Return-Path: <linux-kernel+bounces-163374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E33C8B6A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C266B21DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523A17742;
	Tue, 30 Apr 2024 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OboWkcJh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yEwtqMNT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G/QHuCZI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ype4VZjS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB912F2B;
	Tue, 30 Apr 2024 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456258; cv=none; b=aCKrbnL7ivmFg2vhx+X90SxAU4RJTABiRzKy+q3M9pPswms2zJ9wUOy33CPY/ly5fsxwHejZAai4n2SAxagMaxhGY4cSjMPquopsYx+Ck3VcEMVm0bdCxcz3nUzk4ugFrLNLUlDAKoS4ISM2N1M14guf2gz84eV+adTkoBSHbDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456258; c=relaxed/simple;
	bh=Suy6r87IABRjXRU+C7VTJw1MFooD3kedF/TBBB8HN0k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bj2qRUPJxZ02MvFRD1krO1fRtk9jSAkycxsB2q2PJBaiZ063WS5OCDdp54SicYfqk/ri6/8z08ACtK/i+Vu6QKxuJ6yLgwe0M2QujkD4T/p/dl+dU+/yd6wqBNq0Lv1r9Omv/7wSBVxZd2C7RAmfj+/l6Wju0fj7DPUA2RSZZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OboWkcJh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yEwtqMNT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G/QHuCZI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ype4VZjS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3C5E1F7B7;
	Tue, 30 Apr 2024 05:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714456254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MOX4b9BEaGZXattqGbYFhMplO9EQj4scGgE/7pbr98=;
	b=OboWkcJh0tkVzZWIb7jBbO1u5KLgDoTIULlIBLI0L2no9vsL9IwX6OJwzjrf2aYdIhzxli
	qJUR+g4F2IMkAs0Z3WEwOtY2x1NOsSFl/EedvYpI9JHSxRveTFqwW5r426Dmvy1/0MglQN
	oTUK25A6oW243l0Dxm6vengkOHcDiTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714456254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MOX4b9BEaGZXattqGbYFhMplO9EQj4scGgE/7pbr98=;
	b=yEwtqMNTNFymgJ8nsvsgn7MS8fjOfC7ZJge2qN44deGNyxciChOXvgroEoiR/78VmEgpbD
	3xFCszkBn6Vss7CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714456253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MOX4b9BEaGZXattqGbYFhMplO9EQj4scGgE/7pbr98=;
	b=G/QHuCZImZwmNED3M9b14Lz1YUHGpeFUix3SvlptIIPKujjoQeqc0GIWqvOpnvDY90Wv8B
	h4lUzHeGkoaEurOYkqRjkjhqR9+jvvFb0+wapzO3oQ6Ke5qDFU9vXroA+gmJUvAfCuzGNG
	39yrxABTaBIfRSn4eAvRSqJ9TG/UZI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714456253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MOX4b9BEaGZXattqGbYFhMplO9EQj4scGgE/7pbr98=;
	b=ype4VZjSSO3JjI+H1ArFysZMnWLt8oUpZCY5CsnhInZufPReMCA0IbACe7mMLRi94OQDNk
	s4OgzRbbGUmCXrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5D1B138A7;
	Tue, 30 Apr 2024 05:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sx8TL7yGMGaCEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Apr 2024 05:50:52 +0000
Date: Tue, 30 Apr 2024 07:51:05 +0200
Message-ID: <87jzkfo0ty.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	linux-sound@vger.kernel.org
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592 decrease 30% of gaming performance
In-Reply-To: <CABXGCsP-e5CjqCFztiym=zjQ=Z00uxYcQPFACEbTwjV=BHEdJQ@mail.gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 30 Apr 2024 01:00:07 +0200,
Mikhail Gavrilov wrote:
> 
> On Wed, Apr 24, 2024 at 6:42 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > That said, maybe the first thing you can try would be to check who is
> > actually calling the corresponding function
> > (snd_timer_close_locked()).  Put a debug print or a tracing hook to
> > watch out for figuring out.  If the commit was really relevant, it
> > must be called very frequently and concurrently, and I don't know
> > really who does it except for dmix/dsnoop.
> >
> 
> It's madness.
> Yes I added printk to snd_timer_close_locked and saw that function
> invoked only 3 times when the system booted.
> And never invoked during benchmark.
> 
> > git diff
> diff --git a/Makefile b/Makefile
> index 40fb2ca6fe4c..3ecff79a23b8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2,7 +2,7 @@
>  VERSION = 6
>  PATCHLEVEL = 9
>  SUBLEVEL = 0
> -EXTRAVERSION = -rc6
> +EXTRAVERSION = -rc6-test-build
>  NAME = Hurr durr I'ma ninja sloth
> 
>  # *DOCUMENTATION*
> diff --git a/sound/core/timer.c b/sound/core/timer.c
> index 4d2ee99c12a3..59d8e4698b0b 100644
> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
> @@ -407,7 +407,7 @@ static void snd_timer_close_locked(struct
> snd_timer_instance *timeri,
>                                    struct device **card_devp_to_put)
>  {
>         struct snd_timer *timer = timeri->timer;
> -
> +       printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>         if (timer) {
>                 guard(spinlock_irq)(&timer->lock);
>                 timeri->flags |= SNDRV_TIMER_IFLG_DEAD;
> 
> [Tue Apr 30 03:33:25 2024] igc 0000:0a:00.0 eno1: NIC Link is Up 1000
> Mbps Full Duplex, Flow Control: RX/TX
> [Tue Apr 30 03:33:33 2024] rfkill: input handler disabled
> [Tue Apr 30 03:33:36 2024] DEBUG: Passed snd_timer_close_locked 410
> [Tue Apr 30 03:33:36 2024] Bluetooth: RFCOMM TTY layer initialized
> [Tue Apr 30 03:33:36 2024] Bluetooth: RFCOMM socket layer initialized
> [Tue Apr 30 03:33:36 2024] Bluetooth: RFCOMM ver 1.11
> [Tue Apr 30 03:33:51 2024] systemd-journald[949]:
> /var/log/journal/1b6a399fb0874de8b095a739fe2ff323/user-1000.journal:
> Journal file uses a different sequence number ID, rotating.
> [Tue Apr 30 03:33:52 2024] rfkill: input handler enabled
> [Tue Apr 30 03:33:55 2024] DEBUG: Passed snd_timer_close_locked 410
> [Tue Apr 30 03:33:55 2024] rfkill: input handler disabled
> [Tue Apr 30 03:33:57 2024] input: solaar-keyboard as
> /devices/virtual/input/input18
> [Tue Apr 30 03:34:08 2024] DEBUG: Passed snd_timer_close_locked 410
> [Tue Apr 30 03:34:11 2024] input: Noble FoKus Mystique (AVRCP) as
> /devices/virtual/input/input19
> [Tue Apr 30 03:34:23 2024] show_signal: 8 callbacks suppressed
> [Tue Apr 30 03:34:23 2024] traps: gldriverquery[4464] general
> protection fault ip:7ff83958c76f sp:7ffc464e0e00 error:0 in
> libLLVM.so.18.1[7ff83920c000+3afd000]
> [Tue Apr 30 03:34:25 2024] workqueue: gc_worker [nf_conntrack] hogged
> CPU for >10000us 5 times, consider switching to WQ_UNBOUND
> [Tue Apr 30 03:34:26 2024] workqueue: gc_worker [nf_conntrack] hogged
> CPU for >10000us 7 times, consider switching to WQ_UNBOUND
> [Tue Apr 30 03:35:27 2024] workqueue: gc_worker [nf_conntrack] hogged
> CPU for >10000us 11 times, consider switching to WQ_UNBOUND
> [Tue Apr 30 03:36:28 2024] workqueue: gc_worker [nf_conntrack] hogged
> CPU for >10000us 19 times, consider switching to WQ_UNBOUND
> [Tue Apr 30 03:39:33 2024] workqueue: gc_worker [nf_conntrack] hogged
> CPU for >10000us 35 times, consider switching to WQ_UNBOUND
> 
> I saw a similar picture with ftrace.
> I had no experience with ftrace, so I am laying out everything here
> for you to see if I am doing something wrong or not.
> 
> # echo "snd_timer_close_locked" > /sys/kernel/tracing/set_ftrace_filter
> 
> # echo "function" > /sys/kernel/tracing/current_tracer
> 
> # echo 1 > /sys/kernel/tracing/tracing_on
> 
> /*  Benchmark the game here  */
> 
> # echo 0 > /sys/kernel/tracing/tracing_on
> 
> # cat /sys/kernel/tracing/trace
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
> # cat /sys/kernel/tracing/set_ftrace_filter
> snd_timer_close_locked [snd_timer]
> 
> Now I am tormented by the question: how can reverting code that is not
> invoked directly during a benchmark affect the benchmark result so
> much?

It implies that it's not about the revert that influences on the
result.  It might be rather the fact that you built the kernel by
yourself.  Try to build the kernel again with a debug print but
without the revert of the spinlock.  Does it still show the same
improvement?  If so, try again without the debug print and retest.


Takashi

