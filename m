Return-Path: <linux-kernel+bounces-94018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A262D873880
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18945B20E8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811F132C16;
	Wed,  6 Mar 2024 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtTNf9AH"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407BD130E4A;
	Wed,  6 Mar 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734109; cv=none; b=tHGnZSLqQER9N5oxe9SxaMU+ONNPMUFgJuxOuPnMjHOJWv7+SFgtHbxaaVSdCHUztEIo8JkPV0jKYiTyZsn7vhNRl1uWSP3XzlpHqTwUpuhcyG2ZAa4XzLXuUmOUDp/gMThU+gSCW9fKgWkt9qcIBO95rPOKuomfxIrjr40+pK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734109; c=relaxed/simple;
	bh=SoC1j48yTKipJvPrs9pdIYXOSX3FkBcek9RtYK9AqLU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JXw/KESUrmha5rz5DEoPqjlGCJironcnP6xg164er9kS+CKIdkSxoItSqnf/qlNIBnY0QGtGUfhv36Q7IGDdgN+rzM/XNhFxKL6ekJa87UaC4nPj1lwDnzqa367xSVy0uIC/1F94AdKT23g8ry3uOZlJnB7H5bHlydCVx63bxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtTNf9AH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5673b5a356eso2253343a12.0;
        Wed, 06 Mar 2024 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709734105; x=1710338905; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SoC1j48yTKipJvPrs9pdIYXOSX3FkBcek9RtYK9AqLU=;
        b=PtTNf9AHAEha2525CWrbnJhxrBFBIO1ThUAXkVtRqJ2L/sF4XoAXuUJwNhg5zRvhQz
         QxSU9A30FXbEO541Fr/nnr+JbzeVicxVnLcavDkad1Sl2mGMPqIVBr91qcOXGKXPcYVS
         RDF5+0GrNx8D3pDifR/dQ5bS8/HtUnzvwfzu4aD++BduVSNN8jBXmPqhjy8Ufkg2HVeT
         naR4NcYr48cmb1YIHuhfIDBQVi/uUzSBaEKDzsn18/q7rJfgzTMNfDO0Y7QA8ipoJrb8
         LsUd0TKrU7bAYsOpQqiq7Om8vy/BuOiGaUcjpIOgOE+aCZ1my9wCsLPv6O17GEOYOtct
         qvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709734105; x=1710338905;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SoC1j48yTKipJvPrs9pdIYXOSX3FkBcek9RtYK9AqLU=;
        b=W1vkOc3IaHabC53J3yYtZOrOk8zbC0ymcxnvhAmTNDay6evlmTWe7Cae+t3vM0vKQ/
         rQ4hMadK8RA2oUG8SJj8AO5lVa2XImBcdqmCGP1A6I+zPRfhMCnE8fqDsTFHfaph9Hgr
         pOeEYFHcqr83FEG9Bc5q+dTZ6vGX/0pM7gqIjxxdSQJrWxw1tZGzTJg+hXu8HQLHAMgg
         7jgZfQfeOpX4hR2/TCkuNsGA2vQp3UKVaTH5aYMozg0rozNsMkhlR2C2AeLknsXCPrWJ
         zG0bZX6gftEbqW7jzSY4Odu3V7LNhyd5pZ7KD6MAZIyVJYUxWS1aS33x8KwsO2DketE8
         j6bw==
X-Forwarded-Encrypted: i=1; AJvYcCV73GV96CHl8/a/A/m32tjzk5XdCBp0HGdBAr4q2f5FBvglE6lfaEkoDWnsHdpuHK66s171KurpIon+5Q4kGktDt8uaM5fSrrnOR70cpMxlKusr1Kur34WbZNkob3wpeXkx2CDTi+O8FC5mHzV4LnucgZo14dycLx3hsUYEejVx8A==
X-Gm-Message-State: AOJu0Yx6mom9mWtfXuJAKWZHa3eQDKfo3uxVqIRYQAMrReJNC69YToOu
	vo1y27fA7kmCa3HFEu0dIynkOzK3+8UeZme27RBLI44f/mh8h7yX
X-Google-Smtp-Source: AGHT+IH3Qu5XdLUd/GX1N21KjgkQdDBgTwXz0wQbJ34SGNBwbdysHcduprogf2BSKWsqCdfEkdt29w==
X-Received: by 2002:a50:9b1b:0:b0:567:a8f7:2233 with SMTP id o27-20020a509b1b000000b00567a8f72233mr2520555edi.40.1709734105346;
        Wed, 06 Mar 2024 06:08:25 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id b20-20020a0564021f1400b00567fa27e75fsm352802edb.32.2024.03.06.06.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:08:24 -0800 (PST)
Message-ID: <ec7705f410bc848e79b8ab878b5fbf7618d9456d.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Frank
 Rowand <frowand.list@gmail.com>, Saravana Kannan <saravanak@google.com>,
 Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Wed, 06 Mar 2024 15:11:49 +0100
In-Reply-To: <CAJZ5v0iQNEj6e_L1=uBTPaWn7BqV4pnoWxUq7LRPe5iVWsaifw@mail.gmail.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
	 <20240306085007.169771-2-herve.codina@bootlin.com>
	 <1fff8742a13c28dd7e1dda47ad2d6fa8e21e421e.camel@gmail.com>
	 <CAJZ5v0gWCo9nDAHkzeD08tTKoE0DE0ocht-Qq4zA7P59y9KeuQ@mail.gmail.com>
	 <ed442b6916016b3a40782dc32538fc517715db6c.camel@gmail.com>
	 <CAJZ5v0iQNEj6e_L1=uBTPaWn7BqV4pnoWxUq7LRPe5iVWsaifw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-06 at 14:05 +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 6, 2024 at 2:01=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> >=20
> > On Wed, 2024-03-06 at 13:43 +0100, Rafael J. Wysocki wrote:
> > > On Wed, Mar 6, 2024 at 10:17=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gma=
il.com> wrote:
> > > >=20
> > > > On Wed, 2024-03-06 at 09:50 +0100, Herve Codina wrote:
> > > > > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal"=
)
> > > > > introduces a workqueue to release the consumer and supplier devic=
es
> > > > > used
> > > > > in the devlink.
> > > > > In the job queued, devices are release and in turn, when all the
> > > > > references to these devices are dropped, the release function of =
the
> > > > > device itself is called.
> > > > >=20
> > > > > Nothing is present to provide some synchronisation with this work=
queue
> > > > > in order to ensure that all ongoing releasing operations are done=
 and
> > > > > so, some other operations can be started safely.
> > > > >=20
> > > > > For instance, in the following sequence:
> > > > > =C2=A0 1) of_platform_depopulate()
> > > > > =C2=A0 2) of_overlay_remove()
> > > > >=20
> > > > > During the step 1, devices are released and related devlinks are
> > > > > removed
> > > > > (jobs pushed in the workqueue).
> > > > > During the step 2, OF nodes are destroyed but, without any
> > > > > synchronisation with devlink removal jobs, of_overlay_remove() ca=
n
> > > > > raise
> > > > > warnings related to missing of_node_put():
> > > > > =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2
> > > > >=20
> > > > > Indeed, the missing of_node_put() call is going to be done, too l=
ate,
> > > > > from the workqueue job execution.
> > > > >=20
> > > > > Introduce device_link_wait_removal() to offer a way to synchroniz=
e
> > > > > operations waiting for the end of devlink removals (i.e. end of
> > > > > workqueue jobs).
> > > > > Also, as a flushing operation is done on the workqueue, the workq=
ueue
> > > > > used is moved from a system-wide workqueue to a local one.
> > > > >=20
> > > > > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > > ---
> > > >=20
> > > > With the below addressed:
> > > >=20
> > > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > > >=20
> > > > > =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++=
+++++++---
> > > > > =C2=A0include/linux/device.h |=C2=A0 1 +
> > > > > =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > index d5f4e4aac09b..48b28c59c592 100644
> > > > > --- a/drivers/base/core.c
> > > > > +++ b/drivers/base/core.c
> > > > > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > > > > =C2=A0static void __fw_devlink_link_to_consumers(struct device *d=
ev);
> > > > > =C2=A0static bool fw_devlink_drv_reg_done;
> > > > > =C2=A0static bool fw_devlink_best_effort;
> > > > > +static struct workqueue_struct *device_link_wq;
> > > > >=20
> > > > > =C2=A0/**
> > > > > =C2=A0 * __fwnode_link_add - Create a link between two fwnode_han=
dles.
> > > > > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct devi=
ce
> > > > > *dev)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It may take a while to com=
plete this work because of the SRCU
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization in device_=
link_release_fn() and if the
> > > > > consumer
> > > > > or
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get deleted wh=
en it runs, so put it into the
> > > > > "long"
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get deleted wh=
en it runs, so put it into the
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * dedicated workqueue.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &link->rm_wo=
rk);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(device_link_wq, &link->rm_wo=
rk);
> > > > > =C2=A0}
> > > > >=20
> > > > > +/**
> > > > > + * device_link_wait_removal - Wait for ongoing devlink removal j=
obs
> > > > > to
> > > > > terminate
> > > > > + */
> > > > > +void device_link_wait_removal(void)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devlink removal jobs are queued=
 in the dedicated work queue.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To be sure that all removal job=
s are terminated, ensure that
> > > > > any
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * scheduled work has run to compl=
etion.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 flush_workqueue(device_link_wq);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > > > +
> > > > > =C2=A0static struct class devlink_class =3D {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "devlink",
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_groups =3D devlink_groups,
> > > > > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_dev_char_kobj =3D kobject_cr=
eate_and_add("char", dev_kobj);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sysfs_dev_char_kobj)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto char_kobj_err;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 device_link_wq =3D alloc_workqueue("dev=
ice_link_wq", 0, 0);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!device_link_wq)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto wq_err;
> > > > >=20
> > > >=20
> > > > I can't still agree with this. Why not doing it in devlink_class_in=
it()?
> > > > This is
> > > > devlink specific so it makes complete sense to me.
> > >=20
> > > If you do that in devlink_class_init() and it fails, you essentially
> > > cause the creation of every device link to fail.=C2=A0 IOW, you try t=
o live
> > > without device links and pretend that it is all OK.=C2=A0 That won't =
get
> > > you very far, especially on systems where DT is used.
> > >=20
> > > Doing it here, if it fails, you prevent the driver model from working
> > > at all (because one of its necessary components is unavailable), whic=
h
> > > arguably is a better choice.
> >=20
> > That makes sense but then the only thing I still don't fully get is why=
 we
> > have
> > a separate devlink_class_init() initcall for registering the devlink cl=
ass
> > (which can also fail)...
>=20
> Well, I haven't added it. :-)
>=20
> > What I take from the above is that we should fail the
> > driver model if one of it's fundamental components fails so I would say=
 we
> > should merge devlink_class_init() with device_init() otherwise it's a b=
it
> > confusing (at least to me) and gives the idea that it's ok for the driv=
er
> > model
> > to exist without the links (unless I'm missing some other reason for th=
e
> > devlink
> > init function).
>=20
> +1
>=20
> Feel free to send a patch along these lines, chances are that it will
> be popular. ;-)

I was actually thinking about that but I think I encountered the reason why=
 we
have it like this... devices_init() is called from driver_init() and there =
we
have:

..

devices_init();
buses_init();
classes_init();

..

So classes are initialized after devices which means we can't really do
class_register(&devlink_class) from devices_init(). Unless, of course, we r=
e-
order things in driver_init() but that would be a questionable change at th=
e
very least.

So, while I agree with what you've said, I'm still not sure if mixing devli=
nk
stuff between devices_init() and devlink_class_init() is the best thing to =
do
given that we already have the case where devlink_class_init() can fail whi=
le
the driver model is up.

- Nuno S=C3=A1


