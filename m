Return-Path: <linux-kernel+bounces-77900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE8860BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C6B285AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15E18028;
	Fri, 23 Feb 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9Yeb5G2"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D74168B9;
	Fri, 23 Feb 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675804; cv=none; b=GQSaWIQ/oarB33DUansVYhNZolNHD5wpHnVDobVMHvwyrbXd83Vq6RZj9JDVTwzjXwWNgweCG8AI12BahFSVycoQJUEf9tbu4zNdrZGoIWSJt6Eh3VFUW6xqI41/HqMWHWh3580+kkMtNNz0MoHnOCHW7ja0bWWqAMyzBxUjGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675804; c=relaxed/simple;
	bh=QBWjYeQUn5RBEXUZgv6ZjZLyYZAviiW5C+QMhB89YFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IyjfzoB8f+YhUUYYyrypIQp1t/ugZl5Pop4fn8tN5mIyWmU/ZvSk6xw71KwSSPZ4fT5HV1exibO35q9z8myDZLU6FkoUACmIXCuFraAyErRQRLsWqirCMLbCcu6AdQO40DKotCjKC0d6M79+SpkYKyAUqC7QeqAetKV/PiHLJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9Yeb5G2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so627184a12.0;
        Fri, 23 Feb 2024 00:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708675801; x=1709280601; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBWjYeQUn5RBEXUZgv6ZjZLyYZAviiW5C+QMhB89YFY=;
        b=T9Yeb5G2hWxJ+xDlP9BUSd5C+kwI2JVpF6Vpn5wTpwMhp1x7HZ1DcimV4l64a7kAvo
         U0UROXiGqAla0E/jVVaIU4Lf9Zbgz41oelwhxJM0HvpUVQIqpNdBMOHv0xajjq/Xdvw1
         uB0D1e9jAa7i7zHRnPKi7zQmSQC9XGIF2DijpcGSnGlVVBCK1IdDVg5Elv14d/c/zDNl
         QfG4LvY8j3ZOX8FKaUPArjCosb4oHRHNgQM06a54RPUtoLSIKzI9U5k2ZhZwr2gVyLB4
         gnR69dxx+1l+WbFQqIS8fimKGDueW+lsmRJr0rM0ARnQ0L6c6rfNkpkJ+A6u7tDI4f9F
         Ck8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708675801; x=1709280601;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBWjYeQUn5RBEXUZgv6ZjZLyYZAviiW5C+QMhB89YFY=;
        b=MUt3l2+9R+NyBQJzXRTLIX6Gx4VLeISTxhwDZAEolY8PBwxSG4dBBdGwiOQzoOR0es
         kOuyoHNAsZVqWh+ok6WbUoWur7g+N8gEAPbL2oxe6eguzbtv+FdSxDsREadXlnQFw1Is
         0tetIB8iqf/JZ6Xsp6VlNRy8W5YnJ9riI0WTq0gvSSFqANAsrM5dLOTTfRjZo89wrIBq
         NOgZLGLhydUszbl6zs8wcQCeSFIqC1BV0RZwgkoxp76E62YQlIw1nDgnD8Q8xaHVMSiP
         MreScn+UHB08ucsZCSQ/4wki+/e/9Vi1X22Y/2Si4Fxs8dMLf2D2JfQDVbtTPTKJ78sU
         W91Q==
X-Forwarded-Encrypted: i=1; AJvYcCWF3PwQQTJyrDo3G3jVSLet+iKcI8hyTmkkIuceqAIRSJ4swiB/h1gnerJryzK9p/o8L6iPNctsKeO+u4E2usc50OD2EhVXp80YL0iawFNMR95Pezr5RPwBys9naELInrwQO/0pS8mYWQ==
X-Gm-Message-State: AOJu0YxUjbdBsqoXCtK+gDrciNrWBvhbG/Pt6/j9ilV2Mc/s99HJsTr/
	PKGLF2UUh2ESBlABhWpRcEb+zLbwRADS3hdVw9GyhPoTXZoNmwPD
X-Google-Smtp-Source: AGHT+IH6/tmIKUpLllg396Dn5rOfwaa5kJ99I5fovVYR9bKN2foqm/LQOnMqBq+DgKagJtwBDSwkOw==
X-Received: by 2002:a05:6402:254c:b0:565:6f16:4dab with SMTP id l12-20020a056402254c00b005656f164dabmr802844edb.16.1708675800649;
        Fri, 23 Feb 2024 00:10:00 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id u6-20020aa7d546000000b0056503299e26sm2084780edr.88.2024.02.23.00.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:10:00 -0800 (PST)
Message-ID: <6e6870b37cdd3204bbf54ebce3401b3af13e9131.camel@gmail.com>
Subject: Re: [PATCH 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Lizhi
 Hou <lizhi.hou@amd.com>,  Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Date: Fri, 23 Feb 2024 09:13:21 +0100
In-Reply-To: <CAGETcx9h4=k9XW+jZCw9zcVZruNZLPDQDt_sNZYXc05eQ2_uWQ@mail.gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	 <20231130174126.688486-2-herve.codina@bootlin.com>
	 <CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com>
	 <c4e1092298244c288212e9f6cdbf7c26d0e9d83b.camel@gmail.com>
	 <CAGETcx9h4=k9XW+jZCw9zcVZruNZLPDQDt_sNZYXc05eQ2_uWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-22 at 17:08 -0800, Saravana Kannan wrote:
> On Tue, Feb 20, 2024 at 10:56=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> >=20
> > On Tue, 2024-02-20 at 16:31 -0800, Saravana Kannan wrote:
> > > On Thu, Nov 30, 2023 at 9:41=E2=80=AFAM Herve Codina <herve.codina@bo=
otlin.com>
> > > wrote:
> > > >=20
> > > > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > > introduces a workqueue to release the consumer and supplier devices=
 used
> > > > in the devlink.
> > > > In the job queued, devices are release and in turn, when all the
> > > > references to these devices are dropped, the release function of th=
e
> > > > device itself is called.
> > > >=20
> > > > Nothing is present to provide some synchronisation with this workqu=
eue
> > > > in order to ensure that all ongoing releasing operations are done a=
nd
> > > > so, some other operations can be started safely.
> > > >=20
> > > > For instance, in the following sequence:
> > > > =C2=A0 1) of_platform_depopulate()
> > > > =C2=A0 2) of_overlay_remove()
> > > >=20
> > > > During the step 1, devices are released and related devlinks are re=
moved
> > > > (jobs pushed in the workqueue).
> > > > During the step 2, OF nodes are destroyed but, without any
> > > > synchronisation with devlink removal jobs, of_overlay_remove() can =
raise
> > > > warnings related to missing of_node_put():
> > > > =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2
> > > >=20
> > > > Indeed, the missing of_node_put() call is going to be done, too lat=
e,
> > > > from the workqueue job execution.
> > > >=20
> > > > Introduce device_link_wait_removal() to offer a way to synchronize
> > > > operations waiting for the end of devlink removals (i.e. end of
> > > > workqueue jobs).
> > > > Also, as a flushing operation is done on the workqueue, the workque=
ue
> > > > used is moved from a system-wide workqueue to a local one.
> > >=20
> > > Thanks for the bug report and fix. Sorry again about the delay in
> > > reviewing the changes.
> > >=20
> > > Please add Fixes tag for 80dd33cf72d1.
> > >=20
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > ---
> > > > =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++=
+++++---
> > > > =C2=A0include/linux/device.h |=C2=A0 1 +
> > > > =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index ac026187ac6a..2e102a77758c 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > > > =C2=A0static void __fw_devlink_link_to_consumers(struct device *dev=
);
> > > > =C2=A0static bool fw_devlink_drv_reg_done;
> > > > =C2=A0static bool fw_devlink_best_effort;
> > > > +static struct workqueue_struct *fw_devlink_wq;
> > > >=20
> > > > =C2=A0/**
> > > > =C2=A0 * __fwnode_link_add - Create a link between two fwnode_handl=
es.
> > > > @@ -530,12 +531,26 @@ static void devlink_dev_release(struct device
> > > > *dev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It may take a wh=
ile to complete this work because of the SRCU
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization =
in device_link_release_fn() and if the
> > > > consumer or
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get =
deleted when it runs, so put it into the
> > > > "long"
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get =
deleted when it runs, so put it into the
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * dedicated workqueue.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &l=
ink->rm_work);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(fw_devlink_wq, &li=
nk->rm_work);
> > >=20
> > > This has nothing to do with fw_devlink. fw_devlink is just triggering
> > > the issue in device links. You can hit this bug without fw_devlink to=
o.
> > > So call this device_link_wq since it's consistent with device_link_* =
APIs.
> > >=20
> >=20
> > I'm not sure if I got this right in my series. I do call
> > devlink_release_queue() to
> > my queue. But on the Overlay side I use fwnode_links_flush_queue() beca=
use
> > it looked
> > more sensible from an OF point of view. And including (in OF code)
> > linux/fwnode.h
> > instead linux/device.h makes more sense to me.
> >=20
> > > > =C2=A0}
> > > >=20
> > > > +/**
> > > > + * device_link_wait_removal - Wait for ongoing devlink removal job=
s to
> > > > terminate
> > > > + */
> > > > +void device_link_wait_removal(void)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devlink removal jobs =
are queued in the dedicated work queue.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To be sure that all r=
emoval jobs are terminated, ensure that
> > > > any
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * scheduled work has ru=
n to completion.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drain_workqueue(fw_devlink_wq=
);
> > >=20
> > > Is there a reason this needs to be drain_workqueu() instead of
> > > flush_workqueue(). Drain is a stronger guarantee than we need in this
> > > case. All we are trying to make sure is that all the device link
> > > remove work queued so far have completed.
> > >=20
> >=20
> > Yeah, I'm also using flush_workqueue().
> >=20
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > > +
> > > > =C2=A0static struct class devlink_class =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "devlink",
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_groups =3D devlink_=
groups,
> > > > @@ -4085,9 +4100,14 @@ int __init devices_init(void)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_dev_char_kobj =3D =
kobject_create_and_add("char", dev_kobj);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sysfs_dev_char_kobj=
)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto char_kobj_err;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fw_devlink_wq =3D alloc_workq=
ueue("fw_devlink_wq", 0, 0);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!fw_devlink_wq)
> > >=20
> > > Fix the name appropriately here too please.
> >=20
> > Hi Saravana,
> >=20
> > Oh, was not aware of this series... Please look at my first patch. It
> > already has a
> > review tag by Rafael. I think the creation of the queue makes more sens=
e to
> > be done
> > in devlink_class_init(). Moreover, Rafael complained in my first versio=
n
> > that
> > erroring out because we failed to create the queue is too harsh since
> > devlinks can
> > still work.
>=20
> I think Rafael can be convinced on this one. Firstly, if we fail to
> allocate so early, we have bigger problems.

That's true...

>=20
> > So, what we do is to schedule the work if we have a queue or too call
> > device_link_release_fn() synchronously if we don't have the queue (note=
 that
> > failing
> > to allocate the queue is very unlikely anyways).
>=20
> device links don't really work when you synchronously need to delete a
> link since it always uses SRCUs (it used to have a #ifndef CONFIG_SRCU
> locking). That's like saying a code still works when it doesn't hit a

Hmm, can you elaborate please? Why wouldn't it work if we call it synchrono=
usly?
Sure, we'll have the synchronize_srcu() call which might take some time but=
 I'm
not honestly seeing what could go wrong other than waiting?

I can also see that we can potentially hold the devlink lock for some time =
but
can that lead to any deadlock (It would actually be nice - if doable at all=
 - to
not release the refcounts with a lock hold)?
> deadlock condition.
>=20
> Let's stick with Herve's patch series since he send it first and it
> has fewer things that need to be fixed. If he ignores this thread for

Not exactly true :). If you look at my reply in the other thread (my series=
)
you'll see that I actually sent it first (as RFC - and spotted the issue wa=
y
back in May last year). About the stuff to fix, not sure if it's more. For =
now,
your major complain seems to be about synchronously calling=20
device_link_release_fn() and I did not had it in my v1. But anyways, I just=
 want
a fix for this to land as quick as possible :)=C2=A0

And I guess we also need Rafael to agree in erroring if we fail to allocate=
 the
queue as he was against it.

- Nuno S=C3=A1


