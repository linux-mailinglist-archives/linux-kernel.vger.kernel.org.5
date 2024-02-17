Return-Path: <linux-kernel+bounces-69953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0878590BB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4343BB218EA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB667CF1E;
	Sat, 17 Feb 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KepOSB9h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E107CF09;
	Sat, 17 Feb 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708185572; cv=none; b=N5445aJXLfD1M4PECHgd3gAn7axNkrlOOzHYMdGB/te7Knm9CPnSaQKKOR/VYOUdItitYtKCcQwOvojW/ydD1oZNB6+Z492vfa+3ux9FT0e17shStgUzLyTZfPF7MwNlf6AfXttTe1ne7Q/Sd6yUwXN3LUThTRsJTy1VgzDMRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708185572; c=relaxed/simple;
	bh=7dZw91IA9UkGUlxTQU6Q6OBgjnh8TxNDIuPOvGMyW+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC1MrMeW0IRtOyFb/3fCaAnWeyyrcecfDFGQeM3U7FLZEac4MlQ1OJMzRfw07iT99w5dxZmP/IXCwTDEqz0gYvW5Nz72LmmI6DVr0Uf1+MOv+uIKQpNFOM3wgj4fmzIJp+fXnU2ubWeA7GHu62svneIazoaS8uIca4nC3eCa3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KepOSB9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE532C433F1;
	Sat, 17 Feb 2024 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708185571;
	bh=7dZw91IA9UkGUlxTQU6Q6OBgjnh8TxNDIuPOvGMyW+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KepOSB9hcnZ18sO/rJ+FcR2yhbl+WVXSspcGEoMD1mv8cLnqYI7QlddgpN112h3T5
	 Y27MQsCpWDeeAXl/WVjwlI2fLYdf6PBWgHO0B21LoWBkLaNC7LVxRTCjIhAr5TLpko
	 p39BJRVqtq1XMqlBeI0oxXJalJfS4y8g6CEmwAFE=
Date: Sat, 17 Feb 2024 16:59:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] usb: gadget: legacy: add 9pfs multi gadget
Message-ID: <2024021757-geography-hacksaw-3022@gregkh>
References: <20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de>
 <20240116-ml-topic-u9p-v2-3-b46cbf592962@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v2-3-b46cbf592962@pengutronix.de>

On Fri, Feb 02, 2024 at 01:05:12AM +0100, Michael Grzeschik wrote:
> Add the newly introduced 9pfs transport gadget interface with an new
> multi composed gadget together with acm and eem.
> 
> When using this legacy module, it is also possible to
> mount the 9PFS usb dir as root filesystem. Just follow the
> instrucitons from Documentation/filesystems/9p.rst

Why are we adding new "legacy" gadgets?  What's wrong with the "correct"
api instead?  You need a lot of justification here to add something to
an api we want to one day just delete.

And can you wrap your changelog at 72 columns?


> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> ---
> v1 -> v2:
>   - deleted the usbg 9pfs detailed instruction from commit message
>   - added depends on net for NET_9P dependency
> ---
>  drivers/usb/gadget/legacy/9pfs.c   | 268 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/gadget/legacy/Kconfig  |  16 +++
>  drivers/usb/gadget/legacy/Makefile |   2 +
>  3 files changed, 286 insertions(+)
> 
> diff --git a/drivers/usb/gadget/legacy/9pfs.c b/drivers/usb/gadget/legacy/9pfs.c
> new file mode 100644
> index 0000000000000..3ac7f2e92c5a3
> --- /dev/null
> +++ b/drivers/usb/gadget/legacy/9pfs.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * usb9pfs.c -- Gadget usb9pfs
> + *
> + * Copyright (C) 2023 Michael Grzeschik
> + */
> +
> +/*
> + * Gadget usb9pfs only needs two bulk endpoints, and will use the usb9pfs usb
> + * transport to mount host filesystem via usb gadget. This driver will
> + * also add one ACM and NCM interface.

Why "also"?  What are those interfaces going to be used for and what do
they have to do with 9pfs?

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/usb/composite.h>
> +#include <linux/netdevice.h>
> +
> +#include "u_eem.h"
> +#include "u_ether.h"
> +
> +/*-------------------------------------------------------------------------*/
> +USB_GADGET_COMPOSITE_OPTIONS();
> +
> +USB_ETHERNET_MODULE_PARAMETERS();
> +
> +/* Defines */
> +
> +#define DRIVER_VERSION_STR "v1.0"
> +#define DRIVER_VERSION_NUM 0x1000
> +
> +#define DRIVER_DESC	"Composite Gadget (9P + ACM + NCM)"
> +
> +/*-------------------------------------------------------------------------*/
> +
> +#define DRIVER_VENDOR_NUM	0x1d6b		/* Linux Foundation */
> +#define DRIVER_PRODUCT_NUM	0x0109		/* Linux-USB 9PFS Gadget */
> +
> +/*-------------------------------------------------------------------------*/
> +
> +static struct usb_device_descriptor device_desc = {
> +	.bLength =		sizeof(device_desc),
> +	.bDescriptorType =	USB_DT_DEVICE,
> +
> +	/* .bcdUSB = DYNAMIC */
> +
> +	.bDeviceClass =		USB_CLASS_MISC,
> +	.bDeviceSubClass =	2,
> +	.bDeviceProtocol =	1,
> +
> +	/* .bMaxPacketSize0 = f(hardware) */
> +
> +	/* Vendor and product id can be overridden by module parameters.  */
> +	.idVendor =		cpu_to_le16(DRIVER_VENDOR_NUM),
> +	.idProduct =		cpu_to_le16(DRIVER_PRODUCT_NUM),
> +	/* .bcdDevice = f(hardware) */
> +	/* .iManufacturer = DYNAMIC */
> +	/* .iProduct = DYNAMIC */
> +	/* NO SERIAL NUMBER */
> +	/*.bNumConfigurations =	DYNAMIC*/
> +};
> +
> +static const struct usb_descriptor_header *otg_desc[2];
> +
> +static struct usb_string strings_dev[] = {
> +	[USB_GADGET_MANUFACTURER_IDX].s = "",
> +	[USB_GADGET_PRODUCT_IDX].s = DRIVER_DESC,
> +	[USB_GADGET_SERIAL_IDX].s = "",
> +	{  }			/* end of list */
> +};
> +
> +static struct usb_gadget_strings stringtab_dev = {
> +	.language	= 0x0409,	/* en-us */
> +	.strings	= strings_dev,
> +};
> +
> +static struct usb_gadget_strings *dev_strings[] = {
> +	&stringtab_dev,
> +	NULL,
> +};
> +
> +static struct usb_configuration cdc_driver_conf = {
> +	.label          = DRIVER_DESC,
> +	.bConfigurationValue = 1,
> +	/* .iConfiguration = DYNAMIC */
> +	.bmAttributes   = USB_CONFIG_ATT_SELFPOWER,
> +};
> +
> +static struct usb_function *f_9pfs;
> +static struct usb_function_instance *fi_9pfs;
> +
> +static struct usb_function *f_acm;
> +static struct usb_function_instance *fi_acm;
> +
> +static struct usb_function *f_eem;
> +static struct usb_function_instance *fi_eem;
> +
> +static int cdc_do_config(struct usb_configuration *c)
> +{
> +	int ret;
> +
> +	if (gadget_is_otg(c->cdev->gadget)) {
> +		c->descriptors = otg_desc;
> +		c->bmAttributes |= USB_CONFIG_ATT_WAKEUP;
> +	}
> +
> +	f_9pfs = usb_get_function(fi_9pfs);
> +	if (IS_ERR(f_9pfs))
> +		return PTR_ERR(f_9pfs);
> +
> +	ret = usb_add_function(c, f_9pfs);
> +	if (ret < 0)
> +		goto err_func_9pfs;
> +
> +	f_acm = usb_get_function(fi_acm);
> +	if (IS_ERR(f_acm)) {
> +		ret = PTR_ERR(f_acm);
> +		goto err_func_acm;
> +	}
> +
> +	ret = usb_add_function(c, f_acm);
> +	if (ret)
> +		goto err_conf;
> +
> +	f_eem = usb_get_function(fi_eem);
> +	if (IS_ERR(f_eem)) {
> +		ret = PTR_ERR(f_eem);
> +		goto err_eem;
> +	}
> +
> +	ret = usb_add_function(c, f_eem);
> +	if (ret)
> +		goto err_run;
> +
> +	return 0;
> +err_run:
> +	usb_put_function(f_eem);
> +err_eem:
> +	usb_remove_function(c, f_acm);
> +err_conf:
> +	usb_put_function(f_acm);
> +err_func_acm:
> +	usb_remove_function(c, f_9pfs);
> +err_func_9pfs:
> +	usb_put_function(f_9pfs);
> +	return ret;
> +}
> +
> +static int usb9pfs_bind(struct usb_composite_dev *cdev)
> +{
> +	struct f_eem_opts	*eem_opts = NULL;
> +	int status;
> +
> +	fi_9pfs = usb_get_function_instance("usb9pfs");
> +	if (IS_ERR(fi_9pfs)) {
> +		if (PTR_ERR(fi_9pfs) == -ENOENT)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(fi_9pfs);
> +	}
> +
> +	/* set up serial link layer */
> +	fi_acm = usb_get_function_instance("acm");
> +	if (IS_ERR(fi_acm)) {
> +		if (PTR_ERR(fi_9pfs) == -ENOENT)
> +			return -EPROBE_DEFER;
> +		status = PTR_ERR(fi_acm);
> +		goto err_conf_acm;
> +	}
> +
> +	fi_eem = usb_get_function_instance("eem");
> +	if (IS_ERR(fi_eem)) {
> +		if (PTR_ERR(fi_9pfs) == -ENOENT)
> +			return -EPROBE_DEFER;
> +		status = PTR_ERR(fi_eem);
> +		goto err_conf_eem;
> +	}
> +
> +	eem_opts = container_of(fi_eem, struct f_eem_opts, func_inst);
> +
> +	gether_set_qmult(eem_opts->net, qmult);
> +	if (!gether_set_host_addr(eem_opts->net, host_addr))
> +		pr_info("using host ethernet address: %s", host_addr);
> +	if (!gether_set_dev_addr(eem_opts->net, dev_addr))
> +		pr_info("using self ethernet address: %s", dev_addr);
> +
> +	/* Allocate string descriptor numbers ... note that string
> +	 * contents can be overridden by the composite_dev glue.
> +	 */
> +	status = usb_string_ids_tab(cdev, strings_dev);
> +	if (status < 0)
> +		return status;
> +
> +	device_desc.iManufacturer = strings_dev[USB_GADGET_MANUFACTURER_IDX].id;
> +	device_desc.iProduct = strings_dev[USB_GADGET_PRODUCT_IDX].id;
> +	device_desc.iSerialNumber = strings_dev[USB_GADGET_SERIAL_IDX].id;
> +
> +	/* support OTG systems */
> +	if (gadget_is_otg(cdev->gadget)) {
> +		if (!otg_desc[0]) {
> +			struct usb_descriptor_header *usb_desc;
> +
> +			usb_desc = usb_otg_descriptor_alloc(cdev->gadget);
> +			if (!usb_desc) {
> +				status = -ENOMEM;
> +				goto err_conf_otg;
> +			}
> +			usb_otg_descriptor_init(cdev->gadget, usb_desc);
> +			otg_desc[0] = usb_desc;
> +			otg_desc[1] = NULL;
> +		}
> +	}
> +
> +	status = usb_add_config(cdev, &cdc_driver_conf, cdc_do_config);
> +	if (status)
> +		goto err_free_otg_desc;
> +
> +	usb_ep_autoconfig_reset(cdev->gadget);
> +	usb_composite_overwrite_options(cdev, &coverwrite);
> +
> +	dev_info(&cdev->gadget->dev, DRIVER_DESC " version: " DRIVER_VERSION_STR "\n");

When drivers are working properly, they are quiet.

thanks,

greg k-h

