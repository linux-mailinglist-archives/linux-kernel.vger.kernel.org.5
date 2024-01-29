Return-Path: <linux-kernel+bounces-43463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EB084143A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E1D28576B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF67976053;
	Mon, 29 Jan 2024 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfX2rep5"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290137604C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559975; cv=none; b=A8jYa+BQNYWOWKEoOR5T2EXDI/QhpHXeVdiwxzpumTGamuN9g2PGufBKQjsT6XaPDglG/7ByT/Y4xb3f1dKDu0pFgLRSrO+BX1LsBXiNn1ccc95nYswvsCyF/H6myzj/LjMMuXpR+Nap1ZV+qc5Dp7TwJh7d/5j18t6+cRmw8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559975; c=relaxed/simple;
	bh=9TJp8g/iWr7w2JvuorX4Z7eMh9LLyf7oT/4nvjZTxRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFYRQS5Jlm+2HOszUfQmT/Lv1kL4oPmc1QnHb1FH2iUx48w8VAghuaFEjIo0aLBN7qQoCvh5NMBNJ4mNTeddyyByGf1JPxcaoOqMdmZi4caqvAfzntioYAJvFFkUl8XljU51G0kT/v+cA5bqeq0QraH3FqM/e+IuE2uUVp6evTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfX2rep5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783def87c8cso208056385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706559973; x=1707164773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtiUeD20KsaA1+4Udk2yfayX12MpqAns/2BoC1L++Ug=;
        b=NfX2rep540pnBLSSb+Q7BVCPejhL+QXfocSTTP8hsmJwzLE54t1EeqR/L5RCJrpjwm
         zKJk54BjUOYkgJCeaPYK3jBGNhu+/neCspB9YeZRenfJzHR+oV5leVSQy4t8EVj7JxYx
         Z7zpWKKDCfqrrjSzF46FtpyBLe/8N24/5IDwMrzy/gMi+GnNBktWeDGof4qc0ojFoyCY
         0qCxNcyyEYCC+T01l4RyuW+u0ZGfiLAEm7yn1VDrjWqOoRmkIQshZhg4C7EjpqTwXWpw
         kwbOLcPOlGaqDJe7SMKzgpEEOnDiER0FGDjy6Rxwvs/iUp0vxno96/9yBBJ9uOnvdBUA
         ZHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706559973; x=1707164773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtiUeD20KsaA1+4Udk2yfayX12MpqAns/2BoC1L++Ug=;
        b=vRCx3u7xEPgehmjhBG/IOOLhFzEmDrochhm6i0EI8yY0AX/VWDUOFnvXsFqNvT9BZJ
         Qk//h5Nzhsl6wq0WqvHvIJXNSE6/olkcWY/fFp5vRFOolNyZff2vC1zfHrIeCEPIQbvi
         Xt4WRMF+l9w3XQxRLnt12YgrhBfJOXrI67NNVSed4ASljlmozBqEf9g+F6YUl07cRIp5
         AZ/6K7nKkced1byjrG3W4+rLPk1k1XMBBT7Rbg99wVucyEXwNPagLqhicUmOauYDYyvZ
         AT67uowaEWQs/h7WCkuWjZlFkto9sad6GRzWXWqUX13UnKXhUwk9gCBp4MiE1czggXqn
         QBcw==
X-Gm-Message-State: AOJu0YwNl4wEUTbU0xXQSoR35ykOg9nr2aZ04c18Dlkir0PEXapmazG7
	3NCRt+F/xFEcMT0oUTmhYAKW1voVkktY7i4cVdQh6s5C7Kuk+tALnVfSFBW6
X-Google-Smtp-Source: AGHT+IELZu8VCDEQyS2aECn9jYwuoaIt1pNFMWM/64s2urBOgYt/u+wq+H/+K/tPqNj+SlOrwQL3Kw==
X-Received: by 2002:a05:620a:4456:b0:784:9d2:3397 with SMTP id w22-20020a05620a445600b0078409d23397mr301403qkp.56.1706559972926;
        Mon, 29 Jan 2024 12:26:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVUOf5gVN7MrOXldKGWEZalJWiQCO1TDhBODS03M5usje1RL7S22HugIHm3i7OxdXt/S/oDP7LRuEd1hHZhWFN3g+tuWz0GDR3COgmlsmyb6bWLTyuY2tewY2M5S4uvjIEb0XHKUNjktNo8io5DLZKijZ/cNCcXJKZZOhj/uAGiH2yM/cUouIYRl/f4D2XoEdXmcLYKHHqxSFImpGWovMJwg89kUAy9YZNtszgV9QC1b9Csl6HYmgbjf0fiubHK2yMDWvPZC4q4CQZJjBZwCCJbu4rV5G9zRj2jeMoJxR48sPIrbQDDocwe2PAtHWrEy+mKTk0iA+rrwtrxAQ==
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 22-20020a05620a04d600b00783df78821dsm2859610qks.25.2024.01.29.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:26:12 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2051C1200064;
	Mon, 29 Jan 2024 15:26:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 15:26:12 -0500
X-ME-Sender: <xms:4gm4ZeyR7R7n1LgUhjdykjUv-d7ehyBTF-r3sWgqeFvgVm0cvO6mvQ>
    <xme:4gm4ZaRFxxEnB-6fDRhyzKfG0Unz3nnzOS3nyQXYRyyQqpl2U7p3BA75HJCQKwmyE
    jc_MoNi0kDL0Xqcuw>
X-ME-Received: <xmr:4gm4ZQVX-vxiSYKfdJluG5u_ZaIw2o8nFUK9Ou0-XT-iQIy5cXi1jyMo5V8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefgvdehheeljeeiueejheffudfgfeegvdffvdeuheegkeekkeeivdek
    leevvdfhnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgv
X-ME-Proxy: <xmx:4gm4ZUj3RHR8G-ko8MB6vOzs20z6fSUZici3-Tjbv9qY1JULu3mx-A>
    <xmx:4gm4ZQC-KxpYpcWjyOMOsGGCRhnXhdAOankqS9QF7re-Wg2JqdHapw>
    <xmx:4gm4ZVKCOhp-12PyQE6FQp1xdz17p4-xmp_PxuN4_LiuxxuLgqYohw>
    <xmx:5Am4Zc0KMbacrudaU9lumHzqpxMJLLunPVPyQtUS60wF-bVYvwBN18jgNjQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 15:26:10 -0500 (EST)
Date: Mon, 29 Jan 2024 12:25:13 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Hillf Danton <hdanton@sina.com>,
	syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>,
	eadavis@qq.com, Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Message-ID: <ZbgJqc06rEZ_FqRw@boqun-archlinux>
References: <tencent_4A66EF6ACD6878526F542C2D6D109794E80A@qq.com>
 <20240129044824.1218-1-hdanton@sina.com>
 <20240129104753.1328-1-hdanton@sina.com>
 <afb57c55-5fd0-4f79-9653-67ef0c1e341e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb57c55-5fd0-4f79-9653-67ef0c1e341e@I-love.SAKURA.ne.jp>

On Mon, Jan 29, 2024 at 08:28:50PM +0900, Tetsuo Handa wrote:
> On 2024/01/29 19:47, Hillf Danton wrote:
> > On Mon, 29 Jan 2024 14:53:20 +0900 Tetsuo Handa wrote:
> >> On 2024/01/29 13:48, Hillf Danton wrote:
> >>>> 3 locks held by kworker/1:2/779:
> >>>>  #0: ffff8880b993ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
> >>>>  #1: ffffc900038c7d80 ((work_completion)(&aux->work)#2){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
> >>>>  #2: ffff888052984c80 (&aux->poke_mutex){+.+.}-{3:3}, at: __fd_array_map_delete_elem+0x125/0x2f0 kernel/bpf/arraymap.c:884
> >>>
> >>> Could locking people shed any light on the failure of detecting the
> >>> poke_mutex with rq lock held?
> >>>
> >>
> >> Showing held locks (lockdep_print_held_locks()) is not a snapshot.
> >> Synchronous printk() can make #0 already released by the moment #2 is taken.
> >>
> >> Please consult printk() people for possibility of making printk() from
> >> lockdep reports (and/or hung task reports) asynchronous.
> > 
> > If printk did its work well then we have difficulty explaining why RCU
> > stalled more than two minutes.
> > 
> 
> The report you are talking about is https://syzkaller.appspot.com/x/report.txt?x=14300d80180000 .
> 
> It says
> 
> INFO: task kworker/u5:2:5062 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc1-syzkaller-g8a696a29c690-dirty #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u5:2    state:D stack:27840 pid:5062  tgid:5062  ppid:2      flags:0x00004000
> Workqueue: hci5 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
>  hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
>  hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
>  hci_abort_conn_sync+0x7f8/0xb70 net/bluetooth/hci_sync.c:5356
>  abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2988
>  hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
>  process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
>  process_scheduled_works kernel/workqueue.c:2706 [inline]
>  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
>  kthread+0x2c6/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> 
> and lockdep says kworker/u5:2/5062 was blocked at
> 
> 5 locks held by kworker/u5:2/5062:
>  #0: ffff88802271a938 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc900041cfd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>  #2: ffff888019ff1060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
>  #3: ffff888019ff0078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
>  #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
>  #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
> 
> and ffffffff8ef23348 was held by kworker/u5:0/51.
> 
> 6 locks held by kworker/u5:0/51:
>  #0: ffff88802a730d38 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc90000bc7d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>  #2: ffff888020989060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
>  #3: ffff888020988078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
>  #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
>  #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
>  #5: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
>  #5: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
> 
> Since RCU reader side is not permitted to sleep, kworker/u5:0/51 should have released ffffffff8ef23348 shortly.
> 
> But the thread who was blocking ffffffff8d1b83f8 is not reported (presumably one of threads that are reported as
> "X lock[s] held by Y" without stack trace), we can't know what the thread blocking ffffffff8d1b83f8 was doing.
> 
> Showing all backtraces of threads (including TASK_RUNNING state) could explain.
> 
> So, your question will be "Lockdep developers, can we please make it possible to report all backtraces of
> threads which are holding at least one lock, tolerating increasing possibility of UAF when trying to report
> locks held?" Although Linus does not like, maybe we need to tune hung task report using a kernel config option.
> 

Looks to me that debug_show_all_locks() doesn't hold the lockdep lock,
so it's really a best effort race read of all tasks on lock hold
information. Maybe Hillf wants the following? (Completely untested, it
will stop your whole system and print lock holding information).

Regards,
Boqun

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..17a9392e6bd8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6611,6 +6611,8 @@ void debug_show_all_locks(void)
 	}
 	pr_warn("\nShowing all locks held in the system:\n");
 
+	local_irq_disable();
+	lockdep_lock();
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		if (!p->lockdep_depth)
@@ -6620,6 +6622,8 @@ void debug_show_all_locks(void)
 		touch_all_softlockup_watchdogs();
 	}
 	rcu_read_unlock();
+	lockdep_unlock();
+	local_irq_enable();
 
 	pr_warn("\n");
 	pr_warn("=============================================\n\n");

