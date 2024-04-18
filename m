Return-Path: <linux-kernel+bounces-150732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715FF8AA3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D662284C56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10E019069B;
	Thu, 18 Apr 2024 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUWltMsZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142719067C;
	Thu, 18 Apr 2024 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471009; cv=none; b=YcdtAs/DLLjxBFvgimjR925XNsXrrVpT3WKGZBZkDDQ8FSUn0OIBhPXeotb+v0zsyWP7fjWJh6gChyexvJx3R+Twahsqlp5X+7rEHFZufdbqrwtJu6DP1hx1Z9Itlz/QEsl2dwk4peLj0511ySY+B5p8JLGrYpb7z3J+T9u8+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471009; c=relaxed/simple;
	bh=h4USdSWrObqaShpccdjzCvfL0FvhrtPROlPptuSSiLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+nmLi9st8xgDhyCcdBev0LNDn23nNUekSfhaDDKTNCruK7Ymvju0aDxW7N/ooQtps82sa1dmjKePsbC7iyVRMOapm1dWcmztUmMV2202DvpPwADw7ZVxglBnH2gTO0o48e5d0qs3cX0BrLEVHfbxq46UHro1loGFosX3K+26OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUWltMsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2035C113CC;
	Thu, 18 Apr 2024 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713471008;
	bh=h4USdSWrObqaShpccdjzCvfL0FvhrtPROlPptuSSiLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rUWltMsZ6VPntRp6y4U+QHQ+4xtS8rjX4+FYb4cin/PwkgpuIEgaAApMw+10WVMZW
	 yFzAUfWLwjc2Qos6kfN+zHy1sS6f3x0UixcWRjNnoWHzewCbM63yFa1Nad+qpSHnVS
	 tlNch7Wy0LBufrSrjVDLNDnVwhlfMwkHjeErHgTVFOc5NKJU1M0/NxfsY8RecMFLyL
	 sfqbbKWXtjw3Y6jrGxN/MP9cyC6FcHpMFEesVOotyLEcNyMBXwkbGXrgYcd8H3bt6R
	 +KNo0WHZm5vMj5nXvUzd60jy4AYqocwtW/Bp9WQB777z39u9nIraRrWO4TWfgIMwDn
	 nrg4ztiOLNBWQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 18 Apr 2024 15:09:25 -0500
Subject: [PATCH 1/2] arm64: dts: freescale: ls1028a: Fix embedded PCI
 interrupt mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dt-ls1028a-pci-fixes-v1-1-95f17405e481@kernel.org>
References: <20240418-dt-ls1028a-pci-fixes-v1-0-95f17405e481@kernel.org>
In-Reply-To: <20240418-dt-ls1028a-pci-fixes-v1-0-95f17405e481@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.14-dev

PCI devices should use PCI interrupt binding for their interrupts assuming
they function as standard PCI interrupts. The embedded PCI devices in the
LS1028a are mapping the interrupts directly to the host interrupt
controller. While that works here, it is unusual.

Based on the reference manual, there is not any INTC or INTD to map, so
only INTA and INTB are mapped.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index ae534c23b970..8f8179924851 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1099,6 +1099,10 @@ pcie@1f0000000 { /* Integrated Endpoint Root Complex */
 				  0xc2000000 0x1 0xf8230000  0x1 0xf8230000  0x0 0x020000
 				  /* BAR4 (PF5) - non-prefetchable memory */
 				  0x82000000 0x1 0xfc000000  0x1 0xfc000000  0x0 0x400000>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 
 			enetc_port0: ethernet@0,0 {
 				compatible = "fsl,enetc";
@@ -1143,7 +1147,7 @@ ethernet@0,4 {
 			mscc_felix: ethernet-switch@0,5 {
 				reg = <0x000500 0 0 0 0>;
 				/* IEP INT_B */
-				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <2>;
 				status = "disabled";
 
 				mscc_felix_ports: ports {
@@ -1216,7 +1220,7 @@ fixed-link {
 			rcec@1f,0 {
 				reg = <0x00f800 0 0 0 0>;
 				/* IEP INT_A */
-				interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <1>;
 			};
 		};
 

-- 
2.43.0


