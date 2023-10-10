Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4547C42E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjJJVr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJJVr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:47:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC91599;
        Tue, 10 Oct 2023 14:47:55 -0700 (PDT)
Date:   Tue, 10 Oct 2023 21:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696974474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBIwsLIGsV1PbJPfRcNGsZxdG0JVwlvbNLWv4wvA8DY=;
        b=Z6mCbP16Vy4I8FAjMnVt9Y+N32eRt19XhGNagGwyvlqEYPy2ncireZBUZJA3Q82mdFUYrQ
        pVfKTMQ+3jOLOO2DQIYFR34Io28QOi129eSl48NNZL4gOoC1EpsO8rR3kj/b2kpqY9P513
        M63u8rHoE2j1AOLFT2c79l3kToirw4k7GeUqCFzw3CbKdJEqiT7eZ3TV47csWdTZdhh/mJ
        2PNiyO4BUG3sz8978RsoFJsj3I5r/+a2SuiiD98NZxBGI56k5hzbf1QnIAeEGEwXTUePIO
        iWEAizBc/O8c9eEuH9c14PHAJR7o28SUl5q8dS6dD3CEdjP7xbWEFayLda7ybg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696974474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBIwsLIGsV1PbJPfRcNGsZxdG0JVwlvbNLWv4wvA8DY=;
        b=c55l/3ZXsPJTRIJNL0S6gjli2DSE2yeyXnGPIRJMiZrP0VFV6pybhlhADs8UciatlszHk0
        zvZy9bcx3pY1MZCw==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Remove comment referring to
 rq::cpu_load, since this has been removed
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010155744.1381065-1-colin.i.king@gmail.com>
References: <20231010155744.1381065-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Message-ID: <169697447356.3135.18063293604947285416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b19fdb16fb2167c6bc9ee8fbc0c1d2d4fd3e2eb8
Gitweb:        https://git.kernel.org/tip/b19fdb16fb2167c6bc9ee8fbc0c1d2d4fd3e2eb8
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Tue, 10 Oct 2023 16:57:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Oct 2023 23:42:20 +02:00

sched/headers: Remove comment referring to rq::cpu_load, since this has been removed

There is a comment that refers to cpu_load, however, this cpu_load was
removed with:

  55627e3cd22c ("sched/core: Remove rq->cpu_load[]")

... back in 2019. The comment does not make sense with respect to this
removed array, so remove the comment.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231010155744.1381065-1-colin.i.king@gmail.com
---
 kernel/sched/sched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index faf9031..65cad0e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -948,10 +948,6 @@ struct rq {
 	/* runqueue lock: */
 	raw_spinlock_t		__lock;
 
-	/*
-	 * nr_running and cpu_load should be in the same cacheline because
-	 * remote CPUs use both these fields when doing load calculation.
-	 */
 	unsigned int		nr_running;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
