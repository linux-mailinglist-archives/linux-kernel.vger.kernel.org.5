Return-Path: <linux-kernel+bounces-113684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A019888601
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09951F22875
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65F1E16A4;
	Sun, 24 Mar 2024 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNFPoKDn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A373DB97;
	Sun, 24 Mar 2024 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320648; cv=none; b=fugrPfQJHNsG67IrT+qtmwRYiAt5NHs1IqxpCOMeqHGEgJUDMIfeg7Rowts6rLBcFRjEt737gGK9IeGIWo3+yZY91GVmujqOXAbiEKhD4f3INlxs7oEDFrZFeD+3OXOQdgbb9L2snhFSNpvrEJ1MmDLP7Wuj9gBmyIocguaay0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320648; c=relaxed/simple;
	bh=rG5XrogOSq/XWBkIgCSJ3+HmAxbP/ixfn56h6FYIyuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XA1UBpZvWUsuNpR4F7joWqDzdITk144op6yqceVv8hR2aKLu78rJSukzE+0nAuGBPaO8a6DioQkyxdPlQvuKyLCoFcXLuV0rHGVOwldyj980V1SpUtzUvNyLFSfNpCpz5yBThIyd6JVCEFNaHYZisBf9ND0ZnN04hjyVM0f3DGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNFPoKDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C45C433C7;
	Sun, 24 Mar 2024 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320647;
	bh=rG5XrogOSq/XWBkIgCSJ3+HmAxbP/ixfn56h6FYIyuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNFPoKDnbu9Za2iU0xg+Pv2A57Cw5aotcfvAC6P49T+4qQIouKtxDYMm7hb6NYPhZ
	 sWgzZ6u9mtMwAl464uE6ex3PQZBTu+AkK3dU9MzWklXsaWuy6H8/QcHW66TEy8JxxE
	 mWoGC0fEeyt7n9F5Ol0UxJ0gYZDKFPlem4iYbDE94qcwm5Dbg55QyQey08orRskv21
	 d0TmS0OZOrNly1w2t4GUduBAXxxCXFUknBkijqDz+KmjYY2pWSAXEEQ/yyWT+k2QHI
	 J71X1E/uIflq7urQXlR/9Ak2pXOe7nvCmZQfm6gtICAzNyCPuBdL2P0E97/0b3Pw+s
	 Gs6wO5Dl7/Gvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vaishnav Achath <vaishnav.a@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 208/713] arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and wakeup R5FSS nodes
Date: Sun, 24 Mar 2024 18:38:54 -0400
Message-ID: <20240324224720.1345309-209-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Vaishnav Achath <vaishnav.a@ti.com>

[ Upstream commit dfc90e5f1a0fe0f8124521bc1911e38aa6cd9118 ]

K3 Remoteproc R5 driver requires reserved memory carveouts and
mailbox configuration to instantiate the cores successfully.
Since this is a board level dependency, keep the R5 subsytem
disabled at SoC dtsi, otherwise it results in probe errors like
below during AM62P SK boot:

r5fss@79000000: reserved memory init failed, ret = -22
r5fss@79000000: k3_r5_cluster_rproc_init failed, ret = -22
r5fss@78000000: reserved memory init failed, ret = -22
r5fss@78000000: k3_r5_cluster_rproc_init failed, ret = -22

Fixes: b5080c7c1f7e ("arm64: dts: ti: k3-am62p: Add nodes for more IPs")

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20240121134017.374992-1-vaishnav.a@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi    | 2 ++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
index c4b0b91d70cf3..14eb9ba836d32 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
@@ -187,6 +187,8 @@ mcu_r5fss0: r5fss@79000000 {
 		ranges = <0x79000000 0x00 0x79000000 0x8000>,
 			 <0x79020000 0x00 0x79020000 0x8000>;
 		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
 		mcu_r5fss0_core0: r5f@79000000 {
 			compatible = "ti,am62-r5f";
 			reg = <0x79000000 0x00008000>,
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
index 19f42b39394ee..10a7059b2d9b5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
@@ -78,6 +78,7 @@ wkup_r5fss0: r5fss@78000000 {
 		ranges = <0x78000000 0x00 0x78000000 0x8000>,
 			 <0x78100000 0x00 0x78100000 0x8000>;
 		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		wkup_r5fss0_core0: r5f@78000000 {
 			compatible = "ti,am62-r5f";
-- 
2.43.0


