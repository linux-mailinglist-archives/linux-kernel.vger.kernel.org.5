Return-Path: <linux-kernel+bounces-107805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7888801E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471981F22D78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC7786626;
	Tue, 19 Mar 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OspmlzIS"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3B8592F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864845; cv=none; b=KWe0cBMlVUBeWdfQcAyyvzC2uiFgaOMLh0bYbA9Rc5t6V1SyF9/SR1STlxYwCBdiTiBitOkJed513U3yzvOzrylQ12nXx0FGXaEhVNgSMnm35XUuME3Iuu/kg7HLmcwSIM6OaKnwT0UsWFin5F/7eYJetlkyBGpEmJeH89GVWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864845; c=relaxed/simple;
	bh=+cYea2v2/BKOer4KwV/CVWAJy8hOJfQVFafipAC2J+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAhwQsRV1B+DT1SLsRbbFD/1ajQ9GTiSOyizqSKZEOKlzxYfEO8wr/FKXOQrY/Nyp8OLuT0qnib9C4JcXhl4gqhKmnuesosM+SBF7RN73ay3fXeVheldkgQbm/5D19yuhaHpIr2eDUq1pXnSqhumw4/Wot06CbSphOiMpOrlmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OspmlzIS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51381021af1so8369114e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864840; x=1711469640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUJrKx7MvU52NeuXQ9HrJ3rBR5Q/85XuQI/RS6YMzDI=;
        b=OspmlzISMuWHs4p42TRJ3E/HM6ee+aHOLsfCTHcrsmFoIZ9z1NDRZfhiQHZvONh96g
         nqXcujlfTzZZGyThqak4MJH6Ht4DBVE1Y6A1PVpICPdGyEYqXqy1MD1ZQXUhLW9OIPL0
         Pwp9nSb46AS3s8ka0upRjTAvGe66TZygC+tHXCo6ymZ5o9/ZJdamQvDArxdriFkRVil8
         HJh9c0yUuEIxtJoZYOFWpnvltj+vJmaqgia03G9St4c8IlPI66ToCPfyZDTM2XbwrpkZ
         0bWg9YY3d3fTzHFRZda90m8j+MkRK4Nj9tA5/NncEmdoywJz4LMAsfCsn1/naT5dLwx4
         LAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864840; x=1711469640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUJrKx7MvU52NeuXQ9HrJ3rBR5Q/85XuQI/RS6YMzDI=;
        b=dqCteewDYjT9lDTi17NgLYVN4Rdzmh5Lu9stL2BkEHR/vewKA7V6rJUBFmyPV522R1
         77PN1jZaiiaf8Os5Uu9Pqzry/JqvACvf25z2Jo2aN8fzfRAHM87rfMrHxew2lKIRHAYe
         dq8bpjqbJ1Kj74ktlP515o/XrWDHYT05E2g264GsebpnbhaUKSll78R+3sEkFFLDcssN
         WcpQaIOowJohP9CI+pI+C2NtpqNCNUurU16wG0xbcg50EfoizbzNLFG+f2EV1UBOL1n8
         X73bzVey/tMtI+FQmuln7EHKvcrvZ+zXJzWNehjOTC6f6DWMy7qJkVC7kpCs8jvxifys
         1jQw==
X-Forwarded-Encrypted: i=1; AJvYcCUgvI3xIKHoC6ggk5+UCWOR3miVAXlNTSDyq5rTwJLZ9nBhKFX7tr3vQrmjDfBz0Dc9luQHjjquW3YOgrNNxAfktPoGZaLYhNNa+s9L
X-Gm-Message-State: AOJu0YwGn67jVpNSRtStbaOuRLwqCXx3JFdEtJfx9f6+QZQ+tkVIf8IY
	lRE1Fuuw1+PFHvzVAh/2I0Q5eCTGPcJnbXHIJQO2OUW9+MrseGD43rlh1LBFDI8=
X-Google-Smtp-Source: AGHT+IFGB1DWsnd12ElEbbIWQkgaeOW+F0Ihm5OZyQWwWoNxHzRzknGdE4iOkTj+o5szx6CpaZJqIA==
X-Received: by 2002:a19:e004:0:b0:513:ca40:fafc with SMTP id x4-20020a19e004000000b00513ca40fafcmr8242229lfg.11.1710864839740;
        Tue, 19 Mar 2024 09:13:59 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:59 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:50 +0100
Subject: [PATCH 20/31] arm64: dts: qcom: sdm660-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-20-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm660.dtsi  |  3 ---
 arch/arm64/boot/dts/qcom/pm660l.dtsi |  3 ---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 27 ---------------------------
 3 files changed, 33 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 98dc04962fe3..24efd1bf271c 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -12,9 +12,6 @@
 / {
 	thermal-zones {
 		pm660-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&pm660_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index 6fdbf507c262..46165a2a3694 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -12,9 +12,6 @@
 / {
 	thermal-zones {
 		pm660l-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&pm660l_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index f5921b80ef94..9851bc73222b 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2421,9 +2421,6 @@ sound: sound {
 
 	thermal-zones {
 		aoss-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 0>;
 
 			trips {
@@ -2436,9 +2433,6 @@ aoss_alert0: trip-point0 {
 		};
 
 		cpuss0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 1>;
 
 			trips {
@@ -2451,9 +2445,6 @@ cpuss0_alert0: trip-point0 {
 		};
 
 		cpuss1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 2>;
 
 			trips {
@@ -2466,9 +2457,6 @@ cpuss1_alert0: trip-point0 {
 		};
 
 		cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 3>;
 
 			trips {
@@ -2487,9 +2475,6 @@ cpu0_crit: cpu-crit {
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 4>;
 
 			trips {
@@ -2508,9 +2493,6 @@ cpu1_crit: cpu-crit {
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 5>;
 
 			trips {
@@ -2529,9 +2511,6 @@ cpu2_crit: cpu-crit {
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 6>;
 
 			trips {
@@ -2556,9 +2535,6 @@ cpu3_crit: cpu-crit {
 		 */
 
 		pwr-cluster-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 7>;
 
 			trips {
@@ -2577,9 +2553,6 @@ pwr_cluster_crit: cpu-crit {
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 8>;
 
 			cooling-maps {

-- 
2.40.1


