Return-Path: <linux-kernel+bounces-115623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC73D889452
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B091F2F9FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226E8254F60;
	Mon, 25 Mar 2024 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbOwlR4r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B32023A7;
	Sun, 24 Mar 2024 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321432; cv=none; b=le7WJdTEyezIsjH5BJcps77PXCnzNBc9jDAhNnwD7GvO0mxuEQHXpaG8MTcW7Sm8M7mm+Q/BfXCgaHl89J98hxeI8fpNzv2fjKLqBCGWdd8OzZDfAHzoEEULssRK/e8vIrCessx5+TV+xUeUF+Ae+UAeOLYM3f+gstvlX+DFGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321432; c=relaxed/simple;
	bh=ze5NvR4EfcKhR0fNuwbdLlByKeSoQS9yq6vaY4x24bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSv9q+eVEwEiotFsDCWMtV3Ffh+8RI8Zo0THO0ZMzEi4S/curiyfJs1GiuldOBil4K/xncjEPaJ/9po3oFgyNLUcuVzsUODr+69wg353q1rmQC93Hwp+0Qw6fgYhKI3955hn5fukgxkLbPpvkChtuA2FpDhaFi45Rqp0TRdLdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbOwlR4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1B4C433C7;
	Sun, 24 Mar 2024 23:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321432;
	bh=ze5NvR4EfcKhR0fNuwbdLlByKeSoQS9yq6vaY4x24bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbOwlR4rb95MRlin2ffYBAv9Shc2ms1m7exRX2YTTnW4Ach0pbv+T7ns4ADt7WHBT
	 6OAuNwBQoSToRl79w7GLYb+EsKOMVQOeoanR4jqJTKMukYVA9g2sBU+6zDuNC/kSs0
	 UEomjylWdqa7WkVtVFJVORjFBbulQy6p1XhRF9cW+D65e2EBiKfLrC4UKqv3qp35VW
	 RWKdNu6jUr5Nhld/DUx2/10Z+fmYV1mQkFmdyeSFkopAd+LN1n5OkyRs7UgWYWnBlV
	 nxzAcYVVIk960cqSVbH0OrX7/1wTldHHJ3EdVgaRKJ6rl03EXaLeP0UV/7UMIxAZHd
	 a4McC9imrRK0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 156/638] arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on OSM-S i.MX8MM
Date: Sun, 24 Mar 2024 18:53:13 -0400
Message-ID: <20240324230116.1348576-157-sashal@kernel.org>
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


