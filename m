Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1527F5CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbjKWKne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjKWKnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:43:32 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2044.outbound.protection.outlook.com [40.92.65.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D56F91
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:43:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7Is2B711xsM7AsoW6LgXbCOGiitm3PR/5AtPpNoVZMHG8kpd36ACG99gtDozBmjTPHVD3Jht1VHRiH6+n+ZQlLE3ZNaDV9S/aY9Lrc6tZTp2YdTO9GUKihvbvc9G8C2ngwyH/G7Caftd5My44cws0pGCfmWXnNvQyT9jemf1yU0IPzLdxGVrSdMnZmguiQ5YhM3QNcrjKLTNQLM3Xuhv64PjLTl371DmaZmqiYklt4ZL1sKq0Hte4xM79inguvn/thXkM1O3lEpJsnK9BHdEydgh3N/NB7/OWa30CJ1S818FLJ0QFU1lbLXsu9bEi8UyVxbm4rf7HRE6HI8C7AFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtq/gP9vzhS5ZH2EQ8Z6dBLM+TMKjqUd/6kxXj+JCIM=;
 b=QpIzwumaASt0o4W72/vpEMO1i3a1c3HBDO0IiAjjh/IvzBCuC+0KsVgSlLxaNE9ZvounlWVAC03u83B8jn0b951NTJnHN2fW/Zk1zUDmMeY8SAsQJ6IlMqetvCC24CsYRP7TOMvURMGtQ/kCvoXvdk4cFtWOpXB2tkwOdUt4FXndnGb7RROzR4SB7+8zKjgF8XWsCMPnCt0o1EGkAlnjzf8hsCrcquBDJvPEZ34KnvFZl4aH/mmxMixX3mr6F1xAsnAalamKqGUQfRYyLHlQjHsp5hOH6aJI0MVOOjZtDxofxl4kQXGQyDPiUIvNFuA8FLCPv3JGwacEzbP0XkBSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtq/gP9vzhS5ZH2EQ8Z6dBLM+TMKjqUd/6kxXj+JCIM=;
 b=q5w0faRQbTq/7/EwM1zOqT828Ktwcqr83599rMZyitsmg7tWXsxBJzr+P60cEZV2ZArHLHcbBh/FsrwZ3xvsg8LLuAjCDYf5SyzCsmOCXi8nKMmSb+9nfmYt59JZ8Jircvils3jKl1Jh4lTXrzgesAw9SCOhvqDCr+X+E+D6SGaBpCE5a6JpdnBEP1jKKfMmH72Jup/jRANZEEKlqhxbZURvsetECdrQ9SqH/uBIOUzx/xPvoH5ZiQXH/qJpL88p1kmeMFztqCmOEdvd9jyJu71KNgWCNF1qFckk/DAq8CUrH3NYVhAiNiWIOweJMTQJAEEst516xY0KQ1bsfJ4zQA==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by AM9P193MB1538.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 10:43:34 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%5]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 10:43:34 +0000
Message-ID: <VI1P193MB0752282E559B37F12EB7982599B9A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Thu, 23 Nov 2023 18:43:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kasan: Improve free meta storage in Generic KASAN
From:   Juntong Deng <juntong.deng@outlook.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <VI1P193MB0752675D6E0A2D16CE656F8299BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB0752675D6E0A2D16CE656F8299BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [y+AJZN+LgyNNwKrZLok32T3ixUxqFqPj]
X-ClientProxiedBy: LO4P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::13) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <fa4c1001-824a-4e66-9655-82dec14fceb0@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|AM9P193MB1538:EE_
X-MS-Office365-Filtering-Correlation-Id: d634fd0d-0787-46a7-45d2-08dbec110ac8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKh4Hg0bN09HJAmy5lgfTO8zQldsU1Zf4AfG5sCpfXbsYVLBMfrlyf55Wd45GwDOW01HzvRBlxShsi3RkKITduVDoRhgt5sG6TDEoijV60fJ1EFkudhu8SxgIW4zWOk8vUQ5VbkiPnoCWMCX0shAHwnX/lbBqmetKarl7zL2+HZC3nuFe+Fa/Mqnzb392zRQtz0ax+kri6puNdPRmdecnulxs5huUoRzDnO3XSoRmyl9jXuikioujtitYzK4JE/gKuhnsBmDYkwuk64hPY6goF1YMIW9z84JsUPj13qJJqMV+Ff7kXThw/phwBCyT7qgLYYpYbqLVOYcURg8+7Kq7C4OCvO+5slkac2LUHBXiENR0c9RyZsoHdKM32izyyqdI1M66hRvSdGla2Pqv4V5QLmCEjJxWjxxRGa3G5Mv2UCmSDgKEhyT+9PExlPTt9qvc6tcc2cSczfPCz9f5d44R9DDJ/SW3CR6HFYuwcoYM2l8gzCkF8ChV7XAVmfP2NO+STTp1TVUjOvdiVO9ffkKKjFFY+hT/zI6RhFlITdqiYeu5jBhZvV6w6UTOMOHEeHz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnJiZUVIN05SYTdQUHc4WHppU2RJRmJMdWNUTlBMVVJTKzVnR0F6TUNXVlFL?=
 =?utf-8?B?NHFCWjhQTFlucHZnQ2VEaGZSZnRRWkNKRUc4eHovN1VUQWFNbE9ZbUFlOUJZ?=
 =?utf-8?B?d1YvanpCRzN6UEh2TTRtVzVKb3R6bzZHTzF6cnZ2dXJMOFF0VmY3bzVsV0do?=
 =?utf-8?B?cTVoNWxtSDh4SGR5MDdGMEh2V3AzcmI0RlpvNXFVQnpxaTZMeVRidUZLWnkv?=
 =?utf-8?B?RkJvYWk1RGg0bUNybkFjcW40MjhEM1FSYWUzQzV5dlNiTkhlT2d1d1pSMWtu?=
 =?utf-8?B?MHhuUHpsWU9VRmplWTBNMVFTeGZuamo2Y1hvWVM2UmtnVlAwZ3J6cVE2UnNW?=
 =?utf-8?B?a2Z2VlI2eGFWNE5QVHQwLzh0NFQzQzkwR2xNQmVHaUsxaEkvS3c5cHNIM2JU?=
 =?utf-8?B?b2gyemh5ZUhhMUVXYUhxUHRHWG90RTAwM0tjVVY0bURrQUlQRmZZUUFoQVlH?=
 =?utf-8?B?VUhINW9CeGs5N0w3bEU0MnlKRkZrSmpoRlUycmRwUGw5TDhRNHVXaGpJTXZS?=
 =?utf-8?B?SGNYUUtwQjZ4bVB1UWZzSEI1Q0RnUjZaV0x2cjI3a2NWQStnUU5VUTNaNm83?=
 =?utf-8?B?dHNQMXJxZ25HZXZVS1VETDJBRi9UTVMraHNHc0pDUTIvdjZTOEoxTFFVUVlD?=
 =?utf-8?B?c2dLTFFPWGRQeUNheUFJT005RnZlR0oydXh6RDB2a3I2V1hnZjU5MUFsSlA4?=
 =?utf-8?B?dmIxUUREQk5GcHNYckdSaDlrb3JBcGtoZmpsSmt1MkdWb29XWkN5MThycVhu?=
 =?utf-8?B?blhVNW9KNHZaeVc2bmtzWUVpM1BUWU12MEpUOXFOTDBKUnQrWk5xQjd4bEQ5?=
 =?utf-8?B?MG9EQ2tXaXA2aDAxSFhQK0NLYTdVVXlPMFFVYzh4RDRKQmJTa01GUGZGclJl?=
 =?utf-8?B?MjhKeTlXTW0xY2dvQTVOMUswMWV1YTRrYWRDcERiaHNkdVU2dlQ4R09xTlVu?=
 =?utf-8?B?eHFKdGVtaitBcXhQUGdiVmlXcVJhcFN2RUtmcWd1ODNNdURzSWU3Q1dNRFdN?=
 =?utf-8?B?Zm1laHhQc1NQZENLWUFIME9MNnBQS2hOYmsvcldXWmZHUkVEK2xDdXBJaFRK?=
 =?utf-8?B?WEkzVzR3RHp3cmZzb0Q4K0pUQmNyY1NTdnNQVTZPVmlBbEthWmdPMkFsWFBK?=
 =?utf-8?B?bCtwMG5HZ1d0eEEvMnFaYjhnQ0tSeW54c1RvWTltRVBCT21RZTlDK3prdU8r?=
 =?utf-8?B?QTNBcnRVeEF6NVVIS1ZQUStNVGRIMUNRQmM5QVBjWTNTeTdleDIrRi9NNk5n?=
 =?utf-8?B?VFhIc2ZvTlFQTmJIYms3aWphZTBJUjJlSGN5V2JaZWphMFdWSjYyNDhuNTVZ?=
 =?utf-8?B?alhOVGJraUpkWnBRRCtENGo1YW0vMGw1R3hHMlpWRXk4YndmNk5EY1V1TGVa?=
 =?utf-8?B?SGZvQlNnSDg4akdCN0djb0RQRW0zUWp2dG9TNkIvK0wwZnRDQTlPK2J0WExq?=
 =?utf-8?B?RVZubWhPbW1mZzdRVW9TTHgyUkptVGI2REN4R2JLb01BaEJkajBNelc4Sitm?=
 =?utf-8?B?QnI4eUdvRjlzMFNKOE5OcGZsbWN4eldXc3JhM2o4TkxQM2s3T3B1NDZxeGZv?=
 =?utf-8?B?eXBnY1hlK3g1RDFmRktyK3hadUtSb2pxa3BFWGYxM29JN3hpckZ5VllQTmFa?=
 =?utf-8?Q?IH/rHOy99h1LsvhoOk04WEDA5lSc1GaZ8QAEMK4h/3Zs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d634fd0d-0787-46a7-45d2-08dbec110ac8
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:43:34.5349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1538
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/23 2:46, Juntong Deng wrote:
> Currently free meta can only be stored in object if the object is
> not smaller than free meta.
> 
> After the improvement, when the object is smaller than free meta and
> SLUB DEBUG is not enabled, it is possible to store part of the free
> meta in the object, reducing the increased size of the red zone.
> 
> Example:
> 
> free meta size: 16 bytes
> alloc meta size: 16 bytes
> object size: 8 bytes
> optimal redzone size (object_size <= 64): 16 bytes
> 
> Before improvement:
> actual redzone size = alloc meta size + free meta size = 32 bytes
> 
> After improvement:
> actual redzone size = alloc meta size + (free meta size - object size)
>                      = 24 bytes
> 
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
> V2 -> V3: When SLUB DEBUG is enabled, the previous free meta
> storage method continues to be used. Cancel the change to
> kasan_metadata_size().
> 
> V1 -> V2: Make kasan_metadata_size() adapt to the improved
> free meta storage
> 
>   mm/kasan/generic.c | 39 +++++++++++++++++++++++++++++----------
>   1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 4d837ab83f08..97713251053c 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -361,6 +361,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>   {
>   	unsigned int ok_size;
>   	unsigned int optimal_size;
> +	unsigned int rem_free_meta_size;
> +	unsigned int orig_alloc_meta_offset;
>   
>   	if (!kasan_requires_meta())
>   		return;
> @@ -394,6 +396,9 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>   		/* Continue, since free meta might still fit. */
>   	}
>   
> +	ok_size = *size;
> +	orig_alloc_meta_offset = cache->kasan_info.alloc_meta_offset;
> +
>   	/*
>   	 * Add free meta into redzone when it's not possible to store
>   	 * it in the object. This is the case when:
> @@ -401,23 +406,37 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>   	 *    be touched after it was freed, or
>   	 * 2. Object has a constructor, which means it's expected to
>   	 *    retain its content until the next allocation, or
> -	 * 3. Object is too small.
> +	 * 3. Object is too small and SLUB DEBUG is enabled. Avoid
> +	 *    free meta that exceeds the object size corrupts the
> +	 *    SLUB DEBUG metadata.
>   	 * Otherwise cache->kasan_info.free_meta_offset = 0 is implied.
> +	 * If the object is smaller than the free meta and SLUB DEBUG
> +	 * is not enabled, it is still possible to store part of the
> +	 * free meta in the object.
>   	 */
> -	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
> -	    cache->object_size < sizeof(struct kasan_free_meta)) {
> -		ok_size = *size;
> -
> +	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
>   		cache->kasan_info.free_meta_offset = *size;
>   		*size += sizeof(struct kasan_free_meta);
> -
> -		/* If free meta doesn't fit, don't add it. */
> -		if (*size > KMALLOC_MAX_SIZE) {
> -			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
> -			*size = ok_size;
> +	} else if (cache->object_size < sizeof(struct kasan_free_meta)) {
> +		if (__slub_debug_enabled()) {
> +			cache->kasan_info.free_meta_offset = *size;
> +			*size += sizeof(struct kasan_free_meta);
> +		} else {
> +			rem_free_meta_size = sizeof(struct kasan_free_meta) -
> +									cache->object_size;
> +			*size += rem_free_meta_size;
> +			if (cache->kasan_info.alloc_meta_offset != 0)
> +				cache->kasan_info.alloc_meta_offset += rem_free_meta_size;
>   		}
>   	}
>   
> +	/* If free meta doesn't fit, don't add it. */
> +	if (*size > KMALLOC_MAX_SIZE) {
> +		cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
> +		cache->kasan_info.alloc_meta_offset = orig_alloc_meta_offset;
> +		*size = ok_size;
> +	}
> +
>   	/* Calculate size with optimal redzone. */
>   	optimal_size = cache->object_size + optimal_redzone(cache->object_size);
>   	/* Limit it with KMALLOC_MAX_SIZE (relevant for SLAB only). */


Can someone help to apply the new version of the patch to linux-next?
to replace the buggy version of the patch.

