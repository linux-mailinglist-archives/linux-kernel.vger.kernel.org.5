Return-Path: <linux-kernel+bounces-99559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A30B8789F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E4B1F21686
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1635456B7E;
	Mon, 11 Mar 2024 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9gGpIua"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5356772;
	Mon, 11 Mar 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192045; cv=none; b=bbvb8CwJHRDe4mx9JeBUqdMNwf/0cjhCVGjbtcPp5y32hOWxYrQH+dSyl1dfAnJsehPKHfw335IqPk8+/iEMqv7fT6AWRYnbsxT8q8hoOkt+07uUxCHnRknKCLTXd7XcRi5Mqs+hmvY7Hp9sfs5Ea/cKNtycoqQ5h25QJ+ZH/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192045; c=relaxed/simple;
	bh=HxYdp/+1ZrmqCfP7H1h9KnkYHbDmS8tczK9UeaKATig=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeNFU8jQrufw0UNrXtIaWPdjwrLbeUlUJLpHj3802m+e3ktSVc1D8HtX/kkwuEcJbFCTvcP/Q9u4q5Zg85/z+jImgDjQ+UcQw1cli+hY99wOUbZncx/nVeZy9cLDmpJ3Is8fOg0GTqTlycidzMrisIsRjZCZusQVO6WFFH1J72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9gGpIua; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bed9fb159fso172492439f.1;
        Mon, 11 Mar 2024 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710192043; x=1710796843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBhNEQBVy1fL/SUIc8TvpP+Pi6/a540l6mhfsmCEnoA=;
        b=D9gGpIuaKliULNOid2NDaeh/rxs8s9kHu1YDiG5TYBrkC3bAoW2CUIioGe5LzmITXn
         UEtWWw+drSglfkEAq1Z4FN3MIIlyScW5yxvYXhLZB2PMTR17Jz4Buvuce002k3I+YkIA
         GOyoJISL2jJ4rQw7yTK/ZCbtQWKGEJLkecLqZekN/prt3Zsj74GYmS7Q9KGIvtP8ewKr
         xFzdAlj9Gc3w3Qe8adxiUTfkkjfXBxoegs/L3NtluYoVlNfGndQwWJidy9nBNhzr3+HA
         IUJLEgN/cWFLy33yDRaqzr2xY3N8ju3tJYwqwSmHJpw0Dg4mHmrmwaJF0sTksb8w/W18
         k1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192043; x=1710796843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBhNEQBVy1fL/SUIc8TvpP+Pi6/a540l6mhfsmCEnoA=;
        b=uyRtQ5rLtO3BwPYbQzfQ6hOoQQG1xi3km79ntZS5l/0sJUYw9M2lV0xAG0ROgsJFid
         hXkEfUPOV3/DHgtZlbhB1W//EX5DMa97aK289zZYg5anBEu/7fZHGh2OUhjDkNRHxSU8
         HTT1nIlLLRcofYWTcyryx7s4Fg7cl1675IFDgPCyeO8k8TGbGYgUFspzXVf8G2fqCz6v
         l47td1y4prNvzt+//usvQ6O70ceqb6T8ddMOHYF1WirkFD/1Ic9uDkDr2UXzfE+hIhRP
         IBiIImevwCollKJdut1apy0OlyGF/UTfWg2GaJJbHmtNF6LnE0ZZKqat6tI5inATvom1
         7C/w==
X-Forwarded-Encrypted: i=1; AJvYcCXNZQPRKceiaLGRVDNzxqvo+VUj9wDwQC4KfRitebiCToT+MWPZG/CIxopkzQs5tJdTny0vRkrYwnFtm11icOKVzSZWf652+7Ba5Q/fMUst7KYZfPsiI55lX7Xh9WybJivDHdQbofpmKtnDc9aXYAYYHVZasb9Jl4cMs31SFw0JJlz5+Lc=
X-Gm-Message-State: AOJu0YzR5ibGQWoONgv92ceKVG0MSXQqJYfUhQrfprmTaWN9zu4+yPoy
	A9CRRv4cSHe8QlFd9Zs2RzlEspYjj4I7JSN5/cH7aSnJUP86pNAK
X-Google-Smtp-Source: AGHT+IF0bJjkZx211Ow0o9UR7ZYHFVRcRVsv6ZP9/5/UfJ2pK3pt/4piWTc05I528CJAag+9Qocpiw==
X-Received: by 2002:a05:6602:3307:b0:7c7:b761:9cea with SMTP id b7-20020a056602330700b007c7b7619ceamr8625565ioz.14.1710192042729;
        Mon, 11 Mar 2024 14:20:42 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id a26-20020a056638005a00b004746fab2afdsm1904555jap.40.2024.03.11.14.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 14:20:42 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 11 Mar 2024 14:20:23 -0700
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
Subject: Re: [RFC PATCH v7 03/12] cxl/mbox: Add SET_FEATURE mailbox command
Message-ID: <Ze91l0jz_DZR9jjx@debian>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
 <20240223143723.1574-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223143723.1574-4-shiju.jose@huawei.com>

On Fri, Feb 23, 2024 at 10:37:14PM +0800, shiju.jose@huawei.com wrote:
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
>  drivers/cxl/core/mbox.c | 67 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 30 ++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c078e62ea194..d1660bd20bdb 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1366,6 +1366,73 @@ size_t cxl_get_feature(struct cxl_memdev_state *mds,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
>  
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
> +	if (hdr_size + 10 > mds->payload_size)

Where does this magic number come from? 

Fan

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
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index bcfefff062a6..a8d4104afa53 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -531,6 +531,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>  	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
> +	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -773,6 +774,31 @@ struct cxl_mbox_get_feat_in {
>  	u8 selection;
>  }  __packed;
>  
> +/* Set Feature CXL 3.1 Spec 8.2.9.6.3 */
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
> @@ -912,6 +938,10 @@ size_t cxl_get_feature(struct cxl_memdev_state *mds,
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

