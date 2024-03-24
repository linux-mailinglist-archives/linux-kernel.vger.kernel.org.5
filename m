Return-Path: <linux-kernel+bounces-115882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCDF8894CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D16F1C2F47C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB53839B8;
	Mon, 25 Mar 2024 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huswURFY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B41482F5;
	Sun, 24 Mar 2024 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322104; cv=none; b=HZ2u/Cjsv/tsPeQUs8NL4QoSPvxFZpcRuY716gooI3qxQKmBZT8iVMuDXvzMYFHnkk4JZEUTdLrgObTZxn+YdLmW1GdUzzNqmdjRoL+eSH/UDs3O5+VvHXTfUYP6yLlc0A0f9lZyAsa8dVZLE7PduxRpopgiXpBIdCFcoq69fjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322104; c=relaxed/simple;
	bh=Jv4YL/dREvOGuz0kUMPR0GOmR4M/8pIuTM27ESZPteI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5BNayp2jlHmsX0hXptUoVMvEdNQKZmtI/2kYy6h1NlDQIkDBX8aWFZJ9uzZBeu7fR1ypYvi/zsfA+P1LdsHWrcbRuExDy6s5TyohUKOV347khNSTVwBFi6Sobc+jnQEdKi3CKP6laNd7JpkFbATtbXSTiFtYBqGIE2gzth7SO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huswURFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCD4C433F1;
	Sun, 24 Mar 2024 23:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322103;
	bh=Jv4YL/dREvOGuz0kUMPR0GOmR4M/8pIuTM27ESZPteI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huswURFYGosdCAPMZf55ZYF3Gp5Dw4ukPhB3AUyn8+JS5q3Ud5PBsCbwc/feXxTk7
	 OyJXG6sbF2+MQkWTJlj///8bpubvrb91M1IzSl5Gky5fP6OfkGTgyAPrXuyx0vb88b
	 v3LxtzrBDKwv8tT4PnhoKKKjTtZF+ByTTSd1mbMnZMq7HaUaGCTWTNEM0fY1zc4MeQ
	 gaexxdHfAHowJ2MBafKwBkDuljSEi/vZznIXJ0b8bxJ2ZJ77pWIU7sqiH9pCCJtlxs
	 Dmw5OAeJvs0imlX5VHpN7n3/NbEiKjG4x2vhULXe3u8JoCuZFB8FzYbyqyc3vRYW75
	 WsU9tJ+NCSylQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 178/451] ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the switch node
Date: Sun, 24 Mar 2024 19:07:34 -0400
Message-ID: <20240324231207.1351418-179-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michal Vokáč <michal.vokac@ysoft.com>

[ Upstream commit 79978bff2e4b8e05ebdf5fc3ee6b794002393484 ]

We identified that the PHYs actually do not work since commit 7da7b84fee58
("ARM: dts: imx6dl-yapp4: Move phy reset into switch node") as
a coincidence of several circumstances.

The reset signal is kept asserted by a pull-down resistor on the board
unless it is deasserted by GPIO from the SoC. This is to keep the switch
dead until it is configured properly by the kernel and user space.

Prior to the referenced commit the switch was reset by the FEC driver
and the reset GPIO was actively deasserted. The mdio-bus was scanned
and the attached switch and its PHYs were found and configured.

With the referenced commit the switch is reset by the qca8k driver.
Because of another bug in the qca8k driver, functionality of the reset
pin depends on its pre-kernel configuration. See commit c44fc98f0a8f
("net: dsa: qca8k: fix illegal usage of GPIO")

The problem did not appear until we removed support for the switch
and configuration of its reset pin from the bootloader.

To fix that, properly describe the internal mdio-bus configuration of
the qca8334 switch. The PHYs are internal to the switch and sit on its
internal mdio-bus.

Fixes: 7da7b84fee58 ("ARM: dts: imx6dl-yapp4: Move phy reset into switch node")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 23 ++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index a655b945bf2df..4b7aee8958923 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -118,14 +118,6 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		phy_port2: phy@1 {
-			reg = <1>;
-		};
-
-		phy_port3: phy@2 {
-			reg = <2>;
-		};
-
 		switch@10 {
 			compatible = "qca,qca8334";
 			reg = <0x10>;
@@ -150,15 +142,30 @@ fixed-link {
 				eth2: port@2 {
 					reg = <2>;
 					label = "eth2";
+					phy-mode = "internal";
 					phy-handle = <&phy_port2>;
 				};
 
 				eth1: port@3 {
 					reg = <3>;
 					label = "eth1";
+					phy-mode = "internal";
 					phy-handle = <&phy_port3>;
 				};
 			};
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				phy_port2: ethernet-phy@1 {
+					reg = <1>;
+				};
+
+				phy_port3: ethernet-phy@2 {
+					reg = <2>;
+				};
+			};
 		};
 	};
 };
-- 
2.43.0


