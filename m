Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE667787928
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbjHXUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbjHXUMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:12:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598B91BF1;
        Thu, 24 Aug 2023 13:12:36 -0700 (PDT)
Date:   Thu, 24 Aug 2023 20:12:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692907955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9zq1WZ2DCe9jjiBg6LsVIHzpgwgz+1ksLTOAXXF0I4=;
        b=GNsq/kADCHasr8jGZJYhSu7Qnp3g0Y34zSbIBqIRkbmdb6DpQ6c3iG3AcclZFmg5I1ExME
        Uge+CvnpVZWfS4Gd95y+IcX/Wk+y9rzsKardZjfnP0FHzxhbIR0I8cpgA2qZBa8ISVSmeA
        WQDBeLEXxI+zjMZfLheURYKIV4SuYNN++WWUPUIfxOsvdRs9yjnj8fhWUUWy7LzghNyY2L
        luxnIFqk7c7fm0GhvJtKDoAwCXRInJa2P7D+01PGs+jjV2t27EVNfKrKgtR9raUXd0O5Nt
        w1V/HekDhlH0WRJGchhJD2ZlgwpDRS2+qaq4O3DLscyNSVkiXbKBZz99s9UTYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692907955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9zq1WZ2DCe9jjiBg6LsVIHzpgwgz+1ksLTOAXXF0I4=;
        b=enCGiJHW/09Wb6RkBKgL+C2aFMf2gJ46/dWS9RM0+HCsfolojSmKHfFLBiSPvrOOovSQyw
        1sALOYUbgKTPdADw==
From:   "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf/doc: Modify the documented knob to
 base_slice_ns as well
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230824080342.543396-1-sshegde@linux.vnet.ibm.com>
References: <20230824080342.543396-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <169290795445.27769.10094416642854950152.tip-bot2@tip-bot2>
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

Commit-ID:     2f88c8e802c8b128a155976631f4eb2ce4f3c805
Gitweb:        https://git.kernel.org/tip/2f88c8e802c8b128a155976631f4eb2ce4f3c805
Author:        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
AuthorDate:    Thu, 24 Aug 2023 13:33:42 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Aug 2023 21:31:57 +02:00

sched/eevdf/doc: Modify the documented knob to base_slice_ns as well

After committing the scheduler to EEVDF, we renamed the 'min_granularity_ns'
sysctl to 'base_slice_ns':

   e4ec3318a17f ("sched/debug: Rename sysctl_sched_min_granularity to sysctl_sched_base_slice")

... but we forgot to rename it in the documentation. Do that now.

Fixes: e4ec3318a17f ("sched/debug: Rename sysctl_sched_min_granularity to sysctl_sched_base_slice")
Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230824080342.543396-1-sshegde@linux.vnet.ibm.com
---
 Documentation/scheduler/sched-design-CFS.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
index 03db555..f689198 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -94,7 +94,7 @@ other HZ detail.  Thus the CFS scheduler has no notion of "timeslices" in the
 way the previous scheduler had, and has no heuristics whatsoever.  There is
 only one central tunable (you have to switch on CONFIG_SCHED_DEBUG):
 
-   /sys/kernel/debug/sched/min_granularity_ns
+   /sys/kernel/debug/sched/base_slice_ns
 
 which can be used to tune the scheduler from "desktop" (i.e., low latencies) to
 "server" (i.e., good batching) workloads.  It defaults to a setting suitable
