Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03357B4354
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 21:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjI3TjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 15:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3TjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 15:39:06 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470B6C6;
        Sat, 30 Sep 2023 12:39:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c131ddfc95so234756591fa.0;
        Sat, 30 Sep 2023 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696102741; x=1696707541; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RpWaFzgkKm2rvTL1s71ooDabFhXZwOwJjSveMi3MRwQ=;
        b=QNX4InvSaCpegpS/wZSQoGd6rF7t6lv8KBxWu7D3RXoMjYK+5C/V3VzSrGyVMiuUtI
         nWlLShVWWnM7miWfUNPUbfOktpuhODT/stQ+9OE2AzvvT554IV0mwJl0uD7hyaEf3a1Q
         bie6xbUx39wL3SbflPd3nAFEVjMc0Ei7WjkDzgdE1zMdkh8Ekvbpx6ThnEwZkG45TCun
         FM9JBmCWE5kZExbJLY1M8nmYV2BkwEZ9kcsYjjfo23oLkAFEaP1RHPFAiHC9BTNlVbFN
         qZwaJ5cqVnqnAnXpMe9stQYHd3aqPKIt+khJCqDollFpQv6E4/htAJ1r/x+3OpyM1HWo
         6QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696102741; x=1696707541;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpWaFzgkKm2rvTL1s71ooDabFhXZwOwJjSveMi3MRwQ=;
        b=VcqQkuy0u5Mxs5NkfjiAY/31e9cijEUe0DUVdo+ElPKE1+yK1cAFtwupaZFaXrUREe
         2hCNLbI3bUp/XXgAV+UOwvJYW+yA+6XQVnb1q8gqNQkLmTCmO52VRevybNWs1L5lxPeb
         D/3w8LCeSMCcFQeT/qixa+9DQ6WuJrJuisokKekoMIbV9brHbhdeNvMkjpjka/xxY0UF
         8rJ37uTSw+2ixTax5uisvRZhQYDP8vGYSWXpXrcEnyqpKBxRUvyBdtJ3HDHNqOWuV5hI
         sNyde3QDu9ToTv9ywdw9ncDSTlX8aWT8i9oLgFHCZf71eayhFvw5KJhk0Mefi2TZEMWh
         aRbw==
X-Gm-Message-State: AOJu0YxE9yutPkbhCqV0B4tVM773XFGFVDUZPnLXIyddTR6jomWcF4R9
        AVsw7AiYm/3SK+04zEI9+BM=
X-Google-Smtp-Source: AGHT+IFrEyRrZpzJAwEpurrhffi5P5MXv7kPXIml3FzyBKf3JqRmt1wRZAZY+7+GPWKdrQeXADDvEQ==
X-Received: by 2002:a19:790c:0:b0:500:8fcd:c3b5 with SMTP id u12-20020a19790c000000b005008fcdc3b5mr5400583lfc.12.1696102741074;
        Sat, 30 Sep 2023 12:39:01 -0700 (PDT)
Received: from [192.168.1.161] ([46.31.31.132])
        by smtp.gmail.com with ESMTPSA id k2-20020ac24562000000b004fe2a7a2ee2sm3998853lfm.160.2023.09.30.12.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 12:39:00 -0700 (PDT)
Message-ID: <591e8c9a4018938df17cdfb55306813858904d9d.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Sat, 30 Sep 2023 22:38:58 +0300
In-Reply-To: <20230930-lusty-antihero-f381434ab682@spud>
References: <20230929200844.23316-1-fr0st61te@gmail.com>
         <20230929200844.23316-2-fr0st61te@gmail.com>
         <20230930-lusty-antihero-f381434ab682@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-09-30 at 10:37 +0100, Conor Dooley wrote:
> Hey,
>=20
> On Fri, Sep 29, 2023 at 11:08:43PM +0300, Ivan Mikhaylov wrote:
> > The hardware binding for i2c current monitoring device with
> > overcurrent
> > control.
> >=20
> > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> > ---
> > =C2=A0.../bindings/iio/adc/maxim,max34408.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 101
> > ++++++++++++++++++
> > =C2=A01 file changed, 101 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > new file mode 100644
> > index 000000000000..cdf89fa4c80e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Two- and four-channel current monitors with overcurrent
> > control
> > +
> > +maintainers:
> > +=C2=A0 - Ivan Mikhaylov <fr0st61te@gmail.com>
> > +
> > +description: |
> > +=C2=A0 The MAX34408/MAX34409 are two- and four-channel current monitor=
s
> > that are
> > +=C2=A0 configured and monitored with a standard I2C/SMBus serial
> > interface. Each
> > +=C2=A0 unidirectional current sensor offers precision high-side
> > operation with a
> > +=C2=A0 low full-scale sense voltage. The devices automatically sequenc=
e
> > through
> > +=C2=A0 two or four channels and collect the current-sense samples and
> > average them
> > +=C2=A0 to reduce the effect of impulse noise. The raw ADC samples are
> > compared to
> > +=C2=A0 user-programmable digital thresholds to indicate overcurrent
> > conditions.
> > +=C2=A0 Overcurrent conditions trigger a hardware output to provide an
> > immediate
> > +=C2=A0 indication to shut down any necessary external circuitry.
> > +
> > +=C2=A0 Specifications about the devices can be found at:
> > +=C2=A0
> > https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
34408-MAX34409.pdf
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max34408
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max34409
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 maxim,input1-rsense-val-micro-ohms:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Adjust the Rsense value to monitor high=
er or lower current
> > levels for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input 1.
> > +=C2=A0=C2=A0=C2=A0 enum: [250, 500, 1000, 5000, 10000, 50000, 100000, =
200000,
> > 500000]
> > +=C2=A0=C2=A0=C2=A0 default: 1000
> > +
> > +=C2=A0 maxim,input2-rsense-val-micro-ohms:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Adjust the Rsense value to monitor high=
er or lower current
> > levels for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input 2.
> > +=C2=A0=C2=A0=C2=A0 enum: [250, 500, 1000, 5000, 10000, 50000, 100000, =
200000,
> > 500000]
> > +=C2=A0=C2=A0=C2=A0 default: 1000
> > +
> > +=C2=A0 maxim,input3-rsense-val-micro-ohms:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Adjust the Rsense value to monitor high=
er or lower current
> > levels for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input 3.
> > +=C2=A0=C2=A0=C2=A0 enum: [250, 500, 1000, 5000, 10000, 50000, 100000, =
200000,
> > 500000]
> > +=C2=A0=C2=A0=C2=A0 default: 1000
> > +
> > +=C2=A0 maxim,input4-rsense-val-micro-ohms:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Adjust the Rsense value to monitor high=
er or lower current
> > levels for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input 4.
> > +=C2=A0=C2=A0=C2=A0 enum: [250, 500, 1000, 5000, 10000, 50000, 100000, =
200000,
> > 500000]
> > +=C2=A0=C2=A0=C2=A0 default: 1000
>=20
> Having 4 almost identical properties makes it seem like this should
> have
> some channel nodes, each containing an rsense-micro-ohms type
> property.

Conor, I'll look through.

>=20
> > +
> > +=C2=A0 maxim,shtdn:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Shutdown Output. Open-drain output. Thi=
s output transitions
> > to high impedance
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when any of the digital comparator thre=
sholds are exceeded
> > as long as the ENA
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pin is high.
> > +=C2=A0=C2=A0=C2=A0 type: boolean
>=20
> I don't understand what this property is used for. The description
> here,
> and below for "ena", read like they are the descriptions in the
> datasheet for the pin, rather than how to use the property.
>=20
> The drivers don't appear to contain users either - what is the point
> of
> these properties?

ena and shtdn physical pins of hardware, in the previous version
Jonathan asked about adding them into yaml even if it's not used in
code. should I do it in some other way?

>=20
> > +
> > +=C2=A0 maxim,ena:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SHTDN Enable Input. CMOS digital input.=
 Connect to GND to
> > clear the latch and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unconditionally deassert (force low) th=
e SHTDN output and
> > reset the shutdown
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delay. Connect to VDD to enable normal =
latch operation of
> > the SHTDN output.
> > +=C2=A0=C2=A0=C2=A0 type: boolean
> > +
> > +=C2=A0 supply-vdd: true
>=20
> As pointed out by the bot, this is not correct. You need to use a
> -supply affix, not a supply-prefix.

Oops.

Thanks.

