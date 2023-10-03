Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7477B71D8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbjJCTfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbjJCTfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:35:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2991AC;
        Tue,  3 Oct 2023 12:35:09 -0700 (PDT)
Date:   Tue, 03 Oct 2023 19:35:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696361708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/l4G+biN+V3AM4d7wOYKSw2LMeg2qO6SavzJZSqjzOc=;
        b=pOYlLhoG3yOIEGlhKrP/cXxn+jbWhrTNtddqhdRG/Ccu08QNydZvyBbe6eQ/xZ0dXpdwye
        69QGYRnZar+SrSH7w+sW/ilwm6X3CfSmWGSV7OBoXqIks5TQY6R/nNxaAF5/O5zPWfgIk+
        DWZLhamYb7NIUdj1IYGTG4wJB4QTL3GfbUtAcrtEJEooUJbyAVeCDHxdJXFHZ9kS91613e
        m6JSZEXMWwJ/PjLiAUlOz7+xFTdtQp53I09nHp32g8G3YKkbf7ACiE5QnEA556mCR02Unn
        jKOXaJb7YKQu9Uboy3ucMgOkBWyECZavd9bPNKqz5Cdi/653NVoud4V7egQuYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696361708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/l4G+biN+V3AM4d7wOYKSw2LMeg2qO6SavzJZSqjzOc=;
        b=iwxgdqwXmwRZMhqOvLV5/m+Z7d8RfAF/+gCKn5O7ie8eOr3HOQeNjDJmpwICNV3xntfF5t
        E0W5pASVG3fYhXAg==
From:   "tip-bot2 for Yu Liao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Remove duplicate header inclusions
Cc:     Yu Liao <liaoyu15@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230802021501.2511569-1-liaoyu15@huawei.com>
References: <20230802021501.2511569-1-liaoyu15@huawei.com>
MIME-Version: 1.0
Message-ID: <169636170770.3135.292145012976825156.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d4d6596b43868a1e05fe5b047e73c3aff96444c6
Gitweb:        https://git.kernel.org/tip/d4d6596b43868a1e05fe5b047e73c3aff96444c6
Author:        Yu Liao <liaoyu15@huawei.com>
AuthorDate:    Wed, 02 Aug 2023 10:15:01 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 21:27:55 +02:00

sched/headers: Remove duplicate header inclusions

<linux/psi.h> and "autogroup.h" are included twice, remove the duplicate header
inclusion.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230802021501.2511569-1-liaoyu15@huawei.com
---
 kernel/sched/build_utility.c | 1 -
 kernel/sched/core.c          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 99bdd96..80a3df4 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -34,7 +34,6 @@
 #include <linux/nospec.h>
 #include <linux/proc_fs.h>
 #include <linux/psi.h>
-#include <linux/psi.h>
 #include <linux/ptrace_api.h>
 #include <linux/sched_clock.h>
 #include <linux/security.h>
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 324980e..27aff98 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -85,7 +85,6 @@
 
 #include "sched.h"
 #include "stats.h"
-#include "autogroup.h"
 
 #include "autogroup.h"
 #include "pelt.h"
