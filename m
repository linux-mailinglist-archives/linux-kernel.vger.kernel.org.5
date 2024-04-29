Return-Path: <linux-kernel+bounces-162214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B997C8B57A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BD8287733
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777ED53E34;
	Mon, 29 Apr 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u3z3yMXW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YdzBQ9nR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u3z3yMXW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YdzBQ9nR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCC53378;
	Mon, 29 Apr 2024 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392787; cv=none; b=Y7biPPqprOGgaXNM4qA+UVnE5EvTdNBa/RKLJ2geXmSEO4nk8aJDn3Suzmb2NeGQJ5YJBUA31+v2jJaEqEOi5UWLzp/OEG8Z1d6ShrFQ1tNBWYtOdCQm7uoCT8MnqSQ77+GkFYHSEYiRJx/A8sMrcC1s/5j7DaNm9AbbTCEBU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392787; c=relaxed/simple;
	bh=is+ZZRR1qjQpcT+IviiIaio3XkpSgD8LftCNzbntfDU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcfi1w3+WppYsLpfqVNWFY2rPi19YZao1PZzxKXDYFL0Zytwhgjtb8I6sXuvRjdhUcR+PwNsFZRaKthIyUyq9iQQuM1SM5/INZFhGyyOtdmb8gsuse7h9pLJPvUqR3rfNhFT4WEwDSCcCLw7OQ1lIOleieAS58+3tJdOVQwB3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u3z3yMXW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YdzBQ9nR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u3z3yMXW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YdzBQ9nR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93FD233743;
	Mon, 29 Apr 2024 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714392784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta/xgiOSdujgYrMackSTdmdnjtlcI/U1edyYAhI44nw=;
	b=u3z3yMXWNO1peNgfA6o0JOXiHGnAkbUREtR7LKVaUrARitgKPwq17nahal7yzRHFrLQ69s
	CrBdf+jL8oXheHO5lI9ijJ4PmQC/FmHC+/3fN1sWC9MgL14ddkJ2fpPxkYellyfaiVW/tl
	tY4p++rSyiULhpzQD2fndc9Nxn98Egg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714392784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta/xgiOSdujgYrMackSTdmdnjtlcI/U1edyYAhI44nw=;
	b=YdzBQ9nR91L3a8xEkKxAtGDdrD7etwTeKKJAmILTesf7JWrO1gBB8AmUdafI7HcBnXjUVr
	rBSYifoEGomkUBBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714392784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta/xgiOSdujgYrMackSTdmdnjtlcI/U1edyYAhI44nw=;
	b=u3z3yMXWNO1peNgfA6o0JOXiHGnAkbUREtR7LKVaUrARitgKPwq17nahal7yzRHFrLQ69s
	CrBdf+jL8oXheHO5lI9ijJ4PmQC/FmHC+/3fN1sWC9MgL14ddkJ2fpPxkYellyfaiVW/tl
	tY4p++rSyiULhpzQD2fndc9Nxn98Egg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714392784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta/xgiOSdujgYrMackSTdmdnjtlcI/U1edyYAhI44nw=;
	b=YdzBQ9nR91L3a8xEkKxAtGDdrD7etwTeKKJAmILTesf7JWrO1gBB8AmUdafI7HcBnXjUVr
	rBSYifoEGomkUBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37A28139DE;
	Mon, 29 Apr 2024 12:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +REoDNCOL2Z2VwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Apr 2024 12:13:04 +0000
Date: Mon, 29 Apr 2024 14:13:16 +0200
Message-ID: <87il00pdsz.wl-tiwai@suse.de>
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
In-Reply-To: <87jzkgpdvm.wl-tiwai@suse.de>
References: <20240428005733.202978-1-mbarriolinares@gmail.com>
	<87jzkgpdvm.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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

On Mon, 29 Apr 2024 14:11:41 +0200,
Takashi Iwai wrote:
> 
> On Sun, 28 Apr 2024 02:57:29 +0200,
> ManuLinares wrote:
> > 
> > This adds support for all sample rates supported by the hardware,
> > Digidesign Mbox 3 supports: {44100, 48000, 88200, 96000}
> > 
> > Fixes syncing clock issues that presented as pops. To test this, without
> > this patch playing 440hz tone produces pops.
> > 
> > Clock is now synced between playback and capture interfaces so no more
> > latency drift issue when using pipewire pro-profile.
> > (https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3900)
> > 
> > Signed-off-by: ManuLinares <mbarriolinares@gmail.com>

Also, put a space between Manu and Linares (supposing it's your real
name).  Signed-off-by is a legal requirement, hence it should be
properly spelled.


thanks,

Takashi

