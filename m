Return-Path: <linux-kernel+bounces-67906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED2E8572C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD741F23760
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781C9748D;
	Fri, 16 Feb 2024 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHK+jTrB"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065CF4E2;
	Fri, 16 Feb 2024 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044491; cv=none; b=CFdfFv0KL2n9I6Fem9IOZU78rImYkXnShAGPcsIEIcC6Ix5bXbWNPGqy67l2FI61kZXgqy3Hj3OXBTxcxj3ggRSA6TcoPYPkchoYnCEiqDTJP+Wj1vuqGgJdX2WlkO6N1pfeHGuZJI4+A3gNEvCEsl3IMvzGS9IaId5nFBYInqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044491; c=relaxed/simple;
	bh=sTzWFkwqRE0Ns+D43WT0XBj1vGM9x6rJ6NrQsi4pEIg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY9FivSsmTFKeqinl7VEjAhGUP6ovi9C23/27nk/Ih+qMPbNUnyz08kVCON/MnGAjqR5MZ+pxVrVmsrt+Y+nXp4q0JGUngkvnDTirbEcBO+P/n5K/sgyfjJpcqhOZkOjKWf2masffjQJunfqoRRt1QJMuWmxQBcT3E3qZe+/2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHK+jTrB; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-204235d0913so124420fac.1;
        Thu, 15 Feb 2024 16:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708044488; x=1708649288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odKlKurQmi864EQ3RlaudQFSdJJM8huA+WjbrbV5X8k=;
        b=nHK+jTrBkpy5Di037VfXx/kNXfxSBtlvnWa0HS5jxJgWnBCOYkL7Fy9Ticp3HRtRLL
         ZPoBTW0nGIACR/T2kkjjlOSSPQEPu3FMtJeGtU0Tc6bsdU58uTIymgiFDJywcIa1pwc7
         e53xfayqKT1LLLsp/oEC9U2dU5QVR/iobdUJcYv8uUYfCvF2yGzgQzEKi5mUVBRQ8ZfS
         oZBXlyfb8t4LDKP77gyS+GjVBaeUawD6ZD009+J2zOMxM/yfIN0DdPemIkyQR4LS/QL/
         TSOS+C/bx3RlGdScBsU6KVf8zlx0e3RVxB9iNyt7+kFgmMCT0xYoOZV7r1ftMak2b7/z
         HGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708044488; x=1708649288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odKlKurQmi864EQ3RlaudQFSdJJM8huA+WjbrbV5X8k=;
        b=MFEUAE106k90VbnitIB7Crj4zKHM1bbchdpLm0IUcVKzviJ2QGd+UeImJbofoQsMqc
         uQrlszw5A3/5Vn8gGYmFjBSPQDtbN1DupEi03U2B0yqYyWsHZhlM/1OcBS4fotVyL604
         TFWMdM4+dg5WpE6tzyM2+zwzBzkJBCh9DST9A5ABgjw7U0DP18GjMHhgad4n3kx4p0IR
         RS+B3/3IxNOKXUk5CucLlv1Nxgrrv3DicSMF+k4j+GDKruEQjrgJeRgzF+c7WR4fJe1i
         lgh8wfUdUbHDGAFelwiM4sHk1dU7C7+phX7EnG97IJ7PTvjjjQBZIlforgvy3CTVOvcj
         ZZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWd+EcYrDjAUXsAKKL6x0k/3jNycaqA28XjfCgp8hLA2etIZQPe/Km/xX18MhU2C3ad0VU3ELk7ULGH2CrNHnxBkyOuZRTBs65H7lfFFq9pKT85OVy6kczXdE0HlhI5UwgyCPnkZzMgPpIDf5BGLYJmBCpta4BzJb3k4m7mjTyqFPXXDPQ=
X-Gm-Message-State: AOJu0YwlkNJwb7VSgqty9J7xLH0APQ/HurNpNUqldLi8FrvxddIV0Jnq
	n2KxhUWyr6S6EkPtIia3pXO6iaAhVpWdDoFSGWOwoKvE8oLsAHwM
X-Google-Smtp-Source: AGHT+IFyvXdqWlNUzpfnTBbd5bU+mcNvEJ3YMBEZP6ojXh2NpCe0CNNlyfUaWIQYg6QDzVV5e3W0/g==
X-Received: by 2002:a05:6870:391f:b0:218:d739:31f0 with SMTP id b31-20020a056870391f00b00218d73931f0mr3885081oap.3.1708044488277;
        Thu, 15 Feb 2024 16:48:08 -0800 (PST)
Received: from debian ([2601:641:300:14de:9300:f75a:dfb6:7562])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b005dc89957e06sm2004991pgl.71.2024.02.15.16.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:48:07 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 15 Feb 2024 16:47:43 -0800
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org,
	lenb@kernel.org, naoya.horiguchi@nec.com, james.morse@arm.com,
	jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	mike.malvestuto@intel.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com, fan.ni@samsung.com
Subject: Re: [RFC PATCH v5 04/12] cxl/memscrub: Add CXL device patrol scrub
 control feature
Message-ID: <Zc6wr2mh7Ie1-QnC@debian>
References: <20240111131741.1356-1-shiju.jose@huawei.com>
 <20240111131741.1356-5-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111131741.1356-5-shiju.jose@huawei.com>

On Thu, Jan 11, 2024 at 09:17:33PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature. The device patrol scrub proactively locates and makes corrections
> to errors in regular cycle. The patrol scrub control allows the request to
> configure patrol scrub input configurations.
> 
> The patrol scrub control allows the requester to specify the number of
> hours for which the patrol scrub cycles must be completed, provided that
> the requested number is not less than the minimum number of hours for the
> patrol scrub cycle that the device is capable of. In addition, the patrol
> scrub controls allow the host to disable and enable the feature in case
> disabling of the feature is needed for other purposes such as
> performance-aware operations which require the background operations to be
> turned off.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/Kconfig         |  17 +++
>  drivers/cxl/core/Makefile   |   1 +
>  drivers/cxl/core/memscrub.c | 266 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h        |   8 ++
>  drivers/cxl/pci.c           |   5 +
>  5 files changed, 297 insertions(+)
>  create mode 100644 drivers/cxl/core/memscrub.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 8ea1d340e438..67d88f9bf52b 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -154,4 +154,21 @@ config CXL_PMU
>  	  monitoring units and provide standard perf based interfaces.
>  
>  	  If unsure say 'm'.
> +
> +config CXL_SCRUB
> +	bool "CXL: Memory scrub feature"
> +	depends on CXL_PCI
> +	depends on CXL_MEM
> +	help
> +	  The CXL memory scrub control is an optional feature allows host to
> +	  control the scrub configurations of CXL Type 3 devices, which
> +	  support patrol scrub and/or DDR5 ECS(Error Check Scrub).
> +
> +	  Say 'y/n' to enable/disable the CXL memory scrub driver that will
> +	  attach to CXL.mem devices for memory scrub control feature. See
> +	  sections 8.2.9.9.11.1 and 8.2.9.9.11.2 in the CXL 3.1 specification
> +	  for a detailed description of CXL memory scrub control features.
> +
> +	  If unsure say 'n'.
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 1f66b5d4d935..99e3202f868f 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -15,3 +15,4 @@ cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_SCRUB) += memscrub.o
> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
> new file mode 100644
> index 000000000000..e0d482b0bf3a
> --- /dev/null
> +++ b/drivers/cxl/core/memscrub.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * cxl_memscrub.c - CXL memory scrub driver
> + *
> + * Copyright (c) 2023 HiSilicon Limited.
> + *
> + *  - Provides functions to configure patrol scrub
> + *    feature of the CXL memory devices.
> + */
> +
> +#define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
> +
> +#include <cxlmem.h>
> +
> +/* CXL memory scrub feature common definitions */
> +#define CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH	128
> +
> +static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const uuid_t *feat_uuid,
> +					       struct cxl_mbox_supp_feat_entry *feat_entry_out)
> +{
> +	struct cxl_mbox_get_supp_feats_out *feats_out __free(kvfree) = NULL;
> +	struct cxl_mbox_supp_feat_entry *feat_entry;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_mbox_get_supp_feats_in pi;
> +	int feat_index, count;
> +	int nentries;
> +	int ret;
> +
> +	feat_index = 0;
> +	pi.count = sizeof(struct cxl_mbox_get_supp_feats_out) +
> +			  sizeof(struct cxl_mbox_supp_feat_entry);
> +	feats_out = kvmalloc(pi.count, GFP_KERNEL);
> +	if (!feats_out)
> +		return -ENOMEM;
> +
> +	do {
> +		pi.start_index = feat_index;
> +		memset(feats_out, 0, pi.count);
> +		ret = cxl_get_supported_features(mds, &pi, feats_out);
> +		if (ret)
> +			return ret;
> +
> +		nentries = feats_out->entries;
> +		if (!nentries)
> +			break;
> +
> +		/* Check CXL memdev supports the feature */
> +		feat_entry = (void *)feats_out->feat_entries;
> +		for (count = 0; count < nentries; count++, feat_entry++) {
> +			if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
> +				memcpy(feat_entry_out, feat_entry, sizeof(*feat_entry_out));
> +				return 0;
> +			}
> +		}
> +		feat_index += nentries;
> +	} while (nentries);
> +
> +	return -ENOTSUPP;
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
> + * @enable:     [IN] enable(1)/disable(0) patrol scrub.
> + * @scrub_cycle_changeable: [OUT] scrub cycle attribute of patrol scrub is changeable.
> + * @rate:       [IN] Requested patrol scrub cycle in hours.
> + *              [OUT] Current patrol scrub cycle in hours.
> + * @min_rate:[OUT] minimum patrol scrub cycle, in hours, supported.
> + * @rate_avail:[OUT] Supported patrol scrub cycle in hours.
> + */
> +struct cxl_memdev_ps_params {
> +	bool enable;
> +	bool scrub_cycle_changeable;
> +	u16 rate;
> +	u16 min_rate;
> +	char rate_avail[CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH];
> +};
> +
> +enum {
> +	CXL_MEMDEV_PS_PARAM_ENABLE = 0,
> +	CXL_MEMDEV_PS_PARAM_RATE,
> +};
> +
> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK	BIT(1)
> +#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
> +#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15, 8)
> +#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
> +
> +struct cxl_memdev_ps_feat_read_attrbs {
> +	u8 scrub_cycle_cap;
> +	__le16 scrub_cycle;
> +	u8 scrub_flags;
> +}  __packed;
> +
> +struct cxl_memdev_ps_set_feat_pi {
> +	struct cxl_mbox_set_feat_in pi;
> +	u8 scrub_cycle_hr;
> +	u8 scrub_flags;
> +}  __packed;
> +
> +static int cxl_mem_ps_get_attrbs(struct device *dev,
> +				 struct cxl_memdev_ps_params *params)
> +{
> +	struct cxl_memdev_ps_feat_read_attrbs *rd_attrbs __free(kvfree) = NULL;
> +	struct cxl_mbox_get_feat_in pi = {
> +		.uuid = cxl_patrol_scrub_uuid,
> +		.offset = 0,
> +		.count = sizeof(struct cxl_memdev_ps_feat_read_attrbs),
> +		.selection = CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +	};
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	int ret;
> +
> +	if (!mds)
> +		return -EFAULT;
> +
> +	rd_attrbs = kvmalloc(pi.count, GFP_KERNEL);
> +	if (!rd_attrbs)
> +		return -ENOMEM;
> +
> +	ret = cxl_get_feature(mds, &pi, rd_attrbs);
> +	if (ret) {
> +		params->enable = 0;
> +		params->rate = 0;
> +		snprintf(params->rate_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
> +			"Unavailable");
> +		return ret;
> +	}
> +	params->scrub_cycle_changeable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
> +						   rd_attrbs->scrub_cycle_cap);
> +	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +				   rd_attrbs->scrub_flags);
> +	params->rate = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +				 rd_attrbs->scrub_cycle);
> +	params->min_rate  = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
> +				      rd_attrbs->scrub_cycle);
> +	snprintf(params->rate_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
> +		 "Minimum scrub cycle = %d hour", params->min_rate);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused
> +cxl_mem_ps_set_attrbs(struct device *dev, struct cxl_memdev_ps_params *params,
> +		      u8 param_type)
> +{
> +	struct cxl_memdev_ps_set_feat_pi set_pi = {
> +		.pi.uuid = cxl_patrol_scrub_uuid,
> +		.pi.flags = CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
> +			    CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER,
> +		.pi.offset = 0,
> +		.pi.version = CXL_MEMDEV_PS_SET_FEAT_VERSION,
> +	};
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_memdev_ps_params rd_params;
> +	int ret;
> +
> +	if (!mds)
> +		return -EFAULT;
> +
> +	ret = cxl_mem_ps_get_attrbs(dev, &rd_params);
> +	if (ret) {
> +		dev_err(dev, "Get cxlmemdev patrol scrub params fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	switch (param_type) {
> +	case CXL_MEMDEV_PS_PARAM_ENABLE:
> +		set_pi.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						   params->enable);
> +		set_pi.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      rd_params.rate);
> +		break;
> +	case CXL_MEMDEV_PS_PARAM_RATE:
> +		if (params->rate < rd_params.min_rate) {
> +			dev_err(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
> +				params->rate);
> +			dev_err(dev, "Minimum supported CXL patrol scrub cycle in hour %d\n",
> +			       params->min_rate);
> +			return -EINVAL;
> +		}
> +		set_pi.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      params->rate);
> +		set_pi.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						   rd_params.enable);
> +		break;
> +	default:
> +		dev_err(dev, "Invalid CXL patrol scrub parameter to set\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = cxl_set_feature(mds, &set_pi, sizeof(set_pi));
> +	if (ret) {
> +		dev_err(dev, "CXL patrol scrub set feature fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Verify attribute set successfully */
> +	if (param_type == CXL_MEMDEV_PS_PARAM_RATE) {
> +		ret = cxl_mem_ps_get_attrbs(dev, &rd_params);
> +		if (ret) {
> +			dev_err(dev, "Get cxlmemdev patrol scrub params fail ret=%d\n", ret);
> +			return ret;
> +		}
> +		if (rd_params.rate != params->rate)
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> +	struct cxl_mbox_supp_feat_entry feat_entry;
> +	struct cxl_memdev_ps_params params;
> +	int ret;
> +
> +	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_patrol_scrub_uuid,
> +						  &feat_entry);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!(feat_entry.attrb_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +		return -ENOTSUPP;
> +
> +	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
> +	if (!cxl_ps_ctx)
> +		return -ENOMEM;
> +
> +	cxl_ps_ctx->get_feat_size = feat_entry.get_feat_size;
> +	cxl_ps_ctx->set_feat_size = feat_entry.set_feat_size;
> +	ret = cxl_mem_ps_get_attrbs(&cxlmd->dev, &params);
> +	if (ret) {
> +		dev_err(&cxlmd->dev, "Get CXL patrol scrub params fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +	cxl_ps_ctx->scrub_cycle_changeable =  params.scrub_cycle_changeable;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 46131dcd0900..25c46e72af16 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -983,6 +983,14 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
> +/* cxl memory scrub functions */
> +#ifdef CONFIG_CXL_SCRUB
> +int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
> +#else
> +static inline int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
> +{ return -ENOTSUPP; }
> +#endif
> +
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..acc337b8c365 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -881,6 +881,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * Initialize optional CXL scrub features
> +	 */
> +	cxl_mem_patrol_scrub_init(cxlmd);

It will return a value but never be captured. The return value may
indicate an error other than the fact it is optional, maybe we want to
capture it and handle it properly?

Fan


> +
>  	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
>  	if (rc)
>  		return rc;
> -- 
> 2.34.1
> 

