Return-Path: <linux-kernel+bounces-52208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF6849564
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14421F22589
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED4D11C80;
	Mon,  5 Feb 2024 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvl26cQ0"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688C511C84;
	Mon,  5 Feb 2024 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121789; cv=none; b=JGeJU5yHmZa1iPESWtqA6P7xLZ30hyR3n98roOhB0+VeTjGb8Xrtnsmoch4zBc2u01RsdDkDDPdt7QYaneW1fCvjvdVv3ao3tP5ZTiP/95aGzL6z9//BRVOCEkS088XrUKhCDrwmtZNoOZrj/jiiQP2W3Te31Kue50zeFOUN1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121789; c=relaxed/simple;
	bh=p/ylGTSPNvK1bKWPE19+VRoe5D5yOHh/N6a9RKvsL/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dx3Th1yXnKW/PDIgdeTLD9YwwVPX4+u8sQc9VdI49SDAEpYwKljP53tiGqUP5hwjeZBfdqTE6kekSxgDs+o1UtAmCUZ4v+9VOewyYp6Q4gSV1fNfH0sTff+hXrlMZTLsQPOtvuHVBnxu7NAJ5TleuB8ezLuE5DbQtwP3LR5Ps9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvl26cQ0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51137c8088dso3719288e87.1;
        Mon, 05 Feb 2024 00:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707121785; x=1707726585; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/ylGTSPNvK1bKWPE19+VRoe5D5yOHh/N6a9RKvsL/Q=;
        b=hvl26cQ0yssJL7Oiq9c5Vw1mVtO+/0soXfsiM/Kba5YviGn9zeMXavR/E2d7Q2DBdF
         hFTLJJu5iNZUX2jw99ZLUtnwpD6Y18aybdRxBlLXCxWUXq4Ewe98eINYA7maWAPXxEyM
         oCXwDU5/N008Popf4tV/5mX/TNjIPKHO2J4V1LatU+soPC0m+56Yo6FDp6TLSx7DZ0JO
         CeJGYUlwmMrKDylxuS9HUztwFz/fNJMwNMzhZDjvA/GX9grb5Xjy9NT8ZGdrzOYfOu2f
         MDobW7uV6Aaa4zAKBSuiDp3XDunnc3VRDaFQQDLUiTWBccJUEkMD/N2ipwsskd0fo7+l
         2wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707121785; x=1707726585;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/ylGTSPNvK1bKWPE19+VRoe5D5yOHh/N6a9RKvsL/Q=;
        b=IicnNVgmnZ1tqxIpFDVuoYVuZs4LnlVR/EL3JCtWtKth1wJF0+xGiLE9A3txgb8n5i
         nBMtFXFgr8TKkuQKZtnJyUoujSD941PFyA9AqlobkNrQ6tvmJXPjjzRoJxyLvwaixyxz
         8CnQy6y+TEVPW7El2I+RPYbRYSS2J77G8HEPeGZYQOttNcYdHp701A8uTOKhUxTk6XgT
         w53n2EbJWJfSIN7oO5g1oLL1lVMBRn63Ia2z7ByzsUua9QPBKUSrn/06WZhqxyIGrWv+
         MmBTNIFxVpHKHSQyZ79sseq/2b75N3K9DSyVR3nTVUxFQWqZptCoIl42lMUu2QWMS4yP
         4oFg==
X-Gm-Message-State: AOJu0YzGr7r+6sWvVGlkeFtYqzXIX5K7sMuVNxMiJ4SJsbDjajg1JuYr
	7ls12ft4+oNhmxy7/4RLPweC+qmOPxXLgu+vZMsTL2T5CwRRA9G2krn9j/ZpL1MceA==
X-Google-Smtp-Source: AGHT+IGW5tH6lWt4Hegawu7l8ZmAdhcQMuzNG9xIvDepbxUAlR1/aIKANS7hVNAFKj2tE4w6OPbqiA==
X-Received: by 2002:ac2:4985:0:b0:511:e7e:b2d7 with SMTP id f5-20020ac24985000000b005110e7eb2d7mr8008751lfl.5.1707121785196;
        Mon, 05 Feb 2024 00:29:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCViMd5Jbo9VclBzdiZPbF2vhJLVPoOWlUqTAdbXNoHLz+c3Zw/jrg+6vVfNnEJt8lLTVxdeYOwm6zovC42fNKXiroTSMdj+DCmmQoSm52d49XHHhsCdHay2E+H+4kC+hq4Tyohlo3xL33ezL22cwgZO6XhkXIH0xLUaBjLc9EoaBdr8SUd4DldCKO1x59smC/hyNcvSM+IaJPhvctaGgHvmuN8UbbjO02e9mxAxa2IX08zC5MzAceMo08ZStUDHziVSVkfvjbrSte+qghrEiK7SqJh5katpQbkMHoTgjF2v510bPTs8xQ+8JjsQlFg/GYAc+MCIwHiXpPSdbPOPA4qN8i053N3ZryrgW03WUS6EJMAuFfCuxF4YjPL2UbRvPl2NEIQ2ZYhPU2sLZ2g91ey5H2UVbquLv4DEQ7NGoSsiDC/YSa74EieeEPNUIQ==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040fbdd6f69bsm7879914wms.33.2024.02.05.00.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 00:29:44 -0800 (PST)
Message-ID: <c4a6f0aba84c328dc31d7ec40fe3d4c2b35c6c14.camel@gmail.com>
Subject: Re: [PATCH 1/2] driver: core: add dedicated workqueue for devlink
 removal
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, nuno.sa@analog.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand
 <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 05 Feb 2024 09:29:44 +0100
In-Reply-To: <CAJZ5v0g5JbstLhCaXcY1kawP8etB5Z4TBuGXHz8_wsrXm3CaQA@mail.gmail.com>
References: 
	<20240202-fix-device-links-overlays-v1-0-f9fd1404c8e2@analog.com>
	 <20240202-fix-device-links-overlays-v1-1-f9fd1404c8e2@analog.com>
	 <CAJZ5v0g5JbstLhCaXcY1kawP8etB5Z4TBuGXHz8_wsrXm3CaQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-02 at 16:59 +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 2, 2024 at 1:18=E2=80=AFPM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Let's use a dedicated queue for devlinks since releasing a link happens
> > asynchronously but some code paths, like DT overlays, have some
> > expectations regarding the of_node when being removed (the refcount mus=
t
> > be 1). Given how devlinks are released that cannot be assured. Hence, a=
dd a
> > dedicated queue so that it's easy to sync against devlinks removal.
>=20
> Thanks for following my suggestion!
>=20
> > While at it, make sure to explicitly include <linux/workqueue.h>.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 33 ++++++++++++++++++++++=
+++++++----
> > =C2=A0include/linux/fwnode.h |=C2=A0 1 +
> > =C2=A02 files changed, 30 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 14d46af40f9a..06e7766b5227 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -31,6 +31,7 @@
> > =C2=A0#include <linux/swiotlb.h>
> > =C2=A0#include <linux/sysfs.h>
> > =C2=A0#include <linux/dma-map-ops.h> /* for dma_default_coherent */
> > +#include <linux/workqueue.h>
> >=20
> > =C2=A0#include "base.h"
> > =C2=A0#include "physical_location.h"
> > @@ -44,6 +45,7 @@ static bool fw_devlink_is_permissive(void);
> > =C2=A0static void __fw_devlink_link_to_consumers(struct device *dev);
> > =C2=A0static bool fw_devlink_drv_reg_done;
> > =C2=A0static bool fw_devlink_best_effort;
> > +static struct workqueue_struct *devlink_release_queue __ro_after_init;
> >=20
> > =C2=A0/**
> > =C2=A0 * __fwnode_link_add - Create a link between two fwnode_handles.
> > @@ -235,6 +237,11 @@ static void __fw_devlink_pickup_dangling_consumers=
(struct
> > fwnode_handle *fwnode,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 __fw_devlink_pickup_dangling_consumers(child, new_sup=
);
> > =C2=A0}
> >=20
> > +void fwnode_links_flush_queue(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flush_workqueue(devlink_release_q=
ueue);
> > +}
> > +
> > =C2=A0static DEFINE_MUTEX(device_links_lock);
> > =C2=A0DEFINE_STATIC_SRCU(device_links_srcu);
> >=20
> > @@ -531,9 +538,10 @@ static void devlink_dev_release(struct device *dev=
)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It may take a while =
to complete this work because of the SRCU
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization in d=
evice_link_release_fn() and if the consumer or
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get=
 deleted when it runs, so put it into the "long"
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devlink workqueue.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &link-=
>rm_work);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(devlink_release_queue,=
 &link->rm_work);
> > =C2=A0}
> >=20
> > =C2=A0static struct class devlink_class =3D {
> > @@ -636,10 +644,27 @@ static int __init devlink_class_init(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D class_interface_regi=
ster(&devlink_class_intf);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 class_unregister(&devlink_class);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Using a dedicated queue f=
or devlinks since releasing a link happens
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * asynchronously but some c=
ode paths, like DT overlays, have some
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * expectations regarding th=
e of_node when being removed (the refcount
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * must be 1). Given how dev=
links are released that cannot be assured.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Hence, add a dedicated qu=
eue so that it's easy to sync against
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devlinks removal.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devlink_release_queue =3D alloc_w=
orkqueue("devlink_release", 0, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!devlink_release_queue) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 class_interface_unregister(&devlink_class_intf);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 class_unregister(&devlink_class);
>=20
> This is a bit drastic.
>=20
> I think that device links can still work if devlink_release_queue is
> NULL, just devlink_dev_release() needs to check it and release
> synchronously if it is NULL.
>=20

Agreed, I'll do that way. It will always synchronously remove the links (wh=
ich is
different than before) but I guess that failing in allocating the queue is =
rather
unlikely.

- Nuno S=C3=A1



