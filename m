Return-Path: <linux-kernel+bounces-113111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E588818A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B4C282AEA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B28159573;
	Sun, 24 Mar 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKwJcHKH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E59158D9E;
	Sun, 24 Mar 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319919; cv=none; b=CDKaB1etW12UTl79fx+JBRUMU3A1Nhg6rkVyhSseQWaWr1QZ+X7ckY8AQnX8CZt7Q8XTCFAOHaHuH5ZDwhSqNrLoIYfbPr7JPFzhEONnyYkNO5UkacBksE+Rd32ZGllTeqa6wLVQPqhxD28wgh2lHaJpYFnXyyn+U7NM+gnwQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319919; c=relaxed/simple;
	bh=oeEEazOyNiSzqLggZOqEJTHSkyn2RVzqOkN2OREuYNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tI5viuyrRJtIkfsFLAB+g3/wwGJE1MuJK63EavPIXgTO810/6fvOGZBlz2cI2ccM47ob3XBv/gvHCrNnwCtOuSBz5/9ypIMOptUuNraCrrNeaURBlFfVoqYRWFfA215U+GV/GXXtEZD/VQzO11yIZFUhZsjpmKYG1+0n8F8PqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKwJcHKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D02C433F1;
	Sun, 24 Mar 2024 22:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319918;
	bh=oeEEazOyNiSzqLggZOqEJTHSkyn2RVzqOkN2OREuYNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKwJcHKHO4e6qFxHO5VP/0gB8YEBRDiGy+qeh1UAFvFeXuqh2JPnsLVI7g+2AVZYU
	 hPfO5JEVlmkDXJDc1Ut3iHHsYlmFL3CCGNMUBF6QYPiPUvjo610g9zSEfxXZwM5Uqw
	 WqU9LD8eGePb/UHcsu76MU1G9K114mcTIGMGxrs1Bkz/b4/+WM1HtLA5XzKXKS8U5k
	 ge+bUCgMOSMA2bRCiXWfBtTpuq81sgAbRvPGmROQO7uXlGqkNgn5iSFVSz6uMET+m4
	 92GC5/nieZDyJr/8mBePV7Ur/Wi6gisjd42v7p4LUjjyFvTH5PTPABzFBS4QfSjM+K
	 w8u1OQh/Ylk0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devarsh Thakkar <devarsht@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 224/715] arm64: dts: ti: Add common1 register space for AM62x SoC
Date: Sun, 24 Mar 2024 18:26:43 -0400
Message-ID: <20240324223455.1342824-225-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index c49fbce5cb707..6d07b65a3614e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -783,9 +783,10 @@ dss: dss@30200000 {
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


