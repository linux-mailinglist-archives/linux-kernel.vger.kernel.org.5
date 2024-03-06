Return-Path: <linux-kernel+bounces-93936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6D8873734
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806DD1C2476E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A775130ACE;
	Wed,  6 Mar 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXXJG5EX"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581FC12D1FC;
	Wed,  6 Mar 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730115; cv=none; b=YzxSAvUWmkUvKiX9vNlyst7iIOszoGA6L0BcYwsIjFa7q445CY7q/B4/n/PumWwfYqKPemEjmj69FYevSGWXzfke2BKs4d/CfE+kV6qcomI/QEQJnzCaYi8uXTudnUkzk3jtWDuV4NnlV1RWpVsW5+5mSCZytjRVSpmIsrQ99aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730115; c=relaxed/simple;
	bh=aitebT0QlJARJIrnF7SJmZko1XhGLFibTGZNq/mnCkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txQYiCcWfMqHUO79z3IgwBG0JLeNWdA3Do4IY5JKf74f3ZSgbNp7how+hlqFi1Ae8vFpTGoMUO8BCYPX12bhZ+8kXdsVyk8nean9jAo9PEIjLYR3ZwCQ3p+j/9NaPUsiS6yCrhrJbpPpbLfaW/Y0NYKqTZv7EHOIHrL5cCqyF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXXJG5EX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a458eb7db13so129277266b.2;
        Wed, 06 Mar 2024 05:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709730112; x=1710334912; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aitebT0QlJARJIrnF7SJmZko1XhGLFibTGZNq/mnCkE=;
        b=GXXJG5EXtbuXmXN6p95dTdCRNwqc75GlzC4BS2VQOpIkFP3Hn7iA2lE2lLzRjJ2dvF
         RzVqOOieVKofbJoW68EzmxwSQYQKvPLbuzbu6h4q+/9O2S3lB5b+GHLQvr9n9awfjkvD
         2BfZWUCTziHcphHV64uGAh7aLoyq0bcwZaeZ6KuscunV3NjnENuEAw57p5moU17WDomR
         TURdMAvPhvq9DJ6Niff2oNZmlb9W6IX3pRR7UQbhy2+nWQ9R9kCDduXMEvvaa4LHFYOv
         AwJ1tgpn2l53UYl72XJ3L1lLEvjvs8Wl9FHJEwCagthfpMh6I6DUWGX50MKHyz3N9wpk
         INqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730112; x=1710334912;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aitebT0QlJARJIrnF7SJmZko1XhGLFibTGZNq/mnCkE=;
        b=tH4rwieQdEc/NGDh2Exa1rdNcKKUXaPmtbNHBR3xCkakvH9MeV6ybv5ZmmLxMt0tRo
         fO/d/zCgGdqLSwsTswGGhfR824cSxE7n/ve4Mf7AavFOIqu/72VhrYJmgpVgpIm/BweD
         sFOhxE2FXQp3lI+Bb8B22xaLmUwAhRiwRkJMEJikySiu+LrRiETN4UVyxzd9BbMHGWm2
         b+fsLxWMvmfS8UbUXnzMgSGeOyO3E2lDIiE5/HjfDmjp/qP+UPUjzdOh3viaA/pAsik1
         2xnqMHKRFyYhVit4GyY8tf3/I6uskGS43SNoXh4NIwXof6WKsIlvjw9SWExH6sGXStjG
         Un+A==
X-Forwarded-Encrypted: i=1; AJvYcCU+XMwkcK2XreG194aAmiH5peEP8mck2GJp3qo10QYhRlsmnOO2OFQc/xXFN/BQT6iat5nFj1a8ki1z3ttv883szzL35jvEyG8RG8YjLP5jtqMlvaYyNT2bSwzbmFLiDxeC4DP7viy/6f6RO102uWIPXYa1pPcaQq3GNpHojKubHA==
X-Gm-Message-State: AOJu0YxGtlf0nNH9gUBYAysmG5+Bh3vcsGgaZIZeppKCUCXcBEjXNrbx
	J9YuaBw5nwuHINEUuzqukH+g8ISK1SdLbD+H13K9u3EPUwe+OUsu
X-Google-Smtp-Source: AGHT+IE0ImX8FGEU2/tPsozvNoAqk/2A8buSxLSrFuz5xxCaSXO3E+756WshmkQCzBmZWK3KY5Y06A==
X-Received: by 2002:a17:906:d92d:b0:a43:fa38:901d with SMTP id rn13-20020a170906d92d00b00a43fa38901dmr10066621ejb.45.1709730111283;
        Wed, 06 Mar 2024 05:01:51 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906085100b00a45b6e84e00sm808577ejd.75.2024.03.06.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:01:50 -0800 (PST)
Message-ID: <ed442b6916016b3a40782dc32538fc517715db6c.camel@gmail.com>
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
Date: Wed, 06 Mar 2024 14:05:16 +0100
In-Reply-To: <CAJZ5v0gWCo9nDAHkzeD08tTKoE0DE0ocht-Qq4zA7P59y9KeuQ@mail.gmail.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
	 <20240306085007.169771-2-herve.codina@bootlin.com>
	 <1fff8742a13c28dd7e1dda47ad2d6fa8e21e421e.camel@gmail.com>
	 <CAJZ5v0gWCo9nDAHkzeD08tTKoE0DE0ocht-Qq4zA7P59y9KeuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-06 at 13:43 +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 6, 2024 at 10:17=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Wed, 2024-03-06 at 09:50 +0100, Herve Codina wrote:
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
> > > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > ---
> >=20
> > With the below addressed:
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >=20
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
> > >=20
> > > =C2=A0/**
> > > =C2=A0 * __fwnode_link_add - Create a link between two fwnode_handles=
.
> > > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *=
dev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It may take a while to complet=
e this work because of the SRCU
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization in device_link=
_release_fn() and if the consumer
> > > or
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get deleted when i=
t runs, so put it into the
> > > "long"
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get deleted when i=
t runs, so put it into the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * dedicated workqueue.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &link->rm_work);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(device_link_wq, &link->rm_work);
> > > =C2=A0}
> > >=20
> > > +/**
> > > + * device_link_wait_removal - Wait for ongoing devlink removal jobs =
to
> > > terminate
> > > + */
> > > +void device_link_wait_removal(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devlink removal jobs are queued in =
the dedicated work queue.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To be sure that all removal jobs ar=
e terminated, ensure that any
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * scheduled work has run to completio=
n.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 flush_workqueue(device_link_wq);
> > > +}
> > > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > +
> > > =C2=A0static struct class devlink_class =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "devlink",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_groups =3D devlink_groups,
> > > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_dev_char_kobj =3D kobject_create=
_and_add("char", dev_kobj);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sysfs_dev_char_kobj)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto char_kobj_err;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 device_link_wq =3D alloc_workqueue("device_=
link_wq", 0, 0);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!device_link_wq)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto wq_err;
> > >=20
> >=20
> > I can't still agree with this. Why not doing it in devlink_class_init()=
?
> > This is
> > devlink specific so it makes complete sense to me.
>=20
> If you do that in devlink_class_init() and it fails, you essentially
> cause the creation of every device link to fail.=C2=A0 IOW, you try to li=
ve
> without device links and pretend that it is all OK.=C2=A0 That won't get
> you very far, especially on systems where DT is used.
>=20
> Doing it here, if it fails, you prevent the driver model from working
> at all (because one of its necessary components is unavailable), which
> arguably is a better choice.

That makes sense but then the only thing I still don't fully get is why we =
have
a separate devlink_class_init() initcall for registering the devlink class
(which can also fail)... What I take from the above is that we should fail =
the
driver model if one of it's fundamental components fails so I would say we
should merge devlink_class_init() with device_init() otherwise it's a bit
confusing (at least to me) and gives the idea that it's ok for the driver m=
odel
to exist without the links (unless I'm missing some other reason for the de=
vlink
init function).

- Nuno S=C3=A1


