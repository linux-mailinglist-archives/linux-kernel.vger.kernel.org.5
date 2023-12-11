Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E950680DDE3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345542AbjLKWHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345457AbjLKWHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:07:21 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A8A1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:07:26 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-425928c24easo132281cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702332446; x=1702937246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEQXjkg8ZdEhUtl2x53QcNzk2aEcDFh+4Uvu9gMAPOM=;
        b=Cp8OsCI6uofufSDJylAsPNGwzHWZT98+8bs+7un9QyYaelcZryUNaieWRVJ9GnH4RZ
         Wxd3w0CpyEX8XrsrplAtzWEmybh2/BwuxYwhe0i5eXkllOgWi0N8xZHQHtqIdug61kjN
         A2cB6dO5bSd1tVWWtfnALn2Ia8SfGazPf5vn7ZG+vhmrOsv3C6d2wE2zelcp58AMMBtq
         rbVVZm/h7NY9Q5X/dNNMXO1seRfL+kxkwySFYLGcbASZCPwgwnNdJWuuLqumASwWGDyX
         T+AeMSc2bZYcy4+nr0UwvxFb+JSfGGDP6V8Ovpsbzt7JGPC4AkERnpH3gwLfujjnLHin
         fhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332446; x=1702937246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEQXjkg8ZdEhUtl2x53QcNzk2aEcDFh+4Uvu9gMAPOM=;
        b=ou3cms1R4RY6Fd5kpdeNDlzc1NerdWzXhbzYzWbr0dr5XNJ9w+4O8olkFjqAExcrBK
         kezMrKKDKSbQfSuOEsaRYuDnSuYFejBGVbKF4lZqS8P3qixljSKK+eeXIDw4olCpikR4
         79+PolElKoFgxTUh1RxcmYqrlyL3Uvs/d8hPl0lxqh1l+ybuRiRbolj6MseSwdsM4hdO
         UAKHM34cdzbNPBK8lva0Yrxg+RRn1FjekFqFWFlURHRSp1Et3qfqc+vwKoHA/9un4V1X
         ufvNf6zWOy712yCN1XtnN40b6qt5uGybj20M+xsNhDC3BR1lJuPRR4HeyNfc3o1NklMb
         lsGQ==
X-Gm-Message-State: AOJu0Yz6JteU7ffC4m48I7d7fPvFg+/A+nTpCH4GYAKkTiaaqwj7mFUr
        cBIdnzhoYKWuHa92VUgOSvRgcCEH3Kloj8hp2cZN9pPr7b7Z/wue5p4=
X-Google-Smtp-Source: AGHT+IH+/dyc/hZNX51k+t0PKYhPnetIx3LhhZb7gJ9YizNg8qLu/nCEqnbEKRgxA7byr+po3RGzCwYOrfHmvYMDq5M=
X-Received: by 2002:ac8:5992:0:b0:421:c331:7df4 with SMTP id
 e18-20020ac85992000000b00421c3317df4mr827815qte.18.1702332445538; Mon, 11 Dec
 2023 14:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com> <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
In-Reply-To: <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 11 Dec 2023 15:06:48 -0700
Message-ID: <CAOUHufYwZAUaJh6i8Fazc4gVMSqcsz9JbRNpj0cpx2qR+bZBFw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To:     Kairui Song <ryncsn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 1:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=888=E6=97=A5=
=E5=91=A8=E4=BA=94 14:14=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Unmapped folios accessed through file descriptors can be
> > underprotected. Those folios are added to the oldest generation based
> > on:
> > 1. The fact that they are less costly to reclaim (no need to walk the
> >    rmap and flush the TLB) and have less impact on performance (don't
> >    cause major PFs and can be non-blocking if needed again).
> > 2. The observation that they are likely to be single-use. E.g., for
> >    client use cases like Android, its apps parse configuration files
> >    and store the data in heap (anon); for server use cases like MySQL,
> >    it reads from InnoDB files and holds the cached data for tables in
> >    buffer pools (anon).
> >
> > However, the oldest generation can be very short lived, and if so, it
> > doesn't provide the PID controller with enough time to respond to a
> > surge of refaults. (Note that the PID controller uses weighted
> > refaults and those from evicted generations only take a half of the
> > whole weight.) In other words, for a short lived generation, the
> > moving average smooths out the spike quickly.
> >
> > To fix the problem:
> > 1. For folios that are already on LRU, if they can be beyond the
> >    tracking range of tiers, i.e., five accesses through file
> >    descriptors, move them to the second oldest generation to give them
> >    more time to age. (Note that tiers are used by the PID controller
> >    to statistically determine whether folios accessed multiple times
> >    through file descriptors are worth protecting.)
> > 2. When adding unmapped folios to LRU, adjust the placement of them so
> >    that they are not too close to the tail. The effect of this is
> >    similar to the above.
> >
> > On Android, launching 55 apps sequentially:
> >                            Before     After      Change
> >   workingset_refault_anon  25641024   25598972   0%
> >   workingset_refault_file  115016834  106178438  -8%
>
> Hi Yu,
>
> Thanks you for your amazing works on MGLRU.
>
> I believe this is the similar issue I was trying to resolve previously:
> https://lwn.net/Articles/945266/
> The idea is to use refault distance to decide if the page should be
> place in oldest generation or some other gen, which per my test,
> worked very well, and we have been using refault distance for MGLRU in
> multiple workloads.
>
> There are a few issues left in my previous RFC series, like anon pages
> in MGLRU shouldn't be considered, I wanted to collect feedback or test
> cases, but unfortunately it seems didn't get too much attention
> upstream.
>
> I think both this patch and my previous series are for solving the
> file pages underpertected issue, and I did a quick test using this
> series, for mongodb test, refault distance seems still a better
> solution (I'm not saying these two optimization are mutually exclusive
> though, just they do have some conflicts in implementation and solving
> similar problem):
>
> Previous result:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Execution Results after 905 seconds
> ------------------------------------------------------------------
>                   Executed        Time (=C2=B5s)       Rate
>   STOCK_LEVEL     2542            27121571486.2   0.09 txn/s
> ------------------------------------------------------------------
>   TOTAL           2542            27121571486.2   0.09 txn/s
>
> This patch:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Execution Results after 900 seconds
> ------------------------------------------------------------------
>                   Executed        Time (=C2=B5s)       Rate
>   STOCK_LEVEL     1594            27061522574.4   0.06 txn/s
> ------------------------------------------------------------------
>   TOTAL           1594            27061522574.4   0.06 txn/s
>
> Unpatched version is always around ~500.

Thanks for the test results!

> I think there are a few points here:
> - Refault distance make use of page shadow so it can better
> distinguish evicted pages of different access pattern (re-access
> distance).
> - Throttled refault distance can help hold part of workingset when
> memory is too small to hold the whole workingset.
>
> So maybe part of this patch and the bits of previous series can be
> combined to work better on this issue, how do you think?

I'll try to find some time this week to look at your RFC. It'd be a
lot easier for me if you could share
1. your latest tree, preferably based on the mainline, and
2. your VM image containing the above test.
