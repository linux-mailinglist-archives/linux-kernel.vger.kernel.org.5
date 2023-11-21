Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69867F23F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjKUC1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjKUC0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:26:41 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A009C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:26:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPOTEoCdRD6NorlWgPjIDR9eiQbjeJM5vqrAieIuN09Du3/S2yROZ/g55ucs4bqbYc7ZsSCtUzYV/tDLqE3Yi1o2Li5OnFErMyb4R+v2u2ZNSTjmQQ0SjvxxwJPMKAgPowkbYSOihVm8aMnp61SGi1AIhA6oWUm52RDbYKhgsYGT3uv+1+mTKkX+qtfJypAU7IX/O3aR6SCZzTETKveqK7w8aBf4G9BHLmGIOcPxi8K/Kbpncfejig19OzxBb0qdLUQNwyymbn7j91tqJXt2urSX86+brc9PQJWuak0FxQZWKNmVdPz2Y3sEiSYH3mnbb24VTgshWbyqZ2xs1r59Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8ItEQgjIQmaVwpqwJKF7maiN9vcjojqSMUHMhHLhmY=;
 b=ZzhHZ1ivV24kCUFSuLoI88FF4LRwW72+CZxhQK1qMb3UQX7ifrEFiYedKkio4x+2g6dfUlOKF6w4DDnPH+Vzgmh+s3qm1WYocq+x/7uIEbaqVIcSP60EzA2Uta1TI4eotgKhHebFGPf/W54RacYkg+dVM/uwd4Vqm5sAhKhvWdGxKUps+1pncTn1E/Ng0eVWD0VicTeWXAdZIQPWnTOoStWCw7YTKmDoxrYNEbvTeKZ9P3WlBgCTj5HxSQJRFeV4UvdMYzdY1RiMqZ0mEU20TAN0BTOhKpJrFua8auWHQLsvuRm56wclU5uimoOJyePRsz6CwtA53Mc5qh80Xjb33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8ItEQgjIQmaVwpqwJKF7maiN9vcjojqSMUHMhHLhmY=;
 b=dgIfhNBn15TgrqpVZdAEFXq4Uah4HdlioywGvp+MlPRcBUDQ3nRLAPUMbEbcH/HgMifsGpAVqRiVz+W9rnjyYmWrLE5SmzTv7Rg0iQELT7CgK9bPXPpW1Uuai99IuOH7H3SzL/9tLvVAROG1YA+3/aKwQx8im1T9bCyFgiN+UFR18jAe69P9IshoxEHfDLG1P6Ez9WkdJEzCpb2ayEYR5YK4cYLeJ+gFV3QKLmz/2t3cBqB7JWbfhxqXqbJnG8J1UXCDtLlCu5iZV6/s02oTm8mde7uEUnMc/HDVqM17qJJH5KG1V3nPXixgJ7AOwtyz7NLr8G5xp0nPycGi8Cp0mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB4032.apcprd06.prod.outlook.com (2603:1096:400:4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 02:26:22 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:26:22 +0000
Message-ID: <f4fbe385-3a31-4d8d-ba3b-409f3f03c7c9@vivo.com>
Date:   Tue, 21 Nov 2023 10:26:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: ALLOC_HIGHATOMIC flag allocation issue
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
References: <20231120023537.1785-1-justinjiang@vivo.com>
 <ZVuXlcwgcw0ShjRQ@casper.infradead.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZVuXlcwgcw0ShjRQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB4032:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5713d0-0d56-446b-ab3d-08dbea393ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSpSTV8ZAB/SN/BI1FQHBwfteDGPTYDiaXp36YihqowH85ZmvghF2aXXlebn05j4kEdnPaW/BSLndir50ItupIWgzPgQ7soTGBzySGQG2LxYNRRz0MJYlkchQemVnAKznhRT5s7Niup2+PuCvkERmnIuB8VnAxysF9RvjVlMROOl68TbcblsmC9oigCFNq0bBPnCNjrJZqkjwbE0sx2BRVKg2V7KYdTC+6B7ZFGrMCJC6aRqbeF6qOeVJlJYYENJOovJINZoJVf3EgN1SuDNI/5UaYKQGAI9iTHZWfQxxLxA1w8tz1wVHX3BelNthh0J8IyeNwUfEcBmgTJPMI4HO3DVcP4GyovORH976cbeQVIqh+/TFky/ZvYCGoF9jVCqN5dTCwyPlRBjr1HljKKVVkFG7qgUDUfxrBuPeoPam5aW7UXFPPa2ZXeMRM7geQ6+DxETcoNiQSPPuiKEa3WqcHRJiaAsp3EvEgtla+7ndwZCVOBiatHnmEKKDQRANt0tsiipKuuKquPffvORJzteNW6QHVTOjqVw3cSSOR+uHb+V3zPDKlS1O5WXjiW+MQT5C9+IuMDzabNuOyG0nHiOhTo4Fk4oc6DyN3jw1LdlzmfCBi6ODHyzMNb5Tp4RlsXZoeAxVn4Q+37Hevwgyagp8FHq/VRdWz4ApiFvcjSocJsetARIkL64ry6lDn3n2LqKf4qNree2ksLVF158S0dC7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(346002)(376002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6916009)(316002)(66556008)(66476007)(107886003)(26005)(2616005)(41300700001)(54906003)(66946007)(478600001)(6506007)(6512007)(83380400001)(52116002)(6486002)(31686004)(6666004)(8936002)(8676002)(4326008)(66899024)(2906002)(5660300002)(38350700005)(36756003)(38100700002)(86362001)(31696002)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCtxSFdjWUFaQUlmbjlBQlUxa3NZTXc3MUYzNXJVZ2Z6ZUdEL1p4cm1Pai9t?=
 =?utf-8?B?NE12U2NqbVJvM0hjMlp1dHdkYUdTVUpacGJxZ3M5U2NMbXhmdW8wZnl4MzVn?=
 =?utf-8?B?TzNrT2JQanA1bEw2OU40K0NyNlNTaGpobTN3d0NKTGNnSWxhNW1XeXM5Y0V6?=
 =?utf-8?B?eTNkbzR2bWdaRk8vcGhyWStybnI0VlJ3NkdaNk9KYmRXby9JUFY5b2Z3SE5S?=
 =?utf-8?B?NEtaK3Z5cnQwcnlnSVZOSkZ4UHJnRjVxYTQ5WEJuR1VIUTNoaEh3ejcyV2xS?=
 =?utf-8?B?UFplcGt4QUJHUzU4bVB4Q0l2cGdjMHYwbHY1M3FVQWJYWGNNQWU3VlQwNlVR?=
 =?utf-8?B?S2djUW81UVdyWkFCZnBUNHh5RE1SWGpNVmFFaEVkOWwwdzlMZmt1STJybzBl?=
 =?utf-8?B?VGhlNERUSWpUL2NOaklGUXdpSm5sMHdueWhpekZnVUp2bXM2eElxSnY3Nno3?=
 =?utf-8?B?NTVOZ1V5eEtzbHRVakVTVHVocjNzcWp2SGNUNDRRUm1CU3gzMDNJSnBGbVNC?=
 =?utf-8?B?RVJOaVZnSUZmeUNTcWdwNkhOVjh1RmZ3Y3NqRlNVUWZpa1dPa0FLbnBFZlI5?=
 =?utf-8?B?d1RLdFpZK3hVelhPNit0V0REczU4UVhuMnF6WVcxUDZ6L1FxcCtyNy9kSFVT?=
 =?utf-8?B?QzRYTXRnZU9nMGx1Um9uai8vZW5zbDRUZTg1K0NpQkFwSmhvQ1lHbWZIUlJ4?=
 =?utf-8?B?TlNXMlVpVEVLeXh6dGJnei9uZlJaaFo4Sk40bUFOalBYMVlwVC9pdGpGVHJO?=
 =?utf-8?B?SDFqek9zTmhtdFB3OTRxcWM5M3lreWF4RVJTY05OaHBkaGdSbXNJRnY1TjFN?=
 =?utf-8?B?RklYTGZONzRpWVZ6NTZTMDQ4REpWM2E3VGs4RFJrRnZURDc3cWJyUEdZdzFp?=
 =?utf-8?B?Q3pUbXVERE5Hc3BKSXoxelNwbEd4TjRHSTM5RzhLVUdoOVRTU3A3L2V4MFNp?=
 =?utf-8?B?bU4vdk4zM2JPTUFlVlVMcnZ0QS9Na01DZnJtRVA0VEZ3SXU5MEVxSm1IbENV?=
 =?utf-8?B?d3ZZd0RjSTNSUEJ5cjllN1l6TXhEQmJPc3VacDRkK0FoaUZZcHBCdHFCTTZS?=
 =?utf-8?B?M2VxbFFkRlExSjEya0UzeFFKZjVxZ1UxTDVUVmROTlc5QnJMRi9LNUI1cWc5?=
 =?utf-8?B?NXo5K0NSekN5ajdudHREZi9TV1d3aFdSR3hsMThjTjhDQ0xoTkVJdVRGVWJI?=
 =?utf-8?B?dndqa0dBVUhlamhtLzFnU2cwWjBURVhjTXdnZS9kWWZ6WFd2SDR2VEZHL0lP?=
 =?utf-8?B?L0F4V3kzZ2pDM1l4ZjhJWXQ2aC9wK3hwUG5vejBjbXNCeS9SMisyeHdGdVVV?=
 =?utf-8?B?WFlNWHJjc3o1K1pGdG5lUXZRR2sxMzdCNjQxemxzVnR5QzNkT1hYTDZ4Wm41?=
 =?utf-8?B?SzZlSWFXL1NmL3ZOME5pSUd5L29ITURmRHRXUVhDRUtVZU5JZExCR2YvOGgv?=
 =?utf-8?B?eUo3bDZHVlptWUR1b3lrWkRBYm9HYURJVWdlVjAyOEZheEFlZ29oUkFwNDl4?=
 =?utf-8?B?SHB2N1cyTElzOG1YRU93Q0VvaGR1MmxoMFdwV2RTVFY2aEZ2QmJkRGpQOXNr?=
 =?utf-8?B?RHRXYy85bVdtdHVRWWw3N3ErbjRUUzIvRHRxQU00cVU1aTZJTjZ0c3ZVbGxY?=
 =?utf-8?B?K3N2bldUWkE2S29Gd2hIV2NGeUdhU1NYYVEzQVZFRHpFai9BRWxoYWdUaCtX?=
 =?utf-8?B?a2dLbjlZQjFZeVNLTVRrNkxSekJ4VERTbjdySVhpVjJDb2lwYWlCNTF1bWdq?=
 =?utf-8?B?Ris2cVF6bGY3NHVtbVlKRWg2N3lWTEZvT1JaRHMxMnI5SGRtb21Rdk5BL3Zh?=
 =?utf-8?B?QmtoVFBnR1gyc2l0V0tvNHdDaXU1YldlOWJNeVhQbVUvazVXVDNrQllsaytt?=
 =?utf-8?B?eEhuUDR3Vk1HbGlYSkJQWWN5UHRyQklJL1piRExUVjM0am9SUnBURHhkVk1U?=
 =?utf-8?B?M09MUFVZZVp1SHJiQTNaZjNZcytRVTlqYTFOeFo4SldxODRiR1FOL3l5M1B0?=
 =?utf-8?B?ZzEvYWpPZkswVWpPM3NIaWYyUnJ6ODQ2cmgydEZ6dGtjQUNVQ2tmSFQzcXdi?=
 =?utf-8?B?elhkL0hFeEZQUUhvZjZPWTBVNHppV3FISnA4RUdzMGZLTGRYSDhrYkdocFVH?=
 =?utf-8?Q?qlY3df41exgM+mZl/xyOkE2am?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5713d0-0d56-446b-ab3d-08dbea393ff3
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 02:26:21.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ww6UJFuFOPusnVP/9wLFIriPt8PF6Kb8GhbeCWLqgeTGuW3j+5lgKSTQVHD4BKfKzUSH7YdLi+WEtfM0XUMhDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, I have updated the related modifications according to  your 
suggestions in patch v2.

在 2023/11/21 1:29, Matthew Wilcox 写道:
> On Mon, Nov 20, 2023 at 10:35:36AM +0800, Zhiguo Jiang wrote:
>> +			/*
>> +			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
>> +			 * it should alloc from buddy highatomic migrate freelist firstly
>> +			 * to ensure quick and successful allocation.
> Assuming that all the serious question shave been dealt with, let's
> fix the less important problems ...
>
> 			 * If pcplist is empty and alloc_flags contains
> 			 * ALLOC_HIGHATOMIC, alloc from buddy highatomic
> 			 * freelist first.
>
>> @@ -2918,7 +2927,7 @@ static inline
>>   struct page *rmqueue(struct zone *preferred_zone,
>>   			struct zone *zone, unsigned int order,
>>   			gfp_t gfp_flags, unsigned int alloc_flags,
>> -			int migratetype)
>> +			int migratetype, bool *highatomc_allocation)
> bool *highatomic
>
>> +	/*
>> +	 * The high-order atomic allocation pageblock reserved conditions:
>> +	 *
>> +	 * If the high-order atomic allocation page is alloced from pcplist,
>> +	 * the highatomic pageblock does not need to be reserved, which can
>> +	 * void to migrate an increasing number of pages into buddy
> 	 * avoid migrating an increasing number of pages into buddy
>
>> +	 * MIGRATE_HIGHATOMIC freelist and lead to an increasing risk of
> "increased"
>
>> +	 * allocation failure on other buddy migrate freelists.
>> +	 *
>> +	 * If the high-order atomic allocation page is alloced from buddy
> "allocated"
>
>> @@ -3208,6 +3234,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>>   	struct pglist_data *last_pgdat = NULL;
>>   	bool last_pgdat_dirty_ok = false;
>>   	bool no_fallback;
>> +	bool highatomc_allocation = false;
> Again, just call this 'highatomic'.
>

