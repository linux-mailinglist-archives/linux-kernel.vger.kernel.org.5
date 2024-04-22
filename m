Return-Path: <linux-kernel+bounces-153815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8DB8AD3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C083D1C20BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FEB154431;
	Mon, 22 Apr 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckEjR+Qm"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D25153BC6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713809255; cv=none; b=ebHj6YCJ4x37hdPQqVP8+xk7Cyo1Z814y4YUFafqFd3pBEY+abCjkLBCI7Pj6CU4sW/JTXMmYorkVWeXIvt7zaPU0uGNr+upD0qm6DB+Xk/7s/V7Tp6XocTWX2MwZlTKG523OG7gA8KgsFYN+e8vN/zwNFSLqXTJw1Ffz/UVqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713809255; c=relaxed/simple;
	bh=mp5nOahML70hB9ODfs6Ll0+q3JEa0PXvH3k7986kQnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAOBZkUxDWb5ZCXEk9lbnYqNuamzvTSn9GHbVk1G9gpg84ifvPeGfkjA+nRweaYj2qurAeztT0My/IuHhhBKT8G8AtYdISDQpURGYqCsK/3JzQSFtXJ8bvQtX6ra88tfCCpBSX3K3aRsvc56m5Wuqt/3U72oyzeh4tzx4Warezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckEjR+Qm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5721221b0d5so1338803a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713809252; x=1714414052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jWiUOjQt4xoCGElSGzu3IzSt3boCV/cDK6apkE0DR0k=;
        b=ckEjR+QmXMKtmHupgZJcb8NyFLlGwEZKrZAfqqhsA7Cl+zAyGdHEEknrWpbD1XNs+2
         XtM+H1ajmr7OIB0+FycurJ9Jw9ohphx/GXMK2iwEckzvYNYim2U1Gs+BldIcsrSZiJvw
         XKTnDYObjwLGtas/odTWR72sYV9WjT8VixzE3N9mT1zm8ho1vek/WULIkzWySUxRH31e
         DtlXQAnhy05dQ1TifFd227U29p4oW/0vrniVLeClB2sy7J9pk5yx9Npp3rzQoJVVH5BU
         lD6zi9z/TDv5zpQRU7oNENNBl2NNjh7HUzizfoQSi6eiu8YFzVtRO02dBN1TZ1b6vMfg
         G4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713809252; x=1714414052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWiUOjQt4xoCGElSGzu3IzSt3boCV/cDK6apkE0DR0k=;
        b=kgaFmPBGmeUbt+YFzFmBeE+26fRRdiM+Hv0j3bfZUQ+NWnnJ75sQb6YJLkizQeLJJH
         lhvie4dx1oJPGEVthNwgc2bikhy5eakBceNf7asfViA9AS7RfXDz66V43B7sG6HxOjnM
         oV2oKduKMjC8w1YOk6TnBZ3pn+GzYDvqJXyQTMv9HtGLWTzgdKoxHbuICQEQvLhxDZyY
         NB56DkfzLKURnZ0y6x8VGFn17J7dlLaMfTZICwCL/WHCWOsgk9pXK/xTe/xrvfAMO+HN
         A3qm7+xbq84zBUuTDdK5IUWEB+grVgTY08prdSwKfsyaiJywYFASO0yMFjqcmxxGkSJI
         GcbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhrQ9eONHVs+oOzu42qDVDbIAz0Nhq6guw3OZq57FFyku8b1r5WlZKZSmkno/GXEmviUniNJMp+36sbBDhDT6MEAZYJUNo18GQxTXV
X-Gm-Message-State: AOJu0Yw7SOEOU7XrQimRll3/kOwpL7rSOuNirXJoexS7+ZMyo8wzHkEs
	iySP9lqPEnO7GOpElcBUxk9CsKUf/ETd45wz5Ye4sTEER0WjaOyy7sN8OYIF1Za7Khz/9hHow+x
	KlHPZmwF0/kDayaF37RbbLKJsLDV9+lSczXI=
X-Google-Smtp-Source: AGHT+IGAe1lHopBDKrGiT79eAqKkzD8Cl6oGORZoZpBxdojv9WzH+0MrCLBw68jY1jif1fS/eS0HUyU3s0ZWpGtxeRk=
X-Received: by 2002:aa7:d04e:0:b0:571:badc:203d with SMTP id
 n14-20020aa7d04e000000b00571badc203dmr441218edo.16.1713809252013; Mon, 22 Apr
 2024 11:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com>
 <uekqafv4wx5axijnnfybnxixui3ruzy3mkxirflv7tb3ovrtbk@ounqurycykuv>
 <CAJg=8jzRT=oA9g6AGd1KmAY3GBkKkczj1rCqQ+pik5LmUQYd_A@mail.gmail.com>
 <7jhx44ynje54wfcq3bkaui5w6oox7ypd7cgg4u5zhue6rf5tok@nj6jaxppzq2b> <usubtr2bibcnwca3rk3ytbd2jbpvshgu44faujrrrcnidnrr25@ttdhvhrz34vs>
In-Reply-To: <usubtr2bibcnwca3rk3ytbd2jbpvshgu44faujrrrcnidnrr25@ttdhvhrz34vs>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Mon, 22 Apr 2024 11:07:20 -0700
Message-ID: <CAJg=8jyaV20PannVxVQrqasmo3RCTAjOWfmkdm3ehviMoc=V-w@mail.gmail.com>
Subject: Re: general protection fault in mas_empty_area_rev
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Liam,

On Mon, 22 Apr 2024 at 10:05, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> * Liam R. Howlett <Liam.Howlett@oracle.com> [240422 11:25]:
> > * Marius Fleischer <fleischermarius@gmail.com> [240422 11:11]:
> > > Hi Liam,
> > >
> > > Thank you so much for the response!
> > >
> > > > >
> > > > > Crash log:
> > > > >
> > > > > general protection fault, probably for non-canonical address
> > > > > 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > > >
> > > > > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > > > >
> > > > > CPU: 0 PID: 79545 Comm: syz-executor.0 Not tainted 6.9.0-rc4-dirty #3
> > > >
> > > > This indicates that you built with your own patches.  Could you test an
> > > > unmodified 6.9.0-rc4 with your setup?
> > > >
> > >
> > > I'm very sorry for this oversight. I had applied the patches for another bug
> > > from this conversation
> > > (https://lore.kernel.org/all/20240404070702.2744-3-osalvador@suse.de/T/#m480f21ab850996395082d0faab7f624f45b83781)
> > > I will test the reproducer without these patches and get back to you!
> >
> > After testing with your config, I can see that those fixes are needed to
> > boot.
> >
> > I am going to try 6.9-rc5 with your configuration and see if I can
> > trigger the issue there.
> >
>
> The reproducer does not trigger for me with your configuration and
> reproducer.
>
> Does it still happen for you in 6.9-rc5?
>
You are right, indeed, I was not able to boot v6.9-rc4 without the fixes.

I tested the reproducer on 6.9-rc5 (ed30a4a51bb196781c8058073ea720133a65596f)
and it still triggers the crash in my setup. How can I help you
further troubleshoot
this issue?

Thanks,
Marius

