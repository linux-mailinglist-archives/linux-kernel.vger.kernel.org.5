Return-Path: <linux-kernel+bounces-150733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326038AA3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B5D1C211CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BED194C8A;
	Thu, 18 Apr 2024 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maHvPThe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8794194C74;
	Thu, 18 Apr 2024 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471012; cv=none; b=ePqrDT9fibwiYoUiz81zeC16K+83GgMHCVCCsr1mEImJYxHF+dUH6Hd9vV8gxuuRLxzUvSHJddBNxe8W2lcUYJClXnevTLaEAq5IeHq4vxcAd+O8DQWzr5izV6rABnVyJYfvJgPmzqCT+XqdpzA2FYuFkd/e43bsZZtRfg+Uhkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471012; c=relaxed/simple;
	bh=1jbCnAE/ii2sK8qE3QI3BU+zcM+GW4I6gtOic2jfh/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmsU54OAnTsQ0wD3MwQwEjVCsm+YKFRHbalY4mpPiimUb76PWkNyhQ1rN9r+bJD2obdAPe2y3AZ4+9Ad4uxhiMz49cA705tcM7B9DFB0NMwX+GUmm6wRyJw6uXa+3gEuIvlGLaglybZDXoJHPyHQR5lsrpK2/2JqNdExJvs7/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maHvPThe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328C4C113CC;
	Thu, 18 Apr 2024 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713471011;
	bh=1jbCnAE/ii2sK8qE3QI3BU+zcM+GW4I6gtOic2jfh/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=maHvPTheexlW8Hckm36c6THqkXj57VC9Zg+iPO0oegPO6TEP0a1soaMRmcPLmKWWj
	 UyFCY74mwJmUQtjH1WYEBvEtOahlhTSp7VrzaqrMlRYRzNW/p/J6eAMLiVEVZ1dMDn
	 zZzutXtm3NY7JZ1JuRRVO/Ux2qXq2leHoOGwtqr0K4g82CFWe+Ua0paI2LK1CUdJWN
	 gHciySLXMJ+PjNNgZWE4gythG/pdNz+gKMEjzlaXWP5IQB1sqa8U/QemeyunOUQr7C
	 MFvShtooBgsgX7FUbrpXRmPMX9n/578Qxq11X3vSd1GlikpEx6bWtt3a1+OpydIRLe
	 8FyV/FAINIJ1Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 18 Apr 2024 15:09:26 -0500
Subject: [PATCH 2/2] arm64: dts: freescale: ls1028a: Add standard PCI
 device compatible strings to ENETC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dt-ls1028a-pci-fixes-v1-2-95f17405e481@kernel.org>
References: <20240418-dt-ls1028a-pci-fixes-v1-0-95f17405e481@kernel.org>
In-Reply-To: <20240418-dt-ls1028a-pci-fixes-v1-0-95f17405e481@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.14-dev

PCI devices should have a compatible string based on the vendor and device
IDs. Add these to the Freescale ENETC devices.

Putting the PCI compatible string first as vendor and device ID is more
specific than a compatible without any device specific information.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 8f8179924851..70b8731029c4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1105,19 +1105,19 @@ pcie@1f0000000 { /* Integrated Endpoint Root Complex */
 					<0000 0 0 2 &gic 0 0 GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 
 			enetc_port0: ethernet@0,0 {
-				compatible = "fsl,enetc";
+				compatible = "pci1957,e100", "fsl,enetc";
 				reg = <0x000000 0 0 0 0>;
 				status = "disabled";
 			};
 
 			enetc_port1: ethernet@0,1 {
-				compatible = "fsl,enetc";
+				compatible = "pci1957,e100", "fsl,enetc";
 				reg = <0x000100 0 0 0 0>;
 				status = "disabled";
 			};
 
 			enetc_port2: ethernet@0,2 {
-				compatible = "fsl,enetc";
+				compatible = "pci1957,e100", "fsl,enetc";
 				reg = <0x000200 0 0 0 0>;
 				phy-mode = "internal";
 				status = "disabled";
@@ -1130,14 +1130,14 @@ fixed-link {
 			};
 
 			enetc_mdio_pf3: mdio@0,3 {
-				compatible = "fsl,enetc-mdio";
+				compatible = "pci1957,ee01", "fsl,enetc-mdio";
 				reg = <0x000300 0 0 0 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
 
 			ethernet@0,4 {
-				compatible = "fsl,enetc-ptp";
+				compatible = "pci1957,ee02", "fsl,enetc-ptp";
 				reg = <0x000400 0 0 0 0>;
 				clocks = <&clockgen QORIQ_CLK_HWACCEL 3>;
 				little-endian;
@@ -1205,7 +1205,7 @@ fixed-link {
 			};
 
 			enetc_port3: ethernet@0,6 {
-				compatible = "fsl,enetc";
+				compatible = "pci1957,e100", "fsl,enetc";
 				reg = <0x000600 0 0 0 0>;
 				phy-mode = "internal";
 				status = "disabled";

-- 
2.43.0


