Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06580212E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjLCGBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLCGBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:01:30 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6BFFE
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:01:37 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4b2881aa3d6so1135927e0c.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 22:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701583296; x=1702188096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75GAc10of+yuuWhZkJ7UEiM6igGIu13so7TnNv3aMVo=;
        b=GSzgX36THss1mrdmzMx57swX8PpbZR1MxYCDwIG5lYn6LrQTRIbiFO/mAzpStWzkCm
         jGuKBGY2LMwnnvUz3URHLQF+VVKsGOM7CtQrP6ZaZJ8QGGxdJ+leF58iLwGqmIBkMk3q
         A/Cw5jEpp5UwZzmSLBofH10EytIxAuWHQSTXf2CVqsGEUjruQw9VMDL8SrwqqY7RaNmr
         lcR1YdNuMFkUjPUaB20w92/fWbcBYpiRRdYTTGHW0KFvYoMABGUH9ORq/zcCbY/oo82F
         h1i25rszCbrDp0JVWLtH4bZbthamgmb0PJZ4WzEg8wIU3G9sahRa4p7qHM8gGxDviGgH
         8gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701583296; x=1702188096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75GAc10of+yuuWhZkJ7UEiM6igGIu13so7TnNv3aMVo=;
        b=nq/25i4cEc6UPFuDXBcNkMj49X1MTFJx8nKd9n339TNFHnBXrsP6+Hq2V7Q7maLXdu
         sQ2rC27jX95V5QNWrJpEfmRdKU8qKu4FOkOwrWfYU72Br1fURa9tlrN8rS+Es4FK4miF
         oP/651wQV3f1o1MDTgRR6Ncj5P6z2AODDPyPXx0qveH242ajYA5d/KbVZpjBBjW7gXs4
         qxTQXvmk9ZZmKQX8Pvjv0Bu3fBLrbGiUg+qjNuGQ3pthInlqtTVE534T2hMb9iVTWwS9
         6ZBNEMxSUC5bPrCX4r6KQJsE6W0Q2P+we6Tbgv2YL4tuWh9qXVMTWSSxEMAgVksUYN+L
         Zhog==
X-Gm-Message-State: AOJu0Yyf/tQPdRwXvMG4piMnqyQYqKYaF43qwExO5fPuVcRi/ZykimMO
        yrneQM3292zsSKU54i1w/FBTq5PNZ5ruSlwVmps=
X-Google-Smtp-Source: AGHT+IEp5JZH8xZObiQXhK2t0jgFnkMGZl0S0e9vnimECJPXHXmaw10Ahfs9E6984/48y7eqU+m+L9O3B/IjI5b1vS0=
X-Received: by 2002:a67:ec43:0:b0:464:63dc:bcea with SMTP id
 z3-20020a67ec43000000b0046463dcbceamr718817vso.16.1701583296187; Sat, 02 Dec
 2023 22:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20231102032330.1036151-1-chengming.zhou@linux.dev> <20231102032330.1036151-5-chengming.zhou@linux.dev>
In-Reply-To: <20231102032330.1036151-5-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sun, 3 Dec 2023 15:01:23 +0900
Message-ID: <CAB=+i9SDzPNSL03U9T6XAhfW8oed42yhc9F0ou5-2bqWkUJ=ZQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] slub: Prepare __slab_free() for unfrozen partial
 slab out of node partial list
To:     chengming.zhou@linux.dev
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 12:24=E2=80=AFPM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> Now the partially empty slub will be frozen when taken out of node partia=
l
> list, so the __slab_free() will know from "was_frozen" that the partially
> empty slab is not on node partial list and is a cpu or cpu partial slab
> of some cpu.
>
> But we will change this, make partial slabs leave the node partial list
> with unfrozen state, so we need to change __slab_free() to use the new
> slab_test_node_partial() we just introduced.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index eed8ae0dbaf9..1880b483350e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3631,6 +3631,7 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>         unsigned long counters;
>         struct kmem_cache_node *n =3D NULL;
>         unsigned long flags;
> +       bool on_node_partial;
>
>         stat(s, FREE_SLOWPATH);
>
> @@ -3678,6 +3679,7 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>                                  */
>                                 spin_lock_irqsave(&n->list_lock, flags);
>
> +                               on_node_partial =3D slab_test_node_partia=
l(slab);
>                         }
>                 }
>
> @@ -3706,6 +3708,15 @@ static void __slab_free(struct kmem_cache *s, stru=
ct slab *slab,
>                 return;
>         }
>
> +       /*
> +        * This slab was partially empty but not on the per-node partial =
list,
> +        * in which case we shouldn't manipulate its list, just return.
> +        */
> +       if (prior && !on_node_partial) {
> +               spin_unlock_irqrestore(&n->list_lock, flags);
> +               return;
> +       }
> +
>         if (unlikely(!new.inuse && n->nr_partial >=3D s->min_partial))
>                 goto slab_empty;
>

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> --
> 2.20.1
>
