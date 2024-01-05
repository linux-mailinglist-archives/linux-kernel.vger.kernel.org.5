Return-Path: <linux-kernel+bounces-17668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3668250F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5A71C22DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1F92420A;
	Fri,  5 Jan 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UANw19nm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8AE241F4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrWXQrau2wC/HtAdeb7VniXixpzfii60Lb27ZHahD3914UGUv4FHCZYxYr91gTXPFqlPm/y5KKLByJDVB5VcWgwvrocgEDvsG67Sz6Uk52Z0OFxrcol8V1YipE8QD4AgCr1VJgD1fB9w+/IBS+DnXN/r9XcTgPGm7oPvrcAM9iHckReKHWxvSFK9/9fNKYuRyHdOzKs7Tg6APxwLu/wEBqxtUxJ9vDd6+iH+QWTVXjzs53BgG+RKIYjj0yakHfQNr83NOdnF0xaAerHDXUIHAPFHK5z6W6WmltI/Pl7yUsGQO7uA/POjip5SlBoWmllVifHKzklOlb2tgf4i06s4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9rrwwJeKmFxJoHeXpV2sEnkUMJYcEVwJ70+NIhNCHE=;
 b=UGG0er1YcGMZpronte5DHoNi9uo6V39W223jYmPTkk+B/es84GYx+5DmI4iR91qx8OnFn7L5l1FcGL/16mkT8Mq7xD4gPmPiHWXBP9bAE+dfZ4ginErZzJozmFegwIB6lEPw0Y5+UX2EHqaHicu07HAD8W1oH0Ryp8n+DGhNeMzd4b4JUxqw6MAPrE46IyBa47avdBRmwpCTWz1gIhVBRryKocgwLnL5F+tWolozN7pt0gHkOTeONPUaXHAxqSL2opQpZBJ1WvhGO3/zgYwkFW23mHiOaxi2bYiVL159QzvSNiqVob02NDwd1rLxTitVy1E/CPxykK1KcPQIaC+Jvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9rrwwJeKmFxJoHeXpV2sEnkUMJYcEVwJ70+NIhNCHE=;
 b=UANw19nmjIfvOUj6PCKTuWt1UxSK78xF45wTsL9XVCGOt+FR6BwDc9oXwwXLQvDFZavT0+Haipmv5meckYvBnrN43vi6U2xR38ijFeKbKliBvMptMreso60Ba1piYCCR8SaeoViIRFyFbfEnqaO+ZUUCh7rhBSRnrx4IgsIaafE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 09:38:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 09:38:27 +0000
Message-ID: <e4952a68-82aa-4336-b287-7d03ed925a2e@amd.com>
Date: Fri, 5 Jan 2024 10:38:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/gntdev: Fix the abuse of underlying struct page in
 DMA-buf import
Content-Language: en-US
To: Oleksandr Tyshchenko <olekstysh@gmail.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Daniel Vetter <daniel@ffwll.ch>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>
References: <20240104185327.177376-1-olekstysh@gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240104185327.177376-1-olekstysh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 39277d24-9b81-41a9-974a-08dc0dd211b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ShCTAvQh9CC68/CDlerQGYGWdpkOzI0rXNn59m4RKfiJH4Z9aDIOwojN3sdOXlRK24zYngnanOVvwAwNtvds4Veu9cW29BEk3HN0iIsbGfcV7U1S26JPiCmRZ2T2KItWH9+KAIJjgSlVBwXbuwL1Q6Rd+G29YoTFVX2IJlE+7eEYPakw6ohFKGuR/FKe9Qc3yUtFmtmGqOhZWcfLIOxmKwvgQA1dL2oBuhBlw7IzL7yCEYlmN4KB7Rd9jUJReLORh8PPHbfJiVwALi7Jy+M44CM2zIxasEWGCtRpi6iD5ppzCodw97Z4Mq/SC/t5J5EZPVCm9LKuc29++JdriIlWtFKqbgEXzgev3CAA+GFTyhG/9BjBAweghxBhpt4ZfNZcsEFUcN9IC5PrqZ5kXCcUSxbWbb4hYLb3kX0MKnh4oafutxAKmOAHG8Af7E4YwYe2Vji8X/JofPLplO6pm5GFunhZHW47OI13ePPwzt4rIn/5cnPng/1A4pc84nCjjNCezQK/OHjLRclrBeNqRmiA01mvFN30oyl9VaEtcV8W/b3iSxzl6zZ4JXwl8JOcDP+TMT7HeYR7PmRpyTfR72JSpcZdgTyU2jofmsjvHati1xpNl1A20HXtU6OcaUqr4NRcAw/wNj6Ioh9aApr+eD74SQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2906002)(478600001)(5660300002)(4326008)(6666004)(41300700001)(316002)(54906003)(36756003)(66556008)(66946007)(66476007)(6486002)(6506007)(8936002)(8676002)(6512007)(2616005)(86362001)(31696002)(26005)(83380400001)(66574015)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUdMQzNkZnk2cWRGNVFhYU1jbzVUZzFjVW1RQ3J6dlBpK0c5ZEQyN2wrYmFC?=
 =?utf-8?B?UXBOVkQxekhMRjQ4czNFQnBsY1BsMDdCZXhIdjdUbzk4OXlRUkhnM0xBak5i?=
 =?utf-8?B?OTZqT3NLYTVLZm1nVmNyZXplNDV3M3V3NGMrbFMvQllWQ2x5c3hXTWpuZzNt?=
 =?utf-8?B?UkhtQXI1V1VZZm1SQndQRW5UT3ltUGNodGdpVGpma0g3Ky85aTFxTzN3VVJN?=
 =?utf-8?B?Q3hMLzl5NG9aVFh4ZVl0ZkdvUjBCaEl2dTcyZlhWVzljTVdTREpuSEVoZlRp?=
 =?utf-8?B?dGF0UGkyQ2xySGdCNm02eXBqYlcvVHZxcktac0VVSVNLNENHalJrYnBiNE8y?=
 =?utf-8?B?Zy9za1VKeGl0TnJ0YmxCQnl5TE9PaktKTHg2RG1RYWI0UkIxR05jbWlIU3ha?=
 =?utf-8?B?UVBIM2M4NTI2TlJWbnFqTEJOK0FZdGxUQ0R0bG1ia1RiUW53b1ZnOGs1azNL?=
 =?utf-8?B?TjdLRWFVSEg0Mm56VFlJNDNMVmwwYmNMc3J3VU9hUkJLV3A1SDBWNWljaW1O?=
 =?utf-8?B?R1FBU3IzOHZnVXcrdklzbU9pY3dwRDJKTjE2eEJvaHdNdmRCTkNsb3REMGZD?=
 =?utf-8?B?ZHVVWFV5ckNJd1pIaXpTa0RuZmcrU28rQ1NYM2prN1FLelNvQkpoWmlaRElI?=
 =?utf-8?B?YnlrbkkwZGFXUW5kYlhHR1dwMXNESjFjR3FNakY5NmJNeXBYWmUwVDBmTkYr?=
 =?utf-8?B?S3JsbUZ2YThwRlhyUkQ0bGdrdXVYcEg4S1pqOXNqRmJZZnhsb3ZwTy9ZTmh2?=
 =?utf-8?B?d2FQaGh5RmlUS1JNcFFSbTloeThiVzhmSFNzTE5PTlA4VE95MXlCTm03ZStz?=
 =?utf-8?B?eUg0OWo4aDRqZnB3NllPdFpJVG9qTHVZQUFIZ21ILzVVYVNEd1BGdm80UlFV?=
 =?utf-8?B?aDRTRW1iUldzN1ByZUpVK01yZEFjR0p0U3l6a1EzKzNyWkRraG9oOHBhb2V3?=
 =?utf-8?B?cUt4OTB0cFFLalpENnJheXA0MUV3M0xrV2MrWmZOUVBjUG9vTDN2OE1ldDVp?=
 =?utf-8?B?clBnSmNEQWowd1dCdHpTbVZSMyswemJySmpwVG5YS3NxeFNYZ2J0Ynkxek03?=
 =?utf-8?B?bXg1VFNlb1EyRFZNN3JXQ1YyL1Z0MmgzMzdUU2lTNzJPQ3MrYzlTZzNueTZu?=
 =?utf-8?B?eXZhYmZJWk82UkhqcFM4Q1ZNcmZxKzZGUEplcC92TlR4QmZuN3g4TDMvMUda?=
 =?utf-8?B?REwvU2hYRHg3Vks3NVNNQm1jVm84Q245N05LazBFR3B3UkkyaExhejRXaFpW?=
 =?utf-8?B?UWdIRjZSQitjcFBPZDRlSFhOMGNGVkZNQ0lab1VQcjNqWE5PTmZUTkhCQ1Jh?=
 =?utf-8?B?d2NnRnRTOXJRYzQ2TXRoNE0rTHNWVHJmOCtUeUY1YkcrLzc5K1oxSEt4a2ho?=
 =?utf-8?B?T2t3eEkrK1VsZ3VBaStZdUEzSFlqdHVKd1d1bkIrSHdoTzlNYVdCZEY5QjQ0?=
 =?utf-8?B?bytzT0FWVGhVQ3ZoMkthY2JGalpRSHp5YWtPM0tuS29vZjZ3UTduajdNbVA0?=
 =?utf-8?B?bWlVUzRYb3FwVEl5MkZrbGNtd0lRa1VVY3U5NmVBSEdBbFI3Q1pvbGp3TGhV?=
 =?utf-8?B?S1Z4SmRvaWN4QkI0SDJNUmxjTHR0VGtOUTZaRmxwOURGMEdvOHRDd2ducDhN?=
 =?utf-8?B?RG02MEFZcGNLQXJpOU5ObEVoa25LZjB1K0RrVU4wd2lubkpCb2llMmZnVXhW?=
 =?utf-8?B?S2x4SFY3VVYyMXJaU2NncHFmWktLSHBWUUc4UlpiSFlxN2ZlZENtR1dJcjRV?=
 =?utf-8?B?Qnlubm83aTB4VDdjV3ZZOWtObnlhclZSK2J2YWYxNXBBTUIxRkZEOGFsT3JQ?=
 =?utf-8?B?b0hJd0d2bTFnc0pYVFVVaFJBWVhRclNZdWtNUU1uRmRvRHpRVjVscFlLdXFF?=
 =?utf-8?B?S2ZpaHBKV2dYSTBQdlJGK3ZVTmp6L2I1aTlPL1NWdVNrTnRaZGhvT2NURmY5?=
 =?utf-8?B?UWRnV2M5cWxteW9tK2NOT2VKWFkyMWJPRmdwZTlBU1l3UCtUbkE1UndYUHM3?=
 =?utf-8?B?d3RaRmNPVlBvcDh5blBQL2ZsdHViVU9CMjdVMmJmTnJRSGp2VWtFeC9TeWh3?=
 =?utf-8?B?WjI1Z3krYWtaYVYxSnFocUcxVzRUTFpsRUNWQWZhSFlFOTBxSFUzRDR4Y2xy?=
 =?utf-8?Q?HaxBhl8ino7hjLF3Ny2TNowZv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39277d24-9b81-41a9-974a-08dc0dd211b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 09:38:27.2320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sx6wQNRUOA57ZlltYcOl15bFQ1R4WESeZzqDIZ6t1PpMe8hlDf47Khx7obfbOS3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488

Am 04.01.24 um 19:53 schrieb Oleksandr Tyshchenko:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>
> DO NOT access the underlying struct page of an sg table exported
> by DMA-buf in dmabuf_imp_to_refs(), this is not allowed.
> Please see drivers/dma-buf/dma-buf.c:mangle_sg_table() for details.
>
> Fortunately, here (for special Xen device) we can avoid using
> pages and calculate gfns directly from dma addresses provided by
> the sg table.
>
> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

I can't say that I can judge the full technical background, but that 
looks reasonable to me.

Acked-by: Christian König <christian.koenig@amd.com>

> ---
> Please note, I didn't manage to test the patch against the latest master branch
> on real HW (patch was only build tested there). Patch was tested on Arm64
> guests using Linux v5.10.41 from vendor's BSP, this is the environment where
> running this use-case is possible and to which I have an access (Xen PV display
> with zero-copy and backend domain as a buffer provider - be-alloc=1, so dma-buf
> import part was involved). A little bit old, but the dma-buf import code
> in gntdev-dmabuf.c hasn't been changed much since that time, all context
> remains allmost the same according to my code inspection.
> ---
> ---
>   drivers/xen/gntdev-dmabuf.c | 42 +++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
> index 4440e626b797..0dde49fca9a5 100644
> --- a/drivers/xen/gntdev-dmabuf.c
> +++ b/drivers/xen/gntdev-dmabuf.c
> @@ -11,6 +11,7 @@
>   #include <linux/kernel.h>
>   #include <linux/errno.h>
>   #include <linux/dma-buf.h>
> +#include <linux/dma-direct.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
>   #include <linux/uaccess.h>
> @@ -50,7 +51,7 @@ struct gntdev_dmabuf {
>   
>   	/* Number of pages this buffer has. */
>   	int nr_pages;
> -	/* Pages of this buffer. */
> +	/* Pages of this buffer (only for dma-buf export). */
>   	struct page **pages;
>   };
>   
> @@ -484,7 +485,7 @@ static int dmabuf_exp_from_refs(struct gntdev_priv *priv, int flags,
>   /* DMA buffer import support. */
>   
>   static int
> -dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
> +dmabuf_imp_grant_foreign_access(unsigned long *gfns, u32 *refs,
>   				int count, int domid)
>   {
>   	grant_ref_t priv_gref_head;
> @@ -507,7 +508,7 @@ dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
>   		}
>   
>   		gnttab_grant_foreign_access_ref(cur_ref, domid,
> -						xen_page_to_gfn(pages[i]), 0);
> +						gfns[i], 0);
>   		refs[i] = cur_ref;
>   	}
>   
> @@ -529,7 +530,6 @@ static void dmabuf_imp_end_foreign_access(u32 *refs, int count)
>   
>   static void dmabuf_imp_free_storage(struct gntdev_dmabuf *gntdev_dmabuf)
>   {
> -	kfree(gntdev_dmabuf->pages);
>   	kfree(gntdev_dmabuf->u.imp.refs);
>   	kfree(gntdev_dmabuf);
>   }
> @@ -549,12 +549,6 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
>   	if (!gntdev_dmabuf->u.imp.refs)
>   		goto fail;
>   
> -	gntdev_dmabuf->pages = kcalloc(count,
> -				       sizeof(gntdev_dmabuf->pages[0]),
> -				       GFP_KERNEL);
> -	if (!gntdev_dmabuf->pages)
> -		goto fail;
> -
>   	gntdev_dmabuf->nr_pages = count;
>   
>   	for (i = 0; i < count; i++)
> @@ -576,7 +570,8 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
>   	struct dma_buf *dma_buf;
>   	struct dma_buf_attachment *attach;
>   	struct sg_table *sgt;
> -	struct sg_page_iter sg_iter;
> +	struct sg_dma_page_iter sg_iter;
> +	unsigned long *gfns;
>   	int i;
>   
>   	dma_buf = dma_buf_get(fd);
> @@ -624,26 +619,23 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
>   
>   	gntdev_dmabuf->u.imp.sgt = sgt;
>   
> -	/* Now convert sgt to array of pages and check for page validity. */
> +	gfns = kcalloc(count, sizeof(*gfns), GFP_KERNEL);
> +	if (!gfns)
> +		goto fail_unmap;
> +
> +	/* Now convert sgt to array of gfns without accessing underlying pages. */
>   	i = 0;
> -	for_each_sgtable_page(sgt, &sg_iter, 0) {
> -		struct page *page = sg_page_iter_page(&sg_iter);
> -		/*
> -		 * Check if page is valid: this can happen if we are given
> -		 * a page from VRAM or other resources which are not backed
> -		 * by a struct page.
> -		 */
> -		if (!pfn_valid(page_to_pfn(page))) {
> -			ret = ERR_PTR(-EINVAL);
> -			goto fail_unmap;
> -		}
> +	for_each_sgtable_dma_page(sgt, &sg_iter, 0) {
> +		dma_addr_t addr = sg_page_iter_dma_address(&sg_iter);
> +		unsigned long pfn = bfn_to_pfn(XEN_PFN_DOWN(dma_to_phys(dev, addr)));
>   
> -		gntdev_dmabuf->pages[i++] = page;
> +		gfns[i++] = pfn_to_gfn(pfn);
>   	}
>   
> -	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gntdev_dmabuf->pages,
> +	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gfns,
>   						      gntdev_dmabuf->u.imp.refs,
>   						      count, domid));
> +	kfree(gfns);
>   	if (IS_ERR(ret))
>   		goto fail_end_access;
>   


