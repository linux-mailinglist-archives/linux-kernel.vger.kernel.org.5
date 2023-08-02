Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1A76CFDF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjHBOSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjHBOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:18:19 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18B7270F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690985897; x=1722521897;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=P4GJYnvUt/zKmadxqa1Oj8pcEBeYRrnRDTOH80sgrhk=;
  b=T2q63do/6m76k0QortYBmNw3y2jDAHsfkEiA3SkqkVGO9557koFzyJ9D
   eC6MmtzNFSXOOjdtDufsQgXxI1rmeL+K5N238xrYBHkJCBXz+pDEs/EEU
   jRIVYA+cKlcpf3/UGKzaXAt5vB44M0Jfrca7YqARkxBMJKN53RAvk31f2
   +0LTwojSQ0tZVmanWKUjPDZ7iod7Lx4pmXd37gDniVS4eOGQH2JNfuf/a
   jX621t4PpO81+bmKjQZY0z8/ErcMeQXUmc1zk7bzA9hiYq7wqEKbV2r3l
   57hmH5JNWMS9DszXMuWGVkg7td9w5qjsJXoqiXlz/1twGdeiAcH811wgJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433433791"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="433433791"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 07:15:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="729135465"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="729135465"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 07:14:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 07:14:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 07:14:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 07:14:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax/j7As7ARQPglQQGB3NcX9z+KI/ikxQuCvChFP7YWMDsbe7Nx7170Yb3J1zTBwodPlBSWOZYm3htgTbJPhiN7dCYwvZ8+oNB9XNM1q3uDIw7khnQ1xaoQJ7UdTFEbP6vZ0SV6FVjegFXeTMp0V1n/Jj35LpWDDjsfnS2u0bplahPpgK0I40sDBoNJgtIpg1IOn33EHe9mmpCqsY7Av/1XCPTRUjDwznHTibWaQfsft0cCJ0f8NyfJ2TP2kXaVU1d7MNB1h/pF53i55Z4Uh5dgKsIA3h89ECPRhr2xB6YmTdz1cy27JxxQ19h64HY6m9WmZ28fZ1TPMgzmzPejR/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vBjYVpnNGSFSnAKODyP9VK+kIjktlqwZ2huNzZKBRk=;
 b=KSPA37XYquUbmJ4RZMOv0vPUs+0oG6MqcKp+G3cneT2RDmZWpT/dOBh5wT+pV903DVddbvqCKBp4jOTDgMSb1Oix2ha610ZI8AKzsXazY0lMFK0vRz+toX1u4H8Rvgd2VgbYM42k4+zPiac0eo5y+wLVUk1XL+DenlRkRx5/1ibQUrUCft8g+vwzwLTHGOPjNlA0gluJW852oZl9vv+dXzaEYTX6eb0Lle5MYsbASgPzJmcdf0jDAWgdOccMWOixOC03pi0/Iss3BLa5B4+cu079/3Qn7SCOL8qrFXwmIZo8ukmdWoeXSjjwGRDhUxwOGTxo5ffV8CdTOJjycUhIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW4PR11MB6810.namprd11.prod.outlook.com (2603:10b6:303:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:14:29 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:14:28 +0000
Message-ID: <6f5301b4-57f5-bcef-45d4-68b0efbd4e67@intel.com>
Date:   Wed, 2 Aug 2023 22:14:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <david@redhat.com>,
        <shy828301@gmail.com>, <hughd@google.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <55c9e3f7-099d-6f57-32da-1f318a9688a0@arm.com>
 <eb50a427-3738-c1bb-b8cd-8636902deffb@intel.com>
 <65a36b41-d69e-4072-cfd2-253ed6e4e040@arm.com>
 <286cbca6-ab5e-ad06-ea2a-89ea08ee53d4@intel.com>
 <8dcf002a-088e-32de-7868-5dc5ca6b1206@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <8dcf002a-088e-32de-7868-5dc5ca6b1206@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW4PR11MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4e1fe0-8db7-46ff-c379-08db9362c83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1iepTOYw+ULa24zith1wHAHYULFVTqxinMYwPST6J5IyaQnuo4qHBlEWJgS1UKjZVCh5lrjIM6dr61vv4HpWI/hf3AOETSX+3fkvExAQTIaI8HqSxE5AS1BwQi3EolB+azLqFR+Z6H+j/PGr0Kz4px/s5QQqI/qPQLUbtSGnvR0mb2AbTttmSL4N5/1DCYNDoqIdAG/33E1/dftYe0qs14wPz33pedXxAzX+Q1PWRzEjpnzg9Qh7eAeLyjeCOzm9NAWutLavFP1fu/XyliNz1OKUk+e9dRwLk1qRO0LIrI4JY3VNtUdyk/n+Z4QpWX9HhT7/k9EMAVd5uV17rQqxDlu+HUOzzK5XTz95coJwAsZ7iCdvkkTUTP0K+za9l7P38ohH0z5jWqrn75xvsCuQFMowLOIKFgreWj3Z6yMpIt+hvLkq8O7YC0Ej/ee9yw60Zig68HmYPLLHl/1bNqSCWSKNycB+KUbHjzo+r37ScDuHDSYXjNr5QtBYPi3t1b7Bgp2rqi5/hiN+POcEauN0GQqbIt3fnstZU58c0JAT/ru0gPenTSo2OswLUPoisGgEtyNLBkPA4LPsi0q2OU1IjlUqwE5HErCD9kaZjNamjhOIIVcoFM4En/aMt8ttuge2HPjf/4sMjP+Wz8oxwWFRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(83380400001)(2906002)(316002)(53546011)(86362001)(6506007)(26005)(6486002)(41300700001)(36756003)(66946007)(66476007)(5660300002)(6512007)(82960400001)(66556008)(8936002)(8676002)(38100700002)(186003)(31696002)(6666004)(478600001)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFEraHhtT3pUYitwbVUzUmVnWjdVc1NiaDF5Y0h0dkxadEtCb0srNkZsSS9V?=
 =?utf-8?B?aGVsZHhlRjFsZkw2MElxam5zbWFxL1d1MmNKdTk1V3lCaXhZRG5UMThBMWpj?=
 =?utf-8?B?S01DY3MwMDNTVnhLN1FSYUw4eVk2U0d5dFdwbUhwUTNMMThacmU3OWxaTmxu?=
 =?utf-8?B?RnYzWEpNVVRBVlE1YUY5eWpjQ2thcEtzRGdCejdnUFI5amphakZvYWVZa1Vm?=
 =?utf-8?B?K1Z4Zit4Z2RGWHRLdlkvNE5JZ0xoUWJib2J4VnBhYTNqM3RxSUtxVlNuTE9l?=
 =?utf-8?B?RWZORlBvQkdOWTk5TnJCM1VkMHpKUUlMZlpvUlpYVjVtWmJ4T0Y4UHltRlNX?=
 =?utf-8?B?UEVNK1Vwc3ZmZUl5akRidG5UK0hlOVlHSFIrc29LQ3IxejRmOEdmVkZ6QnVh?=
 =?utf-8?B?VXQrYkloU2t5cXBZSWxBQlE2NWJFOWl5QnBuV0o1VjdPbXZyaWs5TWt2NE9j?=
 =?utf-8?B?RzN4a0hqVGhuY2xEYmJYdkliSDlxaHZkQ2xyZytEYWxSUXgwMVI5bVVSTmN0?=
 =?utf-8?B?YVdlczdRWmhZQkc0S2NTMEFwaTZvcGF3UkhOQ2ZzemVOcjJuTXVlT1NBTWU1?=
 =?utf-8?B?bjh5Vkx2YlRLQkE2Ry9nWmdTQUVHb3MxRjh3VnJrVmZGS1V0VlA0ak9IOFJI?=
 =?utf-8?B?cytUZUdWUVY3c2dXdU1rdi9UM3pWdzlESmpLaEpqT0dyTDBsTysyS0tkbjRU?=
 =?utf-8?B?OWtnRUpFSzk0VEJEajdySkV6QnFLMjlqaFlLR3FrSUU1VS96aXRqNGhudGV3?=
 =?utf-8?B?dnplMXkwSFF5a1dCQlhOcWpjWG1pYlZ5eXpqR3BlVlpwOFVsRjJmcUVBOGJ4?=
 =?utf-8?B?a1h2aGRNZnpVNjJUTXBCc3o1S1BTSlRya3V6TFFpN1BEVnlCR1hMVjFZekRp?=
 =?utf-8?B?WE94UUorOXo1TjliNGpLc0tIKzZGZ3REVkpaVnVvbm9WUGlNdEZMYVlaaVdU?=
 =?utf-8?B?dlRSUzRMbFY5Q0t6dFFId0JQOEVGNkVxbE5zbWhtNHB4UFl6ZlZIcGU5eHgy?=
 =?utf-8?B?SzRhdE9YWFN3UWhwczNCd0xJbnVibVBsMG9LMmxXTEFZQTlMZGRRaC9OcE5n?=
 =?utf-8?B?Z2d2N1BHV3ViR0l0d0IzdHh4WWw1cEViUmZqNGNIUmNpTzNXS0JlMHE4UXpM?=
 =?utf-8?B?YkhmSm5hZy8zU3ZxT0psVnBQakNRYVBJS1prQzJCbW8zMjErTTd3UUROa0Jt?=
 =?utf-8?B?eVdyTE9mTS9ra3BKNENMWmFiK1NVZXRXMnZYSnA3M1A2bG14WmEvWi9KZmFq?=
 =?utf-8?B?REV1dUF1bHZjM0VaMSt0UktJODAvT3RLOWs0OHh1cldRNDRETXdWUVpoWVFj?=
 =?utf-8?B?K3AwR2dKRXVsQzhIK2xpTDNJdUdXb01abW4wY3NySm0yN0o2Qks3K3pqMUJO?=
 =?utf-8?B?RmtHc3kzM0JLS0RObjBMT0JxbXl6ckpkeDNhMjRBcFlITGtKQUQ3TERVL0Ny?=
 =?utf-8?B?QlUxbU52SHBrUlpZSmhTTkNEcVg3M0dGMkdQMWsrZUpXdW1aVUFMT3pRSm1D?=
 =?utf-8?B?VUFjY1RBdGcrZFFpMnQ0YU9kYng5K1lqSXpaSmdhNU92TTZibzkrZzMyWmND?=
 =?utf-8?B?QTA0SENnb3FqOGJWdlVMcVMwVXpQeCttTy9vUVFJY0VsaVgyMTRlVkRFdmFo?=
 =?utf-8?B?Y2EzdHpDeENVeDBhZis0cnFCQTRlSWJjUGFFZjZhMnU3SlRIYjVoOHd0MHlP?=
 =?utf-8?B?V1dUUS94SFhvMEoyaFBybCtyMWFUZmJldlIwdmpzVlYyVEpEM0VrZkdpOERn?=
 =?utf-8?B?Q01mUm1SRkMwUjZQV3c0ZlFIamg2ZEdyZThZUmIyOTJPaEFzSGljaSs5clgr?=
 =?utf-8?B?YjgxZHgxS2FyZVpscXZGYUE3RFRpUi91VW5lUDczbzR6VkxTZHVDRmtqdEth?=
 =?utf-8?B?cE80MG5DSDZJdGRLRjBRRkJ3Z1RvbCtCakNGRWpPbEoyU3lDRTE0aWJPVFlC?=
 =?utf-8?B?WVU2K0pDMkFFaVFodGhEUUVMNUgwTjI4U1RVY09Lbk91Rzc0VWdPUTBKTnZZ?=
 =?utf-8?B?K2NqRDUrKzQ3NUo4QWI1V3NNNUtGY21TNHZaL1NxVEhGOEJqRENFaE1GaDdW?=
 =?utf-8?B?b2N4c253dDJEeXE5YTJlMTBncDJwdmM5dVllU3diMVBvZVJQZTB4cGJVajVW?=
 =?utf-8?B?YmxvdjN6YzErMzJudkJQV0J4YTFZTG5wbkZKdlF0UjJnc3YxdWViNWZzVWdZ?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4e1fe0-8db7-46ff-c379-08db9362c83c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:14:28.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JnlyMJo7NAfpXvHm0xe6MUj8D0ZCuBw4Bn8xBfxLgQUwhtLLN1Vz2SGZq44ZWv6t13P3PM7N+P5f+gQw0Lqpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6810
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



On 8/2/2023 10:08 PM, Ryan Roberts wrote:
> On 02/08/2023 14:46, Yin, Fengwei wrote:
>>
>>
>> On 8/2/2023 9:09 PM, Ryan Roberts wrote:
>>> On 02/08/2023 13:50, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 8/2/2023 7:14 PM, Ryan Roberts wrote:
>>>>> On 28/07/2023 08:09, Yin Fengwei wrote:
>>>>>> It will be used to check whether the folio is mapped to specific
>>>>>> VMA and whether the mapping address of folio is in the range.
>>>>>>
>>>>>> Also a helper function folio_within_vma() to check whether folio
>>>>>> is in the range of vma based on folio_in_range().
>>>>>>
>>>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>>> ---
>>>>>>  mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 69 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>> index 5a03bc4782a2..63de32154a48 100644
>>>>>> --- a/mm/internal.h
>>>>>> +++ b/mm/internal.h
>>>>>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>>>>>  				   bool write, int *locked);
>>>>>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>>>>>  			       unsigned long bytes);
>>>>>> +
>>>>>> +/*
>>>>>> + * Check whether the folio is in specific range
>>>>>> + *
>>>>>> + * First, check whether the folio is in the range of vma.
>>>>>> + * Then, check whether the folio is mapped to the range of [start, end].
>>>>>> + * In the end, check whether the folio is fully mapped to the range.
>>>>>> + *
>>>>>> + * @pte page table pointer will be checked whether the large folio
>>>>>> + *      is fully mapped to. Currently, if mremap in the middle of
>>>>>> + *      large folio, the large folio could be mapped to to different
>>>>>> + *      VMA and address check can't identify this situation.
>>>>>> + */
>>>>>> +static inline bool
>>>>>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>>>>>> +		unsigned long start, unsigned long end, pte_t *pte)
>>>>>
>>>>> This api seems a bit redundant to me. Wouldn't it be better to remove the vma
>>>>> parameter and instead fix up the start/end addresses in folio_within_vma()?
>>>> My understanding is it's necessary. As for madvise, we need to check whether
>>>> the folio is both in the range of VMA and also in the range of [start, end).
>>>
>>> But in folio_within_vma() you pass start as vma->vm_start and end as
>>> vma->vm_end. And in this function, you narrow start/end to be completely
>>> contained in vma. So surely there is only really one start/end you are
>>> interested in? Just seems a bit odd to me.
>> madvise() will call filio_in_range() with VMA and real range [start, end) passed
>> from user space.
>>
>>>
>>>>
>>>>>
>>>>>> +{
>>>>>> +	pte_t ptent;
>>>>>> +	unsigned long i, nr = folio_nr_pages(folio);
>>>>>> +	pgoff_t pgoff, addr;
>>>>>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>>>>>> +
>>>>>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>>>>>> +
>>>>>> +	if (start < vma->vm_start)
>>>>>> +		start = vma->vm_start;
>>>>>> +	if (end > vma->vm_end)
>>>>>> +		end = vma->vm_end;
>>>>>> +
>>>>>> +	pgoff = folio_pgoff(folio);
>>>>>> +	/* if folio start address is not in vma range */
>>>>>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>>>>> +	if (addr < start || end - addr < folio_size(folio))
>>>>>> +		return false;
>>>>>> +
>>>>>> +	/* not necessary to check pte for none large folio */
>>>>>> +	if (!folio_test_large(folio))
>>>>>> +		return true;
>>>>>> +
>>>>>> +	if (!pte)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	/* check whether parameter pte is associated with folio */
>>>>>> +	ptent = ptep_get(pte);
>>>>>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>>>>>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
>>>>>> +	for (i = 0; i < nr; i++, pte++) {
>>>>>> +		ptent = ptep_get(pte);
>>>>>> +
>>>>>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>>>>>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>>>> +			return false;
>>>>>> +	}
>>>>>
>>>>> I don't think I see anything to ensure you don't wander off the end (or start)
>>>>> of the pgtable? If the folio is mremapped so that it straddles multiple tables
>>>>> (or is bigger than a single table?) then I think pte can become invalid? Perhaps
>>>>> you intended start/end to always be within the same pgtable, but that is not
>>>>> guarranteed in the case that folio_within_vma() is making the call.
>>>> If pte is invalid for any reason (pass wrong parameter, not fully mapped etc), this
>>>> function just return false in page table entry check phase.
>>>
>>> Sorry I don't think this covers the issue I'm describing. If you have a
>>> pte-mapped THP that gets mremapped to straddle 2 pte tables, don't you have a
>>> problem?
>>>
>>> example for 4K base page set up:
>>>
>>> folio_nr_pages = 512
>>> first page of folio mapped at vaddr = 2M - 4K = 0x1FF000
>>>
>>> If you then call this function with the pte pointer for the second page in the
>>> folio, which is mapped at address 0x200000, that pte is pointing to the first
>>> pte entry in the table pointed to by the second pmd entry. The pte pointer can
>>> be legitimately manipulated to point to any entry within that table,
>>> corrsponding to vaddrs [0x200000, 0x400000). But you will end up subtracting 1
>>> from the pointer, intending that it now points to the pte entry that represents
>>> vaddr 0x1FF000. But actually it has fallen off the front of the table into some
>>> other arbitrary memory in the linear map. 0x1FF000 is represented in a different
>>> table, pointed to by the first pmd entry.
>> Yes. This can be an issue as hold the second page table lock can't prevent the first
>> part unmapped. Let me add another check vaddr align to folio_size in next version. 
> 
> Locking is a problem but its not the only problem. The 2 tables are almost
> certainly not contiguous in virtual memory. So once you have moved the pointer
> to before the start of the second table, then you are pointing to arbitrary memory.
If vaddr is aligned to folio_size, suppose we are OK here (I have assumption that
large folio will not be larger than PMD size. Or it's possible on ARM platform?).


Regards
Yin, Fengwei

> 
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>
>>>>
>>>>>
>>>>> Also I want to check that this function is definitely always called under the
>>>>> PTL for the table that pte belongs to?
>>>> Yes. I should spell it out. Thanks.
>>>>
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>>
>>>>>> +
>>>>>> +	return true;
>>>>>> +}
>>>>>> +
>>>>>> +static inline bool
>>>>>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>>>>>> +{
>>>>>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>>>>>> +}
>>>>>> +
>>>>>>  /*
>>>>>>   * mlock_vma_folio() and munlock_vma_folio():
>>>>>>   * should be called with vma's mmap_lock held for read or write,
>>>>>
>>>
> 
