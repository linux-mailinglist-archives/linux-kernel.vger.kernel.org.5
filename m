Return-Path: <linux-kernel+bounces-107810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 112E68801FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F561F22237
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E71272D1;
	Tue, 19 Mar 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/tmVSIS"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7A86647
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864850; cv=none; b=C0kG3aHLOnUsk4DgqwbLYCw6xWFsVTMmnE7mLlKyN8mToDoyCIraXHjdtYZMm0TQyBIPXLlzaAm8E/n3a5UgwjROfmFNgBM3nEMAtZyZS+8jzYPogrA4Idia6NslHlFaBlovgKvg0x3xHUwQ85K7FgZlIZ3hj4xuaVsn6/gB6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864850; c=relaxed/simple;
	bh=SYRIPcVRg8wtEwy9lilxy1VuVa/JKKP+USyQ4up8dqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxNmjukZV4uC1PItLjY6R2YjK/IsdJW9jpBcQGQBCM8RhxlsL4Q4/Ng5eiReuHoOIg4eGc5d/5pkVT2SFfzzDmFhCxGhOlBSwiuJQTtaNK5Q6fMA0SBV+g3RnPjxQxWUR7oC+ib+otMu/49UlRQFyQsRW9j4bcv2ZlIS6Z0xink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/tmVSIS; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513d23be0b6so6074654e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864845; x=1711469645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a30QI+q8MIR9amoxAl6v28Tm8Ljq8wSKHv73G7nTU8I=;
        b=W/tmVSISh3OdBVGhkvHSbIMkOYMsLjwSqq9H/yxhl48MUO3b2QWVwBpvZdOrMjWICj
         jufoIyj4dXYv572HNMTnOrCE/SElYt2jo3wlEIcUPCNqxNOP0c3elrizedi1sM8LH9nX
         IyYoHxMRoINq0ECb9ELv2ZYqB7WtSTULSMojtHGt1je2q/qDmbQVOBQhjz8CpOpP+L89
         LpCp2jpgcmfZJZ957kL5lf5xiO8m0zFgGb7Xk4XsbUN4TaUT+tuoWL947wBgw2phw1dN
         v3feq7Y2OeyJC5BQgeXpFI43M7QZExNhmpEEGvoAznSG1MWL4wGZW8TrG/uhfuoAQufq
         sUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864845; x=1711469645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a30QI+q8MIR9amoxAl6v28Tm8Ljq8wSKHv73G7nTU8I=;
        b=g6HqFcRvmPb/NzVBt63b/sHHFcGIdGAWwzzwhvPCKiMhJbJmx3N4hqEntPQ0m7+IZK
         YmMbT6Dpt5h0oIXvKMfp9rbNqPZPmf8ReGBo4V/n9mPjgZVhztYdVfqIoEf3uXEqhDUe
         mATm1t0jFZideKTEMTiAs5gyKK/E+DYpf9/bWjzqNJ9E8bxR3ac/0hJI0kh4jOP2vhne
         eMjwA4RYbHCsIXYFBD9OjP+Tk4i7TM9uDbJoS5rr5fprv8HFfb65YNNo1fVgDnIYSmrK
         J8BDZ6stNPEyEqe+KQFZDqBClY/YTqvIx+ip41XgGPI33Exn6xVdeDtYROYUWA5J69Pc
         Xx3g==
X-Forwarded-Encrypted: i=1; AJvYcCXLjz1BKp3i0x3Rktkh4/E/h3IFBeCxBtDNMkuhH9fi9p2dwIHJUTwaQRmUIYLJHxK9rCvtpJXYC50nlS1RvSpYUAaehD7EL3ltAvJ3
X-Gm-Message-State: AOJu0YzsSFPhOvPOJ2kfODCjfVjCiiJPy/K5D/5XVk+A9bGkPuZEm6lf
	UC2njKca/JCtAHXkYpl9j7yv8jxsWNfnzJL7Npg4jLvTCFIzeLfRCSFtwInUq1M=
X-Google-Smtp-Source: AGHT+IGPBPNajx/uCmgHLtELEJ94O5c6E8RnencvMtahhFC3pBz4X9/JBADwYb4Aihhuo+1W2Tb9xQ==
X-Received: by 2002:ac2:5206:0:b0:513:c25b:8fe with SMTP id a6-20020ac25206000000b00513c25b08femr2281462lfl.58.1710864845705;
        Tue, 19 Mar 2024 09:14:05 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:14:05 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:56 +0100
Subject: [PATCH 26/31] arm64: dts: qcom: sm8150-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-26-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm8150.dtsi      |  3 --
 arch/arm64/boot/dts/qcom/pm8150b.dtsi     |  3 --
 arch/arm64/boot/dts/qcom/pm8150l.dtsi     |  3 --
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi |  3 --
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi |  3 --
 arch/arm64/boot/dts/qcom/sm8150.dtsi      | 84 -------------------------------
 6 files changed, 99 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index 3ba3ba5d8fce..72343fc80a47 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -12,9 +12,6 @@
 / {
 	thermal-zones {
 		pm8150-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm8150_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 1aee3270ce7b..f75e9817de85 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -11,9 +11,6 @@
 / {
 	thermal-zones {
 		pm8150b-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm8150b_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index ac08a09c64c2..b9e0c8af5c48 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -11,9 +11,6 @@
 / {
 	thermal-zones {
 		pm8150l-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm8150l_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
index dbd4b91dfe06..a25927eba785 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
@@ -11,9 +11,6 @@
 / {
 	thermal-zones {
 		pmm8155au-1-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pmm8155au_1_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
index 1cee20ac2c9c..6c370d0e4938 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
@@ -10,9 +10,6 @@
 / {
 	thermal-zones {
 		pmm8155au-2-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pmm8155au_2_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a35c0852b5a1..a2ee7bfe03e1 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4556,9 +4556,6 @@ timer {
 
 	thermal-zones {
 		cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
@@ -4600,9 +4597,6 @@ map1 {
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
@@ -4644,9 +4638,6 @@ map1 {
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
@@ -4688,9 +4679,6 @@ map1 {
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
@@ -4732,9 +4720,6 @@ map1 {
 		};
 
 		cpu4-top-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -4776,9 +4761,6 @@ map1 {
 		};
 
 		cpu5-top-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -4820,9 +4802,6 @@ map1 {
 		};
 
 		cpu6-top-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
@@ -4864,9 +4843,6 @@ map1 {
 		};
 
 		cpu7-top-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
@@ -4908,9 +4884,6 @@ map1 {
 		};
 
 		cpu4-bottom-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 11>;
 
 			trips {
@@ -4952,9 +4925,6 @@ map1 {
 		};
 
 		cpu5-bottom-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
@@ -4996,9 +4966,6 @@ map1 {
 		};
 
 		cpu6-bottom-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 13>;
 
 			trips {
@@ -5040,9 +5007,6 @@ map1 {
 		};
 
 		cpu7-bottom-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 14>;
 
 			trips {
@@ -5084,9 +5048,6 @@ map1 {
 		};
 
 		aoss0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 0>;
 
 			trips {
@@ -5099,9 +5060,6 @@ aoss0_alert0: trip-point0 {
 		};
 
 		cluster0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
@@ -5119,9 +5077,6 @@ cluster0_crit: cluster0-crit {
 		};
 
 		cluster1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -5139,9 +5094,6 @@ cluster1_crit: cluster1-crit {
 		};
 
 		gpu-top-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens0 15>;
 
 			cooling-maps {
@@ -5161,9 +5113,6 @@ gpu_top_alert0: trip-point0 {
 		};
 
 		aoss1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 0>;
 
 			trips {
@@ -5176,9 +5125,6 @@ aoss1_alert0: trip-point0 {
 		};
 
 		wlan-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 1>;
 
 			trips {
@@ -5191,9 +5137,6 @@ wlan_alert0: trip-point0 {
 		};
 
 		video-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 2>;
 
 			trips {
@@ -5206,9 +5149,6 @@ video_alert0: trip-point0 {
 		};
 
 		mem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -5221,9 +5161,6 @@ mem_alert0: trip-point0 {
 		};
 
 		q6-hvx-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -5236,9 +5173,6 @@ q6_hvx_alert0: trip-point0 {
 		};
 
 		camera-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 5>;
 
 			trips {
@@ -5251,9 +5185,6 @@ camera_alert0: trip-point0 {
 		};
 
 		compute-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 6>;
 
 			trips {
@@ -5266,9 +5197,6 @@ compute_alert0: trip-point0 {
 		};
 
 		modem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
@@ -5281,9 +5209,6 @@ modem_alert0: trip-point0 {
 		};
 
 		npu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
@@ -5296,9 +5221,6 @@ npu_alert0: trip-point0 {
 		};
 
 		modem-vec-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 9>;
 
 			trips {
@@ -5311,9 +5233,6 @@ modem_vec_alert0: trip-point0 {
 		};
 
 		modem-scl-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 10>;
 
 			trips {
@@ -5326,9 +5245,6 @@ modem_scl_alert0: trip-point0 {
 		};
 
 		gpu-bottom-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens1 11>;
 
 			cooling-maps {

-- 
2.40.1


