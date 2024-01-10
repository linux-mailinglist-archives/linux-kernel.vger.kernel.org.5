Return-Path: <linux-kernel+bounces-21822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC78294D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75731B21100
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE7F3DB85;
	Wed, 10 Jan 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQ2qlt4z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB93D966
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704874269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRhqVo2UG9ic38CL0B49IBcbUPAEZo2WecBFR7xi49o=;
	b=GQ2qlt4z7rDsmEXlo/iWD9p8oYM7nlOOqihGEjfJVIkmkxkmgGzw+fEyvZjfcqC5thHe9i
	uhv9oP0cPqymkyLgRA85NnFKR9+2WRIo8pZWZdtHqDxAk3oD85jF3k1xj2TI6n63K5BIXe
	yOfOITy4ew2y4nsErObCmxJxH1vjWik=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-DMKf5zPbOnKMTsUVKsbOkw-1; Wed, 10 Jan 2024 03:11:07 -0500
X-MC-Unique: DMKf5zPbOnKMTsUVKsbOkw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e7b5c3582so3519811e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704874266; x=1705479066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRhqVo2UG9ic38CL0B49IBcbUPAEZo2WecBFR7xi49o=;
        b=lOvqhBs7yV8N7rs1TFupUIF1/E/kCWHcQSjaC4X09LyMAJeRf/LRNoQNJeU7KYX331
         hPhou4Z1TNMxl1wGjocmQJqczMJ3qgD+X3YPdwWmVOr8vHN4a9thbkAxxoaQgj+TbwlT
         Stojoh8WoxnCYcjH4UNbcSHkKcO6BorvwWrRYqcfg9FQkSscHXfrAS6j4qTlOCk6c7q5
         t/A0FDIEP1Strt2bDCEXJBYrldWyHaGkajOA5iS/qYfKNTwJHiq5uSmjG/VUOYUnhfrn
         dEhR28YRQxMbmO7FUzErdWOXA9CiLC77Xfsoc0lVPaExJAf7QYAkfOFyNyB0W24YvGsp
         F25A==
X-Gm-Message-State: AOJu0YyHlJkWf0ThWaUhIEPlfLCuwzyv4tCLuLYM8d6VTZoWgrudB3w7
	2UsovmBRSHhhq0XLuzscUUc3hwFxf/R0m43eekYMj93c8IKQOg4Ji3JJMs7HHSXI1bcBRPPkO/W
	bQ19TsuBuuyeGzJ5bcD5YR1yJvOValTu7
X-Received: by 2002:ac2:5dc9:0:b0:50e:7a9e:4846 with SMTP id x9-20020ac25dc9000000b0050e7a9e4846mr184062lfq.70.1704874266040;
        Wed, 10 Jan 2024 00:11:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYpjMplv0WST/nDNwfTquDtdYgCf9QnvDqIrB6EXh2tN7HOItbJi3hhE0w4mwL3IUDeKjbwA==
X-Received: by 2002:ac2:5dc9:0:b0:50e:7a9e:4846 with SMTP id x9-20020ac25dc9000000b0050e7a9e4846mr184057lfq.70.1704874265610;
        Wed, 10 Jan 2024 00:11:05 -0800 (PST)
Received: from redhat.com ([2.52.133.193])
        by smtp.gmail.com with ESMTPSA id w37-20020a0565120b2500b0050ec7a26420sm594115lfu.204.2024.01.10.00.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 00:11:04 -0800 (PST)
Date: Wed, 10 Jan 2024 03:11:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: David Stevens <stevensd@chromium.org>,
	David Hildenbrand <david@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: REGRESSION: lockdep warning triggered by 15b9ce7ecd:
 virtio_balloon: stay awake while adjusting balloon
Message-ID: <20240110030913-mutt-send-email-mst@kernel.org>
References: <20240108215015.GA599905@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108215015.GA599905@mit.edu>

On Mon, Jan 08, 2024 at 04:50:15PM -0500, Theodore Ts'o wrote:
> Hi, while doing final testing before sending a pull request, I merged
> in linux-next, and commit 5b9ce7ecd7: virtio_balloon: stay awake while
> adjusting balloon seems to be causing a lockdep warning (see attached)
> when running gce-xfstests on a Google Compute Engine e2 VM.  I was not
> able to trigger it using kvm-xfstests, but the following command:
> "gce-xfstests -C 10 ext4/4k generic/476) was sufficient to triger the
> problem.   For more information please see [1] and [2].
> 
> [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md
> [2] https://thunk.org/gce-xfstests
> 
> I found it by looking at the git logs, and this commit aroused my
> suspicions, and I further testing showed that the lockdep warning was
> reproducible with this commit, but not when testing with the
> immediately preceeding commit (15b9ce7ecd^).
> 
> Cheers,


Thanks a lot for the report!
I pushed a fixed patch out (tree rebased).
Would be great if you can confirm it's allright now.

> 						- Ted
> 
> 
> root: ext4/4k run xfstest generic/476
> systemd[1]: Started fstests-generic-476.scope - /usr/bin/bash -c test -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/476.
> kernel: [  399.361181] EXT4-fs (dm-1): mounted filesystem 840e25bd-f650-4819-8562-7eded85ef370 r/w with ordered data mode. Quota mode: none.
> systemd[1]: fstests-generic-476.scope: Deactivated successfully.
> systemd[1]: fstests-generic-476.scope: Consumed 3min 1.966s CPU time.
> systemd[1]: xt\x2dvdb.mount: Deactivated successfully.
> kernel: [  537.085404] EXT4-fs (dm-0): unmounting filesystem d3d7a675-f7b6-4384-abec-2e60d885b6da.
> systemd[1]: xt\x2dvdc.mount: Deactivated successfully.
> kernel: [  540.565870] 
> kernel: [  540.567523] ================================
> kernel: [  540.572007] WARNING: inconsistent lock state
> kernel: [  540.576407] 6.7.0-rc3-xfstests-lockdep-00012-g5b9ce7ecd715 #318 Not tainted
> kernel: [  540.583532] --------------------------------
> kernel: [  540.587928] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> kernel: [  540.594326] kworker/0:3/329 [HC0[0]:SC0[0]:HE1:SE1] takes:
> kernel: [  540.599955] ffff90b280a548c0 (&vb->adjustment_lock){?...}-{2:2}, at: update_balloon_size_func+0x33/0x190
> kernel: [  540.609926] {IN-HARDIRQ-W} state was registered at:
> kernel: [  540.614935]   __lock_acquire+0x3f2/0xb30
> kernel: [  540.618992]   lock_acquire+0xbf/0x2b0
> kernel: [  540.622786]   _raw_spin_lock_irqsave+0x43/0x90
> kernel: [  540.627366]   virtballoon_changed+0x51/0xd0
> kernel: [  540.631947]   virtio_config_changed+0x5a/0x70
> kernel: [  540.636437]   vp_config_changed+0x11/0x20
> kernel: [  540.640576]   __handle_irq_event_percpu+0x88/0x230
> kernel: [  540.645500]   handle_irq_event+0x38/0x80
> kernel: [  540.649558]   handle_edge_irq+0x8f/0x1f0
> kernel: [  540.653791]   __common_interrupt+0x47/0xf0
> kernel: [  540.658106]   common_interrupt+0x79/0xa0
> kernel: [  540.661672] EXT4-fs (dm-1): unmounting filesystem 840e25bd-f650-4819-8562-7eded85ef370.
> kernel: [  540.663183]   asm_common_interrupt+0x26/0x40
> kernel: [  540.663190]   acpi_safe_halt+0x1b/0x30
> kernel: [  540.663196]   acpi_idle_enter+0x7b/0xd0
> kernel: [  540.663199]   cpuidle_enter_state+0x90/0x4f0
> kernel: [  540.688723]   cpuidle_enter+0x2d/0x40
> kernel: [  540.692516]   cpuidle_idle_call+0xe4/0x120
> kernel: [  540.697036]   do_idle+0x84/0xd0
> kernel: [  540.700393]   cpu_startup_entry+0x2a/0x30
> kernel: [  540.704588]   rest_init+0xe9/0x180
> kernel: [  540.708118]   arch_call_rest_init+0xe/0x30
> kernel: [  540.712426]   start_kernel+0x41c/0x4b0
> kernel: [  540.716310]   x86_64_start_reservations+0x18/0x30
> kernel: [  540.721164]   x86_64_start_kernel+0x8c/0x90
> kernel: [  540.725737]   secondary_startup_64_no_verify+0x178/0x17b
> kernel: [  540.731432] irq event stamp: 22681
> kernel: [  540.734956] hardirqs last  enabled at (22681): [<ffffffff8b4b5158>] _raw_spin_unlock_irq+0x28/0x50
> kernel: [  540.744564] hardirqs last disabled at (22680): [<ffffffff8b4b4ded>] _raw_spin_lock_irq+0x5d/0x90
> kernel: [  540.753475] softirqs last  enabled at (22076): [<ffffffff8a58cfa1>] srcu_invoke_callbacks+0x101/0x1c0
> kernel: [  540.762904] softirqs last disabled at (22072): [<ffffffff8a58cfa1>] srcu_invoke_callbacks+0x101/0x1c0
> kernel: [  540.773298] 
> kernel: [  540.773298] other info that might help us debug this:
> kernel: [  540.780207]  Possible unsafe locking scenario:
> kernel: [  540.780207] 
> kernel: [  540.786438]        CPU0
> kernel: [  540.789007]        ----
> kernel: [  540.791766]   lock(&vb->adjustment_lock);
> kernel: [  540.796014]   <Interrupt>
> kernel: [  540.798778]     lock(&vb->adjustment_lock);
> kernel: [  540.803605] 
> kernel: [  540.803605]  *** DEADLOCK ***
> kernel: [  540.803605] 
> kernel: [  540.809840] 2 locks held by kworker/0:3/329:
> kernel: [  540.814259]  #0: ffff90b280079148 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work+0x1a6/0x500
> kernel: [  540.824952]  #1: ffff9e3b40d1fe50 ((work_completion)(&vb->update_balloon_size_work)){+.+.}-{0:0}, at: process_one_work+0x1a6/0x500
> kernel: [  540.837088] 
> kernel: [  540.837088] stack backtrace:
> kernel: [  540.841584] CPU: 0 PID: 329 Comm: kworker/0:3 Not tainted 6.7.0-rc3-xfstests-lockdep-00012-g5b9ce7ecd715 #318
> kernel: [  540.851632] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> kernel: [  540.861148] Workqueue: events_freezable update_balloon_size_func
> kernel: [  540.867306] Call Trace:
> kernel: [  540.869914]  <TASK>
> kernel: [  540.872136]  dump_stack_lvl+0x4a/0x80
> kernel: [  540.876012]  mark_lock_irq+0x3a5/0x5a0
> kernel: [  540.879973]  ? stack_trace_save+0x55/0x80
> kernel: [  540.884105]  ? save_trace+0x66/0x200
> kernel: [  540.887894]  mark_lock+0x1f3/0x3f0
> kernel: [  540.891417]  mark_usage+0xe1/0x140
> kernel: [  540.895060]  __lock_acquire+0x3f2/0xb30
> kernel: [  540.899020]  lock_acquire+0xbf/0x2b0
> kernel: [  540.902722]  ? update_balloon_size_func+0x33/0x190
> kernel: [  540.908073]  ? lock_acquire+0xbf/0x2b0
> kernel: [  540.912059]  ? process_one_work+0x1a6/0x500
> kernel: [  540.916388]  ? process_one_work+0x1a6/0x500
> kernel: [  540.920808]  _raw_spin_lock+0x34/0x80
> kernel: [  540.924646]  ? update_balloon_size_func+0x33/0x190
> kernel: [  540.929677]  update_balloon_size_func+0x33/0x190
> kernel: [  540.934510]  ? process_one_work+0x1a6/0x500
> kernel: [  540.939000]  process_one_work+0x20f/0x500
> kernel: [  540.943383]  worker_thread+0x1e1/0x3d0
> kernel: [  540.947391]  ? __pfx_worker_thread+0x10/0x10
> kernel: [  540.952103]  kthread+0xf5/0x130
> kernel: [  540.955392]  ? __pfx_kthread+0x10/0x10
> kernel: [  540.959290]  ret_from_fork+0x31/0x50
> kernel: [  540.963193]  ? __pfx_kthread+0x10/0x10
> kernel: [  540.967157]  ret_from_fork_asm+0x1b/0x30
> kernel: [  540.971205]  </TASK>
> kernel: [  550.008710] EXT4-fs (dm-1): mounted filesystem 840e25bd-f650-4819-8562-7eded85ef370 r/w with ordered data mode. Quota mode: none.
> systemd[1]: xt\x2dvdc.mount: Deactivated successfully.
> kernel: [  550.033770] EXT4-fs (dm-1): unmounting filesystem 840e25bd-f650-4819-8562-7eded85ef370.
> root: gce-xfstests: checking for hook post-xfstests
> root: gce-xfstests: checking for hook pre-xfstests


