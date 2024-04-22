Return-Path: <linux-kernel+bounces-153742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758C8AD296
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DDF1F21D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56526153BDC;
	Mon, 22 Apr 2024 16:43:33 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94515381C;
	Mon, 22 Apr 2024 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804212; cv=none; b=UzQvNZ4tKbOBUfOvT+51QDZXpVueDYaKVjAkk0/Y3ppZbFiNLRuVDJpVHNE3CQavc/WqRK6uUiby2BrMdqhcK9Dy7xxZPh8mKkMinbL4TPsuYAKhFIKEHR4aH3UJ0IBEHfSnI64IZa9dv9dznP+FP6RCiZpNq2lMqaziAOR1u4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804212; c=relaxed/simple;
	bh=ApwW11imVDo3/pCqZSgrElUYpztN4ObYHpPgr4iAaXA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2ycDG4OFilPrY+RRbSsyu+UEKygisoP0O+6JvLMAnb1Cj4MWvS4SkZXs3nXcZhwdbirO2bUd7oKpNkcgw0BjMbVfboQKlsyjVcVNTcXSbH/ctjYLXkE0FafvWXQAvLo22MC0UkrwFehFpCpd83NxsPMPplvAKwUeqSCLhkJjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNWGc2BLXz6JBRf;
	Tue, 23 Apr 2024 00:41:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E415140AB8;
	Tue, 23 Apr 2024 00:43:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 17:43:26 +0100
Date: Mon, 22 Apr 2024 17:43:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v3 2/5] ACPI/NUMA: Print CXL Early Discovery Table
 (CEDT)
Message-ID: <20240422174325.000058ba@Huawei.com>
In-Reply-To: <20240419140203.1996635-3-rrichter@amd.com>
References: <20240419140203.1996635-1-rrichter@amd.com>
	<20240419140203.1996635-3-rrichter@amd.com>
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

On Fri, 19 Apr 2024 16:02:00 +0200
Robert Richter <rrichter@amd.com> wrote:

> The CEDT contains similar entries as the SRAT. For diagnostic reasons
> print the CEDT same style as the SRAT.
> 
> Adding also a pr_info() when successfully adding a CFMWS memory range.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com> # CEDT node info
> Signed-off-by: Robert Richter <rrichter@amd.com>
Hi Robert,

Comments inline,

Jonathan


> ---
>  drivers/acpi/numa/srat.c | 122 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index e45e64993c50..43417b4920da 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -300,6 +300,114 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  	return -EINVAL;
>  }
>  
> +static int __init
> +__acpi_table_print_cedt_entry(union acpi_subtable_headers *__header,
> +			      void *arg, const unsigned long table_end)
> +{
> +	struct acpi_cedt_header *header = (struct acpi_cedt_header *)__header;

As below. There is very little shred by the different types in here, so
I'd break it up into separate functions and just call the relevant
one.

> +
> +	switch (header->type) {
> +	case ACPI_CEDT_TYPE_CHBS:
> +		{
> +			struct acpi_cedt_chbs *p =
> +				(struct acpi_cedt_chbs *)header;
> +
> +			if (header->length < sizeof(struct acpi_cedt_chbs)) {
sizeof(*p) perhaps?
> +				pr_warn("CEDT: unsupported CHBS entry: size %d\n",
> +					 header->length);
> +				break;
> +			}
> +
> +			pr_debug("CEDT: CHBS (0x%llx length 0x%llx uid %lu) %s (%d)\n",
> +				(unsigned long long)p->base,
> +				(unsigned long long)p->length,
> +				(unsigned long)p->uid,
> +				(p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) ?
> +				"cxl11" :
> +				(p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20) ?
> +				"cxl20" :
> +				"unsupported version",
> +				p->cxl_version);
> +		}
> +		break;
> +	case ACPI_CEDT_TYPE_CFMWS:
> +		{
> +			struct acpi_cedt_cfmws *p =
> +				(struct acpi_cedt_cfmws *)header;
> +			int eiw_to_ways[] = {1, 2, 4, 8, 16, 3, 6, 12};
> +			int targets = -1;
> +
> +			if (header->length < sizeof(struct acpi_cedt_cfmws)) {

sizeof(*p) perhaps?

> +				pr_warn("CEDT: unsupported CFMWS entry: size %d\n",
> +					header->length);
> +				break;
> +			}
> +
> +			if (p->interleave_ways < ARRAY_SIZE(eiw_to_ways))
> +				targets = eiw_to_ways[p->interleave_ways];
> +			if (header->length < struct_size(
> +					p, interleave_targets, targets))
> +				targets = -1;

Not a warning?

> +
> +			pr_debug("CEDT: CFMWS (0x%llx length 0x%llx) with %d target%s",
> +				(unsigned long long)p->base_hpa,
> +				(unsigned long long)p->window_size,
> +				targets, targets > 1 ? "s" : "");
> +			for (int i = 0; i < targets; i++)
> +				pr_cont("%s%lu", i ? ", " : " (",
> +					(unsigned long)p->interleave_targets[i]);

This seems odd. I don't think there is a good way to do combined pr_debug() and pr_cont()
There was a discussion about this a few years ago...

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
> +	case ACPI_CEDT_TYPE_CXIMS:
> +		{
> +			struct acpi_cedt_cxims *p =
> +				(struct acpi_cedt_cxims *)header;
> +
> +			if (header->length < sizeof(struct acpi_cedt_cxims)) {

sizeof(*p) perhaps?

> +				pr_warn("CEDT: unsupported CXIMS entry: size %d\n",
> +					header->length);
> +				break;

I'd go with direct returns in these to make the code flow easier to read.

> +			}
> +
> +			pr_debug("CEDT: CXIMS (hbig %u nr_xormaps %u)\n",
> +				(unsigned int)p->hbig,
> +				(unsigned int)p->nr_xormaps);
> +		}
> +		break;
> +	default:
> +		pr_warn("CEDT: Found unsupported entry (type = 0x%x)\n",
> +			header->type);
> +		break;
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

Would this be cleaner just breaking these up?

	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, print_chbs_entry, NULL);
	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, print_cfmws_entry, NULL);
	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS, print_cxims_entry, NULL);


> +}
> +
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  				   void *arg, const unsigned long table_end)
>  {
> @@ -318,8 +426,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	 * found for any portion of the window to cover the entire
>  	 * window.
>  	 */
> -	if (!numa_fill_memblks(start, end))
> +	if (!numa_fill_memblks(start, end)) {
> +		pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
> +			(unsigned long long) start, (unsigned long long) end - 1);
>  		return 0;
> +	}
>  
>  	/* No SRAT description. Create a new node. */
>  	node = acpi_map_pxm_to_node(*fake_pxm);
> @@ -334,13 +445,19 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
>  			node, start, end);
>  	}
> +

Unrelated changed.  Best to clean this out to avoid the (really minor) noise.

>  	node_set(node, numa_nodes_parsed);
>  
> +	pr_info("CEDT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
> +		node, *fake_pxm,
> +		(unsigned long long) start, (unsigned long long) end - 1);
> +
>  	/* Set the next available fake_pxm value */
>  	(*fake_pxm)++;
>  	return 0;
>  }
>  #else
> +static inline void acpi_table_print_cedt(void) {}
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  				   void *arg, const unsigned long table_end)
>  {
> @@ -526,6 +643,9 @@ int __init acpi_numa_init(void)
>  	/* SLIT: System Locality Information Table */
>  	acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
>  
> +	/* CEDT: CXL Early Discovery Table */
> +	acpi_table_print_cedt();
> +
>  	/*
>  	 * CXL Fixed Memory Window Structures (CFMWS) must be parsed
>  	 * after the SRAT. Create NUMA Nodes for CXL memory ranges that


