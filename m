Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6648A7F0F52
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjKTJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjKTJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:46:27 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416FBA7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:46:01 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso54490101fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700473559; x=1701078359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkX770QsciZgmyIjGlD/aDGrwKJCqahJAwyCfq7+gms=;
        b=em0LFo0+cNdIwjHui+KvAJqhsgPFIryudKSw7lvCaZkfx5RO7o8Mqc7OrgvX6AyGuH
         PhkeM8C5Us3U6x/f1oeEjd5/4IW98UwJK0lzs0fM5/5LMwfluNFD6GHv14CXje6Vw92m
         oXuWl7mhIf2tp2bD9maiczdrRXQtRVjNRDQucBbBQIiJ2SbGgZGsgvHFtqMQhgl0qxoP
         zXeAub3ZG6LY8bFr1tI/FZQtylF+Xz9ryw/lVGpKRgYQbQskQJg+Wfst3Vswdk2zRde5
         C9sXJQY8Kl3n1wC8/tJloR9et6V7DOoQrXvJzOoGeG5tuwqVJV3JUF98qYMLZgHz35fY
         wQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700473559; x=1701078359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkX770QsciZgmyIjGlD/aDGrwKJCqahJAwyCfq7+gms=;
        b=ALbX1SQCMsQtLzk4D3g7ThgzvLZLYGlOmvpf3j6ZUIc8RXnDcASCjo9cs/KhtqvuVI
         3N6PEaEu4YycoOeEdy7rz11wreBHudfZGM7RLA03UForQIrjNu5NlBKggzhnLqj8eIgO
         MQIdDgf1fIALOqzNTO9mtQ0QgOlWAG2gBi2hZATx6zz79quAHDn9J4LF05iA5rNh7yUz
         0Q0LWqomVuWLgcSd+7Y7xQXu2U+UZIj1rTSyCEbOGFHN82lKzKqfkE7+5YQJl5NB1SeY
         WA132kBvmM7wJQmehjh2GflcLxBjexspeIf+QAWpAy5Mnfjn0/J8l1ZVDk7V92RKmC3F
         1Wuw==
X-Gm-Message-State: AOJu0YyFThNwczvkLliGieUKLLRIDb2j2yN34bKYyqvKoJL76oVbliDq
        dq0AfKx6h9HqnULGhQs7jIdwNV1GqUEew1wthk73yQ==
X-Google-Smtp-Source: AGHT+IEXtmIeiiZFXoFRKaKbc0qrn9hxoDeZVP3wrl6QX3VQYn1t47LiuGEcBE/xagf4bs0P7gMKS4so7X7kWUS/TJM=
X-Received: by 2002:a2e:8e38:0:b0:2c6:ed5e:bbf0 with SMTP id
 r24-20020a2e8e38000000b002c6ed5ebbf0mr4711811ljk.34.1700473559467; Mon, 20
 Nov 2023 01:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20231116114150.48639-1-huangjie.albert@bytedance.com> <ZVcxmwm/DRTB8QwO@lore-desk>
In-Reply-To: <ZVcxmwm/DRTB8QwO@lore-desk>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 20 Nov 2023 17:45:47 +0800
Message-ID: <CABKxMyPMboVYs01KfPEdxPbx-LT88Qe1pcDMaT0NiNWhA-5emg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH net] veth: fix ethtool statistical errors
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=BA=94 17:26=E5=86=99=E9=81=93=EF=BC=9A
>
> > if peer->real_num_rx_queues > 1, the ethtool -s command for
> > veth network device will display some error statistical values.
> > The value of tx_idx is reset with each iteration, so even if
> > peer->real_num_rx_queues is greater than 1, the value of tx_idx
> > will remain constant. This results in incorrect statistical values.
> > To fix this issue, assign the value of pp_idx to tx_idx.
> >
> > Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit accou=
nting")
> > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > ---
> >  drivers/net/veth.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 0deefd1573cf..3a8e3fc5eeb5 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -225,7 +225,7 @@ static void veth_get_ethtool_stats(struct net_devic=
e *dev,
> >       for (i =3D 0; i < peer->real_num_rx_queues; i++) {
> >               const struct veth_rq_stats *rq_stats =3D &rcv_priv->rq[i]=
.stats;
> >               const void *base =3D (void *)&rq_stats->vs;
> > -             unsigned int start, tx_idx =3D idx;
> > +             unsigned int start, tx_idx =3D pp_idx;
> >               size_t offset;
> >
> >               tx_idx +=3D (i % dev->real_num_tx_queues) * VETH_TQ_STATS=
_LEN;
> > --
> > 2.20.1
> >
>
> Hi Albert,
>
> Can you please provide more details about the issue you are facing?
> In particular, what is the number of configured tx and rx queues for both
> peers?

Hi, Lorenzo
I found this because I wanted to add more echo information in ethttool=EF=
=BC=88for veth,
but I found that the information was incorrect. That's why I paid
attention here.

> tx_idx is the index of the current (local) tx queue and it must restart f=
rom
> idx in each iteration otherwise we will have an issue when
> peer->real_num_rx_queues is greater than dev->real_num_tx_queues.
>
OK. I don't know if this is a known issue.

BR
Albert


> Regards,
> Lorenzo
