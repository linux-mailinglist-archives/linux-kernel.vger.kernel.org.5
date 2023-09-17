Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346FB7A3482
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjIQIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjIQIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:41:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0A6138;
        Sun, 17 Sep 2023 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1694940054; x=1695544854; i=wahrenst@gmx.net;
 bh=BC5dF8SPTBfjejsROono+ihw4XGqTENhs3mXoQWX3Rg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=eUk2h3uap6yUCUlNivtJEC8ngP7zSoXreZyGAHa5yEDJ3HEcTgthYoOWuagJ9GfuocmSDM1rNlA
 sLASDliNAbzmWzJOZUdED+c7bbR3m8WIbKBPlSBi81cz7Otan30IsYrHdgnrz2a/GfKv2oAratI4L
 OtDN24KrQXe1AwtJ1lVndmv+obh4YN9CybT0aFUcc0YAja1fgl+euoxsXwqnjIMcP845n9ZKwfd5p
 KG43YNHm1LZ90p/0TctoCB5oSfhxW8dz5cCYs6h/mSWtvMNQ2c4g0m6MPZN7DJ43aBhEiXTh1ytwS
 5g53zteYS6tHmY+7AA4rCbaEIjp3NQfilW/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUrx-1rfN0B1SIL-00xsib; Sun, 17
 Sep 2023 10:40:54 +0200
Message-ID: <0d2fe28c-27e0-c85a-9bcf-69ee712161d0@gmx.net>
Date:   Sun, 17 Sep 2023 10:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v11 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
Content-Language: en-US
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
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20230913195354.835884-2-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zvPPD55M2TMVbfHIL+92M8ef1dUkI76EKA/GjkzhSVxi1IVwaTM
 plbYW/sKFu9eC9b05n1/k4P8s3xnoMwZpQfBM24mLJ94e5L91FR2ZBudm0Dcer3fMXlc5dI
 aJ49E2s8W6DcZPCe5Ag625xqE0BxIEifh9bBfXZrdP+fGNanlszB/tVUUBKl2JXLrnEkuxN
 EIiqHu8OFRoq5jGQqHSOQ==
UI-OutboundReport: notjunk:1;M01:P0:KcpKe48VCG8=;Nc+5w/Kk/BkQNcIobhTdowkhD2V
 OZq4+vBZOD93+bXCsqyzfVl7N67i6dMY/GkFh5JYr6XbSeCYs5gR7lDuKjKDrVRrMI0zV6wTR
 3UYwC4uX1vQkL55Acq8SrbEu2MMBlv4xTcsdaaEsu2h14MojKvdnYMayAE6CG75W9lW3kT9rn
 9d0cPCGyeOVDd941mrUjBh4ZDL4RVP1lciNduWL8/q1LZUQXb+wwJgzcqXvfnvu8gNalK9rPw
 VnMZrgY3Gq+XuSevaRibKQyG58E5B6TWMuywV9iRk5cLLNNSyI0Blyc7AB80jpGMUz+9yX0sI
 D97BmD3+PA4A9tO37Qpf+CQg8u74l5xAkNEbyjQ/VwAr6G6cebfWc5gI4spdQccLQKsJQXdx5
 eq7R7bSACikMI4sbRW76PDCz3P4qdJh+BUXCtOXgyT6DVqnMLX5fsKR/yK1ez0DwJFusFG1Q3
 ckE2QmWFLhOx82OU7XI3C8c045dJQq9TClLBiu0nxECCJ0OrW95wv+bJSJpNXnhchkelCeRf2
 D3SE/39N3ruPqymVrP8hNdc/21qX8d+veYad78HLe4j0MsDYCMqWZ4u7W1sVlFpkYfr+OTeW4
 iOnkn3W35j1hgPObTkaPcCke0PKloMIrJuyC5bVmBMOlPZp62GQ0mCDE71YJ5h1F0O1P0PPNJ
 XLMTqArmJflSKMzOzE9ot5ICzpU068R70Rd/xt3ALCX/9ah+7+BsAT8DxrLOLD9nXxNQFoEr5
 o1ShndfhjguFSe+KVOimO/UKe9znzwLV6DcxO862NxvFkMHDSo2+WjvYaQdD14X0vU8S24gZM
 Z9EGDwrWsXTerwGcvv5FD40e67j09shwcHxDSiBjBb/Far6t6iqDDOloIxvXNObTqMNJnvYjL
 kfqLdiX9Ys4gxKZKIZHfPRBkEuDrVnb2BSmHfL/7MWlvbUphQbcvo57iG3rrzzzpolYXdHv3p
 1cRs6Q==
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
sorry for not noticing this before, but there is already a vchiq_dev.c
file which represent the character device.

In order to avoid confusion how about renaming vchiq_device.c to
vchiq_bus.c ? This also matches the function names better.
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
>

