Return-Path: <linux-kernel+bounces-108495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C960A880B35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83C11F22E15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407071947B;
	Wed, 20 Mar 2024 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fNUr1Rq2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vh1NHMWJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fNUr1Rq2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vh1NHMWJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7586182C5;
	Wed, 20 Mar 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916004; cv=none; b=Bn0k5ncRYeskm666JmEw9/ls7ySmr4slgnxIyB69XCgQ4ihSLHba4qXT8M5k9Nb9+fmZDCN5+3USJc9/LabiJm1PJGLsNnalvCdzKChDaR9zDYatmW/mcr7q2k+7q3i70yecRY4v4Ngfltc3KDAkcEtSKK04G73+BNtrzfKKLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916004; c=relaxed/simple;
	bh=zgiNS5kSRE57RflAj5hfF9Gbiby7TXllzWqa9MuopCw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcFDm8hALyJW46JpanZWqou7mstLAwQGK0lnx/rrrqsH5VLm0waU4xlQBt/WuzEV2yNUQXF1dObGRPk6tiHqz3rGmeyCp0DzM7PO631ZVGsQMB9vBJ2UAIMAhrkCHB4E9KQkTGXExARBI7OuYpS17rsvYt7TI5L0BLsdjcwjWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fNUr1Rq2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vh1NHMWJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fNUr1Rq2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vh1NHMWJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DED12253D;
	Wed, 20 Mar 2024 06:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710916000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8J+vw6nLkJZ0lyhlz6Wx+SAlBStCeQSVt5Pw4Jr21A=;
	b=fNUr1Rq2PrDxKs68waBsnAHNjoLyzuz3OuUBfarQSudlspprZUt+wcw4kYHSXSC2r75SwC
	6V7Si9y02JpyZT16933FYJzxi0rIRvw//Uh/C+jdDMDwYGyVopHq6u323l7oM7DN4H3BPJ
	mHa6oW1mt0s1R+hyRgdUgOKIP/jOCms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710916000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8J+vw6nLkJZ0lyhlz6Wx+SAlBStCeQSVt5Pw4Jr21A=;
	b=Vh1NHMWJ2BoRwuCiWzfqaFBXdmHQ8s0yGN5rABkTYMRRSjzwl5JFmFdxhU96Ichy2iQt9c
	O7MzlvLYjXl4QLAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710916000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8J+vw6nLkJZ0lyhlz6Wx+SAlBStCeQSVt5Pw4Jr21A=;
	b=fNUr1Rq2PrDxKs68waBsnAHNjoLyzuz3OuUBfarQSudlspprZUt+wcw4kYHSXSC2r75SwC
	6V7Si9y02JpyZT16933FYJzxi0rIRvw//Uh/C+jdDMDwYGyVopHq6u323l7oM7DN4H3BPJ
	mHa6oW1mt0s1R+hyRgdUgOKIP/jOCms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710916000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8J+vw6nLkJZ0lyhlz6Wx+SAlBStCeQSVt5Pw4Jr21A=;
	b=Vh1NHMWJ2BoRwuCiWzfqaFBXdmHQ8s0yGN5rABkTYMRRSjzwl5JFmFdxhU96Ichy2iQt9c
	O7MzlvLYjXl4QLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4378C136D6;
	Wed, 20 Mar 2024 06:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yj7aDqCB+mVuGQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 20 Mar 2024 06:26:40 +0000
Date: Wed, 20 Mar 2024 07:26:39 +0100
Message-ID: <87wmpxto4g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Curtis Malainey <cujomalainey@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] alsa: KMEMLEAK in pulseaudio and alsa-sink-ALC89
In-Reply-To: <c1e2ef3c-164f-4840-9b1c-f7ca07ca422a@alu.unizg.hr>
References: <c1e2ef3c-164f-4840-9b1c-f7ca07ca422a@alu.unizg.hr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fNUr1Rq2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Vh1NHMWJ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.54 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.976];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.03)[87.54%]
X-Spam-Score: -1.54
X-Rspamd-Queue-Id: 7DED12253D
X-Spam-Flag: NO

On Wed, 20 Mar 2024 02:13:08 +0100,
Mirsad Todorovac wrote:
> 
> Hi,
> 
> On Ubuntu 22.04 LTS, with the torvalds tree kernel vanilla v6.8-11167-g4438a810f396,
> there is like 660K memory leaks sized 2048 bytes (1.35 GB)
> 
> unreferenced object 0xffff919c43c7c800 (size 2048):
> unreferenced object 0xffff919c43c78000 (size 2048):
> unreferenced object 0xffff919c43c79800 (size 2048):
> root@defiant:/home/marvin/linux/kernel/linux_torvalds# grep size ~marvin/linux/kernel_bugs/v6.8-11167/kmemleak.log | wc -l
> 663265
> root@defiant:/home/marvin/linux/kernel/linux_torvalds#
> 
> Please find the .config attached.
> 
> The kmemleak output is:
> 
> unreferenced object 0xffff9199526ba800 (size 2048):
>   comm "pulseaudio", pid 2533, jiffies 4294900352
>   hex dump (first 32 bytes):
>     04 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
>     49 45 43 39 35 38 20 50 6c 61 79 62 61 63 6b 20  IEC958 Playback
>   backtrace (crc 87c1dcdc):
>     [<ffffffffb2fa477b>] kmemleak_alloc+0x4b/0x90
>     [<ffffffffb210e517>] __kmalloc_node_track_caller+0x3c7/0x530
>     [<ffffffffb20a102b>] memdup_user+0x2b/0xb0
>     [<ffffffffc0746d56>] snd_ctl_ioctl+0x726/0x860 [snd]
>     [<ffffffffb21bed6d>] __x64_sys_ioctl+0x9d/0xe0
>     [<ffffffffb2f93d33>] do_syscall_64+0x83/0x150
>     [<ffffffffb3000121>] entry_SYSCALL_64_after_hwframe+0x6c/0x74

Thanks for the report.  This was indeed an overlooked marking of
__free(kfree).  I'll submit the fix patch.


Takashi

