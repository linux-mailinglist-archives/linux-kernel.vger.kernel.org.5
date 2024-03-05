Return-Path: <linux-kernel+bounces-91468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61438711F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769711F222FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742F9944F;
	Tue,  5 Mar 2024 00:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0dki4a7"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19679D3;
	Tue,  5 Mar 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599753; cv=none; b=UnODY/ejO2q7+nSbNYL/lh3bwC3QwhM9ZgPbOEk/+k1uSq6Px++3B6ow0hoeXB68/2AyFTqS+Qj3TgEDcxck8hH/fSXrKgBNEWQrj/jPl1ovhushpU3h5lg8QNMe/t/VYhVXob8BY0F3s7/EAlPb7c9gPnnCA13aXBo7ZUcaeOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599753; c=relaxed/simple;
	bh=Nyp5c8gmhPF5HW/cBtAcxcJXAGS/CFB5Nd6jStjHljI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoDelb6RTn/uOvlq6zKyqLoxiYa0R3k3ch6LktqedAYq0yH/HiSjAk/WRIAhd7GjtNjCFBQWeajg+wQNkTVR7Elrh/XLcH/9EVQKpkArAjtABVY2wkRoY8SwZbYDKyJnGtbTLH2O48ClG0usc5XDCbmUFXDhXeFJM/uBYSKxw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0dki4a7; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36576b35951so651865ab.3;
        Mon, 04 Mar 2024 16:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709599751; x=1710204551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+BHVxrlI9al90zgfzMAMYGXo6UILvOU2ILHGRC0OBw=;
        b=d0dki4a7wItXLj6mMmlWEmi6YuIwnYB76Xum9teJn0GWbxHZgOPxFzjGvWwwZ8mvsv
         BJKH7gYA6+ml7OfbFjZK5tuQgp/ClJl8Pun3ON1i+kpQB+VqCyH6PIjJAKM0wN2oC+YI
         zySNaLvsSQCp6I2O69UsYjWRfGhpMwqUBb5NhqYXCWdSzCUsncUAAK8RQqrlsY6u6bVS
         rGlN3TGD+aLx1o5tY5EeJ5R+DDwc0hH0STc4ydxGM0CUyqBkE0gUJUFpaOyCCCiqNxOZ
         2qEm5ASzZGw8ZE0lbpgHLmvUxg8IhHelkmmWTKemNcBRHyUMvUefp1HZK8axb5Cpl1sm
         YZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599751; x=1710204551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+BHVxrlI9al90zgfzMAMYGXo6UILvOU2ILHGRC0OBw=;
        b=CLDlJcMPKjRiKG2mo6nYA4ipTtsrY043xqd2n6VJGsn2PK8AFkftdfY0hNGXHBBqoH
         iBxRgzkyReQ0nkqrIuBQVtPfT0CDy5sk6t/vUpigvZOmh5IgJZPLRAIKnfM+78APg/Jr
         f0xS2pKT42gDpiRvLBRhEskTRA5fVX5s+mCvZHYfurUTdjsgrLl3yz6U1YuCI2g/W0gj
         rxsV2kLMLWzG9NcFa47+7WVWapDKB6bZ4Y8E3SszOXDS08xyjHzeVzjA2nhiSXi6zZu/
         f0ChV1GhLRcp1iDLJJ/Kf7pMu4fuS1J2y8NtnGvShBojj/nA072qvDOKecNb5XWc2TaH
         1Nsg==
X-Forwarded-Encrypted: i=1; AJvYcCVNG6pY2s3p/NjHiJ1SQ56zFMpKYBT0WzC8IsSbQLmEz6eD9lfLUKAei5E4BS+GySy02TIUuoDqcokuM8RUfh0Co7Smg7wml7/yFTxuupeCix/vgm84/zdoMCv9/+1DluwcIyOZvBHP+w==
X-Gm-Message-State: AOJu0Ywv0okzGisDRl63RMkuSABVU23+FVDzCcd69aZUgrRbR+aBVgLZ
	bR5Mo/pm9l8lGyytmnPO0CzBRoAQ/gMt4ONmJPo9106+0xma8nJKB3mOmy96iyFdDw==
X-Google-Smtp-Source: AGHT+IFcwi9gaoZxVBmlUA/f4yh+4E16WuLN4gryhMWjZuOM6lWeIU9uwmOYkkJrmY/3PWsDYKmleQ==
X-Received: by 2002:a05:6e02:1c24:b0:365:1555:9fe1 with SMTP id m4-20020a056e021c2400b0036515559fe1mr15026004ilh.1.1709599751378;
        Mon, 04 Mar 2024 16:49:11 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:8c4f:ad40:e7e2:538])
        by smtp.gmail.com with ESMTPSA id i20-20020a02cc54000000b00474d40f8381sm1931209jaq.122.2024.03.04.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:49:10 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com,
	laurent.pinchart@ideasonboard.com,
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] arm64: dts: imx8mp-beacon-kit: Enable HDMI bridge HPD
Date: Mon,  4 Mar 2024 18:48:58 -0600
Message-ID: <20240305004859.201085-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305004859.201085-1-aford173@gmail.com>
References: <20240305004859.201085-1-aford173@gmail.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
V2:  No Change

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index a08057410bde..fba8fd04398d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -304,6 +304,8 @@ adv_bridge: hdmi@3d {
 		compatible = "adi,adv7535";
 		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
 		reg-names = "main", "cec", "edid", "packet";
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
 		adi,dsi-lanes = <4>;
 		#sound-dai-cells = <0>;
 
-- 
2.43.0


