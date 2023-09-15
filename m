Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C87A2B11
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbjIOXnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 19:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbjIOXmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:42:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6B12105
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 16:42:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26f4bc74131so1953594a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694821350; x=1695426150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvSLgTTIgHIGD+l7tl19R4elC30zzIy17VfAeigIAQE=;
        b=O+vCxHPnFbw4lwwd/iT7keN8p8lJMYK8QK9z6u8vYIxH+D8qyOdZlI8Nc6xXhA1Nw+
         mmDlK5jDy++a3/XIkvEQqH1NpBX7xwbPiaJV3YdNfPXWUaZ4UyycyL/Fv2wrJ8vhhA4c
         rAj2FYfWYUzwE083ZpkTDIlCdc/taLfgFOfvKqgiAoZqh5aAikz9d1MSZmbfTZIpGIT8
         KrqjI1q4H2plIIdCDmaOl990f+jaHDIIjCtcgRl9pErkGc4NKA10dKlX74dcR5MQ4ktD
         4oFb+yhQscMx+/BXnKPplF9SR6TDjlcbvC8fkomrWM3J89A6jnjnvMSKF3/9/lTPiU9u
         caOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694821350; x=1695426150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvSLgTTIgHIGD+l7tl19R4elC30zzIy17VfAeigIAQE=;
        b=FfPn1CqC2ipqQvT/PTQfQv8T/NQqoQMllViUmg/PvBe54yeyy7Bwc2ILEFf80f+dHB
         q8AdDPzhBulo6SvTONzD7TIx8ZiiwnlAJM37I2nib5KL9qndyZy2rng522BQrJu5zVNs
         QjogFS6w7FqzqjccHcccK1IFBSPgxTDUgEVRxLNz1jkNxLcI4hOpSsQcLssqqtmNw/ZC
         CmQDlJyx6L/rcNUVQCzOhoz3UYTezPH0nuRp00Wb/oxiy09fKP76tnuS0m7fWjGc0Eo/
         0q6H3ibXkj0+SrMANgwb0YKhDKd+goqZtMkz8lKWcz1RB1H9yvTUzqtC1jWAhh0bPQiU
         ARzA==
X-Gm-Message-State: AOJu0YwMNVGysy98n4ljSPYUSZrbtCDoFoQsaArau2IrcXlUY48oxt0x
        INtsm9l0b2yduacrccNoaeUhxNALYFCYa4EQ+xU=
X-Google-Smtp-Source: AGHT+IHziJa53jxs/XUXF4tHjfe9Bu1xfg0fT9TSx83rjnJPL7ddsasQ91PExTWxXIx5RQn+yT/uPOeSlQY9Cc9pFL0=
X-Received: by 2002:a17:90b:34a:b0:274:8951:b5ed with SMTP id
 fh10-20020a17090b034a00b002748951b5edmr3968062pjb.20.1694821350468; Fri, 15
 Sep 2023 16:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <2a161c99c47a45f8e9f7a21a732c60f0cd674a66.1694625260.git.andreyknvl@google.com>
 <CANpmjNMfpgE0J4e-nk7d0LQi2msX9KcMwK-j37BPuvnPhKPYKg@mail.gmail.com>
In-Reply-To: <CANpmjNMfpgE0J4e-nk7d0LQi2msX9KcMwK-j37BPuvnPhKPYKg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 16 Sep 2023 01:42:19 +0200
Message-ID: <CA+fCnZfGqpCO_4rhKDaQJBD-LSB7vJmD6vMgp-ri=xeg5+acEA@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] lib/stackdepot, kasan: add flags to
 __stack_depot_save and rename
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
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

On Fri, Sep 15, 2023 at 10:32=E2=80=AFPM Marco Elver <elver@google.com> wro=
te:
> > +depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
> > +                                           unsigned int nr_entries,
> > +                                           gfp_t alloc_flags,
> > +                                           depot_flags_t depot_flags)
> >  {
> >         struct list_head *bucket;
> >         struct stack_record *found =3D NULL;
> >         depot_stack_handle_t handle =3D 0;
> >         struct page *page =3D NULL;
> >         void *prealloc =3D NULL;
> > +       bool can_alloc =3D depot_flags & STACK_DEPOT_FLAG_CAN_ALLOC;
> >         bool need_alloc =3D false;
> >         unsigned long flags;
> >         u32 hash;
> >
> > +       if (depot_flags & ~STACK_DEPOT_FLAGS_MASK)
> > +               return 0;
> > +
>
> Shouldn't this be a WARN due to invalid flags?

Good idea! Will fix. Thanks!
