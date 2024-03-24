Return-Path: <linux-kernel+bounces-115420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7CF889B71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B2D1F36340
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30D42081EC;
	Mon, 25 Mar 2024 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2WtA+Fu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67384839EC;
	Sun, 24 Mar 2024 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320614; cv=none; b=FKueekBddnsY6qaNaPKdimLOgud5Q1OPA1jUpijx5iVRBtaBmC3agtVzGeR+tJLXDoEwnrgngmHRXMB9bQKiVinDOyKVebXTrcnuHXpkdR3xUFmPuWzeBgl+mOdkCQRRk0l6ogPj1sJ0pUzZUlkF47v8Y+4sSFNUr0lfNcjl/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320614; c=relaxed/simple;
	bh=ze5NvR4EfcKhR0fNuwbdLlByKeSoQS9yq6vaY4x24bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHL/ajKFLFPCPlMANuJ8ZRa2a8ETPVdHoR/FSXm2Oy6d+t1+Zx+ND1URF446DgQ6PcQAWjhDw8I/AxrD8AIkjuacPC/PzF27jQRg1HIrDKWakTi6Az2r0zOVzunSEui8/+nJr3sWa80JUqLM7VRvkh13BPkf7/BpbZguHy9/B64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2WtA+Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19BAC43390;
	Sun, 24 Mar 2024 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320613;
	bh=ze5NvR4EfcKhR0fNuwbdLlByKeSoQS9yq6vaY4x24bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2WtA+Fuwp82tmvPLNnnu8g72bJQZejJWJuhGaIrf9a6Y8ZRmiJgap+cYOyxt4TbP
	 ZHpk3HtmDfu2ZnJrsphuvs8ftsABJ8oy03n4lnhUm37idWHAIuJ1j8CwHnS3optNZG
	 0cBHYvRIuclwaPrYA33kO0TNl1B8s2aQEKgCJOMaFdm/DvxH2n3uaZlyWmWS5Stfe8
	 K1K0siG3ILxHv4ieIU3XPA74aU94pMkR4x/GPwtwB/m0F7JKJ2NnZXIMIsC0GuGyte
	 cEhxXKoWtYNMMj+NtV7PmJvj7wyZSG27E/4RgroemiXDtb2VjHJ2NemPI0/qNUQ+1X
	 1+kUPjJd/AJgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 174/713] arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on OSM-S i.MX8MM
Date: Sun, 24 Mar 2024 18:38:20 -0400
Message-ID: <20240324224720.1345309-175-sashal@kernel.org>
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

[ Upstream commit 96293af54f6aa859015d8ca40a1437d3115ad50c ]

There are external pullup resistors on the board and due to silicon
errata ERR050080 let's disable the internal ones to prevent any
unwanted behavior in case they wear out.

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 8b16bd68576c0..0730c22e5b6b9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -294,8 +294,8 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000083
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 6e75ab879bf59..3e7db968f7e64 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -252,8 +252,8 @@ MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x40000083
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000083
 		>;
 	};
 
-- 
2.43.0


