Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BFC7AD07C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjIYGsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjIYGsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:48:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A174A9;
        Sun, 24 Sep 2023 23:48:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso691909366b.1;
        Sun, 24 Sep 2023 23:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695624505; x=1696229305; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QGQcLCqxCVGny11t4hpZ6Fi6+yI0JQShobQTR68V3/g=;
        b=NHW7yTvUlwL6C8iVdhsGdaSnW7S20hHC65rMYExVtxmvSTHRNdWgmXf1ccWol5j7Wm
         +WLrNSBF1FTthhYDHpkeAsxCEdM2cmkbjmZQ3ZYwYKzZDfJC2PaBt0XpfIAHwSr/suhN
         UKcEXWJXRqwD5Gs9mUXOgy4KaEF4ElM/xMYpM09RBeZ3Q3aPHxk/RRrQ7Btn2QPkAN12
         HNj07S9q0LtT5WnvgAE6fUkxV63eDzcwKqUfCDgsivudF8RCwmG/nHqIvXSlbZ/LPPc7
         Dt/K3vBvzp8BGn6VqR4DXPRu9v+kgr0DMbE0W2hU5UQf6KCgR150btUyjROLXwC64eJH
         mwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695624505; x=1696229305;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGQcLCqxCVGny11t4hpZ6Fi6+yI0JQShobQTR68V3/g=;
        b=UF/8Z6hOGAAMMk5b1UPKDua0kfJZjRfIg2NEGlP7KorTYcWvasgszoepBN+1/rMLfs
         AvxWOvyXZI9IHyNwDnopFoDHFrF1fGxc3NLDqkjM56IqG7ZYrm9T6+T4HWS2JAGuLmC+
         f3P4/CcfuDRCec/TB71nogtk9+LlRVEYYN93Lna9eUXV8AknHjlzeE637Ws9j9me12R0
         KalLjhANB6QZYoEMbqq3mREVGtUNR4NT1xsuMSBgw33JuShoKf/px2yCwzUzQ1rSKPt2
         5OvLV4lcRKn8bDDSPecYnDD446y2VbO3tShHo/+YlhOZ1Vj9CDFNbpNIpfLlyI3I3c+y
         eIxQ==
X-Gm-Message-State: AOJu0Yx8AC/zmO7f6Uq9UwPL6DgtdzknKowNoew2W8ZySfEL+XQOm1wC
        FrNuOQ08HNSYM38GAFmSizU=
X-Google-Smtp-Source: AGHT+IF/zXhfeyIYJTltKzgj93IVC5uPE6B5Uwnkh8X9KlFN1dZbN7NKqlIF/CpJUk9r1wLiMYItmw==
X-Received: by 2002:a17:906:30d5:b0:9ae:6355:afe9 with SMTP id b21-20020a17090630d500b009ae6355afe9mr5324754ejb.52.1695624504543;
        Sun, 24 Sep 2023 23:48:24 -0700 (PDT)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id lt2-20020a170906fa8200b00992e265495csm5839491ejb.212.2023.09.24.23.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 23:48:23 -0700 (PDT)
Message-ID: <c25d404fa19c03cafc6dfe70b964369c7c773849.camel@gmail.com>
Subject: Re: [RFC v2 01/11] iio: introduce iio backend device
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Date:   Mon, 25 Sep 2023 08:48:23 +0200
In-Reply-To: <311803c091a70b2c242592eab267079db86f85f9.camel@gmail.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
         <20230727150324.1157933-2-olivier.moysan@foss.st.com>
         <7ec3fe6183409c218b97a3359e951731b47fe16d.camel@gmail.com>
         <095f9c64-bcac-e838-ba69-b5df623c444f@foss.st.com>
         <8b63cad8749ceca31d2f50ee36925ce18523620f.camel@gmail.com>
         <9cf91ed4-8d57-6d84-1767-708a296803b9@foss.st.com>
         <7704da82b99730da5f62668246ba4249000a52f9.camel@gmail.com>
         <75287793-a1c1-9b61-73aa-a2cf8d61dac2@foss.st.com>
         <311803c091a70b2c242592eab267079db86f85f9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

On Fri, 2023-09-22 at 10:53 +0200, Nuno S=C3=A1 wrote:
> Hi Olivier,
>=20
> Sorry for the delay...
>=20
> On Mon, 2023-09-18 at 17:52 +0200, Olivier MOYSAN wrote:
> > Hi Nuno
> >=20
> > On 9/11/23 11:39, Nuno S=C3=A1 wrote:
> > > On Tue, 2023-09-05 at 12:06 +0200, Olivier MOYSAN wrote:
> > > > Hi Nuno,
> > > >=20
> > > > On 9/1/23 10:01, Nuno S=C3=A1 wrote:
> > > > > Hi Olivier,
> > > > >=20
> > > > > On Thu, 2023-08-31 at 18:14 +0200, Olivier MOYSAN wrote:
> > > > > > Hi Nuno,
> > > > > >=20
> > > > > > On 7/28/23 10:42, Nuno S=C3=A1 wrote:
> > > > > > > Hi Olivier,
> > > > > > >=20
> > > > > > > On Thu, 2023-07-27 at 17:03 +0200, Olivier Moysan wrote:
> > > > > > > > Add a new device type in IIO framework.
> > > > > > > > This backend device does not compute channel attributes and=
 does
> > > > > > > > not
> > > > > > > > expose
> > > > > > > > them through sysfs, as done typically in iio-rescale fronte=
nd
> > > > > > > > device.
> > > > > > > > Instead, it allows to report information applying to channe=
l
> > > > > > > > attributes through callbacks. These backend devices can be
> > > > > > > > cascaded
> > > > > > > > to represent chained components.
> > > > > > > > An IIO device configured as a consumer of a backend device =
can
> > > > > > > > compute
> > > > > > > > the channel attributes of the whole chain.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > > > > > > ---
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/Makefile=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/industrialio-backend.c =
| 107
> > > > > > > > +++++++++++++++++++++++++++++
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0include/linux/iio/backend.h=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 56 +++++++++++++++
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A03 files changed, 164 insertions(+)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0create mode 100644 drivers/iio/indu=
strialio-backend.c
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0create mode 100644 include/linux/ii=
o/backend.h
> > > > > > > >=20
> > > > > > > > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > > > > > > > index 9622347a1c1b..9b59c6ab1738 100644
> > > > > > > > --- a/drivers/iio/Makefile
> > > > > > > > +++ b/drivers/iio/Makefile
> > > > > > > > @@ -5,6 +5,7 @@
> > > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0obj-$(CONFIG_IIO) +=3D industrialio=
.o
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0industrialio-y :=3D industrialio-co=
re.o industrialio-event.o
> > > > > > > > inkern.o
> > > > > > > > +industrialio-$(CONFIG_IIO_BACKEND) +=3D industrialio-backe=
nd.o
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0industrialio-$(CONFIG_IIO_BUFFER) +=
=3D industrialio-buffer.o
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0industrialio-$(CONFIG_IIO_TRIGGER) =
+=3D industrialio-trigger.o
> > > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > > > > > b/drivers/iio/industrialio-
> > > > > > > > backend.c
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..7d0625889873
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/drivers/iio/industrialio-backend.c
> > > > > > > > @@ -0,0 +1,107 @@
> > > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > > +/* The industrial I/O core, backend handling functions
> > > > > > > > + *
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +#include <linux/kernel.h>
> > > > > > > > +#include <linux/device.h>
> > > > > > > > +#include <linux/property.h>
> > > > > > > > +#include <linux/iio/iio.h>
> > > > > > > > +#include <linux/iio/backend.h>
> > > > > > > > +
> > > > > > > > +static DEFINE_IDA(iio_backend_ida);
> > > > > > > > +
> > > > > > > > +#define to_iio_backend(_device) container_of((_device), st=
ruct
> > > > > > > > iio_backend,
> > > > > > > > dev)
> > > > > > > > +
> > > > > > > > +static void iio_backend_release(struct device *device)
> > > > > > > > +{
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backe=
nd *backend =3D to_iio_backend(device);
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend->n=
ame);
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static const struct device_type iio_backend_type =3D {
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.release =3D iio=
_backend_release,
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "iio_b=
ackend_device",
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +struct iio_backend *iio_backend_alloc(struct device *paren=
t)
> > > > > > > > +{
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backe=
nd *backend;
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backend =3D devm=
_kzalloc(parent, sizeof(*backend),
> > > > > > > > GFP_KERNEL);
> > > > > > > >=20
> > > > > > >=20
> > > > > > > No error checking.
> > > > > > >=20
> > > > > > > I guess a lot of cleanings are still missing but the importan=
t thing
> > > > > > > I
> > > > > > > wanted to
> > > > > > > notice is that the above pattern is not ok.
> > > > > > > Your 'struct iio_backend *backend'' embeds a 'stuct device' w=
hich is
> > > > > > > a
> > > > > > > refcounted object. Nevertheless, you're binding the lifetime =
of your
> > > > > > > object to
> > > > > > > the parent device and that is wrong. The reason is that as so=
on as
> > > > > > > your
> > > > > > > parent
> > > > > > > device get's released or just unbinded from it's driver, all =
the
> > > > > > > devres
> > > > > > > stuff
> > > > > > > (including your 'struct iio_backend' object) will be released
> > > > > > > independentof
> > > > > > > your 'struct device' refcount value...
> > > > > > >=20
> > > > > > > So, you might argue this won't ever be an issue in here but t=
he
> > > > > > > pattern
> > > > > > > is still
> > > > > > > wrong. There are some talks about this, the last one was give=
n at
> > > > > > > the
> > > > > > > latest
> > > > > > > EOSS:
> > > > > > >=20
> > > > > > > https://www.youtube.com/watch?v=3DHCiJL7djGw8&list=3DPLbzoR-p=
LrL6pY8a8zSKRC6-AihFrruOkq&index=3D27&ab_channel=3DTheLinuxFoundation
> > > > > > >=20
> > > > > >=20
> > > > > > This is a good point. Thanks for pointing it out. Sure, there a=
re
> > > > > > still
> > > > > > many things to improve.
> > > > > >=20
> > > > > > I have seen the comment from Jonathan on your "Add converter
> > > > > > framework"
> > > > > > serie. I had a quick look at the serie. It seems that we share =
the
> > > > > > need
> > > > > > to aggregate some IIO devices. But I need to read it more caref=
ully to
> > > > > > check if we can find some convergences here.
> > > > >=20
> > > > > Yeah, In my case, the backend devices are typically FPGA soft cor=
es and
> > > > > the
> > > > > aggregate
> > > > > device might connect to multiple of these backends. That was one =
of the
> > > > > reason why I
> > > > > used the component API where the aggregate device is only configu=
red
> > > > > when
> > > > > all the
> > > > > devices are probed. Similarly, when one of them is unbind, the wh=
ole
> > > > > thing
> > > > > should be
> > > > > torn down. Also, in my case, the frontend device needs to do a lo=
t of
> > > > > setup
> > > > > on the
> > > > > backend device so the whole thing works (so I do have/need a lot =
more
> > > > > .ops).
> > > > >=20
> > > > > Anyways, it does not matter much what the backend device is and f=
rom a
> > > > > first
> > > > > glance
> > > > > and looking at the .ops you have, it seems that this could easily=
 be
> > > > > supported in the
> > > > > framework I'm adding. The only things I'm seeing are:
> > > >=20
> > > > Thanks for your feedback. Yes, my feeling is that the API I need fo=
r the
> > > > dfsdm use case, can be covered by the API you propose. I'm not fami=
liar
> > > > with component API however, as I discovered it in your serie. It is=
 not
> > > > clear for me how this affects device tree description of the hardwa=
re.
> > >=20
> > > Your aggregate device (that we can think of as a frontend device need=
s to
> > > properly reference all the backends it needs - in your case I guess i=
t's
> > > just
> > > one device). The dts properties I have for now are 'converters' and
> > > 'converter-
> > > names'. But one thing that starts to become clear to me is that I sho=
uld
> > > probably change the name for the framework. Maybe industrialio-aggreg=
ate.c
> > > if we
> > > keep the component API (and so the same frontend + backend naming) or=
 just
> > > industrialio-backend.c (as you have now) if we go with a typical OF l=
ookup.
> > >=20
> >=20
> > In my case I have a digital filter peripheral (frontend) linked to=20
> > several sigma delta converters (backends). So, here 'converters'=20
> > property may be relevant as well. But I agree that a more generic name=
=20
> > seems better for the long term.
> >=20
> > My backend devices need to get a regulator phandle from the device tree=
.
> > It seems that the component API does not offer services allowing to=20
> > retrieve DT properties for the sub-devices. Tell me if I'm wrong, but I=
=20
> > think this constraint require to change converter framework to a typica=
l=20
> > OF lookup.
> >=20
> > Could you please share the structure of your DT for your ad9476 based=
=20
> > example ? This will help me identify the gaps regarding my need.
> >=20
>=20
> I might be missing something but there should be no limitation in the com=
ponent
> stuff for this. Note your frontend/backend devices are just normal device=
 tree
> nodes (meaning that they can have all the properties they want as a norma=
l node)
> and then in the correspondent drivers you handle all the properties. For =
now,
> the only FW properties supported in the framework I sent are 'converters'=
 and
> 'converter-name' which will be used to "create" the aggregate device. Thi=
s
> pretty much means that the complete thing should only come up when all th=
e
> devices you set in DT probe.
>=20
> Of course we can move more properties into the framework if we start to s=
ee some
> generic ones that are almost always present...
>=20
> One thing that Jonathan already mentioned is that the component API works=
 in a
> away that you can have either 1->1 or 1->N (frontends->backends). So, if =
you
> have setups where you have more than one frontend (basically M->N) we nee=
d to
> make sure it still works. In theory (in the component API), I think you c=
an have
> one backend associated with more than one frontend so we should be able t=
o still
> get the M->N topology. Of course the "communications link" is always betw=
een
> frontend -> backend.
>=20
> I'll see if I send the devicetree over the weekend (don't have it in my c=
urrent
> machine)
>=20
>=20

Here it goes the 2 nodes of interest in my testing...

adc_ad9467: ad9467@0 {
        compatible =3D "adi,ad9467";
        reg =3D <0>;

        dmas =3D <&rx_dma 0>;
        dma-names =3D "rx";

        spi-max-frequency =3D <10000000>;
        adi,spi-3wire-enable;

        clocks =3D <&clk_ad9517 3>;
        clock-names =3D "adc-clk";

        converters =3D <&cf_ad9467_core_0>;
};

cf_ad9467_core_0: cf-ad9467-core-lpc@44a00000 {
        compatible =3D "adi,axi-adc-10.0.a";
        reg =3D <0x44A00000 0x10000>;

        clocks =3D <&clkc 16>;
};

Naturally, converter-names only makes sense when you have more than one bac=
kend. But
see that in 'cf_ad9467_core_0', you are free to place a regulator (as I hav=
e a clock)
as long as you handle it in the backend driver.

- Nuno S=C3=A1
> >=20
