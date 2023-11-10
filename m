Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5297E7739
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345902AbjKJCO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjKJCO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:14:27 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37624ED7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX4wP3y15JJ2pU+k/nyOv8w6ImxyFBl/CcVZ65xeE+WSSIZwErFV5njwVmPZRWfM5+xZmhWTqJDoy4CT09Zr897JaJgiNALJNBx9q331hy68jfA92EmAoN/vIg+NQpPbkschgZSgsnUMpRc2DAGhwFSy7ULLPBy4rqNv9f/WI/YDx/JrSic0P/4IVuuxXJMcwm4Y8xX9OaGkgUs2uu864RvyZrMWHrdbtvg++hYVJE9ZRTaIU+JiSoWOsCyzq4EbPi3ZpNrFuHabJI3j6dVrBcAp/Zt/T6dyrelPfeMV+CjnZIcgm07kHLiJ/CSwKnEyYUBrWGu8WTHdAxXTFtVAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk1BX9tdwgNRVW7tO72jrIpS4/CPutvZ8CUohdFxbaE=;
 b=gKVEjcGm2snY+RoZUgUvO6tCo/7jd/BWNQlSHerxR5nwxot5QyllZwsQkTQy+pddpaMv4q31DO7Ij0kCjK2V6huKIqkWnjUf4b/EjSrZJrZpXQWmLHlkqgUYlqA1c1tAzCG5bt11Zg7BE675acHBpfnJbiR14ZCmpTn4B8zETSUaNjYonkQfyS3Y+E0wDiU3XICkSElL5oqVG2GpZL+0pLQZr2ineVa/Lfrm0roT7pjg4ZzboZ8HHB6eCQ83kiQWmFKNvs/ZTQ00BRfoEs8mubfjTOCarb5salrYLbr4FURkOzl3lpb43TtqMAQKHfmoUNDvF/RrvBIlkFWy8sOYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk1BX9tdwgNRVW7tO72jrIpS4/CPutvZ8CUohdFxbaE=;
 b=coYPpCf3ZLkH8GGlip5zMOur1uSM+h7V8yf7sQ7YGi1n5cSEkRpz97/uUBoNa0MDFk1332/HqR/V61x8rWHzKiAT6CFEN9YtV1jbO2sCdMbrC4qEvtz5UfMILv6E5VcbEpo8xPOFkzwqsmRFj2Mf+S1F/kRsmZ7JYUQzpdMVD2/MB7IgXs2hhKMeibO7Bf97PVW/YuL/H9VK0JW/zUOUUlw9K+AhGwlaXBU9EXCAH4gXTtmO80S1qs+poqVs8pZTxkq3Wrjoy0XQDyJgyvo0T9zMoPN0LP0SMBwdcPUGPfO1AAVT5EwU99aFKQY6kflJkxkxJv2R+WPqh84r0p9CkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB5158.apcprd06.prod.outlook.com (2603:1096:101:5a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.31; Fri, 10 Nov
 2023 02:13:45 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.6954.027; Fri, 10 Nov 2023
 02:13:44 +0000
Message-ID: <9dbc7a0f-10e9-47c8-9aac-aaf9545f75a5@vivo.com>
Date:   Fri, 10 Nov 2023 10:13:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: ALLOC_HIGHATOMIC flag allocation issue
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
References: <20231109073133.792-1-justinjiang@vivo.com>
 <20231109073133.792-2-justinjiang@vivo.com>
 <20231109094954.dd4b2a5b1f5dfcc9a721edba@linux-foundation.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <20231109094954.dd4b2a5b1f5dfcc9a721edba@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: 56371012-a7f3-407e-c8c9-08dbe192aaab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAmMZJaRmvVcj+k9RtkEqP+HUE8+3i9jT31L8SV7MuX6FfXyB307m116KB+nywfraK54UI6Ha9RR2Vum+dkN3Potq60YtN6vS2U7B58j2Knx/FNGDKX3aexcVgJlEwWo5u/Fr6oxgLqJjZs+v3aVmXCNDRxBfbUzg3GxrASjg4EdtNrhe1E7weF2tiQvNTnzkOJpwAkn0U7JZh0Q/wX0T9BEkmeRR52OaX0A3+d8clgqF+05x4AHo+zW/Ri+WtxKrPps0jNbHHNA5n4yadD4jUP7xhQqymyWSuAvEFc+gW34SxQgPG7aDY/SWNJvygjKih+STbriaG7lOWHQLB9GVX0DUNw4YdHYdXryrJwo5UcLqt/obSzoEHK7bemHORrMjFfUrvo1/G8plNPfUKZF1BM9dAT7NU1HtCk40TUpiE4j3KsCpON7z88xkp3uOwnO8j4LbaacS5z4XAE0eaO7M84iSBajfYGzcwL269W0FyRJOFphOWe8RrWvaQA3H2t4x3TESwF45NBIEkNd1Y9mM0wqlbTOmDZ0u0HQSIU13o4Eq1vyd7kgrVjsh21y55uEcXmCXIEw1vpIlx4Am4x5cHcngkYWR5P9zy8u9SOa4vqB47Fax486WnaMG6+0ADx5UTTRTYkjo2acYU4aO9gNiiHveCvahA3rvEY/FLQfSwoi8462FLJG9rjNh6vIyBwO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(36756003)(31686004)(52116002)(316002)(6486002)(478600001)(26005)(8936002)(107886003)(6506007)(6512007)(2616005)(966005)(5660300002)(6666004)(6916009)(66556008)(66946007)(66476007)(83380400001)(41300700001)(2906002)(86362001)(38100700002)(8676002)(31696002)(4326008)(43062005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q09EVnpUbUNkY1NWS2hvWGZBc1JBM0FiRWt0TlJ2YlIxVVFNRkdVUkdJN29D?=
 =?utf-8?B?eVZnNmkweXdZcHVlSDBsUklBL3lPekQ4QWVjTEl2OTA4Yk9CRXZ5VWJvd3Jr?=
 =?utf-8?B?cTcramU4VXhSeGxTbHZSdmtETitESWovM2tZQTFiNzJJQ3Q4MTFzR3VqeTdJ?=
 =?utf-8?B?WDRUSWg1aW1HOTk3S3AvbHFBR0t1RXNkZVhEQW5GN2FCSWFNUDRvVzJiTHRi?=
 =?utf-8?B?YjZmaFRkQ0FmNnlyeFlLNFlQOTk1RGlFL0R4OXVVWngzR1BoWURsb3dOSlFj?=
 =?utf-8?B?b2huMlhzYm05N3FyREV3cSthNGRPckJXRzFxaWdwN01hMHJTbmVuN2NteHB6?=
 =?utf-8?B?dVdEQ0l4alBCUGhYcndZZXpEbkNVeHBOaHRVd3luQkordGhScWR2dVNZSjhO?=
 =?utf-8?B?N0pBaHF0M1BHUkkxZXRVTE9BZDlseFh6ZUdELzU0SlIvYnRIN205Q3dKbUFv?=
 =?utf-8?B?UG5qYW1iS1drUFVPc241emlSbjk4ZHNUOFRJMnVwOTZwMVY5RTRVUUw0MWpX?=
 =?utf-8?B?Y1ljRUdvKzlnK1dNNWZ4NXp4aDlRb2xhby94OGdvdDBLZlhMaUdGeUhUSzlC?=
 =?utf-8?B?aXdhYlBpbHdNZXI3amFJYW5sYldxUFFtWGEzSzZoWjNCV3hEZkVtaHhXUE1S?=
 =?utf-8?B?Nk10RURrNTRla2VIeURrcjZtejRMdFNmTnVqT09uR0QxSTRmODRUMkwvYzhI?=
 =?utf-8?B?L3BjQ3d0NkZCeWJoZUdlSHJTNkNIMkx3UE8zeFdJQ3dnV0RReERKMXZNdXBO?=
 =?utf-8?B?VXVIUGJvUGg2ZVJDc0ZXYTMvRUxYRWFTaE9kT1lhM21CZG04YndhLzlBTWJn?=
 =?utf-8?B?ZytweDBsTnppU2Q5NWpRV0tQdmJQWCtUSnZ4ZkR4R3A5VkRQK1J3R3Bkd2I2?=
 =?utf-8?B?MGtEZFFYQWhxUUFacm1uSytLWitPT01Nb1NqL3ZzZ2kvVUxJOEF1RVVhcWZz?=
 =?utf-8?B?SDdtN0c2eXZ3K2dGanBlQ0lBWEp1QkJpSUxGd3FsWUgxWTlRWktyRUQ4aDRa?=
 =?utf-8?B?cHVvVVBEdU0zZEY1L2ZVRXRzQlhwQkYyK0I2TVZBTXJZdEYzRVhHWU5PeUkw?=
 =?utf-8?B?MXprVElTVm00dGp5MDJET0g3blN6b3ZoUVVVcXZ0VlBCV0x6SERoOTRHOGNB?=
 =?utf-8?B?aEd0K2NEMU1aYzJwMjhDUzE1eTdKL0k3d09IeE12RHFsK2hNMVVMaElWcis1?=
 =?utf-8?B?YjFNcm5LMEQxTEJBd0R1elBnMEltMERUbGliWHJMZnNkQnBIY1RDT0hIMmVv?=
 =?utf-8?B?QjJ5TERJMUZ2V1kwLzJzbkhxMndQR0pZUzE5U0J4cWdWR2ZKQlVsVEFXeTgv?=
 =?utf-8?B?M1NqQVZoTjFYWXhKVGEzWWdHdkhZK1NjRG1PZlBtNmtqY3VMQ2N3OXlOaHRS?=
 =?utf-8?B?MFprbERucnNCWWh1ZGNwYVlXWURKK3o3NlU3Uk9xQW0yRk1ucmh0TCtYNnVr?=
 =?utf-8?B?UGM0OUV0NjRXd29rcm5jY3l3djRlckZ0K1JCN0F5VXEwSnBERS9tU3l4WE04?=
 =?utf-8?B?Q2ZiS2lnMW9UZldHaVMzNXNEZG4wNHZVNy9LdStoVXpZVkRtck9aRFpZN0t1?=
 =?utf-8?B?bktqelpEMGRNZ05jd3d1S0NYNGw1WU1hRGxyU3F3ZUNMbGlNMFNwaEdaa2FI?=
 =?utf-8?B?MTcrWWoxYzdBcnVrK3lTVWFpT1pBNjRWK3Rmd1FObkord0drdzBDd2lQb052?=
 =?utf-8?B?ckllOWk3ZHhiVUhmT0xqeWhLaUV3RkpJcjJQYStpcGJ6d0RVekcxWTVwbUFn?=
 =?utf-8?B?T2hqdXdjZk1GZ3dmNjl2SFZhNnVGOTRlSHljTG9Wc2R4QWN0aU0yOGJqTEhP?=
 =?utf-8?B?QVRIL1RwTVMzZjhMVHBTdGpsTUVwQWdSSEQ2WXZqSXlXdjhscWM3aGRzTDd2?=
 =?utf-8?B?b3B5MzFLKzN5SkV6bTE1eFZjdFE1QmIrWnpUUEhOR0hWNHllbG5qY0xRWVNv?=
 =?utf-8?B?WGx3TFZVZG5raERiamtGT2JIQnI1azlIK2xqV1hmaDNxbCs4THB5VnJQM3N1?=
 =?utf-8?B?ZFhKWWlVWklQU080MVVqV1FWYUVrWjBrQ09zUVpETVUzS2tZNjJ4NEJJUnJV?=
 =?utf-8?B?UGVieTRONW4wcm5jWnl4SUNXeU9nVk5GM0lwbUVXM01QemxvZ0RCMFRrQUNX?=
 =?utf-8?Q?UA7Q8Kbsc9uM0qo3SETg6JCu1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56371012-a7f3-407e-c8c9-08dbe192aaab
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 02:13:44.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLZq/HXVySEALS6SAZ6PEtWNrrC+BNCh9gkbsMUACktqsLfenH3p88OUK0EcD4WQlqhZYSFiF96zyinqx8cSFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/10 1:49, Andrew Morton 写道:
> On Thu,  9 Nov 2023 15:31:33 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>
>> Add a new bool* argument to pass return flag instead of *alloc_flags
>> and add the related comments.
> Please retain (and update) the changelog with each version of a patch.
ok, supplement in v3 patch:
https://lore.kernel.org/all/20231110020840.1031-1-justinjiang@vivo.com/
>
> For reviewers (please), here's the v1 changelog:
>
> : In case of alloc_flags contain ALLOC_HIGHATOMIC and alloc order
> : is order1/2/3/10 in rmqueue(), if pages are alloced successfully
> : from pcplist cache, and move a free pageblock from the alloced
> : migratetype freelist to MIGRATE_HIGHATOMIC freelist, rather than
> : alloc from MIGRATE_HIGHATOMIC freelist firstly, so this will result
> : in an increasing number of pages on the MIGRATE_HIGHATOMIC freelist,
> : pages in other migratetype freelist are reduced and more likely to
> : allocation failure.
> :
> : Currently the sequence of ALLOC_HIGHATOMIC allocation is:
> : pcplist cache --> buddy (batch >> order) allocation migratetype
> : freelist --> buddy MIGRATE_HIGHATOMIC freelist --> buddy allocation
> : migratetype freelist.
> :
> : Due to the fact that requesting pages from the pcplist cache is faster
> : than buddy, the sequence of modifying the ALLOC_HIGHATOMIC allocation is:
> : pcplist --> buddy MIGRATE_HIGHATOMIC freelist --> buddy allocation
> : migrate freelist.
> :
> : This patch can solve the allocation failure of the Non-ALLOC_HIGHATOMIC
> : alloc_flag due to excessive pages reservations in MIGRATE_HIGHATOMIC
> : freelists.
>
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -905,7 +905,6 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>>   #endif
>>   #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
>>   #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
>> -#define ALLOC_PCPLIST		0x1000 /* Allocations from pcplist */
>>   
>>   /* Flags that allow allocations below the min watermark. */
>>   #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 67cec88164b1..3c84c3e3eeb0 100755
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2854,6 +2854,11 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>>   			int batch = nr_pcp_alloc(pcp, zone, order);
>>   			int alloced;
>>   
>> +			/*
>> +			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
>> +			 * it should alloc from buddy highatomic migrate freelist firstly
>> +			 * to ensure quick and successful allocation.
>> +			 */
>>   			if (alloc_flags & ALLOC_HIGHATOMIC)
>>   				goto out;
>>   
>> @@ -2925,8 +2930,8 @@ __no_sanitize_memory
>>   static inline
>>   struct page *rmqueue(struct zone *preferred_zone,
>>   			struct zone *zone, unsigned int order,
>> -			gfp_t gfp_flags, unsigned int *alloc_flags,
>> -			int migratetype)
>> +			gfp_t gfp_flags, unsigned int alloc_flags,
>> +			int migratetype, bool *highatomc_allocation)
>>   {
>>   	struct page *page;
>>   
>> @@ -2938,19 +2943,33 @@ struct page *rmqueue(struct zone *preferred_zone,
>>   
>>   	if (likely(pcp_allowed_order(order))) {
>>   		page = rmqueue_pcplist(preferred_zone, zone, order,
>> -				       migratetype, *alloc_flags);
>> -		if (likely(page)) {
>> -			*alloc_flags |= ALLOC_PCPLIST;
>> +				       migratetype, alloc_flags);
>> +		if (likely(page))
>>   			goto out;
>> -		}
>>   	}
>>   
>> -	page = rmqueue_buddy(preferred_zone, zone, order, *alloc_flags,
>> +	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
>>   							migratetype);
>>   
>> +	/*
>> +	 * The high-order atomic allocation pageblock reserved conditions:
>> +	 *
>> +	 * If the high-order atomic allocation page is alloced from pcplist,
>> +	 * the highatomic pageblock does not need to be reserved, which can
>> +	 * void to migrate an increasing number of pages into buddy
>> +	 * MIGRATE_HIGHATOMIC freelist and lead to an increasing risk of
>> +	 * allocation failure on other buddy migrate freelists.
>> +	 *
>> +	 * If the high-order atomic allocation page is alloced from buddy
>> +	 * highatomic migrate freelist, regardless of whether the allocation
>> +	 * is successful or not, the highatomic pageblock can try to be
>> +	 * reserved.
>> +	 */
>> +	if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
>> +		*highatomc_allocation = true;
>>   out:
>>   	/* Separate test+clear to avoid unnecessary atomics */
>> -	if ((*alloc_flags & ALLOC_KSWAPD) &&
>> +	if ((alloc_flags & ALLOC_KSWAPD) &&
>>   	    unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
>>   		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
>>   		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
>> @@ -3218,6 +3237,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>>   	struct pglist_data *last_pgdat = NULL;
>>   	bool last_pgdat_dirty_ok = false;
>>   	bool no_fallback;
>> +	bool highatomc_allocation = false;
>>   
>>   retry:
>>   	/*
>> @@ -3349,7 +3369,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>>   
>>   try_this_zone:
>>   		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
>> -				gfp_mask, &alloc_flags, ac->migratetype);
>> +				gfp_mask, alloc_flags, ac->migratetype, &highatomc_allocation);
>>   		if (page) {
>>   			prep_new_page(page, order, gfp_mask, alloc_flags);
>>   
>> @@ -3357,8 +3377,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>>   			 * If this is a high-order atomic allocation then check
>>   			 * if the pageblock should be reserved for the future
>>   			 */
>> -			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC) &&
>> -				unlikely(!(alloc_flags & ALLOC_PCPLIST)))
>> +			if (unlikely(highatomc_allocation))
>>   				reserve_highatomic_pageblock(page, zone);
>>   
>>   			return page;
>> -- 
>> 2.39.0

