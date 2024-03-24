Return-Path: <linux-kernel+bounces-115791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDBC8897D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1786329D94E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D15C3702C3;
	Mon, 25 Mar 2024 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBxIAcPp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A47145FE1;
	Sun, 24 Mar 2024 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322038; cv=none; b=H2aWywcB0mB/twTnjOOiNyP/Z25Dsy/nf9vsBWF6hS6qXubAd9yfVtaZr/UqQsaPcwg7jq+Yth7UNl9cov3siQO2/551h/Drmr+kCphxKnSHYHRLaJt0iWCgR6Mmhb89fsXf6/PEvVgds2VMWBpX0CKeKuVWT5HCd4jmjJ3ep+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322038; c=relaxed/simple;
	bh=2diJNys690X5vuo8K0Z2rkLA90NikcwwPE7MwS9PceI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqJHSHjEOL/xJ3nbu0fi9zw7fUituneEz+p5jYsFtIqChIc28mOLnpaNSPeFTTuSNbKCGW9U8fStMoq+70vYJv2VU06E1QB6U79V/aJZDapUhsKPywfM0kXzTsTbAq/JXzBxD4Z8EtwNL5vS0p97g79c+/fnn+maB5EdcL5k64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBxIAcPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5319C433F1;
	Sun, 24 Mar 2024 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322037;
	bh=2diJNys690X5vuo8K0Z2rkLA90NikcwwPE7MwS9PceI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QBxIAcPpkLk9BeDiRBYY7miaEFteuaXFmc6dZvoTFhxueWfdeAXrWZSe4ALLRmSYu
	 t+VnLj4ydaCmxIq6t/j/kEIJoPdOUsUqy1wfLcIOFNyM8IOyc5qS0wN5Z5pMRmfi6U
	 p811nJFa+Hsl7kOdlObSCbvcb9KvEm/PRf4o8gmja1zROQz29rbH/E+2JVkw4H0t7A
	 XXxwohbGjlKL3tINvrIou6DPtCPx3KWRGA4enQKS0gKJgNEDIfwulUnivm8bpFsTna
	 xfh+4CqXmET6RB7niZZG3hYfsuWoWXfMe6HjW+yEJujZUXg0BkOaIvfNw0vTX9K+FX
	 soI3bk+uGnxtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 109/451] arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals on BL OSM-S board
Date: Sun, 24 Mar 2024 19:06:25 -0400
Message-ID: <20240324231207.1351418-110-sashal@kernel.org>
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

[ Upstream commit c6d9b5672a0e2c4b1079a50d2fc8780c40cfd3eb ]

These signals are actively driven by the SoC or by the onboard
transceiver. There's no need to enable the internal pull resistors
and due to silicon errata ERR050080 let's disable the internal ones
to prevent any unwanted behavior in case they wear out.

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 0730c22e5b6b9..1dd03ef0a7835 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -313,19 +313,19 @@ MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x19
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
-			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
-			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
-			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x0
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x0
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x0
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x0
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x140
-			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x140
-			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
-			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
+			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x0
+			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x0
+			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x0
+			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x0
 		>;
 	};
 
-- 
2.43.0


