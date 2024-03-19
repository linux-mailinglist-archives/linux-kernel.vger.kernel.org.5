Return-Path: <linux-kernel+bounces-107409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B4E87FC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D5E1C22052
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFCD7FBC1;
	Tue, 19 Mar 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKBiRhDY"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D97F478
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845089; cv=none; b=B7ZcW1JYJRYUHECrR5t9XcBGkH8FARVu7fnpYP15lRCn2OcEqEffgmZQfcUiX3ovk2GUlB9+mJRSEeoAulGRhK/lKoX5v+Mhw+Xkr7ehmHbwfoWdyY8VIz2kg0RoyNme9yUUPjqfbGwHttxzhPMtItx5xoHGE52FQ+TtVNN3eio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845089; c=relaxed/simple;
	bh=tPydKqk2YSla66EnZFuqclyzKir7dE9KK2iKURNVrUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4yNSAw/hzhOKGo9Pvl8gXXAGQ1hLeLMTqmHnfr/8KZBWRUJCO1utnWNjFVAmghoTqT4MjSjhoqW1VQA3DOmzQB1eafldjWmA6BKBrRSdJvzcyZYutGQscruPrrwFdaA50lN6kiYIjw2Fpm5H2zn3Swkt1uMRw0M0YP0tek0648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKBiRhDY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41464711dc8so4221415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710845086; x=1711449886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcCFlDSNEFtoMH4ZYLS7c8L9gm9nhZvpG39nlVIAzsM=;
        b=QKBiRhDYRrjSww2nsoBNfdSY8/koJfsEK8XZCWo02G+LrzadgaqPDEWzQb7JX6Oe20
         zNhpntU24Y6QQkFU7MFNfmSv/KJcEM6a6W5FzOYthvF3d3E71SJgEYXGIOY3jOpIO5u8
         4UbHlKHpBIyHQmyH0czcPz7RzaMsP11Tfg9i/mvhFQaMSpe7eY5Jyeygl7adAYmmYMdr
         jnfiCiYJDWqYDlMtixDtinNHwPTgIVHJRI/PDVGWDxDmBSQl2F5QL2kcX3sbfrohRS5/
         xb1IagS7xRwDCWyEl+/t/hXmtUh76Z8Yu2mOucCijveCn3CcOGVG9nB98tK1Ri4v08mx
         s7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845086; x=1711449886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcCFlDSNEFtoMH4ZYLS7c8L9gm9nhZvpG39nlVIAzsM=;
        b=lj1i9I21daer5OagKJw4keM0Rweb4FqlWPFkywTnaQIQMiyW1y9KbVAyHJVMMpA2OS
         om79OgipwS+rfCUcnOg02wDRIYwlnFY0oFdsXN3LNHDItmJC5nmrCBgfrhLJCJSxoecV
         voMqDMmB3+Kg+vAtrJRtydjDVhVnwJsjj2R2eSSOks/swCxEdRS4RZN4sTARLW4RW4U6
         ZjIZpoH7AfgowJRgiAnIVIOF1OqmLjsqY/g+6iF6mfUcsIZTmd5JPaYmrHnSzMQ6kT3U
         DZlnS2lxxBK2IeS/VkSyEkFQjupCe6yna5d9Ooz4Jk001fei/dcAOpCJmvDeS/vXs/E3
         6lNw==
X-Forwarded-Encrypted: i=1; AJvYcCVyBvwevFp3OcBb4ronpiXUIF4fouyzSBEPTqcJm/u+bEUwcKpOaIyhyFs/vQeAt3KaUdW/cgPj81cjq1/mO9cTy5OdBM5Z5fRsO7z3
X-Gm-Message-State: AOJu0Ywfn/qKJMKxJoHGYeVeeLGPYilBp3AZiFN9XdEXasfVlOr3x92H
	8dzF6xHGOw2Hf5p13gGK2PlK4T5Q/YbwUrmzg4bmKz7AzYYBgB/btrdgnczseTA=
X-Google-Smtp-Source: AGHT+IGgC3joZ9SNi4vPETCkXKlOcafq5dmogQJtOOsU88NpKN/dbbbiashGUrT444nIasUFcRj9aw==
X-Received: by 2002:a05:600c:4e93:b0:414:22b5:c32c with SMTP id f19-20020a05600c4e9300b0041422b5c32cmr1509952wmq.37.1710845086023;
        Tue, 19 Mar 2024 03:44:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4d45000000b0033e03a6b1ecsm12029459wru.18.2024.03.19.03.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:44:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Mar 2024 11:44:32 +0100
Subject: [PATCH 6/7] arm64: dts: qcom: sm8550: remove pcie-1-phy-aux-clk
 and add pcie1_phy pcie1_phy_aux_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-6-926d7a4ccd80@linaro.org>
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
In-Reply-To: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3132;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tPydKqk2YSla66EnZFuqclyzKir7dE9KK2iKURNVrUY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+WyWIIf6eAULGJi+KYMNFWeRDbZQecFnv0jc1Bih
 YiqNcQiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZflslgAKCRB33NvayMhJ0UKIEA
 CREHuVTxqFBzS8w1qctN3Q/TWUi+O2WvULNAIc8TrdkVKqYE1zi/eslMXMTM+vyA3GmXSwKoj+JAbf
 1PivkwHl6csnRWJg32j+EhYkNTxnvJvett9F88fOBTOadAKJSz9jc00GAVTSpeacugGoqNiSZuAG4j
 gG9+DZuBquLDamG4+EV1t5RI9snBRluKJMXOg9VWtUVmiNB8zfecdlNVctAkKpO/nm1rqo44C7A+vM
 cz9AAiIooCYmJDe8DJYGj+SYNnrdw+EFmlQk6tViRJdfChs11bQQEPsv7ePfCOz9uABN+DIkaIL4ks
 vOP8lPHakyl+3RxOGFKs6znQKGB03qnqvpvHZwXAz/3J01GEKyK6mX/ajlqYqRl7i31Fsm0sfW5XLw
 ulQ09aTXg7lP3IA7PGY18/9aW5p9y2FRPKuVP/QNIQkoa1+NYmWcn7C0gZRp1iVrurbnfXfLmBubxN
 s/vN51Y5QYVDu40QgS6wmLHanpQSvVqq+A7i3u/Rj1ClpNKM9WVgC1PcKT2MB1Bs0TYrjT1aM95WCv
 w2VTCUGpaA7zjwi0XdCBaTwZb9CyK3Y6UX9H9t97qZgUSqlN5ww1cOcIdVVnz7qYxraXsCvglFSZEH
 3Jqc8o2shaZ7eZ2wlDqHWqWvSWIXEVSRFUl8+UX04hJ893SqiLyAJApiPIng==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Remove the dummy pcie-1-phy-aux-clk clock and replace with the pcie1_phy
provided QMP_PCIE_PHY_AUX_CLK.

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
index 3904348075f6..c74455dfd354 100644
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
@@ -1906,8 +1901,8 @@ pcie1_phy: phy@1c0e000 {
 
 			power-domains = <&gcc PCIE_1_PHY_GDSC>;
 
-			#clock-cells = <0>;
-			clock-output-names = "pcie1_pipe_clk";
+			#clock-cells = <1>;
+			clock-output-names = "pcie1_pipe_clk", "pcie1_phy_aux_clk";
 
 			#phy-cells = <0>;
 

-- 
2.34.1


