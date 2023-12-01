Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00718800622
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377892AbjLAIrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAIrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:47:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C8C4;
        Fri,  1 Dec 2023 00:47:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b27b498c3so19381965e9.0;
        Fri, 01 Dec 2023 00:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701420445; x=1702025245; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y5k3hp+Fps+KFaY2xy891TNAjRy9G6LGzZSmFk20j0I=;
        b=c7wK3F3y6AdvN+ox6sT3JMWx5xxt/M7lxTFCNoXDX7vH887AMfYs9UVmnRKaBzfDV7
         raAbFFdWh4ZJjRyVQfaL8Hv+AcqGlZvgYTkCXiH7ko61K9vf9M8OnYM+C4qjT6kfLQWe
         +p3THRKVUSHuAXkqsoNMQLoHhqB6gjTZEZ2DBqLlcwxEi3+Q2i86nB2bpvDWitiwg+6d
         +//D4hPfkkA3JB1+nTc9Zk1PtUfXKETcJGQn7l7Z4FEU1jka4bUNRcgsxfMdW1cuQG+/
         SVgw0w2pM/Z6m8rwNLGTDJLJustXggva3WxW9klGtpgroIwEjVKQuS/iBkBOxkWgdEj9
         p4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701420445; x=1702025245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5k3hp+Fps+KFaY2xy891TNAjRy9G6LGzZSmFk20j0I=;
        b=jXXtgPT1klV0WXXJj6Tqo7hh4vlR6enFaJW7nd/6Imr3deX0U79JK6pxun7TzrSIoK
         aUqGnJUSHAptwwAoeYVxE0621AFiNSGbcH+/Aq1mHugFl1y97mb9uMJZzmFFAepI6MAW
         ZQrLszyi0Ka8eClVSfET2gBAYObS95a44Ixv3HcPIekf7J2DFRh06YjJQhPLDIwOP2dn
         0NYD92oE1S8eUoWMHoyB+b3uMNPPe1KSKtU14qQ3xYIgJQDlbWBFUMp0t9qBocGYnQlJ
         owVX2hEC7uzFhGpzYYDeQuf8hpljM4u/0I02tmr4+paChgKlHadl+EUEqor6cG5OZvef
         eENw==
X-Gm-Message-State: AOJu0Yzr0F3TZWa95OA0K2sEF+4aXdJGrdXfGAgvcpqQ5U+5dTVJ1Y1y
        bG6sa/HE+KAhyn5T+aBk67rhFZRftfNda4eq
X-Google-Smtp-Source: AGHT+IFmXuOgohXVK84QCMKE/3yc6ZibYw+Ofbi/yAqp7du3fd6WZT7PuIGZsP4qN5OaNwgY5pAWPg==
X-Received: by 2002:a05:600c:178a:b0:40b:5e59:ccce with SMTP id x10-20020a05600c178a00b0040b5e59cccemr282792wmo.175.1701420445117;
        Fri, 01 Dec 2023 00:47:25 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm4625136wmb.6.2023.12.01.00.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:47:24 -0800 (PST)
Message-ID: <d534c3323c32d4ed2aedae19a9f101be90ef0cc7.camel@gmail.com>
Subject: Re: [PATCH 04/12] iio: adc: ad9467: fix reset gpio handling
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Fri, 01 Dec 2023 09:47:24 +0100
In-Reply-To: <CAMknhBGCqnzCp6vQ+59Z-SybScvbtU7aWdAD6KnP1e6=q60gVQ@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-4-6a3d542eba35@analog.com>
         <CAMknhBGCqnzCp6vQ+59Z-SybScvbtU7aWdAD6KnP1e6=q60gVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-30 at 15:41 -0600, David Lechner wrote:
> On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > The reset gpio was being requested with GPIOD_OUT_LOW which means, not
> > asserted. Then it was being asserted but never de-asserted which means
> > the devices was left in reset. Fix it by de-asserting the gpio.
>=20
> It could be helpful to update the devicetree bindings to state the
> expected active-high or active-low setting for this gpio so it is
> clear which state means asserted.
>=20

You could state that the chip is active low but I don't see that change tha=
t
important for now. Not sure if this is clear and maybe that's why your comm=
ent.
GPIOD_OUT_HIGH has nothing to do with active high or low. It just means, "g=
et me the
pin in the asserted state".

> > While at it, moved the handling to it's own function and dropped
> > 'reset_gpio' from the 'struct ad9467_state' as we only need it during
> > probe. On top of that, refactored things so that we now request the gpi=
o
> > asserted (i.e in reset) and then de-assert it.
> >=20
> > Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/adc/ad9467.c | 33 ++++++++++++++++++++-------------
> > =C2=A01 file changed, 20 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > index 39eccc28debe..368ea57be117 100644
> > --- a/drivers/iio/adc/ad9467.c
> > +++ b/drivers/iio/adc/ad9467.c
> > @@ -121,7 +121,6 @@ struct ad9467_state {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 output_mode;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_desc=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *pwrdown_gpio;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_desc=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 *reset_gpio;
> > =C2=A0};
> >=20
> > =C2=A0static int ad9467_spi_read(struct spi_device *spi, unsigned int r=
eg)
> > @@ -378,6 +377,23 @@ static int ad9467_preenable_setup(struct adi_axi_a=
dc_conv
> > *conv)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ad9467_outputmode_set=
(st->spi, st->output_mode);
> > =C2=A0}
> >=20
> > +static int ad9467_reset(struct device *dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_desc *gpio;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio =3D devm_gpiod_get_optional(=
dev, "reset", GPIOD_OUT_HIGH);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(gpio))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return PTR_ERR(gpio);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!gpio)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 0;
>=20
> can be done in one test instead of 2:
>=20
> if (IS_ERR_OR_NULL(gpio))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR_OR_ZERO(gpio);
>=20

Yep, better that way...

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsleep(1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpiod_direction_output(gpio, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsleep(10);
>=20
> Previous version was 10 milliseconds instead of 10 microseconds. Was
> this change intentional? If yes, it should be mentioned it in the
> commit message.

Oh, good catch! Copy past thing with even realizing the differences in the =
arguments
:face_palm:

- Nuno S=C3=A1


>=20
