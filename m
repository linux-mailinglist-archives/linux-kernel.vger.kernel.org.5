Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675D280068E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377991AbjLAJIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377963AbjLAJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:08:23 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B392B10A;
        Fri,  1 Dec 2023 01:08:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40838915cecso17849615e9.2;
        Fri, 01 Dec 2023 01:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701421708; x=1702026508; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXaat6u7HqTCL3YCj9gZaULpbtExAYlDtK53HWJEcEU=;
        b=Zi4dt4ZPW0pXfod1xXqVLRY+t5VovQUrTZ2i2KZQzu25Lab1chYc/yHKjJP5hkd2wi
         9Hbh8ydZ4a2/jkICobz10SHEhjj90vtflHNa4mPE5VDyC0u2S26ShvEG6wnevfxvoeG9
         KVSiC1cTFK5ufO07wKjETaDFJK01tz+4WVU4O7p0EkzdSCjGMUIWvbeUOYgPlRCuqm53
         /o6bUbyH4RbMjv2F7qHl09vWtmDpFc2GwCzbT8yIERGlhnjgLynuKzvPOX51GHioEVLz
         rrT3yRX/y6WWGMXB7CEQJHdOKQ3okfQJmcJ0BhAq5H5jnbsgfE1AJ+JTxro6I+j2BYvg
         6CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421708; x=1702026508;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXaat6u7HqTCL3YCj9gZaULpbtExAYlDtK53HWJEcEU=;
        b=DPLR2DgRsikXaAkOWDt9ne4FAuNIY+0rlv9s3QwjnWNP1dhYiTYJgKWQ0vZbUCNLz+
         0ZCpH5pW0JxM2csC9NCsdMCdwcQy5Kv3zekZFPuHWyARE3P78tlSBi9iuMX0VRWzBpJ8
         4pfbMdrguyOBj3AXjdSI1uEL1An1Hd5pWUEwpEqcTM+j1xA47s5GMgWMV6WVJ1cMZhbu
         Zn42sJVYQCuESyCsgSkhSaloZtza8rIQ0H58angsG+sHLrPeMC9KKtOELiJbR8IqRzEw
         f4XdPAY/W+6QFXT9GJznOhdRqzdBFaymNv8zCcKyoIC2PyAaEOmNWc+47CpLVGiTxvCZ
         WtkA==
X-Gm-Message-State: AOJu0Yyq7fUaHERUNOnZVAhTgY5Bst9z/cemXuYu0I2v4MwbQoeSWemd
        JnvAhOiquLtVcUwn3TcBsLA=
X-Google-Smtp-Source: AGHT+IGs/teHV3fLEHd8FjhzDpS54MQR1bptuGI+ZzVWc/3464j6pE+OhUqJE2KrBAB21bSwxPG4AA==
X-Received: by 2002:a5d:674a:0:b0:333:2fd2:68bf with SMTP id l10-20020a5d674a000000b003332fd268bfmr598133wrw.82.1701421707983;
        Fri, 01 Dec 2023 01:08:27 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id v10-20020adfe4ca000000b00332f95ab451sm3624753wrm.58.2023.12.01.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:08:27 -0800 (PST)
Message-ID: <026fa80d29054750937cd077b7f4f689de4e18f2.camel@gmail.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
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
Date:   Fri, 01 Dec 2023 10:08:27 +0100
In-Reply-To: <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
         <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
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

On Thu, 2023-11-30 at 17:30 -0600, David Lechner wrote:
> On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Convert the driver to use the new IIO backend framework. The device
> > functionality is expected to be the same (meaning no added or removed
> > features).
>=20
> Missing a devicetree bindings patch before this one?
>=20
> >=20
> > Also note this patch effectively breaks ABI and that's needed so we can
> > properly support this device and add needed features making use of the
> > new IIO framework.
>=20
> Can you be more specific about what is actually breaking?
>=20
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 2 +-
> > =C2=A0drivers/iio/adc/ad9467.c | 256 +++++++++++++++++++++++++++++-----=
-------------
> > =C2=A02 files changed, 157 insertions(+), 101 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 1e2b7a2c67c6..af56df63beff 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -275,7 +275,7 @@ config AD799X
> > =C2=A0config AD9467
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Analog Devices AD9=
467 High Speed ADC driver"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ADI_AXI_ADC
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BACKEND
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say yes here to =
build support for Analog Devices:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * AD9467 16-Bit,=
 200 MSPS/250 MSPS Analog-to-Digital Converter
> > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > index 5db5690ccee8..8b0402e73ace 100644
> > --- a/drivers/iio/adc/ad9467.c
> > +++ b/drivers/iio/adc/ad9467.c
>=20
> <snip>
>=20
> > +static int ad9467_buffer_get(struct iio_dev *indio_dev)
>=20
> perhaps a more descriptive name: ad9467_buffer_setup_optional?
>=20

Hmm, no strong feeling. So yeah, can do as you suggest. Even though, now th=
at I'm
thinking, I'm not so sure if this is just some legacy thing we had in ADI t=
ree. I
wonder if it actually makes sense for a device like with no buffering suppo=
rt?!
=20
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D indio_dev-=
>dev.parent;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *dma_name;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!device_property_present(dev,=
 "dmas"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (device_property_read_string(d=
ev, "dma-names", &dma_name))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dma_name =3D "rx";
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_dmaengine_buffer_=
setup(dev, indio_dev, dma_name);
>=20
> The device tree bindings for "adi,ad9467" don't include dma properties
> (nor should they). Perhaps the DMA lookup should be a callback to the
> backend? Or something similar to the SPI Engine offload that we are
> working on?
>=20

Oh yes, I need to update the bindings. In the link I sent you we can see my=
 thoughts
on this. In theory, hardwarewise, it would actually make sense for the DMA =
to be on
the backend device because that's where the connection is in HW. However, s=
ince we
want to have the IIO interface in the frontend, it would be hard to do that=
 without
hacking devm_iio_dmaengine_buffer_setup().=C2=A0I mean, lifetime wise it wo=
uld be far from
wise to have the DMA buffer associated to a completely different device tha=
n the IIO
parent device. I mean, one way could just be export iio_dmaengine_buffer_fr=
ee() and
iio_dmaengine_buffer_alloc() so we can actually control the lifetime of the=
 buffer
from the frontend device. If Jonathan is fine with this, I'm on board for i=
t....

- Nuno S=C3=A1
>=20

