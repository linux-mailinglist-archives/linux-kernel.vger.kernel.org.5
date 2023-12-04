Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC0803A16
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbjLDQXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:23:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB1B95;
        Mon,  4 Dec 2023 08:23:15 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b397793aaso28943725e9.0;
        Mon, 04 Dec 2023 08:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701706994; x=1702311794; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lZvEefAqVfhhrAqkGJeJBdp4Dkv2bcOw6KGxNpxoDPc=;
        b=jUuf24wS2iJOqUj8uV3RXyyfv7CB3IhOgzupW4+5M+APQ1zJ/sD3eqAlpKczcwAZcr
         bCfwseZ6tG0XNQxkoZ3lvmFffTjI/HYyi2Tz6QFmgjGaGMMTOWh8Y6A3aWRAF0aHshNu
         rPHrf/fZEf9WN7Ml3dAYnVfrtGFeyDXg1tKRBQqhC3KnvVq+wpxOT+byAIiyUWa1reTb
         QkT29jzSOcrSn0cftljX2kah5ivZdOwSQQTWYJ0liolTJ+fu/N3p3TlnwFWpIufKtYlT
         GddrvIR2NMmVJR3woadrYMtKx+Jm7eTNM9+smAq+MvFSfxUh2qr+XfD/KJhJgbRRWUYz
         e5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706994; x=1702311794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZvEefAqVfhhrAqkGJeJBdp4Dkv2bcOw6KGxNpxoDPc=;
        b=dOnZYBHW7GBzDxYdt8bA2C2hpxJDoFQNslVcBRSqxHBR9/Rv7WSt5oFVguR6HdT61g
         RS6RKnw8eKvCiWN0vvsKrspUExhGuJ56XXMzXX105EKz24pH3lEZM20QMLvf3DMwPyXd
         gEZfsRUaymO8cjPIGhJvkXZhSENkDf/DjS+ldekK/uWL5mFMo7OmR0116uYS0m9E3KXh
         mlv82XwaWrQrYdN2zTkM9pSqN2Dul6YoLffqMOgjZZBNzg7RwotV2wJRHaoxZ9rX6mm4
         4okXhN588yGpkAtMFaSUU6jdMEsdfmHVXn1OsKB9JMGLFuCXTKuF/8tWhbu0jmCFXyvF
         IPaw==
X-Gm-Message-State: AOJu0YwneiO30oCJbt4MyTu4I1nG1yPQukdtad4jCN/RK+QnywgarNw1
        IoxeJiMZCT5+sSYdPYQ8ZaM=
X-Google-Smtp-Source: AGHT+IGISfZjrlp519tbNbKXoL9TuXD4P3p9b2cyKLd9JZ08JwPaKfse/EmiCtZt4A38p4Qi3xQUBQ==
X-Received: by 2002:a05:600c:1f16:b0:40b:5e56:7b6c with SMTP id bd22-20020a05600c1f1600b0040b5e567b6cmr3198093wmb.181.1701706993685;
        Mon, 04 Dec 2023 08:23:13 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b0040b3515cdf8sm15571997wms.7.2023.12.04.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:23:13 -0800 (PST)
Message-ID: <f0a65ba32a6e988ec5f99a3a02ab5414f28ff106.camel@gmail.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Mon, 04 Dec 2023 17:23:12 +0100
In-Reply-To: <20231204154810.3f2f3f83@jic23-huawei>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
         <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
         <026fa80d29054750937cd077b7f4f689de4e18f2.camel@gmail.com>
         <20231204154810.3f2f3f83@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-12-04 at 15:48 +0000, Jonathan Cameron wrote:
> On Fri, 01 Dec 2023 10:08:27 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2023-11-30 at 17:30 -0600, David Lechner wrote:
> > > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > > <devnull+nuno.sa.analog.com@kernel.org> wrote:=C2=A0=20
> > > >=20
> > > > From: Nuno Sa <nuno.sa@analog.com>
> > > >=20
> > > > Convert the driver to use the new IIO backend framework. The device
> > > > functionality is expected to be the same (meaning no added or remov=
ed
> > > > features).=C2=A0=20
> > >=20
> > > Missing a devicetree bindings patch before this one?
> > > =C2=A0=20
> > > >=20
> > > > Also note this patch effectively breaks ABI and that's needed so we=
 can
> > > > properly support this device and add needed features making use of =
the
> > > > new IIO framework.=C2=A0=20
> > >=20
> > > Can you be more specific about what is actually breaking?
> > > =C2=A0=20
> > > >=20
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 2 +-
> > > > =C2=A0drivers/iio/adc/ad9467.c | 256 +++++++++++++++++++++++++++++-=
---------------
> > > > --
> > > > =C2=A02 files changed, 157 insertions(+), 101 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > > index 1e2b7a2c67c6..af56df63beff 100644
> > > > --- a/drivers/iio/adc/Kconfig
> > > > +++ b/drivers/iio/adc/Kconfig
> > > > @@ -275,7 +275,7 @@ config AD799X
> > > > =C2=A0config AD9467
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Analog Devices=
 AD9467 High Speed ADC driver"
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ADI_AXI_ADC
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BACKEND
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say yes here=
 to build support for Analog Devices:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * AD9467 16-=
Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
> > > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > > index 5db5690ccee8..8b0402e73ace 100644
> > > > --- a/drivers/iio/adc/ad9467.c
> > > > +++ b/drivers/iio/adc/ad9467.c=C2=A0=20
> > >=20
> > > <snip>
> > > =C2=A0=20
> > > > +static int ad9467_buffer_get(struct iio_dev *indio_dev)=C2=A0=20
> > >=20
> > > perhaps a more descriptive name: ad9467_buffer_setup_optional?
> > > =C2=A0=20
> >=20
> > Hmm, no strong feeling. So yeah, can do as you suggest. Even though, no=
w that I'm
> > thinking, I'm not so sure if this is just some legacy thing we had in A=
DI tree. I
> > wonder if it actually makes sense for a device like with no buffering s=
upport?!
> > =C2=A0
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D indio_=
dev->dev.parent;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *dma_name;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!device_property_present(=
dev, "dmas"))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (device_property_read_stri=
ng(dev, "dma-names", &dma_name))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dma_name =3D "rx";
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_dmaengine_buf=
fer_setup(dev, indio_dev, dma_name);=C2=A0=20
> > >=20
> > > The device tree bindings for "adi,ad9467" don't include dma propertie=
s
> > > (nor should they). Perhaps the DMA lookup should be a callback to the
> > > backend? Or something similar to the SPI Engine offload that we are
> > > working on?
> > > =C2=A0=20
> >=20
> > Oh yes, I need to update the bindings. In the link I sent you we can se=
e my
> > thoughts
> > on this. In theory, hardwarewise, it would actually make sense for the =
DMA to be
> > on
> > the backend device because that's where the connection is in HW. Howeve=
r, since
> > we
> > want to have the IIO interface in the frontend, it would be hard to do =
that
> > without
> > hacking devm_iio_dmaengine_buffer_setup().=C2=A0I mean, lifetime wise i=
t would be far
> > from
> > wise to have the DMA buffer associated to a completely different device=
 than the
> > IIO
> > parent device. I mean, one way could just be export iio_dmaengine_buffe=
r_free()
> > and
> > iio_dmaengine_buffer_alloc() so we can actually control the lifetime of=
 the
> > buffer
> > from the frontend device. If Jonathan is fine with this, I'm on board f=
or it....
>=20
> It is going to be fiddly but I'd kind of expect the front end to be using=
 a more
> abstracted interface to tell the backend to start grabbing data.=C2=A0 Ma=
ybe that ends
> up being so slim it's just these interfaces and it's not sensible to wrap=
 it
> though.
>=20

Likely I'm missing your point but the discussion here is where the DMA buff=
er should
be allocated. In theory, in the backend (at least on ADI usecases - it's th=
e proper
representation of the HW) but as we have the iio device in the frontend, it=
's more
appropriate to have the buffer there. Or at least to have a way to control =
the buffer
lifetime from there...

On the our usecases, it's not like we tell the backend to grab data, we jus=
t use the
normal .update_scan_mode() to enable/disable the channels in the backend so=
 when we
enable the buffer (and the frontend starts receiving and sending data via t=
he serial
interface) the data paths are enabaled/disabled accordingly. Bah, yeah, in =
a way is
another wording for "grab" or "grab not" :)

- Nuno S=C3=A1
