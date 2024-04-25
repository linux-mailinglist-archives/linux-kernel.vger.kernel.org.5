Return-Path: <linux-kernel+bounces-158373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00DC8B1EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8909D285261
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71F126F1D;
	Thu, 25 Apr 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Jp2qf/nV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29086629;
	Thu, 25 Apr 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040203; cv=none; b=uA8tUXSEPfKyUpw56t2PFpS2AKpaMS5ScxVCRR3htplIPLUW9+7mYNDL702JpW2q/sajxNEvXNbhHQDlB746DvD4SqJl7KAha5iR4hNe/Pgnf4s/iZEDwp3jwhJXfp/K0x9FrPzfT1UC1O2wUktTy/lZYcfjbabv80kf909i65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040203; c=relaxed/simple;
	bh=JxFzyBE2ZQODB3KYFqw2793763GvT8dRZ7h+3JwWiu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFiNQEbfa+XrxI800cj8d6Egfsym9Y0hz0A6aFzCVbI9Lc3mp4wewt1fgMNwupvTDT7H6ZBCedZszbQByeCz0SGHqwxQ6rdT2a99mTMUPmK8bIVECdc/xxjlhUkQhQXPjQugde5AvRBiRwdacWyUmHCqHG2iVlKs0PiURDg9jZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Jp2qf/nV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B1E9840E0177;
	Thu, 25 Apr 2024 10:16:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FCtK1WAIkr4K; Thu, 25 Apr 2024 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714040190; bh=lQVGO48zfCsjUCeoo0X+OlSYkAJs9QgyWvhiTbSIGUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jp2qf/nVwQRF+Tnee2mxsYOBpAmuqdRFgq5Fit9SSbryoXrWX6+lSjqdRDvutNbrY
	 gJ9K8rBc1x4dXpBLre21B3p6iMNJXKEGb8yY4w69RpgL9JlD/XPHrZuJLza3WACwWO
	 HDGL2TlQfHXqCgFtgkdP8cvVzp3UEDogiRO1dxWEloGaJt3W1Bthy9sJTA+hZUPamA
	 f8EI4qvxL1pU3RAGKTaaZLg5P1PnAsTIPK5b7dbnkjEwdxQc/5i66StISZ7M/41k1z
	 9rzAOXVROI9BbGciqGTvviBEEE+4w6omO/ehJLLFKstEsuytx9bgPaqZAc1CuOCbkk
	 VKB1yxsZoDiX3G1bt4eznI6p6hHpF2fued64cbEkbrgRDMfoZTscOrkOldAPCjSxDt
	 D5q9q3iP3b2eatofiDYitPOIl+RGAfczCgIwvkBijDsNNfhVpA/n/KIlzTEnvdDLGs
	 Z0E86zLf3N3GPPVN7ovbZF/tDkp7RRsO++OLPL8hJAp2qWCxckd+bPFpqttNxH076F
	 E4TriyrxZguOXsYcizJ9RYeBAFGrlhxdGwVWMm4o8TLimQWFLKPB3jhGkzbVZkJeDO
	 gamzx1ahQ/2erFJ0/JbHBrxP+y53/fum3xWBfy8+A1xGgE9cEGQSC320x9CVMNinur
	 c8i4aytaH4LYv+nyYZAYyV1E=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1660940E01C5;
	Thu, 25 Apr 2024 10:15:48 +0000 (UTC)
Date: Thu, 25 Apr 2024 12:15:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org,
	lenb@kernel.org, naoya.horiguchi@nec.com, james.morse@arm.com,
	jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	mike.malvestuto@intel.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240419164720.1765-2-shiju.jose@huawei.com>

On Sat, Apr 20, 2024 at 12:47:10AM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add scrub subsystem supports configuring the memory scrubbers
> in the system. The scrub subsystem provides the interface for
> registering the scrub devices. The scrub control attributes
> are provided to the user in /sys/class/ras/rasX/scrub
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  .../ABI/testing/sysfs-class-scrub-configure   |  47 +++
>  drivers/ras/Kconfig                           |   7 +
>  drivers/ras/Makefile                          |   1 +
>  drivers/ras/memory_scrub.c                    | 271 ++++++++++++++++++
>  include/linux/memory_scrub.h                  |  37 +++
>  5 files changed, 363 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
>  create mode 100755 drivers/ras/memory_scrub.c
>  create mode 100755 include/linux/memory_scrub.h

ERROR: modpost: missing MODULE_LICENSE() in drivers/ras/memory_scrub.o
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1871: modpost] Error 2
make: *** [Makefile:240: __sub-make] Error 2

Each patch of yours needs to build.

> diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Documentation/ABI/testing/sysfs-class-scrub-configure
> new file mode 100644
> index 000000000000..3ed77dbb00ad
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
> @@ -0,0 +1,47 @@
> +What:		/sys/class/ras/
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		The ras/ class subdirectory belongs to the
> +		common ras features such as scrub subsystem.
> +
> +What:		/sys/class/ras/rasX/scrub/
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		The /sys/class/ras/ras{0,1,2,3,...}/scrub directories

You have different scrubbers.

I'd prefer if you put their names in here instead and do this structure:

/sys/class/ras/scrub/cxl-patrol
		    /ars
		    /cxl-ecs
		    /acpi-ras2

and so on.

Unless the idea is for those devices to have multiple RAS-specific
functionality than just scrubbing. Then you want to do

/sys/class/ras/cxl/scrub
		  /other_function

/sys/class/ras/ars/scrub
		  /...

You get the idea.

> +		correspond to each scrub device registered with the
> +		scrub subsystem.
> +
> +What:		/sys/class/ras/rasX/scrub/name
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		(RO) name of the memory scrubber
> +
> +What:		/sys/class/ras/rasX/scrub/enable_background
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		(RW) Enable/Disable background(patrol) scrubbing if supported.
> +
> +What:		/sys/class/ras/rasX/scrub/rate_available

That's dumping a range so I guess it should be called probably
"possible_rates" or so, so that it is clear what it means.

If some scrubbers support only a discrete set of rate values, then
"possible_rates" fits too if you dump them as a list of values.

> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		(RO) Supported range for the scrub rate by the scrubber.
> +		The scrub rate represents in hours.
> +
> +What:		/sys/class/ras/rasX/scrub/rate
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		(RW) The scrub rate specified and it must be with in the
> +		supported range by the scrubber.
> +		The scrub rate represents in hours.
> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
> index fc4f4bb94a4c..181701479564 100644
> --- a/drivers/ras/Kconfig
> +++ b/drivers/ras/Kconfig
> @@ -46,4 +46,11 @@ config RAS_FMPM
>  	  Memory will be retired during boot time and run time depending on
>  	  platform-specific policies.
>  
> +config SCRUB
> +	tristate "Memory scrub driver"
> +	help
> +	  This option selects the memory scrub subsystem, supports

s/This option selects/Enable/

> +	  configuring the parameters of underlying scrubbers in the
> +	  system for the DRAM memories.
> +
>  endif
> diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
> index 11f95d59d397..89bcf0d84355 100644
> --- a/drivers/ras/Makefile
> +++ b/drivers/ras/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_RAS)	+= ras.o
>  obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
>  obj-$(CONFIG_RAS_CEC)	+= cec.o
> +obj-$(CONFIG_SCRUB)	+= memory_scrub.o
>  
>  obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
>  obj-y			+= amd/atl/
> diff --git a/drivers/ras/memory_scrub.c b/drivers/ras/memory_scrub.c
> new file mode 100755
> index 000000000000..7e995380ec3a
> --- /dev/null
> +++ b/drivers/ras/memory_scrub.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Memory scrub subsystem supports configuring the registered
> + * memory scrubbers.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#define pr_fmt(fmt)     "MEM SCRUB: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/kfifo.h>
> +#include <linux/memory_scrub.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +/* memory scrubber config definitions */

No need for that comment.

> +static ssize_t rate_available_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct scrub_device *scrub_dev = to_scrub_device(dev);
> +	u64 min_sr, max_sr;
> +	int ret;
> +
> +	ret = scrub_dev->ops->rate_avail_range(dev, &min_sr, &max_sr);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx-0x%llx\n", min_sr, max_sr);
> +}

This glue driver will need to store the min and max scrub rates on init
and rate_store() will have to verify the newly supplied rate is within
that range before writing it.

Not the user, nor the underlying hw driver.

> +
> +DEVICE_ATTR_RW(enable_background);
> +DEVICE_ATTR_RO(name);
> +DEVICE_ATTR_RW(rate);
> +DEVICE_ATTR_RO(rate_available);

static

> +
> +static struct attribute *scrub_attrs[] = {
> +	&dev_attr_enable_background.attr,
> +	&dev_attr_name.attr,
> +	&dev_attr_rate.attr,
> +	&dev_attr_rate_available.attr,
> +	NULL
> +};
> +
> +static umode_t scrub_attr_visible(struct kobject *kobj,
> +				  struct attribute *a, int attr_id)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct scrub_device *scrub_dev = to_scrub_device(dev);
> +	const struct scrub_ops *ops = scrub_dev->ops;
> +
> +	if (a == &dev_attr_enable_background.attr) {
> +		if (ops->set_enabled_bg && ops->get_enabled_bg)
> +			return a->mode;
> +		if (ops->get_enabled_bg)
> +			return 0444;
> +		return 0;
> +	}
> +	if (a == &dev_attr_name.attr)
> +		return ops->get_name ? a->mode : 0;
> +	if (a == &dev_attr_rate_available.attr)
> +		return ops->rate_avail_range ? a->mode : 0;
> +	if (a == &dev_attr_rate.attr) { /* Write only makes little sense */
> +		if (ops->rate_read && ops->rate_write)
> +			return a->mode;
> +		if (ops->rate_read)
> +			return 0444;
> +		return 0;
> +	}

All of that stuff's permissions should be root-only.

> +
> +	return 0;
> +}
> +
> +static const struct attribute_group scrub_attr_group = {
> +	.name		= "scrub",
> +	.attrs		= scrub_attrs,
> +	.is_visible	= scrub_attr_visible,
> +};
> +
> +static const struct attribute_group *scrub_attr_groups[] = {
> +	&scrub_attr_group,
> +	NULL
> +};
> +
> +static void scrub_dev_release(struct device *dev)
> +{
> +	struct scrub_device *scrub_dev = to_scrub_device(dev);
> +
> +	ida_free(&scrub_ida, scrub_dev->id);
> +	kfree(scrub_dev);
> +}
> +
> +static struct class scrub_class = {
> +	.name = "ras",
> +	.dev_groups = scrub_attr_groups,
> +	.dev_release = scrub_dev_release,
> +};
> +
> +static struct device *
> +scrub_device_register(struct device *parent, void *drvdata,
> +		      const struct scrub_ops *ops)
> +{
> +	struct scrub_device *scrub_dev;
> +	struct device *hdev;
> +	int err;
> +
> +	scrub_dev = kzalloc(sizeof(*scrub_dev), GFP_KERNEL);
> +	if (!scrub_dev)
> +		return ERR_PTR(-ENOMEM);
> +	hdev = &scrub_dev->dev;
> +
> +	scrub_dev->id = ida_alloc(&scrub_ida, GFP_KERNEL);

What's that silly thing for?

> +	if (scrub_dev->id < 0) {
> +		kfree(scrub_dev);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	scrub_dev->ops = ops;
> +	hdev->class = &scrub_class;
> +	hdev->parent = parent;
> +	dev_set_drvdata(hdev, drvdata);
> +	dev_set_name(hdev, SCRUB_ID_FORMAT, scrub_dev->id);
> +	err = device_register(hdev);
> +	if (err) {
> +		put_device(hdev);
> +		return ERR_PTR(err);
> +	}
> +
> +	return hdev;
> +}
> +
> +static void devm_scrub_release(void *dev)
> +{
> +	device_unregister(dev);
> +}
> +
> +/**
> + * devm_scrub_device_register - register scrubber device
> + * @dev: the parent device
> + * @drvdata: driver data to attach to the scrub device
> + * @ops: pointer to scrub_ops structure (optional)
> + *
> + * Returns the pointer to the new device on success, ERR_PTR() otherwise.
> + * The new device would be automatically unregistered with the parent device.
> + */
> +struct device *
> +devm_scrub_device_register(struct device *dev, void *drvdata,
> +			   const struct scrub_ops *ops)
> +{
> +	struct device *hdev;
> +	int ret;
> +
> +	if (!dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	hdev = scrub_device_register(dev, drvdata, ops);
> +	if (IS_ERR(hdev))
> +		return hdev;
> +
> +	ret = devm_add_action_or_reset(dev, devm_scrub_release, hdev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return hdev;
> +}
> +EXPORT_SYMBOL_GPL(devm_scrub_device_register);
> +
> +static int __init memory_scrub_control_init(void)
> +{
> +	return class_register(&scrub_class);
> +}
> +subsys_initcall(memory_scrub_control_init);

You can't just blindly register this thing without checking whether
there are even any hw scrubber devices on the system.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

