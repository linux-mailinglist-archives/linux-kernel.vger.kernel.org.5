Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A06A7724B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjHGMvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjHGMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:51:22 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDBFC9;
        Mon,  7 Aug 2023 05:51:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 248F45C00AF;
        Mon,  7 Aug 2023 08:51:21 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute4.internal (MEProxy); Mon, 07 Aug 2023 08:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691412681; x=1691499081; bh=Lt8hOx2s13NynnFjaOie8s5FfN5HGBhA+5k
        SEKOK+zc=; b=QodS85LZyPZ3yoGP1hEd5iCF2fM0nFMaO5nA/Zoe8c+0zxYqoaK
        i7uxbDKtMfj0k9spjPC4dAsgCjkWGwIfu91A8OYeKL1KMTqdqpvSLSdvPj9qTMlV
        KdCDLt1bAil53Oy5t68Ry7iZiethODhcusrezTd2QmpSTErRlKBnXgsVz6aI2j5P
        4rixov0B96J0LMUtzHrsJSplo0au/TIds9Hgpjj25qCHBVbMdkU4RacKG+cEsOgS
        lZj5rliz+r5l/PXy62eXi6pbXw0P9r6pq9YBuzGj+8HyrldEAbYkFROl1DfvSbqf
        969LhD+wMU+g5mFzv/aKXBWaZjI1/YROlJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691412681; x=1691499081; bh=Lt8hOx2s13NynnFjaOie8s5FfN5HGBhA+5k
        SEKOK+zc=; b=hRCDQ0LY3RH0+tWuYz92V/SIeW5z6Vw7kCOIG9j7fTzoHKaPAbt
        lp9Kb/l8W2dzPYQxybwvhljH7A4/EAJlZUDaF7b01eAqFNEfAQVsNt4RK2rtxbBm
        XZgUh3FfLK/813CYmkUqmloP3XJ1DZCS8qwDgYJi5wBorG+i2KMv+VDBFUuFrbKK
        mgPqaBnGS60VXzCtfGFAYQmqw0b+OXkneFzyku878ThSfMBgyVELTSw1xqrSSB+A
        GXOUGDylhwyjExAXXkCETO6vUblWmON2zQP5e/DkBK/MG4bGjFauo4HPVBfDsikZ
        C5Fek/3laeT2NVh9jIALO0ItbOCy5yPCtoQ==
X-ME-Sender: <xms:yejQZK5M36t4a2oD3bxXAxns2etV5uRqb6eu21EiPp_zMnfxsfscOg>
    <xme:yejQZD4WVqmVThIfd2VubbdgMjGW7bLe__0tqqkZHh3D_bzAsYWLf7TpEA7ktfbiq
    Wkil1mPob_i4hVW3GY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpeforghn
    jhhushgrkhgruceomhgvsehmrghnjhhushgrkhgrrdhmvgeqnecuggftrfgrthhtvghrnh
    epffdvfeejleefjeegfedtieeuleelhffhuedufeevkeeltdelgeetiefgkefhvddvnecu
    ffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgvsehmrghnjhhushgrkhgrrdhmvg
X-ME-Proxy: <xmx:yejQZJeEK6667LgtwumI09ZH6UK9qv3-ljNzgnvkObxoeWRCMrv8Kw>
    <xmx:yejQZHKKvrPaPpMWLq6hr9cKIBnRM3E_fK9bIvPzkTGtXTHtMKV7Dw>
    <xmx:yejQZOIi33H1SC6G8cs5vsGZN0Fwwmbrbs3qOekr-caAjTBQlYC7qg>
    <xmx:yejQZN_AMHyrrh4QUSJk6wLHteV9-yMErJ5VC1GNuYEnEFYpjoF3Iw>
Feedback-ID: i3ea9498d:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EAA2831A0064; Mon,  7 Aug 2023 08:51:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <a4d189f4-ab60-49ca-b8fe-03b374518b18@app.fastmail.com>
In-Reply-To: <CANn89i+bMh-xU7PCxf_O5N+vy=83S+V=23mAAmbCuhjuP5Ob9g@mail.gmail.com>
References: <20230806075216.13378-1-me@manjusaka.me>
 <CANn89i+bMh-xU7PCxf_O5N+vy=83S+V=23mAAmbCuhjuP5Ob9g@mail.gmail.com>
Date:   Mon, 07 Aug 2023 20:51:00 +0800
From:   Manjusaka <me@manjusaka.me>
To:     "Eric Dumazet" <edumazet@google.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] [RFC PATCH] tcp event: add new tcp:tcp_cwnd_restart event
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do not include code before variable declarations.
Sorry about that. I will update the code later.

> I would rather add a trace in tcp_ca_event(), this would be more gener=
ic ?

https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_cong.c#L41

I think maybe we already have the tcp_ca_event but named tcp_cong_state_=
set?


On Mon, Aug 7, 2023, at 8:34 PM, Eric Dumazet wrote:
> On Sun, Aug 6, 2023 at 9:52=E2=80=AFAM Manjusaka <me@manjusaka.me> wro=
te:
> >
> > The tcp_cwnd_restart function would be called if the user has enable=
d the
> > tcp_slow_start_after_idle configuration and would be triggered when =
the
> > connection is idle (like LONG RTO etc.). I think it would be great to
> > add a new trace event named 'tcp:tcp_cwnd_reset'; it would help peop=
le
> > to monitor the TCP state in a complicated network environment(like
> > overlay/underlay SDN in Kubernetes, etc)
> >
> > Signed-off-by: Manjusaka <me@manjusaka.me>
> > ---
> >  include/trace/events/tcp.h | 7 +++++++
> >  net/ipv4/tcp_output.c      | 1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> > index bf06db8d2046..fa44191cc609 100644
> > --- a/include/trace/events/tcp.h
> > +++ b/include/trace/events/tcp.h
> > @@ -187,6 +187,13 @@ DEFINE_EVENT(tcp_event_sk, tcp_rcv_space_adjust,
> >         TP_ARGS(sk)
> >  );
> >
> > +DEFINE_EVENT(tcp_event_sk, tcp_cwnd_restart,
> > +
> > +       TP_PROTO(struct sock *sk),
> > +
> > +       TP_ARGS(sk)
> > +);
> > +
> >  TRACE_EVENT(tcp_retransmit_synack,
> >
> >         TP_PROTO(const struct sock *sk, const struct request_sock *r=
eq),
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 51d8638d4b4c..e902fa74303d 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -141,6 +141,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
> >   */
> >  void tcp_cwnd_restart(struct sock *sk, s32 delta)
> >  {
> > +       trace_tcp_cwnd_restart(sk);
>=20
> Do not include code before variable declarations.
>=20
> >         struct tcp_sock *tp =3D tcp_sk(sk);
> >         u32 restart_cwnd =3D tcp_init_cwnd(tp, __sk_dst_get(sk));
> >         u32 cwnd =3D tcp_snd_cwnd(tp);
> > --
> > 2.34.1
> >
>=20
> I would rather add a trace in tcp_ca_event(), this would be more gener=
ic ?
>=20
