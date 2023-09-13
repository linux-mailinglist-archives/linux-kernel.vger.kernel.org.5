Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27579F365
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjIMVB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjIMVB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:01:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D279B;
        Wed, 13 Sep 2023 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1694638867; x=1695243667; i=wahrenst@gmx.net;
 bh=aDVZFTIIdQPzxPS22i/sEOSKoSnsx3hpQP4Ys7jhcaM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fezHsEZHszyMfDDjVsoLWXy8Uwd3VDTl2+m2vi2DDhzk4mA4YFhDPCwnJ1Sl1mpq7GVwyNUf9oB
 4KGxcg8zGVConPrdxqyo8x0NV3lEoBpiqVpmbOzl7kPEzFnXoAhDrClXOWnIc+7apuvNoKaxdfFTz
 IFWqP0e5XZ3wAapnorfhAHf3vXNXczljmm7mxyL+49bhze++GC0tf4PNtDPDnji2BX2d7tI3Goh6u
 n4QTUwVJiXy/x1pBf+6hy8QAh04u4q2Raun4pHcqPoaeC4jzSOKmA+yjvHXPdkjVfdFFTjZ14XMSu
 5ilSQQolUQrXRcg/CVyc+PNahUrfmETu0gCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1qyCOJ2m2K-00Hf0K; Wed, 13
 Sep 2023 23:01:07 +0200
Message-ID: <0793697d-08b9-49bf-eef7-2abf33dfa747@gmx.net>
Date:   Wed, 13 Sep 2023 23:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v11 2/5] staging: vc04_services: vchiq_arm: Register
 vchiq_bus_type
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
 <20230913195354.835884-3-umang.jain@ideasonboard.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20230913195354.835884-3-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3TwtOEbqEjcl8Ygdw9ywBOQxc3c7nyDawF77sIeJjZ+gcOrGeXa
 VnS6bXTwD/N4hb48EXr3gtxgng6WEwtfmc3eiPK2NCy/7d2jVnWCSrRvjYKnPG7XFpypbIF
 o6yHmpA7ta9XQkQisIFQjfChx6JO5WCzzCEDTErFNFVxzLjnwjrgtFvXoLOb/IFkKqACRTY
 EzZVIdFoU3H9ZdJj826JA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E1Gj+S7954E=;CBesP4TkCb+koa4TDhUXSKfH+EA
 NW8XSPRQhehzoeGiD6urm/9rOnvX8lc3yBDXoC/XXPufGy2j292kx5zstTBY2EcMAp2KUWOdK
 85BVcGtw59+beWqcL+p+OQmew9EaG0FbO2J3UUMZF9Otzla3DcfvcYi3RV0GxVG5gu7BduhAQ
 q8WHorxxCQtd0zpzTofIb9nc71u5BWnrSBq5ezmy7GVc2nD8Wb6Bm9ToNPt0vrarIgVEJy3qe
 YjfNVKMi9bHgok9K2JxeZwiPgrZiUy6dluMtvOf9prFVZ5afzWLp+0pruCnJ3yzPcxAkReP/c
 CuLDjFGeVM+ejv+bTQ6Z6pSUFevJg3h80Br8wkQSGNFfqsJpqee1Gm4iKEcTzz5wSncd6SnCe
 8Xuwt2fprc94sJhW45krs0LxPdjrj81BbWJTaUKfRINGoZZU1mPy9j3A0nWng+I24OyDTAtDu
 rH9dLzuM1XWG2os07Utx88r9ndM68wvJu3/GRZNPHM2l4R0Xvd1XbCmJuD0CvUMUB6BYMQQXX
 eFq1DRglSA/Gar8XjKSuvZMyVgVWfwrrSaO6m0AirEqI3/SEICAsnlKZD7tcRMN8jnmQIdad7
 65WXMdnjREcBZR2jhrNjajy/tb99RyjB2n2GF4n4FS3mFCHkK9shYri8gGzOxZ6G69xjFsp0k
 F+X1H9i7z7TzbUgWeetaStfCRkXQ+zwSF7H43vHL0nHd4lP/1v/L4TyjwOnryR2D0y/mbVrok
 dL9CTzuL7WlC61eZ1jdJukWNhoNPKcZuj/W+kh0zL7W6ugcYoPHPzWleG2QwWX3bOPLUeMwwG
 iYn4C14lBRvi0+BfqcfqAvrJ3cDznwx7Fcp2dcA+aSjvQBiLRIplJ5NglebNsGGY80OfxzZ4c
 e1ai4VtrjhguWpvqbL2YPFBvQlW+oAaNGj3Wg3LhwcvS5W1/1tqbHa8rM7wiNOEIb+1NEZ+eC
 Z4zmjIdePVX8f5ZN3TqDKQMNl3k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 13.09.23 um 21:53 schrieb Umang Jain:
> Register the vchiq_bus_type bus with the vchiq interface.
> The bcm2835-camera and bcm2835_audio will be registered to this bus type
> going ahead.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>   .../vc04_services/interface/vchiq_arm/vchiq_arm.c   | 13 ++++++++++++-
>   .../interface/vchiq_arm/vchiq_device.c              |  7 -------
>   2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index aa2313f3bcab..d993a91de237 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -12,6 +12,7 @@
>   #include <linux/cdev.h>
>   #include <linux/fs.h>
>   #include <linux/device.h>
> +#include <linux/device/bus.h>
>   #include <linux/mm.h>
>   #include <linux/highmem.h>
>   #include <linux/pagemap.h>
> @@ -34,6 +35,7 @@
>   #include "vchiq_ioctl.h"
>   #include "vchiq_arm.h"
>   #include "vchiq_debugfs.h"
> +#include "vchiq_device.h"
>   #include "vchiq_connected.h"
>   #include "vchiq_pagelist.h"
>
> @@ -1870,9 +1872,17 @@ static int __init vchiq_driver_init(void)
>   {
>   	int ret;
>
> +	ret =3D bus_register(&vchiq_bus_type);
> +	if (ret) {
> +		pr_err("Failed to register %s\n", vchiq_bus_type.name);
> +		return ret;
> +	}
> +
>   	ret =3D platform_driver_register(&vchiq_driver);
> -	if (ret)
> +	if (ret) {
>   		pr_err("Failed to register vchiq driver\n");
> +		bus_unregister(&vchiq_bus_type);
> +	}
>
>   	return ret;
>   }
> @@ -1880,6 +1890,7 @@ module_init(vchiq_driver_init);
>
>   static void __exit vchiq_driver_exit(void)
>   {
> +	bus_unregister(&vchiq_bus_type);
>   	platform_driver_unregister(&vchiq_driver);
>   }
>   module_exit(vchiq_driver_exit);
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev=
ice.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> index aad55c461905..b8c46f39e74a 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> @@ -74,13 +74,6 @@ vchiq_device_register(struct device *parent, const ch=
ar *name)
>   	device->dev.bus =3D &vchiq_bus_type;
>   	device->dev.release =3D vchiq_device_release;
>
> -	of_dma_configure(&device->dev, parent->of_node, true);
> -	ret =3D dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
> -	if (ret) {
> -		dev_err(&device->dev, "32-bit DMA enable failed\n");
> -		return NULL;
> -	}
> -

this code was added in the patch before and now it's removed again.
Please avoid this.

>   	ret =3D device_register(&device->dev);
>   	if (ret) {
>   		dev_err(parent, "Cannot register %s: %d\n", name, ret);

