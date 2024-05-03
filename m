Return-Path: <linux-kernel+bounces-168089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0B88BB389
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B841C2122A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24131158D6D;
	Fri,  3 May 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVTyk0K9"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F80158866;
	Fri,  3 May 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762528; cv=none; b=uvboQhrFBHclfDGg381inmCv7Fk8TWY6MaxNqD2w3xsHqX//X0MIf4nqzeVv5VSND5NHd/rNgSVj5YH+xRDCo9vxuypfKrAtn2mjolAicartDD5ZUVSsECbPJQRsjddBULJ3Ccg2+duNRflJz8ZwGBgLPcFzqEPRZzeSZLtmYDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762528; c=relaxed/simple;
	bh=3kNvXvkN6naoI7GD4sRzPfHePGAYfimaGj1maVSZXX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n39keNSxWathnJqj+9sIs/Kxw1mT40+LLdc3W0rony+4HDn+fFLJ0O54WvEVzi3kHIhC6PLsQAAOQPcO1cGQRHzvJYrAwDHKTonhv1UBrrdwFQXgwFSdcBuPwj4h2yF8VIJWpBGPTHmt2mPgih+z6AdUFFE95VtefyNHtTh4e1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVTyk0K9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a58fbbcd77aso979970966b.2;
        Fri, 03 May 2024 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714762525; x=1715367325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4JYeUr0dOQRMVbNboqjhvtximVshCSVg7z47+X+6e4=;
        b=MVTyk0K9YKRJnNRt4LbI+yOG4ZfSCOfWz4rBaSd3G4Uuo5vNDRb2OIeC4cmq0v/Sud
         KsGqjtTMMNp+w7w4iS1tWm65SoKo7fdubbO98zmekxIUcpgT9Wbm9I4a3b2yGvk9/yHF
         g1b21dCp84+oWkY2ReQkUsryHvutIlJPN+eo1lYA/8jLKh9RUQaTTLTIkU6BgYynotTD
         W18d8jjn1Ae3NTspF1HFmaSrwxO9q8tnjcIPl+XC/lBsp9IoKDW0mJrzh/xCfJI63X3v
         LZk9nUDxoi7DKTJgkAsQnxY8bTJjSElbk+VlXM36YEPIeppVHNm4ea9FBF0sT0KX0hox
         lV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714762525; x=1715367325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4JYeUr0dOQRMVbNboqjhvtximVshCSVg7z47+X+6e4=;
        b=V1cUdGfV67tclrIBWA6926lwwMfxIijqTfzdRxPM9DW/uy2SnAzfLiv9JYvio/K5wA
         aUqDZ4x8M420tb2iu+9nvJgb7JFi5KLznxr2wAVgqRpdzne0IkWNQwqoq/Q2o2A82+wq
         Ejzln9uXnqhrepRGQqD4r4o2zytJSbjnydr7UmPY9HxxR/Ccdpj1oUAu0lg2HPNUf7gz
         vg7xC89KomlQM8sgvp4DYbp4WBGxbffKvHIfNfhmyxiwHMwvh1vGDzVyHIaUDr3G9Rg7
         lyObSTlL8WHVKVfITEvBKU1Dc6YUkWSjrDtmkrwYJwaOp8H4WoD58Kd3kpachKrHrlzq
         uezQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT4DxeCbg8zjeD1MIY+e1XkM3VJb9R+Vj4+gFnrFnohcE1cN+sH7dG6RtA4SSdXw9M7tmtnfQ0yHkiGY3GtARNbCZs/hrPZX4NW1rnsC6PfUO+FcuMF1u/Ksm6BNSe0r3ENVHtuWUgqcwc//hGr+I6O7S22Sl7GjwNJ2rA6TFRlBeTFv5KPR4R7qNImOhup+6S3nTSlnFpiOYzqxlQquABb4dVH/tzdYQ=
X-Gm-Message-State: AOJu0YybgpPZzDsZ8nOzYEgpsUpcI1l0hm4QwWombXPuefdHFhapRdxR
	3J5lhkX0AepMoV7C440LgSSuGaTU7viRD5pgJWAZq+0x9qJy5Mhe
X-Google-Smtp-Source: AGHT+IGl6b9e2HFGYnhoAnaljhI1GQ0PiFI5MbCO2zuMHmb1huwM89XxkBc/QIEubt+jlSDtr2i80w==
X-Received: by 2002:a17:906:fc20:b0:a55:b487:5676 with SMTP id ov32-20020a170906fc2000b00a55b4875676mr2228045ejb.72.1714762525087;
        Fri, 03 May 2024 11:55:25 -0700 (PDT)
Received: from hex.my.domain (83.25.185.84.ipv4.supernova.orange.pl. [83.25.185.84])
        by smtp.gmail.com with ESMTPSA id l8-20020a170906078800b00a598d3ddf8dsm1104618ejc.28.2024.05.03.11.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:55:24 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 03 May 2024 20:55:13 +0200
Subject: [PATCH 3/3] ARM: dts: samsung: exynos4212-tab3: Fix headset mic,
 add jack detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-midas-wm1811-gpio-jack-v1-3-e8cddbd67cbf@gmail.com>
References: <20240503-midas-wm1811-gpio-jack-v1-0-e8cddbd67cbf@gmail.com>
In-Reply-To: <20240503-midas-wm1811-gpio-jack-v1-0-e8cddbd67cbf@gmail.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714762519; l=2229;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=3kNvXvkN6naoI7GD4sRzPfHePGAYfimaGj1maVSZXX8=;
 b=agat+hgkRN9DNTowBNeEtXOd2WrfzFQ9JevjJtvYwfVfxYh/0eH8GkWG0msG//Zw21Hq4/csU
 Qr4xAZ+ecQdCWUpolpGSUoMlA8eRC4nR1P0KeIVHHJ6gqm3OzlAOxIG
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add the necessary properties to the samsung,midas-audio node to allow
for headset jack detection, set up the mic bias regulator GPIO and fix
some other small issues with the sound setup.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index e5254e32aa8f..a059857e3054 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -285,6 +285,8 @@ mic_bias_reg: voltage-regulator-4 {
 		regulator-name = "MICBIAS_LDO_2.8V";
 		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
+		gpio = <&gpm0 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	submic_bias_reg: voltage-regulator-5 {
@@ -297,8 +299,17 @@ submic_bias_reg: voltage-regulator-5 {
 	sound: sound {
 		compatible = "samsung,midas-audio";
 		model = "TAB3";
+
 		mic-bias-supply = <&mic_bias_reg>;
 		submic-bias-supply = <&submic_bias_reg>;
+		lineout-sel-gpios = <&gpj1 2 GPIO_ACTIVE_HIGH>;
+
+		headset-detect-gpios = <&gpx0 4 GPIO_ACTIVE_LOW>;
+		headset-key-gpios = <&gpx3 6 GPIO_ACTIVE_LOW>;
+		headset-4pole-threshold-microvolt = <710 2000>;
+		headset-button-threshold-microvolt = <0 130 260>;
+		io-channel-names = "headset-detect";
+		io-channels = <&adc 0>;
 
 		audio-routing = "HP", "HPOUT1L",
 				"HP", "HPOUT1R",
@@ -345,6 +356,11 @@ wlan_pwrseq: sdhci3-pwrseq {
 	};
 };
 
+&adc {
+	vdd-supply = <&ldo3_reg>;
+	status = "okay";
+};
+
 &bus_acp {
 	devfreq = <&bus_dmc>;
 	status = "okay";
@@ -505,12 +521,11 @@ &i2c_4 {
 	wm1811: audio-codec@1a {
 		compatible = "wlf,wm1811";
 		reg = <0x1a>;
-		clocks = <&pmu_system_controller 0>;
-		clock-names = "MCLK1";
+		clocks = <&pmu_system_controller 0>,
+			 <&s5m8767_osc S2MPS11_CLK_BT>;
+		clock-names = "MCLK1", "MCLK2";
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		interrupt-parent = <&gpx3>;
-		interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
 
 		gpio-controller;
 		#gpio-cells = <2>;

-- 
2.45.0


