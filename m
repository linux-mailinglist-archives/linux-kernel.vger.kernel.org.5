Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3522875E9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGXCeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGXCeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:34:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ED4180
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fToTzt+EUMm0xtTs4UdTiNvO0w2wvNkq6fVJpJWCIds=; b=lsS+vkRN6+2q7LGYzWhw6W05aY
        04Dsl/4gnKtjwQurYx5NQYKajcG54EjjGvmOvFel2N2AppQVS4+3tJi/AwshkhfOJ6gmQwYrgsKOT
        9Kh/+O32BIjJMsXU85Qw3I7PSesptExA2nfQ/SICiFU8EYR9TtsHxabuBm3lgT+b7uuXInkD+6UWR
        jbu0nJHWBt9UiaOWvK3dR8ssJBONzYF9EAZT/zcb8WGGJVTa2/maMIcOlDClJ9eVhfYzoz83KghcW
        dpaS0PEW1UYDqFhj5tflNBK0iQYyCHBJ3RMTyPn+uaomI6UJ8iYx0HmKvez57DhxjCCwjkLaHFTiD
        OiaAZGDw==;
Received: from 50-198-160-193-static.hfc.comcastbusiness.net ([50.198.160.193] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNlOo-002XtI-2k;
        Mon, 24 Jul 2023 02:34:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] cpumask: kernel-doc additions in cpumask.c
Date:   Sun, 23 Jul 2023 19:34:14 -0700
Message-ID: <20230724023414.24882-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Return: value for 4 functions.
Add kernel-doc for cpumask_any_distribute().

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/cpumask.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- linux-next-20230720.orig/lib/cpumask.c
+++ linux-next-20230720/lib/cpumask.c
@@ -14,7 +14,7 @@
  * @start: the start point of the iteration
  * @wrap: assume @n crossing @start terminates the iteration
  *
- * Returns >= nr_cpu_ids on completion
+ * Return: >= nr_cpu_ids on completion
  *
  * Note: the @wrap argument is required for the start condition when
  * we cannot assume @start is set in @mask.
@@ -48,8 +48,9 @@ EXPORT_SYMBOL(cpumask_next_wrap);
  * @node: memory node from which to allocate or %NUMA_NO_NODE
  *
  * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
- * a nop returning a constant 1 (in <linux/cpumask.h>)
- * Returns TRUE if memory allocation succeeded, FALSE otherwise.
+ * a nop returning a constant 1 (in <linux/cpumask.h>).
+ *
+ * Return: TRUE if memory allocation succeeded, FALSE otherwise.
  *
  * In addition, mask will be NULL if this fails.  Note that gcc is
  * usually smart enough to know that mask can never be NULL if
@@ -115,7 +116,7 @@ void __init free_bootmem_cpumask_var(cpu
  * @i: index number
  * @node: local numa_node
  *
- * Returns online CPU according to a numa aware policy; local cpus are returned
+ * Return: online CPU according to a numa aware policy; local cpus are returned
  * first, followed by non-local ones, then it wraps around.
  *
  * For those who wants to enumerate all CPUs based on their NUMA distances,
@@ -162,7 +163,7 @@ static DEFINE_PER_CPU(int, distribute_cp
  * Iterated calls using the same srcp1 and srcp2 will be distributed within
  * their intersection.
  *
- * Returns >= nr_cpu_ids if the intersection is empty.
+ * Return: >= nr_cpu_ids if the intersection is empty.
  */
 unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p)
@@ -181,6 +182,12 @@ unsigned int cpumask_any_and_distribute(
 }
 EXPORT_SYMBOL(cpumask_any_and_distribute);
 
+/**
+ * cpumask_any_distribute - Return an arbitrary cpu from srcp
+ * @srcp: &cpumask for selection
+ *
+ * Return: >= nr_cpu_ids if the intersection is empty.
+ */
 unsigned int cpumask_any_distribute(const struct cpumask *srcp)
 {
 	unsigned int next, prev;
