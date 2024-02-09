Return-Path: <linux-kernel+bounces-59273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B808284F461
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8451C24CFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A85B28DD3;
	Fri,  9 Feb 2024 11:17:26 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580C1EB46;
	Fri,  9 Feb 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477445; cv=none; b=pqAPuLIn0n61K9dRLrLtdyMIj0nqkCXNBcNeqUUP5Fg7d2L+lk2rw7JELgi+kf7Dd3R83dF2uETmvb1k5gN+7sxxyvS0Pf3rfWbYBQzk8vhsDS2O0Agxt6JkjquWPfosSNDYSOqKwtsj05hj87inaK10u9RHkC8FzhN4grxH/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477445; c=relaxed/simple;
	bh=jmpHRCTvzRQw0KdFhRUNvyK16BxOoZIVqXR+vRjCzLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O6vhRb8mYjPGIZJKH0dMQw5fMIjDsl+WwnMh1wKqnqfyP3ubXmPIfTVqYQjKbCt0/ONdPCHSQz/aBzHYEhjdJ6oJ0bFTju2hd+USTSzhNugCN68lImMN9NIhLZf3P86A9imMNn/3CkPKkMlKugnVTUC81GsVcSuB5UoNPBAyKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TWWSk1S8pz6D92M;
	Fri,  9 Feb 2024 19:13:58 +0800 (CST)
Received: from lhrpeml100006.china.huawei.com (unknown [7.191.160.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A631140A35;
	Fri,  9 Feb 2024 19:17:17 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 11:17:02 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 9 Feb 2024 11:17:01 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
Subject: RE: [RFC PATCH v5 01/12] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Thread-Topic: [RFC PATCH v5 01/12] cxl/mbox: Add GET_SUPPORTED_FEATURES
 mailbox command
Thread-Index: AQHaRJCaD0DwIp3NPkK9UMNuy7XDp7EBGDoAgADt89A=
Date: Fri, 9 Feb 2024 11:17:01 +0000
Message-ID: <c4e332fde2654c019d34587c5f1d6a9b@huawei.com>
References: <20240111131741.1356-1-shiju.jose@huawei.com>
 <20240111131741.1356-2-shiju.jose@huawei.com>
 <2k3fvg2xlp7ie47cy7finxchmb6sinkut2mp23wfvv73ik3erw@wohmod7labx5>
In-Reply-To: <2k3fvg2xlp7ie47cy7finxchmb6sinkut2mp23wfvv73ik3erw@wohmod7labx5>
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

Hi Davidlohr,

Thanks for the feedbacks.

>-----Original Message-----
>From: Davidlohr Bueso <dave@stgolabs.net>
>Sent: 08 February 2024 20:52
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
>mm@kvack.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>ira.weiny@intel.com; dan.j.williams@intel.com; linux-edac@vger.kernel.org;
>linux-kernel@vger.kernel.org; david@redhat.com; Vilas.Sridharan@amd.com;
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
>Subject: Re: [RFC PATCH v5 01/12] cxl/mbox: Add GET_SUPPORTED_FEATURES
>mailbox command
>
>On Thu, 11 Jan 2024, shiju.jose@huawei.com wrote:
>
>>From: Shiju Jose <shiju.jose@huawei.com>
>>
>>Add support for GET_SUPPORTED_FEATURES mailbox command.
>>
>>CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
>
>For the whole series, might as well make it 3.1 based. Are you aware of an=
y
>major differences (I have not checked) between versions in either this or =
any of
>the two users that use feats?
Sure, I will make 3.1 based.=20
I checked, no differences found  in feature commands b/w versions 3.0 and 3=
1 other than
new users of the features commands are present in v3.1 such as memory spari=
ng features and Advanced Programmable Corrected Volatile Memory Error Thres=
hold Feature Discovery and Configuration.

>
>>CXL devices supports features with changeable attributes.
>>Get Supported Features retrieves the list of supported device specific
>>features. The settings of a feature can be retrieved using Get Feature
>>and optionally modified using Set Feature.
>>
>>Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>>---
>> drivers/cxl/core/mbox.c | 23 ++++++++++++++++
>> drivers/cxl/cxlmem.h    | 59 +++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 82 insertions(+)
>>
>>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>>36270dcfb42e..6960ce935e73 100644
>>--- a/drivers/cxl/core/mbox.c
>>+++ b/drivers/cxl/core/mbox.c
>>@@ -1303,6 +1303,29 @@ int cxl_set_timestamp(struct cxl_memdev_state
>>*mds)  }  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
>>
>>+int cxl_get_supported_features(struct cxl_memdev_state *mds,
>>+						struct
>cxl_mbox_get_supp_feats_in *pi,
>>+						void *feats_out)
>>+{
>>+	struct cxl_mbox_cmd mbox_cmd;
>>+	int rc;
>>+
>>+	mbox_cmd =3D (struct cxl_mbox_cmd) {
>>+		.opcode =3D CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>>+		.size_in =3D sizeof(*pi),
>>+		.payload_in =3D pi,
>>+		.size_out =3D le32_to_cpu(pi->count),
>>+		.payload_out =3D feats_out,
>>+		.min_out =3D sizeof(struct cxl_mbox_get_supp_feats_out),
>>+	};
>>+	rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
>>+	if (rc < 0)
>>+		return rc;
>>+
>>+	return 0;
>>+}
>>+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>>+
>> int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>		       struct cxl_region *cxlr)
>> {
>>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>>a2fcbca253f3..d831dad748f5 100644
>>--- a/drivers/cxl/cxlmem.h
>>+++ b/drivers/cxl/cxlmem.h
>>@@ -506,6 +506,7 @@ enum cxl_opcode {
>>	CXL_MBOX_OP_SET_TIMESTAMP	=3D 0x0301,
>>	CXL_MBOX_OP_GET_SUPPORTED_LOGS	=3D 0x0400,
>>	CXL_MBOX_OP_GET_LOG		=3D 0x0401,
>>+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	=3D 0x0500,
>>	CXL_MBOX_OP_IDENTIFY		=3D 0x4000,
>>	CXL_MBOX_OP_GET_PARTITION_INFO	=3D 0x4100,
>>	CXL_MBOX_OP_SET_PARTITION_INFO	=3D 0x4101,
>>@@ -740,6 +741,61 @@ struct cxl_mbox_set_timestamp_in {
>>
>> } __packed;
>>
>>+/* Get Supported Features CXL 3.0 Spec 8.2.9.6.1 */
>>+/*
>>+ * Get Supported Features input payload
>>+ * CXL rev 3.0 section 8.2.9.6.1; Table 8-75  */ struct
>>+cxl_mbox_get_supp_feats_in {
>>+	__le32 count;
>>+	__le16 start_index;
>>+	u16 reserved;
>>+} __packed;
>>+
>>+/*
>>+ * Get Supported Features Supported Feature Entry
>>+ * CXL rev 3.0 section 8.2.9.6.1; Table 8-77  */
>>+/* Supported Feature Entry : Payload out attribute flags */
>>+#define CXL_FEAT_ENTRY_FLAG_CHANGABLE	BIT(0)
>>+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_MASK
>	GENMASK(3, 1)
>>+
>>+enum cxl_feat_attrib_value_persistence {
>>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_NONE =3D 0x0,
>>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_CXL_RESET =3D 0x1,
>>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_HOT_RESET =3D 0x2,
>>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_WARM_RESET =3D 0x3,
>>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_COLD_RESET =3D 0x4,
>
>Just leave the enums without explicit values - you are not changing the de=
fault
>counting.
Sure.

>
>>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_MAX
>>+};
>>+
>>+#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_ACROSS_FW_UPDATE_MASK
>	BIT(4)
>>+#define
>CXL_FEAT_ENTRY_FLAG_PERSISTENCE_DEFAULT_SEL_SUPPORT_MASK	BIT(5)
>>+#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_SAVED_SEL_SUPPORT_MASK
>	BIT(6)
>>+
>>+struct cxl_mbox_supp_feat_entry {
>>+	uuid_t uuid;
>>+	__le16 feat_index;
>>+	__le16 get_feat_size;
>>+	__le16 set_feat_size;
>>+	__le32 attrb_flags;
>
>Nit but rename to 'attr', it is more along the kernel coding style (just c=
ompare a
>git grep of attrb vs attr). Also applies to the whole series.
Sure. I will modify.

>
>Thanks,
>Davidlohr
>
>>+	u8 get_feat_version;
>>+	u8 set_feat_version;
>>+	__le16 set_feat_effects;
>>+	u8 rsvd[18];
>>+}  __packed;
>>+
>>+/*
>>+ * Get Supported Features output payload
>>+ * CXL rev 3.0 section 8.2.9.6.1; Table 8-76  */ struct
>>+cxl_mbox_get_supp_feats_out {
>>+	__le16 entries;
>>+	__le16 nsuppfeats_dev;
>>+	u32 reserved;
>>+	struct cxl_mbox_supp_feat_entry feat_entries[]; } __packed;
>>+
>> /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */  struct
>>cxl_mbox_poison_in {
>>	__le64 offset;
>>@@ -867,6 +923,9 @@ void clear_exclusive_cxl_commands(struct
>cxl_memdev_state *mds,
>>				  unsigned long *cmds);
>> void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32
>>status);  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>>+int cxl_get_supported_features(struct cxl_memdev_state *mds,
>>+			       struct cxl_mbox_get_supp_feats_in *pi,
>>+			       void *feats_out);
>> int cxl_poison_state_init(struct cxl_memdev_state *mds);  int
>>cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>		       struct cxl_region *cxlr);
>>--
>>2.34.1
>>

Thank,
Shiju

