Return-Path: <linux-kernel+bounces-158406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC488B1F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE441C21869
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260E208C1;
	Thu, 25 Apr 2024 10:38:33 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE848182AE;
	Thu, 25 Apr 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041513; cv=none; b=JbNyg4mafGGqReP9sjEX+xzscmukD7qx3NIdYEssC/jrcHvlzYpzks9zWOsqrK41F+sKhHL0a6o6WefPUuvQncN0l67LW05Q8JkySUJzE1anMVG7QykFWKPKstF/IKkd5nBKFUo8AznZzdFcjBc3aCffJgrV/PzZMniONXpJITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041513; c=relaxed/simple;
	bh=/81wgdKSHCihIfNVNmv/eA3+L956Kz89St2UPt+Km9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VdftvFH6XDTKGrL1n8FtZLhgaHTA8QOzWtIyOIMUhe7tehyUlFdQg8Xb+rBs3KIByEfyehWkCmsO18ldw+yQpfzNkvjNwAlXVaYRVUbFoOW79834lStFIzpwuFDQt9xN1YQPhoutDvvtAsBs0wLhFRzQSzvmxYUsS432HqY4Dfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQC1v0xR2z67LWc;
	Thu, 25 Apr 2024 18:36:03 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AD761400DB;
	Thu, 25 Apr 2024 18:38:28 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 11:38:27 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Thu, 25 Apr 2024 11:38:27 +0100
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
Subject: RE: [RFC PATCH v8 03/10] cxl/mbox: Add GET_FEATURE mailbox command
Thread-Topic: [RFC PATCH v8 03/10] cxl/mbox: Add GET_FEATURE mailbox command
Thread-Index: AQHaknlNjhR9ApEz/Ue7aqewzZ69irF4BeQAgADGYfA=
Date: Thu, 25 Apr 2024 10:38:27 +0000
Message-ID: <ac756def2c3d40afbf3c11a351942a12@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-4-shiju.jose@huawei.com> <ZimTauNEryrxDQgF@debian>
In-Reply-To: <ZimTauNEryrxDQgF@debian>
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
>Sent: 25 April 2024 00:19
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
>Subject: Re: [RFC PATCH v8 03/10] cxl/mbox: Add GET_FEATURE mailbox
>command
>
>On Sat, Apr 20, 2024 at 12:47:12AM +0800, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for GET_FEATURE mailbox command.
>>
>> CXL spec 3.1 section 8.2.9.6 describes optional device specific features=
.
>> The settings of a feature can be retrieved using Get Feature command.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/mbox.c | 53
>+++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h    | 28 ++++++++++++++++++++++
>>  2 files changed, 81 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>> 82e279b821e2..999965871048 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1318,6 +1318,59 @@ int cxl_get_supported_features(struct
>> cxl_memdev_state *mds,  }
>> EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>>
>> +size_t cxl_get_feature(struct cxl_memdev_state *mds,
>> +		       const uuid_t feat_uuid, void *feat_out,
>> +		       size_t feat_out_size,
>> +		       size_t feat_out_min_size,
>> +		       enum cxl_get_feat_selection selection) {
>> +	struct cxl_dev_state *cxlds =3D &mds->cxlds;
>> +	struct cxl_mbox_get_feat_in pi;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	size_t data_rcvd_size =3D 0;
>> +	size_t data_to_rd_size, size_out;
>> +	int rc;
>> +
>> +	if (feat_out_size < feat_out_min_size) {
>> +		dev_err(cxlds->dev,
>> +			"%s: feature out buffer size(%lu) is not big enough\n",
>> +			__func__, feat_out_size);
>> +		return 0;
>> +	}
>> +
>> +	if (feat_out_size <=3D mds->payload_size)
>> +		size_out =3D feat_out_size;
>> +	else
>> +		size_out =3D mds->payload_size;
>
>Using min() instead?
>    size_out =3D min(feat_out_size, mds->payload_size)
Will do.
>
>> +	pi.uuid =3D feat_uuid;
>> +	pi.selection =3D selection;
>> +	do {
>> +		if ((feat_out_min_size - data_rcvd_size) <=3D mds->payload_size)
>> +			data_to_rd_size =3D feat_out_min_size - data_rcvd_size;
>> +		else
>> +			data_to_rd_size =3D mds->payload_size;
>
>data_to_rd_size =3D min(feat_out_min_size - data_rcvd_size, mds->payload_s=
ize);

Will do.
>
>It seems feat_out_min_size is always the same as feat_out_size in this ser=
ies,
>what is it for? For the loop here, my understanding is we need to fill up =
the out
>buffer multiple times if the feature cannot be held in a call, so it seems
>feat_out_min_size should be feat_out_size here.
feat_out_size and feat_out_min_size added separately because this function =
is a common interface
and  it might be useful for the features like DDR5 ECS Control, where the  =
Get feature output payload
size is relatively high and actually required data is small, contains DDR5 =
ECS control feature readable attributes for N number of memory media FRUs.

>
>Fan
>
>> +
>> +		pi.offset =3D cpu_to_le16(data_rcvd_size);
>> +		pi.count =3D cpu_to_le16(data_to_rd_size);
>> +
>> +		mbox_cmd =3D (struct cxl_mbox_cmd) {
>> +			.opcode =3D CXL_MBOX_OP_GET_FEATURE,
>> +			.size_in =3D sizeof(pi),
>> +			.payload_in =3D &pi,
>> +			.size_out =3D size_out,
>> +			.payload_out =3D feat_out + data_rcvd_size,
>> +			.min_out =3D data_to_rd_size,
>> +		};
>> +		rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
>> +		if (rc < 0 || mbox_cmd.size_out =3D=3D 0)
>> +			return 0;
>> +		data_rcvd_size +=3D mbox_cmd.size_out;
>> +	} while (data_rcvd_size < feat_out_min_size);
>> +
>> +	return data_rcvd_size;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
>> +
>>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  		       struct cxl_region *cxlr)
>>  {
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>> 06231e63373e..c822eb30e6d1 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -528,6 +528,7 @@ enum cxl_opcode {
>>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	=3D 0x0400,
>>  	CXL_MBOX_OP_GET_LOG		=3D 0x0401,
>>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	=3D 0x0500,
>> +	CXL_MBOX_OP_GET_FEATURE		=3D 0x0501,
>>  	CXL_MBOX_OP_IDENTIFY		=3D 0x4000,
>>  	CXL_MBOX_OP_GET_PARTITION_INFO	=3D 0x4100,
>>  	CXL_MBOX_OP_SET_PARTITION_INFO	=3D 0x4101,
>> @@ -754,6 +755,28 @@ struct cxl_mbox_get_supp_feats_out {
>>  	struct cxl_mbox_supp_feat_entry feat_entries[];  } __packed;
>>
>> +/*
>> + * Get Feature CXL 3.1 Spec 8.2.9.6.2  */
>> +
>> +/*
>> + * Get Feature input payload
>> + * CXL rev 3.1 section 8.2.9.6.2 Table 8-99  */ enum
>> +cxl_get_feat_selection {
>> +	CXL_GET_FEAT_SEL_CURRENT_VALUE,
>> +	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
>> +	CXL_GET_FEAT_SEL_SAVED_VALUE,
>> +	CXL_GET_FEAT_SEL_MAX
>> +};
>> +
>> +struct cxl_mbox_get_feat_in {
>> +	uuid_t uuid;
>> +	__le16 offset;
>> +	__le16 count;
>> +	u8 selection;
>> +}  __packed;
>> +
>>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */  struct
>> cxl_mbox_poison_in {
>>  	__le64 offset;
>> @@ -888,6 +911,11 @@ int cxl_set_timestamp(struct cxl_memdev_state
>> *mds);  int cxl_get_supported_features(struct cxl_memdev_state *mds,
>>  			       u32 count, u16 start_index,
>>  			       struct cxl_mbox_get_supp_feats_out *feats_out);
>> +size_t cxl_get_feature(struct cxl_memdev_state *mds,
>> +		       const uuid_t feat_uuid, void *feat_out,
>> +		       size_t feat_out_size,
>> +		       size_t feat_out_min_size,
>> +		       enum cxl_get_feat_selection selection);
>>  int cxl_poison_state_init(struct cxl_memdev_state *mds);  int
>> cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  		       struct cxl_region *cxlr);
>> --
>> 2.34.1
>>
Thanks,
Shiju

