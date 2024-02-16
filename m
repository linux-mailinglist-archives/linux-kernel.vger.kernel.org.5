Return-Path: <linux-kernel+bounces-68434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD51857A25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84B72870DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82C0208DF;
	Fri, 16 Feb 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="agRpDnIm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q8L9QANS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="miCOrLyg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pM9icsqo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955E1B81C;
	Fri, 16 Feb 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078740; cv=none; b=uAqB4geXG91c5xSupXMCVugMD4OST8HKuHjjMS89KBx+2Lydv9Nw5+DKhnAwmbGdXvF0Y+AVObZgX9nn43VLZaGaFhYlFvFxgRUhEuWeCKxoed8oTSJKGdv7O3c7VasHQ3VG8qhgJecUKfCW3QHWMw1JzpxHt88lnV3jCRfq4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078740; c=relaxed/simple;
	bh=2l/Luo4DE+UQCMB52S0bZ89e7WBP7HLxzEg0RHVs1EM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxMxBT3PQ1ldS470je2nKsg7DbZecj2bwRHmbyPVKzS9Eo0/eewHixWaefVvtmKwBoNpyeuf0wtGoy3RAv6FFQuUHihNaf4IN71p0QpGhhbkQbExBvAXd5fVzTt1a8yY3U4j0xP09LTlYLhwspjhvpmiIZqzI+ST7KsT59mmx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=agRpDnIm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q8L9QANS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=miCOrLyg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pM9icsqo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC0151FB5B;
	Fri, 16 Feb 2024 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708078736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6h/xSWPlRf7PDPu4yMf74pKtHxhg0XmMUweyxazKoaE=;
	b=agRpDnImeZyWS78Js8bdcFUV2NVhV7IwcGA1IGE11p01MkbTPglbP3M+dRhVP9WpGpZENr
	Qyans5g34aYETR60cHOrUolFUicF3B9gdr2sFgmK0uh/HfV0W5Ug3BRLxhxv94YFeyLVUK
	5jmzREIDTfr/WECikcnGIOJ+2VW8W4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708078736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6h/xSWPlRf7PDPu4yMf74pKtHxhg0XmMUweyxazKoaE=;
	b=Q8L9QANS+g9P7FTChcAKpxBYo+tyKUXnlM/vE39cSrXUfqFmQEZXJfN+0nReqsMNzXZcxQ
	UVSmAonCbLL0YNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708078735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6h/xSWPlRf7PDPu4yMf74pKtHxhg0XmMUweyxazKoaE=;
	b=miCOrLygZO1ScyMykcr/WPln1exiufOHnRAQ+P+O7JUOavlFJVVOSm3K4voL2m/oNYNHQC
	ZZy36v58yOjUyEe0lNAOQgKbqoVMifbAQbYOAZDkr5PQ3jPVNL9npMAGC6lOuzvRoRc1Tj
	271Uh/XjQ8rgqJ1zxqR3/IE+8+3M6X8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708078735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6h/xSWPlRf7PDPu4yMf74pKtHxhg0XmMUweyxazKoaE=;
	b=pM9icsqomFguXaYdYV31rptOO8JdN00gPdel3E6ToBIlUWpNNvmPvbxF9WRFZb7CPAxPfS
	ZGnuj6UADbhYajDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FA4C1398D;
	Fri, 16 Feb 2024 10:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id st+PJY82z2XPeAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 16 Feb 2024 10:18:55 +0000
Date: Fri, 16 Feb 2024 11:18:55 +0100
Message-ID: <87frxsiueo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hillf Danton <hdanton@sina.com>
Cc: Sven van Ashbrook <svenva@chromium.org>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-sound@vger.kernel.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
In-Reply-To: <87plwwiz6z.wl-tiwai@suse.de>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
	<20240215034528.240-1-hdanton@sina.com>
	<87h6iaf7di.wl-tiwai@suse.de>
	<CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com>
	<875xypk6d6.wl-tiwai@suse.de>
	<20240216043426.1218-1-hdanton@sina.com>
	<87plwwiz6z.wl-tiwai@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[sina.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri, 16 Feb 2024 09:35:32 +0100,
Takashi Iwai wrote:
> 
> On Fri, 16 Feb 2024 05:34:24 +0100,
> Hillf Danton wrote:
> > 
> > On Thu, 15 Feb 2024 18:03:01 +0100 Takashi Iwai <tiwai@suse.de> wrote:
> > > 
> > > So it sounds like that we should go back for __GFP_NORETRY in general
> > > for non-zero order allocations, not only the call you changed, as
> > > __GFP_RETRY_MAYFAIL doesn't guarantee the stuck.
> > > 
> > > How about the changes like below?
> > > 
> > > +/* default GFP bits for our allocations */
> > > +static gfp_t default_gfp(size_t size)
> > > +{
> > > +	/* don't allocate intensively for high-order pages */
> > > +	if (size > PAGE_SIZE)
> > > +		return GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY;
> > > +	else
> > > +		return GFP_KERNEL | __GFP_NOWARN | __GFP_RETRY_MAYFAIL;
> > > +}
> > 
> > Looks like an overdose because both __GFP_NORETRY and __GFP_RETRY_MAYFAIL
> > are checked in __alloc_pages_slowpath().
> 
> If the check there worked as expected, this shouldn't have been a
> problem, no?
> 
> The fact that we have to drop __GFP_RETRY_MAYFAIL indicates that the
> handling there doesn't suffice -- at least for the audio operation.

Reconsidering on this again, I wonder keeping __GFP_RETRY_MAYFAIL
makes sense.  We did have __GFP_NORETRY for avoiding OOM-killer.
But it's been over ages, and the memory allocation core became smart
enough.

The side-effect of __GFP_RETRY_MAYFAIL is that the page reclaim and
compaction happens even for high-order allocations, and that must be
the issue we see now.  For dma_alloc_contiguous() with IOMMU, this
wasn't visible because the loop there sets __GFP_NORETRY explicitly
unless the minimal order.

So, basically we could have achieved the more or less same effect just
by dropping __GFP_NORETRY from DEFAULT_GFP definition.
(Now it's a drop of __GFP_RETRY_MAYFAIL)

OTOH, a slight concern with the drop of __GFP_RETRY_MAYFAIL is whether
allowing OOM-killer for low order allocations is acceptable or not.

There are two patterns of calling allocators:
1. SNDRV_DMA_TYPE_DEV for large pages:
   this is usually only once at driver probe, and the pages are
   preserved via PCM buffer preallocation mechanism

2. SNDRV_DMA_TYPE_DEV for lower orders:
   those are usually at probes for some communication buffers, and in
   most cases they are kept by drivers, too

3. SNDRV_DMA_TYPE_NONCONTIG for large size:
   this is called often, once per stream open, since the driver
   doesn't keep the buffer.

4. SNDRV_DMA_TYPE_NONCONTIG for lower orders:
   basically same as case 2.

That is, triggering OOM-killer would be OK for 2 and 4, but we have to
avoid for 3.  So, __GFP_RETRY_MAYFAIL would be still useful for there.

And for 3, there are two paths:
- with IOMMU => we may pass __GFP_RETRY_MAYFAIL unconditionally to
  dma_alloc_noncontiguous()
- without IOMMU => dma_alloc_noncontiguous() without MAYFAIL,
  but fallback allocation should become conditional:
  - higher order: default (or explicitly with NORETRY)
  - lower order: MAYFAIL

OTOH, the avoidance of OOM-killer wouldn't be bad even for 2 and 4 (as its
usefulness is dubious).  Then the conditionally setting MAYFAIL
wouldn't be bad for the calls of other dma_alloc_coherent() & co,
too.


Takashi

