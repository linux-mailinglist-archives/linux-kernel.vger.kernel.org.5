Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9779E773F72
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHHQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjHHQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:46:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D117170EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:56:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-348c7075afcso149575ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691510169; x=1692114969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QGjHzRfbCCkNjNIAknClWHbX+0mqrJSn4alogR9LmE=;
        b=7MXOeO2AWpO2Bt6uM26Wb5bSSJjj69QW3nmy0ryfflb8lDjuv8OPqrg6l69DaSgIOw
         CPdcV1FBsPTp8gxa97IpgskNzVBk3yTT99f1u+WWiN5a7hQnwC9HIxUQCK0CahLRIanT
         7TlG+cQ89/OU9wG3RCTwLpv2UcnzGkXAfCqSsy8tK19mOwGpZECxLys0UjsZ/ZBKbwwr
         l7lzIZuEtVeViwYbhYdr/aLIy6czbUkA2DHEkxanIpQODbC2MmVKOmtbw39YVUDfyrCF
         j5BBlgg1jvtfSvlyV6lo1LJZb0WvmaRt6BycLrBvh0RgwApM4L797o9EWj3V8J6PjUG8
         Nllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510169; x=1692114969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QGjHzRfbCCkNjNIAknClWHbX+0mqrJSn4alogR9LmE=;
        b=ezLh2r1q+R9f2BQNdCmg0t5j4QjKLFiX+7WkBuJIEOn71HE9orZ2IV6DSQlNnI9f1D
         yz1xudvNBhstavU+A9/KHTckTR09U1dhiezTnmaxreYe+tJm078vhgFyxdMAJr3VJzmn
         5dQtCwYDdOhKgJd79FOnFkqEVpcBU3iqu5j38zkIv/M5jUTAoX5uW9h+Ee+XxOVm+dP2
         hHn8Wkx/u0rGIbIJ4xCIk6flfnJupvCPqg1NaxiJVk24xFr2+cQss9SV/Lf4CPeNeYxQ
         yDliTE695/jqPpaL/EhLhO0w1yFKMyBGf3q+XCU35p/rA9SFm8tJhinwTesRd7Dog3Ns
         qcxQ==
X-Gm-Message-State: AOJu0YxXCG9vRj9JYp6Jd2VWve43wcqD5MxSvPmDzXQYTEjjsHu82QCI
        8jBVttzmLBXLaQ8PG5hoacMLWTxppxFuvRVIwirJCV+d8R8S/0Dyj5G2Mg==
X-Google-Smtp-Source: AGHT+IEcS2KttxAPl/PPlr9cHN2Zs39UZYwywvRTTc3RHtQ/HQ3pnOJ/bgTkgnT/sABlEgq3j7CobXhoy9f1jtaGAKI=
X-Received: by 2002:a05:622a:1456:b0:3fa:45ab:22a5 with SMTP id
 v22-20020a05622a145600b003fa45ab22a5mr631672qtx.27.1691498976444; Tue, 08 Aug
 2023 05:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230808115835.2862058-1-imagedong@tencent.com> <20230808115835.2862058-4-imagedong@tencent.com>
In-Reply-To: <20230808115835.2862058-4-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 8 Aug 2023 14:49:25 +0200
Message-ID: <CANn89iK16069CvbA+p=WyZVYftvHs=FviQp1GSWUTG2ihRfKDA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: tcp: fix unexcepted socket die when
 snd_wnd is 0
To:     menglong8.dong@gmail.com
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 1:59=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> In tcp_retransmit_timer(), a window shrunk connection will be regarded
> as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This is not
> right all the time.
>
> The retransmits will become zero-window probes in tcp_retransmit_timer()
> if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will come up to
> TCP_RTO_MAX sooner or later.
>
> However, the timer can be delayed and be triggered after 122877ms, not
> TCP_RTO_MAX, as I tested.
>
> Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always true
> once the RTO come up to TCP_RTO_MAX, and the socket will die.
>
> Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
> which is exact the timestamp of the timeout. Meanwhile, using the later
> one of tp->retrans_stamp and tp->rcv_tstamp as the last updated timestamp
> in the receiving path, as "tp->rcv_tstamp" can restart from idle, then
> tp->rcv_tstamp could already be a long time (minutes or hours) in the
> past even on the first RTO.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/netdev/CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6gS=
D2XT8pyAMM096pg@mail.gmail.com/
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v3:
> - use after() instead of max() in tcp_rtx_probe0_timed_out()
> v2:
> - consider the case of the connection restart from idle, as Neal comment
> ---
>  net/ipv4/tcp_timer.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index d45c96c7f5a4..f30d1467771c 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -454,6 +454,18 @@ static void tcp_fastopen_synack_timer(struct sock *s=
k, struct request_sock *req)
>                           req->timeout << req->num_timeout, TCP_RTO_MAX);
>  }
>
> +static bool tcp_rtx_probe0_timed_out(struct sock *sk)

const struct sock *sk

> +{
> +       struct tcp_sock *tp =3D tcp_sk(sk);

const struct tcp_sock *tp =3D tcp_sk(sk);

> +       u32 timeout_ts, rtx_ts, rcv_ts;
> +
> +       rtx_ts =3D tp->retrans_stamp;
> +       rcv_ts =3D tp->rcv_tstamp;
> +       timeout_ts =3D after(rtx_ts, rcv_ts) ? rtx_ts : rcv_ts;
> +       timeout_ts +=3D TCP_RTO_MAX;

If we are concerned with a socket dying too soon, I would suggest
adding 2*TCP_RTO_MAX instead of TCP_RTO_MAX

When a receiver is OOMing, it is possible the ACK RWIN 0 can not be sent al=
l,
so tp->rcv_tstamp will not be refreshed. Or ACK could be lost in the
network path.

This also suggests the net_dbg_ratelimited("Peer %pI4:%u/%u
unexpectedly shrunk window %u:%u (repaired)\n"...) messages
are slightly wrong, because they could be printed even if we did not
receive a new ACK packet from the remote peer.

Perhaps we should change them to include delays (how long @skb stayed
in rtx queue, how old is the last ACK we received)

> +
> +       return after(inet_csk(sk)->icsk_timeout, timeout_ts);
> +}
>
>  /**
>   *  tcp_retransmit_timer() - The TCP retransmit timeout handler
> @@ -519,7 +531,7 @@ void tcp_retransmit_timer(struct sock *sk)
>                                             tp->snd_una, tp->snd_nxt);
>                 }
>  #endif
> -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
> +               if (tcp_rtx_probe0_timed_out(sk)) {
>                         tcp_write_err(sk);
>                         goto out;
>                 }
> --
> 2.40.1
>
