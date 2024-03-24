Return-Path: <linux-kernel+bounces-115779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D89889A95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4128B353C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99D36F331;
	Mon, 25 Mar 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO3kU9lr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7FC145B38;
	Sun, 24 Mar 2024 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322036; cv=none; b=f6JzM3HQPTljgXLFYcM3hAUEMnIXadACWpiplTj53JrPhyeAcv9h3fRgCDwJvz+qRzxcbfEHV5yeL2e6cC0SYu+CsYPKjuG+QSFMAIHNkovkq4XUFwZ1EYn3fMhTvJgzxAp1X1AMgR5znVAMxTjjKHIPKe3QU6rh6EC21qyv/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322036; c=relaxed/simple;
	bh=7gluWkL9ytXsWbTJVw0ZLIOnRL3giWSD5tOoQxJEgPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzJXG6ci6q7hyJerzdKfGwL0DbSl/CeTKb9Lasm5QpKiqZMtt/1qRgTPXdNfpw5BdjZkbnmEQmptCk1UaMYKYSkDQWAHobUvt24IfldjSXKU2wKYYLuJg2uIURrI2GN/ZldQO1Z+CPB6Z/+QwcRh9Y3Iz5vcv9ZJ4zjthDBI9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO3kU9lr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174EEC43143;
	Sun, 24 Mar 2024 23:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322035;
	bh=7gluWkL9ytXsWbTJVw0ZLIOnRL3giWSD5tOoQxJEgPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TO3kU9lrgzO8zr1ULIceAMHZkwxvjBJkA6rML1Mj5tzQbpOYYLtdi1rG1homFq3cc
	 YdJoEVIGKXkl9WPNby1jpW6HjhxgjSU6+bEbVjquVDwgRuJgvIAsceG9oZrAZaAWYi
	 xB3hrKN8FiHBTpILTtQS/MYK5eekoZhJwdydkr0D/tHJkedl299y0nEDr4Lw5v8jLg
	 3I930z9L/nMeA7/GD03ViilXJP2/CGig76VSZ0MM/PHsS9XXmDKDMmxmAUOjmGBHKK
	 njSnF6CftFHnM6WmZTiBD8Iq5Ifh4TOpROBqjbtA2zRlmCrTLToBFuEQr0LtMkVg59
	 ymSMmQqIJnkfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 107/451] arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on OSM-S i.MX8MM
Date: Sun, 24 Mar 2024 19:06:23 -0400
Message-ID: <20240324231207.1351418-108-sashal@kernel.org>
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
index 8d10f5b412978..9643d6ed9a7c7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -247,8 +247,8 @@ MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
 
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


