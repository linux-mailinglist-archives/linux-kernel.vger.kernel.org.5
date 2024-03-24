Return-Path: <linux-kernel+bounces-115787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2D8897D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834AD1F34F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD636F329;
	Mon, 25 Mar 2024 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfkKkiVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792FB145B28;
	Sun, 24 Mar 2024 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322038; cv=none; b=acUd8SWWwp2wYnGHkd54InS32NfuKEwdTD/HWAjmbMPDU3I/9jGK0QQ5IvguPDm4xoEj2o4ZBAEp+Zwp7MUlCpICJSGXWlBUlQP5DzIGD7nCHJdEE7z4m8EeINSwLhBQLt588GCA4WQGlsVp1QdHQsMuEGH8MUKhlgBv6bPSO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322038; c=relaxed/simple;
	bh=5HLFCy2eUSbS7pXOYWAt8XGAbN8TP9K8cjvWtMvVQTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPL1oOQePnYn6vSS6+lpR0f2u2Eve71s7WBCwaLyqR8Wc36tYTNoVqhJ6ihQwzhG8A+xgw4QoKhJb+CN5MjKWMIWAemcNZtQeXuMqIbsrno50Sc0xTBydP7r55bOQrt/AGwKaTHZaSSB7hTioSkoPLeJ1QA/N6669QPklN6614s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfkKkiVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9566C433C7;
	Sun, 24 Mar 2024 23:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322038;
	bh=5HLFCy2eUSbS7pXOYWAt8XGAbN8TP9K8cjvWtMvVQTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfkKkiVkH0G8p1VW8u4ulbt8yAKszH4udoHGUQRVO5PqbtyumiUxqz1y9dramEBcj
	 BsFfEeSimLjiOrI9VwnjTfrz9/zYzfoYOrgUSet1i0trSX5Tmd2bQSZS2hFXpm/moT
	 3ZFcGsf+KuD6HGJYx5nBJLlcoKGQ0jqFppFpHkgcocMhBO5VXtp+UFWRfOh+pt3DGw
	 5MyqvQo4XIPQDB/S+I6TE0DyoBS1bKqDas6aXSaP+HX31iXtzfJUyzR3KlhgFTCLek
	 6IlzL14rTkJYQSf7jqOhOT2reVqghv1+ZP5EQZ1daoDr2mP6IM/zf6pVwhSRd5tfq7
	 nuy5At634sJ7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 110/451] arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals on BL board
Date: Sun, 24 Mar 2024 19:06:26 -0400
Message-ID: <20240324231207.1351418-111-sashal@kernel.org>
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
 .../boot/dts/freescale/imx8mm-kontron-bl.dts     | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index 8d0527bb6fa59..bffa0ea4aa46a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -290,19 +290,19 @@ MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
 
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


