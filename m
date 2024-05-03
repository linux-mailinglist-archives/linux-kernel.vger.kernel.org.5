Return-Path: <linux-kernel+bounces-167621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78228BAC15
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847C428179C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8A152E0B;
	Fri,  3 May 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bRqBNXvL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S+TYDqRV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bRqBNXvL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S+TYDqRV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C915219F;
	Fri,  3 May 2024 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738015; cv=none; b=brw/bGL0ymGd1KB6lJu25zVI+e1sYUtAVT8/sxTTphqKyDhOWSjz/ZyQ55NMV+JsuvEaq7oxY0g/zGq6p0yN56nT40bOgN6oWugViIzmqwl0NZskdAAULtp2pCdf+0ihHhIll5P0ZbJVH7dt56vC5zKzc3lTaJuTG4Sv1i6LWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738015; c=relaxed/simple;
	bh=bLEROzC97gkbPw5RNJtxVFHx7EawHPv2uzdKzjVzDEQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnXZxvktkqDp9i5wc6x5RRimZ4RotovAszJp5+yhKOe1elisDuiyImrmt6boP/LW4wMxzgfPewYY61GSKYx9V1AtB9VKaQV2nrhUzomN1fxnJlF+a3kKiVob4hPu0bKOpzMeNHxjYU6exUUIySkeowANfXmRylK1dEfg2NPnoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bRqBNXvL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S+TYDqRV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bRqBNXvL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S+TYDqRV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D12120307;
	Fri,  3 May 2024 12:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714738012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8XRDU8yPPdJlA8bt/QVltW6z1qn8mYxw5vsm9FBKyYE=;
	b=bRqBNXvLNXozsBoxKlzOzcsnyHUPt0xDh/DIw8ek8kc0hCQi8xTszQ+LuqYSLGghhFqDvi
	au3iIFZE7D2LS8/vrlcXr+40BMyJon2IlXPIRojWvpJUzPI9dFbriL/qT2BueLba5IY/ug
	1eCHqXXCKL9TTW10Fb9hBqmVx3x3Prc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714738012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8XRDU8yPPdJlA8bt/QVltW6z1qn8mYxw5vsm9FBKyYE=;
	b=S+TYDqRVHtrkevPltTV9UUSt+TIihJUQVEZ/7i3avgDUd9hjGSqhrS2BO7E9RhPpMCARm4
	OfIakP7VDG4c6yAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bRqBNXvL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S+TYDqRV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714738012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8XRDU8yPPdJlA8bt/QVltW6z1qn8mYxw5vsm9FBKyYE=;
	b=bRqBNXvLNXozsBoxKlzOzcsnyHUPt0xDh/DIw8ek8kc0hCQi8xTszQ+LuqYSLGghhFqDvi
	au3iIFZE7D2LS8/vrlcXr+40BMyJon2IlXPIRojWvpJUzPI9dFbriL/qT2BueLba5IY/ug
	1eCHqXXCKL9TTW10Fb9hBqmVx3x3Prc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714738012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8XRDU8yPPdJlA8bt/QVltW6z1qn8mYxw5vsm9FBKyYE=;
	b=S+TYDqRVHtrkevPltTV9UUSt+TIihJUQVEZ/7i3avgDUd9hjGSqhrS2BO7E9RhPpMCARm4
	OfIakP7VDG4c6yAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AC0313991;
	Fri,  3 May 2024 12:06:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iiSwAFzTNGZwZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 May 2024 12:06:52 +0000
Date: Fri, 03 May 2024 14:07:05 +0200
Message-ID: <87bk5nayl2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"end.to.start" <end.to.start@mail.ru>,
	lgirdwood@gmail.com,
	tiwai@suse.com
Subject: Re: [PATCH 1/1] sound: Support microphone from device Acer 315-24p
In-Reply-To: <9a683d7f-8bde-47f4-9f63-97b65744711b@perex.cz>
References: <20240408152454.45532-1-end.to.start@mail.ru>
	<171268609844.62778.6340689132993321193.b4-ty@kernel.org>
	<9a683d7f-8bde-47f4-9f63-97b65744711b@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3D12120307
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,mail.ru];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,mail.ru,gmail.com,suse.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Fri, 03 May 2024 13:23:28 +0200,
Jaroslav Kysela wrote:
> 
> On 09. 04. 24 20:08, Mark Brown wrote:
> > On Mon, 08 Apr 2024 18:24:54 +0300, end.to.start wrote:
> >> This patch adds microphone detection for the Acer 315-24p, after which a microphone appears on the device and starts working
> >> 
> >> 
> > 
> > Applied to
> > 
> >     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> > 
> > Thanks!
> > 
> > [1/1] sound: Support microphone from device Acer 315-24p
> >        commit: 4b9a474c7c820391c0913d64431ae9e1f52a5143
> > 
> > All being well this means that it will be integrated into the linux-next
> > tree (usually sometime in the next 24 hours) and sent to Linus during
> > the next merge window (or sooner if it is a bug fix), however if
> > problems are discovered then the patch may be dropped or reverted.
> 
> Shall we really accept those anonymous contributions?
> 
> From submitting-patches.rst:
> 
> """
> then you just add a line saying::
> 
>         Signed-off-by: Random J Developer <random@developer.example.org>
> 
> using a known identity (sorry, no anonymous contributions.)
> """

Yeah, that's a bad example, and I noticed too late after sending a PR
to Linus, too (I concentrated only on the diffs).

The code change itself looks OK, so this is no big problem.
But let's decline such a submission at the next time.


thanks,

Takashi

