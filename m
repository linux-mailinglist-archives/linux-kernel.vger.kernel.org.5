Return-Path: <linux-kernel+bounces-48022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F684565E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6CD287D80
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9731615D5A7;
	Thu,  1 Feb 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuUBqucW"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C1315B970
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787572; cv=none; b=l6e1Y4ucuIOjxB5Hkbz1RU4uui/Nll3JNyW8t+mQ7LUS6WF8iuKbNGhaNWnez9O2J9AXI+svcQtIauccmElLQu5N+LC/wwcClbl6vEIfc6vr2VDwM2S1/M5vcYnvIDP+FNDQdVkit24M5GDrWsDD4+3th8vBeim9M/mnfF1tm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787572; c=relaxed/simple;
	bh=xcL6s1Bq2w54lbP4i4OtFL1LPYy3fOZH0SfAWhqCcqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIokU2RovNQUqaAIuUpKY1pl15oAdehNfVcRcVL6VnSKoLNle0qwM5iZw2VMpuNhfWtH49YLCc6b5i/qm9sso493f79Pa6lGCftRVl6Buvzgl6vqC4PuTEDQPMbWyfGa50gawkyliR1QCa7bYdggOt1Ztf2B0uM1eeb6UJ9DqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UuUBqucW; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59a8ecbadf7so367460eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706787569; x=1707392369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDYGx+taIjkEtLDF3e8GG+vO4dY+SCmgebrDZRPNBdg=;
        b=UuUBqucWJZtZnVpjfEj5Y9aA9vHrznckc+fYWanxQINbgjowHahAomRM4uzTNiou5V
         u+bI/s/6tcrXEfn+2q5zHTpHJlLf83m2d2ZV4r5In27yn0FDqljysKFCKC7SeZQ+SidO
         n05+lN2A1DGFhQtbPJV6D6QNC8xc2ndeu74I0oj06ZsbvdcfjevZkjcNtGNNUipSeVbs
         7/cycjvrI6ca2rW53v9Psk6JdQA7Ni+UKnAOIr8JzBT7jEfyjukgKEHayA5DKMWwLKx9
         kJmKQz376/L3l9Bwy0GFW6pEEwCa3xjR8R1fO7QH9h87d7yaXKby2SiwUI5ByCHP8qMA
         GTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706787569; x=1707392369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDYGx+taIjkEtLDF3e8GG+vO4dY+SCmgebrDZRPNBdg=;
        b=oFFbAB0W+zgEfkWhs8hTqfjnyeiaPjVXXEWJpzKeB0rrnZxssEGFvjBrEzJfFuCYkW
         o9CLVcFPfrWCmDUJp+TyiPa6PWZMfZZ2XhIqG1apOzEx4BmiSB4Xr3P1zW0ZSQowV3N2
         Time/TkNDQ68cRSMyY3r5TRq+3uk8SVMTWNmzIhH8gkkuuR+jAd21Aa0O8H9Sh0jIS1K
         Hapn8wwDrwxtrpZRYktiZQiEMxKoLkBcFHBYkK9gf5BYxrf8crRfMeKJiedoRhc96sUE
         /yBVBFZJXQqymaz5AdLoj9uhET0z2bOGFcPX1y9l328CiBg+lvzZhIb4oeKmypn3XjL4
         CZyg==
X-Gm-Message-State: AOJu0YxqUtfzYdWM9XbFawkf4WXs6RBrv3cm2dFQ4+YvegSHGhj4e5xI
	20kKK7Zsh1+WChMdYEzmH10JejLcSCGBgb9FGupN3NX5SIBfWWkaTLZbtNIGQ1dLvgLClakmz/1
	h/vcpAfkZULBeW7FauXjIeXmAbfU1wQDhvkrXFA==
X-Google-Smtp-Source: AGHT+IFA+dn/9ZhRl6yhyA1YfPf8MiEw+0CW5/qz1iT6gz9YEhCL0Dkc7NHJH8pn4HQKdRJ9B9feEpDdYQnoW19OJ/Y=
X-Received: by 2002:a4a:d847:0:b0:59a:3ad:4ff1 with SMTP id
 g7-20020a4ad847000000b0059a03ad4ff1mr1685877oov.3.1706787569156; Thu, 01 Feb
 2024 03:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <09e318f9-ccb6-4c0c-b06d-d433d44d6e25@infradead.org>
In-Reply-To: <09e318f9-ccb6-4c0c-b06d-d433d44d6e25@infradead.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 1 Feb 2024 12:39:17 +0100
Message-ID: <CAHUa44EmZVBVfQPexthZXDyCo_VKwZBuKH1Lz1pL4FSeJubVRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:04=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Hi,
>
> On 1/31/24 09:43, Jens Wiklander wrote:
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
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > class_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > provides a callback to route RPMB frames to the RPMB device accessible
> > via rpmb_route_frames().
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
>
>
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 4fb291f0bf7c..891aa5763666 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -104,6 +104,15 @@ config PHANTOM
> >         If you choose to build module, its name will be phantom. If uns=
ure,
> >         say N here.
> >
> > +config RPMB
> > +     tristate "RPMB partition interface"
> > +     help
> > +       Unified RPMB unit interface for RPMB capable devices such as eM=
MC and
> > +       UFS. Provides interface for in kernel security controllers to a=
ccess
>
>                                       in-kernel
>
> > +       RPMB unit.
> > +
> > +       If unsure, select N.
> > +
> >  config TIFM_CORE
> >       tristate "TI Flash Media interface support"
> >       depends on PCI
>
>
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
>
> > +
> > +/**
> > + * rpmb_route_frames() - route rpmb frames to rpmb device
> > + * @rdev:    rpmb device
> > + * @req:     rpmb request frames
> > + * @req_len: length of rpmb request frames in bytes
> > + * @rsp:     rpmb response frames
> > + * @rsp_len: length of rpmb response frames in bytes
> > + *
> > + * @return < 0 on failure
>
> Above needs a colon ':' after @return, although using
>  * Return:
> is preferable IMO.

Thanks, I'll change to "* Return:" instead, everywhere in this patch.

>
> > + */
> > +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> > +                   unsigned int req_len, u8 *rsp, unsigned int rsp_len=
)
> > +{
>
>
> > +/**
> > + * rpmb_dev_find_device() - return first matching rpmb device
> > + * @data: data for the match function
> > + * @match: the matching function
> > + *
> > + * @returns a matching rpmb device or NULL on failure
>
>     * @returns:
> or
>     * Returns:
>
> > + */
> > +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> > +                                   const struct rpmb_dev *start,
> > +                                   int (*match)(struct device *dev,
> > +                                                const void *data))
> > +{
> > +     struct device *dev;
> > +     const struct device *start_dev =3D NULL;
> > +
> > +     if (start)
> > +             start_dev =3D &start->dev;
> > +     dev =3D class_find_device(&rpmb_class, start_dev, data, match);
> > +
> > +     return dev ? to_rpmb_dev(dev) : NULL;
> > +}
> > +
> > +/**
> > + * rpmb_dev_unregister() - unregister RPMB partition from the RPMB sub=
system
> > + * @rdev: the rpmb device to unregister
> > + *
> > + * @returns < 0 on failure
>
> Ditto.
>
> > + */
> > +int rpmb_dev_unregister(struct rpmb_dev *rdev)
> > +{
> > +     if (!rdev)
> > +             return -EINVAL;
> > +
> > +     device_del(&rdev->dev);
> > +
> > +     rpmb_dev_put(rdev);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
> > +
> > +/**
> > + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
> > + * @dev: storage device of the rpmb device
> > + * @target: RPMB target/region within the physical device
>
> There is no @target function parameter.

You're right, I'll remove it.

>
> > + * @ops: device specific operations
> > + *
> > + * While registering the RPMB partition get references to needed resou=
rces
> > + * with the @ops->get_resources() callback and extracts needed devices
> > + * information while needed resources are available.
> > + *
> > + * @returns a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
>
> Ditto for Return syntax.
>
> > + */
> > +struct rpmb_dev *rpmb_dev_register(struct device *dev,
> > +                                const struct rpmb_ops *ops)
> > +{
> > +     struct rpmb_dev *rdev;
> > +     int id;
> > +     int ret;
> > +
> > +     if (!dev || !ops || !ops->get_resources ||
> > +         !ops->put_resources || !ops->route_frames ||
> > +         !ops->set_dev_info)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> > +     if (!rdev)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     mutex_lock(&rpmb_mutex);
> > +     id =3D ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
> > +     mutex_unlock(&rpmb_mutex);
> > +     if (id < 0) {
> > +             ret =3D id;
> > +             goto exit;
> > +     }
> > +
> > +     rdev->ops =3D ops;
> > +     rdev->id =3D id;
> > +
> > +     dev_set_name(&rdev->dev, "rpmb%d", id);
> > +     rdev->dev.class =3D &rpmb_class;
> > +     rdev->dev.parent =3D dev;
> > +
> > +     ret =3D ops->set_dev_info(dev, rdev);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     ret =3D device_register(&rdev->dev);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     ops->get_resources(rdev->dev.parent);
> > +
> > +     dev_dbg(&rdev->dev, "registered device\n");
> > +
> > +     return rdev;
> > +
> > +exit:
> > +     if (id >=3D 0) {
> > +             mutex_lock(&rpmb_mutex);
> > +             ida_simple_remove(&rpmb_ida, id);
> > +             mutex_unlock(&rpmb_mutex);
> > +     }
> > +     kfree(rdev);
> > +     return ERR_PTR(ret);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_register);
>
>
> > diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
> > new file mode 100644
> > index 000000000000..45073513264a
> > --- /dev/null
> > +++ b/include/linux/rpmb.h
> > @@ -0,0 +1,184 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> > +/*
> > + * Copyright (C) 2015-2019 Intel Corp. All rights reserved
> > + * Copyright (C) 2021-2022 Linaro Ltd
> > + */
> > +#ifndef __RPMB_H__
> > +#define __RPMB_H__
> > +
> > +#include <linux/types.h>
> > +#include <linux/device.h>
> > +
> > +/**
> > + * struct rpmb_frame - rpmb frame as defined by specs
> > + *
> > + * @stuff        : stuff bytes
> > + * @key_mac      : The authentication key or the message authenticatio=
n
> > + *                 code (MAC) depending on the request/response type.
> > + *                 The MAC will be delivered in the last (or the only)
> > + *                 block of data.
> > + * @data         : Data to be written or read by signed access.
> > + * @nonce        : Random number generated by the host for the request=
s
> > + *                 and copied to the response by the RPMB engine.
> > + * @write_counter: Counter value for the total amount of the successfu=
l
> > + *                 authenticated data write requests made by the host.
> > + * @addr         : Address of the data to be programmed to or read
> > + *                 from the RPMB. Address is the serial number of
> > + *                 the accessed block (half sector 256B).
> > + * @block_count  : Number of blocks (half sectors, 256B) requested to =
be
> > + *                 read/programmed.
> > + * @result       : Includes information about the status of the write =
counter
> > + *                 (valid, expired) and result of the access made to t=
he RPMB.
> > + * @req_resp     : Defines the type of request and response to/from th=
e memory.
> > + */
> > +struct rpmb_frame {
> > +     u8     stuff[196];
> > +     u8     key_mac[32];
> > +     u8     data[256];
> > +     u8     nonce[16];
> > +     __be32 write_counter;
> > +     __be16 addr;
> > +     __be16 block_count;
> > +     __be16 result;
> > +     __be16 req_resp;
> > +} __packed;
> > +
> > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication K=
ey */
> > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition =
*/
> > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition=
 */
> > +#define RPMB_RESULT_READ       0x5    /* Read result request  (Interna=
l) */
> > +
> > +#define RPMB_REQ2RESP(_OP) ((_OP) << 8)
> > +#define RPMB_RESP2REQ(_OP) ((_OP) >> 8)
> > +
> > +/**
> > + * enum rpmb_op_result - rpmb operation results
> > + *
> > + * @RPMB_ERR_OK      : operation successful
> > + * @RPMB_ERR_GENERAL : general failure
> > + * @RPMB_ERR_AUTH    : mac doesn't match or ac calculation failure
> > + * @RPMB_ERR_COUNTER : counter doesn't match or counter increment fail=
ure
> > + * @RPMB_ERR_ADDRESS : address out of range or wrong address alignment
> > + * @RPMB_ERR_WRITE   : data, counter, or result write failure
> > + * @RPMB_ERR_READ    : data, counter, or result read failure
> > + * @RPMB_ERR_NO_KEY  : authentication key not yet programmed
> > + *
> > + * @RPMB_ERR_COUNTER_EXPIRED:  counter expired
> > + */
> > +enum rpmb_op_result {
> > +     RPMB_ERR_OK      =3D 0x0000,
> > +     RPMB_ERR_GENERAL =3D 0x0001,
> > +     RPMB_ERR_AUTH    =3D 0x0002,
> > +     RPMB_ERR_COUNTER =3D 0x0003,
> > +     RPMB_ERR_ADDRESS =3D 0x0004,
> > +     RPMB_ERR_WRITE   =3D 0x0005,
> > +     RPMB_ERR_READ    =3D 0x0006,
> > +     RPMB_ERR_NO_KEY  =3D 0x0007,
> > +
> > +     RPMB_ERR_COUNTER_EXPIRED =3D 0x0080
> > +};
> > +
> > +/**
> > + * enum rpmb_type - type of underlaying storage technology
>
>                                underlying

Thanks

>
> > + *
> > + * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
> > + * @RPMB_TYPE_UFS   : UFS (JESD220)
> > + * @RPMB_TYPE_NVME  : NVM Express
> > + */
> > +enum rpmb_type {
> > +     RPMB_TYPE_EMMC,
> > +     RPMB_TYPE_UFS,
> > +     RPMB_TYPE_NVME,
> > +};
> > +
> > +/**
> > + * struct rpmb_dev - device which can support RPMB partition
> > + *
> > + * @dev              : device
> > + * @id               : device id;
> > + * @ops              : operation exported by rpmb
> > + * @dev_id           : unique device identifier read from the hardware
> > + * @dev_id_len       : length of unique device identifier
> > + * @reliable_wr_count: number of sectors that can be written in one ac=
cess
> > + * @capacity         : capacity of the device in units of 128K
> > + */
> > +struct rpmb_dev {
> > +     struct device dev;
> > +     int id;
> > +     const struct rpmb_ops *ops;
> > +     u8 *dev_id;
> > +     size_t dev_id_len;
> > +     u16 reliable_wr_count;
> > +     u16 capacity;
> > +};
> > +
> > +#define to_rpmb_dev(x) container_of((x), struct rpmb_dev, dev)
> > +
> > +/**
> > + * struct rpmb_ops - RPMB ops to be implemented by underlying block de=
vice
> > + *
> > + * @type          : block device type
> > + * @get_resources : gets references to needed resources in rpmb_dev_re=
gister()
> > + * @put_resources : puts references from resources in rpmb_dev_release=
()
> > + * @route_frames  : routes frames to and from the RPMB device
> > + * @get_dev_info  : extracts device info from the RPMB device
>
>        set_dev_info ???

Yes.

Thanks,
Jens

>
> > + */
> > +struct rpmb_ops {
> > +     enum rpmb_type type;
> > +     void (*get_resources)(struct device *dev);
> > +     void (*put_resources)(struct device *dev);
> > +     int (*set_dev_info)(struct device *dev, struct rpmb_dev *rdev);
> > +     int (*route_frames)(struct device *dev, bool write,
> > +                         u8 *req, unsigned int req_len,
> > +                         u8 *resp, unsigned int resp_len);
> > +};
> > +
>
> thanks.
> --
> #Randy

