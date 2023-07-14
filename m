Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8F752FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjGNDYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGNDYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:24:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6621FFC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:24:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e55517de3so4237a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689305040; x=1691897040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAavaLmIeCwYclXN+9/jkCoblgrGrtrOk9lcsx3pq0w=;
        b=KIXsfkQwyuSiZ7lAeGp6ZIlSb0TYvzb3dcNKFNJPdbKpiqxZ+wHFTp4eqzpe2tkANv
         pv3Qs46L3I3UpQ0j2QoVYO25+jRodIjC+C9c/bxR/gB6H4P/n+bLdRYux3pWloWLyGQI
         j6WetHkIsnSmEstipMxWommnaseemHOYIjBASDk4un8tR37s+zFnezjQEVbLP8ED1cWN
         wHYhSa9pQNeUMkwc8oDEzSbLQdCquhS9w9+mjGMobinX5ubMFOn9sLy3m89W+wMX94j8
         eMbBPGG9yOB3T8epjm+QMTFf39Obi/B9nahejQp89OKprTBRnVV1EVo32nh4ULZYLXIi
         qKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689305040; x=1691897040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAavaLmIeCwYclXN+9/jkCoblgrGrtrOk9lcsx3pq0w=;
        b=Sojqg8a+J95CUdCGHvRYmn+AlZSZFH9mrerBRE06CLDzQnSHEK8rRbWgDv8VMWYcEb
         Aa+7eThPcseZfU6pdjUCZY6i/9ccbAHfpD7AhAFZJv6eGbyCxPbiHSE5iHMuBWfVm/8f
         4HAC/9oxRUNdxOP2eEC0JXGTc9NPtnim4ugeqLOAylnSAprte/1+OB8V/C4k2FAjjiGc
         evx6xEHe2u9PZMlrApTXIrRTfInILWHIq7EsiztTsJ+gAOPdrOVzh0Tg7PyiucHd6bfC
         3yhZRQjOiUpKsr4Ln8NrM84WtauChSo0SoXnO6Qkp1Cjr1FgLe/l7+Svaunv2xlr5Jkj
         i20A==
X-Gm-Message-State: ABy/qLZk0L8JWUzhtO3miQkogtR/nw+YSGD0sK5GF6qqml9KXq4xDF2a
        zplkYKSZYqIWRblciQ6Oc2KnqN1KufJWdv1WMVj8Rg==
X-Google-Smtp-Source: APBJJlGjG4qBbS0rwqfLUSuyZ1p0ktq+NWopDc8HyTh7i3Ug4Oz1bNDtDsEWrktWVlsA/CtTxe6Hum4AcDflwh3pwAY=
X-Received: by 2002:a50:bb6a:0:b0:51e:5e41:a0b2 with SMTP id
 y97-20020a50bb6a000000b0051e5e41a0b2mr341376ede.2.1689305039871; Thu, 13 Jul
 2023 20:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com> <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
In-Reply-To: <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 13 Jul 2023 21:23:21 -0600
Message-ID: <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
        shy828301@gmail.com
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

On Thu, Jul 13, 2023 at 9:10=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 7/14/2023 10:08 AM, Yu Zhao wrote:
> > On Thu, Jul 13, 2023 at 9:06=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >> Current madvise_cold_or_pageout_pte_range() has two problems for
> >> large folio support:
> >>   - Using folio_mapcount() with large folio prevent large folio from
> >>     picking up.
> >>   - If large folio is in the range requested, shouldn't split it
> >>     in madvise_cold_or_pageout_pte_range().
> >>
> >> Fix them by:
> >>   - Use folio_estimated_sharers() with large folio
> >>   - If large folio is in the range requested, don't split it. Leave
> >>     to page reclaim phase.
> >>
> >> For large folio cross boundaries of requested range, skip it if it's
> >> page cache. Try to split it if it's anonymous folio. If splitting
> >> fails, skip it.
> >
> > For now, we may not want to change the existing semantic (heuristic).
> > IOW, we may want to stick to the "only owner" condition:
> >
> >   - if (folio_mapcount(folio) !=3D 1)
> >   + if (folio_entire_mapcount(folio) ||
> >   +     (any_page_within_range_has_mapcount > 1))
> >
> > +Minchan Kim
> The folio_estimated_sharers() was discussed here:
> https://lore.kernel.org/linux-mm/20230118232219.27038-6-vishal.moola@gmai=
l.com/
> https://lore.kernel.org/linux-mm/20230124012210.13963-2-vishal.moola@gmai=
l.com/
>
> Yes. It's accurate to check each page of large folio. But it may be over =
killed in
> some cases (And I think madvise is one of the cases not necessary to be a=
ccurate.
> So folio_estimated_sharers() is enough. Correct me if I am wrong).

I see. Then it's possible this is also what the original commit wants
to do -- Minchan, could you clarify?

Regardless, I think we can have the following fix, potentially cc'ing stabl=
e:

-  if (folio_mapcount(folio) !=3D 1)
+  if (folio_estimated_sharers(folio) !=3D 1)

Sounds good?

> > Also there is an existing bug here: the later commit 07e8c82b5eff8
> > ("madvise: convert madvise_cold_or_pageout_pte_range() to use folios")
> > is incorrect for sure; the original commit 9c276cc65a58f ("mm:
> > introduce MADV_COLD") seems incorrect too.
> >
> > +Vishal Moola (Oracle)
> >
> > The "any_page_within_range_has_mapcount" test above seems to be the
> > only correct to meet condition claimed by the comments, before or
> > after the folio conversion, assuming here a THP page means the
> > compound page without PMD mappings (PMD-split). Otherwise the test is
> > always false (if it's also PMD mapped somewhere else).
> >
> >   /*
> >    * Creating a THP page is expensive so split it only if we
> >    * are sure it's worth. Split it if we are only owner.
> >    */
