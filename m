Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585267B6E48
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbjJCQVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjJCQVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:21:40 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B308A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:21:36 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59bf1dde73fso13842037b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696350096; x=1696954896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpyVNkJRXjRkFR/rn/ddNmNe1O9yMqnXww/ltlxxeCg=;
        b=DnGtbFwzDUxWK97sGgcMJ+dCXqK+MF3U2LulPeBCMtPnAWPReGHXlqcFBO6Fz+BnR/
         b9mW82cfFvhV3fU02cRQ7FkkYQUzqizKjNdUrs/iCn3AXqSFoH9wfg7+MeyX8x0gOV05
         hZE6ZA3EboMqtIU7mS9+FSREZWinu5U8ENfYjypGafbgPSpzTKZlXNut2yAXQEJuoZW2
         nTJBgrx1t3IBlJ8w4v0lYU8BeFAnMTz2Id6xOQe1jxyn24VRbmZviwPiuY0eCaEBxTl6
         MXVCmpKmO+9UqX7HrOKp4EpiB9TvGagn2EGE1LstU+BDyyG9rpCqr7UuaNnuuTz+LNWP
         t3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350096; x=1696954896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpyVNkJRXjRkFR/rn/ddNmNe1O9yMqnXww/ltlxxeCg=;
        b=Zcr4S5jfpAQ7ziDjRv526iZa+MrNrBUSp1r1blyy7j9Bg1EaYOWJNc88XoLCiBMBWx
         /wtDvNCgZ7U4l32/oDdYy9fNQG2iDlhSeU37XNTzEzgTF42FU6M0NSnC4SdQe5SVE8Rf
         HpSFdPLqzdxJy41jtaFVrAgheNhinKnRFmRBokf5WnwKHpwauPY+dfVPZ5qwwuT8/LvW
         r1oYIEg2xRhyOyFv/iXwgUM7UA8ce0V4oPlAkifChYbjqLfW43S0sW6FgiC66Hhia57Y
         ELmeGPcMD2II/nox+25MSm9Rw1vFC8rpXAagg6U+PO4FW2+2XjvlhdclnUb/sgm4TOBY
         KTnw==
X-Gm-Message-State: AOJu0Ywugo+hmBkuKJ4TWibOjC7yAtIyPbG+YNcClB/CMkPdu1uvqsX/
        SHdd/xr85/Ql5e8mxQ/TRXp9Zf8zpoIACYDWG0qMgQ==
X-Google-Smtp-Source: AGHT+IHLgDM/yoxhM8u9nOe2pHp+nHs4+ebDacp3i5wmm0zfXZH6bnV+yIRQ2mERuQ97Bs+LZ6TAu1lbdrpuwLOysl8=
X-Received: by 2002:a81:5251:0:b0:586:a170:7dbe with SMTP id
 g78-20020a815251000000b00586a1707dbemr111089ywb.13.1696350095583; Tue, 03 Oct
 2023 09:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com> <20230929183041.2835469-3-Liam.Howlett@oracle.com>
In-Reply-To: <20230929183041.2835469-3-Liam.Howlett@oracle.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Oct 2023 09:21:22 -0700
Message-ID: <CAJuCfpFx3zxv1ZgkLh4dkafOCHvL_674cysJiuQPQhKXX9BuzQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
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

On Fri, Sep 29, 2023 at 11:30=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> When the calling function fails after the dup_anon_vma(), the
> duplication of the anon_vma is not being undone.  Add the necessary
> unlink_anon_vma() call to the error paths that are missing them.
>
> This issue showed up during inspection of the error path in vma_merge()
> for an unrelated vma iterator issue.
>
> Users may experience increased memory usage, which may be problematic as
> the failure would likely be caused by a low memory situation.
>
> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> Cc: stable@vger.kernel.org
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index acb7dea49e23..f9f0a5fe4db4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -583,11 +583,12 @@ static inline void vma_complete(struct vma_prepare =
*vp,
>   * dup_anon_vma() - Helper function to duplicate anon_vma
>   * @dst: The destination VMA
>   * @src: The source VMA
> + * @dup: Pointer to the destination VMA when successful.
>   *
>   * Returns: 0 on success.
>   */
>  static inline int dup_anon_vma(struct vm_area_struct *dst,
> -                              struct vm_area_struct *src)
> +               struct vm_area_struct *src, struct vm_area_struct **dup)
>  {
>         /*
>          * Easily overlooked: when mprotect shifts the boundary, make sur=
e the
> @@ -595,9 +596,15 @@ static inline int dup_anon_vma(struct vm_area_struct=
 *dst,
>          * anon pages imported.
>          */
>         if (src->anon_vma && !dst->anon_vma) {
> +               int ret;
> +
>                 vma_assert_write_locked(dst);
>                 dst->anon_vma =3D src->anon_vma;
> -               return anon_vma_clone(dst, src);
> +               ret =3D anon_vma_clone(dst, src);
> +               if (ret)
> +                       return ret;
> +
> +               *dup =3D dst;
>         }
>
>         return 0;
> @@ -624,6 +631,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
>                unsigned long start, unsigned long end, pgoff_t pgoff,
>                struct vm_area_struct *next)
>  {
> +       struct vm_area_struct *anon_dup =3D NULL;
>         bool remove_next =3D false;
>         struct vma_prepare vp;
>
> @@ -633,7 +641,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
>
>                 remove_next =3D true;
>                 vma_start_write(next);
> -               ret =3D dup_anon_vma(vma, next);
> +               ret =3D dup_anon_vma(vma, next, &anon_dup);
>                 if (ret)
>                         return ret;

Shouldn't the above be changed to a "goto nomem" instead of "return ret" ?


>         }
> @@ -661,6 +669,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
>         return 0;
>
>  nomem:
> +       if (anon_dup)
> +               unlink_anon_vmas(anon_dup);
>         return -ENOMEM;
>  }
>
> @@ -860,6 +870,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator =
*vmi, struct mm_struct *mm,
>  {
>         struct vm_area_struct *curr, *next, *res;
>         struct vm_area_struct *vma, *adjust, *remove, *remove2;
> +       struct vm_area_struct *anon_dup =3D NULL;
>         struct vma_prepare vp;
>         pgoff_t vma_pgoff;
>         int err =3D 0;
> @@ -927,18 +938,18 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
>                 vma_start_write(next);
>                 remove =3D next;                          /* case 1 */
>                 vma_end =3D next->vm_end;
> -               err =3D dup_anon_vma(prev, next);
> +               err =3D dup_anon_vma(prev, next, &anon_dup);
>                 if (curr) {                             /* case 6 */
>                         vma_start_write(curr);
>                         remove =3D curr;
>                         remove2 =3D next;
>                         if (!next->anon_vma)
> -                               err =3D dup_anon_vma(prev, curr);
> +                               err =3D dup_anon_vma(prev, curr, &anon_du=
p);
>                 }
>         } else if (merge_prev) {                        /* case 2 */
>                 if (curr) {
>                         vma_start_write(curr);
> -                       err =3D dup_anon_vma(prev, curr);
> +                       err =3D dup_anon_vma(prev, curr, &anon_dup);
>                         if (end =3D=3D curr->vm_end) {      /* case 7 */
>                                 remove =3D curr;
>                         } else {                        /* case 5 */
> @@ -954,7 +965,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator =
*vmi, struct mm_struct *mm,
>                         vma_end =3D addr;
>                         adjust =3D next;
>                         adj_start =3D -(prev->vm_end - addr);
> -                       err =3D dup_anon_vma(next, prev);
> +                       err =3D dup_anon_vma(next, prev, &anon_dup);
>                 } else {
>                         /*
>                          * Note that cases 3 and 8 are the ONLY ones wher=
e prev
> @@ -968,7 +979,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator =
*vmi, struct mm_struct *mm,
>                                 vma_pgoff =3D curr->vm_pgoff;
>                                 vma_start_write(curr);
>                                 remove =3D curr;
> -                               err =3D dup_anon_vma(next, curr);
> +                               err =3D dup_anon_vma(next, curr, &anon_du=
p);
>                         }
>                 }
>         }
> @@ -1018,6 +1029,9 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
>         return res;
>
>  prealloc_fail:
> +       if (anon_dup)
> +               unlink_anon_vmas(anon_dup);

Maybe a stupid question, but why can't we do this unlinking inside
dup_anon_vma() itself when anon_vma_clone() fails? That would
eliminate the need for the out parameter in that function. I suspect
that there is a reason for that which I'm missing.

> +
>  anon_vma_fail:
>         vma_iter_set(vmi, addr);
>         vma_iter_load(vmi);
> --
> 2.40.1
>
