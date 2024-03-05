Return-Path: <linux-kernel+bounces-93122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C47872B51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F08CB21D67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71812DDBF;
	Tue,  5 Mar 2024 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5z/JnQj"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19614171D2;
	Tue,  5 Mar 2024 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683092; cv=none; b=GVNEkg4d5E/8hlmYNkhEyONq74SeQF9ikLfv5uIezkIJ5BF/Ye4uzLjAWTTtBt5bNRbBJCFShky8UT2Am0ek7Vs4iIG/M0yaOf1X5VMsmwZRb2o8pS66//DIvtIhlkl8n2d2vjkaobarpENZK/t8qGk7eaqooHP99osOHV0ZHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683092; c=relaxed/simple;
	bh=4hCUq/hjcZij7Vw+LDYWfYReVMXKhq7r70yM7c0jmfI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQBXJIkpkW8loVRzFCI6tUYS09q2jFZxRsP5hS2p1+1SGRWef6cJ80uwi9otRDY5dwllLpNBT3o6Yt1Jv8rIcTFoohUjjlxHsLHiR1SjErpzhiojB9HmGYKjoHRnGKuPeH74TUxpMrTd692TT8aB3iHrN6vhCAtTUMy7Ylz7AEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5z/JnQj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e56787e691so238179b3a.0;
        Tue, 05 Mar 2024 15:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709683090; x=1710287890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CRPbTjVgyE4PYwh/jnpL0ufRys+ZJBqz1o3jrQedx1Q=;
        b=N5z/JnQjQeIeVkuECWVQX5EBNV6WMJpKOuUWKAgu98+ww5EK+7tER3tTp2IWioS4OI
         b3GS4WdCh9ldMmhyLaeG8+UPYu0AtI2P6UDZJ9bOtBTN6mjxl2GvfmdsJwPJqqp2u5Dg
         QtBj+G80FK8xpC1/Jhu9T9LqOyXJZ4ZsFESD2mjQ8bZkRGOMkQ0ZhwtjAa3KG8GSXqh1
         dt+93EzJwnYJY6kwlb6qWX7gJddn8yUMTs1fBY2KN59q/wHsv6Nr/PRs1f3tUWEpI7b4
         qTrKXAUpWnMffqvjbm+JxMkrw7DCid2MOhPQIMIc+tU1Cwtiuop0GTUab6m9AeGsH9U/
         gWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709683090; x=1710287890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRPbTjVgyE4PYwh/jnpL0ufRys+ZJBqz1o3jrQedx1Q=;
        b=fxnvIUYlFgFTF3AOc6+M14hYwz/nqqwLERjGXrdTSh6p4sVqZc83XDXyqz+lYv1bH5
         E4+WVYcAskvtBda2/grpxugNQW+4LZWe6v4GF7Rd+oJ5S1ykAdFrKcN3ItWySwg72pCw
         R7ZC7FqyYFK4Sv120TFnkhOAGeueZcqGEZ8zgD5eYvF2ZDlxjf4uI/46uuLxcbeeRYf1
         SB5nlf+IrP4UwkO72QiECxTzt5Js2i+55zulQBFD1gSex0sKE0S7lukzbjt0VQTW2A+i
         yZakM/uj+jWeV/yQ1MBbzSCjXWD7L8q5HCggnEnpR2qloeDpmZ0V6HcYZlpxMMdH3KxG
         yQPw==
X-Forwarded-Encrypted: i=1; AJvYcCUagw3p3GQp1tTIG+VEctIfmZ9VkpanYZxX5tZ393j/tenLJL9YmJx2f7D0fp6qtOGKPXvoI/lTM2Nn6OTw2ZUspMM4fqLu3u60rORI65uoHJAZh8ULOs8DunREKJsopQnISB2pFsE3J7x2Ny32MOjDp/yGL8eUBgXIV6RWqPn0u8of3Cs=
X-Gm-Message-State: AOJu0YwDJ74QREu5IW1CjQOZFRKAqSnByFD5K+9fGVzCJlOiLQClVtzg
	792wnV2lfNIH1HJCW/8jz4cGzpyIEr2Z4KOCB2w3bKdFHj/8yyX3
X-Google-Smtp-Source: AGHT+IFkyfofyClB+sf4ug0A6uUDjt2ZbsKesCzqOAmB+JwKyE/QcgD3QAAH8mfPCIEOeeVjDbPGeg==
X-Received: by 2002:a05:6a20:e111:b0:1a1:48df:d55c with SMTP id kr17-20020a056a20e11100b001a148dfd55cmr4371695pzb.0.1709683090406;
        Tue, 05 Mar 2024 15:58:10 -0800 (PST)
Received: from debian ([2601:641:300:14de:881:34a4:d51c:3425])
        by smtp.gmail.com with ESMTPSA id jw13-20020a056a00928d00b006e5574db193sm9885184pfb.18.2024.03.05.15.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:58:10 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 5 Mar 2024 15:57:53 -0800
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
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [RFC PATCH v6 01/12] cxl/mbox: Add GET_SUPPORTED_FEATURES
 mailbox command
Message-ID: <ZeexgfzE2LkiV_Na@debian>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
 <20240215111455.1462-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215111455.1462-2-shiju.jose@huawei.com>

On Thu, Feb 15, 2024 at 07:14:43PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_SUPPORTED_FEATURES mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get Feature
> and optionally modified using Set Feature.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 23 +++++++++++++++
>  drivers/cxl/cxlmem.h    | 62 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 27166a411705..191f51f3df0e 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1290,6 +1290,29 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
>  
> +int cxl_get_supported_features(struct cxl_memdev_state *mds,
> +						struct cxl_mbox_get_supp_feats_in *pi,
> +						void *feats_out)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +		.size_in = sizeof(*pi),
> +		.payload_in = pi,
> +		.size_out = le32_to_cpu(pi->count),
> +		.payload_out = feats_out,
> +		.min_out = sizeof(struct cxl_mbox_get_supp_feats_out),
> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5303d6942b88..23e4d98b9bae 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -529,6 +529,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -698,6 +699,64 @@ struct cxl_mbox_set_timestamp_in {
>  
>  } __packed;
>  
> +/* Get Supported Features CXL 3.1 Spec 8.2.9.6.1 */

In current code, block comments starts with /* and the real comments go
from the second line.

Fan
> +/*
> + * Get Supported Features input payload
> + * CXL rev 3.1 section 8.2.9.6.1 Table 8-95
> + */
> +struct cxl_mbox_get_supp_feats_in {
> +	__le32 count;
> +	__le16 start_index;
> +	u16 reserved;
> +} __packed;
> +
> +/*
> + * Get Supported Features Supported Feature Entry
> + * CXL rev 3.1 section 8.2.9.6.1 Table 8-97
> + */
> +/* Supported Feature Entry : Payload out attribute flags */
> +#define CXL_FEAT_ENTRY_FLAG_CHANGABLE	BIT(0)
> +#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_MASK	GENMASK(3, 1)
> +#define CXL_FEAT_ENTRY_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE	BIT(4)
> +#define CXL_FEAT_ENTRY_FLAG_SUPPORT_DEFAULT_SELECTION	BIT(5)
> +#define CXL_FEAT_ENTRY_FLAG_SUPPORT_SAVED_SELECTION	BIT(6)
> +
> +enum cxl_feat_attr_value_persistence {
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_NONE,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_CXL_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_HOT_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_WARM_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_COLD_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_MAX
> +};
> +
> +#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_ACROSS_FW_UPDATE_MASK	BIT(4)
> +#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_DEFAULT_SEL_SUPPORT_MASK	BIT(5)
> +#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_SAVED_SEL_SUPPORT_MASK	BIT(6)
> +
> +struct cxl_mbox_supp_feat_entry {
> +	uuid_t uuid;
> +	__le16 feat_index;
> +	__le16 get_feat_size;
> +	__le16 set_feat_size;
> +	__le32 attr_flags;
> +	u8 get_feat_version;
> +	u8 set_feat_version;
> +	__le16 set_feat_effects;
> +	u8 rsvd[18];
> +}  __packed;
> +
> +/*
> + * Get Supported Features output payload
> + * CXL rev 3.1 section 8.2.9.6.1 Table 8-96
> + */
> +struct cxl_mbox_get_supp_feats_out {
> +	__le16 entries;
> +	__le16 nsuppfeats_dev;
> +	u32 reserved;
> +	struct cxl_mbox_supp_feat_entry feat_entries[];
> +} __packed;
> +
>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
>  struct cxl_mbox_poison_in {
>  	__le64 offset;
> @@ -829,6 +888,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
> +int cxl_get_supported_features(struct cxl_memdev_state *mds,
> +			       struct cxl_mbox_get_supp_feats_in *pi,
> +			       void *feats_out);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);
> -- 
> 2.34.1
> 

