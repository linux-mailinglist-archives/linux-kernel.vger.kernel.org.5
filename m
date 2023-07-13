Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8675169D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjGMDIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjGMDIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:08:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782AF1BD4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Y0sPLF5aVYVsJG2qcCZTDi+Jbzew9ykSv/hCoWV/WPI=; b=Gm1FOHM5A2OQWxfTBx2xtCY7qI
        rjgMpmJoRuRum6A+zb94Ptr/ljjUJS9qnjiWJ8YSkrzZCUP5PqOunrOVnC+0P1M2ydKHfrLZ/YT6Q
        FEgjj04uz1l9DDJjPSpQ8M8f3VqU1NFqZcTc+32J5FgmdKXaeJ8DYm9K0+Wpx4ZmKX5rLF2qIF7d5
        NV7tWx+fn3zvyUOEQP+9gWYNjEWod6o39TWaPKEsoRNep24zR5U+P5fZolfrh3lN1rM82MeyxYFaJ
        I5euXRrsLYNGp+PXidAkRQf79LTs8EFobwilxODF7pJJAJdk81NDqEe8fIcTzOVVHv1+34bm3g39/
        KAod/dVA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJmgz-001nEP-2O;
        Thu, 13 Jul 2023 03:08:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] cpumask: eliminate kernel-doc warnings
Date:   Wed, 12 Jul 2023 20:08:32 -0700
Message-ID: <20230713030832.17900-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update lib/cpumask.c and <linux/cpumask.h> to fix all kernel-doc
warnings:

include/linux/cpumask.h:185: warning: Function parameter or member 'srcp1' not described in 'cpumask_first_and'
include/linux/cpumask.h:185: warning: Function parameter or member 'srcp2' not described in 'cpumask_first_and'
include/linux/cpumask.h:185: warning: Excess function parameter 'src1p' description in 'cpumask_first_and'
include/linux/cpumask.h:185: warning: Excess function parameter 'src2p' description in 'cpumask_first_and'

lib/cpumask.c:59: warning: Function parameter or member 'node' not described in 'alloc_cpumask_var_node'
lib/cpumask.c:169: warning: Function parameter or member 'src1p' not described in 'cpumask_any_and_distribute'
lib/cpumask.c:169: warning: Function parameter or member 'src2p' not described in 'cpumask_any_and_distribute'

Fixes: 7b4967c53204 ("cpumask: Add alloc_cpumask_var_node()")
Fixes: 839cad5fa54b ("cpumask: fix function description kernel-doc notation")
Fixes: 93ba139ba819 ("cpumask: use find_first_and_bit()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/cpumask.h |    8 ++++++--
 lib/cpumask.c           |    5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff -- a/lib/cpumask.c b/lib/cpumask.c
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -45,6 +45,7 @@ EXPORT_SYMBOL(cpumask_next_wrap);
  * alloc_cpumask_var_node - allocate a struct cpumask on a given node
  * @mask: pointer to cpumask_var_t where the cpumask is returned
  * @flags: GFP_ flags
+ * @node: memory node from which to allocate or %NUMA_NO_NODE
  *
  * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
  * a nop returning a constant 1 (in <linux/cpumask.h>)
@@ -157,7 +158,9 @@ EXPORT_SYMBOL(cpumask_local_spread);
 static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
 
 /**
- * cpumask_any_and_distribute - Return an arbitrary cpu within srcp1 & srcp2.
+ * cpumask_any_and_distribute - Return an arbitrary cpu within src1p & src2p.
+ * @src1p: first &cpumask for intersection
+ * @src2p: second &cpumask for intersection
  *
  * Iterated calls using the same srcp1 and srcp2 will be distributed within
  * their intersection.
diff -- a/include/linux/cpumask.h b/include/linux/cpumask.h
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -175,8 +175,8 @@ static inline unsigned int cpumask_first
 
 /**
  * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
- * @src1p: the first input
- * @src2p: the second input
+ * @srcp1: the first input
+ * @srcp2: the second input
  *
  * Returns >= nr_cpu_ids if no cpus set in both.  See also cpumask_next_and().
  */
@@ -1197,6 +1197,10 @@ cpumap_print_bitmask_to_buf(char *buf, c
 /**
  * cpumap_print_list_to_buf  - copies the cpumask into the buffer as
  *	comma-separated list of cpus
+ * @buf: the buffer to copy into
+ * @mask: the cpumask to copy
+ * @off: in the string from which we are copying, we copy to @buf
+ * @count: the maximum number of bytes to print
  *
  * Everything is same with the above cpumap_print_bitmask_to_buf()
  * except the print format.
