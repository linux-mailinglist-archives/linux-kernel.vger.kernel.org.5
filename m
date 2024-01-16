Return-Path: <linux-kernel+bounces-27816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E328F82F64D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27AE1C20ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643732D7AB;
	Tue, 16 Jan 2024 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8RhtSsY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF42D78B;
	Tue, 16 Jan 2024 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434270; cv=none; b=MR0Vo8Nf1UI5+L8n383OPScYiP+4mLCN8WxuSZoe3TmkWOEXO/lPyYSfVtYBVDp1YJG0DJ4WsMQ2zghwNcYOueNWlyBTyPH4ccuzRDrA+bzhTNX6kdQOdZex7SjffIwgZQjoAtVRrpQ2RyFfwSJOhxgirZsitWtnBVP5fWVLe/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434270; c=relaxed/simple;
	bh=Rux4A75HfQFutwp+vRjQ/gjHxkjnT0mdFXRPi5y+ycI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=qAa4fUCLhS6MM/Wz3C+LNJpDL7tbbBRZHsYtQy4w5Jbou6EkYW2MsqfniUskIpOfuUZsE13PsNfnmN5EVE6vdcQF3H5rd3uyyQh+WwjJt2VNtO87Su6eOjHrQ133jox0Dc7Wefi1juEPuM6439PTdlEcFOUkeXZTde3IJL4u4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8RhtSsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8934C43394;
	Tue, 16 Jan 2024 19:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434270;
	bh=Rux4A75HfQFutwp+vRjQ/gjHxkjnT0mdFXRPi5y+ycI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8RhtSsYNG+JP4BzaO9+9x0aJeMyNirT6xHCIWW90T4FFJBCtrD/qH+yipAyFGIdT
	 +jMGNxEMSSqpbg0QjgVRfdBmzIP5XBuHqtjW+ZLGcadWBS+HflDVLWRKyxd00QFbqA
	 GhkJygZhSacPTsxyBwBkdWtraOx0k60dpHD2odszq6Bn7NGoMYSr6QK+/GBFOgWogl
	 foynh33ET0IkVuhiavxn7J7m4Dg5OE1IWxQOa1r39VjaRVSKocgktbzlKrzjG6jABI
	 POkuF2k7JqgeiyHNpQUlFfbDfAKzN0vlPEgycduCRyx4QQoXUmXusK6df7CNlHYNoh
	 BuKEZwrtZ/dcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 045/108] arm64: dts: qcom: sm8550: fix soundwire controllers node name
Date: Tue, 16 Jan 2024 14:39:11 -0500
Message-ID: <20240116194225.250921-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit 07c88da81caf0e72c3690b689d30f0d325cfeff4 ]

Fix the following dt bindings check:
arch/arm64/boot/dts/qcom/sm8550-mtp.dtb: soundwire-controller@6ab0000: $nodename:0: 'soundwire-controller@6ab0000' does not match '^soundwire(@.*)?$'
from schema $id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231106-topic-sm8550-upstream-soundwire-bindings-fix-v1-1-4ded91c805a1@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7b9ddde0b2c9..85dc7b5494ab 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2050,7 +2050,7 @@ lpass_wsa2macro: codec@6aa0000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr3: soundwire-controller@6ab0000 {
+		swr3: soundwire@6ab0000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06ab0000 0 0x10000>;
 			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
@@ -2096,7 +2096,7 @@ lpass_rxmacro: codec@6ac0000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr1: soundwire-controller@6ad0000 {
+		swr1: soundwire@6ad0000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06ad0000 0 0x10000>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
@@ -2161,7 +2161,7 @@ lpass_wsamacro: codec@6b00000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr0: soundwire-controller@6b10000 {
+		swr0: soundwire@6b10000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06b10000 0 0x10000>;
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
@@ -2188,7 +2188,7 @@ swr0: soundwire-controller@6b10000 {
 			status = "disabled";
 		};
 
-		swr2: soundwire-controller@6d30000 {
+		swr2: soundwire@6d30000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06d30000 0 0x10000>;
 			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


