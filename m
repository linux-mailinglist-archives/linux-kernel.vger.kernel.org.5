Return-Path: <linux-kernel+bounces-94083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1524A8739AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389D71C20CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA8D13440C;
	Wed,  6 Mar 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpzXnhii"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6991130E3F;
	Wed,  6 Mar 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736443; cv=none; b=GJywSGW0w2L01NiKGo/TNBI24BNCpEKn35qijUB/KPedwRyJBc+CNMFhv+ZJCmcA/wI/7KiPfreWtNvBVNaELMvuRc4H7SwKfbw2TT8mhDT4nAMd5jjsJD9EPOCaMOdMJp/700aE+3JGKs7YbJNavkmhyCddw/xJZ+MbAL8t/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736443; c=relaxed/simple;
	bh=8IWxzcon7ZLnqHGJwaHZCtPJ1y34lrDolQpndiRroaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fO3SKQF69clSAOrW3gqc1EcCxxK2z3PU/Mj4vz1qVeSjhsmIrPaHJHZeMDqHSbKKvsel9RelLAuI6brJPaP5d3faT4NpNlEGaDfuT+XqiAQm2sBz5xbuZ4IGW2dZpc0ggtJOPDvul32ABqSbHM39LMfGX6hDMNq2IY+lmTpDLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpzXnhii; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512e39226efso7021542e87.0;
        Wed, 06 Mar 2024 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736440; x=1710341240; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8IWxzcon7ZLnqHGJwaHZCtPJ1y34lrDolQpndiRroaw=;
        b=FpzXnhiiaEpIypFptvnhtVoUa70mwHFbab20fWTj4wq/iPgmHuYqhqsj/MaiwnJO14
         pZ5myGDKJHis9jRERJk6hcss7qB2V47JsDm09v3y34z9Tol3pw3bmxgp3xwv3Q/GPrxt
         KhaePP9sZewNxrj/yK2UDjh9GgD4jsNQmgxgGGSUyWqbK40qIH20qZMrO38pcHzr/If3
         RhqzkX7SHv9y4MBj5w+STvrM0rjy7jgiZWHu6Pjs/hsjXcP79XjM3v6IHa0vuPfkAxbr
         3gNZG5Ykxe0DXrNZMFaw6CLgPYyY3Cl576Zx9tEmi2U4HCKnfA+y7rLb+ZkqBlhtl+xl
         eNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736440; x=1710341240;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IWxzcon7ZLnqHGJwaHZCtPJ1y34lrDolQpndiRroaw=;
        b=xQzZgJPRAILjy8Vaa2RV9NWsLFp6SR/k7485xnAhw85D2GCrG3f7VJ88arcgYCAsBG
         /YWaGkqQK4b3MP0GUq1anrT8MBV3Bx1cY3rEEsXU8N/f+PvUZbB0je/ZvfKOykciR+Y9
         7HyiSSm56mhaj8X3iGDkA5Yn9EvXzSj8pHU2gp+ldR77oaHjgy7pFDMKvYZHsrPPlCiv
         DAFUx4ML4B1AZiSnLf1kLnB4jMw3TXAzEiQR8SqWwOR1HaP4q4VGfIRz5bh25H3iU444
         MdZBWHG+gluijexBGVHKzwh29z2KIuCifxoMeng9eKd1rUMgrgJt3zaNowYDUZ6p5QIQ
         2ozw==
X-Forwarded-Encrypted: i=1; AJvYcCVr+/dtkn/A+dr/xKgmNnW7D6w2PDrIRLatuK35c9q3BCDQgaXczWsQozGsvI8OLAhUkJuidBRgSw/YgYHJcaEY3oCj2ivRb5idGUIb59leNCGa7Jdl5o0qDM9LmVU+la9wmqJnCw3SDmD4uoLzYPsJTFWPjwtBCeIgU2AHc7xTMw==
X-Gm-Message-State: AOJu0Yyhie6ue3eqrcS+3okAhMMSmaGe9RVY3lHM6Tr9FPlXmcyRYGhQ
	UFBhJncP6UKRJAei5LwPmbUzV5x9jN/jkS4DvlX6DrJ1nmhyVRF6
X-Google-Smtp-Source: AGHT+IF8ySziMft1gXf9sjEul/cXm88GkXaidWXFRg4tBpn2f4KEQdMbytqx0WQYJG4ReYZYy9JQsg==
X-Received: by 2002:ac2:43c9:0:b0:511:a4c9:a010 with SMTP id u9-20020ac243c9000000b00511a4c9a010mr3161979lfl.38.1709736439557;
        Wed, 06 Mar 2024 06:47:19 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id am19-20020a170906569300b00a44cb0bf11bsm5258138ejc.79.2024.03.06.06.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:47:19 -0800 (PST)
Message-ID: <86a0f91675197a00bbd921d6e57d2f3c57796e68.camel@gmail.com>
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
Date: Wed, 06 Mar 2024 15:50:44 +0100
In-Reply-To: <CAJZ5v0iMUOJmm99H6SgfP9179hBsLdyC+1ixJwBxSP0b18V6XA@mail.gmail.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
	 <20240306085007.169771-2-herve.codina@bootlin.com>
	 <1fff8742a13c28dd7e1dda47ad2d6fa8e21e421e.camel@gmail.com>
	 <CAJZ5v0gWCo9nDAHkzeD08tTKoE0DE0ocht-Qq4zA7P59y9KeuQ@mail.gmail.com>
	 <ed442b6916016b3a40782dc32538fc517715db6c.camel@gmail.com>
	 <CAJZ5v0iQNEj6e_L1=uBTPaWn7BqV4pnoWxUq7LRPe5iVWsaifw@mail.gmail.com>
	 <ec7705f410bc848e79b8ab878b5fbf7618d9456d.camel@gmail.com>
	 <CAJZ5v0iMUOJmm99H6SgfP9179hBsLdyC+1ixJwBxSP0b18V6XA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-06 at 15:37 +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 6, 2024 at 3:08=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> >=20
> > On Wed, 2024-03-06 at 14:05 +0100, Rafael J. Wysocki wrote:
> > > On Wed, Mar 6, 2024 at 2:01=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmai=
l.com> wrote:
> > > >=20
> > > > On Wed, 2024-03-06 at 13:43 +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Mar 6, 2024 at 10:17=E2=80=AFAM Nuno S=C3=A1 <noname.nuno=
@gmail.com> wrote:
> > > > > >=20
> > > > > > On Wed, 2024-03-06 at 09:50 +0100, Herve Codina wrote:
> > > > > > > The commit 80dd33cf72d1 ("drivers: base: Fix device link remo=
val")
> > > > > > > introduces a workqueue to release the consumer and supplier
> > > > > > > devices
> > > > > > > used
> > > > > > > in the devlink.
> > > > > > > In the job queued, devices are release and in turn, when all =
the
> > > > > > > references to these devices are dropped, the release function=
 of
> > > > > > > the
> > > > > > > device itself is called.
> > > > > > >=20
> > > > > > > Nothing is present to provide some synchronisation with this
> > > > > > > workqueue
> > > > > > > in order to ensure that all ongoing releasing operations are =
done
> > > > > > > and
> > > > > > > so, some other operations can be started safely.
> > > > > > >=20
> > > > > > > For instance, in the following sequence:
> > > > > > > =C2=A0 1) of_platform_depopulate()
> > > > > > > =C2=A0 2) of_overlay_remove()
> > > > > > >=20
> > > > > > > During the step 1, devices are released and related devlinks =
are
> > > > > > > removed
> > > > > > > (jobs pushed in the workqueue).
> > > > > > > During the step 2, OF nodes are destroyed but, without any
> > > > > > > synchronisation with devlink removal jobs, of_overlay_remove(=
) can
> > > > > > > raise
> > > > > > > warnings related to missing of_node_put():
> > > > > > > =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2
> > > > > > >=20
> > > > > > > Indeed, the missing of_node_put() call is going to be done, t=
oo
> > > > > > > late,
> > > > > > > from the workqueue job execution.
> > > > > > >=20
> > > > > > > Introduce device_link_wait_removal() to offer a way to synchr=
onize
> > > > > > > operations waiting for the end of devlink removals (i.e. end =
of
> > > > > > > workqueue jobs).
> > > > > > > Also, as a flushing operation is done on the workqueue, the
> > > > > > > workqueue
> > > > > > > used is moved from a system-wide workqueue to a local one.
> > > > > > >=20
> > > > > > > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal"=
)
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > > > > ---
> > > > > >=20
> > > > > > With the below addressed:
> > > > > >=20
> > > > > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > > > > >=20
> > > > > > > =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++=
+++++++++++---
> > > > > > > =C2=A0include/linux/device.h |=C2=A0 1 +
> > > > > > > =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > > > index d5f4e4aac09b..48b28c59c592 100644
> > > > > > > --- a/drivers/base/core.c
> > > > > > > +++ b/drivers/base/core.c
> > > > > > > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > > > > > > =C2=A0static void __fw_devlink_link_to_consumers(struct devic=
e *dev);
> > > > > > > =C2=A0static bool fw_devlink_drv_reg_done;
> > > > > > > =C2=A0static bool fw_devlink_best_effort;
> > > > > > > +static struct workqueue_struct *device_link_wq;
> > > > > > >=20
> > > > > > > =C2=A0/**
> > > > > > > =C2=A0 * __fwnode_link_add - Create a link between two fwnode=
_handles.
> > > > > > > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct
> > > > > > > device
> > > > > > > *dev)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It may take a while to=
 complete this work because of the
> > > > > > > SRCU
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization in dev=
ice_link_release_fn() and if the
> > > > > > > consumer
> > > > > > > or
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get delete=
d when it runs, so put it into
> > > > > > > the
> > > > > > > "long"
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get delete=
d when it runs, so put it into
> > > > > > > the
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * dedicated workqueue.
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &link->r=
m_work);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(device_link_wq, &link->r=
m_work);
> > > > > > > =C2=A0}
> > > > > > >=20
> > > > > > > +/**
> > > > > > > + * device_link_wait_removal - Wait for ongoing devlink remov=
al
> > > > > > > jobs
> > > > > > > to
> > > > > > > terminate
> > > > > > > + */
> > > > > > > +void device_link_wait_removal(void)
> > > > > > > +{
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devlink removal jobs are qu=
eued in the dedicated work
> > > > > > > queue.
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To be sure that all removal=
 jobs are terminated, ensure
> > > > > > > that
> > > > > > > any
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * scheduled work has run to c=
ompletion.
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 flush_workqueue(device_link_wq);
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > > > > > +
> > > > > > > =C2=A0static struct class devlink_class =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "devlink",
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_groups =3D devlink_groups=
,
> > > > > > > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_dev_char_kobj =3D kobjec=
t_create_and_add("char",
> > > > > > > dev_kobj);
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sysfs_dev_char_kobj)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto char_kobj_err;
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 device_link_wq =3D alloc_workqueue(=
"device_link_wq", 0, 0);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!device_link_wq)
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto wq_err;
> > > > > > >=20
> > > > > >=20
> > > > > > I can't still agree with this. Why not doing it in
> > > > > > devlink_class_init()?
> > > > > > This is
> > > > > > devlink specific so it makes complete sense to me.
> > > > >=20
> > > > > If you do that in devlink_class_init() and it fails, you essentia=
lly
> > > > > cause the creation of every device link to fail.=C2=A0 IOW, you t=
ry to live
> > > > > without device links and pretend that it is all OK.=C2=A0 That wo=
n't get
> > > > > you very far, especially on systems where DT is used.
> > > > >=20
> > > > > Doing it here, if it fails, you prevent the driver model from wor=
king
> > > > > at all (because one of its necessary components is unavailable), =
which
> > > > > arguably is a better choice.
> > > >=20
> > > > That makes sense but then the only thing I still don't fully get is=
 why
> > > > we
> > > > have
> > > > a separate devlink_class_init() initcall for registering the devlin=
k
> > > > class
> > > > (which can also fail)...
> > >=20
> > > Well, I haven't added it. :-)
> > >=20
> > > > What I take from the above is that we should fail the
> > > > driver model if one of it's fundamental components fails so I would=
 say
> > > > we
> > > > should merge devlink_class_init() with device_init() otherwise it's=
 a
> > > > bit
> > > > confusing (at least to me) and gives the idea that it's ok for the
> > > > driver
> > > > model
> > > > to exist without the links (unless I'm missing some other reason fo=
r the
> > > > devlink
> > > > init function).
> > >=20
> > > +1
> > >=20
> > > Feel free to send a patch along these lines, chances are that it will
> > > be popular. ;-)
> >=20
> > I was actually thinking about that but I think I encountered the reason=
 why
> > we
> > have it like this... devices_init() is called from driver_init() and th=
ere
> > we
> > have:
> >=20
> > ...
> >=20
> > devices_init();
> > buses_init();
> > classes_init();
> >=20
> > ...
> >=20
> > So classes are initialized after devices which means we can't really do
> > class_register(&devlink_class) from devices_init(). Unless, of course, =
we
> > re-
> > order things in driver_init() but that would be a questionable change a=
t the
> > very least.
> >=20
> > So, while I agree with what you've said, I'm still not sure if mixing
> > devlink
> > stuff between devices_init() and devlink_class_init() is the best thing=
 to
> > do
> > given that we already have the case where devlink_class_init() can fail
> > while
> > the driver model is up.
>=20
> So why don't you make devlink_class_init() do a BUG() on failure
> instead of returning an error?=C2=A0 IMO crashing early is better than
> crashing later or otherwise failing in a subtle way due to a missed
> dependency.

Well, I do agree with that... Maybe that's something that Herve can sneak i=
n
this patch? Otherwise, I can later (after this one is applied) send a patch=
 for
it.

- Nuno S=C3=A1

