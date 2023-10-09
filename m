Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5B7BD5FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbjJIJAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345584AbjJIJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:00:12 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDBDAB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:00:11 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-65afac36b2cso22898856d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696842010; x=1697446810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8StrU8p4Asv0JzFS3HoyE3rwHET/Hez/P+/rBmMaFtk=;
        b=HR2vepmFD6lJcBqveS3vZOoo7Mf7CD7SZq1owXB+P7rx/9dUymZMIB/LL0rTTvbnBc
         cYEoxXQ080p17y8Axp9P6NnEJvdFs4CvbpYHyGVooV6U2bnSNq2CbfEpEREpeZK/1Vvi
         3j3hCGcEBhWrCwZMX0Hc1MYH4DPb72QBnONgK2IaGvCl02fCE9sYvnbbJAgefZKUOZwF
         ZlMd3X7G6dt7LIQt66OV9wy0K23EqW+yO5eafZbSwKm7tPXVruCh7zNZVLwnQePeg+k4
         A0PHVcS+qnew09ALXAIR/GAE+y92UljQL1BKApZ2K6X0+OQFPT+QqjJwTir6mkddGxUT
         bGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842010; x=1697446810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8StrU8p4Asv0JzFS3HoyE3rwHET/Hez/P+/rBmMaFtk=;
        b=k+V9IPNWGDXuK3hNZT/C753KAMBK/CDHkdm6hXRCCJuWgZxKVqWUdHyfmkArJDB504
         D/pvNCJeKVq8vbvlZhgmDSdyqTX7SEUBuzoGIw8PoQRLnZDx16gxBXrOlfowQmAtnj1/
         Ovn+EhWlKNT/Dfw68OM3rPJZJe6rYyG5iwHZaVlMvuFRtqH4r7GJ+kUY7mlJfrNbnlrr
         /+eE+xUlsRCsptc0A4zjQjU7q+GMjWH/8t+Vjfk41v40vgbnmXPOLi7PRP+549D28une
         pcYsgXar9PkQYXwy6gXOFfceulLsE94hBsYNzIS0RHemfj4dCu91UbQx+qn/57i56S9C
         pJmg==
X-Gm-Message-State: AOJu0Yy8MRLU4Ke/OEJyjM6hkwegWY8AeWPpmQDaYY7eeYeuOY2SU/Lb
        d/opzl7I3G5qS1FVH8fPaYKG+S/JRkJvdeuVfToLfQ==
X-Google-Smtp-Source: AGHT+IEO9YnlbbIOqdKwEE3OmWo5jLqeq552UXapo4KtEfjHfM7n8GwW5EcKPHdmAbvoEv0At44Ln7MPZiLs8ylQ8BI=
X-Received: by 2002:ad4:4450:0:b0:65d:56c:5177 with SMTP id
 l16-20020ad44450000000b0065d056c5177mr13158908qvt.57.1696842010047; Mon, 09
 Oct 2023 02:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <bbf482643e882f9f870d80cb35342c61955ea291.1694625260.git.andreyknvl@google.com>
In-Reply-To: <bbf482643e882f9f870d80cb35342c61955ea291.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 10:59:30 +0200
Message-ID: <CAG_fn=VspORKG5+xdkmnULq3C64mWCb-XGDvnV9htayf5CL-PQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] lib/stackdepot: rework helpers for depot_alloc_stack
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
> Split code in depot_alloc_stack and depot_init_pool into 3 functions:
>
> 1. depot_keep_next_pool that keeps preallocated memory for the next pool
>    if required.
>
> 2. depot_update_pools that moves on to the next pool if there's no space
>    left in the current pool, uses preallocated memory for the new current
>    pool if required, and calls depot_keep_next_pool otherwise.
>
> 3. depot_alloc_stack that calls depot_update_pools and then allocates
>    a stack record as before.
>
> This makes it somewhat easier to follow the logic of depot_alloc_stack
> and also serves as a preparation for implementing the eviction of stack
> records from the stack depot.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>


> +static void depot_keep_next_pool(void **prealloc)
>  {
>         /*
> -        * If the next pool is already initialized or the maximum number =
of
> +        * If the next pool is already saved or the maximum number of
>          * pools is reached, do not use the preallocated memory.
>          */
>         if (!next_pool_required)
It's not mentioned at the top of the file that next_pool_required is
protected by pool_lock, but it is, correct?
Can you please update the comment to reflect that?


> +
> +       /*
> +        * At this point, either the next pool is kept or the maximum
> +        * number of pools is reached. In either case, take note that
> +        * keeping another pool is not required.
> +        * smp_store_release pairs with smp_load_acquire in stack_depot_s=
ave.

As I wrote in the other patch review, I think we'd better keep
parentheses at the end of the function names in the comments (unless
there's a style guide telling us not to).
