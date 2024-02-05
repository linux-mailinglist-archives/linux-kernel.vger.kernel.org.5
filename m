Return-Path: <linux-kernel+bounces-52843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B3C849D58
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F2D1C21C32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF2A2C69B;
	Mon,  5 Feb 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oFciRSqf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oFciRSqf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB32C688
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144457; cv=none; b=OdPS+WlpoCiXt++6q67kTP6ZAoyVvZbhcDePEqzehxuMioZwBgHR+OVLdO11wMBMYlawdFkUpck1bx99ASnweol9bSjuQ5KPZLMynoFDXhtuv0iDs5O6Hb7zmlnurNupoHUjpMpAd9S2WcBk/5NqcXS91wmkBYC+NqGqsKIDITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144457; c=relaxed/simple;
	bh=y60qSvhHxwQC3IMhanA0g45FqmAYU8c1yQmtInFHF2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTBacVQauuv4dvtXXnvbF0BeThA9pfXl4eotFq3Fd9cUw74IvcgN2ND6qLzGVgsTli84p+/xHozDyig+83tZkz1QGxmrcOOwThdnOHZOO03vQZj99t5vmLnMi6vxTVY1ZORSBLsW4R1j8SDexw53iBAeNqLITZ/wrQQLVf0P+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oFciRSqf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oFciRSqf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DBC2222BC;
	Mon,  5 Feb 2024 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707144452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYUoybHLUqZci7jTkA5AStGSRfMnYOuNTneWtGHo/yU=;
	b=oFciRSqfH+243AnA0GHa7gBzsKGpQHVouFXoNeyaCJrdf++ciV2GKWVGuP+H4BT9Ykk+qT
	UXza7O3LHjkQi9Mwy1a7/ZFGSuhuSsXQhHOCM6PyEhSYWGKqHvlgSu33PKxorW3Y+mgRcv
	4lUcVxv/f6jeVtdgvrYTToHK1MesMCo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707144452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYUoybHLUqZci7jTkA5AStGSRfMnYOuNTneWtGHo/yU=;
	b=oFciRSqfH+243AnA0GHa7gBzsKGpQHVouFXoNeyaCJrdf++ciV2GKWVGuP+H4BT9Ykk+qT
	UXza7O3LHjkQi9Mwy1a7/ZFGSuhuSsXQhHOCM6PyEhSYWGKqHvlgSu33PKxorW3Y+mgRcv
	4lUcVxv/f6jeVtdgvrYTToHK1MesMCo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E11313A2E;
	Mon,  5 Feb 2024 14:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LEY9BQT1wGUQdAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 05 Feb 2024 14:47:32 +0000
Date: Mon, 5 Feb 2024 15:47:31 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: hugetlb: improve the handling of hugetlb
 allocation failure for freed or in-use hugetlb
Message-ID: <ZcD1A3gj-Net_I9b@tiehlicka>
References: <23814ccce5dd3cd30fd67aa692fd0bf3514b0166.1707137359.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23814ccce5dd3cd30fd67aa692fd0bf3514b0166.1707137359.git.baolin.wang@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oFciRSqf
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4DBC2222BC
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Mon 05-02-24 20:50:51, Baolin Wang wrote:
> When handling the freed hugetlb or in-use hugetlb, we should ignore the
> failure of alloc_buddy_hugetlb_folio() to dissolve the old hugetlb successfully,
> since we did not use the new allocated hugetlb in this 2 cases. Moreover,
> moving the allocation into the free hugetlb handling branch.

The changelog is a bit hard for me to understand. What about the
following instead?
alloc_and_dissolve_hugetlb_folio preallocates a new huge page before it
takes hugetlb_lock. In 3 out of 4 cases the page is not really used and
therefore the newly allocated page is just freed right away. This is
wasteful and it might cause pre-mature failures in those cases.

Address that by moving the allocation down to the only case (hugetlb
page is really in the free pages pool). We need to drop hugetlb_lock
to do so and therefore need to recheck the page state after regaining
it.

The patch is more of a cleanup than an actual fix to an existing
problem. There are no known reports about pre-mature failures.

[...]

> @@ -3075,6 +3063,24 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>  		cond_resched();
>  		goto retry;
>  	} else {
> +		if (!new_folio) {
> +			spin_unlock_irq(&hugetlb_lock);
> +			/*
> +			 * Before dissolving the free hugetlb, we need to allocate
> +			 * a new one for the pool to remain stable.  Here, we
> +			 * allocate the folio and 'prep' it by doing everything
> +			 * but actually updating counters and adding to the pool.
> +			 * This simplifies and let us do most of the processing
> +			 * under the lock.
> +			 */

This comment is not really needed anymore IMHO.

> +			new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid,
> +							      NULL, NULL);
> +			if (!new_folio)
> +				return -ENOMEM;
> +			__prep_new_hugetlb_folio(h, new_folio);
> +			goto retry;
> +		}
> +
>  		/*
>  		 * Ok, old_folio is still a genuine free hugepage. Remove it from
>  		 * the freelist and decrease the counters. These will be

-- 
Michal Hocko
SUSE Labs

