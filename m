Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D523E791D5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbjIDSqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241458AbjIDSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:46:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED03CFD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:46:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26d1e5f2c35so1169837a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693853177; x=1694457977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPwa8jzfvAKIRzM093CaFHhTk58/oFuCdDDlLlEVSBw=;
        b=YUD84KBXv2IivI9NlFyFSROdNzdP3a/25BYOBnq98+YBJ31/Z8jQv01cjfJAJxjTCV
         3davQfL5TUG7I51P8ZC0Fdvf5wFhLocZsm5DwcknMHP37gaMOf67EOTKiR3nf2ksgheM
         zGcUqqh88MXZcfrDFwI8cV6fW4M7SFU0IvC30BXjf9JeU7w53XkKwCPpETCy2NYCJ7qT
         D8PEG1BNCwkx1Md9i+pYTV2kN8yBal8OGWEAVxQcbxISNpukRv2cllDlMsg6VkpG2LmW
         GHlEusSFyrpjqDp/eWoTFihWpYw8NzqPicuvXEhLODtVV3qHe6Myy/xc56fsTNHoVWRg
         6iUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693853177; x=1694457977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPwa8jzfvAKIRzM093CaFHhTk58/oFuCdDDlLlEVSBw=;
        b=GuSZPiL7qrrQwZTD1iEth2zpb1VFPCnMRKQpCnZZTUL+SvHX6Y5HpyHgIzlAGrqE/w
         fiSjAxXlLiiDp3vUvvL53NoIAtqmfB8pbVAViSRXP/bhASUlyQKxFdbteSGkQjTA6pER
         mPzYbnxHsyAP+a8+l/eMjU73rMuAKpRQpN/L9Kp/3y6YNfXjF+SJMx0fRSukqO5rKhXL
         BarmfEMEaJjYoKr1TYg7VGwx3UMorTOsb8IdfJlOgoSu5VnD0AJyUFeJXbvJc+ZllS5U
         sxf7Q9O+iwLC797Rhx6GY6JZaM2LwYLj+0frzJTKtMYZ5NrHGt+tDK5NLQCAmIb8MDL8
         Xb2g==
X-Gm-Message-State: AOJu0YytDn8vJADsxUDbmnwAr4Dr6yQBeqNSScWKCSLk7nXxeI1HGy5U
        DUosR9Ox9haLZTOXHcF98fej9qOo9qPCdAzhtEE=
X-Google-Smtp-Source: AGHT+IEikSBJJP1dxY1WJ4P0PY/YwsxJnEhK8ggnWQCjwStB754ZabPYsyu6vtUGQYE/G2z+l7EsZU2urYWGzmAYQ9c=
X-Received: by 2002:a17:90a:38a5:b0:262:fb5d:147b with SMTP id
 x34-20020a17090a38a500b00262fb5d147bmr9835987pjb.19.1693853177173; Mon, 04
 Sep 2023 11:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <6db160185d3bd9b3312da4ccc073adcdac58709e.1693328501.git.andreyknvl@google.com>
 <ZO8IMysDIT7XnN9Z@elver.google.com>
In-Reply-To: <ZO8IMysDIT7XnN9Z@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 4 Sep 2023 20:46:06 +0200
Message-ID: <CA+fCnZdLi3g999PeBWf36Z3RB1ObHyZDR_xS0kwJWm6fNUqSrA@mail.gmail.com>
Subject: Re: [PATCH 11/15] stackdepot: use read/write lock
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:13=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> > -static int new_pool_required =3D 1;
> > +static bool new_pool_required =3D true;
> > +/* Lock that protects the variables above. */
> > +static DEFINE_RWLOCK(pool_rwlock);
>
> Despite this being a rwlock, it'll introduce tons of (cache) contention
> for the common case (stack depot entry exists).
>
> If creating new stack depot entries is only common during "warm-up" and
> then becomes exceedingly rare, I think a percpu-rwsem (read-lock is a
> CPU-local access, but write-locking is expensive) may be preferable.

Good suggestion. I propose that we keep the rwlock for now, and I'll
check whether the performance is better with percpu-rwsem once I get
to implementing and testing the performance changes. I'll also check
whether percpu-rwsem makes sense for stack ring in tag-based KASAN
modes.

> > @@ -262,10 +258,8 @@ static void depot_keep_new_pool(void **prealloc)
> >       /*
> >        * If a new pool is already saved or the maximum number of
> >        * pools is reached, do not use the preallocated memory.
> > -      * READ_ONCE is only used to mark the variable as atomic,
> > -      * there are no concurrent writes.
> >        */
> > -     if (!READ_ONCE(new_pool_required))
> > +     if (!new_pool_required)
>
> In my comment for the other patch I already suggested this change. Maybe
> move it there.

Will do in v2.

>
> >               return;
> >
> >       /*
> > @@ -281,9 +275,8 @@ static void depot_keep_new_pool(void **prealloc)
> >        * At this point, either a new pool is kept or the maximum
> >        * number of pools is reached. In either case, take note that
> >        * keeping another pool is not required.
> > -      * smp_store_release pairs with smp_load_acquire in stack_depot_s=
ave.
> >        */
> > -     smp_store_release(&new_pool_required, 0);
> > +     new_pool_required =3D false;
> >  }
> >
> >  /* Updates refences to the current and the next stack depot pools. */
> > @@ -300,7 +293,7 @@ static bool depot_update_pools(void **prealloc)
> >
> >               /* Take note that we might need a new new_pool. */
> >               if (pools_num < DEPOT_MAX_POOLS)
> > -                     smp_store_release(&new_pool_required, 1);
> > +                     new_pool_required =3D true;
> >
> >               /* Try keeping the preallocated memory for new_pool. */
> >               goto out_keep_prealloc;
> > @@ -369,18 +362,13 @@ depot_alloc_stack(unsigned long *entries, int siz=
e, u32 hash, void **prealloc)
> >  static struct stack_record *depot_fetch_stack(depot_stack_handle_t han=
dle)
> >  {
> >       union handle_parts parts =3D { .handle =3D handle };
> > -     /*
> > -      * READ_ONCE pairs with potential concurrent write in
> > -      * depot_init_pool.
> > -      */
> > -     int pools_num_cached =3D READ_ONCE(pools_num);
> >       void *pool;
> >       size_t offset =3D parts.offset << DEPOT_STACK_ALIGN;
> >       struct stack_record *stack;
>
> I'd add lockdep assertions to check that the lock is held appropriately
> when entering various helper functions that don't actually take the
> lock. Similarly for places that should not have the lock held you could
> assert the lock is not held.

Will do in v2.

Thanks!
