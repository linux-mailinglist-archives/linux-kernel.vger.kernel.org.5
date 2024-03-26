Return-Path: <linux-kernel+bounces-119969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A81688CF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F64E1F67B75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E1213D893;
	Tue, 26 Mar 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="dZldq+m4"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E712B157;
	Tue, 26 Mar 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486831; cv=none; b=gtgRKVtZv/8qWAXgTtyyot9QQXU5fUEZ9CNuFVa6WocJW7ruz684xCIrEb3T1oFzRWr2dzIPJBJ2q2DVibrgG2FpdznlOh7YYJeQsSyQerSBZNOYrdtcMZQI7qXUkByIpin6lSg7PxnYeUZ0gY1630ciOJo1BjSdOrnxWxpCYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486831; c=relaxed/simple;
	bh=TACiQ+xeZGqKNmYVboNXIyaA6O8fjKoa8PCXLZZyb0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdcRCZilHqRGWWkS2y2r6kAPP3l+q8lp/0dfTFSfKtyMPotCl+UcTVbp4WHUvYT2mH5gSLIAbpf37+NgBWjWvzO1B/XYiRteXQzixV7NtNdi7BTKDFpsoaSxPR0dLYFki6/mnnU4krSF98laBWifsPU93wMnAhS4ntwjd9KinFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=dZldq+m4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711486805; x=1712091605; i=w_armin@gmx.de;
	bh=oovH05l1sLDvE4OHaXaGFv4SRMSBo6EJ3rcguRC/AfU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=dZldq+m4Kq7kIFeVzmxRgb1x7V9xohxFoqOF6mk1C4WZNyzkD8mX37rv1n72uxqx
	 TBJxXj4FvW9Zzk3C/lz60hImRz79OfEY+zK9pKZcaXJNvpmF90+p+DElqErnwmpMy
	 FLqhRFijCDE0g/WrnOCoX6rpMulFQY3fzIeatjLBlZwC7HPxbdmeZuH8/1rI2bkGk
	 Rf77DMPMVaNgzajCNLQ2uXK4liQkT05RCLiJMAaZmjJkIhimEC5DqeZCQUPbOWX7n
	 DlflnNdBIq+WOxvBvtwH4szIjReJmuLCTnpSjY2rIs9AQUz+95qaz9IZxbES30lXU
	 x34/OU96JERsOD7IPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowGa-1seSUt15B8-00qVsV; Tue, 26
 Mar 2024 22:00:05 +0100
Message-ID: <31bc6c0a-c0e7-4055-82ec-33da51368e0f@gmx.de>
Date: Tue, 26 Mar 2024 21:59:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] platform/x86: add lenovo wmi camera button driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Ai Chao <aichao@kylinos.cn>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240322064750.267422-1-aichao@kylinos.cn>
 <ZgGmfV9ciPdtbGO1@smile.fi.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <ZgGmfV9ciPdtbGO1@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:R2mVWzkgRZQf922lzF28ziewK/4/O88EndJrffowiB7qy1QldDT
 2UddGvoOLxIwGd5YhkEwa6Cj73O9iaoV29zZSYwJYYD7V2R45DnXdY9RLg3ankulgJYpeFI
 oadxp3L5KfzUb95mo2VoMBEQUx1mfwuN4gXb7/Wcvnh+Kqtmk3pRucdQen7o+L4VAAFyMyc
 h1RTiD7pCrNuNlz4ncZ3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6whmCGcjBL4=;WQUegEFlWSWKLFd1WnF7kbFQd5h
 k/IQesRrup/X+zbEcmwoZPUNAMpl1EWvCiODx7HXYgE5xfF6/lNWiUbTMkLNkcwIQovCzHHbM
 p2irvQnpMdDSl0AXntwih23Oic/pzZvjg4ev5Ir/2J4DER/tuRNJnkZ6gs5n/3/H1ZhJaX2XR
 7UB1AvWhSbhqncDtBY5tVLT16calfxU32z6jhV62eaMwodLBL5Ytl0UUz3V4XM13oROJznAPe
 d1s+m9Dj1vtDI+O6pHRF1NazzF9e29Z+t/+ix6fXrG2LkE8h8XUGpdhfrpzRc1SGYrAwwUpAB
 PnDgwcMp8B+StSZ1siGFclMCqNljCpbfQCvyOPiiZrWatukkjgJuNymJs/Lzx+FX8fKloeVaX
 Rs6PlAddgcq2m2b6AoLy1g+TAQ/YSH6O30b0wVG+GWGICKdQPr0kW/ly0KimOl/p9LMnJAEjA
 BLPc8VDTckR7noF+SNj/L++Kfn9cIWo7rpkF8ZWPE/0UYQb5jRS0xGQeDIM3P0SBLVpbm/rVz
 OYKbNsy+E7ZiX604uIfSsscZ/vibD8QM57wKg/oJTbYUyLMHtCleVtBtOmsd2WaBZqF+Dr1ym
 fzGHoHapqWtRX02F/POcQCpBO/MqJTgQ581ZDOeps2b9/cRT7zu25Od7UM1gfqC5OtKjvP9C/
 iHeVGJCeENEfPLGNIA1EaNIpYTWwiIdr3Zx3ZpVFmxTDJM0ZUuzTNrnjtqjxg6Caeeiy8z900
 Af4GK2YAzQtkPCIsO0Ta6ONm+K82CspNckbrhM8mm0x8uW7J4WhxyGJMNcdtBM+GHARbsictj
 ZEJlH/a/UOR471or5JPq2CWVlr8BIBR/6S6jwAxyI0np4=

Am 25.03.24 um 17:29 schrieb Andy Shevchenko:

> On Fri, Mar 22, 2024 at 02:47:50PM +0800, Ai Chao wrote:
>> Add lenovo generic wmi driver to support camera button.
> WMI
>
>> The Camera button is a GPIO device. This driver receives ACPI notifyi
>> when the camera button is switched on/off. This driver is used in
>> Lenovo A70, it is a Computer integrated machine.
>> +config LENOVO_WMI_CAMERA
>> +	tristate "Lenovo WMI Camera Button driver"
>> +	depends on ACPI_WMI
>> +	depends on INPUT
> No COMPILE_TEST?
>
>> +	help
>> +	  This driver provides support for Lenovo camera button. The Camera
>> +	  button is a GPIO device. This driver receives ACPI notify when the
>> +	  camera button is switched on/off.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called lenovo-wmi-camera.
> ...
>
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/input.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
> + types.h
>
>> +#include <linux/wmi.h>
> ...
>
>> +struct lenovo_wmi_priv {
>> +	struct input_dev *idev;
>> +	struct mutex notify_lock;	/* lenovo wmi camera button notify lock */
> WMI
>
>> +};
> ...
>
>> +	/* obj->buffer.pointer[0] is camera mode:
>> +	 *      0 camera close
>> +	 *      1 camera open
>> +	 */
> /*
>   * The correct multi-line comment style
>   * is depicted here.
>   */
>
> ...
>
>> +	keycode = (camera_mode == SW_CAMERA_ON ?
>> +		   KEY_CAMERA_ACCESS_ENABLE : KEY_CAMERA_ACCESS_DISABLE);
> Useless parentheses.
>
> ...
>
>> +	ret = input_register_device(priv->idev);
>> +	if (ret)
>> +		return ret;
>> +	mutex_init(&priv->notify_lock);
> Your mutex should be initialized before use. Have you tested that?

Hi,

i suggested that the mutex be initialized after calling input_register_device().
The reason for this is that the mutex is only used inside the WMI notify callback,
and the WMI driver core will only call it after probe() has returned.

So imho it should be safe.

Thanks,
Armin Wolf

>
> ...
>
>> +static struct wmi_driver lenovo_wmi_driver = {
>> +	.driver = {
>> +		.name = "lenovo-wmi-camera",
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>> +	.id_table = lenovo_wmi_id_table,
>> +	.no_singleton = true,
>> +	.probe = lenovo_wmi_probe,
>> +	.notify = lenovo_wmi_notify,
>> +	.remove = lenovo_wmi_remove,
>> +};
>> +
> Unneeded blank line.
>
>> +module_wmi_driver(lenovo_wmi_driver);
> ...
>
>> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> Please, move it closer to the respective table.
>

