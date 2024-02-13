Return-Path: <linux-kernel+bounces-63584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B641A8531C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97BF1C267D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076B55C22;
	Tue, 13 Feb 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h0USkYV6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ao4sOlJT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h0USkYV6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ao4sOlJT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E55731C;
	Tue, 13 Feb 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830707; cv=none; b=DfHbXDLXDoR32weizi/8la0BCpfQuokAL4gj8kdTEbHkh13gCNb+kCwGIiKSIA+Y89l/pEwTDAyBmYSG6N7A6l9fM7hXnEQTWKOHeiKdV+RR9jbln4Go0qwJHUa/ZOefu6znQR8+F/lIPGBPiTojP1rIK08lQhzk5fRTP5YeoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830707; c=relaxed/simple;
	bh=dxV7yHCJnIxpEzKaYuqJa05MJzzLK6w5HSkoqNeVti0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+xJCMslnkC51J3LAGV4vkklTy1qXUdE05cFN8gRiZ2fzYEQzaMm04T5TgdNk1LJ46d2rggBxiNjQ3vVDVpglZBv8V6XrJ5gyoGQ2B4PUScOCAgrfeO2gutv6XxVXGRne4p3vsiPH/6OCx5xaHJTZEWQswu17hwJCuYern+vIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h0USkYV6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ao4sOlJT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h0USkYV6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ao4sOlJT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B3A61FCDC;
	Tue, 13 Feb 2024 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707830704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEb4Pp5ybhqZlBe29kJk+TL0hsuA4yQuqt0dPmfwv2w=;
	b=h0USkYV6jS8NTxaKCmrgXueBzsy0r2NJNtekWIiwqy+Kn8fnc0EPwj/mBwflutQOdYX6pm
	JJARrq9nonTl0UJVYfEEOV6mX3fd/YTi88blqeL3s9jshk3ZcLj3wkyUcPLeWUyiS0qDTN
	b4k+m9T9J8hbs3lTbeUitHVY7bpsNpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707830704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEb4Pp5ybhqZlBe29kJk+TL0hsuA4yQuqt0dPmfwv2w=;
	b=Ao4sOlJTipA5MewrKL1mm1xCT2xiOuzTbe1wkY1MMFOKzpoAHV+ykGdvSxHhFr6JgYF/HI
	ByCHgkR2OeLzxeAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707830704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEb4Pp5ybhqZlBe29kJk+TL0hsuA4yQuqt0dPmfwv2w=;
	b=h0USkYV6jS8NTxaKCmrgXueBzsy0r2NJNtekWIiwqy+Kn8fnc0EPwj/mBwflutQOdYX6pm
	JJARrq9nonTl0UJVYfEEOV6mX3fd/YTi88blqeL3s9jshk3ZcLj3wkyUcPLeWUyiS0qDTN
	b4k+m9T9J8hbs3lTbeUitHVY7bpsNpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707830704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEb4Pp5ybhqZlBe29kJk+TL0hsuA4yQuqt0dPmfwv2w=;
	b=Ao4sOlJTipA5MewrKL1mm1xCT2xiOuzTbe1wkY1MMFOKzpoAHV+ykGdvSxHhFr6JgYF/HI
	ByCHgkR2OeLzxeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 319571370C;
	Tue, 13 Feb 2024 13:25:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZK+TC7Bty2UYGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 13:25:04 +0000
Date: Tue, 13 Feb 2024 14:25:03 +0100
Message-ID: <87cyt0xzrk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Cedric Bregardis <cedric.bregardis@free.fr>,
	Jean-Christian Hassler <jhassler@free.fr>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] ALSA: aw2: avoid casting function pointers
In-Reply-To: <20240213101327.460191-1-arnd@kernel.org>
References: <20240213101327.460191-1-arnd@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[free.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,arndb.de,kernel.org,google.com,free.fr,vger.kernel.org,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.39)[97.21%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.49

On Tue, 13 Feb 2024 11:13:19 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-16 started warning about incompatible function pointers here:
> 
> sound/pci/aw2/aw2-alsa.c:363:11: error: cast from 'void (*)(struct snd_pcm_substream *)' to 'snd_aw2_saa7146_it_cb' (aka 'void (*)(void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   363 |                                                     (snd_aw2_saa7146_it_cb)
>       |                                                     ^~~~~~~~~~~~~~~~~~~~~~~
>   364 |                                                     snd_pcm_period_elapsed,
>       |                                                     ~~~~~~~~~~~~~~~~~~~~~~
> sound/pci/aw2/aw2-alsa.c:392:10: error: cast from 'void (*)(struct snd_pcm_substream *)' to 'snd_aw2_saa7146_it_cb' (aka 'void (*)(void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   392 |                                                    (snd_aw2_saa7146_it_cb)
>       |                                                    ^~~~~~~~~~~~~~~~~~~~~~~
>   393 |                                                    snd_pcm_period_elapsed,
>       |                                                    ~~~~~~~~~~~~~~~~~~~~~~
> 
> Add a forward declaration for struct snd_pcm_substrea to allow it to just
> use the correct prototype.
> 
> Fixes: 98f2a97f207a ("[ALSA] Emagic Audiowerk 2 ALSA driver.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied.


Takashi

