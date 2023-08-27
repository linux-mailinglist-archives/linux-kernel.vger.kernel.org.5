Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32225789C92
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjH0JUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjH0JU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07397E1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F7660F16
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 09:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4964DC433C9;
        Sun, 27 Aug 2023 09:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693128018;
        bh=Ibu7OZXmFF1/tmfUzC1QszDkKdxJxutlMYfydtDtkvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeCRgMOdogG7W1AW/VS6qgIe7qwaMx9kWoBCGgkEbH6+sxJl8X216MNKabS6Bw+vg
         UM97X5t7yxV+PrryitqcAJSBbZF5tia9snUfPZ/EC9iDXw59v+qZXOkUbdWWj/KWSt
         5FtcgclCDM2u75WzRMVuRI8AbBZST+F6t4LrokgnV2kaztAvDy4vl4Q9pizUVj83D8
         3M6QKXbwoo4wwe8DJCjAZuW2lQsN5lGDuLnUY0U6lL9Gt29EhMOQLS2C8iSNuTqSNn
         6BHfcMh6tjszCuBuD65E9KXdGDfQvJzh3xFDQYJ156Pmgdk4rPkKc4RC+m+IA+G91+
         3+bwOzkQ5tJRA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 2/2] riscv: errata: prefix T-Head mnemonics with th.
Date:   Sun, 27 Aug 2023 17:08:13 +0800
Message-Id: <20230827090813.1353-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827090813.1353-1-jszhang@kernel.org>
References: <20230827090813.1353-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <uwu@icenowy.me>

T-Head now maintains some specification for their extended instructions
at [1], in which all instructions are prefixed "th.".

Follow this practice in the kernel comments.

Link: https://github.com/T-head-Semi/thead-extension-spec [1]
Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 arch/riscv/include/asm/errata_list.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index feab334dd832..98ecab053dd2 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -90,25 +90,25 @@ asm volatile(ALTERNATIVE(						\
 #endif
 
 /*
- * dcache.ipa rs1 (invalidate, physical address)
+ * th.dcache.ipa rs1 (invalidate, physical address)
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
  *   0000001    01010      rs1       000      00000  0001011
- * dache.iva rs1 (invalida, virtual address)
+ * th.dache.iva rs1 (invalida, virtual address)
  *   0000001    00110      rs1       000      00000  0001011
  *
- * dcache.cpa rs1 (clean, physical address)
+ * th.dcache.cpa rs1 (clean, physical address)
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
  *   0000001    01001      rs1       000      00000  0001011
- * dcache.cva rs1 (clean, virtual address)
+ * th.dcache.cva rs1 (clean, virtual address)
  *   0000001    00101      rs1       000      00000  0001011
  *
- * dcache.cipa rs1 (clean then invalidate, physical address)
+ * th.dcache.cipa rs1 (clean then invalidate, physical address)
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
  *   0000001    01011      rs1       000      00000  0001011
- * dcache.civa rs1 (... virtual address)
+ * th.dcache.civa rs1 (... virtual address)
  *   0000001    00111      rs1       000      00000  0001011
  *
- * sync.s (make sure all cache operations finished)
+ * th.sync.s (make sure all cache operations finished)
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
  *   0000000    11001     00000      000      00000  0001011
  */
-- 
2.40.1

