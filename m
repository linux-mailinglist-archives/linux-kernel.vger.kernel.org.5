Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580BE785BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbjHWPW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbjHWPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:22:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992931711
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:22:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a1de3417acso145398866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692804098; x=1693408898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhg/e4LS8bNfiVgkrr4EWQYAPV9fIVBY5JtlZm2jayY=;
        b=Q1+BATEl4MgihwvjeH3zMhM/2EzkuflMMWwziDhCxRNcGhTM83mMQYqYEV5bPfYt1k
         CG0JrYqgLqW4jFOn+jBGo2s5sLD7cOcgDQ6EwNrkef7z8UxNVbA7mR8X09qAnlZbXwOq
         NZBJlvYMfNnRhwx1VyzycL81YKjYeMVazRVw4B2wkXW08BOzUsSgz1yPBdsmyhLGJEkm
         rD8sRehHnYO6V/Ft04JB+UgoxVh+TdXlGt0dwGafMcyHcjmpWnpBWNusC2oHlz6aYOPV
         gKr5LLt4rc3yvzkPbXyIVjGqgQBs7r702WLfPyVuY1fRZNIo1q2zjUyxH4FvWNyBGMaE
         +jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804098; x=1693408898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhg/e4LS8bNfiVgkrr4EWQYAPV9fIVBY5JtlZm2jayY=;
        b=XTKhTw4Lmh92WlVA9h8HkmFR0CbdN320dRYtI/naLUuzifgj0ajmB3wlK1tL/O8BrK
         7Q/ugRRwVUfwRTcO2AScyAdVlxYtG4aQIyS+TjT1nGRMIOGF7Tu6rAh1Tn0+JYdYeHLs
         GVRayrPfKMt8VdQTcEaGOCWHC2s10CLJrPhmmcfnZU/EyK6SFXqlV1jk16djq+GTgGto
         ziGIWP+aLqorzE7BWyOv04Q+k6DkhsuHJpnTsCsPuRcp0QwlmoDCsaH1MzSX8lEEYzhd
         RpZaTg+nXXYeqc+Y8ftMwKPKnToPZTKVSPGFNMyUojG0AXQGKazZfF+2LenvpJwNuV8V
         3e2A==
X-Gm-Message-State: AOJu0YycTB8/T4aZQfRnukDqDUP0n6VqUXBRi+Os88zO/uTm+Zr+M2s2
        RWNjaSMIXTJptXfoaewHkOGzc6sehUu2FicLR8C6nA==
X-Google-Smtp-Source: AGHT+IFrKHsEM0IbDz6KXhTtMrBoA3+G+4T1xLCzShT8Dr+GOMGHAxHvfHH3ebiSuGNwpxt6NcQA95vhMPtVoo2z7ms=
X-Received: by 2002:a17:907:7e8c:b0:978:8979:c66c with SMTP id
 qb12-20020a1709077e8c00b009788979c66cmr15323509ejc.18.1692804098061; Wed, 23
 Aug 2023 08:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230821160849.531668-1-david@redhat.com> <20230821160849.531668-2-david@redhat.com>
 <CAJD7tkYbHUVbg8LexkBsC9rLFBRrBSQYgOZ1tPKTDGEcWrAghQ@mail.gmail.com> <b00e2d3a-8601-924c-241c-4373b9dea0cb@redhat.com>
In-Reply-To: <b00e2d3a-8601-924c-241c-4373b9dea0cb@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 23 Aug 2023 08:21:01 -0700
Message-ID: <CAJD7tkbjPdk8xSGJG_BGaiNyPdh0-A58vwt7TwjsB4Mjh6RscA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/swap: stop using page->private on
 tail pages for THP_SWAP
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
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

On Wed, Aug 23, 2023 at 8:17=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 23.08.23 17:12, Yosry Ahmed wrote:
> > On Mon, Aug 21, 2023 at 9:09=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> Let's stop using page->private on tail pages, making it possible to
> >> just unconditionally reuse that field in the tail pages of large folio=
s.
> >>
> >> The remaining usage of the private field for THP_SWAP is in the THP
> >> splitting code (mm/huge_memory.c), that we'll handle separately later.
> >>
> >> Update the THP_SWAP documentation and sanity checks in mm_types.h and
> >> __split_huge_page_tail().
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > The mm part looks good to me (with the added fixup):
> >
> > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>
> Thanks!
>
> >>   /**
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index bb5adc604144..84fe0e94f5cd 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -339,6 +339,15 @@ static inline swp_entry_t folio_swap_entry(struct=
 folio *folio)
> >>          return entry;
> >>   }
> >>
> >> +static inline swp_entry_t page_swap_entry(struct page *page)
> >> +{
> >> +       struct folio *folio =3D page_folio(page);
> >> +       swp_entry_t entry =3D folio_swap_entry(folio);
> >> +
> >> +       entry.val +=3D page - &folio->page;
> >> +       return entry;
> >> +}
> >> +
> >>   static inline void folio_set_swap_entry(struct folio *folio, swp_ent=
ry_t entry)
> >>   {
> >>          folio->private =3D (void *)entry.val;
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index cc2f65f8cc62..c04702ae71d2 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -2446,18 +2446,15 @@ static void __split_huge_page_tail(struct page=
 *head, int tail,
> >>          page_tail->index =3D head->index + tail;
> >>
> >>          /*
> >> -        * page->private should not be set in tail pages with the exce=
ption
> >> -        * of swap cache pages that store the swp_entry_t in tail page=
s.
> >> -        * Fix up and warn once if private is unexpectedly set.
> >> -        *
> >> -        * What of 32-bit systems, on which folio->_pincount overlays
> >> -        * head[1].private?  No problem: THP_SWAP is not enabled on 32=
-bit, and
> >> -        * pincount must be 0 for folio_ref_freeze() to have succeeded=
.
> >> +        * page->private should not be set in tail pages. Fix up and w=
arn once
> >> +        * if private is unexpectedly set.
> >>           */
> >> -       if (!folio_test_swapcache(page_folio(head))) {
> >> -               VM_WARN_ON_ONCE_PAGE(page_tail->private !=3D 0, page_t=
ail);
> >> +       if (unlikely(page_tail->private)) {
> >> +               VM_WARN_ON_ONCE_PAGE(true, page_tail);
> >>                  page_tail->private =3D 0;
> >>          }
> >
> > Could probably save a couple of lines here:
> >
> > if (VM_WARN_ON_ONCE_PAGE(page_tail->private !=3D 0, page_tail))
> >
> >         page_tail->private =3D 0;
> >
>
> That would mean that we eventually compile out the runtime check
>
> #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)

I thought the warning would be compiled out but not the check, my bad.

>
> --
> Cheers,
>
> David / dhildenb
>
