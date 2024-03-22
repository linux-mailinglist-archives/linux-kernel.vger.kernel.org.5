Return-Path: <linux-kernel+bounces-111239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778DB88698D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D835281B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BD03F8E0;
	Fri, 22 Mar 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaQ8X91t"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20993A8C3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100575; cv=none; b=p/YQYgtSiYiXVczqefv3hZj7t2Wzp32YYsRt7xrnuVfwpE+3c2k07TaBhokujBI6EwKm+7xTEnsOtds66oB78BJcAeRh3HudA0OVIO19wrXL/6b9+QITfr71vqhfksSEGbYyoM80PyKS4B2eWtUegxwimISentqx5D6egsNfJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100575; c=relaxed/simple;
	bh=fB7ha//rZ/f/HstsEjI3jngLBtEYcuG0WuaGH0Cr+Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t02S78QY25m5743IUxslaHJAKBxTreZsePvzlgLWdNhyDwPxeP2JFZwg1H/DUqDK3rW8s7I6iSeU+WibCVKhX5tf5fBkIEp3LjFTQZlz1evzcmiIYlHB2/yEfTUhbPG+R5MMv7XYglUBU16SqVCINQoVve2DVoFbF+u7j5p+Yus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iaQ8X91t; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-414701303f7so18371185e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711100571; x=1711705371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUssMuF8ThH09UlJpbb9vyo3xzL9TqetFqxpN+Tr8Ns=;
        b=iaQ8X91tv0+DLzbv88073kkbX5aY+4HfWRIupCwulRuo+yC15iB7GEYSgLbqoEX5wT
         0cLvAy/brcI41jTaAWCWW//bfseB2LDjNyyf/Hz/gqXcoS0niVQ7zoVYiY0rqE+zz3bw
         MsGYSE/+MdZQwC4hHi5JWsb/+ECBPnI3gy+oBri8j8GHOb1q0n9ap6BORaZfFvRoKkDt
         SqilPaw0xq/lL7X6+Lj05M06LqbbCP4b9JH0eDqlZy3i5N05r2juYb31uqzox2Yq6M7B
         O2lm3LkCZ+AtolhfOe014bT9qIq9CNOF0s5bbEu/DZMSa/V1rVFaP8cIEmK7IpiWz1NC
         ev6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100571; x=1711705371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUssMuF8ThH09UlJpbb9vyo3xzL9TqetFqxpN+Tr8Ns=;
        b=oeQbHn3ITZqLFGSMAje03ZhB5VUF9DNei5pq+ebqdx6S0ycMeZUpBvGiGuxQrfsWMX
         UhlaT8VcPNincKMn0apeZMyV8q6inyRx9IlLYsBQxohmwPHnQZyW2J1RrsCGu4dj9dp0
         I64hNoOwGZXKLUA17w4CapTMmvY9SQbYJk18ReenzGDPJX9LASAs7wvIi62k4oTbxVl/
         Ff6i8B+CizSw3HUPoTG/5bcN9E7f98rWXi/XQ0jrfEQCvLHKP4AsHbiffLgXmh0G2XYF
         PBx29U9i7WwjWc5kFzxFHw7egCfjWTph0ul6biXrW2Vwdnkw+ILoqEiyGwy8K83H+Are
         J6jg==
X-Forwarded-Encrypted: i=1; AJvYcCW+N7ZsoEPaQxUr+KbGR+LsF/FDfYm5XLv7xWhXT95jxazZr/0wh6/mV+2aGAfYExXPoDZnCBm4UWtqLqhX33BateTobVud2Z7jpZRU
X-Gm-Message-State: AOJu0Yz5PN+X/+p04S9b71scByP9dOSu3OBxqfY5zZ3kIRFv3a9FJthU
	8ok/o2EGCwe6/uauiqKIp3xKG+kzuxFqwtezKefBYboN/ChZKU6EEp6YnUKLdAo=
X-Google-Smtp-Source: AGHT+IGn1TUPJe2KUoUFUP1ntI/uWf3G7ZEIHuB1MYn8zZfb3E723dM4eyZgLqav8ccuQa72KY1kKg==
X-Received: by 2002:a05:600c:6b05:b0:414:69be:54a7 with SMTP id jn5-20020a05600c6b0500b0041469be54a7mr1646075wmb.41.1711100571136;
        Fri, 22 Mar 2024 02:42:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b0041461a922c2sm2547845wmq.5.2024.03.22.02.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:42:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Mar 2024 10:42:44 +0100
Subject: [PATCH v2 7/7] arm64: dts: qcom: sm8650: remove pcie-1-phy-aux-clk
 and add pcie1_phy pcie1_phy_aux_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-7-3ec0a966d52f@linaro.org>
References: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
In-Reply-To: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fB7ha//rZ/f/HstsEjI3jngLBtEYcuG0WuaGH0Cr+Bo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl/VKTZ1JXeyzTLkNtjvqZxp7JUTH+dlXGNHCvhF0m
 hqUydgyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZf1SkwAKCRB33NvayMhJ0firEA
 CHvG8bUPSmOwXe1zrRf6pqMs1BhQOgNZXNsU/OivN3SnRrkypSyvlE/eOvqtco5jvUkXH9C/Z3NJs7
 jjaTDbimSIsSx9Srw7SnN1I8uz0cRPprsn8CoKePHNJcGPyZLetjxJcDwKCj2TrRTf8kGKUeh4MLIf
 JVfBYTm2PpOmuR0WjLpGj2HqS0sPjPe+XT5YoKUsh8UezxIZTilxJ7R+c97ets7BwbKXKzX/0AoTjs
 WKRV39jnL1JOr+Hal9Xiw5UtozzcHcBpUFOQqKLPmNItZ2ChqUl5Gf6Z3bXGIqAI9ZoQokOTG0Y6Rr
 Lt/Mrh2htYkUx/y5X7DulLfENCdQKy6cqEVhQh4MCnP6HdA/uyroJCiF/SKlJrzT2eEnOzglJ0eK3d
 Ui3BLbZrG1GtFdUsqefnny0RIEG0bWORCvS67uFnTm9fqAQq5R34aNorgPQKpol+q1Ixl69dYF8ZlD
 Z1KWMoI8nUD9cKOvcDd4t9nWx3cjzDrnn8huS5dD/6i/RtuF8xzQ3NMRkDEuCZ73cQq/9+Y9JO/2dw
 HMGG9ZIA2u9ZqI8WKk7f2idK9fxHzSIrxjZGjPRnTedH+Od8uNmFxVJOKLACPsh83xE5Hjg8/aGYwx
 XuNNH1iI3NcvU3VpQ4LXvLDUYOvjbxjdtV6NXAitrhkPbN0jZO2skLBgsCeg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Remove the dummy pcie-1-phy-aux-clk clock and replace with the pcie1_phy
provided QMP_PCIE_PHY_AUX_CLK.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts |  4 ----
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts |  4 ----
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 13 ++++---------
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index 4450273f9667..95d0c2baef2b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -645,10 +645,6 @@ &mdss_mdp {
 	status = "okay";
 };
 
-&pcie_1_phy_aux_clk {
-	clock-frequency = <1000>;
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index b07cac2e5bc8..c6e907e40af1 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -831,10 +831,6 @@ &mdss_mdp {
 	status = "okay";
 };
 
-&pcie_1_phy_aux_clk {
-	clock-frequency = <1000>;
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ba72d8f38420..6e4362bbcc3a 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -60,11 +60,6 @@ bi_tcxo_ao_div2: bi-tcxo-ao-div2-clk {
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
@@ -758,8 +753,8 @@ gcc: clock-controller@100000 {
 				 <&bi_tcxo_ao_div2>,
 				 <&sleep_clk>,
 				 <&pcie0_phy>,
-				 <&pcie1_phy>,
-				 <&pcie_1_phy_aux_clk>,
+				 <&pcie1_phy QMP_PCIE_PIPE_CLK>,
+				 <&pcie1_phy QMP_PCIE_PHY_AUX_CLK>,
 				 <&ufs_mem_phy 0>,
 				 <&ufs_mem_phy 1>,
 				 <&ufs_mem_phy 2>,
@@ -2449,8 +2444,8 @@ pcie1_phy: phy@1c0e000 {
 
 			power-domains = <&gcc PCIE_1_PHY_GDSC>;
 
-			#clock-cells = <0>;
-			clock-output-names = "pcie1_pipe_clk";
+			#clock-cells = <1>;
+			clock-output-names = "pcie1_pipe_clk", "pcie1_phy_aux_clk";
 
 			#phy-cells = <0>;
 

-- 
2.34.1


