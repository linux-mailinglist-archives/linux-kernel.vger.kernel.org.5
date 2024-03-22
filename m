Return-Path: <linux-kernel+bounces-111775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BE58870D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1C0281CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1F57878;
	Fri, 22 Mar 2024 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtW0PJgR"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D257876
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124780; cv=none; b=XxCOouqX7owkfB+QKiVkluyLZp03PJMURngF1Sz+7Vt6RyezWRglNu5e6izoZGLLN9iRIzoEv9Aavg5RwvuV50piFnIBBcu69j90o97P0kF1NliICdiby7OrszncF6/5xtzMgELCDn1z7F4dKiVnW4EGHNq67kRNv1oyOsp61IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124780; c=relaxed/simple;
	bh=jPp+TH7YAuJ0YdWefCXyoJLE8vPSiQdm+lmf+doF/Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVwHCAzvPhp4UyRzh8xVEvzv+seUss/wHagTR9VMH19bDPz0JV15h5K67b6JrRQZ+5mV1UwelaM2xSJhT7EmrcnB/BcYWgr2LGMzFbWh1zbs3DgQm/8Fp9+Tqbbntns97hN+kzjUrCYqki6/4n+dBCKQaoUJDlw30fdK3snPIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtW0PJgR; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2443628276.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711124777; x=1711729577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyTGU6CnwLI0U8xKEsXP2Im7L4Z3CPUR203Rapc3+j4=;
        b=gtW0PJgRsLXSFn8A6n65fpLMNn5s0GaSwC6718ewAB36z4958RRxx49N4XekovSEUW
         lodEAiWh0PgjhYQ5hHjSKkZwfYFMhDHtg1h7K8bLc9ntafgQjk/J0THk+4tg2Qnp74R0
         NzS2tXWu7pmD/U9zXcyWmVNpysymi7a9QRFShTcuvc+t0UmmBkrsPxriYooG4kt2qEvQ
         W5x67myIZb/TQIwp+JySq4cQ1QYscDyQv8HK8d5GeGeMjeQVka4xSy+umg239BldkVjK
         KfeqizDdMz0THd1hcGPYknXASxjJ4Q1YLfVFX+6cpghGLiIP9B5ptqNbA1Oe8xWMmCod
         qVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711124777; x=1711729577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyTGU6CnwLI0U8xKEsXP2Im7L4Z3CPUR203Rapc3+j4=;
        b=YdJaQJW4AsCPvi1M0pqgdXbSDsY4rYvFhspporZFxM8jX6aq/+F6Fxndy2qEKyP9h6
         F9iokSaTvzT2idtrMX3jUe4blBVANJPT2SPxr1ntZdRWxCQbBnA4omr8I2Biq4KMy9Ul
         uB8kXNAEgeZWUrYXTX+TeAzld4dnMrBCy0AnyYBz6uP3oUh9wvNU3mTo3FPk2jAF1XCh
         OJm1IWqUDl0grrBN/83IxTNkK2l9VJ1udxKriXNon1GSz5urlBLQMurJ0gJZBvGDhEmV
         UfV9E0Rj3t7vD+haMERXHOxg0vN6JvW9J8Lu7ybNGz+u3/XDBHnJl28XBvRbgZa+4Ac7
         o9iQ==
X-Gm-Message-State: AOJu0Yz52lhin3s4mqaZpIuMP2IemjtUJa+L0HSyyqby9DdJhTcVAuyP
	SpeGxm31L6/to/vrtEeRumLKZKUZ6Z7ov3Mi3ExLkLq4MbcBcJ+r6uYhP561bd6aYLPc1NkLIFv
	+xwpDYMSNRzNQnRKOveGjdv3SyHl/09hfeDQ5ig==
X-Google-Smtp-Source: AGHT+IFxNBafwgHbsjAKLVZBuld+ExAS1fn8pvacHGnoSWpPjY1ydcXNjt8Jo3weqhAlKsaZh3dYqAKtyRj9y4PHVYc=
X-Received: by 2002:a25:8d03:0:b0:dc7:4671:8ae8 with SMTP id
 n3-20020a258d03000000b00dc746718ae8mr2533114ybl.65.1711124776833; Fri, 22 Mar
 2024 09:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org> <20240227153132.2611499-2-jens.wiklander@linaro.org>
In-Reply-To: <20240227153132.2611499-2-jens.wiklander@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Mar 2024 17:25:40 +0100
Message-ID: <CAPDyKFp5j+L=oE1uVyUdu7rVLxRcueWwP0XcNTTMMrFQgmeZiw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 at 16:31, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> partition provides authenticated and replay protected access, hence
> suitable as a secure storage.
>
> The initial aim of this patch is to provide a simple RPMB driver
> interface which can be accessed by the optee driver to facilitate early
> RPMB access to OP-TEE OS (secure OS) during the boot time.
>
> A TEE device driver can claim the RPMB interface, for example, via
> rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> provides a callback to route RPMB frames to the RPMB device accessible
> via rpmb_route_frames().
>
> The detailed operation of implementing the access is left to the TEE
> device driver itself.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/misc/Kconfig     |  10 ++
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/rpmb-core.c | 258 +++++++++++++++++++++++++++++++++++++++
>  include/linux/rpmb.h     | 195 +++++++++++++++++++++++++++++
>  5 files changed, 471 insertions(+)
>  create mode 100644 drivers/misc/rpmb-core.c
>  create mode 100644 include/linux/rpmb.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8999497011a2..e83152c42499 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19012,6 +19012,13 @@ T:     git git://linuxtv.org/media_tree.git
>  F:     Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-=
rotate.yaml
>  F:     drivers/media/platform/sunxi/sun8i-rotate/
>
> +RPMB SUBSYSTEM
> +M:     Jens Wiklander <jens.wiklander@linaro.org>
> +L:     linux-kernel@vger.kernel.org
> +S:     Supported
> +F:     drivers/misc/rpmb-core.c
> +F:     include/linux/rpmb.h
> +
>  RPMSG TTY DRIVER
>  M:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>  L:     linux-remoteproc@vger.kernel.org
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..dbff9e8c3a03 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -104,6 +104,16 @@ config PHANTOM
>           If you choose to build module, its name will be phantom. If uns=
ure,
>           say N here.
>
> +config RPMB
> +       tristate "RPMB partition interface"
> +       depends on MMC
> +       help
> +         Unified RPMB unit interface for RPMB capable devices such as eM=
MC and
> +         UFS. Provides interface for in-kernel security controllers to a=
ccess
> +         RPMB unit.
> +
> +         If unsure, select N.
> +
>  config TIFM_CORE
>         tristate "TI Flash Media interface support"
>         depends on PCI
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index ea6ea5bbbc9c..8af058ad1df4 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)           +=3D lkdtm/
>  obj-$(CONFIG_TIFM_CORE)        +=3D tifm_core.o
>  obj-$(CONFIG_TIFM_7XX1)        +=3D tifm_7xx1.o
>  obj-$(CONFIG_PHANTOM)          +=3D phantom.o
> +obj-$(CONFIG_RPMB)             +=3D rpmb-core.o
>  obj-$(CONFIG_QCOM_COINCELL)    +=3D qcom-coincell.o
>  obj-$(CONFIG_QCOM_FASTRPC)     +=3D fastrpc.o
>  obj-$(CONFIG_SENSORS_BH1770)   +=3D bh1770glc.o
> diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> new file mode 100644
> index 000000000000..e0003b039e9f
> --- /dev/null
> +++ b/drivers/misc/rpmb-core.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
> + * Copyright(c) 2021 - 2024 Linaro Ltd.
> + */
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/rpmb.h>
> +#include <linux/slab.h>
> +
> +static struct list_head rpmb_dev_list;
> +static struct list_head rpmb_intf_list;
> +static DEFINE_MUTEX(rpmb_mutex);
> +
> +/**
> + * rpmb_dev_get() - increase rpmb device ref counter
> + * @rdev: rpmb device
> + */
> +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> +{
> +       if (rdev)
> +               get_device(rdev->parent_dev);
> +       return rdev;
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_get);

As rpmb_dev_find_device() already bumps the reference count by calling
rpmb_dev_get(), why does this need to be exported and called by the
tee driver in patch3, too?

Would it not be sufficient to export only rpmb_dev_put()?

Ahh, I realized now that when calling ->add_rdev() callback, the mutex
is being held without first increasing the reference count. Hmm, I
don't know what makes the best sense here.

> +
> +/**
> + * rpmb_dev_put() - decrease rpmb device ref counter
> + * @rdev: rpmb device
> + */
> +void rpmb_dev_put(struct rpmb_dev *rdev)
> +{
> +       if (rdev)
> +               put_device(rdev->parent_dev);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_put);
> +
> +/**
> + * rpmb_route_frames() - route rpmb frames to rpmb device
> + * @rdev:      rpmb device
> + * @req:       rpmb request frames
> + * @req_len:   length of rpmb request frames in bytes
> + * @rsp:       rpmb response frames
> + * @rsp_len:   length of rpmb response frames in bytes
> + *
> + * Returns: < 0 on failure
> + */
> +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> +                     unsigned int req_len, u8 *rsp, unsigned int rsp_len=
)
> +{
> +       struct rpmb_frame *frm =3D (struct rpmb_frame *)req;
> +       u16 req_type;
> +       bool write;
> +
> +       if (!req || req_len < sizeof(*frm) || !rsp || !rsp_len)
> +               return -EINVAL;
> +
> +       req_type =3D be16_to_cpu(frm->req_resp);
> +       switch (req_type) {
> +       case RPMB_PROGRAM_KEY:
> +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> +                   rsp_len !=3D sizeof(struct rpmb_frame))
> +                       return -EINVAL;
> +               write =3D true;
> +               break;
> +       case RPMB_GET_WRITE_COUNTER:
> +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> +                   rsp_len !=3D sizeof(struct rpmb_frame))
> +                       return -EINVAL;
> +               write =3D false;
> +               break;
> +       case RPMB_WRITE_DATA:
> +               if (req_len % sizeof(struct rpmb_frame) ||
> +                   rsp_len !=3D sizeof(struct rpmb_frame))
> +                       return -EINVAL;
> +               write =3D true;
> +               break;
> +       case RPMB_READ_DATA:
> +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> +                   rsp_len % sizeof(struct rpmb_frame))
> +                       return -EINVAL;
> +               write =3D false;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return rdev->ops->route_frames(rdev->parent_dev, write,
> +                                      req, req_len, rsp, rsp_len);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_route_frames);
> +
> +/**
> + * rpmb_dev_find_device() - return first matching rpmb device
> + * @data: data for the match function
> + * @match: the matching function

There are a couple of missing parameters that should be described here.

Moreover, I think it's important to clarify that it's the caller's
responsibility to call rpmb_dev_put() on the returned rpmb_dev, when
it's ready with it.

> + *
> + * Returns: a matching rpmb device or NULL on failure
> + */
> +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> +                                     const struct rpmb_dev *start,
> +                                     int (*match)(struct rpmb_dev *rdev,
> +                                                  const void *data))
> +{
> +       struct rpmb_dev *rdev;
> +       struct list_head *pos;
> +
> +       mutex_lock(&rpmb_mutex);
> +       if (start)
> +               pos =3D start->list_node.next;
> +       else
> +               pos =3D rpmb_dev_list.next;
> +
> +       while (pos !=3D &rpmb_dev_list) {
> +               rdev =3D container_of(pos, struct rpmb_dev, list_node);
> +               if (match(rdev, data)) {
> +                       rpmb_dev_get(rdev);
> +                       goto out;
> +               }
> +               pos =3D pos->next;
> +       }
> +       rdev =3D NULL;
> +
> +out:
> +       mutex_unlock(&rpmb_mutex);
> +
> +       return rdev;
> +}
> +
> +/**
> + * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsy=
stem
> + * @rdev: the rpmb device to unregister

It would be nice to clarify in the function description for when this
should be called. Especially from the data-lifecycle point of view.

> + *
> + * Returns: < 0 on failure
> + */
> +int rpmb_dev_unregister(struct rpmb_dev *rdev)
> +{
> +       if (!rdev)
> +               return -EINVAL;
> +
> +       mutex_lock(&rpmb_mutex);
> +       list_del(&rdev->list_node);
> +       mutex_unlock(&rpmb_mutex);
> +       kfree(rdev->dev_id);
> +       kfree(rdev);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
> +
> +/**
> + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
> + * @dev: storage device of the rpmb device
> + * @ops: device specific operations
> + *
> + * While registering the RPMB partition extract needed device informatio=
n
> + * while needed resources are available.
> + *
> + * Returns: a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
> + */
> +struct rpmb_dev *rpmb_dev_register(struct device *dev,
> +                                  const struct rpmb_ops *ops)
> +{
> +       struct rpmb_dev *rdev;
> +       struct rpmb_interface *intf;
> +       int ret;
> +
> +       if (!dev || !ops || !ops->route_frames || !ops->set_dev_info)
> +               return ERR_PTR(-EINVAL);
> +
> +       rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> +       if (!rdev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mutex_lock(&rpmb_mutex);
> +       list_add_tail(&rdev->list_node, &rpmb_dev_list);
> +       mutex_unlock(&rpmb_mutex);

It does not look safe to add an rpmb_dev to the rpmb_dev_list, before
it has been completely initialized. The consumer of it may fetch it
and try use it before it's initialized.

> +
> +       rdev->ops =3D ops;
> +
> +       rdev->parent_dev =3D dev;
> +
> +       ret =3D ops->set_dev_info(dev, rdev);

Rather than using a callback to initialize the rpmb_dev, I would
suggest (and prefer) to let the corresponding data be provided as an
in-parameter to rpmb_dev_register() instead.

> +       if (ret)
> +               goto exit;
> +
> +       dev_dbg(rdev->parent_dev, "registered device\n");
> +
> +       mutex_lock(&rpmb_mutex);
> +       list_for_each_entry(intf, &rpmb_intf_list, list_node)
> +               if (intf->add_rdev)
> +                       intf->add_rdev(intf, rdev);

Rather than implementing our own specific notification mechanism, we
could make use of a "blocking_notifier" (include/linux/notifier.h)
instead.

Moreover, it looks like we are lacking a way to inform the consumer
driver that an rpmb_dev is being removed. Or maybe that isn't needed,
as the reference counting manages that for us?

> +       mutex_unlock(&rpmb_mutex);
> +
> +       return rdev;
> +
> +exit:
> +       mutex_lock(&rpmb_mutex);
> +       list_del(&rdev->list_node);
> +       mutex_unlock(&rpmb_mutex);
> +       kfree(rdev);
> +       return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_register);
> +
> +/**
> + * rpmb_interface_register() - register for new device notifications
> + *
> + * @intf : pointer to interface struct with a notification callback
> + */
> +void rpmb_interface_register(struct rpmb_interface *intf)
> +{
> +       struct rpmb_dev *rdev;
> +
> +       mutex_lock(&rpmb_mutex);
> +       list_add_tail(&intf->list_node, &rpmb_intf_list);
> +       if (intf->add_rdev)

Is there any reason to allow the ->add_rdev() callback to be optional?

> +               list_for_each_entry(rdev, &rpmb_dev_list, list_node)
> +                       intf->add_rdev(intf, rdev);

What if ->add_rdev() are happy to use one of the rpmb_dev, then we
will still continue to iterate over the list. Should we use a return
code to indicate if we should continue or not?

> +       mutex_unlock(&rpmb_mutex);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_interface_register);
> +
> +/**
> + * rpmb_interface_unregister() - unregister from new device notification=
s
> + *
> + * @intf : pointer to previously registered interface struct
> + */
> +void rpmb_interface_unregister(struct rpmb_interface *intf)
> +{
> +       mutex_lock(&rpmb_mutex);
> +       list_del(&intf->list_node);
> +       mutex_unlock(&rpmb_mutex);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
> +
> +static int __init rpmb_init(void)
> +{
> +       INIT_LIST_HEAD(&rpmb_dev_list);
> +       INIT_LIST_HEAD(&rpmb_intf_list);
> +       return 0;
> +}
> +
> +static void __exit rpmb_exit(void)
> +{
> +       mutex_destroy(&rpmb_mutex);
> +}
> +
> +subsys_initcall(rpmb_init);
> +module_exit(rpmb_exit);
> +
> +MODULE_AUTHOR("Jens Wiklander <jens.wiklander@linaro.org>");
> +MODULE_DESCRIPTION("RPMB class");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
> new file mode 100644
> index 000000000000..c4b13dad10c4
> --- /dev/null
> +++ b/include/linux/rpmb.h
> @@ -0,0 +1,195 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> +/*
> + * Copyright (C) 2015-2019 Intel Corp. All rights reserved
> + * Copyright (C) 2021-2022 Linaro Ltd
> + */
> +#ifndef __RPMB_H__
> +#define __RPMB_H__
> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +
> +/**
> + * struct rpmb_frame - rpmb frame as defined by specs
> + *
> + * @stuff        : stuff bytes
> + * @key_mac      : The authentication key or the message authentication
> + *                 code (MAC) depending on the request/response type.
> + *                 The MAC will be delivered in the last (or the only)
> + *                 block of data.
> + * @data         : Data to be written or read by signed access.
> + * @nonce        : Random number generated by the host for the requests
> + *                 and copied to the response by the RPMB engine.
> + * @write_counter: Counter value for the total amount of the successful
> + *                 authenticated data write requests made by the host.
> + * @addr         : Address of the data to be programmed to or read
> + *                 from the RPMB. Address is the serial number of
> + *                 the accessed block (half sector 256B).
> + * @block_count  : Number of blocks (half sectors, 256B) requested to be
> + *                 read/programmed.
> + * @result       : Includes information about the status of the write co=
unter
> + *                 (valid, expired) and result of the access made to the=
 RPMB.
> + * @req_resp     : Defines the type of request and response to/from the =
memory.
> + */
> +struct rpmb_frame {
> +       u8     stuff[196];
> +       u8     key_mac[32];
> +       u8     data[256];
> +       u8     nonce[16];
> +       __be32 write_counter;
> +       __be16 addr;
> +       __be16 block_count;
> +       __be16 result;
> +       __be16 req_resp;
> +} __packed;

I haven't looked at the NVME or the UFS spec in detail. Although, I
assume the above frame makes sense for those types of
interfaces/protocols too?

> +
> +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key=
 */
> +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
> +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition *=
/
> +#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal)=
 */
> +
> +#define RPMB_REQ2RESP(_OP) ((_OP) << 8)
> +#define RPMB_RESP2REQ(_OP) ((_OP) >> 8)
> +
> +/**
> + * enum rpmb_op_result - rpmb operation results
> + *
> + * @RPMB_ERR_OK      : operation successful
> + * @RPMB_ERR_GENERAL : general failure
> + * @RPMB_ERR_AUTH    : mac doesn't match or ac calculation failure
> + * @RPMB_ERR_COUNTER : counter doesn't match or counter increment failur=
e
> + * @RPMB_ERR_ADDRESS : address out of range or wrong address alignment
> + * @RPMB_ERR_WRITE   : data, counter, or result write failure
> + * @RPMB_ERR_READ    : data, counter, or result read failure
> + * @RPMB_ERR_NO_KEY  : authentication key not yet programmed
> + *
> + * @RPMB_ERR_COUNTER_EXPIRED:  counter expired
> + */
> +enum rpmb_op_result {
> +       RPMB_ERR_OK      =3D 0x0000,
> +       RPMB_ERR_GENERAL =3D 0x0001,
> +       RPMB_ERR_AUTH    =3D 0x0002,
> +       RPMB_ERR_COUNTER =3D 0x0003,
> +       RPMB_ERR_ADDRESS =3D 0x0004,
> +       RPMB_ERR_WRITE   =3D 0x0005,
> +       RPMB_ERR_READ    =3D 0x0006,
> +       RPMB_ERR_NO_KEY  =3D 0x0007,
> +
> +       RPMB_ERR_COUNTER_EXPIRED =3D 0x0080
> +};
> +
> +/**
> + * enum rpmb_type - type of underlying storage technology
> + *
> + * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
> + * @RPMB_TYPE_UFS   : UFS (JESD220)
> + * @RPMB_TYPE_NVME  : NVM Express
> + */
> +enum rpmb_type {
> +       RPMB_TYPE_EMMC,
> +       RPMB_TYPE_UFS,
> +       RPMB_TYPE_NVME,
> +};
> +
> +/**
> + * struct rpmb_dev - device which can support RPMB partition
> + *
> + * @parent_dev       : parent device
> + * @list_node        : linked list node
> + * @ops              : operation exported by rpmb
> + * @dev_id           : unique device identifier read from the hardware

This part puzzled me a bit, when I realized that they are used as an
input to derive the authentication-data.

For eMMC (as shown in patch2), we have chosen to use the CID register
data, which makes perfect sense to me. However, I think it's important
to clarify what this field is being used for, here in the description
too.

> + * @dev_id_len       : length of unique device identifier
> + * @reliable_wr_count: number of sectors that can be written in one acce=
ss
> + * @capacity         : capacity of the device in units of 128K
> + */
> +struct rpmb_dev {
> +       struct device *parent_dev;
> +       struct list_head list_node;
> +       const struct rpmb_ops *ops;
> +       u8 *dev_id;
> +       size_t dev_id_len;
> +       u16 reliable_wr_count;
> +       u16 capacity;
> +};
> +
> +/**
> + * struct rpmb_ops - RPMB ops to be implemented by underlying block devi=
ce
> + *
> + * @type          : block device type
> + * @route_frames  : routes frames to and from the RPMB device
> + * @set_dev_info  : extracts device info from the RPMB device
> + */
> +struct rpmb_ops {
> +       enum rpmb_type type;

I would keep this in the rpmb_dev instead, as it's not really a callback (o=
ps).

> +       int (*set_dev_info)(struct device *dev, struct rpmb_dev *rdev);

As I suggested earlier, we should be able to drop the above callback.
That said, it looks like we end up with only one callback left, so
maybe just put that in the struct rpmb_dev instead?

> +       int (*route_frames)(struct device *dev, bool write,
> +                           u8 *req, unsigned int req_len,
> +                           u8 *resp, unsigned int resp_len);
> +};
> +
> +/**
> + * struct rpmb_interface - subscribe to new RPMB devices
> + *
> + * @list_node     : linked list node
> + * @add_rdev      : notifies that a new RPMB device has been found
> + */
> +struct rpmb_interface {
> +       struct list_head list_node;
> +       void (*add_rdev)(struct rpmb_interface *intf, struct rpmb_dev *rd=
ev);
> +};
> +
> +#if IS_ENABLED(CONFIG_RPMB)
> +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
> +void rpmb_dev_put(struct rpmb_dev *rdev);
> +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> +                                     const struct rpmb_dev *start,
> +                                     int (*match)(struct rpmb_dev *rdev,
> +                                                  const void *data));
> +struct rpmb_dev *rpmb_dev_register(struct device *dev,
> +                                  const struct rpmb_ops *ops);
> +int rpmb_dev_unregister(struct rpmb_dev *rdev);
> +
> +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> +                     unsigned int req_len, u8 *resp, unsigned int resp_l=
en);
> +
> +void rpmb_interface_register(struct rpmb_interface *intf);
> +void rpmb_interface_unregister(struct rpmb_interface *intf);
> +#else
> +static inline struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> +{
> +       return NULL;
> +}
> +
> +static inline void rpmb_dev_put(struct rpmb_dev *rdev) { }
> +
> +static inline struct rpmb_dev *
> +rpmb_dev_find_device(const void *data, const struct rpmb_dev *start,
> +                    int (*match)(struct rpmb_dev *rdev, const void *data=
))
> +{
> +       return NULL;
> +}
> +
> +static inline struct rpmb_dev *
> +rpmb_dev_register(struct device *dev, const struct rpmb_ops *ops)
> +{
> +       return NULL;
> +}
> +
> +static inline int rpmb_dev_unregister(struct rpmb_dev *dev)
> +{
> +       return 0;
> +}
> +
> +static inline int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> +                                   unsigned int req_len, u8 *resp,
> +                                   unsigned int resp_len)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline void rpmb_interface_register(struct rpmb_interface *intf) =
{ }
> +static inline void rpmb_interface_unregister(struct rpmb_interface *intf=
) { }
> +#endif /* CONFIG_RPMB */
> +
> +#endif /* __RPMB_H__ */
> --
> 2.34.1
>

Kind regards
Uffe

