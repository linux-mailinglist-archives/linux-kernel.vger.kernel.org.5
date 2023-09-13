Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5B79E2A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjIMIxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjIMIxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:53:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1260A196
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:53:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso113723091fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694595214; x=1695200014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irghFXOamQQNX5fLcZk2WyGaYH9G0dtDSaP941nBse4=;
        b=qvs3kW/3jUyw0Zne2Kep3fdybbSLNV9JutvFDyzCyGpuUv+ko1XjhyuvLTkT7dHWU5
         dL8e4FNmRT3yIqrYIMq90MsXSGZpgmTuBDBx+YIY+vBqAJyoRQlEinNn/2NyVlHwnFuM
         X3DTyI4TAnHknzhZ8WcP3A6rQrdb5/cE7lRTdTH2tTxFHYtdS0yOGmscDO11+8mJkOfi
         3jDGiBioeXi1YIW3dxVbGDN/jC/nwFEk15M1JYUcsvJ1KHGQgtyBN34OCvfpsWTCqkoV
         7EZwYw6wFHLPpxy6QTeG5o6f65O06XNleusPgJwhOX+qdCHj5rBqztE7HzE61I2CpgiR
         VcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694595214; x=1695200014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irghFXOamQQNX5fLcZk2WyGaYH9G0dtDSaP941nBse4=;
        b=fJnbgboHwH+g9giKD+O+TDr4F5tl6H5PXegfVI7prZbXBk893U5OZdBtzEoNY3db9k
         uksxB0+6s19vxt8i+2ASDVoft1bHTIXS5ViwTaYMDueXwvEVqYGM1eblZgEpZbryCr0d
         nTaPQJ7sFd5M1MUohvds1AuLJS5BwMEgltWiTtDvVn86mFgM+M3oPXMOKLqIJ7PUhuOt
         k+tQ8sKGupWGD9LopjMDt43J2LIXF48EKgmoXN9+KlrTl4qGNCJQem8fA7rEmnLCVDRi
         kk8zW7LbZR7x5gSBQco2MO9YrgIWafpAr29UG0ihzWvFPkrLGc53IntiNtACmpTFywyb
         JNIQ==
X-Gm-Message-State: AOJu0YzYEbX8fe7/pV5HuUuIgn0V3wU2WWJ3hnJ99PS6IlTUtCQLJTJP
        Ox1r/xHtSbRER3dNgRTNCeJJoLHEvIIGx6XKAPLmSVuHJeg=
X-Google-Smtp-Source: AGHT+IGEza02q48TZ+A5LodeGs2jBxD5vU/PGp/0pfGmoly0eyFqGF1Z2ksRNmX1d1xISZ/D1LqVEz8cVJ/HFZvS7+0=
X-Received: by 2002:a2e:a282:0:b0:2bd:16e6:e34e with SMTP id
 k2-20020a2ea282000000b002bd16e6e34emr1549825lja.1.1694595213868; Wed, 13 Sep
 2023 01:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230912103334.2074140-1-zhaoyang.huang@unisoc.com>
 <ZQBW23Upv/CdN9v6@casper.infradead.org> <CAGWkznEt+mAGtEN+mQm3ZdxTpScmBBOa0TT=oLtuTF6Z-ipqZw@mail.gmail.com>
 <ZQFv8+tI/hEaOzcD@shell.armlinux.org.uk>
In-Reply-To: <ZQFv8+tI/hEaOzcD@shell.armlinux.org.uk>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 13 Sep 2023 16:53:22 +0800
Message-ID: <CAGWkznHjSpYus5y=yYhQkdF9aaMtFvyfXLjc=fhrNs3CGHVwHg@mail.gmail.com>
Subject: Re: [PATCH] arch: arm: remove redundant clear_page when
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 4:17=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Sep 13, 2023 at 09:13:14AM +0800, Zhaoyang Huang wrote:
> > On Tue, Sep 12, 2023 at 8:18=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Tue, Sep 12, 2023 at 06:33:34PM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Double times of clear_page observed in an arm SOC(A55) when
> > > > CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on, which introduced by
> > > > vma_alloc_zeroed_movable_folio within do_anonymous_pages.
> > > > Since there is no D-cache operation within v6's clear_user_highpage=
,
> > > > I would like to suggest to remove the redundant clear_page.
>
> So if CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not enabled, then what ensures
> that the page is cleared?

>
> > > >
> > > > struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct =
*vma,
> > > >                                  unsigned long vaddr)
> > > > {
> > > >       struct folio *folio;
> > > >
> > > > //first clear_page invoked by vma_alloc_folio=3D=3D>alloc_page=3D=
=3D>post_alloc_hook
> > > >       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr=
, false);
> > > >       if (folio)
> > > > //second clear_page which is meaningless since it do nothing to D-c=
ache in armv6
> > > >               clear_user_highpage(&folio->page, vaddr);
>
> If this clear_user_highpage() is removed, how is this code then safe when
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not enabled?
when CONFIG_INIT_ON_ALLOC_DEFAULT_ON is off, want_init_on_alloc() will
return false and then clear_user_highpage will be called
>
> > >
> > > This is, of course, not the only place which calls clear_user_highpag=
e().
> > > Please explain why this patch is safe for all the _other_ places whic=
h
> > > call clear_user_highpage().
> > Here are all positions called clear_user_highpage which are paired
> > with alloc_pages. IMO,  it is safe to skip the second clear_page under
> > armv6.
>
> No.
>
> Looking at, for example, the v4l case... This allocates a page and
> provides it to userspace. The page is allocated using GFP_USER |
> __GFP_DMA32. This does not set __GFP_ZERO. If
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not enabled, the page will not
> be initialised, and thus we will leak any data in that page to
> userspace.
as explained above, clear_user_highpage will be called in this scenario
>
> Now, it's not just about whether that configuration symbol is enabled
> in the kernel configuration - there is a command line argument to
> consider as well. CONFIG_INIT_ON_ALLOC_DEFAULT_ON can be y, but with
> init_on_alloc=3D0 passed to the kernel, if we remove the above
> clear_user_highpage(), the kernel then becomes unsafe.
Both of CONFIG_INIT_ON_ALLOC_DEFAULT_ON and cmdline configuration take
effect via the global variable init_on_alloc which is judged within
want_init_on_alloc()
>
> However, it's more than that. The kernel allocator has no idea that the
> page will be mapped to userspace, so it can't do the "clear the page at
> the user cache colour" trick for VIPT aliasing caches, which ensures
> that we hit cache lines that the user will see. So, I think we would
> then have to add arch specific cache operations to write-back the
> zeroing of the kernel mapping, _and_ cache operations to discard any
> data in the user cache colour.
ok, do you mean you will update v6's clear_user_highpage from memset
to D-cache flush things?
>
> So, essentially, I don't think that _even_ when init_on_alloc is
> enabled, we can skip calling clear_user_highpage() as that would lead
> to data exposure to userspace.
This patch only suggests making changes on the specific v6
architecture where clear_user_highpage equal to clear_page so far.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
