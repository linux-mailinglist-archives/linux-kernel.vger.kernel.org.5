Return-Path: <linux-kernel+bounces-115649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FCE889F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A58FB2BC63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C3350807;
	Mon, 25 Mar 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xmxp02pA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01897137758;
	Sun, 24 Mar 2024 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321520; cv=none; b=D0JjSuIS2DyHZstSEXK9/7rmbTDCYinBYkzRYyxmdt7lMIppGRkVQ3iHOatXlX1ShVvdDIWeWb6p3+qxnuXZ/fpamKPOwYZeFI9oTzbwEXvffZBFNWV/To/LiV3kFNSp60Q4+nlxYhmYLd0DFHMBaJYpc59MgCMu0Po027wlAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321520; c=relaxed/simple;
	bh=5W25tBCsJNoKUVIgqMhNPlMepXpG4H0pEB0O1W0SAxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbGXTVVhs+Yq4iwubOzAAcAj6gwzP+NdVZX6JsAMghRPDCjKBewehpKvT4C/i+H+tMWf/6IJ/JpXovHbeaf1/dN3XKRI5BDU9Tnzl8/eCCftoCfRRsZZaDX+ZUlRGtfsqoJKFnCgHqgQOLXouMmYUiD/PXYvY6WOe/kHlWbplfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xmxp02pA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F07C43394;
	Sun, 24 Mar 2024 23:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321519;
	bh=5W25tBCsJNoKUVIgqMhNPlMepXpG4H0pEB0O1W0SAxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xmxp02pABNsH5pVOFv0od8tDJlik/TZiRYbGBOjsozmU8AG+5UwShF9s4sr7UPUiQ
	 mMtwBVHoUr+QKxZDlvAJrkP8fMaefMWdFMZRMj3yFXyC6b48o1tCQdszFFBIcAHXgi
	 A5+1NePDFqwux0a2GAcd5oLVFOo6tC+iuNb2k8uxYLdUe4ZgGGiAMfiPdfG5MpYVn8
	 /RC2IlJDK4Pb2QV9SVKD/vWsfLHbQ9BVO0DK8uaK+V7824ccHXqeOyelK2owHyXhZY
	 nM1+qEdlkkLTXh/C2REAFEYpep+pkEMT5qCRDT4ehVu5Y9ddzhkpTMSm+VMmEdHh02
	 J2eapeF7E12IA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devarsh Thakkar <devarsht@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 246/638] arm64: dts: ti: Add common1 register space for AM62x SoC
Date: Sun, 24 Mar 2024 18:54:43 -0400
Message-ID: <20240324230116.1348576-247-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Devarsh Thakkar <devarsht@ti.com>

[ Upstream commit 7d8ee2c3b8a2aabb9ce75795bad20773bfe1ba13 ]

This adds common1 register space for AM62x SoC which is using TI's Keystone
display hardware and supporting it as described in
Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml

Fixes: 8ccc1073c7bb ("arm64: dts: ti: k3-am62-main: Add node for DSS")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Link: https://lore.kernel.org/r/20240216062426.4170528-4-devarsht@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 6d125c86c2d35..a9b47ab92a02c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -747,9 +747,10 @@ dss: dss@30200000 {
 		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
 		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
 		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Used for OLDI */
-		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
+		      <0x00 0x3020b000 0x00 0x1000>, /* vp2: Used as DPI Out */
+		      <0x00 0x30201000 0x00 0x1000>; /* common1 */
 		reg-names = "common", "vidl1", "vid",
-			    "ovr1", "ovr2", "vp1", "vp2";
+			    "ovr1", "ovr2", "vp1", "vp2", "common1";
 		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 186 6>,
 			 <&dss_vp1_clk>,
-- 
2.43.0


