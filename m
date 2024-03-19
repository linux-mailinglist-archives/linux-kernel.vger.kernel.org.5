Return-Path: <linux-kernel+bounces-107807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AED8801EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C15DB2248F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF3B86ACA;
	Tue, 19 Mar 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="toAw4Bzm"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858648613C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864846; cv=none; b=gy7JcUX1/toqlJb6EdnUzmoVsd/BfLaDTLnqHALmXltPRglhn2HoWQVhnigIOm2VoIKyPqB6hO9bn13HldrdBul1euA2Y2q9tUljqT94q1rGsFSAhAOaPdqpI79o0m/n9pYw5Mp1lXmtfqGDTdWoeBQkVxbx2fGblipsc7qRZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864846; c=relaxed/simple;
	bh=T0AMd595+W1sDBZ4qDqfxuerOD3YhbiZuI1wj+Egzv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KB8U0fOn3rvbn5UGxBT/4/7edc/vA5hg3Q1F1YKvJi5zR2CmiomVOg6ldfnfsNTCogm+eFjX/Daq1cyYvvMC60nny2D612O1SRlAsACxs9Qsq/J3R5XGAmrXYVDdh+SLRLjUCeVIBxic1KAKjzUa0HhfiEZBEbSKJPiaG6h30zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=toAw4Bzm; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513cfc93f4eso6503462e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864842; x=1711469642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFUKOQmXWTLWdjtaov2aUjztp6b4X+go7eRh8s9UnHk=;
        b=toAw4BzmRm9eWWOKEWD8kBGc9D0w8hCgdRGRnhFIqKy5DtB6l8NjKobaI5aVIhIfM6
         Sk+A4Azs4PR2DYGTrQeG6pYcGwv8yEt82JKv3sUcS1p3/ZHlBMp4R/tUHsNpRdT28RpW
         y0uKNk1cWvFGG+2p+3GodUeN+pG8fz/DAmZE0lqIr7J6gfrJN+8qh+1xfN2M/90zKbPY
         y3/Wv0ajb6RmCoiOqWv8yJfiNkHbDTSCnWENxpQwk2Alf6R5XmOaoFjJMquKhJgykAjE
         dsQyvW/T5gFduq4FdDWkpkHE729y59INzr3SILh+6eu54e8NwhFVvlc2n7ynilwtSQ/P
         eOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864842; x=1711469642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFUKOQmXWTLWdjtaov2aUjztp6b4X+go7eRh8s9UnHk=;
        b=gRwSQJIG7MiF9PdC4p5eQVN3/1r+dDDqnTDLCsVXbQ10TcmfZ1htdSJyFpl6PrUSb6
         EmpvUYuCvaiKGIhprgdotGrsrYxkj4rCmvdMdvn7FHL/q87oV3GM1YMON/U+vSEhTAzV
         oYWS2ZVYEr5VBWusi2MP+HtNswXcVNglhV3ZB/8Gm6Abt4fPwrfMsMClvRtTaSQLNr3o
         cxAXF/JRzl0bXIPb7yS9SB0d+Uu3dz5ZZLKy7SidefSazkoMoE3nEy4yLeDDiNGnRbp2
         rf3u07RkRT1DXzoStVi2U354aW1keHRP4FhcLDi3qSN1guNEE7FAWFYqhX7AwnKpLEKk
         sI7g==
X-Forwarded-Encrypted: i=1; AJvYcCXiXWZ58LDgvS94WCF7SjOxuRI+gVBioZK6Lo9vsKcMSyVtjluthOhTHEz2fwZieuIeNT/OJCrWv87Rtz0BXhJjDn+pF7IaMI4vwEda
X-Gm-Message-State: AOJu0Yy6VOK29jFlDJmrSFSVxStIoErVz/8YePdahR3tzWLEII13jaMQ
	9vVq65YrTQKocL/0ANm8ZVhl71pu/hB5wQOEqTkaoZdT0TGCsxgSvmSXFlc7lsc=
X-Google-Smtp-Source: AGHT+IEvECGMkclgL7HfDaZoY+kI+4AjXLi+FOv4w3hDzPRZ/xHz5uLc5WHnzIsltONPG4EerYCTUQ==
X-Received: by 2002:a05:6512:280d:b0:513:dd43:a153 with SMTP id cf13-20020a056512280d00b00513dd43a153mr10968746lfb.59.1710864842687;
        Tue, 19 Mar 2024 09:14:02 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:14:02 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:53 +0100
Subject: [PATCH 23/31] arm64: dts: qcom: sm6125-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-23-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm6125.dtsi                         | 3 ---
 arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts | 8 --------
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts     | 6 ------
 3 files changed, 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
index 99369a0cdb61..b92f357511de 100644
--- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
@@ -9,9 +9,6 @@
 / {
 	thermal-zones {
 		pm6125-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm6125_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 08046f866f60..dcd05f303b78 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -90,8 +90,6 @@ cmdline_mem: memory@ffd00000 {
 
 	thermal-zones {
 		rf-pa0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6125_adc_tm 0>;
 
 			trips {
@@ -104,8 +102,6 @@ active-config0 {
 		};
 
 		quiet-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <5000>;
 			thermal-sensors = <&pm6125_adc_tm 1>;
 
 			trips {
@@ -118,8 +114,6 @@ active-config0 {
 		};
 
 		xo-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6125_adc_tm 2>;
 
 			trips {
@@ -132,8 +126,6 @@ active-config0 {
 		};
 
 		rf-pa1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6125_adc_tm 3>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
index a49d3ebb1931..994fb0412fcb 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -84,8 +84,6 @@ key-volume-up {
 
 	thermal-zones {
 		rf-pa0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6125_adc_tm 0>;
 
 			trips {
@@ -98,8 +96,6 @@ active-config0 {
 		};
 
 		quiet-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <5000>;
 			thermal-sensors = <&pm6125_adc_tm 1>;
 
 			trips {
@@ -112,8 +108,6 @@ active-config0 {
 		};
 
 		xo-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6125_adc_tm 2>;
 
 			trips {

-- 
2.40.1


