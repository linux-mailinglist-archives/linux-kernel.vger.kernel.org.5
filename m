Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344857BD77B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345697AbjJIJqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbjJIJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:45:59 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CD88F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:45:56 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-65b08bbd8b1so29032226d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696844756; x=1697449556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y350VwO6015lGO7ERBdBbOV3S2AzDXdRMs/XXWO/P3w=;
        b=16YWreNy9aMyICdnKhrSDp3Bdoi1fHnRskPmq54KhqtTuGzcrBjuoBPQ1aSGvjZbr7
         9C27GNKq6SE9yXYmcGbhmSLAWTzO4BGl/hZs2No9vrfEPq+qWmU3Bl+AYKue+wmf7bcQ
         SkFW+6DPTofAbM6BCLD1+WfLRgBFI08tGDu5ZzqFKntWnTf6HnmvRPBpXvKBJ6UODygW
         H9GMWJca0TvNI5iyrWob43yXCdcQ2hTxqToGWjv+eacZYIaGSVckqE3/2ff7kuXMZPjE
         aCkNNf3iimyEu+2yh7GLGo6TkenDF+BOvq/5t7Fxr4tjE1PUCmn0r335LbMTxGpzo1m9
         KTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696844756; x=1697449556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y350VwO6015lGO7ERBdBbOV3S2AzDXdRMs/XXWO/P3w=;
        b=mJw2L4oK+OI9DQXLe4ygLf+OYBqGmNqt6nRQXAVqlzE7Dgetf1+gZN3nELIbUvdVFb
         jMuw7rtfa1gxu/+uQgh1pLQd2VLO/LRtfMfoqB7nyItciShD5qxqEvEMprTwscZSCMq+
         cg9vKtJ5gHpBplP+qTrkB3McT6JhU9Ek8XXC2nZ0CWcbAkmeHByMdt1Py3FPl+uO9GLp
         EsP/GYxcIBWyz+WuqiPeWGNfTtdCz75NZRgGDGMbXLMlO+pCoV5KTPMB3d6rY26cFyFl
         9+b0udosU4td6Ljc7FA1U5ECUr5QaTlF+5bmpMssRzEbImgCpwTFjf1jItV/qPuh9nCH
         3CmA==
X-Gm-Message-State: AOJu0YwZ2Ru9hRj/jx0X4oEk1ymCOaqEKmRNPLm6S9Hj9ysi5Wd7qhIu
        6PN6F3DrFPMmJAmq2H/QOFbMFpmSpxSijD2O+sIcyQ==
X-Google-Smtp-Source: AGHT+IG4QwTOaXmfQuuDncJC4R3XFNA73CgEYP7+INF5jvwiHov6qqKlmNdOP31YsGcbP1khrk2f7OBVjVJhB5+zGjI=
X-Received: by 2002:a05:6214:3d0d:b0:651:69d7:3d6a with SMTP id
 ol13-20020a0562143d0d00b0065169d73d6amr16569724qvb.15.1696844755772; Mon, 09
 Oct 2023 02:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <5c5eca8a53ea53352794de57c87440ec509c9bbc.1694625260.git.andreyknvl@google.com>
In-Reply-To: <5c5eca8a53ea53352794de57c87440ec509c9bbc.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 11:45:19 +0200
Message-ID: <CAG_fn=VBAN+JPtqRRacd69DOK9rZ-RMpzn+QDJTsZgQ68sOS=Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/19] lib/stackdepot: use read/write lock
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 7:16=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Currently, stack depot uses the following locking scheme:
>
> 1. Lock-free accesses when looking up a stack record, which allows to
>    have multiple users to look up records in parallel;
> 2. Spinlock for protecting the stack depot pools and the hash table
>    when adding a new record.
>
> For implementing the eviction of stack traces from stack depot, the
> lock-free approach is not going to work anymore, as we will need to be
> able to also remove records from the hash table.
>
> Convert the spinlock into a read/write lock, and drop the atomic accesses=
,
> as they are no longer required.
>
> Looking up stack traces is now protected by the read lock and adding new
> records - by the write lock. One of the following patches will add a new
> function for evicting stack records, which will be protected by the write
> lock as well.
>
> With this change, multiple users can still look up records in parallel.
>
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Alexander Potapenko <glider@google.com>
(but see the comment below)

>  static struct stack_record *depot_fetch_stack(depot_stack_handle_t handl=
e)
>  {
>         union handle_parts parts =3D { .handle =3D handle };
> -       /*
> -        * READ_ONCE pairs with potential concurrent write in
> -        * depot_init_pool.
> -        */
> -       int pools_num_cached =3D READ_ONCE(pools_num);
>         void *pool;
>         size_t offset =3D parts.offset << DEPOT_STACK_ALIGN;
>         struct stack_record *stack;
>
> -       if (parts.pool_index > pools_num_cached) {
> +       lockdep_assert_held(&pool_rwlock);

Shouldn't it be lockdep_assert_held_read()?
