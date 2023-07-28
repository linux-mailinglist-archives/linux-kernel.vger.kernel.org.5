Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06437767310
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjG1RP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjG1RPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:15:23 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCE63A81
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:15:21 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4476a50c64bso625830137.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690564520; x=1691169320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LROTV5y5IdBJTsjpYwl/eIhz/Ub1IxtdypTbt/I1aSA=;
        b=T/h+VFDtennYU7jNdQ2B6p2dhvppEuTLLFAp8Qh8aosb8BzxrSZZAt8MB5X+QvfUKa
         b//lf0SfR7OwJ637yyR0pMnh3twOFbc7y421CW00PURa5JcT2nCnH0Wy+xn9y6XBGtx5
         4I6J5ouwqYuvYAnofG2Rz6IINeRNlmwTaTwAhlCfe+dX3ImlmLhbROff+YuGiDZP6I3E
         qKPb7mHVsUMdbkeEQMFRzdz9mYIkxnUfXU8NTM8R9sNIbj1tm37ks9IyyG1wpjRGRKya
         RFkfON1/7J9HFiKnMKTeUGcw/P8Sozie4sH1Aq/jE3Qn6qT4yV16rcO1cGJu1v/4+Q5b
         qNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690564520; x=1691169320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LROTV5y5IdBJTsjpYwl/eIhz/Ub1IxtdypTbt/I1aSA=;
        b=QIhJZe1+N5/nx/C6c8g1SmZDdd6e4K3UxNq4MujuE62n0LIDyiQ2kIeA+RcPyiQsS5
         qA40bXZYsL78nZLRdwi9gaMu6U5QfuNARDucy7PmbbRKQOwGMBHcZ0YwwuSu+mz4sjE/
         LcFml0QZp2ZXqr41BsL/QwV3RS3pN6gXag56QW8xWpicVxg0r9K0TWKIL1Z05nPLi18N
         OItB8j2mzukINNGAGkVA1uWSuDclbeK2lkTMg9l3G3ndNMCGL1B57Z5+3E1mIgDBrY2X
         u6zSKtVx/JGw2IbzsCTlu3BO4VEKynGn/uthCxqcgmPBTS06ucjPY3okyymcb8nmoK5m
         r3GQ==
X-Gm-Message-State: ABy/qLZYjuWSU/ciMoz42624F/EBqw+3OP5vIpxaXnnT3oZ28yxQDjNu
        Hkjv5VW8cC/xXQ1iPRBDnqRkKSvdDJZwoU3vx+gcEg==
X-Google-Smtp-Source: APBJJlFVdT0zaDWaI5U/9NiLV0sdX1+Ej6YT5qIxNRjvRnVfgRvHOQMDCbu+agBUeFPAwAwtj0Fc2+EV49TD/jaB8+g=
X-Received: by 2002:a67:e207:0:b0:447:6ef1:c4e with SMTP id
 g7-20020a67e207000000b004476ef10c4emr2228898vsa.34.1690564520259; Fri, 28 Jul
 2023 10:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com>
 <20230727125125.1194376-4-imagedong@tencent.com> <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
 <CADxym3YhjMv3Xkts99fiajq-cR-BqxDayKFzFZ1L49BNfFXkdw@mail.gmail.com>
 <CADVnQynQ1Hw+Jh7pjdNw_Mo4tWZV8V_sA+L-o=O4uV+9Gv7Prg@mail.gmail.com>
 <CADxym3Zqb2CCpJojGiT7gVL98GDdOmjxqLY6ApLeP2zZU1Kn3Q@mail.gmail.com>
 <CANn89i+WnwgpGy4v=aXsjThPBA2FQzWx9Y=ycXWWGLDdtDHBig@mail.gmail.com> <CADVnQy=OumgmsbsQ8QLhUiyUNN95Ay2guVjgGVVLH93QXanBSw@mail.gmail.com>
In-Reply-To: <CADVnQy=OumgmsbsQ8QLhUiyUNN95Ay2guVjgGVVLH93QXanBSw@mail.gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Fri, 28 Jul 2023 10:15:03 -0700
Message-ID: <CADVnQynwrvdoEH2d7VVNSG6vHg8BC5ikz+PApOOMG4Eo3MqSww@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To:     Eric Dumazet <edumazet@google.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 7:25=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
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

One potential pre-existing issue with this logic: if the connection is
restarting from idle, then tp->rcv_tstamp could already be a long time
(minutes or hours) in the past even on the first RTO, in which case
the very first RTO that found a zero tp->snd_wnd  would find this
check returns true, and would destroy the connection immediately. This
seems extremely brittle.

AFAICT it would be safer to replace this logic with a call to the
standard tcp_write_timeout() logic that has a more robust check to see
if the connection should be destroyed.

neal
