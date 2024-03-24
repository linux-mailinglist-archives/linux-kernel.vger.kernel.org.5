Return-Path: <linux-kernel+bounces-115624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49394889464
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B63B2F2F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7A6254F61;
	Mon, 25 Mar 2024 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcyIqtzn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A692023B9;
	Sun, 24 Mar 2024 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321434; cv=none; b=ie/rCMCP3x63mGZFLIm35hkoVyUwCys6T2rzdFlbZd+/c2KzAQvqrJae5DPH2Ib5/QQUOhAjydEbTiR9Hulf5B6SLFLRj1NML3f/BA0fL2q2/UvvlIxnH3/GiysMmmxgEQEGJTskmyBtfsU54sg4jbVQa21xmQvxtrqHPPpcM10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321434; c=relaxed/simple;
	bh=5jaLuzVu03LfcgTNCeqDwZBUUHqQVrNeybRDDhk2+Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1eSJyodMCMaBd+J3epvLA2j0CJA+x73SrTVoeV+kjRMzyKnOFx3Ji8yISPGUW1tfNLVmDQccPoircy4tyJIdNHWNslhF1w3sepkhSNS0pxCUN1c9TfHSFjk/AzYr8Si3jIOlCQSLzocq66WQhobzDSOUQr8XHE44MKUyo1NVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcyIqtzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D598EC433F1;
	Sun, 24 Mar 2024 23:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321433;
	bh=5jaLuzVu03LfcgTNCeqDwZBUUHqQVrNeybRDDhk2+Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NcyIqtznNhOqc0N8vjbYVuZATOuDzKu9kym3wS4/RiGz+2DWDOx2MQnDzwUXgWsjB
	 hnggQ9CAnl84eHCW/8R4rnk/59YfUdk/cKXH7xUp2n00FOEGfrvWNLQ3frbstEZLng
	 7nbjDWPw5S35pr/j7/ndxNzYRUeomovSSQI0JNnzpaSRSj5xzk70rJzfzPhNPNJkdB
	 JZbzFxL/H/q9s0dzIG+AVNxa2LjwDUqxi4FWdNLs/NGnwwxNu5U6ZMCtd8DtppEKxw
	 i279NqbNJv+00j8JIWDaGGkazbhaqJ/9JhEt8U/8Rmm/09Y91KNQVI9RPpn1AameVc
	 CKHmuU9lsz2AA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 157/638] arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/BL i.MX8MM
Date: Sun, 24 Mar 2024 18:53:14 -0400
Message-ID: <20240324230116.1348576-158-sashal@kernel.org>
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
index dcec57c20399e..5fd2e45258b11 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -279,8 +279,8 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000083
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
index 1f8326613ee9e..2076148e08627 100644
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


