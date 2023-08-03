Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B03476EC54
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjHCOVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbjHCOVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:21:09 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F26B2684;
        Thu,  3 Aug 2023 07:20:51 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RGr4t1jffz9t4f;
        Thu,  3 Aug 2023 15:57:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MCduBF0o_i5C; Thu,  3 Aug 2023 15:57:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RGr4m0kFqz9t4n;
        Thu,  3 Aug 2023 15:57:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 13F5B8B773;
        Thu,  3 Aug 2023 15:57:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SEOQdp5N5PsN; Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B5E0E8B77A;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 373Dv4Yu494213
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 15:57:04 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 373Dv4LC494212;
        Thu, 3 Aug 2023 15:57:04 +0200
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
Subject: [PATCH v1 12/12] serial: cpm_uart: Remove linux/fs_uart_pd.h
Date:   Thu,  3 Aug 2023 15:56:53 +0200
Message-ID: <f2cb444fa2b5776c9c51b5e46ea85edab62d1524.1691068700.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691068700.git.christophe.leroy@csgroup.eu>
References: <cover.1691068700.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691071001; l=2154; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=HrW+xy1mV9LzVHBn5BKDV/j8NZ7SIr3YuDt4l5zZYWg=; b=SdK5pHkJWllauesE1RX5dyJy0LrcFgHaRXxxuxOaVzLotCbSaMVmZ0KMHIZFsaBKbAfua+39r hiNo4obrsUEAbvpe/ljhUWlxDBpm5I1eK5Q0ABO5zr++3evq4BLo2wD
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

linux/fs_uart_pd.h is not used anymore. Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/fs_uart_pd.h | 71 --------------------------------------
 1 file changed, 71 deletions(-)
 delete mode 100644 include/linux/fs_uart_pd.h

diff --git a/include/linux/fs_uart_pd.h b/include/linux/fs_uart_pd.h
deleted file mode 100644
index 36b61ff39277..000000000000
--- a/include/linux/fs_uart_pd.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * Platform information definitions for the CPM Uart driver.
- *
- * 2006 (c) MontaVista Software, Inc.
- * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#ifndef FS_UART_PD_H
-#define FS_UART_PD_H
-
-#include <asm/types.h>
-
-enum fs_uart_id {
-	fsid_smc1_uart,
-	fsid_smc2_uart,
-	fsid_scc1_uart,
-	fsid_scc2_uart,
-	fsid_scc3_uart,
-	fsid_scc4_uart,
-	fs_uart_nr,
-};
-
-static inline int fs_uart_id_scc2fsid(int id)
-{
-    return fsid_scc1_uart + id - 1;
-}
-
-static inline int fs_uart_id_fsid2scc(int id)
-{
-    return id - fsid_scc1_uart + 1;
-}
-
-static inline int fs_uart_id_smc2fsid(int id)
-{
-    return fsid_smc1_uart + id - 1;
-}
-
-static inline int fs_uart_id_fsid2smc(int id)
-{
-    return id - fsid_smc1_uart + 1;
-}
-
-struct fs_uart_platform_info {
-        void(*init_ioports)(struct fs_uart_platform_info *);
-	/* device specific information */
-	int fs_no;		/* controller index */
-	char fs_type[4];        /* controller type  */
-	u32 uart_clk;
-	u8 tx_num_fifo;
-	u8 tx_buf_size;
-	u8 rx_num_fifo;
-	u8 rx_buf_size;
-	u8 brg;
-	u8 clk_rx;
-	u8 clk_tx;
-};
-
-static inline int fs_uart_get_id(struct fs_uart_platform_info *fpi)
-{
-        if(strstr(fpi->fs_type, "SMC"))
-                return fs_uart_id_smc2fsid(fpi->fs_no);
-        if(strstr(fpi->fs_type, "SCC"))
-                return fs_uart_id_scc2fsid(fpi->fs_no);
-        return fpi->fs_no;
-}
-
-#endif
-- 
2.41.0

