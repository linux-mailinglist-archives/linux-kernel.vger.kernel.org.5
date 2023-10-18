Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3020D7CDE36
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbjJROCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjJROCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:02:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5054A83
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:02:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40662119cd0so68495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697637726; x=1698242526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je7THM0Q6WDll0ILuhNv36+yFTJhhililTvbjgw8ZHU=;
        b=hm2JnfOsquK3rpgoo2HYBGlM5g0jTTW/ysA0hZQNg69/CawZoMV0WRsxl740kcVDNr
         l6hW5fJ6wO/r0yMM+evjcw8rCNc/xdaPTGInAzAA/fnGkRs2khXY7WhHIMcouBUz1kq/
         eCkVvaU03KSQrn6ttoS+vXNRAlcPRDtRlwUvjq3wJIBZNZmmb6YdNrOcAo+sP1rPrI1C
         6HxGj/rFg/+U38REx6JmtQlWEN3IsfXxMfVxptFoMUPObJoJo3F7YCbpBghgANLh5Vdx
         SIlWvYBdHMienrzDqM1h+pSc1tKIpVhY32kFp5/qF8Hv6oBXzAKVMK6aMdkUXd9cfnwC
         WwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637726; x=1698242526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je7THM0Q6WDll0ILuhNv36+yFTJhhililTvbjgw8ZHU=;
        b=fdao5O8Nc0i8kShLnw78dByDQQa6dbgAoTNCCc56gjcxxr7nTrEtDq3jzFcWMlVgGD
         lm26nhqlEBa1nn+uSwGsBnLovCVUm1Ai/cOIXbtTnx6m2iLWyMJJH7uCM4jNrX88HZRA
         w/Ex2Va9ciAu5ZgngNTdeer7s5GnTjiHq8m/OLsSa6TmNkAlT/335Dxnh0MJUbtS2liR
         zZJYjySEa1g64a+5ZwQKZVGnAAXai4pFdQHYOU4JWWPHUgU/98PWXr1Jt4xq2MMv/bp0
         Wt6lWUrHDkn9S4bHWpC/3AaFOukNpCdD16d4zlJUqg0EZTWsvB3X7WgAdO02+mzfNLZn
         Dttg==
X-Gm-Message-State: AOJu0YxLn3wqGG/AgsGGOM1eJ62io0xGjSH+Pa78fht9x9IA9nBP1+AS
        A35ru4LCq++JQ02nCGsosk8860XFgEfiGbfdyWeJm/gOtTYytuglluJubse6
X-Google-Smtp-Source: AGHT+IHcuMsAxR+b1GedFvT4k/wv4HydLC0ior1sGatheO5efFqmnxwEU39tFYCX4Cd5UIhqW3KiyG3eAVs4VWgaZqo=
X-Received: by 2002:a1c:6a16:0:b0:3f7:3e85:36a with SMTP id
 f22-20020a1c6a16000000b003f73e85036amr100035wmc.7.1697637725279; Wed, 18 Oct
 2023 07:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231014181333.2579530-1-vamshigajjela@google.com>
 <0d5f9af2-22ac-4753-8c5a-76c4d44dcc9c@kernel.org> <7d5493f0-b9a6-5ddc-75a-9add2eb75a24@linux.intel.com>
In-Reply-To: <7d5493f0-b9a6-5ddc-75a-9add2eb75a24@linux.intel.com>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Wed, 18 Oct 2023 19:31:52 +0530
Message-ID: <CAMTSyjojcrKzWWsDdnuO__x5Zwik5m1rW6c7xi2jETh5=jJrwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] serial: core: Potential overflow of frame_time
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 4:30=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 16 Oct 2023, Jiri Slaby wrote:
>
> > On 14. 10. 23, 20:13, Vamshi Gajjela wrote:
> > > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> > >
> > > uart_update_timeout() sets a u64 value to an unsigned int frame_time.
> > > While it can be cast to u32 before assignment, there's a specific cas=
e
> > > where frame_time is cast to u64. Since frame_time consistently
> > > participates in u64 arithmetic, its data type is converted to u64 to
> > > eliminate the need for explicit casting.
> >
> > And make the divisions by the order of magnutude slower for no good rea=
son?
> > (Hint: have you looked what DIV64_U64_ROUND_UP() looks like on 32bit ye=
t?)
> >
> > Unless you provide a reason it can overflow in real (in fact you spell =
the
> > opposite in the text above):
> > NACKED-by: Jiri Slaby <jirislaby@kernel.org>
>
> I sorry but I have to concur Jiri heavily here,
>
> NACKED-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> > > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > > ---
> > > v2:
> > > - use DIV64_U64_ROUND_UP with frame_time
>
> Please, I barely managed to read your v1 and it's v2 already, don't send
> the next version this soon. There's absolutely no need to fill our inboxe=
s
> with n versions of your patch over a weekend, just remain patient
> and wait reasonable amount of time to gather feedback, please. ...I know
> it's often hard to wait, it's hard for me too at times.
>
> You even failed to convert the other divide done on ->frame_time to
> DIV64_u64_ROUND_UP(), which looks a mindboggling oversight to me.
> So far you've managed to cause so many problems with these two attempts t=
o
> fix a non-problem I heavily suggest you focus on something that doesn't
> relate to fixing types. It takes time to understand the related code when
> doing something as simple as type change, which you clearly did not have
> as demonstrated by you missing that other divide which can be trivially
> found with git grep.
Apologies for the inconvenience caused, I should have waited for the respon=
se
on v1 before making v2, by leaving a comment about the anticipated change.

I have clearly not considered all the architectures in the patch, and
the overhead
of division on 32-archs, mistake from my side. once again apologies for tha=
t.

Thanks Jiri Slaby & Ilpo J=C3=A4rvinen for the review.
>
> > >
> > >   drivers/tty/serial/8250/8250_port.c | 2 +-
> > >   include/linux/serial_core.h         | 4 ++--
> > >   2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_port.c
> > > b/drivers/tty/serial/8250/8250_port.c
> > > index 141627370aab..d1bf794498c4 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -1510,7 +1510,7 @@ static inline void __stop_tx(struct uart_8250_p=
ort *p)
> > >                      * rather than after it is fully sent.
> > >                      * Roughly estimate 1 extra bit here with / 7.
> > >                      */
> > > -                   stop_delay =3D p->port.frame_time +
> > > DIV_ROUND_UP(p->port.frame_time, 7);
> > > +                   stop_delay =3D p->port.frame_time +
> > > DIV64_U64_ROUND_UP(p->port.frame_time, 7);
> > >             }
> > >                     __stop_tx_rs485(p, stop_delay);
> > > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.=
h
> > > index bb6f073bc159..b128513b009a 100644
> > > --- a/include/linux/serial_core.h
> > > +++ b/include/linux/serial_core.h
> > > @@ -558,7 +558,7 @@ struct uart_port {
> > >             bool                    hw_stopped;             /* sw-ass=
isted CTS
> > > flow state */
> > >     unsigned int            mctrl;                  /* current modem =
ctrl
> > > settings */
> > > -   unsigned int            frame_time;             /* frame timing i=
n ns
> > > */
> > > +   unsigned long           frame_time;             /* frame timing i=
n ns
> > > */
>
> As with v1, u64 !=3D unsigned long, I hope you do know that much about
> different architectures...
>
> --
>  i.
>
> > >     unsigned int            type;                   /* port type */
> > >     const struct uart_ops   *ops;
> > >     unsigned int            custom_divisor;
> > > @@ -764,7 +764,7 @@ unsigned int uart_get_divisor(struct uart_port *p=
ort,
> > > unsigned int baud);
> > >    */
> > >   static inline unsigned long uart_fifo_timeout(struct uart_port *por=
t)
> > >   {
> > > -   u64 fifo_timeout =3D (u64)READ_ONCE(port->frame_time) * port->fif=
osize;
> > > +   u64 fifo_timeout =3D READ_ONCE(port->frame_time) * port->fifosize=
;
> > >             /* Add .02 seconds of slop */
> > >     fifo_timeout +=3D 20 * NSEC_PER_MSEC;
> >
> >
