Return-Path: <linux-kernel+bounces-107796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B4C8801C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3192852AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EB78526E;
	Tue, 19 Mar 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6L734cM"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6784A28
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864835; cv=none; b=nSGiGF70kZoZ9skA9FMZoqTDSVFM9RyhvSlw0t+gT2VCQmDzZn8sQQpygBxEInclS/ie8JOEpwDQrpdr9Ap57NJKxHzynnTaM3iQ2eYZHAJYhFV7Xwfnp77r75OeLAt6WUdtX3oSiigAVE6WUvu0njS+EOBpkEqc/eYCji01xIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864835; c=relaxed/simple;
	bh=0/k1OG8zIp9FMg8VdY+lmNOtRCz0TLzyGKYijhkIjTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b47dqpT0QVvxH/ZfNk7JNnOY+VAzpWcIAmfAahdrMERdp3E7IFpiDpvwv1iX+QCPCebLmrUHmR6kOmLQeK3s/EKAoBoREJ4bb6QgHcB5iD/riwG9qCpDGvOgkEHUEiUjMVo9qH7uHHg1vvWRcGJgUFBrdRw1unu3mZ5mdJHksaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v6L734cM; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513c8b72b24so6462836e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864832; x=1711469632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnnzTjYGMYdvVMtijUR117h7wwCsVG1+77vBOY60uzM=;
        b=v6L734cMTxW2Eejvl/1EpxONpDbGWqm/fOnLabUIDQOaOX4pWvEEyczEvw76GHts+y
         42yb171d7qsqkNAOUajT0NSiXkBjQLcPwci8wJGHeBMc0SImWrQgqVaeDXrFcgHrx93t
         pZdfdNGBiDXyG63DuCHjoNfvteA8YGIofj5gMHugu7XD+Rb72XflWfccj27g+h5Ep6wK
         bFPe7u1fy3hcSUBPOCnAuGJkmdynSG5i2gPOxEFYP08lE8yZ8NHR9Q4MrvWcAbFMqPaU
         ZwdAaT8C68llOMacq9hJ0mAL9gBLrqyf37YpS4lmbxGtCA9X7YmauDNQSD5tOdQTLx3r
         yAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864832; x=1711469632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnnzTjYGMYdvVMtijUR117h7wwCsVG1+77vBOY60uzM=;
        b=V0KzNiSyEhkHVW2c8531qBLWsrGG6h1wDkZYiqev6tVdD3a738iBL4dcfc5L8edcuw
         UcMvmM6400qJUZgQCrtYxqC3EdUMkVNMA6qcaro1hKzdxnj7AgEVTwMTi0jt0A6IZuOm
         Q8sM/FMv9y3HFOufuMOAgTyKf0phLAY0iDxJLLie95er9/FMaHp4vIP29/0wBNYxSGg3
         +C6k4D1pnSLcboEdH50OPsAKVYTDCY0gTSnrnlm1jQTSfsYkbd5Ma6eD+iS/5RDElL5o
         1KisFWkJCeWESteILB7tuocvFOs7wL3dJaUtE3X67M2dOhCivXYxFoICowPAphD+gaAn
         3QXA==
X-Forwarded-Encrypted: i=1; AJvYcCXJxJeYGJY8doVWF7ohaKFQPDUQZtRgKJcS6H4DBD0Ct5b0awIMzQp1ZeaROOixQQFCqEBBgpqVIx48Rxr0VZANE/idL62VSRnpSeMr
X-Gm-Message-State: AOJu0YxvxbsCbLvBaHH85uFFwXjKMQiPoSHkiRNtTEv7TMDsGDWEpSs6
	17IqKQfkCspHlk2AQ9vKrILWEjoBj3sWZiJB56Z1xgGxCEzKbiEIVZabVU/pIYo=
X-Google-Smtp-Source: AGHT+IH9sfgGnrDzwU543lAC82msqrPzdaGnPwcC2+ew+N4WAUzGLZoh1nEIF2YHhSYiwBYkdFUK7g==
X-Received: by 2002:a19:9103:0:b0:513:2b35:2520 with SMTP id t3-20020a199103000000b005132b352520mr2283451lfd.58.1710864831891;
        Tue, 19 Mar 2024 09:13:51 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:51 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:43 +0100
Subject: [PATCH 13/31] arm64: dts: qcom: qcm2290-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-13-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 89beac833d43..c439ad5a16ae 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -1870,9 +1870,6 @@ cpufreq_hw: cpufreq@f521000 {
 
 	thermal-zones {
 		mapss-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 0>;
 
 			trips {
@@ -1897,9 +1894,6 @@ mapss_crit: mapss-crit {
 		};
 
 		video-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
@@ -1924,9 +1918,6 @@ video_crit: video-crit {
 		};
 
 		wlan-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
@@ -1951,9 +1942,6 @@ wlan_crit: wlan-crit {
 		};
 
 		cpuss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
@@ -1978,9 +1966,6 @@ cpuss0_crit: cpuss0-crit {
 		};
 
 		cpuss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
@@ -2005,9 +1990,6 @@ cpuss1_crit: cpuss1-crit {
 		};
 
 		mdm0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
@@ -2032,9 +2014,6 @@ mdm0_crit: mdm0-crit {
 		};
 
 		mdm1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -2059,9 +2038,6 @@ mdm1_crit: mdm1-crit {
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -2086,9 +2062,6 @@ gpu_crit: gpu-crit {
 		};
 
 		hm-center-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -2113,9 +2086,6 @@ hm_center_crit: hm-center-crit {
 		};
 
 		camera-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 9>;
 
 			trips {

-- 
2.40.1


