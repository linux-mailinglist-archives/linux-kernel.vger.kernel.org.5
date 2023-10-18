Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C527CDDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbjJRNpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJRNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:45:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49270EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:45:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a085efa7so2720e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697636720; x=1698241520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SdoSLraaUpiO2hxeaPG/kpnWvBaHLQjx53dLk1QOUI=;
        b=D2hs+wrGWj3IDATCBRoKs+I6aMQqQ+cuAwfMW+CSkmypMkMstG2tKNT1iyZXuMkiDF
         SZQZ3Xk/dd9W2kxSlNIa+ioc+OMhS1c0Y4q6VRlhfa7ZX/6jSU26yPFoEoMm7442Le/K
         zzVxczMh4w7Sv1MnRzqXYxw1RQtD9f9kFlYfueTyyALCAvvppyCyWTtkITXeoABCurA6
         zX4QLYXcaJaqII56L8/994TDoc3UOZ7GYsIUzGOdb8wY02lICYuHMvwfy/fOM4H1SMO8
         bMgI0gHWo/JWOWB0CpHCg9tsWFNYztV8xJv/xDFMT5PvTRbGPUBFH+V9hTd8A3bybEsD
         0xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697636720; x=1698241520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SdoSLraaUpiO2hxeaPG/kpnWvBaHLQjx53dLk1QOUI=;
        b=FqJT3sbvsHVarsVcOrFWhhEktlrekEvtIhtukz6uu0l5FEbSpBhnUMA7hO3MfbMpQe
         +iyC51aHp6TXXBzMVtWUm/b7WEN0Jpg/MJTul5u8csubBVO7z85UYNpm+XkILymzXhkM
         0wOoig3t7smMPMeOXKVIduKPnPr7Qqb9sDW83tEZNDqvegI81dsDvNQX0+4/aJ+czMqA
         gZMK7CIwIaMeVltyer9LI7nMKJM/ICtnkGCqLxpgpRs/SeQnKgAO3Gi4vuOdRXtsqud1
         3GhQ4EToUVhZEX4wLA0kcHTkDMShoHYE8OdEIMJhfk3Sf8GmJEH1YBNjkYI33auV7LX5
         uqNg==
X-Gm-Message-State: AOJu0Yw54LVpXCSDC+AV3Gt07mWjU8N1y/f9CJAh/1mOuAJ8e1r84LeC
        39qZ98L6OGJg1UJPb0xW7HWSciw4OZ1chHbEz56QoQ==
X-Google-Smtp-Source: AGHT+IG1Fg4xreTaImitI1zxa/Wtx1EsfhB2K9IVt7kw7nSySHSFAau2Lqk438SYZe4fvfkaA6PFU89oMueQibcXqnU=
X-Received: by 2002:ac2:5e75:0:b0:502:932e:2e36 with SMTP id
 a21-20020ac25e75000000b00502932e2e36mr80849lfr.2.1697636719997; Wed, 18 Oct
 2023 06:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231014104942.856152-1-vamshigajjela@google.com>
 <20231014104942.856152-2-vamshigajjela@google.com> <6f25e6fb-bebc-3f9b-9876-5e14d2582f6@linux.intel.com>
In-Reply-To: <6f25e6fb-bebc-3f9b-9876-5e14d2582f6@linux.intel.com>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Wed, 18 Oct 2023 19:15:07 +0530
Message-ID: <CAMTSyjqc118-by6LRHaSN7k8fOcR6K0kmYXdthPD7rqJuYOaVw@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: core: Potential overflow of frame_time
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
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

On Mon, Oct 16, 2023 at 4:03=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sat, 14 Oct 2023, Vamshi Gajjela wrote:
>
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> >
> > uart_update_timeout() sets a u64 value to an unsigned int frame_time.
>
> Yes it does, because uart_update_timeout() does math that requires u64 bu=
t
> the result is always smaller than what requires u64. If you insist on
> doing something add the cast there.
Agree, will add a cast there. Can I do that as part of the patch series 2/3
+     u64 size =3D tty_get_frame_size(cflag);
in uart_update_timeout
>
> > While it can be cast to u32 before assignment, there's a specific case
> > where frame_time is cast to u64.
>
> Because it gets multipled with something that results in a big number
> The cast is all correct too because the developer actually thought of
> possiblity of an overflow on multiply (something every developer should
> be conscious of), so there's nothing to see there either.
Yes, nothing wrong.
>
> > Since frame_time consistently
> > participates in u64 arithmetic, its data type is converted to u64 to
> > eliminate the need for explicit casting.
>
> You need a way more convincing argument that that since you're not even
> converting it to u64 like you falsely stated so the sizes still won't
> match on all architectures.
"all architectures." is something I have missed while considering this patc=
h.
>
> I see you've realized u32 is more than enough to store frame time for the
> speeds UART operates with? So why exactly is this patch needed? Should al=
l
> the other cases where 64-bit arithmetic needs to be used in the kernel be
> similarly upconverted to 64 bits?
Certainly not for other 64-bit arithmetics, I will course correct.
yes u32 is sufficient to store frame time.
>
> Also, did you happen to realize frame_time also participates in 32-bit
> arithmetic which you just make much worse with this change? (Yes, there
> are 32-bit divides done for it.)
char_time =3D max(nsecs_to_jiffies(port->frame_time / 5), 1UL);
Here is that instance




>
> So NACK from me to this "fix" of a non-problem by causing much worse
> problems you seem to be entirely unaware.
>
> NACKED-by:  Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> --
>  i.
>
> > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > ---
> >  include/linux/serial_core.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
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
> >
