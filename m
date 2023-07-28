Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5E7671A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjG1QPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjG1QPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:15:11 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6C04492
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690560908; x=1722096908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UNvxWevf55jDxPvpQxmSCDyqoqWWohmZYU5JaFVmGHk=;
  b=jZN5MERMlwD1UnnYS80A1yupHYK7duCIvyfkw3ZcI4ZVyxaqrW33/bDg
   x678QKm0CVc54v1kEZ9oUwn7OZQMOJQu1rDm8Z6CJU24wni5NCpep9DCX
   krysM5MuDHfHHVFrIjgDxQpIKNorRD0Y68GImSp3UrWF7SHRe3sjPUzjf
   9u5uwq1hk8lg9HZFrX6u9KDA6o28FCUUxjt+Lfszn6vdaUZ23yv3P61h9
   Xtm7mqIYqQ8+06dBOKC5DLA5Kqerhuy33+4qqzzqu0FkAQZerNwgJZnbK
   UvyTwUMSdX76zrC8l94mn3+PI2NsKCdmOZ9u1ksMehHNUQMSYuHYY9p6C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348917588"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="348917588"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 09:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="677563785"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="677563785"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2023 09:15:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 09:15:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 09:15:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 09:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0CARDDEhogmdBANneeiQ7Aur0g36uIGY8r8I51pg0hoFX+8EZrDJQzIH1OT5VyieGo2AFFQbPzChgdczwvO6nwdHqsULzBa0frVC2rKpfJ/44vagZ7uoVBcoWvmERH9RZySAIBqu2FaEdUu3aANjNWGzvOmGpbUU1ulYALxOS/xIRI1BeSPXy1EI6Qyfj4UhLYHwKOVw5knhSbAOmccHY2c46iEuwz25J3PasCs9dHLqPzIGyJOCzCSMbX1as+Y3P6XBXEhwBolLgyVdr5UdeBkDrrIP7aUsWRs8RM9sJ36aU+KEKLticwRo/moF4krYwatRiwThpyvXha/vG/GQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykyq9F++CTZEMi7kLnejCjEWRuMDRa35fnbj2pGbAro=;
 b=aZHTY+BclInVAjPwxRhXqmk6GMSlsODHbxmk/HEPJMXbKV8u53OlvGPoGgxv0AI5tpBdyHGR+BJlv13eTuw9xhpT2jSlGNUtYpWCza61HrJziNHEJYD5B8Tobzf9XLdvTFI3kIUiFSNvpjkIcnK0b6CLE5j+D6vAtmbe6PUm/8TNLwd2KAIPEoy2bWKlXoLZaSNQxitLdEDOkeZRwZm0QHft/dPgyrWPl731/RwyoyJM+21NjRGcZCu91NgL83C7BbMj87yBhPtLKnOHGmMB75l4dR8lVX/BoifK5jrsElXgn8MD2VUKDkj9OCw/eqUd60Je1r9heldqOYK8B+ZoGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CYYPR11MB8407.namprd11.prod.outlook.com (2603:10b6:930:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 28 Jul
 2023 16:14:58 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 16:14:57 +0000
Message-ID: <25faaf8f-6eb6-5c8f-de5e-31aedca61d34@intel.com>
Date:   Sat, 29 Jul 2023 00:14:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 2/4] madvise: Use notify-able API to clear and
 flush page table entries
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <willy@infradead.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>
References: <20230721094043.2506691-1-fengwei.yin@intel.com>
 <20230721094043.2506691-3-fengwei.yin@intel.com>
 <CAOUHufY2tdO0JNTiY=RzHitR7CB1cM5kA=7bd6nbCUW6KM_OVA@mail.gmail.com>
 <05bc90b6-4954-b945-f0d8-373f565c1248@intel.com>
 <CAOUHufYJE40wcT4HTYFJ_7X5=my3OPbMyMBt+QNZdByuL6j58Q@mail.gmail.com>
 <feb58221-e481-3d71-8707-6ffe90158b66@intel.com>
 <CAOUHufa9rFS-VjbCRG6KGjb4YKOZioH=dLdTyFLWqEFePoL+wQ@mail.gmail.com>
 <0843fb4d-ab0b-2766-281c-ef32b6031dd7@intel.com>
 <CAOUHufaZCCVr1C19tZH=+wmWN7pPoJMLuivr=e90Akj29X1evw@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufaZCCVr1C19tZH=+wmWN7pPoJMLuivr=e90Akj29X1evw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::22) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CYYPR11MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f89d293-14ee-447e-0025-08db8f85c94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ml4Z0VTfhy50ngDW1l9iD65d2DNqFldtAxS6a4YgwK1nrFWCk8ZYshoZWznFML8+PxK4f/4lI3Lcdt+Ogxt0CBvO0hYy7ZcVyqle1zblTwZUr9jFu4c7t/owgmVYdX/2doraMqPYbGZyGolQN04XY7s0ewHMIFu5pp9/qZYTy7GSBe5qIvI+XGjL7Dy5gut6iW2mufuS4UfTj+faj1TY2zhT8f3WlVv52PKdelnW9hb7p4+1Lt3ZXeI8yUU5KnjpTi2B8JPLTNOTznAJOY/a8bWFf0xxnar+QBD4o1vO2QVV8Rea2KWtqwujyH8+90qaeT1Nhq03fH6cPk4cdlMf7muiuVHUOm64bw+yX1bHQLv3urnRYCQspFnu2dv5ig2sbQEuO6nasqUKoY68Tcmt1AMhNtnrYduwhAFgQN7dPKaVk1E1VG0axv3Le0dcYbcN3It5yQQfAro03d5kjQ4o89dqZGk3xdrgp2LqhSul7qJ3S0mSnmLc11rEEGRDbTa7sTV0a+rpCxB2L8Z7uiZGl/wpFfYpYiY/8yrp6y+tKWDcDkFZKdQ+v5iNEKREo+qnZFrz4stahAcbj9VzqM08FlpqIqkCb5z5/f3UziU7+Aj/i7mZ54LamEQEkUfOGrvN1Szxn78dZ07070gmVzjm/ERN0x7gnsB5e/oDAU9JCEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(5660300002)(2906002)(2616005)(83380400001)(8676002)(8936002)(966005)(6486002)(38100700002)(31686004)(53546011)(478600001)(26005)(186003)(41300700001)(31696002)(6666004)(82960400001)(6512007)(6506007)(36756003)(66476007)(6916009)(86362001)(66556008)(4326008)(66946007)(316002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHU1N0VpSGNoMWRUc0pack9zUGkrT2x2Snpzdmd4VHhsRVhtTDBPYTEzUlI2?=
 =?utf-8?B?bDV1NWZVVVlOWng2SGtjRENPUFpTRlFLWU81MjhRZDJqTFFwMVZKbi9VbmJi?=
 =?utf-8?B?eEdCaFBRdExrWVBHYVVrM2ZpUmhGMXg4UDNacEIxNFJSckFzQTMya1oxU09L?=
 =?utf-8?B?anpxYktybHVFV3V2aGdHdi9DM1ZWK0xsRlQ1M0pPYzNZd1F5UTlBUEV5a1dG?=
 =?utf-8?B?c1hmUElZek5tRDJPVFR1Qyt0Qlg1dFpHN0JzeExjYXJ0bCsrVXlVTzhXYzhT?=
 =?utf-8?B?azB5aFN2QnNkM0hiMU80QW91UC8vQmVOS3FHY25wNnNwTmY5UjNlZEcya1FV?=
 =?utf-8?B?Y1l6eFZMR1QvTmVJaFo2d1dpS2F1QUdIUFIySTFlL2RaU0FQYXk3cElSc2o4?=
 =?utf-8?B?SUg2RkJNc1RCc0lmT1MzTlBlY3Rja1pDaHkzQ1M0TnlhWDlSUnpjU3E1YXh5?=
 =?utf-8?B?WnAzRW42Mm9Yc3o4MWFZbGk4K2FoZmZTbXppTjVmYmNOR0NKeVdmQ0Q1S2lj?=
 =?utf-8?B?eFZpM0xWd1ZvZHVzdndTdHlLQi9QYk1odHljUzFlM3FwUW9LalFEbGxoWkdr?=
 =?utf-8?B?ZXdYYUVhV0xVSzFpbjdwOGpwZGZnWk9jOHpPbHlkV0lCVzF6VVJEUnY0NHo4?=
 =?utf-8?B?bVJ3UGJKVGQ2VXBhUjlpSXZtOUl3WGJSOEVqVEpWd005elVrT1dBOEJURlBZ?=
 =?utf-8?B?Uzl4dk1OaVpmMFBVNjBEQkVBNnFvbXZNNW1FRHBYWk4vSmR0R09rWTdpRWVW?=
 =?utf-8?B?WWZ1Yi9SSG1nVHBNcWlOOThremZTUjAxL1lNZlNZZXZDYnVvVTFMOXBYemRT?=
 =?utf-8?B?cHlGaVk3R2Nuam16VDhRTFJpK3NhK0NJK0xTNG9KU0hxSUhKcU9uOEdaN0hL?=
 =?utf-8?B?ZHhtL2dqWStibFdFRTdCUVkra0ZPWis1VUUvN3laZG9VZWtwZy9LY2V0WnBV?=
 =?utf-8?B?dG9WSVYzUCszVDVDVEI5Z2g2eGMzb29mMHlvNHQrWmR2WVZJMm8yT3NYd2VV?=
 =?utf-8?B?TmZrbTVTNC9QcFJwQUdtODRNUGd4NXdxVkVXRzBuN0hHSnhlT09mSlEwRnpH?=
 =?utf-8?B?dkRTbjFjU1RNakJKRmUzb2FrYTA5QU00dXRFUUppUHJhVjFqaDhvL1JSWXpj?=
 =?utf-8?B?QkE5MjZST1MxemQvOXB1OUNEc0JHMEhTSGRXeDBLeEdjRm15THdLSGlwcFBW?=
 =?utf-8?B?bGdPazdzUVJrVUtMUDlPWUpHeFl5RlVrVjV0enVWMSs4dkllT3ZFRlVhblQ0?=
 =?utf-8?B?cWZqTUR3WUR2YXRoMm9KUW0wV3VjUVZScEpXSVlRTDFoY3FVMlArcmxzM0Vy?=
 =?utf-8?B?Mk5FcVdLaXJFYVVnQ3c4ejRWdCtybnhQd3FuMVVmSjNncjIxYUNqMkZ3YWow?=
 =?utf-8?B?QjBEL1RlMGluU3pIWU5SMU11dzZGRFkyKzFUWTVZVForTlpyYlFZTXhqSUVE?=
 =?utf-8?B?RlpYOC80RU9xY0lIajdPN1Q4S2wrZ1MzTllOSDl4NVg5TzlNdjRPOGp0TEpq?=
 =?utf-8?B?Qmg1b0NiVUd5OFhUd3RqampJTlM5OTVmc1R1bmVzKzJ3ZDl6bXJjK253dGtI?=
 =?utf-8?B?NWdhZEtNdGZrenlYRTVtWWVmN1FKdjFPQUhLYUx1Zy94TzU2d3E3Yi82bjUy?=
 =?utf-8?B?aERsT2cwNkt4WVg5Rk1weHZLNjRGUGh5TCswcFRFUFp4YjlqUHZrL3dUM0J4?=
 =?utf-8?B?VWFPcGZ0S2ZmK1d0VlpQL3FyQTRXOHFYbXJaUHlXMDdKTjhKZlp3QXk3ZVpx?=
 =?utf-8?B?M05zRnFnNXZwVTAxWnhLLzdJRFpDMFRNTzJqbFhBZzA0MStjMUV5enRvc3Fn?=
 =?utf-8?B?WXR2citCeEhIQy9mR3krd05Ob2psQzVxYnI1cm9kODdmdFdOZ2t5SXZVU0Vx?=
 =?utf-8?B?YWVDQUJwTFo0eXFubEhGaW0yUndXSlpHUG1Ka0hSend1TkpPQlF0MWlDYTF0?=
 =?utf-8?B?ZTBaUFFFYmp1Qml4VEU4SUd0QWJGZExVbzZWQjM0U2ZTZ2owbTFXVDdJRFZr?=
 =?utf-8?B?TE5xdTdGYUdBNC9CQUhMQ2VrZWQyNGliRzVxK0p1aWxOM3hKVU5IVGhzVzdJ?=
 =?utf-8?B?R0M3eVZyaFZodlozY3JWVmE0UmR3UVFLckpEekJOTHIwVGhUMVNoYjR3Smwx?=
 =?utf-8?B?ejk3Q29ZMFVCRXJvT3pDVXdqTDBiS2NwUDh2czk5TTcvQjRxN2lhTEFXb3Zr?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f89d293-14ee-447e-0025-08db8f85c94e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:14:57.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZsXEXGZoftv5LyoLN5KU1TinjyaIVgy0oQ8ATPwGVN1dN7GeolMyj7SBCfYyN2VbI/vJaMX1AKJGn2Efmr/oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8407
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2023 11:28 AM, Yu Zhao wrote:
> On Wed, Jul 26, 2023 at 12:21 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>> On 7/26/23 13:40, Yu Zhao wrote:
>>> On Tue, Jul 25, 2023 at 10:44 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>> On 7/26/23 11:26, Yu Zhao wrote:
>>>>> On Tue, Jul 25, 2023 at 8:49 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 7/25/23 13:55, Yu Zhao wrote:
>>>>>>> On Fri, Jul 21, 2023 at 3:41 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>>
>>>>>>>> Currently, in function madvise_cold_or_pageout_pte_range(), the
>>>>>>>> young bit of pte/pmd is cleared notify subscripter.
>>>>>>>>
>>>>>>>> Using notify-able API to make sure the subscripter is signaled about
>>>>>>>> the young bit clearing.
>>>>>>>>
>>>>>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>>>>> ---
>>>>>>>>  mm/madvise.c | 18 ++----------------
>>>>>>>>  1 file changed, 2 insertions(+), 16 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>>>>>>> index f12933ebcc24..b236e201a738 100644
>>>>>>>> --- a/mm/madvise.c
>>>>>>>> +++ b/mm/madvise.c
>>>>>>>> @@ -403,14 +403,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>>>>>>                         return 0;
>>>>>>>>                 }
>>>>>>>>
>>>>>>>> -               if (pmd_young(orig_pmd)) {
>>>>>>>> -                       pmdp_invalidate(vma, addr, pmd);
>>>>>>>> -                       orig_pmd = pmd_mkold(orig_pmd);
>>>>>>>> -
>>>>>>>> -                       set_pmd_at(mm, addr, pmd, orig_pmd);
>>>>>>>> -                       tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
>>>>>>>> -               }
>>>>>>>> -
>>>>>>>> +               pmdp_clear_flush_young_notify(vma, addr, pmd);
>>>>>>>>                 folio_clear_referenced(folio);
>>>>>>>>                 folio_test_clear_young(folio);
>>>>>>>>                 if (folio_test_active(folio))
>>>>>>>> @@ -496,14 +489,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>>>>>>
>>>>>>>>                 VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>>>>>>>>
>>>>>>>> -               if (pte_young(ptent)) {
>>>>>>>> -                       ptent = ptep_get_and_clear_full(mm, addr, pte,
>>>>>>>> -                                                       tlb->fullmm);
>>>>>>>> -                       ptent = pte_mkold(ptent);
>>>>>>>> -                       set_pte_at(mm, addr, pte, ptent);
>>>>>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>>>>>> -               }
>>>>>>>> -
>>>>>>>> +               ptep_clear_flush_young_notify(vma, addr, pte);
>>>>>>>
>>>>>>> These two places are tricky.
>>>>>>>
>>>>>>> I agree there is a problem here, i.e., we are not consulting the mmu
>>>>>>> notifier. In fact, we do pageout on VMs on ChromeOS, and it's been a
>>>>>>> known problem to me for a while (not a high priority one).
>>>>>>>
>>>>>>> tlb_remove_tlb_entry() is batched flush, ptep_clear_flush_young() is
>>>>>>> not. But, on x86, we might see a performance improvement since
>>>>>>> ptep_clear_flush_young() doesn't flush TLB at all. On ARM, there might
>>>>>>> be regressions though.
>>>>>>>
>>>>>>> I'd go with ptep_clear_young_notify(), but IIRC, Minchan mentioned he
>>>>>>> prefers flush. So I'll let him chime in.
>>>>>> I am OK with either way even no flush way here is more efficient for
>>>>>> arm64. Let's wait for Minchan's comment.
>>>>>
>>>>> Yes, and I don't think there would be any "negative" consequences
>>>>> without tlb flushes when clearing the A-bit.
>>>>>
>>>>>>> If we do end up with ptep_clear_young_notify(), please remove
>>>>>>> mmu_gather -- it should have been done in this patch.
>>>>>>
>>>>>> I suppose "remove mmu_gather" means to trigger flush tlb operation in
>>>>>> batched way to make sure no stale data in TLB for long time on arm64
>>>>>> platform.
>>>>>
>>>>> In madvise_cold_or_pageout_pte_range(), we only need struct
>>>>> mmu_gather *tlb because of tlb_remove_pmd_tlb_entry(), i.e., flushing
>>>>> tlb after clearing the A-bit. There is no correction, e.g., potential
>>>>> data corruption, involved there.
>>>>
>>>> From https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/,
>>>> the reason that arm64 didn't drop whole flush tlb in ptep_clear_flush_young()
>>>> is to prevent the stale data in TLB. I suppose there is no correction issue
>>>> there also.
>>>>
>>>> So why keep stale data in TLB in madvise_cold_or_pageout_pte_range() is fine?
>>>
>>> Sorry, I'm not sure I understand your question here.
>> Oh. Sorry for the confusion. I will explain my understanding and
>> question in detail.
>>
>>>
>>> In this patch, you removed tlb_remove_tlb_entry(), so we don't need
>>> struct mmu_gather *tlb any more.
>> Yes. You are right.
>>
>>>
>>> If you are asking why I prefer ptep_clear_young_notify() (no flush),
>>> which also doesn't need tlb_remove_tlb_entry(), then the answer is
>>> that the TLB size doesn't scale like DRAM does: the gap has been
>>> growing exponentially. So there is no way TLB can hold stale entries
>>> long enough to cause a measurable effect on the A-bit. This isn't a
>>> conjecture -- it's been proven conversely: we encountered bugs (almost
>>> every year) caused by missing TLB flushes and resulting in data
>>> corruption. They were never easy to reproduce, meaning stale entries
>>> never stayed long in TLB.
>>
>> when I read https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/,
>>
>> my understanding is that arm64 still keep something in ptep_clear_flush_young.
>> The reason is finishing TLB flush by next context-switch to make sure no
>> stale entries in TLB cross next context switch.
>>
>> Should we still keep same behavior (no stable entries in TLB cross next
>> context switch) for madvise_cold_or_pageout_pte_range()?
>>
>> So two versions work (I assume we should keep same behavior) for me:
>>   1. using xxx_flush_xxx() version. but with possible regression on arm64.
>>   2. using none flush version. But do batched TLB flush.
> 
> I see. I don't think we need to flush at all, i.e., the no flush
> version *without* batched TLB flush. So far nobody can actually prove
> that flushing TLB while clearing the A-bit is beneficial, not even in
> theory :)

I will just send the fix for folio_mapcount() (with your reviewed-by) as
it's bug fix and it's better to be merged standalone.

The other three patches need more time for discussion.

Regards
Yin, Fengwei

