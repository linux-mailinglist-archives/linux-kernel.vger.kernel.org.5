Return-Path: <linux-kernel+bounces-100766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E6879CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33D21C21288
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AC414291E;
	Tue, 12 Mar 2024 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbPplueR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67860382;
	Tue, 12 Mar 2024 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275669; cv=none; b=H4RXtGG0Cwdr+0h0JexB7v1WD7wN/rzgv45qoC981T1e9FYXhSV0Uy33qdVvyqg2rHeUt60haffAnD5hNXEfayVT8iHbQUGA8JGYd6tLJfBxt9QRYHjuw0+ulUl9y9Jq8tJT6clVXni3u/hae3GW0fR5/9gpQfQE/e06dDHhwX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275669; c=relaxed/simple;
	bh=R1f2Z6Q3RDe933FrVGM57J3eRx3hBGmWcguswU3HfDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRevSZy/Wo2e8lzAa+KkFqlnapXUO4LAqohw0FLRO3drc9KZXe8Nv4d5rkZy9Rij8VACyUh6HjM1qbZKbGTQJxWLaGKB/KCgEckinXBsjsF0oX6IUAT5hkX7lb72L2/tMY3A/VXq/fmHQZ346nHBbaYvpXkKr7Hwl5t+PknCcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbPplueR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDBBC433C7;
	Tue, 12 Mar 2024 20:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710275669;
	bh=R1f2Z6Q3RDe933FrVGM57J3eRx3hBGmWcguswU3HfDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbPplueR7QfpkRHj72iAUR/u7du2AAsFSV0FC3ne5fyvWqvS9olsy9mYB3JV6Rwmb
	 7P3QrB6UN9PXuV0XdScxxrUNv4MZt90dI5TneSGz+h+uRDU+uuJ7IZpLAlN6c8w4nF
	 +oT+0gWFh1wY+gKdXzNLmdH/YW4YW3a6Rv+JLgAw5zbh30oX2AM1e7PWHRsvgJG4c5
	 xKS80UbCKdOiZWPHdQQtDhyM4V6grZMXaeaQf9hA5h3hgZJ9hgtmowkrMkSPIC9YV0
	 NN/yYRLdbbiDUw1/dA7/I7ExMQdOiRgW27nuzBdBgLWXRBRzx30DWL4/RBkJTji+/M
	 G1+Zj8bGgL3gg==
Date: Tue, 12 Mar 2024 13:34:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.9
Message-ID: <20240312133427.1a744844@kernel.org>
In-Reply-To: <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
References: <20240312042504.1835743-1-kuba@kernel.org>
	<CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 13:17:05 -0700 Linus Torvalds wrote:
> On Mon, 11 Mar 2024 at 21:25, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > I get what looks like blk-iocost deadlock when I try to run
> > your current tree on real Meta servers :(  
> 
> Hmm. This "it breaks on real hardware, but works in virtual boxes"
> sounds like it might be the DM queue limit issue.
> 
> Did the tree you tested with perhaps have commit 8e0ef4128694 (which
> came in yesterday through the block merge (merge commit 1ddeeb2a058d
> just after 11am Monday), but not the revert (commit bff4b74625fe, six
> hours later).
> 
> IOW, just how current was that "current"? Your email was sent multiple
> hours after the revert happened and was pushed out, but I would not be
> surprised if your testing was done with something that was in that
> broken window.
> 
> So if you merged some *other* tree than one from that six-hour window,
> please holler - because there's something else going on and we need to
> get the block people on it.

I was testing with net-next on top of b0402403e54a ("Merge tag
'edac_updates_for_v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras").
IOW with the revert of 8e0ef4128694.

I have various debug options enabled, and I only captured the stack
trace from a kdump kernel, with hung_task_panic=1 which dies with
the traces below. Let me retest now and try to capture the real
crash..

[   75.939405] kexec_file_load: type:1, start:0xa0ffb110 head:0x4 flags:0x2
[   98.698918] rcu_tasks_wait_gp: rcu_tasks grace period number 41 (since boot) is 10496 jiffies old.
[  128.811055] rcu_tasks_wait_gp: rcu_tasks grace period number 41 (since boot) is 40608 jiffies old.
[  128.965688] watchdog: Watchdog detected hard LOCKUP on cpu 19
[  128.965691] Modules linked in: tls act_gact cls_bpf kvm_amd kvm irqbypass acpi_cpufreq ipmi_si ipmi_devintf ipmi_msghandler button tpm_crb sch_fq_codel vhost_net tun vhost vhost_iotlb tap virtio_net net_failover failover mpls_gso mpls_iptunnel mpls_router fou xhci_pci nvme xhci_hcd nvme_core fuse loop efivarfs autofs4 cbc cts ghash_generic gcm
[  128.965729] irq event stamp: 806530
[  128.965730] hardirqs last  enabled at (806529): [<ffffffff81153274>] mod_delayed_work_on+0xb4/0x120
[  128.965738] hardirqs last disabled at (806530): [<ffffffff8265a0db>] sysvec_apic_timer_interrupt+0xb/0xc0
[  128.965745] softirqs last  enabled at (794634): [<ffffffff811228e5>] irq_exit_rcu+0x95/0xf0
[  128.965748] softirqs last disabled at (794625): [<ffffffff811228e5>] irq_exit_rcu+0x95/0xf0
[  128.965751] CPU: 19 PID: 6464 Comm: bandicoot#nativ Kdump: loaded Not tainted 6.8.0-03541-g28ac76d5f530 #109
[  128.965756] Hardware name: bla!
[  128.965758] RIP: 0010:__asan_load4+0x8/0x80
[  128.965763] Code: de f2 ff ff 40 38 f0 7e ec c3 48 c1 e8 03 80 3c 10 00 75 f3 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 83 ff fc 4c 8b 04 24 <73> 4d 48 b8 ff ff ff ff ff 7f ff ff 48 39 c7 76 3e 48 8d 47 03 48
[  128.965766] RSP: 0018:ffff888fcd989b00 EFLAGS: 00000087
[  128.965769] RAX: ffff8881789ade2c RBX: 0000000000000002 RCX: ffffffff811e06b9
[  128.965771] RDX: dffffc0000000000 RSI: ffff8881789ade48 RDI: ffff8881789ade2c
[  128.965773] RBP: 0000000000000000 R08: ffffffff811e06e1 R09: 0000000000000001
[  128.965774] R10: ffffffff84875477 R11: 0000000000000000 R12: 0000000000000001
[  128.965776] R13: 000000000000056e R14: 0000000000000001 R15: ffff8881789ade98
[  128.965777] FS:  00007f6c80be9180(0000) GS:ffff888fcd980000(0000) knlGS:0000000000000000
[  128.965780] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  128.965781] CR2: 00007f6c576fdfe0 CR3: 0000000144346001 CR4: 0000000000f70ef0
[  128.965783] PKRU: 55555554
[  128.965784] Call Trace:
[  128.965786]  <NMI>
[  128.965788]  ? watchdog_hardlockup_check+0x1b7/0x2c0
[  128.965797]  ? __perf_event_overflow+0x1d6/0x310
[  128.965803]  ? x86_pmu_handle_irq+0x208/0x290
[  128.965809]  ? perf_event_print_debug+0x500/0x500
[  128.965815]  ? rcu_is_watching+0x34/0x50
[  128.965819]  ? lock_release+0xff/0x410
[  128.965823]  ? ghes_notify_nmi+0x394/0x640
[  128.965828]  ? lock_downgrade+0x3a0/0x3a0
[  128.965831]  ? lock_downgrade+0x3a0/0x3a0
[  128.965834]  ? ghes_copy_tofrom_phys+0x74/0x130
[  128.965843]  ? rcu_is_watching+0x34/0x50
[  128.965846]  ? lock_acquire+0xec/0x440
[  128.965850]  ? lock_sync+0x110/0x110
[  128.965852]  ? ghes_probe+0x600/0x600
[  128.965854]  ? nmi_handle+0x23f/0x340
[  128.965859]  ? lock_downgrade+0x3a0/0x3a0
[  128.965865]  ? amd_pmu_handle_irq+0x7b/0x110
[  128.965869]  ? perf_event_nmi_handler+0x39/0x60
[  128.965874]  ? nmi_handle+0xfa/0x340
[  128.965879]  ? __asan_load4+0x8/0x80
[  128.965884]  ? default_do_nmi+0x6b/0x170
[  128.965888]  ? exc_nmi+0xe8/0x110
[  128.965892]  ? end_repeat_nmi+0xf/0x18
[  128.965899]  ? __lock_acquire+0x251/0x3450
[  128.965902]  ? __lock_acquire+0x229/0x3450
[  128.965906]  ? __asan_load4+0x8/0x80
[  128.965910]  ? __asan_load4+0x8/0x80
[  128.965915]  ? __asan_load4+0x8/0x80
[  128.965920]  </NMI>
[  128.965920]  <IRQ>
[  128.965921]  __lock_acquire+0x251/0x3450
[  128.965931]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[  128.965935]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[  128.965943]  lock_acquire+0x185/0x440
[  128.965946]  ? iocg_waitq_timer_fn+0xa6/0x180
[  128.965952]  ? lock_sync+0x110/0x110
[  128.965956]  ? lock_release+0x25c/0x410
[  128.965959]  ? debug_object_deactivate+0x1bc/0x230
[  128.965966]  ? lock_downgrade+0x3a0/0x3a0
[  128.965979]  ioc_now+0x110/0x240
[  128.965983]  ? iocg_waitq_timer_fn+0xa6/0x180
[  128.965989]  ? find_held_lock+0x85/0xa0
[  128.965999]  iocg_waitq_timer_fn+0xa6/0x180
[  128.966005]  ? iocg_kick_waitq+0x5b0/0x5b0
[  128.966012]  ? rb_erase+0x41e/0x610
[  128.966021]  ? iocg_kick_waitq+0x5b0/0x5b0
[  128.966027]  ? iocg_kick_waitq+0x5b0/0x5b0
[  128.966034]  __hrtimer_run_queues+0x39e/0x6d0
[  128.966043]  ? enqueue_hrtimer+0x1a0/0x1a0
[  128.966048]  ? ktime_get_update_offsets_now+0x5e/0x1d0
[  128.966051]  ? ktime_get_update_offsets_now+0xdc/0x1d0
[  128.966056]  hrtimer_interrupt+0x1b6/0x370
[  128.966065]  __sysvec_apic_timer_interrupt+0xcf/0x300
[  128.966070]  sysvec_apic_timer_interrupt+0x8e/0xc0
[  128.966074]  </IRQ>
[  128.966075]  <TASK>
[  128.966077]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  128.966080] RIP: 0010:mod_delayed_work_on+0xbf/0x120
[  128.966084] Code: 00 00 00 8b 7c 24 04 4c 89 f1 4c 89 e2 4c 89 ee e8 76 f7 ff ff 48 85 db 74 06 e8 6c 53 1c 00 fb 48 b8 00 00 00 00 00 fc ff df <48> c7 44 05 00 00 00 00 00 48 8b 44 24 60 65 48 2b 04 25 28 00 00
[  128.966086] RSP: 0018:ffff8882697b6d18 EFLAGS: 00000206
[  128.966088] RAX: dffffc0000000000 RBX: 0000000000000200 RCX: ffffffff811deb5d
[  128.966090] RDX: 0000000000000000 RSI: ffffffff82a863c0 RDI: ffffffff82d04620
[  128.966092] RBP: 1ffff1104d2f6da4 R08: 0000000000000001 R09: fffffbfff0c2db75
[  128.966093] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88812fbaf080
[  128.966095] R13: ffff888105929c00 R14: 0000000000000000 R15: ffff88812fbaf000
[  128.966100]  ? mark_lock.part.0+0x10d/0x1790
[  128.966106]  ? mod_delayed_work_on+0xb4/0x120
[  128.966110]  ? cancel_delayed_work+0x10/0x10
[  128.966115]  ? blk_mq_delay_run_hw_queue+0x1b4/0x2a0
[  128.966121]  kblockd_mod_delayed_work_on+0x17/0x20
[  128.966125]  blk_mq_flush_plug_list.part.0+0xcf7/0x1080
[  128.966132]  ? blk_mq_try_issue_list_directly+0x240/0x240
[  128.966136]  ? hrtimer_start_range_ns+0x1e3/0x660
[  128.966142]  ? do_raw_spin_unlock+0x93/0xf0
[  128.966145]  ? preempt_count_sub+0x14/0xc0
[  128.966151]  __blk_flush_plug+0x1d6/0x250
[  128.966157]  ? blk_start_plug_nr_ios+0xd0/0xd0
[  128.966162]  ? mark_held_locks+0x65/0x90
[  128.966167]  io_schedule+0x5f/0xa0
[  128.966172]  ? ioc_rqos_throttle+0x697/0xd00
[  128.966175]  ioc_rqos_throttle+0x67b/0xd00
[  128.966180]  ? filemap_read+0x140/0x5f0
[  128.966185]  ? ioc_rqos_merge+0x350/0x350
[  128.966190]  ? bvec_split_segs+0x170/0x170
[  128.966196]  ? iocg_commit_bio+0xa0/0xa0
[  128.966201]  ? blk_attempt_bio_merge.part.0+0x7b/0x1d0
[  128.966208]  __rq_qos_throttle+0x33/0x50
[  128.966212]  blk_mq_submit_bio+0x8bb/0xdb0
[  128.966217]  ? find_held_lock+0x85/0xa0
[  128.966220]  ? blk_mq_flush_plug_list+0x30/0x30
[  128.966224]  ? lock_release+0x25c/0x410
[  128.966231]  ? preempt_count_sub+0x14/0xc0
[  128.966234]  ? blk_cgroup_bio_start+0x15b/0x1e0
[  128.966240]  submit_bio_noacct_nocheck+0x551/0x670
[  128.966243]  ? lock_is_held_type+0xd7/0x130
[  128.966248]  ? blk_alloc_queue+0x440/0x440
[  128.966253]  ? submit_bio_noacct+0x204/0x890
[  128.966260]  btrfs_submit_chunk+0x25f/0x9d0
[  128.966268]  ? run_one_async_done+0xb0/0xb0
[  128.966274]  ? add_ra_bio_pages.constprop.0.isra.0+0x104/0x650
[  128.966280]  ? kasan_save_stack+0x40/0x40
[  128.966289]  btrfs_submit_bio+0x16/0x20
[  128.966294]  btrfs_submit_compressed_read+0x3fe/0x490
[  128.966301]  ? btrfs_submit_compressed_write+0x2d0/0x2d0
[  128.966311]  submit_one_bio+0x6e/0x70
[  128.966315]  btrfs_do_readpage+0x535/0x7a0
[  128.966325]  extent_readahead+0x563/0xa60
[  128.966329]  ? extent_readahead+0x19d/0xa60
[  128.966334]  ? extent_writepages+0x150/0x150
[  128.966341]  ? end_page_read+0x2a0/0x2a0
[  128.966344]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[  128.966347]  ? __filemap_add_folio+0x439/0x7a0
[  128.966361]  ? folio_add_lru+0x1a8/0x2c0
[  128.966365]  ? lock_downgrade+0x3a0/0x3a0
[  128.966368]  ? file_check_and_advance_wb_err+0x1d0/0x1d0
[  128.966373]  read_pages+0xff/0x5d0
[  128.966379]  ? file_ra_state_init+0x50/0x50
[  128.966389]  page_cache_ra_unbounded+0x1b8/0x280
[  128.966397]  filemap_get_pages+0x420/0xa60
[  128.966404]  ? __lock_acquire+0x8f4/0x3450
[  128.966407]  ? filemap_get_read_batch+0x4d0/0x4d0
[  128.966413]  ? lock_is_held_type+0xd7/0x130
[  128.966421]  filemap_read+0x212/0x5f0
[  128.966424]  ? __lock_acquire+0x8f4/0x3450
[  128.966433]  ? filemap_get_pages+0xa60/0xa60
[  128.966436]  ? mark_lock.part.0+0x15b1/0x1790
[  128.966440]  ? lock_acquire+0x195/0x440
[  128.966443]  ? lock_is_held_type+0xd7/0x130
[  128.966448]  ? btrfs_file_read_iter+0x22/0x350
[  128.966452]  ? trace_contention_end+0xe4/0x110
[  128.966457]  ? preempt_count_sub+0x14/0xc0
[  128.966463]  vfs_read+0x392/0x540
[  128.966469]  ? kernel_read+0xc0/0xc0
[  128.966482]  ksys_read+0xc3/0x160
[  128.966485]  ? __ia32_sys_pwrite64+0x130/0x130
[  128.966488]  ? mark_held_locks+0x24/0x90
[  128.966491]  ? mark_held_locks+0x24/0x90
[  128.966497]  do_syscall_64+0x68/0x130
[  128.966501]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[  128.966504] RIP: 0033:0x7f6c7791721a
[  128.966509] Code: 55 48 89 e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 f8 c7 f7 ff 41 89 c0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 36 44 89 c7 48 89 45 f8 e8 32 c8 f7 ff 48 8b

