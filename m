Return-Path: <linux-kernel+bounces-126733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0917D893C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B394D1F24118
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF65337F;
	Mon,  1 Apr 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA9t1hYJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E2535B5;
	Mon,  1 Apr 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980706; cv=none; b=I31iDObh0dzJD0IUVtJ4kQKB9ln5pqYlPRZPTcAh6JC+sEjQ0Kgb9OqHOkzpWDRec8mDNPtUb+GkqrHkb7eK8gB6hvR3UhYXS95QxAJMl+FGvmfTJ0mbToFiVqJuhmCsltYdD2rqucGRt5hEZW95acJKhexXyZfwFMgLsC06A5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980706; c=relaxed/simple;
	bh=7YKueyhgS9qTuYqs8FtNtLDSmanBAOxpbsa2jb1AonU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rh5yIU81zBhfPvB7IoLF7tshqbgdArsDO1dJ2bNaEaUXiYc3Pq3tCV+23DWE9BnmVb0pDAv/F1hXsHSp7W8yWo0b4EeYI6vQV+4Apw6Dw+mOQhBzJur+0nojxURiTCv3MvIU4EKAl90ZRohW72dctc9iaTBubjZSQB/i2Uu1jVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA9t1hYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EB6C43394;
	Mon,  1 Apr 2024 14:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980706;
	bh=7YKueyhgS9qTuYqs8FtNtLDSmanBAOxpbsa2jb1AonU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dA9t1hYJhSFwqkYUYntmy6iMEiAXNB8eK6BE8IbP1OrhLfq5rDLBvFzl6UdUkqdZh
	 0SP4UybqF8c/Vo1nSeFTuoe1w1ejCMEutpv9gByxTknN2VImSkuzQiZrirTnxmmUQn
	 Q/JM4915QG32oUioLJvX+0OriuZe/zzdcftOZti/KZErQCV7taMXsERknngtdbXNHA
	 +VqpVoGSjuwlVjvVmGAqEdRMTTWuD2kmcinLZ0cw6yanGHFSfidBqvf+ZsL+UPM+zu
	 2fD15tve2IBR5YhOkBX4unn4MnhVeRDrDRrYRwo1JE23UA49ZbFoDm7G5gsg+EnV6K
	 /DObeuKdOkIhg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/5] arm64: dts: sharkl3: add missing unit addresses
Date: Mon,  1 Apr 2024 16:11:28 +0200
Message-Id: <20240401141128.98317-5-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401141128.98317-1-krzk@kernel.org>
References: <20240401141128.98317-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nodes with "reg" property are supposed to have unit address, as reported
by dtc W=1 warning:

  sharkl3.dtsi:42.23-48.6: Warning (unit_address_vs_reg): /soc/syscon@402b0000/pmu-gate: node has a reg or ranges property, but no unit name
  sharkl3.dtsi:59.29-63.6: Warning (unit_address_vs_reg): /soc/syscon@402e0000/aonapb-gate: node has a reg or ranges property, but no unit name
  sharkl3.dtsi:74.13-80.6: Warning (unit_address_vs_reg): /soc/syscon@40353000/pll: node has a reg or ranges property, but no unit name
  sharkl3.dtsi:91.15-95.6: Warning (unit_address_vs_reg): /soc/syscon@40359000/mpll: node has a reg or ranges property, but no unit name
  sharkl3.dtsi:106.15-112.6: Warning (unit_address_vs_reg): /soc/syscon@4035c000/rpll: node has a reg or ranges property, but no unit name
  sharkl3.dtsi:123.15-127.6: Warning (unit_address_vs_reg): /soc/syscon@40363000/dpll: node has a reg or ranges property, but no unit name
  sharkl3.dtsi:138.21-142.6: Warning (unit_address_vs_reg): /soc/syscon@60800000/mm-gate: node has a reg or ranges property, but no unit name
  sharkl3.dtsi:153.27-159.6: Warning (unit_address_vs_reg): /soc/syscon@71300000/apapb-gate: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/sprd/sharkl3.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sharkl3.dtsi b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
index 206a4afdab1c..9b4ee0bdd69f 100644
--- a/arch/arm64/boot/dts/sprd/sharkl3.dtsi
+++ b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
@@ -24,7 +24,7 @@ ap_ahb_regs: syscon@20e00000 {
 			#size-cells = <1>;
 			ranges = <0 0 0x20e00000 0x4000>;
 
-			apahb_gate: apahb-gate {
+			apahb_gate: apahb-gate@0 {
 				compatible = "sprd,sc9863a-apahb-gate";
 				reg = <0x0 0x1020>;
 				#clock-cells = <1>;
@@ -39,7 +39,7 @@ pmu_regs: syscon@402b0000 {
 			#size-cells = <1>;
 			ranges = <0 0 0x402b0000 0x4000>;
 
-			pmu_gate: pmu-gate {
+			pmu_gate: pmu-gate@0 {
 				compatible = "sprd,sc9863a-pmu-gate";
 				reg = <0 0x1200>;
 				clocks = <&ext_26m>;
@@ -56,7 +56,7 @@ aon_apb_regs: syscon@402e0000 {
 			#size-cells = <1>;
 			ranges = <0 0 0x402e0000 0x4000>;
 
-			aonapb_gate: aonapb-gate {
+			aonapb_gate: aonapb-gate@0 {
 				compatible = "sprd,sc9863a-aonapb-gate";
 				reg = <0 0x1100>;
 				#clock-cells = <1>;
@@ -71,7 +71,7 @@ anlg_phy_g2_regs: syscon@40353000 {
 			#size-cells = <1>;
 			ranges = <0 0 0x40353000 0x3000>;
 
-			pll: pll {
+			pll: pll@0 {
 				compatible = "sprd,sc9863a-pll";
 				reg = <0 0x100>;
 				clocks = <&ext_26m>;
@@ -88,7 +88,7 @@ anlg_phy_g4_regs: syscon@40359000 {
 			#size-cells = <1>;
 			ranges = <0 0 0x40359000 0x3000>;
 
-			mpll: mpll {
+			mpll: mpll@0 {
 				compatible = "sprd,sc9863a-mpll";
 				reg = <0 0x100>;
 				#clock-cells = <1>;
@@ -103,7 +103,7 @@ anlg_phy_g5_regs: syscon@4035c000 {
 			#size-cells = <1>;
 			ranges = <0 0 0x4035c000 0x3000>;
 
-			rpll: rpll {
+			rpll: rpll@0 {
 				compatible = "sprd,sc9863a-rpll";
 				reg = <0 0x100>;
 				clocks = <&ext_26m>;
@@ -120,7 +120,7 @@ anlg_phy_g7_regs: syscon@40363000 {
 			#size-cells = <1>;
 			ranges = <0 0 0x40363000 0x3000>;
 
-			dpll: dpll {
+			dpll: dpll@0 {
 				compatible = "sprd,sc9863a-dpll";
 				reg = <0 0x100>;
 				#clock-cells = <1>;
@@ -135,7 +135,7 @@ mm_ahb_regs: syscon@60800000 {
 			#size-cells = <1>;
 			ranges = <0 0 0x60800000 0x3000>;
 
-			mm_gate: mm-gate {
+			mm_gate: mm-gate@0 {
 				compatible = "sprd,sc9863a-mm-gate";
 				reg = <0 0x1100>;
 				#clock-cells = <1>;
@@ -150,7 +150,7 @@ ap_apb_regs: syscon@71300000 {
 			#size-cells = <1>;
 			ranges = <0 0 0x71300000 0x4000>;
 
-			apapb_gate: apapb-gate {
+			apapb_gate: apapb-gate@0 {
 				compatible = "sprd,sc9863a-apapb-gate";
 				reg = <0 0x1000>;
 				clocks = <&ext_26m>;
-- 
2.34.1


