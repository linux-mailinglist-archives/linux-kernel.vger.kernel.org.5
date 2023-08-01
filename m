Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046CA76A8CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHAGQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHAGQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:16:03 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F286919A4;
        Mon, 31 Jul 2023 23:16:01 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-796d78b3f68so1457103241.0;
        Mon, 31 Jul 2023 23:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690870561; x=1691475361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p4vegdTGZZl1nUF88RrkC2NO7bjSePCHC5eJz2k+n0=;
        b=WOPiuNCzVdzVYR27WqJiPiOpEZzYJhMmSc0/VVNbAjqxK1J26VWm1G7AHsUaZ7pfAz
         4qmkmWFW2vB2KyVABbXYvyHA3ZRDdwYucLcuUeuUGi5H+NnEROT+vfAGTz3c3QQFHzz6
         AxQolPfRWx+Z++yG2zZVWWqEK+6dJr3jjMpHF1icEb43hj9iOJT9D95k49Fv63bvwPLt
         nuHepY1kVAI67FmVKPBjljtDJ3bON4fK9rq2BQv1aLLVrC9tP+i84FXDMnA3dyxkPERb
         g4p6mCM0oZq+Vs91ckgIkfXaHPjTuqgbXxCneeqNYa6Ya48hd9MZXXTwWre0hhN8u2uN
         A1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690870561; x=1691475361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p4vegdTGZZl1nUF88RrkC2NO7bjSePCHC5eJz2k+n0=;
        b=i+oYQLoLIMxbEFPoM2bDlhvO7lNUAsFzQuafg2j3h9PkT/v3wHZQzo0HBPtwAWFAZi
         6nIx/bNwaWuLp7vSGpBDnDy254N2OJtZcet6v3obR6owZJbwg9KkYSNpXgvPZWZfrWo6
         pWtvaenRg3DYDVZfcLMejJAOxriapBLvtt7TYLPaWX0+szJTSHJ+TFHh+qflix0NwfVt
         D4hjNZCJjSfAyjmrR54HqwaUpmBg69TeFnPERZ3izZFOdWVpoM4KTq0qx84g9SACPvvc
         QbEuQ/VBdoJfS6ESQAH4nbZz5F2IcLDCA3Oc1Tpk7L7Dua+HxWvcgzoc/pONVC4+eShb
         zh5A==
X-Gm-Message-State: ABy/qLZOwtFdmfycRpkBkajpwHm780ICETJQzE0UXAOpt/Q6DFSCekYv
        t2CZsK2bs7G3Hk2/nF+cMQY09nWjkl7TO9o7NYE=
X-Google-Smtp-Source: APBJJlEK+im1T3JcIjDbH3Z4zYFH21mLcWyXFPRlAjqbM2LX9B3Llw5toJIE3Hn1vN9kLImqV4R70L+br44wSg4o84U=
X-Received: by 2002:a67:e9c3:0:b0:447:4cb2:74fb with SMTP id
 q3-20020a67e9c3000000b004474cb274fbmr1459416vso.19.1690870560887; Mon, 31 Jul
 2023 23:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230801045449.156348-1-zhouscd@gmail.com> <2023080159-uncorrupt-chamber-7de0@gregkh>
In-Reply-To: <2023080159-uncorrupt-chamber-7de0@gregkh>
From:   =?UTF-8?B?5ZGo5Z+O5Lic?= <zhouscd@gmail.com>
Date:   Tue, 1 Aug 2023 14:15:50 +0800
Message-ID: <CAN4mUXNNM-25oCx1jjVqqoPpX1P8Z4zkjh84Azprz52O4_AMNw@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: Fix the function name error in sourcesink/loopback.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  Greg KH

> I do not understand this text at all, sorry.
> What exactly is broken and what is changed here to resolve the issue?

The reason for the problem is that the value of struct
usb_function.name is "loopback", while struct usb_function_driver.name
is "Loopback". The same issue exists for sourcesink. When using USB
Config FS, it won't be possible to enable these two functions.

> And please use your full name for patches.

I'm sorry, this is my first time sending kernel patch. How should I
modify my name for the patch that has already been sent? Or should I
resend a new patch?

> You just changed a user-visable api, right?  Where did you document this
>  and what will it affect?

Yes, I removed lb_modexit and lb_modinit and used a simpler method for
function initialization. This does not affect any other
functionalities. In the old way, the loopback function was called by
sslb_modinit in sourcesink. I believe this is not a good approach as
the loopback and sourcesink should be independent functionalities.
Their purpose is to provide simple examples for USB beginners like myself.


Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=BA=8C 13:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 31, 2023 at 09:54:49PM -0700, zhouscd wrote:
> > Inconsistent function names can cause the USB config FS not work.
>
> I do not understand this text at all, sorry.
>
> What exactly is broken and what is changed here to resolve the issue?
>
> >
> > Signed-off-by: zhouscd <zhouscd@gmail.com>
>
> What commit caused the problem?
>
> And please use your full name for patches.
>
> > ---
> >  drivers/usb/gadget/function/f_loopback.c   | 13 +----------
> >  drivers/usb/gadget/function/f_sourcesink.c | 25 ++--------------------
> >  drivers/usb/gadget/function/g_zero.h       |  3 ---
> >  3 files changed, 3 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gad=
get/function/f_loopback.c
> > index ae41f556eb75..45f542b5ff55 100644
> > --- a/drivers/usb/gadget/function/f_loopback.c
> > +++ b/drivers/usb/gadget/function/f_loopback.c
> > @@ -583,16 +583,5 @@ static struct usb_function_instance *loopback_allo=
c_instance(void)
> >
> >       return  &lb_opts->func_inst;
> >  }
> > -DECLARE_USB_FUNCTION(Loopback, loopback_alloc_instance, loopback_alloc=
);
> > -
> > -int __init lb_modinit(void)
> > -{
> > -     return usb_function_register(&Loopbackusb_func);
> > -}
> > -
> > -void __exit lb_modexit(void)
> > -{
> > -     usb_function_unregister(&Loopbackusb_func);
> > -}
> > -
> > +DECLARE_USB_FUNCTION_INIT(loopback, loopback_alloc_instance, loopback_=
alloc);
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/g=
adget/function/f_sourcesink.c
> > index 6803cd60cc6d..f6d1c095aa2c 100644
> > --- a/drivers/usb/gadget/function/f_sourcesink.c
> > +++ b/drivers/usb/gadget/function/f_sourcesink.c
> > @@ -858,7 +858,7 @@ static struct usb_function *source_sink_alloc_func(
> >       ss->bulk_qlen =3D ss_opts->bulk_qlen;
> >       ss->iso_qlen =3D ss_opts->iso_qlen;
> >
> > -     ss->function.name =3D "source/sink";
> > +     ss->function.name =3D "sourcesink";
>
> You just changed a user-visable api, right?  Where did you document this
> and what will it affect?
>
> thanks,
>
> greg k-h
