Return-Path: <linux-kernel+bounces-74175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC4E85D0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6A5B24D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B523A1C2;
	Wed, 21 Feb 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfB31D0n"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631EC365;
	Wed, 21 Feb 2024 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498601; cv=none; b=b6d5GixoZ7EPXGawId2gBem+Ugyp1hBfIX7bv5MoCvfNn2NndI0cmkyeQC+3TyzmOJunp7uvNysI/DPEhUmBw/BOFiDjpaA6xvFouhZJpMIjSpOluMWnSnddJGGeRaGQJnASwDXeTVOMMHP5lSJpYJ1v8nVSsh4/CE1GH9TzvE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498601; c=relaxed/simple;
	bh=g6m076LQ23h6FwkMylUlHWPkBsSKbQX7IRgEVMF1E1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DBo1jetDOJnuozwynV1fWGjqtGWXaGefJNoclMVyIOkQzUoYq4pD4HSVI+TrDQfSRx4yoOWTnoC7p1oHnPl8ifJ46ciE9CDgMjtaqD5/wRi/YLVQJBfAHAYbnFRMIaOR/DMTjcfGStgTiyQXW4xsj/LFRsxd2AOzaxYjWifLKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfB31D0n; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso1090149066b.0;
        Tue, 20 Feb 2024 22:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708498597; x=1709103397; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g6m076LQ23h6FwkMylUlHWPkBsSKbQX7IRgEVMF1E1A=;
        b=EfB31D0nwp5JDZaUAP6wk334twvTXdvK2yAdEMOSJSbO0c+HHxKq4yZKw1xfltiyNi
         YEwo+m8lgkhMsg7JPOGGP8T6iZl0BuWkUuvTN2ZBYhnAsB/LlM27fBp8tQu0VWv8SyTt
         TKZtWmkBgFrn9UZ91B75lWxuv3KztqyWGKEYI40566qpqmfgRPiOGTvE/5/5FjafJS00
         ZkJ2oSUdzlVAn5LEQzD5RljT9UyHDurWw0UmDwrTP/PdAg5PO4F/ydHCkwUPlpPLZGnN
         IosYf9R924CtUBjuN/dV3bBuXnwX89HFes+cxjOzJP6BROoKZWm9Berz08F19KbjX3+f
         IXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708498597; x=1709103397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6m076LQ23h6FwkMylUlHWPkBsSKbQX7IRgEVMF1E1A=;
        b=n4igMn8xkQ/hYJu+3byTj/H3LmMspiyYdqz0Chhmu1F3ct4ulhMxWoMf7fiyX4lQFR
         /ySD6qONFxVsIhnLljFf8PXUHmbD3TaRSzxCEb2x553JrwXi7Q4/6bFEcNI3HTUK00O8
         VPuCuvebFQjGsdj3NVtwDduKlDjb1GTHLAajiwH5Bc+fcL3idUjHcU7qQtqgdsIvM3lV
         BQfjVD64kZqiAROep/5qMakK7q6waPKxMnhnVk2/i97W+Z+G/YMv2rAGrAEGGOeCv6Tb
         AMkO3ArqXP8aIE7ACLYkrpjT65hnbUl1iicJANRSGKWJr+uSYqHPxZHorDKjST5nkcMx
         ad8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQnVtVpBPfp/jp+2c3/uxraLo/xpu8yAFwHoA6XlZrhA0g6iawHXy3ccRlHMwlfIqx+hGgtUWfZkIp3DTExDT0JjZ14GIiK3gVaJdQ0i2pP80vfdFT/WXy8uQvxpFg4xwjw3sZvwI3Gw==
X-Gm-Message-State: AOJu0Yy61kJ5A7aF0c+Uo9vREx5V4cbGJHsio4pDuM1wfYgYmWgMqNWr
	/YuDli4IHNTd0w0cEqPCtskbcY5b5Ed289A7aPCQcgo/c2nnw2D3
X-Google-Smtp-Source: AGHT+IGMVHnJP/qP5C8H+Ph5ZY+nV9TI7+m/pUZ+3ELwkxijh49gE8dP2+Sm0DdGwU64NufV86QItA==
X-Received: by 2002:a17:906:280c:b0:a3c:2f68:54a9 with SMTP id r12-20020a170906280c00b00a3c2f6854a9mr17213107ejc.3.1708498597182;
        Tue, 20 Feb 2024 22:56:37 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709067d5600b00a3e92467f22sm2804937ejp.163.2024.02.20.22.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:56:36 -0800 (PST)
Message-ID: <c4e1092298244c288212e9f6cdbf7c26d0e9d83b.camel@gmail.com>
Subject: Re: [PATCH 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>, Herve Codina
	 <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Date: Wed, 21 Feb 2024 07:56:35 +0100
In-Reply-To: <CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	 <20231130174126.688486-2-herve.codina@bootlin.com>
	 <CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 16:31 -0800, Saravana Kannan wrote:
> On Thu, Nov 30, 2023 at 9:41=E2=80=AFAM Herve Codina <herve.codina@bootli=
n.com> wrote:
> >=20
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
>=20
> Thanks for the bug report and fix. Sorry again about the delay in
> reviewing the changes.
>=20
> Please add Fixes tag for 80dd33cf72d1.
>=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> > =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++++=
+---
> > =C2=A0include/linux/device.h |=C2=A0 1 +
> > =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index ac026187ac6a..2e102a77758c 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > =C2=A0static void __fw_devlink_link_to_consumers(struct device *dev);
> > =C2=A0static bool fw_devlink_drv_reg_done;
> > =C2=A0static bool fw_devlink_best_effort;
> > +static struct workqueue_struct *fw_devlink_wq;
> >=20
> > =C2=A0/**
> > =C2=A0 * __fwnode_link_add - Create a link between two fwnode_handles.
> > @@ -530,12 +531,26 @@ static void devlink_dev_release(struct device *de=
v)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It may take a while =
to complete this work because of the SRCU
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization in d=
evice_link_release_fn() and if the consumer or
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get dele=
ted when it runs, so put it into the "long"
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get dele=
ted when it runs, so put it into the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * dedicated workqueue.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &link-=
>rm_work);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(fw_devlink_wq, &link->=
rm_work);
>=20
> This has nothing to do with fw_devlink. fw_devlink is just triggering
> the issue in device links. You can hit this bug without fw_devlink too.
> So call this device_link_wq since it's consistent with device_link_* APIs=
.
>=20

I'm not sure if I got this right in my series. I do call devlink_release_qu=
eue() to
my queue. But on the Overlay side I use fwnode_links_flush_queue() because =
it looked
more sensible from an OF point of view. And including (in OF code) linux/fw=
node.h
instead linux/device.h makes more sense to me.

> > =C2=A0}
> >=20
> > +/**
> > + * device_link_wait_removal - Wait for ongoing devlink removal jobs to=
 terminate
> > + */
> > +void device_link_wait_removal(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devlink removal jobs are =
queued in the dedicated work queue.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To be sure that all remov=
al jobs are terminated, ensure that any
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * scheduled work has run to=
 completion.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drain_workqueue(fw_devlink_wq);
>=20
> Is there a reason this needs to be drain_workqueu() instead of
> flush_workqueue(). Drain is a stronger guarantee than we need in this
> case. All we are trying to make sure is that all the device link
> remove work queued so far have completed.
>=20

Yeah, I'm also using flush_workqueue().

> > +}
> > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > +
> > =C2=A0static struct class devlink_class =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "devlink",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_groups =3D devlink_grou=
ps,
> > @@ -4085,9 +4100,14 @@ int __init devices_init(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_dev_char_kobj =3D kobj=
ect_create_and_add("char", dev_kobj);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sysfs_dev_char_kobj)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto char_kobj_err;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fw_devlink_wq =3D alloc_workqueue=
("fw_devlink_wq", 0, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!fw_devlink_wq)
>=20
> Fix the name appropriately here too please.

Hi Saravana,

Oh, was not aware of this series... Please look at my first patch. It alrea=
dy has a
review tag by Rafael. I think the creation of the queue makes more sense to=
 be done
in devlink_class_init(). Moreover, Rafael complained in my first version th=
at
erroring out because we failed to create the queue is too harsh since devli=
nks can
still work. So, what we do is to schedule the work if we have a queue or to=
o call
device_link_release_fn() synchronously if we don't have the queue (note tha=
t failing
to allocate the queue is very unlikely anyways).

- Nuno S=C3=A1
>=20

