Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6840E7B7417
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjJCW2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJCW2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:28:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEAFA7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:28:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso1132088a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696372097; x=1696976897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjVaaNbjiuXfFRi+hsEJ3ityN5sLjRpwvH34Vm3lyCg=;
        b=jyvu6Z05ZCB7jqaknM4j7H3/cplwrJBeNZfTZYemEvC7wB5tG5dG7x+95UyP601gmS
         751lV6er9IaaIgw/+383yxsYseK3FW82Z+CLfBz4r/8E/oLFttFoSyKpYMyHUCiedFoA
         oSjHy1tywep6dOP4Q7ImngoCxoCPe8nlmcfGZzOxYXqnSjJ+wUHz/ngtfT5Pu4StZRVC
         HeP1dFOQf+Jy1+dDIC/4yQdNhfYpY50P9/X6zC5aA679zQxrujyyolfXVXAdT0GWDUzI
         rxBDnLhRzxgSpGIMxKKnnMenKNILl7JOSEjtTTcG/KmGK67hxCG5StckffcDiHse2TIL
         yCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696372097; x=1696976897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjVaaNbjiuXfFRi+hsEJ3ityN5sLjRpwvH34Vm3lyCg=;
        b=o67FWKLV2jpKhGMyDkYMbGAqOBowFtLhMH2RwY3SvzqvmAqvGY5hsq1IOth+qzZB/I
         XmxfITW8T5HC/qnCyv+A7dQ2yt/Y2s2FpXj0plzArzBcxG93o37YzVBdmUpaKNC56ZaB
         J7DUi5jCQ+RRuTX9vYfWMGuTJGeFLy7P1uDAGylgmj6C9IhRj7V8bC5liHs9xHfFkrkR
         ZDzRIkcs5V2mjoFnwsM9RWb+fbR9eZohFquYk+Y87v3Gn781CgnB33zM/RGVJk7DvV40
         J9uC2NoIG0O5pYP4e5k7YySM5ZzqN1sPlylX1X5UEKl4UuZPkhUWSP1B/O4VWnyaI1Q1
         Nd0w==
X-Gm-Message-State: AOJu0YyQg3Mgvkj6IiDsQGC+vqh8iRrGExjCXFyw2rjkxdf5ovUTbah9
        6nZd4ENTIy1LjnW50djd2t6nTFiXrIjK0PCr+Uf313Z1
X-Google-Smtp-Source: AGHT+IG/4DThVes56oFOfCGNi886XpnTUDNUMFs/fiSC0i2swouaA5d0uQH9WnPDgF1WR/bDiFIUlddVXFKR0D9urjs=
X-Received: by 2002:a05:6a21:99a2:b0:15e:d84:1c5e with SMTP id
 ve34-20020a056a2199a200b0015e0d841c5emr800517pzb.38.1696372097502; Tue, 03
 Oct 2023 15:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com> <80c9665c-1c3f-17ba-21a3-f6115cebf7d@google.com>
In-Reply-To: <80c9665c-1c3f-17ba-21a3-f6115cebf7d@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 3 Oct 2023 15:28:06 -0700
Message-ID: <CAHbLzkpso6SKP05UDwgSnY_PcX+9O9JF2ud1h69v71A_KHHO3A@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] mempolicy: remove confusing MPOL_MF_LAZY dead code
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 2:24=E2=80=AFAM Hugh Dickins <hughd@google.com> wrot=
e:
>
> v3.8 commit b24f53a0bea3 ("mm: mempolicy: Add MPOL_MF_LAZY") introduced
> MPOL_MF_LAZY, and included it in the MPOL_MF_VALID flags; but a720094ded8
> ("mm: mempolicy: Hide MPOL_NOOP and MPOL_MF_LAZY from userspace for now")
> immediately removed it from MPOL_MF_VALID flags, pending further review.
> "This will need to be revisited", but it has not been reinstated.
>
> The present state is confusing: there is dead code in mm/mempolicy.c to
> handle MPOL_MF_LAZY cases which can never occur.  Remove that: it can be
> resurrected later if necessary.  But keep the definition of MPOL_MF_LAZY,
> which must remain in the UAPI, even though it always fails with EINVAL.
>
> https://lore.kernel.org/linux-mm/1553041659-46787-1-git-send-email-yang.s=
hi@linux.alibaba.com/
> links to a previous request to remove MPOL_MF_LAZY.

Thanks for mentioning my work. I'm glad to see the dead code go away.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/uapi/linux/mempolicy.h |  2 +-
>  mm/mempolicy.c                 | 18 ------------------
>  2 files changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolic=
y.h
> index 046d0ccba4cd..a8963f7ef4c2 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -48,7 +48,7 @@ enum {
>  #define MPOL_MF_MOVE    (1<<1) /* Move pages owned by this process to co=
nform
>                                    to policy */
>  #define MPOL_MF_MOVE_ALL (1<<2)        /* Move every page to conform to =
policy */
> -#define MPOL_MF_LAZY    (1<<3) /* Modifies '_MOVE:  lazy migrate on faul=
t */
> +#define MPOL_MF_LAZY    (1<<3) /* UNSUPPORTED FLAG: Lazy migrate on faul=
t */
>  #define MPOL_MF_INTERNAL (1<<4)        /* Internal flags start here */
>
>  #define MPOL_MF_VALID  (MPOL_MF_STRICT   |     \
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 5d99fd5cd60b..f3224a8b0f6c 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -636,12 +636,6 @@ unsigned long change_prot_numa(struct vm_area_struct=
 *vma,
>
>         return nr_updated;
>  }
> -#else
> -static unsigned long change_prot_numa(struct vm_area_struct *vma,
> -                       unsigned long addr, unsigned long end)
> -{
> -       return 0;
> -}
>  #endif /* CONFIG_NUMA_BALANCING */
>
>  static int queue_pages_test_walk(unsigned long start, unsigned long end,
> @@ -680,14 +674,6 @@ static int queue_pages_test_walk(unsigned long start=
, unsigned long end,
>         if (endvma > end)
>                 endvma =3D end;
>
> -       if (flags & MPOL_MF_LAZY) {
> -               /* Similar to task_numa_work, skip inaccessible VMAs */
> -               if (!is_vm_hugetlb_page(vma) && vma_is_accessible(vma) &&
> -                       !(vma->vm_flags & VM_MIXEDMAP))
> -                       change_prot_numa(vma, start, endvma);
> -               return 1;
> -       }
> -
>         /*
>          * Check page nodes, and queue pages to move, in the current vma.
>          * But if no moving, and no strict checking, the scan can be skip=
ped.
> @@ -1274,9 +1260,6 @@ static long do_mbind(unsigned long start, unsigned =
long len,
>         if (IS_ERR(new))
>                 return PTR_ERR(new);
>
> -       if (flags & MPOL_MF_LAZY)
> -               new->flags |=3D MPOL_F_MOF;
> -
>         /*
>          * If we are using the default policy then operation
>          * on discontinuous address spaces is okay after all
> @@ -1321,7 +1304,6 @@ static long do_mbind(unsigned long start, unsigned =
long len,
>
>         if (!err) {
>                 if (!list_empty(&pagelist)) {
> -                       WARN_ON_ONCE(flags & MPOL_MF_LAZY);
>                         nr_failed |=3D migrate_pages(&pagelist, new_folio=
, NULL,
>                                 start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND, =
NULL);
>                 }
> --
> 2.35.3
>
