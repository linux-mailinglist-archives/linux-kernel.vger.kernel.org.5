Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9887667D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjG1Ix2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjG1Iwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:52:44 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA9E5590
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:50:52 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40550136e54so237471cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690534251; x=1691139051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BbsbrimMUTeJgAjEOYExIYFi9iKyLIi1aTlrJrce/4=;
        b=n3tiZAGSUmSnRTHAUm1LbVpuhD1JjoJZkKXPcU1x7dUQYq2EMq/QpouxW9uoVbNOrh
         Q5INXn2JelMC7PT/tPk2xoBMrubb4mp7GnvJB3EcZstD5RexXHy+xSsHiMXaVVC6+q/1
         4tb7vyHVAwvzGiHThPu6vaQeF1W8x4g8L8NMG07dIQjP52C1B6qa9EQ60xO9K/RV+gq5
         Z/NR7eVvJMQSlvUw4L2SH25RM07Ql1mHgW2WzKaV67nmAp2aGPBZIKRL/KY/mHry9yp9
         J5fAj636BMAZ6zMFJ8Z1d5Rf0QAcfjl/LNtCgHXUsBZccnEO/FDZeu5Tj1KnGSB83PZq
         WuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690534251; x=1691139051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BbsbrimMUTeJgAjEOYExIYFi9iKyLIi1aTlrJrce/4=;
        b=R/fTTe/F84X8X8qZMIU5WOljsexz9SUbgWFRf0jrHKZwdwhknQMXM6GBxA1wE6XPH3
         PdfbvOVGVc8fKX/6IV2yiogw8A1iYSRWyJAfV4+vvjQP/+RbcRlWAYAdb3M6vPcnV7FV
         WCiG+vmsj7L8mG+9cwxHqiuwAhMBQhdmj5cg+63VoaFVph9drOmMX/8jK073tzKsI687
         XNpLh/kY4ZhPm4BQwhvdnK8Uks5cI5CUfR2hqEV5hkJEQmqccOa/Zd9Bz8Jr8Kt25t+f
         NZ/z7MV5wrMd2oMpzrKHK8nGAgr66DTJca98ffWCzj1Pn02lH0B9vZu+aseH5FA2qDS0
         njVg==
X-Gm-Message-State: ABy/qLYrW7JW/XyJ1ZfoS8C1DIaQYkR/wmnVpP1iMs1AqgSRym8eghvL
        vfjeJ+Y/qt4j6aaFAE/oQZjhkrM6wmpzQBburZGvTQ==
X-Google-Smtp-Source: APBJJlEBplEfEwPJvsgNWskc0+quQPcQVXNt02YrlL/uSziHRB5BxCRtAb5wWlFabuW8ZS0821clta3/CmTMUuepSVY=
X-Received: by 2002:a05:622a:1486:b0:3f0:af20:1a37 with SMTP id
 t6-20020a05622a148600b003f0af201a37mr169132qtx.15.1690534251184; Fri, 28 Jul
 2023 01:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com>
 <20230727125125.1194376-4-imagedong@tencent.com> <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
 <CADxym3YhjMv3Xkts99fiajq-cR-BqxDayKFzFZ1L49BNfFXkdw@mail.gmail.com>
 <CADVnQynQ1Hw+Jh7pjdNw_Mo4tWZV8V_sA+L-o=O4uV+9Gv7Prg@mail.gmail.com> <CADxym3Zqb2CCpJojGiT7gVL98GDdOmjxqLY6ApLeP2zZU1Kn3Q@mail.gmail.com>
In-Reply-To: <CADxym3Zqb2CCpJojGiT7gVL98GDdOmjxqLY6ApLeP2zZU1Kn3Q@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 28 Jul 2023 10:50:40 +0200
Message-ID: <CANn89i+WnwgpGy4v=aXsjThPBA2FQzWx9Y=ycXWWGLDdtDHBig@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Neal Cardwell <ncardwell@google.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 8:25=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Fri, Jul 28, 2023 at 12:44=E2=80=AFPM Neal Cardwell <ncardwell@google.=
com> wrote:
> >
> > On Thu, Jul 27, 2023 at 7:57=E2=80=AFPM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > On Fri, Jul 28, 2023 at 3:31=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Thu, Jul 27, 2023 at 2:52=E2=80=AFPM <menglong8.dong@gmail.com> =
wrote:
> > > > >
> > > > > From: Menglong Dong <imagedong@tencent.com>
> > > > >
> > > > > In tcp_retransmit_timer(), a window shrunk connection will be reg=
arded
> > > > > as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. Thi=
s is not
> > > > > right all the time.
> > > > >
> > > > > The retransmits will become zero-window probes in tcp_retransmit_=
timer()
> > > > > if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will come =
up to
> > > > > TCP_RTO_MAX sooner or later.
> > > > >
> > > > > However, the timer is not precise enough, as it base on timer whe=
el.
> > > > > Sorry that I am not good at timer, but I know the concept of time=
-wheel.
> > > > > The longer of the timer, the rougher it will be. So the timeout i=
s not
> > > > > triggered after TCP_RTO_MAX, but 122877ms as I tested.
> > > > >
> > > > > Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is alwa=
ys true
> > > > > once the RTO come up to TCP_RTO_MAX.
> > > > >
> > > > > Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_t=
imeout',
> > > > > which is exact the timestamp of the timeout.
> > > > >
> > > > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > > > ---
> > > > >  net/ipv4/tcp_timer.c | 6 +++++-
> > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > > > > index 470f581eedd4..3a20db15a186 100644
> > > > > --- a/net/ipv4/tcp_timer.c
> > > > > +++ b/net/ipv4/tcp_timer.c
> > > > > @@ -511,7 +511,11 @@ void tcp_retransmit_timer(struct sock *sk)
> > > > >                                             tp->snd_una, tp->snd_=
nxt);
> > > > >                 }
> > > > >  #endif
> > > > > -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX)=
 {
> > > > > +               /* It's a little rough here, we regard any valid =
packet that
> > > > > +                * update tp->rcv_tstamp as the reply of the retr=
ansmitted
> > > > > +                * packet.
> > > > > +                */
> > > > > +               if ((u32)icsk->icsk_timeout - tp->rcv_tstamp > TC=
P_RTO_MAX) {
> > > > >                         tcp_write_err(sk);
> > > > >                         goto out;
> > > > >                 }
> > > >
> > > >
> > > > Hmm, this looks like a net candidate, since this is unrelated to th=
e
> > > > other patches ?
> > >
> > > Yeah, this patch can be standalone. However, considering the
> > > purpose of this series, it is necessary. Without this patch, the
> > > OOM probe will always timeout after a few minutes.
> > >
> > > I'm not sure if I express the problem clearly in the commit log.
> > > Let's explain it more.
> > >
> > > Let's mark the timestamp of the 10th timeout of the rtx timer
> > > as TS1. Now, the retransmission happens and the ACK of
> > > the retransmitted packet will update the tp->rcv_tstamp to
> > > TS1+rtt.
> > >
> > > The RTO now is TCP_RTO_MAX. So let's see what will
> > > happen in the 11th timeout. As we timeout after 122877ms,
> > > so tcp_jiffies32 now is "TS1+122877ms", and
> > > "tcp_jiffies32 - tp->rcv_tstamp" is
> > > "TS1+122877ms - (TS1+rtt)" -> "122877ms - rtt",
> > > which is always bigger than TCP_RTO_MAX, which is 120000ms.
> > >
> > > >
> > > > Neal, what do you think ?
> >
> > Sorry, I am probably missing something here, but: what would ever make
> > this new proposed condition ((u32)icsk->icsk_timeout - tp->rcv_tstamp
> > > TCP_RTO_MAX) true? :-)
> >
>
> If the snd_wnd is 0, we need to keep probing until the window
> is available. Meanwhile, any retransmission that don't have
> a corresponding ACK (see what we do in the 1st patch), which
> can be caused by the lost of the ACK or the lost of the retransmitted
> packet, can make the condition true, as the tp->rcv_tstamp can't be
> updated in time.
>
> This is a little strict here. In the tcp_probe_timer(), we are allowed to
> retransmit the probe0 packet for sysctl_tcp_retries2 times. But
> we don't allow packets to be lost here.
>
> > In your nicely explained scenario, your new expression,
> > icsk->icsk_timeout - tp->rcv_tstamp, will be:
> >
> >   icsk->icsk_timeout - tp->rcv_tstamp
> > =3D TS1 + 120 sec      - (TS1+rtt)
> > =3D 120 sec - RTT
> >
> > AFAICT there is no way for that expression to be bigger than
> > TCP_RTO_MAX =3D 120 sec unless somehow RTT is negative. :-)
> >
> > So AFAICT your expression ((u32)icsk->icsk_timeout - tp->rcv_tstamp >
> > TCP_RTO_MAX) will always be false, so rather than this patch we may as
> > well remove the if check and the body of the if block?
> >
>
> Hmm......as I explained above, the condition will be true
> if the real packet loss happens. And I think it is the origin
> design.
>
> > To me such a change does not seem like a safe and clear bug fix for
> > the "net" branch but rather a riskier design change (appropriate for
> > "net-next" branch) that has connections retry forever when the
> > receiver retracts the window to zero, under the estimation that this
> > is preferable to having the connections die in such a case.
> >
> > There might be apps that depend on the old behavior of having
> > connections die in such cases, so we might want to have this new
> > fail-faster behavior guarded by a sysctl in case some sites need to
> > revert to the older behavior? Not sure...
>
> Yeah, the behavior here will be different for the users. I'm not
> sure if there are any users that rely on such behavior.
>
> What do you think, Eric? Do we need a sysctl here?
>

I honestly do not know what problem you want to solve.

As Neal pointed out, the new condition would not trigger,
so one can question about the whole piece of code,
what is its purpose exactly ?

When receiving WIN 0 acks, we should enter the so called probe0 state.
Maybe the real issue is that the 'receiver' will falsely send WIN X>0 ACKS,
because win probe acks do not really ensure memory is available to
receive new packets ?

Maybe provide a packetdrill test to show what kind of issue you are facing.=
..

In Google kernels, we have TCP_MAX_RTO reduced to 30 seconds, and the
following test runs fine.

// Test how sender reacts to unexpected arrival rwin of 0.

`../common/defaults.sh`

// Create a socket.
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

// Establish a connection.
  +.1 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 6>
   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 8>
  +.1 < . 1:1(0) ack 1 win 457
   +0 accept(3, ..., ...) =3D 4

   +0 write(4, ..., 20000) =3D 20000
   +0 > P. 1:10001(10000) ack 1
  +.1 < . 1:1(0) ack 10001 win 0

// Send zwp since we received rwin of 0 and have data to send.
  +.3 > . 10000:10000(0) ack 1
  +.1 < . 1:1(0) ack 10001 win 0

  +.6 > . 10000:10000(0) ack 1
  +.1 < . 1:1(0) ack 10001 win 0

 +1.2 > . 10000:10000(0) ack 1
  +.1 < . 1:1(0) ack 10001 win 0

 +2.4 > . 10000:10000(0) ack 1
  +.1 < . 1:1(0) ack 10001 win  0

 +4.8 > . 10000:10000(0) ack 1
  +.1 < . 1:1(0) ack 10001 win  0

 +9.6 > . 10000:10000(0) ack 1
  +.1 < . 1:1(0) ack 10001 win  0

+19.2 > . 10000:10000(0) ack 1
  +.1 < . 1:1(0) ack 10001 win 0

+30   > . 10000:10000(0) ack 1
  +.1 < . 1:1(0) ack 10001 win 0

+30   > . 10000:10000(0) ack 1
  +.1 < . 1:1(0) ack 10001 win 193

// Received non-zero window update. Send rest of the data.
   +0 > P. 10001:20001(10000) ack 1
  +.1 < . 1:1(0) ack 20001 win 457
