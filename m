Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C975E1D1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjGWM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjGWM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:27:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69511BD1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690115226; x=1721651226;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SQ23Y4RUZ89n/pI1nQ+w4ON0Ls9C52iyCmcof938pvs=;
  b=bSAbwQOsG1i52Zj/zGXlz2iW/+df337uDKvM/3014o8cj1G9C5k8V1hS
   kKnKp3R/sylI4VY5X/fmMq/1Toqwud18CInd//nF/NTjmZr50hqMqhpHo
   Gn0U+HovrtGJFt33hofUtwhsAF4H6hJgUJrPpRJTDkF0X2ZTqV3WRCypt
   zEcpnovIDIifhDN/UWz9WavuWAw9kn3TZoJQKrfnW/mygUsoQBKXauxic
   lumP5VCYrZbwAx65q/WrkrmJqOFkrMkExZtM/xSt7MVwqxZGgZ/yT/e0f
   nPexs/gk5Hy6Z9A+6y8E7gZt6EQb+NRLjpkLt8rx/E19qm//nmK/Pc17y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="352169643"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="352169643"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 05:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="725406491"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="725406491"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2023 05:27:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 05:27:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 23 Jul 2023 05:27:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 23 Jul 2023 05:27:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaW884nHdCiUTn1JJT/uFAKkeNqwRZueSV8uwkVZQWx3SiBY96rAsXklRSEEpQ3/uOvdF/zV3K7hkEx45Y3zDIouSLWmcFyEo+QF9O55olAdGv/W9VBEet1jHZkIomF/8QJDGVNzptYR6rDhMOzAZz5U+XLCRSMSjjV72iBqcEvV4X1Vjv6JuT2+Q/QJnKeXqJgSmTs6/o3o3EvxDYan/NEXwvFxKrafBViRijKEIdEXA2kBLUIQ/26GPOuu7b891ikUcy6nxjOSfQ25KRFpVUdwto0AKbSX1T04n+U7WVCZNWq+ab8p6J1UsAucSHoIL4D0A+JIYpgOeMxThJ9fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYBTJMmbWeXVKKODXiLEP8FQlKlDh8TNFJoQixab028=;
 b=gRQpGpf52D4o1CUuCA9QOFewbZzGBFxhl1kB+i+8SBDi2lm7r6NaxgeFj6kPA2XhDzKepACQhcZyjBmLoBMHIBGueyphX4sAIm73Y83etQd1PLd+Un/gGjGqMxT3ugFZ8cGgfvr70UuW1KqqNH94ffVzNQy4xqjSUwUmtI1E9Z4AOPkOZ038J/boDFwSnMHxbifB2cZmlUAW5Cj5P9ShI/oQcQY7UzPrSUZlzMFft5voZ0HToFEhWkeCQrywbk3TGVgBfN5BijsXNaMp8ZSv+anoJEU516xIxdTRkEFrZ0+4Olskqb+97Cl21M+TJ3T9aLf8tneLTOE0CbKsRqwN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 12:26:58 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 12:26:57 +0000
Message-ID: <cd64f4f5-e77b-d51d-637e-51cf8dba8277@intel.com>
Date:   Sun, 23 Jul 2023 20:26:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 1/4] madvise: not use mapcount() against large
 folio for sharing check
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <willy@infradead.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>
References: <20230721094043.2506691-1-fengwei.yin@intel.com>
 <20230721094043.2506691-2-fengwei.yin@intel.com>
 <CAOUHufY0AX_wyBCZ3dNMfTg7C1ZBOZHpYSgG=uOwbeeemyFX6Q@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufY0AX_wyBCZ3dNMfTg7C1ZBOZHpYSgG=uOwbeeemyFX6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CO1PR11MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 9117e471-a6ae-432c-e456-08db8b781b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84XwFFdHHomm3huIC67jGqClNUfEdFex1BzMJgUTEVUj0XbnY9SgHmdRHqB0aqqalh6nCRACYCBD6bat2cfT+tiDiWZTw33bVvoHNO3KVRFn+qJp6iUydOjrMuUg7VE2f61esUUQ+p0mxhG6L/yfaMOLlNjZeQ/ceSRzIPMWW3KiLs6e6CSRPHqGgBVTAv76OTd4ul2VEejhxR+I1k0W+Zd0apz/IhBYnmOMGzqeyoZktsN7w+VwP3Qk+JtgM0Y2r4ErCiUw8ZJnFys9XX/xnLv2W9RvmzCr3mio2rng7JE+Fdgadf9RpsukjUcdLuMgWwlXvMd7QmzNt+8ABDn2fqfEP3FH2am3yBCG8SQJkoQI9PmyK8tiIGKq5RwMQdjrYDJssbFaIyfpsjvHxB9CRSb3m7k3zPFyJpmwv9UnTp0ZQAak0BFFshq4UBiZqlMNX4UjaG3qeaUE3+bVkAsB9E2c4BasJfopk/vo5vRMpq3zCrMH6wDAlcsdv69aCQu9bOPidXz6SWBjD6LkOtPDVriFc16PMdrCJi9knuBljrH4ImNgfb1KX5Q5ytSVbgeGwpUJUm1yaT/35Zav4k1YbLLlIgsEqluWK7LCqEDO5/YLCrdi1oCx2mGlyx2C3gNO4ODNN161+gIWM5dWAxh/5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(83380400001)(38100700002)(36756003)(86362001)(31696002)(82960400001)(2906002)(478600001)(26005)(186003)(6506007)(6666004)(6512007)(6486002)(31686004)(5660300002)(8676002)(8936002)(316002)(41300700001)(66476007)(66946007)(66556008)(6916009)(4326008)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nzg2Q3h3L2hhckpuYWczelYvSTJKcWg0VnB6VVh3K0N2VU8rR253TmV4Wm1j?=
 =?utf-8?B?RGpnbFkybFhmL0UxNDJoZFlOKzFFenh5bW5rK2FUUWVxamsxSlRQRnpzcmZz?=
 =?utf-8?B?T2dKYW9obklvSGFSYkpPK3RqOStZcW9oWTk3Y0pvYkRDdFJFOE4xNjg1UCta?=
 =?utf-8?B?N0g5eHU0V2YvSEgyaENjdEk4Z29sTzFyZW1rRmxWcXBTSDdGV2c4d3FFdmVm?=
 =?utf-8?B?R09GZjJWdDlMWW9NMUNIeGQ2MTV1cVNVNHkzbzV5RGEyKzVnUHZ1WTk5WXEr?=
 =?utf-8?B?SFhYSnJyclQzamZpMkNRcXREQXFFM05BVmpVd0FJbXFWWnlJOGN2bnpsRk9H?=
 =?utf-8?B?REQwdmpVazVBbTBFMFV4dksxdFc3U3Y5N1k2eFdEVkF6dndBbTFwczJnQjFR?=
 =?utf-8?B?Z0JsV25kbVprZm55aDNVRTZDd0JkY2JSeW01ZTlzRVBkdkd4L3N2WWc0NjNz?=
 =?utf-8?B?T0h0bTMrNjBRNGlvM3hjQWV6bkdxTExlcElZcWMvb0o0V01Jc1IzRENvNHBI?=
 =?utf-8?B?cWV0bHdTcG5kQXpxTjVRZDJQanVPOW1VcDQwVHZHR29laTI1bm1tMHBLaU1S?=
 =?utf-8?B?QStIZWdqWVZnVjdMek1LZ1hVQmRJemhZUmhZclh1cjF0KzVOUHNyUWZhLzh4?=
 =?utf-8?B?ZnB1VGExK0ZWMVUxL042dXZ2ZGF5Q3RyWVpuQmhHL2cxME5nVHpGMW1NZSto?=
 =?utf-8?B?Z1ZVenBRdG9VNkVoRUtIc2JvM2ZpY0FZamgrQmszYVBUYnZiL2Y3cWFWODNJ?=
 =?utf-8?B?aXhWMmIzbEt1NHVCMGl6MTVwTTFNSUZxSUI4OUNFM0tnVk13N0o3R3dhYWtj?=
 =?utf-8?B?anY1UEoyZjR2V3FIeDZqaWNoRUlmR2JnazQ5RUh4a3JKb3R3UUVMYzhpS000?=
 =?utf-8?B?cG0rMTNEanJMZ3VnYWRIV2lDdmd6MGxPT3J5SW11OEJhVEtVRkZUOGtBR0xS?=
 =?utf-8?B?Q0ZVWUpoYmRXNnJQWVIzL2NMVlRxdGVqaXA4Sm5sUVEyanF2bGtvYVRWWEpr?=
 =?utf-8?B?MzZVUDBoNFVrVVNPQU9XcHBqNlh2SmZwY2g4aTFGaEZHaERveGRhQ1VMQmhj?=
 =?utf-8?B?cElOS2NhSlF2bWsrQkJROWtGSmZMQ3dUb0lUdHUyMXVkWDJCM1Q3K2J6SUVv?=
 =?utf-8?B?bkJleVc1Z3Z0bGJTU0Rlem15K05SZnF1QU1iR1plQWJFcVBRY08yZDhBUEVX?=
 =?utf-8?B?T3hIWGNDMVRvUU9icExJQTNUUWVrS05QZ2FCTUtGUGdQdXBRMzZ4V0pCQktw?=
 =?utf-8?B?eW1ZN2dIU0lONDJrY21JUDh3RFJPN2RRYk1DWTRDUy9ERlZYUVllS0xGUmxK?=
 =?utf-8?B?VXRqNzVFQ3JJMkNiQkkyWXpsSmxDaGlaMW5CaEZFNy9kQ2FxSWxqdXhDNE9L?=
 =?utf-8?B?S0Q1MUhSbnFWa0x3V0hUNVNuQnlWMlh6RkdSaEpBTEtuNWk3SVl2OVkxSm5q?=
 =?utf-8?B?bVhBTEtGNkVLaUFiSHF2Sm9qNGE3VHBGVlp3dXRGakNibmRDQ0ZUcERMdGl0?=
 =?utf-8?B?SlN1cHVNdXEzWDFaMUNXNTlzejcrZnRxYmpZRFBUQlgyL0J5Q1JjRGh2aUZo?=
 =?utf-8?B?VGc5NVMrdGVWbFowSjZGblkzWlNEaExQMm40RUhkcEhCTmphV1c5a2RST0xG?=
 =?utf-8?B?bDFESTRjNDRYNUhWaGwvekxsbVZqdzh2VHZSeG93UDcwMGR1VFFhS2xhaU14?=
 =?utf-8?B?U3lycnJCVEE3dEFDYVBOcm9kUHVxd2sveXJoemNma2hlM09UOU11SVBhb1Qr?=
 =?utf-8?B?bnVVdFdGR1V2N3kxdkZMYkRIUTdOakZnK1BvQ3VrS3YxN0NWaXh0bkUvbXJZ?=
 =?utf-8?B?V0JSZmNVRlhEU0cyR1ozZlVqb0JpMlgwYWtvbUpFNU4xNTdSRDMrdVl1RENa?=
 =?utf-8?B?VGZWczk5d05kdlVqa0xoclRUdzZsY0N5VCtxdXVXZnd6WGJsanlPUkFQL1lz?=
 =?utf-8?B?dTBvVXd1d0FMNGZZSUhrSU5YUUpzaklNbjdRVVhlcmlOYkkxemlRcGQzeHEz?=
 =?utf-8?B?UmIrMEFnN0VrRlc1YjRtVzA0UXVqZzNKbStOS0dWMWo3OENXdWU4ak5YYWVO?=
 =?utf-8?B?UENSdVZ5djRPZkVoeTBPWDJyRDNFQlFteXUydUpSQjQxWktlbVljYWdXdkN4?=
 =?utf-8?Q?DPasA/xC4W0SgmVf159exRh9e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9117e471-a6ae-432c-e456-08db8b781b67
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 12:26:57.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upUNbOqwTar3mqdocH68hU5YkZlg7pqUpKCQ1YtgeLwuvc15pgrqlGwnQDqXSJNdUJAi+JmlwmguCEvFhNq30g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/2023 2:57 AM, Yu Zhao wrote:
> On Fri, Jul 21, 2023 at 3:41 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> The commit
>> 07e8c82b5eff ("madvise: convert madvise_cold_or_pageout_pte_range() to
>> use folios") replaced the page_mapcount() with folio_mapcount() to
>> check whether the folio is shared by other mapping.
>>
>> But it's not correct for large folio. folio_mapcount() returns the
>> total mapcount of large folio which is not suitable to detect whether
>> the folio is shared.
>>
>> Use folio_estimated_sharers() which returns a estimated number of
>> shares. That means it's not 100% correct. But it should be OK for
>> madvise case here.
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> 
> Fixes:
> Cc: stable
OK

> 
>> @@ -383,7 +383,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>                 folio = pfn_folio(pmd_pfn(orig_pmd));
>>
>>                 /* Do not interfere with other mappings of this folio */
>> -               if (folio_mapcount(folio) != 1)
>> +               if (folio_estimated_sharers(folio) != 1)
> 
> Strictly speaking, this isn't a bug. But it may be ok to include it in
> the same patch.
OK. I will drop the change for pmd.

> 
>>                         goto huge_unlock;
>>
>>                 if (pageout_anon_only_filter && !folio_test_anon(folio))
>> @@ -459,7 +459,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>                 if (folio_test_large(folio)) {
>>                         int err;
>>
>> -                       if (folio_mapcount(folio) != 1)
>> +                       if (folio_estimated_sharers(folio) != 1)
>>                                 break;
>>                         if (pageout_anon_only_filter && !folio_test_anon(folio))
>>                                 break;
>> @@ -682,7 +682,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
> 
> What about madvise_free_huge_pmd()? Should it be changed as well so
> that it's consistent with the first change? Either change both or neither.
> 
>>                 if (folio_test_large(folio)) {
>>                         int err;
>>
>> -                       if (folio_mapcount(folio) != 1)
>> +                       if (folio_estimated_sharers(folio) != 1)
> 
> This is another bug fix and should be in a separate patch.
OK. Will split to two patches.

> 
>>                                 break;
>>                         if (!folio_trylock(folio))
>>                                 break;
> 
> Please send two separate fixes, and then:
> 
> Reviewed-by: Yu Zhao <yuzhao@google.com>
Thanks a lot. I will drop the mapcount() change for pmd and sent to patches
for madvise_cold_or_pageout_pte_range() and madvise_free_pte_range().


Regards
Yin, Fengwei
