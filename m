Return-Path: <linux-kernel+bounces-114209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE345888F68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D5E1F2AE87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A4E158D81;
	Sun, 24 Mar 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkavrFOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115022081FD;
	Sun, 24 Mar 2024 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321542; cv=none; b=RsVMFW8g340lsRJ1PMKIXIv2OYUThvCnb7CEop9cxTU+a6E4KY8wfL7ugEbTLj81wNx2R2rw9M6P7q+pbYFBO04Kv86rZ2FozUopSUNFeeRg5dxFgfjiBA+r7eu8UW/L7OXUYR6OAOnNav2icl6FUlfFp2EYzqsnhMl8Doz1xKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321542; c=relaxed/simple;
	bh=qDdkBp52whbIdsEQJeQ73Fo2VF9QAYIUfc9LlJxEzNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8QKTuHv84MVU+x+Y0wPJN/+w34+h3TRE5Gd7LH7RdVh3P5y1+v9fz5VdLMeKMkN8LwvsywM4Vvg2jdKDYyh7x3y9n1fYLLqJQ/SFbQQcoayhjJIhF+qNTcVkuBTbfrCRX2Rrid2FhFhIJbejPZgzWuSYQ+Ipi1keOU8G5aaUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkavrFOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B8CC43399;
	Sun, 24 Mar 2024 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321540;
	bh=qDdkBp52whbIdsEQJeQ73Fo2VF9QAYIUfc9LlJxEzNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkavrFOPD3c+kGhuHZ05GESqdLg+sToYSKhUjoWO0YXSycXpcOgN/AAfbwSWlnT6B
	 C/yVfhynkGDc6Wpajei9cYrAMPvESgDYeAwlOmAqqS0khYFP5xgb2m3+f1drWI88+Z
	 tU1Bb6ysrGdrq07pUYSKS4G9TfBAY6lgf+PjVD1mI/CMpSDZKa+0VIAqx+2YLuIqn2
	 HTzZ86GscvPSdWO3AOOcoW3XQep1tcE8C0H16PMZmlDzCOF434TPtgVItkgJjPDDiY
	 Xc8CJE58jgv0y99bhyYIsyb266P4U4bpO6BwfSzT/hn2ml/Uq9OXy7ePaFc7lxa+W3
	 8Y5X7Whxw5JYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 268/638] ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the switch node
Date: Sun, 24 Mar 2024 18:55:05 -0400
Message-ID: <20240324230116.1348576-269-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
 .../boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
index d2b3e09eb7df8..c32ea040fecdd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
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


