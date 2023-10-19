Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B859C7CF2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbjJSImX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344937AbjJSImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:42:02 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D1126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:41:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so103487631fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697704898; x=1698309698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PaT8mi8bxcfm5TPLf4wNdjRUslXYyG+1MAzO1FCJQ4=;
        b=RtwmWWnTXmonQvpYEUidyG9oXNSlSze7RkJYETvqq4XrpZGJRck3l5HDJZmKHSoMRF
         8hnnsNiHJhr7QUF6Yhr48TJDVMPKnzpd8shWod6sIAMe/TzumhJ/eNlysfXkhD++Cw0h
         XkBvRe7tWL+yVNIT7Xlr/Y+Ah0GRmuZZqK3FGiO4OoZKvuwTtfZay7KYU4J7zxVM5qyt
         YUcKY0UDSX5F2Vo8ItDAm5wLEuXVZvxIc2U6bqKYshX3qXvOwQteidnMVdNq/pF86VYB
         Tdy0sMBcgD4OArbstdpMXR+KPvv3ueH5Z5QG+yMi2UlEpW7B0XRY3k2KNySa0FWLCsuB
         h6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697704898; x=1698309698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PaT8mi8bxcfm5TPLf4wNdjRUslXYyG+1MAzO1FCJQ4=;
        b=Src73DtbRd9A1kjgbOby3kNzqJfLbwtxqXhvthVyttNVXTBeaFl6YL4tI9foD1zA4b
         1L4kqBPzL/kHFr7KQZPamWysYT0loZ//+kQgnUaEB6SAI1wz5BU+P4wwdFLVcXohOWxQ
         ymCN+Ps4qWUAgfkTu/hZPyyRrgyhIDstod/QJ0K7H4vCpgmSJA8kXf5g+2RAriIknnl4
         xx4Rhufc7Wp4vgzy8iz9z8pY5x8lxewvzT00piwhOCYrd9aP9rAMUmMiRZZiUu3zTcSU
         94++tSS+uzphLRoHJsVbuuZzikQaySLOIjBA9OvpKq5oerz1hTQeXkrxRyFYG9z6RVEk
         EO5A==
X-Gm-Message-State: AOJu0YxzC6MUXgW9raktCV4bn3KP3DJNbaWc1LEUTvPEIe7zG1gjyfMK
        vlvyISMC7au/d2gPF4Pj1RIz9aqUYidesWRcZ0ObEA==
X-Google-Smtp-Source: AGHT+IEhvzX+lyIv3ZYHkMP62HnSbiW1SxjBgx4k0NjiXMXnhNqabye36bRAYEyZ6httnZPFUNnUouy7orCk21UnjK0=
X-Received: by 2002:a05:651c:b06:b0:2b9:aa4d:3728 with SMTP id
 b6-20020a05651c0b0600b002b9aa4d3728mr1114413ljr.29.1697704898485; Thu, 19 Oct
 2023 01:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231016031649.35088-1-huangjie.albert@bytedance.com> <CAJ8uoz2DUe3xySTKuLbA5=QDAGuTzPdGu3P_=ZvJmna25VtHCQ@mail.gmail.com>
In-Reply-To: <CAJ8uoz2DUe3xySTKuLbA5=QDAGuTzPdGu3P_=ZvJmna25VtHCQ@mail.gmail.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Thu, 19 Oct 2023 16:41:27 +0800
Message-ID: <CABKxMyONtPR1pWLdBiK5M-NJoc5S6rpyYYUQWa0J2R+eyajOsg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 net-next] xsk: Avoid starving xsk at the
 end of the list
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
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
> since the total budget per send is 32. You need to go through the list
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

Currently, there are two paths in the kernel that consume TX queue descript=
ors:

1=E3=80=81Native XSK
xsk_tx_peek_desc
     xskq_cons_peek_desc

In the first scenario, we consume TX descriptors by sequentially
traversing the pool->xsk_tx_list
without any implicit code logic to ensure fairness. This can lead to a
scenario of starvation,
making it a top priority for us to address.

2=E3=80=81Generic XSK
__xsk_sendmsg (or xsk_poll)
     xsk_generic_xmit
        __xsk_generic_xmit
              xskq_cons_peek_desc

In the second scenario, TX descriptors are consumed by using sendto.
Currently, __xsk_generic_xmit
sends a maximum of 32 TX descriptors each time, and the process
scheduling strategy already
ensures a certain level of fairness. In this scenario, should we
consider not addressing it and
instead prioritize the first scenario?

Additionally, based on my understanding, there should not be
applications concurrently using generic
XSK and native XSK on the same pool.

Magnus, how do you view this issue? I'm concerned that striving for
absolute fairness might introduce
additional complexity in the logic.

BR
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
