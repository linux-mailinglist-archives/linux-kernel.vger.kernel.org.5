Return-Path: <linux-kernel+bounces-74388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71CD85D353
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAC7288C68
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C323D0DB;
	Wed, 21 Feb 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qCRKKfCQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OnuzeNWz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxIjXSKF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/9TPJpB3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEF3D0C0;
	Wed, 21 Feb 2024 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507272; cv=none; b=Y3c0HvSSn7Nc+oqC64wAPk9vW9f8tH7lh0og3DyCC9CAn3KyJUDULkKnIATuFJjdsQpHe9h8zfAFi9WfXDHGTBdfFHwnU6oJzArvS5Ve3nUTdYQMJzHOEIuXoOeE88uJ7hRSI0/LViug1zRkJ9/V9XiqLt3HT5akRkt5r1CRNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507272; c=relaxed/simple;
	bh=5TlMa9rK3chQxEj3QcOSmRC0G1OU5/MpAUznw/rOJdo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwC5Dbzzo/E1ov3F6RVFbrzZDwvHQy1NwWIvfTHblfOSRpwhIfu9RkaIcNMt9xMRW5N+PoW9/+3G/QnA2D8Dy2TJHgaRS+Sq48TUNRmna22QiiWwG+bTH+ToiGP3Zii8t9SfCgJQ38dZ6mwz6PYm0pxwgWbY4a1ywfHiWLwj7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qCRKKfCQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OnuzeNWz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxIjXSKF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/9TPJpB3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA7771FB4C;
	Wed, 21 Feb 2024 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708507269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sXJyWtq+AXXfh+jaGYov5UgxI4/+MWGmULtXt77Th0=;
	b=qCRKKfCQF4da1DJd7nweAh7w1tbQFmDDjjS2dS0EGLvP8L9gZUpipGYhtQfiyWIGNtN+/S
	zOYFaUJzFR+226bxjHJLSqJFuuCdA81R/UFY8h7IQw+JawBSHftSHVRj0RsPLx1QRASbuJ
	U2QhRTTfnLHL/BaTKAYzO7dMKHy3Gy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708507269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sXJyWtq+AXXfh+jaGYov5UgxI4/+MWGmULtXt77Th0=;
	b=OnuzeNWzmWFyodUYNOuiP5nJx7tU0MIOpxIQRFYrkclUEm84y0OTtXj5p0p5RvaW7XoztU
	jhcg6bDeqWqnY7Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708507268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sXJyWtq+AXXfh+jaGYov5UgxI4/+MWGmULtXt77Th0=;
	b=SxIjXSKF1UmH1gZFl0yNP7nSOM/UgjBZrPRKLyaE3BIgeEilr1onz7glRbOTOry7Uq8eSS
	PwzjOHQnW/8MAlZjUvC4alig72w8hN2HSS1qKySDar/oROMoI19my+Ong2XotMW0brRyqd
	pRXrDLKVxzAKqBLo3hdvNRkjel+/8Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708507268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sXJyWtq+AXXfh+jaGYov5UgxI4/+MWGmULtXt77Th0=;
	b=/9TPJpB31e83HnvGa2NgISfNUxD5WkcH5qy5bPFxZd4WSTAGpIRrnF+SxB1EegO/C3aH7q
	eGloLFhYgpNDC7Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A0E8139D0;
	Wed, 21 Feb 2024 09:21:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1ymH4TA1WV2NAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 21 Feb 2024 09:21:08 +0000
Date: Wed, 21 Feb 2024 10:21:08 +0100
Message-ID: <87le7e6um3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sven van Ashbrook <svenva@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	stable@vger.kernel.org,
	Curtis Malainey <cujomalainey@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: Stall at page allocations with __GFP_RETRY_MAYFAIL (Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case)
In-Reply-To: <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
	<87jzn0ofdb.wl-tiwai@suse.de>
	<235ab5aa-90a4-4dd7-b2c6-70469605bcfb@suse.cz>
	<CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SxIjXSKF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/9TPJpB3"
X-Spamd-Result: default: False [-2.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EA7771FB4C
X-Spam-Level: 
X-Spam-Score: -2.31
X-Spam-Flag: NO

On Tue, 20 Feb 2024 16:52:14 +0100,
Sven van Ashbrook wrote:
> 
> Takaski, Vlastimil: thanks so much for the engagement! See below.
> 
> > On 2/19/24 12:36, Takashi Iwai wrote:
> > >
> > > Karthikeyan, Sven, and co: could you guys show the stack trace at the
> > > stall?  This may give us more clear light.
> 
> Here are two typical stack traces at the stall. Note that the timer interrupt
> is just a software watchdog that fires to generate the stack trace.
> This is running the v6.1 kernel.
> We should be able to reproduce this on v6.6 as well if need be.
> 
> <4>[310289.546429] <TASK>
> <4>[310289.546431] asm_sysvec_apic_timer_interrupt+0x16/0x20
> <4>[310289.546434] RIP: 0010:super_cache_count+0xc/0xea
> <4>[310289.546438] Code: ff ff e8 48 ac e3 ff 4c 89 e0 48 83 c4 20 5b
> 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 0f 1f 44 00 00 f6 87 23
> fc ff ff 20 <75> 08 31 c0 c3 cc cc cc cc cc 55 48 89 e5 41 57 41 56 41
> 54 53 49
> <4>[310289.546440] RSP: 0018:ffffa64e8aed35c0 EFLAGS: 00000202
> <4>[310289.546443] RAX: 0000000000000080 RBX: 0000000000000400 RCX:
> 0000000000000000
> <4>[310289.546445] RDX: ffffffffa6d66bc8 RSI: ffffa64e8aed3610 RDI:
> ffff9fd2873dbc30
> <4>[310289.546447] RBP: ffffa64e8aed3660 R08: 0000000000000064 R09:
> 0000000000000000
> <4>[310289.546449] R10: ffffffffa6e3b260 R11: ffffffffa5163a52 R12:
> ffff9fd2873dbc50
> <4>[310289.546451] R13: 0000000000046c00 R14: 0000000000000000 R15:
> 0000000000000000
> <4>[310289.546453] ? super_cache_scan+0x199/0x199
> <4>[310289.546457] shrink_slab+0xb3/0x37e
> <4>[310289.546460] shrink_node+0x377/0x110e
> <4>[310289.546464] ? sysvec_apic_timer_interrupt+0x17/0x80
> <4>[310289.546467] ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> <4>[310289.546471] try_to_free_pages+0x46e/0x857
> <4>[310289.546475] ? psi_task_change+0x7f/0x9c
> <4>[310289.546478] __alloc_pages_slowpath+0x4e2/0xe5c
> <4>[310289.546482] __alloc_pages+0x225/0x2a2
> <4>[310289.546486] __dma_direct_alloc_pages+0xed/0x1cb
> <4>[310289.546489] dma_direct_alloc_pages+0x21/0xa3
> <4>[310289.546493] dma_alloc_noncontiguous+0xd1/0x144
> <4>[310289.546496] snd_dma_noncontig_alloc+0x45/0xe3
> <4>[310289.546499] snd_dma_alloc_dir_pages+0x4f/0x81
> <4>[310289.546502] hda_cl_stream_prepare+0x66/0x15e
> [snd_sof_intel_hda_common (HASH:1255 1)]
> <4>[310289.546510] hda_dsp_cl_boot_firmware+0xc4/0x2ca
> [snd_sof_intel_hda_common (HASH:1255 1)]
> <4>[310289.546518] snd_sof_run_firmware+0xca/0x2d7 [snd_sof (HASH:ecd9 2)]
> <4>[310289.546526] ? hda_dsp_resume+0x97/0x1a7
> [snd_sof_intel_hda_common (HASH:1255 1)]
> <4>[310289.546534] sof_resume+0x155/0x251 [snd_sof (HASH:ecd9 2)]
> <4>[310289.546542] ? pci_pm_suspend+0x1e7/0x1e7
> <4>[310289.546546] dpm_run_callback+0x3c/0x132
> <4>[310289.546549] device_resume+0x1f7/0x282
> <4>[310289.546552] ? dpm_watchdog_set+0x54/0x54
> <4>[310289.546555] async_resume+0x1f/0x5b
> <4>[310289.546558] async_run_entry_fn+0x2b/0xc5
> <4>[310289.546561] process_one_work+0x1be/0x381
> <4>[310289.546564] worker_thread+0x20b/0x35b
> <4>[310289.546568] kthread+0xde/0xf7
> <4>[310289.546571] ? pr_cont_work+0x54/0x54
> <4>[310289.546574] ? kthread_blkcg+0x32/0x32
> <4>[310289.546577] ret_from_fork+0x1f/0x30
> <4>[310289.546580] </TASK>
> 
> <4>[171032.151834] <TASK>
> <4>[171032.151835] asm_sysvec_apic_timer_interrupt+0x16/0x20
> <4>[171032.151839] RIP: 0010:_raw_spin_unlock_irq+0x10/0x28
> <4>[171032.151842] Code: 2c 70 74 06 c3 cc cc cc cc cc 55 48 89 e5 e8
> 7e 30 2b ff 5d c3 cc cc cc cc cc 0f 1f 44 00 00 c6 07 00 fb 65 ff 0d
> af b1 2c 70 <74> 06 c3 cc cc cc cc cc 55 48 89 e5 e8 56 30 2b ff 5d c3
> cc cc cc
> <4>[171032.151844] RSP: 0018:ffff942447b334d8 EFLAGS: 00000286
> <4>[171032.151847] RAX: 0000000000000031 RBX: 0000000000000001 RCX:
> 0000000000000034
> <4>[171032.151849] RDX: 0000000000000031 RSI: 0000000000000002 RDI:
> ffffffff9103b1b0
> <4>[171032.151851] RBP: ffff942447b33660 R08: 0000000000000032 R09:
> 0000000000000010
> <4>[171032.151853] R10: ffffffff9103b370 R11: 00000000ffffffff R12:
> ffffffff9103b160
> <4>[171032.151855] R13: ffffd055000111c8 R14: 0000000000000000 R15:
> 0000000000000031
> <4>[171032.151858] evict_folios+0xf9e/0x1307
> <4>[171032.151861] ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> <4>[171032.151866] shrink_node+0x2e8/0x110e
> <4>[171032.151870] ? common_interrupt+0x1c/0x95
> <4>[171032.151872] ? common_interrupt+0x1c/0x95
> <4>[171032.151875] ? asm_common_interrupt+0x22/0x40
> <4>[171032.151878] ? __compaction_suitable+0x7c/0x9d
> <4>[171032.151882] try_to_free_pages+0x46e/0x857
> <4>[171032.151885] ? psi_task_change+0x7f/0x9c
> <4>[171032.151889] __alloc_pages_slowpath+0x4e2/0xe5c
> <4>[171032.151893] __alloc_pages+0x225/0x2a2
> <4>[171032.151896] __dma_direct_alloc_pages+0xed/0x1cb
> <4>[171032.151900] dma_direct_alloc_pages+0x21/0xa3
> <4>[171032.151903] dma_alloc_noncontiguous+0xd1/0x144
> <4>[171032.151907] snd_dma_noncontig_alloc+0x45/0xe3
> <4>[171032.151910] snd_dma_alloc_dir_pages+0x4f/0x81
> <4>[171032.151913] hda_cl_stream_prepare+0x66/0x15e
> [snd_sof_intel_hda_common (HASH:7df0 1)]
> <4>[171032.151921] hda_dsp_cl_boot_firmware+0xc4/0x2ca
> [snd_sof_intel_hda_common (HASH:7df0 1)]
> <4>[171032.151929] snd_sof_run_firmware+0xca/0x2d7 [snd_sof (HASH:9f20 2)]
> <4>[171032.151937] ? hda_dsp_resume+0x97/0x1a7
> [snd_sof_intel_hda_common (HASH:7df0 1)]
> <4>[171032.151945] sof_resume+0x155/0x251 [snd_sof (HASH:9f20 2)]
> <4>[171032.151953] ? pci_pm_suspend+0x1e7/0x1e7
> <4>[171032.151957] dpm_run_callback+0x3c/0x132
> <4>[171032.151960] device_resume+0x1f7/0x282
> <4>[171032.151962] ? dpm_watchdog_set+0x54/0x54
> <4>[171032.151965] async_resume+0x1f/0x5b
> <4>[171032.151968] async_run_entry_fn+0x2b/0xc5
> <4>[171032.151971] process_one_work+0x1be/0x381
> <4>[171032.151975] worker_thread+0x20b/0x35b
> <4>[171032.151978] kthread+0xde/0xf7
> <4>[171032.151981] ? pr_cont_work+0x54/0x54
> <4>[171032.151984] ? kthread_blkcg+0x32/0x32
> <4>[171032.151987] ret_from_fork+0x1f/0x30
> <4>[171032.151991] </TASK>

Thanks!

Both look like the code path via async PM resume.
Were both from the runtime PM resume?  Or the system resume?


Takashi

