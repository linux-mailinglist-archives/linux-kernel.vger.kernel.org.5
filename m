Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038717FFF43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377229AbjK3XRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377216AbjK3XRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:17:14 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84ABD54
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:17:20 -0800 (PST)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 047841F842;
        Fri,  1 Dec 2023 00:17:19 +0100 (CET)
Received: from livingston (unknown [192.168.42.11])
        by gaggiata.pivistrello.it (Postfix) with ESMTP id A830E7F9DD;
        Fri,  1 Dec 2023 00:17:18 +0100 (CET)
Received: from pivi by livingston with local (Exim 4.96)
        (envelope-from <francesco@dolcini.it>)
        id 1r8qHW-0003JL-1j;
        Fri, 01 Dec 2023 00:17:18 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Date:   Fri,  1 Dec 2023 00:16:57 +0100
Message-Id: <20231130231657.12715-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
is not adequate for embedded systems that use SoCs where it's common to
have a large number of serial ports.

No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").

This enables using the UART connected Bluetooth device on Verdin AM62
board.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Francesco Dolcini <francesco@dolcini.it>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..ecd365cd1d87 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -448,6 +448,7 @@ CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=8
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_BCM2835AUX=y
-- 
2.39.2

