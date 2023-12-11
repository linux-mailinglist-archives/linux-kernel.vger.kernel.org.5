Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BCB80C413
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjLKJNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjLKJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:13:17 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF105123
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:13:15 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ca2573d132so52166371fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702285994; x=1702890794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMuq41y0q5sJqso/AUvyl7ZAzaKQVaVlE4PNh5IKGB8=;
        b=XZBWTh9dUsNLObywd7mGcxjZ7x3APuo1IaI+HZV3I+o6UdM+akYvit6amayZCW0JD1
         RyPNiHO2jFlNH1EWuYNjYEYWhLEkJ3vtK11mPcA4iwpULU3K1+kPd0PmznjWfzfbySLK
         Sl06ceN1xBbA2Xzj2++HFtEu1Ouhp1Kf4XK0kmqgai6XtitLMX+j0tfY6lJ/6D+zSRmz
         /fT+Pc0OXYYwIRr+b0svIj+JtssZoSh349qxKD4FSr1ZmtkczYaE+3kTIT28HwlYiPRv
         BnyQakvbN0B2G6+xNfbXaB67rKQm6+6VZyPqxLw/KWjvIU5Nd8GBmjJIQcg+lpmpekif
         bltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285994; x=1702890794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMuq41y0q5sJqso/AUvyl7ZAzaKQVaVlE4PNh5IKGB8=;
        b=hEeeqaP1/n6jJq8WMoP7Pei6k7vv+wcyvx6XFLAcdoQ5KDwgGXpigX6aT7V8Z9KOIe
         sXYsxEdMky7js8I8/j2dbu9xulFFE9ZFl94Cqa6xEb0bmApS/Tdauu15/9TzvEhvqUdG
         uxNDlk5GjzrfNTZmzXt+fE8ggFc7MnsHC8BNnHBlsKmOZmYFqwbKcOxXDHQGqpuWhj+d
         ANNEKbV2H/DXaEW/cZ6skVF/NkabX4ueVYMw+iONYFzadLkWHXFV9haRu5NcvecEHIVD
         CGE9mi3dC9ehbYDJTOqzwGLJLbH3XaarJ6IdJppDjaf5vFb9d1mcJel67WzGcEPQnNhb
         gclw==
X-Gm-Message-State: AOJu0YyD+xOThb/4Ao0eoS0zYwB7cWn8jch9JLyGqU8qWnSXJCXj0f1K
        tEi+8Wz+kW99itFboPHOKNuecEDEauSnEvl4aOzLyA==
X-Google-Smtp-Source: AGHT+IHB3c+HElrh1wEsgL0DN7SQaXufcgIjPdqncwltsjOSP9zDhyNRpPscij1xxvoK1/39kMXk/tTF2TS4wzKhROI=
X-Received: by 2002:a2e:a417:0:b0:2ca:3591:6667 with SMTP id
 p23-20020a2ea417000000b002ca35916667mr1391946ljn.82.1702285993598; Mon, 11
 Dec 2023 01:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
 <20231208-ad7380-mainline-v1-1-2b33fe2f44ae@baylibre.com> <20231210134932.0bb429f1@jic23-huawei>
In-Reply-To: <20231210134932.0bb429f1@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Mon, 11 Dec 2023 10:13:02 +0100
Message-ID: <CAMknhBFh+tMOjo86-_C2a8=Tp+=NgGEPDg9CZTsngrHeoXt1Fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding for AD7380 ADCs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 2:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri,  8 Dec 2023 09:51:40 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
> > This adds a binding specification for the Analog Devices Inc. AD7380
> > family of ADCs.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> Hi David,
>
> Comments inline.  A question for Mark Brown on the 2-wire bit..
> Do we have existing DT bindings for devices with parallel spi data
> outputs?
>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 102 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   9 ++
> >  2 files changed, 111 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > new file mode 100644
> > index 000000000000..e9a0b72cd9d3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> ...
>
>
> > +  * https://www.analog.com/en/products/ad7380.html
> > +  * https://www.analog.com/en/products/ad7381.html
> > +  * https://www.analog.com/en/products/ad7383.html
> > +  * https://www.analog.com/en/products/ad7384.html
>
> > +  adi,sdo-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ 1-wire, 2-wire ]
> > +    description:
> > +      In 1-wire mode, the SDOA pin acts as the sole data line and the =
SDOB/ALERT
> > +      pin acts as the ALERT interrupt signal. In 2-wire mode, data for=
 input A
> > +      is read from SDOA and data for input B is read from SDOB/ALERT (=
and the
> > +      ALERT interrupt signal is not available).
>
> This is fun...  If I understand correctly 2-wire requires two SPI buses (=
or a complex
> spi controller that does parallel serial channels).

No, it wouldn't work with two separate SPI busses. Only a special
controller with parallel serial channels.

> What would description for that
> look like in DT and can we not establish what is wanted here from that bu=
s description
> rather than an adi specific property?
>
> Seems a bit like parallel-memories.

I don't think this is the same as parallel-memories. Looking at the
the patch [1] it looks like parallel memories requires multiple CS
lines to connect to multiple chips to make the multiple chips behave
as one chip but otherwise works like SPI_RX_DUAL.

This ADC, on the other hand, works as if two chips that share
everything except the MISO line. Each MISO line (SDOA and SDOB) shifts
out one bit of two different words in parallel on each line instead of
two bits of the same word like SPI_RX_DUAL busses.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit=
/?h=3Dfor-6.8&id=3D88a50c1663ffa9f6b31705c6bf7a887a2c8d9434

>
> Mark, any insights into what we should do to describe this?
>
> > +
> > +  vcc-supply:
> > +    description: A 3V to 3.6V supply that powers the chip.
> > +
> > +  vlogic-supply:
> > +    description:
> > +      A 1.65V to 3.6V supply for the logic pins.
> > +
> > +  refio-supply:
> > +    description:
> > +      A 2.5V to 3.3V supply for the external reference voltage. When o=
mitted,
> > +      the internal 2.5V reference is used.
> > +
> > +  interrupts:
> > +    description:
> > +      When the device is using 1-wire mode, this property is used to o=
ptionally
> > +      specify the ALERT interrupt.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - adi,sdo-mode
>
> Could define a default of 1-wire?  Simplifies things a little in the bind=
ings.
>
> > +  - vcc-supply
> > +  - vlogic-supply
>
>
