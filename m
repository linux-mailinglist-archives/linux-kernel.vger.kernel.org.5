Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907817CA2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjJPIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjJPIzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:55:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43A7E6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:54:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so36786821fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697446489; x=1698051289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvcjP0ljqI4rMfXZVhv7BTPY7+cgVsvwJ9E4e61OTFg=;
        b=LVb9XF4duXbt+FWlBWVmwsMlRk4SKKM/78v4pT+LHTqFoUenmT5HAln/Ge0kHMwf1Z
         dQNptFiXdnOFxRi3QPpLS5jMDsHdOVKuWo7SRzndydWmny8ZJchjF/fRGwzTHR8zfSoR
         AfS4rhgOsrLYfileCZ+2JOlXC/VOIwXcJ/12+1Q+vQwmp2q7dms5Zs+dnWq1zXupsHbQ
         bYCN1ZoPhLWZqq+BR9Ll9h17h+6u44vhaRDHhXJ59ZpBwrVHJjZkjY3yPnrCt3gZt7ae
         yx6wV8effS2Q3uzOjihmok0BgtJauTQM2P5XrvBtAergPKeFBzZcQg3ulzvaM/1EKr7w
         UWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697446489; x=1698051289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvcjP0ljqI4rMfXZVhv7BTPY7+cgVsvwJ9E4e61OTFg=;
        b=nQ4RyeZVpTGp8RoT/9T1l5tIQx6J/tKAk2gc5TMOvASMMSzh2GSaXvO43NLgftB8HK
         QnUKGdFMzzC+KKCX+fSruZclYkMd4PgfJIbFAzqPRZ0ddPg1JuPVR3QoyTC4qveUn9Ai
         kBf6Vg043tMo8UrwypAv+RttUDFlkewWxd4Bczoez/auEo+px870IgfVH9WKl7+b2wNh
         NL/h676qhIkhDw0+a2yCXpmQZqM59SlGvtLPHhOjMnvy+uP8MUt8d4pUJxiN25gy8YYY
         q6rlAoYRrtRSeQbmFtBXAXkMDKq29AHdPCsBGdwqzjKEI2h4PMPznvgOAQkDyOx1/NnL
         rTiA==
X-Gm-Message-State: AOJu0YxGbGyJcDWuCRHN/s1DEY6d5dEQPMSKF6GayagK1joOayYXDwo5
        ZaQ7nXzP0vOcoLpS+QHCBbJrqJdxAgirzYood+ImTA==
X-Google-Smtp-Source: AGHT+IH03JrFWB/B8ZWKX8m2yIdPRZ8/VYdAHjlCdExhfEVNY5ljcpzJFIVvUr5yil57VnGD09gG9IhWcPbqwCjdt28=
X-Received: by 2002:a05:651c:1201:b0:2c0:14e2:1f5c with SMTP id
 i1-20020a05651c120100b002c014e21f5cmr25692927lja.5.1697446489057; Mon, 16 Oct
 2023 01:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231016031649.35088-1-huangjie.albert@bytedance.com> <CAJ8uoz2DUe3xySTKuLbA5=QDAGuTzPdGu3P_=ZvJmna25VtHCQ@mail.gmail.com>
In-Reply-To: <CAJ8uoz2DUe3xySTKuLbA5=QDAGuTzPdGu3P_=ZvJmna25VtHCQ@mail.gmail.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 16 Oct 2023 16:54:37 +0800
Message-ID: <CABKxMyMieNNMXFMTRdof1W43ijvZq5e04nOkXFv5djzadXh0xQ@mail.gmail.com>
Subject: Re: Re: [PATCH v2 net-next] xsk: Avoid starving xsk at the end of the list
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Karlsson <magnus.karlsson@gmail.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=
=8816=E6=97=A5=E5=91=A8=E4=B8=80 14:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 16 Oct 2023 at 05:17, Albert Huang
> <huangjie.albert@bytedance.com> wrote:
> >
> > In the previous implementation, when multiple xsk sockets were
> > associated with a single xsk_buff_pool, a situation could arise
> > where the xsk_tx_list maintained data at the front for one xsk
> > socket while starving the xsk sockets at the back of the list.
> > This could result in issues such as the inability to transmit packets,
> > increased latency, and jitter. To address this problem, we introduced
> > a new variable called tx_budget_cache, which limits each xsk to transmi=
t
> > a maximum of MAX_XSK_TX_BUDGET tx descriptors. This allocation ensures
> > equitable opportunities for subsequent xsk sockets to send tx descripto=
rs.
> > The value of MAX_XSK_TX_BUDGET is temporarily set to 16.
>
> Hi Albert. Yes you are correct that there is nothing hindering this to
> happen in the code at the moment, so let us fix it.
>
thanks.

> > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > ---
> >  include/net/xdp_sock.h |  6 ++++++
> >  net/xdp/xsk.c          | 18 ++++++++++++++++++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 69b472604b86..f617ff54e38c 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -44,6 +44,7 @@ struct xsk_map {
> >         struct xdp_sock __rcu *xsk_map[];
> >  };
> >
> > +#define MAX_XSK_TX_BUDGET 16
>
> I think something like MAX_PER_SOCKET_BUDGET would be clearer.
>

 OK, this will be considered  in the next patch.

> >  struct xdp_sock {
> >         /* struct sock must be the first member of struct xdp_sock */
> >         struct sock sk;
> > @@ -63,6 +64,11 @@ struct xdp_sock {
> >
> >         struct xsk_queue *tx ____cacheline_aligned_in_smp;
> >         struct list_head tx_list;
> > +       /* Record the actual number of times xsk has transmitted a tx
> > +        * descriptor, with a maximum limit not exceeding MAX_XSK_TX_BU=
DGET
> > +        */
> > +       u32 tx_budget_cache;
> > +
> >         /* Protects generic receive. */
> >         spinlock_t rx_lock;
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f5e96e0d6e01..087f2675333c 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
> >
> >  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *des=
c)
> >  {
> > +       u32 xsk_full_count =3D 0;
>
> Enough with a bool;
>
> >         struct xdp_sock *xs;
> >
> >         rcu_read_lock();
> > +again:
> >         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > +               if (xs->tx_budget_cache >=3D MAX_XSK_TX_BUDGET) {
> > +                       xsk_full_count++;
> > +                       continue;
> > +               }
>
> The problem here is that the fixed MAX_XSK_TX_BUDGET is only useful
> for the <=3D 2 socket case. If I have 3 sockets sharing a
> netdev/queue_id, the two first sockets can still starve the third one
> since the total budget per send is 32.

Why is there a limit of 32? I'm not quite clear on the implications of thes=
e,
Did I miss something?
BR
Albert

>You need to go through the list
> of sockets in the beginning to compute the MAX_XSK_TX_BUDGET to
> compute this dynamically before each call. Or cache this value
> somehow, in the pool for example. Actually, the refcount in the
> buf_pool will tell you how many sockets are sharing the same buf_pool.
> Try using that to form MAX_XSK_TX_BUDGET on the fly.
>
> Another simpler way of accomplishing this would be to just reorder the
> list every time. Put the first socket last in the list every time. The
> drawback of this is that you need to hold the xsk_tx_list_lock while
> doing this so might be slower. The per socket batch size would also be
> 32 and you would not receive "fairness" over a single call to
> sendto(). Would that be a problem for you?
>

Yes, I did consider this approach, but I abandoned it because it would lose
the performance advantages of lock-free operations(RCU read)
thanks
Albert


> > +
> >                 if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
> >                         if (xskq_has_descs(xs->tx))
> >                                 xskq_cons_release(xs->tx);
> >                         continue;
> >                 }
> >
> > +               xs->tx_budget_cache++;
> > +
> >                 /* This is the backpressure mechanism for the Tx path.
> >                  * Reserve space in the completion queue and only proce=
ed
> >                  * if there is space in it. This avoids having to imple=
ment
> > @@ -436,6 +445,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, =
struct xdp_desc *desc)
> >                 return true;
> >         }
> >
> > +       if (unlikely(xsk_full_count > 0)) {
> > +               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list=
) {
> > +                       xs->tx_budget_cache =3D 0;
> > +               }
> > +               xsk_full_count =3D 0;
> > +               goto again;
> > +       }

this section of code only enters when it's unable to acquire any TX
descriptors and
xsk_full_count > 0.

> > +
> >  out:
> >         rcu_read_unlock();
> >         return false;
> > @@ -1230,6 +1247,7 @@ static int xsk_bind(struct socket *sock, struct s=
ockaddr *addr, int addr_len)
> >         xs->zc =3D xs->umem->zc;
> >         xs->sg =3D !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
> >         xs->queue_id =3D qid;
> > +       xs->tx_budget_cache =3D 0;
> >         xp_add_xsk(xs->pool, xs);
> >
> >  out_unlock:
> > --
> > 2.20.1
> >
> >
