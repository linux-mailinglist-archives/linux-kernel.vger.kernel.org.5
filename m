Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE037661D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjG1CiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjG1CiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:38:10 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2530E0;
        Thu, 27 Jul 2023 19:38:08 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so1438165276.2;
        Thu, 27 Jul 2023 19:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690511887; x=1691116687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b3n4ix0PVCID/H1AF/PSs6xMKgdCeQOhECeB9MZXrY=;
        b=hIEE8deFlO6a9hQYyGPt90EuEo57RSABAUGdR6qZzuOqVuRxjthPsgH17pu2HDmCB7
         nlPeaz4YDPJs/q4s6baeiysbsJF8RxONzgHyOn4XH+pQQ2ONxcJZip2sP4QND5tmCCbu
         bTwBkjRhnvKgioiqTc8Q7XDDC/zYAlpm1Qe0nadneHd+qBUnuGF+G6tMbGTalJEPxq4f
         jqC+1p/FEsDYbcBGIS0BJZlmx7zbA1VNMRiYKNonZNrTpPVri74nzQL751NiLQ3cG7v4
         2VbGGa8N59pdEMZgw31ButQ7Q49PeI4Pvr3UFsWYqW6s4lKN3bVsYYygK2H7nBDxbT9m
         69fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690511887; x=1691116687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b3n4ix0PVCID/H1AF/PSs6xMKgdCeQOhECeB9MZXrY=;
        b=bH4anYWbwMD+5C/+GFakQTeeWJ/kxRTUIiuNzc3I1mBX/iUSQ8sIw3HHCX6eTfupPq
         trVRIFdalH1XZbLoU968yoiVSstzF+wfJ7YtZbhA8jQ+/neQ/5ue32Vd9cienjC2nKjq
         bD69WthyK5r0ZyueotQO1FmhaTDr9VvcUug7ZcCT4gJWt08QOeBKQDCPFjgbOAmeOHBZ
         DyoaxZesBStrk4TBafsLT/BEgHrlum4pzPHNRr4vZBurcaR4E75hgIc8k2yy9yzw0Q2p
         xIKUX8/KjWtOsmJ0pzrF1ZT5Es9wg0VPsXlc1GZycXpd/vOdMZTtubF+KLDuB5b+kJdu
         7sOQ==
X-Gm-Message-State: ABy/qLa5R3/+nk9R9bezHNf0hzuBB3NTl5l01Sg7auVk8rHTJET5HF2K
        z9WztPSlFB2IehCE6QYHdWpX4ORaJfNNOi6M5H4=
X-Google-Smtp-Source: APBJJlFcW97WvKAmuZ+JBhgClpagVh8f/RtiUWA+CD1OWVXxCqSpQ5+MaiYget9I+0WSTruvnWPKofUdjRJgyuWbj6I=
X-Received: by 2002:a0d:d453:0:b0:582:5527:ddc with SMTP id
 w80-20020a0dd453000000b0058255270ddcmr510035ywd.34.1690511887183; Thu, 27 Jul
 2023 19:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com>
 <20230727125125.1194376-2-imagedong@tencent.com> <CANn89iLwLxzSLKtobE9y+ZBU_eizfNo6FUfBa61KeUXsodA2FQ@mail.gmail.com>
In-Reply-To: <CANn89iLwLxzSLKtobE9y+ZBU_eizfNo6FUfBa61KeUXsodA2FQ@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri, 28 Jul 2023 10:37:55 +0800
Message-ID: <CADxym3YP8zw-bCJxWmfcUWYz7Ncipsa=jDMweR6kZF-xaMwc3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: tcp: send zero-window ACK when no memory
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 3:17=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 27, 2023 at 2:51=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
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
> >  include/net/inet_connection_sock.h |  3 ++-
> >  net/ipv4/tcp_input.c               |  4 ++--
> >  net/ipv4/tcp_output.c              | 14 +++++++++++---
> >  3 files changed, 15 insertions(+), 6 deletions(-)
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
> > index 3cd92035e090..03111af6115d 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -5061,7 +5061,8 @@ static void tcp_data_queue(struct sock *sk, struc=
t sk_buff *skb)
> >                         reason =3D SKB_DROP_REASON_PROTO_MEM;
> >                         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDR=
OP);
> >                         sk->sk_data_ready(sk);
> > -                       goto drop;
> > +                       inet_csk(sk)->icsk_ack.pending |=3D ICSK_ACK_NO=
MEM;
>
> Also set ICSK_ACK_NOW ?
>
> We also need to make sure to send an immediate ACK WIN 0 in the case we q=
ueued
> the skb in an empty receive queue and we were under pressure.
>
> We do not want to have a delayed ACK sending a normal RWIN,
> then wait for another packet that we will probably drop.
>
> Look at the code :
>
> if (skb_queue_len(&sk->sk_receive_queue) =3D=3D 0)
>      sk_forced_mem_schedule(sk, skb->truesize);
> else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
>
> and refactor it to make sure to set  ICSK_ACK_NOMEM even on the first pac=
ket
> that bypassed the rmem_schedule().
>

Ok, that makes sense.

>
>
> > +                       goto out_of_window;
>
> Why forcing quickack mode ? Please leave the "goto drop;"
>

Hmm...because I want to make it send an immediate
ACK. Obviously, a ICSK_ACK_NOW flag should be
the better choice here.

> >                 }
> >
> >                 eaten =3D tcp_queue_rcv(sk, skb, &fragstolen);
> > @@ -5102,7 +5103,6 @@ static void tcp_data_queue(struct sock *sk, struc=
t sk_buff *skb)
> >  out_of_window:
> >                 tcp_enter_quickack_mode(sk, TCP_MAX_QUICKACKS);
> >                 inet_csk_schedule_ack(sk);
> > -drop:
> >                 tcp_drop_reason(sk, skb, reason);
> >                 return;
> >         }
> >
