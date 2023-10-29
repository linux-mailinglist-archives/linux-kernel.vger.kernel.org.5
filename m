Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD3E7DABD9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 10:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjJ2JG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 05:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJ2JGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 05:06:25 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1198D3;
        Sun, 29 Oct 2023 02:06:22 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1ef36a04931so2203650fac.2;
        Sun, 29 Oct 2023 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698570382; x=1699175182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofukGO/Db7Y1mdtwCj74nUvsL9cui4KEfjb1HkdjhFQ=;
        b=Qdo/4esR7Vaa7NY8nXEntA8axb3JRDjESjOLoNWNmIMls0ke/M97O59pIa/Ds7zlNb
         QhMGe4dI99w/601hcyxd5AkWIlHyGLRy3FdnInv7wJ46Br9zOaI0lQMf6P607EZJ22Gn
         8fYtxUfRDhnWyIwNvJOid20GzXxyzTdZFTM1KyNdSygaO7scWuszgPd+x3GoRJSQwO6G
         c5VkVZgvRzPcBnTgxMfc7fZFNc8m5tS4S+/6A30hfVh93dkY+a/vLjeAp48t4HLEu3qJ
         Nzeor54KdoHgBUvJ3J5T06jpPA2zNespQGKpFF4o6Eb6NqlKQxqFHpR9NBOtWPWOAL6h
         cW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698570382; x=1699175182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofukGO/Db7Y1mdtwCj74nUvsL9cui4KEfjb1HkdjhFQ=;
        b=TsSxoqvSRMETkw8bcRwVijsIVHDG1bke8O8NVCduhDtrw+dGdzLf8RdROLMc7APwBY
         9Sa7wivbfKXsx3DZB/ozkam0tguC/TeMtXrjU6haS6tIywToH567tQ0PnZf2UuH52Keb
         1V9wAgMgHeE/8quYXrn0RlXlx7YbLCHSa0AiXc9L0qahIxabi/eLXqDA/6ABYO6UgIm/
         TXZnRhqk2XPG8qvJbHCJa8AlHXugwQ2GTOJwyOizY0yXcIveMZ7PeBIDcsw1MKffpXBU
         ILAypmOSxdiJQLHtz3g+xB7N+jt1RSvC9zSxn+/LKc/1GV418+w2m8rZNsgPdsC70vqm
         diAw==
X-Gm-Message-State: AOJu0YySu2/klTqYtuCJbkrEXN6lyA4lhj5tPXRm+rFFvY2zDUAw25X5
        k2unXeXe8sRLXAY2UuQHrKEIh82Mx6rVG0RwUEl3mnX7fuw=
X-Google-Smtp-Source: AGHT+IFdYtt+MSs8NePVx106JkUD7CyEFYfFnwgNPmVFTKI8xB2AyROW8SITDpnBdIXeirknOO7zWoB13NYdMjYzAXw=
X-Received: by 2002:a05:6870:815:b0:1e9:9c39:a580 with SMTP id
 fw21-20020a056870081500b001e99c39a580mr8468921oab.7.1698570382044; Sun, 29
 Oct 2023 02:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231025013939.353553-1-james.hilliard1@gmail.com>
 <ZTwWmHC7Wcd5iwqS@google.com> <CADvTj4oH=3Q3EShC-FM9ob7EnvFe4t2LHyDEwr-e7=G8M=UzYg@mail.gmail.com>
 <ZT3S43_eMdwHWu2u@google.com>
In-Reply-To: <ZT3S43_eMdwHWu2u@google.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sun, 29 Oct 2023 03:05:59 -0600
Message-ID: <CADvTj4o8jSnQewB8bhCxGkOQrRPN9+EsqPg7D5+s7O2rkBMK8Q@mail.gmail.com>
Subject: Re: [PATCH v2] Input: cyttsp5 - improve error handling and remove regmap
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 9:35=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sat, Oct 28, 2023 at 03:31:00AM -0600, James Hilliard wrote:
> > On Fri, Oct 27, 2023 at 1:59=E2=80=AFPM Dmitry Torokhov <dmitry.torokho=
v@gmail.com>
> > wrote:
> >
> > > Hi James,
> > >
> > > On Tue, Oct 24, 2023 at 07:39:38PM -0600, James Hilliard wrote:
> > > > The vendor cyttsp5 driver does not use regmap for i2c support, it
> > > > would appear this is due to regmap not providing sufficient levels
> > > > of control to handle various error conditions that may be present
> > > > under some configuration/firmware variants.
> > > >
> > > > To improve reliability lets refactor the cyttsp5 i2c interface to
> > > > function more like the vendor driver and implement some of the erro=
r
> > > > handling retry/recovery techniques present there.
> > >
> > > Sorry but you need to elaborate more on what is missing in regmap and
> > > how vendor code is better. In my experience vendors rarely follow ker=
nel
> > > development and either are not aware of the latest kernel APIs, or th=
ey
> > > simply have the driver written to what we had in 3.x kernels and have
> > > not really updated it since then.
> > >
> >
> > I'm unaware of a way to do essentially raw reads when using regmap, for
> > example I don't know of a way to implement the cyttsp5_deassert_read
> > function using regmap, maybe there's a way I'm not aware of however?
>
> What is wrong with current way of reading from the input register? It
> should clear the interrupt line.

It doesn't seem to work reliably, for example I would often see this error:
[    2.234089] cyttsp5 2-0024: HID output cmd execution timed out
[    2.239957] cyttsp5 2-0024: Error on launch app r=3D-110
[    2.245150] cyttsp5 2-0024: Fail initial startup r=3D-110
[    2.257502] cyttsp5: probe of 2-0024 failed with error -110

Note that cyttsp5_hid_output_bl_launch_app is called immediately after
cyttsp5_deassert_int with the existing driver so presumably it doesn't actu=
ally
clear the interrupt line correctly.

Some more details:
https://lore.kernel.org/all/CADvTj4pdSkg5RWGThmj8Z_gOL5g2Ovhvfc-XtYTU88_0ve=
4NPw@mail.gmail.com/

>
>
> >
> > In general the issue with regmap seems to be that regmap always does
> > operations against specific registers and prevents doing raw i2c operat=
ions
> > needed to handle some hardware/firmware issues for some variants.
>
> What are those issues and why do they need raw access.

Mostly startup issues with cyttsp5_deassert_read and retry logic from what =
I
can tell. It appears that in some cases(such as when the system is rebooted
without fully powering off) multiple i2c reads are often required to flush =
some
sort of firmware side message queue so that the firmware is in a state in w=
hich
it will respond to commands normally.

I don't understand the reason this driver was written using regmap in the f=
irst
place, from my understanding of the protocol using regmap is not appropriat=
e
as you can't correctly model an i2c-hid like protocol(like cyttsp5 uses) us=
ing
regmap.

Note that upstream drivers like i2c-hid don't use regmap either.

>
> >
> > Note that I'm not exactly doing things the same way the vendor driver d=
oes,
> > I have simplified the error recovery/retry code paths in the startup
> > function.
> >
> >
> > >
> > > >
> > > > As part of this rather than assuming the device is in bootloader mo=
de
> > > > we should first check that the device is in bootloader and only
> > > > attempt to launch the app if it actually is in the bootloader.
> > >
> > > I would prefer if this was split into a separate patch.
> > >
> >
> > I think this change is somewhat intertwined with the probe retry/recove=
ry
> > logic
> > changes and is a bit tricky to split out without breaking the startup
> > sequence
> > from my testing at least.
>
> I understand that it might be tricky but each logical change should
> stand on its own.

Ok, I'll see what I can do there.

>
> Thanks.
>
> --
> Dmitry
