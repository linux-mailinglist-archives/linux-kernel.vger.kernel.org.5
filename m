Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B832F80A55A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573939AbjLHOYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573915AbjLHOYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:24:01 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAA5173B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:24:06 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d74186170fso18381947b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 06:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702045446; x=1702650246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WcPHH8hCzuApfJI8+uPOYiQNMztI2zWo5AZvPnBwtk=;
        b=ZpzaXwVFZEGdX3pPLDMlY7htBuW9a/14C7bGcOtm/1dLEYxVq9Iz8KFvfB3P4QF/c+
         HptqCjyEh+O3zdsUhFGARTXYeI3T//N6at0jUNeCkGFLqeGMDWfe0y+o+xsgUPTGzWhe
         klmEwlH31EsEasteE0EZaAhFmssKJNPc5Q8Iec5kto7W5vSoY7aCv/kZskR+epP4TXsc
         a8Yroi8OWnOgz0Kg1gvisg0WDAxyEEGw3jKcdIWODQrFaNtqw+DWuLDaleC2TcQm8My7
         +tw1AXpuQUVFcns0XiwD+fwEoCLNWRBBeQeZ8J4f606GEIDnshrvdP6S3CtWg+AUsuBI
         i7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045446; x=1702650246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WcPHH8hCzuApfJI8+uPOYiQNMztI2zWo5AZvPnBwtk=;
        b=rJrOGRPmCmQ/KQTVeE2yPNt7ECS5Ef5AzEO4sNqoINXpnlc4XNnsA7s2ykmpllsLVh
         bro7G6kndASjY/5NCoe3BKqQgUqC9Pr0oeNu0Zn+578tK00LXnEYj6c9xrP2XXZCBrZB
         Sq3enErcC2JpbmUjezK20Z14R+cgTkBKtsIrXHAZzis4NC1raXosMihyGgzJ4lZMywAl
         Rk+byoik8n2jA4yEzKT15S0hv2o5uJVYi5ZO2KRmwuYb3gDwoiacJu9r+Kf2dc6ko73P
         l1NPEGYq9wj4yaRWvUdR1mVaHBpZXeC+E5z6KeTQoHyJZJlKDsyhfB09koTdqYOeUD4o
         geHw==
X-Gm-Message-State: AOJu0YyXfGwaG2sp8t4Nvi2rc5h5LHgZVD6KHMArCQWvxiKT7iPvsP0Z
        1ZsU9YyWDIuMbDVuPIRznOPOWes25fjKIfk2Rqs4fw==
X-Google-Smtp-Source: AGHT+IGadGjgU7n/ytBaR8av490goiNnuPW2kEarmWtfhU396Hor6OBA7126/eHuod0bo/NL4glLCtjBv99/zsck2B0=
X-Received: by 2002:a81:7286:0:b0:5d7:1940:7d90 with SMTP id
 n128-20020a817286000000b005d719407d90mr2135ywc.103.1702045446059; Fri, 08 Dec
 2023 06:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20231207111300.80581-1-eichest@gmail.com> <20231207111300.80581-2-eichest@gmail.com>
 <CACRpkdbSs-vebvchxx-Tg+O5CUF5M3vZf-iytuW=ZECnHb2anA@mail.gmail.com> <ZXMV9gzFbc05IEKg@eichest-laptop>
In-Reply-To: <ZXMV9gzFbc05IEKg@eichest-laptop>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Dec 2023 15:23:54 +0100
Message-ID: <CACRpkdao83-nALj2YOq-XHrOh6GEaxufN3Fn+3W52qkL2x+VUQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: atmel,maxtouch: add
 poweroff-in-suspend property
To:     Stefan Eichenberger <eichest@gmail.com>
Cc:     nick@shmanahar.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 2:11=E2=80=AFPM Stefan Eichenberger <eichest@gmail.c=
om> wrote:

> > I can't help but wonder: shouldn't that pretty much be the default beha=
viour
> > if wakeup-source is *not* specified?
> >
> > I.e. the property kind of describes !wakeup-source.
>
> The maxtouch controller has a deep sleep mode which is currently used
> without powering down vdd and vdda. However, because we have a shared
> regulator which powers other peripherals that we want to shut down in
> suspend we need a way to power down vdd and vdda. However, I agree this
> is not really a feature of the device. The feature would basically be
> the internal deep sleep mode.

While it is of no concern to the device tree bindings, Linux regulators
are counting meaning that you need to make all peripherals disable
their regulators and it will come down.

> I didn't want to change the default
> behaviour of the driver, so I added this property but maybe I could
> change it to:
>
> atmel,deep-sleep:
>   description: |
>      Use the maxtouch deep-sleep mode instead of powering down vdd and
>      vdda.
>
> Or to not change the default behaviour:
> atmel,no-deep-sleep:
>   description: |
>      Do not use the maxtouch deep-sleep mode but power down vdd and vdda
>      in suspend.
>
> As I understand the datasheet even if the maxtouch is using its deep
> sleep mode it does not act as a wakeup source.

Do you mean it can still work as a wakeup source in deep sleep mode?
(there is a "not" too much above ...)

> It is just faster in
> waking up because it can keep the configuration in memory.

That sounds like a good reason to have the property, because that
means that if you can control the wakeup latency and specify in the binding
how much in absolute time units it is affected.

I would define it in positive terms instead of reverse "no-deep-sleep"
though such as "atmel,fast-wakeup".

And: If you disable the regulators it will probably *not* be able to wake t=
he
system up, right? And that is just a few lines of code in the driver such a=
s:

go_to_sleep():
  if (!wakeup_source):
     disable_regulators()

Yours,
Linus Walleij
