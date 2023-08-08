Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD436774132
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjHHRQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjHHRPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:15:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649762D5B;
        Tue,  8 Aug 2023 09:06:18 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:59:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691485156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRTAJBEqdoIqtU1fMTNa9ss/qzISSuT9FpyeLJjVRzs=;
        b=JZ5uwZHIcQwKkYH1TBRgIRa1c91CxdUiA/o4NovsnqNDZGMuG9b5LxAIUyFn79PZneDkss
        DLrDVIhGtQYU5dgJ/yl4OO75GdrCN6evDqbtBGumnpQkMfyZd6sO9EConBZ4deDzqADGbb
        2Z0oSHa0VdXnvxttH/dswYcqyIXPE0afjNuYDITR7DUNXPCAqzXruDXpeor6D+V5og5J5M
        lt+1jIIFl90DF2j2W395iJDNs3f1IucaRhRnETI+HRWYWBDJmVAI9PvmMDTZbTZl5hoeBT
        sU9hlhMtSZKtTokkm8DJpDIth18+3JQc2tTvIu6AsA+cxc7cmluW38VgnYWsLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691485156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRTAJBEqdoIqtU1fMTNa9ss/qzISSuT9FpyeLJjVRzs=;
        b=apP4cgbaxuJ2fNBJJ1eYz3lmKZQVlnhDae/HKCLkAFAXTKSIROQytcsvaTsu5BpRUEF8pk
        5Uj7ZvjWJLlSaQBw==
From:   "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] Documentation: core-api/cpuhotplug: Fix state names
Cc:     "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515162038.62703-1-anna-maria@linutronix.de>
References: <20230515162038.62703-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Message-ID: <169148515588.27769.11927101338682187648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     e0a99a839f04c90bf9f16919997c4b34f9c8f1f0
Gitweb:        https://git.kernel.org/tip/e0a99a839f04c90bf9f16919997c4b34f9c8f1f0
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 15 May 2023 18:20:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 08 Aug 2023 10:55:58 +02:00

Documentation: core-api/cpuhotplug: Fix state names

Dynamic allocated hotplug states in documentation and the comment above
cpuhp_state enum do not match the code. To not get confused by wrong
documentation, change to proper state names.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230515162038.62703-1-anna-maria@linutronix.de
---
 Documentation/core-api/cpu_hotplug.rst | 10 +++++-----
 include/linux/cpuhotplug.h             |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index e6f5bc3..b9ae591 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -395,8 +395,8 @@ multi-instance state the following function is available:
 * cpuhp_setup_state_multi(state, name, startup, teardown)
 
 The @state argument is either a statically allocated state or one of the
-constants for dynamically allocated states - CPUHP_PREPARE_DYN,
-CPUHP_ONLINE_DYN - depending on the state section (PREPARE, ONLINE) for
+constants for dynamically allocated states - CPUHP_BP_PREPARE_DYN,
+CPUHP_AP_ONLINE_DYN - depending on the state section (PREPARE, ONLINE) for
 which a dynamic state should be allocated.
 
 The @name argument is used for sysfs output and for instrumentation. The
@@ -588,7 +588,7 @@ notifications on online and offline operations::
 Setup and teardown a dynamically allocated state in the ONLINE section
 for notifications on offline operations::
 
-   state = cpuhp_setup_state(CPUHP_ONLINE_DYN, "subsys:offline", NULL, subsys_cpu_offline);
+   state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "subsys:offline", NULL, subsys_cpu_offline);
    if (state < 0)
        return state;
    ....
@@ -597,7 +597,7 @@ for notifications on offline operations::
 Setup and teardown a dynamically allocated state in the ONLINE section
 for notifications on online operations without invoking the callbacks::
 
-   state = cpuhp_setup_state_nocalls(CPUHP_ONLINE_DYN, "subsys:online", subsys_cpu_online, NULL);
+   state = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "subsys:online", subsys_cpu_online, NULL);
    if (state < 0)
        return state;
    ....
@@ -606,7 +606,7 @@ for notifications on online operations without invoking the callbacks::
 Setup, use and teardown a dynamically allocated multi-instance state in the
 ONLINE section for notifications on online and offline operation::
 
-   state = cpuhp_setup_state_multi(CPUHP_ONLINE_DYN, "subsys:online", subsys_cpu_online, subsys_cpu_offline);
+   state = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "subsys:online", subsys_cpu_online, subsys_cpu_offline);
    if (state < 0)
        return state;
    ....
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 25b6e6e..06dda85 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -48,7 +48,7 @@
  *    same section.
  *
  * If neither #1 nor #2 apply, please use the dynamic state space when
- * setting up a state by using CPUHP_PREPARE_DYN or CPUHP_PREPARE_ONLINE
+ * setting up a state by using CPUHP_BP_PREPARE_DYN or CPUHP_AP_ONLINE_DYN
  * for the @state argument of the setup function.
  *
  * See Documentation/core-api/cpu_hotplug.rst for further information and
