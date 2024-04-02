Return-Path: <linux-kernel+bounces-127461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC04894BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC52C1F22CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE13308A;
	Tue,  2 Apr 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="itmq4zk2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dcSgenen"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038414AAD;
	Tue,  2 Apr 2024 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040678; cv=none; b=j4n+YOElSpvUdYEO6BUtyVU6Ya5VYdjifC1akwQdtTV9FOA5v+A+0iT9Cv6mAx4224aTEHY0NgvLb2ssQtn49X9VG0j9bxbTl/dKVm9CMsqItASCt/1otEAVMaIDkBxD7O/4TFSUjPTXQfc3CPsTt0b5QeGvPtbLuO+CsG6nfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040678; c=relaxed/simple;
	bh=7qOiZVEO4yMr7Y/rT6+JwhH6j9puH5V5BFv+Jf88PmU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJGOnQecGFsSIgYP40lDt61L8x5OVwj6/RkMOAnBx8sgLRUo44poDK6/PsLFFdTSOKsEVuQY5w2DOizl1IQ5rocJjboYynptOj9plVzJMDUs8rnIDYGM0CVTP0Zr5gh0xj7+PSlSI5ks0fOgXR+CDXKvtLXsqXwJhRvGZJOi1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=itmq4zk2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dcSgenen; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2F3F20CFA;
	Tue,  2 Apr 2024 06:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712040674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nh5J8aQQpLo5ckADtp1KCYffB1xaWfrVFf026Vcg7uY=;
	b=itmq4zk2LsYY/D92NJRoZvrmRgmeqTaJoSzHnmLggRvK0aE4H36A/fcaxtca2UjXYhlIfm
	yKzEnnJE3MIvJOWOTlYbyNkUBqrpc0y1H/d/OgUEfcoXz7Vkio+k1ItoiiuGZCQutCV97Q
	Je2uhrJIvAHBByQi3FpClyAwe0YW2Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712040674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nh5J8aQQpLo5ckADtp1KCYffB1xaWfrVFf026Vcg7uY=;
	b=dcSgenen/AOGm90VuZwQfZ+OCN7+CwSnQ3mMtkgpwCXjuHBJtEZbLoSm4c5TCT0BRuZ23F
	cH9VRcbKS3o0K6Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A35E013357;
	Tue,  2 Apr 2024 06:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XFOCJuKqC2b2QQAAn2gu4w
	(envelope-from <tiwai@suse.de>); Tue, 02 Apr 2024 06:51:14 +0000
Date: Tue, 02 Apr 2024 08:51:19 +0200
Message-ID: <87o7ass1eg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [PATCH] ALSA: line6: fix uninit-value in line6_pod_process_message
In-Reply-To: <tencent_44291B84257ABAB7BB7B33C49E0E1BC74B08@qq.com>
References: <00000000000084b18706150bcca5@google.com>
	<tencent_44291B84257ABAB7BB7B33C49E0E1BC74B08@qq.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -0.11
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.11 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FREEMAIL_TO(0.00)[qq.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[7fb05ccf7b3d2f9617b3];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,appspotmail.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E2F3F20CFA

On Tue, 02 Apr 2024 08:47:24 +0200,
Edward Adam Davis wrote:
> 
> [Syzbot reported]
> BUG: KMSAN: uninit-value in line6_pod_process_message+0x72f/0x7b0 sound/usb/line6/pod.c:201
>  line6_pod_process_message+0x72f/0x7b0 sound/usb/line6/pod.c:201
>  line6_data_received+0x5db/0x7e0 sound/usb/line6/driver.c:317
>  __usb_hcd_giveback_urb+0x508/0x770 drivers/usb/core/hcd.c:1648
>  usb_hcd_giveback_urb+0x157/0x720 drivers/usb/core/hcd.c:1732
>  dummy_timer+0xd93/0x6b10 drivers/usb/gadget/udc/dummy_hcd.c:1987
>  call_timer_fn+0x49/0x580 kernel/time/timer.c:1793
>  expire_timers kernel/time/timer.c:1844 [inline]
>  __run_timers kernel/time/timer.c:2418 [inline]
>  __run_timer_base+0x84e/0xe90 kernel/time/timer.c:2429
>  run_timer_base kernel/time/timer.c:2438 [inline]
>  run_timer_softirq+0x3a/0x70 kernel/time/timer.c:2448
>  __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:633 [inline]
>  irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>  sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
>  asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
>  native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
>  arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
>  acpi_safe_halt+0x25/0x30 drivers/acpi/processor_idle.c:112
>  acpi_idle_do_entry+0x22/0x40 drivers/acpi/processor_idle.c:573
>  acpi_idle_enter+0xa1/0xc0 drivers/acpi/processor_idle.c:707
>  cpuidle_enter_state+0xcb/0x250 drivers/cpuidle/cpuidle.c:267
>  cpuidle_enter+0x7f/0xf0 drivers/cpuidle/cpuidle.c:388
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x551/0x750 kernel/sched/idle.c:332
>  cpu_startup_entry+0x65/0x80 kernel/sched/idle.c:430
>  rest_init+0x1e8/0x260 init/main.c:732
>  start_kernel+0x927/0xa70 init/main.c:1074
>  x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:507
>  x86_64_start_kernel+0x98/0xa0 arch/x86/kernel/head64.c:488
>  common_startup_64+0x12c/0x137
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3804 [inline]
>  slab_alloc_node mm/slub.c:3845 [inline]
>  kmalloc_trace+0x578/0xba0 mm/slub.c:3992
>  kmalloc include/linux/slab.h:628 [inline]
>  line6_init_cap_control+0x4f1/0x770 sound/usb/line6/driver.c:700
>  line6_probe+0xeae/0x1120 sound/usb/line6/driver.c:797
>  pod_probe+0x79/0x90 sound/usb/line6/pod.c:522
>  usb_probe_interface+0xd6f/0x1350 drivers/usb/core/driver.c:399
>  really_probe+0x4db/0xd90 drivers/base/dd.c:656
>  __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:798
>  driver_probe_device+0x72/0x890 drivers/base/dd.c:828
>  __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:956
>  bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
>  __device_attach+0x3c1/0x650 drivers/base/dd.c:1028
>  device_initial_probe+0x32/0x40 drivers/base/dd.c:1077
>  bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
>  device_add+0x1475/0x1c90 drivers/base/core.c:3705
>  usb_set_configuration+0x31c9/0x38d0 drivers/usb/core/message.c:2210
>  usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:254
>  usb_probe_device+0x3a7/0x690 drivers/usb/core/driver.c:294
>  really_probe+0x4db/0xd90 drivers/base/dd.c:656
>  __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:798
>  driver_probe_device+0x72/0x890 drivers/base/dd.c:828
>  __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:956
>  bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
>  __device_attach+0x3c1/0x650 drivers/base/dd.c:1028
>  device_initial_probe+0x32/0x40 drivers/base/dd.c:1077
>  bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
>  device_add+0x1475/0x1c90 drivers/base/core.c:3705
>  usb_new_device+0x15ff/0x2470 drivers/usb/core/hub.c:2643
>  hub_port_connect drivers/usb/core/hub.c:5512 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5652 [inline]
>  port_event drivers/usb/core/hub.c:5812 [inline]
>  hub_event+0x4ff8/0x72d0 drivers/usb/core/hub.c:5894
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
>  worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
>  kthread+0x3e2/0x540 kernel/kthread.c:388
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> [Fix]
> Let's clear all the content of the buffer message during alloc.
> 
> Reported-and-tested-by: syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

A fix already submitted in https://lore.kernel.org/r/20240402063628.26609-1-tiwai@suse.de


thanks,

Takashi

