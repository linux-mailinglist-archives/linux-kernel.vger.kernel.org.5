Return-Path: <linux-kernel+bounces-95501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C537874E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE92F1F2114F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92741292F1;
	Thu,  7 Mar 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRlN0nQw"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A14129A98;
	Thu,  7 Mar 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812665; cv=none; b=IP9cX9lILGBkC/7MV1x2EliMd9OCC4d13aXrD0sd1drlL8oK994sPUhZRYwLy53AK+Xm9dJSuj45akqbwJOCEWLwwLzoGO1njBz1QT7frX8Vv9/pZ4hqQz8el5m7p/Qk5BgFbr03+F8Suc/CyKhSvN9+VsH09ubtb59QL02Tv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812665; c=relaxed/simple;
	bh=vDgAX6P28rscWYU/Ap03VR4LmAwylCGv7dAfzgFQieo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AozIskKKZZXiWsz7Owf3q7titoE/vrcFoJJSu9oSJsG/uVcKp3ALGX7M9wX6KUXdavRmg9gf2hOgvd3n7dFcgCeDzL0o1d/a3cLoS9ae50yieXusqvw7w2FXOCBM8dxgxannYklpdn1BVJIZksLcjtLnYIsXvNnMfqe63ja/mCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRlN0nQw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a449c5411e1so107997666b.1;
        Thu, 07 Mar 2024 03:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709812661; x=1710417461; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cJau7i3eV23vAJGOuiZvF0BMLOjfUjwE+0eIoNLgbl4=;
        b=mRlN0nQw8itg1q/+cUV/R6VTcf5ZuqJa6dLHWWYGZc0auVLPYInHtJPTcdB/0ZPXfS
         /c3zje+rUaMqGupgCOhPcJtMX09pjK9tkqIkvjroJ6F2X5uieR669Muu1ABRFHVrxure
         QlFe/b+bNU+EEcRpzV7u+kOc97+FR8BOs8XhtmZFWvE6nZfg4eiUXNGCeqHuj4ijc0K/
         H2/STOfK1+ghxTl9nEU9RPRV5yjc2DvnX9cZSR3Hkw2KjCsmGYt54ZhNW/ceV5wrKOUn
         Sc2RjYcImYIKGhZPIlLagkHEBhUgPEviK63h54DrA/YiJjDvzRyZYU6hv8RY0ppQ5uqZ
         M+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812661; x=1710417461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJau7i3eV23vAJGOuiZvF0BMLOjfUjwE+0eIoNLgbl4=;
        b=N14h/6ixkY3Pott0M/9EvuBzFTjsRiKfxIa0g654qlsCj+9JsZqUUNbCqAXqnpzGUV
         bjzcCgcEDdJ2sjbdbuxB3JLqZ7zv7TQe/hGei6NRJbb/do4If8f023WvTc2ns6TW9Q2p
         jgv5fIBhr2HqpUU7/j8rTHFaNL916VWBRM671cY8rsmw75B0/Cv70MxF+gGSHkCAqgsi
         dDBqx9Zif8OTnIpVxkNyOwHpPb9GbY43y3N/q2gkPDyfFfOKN/M2uLF4ZMProj9d/4iz
         LkN63xEuXCfJnfCn3qdEQaY2mkQYtTFTO6fpf6NH/eW0F4xLXbhnNpAfzY6S/QOw32+2
         YWgw==
X-Forwarded-Encrypted: i=1; AJvYcCUt6hNJy/WC1/PyCHpwiIraYK3dha7U9bZnyxsGes/LRqJdss2EL5ftMIO3tO468srQGO+6W8CM26+bOiRIME187HQm/H9c+1B0/NFvYpiHH4MvkPnEjdAho2hYLBPvsHhViUEa0xh1NgbsmtKmhdqXAFKeVDCZ+2k6FNfCzIP0uw==
X-Gm-Message-State: AOJu0YyEwYaJxVj7+EHo1iLjoY4tPDzwfss9SiRvVHyNbfKS13Q2UZor
	InSNggiuHpo0rLI2nDNWicRs3nNqW290i3g3CYjt9XC2t3iYVUC7
X-Google-Smtp-Source: AGHT+IES2n2T5Br6RCNdl+3OZjWous7H8ss7qKSezNckuGCcINqlL+OD2T2Eovh5MbUtGBx8SAdxHw==
X-Received: by 2002:a17:906:6813:b0:a44:51d8:7dd with SMTP id k19-20020a170906681300b00a4451d807ddmr12385037ejr.0.1709812660908;
        Thu, 07 Mar 2024 03:57:40 -0800 (PST)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id mc18-20020a170906eb5200b00a3f28bf94f8sm8109585ejb.199.2024.03.07.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:57:40 -0800 (PST)
Message-ID: <4c84f81c89b58886ad4e9df41f340790d2dee7d9.camel@gmail.com>
Subject: Re: [PATCH v5 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Saravana Kannan <saravanak@google.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Thu, 07 Mar 2024 12:57:34 +0100
In-Reply-To: <94997e8720bc0a68afa85be3ef521c8844d0f0a0.camel@gmail.com>
References: <20240307111036.225007-1-herve.codina@bootlin.com>
	 <20240307111036.225007-2-herve.codina@bootlin.com>
	 <94997e8720bc0a68afa85be3ef521c8844d0f0a0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-07 at 12:50 +0100, Nuno S=C3=A1 wrote:
> Hi Herve,
>=20
>=20
> On Thu, 2024-03-07 at 12:10 +0100, Herve Codina wrote:
> > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > introduces a workqueue to release the consumer and supplier devices use=
d
> > in the devlink.
> > In the job queued, devices are release and in turn, when all the
> > references to these devices are dropped, the release function of the
> > device itself is called.
> >=20
> > Nothing is present to provide some synchronisation with this workqueue
> > in order to ensure that all ongoing releasing operations are done and
> > so, some other operations can be started safely.
> >=20
> > For instance, in the following sequence:
> > =C2=A0 1) of_platform_depopulate()
> > =C2=A0 2) of_overlay_remove()
> >=20
> > During the step 1, devices are released and related devlinks are remove=
d
> > (jobs pushed in the workqueue).
> > During the step 2, OF nodes are destroyed but, without any
> > synchronisation with devlink removal jobs, of_overlay_remove() can rais=
e
> > warnings related to missing of_node_put():
> > =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2
> >=20
> > Indeed, the missing of_node_put() call is going to be done, too late,
> > from the workqueue job execution.
> >=20
> > Introduce device_link_wait_removal() to offer a way to synchronize
> > operations waiting for the end of devlink removals (i.e. end of
> > workqueue jobs).
> > Also, as a flushing operation is done on the workqueue, the workqueue
> > used is moved from a system-wide workqueue to a local one.
> >=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++++=
+---
> > =C2=A0include/linux/device.h |=C2=A0 1 +
> > =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d5f4e4aac09b..48b28c59c592 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > =C2=A0static void __fw_devlink_link_to_consumers(struct device *dev);
> > =C2=A0static bool fw_devlink_drv_reg_done;
> > =C2=A0static bool fw_devlink_best_effort;
> > +static struct workqueue_struct *device_link_wq;
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * __fwnode_link_add - Create a link between two fwnode_handles.
> > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *de=
v)
> > =C2=A0	/*
> > =C2=A0	 * It may take a while to complete this work because of the SRCU
> > =C2=A0	 * synchronization in device_link_release_fn() and if the consum=
er or
> > -	 * supplier devices get deleted when it runs, so put it into the "lon=
g"
> > -	 * workqueue.
> > +	 * supplier devices get deleted when it runs, so put it into the
> > +	 * dedicated workqueue.
> > =C2=A0	 */
> > -	queue_work(system_long_wq, &link->rm_work);
> > +	queue_work(device_link_wq, &link->rm_work);
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * device_link_wait_removal - Wait for ongoing devlink removal jobs to=
 terminate
> > + */
> > +void device_link_wait_removal(void)
> > +{
> > +	/*
> > +	 * devlink removal jobs are queued in the dedicated work queue.
> > +	 * To be sure that all removal jobs are terminated, ensure that any
> > +	 * scheduled work has run to completion.
> > +	 */
> > +	flush_workqueue(device_link_wq);
> > +}
> > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > +
> > =C2=A0static struct class devlink_class =3D {
> > =C2=A0	.name =3D "devlink",
> > =C2=A0	.dev_groups =3D devlink_groups,
> > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> > =C2=A0	sysfs_dev_char_kobj =3D kobject_create_and_add("char", dev_kobj)=
;
> > =C2=A0	if (!sysfs_dev_char_kobj)
> > =C2=A0		goto char_kobj_err;
> > +	device_link_wq =3D alloc_workqueue("device_link_wq", 0, 0);
>=20
> My rb tag was with the assumption this is moved into devlink_class_init()=
 IIUC,
> Saravana also agreed with that [1]. But it looks like he missed that we a=
re
> allocating the queue in devices_init() and not in devlink_class_init().
>=20
> I'm also not sure if this is in line with what Rafael wanted for ccing st=
able. How
> do
> we know the next patch depends on this one?

Should have looked before:

https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

So, I think what you have is correct :)

- Nuno S=C3=A1


