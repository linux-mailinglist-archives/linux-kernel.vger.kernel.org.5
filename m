Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723AE7D0739
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376298AbjJTDwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346958AbjJTDwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:52:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8179E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697773946; x=1729309946;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T+eg4VWHy1wt/cDepYHGKQi+IdTi8lM4F39yCNr3/nA=;
  b=dHMtAMN+YespnfwmrNURkL6Zx4oiuXD0k/f6XPNY6WyMcNqsOSAmVXMP
   Pu6YV9l4+ZyguKo7HXpW0kmSY8K0mGwAyewmYmsMya4/rfv35XBdHLN8s
   3EcljNeJqtyERNz6p/WihHu4IKB5YC4hOD6mdxWucuPImzkIzV+0HvqL4
   86PUyxpMfr0zvaQh+CNuD+stt1N+17B+Qos3tQvBBh/Ahkvqe37CxAm2c
   qvXzHnMxNqE6Pw0djwp0nAdDReOW76K/YLDoslrOqJzovCrkfgj3LDXSI
   WV8ZRSVs6B86AbEvJouHAnma5dRcTyjWk1KXlBeJ+vPoEPMUUuUczxVDt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="365760871"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="365760871"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 20:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="4980665"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 20:51:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 20:52:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 20:52:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 20:52:19 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 20:52:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9ZlFJ6SlxnJexxlZQo4qr59C7r2tiJjakEKplrGTharkSbXdDs1hPseQdDsNtk8KfRNlbwj+rWT6zGUxBiIfY8R19NAFphyy1LXV8p0FLXOAVmuKM0xftUx/YFrAbjkeCqZz2Fgy1ooyAPkFLxJidNQvsXI/SyuweCNNQtiLRCfWEOaDyTZsoeDqgU3CC+gT8+2uvToNVsJfRPVCFBJuA8XNv8Lxl68oR5CBoRS9uDxiL7RM2iYGeLD3xu+HWB4AHOV1y4H1tuyI9vPnejMdDJaVkmznO3q4FRX3PYsdD1U5Khh7SSZDKDnQrMEIKsaMAo9BWDk2DugjzhKfDa08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlPG1UAebS30kq75cpKn/nnNDbhIfuWQTqXPdPhNU0Q=;
 b=Log+v/DPsPAsDz1GDp3oW4LgaEtSD/AkcBX8cghUhA68/Gyum3lemlmfkSlEZllpjqWXm0zZEaflF8q2SEgdW9eNq6TcHVjRYMVts5noiQaho5zKa0gs/gz+se3HU9cPF2bc+pWBmu24omJVviEo2jj9gZFkjU1gH6vzOvQHcV0w1yP126KVk3BgaaI2tTXWRy3thx7lTQRnDyikQfvmE5nNdvXAFBPFN5jBJELPF/jt5n1eN/eJ/3wEwuGAsqyUfrSrVcmly/TIzO9D5yUzpFWfGVezN27pawYgJtdIxvECVsp5vcY4vwXlgngsLh6tqkh89bFNLcAMe9/R/N3mag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6510.namprd11.prod.outlook.com (2603:10b6:930:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 03:52:14 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49%6]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 03:52:14 +0000
Message-ID: <fb225c52-0d46-4a67-a897-f39b5c1b5554@intel.com>
Date:   Fri, 20 Oct 2023 11:52:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
CC:     "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
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
 <93abbbfb-27fb-4f65-883c-a6aa38c61fa0@intel.com>
 <0aaf6bf4-a327-9582-569e-2a634ce74af4@linux.alibaba.com>
 <CAJD7tkbA0Ofvw8wQM0017DKWC3SXOT71rCnUhGkoPgQ4wOfLOA@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkbA0Ofvw8wQM0017DKWC3SXOT71rCnUhGkoPgQ4wOfLOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1f2981-d190-417d-5119-08dbd11ff1e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgyCgWN/BF6b5FbecMUmUWPvbB22FDw+9/tfhxuDju0jaZyp60gCQIqCHOYVniSYxpyIVzWWNoP9g1LJPWkSNWmylu5fvCBrcoBqhBlTVjmJZ30rFsf13redaLvE20twafvf37ok6O0eJkZfd3Yxl+Njp4fNlpQpAaKAfEtbfbxw1xBLDg/CRUJZwmgnZDRxN6W2AYcnL1k/M88i1IHXEPygF/p/JZw0uwI/BkU+EqXi1Fcvlps98/TswcAvWYvzNpIawc/aAhKVAzt6QUnQdszHW9Hc8NmvMTqcoS7Ru4/2uwpAL6/waI+3jzH0BqCA4b1dbNgok99Gb4e1uJeLhX4DKLL3WAgwQPuJZg2MdAfHUFzraSMuqbZQbgfFz6jM8b2MQ0JfOzg0e8o3XiLqCyxIB57Og0ctzC5YW4Hy8KmVgIFsu3uFEO0wmZL2iwaZ/PTy18nOmz8NiaIvmAVbj9pt8CzkrmM95msYKjQNcs8dWua1/YzTg84MvxDJWPnePuTwsCHp3Aq125Q+6FrF9RtL+SFORrsY66ssrwHS0oZuLoFEB22ibBAPOZkFaL6V9ycDzyJIFucmANyyYMcjEVa/wV+Qb7/8j0RDkOw7lJdmrBKMt9v1+cK1mgMacX5IekAQwZ1XCqDLUVHeNKTRCM9m9yQRxia30uUXh7n5IsVq28abIEDwNnRiUdgXAQpd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38100700002)(86362001)(31696002)(4326008)(36756003)(2616005)(82960400001)(26005)(478600001)(966005)(8936002)(5660300002)(6486002)(54906003)(110136005)(66946007)(316002)(2906002)(6506007)(53546011)(66476007)(6512007)(66556008)(6666004)(41300700001)(83380400001)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXhBVE5DZUF1S25hS0FGR00vUHZJSm56NjZsQ3lxeHJCaWE4aHZTellnaG9m?=
 =?utf-8?B?ZzEvdjVBUExRRTdOOFNtOVVGSmVXcExOSGtPUGJEVllUdGV0bDhxdlMxajg0?=
 =?utf-8?B?Qkc1eHZTOGJQVmtQTHg1eFJsNWNhcVBQMkRnbExxclJidThqM1dKS2pkME44?=
 =?utf-8?B?SGp0OW1uOHdQVjZlOEdrYkdxT2JkZ2lkak9wYVhjUzVmVmZrWGNJY0NQYmlr?=
 =?utf-8?B?VEFEVmtaMnJQYmRxT09vYWlzRW9wbGFUMFVQNGFQWStibVQxcTZ6djZldGVG?=
 =?utf-8?B?MFRYVFBwS1NiQ0ZBL1NnRTZDMTVWRVFYRnNkR0I0bUhDcDI0b0dZR2xpTFVG?=
 =?utf-8?B?V1d5MlhDR2lOYUd0Tmg3WVNoZjJ5bWxiT0xXT3FlMDJUellHUUFJQTQ5NjFo?=
 =?utf-8?B?dGloSGdKcjFxUzBoVTNDdGFONWN2VjlMUEdkZ2JLM3ZIQnBCK3dPWU5MTEZo?=
 =?utf-8?B?RExrK0E2RXNqcE9wWmNCL2NyUHJDRUhBYXA4K0Vkc1Y5ZU9QdXlVZGZMVjdG?=
 =?utf-8?B?d3IvOGREWGYrSVd6WnpYWVVvMmJNVTBHM2h6bXVKWGZ6SG0zZnJ5R1JvV04v?=
 =?utf-8?B?MFdCUzZEZEQvalBzZFNqeVFMQ2dCZTBwNURxY281Ry9uVlZOemZTa2crRVpp?=
 =?utf-8?B?Vk0zTDM4WkE4KzhUai9jOStUSGoxVkNTT2ROSzNvY0FvWGtnaklRV05SOEpX?=
 =?utf-8?B?M1hFMHRqZ3haZXFHdWNmNEpVSjZtNkdwL1l4dFVkaC82WGpkdkVmdzRWbXEr?=
 =?utf-8?B?SnA1NGVMcFFJV1BnMng4Ti8rVitoR3NnWmh4eXA5MXdSR2hQTXN1UlpldS9M?=
 =?utf-8?B?RVU4cjhhQ1hrRFNSRDBxYlVYTWpBVUtkNE50RHVIbm1kaTh5Y3EyMVNPcElE?=
 =?utf-8?B?RG1uS0czY1Z2dVFjRjJjb2hhc2hRZTJuaWF5dFRHenVkNnZMdWszeWZZa1lD?=
 =?utf-8?B?UlhDQ2lwNDMvaW54SSsyZTJWWUNOYjJUaU8rakltL0lDeDJnMkt1Qmw1WEZS?=
 =?utf-8?B?WW9rZWVZZFgycEsyWFpIckZlbC84ZVBxTVF1WXkvdzNZTU16ak9neDdlNldP?=
 =?utf-8?B?N2lJbjNiZXRoSE5IZ3kzall2UlN1L0xaV3BtajNrcHFJN3AwczZ3NGc0K0lX?=
 =?utf-8?B?Vi9kUFVSaGhZSkpvVWZXQmNKemRyYUR5WFpGeVJtNDd2YW52akhqVDJOTCtH?=
 =?utf-8?B?MmhtZmUyUU5XOWl5RjB2NHZ6aHJrTGFsTUdIdWdTSENwZmlhbEJkeWNnN0xB?=
 =?utf-8?B?RVpUNmI0T3U2REd5cUFhOWI0N3JsN2lsVnJjM3pqQ3AyRFVmWUlpalFuQnpJ?=
 =?utf-8?B?K0dUNSsxM1pFS1Fybm5CV3VMQ2dtN2ZRdE1qaHhpMCtMcVVoaG10b2crRyti?=
 =?utf-8?B?c2R3R1p5UlRpaURXaCtIUkxlRGRJN2wyNlpDZVRPbXlacDZxQVNRTU5IR3FQ?=
 =?utf-8?B?SGQ5RkpkKzVDSmd6VlE3anB1NldTaXNnc3dJVXh0dHVkOFBVM0RHTktHUGk4?=
 =?utf-8?B?OUoxaDBZeEtnU25Da2YvMEljTnY3QjMxRHY3RnZ6bjAwYVpFbzhsQWhyTThR?=
 =?utf-8?B?NXlDUFFnaGNtbnQ2WXdwQkk2UEhlbk15SlBabkJOa0Y1V1h2TEhISUJsRWJS?=
 =?utf-8?B?bjBqZEhnYjBoSFBDbjl4MVEzWEZGVkh5b2IwWjV4SGgweEtpaUR3djBSVFRp?=
 =?utf-8?B?QzZuV3pNWEVOT1ZVOXY1Yjg1ckJVN1hqYURaUS9HclJXRTBpMm5XYlE3dG5q?=
 =?utf-8?B?WE9CUXRMcDBtbE83ZmNMdVlld0k4UmYvZHlUMU12a2pXVVRlWEVCQ0lNN1Fr?=
 =?utf-8?B?S25vblBOTmV1VU51b1gxbUVtMysrQklMTFYzaUVkVXhja0s5eFJ4M1h1cWVF?=
 =?utf-8?B?RCtjNlZKN0VjSVhFN0hnQzIrM2dxaDlzK1FpM0NxcDBJT00xUmUwK3FvbFU3?=
 =?utf-8?B?THNHbE1rR05lSCtNdmFYV3lvZSt2Rk52cE05QXBLVEJlSlRDTVU5VEMrc254?=
 =?utf-8?B?RjQ2dXpvWHI1dTRrcEVJOUxiMjZGbkFJcVdqdWZNRGdXMGY4TEN5Z0JXcWJ3?=
 =?utf-8?B?VldmMkpieXh1UjBMUTZvR0M3T0l4OXgwVnpQTmJwNWpQeHhlN29ra1BmVlov?=
 =?utf-8?B?VjJJcTFwN0tjMXh6NGVWcFlTdCtIRjlidi9oVW4yN3dRV3NsUjgyWFZicWUw?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1f2981-d190-417d-5119-08dbd11ff1e1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:52:13.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quQbqz7qI0rlvK+gBLSMmVWx4Y6ds5tJN/OrBWBebuh0LCC+hOaxQUgDUS2EezKLe/tGsy5vEJYL9JoQziHTzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 11:45 AM, Yosry Ahmed wrote:
>>>>
>>>> IMHO, that seems too hacky to me. I still prefer to rely on the migration process of the mlcock pages.
>>>
>>> BTW, Yosry tried to address the overlap of field lru and mlock_count:
>>> https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
>>> But the lore doesn't group all the patches.
>>
>> Thanks for the information. I'd like to review and test if this work can
>> continue.
> 
> The motivation for this work was reviving the unevictable LRU for the
> memcg recharging RFC series [1]. However, that series was heavily
> criticized. I was not intending on following up on it.
> 
> If reworking the mlock_count is beneficial for other reasons, I am
> happy to respin it if the work needed to make it mergeable is minimal.
> Otherwise, I don't think I have the time to revisit (but feel free to
> pick up the patches if you'd like).
> 
> [1]https://lore.kernel.org/lkml/20230720070825.992023-1-yosryahmed@google.com/

I believe reworking the mlock_count is focus here. If there is no overlap
between lru and mlock_count, the whole logic of lru_add_drain() can be
removed here.

And I noticed the link:
https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
only has cover letter and the patches didn't grouped.


Regards
Yin, Fengwei

