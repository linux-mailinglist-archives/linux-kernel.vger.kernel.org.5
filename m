Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B2379DD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjIMBNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIMBNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:13:32 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DE10E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:13:27 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so107045351fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694567606; x=1695172406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjsc0hUdTRQvDzUtDcM0eOVV6oXOZ8WCpdv+IWRoLPY=;
        b=lTdHV+x164VJvffBVmpIp6aPHSzob+GTSDmdIF7r+arBmE/U7eElpT70FVCZDTwNiG
         axoYOcC44VWMyIsS+rF9O4caFYe/lJUsbo7z1qQovLEpm9+F3gkNZhIHtuKvj2V4uLn+
         KYsdYkW8LKBqPGkUxHk0All3xL6peC04Q5yPKodvFMOWvN3NyADiXouH8q/kqgNUuNT8
         m5w2+5VWWO/dxxAEcihUL7j/RNjwS00wfRUMUs9U9xP6pF9r1KF+3eLU3LddEAH8XQue
         n4CLQkhet7unMKRl2bAgH3Q+GNfxR5CdAgBhbk1M8BokmCsrohHPQK1vV8ouZmHijfXL
         H2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694567606; x=1695172406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjsc0hUdTRQvDzUtDcM0eOVV6oXOZ8WCpdv+IWRoLPY=;
        b=lp9wR+23wb7Di3CppNOlYb1d5ICFNBH5IFcoQ9qe5aoU6yqelgiOAwwWccCuUaORNG
         ZIzC6/reZQhqURcFwIGE0/86e/RrVLEdXTEIACJPXHlaC/6ksfgyjTEXQ7pvICAgqaEo
         oK5f+dSQHJX4iDy9IhIyYD3iT/si7MeDvFl02bl0pS4nW3W+MZqVWPtfOptddc8LZWfk
         TzuKYjKdZftkxvupQdqAycXAOMhx7i9xn+BpmGVj+f0egEYaYrr2RINquR7YFbGEPqL5
         fjN/mpg4PUGS9pJlRu3LlKwvgYQ1V7gVrv0SELvJJBPxoAtWTD7kNLIiTAXjsqt2H1Zt
         J96w==
X-Gm-Message-State: AOJu0Yz6XDPE37rGMOX1uxEIwXZwmRx/TrYGpwuiuOKUd80ycshxeqNz
        /OdHdVFKyDC1rHfh6P6SyFUOm3wlsCUWlYiJfR0=
X-Google-Smtp-Source: AGHT+IFdSC8jWmSSvotWYWDGkhIhZ5CzInhYHDzGHWbKW3OweLNGZvJfOCLK2Yf+3MpotTkkbuQ+zFWHdi6GGBmfpD4=
X-Received: by 2002:a2e:8386:0:b0:2bc:e3a5:57aa with SMTP id
 x6-20020a2e8386000000b002bce3a557aamr1020414ljg.0.1694567605937; Tue, 12 Sep
 2023 18:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230912103334.2074140-1-zhaoyang.huang@unisoc.com> <ZQBW23Upv/CdN9v6@casper.infradead.org>
In-Reply-To: <ZQBW23Upv/CdN9v6@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 13 Sep 2023 09:13:14 +0800
Message-ID: <CAGWkznEt+mAGtEN+mQm3ZdxTpScmBBOa0TT=oLtuTF6Z-ipqZw@mail.gmail.com>
Subject: Re: [PATCH] arch: arm: remove redundant clear_page when
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 8:18=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Sep 12, 2023 at 06:33:34PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Double times of clear_page observed in an arm SOC(A55) when
> > CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on, which introduced by
> > vma_alloc_zeroed_movable_folio within do_anonymous_pages.
> > Since there is no D-cache operation within v6's clear_user_highpage,
> > I would like to suggest to remove the redundant clear_page.
> >
> > struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma=
,
> >                                  unsigned long vaddr)
> > {
> >       struct folio *folio;
> >
> > //first clear_page invoked by vma_alloc_folio=3D=3D>alloc_page=3D=3D>po=
st_alloc_hook
> >       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, fa=
lse);
> >       if (folio)
> > //second clear_page which is meaningless since it do nothing to D-cache=
 in armv6
> >               clear_user_highpage(&folio->page, vaddr);
>
> This is, of course, not the only place which calls clear_user_highpage().
> Please explain why this patch is safe for all the _other_ places which
> call clear_user_highpage().
Here are all positions called clear_user_highpage which are paired
with alloc_pages. IMO,  it is safe to skip the second clear_page under
armv6.

drivers/media/v4l2-core/videobuf-dma-sg.c:441:
clear_user_highpage(page, vmf->address);
fs/dax.c:1612: clear_user_highpage(vmf->cow_page, vmf->address);
include/linux/highmem.h:231: clear_user_highpage(&folio->page, vaddr);
mm/memory.c:5974: clear_user_highpage(p, addr + i * PAGE_SIZE);
mm/memory.c:5982: clear_user_highpage(page + idx, addr);
mm/shmem.c:2621: clear_user_highpage(&folio->page, dst_addr);
mm/khugepaged.c:796: clear_user_highpage(page, _address);

>
> >       return folio;
> > }
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  arch/arm/mm/copypage-v6.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> > index a1a71f36d850..6f8bee1b3203 100644
> > --- a/arch/arm/mm/copypage-v6.c
> > +++ b/arch/arm/mm/copypage-v6.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/highmem.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/gfp.h>
> >
> >  #include <asm/shmparam.h>
> >  #include <asm/tlbflush.h>
> > @@ -45,6 +46,13 @@ static void v6_copy_user_highpage_nonaliasing(struct=
 page *to,
> >   */
> >  static void v6_clear_user_highpage_nonaliasing(struct page *page, unsi=
gned long vaddr)
> >  {
> > +     /*
> > +      * This criteria only help bailing out when CONFIG_INIT_ON_ALLOC_=
DEFAULT_ON
> > +      * is on. The page has been memset to zero when it allocated and =
the
> > +      * bellowing clear_page will do it again.
> > +      */
> > +     if (want_init_on_alloc(GFP_HIGHUSER_MOVABLE))
> > +             return;
> >       void *kaddr =3D kmap_atomic(page);
> >       clear_page(kaddr);
> >       kunmap_atomic(kaddr);
> > --
> > 2.25.1
> >
