Return-Path: <linux-kernel+bounces-114127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 011B2888897
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB3CB20425
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B867223FE60;
	Sun, 24 Mar 2024 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNrwGHIM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58687202B84;
	Sun, 24 Mar 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321436; cv=none; b=DmGEQhN3IVoWFgwB2HmjI8fw5XKP15ZMyuxwLm0NYU0tQNcXINqUEEtCeYWwQeNGKT70DeyWYh/jZEEaHHnJOI6fTua3slboeqbBoHjwGhWr0JTAWX42SPJp0r7+SvgMkMwZBZIoE0oOYcXbS6lHXFmrSRf1M6Ldtgvx0uJB0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321436; c=relaxed/simple;
	bh=C5+iWgv1WmZKo9V89Vlt5pXL8s+c771eDGwih5584Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM79YTVboRh+jYRDvx7zFC17BjRUB1F3JBpJiwFAGGMFw904/08f0o/LPhSL1wTJmhr3/x1vfG/rtD3/MK66rJYm9D+XUqKwptJNRthJU9ky+bvgGvd/84z5WYEY0Wi5CXuQ+sYG6B8DeiDlJP0De8oEah7jHB0q3AJ7wl7T/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNrwGHIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9034AC433C7;
	Sun, 24 Mar 2024 23:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321436;
	bh=C5+iWgv1WmZKo9V89Vlt5pXL8s+c771eDGwih5584Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNrwGHIMreKV3D1VL7Qo+icOWwY7xPBkE0Vq9riq3LP534xjtWrf5c+uEnuoKKjKL
	 ddM/Wq3SBjUbn3J9SFjr/4yWqmJrKkNJaqNdLywtEXXO0l670op2S0O5v+drAFU+Rk
	 b7dHG+j9cBMolfLWe26QJD4PgfwYbKXqc/U3nZhAwA9YvKUI3TFupGA5MlnqOspoDp
	 sZCo/THag1QXkmCV2iJ7XgWn3D6R4Q/vnvc2r0aGd0Yiq5tFUwS9HFH4WW8VH/K1j2
	 4NQneyMOJ/XT+CcgVBfdBnya/EJrBvMDUmlG3Dvy6NFajbnSrlugRKCzUPw64RpRrO
	 Hx1stPNtbRQBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 160/638] arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals on BL OSM-S board
Date: Sun, 24 Mar 2024 18:53:17 -0400
Message-ID: <20240324230116.1348576-161-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit 5a940ba3e4d7c8710c9073ff5d0ca4644d4da9db ]

Some signals have external pullup resistors on the board and don't need
the internal ones to be enabled. Due to silicon errata ERR050080 let's
disable the internal pull resistors whererever possible and prevent
any unwanted behavior in case they wear out.

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts  | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 1dd03ef0a7835..d9fa0deea7002 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -337,40 +337,40 @@ MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
 
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


