Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1659B78CD08
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbjH2Tco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbjH2Tcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:32:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC31BE;
        Tue, 29 Aug 2023 12:32:10 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:32:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693337526;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrRWQQoDSArxZusG/tlvTvReg5VXP5p7aFpkbF5LA3k=;
        b=iE3yJQVuqoJEop/mmGbFADRxfZCVOy8Ga3PHdyNGNrDq7fWWLIgZWiVn9eZ8swcfwwc4HO
        8gwsUwxDMrbI6Cbu1UIfPuFZUEHOqmcojR2aUO7W8uCVZ2kc4eHcDbY7T56G2k5qrNjPnc
        YJbFVsKmMD6rQKDUxYMP6tv3qhDg+k7v4eFm4VKK/eAvip1urryvu5LkHQQv1AZUucvtFe
        zFOYutB+otMNMVAJou+4yyhaHeMo/TQwqIXyWcuUAPnUwy1ws+HMdfu56P3NAFl++S2N0a
        u7rGLasFILE/5Pq+4o2S082KS4WUdc/u6QcOI6y9QN9yAUYdOjGRqcMmIh2LAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693337526;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrRWQQoDSArxZusG/tlvTvReg5VXP5p7aFpkbF5LA3k=;
        b=yFLRoZkvnov7TbIUIXW+A+fv5+Vs4PmVsTm1E5Q77GTeThjXxXjRRWQdSEk9QHUqkrS5Bp
        OqCltRzE4jrMkyCQ==
From:   "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Make update_entity_lag() static
Cc:     Hao Jia <jiahao.os@bytedance.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230829030325.69128-1-jiahao.os@bytedance.com>
References: <20230829030325.69128-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Message-ID: <169333752613.27769.784028076271904268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c958ca2013e28e7573ad95c028198cb67c1352dd
Gitweb:        https://git.kernel.org/tip/c958ca2013e28e7573ad95c028198cb67c1352dd
Author:        Hao Jia <jiahao.os@bytedance.com>
AuthorDate:    Tue, 29 Aug 2023 11:03:25 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Aug 2023 21:05:28 +02:00

sched/fair: Make update_entity_lag() static

The function update_entity_lag() is only used inside the kernel/sched/fair.c file.
Make it static.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230829030325.69128-1-jiahao.os@bytedance.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 911d006..8dbff6e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -699,7 +699,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
-void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	s64 lag, limit;
 
