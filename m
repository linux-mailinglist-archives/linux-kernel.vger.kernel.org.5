Return-Path: <linux-kernel+bounces-113106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063AD888180
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A495B23EAA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A624157E9B;
	Sun, 24 Mar 2024 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejB6ssuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FEE55C13;
	Sun, 24 Mar 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319913; cv=none; b=N9oxtajk1laTIoFt66kuOU4+/jJpLjkf5eYCyhI/C+FMVJbQ/tIS7EI+jUEQdIoZsIP7M3PemyRB4LaqKomtLr0idCiI+2ox1LMQ4wDpzIrR5geazlR2aglTPKkerWl86IFSsLGUoyoQcBKvpo22stjVOfk56FlNprcgQ/JP91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319913; c=relaxed/simple;
	bh=9fBJTe87mI9XM2IpLXAQVydlYYvMSHSgDaCK0LeAZws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUSPFqI93rl019GJzE8hPNWOrIB2WrrQzhwBGs0yBbQ52V9CzsbqpXIrp1Kr5vJG+h9O/+xbylNcyxrVcHRfw5scT0oV5omvuczJI5Er/CIWrEGzGsQYxGlgPigYfPFOzvjwEAB9i/9BeQnrPD+U+YyOv1qDPBjyhH5+On/HdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejB6ssuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFFAC433B2;
	Sun, 24 Mar 2024 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319913;
	bh=9fBJTe87mI9XM2IpLXAQVydlYYvMSHSgDaCK0LeAZws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejB6ssuN+5YIoaGW6UyrOZfAEbYK0+eQZybnem0zujHzuSTh2f7vj37LFT9G4U8dT
	 hh1kit8BvYD4y7YXm6GNTPphouxmnMZ9ZM5rFqzRLY6OR0S/lkjVI5IJxFQ3m4YANY
	 pXMqygmdyFCcPiyESflF2/HKn+E52N546meKZdk++sg+ea5p5e1LJj8NE/12TZMI75
	 jHceCOdBbqtZ4GsX/oN3tEOkdDLSpPOokk7932kRJ/sMNtAGxl4dMWRf3KjOVkzu2u
	 z+L4xHJoJ+jWLeRvgrEiZB3CLz3inDKmY8ekzL2Qt3lK9emGBoWpgpTt8h8TrSU3z2
	 nrf0bec5BxbVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bhavya Kapoor <b-kapoor@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 219/715] arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS and RTS in wkup_uart0
Date: Sun, 24 Mar 2024 18:26:38 -0400
Message-ID: <20240324223455.1342824-220-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bhavya Kapoor <b-kapoor@ti.com>

[ Upstream commit 28e5b74d524050008edf415f20a3e38907b8f176 ]

Only Tx and Rx Signal lines for wkup_uart0 are brought out on
the Common Proc Board through SoM, but CTS and RTS signal lines
are not brought on the board. Thus, remove pinmux for CTS and RTS
signal lines for wkup_uart0 in J721S2.

Fixes: f5e9ee0b354a ("arm64: dts: ti: k3-j721s2-common-proc-board: Add uart pinmux")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Link: https://lore.kernel.org/r/20240214105846.1096733-4-b-kapoor@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index c6b85bbf9a179..1ba1f53c72d03 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -190,8 +190,6 @@ J721S2_IOPAD(0x038, PIN_OUTPUT, 0) /* (AB28) MCASP0_ACLKX.MCAN5_TX */
 &wkup_pmx2 {
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (E25) WKUP_GPIO0_6.WKUP_UART0_CTSn */
-			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (F28) WKUP_GPIO0_7.WKUP_UART0_RTSn */
 			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
 		>;
-- 
2.43.0


