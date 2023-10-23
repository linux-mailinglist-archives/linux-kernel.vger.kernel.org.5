Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E07D3C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjJWQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjJWQRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C617D78
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:16:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d153c7f00so2187399a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698077814; x=1698682614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tHn32Hb+H9q5/wYxwsubEfubdWSQHXuWNQ2b+po3Bg=;
        b=kjB7o6FV+BU5bNjwOyX2O8b/1iO9WEMWc280KsJwCVFw6YIslDsPfXYBlqCfBwOSM6
         Vn9vqos/XynNwQ4/YNXiT/YwGM/BOZXoKClF/KcbGVQiKilmXbtBx37y8HyepqBeqQpP
         ZjTh2Hk32DvjtxIqtveD9B0EjX16xEfQ/peu9W9aKeguQeJ+IbqHFydsqSw4/u5UHM8n
         f8QMBIRzhvWxAETQOsASyVPVUCEsjIKq2kPvAJBMS3/Lz4G1eDa6dJTT3XLoH2SdjopQ
         OrXZXqo8RM/FzSvp4H/4nZhjq8gwZIVsTj1nOI7HWMKLYdf8JBZAcgn/+r6SnXLkEM15
         G0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077814; x=1698682614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tHn32Hb+H9q5/wYxwsubEfubdWSQHXuWNQ2b+po3Bg=;
        b=ZO3YW/nTU4PJr4FVIvgcZsUZNiwRvTg5UYOeX12626uS6ONxLeooPzrqz7nO/K5nLf
         Hu4jPye7KR4VFUVy9bN3/z5MTsMBvJwgCRieXL30r2e9H+gpn/yDUuOW9btyj0oUegdY
         f4jQOJSKn8sRDI93h1EIFO9IUM+bohvVfRkafmJCdAM5CrYM2v0cw66i+Y23nR0yIECl
         cSgySpc8EsBXLEf128zEz0PJO9UlvZQUlMvoMXydbzu+mfJwIhDOyUT3dSSHYDH8uvCq
         wUxFGQPcevYeAqCZVrGaX4xFEr3UW71vpBBhNwa0vuuctONdr6zCpNA03ynzPai0yyBV
         EGMA==
X-Gm-Message-State: AOJu0YwrjLnMSgCiHKQyg6BIyhqOatgtjFWc9C4C7yg8xk1b4t8+QLD8
        gKSaWvziueq7rdMupyeDwON9aGekaZ6ny/msBCw=
X-Google-Smtp-Source: AGHT+IE7NI5AoYX+Q47TXmLtq15KJkt/9rcszVFqGyTG7JZwhgGpYyJtBDC0qFW9+8fElaMW/I7RGKsYlJZlFdIN/BM=
X-Received: by 2002:a17:90a:b903:b0:27d:5504:4cc8 with SMTP id
 p3-20020a17090ab90300b0027d55044cc8mr7495426pjr.9.1698077813463; Mon, 23 Oct
 2023 09:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <5c5eca8a53ea53352794de57c87440ec509c9bbc.1694625260.git.andreyknvl@google.com>
 <CAG_fn=VBAN+JPtqRRacd69DOK9rZ-RMpzn+QDJTsZgQ68sOS=Q@mail.gmail.com>
In-Reply-To: <CAG_fn=VBAN+JPtqRRacd69DOK9rZ-RMpzn+QDJTsZgQ68sOS=Q@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 23 Oct 2023 18:16:42 +0200
Message-ID: <CA+fCnZfDRx6VMSevQKfYYwCj49iqsKMaPaWt95rug-nw8Pgx8w@mail.gmail.com>
Subject: Re: [PATCH v2 11/19] lib/stackdepot: use read/write lock
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
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

On Mon, Oct 9, 2023 at 11:45=E2=80=AFAM Alexander Potapenko <glider@google.=
com> wrote:
>
> >  static struct stack_record *depot_fetch_stack(depot_stack_handle_t han=
dle)
> >  {
> >         union handle_parts parts =3D { .handle =3D handle };
> > -       /*
> > -        * READ_ONCE pairs with potential concurrent write in
> > -        * depot_init_pool.
> > -        */
> > -       int pools_num_cached =3D READ_ONCE(pools_num);
> >         void *pool;
> >         size_t offset =3D parts.offset << DEPOT_STACK_ALIGN;
> >         struct stack_record *stack;
> >
> > -       if (parts.pool_index > pools_num_cached) {
> > +       lockdep_assert_held(&pool_rwlock);
>
> Shouldn't it be lockdep_assert_held_read()?

Indeed, this is more precise. Will fix in v3, thanks!
