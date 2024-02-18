Return-Path: <linux-kernel+bounces-70191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D7859490
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72BC1F2255A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF37016416;
	Sun, 18 Feb 2024 04:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHQMK6xC"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A23C12E4D;
	Sun, 18 Feb 2024 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708229837; cv=none; b=iG0znPoIp/IFpxJzbU14Vqk3Sc/GXq959DmBjkdgwAk8hCuUQ1A9rklI/9d8hZaeaRXjkzyg0MnuhohXMirHGkr0IPH/HvEi0k5AQU491y7umIYdoboWe19OP5UwVlQJmUGedSS9RLjTN7i5MijIpIcpLCDKJpzxbnzgCAKjeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708229837; c=relaxed/simple;
	bh=jtYwgVL3qszFQzDtGVjomHAA03c+cCm3XUbUkSyOCVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlmoAF33F8NJ1MoNIPOWPcChDJecQv3kxV006wz+Qo/gnCWafPNzP/sYOfVopZmLo5d1/4DFHkAXUkMEjOTo/hmq1CEFf0Jk4dcvwm8e7iiIZbNFq5126fvKd/ahSTybxgfq1G/tVB907wvfdr7P/Usg4CxMotZ4/0X64vE4Mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHQMK6xC; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6818aa07d81so24812236d6.0;
        Sat, 17 Feb 2024 20:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708229834; x=1708834634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4DhMuxys/34mkhk6GaLGZiP3UVmIiKa+UwrnIlKa10=;
        b=UHQMK6xCsosI7qkDK4iKAp7zPlZodzK5gJ2X+u2XHJXic8jJkLoxdqvjPOZBLVjvO1
         Ut6U89moxhUkCgUwbuhHvdYkiSMfNCQdZGh5u5EWpufCkwPcxDorblQdZL5wLmmi4HV6
         enoN/nB7dyiu1CW23Z3SCHGztxHoxRf6g6WVuc/NOSgjXYhoN7a7Gp7gpoZ6oIQMvQG3
         i80fJgEbrwqX+u7C6s/pDMMpxAWs5CGCfC6CoKoFnc2m9CsCCBRQR+aPw4kOuUg3iPBx
         BtFSEvQuKAekKRlx8V7Y4zWjeZgsUFgbZBv+FjVS4n4yBfsEzRxRyUJ9Fcol0jMZMkuj
         rrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708229834; x=1708834634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4DhMuxys/34mkhk6GaLGZiP3UVmIiKa+UwrnIlKa10=;
        b=SK4uwuHvcTy4kNUxJnMS+MtGDDgP38/q0lgnnRiiMFAtRGdWpSAHorB7sJbsniEPoR
         nRSd5F5z60mXeDSCrN1/dxYxcov48/Zh6ZBZqoUi+/LQwuai0ezhbp9qdq12WMspkaxj
         suPWfKU7fiirLMglUxR6Q5/8bm6HVhnzvmxxNS/ETdQsJCEitMR7gRiynFtTpPqGaP8Y
         cCYmQwBLm1XFIZawP4bKeHTtlLpN63DTP0gRUv+3G3pC6L5SBOuNUkNJ1Rh5u4q4+wce
         yiIFRlvdmmv+thFraoxqw93KKzVHkde3mU88S8yjvfS5wHLQlAYoJ7z2TDMRHgbSpOj+
         CtMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcaQ61rUjdZCnC+SIFYp29CpLKPdAuu9Zt0qjxVdvETQqMsPON9tWqdcESWrevJjiPqeMY27H5D/JSWhrAwmXybPQvu0ITLiKxT+LHuTgX3t6VXvTOXtrZYasjbEBfiPDk7upwlO2Hqg==
X-Gm-Message-State: AOJu0YzvGKJjo2WMaSi69nzVWXuXRgFlI+LwGpS8pKc0LCu8D3NnCa50
	kOHdeymYUU7lVMhc+qjIxrxdXs9GrRo665O+Iav/1cXnRdkX9Fn6
X-Google-Smtp-Source: AGHT+IFMXYUm3DAGvhHMCJf8i+alS/1f7k2sbGdjsuXsPkCamXEfPAlsCaqOCoDWJRS6fbld8/LKrw==
X-Received: by 2002:a0c:df0d:0:b0:68d:124:4354 with SMTP id g13-20020a0cdf0d000000b0068d01244354mr11175451qvl.49.1708229834543;
        Sat, 17 Feb 2024 20:17:14 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:dde9:2f2d:61e4:7364])
        by smtp.gmail.com with ESMTPSA id or31-20020a056214469f00b0068eeebc4656sm1713621qvb.139.2024.02.17.20.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 20:17:14 -0800 (PST)
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
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 6/6] arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
Date: Sat, 17 Feb 2024 22:16:44 -0600
Message-ID: <20240218041649.1209173-7-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218041649.1209173-1-aford173@gmail.com>
References: <20240218041649.1209173-1-aford173@gmail.com>
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
V5:  Added Review and tested-by from Luca
     No functional change since V1
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b8adb28185ad..ccfd5e6f20eb 100644
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


