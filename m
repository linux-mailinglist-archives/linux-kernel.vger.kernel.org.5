Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1299C79B106
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354105AbjIKVwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240226AbjIKOj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:39:27 -0400
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D08F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1694443156;
        bh=coVrW6z+muUJnLu9pKLdcX7o9brQ4PBU1PRO9046yTs=;
        h=From:To:Cc:Subject:Date;
        b=A3p0ZRvKRus694P35NN21sRJuVQvxFNoifb89JhkU+uEDSCzbtebKL6XDQvPpUWca
         GJgW3R04bAUfDwQUVpqnl5MOR0eA15VdW+pHQSqCGUVRTqUa/i9elZyCPKJ5qNtJNE
         VtgmP6nsp1voT0+bHHw29EDCLhcMp2viO28z8VvM=
Received: from rtoax.lan ([120.245.114.155])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 83B9C8B0; Mon, 11 Sep 2023 22:32:59 +0800
X-QQ-mid: xmsmtpt1694442779t2yq1rmqj
Message-ID: <tencent_6F19BC082167F15DF2A8D8BEFE8EF220F60A@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69AedwavA3u8otDWALLItPCt/iDqyXUyy3aYGQDjM5CeLfnl7JMO
         +YnwejpeqISpxpiZ1LdrpRv3Oc097nZc0VgmXPvlmswxgN/kv7TQoxbJ6sDiLZ+ccilaaOywYUyr
         +HyfKEl3Kf7/atW/VUXqRXZFmje82mWt+w6JFWYL1lz8+JHyVfiREIxvcij5Qb0H3Z/sFU50rd8k
         PNu9S76lvkCT18VZygiSdUtppbBeC2/boPkqcyv/gYgDk4qoayNm8xH4Wvl6Xw/tVvHfivUOjkRB
         0UByJ6qH5EWNxrJbtNXyLdcMqP8TorQE5B5xJuEnPVtS8oLNfA/RLuiIprxswTmcyKi+leMn4YPf
         jFO9Vn11GqpG3fVyj6YviE55WoIBq0IAdYB1Z5HDArW6lzQP8ZThyFbO0DJtYxpwy91yTY2vQ/VN
         tkfYXZeUlSzbdrbv/Blg+DDxFmSWSMepDSH8smAlpFAEOfsfbS0PdHET3JjofSqcjUOMvMyhrfqh
         MO8b/rTksKV80hU3gUQjQZz/br/GHDi03fP8vsQZkdCy/BtBxHcpd9P6OKIK+TqEv3U1ICejaym4
         JjC2AlaOKqDQld/R+VCeedv6CzPXXGCitUUC9sTZZdBWH6mrbQURyS6yQuZ5Ajq/WuEcfVA0+YKf
         pi0eLrdm6zRDhFa2kITRu2AKRn3xjGgLsHbz04Mfv4xGwY6athce8Gks+yWdo0Qsh6T25fJ3C0mU
         4+JP73EpbqwgpKp3E6py4I/rNM1WlGTVGw/2wXTwk5vfR3d8Up2h7Z8fNOOMl8jPuOknKXBPN2f+
         d5aq3Q52TTtBKi/WT6IwWpnJjy3atLoVSJmCcUE5fz/lGu0H2EMTVhWEHqAWHSz9oNQM1PKSBjX9
         nUMc5BevkgYJp43u4poNTUkXaxOv+UBvb4PBSGktYMonZAWnNbKgIl/Fa4X6L+srWdPXh904e8nG
         xIfDnWIy4ae9uhT1E1apP6gwzQpNssquY1XWLkl/nNjOMFUfKngsZWc1d3WIeiN9sRKB/AxPqjQC
         1n577wrZTRd2ccXnBA
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Rong Tao <rtoax@foxmail.com>
To:     rppt@kernel.org, rongtao@cestc.cn
Cc:     rtoax@foxmail.com, linux-kernel@vger.kernel.org (open list),
        linux-mm@kvack.org (open list:MEMBLOCK AND MEMORY MANAGEMENT
        INITIALIZATION)
Subject: [PATCH] memblock tests: Fix compilation errors.
Date:   Mon, 11 Sep 2023 22:32:56 +0800
X-OQ-MSGID: <20230911143257.26949-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

This patch fix the follow errors.

commit 61167ad5fecd("mm: pass nid to reserve_bootmem_region()") pass nid
parameter to reserve_bootmem_region(),

    $ make -C tools/testing/memblock/
    ...
    memblock.c: In function ‘memmap_init_reserved_pages’:
    memblock.c:2111:25: error: too many arguments to function ‘reserve_bootmem_region’
    2111 |                         reserve_bootmem_region(start, end, nid);
         |                         ^~~~~~~~~~~~~~~~~~~~~~
    ../../include/linux/mm.h:32:6: note: declared here
    32 | void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
       |      ^~~~~~~~~~~~~~~~~~~~~~
    memblock.c:2122:17: error: too many arguments to function ‘reserve_bootmem_region’
    2122 |                 reserve_bootmem_region(start, end, nid);
         |                 ^~~~~~~~~~~~~~~~~~~~~~

commit dcdfdd40fa82("mm: Add support for unaccepted memory") call
accept_memory() in memblock.c

    $ make -C tools/testing/memblock/
    ...
    cc -fsanitize=address -fsanitize=undefined  main.o memblock.o \
     lib/slab.o mmzone.o slab.o tests/alloc_nid_api.o \
     tests/alloc_helpers_api.o tests/alloc_api.o tests/basic_api.o \
     tests/common.o tests/alloc_exact_nid_api.o   -o main
    /usr/bin/ld: memblock.o: in function `memblock_alloc_range_nid':
    memblock.c:(.text+0x7ae4): undefined reference to `accept_memory'

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/include/linux/mm.h          | 2 +-
 tools/testing/memblock/internal.h | 4 ++++
 tools/testing/memblock/mmzone.c   | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index a03d9bba5151..2bc94079d616 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -29,7 +29,7 @@ static inline void *phys_to_virt(unsigned long address)
 	return __va(address);
 }
 
-void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
+void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
 
 static inline void totalram_pages_inc(void)
 {
diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index fdb7f5db7308..f6c6e5474c3a 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -20,4 +20,8 @@ void memblock_free_pages(struct page *page, unsigned long pfn,
 {
 }
 
+static inline void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+}
+
 #endif
diff --git a/tools/testing/memblock/mmzone.c b/tools/testing/memblock/mmzone.c
index 7b0909e8b759..d3d58851864e 100644
--- a/tools/testing/memblock/mmzone.c
+++ b/tools/testing/memblock/mmzone.c
@@ -11,7 +11,7 @@ struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
 	return NULL;
 }
 
-void reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
+void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid)
 {
 }
 
-- 
2.41.0

