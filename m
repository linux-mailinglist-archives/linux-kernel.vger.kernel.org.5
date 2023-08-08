Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F577362D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHHCFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjHHCFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:05:18 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020FD1705;
        Mon,  7 Aug 2023 19:05:17 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-584243f84eeso59049597b3.0;
        Mon, 07 Aug 2023 19:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691460316; x=1692065116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RzX+H34O3xzBmBu0+3rDM+jp+n0dX/ef1xcfV7+pzk=;
        b=LDmduLasP5b+0jeEmuMKEvQF92x6Py88tUoYG/tCCdPfpQui3Ul3y2hNsEuibam7AC
         pnhv0gsdU6agub4PI9NrJRCES/CyViUfQYKHyIGf4RxOnhBmqyDx81ln8OFbhBHlKM6B
         +rniKHXk3rcj0lCg11vZ0i4Gr4pW1UUYk55OM9NxkpdelyX775arGC8ehGHOK/3ikhgw
         zfSrGIzVnd4moRBCWGf9FybXbnV86reaMxNtEUVH5PMvIISObJECyDD0kWy2cWPziSV/
         5WHPD8xM6Zjvu64UNh66BwFqlQMWCnmXjbRRke/A+aFxT575udDSk4VpSNhu4Y07btFt
         49yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691460316; x=1692065116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RzX+H34O3xzBmBu0+3rDM+jp+n0dX/ef1xcfV7+pzk=;
        b=IrIkpiflBImYzq5o0ej1odU4XiwWpeiosJl/SVKCEEhdJ7PdNxcR/Pbw/v4hHPjxZv
         Fsr4dcxaLG1yih5+uoL/K1ua5kKjA9JJWXFt6iJZp9jGAGFo5zXI/L8MgevWZCMtHs64
         3Ar6xlVEf3J/n2MilpA/gSdhdQXD9VywVCVmdQuOFO1qK1TLQ4Dj7TWdTnkrmQCepqYY
         ZM4nlcyg8t7hxOJ8XoOKUKErpkEDrFP/RNUiCpzeKlGILsDRB38qeVY/amWVytrjqEfR
         TqOpAZZIC+vprWh9pDIgfW7x1xIayMTg+CFLPwcdDF8yOfb2NTTpimW96nK3B++MByec
         Mx0w==
X-Gm-Message-State: AOJu0YyKYfofUS2V5CXYJVqPHJaMUTv1RJrGXg93tSk+Fyvsl8oftMGu
        AakpeOLCLd/DxXwmSJzVKwkxOuBFkFgollwTzt6J8nET7wWKW4DM
X-Google-Smtp-Source: AGHT+IH3wQTVMPlAdfKQrwHrSOWe/aykviUtHPr9RqLJfxZQdkWi62GYi9IwnL433NDv4t0jBtNbt6KTqN7Ir5LMNnU=
X-Received: by 2002:a0d:d48f:0:b0:56d:2afa:5801 with SMTP id
 w137-20020a0dd48f000000b0056d2afa5801mr12663419ywd.46.1691460316133; Mon, 07
 Aug 2023 19:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230807134547.2782227-1-imagedong@tencent.com>
 <20230807134547.2782227-4-imagedong@tencent.com> <CANn89iKLXu1axtg9vMpbWv1CRYh=U_r38dJ8Q2s3togZcXqJ6Q@mail.gmail.com>
In-Reply-To: <CANn89iKLXu1axtg9vMpbWv1CRYh=U_r38dJ8Q2s3togZcXqJ6Q@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 8 Aug 2023 10:05:05 +0800
Message-ID: <CADxym3ZogoBh0cf35463XyVHOpefTsZe1txRF5L7jNUZc9zXeA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: tcp: fix unexcepted socket die when
 snd_wnd is 0
To:     Eric Dumazet <edumazet@google.com>
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 10:20=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Aug 7, 2023 at 3:47=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
> >
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > In tcp_retransmit_timer(), a window shrunk connection will be regarded
> > as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This is n=
ot
> > right all the time.
> >
> > The retransmits will become zero-window probes in tcp_retransmit_timer(=
)
> > if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will come up to
> > TCP_RTO_MAX sooner or later.
> >
> > However, the timer is not precise enough, as it base on timer wheel.
>
> > Sorry that I am not good at timer, but I know the concept of time-wheel=
.
>
> Can you remove this line, can we keep focused on the actual patch instead=
 ?
>
> Regardless of timer-wheel, a timer can be delayed under load.
>

Okay!

> > The longer of the timer, the rougher it will be. So the timeout is not
> > triggered after TCP_RTO_MAX, but 122877ms as I tested.
> >
> > Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always tru=
e
> > once the RTO come up to TCP_RTO_MAX, and the socket will die.
> >
> > Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout=
',
> > which is exact the timestamp of the timeout. Meanwhile, using
> > "max(tp->retrans_stamp, tp->rcv_tstamp)" as the last updated timestamp =
in
> > the receiving path, as "tp->rcv_tstamp" can restart from idle, then
> > tp->rcv_tstamp could already be a long time (minutes or hours) in the
> > past even on the first RTO.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Link: https://lore.kernel.org/netdev/CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6=
gSD2XT8pyAMM096pg@mail.gmail.com/
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> > v2:
> > - consider the case of the connection restart from idle, as Neal commen=
t
> > ---
> >  net/ipv4/tcp_timer.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index d45c96c7f5a4..e4b2d8706cae 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -454,6 +454,14 @@ static void tcp_fastopen_synack_timer(struct sock =
*sk, struct request_sock *req)
> >                           req->timeout << req->num_timeout, TCP_RTO_MAX=
);
> >  }
> >
> > +static bool tcp_rtx_probe0_timed_out(struct sock *sk)
> > +{
> > +       struct tcp_sock *tp =3D tcp_sk(sk);
> > +       u32 last_ts;
> > +
> > +       last_ts =3D max(tp->retrans_stamp, tp->rcv_tstamp);
>
> u32     retrans_stamp;  /* Timestamp of the last retransmit,
> u32     rcv_tstamp;     /* timestamp of last received ACK (for keepalives=
) */
>
> Both fields receive tcp_jiffies32 values, which wrap every 2^32 ticks.
>
> So max(A, B) won't work as you expect...
>
> You need to use before(), after() or something like that.

Now I know how the before()/after() works. I thought they
simply compared the arguments.

I'll use brefore/after here instead.

Thanks!
Menglong Dong

>
> https://en.wikipedia.org/wiki/Serial_number_arithmetic#General_Solution
>
>
> > +       return inet_csk(sk)->icsk_timeout - last_ts > TCP_RTO_MAX;
> > +}
> >
> >  /**
> >   *  tcp_retransmit_timer() - The TCP retransmit timeout handler
> > @@ -519,7 +527,7 @@ void tcp_retransmit_timer(struct sock *sk)
> >                                             tp->snd_una, tp->snd_nxt);
> >                 }
> >  #endif
> > -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
> > +               if (tcp_rtx_probe0_timed_out(sk)) {
> >                         tcp_write_err(sk);
> >                         goto out;
> >                 }
> > --
> > 2.40.1
> >
