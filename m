Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B6B76EC59
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbjHCOV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjHCOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:21:31 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D677B10D4;
        Thu,  3 Aug 2023 07:21:10 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RGr4v4KHDz9t5J;
        Thu,  3 Aug 2023 15:57:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nBQnO2JIAsnV; Thu,  3 Aug 2023 15:57:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RGr4m4W8Qz9t48;
        Thu,  3 Aug 2023 15:57:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 964E88B773;
        Thu,  3 Aug 2023 15:57:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Kl1IMwn4jdMF; Thu,  3 Aug 2023 15:57:12 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4DE3C8B763;
        Thu,  3 Aug 2023 15:57:12 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 373Dv3sK494201
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 15:57:04 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 373Dv3Bu494200;
        Thu, 3 Aug 2023 15:57:03 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Timur Tabi <timur@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v1 09/12] serial: cpm_uart: Remove cpm_uart/ subdirectory
Date:   Thu,  3 Aug 2023 15:56:50 +0200
Message-ID: <9b8b8f89fc386480030f5339abe307541ae436a6.1691068700.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691068700.git.christophe.leroy@csgroup.eu>
References: <cover.1691068700.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691071001; l=2136; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=2acxSC4fZPJjOV4LM1mPnEJI/PngyFJEEkHBhlNg2TQ=; b=YgxQ7g01RNqoTvf18homXVUBRxjsg1kJK1TG/t81XtG70hzyS7tP4/HhQj2wTPUREm8mR1+5G 9laqmukkjvLAcDprHTMnYDsSiey4AJOjP5epzhqNSdxFsKkQ6OfYU44
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpm_uart/ subdirectory only has cpm_uart_core.c and cpm_uart.h now.

Move them up and remove cpm_uart/ directory while renaming
cpm_uart_core.c as cpm_uart.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/tty/serial/Makefile                                 | 2 +-
 drivers/tty/serial/{cpm_uart/cpm_uart_core.c => cpm_uart.c} | 0
 drivers/tty/serial/{cpm_uart => }/cpm_uart.h                | 0
 drivers/tty/serial/cpm_uart/Makefile                        | 6 ------
 4 files changed, 1 insertion(+), 7 deletions(-)
 rename drivers/tty/serial/{cpm_uart/cpm_uart_core.c => cpm_uart.c} (100%)
 rename drivers/tty/serial/{cpm_uart => }/cpm_uart.h (100%)
 delete mode 100644 drivers/tty/serial/cpm_uart/Makefile

diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d4123469583d..138abbc89738 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -41,7 +41,7 @@ obj-$(CONFIG_SERIAL_HS_LPC32XX) += lpc32xx_hs.o
 obj-$(CONFIG_SERIAL_DZ) += dz.o
 obj-$(CONFIG_SERIAL_ZS) += zs.o
 obj-$(CONFIG_SERIAL_SH_SCI) += sh-sci.o
-obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
+obj-$(CONFIG_SERIAL_CPM) += cpm_uart.o
 obj-$(CONFIG_SERIAL_IMX) += imx.o
 obj-$(CONFIG_SERIAL_IMX_EARLYCON) += imx_earlycon.o
 obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart.c
similarity index 100%
rename from drivers/tty/serial/cpm_uart/cpm_uart_core.c
rename to drivers/tty/serial/cpm_uart.c
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart.h
similarity index 100%
rename from drivers/tty/serial/cpm_uart/cpm_uart.h
rename to drivers/tty/serial/cpm_uart.h
diff --git a/drivers/tty/serial/cpm_uart/Makefile b/drivers/tty/serial/cpm_uart/Makefile
deleted file mode 100644
index 91f202fa5251..000000000000
--- a/drivers/tty/serial/cpm_uart/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the Motorola 8xx FEC ethernet controller
-#
-
-obj-$(CONFIG_SERIAL_CPM) += cpm_uart_core.o
-- 
2.41.0

