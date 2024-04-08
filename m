Return-Path: <linux-kernel+bounces-135054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24789BA76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CF01C21958
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF939870;
	Mon,  8 Apr 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bQjM7iN1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RJuKPCAu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SiLVrbBS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xirxDqDV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A238F98
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565529; cv=none; b=lpQWBGyY88HDuSdAcSN9yBQganRqPhIGVVxxdJrvFU9aoRvJ1JzTP9bRcF3tVULOEhJKDGSpHUjn7Rv6dfUgI5Lf6V/XDMOgZhDCCXbxAaViSssqxEqAqTWQc4KuKBH4Ayeg+aDCO5dTnFIZA/XKrzEDqQVtZuYhPmprCuLy96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565529; c=relaxed/simple;
	bh=v3k0q3Ssrf6AF5pL/NajPpfMBf3IXMrttmu5uBqjp4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyoNx1yld4AN7qeAUuM2C30wAaD1kT3SSY0+2dXrzLFKilgRu8Z9Qwzfkgv6gOyPNgYb0623XpfrCHVjM2fLj6N4iHbLCqJwH2sG2pEl2H+pSvBygfxOkjhrs94uLtXeXkZfg9GuHqaKJdxPcOj0sCKsmzkIzW3eLIf+b42BQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bQjM7iN1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RJuKPCAu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SiLVrbBS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xirxDqDV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FD7F20216;
	Mon,  8 Apr 2024 08:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712565525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uwj3JbLD7BKun3ExrCgpdE7EoWxAzmC5eFj4hgIUgzc=;
	b=bQjM7iN1MOxIU5bzvPcqCwH5r/tNIMEzlCqXLYxXDnq+ub9OHTM5+PIiadc8+RUPPJ5Yyh
	VM7164xNrnJamL9DvMEjBzUXlBVBYo7ULATm7M3IFy4iKKpQqwDRitzxg533Q3LB9cN9Ws
	AE4B2ScfYCuyOxAn86fN2a7HhbhV/pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712565525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uwj3JbLD7BKun3ExrCgpdE7EoWxAzmC5eFj4hgIUgzc=;
	b=RJuKPCAuwK2No9fzXyGUbVY31cWdKkZs8F7FUhWDK1NE4bf/1QH2qxr7ZWbkKWyQojf1i6
	NgBP6KxxrGYvmuCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712565524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uwj3JbLD7BKun3ExrCgpdE7EoWxAzmC5eFj4hgIUgzc=;
	b=SiLVrbBSJnRd7N8cOdzaN634wlBtCeYIquZGxihR4+wENZdbf8P6PPiDa+qAk3rRxMl2Ol
	8qmOLP3txCznxrGa4OxGqe4PYnzIXGOJASiLiHreBunsdHJLdXP8qrLjdfyhE1eJ3tco2M
	lrqek+1HxriF/O6nEnkkIq7W8RHKLVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712565524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uwj3JbLD7BKun3ExrCgpdE7EoWxAzmC5eFj4hgIUgzc=;
	b=xirxDqDVmy4uOe8Yy+70NYnEAAHytWEHUnJGKOC7R2WIkbwTBblqGI4rsaplyUWtZa/x02
	jppQn6xkNwCwW6Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B30211332F;
	Mon,  8 Apr 2024 08:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zBSLKBOtE2Y5IgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Mon, 08 Apr 2024 08:38:43 +0000
Date: Mon, 8 Apr 2024 10:38:34 +0200
From: Oscar Salvador <osalvador@suse.de>
To: liuhailong@oppo.com
Cc: akpm@linux-foundation.org, nathan@kernel.org, ndesaulniers@google.com,
	trix@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, surenb@google.com, zhaoyang.huang@unisoc.com,
	quic_charante@quicinc.com, yuzhao@google.com
Subject: Re: [PATCH] mm: vmscan: do not skip CMA while LRU is full of CMA
 folios
Message-ID: <ZhOtCtGBSCntUHvR@localhost.localdomain>
References: <20240408080539.14282-1-liuhailong@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408080539.14282-1-liuhailong@oppo.com>
X-Spam-Flag: NO
X-Spam-Score: -3.65
X-Spam-Level: 
X-Spamd-Result: default: False [-3.65 / 50.00];
	BAYES_HAM(-2.35)[96.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,oppo.com:email]

On Mon, Apr 08, 2024 at 04:05:39PM +0800, liuhailong@oppo.com wrote:
> From: liuhailong <liuhailong@oppo.com>
> @@ -6202,6 +6213,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  		 */
>  		if (sc->priority < DEF_PRIORITY - 2)
>  			sc->may_writepage = 1;
> +
> +		/*
> +		 * If we're getting trouble reclaiming non-cma pages and
> +		 * currently a substantial number of CMA pages on LRU,
"sit on LRU" ?

> +		 * start reclaiming cma pages to alleviate other threads
> +		 * and decrease lru size.
> +		 */
> +		if (sc->priority < DEF_PRIORITY - 2 &&
> +		    sc->nr_scanned < (sc->nr_skipped_cma >> 3))

Why "sc->nr_skipped_cma >> 3"? It feels a bit hardcoded.
Maybe the comment or the changelog should contain a reference about why
this "/8" was a good choice.


-- 
Oscar Salvador
SUSE Labs

