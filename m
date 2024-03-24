Return-Path: <linux-kernel+bounces-113030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4BE8880E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906241C2130A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AB413AA3E;
	Sun, 24 Mar 2024 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpZkxxAr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17F13A89C;
	Sun, 24 Mar 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319840; cv=none; b=lYNSm/6WxtcCe8RXHyJ6sL99YMl4jqyFLr/kkXXdeiCDMqB+Z8MM9NPeixg+WRaZ6BRkXhLibbkDfzIw8GazUdfgA9W4st/7CN16H3KczcIGBdFohGuWLtH3001hi7Zhl5nf+R/8KmakxzO/3qlkl5njreThevD0YQF9TfYsjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319840; c=relaxed/simple;
	bh=WdOioiW+2XSsShu2o9vngQVtVbR3+sZyIsXaFbAZv54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3X7Y1Ri/J2ftBo8jJPqvNLCHSYZD4+/0qN1vl52pwRZiVJ2GDKGZ6vLNG16XRSVH0nzSwZ5UsA2O8MTHfvIamEvg453M/4gAm+XrsVYypFsSlMYtRWkZrXN0KJxurG4dxKg7yZ2G4qtx11fIXPP8lYrXcEBElBYrTx4BqYbXUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpZkxxAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73518C43399;
	Sun, 24 Mar 2024 22:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319840;
	bh=WdOioiW+2XSsShu2o9vngQVtVbR3+sZyIsXaFbAZv54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpZkxxArddvOtJl6vSh1Sau4IgUO5h6yzqReCOk9WSKflP409tSexVpR3F59AWYaA
	 jWnOIapGF2IFjk2dHy5qCQwt0bu3qSqfGFfkh+K3OAL831u5Ka4rpJ6ws11R9opQA5
	 8xp8qDE+qhDaMtxyUgaJbD5JnVJZXc2BCrmDH9bcIrkN8en+MDbz51OZOJOYc4VYio
	 akoTOFIymTldffBnP0PVwUwfmg8Q/G8BCtCf/O+UyVivPG3lLoyFyjkiuzlJR5M3LX
	 clHOcwHPzKNx07CR1zrBA9hwxLYbJG99o3n7nOyBokOHLLTm3dtiFOhxeR7v3kmpeC
	 dYcAUAEoVC7xQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Jai Luthra <j-luthra@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 143/715] arm64: dts: ti: k3-am62p5-sk: Enable CPSW MDIO node
Date: Sun, 24 Mar 2024 18:25:22 -0400
Message-ID: <20240324223455.1342824-144-sashal@kernel.org>
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
index 1773c05f752cd..60868862e3b43 100644
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


