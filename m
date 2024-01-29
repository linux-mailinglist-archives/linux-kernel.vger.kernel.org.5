Return-Path: <linux-kernel+bounces-43548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B884155F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985351C230F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B97815958D;
	Mon, 29 Jan 2024 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="lFL2BqOA"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E4F158D9E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566053; cv=none; b=oRgN62LtJFHZse0f/856rzRCXXoOkPZFmao7f3PU3egb8iLWEX+Xb3qXfgrbsyyyRZ8slxFyDXVF6g+prn96ef2+DnqUIXCKDoxoIMPb4ER6j/9waxEE7M/lM8qUSDzs+sgfVYObjIfjOItEAQT/YaNEwWTCqTGoK55sNKmckQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566053; c=relaxed/simple;
	bh=yEzWXYpJ0zzsfLH9yoENH2HRJkA6mj6FdpG+ugY3fhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkXgymOlUEDN+rSYSASS8BSCUqpwvOXm3jdzN1Vfuj1mS0IdW5bj4gbiaegtbthsLYUEf5KUI4y07Ey8aBFNhpXlqXOdmF8PvleXVB8f0Pm1LnC/t2eytWlUmvIdonSM2I2oZea9XjH2hyCyRSJS2DaF8GRX+VSmSARZBfECLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=lFL2BqOA; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-595b208a050so2262908eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706566050; x=1707170850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkOK2ky57QWvLHymi2f083eMbmQg+Iob+b+B/RRjeqM=;
        b=lFL2BqOA25ZiZLccZCqarYVbk7s9lzka/jD2p1x5dDjHYDDlEQapEBMYBr2Z0qabrx
         6nCiDvqXSV7WP9/hGVmB7MVatpx9j+6zL0CEoTfZG37kNxGGyXSPCGhTBIoLpiMHnaXH
         A8JyRF//IrocwDqizXQ5Jw1IeEZWhK0ccB0zCK9VbPNnP6utimyeDJM+5nVTFEQmXaV+
         B5IWi8GmqQ64Q5+UU6wBEcfdBi5BufJ1HC/c/+oQaHEC+GCN+ZcojX17S6HB3sBIcPOD
         dQQdBBhIEiBAepIDn+YbmsatDg+Qqv44moAt4stYMTdyBP7toF+PO1/8NpmToplBYBER
         mVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706566050; x=1707170850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkOK2ky57QWvLHymi2f083eMbmQg+Iob+b+B/RRjeqM=;
        b=b5ZtRoZ2y/RHOgFYKw2dMdfkW/RxnsYZ3NZarFDUfQkWt54wJdnVvwAhupWBEe0+L4
         VdRdqDHXJCisJ4is2iFv/QcXaV7wllWnXbyURHvl2nSHoa/phvfWOGBNMb4Y6/d6xq/e
         Kc9I5Eg9ouPYHiOPq9vMQLE39dezp4+AV5WEh3BVtR+8ilwzUVZFmELZW7dX4B8BqE2n
         FIFtHs6cc4/CqTCff7BZ3rRw63MY6yhEsjyHPn8h/v5QDgFpP+uGnYxBWdU1X+TODN+V
         DYw/Ys6uqD/gGEoeFSryVG8OTTuB1C1nxh0t4THQqD9wUTWxVxSCl5IY40rBX4S6bj/t
         7VUg==
X-Gm-Message-State: AOJu0YxPlpNThnI92XiujfbnwKMh7eeLNEHMzgBrYiMiocMRwzknQaEN
	DLa1KcLKyEzX5LwOwC0AxxIeASgm7k3cErY1cZdR1i4sFMLAg/SlWygewXUAEYM=
X-Google-Smtp-Source: AGHT+IHqFp8kC5K5GfPaXb9+ihxnatcrPICumwWH3mnaHLyMvECkA4Ua2vHGp4VeYhJjrFZ6wQGdfQ==
X-Received: by 2002:a05:6358:7e99:b0:178:7f7f:2460 with SMTP id o25-20020a0563587e9900b001787f7f2460mr1290013rwn.47.1706566049776;
        Mon, 29 Jan 2024 14:07:29 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id jw3-20020a056a00928300b006dbd2231184sm6320885pfb.70.2024.01.29.14.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:07:29 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rUZmm-00H2v9-1z;
	Tue, 30 Jan 2024 09:07:24 +1100
Date: Tue, 30 Jan 2024 09:07:24 +1100
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
Message-ID: <ZbghnK+Hs+if6vEz@dread.disaster.area>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
 <ZbcDvTkeDKttPfJ4@dread.disaster.area>
 <ZbciOba1h3V9mmup@fedora>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <ZbdhBaXkXm6xyqgC@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbdhBaXkXm6xyqgC@fedora>

On Mon, Jan 29, 2024 at 04:25:41PM +0800, Ming Lei wrote:
> On Mon, Jan 29, 2024 at 04:15:16PM +1100, Dave Chinner wrote:
> > On Mon, Jan 29, 2024 at 11:57:45AM +0800, Ming Lei wrote:
> > > On Mon, Jan 29, 2024 at 12:47:41PM +1100, Dave Chinner wrote:
> > > > On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > > Follows the current report:
> > > 
> > > 1) usersapce call madvise(willneed, 1G)
> > > 
> > > 2) only the 1st part(size is from bdi->io_pages, suppose it is 2MB) is
> > > readahead in madvise(willneed, 1G) since commit 6d2be915e589
> > > 
> > > 3) the other parts(2M ~ 1G) is readahead by unit of bdi->ra_pages which is
> > > set as 64KB by userspace when userspace reads the mmaped buffer, then
> > > the whole application becomes slower.
> > 
> > It gets limited by file->f_ra->ra_pages being initialised to
> > bdi->ra_pages and then never changed as the advice for access
> > methods to the file are changed.
> > 
> > But the problem here is *not the readahead code*. The problem is
> > that the user has configured the device readahead window to be far
> > smaller than is optimal for the storage. Hence readahead is slow.
> > The fix for that is to either increase the device readahead windows,
> > or to change the specific readahead window for the file that has
> > sequential access patterns.
> > 
> > Indeed, we already have that - FADV_SEQUENTIAL will set
> > file->f_ra.ra_pages to 2 * bdi->ra_pages so that readahead uses
> > larger IOs for that access.
> > 
> > That's what should happen here - MADV_WILLNEED does not imply a
> > specific access pattern so the application should be running
> > MADV_SEQUENTIAL (triggers aggressive readahead) then MADV_WILLNEED
> > to start the readahead, and then the rest of the on-demand readahead
> > will get the higher readahead limits.
> > 
> > > This patch changes 3) to use bdi->io_pages as readahead unit.
> > 
> > I think it really should be changing MADV/FADV_SEQUENTIAL to set
> > file->f_ra.ra_pages to bdi->io_pages, not bdi->ra_pages * 2, and the
> > mem.load() implementation in the application converted to use
> > MADV_SEQUENTIAL to properly indicate it's access pattern to the
> > readahead algorithm.
> 
> Here the single .ra_pages may not work, that is why this patch stores
> the willneed range in maple tree, please see the following words from
> the original RH report:

> "
> Increasing read ahead is not an option as it has a mixed I/O workload of
> random I/O and sequential I/O, so that a large read ahead is very counterproductive
> to the random I/O and is unacceptable.
> "

Yes, I've read the bug. There's no triage that tells us what the
root cause of the application perofrmance issue might be. Just an
assertion that "this is how we did it 10 years ago, it's been
unchanged for all this time, the new kernel we are upgrading
to needs to behave exactly like pre-3.10 era kernels did.

And to be totally honest, my instincts tell me this is more likely a
problem with a root cause in poor IO scheduling decisions than be a
problem with the page cache readahead implementation. Readahead has
been turned down to stop the bandwidth it uses via background async
read IO from starving latency dependent foreground random IO
operation, and then we're being asked to turn readahead back up
in specific situations because it's actually needed for performance
in certain access patterns. This is the sort of thing bfq is
intended to solve.


> Also almost all these advises(SEQUENTIA, WILLNEED, NORMAL, RANDOM)
> ignore the passed range, and the behavior becomes all or nothing,
> instead of something only for the specified range, which may not
> match with man, please see 'man posix_fadvise':

The man page says:

	The advice is not binding; it merely constitutes an
	expectation on behalf of the application.

> It is even worse for readahead() syscall:
> 
> 	``` DESCRIPTION readahead()  initiates readahead on a file
> 	so that subsequent reads from that file will be satisfied
> 	from the cache, and not block on disk I/O (assuming the
> 	readahead was initiated early enough and that other activity
> 	on the system did not in the meantime flush pages from the
> 	cache).  ```

Yes, that's been "broken" for a long time (since the changes to cap
force_page_cache_readahead() to ra_pages way back when), but the
assumption documented about when readahead(2) will work goes to the
heart of why we don't let user controlled readahead actually do much
in the way of direct readahead. i.e. too much readahead is
typically harmful to IO and system performance and very, very few
applications actually need files preloaded entirely into memory.

----

All said, I'm starting to think that there isn't an immediate
upstream kernel change needed right now.  I just did a quick check
through the madvise() man page to see if I'd missed anything, and I
most definitely did miss what is a relatively new addition to it:

MADV_POPULATE_READ (since Linux 5.14)
     "Populate (prefault) page tables readable, faulting in all
     pages in the range just as if manually reading from each page;
     however, avoid the actual memory access that would have been
     performed after handling the fault.

     In contrast to MAP_POPULATE, MADV_POPULATE_READ does not hide
     errors, can be applied to (parts of) existing mappings and will
     al‐ ways  populate (prefault) page tables readable.  One
     example use case is prefaulting a file mapping, reading all
     file content from disk; however, pages won't be dirtied and
     consequently won't have to be written back to disk when
     evicting the pages from memory.

That's exactly what the application is apparently wanting
MADV_WILLNEED to do.

Please read the commit message for commit 4ca9b3859dac ("mm/madvise:
introduce MADV_POPULATE_(READ|WRITE) to prefault page tables"). It
has some relevant commentary on why MADV_WILLNEED could not be
modified to meet the pre-population requirements of the applications
that required this pre-population behaviour from the kernel.

With this, I suspect that the application needs to be updated to
use MADV_POPULATE_READ rather than MADV_WILLNEED, and then we can go
back and do some analysis of the readahead behaviour of the
application and the MADV_POPULATE_READ operation. We may need to
tweak MADV_POPULATE_READ for large readahead IO, but that's OK
because it's no longer "optimistic speculation" about whether the
data is needed in cache - the operation being performed guarantees
that or it fails with an error. IOWs, MADV_POPULATE_READ is
effectively user data IO at this point, not advice about future
access patterns...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

