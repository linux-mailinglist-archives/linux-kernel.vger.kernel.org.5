Return-Path: <linux-kernel+bounces-166086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC84E8B9607
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFA01C214A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66783D57A;
	Thu,  2 May 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLyB+JqV"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED428689
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636846; cv=none; b=giuOm5LFSKazhyShDZAkcHmR5wGcCxe8irlVk7EsVNTUn4+HJk11hwnJEHZUgA1KRCZrZXO0XTcG/GYzR5fLxETt0hSvq1QDzH/TSOUkEbFLjas7KRXTJMJMSEQgKhZ4vki55VCVXyPyISayuu6OXT5sorxryT7VJpLpYQKRY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636846; c=relaxed/simple;
	bh=3ZGMHJGirju68C+Mp8vVL2ANcwk1wDJ7jGZIfCJTjeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e6C/TXCnxzZn+GcB/ttexR6pYfNf/vcGFciolH8DfOpGKtCdb1BYwlx2spdx+XD5RY7nSgWue/T5xJcrD5KGlPIHXtj210OaVhLMWKjIvMUxuWWjMTCaaePJnq7iuIT+v8g321HbmWzE2u+BYsx63rnkLp2oQyidCjrFQo/T7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rLyB+JqV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41dc9c83e57so3054865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714636843; x=1715241643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqbO5YYdNpMbTQN8YkVtjQ7lY5CMowFcTiU4c3ibltA=;
        b=rLyB+JqV9f0eZbukjKmGnky1eSDftR7DxOIJfNlqCwhtVFxxWei/YN04Ck7Bm5ZyJY
         NAvZ7PKROs7CHIlcmcRwP9Ew/p4FFnIH8E78HaI3GhyXv1Wz1/01/1Om/5ZzXmBnLMqB
         JVfOKX6l3rVJnYfaSL3SssXw8CZ2HCqU4+n1UYW/f3ugb8rT1iKgF1ndGGwnvn/P3I9r
         DsvAW/4d2dFvcliyG6mEVW2P+sAYVbGNPLlNoc440Rl32jTsOOH/o4xWfoHlVIA8/gXv
         eVBJ67n2jbUEy1e9kPtjMrI+R9PcFM0osxvAup3yMxFNXm3EA2Q8b1oU5ny5afXggYiB
         sIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636843; x=1715241643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqbO5YYdNpMbTQN8YkVtjQ7lY5CMowFcTiU4c3ibltA=;
        b=ZRrS8J59IsXxeaK/cbKps54bt+b31w5bi2ALoqsl/pu+zHCIsbz0QKr3vs2vuqO2H5
         wZ3kLEX/MyRatAba757W7ytnaa7yOkHQHNSUxSaDmSr7DUqn+2SV3sgP8iN8U9LHbwYv
         ZmH5JitFCsMRLDGY8VDQdtgOF+/KxmbetnDmuxHLsy5LUaWDeccxlsgfzPerXeMZc4He
         nf4HHKhlYKR5jE6JdXK4VPgbGk8ak3WRSh5GqFf3VuL7yiiAyzNmo6wImfcSIc/YkyTc
         R9trPZcR5EIUqm2nZMvWIClaLWtxAuBduXCxoPbSXb8Ah1d112oyPfTTgSFrKDnDoGDq
         RVpA==
X-Forwarded-Encrypted: i=1; AJvYcCX0PEGKh6YEdKbCwdYWXuGgBYUWCsfVNnei92w8EQ9FXsDTYZok+bRS31r7nODxpBjnDPqOUvoZ6uOlhYF6BgQHFCX6yxBlHlcJktMa
X-Gm-Message-State: AOJu0YwqY+nMybM4qS1/+AhTBGzKcjQnj31uvnNJg+O2uuDajHo07uNc
	rprAovKm/tQ9CrWaGJ//1LMe1P525KNyrqVOiaZ23yMwKH5AjJ13iDJcjfAEcy4=
X-Google-Smtp-Source: AGHT+IEIBA4qejy6AcqRq1KWD1O/ysKS6wKyKRQS6hQp/h0r/X7G+fn6ZKbepr3zL0ki+eOCDftOzQ==
X-Received: by 2002:a05:600c:45c5:b0:41b:4506:9fd with SMTP id s5-20020a05600c45c500b0041b450609fdmr1563905wmo.6.1714636842726;
        Thu, 02 May 2024 01:00:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041c02589a7csm4806597wmq.40.2024.05.02.01.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 01:00:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 02 May 2024 10:00:37 +0200
Subject: [PATCH v5 2/3] arm64: dts: qcom: sm8550: remove pcie-1-phy-aux-clk
 and add pcie1_phy pcie1_phy_aux_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v5-2-10c650cfeade@linaro.org>
References: <20240502-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v5-0-10c650cfeade@linaro.org>
In-Reply-To: <20240502-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v5-0-10c650cfeade@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3ZGMHJGirju68C+Mp8vVL2ANcwk1wDJ7jGZIfCJTjeE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmM0gn2GJoWpdjBdGppb8wsgezAlhh94idWkN2tUr6
 dB2qxWeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZjNIJwAKCRB33NvayMhJ0Yf7D/
 9eMQsyvRHsbity27GNiq+tCoZhfuPWKpXtv3cZ/YFkKHtQBQFq9RlNQDtITNanhcfKoz9ORP609bJd
 DebQm0W3kDOcQ9BUANRaDMG32sAa1dMwWV523ffmFSlvdtKwEVUhwdDTK5fZuz88EEds5bb/QY5c3g
 Fq+50jc8UI907/C9WSgxei3EJlB1pTwmVDnU9fMNh3OM0g7AI/g/8zKXHaXpWNu/GPdd6HebfAHV5v
 R2bfYMOatTrOgMYdOcnF+JlM/gsai9O1RpE+FJ+rz+3OtZdpSEhQAlRLEg+C/0fkHKdh9iYpARyahv
 TGS6Fjdv2YdepgG+RFWfHwBa7grriUB/Yrsl6uMtaAiM9wvUeKwaQbXTLQkxC1GqdN+1vZHTwR4QDH
 crjHf4bi6VbMV3Jgq4fwGX/3lmDiNvNftkgPVxR2Z4PX3FI8tZUWsFp/a/FIQuHlkru8JJDYhdekNg
 fHBZ/zdqfjSxQiyEnHv5wIzR23YXtu72U1bzsR/vvYFQKFVP3SUyxWaCgIOM0idMsWnOlzMTBFZM3j
 KhVEULMESVitcHOundmc7IZuIQyL0VBgcSSWok8NXwJCgyAkIuibVEZiDT/z+faRop5P+i0Z06kTmX
 sX5Q8yl8KO8CIzcFpJreb2sc7oVHwY/Zbg6GNHAK4akPRm+EPxxSwD1OZgxQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The PCIe Gen4x2 PHY found in the SM8550 SoCs have a second clock named
"PHY_AUX_CLK" which is an input of the Global Clock Controller (GCC) which
is muxed & gated then returned to the PHY as an input.

Remove the dummy pcie-1-phy-aux-clk clock and now the pcie1_phy exposes
2 clocks, properly add the pcie1_phy provided clocks to the Global Clock
Controller (GCC) node clocks inputs.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts |  4 ----
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  4 ----
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 19 -------------------
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 13 ++++---------
 4 files changed, 4 insertions(+), 36 deletions(-)

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
index 92f015017418..39ba3e9969b7 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -720,17 +720,6 @@ &ipa {
 	status = "okay";
 };
 
-&gcc {
-	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
-		 <&pcie0_phy>,
-		 <&pcie1_phy>,
-		 <0>,
-		 <&ufs_mem_phy 0>,
-		 <&ufs_mem_phy 1>,
-		 <&ufs_mem_phy 2>,
-		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
-};
-
 &gpi_dma1 {
 	status = "okay";
 };
@@ -810,10 +799,6 @@ &mdss_dp0_out {
 	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 };
 
-&pcie_1_phy_aux_clk {
-	status = "disabled";
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
@@ -907,10 +892,6 @@ &pon_resin {
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


