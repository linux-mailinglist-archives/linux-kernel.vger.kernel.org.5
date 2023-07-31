Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA63A768A66
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGaDly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaDlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:41:52 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B3C10B;
        Sun, 30 Jul 2023 20:41:51 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-583e91891aeso48158017b3.1;
        Sun, 30 Jul 2023 20:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690774910; x=1691379710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llUncJ6XvCbCVRkShMXc33YP30OKZJvRpZvYC2tLhSU=;
        b=fjQcJ5Os0GLC2NIOptOGGKWlgkoMvHgNzBh7voqbL0syWox3vFWTPbBb/wtGVAxboU
         BGhIO1nHeTc4V4Wfjl0emVtEEdl1h8DLIHj0OYKh70PF0Yvd1g2fYM/eOlBOwcMvEdh1
         yA1Ip9q11i9/PevHdbMeIbnl/yx/5oJflytYFMOhlk16e02xbc0719B3lZNfdbZ3Doy9
         atfqAzIwY8Tx4U3gkxciMuMoBytOZpNiWZGlOrkwuhQd3a2ZbQDBCqwjFG+qaEHEy2iu
         BcyRvRoWgQoXK2ZI280DBTnG6L0/bM27GS9h/1MbV7oxNL7RGAB0Wmbmm4UC9zTCfT6/
         VGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690774910; x=1691379710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llUncJ6XvCbCVRkShMXc33YP30OKZJvRpZvYC2tLhSU=;
        b=FndiDHXbHIFHGGt9ULlL1kehZqyWN3ggwwu+pOqlGuoVlY+izHTZtqXL0V7DhJ9nEO
         XuLwGjVhvQ68hal8DJBbjPHcNDzMcHDmPC1ErciMTBzZoIEkUTn8agTzO+e9fGRKQvTp
         dZk93UVM9MWxZkus2WB0Fl4WmLRu9DQUZLNdrRalusKFXGtAFrhF8d2dJaDDbkJzbbXe
         mOiiCq68FgqvwFPx0Ez5vsKAw7HoIgvv+cly+BwCumZJHZa5E7a8HT/94zPJxPfzH6ZK
         SUFy5/LbPRZRPfIyOkPNGuwbiTTqR7hczbEWYyx0Oo9+JXYBuizfCsliCAiERwzdAAcc
         cnSQ==
X-Gm-Message-State: ABy/qLZ7bAuJgxzgqjuDJDAnqDLpW0qSFigIk56DTBvakpbQAIZ8hMH8
        1TUXZhSCkMFFUj/mcXx60/NqgeLbOxXO6KasA68=
X-Google-Smtp-Source: APBJJlHslHdUNzQb+zIUzFCaH4j0CZPvq2RJDTh0koAylOIa27++22Dkw+/kbvi8Sod48N6hcDTpvzFtWuVzRiZ3aGY=
X-Received: by 2002:a0d:db87:0:b0:583:cf0f:152d with SMTP id
 d129-20020a0ddb87000000b00583cf0f152dmr11597944ywe.6.1690774910623; Sun, 30
 Jul 2023 20:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com>
 <20230727125125.1194376-4-imagedong@tencent.com> <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
 <CADxym3YhjMv3Xkts99fiajq-cR-BqxDayKFzFZ1L49BNfFXkdw@mail.gmail.com>
 <CADVnQynQ1Hw+Jh7pjdNw_Mo4tWZV8V_sA+L-o=O4uV+9Gv7Prg@mail.gmail.com>
 <CADxym3Zqb2CCpJojGiT7gVL98GDdOmjxqLY6ApLeP2zZU1Kn3Q@mail.gmail.com>
 <CANn89i+WnwgpGy4v=aXsjThPBA2FQzWx9Y=ycXWWGLDdtDHBig@mail.gmail.com>
 <CADVnQy=OumgmsbsQ8QLhUiyUNN95Ay2guVjgGVVLH93QXanBSw@mail.gmail.com> <CADVnQynwrvdoEH2d7VVNSG6vHg8BC5ikz+PApOOMG4Eo3MqSww@mail.gmail.com>
In-Reply-To: <CADVnQynwrvdoEH2d7VVNSG6vHg8BC5ikz+PApOOMG4Eo3MqSww@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Mon, 31 Jul 2023 11:41:38 +0800
Message-ID: <CADxym3YgR36hoTEHUbCYUzYkiXpjnSuVEZWnvoqbMo8MoTCtnQ@mail.gmail.com>
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

On Sat, Jul 29, 2023 at 1:15=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Fri, Jul 28, 2023 at 7:25=E2=80=AFAM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >
> > On Fri, Jul 28, 2023 at 1:50=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Fri, Jul 28, 2023 at 8:25=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 28, 2023 at 12:44=E2=80=AFPM Neal Cardwell <ncardwell@g=
oogle.com> wrote:
> > > > >
> > > > > On Thu, Jul 27, 2023 at 7:57=E2=80=AFPM Menglong Dong <menglong8.=
dong@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Jul 28, 2023 at 3:31=E2=80=AFAM Eric Dumazet <edumazet@=
google.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jul 27, 2023 at 2:52=E2=80=AFPM <menglong8.dong@gmail=
.com> wrote:
> > > > > > > >
> > > > > > > > From: Menglong Dong <imagedong@tencent.com>
> > > > > > > >
> > > > > > > > In tcp_retransmit_timer(), a window shrunk connection will =
be regarded
> > > > > > > > as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX=
'. This is not
> > > > > > > > right all the time.
> > > > > > > >
> > > > > > > > The retransmits will become zero-window probes in tcp_retra=
nsmit_timer()
> > > > > > > > if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will=
 come up to
> > > > > > > > TCP_RTO_MAX sooner or later.
> > > > > > > >
> > > > > > > > However, the timer is not precise enough, as it base on tim=
er wheel.
> > > > > > > > Sorry that I am not good at timer, but I know the concept o=
f time-wheel.
> > > > > > > > The longer of the timer, the rougher it will be. So the tim=
eout is not
> > > > > > > > triggered after TCP_RTO_MAX, but 122877ms as I tested.
> > > > > > > >
> > > > > > > > Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' i=
s always true
> > > > > > > > once the RTO come up to TCP_RTO_MAX.
> > > > > > > >
> > > > > > > > Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->=
icsk_timeout',
> > > > > > > > which is exact the timestamp of the timeout.
> > > > > > > >
> > > > > > > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > > > > > > ---
> > > > > > > >  net/ipv4/tcp_timer.c | 6 +++++-
> > > > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > > > > > > > index 470f581eedd4..3a20db15a186 100644
> > > > > > > > --- a/net/ipv4/tcp_timer.c
> > > > > > > > +++ b/net/ipv4/tcp_timer.c
> > > > > > > > @@ -511,7 +511,11 @@ void tcp_retransmit_timer(struct sock =
*sk)
> > > > > > > >                                             tp->snd_una, tp=
->snd_nxt);
> > > > > > > >                 }
> > > > > > > >  #endif
> > > > > > > > -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RT=
O_MAX) {
> > > > > > > > +               /* It's a little rough here, we regard any =
valid packet that
> > > > > > > > +                * update tp->rcv_tstamp as the reply of th=
e retransmitted
> > > > > > > > +                * packet.
> > > > > > > > +                */
> > > > > > > > +               if ((u32)icsk->icsk_timeout - tp->rcv_tstam=
p > TCP_RTO_MAX) {
> > > > > > > >                         tcp_write_err(sk);
> > > > > > > >                         goto out;
> > > > > > > >                 }
>
> One potential pre-existing issue with this logic: if the connection is
> restarting from idle, then tp->rcv_tstamp could already be a long time
> (minutes or hours) in the past even on the first RTO, in which case
> the very first RTO that found a zero tp->snd_wnd  would find this
> check returns true, and would destroy the connection immediately. This
> seems extremely brittle.

Yes, this scenario can happen and cause the connection
break unexpectedly.

>
> AFAICT it would be safer to replace this logic with a call to the
> standard tcp_write_timeout() logic that has a more robust check to see
> if the connection should be destroyed.

Yes, we need a more robust check here. But I think tcp_write_timeout()
is not a good choice. The icsk->icsk_retransmits won't increase and
can keep being 0 in this scenario, which makes tcp_write_timeout()
always return 0.

Enn...let me think again.

>
> neal
