Return-Path: <linux-kernel+bounces-82452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45218684BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA421C22880
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA37C137C55;
	Mon, 26 Feb 2024 23:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq3oG8xK"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848501369A7;
	Mon, 26 Feb 2024 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991152; cv=none; b=SE2MsVpnkjdm3POK/AGMe/LQUW2BUr6g/c7xFdCnS3J8G6fNJge+jUaqZrW9JwZAL2EMGzzf1OZ6jw7wwLosKqW82X5YQ2Ad9sc3JfjLkvALxc9QVa8nUjklyRwqfR9fBtGvm5BrMOEwZAEQ0My0Adxfj3iCGno8d4KT4m5vSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991152; c=relaxed/simple;
	bh=dUKQStftk0NCvevS137ee+FAWx6tumN2ZluM+6YIhrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efCnA6uxLP+2m517u3BM/EB+bG/YfXVFbgxWc/jsicmqhD9LNyuoyibMYigdc9ZFei3+zZuqxu3CYE+A4zp4ZHRFBnmoEjAFfL6bERnyJSpujQWdRWHUoZzHHKfc4q+ZLhjiLfbFnlFlbvhuVfp/oS3RU6in1aB0GK9D98AvUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cq3oG8xK; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7beda6a274bso169970839f.2;
        Mon, 26 Feb 2024 15:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708991149; x=1709595949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knPaTIoFneZG5hrVEsT/YmqDcycwgQYY5PSRLonRAH0=;
        b=cq3oG8xKLDNDNPcezTHM94JZwJ/1aqyyYN8YRFOahQD8ggvzjLV+tdVypbdh8YBZVX
         mvxcPR5TJ2lsWcgde4GAD31V5VlBO7htQoSmPmhe4s4v1wSL6LGjlWXDNUiUR2W7nsbo
         69z8U5rRfCcpUIjaKviuPakMWtMJBPyfPYHfnAwQuTEFvESE4e0usyD7pxk+5W2qH6IF
         CsySnuJbzPFnUCg/j/a8ZWlZrJ+m7fs9c+1t/RH6g+EwCjgNtN0R9FCMsITwQtjW/LqP
         RCmMnQn8zL+crIYb6O7LXK7BfJidRZegKpSQDbXsgsfAiseRfLKN9sIPl/syJJrysChd
         3sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991149; x=1709595949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knPaTIoFneZG5hrVEsT/YmqDcycwgQYY5PSRLonRAH0=;
        b=SncdmAiWAhlamNBU5AZZ0636iJORQz+K+LLPp8wzgcNZxCKcw613VPqnR8mT+mAYkP
         N/C5fo9sKQ+u8C6baGDTMyfth7+2PNxjez4FI+j47Xgtnc/y2LbPuRHQA5ONBK/YYt7l
         YZT1bWMls7UCpSIQsLr44zUdUvuY6g0GcvsnHl1nEYf75npLcZm/jJSi6B3l5W8wB24I
         ljY64shBLGdN2R+bXl/3+7qO9Bm1ZxuCSDXvFAC/aUZ9wjL1zDAn+o6ToU28aSP4Hc47
         n31aF0/OvqeYeOTb3LDLezYuyCjR7JiM7Y6JzcnngRp6Px6bXcJDsZLdSpp0mXQJ0Muq
         Xsvw==
X-Forwarded-Encrypted: i=1; AJvYcCWLQyCsohZKkRPrKL6L1VLX6NTk5//tdldlAL1mfCKJDaBeCwu9kuCJGyaPUIFVDGAmM1PLNy8EyDnYNXkrmIVEg0VDqsoRPDzQowpVKebwLXD+0KUu6leurf1OtUlW6w0ZLYzxFYaKkw==
X-Gm-Message-State: AOJu0YyUg0fTEvWy3rv81n9fGQKbqPkzKz/0tGfzyzAew1WlXGf+C34N
	cDil9dZBVwODyNJefQAfFDn7JYMfQa9yu0TvN5do3a4aVRgeD798
X-Google-Smtp-Source: AGHT+IHGXdeE0h7LKc2vsghd3XmTbOAHJo4wOu7BDYc0A1aaAW0t4XuHxS/AkRYcn3LhNnYqHf+PQQ==
X-Received: by 2002:a5d:91cd:0:b0:7c7:97c2:f04f with SMTP id k13-20020a5d91cd000000b007c797c2f04fmr10088960ior.8.1708991149640;
        Mon, 26 Feb 2024 15:45:49 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9c95:d061:819a:2ab2])
        by smtp.gmail.com with ESMTPSA id c25-20020a023319000000b004741cf1e95esm1545317jae.11.2024.02.26.15.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 15:45:49 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 6/6] arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
Date: Mon, 26 Feb 2024 17:45:17 -0600
Message-ID: <20240226234532.80114-7-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226234532.80114-1-aford173@gmail.com>
References: <20240226234532.80114-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8M Plus has support for an HDMI transmitter.  The
video is genereated by lcdif3, routed to the hdmi parallel
video interface, then fed to a DW HDMI bridge to support
up to 4K video output.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
V6:  No Change

V5:  Added Review and tested-by from Luca
     No functional change since V1
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34681284043f..ee644d27652b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -887,6 +887,7 @@ CONFIG_DRM_ANALOGIX_ANX7625=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_CDNS_MHDP8546=m
+CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE=m
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=m
 CONFIG_DRM_IMX_DCSS=m
-- 
2.43.0


