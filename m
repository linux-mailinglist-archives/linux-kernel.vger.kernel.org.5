Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F428766226
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjG1C5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjG1C5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:57:44 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFC4213A;
        Thu, 27 Jul 2023 19:57:43 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-583b3939521so17394907b3.0;
        Thu, 27 Jul 2023 19:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690513062; x=1691117862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsaOUxGKCUymU5XYv3kBwo3bO2Reb2k4CNVi51cNoCA=;
        b=AvI4pzn50m6Z4u+JcVsB4FGBnU5TVw1vda+BSDO1IiJHRfmQ+jOWSYr5tslGSBAFWG
         /r42a+vYprV5AFLXj38ZTQyeNgwEci/tL00m7KK46qnUm+cKq+lMgqtVel1Jeps3E/kp
         VPitOzL6WD0s8ObGvAN0HwIfvgH5YIgJx21BpUFITf5l3Ljt+1pXyvlQz6YdQ4tyt1jV
         eZgOAeHCQkhPKRcsT69NnGYqYxmAaXLg5+JKytP0aX+TaAKr83PsXCRws+vn+W1BUlEM
         xWOb4nSSKgfaboQYrinS3Cr+H8isUwMtQm7KPTW4wPBc3s7VG95hPOon/RAQZxFcl2DS
         aGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690513062; x=1691117862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsaOUxGKCUymU5XYv3kBwo3bO2Reb2k4CNVi51cNoCA=;
        b=UZYZpDInejFcFKBPffjaNzyjEitFq495fZrIQjnXYHVD6pTPhYEKNBSQqQhkAmOjkK
         P07YRXAEebKc1UtvWD3Ncoev2O/Tr/sX52ZzUUvrxA3z6ZmtlGr7IM7HpqRM11gfdis0
         12IDlgFC3BN7yc+D1MBNKI8kOcD5TpGeQlxUn69AICI06b2eR+uUKWGMjz5ib9c4dRrd
         /yC6cvHSi4FHxLplbbeAUyZpgA0E8IXOz9PmOl1cq+YRRThgEQ4TTMnezRRlnDlL7TQb
         r/LpN51wWjDhTRFzhcOtI8zbALXr2zHHkj0Nf6GeTARnupJXjHy4YhCatOMNpWBN0KZI
         up7A==
X-Gm-Message-State: ABy/qLbkVECKTHIld7SVK3lYCyqhsejOjn0cQnyoQwktBd10ueKrJzaa
        ZJFZ+Z/+lM3eOR35D0ng0LpCa5VOwQEmm8nD5rw=
X-Google-Smtp-Source: APBJJlGlA2T5FCdHiKh52XA6dYrRm3KVlVjVOLmOqr+mbwAk7TIBdfOzDK3sX3iqxcQJEv8xJdDJKkhV5hUyruwm1O8=
X-Received: by 2002:a81:4703:0:b0:583:3c7e:7749 with SMTP id
 u3-20020a814703000000b005833c7e7749mr558721ywa.41.1690513062128; Thu, 27 Jul
 2023 19:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com>
 <20230727125125.1194376-4-imagedong@tencent.com> <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
In-Reply-To: <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri, 28 Jul 2023 10:57:30 +0800
Message-ID: <CADxym3YhjMv3Xkts99fiajq-cR-BqxDayKFzFZ1L49BNfFXkdw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 3:31=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 27, 2023 at 2:52=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
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
> > Sorry that I am not good at timer, but I know the concept of time-wheel=
.
> > The longer of the timer, the rougher it will be. So the timeout is not
> > triggered after TCP_RTO_MAX, but 122877ms as I tested.
> >
> > Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always tru=
e
> > once the RTO come up to TCP_RTO_MAX.
> >
> > Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout=
',
> > which is exact the timestamp of the timeout.
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> >  net/ipv4/tcp_timer.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index 470f581eedd4..3a20db15a186 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -511,7 +511,11 @@ void tcp_retransmit_timer(struct sock *sk)
> >                                             tp->snd_una, tp->snd_nxt);
> >                 }
> >  #endif
> > -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
> > +               /* It's a little rough here, we regard any valid packet=
 that
> > +                * update tp->rcv_tstamp as the reply of the retransmit=
ted
> > +                * packet.
> > +                */
> > +               if ((u32)icsk->icsk_timeout - tp->rcv_tstamp > TCP_RTO_=
MAX) {
> >                         tcp_write_err(sk);
> >                         goto out;
> >                 }
>
>
> Hmm, this looks like a net candidate, since this is unrelated to the
> other patches ?

Yeah, this patch can be standalone. However, considering the
purpose of this series, it is necessary. Without this patch, the
OOM probe will always timeout after a few minutes.

I'm not sure if I express the problem clearly in the commit log.
Let's explain it more.

Let's mark the timestamp of the 10th timeout of the rtx timer
as TS1. Now, the retransmission happens and the ACK of
the retransmitted packet will update the tp->rcv_tstamp to
TS1+rtt.

The RTO now is TCP_RTO_MAX. So let's see what will
happen in the 11th timeout. As we timeout after 122877ms,
so tcp_jiffies32 now is "TS1+122877ms", and
"tcp_jiffies32 - tp->rcv_tstamp" is
"TS1+122877ms - (TS1+rtt)" -> "122877ms - rtt",
which is always bigger than TCP_RTO_MAX, which is 120000ms.

>
> Neal, what do you think ?
