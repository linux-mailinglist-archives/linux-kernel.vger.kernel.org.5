Return-Path: <linux-kernel+bounces-107789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390AF8801AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D31C21282
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811E2839FA;
	Tue, 19 Mar 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLb3xpLj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341582C6B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864828; cv=none; b=qdqSzpFKqsfCD2a9rxNqNNluvz/KrEIZi7tFoj0Api0IN/UCTYTp5u4SECHlnNAgld2frPndt4ieS4LPLUjOQV/QoV3GJTw4OV0o61xC6Y2eqsm/d7cijzau4l9IqK/ROhEeN/leiMNP7VcxhYxa/N3Yh3D+CYnkzLu2CW6e4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864828; c=relaxed/simple;
	bh=SfPqDJQhOWdHozWKeZBtjuPf0esW3AKFUGrf2WUgQEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hD16r8TV5y3OUYDEMUEoqxVqo4489tpGvFUw4sOmp1oSuJ4LxaAuQDsYpJgYWVl/nmOFIrqYb94skbmR887FQ7glO1rW+lawTBVgzhT9koWKlJGbfhaosVqkK+4gr4kyFkBZAxsC3+00QBDxpCAYX/XN7LGBwdnFbi8+9vWYrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RLb3xpLj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso9874526e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864825; x=1711469625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JE5DV75rtGU2KZG98kvu1+83FeCFnCvttAQ6DWMQmbM=;
        b=RLb3xpLj10O8rivS2nehc5aJxABoMCcaxrBEt+yFQTbBTu+rOwj2IK9vkR2cCy5Q7G
         42IQOVu9CNA3Rbca7Rd2md6QSR6bYSdchJWhGiOVqBG4duqMT/3i+Q6IrzxQGOrPvX9s
         uhaO7KPNdQvtd4hSg7WBWoOC4mxJIVjMRr59tMQMVDTmqyCYt5TDHoaG2TF1gDwMpkWI
         AlSCdCqtNNUpje0hiRwaHG6tWEBCH+SW5d9flov19po6uo9gKmpeoYWqellUeGNYSqTz
         1wplJZIzzPvzwMg/lOKvND9Ztg5REyADC3zPfFD3SeXjZ6OXKm71ZBjSJ1yipVAeNuE3
         CpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864825; x=1711469625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE5DV75rtGU2KZG98kvu1+83FeCFnCvttAQ6DWMQmbM=;
        b=nLh1x6KjK2xZTZh4FMh6+vgeeBZMNtWB56rQQLwcnAJVUFu/5W2S29xRHVpTWF5rs4
         u0AJXCj3mZm6zwNC4xvzZkCxzcF3pDX2n4RmbnB58y5XhGHByky6Gctub4kOfy0HwLWC
         rvToLDswy92Vy1TPTYlCcPU4cyzxmgdgrabT5Fn4fQlsfmu9BgRV1/S0QzOgT5iUb3sJ
         a4Yponh6SfbV/7r58f22M61G8zPn1RMOI8DQC3m9fMehoF1inzCFSP6E+yg372MfKZaH
         jFAdJrsRx6YerpWYpw1i4g4bFbWllpGL9+8SYaDRH3OnMNJdadv13DNFe4R8R9gn4S6w
         mp9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLcsqpgURT9mF+OSMoBxUdHu5xrJh03OxglNDs1HE5fF6YFqZ4rFbSP9E+csnk7/je0LTH7BmA4wbSdt3msZR3+gpRKh9T7tHjgr88
X-Gm-Message-State: AOJu0YwU12Wth5Ncwh/Jr/rZDZQhhlQgHksz1kjBTSel2aN1HTtp1Tlr
	Y6lC/aEj25aTWDY9+S6iWYuls5IGrrRN7crwEldyfabO7iXr0lJg9TqXACYBt2s=
X-Google-Smtp-Source: AGHT+IFcyBzfaTP1g339erTfOUUblPYAamGEaifNUd5xLAOw6PtTY0a0M6q5/7zz74sfVo/yjEXkvQ==
X-Received: by 2002:a19:6907:0:b0:514:b450:99b4 with SMTP id e7-20020a196907000000b00514b45099b4mr4007765lfc.65.1710864825102;
        Tue, 19 Mar 2024 09:13:45 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:44 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:36 +0100
Subject: [PATCH 06/31] arm64: dts: qcom: msm8953-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-6-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 18 ------------------
 arch/arm64/boot/dts/qcom/pm8953.dtsi  |  3 ---
 2 files changed, 21 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index f1011bb641c6..73e52cc54236 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1953,8 +1953,6 @@ q6routing: routing {
 
 	thermal-zones {
 		cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens0 9>;
 			trips {
 				cpu0_alert: trip-point0 {
@@ -1976,8 +1974,6 @@ map0 {
 			};
 		};
 		cpu1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens0 10>;
 			trips {
 				cpu1_alert: trip-point0 {
@@ -1999,8 +1995,6 @@ map0 {
 			};
 		};
 		cpu2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens0 11>;
 			trips {
 				cpu2_alert: trip-point0 {
@@ -2022,8 +2016,6 @@ map0 {
 			};
 		};
 		cpu3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens0 12>;
 			trips {
 				cpu3_alert: trip-point0 {
@@ -2045,8 +2037,6 @@ map0 {
 			};
 		};
 		cpu4-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens0 4>;
 			trips {
 				cpu4_alert: trip-point0 {
@@ -2068,8 +2058,6 @@ map0 {
 			};
 		};
 		cpu5-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens0 5>;
 			trips {
 				cpu5_alert: trip-point0 {
@@ -2091,8 +2079,6 @@ map0 {
 			};
 		};
 		cpu6-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens0 6>;
 			trips {
 				cpu6_alert: trip-point0 {
@@ -2114,8 +2100,6 @@ map0 {
 			};
 		};
 		cpu7-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens0 7>;
 			trips {
 				cpu7_alert: trip-point0 {
@@ -2138,8 +2122,6 @@ map0 {
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens0 15>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
index 1067e141be6c..64258505f9ba 100644
--- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
@@ -9,9 +9,6 @@
 / {
 	thermal-zones {
 		pm8953-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm8953_temp>;
 
 			trips {

-- 
2.40.1


