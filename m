Return-Path: <linux-kernel+bounces-101033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2296B87A0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1EEB20EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2286B663;
	Wed, 13 Mar 2024 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YOBNuMQW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25179C5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710294514; cv=none; b=IRe5v4GbEuMEQ3bZsOAGLF6wgIqAcpxuTldV6HhkJzSZA4yGH2Xp0Vmg/fLAqMrLnj+Jj4t9GkKw70vWPRD6BMuHNyel8+dCYcb0TKp6JKBo0/+i2g4hx1bIy0nZ3w7f7GUrAcwQveUkio16jeBkb48pm1bMr0ZE3t/7epyIu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710294514; c=relaxed/simple;
	bh=c92qP+d07eBt96HVP0lkZ4RsU9g6JYwmN44tFCExclg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ioPo36oPkcMEmlXcvfEvIXos7lZ08ImfxHyUaciOy8zRgHiWSvKV9cY+MJ9AvPbR40vrVdy82b494wUxRRsEQEBTgfKFMnqbPzOFyAOkMzTjFXXQszLamyP9wDNaSYc3J/a7UtKvh6oNBtVsED14Hv3EAh05wCbak4/N9LrncNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YOBNuMQW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42D16FLe009969;
	Wed, 13 Mar 2024 01:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=lvDevJgXzZHK+XAuqd2R8EtdQOr26ZP2QO5Xtddz0KA=;
 b=YOBNuMQWKm6Sl7lJnNjiNrPMHnb6nGkjpHEY58UajnzpJZS6uarS8BOk4Ir3FTWV303s
 ACoQ2zj93BnrjLkn0bu9C22nin+fDWSvbYxLxEs8R8g0GwCBurATPdhJjh0Z+LzMKLLr
 ZtVGB7BlXZV4NCrN2eV0N4KjOUojadOOpoy0alV6z3NMXwkDnfxTrjyYrTDLT+L3rjCt
 f31U5prTAdwOe3BpGI2E3d333dha4UnGAfsJaSzjsHI72fPD8dhqNoVDs2s0kd0oKTWB
 p7fdaGIRii0cu2JL6NgFnojs2CnQ5s3vfnIpcsK33WGzK429wKHGI74weofyaZ11naS5 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wu1au127q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 01:48:11 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42D1j7Tw030279;
	Wed, 13 Mar 2024 01:48:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wu1au1267-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 01:48:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CN67Yx018134;
	Wed, 13 Mar 2024 01:41:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23tb3uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 01:41:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42D1fN1O30867824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 01:41:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7395520043;
	Wed, 13 Mar 2024 01:41:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E069920040;
	Wed, 13 Mar 2024 01:41:22 +0000 (GMT)
Received: from heavy (unknown [9.171.20.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 13 Mar 2024 01:41:22 +0000 (GMT)
Date: Wed, 13 Mar 2024 02:41:21 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Changbin Du <changbin.du@huawei.com>, elver@google.com
Cc: Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] kmsan: instrumentation recursion problems
Message-ID: <czcb6tjpfu3ry5j6blzkhw5hg2thfkir7xkxholzqqpnv5pj4f@jtdhzoif5m2q>
References: <20240308043448.masllzeqwht45d4j@M910t>
 <CANpmjNOc4Z6Qy_L3pjuW84BOxoiqXgLC1tWbJuZwRUZqs2ioMA@mail.gmail.com>
 <20240311093036.44txy57hvhevybsu@M910t>
 <20240311110223.nzsplk6a6lzxmzqi@M910t>
 <ndf5znadjpm4mcscns66bhcgvvykmcou3kjkqy54fcvgtvu7th@vpaomrytk4af>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ndf5znadjpm4mcscns66bhcgvvykmcou3kjkqy54fcvgtvu7th@vpaomrytk4af>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rn6Ph5G0Y3Tx4t5XLA2Vl-9bR-jX3YyW
X-Proofpoint-GUID: iF5gmBX_HbtGdM5hh3iUteh4JaUI99NA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130012

On Wed, Mar 13, 2024 at 12:52:33AM +0100, Ilya Leoshkevich wrote:
> On Mon, Mar 11, 2024 at 07:02:23PM +0800, Changbin Du wrote:
> > On Mon, Mar 11, 2024 at 05:30:36PM +0800, Changbin Du wrote:
> > > On Fri, Mar 08, 2024 at 10:39:15AM +0100, Marco Elver wrote:
> > > > On Fri, 8 Mar 2024 at 05:36, 'Changbin Du' via kasan-dev
> > > > <kasan-dev@googlegroups.com> wrote:
> > > > >
> > > > > Hey, folks,
> > > > > I found two instrumentation recursion issues on mainline kernel.
> > > > >
> > > > > 1. recur on preempt count.
> > > > > __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() -> preempt_disable() -> __msan_metadata_ptr_for_load_4()
> > > > >
> > > > > 2. recur in lockdep and rcu
> > > > > __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() -> pfn_valid() -> rcu_read_lock_sched() -> lock_acquire() -> rcu_is_watching() -> __msan_metadata_ptr_for_load_8()
> > > > >
> > > > >
> > > > > Here is an unofficial fix, I don't know if it will generate false reports.
> > > > >
> > > > > $ git show
> > > > > commit 7f0120b621c1cbb667822b0f7eb89f3c25868509 (HEAD -> master)
> > > > > Author: Changbin Du <changbin.du@huawei.com>
> > > > > Date:   Fri Mar 8 20:21:48 2024 +0800
> > > > >
> > > > >     kmsan: fix instrumentation recursions
> > > > >
> > > > >     Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > > > >
> > > > > diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> > > > > index 0db4093d17b8..ea925731fa40 100644
> > > > > --- a/kernel/locking/Makefile
> > > > > +++ b/kernel/locking/Makefile
> > > > > @@ -7,6 +7,7 @@ obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
> > > > >
> > > > >  # Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
> > > > >  KCSAN_SANITIZE_lockdep.o := n
> > > > > +KMSAN_SANITIZE_lockdep.o := n
> > > > 
> > > > This does not result in false positives?
> > > >
> > This does result lots of false positives.
> > 
> > > I saw a lot of reports but seems not related to this.
> > > 
> > > [    2.742743][    T0] BUG: KMSAN: uninit-value in unwind_next_frame+0x3729/0x48a0
> > > [    2.744404][    T0]  unwind_next_frame+0x3729/0x48a0
> > > [    2.745623][    T0]  arch_stack_walk+0x1d9/0x2a0
> > > [    2.746838][    T0]  stack_trace_save+0xb8/0x100
> > > [    2.747928][    T0]  set_track_prepare+0x88/0x120
> > > [    2.749095][    T0]  __alloc_object+0x602/0xbe0
> > > [    2.750200][    T0]  __create_object+0x3f/0x4e0
> > > [    2.751332][    T0]  pcpu_alloc+0x1e18/0x2b00
> > > [    2.752401][    T0]  mm_init+0x688/0xb20
> > > [    2.753436][    T0]  mm_alloc+0xf4/0x180
> > > [    2.754510][    T0]  poking_init+0x50/0x500
> > > [    2.755594][    T0]  start_kernel+0x3b0/0xbf0
> > > [    2.756724][    T0]  __pfx_reserve_bios_regions+0x0/0x10
> > > [    2.758073][    T0]  x86_64_start_kernel+0x92/0xa0
> > > [    2.759320][    T0]  secondary_startup_64_no_verify+0x176/0x17b
> > > 
> > Above reports are triggered by KMEMLEAK and KFENCE.
> > 
> > Now with below fix, I was able to run kmsan kernel with:
> >   CONFIG_DEBUG_KMEMLEAK=n
> >   CONFIG_KFENCE=n
> >   CONFIG_LOCKDEP=n
> > 
> > KMEMLEAK and KFENCE generate too many false positives in unwinding code.
> > LOCKDEP still introduces instrumenting recursions.
> 
> FWIW I see the same issue on s390, and the best I could come up with so
> far was also disabling lockdep.
> 
> For KFENCE I have the following [1] though, maybe this will be helpful
> to you as well?
> 
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20231213233605.661251-17-iii@linux.ibm.com/
> 
> [...]

So, I tried to brute force the issue and came up with the following.
The goal was to minimize the usage of __no_sanitize_memory in order to
avoid false positives. I don't propose to commit this, I'm posting this
to highlight the intermediate problems that need to be solved.



From e3834f4e4ebe2596542a7464f8cc487e2c8e37c9 Mon Sep 17 00:00:00 2001
From: Ilya Leoshkevich <iii@linux.ibm.com>
Date: Wed, 13 Mar 2024 01:18:22 +0100
Subject: [PATCH] s390/kmsan: Fix lockdep recursion

After commit 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
memory_section->usage"), an infinite mutual recursion between
kmsan_get_metadata() and lock_acquire() arose.

Teach lockdep recursion detection to handle it. The goal is to make
lock_acquire() survive until lockdep_recursion_inc(). This requires
solving a number of intermediate problems:

0. Disable KMSAN checks in lock_acquire().

1. lock_acquire() calls instrumented trace_lock_acquire().
   Force inlining.

2. trace_lock_acquire() calls instrumented cpu_online().
   Force inlining.

3: trace_lock_acquire() calls instrumented rcu_is_watching(), which in
   turn calls instrumented __preempt_count_add().
   Disable instrumentation in rcu_is_watching().
   Disabling checks is not enough, because __preempt_count_add() would
   call __msan_instrument_asm_store().
   Force inlinining of __preempt_count_add().

4: lock_acquire() inlines lockdep_enabled(), which inlines
   __preempt_count_add(), which calls __msan_instrument_asm_store().
   Don't inline lockdep_enabled() and disable KMSAN instrumentation in it.

5: lock_acquire() calls check_flags(), which calls the instrumented
   preempt_count().
   Always inline preempt_count().

6: lock_acquire() inlines lockdep_recursion_inc(), which needs to
   update KMSAN metadata.
   Do not inline lockdep_recursion_inc(), disable KMSAN instrumentation
   in it.

7: lock_acquire() calls instrumented lockdep_nmi().
   Force inlining.

With that, the KMSAN+lockdep kernel boots again, but unfortunately it
is very slow.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/preempt.h | 12 ++++++------
 include/linux/cpumask.h         |  2 +-
 include/linux/tracepoint.h      |  2 +-
 kernel/locking/lockdep.c        | 10 +++++++---
 kernel/rcu/tree.c               |  1 +
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index bf15da0fedbc..225ce14bb0d6 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -12,7 +12,7 @@
 #define PREEMPT_NEED_RESCHED	0x80000000
 #define PREEMPT_ENABLED	(0 + PREEMPT_NEED_RESCHED)
 
-static inline int preempt_count(void)
+static __always_inline int preempt_count(void)
 {
 	return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
 }
@@ -44,7 +44,7 @@ static inline bool test_preempt_need_resched(void)
 	return !(READ_ONCE(S390_lowcore.preempt_count) & PREEMPT_NEED_RESCHED);
 }
 
-static inline void __preempt_count_add(int val)
+static __always_inline void __preempt_count_add(int val)
 {
 	/*
 	 * With some obscure config options and CONFIG_PROFILE_ALL_BRANCHES
@@ -59,7 +59,7 @@ static inline void __preempt_count_add(int val)
 	__atomic_add(val, &S390_lowcore.preempt_count);
 }
 
-static inline void __preempt_count_sub(int val)
+static __always_inline void __preempt_count_sub(int val)
 {
 	__preempt_count_add(-val);
 }
@@ -79,7 +79,7 @@ static inline bool should_resched(int preempt_offset)
 
 #define PREEMPT_ENABLED	(0)
 
-static inline int preempt_count(void)
+static __always_inline int preempt_count(void)
 {
 	return READ_ONCE(S390_lowcore.preempt_count);
 }
@@ -102,12 +102,12 @@ static inline bool test_preempt_need_resched(void)
 	return false;
 }
 
-static inline void __preempt_count_add(int val)
+static __always_inline void __preempt_count_add(int val)
 {
 	S390_lowcore.preempt_count += val;
 }
 
-static inline void __preempt_count_sub(int val)
+static __always_inline void __preempt_count_sub(int val)
 {
 	S390_lowcore.preempt_count -= val;
 }
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..af6515e5def8 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1099,7 +1099,7 @@ static __always_inline unsigned int num_online_cpus(void)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
 
-static inline bool cpu_online(unsigned int cpu)
+static __always_inline bool cpu_online(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_online_mask);
 }
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 88c0ba623ee6..34bc35aa2f4b 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -252,7 +252,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
-	static inline void trace_##name(proto)				\
+	static __always_inline void trace_##name(proto)			\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..86244a7e8533 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -111,7 +111,8 @@ late_initcall(kernel_lockdep_sysctls_init);
 DEFINE_PER_CPU(unsigned int, lockdep_recursion);
 EXPORT_PER_CPU_SYMBOL_GPL(lockdep_recursion);
 
-static __always_inline bool lockdep_enabled(void)
+__no_sanitize_memory
+static noinline bool lockdep_enabled(void)
 {
 	if (!debug_locks)
 		return false;
@@ -457,7 +458,8 @@ void lockdep_init_task(struct task_struct *task)
 	task->lockdep_recursion = 0;
 }
 
-static __always_inline void lockdep_recursion_inc(void)
+__no_sanitize_memory
+static noinline void lockdep_recursion_inc(void)
 {
 	__this_cpu_inc(lockdep_recursion);
 }
@@ -5687,7 +5689,7 @@ static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock
 #endif
 }
 
-static bool lockdep_nmi(void)
+static __always_inline bool lockdep_nmi(void)
 {
 	if (raw_cpu_read(lockdep_recursion))
 		return false;
@@ -5716,6 +5718,7 @@ EXPORT_SYMBOL_GPL(read_lock_is_recursive);
  * We are not always called with irqs disabled - do that here,
  * and also avoid lockdep recursion:
  */
+__no_kmsan_checks
 void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 			  int trylock, int read, int check,
 			  struct lockdep_map *nest_lock, unsigned long ip)
@@ -5758,6 +5761,7 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 }
 EXPORT_SYMBOL_GPL(lock_acquire);
 
+__no_kmsan_checks
 void lock_release(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d9642dd06c25..8c587627618e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -692,6 +692,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
  * Make notrace because it can be called by the internal functions of
  * ftrace, and making this notrace removes unnecessary recursion calls.
  */
+__no_sanitize_memory
 notrace bool rcu_is_watching(void)
 {
 	bool ret;
-- 
2.44.0


