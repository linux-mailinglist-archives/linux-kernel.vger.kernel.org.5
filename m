Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BC37C9A73
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjJORuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJORuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:50:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22523AB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 10:50:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so5465a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697392199; x=1697996999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhI6/CEtA7dPuJC2WbvamIAcAZbCRPrEicy0biCB5oM=;
        b=yF2QnBJbFrpP1iRq/qALEwYezT77hXdRXPpmHRaAfADC17pW0W7k/k9lh3wZoIosLi
         eCUp6YmLgyBitR3u0uiEoDY54n3Rfgv+90FoKq+EpEgYazD+Xdh5Bntz3CTXDjxvjpLQ
         UQrB8FnTgu74TEbS0JVr60Cg3V79CUBo+pz2s6zCKpvzLd/qLYPu3J0JbvqHlQZGYwQU
         m1YWqILXCuRMavlSAMipjDDBiNh3PD/jt1Ok7b+nER5ZA8grow7iD1S3azq4O9hhliLm
         NALeekhhD10S4XbLv0xmMH1feQZkqUr0t3mCVxuU09jvThe+J1AbQPVys/xbN0wM4Kg5
         iZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697392199; x=1697996999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhI6/CEtA7dPuJC2WbvamIAcAZbCRPrEicy0biCB5oM=;
        b=ZkCnRCwJcNu/zR2bYaNKq7rMX2EKTVLCdh4GL/sVQgFQaBMVlTtdNx8k5Zpt2EmYR+
         Bv+rPs9J7V9V+98QWLyfKihz3RSXmfNKkmOmGA6hDgHS2KaKPi8LrwMxIgtdHJRKlmNz
         9+wVl8pzKH3URzFXDCZVjgvAgY1itJOXlViG1qunmJvtqZhPD0t+c+T1zYouMP5i0+yq
         IFxUNH3m41xdEdXSGsfyJYxxW1LLl5jr8cXFbOsvCaJRMm7/F3dzT+sZAJ+Bbs/Uw95a
         EzQFw4pWpoywS6lqTM89rzlvNZJDaLBmK9pLNQEfd9Y0OOHUca2sS/NDz4sO5yG/IkqA
         6lBg==
X-Gm-Message-State: AOJu0YxFGLDMnDwTm94JgYKIPwysw0cv0EawXu6FlyTcerVAhkUm6diP
        sqkzHA56TxfrUdyH5KKdZWJeVmppgu1if9GugkdvKA==
X-Google-Smtp-Source: AGHT+IF7HTW4HSQYWHMETNkTzAk/Ya6xhaLXwi7KHbmL9ZmGzJDwwiQqJu77JqH6Sl2GyBBNxDTh6tmX1tMx4sykqac=
X-Received: by 2002:a50:8a95:0:b0:538:5f9e:f0fc with SMTP id
 j21-20020a508a95000000b005385f9ef0fcmr147551edj.0.1697392199329; Sun, 15 Oct
 2023 10:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231014181333.2579530-1-vamshigajjela@google.com> <20231014191355.7f44aac3537a8d260225fa0c@hugovil.com>
In-Reply-To: <20231014191355.7f44aac3537a8d260225fa0c@hugovil.com>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Sun, 15 Oct 2023 23:19:47 +0530
Message-ID: <CAMTSyjohXMQVqesqWsqd=vfRGEhqFB=MBnh8ZRk3hjHOXLdEkg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] serial: core: Potential overflow of frame_time
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 4:44=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> On Sat, 14 Oct 2023 23:43:33 +0530
> Vamshi Gajjela <vamshigajjela@google.com> wrote:
>
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
>
> Hi,
> your commit title doesn't really explain what this patch is doing.
>
> Please see: https://cbea.ms/git-commit/#imperative
Thanks Hugo for the review, I will provide details in the following respons=
e.
>
>
> > uart_update_timeout() sets a u64 value to an unsigned int frame_time.
> > While it can be cast to u32 before assignment, there's a specific case
> > where frame_time is cast to u64. Since frame_time consistently
> > participates in u64 arithmetic, its data type is converted to u64 to
> > eliminate the need for explicit casting.
>
> Again, refering to your title commit message, I would expect that you
> would describe precisely how a potential overflow can happen here, and
> I am not seeing it.
>
> And based on your log message, it seems that your commit is simply some
> kind of optimization, not a fix?

In the function uart_update_timeout() within serial_core.c, a u64 value is
assigned to an "unsigned int" variable frame_time. This raises concerns abo=
ut
potential overflow. While the code in the patch doesn't explicitly manifest
the issue in the following line of uart_update_timeout()

"port->frame_time =3D DIV64_U64_ROUND_UP(frame_time, baud);"

lacks a u32 typecast for frame_time.

In the function "uart_fifo_timeout" has the following line of code

u64 fifo_timeout =3D (u64)READ_ONCE(port->frame_time) * port->fifosize;

In the above line frame_time is typecast to u64

also, timeout values in the serial core associated with frame_time are used
in the u64 arithmetic. To maintain consistency and readability, I've update=
d
the size of frame_time from "unsigned int" to "unsigned long". This ensures
uniformity with typecasts elsewhere in the code, addressing potential issue=
s
and enhancing clarity.

I hope this provides clarity. Would you find it helpful if I were to provid=
e
further details in the commit message?
>
> Hugo.
>
>
>
> > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > ---
> > v2:
> > - use DIV64_U64_ROUND_UP with frame_time
> >
> >  drivers/tty/serial/8250/8250_port.c | 2 +-
> >  include/linux/serial_core.h         | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 141627370aab..d1bf794498c4 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1510,7 +1510,7 @@ static inline void __stop_tx(struct uart_8250_por=
t *p)
> >                        * rather than after it is fully sent.
> >                        * Roughly estimate 1 extra bit here with / 7.
> >                        */
> > -                     stop_delay =3D p->port.frame_time + DIV_ROUND_UP(=
p->port.frame_time, 7);
> > +                     stop_delay =3D p->port.frame_time + DIV64_U64_ROU=
ND_UP(p->port.frame_time, 7);
> >               }
> >
> >               __stop_tx_rs485(p, stop_delay);
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index bb6f073bc159..b128513b009a 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -558,7 +558,7 @@ struct uart_port {
> >
> >       bool                    hw_stopped;             /* sw-assisted CT=
S flow state */
> >       unsigned int            mctrl;                  /* current modem =
ctrl settings */
> > -     unsigned int            frame_time;             /* frame timing i=
n ns */
> > +     unsigned long           frame_time;             /* frame timing i=
n ns */
> >       unsigned int            type;                   /* port type */
> >       const struct uart_ops   *ops;
> >       unsigned int            custom_divisor;
> > @@ -764,7 +764,7 @@ unsigned int uart_get_divisor(struct uart_port *por=
t, unsigned int baud);
> >   */
> >  static inline unsigned long uart_fifo_timeout(struct uart_port *port)
> >  {
> > -     u64 fifo_timeout =3D (u64)READ_ONCE(port->frame_time) * port->fif=
osize;
> > +     u64 fifo_timeout =3D READ_ONCE(port->frame_time) * port->fifosize=
;
> >
> >       /* Add .02 seconds of slop */
> >       fifo_timeout +=3D 20 * NSEC_PER_MSEC;
> > --
> > 2.42.0.655.g421f12c284-goog
> >
