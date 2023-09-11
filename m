Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1BE79BA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348391AbjIKV0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbjIKUXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:23:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B78185;
        Mon, 11 Sep 2023 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1694463764; x=1695068564; i=wahrenst@gmx.net;
 bh=zG5Vmw3qiXN8IClSARt1XGb9sZT76BbpMWIHv9WvXs0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QqfndfSj46qyTmWtdGJ3SprEE9JK+s61mMT69AeawtU+6nKJAgOAQSYg4wn8gXIfcsg9jQ1
 ET3bNAujCeJLr4oN4NGYZo/A32YCw4GhuQ70VD1gR0goYZAvhDexfd9XTuVbNeoFNsYJe0iiQ
 B5Oz87Wd7vRw+LkzNnT7pSXnCx/mHvduibRGvLev3ecQfdJSTqefM8ij3YH8h1Y8SSqtICexQ
 G6LUur6EKzzgquWDzC22bgWjKijDjKXhBz+p/6alsnj9xAHqZI6YjaNe6qAik3OPkrvsNVuFv
 mcyVFaee3mepTNCuP72q4syKKTOdrYEKkZj1L0Feq6oAuOq/AIGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZkpb-1q8whn0pJH-00Wqjl; Mon, 11
 Sep 2023 22:22:44 +0200
Message-ID: <c96262e7-9bd9-c75d-7584-e6ff62f69530@gmx.net>
Date:   Mon, 11 Sep 2023 22:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v10 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
To:     Umang Jain <umang.jain@ideasonboard.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        athierry@redhat.com, error27@gmail.com,
        kieran.bingham@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        dave.stevenson@raspberrypi.com, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <20230911140712.180751-1-umang.jain@ideasonboard.com>
 <20230911140712.180751-2-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20230911140712.180751-2-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:++NzSYrVvw3FDACteBIJlbHPCAhvUjPXq4BhR+qkmLZ600Lln2S
 MaWpfdF84BNqhW6XXbk5Nk19u/8JEHcdG3/lEWq2usC6Gu4CBGkXEFGGVp1fz6+2VM450zi
 vY/482c7epOoefiA3Gz8lC4IWTrQSmzeRjnTj9WepcFQcJ5C1fng7mRu38yirQjs7pBylzL
 +9m3lO28BootWFGLvf9Jg==
UI-OutboundReport: notjunk:1;M01:P0:ztWtLMMskKc=;wxi/aOEAJSmHSypM+1dCpadJ/4/
 F/KhDDJ/Z46rny+nY/XLwx07J/ozEJ/Qdpfby1ooXkkYQ5e/vyUIx9l4CsCYDc4yOvsQDOdhb
 OEl1SQNypi+jU6xsz5W73bkOLLk48HJ/X3bY1yFz0I7mZnxBGPoHG7/wh2+mXpd5CPEZOh9Rv
 tepXreGP6gugPfIe+BZRJf123hOFp8ZI4tssNKt+VnYYZxPy+cOSU0l+PV+DKZ/YGfLumxfEg
 uN7vJZ5MFAOyChYjT6SQBBHdL339FT7dr1ZvGjVp+7GksAG4Kng9XxNn9xcotUMfxEdEQsP/s
 /WMO0GbSfPJ/vh5P8vvNxO99Wnlrk47wXeCwx8Q9KJmxYxmxDSbBJ9MRph6VyxROVRFcFfhHK
 cYJoHAyy6MtqMXsRL0R/3CJjI6TtyI3ptw6zmZAV2WcXApwgMf39FG5HoPdxyEBe+fVwG9ILR
 w2R3nwn++M9Ird/ycNnq7LKCX9ZikCtjcQ8V6W4zPTg8ojhUCqrncBjU5CNe5e0y03gOahQ/n
 Q2G2GmLSLH4sSnIBGPNWdjHguE+9WBitE3Zuc2Ad+KjKyUsDN0B+Q+ESLwTui/ntpn1QluMBk
 w7wOMes+mAkt4JrWiu68zKFYJwpz45nCi2RwgnjlonpYXVfpTUAe0EK4YjL70vmAeEtyNV+7q
 q8jV+wXihWm44FZzwj4RAVAKgwhLkjnK16lbBG6XWndyZ1aVwjfXc7RsQhb0gcI3jVRoXxc3d
 7ncIZl7xxYyzDZdY9tnxUME2tT7NUOLltoEiRNMljzmpP4p4jf5vUXZadVC3nRZQTs85wg9ju
 JCWjy0NXW6hvFfMYJLDCWmFntcadnjMc9ZCrcW9T16JVY5x0oCjZcF25/TkwOPgOSOg7e/U0E
 a1f0WFbKagJHtw0ju+16ii6zh4ylAijKMMaPjZmvM163rtt6NHAS8VaskT9j6Pyfx3Wznorw/
 ywqGAXEoEWJdCs9GB19p9sIiuKM=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 11.09.23 um 16:07 schrieb Umang Jain:
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
> +	if (ret) {
> +		dev_err(&device->dev, "32-bit DMA enable failed\n");
> +		return NULL;
> +	}

Unfortunately the call of of_dma_configure() generates warnings likes
this (Raspberry Pi 3A+ with multi_v7_defconfig + VCHIQ):

[    9.206802] vchiq-bus bcm2835-audio: DMA mask not set
[    9.206892] vchiq-bus bcm2835-camera: DMA mask not set

In the old platform driver code we had something like

   pdevinfo.dma_mask =3D DMA_BIT_MASK(32);

So there is still something missing for our new bus driver.

> +
> +	ret =3D device_register(&device->dev);
> +	if (ret) {
> +		dev_err(parent, "Cannot register %s: %d\n", name, ret);
> +		put_device(&device->dev);
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
