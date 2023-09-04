Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857C5791D58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353561AbjIDSqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjIDSqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:46:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AD1CDB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:45:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26d5970cd28so918118a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693853150; x=1694457950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZraNgcOpe7Ut9pr2LDBQ0Wst9d1OxSHG4PF5uMFpp0=;
        b=QtJp45B/JBurQEdV/NCGrSQIKlRSdEeFBJ8zGaCCuTPOZqscof7IBZY40Rtyx4C6ci
         dLvEP9czZJT5jwc8qpUuWhs2lr8zUXlqQ40HiQAmOy+kMTzPbVB0jE+0KCjleA3JDafQ
         dXodJZyzYYiBj9zqreGxf/4v0KwYo79Wh44vbLm6JC/TnZmuNEE4nKoiCHKxgclZrGYm
         oH9ZQkpVz1tLAcstiMN256iv8wNBtcfo+fyJiuddNtsZuMF1fXonktSVeXIMCQ29cgMQ
         C6C379j0I/3cAgjjU7unXZKyisR3jONp5hJPcxdpSceYSkW7Vu6Er2p2gVzAHwX9jiTI
         /dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693853150; x=1694457950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZraNgcOpe7Ut9pr2LDBQ0Wst9d1OxSHG4PF5uMFpp0=;
        b=YGPVUDFPWbaBa/gcrhBQ0SpRxdyl1SWmZZf4SiFF71DeURh+wfaFnS/ERrJRXzXMcB
         q0BMobVWDemzf0fI3dm4rx5kzOFkYrgEjx11P7mr3ZkavP6Ez5rTzHDYGyEwlVnDUoJ+
         7OpfP/fSjpfDQHUStGO/H11TJwCCqkgDf1GIoHqNuHQ0NtsQFpjOj5q0282TMKXa19e1
         JYhJG4hiDLYr73TRklHJwVwFNyvbjydi6mijhYCgwVX8SVjJm0iWLc4jdOYPmq4Me4Nl
         iVD5y4z9ilUVKm1MMWKZbfEiAaunzmUMzFqnzPzn1NTOTaGFWoaV2SA+Uk524b3MR6Am
         DVEw==
X-Gm-Message-State: AOJu0YwsWMu+6JRZYNjOWNorFxiBvXJDIktXzDavigE1MYYACkqi2+aa
        o7j3PFkGxJS1Ztp28Eu+clRpQf1ahXxLXXknhvwikaIo
X-Google-Smtp-Source: AGHT+IEFOgOrP0DsyXjT9jJFbC5jM1AAeRE10sr/JTIJgMwQ4oWyFgF22htl6bFnUV6yTQWnRQ8PAt++hxDrbhf9eeA=
X-Received: by 2002:a17:90a:7e02:b0:26d:2b1d:1982 with SMTP id
 i2-20020a17090a7e0200b0026d2b1d1982mr7353698pjl.24.1693853150181; Mon, 04 Sep
 2023 11:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <8ad8f778b43dab49e4e6214b8d90bed31b75436f.1693328501.git.andreyknvl@google.com>
 <ZO7/CqwhzqulWP7K@elver.google.com>
In-Reply-To: <ZO7/CqwhzqulWP7K@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 4 Sep 2023 20:45:39 +0200
Message-ID: <CA+fCnZdg4p3Lea6HpiKojSgtMEX+V-K+C5FBoGxpfSosDCcH9g@mail.gmail.com>
Subject: Re: [PATCH 06/15] stackdepot: fix and clean-up atomic annotations
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

On Wed, Aug 30, 2023 at 10:34=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index 93191ee70fc3..9ae71e1ef1a7 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -226,10 +226,10 @@ static void depot_init_pool(void **prealloc)
> >       /*
> >        * If the next pool is already initialized or the maximum number =
of
> >        * pools is reached, do not use the preallocated memory.
> > -      * smp_load_acquire() here pairs with smp_store_release() below a=
nd
> > -      * in depot_alloc_stack().
> > +      * READ_ONCE is only used to mark the variable as atomic,
> > +      * there are no concurrent writes.
>
> This doesn't make sense. If there are no concurrent writes, we should
> drop the marking, so that if there are concurrent writes, tools like
> KCSAN can tell us about it if our assumption was wrong.

Makes sense, will do in v2.

> > @@ -425,8 +424,8 @@ depot_stack_handle_t __stack_depot_save(unsigned lo=
ng *entries,
> >        * Check if another stack pool needs to be initialized. If so, al=
locate
> >        * the memory now - we won't be able to do that under the lock.
> >        *
> > -      * The smp_load_acquire() here pairs with smp_store_release() to
> > -      * |next_pool_inited| in depot_alloc_stack() and depot_init_pool(=
).
> > +      * smp_load_acquire pairs with smp_store_release
> > +      * in depot_alloc_stack and depot_init_pool.
>
> Reflow comment to match 80 cols used by comments elsewhere.

Will do in v2.

Thanks!
