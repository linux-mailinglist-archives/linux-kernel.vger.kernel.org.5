Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C87CBBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjJQGzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjJQGzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:55:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57602B6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:55:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9338e4695so69240691fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697525709; x=1698130509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDkATyrBELpMJhNZkPKNwPN8vNWTOg5Prx6dfaUxudc=;
        b=lgYC1Grth33gc7E48Q0tJylGuhX7skgPrvXq3Sk3MRg0qbOroyDLOFFf3qhHeMz2lJ
         o2h8AaX3jKbigUivUgQit/fYI9pekdkwzIGyOsT8NcOyw4VJJyNu0+APhcsoZcBMAJww
         nE0S2+FQqMS39Z0bB2RszhPfhnRxM4EJ7ZpSRxIJ+dHxFjmMomRx3oUjxZzx5gIsXw5t
         6h949gBsh151J1m/pW6E88DQ/Rr1vtTHZGV1xS1LFm2LnLOlaG/HOpm5oGnPclH3vsRm
         LLTYjUIqppv6l4cr1wZiHzRd1oofB2Cda8oAga8ovjDZOCMbNGlH0KJI6GG4AUF9CWlY
         lbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697525709; x=1698130509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDkATyrBELpMJhNZkPKNwPN8vNWTOg5Prx6dfaUxudc=;
        b=b0kxt5NHhsqX87Qcb95M8vCE7xZ4jymmBaP5/6EBfD4j570aTmamJ2R1BSB9XqNsct
         mLQ9LReXBdAU+OKOX3y3RQ4tXtnonUvOnFe4QCrfZFeKYUuk+mzwfdg6TgGyhheBBYsO
         lNl3iZzzacPGbilAYoyHtzozBNEEzd7518njA7hQSncijgx8eGJ1bMk5dHMyOoC6eU0g
         5IqwmrpMfTlFoPZh4IFaFXbCjNjGI9+rXfqrh7XFl2f/jkFxp3aTd/ErLJxlRtGZeXnu
         SM8ERuUAwGgtQkRh2y2TJVdTbRXi3h0AUM857PRZ33rqvOK8vY8hxv9fkGx1SEZZh+YD
         Wk1A==
X-Gm-Message-State: AOJu0Yy0GHAItlqFocYG0UWHtYVMaQH4fofnrct8glgicUt91KRiMvL7
        xjKNQC8gDhXo3Sc70EqDvl75t/AeeYoi/4cR/RpjXQ==
X-Google-Smtp-Source: AGHT+IECj117APB9tIfHpuHnYtXL8pZAUC+BwW1vvYpdkLMvvBPbK79bq7ACBx0xDJ5SxErp0KFKe6Hj+mIK5TUoNyU=
X-Received: by 2002:a2e:730a:0:b0:2c5:1c4:9005 with SMTP id
 o10-20020a2e730a000000b002c501c49005mr895088ljc.32.1697525709544; Mon, 16 Oct
 2023 23:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231016031649.35088-1-huangjie.albert@bytedance.com>
 <CAJ8uoz2DUe3xySTKuLbA5=QDAGuTzPdGu3P_=ZvJmna25VtHCQ@mail.gmail.com>
 <CABKxMyMieNNMXFMTRdof1W43ijvZq5e04nOkXFv5djzadXh0xQ@mail.gmail.com> <CAJ8uoz069tKX60=j3PwsVrO64c+mRGvVYJJWPwTktrAuh=3fbg@mail.gmail.com>
In-Reply-To: <CAJ8uoz069tKX60=j3PwsVrO64c+mRGvVYJJWPwTktrAuh=3fbg@mail.gmail.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Tue, 17 Oct 2023 14:54:57 +0800
Message-ID: <CABKxMyM_jGBWK1g8Hb145PEBui_p1RCg-uGm5Sjtb4injVD3Jw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] xsk: Avoid starving xsk at the end of the list
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Karlsson <magnus.karlsson@gmail.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=
=8816=E6=97=A5=E5=91=A8=E4=B8=80 17:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 16 Oct 2023 at 10:54, =E9=BB=84=E6=9D=B0 <huangjie.albert@bytedan=
ce.com> wrote:
> >
> > Magnus Karlsson <magnus.karlsson@gmail.com> =E4=BA=8E2023=E5=B9=B410=E6=
=9C=8816=E6=97=A5=E5=91=A8=E4=B8=80 14:41=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, 16 Oct 2023 at 05:17, Albert Huang
> > > <huangjie.albert@bytedance.com> wrote:
> > > >
> > > > In the previous implementation, when multiple xsk sockets were
> > > > associated with a single xsk_buff_pool, a situation could arise
> > > > where the xsk_tx_list maintained data at the front for one xsk
> > > > socket while starving the xsk sockets at the back of the list.
> > > > This could result in issues such as the inability to transmit packe=
ts,
> > > > increased latency, and jitter. To address this problem, we introduc=
ed
> > > > a new variable called tx_budget_cache, which limits each xsk to tra=
nsmit
> > > > a maximum of MAX_XSK_TX_BUDGET tx descriptors. This allocation ensu=
res
> > > > equitable opportunities for subsequent xsk sockets to send tx descr=
iptors.
> > > > The value of MAX_XSK_TX_BUDGET is temporarily set to 16.
> > >
> > > Hi Albert. Yes you are correct that there is nothing hindering this t=
o
> > > happen in the code at the moment, so let us fix it.
> > >
> > thanks.
> >
> > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > ---
> > > >  include/net/xdp_sock.h |  6 ++++++
> > > >  net/xdp/xsk.c          | 18 ++++++++++++++++++
> > > >  2 files changed, 24 insertions(+)
> > > >
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index 69b472604b86..f617ff54e38c 100644
> > > > --- a/include/net/xdp_sock.h
> > > > +++ b/include/net/xdp_sock.h
> > > > @@ -44,6 +44,7 @@ struct xsk_map {
> > > >         struct xdp_sock __rcu *xsk_map[];
> > > >  };
> > > >
> > > > +#define MAX_XSK_TX_BUDGET 16
> > >
> > > I think something like MAX_PER_SOCKET_BUDGET would be clearer.
> > >
> >
> >  OK, this will be considered  in the next patch.
> >
> > > >  struct xdp_sock {
> > > >         /* struct sock must be the first member of struct xdp_sock =
*/
> > > >         struct sock sk;
> > > > @@ -63,6 +64,11 @@ struct xdp_sock {
> > > >
> > > >         struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > > >         struct list_head tx_list;
> > > > +       /* Record the actual number of times xsk has transmitted a =
tx
> > > > +        * descriptor, with a maximum limit not exceeding MAX_XSK_T=
X_BUDGET
> > > > +        */
> > > > +       u32 tx_budget_cache;
> > > > +
> > > >         /* Protects generic receive. */
> > > >         spinlock_t rx_lock;
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index f5e96e0d6e01..087f2675333c 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
> > > >
> > > >  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc =
*desc)
> > > >  {
> > > > +       u32 xsk_full_count =3D 0;
> > >
> > > Enough with a bool;
> > >
> > > >         struct xdp_sock *xs;
> > > >
> > > >         rcu_read_lock();
> > > > +again:
> > > >         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > > +               if (xs->tx_budget_cache >=3D MAX_XSK_TX_BUDGET) {
> > > > +                       xsk_full_count++;
> > > > +                       continue;
> > > > +               }
> > >
> > > The problem here is that the fixed MAX_XSK_TX_BUDGET is only useful
> > > for the <=3D 2 socket case. If I have 3 sockets sharing a
> > > netdev/queue_id, the two first sockets can still starve the third one
> > > since the total budget per send is 32.
> >
> > Why is there a limit of 32? I'm not quite clear on the implications of =
these,
> > Did I miss something?
> > BR
> > Albert
>
> There is a define TX_BATCH_SIZE 32 that controls the max number of
> packets a sendto() call can send before it exits. It is used in
> __xsk_generic_xmit().

OK,I got it . I missed the logic here. I will reconsider the logic in this =
part.
Thanks
BR
Albert

>
> > >You need to go through the list
> > > of sockets in the beginning to compute the MAX_XSK_TX_BUDGET to
> > > compute this dynamically before each call. Or cache this value
> > > somehow, in the pool for example. Actually, the refcount in the
> > > buf_pool will tell you how many sockets are sharing the same buf_pool=
.
> > > Try using that to form MAX_XSK_TX_BUDGET on the fly.
> > >
> > > Another simpler way of accomplishing this would be to just reorder th=
e
> > > list every time. Put the first socket last in the list every time. Th=
e
> > > drawback of this is that you need to hold the xsk_tx_list_lock while
> > > doing this so might be slower. The per socket batch size would also b=
e
> > > 32 and you would not receive "fairness" over a single call to
> > > sendto(). Would that be a problem for you?
> > >
> >
> > Yes, I did consider this approach, but I abandoned it because it would =
lose
> > the performance advantages of lock-free operations(RCU read)
> > thanks
> > Albert
>
> OK, then let us not consider it and try to make your current approach wor=
k.
>
> >
> > > > +
> > > >                 if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
> > > >                         if (xskq_has_descs(xs->tx))
> > > >                                 xskq_cons_release(xs->tx);
> > > >                         continue;
> > > >                 }
> > > >
> > > > +               xs->tx_budget_cache++;
> > > > +
> > > >                 /* This is the backpressure mechanism for the Tx pa=
th.
> > > >                  * Reserve space in the completion queue and only p=
roceed
> > > >                  * if there is space in it. This avoids having to i=
mplement
> > > > @@ -436,6 +445,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *po=
ol, struct xdp_desc *desc)
> > > >                 return true;
> > > >         }
> > > >
> > > > +       if (unlikely(xsk_full_count > 0)) {
> > > > +               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_=
list) {
> > > > +                       xs->tx_budget_cache =3D 0;
> > > > +               }
> > > > +               xsk_full_count =3D 0;
> > > > +               goto again;
> > > > +       }
> >
> > this section of code only enters when it's unable to acquire any TX
> > descriptors and
> > xsk_full_count > 0.
> >
> > > > +
> > > >  out:
> > > >         rcu_read_unlock();
> > > >         return false;
> > > > @@ -1230,6 +1247,7 @@ static int xsk_bind(struct socket *sock, stru=
ct sockaddr *addr, int addr_len)
> > > >         xs->zc =3D xs->umem->zc;
> > > >         xs->sg =3D !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
> > > >         xs->queue_id =3D qid;
> > > > +       xs->tx_budget_cache =3D 0;
> > > >         xp_add_xsk(xs->pool, xs);
> > > >
> > > >  out_unlock:
> > > > --
> > > > 2.20.1
> > > >
> > > >
