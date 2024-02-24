Return-Path: <linux-kernel+bounces-79890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955288627F3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C116282368
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CFC4D9F7;
	Sat, 24 Feb 2024 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0+W48qr"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9C14B820;
	Sat, 24 Feb 2024 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814034; cv=none; b=VTEIl0aGjM8xqXZKPlbcudnS0HdNzEWrvh9dmdE7Z8bK26bnWqCsp6Tr8N1XuHFd1KL3jxWKy3PkTn6d4Ktpg548jlSUVygzMmaoWYxNuh/5NVEMXmXFjFQRZ70oCJeCBEuQERBy1/0zBwk6mSBIcUqBxAm8XKheEL6kln6J6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814034; c=relaxed/simple;
	bh=5cN6RyEs305wtcE1lbo5oKHKBFN5ZgQUw5ebMX49fcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dpkp4orUAT9Pe9hJaPMnArlhTOtUXeqZcI4pcl1Of/0+DALs2JLOgsXku12i2XpshLe+epV3impY7I3aEOtBihPwzkccjlDXwlt5D/XxydGAncVntjF34DPZdDZBPnVqIfbXjmdQzUCkjXa1a6ewXFXVuOIf8gv6IgKLDdwlW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0+W48qr; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c15dd2a1fdso1640873b6e.2;
        Sat, 24 Feb 2024 14:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708814032; x=1709418832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6gPHmRlLFFQMWkc4uxPzbDvlnlcPP+R+SMH5i+OHHA=;
        b=m0+W48qrZXIP10G3IPrRV13842HLA905e4lknjVsLjtv5aoufmDItk6BR+7cK9QtEH
         UeSs7H2IZBu+ZEUkkJe1pCr5zw7ALF6NoBhuaFqEUagtQbfiu3La89mWnb3ZpthC0/td
         uZFmLfdPonw1/lDRWcuQdXYptP/iFtIPIeySBscRKycYRhjFoOuedZwVc8qmV0BWEFjW
         4u9whgA3vPhtpSnwDqLKhE3iVdC2djIYbmloB7jhkdiTp6YpP56ELwXOqTqXna5Mz/S4
         zx6bgWkUFs/Ev1uWtDkPdZNwX+4a8jRQUaA8JGJl8wWOVbvdYcZzSryVUXM318kVQRIv
         HE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708814032; x=1709418832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6gPHmRlLFFQMWkc4uxPzbDvlnlcPP+R+SMH5i+OHHA=;
        b=tL1GKgseW/16RV8KnoC5Ji9PNKBJ+LlM2atj823pvG2ii5HQ6g3g2CBeXBwR4+0cvj
         CVU697pB3ePdXyew5DTrcBGYFUS3G3PFtpD7NZozIGltm1Hog/xpFBTrIRVLxPNFzZ68
         maSlD43W9IKzGSlzXIip3UWBtNHmudQw1j97OOlz5NCruzj8vZugY0NApfAfojA4gcGG
         w83ACyJbXgz6q6WACZADvMqX+MHcMfFhRkW/pExVzQN2XBo0b3FRB9QSFc3LFWK22H0D
         3tVoXUwWlL5aHv2ZVMoEN9gz4dRmHdksU6jPpGJYuAnX0oGLSSSZuD2TR8kUmFMZtgGd
         dMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkSAo4gXy7k+jTaN/leeZ/Hd86Pw7JqBdMePDOZ5m+SDLsJJ6G3LRkTXSXT7XFIdobJ9f6x1zjalEvA5/kvDTa2CajBosmjBjs4D0f/Lto50qWrqvFRrxVNIbvn8wprqlOqWLWWoRn
X-Gm-Message-State: AOJu0Yxchio4s0yQb0BQYfSyXkSZgxPWc2UrDWVYsJJGpif/rGwNL5WQ
	gIq5lO0I17Gdh9cBlZj2d6rBWId8Q5KYD4rQv0Y05Vm4KmGRnuQ78MHe3EvD5438NWfKDj33D4U
	IXuE9fDvaCbqtnXoRjpoBPe+j3vA=
X-Google-Smtp-Source: AGHT+IEixbNflSAfDemWTfeO2tzJy5oyppYUIZrtnSDDjXS2qZU3KwpIovwEEi3NVJMYFTxUs4wxrPGKGjadb4aHu9Q=
X-Received: by 2002:a05:6808:238b:b0:3be:a516:6ed5 with SMTP id
 bp11-20020a056808238b00b003bea5166ed5mr3578004oib.57.1708814032281; Sat, 24
 Feb 2024 14:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224215023.5271-1-21cnbao@gmail.com> <20240224220819.49277-1-sj@kernel.org>
In-Reply-To: <20240224220819.49277-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 25 Feb 2024 11:33:40 +1300
Message-ID: <CAGsJ_4wAx4fA3oR4=JogZ1HAj6fBFRH2c_KmvwSceuPiUWBYFQ@mail.gmail.com>
Subject: Re: [PATCH] Docs/mm/damon/design: describe the differences for
 pageout's virtual address and physcial address
To: SeongJae Park <sj@kernel.org>
Cc: corbet@lwn.net, linux-mm@kvack.org, akpm@linux-foundation.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 11:08=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Hi Barry,
>
> On Sun, 25 Feb 2024 10:50:23 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > The doc needs update. As only in the case of virtual address, we are
> > calling madvise() with MADV_PAGEOUT; but in the case of physical
> > address, we are actually calling reclaim_pages() directly. And
> > madvise() with MADV_PAGEOUT is much more aggresive on reclamation
> > compared to reclaim_pages() on paddr.
>
> Thank you for this nice patch :)
>
> >
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  Documentation/mm/damon/design.rst | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon=
/design.rst
> > index 8c89d26f0baa..6c50743552f5 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -315,7 +315,13 @@ that supports each action are as below.
> >     Supported by ``vaddr`` and ``fvaddr`` operations set.
> >   - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``.
> >     Supported by ``vaddr`` and ``fvaddr`` operations set.
> > - - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT`=
`.
> > + - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT`=
` if
> > +   the region is using virtual address; otherwise, call ``reclaim_page=
s()``
> > +   for the region if physical address is used.
> > +   ``madvise()``  with ``MADV_PAGEOUT``  is aggressively reclaiming me=
mory
> > +   when pages are not shared by multiple processes. Differently, paddr=
's
> > +   pageout  will do the best-effort reclamation by scanning PTEs to fi=
gure
> > +   out if pages are young, if not, pages are reclaimed.
>
> I think this might be too much details.  Especially, explanation of
> ``MADV_PAGEOUT`` might better to be done on it's document.  We wouldn't w=
ant to
> update two places for future changes to ``MADV_PAGEOUT``.  What do you th=
ink
> about making it simple and independent from the implementation detail?  F=
or
> example,
>
>     - - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOU=
T``.
>     + - ``pageout``: Reclaim the region.

make sense. as someday we might rename reclaim_pages to reclaim_folios or
something else. and we might not use madvise() for vaddr any more, who know=
s:-)
so it is more sensible to remove the details.
I will send v2 to follow your proposal.

>
> Thanks,
> SJ
>
> >     Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
> >   - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAG=
E``.
> >     Supported by ``vaddr`` and ``fvaddr`` operations set.
> > --
> > 2.34.1

Thanks
Barry

