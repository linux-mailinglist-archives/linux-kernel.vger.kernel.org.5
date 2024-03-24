Return-Path: <linux-kernel+bounces-115836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67A889837
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AB929D6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D01D3709D4;
	Mon, 25 Mar 2024 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL+qEFt8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C9145FFA;
	Sun, 24 Mar 2024 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322057; cv=none; b=jqHPGT2NgRDyQAmXQnqMIWjkD8cBRPmJ+MkR1Tpxi96MNG8h+a94M86kb3uQXA/l1ccZZb55Pcbc0C6sMYIEdfmnULRnkQSczej88BKpN0mvr9qyeqdtgt354Irnar0q6HehGHvwjk/vR7GK5DgVevFAwkOaRCzym8HMZ5NUHnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322057; c=relaxed/simple;
	bh=NPq6MquJ5yUC5CMPcnfevOigtOVMb24x6buBjtq8ZJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bukf2UQFgLf0H3Sa38IlgiejBirehnmm+g8WEc54jUoPARAGuJJmdRTK1hABEeCEtSG9X5rEp8wTrW9dMRRL7zaWn7/sM5NEvC3DFimtbiREa0wkgxxySGX5596yy9w76c3YclSc7VQkZnzz3RJlh2K17jJzIg1LVn8lOnR8/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL+qEFt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA88CC433C7;
	Sun, 24 Mar 2024 23:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322057;
	bh=NPq6MquJ5yUC5CMPcnfevOigtOVMb24x6buBjtq8ZJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EL+qEFt8YnF1D8EXtjAXS17jpNIU9lV0XeYhqh2Qkaz8zJ7aB/SeSxLgW5nMEp0lk
	 oj9dGN9Yk1afg3H65Glj0SPKoKSKndOqoCABLdQFDHqr26fPe2w9078C1z5lPKJFyF
	 Lmj+RD2ZiK6H4CbEuLW5OkQ693b67dzLzQTuEpxVu+RCTilg+5Za4FK4WgV8DQihjS
	 c2Qpe/IaHGATXYiqOc5syP9za/Kx/pEN7tWwiL9SjHAlCnUs4Zya/ywQ0kQNZkpj39
	 SVuXkLcMUD27WmXBe+R9BsIo+npEqb4CEbjnURXKVgTaT/71te0wLLjFOljFWLuLqH
	 ppnIcR4Lh5ZOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/451] arm64: dts: qcom: sc8280xp: update UFS PHY nodes
Date: Sun, 24 Mar 2024 19:06:46 -0400
Message-ID: <20240324231207.1351418-131-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 33c4e6588e4f018abc43381ee21fe2bed37e34a5 ]

Update the UFS PHY nodes to match the new binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20221104092045.17410-3-johan+linaro@kernel.org
Stable-dep-of: 1d4ef9644e21 ("arm64: dts: qcom: sc8280xp: Fix UFS PHY clocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 49 +++++++++-----------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 7e3aaf5de3f5c..88140ce104a44 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -845,7 +845,7 @@ ufs_mem_hc: ufs@1d84000 {
 				     "jedec,ufs-2.0";
 			reg = <0 0x01d84000 0 0x3000>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
-			phys = <&ufs_mem_phy_lanes>;
+			phys = <&ufs_mem_phy>;
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			#reset-cells = <1>;
@@ -887,27 +887,20 @@ ufs_mem_hc: ufs@1d84000 {
 
 		ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sc8280xp-qmp-ufs-phy";
-			reg = <0 0x01d87000 0 0x1c8>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-			clock-names = "ref",
-				      "ref_aux";
+			reg = <0 0x01d87000 0 0x1000>;
+
 			clocks = <&gcc GCC_UFS_CARD_CLKREF_CLK>,
 				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+			clock-names = "ref", "ref_aux";
+
+			power-domains = <&gcc UFS_PHY_GDSC>;
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-			status = "disabled";
 
-			ufs_mem_phy_lanes: phy@1d87400 {
-				reg = <0 0x01d87400 0 0x108>,
-				      <0 0x01d87600 0 0x1e0>,
-				      <0 0x01d87c00 0 0x1dc>,
-				      <0 0x01d87800 0 0x108>,
-				      <0 0x01d87a00 0 0x1e0>;
-				#phy-cells = <0>;
-			};
+			#phy-cells = <0>;
+
+			status = "disabled";
 		};
 
 		ufs_card_hc: ufs@1da4000 {
@@ -915,7 +908,7 @@ ufs_card_hc: ufs@1da4000 {
 				     "jedec,ufs-2.0";
 			reg = <0 0x01da4000 0 0x3000>;
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-			phys = <&ufs_card_phy_lanes>;
+			phys = <&ufs_card_phy>;
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			#reset-cells = <1>;
@@ -956,28 +949,20 @@ ufs_card_hc: ufs@1da4000 {
 
 		ufs_card_phy: phy@1da7000 {
 			compatible = "qcom,sc8280xp-qmp-ufs-phy";
-			reg = <0 0x01da7000 0 0x1c8>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-			clock-names = "ref",
-				      "ref_aux";
+			reg = <0 0x01da7000 0 0x1000>;
+
 			clocks = <&gcc GCC_UFS_1_CARD_CLKREF_CLK>,
 				 <&gcc GCC_UFS_CARD_PHY_AUX_CLK>;
+			clock-names = "ref", "ref_aux";
+
+			power-domains = <&gcc UFS_CARD_GDSC>;
 
 			resets = <&ufs_card_hc 0>;
 			reset-names = "ufsphy";
 
-			status = "disabled";
+			#phy-cells = <0>;
 
-			ufs_card_phy_lanes: phy@1da7400 {
-				reg = <0 0x01da7400 0 0x108>,
-				      <0 0x01da7600 0 0x1e0>,
-				      <0 0x01da7c00 0 0x1dc>,
-				      <0 0x01da7800 0 0x108>,
-				      <0 0x01da7a00 0 0x1e0>;
-				#phy-cells = <0>;
-			};
+			status = "disabled";
 		};
 
 		tcsr_mutex: hwlock@1f40000 {
-- 
2.43.0


