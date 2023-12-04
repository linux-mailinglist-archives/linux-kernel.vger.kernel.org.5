Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CD8802DF8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjLDI4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjLDI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:56:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232FE101;
        Mon,  4 Dec 2023 00:56:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40838915cecso42811805e9.2;
        Mon, 04 Dec 2023 00:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701680201; x=1702285001; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Of7anv7twHrm1GM3ZZhVMaGN+HHiOJ/eAtPCQmGTSs0=;
        b=Iy5hv7eallZTRdH46F5fYyzddJi4DoXAMu/OIimPycQsSxlObzDawdwWNcw9jqRPjS
         fvET0vsDGGCpznl/QwKWsCNcdookUNF9RcRpyeg8mYXaBsVN2jsCeWulbR6qlD1AMYhu
         BKJV4Aso1Az5x4O48yddUojVJDnlupsC5zCFScpVvlj5n8HRVgCfCgE2L7PrU9x3fwrh
         dGc3H6vdcAQLNPIwxzyzARr53zOCIo+JZCkG/HZ1yyL9QrvBrLqw6qFbvGD/NzEoTD/i
         zihV/T8dQiDyh0n+XSKsZpAFqJKmdoL6cssbnd2Rrxayaa7fsPmdeEdqFgoSDCQo+OsH
         ilKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701680201; x=1702285001;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Of7anv7twHrm1GM3ZZhVMaGN+HHiOJ/eAtPCQmGTSs0=;
        b=Ab96FsTxn7TrfQT0BN0ccAa/rDC1QTqGIXz3XE2eknPTgMMvtw964sVGejoZbM5KVz
         DCBUK5jq88mlZuby7w67tuYLbXX9Ya5GTfaIfEadAfdIBkmMbNTIw97c/ArKHBaaa+Mw
         XAj/1hi38dRtCFAzYnaqaMdmlGELmORO4Ibwn598QsB6BPTUtGszM+QVbvaxsh2CosuC
         FMjevTeoZnwwJ7ChIW018o2E2Uqyui/ptNdZd+p7EgvCS6+PZG/JUetFdCxf6JZ4AY4m
         p00kDnd+Wi7w5tn8KXUhpieAqncFNRZS5d9D95R82MmApEcic8HpSgJeImsLrl9Tq2BE
         gu3A==
X-Gm-Message-State: AOJu0Ywp+1itkcFa5ltgNLxAi3DI0ArVYPQzvqzp/zO2uFL+KzCqX6Xm
        cvD6SGRcofQUE1D1kc72lEg=
X-Google-Smtp-Source: AGHT+IH104Kfc26vBVXIOBFr05Rw0BdMZYUoKpw8Kvl5Igdx7+N3fC51XzESQVN54zvANJYQ7L8QKg==
X-Received: by 2002:a05:600c:450d:b0:409:5a92:4718 with SMTP id t13-20020a05600c450d00b004095a924718mr1840488wmo.36.1701680201175;
        Mon, 04 Dec 2023 00:56:41 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d6992000000b003333abf3edfsm5786866wru.47.2023.12.04.00.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:56:40 -0800 (PST)
Message-ID: <a8ef2e4ee00eae38d16baad8e124a68c069dd2e3.camel@gmail.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>
Cc:     nuno.sa@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Mon, 04 Dec 2023 09:56:40 +0100
In-Reply-To: <863114fa44cda4ca58e17a47191f0388df39cc80.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
         <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
         <026fa80d29054750937cd077b7f4f689de4e18f2.camel@gmail.com>
         <CAMknhBGKinZB==QHLazZ9ZkfALyj2N=rVfZfsOk22p6X9SZSrQ@mail.gmail.com>
         <863114fa44cda4ca58e17a47191f0388df39cc80.camel@gmail.com>
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

On Sat, 2023-12-02 at 09:46 +0100, Nuno S=C3=A1 wrote:
> On Fri, 2023-12-01 at 11:44 -0600, David Lechner wrote:
> > On Fri, Dec 1, 2023 at 3:08=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> > >=20
> > > On Thu, 2023-11-30 at 17:30 -0600, David Lechner wrote:
> > > > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > >=20
> > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > >=20
> > > > > Convert the driver to use the new IIO backend framework. The devi=
ce
> > > > > functionality is expected to be the same (meaning no added or rem=
oved
> > > > > features).
> > > >=20
> > > > Missing a devicetree bindings patch before this one?
> > > >=20
> > > > >=20
> > > > > Also note this patch effectively breaks ABI and that's needed so =
we can
> > > > > properly support this device and add needed features making use o=
f the
> > > > > new IIO framework.
> > > >=20
> > > > Can you be more specific about what is actually breaking?
> > > >=20
> > > > >=20
> > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > ---
> > > > > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 2 +-
> > > > > =C2=A0drivers/iio/adc/ad9467.c | 256 ++++++++++++++++++++++++++++=
+--------------
> > > > > --
> > > > > --
> > > > > =C2=A02 files changed, 157 insertions(+), 101 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > > > index 1e2b7a2c67c6..af56df63beff 100644
> > > > > --- a/drivers/iio/adc/Kconfig
> > > > > +++ b/drivers/iio/adc/Kconfig
> > > > > @@ -275,7 +275,7 @@ config AD799X
> > > > > =C2=A0config AD9467
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Analog Devic=
es AD9467 High Speed ADC driver"
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ADI_AXI_ADC
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BACKEND
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say yes he=
re to build support for Analog Devices:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * AD9467 1=
6-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
> > > > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > > > index 5db5690ccee8..8b0402e73ace 100644
> > > > > --- a/drivers/iio/adc/ad9467.c
> > > > > +++ b/drivers/iio/adc/ad9467.c
> > > >=20
> > > > <snip>
> > > >=20
> > > > > +static int ad9467_buffer_get(struct iio_dev *indio_dev)
> > > >=20
> > > > perhaps a more descriptive name: ad9467_buffer_setup_optional?
> > > >=20
> > >=20
> > > Hmm, no strong feeling. So yeah, can do as you suggest. Even though, =
now that
> > > I'm
> > > thinking, I'm not so sure if this is just some legacy thing we had in=
 ADI tree.
> > > I
> > > wonder if it actually makes sense for a device like with no buffering=
 support?!
> > >=20
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D indi=
o_dev->dev.parent;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *dma_name;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!device_property_presen=
t(dev, "dmas"))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (device_property_read_st=
ring(dev, "dma-names", &dma_name))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dma_name =3D "rx";
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_dmaengine_b=
uffer_setup(dev, indio_dev, dma_name);
> > > >=20
> > > > The device tree bindings for "adi,ad9467" don't include dma propert=
ies
> > > > (nor should they). Perhaps the DMA lookup should be a callback to t=
he
> > > > backend? Or something similar to the SPI Engine offload that we are
> > > > working on?
> > > >=20
> > >=20
> > > Oh yes, I need to update the bindings. In the link I sent you we can =
see my
> > > thoughts
> > > on this. In theory, hardwarewise, it would actually make sense for th=
e DMA to
> > > be
> > > on
> > > the backend device because that's where the connection is in HW. Howe=
ver, since
> > > we
> > > want to have the IIO interface in the frontend, it would be hard to d=
o that
> > > without
> > > hacking devm_iio_dmaengine_buffer_setup(). I mean, lifetime wise it w=
ould be
> > > far
> > > from
> > > wise to have the DMA buffer associated to a completely different devi=
ce than
> > > the
> > > IIO
> > > parent device. I mean, one way could just be export iio_dmaengine_buf=
fer_free()
> > > and
> > > iio_dmaengine_buffer_alloc() so we can actually control the lifetime =
of the
> > > buffer
> > > from the frontend device. If Jonathan is fine with this, I'm on board=
 for
> > > it....
> > >=20
> > > - Nuno S=C3=A1
> > > >=20
> > >=20
> >=20
> > I was planning on exporting iio_dmaengine_buffer_alloc() [1] for SPI
> > Engine offload support, so I hope that is the right way to go. ;-)
> >=20
> > [1]:
> > https://github.com/analogdevicesinc/linux/pull/2341/commits/71048ff83a6=
3e9d0a5ddb9ffa331871edd6bd2a5
>=20
> I don't really want to extend much on this since this is still out of tre=
e code so
> I'm not sure we should be discussing it much in here. But there a couple =
of
> concerns
> already I'm seeing:
>=20
> * AFAIU, you export the function so you can use it in your pwm trigger. A=
nd you
> don't
> want to attach the buffer to a device. That looks very questionable. If y=
ou don't
> attach to a device, how do you have the userspace interface working on th=
at buffer?
> How can you fetch samples from it? Also hiding the buffer allocation in p=
ure
> trigger
> device is at the very least questionable. But the point is, in the end of=
 the day,
> the buffer should belong to a device.
>=20
> * Your PWM trigger seems to be highly focused on the spi_engine offload f=
eature.
> You

OTOH, it also seems there are some stm focused triggers. So maybe we can al=
so have
something more oriented to spi_engine...

- Nuno S=C3=A1

