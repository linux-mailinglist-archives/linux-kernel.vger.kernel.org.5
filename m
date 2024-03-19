Return-Path: <linux-kernel+bounces-107806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4538801E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF691F21C60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAE986640;
	Tue, 19 Mar 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZPtC86W"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F785C45
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864845; cv=none; b=oXZoGWPAGlVYlz+X3/Z+Qba+OmaFpeUtLmxKEHlN5q6NRUSbiDkZUiH0uVPYgdNOVzOAZToXz7hRiemuA845chQBEg9+Lb+XrGv8LeQvIaQnVztuogFq0PDHK6DNWsSba2ksCiW59K964qVvUkBtJJiQV43oRXLryZ64KGCAePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864845; c=relaxed/simple;
	bh=pA4U1gIpuSng0p4EvRgnsn4OXJOXp+4JRJ7zOeQmvfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0ajRQfPRdGV0nmS+8pW/I42x4SiltMrWOrvpiEGs5VoTEei+Ln6Xp83ULlvdXAXjoFZJFxdMGS24rOeFSy/CyADd7hNXp7+V52FcC9LYSLR2AlrH8zGhL4SXIElMClkSqwR6GqmhQNOiltRg7RAcjFSVgsILoub6mi+2v9bqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZPtC86W; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513e6778112so59e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864842; x=1711469642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfcVMpSrriu/CCewjQNWQl8ouwgswOI0990n8OUQStQ=;
        b=qZPtC86Wt3w/sVLHwMIWWg7BIIP4GKA6xp/Cn5ellroR9rkRMeJBUCwpQxQqp9yo98
         Gc/pXF1r2+CWLlNHNcaQXZra1X29fvSbLh1XhkocVOCGF0kif6lS/8KELBXomQGwzeAu
         rGkAH0oCdKiNKdgKz0Ho9xAv2eVxT4ulk425Q9ky6ano7DhVTzD8LTd2Bp5PWpMOm11s
         tGkk0aAVWmDhn1QUAehUdDMB0YrPnDOMgojdiFsuwzl0Us/Rr+RZDVCYp5dHuAsKmAtk
         w/czXs7WRT9aLTtZZxPcNU7X8mNSloA6TJxTlUvXmx7yxb2pY5k8I5ZxPhNgmwoxqROP
         z3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864842; x=1711469642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfcVMpSrriu/CCewjQNWQl8ouwgswOI0990n8OUQStQ=;
        b=DQdXH+ZpkETorMtUkHfBfkO73FCXvE3pcPTcgD5x8p1pK5Jt1ZNgaBjPcfOzll8ybh
         HGwwuDSitrlvJhSlJAdndRJKR2o2wkaLad9GKP88GAMVPfFitn4T9qeZTwC9rQX3tvCU
         6OcS6JV/UEWsmnitwkeewhomMKDt8tLKg6np60ijmDh/t+Lc9QZDN2W+Wt8Lypbp1UpI
         L+qhJr/LWsCFQRN5sZEwSRlL3pUMRJRC8ozbU9A0mswq857Ia31UFtWU8AeH6ySCId2Y
         vGTjFQQF/w8cyac353MM7nqCBxCT9JRNvXlRg5wWyPovG3gZsF9i5X/RcSeyIcih/Q/d
         lzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHEkHwddUnUrbH52QRmc89v+uOu4gcx5QwXb+J16BG3Y1e6k+rwbykW+uPXij//PXBgaZbDQflHLKeb7qku49i/6yMcIhjFoYF+9MJ
X-Gm-Message-State: AOJu0Ywix7C2xmhJ5GBnDnFcOD9uJQOM9SDPDZ/OWciOToEdq72zxlFd
	xUzf4kgGVmEtlVD7GERY8Qi4Me540C/jjoDTnq9vZR/5hWi3CtAOaW0sfHnp2+8=
X-Google-Smtp-Source: AGHT+IHX5iO3JUm8aTHh0lFyZbl4/yCiMz7XlUvrkC+8Ii2tRHFdbWywW9GwgMHPSMqebNS2pXg0Zw==
X-Received: by 2002:a05:6512:32a8:b0:513:dfac:b29e with SMTP id q8-20020a05651232a800b00513dfacb29emr1185145lfe.26.1710864841772;
        Tue, 19 Mar 2024 09:14:01 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:14:01 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:52 +0100
Subject: [PATCH 22/31] arm64: dts: qcom: sm6115-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-22-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/pmi632.dtsi |  3 ---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 32 --------------------------------
 2 files changed, 35 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
index 94d53b1cf6c8..e1658993d6c1 100644
--- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -10,9 +10,6 @@
 / {
 	thermal-zones {
 		pmi632-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pmi632_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index aca0a87092e4..0a0bb5310849 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -3011,8 +3011,6 @@ cpufreq_hw: cpufreq@f521000 {
 
 	thermal-zones {
 		mapss-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 0>;
 
 			trips {
@@ -3031,8 +3029,6 @@ trip-point1 {
 		};
 
 		cdsp-hvx-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
@@ -3051,8 +3047,6 @@ trip-point1 {
 		};
 
 		wlan-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
@@ -3071,8 +3065,6 @@ trip-point1 {
 		};
 
 		camera-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
@@ -3091,8 +3083,6 @@ trip-point1 {
 		};
 
 		video-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
@@ -3111,8 +3101,6 @@ trip-point1 {
 		};
 
 		modem1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
@@ -3131,8 +3119,6 @@ trip-point1 {
 		};
 
 		cpu4-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -3157,8 +3143,6 @@ cpu4_crit: cpu-crit {
 		};
 
 		cpu5-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -3183,8 +3167,6 @@ cpu5_crit: cpu-crit {
 		};
 
 		cpu6-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -3209,8 +3191,6 @@ cpu6_crit: cpu-crit {
 		};
 
 		cpu7-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
@@ -3235,8 +3215,6 @@ cpu7_crit: cpu-crit {
 		};
 
 		cpu45-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
@@ -3261,8 +3239,6 @@ cpu45_crit: cpu-crit {
 		};
 
 		cpu67-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 11>;
 
 			trips {
@@ -3287,8 +3263,6 @@ cpu67_crit: cpu-crit {
 		};
 
 		cpu0123-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
@@ -3313,8 +3287,6 @@ cpu0123_crit: cpu-crit {
 		};
 
 		modem0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 13>;
 
 			trips {
@@ -3333,8 +3305,6 @@ trip-point1 {
 		};
 
 		display-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 14>;
 
 			trips {
@@ -3353,8 +3323,6 @@ trip-point1 {
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 15>;
 
 			cooling-maps {

-- 
2.40.1


