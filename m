Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC9376CD3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjHBMnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjHBMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:43:36 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CE0212D;
        Wed,  2 Aug 2023 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690980186; x=1722516186;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lQqsBfeRJrQn0cUhQfZm+ghV3Q8PmK4Oei6G/zuWWx8=;
  b=E0NDCbvefmE7Dlzs9/pMXxSvpMBniD23vkreKmWkSlN1PD2KjVG7at/t
   2KbmaczNoEMwiqwQYOdMIuinIMcqKClc7reSQo8aZ7lZ/chqYzna3rumP
   BpgpnxG2Yp1HHeF+XiMCUVcr6wrye0g7A7LPXXqfq4jDWOMWuNA5WiYdc
   Sq9GtNlTSQPYUjvwsdGJOD3qF+i+a7Mo9QzkobsgGh84VDyZfXpYN0Rux
   KSAoZnf00DUqMNUb9xxPIseTAueDNp6gnpcz0BHzv5G+bWciWSo9kzE34
   4u7YkWzVlYdpfnbCQiMeH3Z2taSIf82AkOiX2IRuGYnwgDGaWYkvKGogc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433406327"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="433406327"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 05:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732364347"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="732364347"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2023 05:42:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 05:42:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 05:42:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 05:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuJ/QM/Xu66QrvJYdbJMn4K0f4TZW47usuXJMQf3ltEYRGfhCC4UE9R3Z3Udq6/t5BeG4C0ZnwbOKfw1kvfw8CEReAKRtEEoKWis0QZLmbQ+odiBFC3dUfjOz7XPkEfNp24P78qwCknl0iKcvRaejCNujXsb9B+ZXiUGuycBQ86cW9Ua1E30bvXN4IW+Ze27ZhL6Q6j9+e5eNkuvIdee10IwlIDpkKk4zNy54wLt7iClnlb1fmKF/w1/bHQmxhKv1m3ESxwBFBdRjhHNAEmjbvGC0bIrzz7L52RRFXPGtgKsdw2eEG0UrwpJfkeov/orda6Mgif8EQYR0yEsK2I6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEHfg8yhG01pcEasxpuswpRdoEi0XJH3H7aSZq8ORFU=;
 b=hkCa/zaD3d21QDF5//Z0NLEKaStIThigp56PZd5JI8Vefcrh+iE47FKLqOeupaSQv8hh+oJmq4HeAh7rEiua5VqBhAuvNSqMMoNNa6vHxFBADZ3OFx8enllNSM9vjHDthdZE4cDFeuwi9TaUP/xvpMoXagan02fRaoPgQ/qGccW2kF7sGWVNxZBExdecCvm0Hdv521HVbEO/wIVnq9hVPo/fuwjjLdEoswA7vRWGO1v14VyYmjjOA+rJ26B5nIKo4R/NbxrP+gPUqj0FrExV3SqYxpmLM3Pl4lK4MD6IN04zTyhYFTTMCcCJOy/nUl75Nsapj+iYjQgg2EJGYoPX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA2PR11MB5002.namprd11.prod.outlook.com (2603:10b6:806:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:42:14 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:42:14 +0000
Message-ID: <5f98748a-97ca-6426-1e24-a5675da75381@intel.com>
Date:   Wed, 2 Aug 2023 20:42:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <yuzhao@google.com>, <david@redhat.com>,
        <shy828301@gmail.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
 <56c8f4f9-b54b-b0bb-250c-ec8643accfc7@intel.com>
 <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA2PR11MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb5c9f0-7dd5-4d5c-f268-08db9355e618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0RuZjmpr07LNFfwMbptA4eLhMVbMJNCXdiLdZm9GrhHjGSKN8XoZultNGtLNcvABBteOF+z44rX1LA5T/52aVzX6rAhnocpsU3mHG2hIcVDE1RSw9Cr9PTNOqPud4ESSE4EX5yVdq1884duMn0w58oN2eXOE6MkPUqCFpofskN6+cpXld7xHO5Q7He4GMe90Rhp/nLLeyeRqL0K0hgM6TDPHcV9e/kMA5z71XYbQBi8txNZ7U2UH4MiRGUTqP5rtCrVVwxjiDMFKykIXxQeSym51Ta7JhpsGa5ZtvbD2icRdYNH9p7nQNzfyyVosNxPBvfNh8xliEMcOXQ8itpiShD3QL8tnJjNLLJVAT91NGBARVaAt8X2Us+LCldrey24vyHniBlO95OpbQXCdmHBnjqRYzxTzW88Lh5FeaZBEOqU5UTSvhksNc7dYYvr09aHKo4UJf2e0Lo7dNJEjhFpqlgjegCGSXyMXsC3yMZYgmfcKou1yWBi4z0aO5ZP85tgBR87MbxaF6fGOOHlTaMiQCqP4sBoV0YlxVVOIe7Eu51ZPexpLKFdXgZZVMfkbryt99BjSUIStvbyNolcQO3G2LbJMbOxEHX1eiUXB6NqeQm7XW7Ey644WwKlXNZGBVj30TiIgXBf7AxCgXaw58FDV/w5aw17kDDMx1wOk1tjghQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(31686004)(7416002)(41300700001)(5660300002)(2906002)(83380400001)(2616005)(186003)(86362001)(478600001)(110136005)(316002)(53546011)(26005)(82960400001)(6506007)(38100700002)(921005)(66946007)(6666004)(66476007)(66556008)(31696002)(6486002)(6512007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGV5RzR6azh2dGlyVThRVFJVU3VuVFVYYW41bUpwM0pZVnFuejBiRzl1SEF3?=
 =?utf-8?B?SlZ2K2c3Z1IwQk5OOEpSaUNtY2VOV1Y0ME9GSUppdnZ0Z2duQ3REeFdJWnA1?=
 =?utf-8?B?akNZWGZrMW5ZSXRmSysvQUswdm1VT2s2aEFSWlkzUC83bm1lNXpBa0xyNUgw?=
 =?utf-8?B?bmVYeWhCZ2RtL3ZtNDhOUkVzN25laUZYelFuMVEranozd3FsMmd5bnBFTVpN?=
 =?utf-8?B?VWFIcXdyM2pydUY5bnh4Vmt2dzNZVDFpaXNqRitkVlFCUWdLNm1CS0dORGNT?=
 =?utf-8?B?RktWYVRPeW9JRWZ3QWVIRUVxcXpJTi91c2ZCTmgvdXlhY3JSTEVDODh6VEZJ?=
 =?utf-8?B?bzJmMDF0ZmxIVVBpYUpUM1ljOGVrK28vZlA5a2kreE1rbWxjalVBZW5XMDEx?=
 =?utf-8?B?VUx6MCszS2FCcjV0VkEyTStRRko1T0RTR3VPMEVKNllaN1V0YnVyYjNEVTZi?=
 =?utf-8?B?UXRuWWZVODhNVTc0VVlyTnAzcHdZRkFUVmthcFg3UzQxSS9hQU1BV2hwL3pi?=
 =?utf-8?B?alAxeVNuemYrWXNjYzlSeVRrWkFvUXVuTGFzcE1BcnpJLzZzWlhjMkl1cXBw?=
 =?utf-8?B?bXgwSmZuc1pyVDFVaW1kbXluR0c4UncvYzhlMC93S2pqbysvT1NFQm1WeVh5?=
 =?utf-8?B?K1p5VHdlYXA3WjFCY2ZVMEVLRngzdlR4Z05DL1h4Q0FWblgxY0ZzRFhqNFBK?=
 =?utf-8?B?OG1UKzZ0L0h1NzBJeWcxSHJsaXRDNmJNbkhLUG9kZWxmSnJPNHI3RDIya0tx?=
 =?utf-8?B?UUc1eTBoekdtcmNlWFFHamtDNFlzMSt3OERuTWtQRFdmUGhsaDNIeEhKSzJG?=
 =?utf-8?B?SmZMZWZjakNGQ1FobFVGRmF0ZXR0bFloUm1VKytReEFmWUhQUng2b3gzRlFz?=
 =?utf-8?B?cjZ6eTdYMDQ1T2xZSVpKK0FwQlgwUkZOTTVsci9TVDVJTWIvTms0MFpaaW9S?=
 =?utf-8?B?SXNuVW91bkNCSnFmUjN2V2pxcXVqNVl1eXhKQlFraVlKWlFoRDdrMlJjTTN5?=
 =?utf-8?B?T0drQWltZWIzbjRpNWx3bnRuUUk1dHFXalhzUEhzT3JnVGh1NWN4UW5BUlo0?=
 =?utf-8?B?VlpNbjJwdnRCK1kzTllOY2JBTm1SWXZ5Q3hITWR0cjF5dFkyaFl1dmxOVW1O?=
 =?utf-8?B?VDNZRzlmZVNyWlFpL2RyRFErVUxHRDgwZ3JYZ0FjVTBJVkdLUmZ2a2tRR2FC?=
 =?utf-8?B?TVRobjFqa2k3R3FwTTAwbEkwUEgva05nc0ZBSUFFMlJ3OXFUcVNSWDJTUitT?=
 =?utf-8?B?ZVBQMjl6ZnpleEVzZ1FiQVRtbHQ1VlNyRDlDOThGU1Mrci81dk8zanF1QmQx?=
 =?utf-8?B?R0YyOTdFdXdtUjBxdWRnYndqcWtUNm85bm1WVzNVYVFnb250NFdhRVZ2d2Ri?=
 =?utf-8?B?WnR0VWI0MHp2NkNvMi9IcXkxUTA2U003TGRQWGw2T3I0QTA0M2dwNWtQemJ4?=
 =?utf-8?B?WjVib1NncjJXM2hndG5oOWZmN2treHJKdmpYcW5EcjRHYzZHWnpnMXpPekhn?=
 =?utf-8?B?RndXSjdsaW5ndVlndjc4NVdXRE9CZzdsTHMwMGd3STRPVDB5TGpOdjA2dzZy?=
 =?utf-8?B?ZFI4YVAwQkpJOXdEUTZpWEFiYzd1bUx4WnprdmRTWHFuZEFxVy9ZOUNUZ2JC?=
 =?utf-8?B?V2ExdFJSeDQ5Z2hJdCtyNzhUd2dDcVFVbFE4MEtDYXpUZHVPbGxyaXMvOW03?=
 =?utf-8?B?YzBDUWM0UWtnVVAxaWpRdThnWUJvQUpYZGR5V2p0R2xHdDhjVjhCZW1SMWF3?=
 =?utf-8?B?YnlvYjU2ZUtydkZSbVd6cU4zZ01ueXd2WDhFU0xSRERwYjVlN2VxNzFtRDND?=
 =?utf-8?B?UWhHcUh1Uk1EQWNkaUVaTDR3WFBtcGh4K2xFZ05qdE1NV2czc05NQnhDUjha?=
 =?utf-8?B?TVFTVU8zMkwxTlp2SGFxREJzb0JQTFJpTVRMWE1UaFVGR0JROEdTNTlFUjJK?=
 =?utf-8?B?RmJUMjAxT0E0UXpudDkyMlhFNW5QbENvUWxPRmpMVmFHcjRwQ3QvUW5iMTgw?=
 =?utf-8?B?V3NEOUF5L3RVUlNoR29RME9QQklaanM0TnlrRFEyWVVwOWpBRVhRU25lL1Q4?=
 =?utf-8?B?QUZsS3BMWnRKY2p4OWhwdlh1QW5TbG44a0tHUEl0UGlzQ3lDWDJxTldkSXgz?=
 =?utf-8?Q?IPwi49FtKSu21QfBsGSFgntAP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb5c9f0-7dd5-4d5c-f268-08db9355e618
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:42:14.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y027k44N3wxKcr2lOAz9h5UVfW+3M+L5yKl7+0LBlVvA+L+Avf01KQmzLj7lid9IgixZTLe+HNjQ+WkVGj7oIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5002
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



On 8/2/2023 8:40 PM, Ryan Roberts wrote:
> On 02/08/2023 13:35, Yin, Fengwei wrote:
>>
>>
>> On 8/2/2023 6:27 PM, Ryan Roberts wrote:
>>> On 28/07/2023 17:13, Yin Fengwei wrote:
>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>
>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>
>>>> Yin Fengwei (2):
>>>>   madvise: don't use mapcount() against large folio for sharing check
>>>>   madvise: don't use mapcount() against large folio for sharing check
>>>>
>>>>  mm/huge_memory.c | 2 +-
>>>>  mm/madvise.c     | 6 +++---
>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>
>>> As a set of fixes, I agree this is definitely an improvement, so:
>>>
>>> Reviewed-By: Ryan Roberts
>> Thanks.
>>
>>>
>>>
>>> But I have a couple of comments around further improvements;
>>>
>>> Once we have the scheme that David is working on to be able to provide precise
>>> exclusive vs shared info, we will probably want to move to that. Although that
>>> scheme will need access to the mm_struct of a process known to be mapping the
>>> folio. We have that info, but its not passed to folio_estimated_sharers() so we
>>> can't just reimplement folio_estimated_sharers() - we will need to rework these
>>> call sites again.
>> Yes. This could be extra work. Maybe should delay till David's work is done.
> 
> What you have is definitely an improvement over what was there before. And is
> probably the best we can do without David's scheme. So I wouldn't delay this.
> Just pointing out that we will be able to make it even better later on (if
> David's stuff goes in).
Yes. I agree that we should wait for David's work ready and do fix based on that.


Regards
Yin, Fengwei

> 
>>
>>>
>>> Given the aspiration for most of the memory to be large folios going forwards,
>>> wouldn't it be better to avoid splitting the large folio where the large folio
>>> is mapped entirely within the range of the madvise operation? Sorry if this has
>>> already been discussed and decided against - I didn't follow the RFC too
>>> closely. Or perhaps you plan to do this as a follow up?
>> Yes. We are on same page. RFC patchset did that. But there are some other opens
>> on the RFC. So I tried to submit this part of change which is bug fix. The other
>> thing left in RFC is optimization (avoid split large folio if we can).
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>> Thanks,
>>> Ryan
>>>
> 
> 
