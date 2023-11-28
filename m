Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73D87FB957
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjK1LW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343838AbjK1LWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:22:24 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4000D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:22:30 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c997447ff9so38738441fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701170549; x=1701775349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULlAN2OTwH0qqZqtpyuFI3gtbbBSb9YRY8MDdp/pLEI=;
        b=NB/ZZ4OfuekjUCD+HmArLOdmhiLrMmoxVotzVDeOo7bOqWJmJ5qg0O96SyUc1Dsxe4
         TtWKMrm9Gm8RH4GBCiLAAwqCYhRajzw3+pLJ/oTA7QJPpDdN2O0muxBbZbphAnAyf8s2
         l0BPR10T9AGKSttFFBCDOxtMJP7wbAKFNoC6hgca8YRyx0P3jWJwEUtWsompYkZDZiKY
         Np+SWevSlNPMouX7GQgL1aGM3bdB3iSyQGnEYe6TkGLO3wmqC/ogek11QQYC6aRSzOkY
         eL8gLAQYm9wWVX/3ymFbS21T+kpriIwHdxJZkWulgNEfReE8Gm1cGryB2JQh2Bvi8Hxg
         f3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701170549; x=1701775349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULlAN2OTwH0qqZqtpyuFI3gtbbBSb9YRY8MDdp/pLEI=;
        b=bD93b5Y799+SUG9Y12c8Xrb6T5o7ZBMtzWYWIkjaHDOjMa9oQtKuLJqm+DMM9G0e2J
         97MDDB4RSBN21WIMSqA37eWU2JeVacTHrdxucxVWJfFSQdVajjh1RRIggVTtulp470BG
         gG1jeIsgsbh7Rm0CswqsbuMQj5Xhh6uF/eD7zOSynpjv6RwIo3i6nWqwgzTt3LGdtS3n
         +deickp1zUvAaAh3z/D39489Y/ipSGhzjTZKw9HAQNmnz5P8HsThbVk/nvyp6HTF8WgS
         IvRvNEKveozw2atMTwCJQHCX8ljeav9DqBJ/aDiNCREAp3lK7A90zaVukJkA7M6AnsrH
         uLeQ==
X-Gm-Message-State: AOJu0YyUzwaB0ISTCQH8SV0qTczzHptL4MTTHwMdEG/yOYb6Gl4ZyEeR
        J9IwZPZVMfrQS0k+lQvYZGMv3JP+CV9IeeDNbf0=
X-Google-Smtp-Source: AGHT+IEgbSqEM0GnWhmYSByqskXTL1dK//72eoBZ12lYDz5E4DY/JajbIzLVllzygCGo+JnKCyJuyOjidlFrHgu7b5Y=
X-Received: by 2002:a2e:a7c8:0:b0:2c9:a0d6:1a2d with SMTP id
 x8-20020a2ea7c8000000b002c9a0d61a2dmr5997059ljp.8.1701170548525; Tue, 28 Nov
 2023 03:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-19-ryncsn@gmail.com>
 <CAF8kJuNmzGSCE_VhXboXF4tGbLvJXxXYM6j-vkF4d1CkRB-z5A@mail.gmail.com>
In-Reply-To: <CAF8kJuNmzGSCE_VhXboXF4tGbLvJXxXYM6j-vkF4d1CkRB-z5A@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Tue, 28 Nov 2023 19:22:10 +0800
Message-ID: <CAMgjq7AwFiDb7cAMkWMWb3vkccie1-tocmZfT7m4WRb_UKPghg@mail.gmail.com>
Subject: Re: [PATCH 18/24] mm/swap: introduce a helper non fault swapin
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=B8=89 12:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 19, 2023 at 11:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > There are two places where swapin is not direct caused by page fault:
> > shmem swapin is invoked through shmem mapping, swapoff cause swapin by
> > walking the page table. They used to construct a pseudo vmfault struct
> > for swapin function.
> >
> > Shmem has dropped the pseudo vmfault recently in commit ddc1a5cbc05d
> > ("mempolicy: alloc_pages_mpol() for NUMA policy without vma"). Swapoff
> > path is still using a pseudo vmfault.
> >
> > Introduce a helper for them both, this help save stack usage for swapof=
f
> > path, and help apply a unified swapin cache and readahead policy check.
> >
> > Also prepare for follow up commits.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/shmem.c      | 51 ++++++++++++++++---------------------------------
> >  mm/swap.h       | 11 +++++++++++
> >  mm/swap_state.c | 38 ++++++++++++++++++++++++++++++++++++
> >  mm/swapfile.c   | 23 +++++++++++-----------
> >  4 files changed, 76 insertions(+), 47 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index f9ce4067c742..81d129aa66d1 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1565,22 +1565,6 @@ static inline struct mempolicy *shmem_get_sbmpol=
(struct shmem_sb_info *sbinfo)
> >  static struct mempolicy *shmem_get_pgoff_policy(struct shmem_inode_inf=
o *info,
> >                         pgoff_t index, unsigned int order, pgoff_t *ilx=
);
> >
> > -static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
> > -                       struct shmem_inode_info *info, pgoff_t index)
> > -{
> > -       struct mempolicy *mpol;
> > -       pgoff_t ilx;
> > -       struct page *page;
> > -
> > -       mpol =3D shmem_get_pgoff_policy(info, index, 0, &ilx);
> > -       page =3D swap_cluster_readahead(swap, gfp, mpol, ilx);
> > -       mpol_cond_put(mpol);
> > -
> > -       if (!page)
> > -               return NULL;
> > -       return page_folio(page);
> > -}
> > -
>
> Nice. Thank you.
>
> >  /*
> >   * Make sure huge_gfp is always more limited than limit_gfp.
> >   * Some of the flags set permissions, while others set limitations.
> > @@ -1854,9 +1838,12 @@ static int shmem_swapin_folio(struct inode *inod=
e, pgoff_t index,
> >  {
> >         struct address_space *mapping =3D inode->i_mapping;
> >         struct shmem_inode_info *info =3D SHMEM_I(inode);
> > -       struct swap_info_struct *si;
> > +       enum swap_cache_result result;
> >         struct folio *folio =3D NULL;
> > +       struct mempolicy *mpol;
> > +       struct page *page;
> >         swp_entry_t swap;
> > +       pgoff_t ilx;
> >         int error;
> >
> >         VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
> > @@ -1866,34 +1853,30 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> >         if (is_poisoned_swp_entry(swap))
> >                 return -EIO;
> >
> > -       si =3D get_swap_device(swap);
> > -       if (!si) {
> > +       mpol =3D shmem_get_pgoff_policy(info, index, 0, &ilx);
> > +       page =3D swapin_page_non_fault(swap, gfp, mpol, ilx, fault_mm, =
&result);

Hi Chris,

I've been trying to address these issues in V2, most issue in other
patches have a straight solution, some could be discuss in seperate
series, but I come up with some thoughts here:

>
> Notice this "result" CAN be outdated. e.g. after this call, the swap
> cache can be changed by another thread generating the swap page fault
> and installing the folio into the swap cache or removing it.

This is true, and it seems a potential race also exist before this
series for direct (no swapcache) swapin path (do_swap_page) if I
understand it correctly:

In do_swap_page path, multiple process could swapin the page at the
same time (a mapped once page can still be shared by sub threads),
they could get different folios. The later pte lock and pte_same check
is not enough, because while one process is not holding the pte lock,
another process could read-in, swap_free the entry, then swap-out the
page again, using same entry, an ABA problem. The race is not likely
to happen in reality but in theory possible.

Same issue for shmem here, there are
shmem_confirm_swap/shmem_add_to_page_cache check later to prevent
re-installing into shmem mapping for direct swap in, but also not
enough. Other process could read-in and re-swapout using same entry so
the mapping entry seems unchanged during the time window. Still very
unlikely to happen in reality, but not impossible.

When swapcache is used there is no such issue, since swap lock and
swap_map are used to sync all readers, and while one reader is still
holding the folio, the entry is locked through swapcache, or if a
folio is removed from swapcache, folio_test_swapcache will fail, and
the reader could retry.

I'm trying to come up with a better locking for direct swap in, am I
missing anything here? Correct me if I get it wrong...
