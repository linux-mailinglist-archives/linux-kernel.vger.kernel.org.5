Return-Path: <linux-kernel+bounces-34085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9D3837308
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE21F276F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93A4653C;
	Mon, 22 Jan 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yvb+XZfx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2FOwyztF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yvb+XZfx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2FOwyztF"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9E3FE50
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952812; cv=none; b=P56+GMixdvNfe56Bqco13x3wFF5js4I/3Z5xIMw1yDwGoKoxlstHWZBzuDrMwqqtaVwoFxsORfrqt8zm65dlGXlyKtTP+zhHG/QWbxbl24+CxGE+2iTxT/pyC10dkfcAfmbHlZGRgZA/2Ip0K5YDZ5Q188lSv+0QHBY12Awij7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952812; c=relaxed/simple;
	bh=+6fwH0hRVuUAlx5lrs6JF535RZdnPP/KIiy562TbJjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIDr63dqN25GwcaMhoq0eOmiUYZ3pIuOONetz4Zl4rGdSK8bQXvhGeRy2KzNleT6itK5l23dxqkCmM2bfUI9ZkwVDLCpJ1N/Z+IX795VDek8fuq+fBRHN3JzHfbZnGBTgyRkDA6j287//8CYTZm5NKe0jlYvR32GtGzINafBnR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yvb+XZfx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2FOwyztF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yvb+XZfx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2FOwyztF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35F33210FE;
	Mon, 22 Jan 2024 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705952808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTFml9Z618CdLmc+Tz57yIVpWiYs0cVxLRH1JApj1Hk=;
	b=Yvb+XZfxWjJit11P9whnKe4mFZhYC4pw/S6/y34rLc0xnyLv/QRpraDotmAb/r3SpfhE2j
	IJ1L+0nKqsWX44dCogWlzRFnN1iER9j4BSHo8rKY7SuTCy0wEh1ccDhvMDSWsU2rxNPTk/
	6xvRPbIHiQtPJHDc3W9K0RHwGswNJO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705952808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTFml9Z618CdLmc+Tz57yIVpWiYs0cVxLRH1JApj1Hk=;
	b=2FOwyztFe/C3qQZ+1yTVvMl3+ihdpjIOvFxo9WJ2EceBGThdW4pu2QkjafbEVA8WyGPZP2
	nfUf6hbs0WP3SAAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705952808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTFml9Z618CdLmc+Tz57yIVpWiYs0cVxLRH1JApj1Hk=;
	b=Yvb+XZfxWjJit11P9whnKe4mFZhYC4pw/S6/y34rLc0xnyLv/QRpraDotmAb/r3SpfhE2j
	IJ1L+0nKqsWX44dCogWlzRFnN1iER9j4BSHo8rKY7SuTCy0wEh1ccDhvMDSWsU2rxNPTk/
	6xvRPbIHiQtPJHDc3W9K0RHwGswNJO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705952808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTFml9Z618CdLmc+Tz57yIVpWiYs0cVxLRH1JApj1Hk=;
	b=2FOwyztFe/C3qQZ+1yTVvMl3+ihdpjIOvFxo9WJ2EceBGThdW4pu2QkjafbEVA8WyGPZP2
	nfUf6hbs0WP3SAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAB5913995;
	Mon, 22 Jan 2024 19:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uJM+KSfGrmXXNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jan 2024 19:46:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 30D47A0803; Mon, 22 Jan 2024 20:46:43 +0100 (CET)
Date: Mon, 22 Jan 2024 20:46:43 +0100
From: Jan Kara <jack@suse.cz>
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Guanjun <guanjun@linux.alibaba.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Oliver Neukum <oneukum@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>, Tony Lu <tonylu@linux.alibaba.com>,
	Vinod Koul <vkoul@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wei Liu <wei.liu@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] bitmap patches for v6.8
Message-ID: <20240122194643.yfzodqnrknuhm3nw@quack3>
References: <ZZwrbDUe4VQRYv5I@yury-ThinkPad>
 <CAHk-=wh02qG1CtiQ-pPDcpbiZUx6AEdfAYPbp0nJ7wyzdHmEkw@mail.gmail.com>
 <Za2qLrnItFxbB859@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za2qLrnItFxbB859@yury-ThinkPad>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com,xs4all.nl];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL3fjri4hbejo913g8y39c7scs)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[31];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,linux.ibm.com,linux.intel.com,acm.org,google.com,bytedance.com,intel.com,gmail.com,linux-m68k.org,linux.alibaba.com,xs4all.nl,suse.cz,kernel.dk,physik.fu-berlin.de,efficios.com,outlook.com,suse.com,infradead.org,rasmusvillemoes.dk,suse.de,kernel.org,redhat.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Sun 21-01-24 15:35:18, Yury Norov wrote:
> On Sun, Jan 21, 2024 at 01:47:21PM -0800, Linus Torvalds wrote:
> > So I've left this to be my last pull request, because I hate how our
> > header files are growing, and this part:
> > 
> >  include/linux/find.h | 301 ++++++++++++++++++++++++++++++-
> >  1 file changed, 297 insertions(+), 4 deletions(-)
> > 
> > in particular.
> > 
> > Nobody includes <linux/find.h> directly, but indirectly pretty much
> > *every* single kernel C file includes it.
> > 
> > Looking at some basic stats of my dependency files in my tree, 4426 of
> > 4526 object files (~98%) depend on find.h because they get it through
> > *some* path that ends up with bitmap.h -> find.h.
> > 
> > And honestly, the number of files that actually want the new functions
> > is basically just a tiny handful. It's also not obvious how useful
> > those optimizations are, considering that a lot of the loops are
> > *tiny*. I looked at a few cases, and the size of the bitmap it was
> > iterating over was often in the 2-4 range, sometimes (like
> > RTW89_TXCH_NUM) 13, etc.
> > 
> > In radio-shark, you replaced a loop like this
> > 
> >         for (i = 0; i < 2; i++) {
> > 
> > with that for_each_test_and_clear_bit(), and it *really* isn't clear
> > that it was worth it. It sure wasn't performance-critical to begin
> > with.
> > 
> > In general, if an "optimization" doesn't have any performance numbers
> > attached to it, is it an optimization at all?
> 
> No, this is not a performance optimization, and I don't claim that.
> Jan Kara reported some performance improvement, but performance is not
> the main goal of the series, and I didn't run performance tests for
> this on myself.
> 
> The original motivation came from the fact that using non-volatile
> find_bit() together with volatile test_and_set_bit() may trigger
> KCSAN warning on concurrent memory access.

Maybe to save Linus some reading: It is not only about KCSAN, it is a real
(theoretical) race. In principle the problem is that find_next_bit() does
something like:

	if (*addr)
		return __ffs(*addr)

and if the compiler decides to refetch *addr and we race with concurrent
writer bad things can happen. Now I wanted to fix this in a less intrusive
way using READ_ONCE()
(https://lore.kernel.org/linux-fsdevel/20231011150252.32737-1-jack@suse.cz/)
but Yury didn't like that and came up with this series.

> People wanted to make the whole find API volatile, which is a bad idea
> for sure. So I had to give them a reasonable alternative. After some
> thinking I decided that we just need a separate set of volatile find API.
> Check this for initial discussion:
> 
> https://lore.kernel.org/lkml/634f5fdf-e236-42cf-be8d-48a581c21660@alu.unizg.hr/T/#m3e7341eb3571753f3acf8fe166f3fb5b2c12e615
> 
> It also makes the code cleaner, at least to my taste, and some
> reviewers' too. And to some degree less bug-prone. For example,
> ILSEL_LEVELS is just 15, but traversing code in ilsel_enable()
> is buggy, as Geert spotted. And switching to atomic find() fixes
> it automatically:
> 
> https://lore.kernel.org/lkml/CAMuHMdWHxesM-EOOMtrrw3Caz+5Wux35QiKOjvwA=vwQpRe26Q@mail.gmail.com/T/#me53217b32fd5623af6c7eafa5c4ce6d0465f6c58
> 
> (His review came just a couple days ago, after I submitted the pull
> request, so the tag is not there.)

I would just note that this pull as is still does not address the original
issue in xarray when using find_next_bit() and I'm not yet sure how/if you
plan to address it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

