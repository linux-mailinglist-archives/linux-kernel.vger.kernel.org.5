Return-Path: <linux-kernel+bounces-55202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98BD84B914
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33451C23787
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135211384BD;
	Tue,  6 Feb 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iD/wbw8z"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9A133428
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232287; cv=none; b=ZIcxp9S7E19fkHVwLZsFuc9Or+KXexzTfzRYEySFyp/yKnb09CiSo9YQcvEMBH6ZFBAh4mk7GCEI4Knk54Dgv2MZe/Msq3Rb1Cdx9lq0fTfM5nMhPREjmhIX6NspLM46ePlegP3p++R11Sppk7MgRMZwXQU/dU/mGkrfJ50JM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232287; c=relaxed/simple;
	bh=V+h7kNIOIk7uxK3ZmXxaIRjARIX9Tv14EifdrQQ3Fcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE5he1Xaf/kX3PM7nyqcqSnQ8rLDQFAOj7MC86rwR3hxwrG6VJ0mM7hxLVybdpOzkkv/JgvEcxCt0CgMg49czIsyGJNlsI7smeJMNMBQnkVVFyZTagvWU3lc+GS+GUfxco3IHfGQ1N8zdDKy4RG8pVrKaNk2Tu1HfXVrvvPPONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iD/wbw8z; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d051fb89fbso13831041fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707232283; x=1707837083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQL4UgN2a82rxpcDP6lB1rkWj5e7indUsz81vK5JM04=;
        b=iD/wbw8z2mhR7I6FU/scMrmfVUDANdzsvvavy8lmH7/v5eOcO+F3oRN3ouQODlWw+h
         Br1wAMDcJ2ul/LFzeOQG/7n1RiF1PzSdMyScdnyBQSJAK5djtM0uMM4bJxu9tU7dam8l
         Nl8JIAQzzq3Z10f13B+zks9YRZ6uMWEUIqTY5K1k4LzORpaxJxI92NdLXIqDpQ00eQnQ
         HjWmI33txOyn5k7EB+BvsPAy1rl4pHanGGXmbs9hEPAknMh8ZOAl9iUz3uX8R5mOyAtm
         bPP+EBvPtJpn5xx2/ayf4r01jQxAgntd72o4r8KbfJaQbllWtW16eQrYWjQBtHFstYjB
         pR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232283; x=1707837083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQL4UgN2a82rxpcDP6lB1rkWj5e7indUsz81vK5JM04=;
        b=QRqDTb9GppPwgRdqR9nSSV6z04R71At/o7H1Bp9uNEi0Xs0weDr8jlkKfWUyHfM9QW
         OcE8t7Vye8+vo55v5zM9wn9iqn40+z8/d5Z4+Cy9jiJru6R2AzraDYdwy0MUSKy7Yz4x
         67KLU0WvJI2qHns/tyssmFqOYNPpEpFjk0dTRUzzFs2rH4GTNDuRzsW0lIoHJiHPHy5K
         ax8uuIm9uouHgXy0cpdDO7H1tt7GTTtnLyAbDzPM1ygK7ukh875c2irfz1u24dkutQuS
         nOb5Qzf204TYVGiTQBprWMKmtuZt6t0/NcUXutWhwvjvkaupkVLBsgtpkIkTECp0BxHP
         /6uQ==
X-Gm-Message-State: AOJu0Yy7Izrc2auuaplV+Wi7wrYaWl3BvdmqhyN6H8dflKqH3D7tAeOb
	e1gP7XKAWAjeLd42of2bSQs8Thxfzgc5vJVNfS+2Q3+FDeWWZWNMHGfXjp/FI8zE/ZNz5pw27xl
	aTiatm+kXzL1Tv5BI+m23JzNvQMWa19YJSiV1mA==
X-Google-Smtp-Source: AGHT+IGBymJiPh8IHxokFPKYJFl5q2mdO6HeoFmrzMiiXCKkrRy/rFturaAsejiOyFaxvXsHX1lkkjPbtf6A3yyZOGE=
X-Received: by 2002:a05:651c:c1:b0:2d0:aaa8:da8b with SMTP id
 1-20020a05651c00c100b002d0aaa8da8bmr2403372ljr.8.1707232282948; Tue, 06 Feb
 2024 07:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
In-Reply-To: <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 6 Feb 2024 17:10:46 +0200
Message-ID: <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > A number of storage technologies support a specialised hardware
> > partition designed to be resistant to replay attacks. The underlying
> > HW protocols differ but the operations are common. The RPMB partition
> > cannot be accessed via standard block layer, but by a set of specific
> > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > partition provides authenticated and replay protected access, hence
> > suitable as a secure storage.
> >
> > The initial aim of this patch is to provide a simple RPMB Driver which
> > can be accessed by the optee driver to facilitate early RPMB access to
> > OP-TEE OS (secure OS) during the boot time.
>
> How early do we expect OP-TEE to need RPMB access?

It depends on the requested services. I am currently aware of 2
services that depend on the RPMB
- FirmwareTPM
- UEFI variables stored there via optee.

For the FirmwareTPM it depends on when you want to use it. This
typically happens when the initramfs is loaded or systemd requests
access to the TPM. I guess this is late enough to not cause problems?

For the latter, we won't need the supplicant until a write is
requested. This will only happen once the userspace is up and running.
The UEFI driver that sits behind OP-TEE has an in-memory cache of the
variables, so all the reads (the kernel invokes get_next_variable
during boot) are working without it.

Thanks
/Ilias
>
> The way things work for mmc today, is that the eMMC card gets
> discovered/probed via a workqueue. The work is punted by the mmc host
> driver (typically a module-platform-driver), when it has probed
> successfully.
>
> The point is, it looks like we need some kind of probe deferral
> mechanism too. Whether we want the OP-TEE driver to manage this itself
> or whether we should let rpmb_dev_find_device() deal with it, I don't
> know.
>
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > class_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > provides a callback to route RPMB frames to the RPMB device accessible
> > via rpmb_route_frames().
>
> By looking at the design of the interface, I do like it. It's simple
> and straightforward.
>
> However, I wonder if you considered avoiding using a class-device
> altogether? Even if it helps with lifecycle problems and the
> ops-lookup, we really don't need another struct device with a sysfs
> node, etc.
>
> To deal with the lifecycle issue, we could probably just add reference
> counting for the corresponding struct device that we already have at
> hand, which represents the eMMC/UFS/NVME card. That together with a
> simple list that contains the registered rpmb ops. But I may be
> overlooking something, so perhaps it's more complicated than that?
>
> >
> > The detailed operation of implementing the access is left to the TEE
> > device driver itself.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  MAINTAINERS              |   7 ++
> >  drivers/misc/Kconfig     |   9 ++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/rpmb-core.c | 247 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/rpmb.h     | 184 +++++++++++++++++++++++++++++
> >  5 files changed, 448 insertions(+)
> >  create mode 100644 drivers/misc/rpmb-core.c
> >  create mode 100644 include/linux/rpmb.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8999497011a2..e83152c42499 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19012,6 +19012,13 @@ T:     git git://linuxtv.org/media_tree.git
> >  F:     Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de=
2-rotate.yaml
> >  F:     drivers/media/platform/sunxi/sun8i-rotate/
> >
> > +RPMB SUBSYSTEM
> > +M:     Jens Wiklander <jens.wiklander@linaro.org>
> > +L:     linux-kernel@vger.kernel.org
> > +S:     Supported
> > +F:     drivers/misc/rpmb-core.c
> > +F:     include/linux/rpmb.h
> > +
> >  RPMSG TTY DRIVER
> >  M:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >  L:     linux-remoteproc@vger.kernel.org
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 4fb291f0bf7c..891aa5763666 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -104,6 +104,15 @@ config PHANTOM
> >           If you choose to build module, its name will be phantom. If u=
nsure,
> >           say N here.
> >
> > +config RPMB
> > +       tristate "RPMB partition interface"
>
> Should we add a "depends on MMC"? (We can add the other NVME and UFS
> later on too).
>
> > +       help
> > +         Unified RPMB unit interface for RPMB capable devices such as =
eMMC and
> > +         UFS. Provides interface for in kernel security controllers to=
 access
> > +         RPMB unit.
> > +
> > +         If unsure, select N.
> > +
> >  config TIFM_CORE
> >         tristate "TI Flash Media interface support"
> >         depends on PCI
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index ea6ea5bbbc9c..8af058ad1df4 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)           +=3D lkdtm/
> >  obj-$(CONFIG_TIFM_CORE)        +=3D tifm_core.o
> >  obj-$(CONFIG_TIFM_7XX1)        +=3D tifm_7xx1.o
> >  obj-$(CONFIG_PHANTOM)          +=3D phantom.o
> > +obj-$(CONFIG_RPMB)             +=3D rpmb-core.o
> >  obj-$(CONFIG_QCOM_COINCELL)    +=3D qcom-coincell.o
> >  obj-$(CONFIG_QCOM_FASTRPC)     +=3D fastrpc.o
> >  obj-$(CONFIG_SENSORS_BH1770)   +=3D bh1770glc.o
> > diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> > new file mode 100644
> > index 000000000000..a3c289051687
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,247 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
> > + * Copyright(c) 2021 - 2024 Linaro Ltd.
> > + */
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/rpmb.h>
> > +#include <linux/slab.h>
> > +
> > +static DEFINE_IDA(rpmb_ida);
> > +static DEFINE_MUTEX(rpmb_mutex);
> > +
> > +/**
> > + * rpmb_dev_get() - increase rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > +{
> > +       if (rdev)
> > +               get_device(&rdev->dev);
> > +       return rdev;
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_get);
> > +
> > +/**
> > + * rpmb_dev_put() - decrease rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +void rpmb_dev_put(struct rpmb_dev *rdev)
> > +{
> > +       if (rdev)
> > +               put_device(&rdev->dev);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_put);
> > +
> > +/**
> > + * rpmb_route_frames() - route rpmb frames to rpmb device
> > + * @rdev:      rpmb device
> > + * @req:       rpmb request frames
> > + * @req_len:   length of rpmb request frames in bytes
> > + * @rsp:       rpmb response frames
> > + * @rsp_len:   length of rpmb response frames in bytes
> > + *
> > + * @return < 0 on failure
> > + */
> > +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> > +                     unsigned int req_len, u8 *rsp, unsigned int rsp_l=
en)
> > +{
> > +       struct rpmb_frame *frm =3D (struct rpmb_frame *)req;
>
> Is there a reason why we are passing an u8 *req, in favor of a
> "rpmb_frame *frame" directly as the in-parameter?
>
> > +       u16 req_type;
> > +       bool write;
> > +
> > +       if (!req || req_len < sizeof(*frm) || !rsp || !rsp_len)
> > +               return -EINVAL;
> > +
> > +       req_type =3D be16_to_cpu(frm->req_resp);
> > +       switch (req_type) {
> > +       case RPMB_PROGRAM_KEY:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   rsp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D true;
> > +               break;
> > +       case RPMB_GET_WRITE_COUNTER:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   rsp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D false;
> > +               break;
> > +       case RPMB_WRITE_DATA:
> > +               if (req_len % sizeof(struct rpmb_frame) ||
> > +                   rsp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D true;
> > +               break;
> > +       case RPMB_READ_DATA:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   rsp_len % sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D false;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return rdev->ops->route_frames(rdev->dev.parent, write,
> > +                                      req, req_len, rsp, rsp_len);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_route_frames);
>
> [...]
>
>
> > +
> > +/**
> > + * enum rpmb_type - type of underlaying storage technology
> > + *
> > + * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
> > + * @RPMB_TYPE_UFS   : UFS (JESD220)
> > + * @RPMB_TYPE_NVME  : NVM Express
> > + */
> > +enum rpmb_type {
> > +       RPMB_TYPE_EMMC,
> > +       RPMB_TYPE_UFS,
> > +       RPMB_TYPE_NVME,
> > +};
>
> In what way do we expect these to be useful?
>
> Perhaps we should add some information about this, because currently
> in the series they seem not to be used. Maybe the OP-TEE driver needs
> it when extending support to NVME and UFS?
>
> [...]
>
> Kind regards
> Uffe

