Return-Path: <linux-kernel+bounces-152982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A274C8AC711
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3069D1F21CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39FE44C84;
	Mon, 22 Apr 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXJ+saew"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33439179AB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774799; cv=none; b=qyXv0/hmdygGd1BPtaqvpxVILlZ/eeMEYgKXAmuuZyl3B5Sx7YbiDYOHNHLK6l4wkErZkyONYIyAACVOLgiRtNK4BQUcKQqqsLTVrQlL7rQBAQyDppAHMc4v9QjWHrXiGR0Xqmc5YYNS/uIoXw56p/lhOr6VAqRHGjb2Eya55ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774799; c=relaxed/simple;
	bh=/XAPDMkZMT1mZ9FOhnEUgwml1nugoL+UQJKgB4y595o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nqb7AF+6Sj9kPFBOdbfVAuEIW500Mb7kdSwbgkk0s0XMtaDicbUlmurQ6+QoZZgx3EC7wP0dPm9TrcaT00xX92irf8br7J31Vqs/EnIc9zDBx5TRGY5x46jAJWdHHZVHMFpvHpQrVVUU2uAZe038xhchyUwosfVT1MUkgbJ/zXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wXJ+saew; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a5b68ed5cso5868935e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713774796; x=1714379596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+2buCEoaK85v2L3RrMSrTLmmbAA6+KMzzn+JIjinZ8=;
        b=wXJ+saewc48YfF2sQBglG+JKFHi0WZnE5DLIKEAymsZPFw0YAAeYJeP0neJdT52Ngw
         9p+bx3WuAidJEPMEpy+V93ST2bNn9ZUJ1AkvfASgkC92McWzVQ/HNtR2usIaDcwX1y7y
         3mMrCj0pmw4vjpU+eBor7w80xaDEkUX60tOpo8vtqgjncXrGe2Ylr22GAQH4Op+hAI7s
         a44xcoS9iJJUWOWrH/ivNCTmEouZ1c5HHJ3VxZEc/GiTpN7XKfWPtOi/bTjQ/t03SbZy
         zSzr8XIpHXmrukRYT+JCxOJGewyB09JToft3WhIuNs57nTfq3rUGET5cA++FewbQu0CO
         4fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774796; x=1714379596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+2buCEoaK85v2L3RrMSrTLmmbAA6+KMzzn+JIjinZ8=;
        b=WNSyIMW9K84aFXTORc43vojoVkUrTb1ELETM7ymP94FMYJ9Rmnj8kMEfUMKqzKs0jB
         2otldcLj9oce80Eapfozk2kK2UywqhHQxkoeEYvmvtV36jo7RNwcEmGCX4+rfNRSg+td
         v20YRAOUoi67wWJeuJfZc2QAeaHR6zgE+BGF5HHnZ0mlQk2ow3DBYLmpWUgNydOxIREp
         iHonDxA50v6xUiP7NEg/Z/KP/PFWB5X5F6HPgBamShx+7yxFButKKMFcUbCtOY8lrkma
         QyNoGjf7Tfmrr4ZyjYwc7zHFwNcplAqNEY1TgePUaByhm+5aPk/uDC9AgmMWqlLBJE88
         ROnw==
X-Forwarded-Encrypted: i=1; AJvYcCVQo8/auKldl05iYmp3JDgb2/Zsie0gUD+xw6c/Jb6wpwg5Ao9qi8F6WudCU8/EDF8bwvCLbE9UY8Dabdz3ILWz1WyBIDKYeU0rTBkS
X-Gm-Message-State: AOJu0YyAWGyCuuw6XnDQMQXFk8QpbGJgEbDLZF8KK3RlxmP73B1vXXIm
	rLrkSL6/bUX39a7UFvntQvtdmJZmJXgTbHiYQ14zGGvsBSRb/ZlRR+7R6BFODO9q5XA87GoudR4
	rSx4+NA==
X-Google-Smtp-Source: AGHT+IEgr7AtR5kDCO971CSg++/mcgo/iZQ4+3qL3bk2pCiVRwD9RxQhUdjpZ8H7bWEG/ngb4hoL3w==
X-Received: by 2002:a05:600c:3ca1:b0:419:f3fa:23ef with SMTP id bg33-20020a05600c3ca100b00419f3fa23efmr4167711wmb.25.1713774796370;
        Mon, 22 Apr 2024 01:33:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b004161bffa48csm15978786wms.40.2024.04.22.01.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:33:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 22 Apr 2024 10:33:12 +0200
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8550: remove pcie-1-phy-aux-clk
 and add pcie1_phy pcie1_phy_aux_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-2-799475a27cce@linaro.org>
References: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-0-799475a27cce@linaro.org>
In-Reply-To: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-0-799475a27cce@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3193;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/XAPDMkZMT1mZ9FOhnEUgwml1nugoL+UQJKgB4y595o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmJiDIRKeRNA/WDMhtnMFoRtGB8wJy8e0uRvk3OXyG
 7dOOQ6uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiYgyAAKCRB33NvayMhJ0UCAEA
 DHUtccp5Zt/hmVIaWMrasPeto2TCrvaYT0N62I/nfa2mUnUa9eu4WBOkhCSi6d8/Gw7YEp7h1KM/6u
 1r0ttUSYdNtXIUPWG56Ku02CxF7rKMnAXo4qUoBxzZTNKa5vbzYDmZcwdgnTGhd6zk2GJXnjMnuvBv
 j8IzzPu9caCfKfylSj5GXCRmCW5erg14k4fLx2OQa6In6eUdTvErnHItUcXeNxmjP88p199tqMCvGi
 7XR3m9i+j4GEMrDsHi7jzwZLRYIZAnWHR/PuuT7RdpTsihkOUzv+qiutZF6faQ9JINiaB7kJAHA270
 XSuqygZS8QWuUXl9kppYb9MGpKVM+IeRuwbENpokKVy/B9Yb9VcaffRQ4RJ6++UhLerxRoLMCEfYj1
 QgskyRD5mOQ5RG8NHQyOISXbYDKhdC6v7DJUz9knCOSCkMwkYT+kumwSkRrnnD+PkwpHd71VxYMUX/
 KbNb1/RZBq0pRKtwjSue9cTHSnb7RR05CID3EnHqI5zEol1i49aqGY/HXisVYfRdmmUfjYZactTJGA
 LFmKD5nE310+AFayyB4E3yB691YQ5g2qZSij3qcR71ubCadyrKJmv7xRiHwIS0z+kehIHqWT37rJEI
 542qa/74ktuBev/tL+3EkWXPkJvb2+zKakR1p99tN55rTMCg0jHEM2lUez3g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Remove the dummy pcie-1-phy-aux-clk clock and replace with the pcie1_phy
provided QMP_PCIE_PHY_AUX_CLK.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts |  4 ----
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  4 ----
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts |  8 --------
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 13 ++++---------
 4 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 12d60a0ee095..ccff744dcd14 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -979,10 +979,6 @@ &pcie1_phy {
 	status = "okay";
 };
 
-&pcie_1_phy_aux_clk {
-	clock-frequency = <1000>;
-};
-
 &pm8550_gpios {
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio12";
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 3d4ad5aac70f..1fa7c4492057 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -739,10 +739,6 @@ &mdss_dp0_out {
 	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 };
 
-&pcie_1_phy_aux_clk {
-	clock-frequency = <1000>;
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 92f015017418..da3cfa697969 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -810,10 +810,6 @@ &mdss_dp0_out {
 	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 };
 
-&pcie_1_phy_aux_clk {
-	status = "disabled";
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
@@ -907,10 +903,6 @@ &pon_resin {
 	status = "okay";
 };
 
-&pcie_1_phy_aux_clk {
-	clock-frequency = <1000>;
-};
-
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index bc5aeb05ffc3..143994d1e6ca 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -58,11 +58,6 @@ bi_tcxo_ao_div2: bi-tcxo-ao-div2-clk {
 			clock-mult = <1>;
 			clock-div = <2>;
 		};
-
-		pcie_1_phy_aux_clk: pcie-1-phy-aux-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-		};
 	};
 
 	cpus {
@@ -776,8 +771,8 @@ gcc: clock-controller@100000 {
 			#power-domain-cells = <1>;
 			clocks = <&bi_tcxo_div2>, <&sleep_clk>,
 				 <&pcie0_phy>,
-				 <&pcie1_phy>,
-				 <&pcie_1_phy_aux_clk>,
+				 <&pcie1_phy QMP_PCIE_PIPE_CLK>,
+				 <&pcie1_phy QMP_PCIE_PHY_AUX_CLK>,
 				 <&ufs_mem_phy 0>,
 				 <&ufs_mem_phy 1>,
 				 <&ufs_mem_phy 2>,
@@ -1928,8 +1923,8 @@ pcie1_phy: phy@1c0e000 {
 
 			power-domains = <&gcc PCIE_1_PHY_GDSC>;
 
-			#clock-cells = <0>;
-			clock-output-names = "pcie1_pipe_clk";
+			#clock-cells = <1>;
+			clock-output-names = "pcie1_pipe_clk", "pcie1_phy_aux_clk";
 
 			#phy-cells = <0>;
 

-- 
2.34.1


