Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D217BC320
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjJFXvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjJFXvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:51:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B0ABD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=eda8bkHW/wfNmnWvVarEi8u05ELZ2c0LLY0YPElc1Y0=; b=Kr8slfhvovWJW1h9cAaaosEWQB
        UCJkNIp+XgYlakdUDtnDKQOCta6hLiVuHDc6xTTP6+ww40zPE/LbSJ2WvoSVQkapKWp0wagwOiUuY
        vD87U2+F8kCZHFoqudkEq5F6UJ/p1RbBeyVq81keRvlPd2keKEqF+U65MQrCLSYRPdzVxZG/H0X9Q
        L9xUT2TQGMdHKh42unQfSPq5lAtxQ5EKsnrDjg8kYbTKtPuOnQGACCIGJWulsvZTmvVWuEuO0Gd8h
        TOGNiOTtT17WASI0L+qWkvnCLQImnmfYdYae9E2a9vsJGMkXh8EJAndCP3qWupJUckKsbxSPmWLB+
        q6Z51jfA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qoubV-006fdq-0Z;
        Fri, 06 Oct 2023 23:51:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: [PATCH] x86/intel_rdt/cqm: fix kernel-doc warnings
Date:   Fri,  6 Oct 2023 16:51:32 -0700
Message-ID: <20231006235132.16227-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot reported kernel-doc warnings here:

monitor.c:34: warning: Cannot understand  * @rmid_free_lru    A least recently used list of free RMIDs
 on line 34 - I thought it was a doc line
monitor.c:41: warning: Cannot understand  * @rmid_limbo_count     count of currently unused but (potentially)
 on line 41 - I thought it was a doc line
monitor.c:50: warning: Cannot understand  * @rmid_entry - The entry in the limbo and free lists.
 on line 50 - I thought it was a doc line

We don't have a syntax for documenting individual data items via
kernel-doc, so remove the "/**" kernel-doc markers and add a hyphen
for consistency.

Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
Fixes: 24247aeeabe9 ("x86/intel_rdt/cqm: Improve limbo list processing")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202310062356.lX3xpLP9-lkp@intel.com/
Cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
---
Not using Closes: since this patch only addresses some of the issues
  reported.

 arch/x86/kernel/cpu/resctrl/monitor.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -- a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -30,15 +30,15 @@ struct rmid_entry {
 	struct list_head		list;
 };
 
-/**
- * @rmid_free_lru    A least recently used list of free RMIDs
+/*
+ * @rmid_free_lru - A least recently used list of free RMIDs
  *     These RMIDs are guaranteed to have an occupancy less than the
  *     threshold occupancy
  */
 static LIST_HEAD(rmid_free_lru);
 
-/**
- * @rmid_limbo_count     count of currently unused but (potentially)
+/*
+ * @rmid_limbo_count - count of currently unused but (potentially)
  *     dirty RMIDs.
  *     This counts RMIDs that no one is currently using but that
  *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
@@ -46,7 +46,7 @@ static LIST_HEAD(rmid_free_lru);
  */
 static unsigned int rmid_limbo_count;
 
-/**
+/*
  * @rmid_entry - The entry in the limbo and free lists.
  */
 static struct rmid_entry	*rmid_ptrs;
