Return-Path: <linux-kernel+bounces-107784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4A88801A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F63B23D01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DF6823A6;
	Tue, 19 Mar 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brvYlci3"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DA81AB3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864823; cv=none; b=mrHfpOIMFNbD3JOJfiOZB/Dbm8Mt68Ep+E1esjY9YSdGgtmXXF07wGXsR6bWB9k/WEZ9OMfMf/DIn2kc9dt60T+2YoimfbeOn8NotblT47MC04m46wD10kvFhH8oWv8dyzGuCHV3ieHO+WlIRN3RLfcij+aAjab4u6Udi3LoLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864823; c=relaxed/simple;
	bh=k8lnyjg65wL5etJQYY5aU0Vd22mGTE1lhYSWDl+Scgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HasLKOPmAkUiN3XU7ekWiAfb1IkCtFjR1WDhQUjQ1s+Xaoxdt1IBiR1DUb8Mk+ZFU+7GWC1lN2rm7f6WZDUoqdCHf7qcBuH3I3rE5EQmfVk/WqXuEECRmShZt1ddjetEbT/5sc+hZ8Eb+3kwocwiGHDIhwyZG7VxIuBFKR2ablk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=brvYlci3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513d4559fb4so6995893e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864820; x=1711469620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OicwjZjP5RidZKnqT+PRFlgcMM+RvFHnxHBQjXeoNE=;
        b=brvYlci3zCiHWMpu6XhPUSTyRLJ59r8BqwJK3r0Gn/QHd97MeHN/hBIk4pE4heAgRi
         zYSq/d6mc3YwVvzkOVkjLIUnU8GKxpuVLcj4MBYvqazazuwj+vWUkkpXr/h90uRhRqYa
         iJ3bLNy8EQf1pFsqju1ugwfQzP1aEUamFkdpyEgAGiSmnOJgq7BczFLJIdLXlpL/Y9lP
         qDPhT6tfmmf32SKgnfSqdoXAZkr8+LMW07iJ3Y0IXsRAM8vT6zzCFmbQIrbRSFMYH7jr
         E/8O+rl2Zdp5TyrquUKrYzZdI6zHrew7UeY54/Sv33Bb1L5CbtppFqNdukMoFK0aXxbO
         RpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864820; x=1711469620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OicwjZjP5RidZKnqT+PRFlgcMM+RvFHnxHBQjXeoNE=;
        b=MH8OZZLw5CPkf4PjiHKYnN/YI4G1DanrugAe+BY4xQi+Rzv8JFTUuGE7hrIMngD+8G
         GHk6+jOj/hWZqqmDEIm2n+9e0aPnhSZkIU/lQBqruri/AI6wM90seJHrF5StW5rPt8LY
         dUFD/7vREI+oZX+zRHZnobr5qLI1HYH8oWoUfNrWJvU+WhRwnXUIk1LkOtS00Bejv6O8
         LVi62zWOkctOl29+OeXxfh3XGSqZkYSaZC8ty2OyBEt5oHF+aPKqpc2Jl21iQonVbDKp
         v9VQRrJtVJhQbw/h/ow0v33uG8CM9DNPgrsi+bRtdCVT2u6qMFQO2Z9v+E5hEUn2OdLJ
         e5YA==
X-Forwarded-Encrypted: i=1; AJvYcCUZDHeYdqao6MKCPB0BtPgWOpkZD3QKNA5bLuXrSeeRuxqbuvnKFujUpAmMCd6JE/xYeLhpIARC0q+7B7YT1qljSIs/1d8Xxta3UZpM
X-Gm-Message-State: AOJu0YwtAXuZV7CEZEFrhzOggTNGeRfohxIiGwEqGoYKa7SjTwXBS6ur
	eq/6vAHzF4r6IJpNWl4TRARTO/9IeIYPN+YRJv2hXfHlsGpeqheck6Lo1oy7Bv0=
X-Google-Smtp-Source: AGHT+IGV+ykXLPbUP4WJZLNYwONutSZZLeV4SkkuFmnHc91t7astVEHOtCiyymAmSNisXXVQDSxKmQ==
X-Received: by 2002:a05:6512:360d:b0:513:8a39:e0d9 with SMTP id f13-20020a056512360d00b005138a39e0d9mr2067139lfs.64.1710864819662;
        Tue, 19 Mar 2024 09:13:39 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:39 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:31 +0100
Subject: [PATCH 01/31] arm64: dts: qcom: ipq6018-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-1-e0aee1dbcd78@linaro.org>
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
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 4e29adea570a..cd0ee133964d 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -912,8 +912,6 @@ pcie0: pcie@20000000 {
 
 	thermal-zones {
 		nss-top-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 4>;
 
 			trips {
@@ -926,8 +924,6 @@ nss-top-critical {
 		};
 
 		nss-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 5>;
 
 			trips {
@@ -940,8 +936,6 @@ nss-critical {
 		};
 
 		wcss-phya0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 7>;
 
 			trips {
@@ -954,8 +948,6 @@ wcss-phya0-critical {
 		};
 
 		wcss-phya1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 8>;
 
 			trips {
@@ -968,8 +960,6 @@ wcss-phya1-critical {
 		};
 
 		cpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 13>;
 
 			trips {
@@ -998,8 +988,6 @@ map0 {
 		};
 
 		lpass-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 14>;
 
 			trips {
@@ -1012,8 +1000,6 @@ lpass-critical {
 		};
 
 		ddrss-top-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 			thermal-sensors = <&tsens 15>;
 
 			trips {

-- 
2.40.1


