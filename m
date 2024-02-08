Return-Path: <linux-kernel+bounces-58764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B22584EB5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8271F21D45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C324F5F2;
	Thu,  8 Feb 2024 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="YOXU7Gja"
Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642CF50A64;
	Thu,  8 Feb 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430271; cv=pass; b=j9EnTL03irdyNr+spaUoyU1Ax8I1uiqJynGMVPEOt2fHkUF8yw0bK8Pf8Lb6729tsgsM1YxMic0WQMmny3KnBJQ4FP5+Qm/hb1kQEaYOgwjdg4R1fcD1KhLGJUuvCwYWdmUWxtNnpwwP3gkZQIOWFnQlLXK3qRgybi0Nip1oaLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430271; c=relaxed/simple;
	bh=EfzQfH39aO+4zozrTp5Iw6smZ27pVpvHxXQ5G56bcOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJRbn7Vt2XGh+RvqGbKtY2jxJZtNsbZaewMXfavpl9H8Ko2hhwn+V6jtUJ5KgAOE5xmLFOvK+/BTCKgJZ+sJIwvIyXf13LjBvhRgjYSXA6h1lNMZEBT6Svm9QME/Md+v+14oFW3llMbhAghBE3FPzvRWhZwRGI9I2kFnRweK9uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=YOXU7Gja; arc=pass smtp.client-ip=23.83.209.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2FC81C3258;
	Thu,  8 Feb 2024 20:52:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 575F7C2B2F;
	Thu,  8 Feb 2024 20:52:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1707425545; a=rsa-sha256;
	cv=none;
	b=eYQaUjfaqCK4xqX9nP/8LGZahisop7rwAID90vEA1OqmZHHOvAXr6pQaADpvMEW08Bu+dQ
	+O/mPnQu+7rb2/ZSs/IY8HcRn4Tp3JMsztQWNADwix7ZdKFhXTo6GxrRcvCYbeY1M2K38Y
	yN17gvV+SDM3VaeJL890Kb9tMimDPTrJdKteWtrBydp1LjX1FzXZXcBAjl5ntfNKIcrkZV
	gtGhLJLa6E74WhDMu5ueIsiVY6h97FAA8cv2kgfOOpdIwzjzOxN2DjBzVGyMUMSHNW9D16
	tcggDxwzVG1rhjNJRXcKCgUi6RMV3VXNcIFwRopKyWEDodPBXPsCyzL3YeTUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1707425545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CcMUr6aSsUDavOgiQY01krpatcLaL0XR+yGhEiyDQ5U=;
	b=qohssJ3OLAkOXjEBqbEjqEUP2wcs/MEVf4omu3Zfh/lu81SQ0fYOXywmomz8sEUn+q5+Km
	/3PR/FgF4924gtPBnGlZ0Nr4tqKV5+fWisrdhJAKGXWPScDzdXirusXVAkfCWxBAUDNlMW
	WviojhJYBcFf4mSRrK5fqZ8kg7FY42g39/GDeAwAhtNyXr9VU06oKJeV1wpnHbe8xgYgx4
	m2sgHla7QJVns7HKhjuaZJJ5OeptqotMWeIuiEddhvGTGDXnUbvNbPdG0E+zCKQFrbuJA1
	t7eknmDYMLQz2J+VjPfOF3gQYgGuB155PzR3+eai/mURyFVj4WKg4p+kGiI/Ow==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-6hq8s;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bubble-Relation: 2299cdce6fe69eba_1707425545994_4052383959
X-MC-Loop-Signature: 1707425545994:3695226952
X-MC-Ingress-Time: 1707425545993
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.7.223 (trex/6.9.2);
	Thu, 08 Feb 2024 20:52:25 +0000
Received: from offworld (unknown [108.175.208.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4TW8Lb0jY9z6f;
	Thu,  8 Feb 2024 12:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1707425545;
	bh=CcMUr6aSsUDavOgiQY01krpatcLaL0XR+yGhEiyDQ5U=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=YOXU7GjaqvpZw5IyzvttEBrRKB/ZhM7rPdiuGFFLyx9t5cKNmHOZz/0p0fuNpyBJ4
	 XipLwJ+ptUNHrgtjNmf2EEprypP59TujNiDwdnRsgBgtXhJ8noBZsqpH1v8Jv3wrvs
	 Fjk20dPzwDQCntNE3UHANhWu7hPxg3LLfVojP3JKQ0SJO/fcR/d2BEtb19/QoCHgDJ
	 3TR9axYgi/99YlcCej1kx7fe8v7EVdLnRfN2v3moZGwyPBowvnZpMatyr1OTtjn63g
	 O7vb5b6IXdLLxhlQXXzTYNHmpAfLwcX7wxwRTgE1G6ZtL7jodYakara7t6arTrjAOV
	 zjck6sMz1nunQ==
Date: Thu, 8 Feb 2024 12:52:08 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-mm@kvack.org, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	dan.j.williams@intel.com, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com, 
	Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org, lenb@kernel.org, 
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com, 
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	mike.malvestuto@intel.com, gthelen@google.com, wschwartz@amperecomputing.com, 
	dferguson@amperecomputing.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [RFC PATCH v5 01/12] cxl/mbox: Add GET_SUPPORTED_FEATURES
 mailbox command
Message-ID: <2k3fvg2xlp7ie47cy7finxchmb6sinkut2mp23wfvv73ik3erw@wohmod7labx5>
Mail-Followup-To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com, 
	Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org, lenb@kernel.org, 
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com, 
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	mike.malvestuto@intel.com, gthelen@google.com, wschwartz@amperecomputing.com, 
	dferguson@amperecomputing.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20240111131741.1356-1-shiju.jose@huawei.com>
 <20240111131741.1356-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240111131741.1356-2-shiju.jose@huawei.com>
User-Agent: NeoMutt/20231221

On Thu, 11 Jan 2024, shiju.jose@huawei.com wrote:

>From: Shiju Jose <shiju.jose@huawei.com>
>
>Add support for GET_SUPPORTED_FEATURES mailbox command.
>
>CXL spec 3.0 section 8.2.9.6 describes optional device specific features.

For the whole series, might as well make it 3.1 based. Are you aware of
any major differences (I have not checked) between versions in either
this or any of the two users that use feats?

>CXL devices supports features with changeable attributes.
>Get Supported Features retrieves the list of supported device specific
>features. The settings of a feature can be retrieved using Get Feature
>and optionally modified using Set Feature.
>
>Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>---
> drivers/cxl/core/mbox.c | 23 ++++++++++++++++
> drivers/cxl/cxlmem.h    | 59 +++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 82 insertions(+)
>
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>index 36270dcfb42e..6960ce935e73 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -1303,6 +1303,29 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
> }
> EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
>
>+int cxl_get_supported_features(struct cxl_memdev_state *mds,
>+						struct cxl_mbox_get_supp_feats_in *pi,
>+						void *feats_out)
>+{
>+	struct cxl_mbox_cmd mbox_cmd;
>+	int rc;
>+
>+	mbox_cmd = (struct cxl_mbox_cmd) {
>+		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>+		.size_in = sizeof(*pi),
>+		.payload_in = pi,
>+		.size_out = le32_to_cpu(pi->count),
>+		.payload_out = feats_out,
>+		.min_out = sizeof(struct cxl_mbox_get_supp_feats_out),
>+	};
>+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>+	if (rc < 0)
>+		return rc;
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>+
> int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>		       struct cxl_region *cxlr)
> {
>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>index a2fcbca253f3..d831dad748f5 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -506,6 +506,7 @@ enum cxl_opcode {
>	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>	CXL_MBOX_OP_GET_LOG		= 0x0401,
>+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
>@@ -740,6 +741,61 @@ struct cxl_mbox_set_timestamp_in {
>
> } __packed;
>
>+/* Get Supported Features CXL 3.0 Spec 8.2.9.6.1 */
>+/*
>+ * Get Supported Features input payload
>+ * CXL rev 3.0 section 8.2.9.6.1; Table 8-75
>+ */
>+struct cxl_mbox_get_supp_feats_in {
>+	__le32 count;
>+	__le16 start_index;
>+	u16 reserved;
>+} __packed;
>+
>+/*
>+ * Get Supported Features Supported Feature Entry
>+ * CXL rev 3.0 section 8.2.9.6.1; Table 8-77
>+ */
>+/* Supported Feature Entry : Payload out attribute flags */
>+#define CXL_FEAT_ENTRY_FLAG_CHANGABLE	BIT(0)
>+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_MASK	GENMASK(3, 1)
>+
>+enum cxl_feat_attrib_value_persistence {
>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_NONE = 0x0,
>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_CXL_RESET = 0x1,
>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_HOT_RESET = 0x2,
>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_WARM_RESET = 0x3,
>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_COLD_RESET = 0x4,

Just leave the enums without explicit values - you are not
changing the default counting.

>+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_MAX
>+};
>+
>+#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_ACROSS_FW_UPDATE_MASK	BIT(4)
>+#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_DEFAULT_SEL_SUPPORT_MASK	BIT(5)
>+#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_SAVED_SEL_SUPPORT_MASK	BIT(6)
>+
>+struct cxl_mbox_supp_feat_entry {
>+	uuid_t uuid;
>+	__le16 feat_index;
>+	__le16 get_feat_size;
>+	__le16 set_feat_size;
>+	__le32 attrb_flags;

Nit but rename to 'attr', it is more along the kernel coding style
(just compare a git grep of attrb vs attr). Also applies to the whole
series.

Thanks,
Davidlohr

>+	u8 get_feat_version;
>+	u8 set_feat_version;
>+	__le16 set_feat_effects;
>+	u8 rsvd[18];
>+}  __packed;
>+
>+/*
>+ * Get Supported Features output payload
>+ * CXL rev 3.0 section 8.2.9.6.1; Table 8-76
>+ */
>+struct cxl_mbox_get_supp_feats_out {
>+	__le16 entries;
>+	__le16 nsuppfeats_dev;
>+	u32 reserved;
>+	struct cxl_mbox_supp_feat_entry feat_entries[];
>+} __packed;
>+
> /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
> struct cxl_mbox_poison_in {
>	__le64 offset;
>@@ -867,6 +923,9 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>				  unsigned long *cmds);
> void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> int cxl_set_timestamp(struct cxl_memdev_state *mds);
>+int cxl_get_supported_features(struct cxl_memdev_state *mds,
>+			       struct cxl_mbox_get_supp_feats_in *pi,
>+			       void *feats_out);
> int cxl_poison_state_init(struct cxl_memdev_state *mds);
> int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>		       struct cxl_region *cxlr);
>--
>2.34.1
>

