Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DF791D74
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbjIDS7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbjIDS7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:59:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86981109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:59:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so16732745e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693853967; x=1694458767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDbiLlEqmBfltBmTsCoRx2b9yjBtdlH6iWz3M1Lt5wc=;
        b=UsacGrYwpzfvG2zkN3iCDcReyHgmqZk0Xa6lI75Ewve+G/UCWqNdfr7vyCKIA6N3pL
         3xKwfnIniiKHYvxUTPX2K2n0WjnM3skwcd16WASci6Mqcnd/kZqRjSb/wRfGTKh95eA8
         621Y31CKPG0s8190HKIAa/B3NIUqkAtwXlCxJgMjG9FxQqJOncJ7O8QctflmRTQ5Ceom
         ejfzdtT9ZVPqSeABsqDqObvemAjegw+CCp07DJFs87Yx+8LD2MrcNPTDtwyYQNsvnOe2
         TiVIDzXAE+tF9MEkAShk+BL8xnbjdRpeB8xPzdg8cWqgupnTA2ZjvrypqmB2X0stCo0Z
         UYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693853967; x=1694458767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDbiLlEqmBfltBmTsCoRx2b9yjBtdlH6iWz3M1Lt5wc=;
        b=YBKgP7R9zBGt2afZXFmjzBgTbtHCKEYtbN2hlf7f6+eaoMDilLvnKHzFD1d4BhHgeQ
         eKcCJVTYuizFOzs7HPOVP9pMDiEAhOtosk6/HOCXHL5Nz+gkNJbYMBE+47RDkEjKRsBu
         GYSnlcBkTkiISEpUGcRQPd6Rur4rVIOV055+lxjSE4n5WvXxJDbxE6IPvMqjmRQzX+UC
         eGKljcTkT1hip8FDoH6ecsNEG49yytgBqt0nHyKJmL9iHNDtkDAfVnAv3otfkFQkmnr9
         mBQEFKYQxJvsyZoMNxxIxXVTBly1E8RHR7AYZUm+RtIqrn3kUOlbUjs80EvbqPmxpSNj
         caJQ==
X-Gm-Message-State: AOJu0YzJc7xPPOnWIRIXXxwRs7LZTOxceJiWvX/nomokPsl0fb1Ed5RK
        pc44P8leuEP6GrqxDLUTUvlJz9aUf+QR0t6WCC011g==
X-Google-Smtp-Source: AGHT+IHOsC3Af4FNjKO9QGMexCyA+QCLKl7uog8SZuiwiBIkzWUkqdvWTyJBAuXaxokuy1BJ3nGY6bHsOOQBsnoybKI=
X-Received: by 2002:a7b:ce18:0:b0:3fb:f0ef:4669 with SMTP id
 m24-20020a7bce18000000b003fbf0ef4669mr8247988wmc.17.1693853966862; Mon, 04
 Sep 2023 11:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <f7ab7ad4013669f25808bb0e39b3613b98189063.1693328501.git.andreyknvl@google.com>
 <ZO8OACjoGtRuy1Rm@elver.google.com> <CA+fCnZcAuipLKDiNY6LJAs6ODaOG9i6goVLQSdbALrzUDsnv5w@mail.gmail.com>
In-Reply-To: <CA+fCnZcAuipLKDiNY6LJAs6ODaOG9i6goVLQSdbALrzUDsnv5w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 4 Sep 2023 20:58:50 +0200
Message-ID: <CANpmjNPVu10Y+gO=r3eaU9GP8VL_dqmch3QQXYX8g9D-+HjVPg@mail.gmail.com>
Subject: Re: [PATCH 15/15] kasan: use stack_depot_evict for tag-based modes
To:     Andrey Konovalov <andreyknvl@gmail.com>
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

On Mon, 4 Sept 2023 at 20:48, Andrey Konovalov <andreyknvl@gmail.com> wrote=
:
>
> On Wed, Aug 30, 2023 at 11:38=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> >
> > > --- a/mm/kasan/tags.c
> > > +++ b/mm/kasan/tags.c
> > > @@ -96,7 +96,7 @@ static void save_stack_info(struct kmem_cache *cach=
e, void *object,
> > >                       gfp_t gfp_flags, bool is_free)
> > >  {
> > >       unsigned long flags;
> > > -     depot_stack_handle_t stack;
> > > +     depot_stack_handle_t stack, old_stack;
> > >       u64 pos;
> > >       struct kasan_stack_ring_entry *entry;
> > >       void *old_ptr;
> > > @@ -120,6 +120,8 @@ static void save_stack_info(struct kmem_cache *ca=
che, void *object,
> > >       if (!try_cmpxchg(&entry->ptr, &old_ptr, STACK_RING_BUSY_PTR))
> > >               goto next; /* Busy slot. */
> > >
> > > +     old_stack =3D READ_ONCE(entry->stack);
> >
> > Why READ_ONCE? Is it possible that there is a concurrent writer once th=
e
> > slot has been "locked" with STACK_RING_BUSY_PTR?
> >
> > If there is no concurrency, it would be clearer to leave it unmarked an=
d
> > add a comment to that effect. (I also think a comment would be good to
> > say what the WRITE_ONCE below pair with, because at this point I've
> > forgotten.)
>
> Hm, I actually suspect we don't need these READ/WRITE_ONCE to entry
> fields at all. This seems to be a leftover from the initial series
> when I didn't yet have the rwlock. The rwlock prevents the entries
> from being read (in kasan_complete_mode_report_info) while being
> written and the try_cmpxchg prevents the same entry from being
> rewritten (in the unlikely case of wrapping during writing).
>
> Marco, do you think we can drop these READ/WRITE_ONCE?

Yes, I think they can be dropped.
