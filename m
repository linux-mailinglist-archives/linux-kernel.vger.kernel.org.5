Return-Path: <linux-kernel+bounces-162213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8D8B579F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218B81C22E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787DE54FAB;
	Mon, 29 Apr 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r7wHopYS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v6PkS9iC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r7wHopYS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v6PkS9iC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3205537FA;
	Mon, 29 Apr 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392693; cv=none; b=jrcAlwmUbkwD32QWIu3Kv23anThx8giM8EU0nANkmgq/n+wh4XTJlqxeBIuWtgAoE0KlVKzMCojAEQ8Vs8ZUmJkWeMOtHGlWbwWKjB/n7vV/cKG0/JiFbdRyo6rlIfCbTT6PKlh3b+mVTbRj/isy5z8WdXdsKDj7NqjN5zhsdjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392693; c=relaxed/simple;
	bh=Kv9UVoqr4FPtC8ayOP5lsOjpRRdbK3TbUzE2L4pIu3c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gj6jZ29HLPg2clDMoZUf1wHLA8qqwOkxH1vDX3AHnz8mZMsvjucm0Y3jowf+HuS0LpFjYXMN0Y3o1r3/s9sb1eJf0BqgwBygn+7MJc0+y1EREGCd7lkNxht6/TC2bbvLd9LPZm4Tuh4W5csJHe3fDkOlUUKUCD8iUsS4GNY2JpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r7wHopYS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v6PkS9iC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r7wHopYS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v6PkS9iC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 227723373E;
	Mon, 29 Apr 2024 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714392690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZnWgq4tXzT/pnbV9TmhzqgQBTHbr85kNIzhNWX8X4Q=;
	b=r7wHopYSw64Ks0Q94uS2D/MljcGTpCE5Wd5xQUBqEiafxM0l1mAvPGo01+ZyWBBc6URMsX
	8x3KvUIv/4MXVln7irBteQ03i+kt8xKMzS9DSYCN7Y0Oe9deAJYhwlDaj5XvnrjlFbdw9D
	RaCJqBhUTGAGHtdY8EnqTv5/L1g7xXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714392690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZnWgq4tXzT/pnbV9TmhzqgQBTHbr85kNIzhNWX8X4Q=;
	b=v6PkS9iCjsDfJlMRAseJm2xGdpPi4HY7EH/zD9Dne+kRlONHO0sE5M79hOZmpNAU8s5h8Y
	bCFZaPNgPMHnnxDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714392690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZnWgq4tXzT/pnbV9TmhzqgQBTHbr85kNIzhNWX8X4Q=;
	b=r7wHopYSw64Ks0Q94uS2D/MljcGTpCE5Wd5xQUBqEiafxM0l1mAvPGo01+ZyWBBc6URMsX
	8x3KvUIv/4MXVln7irBteQ03i+kt8xKMzS9DSYCN7Y0Oe9deAJYhwlDaj5XvnrjlFbdw9D
	RaCJqBhUTGAGHtdY8EnqTv5/L1g7xXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714392690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZnWgq4tXzT/pnbV9TmhzqgQBTHbr85kNIzhNWX8X4Q=;
	b=v6PkS9iCjsDfJlMRAseJm2xGdpPi4HY7EH/zD9Dne+kRlONHO0sE5M79hOZmpNAU8s5h8Y
	bCFZaPNgPMHnnxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A05A139DE;
	Mon, 29 Apr 2024 12:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id il5OJHGOL2bmVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Apr 2024 12:11:29 +0000
Date: Mon, 29 Apr 2024 14:11:41 +0200
Message-ID: <87jzkgpdvm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: ManuLinares <mbarriolinares@gmail.com>
Cc: alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	dengxiang <dengxiang@nfschina.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Max McCarthy <mmccarthy@mcintoshlabs.com>,
	WhaleChang <whalechang@google.com>,
	Lukasz Tyl <ltyl@hem-e.com>,
	Jeremie Knuesel <knuesel@gmail.com>,
	Alexander Tsoy <alexander@tsoy.me>,
	Jussi Laako <jussi@sonarnerd.net>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add sampling rates support for Mbox3
In-Reply-To: <20240428005733.202978-1-mbarriolinares@gmail.com>
References: <20240428005733.202978-1-mbarriolinares@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[alsa-project.org,perex.cz,suse.com,nfschina.com,gmail.com,mcintoshlabs.com,google.com,hem-e.com,tsoy.me,sonarnerd.net,vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Sun, 28 Apr 2024 02:57:29 +0200,
ManuLinares wrote:
> 
> This adds support for all sample rates supported by the hardware,
> Digidesign Mbox 3 supports: {44100, 48000, 88200, 96000}
> 
> Fixes syncing clock issues that presented as pops. To test this, without
> this patch playing 440hz tone produces pops.
> 
> Clock is now synced between playback and capture interfaces so no more
> latency drift issue when using pipewire pro-profile.
> (https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3900)
> 
> Signed-off-by: ManuLinares <mbarriolinares@gmail.com>
(snip)
> -	dev_dbg(&dev->dev, "device initialised!\n");
> +	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
>  
>  	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
>  		&dev->descriptor, sizeof(dev->descriptor));
>  	config = dev->actconfig;
> -	if (err < 0)
> -		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
> +	if (err < 0) 

You put a tailing sparce superfluously.

> +		dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
>  
>  	err = usb_reset_configuration(dev);
> -	if (err < 0)
> -		dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
> -	dev_dbg(&dev->dev, "mbox3_boot: new boot length = %d\n",
> +	if (err < 0) 

Ditto.  Try to run checkpatch.pl at the next time; it should warn you
such errors.

(snip)
> +static void mbox3_set_format_quirk(struct snd_usb_substream *subs,
> +									const struct audioformat *fmt)
> +{
> +	// Set rate only for one interface
> +	//u8 iface = subs->data_endpoint->iface;
> +	//if (iface != 2) return;
> +
> +	u8 buffer[4] = {0};
> +	u32 new_rate = subs->data_endpoint->cur_rate;

Let's to be classic: try to put the variable definitions at the begin
of the function.

(snip)
> +	__le32 set_rate = cpu_to_le32(new_rate);

Ditto.

(snip)
> +	// Check whether the change was successful
> +	buffer[0] = 0; buffer[1] = 0; buffer[2] = 0; buffer[3] = 0;

You can use memset().  (Or if it were a __le32 variable, it can be
simply zero assignment.)

> +	snd_usb_ctl_msg(subs->dev,
> +					usb_sndctrlpipe(subs->dev, 0),
> +					0x01, 0x21 | USB_DIR_IN, 0x0100, 0x8101, &buffer, 4);
> +	//set_rate = *(int *)buffer;
> +	set_rate = le32_to_cpu(*(u32 *)buffer);

Strictly speaking, this won't work always as no alignment is
guaranteed for char[4].  If you need to pass/receive a 4-byte integer,
better to use a __le32 variable instead.  For a one-byte temporary
buffer, you can use another variable additionally.

Could you resubmit with those corrections?


thanks,

Takashi

