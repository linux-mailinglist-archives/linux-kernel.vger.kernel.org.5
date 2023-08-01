Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8394F76AA26
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjHAHku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHAHks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:40:48 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E251E1726
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:40:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4036bd4fff1so222011cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690875646; x=1691480446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1ckwMzi+FIp2LWpGFkmYasLA7o5jmHuzGuDzFbHRJI=;
        b=Z4l96ijOCUV1jCIh7akPgFxUN7n4TGV+4ixXqZrqoMrJu+qGIaelFu/BYkra1Pi/P8
         893iEXuQuzDXJUimzaHponHU2RQjDGCaneTVA77mXZ6CnhiN3d9U/g6cvrUoqbDaOKC3
         H//HxyTPW566NzLCjsgOKoEn7W5zJrdMl8iE8OedNPmvqZVmyDr7OUFMIwgLiU5+N/m2
         y9KYD270Hvq4q2WffLKgxrBLT9bUF2I0dW1faCBavJb2WtWAivOTV6uQo/FU5TJ2wW/U
         XwWIq3DC+2vaPy0GYXzz20KmvIFM8+ElbJGCMNc9yiD1LKZ2t+AQDqk/FIKJo8lOYCC2
         mPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690875646; x=1691480446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1ckwMzi+FIp2LWpGFkmYasLA7o5jmHuzGuDzFbHRJI=;
        b=Bdv1o4K8i/0jRTf7Tru28BvyOgrxoEF4fpMF9Y2H75zj4X6kSWKGdOe0gppTrNBBwQ
         xBm/xpmfW4CeW9pBHREzN7J0U7KA3AlV+gXmbFbzfLAekEYNImpdiImR+us3i8DsFB2S
         bXT09wV6FOmdB/mmFkhgVs9dNd2ADo4HLCEbPKRdAEjxusF2EeMCI9ELqz8QT1rzumXa
         naxCA1qsHGPzlAUu2DZk4JukQPsk218VIiOMz9FLjJOcwc2A8zpQHPAijvpLdVJ6cKPl
         BbCrttmpgbqaC+POE1DUe0Filyx/vE3525+sPX7WlhAtAEBoCnCGtYfvbmqlWx3LnZB2
         1Kmg==
X-Gm-Message-State: ABy/qLbGF2V3t/cIT5RR1a1DNkN4cInK/1eX9IyT7kcaNDX8Ydd+ZqCt
        RPMk/rpOkAITaGSs6MV1Lf0AB5gesYMmTbsoNxm/Yg==
X-Google-Smtp-Source: APBJJlE/z1yYLYt6LNaoji+ukmicGnkFXZ2bSaBTlYLoWNAFANjvUdHA7+uDUY1fMUI4yexT4v3uMHavY/A8llix6BA=
X-Received: by 2002:a05:622a:1827:b0:403:eeb9:a76 with SMTP id
 t39-20020a05622a182700b00403eeb90a76mr628181qtc.17.1690875645932; Tue, 01 Aug
 2023 00:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230720112955.643283-1-ryan.roberts@arm.com> <20230720112955.643283-3-ryan.roberts@arm.com>
 <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
 <ZMFNgmlT1JpI0z5+@casper.infradead.org> <87r0ouw39n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZMHX+O0wmjuPXdTi@casper.infradead.org> <faf8d723-afb8-ac4e-7861-4004bb78c5a9@arm.com>
 <CAOUHufa38H0o0ZoX-KYMSeAiJghMWtjfHM2F4OjUZ-a--_Kt_w@mail.gmail.com> <3c26aa4e-fe11-09d2-c2fb-63546ba80893@arm.com>
In-Reply-To: <3c26aa4e-fe11-09d2-c2fb-63546ba80893@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 1 Aug 2023 01:40:09 -0600
Message-ID: <CAOUHufZKVd72hdzUB+++E9+LL6N2WESuHU2AenUDoG=Nv91N5A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: Implement folio_remove_rmap_range()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 3:00=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/07/2023 17:38, Yu Zhao wrote:
> > On Thu, Jul 27, 2023 at 1:26=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 27/07/2023 03:35, Matthew Wilcox wrote:
> >>> On Thu, Jul 27, 2023 at 09:29:24AM +0800, Huang, Ying wrote:
> >>>> Matthew Wilcox <willy@infradead.org> writes:
> >>>>> I think that can make sense.  Because we limit to a single page tab=
le,
> >>>>> specifying 'nr =3D 1 << PMD_ORDER' is the same as 'compound =3D tru=
e'.
> >>>>> Just make it folio, page, nr, vma.  I'd actually prefer it as (vma,
> >>>>> folio, page, nr), but that isn't the convention we've had in rmap u=
p
> >>>>> until now.
> >>>>
> >>>> IIUC, even if 'nr =3D 1 << PMD_ORDER', we may remove one PMD 'compou=
nd'
> >>>> mapping, or 'nr' PTE mapping.  So, we will still need 'compound' (or
> >>>> some better name) as parameter.
> >>>
> >>> Oh, this is removing ... so you're concerned with the case where we'v=
e
> >>> split the PMD into PTEs, but all the PTEs are still present in a sing=
le
> >>> page table?  OK, I don't have a good answer to that.  Maybe that torp=
edoes
> >>> the whole idea; I'll think about it.
> >>
> >> This is exactly why I think the approach I've already taken is the cor=
rect one;
> >> a 'range' makes no sense when you are dealing with 'compound' pages be=
cause you
> >> are accounting the entire folio. So surely its better to reflect that =
by only
> >> accounting small pages in the range version of the API.
> >
> > If the argument is the compound case is a separate one, then why not a
> > separate API for it?
> >
> > I don't really care about whether we think 'range' makes sense for
> > 'compound' or not. What I'm saying is:
> > 1. if they are considered one general case, then one API with the
> > compound parameter.
> > 2. if they are considered two specific cases, there should be two APIs.
> > This common design pattern is cleaner IMO.
>
> Option 2 definitely makes sense to me and I agree that it would be cleane=
r to
> have 2 separate APIs, one for small-page accounting (which can accept a r=
ange
> within a folio) and one for large-page accounting (i.e. compound=3Dtrue i=
n today's
> API).
>
> But...
>
> 1) That's not how the rest of the rmap API does it

Yes, but that's how we convert things: one step a time.

> 2) This would be a much bigger change since I'm removing an existing API =
and
> replacing it with a completely new one (there are ~20 call sites to fix u=
p). I
> was trying to keep the change small and manageable by maintaining the cur=
rent
> API but moving all the small-page logic to the new API, so the old API is=
 a
> wrapper in that case.

I don't get how it'd be "much bigger". Isn't it just a straightforward
replacement?

> 3) You would also need an API for the hugetlb case, which page_remove_rma=
p()
> handles today. Perhaps that could also be done by the new API that handle=
s the
> compound case. But then you are mixing and matching your API styles - one=
 caters
> for 1 specific case, and the other caters for 2 cases and figures out whi=
ch one.

You are talking about cases *inside* the APIs, and that's irrelevant
to the number of APIs: we only need two -- one supports a range within
a folio and the other takes a folio as a single unit.

> > Right now we have an overlap (redundancy) -- people would have to do
> > two code searches: one for page_remove_rmap() and the other for
> > folio_remove_rmap_range(nr=3D1), and this IMO is a bad design pattern.
>
> I'm open to doing the work to remove this redundancy, but I'd like to hea=
r
> concensus on this thread that its the right approach first. Although pers=
onally
> I don't see a problem with what I've already done; If you want to operate=
 on a
> page (inc the old concept of a "compound page" and a hugetlb page) call t=
he old
> one. If you want to operate on a range of pages in a folio, call the new =
one.
