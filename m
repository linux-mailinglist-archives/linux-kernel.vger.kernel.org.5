Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515437D06A7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbjJTCzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJTCzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:55:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8218BBB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697770509; x=1729306509;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k7hKBSZt5TwB8f65kZ32mR9z/qBjAZ+Dx7yn1OvfP6c=;
  b=gTgbeeFiJIXe1laHtZrmUB6OHshpsP+kuw3iJSKdwDQ+t8+5DntuTs9D
   kqm5TP05bFnc5fx6nAJ0zlg6qbcZMeO6TkajuL9sMm+X1QOizE3Otc8kd
   6U9EzuvlfpzdTLmoHv50N6Pd2AQOrrDFt954YCWvq4BMyxOfq4lJrhlYM
   v7CAVWLMobOLl/W0KQ+eeSeL+symnqLqFaU8j0QCWPHfNPAqaXWmGh7Ty
   oTPApfN8lM7JOoVQB00Fm7+KAhg9nfWcZoFqLaBmYjVENAcVwjuGd4w//
   cc64Dunw2ally7lPrjCyqImptqeyUbw7+USGmJODgIslU8T+Qr8I7yizl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="417549885"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="417549885"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 19:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="792249338"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="792249338"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 19:55:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 19:55:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 19:55:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 19:55:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcwOf4h0EVUOiA9eGC3pCaQkFtL85FBtFGn1e4u7P1VuS1T5p8z30+6VW2J0Waj4UCtTq+Rjlfsdtr5VHxQmzYr8xdd48hnxjSLFcCaHNwOOaDYiu47yX1aFHFqzaGl8tfiX8v0cq3d4WJKYM2HVrb9tYeQAXbiw005JxjEFiJRpk9X58F5Nh2fOfmEK7uVA4bG8jguvWfSbpHI/zhNVLDCpron0gy5R6rymqR+kVIKZl+1kv/QMDCEFPQLGgRudzKpBEJcKCQ1SmjhZAebcsgLOmszTjLAZBFlTHNn/EvpxD2ZuWT+6YjabB8dMgb4X+Bh69gHl5ZWx802PdJCL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNsmyZN8fr42r326FKUjy24IvxWuRGqU8bWvXZfqdRM=;
 b=FPePbrfwo0Er5R9W3dykCNm1yO9N8pAU3iv0C93+5uPYqCbdDL3tG8YvY9CylcCBxYMoDCiYg4XGcYYTI3Ivb4K/pvTRvGWFr5d5aUOs9T2UmwzOqy14Pju1IkcySN3h4Y0aQDSm7jW6ffJg6kX1sSbcK4M8z1FNEJPkgHoBdH66RaTiJJJ1qxDu+u24hw5SvX+DqpJNCkCR6p9ZczhAixCNWTvI+Yo4vr6xB+4XkWd3TDKAK5QW9aGl3AzerItEPL2aMiJfKlvRJqE/alonUT7ljbxUCfCQ9E743GfoDdfQctEueOzFah2+5Dx/6L3CXD3WfvWs4bm7kC0stSXD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 02:55:04 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49%6]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 02:55:04 +0000
Message-ID: <93abbbfb-27fb-4f65-883c-a6aa38c61fa0@intel.com>
Date:   Fri, 20 Oct 2023 10:54:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yosry Ahmed <yosryahmed@google.com>
CC:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <hughd@google.com>, <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
 <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com>
 <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ad721be-b81e-d279-0055-f995a8cfe180@linux.alibaba.com>
 <27f40fc2-806a-52a9-3697-4ed9cd7081d4@intel.com>
 <e8099116-6f78-cb4a-5036-1d7e38b63e52@linux.alibaba.com>
 <fd389af5-d949-43dc-9a35-d53112fe4a60@intel.com>
 <05d596f3-c59c-76c3-495e-09f8573cf438@linux.alibaba.com>
 <b9042fcb-05df-460f-87b8-4d7a04d3bd5e@intel.com>
 <e84f8c2d-6264-f2a3-3737-17d48a0251f8@linux.alibaba.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <e84f8c2d-6264-f2a3-3737-17d48a0251f8@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:820:f::7) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH3PR11MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 179b17ba-9ab3-480f-e823-08dbd117f54d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kk7k5QYGE8zc31LSa/YYsbzUfLW0RJICxiekdM8Hn6swNiJELG890iS/OtfjQazg3VE1OaUJnyTKtXeqkAu9Zkrh36JuFXMzY1fUYySykctG69zzaTO5aSuPNS3qhVevHZ4vtt1HwDnVi79405aodJHaZWkDBuB844HOQQLCq09yjSt0Ucg66ZDFFRj/l0LKP99Zkxu/xvq86O817rFUibgKYc5V/7iqbUaeFU/g9XnyDgwGF0lIGWLPynTsRCRLDN+FxWK1YJCGYUDU1O0ojcsDkhag/Ooxi0spmbbdVWYoB9PRtfgXTj0/cBGK+8NUkQjgcq5qtE9uQsyYpIG2AwJ5KENJi2G2yOkgLtdesqepYFn0FeqK3aE3yd3Tz7JDL4vSdofa31yMJZltwf7VPcPRygIueqd7kBHYQCQXj6ioB7BFFuOCNA9BysfaRNnCjbdhDmAR/TxaghHdv2LpWVn6Hs6uGGtYZvsKH88t9WCMouA0dj0p23U/rmjNtc1bl3gLUcKuupJYm3U6Tt3mDja2e7NstebMffF22wGvKFsNi0ydsIfgSkMbducYz0HXv+wh3ZIjMEr8978GoRdapYvIbko8nKDw20Sij6omdXvTeIDl1GnujsSg6XDosFPMcuDCN9/fc950IsPF5m4J1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(26005)(82960400001)(31686004)(38100700002)(5660300002)(83380400001)(31696002)(316002)(4326008)(86362001)(8936002)(66946007)(8676002)(41300700001)(110136005)(66476007)(66556008)(6486002)(966005)(53546011)(6666004)(6506007)(478600001)(2906002)(6512007)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2ZRT0hySithOTN0WUl3MHhJVWRKNXRITmw0a3VaSEJJa25RN0szL2pPRnBq?=
 =?utf-8?B?bDNFNm4ybXpTbFpwaDVjcm5ua1orMmVJeEl6YThiQ2Y1bWdIQVN4Rit2SWhS?=
 =?utf-8?B?ejQzWFkrRm5PRFFvM3hGajQyRUwyZFVKbFZRaFRiQ2wvOFB3T21rcDIraGtU?=
 =?utf-8?B?MzdIcDdmWFgrb2NnTGpDVk1VRlUxbTM5QUR4QWw4UERMOVIyZHAyZE9aT3Q2?=
 =?utf-8?B?V0RpOEprM2ZDS3pPM1I1WHB3blFJUENVbnYzZ1RaTVpNYmwwQi9OeFBvYTZM?=
 =?utf-8?B?Y1hWUG1qWnYyWCtNV1RqZXBXY0pqQy92QTNVbmxlcEllQzFsYWIvekV0QzdM?=
 =?utf-8?B?bXJIdnhXYmprdWllTXFzeEo4dm5PVEg1NUhmWjhlREowUnM3djE3RmFaaWpV?=
 =?utf-8?B?dVBSS056UGlOZVViR2RJZGE5VUgwUmIxT0tWNjdHbTFCdUxreFhjb1BsajhD?=
 =?utf-8?B?TnlsZmdTMnhTcmNmSGQwSjlXUGVvdjNqM2NZSHROVjhLMU1qbVhGZmgzb3FR?=
 =?utf-8?B?Mms2NGR1MTZQdzF0YUNRUE5Wd1YzckR5MGdmWERDeFNUQ255RmlJdUh5UDhL?=
 =?utf-8?B?VnlyK0MrcTJzS1F5NEFxVER2cDdIMmxuc3p0cUJzd2hUOXAvakJLVk1KK1dC?=
 =?utf-8?B?a0VpbkZpWkh6VVRmRGlDNE1JRTM5NEE3THR1V3pQZDRYTVlsTUxIS2Q1Mmxr?=
 =?utf-8?B?czRNemNpSFBITWd5WVJJb3FacVNkREIxY0s0cy82RkpYb2NaUWZhR1ZVWDFa?=
 =?utf-8?B?QjY1U0VQQnN5RUloRHZNc012dCtyUjdJMlJBc2FPbFpaeDFiMmVpRzVVc1ZG?=
 =?utf-8?B?WFlwREhUcGJxZkJaRlBtck9XUUZXZ0UvRkFldjVEWDAzT1QrdFloTjdId2lz?=
 =?utf-8?B?MGcwSkZQWjY2ZFp5aGtsY2Y5eEY5SUpjTUF4aTVVVGRmZW9UUHRJV2VKM1Ni?=
 =?utf-8?B?VzBnaUFpb2ludWxOa3I1WkZ2eTE5Um55aENmVWlRTSt5RWZPZ0lSODRBVUgz?=
 =?utf-8?B?bldQTldVY0Q4L2dJTWVUOGpJTkRDd2dhMDYySEEydndmYW94UUs1U2NaYkIx?=
 =?utf-8?B?WmlMaFpKMlhEelVtMkxPUzEwUnNRbW41QlNLTkNrSUJrV1VIZmJQT2xjL3RN?=
 =?utf-8?B?ekg0S2tBaXkzZGNGTkdWUlIxYzFyK1duMUlMaVAzQnZzNEMrbWMzbUJVU2hE?=
 =?utf-8?B?c0E0SGxRTzBhK2plQ1BsOHBtL3hKZXNoZGtaU2dKMnhQZEdOQWxqNTdzQ3kw?=
 =?utf-8?B?SkNETS84NlJjYkY0akV4VFAxWll0cExpK0tzOW9xK3c2eHlZdHhmdFZmeld3?=
 =?utf-8?B?WUZqWVJvR21nYVFKM1prV1FnVDhrdG0vVXZ2ZE5OL3NUMkVrRCtsZ2Z0THJt?=
 =?utf-8?B?dkJEWFgzcjRDNDhVenM2TjVkdmdYQll0b3psWC8yd2tsVnI2TFoxL0h3NUlq?=
 =?utf-8?B?Rnc1U3hScjk5dVE2R2NMejNmcUpkd2lOQldoYWxvT1F4ZnBOSjJRZlZTa2dK?=
 =?utf-8?B?QkZPVWlVbWU0MlZNUTZwcDVId01NTWtmamxURWltaXFsRDR2N01UTHdMc0tV?=
 =?utf-8?B?Zmg1SGZ2ejc1QnhlcEtTSktKTEVpM1BvZDI1UVZGSncyTTMrV2I4YkNGVlR4?=
 =?utf-8?B?cHVXVlBwMWhodUVSNVRxL21aTExwKzVQLzdQUFFaaTFFTkRsSk90WDA2eTgv?=
 =?utf-8?B?bkFqazJxUGxvY2RwN2t6QXR1eVVVaHJsQk9rOU01WDErUmZuZVZVM2pMbDR1?=
 =?utf-8?B?S05zcTl3d00yVTFobkpjbFUyVGJTc1JvWXN3UUk1eFNSODJsQmZxWWY0SHpF?=
 =?utf-8?B?UFJvQmZwTTlmMk00QTJncmtHVzdiV1FuVTFGWGtCMXFkaUo1ZGNiMlp2eGdi?=
 =?utf-8?B?SDVXUTk3cnRXckRoS1ZUTUpZNU9Ia3lwajdpN1cwSlh6M3hYRTVuZEUzY01X?=
 =?utf-8?B?UTFsdmh4MVR4UnRWQzNUVGJVcjMyS0x1bWI0STBuNU50cjVPRnF1aWQ3UTZ4?=
 =?utf-8?B?aEZISk1xNWJvaHNZZ1M5R05yb05qRTJ5ck9iVW9YYVlxeWhWeWtRMmd1MHpS?=
 =?utf-8?B?MFA0WnRqZXFGam5ZRkluQ0VqdHpscDl1V1VFVEllUFoxNklUVGNYWHpDbHE0?=
 =?utf-8?B?NVBvaUNMaElYY3RLY2JlSUV6bGZudFVLbUxRcXhKcjNyemVrcC9aRUZkWmtx?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 179b17ba-9ab3-480f-e823-08dbd117f54d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 02:55:03.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VV1uqoSHikM5OcSQSyF67gSvXcalcSOAB0eJXiE46tUIHomrGNtMQau17KO0Jf/NLlSZzPnArAtMYF2BimE2dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8383
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 10:45 AM, Baolin Wang wrote:
> 
> 
> On 10/20/2023 10:30 AM, Yin, Fengwei wrote:
>>
>>
>> On 10/20/2023 10:09 AM, Baolin Wang wrote:
>>>
>>>
>>> On 10/19/2023 8:07 PM, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 10/19/2023 4:51 PM, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 10/19/2023 4:22 PM, Yin Fengwei wrote:
>>>>>> Hi Baolin,
>>>>>>
>>>>>> On 10/19/23 15:25, Baolin Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 10/19/2023 2:09 PM, Huang, Ying wrote:
>>>>>>>> Zi Yan <ziy@nvidia.com> writes:
>>>>>>>>
>>>>>>>>> On 18 Oct 2023, at 9:04, Baolin Wang wrote:
>>>>>>>>>
>>>>>>>>>> When doing compaction, I found the lru_add_drain() is an obvious hotspot
>>>>>>>>>> when migrating pages. The distribution of this hotspot is as follows:
>>>>>>>>>>        - 18.75% compact_zone
>>>>>>>>>>           - 17.39% migrate_pages
>>>>>>>>>>              - 13.79% migrate_pages_batch
>>>>>>>>>>                 - 11.66% migrate_folio_move
>>>>>>>>>>                    - 7.02% lru_add_drain
>>>>>>>>>>                       + 7.02% lru_add_drain_cpu
>>>>>>>>>>                    + 3.00% move_to_new_folio
>>>>>>>>>>                      1.23% rmap_walk
>>>>>>>>>>                 + 1.92% migrate_folio_unmap
>>>>>>>>>>              + 3.20% migrate_pages_sync
>>>>>>>>>>           + 0.90% isolate_migratepages
>>>>>>>>>>
>>>>>>>>>> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
>>>>>>>>>> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
>>>>>>>>>> immediately, to help to build up the correct newpage->mlock_count in
>>>>>>>>>> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
>>>>>>>>>> pages are migrating, then we can avoid this lru drain operation, especailly
>>>>>>>>>> for the heavy concurrent scenarios.
>>>>>>>>>
>>>>>>>>> lru_add_drain() is also used to drain pages out of folio_batch. Pages in folio_batch
>>>>>>>>> have an additional pin to prevent migration. See folio_get(folio); in folio_add_lru().
>>>>>>>>
>>>>>>>> lru_add_drain() is called after the page reference count checking in
>>>>>>>> move_to_new_folio().  So, I don't this is an issue.
>>>>>>>
>>>>>>> Agree. The purpose of adding lru_add_drain() is to address the 'mlock_count' issue for mlocked pages. Please see commit c3096e6782b7 and related comments. Moreover I haven't seen an increase in the number of page migration failures due to page reference count checking after this patch.
>>>>>>
>>>>>> I agree with your. My understanding also is that the lru_add_drain() is only needed
>>>>>> for mlocked folio to correct mlock_count. Like to hear the confirmation from Huge.
>>>>>>
>>>>>>
>>>>>> But I have question: why do we need use page_was_mlocked instead of check
>>>>>> folio_test_mlocked(src)? Does page migration clear the mlock flag? Thanks.
>>>>>
>>>>> Yes, please see the call trace: try_to_migrate_one() ---> page_remove_rmap() ---> munlock_vma_folio().
>>>>
>>>> Yes. This will clear mlock bit.
>>>>
>>>> What about set dst folio mlocked if source is before try_to_migrate_one()? And
>>>> then check whether dst folio is mlocked after? And need clear mlocked if migration
>>>> fails. I suppose the change is minor. Just a thought. Thanks.
>>>
>>> IMO, this will break the mlock related statistics in mlock_folio() when the remove_migration_pte() rebuilds the mlock status and mlock count.
>>>
>>> Another concern I can see is that, during the page migration, a concurrent munlock() can be called to clean the VM_LOCKED flags for the VMAs, so the remove_migration_pte() should not rebuild the mlock status and mlock count. But the dst folio's mlcoked status is still remained, which is wrong.
>>>
>>> So your suggested apporach seems not easy, and I think my patch is simple with re-using existing __migrate_folio_record() and __migrate_folio_extract() :)
>>
>> Can these concerns be addressed by clear dst mlocked after lru_add_drain() but before
>> remove_migration_pte()?
> 
> IMHO, that seems too hacky to me. I still prefer to rely on the migration process of the mlcock pages.

BTW, Yosry tried to address the overlap of field lru and mlock_count:
https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
But the lore doesn't group all the patches.


Regards
Yin, Fengwei
