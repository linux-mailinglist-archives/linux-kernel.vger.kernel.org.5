Return-Path: <linux-kernel+bounces-151852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E888AB4BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC7F2839DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C9F13BAFC;
	Fri, 19 Apr 2024 18:06:53 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44550130AC4;
	Fri, 19 Apr 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550013; cv=none; b=fmBVg7wy7AyYjGOUiEl65+uGunbk7ZoAWpkHJmJy1/LodO0KvdHP322sSDo5AwZpYDpwSeO+13/8HqvApGGAhdnCIT1yuCpV+0y+lIm1twpNyp35P4efSsmqtLkkuCHQm1TcTJ9zkdhMPckbkHctWGndYRplaliglqbqYlLy31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550013; c=relaxed/simple;
	bh=g6h4liwRb6pLZ6FcdagGwL8SquGArFkeky/4BcIbLcs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngfVmq4WyA+kioPq+FjWyTpqW0JmXq2gW/X8/wAOi9QIWtrIeEkvf/f2ijw8XKaxoHG68yp1PZ5FoPVC8uRNMhuAjNd01oDAATnMbF+tDesXyHrDol7cvwrc5NWRt+gw7qQx6yrtm7TyMOBUy22sj7cDmXb7+LfWky6VFa2w2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLjGG1Ljkz6JBHw;
	Sat, 20 Apr 2024 02:04:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 50007140447;
	Sat, 20 Apr 2024 02:06:44 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 19:06:43 +0100
Date: Fri, 19 Apr 2024 19:06:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v8 06/10] ACPICA: Add __free() based cleanup
 function for acpi_put_table
Message-ID: <20240419190642.00005ee7@huawei.com>
In-Reply-To: <20240419164720.1765-7-shiju.jose@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
	<20240419164720.1765-7-shiju.jose@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 20 Apr 2024 00:47:15 +0800
<shiju.jose@huawei.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add __free() based cleanup function for acpi_put_table.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---

Reviewing (and rejecting) my own patch time ;(

I was thinking this would be useful more widely but hadn't looked
as closely as I should have done.  Sorry Shiju for sending you
down a bad path.

>  include/acpi/acpixf.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 3d90716f9522..fc64d903a703 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -492,6 +492,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>  					    **out_table))
>  ACPI_EXTERNAL_RETURN_VOID(void acpi_put_table(struct acpi_table_header *table))
>  
> +DEFINE_FREE(acpi_put_table, struct acpi_table_header *, if (!IS_ERR_OR_NULL(_T)) acpi_put_table(_T))

This is reliant on acpi_get_table2() in patch 8 / below being used as acpi_get_table()
doesn't return the table.

Maybe we are better off treating acpi_get_table() / acpi_put_table() as if it were a
conditional lock? Or change the 93 instances of acpi_get_table to deal with it returning
a copy of the table handle pointer

That would bring it inline with many other get functions in the kernel + make our life
easier using tooling like this.


+static struct acpi_table_header *acpi_get_table2(acpi_string signature,
+						  u32 instance)
+{
+	struct acpi_table_header *header = NULL;
+	acpi_status status = acpi_get_table(signature, instance, &header);
+
+	if (ACPI_FAILURE(status))
+		return ERR_PTR(-EINVAL);
+
+	return header;
+}
So that we could do things like:
+	struct acpi_table_header *pAcpiTable __free(acpi_put_table) =
+						acpi_get_table2("RAS2", 0);

and avoid having to call acpi_put_table() in error paths etc.

The snag is that acpi_get_table() is from acpica (via this wrapper) so any
modification would be a little messy. Also a number of cases use the status
value via 
const char *msg = acpi_format_exception(status);

Which we'd need to return via some path (a parameter probably). We 'could'
do that but the advantages of this are getting eroded.

Upshot, this is messier than I thought, so we probably shouldn't do it.

The code in ras2 can be done reasonably neatly an outer wrapper function
that gets the table and an inner one that deals with the actual processing
of the entries.

Pity as there are some messy bits of code this would tidy up. In most of
those a helper function also works.

Jonathan

p.s. Whilst looking at this I noticed that acpi_has_watchdog() if it
succeeds doesn't put the wdat table which seems suspicious as a side
effect.

> +
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>  			    acpi_get_table_by_index(u32 table_index,
>  						    struct acpi_table_header


