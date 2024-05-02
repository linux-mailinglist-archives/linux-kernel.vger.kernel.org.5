Return-Path: <linux-kernel+bounces-166087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159A98B960A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EEC1C2152B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3642076;
	Thu,  2 May 2024 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qYtPJVRh"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE72D045
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636847; cv=none; b=TrPdOMMHpilP/z0kFTpeXLfC7+IvVyn1ItIc1a446i7dsgSJ8C7uuqq9LjK/NXlw2phkTls8jbkJHdeoI5POJdITWhtPTxcml8ZA7mkK5x3eVgKDOzkD7h/xZpdeQ36/WMKEDL+Z7xxWxPG/+TjTRTOB9uXSNJyk+ipYgbcq7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636847; c=relaxed/simple;
	bh=6YI9duv4q6KVjAqk9Z+8wEkt2+gAL9b/MgcLDx+vv1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zn2DsXPzHNz90s9q775FXN2F6OZDMNQP13mbQqzl2kCRQ5yPGPRuVCSinI0jKmrK6f74ChWHv9dnedlheSMBfMGE5mfxQXYoE/szUQg748ePZILhQUm5x74YhmxLlZAZT9XdTLlUSU9ZJoVO1O32H3p2wFvu+6kxqnT1qPUZAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qYtPJVRh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34b3374ae22so7153761f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714636844; x=1715241644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajn8usTuqsfMNwN0wgJ7uSMnydqkyy9vQLRbPTG7jrc=;
        b=qYtPJVRhstYWlPfz9fHTbv2opdLRLOJUKJ1XWe3NPx4j8aH5x3GXKdBzBQQ1soUnWl
         1ZAdy/OwlOvKA09u/i9xEF8X8sitcScSPdbNY4XuBg3+q7ebeKJzn0q5zLvy2F89Y/Tr
         p1yg8z8g2w9Tlo0cqIQe4s/y1YdlA55mrAG54BqyxURRwwpsF2Y84C79uvLkeNM1GEUc
         ZxPKZtdf/hXw8l+dnz8aGOggAT2XXTlhe/WC+cEDxoBBWFNLn1hP+Pahyd3qBV4J+ECO
         4vdMWtyKvxdZOpiNxYCY0Y94VH6QxXxrBoFaKjIqBPJ5s+C0R9z37EFQXaY7FMszf0Cc
         B1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636844; x=1715241644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajn8usTuqsfMNwN0wgJ7uSMnydqkyy9vQLRbPTG7jrc=;
        b=SbDw3XK7kNiyeJRYAXel6swXzpRoeCC0lRdTb0yEAt2ZQIKpv3FjBFEoqrxTdMQbk1
         asCIbFj9Mk2jafkyWBFS7K9AZaV59oo6PBsR3FYM5poej8ysg6H7DavxZYWhr0jUI2j0
         /qJYZT4SyV0DQS1d6P5nER9kDun1y0oZCwsgFWVY/fs0F6B3Dl8XHBdBvPdkUfRjUX+z
         Y2FRMy+5DaXNawLUkQr3k90lqzvD4I4EIyr5Ioc5rQsSKsiHk0qiuAS8Ql3NtQ4ed+Tn
         FyXy/zhipCa3j+mz9H5L8KWvvfrKA/1Xpd6jXUjnp6vudQORFddinkT/H6DBdCdiiOvT
         z8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW1Dp7KynL4K0DFFjhPmm/oxF4udl3xoJB9bI/a3kLaqBflzLwTeW9nQpvb79kzZBf6XPvu5RduQaPGzfOR2hS09X7/kL2VABk9Ya0L
X-Gm-Message-State: AOJu0YxrFk9vZTP2wfo1twV9mgQ0DhQPKZFhSZRutTegQ2YN64AFdcMn
	n7z9cG9gIx6AOhqEBHOv8p9Qpugi26bN3oaZ+9xJJOuizsKjFbuV0I+Q0KfmnfE=
X-Google-Smtp-Source: AGHT+IEMzh95ItE0S47y+bpv9P8IykzSeSutZN4r/l9PRXL2kPtzF3jrDQ3CyeUQConSnwboYrmVUg==
X-Received: by 2002:a05:6000:1811:b0:34d:95be:9340 with SMTP id m17-20020a056000181100b0034d95be9340mr3821414wrh.40.1714636843593;
        Thu, 02 May 2024 01:00:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041c02589a7csm4806597wmq.40.2024.05.02.01.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 01:00:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 02 May 2024 10:00:38 +0200
Subject: [PATCH v5 3/3] arm64: dts: qcom: sm8650: remove pcie-1-phy-aux-clk
 and add pcie1_phy pcie1_phy_aux_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v5-3-10c650cfeade@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2773;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6YI9duv4q6KVjAqk9Z+8wEkt2+gAL9b/MgcLDx+vv1w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmM0gngOgq2EfztlknwDOuQ3nmqCige71pZnTYJcQU
 ueaQc6yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZjNIJwAKCRB33NvayMhJ0ZPbD/
 0ZnGwYdOfo2jlubqYAOosNE3GmfifylqGGvo47yEhvcYQrSk045jmGzrX5Yu+QuIMXWPSrydWIEFeL
 pxhZZHdA+Ylu96GghwR9n6Le2/nZ4sh6QQvvJWohXk6o5+ak+TlZfNyuEvIT1Y7gkPikSYH0FfJuph
 DMgMz1Ix7WwriGGeOLe+tcUwvQAdVjEoveHknAyB3wuMqDt5dllPV+MVOqvCy2W2v1jqhT3j+DCYsc
 1V+AsqeuuD4J+OvetedR5IOrxiA1pPa/ElbWkrvd5X3lbnX/dP3CmqpZkfgdPKOHtESA+wUohf5yHI
 Y6bh0jysptG/WM60RqxcxRGDehK/h90rhEefCcdb+BkYlkz6+yhrBVC4BuU54DIPIOGyutyRC0ODAU
 FXejUnjkzqEGxRXSrIV0Hn3s0ahmKBLql3oXQAqs2viPU26iePuLBzg5A67FGztft2KoUbKksrcr+9
 39ylvdnOYxF6cof888iAxOS5GsUpimjqPsPInbLcOxMRK8DXk7LPdAb+LgpctThulhtH3jIA2BPPyS
 Xk0KD2yixakCPy9eNF1eDIq8UTIcxDSxRpdyMwpDDUWwE2Z8GeOkw6VDzb40RtDTzIfPyT92mo95aL
 RNIFr4U99WiGvYCEUzJ+7rHhURO54MjTwrF8Qm8yTA6vuYpLFCHHuBXN5Akg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The PCIe Gen4x2 PHY found in the SM8650 SoCs have a second clock named
"PHY_AUX_CLK" which is an input of the Global Clock Controller (GCC) which
is muxed & gated then returned to the PHY as an input.

Remove the dummy pcie-1-phy-aux-clk clock and now the pcie1_phy exposes
2 clocks, properly add the pcie1_phy provided clocks to the Global Clock
Controller (GCC) node clocks inputs.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts |  4 ----
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts |  4 ----
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 13 ++++---------
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index d04ceaa73c2b..ea092f532e5a 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -641,10 +641,6 @@ &mdss_dsi0_phy {
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
index 4e94f7fe4d2d..bd87aa3aa548 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -835,10 +835,6 @@ &mdss_dp0_out {
 	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 };
 
-&pcie_1_phy_aux_clk {
-	clock-frequency = <1000>;
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 62a6e77730bc..78b8944eaab2 100644
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
@@ -2467,8 +2462,8 @@ pcie1_phy: phy@1c0e000 {
 
 			power-domains = <&gcc PCIE_1_PHY_GDSC>;
 
-			#clock-cells = <0>;
-			clock-output-names = "pcie1_pipe_clk";
+			#clock-cells = <1>;
+			clock-output-names = "pcie1_pipe_clk", "pcie1_phy_aux_clk";
 
 			#phy-cells = <0>;
 

-- 
2.34.1


