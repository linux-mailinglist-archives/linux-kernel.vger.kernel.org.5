Return-Path: <linux-kernel+bounces-121442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CFC88E92B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D976B37161
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57F512DDA0;
	Wed, 27 Mar 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="GGvrvLay"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058342E62C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549961; cv=none; b=IIRfUJAQBfxGaTFPYkHKgZj6mdRd7l4N3RGDbxENUruPodkCb0YuZAuG4aolZXp8DInTZolNl9EVh9WNW55tmxxInSCxbGd8o0MtZz/xdtB2fByAUvFmJl7+/yaNcB4jnHt8ejCLiHNjJS9S53Ys97pK+xds9Cr+GLgttPTEZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549961; c=relaxed/simple;
	bh=nCtunvuCgrqfxtH1JP7NEPXwfpvzt45vRCZIfaGuBLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+WzOlxOvhfX5Khcg1TQK4BQM5Q3h9dFLbUN3MbICRvMaoghZo1KxrSiaEnbKBIz5vc/CpmqgNH5/LiBT5j6BnUWmPpCLvFdMfDcDeYVzmfQvTrcubFgi5Szqf5rkROskrSGIQzClCKIX47mjMfdLdGtKV4LylVHJRbGEGpTHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=GGvrvLay; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbbc6e51d0so4000013b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711549958; x=1712154758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vjl4T139soDHCaOLCmona2jIshqQpQnAUTRCdsvrmJ4=;
        b=GGvrvLayBSbnMl8bmSoA9Gl8fDWAq2W7kd40kekGkjB7QWM5ejE6XFr8xuLUMiHYqO
         sNcIFHQqbN8msuMxju4NjLR6ZzNRcSg/2MuBNKzyUKVgF5CMuPS6K6op3Pz6HPvnlN3x
         XkG2K0PQgeY83ffItTyRxgqE4BJiOjq+Hrr+DJFCoND6Vih/x5Qn80U/8yT+60QHwwX+
         npf1MtviMFqbqQtNfP5L64/qd+hpQPdak31M9Pv+toUgzmJAltVVamXMsm8qg53DEfjC
         nld6edin8/UnV++yQ/TeE12/qY0kSnRPuyMN35GTdlg0+FMcjW98of2bAL6AlEtSqbzJ
         uXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711549958; x=1712154758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vjl4T139soDHCaOLCmona2jIshqQpQnAUTRCdsvrmJ4=;
        b=YG19K73ylKth4O9u2xOpU8uOsVF2ESZG9SH84gQRtyvqWAHtdFC9miy+sBbCptJtMq
         aeCTuYb2p4ZCQgifCLHqbUoLyHoNikuwjDhLDsqAlTiSvimdmfTHr85e+k1BqCPSVVT2
         6ZUbvHQ0C4jix0QJyfr0/4461q+a3YS3fdOl+wBlCuTFVdgh38AJdYeCfpNZS+XuZ3d8
         7IasGiYnzZovuNh2uIklC25R0+p8ZoWdGgy9IZp/s3JkO6LrdCAVbr1U2aVsBl/Uu3IR
         yDKsptkKk2mFc9Zjvg3Baw7FvB4FV+zc241Ej+osA5pcfF89fOgTEfnS4I0SRlZFZMgj
         avew==
X-Forwarded-Encrypted: i=1; AJvYcCXV6eJxuDd/khwpv+adl87xmp+cEfmblgfF2NNpaBKO+Qjdp5ZNx/wLSjMZbA62ZAhI+QR4VY/X5QFQl0SJ02h2S6TLhvl60PWZLD+m
X-Gm-Message-State: AOJu0YwaSLtcdHGYONU4WtdqEg2B70D7I/zLfpn0vH1HjGbpBHmkTiYW
	4IsWKRxWxObw3k4DcBes2Ki6XdkcMxGXYSNmfeqOmxVNNspRDBQWI96191toCX8=
X-Google-Smtp-Source: AGHT+IFFV7K4elVNFISHH+/3VplQzUN8rxrDU6e04XmXU6yaxdhL2HeFj4lLnvWCMo5MN9MWFEZmEw==
X-Received: by 2002:a05:6808:17a5:b0:3c3:d6d6:d40 with SMTP id bg37-20020a05680817a500b003c3d6d60d40mr56729oib.43.1711549958045;
        Wed, 27 Mar 2024 07:32:38 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id gf15-20020a056214250f00b006912014b98dsm6338275qvb.129.2024.03.27.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:32:37 -0700 (PDT)
Date: Wed, 27 Mar 2024 10:32:36 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
Message-ID: <20240327143236.GE229434@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <b5b09acc-8bca-4e8c-82d4-6542fc7e9aec@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b09acc-8bca-4e8c-82d4-6542fc7e9aec@suse.cz>

On Wed, Mar 27, 2024 at 09:54:01AM +0100, Vlastimil Babka wrote:
> On 3/20/24 7:02 PM, Johannes Weiner wrote:
> > Free page accounting currently happens a bit too high up the call
> > stack, where it has to deal with guard pages, compaction capturing,
> > block stealing and even page isolation. This is subtle and fragile,
> > and makes it difficult to hack on the code.
> > 
> > Now that type violations on the freelists have been fixed, push the
> > accounting down to where pages enter and leave the freelist.
> 
> Awesome!
> 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Just some nits:
> 
> > @@ -1314,10 +1349,10 @@ static inline void expand(struct zone *zone, struct page *page,
> >  		 * Corresponding page table entries will not be touched,
> >  		 * pages will stay not present in virtual address space
> >  		 */
> > -		if (set_page_guard(zone, &page[size], high, migratetype))
> > +		if (set_page_guard(zone, &page[size], high))
> >  			continue;
> >  
> > -		add_to_free_list(&page[size], zone, high, migratetype);
> > +		add_to_free_list(&page[size], zone, high, migratetype, false);
> 
> This is account_freepages() in the hot loop, what if we instead used
> __add_to_free_list(), sum up nr_pages and called account_freepages() once
> outside of the loop?

Good idea. I'll send a fixlet for that.

> >  		set_buddy_order(&page[size], high);
> >  	}
> >  }
> 
> <snip>
> 
> > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > index 042937d5abe4..914a71c580d8 100644
> > --- a/mm/page_isolation.c
> > +++ b/mm/page_isolation.c
> > @@ -252,7 +252,8 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
> >  		 * Isolating this block already succeeded, so this
> >  		 * should not fail on zone boundaries.
> >  		 */
> > -		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
> > +		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page,
> > +							   migratetype));
> >  	} else {
> >  		set_pageblock_migratetype(page, migratetype);
> >  		__putback_isolated_page(page, order, migratetype);
> 
> Looks like a drive-by edit of an extra file just to adjust identation.

Argh, yeah, I think an earlier version mucked with the signature and I
didn't undo that cleanly. I'll send a fixlet for that too.

Thanks for the review!

