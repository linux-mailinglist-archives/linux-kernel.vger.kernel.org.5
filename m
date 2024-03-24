Return-Path: <linux-kernel+bounces-113107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F342888182
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AA01C21A29
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871E81586D7;
	Sun, 24 Mar 2024 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoGPVs53"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877E157E9E;
	Sun, 24 Mar 2024 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319914; cv=none; b=GZWSguo8u+nP8L3Q4Df9LYH3w9t4Ptm0+mB9XlbZaxJfJH1sIo1NamvDAwaVkl1oL6Sq9EhJrHmxAjXfsuGDdL6MJDzLA6KgNbHJBOdDzSe0VZldmDjfevQavoYrxmswJv9p1Dosy5vHn0LUbd/6LBhf9XbmgwAiLTY6ZZiljPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319914; c=relaxed/simple;
	bh=s63ujHTQhYmDGDVB83IzyZeuVeupg1ZEtdnm+HFw1WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZtKxftKhwuEfHtlf72HlYE/LK+WXnLDGDbFqYD5jJtwOKo3Yi52Gbvp4TE48XCZdfh28g2v96xuFqA4HyyebwvbaSOM0HZ5MLfUxLXG44lKQXtoE/MZkVNLhOuG6DWRfG0MqXQjHqPD7S+eplM+JO4DaAL7jf1VuckUGkribJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoGPVs53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7357C43390;
	Sun, 24 Mar 2024 22:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319914;
	bh=s63ujHTQhYmDGDVB83IzyZeuVeupg1ZEtdnm+HFw1WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoGPVs53SeH+wu3lv/TWWbYU5i8QzOOaFmeby2p1piK+ZKBgUmMnfb36ImLSNCZIJ
	 4GCqlsn3Ig8pHONoXOKwM/QcoAQYw37eRPpesYMQvZdln3ZDiwQFuxNgLdmzh8A1OM
	 nciptczDCypum5hVw07rr3BQq6v5l/mXMLhzGlMygtrFv0fRb8K37ObXW4W+noCMuw
	 wdrkw5ZR/s3r7RJUQCdFTpJIixYj0xmhNl9qwoo3ldN2TeUBU03hIm9wn9zGhZUz41
	 zmrfGyyS4eKQKQbla5hBcxJ0NyhqbiL7cPnDuYnz1HOKq00SnCmAtillwjk2wPbpq0
	 vcv5h3+RkVPAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bhavya Kapoor <b-kapoor@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 220/715] arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in wkup_uart0
Date: Sun, 24 Mar 2024 18:26:39 -0400
Message-ID: <20240324223455.1342824-221-sashal@kernel.org>
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

[ Upstream commit d29a6cf980572d8cf7b63935716fca663e2610f0 ]

Only Tx and Rx Signal lines for wkup_uart0 are brought out on
the J784S4 EVM from SoC, but CTS and RTS signal lines are not
brought on the EVM. Thus, remove pinmux for CTS and RTS signal
lines for wkup_uart0 in J784S4.

Fixes: 6fa5d37a2f34 ("arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Link: https://lore.kernel.org/r/20240214105846.1096733-5-b-kapoor@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index f34b92acc56d8..33795a0bc69cf 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -335,8 +335,6 @@ &wkup_pmx2 {
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (L37) WKUP_GPIO0_6.WKUP_UART0_CTSn */
-			J721S2_WKUP_IOPAD(0x074, PIN_INPUT, 0) /* (L36) WKUP_GPIO0_7.WKUP_UART0_RTSn */
 			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (K35) WKUP_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
 		>;
-- 
2.43.0


