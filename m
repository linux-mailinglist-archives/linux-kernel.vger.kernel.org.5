Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1D67F3B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjKVBVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVBVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:21:22 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6552F199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:21:19 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4629fac5a43so875603137.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700616078; x=1701220878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jSDtkFwQYo0V9vh+o/S1qJObVftAqZ0HjjCO+CrpZs=;
        b=K2pGx08zOcIiwXMVPMRGaTDL7biVp2NHkpJT8EKz6t19/Xps8/8etRB4aoDDL9ZOwA
         94ELG06vgGS6VbOoXwh/RU3Ep+E4q5i5QXZx1jXlCOlOKsCD/Gn4LaqdzI2Mo7dEbs//
         0qowZ4wpcG7qKEw12OEKT2Skoa/tv29EsFa+zZKgdcj01Yfv7nsO7nymOnlAcSQ8h46U
         oR96vvFmI49rtzpjecb7HufssqMixBWJQjWkjMqWFf6ei2Us7m5mDvkpzagJ7C7Lirpe
         m8QY+tcana9R8TS+2eQTqEszlgXNINePxsappzn6uvOXeZ7e0OWaRYkVY9aX0bHxBiEj
         0+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700616078; x=1701220878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jSDtkFwQYo0V9vh+o/S1qJObVftAqZ0HjjCO+CrpZs=;
        b=BZeY8yB1QRtIVLdgHE8Zjj5Z5GbitVlHyylTsTQ61xmOTbALv6+7b4yhdkPR/lkvTo
         ORy3e3+axIFkF7+G84ghQEjiTfEPkQMtB4s+o6fF3hZ3M2d4Ij+Udr1nrzr9xiIs/FDE
         F7liJ0OOtW+2pmN4WhE7DVDcSCqOP8zEfl7+4trm7CFoG6Yl3J/3QSa2Fq9pJe17PnB5
         GgJm6VDCPEgBuFgZlbTKwrlBMAQKwdKQ69DKabq8Pm/kKvNf8+0JghiuVOS2bBNgPjEr
         9SzEe6h3aO3bIm9+niHQgkcOQehOxmddFBpA/Ro5CmHXUB0nzEQS4U9HMAdrxa25/Uan
         KGXw==
X-Gm-Message-State: AOJu0YyEHrxwxsR9Eg+InOZt7PfKKC0Ri0l6tyYxBHHIFIJGEiKEIhQA
        3El8ihZF4eohjsuBRrNilQfsHQBXbjX0ofRHDVU=
X-Google-Smtp-Source: AGHT+IG2LMvK/BZf49hfutXSNQrwe9ElnGcS7qqjv7aljb0nWVvGvhjK07ml4uXR76QepU3OTwghOEGyx3dg+dxgZZY=
X-Received: by 2002:a67:c094:0:b0:462:85e1:c46e with SMTP id
 x20-20020a67c094000000b0046285e1c46emr1021918vsi.29.1700616078413; Tue, 21
 Nov 2023 17:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20231102032330.1036151-1-chengming.zhou@linux.dev> <20231102032330.1036151-4-chengming.zhou@linux.dev>
In-Reply-To: <20231102032330.1036151-4-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Wed, 22 Nov 2023 10:21:07 +0900
Message-ID: <CAB=+i9RpyqWcv-XNp2Eg=dgbRE9EuhfMj=HOhqxOrJxq02jS1g@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] slub: Keep track of whether slub is on the
 per-node partial list
To:     chengming.zhou@linux.dev
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
> Now we rely on the "frozen" bit to see if we should manipulate the
> slab->slab_list, which will be changed in the following patch.
>
> Instead we introduce another way to keep track of whether slub is on
> the per-node partial list, here we reuse the PG_workingset bit.
>
> We use __set_bit and __clear_bit directly instead of the atomic version
> for better performance and it's safe since it's protected by the slub
> node list_lock.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 03384cd965c5..eed8ae0dbaf9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2116,6 +2116,25 @@ static void discard_slab(struct kmem_cache *s, str=
uct slab *slab)
>         free_slab(s, slab);
>  }
>
> +/*
> + * SLUB reuses PG_workingset bit to keep track of whether it's on
> + * the per-node partial list.
> + */
> +static inline bool slab_test_node_partial(const struct slab *slab)
> +{
> +       return folio_test_workingset((struct folio *)slab_folio(slab));
> +}
> +
> +static inline void slab_set_node_partial(struct slab *slab)
> +{
> +       __set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> +}
> +
> +static inline void slab_clear_node_partial(struct slab *slab)
> +{
> +       __clear_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> +}
> +
>  /*
>   * Management of partially allocated slabs.
>   */
> @@ -2127,6 +2146,7 @@ __add_partial(struct kmem_cache_node *n, struct sla=
b *slab, int tail)
>                 list_add_tail(&slab->slab_list, &n->partial);
>         else
>                 list_add(&slab->slab_list, &n->partial);
> +       slab_set_node_partial(slab);
>  }
>
>  static inline void add_partial(struct kmem_cache_node *n,
> @@ -2141,6 +2161,7 @@ static inline void remove_partial(struct kmem_cache=
_node *n,
>  {
>         lockdep_assert_held(&n->list_lock);
>         list_del(&slab->slab_list);
> +       slab_clear_node_partial(slab);
>         n->nr_partial--;
>  }
>
> @@ -4833,6 +4854,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache=
 *s)
>
>                         if (free =3D=3D slab->objects) {
>                                 list_move(&slab->slab_list, &discard);
> +                               slab_clear_node_partial(slab);
>                                 n->nr_partial--;
>                                 dec_slabs_node(s, node, slab->objects);
>                         } else if (free <=3D SHRINK_PROMOTE_MAX)
> --

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
