Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4697CD6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjJRIjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjJRIji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:39:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CDEEA;
        Wed, 18 Oct 2023 01:39:35 -0700 (PDT)
Date:   Wed, 18 Oct 2023 08:39:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697618373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FxJ214tTC3Ga4e8z0UB3atScPcX1trtpBjOv5omanQQ=;
        b=bKusSB4Czmphn3Fpo9v1dpysTmF4UemtmDl3LiG8PjYT/PXmwTrzmHT2hxSSh0CCBR1FnB
        KBbfwhEgBhU3U9aGLzqa9mjGPW7DxkhI9UR+zdWKit/akybcf6HrVD92Aou+mL7lP+NisR
        25azMZxzxiTqZXQ4Lu+BdgxdwXRMivplI5kSRV+cFNe5v6CVE0fkSOZvrmgNyTEuYtWDCp
        Xvq5s1aX3jK7uMjWN5KTBJovcTE8NHRCs9VBDz8jtXk72ShaBuxyIttXS8qk/mr1+BhDSm
        3mQPfgLXoGisN7CNhyGRXsfl5prxIif1Fe1w1CzfsmILl8HKw08DJSxauykFkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697618373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FxJ214tTC3Ga4e8z0UB3atScPcX1trtpBjOv5omanQQ=;
        b=aX5YLFIQujRc368nJMfQ+PNKMZjeRCAHG9sT8EEEXiprU/PAEZweFkhyVb7YfOv7mzp5J8
        eW/eeUx+t/6RWlAg==
From:   "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove duplicate #include
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231018062759.44375-1-jiapeng.chong@linux.alibaba.com>
References: <20231018062759.44375-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <169761837272.3135.2661780509672715179.tip-bot2@tip-bot2>
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

Commit-ID:     1b7ef2d94ff4cb0b1186a224a97349864820c606
Gitweb:        https://git.kernel.org/tip/1b7ef2d94ff4cb0b1186a224a97349864820c606
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Wed, 18 Oct 2023 14:27:59 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Oct 2023 10:32:31 +02:00

sched/fair: Remove duplicate #include

./kernel/sched/fair.c: linux/sched/cond_resched.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231018062759.44375-1-jiapeng.chong@linux.alibaba.com

Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6907
---
 kernel/sched/fair.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 38d757c..9ae2208 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -51,8 +51,6 @@
 
 #include <asm/switch_to.h>
 
-#include <linux/sched/cond_resched.h>
-
 #include "sched.h"
 #include "stats.h"
 #include "autogroup.h"
