Return-Path: <linux-kernel+bounces-107786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12AE8801A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE441F21F15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329A68288A;
	Tue, 19 Mar 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozFW/VoO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD481ADD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864825; cv=none; b=BtlJDlhmkkA4khOWYhh9vOxNupS3WWwP40uRhE+9ICA7gvF4DYSZ7FCcCY6mDN3A5NATUZyoo6P+cUx387Dw24jIZ0Deq4lq8nm9xGLKUDo3EKoF9nMRQnbxBsj0h4/qVRggT0o1e3jZjf/Cy2uM09gCeYtsr5T0HAJo4I2btHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864825; c=relaxed/simple;
	bh=AI/6GDzleNINtkezjfAEmbDXxNIt1iLgs6smOMt1BtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FNLApXlyU7ZrNZRpb6AWKdyrJnfAjV6wxclP8+6innVKCgqcMKAHYhsFe8IwGZKRW7+W1FWtcTSEuSq8/EPEhkAdCsPcuRVFUjpmaJP4Zw+uNiUYnBqKQC6njo3aVzSZLXTB3ghwEbxRIfyP9TlV41U4oD+LLIg7LEeYNQp0/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ozFW/VoO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513e25afabaso3209631e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864822; x=1711469622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cK/DjygM8+bO8NZk8MSB3Ko2HzSfu+tnWhQWu8DehZc=;
        b=ozFW/VoOBKXQeUN5+MmsNMk+xzgS/xe2wt90gXKcbpvD/6UH0iPhESuGZbkLlOOkMJ
         18vwuTzxV+SSPKkoeBnQPzMdVIZubObW2i0pBPNwNMGp2CTvpZPBjGqxw9ho6PtTKf8k
         6PlTPxnQ88I8Vg7KnjybhQzrhXrTXlroR9TZfPrIQsqjmfFAVhc0oVvnryXa2eCoT9od
         lor1u0dkUinBnehZNR5rx8M7m5P72egVzusy7ASQnJTYs/M9w57Pv4/Vvahzr/qqquqG
         jh1i1Nr2v3t0030W9zBEjcNzXc5uNqWTkx1pKQJXfz8wLd1LTakoEiMPH2noLRcRSpNI
         U+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864822; x=1711469622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK/DjygM8+bO8NZk8MSB3Ko2HzSfu+tnWhQWu8DehZc=;
        b=oVFnFlzUTrCB4gT+tIspKODDsWiCCS7uLx6JPF8bLtfreX4g3e4H4cB9uMSv+w44q2
         8Lj+ucoeNnE46SA9vqGEMICsXZqE4dv3aw88Um0SINnOSoeICb6Nj367B9Ys1Ft06Hpc
         uXilAIFolXM9s/o2OrSjf4l0SpLR20/Y8quG+WflybKLwee3vTddgBV00zft40Vz1Fk5
         G+cypit4bREXIiUO4w2WaDCfkog+XCFcaT7e3kS318VaN/NY3Sqia9ONGOpTm7c7UTyN
         kxO4VNrrbfLgQbnAM/2FYpdBF5yzPp8FYSBN82cxWh1kH2YQeXjEH0ANtNEmAQ7Amf5U
         tpcw==
X-Forwarded-Encrypted: i=1; AJvYcCUV8iikvQYF+t4Hto0ZnqxSYGBiKDa3gW/17nhqtbtQeI4bR0k96DXrJtElrliME+mwXLub1/LcIrw8uzXA2BgVnZ+OebDECWDDubcM
X-Gm-Message-State: AOJu0YxTwMf8VgInHwLIJbMbZ44zkniScPmgZJQxodIuJOJpd2LYstT8
	+TFO7msmqK4CibHAMgiqZKT0Rn7pxD4lsYTAza9ifbiHay8LlnhlCpU5DzhO8og=
X-Google-Smtp-Source: AGHT+IGXpqTMMqMQtoD8GlYkET93+vUVl53lsGT3mijIE32aVUr82o7PSkzaLdW1uxZRxDx/280DBA==
X-Received: by 2002:ac2:5b84:0:b0:513:58a1:f4fd with SMTP id o4-20020ac25b84000000b0051358a1f4fdmr9833316lfn.25.1710864821702;
        Tue, 19 Mar 2024 09:13:41 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:41 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:33 +0100
Subject: [PATCH 03/31] arm64: dts: qcom: ipq9574-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-3-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7f2e5cbf3bbb..98c5623f4391 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -749,8 +749,6 @@ frame@b128000 {
 
 	thermal-zones {
 		nss-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 3>;
 
 			trips {
@@ -763,8 +761,6 @@ nss-top-critical {
 		};
 
 		ubi-0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 4>;
 
 			trips {
@@ -777,8 +773,6 @@ ubi_0-critical {
 		};
 
 		ubi-1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 5>;
 
 			trips {
@@ -791,8 +785,6 @@ ubi_1-critical {
 		};
 
 		ubi-2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 6>;
 
 			trips {
@@ -805,8 +797,6 @@ ubi_2-critical {
 		};
 
 		ubi-3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 7>;
 
 			trips {
@@ -819,8 +809,6 @@ ubi_3-critical {
 		};
 
 		cpuss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 8>;
 
 			trips {
@@ -833,8 +821,6 @@ cpu-critical {
 		};
 
 		cpuss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 9>;
 
 			trips {
@@ -847,8 +833,6 @@ cpu-critical {
 		};
 
 		cpu0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 10>;
 
 			trips {
@@ -877,8 +861,6 @@ map0 {
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 11>;
 
 			trips {
@@ -907,8 +889,6 @@ map0 {
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 12>;
 
 			trips {
@@ -937,8 +917,6 @@ map0 {
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 13>;
 
 			trips {
@@ -967,8 +945,6 @@ map0 {
 		};
 
 		wcss-phyb-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 14>;
 
 			trips {
@@ -981,8 +957,6 @@ wcss_phyb-critical {
 		};
 
 		top-glue-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 15>;
 
 			trips {

-- 
2.40.1


