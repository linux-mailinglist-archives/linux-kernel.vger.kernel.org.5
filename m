Return-Path: <linux-kernel+bounces-163902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ADF8B757C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961C71F22732
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D9913D624;
	Tue, 30 Apr 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qwNc6rkY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZsGFxiLM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qwNc6rkY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZsGFxiLM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855D168A9;
	Tue, 30 Apr 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479135; cv=none; b=Qy7FhSwvFi/qvrvnJVVGAH+VkZ7Bx13sZQRXmFMUtARIfpmQr0czCqRJI8aRh+kcVbzDoC3nGZh9FTBAWh05FT3lTQYlKfu74AiC520xLkSgCfYF8WpzygVexFLat8I52tPrTtYlO8271bxSVWHHg4ItCxyLhBC1W8PlWFAcxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479135; c=relaxed/simple;
	bh=hJm9DDBBeDPeOGhUdgcevRiGerimoe1kP5QSDiYDWt4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdLDoiirJb7WZdv1shmcvmJ8+/PImcxx/9fFEGskWbXQcOn/WNgU++9SW1/NH8CM+vXaHlEhTzZUb7HfeN4aOe/6XQXnf+iWejIjT9/kfA693MMXzpq+SIV6FlnTFsJGJtBV4k10YxbPBiNPA1mwNaD0bvM6Qzv7nCewEObvokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qwNc6rkY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZsGFxiLM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qwNc6rkY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZsGFxiLM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE34533FC3;
	Tue, 30 Apr 2024 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714479131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYzILj7G3DDHTdpeslHvGKR36PqiiumYG/XzPBAZkPk=;
	b=qwNc6rkYl95dVOBqRQzy+uG4A8MXJj7kkQZrRPRmpfGaIgMrayOUUkFdi20F1kDGv0DDwv
	eKIc4ZbNCiQu8p00oiX8rhS+USrxuYY62ZcIVAR4pzIkqHxexc2Pz+mJHSdpJc1l2cBF73
	ObDfwNUzZ/IUxZQBti7reE9pVLYUVPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714479131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYzILj7G3DDHTdpeslHvGKR36PqiiumYG/XzPBAZkPk=;
	b=ZsGFxiLM81pMLOrrkbgBDdqt/aimWCGbMJWQvIF8NcneepHLCeex8Doivb6E+i1GVAnhPL
	o+bhytX8yIaPukDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714479131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYzILj7G3DDHTdpeslHvGKR36PqiiumYG/XzPBAZkPk=;
	b=qwNc6rkYl95dVOBqRQzy+uG4A8MXJj7kkQZrRPRmpfGaIgMrayOUUkFdi20F1kDGv0DDwv
	eKIc4ZbNCiQu8p00oiX8rhS+USrxuYY62ZcIVAR4pzIkqHxexc2Pz+mJHSdpJc1l2cBF73
	ObDfwNUzZ/IUxZQBti7reE9pVLYUVPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714479131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYzILj7G3DDHTdpeslHvGKR36PqiiumYG/XzPBAZkPk=;
	b=ZsGFxiLM81pMLOrrkbgBDdqt/aimWCGbMJWQvIF8NcneepHLCeex8Doivb6E+i1GVAnhPL
	o+bhytX8yIaPukDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 966EC136A8;
	Tue, 30 Apr 2024 12:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qkC4IxvgMGa+GAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Apr 2024 12:12:11 +0000
Date: Tue, 30 Apr 2024 14:12:23 +0200
Message-ID: <87r0enm4m0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	linux-sound@vger.kernel.org
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592 decrease 30% of gaming performance
In-Reply-To: <CABXGCsMPLWm8xVZ3mk-e8FJht4FjdxEREov0DFKMooMD0BvRyw@mail.gmail.com>
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
	<874jcl7e83.wl-tiwai@suse.de>
	<CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
	<87v851e2di.wl-tiwai@suse.de>
	<CABXGCsNMBRUaY-V8mhUQKdq+CQW5+eGUWL_YCJWXo0cgh9bGJQ@mail.gmail.com>
	<87h6glt9zc.wl-tiwai@suse.de>
	<CABXGCsMcazRvmiN4XtiHQCE9=dB=M=VsRqB=v+RPmtuhBL29DA@mail.gmail.com>
	<a6f4e20ea2a68f56a7d2c4d76280bca44d6bf421.camel@gmail.com>
	<CABXGCsPdqfXeZUw1ocx8O3NdOEb+h4yQ77+zdNpcwP_4JrYXuQ@mail.gmail.com>
	<CABXGCsMTbmU4CP8CHUqRVXWkGiErFtEVG4COy6RSRWsAuK_-CQ@mail.gmail.com>
	<87pluedgx5.wl-tiwai@suse.de>
	<87jzkmdghh.wl-tiwai@suse.de>
	<CABXGCsP-e5CjqCFztiym=zjQ=Z00uxYcQPFACEbTwjV=BHEdJQ@mail.gmail.com>
	<87jzkfo0ty.wl-tiwai@suse.de>
	<CABXGCsMPLWm8xVZ3mk-e8FJht4FjdxEREov0DFKMooMD0BvRyw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 30 Apr 2024 12:54:36 +0200,
Mikhail Gavrilov wrote:
> 
> On Tue, Apr 30, 2024 at 10:50 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > It implies that it's not about the revert that influences on the
> > result.  It might be rather the fact that you built the kernel by
> > yourself.  Try to build the kernel again with a debug print but
> > without the revert of the spinlock.
> 
> It was built without reverting the spinlock.
> With revert in the kernel log appears "WARNING: possible irq lock
> inversion dependency detected"

Where and how...?  That important piece is missing in you info...
And, it's likely a false-positive detection by lockdep.

When you disable lockdep, does it still show any performance down?


Takashi

> I suppose commit 587d67fd929a fixes just this.
> About calls of snd_timer_close_locked, I again see only 3 invokes when
> the system booted:
> [Tue Apr 30 15:09:40 2024] igc 0000:0a:00.0 eno1: NIC Link is Up 1000
> Mbps Full Duplex, Flow Control: RX/TX
> [Tue Apr 30 15:09:42 2024] input: Denon PerL Pro 772 (AVRCP) as
> /devices/virtual/input/input18
> [Tue Apr 30 15:09:45 2024] rfkill: input handler disabled
> [Tue Apr 30 15:09:49 2024] Bluetooth: RFCOMM TTY layer initialized
> [Tue Apr 30 15:09:49 2024] Bluetooth: RFCOMM socket layer initialized
> [Tue Apr 30 15:09:49 2024] Bluetooth: RFCOMM ver 1.11
> [Tue Apr 30 15:09:49 2024] DEBUG: Passed snd_timer_close_locked 410
> [Tue Apr 30 15:09:51 2024] systemd-journald[947]:
> /var/log/journal/1b6a399fb0874de8b095a739fe2ff323/user-1000.journal:
> Journal file uses a different sequence number ID, rotating.
> [Tue Apr 30 15:09:52 2024] rfkill: input handler enabled
> [Tue Apr 30 15:09:55 2024] DEBUG: Passed snd_timer_close_locked 410
> [Tue Apr 30 15:09:55 2024] rfkill: input handler disabled
> [Tue Apr 30 15:09:55 2024] input: Denon PerL Pro 772 (AVRCP) as
> /devices/virtual/input/input19
> [Tue Apr 30 15:09:57 2024] input: solaar-keyboard as
> /devices/virtual/input/input20
> [Tue Apr 30 15:10:08 2024] DEBUG: Passed snd_timer_close_locked 410
> [Tue Apr 30 15:10:23 2024] show_signal_msg: 8 callbacks suppressed
> [Tue Apr 30 15:10:23 2024] gldriverquery[4423]: segfault at 0 ip
> 0000000000000000 sp 00007fff2ee18c38 error 14 in
> gldriverquery[55c135c00000+14000] likely on CPU 11 (core 11, socket 0)
> [Tue Apr 30 15:10:23 2024] Code: Unable to access opcode bytes at
> 0xffffffffffffffd6.
> [Tue Apr 30 15:10:40 2024] workqueue: gc_worker [nf_conntrack] hogged
> CPU for >10000us 7 times, consider switching to WQ_UNBOUND
> [Tue Apr 30 15:10:40 2024] workqueue: gc_worker [nf_conntrack] hogged
> CPU for >10000us 11 times, consider switching to WQ_UNBOUND
> 
> And no invokes during benchmark.
> root@primary-ws ~# cat /sys/kernel/tracing/trace
> # tracer: function
> #
> # entries-in-buffer/entries-written: 0/0   #P:32
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
> 
> I attached here two kernel logs both with printk debug. One is clean
> 6.9.0-rc6 the other 6.9.0-rc6 with revert 587d67fd929a.
> I didn't see any difference between kernel logs.
> I only see that without 587d67fd929a at some point a possible irq lock
> inversion dependency is detected and the benchmark improves results up
> to 30%.
> 
> -- 
> Best Regards,
> Mike Gavrilov.
> 
> 

