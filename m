Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAB7F11C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjKTLTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjKTLTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:19:07 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32557CA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:17:45 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c88750e7d1so2560361fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700479063; x=1701083863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlAzsIeNdJrrb0PCgVXBwtQkX4AXQb5hB3gxR/EMw3M=;
        b=ZaPA/nPp4qE7iQaLfkgxZCixN7xBwiEZbL+iniiLjmmRymsP35FRb9JOhr8ovrIRph
         LBD7dov7E3Uuy+OZKsUq6WUErfjgb8Tsvxet9W/tu828FlvA3JOjFgE/lm0SR3xuQdJe
         e7jX1/XS/SyZ/Bp/xl7eFGxuWJF6cddLtJq+RNegC69b2QsSDnlvVk4yQy/jFTc9/CkJ
         cV/Gv5YOu4eieOPBybvWkwTwID29lC1zVa4dL88jabOq+BdnX8xfCzNz0wGanz2gXPST
         9DQcH+2GgSz4gYpd1GZQY4PtqaOsQNUybRm5aHZYMQp1urMkpdO+ajadd35OfkR1gESl
         jUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479063; x=1701083863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlAzsIeNdJrrb0PCgVXBwtQkX4AXQb5hB3gxR/EMw3M=;
        b=LkiDlrBG3D2D9TMPR0phxZUw8hUs4/0faSb7UXKC1Jr8YPUX6KMQ3dxG3F3/b+q6uX
         bb7Xi2tiYo7L0+0we6E4jZjw2d0rCQeJOX1gj6hAdwz/ODUsSPVywdh4Gk1XopfU/mI6
         wJNR6R6M1+pBQ7EMfefust+9adWpZSdWM/Vx7wKwB+x0IKmN+7bZ/golVNbpTLDSytED
         vI7Cm+93bGErZzILSHio6W9g1sPxI6j1vWLB0Ue6NapPsT33QV0wDVk7GVq2C5pEZTFk
         havjAy/UpAtWcimclVURymLbpieJ3G8wJUX2JOBZZEVZBsY4QBtMJoh0r1mjEoF/QSfN
         mVIw==
X-Gm-Message-State: AOJu0Yz7J8PsjTmWblFO4pD0Zzr+mNasl/PQgjqYG5iltTMoH0ZtSGNg
        qywSC2YZ0+u64gAxqDWyBLzrFh6OzpIzlpURnf+dQEAJoJMdVA==
X-Google-Smtp-Source: AGHT+IGROfOVRQGMAWNU064ZJvUcxyA8rNdh/U5bUHgKrIdtR5uJKxgBEdgG1lmgfUYHqP6WcQmWUL3CwfpOdnAodo0=
X-Received: by 2002:a2e:9008:0:b0:2c8:7176:1727 with SMTP id
 h8-20020a2e9008000000b002c871761727mr4568048ljg.5.1700479062869; Mon, 20 Nov
 2023 03:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-20-ryncsn@gmail.com>
 <CAF8kJuMJMBjn2VGq8aUzv_t4+k0zPW8WvJaraYe-8GRbX0q1fg@mail.gmail.com>
In-Reply-To: <CAF8kJuMJMBjn2VGq8aUzv_t4+k0zPW8WvJaraYe-8GRbX0q1fg@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Mon, 20 Nov 2023 19:17:24 +0800
Message-ID: <CAMgjq7DCq1mXwKW8o2nyqb2VA0RV0LP1L9D6to48Qww8VRkAOw@mail.gmail.com>
Subject: Re: [PATCH 19/24] shmem, swap: refactor error check on OOM or race
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

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=80 15:12=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kairui,
>
> On Sun, Nov 19, 2023 at 11:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > It should always check if a swap entry is already swaped in on error,
> > fix potential false error issue.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/shmem.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 81d129aa66d1..6154b5b68b8f 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1857,13 +1857,11 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> >         page =3D swapin_page_non_fault(swap, gfp, mpol, ilx, fault_mm, =
&result);
> >         mpol_cond_put(mpol);
> >
> > -       if (PTR_ERR(page) =3D=3D -EBUSY) {
> > -               if (!shmem_confirm_swap(mapping, index, swap))
> > -                       return -EEXIST;
>
> Do you intentionally remove checking shmem_confirm_swap()?
> I am not sure I am following.

Hi, Chris, thanks for the review.

This was also called under failed: label so I think there is no need
to keep it here.

>
> > +       if (IS_ERR_OR_NULL(page)) {
> > +               if (!page)
> > +                       error =3D -ENOMEM;
> >                 else
> > -                       return -EINVAL;
> > -       } else if (!page) {
> > -               error =3D -ENOMEM;
> > +                       error =3D -EINVAL;
>
> The resulting code is a bit hard to read in diff. In plan source it is li=
ke:
>
>         if (IS_ERR_OR_NULL(page)) {
>                 if (!page)
>                         error =3D -ENOMEM;
>                 else
>                         error =3D -EINVAL;
>                 goto failed;
>         } else {
>                 folio =3D page_folio(page);
>                 if (fault_type && result !=3D SWAP_CACHE_HIT) {
>                         *fault_type |=3D VM_FAULT_MAJOR;
>                         count_vm_event(PGMAJFAULT);
>                         count_memcg_event_mm(fault_mm, PGMAJFAULT);
>                 }
>         }
>
> First of all, if the first always "goto failed", the second else is not n=
eeded.
> The whole else block can be flatten one indentation.

Yes, thanks for the suggestion.

>
>  if (IS_ERR_OR_NULL(page)) {
>                 if (!page)
>                         error =3D -ENOMEM;
>                 else
>                         error =3D -EINVAL;
>                 goto failed;
>   } else {
>
> Can be rewrite as following with less indentation:
>
> if (!page) {
>      error =3D -ENOMEM;
>      goto failed;
> }
> if (IS_ERR(page)) {
>      error =3D -EINVAL;
>      goto failed;
> }
> /* else block */
>
> Am I missing something and misreading your code?

Your code looks cleaner :)

This patch is trying to clean up the error path after the helper
refactor, and your suggestions are very helpful, thanks!

>
> Chris
