Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE27692ED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjGaKTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGaKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:19:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2EA6;
        Mon, 31 Jul 2023 03:19:31 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=si2rHQ7oAZJMqEY6pXFDHPBiIsEDLkyzqysOdhQbPi8=;
        b=ozxpSvP4x7YQES8NjLra9dpO7QSHryCYZJEqqFc8zP0UVS/7huvIuBGT7Pl35w8dp5EchU
        LXoPUzTYU75AJwi2LVY7d3j5vzcDsqFJhb7vXLntsZcKbx6p5lhvXW53MqbzbhKYhUrwaT
        CrjREpjQ/E8qNC959nMyY0pn0vSyokCzQ5Zq8VAnwLAlAHo2M38ZCtx7ouw3qtDzn6suf9
        iRB35G3X6ahKTVJT4KOOqID16M+A+RxN6JxV9VRSyGed8iB90EJWubBb4fdt4ljYCnTtwd
        Ht9/o4s8f+35h1J3H5nVM96HO2eVVYmGhRwlubeoi3ykSgb5b0Z9dpQ0ehVPpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=si2rHQ7oAZJMqEY6pXFDHPBiIsEDLkyzqysOdhQbPi8=;
        b=BOs2q+y6fnkGN2oRFnmhIrXdr5eHdfinQl8jY7Io6TYpr5eDYWiKg8QOdWb/KlhL4DdZ+1
        FKjoIPYDY3TxkTAQ==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Remove unused extern declaration
 arch_perf_get_page_size()
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230725135038.25060-1-yuehaibing@huawei.com>
References: <20230725135038.25060-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <169079876986.28540.2484423091109012326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     62af03223785c11a0916df6a854ef4785d2350a5
Gitweb:        https://git.kernel.org/tip/62af03223785c11a0916df6a854ef4785d2350a5
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Tue, 25 Jul 2023 21:50:38 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:28:48 +02:00

perf: Remove unused extern declaration arch_perf_get_page_size()

commit 8af26be06272 ("perf/core: Fix arch_perf_get_page_size()")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230725135038.25060-1-yuehaibing@huawei.com
---
 include/linux/perf_event.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9b1cf3c..e83f13c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1860,10 +1860,6 @@ extern void arch_perf_update_userpage(struct perf_event *event,
 				      struct perf_event_mmap_page *userpg,
 				      u64 now);
 
-#ifdef CONFIG_MMU
-extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr);
-#endif
-
 /*
  * Snapshot branch stack on software events.
  *
