Return-Path: <linux-kernel+bounces-107808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3FE8801EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3D4B24338
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78B823DB;
	Tue, 19 Mar 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvv2rGAs"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA1F85936
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864848; cv=none; b=Ww0UwNZYo9eKGlAIaRGugSosBJcaWwDU3Fr01GbPD+shHhQOipPZgR8kgL+TrONdjGtKAtP+CbRYG2cZ1hjFXpuBsuRn4e6h1L24Lq18iByc54jdRHgmO1qVRKzorTftt9nyAwHXp48dfgQ0utlWY8Ww8VSdGaNCaK++0o+ckW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864848; c=relaxed/simple;
	bh=4ryAGqAK+Fc9WQiOXMMu5C5xniMZ51oUjQTqDkBykkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJ4S5NXLHo5xifFkN1Lz6izSciEWauXUw/N2Jlob3IfiJXXQF3QzHUemBw21fslJo+Lj/d7qq4kVBhVGPsz7ZAiYIA6NN5MZde3WNdCB/VzJ1N6/oi2fMmr6GNyrqLdTNvotDwarFS9WQ1b3ZLPrOffdinrjPiv4/NEY7ooK7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bvv2rGAs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513dc99b709so5118829e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864843; x=1711469643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PB20iR2ZLd5oZ38PSb8fZdY49P29stRXGwMP2qRq3s=;
        b=bvv2rGAs9vwryhkR8xNTDxsXGv/ec5u+IHGiV2/p7NuJ5br18HKjPYhXb+CVYdWC8k
         Pv9zUjVWEOJpm0PQXBqTDS1DurbSwC4aMDrRCqSS+WcKmWgwENVGyp01xjnnZNx9BmdH
         k7t7fnz5RwOBG4l1DOxZfbtz4+Co2T524T9HCME1dWGtgwQTbR/2tFKFZgMh0RrXhQUY
         j1OZ1Q54u5jHYn1q5bZ3MXQjZF7LneORxvr3BHFfgngz+3TkqSIzecMJFA3zngsR32sI
         2g+nJl1ZbyRNBLge7jM3CTALXNytb2GcVpguywjR0MV2WdXG6GaYRmNyDFiOnC07Kx2m
         ccNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864843; x=1711469643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PB20iR2ZLd5oZ38PSb8fZdY49P29stRXGwMP2qRq3s=;
        b=lWJoSSK7f6XqheHK17W2VxgpCeJr3Th2JEwqjL3rX9yUF9yPYx+AEGGhRWPTg0/G8r
         Jpq0iODFN72cdUUi5D+Y2z5cy5H+jhCrA0G3XV7MkOSbvqXdnLYVx4Hpkw+j1cbFE5ZI
         viIJNp83RpKeNowYcNYzZVmLidS1dRCI4yg9nHjBU2bYedLslHcDey2qECfrzrzzu7DH
         /f08MK+F8/ca4OUa7FYLZ1XX5nmY/+BMa2N/+RwUPAWV1H5t+SvpG1FRRuQ4GUk61FtO
         wByC3D3PwywXcsRWfwDcPgKKXzyWA2n9A2Agt/V2Q0jU3HeYVQUpg41jwhotSHIOhgEu
         t/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUr1x2ydcf1ehxyQr/kPzNokDvm9GweVynyA/qWtVREXLZG9+S2qFFaEa9tfX03cFgGq9U0eutUlKh4AIupttdYQGgkS2UB0nbpwS50
X-Gm-Message-State: AOJu0Ywcm5D8vki2bCU6fBX6tsfXnZzXuRHoQMW8Ubfu0NbcGLS3Ernj
	dkhJ/pvwqNlx5zwluxphLWUlCJl2Fspz6Pvv1TE3/GekAyVwEE1blVFhpyCIfAA=
X-Google-Smtp-Source: AGHT+IH3bRQUCVmN1BX9wv+eReCSwFOq2pBH7CsQE1yZ1QIXXi7x2ZnCWDJJdrRzAjna6LFGhwiUAg==
X-Received: by 2002:ac2:4474:0:b0:513:c2ba:edaf with SMTP id y20-20020ac24474000000b00513c2baedafmr2053915lfl.20.1710864843696;
        Tue, 19 Mar 2024 09:14:03 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:14:03 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:54 +0100
Subject: [PATCH 24/31] arm64: dts: qcom: sm6350-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-24-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm6350.dtsi              |  3 -
 arch/arm64/boot/dts/qcom/sm6350.dtsi              | 81 -----------------------
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts |  4 --
 3 files changed, 88 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6350.dtsi b/arch/arm64/boot/dts/qcom/pm6350.dtsi
index 3a2a841e83f1..be118da8838b 100644
--- a/arch/arm64/boot/dts/qcom/pm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6350.dtsi
@@ -9,9 +9,6 @@
 / {
 	thermal-zones {
 		pm6350-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm6350_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 24bcec3366ef..da17057028af 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -2712,9 +2712,6 @@ wifi: wifi@18800000 {
 
 	thermal-zones {
 		aoss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 0>;
 
 			trips {
@@ -2727,9 +2724,6 @@ aoss0-crit {
 		};
 
 		aoss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 0>;
 
 			trips {
@@ -2742,9 +2736,6 @@ aoss1-crit {
 		};
 
 		audio-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 2>;
 
 			trips {
@@ -2757,9 +2748,6 @@ audio-crit {
 		};
 
 		camera-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 5>;
 
 			trips {
@@ -2772,9 +2760,6 @@ camera-crit {
 		};
 
 		cpu0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
@@ -2800,9 +2785,6 @@ map0 {
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
@@ -2828,9 +2810,6 @@ map0 {
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
@@ -2856,9 +2835,6 @@ map0 {
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
@@ -2884,9 +2860,6 @@ map0 {
 		};
 
 		cpu4-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
@@ -2912,9 +2885,6 @@ map0 {
 		};
 
 		cpu5-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -2940,9 +2910,6 @@ map0 {
 		};
 
 		cpu6-left-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
@@ -2968,9 +2935,6 @@ map0 {
 		};
 
 		cpu6-right-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
@@ -2996,9 +2960,6 @@ map0 {
 		};
 
 		cpu7-left-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 11>;
 
 			trips {
@@ -3024,9 +2985,6 @@ map0 {
 		};
 
 		cpu7-right-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
@@ -3052,9 +3010,6 @@ map0 {
 		};
 
 		cpuss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -3067,9 +3022,6 @@ cpuss0-crit {
 		};
 
 		cpuss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -3082,9 +3034,6 @@ cpuss1-crit {
 		};
 
 		cwlan-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 1>;
 
 			trips {
@@ -3097,9 +3046,6 @@ cwlan-crit {
 		};
 
 		ddr-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -3112,9 +3058,6 @@ ddr-crit {
 		};
 
 		gpuss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 13>;
 
 			trips {
@@ -3140,9 +3083,6 @@ map0 {
 		};
 
 		gpuss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 14>;
 
 			trips {
@@ -3168,9 +3108,6 @@ map0 {
 		};
 
 		modem-core0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 6>;
 
 			trips {
@@ -3183,9 +3120,6 @@ modem-core0-crit {
 		};
 
 		modem-core1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
@@ -3198,9 +3132,6 @@ modem-core1-crit {
 		};
 
 		modem-scl-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 9>;
 
 			trips {
@@ -3213,9 +3144,6 @@ modem-scl-crit {
 		};
 
 		modem-vec-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
@@ -3228,9 +3156,6 @@ modem-vec-crit {
 		};
 
 		npu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 10>;
 
 			trips {
@@ -3243,9 +3168,6 @@ npu-crit {
 		};
 
 		q6-hvx-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -3258,9 +3180,6 @@ q6-hvx-crit {
 		};
 
 		video-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 11>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index bc67e8c1fe4d..c50fa7f3a5fd 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -94,8 +94,6 @@ memory@efe01000 {
 
 	thermal-zones {
 		chg-skin-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm7250b_adc_tm 0>;
 
 			trips {
@@ -108,8 +106,6 @@ active-config0 {
 		};
 
 		conn-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm7250b_adc_tm 1>;
 
 			trips {

-- 
2.40.1


