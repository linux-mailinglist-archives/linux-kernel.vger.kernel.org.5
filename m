Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F337AAD22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjIVIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjIVIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:51:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B8CF;
        Fri, 22 Sep 2023 01:51:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so219907866b.3;
        Fri, 22 Sep 2023 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695372671; x=1695977471; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OPRt18Q3nSt6C3xJGFAfKZrj5zvoYjUCJVecD5gMWIA=;
        b=ahzFxKJHGt2spzhMp0hCqvOS5plfDOgt1LfWSGtXPgSBIR9zwlCNHKrgBQ/N2Rqf6W
         TtE/RsRVmsCQuY7q1w0uqFny2bEc42BgeFYxrnHK89qrFwHVOSCh8tS1xDMQo5y0Ob4T
         GIPDVtSKq7Y/1Mo3s2GNZfWBtGQWDxNTlHUmemhIl1FDmvSnFkUMDRIBf/pzKKLEJygZ
         0N6M88f+eT0KxQduWHuB78MT57MNUsyTBm+pm3ApBwM8trTKPnJMPn07FcTET34erMgG
         PffKvlcisubfMBlgKj0q6vASSFMffsGnzgw68MU2PP0gFYkCl8zqDiywcKXpEUID9+C9
         fhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695372671; x=1695977471;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPRt18Q3nSt6C3xJGFAfKZrj5zvoYjUCJVecD5gMWIA=;
        b=LvuI7oTBgJ0OkyY80gWjb4rRCFpGBdFIPLo1woj+WLxvU3XKlOlMJx55BWYuFghXTZ
         UfAHaxLHAJxI9XnAcz9u+r65ps8rTIlMSI5QF9IwNg2uwwfHoEiRePdmvhIGjODJ247q
         D/NzX1VwGo3Caq3g7u4TiTBG04zDgRiy8JjO8mwmXePJfPPCje5wtlv7/887S/Jr8GV7
         PovIUUv1GomYbkjribLLRmsfUamIChcZ5d23piz5Ep6Gxo6j9NYt4Mu9N/7buis/qzhc
         ioM2ooUHgMELCvVuWruskNhlP2geOBlJyAdoWEUCcdA7p1q30ythi+WINF4KUKwmmn/j
         q6Gw==
X-Gm-Message-State: AOJu0YyriaDiUOxm9JgDZhQGv1o22tSnLhOjPadej+8e9wl50zJ73wjI
        nCrGbjfi+CmaKzczkskHgmI=
X-Google-Smtp-Source: AGHT+IGi2K1al1hAewolPA/TeAjH30bTzkAI6nq0f0+AjreM9YtOKZUuZ18R0F3spjeG3ceNe83p+g==
X-Received: by 2002:a17:906:15a:b0:9ae:59c9:b831 with SMTP id 26-20020a170906015a00b009ae59c9b831mr4599440ejh.49.1695372670475;
        Fri, 22 Sep 2023 01:51:10 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef34:6000:bd39:43a2:571c:1c76? (p200300f6ef346000bd3943a2571c1c76.dip0.t-ipconnect.de. [2003:f6:ef34:6000:bd39:43a2:571c:1c76])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090624c100b009ae3e6c342asm2357193ejb.111.2023.09.22.01.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 01:51:09 -0700 (PDT)
Message-ID: <311803c091a70b2c242592eab267079db86f85f9.camel@gmail.com>
Subject: Re: [RFC v2 01/11] iio: introduce iio backend device
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Date:   Fri, 22 Sep 2023 10:53:54 +0200
In-Reply-To: <75287793-a1c1-9b61-73aa-a2cf8d61dac2@foss.st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
         <20230727150324.1157933-2-olivier.moysan@foss.st.com>
         <7ec3fe6183409c218b97a3359e951731b47fe16d.camel@gmail.com>
         <095f9c64-bcac-e838-ba69-b5df623c444f@foss.st.com>
         <8b63cad8749ceca31d2f50ee36925ce18523620f.camel@gmail.com>
         <9cf91ed4-8d57-6d84-1767-708a296803b9@foss.st.com>
         <7704da82b99730da5f62668246ba4249000a52f9.camel@gmail.com>
         <75287793-a1c1-9b61-73aa-a2cf8d61dac2@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
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

Sorry for the delay...

On Mon, 2023-09-18 at 17:52 +0200, Olivier MOYSAN wrote:
> Hi Nuno
>=20
> On 9/11/23 11:39, Nuno S=C3=A1 wrote:
> > On Tue, 2023-09-05 at 12:06 +0200, Olivier MOYSAN wrote:
> > > Hi Nuno,
> > >=20
> > > On 9/1/23 10:01, Nuno S=C3=A1 wrote:
> > > > Hi Olivier,
> > > >=20
> > > > On Thu, 2023-08-31 at 18:14 +0200, Olivier MOYSAN wrote:
> > > > > Hi Nuno,
> > > > >=20
> > > > > On 7/28/23 10:42, Nuno S=C3=A1 wrote:
> > > > > > Hi Olivier,
> > > > > >=20
> > > > > > On Thu, 2023-07-27 at 17:03 +0200, Olivier Moysan wrote:
> > > > > > > Add a new device type in IIO framework.
> > > > > > > This backend device does not compute channel attributes and d=
oes
> > > > > > > not
> > > > > > > expose
> > > > > > > them through sysfs, as done typically in iio-rescale frontend
> > > > > > > device.
> > > > > > > Instead, it allows to report information applying to channel
> > > > > > > attributes through callbacks. These backend devices can be
> > > > > > > cascaded
> > > > > > > to represent chained components.
> > > > > > > An IIO device configured as a consumer of a backend device ca=
n
> > > > > > > compute
> > > > > > > the channel attributes of the whole chain.
> > > > > > >=20
> > > > > > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > > > > > ---
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/Makefile=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/industrialio-backend.c | =
107
> > > > > > > +++++++++++++++++++++++++++++
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0include/linux/iio/backend.h=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 56 +++++++++++++++
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A03 files changed, 164 insertions(+)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0create mode 100644 drivers/iio/indust=
rialio-backend.c
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0create mode 100644 include/linux/iio/=
backend.h
> > > > > > >=20
> > > > > > > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > > > > > > index 9622347a1c1b..9b59c6ab1738 100644
> > > > > > > --- a/drivers/iio/Makefile
> > > > > > > +++ b/drivers/iio/Makefile
> > > > > > > @@ -5,6 +5,7 @@
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0obj-$(CONFIG_IIO) +=3D industrialio.o
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0industrialio-y :=3D industrialio-core=
.o industrialio-event.o
> > > > > > > inkern.o
> > > > > > > +industrialio-$(CONFIG_IIO_BACKEND) +=3D industrialio-backend=
.o
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0industrialio-$(CONFIG_IIO_BUFFER) +=
=3D industrialio-buffer.o
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0industrialio-$(CONFIG_IIO_TRIGGER) +=
=3D industrialio-trigger.o
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > > > > b/drivers/iio/industrialio-
> > > > > > > backend.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..7d0625889873
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/iio/industrialio-backend.c
> > > > > > > @@ -0,0 +1,107 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > +/* The industrial I/O core, backend handling functions
> > > > > > > + *
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/kernel.h>
> > > > > > > +#include <linux/device.h>
> > > > > > > +#include <linux/property.h>
> > > > > > > +#include <linux/iio/iio.h>
> > > > > > > +#include <linux/iio/backend.h>
> > > > > > > +
> > > > > > > +static DEFINE_IDA(iio_backend_ida);
> > > > > > > +
> > > > > > > +#define to_iio_backend(_device) container_of((_device), stru=
ct
> > > > > > > iio_backend,
> > > > > > > dev)
> > > > > > > +
> > > > > > > +static void iio_backend_release(struct device *device)
> > > > > > > +{
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend=
 *backend =3D to_iio_backend(device);
> > > > > > > +
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend->nam=
e);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static const struct device_type iio_backend_type =3D {
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.release =3D iio_b=
ackend_release,
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "iio_bac=
kend_device",
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct iio_backend *iio_backend_alloc(struct device *parent)
> > > > > > > +{
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend=
 *backend;
> > > > > > > +
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backend =3D devm_k=
zalloc(parent, sizeof(*backend),
> > > > > > > GFP_KERNEL);
> > > > > > >=20
> > > > > >=20
> > > > > > No error checking.
> > > > > >=20
> > > > > > I guess a lot of cleanings are still missing but the important =
thing
> > > > > > I
> > > > > > wanted to
> > > > > > notice is that the above pattern is not ok.
> > > > > > Your 'struct iio_backend *backend'' embeds a 'stuct device' whi=
ch is
> > > > > > a
> > > > > > refcounted object. Nevertheless, you're binding the lifetime of=
 your
> > > > > > object to
> > > > > > the parent device and that is wrong. The reason is that as soon=
 as
> > > > > > your
> > > > > > parent
> > > > > > device get's released or just unbinded from it's driver, all th=
e
> > > > > > devres
> > > > > > stuff
> > > > > > (including your 'struct iio_backend' object) will be released
> > > > > > independentof
> > > > > > your 'struct device' refcount value...
> > > > > >=20
> > > > > > So, you might argue this won't ever be an issue in here but the
> > > > > > pattern
> > > > > > is still
> > > > > > wrong. There are some talks about this, the last one was given =
at
> > > > > > the
> > > > > > latest
> > > > > > EOSS:
> > > > > >=20
> > > > > > https://www.youtube.com/watch?v=3DHCiJL7djGw8&list=3DPLbzoR-pLr=
L6pY8a8zSKRC6-AihFrruOkq&index=3D27&ab_channel=3DTheLinuxFoundation
> > > > > >=20
> > > > >=20
> > > > > This is a good point. Thanks for pointing it out. Sure, there are
> > > > > still
> > > > > many things to improve.
> > > > >=20
> > > > > I have seen the comment from Jonathan on your "Add converter
> > > > > framework"
> > > > > serie. I had a quick look at the serie. It seems that we share th=
e
> > > > > need
> > > > > to aggregate some IIO devices. But I need to read it more careful=
ly to
> > > > > check if we can find some convergences here.
> > > >=20
> > > > Yeah, In my case, the backend devices are typically FPGA soft cores=
 and
> > > > the
> > > > aggregate
> > > > device might connect to multiple of these backends. That was one of=
 the
> > > > reason why I
> > > > used the component API where the aggregate device is only configure=
d
> > > > when
> > > > all the
> > > > devices are probed. Similarly, when one of them is unbind, the whol=
e
> > > > thing
> > > > should be
> > > > torn down. Also, in my case, the frontend device needs to do a lot =
of
> > > > setup
> > > > on the
> > > > backend device so the whole thing works (so I do have/need a lot mo=
re
> > > > .ops).
> > > >=20
> > > > Anyways, it does not matter much what the backend device is and fro=
m a
> > > > first
> > > > glance
> > > > and looking at the .ops you have, it seems that this could easily b=
e
> > > > supported in the
> > > > framework I'm adding. The only things I'm seeing are:
> > >=20
> > > Thanks for your feedback. Yes, my feeling is that the API I need for =
the
> > > dfsdm use case, can be covered by the API you propose. I'm not famili=
ar
> > > with component API however, as I discovered it in your serie. It is n=
ot
> > > clear for me how this affects device tree description of the hardware=
.
> >=20
> > Your aggregate device (that we can think of as a frontend device needs =
to
> > properly reference all the backends it needs - in your case I guess it'=
s
> > just
> > one device). The dts properties I have for now are 'converters' and
> > 'converter-
> > names'. But one thing that starts to become clear to me is that I shoul=
d
> > probably change the name for the framework. Maybe industrialio-aggregat=
e.c
> > if we
> > keep the component API (and so the same frontend + backend naming) or j=
ust
> > industrialio-backend.c (as you have now) if we go with a typical OF loo=
kup.
> >=20
>=20
> In my case I have a digital filter peripheral (frontend) linked to=20
> several sigma delta converters (backends). So, here 'converters'=20
> property may be relevant as well. But I agree that a more generic name=
=20
> seems better for the long term.
>=20
> My backend devices need to get a regulator phandle from the device tree.
> It seems that the component API does not offer services allowing to=20
> retrieve DT properties for the sub-devices. Tell me if I'm wrong, but I=
=20
> think this constraint require to change converter framework to a typical=
=20
> OF lookup.
>=20
> Could you please share the structure of your DT for your ad9476 based=20
> example ? This will help me identify the gaps regarding my need.
>=20

I might be missing something but there should be no limitation in the compo=
nent
stuff for this. Note your frontend/backend devices are just normal device t=
ree
nodes (meaning that they can have all the properties they want as a normal =
node)
and then in the correspondent drivers you handle all the properties. For no=
w,
the only FW properties supported in the framework I sent are 'converters' a=
nd
'converter-name' which will be used to "create" the aggregate device. This
pretty much means that the complete thing should only come up when all the
devices you set in DT probe.

Of course we can move more properties into the framework if we start to see=
 some
generic ones that are almost always present...

One thing that Jonathan already mentioned is that the component API works i=
n a
away that you can have either 1->1 or 1->N (frontends->backends). So, if yo=
u
have setups where you have more than one frontend (basically M->N) we need =
to
make sure it still works. In theory (in the component API), I think you can=
 have
one backend associated with more than one frontend so we should be able to =
still
get the M->N topology. Of course the "communications link" is always betwee=
n
frontend -> backend.

I'll see if I send the devicetree over the weekend (don't have it in my cur=
rent
machine)

- Nuno S=C3=A1

> >=20
>=20
