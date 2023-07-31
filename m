Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6039B768A53
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjGaD3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGaD2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:28:46 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272B189;
        Sun, 30 Jul 2023 20:28:44 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-585ff234cd1so14553877b3.3;
        Sun, 30 Jul 2023 20:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690774123; x=1691378923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf7+baYff09Pijz3Z+hz1ANrPsY0lYMWHfXHDuGkvAY=;
        b=D/voIeALFvWpSrn+OemOTBamvFazzdHhrm3cgmRsairkHAUFO66cbCnQIbwHBzHCDf
         HRSXOb3gkuRvr39EfPGx3GSzBlgQ0kJOOoH+/M/LjrZd0u/j/J58U8vRa+qFZ7pyKlRk
         vI3Z/CfcIrzWOpT7QuCcOqtIAQWKrzZE9VhSyT76dWLEfqrRQ6iYweyCjr7TVW1iE/pd
         6rOSfoZXBZmtLYoejLxFwneD4MTNDMRBy39fVskIYFBGCQLuyUeAXQ5ZT2wmvW3BGRn5
         6AzvzlpuZC1BbQnF4jn5IjXTToFWmsfWSN/MMI4WsuaGn6XdcrrhylLWVsz43eR6Ha0o
         xfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690774123; x=1691378923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf7+baYff09Pijz3Z+hz1ANrPsY0lYMWHfXHDuGkvAY=;
        b=BUynmXO1JbJCaCEUcb8nABnPfIHcsLWUGyrMk7a6Fd4LSCl5XGtwET3EfXtf09RZB3
         WDS+/aanbnjJ4qr+++kEmuC86Rha70YSSjgJ3/lHEy8b1h65wChHrj0Ns3gy3irK1+74
         XGIeWbnAi5bS5vO5XC2Yzndcc7qlXuWIE3kZ1uxU/fs2c7ugly5YWcumgnW2nMefl72R
         NNNCbJn0IYKeiggL9r25YF5UB/cvydtwyMHSWmlHYTz0gjwyaw+qvVeVz+ZT02TUr+I/
         tIGht8Ctrv5aSKVaU207HuhbJey77eUpXgLTfRDLO50QIl3FcX8izymMDraqCq82rC24
         bKqw==
X-Gm-Message-State: ABy/qLY+MO6i0+YWu9otYltRKQdR6+JzAwaEBTUNwv4mNjDhKAY668Fl
        P+FtrDURPnfTEMpNgwowQfHlnYSkrABfhBH0xukzWFXC2VRkLCdocQw=
X-Google-Smtp-Source: APBJJlHJLx3t5ucc7TODXANfG8KZWsZGBYZH5XCaJRHO0xV8vGrRilxNbzp6YslSwl7K6+GWVsDZEmhrPlrpL8jjRSw=
X-Received: by 2002:a0d:dd91:0:b0:579:f163:dc2f with SMTP id
 g139-20020a0ddd91000000b00579f163dc2fmr9500769ywe.3.1690774123067; Sun, 30
 Jul 2023 20:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com>
 <20230727125125.1194376-4-imagedong@tencent.com> <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
 <CADxym3YhjMv3Xkts99fiajq-cR-BqxDayKFzFZ1L49BNfFXkdw@mail.gmail.com>
 <CADVnQynQ1Hw+Jh7pjdNw_Mo4tWZV8V_sA+L-o=O4uV+9Gv7Prg@mail.gmail.com>
 <CADxym3Zqb2CCpJojGiT7gVL98GDdOmjxqLY6ApLeP2zZU1Kn3Q@mail.gmail.com>
 <CANn89i+WnwgpGy4v=aXsjThPBA2FQzWx9Y=ycXWWGLDdtDHBig@mail.gmail.com> <CADVnQy=OumgmsbsQ8QLhUiyUNN95Ay2guVjgGVVLH93QXanBSw@mail.gmail.com>
In-Reply-To: <CADVnQy=OumgmsbsQ8QLhUiyUNN95Ay2guVjgGVVLH93QXanBSw@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Mon, 31 Jul 2023 11:28:31 +0800
Message-ID: <CADxym3bZ_Bsa_EdU_eTHgtgshi0RYuA+bWQO_sSJRbtGjtr8aA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To:     Neal Cardwell <ncardwell@google.com>
Cc:     Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 10:25=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
>
> On Fri, Jul 28, 2023 at 1:50=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Jul 28, 2023 at 8:25=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > On Fri, Jul 28, 2023 at 12:44=E2=80=AFPM Neal Cardwell <ncardwell@goo=
gle.com> wrote:
> > > >
> > > > On Thu, Jul 27, 2023 at 7:57=E2=80=AFPM Menglong Dong <menglong8.do=
ng@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jul 28, 2023 at 3:31=E2=80=AFAM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 27, 2023 at 2:52=E2=80=AFPM <menglong8.dong@gmail.c=
om> wrote:
> > > > > > >
> > > > > > > From: Menglong Dong <imagedong@tencent.com>
> > > > > > >
> > > > > > > In tcp_retransmit_timer(), a window shrunk connection will be=
 regarded
> > > > > > > as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'.=
 This is not
> > > > > > > right all the time.
> > > > > > >
> > > > > > > The retransmits will become zero-window probes in tcp_retrans=
mit_timer()
> > > > > > > if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will c=
ome up to
> > > > > > > TCP_RTO_MAX sooner or later.
> > > > > > >
> > > > > > > However, the timer is not precise enough, as it base on timer=
 wheel.
> > > > > > > Sorry that I am not good at timer, but I know the concept of =
time-wheel.
> > > > > > > The longer of the timer, the rougher it will be. So the timeo=
ut is not
> > > > > > > triggered after TCP_RTO_MAX, but 122877ms as I tested.
> > > > > > >
> > > > > > > Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is =
always true
> > > > > > > once the RTO come up to TCP_RTO_MAX.
> > > > > > >
> > > > > > > Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->ic=
sk_timeout',
> > > > > > > which is exact the timestamp of the timeout.
> > > > > > >
> > > > > > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > > > > > ---
> > > > > > >  net/ipv4/tcp_timer.c | 6 +++++-
> > > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > > > > > > index 470f581eedd4..3a20db15a186 100644
> > > > > > > --- a/net/ipv4/tcp_timer.c
> > > > > > > +++ b/net/ipv4/tcp_timer.c
> > > > > > > @@ -511,7 +511,11 @@ void tcp_retransmit_timer(struct sock *s=
k)
> > > > > > >                                             tp->snd_una, tp->=
snd_nxt);
> > > > > > >                 }
> > > > > > >  #endif
> > > > > > > -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_=
MAX) {
> > > > > > > +               /* It's a little rough here, we regard any va=
lid packet that
> > > > > > > +                * update tp->rcv_tstamp as the reply of the =
retransmitted
> > > > > > > +                * packet.
> > > > > > > +                */
> > > > > > > +               if ((u32)icsk->icsk_timeout - tp->rcv_tstamp =
> TCP_RTO_MAX) {
> > > > > > >                         tcp_write_err(sk);
> > > > > > >                         goto out;
> > > > > > >                 }
> > > > > >
> > > > > >
> > > > > > Hmm, this looks like a net candidate, since this is unrelated t=
o the
> > > > > > other patches ?
> > > > >
> > > > > Yeah, this patch can be standalone. However, considering the
> > > > > purpose of this series, it is necessary. Without this patch, the
> > > > > OOM probe will always timeout after a few minutes.
> > > > >
> > > > > I'm not sure if I express the problem clearly in the commit log.
> > > > > Let's explain it more.
> > > > >
> > > > > Let's mark the timestamp of the 10th timeout of the rtx timer
> > > > > as TS1. Now, the retransmission happens and the ACK of
> > > > > the retransmitted packet will update the tp->rcv_tstamp to
> > > > > TS1+rtt.
> > > > >
> > > > > The RTO now is TCP_RTO_MAX. So let's see what will
> > > > > happen in the 11th timeout. As we timeout after 122877ms,
> > > > > so tcp_jiffies32 now is "TS1+122877ms", and
> > > > > "tcp_jiffies32 - tp->rcv_tstamp" is
> > > > > "TS1+122877ms - (TS1+rtt)" -> "122877ms - rtt",
> > > > > which is always bigger than TCP_RTO_MAX, which is 120000ms.
> > > > >
> > > > > >
> > > > > > Neal, what do you think ?
> > > >
> > > > Sorry, I am probably missing something here, but: what would ever m=
ake
> > > > this new proposed condition ((u32)icsk->icsk_timeout - tp->rcv_tsta=
mp
> > > > > TCP_RTO_MAX) true? :-)
> > > >
> > >
> > > If the snd_wnd is 0, we need to keep probing until the window
> > > is available. Meanwhile, any retransmission that don't have
> > > a corresponding ACK (see what we do in the 1st patch), which
> > > can be caused by the lost of the ACK or the lost of the retransmitted
> > > packet, can make the condition true, as the tp->rcv_tstamp can't be
> > > updated in time.
> > >
> > > This is a little strict here. In the tcp_probe_timer(), we are allowe=
d to
> > > retransmit the probe0 packet for sysctl_tcp_retries2 times. But
> > > we don't allow packets to be lost here.
> > >
> > > > In your nicely explained scenario, your new expression,
> > > > icsk->icsk_timeout - tp->rcv_tstamp, will be:
> > > >
> > > >   icsk->icsk_timeout - tp->rcv_tstamp
> > > > =3D TS1 + 120 sec      - (TS1+rtt)
> > > > =3D 120 sec - RTT
> > > >
> > > > AFAICT there is no way for that expression to be bigger than
> > > > TCP_RTO_MAX =3D 120 sec unless somehow RTT is negative. :-)
> > > >
> > > > So AFAICT your expression ((u32)icsk->icsk_timeout - tp->rcv_tstamp=
 >
> > > > TCP_RTO_MAX) will always be false, so rather than this patch we may=
 as
> > > > well remove the if check and the body of the if block?
> > > >
> > >
> > > Hmm......as I explained above, the condition will be true
> > > if the real packet loss happens. And I think it is the origin
> > > design.
> > >
> > > > To me such a change does not seem like a safe and clear bug fix for
> > > > the "net" branch but rather a riskier design change (appropriate fo=
r
> > > > "net-next" branch) that has connections retry forever when the
> > > > receiver retracts the window to zero, under the estimation that thi=
s
> > > > is preferable to having the connections die in such a case.
> > > >
> > > > There might be apps that depend on the old behavior of having
> > > > connections die in such cases, so we might want to have this new
> > > > fail-faster behavior guarded by a sysctl in case some sites need to
> > > > revert to the older behavior? Not sure...
> > >
> > > Yeah, the behavior here will be different for the users. I'm not
> > > sure if there are any users that rely on such behavior.
> > >
> > > What do you think, Eric? Do we need a sysctl here?
> > >
> >
> > I honestly do not know what problem you want to solve.
> >
> > As Neal pointed out, the new condition would not trigger,
> > so one can question about the whole piece of code,
> > what is its purpose exactly ?
> >
> > When receiving WIN 0 acks, we should enter the so called probe0 state.
> > Maybe the real issue is that the 'receiver' will falsely send WIN X>0 A=
CKS,
> > because win probe acks do not really ensure memory is available to
> > receive new packets ?
> >
> > Maybe provide a packetdrill test to show what kind of issue you are fac=
ing...
> >
> > In Google kernels, we have TCP_MAX_RTO reduced to 30 seconds, and the
> > following test runs fine.
> >
> > // Test how sender reacts to unexpected arrival rwin of 0.
> >
> > `../common/defaults.sh`
> >
> > // Create a socket.
> >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> >    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> >    +0 bind(3, ..., ...) =3D 0
> >    +0 listen(3, 1) =3D 0
> >
> > // Establish a connection.
> >   +.1 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 6>
> >    +0 > S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 8=
>
> >   +.1 < . 1:1(0) ack 1 win 457
> >    +0 accept(3, ..., ...) =3D 4
> >
> >    +0 write(4, ..., 20000) =3D 20000
> >    +0 > P. 1:10001(10000) ack 1
> >   +.1 < . 1:1(0) ack 10001 win 0
> >
> > // Send zwp since we received rwin of 0 and have data to send.
> >   +.3 > . 10000:10000(0) ack 1
> >   +.1 < . 1:1(0) ack 10001 win 0
> >
> >   +.6 > . 10000:10000(0) ack 1
> >   +.1 < . 1:1(0) ack 10001 win 0
> >
> >  +1.2 > . 10000:10000(0) ack 1
> >   +.1 < . 1:1(0) ack 10001 win 0
> >
> >  +2.4 > . 10000:10000(0) ack 1
> >   +.1 < . 1:1(0) ack 10001 win  0
> >
> >  +4.8 > . 10000:10000(0) ack 1
> >   +.1 < . 1:1(0) ack 10001 win  0
> >
> >  +9.6 > . 10000:10000(0) ack 1
> >   +.1 < . 1:1(0) ack 10001 win  0
> >
> > +19.2 > . 10000:10000(0) ack 1
> >   +.1 < . 1:1(0) ack 10001 win 0
> >
> > +30   > . 10000:10000(0) ack 1
> >   +.1 < . 1:1(0) ack 10001 win 0
> >
> > +30   > . 10000:10000(0) ack 1
> >   +.1 < . 1:1(0) ack 10001 win 193
> >
> > // Received non-zero window update. Send rest of the data.
> >    +0 > P. 10001:20001(10000) ack 1
> >   +.1 < . 1:1(0) ack 20001 win 457
>
> In that packetdrill case AFAICT that is the ZWP timer firing, and the
> sender sends a ZWP.
>
> I think maybe Menglong is looking more at something like the following
> scenario, where at the time the RTO timer fires the data sender finds
> the tp->snd_wnd is zero, so it sends a retransmit of the
> lowest-sequence data packet.
>

Sorry for the late reply, I'm traveling on the weekend for two days.

Yes, I think it is close to my scenario. The sender will send
a retransmit of the lowest-sequence data packet to probe
the window.

> Here is a packetdrill case and the tcpdump trace on an upstream
> net-next kernel... I have not worked out all the details at the end,
> but perhaps it can help move the discussion forward:
>

The packetdrill is more amazing than I thought, I never
thought it could do such a thing.

>
> ~/packetdrill/gtests/net/tcp/receiver_window# cat rwin-rto-zero-window.pk=
t
> // Test how sender reacts to unexpected arrival rwin of 0.
>
> `../common/defaults.sh`
>
> // Create a socket.
>     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
>    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
>    +0 bind(3, ..., ...) =3D 0
>    +0 listen(3, 1) =3D 0
>
> // Establish a connection.
>   +.1 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 6>
>    +0 > S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 14>
>   +.1 < . 1:1(0) ack 1 win 457
>    +0 accept(3, ..., ...) =3D 4
>
>    +0 write(4, ..., 20000) =3D 20000
>    +0 > P. 1:10001(10000) ack 1
>
> // TLP
>   +.2 > . 10001:11001(1000) ack 1
> // Receiver has retracted rwin to 0
> // (perhaps from the 2023 proposed OOM code?).
>   +.1 < . 1:1(0) ack 1 win 0
>
> // RTO, and in tcp_retransmit_timer() we see the receiver window is zero,
> // so we take the special f (!tp->snd_wnd...) code path.
>   +.2 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
>   +.5 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
>  +1.2 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
>  +2.4 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
>  +4.8 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
>  +9.6 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
> +19.2 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
> +38.4 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
> +76.8 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
> +120 > . 1:1001(1000) ack 1
>  +.1 < . 1:1(0) ack 1 win 0
>
> +120 > . 1:1001(1000) ack 1
>  +.1 < . 1:1(0) ack 1001 win 1000
>
> // Received non-zero window update. Send more data.
>   +0 > P. 1001:3001(2000) ack 1
>  +.1 < . 1:1(0) ack 3001 win 1000
>
> ----------
> When I run that script on a net-next kernel I see the rounding up of
> the RTO to 122 secs rather than 120 secs, but for whatever reason the
> script does not cause the socket to die early...
>

Enn....it should die, let me dig deeper into the script first.
The script looks nice, I need a little time to learn it.

Thanks!
Menglong Dong

> The tcpdump trace:
>
>  tcpdump -ttt -n -i any port 8080 &
>
> ->
>
> ~/packetdrill/gtests/net/tcp/receiver_window#
> ../../packetdrill/packetdrill rwin-rto-zero-window.pkt
>  00:01:01.370344 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [S], seq 0, win 65535, options [mss
> 1000,nop,nop,sackOK,nop,wscale 6], length 0
>  00:00:00.000096 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [S.], seq 3847169154, ack 1, win 65535, options [mss
> 1460,nop,nop,sackOK,nop,wscale 14], length 0
>  00:00:00.100277 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 457, length 0
>  00:00:00.000090 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [P.], seq 1:2001, ack 1, win 4, length 2000: HTTP
>  00:00:00.000006 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [P.], seq 2001:4001, ack 1, win 4, length 2000: HTTP
>  00:00:00.000003 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [P.], seq 4001:6001, ack 1, win 4, length 2000: HTTP
>  00:00:00.000002 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [P.], seq 6001:8001, ack 1, win 4, length 2000: HTTP
>  00:00:00.000001 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [P.], seq 8001:10001, ack 1, win 4, length 2000: HTTP
>  00:00:00.209131 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 10001:11001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100190 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:00.203824 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100175 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:00.507835 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100192 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:01.115858 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100182 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:02.331747 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100198 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:04.955980 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100197 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:09.627985 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100179 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:19.355725 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100203 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:42.395633 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100202 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:01:17.724059 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100201 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:02:02.779516 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100229 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:02:02.779828 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100230 ?     In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1001, win 1000, length 0
>  00:00:00.000034 ?     Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 11001:12001, ack 1, win 4, length 1000: HTTP
>  00:00:00.000005 ?     Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 12001:13001, ack 1, win 4, length 1000: HTTP
>
> rwin-rto-zero-window.pkt:62: error handling packet: live packet field
> tcp_psh: expected: 1 (0x1) vs actual: 0 (0x0)
> script packet: 405.390244 P. 1001:3001(2000) ack 1
> actual packet: 405.390237 . 11001:13001(2000) ack 1 win 4
