Return-Path: <linux-kernel+bounces-162275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367E8B58F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CA5B240C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2527EEF3;
	Mon, 29 Apr 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="McpW5kVn"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A527C089
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394638; cv=none; b=gWakqy2phh62GJKL4pKzDI45LlyYUIHfYDah0Wm6QcWtBKSjCaLZm6nbSUKoclaotD0FfJjCOTwv/KO8gJaW8SqSCiLpSYMs91ETaUBP5DBHhLtDjdINWE3XysQN/r0iREFjgXy4p4fb3bQZNlHu74Sih7MIut+bHU9aM52T+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394638; c=relaxed/simple;
	bh=LK7Ctcd6RzL54uaHPMejPy+1++45b+tqteiPOT8tKcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMFCbILjII7ON+jCnm+zxvlhcW6Lulto/0FvvYpMfalluvMbUILCnKP6qbFRd2m3oYrCf6ONvJL/6eqIWI0U46HuIxdHSFhlHTnI1QXEUEjUAFPsD0McHWvkkxaKHeFqLTbs+vHHvwNrw15h42tNqtE9mkW6wE4DsJr0NMhS+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=McpW5kVn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516ef30b16eso4873438e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714394635; x=1714999435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOY5SzSul9sZ0JXY/XiYAvnKe9RLzyPFltZQ3GztXPY=;
        b=McpW5kVncmdYDIx6IvgKjqfNDustvGfXIcrwMhw6WhHgqfrK+pKJwGoPdfaSw8ulro
         0iSlImklfnv8Vrm3OLQx+DR6YujOvognHDQSQ6HqbNWsup9bMFaDSAt50lQC8aJDK4ON
         vb5UejQ5Mrd1JasLfeZH3nXxPRZ5OSL7yXnrH+1gQ9WtLyA4pN6/xy3A/gQ+g9iiUCsE
         wVqP94D6UdoZb0yhauvuaq58hDPAFqZIeuz76bw/aq+mqQv5m1T4O3d7qgPO4tzy0BKJ
         8tU05n/6RtdiBBKNjFlx4jaETwcLXKhyyq3OkCX1NfgMnSsKYBdrBpsIBW8cr1FZbcW2
         p/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394635; x=1714999435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOY5SzSul9sZ0JXY/XiYAvnKe9RLzyPFltZQ3GztXPY=;
        b=P5ljNiTR8zlBo+C24MFD47IAaIar+9wos6PPtGGlhUShB47EKZAZDZahSx0aWv1F9o
         9X/3qKSrvek7wOl7/bSPZ6+5C3JmHWF7CLfePYUixHZNPt33AMytXD8xfQur85IJgA2m
         +vxLb3nQbZvre8TP7FxvWbIEJ1U6jXPjsz+uPhsA2mfRhVg/wsCoOGLNSHhOFJ89cL1u
         StJIfTeCBvLyLkBTO88/MCcHVnzUgMGosYfT6Qb6Vkt7rpnqbKa/nkLpBWmmY2BKSPa1
         pJJb4XJ5zePQTAJx+WbO7MakgGCQg/jdbXvn/y0c8let7rnY7peY6ajfUNtTX6QiooFS
         aTqw==
X-Forwarded-Encrypted: i=1; AJvYcCWrj/smQGQ+A/bSOmg3L7ior7zrTj8AEa7zmZuseieUNATLi0vRNdfMc2wxOdsmcnq9EFREj5a9D3lIdXLMfN/6fWE6mvIvdd4m+RJf
X-Gm-Message-State: AOJu0Yz3WW19lwoLHCY3nOOK2VHzzVNvFFwWX/4bdOT85IQqtAMgD+om
	pVEYzoDFmY3xAY6GB85l/NYnhOXSniBaiBtLlgxy3fvyzhads+4Dv8FgnD5pNo6vboAHO50f1j/
	N
X-Google-Smtp-Source: AGHT+IFn5hC41vLvelPj6vdVIj3fwTZnutyqPvHDxZ6jl+l/tu+KdBq97m2w3o/AnQHCuTfI9ZWGbQ==
X-Received: by 2002:a05:6512:3d08:b0:51a:c207:12b with SMTP id d8-20020a0565123d0800b0051ac207012bmr7534206lfv.37.1714394634706;
        Mon, 29 Apr 2024 05:43:54 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h18-20020a0565123c9200b0051d94297380sm467538lfv.241.2024.04.29.05.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 05:43:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Apr 2024 15:43:48 +0300
Subject: [PATCH 11/12] arm64: dts: qcom: delete wrong usb-role-switch
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-usb-link-dtsi-v1-11-87c341b55cdf@linaro.org>
References: <20240429-usb-link-dtsi-v1-0-87c341b55cdf@linaro.org>
In-Reply-To: <20240429-usb-link-dtsi-v1-0-87c341b55cdf@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5376;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=LK7Ctcd6RzL54uaHPMejPy+1++45b+tqteiPOT8tKcA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmL5X/aU9hXN91FuteM+0Xv3KuVW+d8/LeIihAu
 KlvO0WjYweJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZi+V/wAKCRCLPIo+Aiko
 1ZX/B/9IaKN/gnDntewUSImAIvBRvjeUbGJnpP/AY7Ml0PY9cj58xf7cSi69vMFZtOn2mut3Esv
 DFeWGh9QTr/dJ4EZjeJ8ueM8UTbptDfWpxBR4oi4dHmja+3rzbGcssAacuVvSQ4R1Q4Lq/PowlC
 PpzBAJpw3oBUj7Mnz7n2kgnxkZIqhAh2mHdTyg1MSSb0h2b8sGcZ9Qe03uVIum0LzYahMaR9LXE
 4+u96nee4beK/QEtYnHFWsYlx2gXG30uFbD0SCOhS++KZ++9nGhl/l/cvqQcnivWJvl33bnxAdU
 KvqJIDZQoEQ19DppyNFMp0LX8jvwAuSFLsUAuKuUnXarYknS
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The usb-role-switch property doesn't make sense for the USB hosts which
are fixed to either host or peripheral USB data mode. Delete
usb-role-switch property being present in SoC dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dts | 1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts    | 1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts     | 1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts   | 1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts    | 1 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts             | 1 +
 arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts     | 1 +
 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts   | 1 +
 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts  | 1 +
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts      | 1 +
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts    | 1 +
 11 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dts b/arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dts
index 711d84dad9d7..2edf804eb7c9 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dts
@@ -301,5 +301,6 @@ &usb3 {
 };
 
 &usb3_dwc3 {
+	/delete-property/ usb-role-switch;
 	dr_mode = "peripheral";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
index a5957e79b818..336b916729e4 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
@@ -321,5 +321,6 @@ &usb3 {
 };
 
 &usb3_dwc3 {
+	/delete-property/ usb-role-switch;
 	dr_mode = "peripheral";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts
index 6b9245cd8b0c..bdf1bfc79c56 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts
@@ -326,5 +326,6 @@ &usb3 {
 };
 
 &usb3_dwc3 {
+	/delete-property/ usb-role-switch;
 	dr_mode = "peripheral";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
index 9ac4f507e321..fccb9c4360ca 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
@@ -322,5 +322,6 @@ &usb3 {
 };
 
 &usb3_dwc3 {
+	/delete-property/ usb-role-switch;
 	dr_mode = "peripheral";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
index b0588f30f8f1..d46325e79917 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
@@ -357,5 +357,6 @@ &usb3 {
 };
 
 &usb3_dwc3 {
+	/delete-property/ usb-role-switch;
 	dr_mode = "peripheral";
 };
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 47ca2d000341..27de7cf31c83 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -667,6 +667,7 @@ &usb_1 {
 };
 
 &usb_1_dwc3 {
+	/delete-property/ usb-role-switch;
 	dr_mode = "peripheral";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
index e27f3c5d5bba..a288d52fb6d7 100644
--- a/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
+++ b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
@@ -248,5 +248,6 @@ &usb3 {
 };
 
 &usb3_dwc3 {
+	/delete-property/ usb-role-switch;
 	dr_mode = "peripheral";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts b/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
index c82d6e628d2c..2f55db0c8ce3 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
@@ -287,5 +287,6 @@ &usb3 {
 };
 
 &usb3_dwc3 {
+	/delete-property/ usb-role-switch;
 	dr_mode = "peripheral";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index 2c7a12983dae..9153a5a55ed9 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -240,6 +240,7 @@ &usb {
 };
 
 &usb_dwc3 {
+	/delete-property/ usb-role-switch;
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
 
diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
index 98eb072fa912..4a30024aa48f 100644
--- a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
@@ -234,6 +234,7 @@ &usb {
 };
 
 &usb_dwc3 {
+	/delete-property/ usb-role-switch;
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 54da053a8042..9d78bb3f7190 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -359,6 +359,7 @@ &usb {
 };
 
 &usb_dwc3 {
+	/delete-property/ usb-role-switch;
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
 

-- 
2.39.2


