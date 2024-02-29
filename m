Return-Path: <linux-kernel+bounces-86722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB57286C9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D21D1F22CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D527E0F8;
	Thu, 29 Feb 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIfnjJpq"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD441EB46;
	Thu, 29 Feb 2024 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211786; cv=none; b=SOtA0IH7iU7somXNnHQd57+MyXrn7LuoXwTf0WpkGdCKVkJPG7zgMU3Lv/7SgUF8v6IxjBh01gxF0XXs/zVjhhxWECkaHE33IN2PigHknaGQBsDNes5KJTpZtS4Puk91ncsQGn3TcOV37yKBf5vayS4dg2Py6Cus+2MfswTiLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211786; c=relaxed/simple;
	bh=NF+J53s9ack+LK9clVcP6iNIeJuebRRdCkgajbisWOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PjrkGP1lguVTPWHdxgefsykzlPAA3dPimv1lxzjOBo2Z5s4uJXUsWqn/bZojaDUo1ZmQZlopt5P1QoIrnQt2lsIp/oUqGpnkoGIK6+KK8Z2InHcx1H4zdxQiXBvUt6UYtw3pOERobasHA1fVif/lyunIK4YNenp94vDpU8IZ+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIfnjJpq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso160066866b.0;
        Thu, 29 Feb 2024 05:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709211783; x=1709816583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NF+J53s9ack+LK9clVcP6iNIeJuebRRdCkgajbisWOE=;
        b=nIfnjJpq9DAufhbCaqrOrTRNq6dVRaekf1gZpfe6Ljmrr/gmlMmWLNY+Oc25EpawJ4
         L0pytzVVdBYfQHXpb76gyJI+1/kwXoTo8d4Hc0V8771+ZIRLaPctxhSgTMm58rJ7Js/B
         RSTzomwgBPmGgfCx2AfR5z6jeUe2b0uPGRZ/eQNwLcfORPTC8DuI3n50IVs8HPbuVnrN
         C+AtibK23YYNFAJQOJpzW+yGqwiqnZEZXdrY1Z4TZ01lkdf3bzNO1IxYMi+k92mviJeb
         PFuONEIPCAQTAyQ5ftxrgLWBkthbhzJtdkogZFLdE9n/H646pQhA1VvTmZ1DZ94A3g/H
         Ohtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709211783; x=1709816583;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NF+J53s9ack+LK9clVcP6iNIeJuebRRdCkgajbisWOE=;
        b=qdepcjGXPSE8bTZnIqheHyNSX3CDv7V+cZdAeH0ni90srINTrYDGVlJnl5/mCkKLdv
         mDN9PbZVEI6kQRccFgvBjfMxHdLP098NyHIfrKHs0U0bImHwIrEFtTB8xTH+GrTD4EqX
         78zPa71dSuuvdnvwBrbc9zvXUOYG45pUeuuCNNw+oiNJkFZBmnra9UKmvO04Ak9xXTqL
         Nj82TzggYbHIp+DjPXYl0LjJboT/tj/5Mi8GzrDDdHsJsXBeRkiyBIw8M2ZMMp6XpvYA
         gstmOroO6ITHNTbfF5CkWkC52N/tXf6pPVLwNTMqeYYZGxknrjKSN6MY+U4vAwvRWsn8
         JTAg==
X-Forwarded-Encrypted: i=1; AJvYcCVTjch/0NUhT/MRecCOmYIZHP3mF3MY63UbF5oY3g1RY+lZ+z+o3YwE/nGXatRNfhlXD7P+aXuyFavIwQch0gHCPWyJP+ra1ZCIwJfw7gtzw2GrnsF04IuAGZTu0sKj87IL4/MuEQJKoTZm8SRiWcQIA6OTjsLsSKqlQWUrWtE8ww==
X-Gm-Message-State: AOJu0YyuLz/CNNfb4wxPNBBk1fwjzgSHUofDyvH7532+V6vsLZ/VLzv5
	naR6XTOrgo//aXKpPDTANREW84rMwfuf5wPLPEIUAAAjb4ttxYFQ
X-Google-Smtp-Source: AGHT+IEDPxQCBGh3Ia0jt9ZWaBBa9PCJvA+qO+WlevHSeyZi1rwDKWtBI0Jfr1TaLVksgHmxMS/DWg==
X-Received: by 2002:a17:906:3689:b0:a43:e812:fbc8 with SMTP id a9-20020a170906368900b00a43e812fbc8mr1505196ejc.18.1709211782649;
        Thu, 29 Feb 2024 05:03:02 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id cw10-20020a170907160a00b00a3e9ea356easm666794ejd.125.2024.02.29.05.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:03:02 -0800 (PST)
Message-ID: <af8a97f3a187cc403b6184948d3e335ee83f44ec.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Frank
 Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Thu, 29 Feb 2024 14:06:25 +0100
In-Reply-To: <CAJZ5v0hGfqrczS1Si8Bu67vTSkTKO_gO7ftO2R7CQxGKGWsbAA@mail.gmail.com>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
	 <20240229105204.720717-2-herve.codina@bootlin.com>
	 <9cc3d11bc3e1bb89a1c725f865d0c8d1494111c5.camel@gmail.com>
	 <CAJZ5v0hGfqrczS1Si8Bu67vTSkTKO_gO7ftO2R7CQxGKGWsbAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 14:01 +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 29, 2024 at 12:13=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> >=20
> > Hi,
> >=20
> > Just copy pasting my previous comments :)
> >=20
> > On Thu, 2024-02-29 at 11:52 +0100, Herve Codina wrote:
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
> > > =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++=
+++---
> > > =C2=A0include/linux/device.h |=C2=A0 1 +
> > > =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index d5f4e4aac09b..80d9430856a8 100644
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
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 drain_workqueue(device_link_wq);
> > > +}
> >=20
> > I'm still not convinced we can have a recursive call into devlinks remo=
val
> > so I
> > do think flush_workqueue() is enough. I will defer to Saravana though..=
.
>=20
> AFAICS, the difference betwee flush_workqueue() and drain_workqueue()
> is the handling of the case when a given work item can queue up itself
> again.=C2=A0 This does not happen here.


Yeah, that's also my understanding...

