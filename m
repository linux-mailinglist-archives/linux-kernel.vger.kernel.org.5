Return-Path: <linux-kernel+bounces-68564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DDD857C78
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576D81F2460C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068278B5F;
	Fri, 16 Feb 2024 12:23:06 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08EB2CCB4;
	Fri, 16 Feb 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086185; cv=none; b=LTcSpRaNiAWQgAtZgwCk1P1Q3LObELccs1DMniFtrJMnEuJDfgqEW1XmYh3VGpHmXs+AbXV3JaFs9lBRdIcPAetqB9OCZ4wXX+o3sxLZYLraDrxkh6FVUAuy4EyxcqQM6ZtFLochU+KOOZce6SEm+9NxyoyvRkbeaGgTYxMzKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086185; c=relaxed/simple;
	bh=yrmZL16MUTDVxOrX5KQ5FuNJRvrfvqAbxjfIN/1TYBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yi1jFU7x8qpjzwcr/t+d6liJJWVm8DNwv79YU6vcQ7AWsPhfIBVLOHZ2JpRai4w+FhLzy8fNjeMxFyba54la4z3ZCeq5s6qSEe+x8gHIpvI7jHnAkGzfj25LTzWD0pU45JFAkMQOwPA4mVOxDy+gO06HTA+TCSCtCLsjUl8tF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbrZj62Bkz67kb7;
	Fri, 16 Feb 2024 20:19:09 +0800 (CST)
Received: from lhrpeml100004.china.huawei.com (unknown [7.191.162.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CBD3140D26;
	Fri, 16 Feb 2024 20:22:57 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 12:22:56 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 16 Feb 2024 12:22:56 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: RE: [RFC PATCH v5 04/12] cxl/memscrub: Add CXL device patrol scrub
 control feature
Thread-Topic: [RFC PATCH v5 04/12] cxl/memscrub: Add CXL device patrol scrub
 control feature
Thread-Index: AQHaRJCcDuRPW75t/0eXGLSLJBtKubEMWl6AgAC/IGA=
Date: Fri, 16 Feb 2024 12:22:56 +0000
Message-ID: <86ac936adec1415193ce6cd352c19d71@huawei.com>
References: <20240111131741.1356-1-shiju.jose@huawei.com>
 <20240111131741.1356-5-shiju.jose@huawei.com> <Zc6wr2mh7Ie1-QnC@debian>
In-Reply-To: <Zc6wr2mh7Ie1-QnC@debian>
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

Hi Fan,

Thanks for the feedback.

>-----Original Message-----
>From: fan <nifan.cxl@gmail.com>
>Sent: 16 February 2024 00:48
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
>mm@kvack.org; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dan.j.williams@intel.com; linux-edac@vger.kernel.org; linux-
>kernel@vger.kernel.org; david@redhat.com; Vilas.Sridharan@amd.com;
>leo.duran@amd.com; Yazen.Ghannam@amd.com; rientjes@google.com;
>jiaqiyan@google.com; tony.luck@intel.com; Jon.Grimm@amd.com;
>dave.hansen@linux.intel.com; rafael@kernel.org; lenb@kernel.org;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; mike.malvestuto@intel.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>=
;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>; fan.ni@samsung.com
>Subject: Re: [RFC PATCH v5 04/12] cxl/memscrub: Add CXL device patrol scru=
b
>control feature
>
>On Thu, Jan 11, 2024 at 09:17:33PM +0800, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
>> control feature. The device patrol scrub proactively locates and makes
>> corrections to errors in regular cycle. The patrol scrub control
>> allows the request to configure patrol scrub input configurations.
>>
>> The patrol scrub control allows the requester to specify the number of
>> hours for which the patrol scrub cycles must be completed, provided
>> that the requested number is not less than the minimum number of hours
>> for the patrol scrub cycle that the device is capable of. In addition,
>> the patrol scrub controls allow the host to disable and enable the
>> feature in case disabling of the feature is needed for other purposes
>> such as performance-aware operations which require the background
>> operations to be turned off.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/Kconfig         |  17 +++
>>  drivers/cxl/core/Makefile   |   1 +
>>  drivers/cxl/core/memscrub.c | 266
>++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h        |   8 ++
>>  drivers/cxl/pci.c           |   5 +
>>  5 files changed, 297 insertions(+)
>>  create mode 100644 drivers/cxl/core/memscrub.c
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig index
>> 8ea1d340e438..67d88f9bf52b 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -154,4 +154,21 @@ config CXL_PMU
>>  	  monitoring units and provide standard perf based interfaces.
>>
>>  	  If unsure say 'm'.
>> +
>> +config CXL_SCRUB
>> +	bool "CXL: Memory scrub feature"
>> +	depends on CXL_PCI
>> +	depends on CXL_MEM
>> +	help
>> +	  The CXL memory scrub control is an optional feature allows host to
>> +	  control the scrub configurations of CXL Type 3 devices, which
>> +	  support patrol scrub and/or DDR5 ECS(Error Check Scrub).
>> +
>> +	  Say 'y/n' to enable/disable the CXL memory scrub driver that will
>> +	  attach to CXL.mem devices for memory scrub control feature. See
>> +	  sections 8.2.9.9.11.1 and 8.2.9.9.11.2 in the CXL 3.1 specification
>> +	  for a detailed description of CXL memory scrub control features.
>> +
>> +	  If unsure say 'n'.
>> +
>>  endif
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 1f66b5d4d935..99e3202f868f 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -15,3 +15,4 @@ cxl_core-y +=3D hdm.o
>>  cxl_core-y +=3D pmu.o
>>  cxl_core-$(CONFIG_TRACING) +=3D trace.o
>>  cxl_core-$(CONFIG_CXL_REGION) +=3D region.o
>> +cxl_core-$(CONFIG_CXL_SCRUB) +=3D memscrub.o
>> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
>> new file mode 100644 index 000000000000..e0d482b0bf3a
>> --- /dev/null
>> +++ b/drivers/cxl/core/memscrub.c
>> @@ -0,0 +1,266 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * cxl_memscrub.c - CXL memory scrub driver
>> + *
>> + * Copyright (c) 2023 HiSilicon Limited.
>> + *
>> + *  - Provides functions to configure patrol scrub
>> + *    feature of the CXL memory devices.
>> + */
>> +
>> +#define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
>> +
>> +#include <cxlmem.h>
>> +
>> +/* CXL memory scrub feature common definitions */
>> +#define CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH	128
>> +
>> +static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd=
,
>const uuid_t *feat_uuid,
>> +					       struct cxl_mbox_supp_feat_entry
>*feat_entry_out) {
>> +	struct cxl_mbox_get_supp_feats_out *feats_out __free(kvfree) =3D NULL;
>> +	struct cxl_mbox_supp_feat_entry *feat_entry;
>> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
>> +	struct cxl_mbox_get_supp_feats_in pi;
>> +	int feat_index, count;
>> +	int nentries;
>> +	int ret;
>> +
>> +	feat_index =3D 0;
>> +	pi.count =3D sizeof(struct cxl_mbox_get_supp_feats_out) +
>> +			  sizeof(struct cxl_mbox_supp_feat_entry);
>> +	feats_out =3D kvmalloc(pi.count, GFP_KERNEL);
>> +	if (!feats_out)
>> +		return -ENOMEM;
>> +
>> +	do {
>> +		pi.start_index =3D feat_index;
>> +		memset(feats_out, 0, pi.count);
>> +		ret =3D cxl_get_supported_features(mds, &pi, feats_out);
>> +		if (ret)
>> +			return ret;
>> +
>> +		nentries =3D feats_out->entries;
>> +		if (!nentries)
>> +			break;
>> +
>> +		/* Check CXL memdev supports the feature */
>> +		feat_entry =3D (void *)feats_out->feat_entries;
>> +		for (count =3D 0; count < nentries; count++, feat_entry++) {
>> +			if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
>> +				memcpy(feat_entry_out, feat_entry,
>sizeof(*feat_entry_out));
>> +				return 0;
>> +			}
>> +		}
>> +		feat_index +=3D nentries;
>> +	} while (nentries);
>> +
>> +	return -ENOTSUPP;
>> +}
>> +
>> +/* CXL memory patrol scrub control definitions */
>> +#define CXL_MEMDEV_PS_GET_FEAT_VERSION	0x01
>> +#define CXL_MEMDEV_PS_SET_FEAT_VERSION	0x01
>> +
>> +static const uuid_t cxl_patrol_scrub_uuid =3D
>> +	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,
>\
>> +		  0x06, 0xdb, 0x8a);
>> +
>> +/* CXL memory patrol scrub control functions */ struct
>> +cxl_patrol_scrub_context {
>> +	struct device *dev;
>> +	u16 get_feat_size;
>> +	u16 set_feat_size;
>> +	bool scrub_cycle_changeable;
>> +};
>> +
>> +/**
>> + * struct cxl_memdev_ps_params - CXL memory patrol scrub parameter data
>structure.
>> + * @enable:     [IN] enable(1)/disable(0) patrol scrub.
>> + * @scrub_cycle_changeable: [OUT] scrub cycle attribute of patrol scrub=
 is
>changeable.
>> + * @rate:       [IN] Requested patrol scrub cycle in hours.
>> + *              [OUT] Current patrol scrub cycle in hours.
>> + * @min_rate:[OUT] minimum patrol scrub cycle, in hours, supported.
>> + * @rate_avail:[OUT] Supported patrol scrub cycle in hours.
>> + */
>> +struct cxl_memdev_ps_params {
>> +	bool enable;
>> +	bool scrub_cycle_changeable;
>> +	u16 rate;
>> +	u16 min_rate;
>> +	char rate_avail[CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH];
>> +};
>> +
>> +enum {
>> +	CXL_MEMDEV_PS_PARAM_ENABLE =3D 0,
>> +	CXL_MEMDEV_PS_PARAM_RATE,
>> +};
>> +
>> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
>> +#define
>	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK
>	BIT(1)
>> +#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
>> +#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15,
>8)
>> +#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
>> +
>> +struct cxl_memdev_ps_feat_read_attrbs {
>> +	u8 scrub_cycle_cap;
>> +	__le16 scrub_cycle;
>> +	u8 scrub_flags;
>> +}  __packed;
>> +
>> +struct cxl_memdev_ps_set_feat_pi {
>> +	struct cxl_mbox_set_feat_in pi;
>> +	u8 scrub_cycle_hr;
>> +	u8 scrub_flags;
>> +}  __packed;
>> +
>> +static int cxl_mem_ps_get_attrbs(struct device *dev,
>> +				 struct cxl_memdev_ps_params *params) {
>> +	struct cxl_memdev_ps_feat_read_attrbs *rd_attrbs __free(kvfree) =3D
>NULL;
>> +	struct cxl_mbox_get_feat_in pi =3D {
>> +		.uuid =3D cxl_patrol_scrub_uuid,
>> +		.offset =3D 0,
>> +		.count =3D sizeof(struct cxl_memdev_ps_feat_read_attrbs),
>> +		.selection =3D CXL_GET_FEAT_SEL_CURRENT_VALUE,
>> +	};
>> +	struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev);
>> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
>> +	int ret;
>> +
>> +	if (!mds)
>> +		return -EFAULT;
>> +
>> +	rd_attrbs =3D kvmalloc(pi.count, GFP_KERNEL);
>> +	if (!rd_attrbs)
>> +		return -ENOMEM;
>> +
>> +	ret =3D cxl_get_feature(mds, &pi, rd_attrbs);
>> +	if (ret) {
>> +		params->enable =3D 0;
>> +		params->rate =3D 0;
>> +		snprintf(params->rate_avail,
>CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
>> +			"Unavailable");
>> +		return ret;
>> +	}
>> +	params->scrub_cycle_changeable =3D
>FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
>> +						   rd_attrbs->scrub_cycle_cap);
>> +	params->enable =3D
>FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
>> +				   rd_attrbs->scrub_flags);
>> +	params->rate =3D
>FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
>> +				 rd_attrbs->scrub_cycle);
>> +	params->min_rate  =3D
>FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
>> +				      rd_attrbs->scrub_cycle);
>> +	snprintf(params->rate_avail,
>CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
>> +		 "Minimum scrub cycle =3D %d hour", params->min_rate);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused
>> +cxl_mem_ps_set_attrbs(struct device *dev, struct cxl_memdev_ps_params
>*params,
>> +		      u8 param_type)
>> +{
>> +	struct cxl_memdev_ps_set_feat_pi set_pi =3D {
>> +		.pi.uuid =3D cxl_patrol_scrub_uuid,
>> +		.pi.flags =3D
>CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
>> +			    CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER,
>> +		.pi.offset =3D 0,
>> +		.pi.version =3D CXL_MEMDEV_PS_SET_FEAT_VERSION,
>> +	};
>> +	struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev);
>> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
>> +	struct cxl_memdev_ps_params rd_params;
>> +	int ret;
>> +
>> +	if (!mds)
>> +		return -EFAULT;
>> +
>> +	ret =3D cxl_mem_ps_get_attrbs(dev, &rd_params);
>> +	if (ret) {
>> +		dev_err(dev, "Get cxlmemdev patrol scrub params fail
>ret=3D%d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	switch (param_type) {
>> +	case CXL_MEMDEV_PS_PARAM_ENABLE:
>> +		set_pi.scrub_flags =3D
>FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
>> +						   params->enable);
>> +		set_pi.scrub_cycle_hr =3D
>FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
>> +						      rd_params.rate);
>> +		break;
>> +	case CXL_MEMDEV_PS_PARAM_RATE:
>> +		if (params->rate < rd_params.min_rate) {
>> +			dev_err(dev, "Invalid CXL patrol scrub cycle(%d) to
>set\n",
>> +				params->rate);
>> +			dev_err(dev, "Minimum supported CXL patrol scrub
>cycle in hour %d\n",
>> +			       params->min_rate);
>> +			return -EINVAL;
>> +		}
>> +		set_pi.scrub_cycle_hr =3D
>FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
>> +						      params->rate);
>> +		set_pi.scrub_flags =3D
>FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
>> +						   rd_params.enable);
>> +		break;
>> +	default:
>> +		dev_err(dev, "Invalid CXL patrol scrub parameter to set\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret =3D cxl_set_feature(mds, &set_pi, sizeof(set_pi));
>> +	if (ret) {
>> +		dev_err(dev, "CXL patrol scrub set feature fail ret=3D%d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Verify attribute set successfully */
>> +	if (param_type =3D=3D CXL_MEMDEV_PS_PARAM_RATE) {
>> +		ret =3D cxl_mem_ps_get_attrbs(dev, &rd_params);
>> +		if (ret) {
>> +			dev_err(dev, "Get cxlmemdev patrol scrub params fail
>ret=3D%d\n", ret);
>> +			return ret;
>> +		}
>> +		if (rd_params.rate !=3D params->rate)
>> +			return -EFAULT;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd) {
>> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
>> +	struct cxl_mbox_supp_feat_entry feat_entry;
>> +	struct cxl_memdev_ps_params params;
>> +	int ret;
>> +
>> +	ret =3D cxl_mem_get_supported_feature_entry(cxlmd,
>&cxl_patrol_scrub_uuid,
>> +						  &feat_entry);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (!(feat_entry.attrb_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
>> +		return -ENOTSUPP;
>> +
>> +	cxl_ps_ctx =3D devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx),
>GFP_KERNEL);
>> +	if (!cxl_ps_ctx)
>> +		return -ENOMEM;
>> +
>> +	cxl_ps_ctx->get_feat_size =3D feat_entry.get_feat_size;
>> +	cxl_ps_ctx->set_feat_size =3D feat_entry.set_feat_size;
>> +	ret =3D cxl_mem_ps_get_attrbs(&cxlmd->dev, &params);
>> +	if (ret) {
>> +		dev_err(&cxlmd->dev, "Get CXL patrol scrub params fail
>ret=3D%d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +	cxl_ps_ctx->scrub_cycle_changeable =3D
>params.scrub_cycle_changeable;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>> 46131dcd0900..25c46e72af16 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -983,6 +983,14 @@ int cxl_trigger_poison_list(struct cxl_memdev
>> *cxlmd);  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>> int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>>
>> +/* cxl memory scrub functions */
>> +#ifdef CONFIG_CXL_SCRUB
>> +int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd); #else static
>> +inline int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd) {
>> +return -ENOTSUPP; } #endif
>> +
>>  #ifdef CONFIG_CXL_SUSPEND
>>  void cxl_mem_active_inc(void);
>>  void cxl_mem_active_dec(void);
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
>> 0155fb66b580..acc337b8c365 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -881,6 +881,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, cons=
t
>struct pci_device_id *id)
>>  	if (rc)
>>  		return rc;
>>
>> +	/*
>> +	 * Initialize optional CXL scrub features
>> +	 */
>> +	cxl_mem_patrol_scrub_init(cxlmd);
>
>It will return a value but never be captured. The return value may indicat=
e an
>error other than the fact it is optional, maybe we want to capture it and =
handle
>it properly?
I  will add a warning log here on failure?     =20

>
>Fan
>
>
>> +
>>  	rc =3D devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
>>  	if (rc)
>>  		return rc;
>> --
>> 2.34.1
>>
Thanks,
Shiju

