Return-Path: <linux-kernel+bounces-160787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD64A8B42E4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DFD281109
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1773D0C2;
	Fri, 26 Apr 2024 23:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuyFonQx"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDAE3FB89;
	Fri, 26 Apr 2024 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175814; cv=none; b=E+qSV42BFEtI5v9efzn35jC2yoPvBmJGy43FFZXuyik0K4KQgBi5afneFFIwg9q0boP5ylNspRYUo7tyNNInGqNTOWqBENte82N5X9E0wYtQuZtmqugsAwJcEBNiAKCtOTZT+9FC7cCHhSOVz4826lc3x210wJtrvPpMFNZCWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175814; c=relaxed/simple;
	bh=hj5AA7HeXQoTedhoGEKLa865w8vcsTapmZBY+hDU/vw=;
	h=From:Date:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1q59rimkUY/UBPC9x91X5bonBcTcK6fMjaxfXatVAfzXv90s7oZk+iYKgSDYK0Df6YhjCX1gwqICpSNvndrbhIexeQZ1INfkVBJXuaVHD7kSNmYqItenxKOsaIG5nv2NUG4jCEDblEnqNFwvrXtesrlPtiCKAu0Mip/vWG5cLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuyFonQx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6effe9c852eso2488463b3a.3;
        Fri, 26 Apr 2024 16:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714175812; x=1714780612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAcldRD49exVnUdGEuC783CMnIp3NUotVJoupv9iIYI=;
        b=SuyFonQx/HaZSzDkfinAw6L53pttMAL1S3bf8Rz6gceRRKF3vB60wG0BnnDGk8tvI/
         UIFJQmJDc8Zzm36Xs6thDUbUJbVq/9aW0fk/ncoIHTRutGAKn7pQKgw05xDaDWYw4PP9
         ZH7yJ4hYTV43HostaR1uZe4G0x+jHUxXoCTbZAkghQgEuPcrd1eAC62Gznj0ZF/qeQqa
         hCuzyQh8l0/KXcS3aoFjFD+OvQzWXfLOygaKStLVT/I3XslWsqqj7CxvXBRoXQgRwnRP
         ZlG7g7TOUedesL4kd03ssmu+jvUksXl25wrw+5y2nWFdTfEGbTpkno+xqvC1soU+ImKT
         9A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714175812; x=1714780612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAcldRD49exVnUdGEuC783CMnIp3NUotVJoupv9iIYI=;
        b=bZns1xYgkudAmnk4PNDa4QTDNGae1YsRX7AM83gGqQTnrLoPlExAN6Fi6RPaeSHZhV
         BmVRmDSAcRrePHeHBQ2UBRf4NGqYoNgLDik68ppDe7Bb072kQa3OpIkrk1139CvQ0S57
         73o7HOoRVt9unS7W8XVS9zvKqluvIRrBNHlfzHcFOY4GHT535Fp8yL2mSPIThvCb6xad
         9Y0FJsJ38RqTAhjMOiug4P/n3GvB17qREW6J0+sR3S5UBgc6pDXxSAwH/t7VU5b/J7Cx
         k+iotOpuNp1WI0cU0gsB6U2uS+t1r+HpquPUgYm8HAAPwzpQap3XXWBm1spu8TDRiqeR
         Tzmw==
X-Forwarded-Encrypted: i=1; AJvYcCV774A5rmhrRo6hpALXtBIB9KddhlEZisy+ipaxn6fzubsFGAPcrZWhBFlvs6+UsoneKKqKBnlkgYmfw6t3F+sSH8XMKQI/zoKYOsfx+6Bvjzda61zkZUkn3kClBACz5eU4Mw9TjrI7Gr6VSSgYmgLY7ODLzbCr44zf9PFci3DZCsDUyc4=
X-Gm-Message-State: AOJu0Yw3/8EqLAZuYW5JYtTLx/z/kyF0MXloss6eqEFQGQ25Xe5aYdz3
	5KlrN3POjoC24dBT0peQl19i90fTotrV5pNjLmUAFcRmnD7GP8dc9XYJdQ==
X-Google-Smtp-Source: AGHT+IGjoC+qdhChPjRTonGyec020oo04Av8Y+SjZ600G+CuIbMRoChrNWryFEGU1/BBhUZ3sMKAkw==
X-Received: by 2002:a05:6a21:99a6:b0:1a7:75ee:6742 with SMTP id ve38-20020a056a2199a600b001a775ee6742mr5414816pzb.2.1714175811642;
        Fri, 26 Apr 2024 16:56:51 -0700 (PDT)
Received: from debian ([2601:641:300:14de:3ab3:2758:b06d:d8f6])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090a778c00b002ab534866dcsm16476487pjk.26.2024.04.26.16.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:56:51 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 26 Apr 2024 16:56:30 -0700
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
Subject: Re: [RFC PATCH v8 05/10] cxl/memscrub: Add CXL device patrol scrub
 control feature
Message-ID: <Ziw_Ll3vMBK1zNw4@debian>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-6-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419164720.1765-6-shiju.jose@huawei.com>

On Sat, Apr 20, 2024 at 12:47:14AM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature. The device patrol scrub proactively locates and makes corrections
> to errors in regular cycle.
> 
> Allow specifying the number of hours within which the patrol scrub must be
> completed, subject to minimum and maximum limits reported by the device.
> Also allow disabling scrub allowing trade-off error rates against
> performance.
> 
> Register with scrub subsystem to provide scrub control attributes to the
> user.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/scrub/scrub-configure.rst |  52 ++++
>  drivers/cxl/Kconfig                     |  19 ++
>  drivers/cxl/core/Makefile               |   1 +
>  drivers/cxl/core/memscrub.c             | 314 ++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |   8 +
>  drivers/cxl/mem.c                       |   6 +
>  6 files changed, 400 insertions(+)
>  create mode 100644 Documentation/scrub/scrub-configure.rst
>  create mode 100644 drivers/cxl/core/memscrub.c
> 
> diff --git a/Documentation/scrub/scrub-configure.rst b/Documentation/scrub/scrub-configure.rst
> new file mode 100644
> index 000000000000..2275366b60d3
> --- /dev/null
> +++ b/Documentation/scrub/scrub-configure.rst
> @@ -0,0 +1,52 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +Scrub subsystem
> +================
> +
> +Copyright (c) 2024 HiSilicon Limited.
> +
> +:Author:   Shiju Jose <shiju.jose@huawei.com>
> +:License:  The GNU Free Documentation License, Version 1.2
> +          (dual licensed under the GPL v2)
> +:Original Reviewers:
> +
> +- Written for: 6.9
> +- Updated for:
> +
> +Introduction
> +------------
> +The scrub subsystem provides interface for controlling attributes
> +of memory scrubbers in the system. The scrub device drivers
> +in the system register with the scrub subsystem.The scrub subsystem
> +driver exposes the scrub controls to the user in the sysfs.
> +
> +The File System
> +---------------
> +
> +The control attributes of the registered scrubbers could be
> +accessed in the /sys/class/ras/rasX/scrub/
> +
> +sysfs
> +-----
> +
> +Sysfs files are documented in
> +`Documentation/ABI/testing/sysfs-class-scrub-configure`.
> +
> +Example
> +-------
> +
> +The usage takes the form shown in this example::
> +
> +1. CXL patrol scrubber
> +    # cat /sys/class/ras/ras0/scrub/rate_available
> +    # 0x1-0xff
> +    # echo 30 > /sys/class/ras/ras0/scrub/rate
> +    # cat /sys/class/ras/ras0/scrub/rate
> +    # 0x1e
> +    # echo 1 > /sys/class/ras/ras0/scrub/enable_background
> +    # cat /sys/class/ras/ras0/scrub/enable_background
> +    # 1
> +    # echo 0 > /sys/class/ras/ras0/scrub/enable_background
> +    # cat /sys/class/ras/ras0/scrub/enable_background
> +    # 0
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 5f3c9c5529b9..3621b9f27e80 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -144,4 +144,23 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> +config CXL_SCRUB
> +	bool "CXL: Memory scrub feature"
> +	depends on CXL_PCI
> +	depends on CXL_MEM
> +	depends on SCRUB
> +	help
> +	  The CXL memory scrub control is an optional feature allows host to
> +	  control the scrub configurations of CXL Type 3 devices, which
> +	  supports patrol scrubbing.
> +
> +	  Registers with the scrub subsystem to provide control attributes
> +	  of CXL memory device scrubber to the user.
> +	  Provides interface functions to support configuring the CXL memory
> +	  device patrol scrubber.
> +
> +	  Say 'y/n' to enable/disable control of memory scrub parameters for
> +	  CXL.mem devices. See section 8.2.9.9.11.1 of CXL 3.1 specification
> +	  for detailed description of CXL memory patrol scrub control feature.
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..e0fc814c3983 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -16,3 +16,4 @@ cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_SCRUB) += memscrub.o
> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
> new file mode 100644
> index 000000000000..a50f6e384394
> --- /dev/null
> +++ b/drivers/cxl/core/memscrub.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * CXL memory scrub driver.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + *
> + *  - Provides functions to configure patrol scrub feature of the
> + *    CXL memory devices.
> + *  - Registers with the scrub subsystem driver to expose the sysfs attributes
> + *    to the user for configuring the CXL memory patrol scrub feature.
> + */
> +
> +#define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
> +
> +#include <cxlmem.h>
> +#include <linux/cleanup.h>
> +#include <linux/limits.h>
> +#include <linux/memory_scrub.h>
> +
> +static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const uuid_t *feat_uuid,
> +					       struct cxl_mbox_supp_feat_entry *feat_entry_out)
> +{
> +	struct cxl_mbox_supp_feat_entry *feat_entry;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	int feat_index, feats_out_size;
> +	int nentries, count;
> +	int ret;
> +
> +	feat_index = 0;
> +	feats_out_size = sizeof(struct cxl_mbox_get_supp_feats_out) +
> +			  sizeof(struct cxl_mbox_supp_feat_entry);
> +	struct cxl_mbox_get_supp_feats_out *feats_out __free(kfree) =
> +					kmalloc(feats_out_size, GFP_KERNEL);
> +	if (!feats_out)
> +		return -ENOMEM;
> +
> +	while (true) {
> +		memset(feats_out, 0, feats_out_size);
> +		ret = cxl_get_supported_features(mds, feats_out_size,
> +						 feat_index, feats_out);
> +		if (ret)
> +			return ret;
> +
> +		nentries = feats_out->nr_entries;
> +		if (!nentries)
> +			return -EOPNOTSUPP;
> +
> +		/* Check CXL memdev supports the feature */
> +		feat_entry = feats_out->feat_entries;
> +		for (count = 0; count < nentries; count++, feat_entry++) {
> +			if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
> +				memcpy(feat_entry_out, feat_entry,
> +				       sizeof(*feat_entry_out));
> +				return 0;
> +			}
> +		}
> +		feat_index += nentries;
> +	}
> +}
> +
> +/* CXL memory patrol scrub control definitions */
> +#define CXL_MEMDEV_PS_GET_FEAT_VERSION	0x01
> +#define CXL_MEMDEV_PS_SET_FEAT_VERSION	0x01
> +
> +static const uuid_t cxl_patrol_scrub_uuid =
> +	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,     \
> +		  0x06, 0xdb, 0x8a);
> +
> +/* CXL memory patrol scrub control functions */
> +struct cxl_patrol_scrub_context {
> +	struct device *dev;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +	bool scrub_cycle_changeable;
> +};
> +
> +/**
> + * struct cxl_memdev_ps_params - CXL memory patrol scrub parameter data structure.
> + * @enable:     [IN & OUT] enable(1)/disable(0) patrol scrub.
> + * @scrub_cycle_changeable: [OUT] scrub cycle attribute of patrol scrub is changeable.
> + * @rate:       [IN] Requested patrol scrub cycle in hours.
> + *              [OUT] Current patrol scrub cycle in hours.
> + * @min_rate:[OUT] minimum patrol scrub cycle, in hours, supported.
> + */
> +struct cxl_memdev_ps_params {
> +	bool enable;
> +	bool scrub_cycle_changeable;
> +	u16 rate;
> +	u16 min_rate;
> +};
> +
> +enum cxl_scrub_param {
> +	cxl_ps_param_enable,
> +	cxl_ps_param_rate,
> +};
> +
> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK	BIT(1)
> +#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
> +#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15, 8)
> +#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
> +
> +struct cxl_memdev_ps_rd_attrs {
> +	u8 scrub_cycle_cap;
> +	__le16 scrub_cycle;
> +	u8 scrub_flags;
> +}  __packed;
> +
> +struct cxl_memdev_ps_wr_attrs {
> +	u8 scrub_cycle_hr;
> +	u8 scrub_flags;
> +}  __packed;
> +

In this patch, generally "rate" is used for cycle in hour, here we use
scrub_cycle_hr. I am not sure whether "rate" is the proper term for the
purpose, "interval" or "cycle" seems more straightforward for me.
But someone else may have a different thought about it.

> +static int cxl_mem_ps_get_attrs(struct device *dev,
> +				struct cxl_memdev_ps_params *params)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	size_t rd_data_size = sizeof(struct cxl_memdev_ps_rd_attrs);
> +	size_t data_size;
> +
> +	if (!mds)
> +		return -EFAULT;
> +
> +	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =
> +						kmalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(mds, cxl_patrol_scrub_uuid, rd_attrs,
> +				    rd_data_size, rd_data_size,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE);
> +	if (!data_size)
> +		return -EIO;
> +
> +	params->scrub_cycle_changeable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
> +						   rd_attrs->scrub_cycle_cap);
> +	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +				   rd_attrs->scrub_flags);
> +	params->rate = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +				 rd_attrs->scrub_cycle);
> +	params->min_rate = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
> +				      rd_attrs->scrub_cycle);
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ps_set_attrs(struct device *dev, struct cxl_memdev_ps_params *params,
> +				enum cxl_scrub_param param_type)
> +{
> +	struct cxl_memdev_ps_wr_attrs wr_attrs;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_memdev_ps_params rd_params;
> +	int ret;
> +
> +	ret = cxl_mem_ps_get_attrs(dev, &rd_params);
> +	if (ret) {
> +		dev_err(dev, "Get cxlmemdev patrol scrub params failed ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	switch (param_type) {
> +	case cxl_ps_param_enable:
> +		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						   params->enable);
> +		wr_attrs.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      rd_params.rate);
> +		break;
> +	case cxl_ps_param_rate:
> +		if (params->rate < rd_params.min_rate) {
> +			dev_err(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
> +				params->rate);
> +			dev_err(dev, "Minimum supported CXL patrol scrub cycle in hour %d\n",
> +			       params->min_rate);
> +			return -EINVAL;
> +		}
> +		wr_attrs.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						     params->rate);
> +		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						  rd_params.enable);
> +		break;
> +	}
> +
> +	ret = cxl_set_feature(mds, cxl_patrol_scrub_uuid, CXL_MEMDEV_PS_SET_FEAT_VERSION,
> +			      &wr_attrs, sizeof(wr_attrs),
> +			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET);
> +	if (ret)
> +		dev_err(dev, "CXL patrol scrub set feature failed ret=%d\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +static int cxl_patrol_scrub_get_enabled_bg(struct device *dev, bool *enabled)
> +{
> +	struct cxl_memdev_ps_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ps_get_attrs(dev->parent, &params);
> +	if (ret)
> +		return ret;
> +
> +	*enabled = params.enable;
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_set_enabled_bg(struct device *dev, bool enable)
> +{
> +	struct cxl_memdev_ps_params params = {
> +		.enable = enable,
> +	};
> +
> +	return cxl_mem_ps_set_attrs(dev->parent, &params, cxl_ps_param_enable);
> +}
> +
> +static int cxl_patrol_scrub_get_name(struct device *dev, char *name)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
> +
> +	return sysfs_emit(name, "%s_%s\n", "cxl_patrol_scrub",
> +			  dev_name(&cxlmd->dev));
> +}
> +
> +static int cxl_patrol_scrub_write_rate(struct device *dev, u64 rate)
> +{
> +	struct cxl_memdev_ps_params params = {
> +		.rate = rate,
> +	};
> +
> +	return cxl_mem_ps_set_attrs(dev->parent, &params, cxl_ps_param_rate);
> +}
> +
> +static int cxl_patrol_scrub_read_rate(struct device *dev, u64 *rate)
> +{
> +	struct cxl_memdev_ps_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ps_get_attrs(dev->parent, &params);
> +	if (ret)
> +		return ret;
> +
> +	*rate = params.rate;
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_read_rate_avail(struct device *dev, u64 *min, u64 *max)
> +{
> +	struct cxl_memdev_ps_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ps_get_attrs(dev->parent, &params);
> +	if (ret)
> +		return ret;
> +	*min = params.min_rate;
> +	*max = U8_MAX; /* Max set by register size */
> +
> +	return 0;
> +}
> +
> +static const struct scrub_ops cxl_ps_scrub_ops = {
> +	.get_enabled_bg = cxl_patrol_scrub_get_enabled_bg,
> +	.set_enabled_bg = cxl_patrol_scrub_set_enabled_bg,
> +	.get_name = cxl_patrol_scrub_get_name,
> +	.rate_read = cxl_patrol_scrub_read_rate,
> +	.rate_write = cxl_patrol_scrub_write_rate,
> +	.rate_avail_range = cxl_patrol_scrub_read_rate_avail,
> +};
> +
> +int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> +	struct cxl_mbox_supp_feat_entry feat_entry;
> +	struct cxl_memdev_ps_params params;
> +	struct device *cxl_scrub_dev;
> +	int ret;
> +
> +	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_patrol_scrub_uuid,
> +						  &feat_entry);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +		return -EOPNOTSUPP;
> +
> +	ret = cxl_mem_ps_get_attrs(&cxlmd->dev, &params);
> +	if (ret)
> +		return dev_err_probe(&cxlmd->dev, ret,
> +				     "Get CXL patrol scrub params failed\n");
> +
> +	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
> +	if (!cxl_ps_ctx)
> +		return -ENOMEM;
> +
> +	*cxl_ps_ctx = (struct cxl_patrol_scrub_context) {
> +		.get_feat_size = feat_entry.get_size,
> +		.set_feat_size = feat_entry.set_size,
> +		.scrub_cycle_changeable =  params.scrub_cycle_changeable,
> +	};
> +
> +	cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, cxl_ps_ctx,
> +						   &cxl_ps_scrub_ops);
> +	if (IS_ERR(cxl_scrub_dev))
> +		return PTR_ERR(cxl_scrub_dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 1c50a3e2eced..f95e39febd73 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -956,6 +956,14 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
> +/* cxl memory scrub functions */
> +#ifdef CONFIG_CXL_SCRUB
> +int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
> +#else
> +static inline int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
> +{ return 0; }
> +#endif
> +
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 0c79d9ce877c..399e43463626 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -117,6 +117,12 @@ static int cxl_mem_probe(struct device *dev)
>  	if (!cxlds->media_ready)
>  		return -EBUSY;
>  
> +	rc = cxl_mem_patrol_scrub_init(cxlmd);
> +	if (rc) {
> +		dev_dbg(&cxlmd->dev, "CXL patrol scrub init failed\n");
> +		return rc;
> +	}

If the device does not support memory patrol scrub feature, the above
function will return -EOPNOTSUPP. Since the feature is optional, should we
just warn it and let it go through?

Fan
> +
>  	/*
>  	 * Someone is trying to reattach this device after it lost its port
>  	 * connection (an endpoint port previously registered by this memdev was
> -- 
> 2.34.1
> 

