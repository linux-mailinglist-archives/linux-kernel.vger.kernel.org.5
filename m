Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B41773FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjHHQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjHHQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:52:52 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2533418875
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:58:27 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40c72caec5cso290421cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691510306; x=1692115106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCOXJYzxETCH/0UcvxLQeHGSMM7DSEXKUT9P3Dlmymo=;
        b=XY594UEiNBVdnowDggoSTsy01/7LFkzZtWyJ0osca2l37W78HGpDPMoIqFYvu62sJ7
         LOfIkxgpcwCQD3onyp1myYYx4Lve3r2KmyWeVl/ONp//on9vHq6TaoT1HRxeg7yP81aQ
         +ksYegCJOmnKd67lUYkM0RkG2PmMd4VBnoIu5UVhTOrudjcC41oPzrPSb6QFq04ZBJX+
         cRcNqLfBMqJ/ZeZVIU+igrWi+4qmnc7LSaGU81l+vIVsy3DxQImk4ymN4mEkeNE9SQgP
         RZqjAVRhg+S9ptIeLIwgrEh//Otme/dNntvOX8Eyw6DHYPtNfeDp22XpEolICEt4/F3H
         qkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510306; x=1692115106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCOXJYzxETCH/0UcvxLQeHGSMM7DSEXKUT9P3Dlmymo=;
        b=btqHGIkzJNhwrmCYfHpsXuYohR8sDBDkGGryVn+4x3uaOm9dth7mXZ+eoMlKh3xPgS
         eXz18UkBLJ1I+3vl7BhQYmsfRfTIWrBvpUhySeKslpF1R4jxFfQ5mUDnjbuY5oGdLyyH
         rLLDCWQjbvoEg1CiHUAomQd1s5OtBAkl1Nv4x5hwZjZm78dSk5/ndBTaucCGdmIsaHa6
         ZRJ0uoskOcjP0rF0EKSXYBqLvxlaLQCjx/dEMahXLJRgOLMJsW78Us8hfj3TbeUfYuzc
         5L72RZrw+GjgbQ5psxpRdFXkt7XUZBMU9ld2QVJMDYTDDZkcmJIEJqUS1qqW2nK4oxX1
         UwpQ==
X-Gm-Message-State: AOJu0Yymg9v5MwwHYIrtsBQYepfdZi90AoneF81CpiwtPS8DeL5SQB6m
        ijemCZyVGr1yFitj4WEPevMOCQ5yOUrivO6ZpIAq+qEtR30z+rTEVqU=
X-Google-Smtp-Source: AGHT+IEfM3zZpi2A8IEkcUU11DnAyYRP6HYaBR73Q/AKzK2pHMPvaVHfkSYylHJ4uhb2VI1kTwpMv6BetR8BNyyQJjc=
X-Received: by 2002:ac8:5951:0:b0:403:96e3:4745 with SMTP id
 17-20020ac85951000000b0040396e34745mr749543qtz.20.1691484513351; Tue, 08 Aug
 2023 01:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
 <20230808055817.3979-1-me@manjusaka.me> <CANn89iKxJThy4ZVq4do6Z1bOZsRptfN6N8ydPaHQAmYKCjtOnw@mail.gmail.com>
 <af02d2a9-4655-45a1-8c3a-d9921bfdbc35@manjusaka.me>
In-Reply-To: <af02d2a9-4655-45a1-8c3a-d9921bfdbc35@manjusaka.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 8 Aug 2023 10:48:21 +0200
Message-ID: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
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

On Tue, Aug 8, 2023 at 10:46=E2=80=AFAM Manjusaka <me@manjusaka.me> wrote:
>
>
>
> On 2023/8/8 16:26, Eric Dumazet wrote:
> > On Tue, Aug 8, 2023 at 7:59=E2=80=AFAM Manjusaka <me@manjusaka.me> wrot=
e:
> >>
> >> In normal use case, the tcp_ca_event would be changed in high frequenc=
y.
> >>
> >> It's a good indicator to represent the network quanlity.
> >
> > quality ?
> >
> > Honestly, it is more about TCP stack tracing than 'network quality'
> >
> >>
> >> So I propose to add a `tcp:tcp_ca_event` trace event
> >> like `tcp:tcp_cong_state_set` to help the people to
> >> trace the TCP connection status
> >>
> >> Signed-off-by: Manjusaka <me@manjusaka.me>
> >> ---
> >>  include/net/tcp.h          |  9 ++------
> >>  include/trace/events/tcp.h | 45 +++++++++++++++++++++++++++++++++++++=
+
> >>  net/ipv4/tcp_cong.c        | 10 +++++++++
> >>  3 files changed, 57 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/net/tcp.h b/include/net/tcp.h
> >> index 0ca972ebd3dd..a68c5b61889c 100644
> >> --- a/include/net/tcp.h
> >> +++ b/include/net/tcp.h
> >> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struc=
t sock *sk)
> >>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
> >>  }
> >>
> >> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_ev=
ent event)
> >> -{
> >> -       const struct inet_connection_sock *icsk =3D inet_csk(sk);
> >> -
> >> -       if (icsk->icsk_ca_ops->cwnd_event)
> >> -               icsk->icsk_ca_ops->cwnd_event(sk, event);
> >> -}
> >> +/* from tcp_cong.c */
> >> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
> >>
> >>  /* From tcp_cong.c */
> >>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
> >> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> >> index bf06db8d2046..b374eb636af9 100644
> >> --- a/include/trace/events/tcp.h
> >> +++ b/include/trace/events/tcp.h
> >> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
> >>                   __entry->cong_state)
> >>  );
> >>
> >> +TRACE_EVENT(tcp_ca_event,
> >> +
> >> +       TP_PROTO(struct sock *sk, const u8 ca_event),
> >> +
> >> +       TP_ARGS(sk, ca_event),
> >> +
> >> +       TP_STRUCT__entry(
> >> +               __field(const void *, skaddr)
> >> +               __field(__u16, sport)
> >> +               __field(__u16, dport)
> >> +               __array(__u8, saddr, 4)
> >> +               __array(__u8, daddr, 4)
> >> +               __array(__u8, saddr_v6, 16)
> >> +               __array(__u8, daddr_v6, 16)
> >> +               __field(__u8, ca_event)
> >> +       ),
> >> +
> >
> > Please add the family (look at commit 3dd344ea84e1 ("net: tracepoint:
> > exposing sk_family in all tcp:tracepoints"))
> >
> >
> >
> >> +       TP_fast_assign(
> >> +               struct inet_sock *inet =3D inet_sk(sk);
> >> +               __be32 *p32;
> >> +
> >> +               __entry->skaddr =3D sk;
> >> +
> >> +               __entry->sport =3D ntohs(inet->inet_sport);
> >> +               __entry->dport =3D ntohs(inet->inet_dport);
> >> +
> >> +               p32 =3D (__be32 *) __entry->saddr;
> >> +               *p32 =3D inet->inet_saddr;
> >> +
> >> +               p32 =3D (__be32 *) __entry->daddr;
> >> +               *p32 =3D  inet->inet_daddr;
> >
> > We keep copying IPv4 addresses that might contain garbage for IPv6 sock=
ets :/
> >
> >> +
> >> +               TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_d=
addr,
> >> +                          sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> >
> > I will send a cleanup, because IP_STORE_ADDRS() should really take
> > care of all details.
> >
> >
> >> +
> >> +               __entry->ca_event =3D ca_event;
> >> +       ),
> >> +
> >> +       TP_printk("sport=3D%hu dport=3D%hu saddr=3D%pI4 daddr=3D%pI4 s=
addrv6=3D%pI6c daddrv6=3D%pI6c ca_event=3D%u",
> >> +                 __entry->sport, __entry->dport,
> >> +                 __entry->saddr, __entry->daddr,
> >> +                 __entry->saddr_v6, __entry->daddr_v6,
> >> +                 __entry->ca_event)
> >
> > Please print the symbol instead of numeric ca_event.
> >
> > Look at show_tcp_state_name() for instance.
>
> Thanks for the kindness code review, I still get some issue here(Sorry fo=
r the first time to contribute):
>
> 1. > We keep copying IPv4 addresses that might contain garbage for IPv6 s=
ockets :/
>
> I'm not getting your means, would you mean that we should only save the I=
Pv4 Address here?
>
> 2. > I will send a cleanup, because IP_STORE_ADDRS() should really take c=
are of all details.
>
> I think you will make the address assignment code in TP_fast_assign as a =
new function.
>
> Should I submit the new change until you send the cleanup patch or I can =
make this in my patch(cleanup the address assignment)
>

Wait a bit, I am sending fixes today, so that no more copy/paste
duplicates the issues.
