Return-Path: <linux-kernel+bounces-107798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718A08801CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A562860DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FF85925;
	Tue, 19 Mar 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuGLQSqX"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB068529D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864839; cv=none; b=A6XLqx9EnTNy6YorTK6HPZigtv9cLUSGn+lieaY5yDuTZZi52/bqQ9jh3ZDyOzVlD84YdjDhTORfvLrzd1Ylv1xY3cBhBMuz++P2SRNR9gsKZ5Uc2dgVhZQOdLCqG5874caQoYS4aXMszMv5igbbUvqunNAy/XTqg50pudpYa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864839; c=relaxed/simple;
	bh=EYOEa0uVYp0vYfKNVrRpWVnmRsG7n3juvC+eylZ7ENw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SbCTDWaSfQHEvoShPIEnvEuf7GVin519a0g1uio2PcnEw70s5PXEplxgI3hsFxJAw2nSKN1TCYuufWf3ppxX7hi1/tKofOiM7w/ZPl358fhRse0Ks7rHGb5/jmQnTUO0LElDFLqQTXkjFx2+podAuCz4i3wxPjGMxSaGtI1Gih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UuGLQSqX; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513d599dbabso6581103e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864835; x=1711469635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yshrbrRqv1mNDaYKhbz7spWFrVefLfnoM8iQyT0aqAU=;
        b=UuGLQSqXAizr4l8yW1/RlwbtYJNOst9EgJk8//4UOVTgsliHm7e5Awf4lDpgRHAg14
         5i3FZZKpT4k7HUumnCDUnZR17BTHb75t30catZhNQR/O5vhsVP8yLv4zs+hKckfuCAgV
         omhj2zADnxkuxHLq38deHEyyfeusSgf+r/IoTzqd0bjeo+RrIzi1QflGdWxAimPbmupN
         1Op/tJlqEx6LaH5LCu43nsnfAyrF4eQIWAurKjKBBVSjTmWVh/80Zo8lla/rraCnwUya
         hGpjhERGzomL4g1OZT1sORwqcJPeDl/U1V3L9YMKAt997VpMqVP7/fM3k9eHmo1ZWelU
         ehpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864835; x=1711469635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yshrbrRqv1mNDaYKhbz7spWFrVefLfnoM8iQyT0aqAU=;
        b=dMlS0qZLnOlKKLdR0zGEYiREmgM3M7/tWR2yilz8Zmaw3dIl7fK49HkBX++FbWeMpP
         twHimMXVuulR5BJkOmidjdpACMKI6J/JUX7UzXPSAraRTvYV/hVH5WeP+/I4d/2Tt+MQ
         8OGnTXiFwQClpy97GTolz/QHyieg9PdDTv+Mi5NLYD6JYuXjlF4V+d9KY7k44csLJFtj
         TuaN7wtS1a81JZHkA72qkgXENDzUZ58LE9s7YwEZBmJCPC6VQ1OnJ7c+lrPrvz/xooke
         +u9a8fbLzEuypjYz0eigmJxEW7wuNq+sGvW6W7EdEGahBjNoXBvHO/koxsXAuFm72JUh
         rcig==
X-Forwarded-Encrypted: i=1; AJvYcCUj/Vmw7OjtLlrOeTt4IWJBSpIIz0OJS84MWSZUwjzm31ior1cOMweseV0sdW0OpoSyklrA119xgdRLxaoNS6mg3tCo1/e2rmWiwhLg
X-Gm-Message-State: AOJu0YxiaTHZYbphPXReDkB2QEnQlNYLkzRWqEp/B3ZIg/jXMEN3QWgt
	gDI773saIjmWmXX4XD3/niP5H1m0usYVjUykjaF4a078SCrefUlaDmMxpZ/2yzM=
X-Google-Smtp-Source: AGHT+IE5fk5J4YPttQCGqL4rGXiVuyuUObxgdbsNNHCn0IESQPWQF1UUvgMovCGO1tfo7E27XpIThg==
X-Received: by 2002:a05:6512:358c:b0:513:c9f5:cbf2 with SMTP id m12-20020a056512358c00b00513c9f5cbf2mr2266989lfr.59.1710864835674;
        Tue, 19 Mar 2024 09:13:55 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:54 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:46 +0100
Subject: [PATCH 16/31] arm64: dts: qcom: sc7180-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-16-e0aee1dbcd78@linaro.org>
References: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
In-Reply-To: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

All of the thermal zone suppliers are interrupt-driven, remove the
bogus and unnecessary polling that only wastes CPU time.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi               |  2 -
 arch/arm64/boot/dts/qcom/pm6150l.dtsi              |  3 -
 .../arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi |  3 -
 .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi     |  3 -
 .../arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi |  3 -
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  3 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  3 -
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 75 ----------------------
 8 files changed, 95 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 11158c2bd524..78acad023e62 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -12,8 +12,6 @@
 / {
 	thermal-zones {
 		pm6150_thermal: pm6150-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6150_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index d13a1ab7c20b..a20e9b9993b2 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -10,9 +10,6 @@
 / {
 	thermal-zones {
 		pm6150l-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm6150l_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 7765c8f64905..80fa40cdebd5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -24,9 +24,6 @@ adau7002: audio-codec-1 {
 
 	thermal-zones {
 		skin_temp_thermal: skin-temp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm6150_adc_tm 1>;
 			sustainable-power = <965>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index 2ba3bbf3b9ad..385eba9e142d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -44,9 +44,6 @@ pp3300_touch: pp3300-touch-regulator {
 
 	thermal-zones {
 		skin_temp_thermal: skin-temp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm6150_adc_tm 1>;
 			sustainable-power = <965>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index 067813f5f437..026d0845d78b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -14,9 +14,6 @@
 / {
 	thermal-zones {
 		5v-choke-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <250>;
-
 			thermal-sensors = <&pm6150_adc_tm 1>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 305ad127246e..1bf313a3c59c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -49,9 +49,6 @@ v1p8_mipi: v1p8-mipi-regulator {
 
 	thermal-zones {
 		skin_temp_thermal: skin-temp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm6150_adc_tm 1>;
 			sustainable-power = <574>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index f3a6da8b2890..8a8a5ca0e568 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -21,9 +21,6 @@
 / {
 	thermal-zones {
 		charger_thermal: charger-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm6150_adc_tm 0>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 2b481e20ae38..54e0ab1c8580 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -4031,9 +4031,6 @@ lpass_hm: clock-controller@63000000 {
 
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 1>;
 			sustainable-power = <1052>;
 
@@ -4080,9 +4077,6 @@ map1 {
 		};
 
 		cpu1_thermal: cpu1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 2>;
 			sustainable-power = <1052>;
 
@@ -4129,9 +4123,6 @@ map1 {
 		};
 
 		cpu2_thermal: cpu2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 3>;
 			sustainable-power = <1052>;
 
@@ -4178,9 +4169,6 @@ map1 {
 		};
 
 		cpu3_thermal: cpu3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 4>;
 			sustainable-power = <1052>;
 
@@ -4227,9 +4215,6 @@ map1 {
 		};
 
 		cpu4_thermal: cpu4-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 5>;
 			sustainable-power = <1052>;
 
@@ -4276,9 +4261,6 @@ map1 {
 		};
 
 		cpu5_thermal: cpu5-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 6>;
 			sustainable-power = <1052>;
 
@@ -4325,9 +4307,6 @@ map1 {
 		};
 
 		cpu6_thermal: cpu6-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 9>;
 			sustainable-power = <1425>;
 
@@ -4366,9 +4345,6 @@ map1 {
 		};
 
 		cpu7_thermal: cpu7-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 10>;
 			sustainable-power = <1425>;
 
@@ -4407,9 +4383,6 @@ map1 {
 		};
 
 		cpu8_thermal: cpu8-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 11>;
 			sustainable-power = <1425>;
 
@@ -4448,9 +4421,6 @@ map1 {
 		};
 
 		cpu9_thermal: cpu9-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 12>;
 			sustainable-power = <1425>;
 
@@ -4489,9 +4459,6 @@ map1 {
 		};
 
 		aoss0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 0>;
 
 			trips {
@@ -4510,9 +4477,6 @@ aoss0_crit: aoss0-crit {
 		};
 
 		cpuss0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -4530,9 +4494,6 @@ cpuss0_crit: cluster0-crit {
 		};
 
 		cpuss1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -4550,9 +4511,6 @@ cpuss1_crit: cluster0-crit {
 		};
 
 		gpuss0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 13>;
 
 			trips {
@@ -4578,9 +4536,6 @@ map0 {
 		};
 
 		gpuss1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 14>;
 
 			trips {
@@ -4606,9 +4561,6 @@ map0 {
 		};
 
 		aoss1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 0>;
 
 			trips {
@@ -4627,9 +4579,6 @@ aoss1_crit: aoss1-crit {
 		};
 
 		cwlan-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 1>;
 
 			trips {
@@ -4648,9 +4597,6 @@ cwlan_crit: cwlan-crit {
 		};
 
 		audio-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 2>;
 
 			trips {
@@ -4669,9 +4615,6 @@ audio_crit: audio-crit {
 		};
 
 		ddr-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -4690,9 +4633,6 @@ ddr_crit: ddr-crit {
 		};
 
 		q6-hvx-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -4711,9 +4651,6 @@ q6_hvx_crit: q6-hvx-crit {
 		};
 
 		camera-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 5>;
 
 			trips {
@@ -4732,9 +4669,6 @@ camera_crit: camera-crit {
 		};
 
 		mdm-core-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 6>;
 
 			trips {
@@ -4753,9 +4687,6 @@ mdm_crit: mdm-crit {
 		};
 
 		mdm-dsp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
@@ -4774,9 +4705,6 @@ mdm_dsp_crit: mdm-dsp-crit {
 		};
 
 		npu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
@@ -4795,9 +4723,6 @@ npu_crit: npu-crit {
 		};
 
 		video-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 9>;
 
 			trips {

-- 
2.40.1


