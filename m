Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B976CDA8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjHBM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjHBM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:56:08 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1384FE;
        Wed,  2 Aug 2023 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690980966; x=1722516966;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QEKSbMpDNazHtcDlIANxYoEYTfzlBzVhMcJ8z/iasAw=;
  b=jIthmBusTJ4IPJflrMxhp/LhgFE2oFFKg4TOeX4ON9hakMnsdggi9gbE
   tEbI6pIQE3HIaJcYWPKq2IQuS//rBtFnfbvg+7hvrelMCuXMMq7x9XsHv
   V09fuksXrK9WcPEzbag4a2j95zuqqxRVJG8lNGFkE2OsUH0ABZaXyj17H
   Lfs0ohHT0JP975Q/YzUI3Mkwg4LUHfKNYYzsJVTKrQiJF7kLytLOnGBY0
   lrBo3SnJsYc79oFAGQx1GzEKa/X/IOyRYQ+dWD2KODPrm/fkK8uCMBLmM
   C229Lwn7nQFxztLMDvbQ0yR49mpLjZhU28yjX8zKH1+YTt9SNCUGiTE9p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="373216521"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="373216521"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 05:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="764213566"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="764213566"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2023 05:56:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 05:56:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 05:56:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 05:56:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knqae2Q+i5BfxbNQXWMG7E2fWZqepAMtLZGg3dDhLMV7oowjSW6NTUplXUviGCYwf7vp3pYxnBCtvqhhBHAckLwflYXCr9OEiVLWGCXuxL4oNKikNdVI55N0E/6Tlq6zBVR5mqCLTN8Xs89UkeMB4eD/AhaJV2WUjIosvVmQYL56oUsXk+eN2tz6GPS4d+reZLgZ8dQTepqYKjr9zZyUDQmLTEUsB+Fk95WCITAecGgidRUqeMJ93I8KWby5RvD/Jv/zG4a44nefNKxWEDNrNIT2Ng1VaL/4szrgrs1EztNT5wlUDNqU6SPZ2nVEcB3wGCpDyImjgy+s+sI/tgsGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcMNXR9yAhT9t4uB93JcttNAp5SQexjBlPod+dtmAXs=;
 b=O78E29iU4KL4t0A+cqmItxfoNCd8YU6OP61T0w3mm4BdVW5RoCO6Y66YMb6q1ZJHCuwiK4mUq+vUejUec0hWABBrAttxnj92qxWqkaFfJXlufM57I9bgEMrTiohouK2nV9Mearzoa6lyJUXVtNF93jdD4eJrwT0DTW6pdJOGA6IpidvNNxpDd6NYS2MvrQrbHSV1MC/IwkwE4dRV2+Qzhn66Oq6IOMzIAcbycPU4Y16FC3QKr0lyY1WYcOCiIoZJ5ckiLMTf+0YbNUNiWELyV7t/nyee0YOpwFBJkToL0KFqfaiyI1Sf+UkVMGI+QZAb9eHeXdqf3x1rw9rHQd0Heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:56:03 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:56:03 +0000
Message-ID: <837ba176-c97f-f81b-c044-eb6aa3d88bb7@intel.com>
Date:   Wed, 2 Aug 2023 20:55:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <yuzhao@google.com>, <david@redhat.com>,
        <shy828301@gmail.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
 <56c8f4f9-b54b-b0bb-250c-ec8643accfc7@intel.com>
 <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com>
 <5f98748a-97ca-6426-1e24-a5675da75381@intel.com>
 <a590da86-0c42-7d46-d320-c661a59a46c1@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <a590da86-0c42-7d46-d320-c661a59a46c1@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0051.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA0PR11MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: 283d2600-a2f4-4792-9e0e-08db9357d3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sNUvP18r0CDoc/qwv08iLjCDcj4XKx6xj0o8H8vPH3WKnMsSPgLCeNmScRvBAiESdarEHdL/gWlSgSQu5uXxYFFhn85jk61XZmnzTH7JGHehBnZP8nq0cHotNRVjgTRaYJb69+PkUHqQ0Mme2qpX3LWLaS6aosSBwu0ahRfeBuEwjkQM88Dr4+xz8uHfxepewfocNOjkOJKbDEZLp3gv0IYrkiIQSq7GFpkSW4V2wqcs88O7IBJY96Ej6QSLoS7a8oeG/SlmQI4RY1JVnxGMeSLdZpXcGlsNeAZPkeqkTDpfUmM8o951UvCKv7Q5CJbLd3YmOWZCYPtESFZpsAvRjknMCi6OoQ6dUZrZIwlf0Iw89D6AB+sVGTcc0uxh+qhJJO4M9C5ZcbHxXvWIVS+rKkNJJRtEnVWgqcfp1yV4jFO4aOHyE91JKwUpAJVXo6MOH45v6km/IkkzxTpjK0i0jkdrZBW9F6m5y4l1r7E38gUQp92YWQng/2drzDHnQZOacDAWGyJrxccVR+9BrdXdObX89mthedR4Sl+6N9HP+4QPkpx3RudOcQUKTaO5vX9SpugetGINMLQAugoTdTz9WA8YjhhkfH4a2ZVw4EY+Hlp+2O8Xhmho2deqTlh2DSTf3XTC0d2LCLHhO5DXeQid7NkwPITTMnKJjnU3Sq05Gg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(83380400001)(36756003)(6506007)(53546011)(8676002)(8936002)(31686004)(7416002)(38100700002)(6512007)(2616005)(2906002)(66476007)(66556008)(6666004)(66946007)(82960400001)(478600001)(31696002)(6486002)(86362001)(921005)(316002)(186003)(26005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BDc3F5SVRWUUJDQXFNR0FzZ2hGNHljcm55RmMzT0dqM2JkelBBbGNoODQz?=
 =?utf-8?B?Rzg4eXdnU2lVRjZNNEhmUUg0UHp2c2tRM3N3enJxS2t2d3p5TUs4R1FOeFFX?=
 =?utf-8?B?YU5SRlVqUCtxTGk4aVdEYnQrOFcyTk5FaVRVMXFmRWlTUFRQSy9QbkgwcEY3?=
 =?utf-8?B?TVNnSERXeEFPRHNlZXorY3lvanJUdXN1RFNFVng4R01EQmNMZ051UCsrMWRN?=
 =?utf-8?B?NVJjNUtOQkI2QUdMZ1BVamhYTldZSXR3TDR6M1pPcVN5bE05aXdlelNJZStN?=
 =?utf-8?B?NFVIaEFFdzAyQmVrSFNTZ0JWVXNyT1Y1Mm1LWTN1eVcvN1NaWmVMRjJvN1BG?=
 =?utf-8?B?QktXdUI4SFp0M0IxSW9HK1YreHlMbmN2L01FQ2tyWFNKOXU2eWMrRHNQakdO?=
 =?utf-8?B?M1ZobmZyVjFvQWV3Q25zZWxWKzdLWWpkOStES0NLUmYra3JVWjhQWTQ0elVp?=
 =?utf-8?B?UWFCMG1CWnA1Nk03M0tkLzIxaFBJcUtFM1J1bUhENHU3aG51QUNkQnI0ZVFX?=
 =?utf-8?B?R3E5SytPcDhnNGx3UnJveDFhbDA2eG1UV0trdFhjN082UC8ya0ZWNXcwdEhC?=
 =?utf-8?B?VVBwSW9lSC9sMFc4QjJPdUFJRHVYODVBek9BbGIxRDhoK0NCUmdIK0JtM016?=
 =?utf-8?B?dmNRMXc4RGFiOHBndXF1dlhPdk92dXFYYUdyeEkzY25QMjRNcG1waC9OazRp?=
 =?utf-8?B?TkFvN3V5VHJWejloZ0FuQTUzSlBFMHpaZVQ4bVBtNEUzbG91aGJERUkrdFo5?=
 =?utf-8?B?U2x3UGN3NklsNDNidTdGUXdvQUtCSDkyRDE1U2FUbURobjJaTFB6UlB1TjU1?=
 =?utf-8?B?YnlIRXZycUdNNXdCbGVpSVJPZ3M2NFNUakJORXpaaUpTbU50ekdQdGRXSGF1?=
 =?utf-8?B?WnN1ZmxjNUdQMkt3a1F5aFV1VVFJUW96a1dBUjgrbjgvSjRNNWpXL0lxREJL?=
 =?utf-8?B?NzEydXY5SjQ4WVdmeTZ5MGNmQlcxTEd3TjNHZmc1Q3M2b3Rmd1RudnFaUXl5?=
 =?utf-8?B?ektGcSswaGExNkRqNHZKZitXOFp5eWRyak9BRUZEV2ppSndkNnNTdzZOOGxk?=
 =?utf-8?B?RGNydlRRSkpJNnVBSFVqZ3VFRzhGaFdlU0JSdnpvZGZkMjVsQkhiVW9lZWVi?=
 =?utf-8?B?SjF5WDl0SHRzYnFFWS91bEFkRFRKTTV2Mml3NHNQcXBheGhVOFkyOFBQUVl3?=
 =?utf-8?B?TGJBamVXYmpFOTdLUXdUcEZ4QnFuMmNUcVJnN1JjRzBxMFhxckNocXpJT0pI?=
 =?utf-8?B?TGJDTmZleGpERmpWNjRrQVZ6NnpibUtvQW1UZFZmVm1IQ05EQjAxV3o3aG1Q?=
 =?utf-8?B?NmZOdEZxczZpdm54SDdzaHZ1WExZbElOWlBXdTVOS2VuZWZUNWFQcXZuK0tC?=
 =?utf-8?B?NVgwWVYzeDdRRnFDV2l4NURINDRZS0kwRHE1STZJdE9vbVM5WlFVVlNOTnFL?=
 =?utf-8?B?U3JOTzJDNEd6SmI1QURzSy9xUjdQTjVhR0RQUlJQcGJ4a2I5S0xNeStBem1V?=
 =?utf-8?B?ejZ0NjJKLzM4aXpsOUgvT1pxMHVTTmNkbFJpdkMyQXRZNDcvenIrYndyMmR0?=
 =?utf-8?B?MThOcWNHNjd6dS9mc3BpSjNTb2J0UUlybktuekx2SHJHRGlaWjhFbDFqOGpH?=
 =?utf-8?B?RUFRQ1gyc08zdy9GaVJSZGRvMDlNRjdudiswUkFmQ295a0tLVk42ZitYWHFJ?=
 =?utf-8?B?MHdlK09VbzhiaEJkWnB5NEFPQzNWMUNpSFlCQVdnRUNoMDl6TEZZbzFMbTJY?=
 =?utf-8?B?OXJteVhyVldMMCtsazdkR2NLQU1pTDA4VldNTjlZbEFlVXB1aFVtZXlsS0xv?=
 =?utf-8?B?SE9uaVBFeGhmd1oyV09zMXMwV2MxOTd2bTJDZU43T0NDclFuZEE3TG5IZ1RL?=
 =?utf-8?B?OEF3SlZIRHBCMFNnbVl1ZFpIb2s1aDc3bExxMmxQQ0pLYTdvdE5PcEFCT3VK?=
 =?utf-8?B?NmpiRHV0bmRlMlJ2bDh2bWI1ZzJpSWhXRWxSeVFNbkozMUlGT0lra01DMEta?=
 =?utf-8?B?TzF1WlQvZ2tycWszRUZHNVA0cVMrYkFiWlc0Z2JpaW55SnQyMjBnZ2g4RUwv?=
 =?utf-8?B?QWpYSENoTUMrYURydXdwVzhMRXdaR2E0UGFhbitHcUZtTEtOeHhRaXJibTV6?=
 =?utf-8?Q?eI96GO/J2AzxiyVBlTOPXqj4X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 283d2600-a2f4-4792-9e0e-08db9357d3ee
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:56:03.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7D8ndrjIgleFy1ZslKAo9NK056AEPO1IJZ800OJcEfJi53FO1EPLbFApzgtm9yMeh1pZ5urH3CgRKRKBu7VTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
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



On 8/2/2023 8:49 PM, Ryan Roberts wrote:
> On 02/08/2023 13:42, Yin, Fengwei wrote:
>>
>>
>> On 8/2/2023 8:40 PM, Ryan Roberts wrote:
>>> On 02/08/2023 13:35, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 8/2/2023 6:27 PM, Ryan Roberts wrote:
>>>>> On 28/07/2023 17:13, Yin Fengwei wrote:
>>>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>>>
>>>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>>>
>>>>>> Yin Fengwei (2):
>>>>>>   madvise: don't use mapcount() against large folio for sharing check
>>>>>>   madvise: don't use mapcount() against large folio for sharing check
>>>>>>
>>>>>>  mm/huge_memory.c | 2 +-
>>>>>>  mm/madvise.c     | 6 +++---
>>>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>
>>>>> As a set of fixes, I agree this is definitely an improvement, so:
>>>>>
>>>>> Reviewed-By: Ryan Roberts
>>>> Thanks.
>>>>
>>>>>
>>>>>
>>>>> But I have a couple of comments around further improvements;
>>>>>
>>>>> Once we have the scheme that David is working on to be able to provide precise
>>>>> exclusive vs shared info, we will probably want to move to that. Although that
>>>>> scheme will need access to the mm_struct of a process known to be mapping the
>>>>> folio. We have that info, but its not passed to folio_estimated_sharers() so we
>>>>> can't just reimplement folio_estimated_sharers() - we will need to rework these
>>>>> call sites again.
>>>> Yes. This could be extra work. Maybe should delay till David's work is done.
>>>
>>> What you have is definitely an improvement over what was there before. And is
>>> probably the best we can do without David's scheme. So I wouldn't delay this.
>>> Just pointing out that we will be able to make it even better later on (if
>>> David's stuff goes in).
>> Yes. I agree that we should wait for David's work ready and do fix based on that.
> 
> I was suggesting the opposite - not waiting. Then we can do separate improvement
> later.
Let's wait for David's work ready. Otherwise, some other similar fix could be
submitted. Unfortunately, we can't build folio_estimated_sharers() based on
folio_maybe_mapped_shared() because latter one requires the extra parameter.


Regards
Yin, Fengwei

> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>>
>>>>>
>>>>> Given the aspiration for most of the memory to be large folios going forwards,
>>>>> wouldn't it be better to avoid splitting the large folio where the large folio
>>>>> is mapped entirely within the range of the madvise operation? Sorry if this has
>>>>> already been discussed and decided against - I didn't follow the RFC too
>>>>> closely. Or perhaps you plan to do this as a follow up?
>>>> Yes. We are on same page. RFC patchset did that. But there are some other opens
>>>> on the RFC. So I tried to submit this part of change which is bug fix. The other
>>>> thing left in RFC is optimization (avoid split large folio if we can).
>>>>
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>>
>>>>> Thanks,
>>>>> Ryan
>>>>>
>>>
>>>
> 
