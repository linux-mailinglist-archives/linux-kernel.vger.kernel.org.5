Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6097B40AB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 15:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjI3Nxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 09:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjI3Nxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:53:35 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA711F1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:53:32 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4963adb481dso5720486e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696082012; x=1696686812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE44gllyMSKTL2/oh+C5sUr05vfExpsU9yzwXpUaPDg=;
        b=jfIpQT7zLLvrwHSmOM9hWG8DfZs3zG6t95Q0sYBvCoGl5nuXtXXocIJZZXIK11DHFR
         62tuPq7mcHbTj9do+ELhAkRi4wwYoHSaDsog0Kx2j+GIpzbH86Yal0m8a6X0wmZe0A+Q
         xFi0X/o3Gj0zOjSa+ncOOupILLUvsm7shIIl56PlgB/lV6c7VFgPd0BBHEGe6JgM4tOy
         c5kf/620XMp5Fc/7CNYAf7YZgWHnpF+kgUPdOp3vOryl4RdCxfW4R1dKmWMr6fJ0wvmx
         ifTuutg+IbbD7NQVZBl5B6UoUIQd3POM/Q8wwyRUBKVfhUd7N0ncw73jcdzuW4yoBiZL
         E5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696082012; x=1696686812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE44gllyMSKTL2/oh+C5sUr05vfExpsU9yzwXpUaPDg=;
        b=g2SUco8hlP50qwdUKeP3za8eCpP03m2BchNdEpHzz7BN3HNLMZPD1JJAktYAwEfpkN
         fFmXIjQecAWGmjqxuYG9guptyPng9NePEnIOkwOrWFlNex3hVF+or3a13yBZ1uNMUjgT
         lO4kPJWsE7kKn+igNjydHg0cSPMcF9kDOBPRNWkpbQGyeyVCBQLdXCmmPcNESDGBQE0E
         I1Uh4aF/QbqeyTFvW26aDimD1+sr8zHRZO/h65HNIU7Pz4gHzTSfgoRdRGZQNIKq7FhB
         hL94PgfhTIgz0UFUxATtDY0UTjFEcn8gdeCMdpZuIc/RU0C+ud83GJAt6AmR47QMHAK7
         AZAQ==
X-Gm-Message-State: AOJu0Yyv+9p1+ZwXY9brZatnMVYHzuPOiA+HJltxvrvCxjV9TUfH320L
        S0F2b7vMR4FB0lIb979W0SpKWQBY59iveHJP5a8=
X-Google-Smtp-Source: AGHT+IFgF9luMMCdL8FDm0tPqnvyIUnoBHwXCDg73udcbnOe9TI+UnqcrKovU9VnWkkpiGQqG8bMpRPqTY6PfyY8Fag=
X-Received: by 2002:a1f:e043:0:b0:48d:1b20:268e with SMTP id
 x64-20020a1fe043000000b0048d1b20268emr5942014vkg.10.1696082011676; Sat, 30
 Sep 2023 06:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <4d31a2bf7eb544749023cf491c0eccc8@AcuMS.aculab.com>
 <202309071235.CB4F6B2@keescook> <20ca0a567a874052a1161e9be0870463@AcuMS.aculab.com>
 <e17c58a4-2dd8-4a1b-9feb-ab307e3877c2@suse.cz> <1bf41b7c8d7c428c8bfb5504ec9f680e@AcuMS.aculab.com>
 <1d634412-c0e5-4c16-92a4-447bde684ad6@suse.cz> <e12d3085c8b8414b837bfc737af0c9de@AcuMS.aculab.com>
 <5569ec99-b441-f7f0-060b-168abc089b23@suse.cz> <a7186ea957ae47feb8c79ad92057f481@AcuMS.aculab.com>
 <d3850b0e-6306-56a2-9562-21c51504ab4d@suse.cz>
In-Reply-To: <d3850b0e-6306-56a2-9562-21c51504ab4d@suse.cz>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sat, 30 Sep 2023 22:53:19 +0900
Message-ID: <CAB=+i9SkvY0Q1V-t3sZxbyTiEHwSXHRuzTNjgeA-BV+K+2fJxQ@mail.gmail.com>
Subject: Re: Subject: [PATCH v2] slab: kmalloc_size_roundup() must not return
 0 for non-zero size
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 9:48=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/20/23 12:06, David Laight wrote:
> > From: Vlastimil Babka
> >> Sent: 20 September 2023 10:58
> >>
> >> On 9/11/23 18:38, David Laight wrote:
> >> >> >> So perhaps the best would be to return size for c =3D=3D NULL, b=
ut also do a
> >> >> >> WARN_ONCE?
> >> >> >
> >> >> > That would add a real function call to an otherwise leaf function
> >> >> > and almost certainly require the compiler create a stack frame.
> >> >>
> >> >> Hm I thought WARN is done by tripping on undefined instruction like=
 BUG
> >> >> these days. Also any code that accepts the call to kmalloc_size_rou=
ndup
> >> >> probably could accept that too.
> >> >
> >> > It's probably just worth removing the c =3D=3D NULL check and
> >> > assuming there won't be any fallout.
> >> > The NULL pointer deref is an easy to debug as anything else.
> >> >
> >> > If it gets called in any early init code it'll soon show up.
> >>
> >> Good point, early crash should be ok.
> >> So how about this with my tweaks, looks ok?
> >
> > Is that just/mainly the change to assume that kmalloc_slab() doesn't fa=
il?
>
> Yes.
>
> > You can also remove 'c'.
> >       return kmalloc_slab(size, GFP_KERNEL, 0)->object_size;
> > isn't too long.
>
> Right, did that and pushed to -next. Thanks!

A bit late, but for the record:

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> > I also did a grep for callers.
> > Nothing in early code, IIRC mainly 'net'.
> >
> >       David
> >
> >> I'll put it in -next and
> >> send with another hotfix to 6.6 next week.
> >> ----8<----
> >> From f5de1ee7b35d7ab35c21c79dd13cea49fbe239b7 Mon Sep 17 00:00:00 2001
> >> From: David Laight <david.laight@aculab.com>
> >> Date: Thu, 7 Sep 2023 12:42:20 +0000
> >> Subject: [PATCH] Subject: [PATCH v2] slab: kmalloc_size_roundup() must=
 not
> >>  return 0 for non-zero size
> >>
> >> The typical use of kmalloc_size_roundup() is:
> >>
> >>      ptr =3D kmalloc(sz =3D kmalloc_size_roundup(size), ...);
> >>      if (!ptr) return -ENOMEM.
> >>
> >> This means it is vitally important that the returned value isn't less
> >> than the argument even if the argument is insane.
> >> In particular if kmalloc_slab() fails or the value is above
> >> (MAX_ULONG - PAGE_SIZE) zero is returned and kmalloc() will return
> >> its single zero-length buffer ZERO_SIZE_PTR.
> >>
> >> Fix this by returning the input size if the size exceeds
> >> KMALLOC_MAX_SIZE. kmalloc() will then return NULL as the size really i=
s
> >> too big.
> >>
> >> kmalloc_slab() should not normally return NULL, unless called too earl=
y.
> >> Again, returning zero is not the correct action as it can be in some
> >> usage scenarios stored to a variable and only later cause kmalloc()
> >> return ZERO_SIZE_PTR and subsequent crashes on access. Instead we can
> >> simply stop checking the kmalloc_slab() result completely, as calling
> >> kmalloc_size_roundup() too early would then result in an immediate cra=
sh
> >> during boot and the developer noticing an issue in their code.
> >>
> >> [vbabka@suse.cz: remove kmalloc_slab() result check, tweak comments an=
d
> >>  commit log]
> >> Signed-off-by: David Laight <david.laight@aculab.com>
> >> Fixes: 05a940656e1e ("slab: Introduce kmalloc_size_roundup()")
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slab_common.c | 25 ++++++++++++++-----------
> >>  1 file changed, 14 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index e99e821065c3..1dc108224bd1 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -747,22 +747,25 @@ size_t kmalloc_size_roundup(size_t size)
> >>  {
> >>      struct kmem_cache *c;
> >>
> >> -    /* Short-circuit the 0 size case. */
> >> -    if (unlikely(size =3D=3D 0))
> >> -            return 0;
> >> -    /* Short-circuit saturated "too-large" case. */
> >> -    if (unlikely(size =3D=3D SIZE_MAX))
> >> -            return SIZE_MAX;
> >> +    if (size && size <=3D KMALLOC_MAX_CACHE_SIZE) {
> >> +            /*
> >> +             * The flags don't matter since size_index is common to a=
ll.
> >> +             * Neither does the caller for just getting ->object_size=
.
> >> +             */
> >> +            c =3D kmalloc_slab(size, GFP_KERNEL, 0);
> >> +            return c->object_size;
> >> +    }
> >> +
> >>      /* Above the smaller buckets, size is a multiple of page size. */
> >> -    if (size > KMALLOC_MAX_CACHE_SIZE)
> >> +    if (size && size <=3D KMALLOC_MAX_SIZE)
> >>              return PAGE_SIZE << get_order(size);
> >>
> >>      /*
> >> -     * The flags don't matter since size_index is common to all.
> >> -     * Neither does the caller for just getting ->object_size.
> >> +     * Return 'size' for 0 - kmalloc() returns ZERO_SIZE_PTR
> >> +     * and very large size - kmalloc() may fail.
> >>       */
> >> -    c =3D kmalloc_slab(size, GFP_KERNEL, 0);
> >> -    return c ? c->object_size : 0;
> >> +    return size;
> >> +
> >>  }
> >>  EXPORT_SYMBOL(kmalloc_size_roundup);
> >>
> >> --
> >> 2.42.0
> >>
> >>
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)
>
