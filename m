Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDB7835FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjHUWxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHUWxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:53:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E56127
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:53:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so30835045ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692658403; x=1693263203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCqfnO9Be/Ab7vuptHUo6uWeUi2p2xjbtI/EZiHxUng=;
        b=jPWb0Gs+6fFujjWIELjliELM3jzG6DXdK7fKUc7wtJ4kO60unkDVztk5aUhZiusU1F
         diNVy1zNpO7XXlh2pDKZ9IHjCbLUUZtR3WghjVjKsJTSkPtByoUBXB/kcrD44kJpn75T
         nmrtOmrAGz4dmDeT+rCH67xTqXYS0GPoRWlC4X5WCHTrzKuqPAZl+/fHMP3z8FMWrHs2
         QmDH5IRFp0kWYUlNpX5n9NzaElwNuAtqioMq34yXmOg8fwJIo9qG6ygvJsgrFPJ+tPwA
         lv5e8lsAkHAZTf7E2U8HI1yhjzGn3ZneGYrnNqzIAP7HgPJlf/LH4oQzHYBGqsPjsS7R
         /MQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692658403; x=1693263203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCqfnO9Be/Ab7vuptHUo6uWeUi2p2xjbtI/EZiHxUng=;
        b=MM34Ab45DIivW/g3uReasVLRhxD9QRTLgY7YPKIDxmhvOLJveJs/mWBRghCeovIDL8
         RV/FjmxBjF5of5BqieFfkCQBgpBcT1FSYDwxz9DsCliUKS4C8mNZboQ95ZXoh6Ort29Y
         AbT48DhoCqqT8D0U84Z9+o5Tcvw7XEzr+9nqc0NRldMXXlXpJr717tUwCaOx7UffHNDt
         YDMW4JRItknAs2FxikGP40FwBl9mKrYJrbIwNzW5GgpXohFl0/vKGytaEtR53BY+zRIP
         w4HaLfY6YScKffe6UyfSy1HL3NSjWyUgAXUgbh8NNWJ/Bud4tsP0F/kQSlgBdA6FB88E
         l7Rg==
X-Gm-Message-State: AOJu0YxUxZ/gHG7Qx+459yiReTvXbsg01H4FtYpGSD0nxIAFsKZCtkkG
        I0g6aE8gawcF5cSx9+Ipz7nxDij2ABl55/O8oME=
X-Google-Smtp-Source: AGHT+IHzIOsbe21+zcESDbwwQACz/iqWoMYJDXNxMd8iJ4rglF5vLBDSW47hCpc2svBr/ec1hFrM3HsXSyqqDHj2w0s=
X-Received: by 2002:a17:90a:df0d:b0:26d:609a:74cd with SMTP id
 gp13-20020a17090adf0d00b0026d609a74cdmr10262519pjb.24.1692658403364; Mon, 21
 Aug 2023 15:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230818211533.2523697-1-zokeefe@google.com>
In-Reply-To: <20230818211533.2523697-1-zokeefe@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 21 Aug 2023 15:53:11 -0700
Message-ID: <CAHbLzkrvAFYHBGz6fZEZYD0vO5bJAT3dJgP5a7-+y+jJ9Fsm+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>
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

On Fri, Aug 18, 2023 at 2:15=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> The 6.0 commits:
>
> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
> commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
>
> merged "can we have THPs in this VMA?" logic that was previously done
> separately by fault-path, khugepaged, and smaps "THPeligible" checks.
>
> During the process, the semantics of the fault path check changed in two
> ways:
>
> 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
> 2) We no longer checked if non-anonymous memory had a vm_ops->huge_fault
>    handler that could satisfy the fault.  Previously, this check had been
>    done in create_huge_pud() and create_huge_pmd() routines, but after
>    the changes, we never reach those routines.
>
> During the review of the above commits, it was determined that in-tree
> users weren't affected by the change; most notably, since the only releva=
nt
> user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
> explicitly approved early in approval logic.  However, there is at least
> one occurrence where an out-of-tree driver that used
> VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was broken.
>
> Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
> any ->huge_fault handler a chance to handle the fault.  Note that we
> don't validate the file mode or mapping alignment, which is consistent
> with the behavior before the aforementioned commits.
>
> Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
> Changed from v1[1]:
>         - [Saurabhi] Allow ->huge_fault handler to handle fault, if it ex=
ists
>
> [1] https://lore.kernel.org/linux-mm/CAAa6QmQw+F=3Do6htOn=3D6ADD6mwvMO=3D=
Ow_67f3ifBv3GpXx9Xg_g@mail.gmail.com/

Thanks, Zach. The patch looks correct to me. You can add
Reviewed-by:Yang Shi <shy828301@gmail.com>.

A further comment below...

>
> ---
>  mm/huge_memory.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index eb3678360b97..cd379b2c077b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -96,11 +96,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma, u=
nsigned long vm_flags,
>                 return in_pf;
>
>         /*
> -        * Special VMA and hugetlb VMA.
> +        * khugepaged special VMA and hugetlb VMA.
>          * Must be checked after dax since some dax mappings may have
>          * VM_MIXEDMAP set.
>          */
> -       if (vm_flags & VM_NO_KHUGEPAGED)
> +       if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))

I'm wondering whether we shall remove VM_MIXEDMAP from
VM_NO_KHUGEPAGED or not if that kind VMAs are huge page applicable for
some usecases. The downside may be some CPU time waste on the
VM_MIXEDMAP area which has PFN instead of struct page, but it should
be ok. Anything else did I miss? Just back from a long vacation, my
brain is still not running in full speed yet.

>                 return false;
>
>         /*
> @@ -128,12 +128,15 @@ bool hugepage_vma_check(struct vm_area_struct *vma,=
 unsigned long vm_flags,
>                                            !hugepage_flags_always())))
>                 return false;
>
> -       /* Only regular file is valid */
> -       if (!in_pf && file_thp_enabled(vma))
> -               return true;
> -
>         if (!vma_is_anonymous(vma))
> -               return false;
> +               return in_pf ?
> +                       /*
> +                        * Trust that ->huge_fault() handlers know
> +                        * what they are doing in fault path.
> +                        */
> +                       !!vma->vm_ops->huge_fault :
> +                       /* Only regular file is valid in collapse path */
> +                       file_thp_enabled(vma);
>
>         if (vma_is_temporary_stack(vma))
>                 return false;
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
