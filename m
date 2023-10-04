Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698247B8362
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243161AbjJDPRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242998AbjJDPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:17:06 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5EEBF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:17:02 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a1ec43870cso27314037b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696432622; x=1697037422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN5WIKysaV095JDrkaH6KFl3bMCNfb4hE0xbNlkR+WI=;
        b=SLahdtkpCZ9uSW+lkZcC0ktV27g4x3ZaI/QYdA5LOmuNbMVnQmW3kpO3nsZFC5QB5j
         PeZb209MDBo/EY1t/x+G2MT9I8+/7qEYCRnB7J4jJANnmF0AsYboTrl6PSaSSlLyg5aD
         82nFzpXWyCTQLeWtj41lT6nagnEgbQOK57lbNS3C8RgO0t2J0ghKKWNvWAhVZwc6F/QZ
         jfk3kRRwTwImafpER0s5p8cOrh+BTag294qXqagS+RhofuWcsKLdSZKgOfjoN1s8T67o
         Ps0vnooYJ5FoMVu9/MfRpyJr20qzSIjWIPn1CxIrDgaxyi9BKOPMCoD5woPP8zmi9LO8
         /o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432622; x=1697037422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN5WIKysaV095JDrkaH6KFl3bMCNfb4hE0xbNlkR+WI=;
        b=lDRu6PtxSX/CwLIHBlO6fbYzg/asuPr99y/GA3gqFaIdiNT+4iE2RA8J71X4znoInN
         4E1bfGdMMR5IhUitKMYg/ds4fc886m3RMouC/bEmHFlaszI8vYIMjuF82x81b9OS2qQy
         YG3udTGQtOL1DpoMbZ8vxH8O71JaKLwIlMynI2BT7WvtPK0bAWt0ols7w//lRWh2puT1
         L4vdyf33hw+PQ1M+2HOhrT45kaLTjZPO2/ldeKyVRB/PswMGTdJ2hoO6qYWLE0XGy8Oh
         wX+9oSDRYRE7sx0N9l8kPcm6GGxXPM6GT73b9LqO1D04dvmjp9q4Nl8FeUjPTMjZU96C
         /kWQ==
X-Gm-Message-State: AOJu0YxWgF76op05Orxg74e1yjQzbdq3mMCdNgwqjZUbXXE1x/L1OprE
        3iuL0r6W9U5R0d2IEKjds8z/gIbxM4JNVsqSMsU8VPu8+ZMM6iRG
X-Google-Smtp-Source: AGHT+IF3gOIOHwzY/EJ4UEawivz5g6FcqEZ4tBc3cxlP5IfgeoL3y+aonS5/cF9+D+3yxBLVKvrpO4rH7ZRnIHAw2Z4=
X-Received: by 2002:a05:6902:188e:b0:d78:be:6f02 with SMTP id
 cj14-20020a056902188e00b00d7800be6f02mr2507137ybb.11.1696432622042; Wed, 04
 Oct 2023 08:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZR1maZoAh2W/0Vw6@work>
In-Reply-To: <ZR1maZoAh2W/0Vw6@work>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 4 Oct 2023 11:16:50 -0400
Message-ID: <CAM0EoMkMfvpmxkcSyqC0dOLKDH8_JiJ74u06x7sqUHSehgjOtQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: sched: cls_u32: Fix allocation size in u32_init()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 9:19=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> commit d61491a51f7e ("net/sched: cls_u32: Replace one-element array
> with flexible-array member") incorrecly replaced an instance of
> `sizeof(*tp_c)` with `struct_size(tp_c, hlist->ht, 1)`. This results
> in a an over-allocation of 8 bytes.
>
> This change is wrong because `hlist` in `struct tc_u_common` is a
> pointer:
>
> net/sched/cls_u32.c:
> struct tc_u_common {
>         struct tc_u_hnode __rcu *hlist;
>         void                    *ptr;
>         int                     refcnt;
>         struct idr              handle_idr;
>         struct hlist_node       hnode;
>         long                    knodes;
> };
>
> So, the use of `struct_size()` makes no sense: we don't need to allocate
> any extra space for a flexible-array member. `sizeof(*tp_c)` is just fine=
.
>
> So, `struct_size(tp_c, hlist->ht, 1)` translates to:
>
> sizeof(*tp_c) + sizeof(tp_c->hlist->ht) =3D=3D
> sizeof(struct tc_u_common) + sizeof(struct tc_u_knode *) =3D=3D
>                                                 144 + 8  =3D=3D 0x98 (bye=
s)
>                                                      ^^^
>                                                       |
>                                                 unnecessary extra
>                                                 allocation size
>
> $ pahole -C tc_u_common net/sched/cls_u32.o
> struct tc_u_common {
>         struct tc_u_hnode *        hlist;                /*     0     8 *=
/
>         void *                     ptr;                  /*     8     8 *=
/
>         int                        refcnt;               /*    16     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct idr                 handle_idr;           /*    24    96 *=
/
>         /* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
>         struct hlist_node          hnode;                /*   120    16 *=
/
>         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
>         long int                   knodes;               /*   136     8 *=
/
>
>         /* size: 144, cachelines: 3, members: 6 */
>         /* sum members: 140, holes: 1, sum holes: 4 */
>         /* last cacheline: 16 bytes */
> };
>
> And with `sizeof(*tp_c)`, we have:
>
>         sizeof(*tp_c) =3D=3D sizeof(struct tc_u_common) =3D=3D 144 =3D=3D=
 0x90 (bytes)
>
> which is the correct and original allocation size.
>
> Fix this issue by replacing `struct_size(tp_c, hlist->ht, 1)` with
> `sizeof(*tp_c)`, and avoid allocating 8 too many bytes.
>
> The following difference in binary output is expected and reflects the
> desired change:
>
> | net/sched/cls_u32.o
> | @@ -6148,7 +6148,7 @@
> | include/linux/slab.h:599
> |     2cf5:      mov    0x0(%rip),%rdi        # 2cfc <u32_init+0xfc>
> |                        2cf8: R_X86_64_PC32     kmalloc_caches+0xc
> |-    2cfc:      mov    $0x98,%edx
> |+    2cfc:      mov    $0x90,%edx
>
> Reported-by: Alejandro Colomar <alx@kernel.org>
> Closes: https://lore.kernel.org/lkml/09b4a2ce-da74-3a19-6961-67883f634d98=
@kernel.org/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> Changes in v2:
>  - Update subject line.
>  - Update changelog text.
>
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZN5DvRyq6JNz20l1@work/
>
>  net/sched/cls_u32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index da4c179a4d41..6663e971a13e 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -366,7 +366,7 @@ static int u32_init(struct tcf_proto *tp)
>         idr_init(&root_ht->handle_idr);
>
>         if (tp_c =3D=3D NULL) {
> -               tp_c =3D kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KER=
NEL);
> +               tp_c =3D kzalloc(sizeof(*tp_c), GFP_KERNEL);
>                 if (tp_c =3D=3D NULL) {
>                         kfree(root_ht);
>                         return -ENOBUFS;
> --
> 2.34.1
>
