Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D67BBC86
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjJFQPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjJFQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:15:38 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5ABA6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:15:37 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65b2463d651so13037016d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696608936; x=1697213736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai1VUkXPsadETq6pOE6a32ZLkIYlGlq9aDxrp9PEvE4=;
        b=Zuk8/iN5s/Ogln3oCXDhGbvD3BLgqrxL4zWLH8a3R3A7VN937n1t4T1ss9tjOQrIGh
         Tcg2atvNfVydPrcujCf7lRciIEhmjorLY8zabpP53nhIQKzuAsXpnw9TZfIRPGKY/wb3
         QVIuktvF1IrHlyhsvm1Nn5Xj1xx3lplhNrxyiJd5USxhj8HZLwLDrPzLeSOZSpFIOc9p
         GMG3qPa+GEVFILyX9n6J7avpy1rUA9t783tLzZOGggCLQQnS5v4iOjUTtwDBKCaeQHWo
         Xkl846HzJtI93qXzpAL48aYGZ86WASTqy7MaV/ek6BbeZAJw0XZ82PkcQXD2d0wHDtyu
         aQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696608936; x=1697213736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ai1VUkXPsadETq6pOE6a32ZLkIYlGlq9aDxrp9PEvE4=;
        b=vFnXndItRSPks9d7/g0C5hyemT5I/oEsP5Ud+rv+ThQAVwTsQEgNsBs/il3/aYlenO
         nJvBOlDDTq3z8Sn0yrw4ivQQ6VkryDBj7EtkMVSu2KJb6lZ6oP+GMvwS57sRtQJbwZQ8
         7mj9MapxosblIym516j/d9Unox9gMSu5kUB4X2t+VkjBGT79NWWUY0ikLO13DGAv12/B
         +dA3p+E3mHr6S5r99gsUEglV39PtJMDh/P2sATZBTRltinuSsKBdinvKji/RXUfE/3YX
         skqi6AiOj+H6nFBim4U5UdQ6rDmkF12A5TM665oCzWYnSUwblFdfOYgKlBMTt3clbAjv
         hNGA==
X-Gm-Message-State: AOJu0YwzeC6rMF+4Bfg6Z2hiSyOIZkeAwK2L4bEsKxayKUypyZObW0xu
        SgtMcv34GtTCbBcJMrn+esfZlkUyBh0F0w/8N32IXw==
X-Google-Smtp-Source: AGHT+IEx1r9T2vcKD7OU3CKGcePtixoTmdCamC4dHynLFAkpHGb+HrzdeTktZR9NJ/zM4r7N4H39UZ7z9KbKRitbBww=
X-Received: by 2002:a05:6214:4285:b0:658:708c:4d56 with SMTP id
 og5-20020a056214428500b00658708c4d56mr8723713qvb.17.1696608936423; Fri, 06
 Oct 2023 09:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <e78360a883edac7bc3c6a351c99a6019beacf264.1694625260.git.andreyknvl@google.com>
In-Reply-To: <e78360a883edac7bc3c6a351c99a6019beacf264.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 6 Oct 2023 18:14:56 +0200
Message-ID: <CAG_fn=UAF2aYD1mFbakNhcYk5yZR6tFeP8R-Yyq0p_7hy9owXA@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] lib/stackdepot: fix and clean-up atomic annotations
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

On Wed, Sep 13, 2023 at 7:15=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Simplify comments accompanying the use of atomic accesses in the
> stack depot code.
>
> Also drop smp_load_acquire from next_pool_required in depot_init_pool,
> as both depot_init_pool and the all smp_store_release's to this variable
> are executed under the stack depot lock.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

(but see below)


>                  * Move on to the next pool.
>                  * WRITE_ONCE pairs with potential concurrent read in
> -                * stack_depot_fetch().
> +                * stack_depot_fetch.

Why are you removing the parentheses here? kernel-doc uses them to
tell functions from non-functions, and having them in non-doc comments
sounds consistent.
