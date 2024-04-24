Return-Path: <linux-kernel+bounces-157832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA008B16FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A03DB2736E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813216F269;
	Wed, 24 Apr 2024 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLKuutOA"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A1142E6F;
	Wed, 24 Apr 2024 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000759; cv=none; b=q7ropMWqYUP6pHyAUegZoAJMqeRdLZaEoyButvVILYkHsIDWdaXUzwUrhtGBmOaWB1+tKg9ejVhXrKSKshAjLMbcRQQVFEcrbzT+NPXyYaNMvsEo7govUrPq5ALnTuUqMc/RnwhkiUrz+hYrXbJnNvOT/lyqjh9FiXJDnj+wuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000759; c=relaxed/simple;
	bh=T0q3Dl6/0KH0khAoyfEPkB4v/KHhMEDnVbAu9J++Ykg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMvn3b4a2qmctrk7OPqjuWaQQmjT33ciXQJGu7UChL/Dk6J1FpSC68ylhGosnz/dp6nupbZLCcMgetWCUXCQKh9xeEUMR/VFke9eyp6sZQR37dwPXltW1E01A3f/KzuG7t/F9qljVEuMXkoUSHs7CfCkRSnf3umTFYrxdFz2TJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLKuutOA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f30f69a958so388884b3a.1;
        Wed, 24 Apr 2024 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714000757; x=1714605557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sakwDrIIsmCz4hVkB1z5sN2fWtElfeE23GuvVoi+CRM=;
        b=aLKuutOA2LNZoBs/lhGRc/8Psr3FFvZj/sgGs8feAr7FdJZ6V1PVg+4ettu4kz8KMT
         hAqgJpHtwfB0Gj+vWWL5XFYIMUsFX43qgjwJNN41Cnjck2Thh+iO/l0BAZdTiKrzPMJ2
         YnTy0ourOsB5cHq/EQFssakSJyi0gY0Wh8IXYlb4yN+2adrjv3RlkZ9nRFNN9AQRx1LH
         SGl37ZKHwLNzCmL4GZ33NebaV/mW/cVgpdCPCCgUWWRQspy62B/GvWiLXmk9souP9GEc
         VjE6eKreTPk6I7hDXLcEocZLRQ1CJi/BK2f7gDOV8rKQHO/UY2HN2EV5cgB3U0ScK3qS
         F1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000757; x=1714605557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sakwDrIIsmCz4hVkB1z5sN2fWtElfeE23GuvVoi+CRM=;
        b=UgvxXKlyhDuwBTFYerX9IZqNq1lqqfcYdHyaMx13e0FFmXI8LlJe5YcGFTf/QatKWY
         TbuKZnqKmj3fYS+ZemQEPmEHIwbOIpqLIxq7vMjwxAWz/6OS+SvdqhNr+J9LEvGn92+A
         79yxgMC1frObO9WVZ25TLCs5BSM48cIAAvdvAkgm4LDX4c1olyBxv7uCVoQXlq7cRDOE
         bvyrfnuXIg2V8Yzw3QYwY+1M5rNn/mrxuP94XOhGk8fSZJ34WmfoAz9EFv/UCVuTnqIZ
         raJ8fXIdaZLw9yU4uDf/ajejiBB9/eVLlccAevSr5FVv4RxTLbG4UqF7OrqR4TFdiQ1/
         gRTw==
X-Forwarded-Encrypted: i=1; AJvYcCWNO7BCAy8hH1JWW0ymCWknTMki9xicRzP9gQGT0WBmP+AxPz2DEE1u3B87sVDIXgHLnoE1AZO1ErPPB1ZoPatp2KUW5u67iEzmovsl+vdswL5bev7lO2+3Ov+jm/zHcGgAFmTwHm2qtpIt3maRMAbbpHCn+9eEzYUwHdBP3RiAAXltPl4=
X-Gm-Message-State: AOJu0YyTWeId+h/vZQ0LvEazxZQjzON2kx/KXHqC7eVolxLLjz2iCjuf
	Tqhaw4a8zXxNaMjK8ggDYHlCj8cquhHdX+aUopRCzoSZuYct4jMn
X-Google-Smtp-Source: AGHT+IEuvZAJziMcw4WYyCy553sul9ZkpvveDxJ7UhszeD5DLuljCvM3wLrc+K7mU7JskjhiQsWU8A==
X-Received: by 2002:a05:6a21:2709:b0:1ac:48a9:8a42 with SMTP id rm9-20020a056a21270900b001ac48a98a42mr4263409pzb.14.1714000756872;
        Wed, 24 Apr 2024 16:19:16 -0700 (PDT)
Received: from debian ([2601:641:300:14de:56e5:6d59:647c:63a1])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902768500b001e4478e9b21sm12438135pll.244.2024.04.24.16.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:19:16 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Apr 2024 16:19:06 -0700
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
Subject: Re: [RFC PATCH v8 03/10] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <ZimTauNEryrxDQgF@debian>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419164720.1765-4-shiju.jose@huawei.com>

On Sat, Apr 20, 2024 at 12:47:12AM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 53 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 28 ++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 82e279b821e2..999965871048 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1318,6 +1318,59 @@ int cxl_get_supported_features(struct cxl_memdev_state *mds,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>  
> +size_t cxl_get_feature(struct cxl_memdev_state *mds,
> +		       const uuid_t feat_uuid, void *feat_out,
> +		       size_t feat_out_size,
> +		       size_t feat_out_min_size,
> +		       enum cxl_get_feat_selection selection)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_mbox_get_feat_in pi;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t data_rcvd_size = 0;
> +	size_t data_to_rd_size, size_out;
> +	int rc;
> +
> +	if (feat_out_size < feat_out_min_size) {
> +		dev_err(cxlds->dev,
> +			"%s: feature out buffer size(%lu) is not big enough\n",
> +			__func__, feat_out_size);
> +		return 0;
> +	}
> +
> +	if (feat_out_size <= mds->payload_size)
> +		size_out = feat_out_size;
> +	else
> +		size_out = mds->payload_size;

Using min() instead?
    size_out = min(feat_out_size, mds->payload_size)

> +	pi.uuid = feat_uuid;
> +	pi.selection = selection;
> +	do {
> +		if ((feat_out_min_size - data_rcvd_size) <= mds->payload_size)
> +			data_to_rd_size = feat_out_min_size - data_rcvd_size;
> +		else
> +			data_to_rd_size = mds->payload_size;

data_to_rd_size = min(feat_out_min_size - data_rcvd_size, mds->payload_size);
    
It seems feat_out_min_size is always the same as feat_out_size in this series,
what is it for? For the loop here, my understanding is we need to fill up the
out buffer multiple times if the feature cannot be held in a call, so it
seems feat_out_min_size should be feat_out_size here.

Fan

> +
> +		pi.offset = cpu_to_le16(data_rcvd_size);
> +		pi.count = cpu_to_le16(data_to_rd_size);
> +
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_FEATURE,
> +			.size_in = sizeof(pi),
> +			.payload_in = &pi,
> +			.size_out = size_out,
> +			.payload_out = feat_out + data_rcvd_size,
> +			.min_out = data_to_rd_size,
> +		};
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		if (rc < 0 || mbox_cmd.size_out == 0)
> +			return 0;
> +		data_rcvd_size += mbox_cmd.size_out;
> +	} while (data_rcvd_size < feat_out_min_size);
> +
> +	return data_rcvd_size;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 06231e63373e..c822eb30e6d1 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -528,6 +528,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> +	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -754,6 +755,28 @@ struct cxl_mbox_get_supp_feats_out {
>  	struct cxl_mbox_supp_feat_entry feat_entries[];
>  } __packed;
>  
> +/*
> + * Get Feature CXL 3.1 Spec 8.2.9.6.2
> + */
> +
> +/*
> + * Get Feature input payload
> + * CXL rev 3.1 section 8.2.9.6.2 Table 8-99
> + */
> +enum cxl_get_feat_selection {
> +	CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
> +	CXL_GET_FEAT_SEL_SAVED_VALUE,
> +	CXL_GET_FEAT_SEL_MAX
> +};
> +
> +struct cxl_mbox_get_feat_in {
> +	uuid_t uuid;
> +	__le16 offset;
> +	__le16 count;
> +	u8 selection;
> +}  __packed;
> +
>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
>  struct cxl_mbox_poison_in {
>  	__le64 offset;
> @@ -888,6 +911,11 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_get_supported_features(struct cxl_memdev_state *mds,
>  			       u32 count, u16 start_index,
>  			       struct cxl_mbox_get_supp_feats_out *feats_out);
> +size_t cxl_get_feature(struct cxl_memdev_state *mds,
> +		       const uuid_t feat_uuid, void *feat_out,
> +		       size_t feat_out_size,
> +		       size_t feat_out_min_size,
> +		       enum cxl_get_feat_selection selection);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);
> -- 
> 2.34.1
> 

