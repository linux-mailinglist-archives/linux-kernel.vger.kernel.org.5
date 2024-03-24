Return-Path: <linux-kernel+bounces-113037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6486B8880F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFBF1C2131A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA113DBB2;
	Sun, 24 Mar 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPDAfp7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3B13DB8A;
	Sun, 24 Mar 2024 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319847; cv=none; b=M3NQS/VWj8xPGtSK6JO+zyG44E8zzyT7rwB2qbo+lMIhesl2epg8d0bBzL3C1LYQewc9eM4FOwliyrtDKDwcZBy0blGzoZV7zzXqO4XvU+w6bsAfirJ12fkyfdjTtG+/AHB4JQnq0ZNAg+HrTfDEDRKSch7+szTUu0z7e748GvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319847; c=relaxed/simple;
	bh=rG5XrogOSq/XWBkIgCSJ3+HmAxbP/ixfn56h6FYIyuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI+/+dEr7b2Et541CJ79suyu4h2unYS1phKalObyvPdsafnbyoXZvVh7iSpI6RggB9E2AtmOgJUhV2qYkatKeOSV8MAfeAdDGj8uf56kV7sWvTeZMyfJGncCy3/wSJ+ZvQ9CQ6AFmVmeyAieUKc9kiraJ4bRg8K1zlC1LtOQUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPDAfp7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75148C43394;
	Sun, 24 Mar 2024 22:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319847;
	bh=rG5XrogOSq/XWBkIgCSJ3+HmAxbP/ixfn56h6FYIyuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPDAfp7N4k+hNewM5qQg30HGgUaoi/mmyEG/0zq9Oz3wNryMG1pl1OAh0yuKdFwD+
	 PMRKPCCeaLHDkCjD0SA2WOQeVhSI5DOzxgjjtui9rvZMaAzbhKIpTPLXiXdLlx7zbk
	 LJSuVOEDO5syhzTOBPhKw5ak21f0WC/gdZu2tUfjYv5oKQ/gxdp0vuFGWwQjXJkTPa
	 guh41tuKHU+8EJyy1/dMTVVjrn5WbvZ+7P3Kz/es53S5VrVNJ/zIQEUEIYASK0AspY
	 xtqm2vgAjUYUCUv4N4FixlSxU8DE0AjXuzUC5T0UcSIlXm7hBaEq93EGjRf+dNneU1
	 cqZmpdVHLMMug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vaishnav Achath <vaishnav.a@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 150/715] arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and wakeup R5FSS nodes
Date: Sun, 24 Mar 2024 18:25:29 -0400
Message-ID: <20240324223455.1342824-151-sashal@kernel.org>
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


