Return-Path: <linux-kernel+bounces-149944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F30E8A9825
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EF92840FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C7915B969;
	Thu, 18 Apr 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iwuquuFV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5agX036W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XI4mK2VA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lRh68gjo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F015D5C1;
	Thu, 18 Apr 2024 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438284; cv=none; b=XYjYOGmMcTsvaNcEw5BC8vydgJ6ZxluBDGFiJptMrN2S/QcAod/rKIwJXVwYMsoME3izyJfQFZb6CT0uX/5sjItIuH7ZItKBURnloqU8AcjroUCjejJIrpVfWZ1p+IT2jPX6qsQ+XsIGcCbHNnR63+SK5SMd2qcCg5Fo/qeQnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438284; c=relaxed/simple;
	bh=n6GYePWKGsaNVZpPhB0ngSYw7xW4miHlMzKXOKwuVms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3TW8uBUTqXx4qpMii562uehiOTEn6GZCd0I+Q+toPHqckq4LdANvtLPVCQMVKfcptqPIdLOid7zaZVDrJt3UhOSJc199Gy3oEy3EO4Q+f/3MtMqhD/ErSSn4h8z/xURuI4jmszW9LgXhOLvvVs133hwIaB/acktdtQpMsjVUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iwuquuFV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5agX036W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XI4mK2VA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lRh68gjo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B234C34DD5;
	Thu, 18 Apr 2024 11:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713438275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gv1S5z4U/Lpggcm746FJVB5sgVR9PpMNoPlpi/9ROxQ=;
	b=iwuquuFVSRj3wbZCLHn+iERrfqZ94jpQwcRoAjkTgPgCjZ9T5yHoslKOU7yjTp2Qn7GhQI
	4bp/2Jm/BhOOW45u/3kTokz1zh3D9BRjs2v5BXX0U6hohw/BdwtSc4lvfUA5lsrufbci3b
	XSEcEqETcdua1ZbS1B7L450I6w+Rcnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713438275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gv1S5z4U/Lpggcm746FJVB5sgVR9PpMNoPlpi/9ROxQ=;
	b=5agX036W69nvNXNH3kJXYCpizMe4x2w1YlQxcUWUiKddCrUfqw1yXh3VJB7M6C0kkf0SzM
	8aXAirlqboDm7SCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XI4mK2VA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lRh68gjo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713438274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gv1S5z4U/Lpggcm746FJVB5sgVR9PpMNoPlpi/9ROxQ=;
	b=XI4mK2VAsewf9Mau4YEWo81qOrnE2L6X7K447OkXOVwrenGAseIJdpA75NAw3F06xbZnV2
	5oB1MfaA+dUoJIs2Ki0kWbes/57/3OEdsf29V7TVph11AOK07vbTL83ycbxzKMy/Mzv2di
	5rBtIkL/Iq0VRQIDp11LMq2JREALHTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713438274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gv1S5z4U/Lpggcm746FJVB5sgVR9PpMNoPlpi/9ROxQ=;
	b=lRh68gjome/yMlDFGPIYA9g2odX3SgIGtGtf7dAvaJwfZUQxh0UVwOfZBK60hYYb/EcL07
	PbLXKw4KbgMc1ECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A60E91384C;
	Thu, 18 Apr 2024 11:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LpV7KEL+IGYrWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Apr 2024 11:04:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4DEF6A0812; Thu, 18 Apr 2024 13:04:34 +0200 (CEST)
Date: Thu, 18 Apr 2024 13:04:34 +0200
From: Jan Kara <jack@suse.cz>
To: Zach O'Keefe <zokeefe@google.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Maxim Patlasov <MPatlasov@parallels.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/writeback: fix possible divide-by-zero in
 wb_dirty_limits(), again
Message-ID: <20240418110434.g5bx5ntp2m4433eo@quack3>
References: <20240118181954.1415197-1-zokeefe@google.com>
 <20240417111001.fa2eg5gp6t2wiwco@quack3>
 <CAAa6QmSOum_0ZhyUq1ppguLp0jpEs0u1U843GkF==xMwaMGV4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAa6QmSOum_0ZhyUq1ppguLp0jpEs0u1U843GkF==xMwaMGV4A@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B234C34DD5
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]

On Wed 17-04-24 12:33:39, Zach O'Keefe wrote:
> On Wed, Apr 17, 2024 at 4:10 AM Jan Kara <jack@suse.cz> wrote:
> > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > index cd4e4ae77c40a..02147b61712bc 100644
> > > --- a/mm/page-writeback.c
> > > +++ b/mm/page-writeback.c
> > > @@ -1638,7 +1638,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
> > >        */
> > >       dtc->wb_thresh = __wb_calc_thresh(dtc);
> > >       dtc->wb_bg_thresh = dtc->thresh ?
> > > -             div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
> > > +             div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
..
> > Thirdly, if thresholds are larger than 1<<32 pages, then dirty balancing is
> > going to blow up in many other spectacular ways - consider only the
> > multiplication on this line - it will not necessarily fit into u64 anymore.
> > The whole dirty limiting code is interspersed with assumptions that limits
> > are actually within u32 and we do our calculations in unsigned longs to
> > avoid worrying about overflows (with occasional typing to u64 to make it
> > more interesting because people expected those entities to overflow 32 bits
> > even on 32-bit archs). Which is lame I agree but so far people don't seem
> > to be setting limits to 16TB or more. And I'm not really worried about
> > security here since this is global-root-only tunable and that has much
> > better ways to DoS the system.
> >
> > So overall I'm all for cleaning up this code but in a sensible way please.
> > E.g. for these overflow issues at least do it one function at a time so
> > that we can sensibly review it.
> >
> > Andrew, can you please revert this patch until we have a better fix? So far
> > it does more harm than good... Thanks!
> 
> Shall we just roll-forward with a suitable fix? I think all the
> original code actually "needed" was to cast the ternary predicate,
> like:
> 
> ---8<---
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index fba324e1a010..ca1bfc0c9bdd 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1637,8 +1637,8 @@ static inline void wb_dirty_limits(struct
> dirty_throttle_control *dtc)
>          *   at some rate <= (write_bw / 2) for bringing down wb_dirty.
>          */
>         dtc->wb_thresh = __wb_calc_thresh(dtc);
> -       dtc->wb_bg_thresh = dtc->thresh ?
> -               div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
> +       dtc->wb_bg_thresh = (u32)dtc->thresh ?
> +               div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;

Well, this would fix the division by 0 but when you read the code you
really start wondering what's going on :) And as I wrote above when
thresholds pass UINT_MAX, the dirty limitting code breaks down anyway so I
don't think the machine will be more usable after your fix. Would you be up
for a challenge to modify mm/page-writeback.c so that such huge limits
cannot be set instead? That would be actually a useful fix...

								Honza

> 
>         /*
>          * In order to avoid the stacked BDI deadlock we need
> ---8<---
> 
> Thanks, and apologize for the inconvenience
> 
> Zach
> 
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

