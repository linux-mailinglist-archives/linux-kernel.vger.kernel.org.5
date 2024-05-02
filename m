Return-Path: <linux-kernel+bounces-166066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798618B9577
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F46628572E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F0023769;
	Thu,  2 May 2024 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0kCiASM+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3PxaclT8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0kCiASM+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3PxaclT8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EEA1527BD;
	Thu,  2 May 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635971; cv=none; b=iqrskZAowPeks46uMCtwI9YfSWHJxgXGrvn03P9Ubgg5Fxpq+kQFxxNuiduPw9Ef6Js1CBEtrhKjOTJNyjbhA3reKbXUDY7+lUymNScwUiG1C8syGZ9QyOXUkfutVnEODAB9ISJ7JSi448FbCxI0qRza5t64KNyMtiwEnDGNTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635971; c=relaxed/simple;
	bh=G2F+pRuroYRYP/lwNUvpjm4eUMZYODI68gnHdFvmk5A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvJZDs3zqja9x4e61PemjArrc0mNS51ENPgVgS0+/V6UilT3ULrX+rrevq/VWKeoqOI0rR4az4nRj0iDuTWIo+KVjnf/7Nz77CNWcqMe+Pe7JDv/oCDgSRJAjCKYnExuxlYUB7HWfE6Gl5gdXOFPQHZ+5wyW6gDj/MY6fOqMaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0kCiASM+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3PxaclT8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0kCiASM+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3PxaclT8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B2CD1FBAF;
	Thu,  2 May 2024 07:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714635962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=grBrX5v5BMK7IiisGU8WUSwT0CHWzdkb4PZ4mBQewnU=;
	b=0kCiASM+3jGMhAqvGONuClyTbpR7p5db0zoU56cfzvj8ZLM1TibUzz1w1xMxYaPoEj0nk6
	6zO1slhkluZbunRsjK6LWnAoTDdxAEpLlgdWt82+iXrCk6ut27P3+9mux6/YtGiRHsPce0
	Q8WT8XRSSoZkls9WDZVKmlEqOdAX5gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714635962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=grBrX5v5BMK7IiisGU8WUSwT0CHWzdkb4PZ4mBQewnU=;
	b=3PxaclT8gno2WpuhwwnPIbk2kacgToaytnBHEwFzPUF+xZlvTtA4HU3gxAeJNZNwsBPr8W
	2eKgWDE02MgRsmCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0kCiASM+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3PxaclT8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714635962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=grBrX5v5BMK7IiisGU8WUSwT0CHWzdkb4PZ4mBQewnU=;
	b=0kCiASM+3jGMhAqvGONuClyTbpR7p5db0zoU56cfzvj8ZLM1TibUzz1w1xMxYaPoEj0nk6
	6zO1slhkluZbunRsjK6LWnAoTDdxAEpLlgdWt82+iXrCk6ut27P3+9mux6/YtGiRHsPce0
	Q8WT8XRSSoZkls9WDZVKmlEqOdAX5gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714635962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=grBrX5v5BMK7IiisGU8WUSwT0CHWzdkb4PZ4mBQewnU=;
	b=3PxaclT8gno2WpuhwwnPIbk2kacgToaytnBHEwFzPUF+xZlvTtA4HU3gxAeJNZNwsBPr8W
	2eKgWDE02MgRsmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AA6B13957;
	Thu,  2 May 2024 07:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hL2KJLlEM2biUwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 02 May 2024 07:46:01 +0000
Date: Thu, 02 May 2024 09:46:14 +0200
Message-ID: <87sez0k661.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	hverkuil@xs4all.nl,
	sakari.ailus@iki.fi,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 00/16] Add audio support in v4l2 framework
In-Reply-To: <ZjGhPz-bokg6ZbDJ@finisterre.sirena.org.uk>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
	<20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
	<ZjEEKyvb02CWz3l4@finisterre.sirena.org.uk>
	<20240430172752.20ffcd56@sal.lan>
	<ZjGhPz-bokg6ZbDJ@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1B2CD1FBAF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xs4all.nl];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,collabora.com,nxp.com,xs4all.nl,iki.fi,chromium.org,samsung.com,vger.kernel.org,gmail.com,perex.cz,suse.com,alsa-project.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]

On Wed, 01 May 2024 03:56:15 +0200,
Mark Brown wrote:
> 
> On Tue, Apr 30, 2024 at 05:27:52PM +0100, Mauro Carvalho Chehab wrote:
> > Mark Brown <broonie@kernel.org> escreveu:
> > > On Tue, Apr 30, 2024 at 10:21:12AM +0200, Sebastian Fricke wrote:
> 
> > > The discussion around this originally was that all the audio APIs are
> > > very much centered around real time operations rather than completely
> 
> > The media subsystem is also centered around real time. Without real
> > time, you can't have a decent video conference system. Having
> > mem2mem transfers actually help reducing real time delays, as it 
> > avoids extra latency due to CPU congestion and/or data transfers
> > from/to userspace.
> 
> Real time means strongly tied to wall clock times rather than fast - the
> issue was that all the ALSA APIs are based around pushing data through
> the system based on a clock.
> 
> > > That doesn't sound like an immediate solution to maintainer overload
> > > issues...  if something like this is going to happen the DRM solution
> > > does seem more general but I'm not sure the amount of stop energy is
> > > proportionate.
> 
> > I don't think maintainer overload is the issue here. The main
> > point is to avoid a fork at the audio uAPI, plus the burden
> > of re-inventing the wheel with new codes for audio formats,
> > new documentation for them, etc.
> 
> I thought that discussion had been had already at one of the earlier
> versions?  TBH I've not really been paying attention to this since the
> very early versions where I raised some similar "why is this in media"
> points and I thought everyone had decided that this did actually make
> sense.

Yeah, it was discussed in v1 and v2 threads, e.g.
  https://patchwork.kernel.org/project/linux-media/cover/1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com/#25485573

My argument at that time was how the operation would be, and the point
was that it'd be a "batch-like" operation via M2M without any timing
control.  It'd be a very special usage for for ALSA, and if any, it'd
be hwdep -- that is a very hardware-specific API implementation -- or
try compress-offload API, which looks dubious.

OTOH, the argument was that there is already a framework for M2M in
media API and that also fits for the batch-like operation, too.  So
was the thread evolved until now.


thanks,

Takashi

