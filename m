Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A774773621
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjHHB6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjHHB63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:58:29 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF189F1;
        Mon,  7 Aug 2023 18:58:28 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-d3563cb41e9so4285923276.0;
        Mon, 07 Aug 2023 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691459908; x=1692064708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vbR+3AXDJwndsjWTNdO9o3kq69tlinQ654fL9RtrZ4=;
        b=oy20Rb49UbMDTh1WwIzKz9xsAcSuB3bmzVm87cc9ts2dYBIqAJehfFV6m2zhpDCiYO
         1H/ukdmkfOTjW1fWe4nxWYIV7NBmUr2rqK875tKI8x9TLx3F/bHgLklJ6P9/dIIx9cXU
         XW2T1QZRo7bsDqLYhDBJ61/EJQHPDVJYcdNdY/ZVcE7iD59HbR9sjT18jS/oX//tgqcm
         8AixuTjznnRMtGpVjnzPTds2O26k1K+tSt6gXUz9b1gpQ1n1gplBO0Qs7d58lm3oF3TS
         JU5IGpdZEnBmvW8WqIhCcEpH4xHJJhpMjr/gKhqWnfWnfH7aSgW4c/Y3K0E2ix6hONUe
         nqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691459908; x=1692064708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vbR+3AXDJwndsjWTNdO9o3kq69tlinQ654fL9RtrZ4=;
        b=J84dtNdSDSjatL4kIsayKOLRaVXIw8V2hxz91ORHEr/IzZxjuwCaha7GOTobwdQsy1
         s0eRb0wVAdJOqdGEhHYWvBuwfTKvsOWtDQMhN30rfFHqIUi5/TyNeEyKows/YCO/vLiu
         GKX9iM1fQ0sfsuQL9LDOz5ubb1EWPqM4/n+ibVHNuZn42jSjyNDqQtNCFESL+Ru9kEkr
         vJ5qnWgLM9lluBBBi2X5PdTn4Uvt/I//LIdV8AVGEOePS3kFtfNbn2En5GljEOHPiwwS
         +WynD5VwqnVvCNzApM8e5FSxp3sHogg2gxVyvZY/aeCnH+zmVnkkNaJ+m+M3Dv3AZEiR
         +pzQ==
X-Gm-Message-State: AOJu0Yx/pGj6oxdSv0kkrgSDDaN2umYp4aTQnwV05ymJbrORFxjGsRmu
        hhoDtoYUvIxK19c082czPN4NJxabqG6TOI0Awq29G7d2oxBfK/IC
X-Google-Smtp-Source: AGHT+IFCv4Wq+bYdRuW4AeEHzG6cA3bO1KI1Y2C6ue+gSUpCiyd0qS8BYQnpUPA5ccm2Mn/tSfT0oXnsXohDBc5ugbE=
X-Received: by 2002:a25:410e:0:b0:d4c:83a8:268d with SMTP id
 o14-20020a25410e000000b00d4c83a8268dmr5489882yba.38.1691459907805; Mon, 07
 Aug 2023 18:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230807134547.2782227-1-imagedong@tencent.com>
 <20230807134547.2782227-2-imagedong@tencent.com> <CANn89iJ762Y3KvL26-3s9vkZdkWi9PoJXhzLHr3+5v9Ti47gTw@mail.gmail.com>
In-Reply-To: <CANn89iJ762Y3KvL26-3s9vkZdkWi9PoJXhzLHr3+5v9Ti47gTw@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 8 Aug 2023 09:58:16 +0800
Message-ID: <CADxym3ZqELjAz8iYwkgqndG6Ggto0DCU6g-ffbSitNWO6tZ7ng@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: tcp: send zero-window ACK when no memory
To:     Eric Dumazet <edumazet@google.com>
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
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

On Mon, Aug 7, 2023 at 10:05=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Aug 7, 2023 at 3:47=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
> >
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > For now, skb will be dropped when no memory, which makes client keep
> > retrans util timeout and it's not friendly to the users.
> >
> > In this patch, we reply an ACK with zero-window in this case to update
> > the snd_wnd of the sender to 0. Therefore, the sender won't timeout the
> > connection and will probe the zero-window with the retransmits.
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> > v2:
> > - send 0 rwin ACK for the receive queue empty case when necessary
> > - send the ACK immediately by using the ICSK_ACK_NOW flag
> > ---
> >  include/net/inet_connection_sock.h |  3 ++-
> >  net/ipv4/tcp_input.c               | 14 +++++++++++---
> >  net/ipv4/tcp_output.c              | 14 +++++++++++---
> >  3 files changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/inet_connection_sock.h b/include/net/inet_conn=
ection_sock.h
> > index c2b15f7e5516..be3c858a2ebb 100644
> > --- a/include/net/inet_connection_sock.h
> > +++ b/include/net/inet_connection_sock.h
> > @@ -164,7 +164,8 @@ enum inet_csk_ack_state_t {
> >         ICSK_ACK_TIMER  =3D 2,
> >         ICSK_ACK_PUSHED =3D 4,
> >         ICSK_ACK_PUSHED2 =3D 8,
> > -       ICSK_ACK_NOW =3D 16       /* Send the next ACK immediately (onc=
e) */
> > +       ICSK_ACK_NOW =3D 16,      /* Send the next ACK immediately (onc=
e) */
> > +       ICSK_ACK_NOMEM =3D 32,
> >  };
> >
> >  void inet_csk_init_xmit_timers(struct sock *sk,
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 8e96ebe373d7..aae485d0a3b6 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -5059,12 +5059,20 @@ static void tcp_data_queue(struct sock *sk, str=
uct sk_buff *skb)
> >
> >                 /* Ok. In sequence. In window. */
> >  queue_and_out:
> > -               if (skb_queue_len(&sk->sk_receive_queue) =3D=3D 0)
> > -                       sk_forced_mem_schedule(sk, skb->truesize);
> > -               else if (tcp_try_rmem_schedule(sk, skb, skb->truesize))=
 {
> > +               if (skb_queue_len(&sk->sk_receive_queue) =3D=3D 0) {
> > +                       if (tcp_try_rmem_schedule(sk, skb, skb->truesiz=
e)) {
> > +                               sk_forced_mem_schedule(sk, skb->truesiz=
e);
>
> I think we want sk->sk_data_ready() here, to let applications drain the q=
ueue,
> regardless of sk->sk_rcvlowat value.
>
>
> > +                               inet_csk(sk)->icsk_ack.pending |=3D
> > +                                       (ICSK_ACK_NOMEM | ICSK_ACK_NOW)=
;
> > +                               inet_csk_schedule_ack(sk);
> > +                       }
> > +               } else if (tcp_try_rmem_schedule(sk, skb, skb->truesize=
)) {
> >                         reason =3D SKB_DROP_REASON_PROTO_MEM;
> >                         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDR=
OP);
> >                         sk->sk_data_ready(sk);
>
> We also want to keep this sk->sk_data_ready(sk) call.
>
> > +                       inet_csk(sk)->icsk_ack.pending |=3D
> > +                               (ICSK_ACK_NOMEM | ICSK_ACK_NOW);
> > +                       inet_csk_schedule_ack(sk);
> >                         goto drop;
> >                 }
>
> This would suggest a different code refactoring, to avoid code duplicatio=
n.
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 57c8af1859c16eba5e952a23ea959b628006f9c1..dde6c44f2c1e33dcf60c23b49=
cd99f270874ca96
> 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5050,13 +5050,17 @@ static void tcp_data_queue(struct sock *sk,
> struct sk_buff *skb)
>
>                 /* Ok. In sequence. In window. */
>  queue_and_out:
> -               if (skb_queue_len(&sk->sk_receive_queue) =3D=3D 0)
> -                       sk_forced_mem_schedule(sk, skb->truesize);
> -               else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
> -                       reason =3D SKB_DROP_REASON_PROTO_MEM;
> -                       NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP=
);
> +               if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
> +                       /* TODO: maybe ratelimit these WIN 0 ACK ? */
> +                       inet_csk(sk)->icsk_ack.pending |=3D
> CSK_ACK_NOMEM | ICSK_ACK_NOW;
> +                       inet_csk_schedule_ack(sk);
>                         sk->sk_data_ready(sk);
> -                       goto drop;
> +                       if (skb_queue_len(&sk->sk_receive_queue)) {
> +                               reason =3D SKB_DROP_REASON_PROTO_MEM;
> +                               NET_INC_STATS(sock_net(sk),
> LINUX_MIB_TCPRCVQDROP);
> +                               goto drop;
> +                       }
> +                       sk_forced_mem_schedule(sk, skb->truesize);
>                 }
>
>                 eaten =3D tcp_queue_rcv(sk, skb, &fragstolen);

Looks much better, thank you!
