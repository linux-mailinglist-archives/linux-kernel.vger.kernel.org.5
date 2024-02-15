Return-Path: <linux-kernel+bounces-66434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB47855CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2B52868C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F1134CC;
	Thu, 15 Feb 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AyQAC6EV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yq6j5sac";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SD/LXjnb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W7qfD0w9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039513FE2;
	Thu, 15 Feb 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986415; cv=none; b=s7TU/MNeSV5tA2neMiQUiNSXYNaUpd+8LZlforqXNHL0hdykAT5cWDZj4svF/2IuycGhXe231fmLeigLW45wjvrRhskV1ctpH7ZASLxQCFvxZ5Fld675x7UbzWKOu71kyi28X3pySlf7ankXkOBDgiJ2yKpsSpGi6puwCUdY58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986415; c=relaxed/simple;
	bh=F7BdL6N3jatKbCbiIQyhxX2cwbuRbqCr7GGsYXgZGxk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrGyhBz4wXkawBnL2lM1YpjSRAYnsMWbFEAs6Rx75CQCH8MQ8ep91hvKj6DSYx4buPe/ZiNbNCgs0f9bV4BFUyIlbg7rls4BmDhg40S1PcLTqZ99bE/9+DZyx2rIz4EFA8XDqCIDhwtcjlVMstoRVcPEX6gc2ktjDnawgq67vx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AyQAC6EV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yq6j5sac; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SD/LXjnb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W7qfD0w9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D36A21F86A;
	Thu, 15 Feb 2024 08:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707986411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XULIr3WXpUdEe2Bc55sez6vW2u/ICAnQ7pQCNfnb9mM=;
	b=AyQAC6EVNdn1/D/oO7mwlKLB0FypMsQ2J7FZl5lIiLuoYSC9A1W1/NJ9jlaeofv++t/8zw
	LuctbTgtJQpInzym/Yl+7eZkh7YF8PhgREeLfDivSScgJK7Gwt8QGWHxA+k+MDg/KyXY2c
	n8gD82TT9kpa1iihtgHZlxbGRAyZPqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707986411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XULIr3WXpUdEe2Bc55sez6vW2u/ICAnQ7pQCNfnb9mM=;
	b=yq6j5sacooZ6sFmpUGxUM/EbKnJc9nb93otu8oOTaU9WQ6rf7NpXLSnCPgLXVkLaZpaTXX
	7HnIXjoW5yNziDAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707986409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XULIr3WXpUdEe2Bc55sez6vW2u/ICAnQ7pQCNfnb9mM=;
	b=SD/LXjnbFYNfMpV7sQYcw4PFtOqBIfk6icBjvxzr0Sb9Y5nPm1p8tY0ifD7cicUw1NqjEw
	fdiCX4S917MqDuSNtGZK+jK8TgbkLmsZ3an5iXfCkondGibPB8/ZQMWJ8tnyyRu29E7/TK
	biq4GvQfWKNdYxwzX2RifJyMFM++qPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707986409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XULIr3WXpUdEe2Bc55sez6vW2u/ICAnQ7pQCNfnb9mM=;
	b=W7qfD0w9YA1iyqPelkUBHtzE1zn8BUMfUkS2T3iTaYg75rUUrcB5pNB80Jd42Z5OntWjwd
	rW808AI83xJiV9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C3AC13A72;
	Thu, 15 Feb 2024 08:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v391JOnNzWXHDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 Feb 2024 08:40:09 +0000
Date: Thu, 15 Feb 2024 09:40:09 +0100
Message-ID: <87h6iaf7di.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hillf Danton <hdanton@sina.com>
Cc: Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sven van Ashbrook <svenva@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
In-Reply-To: <20240215034528.240-1-hdanton@sina.com>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
	<20240215034528.240-1-hdanton@sina.com>
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email];
	 FREEMAIL_TO(0.00)[sina.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu, 15 Feb 2024 04:45:27 +0100,
Hillf Danton wrote:
> 
> On Wed, 14 Feb 2024 17:07:25 -0700 Karthikeyan Ramasubramanian <kramasub@chromium.org>
> > Before 9d8e536 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
> > the alsa non-contiguous allocator always called the alsa fallback
> > allocator in the non-iommu case. This allocated non-contig memory
> > consisting of progressively smaller contiguous chunks. Allocation was
> > fast due to the OR-ing in of __GFP_NORETRY.
> > 
> > After 9d8e536 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
> > the code tries the dma non-contig allocator first, then falls back to
> > the alsa fallback allocator. In the non-iommu case, the former supports
> > only a single contiguous chunk.
> > 
> > We have observed experimentally that under heavy memory fragmentation,
> > allocating a large-ish contiguous chunk with __GFP_RETRY_MAYFAIL
> > triggers an indefinite hang in the dma non-contig allocator. This has
> > high-impact, as an occurrence will trigger a device reboot, resulting in
> > loss of user state.
> > 
> > Fix the non-iommu path by letting dma_alloc_noncontiguous() fail quickly
> > so it does not get stuck looking for that elusive large contiguous chunk,
> > in which case we will fall back to the alsa fallback allocator.
> 
> The faster dma_alloc_noncontiguous() fails the more likely the paperover
> in 9d8e536d36e7 fails to work, so this is another case of bandaid instead
> of mitigating heavy fragmentation at the first place.

Yes, the main problem is the indefinite hang from
dma_alloc_noncontiguous().

So, is the behavior more or less same even if you pass
__GFP_RETRY_MAYFAIL to dma_alloc_noncontiguous()?  Or is this flag
already implicitly set somewhere in the middle?  It shouldn't hang
indefinitely, but the other impact to the system like OOM-killer
kickoff may be seen.

As of now, I'm inclined to take the suggested workaround.  It'll work
in most cases.  The original issue worked around by the commit
9d8e536d36e7 still remains, and we need to address differently.


thanks,

Takashi

