Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0647D512E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbjJXNOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJXNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:14:35 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2647ADD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:14:33 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2ec9a79bdso3223603b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698153272; x=1698758072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEr9urFwA/XFdZ4nlXaG4cbFnHUMhCkx9szJZ37Mwg4=;
        b=syAtvyUHXKO+N3kn4Ka696c9uX/VUlQgIOPAWUq/T+P9mmwiT1SLLh/JQLL5vm77q9
         PbGXVzakdBwplZTTQMEjv7B1y7znXqEXzCTlX/yJPddrE90k+JsEs+9gz6OEz66skNbt
         c1AQTLD3c2YV3juxm6ZoREJqvwR1PQROdpq/OENHQtF7uUef79wVDKvC/g8+vnm5F5Nk
         4KnVBsqdJO1Y+a84pgfSjlgV81WA1ZrRt4C9/kWkrhxG7bwcQvM71vMWEdelsnVCwV9r
         dywyUmw59bYF51w4T2EMFzG8JhUlR8Irn1YjAujWnHCRojp9ztGhNd+wF6jcToumWNhI
         6pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698153272; x=1698758072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEr9urFwA/XFdZ4nlXaG4cbFnHUMhCkx9szJZ37Mwg4=;
        b=hJp5QOdiP/x4qUclylX37FAWAeQOeaovKFRrjBvuTPLQe6ZL6antKf+OY7EbT6220p
         tiOcurPziy4k/0ugPFTvRYOui8XXSwz+vZIsFYRHle0hVK9Tw9UHlHpEOTWojHejz8NK
         +LI8/N5mgut0ZwBwKekjj6UKoFTs+XUb1JRTleSGcj9vcmH3ANHkqssOiQ34ZSUoN5qZ
         srjj1sZOfHGEmz5BcThwbnLbbHkp2ToAHpZAAHDCrKRilaOVHdsswSc9rCsb4jF6Y5JY
         0CG+Tx7x/eVBxrUhfBH4AW6W68OeaxEdbdt0Axf2uPRykOE7FYMydUcweaEXkNGZKD7z
         hfcg==
X-Gm-Message-State: AOJu0YwWpcwGqxtDSA9cnqsGxMWHZfT1p5IOkhZGSQfhfUpjqWWBf+Ra
        9vHEtzh+d8nTrunh8tSMYL6sJqFH1PFLLq0QCj3jcA==
X-Google-Smtp-Source: AGHT+IFko/8C6M3JHArZ1Zx5hfggnK1QA7sDxIbWpOuWMp+LhICu2KMX4uEDtQ/Lxme/mdMUv5QiMHA4JlifACARQAg=
X-Received: by 2002:aca:d12:0:b0:3a7:6ff5:c628 with SMTP id
 18-20020aca0d12000000b003a76ff5c628mr13328519oin.11.1698153272314; Tue, 24
 Oct 2023 06:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698077459.git.andreyknvl@google.com>
In-Reply-To: <cover.1698077459.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 24 Oct 2023 15:13:54 +0200
Message-ID: <CANpmjNNoJQoWzODAbc4naq--b+LOfK76TCbx9MpL8+4x9=LTiw@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] stackdepot: allow evicting stack traces
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 at 18:22, <andrey.konovalov@linux.dev> wrote:
[...]
> ---
>
> Changes v2->v3:
> - Fix null-ptr-deref by using the proper number of entries for
>   initializing the stack table when alloc_large_system_hash()
>   auto-calculates the number (see patch #12).
> - Keep STACKDEPOT/STACKDEPOT_ALWAYS_INIT Kconfig options not configurable
>   by users.
> - Use lockdep_assert_held_read annotation in depot_fetch_stack.
> - WARN_ON invalid flags in stack_depot_save_flags.
> - Moved "../slab.h" include in mm/kasan/report_tags.c in the right patch.
> - Various comment fixes.
>
> Changes v1->v2:
> - Rework API to stack_depot_save_flags(STACK_DEPOT_FLAG_GET) +
>   stack_depot_put.
> - Add CONFIG_STACKDEPOT_MAX_FRAMES Kconfig option.
> - Switch stack depot to using list_head's.
> - Assorted minor changes, see the commit message for each path.
>
> Andrey Konovalov (19):
>   lib/stackdepot: check disabled flag when fetching
>   lib/stackdepot: simplify __stack_depot_save
>   lib/stackdepot: drop valid bit from handles
>   lib/stackdepot: add depot_fetch_stack helper
>   lib/stackdepot: use fixed-sized slots for stack records

1. I know fixed-sized slots are need for eviction to work, but have
you evaluated if this causes some excessive memory waste now? Or is it
negligible?

If it turns out to be a problem, one way out would be to partition the
freelist into stack size classes; e.g. one for each of stack traces of
size 8, 16, 32, 64.

>   lib/stackdepot: fix and clean-up atomic annotations
>   lib/stackdepot: rework helpers for depot_alloc_stack
>   lib/stackdepot: rename next_pool_required to new_pool_required
>   lib/stackdepot: store next pool pointer in new_pool
>   lib/stackdepot: store free stack records in a freelist
>   lib/stackdepot: use read/write lock

2. I still think switching to the percpu_rwsem right away is the right
thing, and not actually a downside. I mentioned this before, but you
promised a follow-up patch, so I trust that this will happen. ;-)

>   lib/stackdepot: use list_head for stack record links
>   kmsan: use stack_depot_save instead of __stack_depot_save
>   lib/stackdepot, kasan: add flags to __stack_depot_save and rename
>   lib/stackdepot: add refcount for records
>   lib/stackdepot: allow users to evict stack traces
>   kasan: remove atomic accesses to stack ring entries
>   kasan: check object_size in kasan_complete_mode_report_info
>   kasan: use stack_depot_put for tag-based modes
>
>  include/linux/stackdepot.h |  59 ++++--
>  lib/Kconfig                |  10 +
>  lib/stackdepot.c           | 418 ++++++++++++++++++++++++-------------
>  mm/kasan/common.c          |   7 +-
>  mm/kasan/generic.c         |   9 +-
>  mm/kasan/kasan.h           |   2 +-
>  mm/kasan/report_tags.c     |  27 +--
>  mm/kasan/tags.c            |  24 ++-
>  mm/kmsan/core.c            |   7 +-
>  9 files changed, 365 insertions(+), 198 deletions(-)

Acked-by: Marco Elver <elver@google.com>

The series looks good in its current state. However, see my 2
higher-level comments above.
