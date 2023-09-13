Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7F79F357
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjIMU6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjIMU6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:58:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3701999;
        Wed, 13 Sep 2023 13:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1694638693; x=1695243493; i=wahrenst@gmx.net;
 bh=/o76H5aWQpn4880kTGpzFzKgSLaznbCWbqBvGuNkXLQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GCIoAwIC4kHxCkKoLA7tjtXkOwY/WpWmC/BXjjX2spe1u70d1ZX4FIDxTeaIt/NTHXEDVFKyHUu
 9UqK/3MW76lvs3GasO/xyj3f53mygOaCNERVFjmPo8UUPv+DaBk7+D9lKFKh1HGz1PqN980sGbgpr
 SMD7EFhT1C/O5qL0DRr44ir7ADyUMYVO9noqQABj4YkUjJDnsfkWTBbsbVADfUhg05CfYaorpRfS6
 /jtCXyaDwGVyY+LHKvKp7MNIcH4lWLoLFa0aYNTW54GDDpyaiq6X/jTw/8ks5HEKTN8CcS/xjh5W8
 FVfNZzUMWZYhR9qcTayVMEf505vWqNHfYQjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHG8m-1qtiDN1zkW-00DFME; Wed, 13
 Sep 2023 22:58:13 +0200
Message-ID: <5e7aff1e-82de-2ec4-4d30-2b1f37ed2eed@gmx.net>
Date:   Wed, 13 Sep 2023 22:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v11 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20230913195354.835884-1-umang.jain@ideasonboard.com>
 <20230913195354.835884-2-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20230913195354.835884-2-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:beTLit3Luj7YREWhFWQZZiKWmOwkXzWZfuQyWPOx7bYTAhtD2M3
 AhLfXG8VXxnz5PxFJt5EoYqFaVX6RI/GiMcCK8CoONKC+YTMvCxUuGkHc6bKNI5Xniau0yO
 AHzGJfFrFlXe/d1SEbp3yK1zrnXFfFlLp5v0t4CLtzq1nawxeh8Y8aFLriiUVETfROaYkzZ
 Gtd5J20+YnfbaqYdbMEsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KVXmsIRP6iI=;UcTa+O0m1QkJpekq9IsFWYuqDmt
 g/+FcvwolpCRFJwgLTwrf8bMo0hThA+aSfauEiZYtTlD/m3lT8+B+I8mnxBqPxXFi/wOt58aH
 TaU/TYz/efq2AXFMxKEedFo0kzvnQ0ICRXh5m1N03caa7viN7bVcBkmW+l3Xee4E5cKuIe9Nj
 6//E+y3bL6CQi2cFB8rfPrdcLcqQl8jEy89vbX1KSVWldKOIj2veZmun2qkfrYMMNZVrg3zi6
 yMa9idXLHCDgp8srgtwFqpVOxYM/1DN6KXMF4SkGZiwjIzuipVG6vm0i3aQcPjcCp4LpC5IvR
 Rv03U4SS2a0jGJVlmDi2Gv2uZOUchfL5nCNLcY/zn5ErjKNaL0EsulsNAefZLtxZt+qBt+p3N
 X0xFi+Feo2dqFH0db27+tgLC4/oNvcta/lGqXXdNszZvL8t3SQUwS1Vowik7Q1N94+c+MfuHb
 JYnrGLPJeiJBJTlgZt1MvcVIljCvCh554ZOJAhSe19oPBdq7cqV2eYMZ0aKSgnFIExIOtDS0s
 EK+gvGLxHOWZsFn7+OYckea2Gowi0eGMVM9SNPDmpfMW1hjBgMfPOvacQrV6Znof+hRKERyHw
 al8glfcCHUvGmJ/UOdSq02CHoAP5rQ+XxRim/RexcksBbB6zVZ49tCI5mh6gdDMKmuSoNiWTz
 ffzQvMgybwcoDUrfSC4oo0rNpY/D7nz4mJlwbQngWu/f+rNXCDrpASFXCe9rkDdx/aHjUh+uD
 HLXOH0EUHZRfBWiQBmlTe3J8V6icc10q4xiBnafW7Jvuu3rSZ9f3jHNcRAbGcElICBRYJQGNr
 3xslwrUanZCfnqk840NyRRYo31e5Xz0ju3kMS95xTUHBP9Q4+t4hf2gA5nTc1oKUjcLaEnnXw
 GmYM9TcOnHNb4q8/f+QNwR7HL4Km0AdGFj1nhm+yP5gZ7K+/KmCr8kCZSn7EKPhy1TnW4Nh0l
 BWkPCQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 13.09.23 um 21:53 schrieb Umang Jain:
> The devices that the vchiq interface registers (bcm2835-audio,
> bcm2835-camera) are implemented and exposed by the VC04 firmware.
> The device tree describes the VC04 itself with the resources required
> to communicate with it through a mailbox interface. However, the
> vchiq interface registers these devices as platform devices. This
> also means the specific drivers for these devices are getting
> registered as platform drivers. This is not correct and a blatant
> abuse of platform device/driver.
>
> Add a new bus type, vchiq_bus_type and device type (struct vchiq_device)
> which will be used to migrate child devices that the vchiq interfaces
> creates/registers from the platform device/driver.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   drivers/staging/vc04_services/Makefile        |   1 +
>   .../interface/vchiq_arm/vchiq_device.c        | 111 ++++++++++++++++++
>   .../interface/vchiq_arm/vchiq_device.h        |  54 +++++++++
>   3 files changed, 166 insertions(+)
>   create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/v=
chiq_device.c
>   create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/v=
chiq_device.h
>
> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc=
04_services/Makefile
> index 44794bdf6173..2d071e55e175 100644
> --- a/drivers/staging/vc04_services/Makefile
> +++ b/drivers/staging/vc04_services/Makefile
> @@ -5,6 +5,7 @@ vchiq-objs :=3D \
>      interface/vchiq_arm/vchiq_core.o  \
>      interface/vchiq_arm/vchiq_arm.o \
>      interface/vchiq_arm/vchiq_debugfs.o \
> +   interface/vchiq_arm/vchiq_device.o \
>      interface/vchiq_arm/vchiq_connected.o \
>
>   ifdef CONFIG_VCHIQ_CDEV
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev=
ice.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> new file mode 100644
> index 000000000000..aad55c461905
> --- /dev/null
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * vchiq_device.c - VCHIQ generic device and bus-type
> + *
> + * Copyright (c) 2023 Ideas On Board Oy
> + */
> +
> +#include <linux/device/bus.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of_device.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include "vchiq_device.h"
> +
> +static int vchiq_bus_type_match(struct device *dev, struct device_drive=
r *drv)
> +{
> +	if (dev->bus =3D=3D &vchiq_bus_type &&
> +	    strcmp(dev_name(dev), drv->name) =3D=3D 0)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int vchiq_bus_uevent(const struct device *dev, struct kobj_ueven=
t_env *env)
> +{
> +	const struct vchiq_device *device =3D container_of_const(dev, struct v=
chiq_device, dev);
> +
> +	return add_uevent_var(env, "MODALIAS=3D%s", dev_name(&device->dev));
> +}
> +
> +static int vchiq_bus_probe(struct device *dev)
> +{
> +	struct vchiq_device *device =3D to_vchiq_device(dev);
> +	struct vchiq_driver *driver =3D to_vchiq_driver(dev->driver);
> +	int ret;
> +
> +	ret =3D driver->probe(device);
> +	if (ret =3D=3D 0)
> +		return 0;
> +
> +	return ret;
> +}
> +
> +struct bus_type vchiq_bus_type =3D {
> +	.name   =3D "vchiq-bus",
> +	.match  =3D vchiq_bus_type_match,
> +	.uevent =3D vchiq_bus_uevent,
> +	.probe  =3D vchiq_bus_probe,
> +};
> +
> +static void vchiq_device_release(struct device *dev)
> +{
> +	struct vchiq_device *device =3D to_vchiq_device(dev);
> +
> +	kfree(device);
> +}
> +
> +struct vchiq_device *
> +vchiq_device_register(struct device *parent, const char *name)
> +{
> +	struct vchiq_device *device;
> +	int ret;
> +
> +	device =3D kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device) {
> +		dev_err(parent, "Cannot register %s: Insufficient memory\n",
> +			name);
AFAIK kzalloc already logs an error in case of insufficient memory, so
there is no need for this.
> +		return NULL;
> +	}
> +
> +	device->dev.init_name =3D name;
> +	device->dev.parent =3D parent;
> +	device->dev.bus =3D &vchiq_bus_type;
> +	device->dev.release =3D vchiq_device_release;
> +
> +	of_dma_configure(&device->dev, parent->of_node, true);
> +	ret =3D dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
 From my understand Robin suggested to drop dma_set_mask_and_coherent()
here, too. In case this cause a regression until patch 3 & 4 are
applied. The DMA mask parts should be applied separately before this patch=
.
> +	if (ret) {
> +		dev_err(&device->dev, "32-bit DMA enable failed\n");
> +		return NULL;
> +	}
> +
> +	ret =3D device_register(&device->dev);
> +	if (ret) {
> +		dev_err(parent, "Cannot register %s: %d\n", name, ret);
> +		put_device(&device->dev);
Also Robin pointed out that there is a memory leak in the error path,
because the "device" get lost.

Thanks Stefan
> +		return NULL;
> +	}
> +
> +	return device;
> +}
> +
> +void vchiq_device_unregister(struct vchiq_device *vchiq_dev)
> +{
> +	device_unregister(&vchiq_dev->dev);
> +}
> +
> +int vchiq_driver_register(struct vchiq_driver *vchiq_drv)
> +{
> +	vchiq_drv->driver.bus =3D &vchiq_bus_type;
> +
> +	return driver_register(&vchiq_drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(vchiq_driver_register);
> +
> +void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv)
> +{
> +	driver_unregister(&vchiq_drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(vchiq_driver_unregister);
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev=
ice.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> new file mode 100644
> index 000000000000..7eaaf9a91cda
> --- /dev/null
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 Ideas On Board Oy
> + */
> +
> +#ifndef _VCHIQ_DEVICE_H
> +#define _VCHIQ_DEVICE_H
> +
> +#include <linux/device.h>
> +
> +struct vchiq_device {
> +	struct device dev;
> +};
> +
> +struct vchiq_driver {
> +	int		(*probe)(struct vchiq_device *device);
> +	void		(*remove)(struct vchiq_device *device);
> +	int		(*resume)(struct vchiq_device *device);
> +	int		(*suspend)(struct vchiq_device *device,
> +				   pm_message_t state);
> +	struct device_driver driver;
> +};
> +
> +static inline struct vchiq_device *to_vchiq_device(struct device *d)
> +{
> +	return container_of(d, struct vchiq_device, dev);
> +}
> +
> +static inline struct vchiq_driver *to_vchiq_driver(struct device_driver=
 *d)
> +{
> +	return container_of(d, struct vchiq_driver, driver);
> +}
> +
> +extern struct bus_type vchiq_bus_type;
> +
> +struct vchiq_device *
> +vchiq_device_register(struct device *parent, const char *name);
> +void vchiq_device_unregister(struct vchiq_device *dev);
> +
> +int vchiq_driver_register(struct vchiq_driver *vchiq_drv);
> +void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv);
> +
> +/**
> + * module_vchiq_driver() - Helper macro for registering a vchiq driver
> + * @__vchiq_driver: vchiq driver struct
> + *
> + * Helper macro for vchiq drivers which do not do anything special in
> + * module init/exit. This eliminates a lot of boilerplate. Each module =
may only
> + * use this macro once, and calling it replaces module_init() and modul=
e_exit()
> + */
> +#define module_vchiq_driver(__vchiq_driver) \
> +	module_driver(__vchiq_driver, vchiq_driver_register, vchiq_driver_unre=
gister)
> +
> +#endif /* _VCHIQ_DEVICE_H */

