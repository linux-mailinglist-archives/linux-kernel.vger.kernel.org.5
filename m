Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD330774203
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjHHRcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjHHRba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:31:30 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ED421E4D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:13:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-407db3e9669so290541cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691511184; x=1692115984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn2bzFezk/UZyxUtkuS/wxumoulHOnZ5vgKYBp+qi5w=;
        b=YUIPFykUv4NFNTmJDRfYV4eA7A6vrAQ46CX9TZOlbVyCPhqPG/8mRYvOv3LFEtKOai
         SUYId6mhf968MTWnFgoLydQUt/s7AZrAnsstngHUJXAyAeaLKRV40YkCbYkKfIYGovDL
         BiiTIqUQlA6DH9kXXPZQMckBzYFKjHq77xIe1VCVr044B1cOE5bBrLH1XTtJ+FMnfqOS
         4mn38f9rySGyTXAQRDnJwmqPzTvODDn6qdOVDixDqAvufQSP8zWHJC2wqrpujJ1akHrQ
         9h827weVJAuQRlJRcUr/ljjoTR7spBex2H2dmmHCNUGhYU2BSHSjf/Ao9AUvUkyS1N2q
         wSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511184; x=1692115984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn2bzFezk/UZyxUtkuS/wxumoulHOnZ5vgKYBp+qi5w=;
        b=c7sDjO4Y+Fxf/0w7KRRw6UoILZhF42/VemN4kKOZDa4yGQBnb3E3/OFfNy6xqYrUHl
         vKcHbvfWFiMxlK8a7o4CFjjlfsSh58GxIMZsZqsK/xfwrNmKUUCGsXJKQPfbLpw5/HmM
         K6TouQOnFVuy7zVKyGTNR7ad2gS0YBETXPFMrC21w4/A5vo7+XeeKU90o9DgHv45Y2Yv
         v7wOI6Ts4GBbgHudDsOhHQseRfzwTVzQoPfVYuQ6/KMZcK65D0vnFGzQXGVfCCK3C4wX
         ZaoRS6VvZHjoa1VKeum1CvSALutDyQw9vrRvtLT5uXvL2RsLRZewrycZmgeIOu0reTEn
         8aiQ==
X-Gm-Message-State: AOJu0Yw4ot++J/L1qquT/xe5AhlbWuGqtBJpBFUQ5l3zvgJfgz4wuHAh
        PpybEV2ydnI58cUsrvG6Osw0STaW+P/tstsNJ4jVaXJAzQsJ+lkX7SqpOw==
X-Google-Smtp-Source: AGHT+IF/S2chbVVgN+yPnHABejpoo8ifP2bZqpJf8cs3Tyc6YLaH9rDxpT5eAuURhdr8o0ULbCZm5CbGz0HFlBZF3Nc=
X-Received: by 2002:a05:622a:d0:b0:403:aa88:cf7e with SMTP id
 p16-20020a05622a00d000b00403aa88cf7emr595630qtw.29.1691483209473; Tue, 08 Aug
 2023 01:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
 <20230808055817.3979-1-me@manjusaka.me>
In-Reply-To: <20230808055817.3979-1-me@manjusaka.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 8 Aug 2023 10:26:36 +0200
Message-ID: <CANn89iKxJThy4ZVq4do6Z1bOZsRptfN6N8ydPaHQAmYKCjtOnw@mail.gmail.com>
Subject: Re: [PATCH v2] tracepoint: add new `tcp:tcp_ca_event` trace event
To:     Manjusaka <me@manjusaka.me>
Cc:     ncardwell@google.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 7:59=E2=80=AFAM Manjusaka <me@manjusaka.me> wrote:
>
> In normal use case, the tcp_ca_event would be changed in high frequency.
>
> It's a good indicator to represent the network quanlity.

quality ?

Honestly, it is more about TCP stack tracing than 'network quality'

>
> So I propose to add a `tcp:tcp_ca_event` trace event
> like `tcp:tcp_cong_state_set` to help the people to
> trace the TCP connection status
>
> Signed-off-by: Manjusaka <me@manjusaka.me>
> ---
>  include/net/tcp.h          |  9 ++------
>  include/trace/events/tcp.h | 45 ++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_cong.c        | 10 +++++++++
>  3 files changed, 57 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0ca972ebd3dd..a68c5b61889c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struct s=
ock *sk)
>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>  }
>
> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event=
 event)
> -{
> -       const struct inet_connection_sock *icsk =3D inet_csk(sk);
> -
> -       if (icsk->icsk_ca_ops->cwnd_event)
> -               icsk->icsk_ca_ops->cwnd_event(sk, event);
> -}
> +/* from tcp_cong.c */
> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
>
>  /* From tcp_cong.c */
>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index bf06db8d2046..b374eb636af9 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
>                   __entry->cong_state)
>  );
>
> +TRACE_EVENT(tcp_ca_event,
> +
> +       TP_PROTO(struct sock *sk, const u8 ca_event),
> +
> +       TP_ARGS(sk, ca_event),
> +
> +       TP_STRUCT__entry(
> +               __field(const void *, skaddr)
> +               __field(__u16, sport)
> +               __field(__u16, dport)
> +               __array(__u8, saddr, 4)
> +               __array(__u8, daddr, 4)
> +               __array(__u8, saddr_v6, 16)
> +               __array(__u8, daddr_v6, 16)
> +               __field(__u8, ca_event)
> +       ),
> +

Please add the family (look at commit 3dd344ea84e1 ("net: tracepoint:
exposing sk_family in all tcp:tracepoints"))



> +       TP_fast_assign(
> +               struct inet_sock *inet =3D inet_sk(sk);
> +               __be32 *p32;
> +
> +               __entry->skaddr =3D sk;
> +
> +               __entry->sport =3D ntohs(inet->inet_sport);
> +               __entry->dport =3D ntohs(inet->inet_dport);
> +
> +               p32 =3D (__be32 *) __entry->saddr;
> +               *p32 =3D inet->inet_saddr;
> +
> +               p32 =3D (__be32 *) __entry->daddr;
> +               *p32 =3D  inet->inet_daddr;

We keep copying IPv4 addresses that might contain garbage for IPv6 sockets =
:/

> +
> +               TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_dadd=
r,
> +                          sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);

I will send a cleanup, because IP_STORE_ADDRS() should really take
care of all details.


> +
> +               __entry->ca_event =3D ca_event;
> +       ),
> +
> +       TP_printk("sport=3D%hu dport=3D%hu saddr=3D%pI4 daddr=3D%pI4 sadd=
rv6=3D%pI6c daddrv6=3D%pI6c ca_event=3D%u",
> +                 __entry->sport, __entry->dport,
> +                 __entry->saddr, __entry->daddr,
> +                 __entry->saddr_v6, __entry->daddr_v6,
> +                 __entry->ca_event)

Please print the symbol instead of numeric ca_event.

Look at show_tcp_state_name() for instance.
