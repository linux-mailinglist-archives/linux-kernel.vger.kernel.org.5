Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EC078F973
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344203AbjIAIBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjIAIB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:01:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F1010D5;
        Fri,  1 Sep 2023 01:01:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99cdb0fd093so206126866b.1;
        Fri, 01 Sep 2023 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693555282; x=1694160082; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tIsGOpwlLmSZ2KDdmXJKnUAX098byrY4woN1ST2iOSo=;
        b=O8FLaMGsY06HbvOqAOkpBPzuQtVCd6jMCWbYt5p/obuV30lFUoreuC0Yr8UpTF7l6L
         eBd4i4BZ1qSxRIvLhS39n9sNx34c2Ad8rPoXmG/RF/NqTMlq+Lj+l3enZdcLwczh2d9T
         dLxoe/BXEMOPDlltqacpHFYNIsWWAzTdkItpY1SbvlUGmQZf0qY2gdL9FvGjzHObFeBi
         A0l6eQARC5SW6GYlvWShdV71V9eUNIZvK5NFKzgRjpoay5OpB1k2yRub5CKzV6xv0R8A
         /zmvTVIuKi29P4lBzlb3HFYCb4PuvI6tCZ5nn6HMv1BRn/5tQT4V3+ZdngDQtyYWFBvn
         O38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693555282; x=1694160082;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIsGOpwlLmSZ2KDdmXJKnUAX098byrY4woN1ST2iOSo=;
        b=cFvSjhaDxq3PwR8Enx8vGSSzehQDoEhLd2vBTdYhMYAXK3BUi13ipe3kNJKyugf3yj
         wUxtDFWkJ543aO987N1kMhhXbL07DLa53V0yxZZ0PKQ5QYOzRomrgk9Gh/PLMgkBn8sM
         yvLVN/udSB60/hJEjBvyJyn72U/J6pBkkV7zfc5ORwav5wy2RRBVqXBDahzIpzkHnLmS
         oWusdT2rhoGz3fnZamITg1H/O7F/EKwBD5Ov2/pRy4+vUkEh+EL/lfD3r4StGTMGqoY8
         6jVX3UEh73tvMe7zO6Heop08HKh0c8kpzeR4Rz7hSj84wZYsUXlak7qcSLCiA6JybuMk
         kvPA==
X-Gm-Message-State: AOJu0Yy//RtZx5+8AbbmLMLchKHNdWAyXcum27RsUcLQtvK4KQn/bZQ1
        UEccaVIaUbkUw+WXFcM9X00JvpvCibTnDYS6
X-Google-Smtp-Source: AGHT+IGKl8ZEVXDOp+GPYazaVxaAVqoSdhiiaVcrhAVF+Ug6yY8m1NFCYAGSygaZBnbR7BPOEenj9Q==
X-Received: by 2002:a17:906:3291:b0:9a1:fe9c:eee5 with SMTP id 17-20020a170906329100b009a1fe9ceee5mr1301981ejw.63.1693555281833;
        Fri, 01 Sep 2023 01:01:21 -0700 (PDT)
Received: from ?IPv6:2001:a61:3488:8a01:c631:bde5:1eff:9b66? ([2001:a61:3488:8a01:c631:bde5:1eff:9b66])
        by smtp.gmail.com with ESMTPSA id gu18-20020a170906f29200b0098f99048053sm1700886ejb.148.2023.09.01.01.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 01:01:20 -0700 (PDT)
Message-ID: <8b63cad8749ceca31d2f50ee36925ce18523620f.camel@gmail.com>
Subject: Re: [RFC v2 01/11] iio: introduce iio backend device
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Date:   Fri, 01 Sep 2023 10:01:19 +0200
In-Reply-To: <095f9c64-bcac-e838-ba69-b5df623c444f@foss.st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
         <20230727150324.1157933-2-olivier.moysan@foss.st.com>
         <7ec3fe6183409c218b97a3359e951731b47fe16d.camel@gmail.com>
         <095f9c64-bcac-e838-ba69-b5df623c444f@foss.st.com>
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

On Thu, 2023-08-31 at 18:14 +0200, Olivier MOYSAN wrote:
> Hi Nuno,
>=20
> On 7/28/23 10:42, Nuno S=C3=A1 wrote:
> > Hi Olivier,
> >=20
> > On Thu, 2023-07-27 at 17:03 +0200, Olivier Moysan wrote:
> > > Add a new device type in IIO framework.
> > > This backend device does not compute channel attributes and does not =
expose
> > > them through sysfs, as done typically in iio-rescale frontend device.
> > > Instead, it allows to report information applying to channel
> > > attributes through callbacks. These backend devices can be cascaded
> > > to represent chained components.
> > > An IIO device configured as a consumer of a backend device can comput=
e
> > > the channel attributes of the whole chain.
> > >=20
> > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > ---
> > > =C2=A0=C2=A0drivers/iio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0=C2=A0drivers/iio/industrialio-backend.c | 107 ++++++++++++++++=
+++++++++++++
> > > =C2=A0=C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 56 +++++++++++++++
> > > =C2=A0=C2=A03 files changed, 164 insertions(+)
> > > =C2=A0=C2=A0create mode 100644 drivers/iio/industrialio-backend.c
> > > =C2=A0=C2=A0create mode 100644 include/linux/iio/backend.h
> > >=20
> > > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > > index 9622347a1c1b..9b59c6ab1738 100644
> > > --- a/drivers/iio/Makefile
> > > +++ b/drivers/iio/Makefile
> > > @@ -5,6 +5,7 @@
> > > =C2=A0=20
> > > =C2=A0=C2=A0obj-$(CONFIG_IIO) +=3D industrialio.o
> > > =C2=A0=C2=A0industrialio-y :=3D industrialio-core.o industrialio-even=
t.o inkern.o
> > > +industrialio-$(CONFIG_IIO_BACKEND) +=3D industrialio-backend.o
> > > =C2=A0=C2=A0industrialio-$(CONFIG_IIO_BUFFER) +=3D industrialio-buffe=
r.o
> > > =C2=A0=C2=A0industrialio-$(CONFIG_IIO_TRIGGER) +=3D industrialio-trig=
ger.o
> > > =C2=A0=20
> > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industr=
ialio-
> > > backend.c
> > > new file mode 100644
> > > index 000000000000..7d0625889873
> > > --- /dev/null
> > > +++ b/drivers/iio/industrialio-backend.c
> > > @@ -0,0 +1,107 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* The industrial I/O core, backend handling functions
> > > + *
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/device.h>
> > > +#include <linux/property.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/backend.h>
> > > +
> > > +static DEFINE_IDA(iio_backend_ida);
> > > +
> > > +#define to_iio_backend(_device) container_of((_device), struct iio_b=
ackend,
> > > dev)
> > > +
> > > +static void iio_backend_release(struct device *device)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *backen=
d =3D to_iio_backend(device);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend->name);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend);
> > > +}
> > > +
> > > +static const struct device_type iio_backend_type =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.release =3D iio_backend_r=
elease,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "iio_backend_dev=
ice",
> > > +};
> > > +
> > > +struct iio_backend *iio_backend_alloc(struct device *parent)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *backen=
d;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backend =3D devm_kzalloc(p=
arent, sizeof(*backend), GFP_KERNEL);
> > >=20
> >=20
> > No error checking.
> >=20
> > I guess a lot of cleanings are still missing but the important thing I =
wanted to
> > notice is that the above pattern is not ok.
> > Your 'struct iio_backend *backend'' embeds a 'stuct device' which is a
> > refcounted object. Nevertheless, you're binding the lifetime of your ob=
ject to
> > the parent device and that is wrong. The reason is that as soon as your=
 parent
> > device get's released or just unbinded from it's driver, all the devres=
 stuff
> > (including your 'struct iio_backend' object) will be released independe=
ntof
> > your 'struct device' refcount value...
> >=20
> > So, you might argue this won't ever be an issue in here but the pattern=
 is still
> > wrong. There are some talks about this, the last one was given at the l=
atest
> > EOSS:
> >=20
> > https://www.youtube.com/watch?v=3DHCiJL7djGw8&list=3DPLbzoR-pLrL6pY8a8z=
SKRC6-AihFrruOkq&index=3D27&ab_channel=3DTheLinuxFoundation
> >=20
>=20
> This is a good point. Thanks for pointing it out. Sure, there are still=
=20
> many things to improve.
>=20
> I have seen the comment from Jonathan on your "Add converter framework"=
=20
> serie. I had a quick look at the serie. It seems that we share the need=
=20
> to aggregate some IIO devices. But I need to read it more carefully to=
=20
> check if we can find some convergences here.

Yeah, In my case, the backend devices are typically FPGA soft cores and the=
 aggregate
device might connect to multiple of these backends. That was one of the rea=
son why I
used the component API where the aggregate device is only configured when a=
ll the
devices are probed. Similarly, when one of them is unbind, the whole thing =
should be
torn down. Also, in my case, the frontend device needs to do a lot of setup=
 on the
backend device so the whole thing works (so I do have/need a lot more .ops)=
.

Anyways, it does not matter much what the backend device is and from a firs=
t glance
and looking at the .ops you have, it seems that this could easily be suppor=
ted in the
framework I'm adding. The only things I'm seeing are:

1) You would need to use the component API if it's ok. Also not sure if the=
 cascaded
usecase you mention would work with that API.

2) We would need to add the .read_raw() op. If you look at my RFC, I alread=
y have
some comments/concerns about having an option like that (see there).

Having said that, none of the above are blockers as 1), I can ditch the com=
ponent API
in favour of typical FW/OF lookup (even though the component API makes some=
 things
easier to handle) and 2), adding a .read_raw() op is not a blocker for me.

Alternatively, another (maybe crazy) idea would be to have this framework h=
ave the
really generic stuff (like lookup + generic ops) and build my iio-converter=
 on top of
it (extending it). You know, some OO fun :). Maybe not worth the trouble th=
ough.

Let's if Jonathan has some suggestions on how to proceed...

- Nuno S=C3=A1
> >=20

