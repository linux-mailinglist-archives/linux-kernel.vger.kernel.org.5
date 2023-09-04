Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86661791D67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjIDStB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjIDSs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:48:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3925DCC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:48:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2680eee423aso784680a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693853335; x=1694458135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHkLed3ShSa5G4ls8XODIWF8XE/UOVeInJKV4+j5nGY=;
        b=TagZoS2OjJy7g+bT8ZnCuaJy4/iclVfKpWhmsxhW0Gb25dm1zClgwZ1a/raNjfF8MY
         W5W2Ey5lW9nc45J6TLShE2uedOB7g/+FOHEchYTlU1oVnyn1bHl+YZHy6ItM+xTElKZE
         t7SnQk9iTIQX1C9f0MmHVDcExXJQQKTG4a76io3GnqelVZIrLQaqxmamB+aPlFrbA+CH
         meKg0Mwgeflks3NScxTzYCAYyn8w68i3j5VSXuo1gsotxD40tVjHxZkFCW893L80RpIu
         OQPxHFegez+YkYG+h8g9jYEQvWU0q0Y0lGCORSWqWOZdEV1cSbPZJ4iPUsh4ya/0nVOD
         7OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693853336; x=1694458136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHkLed3ShSa5G4ls8XODIWF8XE/UOVeInJKV4+j5nGY=;
        b=ap83kDjah9dLO6rFxyhELcwfTKyOC9oBivotsyo8kH/7h/sBLU2JjLExpcBKRjh6yu
         BKGcZRV1X3Bc+PYYtQCbSXPNejYsqRVFp0LLUNR8GGW4IcKN2gJMme2zx+vXy0ZvSa9g
         nEojdrQYQPRUAGTjgZFjibP2G1FeqK6ajtUFIJ2+Pz8Zn07KbWm3ay7IQ5dvssQV10yV
         Xy9B3wJhvEXNVeM/U9bNHE8W5SvJjQltk3tA44UrXtYVEOBW7yKHvdzl8hD1KwiyZQjV
         yXecRW+xqD/WaMQ/6nYPIYm6jYtlEsdINaKicOKuzMZVftacSHUTDcYA7O/9Hd3aVNNP
         aRRA==
X-Gm-Message-State: AOJu0Yz2IERUnLE+m4U7L/zF/qtLSzPgf9nmMm0pGu5I8qrUoEybXDmU
        ygzmCUxB3xDucp2fdHAsoL+IL5vYn61vTy2NlxzY7bBw
X-Google-Smtp-Source: AGHT+IGF0ruB4y6Ivcx06qnSn544y5TwQFt/dfCx2tcf9FwoOKXDL8nDuD3aAdIGwqkV4zdkaYHt3EfH0WvizHMBs0w=
X-Received: by 2002:a17:90a:f00b:b0:26f:d6f4:9646 with SMTP id
 bt11-20020a17090af00b00b0026fd6f49646mr7159222pjb.40.1693853335614; Mon, 04
 Sep 2023 11:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <f7ab7ad4013669f25808bb0e39b3613b98189063.1693328501.git.andreyknvl@google.com>
 <ZO8OACjoGtRuy1Rm@elver.google.com>
In-Reply-To: <ZO8OACjoGtRuy1Rm@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 4 Sep 2023 20:48:44 +0200
Message-ID: <CA+fCnZcAuipLKDiNY6LJAs6ODaOG9i6goVLQSdbALrzUDsnv5w@mail.gmail.com>
Subject: Re: [PATCH 15/15] kasan: use stack_depot_evict for tag-based modes
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

On Wed, Aug 30, 2023 at 11:38=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> > --- a/mm/kasan/tags.c
> > +++ b/mm/kasan/tags.c
> > @@ -96,7 +96,7 @@ static void save_stack_info(struct kmem_cache *cache,=
 void *object,
> >                       gfp_t gfp_flags, bool is_free)
> >  {
> >       unsigned long flags;
> > -     depot_stack_handle_t stack;
> > +     depot_stack_handle_t stack, old_stack;
> >       u64 pos;
> >       struct kasan_stack_ring_entry *entry;
> >       void *old_ptr;
> > @@ -120,6 +120,8 @@ static void save_stack_info(struct kmem_cache *cach=
e, void *object,
> >       if (!try_cmpxchg(&entry->ptr, &old_ptr, STACK_RING_BUSY_PTR))
> >               goto next; /* Busy slot. */
> >
> > +     old_stack =3D READ_ONCE(entry->stack);
>
> Why READ_ONCE? Is it possible that there is a concurrent writer once the
> slot has been "locked" with STACK_RING_BUSY_PTR?
>
> If there is no concurrency, it would be clearer to leave it unmarked and
> add a comment to that effect. (I also think a comment would be good to
> say what the WRITE_ONCE below pair with, because at this point I've
> forgotten.)

Hm, I actually suspect we don't need these READ/WRITE_ONCE to entry
fields at all. This seems to be a leftover from the initial series
when I didn't yet have the rwlock. The rwlock prevents the entries
from being read (in kasan_complete_mode_report_info) while being
written and the try_cmpxchg prevents the same entry from being
rewritten (in the unlikely case of wrapping during writing).

Marco, do you think we can drop these READ/WRITE_ONCE?

Thanks!
