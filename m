Return-Path: <linux-kernel+bounces-39339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE683CEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB45B2250F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7EF13AA4E;
	Thu, 25 Jan 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="RODS774o"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2A13A256;
	Thu, 25 Jan 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219792; cv=none; b=EJkP39tHJICqdcIb89NHensw7MKg50Dp71Fbnauc+pAw/EFn/ePN3g0TWs5VnJW0OxpuHYopGBJBgZprJ7E/iWJ/ifyd7qJpKWF6sznQ8xnd/q/ezMw80OVQHYBybn1KTr9jl6pS1L0g4clQtdBGc3knvE1SXgJOx9m84iVOg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219792; c=relaxed/simple;
	bh=iVJuRxgL5kv4O2Iy1LSObxXiPhy/9uSVuR7pRJgvKG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Txa33zAdfAS0cDW3hNxoAP+gLIGWLa2gqLhdfgeinZCQwPyvYX/zp+rwFcVSgsCK0VlWggY3nR8NUtNYO572FOXDFautxd6/e3WXaCwA537X/xS3paSNFmGCAQzsqT1W9/g2pEoPbHG9TzlaCXFbJCgUywJYpk4E78AGicCFiR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=RODS774o; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706219789; bh=iVJuRxgL5kv4O2Iy1LSObxXiPhy/9uSVuR7pRJgvKG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RODS774onD7Q2Ed1k0w52jLNPH5kgjmsAPo8dyaXPmtrgNXB0MT+kRc8oP3pC3de9
	 vOvaU3gjzTMCU/ihlARbPVQoE8j1bZ4B4lbtPYMuBhEaYBTdQ3B2vH2sI67f3yf40w
	 FD+ZpieSyTQiRs8meTzZimPgi63lKq/35lZrHDD0=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 25 Jan 2024 22:56:25 +0100
Subject: [PATCH RFC 1/2] arm64: dts: qcom: msm8953: Add GPU IOMMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-msm8953-gpu-v1-1-f6493a5951f3@z3ntu.xyz>
References: <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
In-Reply-To: <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=83PN5aUeRY5s9kLZimJpYkdeYsnG6XOaZnR2lKrM23o=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlstkKsY20NOQhBoGTOoVsRqfQlTkjRCUrQIEq4
 U383JLKFYeJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZbLZCgAKCRBy2EO4nU3X
 VrXYEACkjZWciMksryIKVAtyt0jvUPgZIYSQpLKi4gVk8qhDi1cN0OHbIWyvjjYtlwCEue3IlDc
 5K4Fb1Y0tqpmfwhzYaSNv0FCIME0SjvE+badDBP6U92mdLvIavqIm5Eu41PuGiipYchgo2AnQm5
 apANVErzBIvldi0g5Whm3LVaJUNukjusGZQK+2wyrH1VmSyrDID49nB2DUEgfxQeoD4DMi/jWW+
 7W3zjYJoFcW0HMZANgRn1GoVcRyiOUaicxrkDuYuAUAE5GLiBIbKiRGXtCQbgJ/Dfo313sRSbG1
 fxicXg8oXzyvsYAmiPTOwBFKLjA4iRDrwdp2Q//xc1d6KIILIKqVbc1iCxy0Ss6ibCyg/1+u2Qt
 keDhkRaVhbL9m5aIc7TRSSahL07U1SatRnWOLVG3Ic1NUVItCLMy2OkX6OpslkddeD3EsXy7x3k
 zjL8o6ACgbQQIYl8BHEggqgew8fbWzJs77pvM7N+CgqywwZfZzKMbF8pPzgSrEzy5Tpvj1xrKwt
 TTf/ryqKLbZe6Aib238naxwwxUq6OritW6xvtRIWuQiWhO337RIFf825HrcBSPX9ijmTkYb/Okn
 bvWdO+3tNjtN2sXacfn2uE60DEZQPcT6UDbhwm2aVJ01ZsuR1PLkOi9WxFlV1XLqRmxz7qt0S1A
 aVFJ2z/em6bx17A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Add the IOMMU used for the GPU on MSM8953.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index dcb5c98b793c..91d083871ab0 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1046,6 +1046,37 @@ mdss_dsi1_phy: phy@1a96400 {
 			};
 		};
 
+		gpu_iommu: iommu@1c48000 {
+			compatible = "qcom,msm8953-iommu", "qcom,msm-iommu-v2";
+			ranges = <0 0x01c48000 0x8000>;
+
+			clocks = <&gcc GCC_OXILI_AHB_CLK>,
+				 <&gcc GCC_BIMC_GFX_CLK>;
+			clock-names = "iface", "bus";
+
+			power-domains = <&gcc OXILI_CX_GDSC>;
+
+			qcom,iommu-secure-id = <18>;
+
+			#address-cells = <1>;
+			#iommu-cells = <1>;
+			#size-cells = <1>;
+
+			/* gfx3d_user */
+			iommu-ctx@0 {
+				compatible = "qcom,msm-iommu-v2-ns";
+				reg = <0x0000 0x1000>;
+				interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* gfx3d_secure */
+			iommu-ctx@2000 {
+				compatible = "qcom,msm-iommu-v2-sec";
+				reg = <0x2000 0x1000>;
+				interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		apps_iommu: iommu@1e20000 {
 			compatible = "qcom,msm8953-iommu", "qcom,msm-iommu-v1";
 			ranges = <0 0x01e20000 0x20000>;

-- 
2.43.0


