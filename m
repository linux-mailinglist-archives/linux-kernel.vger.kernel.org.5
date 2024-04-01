Return-Path: <linux-kernel+bounces-126727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22382893C03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D228E2821CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD7B4EB24;
	Mon,  1 Apr 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubGHvdwU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031E4DA05;
	Mon,  1 Apr 2024 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980672; cv=none; b=nwoWWSRJf3YYPCpxl5RfB7JJbS9tmoYmBeICrBybyQ9CA/r2nyanxylGM6EtKE6IjoO4VVvlYKzQMI3m+X9QzsWE7rMtjStDEGsRaMZrDGDQ9itMIXAtDBs/5ZkfOEpe6RmnspwKzCuBowyFlK3dSZzZMALBRzylpQWHCsT7EsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980672; c=relaxed/simple;
	bh=hIEcwI6YKBVieyA1/9Z1S/OrrAxqnZGijqF2GQbbXf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qpE1f3SiBMrMwlYpx4hEqs5PQffBKcraAxBqWuz1tRUFAZy/NChpVxEPkm87SJJCaF7wuvbiIdrQpt7EfJwUjAJnzTOvJ9zQdlad2b6PlAoVoXSv+zc+eZSfrl3UkT8kedVoN8FBL5JUIhbqWr/RAVCI2D1j2T1cPdwsoMW4zE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubGHvdwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EF9C43394;
	Mon,  1 Apr 2024 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980672;
	bh=hIEcwI6YKBVieyA1/9Z1S/OrrAxqnZGijqF2GQbbXf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubGHvdwUHLWc/9GmApJt1szAsJWiD2/dUy0Dg7ABkkoeI2TBBVE7vOP4f+Ozsn5xs
	 zRJ/kKMIal2cDXQEn728w8M7iTBtG5TK5n27vQ4urqVGco2iLZZbJkbsLK/bzoFflW
	 rKRfkb2jNz+8ScclcKHCgLUja931UOIvrQwfQa6+a2U62IL0eEUgIprEcFjyUGuyzM
	 rv3Tz3jfchyVkWNbS72P72qiZtjJZmJvgF/EgjuB9cIAzte8hDiZ+TL/XoGkmqUDz8
	 8AQae8rxDbjKuVKmU6d33yLOVBLo4fz624i+ORUuO5XE07NcKZc0267kXY5ED3cor0
	 tXycN8S/p0+0A==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/6] arm64: dts: marvell: cn9130-crb: drop wrong unit-addresses
Date: Mon,  1 Apr 2024 16:10:50 +0200
Message-Id: <20240401141051.98233-5-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401141051.98233-1-krzk@kernel.org>
References: <20240401141051.98233-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Top-level nodes, not being on MMIO bus, do not have "reg" properties and
should not have unit addresses.  Correct their name as well to match
"Generic node names" recommendation from Devicetree specification.
This also fixes dtc W=1 warnings:

  cn9130-crb.dtsi:29.35-37.4: Warning (unit_address_vs_reg): /ap0_mmc_vccq@0: node has a unit name, but no reg or ranges property
  cn9130-crb.dtsi:39.38-46.4: Warning (unit_address_vs_reg): /cp0_usb3_vbus@1: node has a unit name, but no reg or ranges property
  cn9130-crb.dtsi:57.33-65.4: Warning (unit_address_vs_reg): /cp0_sd_vccq@0: node has a unit name, but no reg or ranges property
  cn9130-crb.dtsi:67.31-75.4: Warning (unit_address_vs_reg): /cp0_sd_vcc@0: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
index 6fcc34f7b464..d48dd6bca6e5 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -26,7 +26,7 @@ memory@0 {
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
-	ap0_reg_mmc_vccq: ap0_mmc_vccq@0 {
+	ap0_reg_mmc_vccq: regulator-1 {
 		compatible = "regulator-gpio";
 		regulator-name = "ap0_mmc_vccq";
 		regulator-min-microvolt = <1800000>;
@@ -36,7 +36,7 @@ ap0_reg_mmc_vccq: ap0_mmc_vccq@0 {
 			  3300000 0x0>;
 	};
 
-	cp0_reg_usb3_vbus1: cp0_usb3_vbus@1 {
+	cp0_reg_usb3_vbus1: regulator-2 {
 		compatible = "regulator-fixed";
 		regulator-name = "cp0-xhci1-vbus";
 		regulator-min-microvolt = <5000000>;
@@ -45,16 +45,16 @@ cp0_reg_usb3_vbus1: cp0_usb3_vbus@1 {
 		gpio = <&expander0 8 GPIO_ACTIVE_HIGH>;
 	};
 
-	cp0_usb3_0_phy0: cp0_usb3_phy0 {
+	cp0_usb3_0_phy0: usb-phy-1 {
 		compatible = "usb-nop-xceiv";
 	};
 
-	cp0_usb3_0_phy1: cp0_usb3_phy1 {
+	cp0_usb3_0_phy1: usb-phy-2 {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&cp0_reg_usb3_vbus1>;
 	};
 
-	cp0_reg_sd_vccq: cp0_sd_vccq@0 {
+	cp0_reg_sd_vccq: regulator-3 {
 		compatible = "regulator-gpio";
 		regulator-name = "cp0_sd_vccq";
 		regulator-min-microvolt = <1800000>;
@@ -64,7 +64,7 @@ cp0_reg_sd_vccq: cp0_sd_vccq@0 {
 			  3300000 0x0>;
 	};
 
-	cp0_reg_sd_vcc: cp0_sd_vcc@0 {
+	cp0_reg_sd_vcc: regulator-4 {
 		compatible = "regulator-fixed";
 		regulator-name = "cp0_sd_vcc";
 		regulator-min-microvolt = <3300000>;
-- 
2.34.1


