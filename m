Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA503792C63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbjIERTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353109AbjIERNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:13:38 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD2E199C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 09:43:36 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-31c73c21113so2265045f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693931836; x=1694536636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6oY7/OBmfJxk+eRddlxtREgaCt+NRSSuVpUhmBP/Wg=;
        b=RaTUMETJKl6CBtQ+/BXpAGCVcQor3tJXbyoT3/aJ34c9lwTn4DfmQiFIo/oYS8w3L6
         cjQYGr47b+c4r+QCUOmFepmbP8+tnw1+Qc9YOFQSo6IOoYu5QpD1IAIP1YyrWlQxXEsU
         F+/8oxoLgkcezMEEBYrBWq7hYZWDt0R6UcjO54SYPGZhrWsbb8vOSJC17VWfxkUonXCB
         3n1dVrVLRC153DuOz3u0uUbBOh7hSu2bJeVCwFrKN2XBwCJTyIZLAYK0JoznFNKfuEMk
         bj8sWlnwYFjDRHBAtvf+HBNggryLeEqOFJVZAzRxBjRu8k5D2Ep89On9KcCAypSkiFdM
         0OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693931836; x=1694536636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6oY7/OBmfJxk+eRddlxtREgaCt+NRSSuVpUhmBP/Wg=;
        b=Y01xDfn3X/Jifyly36KSzJOZLR1Sj0BR1QONG7FnuTnXYpVOpEgC9WP/Wz38Zkox14
         2kbbK5ipckkzx9GvNO7krgHuQImddPdhJ6ps4RiM3DNYKWE4AuBXLAnQz4TyiqoBXqsn
         svMpn1DzIWHUTK7ZAHrLe5imCdL8x933OxEt5V0ZLWlUEpg6rMrwvbDIQm7ycqY/uJx/
         TncdXdiwl2XK1jvg1H9OmE9NtsaQmGXuGJWIZxffs5eBLsgmr6kMbM0MkURC2LSTvtPf
         fqG520h4EwODqnYHZTAVE5xl8of1eJUErBPXPUe+uZNYnqo0VCNQe6shrjoCs8Ea5biB
         TL2w==
X-Gm-Message-State: AOJu0YwmGKAQpAnFPa3JG3SCB82YTLtdE+4IjKIDCiLkF2gJaguITa1M
        j56SyQlcu+Fhsois2V7sF2X5w+Y9V+waCqmT92rjzBN+oLZYpwTLIbQ=
X-Google-Smtp-Source: AGHT+IHgIi5xOb5oO6jm3/TW79RYdN1DcImmHLU2S7XjWjL6nk5B/JcNIzHulmIGY0UX5hVn2L7SCxVCc7KoQy4tvIs=
X-Received: by 2002:a05:600c:128f:b0:3fe:4cbc:c345 with SMTP id
 t15-20020a05600c128f00b003fe4cbcc345mr162850wmd.41.1693930780661; Tue, 05 Sep
 2023 09:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <6db160185d3bd9b3312da4ccc073adcdac58709e.1693328501.git.andreyknvl@google.com>
 <ZO8IMysDIT7XnN9Z@elver.google.com> <CA+fCnZdLi3g999PeBWf36Z3RB1ObHyZDR_xS0kwJWm6fNUqSrA@mail.gmail.com>
In-Reply-To: <CA+fCnZdLi3g999PeBWf36Z3RB1ObHyZDR_xS0kwJWm6fNUqSrA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 Sep 2023 18:19:04 +0200
Message-ID: <CANpmjNNtT1WUpJu_n5x_tA2sL4+utP0a6oGUzqrU5JuEu3mowg@mail.gmail.com>
Subject: Re: [PATCH 11/15] stackdepot: use read/write lock
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Sept 2023 at 20:46, Andrey Konovalov <andreyknvl@gmail.com> wrote=
:
>
> On Wed, Aug 30, 2023 at 11:13=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> >
> > > -static int new_pool_required =3D 1;
> > > +static bool new_pool_required =3D true;
> > > +/* Lock that protects the variables above. */
> > > +static DEFINE_RWLOCK(pool_rwlock);
> >
> > Despite this being a rwlock, it'll introduce tons of (cache) contention
> > for the common case (stack depot entry exists).
> >
> > If creating new stack depot entries is only common during "warm-up" and
> > then becomes exceedingly rare, I think a percpu-rwsem (read-lock is a
> > CPU-local access, but write-locking is expensive) may be preferable.
>
> Good suggestion. I propose that we keep the rwlock for now, and I'll
> check whether the performance is better with percpu-rwsem once I get
> to implementing and testing the performance changes. I'll also check
> whether percpu-rwsem makes sense for stack ring in tag-based KASAN
> modes.

I think it's quite obvious that the percpu-rwsem is better. A simple
experiment is to measure the ratio of stackdepot hits vs misses. If
the ratio is obviously skewed towards hits, then I'd just go with the
percpu-rwsem.

The performance benefit may not be measurable if you use a small system.
