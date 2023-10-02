Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E943E7B5A52
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbjJBSfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjJBSfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:35:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A0AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:34:57 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3af5b5d7f16so56050b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696271697; x=1696876497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYZ0mG+1+QVjGIg5If9O0ArAPvVVYNnY7+gjoXl9mzo=;
        b=fk2pmspdhWuHu2MrckRunBhxps1phBOY5nQfUtldiN+rOsqeiy0aQocWZB0Dx0Azdd
         unFEY38sVk1/Y8yw9dqLCvwzd5S+8/TVDddAK4h1S43NQb9e+zDkd+X8bgf7N6AV0t2S
         Bxa/H4bB7NjCLGYtDWBwktnYebddFBxAViUT8tFjAuiEhBo0boxOxDTv9VT05d64hCr9
         iObGe1zZvHlIxzpXjSDWcPHyviIOJOr1uOOHatu7jBnTgaiAv8tLFLZ1alVDf3It0+uI
         /DueyZtOhhoz6ax/QDrk0AECKgB1hzvgIOadIssYg3gro8gAblF21/YVjc9kkIvHZZq2
         jRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696271697; x=1696876497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYZ0mG+1+QVjGIg5If9O0ArAPvVVYNnY7+gjoXl9mzo=;
        b=P5F1XSzOaPzzeAGrTqb6s3qUyneaDXQQR+JvikF8CgbSl3OotuDOQDAgxSIuAlrik/
         QFSnFGNu9uvAv/uY719LOtuDKu/9Cb17HkQfu1J+PHHFsLYAOsNXzzHFwQpj+b6QeaZL
         5dS/K+jUIl3XIpcXjbkQOqXm3bXgOyfgCECXNUVSX3Z7JLrn3mW6xPelvPYAaKa2Rrbd
         aPu81+KltKlJCiNy0oIdY6KI9NxGYQ1b5fY7OHbXPOwb0wq/uBeyd1k9HCZGBElELoir
         s9v/yFZnltheEUEnyoduJcSuzPxbSceNApE8AgbHDvZ2hXrdXgOsXPVU32tIkjHP6Ii/
         Lc1A==
X-Gm-Message-State: AOJu0Yy+hI89k8Sldc8+8KnVTIpKsLnTqU+mv7GZuaSHvng6ZkMM1Ar4
        NTqUVMEh0x9qyJFXN+RjVSeG8dfew3Daobmubxj+0g==
X-Google-Smtp-Source: AGHT+IFrSNucroAoFPYKzSHS0KRFLI9bSO+V8Flpb1DSqKOAUJFSimWbH4j2jPQlv0ng/oP3xMX7UteRLf895ba4L5o=
X-Received: by 2002:a05:6808:1484:b0:3a4:316c:8eeb with SMTP id
 e4-20020a056808148400b003a4316c8eebmr16210570oiw.40.1696271696596; Mon, 02
 Oct 2023 11:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-hib_zero_bitmap_fix-v1-1-6cfdcb785250@quicinc.com> <CADyq12znHG_VPLVxSe+2ofX-WR1Uha2hu1MhoUAquMnoD_oP0w@mail.gmail.com>
In-Reply-To: <CADyq12znHG_VPLVxSe+2ofX-WR1Uha2hu1MhoUAquMnoD_oP0w@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 2 Oct 2023 14:34:20 -0400
Message-ID: <CADyq12x1wZb0Yt3sXR21pQSagT7tGvFmXTBaoeNXkOjPi5-Rnw@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix a bug in copying the zero bitmap to
 safe pages
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kernel@quicinc.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 1:56=E2=80=AFPM Brian Geffon <bgeffon@google.com> wr=
ote:
>
> On Fri, Sep 29, 2023 at 1:31=E2=80=AFPM Pavankumar Kondeti
> <quic_pkondeti@quicinc.com> wrote:
> >
> > The following crash is observed 100% of the time during resume from
> > the hibernation on a x86 QEMU system.
> >
> > [   12.931887]  ? __die_body+0x1a/0x60
> > [   12.932324]  ? page_fault_oops+0x156/0x420
> > [   12.932824]  ? search_exception_tables+0x37/0x50
> > [   12.933389]  ? fixup_exception+0x21/0x300
> > [   12.933889]  ? exc_page_fault+0x69/0x150
> > [   12.934371]  ? asm_exc_page_fault+0x26/0x30
> > [   12.934869]  ? get_buffer.constprop.0+0xac/0x100
> > [   12.935428]  snapshot_write_next+0x7c/0x9f0
> > [   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
> > [   12.936530]  ? submit_bio_noacct+0x44/0x2c0
> > [   12.937035]  ? hib_submit_io+0xa5/0x110
> > [   12.937501]  load_image+0x83/0x1a0
> > [   12.937919]  swsusp_read+0x17f/0x1d0
> > [   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
> > [   12.938967]  load_image_and_restore+0x45/0xc0
> > [   12.939494]  software_resume+0x13c/0x180
> > [   12.939994]  resume_store+0xa3/0x1d0
> >
> > The commit being fixed introduced a bug in copying the zero bitmap
> > to safe pages. A temporary bitmap is allocated in prepare_image()
> > to make a copy of zero bitmap after the unsafe pages are marked.
> > Freeing this temporary bitmap later results in an inconsistent state
> > of unsafe pages. Since free bit is left as is for this temporary bitmap
> > after free, these pages are treated as unsafe pages when they are
> > allocated again. This results in incorrect calculation of the number
> > of pages pre-allocated for the image.
> >
> > nr_pages =3D (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_u=
nsafe_pages;
> >
> > The allocate_unsafe_pages is estimated to be higher than the actual
> > which results in running short of pages in safe_pages_list. Hence the
> > crash is observed in get_buffer() due to NULL pointer access of
> > safe_pages_list.
>
> After reading through the code, perhaps I'm missing something, I'm not
> sure that this is really fixing the problem.
>
> It seems like the problem would be that memory_bm_create() results in
> calls to get_image_page() w/ safe_needed =3D PG_ANY =3D=3D 0, meaning tha=
t
> get_image_page() will not touch allocated_unsafe_pages and instead
> will mark the page as in use by setting it in the forbidden_pages_map
> and the free_pages_map simultaneously. The problem is that the
> free_pages_map was already populated by the call to mark_unsafe_pages,
> meaning that if we allocated a safe page in get_image_page() we just
> set the free bit when it otherwise should not be set.
>
> When the page is later free'd via the call to memory_bm_free(&tmp,
> PG_UNSAFE_KEEP), it results in calls to free_image_page() w/
> clear_page_nosave =3D PG_UNSAFE_KEEP =3D=3D 0. This means that we do not
> touch the free_pages_map because we don't call
> swsusp_unset_page_free().
>
> With all that being said it seems like the correct way to deal with
> that would be to do:
>    error =3D memory_bm_create(&tmp, GFP_ATOMIC, PG_SAFE);
> Here we know that the pages were not in the free_pages_map initially.
>
> Followed by freeing it as:
>     memory_bm_free(&tmp, PG_UNSAFE_CLEAR);
> And here we know that swsusp_unset_page_free() will be called making
> sure the page is not in the free_pages_map afterwards.
>
> And that should result in an unchanged free_pages_map. Does that make
> sense? Please correct me if I'm misunderstanding something.
>

To restate this another way, if I'm reading it correctly, I think the
outcome is actually nearly the same, the difference is, when
allocating the bitmap before w/ PG_ANY we're setting bits in the
free_page_list which will be unset a few lines later in the call to
mark_unsafe_pages(), and then we won't touch the free_pages_list
during the memory_bm_free() because it's called with PG_UNSAFE_KEEP.

> >
> > Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the imag=
e file")
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > ---
> >  kernel/power/snapshot.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 87e9f7e2bdc0..cb7341a71a21 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -2628,7 +2628,7 @@ static int prepare_image(struct memory_bitmap *ne=
w_bm, struct memory_bitmap *bm,
> >                 struct memory_bitmap *zero_bm)
> >  {
> >         unsigned int nr_pages, nr_highmem;
> > -       struct memory_bitmap tmp;
> > +       struct memory_bitmap tmp_zero_bm;
> >         struct linked_page *lp;
> >         int error;
> >
> > @@ -2636,6 +2636,16 @@ static int prepare_image(struct memory_bitmap *n=
ew_bm, struct memory_bitmap *bm,
> >         free_image_page(buffer, PG_UNSAFE_CLEAR);
> >         buffer =3D NULL;
> >
> > +       /*
> > +        * Allocate a temporary bitmap to create a copy of zero_bm in
> > +        * safe pages. This allocation needs to be done before marking
> > +        * unsafe pages below so that it can be freed without altering
> > +        * the state of unsafe pages.
> > +        */
> > +       error =3D memory_bm_create(&tmp_zero_bm, GFP_ATOMIC, PG_ANY);
> > +       if (error)
> > +               goto Free;
> > +
> >         nr_highmem =3D count_highmem_image_pages(bm);
> >         mark_unsafe_pages(bm);
> >
> > @@ -2646,12 +2656,7 @@ static int prepare_image(struct memory_bitmap *n=
ew_bm, struct memory_bitmap *bm,
> >         duplicate_memory_bitmap(new_bm, bm);
> >         memory_bm_free(bm, PG_UNSAFE_KEEP);
> >
> > -       /* Make a copy of zero_bm so it can be created in safe pages */
> > -       error =3D memory_bm_create(&tmp, GFP_ATOMIC, PG_ANY);
> > -       if (error)
> > -               goto Free;
> > -
> > -       duplicate_memory_bitmap(&tmp, zero_bm);
> > +       duplicate_memory_bitmap(&tmp_zero_bm, zero_bm);
> >         memory_bm_free(zero_bm, PG_UNSAFE_KEEP);
> >
> >         /* Recreate zero_bm in safe pages */
> > @@ -2659,8 +2664,8 @@ static int prepare_image(struct memory_bitmap *ne=
w_bm, struct memory_bitmap *bm,
> >         if (error)
> >                 goto Free;
> >
> > -       duplicate_memory_bitmap(zero_bm, &tmp);
> > -       memory_bm_free(&tmp, PG_UNSAFE_KEEP);
> > +       duplicate_memory_bitmap(zero_bm, &tmp_zero_bm);
> > +       memory_bm_free(&tmp_zero_bm, PG_UNSAFE_KEEP);
> >         /* At this point zero_bm is in safe pages and it can be used fo=
r restoring. */
> >
> >         if (nr_highmem > 0) {
> >
> > ---
> > base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> > change-id: 20230929-hib_zero_bitmap_fix-bc5884eba0ae
> >
> > Best regards,
> > --
> > Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> >
