Return-Path: <linux-kernel+bounces-158973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC588B2793
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E992832D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60414EC45;
	Thu, 25 Apr 2024 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrK8xcgB"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2B14B077;
	Thu, 25 Apr 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714066023; cv=none; b=TOkp2aDocMggg5MqoF728bCjNOeNFm4G6/0L1+rEfM1bax3DjNC72MCPegOc9L+U2dGQkwH2JSGVJ2uBtC62xO4MIh1EXI8H09ZGMFwcFf8qvwcPb8ds3VDbgmIRd0A5ayXR06ya01pQ5KGVFAMqxlXIsU4CMty14nxEhcoXfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714066023; c=relaxed/simple;
	bh=UwM45O+uiXeyA4vPnBKUJQTx2u/U7RSqQt9xERpAiq0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbtt7sMmW6xWtE3GW9hhytWbMXj7HzmqnqNzdc7Hs65c0XxRLCZ1uvQDnvr0lAToPwfb9AbENFKyxXZBpL+rbCVq+atYB/icfJsVYuf7VvTXS29+lDvBejMzjfnA7+HnojVfuXTVZYEpsySx5lWASCM1pDcvtmwl2nGK5PQYJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrK8xcgB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e86d56b3bcso11607365ad.1;
        Thu, 25 Apr 2024 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714066021; x=1714670821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0g4XLw3B45byIB1RDNUY38GqRrTXx8Au6b71CzhcTY=;
        b=hrK8xcgBVbFv3+I/Ni3ltmFcNRXXjE2Xlre1nyjT+m9eU2SB2x6NQU8AAM0aUC/e1O
         tR4Txtn9XBxYBYwksbKE5QwiAdb+KZ3xe0ZXSzDtEo/6ePtqpKHO53KVnSs/eXChCIF+
         eo5rh+yaqtiwxgNAlM1VPdJY4r9XZKnaFtMaLrMaaH5YwwNer5x3FBbj/tOm+NZ3PTx2
         741ZRCnR/POrYMzgGoytzJqSEZxWJz5rcubKCjNZO4/1k2mm/Z1g/jRSikQ8hlUxRaNm
         CF4BO/xGK4JSaq+ta2VpHIjDTdklWB9SVbuEo+pZHKcRq+Pg+sqSlX/c1XJYTnmXnheM
         Wl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714066021; x=1714670821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0g4XLw3B45byIB1RDNUY38GqRrTXx8Au6b71CzhcTY=;
        b=QCFRW9u0UaN/uExrOmMY/aiAkPn6zUQBb4y0r1iKm6POAUrQgDU0Ns18jc2b57/b1e
         0s73vgOX3Ft3YK16dLJVhGCBw0AdrIUB4A0KOCtrGUdhzJtf0DUIyh08neB+jaBMuUg7
         MkwHN/mULg3R6KOP/gh0wkzl8pbVo31R/EkdjhrOvYVih+p+WYf6PYXhAx5m1Cogh3AS
         asSY7BMIwpz8ZjW1lT1kMXG88UumZTOGAHpVJathioUuBTcaD8YCUcLt7pMQD5OTHlOT
         FcQ4dDPH/sIeVEgnfCpL4YJvmmkr91aYja9GJ2V92IcLC9g0MJrMBYiQCKG85DSLpk3G
         IzSw==
X-Forwarded-Encrypted: i=1; AJvYcCXjc39NHT4agjp6zVGZte8+Dxrh7CsflT9P9d4lOzeMYttT1h6I6QwFscwxCGalzwlwnTmtz4YgVsqPiEhcUrkPtv5/lTEgRLk4TlcHY/b9E3OoHqMWNfDRJiEoB6eC0jnfeGgykcpGgpEwj1FScUYFou/EFxW9S9J1PfRFuvdWZwmwmDY=
X-Gm-Message-State: AOJu0YxalK7+C2Gw0LSzw9B5RcondJ5aF8mWLk1hDnY41qww/3AWKF5I
	Jd78gsNOImsYlWCPgqx53uiL7IIwn80odpax8SmMRjTLp2Nb33G7
X-Google-Smtp-Source: AGHT+IHw1urF2jSmmVEyN/pDFpaeHgkS2s4n3bNqIbCZc/EzsYBVznM5xl8ZZJoveHKfQd5yVAxpTA==
X-Received: by 2002:a17:902:8e83:b0:1e0:e85b:2d30 with SMTP id bg3-20020a1709028e8300b001e0e85b2d30mr174445plb.42.1714066020873;
        Thu, 25 Apr 2024 10:27:00 -0700 (PDT)
Received: from debian ([2601:641:300:14de:8052:4ab9:f3ac:ce61])
        by smtp.gmail.com with ESMTPSA id jv12-20020a170903058c00b001eab3baad5dsm1680463plb.4.2024.04.25.10.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:27:00 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 25 Apr 2024 10:26:54 -0700
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
Subject: Re: [RFC PATCH v8 04/10] cxl/mbox: Add SET_FEATURE mailbox command
Message-ID: <ZiqSXtrV14Kglr6i@debian>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-5-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419164720.1765-5-shiju.jose@huawei.com>

On Sat, Apr 20, 2024 at 12:47:13AM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for SET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> The settings of a feature can be optionally modified using Set Feature
> command.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 33 +++++++++++++++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 999965871048..4ca1238e8fec 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1371,6 +1371,79 @@ size_t cxl_get_feature(struct cxl_memdev_state *mds,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
>  
> +/*
> + * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
> + * available in the mailbox for storing the actual feature data so that
> + * the feature data transfer would work as expected.
> + */
> +#define FEAT_DATA_MIN_PAYLOAD_SIZE 10
> +int cxl_set_feature(struct cxl_memdev_state *mds,
> +		    const uuid_t feat_uuid, u8 feat_version,
> +		    void *feat_data, size_t feat_data_size,
> +		    u8 feat_flag)
> +{
> +	struct cxl_memdev_set_feat_pi {
> +		struct cxl_mbox_set_feat_hdr hdr;
> +		u8 feat_data[];
> +	}  __packed;
> +	size_t data_in_size, data_sent_size = 0;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t hdr_size;
> +	int rc = 0;
> +
> +	struct cxl_memdev_set_feat_pi *pi __free(kfree) =
> +					kmalloc(mds->payload_size, GFP_KERNEL);
> +	pi->hdr.uuid = feat_uuid;
> +	pi->hdr.version = feat_version;
> +	feat_flag &= ~CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK;
> +	hdr_size = sizeof(pi->hdr);
> +	/*
> +	 * Check minimum mbox payload size is available for
> +	 * the feature data transfer.
> +	 */
> +	if (hdr_size + FEAT_DATA_MIN_PAYLOAD_SIZE > mds->payload_size)
> +		return -ENOMEM;
> +
> +	if ((hdr_size + feat_data_size) <= mds->payload_size) {
> +		pi->hdr.flags = cpu_to_le32(feat_flag |
> +				       CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
> +		data_in_size = feat_data_size;
> +	} else {
> +		pi->hdr.flags = cpu_to_le32(feat_flag |
> +				       CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
> +		data_in_size = mds->payload_size - hdr_size;
> +	}
> +
> +	do {
> +		pi->hdr.offset = cpu_to_le16(data_sent_size);
> +		memcpy(pi->feat_data, feat_data + data_sent_size, data_in_size);
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_SET_FEATURE,
> +			.size_in = hdr_size + data_in_size,
> +			.payload_in = pi,
> +		};
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		if (rc < 0)
> +			return rc;
> +
> +		data_sent_size += data_in_size;
> +		if (data_sent_size >= feat_data_size)
> +			return 0;
> +
> +		if ((feat_data_size - data_sent_size) <= (mds->payload_size - hdr_size)) {
> +			data_in_size = feat_data_size - data_sent_size;
> +			pi->hdr.flags = cpu_to_le32(feat_flag |
> +					       CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER);
> +		} else {
> +			pi->hdr.flags = cpu_to_le32(feat_flag |
> +					       CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER);
> +		}
> +	} while (true);
> +
> +	return rc;
Dead code.

Fan

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c822eb30e6d1..1c50a3e2eced 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -529,6 +529,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>  	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
> +	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -777,6 +778,34 @@ struct cxl_mbox_get_feat_in {
>  	u8 selection;
>  }  __packed;
>  
> +/*
> + * Set Feature CXL 3.1 Spec 8.2.9.6.3
> + */
> +
> +/*
> + * Set Feature input payload
> + * CXL rev 3.1 section 8.2.9.6.3 Table 8-101
> + */
> +/* Set Feature : Payload in flags */
> +#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
> +enum cxl_set_feat_flag_data_transfer {
> +	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER,
> +	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER,
> +	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER,
> +	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER,
> +	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER,
> +	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
> +};
> +#define CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET	BIT(3)
> +
> +struct cxl_mbox_set_feat_hdr {
> +	uuid_t uuid;
> +	__le32 flags;
> +	__le16 offset;
> +	u8 version;
> +	u8 rsvd[9];
> +}  __packed;
> +
>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
>  struct cxl_mbox_poison_in {
>  	__le64 offset;
> @@ -916,6 +945,10 @@ size_t cxl_get_feature(struct cxl_memdev_state *mds,
>  		       size_t feat_out_size,
>  		       size_t feat_out_min_size,
>  		       enum cxl_get_feat_selection selection);
> +int cxl_set_feature(struct cxl_memdev_state *mds,
> +		    const uuid_t feat_uuid, u8 feat_version,
> +		    void *feat_data, size_t feat_data_size,
> +		    u8 feat_flag);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);
> -- 
> 2.34.1
> 

