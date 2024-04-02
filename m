Return-Path: <linux-kernel+bounces-128577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A43D895CA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4291F24A02
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF315B991;
	Tue,  2 Apr 2024 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XugYxXbT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146F15B98E;
	Tue,  2 Apr 2024 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086332; cv=none; b=fMbmMGRXpxMLgWrgug2/ajX0jxjTKDKyC/WtAzUyec+XH3GlqSXQLz0S64zud1F6OJQ1tAZPRm1/PpH+E26SPRD48Xv6uJQyhSHgiWm0MsXUqtPpAKQp7ciuSbpDDsCt+Cy6BB1iTP1DpfWjRGT4dN3p+NllzEVllhtAsW5brB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086332; c=relaxed/simple;
	bh=MpW6PX8Bem0CCYfn+8oO3DeXkyhX4lbaoUlF1H22xYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+gMoMLb93VGSuOdWTKoRjy4o8kMtfLtF2IQ9tLbSPApUqYW+/qyMBetGwhex8eTdqIYmFZEJBd1BwXt22TcWBIWiRM0DnMqEfTodGLba4v5kWm31xPATevyr1FfhKxGMdSsgDUf1kYr+oEbM0WS9ZOyOFEfO6gxUe/OxaX6mgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XugYxXbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35208C433F1;
	Tue,  2 Apr 2024 19:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086331;
	bh=MpW6PX8Bem0CCYfn+8oO3DeXkyhX4lbaoUlF1H22xYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XugYxXbTrDJbcJ+2xLQFyO7uzpdwPd4Fd0a/4qTkVLPiU/VWcz1yz+6Srg2X0rwl/
	 4oLjLOyFyum0v8VFZtM3xyBJOSZ29kmZ2Md7YBijOcJPpCHJ4uLI/piZlE0l8h79TU
	 bn3gcrlvI6iOSlpOUOFunmsiQOT4domKQRQUg+KZKRcj3qovOkSGLp1ClKQpTQ+Ge2
	 M38haeryYMprH93aO8W2YMgipIJxfFk3UtNpz1EX+d2GZ89WPT0WW1guqIpJ2HJbln
	 54R3RWRY/XdymEX15XvvnWvlzZClcm3WmqMrp5qlaM9E7BH9EhhJ4fc1rQa/yTARc6
	 kJZwe0ryxGt6w==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 6/9] arm64: dts: hisilicon: hip07: correct unit addresses
Date: Tue,  2 Apr 2024 21:31:45 +0200
Message-Id: <20240402193148.62323-6-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402193148.62323-1-krzk@kernel.org>
References: <20240402193148.62323-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct several nodes' unit addresses to fix dtc W=1 warnings:

  arch/arm64/boot/dts/hisilicon/hip07.dtsi:1382.23-1520.5: Warning (simple_bus_reg): /soc/dsa@c7000000: simple-bus unit address format error, expected "c5000000"
  arch/arm64/boot/dts/hisilicon/hip07.dtsi:1727.29-1747.5: Warning (simple_bus_reg): /soc/pcie@a00a0000: simple-bus unit address format error, expected "af800000"
  arch/arm64/boot/dts/hisilicon/hip07.dtsi:1748.29-1788.5: Warning (simple_bus_reg): /soc/crypto@d2000000: simple-bus unit address format error, expected "d0000000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 9d1e86553ea8..00a6bfa7478c 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1379,7 +1379,7 @@ phy1: ethernet-phy@1 {
 			};
 		};
 
-		dsaf0: dsa@c7000000 {
+		dsaf0: dsa@c5000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "hisilicon,hns-dsaf-v2";
@@ -1724,7 +1724,7 @@ sas2: sas@a3000000 {
 			status = "disabled";
 		};
 
-		p0_pcie2_a: pcie@a00a0000 {
+		p0_pcie2_a: pcie@af800000 {
 			compatible = "hisilicon,hip07-pcie-ecam";
 			reg = <0 0xaf800000 0 0x800000>,
 			      <0 0xa00a0000 0 0x10000>;
@@ -1745,7 +1745,7 @@ p0_pcie2_a: pcie@a00a0000 {
 					 0x0 0 0 4 &mbigen_pcie2_a 671 4>;
 			status = "disabled";
 		};
-		p0_sec_a: crypto@d2000000 {
+		p0_sec_a: crypto@d0000000 {
 			compatible = "hisilicon,hip07-sec";
 			reg = <0x0 0xd0000000 0x0 0x10000>,
 			      <0x0 0xd2000000 0x0 0x10000>,
@@ -1786,7 +1786,7 @@ p0_sec_a: crypto@d2000000 {
 				     <605 1>, <606 4>,
 				     <607 1>, <608 4>;
 		};
-		p0_sec_b: crypto@8,d2000000 {
+		p0_sec_b: crypto@8d0000000 {
 			compatible = "hisilicon,hip07-sec";
 			reg = <0x8 0xd0000000 0x0 0x10000>,
 			      <0x8 0xd2000000 0x0 0x10000>,
@@ -1827,7 +1827,7 @@ p0_sec_b: crypto@8,d2000000 {
 				     <605 1>, <606 4>,
 				     <607 1>, <608 4>;
 		};
-		p1_sec_a: crypto@400,d2000000 {
+		p1_sec_a: crypto@400d0000000 {
 			compatible = "hisilicon,hip07-sec";
 			reg = <0x400 0xd0000000 0x0 0x10000>,
 			      <0x400 0xd2000000 0x0 0x10000>,
@@ -1868,7 +1868,7 @@ p1_sec_a: crypto@400,d2000000 {
 				     <605 1>, <606 4>,
 				     <607 1>, <608 4>;
 		};
-		p1_sec_b: crypto@408,d2000000 {
+		p1_sec_b: crypto@408d0000000 {
 			compatible = "hisilicon,hip07-sec";
 			reg = <0x408 0xd0000000 0x0 0x10000>,
 			      <0x408 0xd2000000 0x0 0x10000>,
-- 
2.34.1


