Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0AC78E6C3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbjHaGuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjHaGuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F9FAB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693464570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a0j4n2f1vvayV+xcAyvLcHnKmq3B9Kju9cEAHJNe8NI=;
        b=hO84rlnlwj+8x0HwoNjYYwPgfT5Si2NQ3tsQmo0d3PQ5aZBByQ3PaGmM5h+XiEG2ubiPAj
        CFNYjlrFwGENTY5Mr7n3DhW900VErVsaqVN4DV2XBHPicl1W9N8z6j+3YQ6YW8GVVAvTwL
        RTaF1iyn4TmaGkuh/zq4cJ7kBJZ9XwY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-P6M_U51_NHyTk2NOS-ddQg-1; Thu, 31 Aug 2023 02:31:45 -0400
X-MC-Unique: P6M_U51_NHyTk2NOS-ddQg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a7292a2ad5so586472b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693463504; x=1694068304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0j4n2f1vvayV+xcAyvLcHnKmq3B9Kju9cEAHJNe8NI=;
        b=eaFLk+LV+joYDXNMkuSQ4+oiPpks6pKJnGGpUPZ421S+ZNZw7XyQfeprNT1hSNHsuc
         9Pglg9wf04YszTs4AQsbsAa/1L16W/rayc+7G8i72SaXCFS2UopMhHZMaZI2QR90l3MC
         Pdm84vUQfs+lmnuTmUrG4xj7WA+8vnZ2HJVq5jchFFsJvuUBYocEYfwc0CQew4kCDUMv
         LSultYpcbadcdyasa+VPOhR5MNg1lhDhtI4AyW4c0Qt0Ix87E7xhQdgaxkUcMqW/14Gt
         e/EJO8CeWOwuxFndP7ctlmiENy0xbtmmq5sE56zLNninp3lnWhFq9hTZ3iCzkyErKpZY
         6bYA==
X-Gm-Message-State: AOJu0YzgatYpzijzTvakmFJwbM2KSBKooBx996BsWS3CwoItuUfAvwxP
        4ReZY/FDq1ZDGqAWYGuPxg7F84d5LVqagc77HDTowY0DBKT0pSm22DC+9YzNsUNct5HCBeAn1sv
        EjbFInlbWcHHVnfqPg2t+n0sK
X-Received: by 2002:a05:6808:238f:b0:3a1:e85f:33ee with SMTP id bp15-20020a056808238f00b003a1e85f33eemr5621618oib.56.1693463504369;
        Wed, 30 Aug 2023 23:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWGPbpGZOjZ1PVSXOQOOFe4pOZuYRECY9B070QswchEb6V81KoAeJA5CjZWgpMx6HCqme1wA==
X-Received: by 2002:a05:6808:238f:b0:3a1:e85f:33ee with SMTP id bp15-20020a056808238f00b003a1e85f33eemr5621611oib.56.1693463504114;
        Wed, 30 Aug 2023 23:31:44 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a802:98e3:3c98:3d83:9703:4411])
        by smtp.gmail.com with ESMTPSA id fa28-20020a0568082a5c00b003a9a35349b1sm404009oib.24.2023.08.30.23.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 23:31:43 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] smp: Change function signatures to use call_single_data_t
Date:   Thu, 31 Aug 2023 03:31:28 -0300
Message-ID: <20230831063129.335425-1-leobras@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call_single_data_t is a size-aligned typedef of struct __call_single_data.

This alignment is desirable in order to have smp_call_function*() avoid
bouncing an extra cacheline in case of an unaligned csd, given this
would hurt performance.

Since the removal of struct request->csd in commit 660e802c76c8
("blk-mq: use percpu csd to remote complete instead of per-rq csd") there
are no current users of smp_call_function*() with unaligned csd.

Change every 'struct __call_single_data' function parameter to
'call_single_data_t', so we have warnings if any new code tries to
introduce an smp_call_function*() call with unaligned csd.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/smp.h        |  2 +-
 include/trace/events/csd.h |  8 ++++----
 kernel/smp.c               | 26 +++++++++++++-------------
 kernel/up.c                |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 91ea4a67f8ca..e87520dc2959 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
+int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
index 67e9d01f80c2..58cc83b99c34 100644
--- a/include/trace/events/csd.h
+++ b/include/trace/events/csd.h
@@ -12,7 +12,7 @@ TRACE_EVENT(csd_queue_cpu,
 	TP_PROTO(const unsigned int cpu,
 		unsigned long callsite,
 		smp_call_func_t func,
-		struct __call_single_data *csd),
+		call_single_data_t *csd),
 
 	TP_ARGS(cpu, callsite, func, csd),
 
@@ -39,7 +39,7 @@ TRACE_EVENT(csd_queue_cpu,
  */
 DECLARE_EVENT_CLASS(csd_function,
 
-	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
 
 	TP_ARGS(func, csd),
 
@@ -57,12 +57,12 @@ DECLARE_EVENT_CLASS(csd_function,
 );
 
 DEFINE_EVENT(csd_function, csd_function_entry,
-	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
 	TP_ARGS(func, csd)
 );
 
 DEFINE_EVENT(csd_function, csd_function_exit,
-	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
 	TP_ARGS(func, csd)
 );
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 8455a53465af..8c714583786b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -127,7 +127,7 @@ send_call_function_ipi_mask(struct cpumask *mask)
 }
 
 static __always_inline void
-csd_do_func(smp_call_func_t func, void *info, struct __call_single_data *csd)
+csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
 {
 	trace_csd_function_entry(func, csd);
 	func(info);
@@ -174,7 +174,7 @@ module_param(csd_lock_timeout, ulong, 0444);
 static atomic_t csd_bug_count = ATOMIC_INIT(0);
 
 /* Record current CSD work for current CPU, NULL to erase. */
-static void __csd_lock_record(struct __call_single_data *csd)
+static void __csd_lock_record(call_single_data_t *csd)
 {
 	if (!csd) {
 		smp_mb(); /* NULL cur_csd after unlock. */
@@ -189,13 +189,13 @@ static void __csd_lock_record(struct __call_single_data *csd)
 		  /* Or before unlock, as the case may be. */
 }
 
-static __always_inline void csd_lock_record(struct __call_single_data *csd)
+static __always_inline void csd_lock_record(call_single_data_t *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled))
 		__csd_lock_record(csd);
 }
 
-static int csd_lock_wait_getcpu(struct __call_single_data *csd)
+static int csd_lock_wait_getcpu(call_single_data_t *csd)
 {
 	unsigned int csd_type;
 
@@ -210,7 +210,7 @@ static int csd_lock_wait_getcpu(struct __call_single_data *csd)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
 {
 	int cpu = -1;
 	int cpux;
@@ -276,7 +276,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
  * previous function call. For multi-cpu calls its even more interesting
  * as we'll have to ensure no other cpu is observing our csd.
  */
-static void __csd_lock_wait(struct __call_single_data *csd)
+static void __csd_lock_wait(call_single_data_t *csd)
 {
 	int bug_id = 0;
 	u64 ts0, ts1;
@@ -290,7 +290,7 @@ static void __csd_lock_wait(struct __call_single_data *csd)
 	smp_acquire__after_ctrl_dep();
 }
 
-static __always_inline void csd_lock_wait(struct __call_single_data *csd)
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled)) {
 		__csd_lock_wait(csd);
@@ -300,17 +300,17 @@ static __always_inline void csd_lock_wait(struct __call_single_data *csd)
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #else
-static void csd_lock_record(struct __call_single_data *csd)
+static void csd_lock_record(call_single_data_t *csd)
 {
 }
 
-static __always_inline void csd_lock_wait(struct __call_single_data *csd)
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #endif
 
-static __always_inline void csd_lock(struct __call_single_data *csd)
+static __always_inline void csd_lock(call_single_data_t *csd)
 {
 	csd_lock_wait(csd);
 	csd->node.u_flags |= CSD_FLAG_LOCK;
@@ -323,7 +323,7 @@ static __always_inline void csd_lock(struct __call_single_data *csd)
 	smp_wmb();
 }
 
-static __always_inline void csd_unlock(struct __call_single_data *csd)
+static __always_inline void csd_unlock(call_single_data_t *csd)
 {
 	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
 
@@ -376,7 +376,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
  */
-static int generic_exec_single(int cpu, struct __call_single_data *csd)
+static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
@@ -667,7 +667,7 @@ EXPORT_SYMBOL(smp_call_function_single);
  *
  * Return: %0 on success or negative errno value on error
  */
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	int err = 0;
 
diff --git a/kernel/up.c b/kernel/up.c
index a38b8b095251..df50828cc2f0 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	unsigned long flags;
 
-- 
2.42.0

