Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C97E76D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345577AbjKJBvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKJBvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:51:14 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2126.outbound.protection.outlook.com [40.107.255.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7490244A6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:51:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMETKKwKTVwbqjsyYhWhNDT6Dej33Nk5B9DcXTcAn3v1FBgs0R619H645ZmOz6L0GKisSoF33Ven0p7OgR499jycPts3xRLvI2NtyfWEH5Gr1WXCj/AfLryzANEEN1W5IEos/hyyDA14/cImOAKhwWT5x+ggjruaLt+jC7hZiXmpOl6xee2Eh8qWge5CgoOheNGSS/Vhg0rInE0B0ZQA8/tRndXEeLaH4HOkf99TCcl4Gq7dP5Sf3Y30bpeqcbQVqTBoj5529fIzfuzL4/yrh8i9+dTmrSxdwdKi4UiCPoM+McDJxWFR7QS6RPmE2tHsLacC8v4/+d63nxF1SKUCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUkyq0gFoe+k9Bq4t4ulS/n2dt9HfdLJpOEM58QVuE4=;
 b=K6LHSDiUvhEJb9kHhKj8IZsbHUSA1/7Vh7Hq00DZCVXXg6qPvFY0HptPqDXKobz+2MCHoV/BfhdR5s9oqDXyID1yuBaylByrHGwW3LgJwj6kAl5xexFazCPJXWthl3skY1cejE+KhnzkJ5W/iMs8UMwubwlqb3XTu3KTra4SYJdt1ycfvq40UAsUDuRA5okgi4BrkHR8OKHrFEm4qh5DayVuKq+yYs/THNExJaKmRPsD1YExFkLhWAaeB5stT3mrXdFUQo47D3H6eT/M0zZXA5QaimxWhE3HHAOzuJpSxV0UOA9fMItDtHohNh5e8s9UVImAt2Bt49meOCEO69HVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUkyq0gFoe+k9Bq4t4ulS/n2dt9HfdLJpOEM58QVuE4=;
 b=DlINMp2dYkCRd7zM+wDZFdXcLzGHlgD8LfEE7tYPbc3J3/h88ZWM/G8eCHb7ozJnsfpVx4HvRuVY0LWaPvfUoiu+IN6OQRGz3Z7+aTO7ihTREKruzi2dD+JHTWEgc93hCD7dtxA4Duxbix9Adaa0gSH0fjYX6uVJs1x2AdahCitU6lFdpLlhEd66uHy1sreyoQ5wsnI/Writ1m+azClbqgcMfXzBe5BSuM1DX6dZTqteLyXPbylcKq1vU3rDmqVtES8MTscopy7rShfIaZgnw8XB+gLOeedCy/zDlKLhUxKHu9aSAMmQJWpaoidt4hTjPmsnLn2uLHcMiC2QawTSAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6211.apcprd06.prod.outlook.com (2603:1096:820:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 01:51:05 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.6954.027; Fri, 10 Nov 2023
 01:51:05 +0000
Message-ID: <13f31dc5-cd0b-4120-af21-196619d8fa69@vivo.com>
Date:   Fri, 10 Nov 2023 09:51:02 +0800
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
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f28ab1e-f93a-4585-33e1-08dbe18f7ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYDjeFBL9vag2J7O1ZSW6fic8ulGbZZ1r9SzwDRs4MwIdTtkvt7eikn0xl1diBjEHXGxbAJhUyNSHO6abov5zcn3mkcQurrtfTfeiRYZk68mlDffYgH2KBVjiVW2g78ZonEPzoHuY8SOUd1+p94F8g+jgv2oBgD1ZQpChd7s/Kw/98HMtdvkJw5ftkJ5TAqXVDv85k8iynuMajVULibYqmaA1Y9XvkvstDh2trrMiACRm7Z8a+ui2aFc8m5k1OfubqotJ9ujBDGyI75ddiGLobu9kHUxRt0lVdoZH5EdKrpnHu140DvnQwOwgpQkjoHcmEZHeLgUWdGv3K/9CiMCFsmkYDxtuVeMqJNZdXXel2PWsa9MMf84dDMCIAPu36n6qfGr/DNJe5+apCsEjbHXEBOf1NFXN/C04oT3R44yQ2PL3z7RRP03q1fWsrkXdaXVG2Ddsi7q7vPTiXMX4tSu6TNWDU7eawUdlzlipYWHjOzQu9GTCWmjEOms9dHmjgQInYV18Knn2yNzW/+CGsLTCy9h5AZHhuOFdAcx4hVtEwX0kU3COdl/HPEmXbuEbZj9avYwvKaIGFrchKlTMvaNb3bLooAb+3HU88FosV37IZBGgjNlGoubjELIodP6rHSU6QJ2oiqR0y6knehg+mvBugdGErHiTxNN/DZGUmC2smfhrd9Ad538QwTrYxmEFgaJ0Vn7s1oLX8PbVEuSuOQQlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(4326008)(8936002)(6512007)(2616005)(316002)(478600001)(6486002)(26005)(36756003)(66476007)(66556008)(6916009)(31696002)(66946007)(38350700005)(6506007)(52116002)(6666004)(8676002)(5660300002)(2906002)(83380400001)(38100700002)(41300700001)(31686004)(86362001)(43062005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGx6OFNEUGp4bnNvanVyVXZIQTR4WlBrQmEyeFNJL05MQmJybFNGOUFHVVph?=
 =?utf-8?B?MytwcHB6dDUyZUpEZm1nZTNVQlRoSkZ6cml0U3NHU1IrM1FKeGlwY0tTNnNX?=
 =?utf-8?B?SlBaaWZvNGFvZ1VNd0ZNSUdoNVZ4amJERVZ2T0JadVhEZjNIcHh0OHBFcG1H?=
 =?utf-8?B?RG9jM1NPRlVkNktaLzN1clExUThEWDVxRDh3NUxIeE1lLzk2azBoRW9pUzR2?=
 =?utf-8?B?MWgwciszeE9waU1FVjlLUkcrUGZNUFo2bmhKZlZJWUtMZDZmRzVTMGFpZTZK?=
 =?utf-8?B?M0N1VERaZDBFMEdOaDlqYzlxTW1KUi9Kc004S0FCR2NrRXp2NmpkanlWUCtj?=
 =?utf-8?B?NFVhcUROWW5TYXZDTndkWDByM3JqaUZCV0pBT2t0OVdnei9IbSt0UkJsN2ZW?=
 =?utf-8?B?ZGhEVzZjY3h0dERYWnVmeHlKS2lOeVR5ZTc4bkVqZWF5ZHBtZzlmSW1PSTYx?=
 =?utf-8?B?bmwremY5a1hkS05NdmM0QzZGQUJ2cnE4b0hVRVFaWko4aU1Zd2o0WjRHUTBP?=
 =?utf-8?B?Mk84VkVRcloxSzN0VFl1Y2duNk1QMExyK0h4R1J3czRkbStuSGVQYkVsMlF0?=
 =?utf-8?B?ZmJ4MkxyQ0NKYnQwYlBpcm00eXF6ZzRXOTdQbSswZkFtc085Ui9KY3JjRytB?=
 =?utf-8?B?Q29QZ3J6dmV1dlZPMUkvYzUxNEU5RGFlbitWZTU5UE16Z0JQenlGWHJqYUlJ?=
 =?utf-8?B?Mld0c0gzaDAwWERVSjI2cHlUQ0dNS2VMN3J5WHlJaWtuQVpnQmJUT05EUUlB?=
 =?utf-8?B?RGhuUk5hZEpXbXFQWDhrUk9ZWllDdFAwVDgveklFbkJ0OWgzNTRGT0UxcjJY?=
 =?utf-8?B?ZjR5dW1LcWpRbExKRGo3UFZ0QnIvOGdhMXNOQS95RnpGSVZBSnVaMFVPdEx0?=
 =?utf-8?B?cHJtYnFmSWZKdzdYS2xHMDdkQm9tVkp2VGJrdjNHeWNmSWhhdmRmN3prWE1M?=
 =?utf-8?B?R0ZkbDJVbCt4SThwOHRBNlBZNkNVZFVKZGlJMDlmcU1RaWM0WWxpYlo4SmdJ?=
 =?utf-8?B?VkdXbFVHelZNb2xXSzZud1hpNE5uMFVidmdESWlLMHV1QjZRaWRVWDI2L1ZK?=
 =?utf-8?B?VWlZdWFvSHlIVDlSYnYxdlIxbWJMZ3VycFZuOU1IanVadDlPZkRKTDF2Ukkv?=
 =?utf-8?B?QnF4d3FwT3VkVmx2NTROSXF0bTVBaTlRQ3FNZGtvTkhzVDJrcCsrT3RCVkY2?=
 =?utf-8?B?V3RvRnFBOW4wRXVvNW5GZnFYcExWUkJwd1ZnbUF4aGZJWkc4ZGQ5VXU3WFRh?=
 =?utf-8?B?dCt4SUU3OHBmNThrc2hTeUUzNEdUSmF2N1NrQmdPdldXUXdBYXkvczVvVVhm?=
 =?utf-8?B?Sm5BQkNEaTV6a1FDRmtJeW9QcnVuR3BEWjd4QmFaOGtoUkROZWZJelNyVmg1?=
 =?utf-8?B?SDRzUGZpZ3cwTTRjdFlmWmpQS2JLbWhaaFlZN2plVEJSd0d4aWtQbWcwRDY0?=
 =?utf-8?B?SktQRHZWV09oZWxTVysyOGZGUVZqWjBZTXNOclJoQWp2VkJvaEtvcHJPeURZ?=
 =?utf-8?B?bU53Uld3T0xXVVU0TWdVS2RuVE5PcHQxL0thVzJRR0JoSmpzUm9nWXJCR29i?=
 =?utf-8?B?RXdqSnFnc013VzhkcjZiQ2JJamFlUFVxZENYME0yZlJBVW1LcEVNRGhaeFZa?=
 =?utf-8?B?SHhtb25GZGVNZlZKanJra1ZVcEFhd0FOSkUwbmdmS2xoVHlGRktnbmNUdmVk?=
 =?utf-8?B?N1VQcDI2UGEwMTVxd0lHdHU3TXdEY3RQMWxqdEtwV3FhbVQ3R3NDdEw4MjN1?=
 =?utf-8?B?Rkx4QWxUaVlLT3drMlo2Zkd1YUZuMlNnRjJFYm5pbzhVLzRTY0twM2Uvdkoz?=
 =?utf-8?B?STZwUzNOTHFYczNCc2lSd2Exa2EvdHBkS2FzeC9HRUkyOWRaQ1RRZzhDYjZn?=
 =?utf-8?B?bW1POHV1b3NPRGRNbWRSMXFRVHBySlJRbUJtZE9vWWpkU0V2R1d3SnZ4U0sw?=
 =?utf-8?B?RXR3T05BcFFjY2ZpWktXMEdxdkw1ZzlpY3JUR3B0VktMMDdTZVVRTEJvT2Jz?=
 =?utf-8?B?RS9qS2VSR0hxdFVDdmNKTFp0UElmZlVURUtwVmpqQ1lPQ0VSMHNGLzlBVUFO?=
 =?utf-8?B?b2crVGl2NGpyQ0RlYnVscTNZSHZyMFBDUUNqeFRPcm00NTk4Y1liMkVTVE9C?=
 =?utf-8?Q?bEeEYAeH/yvMOUlA8jGz+H7Ll?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f28ab1e-f93a-4585-33e1-08dbe18f7ff9
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 01:51:04.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFttxK5OhmUMS45tfRMAVyb6WJfw6sIQUH7qLpnYrhTKZPVLP4YAEHDW/p1Xe9XhCtOxf0ATohICR1W5xD2CNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6211
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/10 1:49, Andrew Morton 写道:
> On Thu,  9 Nov 2023 15:31:33 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>
>> Add a new bool* argument to pass return flag instead of *alloc_flags
>> and add the related comments.
> Please retain (and update) the changelog with each version of a patch.
ok，I will supplement it if there is a later version.
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

