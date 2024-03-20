Return-Path: <linux-kernel+bounces-108732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C0A880F50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6561F22D71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F68D3C060;
	Wed, 20 Mar 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="01nAMklD"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59633BB36
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929292; cv=none; b=bPPvm3CdouSPDjC7/Pp0h0MA+46MzEOjIorGaS91xwA2Kt+20NMpW7rsiZ1C05//NTPZdowjYloO7OpYYSkCegNroVvCyHZWw9fUEUR9CcAugAadK1KSkO7YIEVuUTeZUxNP7MYHiVWBYlW3F5ldc6aNzatmXgQ8k8Ow8xRGstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929292; c=relaxed/simple;
	bh=1hptgYlCcZSnoXBrBdypsLIWzxVZcCAgl4Xy644y3kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmdY3qJgNexgtrZB1m8kVCY6B1uQGXYVJYoKqDclj1MoNbHZRqk46CsBrRvzqDX3lnDMoHtvEl9SSt/QqYhs4yJbcX8PdQ1ueqVwneQ4o2EhmXJ0Zuzb9Gm53dySdzD66rzYzPBfL2flrL58qYlUc2zm+B3J1RIBZLgegyvmlX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=01nAMklD; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690fed6816fso42981426d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710929288; x=1711534088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCvQMo3ZWIjWXG5M214OiwkknCIOzKyMIbVwF3D6h1Q=;
        b=01nAMklDIXL9t7UBpppjC6co6ljrfCuWQ/fRXfN9ugw9qfdZ4zInrBgV3PjrDUsXTo
         lfmNrYr9IBLrCPO65PSxeLRwl3ekPHDFPTyvlbUhZmM4YpyXwQ4b/wutj9w4cUuueLnS
         azjW4kiUsXiIwcjWVt7ReuegyFJYN1Kp2dsEwDvXNZ/TpOLK49AO1Ao4lANNBxB/JnkH
         YkPgnWwbiLDaHR5J4gfu8nX5QYczp14kmO3xJyNQVTJb+Qz7PyThqGtTEwhi9hePnu4B
         Ul4N7JrFdaKyAnqhTU11v0q2vnx3noaaBvBi98M+DHYMlC9EGwSuzBi6HIkj0+g0vG3w
         ibQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929288; x=1711534088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCvQMo3ZWIjWXG5M214OiwkknCIOzKyMIbVwF3D6h1Q=;
        b=Y4TzMteNYmcu5mi1hQ0X7hBOCQg7plrvLL82wx44BL0Gfsz1ZgndtVf2ZcUKtI1uKj
         JDYWi3EJpRw5FJGAMGCoGmyL/IRS/RjgkoAtrS2iEYFOGvLmKfhD0Tvng+2m3IWnQhnO
         IVI4/TcrIiTytfK38JhCU1LMfjGGALzTkW8ShOubFox3ViAHGW8HDkNtwqfEcoCZnsVb
         DL/pmEThIP20FgIIu1mJpHpxyPT7lCiOsZfpL+I3hhxQxoHrcCmKSzKtQd3g4HYUJ8+S
         13ZMOVkxT4rCSDufVDtbpiUOz5NGKZHBg60pPtBv5TyJz1c7e3pexJBqhIRnd4cND3d2
         9AZA==
X-Forwarded-Encrypted: i=1; AJvYcCWe2M3CviJVD2QD50u53MxHQaIJsXIR+V/rMpB+v/TmeNN6QDjlPTfx0cu0evpUkfOaGwHnueKQakM2naXbs85+g+BWwVC50M1zQgDW
X-Gm-Message-State: AOJu0YxKm14X2dPFemBN49mn6SRuO8vDnXPDw/ZW/9wMNFf/00Fa377R
	RpmgiD+j5jUV4YPYTmCvLOO0NQ48wY9PMKFly8YgRZI8XS9qhbR+U3mjimINsTk=
X-Google-Smtp-Source: AGHT+IEWV18aYAjvZ7bxiaK/qFfoU+/v7NHBEw/3Dd1cpE57bgZLsXRcM25hVl8CrDOXyT6aQPlgyw==
X-Received: by 2002:a0c:c682:0:b0:696:3620:cfdb with SMTP id d2-20020a0cc682000000b006963620cfdbmr3985416qvj.8.1710929288376;
        Wed, 20 Mar 2024 03:08:08 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 11-20020ad45bab000000b0069046d929a3sm7550743qvq.145.2024.03.20.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:08:08 -0700 (PDT)
Date: Wed, 20 Mar 2024 06:08:03 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Nhat Pham <nphamcs@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
Message-ID: <20240320100803.GB294822@cmpxchg.org>
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
 <Zfp-iWaDfqeCOElt@google.com>
 <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
 <ZfqPK7AVunq2SC1l@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfqPK7AVunq2SC1l@google.com>

On Wed, Mar 20, 2024 at 07:24:27AM +0000, Yosry Ahmed wrote:
> [..]
> > > > -     /* map */
> > > > -     spin_lock(&tree->lock);
> > > >       /*
> > > > -      * The folio may have been dirtied again, invalidate the
> > > > -      * possibly stale entry before inserting the new entry.
> > > > +      * We finish initializing the entry while it's already in xarray.
> > > > +      * This is safe because:
> > > > +      *
> > > > +      * 1. Concurrent stores and invalidations are excluded by folio lock.
> > > > +      *
> > > > +      * 2. Writeback is excluded by the entry not being on the LRU yet.
> > > > +      *    The publishing order matters to prevent writeback from seeing
> > > > +      *    an incoherent entry.
> > >
> > > As I mentioned before, writeback is also protected by the folio lock.
> > > Concurrent writeback will find the folio in the swapcache and abort. The
> > > fact that the entry is not on the LRU yet is just additional protection,
> > > so I don't think the publishing order actually matters here. Right?
> > 
> > Right. This comment is explaining why this publishing order does not
> > matter. I think we are talking about the same thing here?
> 
> The comment literally says "the publishing order matters.." :)
> 
> I believe Johannes meant that we should only publish the entry to the
> LRU once it is fully initialized, to prevent writeback from using a
> partially initialized entry.
> 
> What I am saying is that, even if we add a partially initialized entry
> to the zswap LRU, writeback will skip it anyway because the folio is
> locked in the swapcache.
> 
> So basically I think the comment should say:
> 
> 	/*
> 	 * We finish initializing the entry while it's already in the
> 	 * xarray. This is safe because the folio is locked in the swap
> 	 * cache, which should protect against concurrent stores,
> 	 * invalidations, and writeback.
> 	 */
> 
> Johannes, what do you think?

I don't think that's quite right.

Writeback will bail on swapcache insert, yes, but it will access the
entry before attempting it. If LRU publishing happened before setting
entry->swpentry e.g., we'd have a problem, while your comment suggets
it would be safe to rearrange the code like this.

So LRU publishing order does matter.

