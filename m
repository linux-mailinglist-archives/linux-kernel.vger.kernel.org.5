Return-Path: <linux-kernel+bounces-37651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B2883B310
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01181B24BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430181353F0;
	Wed, 24 Jan 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzsdiqP1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3ED1353E0;
	Wed, 24 Jan 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128243; cv=none; b=dPCkaKWdbGkpOE5Ve2LwQeoPYZhvvzdS/MrSaVpcMHxhHNRReaTtTjuxaDXoRtnzEt/6AMgKhqp19QIQkxhGX3BGfMTl3Q2sIq/mm+fHuKI+UgYgF/ZQzIOuhXDgDEw0Plem3P+gcWGcnL5s9zpkyp7CevdhCZ/EahOQSvdu6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128243; c=relaxed/simple;
	bh=u4l0RsRj4668NcOaxKO+LZ3qtMcTAwoAKZZ3yHzWIOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ks3IKjQKKralvwLpKXW/FY+Znjal9TEyStLZBPTaireXdxws+3huKCiqAN+cMeVreGAJYslyyZF0ZAJhun6xHBdDPt1cAcmiK712mkxKZetUNXGYxeytJQ6iMzf405nIf6XTXKR1OGHWql3k1qMKSFzHIAsasciEEydQxlo6M9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzsdiqP1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e80046264so74403935e9.0;
        Wed, 24 Jan 2024 12:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706128240; x=1706733040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltvCgfghB12MtrfTdUe+z12yA+jwvK0290cBhszdhKI=;
        b=hzsdiqP1YI/5/jCP1yyUxoKHQAKbL2yOzvReS+fhDPRf/yQji1HFhg/reVtoErrCYE
         TO9BgozsFb3BQ74MZFuO1z378h2py5csHy+h9z/9gtmxEz2671p6vqLDEZRQfhpIcASv
         g0z5IENbwNZorCD6kzA0Xcprd7LHXZgLWs8Xcp6g8GyuMMHbVMkZogOcoLZ8qS3/Typo
         gWftR8Mm5NZlbY3p47Uuoj9TwZrRY39TwSIeP6Bgpbilq4FZEsKxlbyvD/DFNh7syiwC
         zpsvC0dizjB+6gLXIbjP1O4Z4Z94hWXDdqvu4Lc0lskhwB9KEymNPHcboz8W4EGMLjpQ
         xZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706128240; x=1706733040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltvCgfghB12MtrfTdUe+z12yA+jwvK0290cBhszdhKI=;
        b=DoI73Qg0VK896zVQLvg2WjlSEjbkwFkNnjch/5MbuzNiYGorCSakCk6fqYES30BWLn
         4uhEn+ZAJLDxnjzS3ndubuKviDC6Ku6h3PvjnYBQorThiPoEehXIJUfj2ZAcxmxCUIfR
         vztp1sWEbVQPcgmli7vmp3Klx4TkJCKmdOdV/pvcbpiCht7izmfN90dRcnjkOhfxs4Ni
         dVmWzj0PEGpbdvrh5HVqPZEfdNIyJ2KCUingJqHhwlUI8Kt/QaHXwX8SI+xDuA44nldO
         AKhX8lORv1HPicrlwGnTA+hPaa88WfKGO9Pq5wfabAmpink2jtD4KgN1n5N3jD7kTv3V
         Ereg==
X-Gm-Message-State: AOJu0YzyZwTcQW3LHv2k5ptoovgK4Aa+BGt7rBd+zEiCyUKg+/LlTRmd
	b+EzXsA9frpv7Tm8SP7DePbvMk3QOgwOHbMqwWAKCwA90zG43jsN
X-Google-Smtp-Source: AGHT+IHZ/0Ki0OXu+Hh6+p5Oxqj8EWS6Ev7/qQSl6UWO72S02kfAs0Y0JWc+Idiposijy8URFA4EYg==
X-Received: by 2002:a05:600c:4f0e:b0:40e:66ee:2ba3 with SMTP id l14-20020a05600c4f0e00b0040e66ee2ba3mr1566084wmq.29.1706128240034;
        Wed, 24 Jan 2024 12:30:40 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b0040d62f89381sm174073wmo.35.2024.01.24.12.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 12:30:39 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 25 Jan 2024 00:30:06 +0400
Subject: [PATCH 3/4] arm64: dts: rockchip: enable temperature driven fan
 control on Rock 5B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-rk-dts-additions-v1-3-5879275db36f@gmail.com>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
In-Reply-To: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706128223; l=1551;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=u4l0RsRj4668NcOaxKO+LZ3qtMcTAwoAKZZ3yHzWIOk=;
 b=K97GzVwWsCS1pD9bcfThrRGqutRbFk4tSHd9NZbQ0Ca+7A4u8xqC6RR67X2kmk1+K9HW1Hdqk
 tHPNbAcztwbCANcKaBcaZPMlrOCQljO+X12q73wj75Tqwx/+f/IIn/3
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This enables thermal monitoring on Radxa Rock 5B and links the PWM
fan as an active cooling device managed automatically by the thermal
subsystem, with a target SoC temperature of 55C

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 9b7bf6cec8bd..c4c94e0b6163 100644
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
@@ -180,6 +180,25 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
+&package_thermal {
+	polling-delay = <1000>;
+
+	trips {
+		package_fan: package-fan {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map-fan {
+			trip = <&package_fan>;
+			cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
@@ -738,6 +757,10 @@ regulator-state-mem {
 	};
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";

-- 
2.43.0


