Return-Path: <linux-kernel+bounces-113680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C628885FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EF328CE57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F3A1E065B;
	Sun, 24 Mar 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wcx6Sj2I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C41D8BB6;
	Sun, 24 Mar 2024 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320642; cv=none; b=GaETd+bLJ3vYYTPHUyENVvSB5cR720uYhu9SOmYxrrgA0Gpq9mA/tjw32b0Rw0LEfyVaVKykP4YeCy2jlxWBcAvDILVQYX+BlfkkzvQL8OpmmWbdWt0BHvA2VEyGUtuANPHspUqxWqCDJrBlyoN2nWuI2EleQOb2VDdbfupK4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320642; c=relaxed/simple;
	bh=k7YMyN9XUWIVYZrAOUT9qbPDF7I17RHxw0+eDlMF5jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWdRH5AVmZXkHrSu7FvrYVnJBubKNHna/fb7bEm+sprUORXb+0s9ohvrC2zbqRhmEYsKGxQSjjCNluQ9DzDVj20mWUEbmN8WJrAsaO/VYVf7K14Ft0QfB4xvXtCi6Al2cuQnJgfKCLxYpW8u+eomsySM4zHD4q8fpH57L63QGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wcx6Sj2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6DAC433C7;
	Sun, 24 Mar 2024 22:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320640;
	bh=k7YMyN9XUWIVYZrAOUT9qbPDF7I17RHxw0+eDlMF5jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wcx6Sj2IW/HvBJkc6Rt01KJq+hD9x9jNxlSb8fvO34sA/hgrHmwvTANOevjpSPbFr
	 jPjQSg/urYqN95uRTHgZs5tIECh5+QD8Ammh2M3tUzsczdnclFr1tH2xpgWe/j7i4E
	 6rXwj4dc1pyiqBRDfFarx1RMDB3z9t2r/d3iO5xdqNtoCfotRRnSrgXr8UyNAxduGC
	 Weqqb4D6YPGjg3WRe+ruadnr9WSsJVfTlstXee3FB3Gw9BLln2/DNJodq7zRMSsTAH
	 6YNnevi7AEM263DlJooErCXOQ/QExIw4HmcxVFH/7dqhZM/fapYaf09BVzQBbsz6iU
	 /Kro8kMO8116w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Jai Luthra <j-luthra@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 202/713] arm64: dts: ti: k3-am62p5-sk: Enable CPSW MDIO node
Date: Sun, 24 Mar 2024 18:38:48 -0400
Message-ID: <20240324224720.1345309-203-sashal@kernel.org>
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

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

[ Upstream commit 8839a9af397e803e0447a6b3e69fad54ed22d26d ]

Enable the CPSW MDIO node, and link the pinctrl information to enable
ethernet on SK-AM62P.

Ethernet was unintentally broken on this board, even though these nodes
were already present, as enabling them was missed in the original
patch.

Fixes: c00504ea42c0 ("arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM")
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Link: https://lore.kernel.org/r/20240201-am62p_cpsw_mdio-v1-1-05f758300f6e@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index f377eadef0c12..04e51934d24ca 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -445,6 +445,10 @@ &cpsw_port2 {
 };
 
 &cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins_default>;
+	status = "okay";
+
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-- 
2.43.0


