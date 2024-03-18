Return-Path: <linux-kernel+bounces-105653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5129F87E218
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BA528120C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A71DFC4;
	Mon, 18 Mar 2024 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhmNKF/j"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BB1CFA9;
	Mon, 18 Mar 2024 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710728413; cv=none; b=s0rCsQhLOIwxpE6dcJ5gTZDULArgpWm3OEnPVIMm9Q2PqddLo7qC8zSC3aVCOTkKLMuPbT2Qsg0uIRUH/2hH/JG4IyyBVQjfoCSF36+ZQ5p78cU2k/dzE6XDRoADVcbyzZI+uOrRYl/Sq7GhO88OPQ+ty23DkhBpRM8tqhqjKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710728413; c=relaxed/simple;
	bh=vCXu/AhuxP5gJhjg4AHVVhvR88mode4y7TG/QExfcdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgg/9OufVmjAmCiVq+FrCVya96ftrCf4b7i3PeHcstH13cAvcnbKeQMYuKr+L/eQKdC2mIQS836XHXYIx4eAPx5tzyTe/mxG0H0MV2pqphfBSBk3LcxG74HPBL3vI5BTKYzZQ2FNVR8ULUnA7icf0Fqo2YPLtCPngXHSldFuI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhmNKF/j; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0189323b4so4326375ad.1;
        Sun, 17 Mar 2024 19:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710728411; x=1711333211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L3xuu5CGxtuUhsF5/rYkAo0s28e9wHynbV8dfQ8L3j4=;
        b=jhmNKF/jDnQQbpWo0AhTIly2r2C+R7iBeyr1hn938bZhNsTTUSBhOeCTgwP0Cs5fO6
         aii0DmirGQ/sG6nnCpGmQE6v3s4Ih6Y8Z3GLYCqW9j+pQOYKUXdiOAOydyWn8NpwuuH1
         1WnFQChTnCRu2N5h4hculbzh90V11/7tfeF9DeA17RRN4FexE7yDFPJZdWHoPHwzGzDU
         MQ5cTDk2FDwObH93sAhU8nubmtR866FPaiZ8yCix3zhEbNv2JLtjrsfFuD28viQRcVQ8
         RzzRSDQDOEc+Gn5VnDrlIIdvHXVcYqtUceQzVBQ1H4jQiL6pYsetJ+PLDhLjg32ZDgg/
         mLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710728411; x=1711333211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3xuu5CGxtuUhsF5/rYkAo0s28e9wHynbV8dfQ8L3j4=;
        b=lxtzXRta0BwlUQCiq+gPbkrIn8mLMMbAqO9LA4RPHV+LHzRm2LN9/xRLqTGogE7cHb
         pNEfM4kN31Yenjv+Pjwnuc2PYgXBm7l1BHs/6YUcNHkZu3FN34Sa8C6yiTlC/56rU1gu
         TXI0OmNm+P7Y8RZBjdklgqJ04Zg9QqGGV2f+D+ZiRldPWqCum3ghlQSLNlg0Npbnf2s/
         wOUqj97G30/R4+EVB+5IgIpzupiEXuVCh12OHWpOWm3+/e8wrti+xw0701K7ecGQiDdS
         g1JT2PvJ8vgGgO9cqC0jEgZAq+vLMPBr8A0ULf41PpKnBXFGPNB4k/zzxl7BBbQ+r4oe
         1QFw==
X-Forwarded-Encrypted: i=1; AJvYcCXU//6+wuj8XbQsSZY4VNDGWZW+Pn+WgAUNmfyxximpJtbHVuV9Nf+J8KDwXEearnoJNnFHQi6RXKX3ow2K5SRmQnrZS7E+S/FZCsMY0r6z0UOdIssbRx1/EodOrVNiOVDx
X-Gm-Message-State: AOJu0Ywv15TJNNS9qzIwL8451bCDlD7hKtVJmx+AaeayOuNNLOGanm24
	8OcearQYQAs5Q4Ihe+/upQZRwbqlatF6i9z1WEPc+ZwHUyDuVCp3dXs0sTH/uO29ubE4q7MEm+2
	mdEphX0330CaLw59UZ13SkmOgVDaWpxP1oec=
X-Google-Smtp-Source: AGHT+IEttEd3Yqs4P+rKnQA2f0RJp0lkJaxccPIWEPDlTITC3AlJwMYmZjn8I9jVdeJeAFK/O865d1pOFy9RUV1bnkI=
X-Received: by 2002:a17:90a:6c06:b0:29c:77f9:437f with SMTP id
 x6-20020a17090a6c0600b0029c77f9437fmr7515593pjj.49.1710728410486; Sun, 17 Mar
 2024 19:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317113811.8085-1-qiang.zhang1211@gmail.com> <4ffbaa69-0d36-4a16-abc5-8aa4b37e68b8@paulmck-laptop>
In-Reply-To: <4ffbaa69-0d36-4a16-abc5-8aa4b37e68b8@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 18 Mar 2024 10:19:58 +0800
Message-ID: <CALm+0cVA6Hb7MX1q-Xz9K1no2vJQ614qBtpqcuCink=AF_LAhA@mail.gmail.com>
Subject: Re: [PATCH v2] rcutorture: Make rcutorture support print rcu-tasks gp state
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sun, Mar 17, 2024 at 07:38:11PM +0800, Zqiang wrote:
> > This commit make rcu-tasks related rcutorture test support rcu-tasks
> > gp state printing when the writer stall occurs or the at the end of
> > rcutorture test, and generate rcu_ops->get_gp_data() operation to
> > simplify the acquisition of gp state for different types of rcutorture
> > tests.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>
> Much better!!!
>
> A few questions below.  One small change left, a question on testing,
> and the possibility of a few cleanup patches if you are interested.
>
>                                                         Thanx, Paul
>
> > ---
> >
> > [   47.582683] rcu:  Start-test grace-period state: g4313 f0x0
> > [   73.780444] rcu:  End-test grace-period state: g15728 f0x0 total-gps=2854
> >
> > [   99.013921] srcu:  Start-test grace-period state: g0 f0x0
> > [  126.596727] srcu:  End-test grace-period state: g10292 f0x0 total-gps=10292
> >
> > [  175.664991] srcud:  Start-test grace-period state: g0 f0x0
> > [  195.012774] srcud:  End-test grace-period state: g7628 f0x0 total-gps=7628
> >
> > [  216.943521] tasks:  Start-test grace-period state: g8 f0x0
> > [  234.245093] tasks:  End-test grace-period state: g300 f0x0 total-gps=292
> >
> > [  267.139368] tasks-rude:  Start-test grace-period state: g8 f0x0
> > [  296.132748] tasks-rude:  End-test grace-period state: g684 f0x0 total-gps=676
> >
> > [  316.044241] tasks-tracing:  Start-test grace-period state: g8 f0x0
> > [  342.020447] tasks-tracing:  End-test grace-period state: g348 f0x0 total-gps=340
> >
> >  kernel/rcu/rcu.h        | 20 ++++++++++----------
> >  kernel/rcu/rcutorture.c | 29 +++++++++++++++++++++--------
> >  kernel/rcu/srcutree.c   |  5 +----
> >  kernel/rcu/tasks.h      | 21 +++++++++++++++++++++
> >  kernel/rcu/tree.c       | 13 +++----------
> >  5 files changed, 56 insertions(+), 32 deletions(-)
> >
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 86fce206560e..38238e595a61 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -522,12 +522,18 @@ static inline void show_rcu_tasks_gp_kthreads(void) {}
> >
> >  #ifdef CONFIG_TASKS_RCU
> >  struct task_struct *get_rcu_tasks_gp_kthread(void);
> > +void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq);
> >  #endif // # ifdef CONFIG_TASKS_RCU
> >
> >  #ifdef CONFIG_TASKS_RUDE_RCU
> >  struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
> > +void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq);
> >  #endif // # ifdef CONFIG_TASKS_RUDE_RCU
> >
> > +#ifdef CONFIG_TASKS_TRACE_RCU
> > +void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
> > +#endif
> > +
>
> If you have not already done so, could you please test with the rcutorture
> scenarios, while artificially forcing that warning to trigger?

I used the following command to force writer stall:

insmod rcutorture.ko torture_type=rcu* fwd_progress=0 stat_interval=4
stall_cpu_block=1 stall_cpu=40 stall_cpu_holdoff=10

tasks_trace:
[52392.689229] ??? Writer stall state RTWS_SYNC(21) g447101 f0x0
->state 0x2 cpu 2
[52392.689235] rcu_tasks_trace: RTGS_WAIT_SCAN_HOLDOUTS(6) since 8
g:447101 i:0/26562 kCuU l:1 N1 h:44/225560/436368

tasks_rude:
[52614.705062] ??? Writer stall state RTWS_SYNC(21) g261 f0x0 ->state 0x2 cpu 2
[52614.705067] rcu_tasks_rude: RTGS_WAIT_GP(2) since 13807 g:261
i:0/261 kCuU l:250

tasks:
[52751.857305] ??? Writer stall state RTWS_EXP_SYNC(4) g149 f0x0
->state 0x2 cpu 2
[52751.858163] rcu_tasks: RTGS_WAIT_SCAN_HOLDOUTS(6) since 57 g:149
i:0/0 kCuU l:250

rcu:
??? Writer stall state RTWS_POLL_WAIT_EXP_FULL(20) g952633 f0x0
->state 0x402 cpu 2
[52826.481118] task:rcu_torture_wri state:I stack:0 pid:8655 tgid:8655
ppid:2 flags:0x00004000
rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x402
->rt_priority 1 delta ->gp_start 6093 ->gp_activity 0
->gp_req_activity 6093 ->gp_wake_time 6093 ->gp_wake_seq 952629
->gp_s0
[52826.481462] rcu: rcu_node 0:3 ->gp_seq 952633 ->gp_seq_needed
952640 ->qsmask 0x0 b.EG ->n_boosts 2328
[52826.481466] rcu: cpu 0 ->gp_seq_needed 952640
[52826.481469] rcu: cpu 1 ->gp_seq_needed 952640
[52826.481472] rcu: cpu 2 ->gp_seq_needed 952636
[52826.481474] rcu: cpu 3 ->gp_seq_needed 952640
[52826.481477] rcu: RCU callbacks invoked since boot: 127957840
[52826.481481] rcu_tasks: RTGS_WAIT_CBS(11) since 30792 g:268 i:0/0 k.u. l:250
[52826.481486] rcu_tasks_rude: RTGS_WAIT_CBS(11) since 164976 g:680
i:0/677 k.u. l:250
[52826.481492] rcu_tasks_trace: RTGS_WAIT_CBS(11) since 395536
g:447148 i:0/26567 k.u. l:1 N0 h:44/225572/436420

srcu:
rcu: srcu-torture: Tree SRCU g3586 state 0 (SRCU_SIZE_SMALL)
per-CPU(idx=1): 0(16,6 C) 1(2,-12 .) 2(-11,7 .) 3(-6,-1 .) T(1,0)
[52940.785131] ??? Writer stall state RTWS_EXP_SYNC(4) g3586 f0x0
->state 0x2 cpu 0
[52940.785136] task:rcu_torture_wri state:D stack:0 pid:8748 tgid:8748
ppid:2 flags:0x00004000


>
> For example, CONFIG_TASKS_TRACE_RCU can be tested using this command
> line:
>
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5m --configs "TRACE01 TRACE02" --trust-make
>
> You can add more scenarios to the --configs argument, and the rest of
> them can be found in tools/testing/selftests/rcutorture/configs/rcu.
>
> >  #ifdef CONFIG_TASKS_RCU_GENERIC
> >  void tasks_cblist_init_generic(void);
> >  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> > @@ -557,8 +563,7 @@ static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
> >  #endif
> >
> >  #if defined(CONFIG_TREE_RCU)
> > -void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > -                         unsigned long *gp_seq);
> > +void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq);
> >  void do_trace_rcu_torture_read(const char *rcutorturename,
> >                              struct rcu_head *rhp,
> >                              unsigned long secs,
> > @@ -566,8 +571,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
> >                              unsigned long c);
> >  void rcu_gp_set_torture_wait(int duration);
> >  #else
> > -static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
> > -                                       int *flags, unsigned long *gp_seq)
> > +static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
> >  {
> >       *flags = 0;
> >       *gp_seq = 0;
> > @@ -587,20 +591,16 @@ static inline void rcu_gp_set_torture_wait(int duration) { }
> >
> >  #ifdef CONFIG_TINY_SRCU
> >
> > -static inline void srcutorture_get_gp_data(enum rcutorture_type test_type,
> > -                                        struct srcu_struct *sp, int *flags,
> > +static inline void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
> >                                          unsigned long *gp_seq)
> >  {
> > -     if (test_type != SRCU_FLAVOR)
> > -             return;
> >       *flags = 0;
> >       *gp_seq = sp->srcu_idx;
> >  }
> >
> >  #elif defined(CONFIG_TREE_SRCU)
> >
> > -void srcutorture_get_gp_data(enum rcutorture_type test_type,
> > -                          struct srcu_struct *sp, int *flags,
> > +void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
> >                            unsigned long *gp_seq);
> >
> >  #endif
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 2f43d31fb7a5..2e8a037072eb 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -381,6 +381,7 @@ struct rcu_torture_ops {
> >       void (*gp_kthread_dbg)(void);
> >       bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
> >       int (*stall_dur)(void);
> > +     void (*get_gp_data)(int *flags, unsigned long *gp_seq);
> >       long cbflood_max;
> >       int irq_capable;
> >       int can_boost;
> > @@ -569,6 +570,7 @@ static struct rcu_torture_ops rcu_ops = {
> >       .gp_kthread_dbg         = show_rcu_gp_kthreads,
> >       .check_boost_failed     = rcu_check_boost_fail,
> >       .stall_dur              = rcu_jiffies_till_stall_check,
> > +     .get_gp_data            = rcutorture_get_gp_data,
> >       .irq_capable            = 1,
> >       .can_boost              = IS_ENABLED(CONFIG_RCU_BOOST),
> >       .extendables            = RCUTORTURE_MAX_EXTEND,
> > @@ -612,6 +614,7 @@ static struct rcu_torture_ops rcu_busted_ops = {
> >       .sync           = synchronize_rcu_busted,
> >       .exp_sync       = synchronize_rcu_busted,
> >       .call           = call_rcu_busted,
> > +     .get_gp_data    = NULL,
>
> When this is NULL, please just leave it out.
>
> If you wish, you can also send separate patches removing the pre-existing
> initialization of function pointers to NULL, one per function pointer.

I will record it in my todo document.

Thanks


>
> >       .cb_barrier     = NULL,
> >       .fqs            = NULL,
> >       .stats          = NULL,
> > @@ -628,6 +631,11 @@ static struct srcu_struct srcu_ctld;
> >  static struct srcu_struct *srcu_ctlp = &srcu_ctl;
> >  static struct rcu_torture_ops srcud_ops;
> >
> > +static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
> > +{
> > +     srcutorture_get_gp_data(srcu_ctlp, flags, gp_seq);
> > +}
> > +
> >  static int srcu_torture_read_lock(void)
> >  {
> >       if (cur_ops == &srcud_ops)
> > @@ -736,6 +744,7 @@ static struct rcu_torture_ops srcu_ops = {
> >       .call           = srcu_torture_call,
> >       .cb_barrier     = srcu_torture_barrier,
> >       .stats          = srcu_torture_stats,
> > +     .get_gp_data    = srcu_get_gp_data,
> >       .cbflood_max    = 50000,
> >       .irq_capable    = 1,
> >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > @@ -774,6 +783,7 @@ static struct rcu_torture_ops srcud_ops = {
> >       .call           = srcu_torture_call,
> >       .cb_barrier     = srcu_torture_barrier,
> >       .stats          = srcu_torture_stats,
> > +     .get_gp_data    = srcu_get_gp_data,
> >       .cbflood_max    = 50000,
> >       .irq_capable    = 1,
> >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > @@ -796,6 +806,7 @@ static struct rcu_torture_ops busted_srcud_ops = {
> >       .call           = srcu_torture_call,
> >       .cb_barrier     = srcu_torture_barrier,
> >       .stats          = srcu_torture_stats,
> > +     .get_gp_data    = NULL,
> >       .irq_capable    = 1,
> >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> >       .extendables    = RCUTORTURE_MAX_EXTEND,
> > @@ -838,6 +849,7 @@ static struct rcu_torture_ops trivial_ops = {
> >       .get_gp_seq     = rcu_no_completed,
> >       .sync           = synchronize_rcu_trivial,
> >       .exp_sync       = synchronize_rcu_trivial,
> > +     .get_gp_data    = NULL,
> >       .fqs            = NULL,
> >       .stats          = NULL,
> >       .irq_capable    = 1,
> > @@ -882,6 +894,7 @@ static struct rcu_torture_ops tasks_ops = {
> >       .call           = call_rcu_tasks,
> >       .cb_barrier     = rcu_barrier_tasks,
> >       .gp_kthread_dbg = show_rcu_tasks_classic_gp_kthread,
> > +     .get_gp_data    = rcu_tasks_get_gp_data,
> >       .fqs            = NULL,
> >       .stats          = NULL,
> >       .irq_capable    = 1,
> > @@ -922,6 +935,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
> >       .call           = call_rcu_tasks_rude,
> >       .cb_barrier     = rcu_barrier_tasks_rude,
> >       .gp_kthread_dbg = show_rcu_tasks_rude_gp_kthread,
> > +     .get_gp_data    = rcu_tasks_rude_get_gp_data,
> >       .cbflood_max    = 50000,
> >       .fqs            = NULL,
> >       .stats          = NULL,
> > @@ -974,6 +988,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
> >       .call           = call_rcu_tasks_trace,
> >       .cb_barrier     = rcu_barrier_tasks_trace,
> >       .gp_kthread_dbg = show_rcu_tasks_trace_gp_kthread,
> > +     .get_gp_data    = rcu_tasks_trace_get_gp_data,
> >       .cbflood_max    = 50000,
> >       .fqs            = NULL,
> >       .stats          = NULL,
> > @@ -2264,10 +2279,8 @@ rcu_torture_stats_print(void)
> >               int __maybe_unused flags = 0;
> >               unsigned long __maybe_unused gp_seq = 0;
> >
> > -             rcutorture_get_gp_data(cur_ops->ttype,
> > -                                    &flags, &gp_seq);
> > -             srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
> > -                                     &flags, &gp_seq);
> > +             if (cur_ops->get_gp_data)
> > +                     cur_ops->get_gp_data(&flags, &gp_seq);
> >               wtp = READ_ONCE(writer_task);
> >               pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
> >                        rcu_torture_writer_state_getname(),
> > @@ -3390,8 +3403,8 @@ rcu_torture_cleanup(void)
> >               fakewriter_tasks = NULL;
> >       }
> >
> > -     rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> > -     srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> > +     if (cur_ops->get_gp_data)
> > +             cur_ops->get_gp_data(&flags, &gp_seq);
> >       pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
> >                cur_ops->name, (long)gp_seq, flags,
> >                rcutorture_seq_diff(gp_seq, start_gp_seq));
> > @@ -3762,8 +3775,8 @@ rcu_torture_init(void)
> >                       nrealreaders = 1;
> >       }
> >       rcu_torture_print_module_parms(cur_ops, "Start of test");
> > -     rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> > -     srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> > +     if (cur_ops->get_gp_data)
> > +             cur_ops->get_gp_data(&flags, &gp_seq);
> >       start_gp_seq = gp_seq;
> >       pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
> >                cur_ops->name, (long)gp_seq, flags);
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index d19326486edd..98f79ba01b0a 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1828,12 +1828,9 @@ static void process_srcu(struct work_struct *work)
> >       srcu_reschedule(ssp, curdelay);
> >  }
> >
> > -void srcutorture_get_gp_data(enum rcutorture_type test_type,
> > -                          struct srcu_struct *ssp, int *flags,
> > +void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
> >                            unsigned long *gp_seq)
> >  {
> > -     if (test_type != SRCU_FLAVOR)
> > -             return;
> >       *flags = 0;
> >       *gp_seq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
> >  }
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index e83adcdb49b5..e7ac9138a4fd 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1182,6 +1182,13 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
> >  }
> >  EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
> >
> > +void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq)
> > +{
> > +     *flags = 0;
> > +     *gp_seq = rcu_seq_current(&rcu_tasks.tasks_gp_seq);
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_tasks_get_gp_data);
> > +
> >  /*
> >   * Protect against tasklist scan blind spot while the task is exiting and
> >   * may be removed from the tasklist.  Do this by adding the task to yet
> > @@ -1361,6 +1368,13 @@ struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
> >  }
> >  EXPORT_SYMBOL_GPL(get_rcu_tasks_rude_gp_kthread);
> >
> > +void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq)
> > +{
> > +     *flags = 0;
> > +     *gp_seq = rcu_seq_current(&rcu_tasks_rude.tasks_gp_seq);
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
> > +
> >  #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
> >
> >  ////////////////////////////////////////////////////////////////////////
> > @@ -2020,6 +2034,13 @@ struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
> >  }
> >  EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
> >
> > +void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq)
> > +{
> > +     *flags = 0;
> > +     *gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_tasks_trace_get_gp_data);
> > +
> >  #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
> >  static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
> >  #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9fbb5ab57c84..e229a12afe31 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -539,17 +539,10 @@ static struct rcu_node *rcu_get_root(void)
> >  /*
> >   * Send along grace-period-related data for rcutorture diagnostics.
> >   */
> > -void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > -                         unsigned long *gp_seq)
> > +void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
> >  {
> > -     switch (test_type) {
> > -     case RCU_FLAVOR:
> > -             *flags = READ_ONCE(rcu_state.gp_flags);
> > -             *gp_seq = rcu_seq_current(&rcu_state.gp_seq);
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > +     *flags = READ_ONCE(rcu_state.gp_flags);
> > +     *gp_seq = rcu_seq_current(&rcu_state.gp_seq);
> >  }
> >  EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
> >
> > --
> > 2.17.1
> >

