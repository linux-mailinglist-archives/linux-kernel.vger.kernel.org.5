Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF27F65F6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjKWSGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjKWSGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:06:21 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADFCD5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:06:28 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so743320a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700762788; x=1701367588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOe1NePRnmjI5/xj2NE8BgAqPHEuVYA8qvj9b+OSxE4=;
        b=QvwX3O6GO/POlaq+PTSspRHagA1Qq80kfpBEEgyGrBiJqhp876TuaP1tcIwex4I73w
         RjTTkei6mNrD9fw7KZtlMaZCzQ0XiFC9tG68rJE/93kEkhl7AgGIjc0yDyENQimMmHHH
         QIVBoMAUwGcSEZnQGQPu5dbkYHevljKAD8SOv8XrUfrK32Ix4Jy7BjP8a6Wrp+8xdX5T
         e7OA4hbKUnrXVJWeuAB1c6vxk41V/a8e3AG9RJJu0BDddi02lJKwxQ/37nu0ehkSD0/V
         XaaV+M8JOWnJGwQUjadTTS9wWnG4aNK+Vt+lwNH847MJhw96FMI10qbn6mgZB7ZPPRB2
         uXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762788; x=1701367588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOe1NePRnmjI5/xj2NE8BgAqPHEuVYA8qvj9b+OSxE4=;
        b=oNSzM2zg1aJmTuh1mEzegRi8N8lAdbJRrgBMPWp86Vpec9XXfBURyoaCOIPsit9eMt
         agSrPtpVnQKUVpmFE5HO22bdOAJWUYs3X7I9RHiVkjxIdJw3kwmey14oKV9/E0dTleyx
         KAYcqy+GIIHh7PyRK3wBjmbznpwyifqpwDONlgq/5WJHN+1u/vOAF1RZk2Y++27FtmTw
         yOAe9fVWJ8joG3/LAtQCe9uWZNow7zSK2blvGn/ZQxVwOiXWaYLcs81CIj2+yYWMRFQm
         6AU5Lf+bzXZFl4L9tIbu7R55S2frw3I1Rqbq0RUyLirScucd2ZbRQ6GY+7ri1Mh06sBx
         9rNQ==
X-Gm-Message-State: AOJu0YxWuUbCNGbcEXXYbLG/Rzw7BkuLYXKjqRYu2f+WFW/Fm1XADWam
        m0rfXdsFQOK0eVMtnFlsckrhvgQA/fLeEbrj4Sw=
X-Google-Smtp-Source: AGHT+IH2Pl70LHZpU8DuzcnGuR/bAKdUJiC1DPEm78lHJpvMtLkeUujE9tRpV4upVgM8fa4Mn/iiyks41B6H6pBWrAA=
X-Received: by 2002:a17:90b:3a8d:b0:280:1a19:6dd5 with SMTP id
 om13-20020a17090b3a8d00b002801a196dd5mr162675pjb.36.1700762787678; Thu, 23
 Nov 2023 10:06:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699297309.git.andreyknvl@google.com> <9752c5fc4763e7533a44a7c9368f056c47b52f34.1699297309.git.andreyknvl@google.com>
 <ZV44eczk0L_ihkwi@elver.google.com>
In-Reply-To: <ZV44eczk0L_ihkwi@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 23 Nov 2023 19:06:16 +0100
Message-ID: <CA+fCnZft0Nkc2RrKofi-0a0Yq9gX0Fw5Z+ubBfQy+dVYbWuPuQ@mail.gmail.com>
Subject: Re: [PATCH RFC 14/20] mempool: introduce mempool_use_prealloc_only
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Wed, Nov 22, 2023 at 6:21=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Mon, Nov 06, 2023 at 09:10PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Introduce a new mempool_use_prealloc_only API that tells the mempool to
> > only use the elements preallocated during the mempool's creation and to
> > not attempt allocating new ones.
> >
> > This API is required to test the KASAN poisoning/unpoisoning functinali=
ty
> > in KASAN tests, but it might be also useful on its own.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  include/linux/mempool.h |  2 ++
> >  mm/mempool.c            | 27 ++++++++++++++++++++++++---
> >  2 files changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/mempool.h b/include/linux/mempool.h
> > index 4aae6c06c5f2..822adf1e7567 100644
> > --- a/include/linux/mempool.h
> > +++ b/include/linux/mempool.h
> > @@ -18,6 +18,7 @@ typedef struct mempool_s {
> >       int min_nr;             /* nr of elements at *elements */
> >       int curr_nr;            /* Current nr of elements at *elements */
> >       void **elements;
> > +     bool use_prealloc_only; /* Use only preallocated elements */
>
> This increases the struct size from 56 to 64 bytes (64 bit arch).
> mempool_t is embedded in lots of other larger structs, and this may
> result in some unwanted bloat.
>
> Is there a way to achieve the same thing without adding a new bool to
> the mempool struct?

We could split out the part of mempool_alloc that uses preallocated
elements without what waiting part and expose it in another API
function named something like mempool_alloc_preallocated. Would that
be better?
