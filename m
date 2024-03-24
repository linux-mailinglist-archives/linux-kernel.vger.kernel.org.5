Return-Path: <linux-kernel+bounces-113719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6532F88863C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1908A1F23A29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76991E85D6;
	Sun, 24 Mar 2024 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4bgoAaR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90821DC7F9;
	Sun, 24 Mar 2024 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320710; cv=none; b=V4+1suzYFMbOYHvFtXPYKVMjRdxIhQR9OYv075KLKWKMJhUuXGZDb5SN2g91qBeJN3cb+aeMqipeKLJB/E4NvyZgtXwxQQ5Brar1SiKOrJ+Y/337p8uF/TByjrKr+81GqM1fK1zwpgNoIsfsLBYVFW9+aoyqP2/WPFGzUGKLF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320710; c=relaxed/simple;
	bh=mwIH3PjBjugu5fGqYB7lKPMckfOdZeCQHALgGAMrEnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk5lAEiSdMZVy8M/mB0I1/w4q6HwiXFPyBNNR5pxppEDJg+K0NJxdnEhHPpwIn4z8daHmECipfe3lxzP/JAU+FoW07vAx4VMEA5Kwl2T9q+FD3GcraMLUnhkGJBSq7rGANqx4kqPfV5XrDNdJ7sbW3cc74JeGNq13bKXBDpDHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4bgoAaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0683FC43399;
	Sun, 24 Mar 2024 22:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320709;
	bh=mwIH3PjBjugu5fGqYB7lKPMckfOdZeCQHALgGAMrEnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4bgoAaRXrMy2T+8lKklWcCeWWBTzr6lrwiZm+tE4SkKflc0iop3aO1NSWWvubA+c
	 hYcygPpkPC8wFzttW+nR/Lk2FypBy99pNlugEf+x+uQhamMmoite2cELMS8QTBuAup
	 FmP9ci9frucV9dN9fNbNqXXBdFu+nUKIEsCvsjFtDAgsqtVqJalLUnZnPX/qeQ31H8
	 1yQLpJasB4WDRv46EtSUnI7F0nNf3sZSS7HbKm38ht3ug65BH/Z+vFfDQS/5n4a23M
	 SVT8dN8wGtIzUCQWkAYtyVwKUSdbFLhzlORm4hlJVsoiOP83lF8i/ydJaAxFilPoIV
	 zINhHtH+vYpgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bhavya Kapoor <b-kapoor@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 272/713] arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in wkup_uart0
Date: Sun, 24 Mar 2024 18:39:58 -0400
Message-ID: <20240324224720.1345309-273-sashal@kernel.org>
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
index f1f4c8634ab69..50210700fdc8e 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -331,8 +331,6 @@ &wkup_pmx2 {
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


