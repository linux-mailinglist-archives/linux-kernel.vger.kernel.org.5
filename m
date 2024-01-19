Return-Path: <linux-kernel+bounces-31308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BAA832C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DB91F24E94
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8930A54BCF;
	Fri, 19 Jan 2024 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p4dFb6GM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7GbZmExG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uv6/I8/D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TjocpMhx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF654BC1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677796; cv=none; b=BpN5FYoKnLcUIW7z1IXllXtp1cOwywcuhQo3kgwe/rLIDbdQe2OQ0IjqZ8fr/HuY+QN/qQ3XFlIVKmsuuZIe/yETgTlaOU5vgxx5Um+1uLVYtStOJoS3OlO23qBwsP8ox/83rwbkI7sOsVFa3UCgwy1qhb2//URYf4QE7Iypgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677796; c=relaxed/simple;
	bh=BZHfkaDvaNb/lVEFpgRJfEoNFqi2qK09ZJ8LTvkZg/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF4xhX3yMQscnfxPs+3gLJCFRHcqA1DXB5MoSors6atK6PvkWw6m8aUVZPq5LtL6t+1TnHTywdrZt1J83h8nc+jDBetSlFvraDCfCKsWTvygB3yyGGZQ4W+U9noiR70GCjWA+KIfhlSfvjmfSOvL2XDBCzyTlsXzyIy6+A06Imw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p4dFb6GM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7GbZmExG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uv6/I8/D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TjocpMhx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E42E921F0E;
	Fri, 19 Jan 2024 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705677793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UlMhYNvxmdwU88x2GiClfz7jLnVbiymkQwkKTqSWf3I=;
	b=p4dFb6GMSRo0tZhknWp0pJnU0cXnMMRmhs/hkaguOiNRiUJHsE/ioFUyDkg/V2qD3QVgzp
	AXhqPWksFbJZvehe8aMjyxJNPs5uwTy+lrH0/UrfAHBEZZ/Ob1FBKQsaVZu8hwXeU7Dfj0
	tvoFqMZArauYQLSc6F3Nr4PKRU/ryDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705677793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UlMhYNvxmdwU88x2GiClfz7jLnVbiymkQwkKTqSWf3I=;
	b=7GbZmExGbUuvg8YHeHRlbRjMJkr4BYJT1xm9jzKqY+Cz95B2DX/dKt9p4VWRSDSo+lb3Nw
	SUMfM2Fp4AMNVjCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705677792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UlMhYNvxmdwU88x2GiClfz7jLnVbiymkQwkKTqSWf3I=;
	b=uv6/I8/DAEwdii5GhOY2DDxek1tbLfwtJJeQnDG5/iM33eCjj5k7OTy6CxNTGvwRyra9em
	IlvkNGZQaNCzIRfqulB3WYnKdsno6wb+LTR4alLPqugEiSiQ8IvBBqcZqMsY5fY0UpI+oi
	EgCTg3SNd0HB5Zac4bZuMc/3+V6YCMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705677792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UlMhYNvxmdwU88x2GiClfz7jLnVbiymkQwkKTqSWf3I=;
	b=TjocpMhxinabRrhyYc09GRqMbbXQIjoZ/y+OdQ8zSfuYh+5s+nDjTuGdcF/ifi9+pNr98H
	1P7ed6EnA18ACfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D96231388C;
	Fri, 19 Jan 2024 15:23:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X0oONeCTqmXeQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Jan 2024 15:23:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D682A0803; Fri, 19 Jan 2024 16:23:12 +0100 (CET)
Date: Fri, 19 Jan 2024 16:23:12 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, jack@suse.cz, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flex_proportions: remove unused fprop_local_single
Message-ID: <20240119152312.qb4xd43zw6jtdihv@quack3>
References: <20240118201321.759174-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118201321.759174-1-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="uv6/I8/D";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TjocpMhx
X-Spamd-Result: default: False [0.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.19
X-Rspamd-Queue-Id: E42E921F0E
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Fri 19-01-24 04:13:21, Kemeng Shi wrote:
> The single variant of flex_proportions is not used. Simply remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Yup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/flex_proportions.h | 32 -------------
>  lib/flex_proportions.c           | 77 --------------------------------
>  2 files changed, 109 deletions(-)
> 
> diff --git a/include/linux/flex_proportions.h b/include/linux/flex_proportions.h
> index 3e378b1fb0bc..e9a72fd0bfe7 100644
> --- a/include/linux/flex_proportions.h
> +++ b/include/linux/flex_proportions.h
> @@ -38,38 +38,6 @@ int fprop_global_init(struct fprop_global *p, gfp_t gfp);
>  void fprop_global_destroy(struct fprop_global *p);
>  bool fprop_new_period(struct fprop_global *p, int periods);
>  
> -/*
> - *  ---- SINGLE ----
> - */
> -struct fprop_local_single {
> -	/* the local events counter */
> -	unsigned long events;
> -	/* Period in which we last updated events */
> -	unsigned int period;
> -	raw_spinlock_t lock;	/* Protect period and numerator */
> -};
> -
> -#define INIT_FPROP_LOCAL_SINGLE(name)			\
> -{	.lock = __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
> -}
> -
> -int fprop_local_init_single(struct fprop_local_single *pl);
> -void fprop_local_destroy_single(struct fprop_local_single *pl);
> -void __fprop_inc_single(struct fprop_global *p, struct fprop_local_single *pl);
> -void fprop_fraction_single(struct fprop_global *p,
> -	struct fprop_local_single *pl, unsigned long *numerator,
> -	unsigned long *denominator);
> -
> -static inline
> -void fprop_inc_single(struct fprop_global *p, struct fprop_local_single *pl)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	__fprop_inc_single(p, pl);
> -	local_irq_restore(flags);
> -}
> -
>  /*
>   * ---- PERCPU ----
>   */
> diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
> index 83332fefa6f4..84ecccddc771 100644
> --- a/lib/flex_proportions.c
> +++ b/lib/flex_proportions.c
> @@ -83,83 +83,6 @@ bool fprop_new_period(struct fprop_global *p, int periods)
>  	return true;
>  }
>  
> -/*
> - * ---- SINGLE ----
> - */
> -
> -int fprop_local_init_single(struct fprop_local_single *pl)
> -{
> -	pl->events = 0;
> -	pl->period = 0;
> -	raw_spin_lock_init(&pl->lock);
> -	return 0;
> -}
> -
> -void fprop_local_destroy_single(struct fprop_local_single *pl)
> -{
> -}
> -
> -static void fprop_reflect_period_single(struct fprop_global *p,
> -					struct fprop_local_single *pl)
> -{
> -	unsigned int period = p->period;
> -	unsigned long flags;
> -
> -	/* Fast path - period didn't change */
> -	if (pl->period == period)
> -		return;
> -	raw_spin_lock_irqsave(&pl->lock, flags);
> -	/* Someone updated pl->period while we were spinning? */
> -	if (pl->period >= period) {
> -		raw_spin_unlock_irqrestore(&pl->lock, flags);
> -		return;
> -	}
> -	/* Aging zeroed our fraction? */
> -	if (period - pl->period < BITS_PER_LONG)
> -		pl->events >>= period - pl->period;
> -	else
> -		pl->events = 0;
> -	pl->period = period;
> -	raw_spin_unlock_irqrestore(&pl->lock, flags);
> -}
> -
> -/* Event of type pl happened */
> -void __fprop_inc_single(struct fprop_global *p, struct fprop_local_single *pl)
> -{
> -	fprop_reflect_period_single(p, pl);
> -	pl->events++;
> -	percpu_counter_add(&p->events, 1);
> -}
> -
> -/* Return fraction of events of type pl */
> -void fprop_fraction_single(struct fprop_global *p,
> -			   struct fprop_local_single *pl,
> -			   unsigned long *numerator, unsigned long *denominator)
> -{
> -	unsigned int seq;
> -	s64 num, den;
> -
> -	do {
> -		seq = read_seqcount_begin(&p->sequence);
> -		fprop_reflect_period_single(p, pl);
> -		num = pl->events;
> -		den = percpu_counter_read_positive(&p->events);
> -	} while (read_seqcount_retry(&p->sequence, seq));
> -
> -	/*
> -	 * Make fraction <= 1 and denominator > 0 even in presence of percpu
> -	 * counter errors
> -	 */
> -	if (den <= num) {
> -		if (num)
> -			den = num;
> -		else
> -			den = 1;
> -	}
> -	*denominator = den;
> -	*numerator = num;
> -}
> -
>  /*
>   * ---- PERCPU ----
>   */
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

