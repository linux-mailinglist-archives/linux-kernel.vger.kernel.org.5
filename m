Return-Path: <linux-kernel+bounces-154819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 258318AE178
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECAF2816B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE35FB8B;
	Tue, 23 Apr 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6fHOGvL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZIDmakrX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196C5FB8A;
	Tue, 23 Apr 2024 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866154; cv=none; b=r1OJ6RWmWV5r31lsUxbbEVjZk7Y/1Y1PNhQISFWxgqIjnUccTSsgjkRZN0mUtc784wfRbtgPq8OaS4sRVjCPsVr4UNK1pIeyMAbyf8HYw/VF5UbUDKtXXpI3uW45bXW0NJwuLREwSUbi/GNc5FPda8jp0axvXTRAHFrmXDe59po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866154; c=relaxed/simple;
	bh=DDWpt3khOTNI7W+Fcpu9tbc/QD9yO4O+KnzheVduoaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6MrLiGbhtjtkdpvNkU4qRs4T2Qk+TT1IriG2KEfTYJXo3D2VMez2acgXybXa04ku7s6lOqn1bTEh3AVZbCGA5c/UjOSdJH4/USrGqJa59GW1A30XhQOPe+hMXhujiZkjre9ZpSP8CobeJyUXUuo5XLuBwa4FINaWYDDTt3RS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6fHOGvL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZIDmakrX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 23 Apr 2024 11:55:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713866143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Nx8yqSMqk6NdlHtzGLr2MTDXlYiWPZXvaqNERsKydY=;
	b=p6fHOGvLuVoHHVptkxTjdyLfrBv/WEUM0rlQrTqhpX36rDzQgjzSH+hNseUJgQJw3RlhBd
	f8lnqsFU+t9HaTzU2cRZx0NlRwQTQjjto9V8iSC2ceGA2EnsuZxnbO/V0z9R8CiLrLHKxq
	jlRjQ/8rtKy5Lz7nCFi7ocnZdCgUWcGNv8i5PlIh/Wl4HVOiS5NwPbnMpfkAG3UPkAT0Rm
	8cOBxJ/omnplMWI7TJtQRCYsndrmztP0kllxBqvnpFtww9Z/+QM+dTzWYv6UFVIFhIT7WZ
	Cnw2VgLBbSqBu61KpWwpUuHDxV5nollqMpd5HxiTdAlityU74JEbrmhGRlQ2Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713866143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Nx8yqSMqk6NdlHtzGLr2MTDXlYiWPZXvaqNERsKydY=;
	b=ZIDmakrXTzr5H1pBUDD/Ih1wjrZUweXTIe9y3xeNQ8KsXbLpFS48/EwqhFaTi1uw3a1skv
	ZD1y/oO8yHSofBAg==
From: Nam Cao <namcao@linutronix.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jaya Kumar <jayalk@intworks.biz>, Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, tiwai@suse.de, bigeasy@linutronix.de,
	patrik.r.jakobsson@gmail.com,
	Vegard Nossum <vegard.nossum@oracle.com>,
	George Kennedy <george.kennedy@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>, chuansheng.liu@intel.com,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: fix incorrect address computation in deferred IO
Message-ID: <20240423095538.m79ML6a0@linutronix.de>
References: <20240419190032.40490-1-namcao@linutronix.de>
 <666d986e-5227-4b6d-829c-95ff16115488@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <666d986e-5227-4b6d-829c-95ff16115488@suse.de>

On Tue, Apr 23, 2024 at 10:37:41AM +0200, Thomas Zimmermann wrote:
> Hi,
> 
> thanks for following through with the bug and sending the patch
> 
> Am 19.04.24 um 21:00 schrieb Nam Cao:
> > With deferred IO enabled, a page fault happens when data is written to the
> > framebuffer device. Then driver determines which page is being updated by
> > calculating the offset of the written virtual address within the virtual
> > memory area, and uses this offset to get the updated page within the
> > internal buffer. This page is later copied to hardware (thus the name
> > "deferred IO").
> > 
> > This calculation is only correct if the virtual memory area is mapped to
> > the beginning of the internal buffer. Otherwise this is wrong. For example,
> > if users do:
> >      mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0xff000);
> > 
> > Then the virtual memory area will mapped at offset 0xff000 within the
> > internal buffer. This offset 0xff000 is not accounted for, and wrong page
> > is updated. This will lead to wrong pixels being updated on the device.
> > 
> > However, it gets worse: if users do 2 mmap to the same virtual address, for
> > example:
> > 
> >      int fd = open("/dev/fb0", O_RDWR, 0);
> >      char *ptr = (char *) 0x20000000ul;
> >      mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0xff000);
> >      *ptr = 0; // write #1
> >      mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0);
> >      *ptr = 0; // write #2
> > 
> > In this case, both write #1 and write #2 apply to the same virtual address
> > (0x20000000ul), and the driver mistakenly thinks the same page is being
> > written to. When the second write happens, the driver thinks this is the
> > same page as the last time, and reuse the page from write #1. The driver
> > then lock_page() an incorrect page, and returns VM_FAULT_LOCKED with the
> > correct page unlocked. It is unclear what will happen with memory
> > management subsystem after that, but likely something terrible.
> 
> Please tone down the drama. :)

Sorry, that wasn't intentional. Writing is hard :(

Let me just cut this out, this info is not really needed to justify the
changes.

> 
> > 
> > Fix this by taking the mapping offset into account.
> > 
> > Reported-and-tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > Closes: https://lore.kernel.org/linux-fbdev/271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com
> > Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > ---
> >   drivers/video/fbdev/core/fb_defio.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
> > index dae96c9f61cf..d5d6cd9e8b29 100644
> > --- a/drivers/video/fbdev/core/fb_defio.c
> > +++ b/drivers/video/fbdev/core/fb_defio.c
> > @@ -196,7 +196,8 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
> >    */
> >   static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_info *info, struct vm_fault *vmf)
> >   {
> > -	unsigned long offset = vmf->address - vmf->vma->vm_start;
> > +	unsigned long offset = vmf->address - vmf->vma->vm_start
> > +			+ (vmf->vma->vm_pgoff << PAGE_SHIFT);
> 
> The page-fault handler at [1] use vm_fault.pgoff to retrieve the page
> structure. Can we do the same here and avoid that computation?

Yes, thanks for the suggestion.

It will change things a bit: offset will not be the exact value anymore,
but will be rounded down to multiple of PAGE_SIZE. But that doesn't matter,
because it will only be used to calculate the page offset later on.

We can clean this up and rename this "offset" to "pg_offset". But that's
for another day.

Best regards,
Nam

