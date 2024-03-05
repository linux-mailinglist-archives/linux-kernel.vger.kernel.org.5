Return-Path: <linux-kernel+bounces-92541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2C8721E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB291F220F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8FE86AF1;
	Tue,  5 Mar 2024 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B1+KG7uN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByrlwcG0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00108614D;
	Tue,  5 Mar 2024 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650090; cv=none; b=hBoPtRrykpUsi/FbWTk1KL3TpaoMK1N50aRGCZTwslrMTpslBejXgqZ8I3REDONlx3pw3sZYj8jYsIjgaaatu/ac2yJeRvU3RjnRtH/92wNqzJZQgIpXtywxkBQWD4VmarubANFsD0wK5kNySAaU/0Nnnb/eRYu7YZgQ8H+OOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650090; c=relaxed/simple;
	bh=TbjxJ0CRQa71zw3frIkUsmK2i48ukVy0JiUmCm9BtEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwS++tC4i03TbetqzPi4uCWDW0iY1mgOYm0+3SchPZ7TOQ+6cuzQ4nNzV9FeO/v+dodJQ5I7F/tazr9WLSs60dTXnBcVIisJ9OPQStgJdFemhV/WvfuqgcT29K4ibiSl+sSF2gb8nbpGxAExof8R5X1RoITNXkHeh8ZX5LiDc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B1+KG7uN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByrlwcG0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 5 Mar 2024 15:48:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709650084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W78eNtAI9ryHMVWR9+6BckVN1EnUMX2GT16B6I+VZoQ=;
	b=B1+KG7uNDlR37w+2WdT2Z9mp9+hkmQ4c2plhD9ymnB2oKVUUM7AK1LiJvqR1CRkojh0CWM
	lMYn8+6iiImYyGAqh6HafKMCpDJjPEFy9IU8l/pL6Y6BJVqQuTkN7XuaiLrz/DzT+WgZKh
	Y3PI7fVyIOC89t2hnxZxJm1hRvL0Av9/dxRfvEMAfP7AjnGeYIPCvajw0ns+P9rFho4s6z
	iLwlCtjiP+qpzirfR/nwPEOdbgwLQYqhXfX7mAY5jxGZ7Tp2rkkD1UBjOPLExwDWVnMoQJ
	JXgdOoVOaxwHos/4S/azssF6lyQMyZ27pRu1mxZ640VIcUC2LjbJwc4dOnjjJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709650084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W78eNtAI9ryHMVWR9+6BckVN1EnUMX2GT16B6I+VZoQ=;
	b=ByrlwcG0t1sc6igsbM7NK+AxySV/Gd+mF/2FRf7vFEC9Le1J9lMJZEt2QfidaJWLi5PPjf
	Tw9XbqCwai4eTyBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Ai Chao <aichao@kylinos.cn>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4] platform/x86: add lenovo generic wmi driver
Message-ID: <20240305154002-7100004b-7ced-4ef0-9bbe-ad528e1869e2@linutronix.de>
References: <20240305121315.1744363-1-aichao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305121315.1744363-1-aichao@kylinos.cn>

On Tue, Mar 05, 2024 at 08:13:15PM +0800, Ai Chao wrote:
> Add lenovo generic wmi driver to support camera button.
> The Camera button is a GPIO device. This driver receives ACPI notifyi
>  when the button pressed.

the button *is* pressed.


The subject does not mention that it is only about te camera button.

I would be interested on which devices this driver was tested and is
expected to work with.

> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_wmi_priv.
> v3: Remove lenovo_wmi_remove function.
> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
> 
>  drivers/platform/x86/Kconfig             |  12 +++
>  drivers/platform/x86/Makefile            |   1 +
>  drivers/platform/x86/lenovo-wmi-camera.c | 118 +++++++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9a..079f5aa5910c 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
>  	To compile this driver as a module, choose M here: the module
>  	will be called inspur-platform-profile.
>  
> +config LENOVO_WMI_CAMERA
> +	tristate "Lenovo WMI Camera Button driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	help
> +	  This driver provides support for Lenovo camera button. The Camera
> +	  button is a GPIO device. This driver receives ACPI notify when the
> +	  button pressed.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called lenovo-wmi-camera.
> +
>  source "drivers/platform/x86/x86-android-tablets/Kconfig"
>  
>  config FW_ATTR_CLASS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 1de432e8861e..217e94d7c877 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
>  obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>  obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>  obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
> +obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
>  
>  # Intel
>  obj-y				+= intel/
> diff --git a/drivers/platform/x86/lenovo-wmi-camera.c b/drivers/platform/x86/lenovo-wmi-camera.c
> new file mode 100644
> index 000000000000..77084266829c
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lenovo WMI Camera Button Driver
> + *
> + * Author: Ai Chao <aichao@kylinos.cn>
> + * Copyright (C) 2024 KylinSoft Corporation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
> +
> +struct lenovo_wmi_priv {
> +	struct input_dev *idev;
> +	struct device *dev;
> +	u8 camera_mode;
> +};
> +
> +enum {
> +	CAMERA_BUTTON_PRESSED = 1,
> +};
> +
> +static ssize_t camerabutton_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct lenovo_wmi_priv *priv = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", priv->camera_mode);
> +}
> +DEVICE_ATTR_RO(camerabutton);
> +
> +static struct attribute *lenovo_wmi_attrs[] = {
> +	&dev_attr_camerabutton.attr,
> +	NULL,

No trailing comma after sentinel elements.

> +};
> +
> +static const struct attribute_group lenovo_wmi_group = {
> +	.attrs = lenovo_wmi_attrs,
> +};
> +
> +const struct attribute_group *lenovo_wmi_groups[] = {
> +	&lenovo_wmi_group,
> +	NULL,

Also no trailing comma.

> +};
> +
> +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_object *obj)
> +{
> +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +
> +	if (obj->type == ACPI_TYPE_BUFFER &&
> +	    obj->buffer.pointer[0] <= CAMERA_BUTTON_PRESSED) {
> +		/* Camera mode:
> +		 *      0 camera close
> +		 *      1 camera open
> +		 */
> +		priv->camera_mode = obj->buffer.pointer[0];

This looks similar to a switch.
Would it be more useful for the user to report a standard switch instead
of a key event which needs to be correlated with the sysfs file?

> +
> +		input_report_key(priv->idev, KEY_CAMERA, 1);
> +		input_sync(priv->idev);
> +		input_report_key(priv->idev, KEY_CAMERA, 0);
> +		input_sync(priv->idev);
> +	} else {
> +		dev_dbg(&wdev->dev, "Bad response type %d\n", obj->type);
> +	}
> +}
> +
> +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct lenovo_wmi_priv *priv;
> +
> +	priv = devm_kzalloc(&wdev->dev, sizeof(*priv),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	priv->idev = devm_input_allocate_device(&wdev->dev);
> +	if (!priv->idev)
> +		return -ENOMEM;
> +
> +	priv->idev->name = "Lenovo WMI Camera Button";
> +	priv->idev->phys = "wmi/input0";
> +	priv->idev->id.bustype = BUS_HOST;
> +	priv->idev->dev.parent = &wdev->dev;
> +	set_bit(EV_KEY, priv->idev->evbit);
> +	set_bit(KEY_CAMERA, priv->idev->keybit);

input_set_capability()?

> +
> +	return input_register_device(priv->idev);
> +}
> +
> +static const struct wmi_device_id lenovo_wmi_id_table[] = {
> +	{ .guid_string = WMI_LENOVO_CAMERABUTTON_EVENT_GUID },
> +	{  }
> +};
> +
> +static struct wmi_driver lenovo_wmi_driver = {
> +	.driver = {
> +		.name = "lenovo-wmi-camera",
> +		.dev_groups = lenovo_wmi_groups,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table = lenovo_wmi_id_table,
> +	.no_singleton = false,
> +	.probe = lenovo_wmi_probe,
> +	.notify = lenovo_wmi_notify,
> +};
> +
> +module_wmi_driver(lenovo_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Lenovo Generic WMI Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

