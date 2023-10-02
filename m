Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16C47B5405
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbjJBNeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbjJBNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:34:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE9394;
        Mon,  2 Oct 2023 06:33:59 -0700 (PDT)
Date:   Mon, 02 Oct 2023 13:33:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696253637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3B5HvJRTYZooyesqcYO298zFGCQXM3m4DvMYNjoA7c=;
        b=obEmbsdTCjJeQWro29uZKjEhEalKRw8wo8dIQKfGVJXVxXWvS5Sgln0j6z+s4sFDCxgM+R
        nhmU23Rp1F5wL0m22fezMdVfMAHgE9ZbMA5M8EFVoYVDBNBmHmZBXRx6D9QThxkxwKDMw0
        vCAySkzBDvLq6IjfewtnEnAv9JCgpV4M0AmYTmXoMA1OukBez/oD9Aq2pOQzsEEfQNuru3
        6GEIyCy7wLimedfC4KY/FcuLOn9O+vw95YcWvsbDvGTqEoCc/jR8Vj2CLAS/J6nC/etA/x
        ZCVqESDJCimepe+Lz8uVHzKgOH7TmgAYkGfftjd8G+7ATSe8Aslabqh+FM0zDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696253637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3B5HvJRTYZooyesqcYO298zFGCQXM3m4DvMYNjoA7c=;
        b=YOD0gdBL4Z+Hmq5vRL+qGAT11iLNNhOzYlTTDTaH/oYU8Fh7tgvZdAhHu1Gl9SPraBAiyo
        g4WWvGYtvbM8K4Dw==
From:   "tip-bot2 for Cyril Hrubis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt/docs: Clarify & fix sched_rt_* sysctl docs
Cc:     Cyril Hrubis <chrubis@suse.cz>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231002115553.3007-3-chrubis@suse.cz>
References: <20231002115553.3007-3-chrubis@suse.cz>
MIME-Version: 1.0
Message-ID: <169625363717.3135.9382164019084788726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e6dbdd8fb75526b01787050087b65d12c76b3666
Gitweb:        https://git.kernel.org/tip/e6dbdd8fb75526b01787050087b65d12c76b3666
Author:        Cyril Hrubis <chrubis@suse.cz>
AuthorDate:    Mon, 02 Oct 2023 13:55:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 02 Oct 2023 15:17:13 +02:00

sched/rt/docs: Clarify & fix sched_rt_* sysctl docs

- Describe explicitly that sched_rt_runtime_us is allocated from
  sched_rt_period_us and hence always less or equal to that value.

- The limit for sched_rt_runtime_us is not INT_MAX-1, but rather it's
  limited by the value of sched_rt_period_us. If sched_rt_period_us is
  INT_MAX then sched_rt_runtime_us can be set to INT_MAX as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231002115553.3007-3-chrubis@suse.cz
---
 Documentation/scheduler/sched-rt-group.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index 655a096..a16bee8 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -87,18 +87,20 @@ lack an EDF scheduler to make non-uniform periods usable.
 The system wide settings are configured under the /proc virtual file system:
 
 /proc/sys/kernel/sched_rt_period_us:
-  The scheduling period that is equivalent to 100% CPU bandwidth
+  The scheduling period that is equivalent to 100% CPU bandwidth.
 
 /proc/sys/kernel/sched_rt_runtime_us:
-  A global limit on how much time realtime scheduling may use.  Even without
-  CONFIG_RT_GROUP_SCHED enabled, this will limit time reserved to realtime
-  processes. With CONFIG_RT_GROUP_SCHED it signifies the total bandwidth
-  available to all realtime groups.
+  A global limit on how much time realtime scheduling may use. This is always
+  less or equal to the period_us, as it denotes the time allocated from the
+  period_us for the realtime tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
+  this will limit time reserved to realtime processes. With
+  CONFIG_RT_GROUP_SCHED=y it signifies the total bandwidth available to all
+  realtime groups.
 
   * Time is specified in us because the interface is s32. This gives an
     operating range from 1us to about 35 minutes.
   * sched_rt_period_us takes values from 1 to INT_MAX.
-  * sched_rt_runtime_us takes values from -1 to (INT_MAX - 1).
+  * sched_rt_runtime_us takes values from -1 to sched_rt_period_us.
   * A run time of -1 specifies runtime == period, ie. no limit.
 
 
