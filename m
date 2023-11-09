Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DD17E6555
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjKIIaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjKIIay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:30:54 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07282D54
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:30:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtQ73zCQ55HeiZ4mY9X+9dgOM8/bz3AaqaYUdrC0k3xhHXHaucM1OmnSRcgsp0me+7gF0WqaUOWh0uE7HlfqnUEv4SjO+2GFyaqn55A8x8PuKXeg28FiI5kumnV9iyjgVxUDjDsaWldRKIlhdYAb+uX2jxZBr7ck36UU+eOnlr/o5T6UtbXk48jsmwD8HumhkopE0utUfHxcNIMAnENUtkeHmB0jBiErmCYAkjrgR/G6ZRk0JeZqvCMJeEteAh1saEmZH9ObZTFaa+/3STS2whThwss5IDFi9loZBw/kqyIToqWGYLpZfYcXgaccV7V119t3WUjw6B57r0YHjg26Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFDjdcPfWiClJnKHfdSrGhthGHGvJzva3CC7UeBiknk=;
 b=LldWLlWI7Uvoyym+xtsL0c5X6Vhdn5GnuR7bcEEDGBF+or0TVwbnI1v/sPgS2Olr3gHt/mZONOcZ8lz0bM5dAj10sR7tYaYIPD0lb5xqAQSxzzmgmz13sKsPhPnUYZ5OcyTrqvoB1z4jEYFU+xkT9nmT2qhpgEiFIxPsq5g6VM5Xd8DJrd2YZV7tKKRSb8cHtBOlLciNw7L1RU1GnQpDcPSnM+wNl2OkICd+BPQwr/bJyD43jz8HjW/ksnCnZq18HSuVuXQC3fGq/YEtIQ1+hyGdOBLGoEvVEiHAzkq7F7Ebffibf3qnxN6caZJAHbt9r6tCVHIWUJevqd8cWH4hCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFDjdcPfWiClJnKHfdSrGhthGHGvJzva3CC7UeBiknk=;
 b=msndB3hQhPV19yA91FSsppSSlrrKuvIdLwehr0M1M7tBVM1T1tecqWh2bEoqjE/GITQw85XFLsf+WrV13X8q6Un7O8iLLQL6olxD0oNalOBFnJYUFc0ujM60ZUczFhN6ggJqxaJZ/kWozol7p2cI6VvzzqplUB2JZ4eQeAtLt1raWtR/PDGPus/Kp/GA3Tz9gIr3ngDhRZJLB0qpvx9P+Sbb94MZa8Q9qnlrXb2Qq+xXkKibQ6sJe0XTd0zmJyfaCDfpE9KW2Jbf5i3g0g1SyJ1ZcA1Yz+GJSZaQUkK7Xl5SR5pe6I3bWkO8Kcsb/l56notuoPjZSF+5eHEcD1zKSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 08:30:45 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 08:30:45 +0000
Message-ID: <4e5da8a3-ce86-405c-b480-66cc1a6bbcd5@vivo.com>
Date:   Thu, 9 Nov 2023 16:30:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm:ALLOC_HIGHATOMIC flag allocation issuse
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
References: <20231108065408.1861-1-justinjiang@vivo.com>
 <20231108135734.7b3820985c288ff98f41d2c4@linux-foundation.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <20231108135734.7b3820985c288ff98f41d2c4@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a54845-f5f1-4fed-616e-08dbe0fe2afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0AAim02LsBmP+sJP0neU9l0QHWoFnhuQQMG46wvzKCiK44MfB4tiK8+nYZaNi25EWqstJDszwiPUtiwoaRcws/rY+0ieRXl5qljv74BL6CtUvM47ny5HNxLVke+szE3SorywuVWfW75cPulkjuAeNJKJR0NqwgJtnrzrXW3pUFg5zxtMKvlyjmRmoKXhoesa9UBakvBKhXOMy3NXr7RzxwjOd/R/D+Nr3PRm0Yvdoc0VLmkzbXlW02SisoxqTSuNF1PMbGGlGpAjCN4P3hHvTTXlpUGjVFIiqQiyouQXSWR+rHgnS2AajcTHww3ymMXmCUlelephmvucpNfh1uujjh4S9JI70MN0QYg52OUMGgbc6mes4/YRKn9Yf5pPLz4Qo427YbdrtOg2lb/onrUmRnGNCY/1WxG6FxcsCDjCKMOFamN6LOKQEfCfcfWbEPb/4qCOavHzL8JgpQNes7i39hgnECq2CJnKvHcJL6hCO7anbn4hv+vrFHC0M7MF+4thRe1757N5fT3gE4r6lx3BwXEpBbHGSvw9OrMO8Bl7d5tFR4WRVPNFT+cYjwP83FxFy32bqXwju/TNCoghf5z3efdIdHmroOCkCRKywreSeco/AQFYsqlgLpzZYptyv9LBSHhXNU9l3PvmojlfvmuAZ3/cBPeXaXkcMBfM4tCpSZawcLXbcFJy8Ii0ZkFIvnZK+7XtziiGLA7knOD3kkuv/95ut/+2QmBc9sSqnfhGII3G9nrDrTePioWPwkgOzXE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38350700005)(31686004)(31696002)(86362001)(83380400001)(26005)(36756003)(107886003)(2616005)(41300700001)(4326008)(6486002)(966005)(38100700002)(6666004)(6512007)(52116002)(478600001)(6506007)(66556008)(5660300002)(66946007)(66476007)(8676002)(8936002)(316002)(6916009)(2906002)(43062005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXpMdURrUjZoMXFlN25ZQjZMM1hSajRNQjIvbStwc21iY2VxaEh6QTRhVHpn?=
 =?utf-8?B?WUZRZnJZQmlzczhpUE5mQWRDTFA3aHNoaEZnSkhYaFhlbzlkOW9PQlJxZUtC?=
 =?utf-8?B?ZVQrL2tSOHNWTGFtdnFERWpQYjBMWkVsQlpRVHYzYXI0WlBhZVVJbGZqQ0Nv?=
 =?utf-8?B?bWJlaWlHUnFkM0Z3ZkxuRU1CWW11dmIvb3RXYktDMHE0c2dRQWhkTVQ2aG10?=
 =?utf-8?B?V0t1eStQVWFtQTNHdlJOSHI3OGVVNW00TUhSbUFYZWcrLy9EWml1RDhtOUlC?=
 =?utf-8?B?M25abnlVR01MZlpaS05KRWJTK0hNQkVwRndrV1lQOGdHNUtTU2dUMm5RWmtC?=
 =?utf-8?B?VCtVN1d1eG1GVWlSN1pwc2g3NWp6c2RWd2FPSVZXRzQ5M1RoYmJIRk5vTCtS?=
 =?utf-8?B?aExZUHcvc0RYWlZTNG1xUEUzeHN3VkFXazNXRjNOeHd1NXhra09uc28yd2VK?=
 =?utf-8?B?UXRwOHlYcWw4WGd2ampESHlhWXpaQWJWYnJua2Y5NmQ5bURhK1dxaTJDYmlw?=
 =?utf-8?B?ZTd1SlJLam1ualgvWS83dFk1eDJaV0k5Zit4MnlVaC9NUm1FWmlCNWhzZlhh?=
 =?utf-8?B?UEVKYktSL3dIakdPa0VEY1dwUHJPQ1VjOE53UTVlMUlMYVhhN1RzdXNMRVVN?=
 =?utf-8?B?QWFTdjUxeU9RaXJOQy9lcStQU1VRaDIrdWxBV1ZOQTRUS3pZZlJTdmtEc3Vk?=
 =?utf-8?B?aFJOY3ZlQStqOXdwNTJvTnovVDFKZnFiL1NQVHBKNmZzVjdxTm9jemZQV0gy?=
 =?utf-8?B?MVV0Ukt2bTUxUlFFTXRaOUxOandHS0dsMTVoek8rYkpkR1JLZkh4OFpyekdo?=
 =?utf-8?B?d2t2K1JJZE5sM2N1dHNmcldmblE5eEw0bXNwb2hFSjBZR3psT0NHYzNUSmdL?=
 =?utf-8?B?WlFROVo1THIwSU04ZXpoaDVZRmxQeFZRSjFlelhsSUFHRUJzZGliS1FIYzZG?=
 =?utf-8?B?OG1McUlFYmVNZ0lVYjhrc0ozN0RGTEk5ek10R01MMzJaSVhrTWU3Z0lPQVpK?=
 =?utf-8?B?ZnZINjVCRVUvUlVENTNVeU5NdUZGdTN1RCtWOUZmQzg5Z3ZwblMrREJmcXhG?=
 =?utf-8?B?ek5yUEVrN2NIM3dLUTdWRkM0Vk9wN2UwcWlSRkcrYjd4UnJyb090YjZWRnRi?=
 =?utf-8?B?VDJHREwvS0dRY1FzY0RMUnBYSkpLeTdEWHkwT09JVmNWQjdzRzM3VzlpQmpm?=
 =?utf-8?B?K3FPMkx0bDFTMkRvVXg5VW9HTEsyOTJoelpvVFVpN2tBdGVabzF4SFhLN2dN?=
 =?utf-8?B?RERhUnZxUDV6T1dZRmRYbjZnVWtFZ0l5NjlFb3I5b3NsanZyVlVVMC8rd0F6?=
 =?utf-8?B?aU56c1d4TzIyMGZZbW0yUklUWk11SDBkV21DVGkwRXBZblpCakJRNHZkaHV4?=
 =?utf-8?B?WnJ2ZHZ5MjZiSEJUdFVBWVJwdjF6RTRmUEJUVjBxVlY3YmVJZGQxUFYxc0tW?=
 =?utf-8?B?VGVFZERxb0hKZktoQkpxeERNZ2FNbmc0WE9ESWFBUkErWk5lQ2hVbWxNcW1Q?=
 =?utf-8?B?dG9tL0dLR2QrR2lEb0M2MzVzU0RZVkpLYUc3NEJNTW0ycWt2N1B5by8rbGd0?=
 =?utf-8?B?eldVcnl6ZEJXK29mVzZvTFZwdk4yZi9jMkw1c25kTzduaGNUanBaRGFaTk9J?=
 =?utf-8?B?c3ZXd0ZMaVlJWXpBaHhGSkJDTXBLNlhBaXhYbnFtckx4QzJPbEhRalIrL3lN?=
 =?utf-8?B?OGRwc2UyQ0lQc0pwL3Q2NFdQemY2cElCQXRzejJUTjNtR2tJb1NydDRhTnYw?=
 =?utf-8?B?aHBuMkQxam9yT0xSekUxTjFmV1JTMkM4eEgvZUE1eVlWejNPKzU4SGVDc284?=
 =?utf-8?B?RFl2NDVlSGZhRndCdWMvUHJjL2VBTDBzcWhLSnFhaHc4NWs3ay94VUpiYTdV?=
 =?utf-8?B?aHFCRlpmN3k5KzJVdmdjNzhCMTN1a1pjUm9WQ05IZmZkMGVycEpqNERtNFNh?=
 =?utf-8?B?Y1pTZmZXSHEvTWkxWEhWMHVFZit1Z0p1U1UzcUw4RXNSR0l0bFdoM09JUFRL?=
 =?utf-8?B?NE9KYVJZbTVMUE5WODkva2lrN0pwUDJxbENUeXZFaEloSkhHRG8wcWgwMkZx?=
 =?utf-8?B?UnFvdm5TNldRMGlVL3JaSWJsbUpiUFU5ZGRpeTUvNTR4dDVjN3poUUNtR1Nn?=
 =?utf-8?Q?QHvRCo4j7irJuvv7PyPy3I1h/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a54845-f5f1-4fed-616e-08dbe0fe2afb
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:30:45.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AHxcDZafTVXkuPHzDsXDggPpuu+751ooyiz2F2rGHnA/qp/vgIzcwlDTxEgSM7Q072/QoCsXbJThvGhABUbJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6871
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/9 5:57, Andrew Morton 写道:
> On Wed,  8 Nov 2023 14:54:07 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
Hi Andrew Morton :

In response to your three good suggestions, I have made relevant 
modifications in [PATCH v2 1/1], thanks for your review.
https://lore.kernel.org/all/20231109073133.792-2-justinjiang@vivo.com/

>> In case that alloc_flags contains ALLOC_HIGHATOMIC and alloc order
>> is order1/2/3/10 in rmqueue(), if pages are alloced successfully
>> from pcplist, a free pageblock will be also moved from the alloced
>> migratetype freelist to MIGRATE_HIGHATOMIC freelist, rather than
>> alloc from MIGRATE_HIGHATOMIC freelist firstly, so this will result
>> in an increasing number of pages on the MIGRATE_HIGHATOMIC freelist,
>> pages in other migratetype freelist are reduced and more likely to
>> allocation failure.
>>
>> Currently the sequence of ALLOC_HIGHATOMIC allocation is:
>> pcplist --> rmqueue_bulk() --> rmqueue_buddy() MIGRATE_HIGHATOMIC
>> --> rmqueue_buddy() allocation migratetype.
>>
>> Due to the fact that requesting pages from the pcplist is faster than
>> buddy, the sequence of modifying the ALLOC_HIGHATOMIC allocation is:
>> pcplist --> rmqueue_buddy() MIGRATE_HIGHATOMIC --> rmqueue_buddy()
>> allocation migratetype.
>>
>> This patch can solve the failure problem of allocating other types of
>> pages due to excessive MIGRATE_HIGHATOMIC freelist reservations.
>>
>> In comparative testing, cat /proc/pagetypeinfo and the HighAtomic
>> freelist size is:
>> Test without this patch:
>> Node 0, zone Normal, type HighAtomic 2369 771 138 15 0 0 0 0 0 0 0
>> Test with this patch:
>> Node 0, zone Normal, type HighAtomic 206 82 4 2 1 0 0 0 0 0 0
> Hopefully hannes can check this for us, but I have a stylistic concern...
>
>> +#define ALLOC_PCPLIST		0x1000 /* Allocations from pcplist */
>>   
>>   /* Flags that allow allocations below the min watermark. */
>>   #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index b8544f08cc36..67cec88164b1
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2854,11 +2854,15 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>>   			int batch = nr_pcp_alloc(pcp, zone, order);
>>   			int alloced;
>>   
>> +			if (alloc_flags & ALLOC_HIGHATOMIC)
>> +				goto out;
>> +
> A comment here explaining why we're doing this would help readers.
add in [PATCH v2 1/1].
>
>>   			alloced = rmqueue_bulk(zone, order,
>>   					batch, list,
>>   					migratetype, alloc_flags);
>>   
>>   			pcp->count += alloced << order;
>> +out:
>>   			if (unlikely(list_empty(list)))
>>   				return NULL;
>>   		}
>> @@ -2921,7 +2925,7 @@ __no_sanitize_memory
>>   static inline
>>   struct page *rmqueue(struct zone *preferred_zone,
>>   			struct zone *zone, unsigned int order,
>> -			gfp_t gfp_flags, unsigned int alloc_flags,
>> +			gfp_t gfp_flags, unsigned int *alloc_flags,
>>   			int migratetype)
>>   {
>>   	struct page *page;
>> @@ -2934,17 +2938,19 @@ struct page *rmqueue(struct zone *preferred_zone,
>>   
>>   	if (likely(pcp_allowed_order(order))) {
>>   		page = rmqueue_pcplist(preferred_zone, zone, order,
>> -				       migratetype, alloc_flags);
>> -		if (likely(page))
>> +				       migratetype, *alloc_flags);
>> +		if (likely(page)) {
>> +			*alloc_flags |= ALLOC_PCPLIST;
>>   			goto out;
>> +		}
>>   	}
> So we're effectively returning a boolean to the caller via *alloc_flags.
>
> This isn't a great way of doing it.  Wouldn't it be cleaner to pass a
> new bool* argument to rmqueue() for this?  Make it explicit?
>
> rmqueue() will be inlined into its sole caller, so this approach
> shouldn't add overhead.
Yes，I agree with your suggestion that pass a new bool* argument to 
rmqueue() for this, it is more clearer.
I have modified in [PATCH v2 1/1].
>
>> -	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
>> +	page = rmqueue_buddy(preferred_zone, zone, order, *alloc_flags,
>>   							migratetype);
>>
>>   out:
>>   	/* Separate test+clear to avoid unnecessary atomics */
>> -	if ((alloc_flags & ALLOC_KSWAPD) &&
>> +	if ((*alloc_flags & ALLOC_KSWAPD) &&
>>   	    unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
>>   		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
>>   		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
>> @@ -3343,7 +3349,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>>   
>>   try_this_zone:
>>   		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
>> -				gfp_mask, alloc_flags, ac->migratetype);
>> +				gfp_mask, &alloc_flags, ac->migratetype);
>>   		if (page) {
>>   			prep_new_page(page, order, gfp_mask, alloc_flags);
>>   
>> @@ -3351,7 +3357,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>>   			 * If this is a high-order atomic allocation then check
>>   			 * if the pageblock should be reserved for the future
>>   			 */
>> -			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
>> +			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC) &&
>> +				unlikely(!(alloc_flags & ALLOC_PCPLIST)))
> Again, a comment explaining the reason for the test would be good.
add in [PATCH v2 1/1].
>
>>   				reserve_highatomic_pageblock(page, zone);
>>   
>>   			return page;
>> -- 
>> 2.39.0
>>

