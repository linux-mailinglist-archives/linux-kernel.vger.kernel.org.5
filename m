Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65A076229A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGYTrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGYTrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:47:21 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079871FF5;
        Tue, 25 Jul 2023 12:47:20 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d1c988afebfso153481276.2;
        Tue, 25 Jul 2023 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690314439; x=1690919239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeJhTxpV2KdMMMSZLbWge8qm6rDJ0HM+acsXY0ytlKU=;
        b=PA8xavyt2HOc4k97SAdgucxOUb3/+ImBN0gn0fioaV5W7ZXer4eSAu5M8BGv/3eRWE
         zhnXJU6OHzjfhVfABYLNdRTWxq9A4xYiX8Wl7v0rzzay3LYVquG2a2RScYvOEUTRwekI
         KUz+Tafe9+FElePdyBczThkkG5IMK7Blre42rTJRxXJq/D4uA6AXbwc8KwenybeJFBds
         DsyMMNByA8XSUg7+L2E9pMBEmzBUnOjShg/Au8+v527dXfAPrUNKtHGs/Dcee8wTQXVH
         rYlTVSWNHl6ldbo60kazW5+mQ+scbOdGhCsm7oA7erwxmacAdo/1TzyV6akyg/SQw7lX
         xF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690314439; x=1690919239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeJhTxpV2KdMMMSZLbWge8qm6rDJ0HM+acsXY0ytlKU=;
        b=M3mP1cYpH8BFNzGeaixrNOxOuit1OyGwgIrlplbbifNovroOiS+JfRLB2EJhpwsYMo
         8sSAVs92KjnBnkuexFXnMqgPBquMIDujRFZWd/6c8Ovbdp3kzS1oymsyhTYEdIdvx8jn
         fNraJB945L+llzYX5/Q95ICJcYlMvs3D1Vbc+4qsgCrrOhK3bhgihPgn+Mh3ODKw9cm0
         Bc5JQWvlyVX5Cz3Fm1RkMRYtSavkpS2tXLoBTA5PYU3rLMEgj7N3j73M8fLY7CLgKQ6r
         HRdTuIzTWsgbJPQ7K/H3+hAGsfJ+vQVB3DonjDf51J6VBIZcuhDTG7sDdkPJcLh3ZSOK
         GMKw==
X-Gm-Message-State: ABy/qLb57eKvjiP9B6R9F1MicVyn1OVDE3kv05Sb6EGC7OwIJ1Rop8Fj
        BwQpJkSJ9MmX0vfF7MNLTGUvg7CXwLvxfwyFGQg=
X-Google-Smtp-Source: APBJJlH3O1N0+A/LhmIX/UCjjCLprcxDzwP9u1Pgqo1ZYHVk7bomcjWnNWvdljBnCzytABCnQ5kTgfY4xxBUvevldvs=
X-Received: by 2002:a25:2986:0:b0:d06:66be:b22 with SMTP id
 p128-20020a252986000000b00d0666be0b22mr9621709ybp.19.1690314439137; Tue, 25
 Jul 2023 12:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230725183646.5668-1-pchelkin@ispras.ru>
In-Reply-To: <20230725183646.5668-1-pchelkin@ispras.ru>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 25 Jul 2023 15:46:57 -0400
Message-ID: <CADvbK_dN4Z3kOqmJcNcUGHp56KLF87tKLHt-3BNbyRa=QOR0dw@mail.gmail.com>
Subject: Re: [PATCH] tipc: stop tipc crypto on failure in tipc_node_create
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
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

On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> If tipc_link_bc_create() fails inside tipc_node_create() for a newly
> allocated tipc node then we should stop its tipc crypto and free the
> resources allocated with a call to tipc_crypto_start().
>
> Call tipc_crypto_stop() in that case. Also extract the similar error exit
> paths into a goto statement.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: cb8092d70a6f ("tipc: move bc link creation back to tipc_node_creat=
e")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  net/tipc/node.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 5e000fde8067..0d64005a803b 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -546,9 +546,7 @@ struct tipc_node *tipc_node_create(struct net *net, u=
32 addr, u8 *peer_id,
>  #ifdef CONFIG_TIPC_CRYPTO
>         if (unlikely(tipc_crypto_start(&n->crypto_rx, net, n))) {
>                 pr_warn("Failed to start crypto RX(%s)!\n", n->peer_id_st=
ring);
> -               kfree(n);
> -               n =3D NULL;
> -               goto exit;
> +               goto free_node;
>         }
>  #endif
>         n->addr =3D addr;
> @@ -583,9 +581,7 @@ struct tipc_node *tipc_node_create(struct net *net, u=
32 addr, u8 *peer_id,
>                                  n->capabilities, &n->bc_entry.inputq1,
>                                  &n->bc_entry.namedq, snd_l, &n->bc_entry=
.link)) {
>                 pr_warn("Broadcast rcv link creation failed, no memory\n"=
);
> -               kfree(n);
> -               n =3D NULL;
> -               goto exit;
> +               goto stop_crypto;
>         }
>         tipc_node_get(n);
Can you please try moving up tipc_node_get(n) ahead tipc_link_bc_create()
and use tipc_node_put(n) to replace kfree(n) to avoid the extra
tipc_crypto_stop() call below?

Thanks.

>         timer_setup(&n->timer, tipc_node_timeout, 0);
> @@ -610,6 +606,15 @@ struct tipc_node *tipc_node_create(struct net *net, =
u32 addr, u8 *peer_id,
>  exit:
>         spin_unlock_bh(&tn->node_list_lock);
>         return n;
> +stop_crypto:
> +
> +#ifdef CONFIG_TIPC_CRYPTO
> +       tipc_crypto_stop(&n->crypto_rx);
> +free_node:
> +#endif
> +       kfree(n);
> +       spin_unlock_bh(&tn->node_list_lock);
> +       return NULL;
>  }
>
>  static void tipc_node_calculate_timer(struct tipc_node *n, struct tipc_l=
ink *l)
> --
> 2.41.0
>
