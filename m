Return-Path: <linux-kernel+bounces-90181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC7886FB71
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275B21F22B6D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C71756B;
	Mon,  4 Mar 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l01HFlZd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UnWQ2m0D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Elb81x4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F8siSzGl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06920171A6;
	Mon,  4 Mar 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540124; cv=none; b=aZmmbiuwuZQDwoEXIvE+GSneT+UN7dMRCJtWKzfQLCagZCyLVaJxs82fEOpX8UVo1pbYRMqqzhSqw1u73AEDt11HE2nXeY2siv6+jMhOcGBpgWv69Ef+vmTJnhCRmEEMFOdNoYCxSGungrYOqMqpeBTuO/QbWrWRbA2n7BZSvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540124; c=relaxed/simple;
	bh=xtDY+koMXDOcmDgkQrKSlKFln0oMOLNo/L29ZJxzVeQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZbtb0lNQ4bw2BfpseYHZnGfWuGHXDSH1wDmDcztRBeJQidYYlRknJ1577E7pknFwClnVPStIurPmEZHdTUf4ywk9ORoDSYZl/22KQ3FhVnEAtN5Bd3xw/hrfNq4slZk2f8JTkOX6FsIjiyLIWrYDlfngfD7/YMBNzWwV8+/WwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l01HFlZd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UnWQ2m0D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Elb81x4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F8siSzGl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E61D68794;
	Mon,  4 Mar 2024 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709540120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZt+Y+jfJVrXUNZn7FxYOJsCw8lVDDLyEEI3tfW+wdA=;
	b=l01HFlZdasj9oN+RdZfW0U5Qxnkwx5VWOpEopaOuByLsG4FYwE+led8RyFlhlGNjqY7PWv
	Otj6m71Vbn0hxwy4u2KQa3ZHLcfbykfXlTCrkRQE3Ay3MGARUOf0JO3lGyQeEDFzCU2Fly
	Sl/9WBS962eyQYchPnFA86i0krMOsng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709540120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZt+Y+jfJVrXUNZn7FxYOJsCw8lVDDLyEEI3tfW+wdA=;
	b=UnWQ2m0D6dQL6klQrLpEWBfm+ew581DQhzms8MGBRDpSa39sCDgu7bkdTJPl54iry9Pmfk
	9UO8413tBhM1LVCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709540119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZt+Y+jfJVrXUNZn7FxYOJsCw8lVDDLyEEI3tfW+wdA=;
	b=Elb81x4XwxrV9Wc5XW3o2xoi28pS0clJZ5FlJGTgg8Yd91MSXqqgdf9mct5l5fBWOWByip
	C+VvnKLAgWRB9K2YuNsWPi9Grv6nbIMjyDpfabn4i1mmOXKiOGftAg+hyOXHhC9+wkd7ld
	BvTlLHqsR15ZScp8bDDi6GCa6DK9sY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709540119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZt+Y+jfJVrXUNZn7FxYOJsCw8lVDDLyEEI3tfW+wdA=;
	b=F8siSzGlhgNh6ms8aTZQqgBluIbm2Vuy0W4McJzpfWmddtrlNJ+CoS5oeo9KHZv9Hy+b98
	VnOhUcqhNgfhl2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C670E13A58;
	Mon,  4 Mar 2024 08:15:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GA0CLxaD5WVfaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 Mar 2024 08:15:18 +0000
Date: Mon, 04 Mar 2024 09:15:18 +0100
Message-ID: <871q8q2z1l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kenny Levinsen <kl@kl.wtf>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Name feature ctl using output if input is PCM
In-Reply-To: <20240301231107.42679-1-kl@kl.wtf>
References: <20240301231107.42679-1-kl@kl.wtf>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Elb81x4X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F8siSzGl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 0E61D68794
X-Spam-Flag: NO

On Sat, 02 Mar 2024 00:11:07 +0100,
Kenny Levinsen wrote:
> 
> When building feature controls from a unit without a name, we try to
> derive a name first from the feature unit's input, then fall back to the
> output terminal.
> 
> If a feature unit connects directly to a "USB Streaming" input terminal
> rather than a mixer or other virtual type, the control receives the
> somewhat meaningless name "PCM", even if the output had a descriptive
> type such as "Headset" or "Speaker".
> 
> Here is an example of such AudioControl descriptor from a USB headset
> which ends up named "PCM Playback" and is therefore not recognized as
> headphones by userspace:
> 
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             4
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          5
>         bNrChannels             2
>         wChannelConfig     0x0003
>           Left Front (L)
>           Right Front (R)
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             5
>         wTerminalType      0x0402 Headset
>         bAssocTerminal          4
>         bSourceID               6
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                13
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                 6
>         bSourceID               4
>         bControlSize            2
>         bmaControls(0)     0x0002
>           Volume Control
>         bmaControls(1)     0x0000
>         bmaControls(2)     0x0000
>         iFeature                0
> 
> Other headsets and DACs I tried that used their output terminal for
> naming only did so due to their input being an unnamed sidetone mixer.
> 
> Instead of always starting with the input terminal, check the type of it
> first. If it seems uninteresting, invert the order and use the output
> terminal first for naming.
> 
> This makes userspace recognize headsets with simple controls as
> headphones, and leads to more consistent naming of playback devices
> based on their outputs irrespective of sidetone mixers.
> 
> Signed-off-by: Kenny Levinsen <kl@kl.wtf>

Thanks, applied now to for-next branch.


Takashi

