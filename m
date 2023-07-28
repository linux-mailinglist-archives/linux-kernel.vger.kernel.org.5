Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31F76634E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjG1Eox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjG1Eoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:44:46 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191F1271C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:44:45 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4864cc561aeso626795e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690519484; x=1691124284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=692+S4FkHmBxAzri9hrerkt5cmhJNCiOy9pNKkxR03g=;
        b=YzewPKio72RERcsDJVs1hi8YpkYWh8mmYJP/6oZ3AKBPd2ppBuK2N6hf1FV4t8m+oJ
         2YYLjkQeGLOMv6tXIhyWKr7VOmJtWPoU62y5mr+FmqblVG7zLNVSx4m+G/NnSoebYdZr
         CmY8U850HVcdOkgLUEbhx1UP7TDgE4OFDO9+N5xMZ1PKGxku206gCNmlFI7QSK8a1TS/
         weFTypTMxFfxu/qZ+n0ys61at3MwVKLm+ctrs/BkGaToMN2ipz6AfjUwPQJ3P8PgNp8Y
         NnkI0+tF11BRydfy4mOpVtQUYbf+JJTcQ4pSmCj2VP2JY3vyz04kaN3NFKv7niZ5NN2I
         f+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690519484; x=1691124284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=692+S4FkHmBxAzri9hrerkt5cmhJNCiOy9pNKkxR03g=;
        b=WcZ88xzT8byxq/hP03KfdCihCddWQcImtXi3/mXHpuThFWkFAvPfurX0+7tZfyoGfw
         Td44T7wjsU3Qge501LA9UwJc3f2zmYgvceUvsJym5iyPjblDcWlaNDuUJXlZkBAGZaXp
         +V+lPW5hx3yNCurbtun2G1ywaDLwYoiAst+kXitHfvr0/kY0D0Py3oGCvTGGbd8GxsUd
         pTKElB/IOKkMi+ew3pEX4L3QENvUAnFXu/h4RHvepKsXd4Px3HBo9WXaRyFIpxc94z2p
         itjckwnAx75lkDSkUCnJcumoeeXcjRroO6XFb+GS+U8iJ/EkvGtCLA95lUEebmRPgTWZ
         8VaA==
X-Gm-Message-State: ABy/qLb5W3sWBXr/EQvZMPZ0wuRZ+j/Z8JGCZGHCCeTUpAVxyr9YOjD/
        eOfjmEjk7dnFjviIYJiLusf0Ls5djk+I+Y2z9Hzq0g==
X-Google-Smtp-Source: APBJJlEKpoNFDzvfV+zFJbA+09Khp7PEOkCicSdyl2eevP65dKFx9uCaKuiELgPDji/ZXo/g5Z7+i4Bza4K4eTxjE2w=
X-Received: by 2002:a67:fc52:0:b0:443:5f6e:c1b5 with SMTP id
 p18-20020a67fc52000000b004435f6ec1b5mr1210977vsq.18.1690519484005; Thu, 27
 Jul 2023 21:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com>
 <20230727125125.1194376-4-imagedong@tencent.com> <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
 <CADxym3YhjMv3Xkts99fiajq-cR-BqxDayKFzFZ1L49BNfFXkdw@mail.gmail.com>
In-Reply-To: <CADxym3YhjMv3Xkts99fiajq-cR-BqxDayKFzFZ1L49BNfFXkdw@mail.gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Thu, 27 Jul 2023 21:44:26 -0700
Message-ID: <CADVnQynQ1Hw+Jh7pjdNw_Mo4tWZV8V_sA+L-o=O4uV+9Gv7Prg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 7:57=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Fri, Jul 28, 2023 at 3:31=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Jul 27, 2023 at 2:52=E2=80=AFPM <menglong8.dong@gmail.com> wrot=
e:
> > >
> > > From: Menglong Dong <imagedong@tencent.com>
> > >
> > > In tcp_retransmit_timer(), a window shrunk connection will be regarde=
d
> > > as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This is=
 not
> > > right all the time.
> > >
> > > The retransmits will become zero-window probes in tcp_retransmit_time=
r()
> > > if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will come up t=
o
> > > TCP_RTO_MAX sooner or later.
> > >
> > > However, the timer is not precise enough, as it base on timer wheel.
> > > Sorry that I am not good at timer, but I know the concept of time-whe=
el.
> > > The longer of the timer, the rougher it will be. So the timeout is no=
t
> > > triggered after TCP_RTO_MAX, but 122877ms as I tested.
> > >
> > > Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always t=
rue
> > > once the RTO come up to TCP_RTO_MAX.
> > >
> > > Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeo=
ut',
> > > which is exact the timestamp of the timeout.
> > >
> > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > ---
> > >  net/ipv4/tcp_timer.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > > index 470f581eedd4..3a20db15a186 100644
> > > --- a/net/ipv4/tcp_timer.c
> > > +++ b/net/ipv4/tcp_timer.c
> > > @@ -511,7 +511,11 @@ void tcp_retransmit_timer(struct sock *sk)
> > >                                             tp->snd_una, tp->snd_nxt)=
;
> > >                 }
> > >  #endif
> > > -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
> > > +               /* It's a little rough here, we regard any valid pack=
et that
> > > +                * update tp->rcv_tstamp as the reply of the retransm=
itted
> > > +                * packet.
> > > +                */
> > > +               if ((u32)icsk->icsk_timeout - tp->rcv_tstamp > TCP_RT=
O_MAX) {
> > >                         tcp_write_err(sk);
> > >                         goto out;
> > >                 }
> >
> >
> > Hmm, this looks like a net candidate, since this is unrelated to the
> > other patches ?
>
> Yeah, this patch can be standalone. However, considering the
> purpose of this series, it is necessary. Without this patch, the
> OOM probe will always timeout after a few minutes.
>
> I'm not sure if I express the problem clearly in the commit log.
> Let's explain it more.
>
> Let's mark the timestamp of the 10th timeout of the rtx timer
> as TS1. Now, the retransmission happens and the ACK of
> the retransmitted packet will update the tp->rcv_tstamp to
> TS1+rtt.
>
> The RTO now is TCP_RTO_MAX. So let's see what will
> happen in the 11th timeout. As we timeout after 122877ms,
> so tcp_jiffies32 now is "TS1+122877ms", and
> "tcp_jiffies32 - tp->rcv_tstamp" is
> "TS1+122877ms - (TS1+rtt)" -> "122877ms - rtt",
> which is always bigger than TCP_RTO_MAX, which is 120000ms.
>
> >
> > Neal, what do you think ?

Sorry, I am probably missing something here, but: what would ever make
this new proposed condition ((u32)icsk->icsk_timeout - tp->rcv_tstamp
> TCP_RTO_MAX) true? :-)

In your nicely explained scenario, your new expression,
icsk->icsk_timeout - tp->rcv_tstamp, will be:

  icsk->icsk_timeout - tp->rcv_tstamp
=3D TS1 + 120 sec      - (TS1+rtt)
=3D 120 sec - RTT

AFAICT there is no way for that expression to be bigger than
TCP_RTO_MAX =3D 120 sec unless somehow RTT is negative. :-)

So AFAICT your expression ((u32)icsk->icsk_timeout - tp->rcv_tstamp >
TCP_RTO_MAX) will always be false, so rather than this patch we may as
well remove the if check and the body of the if block?

To me such a change does not seem like a safe and clear bug fix for
the "net" branch but rather a riskier design change (appropriate for
"net-next" branch) that has connections retry forever when the
receiver retracts the window to zero, under the estimation that this
is preferable to having the connections die in such a case.

There might be apps that depend on the old behavior of having
connections die in such cases, so we might want to have this new
fail-faster behavior guarded by a sysctl in case some sites need to
revert to the older behavior? Not sure...

neal
