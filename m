Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2998D7F3AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjKVA0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKVA03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:26:29 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF561A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:26:25 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4af6a700087so2006139e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700612784; x=1701217584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6SlFQgfAbHnP562FfJkWr5EctvFZHTzloSc2FxzjM0=;
        b=UC6UBsbCSyLvyhrH64oa/ww0lcYpJhyP7XAcHDce292uAXkLJxq9X8qlebemK22hiH
         HKd50MBze7AG/vKCXX2ffmdMJ7/DausoyrL03VlKJRSgDnmNqWQHkbagBIk5dRCNe3IS
         mGoOvtAHnNJYT5DxhoPjt8E99/pSj9iOrHBs3brLrorIHZ1u/ljsm6mzQM2tGcjPvc+6
         faAExPbwK9h02AOOTyWbbL58eK0P+2tc3vUVp+RsB4DOy0vhMmTtlx5ak0sipy1Ap3kP
         WnoyFHN6uPLYqPaKiIudA8TQ6vmXzSxtTSg3/RN0yANyn3bSP2TKdi9tpafCiuzRwvCo
         Lybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700612784; x=1701217584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6SlFQgfAbHnP562FfJkWr5EctvFZHTzloSc2FxzjM0=;
        b=igr+Y0yHCyJHJt4L3W02PreAXZSirkoueALPB0rU/vElFgjMNwJ1fUCVySqZ6Vk8WW
         vxh8D4/DTGGT5dBqzUPMk2FCVKYpCf07WQ+q3Dg1aSyxi4aexM44HWZwoNMPt2eShb98
         ExMG3pNOQ7mf9nyTDeWfaQGsP35POjLrlcynyb3w5yvI6SER/65g9NNoAVb/fwqL95UG
         NEgAkh85hf8GBWtMBVjJ4hUuWJiB3+iS/fHvAFg+cvMVtPPZd+5opGu6kZaCXeZ4SpJp
         Egg/77RfFfBBVZcsRWyWO79NKA0CELX9nX2QfNZgO+ZA+cXZ56fsiuhoY1bHZxmQJxSn
         dF1Q==
X-Gm-Message-State: AOJu0YzlNHzmkJ5Y3aaQ2rZ68BJS6hANj0A4NZO6aaJeSdyvvAx64tJm
        RWADW5lnbwr9Igj46qR8STpOD4+qBp+4i5wDmFI=
X-Google-Smtp-Source: AGHT+IHSGwEXWP+fKT1/z0TeCOtjJ0b/m9MVR4pikWe6eK27nVISLA4rBz5IDKGV5NT81vvCXt4/G7FPBSZmCN1SfMg=
X-Received: by 2002:a1f:dfc4:0:b0:49a:1a56:945c with SMTP id
 w187-20020a1fdfc4000000b0049a1a56945cmr1110334vkg.13.1700612784086; Tue, 21
 Nov 2023 16:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20231102032330.1036151-1-chengming.zhou@linux.dev> <20231102032330.1036151-2-chengming.zhou@linux.dev>
In-Reply-To: <20231102032330.1036151-2-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Wed, 22 Nov 2023 09:26:13 +0900
Message-ID: <CAB=+i9RU-VOcnWOOuHSYp3ybRjcrxxLqsqN6aSL1=Lac83c-AQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] slub: Reflow ___slab_alloc()
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
> The get_partial() interface used in ___slab_alloc() may return a single
> object in the "kmem_cache_debug(s)" case, in which we will just return
> the "freelist" object.
>
> Move this handling up to prepare for later changes.
>
> And the "pfmemalloc_match()" part is not needed for node partial slab,
> since we already check this in the get_partial_node().
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 63d281dfacdb..0b0fdc8c189f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3216,8 +3216,21 @@ static void *___slab_alloc(struct kmem_cache *s, g=
fp_t gfpflags, int node,
>         pc.slab =3D &slab;
>         pc.orig_size =3D orig_size;
>         freelist =3D get_partial(s, node, &pc);
> -       if (freelist)
> -               goto check_new_slab;
> +       if (freelist) {
> +               if (kmem_cache_debug(s)) {
> +                       /*
> +                        * For debug caches here we had to go through
> +                        * alloc_single_from_partial() so just store the
> +                        * tracking info and return the object.
> +                        */
> +                       if (s->flags & SLAB_STORE_USER)
> +                               set_track(s, freelist, TRACK_ALLOC, addr)=
;
> +
> +                       return freelist;
> +               }
> +
> +               goto retry_load_slab;
> +       }
>
>         slub_put_cpu_ptr(s->cpu_slab);
>         slab =3D new_slab(s, gfpflags, node);
> @@ -3253,20 +3266,6 @@ static void *___slab_alloc(struct kmem_cache *s, g=
fp_t gfpflags, int node,
>
>         inc_slabs_node(s, slab_nid(slab), slab->objects);
>
> -check_new_slab:
> -
> -       if (kmem_cache_debug(s)) {
> -               /*
> -                * For debug caches here we had to go through
> -                * alloc_single_from_partial() so just store the tracking=
 info
> -                * and return the object
> -                */
> -               if (s->flags & SLAB_STORE_USER)
> -                       set_track(s, freelist, TRACK_ALLOC, addr);
> -
> -               return freelist;
> -       }
> -
>         if (unlikely(!pfmemalloc_match(slab, gfpflags))) {
>                 /*
>                  * For !pfmemalloc_match() case we don't load freelist so=
 that

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> --
> 2.20.1
>
