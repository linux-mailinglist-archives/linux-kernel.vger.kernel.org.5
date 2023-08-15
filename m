Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33ED77D609
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbjHOWa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbjHOWae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:30:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5887D1BFF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:30:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99357737980so779639666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692138632; x=1692743432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d1/EJSahT73cr9ZlY19BewTHK2xn5aHPxZEg9xbznE=;
        b=fuO4sjjhidMzbvLnT9dUoAAFNvsL80E86QRBRvCG68qw2PwOECF7uNFobvdM6y5lKU
         qjcVVEaRDyXoNJXCYtMbXDuFoW8yIJgZ/4A4kWYjFT6JFliWW+92D+HIU2wNtgHwNedU
         1xCbPa5QAEwjL7mJS57hZdlqigBCHDZgbU22cr8HT5A9TWDl8vuoeELdG11BCoLOmsW0
         aqkFl6+maxXHPmNVNM5TO5q2RqJEQMl0OBrEyb5q5roH6f51gfGw738qcgaByXAb6DYl
         /roNcORi2zIPZonlrN42mv83ldo3eF5wFAcR9jh7FLnQ4+Zwun8L3iXx6Eug/dsj6TVu
         C0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138632; x=1692743432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7d1/EJSahT73cr9ZlY19BewTHK2xn5aHPxZEg9xbznE=;
        b=daWbzoYVuaFT5oZ7KZMuY4/w4+xcvyjnFXFxZ4OpRup0w+S+qbO4bK9b88ZgKXDstV
         0f02WI5BQdlMuMdwT7t2Ix6B6DVbOliY3m7jxHrafWnvHs0Zo1ieo2iWaI9rUMUa6Iv4
         Luc/BfbRWZJcfS8pMEbSXC+61WUwCyexSL8V3shpN6UqleFII5+1ECHs+fFgg1Jns04P
         hxLdCSoejqSx1GLBcln7j+d+Lh1wYJtiRzBnKCdWaTxi/HM6b+PBOYj372jmNc85icOt
         IP8ah0zKHO+i3CPgZXptj1nYMLi3UWHOUIC96N8FfLyQHrOcB0xlZr1Cw5yUI7gjwgsM
         Xurw==
X-Gm-Message-State: AOJu0YxkaIZJmztc8KYhqjaZn7rVm3PxoiB9MEEl06uNGS8b7Ic6Xu99
        mp902bdxjMk63KOMeEu5rV2FZYfmkKuc/XvZTVJ/YA==
X-Google-Smtp-Source: AGHT+IFefgKJ3rlJrwcdcShWAye+TdzZGubEtXnhS2+tj43kxBszt5uVbjyXVBBxySosNukp2MmnF7gRjb0d1rz7LGI=
X-Received: by 2002:a17:906:9be9:b0:993:dd1d:8251 with SMTP id
 de41-20020a1709069be900b00993dd1d8251mr31205ejc.28.1692138631681; Tue, 15 Aug
 2023 15:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230620194644.3142384-1-yosryahmed@google.com>
 <CAKEwX=OLR02MazB31wR-nphjZJvBHrm5Zy7hLPByZ3ubgO8mjw@mail.gmail.com>
 <CAJD7tkZ7dLwny7-CX7qCywZPtki+fDuESGfv+B9QG87cSsrHVQ@mail.gmail.com>
 <20230811141920.2f9bab6f21ab635ff1bd63ac@linux-foundation.org>
 <CAJD7tkbfKxCOoxNCgtbaAg4LXFbf=afaxei0SbKU2B=HFpPf6Q@mail.gmail.com> <CAF8kJuPhP4q5ObisoyWZ0QdqUrTeNBec3P36PNz=KHLiXW6SrA@mail.gmail.com>
In-Reply-To: <CAF8kJuPhP4q5ObisoyWZ0QdqUrTeNBec3P36PNz=KHLiXW6SrA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 15 Aug 2023 15:29:55 -0700
Message-ID: <CAJD7tkZ21fcwS=m4RuctR4H7dG+NvFQgcc_-Bi6Et73ULgc1kw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: zswap: multiple zpools support
To:     Chris Li <chrisl@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 3:22=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Yosry,
>
> On Fri, Aug 11, 2023 at 4:21=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Fri, Aug 11, 2023 at 2:19=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Thu, 13 Jul 2023 03:35:25 -0700 Yosry Ahmed <yosryahmed@google.com=
> wrote:
> > >
> > > > >
> > > > > I'm experimenting with some other zswap changes - if I have
> > > > > extra cycles and resources I'll try to apply this patch and see h=
ow the
> > > > > numbers play out.
> > > >
> > > > That would be amazing. Looking forward to any numbers you can dig :=
)
> > >
> > > So this patch seems stuck.  I can keep it in mm.git until the fog
> > > clears, but would prefer not to.  Can we please revisit and decide on=
 a
> > > way forward?
> >
> > Johannes did not like a config option so I proposed it here as a
> > constant (like SWAP_CLUSTER_MAX and others we have). This is a value
> > that we have been using in our data centers for almost a decade, so it
>
> I dug up the previous V1 discussion and this V3 discussion thread.
> It seems obvious having multiple pools having locking contention advantag=
e.
> The number does not lie.
>
> However the number of pools is hard to decide at compile time.
>
> Regarding the per CPU pool. That might work well for a small number of CP=
Us.
> When the system has many CPUs e.g. a few hundreds of CPUs. It means havin=
g
> hundreds of pools which is  a bad idea.
>
> How about just setting it as a run time value(size/bits) and can only
> change pool
> (size/bits) when zswap does not have any active stores.

I was hoping we can add the basic support here for multiple zpools,
and then later, if needed, extend to support runtime dynamic tuning.
Adding this will introduce more complexity as we will need to lock all
trees and make sure there is no activity and alloc/free zpools. If a
limitation for compile-time constant is observed we can do that,
otherwise let's keep it simple and incremental for now.

FWIW, we have been running with 32 zpools in Google's fleet for ~a
decade now and it seems to work well for various workloads and machine
configurations.

>
> Chris
>
> > has seen a ton of testing. I was hoping Johannes would get time to
> > take a look, or Nhat would get time to test it out, but neither of
> > these things happen.
> >
> > I obviously want it to be merged, but hopefully someone will chime in h=
ere :)
> >
