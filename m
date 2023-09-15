Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6857A15AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjIOFrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjIOFrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:47:20 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB02719
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:47:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bfc5218dd8so27298281fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694756833; x=1695361633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5dc0RapsJHRQN53o8cJrIr79i5yRR+ziDw1tWj/hHA=;
        b=QfIxft7IqHZLgWnz3JpSP9uxqXMnmkfORydpkR7+HIFHhc3MHEvLkfxZBSs3gDNdfU
         FT0NxiO3c4uzVjuIUwGcT2z35h6xPN2a9m8Qs88aaYY5skMysZD4cM+A/xgbUalTvuyT
         +YuZJS5kj4/FBP6z29+Ii79e+Ru4hCKnqPS0y/SDB0HynovWt2qL4pPc7LvoMzYST30c
         s8ba7oujFhgLE9VjonsNzlWn7EIFux/IELkOyMaGmid+SFb1vyZGGB6w+s11A2z514N6
         gzYfC9t9V3k2LMcHAbjdE/KpafCng9tRIFD9P31ZGALEy7Fqj/vEJlZhXG1gEaU2rmrG
         jxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694756833; x=1695361633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5dc0RapsJHRQN53o8cJrIr79i5yRR+ziDw1tWj/hHA=;
        b=cpFEJ3MdWjUn0q7H7VBtvoBjtjo68RPKpoic3zPrnbjPie0nSmpSCrCoHl9Ix7e/7a
         W0BBpL4C2dye2YTok+Vntg8vEKr4JkuRQpdiqQ4X5ivT6t5gp8b/03fna0RWqkziZFvy
         ssw2foQJCOaFLYiArraau698nb8jNlP6l2Ev5y3siMliKaL6My+lBiIAwAnizBYlX+sp
         5+ojXFpzSxc36daVo0YBGuOwHskfVX++MCUbaC0WTUaRhV4I/cjeavtXMWQjSxqGR7jF
         4xv+cw/IbGuxf3ndGIxTlsElpxbrUKix99ejHxwDUfSZ2wyuOan8yxsNMFPkqncE8M+f
         GXFQ==
X-Gm-Message-State: AOJu0YwBSm2avD51OEIC30oykh5MdbtXr/BK6cxfJi6M4G9yu8g8gQmD
        lAFwpCLaWnHnoQHEQcBjRm+baHv0+KKaM9kMcHM=
X-Google-Smtp-Source: AGHT+IHvdaJpFwbo/Bxy9YcFi/E9XHr2+yJoPfdexlwLicIjMp5w2xNyBGPYT2kgxQDJpBlowPT54BifZOgYPFqahto=
X-Received: by 2002:a2e:494a:0:b0:2bc:d634:2210 with SMTP id
 b10-20020a2e494a000000b002bcd6342210mr623143ljd.16.1694756832856; Thu, 14 Sep
 2023 22:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230912103334.2074140-1-zhaoyang.huang@unisoc.com>
 <ZQBW23Upv/CdN9v6@casper.infradead.org> <CAGWkznEt+mAGtEN+mQm3ZdxTpScmBBOa0TT=oLtuTF6Z-ipqZw@mail.gmail.com>
 <ZQFv8+tI/hEaOzcD@shell.armlinux.org.uk> <CAGWkznHjSpYus5y=yYhQkdF9aaMtFvyfXLjc=fhrNs3CGHVwHg@mail.gmail.com>
In-Reply-To: <CAGWkznHjSpYus5y=yYhQkdF9aaMtFvyfXLjc=fhrNs3CGHVwHg@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 15 Sep 2023 13:47:01 +0800
Message-ID: <CAGWkznHW0c3ZWyMrzwui5oqaz7e-v6JgvEegyTd6MQTM=_J2XQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

any further comments, it is arised from a real performance issue
observed double times of memset in ARM A55 which should be waste. What
this patch suggest is to remove the latter one while ensure the page
will be cleared under all scenarios

On Wed, Sep 13, 2023 at 4:53=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
.com> wrote:
>
> On Wed, Sep 13, 2023 at 4:17=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Sep 13, 2023 at 09:13:14AM +0800, Zhaoyang Huang wrote:
> > > On Tue, Sep 12, 2023 at 8:18=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Tue, Sep 12, 2023 at 06:33:34PM +0800, zhaoyang.huang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > Double times of clear_page observed in an arm SOC(A55) when
> > > > > CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on, which introduced by
> > > > > vma_alloc_zeroed_movable_folio within do_anonymous_pages.
> > > > > Since there is no D-cache operation within v6's clear_user_highpa=
ge,
> > > > > I would like to suggest to remove the redundant clear_page.
> >
> > So if CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not enabled, then what ensures
> > that the page is cleared?
>
> >
> > > > >
> > > > > struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struc=
t *vma,
> > > > >                                  unsigned long vaddr)
> > > > > {
> > > > >       struct folio *folio;
> > > > >
> > > > > //first clear_page invoked by vma_alloc_folio=3D=3D>alloc_page=3D=
=3D>post_alloc_hook
> > > > >       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vad=
dr, false);
> > > > >       if (folio)
> > > > > //second clear_page which is meaningless since it do nothing to D=
-cache in armv6
> > > > >               clear_user_highpage(&folio->page, vaddr);
> >
> > If this clear_user_highpage() is removed, how is this code then safe wh=
en
> > CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not enabled?
> when CONFIG_INIT_ON_ALLOC_DEFAULT_ON is off, want_init_on_alloc() will
> return false and then clear_user_highpage will be called
> >
> > > >
> > > > This is, of course, not the only place which calls clear_user_highp=
age().
> > > > Please explain why this patch is safe for all the _other_ places wh=
ich
> > > > call clear_user_highpage().
> > > Here are all positions called clear_user_highpage which are paired
> > > with alloc_pages. IMO,  it is safe to skip the second clear_page unde=
r
> > > armv6.
> >
> > No.
> >
> > Looking at, for example, the v4l case... This allocates a page and
> > provides it to userspace. The page is allocated using GFP_USER |
> > __GFP_DMA32. This does not set __GFP_ZERO. If
> > CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not enabled, the page will not
> > be initialised, and thus we will leak any data in that page to
> > userspace.
> as explained above, clear_user_highpage will be called in this scenario
> >
> > Now, it's not just about whether that configuration symbol is enabled
> > in the kernel configuration - there is a command line argument to
> > consider as well. CONFIG_INIT_ON_ALLOC_DEFAULT_ON can be y, but with
> > init_on_alloc=3D0 passed to the kernel, if we remove the above
> > clear_user_highpage(), the kernel then becomes unsafe.
> Both of CONFIG_INIT_ON_ALLOC_DEFAULT_ON and cmdline configuration take
> effect via the global variable init_on_alloc which is judged within
> want_init_on_alloc()
> >
> > However, it's more than that. The kernel allocator has no idea that the
> > page will be mapped to userspace, so it can't do the "clear the page at
> > the user cache colour" trick for VIPT aliasing caches, which ensures
> > that we hit cache lines that the user will see. So, I think we would
> > then have to add arch specific cache operations to write-back the
> > zeroing of the kernel mapping, _and_ cache operations to discard any
> > data in the user cache colour.
> ok, do you mean you will update v6's clear_user_highpage from memset
> to D-cache flush things?
> >
> > So, essentially, I don't think that _even_ when init_on_alloc is
> > enabled, we can skip calling clear_user_highpage() as that would lead
> > to data exposure to userspace.
> This patch only suggests making changes on the specific v6
> architecture where clear_user_highpage equal to clear_page so far.
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
