Return-Path: <linux-kernel+bounces-107790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA388801B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F921F22E35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623A83CAE;
	Tue, 19 Mar 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flJxft6Q"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679F82D85
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864830; cv=none; b=k26qs2/UhD1MLi0hqhJ2M3BHUpSmIQgR0qYGlR98eeWKSXLtb31IFS0kOT60N2aUtvSLtce3wPt6+4KDPPHMKHkeEe4cgIo16Vbv1h23w32gYMd8VtMEKsGEO0ss+pArKsYfLDRS4wVaJltEHUe5TBxLueY0NZKCYQyINhHXGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864830; c=relaxed/simple;
	bh=PFYMK6VYlsNGq0yT2mzUkiCLZovHcDvfCBSf9J4E7w8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8DL1Co7CxHiAGQr3tHUSShUgtRkaFdrXVuuSMoHokRIIv3+kinmeFQ1RffVyUwZV2/xgkPy2za2Wegdv4YaKiCNz3F/B5kjiAXbNrR8MT0T4KCxT2gnCDAeaRUA52sB1pJ8NIYPG77eoCpX+Kjwv6D6qrvTqSnSxYjYKdsmIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=flJxft6Q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513e6777af4so4509729e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864826; x=1711469626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zjX2LvJZoTkKgrNigxF1JXeIkRgZu7NU8ImcW2GIeo=;
        b=flJxft6Qx/sLfL08fCzLeilXx4jeuhO52LEJ1wFqXPnA9rGStX8zrdnD6woN8U0X7A
         WM7ClmDewfd5dGA0swmYvUZPD4YGLShtLpFU28P1rqDDyxkFRXcBGkkJzgg0EmVC2K9k
         eJ/UOzyHYoXyuDeNbIa2yfR9Blxkq7I1KROC/HCZUSb4OgfoKzJOYjGc9zmTtHBK1zkW
         7u+yy4Lihn/AzLtsBTlkUi4IHbjbSGH1o3JgSILN45k63oN/3vKDfSsls1SZb08i/m2E
         +AIZgJD6DWLNW4omSjYYW3jdewFVn/3UW4anq8M/adhISC/fD63w+yaXh0miMwwUhYMt
         Ue/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864826; x=1711469626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zjX2LvJZoTkKgrNigxF1JXeIkRgZu7NU8ImcW2GIeo=;
        b=BEvExyMNcipzSkTY5wCOH/nUBxq0m3sGDygaZ3iGLnp2ppE6E7qLtIyHSrSi3Vu+64
         BAbP67MdB38/umukojxNZokkEuINqP2cwWK3/rqiSROTrgXPqvPxaw0qGctcXUDvRcuQ
         8DDoAEc88RZd1XXCV0KWNzEZRVX784pt/09PJlVlV19cVXbNtsVkjXWUjc/y7uOnf0I7
         NXBJiLvUGCcrtqHzhrARqaShvG0ZYFHGWsu5KcMZ5eLaI7fNaGNWQzhiE9RPb6JNK93E
         QIDD3lg5RrCbSqkrnpIEMHUeIrzv1UNp7f5XmRM8IKu6hDHa21tSazO6581d4k92cgG1
         FnTA==
X-Forwarded-Encrypted: i=1; AJvYcCXW/pIo3JR+BEgCZRvKB3gZ5B2j5mRiYn8EveGj2ojsrwEW5RUMKMcvHbIgS/OzhJl6aXFSZzOuwuWxL1QZz1qOzAdbwWiZX86xuBIr
X-Gm-Message-State: AOJu0YzgAhJRqQhHdQSNTbpgt0Ft+3DhVezZ1edIoKpmFQrBWSJgrOnw
	FTgzZZB2WWo/18+cjkeW0urS23E4QDW7goZ6nm9xD9msPJkzQVKqZOxkTbDABxrC820gscsQhMw
	wp3I=
X-Google-Smtp-Source: AGHT+IEl06sVnPcghkVNp49cEc/4CH7lfCC+t3lCR6sd/PvrNoUINkJMCmtaDs7RzkSG1YYm3FInlw==
X-Received: by 2002:a05:6512:b9e:b0:513:ed17:af03 with SMTP id b30-20020a0565120b9e00b00513ed17af03mr5570583lfv.59.1710864826155;
        Tue, 19 Mar 2024 09:13:46 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:45 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:37 +0100
Subject: [PATCH 07/31] arm64: dts: qcom: msm8976-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-7-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index d2bb1ada361a..09cb8cbceb6e 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -1123,9 +1123,6 @@ pil-reloc@94c {
 
 	thermal-zones {
 		aoss0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 0>;
 
 			trips {
@@ -1138,9 +1135,6 @@ aoss0_alert0: trip-point0 {
 		};
 
 		modem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 1>;
 			trips {
 				modem_alert0: trip-point0 {
@@ -1152,9 +1146,6 @@ modem_alert0: trip-point0 {
 		};
 
 		qdsp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 2>;
 			trips {
 				qdsp_alert0: trip-point0 {
@@ -1166,9 +1157,6 @@ qdsp_alert0: trip-point0 {
 		};
 
 		cam-isp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&tsens 3>;
 			trips {
 				cam_isp_alert0: trip-point0 {
@@ -1180,8 +1168,6 @@ cam_isp_alert0: trip-point0 {
 		};
 
 		cpu4-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 4>;
 
 			trips {
@@ -1204,8 +1190,6 @@ cpu4_crit: cpu-crit {
 		};
 
 		cpu5-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 5>;
 
 			trips {
@@ -1228,8 +1212,6 @@ cpu5_crit: cpu-crit {
 		};
 
 		cpu6-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 6>;
 
 			trips {
@@ -1252,8 +1234,6 @@ cpu6_crit: cpu-crit {
 		};
 
 		cpu7-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 7>;
 
 			trips {
@@ -1276,8 +1256,6 @@ cpu7_crit: cpu-crit {
 		};
 
 		big-l2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 8>;
 
 			trips {
@@ -1300,8 +1278,6 @@ l2_crit: l2-crit {
 		};
 
 		cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 9>;
 
 			trips {
@@ -1324,8 +1300,6 @@ cpu0_crit: cpu-crit {
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 10>;
 
 			trips {

-- 
2.40.1


