Return-Path: <linux-kernel+bounces-115367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6478893BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8869299CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0001A1F0950;
	Mon, 25 Mar 2024 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeQwloAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641C82D85;
	Sun, 24 Mar 2024 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320618; cv=none; b=smY1uEVkcDnR/PnhIquBM+boDlPObvYgyLVq7+v2E9mSt5pBslecupcrWErsiayD0xZaCWFMOBOBVtA7DiKEokCaU8O38NZd7XCZHQGQh8bQICu60hocYB31dlhGPNFqf0IblUxxlm+eRwpM5MVdUEv1bcvQSuwY6E4K8emC+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320618; c=relaxed/simple;
	bh=xPRqP6qMDypdxzrwhFJPn3DwXf9dhukUsTYwU4wACgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQ8T/+DyYXp1H2vaqkxPOjpxdEDEoUYq5XaPysKth+lBvjo1LvGGTfhh3SDfP0wSP1xzkt5KFePu/qTbwfDKf1Rn/Q4Dv9tKXc0ob+rcst2AOwcK8yuXJYWIV79lPKGLiNCk2ERt6RfrTjg7/HN/RzaBAAEiZ/K2Z7TBFRpqny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeQwloAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7788EC43390;
	Sun, 24 Mar 2024 22:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320618;
	bh=xPRqP6qMDypdxzrwhFJPn3DwXf9dhukUsTYwU4wACgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeQwloApgFI8LRlMmOvFFdvbY69vzLZDvYMqZtmIwR4jlI6MIqjCbZIDHSyCeSXCm
	 VUMQjjUBoler5bIFbKl9PzJ35XBxsk7wsmS/osqKPlF0VSgNwc0ndyrt/ViqLN1TH2
	 X20+ANOxRBWURYrTKWWgjhxCLhv3ReggEp3uBVx3pe8skQ/xY3aYzqz8dQG5F6DDoA
	 RxGuNQhl6niK6/0M19xk49U5MxSNMD6Fphv0wbdXRNFaDIH5BlbHGS74IfSNOdMSRT
	 HcymU7Rsm8hQ3i8SgOU6mjvaUe/yZ3nrxebjlY6t+TdK77DSJk8nZYNAcp8SqVYb/v
	 eK2izxcW2HhYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 179/713] arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals on BL board
Date: Sun, 24 Mar 2024 18:38:25 -0400
Message-ID: <20240324224720.1345309-180-sashal@kernel.org>
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
index ee93db11c0d06..aab8e24216501 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -316,40 +316,40 @@ MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
 
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


