Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB372802077
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 03:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjLCCuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 21:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCCuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 21:50:18 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C2011F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 18:50:24 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54c77e0832cso1311087a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 18:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701571823; x=1702176623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6npRnsWkqBdhZbc6M4dSByEnWkDw3CX1ntQyh6JSYSY=;
        b=AdS/7VcxZKbx5RzVBPV5c6c0Ffp/QG+7hcDVPDyLONNrUV7cx5JYB6b5bCuFiJrrK6
         YygSawS6eE5K+jeEmi0iDgcbciMewPuLekLfCQsx58r833Brjg+TNihge5pOdlhYnG6Z
         x5JN5ol2W6aGTaj/3DJh2VsLsAOYw7VBs+epvoa46jjT53g23Y8mP60ci9IaLlvnJTW7
         uBfK2YIMhbnH/1EBUx8Fwj8Tvq+fGKIiuqRZE6OBHI0rODKZL8D4NwuBybGQVPT2fyz3
         sSbAH3Mk/KpygfcMz/SluGnHYizZhVaWi6HoC68/xCBC1M25UpbDY/34uWQWD6KF1fVa
         +0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701571823; x=1702176623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6npRnsWkqBdhZbc6M4dSByEnWkDw3CX1ntQyh6JSYSY=;
        b=Ac/8qQJci87RdGZA2Z85i+vCtjKqoZ25NBOoQ6ysJBfmvC/5NQLT0QPsJsMmx1ra/7
         2jFHUNAhQYsFzZ8tOU2nMbQy9xrhjhqeV4Z7Yg3GYtBvJcDqEzG3IZZw2wNo6IBmZip3
         B+7qjTYjKgW4Sjf2ZchSN61xhpihNxE0n/bO5CX5q3HUrdLWtGJ000++0lw7/uhJmFYk
         bAGPpAnupXYfF6i909JePk8ya73EnYudCrvgIQ9m3ClimP2Vf3emnS3RVAhAD5FfWPoP
         Q4RMoDeIkA/FSF333FdjW+ipWVp7UiC4//+nERrmLIgYMwBHuThG5XD1j+FnKutSwFqB
         IFMQ==
X-Gm-Message-State: AOJu0YzDuixtv2QMTiRrmNlccS30TG7hemHsZnAzAGXy0dxTbz1Uy3qw
        7h8pOHkDPKYfz5PzdkEk9lxWujzO4eGip4p7p/CfKA==
X-Google-Smtp-Source: AGHT+IHWCKbajPDOzc2EJ1n/RHOirXnZrIM6lY1wrd1As3uj0q5lJQ4NYVZawgsgWNzlvYGzmKItLV0vJmDPjgXNDl8=
X-Received: by 2002:a17:906:265a:b0:9ff:9db9:1dc0 with SMTP id
 i26-20020a170906265a00b009ff9db91dc0mr2116273ejc.62.1701571822752; Sat, 02
 Dec 2023 18:50:22 -0800 (PST)
MIME-Version: 1.0
References: <ZWomqO8m4vVcW+ro@debian.debian> <656b3a1bcd212_1a6a2c294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <656b3a1bcd212_1a6a2c294db@willemb.c.googlers.com.notmuch>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Sat, 2 Dec 2023 20:50:11 -0600
Message-ID: <CAO3-PboYVv6pGm6ZhNs4ArK=3W-V4XY6EJxcYXGyX=YHwdHW6g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] packet: add a generic drop reason for receive
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 2, 2023 at 8:07=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Yan Zhai wrote:
> > Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> > from consume_skb to kfree_skb to improve error handling. However, this
> > could bring a lot of noises when we monitor real packet drops in
> > kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> > can be freed, not actual packets.
> >
> > Adding a generic drop reason to allow distinguish these "clone drops".
> >
> > [1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-xcxL=
FUK2Zj08A8MrLk9jzg@mail.gmail.com/
> > Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> > v2->v3: removed an unused variable
> > v1->v2: fixups suggested by Eric Dumazet
> > v2: https://lore.kernel.org/netdev/ZWobMUp22oTpP3FW@debian.debian/
> > v1: https://lore.kernel.org/netdev/ZU3EZKQ3dyLE6T8z@debian.debian/
> > ---
> >  include/net/dropreason-core.h |  6 ++++++
> >  net/packet/af_packet.c        | 26 +++++++++++++-------------
> >  2 files changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index 3c70ad53a49c..278e4c7d465c 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -86,6 +86,7 @@
> >       FN(IPV6_NDISC_NS_OTHERHOST)     \
> >       FN(QUEUE_PURGE)                 \
> >       FN(TC_ERROR)                    \
> > +     FN(PACKET_SOCK_ERROR)           \
> >       FNe(MAX)
> >
> >  /**
> > @@ -378,6 +379,11 @@ enum skb_drop_reason {
> >       SKB_DROP_REASON_QUEUE_PURGE,
> >       /** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
> >       SKB_DROP_REASON_TC_ERROR,
> > +     /**
> > +      * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket erro=
rs
> > +      * after its filter matches an incoming packet.
> > +      */
> > +     SKB_DROP_REASON_PACKET_SOCK_ERROR,
> >       /**
> >        * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
> >        * shouldn't be used as a real 'reason' - only for tracing code g=
en
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index a84e00b5904b..933fdfaacc44 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2127,7 +2127,7 @@ static int packet_rcv(struct sk_buff *skb, struct=
 net_device *dev,
> >       u8 *skb_head =3D skb->data;
> >       int skb_len =3D skb->len;
> >       unsigned int snaplen, res;
> > -     bool is_drop_n_account =3D false;
> > +     enum skb_drop_reason drop_reason =3D SKB_CONSUMED;
>
> Reverse xmas tree
>
oh I didn't know we have requirements on variable ordering. Will pay
attention in future.

> >
> >       if (skb->pkt_type =3D=3D PACKET_LOOPBACK)
> >               goto drop;
> > @@ -2161,6 +2161,10 @@ static int packet_rcv(struct sk_buff *skb, struc=
t net_device *dev,
> >       res =3D run_filter(skb, sk, snaplen);
> >       if (!res)
> >               goto drop_n_restore;
> > +
> > +     /* skb will only be "consumed" not "dropped" before this */
> > +     drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
> > +
>
> This can be set in drop_n_account, rather than the common path.
>
> Same in tpacket_rcv.

Sure, let me shoot a v4 to move it.
