Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75B785C25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbjHWPb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbjHWPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:31:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5251CDF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:31:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bed101b70so746841866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692804713; x=1693409513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYrf2GpbGdlf7lCTIqcEvi/XXKloMRjnbxsd20jVdbA=;
        b=FVFTR6zIZBCtNSVzEXQTnf6c+xo9f1ttBG/opfKcx6YFOgEw5AMtTB/0/nrJw2ZNha
         FqwIi/uJ0cop/dlfSSI5uiZDqRzj7jHartyg5x6GRdhCxtR3ovWY82hmBTT4UZHN1zxS
         zq5sFGmV/ZRLssqN3aaHWnVo5weRQ23UijbtBAdwtQb+TkqsRT1OWNolgEpwqeW0JSdo
         TZiTLxFWAY3nuqKsrZ3ENiSB5/mIKTOdo6a5BTRN9UchCwPawnmGK7g1Uy9NuhqX1mLy
         AJ9t3SEZz+s1MoExy1IqrMIx236qpmUvHyngxPUkJCKlByF0SGYNtqJh3K4B71uajEhS
         m5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804713; x=1693409513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYrf2GpbGdlf7lCTIqcEvi/XXKloMRjnbxsd20jVdbA=;
        b=MpYw2y6LtYUGm0wps6o++X4U+vR+AidzvwcPAwowh45+mZGMERymeqMKwNtPWeCSkn
         fSqxkaiWTWBCJUwuPILS9y3RRLK90goe0ADwDXweb3BTiiOr1NqkiCBdMW+A7UHPw4Aw
         zM0lifv49QaJiOwf9Q99qBg5HP+TR3Zh9n19XdxNy495wpj9ziSVm1kv/JT90VHzOFMA
         LVMhoUxxNtkdlmbpKwQcHEsFjnPwg9MKk8nfCiPZEu5XylLbv06yzz5WD13oHVnJEEzi
         MZBh5kJOCY/x6uZ6gFu83kdiipCUNDflSrQEJr+VYQHzCq0f9Zd3+X9ldOijnXsWxNCj
         zrew==
X-Gm-Message-State: AOJu0Yzghf0OuW/emYZ1vf698vtHgoJVy6X3McWGvaFE8xw5Ecy5kSv9
        01yLUJhG6g0oqneh1uLSYllDGiXqqJsQEj55xUg5/w==
X-Google-Smtp-Source: AGHT+IHhEhVQAm8bllNWnfvIrsbzwpalLHvKYZWfHuErDCbPhelT3wHAcn8MfG+cIeuWsS4XHaFk0nd4eZX2ohR1ycs=
X-Received: by 2002:a17:906:31c1:b0:99d:a6b9:fd04 with SMTP id
 f1-20020a17090631c100b0099da6b9fd04mr9893550ejf.46.1692804713226; Wed, 23 Aug
 2023 08:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230821160849.531668-1-david@redhat.com> <20230821160849.531668-2-david@redhat.com>
 <CAJD7tkYbHUVbg8LexkBsC9rLFBRrBSQYgOZ1tPKTDGEcWrAghQ@mail.gmail.com>
 <b00e2d3a-8601-924c-241c-4373b9dea0cb@redhat.com> <CAJD7tkbjPdk8xSGJG_BGaiNyPdh0-A58vwt7TwjsB4Mjh6RscA@mail.gmail.com>
 <ab9f4179-fb40-c920-ccb5-42c111012b15@redhat.com>
In-Reply-To: <ab9f4179-fb40-c920-ccb5-42c111012b15@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 23 Aug 2023 08:31:16 -0700
Message-ID: <CAJD7tkbHp5tJYb3T0Y_yGcqwkAimPrdQ2SAgSNwVaMFbBFK8BA@mail.gmail.com>
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

On Wed, Aug 23, 2023 at 8:26=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 23.08.23 17:21, Yosry Ahmed wrote:
> > On Wed, Aug 23, 2023 at 8:17=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 23.08.23 17:12, Yosry Ahmed wrote:
> >>> On Mon, Aug 21, 2023 at 9:09=E2=80=AFAM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>> Let's stop using page->private on tail pages, making it possible to
> >>>> just unconditionally reuse that field in the tail pages of large fol=
ios.
> >>>>
> >>>> The remaining usage of the private field for THP_SWAP is in the THP
> >>>> splitting code (mm/huge_memory.c), that we'll handle separately late=
r.
> >>>>
> >>>> Update the THP_SWAP documentation and sanity checks in mm_types.h an=
d
> >>>> __split_huge_page_tail().
> >>>>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>
> >>> The mm part looks good to me (with the added fixup):
> >>>
> >>> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> >>
> >> Thanks!
> >>
> >>>>    /**
> >>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>>> index bb5adc604144..84fe0e94f5cd 100644
> >>>> --- a/include/linux/swap.h
> >>>> +++ b/include/linux/swap.h
> >>>> @@ -339,6 +339,15 @@ static inline swp_entry_t folio_swap_entry(stru=
ct folio *folio)
> >>>>           return entry;
> >>>>    }
> >>>>
> >>>> +static inline swp_entry_t page_swap_entry(struct page *page)
> >>>> +{
> >>>> +       struct folio *folio =3D page_folio(page);
> >>>> +       swp_entry_t entry =3D folio_swap_entry(folio);
> >>>> +
> >>>> +       entry.val +=3D page - &folio->page;
> >>>> +       return entry;
> >>>> +}
> >>>> +
> >>>>    static inline void folio_set_swap_entry(struct folio *folio, swp_=
entry_t entry)
> >>>>    {
> >>>>           folio->private =3D (void *)entry.val;
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index cc2f65f8cc62..c04702ae71d2 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -2446,18 +2446,15 @@ static void __split_huge_page_tail(struct pa=
ge *head, int tail,
> >>>>           page_tail->index =3D head->index + tail;
> >>>>
> >>>>           /*
> >>>> -        * page->private should not be set in tail pages with the ex=
ception
> >>>> -        * of swap cache pages that store the swp_entry_t in tail pa=
ges.
> >>>> -        * Fix up and warn once if private is unexpectedly set.
> >>>> -        *
> >>>> -        * What of 32-bit systems, on which folio->_pincount overlay=
s
> >>>> -        * head[1].private?  No problem: THP_SWAP is not enabled on =
32-bit, and
> >>>> -        * pincount must be 0 for folio_ref_freeze() to have succeed=
ed.
> >>>> +        * page->private should not be set in tail pages. Fix up and=
 warn once
> >>>> +        * if private is unexpectedly set.
> >>>>            */
> >>>> -       if (!folio_test_swapcache(page_folio(head))) {
> >>>> -               VM_WARN_ON_ONCE_PAGE(page_tail->private !=3D 0, page=
_tail);
> >>>> +       if (unlikely(page_tail->private)) {
> >>>> +               VM_WARN_ON_ONCE_PAGE(true, page_tail);
> >>>>                   page_tail->private =3D 0;
> >>>>           }
> >>>
> >>> Could probably save a couple of lines here:
> >>>
> >>> if (VM_WARN_ON_ONCE_PAGE(page_tail->private !=3D 0, page_tail))
> >>>
> >>>          page_tail->private =3D 0;
> >>>
> >>
> >> That would mean that we eventually compile out the runtime check
> >>
> >> #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
> >
> > I thought the warning would be compiled out but not the check, my bad.
>
> I even remembered that VM_WARN_ON_ONCE and friends could/should not be
> used in conditionals.
>
> But we do seem to have two users now:
>
>   $ git grep "if (VM_WARN_ON"
> mm/mmap.c:              if (VM_WARN_ON_ONCE_MM(vma->vm_end !=3D vmi_end, =
mm))
> mm/mmap.c:              if (VM_WARN_ON_ONCE_MM(vma->vm_start !=3D vmi_sta=
rt, mm))
>
> But they only do warning-related action, to dump the stack, the vma, ...
>
> So if the warnings get compiled out, also all the other stuff gets compil=
ed out as well,
> which makes sense here.

Funny enough, I did the same grep and immediately thought that since
we have users of that, then it's okay (i.e the check wouldn't be
compiled out). I wasn't thorough enough to actually check what they
are doing :)

>
> --
> Cheers,
>
> David / dhildenb
>
