Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF87BD593
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbjJIIqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345520AbjJIIqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:46:19 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B288D10B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:46:17 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b07719089aso2815741241.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696841176; x=1697445976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z2RpbvMTdKoZ2zJiAZ7Z5I3rvjdlk66rFfj4n9j6rj0=;
        b=yPf7GajXw5eWqO+Vv0bkQbvHayGDGg1WKvif8A1srRedjaInPe3G10YcV3cd1xt206
         DRRm+Fbh08s3kMnzo7y1mgDkmJuKTnKckRy4UL8Ml+/Wgv2Xz43cfISW5uWqlEwCQbCl
         gPAa4tG9fbLUNS0JI7FheTguZiZati6DTG/Zf5vZpPTMQQCQTGgDiCntaSfWJ7oM+0jj
         3IBHmlvXk5MBwe0pzTroNvIEfecb2PS8c/kBWYHPoYnhfNuDEs0Q/WqnIEAT97ALYX2J
         sLJNm2OzL5daQkSTdf9fT0t6VmwcuBh4QFu0mGkLi0u1g6lduQJIdUBvNn+SPeihSZVv
         ot5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841176; x=1697445976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2RpbvMTdKoZ2zJiAZ7Z5I3rvjdlk66rFfj4n9j6rj0=;
        b=xAYvJD2vGJTiUjchlozYDRfoSM5uHgemvJsFVm/TCZpwEl/WVcS0xmqVxKaeknIjjv
         amtcM8rOQthr3qTfn9PNS+zBh2qXi8bVvWv9BXbxl65audZfkXBob+XeGsRjYn3rPZ6N
         vBUO6lHSORfBEhv9mtAsJuGAud+XIuUErXRMOBaWsBBLEagtGTkIgn0DwhZZD4el3BcY
         v8uFBv+0zAskcUGMeMLhMW99OmiDI+qVJWJURqPpP40YWKFZD/OaFPkFncmx8DxXztFD
         SxtP1ytHznzOb40HU+bGZsKAozeE47f/0xuIBcWlItOB6APKaDXw5fxl/mMGDZyvwiSa
         sf6A==
X-Gm-Message-State: AOJu0Yxi5ZqQ3MdML0hvEWw67KE3t27tFgiyUmIOvLpmdh7Jj5sFHyey
        XJU8WYptLFYT4FGa0jghWnjQ2BUGtCo1Faj8SdvOlw==
X-Google-Smtp-Source: AGHT+IHJAkG1xfrKUNuQ0TQrvXyaCe7agnEMJzL4WMrcd8MJmGF43xIyigd35G/FEsVM6J9ytZ7zIV7xpP6mYageJm4=
X-Received: by 2002:a1f:6d44:0:b0:494:63f7:4e7f with SMTP id
 i65-20020a1f6d44000000b0049463f74e7fmr6815444vkc.2.1696841176576; Mon, 09 Oct
 2023 01:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696605143.git.andreyknvl@google.com> <6f621966c6f52241b5aaa7220c348be90c075371.1696605143.git.andreyknvl@google.com>
In-Reply-To: <6f621966c6f52241b5aaa7220c348be90c075371.1696605143.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 9 Oct 2023 10:45:40 +0200
Message-ID: <CANpmjNOHPRHOOPNwx04S_CE5OoQMAmfxHjxqeqy=YUpU+sY7yA@mail.gmail.com>
Subject: Re: [PATCH 3/5] kasan: use unchecked __memset internally
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 6 Oct 2023 at 17:18, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> KASAN code is supposed to use the unchecked __memset implementation when
> accessing its metadata.
>
> Change uses of memset to __memset in mm/kasan/.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Do we need a "Fixes" tag?

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/report.c | 4 ++--
>  mm/kasan/shadow.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index ca4b6ff080a6..12557ffee90b 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -538,7 +538,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
>
>         start_report(&flags, true);
>
> -       memset(&info, 0, sizeof(info));
> +       __memset(&info, 0, sizeof(info));
>         info.type = type;
>         info.access_addr = ptr;
>         info.access_size = 0;
> @@ -576,7 +576,7 @@ bool kasan_report(const void *addr, size_t size, bool is_write,
>
>         start_report(&irq_flags, true);
>
> -       memset(&info, 0, sizeof(info));
> +       __memset(&info, 0, sizeof(info));
>         info.type = KASAN_REPORT_ACCESS;
>         info.access_addr = addr;
>         info.access_size = size;
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index dd772f9d0f08..d687f09a7ae3 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -324,7 +324,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>         if (!page)
>                 return -ENOMEM;
>
> -       memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
> +       __memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
>         pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
>
>         spin_lock(&init_mm.page_table_lock);
> --
> 2.25.1
>
