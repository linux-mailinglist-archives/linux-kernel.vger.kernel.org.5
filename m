Return-Path: <linux-kernel+bounces-68244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F668577BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958081C20D14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8EC17997;
	Fri, 16 Feb 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IkVERSf1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cELwtcWR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IkVERSf1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cELwtcWR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF71AAA5;
	Fri, 16 Feb 2024 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072536; cv=none; b=NUQKkrsElwBVOIGnXMVMFNseuTzM/gQVda54HFN5joNxXrms122mFERsGapCtyM6bkTXkh/Pzg3ugESuMRE7pOjGlIZOb0CmaIYOOmFm1DnfKzQpsINDen8O/2EQDABGt2LTAkusUbPyIMnXN0XNMBZ0/49HLa5B7cwpxvrN4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072536; c=relaxed/simple;
	bh=9oCIM5U9c/Uf/jN3kabebTYcMoMEyicBQQuvHlQ2VqM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqBN4d2e2ngdO66TGhk8XMwgUBsfC6CoKyTe5rZ+yNpLsA3Vmb5Hjxn5lzeXUsX489O1cUaG4fEICcGfXHb4QTOzzhHT4XOTv/78VogJdPVF3I8uPuGwjuXWuooMIUJ+lSvtnJKoDe80yYIF3CpZ3Absnlh7cCT1DgEWFhPx8Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IkVERSf1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cELwtcWR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IkVERSf1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cELwtcWR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C2612210E;
	Fri, 16 Feb 2024 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708072533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxY1rjQUL7/INb2efaS+2g4HNuLqJyFSIxGdTguqZSo=;
	b=IkVERSf1uTRyLMSHLDiuxvLfwvEPROKChTS+lcP8z4M5QhhuIwIbZ/xES0fvgjtS1NhxZP
	FTyu7OL4egXPWFdKler2wN9WXyqBo274gODBNAJJwrr5ePyM6t1HJje+wZYTP2Fv1KNXgX
	0JGJprsacKglALT/Tng9HvlYdpqvZwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708072533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxY1rjQUL7/INb2efaS+2g4HNuLqJyFSIxGdTguqZSo=;
	b=cELwtcWRAo3eI8Kgc6Y46SvDHMn95dLeTh4Y5IiOZrVY28ng9ZS5GkgaYJYTu0Tlzfc2TD
	q3mckq0C3NiYJ2DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708072533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxY1rjQUL7/INb2efaS+2g4HNuLqJyFSIxGdTguqZSo=;
	b=IkVERSf1uTRyLMSHLDiuxvLfwvEPROKChTS+lcP8z4M5QhhuIwIbZ/xES0fvgjtS1NhxZP
	FTyu7OL4egXPWFdKler2wN9WXyqBo274gODBNAJJwrr5ePyM6t1HJje+wZYTP2Fv1KNXgX
	0JGJprsacKglALT/Tng9HvlYdpqvZwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708072533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxY1rjQUL7/INb2efaS+2g4HNuLqJyFSIxGdTguqZSo=;
	b=cELwtcWRAo3eI8Kgc6Y46SvDHMn95dLeTh4Y5IiOZrVY28ng9ZS5GkgaYJYTu0Tlzfc2TD
	q3mckq0C3NiYJ2DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D16D1398D;
	Fri, 16 Feb 2024 08:35:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dA1KBVUez2UTYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 16 Feb 2024 08:35:33 +0000
Date: Fri, 16 Feb 2024 09:35:32 +0100
Message-ID: <87plwwiz6z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hillf Danton <hdanton@sina.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Sven van Ashbrook <svenva@chromium.org>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-sound@vger.kernel.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
In-Reply-To: <20240216043426.1218-1-hdanton@sina.com>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
	<20240215034528.240-1-hdanton@sina.com>
	<87h6iaf7di.wl-tiwai@suse.de>
	<CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com>
	<875xypk6d6.wl-tiwai@suse.de>
	<20240216043426.1218-1-hdanton@sina.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.41 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[sina.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.49)[79.68%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.41

On Fri, 16 Feb 2024 05:34:24 +0100,
Hillf Danton wrote:
> 
> On Thu, 15 Feb 2024 18:03:01 +0100 Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > So it sounds like that we should go back for __GFP_NORETRY in general
> > for non-zero order allocations, not only the call you changed, as
> > __GFP_RETRY_MAYFAIL doesn't guarantee the stuck.
> > 
> > How about the changes like below?
> > 
> > +/* default GFP bits for our allocations */
> > +static gfp_t default_gfp(size_t size)
> > +{
> > +	/* don't allocate intensively for high-order pages */
> > +	if (size > PAGE_SIZE)
> > +		return GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY;
> > +	else
> > +		return GFP_KERNEL | __GFP_NOWARN | __GFP_RETRY_MAYFAIL;
> > +}
> 
> Looks like an overdose because both __GFP_NORETRY and __GFP_RETRY_MAYFAIL
> are checked in __alloc_pages_slowpath().

If the check there worked as expected, this shouldn't have been a
problem, no?

The fact that we have to drop __GFP_RETRY_MAYFAIL indicates that the
handling there doesn't suffice -- at least for the audio operation.


thanks,

Takashi

