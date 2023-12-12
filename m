Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0380F6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjLLTaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjLLTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:30:32 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB719AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:30:38 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7caff8105dcso745308241.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702409438; x=1703014238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pcoi2NJ5WlkDrXij7nG/i+1L6bQHIDHmRGBrwHts7ds=;
        b=NP3mBX4GA1YoBym7tucbXITo6X8XoXE0VbjhYiHuPQP/3egsZhq+knW+pOqNNVdopn
         yrgtO9vKZt2abkyv73Pyps45IRe+ZyF9NMDtMs3PIzCkN10k8LS5UR7JttCwjoPnielO
         nB9rrbsjdsdNiWdPHQphhV39PtPm310Be5kZeZUUfTAv+Qxq8f449aOXT3KbNU9yKJh+
         8ZIoI6pq6vcnBcuY660jtCPzaFk581fLPzNC8lZZMGyX0caKqLOYirL33JWvD/lyGN5H
         NSNqchTpNzdTBZOhqn9jQG4nEOUbqo6Q3ffaaV+2lAtdR70HrIcRyugMBl7Nhjy3iz/I
         zC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409438; x=1703014238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pcoi2NJ5WlkDrXij7nG/i+1L6bQHIDHmRGBrwHts7ds=;
        b=BKRJ0CDiii4RaeMMthR/uWxOPpuD97Msq3xVkt4oYqMO3VAevOlEGZdeI7c9XF8ulA
         2TYywxlPzC75pWmeeHsGvKuMOeIX3D0yhs+Dymgiwp8H6Dc7Y0mak31QHhoCAvIlKRmL
         k9KCL5Ys+k46b0gCNpgT0TU7C3j4CUHbBfMkvcnYA5CHBlb2x3zdI6+ppEURyeekwlDD
         mWEuM4eue/M52+rMcuIAmJVn3P5/FDdlCaoqI6pTlFatdq3gOD2tElp3YdLIbZeHkiB/
         Is0sXf9eOlwnp2nSM7viI0imN4xKWCUiSLgxFeng5jrgg9wDK12n0pk3e9YWSWgotlLS
         CExQ==
X-Gm-Message-State: AOJu0YyLIwEa52u3U8RctkCXQQ/15YFDDDav+4qvz2R4X7PRfP8h1DI7
        KQUPbjQSUGbza/zCrpzd+KgG1VVskXe4w8CGEh17Nw==
X-Google-Smtp-Source: AGHT+IFFYsOyN/3AYlxu0hMyGsXXOjsnSyeVU9PlVy7sfaaSLsLOBXbgAvu4WYOa2L4VQB9LFX7A9Ttrk9JV9h6+NMA=
X-Received: by 2002:a05:6102:510a:b0:462:8ca2:1bb0 with SMTP id
 bm10-20020a056102510a00b004628ca21bb0mr4858842vsb.20.1702409437702; Tue, 12
 Dec 2023 11:30:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702339432.git.andreyknvl@google.com> <d0943bd69fdfe27fbda20fde9b143e57c825546f.1702339432.git.andreyknvl@google.com>
In-Reply-To: <d0943bd69fdfe27fbda20fde9b143e57c825546f.1702339432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Dec 2023 20:30:01 +0100
Message-ID: <CANpmjNNTA2qvBTLvA6Qn4HSpsWP6dmMODCFSVtLKZrZfGSAL0A@mail.gmail.com>
Subject: Re: [PATCH mm 3/4] kasan: memset free track in qlink_free
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 01:14, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Instead of only zeroing out the stack depot handle when evicting the
> free stack trace in qlink_free, zero out the whole track.
>
> Do this just to produce a similar effect for alloc and free meta. The
> other fields of the free track besides the stack trace handle are
> considered invalid at this point anyway, so no harm in zeroing them out.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>
> This can be squashed into "kasan: use stack_depot_put for Generic mode"
> or left standalone.
> ---
>  mm/kasan/quarantine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 265ca2bbe2dd..782e045da911 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -157,7 +157,7 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>         if (free_meta &&
>             *(u8 *)kasan_mem_to_shadow(object) == KASAN_SLAB_FREETRACK) {
>                 stack_depot_put(free_meta->free_track.stack);
> -               free_meta->free_track.stack = 0;
> +               __memset(&free_meta->free_track, 0, sizeof(free_meta->free_track));
>         }
>
>         /*
> --
> 2.25.1
>
