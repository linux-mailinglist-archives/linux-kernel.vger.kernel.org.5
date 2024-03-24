Return-Path: <linux-kernel+bounces-116031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B5B88961C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E62EB39F85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD0526E61B;
	Mon, 25 Mar 2024 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0ZA34m4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E122779D7;
	Sun, 24 Mar 2024 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323412; cv=none; b=Fj6mT6MCiVJhbVKkFS5iAQsLKwkoqHOTi/i8WWlxNQX56d4oOCfaBS54LnJNbev0SYvx98+AXzDjJnsnY/jIaHWsaGkMMdI759X7zrPWYkVvT10QAz86V7vVNleUClz2DgpCn+7P5tBd4lsL2LWoP4Y1GOydDRiSr8vLcbqrsYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323412; c=relaxed/simple;
	bh=vI7cyIplM0mY+XAcjngitzBuY6u1HBmAHntcvWfZL/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJQd8pytrDq+AWIf5QenA2I46YHqwm+CbJb+Yf8IiIB6ERu2VpRQF/GuThE6HYMi5c34z3av7wI8ygEz7jJ/crPYwDBFeFdidLYUeVcSn9x+75YA3PgVFcIX/WRt2WPfFk1NvNesh/cRpyJRqV9dZfMYk10G9n0AeJKr6fnD3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0ZA34m4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E4EC43390;
	Sun, 24 Mar 2024 23:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323412;
	bh=vI7cyIplM0mY+XAcjngitzBuY6u1HBmAHntcvWfZL/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0ZA34m4kQaaa6vEwKbk03l4mhH3UrzsPdwhHMr497TmUZ3HcYMq2jBYxhuPWzN1J
	 jk5lJ0mofWNLlKaobn5yTkhAIanqUMWMvfhH7XUe92EqoCXq38jts7P2TARRqvEGNI
	 TcP1US1I1vdLu3gw1YS7blP5fTaE7nOVBBtkSsL188UrBvpWvqmKGwlPzo1dAb0XHN
	 zpedBr6ug4CdZqsFvmcy4d5gQiiCYWIFeUcxTxEzlTgeZRJc8QXXgtNhW9u81sduFI
	 YtRnOn/JnPf9qGQkepeXlNjONGPza3zVLvjhB+Y1PF5HUKn2uopGfn/IthIEUh/8io
	 rV8fzme05Zdew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 114/317] ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the switch node
Date: Sun, 24 Mar 2024 19:31:34 -0400
Message-ID: <20240324233458.1352854-115-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 76da90e858045..69ad1f198fa71 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -117,14 +117,6 @@ mdio {
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
@@ -149,15 +141,30 @@ fixed-link {
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


