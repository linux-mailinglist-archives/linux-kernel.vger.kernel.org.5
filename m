Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB462783098
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjHUS67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjHUS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:58:57 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3323618F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:58:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a7d4030621so2193548b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692644278; x=1693249078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgTryES813gEuXUnIgi236ML21K1l0hM6GHsZBUw57Y=;
        b=vAGzobRJnMFGgEU19XWoM+BaIci+TjqU/2ywuL3a2qdCUTtP2lXdlvBuIuIRrG/feG
         b+voPwntRD6ttf/xooN6bVXYBDMrleIfrpykGXay1hKOD1RGf04NomcsKs2e0lvbM6i9
         Yw8i5WznovSMGMqQZsvAh5h1xN8B6M2u2TlzHTxrq8Gm3aUBic/eMZN8nqdSQziZXYRF
         HQJemUJvArA/whVaRtwRYV5N9TDdLNwsCvsQXUGda0xEW4gqwLT/WgUoChm7fgTQuVuk
         BHY0MC0/w+0vokEGUH+9poYS97VQioXKLe7aNoTE1VW13035evT8aFtvraeDb4tg4zen
         JcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692644278; x=1693249078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgTryES813gEuXUnIgi236ML21K1l0hM6GHsZBUw57Y=;
        b=SE3L7H7tcplS9/7cAx/iijr5YOfseBPElD77BGX5H9tyr6BdyulfXNfvE85T44/jS5
         bF3JVWRfPNKyj9tDblZ5XbhHMrgxsjdiQCKQXrc82CTa3QpDmtifQ17cFZrmVruzI8r0
         01H+Y3cBixWol7X07oUQx3wrnMaA0g2dAh2sxuUZNPFaWK4Py9+tnRWilCEl8BDrRtDX
         JITuJBeYC+4gDzYO5aDmVYmRpzq91ziQKBPBjuaim/77imigTWJxkATZVtmC5/C2dJhN
         XYDWoVG9pRkC9wtEe66ft1AHBcTQX1V1t3XTODnC6oGG4Qhb7OyAkAr/UX4NdSjgWW94
         cWuw==
X-Gm-Message-State: AOJu0Yw58yU7WnOEs657KVfWYilByAkLZMitGr0y8So4ZL+wqzOClKi1
        NJMsGI5vDhrOVzGW9T9DX6H+RKqBmzetLLfb0L2y0Soz+Lod/FLzimw=
X-Google-Smtp-Source: AGHT+IGymFpqmfPxww3WyclMwt/aMTb/zaJpegHEhSEBMzR9V7QboBy4Zu2DsxM5KaHEt8jGzPgMY0dBzHh+Zl3OpGA=
X-Received: by 2002:a05:6122:311f:b0:48f:8891:29d9 with SMTP id
 cg31-20020a056122311f00b0048f889129d9mr380951vkb.13.1692643479268; Mon, 21
 Aug 2023 11:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230820224800.3905291-1-masahiroy@kernel.org>
In-Reply-To: <20230820224800.3905291-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Aug 2023 11:44:27 -0700
Message-ID: <CAKwvOd=OpBdu70JucO9tQekRRHsRFj4M8hci-udLaMQKyfFJEw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: merge list.h in modpost and kconfig
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 3:48=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Move scripts/mod/list.h to scripts/include/list.h and remove
> scripts/kconfig/list.h. This removes the code duplication between
> scripts/mod/list.h and scripts/kconfig/list.h.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  Makefile                        |   2 +-
>  scripts/{mod =3D> include}/list.h |   0
>  scripts/kconfig/expr.h          |   3 +-
>  scripts/kconfig/list.h          | 132 --------------------------------
>  scripts/kconfig/preprocess.c    |   2 +-
>  scripts/mod/modpost.h           |   2 +-
>  6 files changed, 5 insertions(+), 136 deletions(-)
>  rename scripts/{mod =3D> include}/list.h (100%)
>  delete mode 100644 scripts/kconfig/list.h
>
> diff --git a/Makefile b/Makefile
> index 4382cdb38fba..5434e093d086 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -469,7 +469,7 @@ export rust_common_flags :=3D --edition=3D2021 \
>                             -Dclippy::needless_continue \
>                             -Wclippy::dbg_macro
>
> -KBUILD_HOSTCFLAGS   :=3D $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $(H=
OSTCFLAGS)
> +KBUILD_HOSTCFLAGS   :=3D $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $(H=
OSTCFLAGS) -I $(srctree)/scripts/include
>  KBUILD_HOSTCXXFLAGS :=3D -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
>  KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo \
>                         -Zallow-features=3D $(HOSTRUSTFLAGS)
> diff --git a/scripts/mod/list.h b/scripts/include/list.h
> similarity index 100%
> rename from scripts/mod/list.h
> rename to scripts/include/list.h
> diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
> index 4a9a23b1b7e1..8f46c079fa98 100644
> --- a/scripts/kconfig/expr.h
> +++ b/scripts/kconfig/expr.h
> @@ -12,11 +12,12 @@ extern "C" {
>
>  #include <assert.h>
>  #include <stdio.h>
> -#include "list.h"
>  #ifndef __cplusplus
>  #include <stdbool.h>
>  #endif
>
> +#include <list.h>
> +
>  struct file {
>         struct file *next;
>         struct file *parent;
> diff --git a/scripts/kconfig/list.h b/scripts/kconfig/list.h
> deleted file mode 100644
> index 45cb237ab7ef..000000000000
> --- a/scripts/kconfig/list.h
> +++ /dev/null
> @@ -1,132 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LIST_H
> -#define LIST_H
> -
> -/*
> - * Copied from include/linux/...
> - */
> -
> -#undef offsetof
> -#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
> -
> -/**
> - * container_of - cast a member of a structure out to the containing str=
ucture
> - * @ptr:        the pointer to the member.
> - * @type:       the type of the container struct this is embedded in.
> - * @member:     the name of the member within the struct.
> - *
> - */
> -#define container_of(ptr, type, member) ({                      \
> -       const typeof( ((type *)0)->member ) *__mptr =3D (ptr);    \
> -       (type *)( (char *)__mptr - offsetof(type,member) );})
> -
> -
> -struct list_head {
> -       struct list_head *next, *prev;
> -};
> -
> -
> -#define LIST_HEAD_INIT(name) { &(name), &(name) }
> -
> -#define LIST_HEAD(name) \
> -       struct list_head name =3D LIST_HEAD_INIT(name)
> -
> -/**
> - * list_entry - get the struct for this entry
> - * @ptr:       the &struct list_head pointer.
> - * @type:      the type of the struct this is embedded in.
> - * @member:    the name of the list_head within the struct.
> - */
> -#define list_entry(ptr, type, member) \
> -       container_of(ptr, type, member)
> -
> -/**
> - * list_for_each_entry -       iterate over list of given type
> - * @pos:       the type * to use as a loop cursor.
> - * @head:      the head for your list.
> - * @member:    the name of the list_head within the struct.
> - */
> -#define list_for_each_entry(pos, head, member)                         \
> -       for (pos =3D list_entry((head)->next, typeof(*pos), member);     =
 \
> -            &pos->member !=3D (head);    \
> -            pos =3D list_entry(pos->member.next, typeof(*pos), member))
> -
> -/**
> - * list_for_each_entry_safe - iterate over list of given type safe again=
st removal of list entry
> - * @pos:       the type * to use as a loop cursor.
> - * @n:         another type * to use as temporary storage
> - * @head:      the head for your list.
> - * @member:    the name of the list_head within the struct.
> - */
> -#define list_for_each_entry_safe(pos, n, head, member)                 \
> -       for (pos =3D list_entry((head)->next, typeof(*pos), member),     =
 \
> -               n =3D list_entry(pos->member.next, typeof(*pos), member);=
 \
> -            &pos->member !=3D (head);                                   =
 \
> -            pos =3D n, n =3D list_entry(n->member.next, typeof(*n), memb=
er))
> -
> -/**
> - * list_empty - tests whether a list is empty
> - * @head: the list to test.
> - */
> -static inline int list_empty(const struct list_head *head)
> -{
> -       return head->next =3D=3D head;
> -}
> -
> -/*
> - * Insert a new entry between two known consecutive entries.
> - *
> - * This is only for internal list manipulation where we know
> - * the prev/next entries already!
> - */
> -static inline void __list_add(struct list_head *_new,
> -                             struct list_head *prev,
> -                             struct list_head *next)
> -{
> -       next->prev =3D _new;
> -       _new->next =3D next;
> -       _new->prev =3D prev;
> -       prev->next =3D _new;
> -}
> -
> -/**
> - * list_add_tail - add a new entry
> - * @new: new entry to be added
> - * @head: list head to add it before
> - *
> - * Insert a new entry before the specified head.
> - * This is useful for implementing queues.
> - */
> -static inline void list_add_tail(struct list_head *_new, struct list_hea=
d *head)
> -{
> -       __list_add(_new, head->prev, head);
> -}
> -
> -/*
> - * Delete a list entry by making the prev/next entries
> - * point to each other.
> - *
> - * This is only for internal list manipulation where we know
> - * the prev/next entries already!
> - */
> -static inline void __list_del(struct list_head *prev, struct list_head *=
next)
> -{
> -       next->prev =3D prev;
> -       prev->next =3D next;
> -}
> -
> -#define LIST_POISON1  ((void *) 0x00100100)
> -#define LIST_POISON2  ((void *) 0x00200200)
> -/**
> - * list_del - deletes entry from list.
> - * @entry: the element to delete from the list.
> - * Note: list_empty() on entry does not return true after this, the entr=
y is
> - * in an undefined state.
> - */
> -static inline void list_del(struct list_head *entry)
> -{
> -       __list_del(entry->prev, entry->next);
> -       entry->next =3D (struct list_head*)LIST_POISON1;
> -       entry->prev =3D (struct list_head*)LIST_POISON2;
> -}
> -#endif
> diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
> index 748da578b418..cc2d5d26185d 100644
> --- a/scripts/kconfig/preprocess.c
> +++ b/scripts/kconfig/preprocess.c
> @@ -9,7 +9,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>
> -#include "list.h"
> +#include <list.h>
>  #include "lkc.h"
>
>  #define ARRAY_SIZE(arr)                (sizeof(arr) / sizeof((arr)[0]))
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 5f94c2c9f2d9..4ebc053cc68f 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -11,7 +11,7 @@
>  #include <unistd.h>
>  #include <elf.h>
>
> -#include "list.h"
> +#include <list.h>
>  #include "elfconfig.h"
>
>  /* On BSD-alike OSes elf.h defines these according to host's word size *=
/
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
