Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F55783661
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjHUXfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHUXfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:35:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3283CDF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:34:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb0336ed4fso766e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692660883; x=1693265683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A54V70or4HVq8F9rxCPaBDJeQam0nY34rK8TRrDq9Pw=;
        b=4PUHlW3xatjmFic7aEt4R9ivlLm+IXmw0tJ95HLAXe28jXbDSDyn3Z1AboBh0KLPry
         BuuGYYbPsOhIOsZ3nQ1EF+kMHDVwpUlWnNpBV7IG1wYm9530TNFOk6XeaTM+/7Zq/V1y
         Joa1Lt6lSkrj9BLsx5RWmAEm54lrJHSD2ccUyxiJI5bFT0ADZgUR8UWWbBvsXL3Q6Pdn
         31yYxqfyBw4wb+kRBCBsGGjCgrXcCQicIgFijBWKgEBOPYAnZ4kbtrzEKS3rXF1c9D11
         Qn35ooYRMOAEIQ1reiDZRgabEI43zFBtJahAT8d7tbGVkC1uaJQmmWb54q/BAgUHbPdp
         IJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692660883; x=1693265683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A54V70or4HVq8F9rxCPaBDJeQam0nY34rK8TRrDq9Pw=;
        b=bIDThI5Fyf1F/3M6Qj7m8sjFdnQWlZ2ab/JyCMKfduS0h20qHuQg7eSAAcpW2fGPq1
         J3aO6vCj5mrGrK3kfMhSBSfFnu0gAF+8iUSwI3rSIgT+jKitcYZhbuo7E4ipx3Jrnc8i
         zd+c6bhwiLXqR41q175szf9CqhKYHylkRTnD0U0l+P7csJULXwPrwdpV5kKzhGM8AhjL
         Znl9hHDyMiv/WCNKaz5QkmBzB8Zv+Dxy6Q0YvrbAgNgNcoJ8qE+Pq3WDmt9XmJWz6QPq
         07EbBH2GansC8hkj2wU4K8nrtJnveKIr678vbJKfWk2iAs+EC0dVkgwhI1bzoW5snnAh
         BCOg==
X-Gm-Message-State: AOJu0Yz7uHV1j4J3Q0eVQjP9iBacCmtE9wJs2wi7lH0LOQc1e7rPvio4
        +yZrOT2qJrYWX+OTQdbsTw5cX8HgAXNCD91AgpxAdQ==
X-Google-Smtp-Source: AGHT+IGQQnHeUTd5n/FizVssz2JTYq3qNAJxVfz6QI34YYlEswenP5KVAycXosoQp1EpVf/+ANie5NhxjXQypOjHX1w=
X-Received: by 2002:ac2:5195:0:b0:4ff:d0c0:5d72 with SMTP id
 u21-20020ac25195000000b004ffd0c05d72mr27733lfi.0.1692660882966; Mon, 21 Aug
 2023 16:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230818211533.2523697-1-zokeefe@google.com> <CAHbLzkrvAFYHBGz6fZEZYD0vO5bJAT3dJgP5a7-+y+jJ9Fsm+Q@mail.gmail.com>
In-Reply-To: <CAHbLzkrvAFYHBGz6fZEZYD0vO5bJAT3dJgP5a7-+y+jJ9Fsm+Q@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 21 Aug 2023 16:34:05 -0700
Message-ID: <CAAa6QmRrJZwNGO-z_co71cRKroXa7oJ=6nA-5Hbpo5bWeu4_BQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 3:53=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Fri, Aug 18, 2023 at 2:15=E2=80=AFPM Zach O'Keefe <zokeefe@google.com>=
 wrote:
> >
> > The 6.0 commits:
> >
> > commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
> > commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> >
> > merged "can we have THPs in this VMA?" logic that was previously done
> > separately by fault-path, khugepaged, and smaps "THPeligible" checks.
> >
> > During the process, the semantics of the fault path check changed in tw=
o
> > ways:
> >
> > 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
> > 2) We no longer checked if non-anonymous memory had a vm_ops->huge_faul=
t
> >    handler that could satisfy the fault.  Previously, this check had be=
en
> >    done in create_huge_pud() and create_huge_pmd() routines, but after
> >    the changes, we never reach those routines.
> >
> > During the review of the above commits, it was determined that in-tree
> > users weren't affected by the change; most notably, since the only rele=
vant
> > user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
> > explicitly approved early in approval logic.  However, there is at leas=
t
> > one occurrence where an out-of-tree driver that used
> > VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was broken.
> >
> > Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
> > any ->huge_fault handler a chance to handle the fault.  Note that we
> > don't validate the file mode or mapping alignment, which is consistent
> > with the behavior before the aforementioned commits.
> >
> > Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> > Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
> > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > ---
> > Changed from v1[1]:
> >         - [Saurabhi] Allow ->huge_fault handler to handle fault, if it =
exists
> >
> > [1] https://lore.kernel.org/linux-mm/CAAa6QmQw+F=3Do6htOn=3D6ADD6mwvMO=
=3DOw_67f3ifBv3GpXx9Xg_g@mail.gmail.com/
>
> Thanks, Zach. The patch looks correct to me. You can add
> Reviewed-by:Yang Shi <shy828301@gmail.com>.


Hey Yang, thanks for taking the time to review .. and ..  welcome back :)

Sorry to do this to you, but while responding to you on another thread
I realized an issue below:

> A further comment below...
>
> >
> > ---
> >  mm/huge_memory.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index eb3678360b97..cd379b2c077b 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -96,11 +96,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma,=
 unsigned long vm_flags,
> >                 return in_pf;
> >
> >         /*
> > -        * Special VMA and hugetlb VMA.
> > +        * khugepaged special VMA and hugetlb VMA.
> >          * Must be checked after dax since some dax mappings may have
> >          * VM_MIXEDMAP set.
> >          */
> > -       if (vm_flags & VM_NO_KHUGEPAGED)
> > +       if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
>
> I'm wondering whether we shall remove VM_MIXEDMAP from
> VM_NO_KHUGEPAGED or not if that kind VMAs are huge page applicable for
> some usecases. The downside may be some CPU time waste on the
> VM_MIXEDMAP area which has PFN instead of struct page, but it should
> be ok. Anything else did I miss? Just back from a long vacation, my
> brain is still not running in full speed yet.

I was thinking about the same thing, and had originally intended to
raise that question here -- but thought it better to stick with the
immediate issue. Ironically, we've gone off on both a THPeligible
tangent and another about faulting file-backed memory.

But ya, AFAIU, there is no technical reason why collapse can't act on
VM_MIXEDMAP, as long as all the pages it finds are vm_normal() pages.
I don't know enough about the possible use cases here though, and
whether this is the best memory to be allocating precious hugepages
to. You also raise a good point about cpu usage, since there may be a
greater chance of failing late in scan due finding a PFN-only mapping.

> >                 return false;
> >
> >         /*
> > @@ -128,12 +128,15 @@ bool hugepage_vma_check(struct vm_area_struct *vm=
a, unsigned long vm_flags,
> >                                            !hugepage_flags_always())))
> >                 return false;
> >
> > -       /* Only regular file is valid */
> > -       if (!in_pf && file_thp_enabled(vma))
> > -               return true;
> > -
> >         if (!vma_is_anonymous(vma))
> > -               return false;
> > +               return in_pf ?
> > +                       /*
> > +                        * Trust that ->huge_fault() handlers know
> > +                        * what they are doing in fault path.
> > +                        */
> > +                       !!vma->vm_ops->huge_fault :
> > +                       /* Only regular file is valid in collapse path =
*/
> > +                       file_thp_enabled(vma);

This works for fault and collapse paths, but what about smaps? I think
we should be doing both checks, and returning "true" if either is
true. This also raises the question of how hugepage_vma_check() is set
up, and how we've been using "in_pf" and "smaps". Today, these mean,
"am I in fault path?" and "am I in smaps path?", whereas I think they
ought to be, "should I check fault path, else check collapse path",
and "am I in smaps path?". smaps path should then use
hugepage_vma_check(in_pf) || hugepage_vma_check(!in_pf). It a depends
on how pedantic we want to be about THPeligible, but I've found a few
corner cases where the distinction matters.

What I think I'll do is send off an embarrassing 3rd revision of this
simple patch -- removing Patch 2 that was previously included in v2 --
just so we have a shot of getting the fix for Saurabh into 6.6. We can
worry about any other refactorings / fixes later..

Thanks,
Zach


> >         if (vma_is_temporary_stack(vma))
> >                 return false;
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
