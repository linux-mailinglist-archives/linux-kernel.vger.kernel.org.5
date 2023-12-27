Return-Path: <linux-kernel+bounces-12297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6AE81F27A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3251F22123
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDEF49F9E;
	Wed, 27 Dec 2023 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Blm0wOcc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7749F61
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d5f402571so8924575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703716115; x=1704320915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tK6odd1OtAVKiOdlxNNM68RkmR7ig1R/23WAvAxgt60=;
        b=Blm0wOccePPpXVB8N/zFnmMQWlTFTzPz6sTAkkEgiqXxXmPKrP+2fbPFl7oGOLOHAR
         ebUAz3GstHQKEVnNNB9JO+w7ddgn2GK2vHld5lvaiBxAohrPUoVcaXS3/AfvJlRlJrEM
         KqfAjRixns6qGJxb3h933QstokGdXnjiFDxXO+t624vrPvWveSVSPt+uwBULfZHu+rrm
         ESZvd04UWUr7sjvQLtHn4AhfStrF9dFJU8uhcFmRNfcdyOWD9y8YmJJbeymjXgy3XzdT
         4jWle++IjZlmxfOb3ypB9VP89EsgiqWIpZ7dI3qQVxl4L6Sh8nlzj4+GZ15bZdQ/6loH
         G2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703716115; x=1704320915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK6odd1OtAVKiOdlxNNM68RkmR7ig1R/23WAvAxgt60=;
        b=J0PuVdwQ/nAqfMctPXnmfktaNFMWVEU/+uUjGyVKSWPgxrTajUabQ7ws/8xXDg1ch0
         BG7v3HneToyvWfDoG+4m4h/zIKR/6uMDWE7opkoO+gV0AzWFX3Z3kWbbbT6GjSz2h4IU
         M/+dtYgNRM33QNiXvkSZ8p47EyW/bt+8RKOZaN85JHPsaSsS9CUJI/UjrulqTZ6/veAv
         6UQQlh4w1Yva1DPjPhEZG25VT6tuY1UqLTcDr2YdcXmQaLU8Yt1DKxy/xb06xR39K9Zg
         +8i7DsinJTvh7eTxnwV3PMeNymnEGeRJEobgWddy+50pbnGx4FW35filHHangh/q5FWT
         EvCQ==
X-Gm-Message-State: AOJu0YylGYqxYWuB0ZC1Yxi8mn/gNPi9msDslXeY2mL4xYgjPI5okoz7
	jIyxcXHyS9NDGWXSvPxcnZSikjjbBq2Ijw==
X-Google-Smtp-Source: AGHT+IEU/XUIqOL++xPi8/jutwJk5h4bHe8DFhWyvqha2kXnhOFAt+AX45R/bH+Cj4w0+Tdtu+nCnQ==
X-Received: by 2002:a05:600c:524a:b0:40d:5fe9:b374 with SMTP id fc10-20020a05600c524a00b0040d5fe9b374mr584909wmb.71.1703716115176;
        Wed, 27 Dec 2023 14:28:35 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id fb20-20020a1709073a1400b00a26a061ae1esm6854252ejc.97.2023.12.27.14.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 14:28:34 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 23:28:28 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: sc8280xp-crd: Add PCIe CLKREQ# sleep
 state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-8280_pcie_dts-v1-3-13d12b1698ff@linaro.org>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
In-Reply-To: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703716109; l=3813;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=wNNlr9q+wppYjS6msbjrsQS3RolKg1AY+hca/Z4U7jI=;
 b=qvq7xUeQksr7Wqrk/el2CPvZx9ZDK+mjMvIO6NWtJvxBebD4JEsJG5MRUsJQywBQ4No1d6d8u
 drvcG+ZKWDZB+kZyoUxuGcD2bA1JsYUTbQtbPJGX9VjDZf0OxLFEE2c
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The CLKREQ pin should not be muxed to its active function when the RC
is asleep. Add the missing pin sleep states to resolve that.

Fixes: d907fe5acbf1 ("arm64: dts: qcom: sc8280xp-crd: enable WiFi controller")
Fixes: 17e2ccaf65d1 ("arm64: dts: qcom: sc8280xp-crd: enable SDX55 modem")
Fixes: 6a1ec5eca73c ("arm64: dts: qcom: sc8280xp-crd: enable NVMe SSD")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 78 ++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index ffc4406422ae..58c0c2d10cb3 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -530,8 +530,9 @@ &pcie2a {
 
 	vddpe-3v3-supply = <&vreg_nvme>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2a_default>;
+	pinctrl-0 = <&pcie2a_default>, <&pcie2a_clkreq_default>;
+	pinctrl-1 = <&pcie2a_default>, <&pcie2a_clkreq_sleep>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
@@ -549,8 +550,9 @@ &pcie3a {
 
 	vddpe-3v3-supply = <&vreg_wwan>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3a_default>;
+	pinctrl-0 = <&pcie3a_default>, <&pcie3a_clkreq_default>;
+	pinctrl-1 = <&pcie3a_default>, <&pcie3a_clkreq_sleep>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
@@ -568,8 +570,9 @@ &pcie4 {
 
 	vddpe-3v3-supply = <&vreg_wlan>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie4_default>;
+	pinctrl-0 = <&pcie4_default>, <&pcie4_clkreq_default>;
+	pinctrl-1 = <&pcie4_default>, <&pcie4_clkreq_sleep>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
@@ -835,13 +838,6 @@ nvme_reg_en: nvme-reg-en-state {
 	};
 
 	pcie2a_default: pcie2a-default-state {
-		clkreq-n-pins {
-			pins = "gpio142";
-			function = "pcie2a_clkreq";
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-
 		perst-n-pins {
 			pins = "gpio143";
 			function = "gpio";
@@ -857,14 +853,21 @@ wake-n-pins {
 	       };
 	};
 
-	pcie3a_default: pcie3a-default-state {
-		clkreq-n-pins {
-			pins = "gpio150";
-			function = "pcie3a_clkreq";
-			drive-strength = <2>;
-			bias-pull-up;
-		};
+	pcie2a_clkreq_default: pcie2a-clkreq-default-state {
+		pins = "gpio142";
+		function = "pcie2a_clkreq";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	pcie2a_clkreq_sleep: pcie2a-clkreq-sleep-state {
+		pins = "gpio142";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 
+	pcie3a_default: pcie3a-default-state {
 		perst-n-pins {
 			pins = "gpio151";
 			function = "gpio";
@@ -880,14 +883,21 @@ wake-n-pins {
 		};
 	};
 
-	pcie4_default: pcie4-default-state {
-		clkreq-n-pins {
-			pins = "gpio140";
-			function = "pcie4_clkreq";
-			drive-strength = <2>;
-			bias-pull-up;
-		};
+	pcie3a_clkreq_default: pcie3a-clkreq-default-state {
+		pins = "gpio150";
+		function = "pcie3a_clkreq";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 
+	pcie3a_clkreq_sleep: pcie3a-clkreq-sleep-state {
+		pins = "gpio150";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	pcie4_default: pcie4-default-state {
 		perst-n-pins {
 			pins = "gpio141";
 			function = "gpio";
@@ -903,6 +913,20 @@ wake-n-pins {
 		};
 	};
 
+	pcie4_clkreq_default: pcie4-clkreq-default-state {
+		pins = "gpio140";
+		function = "pcie4_clkreq";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	pcie4_clkreq_sleep: pcie4-clkreq-sleep-state {
+		pins = "gpio140";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	sdc2_default_state: sdc2-default-state {
 		clk-pins {
 			pins = "sdc2_clk";

-- 
2.43.0


