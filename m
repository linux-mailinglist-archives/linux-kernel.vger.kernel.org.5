Return-Path: <linux-kernel+bounces-69109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A48584B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03B2B269DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7578A133981;
	Fri, 16 Feb 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO5XnCik"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB1132493;
	Fri, 16 Feb 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106342; cv=none; b=IXP6KZ4kQKVH8Kspp1tNwCs8u8ZYasx0SWy0yggSLf6KrgK+TKm2rpITKcRNjDAnr/RENrKSToomVIDeP4+IOSQA4SFnoIa9CnO7OgfyHxjLUahID7GVXecsta+Q1YR292dJjAUrImrcbYLmDMVlDSx9TnuyA9ounq6ImsNNiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106342; c=relaxed/simple;
	bh=+PqkRbRSH++0IYnYB/a3Vw97KSbi9YQUovgEwXLQjmY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0iWY2WjKUQach04wxM0NzEF5/4YAaepYJwbv7rMOZvciwijPtuWEH2zmKBJ5daLy/NLRjIXn1yWV9fhTOlTx80KYSl4G6+KorA7rR5ria1EdUPakKjp0BjzNIYYzFoImgurm8QIqtA4fwrOV6RmdAzWtNPA7pgsPBfIIflOXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO5XnCik; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso1597071b3a.3;
        Fri, 16 Feb 2024 09:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106340; x=1708711140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hH43F2xAPB/ks5JUHmf/XMk0PC3oEYZ4qnSY0+cZETI=;
        b=aO5XnCikqPeU4l7uiyWU0e1RDU2XQNck8SYAQFXGjwum6PFRzkCPZbYP82Bj6OBAOs
         8PMkt9n5Eckw475xTOmsUH9j87C+OZyw+wC5VNSmltHrLPtcYza9YOJ+3fZ4WI9r+Ewf
         JIeSZX95Y9UnGgdiKw8HI/N/S2KlqgPgQFlphLKvSchIuXwak474IWYKQzRtLh1I0y3d
         q1vF4GmGqlEfe541PTNfHVLTuINLmlZxMPGiFrTz6+/qG1ulFV+wbLRsysjFnPC5gqSx
         PFSeCEaWjPAKxypMi1TBDYRRC8Ud840UOs60o3lxoAtgbDLzetFW5oDuhsU4cNfo+0LD
         zkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106340; x=1708711140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hH43F2xAPB/ks5JUHmf/XMk0PC3oEYZ4qnSY0+cZETI=;
        b=tfzidofrRRzEt7Kw1X4cnNdwTzHcqaCyvzaVk/oOXEaoCp5G2UUlvuuDE1G1rzMSLu
         RKIRBh3gKtYkiUYw4IiqLKAqbAaprqgu4/2hAtQ+QXx7LzSY1rkuP9twwzU+WQrTwkzs
         GMfDPaFr0nm8v2iqWBYF94h7q+lEmgXsrlyIvE7dFIfVmyqiuBca1JkVdU/kMajQkdu4
         scYqr01zO7XoFGEdoejUPrbHinrtRlDhddJjH3snGneS00BTgh89ihke/pWwp/wbYDpH
         7fU9933a5opGSCg1NxtJV5g4rGXFJ+SwBZH+Wb/ze7MCyfRsRZeuG6mIP9gP7/8txw5e
         Dkrw==
X-Forwarded-Encrypted: i=1; AJvYcCX2AJhoKZ8bWg5EVPV6oTSLHuty4gCRk/FWYZwp9ErL++piAOHSCtTKf3Zbfcc88Rj0LgzkiLEd3TVDG3HUOx3uMmPlI+GNZkYVr+N7KAfuI00MisNukVEe5n9maa/Rt6OwORNyw89qI3IbgnflAzBaRoocJMBynwFJEB+x65gIAFV+rpE=
X-Gm-Message-State: AOJu0Yw28YAQPz1XEf4hhXx3Y7WQJ5ZbdQQpqLiXvGgdeZTgEbFlxlRg
	womET+bk1tLKKYaelrXgNoV1DhfVJGcRXPyJO97dV5DfcAAjlupN
X-Google-Smtp-Source: AGHT+IHkvo4psKVDx9AOZFUBRJUz8xKDEVAeAd8Sm6Fku4o4O6cqOk5RoogdQE2aqNzShnIK+xyl8w==
X-Received: by 2002:a05:6a00:190e:b0:6e0:ed67:b309 with SMTP id y14-20020a056a00190e00b006e0ed67b309mr6762758pfi.21.1708106339699;
        Fri, 16 Feb 2024 09:58:59 -0800 (PST)
Received: from debian ([2601:641:300:14de:f1a:387c:5c5c:3099])
        by smtp.gmail.com with ESMTPSA id m16-20020a056a00081000b006e13d849fa5sm237509pfk.68.2024.02.16.09.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:58:59 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 16 Feb 2024 09:58:55 -0800
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
	linuxarm@huawei.com
Subject: Re: [RFC PATCH v5 05/12] cxl/memscrub: Add CXL device ECS control
 feature
Message-ID: <Zc-iX3fyHEB-NnBD@debian>
References: <20240111131741.1356-1-shiju.jose@huawei.com>
 <20240111131741.1356-6-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111131741.1356-6-shiju.jose@huawei.com>

On Thu, Jan 11, 2024 at 09:17:34PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
> control feature.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts. The ECS control feature
> allows the request to configure ECS input configurations during system
> boot or at run-time.
> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count provided that the request is within the definition
> specified in DDR5 mode registers, change mode between codeword mode and
> row count mode, and reset the ECS counter.
> 
> Open Question:
> Is cxl_mem_ecs_init() invoked in the right function in cxl/core/region.c?
>  
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/memscrub.c | 303 +++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/region.c   |   1 +
>  drivers/cxl/cxlmem.h        |   3 +
>  3 files changed, 306 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
> index e0d482b0bf3a..e7741e2fdbdb 100644
> --- a/drivers/cxl/core/memscrub.c
> +++ b/drivers/cxl/core/memscrub.c
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2023 HiSilicon Limited.
>   *
>   *  - Provides functions to configure patrol scrub
> - *    feature of the CXL memory devices.
> + *    and DDR5 ECS features of the CXL memory devices.
>   */
>  
>  #define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
> @@ -264,3 +264,304 @@ int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
> +
> +/* CXL DDR5 ECS control definitions */
> +#define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
> +#define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
> +
> +static const uuid_t cxl_ecs_uuid =
> +	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,     \
> +		  0x89, 0x33, 0x86);
> +
> +struct cxl_ecs_context {
> +	struct device *dev;
> +	u16 nregions;
> +	int region_id;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +};
> +
> +/**
> + * struct cxl_memdev_ecs_params - CXL memory DDR5 ECS parameter data structure.
> + * @log_entry_type: ECS log entry type, per DRAM or per memory media FRU.
> + * @threshold: ECS threshold count per GB of memory cells.
> + * @mode:	codeword/row count mode
> + *		0 : ECS counts rows with errors
> + *		1 : ECS counts codeword with errors
> + * @reset_counter: [IN] reset ECC counter to default value.
> + */
> +struct cxl_memdev_ecs_params {
> +	u8 log_entry_type;
> +	u16 threshold;

Why need to be u16? It has only 3 bits.

> +	u8 mode;
> +	bool reset_counter;
> +};
> +
> +enum {
> +	CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE = 0,
> +	CXL_MEMDEV_ECS_PARAM_THRESHOLD,
> +	CXL_MEMDEV_ECS_PARAM_MODE,
> +	CXL_MEMDEV_ECS_PARAM_RESET_COUNTER,
> +};
> +
> +#define	CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK	GENMASK(1, 0)
> +#define	CXL_MEMDEV_ECS_REALTIME_REPORT_CAP_MASK	BIT(0)
> +#define	CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK	GENMASK(2, 0)
> +#define	CXL_MEMDEV_ECS_MODE_MASK	BIT(3)
> +#define	CXL_MEMDEV_ECS_RESET_COUNTER_MASK	BIT(4)
> +
> +static const u16 ecs_supp_threshold[] = { 0, 0, 0, 256, 1024, 4096 };
> +
> +enum {
> +	ECS_LOG_ENTRY_TYPE_DRAM = 0x0,
> +	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU = 0x1,
> +};
> +
> +enum {
> +	ECS_THRESHOLD_256 = 3,
> +	ECS_THRESHOLD_1024 = 4,
> +	ECS_THRESHOLD_4096 = 5,
> +};
> +
> +enum {
> +	ECS_MODE_COUNTS_ROWS = 0,
> +	ECS_MODE_COUNTS_CODEWORDS = 1,
> +};
> +
> +struct cxl_memdev_ecs_feat_read_attrbs {
> +	u8 ecs_log_cap;
> +	u8 ecs_cap;
> +	__le16 ecs_config;
> +	u8 ecs_flags;
> +}  __packed;
> +
> +struct cxl_memdev_ecs_set_feat_pi {
> +	struct cxl_mbox_set_feat_in pi;
> +	struct cxl_memdev_ecs_feat_wr_attrbs {
> +		u8 ecs_log_cap;
> +		__le16 ecs_config;
> +	} __packed wr_attrbs[];
> +}  __packed;
> +
> +/* CXL DDR5 ECS control functions */
> +static int cxl_mem_ecs_get_attrbs(struct device *dev, int fru_id,
> +				  struct cxl_memdev_ecs_params *params)
> +{
> +	struct cxl_memdev_ecs_feat_read_attrbs *rd_attrbs __free(kvfree) = NULL;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_mbox_get_feat_in pi = {
> +		.uuid = cxl_ecs_uuid,
> +		.offset = 0,
> +		.selection = CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +	};
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +	u8 threshold_index;
> +	int ret;
> +
> +	if (!mds)
> +		return -EFAULT;
> +	cxl_ecs_ctx = dev_get_drvdata(dev);
> +
> +	pi.count = cxl_ecs_ctx->get_feat_size;
> +	rd_attrbs = kvmalloc(pi.count, GFP_KERNEL);
> +	if (!rd_attrbs)
> +		return -ENOMEM;
> +
> +	ret = cxl_get_feature(mds, &pi, rd_attrbs);
> +	if (ret) {
> +		params->log_entry_type = 0;
> +		params->threshold = 0;
> +		params->mode = 0;
> +		return ret;
> +	}
> +	params->log_entry_type = FIELD_GET(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
> +					   rd_attrbs[fru_id].ecs_log_cap);
> +	threshold_index = FIELD_GET(CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +				    rd_attrbs[fru_id].ecs_config);
> +	params->threshold = ecs_supp_threshold[threshold_index];
> +	params->mode = FIELD_GET(CXL_MEMDEV_ECS_MODE_MASK,
> +				 rd_attrbs[fru_id].ecs_config);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused
> +cxl_mem_ecs_set_attrbs(struct device *dev, int fru_id,
> +		       struct cxl_memdev_ecs_params *params, u8 param_type)
> +{
> +	struct cxl_memdev_ecs_feat_read_attrbs *rd_attrbs __free(kvfree) = NULL;
> +	struct cxl_memdev_ecs_set_feat_pi *set_pi __free(kvfree) = NULL;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_mbox_get_feat_in pi = {
> +		.uuid = cxl_ecs_uuid,
> +		.offset = 0,
> +		.selection = CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +	};
> +	struct cxl_memdev_ecs_feat_wr_attrbs *wr_attrbs;
> +	struct cxl_memdev_ecs_params rd_params;
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +	u16 nmedia_frus, count;
> +	u32 set_pi_size;
> +	int ret;
> +
> +	if (!mds)
> +		return -EFAULT;
> +
> +	cxl_ecs_ctx = dev_get_drvdata(dev);
> +	nmedia_frus = cxl_ecs_ctx->nregions;
> +
> +	rd_attrbs = kvmalloc(cxl_ecs_ctx->get_feat_size, GFP_KERNEL);
> +	if (!rd_attrbs)
> +		return -ENOMEM;
> +
> +	pi.count = cxl_ecs_ctx->get_feat_size;
> +	ret = cxl_get_feature(mds, &pi, rd_attrbs);
> +	if (ret)
> +		return ret;
> +	set_pi_size = sizeof(struct cxl_mbox_set_feat_in) +
> +				cxl_ecs_ctx->set_feat_size;
> +	set_pi = kvmalloc(set_pi_size, GFP_KERNEL);
> +	if (!set_pi)
> +		return -ENOMEM;
> +
> +	set_pi->pi.uuid = cxl_ecs_uuid;
> +	set_pi->pi.flags = CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
> +				CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER;
> +	set_pi->pi.offset = 0;
> +	set_pi->pi.version = CXL_MEMDEV_ECS_SET_FEAT_VERSION;
> +	/* Fill writable attributes from the current attributes read for all the media FRUs */
> +	wr_attrbs = set_pi->wr_attrbs;
> +	for (count = 0; count < nmedia_frus; count++) {
> +		wr_attrbs[count].ecs_log_cap = rd_attrbs[count].ecs_log_cap;
> +		wr_attrbs[count].ecs_config = rd_attrbs[count].ecs_config;
> +	}
> +
> +	/* Fill attribute to be set for the media FRU */
> +	switch (param_type) {
> +	case CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE:
> +		if (params->log_entry_type != ECS_LOG_ENTRY_TYPE_DRAM &&
> +		    params->log_entry_type != ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU) {
> +			dev_err(dev->parent,
> +				"Invalid CXL ECS scrub log entry type(%d) to set\n",
> +			       params->log_entry_type);
> +			dev_err(dev->parent,
> +				"Log Entry Type 0: per DRAM  1: per Memory Media FRU\n");
> +			return -EINVAL;
> +		}
> +		wr_attrbs[fru_id].ecs_log_cap = FIELD_PREP(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
> +							   params->log_entry_type);
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_THRESHOLD:
> +		wr_attrbs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK;
> +		switch (params->threshold) {
> +		case 256:
> +			wr_attrbs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_256);
> +			break;
> +		case 1024:
> +			wr_attrbs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_1024);
> +			break;
> +		case 4096:
> +			wr_attrbs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_4096);
> +			break;
> +		default:
> +			dev_err(dev->parent,
> +				"Invalid CXL ECS scrub threshold count(%d) to set\n",
> +				params->threshold);
> +			dev_err(dev->parent,
> +				"Supported scrub threshold count: 256,1024,4096\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_MODE:
> +		if (params->mode != ECS_MODE_COUNTS_ROWS &&
> +		    params->mode != ECS_MODE_COUNTS_CODEWORDS) {
> +			dev_err(dev->parent,
> +				"Invalid CXL ECS scrub mode(%d) to set\n",
> +				params->mode);
> +			dev_err(dev->parent,
> +				"Mode 0: ECS counts rows with errors"
> +				" 1: ECS counts codewords with errors\n");
> +			return -EINVAL;
> +		}
> +		wr_attrbs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_MODE_MASK;
> +		wr_attrbs[fru_id].ecs_config |= FIELD_PREP(CXL_MEMDEV_ECS_MODE_MASK,
> +							  params->mode);
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_RESET_COUNTER:
> +		wr_attrbs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_RESET_COUNTER_MASK;
> +		wr_attrbs[fru_id].ecs_config |= FIELD_PREP(CXL_MEMDEV_ECS_RESET_COUNTER_MASK,
> +							   params->reset_counter);
> +		break;
> +	default:
> +		dev_err(dev->parent, "Invalid CXL ECS parameter to set\n");
> +		return -EINVAL;
> +	}
> +	ret = cxl_set_feature(mds, set_pi, set_pi_size);
> +	if (ret) {
> +		dev_err(dev->parent, "CXL ECS set feature fail ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Verify attribute is set successfully */
> +	ret = cxl_mem_ecs_get_attrbs(dev, fru_id, &rd_params);
> +	if (ret) {
> +		dev_err(dev->parent, "Get cxlmemdev ECS params fail ret=%d\n", ret);
> +		return ret;
> +	}
> +	switch (param_type) {
> +	case CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE:
> +		if (rd_params.log_entry_type != params->log_entry_type)
> +			return -EFAULT;
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_THRESHOLD:
> +		if (rd_params.threshold != params->threshold)
> +			return -EFAULT;
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_MODE:
> +		if (rd_params.mode != params->mode)
> +			return -EFAULT;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
> +{
> +	struct cxl_mbox_supp_feat_entry feat_entry;
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +	int nmedia_frus;
> +	int ret;
> +
> +	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_ecs_uuid, &feat_entry);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!(feat_entry.attrb_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +		return -ENOTSUPP;
> +	nmedia_frus = feat_entry.get_feat_size/
> +				sizeof(struct cxl_memdev_ecs_feat_read_attrbs);
> +	if (nmedia_frus) {
> +		cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx), GFP_KERNEL);
> +		if (!cxl_ecs_ctx)
> +			return -ENOMEM;
> +
> +		cxl_ecs_ctx->nregions = nmedia_frus;
> +		cxl_ecs_ctx->get_feat_size = feat_entry.get_feat_size;
> +		cxl_ecs_ctx->set_feat_size = feat_entry.set_feat_size;
> +		cxl_ecs_ctx->region_id = region_id;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_ecs_init, CXL);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3e817a6f94c6..ca71ad403d62 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2912,6 +2912,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
>  				p->res);
>  	}
> +	cxl_mem_ecs_init(cxlmd, atomic_read(&cxlrd->region_id));

Check the return value and process accordingly.

Fan

>  
>  	put_device(region_dev);
>  out:
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 25c46e72af16..c255063dd795 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -986,9 +986,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  /* cxl memory scrub functions */
>  #ifdef CONFIG_CXL_SCRUB
>  int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
> +int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id);
>  #else
>  static inline int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
>  { return -ENOTSUPP; }
> +static inline int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
> +{ return -ENOTSUPP; }
>  #endif
>  
>  #ifdef CONFIG_CXL_SUSPEND
> -- 
> 2.34.1
> 

