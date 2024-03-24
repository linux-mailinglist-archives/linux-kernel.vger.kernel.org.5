Return-Path: <linux-kernel+bounces-113721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED0988863E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA9E2930B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B871E8E33;
	Sun, 24 Mar 2024 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBKBIElQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B741DBF50;
	Sun, 24 Mar 2024 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320703; cv=none; b=IkN6ulAHuJHEptN/DBKwkonESrzU25OLJcoTHxzsSMEvioxM4gO+dgY2PTOFg531VE2OaAk5I/A/fB1Z8gnp/Z7PgIxZORjffJU9/CMpKs+u05NZa1v9nI+9Y3Ef7HDOO3z+LRkOBxAu97nQ20P+BJNNkMcGFR8csZS+qhH+vH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320703; c=relaxed/simple;
	bh=RzyK29TSRnSYZCzvmT+yLQqJFtYVbESIkYx4+PpbUT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFo/3VPwaQl0A+eNep6vimlvTmaH8V4fruXbrldlCjYPiRI9PEFGq9n8qPluFPb2YM1mpIMG1167Vj7TlHS+ZFT3QCSmhL4PYcNlSXVGxQGMHE9Yi7DtFg44AcZ2oz9Vw1mdNkKtkM0v7WOQDgYAFXSRXVOu73Jyxifu2Ew0zL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBKBIElQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCF7C433C7;
	Sun, 24 Mar 2024 22:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320703;
	bh=RzyK29TSRnSYZCzvmT+yLQqJFtYVbESIkYx4+PpbUT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBKBIElQyOCyJWb8l+sTb7AyZiWUyiUDH0Ij9CPISxweJEkXBujOBb11Ba3DqhpM0
	 lAu3jsibvwS20dOgv2a9/6iQAg1gRmX+mzOc/ZU71PZxeDmdeMEUHla3Px4Mw4k4gT
	 FYwOYP+xl34hXx4hDjnbT77ubQmjASZKuyo+WVcOs94ytkTw2VuBrSusGl2d4FDYSa
	 /2k/4OI614mpu340PWhsSpr99+R0npTp87Ue+iuq9urgVKkayfgPIsGmXIZ1M60LCy
	 sm5E4jRiZSBBmi1TAnDF2rD+wewxqTXR8FCqlsKyP+S+GBhzwVU1kunXo6QBSQI9e5
	 6/Yf6kc+xboYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 265/713] arm64: dts: qcom: sm8150: use 'gpios' suffix for PCI GPIOs
Date: Sun, 24 Mar 2024 18:39:51 -0400
Message-ID: <20240324224720.1345309-266-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit af6f6778d34cb40e60368e288767f674cc0c5f60 ]

Linux handles both versions, but bindings expect GPIO properties to
have 'gpios' suffix instead of 'gpio':

  sa8155p-adp.dtb: pci@1c00000: Unevaluated properties are not allowed ('perst-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231111164229.63803-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 7c38989d0f7a ("arm64: dts: qcom: sm8150: correct PCIe wake-gpios")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 3221478663ac6..a662f09fdbe19 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1878,7 +1878,7 @@ pcie0: pci@1c00000 {
 			phys = <&pcie0_phy>;
 			phy-names = "pciephy";
 
-			perst-gpio = <&tlmm 35 GPIO_ACTIVE_HIGH>;
+			perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
 			enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
@@ -1972,7 +1972,7 @@ pcie1: pci@1c08000 {
 			phys = <&pcie1_phy>;
 			phy-names = "pciephy";
 
-			perst-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
+			perst-gpios = <&tlmm 102 GPIO_ACTIVE_HIGH>;
 			enable-gpio = <&tlmm 104 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
-- 
2.43.0


