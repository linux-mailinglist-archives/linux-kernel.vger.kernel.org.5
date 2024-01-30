Return-Path: <linux-kernel+bounces-43950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A73841B70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B2C1C249D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB338384;
	Tue, 30 Jan 2024 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0lA7dwLV"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AE38387
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592581; cv=none; b=f5muVc8huvp5xdcBVBYeiQ0RxSwBvqd+V6TSlbdQBcI+vsjOVlmA5HF7PXo2icyMvRlb+r+bk/4ttX8czt3V600YZ9+aFx473+aIr3FO/v8Qx+VIG3USL/DgeA+XGacFsUHhzzmxyY5uzRIEEWtr60vXngKEwx+iz3BgkaRK5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592581; c=relaxed/simple;
	bh=bwoX6ohEHDNuHDfSYeSXyxdogAOLcbHWlgflDMLPeEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq3X0QhlRp2gBEGQaoIJD4YUyUcKogKWvIIfidL6FKzPwcm4KVphslD1R21hIgWbz8CKH9PyvY9uluUUH6uHWjoPInnqb/AN6aslBamkrpeDFAdcQ/qaaJfQHxnt+nUxw5e+typbqRRf7Hlg3G5Sb4fGDZK83vFFF8u8yy2mczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0lA7dwLV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1960510a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706592579; x=1707197379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vanmZRR1y5QKkmBQ3KupoInC2hTIn8cCfF2flGLfL1Q=;
        b=0lA7dwLVYzby8Mj7m/yH4EkDQKwl0O6SMclr4za3fN/Es1oobq1jyIlq6+TkCrAgNJ
         DHGX0eHwlzyvWmTU1HH4rC7z5l2Wrv/HEOOfYSGgKI7is5+v2NPKOeafYnR/uPWv3Aax
         KqZrJbY+dNQEXg/RvvHPlhqWg1wesKGIRBDFCAZhmoMx4T6Adjw52cjwXQqaDUttoiu+
         TI/5h9lFMK+EHmsiHm5MCqv3p5B9uZxFTxOx+IeWbjq+bzKX86c0+Ixsq847qv4O1+DM
         tjmp8apGMujvVUYHhFRhDdquD+Q6AYBGGmjzOnvvoUy16AuB7AVPPzcNwY3EulvlSQ0/
         KVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706592579; x=1707197379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vanmZRR1y5QKkmBQ3KupoInC2hTIn8cCfF2flGLfL1Q=;
        b=IJ2dUB3fHaYhgoQbdT0e23RiPsjb7cztKG59sCBJWivv1dvyXuDlxcaBX7uB27eJXc
         AyXMNJHycfz7kMpKhc2fhkoW8w+DwT7X1Aci8Kgv3LPQXDNy8+HodFDSQMLGACFzRxZI
         ALWuvjlgPRIo+YwYTuMW7u8qQTXN8SNPCCAlK9Fj38Ui4A3BKPVkh0tsal21YL9bAknQ
         itCuvXGTijrvTe6WCcGfgyzLe8mdZGcvfJzc/imjP37ottFXk9IQEV/1l851oowFMVP2
         /nlHt1CFTnEQVEiVnFBZlVAZEBpHavKm1/6SkiWP4AxD9K3puzDl+YlmRrFqH297mlGM
         v9Kw==
X-Gm-Message-State: AOJu0YxXRQcn6RRQDGVeoLze+qPQxICQCD+gCw9p3R1zpwPunNStgMEA
	VciqOFrwwAjDWH8sDrTIbRYHKCmVUQid7+L/9dkWwlOcp4XxCrsjeHx4mszLpD0=
X-Google-Smtp-Source: AGHT+IFw7hA4oDv8nkHlg66no17qVoSIkfqyrunXgNkE/oWL4LONcHwUWk8+uCHsvEFMQOIrPZiMUw==
X-Received: by 2002:a17:902:ed04:b0:1d7:2004:67eb with SMTP id b4-20020a170902ed0400b001d7200467ebmr5270694pld.26.1706592578661;
        Mon, 29 Jan 2024 21:29:38 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001d90a67e10bsm422419plq.109.2024.01.29.21.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 21:29:38 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rUggh-00HBSK-1J;
	Tue, 30 Jan 2024 16:29:35 +1100
Date: Tue, 30 Jan 2024 16:29:35 +1100
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
Message-ID: <ZbiJP3Dhjkh6Dz4x@dread.disaster.area>
References: <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
 <ZbcDvTkeDKttPfJ4@dread.disaster.area>
 <ZbciOba1h3V9mmup@fedora>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <ZbdhBaXkXm6xyqgC@fedora>
 <ZbghnK+Hs+if6vEz@dread.disaster.area>
 <ZbhpbpeV6ChPD9NT@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbhpbpeV6ChPD9NT@fedora>

On Tue, Jan 30, 2024 at 11:13:50AM +0800, Ming Lei wrote:
> On Tue, Jan 30, 2024 at 09:07:24AM +1100, Dave Chinner wrote:
> > On Mon, Jan 29, 2024 at 04:25:41PM +0800, Ming Lei wrote:
> > > On Mon, Jan 29, 2024 at 04:15:16PM +1100, Dave Chinner wrote:
> > > > On Mon, Jan 29, 2024 at 11:57:45AM +0800, Ming Lei wrote:
> > > > > On Mon, Jan 29, 2024 at 12:47:41PM +1100, Dave Chinner wrote:
> > > > > > On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > > > > Follows the current report:
> > > > > 
> > > > > 1) usersapce call madvise(willneed, 1G)
> > > > > 
> > > > > 2) only the 1st part(size is from bdi->io_pages, suppose it is 2MB) is
> > > > > readahead in madvise(willneed, 1G) since commit 6d2be915e589
> > > > > 
> > > > > 3) the other parts(2M ~ 1G) is readahead by unit of bdi->ra_pages which is
> > > > > set as 64KB by userspace when userspace reads the mmaped buffer, then
> > > > > the whole application becomes slower.
> > > > 
> > > > It gets limited by file->f_ra->ra_pages being initialised to
> > > > bdi->ra_pages and then never changed as the advice for access
> > > > methods to the file are changed.
> > > > 
> > > > But the problem here is *not the readahead code*. The problem is
> > > > that the user has configured the device readahead window to be far
> > > > smaller than is optimal for the storage. Hence readahead is slow.
> > > > The fix for that is to either increase the device readahead windows,
> > > > or to change the specific readahead window for the file that has
> > > > sequential access patterns.
> > > > 
> > > > Indeed, we already have that - FADV_SEQUENTIAL will set
> > > > file->f_ra.ra_pages to 2 * bdi->ra_pages so that readahead uses
> > > > larger IOs for that access.
> > > > 
> > > > That's what should happen here - MADV_WILLNEED does not imply a
> > > > specific access pattern so the application should be running
> > > > MADV_SEQUENTIAL (triggers aggressive readahead) then MADV_WILLNEED
> > > > to start the readahead, and then the rest of the on-demand readahead
> > > > will get the higher readahead limits.
> > > > 
> > > > > This patch changes 3) to use bdi->io_pages as readahead unit.
> > > > 
> > > > I think it really should be changing MADV/FADV_SEQUENTIAL to set
> > > > file->f_ra.ra_pages to bdi->io_pages, not bdi->ra_pages * 2, and the
> > > > mem.load() implementation in the application converted to use
> > > > MADV_SEQUENTIAL to properly indicate it's access pattern to the
> > > > readahead algorithm.
> > > 
> > > Here the single .ra_pages may not work, that is why this patch stores
> > > the willneed range in maple tree, please see the following words from
> > > the original RH report:
> > 
> > > "
> > > Increasing read ahead is not an option as it has a mixed I/O workload of
> > > random I/O and sequential I/O, so that a large read ahead is very counterproductive
> > > to the random I/O and is unacceptable.
> > > "
> > 
> > Yes, I've read the bug. There's no triage that tells us what the
> > root cause of the application perofrmance issue might be. Just an
> > assertion that "this is how we did it 10 years ago, it's been
> > unchanged for all this time, the new kernel we are upgrading
> > to needs to behave exactly like pre-3.10 era kernels did.
> > 
> > And to be totally honest, my instincts tell me this is more likely a
> > problem with a root cause in poor IO scheduling decisions than be a
> > problem with the page cache readahead implementation. Readahead has
> > been turned down to stop the bandwidth it uses via background async
> > read IO from starving latency dependent foreground random IO
> > operation, and then we're being asked to turn readahead back up
> > in specific situations because it's actually needed for performance
> > in certain access patterns. This is the sort of thing bfq is
> > intended to solve.
> 
> Reading mmaped buffer in userspace is sync IO, and page fault just
> readahead 64KB. I don't understand how block IO scheduler makes a
> difference in this single 64KB readahead in case of cache miss.

I think you've misunderstood what I said. I was refering to the
original customer problem of "too much readahead IO causes problems
for latency sensitive IO" issue that lead to the customer setting
64kB readahead device limits in the first place.

That is, if reducing readahead for sequential IO suddenly makes
synchronous random IO perform a whole lot better and the application
goes faster, then it indicates the problem is IO dispatch
prioritisation, not that there is too much readahead. Deprioritising
readahead will educe it's impact on other IO, without having to
reduce the readahead windows that provide decent sequential IO
perofrmance...

I really think the customer needs to retune their application from
first principles. Start with the defaults, measure where things are
slow, address the worst issue by twiddling knobs. Repeat until
performance is either good enough or they hit on actual problems
that need code changes.

> > > It is even worse for readahead() syscall:
> > > 
> > > 	``` DESCRIPTION readahead()  initiates readahead on a file
> > > 	so that subsequent reads from that file will be satisfied
> > > 	from the cache, and not block on disk I/O (assuming the
> > > 	readahead was initiated early enough and that other activity
> > > 	on the system did not in the meantime flush pages from the
> > > 	cache).  ```
> > 
> > Yes, that's been "broken" for a long time (since the changes to cap
> > force_page_cache_readahead() to ra_pages way back when), but the
> > assumption documented about when readahead(2) will work goes to the
> > heart of why we don't let user controlled readahead actually do much
> > in the way of direct readahead. i.e. too much readahead is
> > typically harmful to IO and system performance and very, very few
> > applications actually need files preloaded entirely into memory.
> 
> It is true for normal readahead, but not sure if it is for
> advise(willneed) or readahead().

If we allowed unbound readahead via WILLNEED or readahead(2), then
a user can DOS the storage and/or the memory allocation subsystem
very easily.

In a previous attempt to revert the current WILLNEED readahead
bounding behaviour changes, Linus said this:

"It's just that historically we've had
some issues with people over-doing readahead (because it often helps
some made-up microbenchmark), and then we end up with latency issues
when somebody does a multi-gigabyte readahead... Iirc, we had exactly
that problem with the readahead() system call at some point (long
ago)."

https://lore.kernel.org/linux-mm/CA+55aFy8kOomnL-C5GwSpHTn+g5R7dY78C9=h-J_Rb_u=iASpg@mail.gmail.com/

Elsewhere in a different thread for a different patchset to try to
revert this readahead behaviour, Linus ranted about how it allowed
unbound, unkillable user controlled readahead for 64-bit data
lengths.

Fundamentally, readahead is not functionality we want to expose
directly to user control. MADV_POPULATE_* is a different in that it
isn't actually readahead - it works more like normal sequential user
page fault access. It is interruptable, it can fail due to ENOMEM or
OOM-kill, it can fail on IO errors, etc. IOWs, The MADV_POPULATE
functions are what the application should be using, not trying to
hack WILLNEED to do stuff that MADV_POPULATE* already does in a
better way...

> > Please read the commit message for commit 4ca9b3859dac ("mm/madvise:
> > introduce MADV_POPULATE_(READ|WRITE) to prefault page tables"). It
> > has some relevant commentary on why MADV_WILLNEED could not be
> > modified to meet the pre-population requirements of the applications
> > that required this pre-population behaviour from the kernel.
> > 
> > With this, I suspect that the application needs to be updated to
> > use MADV_POPULATE_READ rather than MADV_WILLNEED, and then we can go
> > back and do some analysis of the readahead behaviour of the
> > application and the MADV_POPULATE_READ operation. We may need to
> > tweak MADV_POPULATE_READ for large readahead IO, but that's OK
> > because it's no longer "optimistic speculation" about whether the
> > data is needed in cache - the operation being performed guarantees
> > that or it fails with an error. IOWs, MADV_POPULATE_READ is
> > effectively user data IO at this point, not advice about future
> > access patterns...
> 
> BTW, in this report, MADV_WILLNEED is used by java library[1], and I
> guess it could be difficult to update to MADV_POPULATE_READ.

Yes, but that's not an upstream kernel code development problem.
That's a problem for the people paying $$$$$ to their software
vendor to sort out.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

