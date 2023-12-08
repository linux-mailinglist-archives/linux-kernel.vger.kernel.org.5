Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE9080A690
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574104AbjLHPGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574145AbjLHPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:06:47 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B02199B;
        Fri,  8 Dec 2023 07:06:52 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso3007904a12.1;
        Fri, 08 Dec 2023 07:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702048011; x=1702652811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V1/9BltMcK/T1WnIZlF2XMjFfUalFA2keeh04VI0Egk=;
        b=fhnPXzOvG59tMyuIahr2kpoT926GU9WOEFey6gcKP7ymuZRapW0dYgyzNRNWBNSrd8
         pJKcwi/JEsz+5GfMUy/RmVs5coBFpqTPt1Yz15sLMNIK/uPZY/8522zEHwX+HoMTjYf8
         M6fXQjMc+Kh9jVY5zFchrSWrUxuR+jLN4ecuq2rqha/9Wly8QigGAgL4mUxJuZ7IQU4d
         2Ik8L4J9EvjoPfKOhPHdUfaoE5P8nvCoMCK7JEleQP1uZMztF1JKqu81ejxVzaQWIKGl
         7giXIpKRjQ5V0417kcSIeR9V4QR4uHFgy9t8Iq6Z4uiqUL9rZdiKs1LpUKNud8uHhp6r
         Dk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048011; x=1702652811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1/9BltMcK/T1WnIZlF2XMjFfUalFA2keeh04VI0Egk=;
        b=qAh5ZTzKaQgwJXNnCkN1ncfTAnWNP4l0Gb+Gt2oAjkts4usUyqiddmPpebUIxLYI4y
         UWn+VxZZUhHyB9X+FNvt7jIiEkSVwwL/o9LCJhRGu16b/uoqgOKG9JUvDJO35kBXK+kn
         0XI9k276R1Jg1LjnXAkShPwrDdFXWegG43UVuHPQJr2g61j5sAt6sXz3dho4pZ11ZceJ
         +n5hfeig9swqeVozD5ruJhJAUcWjznLasANf9u7aoUqBBrWQZdx0NeU9eoo6tet4IPTY
         jPOeoCJ65AP6cl3QVJqNbmT8Lmvi1/FtxTgjEwjkSM1uIUu6izb5y2y4zbxGcc4tBst9
         Ga0g==
X-Gm-Message-State: AOJu0YwdraJF4JvAt+ALaAS1qDVkAYysw5V5/g18mYDlF/Aewz6iy0Dc
        XLEXL4kNQHWKavo+vqMEqXyowKfEUYkUYA==
X-Google-Smtp-Source: AGHT+IGS9lboT4wrlJKPIq2Hm6L99GqDZgzqgrHzo+ijDjlH86ZVCasSlzK2nWDHcxc6Iz23891S1A==
X-Received: by 2002:aa7:c504:0:b0:54c:4fec:fb with SMTP id o4-20020aa7c504000000b0054c4fec00fbmr69983edq.138.1702048010983;
        Fri, 08 Dec 2023 07:06:50 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:905b:7c28:f9e2:a6aa])
        by smtp.gmail.com with ESMTPSA id o12-20020a50c90c000000b0054da352618asm841707edh.94.2023.12.08.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:06:23 -0800 (PST)
Date:   Fri, 8 Dec 2023 16:05:50 +0100
From:   Stefan Eichenberger <eichest@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     nick@shmanahar.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: atmel,maxtouch: add
 poweroff-in-suspend property
Message-ID: <ZXMwzqF8tHZuWVBN@eichest-laptop>
References: <20231207111300.80581-1-eichest@gmail.com>
 <20231207111300.80581-2-eichest@gmail.com>
 <CACRpkdbSs-vebvchxx-Tg+O5CUF5M3vZf-iytuW=ZECnHb2anA@mail.gmail.com>
 <ZXMV9gzFbc05IEKg@eichest-laptop>
 <CACRpkdao83-nALj2YOq-XHrOh6GEaxufN3Fn+3W52qkL2x+VUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdao83-nALj2YOq-XHrOh6GEaxufN3Fn+3W52qkL2x+VUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Dec 08, 2023 at 03:23:54PM +0100, Linus Walleij wrote:
> On Fri, Dec 8, 2023 at 2:11 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> 
> > > I can't help but wonder: shouldn't that pretty much be the default behaviour
> > > if wakeup-source is *not* specified?
> > >
> > > I.e. the property kind of describes !wakeup-source.
> >
> > The maxtouch controller has a deep sleep mode which is currently used
> > without powering down vdd and vdda. However, because we have a shared
> > regulator which powers other peripherals that we want to shut down in
> > suspend we need a way to power down vdd and vdda. However, I agree this
> > is not really a feature of the device. The feature would basically be
> > the internal deep sleep mode.
> 
> While it is of no concern to the device tree bindings, Linux regulators
> are counting meaning that you need to make all peripherals disable
> their regulators and it will come down.

Yes we are working on that one. This is the last driver we need to allow
disabling the regulator, afterward it should hoepfully work on our
target system.

> 
> > I didn't want to change the default
> > behaviour of the driver, so I added this property but maybe I could
> > change it to:
> >
> > atmel,deep-sleep:
> >   description: |
> >      Use the maxtouch deep-sleep mode instead of powering down vdd and
> >      vdda.
> >
> > Or to not change the default behaviour:
> > atmel,no-deep-sleep:
> >   description: |
> >      Do not use the maxtouch deep-sleep mode but power down vdd and vdda
> >      in suspend.
> >
> > As I understand the datasheet even if the maxtouch is using its deep
> > sleep mode it does not act as a wakeup source.
> 
> Do you mean it can still work as a wakeup source in deep sleep mode?
> (there is a "not" too much above ...)

Sorry for the confusion. As it is configured now, it can not work as
wakeup source in deep sleep mode. Touch is completely disabled.

> > It is just faster in
> > waking up because it can keep the configuration in memory.
> 
> That sounds like a good reason to have the property, because that
> means that if you can control the wakeup latency and specify in the binding
> how much in absolute time units it is affected.
> 
> I would define it in positive terms instead of reverse "no-deep-sleep"
> though such as "atmel,fast-wakeup".
> 
> And: If you disable the regulators it will probably *not* be able to wake the
> system up, right? And that is just a few lines of code in the driver such as:
> 
> go_to_sleep():
>   if (!wakeup_source):
>      disable_regulators()

So to not change the default behaviour I would have to name it:
atmel,slow-wakeup
or maybe even full wakeup because it does a wakeup from the disabled
state?
atmel,full-wakeup

Exactly, the added code looks more or less exactly as you wrote. And on
resume it does the opposite + configure it:

resume():
  if (!wakeup_source):
     enable_regulators()
     configure_maxtouch()

Regards,
Stefan
