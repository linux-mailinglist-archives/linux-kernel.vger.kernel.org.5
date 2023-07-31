Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0B769243
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjGaJuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjGaJua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:50:30 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF91728;
        Mon, 31 Jul 2023 02:49:22 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5862a6ae535so7083227b3.0;
        Mon, 31 Jul 2023 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690796962; x=1691401762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij1aV1fmuLlyqs7lKmMEeDIzZHYRrbZXBxEfq4EEuvo=;
        b=oACT52WzGLPino7hBFYPcDzYfRg5+dAt3Z7rN2YCnE9zYuvYjI4avIqCwGh3XDH3c4
         24kHbhbTJNcwibv4du9VQ2JKfzmqBhnXC7CySyW6+C/VKYHFsaNzQVeMIHR/hRuw+aOB
         mnar+ZwKu7goyhIFjlguHw8LiRdVgrigvEh4DaTuE2OvP/Yz2oAu3MwidU6pNDUg8+1r
         1MemsQVNeEY3rRHFhMJGdlzjXAJ+AmDpjOgv4e0rIXno2g3V9zV2gP3PiORVJ4zO+8MJ
         mMxBihy8DF/ad0ml5FbA4QH+ynaqPJceTaBV3Wc1VgzAQgNpCIgpIm4QAmK3/A1QwBfC
         Tm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796962; x=1691401762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ij1aV1fmuLlyqs7lKmMEeDIzZHYRrbZXBxEfq4EEuvo=;
        b=anwB2IVhn2oXRKc9y5voCepzQyNGp5BFw7pK+YcZ3FBL9g7T1NkxkO6E+h4yx2XTt8
         nC1jmgjbgx1yJh7t36QWD5vY1aouvXsF4CbNHOPqkNvz24quH8/02FRbR22DpmyW5dk3
         f45klQzqgz+p4UsDSejsuWDUi9aUHGOl1gvbdNvF5rpefR3EQWu67FupL81Su/pSjuLi
         CLE0LLBPlkRLelpMZzD3KAO5lqFiCXHDGN/AojzUfkaf7uG1PWRkV/ELlVVKEWV5h9OO
         ZRzqU/YTPP48Yql2WufwTOPGOyQXZnpEE3BItM2ptnFT0IhSKCzwPZ/8pUb1s51LzDWf
         y9ZA==
X-Gm-Message-State: ABy/qLZvRoQOk9371kj0nMLaSHE+5eSLqP65aVX6adPfln8j3HYlYgAi
        mg+UuPKV5SnqP/cSkKQYerA59OPdYCgGYxMrzQw=
X-Google-Smtp-Source: APBJJlFQMtAm05z6LaJtyfZIUM6HxyewJB6FcXrdRCnrtHER1wJkgVIc69uw1uXY3afJuAuz5iRdJLN0CchcGOa7keE=
X-Received: by 2002:a25:8b04:0:b0:d2c:763d:1253 with SMTP id
 i4-20020a258b04000000b00d2c763d1253mr3841264ybl.46.1690796961681; Mon, 31 Jul
 2023 02:49:21 -0700 (PDT)
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
Date:   Mon, 31 Jul 2023 17:49:10 +0800
Message-ID: <CADxym3Y7kF9rT+PL6SE_tZFi2Q1CXqhz9e66F1kckcYtMmEkuQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To:     Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
>
> AFAICT it would be safer to replace this logic with a call to the
> standard tcp_write_timeout() logic that has a more robust check to see
> if the connection should be destroyed.

How about we check it with:

icsk->icsk_timeout - max(tp->retrans_stamp, tp->rcv_tstamp) > TCP_RTO_MAX

?

Therefore, we don't need to do a lot of modification. I have to
say that the way we check here is rough, and a simple loss
of the retransmitted packet or the ACK can cause the die
of the socket.

Maybe we need a more perfect way here? which may introduce
a certain amount of modification.

BTW, should I split out this patch from this series?

>
> neal
