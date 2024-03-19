Return-Path: <linux-kernel+bounces-107813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F16880205
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03325B24E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE00128375;
	Tue, 19 Mar 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="et1V6qY6"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89B1272DC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864854; cv=none; b=r8r8uDzyjOxH3sACZjvvFMjd1sLkloVEUX16jE8SGhuiLNQoCK5aOoiTK1hI9pjRMqtVauphR7xPiRjnV02+aJGV8dmqcpIrmB+1g5k9TlZIiXCz8IjnlV0bQlOHI0OMY8fGuiZfLhZKDuHl98BQJXsBjBHfWMGAOtSguwG69bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864854; c=relaxed/simple;
	bh=WizwTGgP4cVSbvK0Z5+gMnGIqDckrAMp1j1rUCmVD3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+spMGsQ5cmdEpTI3hj2Sv/IQIlK547gwxFfItMwyxESB9VOBxYu8qB6xsEmF6B7x9iT5Ze1gXlAFaOK2WK7G9U/sdMI3uIunKNrKIh6QKEpnmv7Anv6Qs32RijB8bT4/REJjI1BL7pQHMXMXv88S43s/WMbTokLTDShbdzFcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=et1V6qY6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d599dbabso6581509e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864850; x=1711469650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqX9h+0UxlZQM32W03xoBKjlP5c39q57qREfueCSqoc=;
        b=et1V6qY6bBFIB7cvs5CN5P4bAFS4Dh27Xd101x16LZn5Eyy9XY8QEQG6QtB0AvjKGF
         GGl34IHIPZcVcMfE+5lqHMrWv5xHCZbXpeVUhv58Ac+OfCMKdwwkEv3fgs+ambZBegz8
         73/ik+5bnGmG8rUoVY2lE+vGPpYJ8Lvknxnf2K+iUsVta6INrysDggP7cBkIrPZfnw8a
         IBIVlsqdAV0CO+f0/93/ZvhqaTryho88JdTd7MIkBhCeojiGcQQvv+BVeLxVd0p/ISZw
         oaSf7JDe8sMtX2d6Fyk9JTSusWlOf6henbfig+VCc22FIQ6MVoQZ+UdSkgESa0CGfeKL
         dsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864850; x=1711469650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqX9h+0UxlZQM32W03xoBKjlP5c39q57qREfueCSqoc=;
        b=qxLZ2ocSVuPfm18wqHS/mnkbeJDFq6G9HbUDMIGXD6fZ+4klWO73mD9oMiS0GPTyZb
         l2kJjsUK/Ka6drdO0T9e3/kpS42Py0Wre9ABgg/w+gqqJco3s/BgRvvaAvTZH42xPuE6
         0AN/ybfdhDNFjMQaZEdsvs+st8tjRq+BsezZfw4wiQkyd4SvQ6cwW3td1SySA53ovW0a
         QjWfIi+qLkfac4NvZP+diP+4lL9YD3FRoWGGNjBAUHk9yvhM3pXpAFbNLtLAz9mqfgk5
         msMTaU5aPLeTYRz6hoFyBdPLY2SkJBeXYJVtbVMm6MmqboAOd1BExT0WZZX3b6n+26ku
         hRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYWIOr9S9iRmyxOgl7dm+DBZiHpjdWveni0q8yeENXajaLcV7sfZMMBszsSby29eipMkGl38llN4dxY93FUN/SEfIG6XQlN8Nb6Flb
X-Gm-Message-State: AOJu0YxfcHQ0DHbAJM6GeTiXwEHjgVgibX6a0s1lUtWVjs+IXVIEkNjv
	4oLPicd5hM/LFVAfhbJvaSdpDqhtf5jCDBpyZ2bZzTIYgLKTwuGRKK2XpKM65y0=
X-Google-Smtp-Source: AGHT+IFVKvGZCJdKyNwXRx8eWbxapy5yWUA2KCEvgq2sv7/ajcHT9Uoh2beROUZ2ekFt9krds5QyDA==
X-Received: by 2002:ac2:5306:0:b0:513:80cd:e807 with SMTP id c6-20020ac25306000000b0051380cde807mr2176984lfh.20.1710864848499;
        Tue, 19 Mar 2024 09:14:08 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:14:08 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:59 +0100
Subject: [PATCH 29/31] arm64: dts: qcom: sm8450-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-29-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm8450.dtsi    |  3 --
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 16 ---------
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 64 ---------------------------------
 3 files changed, 83 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8450.dtsi b/arch/arm64/boot/dts/qcom/pm8450.dtsi
index ae5bce3cf46e..5be83d41f3a2 100644
--- a/arch/arm64/boot/dts/qcom/pm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8450.dtsi
@@ -9,9 +9,6 @@
 / {
 	thermal-zones {
 		pm8450-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm8450_temp_alarm>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 0786cff07b89..4f17fceaca65 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -136,8 +136,6 @@ pmic_glink_sbu: endpoint {
 
 	thermal-zones {
 		camera-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 2>;
 
 			trips {
@@ -150,8 +148,6 @@ active-config0 {
 		};
 
 		rear-tof-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 5>;
 
 			trips {
@@ -164,8 +160,6 @@ active-config0 {
 		};
 
 		skin-msm-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 1>;
 
 			trips {
@@ -178,8 +172,6 @@ active-config0 {
 		};
 
 		therm1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 3>;
 
 			trips {
@@ -192,8 +184,6 @@ active-config0 {
 		};
 
 		therm2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 6>;
 
 			trips {
@@ -206,8 +196,6 @@ active-config0 {
 		};
 
 		usb-conn-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 7>;
 
 			trips {
@@ -220,8 +208,6 @@ active-config0 {
 		};
 
 		wide-rfc-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 4>;
 
 			trips {
@@ -234,8 +220,6 @@ active-config0 {
 		};
 
 		xo-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 0>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index b86be34a912b..29c3a74ceb5a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4595,8 +4595,6 @@ sound: sound {
 
 	thermal-zones {
 		aoss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 0>;
 
 			trips {
@@ -4615,8 +4613,6 @@ reset-mon-cfg {
 		};
 
 		cpuss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
@@ -4635,8 +4631,6 @@ reset-mon-cfg {
 		};
 
 		cpuss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
@@ -4655,8 +4649,6 @@ reset-mon-cfg {
 		};
 
 		cpuss3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
@@ -4675,8 +4667,6 @@ reset-mon-cfg {
 		};
 
 		cpuss4-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
@@ -4695,8 +4685,6 @@ reset-mon-cfg {
 		};
 
 		cpu4-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
@@ -4721,8 +4709,6 @@ cpu4_top_crit: cpu-crit {
 		};
 
 		cpu4-bottom-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -4747,8 +4733,6 @@ cpu4_bottom_crit: cpu-crit {
 		};
 
 		cpu5-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -4773,8 +4757,6 @@ cpu5_top_crit: cpu-crit {
 		};
 
 		cpu5-bottom-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -4799,8 +4781,6 @@ cpu5_bottom_crit: cpu-crit {
 		};
 
 		cpu6-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
@@ -4825,8 +4805,6 @@ cpu6_top_crit: cpu-crit {
 		};
 
 		cpu6-bottom-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
@@ -4851,8 +4829,6 @@ cpu6_bottom_crit: cpu-crit {
 		};
 
 		cpu7-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 11>;
 
 			trips {
@@ -4877,8 +4853,6 @@ cpu7_top_crit: cpu-crit {
 		};
 
 		cpu7-middle-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
@@ -4903,8 +4877,6 @@ cpu7_middle_crit: cpu-crit {
 		};
 
 		cpu7-bottom-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 13>;
 
 			trips {
@@ -4929,8 +4901,6 @@ cpu7_bottom_crit: cpu-crit {
 		};
 
 		gpu-top-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 14>;
 
 			cooling-maps {
@@ -4968,8 +4938,6 @@ gpu_top_alert0: trip-point0 {
 		};
 
 		gpu-bottom-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 15>;
 
 			cooling-maps {
@@ -5007,8 +4975,6 @@ gpu_bottom_alert0: trip-point0 {
 		};
 
 		aoss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 0>;
 
 			trips {
@@ -5027,8 +4993,6 @@ reset-mon-cfg {
 		};
 
 		cpu0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 1>;
 
 			trips {
@@ -5053,8 +5017,6 @@ cpu0_crit: cpu-crit {
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 2>;
 
 			trips {
@@ -5079,8 +5041,6 @@ cpu1_crit: cpu-crit {
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -5105,8 +5065,6 @@ cpu2_crit: cpu-crit {
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -5131,8 +5089,6 @@ cpu3_crit: cpu-crit {
 		};
 
 		cdsp0-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 5>;
 
 			trips {
@@ -5163,8 +5119,6 @@ cdsp_0_config: junction-config {
 		};
 
 		cdsp1-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 6>;
 
 			trips {
@@ -5195,8 +5149,6 @@ cdsp_1_config: junction-config {
 		};
 
 		cdsp2-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
@@ -5227,8 +5179,6 @@ cdsp_2_config: junction-config {
 		};
 
 		video-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
@@ -5247,8 +5197,6 @@ reset-mon-cfg {
 		};
 
 		mem-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 9>;
 
 			trips {
@@ -5273,8 +5221,6 @@ reset-mon-cfg {
 		};
 
 		modem0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 10>;
 
 			trips {
@@ -5305,8 +5251,6 @@ reset-mon-cfg {
 		};
 
 		modem1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 11>;
 
 			trips {
@@ -5337,8 +5281,6 @@ reset-mon-cfg {
 		};
 
 		modem2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 12>;
 
 			trips {
@@ -5369,8 +5311,6 @@ reset-mon-cfg {
 		};
 
 		modem3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 13>;
 
 			trips {
@@ -5401,8 +5341,6 @@ reset-mon-cfg {
 		};
 
 		camera0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 14>;
 
 			trips {
@@ -5421,8 +5359,6 @@ reset-mon-cfg {
 		};
 
 		camera1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 15>;
 
 			trips {

-- 
2.40.1


