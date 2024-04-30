Return-Path: <linux-kernel+bounces-164360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B668B7CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211521C22543
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059A8178CD6;
	Tue, 30 Apr 2024 16:22:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140B176FB2;
	Tue, 30 Apr 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494161; cv=none; b=JDvzAarAcbfLK6AtenPLVEgVR3ofCnh6wqQER/ytjEUzeaibk0PyLVRrV6zV3k00L4KHMow2QlVgAN8MUvc/Vr5dDpVOTBwCwTVYnIv3rTCaC7R2YPCmNwSJ0i6B8IIoU3cmoN9RmSQW+bPpAWw0GVg4RHMadB07+FGcYT31l4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494161; c=relaxed/simple;
	bh=nHIY0JruljXXmK/rAV01B+Ul74H6SRPBbc8c8KF2kxg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUf05fOq+FIIvrL+fwrzcW4VO49aIKtkoi0oycTWKLO3rh6lp+o/JCEuQGE9rqkVBHqORQyAuzjCgqNS89hMFESj6/SXbWiIJW18GYyFeMGR4RY7KM8FN3ASIGupCfNDRe5suKJ7noAWbBwZ4a2NNfsxMxMIE8WZtRpcpACf4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTQQM6t17z6GCjQ;
	Wed,  1 May 2024 00:19:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 69784140B55;
	Wed,  1 May 2024 00:22:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 17:22:32 +0100
Date: Tue, 30 Apr 2024 17:22:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v6 7/7] ACPI/NUMA: Print CXL Early Discovery Table
 (CEDT)
Message-ID: <20240430172231.00002bd5@Huawei.com>
In-Reply-To: <20240430092200.2335887-8-rrichter@amd.com>
References: <20240430092200.2335887-1-rrichter@amd.com>
	<20240430092200.2335887-8-rrichter@amd.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 11:22:00 +0200
Robert Richter <rrichter@amd.com> wrote:

> The CEDT contains similar entries as the SRAT. For diagnostic reasons
> print the CEDT same style as the SRAT.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
I'm fairly sure the interleave ways conversion is wrong.
Otherwise all trivial stuff.

Jonathan

> ---
>  drivers/acpi/numa/srat.c | 111 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 34ecf2dc912f..fa21d4d5fccf 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -320,6 +320,114 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
>  	return 0;
>  }
>  
> +static int __init
> +__acpi_table_print_cedt_entry(union acpi_subtable_headers *__header,
> +			      void *arg, const unsigned long table_end)
> +{
> +	struct acpi_cedt_header *header = (struct acpi_cedt_header *)__header;
> +
> +	switch (header->type) {
> +	case ACPI_CEDT_TYPE_CHBS:
> +		{
> +			struct acpi_cedt_chbs *p =
> +				(struct acpi_cedt_chbs *)header;
> +
> +			if (header->length < sizeof(struct acpi_cedt_chbs)) {
> +				pr_warn("CEDT: unsupported CHBS entry: size %d\n",
> +					 header->length);
> +				break;

Might as well return.

> +			}
> +
> +			pr_debug("CEDT: CHBS (0x%llx length 0x%llx uid %lu) %s (%d)\n",
> +				(unsigned long long)p->base,
> +				(unsigned long long)p->length,

The printk docs https://docs.kernel.org/core-api/printk-formats.html
suggest you shouldn't need the casts though I appreciate other functions in here
are doing this.

> +				(unsigned long)p->uid,
> +				(p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) ?
> +				"cxl11" :
> +				(p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20) ?
> +				"cxl20" :
> +				"unsupported version",

That seems harsh.  Like all ACPI tables, these should be backwards compatible.
So not so much unsupported as "newer version".  Breakage happens, but it is rare
and for the rest of the kernel I don' think we check this.

Also can we switch to the 3.1 spec terms.  RCH etc. Though the term for 2.0+ in the
table definition for CHBS is the nasty:
"Host Bridge that is associated with one or more CXL root ports." 

> +				p->cxl_version);
> +		}
> +		break;

Trivial but I love early returns as they tend to avoid lots of scrolling to see where
the break goes and it is unlikely there will ever be anything to do after this.
 
> +	case ACPI_CEDT_TYPE_CFMWS:
> +		{
> +			struct acpi_cedt_cfmws *p =
> +				(struct acpi_cedt_cfmws *)header;
> +			int eiw_to_ways[] = {1, 2, 4, 8, 16, 3, 6, 12};
> +			int targets = -1;
> +
> +			if (header->length < sizeof(struct acpi_cedt_cfmws)) {
> +				pr_warn("CEDT: unsupported CFMWS entry: size %d\n",
> +					header->length);
> +				break;

Might as well return.

> +			}
> +
> +			if (p->interleave_ways < ARRAY_SIZE(eiw_to_ways))
> +				targets = eiw_to_ways[p->interleave_ways];

That looks wrong for 3, 6, 12 as index is 0x8, 0x9, 0xA not 5 6 7
Don't we have a function to decode this somewhere than can be reused?

> +			if (header->length < struct_size(
> +					p, interleave_targets, targets))
> +				targets = -1;
> +
> +			pr_debug("CEDT: CFMWS (0x%llx length 0x%llx) with %d target%s",
> +				(unsigned long long)p->base_hpa,
> +				(unsigned long long)p->window_size,
> +				targets, targets > 1 ? "s" : "");
> +			for (int i = 0; i < targets; i++)
> +				pr_cont("%s%lu", i ? ", " : " (",
> +					(unsigned long)p->interleave_targets[i]);
> +			pr_cont("%s%s%s%s%s%s\n",
> +				targets > 0 ? ")" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) ?
> +				" type2" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) ?
> +				" type3" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) ?
> +				" volatile" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM) ?
> +				" pmem" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED) ?
> +				" fixed" : "");
> +		}
> +		break;
return 

> +	case ACPI_CEDT_TYPE_CXIMS:
> +		{
> +			struct acpi_cedt_cxims *p =
> +				(struct acpi_cedt_cxims *)header;
> +
> +			if (header->length < sizeof(struct acpi_cedt_cxims)) {
> +				pr_warn("CEDT: unsupported CXIMS entry: size %d\n",
> +					header->length);
> +				break;
return
> +			}
> +
> +			pr_debug("CEDT: CXIMS (hbig %u nr_xormaps %u)\n",
> +				(unsigned int)p->hbig,
> +				(unsigned int)p->nr_xormaps);
> +		}
> +		break;
return
> +	default:
> +		pr_warn("CEDT: Found unsupported entry (type = 0x%x)\n",
> +			header->type);
> +		break;
return
> +	}
> +
> +	return 0;
> +}
> +
> +static void __init acpi_table_print_cedt_entry(enum acpi_cedt_type id)
> +{
> +	acpi_table_parse_cedt(id, __acpi_table_print_cedt_entry, NULL);
> +}
> +
> +static void __init acpi_table_print_cedt(void)
> +{
> +	/* Print only implemented CEDT types */
> +	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CHBS);
> +	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CFMWS);
> +	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CXIMS);
> +}
> +
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  				   void *arg, const unsigned long table_end)
>  {
> @@ -518,6 +626,9 @@ int __init acpi_numa_init(void)
>  	/* SLIT: System Locality Information Table */
>  	acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
>  
> +	/* CEDT: CXL Early Discovery Table */
> +	acpi_table_print_cedt();
> +
>  	/*
>  	 * CXL Fixed Memory Window Structures (CFMWS) must be parsed
>  	 * after the SRAT. Create NUMA Nodes for CXL memory ranges that


