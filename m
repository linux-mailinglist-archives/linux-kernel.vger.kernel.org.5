Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13EB7BABE1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjJEVWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJEVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:22:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAFA95;
        Thu,  5 Oct 2023 14:22:07 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-564af0ac494so1044440a12.0;
        Thu, 05 Oct 2023 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696540927; x=1697145727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vR11VcSycWMnF0G38upGXhqs80RNqCoLM8Yc54IYpxM=;
        b=icUJFlz+hlDPbQRDi9Y7LpKpZsbSFdcvcrCn56mgif0nqZ8oWeJqmrz7nSzCFrZjPf
         3rskEpVjIDxpSRo4XpmouFdWJ+f+5yZKh6J7VpsekAtIx6IY1eQi9wul2+AuDoknfS8D
         2NdHuO3+FQWhE4XBhOIF7Qb57HfVy7r0FmY1GfQmWv1nZrLTnd/NlZ+1xwSVL+V/cEo3
         s7cogLvJ/3SQVOFV0LRMnQ1JlAutPuya576D60rCpXkR5kWagaqCNZDZoPK2+ToN1ean
         BvCdq3BrWwTRT1jpGzzG+BTPCTzyCrmGgpC1zAjqoWP0MM4kn/oYsbMDr2haiNokR81d
         Ca0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696540927; x=1697145727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vR11VcSycWMnF0G38upGXhqs80RNqCoLM8Yc54IYpxM=;
        b=hkky4JpOyXrt/R+xzJWi9CqGPqr9iHVEL/VjwIz1bpp/tCe8cn8skpTJ9SSW6alcmk
         AuqOn/2Sjf2pUN73dPZrHhHz2UElhT4L1Fgj3J1XwQ75fOlFeJ3PEkC8mQewZniHnEci
         bPLR7F7DO3jfHpp3TVCdAxgo9/av0PhLOcZ7Ro3B5KmjBHCg5CEeSuUX1+DFE+1kArdr
         CnhtVEfm5SgDv+VtxDr9bxty6FHKakciZJOLSqYLK3YA8IN2yZV/7hnX0Iq1ZFuGZQf9
         G6uRrt0krQ89z/UaSX7lxHLp7Pxiibwa3XRszlWrh3FovQf0N9LImOeOMFN5ak7fXQiE
         SVkw==
X-Gm-Message-State: AOJu0Yyrynq2dHj/hzKHPbogIjJXDxBu2ipxTvHwYWAmS8zJW4cPIq1M
        AZY2xbcu5H8rrQRH4tX2zCyawE7rugZKBlpKveA=
X-Google-Smtp-Source: AGHT+IHc1YIkEdrWv9pd8ej0GQX+FpVlMxW7+nXw9UjdRsbCf+sNBIGRA5zww4B+Y8OATKMaVI/94oHaJrS7fqo5fEY=
X-Received: by 2002:a17:90b:30cb:b0:279:cea:cfa9 with SMTP id
 hi11-20020a17090b30cb00b002790ceacfa9mr6310042pjb.21.1696540927028; Thu, 05
 Oct 2023 14:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230928151631.149333-1-jcmvbkbc@gmail.com> <20230928151631.149333-6-jcmvbkbc@gmail.com>
 <2023100326-crushing-septic-4856@gregkh> <CAMo8BfJgpP-=tNEChcyR3z6i_QeJ9Ywq7EOjjC5i7Uq4OrgXNA@mail.gmail.com>
 <2023100544-rendering-identify-e0ad@gregkh>
In-Reply-To: <2023100544-rendering-identify-e0ad@gregkh>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 5 Oct 2023 14:21:55 -0700
Message-ID: <CAMo8Bf+wS+qiX2mMZm0i8dt7xkDO8RvroP8RF=78zxgFj-zwaA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drivers/tty/serial: add ESP32S3 ACM device driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 11:57=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Oct 03, 2023 at 12:46:46PM -0700, Max Filippov wrote:
> > > > Hardware specification is available at the following URL:
> > > >
> > > >   https://www.espressif.com/sites/default/files/documentation/esp32=
-s3_technical_reference_manual_en.pdf
> > > >   (Chapter 33 USB Serial/JTAG Controller)
> > >
> > > I don't understand this driver, "ACM" is a USB host <-> gadget protoc=
ol,
> > > why do you need a platform serial driver for this?
> >
> > The USB part of this piece of hardware is fixed and not controllable, s=
o
> > all we have is a very limited UART interface. But to the outside world
> > it's a USB device with the CDC-ACM interface.
>
> Where is the "outside world" here?  The other end of the tty connection?

Yes.

> So this is a "ACM gadget"?  If so, please try to use that term as that's
> what we use in the kernel to keep things straight.

Ok.

> > > > diff --git a/drivers/tty/serial/esp32_acm.c b/drivers/tty/serial/es=
p32_acm.c
> > > > new file mode 100644
> > > > index 000000000000..f02abd2ac65e
> > > > --- /dev/null
> > > > +++ b/drivers/tty/serial/esp32_acm.c
> > > > @@ -0,0 +1,459 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > >
> > > Why "or later"?  I have to ask, sorry.
> >
> > I don't really have a preference here. Is there a reason to choose
> > GPL-2.0 only for a new code?
>
> It's your call, you need to pick that, but I can provide recommendations
> if you want :)

Please do?

> > > And no copyright information?  That's fine, but be sure your company'=
s
> > > lawyers are ok with it...
> >
> > There's no company behind this, just myself.
>
> Great, it's your copyright, be proud, put it on there!

If I don't have to I'd rather not. This is just a piece of meaningless nois=
e.

> > > > +#define DEV_NAME     "ttyACM"
> > >
> > > There is already a ttyACM driver in the kernel, will this conflict wi=
th
> > > that one?  And are you using the same major/minor numbers for it as
> > > well?  If so, how is this going to work?
> >
> > I'll rename it to ttyS. I see that it coexists with the other driver th=
at calls
> > its devices ttyS just fine.
>
> Great.  But if you are going to be like a ACM gadget, use ttyGS like
> that driver does?

Ok.

> > > > --- a/include/uapi/linux/serial_core.h
> > > > +++ b/include/uapi/linux/serial_core.h
> > > > @@ -248,4 +248,7 @@
> > > >  /* Espressif ESP32 UART */
> > > >  #define PORT_ESP32UART       124
> > > >
> > > > +/* Espressif ESP32 ACM */
> > > > +#define PORT_ESP32ACM        125
> > >
> > > Why are these defines needed?  What in userspace is going to require
> > > them?  If nothing, please do not add them.
> >
> > I don't understand what the alternatives are. The comment for the
> > uart_ops::config_port() callback says that port->type should be set
> > to the type of the port found, and I see that almost every serial drive=
r
> > defines a unique PORT_* for that.
>
> Yes, but not all do.  If you don't need to do anything special, it can
> just claim to be a normal device, we've had threads about this on the
> list before.  If you don't need to determine in userspace from the tty
> connection what device it is, just use the default one instead.

Ok, it looks like having

#define PORT_ESP32ACM (-1)

in the driver source should be ok? I've tested that it works.

--=20
Thanks.
-- Max
