Return-Path: <linux-kernel+bounces-107792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEC58801B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA281C22D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBFB83CDA;
	Tue, 19 Mar 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stIKvLOX"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6C83A05
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864831; cv=none; b=clL030eYWEObdQxzmu/PERDp8y7/N0UwB5Z8qcudf7102ewyOSKh9SfDaAUwOYYj3rNCfOKAGxrjrsgRrgmlmmR+KKC/HNYVY3xmNlz/ezZrYe6JxGJa7QvtXWDfK2AcW25cAa/STl58HCcCQ/ywGkIKBWXqWR7lLDYuXh1r2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864831; c=relaxed/simple;
	bh=Dx4eKRKD7RSI0UXacL9tWgAfAMYTeDCaf8UjZrFGLoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1Q90ndcs6wVXvtUv/RyM0CCs1rJYGkzTwW+/Vm0O569UgegukNbI+a+Xk11CpH23RnvgSNlJyc2V7wPMtAFu5J6Cjkc7qVAJ99SnKOYrJ62mjpQLB4Tn6toFw+jZbj26/T/aElqDf8yLWCAx5k9RPLkVJCiKJmeCrCLVQjExOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=stIKvLOX; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513e89d0816so2951766e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864828; x=1711469628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYS0OchrGD9kAwkYnjOpoqJceeaOYGfSJc+i+MfcuTY=;
        b=stIKvLOXV4FwdZO7WH6FWnFusAJKtz2NVmp0w8amhXPLaZ4GK82+UXcBNiOJ2zwviY
         z5eeeulPy0jKOGtcwD8GLNUkrbjOGsiyDmIFKeUv4rL3uobDkchancusC3UVuZBTfiCD
         XG6LszYdZB3n+pkCti6ImTT5rg6RTIKwVFJZSS3pmW2nyhCGUaaME3gIKTTVL3wPdZ77
         /D9RauUHNAQ3fd5bI3D1SnfWAQJNCzojjQFRYfeI3slwxrt6ifogXUGbwrM9Lrjxl1+F
         BWj6HZfvztucmGhtZyyKxnhi9SSr92RImgBHNTwMxn0QaKLvZV3NPqkp/Wi0TktE8p8y
         /hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864828; x=1711469628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYS0OchrGD9kAwkYnjOpoqJceeaOYGfSJc+i+MfcuTY=;
        b=Zt2xKCnUSoRySCfhthf9f1CNpDZowWFTGv36rJSCKgJ+N6QR7QWDksiVtitqhyivfX
         JYSi6CCBMaTA0UNOtt43+fZlC3BZxytM3orr1sd2FklMp4pzQpfChvvaNpKJLAzxe+vN
         qpb3tiI095e+77RgNT0woFHqFSLAxCZ3wD7jekUTp6S29f3LB6gvi/ObxV+ZUKXLOLe4
         UJs6E5RbyxFLbPXOUsS0+y5YjpqxWT03gl6rxVwvdqwptwSkBhX1iKnBIP0vJnUQRZwi
         MMMR60C/FupGZKRptVn4Zl/kAMh3RkDO6qEAEXnnZoO/SgArHwKLeMo5qitYVoHL9c4o
         nqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV99A10ItK5/2446v0gHUURQZweBh9YImlr0ySLEwGEkzYutwO0GDovpDjPiHTE6gEx9bXiGZ8yfPIkliEZOuTztY4HwzGsqdTIL9uV
X-Gm-Message-State: AOJu0YwgQcX90noJut64zjOyznERrlOBvUKUrZs+6i8mVTNVvwQVndAX
	Qdqbv7lbJ2uKRabQIIDcv6KMg20yWrYS1ADBcSohQZsZcbhMNmdaTWN1P1oa5Zg=
X-Google-Smtp-Source: AGHT+IGHSLoi1cSJEsqg639BDjMBa+TvC4cTijSihrY3DOfEJjf/m6Xb8qxLx6DnMmOh6MXVY5BkHQ==
X-Received: by 2002:ac2:505c:0:b0:513:2ead:4f86 with SMTP id a28-20020ac2505c000000b005132ead4f86mr2074188lfm.12.1710864828150;
        Tue, 19 Mar 2024 09:13:48 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:47 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:39 +0100
Subject: [PATCH 09/31] arm64: dts: qcom: msm8998-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-9-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 57 -----------------------------------
 arch/arm64/boot/dts/qcom/pm8998.dtsi  |  3 --
 2 files changed, 60 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 4dfe2d09ac28..8f5a92f1b863 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -487,9 +487,6 @@ slpi_smp2p_in: slave-kernel {
 
 	thermal-zones {
 		cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
@@ -508,9 +505,6 @@ cpu0_crit: cpu-crit {
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
@@ -529,9 +523,6 @@ cpu1_crit: cpu-crit {
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
@@ -550,9 +541,6 @@ cpu2_crit: cpu-crit {
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
@@ -571,9 +559,6 @@ cpu3_crit: cpu-crit {
 		};
 
 		cpu4-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -592,9 +577,6 @@ cpu4_crit: cpu-crit {
 		};
 
 		cpu5-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -613,9 +595,6 @@ cpu5_crit: cpu-crit {
 		};
 
 		cpu6-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
@@ -634,9 +613,6 @@ cpu6_crit: cpu-crit {
 		};
 
 		cpu7-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
@@ -655,9 +631,6 @@ cpu7_crit: cpu-crit {
 		};
 
 		gpu-bottom-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
@@ -670,9 +643,6 @@ gpu1_alert0: trip-point0 {
 		};
 
 		gpu-top-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 13>;
 
 			trips {
@@ -685,9 +655,6 @@ gpu2_alert0: trip-point0 {
 		};
 
 		clust0-mhm-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
@@ -700,9 +667,6 @@ cluster0_mhm_alert0: trip-point0 {
 		};
 
 		clust1-mhm-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -715,9 +679,6 @@ cluster1_mhm_alert0: trip-point0 {
 		};
 
 		cluster1-l2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 11>;
 
 			trips {
@@ -730,9 +691,6 @@ cluster1_l2_alert0: trip-point0 {
 		};
 
 		modem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 1>;
 
 			trips {
@@ -745,9 +703,6 @@ modem_alert0: trip-point0 {
 		};
 
 		mem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 2>;
 
 			trips {
@@ -760,9 +715,6 @@ mem_alert0: trip-point0 {
 		};
 
 		wlan-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -775,9 +727,6 @@ wlan_alert0: trip-point0 {
 		};
 
 		q6-dsp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -790,9 +739,6 @@ q6_dsp_alert0: trip-point0 {
 		};
 
 		camera-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 5>;
 
 			trips {
@@ -805,9 +751,6 @@ camera_alert0: trip-point0 {
 		};
 
 		multimedia-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 6>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 3f82715392c6..157feef07b03 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -10,9 +10,6 @@
 / {
 	thermal-zones {
 		pm8998-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&pm8998_temp>;
 
 			trips {

-- 
2.40.1


