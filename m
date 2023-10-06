Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7A7BBA88
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjJFOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjJFOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:41:25 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADFAC6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:41:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5e53:403c:300c:38ca])
        by albert.telenet-ops.be with bizsmtp
        id uehJ2A0010nPCdM06ehJGn; Fri, 06 Oct 2023 16:41:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qom10-005X4U-1Q;
        Fri, 06 Oct 2023 16:41:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qom0z-006v2M-Vg;
        Fri, 06 Oct 2023 16:41:17 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/5] m68k: Fix indentation by 7 spaces in <asm/io_mm.h>
Date:   Fri,  6 Oct 2023 16:41:10 +0200
Message-Id: <41ca6ab21459164a52f5f468c32ef09aee7ba3d3.1696602993.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696602993.git.geert@linux-m68k.org>
References: <cover.1696602993.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indentation should use TABs, not spaces.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/io_mm.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index 370ca49728096305..38a021bd212660c1 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -294,20 +294,20 @@ static inline void isa_delay(void)
 #define isa_outsb(port, buf, nr) raw_outsb(isa_itb(port), (u8 *)(buf), (nr))
 
 #define isa_insw(port, buf, nr)     \
-       (ISA_SEX ? raw_insw(isa_itw(port), (u16 *)(buf), (nr)) :    \
-                  raw_insw_swapw(isa_itw(port), (u16 *)(buf), (nr)))
+	(ISA_SEX ? raw_insw(isa_itw(port), (u16 *)(buf), (nr)) :    \
+		   raw_insw_swapw(isa_itw(port), (u16 *)(buf), (nr)))
 
 #define isa_outsw(port, buf, nr)    \
-       (ISA_SEX ? raw_outsw(isa_itw(port), (u16 *)(buf), (nr)) :  \
-                  raw_outsw_swapw(isa_itw(port), (u16 *)(buf), (nr)))
+	(ISA_SEX ? raw_outsw(isa_itw(port), (u16 *)(buf), (nr)) :  \
+		   raw_outsw_swapw(isa_itw(port), (u16 *)(buf), (nr)))
 
 #define isa_insl(port, buf, nr)     \
-       (ISA_SEX ? raw_insl(isa_itl(port), (u32 *)(buf), (nr)) :    \
-                  raw_insw_swapw(isa_itw(port), (u16 *)(buf), (nr)<<1))
+	(ISA_SEX ? raw_insl(isa_itl(port), (u32 *)(buf), (nr)) :    \
+		   raw_insw_swapw(isa_itw(port), (u16 *)(buf), (nr)<<1))
 
 #define isa_outsl(port, buf, nr)    \
-       (ISA_SEX ? raw_outsl(isa_itl(port), (u32 *)(buf), (nr)) :  \
-                  raw_outsw_swapw(isa_itw(port), (u16 *)(buf), (nr)<<1))
+	(ISA_SEX ? raw_outsl(isa_itl(port), (u32 *)(buf), (nr)) :  \
+		   raw_outsw_swapw(isa_itw(port), (u16 *)(buf), (nr)<<1))
 
 
 #ifdef CONFIG_ATARI_ROM_ISA
@@ -319,14 +319,14 @@ static inline void isa_delay(void)
 #define isa_rom_insb(port, buf, nr) raw_rom_insb(isa_itb(port), (u8 *)(buf), (nr))
 
 #define isa_rom_insw(port, buf, nr)     \
-       (ISA_SEX ? raw_rom_insw(isa_itw(port), (u16 *)(buf), (nr)) :    \
-		  raw_rom_insw_swapw(isa_itw(port), (u16 *)(buf), (nr)))
+	(ISA_SEX ? raw_rom_insw(isa_itw(port), (u16 *)(buf), (nr)) :    \
+		   raw_rom_insw_swapw(isa_itw(port), (u16 *)(buf), (nr)))
 
 #define isa_rom_outsb(port, buf, nr) raw_rom_outsb(isa_itb(port), (u8 *)(buf), (nr))
 
 #define isa_rom_outsw(port, buf, nr)    \
-       (ISA_SEX ? raw_rom_outsw(isa_itw(port), (u16 *)(buf), (nr)) :  \
-		  raw_rom_outsw_swapw(isa_itw(port), (u16 *)(buf), (nr)))
+	(ISA_SEX ? raw_rom_outsw(isa_itw(port), (u16 *)(buf), (nr)) :  \
+		   raw_rom_outsw_swapw(isa_itw(port), (u16 *)(buf), (nr)))
 #endif /* CONFIG_ATARI_ROM_ISA */
 
 #endif  /* CONFIG_ISA || CONFIG_ATARI_ROM_ISA */
-- 
2.34.1

