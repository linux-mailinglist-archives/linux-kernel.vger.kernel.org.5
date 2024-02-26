Return-Path: <linux-kernel+bounces-80925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA95866E23
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E268BB242E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB2C1D535;
	Mon, 26 Feb 2024 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p/94khlF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bWNTJkTO"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91CE1CAA2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937019; cv=none; b=k+OJy/yCWH672cTSb/LY12k1GQ/hxTz2BWdjbDOqHbqz3IoEAwCeISDjxIgajs0kHwqXmxYMjoe9ZzlUEG8+Xdh4PU4HKECpDPJvd7alzWU352nfZ183uI5zgOSDG+gK2DqQpu4Cl3ODlW5RUmouHLLNXE69oSfGsW2LUlQlavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937019; c=relaxed/simple;
	bh=ff9YDknUAfWbL+Qlzh7JnnvIMBsX8B6h0Cy2E6mlWLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0beSrk6JpQ6ziO9RHI/woDZK1/Day9A6Z9wFgJ/eKIfOJLM0jlJWzMVhI3gc06QdDyFvu91Axse/+A1DKUQ3CI3UkwJbWn5f9WPq1kqUHWrkPRn3MzGbGAyf3AEi9czMxp3Fnr9fX24LRwt/nhWv2/ZlIOmC/ZmoF75b21Epf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p/94khlF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bWNTJkTO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE9701FB3D;
	Mon, 26 Feb 2024 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708937016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCro49qKFb96ctGGHx0sMJf91QqvH7dMQtCRbD9/a3Y=;
	b=p/94khlFMrPoU8svplFmUmTUb8/+VJ9NtDtg9Nv120CoQt12J5AKgAaJQTDCzD0PAqYsEB
	HSKeuUyLUMu1GZlJFzHpWBylEGdjGuL86bvtkqgCFyzL67wal/MfNiUm/T+8UJlVNOdVrK
	oCjAlSjY33goDle8rpo+m5nb+3/eaOM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708937015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCro49qKFb96ctGGHx0sMJf91QqvH7dMQtCRbD9/a3Y=;
	b=bWNTJkTOWTfd1NIXZT1FXBRV0jUN7QWza9A6QAZIcqK2h5L2BNdf8bB0+xmaeNtn8hoCwL
	1V+XcMv+GpwcCaZK6344GJImjy2FF9jlfq8gss9FmXHoCvJAag20KAwvUhgP2wWF7xLVPU
	KxcxIBFHJGKtsaGI0YmDv6DNQL4mh54=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C250513A58;
	Mon, 26 Feb 2024 08:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rdf/LjdP3GUJFQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 26 Feb 2024 08:43:35 +0000
Date: Mon, 26 Feb 2024 09:43:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	akpm@linux-foundation.org, kent.overstreet@linux.dev,
	petr@tesarici.cz, keescook@chromium.org, pasha.tatashin@soleen.com,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] mm: enumerate all gfp flags
Message-ID: <ZdxPN4RpNW54ckTE@tiehlicka>
References: <20240224015800.2569851-1-surenb@google.com>
 <c45d16c6-abab-4132-a499-c231dcedebb2@wanadoo.fr>
 <CAJuCfpFskKqCGj4imMMLjUQJWR_8-KHuYc=xAZ4e20+57Zf5Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFskKqCGj4imMMLjUQJWR_8-KHuYc=xAZ4e20+57Zf5Rg@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[wanadoo.fr,linux-foundation.org,linux.dev,tesarici.cz,chromium.org,soleen.com,android.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Sun 25-02-24 01:12:46, Suren Baghdasaryan wrote:
> On Sat, Feb 24, 2024 at 7:03 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > Le 24/02/2024 à 02:58, Suren Baghdasaryan a écrit :
> > > Introduce GFP bits enumeration to let compiler track the number of used
> > > bits (which depends on the config options) instead of hardcoding them.
> > > That simplifies __GFP_BITS_SHIFT calculation.
> > >
> > > Suggested-by: Petr Tesařík <petr@tesarici.cz>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > > Changes from v4 [1]:
> > > - Split from the series [2] as a stand-alone patch, per Michal Hocko
> > > - Added Reviewed-by, per Pasha Tatashin
> > > - Added Acked-by, per Michal Hocko
> > >
> > > [1] https://lore.kernel.org/all/20240221194052.927623-7-surenb@google.com/
> > > [2] https://lore.kernel.org/all/20240221194052.927623-1-surenb@google.com/
> > >
> > >   include/linux/gfp_types.h | 90 +++++++++++++++++++++++++++------------
> > >   1 file changed, 62 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> > > index 1b6053da8754..868c8fb1bbc1 100644
> > > --- a/include/linux/gfp_types.h
> > > +++ b/include/linux/gfp_types.h
> > > @@ -21,44 +21,78 @@ typedef unsigned int __bitwise gfp_t;
> > >    * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
> > >    */
> > >
> > > +enum {
> > > +     ___GFP_DMA_BIT,
> > > +     ___GFP_HIGHMEM_BIT,
> > > +     ___GFP_DMA32_BIT,
> > > +     ___GFP_MOVABLE_BIT,
> > > +     ___GFP_RECLAIMABLE_BIT,
> > > +     ___GFP_HIGH_BIT,
> > > +     ___GFP_IO_BIT,
> > > +     ___GFP_FS_BIT,
> > > +     ___GFP_ZERO_BIT,
> > > +     ___GFP_UNUSED_BIT,      /* 0x200u unused */
> >
> > Hi,
> >
> > what is the need to have this ___GFP_UNUSED_BIT now?
> 
> Hi!
> We can remove it but then all values will shift. That should be safe
> to do now but I prefer one patch to do only one thing. We can add a
> separate patch to do further cleanup of unused values.

Agreed!

> > > +     ___GFP_DIRECT_RECLAIM_BIT,
> > > +     ___GFP_KSWAPD_RECLAIM_BIT,
> > > +     ___GFP_WRITE_BIT,
> > > +     ___GFP_NOWARN_BIT,
> > > +     ___GFP_RETRY_MAYFAIL_BIT,
> > > +     ___GFP_NOFAIL_BIT,
> > > +     ___GFP_NORETRY_BIT,
> > > +     ___GFP_MEMALLOC_BIT,
> > > +     ___GFP_COMP_BIT,
> > > +     ___GFP_NOMEMALLOC_BIT,
> > > +     ___GFP_HARDWALL_BIT,
> > > +     ___GFP_THISNODE_BIT,
> > > +     ___GFP_ACCOUNT_BIT,
> > > +     ___GFP_ZEROTAGS_BIT,
> > > +#ifdef CONFIG_KASAN_HW_TAGS
> > > +     ___GFP_SKIP_ZERO_BIT,
> > > +     ___GFP_SKIP_KASAN_BIT,
> > > +#endif
> > > +#ifdef CONFIG_LOCKDEP
> > > +     ___GFP_NOLOCKDEP_BIT,
> > > +#endif
> > > +     ___GFP_LAST_BIT
> > > +};
> >
> > Does it make sense to have something like:
> >    BUILD_BUG_ON(___GFP_LAST_BIT > BITS_PER_LONG, "blah");
> 
> I suppose that would not hurt, except gfp_t is unsigned int, not long.
> Something like this would work I think:
> 
> BUILD_BUG_ON_MSG(___GFP_LAST_BIT > BITS_PER_TYPE(gfp_t), "GFP bit overflow");
> 
> except I'm not sure where to put this check. One of the __init
> functions in page_alloc.c would probably work but none seem to be
> appropriate. mm_core_init() perhaps? Other ideas?

Would that check add much? We currently cannot use the full width of the
gfp_t because radix tree code needs to fit also its own tag into the
same word (see radix_tree_init). If the radix tree constrain is lifted
then we should add something like the above.
-- 
Michal Hocko
SUSE Labs

