Return-Path: <linux-kernel+bounces-158405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11F08B1F57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70E92891A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA923763;
	Thu, 25 Apr 2024 10:38:20 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA961CFA0;
	Thu, 25 Apr 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041499; cv=none; b=dG7iGyFef+ALSGlNYA1NjEApn+N1wKB7su5OgTKpKgAs0eU3KIZXrggCkA51cIyBcr+h8D1J8TExRexoTWW0zTb2MyPJ5JbYwlGwEettIzY42R9BhFzYBYpeCRB66TB1F+w4BeuiGlRvT5a0WEi2h8eFm+YxKstucz8u2IEpumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041499; c=relaxed/simple;
	bh=6D6ozECtSRgaF2XlS0SJAVj1f0THyMZNTh28tUKJJP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dpFUtcHpY740g35UxJyhlC2rOyl+jUo4U4kAYt+J0pnBT+cfrkaFzDk1kg/ndvIiVhw9Sa1mpt0D+wxVwhpvICJnhE76hsPdP2dfhEXujFCoxDxQTBmaTiJJz5DRzNpleX+g5vcoEQSgDVP6aPGL5WD8yMTk+xhx/1zPr+BrMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQC1Z4FHgz6K5vB;
	Thu, 25 Apr 2024 18:35:46 +0800 (CST)
Received: from lhrpeml100006.china.huawei.com (unknown [7.191.160.224])
	by mail.maildlp.com (Postfix) with ESMTPS id A9EFD1400DB;
	Thu, 25 Apr 2024 18:38:11 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 11:38:11 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Thu, 25 Apr 2024 11:38:11 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Thread-Topic: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Thread-Index: AQHaknlLsB7DmyDvA0iAgKJhxeY8vLF31X0AgAD1x9A=
Date: Thu, 25 Apr 2024 10:38:10 +0000
Message-ID: <cbee9fa6a57245948c89c54f14ed3214@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-2-shiju.jose@huawei.com> <Zilq0ER7C8zeo3j8@debian>
In-Reply-To: <Zilq0ER7C8zeo3j8@debian>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: fan <nifan.cxl@gmail.com>
>Sent: 24 April 2024 21:26
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
>mm@kvack.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; david@redhat.com=
;
>Vilas.Sridharan@amd.com; leo.duran@amd.com; Yazen.Ghannam@amd.com;
>rientjes@google.com; jiaqiyan@google.com; tony.luck@intel.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com; rafael@kernel.org;
>lenb@kernel.org; naoya.horiguchi@nec.com; james.morse@arm.com;
>jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>mike.malvestuto@intel.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
>
>On Sat, Apr 20, 2024 at 12:47:10AM +0800, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add scrub subsystem supports configuring the memory scrubbers in the
>> system. The scrub subsystem provides the interface for registering the
>> scrub devices. The scrub control attributes are provided to the user
>> in /sys/class/ras/rasX/scrub
>>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  .../ABI/testing/sysfs-class-scrub-configure   |  47 +++
>>  drivers/ras/Kconfig                           |   7 +
>>  drivers/ras/Makefile                          |   1 +
>>  drivers/ras/memory_scrub.c                    | 271 ++++++++++++++++++
>>  include/linux/memory_scrub.h                  |  37 +++
>>  5 files changed, 363 insertions(+)
>>  create mode 100644
>> Documentation/ABI/testing/sysfs-class-scrub-configure
>>  create mode 100755 drivers/ras/memory_scrub.c  create mode 100755
>> include/linux/memory_scrub.h
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure
>> b/Documentation/ABI/testing/sysfs-class-scrub-configure
>> new file mode 100644
>> index 000000000000..3ed77dbb00ad
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
>> @@ -0,0 +1,47 @@
>> +What:		/sys/class/ras/
>> +Date:		March 2024
>> +KernelVersion:	6.9
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:
>> +		The ras/ class subdirectory belongs to the
>> +		common ras features such as scrub subsystem.
>> +
>> +What:		/sys/class/ras/rasX/scrub/
>> +Date:		March 2024
>> +KernelVersion:	6.9
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:
>> +		The /sys/class/ras/ras{0,1,2,3,...}/scrub directories
>> +		correspond to each scrub device registered with the
>> +		scrub subsystem.
>> +
>> +What:		/sys/class/ras/rasX/scrub/name
>> +Date:		March 2024
>> +KernelVersion:	6.9
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:
>> +		(RO) name of the memory scrubber
>> +
>> +What:		/sys/class/ras/rasX/scrub/enable_background
>> +Date:		March 2024
>> +KernelVersion:	6.9
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:
>> +		(RW) Enable/Disable background(patrol) scrubbing if supported.
>> +
>> +What:		/sys/class/ras/rasX/scrub/rate_available
>> +Date:		March 2024
>> +KernelVersion:	6.9
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:
>> +		(RO) Supported range for the scrub rate by the scrubber.
>> +		The scrub rate represents in hours.
>> +
>> +What:		/sys/class/ras/rasX/scrub/rate
>> +Date:		March 2024
>> +KernelVersion:	6.9
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:
>> +		(RW) The scrub rate specified and it must be with in the
>> +		supported range by the scrubber.
>> +		The scrub rate represents in hours.
>> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig index
>> fc4f4bb94a4c..181701479564 100644
>> --- a/drivers/ras/Kconfig
>> +++ b/drivers/ras/Kconfig
>> @@ -46,4 +46,11 @@ config RAS_FMPM
>>  	  Memory will be retired during boot time and run time depending on
>>  	  platform-specific policies.
>>
>> +config SCRUB
>> +	tristate "Memory scrub driver"
>> +	help
>> +	  This option selects the memory scrub subsystem, supports
>> +	  configuring the parameters of underlying scrubbers in the
>> +	  system for the DRAM memories.
>> +
>>  endif
>> diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile index
>> 11f95d59d397..89bcf0d84355 100644
>> --- a/drivers/ras/Makefile
>> +++ b/drivers/ras/Makefile
>> @@ -2,6 +2,7 @@
>>  obj-$(CONFIG_RAS)	+=3D ras.o
>>  obj-$(CONFIG_DEBUG_FS)	+=3D debugfs.o
>>  obj-$(CONFIG_RAS_CEC)	+=3D cec.o
>> +obj-$(CONFIG_SCRUB)	+=3D memory_scrub.o
>>
>>  obj-$(CONFIG_RAS_FMPM)	+=3D amd/fmpm.o
>>  obj-y			+=3D amd/atl/
>> diff --git a/drivers/ras/memory_scrub.c b/drivers/ras/memory_scrub.c
>> new file mode 100755 index 000000000000..7e995380ec3a
>> --- /dev/null
>> +++ b/drivers/ras/memory_scrub.c
>> @@ -0,0 +1,271 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Memory scrub subsystem supports configuring the registered
>> + * memory scrubbers.
>> + *
>> + * Copyright (c) 2024 HiSilicon Limited.
>> + */
>> +
>> +#define pr_fmt(fmt)     "MEM SCRUB: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/kfifo.h>
>> +#include <linux/memory_scrub.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +
>> +/* memory scrubber config definitions */ #define SCRUB_ID_PREFIX
>> +"ras"
>> +#define SCRUB_ID_FORMAT SCRUB_ID_PREFIX "%d"
>> +
>> +static DEFINE_IDA(scrub_ida);
>> +
>> +struct scrub_device {
>> +	int id;
>> +	struct device dev;
>> +	const struct scrub_ops *ops;
>> +};
>> +
>> +#define to_scrub_device(d) container_of(d, struct scrub_device, dev)
>> +static ssize_t enable_background_store(struct device *dev,
>> +				       struct device_attribute *attr,
>> +				       const char *buf, size_t len) {
>> +	struct scrub_device *scrub_dev =3D to_scrub_device(dev);
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret =3D kstrtobool(buf, &enable);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D scrub_dev->ops->set_enabled_bg(dev, enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t enable_background_show(struct device *dev,
>> +				      struct device_attribute *attr, char *buf) {
>> +	struct scrub_device *scrub_dev =3D to_scrub_device(dev);
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret =3D scrub_dev->ops->get_enabled_bg(dev, &enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%d\n", enable); }
>> +
>> +static ssize_t name_show(struct device *dev,
>> +			 struct device_attribute *attr, char *buf) {
>> +	struct scrub_device *scrub_dev =3D to_scrub_device(dev);
>> +	int ret;
>> +
>> +	ret =3D scrub_dev->ops->get_name(dev, buf);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return strlen(buf);
>> +}
>> +
>> +static ssize_t rate_show(struct device *dev, struct device_attribute *a=
ttr,
>> +			 char *buf)
>> +{
>> +	struct scrub_device *scrub_dev =3D to_scrub_device(dev);
>> +	u64 val;
>> +	int ret;
>> +
>> +	ret =3D scrub_dev->ops->rate_read(dev, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "0x%llx\n", val); }
>> +
>> +static ssize_t rate_store(struct device *dev, struct device_attribute *=
attr,
>> +			  const char *buf, size_t len)
>> +{
>> +	struct scrub_device *scrub_dev =3D to_scrub_device(dev);
>> +	long val;
>> +	int ret;
>> +
>> +	ret =3D kstrtol(buf, 10, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D scrub_dev->ops->rate_write(dev, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t rate_available_show(struct device *dev,
>> +				   struct device_attribute *attr,
>> +				   char *buf)
>> +{
>> +	struct scrub_device *scrub_dev =3D to_scrub_device(dev);
>> +	u64 min_sr, max_sr;
>> +	int ret;
>> +
>> +	ret =3D scrub_dev->ops->rate_avail_range(dev, &min_sr, &max_sr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "0x%llx-0x%llx\n", min_sr, max_sr); }
>> +
>> +DEVICE_ATTR_RW(enable_background);
>> +DEVICE_ATTR_RO(name);
>> +DEVICE_ATTR_RW(rate);
>> +DEVICE_ATTR_RO(rate_available);
>> +
>> +static struct attribute *scrub_attrs[] =3D {
>> +	&dev_attr_enable_background.attr,
>> +	&dev_attr_name.attr,
>> +	&dev_attr_rate.attr,
>> +	&dev_attr_rate_available.attr,
>> +	NULL
>> +};
>> +
>> +static umode_t scrub_attr_visible(struct kobject *kobj,
>> +				  struct attribute *a, int attr_id) {
>> +	struct device *dev =3D kobj_to_dev(kobj);
>> +	struct scrub_device *scrub_dev =3D to_scrub_device(dev);
>> +	const struct scrub_ops *ops =3D scrub_dev->ops;
>> +
>> +	if (a =3D=3D &dev_attr_enable_background.attr) {
>> +		if (ops->set_enabled_bg && ops->get_enabled_bg)
>> +			return a->mode;
>> +		if (ops->get_enabled_bg)
>> +			return 0444;
>> +		return 0;
>> +	}
>> +	if (a =3D=3D &dev_attr_name.attr)
>> +		return ops->get_name ? a->mode : 0;
>> +	if (a =3D=3D &dev_attr_rate_available.attr)
>> +		return ops->rate_avail_range ? a->mode : 0;
>> +	if (a =3D=3D &dev_attr_rate.attr) { /* Write only makes little sense *=
/
>> +		if (ops->rate_read && ops->rate_write)
>> +			return a->mode;
>> +		if (ops->rate_read)
>> +			return 0444;
>> +		return 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct attribute_group scrub_attr_group =3D {
>> +	.name		=3D "scrub",
>> +	.attrs		=3D scrub_attrs,
>> +	.is_visible	=3D scrub_attr_visible,
>> +};
>> +
>> +static const struct attribute_group *scrub_attr_groups[] =3D {
>> +	&scrub_attr_group,
>> +	NULL
>> +};
>> +
>> +static void scrub_dev_release(struct device *dev) {
>> +	struct scrub_device *scrub_dev =3D to_scrub_device(dev);
>> +
>> +	ida_free(&scrub_ida, scrub_dev->id);
>> +	kfree(scrub_dev);
>> +}
>> +
>> +static struct class scrub_class =3D {
>> +	.name =3D "ras",
>> +	.dev_groups =3D scrub_attr_groups,
>> +	.dev_release =3D scrub_dev_release,
>> +};
>> +
>> +static struct device *
>> +scrub_device_register(struct device *parent, void *drvdata,
>> +		      const struct scrub_ops *ops)
>> +{
>> +	struct scrub_device *scrub_dev;
>> +	struct device *hdev;
>> +	int err;
>> +
>> +	scrub_dev =3D kzalloc(sizeof(*scrub_dev), GFP_KERNEL);
>> +	if (!scrub_dev)
>> +		return ERR_PTR(-ENOMEM);
>> +	hdev =3D &scrub_dev->dev;
>> +
>> +	scrub_dev->id =3D ida_alloc(&scrub_ida, GFP_KERNEL);
>> +	if (scrub_dev->id < 0) {
>> +		kfree(scrub_dev);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	scrub_dev->ops =3D ops;
>> +	hdev->class =3D &scrub_class;
>> +	hdev->parent =3D parent;
>> +	dev_set_drvdata(hdev, drvdata);
>> +	dev_set_name(hdev, SCRUB_ID_FORMAT, scrub_dev->id);
>
>Need to check the return value of dev_set_name?
Will do, though checking return value of dev_set_name() is not common in th=
e kernel.

>
>fan
>
>> +	err =3D device_register(hdev);
>> +	if (err) {

Thanks,
Shiju

