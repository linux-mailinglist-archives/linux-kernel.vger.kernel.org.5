Return-Path: <linux-kernel+bounces-135735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EBD89CA8E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C88BB22A03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769B143896;
	Mon,  8 Apr 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zef5djim"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F76142906;
	Mon,  8 Apr 2024 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596527; cv=none; b=cR9nwkY5O0OLQ4/t5p7QL4hAJTcmcX571azwPfryD/WwcCZoEF1lxIRzgTVv1ROrzQ2KxAsUimi1hZR/UbmRmneh68c4g3sDvfKbeL6ghwpEYBepTggkqobKLbPgQE/RxleSYgiwxppaBD0/KtxqhC4YBJqQl46I3RC5atWLx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596527; c=relaxed/simple;
	bh=cb3yCHZjckEDvem/7qkDx7+ocNrNL4H3d8W/mSBltHc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SqQxS10lbI3DMu7OmlmMGd/JwNCU2mQ8gHNHTw44vTNxArrZGqXETYUic1wbYWhpA52fCUCe4D18ZoGjnZcJqJXYOdXN4bBbtwkBcWVsH4SSzTwLvfQDl09L6Z4wLY+gP20JRsnQ1ZdwMKczTGMuMJXNCXmT/I8635++GL+OdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zef5djim; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712596525; x=1744132525;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cb3yCHZjckEDvem/7qkDx7+ocNrNL4H3d8W/mSBltHc=;
  b=Zef5djimDvlod85TlhdR7U5mN7Lhsg9mG0qvPaE2iVijpoVkMiLGy6zf
   j2C6TfOz7RlMhAttpbtcHC2LJtGx18dh/dBtN85zFQK/AANrTbMhWVzTX
   F3dpTYOzgsEd2DVAftPe/tPx6/4sOm++SRyZ0LpPj06uRoJPQMixR0HRO
   I2Fc67RZE7OqK3HQo3PoDZLPwcZMGKwRzkk3J6JcDe9SxTp/9VsY42NRW
   SQsEJTtRLqnfF2xdJXMiI48s7FKc/dqhck4Tko4XndY5j7FKqsHZdnQxK
   aLKAI+dADCBc3WJ/xCS8RUbOkgBnElkhp/0spPeEPoAGPSwSIOQWfOtY+
   Q==;
X-CSE-ConnectionGUID: EM9+v3cIQvescg2JlZ8urA==
X-CSE-MsgGUID: UddkRFC4TKarMozCvhME1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18497437"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="18497437"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:15:24 -0700
X-CSE-ConnectionGUID: mpnUkkKMSJWvY24XJKOp0A==
X-CSE-MsgGUID: HoxRDC2aSX+hAH2ZkWUTyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20037843"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:15:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 20:15:17 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] ACPI: fan: Add hwmon support
In-Reply-To: <36a8ebff-8a89-44e0-9b30-374913bd8cbd@gmx.de>
Message-ID: <d5cf9425-c43d-2771-0906-7c055244d783@linux.intel.com>
References: <20240408123718.15512-1-W_Armin@gmx.de> <63187b48-7978-3b0f-0526-79afea65c492@linux.intel.com> <36a8ebff-8a89-44e0-9b30-374913bd8cbd@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-884334050-1712596517=:14302"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-884334050-1712596517=:14302
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 8 Apr 2024, Armin Wolf wrote:
> Am 08.04.24 um 17:48 schrieb Ilpo J=C3=A4rvinen:
> > On Mon, 8 Apr 2024, Armin Wolf wrote:
> >=20
> > > Currently, the driver does only supports a custom sysfs
> > > interface to allow userspace to read the fan speed.
> > > Add support for the standard hwmon interface so users
> > > can read the fan speed with standard tools like "sensors".
> > >=20
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   drivers/acpi/Makefile    |  1 +
> > >   drivers/acpi/fan.h       |  2 ++
> > >   drivers/acpi/fan_core.c  |  7 ++++
> > >   drivers/acpi/fan_hwmon.c | 78 +++++++++++++++++++++++++++++++++++++=
+++
> > >   4 files changed, 88 insertions(+)
> > >   create mode 100644 drivers/acpi/fan_hwmon.c
> > >=20
> > > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > > index d69d5444acdb..9a2e03acc1be 100644
> > > --- a/drivers/acpi/Makefile
> > > +++ b/drivers/acpi/Makefile
> > > @@ -83,6 +83,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)=09+=3D
> > > tiny-power-button.o
> > >   obj-$(CONFIG_ACPI_FAN)=09=09+=3D fan.o
> > >   fan-objs=09=09=09:=3D fan_core.o
> > >   fan-objs=09=09=09+=3D fan_attr.o
> > > +fan-objs=09=09=09+=3D fan_hwmon.o
> > >=20
> > >   obj-$(CONFIG_ACPI_VIDEO)=09+=3D video.o
> > >   obj-$(CONFIG_ACPI_TAD)=09=09+=3D acpi_tad.o
> > > diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> > > index e7b4b4e4a55e..45c2637566da 100644
> > > --- a/drivers/acpi/fan.h
> > > +++ b/drivers/acpi/fan.h
> > > @@ -56,4 +56,6 @@ struct acpi_fan {
> > >   int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fs=
t
> > > *fst);
> > >   int acpi_fan_create_attributes(struct acpi_device *device);
> > >   void acpi_fan_delete_attributes(struct acpi_device *device);
> > > +
> > > +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
> > >   #endif
> > > diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> > > index ff72e4ef8738..6bbdbb914e95 100644
> > > --- a/drivers/acpi/fan_core.c
> > > +++ b/drivers/acpi/fan_core.c
> > > @@ -7,6 +7,7 @@
> > >    *  Copyright (C) 2022 Intel Corporation. All rights reserved.
> > >    */
> > >=20
> > > +#include <linux/kconfig.h>
> > >   #include <linux/kernel.h>
> > >   #include <linux/module.h>
> > >   #include <linux/init.h>
> > > @@ -336,6 +337,12 @@ static int acpi_fan_probe(struct platform_device
> > > *pdev)
> > >   =09=09if (result)
> > >   =09=09=09return result;
> > >=20
> > > +=09=09if (IS_REACHABLE(CONFIG_HWMON)) {
> > > +=09=09=09result =3D devm_acpi_fan_create_hwmon(device);
> > > +=09=09=09if (result)
> > > +=09=09=09=09return result;
> > > +=09=09}
> > > +
> > >   =09=09result =3D acpi_fan_create_attributes(device);
> > >   =09=09if (result)
> > >   =09=09=09return result;
> > > diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> > > new file mode 100644
> > > index 000000000000..4f2bec8664f4
> > > --- /dev/null
> > > +++ b/drivers/acpi/fan_hwmon.c
> > > @@ -0,0 +1,78 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * fan_hwmon.c - hwmon interface for the ACPI Fan driver
> > > + *
> > > + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> > > + */
> > > +
> > > +#include <linux/acpi.h>
> > > +#include <linux/hwmon.h>
> > > +#include <linux/limits.h>
> > > +
> > > +#include "fan.h"
> > > +
> > > +static umode_t acpi_fan_is_visible(const void *drvdata, enum
> > > hwmon_sensor_types type, u32 attr,
> > > +=09=09=09=09   int channel)
> > > +{
> > > +=09return 0444;
> > > +}
> > > +
> > > +static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types
> > > type, u32 attr, int channel,
> > > +=09=09=09 long *val)
> > > +{
> > > +=09struct acpi_device *adev =3D dev_get_drvdata(dev);
> > > +=09struct acpi_fan_fst fst;
> > > +=09int ret;
> > > +
> > > +=09switch (type) {
> > > +=09case hwmon_fan:
> > > +=09=09ret =3D acpi_fan_get_fst(adev, &fst);
> > > +=09=09if (ret < 0)
> > > +=09=09=09return ret;
> > > +
> > > +=09=09switch (attr) {
> > > +=09=09case hwmon_fan_input:
> > > +=09=09=09if (fst.speed > LONG_MAX)
> > > +=09=09=09=09return -EOVERFLOW;
> > > +
> > > +=09=09=09*val =3D fst.speed;
> > > +=09=09=09return 0;
> > > +=09=09case hwmon_fan_fault:
> > > +=09=09=09*val =3D (fst.speed =3D=3D U32_MAX);
> > > +=09=09=09return 0;
> > Is it okay to return 0 in this case?
>=20
> Hi,
>=20
> i think so, since the value of the attribute (with the meaning of "is the=
 rpm
> value ok?") is being
> correctly stored in val. If acpi_fan_get_fst() fails, we already return a
> negative error code.

Ah, right. It seems fine.

--=20
 i.

> > > +=09=09default:
> > > +=09=09=09break;
> > > +=09=09}
> > > +=09=09break;
> > > +=09default:
> > > +=09=09break;
> > > +=09}
> > > +
> > > +=09return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static const struct hwmon_ops acpi_fan_ops =3D {
> > > +=09.is_visible =3D acpi_fan_is_visible,
> > > +=09.read =3D acpi_fan_read,
> > > +};
> > > +
> > > +static const struct hwmon_channel_info * const acpi_fan_info[] =3D {
> > > +=09HWMON_CHANNEL_INFO(fan,
> > > +=09=09=09   HWMON_F_INPUT | HWMON_F_FAULT),
> > One line.
> >=20
>=20

--8323328-884334050-1712596517=:14302--

