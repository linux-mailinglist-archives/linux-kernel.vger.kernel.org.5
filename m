Return-Path: <linux-kernel+bounces-122189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36CC88F33F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432F51F2CC25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA6154C05;
	Wed, 27 Mar 2024 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MV6jpx12"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1F18EA5;
	Wed, 27 Mar 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711582518; cv=none; b=dhzOyNIXe1F0UPx9yGyuOk3HsgR9OEVdFXiAtPGjsLwCHf0HWIgo6AZbfrgeXx1BtOvp4ea5JCo+pgUjRHYh/LJNQfUKME+/L95W7VhGyNyqFKK4RtGm3O0sCOEqrGk5IPBMCFCYMNyRXg3lTBtajofl0EyiUPs4svyDkvJMaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711582518; c=relaxed/simple;
	bh=ggoohYJsb9ECAI0rJrpLDy3B0jegVcju5LyHVqBpo7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhfyuWoYJWrleDH1tb3U6tPg1KAyXOiBO+9izW8i26uq96PbJrkV45Gn34N+ZymNTT20snj21iZxhfhgx4SfcP+S2QmO4xBrq2/fF10zZYWVH+DEgm9LzKGthIbsPJJIyhNTy2fkV1magRiGz9ffJpRFnMj15tyyrFysqAcfJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MV6jpx12; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711582507; x=1712187307; i=w_armin@gmx.de;
	bh=z0/+i5Xjmaje00PqJ8amwVARW1ROVxGdWi9EGRaNR18=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MV6jpx12qjWbhA6y4BDdQDB5Cl2B+dNnRheOf4oxJdXh46HOdezN7H6KIYSU/KHY
	 9XoMnP2s/sUPzFyJqgxduHR6k14UCooqlRhmtr7sjrj2996+19jajMeCgyUpezKFD
	 OwKMKUpYokS62MacGWIUExCnvwV9msfCgYP07DOVkdOxAoT5rWEl8DI/VuS4YgID7
	 GBSeKIbcML009JkyIVgO8Nj9Knqq1auStO+hP8zhf7oMGwhNfaazzWhgxrNQFPOmj
	 7cKZUWHp57PuQ6PA/90CPWD1Go3y8bqTAoBgElpBKdOzD9UDKadNXnqyAdiWXM1CT
	 k8Bnl2y5aaeCwuOExg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Vi-1svj6p2584-016Q0R; Thu, 28
 Mar 2024 00:35:07 +0100
Message-ID: <a2362908-feab-416c-b5ae-13d560089ee6@gmx.de>
Date: Thu, 28 Mar 2024 00:35:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] platform/x86: quickstart: Miscellaneous
 improvements
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240327215208.649020-1-andy.shevchenko@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240327215208.649020-1-andy.shevchenko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BIeLkcVTChRbaQCHDz81Pnahp38AVv64pZ+c2NbsBfJfQAsYSIr
 VBM8vdNcLunCYLCb8XojykRNYOQUcgZV68dxBNgGwA93VRx+/6PzRBSu7AYi8PFC/xiHlDD
 LplGjVFtBQrjd4ts18Bc8WZc2ldu3ywknpBkcsBNlkvcptRVSawgPd0YSuNQe1lVsRb4tv4
 1wmaAn/4lv1o5lZbVxVhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l58OXnBeQuA=;2opCUHfijmXnrgZCra7bo1x24q9
 drV/WbAc3kzibNjBAHaPVqajBh0AlVaJazNdmPJzc4AJg0mZF4kzDtbhJyCLY0RTNVfCN987Q
 TB8FhOzynXc3gLaxP0ZXeiTOjIkcIgEPdH6VOtIQ5joCTxvOY7Y0E6JjzsXfB1JbeBVKRicrV
 JV/kEMjEaWcQZnGcrrTnGiTO9loa1OmvmzIkek0pQNBrGsmsGIEhmgVFzQygYrrRQfIzD5Ak6
 GKUGS2eiL1OiKKwEBdMBIR9X86orUH1z7+3EYD1dOg2608XXM/3t3jRpFhhYpDZ0XZg+gBUvC
 7i7ablI3HVWhK1qicrV5XjsI2yMEwqK/buqIbqa8qxJ0/vz/DHNXqNizJ1Fm7zHXFAevdUe2E
 vOHxLcXmvx5cPJTZZcqs5dO1vAaXlznMIzpfJleQg8PAEW/If0POWP9nKvGT9JHznWcu1Qv3o
 SMVbpRD5VXiSRU1y6pUZItZPl1NRlPyVVGhBkWqn+5cECCV8PIU8oQ8BvfC8ianlggloofjvw
 jyQPZrDZSsmm/9O8ttoJ1CcF44WjQk0VpLjjAIbBuV9S4TLzGeh1FZROUg91k1qrHP9NAYWn4
 32DXPzWaLnJj0LTQEDjDeHbnvp3tHJrZ2ZZJHJkNy34gX9uu3AjHvDCFaZYi9mY/TuaakoSG3
 Ofstmekxyhq9bR+ikWKNWwOwVxKujywgxhc7NO71MfGehxqhOzC+IEqT6TEZmtGvccBRclgjY
 fpbWK0TXE3jG2V5rugOSaxm2vViC3PaGpSroX7Kw+aqkxJ+6MWSZP7XVJCEZndhnECWNdskty
 jGxHMca1oTMvacghNOQx88lh0QM1HGZue9vtt9MoDUhq8=

Am 27.03.24 um 22:52 schrieb Andy Shevchenko:

> There is a mix of a few improvements to the driver.
> I have done this instead of review, so it can quickly be
> folded into the original code (partially or fully).
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>   drivers/platform/x86/quickstart.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/qu=
ickstart.c
> index ba3a7a25dda70..f686942662ccc 100644
> --- a/drivers/platform/x86/quickstart.c
> +++ b/drivers/platform/x86/quickstart.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * quickstart.c - ACPI Direct App Launch driver
> + * ACPI Direct App Launch driver
>    *
>    * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
>    * Copyright (C) 2022 Arvid Norlander <lkml@vorapal.se>
> @@ -10,15 +10,18 @@
>    * <https://archive.org/details/microsoft-acpi-dirapplaunch>
>    */
>
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -

Hi,

that is the reason for removing this?

>   #include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
>   #include <linux/init.h>
>   #include <linux/input.h>
>   #include <linux/input/sparse-keymap.h>
> -#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
>   #include <linux/sysfs.h>
>   #include <linux/types.h>
>
> @@ -165,7 +168,8 @@ static int quickstart_probe(struct platform_device *=
pdev)
>   	data->dev =3D &pdev->dev;
>   	dev_set_drvdata(&pdev->dev, data);
>
> -	/* We have to initialize the device wakeup before evaluating GHID beca=
use
> +	/*
> +	 * We have to initialize the device wakeup before evaluating GHID beca=
use
>   	 * doing so will notify the device if the button was used to wake the=
 machine
>   	 * from S5.
>   	 */
> @@ -202,7 +206,7 @@ static int quickstart_probe(struct platform_device *=
pdev)
>   }
>
>   static const struct acpi_device_id quickstart_device_ids[] =3D {
> -	{ "PNP0C32", 0 },
> +	{ "PNP0C32" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, quickstart_device_ids);

