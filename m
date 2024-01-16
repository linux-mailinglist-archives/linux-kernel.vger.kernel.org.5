Return-Path: <linux-kernel+bounces-27817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5580782F651
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D011C20A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F972DF9D;
	Tue, 16 Jan 2024 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyJfZaDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E402DF68;
	Tue, 16 Jan 2024 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434272; cv=none; b=r07oIFDY8CCT+Ayn2UxIt7Czns/WQYmuKuelwmUm6zy6FfErSRD00O/K9HIeZ2A/t13d9Vbfz7bRBxvUG+kZmgi0V0NN4p066BWrPKBlEbkgOr+2StSN33UjVy6Rd6kxxEswe7vOc/7Tay2R1bSzbXi2+wByVHxgW4vR3ne5cAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434272; c=relaxed/simple;
	bh=IBkkjUMYB1DUG4rPB1B8PBT6+nn54aUHEQBIED4VgFA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=mMG92rx9BTkImdRbqoCAsylJXrGWo3PkgeS9cHpnJVlzQX421Zo2nUeSOTVXWHMxeMbyPwtkrhOkANAmJRmS9o/omKSuGnccCZP5IoW7p5If1CwmROVUj4J2QBWk2jZN2/Zr54IQ/C/arakLSXVep4LoU8fgReu+K/GphKobxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyJfZaDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F7BC433C7;
	Tue, 16 Jan 2024 19:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434272;
	bh=IBkkjUMYB1DUG4rPB1B8PBT6+nn54aUHEQBIED4VgFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyJfZaDs1AX7NcZXUY6w1Z9KbAO3w75l4pN+298nxDIAeE33nrfkceKeP6yh53QCY
	 vbiUno9wTEcplOEvPhgyU0/c4h22yK3u8D6AAXm0Gz9Vo/NMrSKW8N8pn044sKL1VX
	 GMQEmLEMks7BaTf84ooXATbademqMk9Q92SOfTRO/Y24ccCccOdKQuiiK4d2Gs7VPO
	 KqLuts0kD/onVo65wsTKPGWtPjUluDMHybWUV9LX+IiBC1QrD3U8pyl0SvrzgDxSrL
	 udAJ+963O6YKFn10NeDIb5xt9Gq5hVuUyFzowkjNIbYnZAxBL5RlPOHd0O6Yi92HjM
	 pQ3ygVeKD0Rkg==
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
Subject: [PATCH AUTOSEL 6.7 046/108] arm64: dts: qcom: sm8450: fix soundwire controllers node name
Date: Tue, 16 Jan 2024 14:39:12 -0500
Message-ID: <20240116194225.250921-46-sashal@kernel.org>
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

[ Upstream commit 11fcb81373de52eeb1d3ff135a8d24a4b18978d3 ]

Fix the following dt bindings check:
arch/arm64/boot/dts/qcom/sm8450-hdk.dtb: soundwire-controller@31f0000: $nodename:0: 'soundwire-controller@31f0000' does not match '^soundwire(@.*)?$'
        from schema $id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231106-topic-sm8450-upstream-soundwire-bindings-fix-v1-1-41d4844a5a7d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1783fa78bdbc..4259b30b6439 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2160,7 +2160,7 @@ wsa2macro: codec@31e0000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr4: soundwire-controller@31f0000 {
+		swr4: soundwire@31f0000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x031f0000 0 0x2000>;
 			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
@@ -2208,7 +2208,7 @@ rxmacro: codec@3200000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr1: soundwire-controller@3210000 {
+		swr1: soundwire@3210000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x03210000 0 0x2000>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
@@ -2275,7 +2275,7 @@ wsamacro: codec@3240000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr0: soundwire-controller@3250000 {
+		swr0: soundwire@3250000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x03250000 0 0x2000>;
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
@@ -2302,7 +2302,7 @@ swr0: soundwire-controller@3250000 {
 			status = "disabled";
 		};
 
-		swr2: soundwire-controller@33b0000 {
+		swr2: soundwire@33b0000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x033b0000 0 0x2000>;
 			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


