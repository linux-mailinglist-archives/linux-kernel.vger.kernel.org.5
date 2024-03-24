Return-Path: <linux-kernel+bounces-113104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C091688817D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2ED288250
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C416F157E64;
	Sun, 24 Mar 2024 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe/T94XW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2B156986;
	Sun, 24 Mar 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319912; cv=none; b=FkZPh/1GkGU7sdtzy27QY6KAhf6T8GP+hnDr//qmdhh8rhS/HFAbG89EEp6ea0GbegNSkVas8DuiW32wT6PFQgegGc0c9DSG6tF65MGbF8gnJZA3OpV8oR3+cuxe7IqG0NfULAHdN0B4unrUEPNNnp41/hKt81eNxOS0c3uNq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319912; c=relaxed/simple;
	bh=b3EGla1ceGQDu3kI0qNL7DjBL1cafs8iz7Jsl5WCx38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHgeJqKqdTkGQpOkPvEXef//lKZgUViviyI/YbK9SjIcGtQTSY3EdfmrSpARe2g8E5FQN/Ed7lskqlvJZqlGRD4nDgLyihYbl0G4mi29fudMhvRuCPzYrOrZTNLlvLZsFQ/JN3nrNC6ZShdYNQ3zTID8/zucHmfH+OrjdvCG2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe/T94XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28551C43390;
	Sun, 24 Mar 2024 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319911;
	bh=b3EGla1ceGQDu3kI0qNL7DjBL1cafs8iz7Jsl5WCx38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fe/T94XWVA0ODiiovsLbj4gVvWbGsohv3FijB6AoF8TvDgwo/GRGlvGOCdbIXiH2e
	 ozUQJRaEY8Emu+y24Feb7xPhBCzWBSQhtiHmXe9xkYrCSVqn+CtstB4pv7GET3r1G4
	 VVwKT8Vjwr1xyrvgtdVsuMyWlrhE8/F1oX21BEf7+XAaOm6RM64yqoHQGNBRrI2BE0
	 NqRUPIsMeyFPKBFKtq+1VYL46+1RhWmUuGhAO8lWgEZaEGP0LRYlNWU7pt2snD8+ih
	 bkLDINM7dJmAPRADab/IRhd6Xtpqwvg76sO8kdtbMRmFsS8DG0CBMRMM7AQlrssFjP
	 XIFfsOqderU4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bhavya Kapoor <b-kapoor@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 217/715] arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for wkup_uart0 and mcu_uart0
Date: Sun, 24 Mar 2024 18:26:36 -0400
Message-ID: <20240324223455.1342824-218-sashal@kernel.org>
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

[ Upstream commit 566feddd2ba5e29d9ccab36d6508592ae563f275 ]

WKUP_PADCONFIG registers for wkup_uart0 and mcu_uart0 lies
under wkup_pmx2 for J7200. Thus, modify pinmux for both
of them.

Fixes: 3709ea7f960e ("arm64: dts: ti: k3-j7200-common-proc-board: Add uart pinmux")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Link: https://lore.kernel.org/r/20240214105846.1096733-2-b-kapoor@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/ti/k3-j7200-common-proc-board.dts  | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index cee2b4b0eb87d..53594c5fb8e8f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -91,24 +91,25 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
 };
 
 &wkup_pmx0 {
+};
+
+&wkup_pmx2 {
 	mcu_uart0_pins_default: mcu-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
-			J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
-			J721E_WKUP_IOPAD(0xf8, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
-			J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
+			J721E_WKUP_IOPAD(0x90, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
+			J721E_WKUP_IOPAD(0x94, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
+			J721E_WKUP_IOPAD(0x8c, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
+			J721E_WKUP_IOPAD(0x88, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
 		>;
 	};
 
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
-			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
+			J721E_WKUP_IOPAD(0x48, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
+			J721E_WKUP_IOPAD(0x4c, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
 		>;
 	};
-};
 
-&wkup_pmx2 {
 	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
-- 
2.43.0


