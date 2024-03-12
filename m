Return-Path: <linux-kernel+bounces-100772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77013879D10
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29433B23178
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B88414372B;
	Tue, 12 Mar 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfqpOZxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D08365;
	Tue, 12 Mar 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710276461; cv=none; b=E0ONBndsqBMm3lzDeK+XPAFnCX79Zh+rzFhicmEY1mxVpfXJn+IwGFYQOSCbEefTN052mRTIYNreXeeNFPshYgOHFBEdwZxiZtjob2oyqewQaZpgq9kRj+kjVm3vX9YKZaP1f/Ph1GGwgS1HicyM7N20SLdyx6w67vsqLpzCRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710276461; c=relaxed/simple;
	bh=GERHLPdEbleoVprwdXIvMQsUSqq4hz0J9Q1eneTgSfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5hmhtQic0VbOWRggiV2wLcxG2fBAoI5BPOP1cGzVOuZxR7bvponntuczPsBT+GLhuZv0wMIQxflnLoYXdQpVYifMqSvusDOIPL5Ovrz7JMCf2sRCNENEbfOEEOHS5iHBJsGvCWdEShMZDa08CUHzYiCBgWDFPTPkgOjOI6q3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfqpOZxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80439C433C7;
	Tue, 12 Mar 2024 20:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710276460;
	bh=GERHLPdEbleoVprwdXIvMQsUSqq4hz0J9Q1eneTgSfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TfqpOZxlbp1/ZQysY1Ooa+fzuHT7ckobUVJhPz4G0CA3j0bOpHZVXPR5R5ex8XbjI
	 5Amx8e7xxoQ+4RsGaaY1aiAOtqAvjDDrYT9/Ll+EiriP+I6SS/7O//TE1bF1WGx0/l
	 6LvvTTDJP9EIDFuA/G0G5dwDYK1vyW5rEtNgkcrFU+AKgMXQwxPu5/0W5DArZzPkCl
	 naip2IpDT1ABCgBDOXVrFgT5zYPwyVXvHDMPHIbeNo7v5/Vxg4NVU7IbczCoohGSy8
	 g4sewARaurO7PFTtLIbjCJTRe8E4TAy2UM960AIhymslPVOaXkgB1znBExbWV0+xRd
	 wmpFwf62ChXiQ==
Date: Tue, 12 Mar 2024 13:47:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org, Tejun
 Heo <tj@kernel.org>
Subject: Re: [GIT PULL] Networking for v6.9
Message-ID: <20240312134739.248e6bd3@kernel.org>
In-Reply-To: <20240312133427.1a744844@kernel.org>
References: <20240312042504.1835743-1-kuba@kernel.org>
	<CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
	<20240312133427.1a744844@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 13:34:27 -0700 Jakub Kicinski wrote:
> I was testing with net-next on top of b0402403e54a ("Merge tag
> 'edac_updates_for_v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras").
> IOW with the revert of 8e0ef4128694.
> 
> I have various debug options enabled, and I only captured the stack
> trace from a kdump kernel, with hung_task_panic=1 which dies with
> the traces below. Let me retest now and try to capture the real
> crash..

With your tree as of 65d287c7eb1d it gets to prompt but dies soon after
when prod services kick in (dunno what rpm Kdump does but says iocost
so adding Tejun):

[  115.832425] WARNING: CPU: 59 PID: 6473 at block/blk-iocost.c:2255 ioc_timer_fn+0x1dd4/0x2060
[  115.851797] Modules linked in: tls act_gact cls_bpf kvm_amd kvm irqbypass acpi_cpufreq ipmi_si ipmi_devintf ipmi_msghandler button tpm_crb sch_fq_codel xhci_pci nvme xhci_hcd nvme_core fuse loop efivarfs autofs4 cbc cts ghash_generic gcm
[  115.898730] CPU: 59 PID: 6473 Comm: rpm Kdump: loaded Not tainted 6.8.0-04854-gd99b04ab6218 #111
[  115.918472] Hardware name: cheese!
[  115.937746] RIP: 0010:ioc_timer_fn+0x1dd4/0x2060
[  115.948369] Code: ff ff 0f 0b e9 04 f8 ff ff 48 8b 5c 24 10 48 8d bb f0 00 00 00 e8 1c 05 94 ff 48 c7 83 f0 00 00 00 00 00 00 00 e9 1b f7 ff ff <0f> 0b 48 8b bc 24 c0 00 00 00 e8 0d 35 a4 00 e9 97 f8 ff ff 48 8b
[  115.990256] RSP: 0018:ffff888fced89ac8 EFLAGS: 00010046
[  116.002156] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81c354dc
[  116.018379] RDX: dffffc0000000000 RSI: ffffffff82a86800 RDI: ffff8881612561e8
[  116.034485] RBP: ffffe8ffffdc8000 R08: ffffffff81c31dbb R09: fffffbfff090ead6
[  116.050519] R10: ffffffff848756b7 R11: 0000000000000000 R12: ffff888fced89cd8
[  116.066741] R13: ffffe8ffffdc8010 R14: ffffe8ffffdc7fd0 R15: ffff888161256120
[  116.083079] FS:  00007fae6679f780(0000) GS:ffff888fced80000(0000) knlGS:0000000000000000
[  116.101394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  116.114610] CR2: 00007f45dde301b0 CR3: 00000001a25cd002 CR4: 0000000000f70ef0
[  116.131019] PKRU: 55555554
[  116.137732] Call Trace:
[  116.143788]  <IRQ>
[  116.148583]  ? __warn+0xa0/0x230
[  116.156470]  ? ioc_timer_fn+0x1dd4/0x2060
[  116.165729]  ? report_bug+0x229/0x240
[  116.174266]  ? handle_bug+0x3c/0x70
[  116.182311]  ? exc_invalid_op+0x14/0x40
[  116.191286]  ? asm_exc_invalid_op+0x16/0x20
[  116.200909]  ? ioc_now+0x19b/0x240
[  116.208973]  ? ioc_timer_fn+0x3ac/0x2060
[  116.218090]  ? ioc_timer_fn+0x1dd4/0x2060
[  116.227521]  ? ioc_timer_fn+0x3ac/0x2060
[  116.236616]  ? transfer_surpluses+0xdc0/0xdc0
[  116.246621]  ? lock_acquire+0x184/0x440
[  116.255451]  ? lock_sync+0x110/0x110
[  116.263832]  ? __lock_acquire+0x8f2/0x3440
[  116.273202]  ? do_raw_spin_unlock+0x92/0xf0
[  116.282808]  ? transfer_surpluses+0xdc0/0xdc0
[  116.292776]  ? transfer_surpluses+0xdc0/0xdc0
[  116.302815]  call_timer_fn+0x13d/0x3a0
[  116.311489]  ? timer_shutdown_sync+0x10/0x10
[  116.321782]  ? lock_downgrade+0x3a0/0x3a0
[  116.331131]  ? transfer_surpluses+0xdc0/0xdc0
[  116.341050]  ? mark_held_locks+0x65/0x90
[  116.350113]  ? transfer_surpluses+0xdc0/0xdc0
[  116.360151]  __run_timers+0x445/0x570
[  116.368667]  ? call_timer_fn+0x3a0/0x3a0
[  116.377777]  ? lock_sync+0x110/0x110
[  116.386245]  ? do_raw_spin_lock+0x10f/0x1a0
[  116.395904]  ? spin_bug+0xe0/0xe0
[  116.403775]  run_timer_base+0x66/0x80
[  116.412431]  run_timer_softirq+0x16/0x30
[  116.421505]  __do_softirq+0x105/0x5de
[  116.430031]  irq_exit_rcu+0x94/0xf0
[  116.438197]  sysvec_apic_timer_interrupt+0x93/0xc0
[  116.449178]  </IRQ>
[  116.454325]  <TASK>
[  116.459342]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  116.471096] RIP: 0010:_raw_spin_unlock_irqrestore+0x33/0x50
[  116.483858] Code: 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 85 97 b6 fe 48 89 ef e8 ed e0 b6 fe 80 e7 02 74 06 e8 03 dc c9 fe fb bf 01 00 00 00 <e8> b8 b6 af fe 65 8b 05 59 1e 9c 7d 85 c0 74 03 5b 5d c3 e8 a5 96
[  116.525813] RSP: 0018:ffff8881cf28f1d0 EFLAGS: 00000206
[  116.537931] RAX: 0000000000034ad1 RBX: 0000000000000282 RCX: ffffffff811de87d
[  116.554120] RDX: 0000000000000000 RSI: ffffffff82a86540 RDI: 0000000000000001
[  116.570384] RBP: ffffffff8436c200 R08: 0000000000000001 R09: fffffbfff0c2dd7d
[  116.586506] R10: 0000000000000001 R11: 0000000000000000 R12: ffff888241b3fc80
[  116.602344] R13: 0000000000000080 R14: 0000000000000001 R15: 0000000000000282
[  116.618234]  ? mark_lock.part.0+0x10d/0x1790
[  116.627775]  __create_object+0x5e/0x80
[  116.636199]  kmem_cache_alloc+0x2f3/0x3b0
[  116.645206]  alloc_extent_state+0x1e/0x1a0
[  116.654355]  __set_extent_bit+0x32b/0xb30
[  116.663374]  lock_extent+0xc1/0x430
[  116.671221]  ? memcg_list_lru_alloc+0x580/0x580
[  116.681348]  ? try_lock_extent+0xf0/0xf0
[  116.690125]  ? preempt_count_sub+0x14/0xc0
[  116.699283]  ? folio_add_lru+0x1b6/0x2c0
[  116.708079]  ? filemap_add_folio+0xd0/0x130
[  116.717417]  ? __filemap_add_folio+0x7a0/0x7a0
[  116.727382]  add_ra_bio_pages.constprop.0.isra.0+0x294/0x650
[  116.740055]  btrfs_submit_compressed_read+0x339/0x490
[  116.751363]  ? btrfs_submit_compressed_write+0x2d0/0x2d0
[  116.763251]  ? lock_downgrade+0x3a0/0x3a0
[  116.772238]  submit_one_bio+0x6e/0x70
[  116.780431]  extent_readahead+0x9b4/0xa60
[  116.789403]  ? extent_readahead+0x19d/0xa60
[  116.798755]  ? extent_writepages+0x150/0x150
[  116.808347]  ? end_page_read+0x2a0/0x2a0
[  116.817152]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[  116.828633]  ? __filemap_add_folio+0x439/0x7a0
[  116.838619]  ? folio_add_lru+0x1a7/0x2c0
[  116.847426]  ? lock_downgrade+0x3a0/0x3a0

