Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376437658E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjG0QjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjG0QjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:39:20 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276B62D54
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:39:19 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40540a8a3bbso304571cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690475958; x=1691080758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yDMqgwJZJpeLWzTC3EjN9bRwWDIhFu5M1m3QL8b53s=;
        b=AdhfcTm82K1GjFLigVcxGTETbwB4Hu0ZKLK+rVeYJhk06k5aXEomtq0SuD4my1yUGg
         G6a/EeSTlThiC82+Z4bb/j+2s0ml/xUhySNsXFOA6VBQOFGZDamFXY9HPFc97j6VTYG5
         1e3d2EFDPlJjT/zTfCt+EjkDltdCVWOfiGhis7IWPppJdrn0DD5QVUmWhlKEzl+bjSib
         UYXeS7mDMrpUEzNQ3lX5EVaJgq/MZDpL+9hmU+DGwhEBLNQsOasCoVnXS4xZoegM3c2P
         U6gEU7zhObGvROVJgWVeMRLMV+9gxdLqC4/35IJiVicb67MCUB2Azg0hfZNEGGq3G8kR
         5mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475958; x=1691080758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yDMqgwJZJpeLWzTC3EjN9bRwWDIhFu5M1m3QL8b53s=;
        b=RWEDy+jndlyOfPwaZxzrHtFvbaayR1qir84+OE3/6FMwI5nxGX1dlF9RmLpe7lRwph
         mrLIdDgGLAVormh/OfpZI0CJ9gjLZ9Vafx3ZjREnZ9B5jVk/mF6gKdmPbidTDyGe6gol
         1bKLoCliZRV9ED8Tyj1SaXAOpAxNjK8edOOmNTGyawLYiGpw7tbuDYrEMwkDS/dwRANb
         vHF0fm8CZij3oerC/qXPXhFRDbjh7QFwMiqKYaG136V3MW1s7Ue2msGFyDvbgIGWYy8q
         M4abP+4mTHc6jh3JruNhPEEhB9bEX44d4BC3QWZyMqbzq//5vWJHILW4G/LwsKSCm6rX
         jokA==
X-Gm-Message-State: ABy/qLb17hVMX8oupxEtCTjfuPkidushaUyGzSztBenyI8nDuUfeXsnp
        Oc3S18xxize2Yz+HigvedXJ6H4iu2CtKFdHPtgBvTQ==
X-Google-Smtp-Source: APBJJlFa6Zgjvg4Fw2GO4V4tr/e2Mu+mSsSifid6jwnpXQAx3UQnVcDy9mGobHKu9b2sKlUs8EavhIu7j8HTjvXvfKs=
X-Received: by 2002:ac8:7d85:0:b0:3f9:a78f:c527 with SMTP id
 c5-20020ac87d85000000b003f9a78fc527mr207755qtd.21.1690475958109; Thu, 27 Jul
 2023 09:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230720112955.643283-1-ryan.roberts@arm.com> <20230720112955.643283-3-ryan.roberts@arm.com>
 <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
 <ZMFNgmlT1JpI0z5+@casper.infradead.org> <87r0ouw39n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZMHX+O0wmjuPXdTi@casper.infradead.org> <faf8d723-afb8-ac4e-7861-4004bb78c5a9@arm.com>
In-Reply-To: <faf8d723-afb8-ac4e-7861-4004bb78c5a9@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 27 Jul 2023 10:38:42 -0600
Message-ID: <CAOUHufa38H0o0ZoX-KYMSeAiJghMWtjfHM2F4OjUZ-a--_Kt_w@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 1:26=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/07/2023 03:35, Matthew Wilcox wrote:
> > On Thu, Jul 27, 2023 at 09:29:24AM +0800, Huang, Ying wrote:
> >> Matthew Wilcox <willy@infradead.org> writes:
> >>> I think that can make sense.  Because we limit to a single page table=
,
> >>> specifying 'nr =3D 1 << PMD_ORDER' is the same as 'compound =3D true'=
.
> >>> Just make it folio, page, nr, vma.  I'd actually prefer it as (vma,
> >>> folio, page, nr), but that isn't the convention we've had in rmap up
> >>> until now.
> >>
> >> IIUC, even if 'nr =3D 1 << PMD_ORDER', we may remove one PMD 'compound=
'
> >> mapping, or 'nr' PTE mapping.  So, we will still need 'compound' (or
> >> some better name) as parameter.
> >
> > Oh, this is removing ... so you're concerned with the case where we've
> > split the PMD into PTEs, but all the PTEs are still present in a single
> > page table?  OK, I don't have a good answer to that.  Maybe that torped=
oes
> > the whole idea; I'll think about it.
>
> This is exactly why I think the approach I've already taken is the correc=
t one;
> a 'range' makes no sense when you are dealing with 'compound' pages becau=
se you
> are accounting the entire folio. So surely its better to reflect that by =
only
> accounting small pages in the range version of the API.

If the argument is the compound case is a separate one, then why not a
separate API for it?

I don't really care about whether we think 'range' makes sense for
'compound' or not. What I'm saying is:
1. if they are considered one general case, then one API with the
compound parameter.
2. if they are considered two specific cases, there should be two APIs.
This common design pattern is cleaner IMO.

Right now we have an overlap (redundancy) -- people would have to do
two code searches: one for page_remove_rmap() and the other for
folio_remove_rmap_range(nr=3D1), and this IMO is a bad design pattern.
