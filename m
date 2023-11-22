Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB707F3BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343531AbjKVC2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVC2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:28:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B25D181
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 18:28:07 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5bdfbd69bd5so293979a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 18:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700620086; x=1701224886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfTZswEnYt7aHpTJOx6kD98hPK28QoQ/YumgrlaBkC0=;
        b=OXfctwb/OBD7DmyLLb/FWMN2y5kt0CnWvyEREsI2qkUvMWxN+qt9ruicGSjJZzQ73n
         vi+bimiFrsEmX/Hy7TSOWbJSTGEiUXPl9HgKh4f26Skj233R+8vmB64mb9E5U6LIOKh0
         gfVZPcGVqMk+s+jRML0Q65O4YqRBb0JrBJ1/NlUy7jdXdSNfdmRdU30IcujQcW1QFgDi
         FT1jjM3QqofizLQfWo0W81ZZmt07cU7eOiqXdID3F+vWCneEkyyIqnBN6R6bLanBYRRY
         SSeFzCM9lmVHHir6fV/cnCWp6kUvPAfjYQf5LGL1eGKzZXP+MlyHs5r2c97L/gwuhGYE
         xykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700620086; x=1701224886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfTZswEnYt7aHpTJOx6kD98hPK28QoQ/YumgrlaBkC0=;
        b=C8sf1b1fSp53io0IdDDEa72F9fxg8mWcA8osq96wHZFM/3fiv18T3wMXBh+yqNdGR5
         Vn12pYI3iW0uqRra8Y1bvXqQYegPhav7zEBweG8Epp3MFeSeQ5MU/D81rhjLhlSzoGX6
         vTmQ5K4SsoH/OSD+EcQF/OUbInQRfY167Myw06uudl9ZPcnbBV+UW9vk1BOlQ2rySAkp
         +xKy4VCgveU6OEA/REgTXYm8hjwBfn99M25OQAlNWU/UhiT1iFtpEihp1e2MaPfrBHv9
         8KYeSbEorxQuOzF9Jw/JznzJuHzVMwBcbJQ17kI46oRHi4gioHGdxHSg3wuy6w2ezIse
         rsnw==
X-Gm-Message-State: AOJu0YyVYiGB4lQ0+xVsgyEb4kmBqPMn0Ss/O3VSR9UDkeIBQKtcKw6S
        yq+yayns8ALamZqpOiZp4jkhSYib0FPEOY5Mx+w=
X-Google-Smtp-Source: AGHT+IHAMQ+tOeNRO2k3sRkUVDLcsPWJuo4/OHgwq3ka2J+5TxYjwdPReGcf9/rYE3eK82vEcdhwoQgJh8lBrOuobi0=
X-Received: by 2002:a17:90a:fe90:b0:280:4a23:3c84 with SMTP id
 co16-20020a17090afe9000b002804a233c84mr6491607pjb.22.1700620086495; Tue, 21
 Nov 2023 18:28:06 -0800 (PST)
MIME-Version: 1.0
References: <VI1P193MB0752C0ADCF4F90AE8368C0B399BBA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB0752C0ADCF4F90AE8368C0B399BBA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 22 Nov 2023 03:27:55 +0100
Message-ID: <CA+fCnZfBM=UU0AyArERNMxBMeaPvbV-e6uyQDpwgqA5c6_f_DQ@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: Improve free meta storage in Generic KASAN
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:42=E2=80=AFPM Juntong Deng <juntong.deng@outlook=
.com> wrote:
>
> Currently free meta can only be stored in object if the object is
> not smaller than free meta.
>
> After the improvement, even when the object is smaller than free meta,
> it is still possible to store part of the free meta in the object,
> reducing the increased size of the redzone.
>
> Example:
>
> free meta size: 16 bytes
> alloc meta size: 16 bytes
> object size: 8 bytes
> optimal redzone size (object_size <=3D 64): 16 bytes
>
> Before improvement:
> actual redzone size =3D alloc meta size + free meta size =3D 32 bytes
>
> After improvement:
> actual redzone size =3D alloc meta size + (free meta size - object size)
>                     =3D 24 bytes
>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

I think this change as is does not work well with slub_debug.

slub_debug puts its metadata (redzone, tracks, and orig_size) right
after the object (see calculate_sizes and the comment before
check_pad_bytes). With the current code, KASAN's free meta either fits
within the object or is placed after the slub_debug metadata and
everything works well. With this change, KASAN's free meta tail goes
right past object_size, overlaps with the slub_debug metadata, and
thus can corrupt it.

Thus, to make this patch work properly, we need to carefully think
about all metadatas layout and teach slub_debug that KASAN's free meta
can go past object_size. Possibly, adjusting s->inuse by the size of
KASAN's metas (along with moving kasan_cache_create and fixing up
set_orig_size) would be enough. But I'm not familiar with the
slub_debug code enough to be sure.

If you decide to proceed with improving this change, I've left some
comments for the current code below.

Thank you!

> ---
> V1 -> V2: Make kasan_metadata_size() adapt to the improved
> free meta storage
>
>  mm/kasan/generic.c | 50 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 16 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 4d837ab83f08..802c738738d7 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -361,6 +361,8 @@ void kasan_cache_create(struct kmem_cache *cache, uns=
igned int *size,
>  {
>         unsigned int ok_size;
>         unsigned int optimal_size;
> +       unsigned int rem_free_meta_size;
> +       unsigned int orig_alloc_meta_offset;
>
>         if (!kasan_requires_meta())
>                 return;
> @@ -394,6 +396,9 @@ void kasan_cache_create(struct kmem_cache *cache, uns=
igned int *size,
>                 /* Continue, since free meta might still fit. */
>         }
>
> +       ok_size =3D *size;
> +       orig_alloc_meta_offset =3D cache->kasan_info.alloc_meta_offset;
> +
>         /*
>          * Add free meta into redzone when it's not possible to store
>          * it in the object. This is the case when:
> @@ -401,21 +406,26 @@ void kasan_cache_create(struct kmem_cache *cache, u=
nsigned int *size,
>          *    be touched after it was freed, or
>          * 2. Object has a constructor, which means it's expected to
>          *    retain its content until the next allocation, or

Please drop "or" on the line above.

> -        * 3. Object is too small.
>          * Otherwise cache->kasan_info.free_meta_offset =3D 0 is implied.
> +        * Even if the object is smaller than free meta, it is still
> +        * possible to store part of the free meta in the object.
>          */
> -       if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
> -           cache->object_size < sizeof(struct kasan_free_meta)) {
> -               ok_size =3D *size;
> -
> +       if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
>                 cache->kasan_info.free_meta_offset =3D *size;
>                 *size +=3D sizeof(struct kasan_free_meta);
> +       } else if (cache->object_size < sizeof(struct kasan_free_meta)) {
> +               rem_free_meta_size =3D sizeof(struct kasan_free_meta) -
> +                                                               cache->ob=
ject_size;
> +               *size +=3D rem_free_meta_size;
> +               if (cache->kasan_info.alloc_meta_offset !=3D 0)
> +                       cache->kasan_info.alloc_meta_offset +=3D rem_free=
_meta_size;
> +       }
>
> -               /* If free meta doesn't fit, don't add it. */
> -               if (*size > KMALLOC_MAX_SIZE) {
> -                       cache->kasan_info.free_meta_offset =3D KASAN_NO_F=
REE_META;
> -                       *size =3D ok_size;
> -               }
> +       /* If free meta doesn't fit, don't add it. */
> +       if (*size > KMALLOC_MAX_SIZE) {
> +               cache->kasan_info.free_meta_offset =3D KASAN_NO_FREE_META=
;
> +               cache->kasan_info.alloc_meta_offset =3D orig_alloc_meta_o=
ffset;
> +               *size =3D ok_size;
>         }
>
>         /* Calculate size with optimal redzone. */
> @@ -464,12 +474,20 @@ size_t kasan_metadata_size(struct kmem_cache *cache=
, bool in_object)
>         if (in_object)
>                 return (info->free_meta_offset ?
>                         0 : sizeof(struct kasan_free_meta));

This needs to be changed as well to something like min(cache->object,
sizeof(struct kasan_free_meta)). However, with the slub_debug
conflicts I mentioned above, we might need to change this to something
else.



> -       else
> -               return (info->alloc_meta_offset ?
> -                       sizeof(struct kasan_alloc_meta) : 0) +
> -                       ((info->free_meta_offset &&
> -                       info->free_meta_offset !=3D KASAN_NO_FREE_META) ?
> -                       sizeof(struct kasan_free_meta) : 0);
> +       else {
> +               size_t alloc_meta_size =3D info->alloc_meta_offset ?
> +                                                               sizeof(st=
ruct kasan_alloc_meta) : 0;
> +               size_t free_meta_size =3D 0;
> +
> +               if (info->free_meta_offset !=3D KASAN_NO_FREE_META) {
> +                       if (info->free_meta_offset)
> +                               free_meta_size =3D sizeof(struct kasan_fr=
ee_meta);
> +                       else if (cache->object_size < sizeof(struct kasan=
_free_meta))
> +                               free_meta_size =3D sizeof(struct kasan_fr=
ee_meta) -
> +                                                                       c=
ache->object_size;
> +               }
> +               return alloc_meta_size + free_meta_size;
> +       }
>  }
>
>  static void __kasan_record_aux_stack(void *addr, bool can_alloc)
> --
> 2.39.2
