Return-Path: <linux-kernel+bounces-95535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ABC874F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7AB1F24747
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA2912B14C;
	Thu,  7 Mar 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeaVX8Pz"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624B12AAE5;
	Thu,  7 Mar 2024 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814564; cv=none; b=BKgLETGatcfaBI6FMMER5iQAoCRT5aCib29DMlJFlqdCGpskyb7Tx9fxfnuauX/uwh5qJO/DZKM/sbl3G8A42lLv24/f7ZZaCTak8NuqinOEJKGjIMaIXB5kzOTW4o4S6haKhVN3p6fInJV9df0iK9KBYd/7CZC5P9IYl4ryyOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814564; c=relaxed/simple;
	bh=TXEiZlFrI3O3jEy5Fg8AeV6L0c2a37TvABNwO3/ujww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSvqJ4L5IhlPg/DnngGLgm7LACPGqOz2b4IaASKGGlNQfzJZ6SZ5qYmsiiDQvGUZ5/dezUdCsBb4y2ZYdcvGRrrRLUBzCcku7MHCKAUJfhO5dw6K/A0mZm6QOoxvrq1D/ZCCC0CZfTgnGVp+YLt+XXokfiG+7HiLV+bRNVP10qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeaVX8Pz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512b3b04995so608215e87.3;
        Thu, 07 Mar 2024 04:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709814561; x=1710419361; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i63ZUY7XKpQyXAHueT3y2cbAVNLsMRCCki1KAQkz850=;
        b=FeaVX8Pz2z86Zd8UN4Yk9VOBSa/if4g0MSQf7eaD6o/VOSjOOXC0TwVRGw91GkERsr
         Cd+hdo10vB8JQ5+lVDI1VKhC99uHqqzRJK3iFQLD2KNRJ2CD0fgEjCrtSpNoREFIJ3rb
         Ku83GZxlEphqNHAvn/vsJfsJwhI1PZCqd1HPjOsx/g4L4Flb+ZYlBHdRB0xFsoAI9stp
         6BQze9SSWch2iSIkO/Ff2j+RPNKqwmSY69O7lyCH41hchTHfzge92niYarpjS0qIApR1
         pfGnK5oF7TQONZWxXo6EqGQYe/6UYY+YpV10lkcY8iE95jTR5eFwhXPWlC7mDOG34k82
         sO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709814561; x=1710419361;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i63ZUY7XKpQyXAHueT3y2cbAVNLsMRCCki1KAQkz850=;
        b=UyKny6NVnIkhNtYU2DJRUU820tgmXAjoaYBVW6aVH4YDxW5JSHp0Y7Y4sMW+wtTXvU
         IHDifZ2LLRIXCQhAXLeOdc1NCa1kGqJ7jFW6rg4C5UmAv5Vm/kNapfmT6s4fydFYnmzz
         Q/BStMnNzMMU3X7+4LjtFPCVXWjM98XZ0/pO84KLEN7NgfDy1pvrblLVJfHPMXxrrPOz
         u51bHsFtSTUWDCC/ItX0QnD+NI2wtAbjFFeTCJVzK/T3DnIUSOJfvEPpbr+q0w8VSvlo
         u0qWj1htXc/haKlF+pFnvY4d9jjvLOWnfMZ7OCWh3KmJmCP8RuQHwxeyM8lA3SxTBBzd
         CN5g==
X-Forwarded-Encrypted: i=1; AJvYcCVddjhySDUqtRyVqzRXuGS1mLIQD/pYxUQ9InnNpd1AR/lxFEF8xmTOBj+YTQWMtPWIlDow5xrt60TTpR7Cqf9D2E8vYkOnjQ/b5UrmSd0v+NRRPRq70QsiX/S9i/2GIsw2FwQuSh/VNkhz6QiTJE0LJzb3wHB8krauEw9PMcBhtA==
X-Gm-Message-State: AOJu0Yy2Pb0kIkMhamoCvQR4OoEDYlnpSmCLuxm87XcuznW1c5ZnIQmc
	PV45iyMdayTzbbvpRPAzHlEu8rMwTuPaQsuAWNQshUa01YBczuBp
X-Google-Smtp-Source: AGHT+IHelcR5ZOyVmkbwCwQ8QjJfDVtAw8aDRRZ7Hsnxo1rdcGIXHa1CI9IXIdmB4PvykPUvOGmiQA==
X-Received: by 2002:a05:6512:484e:b0:513:5eb5:625f with SMTP id ep14-20020a056512484e00b005135eb5625fmr1204005lfb.31.1709814560578;
        Thu, 07 Mar 2024 04:29:20 -0800 (PST)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id lo2-20020a170906fa0200b00a45a687b52asm2925721ejb.213.2024.03.07.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:29:20 -0800 (PST)
Message-ID: <c0f7ea40a2b1abc22242a892e162e4511a7c99f1.camel@gmail.com>
Subject: Re: [PATCH v5 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Saravana Kannan <saravanak@google.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Thu, 07 Mar 2024 13:29:19 +0100
In-Reply-To: <20240307131623.467e1def@bootlin.com>
References: <20240307111036.225007-1-herve.codina@bootlin.com>
	 <20240307111036.225007-2-herve.codina@bootlin.com>
	 <94997e8720bc0a68afa85be3ef521c8844d0f0a0.camel@gmail.com>
	 <20240307131623.467e1def@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-07 at 13:16 +0100, Herve Codina wrote:
> Hi Nuno,
>=20
> On Thu, 07 Mar 2024 12:50:52 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > Hi Herve,
> >=20
> >=20
> > On Thu, 2024-03-07 at 12:10 +0100, Herve Codina wrote:
> > > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > introduces a workqueue to release the consumer and supplier devices u=
sed
> > > in the devlink.
> > > In the job queued, devices are release and in turn, when all the
> > > references to these devices are dropped, the release function of the
> > > device itself is called.
> > >=20
> > > Nothing is present to provide some synchronisation with this workqueu=
e
> > > in order to ensure that all ongoing releasing operations are done and
> > > so, some other operations can be started safely.
> > >=20
> > > For instance, in the following sequence:
> > > =C2=A0 1) of_platform_depopulate()
> > > =C2=A0 2) of_overlay_remove()
> > >=20
> > > During the step 1, devices are released and related devlinks are remo=
ved
> > > (jobs pushed in the workqueue).
> > > During the step 2, OF nodes are destroyed but, without any
> > > synchronisation with devlink removal jobs, of_overlay_remove() can ra=
ise
> > > warnings related to missing of_node_put():
> > > =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2
> > >=20
> > > Indeed, the missing of_node_put() call is going to be done, too late,
> > > from the workqueue job execution.
> > >=20
> > > Introduce device_link_wait_removal() to offer a way to synchronize
> > > operations waiting for the end of devlink removals (i.e. end of
> > > workqueue jobs).
> > > Also, as a flushing operation is done on the workqueue, the workqueue
> > > used is moved from a system-wide workqueue to a local one.
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++=
+++---
> > > =C2=A0include/linux/device.h |=C2=A0 1 +
> > > =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index d5f4e4aac09b..48b28c59c592 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > > =C2=A0static void __fw_devlink_link_to_consumers(struct device *dev);
> > > =C2=A0static bool fw_devlink_drv_reg_done;
> > > =C2=A0static bool fw_devlink_best_effort;
> > > +static struct workqueue_struct *device_link_wq;
> > > =C2=A0
> > > =C2=A0/**
> > > =C2=A0 * __fwnode_link_add - Create a link between two fwnode_handles=
.
> > > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *=
dev)
> > > =C2=A0	/*
> > > =C2=A0	 * It may take a while to complete this work because of the SR=
CU
> > > =C2=A0	 * synchronization in device_link_release_fn() and if the cons=
umer or
> > > -	 * supplier devices get deleted when it runs, so put it into the
> > > "long"
> > > -	 * workqueue.
> > > +	 * supplier devices get deleted when it runs, so put it into the
> > > +	 * dedicated workqueue.
> > > =C2=A0	 */
> > > -	queue_work(system_long_wq, &link->rm_work);
> > > +	queue_work(device_link_wq, &link->rm_work);
> > > =C2=A0}
> > > =C2=A0
> > > +/**
> > > + * device_link_wait_removal - Wait for ongoing devlink removal jobs =
to
> > > terminate
> > > + */
> > > +void device_link_wait_removal(void)
> > > +{
> > > +	/*
> > > +	 * devlink removal jobs are queued in the dedicated work queue.
> > > +	 * To be sure that all removal jobs are terminated, ensure that any
> > > +	 * scheduled work has run to completion.
> > > +	 */
> > > +	flush_workqueue(device_link_wq);
> > > +}
> > > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > +
> > > =C2=A0static struct class devlink_class =3D {
> > > =C2=A0	.name =3D "devlink",
> > > =C2=A0	.dev_groups =3D devlink_groups,
> > > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> > > =C2=A0	sysfs_dev_char_kobj =3D kobject_create_and_add("char", dev_kob=
j);
> > > =C2=A0	if (!sysfs_dev_char_kobj)
> > > =C2=A0		goto char_kobj_err;
> > > +	device_link_wq =3D alloc_workqueue("device_link_wq", 0, 0);=C2=A0=
=20
> >=20
> > My rb tag was with the assumption this is moved into devlink_class_init=
(). IIUC,
> > Saravana also agreed with that [1]. But it looks like he missed that we=
 are
> > allocating the queue in devices_init() and not in devlink_class_init().
> >=20
> > I'm also not sure if this is in line with what Rafael wanted for ccing =
stable.
> > How do
> > we know the next patch depends on this one?
> >=20
> > [1]:
> > https://lore.kernel.org/lkml/CAGETcx_gNWOTsSZMaZu+XU1-5Z60WEcMhw08t4Sn_=
-YgkCCUmA@mail.gmail.com/
> >=20
>=20
> We discussed that point and I understood that you were ok to do that on y=
our
> side:
> =C2=A0
> https://lore.kernel.org/linux-kernel/f42ceee61ddb8b50c347589649d4131476ab=
5d81.camel@gmail.com/
>=20
> Sorry if I misunderstood.

Oh, yeah, I can do that. But given Saravana reply I thought the expectation=
 is to
have the queue already allocated in devlink_class_init().

>=20
> I am going to wait for other comments on this current series before re-se=
nding
> with our 'Reviewed-by' removed if needed. Let me know.
>=20

Anyways, if your expectation was for me to do it later, fine. No need to re=
move the
tag. Sorry for the noise.

- Nuno S=C3=A1
>=20


