Return-Path: <linux-kernel+bounces-45840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014988436E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2571F2A74A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF1E42049;
	Wed, 31 Jan 2024 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDeNfLtc"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9C38399;
	Wed, 31 Jan 2024 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706683118; cv=none; b=hc0Fdzrn9nPgdpc5IcxymhY1TNpSM5ZMIegZM9Bxclmpbl+5x3Iswa4/MRZrTtfadCjadYXs+7wEal1O43Px0zvdjMnU1+Nn8mQ/C0Weqg8nCfHd/pDRqHh4QYQMNW/Y/+RfCYybTk22L+DtC6mcdgXHpU/E3jqi02CaoqoTKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706683118; c=relaxed/simple;
	bh=7KDFAU8s2wR4bPsMZzaeIQ/0mGhrd+S9mSxfVVE5N+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGYWh6uzGPyDA92umDTm14kmZntEE8MZZYWJ3QsoINa/5fQ0sR+N6J/VF067ixNqp+gjnlrWBeh/AqYNS7eehj1xSwiaUCXKqDFywvsKRGkOywo59byMUrN7kd/3YyC7hJMsjTPuQGrLAQYtZ8yq/Hkrrt0+tr7zH9FQeysLo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDeNfLtc; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6818f3cf00aso39259986d6.0;
        Tue, 30 Jan 2024 22:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706683115; x=1707287915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OVlHJvrK3//SACaGBCuaMdfL6VLG3Nf0f7Gh7CCmz4=;
        b=lDeNfLtcGA03NN/uyDKmMSvADNJ/dIP4UoWuJ5KgQteMSZSfkY8rgxcWVUDS+dxqaP
         fghj0GgoHSArafgOwErNDhnbUesH9X/FjUqt/AkzndY0Ace0wtoGykMLxT1tbpUifnFP
         OsvUSth+5wvv+FGj5aPgsh3UVQjV/podVcTON3OG3CAsGFSjbztdtBmoFQfLbfixWiJX
         KLxJrcJEUXvsBjQSA8+16utWcGFeBlbf6ubrFK0VPA8LXFkCnuhtnaOtrnn4+qtxyGAd
         rb0w6D/H17ODrXjFiZCqTDjwxjmCz8D+gI4SedYjz+6TCbM8gqWLDJ/fnk4Z2SITLbUP
         QQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706683115; x=1707287915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OVlHJvrK3//SACaGBCuaMdfL6VLG3Nf0f7Gh7CCmz4=;
        b=kYFMXEublu6cbM7I/+YBKML4agf8rDooiHzZ6QtQOiL8hlfFjsFcpzNVw5u2FJG54l
         b4LogX532wuqeKe3ou3P+nW80qxBk4kLTRFZFmvQITgUz4kAlGewjkU0cL8JPpynNvUg
         Qs7xNnFNG3h/EAoyirITNf8SdcT9Hpdn+UXDOTYWeEw7HSBcnKIKm7+oxYyWEl1Y4Ylz
         twET0lyZ3XAnpCuJd/4VpJJAFvycEbhQi0Kb6Owng+IfYPDGaFK/MafVqa1FZU0WBuzk
         iqMxPD+wlgh92CWstGNqhFe6VqSPpDQr9wMn6B8QgHCDAW3wcgsHdAvipfPOdfcwh8FY
         nK9w==
X-Gm-Message-State: AOJu0Yx0auSWYIuPreoV3Fcv9Jj1QbYhWArh4S05vSOGwO9YOeK3/cfG
	DzqXlBAsEwLcq2HuPx/sFPS5Qpbbd0Uuol/YiVW5bmPRKndavuDM
X-Google-Smtp-Source: AGHT+IHGR9Psh3CWFpRvhr+EIAGFiiQTn/fQ/OeNMDw28Qe/8LO7NBiE1xLguL3HEsSFEarNjcXlVQ==
X-Received: by 2002:ad4:5cc6:0:b0:68c:67a0:a194 with SMTP id iu6-20020ad45cc6000000b0068c67a0a194mr988723qvb.61.1706683114910;
        Tue, 30 Jan 2024 22:38:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX73WapufAf0vTlnVFHLt83nvLYg5YLPpOl3kfzm0IilJI/c7FdcXu7He4glPxohGaX9M6lIBZoiT4/2Yu4MnZEzkRUeO76xjcz/GUcjw+UN0TjMaNao8RWt2ch0cL0Lqa2Y7mfaMNFLy/rZsKxPpKpMLG4mGfZV4OBH10LWKl4hHGouPVcuytqmlmWqH/Lb1Xsv7MjM3ySTTXbvPBaKR0N4ZDJhqsR4eNdzV3LG+8kJ44HGeNWKEY240bJuYriiQLAXSMcBZ6drB3Oaav40spugEYhyZY8xN3BuUrRmla9q114yUKKPwH1jx6BfR+vFhMFv0vceqXYdH3YzNAzTQ1jEZ681VbW7mfun537Sx1nZkrxCVfdS0YGRIZSzDSmIpPEJis34lsMjAXK3zTicEKQxGN9bkAqNpW0KzzWK09m7O37gkAOwujJLQYBdNJmDQmXm3dYSn9uQwBT8GMuz4aio67bC4k6F7KD1DE=
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id ol5-20020a0562143d0500b006869bc1fc0esm5239092qvb.11.2024.01.30.22.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 22:38:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 7493727C005B;
	Wed, 31 Jan 2024 01:38:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 31 Jan 2024 01:38:33 -0500
X-ME-Sender: <xms:6Oq5ZV24iFMcQRxBoy4Ak_Bsgx4rTJdr0zCm-3BjSYgOZicNpOw_4w>
    <xme:6Oq5ZcEpjErj9Vr5OqGnNEdCoMKmiIAyDvrk1r5dmTPxFD7MnmsgV0ggGDsmi9fnd
    l5iCM-eITlgdjPuPA>
X-ME-Received: <xmr:6Oq5ZV6FfX6KbMAWY0AT4qEoYVIG6OH9oPnZ7uKTaM_-LRafqSftMrKsFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffjeekveekhfekudekgeeivdefhedthedvfeegleegueeviefhueeuudeh
    keektdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpsh
    ihiihkrghllhgvrhdrrghpphhsphhothdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvg
    hrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhf
    vghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:6Oq5ZS2pz1ygU3dr6Ij2NNJmmsZ2SJjJjTFbBMzqgwetXX6IFmy9Aw>
    <xmx:6Oq5ZYE6KU4rVaDcV6Qw9CWCUQCMLmp5rVOIKDhp1UdbZG6JLRf8UQ>
    <xmx:6Oq5ZT9r8J-vXGKOKPXcQ2j8AvCpBlndj3aJB5n6oIkHBdf3PaKRcg>
    <xmx:6eq5ZVeUO2aj2Xdq3_wn84cXk_zpFsSAq4s-t4JHX586AGhyhuFSyQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 01:38:31 -0500 (EST)
Date: Tue, 30 Jan 2024 22:38:30 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
Cc: eadavis@qq.com, hdanton@sina.com, linux-kernel@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>, urezki@gmail.com,
	neeraj.iitr10@gmail.com, rcu@vger.kernel.org
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Message-ID: <Zbnq5o_HJOMIIK-c@Boquns-Mac-mini.home>
References: <20240130113037.1390-1-hdanton@sina.com>
 <00000000000082e8ba06102ba5f1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000082e8ba06102ba5f1@google.com>

[Cc other RCU folks]

On Tue, Jan 30, 2024 at 07:45:06AM -0800, syzbot wrote:
> Hello,
> 

This looks like the case which Frederic recently fixed:

	https://lore.kernel.org/lkml/20240129232349.3170819-9-boqun.feng@gmail.com/

, which is currently queued in my tree for v6.9 PR:

	https://github.com/fbq/linux.git rcu-exp.2024.01.29b

can we give it a spin?

Regards,
Boqun

> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: task hung in hci_conn_failed
> 
> INFO: task kworker/u5:4:5429 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u5:4    state:D stack:27616 pid:5429  tgid:5429  ppid:2      flags:0x00004000
> Workqueue: hci0 hci_cmd_sync_work
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
>  hci_abort_conn_sync+0x758/0xb50 net/bluetooth/hci_sync.c:5356
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
> Showing all locks held in the system:
> 3 locks held by kworker/0:0/8:
> 3 locks held by kworker/0:1/9:
> 2 locks held by kworker/u4:0/11:
>  #0: ffff888013089938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc90000107d80 (connector_reaper_work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
> 2 locks held by kworker/u4:2/42:
>  #0: ffff888013089938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc90000b2fd80 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
> 1 lock held by udevd/4510:
> 2 locks held by getty/4809:
>  #0: ffff8880298450a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
>  #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
> 1 lock held by syz-executor.3/5419:
> 5 locks held by kworker/u5:4/5429:
>  #0: ffff88802d96d538 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc90009befd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>  #2: ffff888075635060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
>  #3: ffff888075634078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
>  #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
>  #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
> 6 locks held by kworker/u5:5/5431:
>  #0: ffff888027f29538 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc90009bffd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>  #2: ffff888079359060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
>  #3: ffff888079358078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
>  #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
>  #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
>  #5: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
>  #5: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
> 3 locks held by kworker/1:5/5500:
> 3 locks held by kworker/0:8/5556:
> 3 locks held by kworker/1:6/5586:
> 3 locks held by kworker/1:7/5659:
> 2 locks held by dhcpcd/20271:
>  #0: ffff88808e304130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
>  #0: ffff88808e304130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2c/0xf50 net/packet/af_packet.c:3202
>  #1: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
>  #1: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
> 1 lock held by dhcpcd/20354:
>  #0: ffff88803a7ba130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
>  #0: ffff88803a7ba130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2c/0xf50 net/packet/af_packet.c:3202
> 1 lock held by dhcpcd/20466:
>  #0: ffff88801db68130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
>  #0: ffff88801db68130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2c/0xf50 net/packet/af_packet.c:3202
> 1 lock held by dhcpcd/20585:
>  #0: ffff888094ba4130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
>  #0: ffff888094ba4130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2c/0xf50 net/packet/af_packet.c:3202
> 1 lock held by dhcpcd/20736:
>  #0: ffff88809175e130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
>  #0: ffff88809175e130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2c/0xf50 net/packet/af_packet.c:3202
> 1 lock held by syz-executor.1/21229:
> 3 locks held by syz-executor.4/21232:
> 1 lock held by syz-executor.5/21233:
> 
> =============================================
> 
> NMI backtrace for cpu 1
> CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
>  watchdog+0xf87/0x1210 kernel/hung_task.c:379
>  kthread+0x2c6/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 21255 Comm: syz-executor.0 Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:981 [inline]
> RIP: 0010:debug_check_no_obj_freed+0x21d/0x600 lib/debugobjects.c:1019
> Code: 89 64 24 38 49 bd 22 01 00 00 00 00 ad de 48 c1 ea 03 4d 89 fc 80 3c 1a 00 0f 85 dc 00 00 00 48 8d 78 18 41 83 c6 01 4c 8b 38 <48> 89 fa 48 c1 ea 03 80 3c 1a 00 0f 85 f7 02 00 00 48 8b 50 18 4c
> RSP: 0018:ffffc9007e76fc80 EFLAGS: 00000006
> RAX: ffff88809414c528 RBX: dffffc0000000000 RCX: ffffffff8168ea5e
> RDX: 1ffff110128298a5 RSI: ffff888066342100 RDI: ffff88809414c540
> RBP: ffffc9007e76fdc0 R08: 0000000000000001 R09: fffff5200fcedf7e
> R10: 0000000000000003 R11: 0000000000000000 R12: ffff888066341100
> R13: dead000000000122 R14: 0000000000000005 R15: ffff88805dc630f0
> FS:  0000555555f24480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007faacb501400 CR3: 0000000048e71000 CR4: 0000000000350ef0
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  slab_free_hook mm/slub.c:2093 [inline]
>  slab_free mm/slub.c:4299 [inline]
>  kmem_cache_free+0x255/0x350 mm/slub.c:4363
>  putname+0x12e/0x170 fs/namei.c:274
>  do_symlinkat+0x1ac/0x310 fs/namei.c:4515
>  __do_sys_symlinkat fs/namei.c:4522 [inline]
>  __se_sys_symlinkat fs/namei.c:4519 [inline]
>  __x64_sys_symlinkat+0x97/0xc0 fs/namei.c:4519
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7faacb47c527
> Code: 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0a 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd9c121f28 EFLAGS: 00000206 ORIG_RAX: 000000000000010a
> RAX: ffffffffffffffda RBX: 00007ffd9c121ff0 RCX: 00007faacb47c527
> RDX: 00007faacb4c9526 RSI: 00000000ffffff9c RDI: 00007ffd9c121ff0
> RBP: 0000000000000001 R08: 0000000000000017 R09: 00007ffd9c121c77
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
>  </TASK>
> 
> 
> Tested on:
> 
> commit:         861c0981 Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=1207db37e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
> dashboard link: https://syzkaller.appspot.com/bug?extid=a984066a63e9c1e62662
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a550d3e80000
> 

