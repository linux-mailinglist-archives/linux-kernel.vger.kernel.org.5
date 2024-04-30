Return-Path: <linux-kernel+bounces-164285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448008B7BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40862885C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E29175551;
	Tue, 30 Apr 2024 15:33:01 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06070BE49;
	Tue, 30 Apr 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491180; cv=none; b=J3asETyyHkmyGr4dLde1I3G7JOZF91tqUKG+LIMayz14fhaF1rv5bUCssLYJOJLvnkNO3pm4hx3A8LvTdf1lUH+nP661sZDbrgnSa5FkMudEagfzeys3gTJ6sg5wRdqqk2D0sSSkI5GKQ+4EGK5X4UNbTTdWa/O+w7YbCjPc8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491180; c=relaxed/simple;
	bh=UvCzRb6ahj4TK7FpRLDSQ3JR28xP0+x1n4eaXr2C6zU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCV7rUhPgon84gE3TN9HYcMw20pd/vc2lp9EB/lkRK9Orm1htLwunwJPrRL+LI1bM3G9NIujo2blkTEb6w+GKCmjwa5m9sNPx2RfqGsjAk/1OPtJslvzUWqTkhjvS2C87bplxIlC7fkCLd6OdmEQpxXLparSrKt6Bu8G246P/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTPK20bssz6J6Yb;
	Tue, 30 Apr 2024 23:30:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E7981400DC;
	Tue, 30 Apr 2024 23:32:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 16:32:54 +0100
Date: Tue, 30 Apr 2024 16:32:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v6 6/7] ACPI/NUMA: Add log messages for memory ranges
 found in CEDT
Message-ID: <20240430163253.00006c6e@Huawei.com>
In-Reply-To: <20240430092200.2335887-7-rrichter@amd.com>
References: <20240430092200.2335887-1-rrichter@amd.com>
	<20240430092200.2335887-7-rrichter@amd.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 11:21:59 +0200
Robert Richter <rrichter@amd.com> wrote:

> Adding a pr_info() when successfully adding a CFMWS memory range.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Hmm. I'm a bit doubtful this will work for other architectures
as arm64 at least has two sets of memblocks and the holes probably
want to go in memblock.reserved rather than in memblock.memory.
I think we would want to reflect where the extra memblks was added.

However. I'm not 100% sure on what that ends up like as I've not
written an appropriate numa_fill_memblks() yet, so I guess for
now it's fine here, and maybe it will get pushed into the arch
specific code when a second architecture implements numa_fill_memblks()
if some architectures want to return more detailed info.

So, I've argued myself around to
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan

p.s. Unrelated whitespace change but I guess can cope with that...

> ---
>  drivers/acpi/numa/srat.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 76b39a6d3aef..34ecf2dc912f 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -339,8 +339,12 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	 * window.
>  	 */
>  	modified = numa_fill_memblks(start, end);
> -	if (modified != NUMA_NO_MEMBLK)
> +	if (modified != NUMA_NO_MEMBLK) {
> +		if (modified)
> +			pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
> +				(unsigned long long) start, (unsigned long long) end - 1);
>  		return 0;
> +	}
>  
>  	/* No SRAT description. Create a new node. */
>  	node = acpi_map_pxm_to_node(*fake_pxm);
> @@ -355,8 +359,13 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
>  			node, start, end);
>  	}
> +
>  	node_set(node, numa_nodes_parsed);
>  
> +	pr_info("CEDT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
> +		node, *fake_pxm,
> +		(unsigned long long) start, (unsigned long long) end - 1);
> +
>  	/* Set the next available fake_pxm value */
>  	(*fake_pxm)++;
>  	return 0;


