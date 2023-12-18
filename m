Return-Path: <linux-kernel+bounces-3806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5643881722C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4281F24C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F5E5BF9E;
	Mon, 18 Dec 2023 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="vnP0j8j3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6780F3788B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67f4a160dbbso3700146d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1702908236; x=1703513036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SeIfmjTD20WCr2YilJIxer8YjFa9qmpum3ZmpdpwHyc=;
        b=vnP0j8j3nA2tDrIsLef6sAjUi4Y9BsScoIJWfnhWYmTm7v8A+GTgm5ao8qM3p982pl
         OevBvOeIcWRCMdSuTJ1I03LvFeh3gjr1xIRe1T/kb9XfpXKPrqMGzk0zr9VwDGrlLCx0
         YutfYhef88SRi8mBINz3ceIFgruS6choYh+Jh8Lyf3GktjFkOwk7nGlQ0H5Ss62UG4Qj
         M8XFVX/doh+Y6pAwaek0Pfi4H8aI1+ruwSgsXhUXlp9r5T+83udpsuE8vYUEU+IkXfOG
         Y4MUay2l0UirW8mGdMyBkjB9eWH6UeL7A79rBizJactclhOxV/iupVjebOLo+E3HgZSR
         Y6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908236; x=1703513036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeIfmjTD20WCr2YilJIxer8YjFa9qmpum3ZmpdpwHyc=;
        b=k2jUgg8+fxu7TrdeubJNDyoaqwt/PALv/79iK6aQ1tW6ea5dpfn1v0m63MEUoWtjJn
         S/v8nhPABnPTelecyhOiKypatZw4hgUZcpONi0ZbzXyXo0FaXp/uQ0h296TmnX2wDb4S
         Uk7y8v9ZnFxFJEvbhtseoZHFr0jvjfWarTz++YmHnYUThRBfufnPU8lu9X6+Yp4beG7H
         c1yHL1Zexcdf4ykkExQdl6VCn3UgjFm6Bw7z/oo4BFz/Eb54O3Unx9YJAE9Vc+GvIUzW
         FFcb3P0nqX2KWpRqztxxJOh1GKPSzXmVoqWdeIftfWFwsKCsdbtKWbY7ZrAmYFylpb6W
         G/ig==
X-Gm-Message-State: AOJu0YwBLVZgl9hqprLJUJD0xD7jSeBrbWa6fYHd8+PqibZlBHs9DYY0
	chfnbCyY6Rks5EVMsYiXr2OtQw==
X-Google-Smtp-Source: AGHT+IFz9FW2U2XDVOM4MX6gEtXNBqhd0ARPDkjoUkA8I/HFGRb8YMvCepMaTFm2xwQMUsHHTOgkLQ==
X-Received: by 2002:a05:6214:daf:b0:67f:3d1e:ad22 with SMTP id h15-20020a0562140daf00b0067f3d1ead22mr2663046qvh.31.1702908236081;
        Mon, 18 Dec 2023 06:03:56 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:c6bd])
        by smtp.gmail.com with ESMTPSA id mx2-20020a0562142e0200b0067f566221d8sm175076qvb.121.2023.12.18.06.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:03:54 -0800 (PST)
Date: Mon, 18 Dec 2023 15:03:54 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
	Seth Jennings <sjenning@redhat.com>,
	Dan Streetman <ddstreet@ieee.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm/zswap: cleanup zswap_reclaim_entry()
Message-ID: <20231218140313.GA19167@cmpxchg.org>
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com>
 <CAJD7tkb5cKopA-Lfvtsn7sqgqjRf2kyaMwZhhp6SkveNEwArGw@mail.gmail.com>
 <20231214142320.f5cf319e619dbb2127c423e9@linux-foundation.org>
 <CAJD7tkaJVB+BoYmcO3MtGD7Ku88Sjk-VAK640h9B-aQzyGPdZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaJVB+BoYmcO3MtGD7Ku88Sjk-VAK640h9B-aQzyGPdZQ@mail.gmail.com>

On Thu, Dec 14, 2023 at 02:41:26PM -0800, Yosry Ahmed wrote:
> On Thu, Dec 14, 2023 at 2:23 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 13 Dec 2023 17:02:25 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > > On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
> > > <zhouchengming@bytedance.com> wrote:
> > > >
> > > > Also after the common decompress part goes to __zswap_load(), we can
> > > > cleanup the zswap_reclaim_entry() a little.
> > >
> > > I think you mean zswap_writeback_entry(), same for the commit title.
> >
> > I updated my copy of the changelog, thanks.
> >
> > > > -       /*
> > > > -        * If we get here because the page is already in swapcache, a
> > > > -        * load may be happening concurrently. It is safe and okay to
> > > > -        * not free the entry. It is also okay to return !0.
> > > > -        */
> > >
> > > This comment should be moved above the failure check of
> > > __read_swap_cache_async() above, not completely removed.
> >
> > This?
> 
> Yes, thanks a lot. Although I think a new version is needed anyway to
> address other comments.
> 
> >
> > --- a/mm/zswap.c~mm-zswap-cleanup-zswap_reclaim_entry-fix
> > +++ a/mm/zswap.c
> > @@ -1457,8 +1457,14 @@ static int zswap_writeback_entry(struct
> >         mpol = get_task_policy(current);
> >         page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
> >                                 NO_INTERLEAVE_INDEX, &page_was_allocated, true);
> > -       if (!page)
> > +       if (!page) {
> > +               /*
> > +                * If we get here because the page is already in swapcache, a
> > +                * load may be happening concurrently. It is safe and okay to
> > +                * not free the entry. It is also okay to return !0.
> > +                */
> >                 return -ENOMEM;
> > +       }
> >
> >         /* Found an existing page, we raced with load/swapin */
> >         if (!page_was_allocated) {

That's the wrong branch, no?

!page -> -ENOMEM

page && !page_was_allocated -> already in swapcache

Personally, I don't really get the comment. What does it mean that
it's "okay" not to free the entry? There is a put, which may or may
not free the entry if somebody else is using it. Is it explaining how
lifetime works for refcounted objects? I'm similarly confused by the
"it's okay" to return non-zero. What is that trying to convey?

Deletion seemed like the right choice here, IMO ;)

