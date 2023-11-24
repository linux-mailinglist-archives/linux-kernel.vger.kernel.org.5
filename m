Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95B47F6DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjKXIPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjKXIPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:15:03 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3191702
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:15:08 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso19668581fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700813707; x=1701418507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EYwIkp2+JQBbwt8LYg5s9Pu8iHhOSMhe1Ch2bTUfS8=;
        b=ScsPkB3QuOm4j8YMdBtHYMMuSKvWPwBFsTISzw1rJ1YeZiH6kWXMJrVWWiy+O97c2h
         q1jipEBmSJDfDdD0QhVFO1PSHBLgNFphq+59BiXRb6T1u8Zz+EzmUsxiOnKzUYUyYP9R
         Omt7WLbHWLGWKuuPFDq28hMKdl6cJxVU5JSz+wp/ErlZc0HBMmHQ5MxY28O9FeT53SK+
         BxHRXt+i5jRYA8zQPb1gO6ATUgsxAUzXQIYAQgZXobzRKFK+7V5K/MQOA4E4mSJrHNkw
         ZPIojiTicSTK0cJ6hOuTkma+moaVRghdwziQfaThP1Xt14wke3OyLWNkE3wi6ed20kfa
         h32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700813707; x=1701418507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EYwIkp2+JQBbwt8LYg5s9Pu8iHhOSMhe1Ch2bTUfS8=;
        b=As/genYMrLGIG4Qh3MG4aAyrShgtkD0rJvjJEa4mBAI42rkCYLharVFsU9AXwQTEcx
         9u0ugA1fPIohShFDpSw24fzkENzvZaiilN3tjFqG2yPIdlXzHTX3eDWcRvRoiG43VRc+
         1YEStcVGwQe4v6xIt5Uw1V7m9eeAG5HE1oQxikHXE3C+rvKiFiXvzD3ps+ydM35kTFUs
         CVt01TwLOeFqIMm+e8Xi94/x6hTs9Zg9ofScMCuLADY1gw4cCiSqfNcTi0KJk2BcfNu3
         2cN//Lx/kjch1SGh9MSRnMhotlmTJX4IdIMF8VObQxQcG2/L1yfTpbjxbKVYJeC7BhA8
         ROyA==
X-Gm-Message-State: AOJu0YzMvV+3vTzIEFBmc3tXc7EHF7figKjRK7H1TjH0TmraiMzogb2j
        b0Gv+/ThDIHnRzhf9qZ0jDMQ1cV4kh84lID8E6A=
X-Google-Smtp-Source: AGHT+IHuAjr2hg83x7hwu14c0h4KwHcHHqArvnEQR9FpmuSLSDWtPuPaAuIT+hAxfw1N2h1khf2ZD80b2NpE99GcMHk=
X-Received: by 2002:a2e:90c2:0:b0:2c8:8024:3447 with SMTP id
 o2-20020a2e90c2000000b002c880243447mr1378942ljg.44.1700813706787; Fri, 24 Nov
 2023 00:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-22-ryncsn@gmail.com>
 <CAF8kJuN5GELAdh5ZJHthtgJCaYkgQ38BmzLZerUp6fS+pVU=WQ@mail.gmail.com>
In-Reply-To: <CAF8kJuN5GELAdh5ZJHthtgJCaYkgQ38BmzLZerUp6fS+pVU=WQ@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Fri, 24 Nov 2023 16:14:49 +0800
Message-ID: <CAMgjq7CMvT-YLQoeRKCaNUDLyzuLzCi7s8rzgsNxpncc=7AWcg@mail.gmail.com>
Subject: Re: [PATCH 21/24] swap: make swapin_readahead result checking
 argument mandatory
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=B8=89 13:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 19, 2023 at 11:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > This is only one caller now in page fault path, make the result return
> > argument mandatory.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_state.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 6f39aa8394f1..0433a2586c6d 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -913,7 +913,6 @@ static struct page *swapin_no_readahead(swp_entry_t=
 entry, gfp_t gfp_mask,
> >  struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> >                               struct vm_fault *vmf, enum swap_cache_res=
ult *result)
> >  {
> > -       enum swap_cache_result cache_result;
> >         struct swap_info_struct *si;
> >         struct mempolicy *mpol;
> >         void *shadow =3D NULL;
> > @@ -928,29 +927,27 @@ struct page *swapin_readahead(swp_entry_t entry, =
gfp_t gfp_mask,
> >
> >         folio =3D swap_cache_get_folio(entry, vmf, &shadow);
> >         if (folio) {
> > +               *result =3D SWAP_CACHE_HIT;
> >                 page =3D folio_file_page(folio, swp_offset(entry));
> > -               cache_result =3D SWAP_CACHE_HIT;
> >                 goto done;
> >         }
> >
> >         mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> >         if (swap_use_no_readahead(si, swp_offset(entry))) {
> > +               *result =3D SWAP_CACHE_BYPASS;
>
> Each of this "*result" will compile into memory store instructions.
> The compiler most likely can't optimize and combine them together
> because the store can cause segfault from the compiler's point of
> view. The multiple local variable assignment can be compiled into a
> few registers assignment so it does not cost as much as multiple
> memory stores.
>
> >                 page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx=
, vmf->vma->vm_mm);
> > -               cache_result =3D SWAP_CACHE_BYPASS;
> >                 if (shadow)
> >                         workingset_refault(page_folio(page), shadow);
> > -       } else if (swap_use_vma_readahead(si)) {
> > -               page =3D swap_vma_readahead(entry, gfp_mask, mpol, ilx,=
 vmf);
> > -               cache_result =3D SWAP_CACHE_MISS;
> >         } else {
> > -               page =3D swap_cluster_readahead(entry, gfp_mask, mpol, =
ilx);
> > -               cache_result =3D SWAP_CACHE_MISS;
> > +               *result =3D SWAP_CACHE_MISS;
> > +               if (swap_use_vma_readahead(si))
> > +                       page =3D swap_vma_readahead(entry, gfp_mask, mp=
ol, ilx, vmf);
> > +               else
> > +                       page =3D swap_cluster_readahead(entry, gfp_mask=
, mpol, ilx);
>
> I recall you introduce or heavy modify this function in previous patch be=
fore.
> Consider combine some of the patch and present the final version sooner.
> From the reviewing point of view, don't need to review so many
> internal version which get over written any way.
>
> >         }
> >         mpol_cond_put(mpol);
> >  done:
> >         put_swap_device(si);
> > -       if (result)
> > -               *result =3D cache_result;
>
> The original version with check and assign it at one place is better.
> Safer and produce better code.

Yes, that's less error-prone indeed, saving a "if" seems doesn't worth
all the potential trouble, will drop this.
