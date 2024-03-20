Return-Path: <linux-kernel+bounces-108538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F253880BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163FEB22B05
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A020DCD;
	Wed, 20 Mar 2024 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoLHUiKV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE81EEE0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919473; cv=none; b=uSMjj+u9SrLKsrndR46g1ppXOKxQCBn4wbdYlEQsDexn3HYvkTPPKwxLaOqMcKBKUndpE4QZNTFG/t1Lv/W3NhYwjobDdduNNfiIaNpsSU0rDZpCjlnp5woJ7+KhNT8PkVwrE3Jb8VB9glZgcIhC7uDAqsfiSMsPGXKw4xHPMr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919473; c=relaxed/simple;
	bh=28P57Ke0dbK+IeJ0axzZcEs9sf1skvjRGuluIRciE+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h3zFg12uSL4SDW79/nbOUbPHRQIKBGMBaz1wqJ88lwf7R3uu0bUuzK33dKTI4JaeVovmcYHiWKVA5eoDOceFgZUs7QAPh7XGWu0MLam0tYaASKz+7q1JF1SNwYNdpCUTLBwWAeTClR5//K9SJsH5ZM21u3KOc9lmnbYxcmF323g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoLHUiKV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so11346240276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710919470; x=1711524270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdxVN0VZOTjmFNJigRO9F2rl5jmImdVJnsiuxriNi0Y=;
        b=BoLHUiKVbI13VdVfl9qbwJ4R2ynvZBitxHrALui6NzdSWYxi/xOS65ZhdmPiVPNqIS
         gP4wPz70I76X2tWqyhml9QpX1y/unMC2QA2wLpcY40fn/sqBwc9WMm6PiiyMS3a+QyYG
         Hyw7K7CjudWbsp9ux0sYcDjTUiTlg5gf89l3rkuHSDJnoV+N+5PATMAdZls/Ksrn8F0T
         Ld71iIQMfIOnDD3hH5AZIn209dGEzAhoo5oTT2UTAfj3X+AQl4dgEpZG3FNUrE3Tr3l2
         9VlAqqhELmvGk+sonEcOaLQjZOaXKhf9IV3U+mCWDGSlWDxlY6YJgklVZx3Gb1Xd8XSQ
         rnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710919470; x=1711524270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdxVN0VZOTjmFNJigRO9F2rl5jmImdVJnsiuxriNi0Y=;
        b=bu8NwstF/xM/NZi/Pm1rjvIe4i3ndXEejsO3hy/snlehHV9UdSWdj9Iuz9ZoCDtMsY
         ntqu0PvdmktIYb/jAVR2wMhLj/kQOKSZZyhZys6F65dw3x++iI7BjFVZqtlrA9Qni33n
         T7JlZHJTP2ZxppbTXFJ98UgBllw07us8d07vySJNkFMdasQYVDBUfmrcBi8GSr5nAsjx
         vYZi7mxOtF3+u3QGvZJCMlWP+k035drnPJERyjckSZdDnhfh3D2oAjpCZDDCn7jg0OB9
         Lrgd5XKd8Re8uqyox67v0Ea41YpuSC8LxIGnYHlHdGM3enk8ZsmQlFBwA1/+oNOuf22K
         B6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv0nG00MSKOtiVBPyXmVCHNKlJMUBLqTT7rHcBfEY0ZL1cbx++SFx/gyEj9i7Wfsd1mysYvzjdGQuhIJ5JF+ob8Jtv1YWC4iH/ov+R
X-Gm-Message-State: AOJu0YzQHkL7DLOrV0c4Qbw6EqeHIXXp0qn7nk2pdKeTmAK8/dYQl8di
	cYWMwfae45oZDMCSUHlzVj/nlbhGIwD/V4+6w0eLEHAqHC1TPLd3WvdLgteyUN4SMOJADRYyN6j
	+u2ADuvYkDZ2cfESotg==
X-Google-Smtp-Source: AGHT+IFAjPaqqQcKbeydP6MHZQdihePR91rwKuw9/CirPYjLnwS1+VvZ7x1qZMlGNReEhNYJtzqSLF4ZeO8jzrSt
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:100e:b0:dc9:5ef8:2b2d with
 SMTP id w14-20020a056902100e00b00dc95ef82b2dmr4326404ybt.4.1710919470153;
 Wed, 20 Mar 2024 00:24:30 -0700 (PDT)
Date: Wed, 20 Mar 2024 07:24:27 +0000
In-Reply-To: <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
 <Zfp-iWaDfqeCOElt@google.com> <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
Message-ID: <ZfqPK7AVunq2SC1l@google.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
From: Yosry Ahmed <yosryahmed@google.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

[..]
> > > -     /* map */
> > > -     spin_lock(&tree->lock);
> > >       /*
> > > -      * The folio may have been dirtied again, invalidate the
> > > -      * possibly stale entry before inserting the new entry.
> > > +      * We finish initializing the entry while it's already in xarray.
> > > +      * This is safe because:
> > > +      *
> > > +      * 1. Concurrent stores and invalidations are excluded by folio lock.
> > > +      *
> > > +      * 2. Writeback is excluded by the entry not being on the LRU yet.
> > > +      *    The publishing order matters to prevent writeback from seeing
> > > +      *    an incoherent entry.
> >
> > As I mentioned before, writeback is also protected by the folio lock.
> > Concurrent writeback will find the folio in the swapcache and abort. The
> > fact that the entry is not on the LRU yet is just additional protection,
> > so I don't think the publishing order actually matters here. Right?
> 
> Right. This comment is explaining why this publishing order does not
> matter. I think we are talking about the same thing here?

The comment literally says "the publishing order matters.." :)

I believe Johannes meant that we should only publish the entry to the
LRU once it is fully initialized, to prevent writeback from using a
partially initialized entry.

What I am saying is that, even if we add a partially initialized entry
to the zswap LRU, writeback will skip it anyway because the folio is
locked in the swapcache.

So basically I think the comment should say:

	/*
	 * We finish initializing the entry while it's already in the
	 * xarray. This is safe because the folio is locked in the swap
	 * cache, which should protect against concurrent stores,
	 * invalidations, and writeback.
	 */

Johannes, what do you think?

