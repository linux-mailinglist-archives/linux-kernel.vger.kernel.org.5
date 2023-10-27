Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DB87D9A93
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346047AbjJ0N6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345996AbjJ0N6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:58:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE7C0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:58:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso3103e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698415106; x=1699019906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I06EvxGHjZIwzPaPsKm9/VYgT9VaTOcKNELZpAZ5HrU=;
        b=XHCCqkTeoyzrNSbep2ZajsZ4+YXcm+Ls+8rw6L0dvSFVcZdZqSzlICxG/f5wj4druL
         rfTNtEKwMM1LYkZT6pV19GAxsrUvjLmk8RI8pMQ1drlRjR0JXI21rsdOep+RsRnoe3/x
         ejReCHnuZgrdeR5t9NgwecJuDb+ntKsdlfmX5bcJNp7a7ZIwMHt9E2VIDRw33wX+S7Kd
         gyOZ9caaBoGmB+3Q2mOQmteB6NOUTKKLqBPnF3atz6AkXOEef68Pt5ocnqrCV4FyA86N
         0V44F3kBRxLrgeq9jyt0uBGpGpPo3NBEyec+0MsggiK55FeZ9x+/shWMzUAI8Ug3L7Ye
         LaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698415106; x=1699019906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I06EvxGHjZIwzPaPsKm9/VYgT9VaTOcKNELZpAZ5HrU=;
        b=sfWHYdBABZi1Ii6d5aIeU2IifNicxC8cGVxTk9i8UdZMGT6aEsPenro3MbBuDQOUQD
         mUgkdt4t4gIvbdNkizqupY0sjLpLO9FcPOGOOBtcH6qmZzcltiQNmIxBDLXJOUwo2buj
         /HCzkGiETQW47Cr/8Kn+Ch56WyIG8NgaRjuYhAKC7rSlbdOBYwnMsrCxz7pls/Qxj1ED
         A7NvESVS8G8SvhhAC6athSWfCphax0NGvqleaDk9DmvaAxpUjCAK6eOz7U99hixTtL4i
         47DSaWAYdE6KotpLcUB6Da1FoeDsInd7fekfxv7rQVPAyHR7a6n/IhKrMwflaBBueseZ
         A+sA==
X-Gm-Message-State: AOJu0YxJ37RJXTA4Jtj8IzIOUb23t0XGtrN4zacJC79gHWroW3LyHSVi
        0tJD/xwf93AhWyjGfH9YNndwglgr1IBTpOrmHOIFWg==
X-Google-Smtp-Source: AGHT+IFMpr3rofEls+Hd9p5f+Lak9nJ0j0GM2NNACzWdEkHubF8mqlzEXV87LiJ5AZJIJ4B4kF8LTdf+dUTHIzJ9GaQ=
X-Received: by 2002:a05:6512:36c9:b0:507:8c80:f1d1 with SMTP id
 e9-20020a05651236c900b005078c80f1d1mr84936lfs.2.1698415105199; Fri, 27 Oct
 2023 06:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231026135628.2800617-1-vamshigajjela@google.com> <2023102712-frolic-bush-3d67@gregkh>
In-Reply-To: <2023102712-frolic-bush-3d67@gregkh>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Fri, 27 Oct 2023 19:28:12 +0530
Message-ID: <CAMTSyjpzrwnbzcjm1nO9Zi7sn7yOGb8sxMjEJGgZoQLgDCx99g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
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

On Fri, Oct 27, 2023 at 12:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 26, 2023 at 07:26:28PM +0530, Vamshi Gajjela wrote:
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
>
> Please use lower case letters like I think you mean to?
Sure, I will update.
>
> Also, where are patches 1/3 and 2/3 of this series?  I can't do anything
> without them as well.
1/3 is dropped:
https://lore.kernel.org/lkml/CAMTSyjqc118-by6LRHaSN7k8fOcR6K0kmYXdthPD7rqJu=
YOaVw@mail.gmail.com/
2/3 is a clean up:
https://lore.kernel.org/lkml/CAMTSyjpiz_LVtVAzaNpD-xThtp6sKNy-Uvkr+CaH9b10V=
RYD9A@mail.gmail.com/
for 2/3 waiting on response from Ilpo J=C3=A4rvinen

>
> > The function uart_fifo_timeout() returns an unsigned long value, which
> > is the number of jiffies. Therefore, change the variable timeout in the
> > function uart_poll_timeout() from int to unsigned long.
> > Change the return type of the function uart_poll_timeout() from int to
> > unsigned long to be consistent with the type of timeout values.
> >
> > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > ---
> > v3:
> > - updated description
> > v2:
> > - unsigned long instead of unsigned int
> > - added () after function name in short log
> > - updated description
> >
> >  include/linux/serial_core.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index bb6f073bc159..6916a1d7e477 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struc=
t uart_port *port)
> >  }
> >
> >  /* Base timer interval for polling */
> > -static inline int uart_poll_timeout(struct uart_port *port)
> > +static inline unsigned long uart_poll_timeout(struct uart_port *port)
> >  {
> > -     int timeout =3D uart_fifo_timeout(port);
> > +     unsigned long timeout =3D uart_fifo_timeout(port);
> >
> >       return timeout > 6 ? (timeout / 2 - 2) : 1;
>
> So we are now doing 64bit math?  Did that just make things slower?
>
> What bug is this actually fixing?  How have you tested this to verify it
> works?
>
> thanks,
>
> greg k-h
