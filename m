Return-Path: <linux-kernel+bounces-122482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C10888F84B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A7A28676D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E9337719;
	Thu, 28 Mar 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZclmSg/"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC4291E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609143; cv=none; b=NifJJScjvV2lPrGKlmloZkUKoarnXYQQti5kWd1r1Icycr8L5K31NR5UvG62+LOsoyDfB0CVi/qLLNEtJViVV0pQujfF5mw83Ywlfo7fzVgJkZD8qcb5ocKqbKa2pe/Ce1Y+GzI7Q0l3KFND0guEKblwVRSXjU8Y7cg5FsswCw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609143; c=relaxed/simple;
	bh=5HMzgxY7WW8F6zsMJTpxD5wIbwKEFnIUmtImY4cwgmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riw324P57iXrMyDQBjZJ8DPcPxqo3CZi5w4c0mfPDjDWhap4hp+WJWBg5biD919HK++tiZlVEwpuB11TAwRbDjOXoiFyRKE6ML4T60RE2nA6G3RHLO8p1Uo+yyBiksfsWj7LPpcGIHLlOK4BAvK4rxVjdCgNI9cQa3tEheE/Yrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AZclmSg/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e675181ceaso371340a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711609140; x=1712213940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBOGKnDe7uDI9W9DtUlhJOQmAOpgqzH57s007bQc00I=;
        b=AZclmSg/s0ZJH2MS1OkHsKxymB8uzQwBc67NcWu/ldK+h+X1hljP1v7oiBLcBglfbR
         A/MyrrvI/kUQcqsgjHis2xhzldKVxWLWd7350drBvX7iq1kSvKE6kj3rrs2jjAvzmWPq
         2EH3nmuiU9/iOX518Dzbs3n8/ojqqLULyArmGElo7HSVI39fqqXt6cQ0p2/DktNjeLO3
         typXCBlJfCJ/JDeRDG5AScnq/7akLmrvfytpuTTeeO/121FHCY6GwNLguTd+OamZ7y2p
         CXkktyBdPRdWvMN08bUK7RlKQi7x+KhD8RKAWdnvdJUHC4EYn81c+79TNoBaW3cFQFRz
         gOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711609140; x=1712213940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBOGKnDe7uDI9W9DtUlhJOQmAOpgqzH57s007bQc00I=;
        b=upoyRE6VvYSPxEt95AB8tostOgqBwbDk0eolHYw02CRFCZQ4TMU23V+VxFO+5lSaQJ
         xWJ2ryHivph77mdFXJ++ddnbN5B3jEux0FQAaunU05iv2NT/ydA15eBHyVt8k462yH4o
         kkPjdg8h3vCLT+F3MnF6PzRlkyfgagRwRj9R680W7MKzJm1BklNifwriiI1Qmdj3Ilko
         5TVchuVglWQuXlFsuQjwXAHmew6aHZ56SZyIowGMyryBw0txtjmtICyGNWGfe+gUBupE
         gbw3AfChQpFH3yU0Fj3zbJSc95c7HVunXsFFKvPqDaZEifzBIvksfg9H9yxk08E8uFjB
         10Zg==
X-Gm-Message-State: AOJu0YwfCYfo9DW233zU29lLvxmQ9DwwqzYUFriT5bU1irHdg3AZhvOC
	0grznvi2N3x7tWWAcJ/ElsY04MA1whUG0hnNdxCNwv0K+eOPCJNO32+zJA9pvnBBXPJ8tfhx5Vd
	WFRkQi4mALSP6URnxG7VPFMOwMP97B7CKtoEpnQ==
X-Google-Smtp-Source: AGHT+IFsq1AS1UHQNpFcKEroTd6NfWvjt9v8A/3vlvnPXGyWv8WUJrMVCNwdhE01JA7O24TG2351qaJp6jYQlyH/Rjs=
X-Received: by 2002:a05:6871:88b:b0:22a:107c:4ddf with SMTP id
 r11-20020a056871088b00b0022a107c4ddfmr2002032oaq.23.1711609139976; Wed, 27
 Mar 2024 23:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org> <CAPDyKFp5j+L=oE1uVyUdu7rVLxRcueWwP0XcNTTMMrFQgmeZiw@mail.gmail.com>
In-Reply-To: <CAPDyKFp5j+L=oE1uVyUdu7rVLxRcueWwP0XcNTTMMrFQgmeZiw@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 28 Mar 2024 07:58:48 +0100
Message-ID: <CAHUa44Fr42j07Rshu0JS5Kwu6xL2aroGkz=Xp1xwBLLLSkQgLw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Ulf Hansson <ulf.hansson@linaro.org>
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

On Fri, Mar 22, 2024 at 5:26=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Tue, 27 Feb 2024 at 16:31, Jens Wiklander <jens.wiklander@linaro.org> =
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
> > The initial aim of this patch is to provide a simple RPMB driver
> > interface which can be accessed by the optee driver to facilitate early
> > RPMB access to OP-TEE OS (secure OS) during the boot time.
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
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
> >  drivers/misc/Kconfig     |  10 ++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/rpmb-core.c | 258 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/rpmb.h     | 195 +++++++++++++++++++++++++++++
> >  5 files changed, 471 insertions(+)
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
> > index 4fb291f0bf7c..dbff9e8c3a03 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -104,6 +104,16 @@ config PHANTOM
> >           If you choose to build module, its name will be phantom. If u=
nsure,
> >           say N here.
> >
> > +config RPMB
> > +       tristate "RPMB partition interface"
> > +       depends on MMC
> > +       help
> > +         Unified RPMB unit interface for RPMB capable devices such as =
eMMC and
> > +         UFS. Provides interface for in-kernel security controllers to=
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
> > index 000000000000..e0003b039e9f
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,258 @@
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
> > +static struct list_head rpmb_dev_list;
> > +static struct list_head rpmb_intf_list;
> > +static DEFINE_MUTEX(rpmb_mutex);
> > +
> > +/**
> > + * rpmb_dev_get() - increase rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > +{
> > +       if (rdev)
> > +               get_device(rdev->parent_dev);
> > +       return rdev;
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_get);
>
> As rpmb_dev_find_device() already bumps the reference count by calling
> rpmb_dev_get(), why does this need to be exported and called by the
> tee driver in patch3, too?
>
> Would it not be sufficient to export only rpmb_dev_put()?
>
> Ahh, I realized now that when calling ->add_rdev() callback, the mutex
> is being held without first increasing the reference count. Hmm, I
> don't know what makes the best sense here.

rpmb_dev_get() is needed in another place in the OP-TEE driver too,
I'll get to that below.

>
> > +
> > +/**
> > + * rpmb_dev_put() - decrease rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +void rpmb_dev_put(struct rpmb_dev *rdev)
> > +{
> > +       if (rdev)
> > +               put_device(rdev->parent_dev);
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
> > + * Returns: < 0 on failure
> > + */
> > +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> > +                     unsigned int req_len, u8 *rsp, unsigned int rsp_l=
en)
> > +{
> > +       struct rpmb_frame *frm =3D (struct rpmb_frame *)req;
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
> > +       return rdev->ops->route_frames(rdev->parent_dev, write,
> > +                                      req, req_len, rsp, rsp_len);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_route_frames);
> > +
> > +/**
> > + * rpmb_dev_find_device() - return first matching rpmb device
> > + * @data: data for the match function
> > + * @match: the matching function
>
> There are a couple of missing parameters that should be described here.
>
> Moreover, I think it's important to clarify that it's the caller's
> responsibility to call rpmb_dev_put() on the returned rpmb_dev, when
> it's ready with it.

I'll update.

>
> > + *
> > + * Returns: a matching rpmb device or NULL on failure
> > + */
> > +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> > +                                     const struct rpmb_dev *start,
> > +                                     int (*match)(struct rpmb_dev *rde=
v,
> > +                                                  const void *data))
> > +{
> > +       struct rpmb_dev *rdev;
> > +       struct list_head *pos;
> > +
> > +       mutex_lock(&rpmb_mutex);
> > +       if (start)
> > +               pos =3D start->list_node.next;
> > +       else
> > +               pos =3D rpmb_dev_list.next;
> > +
> > +       while (pos !=3D &rpmb_dev_list) {
> > +               rdev =3D container_of(pos, struct rpmb_dev, list_node);
> > +               if (match(rdev, data)) {
> > +                       rpmb_dev_get(rdev);
> > +                       goto out;
> > +               }
> > +               pos =3D pos->next;
> > +       }
> > +       rdev =3D NULL;
> > +
> > +out:
> > +       mutex_unlock(&rpmb_mutex);
> > +
> > +       return rdev;
> > +}
> > +
> > +/**
> > + * rpmb_dev_unregister() - unregister RPMB partition from the RPMB sub=
system
> > + * @rdev: the rpmb device to unregister
>
> It would be nice to clarify in the function description for when this
> should be called. Especially from the data-lifecycle point of view.

OK, I'll update.

>
> > + *
> > + * Returns: < 0 on failure
> > + */
> > +int rpmb_dev_unregister(struct rpmb_dev *rdev)
> > +{
> > +       if (!rdev)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&rpmb_mutex);
> > +       list_del(&rdev->list_node);
> > +       mutex_unlock(&rpmb_mutex);
> > +       kfree(rdev->dev_id);
> > +       kfree(rdev);
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
> > +
> > +/**
> > + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
> > + * @dev: storage device of the rpmb device
> > + * @ops: device specific operations
> > + *
> > + * While registering the RPMB partition extract needed device informat=
ion
> > + * while needed resources are available.
> > + *
> > + * Returns: a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
> > + */
> > +struct rpmb_dev *rpmb_dev_register(struct device *dev,
> > +                                  const struct rpmb_ops *ops)
> > +{
> > +       struct rpmb_dev *rdev;
> > +       struct rpmb_interface *intf;
> > +       int ret;
> > +
> > +       if (!dev || !ops || !ops->route_frames || !ops->set_dev_info)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> > +       if (!rdev)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       mutex_lock(&rpmb_mutex);
> > +       list_add_tail(&rdev->list_node, &rpmb_dev_list);
> > +       mutex_unlock(&rpmb_mutex);
>
> It does not look safe to add an rpmb_dev to the rpmb_dev_list, before
> it has been completely initialized. The consumer of it may fetch it
> and try use it before it's initialized.

You're right, I'll move the registration to the end of mmc_blk_probe().

>
> > +
> > +       rdev->ops =3D ops;
> > +
> > +       rdev->parent_dev =3D dev;
> > +
> > +       ret =3D ops->set_dev_info(dev, rdev);
>
> Rather than using a callback to initialize the rpmb_dev, I would
> suggest (and prefer) to let the corresponding data be provided as an
> in-parameter to rpmb_dev_register() instead.

OK

>
> > +       if (ret)
> > +               goto exit;
> > +
> > +       dev_dbg(rdev->parent_dev, "registered device\n");
> > +
> > +       mutex_lock(&rpmb_mutex);
> > +       list_for_each_entry(intf, &rpmb_intf_list, list_node)
> > +               if (intf->add_rdev)
> > +                       intf->add_rdev(intf, rdev);
>
> Rather than implementing our own specific notification mechanism, we
> could make use of a "blocking_notifier" (include/linux/notifier.h)
> instead.

Good idea, I'll use that.

>
> Moreover, it looks like we are lacking a way to inform the consumer
> driver that an rpmb_dev is being removed. Or maybe that isn't needed,
> as the reference counting manages that for us?

Yes, the reference counting is managing this.

>
> > +       mutex_unlock(&rpmb_mutex);
> > +
> > +       return rdev;
> > +
> > +exit:
> > +       mutex_lock(&rpmb_mutex);
> > +       list_del(&rdev->list_node);
> > +       mutex_unlock(&rpmb_mutex);
> > +       kfree(rdev);
> > +       return ERR_PTR(ret);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_register);
> > +
> > +/**
> > + * rpmb_interface_register() - register for new device notifications
> > + *
> > + * @intf : pointer to interface struct with a notification callback
> > + */
> > +void rpmb_interface_register(struct rpmb_interface *intf)
> > +{
> > +       struct rpmb_dev *rdev;
> > +
> > +       mutex_lock(&rpmb_mutex);
> > +       list_add_tail(&intf->list_node, &rpmb_intf_list);
> > +       if (intf->add_rdev)
>
> Is there any reason to allow the ->add_rdev() callback to be optional?

No, I'll fix.

>
> > +               list_for_each_entry(rdev, &rpmb_dev_list, list_node)
> > +                       intf->add_rdev(intf, rdev);
>
> What if ->add_rdev() are happy to use one of the rpmb_dev, then we
> will still continue to iterate over the list. Should we use a return
> code to indicate if we should continue or not?

I'm switching to "blocking_notifier".

>
> > +       mutex_unlock(&rpmb_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_interface_register);
> > +
> > +/**
> > + * rpmb_interface_unregister() - unregister from new device notificati=
ons
> > + *
> > + * @intf : pointer to previously registered interface struct
> > + */
> > +void rpmb_interface_unregister(struct rpmb_interface *intf)
> > +{
> > +       mutex_lock(&rpmb_mutex);
> > +       list_del(&intf->list_node);
> > +       mutex_unlock(&rpmb_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
> > +
> > +static int __init rpmb_init(void)
> > +{
> > +       INIT_LIST_HEAD(&rpmb_dev_list);
> > +       INIT_LIST_HEAD(&rpmb_intf_list);
> > +       return 0;
> > +}
> > +
> > +static void __exit rpmb_exit(void)
> > +{
> > +       mutex_destroy(&rpmb_mutex);
> > +}
> > +
> > +subsys_initcall(rpmb_init);
> > +module_exit(rpmb_exit);
> > +
> > +MODULE_AUTHOR("Jens Wiklander <jens.wiklander@linaro.org>");
> > +MODULE_DESCRIPTION("RPMB class");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
> > new file mode 100644
> > index 000000000000..c4b13dad10c4
> > --- /dev/null
> > +++ b/include/linux/rpmb.h
> > @@ -0,0 +1,195 @@
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
> > +       u8     stuff[196];
> > +       u8     key_mac[32];
> > +       u8     data[256];
> > +       u8     nonce[16];
> > +       __be32 write_counter;
> > +       __be16 addr;
> > +       __be16 block_count;
> > +       __be16 result;
> > +       __be16 req_resp;
> > +} __packed;
>
> I haven't looked at the NVME or the UFS spec in detail. Although, I
> assume the above frame makes sense for those types of
> interfaces/protocols too?

This is MMC-specific as we learned in the mail thread. I'll move this
into the MMC-specific code.

>
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
> > +       RPMB_ERR_OK      =3D 0x0000,
> > +       RPMB_ERR_GENERAL =3D 0x0001,
> > +       RPMB_ERR_AUTH    =3D 0x0002,
> > +       RPMB_ERR_COUNTER =3D 0x0003,
> > +       RPMB_ERR_ADDRESS =3D 0x0004,
> > +       RPMB_ERR_WRITE   =3D 0x0005,
> > +       RPMB_ERR_READ    =3D 0x0006,
> > +       RPMB_ERR_NO_KEY  =3D 0x0007,
> > +
> > +       RPMB_ERR_COUNTER_EXPIRED =3D 0x0080
> > +};
> > +
> > +/**
> > + * enum rpmb_type - type of underlying storage technology
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
> > +
> > +/**
> > + * struct rpmb_dev - device which can support RPMB partition
> > + *
> > + * @parent_dev       : parent device
> > + * @list_node        : linked list node
> > + * @ops              : operation exported by rpmb
> > + * @dev_id           : unique device identifier read from the hardware
>
> This part puzzled me a bit, when I realized that they are used as an
> input to derive the authentication-data.
>
> For eMMC (as shown in patch2), we have chosen to use the CID register
> data, which makes perfect sense to me. However, I think it's important
> to clarify what this field is being used for, here in the description
> too.

Good point, I'll add that.

>
> > + * @dev_id_len       : length of unique device identifier
> > + * @reliable_wr_count: number of sectors that can be written in one ac=
cess
> > + * @capacity         : capacity of the device in units of 128K
> > + */
> > +struct rpmb_dev {
> > +       struct device *parent_dev;
> > +       struct list_head list_node;
> > +       const struct rpmb_ops *ops;
> > +       u8 *dev_id;
> > +       size_t dev_id_len;
> > +       u16 reliable_wr_count;
> > +       u16 capacity;
> > +};
> > +
> > +/**
> > + * struct rpmb_ops - RPMB ops to be implemented by underlying block de=
vice
> > + *
> > + * @type          : block device type
> > + * @route_frames  : routes frames to and from the RPMB device
> > + * @set_dev_info  : extracts device info from the RPMB device
> > + */
> > +struct rpmb_ops {
> > +       enum rpmb_type type;
>
> I would keep this in the rpmb_dev instead, as it's not really a callback =
(ops).
>
> > +       int (*set_dev_info)(struct device *dev, struct rpmb_dev *rdev);
>
> As I suggested earlier, we should be able to drop the above callback.
> That said, it looks like we end up with only one callback left, so
> maybe just put that in the struct rpmb_dev instead?

OK

Thanks,
Jens

>
> > +       int (*route_frames)(struct device *dev, bool write,
> > +                           u8 *req, unsigned int req_len,
> > +                           u8 *resp, unsigned int resp_len);
> > +};
> > +
> > +/**
> > + * struct rpmb_interface - subscribe to new RPMB devices
> > + *
> > + * @list_node     : linked list node
> > + * @add_rdev      : notifies that a new RPMB device has been found
> > + */
> > +struct rpmb_interface {
> > +       struct list_head list_node;
> > +       void (*add_rdev)(struct rpmb_interface *intf, struct rpmb_dev *=
rdev);
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_RPMB)
> > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
> > +void rpmb_dev_put(struct rpmb_dev *rdev);
> > +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> > +                                     const struct rpmb_dev *start,
> > +                                     int (*match)(struct rpmb_dev *rde=
v,
> > +                                                  const void *data));
> > +struct rpmb_dev *rpmb_dev_register(struct device *dev,
> > +                                  const struct rpmb_ops *ops);
> > +int rpmb_dev_unregister(struct rpmb_dev *rdev);
> > +
> > +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> > +                     unsigned int req_len, u8 *resp, unsigned int resp=
_len);
> > +
> > +void rpmb_interface_register(struct rpmb_interface *intf);
> > +void rpmb_interface_unregister(struct rpmb_interface *intf);
> > +#else
> > +static inline struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > +{
> > +       return NULL;
> > +}
> > +
> > +static inline void rpmb_dev_put(struct rpmb_dev *rdev) { }
> > +
> > +static inline struct rpmb_dev *
> > +rpmb_dev_find_device(const void *data, const struct rpmb_dev *start,
> > +                    int (*match)(struct rpmb_dev *rdev, const void *da=
ta))
> > +{
> > +       return NULL;
> > +}
> > +
> > +static inline struct rpmb_dev *
> > +rpmb_dev_register(struct device *dev, const struct rpmb_ops *ops)
> > +{
> > +       return NULL;
> > +}
> > +
> > +static inline int rpmb_dev_unregister(struct rpmb_dev *dev)
> > +{
> > +       return 0;
> > +}
> > +
> > +static inline int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> > +                                   unsigned int req_len, u8 *resp,
> > +                                   unsigned int resp_len)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static inline void rpmb_interface_register(struct rpmb_interface *intf=
) { }
> > +static inline void rpmb_interface_unregister(struct rpmb_interface *in=
tf) { }
> > +#endif /* CONFIG_RPMB */
> > +
> > +#endif /* __RPMB_H__ */
> > --
> > 2.34.1
> >
>
> Kind regards
> Uffe

