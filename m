Return-Path: <linux-kernel+bounces-70640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3923859A96
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBBAB20C36
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 01:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A53F1FB3;
	Mon, 19 Feb 2024 01:49:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4C2EDD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708307347; cv=none; b=FwAzbrwoAB9x8GBPKPtl31l+RB6O7zYJ5EOwLl5OcH7e6xUSBDncUYXtXhnqzv2YELbgQ0n0ueO/2bZUoXSjeexemuGLw2XNLKdDwEdA+3uuZ5CP6xymwp35uD0aGa5qIYT1VTjb4v6Yg0+4RWmYZ64TOOkY8+Lm5JcHFRvT4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708307347; c=relaxed/simple;
	bh=/+A2x1jMwrF0kaNIZ7nVmUvk0x4kJI9kCjxVuYXxOFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISRRldvtCiOdB8aZhPLFzVYrkhyQoc3uBMsQads5RbOQA1chyqwejiN86wK90uHSHYwxVBxxuNfjQI8MvM8+jBK/sPZhiDnCA8Qkz1TFcjU3wQl1htly0HkbuqM2X0WZLz8OlAoNCVPczwsh9jokA/rvEea2CtSJ3MUHDXFvzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rbslz-0004De-Vq; Mon, 19 Feb 2024 02:48:47 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rbslv-001YPK-QO; Mon, 19 Feb 2024 02:48:43 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rbslv-00FiMX-2I;
	Mon, 19 Feb 2024 02:48:43 +0100
Date: Mon, 19 Feb 2024 02:48:43 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] usb: gadget: legacy: add 9pfs multi gadget
Message-ID: <ZdKze80oFj0PRkkZ@pengutronix.de>
References: <20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de>
 <20240116-ml-topic-u9p-v2-3-b46cbf592962@pengutronix.de>
 <2024021757-geography-hacksaw-3022@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hmLwYFImqzne253t"
Content-Disposition: inline
In-Reply-To: <2024021757-geography-hacksaw-3022@gregkh>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--hmLwYFImqzne253t
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 04:59:28PM +0100, Greg Kroah-Hartman wrote:
>On Fri, Feb 02, 2024 at 01:05:12AM +0100, Michael Grzeschik wrote:
>> Add the newly introduced 9pfs transport gadget interface with an new
>> multi composed gadget together with acm and eem.
>>
>> When using this legacy module, it is also possible to
>> mount the 9PFS usb dir as root filesystem. Just follow the
>> instrucitons from Documentation/filesystems/9p.rst
>
>Why are we adding new "legacy" gadgets?  What's wrong with the "correct"
>api instead?  You need a lot of justification here to add something to
>an api we want to one day just delete.

Without the legacy gadget there is no real solution to mount
the 9pfs via the gadget as rootfs. The "correct" api is configfs
which will need the user to have some filesystem to mount it to.

There is the relatively new concept of bootconfig which sounds
promising to describe an complete configfs tree from system boot.

However this is some future talk for now, so we would like to
stick with the legacy setup to be able to mount the 9pfs rootfs.

I will improve the commit message to make this clear.

>And can you wrap your changelog at 72 columns?

Sure

>
>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>> ---
>> v1 -> v2:
>>   - deleted the usbg 9pfs detailed instruction from commit message
>>   - added depends on net for NET_9P dependency
>> ---
>>  drivers/usb/gadget/legacy/9pfs.c   | 268 ++++++++++++++++++++++++++++++=
+++++++
>>  drivers/usb/gadget/legacy/Kconfig  |  16 +++
>>  drivers/usb/gadget/legacy/Makefile |   2 +
>>  3 files changed, 286 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/legacy/9pfs.c b/drivers/usb/gadget/legac=
y/9pfs.c
>> new file mode 100644
>> index 0000000000000..3ac7f2e92c5a3
>> --- /dev/null
>> +++ b/drivers/usb/gadget/legacy/9pfs.c
>> @@ -0,0 +1,268 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * usb9pfs.c -- Gadget usb9pfs
>> + *
>> + * Copyright (C) 2023 Michael Grzeschik
>> + */
>> +
>> +/*
>> + * Gadget usb9pfs only needs two bulk endpoints, and will use the usb9p=
fs usb
>> + * transport to mount host filesystem via usb gadget. This driver will
>> + * also add one ACM and NCM interface.
>
>Why "also"?  What are those interfaces going to be used for and what do
>they have to do with 9pfs?

They are not necessary to be used with 9pfs. But since we introduce an
new legacy module which is fully claiming the UDC, it would make sense
to leave the other endpoints unavailable but instead add some common
interfaces like ecm and acm.

I will also improve the comment and the commit message to point this
out.

>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/err.h>
>> +#include <linux/usb/composite.h>
>> +#include <linux/netdevice.h>
>> +
>> +#include "u_eem.h"
>> +#include "u_ether.h"
>> +
>> +/*---------------------------------------------------------------------=
----*/
>> +USB_GADGET_COMPOSITE_OPTIONS();
>> +
>> +USB_ETHERNET_MODULE_PARAMETERS();
>> +
>> +/* Defines */
>> +
>> +#define DRIVER_VERSION_STR "v1.0"
>> +#define DRIVER_VERSION_NUM 0x1000
>> +
>> +#define DRIVER_DESC	"Composite Gadget (9P + ACM + NCM)"
>> +
>> +/*---------------------------------------------------------------------=
----*/
>> +
>> +#define DRIVER_VENDOR_NUM	0x1d6b		/* Linux Foundation */
>> +#define DRIVER_PRODUCT_NUM	0x0109		/* Linux-USB 9PFS Gadget */
>> +
>> +/*---------------------------------------------------------------------=
----*/
>> +
>> +static struct usb_device_descriptor device_desc =3D {
>> +	.bLength =3D		sizeof(device_desc),
>> +	.bDescriptorType =3D	USB_DT_DEVICE,
>> +
>> +	/* .bcdUSB =3D DYNAMIC */
>> +
>> +	.bDeviceClass =3D		USB_CLASS_MISC,
>> +	.bDeviceSubClass =3D	2,
>> +	.bDeviceProtocol =3D	1,
>> +
>> +	/* .bMaxPacketSize0 =3D f(hardware) */
>> +
>> +	/* Vendor and product id can be overridden by module parameters.  */
>> +	.idVendor =3D		cpu_to_le16(DRIVER_VENDOR_NUM),
>> +	.idProduct =3D		cpu_to_le16(DRIVER_PRODUCT_NUM),
>> +	/* .bcdDevice =3D f(hardware) */
>> +	/* .iManufacturer =3D DYNAMIC */
>> +	/* .iProduct =3D DYNAMIC */
>> +	/* NO SERIAL NUMBER */
>> +	/*.bNumConfigurations =3D	DYNAMIC*/
>> +};
>> +
>> +static const struct usb_descriptor_header *otg_desc[2];
>> +
>> +static struct usb_string strings_dev[] =3D {
>> +	[USB_GADGET_MANUFACTURER_IDX].s =3D "",
>> +	[USB_GADGET_PRODUCT_IDX].s =3D DRIVER_DESC,
>> +	[USB_GADGET_SERIAL_IDX].s =3D "",
>> +	{  }			/* end of list */
>> +};
>> +
>> +static struct usb_gadget_strings stringtab_dev =3D {
>> +	.language	=3D 0x0409,	/* en-us */
>> +	.strings	=3D strings_dev,
>> +};
>> +
>> +static struct usb_gadget_strings *dev_strings[] =3D {
>> +	&stringtab_dev,
>> +	NULL,
>> +};
>> +
>> +static struct usb_configuration cdc_driver_conf =3D {
>> +	.label          =3D DRIVER_DESC,
>> +	.bConfigurationValue =3D 1,
>> +	/* .iConfiguration =3D DYNAMIC */
>> +	.bmAttributes   =3D USB_CONFIG_ATT_SELFPOWER,
>> +};
>> +
>> +static struct usb_function *f_9pfs;
>> +static struct usb_function_instance *fi_9pfs;
>> +
>> +static struct usb_function *f_acm;
>> +static struct usb_function_instance *fi_acm;
>> +
>> +static struct usb_function *f_eem;
>> +static struct usb_function_instance *fi_eem;
>> +
>> +static int cdc_do_config(struct usb_configuration *c)
>> +{
>> +	int ret;
>> +
>> +	if (gadget_is_otg(c->cdev->gadget)) {
>> +		c->descriptors =3D otg_desc;
>> +		c->bmAttributes |=3D USB_CONFIG_ATT_WAKEUP;
>> +	}
>> +
>> +	f_9pfs =3D usb_get_function(fi_9pfs);
>> +	if (IS_ERR(f_9pfs))
>> +		return PTR_ERR(f_9pfs);
>> +
>> +	ret =3D usb_add_function(c, f_9pfs);
>> +	if (ret < 0)
>> +		goto err_func_9pfs;
>> +
>> +	f_acm =3D usb_get_function(fi_acm);
>> +	if (IS_ERR(f_acm)) {
>> +		ret =3D PTR_ERR(f_acm);
>> +		goto err_func_acm;
>> +	}
>> +
>> +	ret =3D usb_add_function(c, f_acm);
>> +	if (ret)
>> +		goto err_conf;
>> +
>> +	f_eem =3D usb_get_function(fi_eem);
>> +	if (IS_ERR(f_eem)) {
>> +		ret =3D PTR_ERR(f_eem);
>> +		goto err_eem;
>> +	}
>> +
>> +	ret =3D usb_add_function(c, f_eem);
>> +	if (ret)
>> +		goto err_run;
>> +
>> +	return 0;
>> +err_run:
>> +	usb_put_function(f_eem);
>> +err_eem:
>> +	usb_remove_function(c, f_acm);
>> +err_conf:
>> +	usb_put_function(f_acm);
>> +err_func_acm:
>> +	usb_remove_function(c, f_9pfs);
>> +err_func_9pfs:
>> +	usb_put_function(f_9pfs);
>> +	return ret;
>> +}
>> +
>> +static int usb9pfs_bind(struct usb_composite_dev *cdev)
>> +{
>> +	struct f_eem_opts	*eem_opts =3D NULL;
>> +	int status;
>> +
>> +	fi_9pfs =3D usb_get_function_instance("usb9pfs");
>> +	if (IS_ERR(fi_9pfs)) {
>> +		if (PTR_ERR(fi_9pfs) =3D=3D -ENOENT)
>> +			return -EPROBE_DEFER;
>> +		return PTR_ERR(fi_9pfs);
>> +	}
>> +
>> +	/* set up serial link layer */
>> +	fi_acm =3D usb_get_function_instance("acm");
>> +	if (IS_ERR(fi_acm)) {
>> +		if (PTR_ERR(fi_9pfs) =3D=3D -ENOENT)
>> +			return -EPROBE_DEFER;
>> +		status =3D PTR_ERR(fi_acm);
>> +		goto err_conf_acm;
>> +	}
>> +
>> +	fi_eem =3D usb_get_function_instance("eem");
>> +	if (IS_ERR(fi_eem)) {
>> +		if (PTR_ERR(fi_9pfs) =3D=3D -ENOENT)
>> +			return -EPROBE_DEFER;
>> +		status =3D PTR_ERR(fi_eem);
>> +		goto err_conf_eem;
>> +	}
>> +
>> +	eem_opts =3D container_of(fi_eem, struct f_eem_opts, func_inst);
>> +
>> +	gether_set_qmult(eem_opts->net, qmult);
>> +	if (!gether_set_host_addr(eem_opts->net, host_addr))
>> +		pr_info("using host ethernet address: %s", host_addr);
>> +	if (!gether_set_dev_addr(eem_opts->net, dev_addr))
>> +		pr_info("using self ethernet address: %s", dev_addr);
>> +
>> +	/* Allocate string descriptor numbers ... note that string
>> +	 * contents can be overridden by the composite_dev glue.
>> +	 */
>> +	status =3D usb_string_ids_tab(cdev, strings_dev);
>> +	if (status < 0)
>> +		return status;
>> +
>> +	device_desc.iManufacturer =3D strings_dev[USB_GADGET_MANUFACTURER_IDX]=
=2Eid;
>> +	device_desc.iProduct =3D strings_dev[USB_GADGET_PRODUCT_IDX].id;
>> +	device_desc.iSerialNumber =3D strings_dev[USB_GADGET_SERIAL_IDX].id;
>> +
>> +	/* support OTG systems */
>> +	if (gadget_is_otg(cdev->gadget)) {
>> +		if (!otg_desc[0]) {
>> +			struct usb_descriptor_header *usb_desc;
>> +
>> +			usb_desc =3D usb_otg_descriptor_alloc(cdev->gadget);
>> +			if (!usb_desc) {
>> +				status =3D -ENOMEM;
>> +				goto err_conf_otg;
>> +			}
>> +			usb_otg_descriptor_init(cdev->gadget, usb_desc);
>> +			otg_desc[0] =3D usb_desc;
>> +			otg_desc[1] =3D NULL;
>> +		}
>> +	}
>> +
>> +	status =3D usb_add_config(cdev, &cdc_driver_conf, cdc_do_config);
>> +	if (status)
>> +		goto err_free_otg_desc;
>> +
>> +	usb_ep_autoconfig_reset(cdev->gadget);
>> +	usb_composite_overwrite_options(cdev, &coverwrite);
>> +
>> +	dev_info(&cdev->gadget->dev, DRIVER_DESC " version: " DRIVER_VERSION_S=
TR "\n");
>
>When drivers are working properly, they are quiet.

Right, I will fix that.

Thanks,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--hmLwYFImqzne253t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmXSs3UACgkQC+njFXoe
LGRxbQ/7BYgYye1JCQtKM2lwhdqY75Nya3hWcCw66xFW6MyuIjh/wXsfMXZDC3dK
/19EfJQplNzSMCwDZFeA7HgJ8wxfl8ayjv90JZ7a66UJ1BYmXmojkLiDrn7LzUpa
MBFZJfEQrZHGW/3YF0ifrbkov9wkSf6LXyS8MoVCbSgl9eL60JNDqD82VbZC+HQg
1BYWYnorUQULrqYPB1FEg/N0QMBXyadXAu7EdG6nV/Zxlown5hhOXeB4aAvnguxe
BXVwVV63rIMUwAtFfK8/RX6PhOLrNZTQ/z/ol1LvilWFlJ6mxNH6CHiWUeJw1vn3
kodbANq4oadIvrInLL65woZp+4tyffMgIdnA/c8TyNgG1HwSlTwWlDvPi2zsB8gH
P/tlRLmv0VUCbUXx+xtdfDdWCSX2cDsAQgnSvXKOFTDt84lfjCO9LNpRs6OjuvTP
PvHO5IUziH9wIi1Q9VFFoXd38be4V6N26w90LL4WefMzeVx4Fo935Nb8gklO6ZYW
izwqdY9wnccy40nSKXbPDUxHg6P/YbbcWp/z2z9mrT9S4e/LqvwYrQsJyZrbcKj8
47NZmc2bXJUc+AjfGk8NwfLsk8vkEdDLjp9jQeIDHTOd0sq/59gs10gLNFm8pjw4
hcBmryl9RgQk3OOWtys/hShrztriLxEFpewUwZLPCziWqq3EaLY=
=WfB2
-----END PGP SIGNATURE-----

--hmLwYFImqzne253t--

