Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBBF7AE074
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjIYUvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIYUvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:51:12 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BDFBE;
        Mon, 25 Sep 2023 13:51:02 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-452749f6c47so3012934137.1;
        Mon, 25 Sep 2023 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695675061; x=1696279861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLT6JXItUdbK8gpxFGKaP+4imC55Y5aPeSLP42utcRg=;
        b=cmWD1mGvN7sErs2tS/1bN+B+MK571qiF4jvgVA90LliVrxm23l7qEkfvoBcyEGAuWS
         hSKLAk0hXpoZ8H18ZjJH2m1S9100FIg+NC6n45dYIpogL5+yJTkhtxpF3cJ50CHnJOYs
         BjMcDlxXMbfl09PXN3SVf4iwAk8xe23rlSH3CPdNh8VIvMK7ei+1ynHwGthgRLfuGdBC
         gnhbp/d1i5a8ZLDlnPcr8QBhjwGUr8shPvQP7rZRW+u5vx6pNG+h6qg8hTnfVF2KIRVl
         BPaEcLspSh8PYpMkVclmdVzRhI6K0Zf81tF9kfxT3XXLGy/Adcro7HUwVQfYTqAKUXpy
         eZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695675061; x=1696279861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLT6JXItUdbK8gpxFGKaP+4imC55Y5aPeSLP42utcRg=;
        b=vktlfilba1A4t7Pt0JR1ma+0FeIcfITioYiej3ibhHinyy5TG+HuzB3LXiRaPkW5X0
         ZfkHZGsu9LRw08yN4L9nI3UgoNuqGPMbK4vkfVznMt1MjmChGiUtFcIQzJ8+GezM2ca1
         +Q76L86DvkplbJDGk6Uir/KzmKvUVqLTfGiUlxdj4VUQMKMQ6MTeErTNP1E8qAyXK3W9
         gA7YSYUoibjyEy1b0Jt0Ap11Sgorvz0FR2QB6t08fxy+/j3ER/Smnmp61Ssotkt1I7wS
         xcoy9aB2zCIODDsB7LdKJrcKwMXUwUgGKleOZQ/DscCY6wB+wyQKKSg8V03E5ju3c1nl
         UKLg==
X-Gm-Message-State: AOJu0Yya3yRBFk701yqYfudehGpeL9B8vpXP8WkWr3JoiByVwqn79ADY
        MFu6K9WykOuFBkQCeifccC7A9UvxNHAt+0EEFrg=
X-Google-Smtp-Source: AGHT+IGfAvQ8kf3O9EjKf5AXzCA7Xf27mHHDDDAsYtLOnBY50Vko+gP8W+3Arhov0vTpCnY4rfIvw5rvelnJEfRIN+8=
X-Received: by 2002:a05:6102:2e4:b0:44d:48bf:591c with SMTP id
 j4-20020a05610202e400b0044d48bf591cmr5309437vsj.30.1695675061205; Mon, 25 Sep
 2023 13:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
 <65105d3a8e70e_12c73e29410@willemb.c.googlers.com.notmuch> <f705117e-41dd-cb2f-ed06-6c47876fd6a2@wanadoo.fr>
In-Reply-To: <f705117e-41dd-cb2f-ed06-6c47876fd6a2@wanadoo.fr>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 25 Sep 2023 22:50:24 +0200
Message-ID: <CAF=yD-+8Q19sO4XC0dNSiYWSCj03rS9tfV+mVjvZOBnnwpnS5g@mail.gmail.com>
Subject: Re: [PATCH net-next] udp_tunnel: Use flex array to simplify code
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 6:26=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 24/09/2023 =C3=A0 18:00, Willem de Bruijn a =C3=A9crit :
> > Christophe JAILLET wrote:
> >> 'n_tables' is small, UDP_TUNNEL_NIC_MAX_TABLES       =3D 4 as a maximu=
m. So there
> >> is no real point to allocate the 'entries' pointers array with a dedic=
ate
> >> memory allocation.
> >>
> >> Using a flexible array for struct udp_tunnel_nic->entries avoids the
> >> overhead of an additional memory allocation.
> >>
> >> This also saves an indirection when the array is accessed.
> >>
> >> Finally, __counted_by() can be used for run-time bounds checking if
> >> configured and supported by the compiler.
> >>
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> >> ---
> >>   net/ipv4/udp_tunnel_nic.c | 11 ++---------
> >>   1 file changed, 2 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> >> index 029219749785..b6d2d16189c0 100644
> >> --- a/net/ipv4/udp_tunnel_nic.c
> >> +++ b/net/ipv4/udp_tunnel_nic.c
> >> @@ -47,7 +47,7 @@ struct udp_tunnel_nic {
> >>
> >>      unsigned int n_tables;
> >>      unsigned long missed;
> >> -    struct udp_tunnel_nic_table_entry **entries;
> >> +    struct udp_tunnel_nic_table_entry *entries[] __counted_by(n_table=
s);
> >>   };
> >>
> >>   /* We ensure all work structs are done using driver state, but not t=
he code.
> >> @@ -725,16 +725,12 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic=
_info *info,
> >>      struct udp_tunnel_nic *utn;
> >>      unsigned int i;
> >>
> >> -    utn =3D kzalloc(sizeof(*utn), GFP_KERNEL);
> >> +    utn =3D kzalloc(struct_size(utn, entries, n_tables), GFP_KERNEL);
> >>      if (!utn)
> >>              return NULL;
> >>      utn->n_tables =3D n_tables;
> >
> > Should utn->n_tables be initialized before first use of
> > struct_size(utn, entries, n_tables)?
> >
>
> It can't be.
> struct_size() is used to compute the memory size to allocate.
>
> Before the kzalloc() call, utn does not exist, so we can't write
> anything to utn->n_tables. It is undefined at this point.
>
> It is initialized the line just after, after the allocation, but before
> any use.

Of course, sorry. I confused __counted_by's reference to a field
member in the struct, with the normal argument passing of struct_size
and flex_array_size.
