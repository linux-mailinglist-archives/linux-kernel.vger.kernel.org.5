Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4313A7581D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjGRQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjGRQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:14:52 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D757E0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:14:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401d1d967beso372721cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689696890; x=1692288890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/0dqzn2J5kw4y+zZIL8GSPv8S5vyPyRnDe8Ec33Zrs=;
        b=lSGnSjIBI+wgU+VXQQhzLq0K4fZiryOOw0n4IOvbOn34n0tgp5B9jhkdsuXnuVCBGA
         O8myyTMDd0YWkpVme0wagHte95tKsDm8jVnz6O/k65x1FYsXuDZRBHYekWLEZpju6ToG
         wNlVyXdJ7+gy9P0XmSYaZOcaER2jIEnt2AzZd2iy+jdIOyWHWZmb/hKI+hNW1a3+He5+
         DabixmPFeHBNT+UHIqsxffno8fJv86BXLkLpaWwNw6UuiWIpNLeszY/5JXGhoKNToiu1
         RtHwO4z77x7DA/qTgrwutUy+fYOhWvE7hpWpoerX4aemEYpB/fae/c0dezC5Dx/Gwd8A
         VZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696890; x=1692288890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/0dqzn2J5kw4y+zZIL8GSPv8S5vyPyRnDe8Ec33Zrs=;
        b=EsW0sY8cskmjVeiwATHYMpX9wBjZObPxUiuap4rZ8lm695cjeiGK8RHxOQWxi6ZHjt
         esTYu/Z2ShiBB9azmYlbZS5kaB9jaZ90/l38pL+skTtvn7hqrYa1/WTLaFDzg2INoxyf
         iKCLI9zQDag8TmzMspLszEtejosDcy6VVRk/3MJSq6+HXcmmDDlNNiZbEPnzIZvh/QSO
         ZuslVwgStk3kBXQYTlmZj+WfI42djXJLnIEU7z9+xA+jNNPnIOTJW8MK9uRFoO2dA39t
         +ji3ZxAwULet9tq5gKQZkGSpr8DFRWdRX+BaxU05qp5TTXx+d1rGorAzL6H/NMr6wPOw
         8bSw==
X-Gm-Message-State: ABy/qLbfUmCO6iiohxkW2+nMl//AnfksK4FnJmEaH0KAA5wMQN7A+uFO
        B7O+i0VbXI5OqhdDsvS7P/p05hgsOgIWbfL8vvxdhTKe5B25V5t/0MHl0g==
X-Google-Smtp-Source: APBJJlHdYn3M1o+p9OfETcxusX/LWCe//h2+xWNnjSuKc24YuF5OC/B+OgGNOEavlHS8rC4TKHiuLtw9kwe2CPwIZYk=
X-Received: by 2002:a05:622a:1312:b0:403:d35d:4660 with SMTP id
 v18-20020a05622a131200b00403d35d4660mr223929qtk.11.1689696889673; Tue, 18 Jul
 2023 09:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230718004942.113174-1-mike.kravetz@oracle.com> <20230718004942.113174-2-mike.kravetz@oracle.com>
In-Reply-To: <20230718004942.113174-2-mike.kravetz@oracle.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 18 Jul 2023 09:14:13 -0700
Message-ID: <CADrL8HXY_PDN59YJ33iaDFKqTF4+r9eXjbeat1-Hfa61GEH4JQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlb: Do not clear hugetlb dtor until
 allocating vmemmap
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
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

On Mon, Jul 17, 2023 at 5:50=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> Freeing a hugetlb page and releasing base pages back to the underlying
> allocator such as buddy or cma is performed in two steps:
> - remove_hugetlb_folio() is called to remove the folio from hugetlb
>   lists, get a ref on the page and remove hugetlb destructor.  This
>   all must be done under the hugetlb lock.  After this call, the page
>   can be treated as a normal compound page or a collection of base
>   size pages.
> - update_and_free_hugetlb_folio() is called to allocate vmemmap if
>   needed and the free routine of the underlying allocator is called
>   on the resulting page.  We can not hold the hugetlb lock here.
>
> One issue with this scheme is that a memory error could occur between
> these two steps.  In this case, the memory error handling code treats
> the old hugetlb page as a normal compound page or collection of base
> pages.  It will then try to SetPageHWPoison(page) on the page with an
> error.  If the page with error is a tail page without vmemmap, a write
> error will occur when trying to set the flag.
>
> Address this issue by modifying remove_hugetlb_folio() and
> update_and_free_hugetlb_folio() such that the hugetlb destructor is not
> cleared until after allocating vmemmap.  Since clearing the destructor
> requires holding the hugetlb lock, the clearing is done in
> remove_hugetlb_folio() if the vmemmap is present.  This saves a
> lock/unlock cycle.  Otherwise, destructor is cleared in
> update_and_free_hugetlb_folio() after allocating vmemmap.
>
> Note that this will leave hugetlb pages in a state where they are marked
> free (by hugetlb specific page flag) and have a ref count.  This is not
> a normal state.  The only code that would notice is the memory error
> code, and it is set up to retry in such a case.
>
> A subsequent patch will create a routine to do bulk processing of
> vmemmap allocation.  This will eliminate a lock/unlock cycle for each
> hugetlb page in the case where we are freeing a large number of pages.
>
> Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated wit=
h each HugeTLB page")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 90 ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 66 insertions(+), 24 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 64a3239b6407..4a910121a647 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1579,9 +1579,37 @@ static inline void destroy_compound_gigantic_folio=
(struct folio *folio,
>                                                 unsigned int order) { }
>  #endif
>
> +static inline void __clear_hugetlb_destructor(struct hstate *h,
> +                                               struct folio *folio)
> +{
> +       lockdep_assert_held(&hugetlb_lock);
> +
> +       /*
> +        * Very subtle
> +        *
> +        * For non-gigantic pages set the destructor to the normal compou=
nd
> +        * page dtor.  This is needed in case someone takes an additional
> +        * temporary ref to the page, and freeing is delayed until they d=
rop
> +        * their reference.
> +        *
> +        * For gigantic pages set the destructor to the null dtor.  This
> +        * destructor will never be called.  Before freeing the gigantic
> +        * page destroy_compound_gigantic_folio will turn the folio into =
a
> +        * simple group of pages.  After this the destructor does not
> +        * apply.
> +        *
> +        */

Is it correct and useful to add a
WARN_ON_ONCE(folio_test_hugetlb_vmemmap_optimized(folio)) here?

Feel free to add:

Acked-by: James Houghton <jthoughton@google.com>

> +       if (hstate_is_gigantic(h))
> +               folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
> +       else
> +               folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
> +}
> +
>  /*
> - * Remove hugetlb folio from lists, and update dtor so that the folio ap=
pears
> - * as just a compound page.
> + * Remove hugetlb folio from lists.
> + * If vmemmap exists for the folio, update dtor so that the folio appear=
s
> + * as just a compound page.  Otherwise, wait until after allocating vmem=
map
> + * to update dtor.
>   *
>   * A reference is held on the folio, except in the case of demote.
>   *
> @@ -1612,31 +1640,19 @@ static void __remove_hugetlb_folio(struct hstate =
*h, struct folio *folio,
>         }
>
>         /*
> -        * Very subtle
> -        *
> -        * For non-gigantic pages set the destructor to the normal compou=
nd
> -        * page dtor.  This is needed in case someone takes an additional
> -        * temporary ref to the page, and freeing is delayed until they d=
rop
> -        * their reference.
> -        *
> -        * For gigantic pages set the destructor to the null dtor.  This
> -        * destructor will never be called.  Before freeing the gigantic
> -        * page destroy_compound_gigantic_folio will turn the folio into =
a
> -        * simple group of pages.  After this the destructor does not
> -        * apply.
> -        *
> -        * This handles the case where more than one ref is held when and
> -        * after update_and_free_hugetlb_folio is called.
> -        *
> -        * In the case of demote we do not ref count the page as it will =
soon
> -        * be turned into a page of smaller size.
> +        * We can only clear the hugetlb destructor after allocating vmem=
map
> +        * pages.  Otherwise, someone (memory error handling) may try to =
write
> +        * to tail struct pages.
> +        */
> +       if (!folio_test_hugetlb_vmemmap_optimized(folio))
> +               __clear_hugetlb_destructor(h, folio);
> +
> +        /*
> +         * In the case of demote we do not ref count the page as it will=
 soon
> +         * be turned into a page of smaller size.
>          */
>         if (!demote)
>                 folio_ref_unfreeze(folio, 1);
> -       if (hstate_is_gigantic(h))
> -               folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
> -       else
> -               folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
>
>         h->nr_huge_pages--;
>         h->nr_huge_pages_node[nid]--;
> @@ -1728,6 +1744,19 @@ static void __update_and_free_hugetlb_folio(struct=
 hstate *h,
>                 return;
>         }
>
> +       /*
> +        * If needed, clear hugetlb destructor under the hugetlb lock.
> +        * This must be done AFTER allocating vmemmap pages in case there=
 is an
> +        * attempt to write to tail struct pages as in memory poison.
> +        * It must be done BEFORE PageHWPoison handling so that any subse=
quent
> +        * memory errors poison individual pages instead of head.
> +        */
> +       if (folio_test_hugetlb(folio)) {
> +               spin_lock_irq(&hugetlb_lock);
> +               __clear_hugetlb_destructor(h, folio);
> +               spin_unlock_irq(&hugetlb_lock);
> +       }
> +
>         /*
>          * Move PageHWPoison flag from head page to the raw error pages,
>          * which makes any healthy subpages reusable.
> @@ -3604,6 +3633,19 @@ static int demote_free_hugetlb_folio(struct hstate=
 *h, struct folio *folio)
>                 return rc;
>         }
>
> +       /*
> +        * The hugetlb destructor could still be set for this folio if vm=
emmap
> +        * was actually allocated above.  The ref count on all pages is 0=
.
> +        * Therefore, nobody should attempt access.  However, before dest=
roying
> +        * compound page below, clear the destructor. Unfortunately, this
> +        * requires a lock/unlock cycle.
> +        */
> +       if (folio_test_hugetlb(folio)) {
> +               spin_lock_irq(&hugetlb_lock);
> +               __clear_hugetlb_destructor(h, folio);
> +               spin_unlock_irq(&hugetlb_lock);
> +       }
> +
>         /*
>          * Use destroy_compound_hugetlb_folio_for_demote for all huge pag=
e
>          * sizes as it will not ref count folios.
> --
> 2.41.0
>
