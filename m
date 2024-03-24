Return-Path: <linux-kernel+bounces-115862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DCD8894CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BEE295C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A51158A33;
	Mon, 25 Mar 2024 03:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIUQ/Ukx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD16145B31;
	Sun, 24 Mar 2024 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322036; cv=none; b=P68hxUlJKD5yG9kY7DNYlIN8uPdxb7W4xJNdG8itBhw+NOIJFMdtGSOi7djzmHAEOP0wwHgdys3GN6eG1QgNa5tNC2+hL5UEf2/8yyrwvYUz7PgOxheugq0VJyfMHnkr5v/fMVuRN2m16lIvu7TQV9I4sn1Ua8JaIx6KVQ67jUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322036; c=relaxed/simple;
	bh=tCSre+Ddtl3qL0VguPf4rFmfNsZDRggcxJFqUVMB4OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yngd8M0VPH6EtVhcNXds8Wvxd5hUNgXjfcUP5YAFQpReBsCF/qgXtDrzFggWBI41spRF6dOJR6c6tFmaxdK4cjbvRTyMv9th1SbQhT2sXGli1ArJUNVqUyg5p0548BhvvxuPp6e28EDWzhAwMJc0qmiKAJOHobjZ9nQ/PI++0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIUQ/Ukx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06ECC433C7;
	Sun, 24 Mar 2024 23:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322036;
	bh=tCSre+Ddtl3qL0VguPf4rFmfNsZDRggcxJFqUVMB4OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIUQ/UkxklqBNNlC+Uw1GVQouUlkDeMME9V3DhEuJATt9ullzsMDdb+9BSLIuGBr4
	 ORjV+OCXEeAsRCaYVtpPbypDxfsWN2r97BjEhmhYgtjnuDz7I/rpm9QsEVtMIKVHPY
	 gaNjN5F+xYL/hsPb3DyRuI+X7O2WSZGSWyCP/tOyTVG0EoJSGfOcRgnw8Rl7lZn9Qc
	 UTkFGx/tmN7xbF/FjKHrCUeP1Nr7xOzrCtiz2/Tsy36nNULUjrPWXFev9m6BiNy0bD
	 uP9Xop//cEYRWFav20IDQg7niEiisj6LxCq4FLCExKyp+6fDH/gFt6wle2o0GVOIU3
	 kNTi3/Th0ustA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 108/451] arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/BL i.MX8MM
Date: Sun, 24 Mar 2024 19:06:24 -0400
Message-ID: <20240324231207.1351418-109-sashal@kernel.org>
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

[ Upstream commit f19e5bb91d53264d7dac5d845a4825afadf72440 ]

There are external pullup resistors on the board and due to silicon
errata ERR050080 let's disable the internal ones to prevent any
unwanted behavior in case they wear out.

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index a079322a37931..8d0527bb6fa59 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -277,8 +277,8 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000083
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
index 0679728d24899..884ae2ad35114 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
@@ -237,8 +237,8 @@ MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
 
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


