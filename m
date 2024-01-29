Return-Path: <linux-kernel+bounces-42615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B78403D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A171C22BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C860241;
	Mon, 29 Jan 2024 11:28:57 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A005FEF9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527736; cv=none; b=HwnwCzzP6RCOdkpEnMBSDQkAcdy1mGr0JoebnKOHsN6j3XYTkmfdm8d3QFS1fds/P/LJ1sphj9CkwYccNpSBZ73LRaWy6qnuhiYn42CqrwSf1ohOYds/AgnQ4bVjQDxPVYSZlwO+7gh8Rw2wiFfnEFTTT2JQqcBzXGKkkK/pD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527736; c=relaxed/simple;
	bh=SI/uKxzS8VQ4/JvIfm7PqZ1opzWLrFvAnZI93dLX+Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHaKbkYwBqBhpQkh9kbFOPkJ+GaO/Y4ok81MJblmQYO/T8FWhefd3tfhcPvDUXhwC+Ah26f7JAZd1NpA5bsgU47pKhVWHbX/PnUdfSB8K1UgaOVm1et65KCrjFWn/jaePEfWU6A+Ur5uCtIIKsXgHtFvvJzHzKFo8/MQZQqI6i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40TBSpoX098267;
	Mon, 29 Jan 2024 20:28:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 29 Jan 2024 20:28:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40TBSpWb098262
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 29 Jan 2024 20:28:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <afb57c55-5fd0-4f79-9653-67ef0c1e341e@I-love.SAKURA.ne.jp>
Date: Mon, 29 Jan 2024 20:28:50 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Content-Language: en-US
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>,
        eadavis@qq.com, Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <tencent_4A66EF6ACD6878526F542C2D6D109794E80A@qq.com>
 <20240129044824.1218-1-hdanton@sina.com>
 <20240129104753.1328-1-hdanton@sina.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240129104753.1328-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/29 19:47, Hillf Danton wrote:
> On Mon, 29 Jan 2024 14:53:20 +0900 Tetsuo Handa wrote:
>> On 2024/01/29 13:48, Hillf Danton wrote:
>>>> 3 locks held by kworker/1:2/779:
>>>>  #0: ffff8880b993ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
>>>>  #1: ffffc900038c7d80 ((work_completion)(&aux->work)#2){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>>>>  #2: ffff888052984c80 (&aux->poke_mutex){+.+.}-{3:3}, at: __fd_array_map_delete_elem+0x125/0x2f0 kernel/bpf/arraymap.c:884
>>>
>>> Could locking people shed any light on the failure of detecting the
>>> poke_mutex with rq lock held?
>>>
>>
>> Showing held locks (lockdep_print_held_locks()) is not a snapshot.
>> Synchronous printk() can make #0 already released by the moment #2 is taken.
>>
>> Please consult printk() people for possibility of making printk() from
>> lockdep reports (and/or hung task reports) asynchronous.
> 
> If printk did its work well then we have difficulty explaining why RCU
> stalled more than two minutes.
> 

The report you are talking about is https://syzkaller.appspot.com/x/report.txt?x=14300d80180000 .

It says

INFO: task kworker/u5:2:5062 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc1-syzkaller-g8a696a29c690-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u5:2    state:D stack:27840 pid:5062  tgid:5062  ppid:2      flags:0x00004000
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
 hci_abort_conn_sync+0x7f8/0xb70 net/bluetooth/hci_sync.c:5356
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2988
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

and lockdep says kworker/u5:2/5062 was blocked at

5 locks held by kworker/u5:2/5062:
 #0: ffff88802271a938 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900041cfd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888019ff1060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff888019ff0078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289

and ffffffff8ef23348 was held by kworker/u5:0/51.

6 locks held by kworker/u5:0/51:
 #0: ffff88802a730d38 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90000bc7d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888020989060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff888020988078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
 #5: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #5: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995

Since RCU reader side is not permitted to sleep, kworker/u5:0/51 should have released ffffffff8ef23348 shortly.

But the thread who was blocking ffffffff8d1b83f8 is not reported (presumably one of threads that are reported as
"X lock[s] held by Y" without stack trace), we can't know what the thread blocking ffffffff8d1b83f8 was doing.

Showing all backtraces of threads (including TASK_RUNNING state) could explain.

So, your question will be "Lockdep developers, can we please make it possible to report all backtraces of
threads which are holding at least one lock, tolerating increasing possibility of UAF when trying to report
locks held?" Although Linus does not like, maybe we need to tune hung task report using a kernel config option.


