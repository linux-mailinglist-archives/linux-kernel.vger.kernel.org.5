Return-Path: <linux-kernel+bounces-72872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F585B9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276391F24442
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F6665BDF;
	Tue, 20 Feb 2024 11:05:57 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5F65BAB;
	Tue, 20 Feb 2024 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427156; cv=none; b=tQt0b5XrTbAdfvCJUZIyTMIz0wd2FUicb9O2tc9uhq+Hc0utv29d/fF4bJNHVN6T6OuhSDNGnvaYC8QBoiZJYX//fMb4iFWZDG3A94WpJpmS3aaEuOZWGhaDbQbGeIYHa3nxUf76Am5yI5nLDwGp1HBpPZagsu910r0HmysZ8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427156; c=relaxed/simple;
	bh=nWbcj9a7ApzfSfnJyvKwRS+t0ZxHTScdHFamDuoqyEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U4+FyvC3cIL9l0wqmXN1/EfT3lwIw5PZt+QwmwPyQvxJZC2NzvVtYLifZ1lDq5KLhnsgU6m3bwvCR8M8vPR3vanSl6N4Q53joo1rQuujZl4iQ9xyDZZzBlC2QmmTQXV18VxW9Oh8uQQgwIZHZYSKnELFxJzR0E4vzxjn99K63+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfGgg4bKRz6K613;
	Tue, 20 Feb 2024 19:01:51 +0800 (CST)
Received: from lhrpeml100002.china.huawei.com (unknown [7.191.160.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 621FB140C98;
	Tue, 20 Feb 2024 19:05:51 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 11:05:51 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Tue, 20 Feb 2024 11:05:51 +0000
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
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH v5 05/12] cxl/memscrub: Add CXL device ECS control
 feature
Thread-Topic: [RFC PATCH v5 05/12] cxl/memscrub: Add CXL device ECS control
 feature
Thread-Index: AQHaRJCdX+Iod/7xJkOZf7U0hSyTtrENenuAgAXTbpA=
Date: Tue, 20 Feb 2024 11:05:50 +0000
Message-ID: <4cf7d0182946456b8e4e69fd7b6cfd7d@huawei.com>
References: <20240111131741.1356-1-shiju.jose@huawei.com>
 <20240111131741.1356-6-shiju.jose@huawei.com> <Zc-iX3fyHEB-NnBD@debian>
In-Reply-To: <Zc-iX3fyHEB-NnBD@debian>
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

>-----Original Message-----
>From: fan <nifan.cxl@gmail.com>
>Sent: 16 February 2024 17:59
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
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [RFC PATCH v5 05/12] cxl/memscrub: Add CXL device ECS control
>feature
>
>On Thu, Jan 11, 2024 at 09:17:34PM +0800, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub
>> (ECS) control feature.
>>
>> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
>> Specification (JESD79-5) and allows the DRAM to internally read,
>> correct single-bit errors, and write back corrected data bits to the
>> DRAM array while providing transparency to error counts. The ECS
>> control feature allows the request to configure ECS input
>> configurations during system boot or at run-time.
>>
>> The ECS control allows the requester to change the log entry type, the
>> ECS threshold count provided that the request is within the definition
>> specified in DDR5 mode registers, change mode between codeword mode
>> and row count mode, and reset the ECS counter.
>>
>> Open Question:
>> Is cxl_mem_ecs_init() invoked in the right function in cxl/core/region.c=
?
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/memscrub.c | 303
>+++++++++++++++++++++++++++++++++++-
>>  drivers/cxl/core/region.c   |   1 +
>>  drivers/cxl/cxlmem.h        |   3 +
>>  3 files changed, 306 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
>> index e0d482b0bf3a..e7741e2fdbdb 100644
>> --- a/drivers/cxl/core/memscrub.c
>> +++ b/drivers/cxl/core/memscrub.c
>> @@ -5,7 +5,7 @@
>>   * Copyright (c) 2023 HiSilicon Limited.
>>   *
>>   *  - Provides functions to configure patrol scrub
>> - *    feature of the CXL memory devices.
>> + *    and DDR5 ECS features of the CXL memory devices.
>>   */
>>
>>  #define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
>> @@ -264,3 +264,304 @@ int cxl_mem_patrol_scrub_init(struct cxl_memdev
>*cxlmd)
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
>> +
>> +/* CXL DDR5 ECS control definitions */
>> +#define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
>> +#define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
>> +
>> +static const uuid_t cxl_ecs_uuid =3D
>> +	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,
>\
>> +		  0x89, 0x33, 0x86);
>> +
>> +struct cxl_ecs_context {
>> +	struct device *dev;
>> +	u16 nregions;
>> +	int region_id;
>> +	u16 get_feat_size;
>> +	u16 set_feat_size;
>> +};
>> +
>> +/**
>> + * struct cxl_memdev_ecs_params - CXL memory DDR5 ECS parameter data
>structure.
>> + * @log_entry_type: ECS log entry type, per DRAM or per memory media
>FRU.
>> + * @threshold: ECS threshold count per GB of memory cells.
>> + * @mode:	codeword/row count mode
>> + *		0 : ECS counts rows with errors
>> + *		1 : ECS counts codeword with errors
>> + * @reset_counter: [IN] reset ECC counter to default value.
>> + */
>> +struct cxl_memdev_ecs_params {
>> +	u8 log_entry_type;
>> +	u16 threshold;
>
>Why need to be u16? It has only 3 bits.
Here u16 threshold stores the ECS threshold count 256/1024/4096 from the us=
er and converted to the corresponding 3 bit value in cxl_mem_ecs_set_attrbs=
() below.
Please see spec r3.1, Table  8-210. DDR5 ECS Control Feature Readable Attri=
butes
Bits[2:0]: ECS Threshold Count per Gb of Memory Cells:
- 011b =3D 256 (default)
- 100b =3D 1024
- 101b =3D 4096

>
>> +	u8 mode;
>> +	bool reset_counter;
>> +};
>> +
>> +enum {
>> +	CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE =3D 0,
>> +	CXL_MEMDEV_ECS_PARAM_THRESHOLD,
>> +	CXL_MEMDEV_ECS_PARAM_MODE,
>> +	CXL_MEMDEV_ECS_PARAM_RESET_COUNTER,
>> +};
>> +
>> +#define	CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK	GENMASK(1, 0)
>> +#define	CXL_MEMDEV_ECS_REALTIME_REPORT_CAP_MASK	BIT(0)
>> +#define	CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK
>	GENMASK(2, 0)
>> +#define	CXL_MEMDEV_ECS_MODE_MASK	BIT(3)
>> +#define	CXL_MEMDEV_ECS_RESET_COUNTER_MASK	BIT(4)
>> +
>> +static const u16 ecs_supp_threshold[] =3D { 0, 0, 0, 256, 1024, 4096 };
>> +
>> +enum {
>> +	ECS_LOG_ENTRY_TYPE_DRAM =3D 0x0,
>> +	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU =3D 0x1, };
>> +
>> +enum {
>> +	ECS_THRESHOLD_256 =3D 3,
>> +	ECS_THRESHOLD_1024 =3D 4,
>> +	ECS_THRESHOLD_4096 =3D 5,
>> +};
>> +
>> +enum {
>> +	ECS_MODE_COUNTS_ROWS =3D 0,
>> +	ECS_MODE_COUNTS_CODEWORDS =3D 1,
>> +};
>> +
>> +struct cxl_memdev_ecs_feat_read_attrbs {
>> +	u8 ecs_log_cap;
>> +	u8 ecs_cap;
>> +	__le16 ecs_config;
>> +	u8 ecs_flags;
>> +}  __packed;
>> +
>> +struct cxl_memdev_ecs_set_feat_pi {
>> +	struct cxl_mbox_set_feat_in pi;
>> +	struct cxl_memdev_ecs_feat_wr_attrbs {
>> +		u8 ecs_log_cap;
>> +		__le16 ecs_config;
>> +	} __packed wr_attrbs[];
>> +}  __packed;
>> +
>> +/* CXL DDR5 ECS control functions */
>> +static int cxl_mem_ecs_get_attrbs(struct device *dev, int fru_id,
>> +				  struct cxl_memdev_ecs_params *params) {
>> +	struct cxl_memdev_ecs_feat_read_attrbs *rd_attrbs __free(kvfree) =3D
>NULL;
>> +	struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev->parent);
>> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
>> +	struct cxl_mbox_get_feat_in pi =3D {
>> +		.uuid =3D cxl_ecs_uuid,
>> +		.offset =3D 0,
>> +		.selection =3D CXL_GET_FEAT_SEL_CURRENT_VALUE,
>> +	};
>> +	struct cxl_ecs_context *cxl_ecs_ctx;
>> +	u8 threshold_index;
>> +	int ret;
>> +
>> +	if (!mds)
>> +		return -EFAULT;
>> +	cxl_ecs_ctx =3D dev_get_drvdata(dev);
>> +
>> +	pi.count =3D cxl_ecs_ctx->get_feat_size;
>> +	rd_attrbs =3D kvmalloc(pi.count, GFP_KERNEL);
>> +	if (!rd_attrbs)
>> +		return -ENOMEM;
>> +
>> +	ret =3D cxl_get_feature(mds, &pi, rd_attrbs);
>> +	if (ret) {
>> +		params->log_entry_type =3D 0;
>> +		params->threshold =3D 0;
>> +		params->mode =3D 0;
>> +		return ret;
>> +	}
>> +	params->log_entry_type =3D
>FIELD_GET(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
>> +					   rd_attrbs[fru_id].ecs_log_cap);
>> +	threshold_index =3D
>FIELD_GET(CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
>> +				    rd_attrbs[fru_id].ecs_config);
>> +	params->threshold =3D ecs_supp_threshold[threshold_index];
>> +	params->mode =3D FIELD_GET(CXL_MEMDEV_ECS_MODE_MASK,
>> +				 rd_attrbs[fru_id].ecs_config);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused
>> +cxl_mem_ecs_set_attrbs(struct device *dev, int fru_id,
>> +		       struct cxl_memdev_ecs_params *params, u8 param_type) {
>> +	struct cxl_memdev_ecs_feat_read_attrbs *rd_attrbs __free(kvfree) =3D
>NULL;
>> +	struct cxl_memdev_ecs_set_feat_pi *set_pi __free(kvfree) =3D NULL;
>> +	struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev->parent);
>> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
>> +	struct cxl_mbox_get_feat_in pi =3D {
>> +		.uuid =3D cxl_ecs_uuid,
>> +		.offset =3D 0,
>> +		.selection =3D CXL_GET_FEAT_SEL_CURRENT_VALUE,
>> +	};
>> +	struct cxl_memdev_ecs_feat_wr_attrbs *wr_attrbs;
>> +	struct cxl_memdev_ecs_params rd_params;
>> +	struct cxl_ecs_context *cxl_ecs_ctx;
>> +	u16 nmedia_frus, count;
>> +	u32 set_pi_size;
>> +	int ret;
>> +
>> +	if (!mds)
>> +		return -EFAULT;
>> +
>> +	cxl_ecs_ctx =3D dev_get_drvdata(dev);
>> +	nmedia_frus =3D cxl_ecs_ctx->nregions;
>> +
>> +	rd_attrbs =3D kvmalloc(cxl_ecs_ctx->get_feat_size, GFP_KERNEL);
>> +	if (!rd_attrbs)
>> +		return -ENOMEM;
>> +
>> +	pi.count =3D cxl_ecs_ctx->get_feat_size;
>> +	ret =3D cxl_get_feature(mds, &pi, rd_attrbs);
>> +	if (ret)
>> +		return ret;
>> +	set_pi_size =3D sizeof(struct cxl_mbox_set_feat_in) +
>> +				cxl_ecs_ctx->set_feat_size;
>> +	set_pi =3D kvmalloc(set_pi_size, GFP_KERNEL);
>> +	if (!set_pi)
>> +		return -ENOMEM;
>> +
>> +	set_pi->pi.uuid =3D cxl_ecs_uuid;
>> +	set_pi->pi.flags =3D
>CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
>> +				CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER;
>> +	set_pi->pi.offset =3D 0;
>> +	set_pi->pi.version =3D CXL_MEMDEV_ECS_SET_FEAT_VERSION;
>> +	/* Fill writable attributes from the current attributes read for all t=
he
>media FRUs */
>> +	wr_attrbs =3D set_pi->wr_attrbs;
>> +	for (count =3D 0; count < nmedia_frus; count++) {
>> +		wr_attrbs[count].ecs_log_cap =3D rd_attrbs[count].ecs_log_cap;
>> +		wr_attrbs[count].ecs_config =3D rd_attrbs[count].ecs_config;
>> +	}
>> +
>> +	/* Fill attribute to be set for the media FRU */
>> +	switch (param_type) {
>> +	case CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE:
>> +		if (params->log_entry_type !=3D ECS_LOG_ENTRY_TYPE_DRAM
>&&
>> +		    params->log_entry_type !=3D
>ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU) {
>> +			dev_err(dev->parent,
>> +				"Invalid CXL ECS scrub log entry type(%d) to
>set\n",
>> +			       params->log_entry_type);
>> +			dev_err(dev->parent,
>> +				"Log Entry Type 0: per DRAM  1: per Memory
>Media FRU\n");
>> +			return -EINVAL;
>> +		}
>> +		wr_attrbs[fru_id].ecs_log_cap =3D
>FIELD_PREP(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
>> +							   params-
>>log_entry_type);
>> +		break;
>> +	case CXL_MEMDEV_ECS_PARAM_THRESHOLD:
>> +		wr_attrbs[fru_id].ecs_config &=3D
>~CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK;
>> +		switch (params->threshold) {
>> +		case 256:
>> +			wr_attrbs[fru_id].ecs_config |=3D FIELD_PREP(
>> +
>	CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
>> +						ECS_THRESHOLD_256);
>> +			break;
>> +		case 1024:
>> +			wr_attrbs[fru_id].ecs_config |=3D FIELD_PREP(
>> +
>	CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
>> +						ECS_THRESHOLD_1024);
>> +			break;
>> +		case 4096:
>> +			wr_attrbs[fru_id].ecs_config |=3D FIELD_PREP(
>> +
>	CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
>> +						ECS_THRESHOLD_4096);
>> +			break;
>> +		default:
>> +			dev_err(dev->parent,
>> +				"Invalid CXL ECS scrub threshold count(%d) to
>set\n",
>> +				params->threshold);
>> +			dev_err(dev->parent,
>> +				"Supported scrub threshold count:
>256,1024,4096\n");
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	case CXL_MEMDEV_ECS_PARAM_MODE:
>> +		if (params->mode !=3D ECS_MODE_COUNTS_ROWS &&
>> +		    params->mode !=3D ECS_MODE_COUNTS_CODEWORDS) {
>> +			dev_err(dev->parent,
>> +				"Invalid CXL ECS scrub mode(%d) to set\n",
>> +				params->mode);
>> +			dev_err(dev->parent,
>> +				"Mode 0: ECS counts rows with errors"
>> +				" 1: ECS counts codewords with errors\n");
>> +			return -EINVAL;
>> +		}
>> +		wr_attrbs[fru_id].ecs_config &=3D
>~CXL_MEMDEV_ECS_MODE_MASK;
>> +		wr_attrbs[fru_id].ecs_config |=3D
>FIELD_PREP(CXL_MEMDEV_ECS_MODE_MASK,
>> +							  params->mode);
>> +		break;
>> +	case CXL_MEMDEV_ECS_PARAM_RESET_COUNTER:
>> +		wr_attrbs[fru_id].ecs_config &=3D
>~CXL_MEMDEV_ECS_RESET_COUNTER_MASK;
>> +		wr_attrbs[fru_id].ecs_config |=3D
>FIELD_PREP(CXL_MEMDEV_ECS_RESET_COUNTER_MASK,
>> +							   params-
>>reset_counter);
>> +		break;
>> +	default:
>> +		dev_err(dev->parent, "Invalid CXL ECS parameter to set\n");
>> +		return -EINVAL;
>> +	}
>> +	ret =3D cxl_set_feature(mds, set_pi, set_pi_size);
>> +	if (ret) {
>> +		dev_err(dev->parent, "CXL ECS set feature fail ret=3D%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Verify attribute is set successfully */
>> +	ret =3D cxl_mem_ecs_get_attrbs(dev, fru_id, &rd_params);
>> +	if (ret) {
>> +		dev_err(dev->parent, "Get cxlmemdev ECS params fail
>ret=3D%d\n", ret);
>> +		return ret;
>> +	}
>> +	switch (param_type) {
>> +	case CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE:
>> +		if (rd_params.log_entry_type !=3D params->log_entry_type)
>> +			return -EFAULT;
>> +		break;
>> +	case CXL_MEMDEV_ECS_PARAM_THRESHOLD:
>> +		if (rd_params.threshold !=3D params->threshold)
>> +			return -EFAULT;
>> +		break;
>> +	case CXL_MEMDEV_ECS_PARAM_MODE:
>> +		if (rd_params.mode !=3D params->mode)
>> +			return -EFAULT;
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id) {
>> +	struct cxl_mbox_supp_feat_entry feat_entry;
>> +	struct cxl_ecs_context *cxl_ecs_ctx;
>> +	int nmedia_frus;
>> +	int ret;
>> +
>> +	ret =3D cxl_mem_get_supported_feature_entry(cxlmd, &cxl_ecs_uuid,
>&feat_entry);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (!(feat_entry.attrb_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
>> +		return -ENOTSUPP;
>> +	nmedia_frus =3D feat_entry.get_feat_size/
>> +				sizeof(struct
>cxl_memdev_ecs_feat_read_attrbs);
>> +	if (nmedia_frus) {
>> +		cxl_ecs_ctx =3D devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx),
>GFP_KERNEL);
>> +		if (!cxl_ecs_ctx)
>> +			return -ENOMEM;
>> +
>> +		cxl_ecs_ctx->nregions =3D nmedia_frus;
>> +		cxl_ecs_ctx->get_feat_size =3D feat_entry.get_feat_size;
>> +		cxl_ecs_ctx->set_feat_size =3D feat_entry.set_feat_size;
>> +		cxl_ecs_ctx->region_id =3D region_id;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_mem_ecs_init, CXL);
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 3e817a6f94c6..ca71ad403d62 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2912,6 +2912,7 @@ int cxl_add_to_region(struct cxl_port *root, struc=
t
>cxl_endpoint_decoder *cxled)
>>  			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
>>  				p->res);
>>  	}
>> +	cxl_mem_ecs_init(cxlmd, atomic_read(&cxlrd->region_id));
>
>Check the return value and process accordingly.
Sure.

>
>Fan
>
>>
>>  	put_device(region_dev);
>>  out:
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>> 25c46e72af16..c255063dd795 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -986,9 +986,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd,
>> u64 dpa);
>>  /* cxl memory scrub functions */
>>  #ifdef CONFIG_CXL_SCRUB
>>  int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
>> +int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id);
>>  #else
>>  static inline int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
>> { return -ENOTSUPP; }
>> +static inline int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int
>> +region_id) { return -ENOTSUPP; }
>>  #endif
>>
>>  #ifdef CONFIG_CXL_SUSPEND
>> --
>> 2.34.1
>>

Thanks,
Shiju

