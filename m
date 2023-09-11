Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A079BF87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242243AbjIKWXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbjIKJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:36:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A944AE7;
        Mon, 11 Sep 2023 02:36:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so5402067a12.1;
        Mon, 11 Sep 2023 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694424982; x=1695029782; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bpVkJJ7m6qvUN1qT+CID+AZx4IQ3hba2HraQxDZh6mI=;
        b=dMGzPr8PfMiW8ybbDJ0zJecM3Pldnb2fvQTxXjEdF4ViKxxNRObGLDHhd3IpGn/t7P
         vvq78Qt2bfqfB0KFzjpyLQqeTuw3dLZoE6Dn/O70sOZth32Dd11vBrl+bS+267DdXdif
         1ccJh85LWG9SRCXF9/glIxEWJNMDPhLvRPVQjUnhvE9vLJj6zXX+TJ9oWDyHq1Pq5nee
         NRkZFS05K7czjeHz/U8mK8lX0OOUA6EAtnC3nwC8fU+gticBZrsAldjQYXQTgoUPhIEf
         MP+a6l4+yRHiUIQatWH8a9sUd7hmr0HepHbDph2zMCJv0H7srD9b4BOBTNxKdsUIvfcY
         qQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424982; x=1695029782;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpVkJJ7m6qvUN1qT+CID+AZx4IQ3hba2HraQxDZh6mI=;
        b=c9MD7sVL+Fzb8X0QXkzios31AbBU9cFKfK4wZrR9mLd5h7VIoQN35HxpYrHt+xMvph
         iXryZa8nKampzKmwB6dllIzrxrDatkXsUexO+hf7vf5Gh/a/gpGPN1meJVqg2Fgw6QUI
         xqlXBagoH6jDDSzBb/q3c8bwOhg4f1DW54xZkbHNhaa4XjJLupthA0HmbnzxVrbHa1Y4
         3hPfNqDbOsRtGejF0/v+YQJUKxqa7QixopLT2RMKN6bvQP/fwK9kB1tlKf+xtLituaWf
         ysUhW34mQ3O3AHNMHNUpXQA6A0rNEIElovniaD1RFZp2M0owiYuMiHbl8SnInDyDAEIW
         QTkQ==
X-Gm-Message-State: AOJu0YyKKBXeWZwe4xZGuuySQs2aN2zWOo5mEWtVLEeci/9tSQZqY/7u
        NTipt1hf3ocgoSDTCqiIikc=
X-Google-Smtp-Source: AGHT+IGLbWxoNir8IZc0GNOR7Uu5qDBguwsWZGd00u35GagpzbNVqehUemI1dmoZpuKOhrVDO6hwYw==
X-Received: by 2002:a17:906:1d:b0:9a1:b67e:415 with SMTP id 29-20020a170906001d00b009a1b67e0415mr7709877eja.73.1694424981781;
        Mon, 11 Sep 2023 02:36:21 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef34:6000:4640:4182:8da8:51bf? (p200300f6ef346000464041828da851bf.dip0.t-ipconnect.de. [2003:f6:ef34:6000:4640:4182:8da8:51bf])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906371600b0099297c99314sm5044006ejc.113.2023.09.11.02.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:36:20 -0700 (PDT)
Message-ID: <7704da82b99730da5f62668246ba4249000a52f9.camel@gmail.com>
Subject: Re: [RFC v2 01/11] iio: introduce iio backend device
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Date:   Mon, 11 Sep 2023 11:39:03 +0200
In-Reply-To: <9cf91ed4-8d57-6d84-1767-708a296803b9@foss.st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
         <20230727150324.1157933-2-olivier.moysan@foss.st.com>
         <7ec3fe6183409c218b97a3359e951731b47fe16d.camel@gmail.com>
         <095f9c64-bcac-e838-ba69-b5df623c444f@foss.st.com>
         <8b63cad8749ceca31d2f50ee36925ce18523620f.camel@gmail.com>
         <9cf91ed4-8d57-6d84-1767-708a296803b9@foss.st.com>
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

On Tue, 2023-09-05 at 12:06 +0200, Olivier MOYSAN wrote:
> Hi Nuno,
>=20
> On 9/1/23 10:01, Nuno S=C3=A1 wrote:
> > Hi Olivier,
> >=20
> > On Thu, 2023-08-31 at 18:14 +0200, Olivier MOYSAN wrote:
> > > Hi Nuno,
> > >=20
> > > On 7/28/23 10:42, Nuno S=C3=A1 wrote:
> > > > Hi Olivier,
> > > >=20
> > > > On Thu, 2023-07-27 at 17:03 +0200, Olivier Moysan wrote:
> > > > > Add a new device type in IIO framework.
> > > > > This backend device does not compute channel attributes and does =
not
> > > > > expose
> > > > > them through sysfs, as done typically in iio-rescale frontend dev=
ice.
> > > > > Instead, it allows to report information applying to channel
> > > > > attributes through callbacks. These backend devices can be cascad=
ed
> > > > > to represent chained components.
> > > > > An IIO device configured as a consumer of a backend device can co=
mpute
> > > > > the channel attributes of the whole chain.
> > > > >=20
> > > > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > > > ---
> > > > > =C2=A0=C2=A0=C2=A0drivers/iio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > > =C2=A0=C2=A0=C2=A0drivers/iio/industrialio-backend.c | 107
> > > > > +++++++++++++++++++++++++++++
> > > > > =C2=A0=C2=A0=C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 56 +++++++++++++++
> > > > > =C2=A0=C2=A0=C2=A03 files changed, 164 insertions(+)
> > > > > =C2=A0=C2=A0=C2=A0create mode 100644 drivers/iio/industrialio-bac=
kend.c
> > > > > =C2=A0=C2=A0=C2=A0create mode 100644 include/linux/iio/backend.h
> > > > >=20
> > > > > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > > > > index 9622347a1c1b..9b59c6ab1738 100644
> > > > > --- a/drivers/iio/Makefile
> > > > > +++ b/drivers/iio/Makefile
> > > > > @@ -5,6 +5,7 @@
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0=C2=A0obj-$(CONFIG_IIO) +=3D industrialio.o
> > > > > =C2=A0=C2=A0=C2=A0industrialio-y :=3D industrialio-core.o industr=
ialio-event.o inkern.o
> > > > > +industrialio-$(CONFIG_IIO_BACKEND) +=3D industrialio-backend.o
> > > > > =C2=A0=C2=A0=C2=A0industrialio-$(CONFIG_IIO_BUFFER) +=3D industri=
alio-buffer.o
> > > > > =C2=A0=C2=A0=C2=A0industrialio-$(CONFIG_IIO_TRIGGER) +=3D industr=
ialio-trigger.o
> > > > > =C2=A0=C2=A0=20
> > > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > > b/drivers/iio/industrialio-
> > > > > backend.c
> > > > > new file mode 100644
> > > > > index 000000000000..7d0625889873
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/industrialio-backend.c
> > > > > @@ -0,0 +1,107 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/* The industrial I/O core, backend handling functions
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/property.h>
> > > > > +#include <linux/iio/iio.h>
> > > > > +#include <linux/iio/backend.h>
> > > > > +
> > > > > +static DEFINE_IDA(iio_backend_ida);
> > > > > +
> > > > > +#define to_iio_backend(_device) container_of((_device), struct
> > > > > iio_backend,
> > > > > dev)
> > > > > +
> > > > > +static void iio_backend_release(struct device *device)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *ba=
ckend =3D to_iio_backend(device);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend->name);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend);
> > > > > +}
> > > > > +
> > > > > +static const struct device_type iio_backend_type =3D {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.release =3D iio_backe=
nd_release,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "iio_backend=
_device",
> > > > > +};
> > > > > +
> > > > > +struct iio_backend *iio_backend_alloc(struct device *parent)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *ba=
ckend;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backend =3D devm_kzall=
oc(parent, sizeof(*backend), GFP_KERNEL);
> > > > >=20
> > > >=20
> > > > No error checking.
> > > >=20
> > > > I guess a lot of cleanings are still missing but the important thin=
g I
> > > > wanted to
> > > > notice is that the above pattern is not ok.
> > > > Your 'struct iio_backend *backend'' embeds a 'stuct device' which i=
s a
> > > > refcounted object. Nevertheless, you're binding the lifetime of you=
r
> > > > object to
> > > > the parent device and that is wrong. The reason is that as soon as =
your
> > > > parent
> > > > device get's released or just unbinded from it's driver, all the de=
vres
> > > > stuff
> > > > (including your 'struct iio_backend' object) will be released
> > > > independentof
> > > > your 'struct device' refcount value...
> > > >=20
> > > > So, you might argue this won't ever be an issue in here but the pat=
tern
> > > > is still
> > > > wrong. There are some talks about this, the last one was given at t=
he
> > > > latest
> > > > EOSS:
> > > >=20
> > > > https://www.youtube.com/watch?v=3DHCiJL7djGw8&list=3DPLbzoR-pLrL6pY=
8a8zSKRC6-AihFrruOkq&index=3D27&ab_channel=3DTheLinuxFoundation
> > > >=20
> > >=20
> > > This is a good point. Thanks for pointing it out. Sure, there are sti=
ll
> > > many things to improve.
> > >=20
> > > I have seen the comment from Jonathan on your "Add converter framewor=
k"
> > > serie. I had a quick look at the serie. It seems that we share the ne=
ed
> > > to aggregate some IIO devices. But I need to read it more carefully t=
o
> > > check if we can find some convergences here.
> >=20
> > Yeah, In my case, the backend devices are typically FPGA soft cores and=
 the
> > aggregate
> > device might connect to multiple of these backends. That was one of the
> > reason why I
> > used the component API where the aggregate device is only configured wh=
en
> > all the
> > devices are probed. Similarly, when one of them is unbind, the whole th=
ing
> > should be
> > torn down. Also, in my case, the frontend device needs to do a lot of s=
etup
> > on the
> > backend device so the whole thing works (so I do have/need a lot more .=
ops).
> >=20
> > Anyways, it does not matter much what the backend device is and from a =
first
> > glance
> > and looking at the .ops you have, it seems that this could easily be
> > supported in the
> > framework I'm adding. The only things I'm seeing are:
>=20
> Thanks for your feedback. Yes, my feeling is that the API I need for the=
=20
> dfsdm use case, can be covered by the API you propose. I'm not familiar=
=20
> with component API however, as I discovered it in your serie. It is not=
=20
> clear for me how this affects device tree description of the hardware.

Your aggregate device (that we can think of as a frontend device needs to
properly reference all the backends it needs - in your case I guess it's ju=
st
one device). The dts properties I have for now are 'converters' and 'conver=
ter-
names'. But one thing that starts to become clear to me is that I should
probably change the name for the framework. Maybe industrialio-aggregate.c =
if we
keep the component API (and so the same frontend + backend naming) or just
industrialio-backend.c (as you have now) if we go with a typical OF lookup.

> So I need to take time to look at existing examples.
> I think I need also to try a template implementation of dfsdm use case=
=20
> based on your API, to figure out how it could work.
>=20

Please do so :).

> >=20
> > 1) You would need to use the component API if it's ok. Also not sure if=
 the
> > cascaded
> > usecase you mention would work with that API.
> >=20
>=20
> The cascaded use case by itself is not a real requirement for dfsdm use=
=20
> case. The idea here was to think about future possible needs, and to=20
> ensure that the solution is scalable enough. So, it is not a strong=20
> requirement, but we probably need to keep it in mind.
>=20

Sure. I think one backend might be used as frontend in another aggregate de=
vice,
using the component API, but I'm 100% sure. So, yeah, something to keep in =
mind
and test with some dummy setup.

> > 2) We would need to add the .read_raw() op. If you look at my RFC, I al=
ready
> > have
> > some comments/concerns about having an option like that (see there).
> >=20
> > Having said that, none of the above are blockers as 1), I can ditch the
> > component API
> > in favour of typical FW/OF lookup (even though the component API makes =
some
> > things
> > easier to handle) and 2), adding a .read_raw() op is not a blocker for =
me.
> >=20
>=20
> Yes, It would be nice to have read_raw(), as this allows to stick to=20
> existing IIO API for standard IIO attributes. But I guess this should=20
> not be a problem.

My idea is to still make use of standard IIO attrs but with a more fine gra=
ined
approach on the callback. Here is what I reasoned about in the other thread=
:

"There are some IIO attributes (like scale, frequency, etc) that might
be implemented in the soft cores. I still didn't made my mind if I should j=
ust
have a catch all read_raw() and write_raw() converter_ops or more fine
tuned ops. Having the catch all reduces the number of ops but also makes
it more easier to add stuff that ends up being not used anymore and then
forgotten. There are also cases (eg: setting sampling frequency) where
we might need to apply settings in both the frontend and the backend
devices which means having the catch all write_raw() would be more
awkward in these case. I'm a bit more inclined to the more specific ops."

- Nuno S=C3=A1

