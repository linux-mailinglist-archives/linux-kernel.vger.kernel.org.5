Return-Path: <linux-kernel+bounces-157683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337388B1490
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E67B21888
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A36142659;
	Wed, 24 Apr 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCDPwWus"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245B134A8;
	Wed, 24 Apr 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990372; cv=none; b=FON9h5hKbHe8JTrkiVvX732nmYzFDxjyevboMdzyxkBJsVoRXyTpqkxIrfvgE9vRdTeW8AsL/EK/A/zwdx9ZNUTJdayz2hKLOG2AY+Xi6TFpG6T4j9FQxWkg2Jv6hA4be7LRTtYJIfdjooYmACQU4ZNZc0k7fkUAF1QXXzF+3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990372; c=relaxed/simple;
	bh=3E6hBRp+q6RqA9OZIcTord3rpr9d9+SPNfOfM8PyddI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibXPlBMmMyBrrEKhSk1GK8lLg0HHQKgZno8awmZcWLfTbjIMQQFXVe4RK61fxirXucVgekv4uDM9SgqUi/Fupfqnbjbo+cxzH6jGFNaeZ6HMBQgKBOMFqZyI1PbLh3412HgdqP+Te35IBcIk4PlkjKV2ZeUVAzE8MJdHkYpkWDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCDPwWus; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-232f2b86e4fso143320fac.3;
        Wed, 24 Apr 2024 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713990369; x=1714595169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=incol+l1cttU80jXk2nqyGIlECdYg5DlgRh3ZAraHcI=;
        b=HCDPwWusnWZP1yzDJyyw8OOb6k4CHjIh65r3aEWNn0kEusm4bIxLLe6G3TJdJY9Hez
         gA5JUDmaxQVAvflYUOad6YBX8xDB6N+n/fZzJBCGlUUxg4rHmWtnasJHMl7WHqXq2se4
         s8Ww+Qg2Hnrdba5Vr81pCmmtj16+/bbdDYAtgXY39SMxvKNB0jry8yoa/TWxA8qrBGZi
         T7rvJ8KFDn6QQy0YT5vdQExmZCYAmIvqg1O4lPccJZ2jBs0n0Wbnp61VPOrspkLHwwrA
         l9epSzaE9Xri1Fhgsx1zjLZ3pAkV2jyBnCD0b2zGjFlQPn9dUlVJUIQ7/7UUX99jRolE
         34pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713990369; x=1714595169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=incol+l1cttU80jXk2nqyGIlECdYg5DlgRh3ZAraHcI=;
        b=A8om7LNHM2wJ/coL25ska37ZyuxHvfLf6niz9g5KrIaNpQz9m3kROcvhMlriODmAZk
         kQtY0chISyU5CgjdT081NEmwF1xyMbwt0Z9o3j56mVJwTsVJljge9Fp020wRRwnJJkYw
         dUbh3BbH5SBnpC8g8EELldXdy7f52hqV6vTZLnRKGBbzSvRoO/Wy9J7jbougtKTAKX6x
         5fQ/huwtpUQhs8emHGAmt5AUdwj/6Xc/KER4y50BJTIZYxbga516b9HfXHfwCeRIEYJf
         6Mqlf9hmrqlyEYpVQnOAfMnV+ZehTirJiHNTo2huT8qJTmaopCNeTOb4Hp+qwwZ5wjbA
         pk/g==
X-Forwarded-Encrypted: i=1; AJvYcCUxsu2zusA3iCcDvqYfh8r0TxNuMet4xuM8FNfDAyk7/QHvaTkaz47b7uUHLjIu30C0mH9MiRkGE2en4iwoqyO+46kl3vZQ8DfK+LNAHMohUNP+Jnb+QvxuwwNgJOOmwHiWMRr38ss2gjGnN8QvAUp3R0HDVr1EYLu8KCMCQUhp5UuZIPY=
X-Gm-Message-State: AOJu0YzYvURxPyM9a5zKhDSEfigIxom/CbmQeXVYGOIsQWvTokhw/DA5
	xvhuFFjSL3fTeOKIF90LoHIYPUYp39ZQyMDvOHVv7jCPTejxX38g
X-Google-Smtp-Source: AGHT+IFhXCtEEypDPb+KRK/ZNKaDwjojMo4l1m6xexhGZqfv+stKhOGdYK5rdm1vBXBnystoX42XUQ==
X-Received: by 2002:a05:6870:e245:b0:233:b5dd:471c with SMTP id d5-20020a056870e24500b00233b5dd471cmr3861498oac.51.1713990369274;
        Wed, 24 Apr 2024 13:26:09 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b318:9476:706a:e82a])
        by smtp.gmail.com with ESMTPSA id p5-20020a634f45000000b005f05c88c149sm11622926pgl.71.2024.04.24.13.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 13:26:08 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Apr 2024 13:25:52 -0700
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
Message-ID: <Zilq0ER7C8zeo3j8@debian>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
> 
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
> +#define SCRUB_ID_PREFIX "ras"
> +#define SCRUB_ID_FORMAT SCRUB_ID_PREFIX "%d"
> +
> +static DEFINE_IDA(scrub_ida);
> +
> +struct scrub_device {
> +	int id;
> +	struct device dev;
> +	const struct scrub_ops *ops;
> +};
> +
> +#define to_scrub_device(d) container_of(d, struct scrub_device, dev)
> +static ssize_t enable_background_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct scrub_device *scrub_dev = to_scrub_device(dev);
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = scrub_dev->ops->set_enabled_bg(dev, enable);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t enable_background_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct scrub_device *scrub_dev = to_scrub_device(dev);
> +	bool enable;
> +	int ret;
> +
> +	ret = scrub_dev->ops->get_enabled_bg(dev, &enable);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", enable);
> +}
> +
> +static ssize_t name_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct scrub_device *scrub_dev = to_scrub_device(dev);
> +	int ret;
> +
> +	ret = scrub_dev->ops->get_name(dev, buf);
> +	if (ret)
> +		return ret;
> +
> +	return strlen(buf);
> +}
> +
> +static ssize_t rate_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct scrub_device *scrub_dev = to_scrub_device(dev);
> +	u64 val;
> +	int ret;
> +
> +	ret = scrub_dev->ops->rate_read(dev, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", val);
> +}
> +
> +static ssize_t rate_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	struct scrub_device *scrub_dev = to_scrub_device(dev);
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = scrub_dev->ops->rate_write(dev, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
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
> +
> +DEVICE_ATTR_RW(enable_background);
> +DEVICE_ATTR_RO(name);
> +DEVICE_ATTR_RW(rate);
> +DEVICE_ATTR_RO(rate_available);
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

Need to check the return value of dev_set_name?

fan

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
> +
> +static void memory_scrub_control_exit(void)
> +{
> +	class_unregister(&scrub_class);
> +}
> +module_exit(memory_scrub_control_exit);
> diff --git a/include/linux/memory_scrub.h b/include/linux/memory_scrub.h
> new file mode 100755
> index 000000000000..f0e1657a5072
> --- /dev/null
> +++ b/include/linux/memory_scrub.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Memory scrub subsystem driver supports controlling
> + * the memory scrubbers in the system.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#ifndef __MEMORY_SCRUB_H
> +#define __MEMORY_SCRUB_H
> +
> +#include <linux/types.h>
> +
> +struct device;
> +
> +/**
> + * struct scrub_ops - scrub device operations (all elements optional)
> + * @get_enabled_bg: check if currently performing background scrub.
> + * @set_enabled_bg: start or stop a bg-scrub.
> + * @get_name: get the memory scrubber name.
> + * @rate_avail_range: retrieve limits on supported rates.
> + * @rate_read: read the scrub rate
> + * @rate_write: set the scrub rate
> + */
> +struct scrub_ops {
> +	int (*get_enabled_bg)(struct device *dev, bool *enable);
> +	int (*set_enabled_bg)(struct device *dev, bool enable);
> +	int (*get_name)(struct device *dev, char *buf);
> +	int (*rate_avail_range)(struct device *dev, u64 *min, u64 *max);
> +	int (*rate_read)(struct device *dev, u64 *rate);
> +	int (*rate_write)(struct device *dev, u64 rate);
> +};
> +
> +struct device *
> +devm_scrub_device_register(struct device *dev, void *drvdata,
> +			   const struct scrub_ops *ops);
> +#endif /* __MEMORY_SCRUB_H */
> -- 
> 2.34.1
> 

