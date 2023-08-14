Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D775C77C138
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjHNUDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjHNUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:03:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D681702
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:02:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso4835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692043373; x=1692648173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0A/tNfxGPsJHc4cQLFJlQHB84qlu/IxeBmLjoZv9mp8=;
        b=pDTGgMZBUgus0tq4Ys5S7AFUaN/kDow8ur6MSITWWabBDD/ueOxgtf+d9iOoyDr1ka
         oQ4ZSOx4fJDYPnRET4DuD0BVVSBnK0RkIsJG+O208OOpxHoB7E0iFKJmndnWDCGMOzpW
         Q6SIy32E+U1GDJ1LmtFgaiqgZ1wydPmvXX6KGRxXjWLecQ9m1RFO7Voog3qAMm5FlAQr
         Ka7Pdy93jH5oulHxoLLRePVmB/4YwDUi7suQdllLegQZEuxVMGTfVFYIsQ0Xwzvn0H66
         cqTy/+AeEonnf9Aiaitf5ZOcIiosbwRDSCylchdvDjVA/FtR8zaKkmK8aGGfGB/6PKXr
         rRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043373; x=1692648173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0A/tNfxGPsJHc4cQLFJlQHB84qlu/IxeBmLjoZv9mp8=;
        b=mEJUP7NZsj8mIgENc+j4TzVvaTrxHS2/2rtnx0jOC0+Ebb8ApKOInc7tu8+T+4Os2d
         Gg4jmPoenZu7xYx0G2/aDeGm2JBoPSw0PK3+uzXnb5kDrmWx0DWu4RurdS/dZ7LrJ/hs
         F2tYu40y3IKGm2VV7hgaJUISM7oix43OCIy7VrMirD6voEjeIRdrnM0LAGUN1gXz7bLF
         G5GS7ANJww8WSYjx6w6it4wr8+DM3k+rjgF/hyL7zA/7WWN4SWoOJRMYtKeRDRyxvdbk
         P8LrEqJZgKBAjbF11CTjPkMBUmsh1uDkVUEqrotnTXih8buzI+Cusr1Y+aC5zntFvF+D
         B0TA==
X-Gm-Message-State: AOJu0Yyb6wvFWlO6QpKleSuTf0CFCanw2Cp34A3d9xpSJTVmmaaofH10
        0Hsf3CBwBLWap/IqIKC1nDYa1jbHF8xTZ6wA4RUk4Q==
X-Google-Smtp-Source: AGHT+IGGliV1fgsKg3eVDFnlJBREzouQtAzNsHcwegIwfrZDczxidsuUDlItot4A8Z6DwSDMOOl6CsrSRTkgz2FLGoQ=
X-Received: by 2002:a05:600c:286:b0:3f1:6fe9:4a95 with SMTP id
 6-20020a05600c028600b003f16fe94a95mr339090wmk.4.1692043372571; Mon, 14 Aug
 2023 13:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230804152724.3090321-1-surenb@google.com> <20230804152724.3090321-6-surenb@google.com>
 <CAG48ez0XCXoXbSR6dyX7GUQYJKRFKQsHuye5q-PLU3-gR5of5A@mail.gmail.com> <20230814121521.83c2dda21765757d272538b2@linux-foundation.org>
In-Reply-To: <20230814121521.83c2dda21765757d272538b2@linux-foundation.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Aug 2023 22:02:15 +0200
Message-ID: <CAG48ez1U5RW6ZJxc9wK4vo8qMJcQ0t+H8z-h4V_E8dkVAomSAQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mm: always lock new vma before inserting into vma tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        torvalds@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
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

On Mon, Aug 14, 2023 at 9:15=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> On Mon, 14 Aug 2023 16:54:01 +0200 Jann Horn <jannh@google.com> wrote:
>
> > > @@ -403,6 +403,8 @@ static int vma_link(struct mm_struct *mm, struct =
vm_area_struct *vma)
> > >
> > >   vma_iter_store(&vmi, vma);
> > >
> > > + vma_start_write(vma);
> > > +
> > >   if (vma->vm_file) {
> > >  mapping =3D vma->vm_file->f_mapping;
> > >  i_mmap_lock_write(mapping);
> >
> > The "vma_start_write()" has to be ordered before the
> > "vma_iter_store(&vmi, vma)".
>
> Thanks.  This?
>
>
> --- a/mm/mmap.c~mm-always-lock-new-vma-before-inserting-into-vma-tree-fix
> +++ a/mm/mmap.c
> @@ -401,10 +401,10 @@ static int vma_link(struct mm_struct *mm
>         if (vma_iter_prealloc(&vmi, vma))
>                 return -ENOMEM;
>
> -       vma_iter_store(&vmi, vma);
> -
>         vma_start_write(vma);
>
> +       vma_iter_store(&vmi, vma);
> +
>         if (vma->vm_file) {
>                 mapping =3D vma->vm_file->f_mapping;
>                 i_mmap_lock_write(mapping);

Yes, thanks, that looks good.
