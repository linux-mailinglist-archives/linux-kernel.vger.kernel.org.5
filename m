Return-Path: <linux-kernel+bounces-42186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FFA83FDA7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D10628722E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1800C47A62;
	Mon, 29 Jan 2024 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="BkKYq7pr"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559045958
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505326; cv=none; b=JU5gJ+wX4cpc0nqRDTTm+qsrDnKeqKOC3lm714PLj/Mm9P911ru4Wq34z8qye/WpGDzXN4Bg8XDSuv9WF0KjWn8G9roCPfS+KiBLbmlaoHhElRZkZK5sxa2cazfikxVbO4ziSwIkx7ZwSJzbI/0DhIaT8l3+uHZAHbHKweKs4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505326; c=relaxed/simple;
	bh=sYJ01KRgJ0qUN+iB6Hi1omRu6ElpgexbhZcFP/ArE/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvA556hKEYjxVcZNOn+8HQhe2Eo4pt6hH6/UV8mMBCLZThhbBmZwUKMpmGoSe+WLusoaVqguSznNm98dlPK+xnPZZAHXBtzj4CwUlYY0KfC8Kr4LMnGaJZlTD6tMXdRnyAmdG63bwihirCnF5U+0F11sXmH3QgNYQaKM0TQ8snc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=BkKYq7pr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6de2f8d6fb9so267118b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706505324; x=1707110124; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MzCJhbr94fRn8OFzgvOn2yQbiBfC+VkQTRw5GLu7Xvk=;
        b=BkKYq7prexFZDQBmHAkBmKfyxskixXIXFPIm0Ua1IJ+LgqeYdjFwAfbAYuQa44o7Xd
         8JmCMp9KDPptuGlrhZBH67jD48OMmxiHJVVRzG4lqGPBTKF5Je9QFP/Xl8gtmbFtrpu5
         7GwHloDJDRIid+Kwr86iB4+IojWymz73JuQZ3TShCIk0SEIAbMaeZ8NOR2JguJpt6U9n
         Qh9o5FeKaIvbAAbJ9yPnCsJ41tlR6kxN6c4M1bsonE9vZjbaqllbzlnaBT4XfoZuVtJg
         kM7EXa1sEF6MvH9R9/afMNqa822D0fCTo2seAyf737/k6kvKHzpjF7jAMtSz85fPBp4W
         LN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706505324; x=1707110124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzCJhbr94fRn8OFzgvOn2yQbiBfC+VkQTRw5GLu7Xvk=;
        b=RP4zHfoDKe9R33RFeKjHARmsDhNNXOwRmiTHsJHfN9AtwXYbcBM8v6Lk7t9jfsdZNd
         53YupBj0Vly8q49YMhWqss0TBrARAWjj8bsBicCwBKRAWfmrifFCnX/Iz9r4MVeJgt/F
         8ex5mD6hoQQeZySsXRXkmdxaXgiOdmu3AVOOt+6fff6JruFl6enXOxwGpmXfYe7zfp6M
         wVx2Q4ogjNIWi6YyZGgGfqC3IR7V77twBhmk1xez2uQZJTi4TH+b/nznMgbMdR5H82zh
         HgHp6PBYVTHNzoHr72WD250HUOP6W85/T+ybLbvtAdDNA/w4ysaNQ0yb99IZNNOWSnx9
         8t1Q==
X-Gm-Message-State: AOJu0Yw+f+ufWm/QeGbtAtqIy1B/biRBBNqw/AT/2ua5DngWF+tj40JM
	4kDLnt1OovHYn9o63lki75tKdktwGvO5bl70Mt3U8iZW5qUCCAomWCtZQ5faYf8=
X-Google-Smtp-Source: AGHT+IGANgJ4Z2U1cic1qfkdu+LrVftCh5DoXKhkXGOBg6TiBffjvJTExqp//91HJcFTxKSobu8QBQ==
X-Received: by 2002:a05:6a00:d74:b0:6dd:8a25:e167 with SMTP id n52-20020a056a000d7400b006dd8a25e167mr3050277pfv.34.1706505323985;
        Sun, 28 Jan 2024 21:15:23 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00218a00b006dbd1b13d29sm4911312pfi.208.2024.01.28.21.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 21:15:23 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rUJzI-00GjMK-2X;
	Mon, 29 Jan 2024 16:15:16 +1100
Date: Mon, 29 Jan 2024 16:15:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <Zbc0ZJceZPyt8m7q@dread.disaster.area>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
 <ZbcDvTkeDKttPfJ4@dread.disaster.area>
 <ZbciOba1h3V9mmup@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbciOba1h3V9mmup@fedora>

On Mon, Jan 29, 2024 at 11:57:45AM +0800, Ming Lei wrote:
> On Mon, Jan 29, 2024 at 12:47:41PM +1100, Dave Chinner wrote:
> > On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > > On Sun, Jan 28, 2024 at 7:22 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> > > > > On Sun, Jan 28 2024 at  5:02P -0500,
> > > > > Matthew Wilcox <willy@infradead.org> wrote:
> > > > Understood.  But ... the application is asking for as much readahead as
> > > > possible, and the sysadmin has said "Don't readahead more than 64kB at
> > > > a time".  So why will we not get a bug report in 1-15 years time saying
> > > > "I put a limit on readahead and the kernel is ignoring it"?  I think
> > > > typically we allow the sysadmin to override application requests,
> > > > don't we?
> > > 
> > > The application isn't knowingly asking for readahead.  It is asking to
> > > mmap the file (and reporter wants it done as quickly as possible..
> > > like occurred before).
> > 
> > ... which we do within the constraints of the given configuration.
> > 
> > > This fix is comparable to Jens' commit 9491ae4aade6 ("mm: don't cap
> > > request size based on read-ahead setting") -- same logic, just applied
> > > to callchain that ends up using madvise(MADV_WILLNEED).
> > 
> > Not really. There is a difference between performing a synchronous
> > read IO here that we must complete, compared to optimistic
> > asynchronous read-ahead which we can fail or toss away without the
> > user ever seeing the data the IO returned.
> 
> Yeah, the big readahead in this patch happens when user starts to read
> over mmaped buffer instead of madvise().

Yes, that's how it is intended to work :/

> > We want required IO to be done in as few, larger IOs as possible,
> > and not be limited by constraints placed on background optimistic
> > IOs.
> > 
> > madvise(WILLNEED) is optimistic IO - there is no requirement that it
> > complete the data reads successfully. If the data is actually
> > required, we'll guarantee completion when the user accesses it, not
> > when madvise() is called.  IOWs, madvise is async readahead, and so
> > really should be constrained by readahead bounds and not user IO
> > bounds.
> > 
> > We could change this behaviour for madvise of large ranges that we
> > force into the page cache by ignoring device readahead bounds, but
> > I'm not sure we want to do this in general.
> > 
> > Perhaps fadvise/madvise(willneed) can fiddle the file f_ra.ra_pages
> > value in this situation to override the device limit for large
> > ranges (for some definition of large - say 10x bdi->ra_pages) and
> > restore it once the readahead operation is done. This would make it
> > behave less like readahead and more like a user read from an IO
> > perspective...
> 
> ->ra_pages is just one hint, which is 128KB at default, and either
> device or userspace can override it.
> 
> fadvise/madvise(willneed) already readahead bytes from bdi->io_pages which
> is the max device sector size(often 10X of ->ra_pages), please see
> force_page_cache_ra().

Yes, but if we also change vma->file->f_ra->ra_pages during the
WILLNEED operation (as we do for FADV_SEQUENTIAL) then we get a
larger readahead window for the demand-paged access portion of the
WILLNEED access...

> 
> Follows the current report:
> 
> 1) usersapce call madvise(willneed, 1G)
> 
> 2) only the 1st part(size is from bdi->io_pages, suppose it is 2MB) is
> readahead in madvise(willneed, 1G) since commit 6d2be915e589
> 
> 3) the other parts(2M ~ 1G) is readahead by unit of bdi->ra_pages which is
> set as 64KB by userspace when userspace reads the mmaped buffer, then
> the whole application becomes slower.

It gets limited by file->f_ra->ra_pages being initialised to
bdi->ra_pages and then never changed as the advice for access
methods to the file are changed.

But the problem here is *not the readahead code*. The problem is
that the user has configured the device readahead window to be far
smaller than is optimal for the storage. Hence readahead is slow.
The fix for that is to either increase the device readahead windows,
or to change the specific readahead window for the file that has
sequential access patterns.

Indeed, we already have that - FADV_SEQUENTIAL will set
file->f_ra.ra_pages to 2 * bdi->ra_pages so that readahead uses
larger IOs for that access.

That's what should happen here - MADV_WILLNEED does not imply a
specific access pattern so the application should be running
MADV_SEQUENTIAL (triggers aggressive readahead) then MADV_WILLNEED
to start the readahead, and then the rest of the on-demand readahead
will get the higher readahead limits.

> This patch changes 3) to use bdi->io_pages as readahead unit.

I think it really should be changing MADV/FADV_SEQUENTIAL to set
file->f_ra.ra_pages to bdi->io_pages, not bdi->ra_pages * 2, and the
mem.load() implementation in the application converted to use
MADV_SEQUENTIAL to properly indicate it's access pattern to the
readahead algorithm.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

