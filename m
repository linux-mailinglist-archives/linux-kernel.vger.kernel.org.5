Return-Path: <linux-kernel+bounces-114772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C37088924D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A582B27B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147CF1B8842;
	Mon, 25 Mar 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBtGziih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BBF21A82E;
	Sun, 24 Mar 2024 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323373; cv=none; b=fCgTqGED4IjpxIXe/oHAFRjnYsdDy505Izdziq241m44j7jV58w4+/8islCofyA+JU6JDTCRVI+vLbPS+tUDFTXmM/u7O1yJRg7EePdK8hBlbZXLSE7brwF8QuMmqjfD9uukM60xz1FkYJXAnulNogsRt4+soJyQAvIOSgiiqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323373; c=relaxed/simple;
	bh=t4VgZYcbk0X9lwkENC4ESyD43JJVmn4mAQAetzW2wAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVHib0NW9eAfTx4Om8NkHFpnTMuaEM24Qge0DNyX8XQVdEyqkN/8gqemOatQnrYlF1Ip9jNdhGxvYv7/bDDsfMs+VyDgol5LTgWJjX3SWRFjVsSprTX2K1ZRDwHu5124+zOSEQAznQA3dJGFtg87J7pYjkwm+v410VOCUUW+A0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBtGziih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED98C433C7;
	Sun, 24 Mar 2024 23:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323372;
	bh=t4VgZYcbk0X9lwkENC4ESyD43JJVmn4mAQAetzW2wAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBtGziihNVTnkR/31z9CAhTMut1o/Pagmw1Q/HntNSELLARYPQk0kCZmtXqlNNkm+
	 DjtYOwBEXoirm33qltwzmljDPGCn9rzZdWu9v3IRwbZxXPovjEV6X+JVgpyRNaZgBN
	 tWLlCxqUrGZsgQTUgH2en5Rxd5lFuAjhwxp9JSvMgMRbQLdQpPHV70J1NHpHTzUkWq
	 0ivw8ZIAQgn7yVsrbonIq9KUoMmqLiOeRJfccB+DC/fjsH+/egqzKLR/eJmMEOX20T
	 T0hIIeIaL6UPXmp3uUiUOPhd7L0vKSlPzTqpmkEFkPprKiZyVPkWOREsxYj2gc/vpZ
	 JbQvlfugaqO/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 072/317] arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals on BL board
Date: Sun, 24 Mar 2024 19:30:52 -0400
Message-ID: <20240324233458.1352854-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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

[ Upstream commit 162aadaa0df8217b0cc49d919dd00022fef65e78 ]

These signals are actively driven by the SoC or by the onboard
transceiver. There's no need to enable the internal pull resistors
and due to silicon errata ERR050080 let's disable the internal ones
to prevent any unwanted behavior in case they wear out.

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/freescale/imx8mm-kontron-n801x-s.dts     | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index 362f9360b4a51..67e768032320a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -288,19 +288,19 @@ MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
 
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


