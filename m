Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84A7B1485
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjI1HQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjI1HQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:16:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F622CC9;
        Thu, 28 Sep 2023 00:15:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-504b84d59cbso2176957e87.3;
        Thu, 28 Sep 2023 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695885351; x=1696490151; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=33ZfCzYAGHKG2C0lpmMA4tTJU3r/Irwm53aqU/hJTGs=;
        b=ClVkHWs9yV+xaomQX6IN7kbcZLln63xrXCCxDDHMPYY50E0x7aIpXLnYYkFedzTEQA
         ar5517PtqrfMAdOFS/SoUrjaGSoAgvmzl3tO5g0AENQy7f0XES7UGU73t7gGAW/Z4Ygy
         O8YT7sqciYAIJhJP+VSVjvYTrnwnfIJoWAwCUQNZ+yUU3fubCxzK8fhB05GzAiCSbIkc
         fR+ZRtleilmSAPI0sK6IHxiOLYGdPbSeVuezEHfqw0cZhyYyComOjpGjgYer8frWDZKY
         Z6BW0lQ5adRM2vULZF1+QudOIfLOUngx9lVHQ3yu+35N4/q6AiDvRjPEzzKp8ndtSnAw
         FAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695885351; x=1696490151;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33ZfCzYAGHKG2C0lpmMA4tTJU3r/Irwm53aqU/hJTGs=;
        b=NZjlb4rLluCsTnmgpROssvN5eTw/nLYd4euQALkAoLrJIyeNJcvbPFHyH+ewWXbe82
         vtRqiXATuv8skOuhqaAIDHZZx8jUmHR9nRWUeQHdTVqfd+PaIdypqBa4gwhPqlw2pc2x
         S6CZUQFEZmMxh9dtgyAHDJdFMX4EPIhBg3k6mQvoF4J96sdYVL6o39iNZ3QofKAzsmoA
         hCPCGdcIlgU5YwEQFLjhsRteVcLsnIIM8jHm9pCiHZKOgwsY7c+PLtx/qn7gzsBQ1OuA
         +wpJBbdc4dzRxoreXGavNTyPP1SIGEWCMn4ApXRzPDJ9J2bwJrGUMkYnP7JPXfBbWPLD
         3i2Q==
X-Gm-Message-State: AOJu0YzdafMlqtnbTnakwmYBA4ktHHkjSCc/vtnOiz7BK36fHwijRAvH
        DFCRkrZU11E20/q/8aeA25I=
X-Google-Smtp-Source: AGHT+IE2ChKJrMwi/0bbsvFt9PXdPuE7Mgrq6ku8r2n7nyAvTetdaF8DW9opG0BnkgbwS49cT2maoQ==
X-Received: by 2002:a05:6512:1383:b0:503:59d:fbff with SMTP id fc3-20020a056512138300b00503059dfbffmr497277lfb.2.1695885350460;
        Thu, 28 Sep 2023 00:15:50 -0700 (PDT)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id iw7-20020a05600c54c700b003fc16ee2864sm17676435wmb.48.2023.09.28.00.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 00:15:49 -0700 (PDT)
Message-ID: <60e913e81ce67192ed0449fe7b718434fd360d97.camel@gmail.com>
Subject: Re: [RFC v2 01/11] iio: introduce iio backend device
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Date:   Thu, 28 Sep 2023 09:15:49 +0200
In-Reply-To: <8991b1a2-d9bf-c04d-81e4-5ce60da579ab@foss.st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
         <20230727150324.1157933-2-olivier.moysan@foss.st.com>
         <7ec3fe6183409c218b97a3359e951731b47fe16d.camel@gmail.com>
         <095f9c64-bcac-e838-ba69-b5df623c444f@foss.st.com>
         <8b63cad8749ceca31d2f50ee36925ce18523620f.camel@gmail.com>
         <9cf91ed4-8d57-6d84-1767-708a296803b9@foss.st.com>
         <7704da82b99730da5f62668246ba4249000a52f9.camel@gmail.com>
         <75287793-a1c1-9b61-73aa-a2cf8d61dac2@foss.st.com>
         <311803c091a70b2c242592eab267079db86f85f9.camel@gmail.com>
         <c25d404fa19c03cafc6dfe70b964369c7c773849.camel@gmail.com>
         <8991b1a2-d9bf-c04d-81e4-5ce60da579ab@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

Hi Olivier,

On Tue, 2023-09-26 at 18:44 +0200, Olivier MOYSAN wrote:
> Hi Nuno,
>=20
> On 9/25/23 08:48, Nuno S=C3=A1 wrote:
> > Hi Olivier,
> >=20
> > On Fri, 2023-09-22 at 10:53 +0200, Nuno S=C3=A1 wrote:
> > > Hi Olivier,
> > >=20
> > > Sorry for the delay...
> > >=20
> > > On Mon, 2023-09-18 at 17:52 +0200, Olivier MOYSAN wrote:
> > > > Hi Nuno
> > > >=20
> > > > On 9/11/23 11:39, Nuno S=C3=A1 wrote:
> > > > > On Tue, 2023-09-05 at 12:06 +0200, Olivier MOYSAN wrote:
> > > > > > Hi Nuno,
> > > > > >=20
> > > > > > On 9/1/23 10:01, Nuno S=C3=A1 wrote:
> > > > > > > Hi Olivier,
> > > > > > >=20
> > > > > > > On Thu, 2023-08-31 at 18:14 +0200, Olivier MOYSAN wrote:
> > > > > > > > Hi Nuno,
> > > > > > > >=20
> > > > > > > > On 7/28/23 10:42, Nuno S=C3=A1 wrote:
> > > > > > > > > Hi Olivier,
> > > > > > > > >=20
> > > > > > > > > On Thu, 2023-07-27 at 17:03 +0200, Olivier Moysan wrote:
> > > > > > > > > > Add a new device type in IIO framework.
> > > > > > > > > > This backend device does not compute channel attributes=
 and does
> > > > > > > > > > not
> > > > > > > > > > expose
> > > > > > > > > > them through sysfs, as done typically in iio-rescale fr=
ontend
> > > > > > > > > > device.
> > > > > > > > > > Instead, it allows to report information applying to ch=
annel
> > > > > > > > > > attributes through callbacks. These backend devices can=
 be
> > > > > > > > > > cascaded
> > > > > > > > > > to represent chained components.
> > > > > > > > > > An IIO device configured as a consumer of a backend dev=
ice can
> > > > > > > > > > compute
> > > > > > > > > > the channel attributes of the whole chain.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.c=
om>
> > > > > > > > > > ---
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/Makefile=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/industrialio-=
backend.c | 107
> > > > > > > > > > +++++++++++++++++++++++++++++
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/linux/iio/backend=
.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 56 +++++++++++++++
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A03 files changed, 164 inse=
rtions(+)
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0create mode 100644 driver=
s/iio/industrialio-backend.c
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0create mode 100644 includ=
e/linux/iio/backend.h
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefil=
e
> > > > > > > > > > index 9622347a1c1b..9b59c6ab1738 100644
> > > > > > > > > > --- a/drivers/iio/Makefile
> > > > > > > > > > +++ b/drivers/iio/Makefile
> > > > > > > > > > @@ -5,6 +5,7 @@
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0obj-$(CONFIG_IIO) +=3D in=
dustrialio.o
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0industrialio-y :=3D indus=
trialio-core.o industrialio-event.o
> > > > > > > > > > inkern.o
> > > > > > > > > > +industrialio-$(CONFIG_IIO_BACKEND) +=3D industrialio-b=
ackend.o
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0industrialio-$(CONFIG_IIO=
_BUFFER) +=3D industrialio-buffer.o
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0industrialio-$(CONFIG_IIO=
_TRIGGER) +=3D industrialio-trigger.o
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > > > > > > > b/drivers/iio/industrialio-
> > > > > > > > > > backend.c
> > > > > > > > > > new file mode 100644
> > > > > > > > > > index 000000000000..7d0625889873
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/drivers/iio/industrialio-backend.c
> > > > > > > > > > @@ -0,0 +1,107 @@
> > > > > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > > > > +/* The industrial I/O core, backend handling functions
> > > > > > > > > > + *
> > > > > > > > > > + */
> > > > > > > > > > +
> > > > > > > > > > +#include <linux/kernel.h>
> > > > > > > > > > +#include <linux/device.h>
> > > > > > > > > > +#include <linux/property.h>
> > > > > > > > > > +#include <linux/iio/iio.h>
> > > > > > > > > > +#include <linux/iio/backend.h>
> > > > > > > > > > +
> > > > > > > > > > +static DEFINE_IDA(iio_backend_ida);
> > > > > > > > > > +
> > > > > > > > > > +#define to_iio_backend(_device) container_of((_device)=
, struct
> > > > > > > > > > iio_backend,
> > > > > > > > > > dev)
> > > > > > > > > > +
> > > > > > > > > > +static void iio_backend_release(struct device *device)
> > > > > > > > > > +{
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_b=
ackend *backend =3D to_iio_backend(device);
> > > > > > > > > > +
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backen=
d->name);
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backen=
d);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static const struct device_type iio_backend_type =3D {
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.release =3D=
 iio_backend_release,
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "i=
io_backend_device",
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > > +struct iio_backend *iio_backend_alloc(struct device *p=
arent)
> > > > > > > > > > +{
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_b=
ackend *backend;
> > > > > > > > > > +
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backend =3D =
devm_kzalloc(parent, sizeof(*backend),
> > > > > > > > > > GFP_KERNEL);
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > No error checking.
> > > > > > > > >=20
> > > > > > > > > I guess a lot of cleanings are still missing but the impo=
rtant
> > > > > > > > > thing
> > > > > > > > > I
> > > > > > > > > wanted to
> > > > > > > > > notice is that the above pattern is not ok.
> > > > > > > > > Your 'struct iio_backend *backend'' embeds a 'stuct devic=
e' which
> > > > > > > > > is
> > > > > > > > > a
> > > > > > > > > refcounted object. Nevertheless, you're binding the lifet=
ime of
> > > > > > > > > your
> > > > > > > > > object to
> > > > > > > > > the parent device and that is wrong. The reason is that a=
s soon as
> > > > > > > > > your
> > > > > > > > > parent
> > > > > > > > > device get's released or just unbinded from it's driver, =
all the
> > > > > > > > > devres
> > > > > > > > > stuff
> > > > > > > > > (including your 'struct iio_backend' object) will be rele=
ased
> > > > > > > > > independentof
> > > > > > > > > your 'struct device' refcount value...
> > > > > > > > >=20
> > > > > > > > > So, you might argue this won't ever be an issue in here b=
ut the
> > > > > > > > > pattern
> > > > > > > > > is still
> > > > > > > > > wrong. There are some talks about this, the last one was =
given at
> > > > > > > > > the
> > > > > > > > > latest
> > > > > > > > > EOSS:
> > > > > > > > >=20
> > > > > > > > > https://www.youtube.com/watch?v=3DHCiJL7djGw8&list=3DPLbz=
oR-pLrL6pY8a8zSKRC6-AihFrruOkq&index=3D27&ab_channel=3DTheLinuxFoundation
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > This is a good point. Thanks for pointing it out. Sure, the=
re are
> > > > > > > > still
> > > > > > > > many things to improve.
> > > > > > > >=20
> > > > > > > > I have seen the comment from Jonathan on your "Add converte=
r
> > > > > > > > framework"
> > > > > > > > serie. I had a quick look at the serie. It seems that we sh=
are the
> > > > > > > > need
> > > > > > > > to aggregate some IIO devices. But I need to read it more c=
arefully
> > > > > > > > to
> > > > > > > > check if we can find some convergences here.
> > > > > > >=20
> > > > > > > Yeah, In my case, the backend devices are typically FPGA soft=
 cores and
> > > > > > > the
> > > > > > > aggregate
> > > > > > > device might connect to multiple of these backends. That was =
one of the
> > > > > > > reason why I
> > > > > > > used the component API where the aggregate device is only con=
figured
> > > > > > > when
> > > > > > > all the
> > > > > > > devices are probed. Similarly, when one of them is unbind, th=
e whole
> > > > > > > thing
> > > > > > > should be
> > > > > > > torn down. Also, in my case, the frontend device needs to do =
a lot of
> > > > > > > setup
> > > > > > > on the
> > > > > > > backend device so the whole thing works (so I do have/need a =
lot more
> > > > > > > .ops).
> > > > > > >=20
> > > > > > > Anyways, it does not matter much what the backend device is a=
nd from a
> > > > > > > first
> > > > > > > glance
> > > > > > > and looking at the .ops you have, it seems that this could ea=
sily be
> > > > > > > supported in the
> > > > > > > framework I'm adding. The only things I'm seeing are:
> > > > > >=20
> > > > > > Thanks for your feedback. Yes, my feeling is that the API I nee=
d for the
> > > > > > dfsdm use case, can be covered by the API you propose. I'm not =
familiar
> > > > > > with component API however, as I discovered it in your serie. I=
t is not
> > > > > > clear for me how this affects device tree description of the ha=
rdware.
> > > > >=20
> > > > > Your aggregate device (that we can think of as a frontend device =
needs to
> > > > > properly reference all the backends it needs - in your case I gue=
ss it's
> > > > > just
> > > > > one device). The dts properties I have for now are 'converters' a=
nd
> > > > > 'converter-
> > > > > names'. But one thing that starts to become clear to me is that I=
 should
> > > > > probably change the name for the framework. Maybe industrialio-ag=
gregate.c
> > > > > if we
> > > > > keep the component API (and so the same frontend + backend naming=
) or just
> > > > > industrialio-backend.c (as you have now) if we go with a typical =
OF lookup.
> > > > >=20
> > > >=20
> > > > In my case I have a digital filter peripheral (frontend) linked to
> > > > several sigma delta converters (backends). So, here 'converters'
> > > > property may be relevant as well. But I agree that a more generic n=
ame
> > > > seems better for the long term.
> > > >=20
> > > > My backend devices need to get a regulator phandle from the device =
tree.
> > > > It seems that the component API does not offer services allowing to
> > > > retrieve DT properties for the sub-devices. Tell me if I'm wrong, b=
ut I
> > > > think this constraint require to change converter framework to a ty=
pical
> > > > OF lookup.
> > > >=20
> > > > Could you please share the structure of your DT for your ad9476 bas=
ed
> > > > example ? This will help me identify the gaps regarding my need.
> > > >=20
> > >=20
> > > I might be missing something but there should be no limitation in the=
 component
> > > stuff for this. Note your frontend/backend devices are just normal de=
vice tree
> > > nodes (meaning that they can have all the properties they want as a n=
ormal
> > > node)
> > > and then in the correspondent drivers you handle all the properties. =
For now,
> > > the only FW properties supported in the framework I sent are 'convert=
ers' and
> > > 'converter-name' which will be used to "create" the aggregate device.=
 This
> > > pretty much means that the complete thing should only come up when al=
l the
> > > devices you set in DT probe.
> > >=20
> > > Of course we can move more properties into the framework if we start =
to see
> > > some
> > > generic ones that are almost always present...
> > >=20
> > > One thing that Jonathan already mentioned is that the component API w=
orks in a
> > > away that you can have either 1->1 or 1->N (frontends->backends). So,=
 if you
> > > have setups where you have more than one frontend (basically M->N) we=
 need to
> > > make sure it still works. In theory (in the component API), I think y=
ou can
> > > have
> > > one backend associated with more than one frontend so we should be ab=
le to
> > > still
> > > get the M->N topology. Of course the "communications link" is always =
between
> > > frontend -> backend.
> > >=20
> > > I'll see if I send the devicetree over the weekend (don't have it in =
my current
> > > machine)
> > >=20
> > >=20
> >=20
> > Here it goes the 2 nodes of interest in my testing...
> >=20
> > adc_ad9467: ad9467@0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ad=
9467";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&rx_dma 0>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "rx";
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi-max-frequency =3D =
<10000000>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,spi-3wire-enable;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clk_ad951=
7 3>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "adc-c=
lk";
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 converters =3D <&cf_ad=
9467_core_0>;
> > };
> >=20
> > cf_ad9467_core_0: cf-ad9467-core-lpc@44a00000 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ax=
i-adc-10.0.a";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44A00000 0x=
10000>;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 16>;
> > };
> >=20
> > Naturally, converter-names only makes sense when you have more than one=
 backend.
> > But
> > see that in 'cf_ad9467_core_0', you are free to place a regulator (as I=
 have a
> > clock)
> > as long as you handle it in the backend driver.
> >=20
> > - Nuno S=C3=A1
>=20
> Thanks for the example. This helped me prototyping a dfsdm driver based=
=20
> on the converter framework. Regarding device tree and driver update this=
=20
> looks fine. I could integrate the API smartly in my frontend (dfsdm) and=
=20
> backend (sd modulator).
>=20
> My prototype executes up to probe. I have noticed however that init=20
> (backend & frontend) ops are not called in my implementation. I can see=
=20
> that init ops are called from bind ops. component_bind_all() calls=20

Note that you need to call converter_frontend_add() from your frontend devi=
ce (stm32-
dfsdm-adc) probe function and converter_add() from your backend's probes. A=
nd
ideally, this is the only thing you do at probe. Then, once all the element=
s are
probed, the complete aggregate device is initialised and the .bind()/.init(=
) function
should be called.

And I want to reinforce the above, in the component API, things will only c=
ome up
when all the pieces (all the converters you specified in DT) are probed. Th=
e same is
true if one of the elements is unbound from it's driver - all the other ele=
ments in
the aggregate device will be torn down and converter_frontend_unbind() will=
 be
called. This means it's an all or nothing solution... Let me know if this d=
oes not
work for you.

> converter bind ops, but component_bind_all() is called from converter=20
> bind ops. So, I don't understand how initialization can proceed with=20
> these circular calls. Maybe I missed something here.
>=20

This one I'm not following... component_bind_all() should be called from
converter_frontend_bind() and this will call all converter_bind() you have =
(depends
on how many backends you have). After all backends are initialized, .fronte=
nd_init()
is called. In there, if you need (most likely you do) an handle to a conver=
ter you
then need to call converter_get(). So, component_bind_all() should not be c=
alled from
converter bind ops but from frontend_component_ops which are the
component_master_ops. If this is not happening, then we have an issue :)

> The change in the DT has an impact (But moderated) on legacy. Breaking=
=20
> the legacy was unavoidable anyway.
>=20
> DFSDM legacy binding (with two channels)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dfsdm_pdm1: filter@1 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "st,stm32=
-dfsdm-adc";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st,adc-channels =3D <2 3=
>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st,adc-channel-types =3D=
 "SPI_R", "SPI_R";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io-channels =3D <&sd_adc=
2 &sd_adc3>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> DFSDM binding with converter fw
> =C2=A0=C2=A0=C2=A0=C2=A0 dfsdm_pdm1: filter@1 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "st,stm32=
-dfsdm-adc";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st,adc-channels =3D <2 3=
>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st,adc-channel-types =3D=
 "SPI_R", "SPI_R";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 converters =3D <&sd_adc2=
 &sd_adc3>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> I have also the aim to change DFSDM bindings to use IIO generic channels=
=20
> bindings (bindings/iio/adc/adc.yaml).
>=20
> Ideally the DFSDM bindings should looks like this:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dfsdm_pdm1: filter@1 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "st,stm32=
-dfsdm-adc";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel@2 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <2>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st,adc-channel-types =3D "SPI_R";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 converters =3D <&sd_adc2>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel@3 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <3>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st,adc-channel-types =3D "SPI_R";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 converters =3D <&sd_adc3>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> But it seems that current framework converter API cannot support this=20
> topology.
>=20

Indeed this won't work and I honestly it never crossed my mind ehehe,

> As a fallback solution the following binding may be adopted
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dfsdm_pdm1: filter@1 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "st,stm32=
-dfsdm-adc";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel@2 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <2>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st,adc-channel-types =3D "SPI_R";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel@3 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <3>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st,adc-channel-types =3D "SPI_R";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 converters =3D <&sd_adc2=
 &sd_adc3>;
>=20
> In this case the frontend driver needs a mean to map backend and=20
> channels. It's not the smartest solution, yet. Especially since the use=
=20
> of generic channel is quite common.

Yeah, I'm also not a fan of that... To support the above topology and from =
the top of
my head we could either:

1) Somehow split converter_frontend_add() to give more control to the calle=
r to call
converter_frontend_add_matches() and in this case have another API that acc=
epts a
fwnode.

2) Just extend converter_frontend_add_matches() so that we also look into c=
hild nodes
for 'converters'

Then, on the get() side, we would need something like converters_get_from_f=
wnode() to
get each handle. I would likely prefer to go with 2) because 1) already imp=
lies some
FW parsing during probe that I would like to avoid.

Anyways the above is already showing that maybe going with the component AP=
I for
something more generic might be a stretch and harder to scale for everyone =
needs.
With an OF lookup, the above topology would be easier to accomplish (though=
 we would
always need a converters_get_from_fwnode() kind of function).

When you say:=C2=A0

"In this case the frontend driver needs a mean to map backend and channels.=
"

Could 'converter-names' be used for the above? Or would the above be trivia=
l with an
OF lookup?

> Perhaps the converter_frontend_add() API needs to be extended to support=
=20
> generic channel configuration. Maybe the IIO core should provide the=20
> related helpers as well. (As far as I know this does not exists).
> So, still opened questions ..
>=20

No sure what do you mean by the above?

> That said, I feel confident that the converter framework is a good=20
> option for the DFSDM use case.
>=20

Yeah, I'm also confident that we can get something that suits both our usec=
ases
either with OF or component. I must say that I'm tempted to send a version =
of this
with an OF lookup just so we get a look on how it would look like and compa=
re against
the component API.

- Nuno S=C3=A1
> > >=20
