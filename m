Return-Path: <linux-kernel+bounces-73129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B4985BDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B875FB25F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BAD6A8C6;
	Tue, 20 Feb 2024 13:58:33 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F3B5F875;
	Tue, 20 Feb 2024 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437513; cv=none; b=RlRdQ7k5CiDKTMztOLnVKXasHo3XCVHvMVRBOdz5CzYrajtX6KhI0pfs18hSQsoXTGLHlXrTf+Tv30+xVyTHScZhxJEO3v15JvD+ylfeFhYk11doMBajEPG119aMz3f/HKyihQNQ6C7CplOE+ytYHwbRffjX7IEJmagrEyGY+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437513; c=relaxed/simple;
	bh=2jZ1Zn0GEruFDEKcPjM7bIQpXDdfiaGStAVOT5f5KoA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vlc4SqojyjfkklmAXNfa0MzMNp37prDOWpzCfEMf+4qJhhHLDEe1+lUfpxYxe51cznQ19ADAoih0JN0Ce/d624YbI+6pZaLpzkzSyubd21crwIHUrHvkgd5+aOddSS0ahjGOrTGhMZAtz6TGmK+bG7n/hMhRnnvo8FKUfYdL+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfLVr44Qwz6K6LW;
	Tue, 20 Feb 2024 21:54:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 49F37140B30;
	Tue, 20 Feb 2024 21:58:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 13:58:27 +0000
Date: Tue, 20 Feb 2024 13:58:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>
Subject: Re: [RFC PATCH v6 10/12] ACPICA: ACPI 6.5: Add support for RAS2
 table
Message-ID: <20240220135826.000005e9@Huawei.com>
In-Reply-To: <20240215111455.1462-11-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<20240215111455.1462-11-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 19:14:52 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for ACPI RAS2 feature table(RAS2) defined in the ACPI 6.5
> Specification & upwards revision, section 5.2.21.
> 
> The RAS2 table provides interfaces for platform RAS features. RAS2 offers
> the same services as RASF, but is more scalable than the latter.
> RAS2 supports independent RAS controls and capabilities for a given RAS
> feature for multiple instances of the same component in a given system.
> The platform can support either RAS2 or RASF but not both.
> 
> Link: https://github.com/acpica/acpica/pull/899

It merged in October.  Rafael, can we get this into the kernel version
so we don't have a dependency in this patch set?

Thanks,

Jonathan



> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  include/acpi/actbl2.h | 137 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 9775384d61c6..15c271657f9f 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -47,6 +47,7 @@
>  #define ACPI_SIG_PPTT           "PPTT"	/* Processor Properties Topology Table */
>  #define ACPI_SIG_PRMT           "PRMT"	/* Platform Runtime Mechanism Table */
>  #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
> +#define ACPI_SIG_RAS2           "RAS2"	/* RAS2 Feature table */
>  #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
>  #define ACPI_SIG_RHCT           "RHCT"	/* RISC-V Hart Capabilities Table */
>  #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
> @@ -2751,6 +2752,142 @@ enum acpi_rasf_status {
>  #define ACPI_RASF_ERROR                 (1<<2)
>  #define ACPI_RASF_STATUS                (0x1F<<3)
>  
> +/*******************************************************************************
> + *
> + * RAS2 - RAS2 Feature Table (ACPI 6.5)
> + *        Version 2
> + *
> + *
> + ******************************************************************************/
> +
> +struct acpi_table_ras2 {
> +	struct acpi_table_header header;        /* Common ACPI table header */
> +	u16 reserved;
> +	u16 num_pcc_descs;
> +};
> +
> +/*
> + * RAS2 Platform Communication Channel Descriptor
> + */
> +
> +struct acpi_ras2_pcc_desc {
> +	u8 channel_id;
> +	u16 reserved;
> +	u8 feature_type;
> +	u32 instance;
> +};
> +
> +/*
> + * RAS2 Platform Communication Channel Shared Memory Region
> + */
> +
> +struct acpi_ras2_shared_memory {
> +	u32 signature;
> +	u16 command;
> +	u16 status;
> +	u16 version;
> +	u8 features[16];
> +	u8 set_capabilities[16];
> +	u16 num_parameter_blocks;
> +	u32 set_capabilities_status;
> +};
> +
> +/* RAS2 Parameter Block Structure Header */
> +
> +struct acpi_ras2_parameter_block {
> +	u16 type;
> +	u16 version;
> +	u16 length;
> +};
> +
> +/*
> + * RAS2 Parameter Block Structure for PATROL_SCRUB
> + */
> +
> +struct acpi_ras2_patrol_scrub_parameter {
> +	struct acpi_ras2_parameter_block header;
> +	u16 patrol_scrub_command;
> +	u64 requested_address_range[2];
> +	u64 actual_address_range[2];
> +	u32 flags;
> +	u32 scrub_params_out;
> +	u32 scrub_params_in;
> +};
> +
> +/* Masks for Flags field above */
> +
> +#define ACPI_RAS2_SCRUBBER_RUNNING      1
> +
> +/*
> + * RAS2 Parameter Block Structure for LA2PA_TRANSLATION
> + */
> +
> +struct acpi_ras2_la2pa_translation_parameter {
> +	struct acpi_ras2_parameter_block header;
> +	u16 addr_translation_command;
> +	u64 sub_instance_id;
> +	u64 logical_address;
> +	u64 physical_address;
> +	u32 status;
> +};
> +
> +/* Channel Commands */
> +
> +enum acpi_ras2_commands {
> +	ACPI_RAS2_EXECUTE_RAS2_COMMAND = 1
> +};
> +
> +/* Platform RAS2 Features */
> +
> +enum acpi_ras2_features {
> +	ACPI_RAS2_PATROL_SCRUB_SUPPORTED = 0,
> +	ACPI_RAS2_LA2PA_TRANSLATION = 1
> +};
> +
> +/* RAS2 Patrol Scrub Commands */
> +
> +enum acpi_ras2_patrol_scrub_commands {
> +	ACPI_RAS2_GET_PATROL_PARAMETERS = 1,
> +	ACPI_RAS2_START_PATROL_SCRUBBER = 2,
> +	ACPI_RAS2_STOP_PATROL_SCRUBBER = 3
> +};
> +
> +/* RAS2 LA2PA Translation Commands */
> +
> +enum acpi_ras2_la2pa_translation_commands {
> +	ACPI_RAS2_GET_LA2PA_TRANSLATION = 1
> +};
> +
> +/* RAS2 LA2PA Translation Status values */
> +
> +enum acpi_ras2_la2pa_translation_status {
> +	ACPI_RAS2_LA2PA_TRANSLATION_SUCCESS = 0,
> +	ACPI_RAS2_LA2PA_TRANSLATION_FAIL = 1
> +};
> +
> +/* Channel Command flags */
> +
> +#define ACPI_RAS2_GENERATE_SCI          (1<<15)
> +
> +/* Status values */
> +
> +enum acpi_ras2_status {
> +	ACPI_RAS2_SUCCESS = 0,
> +	ACPI_RAS2_NOT_VALID  = 1,
> +	ACPI_RAS2_NOT_SUPPORTED = 2,
> +	ACPI_RAS2_BUSY = 3,
> +	ACPI_RAS2_FAILED = 4,
> +	ACPI_RAS2_ABORTED = 5,
> +	ACPI_RAS2_INVALID_DATA = 6
> +};
> +
> +/* Status flags */
> +
> +#define ACPI_RAS2_COMMAND_COMPLETE      (1)
> +#define ACPI_RAS2_SCI_DOORBELL          (1<<1)
> +#define ACPI_RAS2_ERROR                 (1<<2)
> +#define ACPI_RAS2_STATUS                (0x1F<<3)
> +
>  /*******************************************************************************
>   *
>   * RGRT - Regulatory Graphics Resource Table


