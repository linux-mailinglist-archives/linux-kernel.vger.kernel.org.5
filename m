Return-Path: <linux-kernel+bounces-115793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D37889689
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA151C30465
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F43371FA1;
	Mon, 25 Mar 2024 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpIY1YlR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE0145FE4;
	Sun, 24 Mar 2024 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322041; cv=none; b=kbQa8Xydkhpn1uo8lKDkjWtNR4ZPRnTPoCma29CpKcBMb5uNOpVEG+jr56zyw0oE7Tcz0PSHhe181x8xiB/9VbHBMy8V/l/NR2ZXiva0JpaHx2yh8nR4SNPnWGglrdN/5zs5s8cFV9M4MmlAoi5jotTq146+YfyYi30niYIM7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322041; c=relaxed/simple;
	bh=hIfuZhCS2CO+ecIL9mNN2he8sfme3MBnMBCtGRadDRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i44rYNb5SpxBGNWmk4k6IRDdJHUHVVuNlKFELPKGP2dvECWXQyG4tsDWUN1QttBahvRH+lIAftJg5L1XnX2FhxHXHI1BWjsIQYrtDn0QsX9Ndqf9piAqVXZrUp2d75eFKLMjVicZ7H+AYRR986SwN8WC/TqSFpy7r6jAvTYQkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpIY1YlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81997C433C7;
	Sun, 24 Mar 2024 23:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322040;
	bh=hIfuZhCS2CO+ecIL9mNN2he8sfme3MBnMBCtGRadDRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpIY1YlR3qfSOPEPTS7fAywvwF1JjJGosm4RJqKCjwLGIyKfq2tigS9unYKlWDpj1
	 F4vSRE6bIkHgucPI4N6xcAfZzkW8SdOgRm8R25NwK1QmD0bXW86jw3MNond7w1VoCd
	 g34AMcuRDVKjM8WBiTMZAqZfyg7nS51ZOZwFvT5nuJ6EKWSpcULKR/TEowY/aWPIkD
	 ljnLRmZ8mK1G/d7+wUZH3OUvgsiEKbk5Z3uCHF7WvXZ76XSBOZz1r3OJzxPVY/mHji
	 Ufv8NmutTzmVb8UtGJVtX+XMm06Dq+7H24l4widv1slvXWjo5cB+zVYb79a1z326Un
	 QbGTc1/EnicMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 112/451] arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals on BL board
Date: Sun, 24 Mar 2024 19:06:28 -0400
Message-ID: <20240324231207.1351418-113-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit 008820524844326ffb3123cebceba1960c0ad0dc ]

Some signals have external pullup resistors on the board and don't need
the internal ones to be enabled. Due to silicon errata ERR050080 let's
disable the internal pull resistors whererever possible and prevent
any unwanted behavior in case they wear out.

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/freescale/imx8mm-kontron-bl.dts   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index bffa0ea4aa46a..d54cddd65b526 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -314,40 +314,40 @@ MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
 
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x90
 			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
 			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
 			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
-			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
 		>;
 	};
 
 	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x94
 			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
 			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
 			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
-			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
 		>;
 	};
 
 	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x96
 			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
 			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
 			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
-			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
 		>;
 	};
 };
-- 
2.43.0


