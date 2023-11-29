Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0A7FCBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 01:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjK2Aqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 19:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK2Aqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:46:45 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D951B10C1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:46:51 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4ac0d137835so1956925e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701218811; x=1701823611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oDh1aIguEdHpwRt07bECjWeSQzO3Fxi6hNx6EgBsZw=;
        b=JdlTmnzA7eCJONVLzPygFC9sGQ7/D3ZuLjhPPfenDInfKeJg50o8Yza+WM9X10Hxb9
         p8EhBuv9DdGJRscOf1zewWiRWPQb/d5vTWEvCTi3gDeJhzomoZXTWll9JunGUpkBPvup
         z7ZHdjMVzw39Uf1uACiCOXJAMggL1Q0yQOyDl+IqvaQ6yTr3oRDJQXSVignvI0sWxxDe
         8LuKRoMQd8KEvGZh1wt4e2mDVFNK87UfD4hDRvxrqixpSo3rbQ1L/2LwZsGlgtDSedXb
         eSaTVIfQ+YCF2LyXzsus47ZJM7uvu7y66kHXQXZ4i68/UGAimlBpSUyAxXcwpzHD07hv
         atRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701218811; x=1701823611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oDh1aIguEdHpwRt07bECjWeSQzO3Fxi6hNx6EgBsZw=;
        b=uRKZH1XcK0l7L5EOgPKG3WS82D8yR3SK+stLgCHD1uX4pOLN84vLivdrjwstS8yjwq
         CTfHjeI07paOd4WfAU+FZlW1ws3ghAMLXyMCTrHwjw+tJf6BIkDtx/Mcc1WW9xhb6GyZ
         dpaovzo41IcSR6yy+6f8qUuUjkwyq4YTj7FcfPPIK3ypfMdtvAHYKtTR7WItnfYU3i0X
         PcW7zm/gB9ktboGyheddLwYWoCpfKvAzOxF0b5W6OicE1F0c7byj1DP4xhDTfAqjOhoF
         k9qMLIkZIxrhqKNhshhIKbozzXEKE+QFsbTW0gOjLVssvkpCH2aDos36VZXAzpYqF6ng
         R4Fw==
X-Gm-Message-State: AOJu0Yw15NkippzeiHAtuLdqLv38k7ygw45LXJJnxZVxrDY6DXZjc6n+
        O39UCMMrn9RN4CMpRRObsWqhtNNJ4DHurVXsBvM=
X-Google-Smtp-Source: AGHT+IEk8yTd8eI4EdeyKZW6reXCMwZOddixQRa28CFP3qyfYrswVX53unzj5ErXKXftiuXmRwb92oAWzv7HWxQq7w0=
X-Received: by 2002:a1f:f8cf:0:b0:4b2:777a:a860 with SMTP id
 w198-20020a1ff8cf000000b004b2777aa860mr3478556vkh.13.1701218810686; Tue, 28
 Nov 2023 16:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20230810163627.6206-9-vbabka@suse.cz> <20230810163627.6206-11-vbabka@suse.cz>
 <CAB=+i9TSMVURktFvr7sAt4T2BdaUvsWFapAjTZNtk0AKS01O9A@mail.gmail.com> <077e8e97-e88f-0b8e-2788-4031458be090@suse.cz>
In-Reply-To: <077e8e97-e88f-0b8e-2788-4031458be090@suse.cz>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Wed, 29 Nov 2023 09:46:38 +0900
Message-ID: <CAB=+i9SQBhYBjOSHDeqgJJ5YARqZCS3oUUutzr4m+2V+ZvySpg@mail.gmail.com>
Subject: Re: [RFC v2 2/7] mm, slub: add opt-in slub_percpu_array
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Wed, Nov 29, 2023 at 2:37=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 8/21/23 16:57, Hyeonggon Yoo wrote:
> > Hi,
> >
> > On Fri, Aug 11, 2023 at 1:36=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
>
> Oops, looks like I forgot reply, sorry (preparing v3 now).

It's fine, you were busy removing SLAB :)
thanks for replying.

> >
> >>  /*
> >>   * Inlined fastpath so that allocation functions (kmalloc, kmem_cache=
_alloc)
> >>   * have the fastpath folded into their functions. So no function call
> >> @@ -3465,7 +3564,11 @@ static __fastpath_inline void *slab_alloc_node(=
struct kmem_cache *s, struct list
> >>         if (unlikely(object))
> >>                 goto out;
> >>
> >> -       object =3D __slab_alloc_node(s, gfpflags, node, addr, orig_siz=
e);
> >> +       if (s->cpu_array)
> >> +               object =3D alloc_from_pca(s);
> >> +
> >> +       if (!object)
> >> +               object =3D __slab_alloc_node(s, gfpflags, node, addr, =
orig_size);
> >>
> >>         maybe_wipe_obj_freeptr(s, object);
> >>         init =3D slab_want_init_on_alloc(gfpflags, s);
> >> @@ -3715,6 +3818,34 @@ static void __slab_free(struct kmem_cache *s, s=
truct slab *slab,
> >>         discard_slab(s, slab);
> >>  }
> >
> >>  #ifndef CONFIG_SLUB_TINY
> >>  /*
> >>   * Fastpath with forced inlining to produce a kfree and kmem_cache_fr=
ee that
> >> @@ -3740,6 +3871,11 @@ static __always_inline void do_slab_free(struct=
 kmem_cache *s,
> >>         unsigned long tid;
> >>         void **freelist;
> >>
> >> +       if (s->cpu_array && cnt =3D=3D 1) {
> >> +               if (free_to_pca(s, head))
> >> +                       return;
> >> +       }
> >> +
> >>  redo:
> >>         /*
> >>          * Determine the currently cpus per cpu slab.
> >> @@ -3793,6 +3929,11 @@ static void do_slab_free(struct kmem_cache *s,
> >>  {
> >>         void *tail_obj =3D tail ? : head;
> >>
> >> +       if (s->cpu_array && cnt =3D=3D 1) {
> >> +               if (free_to_pca(s, head))
> >> +                       return;
> >> +       }
> >> +
> >>         __slab_free(s, slab, head, tail_obj, cnt, addr);
> >>  }
> >>  #endif /* CONFIG_SLUB_TINY */
> >
> > Is this functionality needed for SLUB_TINY?
>
> Due to the prefill semantics, I think it has to be be even in TINY, or we
> risk running out of memory reserves. Also later I want to investigate
> extending this approach for supporting allocations in very constrained
> contexts (NMI) so e.g. bpf doesn't have to reimplement the slab allocator=
,
> and that would also not be good to limit to !SLUB_TINY.

I've got the point, thanks for the explanation!

> >> @@ -4060,6 +4201,45 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s,=
 gfp_t flags, size_t size,
> >>  }
> >>  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
> >>
> >> +int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned in=
t count,
> >> +               gfp_t gfp)
> >> +{
> >> +       struct slub_percpu_array *pca;
> >> +       void *objects[32];
> >> +       unsigned int used;
> >> +       unsigned int allocated;
> >> +
> >> +       if (!s->cpu_array)
> >> +               return -EINVAL;
> >> +
> >> +       /* racy but we don't care */
> >> +       pca =3D raw_cpu_ptr(s->cpu_array);
> >> +
> >> +       used =3D READ_ONCE(pca->used);
> >
> > Hmm for the prefill to be meaningful,
> > remote allocation should be possible, right?
>
> Remote in what sense?

TL;DR) What I wanted to ask was:
"How pre-filling a number of objects works when the pre-filled objects
are not shared between CPUs"

IIUC the prefill is opportunistically filling the array so (hopefully)
expecting there are
some objects filled in it.

Let's say CPU X calls kmem_cache_prefill_percpu_array(32) and all 32
objects are filled into CPU X's array.
But if CPU Y can't allocate from CPU X's array (which I referred to as
"remote allocation"), the semantics differ from
the maple tree's perspective because preallocated objects were shared
between CPUs before, but now it's not?

Thanks!

--
Hyeonggon
