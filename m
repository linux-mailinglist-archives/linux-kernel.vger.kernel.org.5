Return-Path: <linux-kernel+bounces-84934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0CB86ADE5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EA21F23349
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D6915AACE;
	Wed, 28 Feb 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6XguaeT"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E013B2A1;
	Wed, 28 Feb 2024 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120270; cv=none; b=C3rR5vP2ocdcoOPG0nym7yxIcNFhFt5WGJYoRhND+O731HyTopaiyxCyj5ZfXlvfKbc+Q/P4F7JX/r+d4P2MbgA5zndUT58BHjSb/+pjARXtNW5TzsdVfhoSQMzYOChyEI534z+pyhQwT94UomtJ/3WvFB3oGhrO7TCqG7HHDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120270; c=relaxed/simple;
	bh=FEijyJYWtEmQVABgrDhnznqkp29AKzk0XPKscgxFVJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpJgct4mSidEIpEYz6E/NJUOwSycYGpqj8Xw9yxaTu4pHCkKLhNCA3Fhvhn1CLFYEk/HSFwWs5bDZje6nHBqx6HACyz/DtWVHYMs1gmxeJlCjrjT85aNRB+zTT8o28W0i+UiwSmJP9upGDDgLy+9FOOV8TABuOigBu4HhzirsLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6XguaeT; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c76a566218so252334739f.2;
        Wed, 28 Feb 2024 03:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709120268; x=1709725068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjHmD27Zn5f9qcl1J3ud5c045eXb4S8qmKaQOkxlviQ=;
        b=j6XguaeTTJOiZprBhDVlf0H95lsB51wM/mk1kYdOkq4mBD7xuvQaiqolB+pWAFdHTJ
         UM1ppmdefH6fLGh9QircW8qZ1ShoID0f87V32lo0UzgN8qOcUxv0XQcA4VnKq+j7lqWe
         AlOkHjvhWpB8UGEZLsbc6iTaeiQgF2jv/aHtaHBRGld7Q+hXbAuG8bOpZKX0sV+3NdVZ
         Yk9H8yyZVCKMyMZaYVemtQK37ciP8Sp39PF6YzHKeMVIN+ZcKoZAlt/XbIAGbc4peezW
         YemQQa6OMKEzMjyEb05emUecYKcopC0TRTg4FKmGoYGESQBNtaZavit5yuj7AGCCHjw7
         JKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709120268; x=1709725068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjHmD27Zn5f9qcl1J3ud5c045eXb4S8qmKaQOkxlviQ=;
        b=a8ffAIH02DBNf83S9jLbzj/hyed81A9aQp54todzF6GgdeX/+jaNLyewW+yZ3fvKXn
         PcTSxP3GVqCh1oyWowtYEhz2T8DMEkxpm9hW9IVd4u4+aqD1fQeflLRGRhlufR2+MPMp
         vziWPQqmEANqqJkVaQgWIr4fWlvgdcsIFCsnydshTYSjoTs2yTQWnInkWA5jDIOEEG+E
         HJCMEQpS8KEyJ+7ZXcYjH3ctdDiZFgb4xKnFQbZTuZCNT1dWA12xyU1k+S/yW6e0UA7b
         2XmN3EHHkSVTTQo1KkxmS0nE/W5dV5Ihfq43uwsZ9xXJgU7Iyr7QTl9CLkjgOqO9fFm8
         n8bw==
X-Forwarded-Encrypted: i=1; AJvYcCWnvTHxquim+GMVeXVfS7VzWyYZgtciYzcW0LIkgBNhUPGI+v4oYPZHOzszpEry4uB8RVrDrFooamSUZucbkW/FkEr03BSQtHPdTciLg0zWJIsF/GHRy4eafKCZnVS7RlNCucDm8ya1yw==
X-Gm-Message-State: AOJu0YxBYe/fcU/q0wUwjwg6Lb3GMMFhcA1Fy6oPbUft8bvAPdNyyy9H
	Ow4Vjzqzltc7a5HUQUIEruzgkYsqYSCzMHGLoE9UaDJzwzkPShH0
X-Google-Smtp-Source: AGHT+IGw+AwPTdvF2K2zzuaTTuvgEgfn6uZbhI7INlVZj/9AQPcv5DRB1Uszb8mE8Xlc7RpERydtsA==
X-Received: by 2002:a6b:7219:0:b0:7c7:8b50:fedf with SMTP id n25-20020a6b7219000000b007c78b50fedfmr14907652ioc.4.1709120268020;
        Wed, 28 Feb 2024 03:37:48 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:abe6:89f4:1061:8343])
        by smtp.gmail.com with ESMTPSA id k6-20020a02c646000000b004747d876aefsm1833147jan.6.2024.02.28.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:37:47 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mp-beacon-kit: Enable HDMI bridge HPD
Date: Wed, 28 Feb 2024 05:37:36 -0600
Message-ID: <20240228113737.43434-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228113737.43434-1-aford173@gmail.com>
References: <20240228113737.43434-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DSI to HDMI bridge supports hot-plut-detect, but the
driver didn't previously support a shared IRQ GPIO.  With
the driver updated, the interrupt can be added to the bridge.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index 8de4dd268908..d854c94ec997 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -405,6 +405,8 @@ adv_bridge: hdmi@3d {
 		compatible = "adi,adv7535";
 		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
 		reg-names = "main", "cec", "edid", "packet";
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
 		adi,dsi-lanes = <4>;
 		#sound-dai-cells = <0>;
 
-- 
2.43.0


