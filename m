Return-Path: <linux-kernel+bounces-87348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C6186D322
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F39286538
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31613C9DF;
	Thu, 29 Feb 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YINBMM7e"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC713F451;
	Thu, 29 Feb 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234830; cv=none; b=HTRALhdKe4XcKz0LKRFZDmSu5ijc+22YJXqItYmAImA+cQC71aC8nxN2NPGmn4yQuEgE2H+kXnbAzmVo6+WvvHNpeodb/ty+7yx6/W66uxYKVmjcUuTtmQ2Pd0//qrpSDJWkxGfbzn9xj6pjqYglJJM8Eiwerfzex0euCcR+UCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234830; c=relaxed/simple;
	bh=Ho/8fTxDDk0oY+T8PDaCqjRH1MRLd78jPjHkNM1Fiy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wy3HeXt6Q+sqOlWscjojgrFYL0qbylMs2yGhn0+MG3zkfy8ubq7hzd8rTnQu15PTElVy71IS5Umuf7n319ETZSVoJPj8eVDopQoEX3xlLXHzQqhovJiw/JqHCsAjLkzw6Xsk/63xMuAlMNL2ac1f0dDYG0VN2yMGHqMrsqS7gY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YINBMM7e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412c3f4c6b9so1423435e9.0;
        Thu, 29 Feb 2024 11:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709234826; x=1709839626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjF+Nm70GZV3EV5zT61+vVH9aCxdPSz8FYjQv588FDY=;
        b=YINBMM7ezcjghQnAl/Y+IfS+YuFLmsH/lnL0ox8SsqIKsHTdoaAQRFIHFJ+59Hqic3
         jvPp5ujB6x18uLG9x15ysEIqkyTqjioogJDGlEoxEh0WZsxDJkuALvusDD1DFYpHd+iY
         uAYEKU7oXy50MfhkX3PEm4PCgLRUJneR0zJYST3InCy86S2hCjryk0WcjRcJLhmUFfYB
         P7VLnldzXuiept1bE8JYD77Sc1NNHSx88G0i2nk+yvpjVkvF1VCpWQwq1FOmSlCcIug2
         A8lWExRyM+7+H8XDo0pp8Qm0MkgVKIQRAdd2P4qCkRDq1xaRSAPvPxVTIBCbNVr67vTv
         qirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234826; x=1709839626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjF+Nm70GZV3EV5zT61+vVH9aCxdPSz8FYjQv588FDY=;
        b=eSQYoeH4iMpdNKWCHE1qsIAnTu43VjZHyNMEIaTr5uVP/mi+rIeVt71yr3FFYxAL5Y
         dA4J3P50xQDkjMSBSU937jao9/XDmX1BfEtz1kd9BhJeQIJIhsRq63McSnBEy9tWwogF
         HZBjUxKoU02aOm+3veJw9I2/wUPhJHTCB1mIgUh5MlxQ2Lw05zppNpl7fvljY7zOILvw
         sazUXA+WSjiTWIXxUpIAV5OQRr3LuqSlHKeE4ZqOU4XaotIvxE1R1UNP33KIg8oTuqck
         lAtSB03SxmGPVVo4Na+w5jq00TIW4FLeDc3HO74y3C4eCCL0QPGXJxZKq93t7p1HIDeF
         FmjA==
X-Forwarded-Encrypted: i=1; AJvYcCVc16DCt5ANt8vorY3zyWTQ54yrj09fda05nBbZMhBBGBYDzW/DgwyklxW0+a2t7T41NYKyvSK3RpOYukhAca3ozM4P+XfbLEZlajT9HDnx2qfhFjoMc45Ae20O3A3bUx++AKgGkwLdTA==
X-Gm-Message-State: AOJu0Yy+2P2/uzDJnpwuprCycfjN3GzHsDThbajcDjAkp5omTBrFWZeP
	wDaNcT4QjTW2EzJzqpXe/a6LfbDznGG9sQW+eXEPSHbkx95E24S1Rhn59V0hpGZKYQ==
X-Google-Smtp-Source: AGHT+IE5LYJ+eH6qEYpCvW2Ade7RBhtp9koyNGFhLwrJlvKvIsvwEIqIjhWPVd3V+qWr7oNTqvsdJw==
X-Received: by 2002:a05:600c:4fcc:b0:412:c1d4:995f with SMTP id o12-20020a05600c4fcc00b00412c1d4995fmr622wmq.13.1709234826323;
        Thu, 29 Feb 2024 11:27:06 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:6ebc::d35])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b00412bca49a5bsm2853944wms.42.2024.02.29.11.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:27:06 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 29 Feb 2024 23:26:33 +0400
Subject: [PATCH v3 2/5] arm64: dts: rockchip: enable automatic active
 cooling on Rock 5B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-rk-dts-additions-v3-2-6afe8473a631@gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
In-Reply-To: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709234816; l=1646;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=Ho/8fTxDDk0oY+T8PDaCqjRH1MRLd78jPjHkNM1Fiy8=;
 b=9He9zzAzOU9/Q78jwrKCrcpeg4Gshhw2MArhwDVEmmq1HYUzqs/CKJUbr0yRGn7xFOFd0mBCN
 JLwCXW4gkE3BpRCQQ0vWCiuoNuc0WT6D/kJPiQwMDD95/m5GOi347qA
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This links the PWM fan on Radxa Rock 5B as an active cooling device
managed automatically by the thermal subsystem, with a target SoC
temperature of 65C and a minimum-spin interval from 55C to 65C to
ensure airflow when the system gets warm

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 30 ++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index a0e303c3a1dc..3f7fb055c4dc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -52,7 +52,7 @@ led_rgb_b {
 
 	fan: pwm-fan {
 		compatible = "pwm-fan";
-		cooling-levels = <0 95 145 195 255>;
+		cooling-levels = <0 120 150 180 210 240 255>;
 		fan-supply = <&vcc5v0_sys>;
 		pwms = <&pwm1 0 50000 0>;
 		#cooling-cells = <2>;
@@ -173,6 +173,34 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
+&package_thermal {
+	polling-delay = <1000>;
+
+	trips {
+		package_fan0: package-fan0 {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+		package_fan1: package-fan1 {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+		map2 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;

-- 
2.44.0


