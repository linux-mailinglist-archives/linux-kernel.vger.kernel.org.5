Return-Path: <linux-kernel+bounces-107800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9E28801D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3624CB2487A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C5B8593E;
	Tue, 19 Mar 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erW6ab4R"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF578563C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864840; cv=none; b=B+b+MuckJ79nJnp/K7i6WAkkW505ewjODyFqFnW3K7c0Yk1u3irz1brSAnyK0b4Ua7UPj6v4VMmRMo0YJtBfOeEeWveQ7w6iCkpIkR3vnb2xiUyiDJ7fuRXvwUQ2WucxirbLnE7s+ulUyBmfmtsjJW1LCb9eFiWBNzOTT7fbnRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864840; c=relaxed/simple;
	bh=r63AdtT4GVZ7zZXIKR+NEiJ7S/HPxGoyuJWtUf4y+jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DRou26p1zUr2HGH3Q97u5yOjQqidpTqRUGK4QChCjiTcI7hdyTb3lPGyKcZdMdw2iFmIk+xL1ra3Lt9V47oka6LdFXcoJ2CF4otoy/ki167IKxUyVzFsbPtjmQ6DK4GAyDMeS9FRPGM5D4v+umFoIZGjKJYFHTFM52v/g4bxToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=erW6ab4R; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513d4559fb4so6996419e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864837; x=1711469637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB3PcUCPufS9ZcD95Yf/HAHsA+W7OOJ/3I2gdHjfGlc=;
        b=erW6ab4RAhNstlH+7diaZgjlQdI3nlQnmDaHn6987NWEbUfDnA1yPplfKBwsI+yymW
         XLBB0p1pVEZ92B84Ne7l97MoLuUVW9Lw9utWSseuUxUwFaPaBZ5wdPbYluMxDdpFFReE
         +aRBQ/9kMaSOF912XjvHOqp6VYbmkljqELGNNgnDW8VGqODh4ihY0L9ogVITZ8Ibx1AM
         az+ap7TB/BvcNDmiWLIeVrVrbyHtHfTfg/NRHcECdJnvFqNWMDkvE75kcXJD+lr4kbr/
         PTp0qOXv3PNNj4W5O/wPc2z6SPRk+fZKdLlndY8rOSojxxZTFvN2/f0HJ4TjCgIlmUeh
         8gQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864837; x=1711469637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OB3PcUCPufS9ZcD95Yf/HAHsA+W7OOJ/3I2gdHjfGlc=;
        b=kffjQsMDWLAt0JjmV9ij29s6579o/6TB44hssFX0WLBMkh/qKJ9jq71LjDJeJiHiGa
         m3MC/0jbi59LD/0C2XjJWJhr5R1dtqxkygQ82SGIKJBkttoeAQp0YA4jm2bTLvmE07Bv
         aMPOGpibc9xE3PCaefaTNtfWQd1JWVcGBmSqpWMichHj24kZ/KaXHjYWgsG4zOmUGbX/
         TBM5aIEvBt8bN4xO3NsULNGKw1k9DnQT7tYwyvTq2+6T6o7ajCeapyakwRRYcz5pOhy6
         RQX4hmwCroluhqc3CWlCQzRgikZO28SI7FhERtxzcLPgSVtp248QNWqTQ+G/KExdMNWr
         FxsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUJgAkhlLstm0uNCaRmJ9AdNH48KqsljIXl6RH6YPWFI7gToIyI6VXm4KJ1XMs3LaNo+rfTzyGXOqVUWm8/yg3+ZVcBHsASkjW2Xim
X-Gm-Message-State: AOJu0YxLt1WJ+Ed4MsbowkuYVNuMigKmmoZWvnJup0l2nf5V6cgYrwed
	qUwPKnsct3obtD7+hkIh67COUgf7cNjh4TKKciH7z3sc7AXVpRVsY2XTIP+I7Ck=
X-Google-Smtp-Source: AGHT+IH53t86LWw3WY/febzezecdPoEWe/w9djLV1EKb/35WONffId6x0wGKP1w9qREOVMC5qjO2Uw==
X-Received: by 2002:a19:3854:0:b0:513:c632:24bc with SMTP id d20-20020a193854000000b00513c63224bcmr2060824lfj.35.1710864836795;
        Tue, 19 Mar 2024 09:13:56 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:56 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:47 +0100
Subject: [PATCH 17/31] arm64: dts: qcom: sc7280-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-17-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              |  3 -
 arch/arm64/boot/dts/qcom/pm7325.dtsi               |  2 -
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 14 ----
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 81 ----------------------
 4 files changed, 100 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 3bf7cf5d1700..48eb8d9a5ac3 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -10,9 +10,6 @@
 / {
 	thermal-zones {
 		pm7250b-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm7250b_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pm7325.dtsi b/arch/arm64/boot/dts/qcom/pm7325.dtsi
index d1c5476af5ee..a25f6f65e416 100644
--- a/arch/arm64/boot/dts/qcom/pm7325.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7325.dtsi
@@ -34,8 +34,6 @@ pm7325_gpios: gpio@8800 {
 
 &thermal_zones {
 	pm7325_thermal: pm7325-thermal {
-		polling-delay-passive = <100>;
-		polling-delay = <0>;
 		thermal-sensors = <&pm7325_temp_alarm>;
 
 		trips {
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 4ff9fc24e50e..e4882b94d103 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -164,8 +164,6 @@ afvdd_2p8: regulator-afvdd-2p8 {
 
 	thermal-zones {
 		camera-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 2>;
 
 			trips {
@@ -178,8 +176,6 @@ active-config0 {
 		};
 
 		chg-skin-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm7250b_adc_tm 0>;
 
 			trips {
@@ -192,8 +188,6 @@ active-config0 {
 		};
 
 		conn-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm7250b_adc_tm 1>;
 
 			trips {
@@ -206,8 +200,6 @@ active-config0 {
 		};
 
 		quiet-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 1>;
 
 			trips {
@@ -220,8 +212,6 @@ active-config0 {
 		};
 
 		rear-cam-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 4>;
 
 			trips {
@@ -234,8 +224,6 @@ active-config0 {
 		};
 
 		sdm-skin-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 3>;
 
 			trips {
@@ -248,8 +236,6 @@ active-config0 {
 		};
 
 		xo-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 0>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 7e7f0f0fb41b..ef60a511a69f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -5969,9 +5969,6 @@ cpufreq_hw: cpufreq@18591000 {
 
 	thermal_zones: thermal-zones {
 		cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
@@ -6013,9 +6010,6 @@ map1 {
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
@@ -6057,9 +6051,6 @@ map1 {
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
@@ -6101,9 +6092,6 @@ map1 {
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
@@ -6145,9 +6133,6 @@ map1 {
 		};
 
 		cpu4-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -6189,9 +6174,6 @@ map1 {
 		};
 
 		cpu5-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -6233,9 +6215,6 @@ map1 {
 		};
 
 		cpu6-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
@@ -6277,9 +6256,6 @@ map1 {
 		};
 
 		cpu7-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
@@ -6321,9 +6297,6 @@ map1 {
 		};
 
 		cpu8-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 11>;
 
 			trips {
@@ -6365,9 +6338,6 @@ map1 {
 		};
 
 		cpu9-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
@@ -6409,9 +6379,6 @@ map1 {
 		};
 
 		cpu10-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 13>;
 
 			trips {
@@ -6453,9 +6420,6 @@ map1 {
 		};
 
 		cpu11-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 14>;
 
 			trips {
@@ -6497,9 +6461,6 @@ map1 {
 		};
 
 		aoss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 0>;
 
 			trips {
@@ -6518,9 +6479,6 @@ aoss0_crit: aoss0-crit {
 		};
 
 		aoss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 0>;
 
 			trips {
@@ -6539,9 +6497,6 @@ aoss1_crit: aoss1-crit {
 		};
 
 		cpuss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
@@ -6559,9 +6514,6 @@ cpuss0_crit: cluster0-crit {
 		};
 
 		cpuss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -6579,9 +6531,6 @@ cpuss1_crit: cluster0-crit {
 		};
 
 		gpuss0-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 1>;
 
 			trips {
@@ -6607,9 +6556,6 @@ map0 {
 		};
 
 		gpuss1-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 2>;
 
 			trips {
@@ -6635,9 +6581,6 @@ map0 {
 		};
 
 		nspss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -6656,9 +6599,6 @@ nspss0_crit: nspss0-crit {
 		};
 
 		nspss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -6677,9 +6617,6 @@ nspss1_crit: nspss1-crit {
 		};
 
 		video-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 5>;
 
 			trips {
@@ -6698,9 +6635,6 @@ video_crit: video-crit {
 		};
 
 		ddr-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 6>;
 
 			trips {
@@ -6719,9 +6653,6 @@ ddr_crit: ddr-crit {
 		};
 
 		mdmss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
@@ -6740,9 +6671,6 @@ mdmss0_crit: mdmss0-crit {
 		};
 
 		mdmss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
@@ -6761,9 +6689,6 @@ mdmss1_crit: mdmss1-crit {
 		};
 
 		mdmss2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 9>;
 
 			trips {
@@ -6782,9 +6707,6 @@ mdmss2_crit: mdmss2-crit {
 		};
 
 		mdmss3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 10>;
 
 			trips {
@@ -6803,9 +6725,6 @@ mdmss3_crit: mdmss3-crit {
 		};
 
 		camera0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 11>;
 
 			trips {

-- 
2.40.1


