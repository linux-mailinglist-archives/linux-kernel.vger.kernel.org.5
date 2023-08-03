Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2A76E528
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjHCKAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjHCJ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:59:54 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C33C0A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691056785; x=1722592785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mc9HKN3jl6ILxYL5ag1MnULLpPAYBb31Lv0LkLkfcLY=;
  b=T+5+BbVZ/Ibr9WGRjYY5gk26ai+cIglq30Jt7aDnv8RGisA9C6GwahlV
   5XcW3yVOoAIc2EyF7Y6DDj3kUiGdQjI6cSa4334mCT7k2abRG+NUyRYjG
   Gsx0nGXOsUi/2FxUYgJqfPisG20kO/ROHVd1K3ZBka2I2MKftCI5zBT60
   ekQidyBhZg4BzyHrmC8bMzTgrQ13uZccjMUpcYr7Pl3WYFwDBYqthWPgI
   OUzfbPzfUYfU73tXtoIabM1cY6zx1m95TXVDOXRI/7CycvIICG3T+BOji
   nYJbANApUNn57H7STd3vNGV5g2TLKcB808VTmr4rYdA6JeQNvTVojJjxG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350123126"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="350123126"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 02:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="976008802"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="976008802"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 02:59:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 02:59:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 02:59:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 02:59:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 02:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQtuWDZQsUI6gA/15H5HqCimv6R7Afm7WuYZ5bto4Oe7TeXoAbdXmwMMa7FgaBVj/9WCwQVTz/DHOIhWujMaIFgBPKt1OBYvJL8uehbutWu9++l8n1zvcqQ4/CDcKSIz7hfHJ6xYv0q4jdh0IE9O20vbCEf/nvdan0vGs0fBdjYf3iwvgkUpS9nd0MVd7h3ZUHsDxyBPVxNydqXW6F83kcFS9BPZ2CCR0yVRmvTr+gZEDs5v3jgOhDgK3LvXGSdk5VEva73wHmNMgTtGNgguDaPVBZf14hPCUlUyr23BVBmez3IQPhq+QtT3lB0m1vcFWF2DKFcyBPT4Fmh9dTiwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xqLynv7OMOx5AkMDanPRSbd4sy/QdN/IlQPwnQ7AS4=;
 b=mTR3WUihXQQ8lN6fIr2ALlEf2S6H2Qn/z6q5ffeSGuU2e5u9qsfkNRyUCiDmSoaG11yri4ZVckVvQ9Pk/3APJ68q6tMeX+T6AfdEwGFlyzW3Z70sUhC1a+Z8q85VlM71zMkUvJnT4LsfIC+RuWQTVvLgrFem1Mm/Cz5CpY9kyxP/14SjZ45AsbwqoG8/8VU7OQOXrsCRLLLRl6ENblb+HVehQsK4lXvZ7XovYr/XXc3vQEu8kCDaiCec+6dTFoM8Uu7ehEG9rlecGRK9VjPxlRh74jOWDuC0nYcLIWelox+vw1iAre6zhgsXMnb+OUyhVRxZYNlOFFsgSeJtjt89kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH0PR11MB5444.namprd11.prod.outlook.com (2603:10b6:610:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 09:59:37 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 09:59:37 +0000
Message-ID: <07d060a8-9ffe-16c1-652b-7854730ea572@intel.com>
Date:   Thu, 3 Aug 2023 17:58:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
 <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
 <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
 <4ae53b2a-e069-f579-428d-ac6f744cd19a@intel.com>
 <49142e18-fd4e-6487-113a-3112b1c17dbe@arm.com>
 <2d947a72-c295-e4c5-4176-4c59cc250e39@intel.com>
 <cf71f899-e302-0e60-c21a-6af65205cd39@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <cf71f899-e302-0e60-c21a-6af65205cd39@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH0PR11MB5444:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b90fc4-26c7-40c9-52e3-08db940858a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmyjkY+CZOgm9F99br+bbr2xX/rWtKsYZR5kagOt7DPiI3e3bBQ8zVkPP6jfc8xVA60Ll/oB2VD7BfAAM6WYsmEtAZtSYyPXF+H7Lr7gi6+etJaqYDR3oeqg6tOK2R0D+evzwBr79j3x2RB2Ivq49ZoyDZdSR320z+HX81Db43zyJv0KkUyzHcTGxCZV2TYj4bIsSKdeWdaLhkVO1hPKFdPFQ2/+QDVAZUiDPDXQYT4PMNWkRVMJ1g43sX8j6wEbmtLxESiL/+APwR8ZYuSD8MsQXu8xb9EpMzYmA3b3si4TqSnbmXKNWgscovHYi3/INv4MQmN0OuPVU1L0omugpboIXN/K3kornYzrBIeTUdUP2x4t6i9ZruzE9I9hqWByGRgkXaGlykRaSCxxrvKJ1rPF76BTrlCZL2chKIZpYurgr9Wv22sJqUyeJmtJi4E31XtKDFedgpyTE3aMRlRtSme5/zBVwIWyVJb6LTpjuZqooEh0S/YtpILzdWm9udzQBdG6haSCPttDW+dbeXfpIB3eMRPGZxN4BcNceF902ZCVwneacZvh0l3bK6X2eerm5j5ey1W1KHOe+lXPWfe9RKjtrecthvdwgePuErvoR5KuirDvbL/ZKztLiXJB3FHBI0+sOE52vzFiTcNlX/ikbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(2616005)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(7416002)(41300700001)(8676002)(8936002)(6486002)(6666004)(6512007)(54906003)(110136005)(478600001)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpVV2lDNG5MWGNiQVFDQ2RZK0w5SmdjaEVoSTZFTzNDbUl5M0hoaFYzWEhI?=
 =?utf-8?B?dnNhVTZYeUNkczl6ZUN2WkdDYTdydHViVDRXeG0xS013ZUV5VjlrUEIwcmxk?=
 =?utf-8?B?bzFzZVhoWTRGZ3VHWDdDdnAvRTg0YkJLYmdmRVBScVpBZVJMVDlKVmlsWHY4?=
 =?utf-8?B?UGovS3JwTnpWUC9sS0doc2M3N0JZWEVsZ0xSa3hvZU1ERWQra0pZbmxRRWcv?=
 =?utf-8?B?N2dkVm1vSDFwM2hVOWd4YmtKQy9iT1EvZzdGbEZEYmlLUDZVOHBEWTlCcGNy?=
 =?utf-8?B?MGFHVjZYZXpHSkJKWDJHdE83MmdWQmpmVGxwdVJOTjBQdVNPVFd3cFMvM2pw?=
 =?utf-8?B?Z3RJTzBHM243R1FaQy8wNWZYUmZoSlYzU2o1ZW1hclJBdWNEWWk0YWZiL3pB?=
 =?utf-8?B?dEpZeXE5elhCbXAyczlmL0hFbDYwcTJ0SE5LV3MyU2kwT2hXT0tGcHZkSTc4?=
 =?utf-8?B?L3pReDFoOTNpbURxcnVWVHBoUExObzc3QU9vUEYzelJRSjhMTjliaTF0bGNp?=
 =?utf-8?B?K3NmM3dJVTVkNUFaL0ltK1NUMktiSml3OEtIR2haTisvdTdkMDhDOVNNalkz?=
 =?utf-8?B?V1R2UnJRU0FNYWd6Y1ZDZ1VYMWUzaG5NcGVjeGlwK29hRzRtRDY4aVlZYnZz?=
 =?utf-8?B?T3IzYWl5Nm04YndxQ1FSYldhYUFoa0dvdVJYTG1kRG9QNHR4QXkrVUdQU1hC?=
 =?utf-8?B?QWZjTGV4d09LcjJmMEtYUGU1TzFKbS9MWXIwbnBadVVYajNKV2V6d2toYmh2?=
 =?utf-8?B?WXM2TC9sanNxRlduamNiQlhyWVRaUWdoNENaMDE2dWUvNHF1bGUram1QZ3BI?=
 =?utf-8?B?Z3N3bDdwK01xZFFPT3Y3TG9oUCtUVVhzVlVFVVNESHVVNGYwT0tON1lLaHZJ?=
 =?utf-8?B?TGxxVDJIV295T1FiZ0l5NFdlNy9peDlxeWdoNEMvb1FocFJrbjV6VE12amtH?=
 =?utf-8?B?MDFPYlRoRC9hMWd1RkhnTW9WaXhWOEVpKzk1Y3VHZVFMQ3U0akI3Vmh3UXpz?=
 =?utf-8?B?M0hZVFV3N0QxdHB4ZDRWbVNJS3FjajZJTGtwcjI1U2lkYnJZZDVmbjYwWlhm?=
 =?utf-8?B?NGpsb3hGOElORDZ6MStiMVlLOVF5ZzNId0lNYkpMYjBKNjVYanhjK21wWlJE?=
 =?utf-8?B?dHZ5dVpzVHpEbDhhZnVOb1ZYVzdrM2M5K05kMUppMHU2NVhxTWhjQjJXOU5K?=
 =?utf-8?B?QTJjZjRLM2Q5eDg1RitoTEU5Z2VqanpYWDdDMllmYVkrb2d6U1dpaDYvb1VO?=
 =?utf-8?B?bCs0b0cxYURYeVZsTnh0czVFcnltOXNoQ2tzWVBIQzBpaHoxdXVzV1p5bkh0?=
 =?utf-8?B?RkFPWWVaNjV5dkh4R1hKY0o3Y3NSYTJkdmVPcVc4VWR1QUJIZlk1MThob0ZW?=
 =?utf-8?B?TjhwOVlLaGdKVlVOaGpxdCtpVzN1dHVacVIzKy8reFpQTVpoOUZMY2pHOG54?=
 =?utf-8?B?SkxLRTJTeWdwdW80bDBhZysvUS9ZVjFxUzNTTmQxc3FycjNUaFJ5NnFWNnRO?=
 =?utf-8?B?UnJITnBMcEQxRlJqKzdOMzFDSlNBWk4rWTZNRjdTME9PSzJucGFUd09XMktI?=
 =?utf-8?B?SEg0ZkcwRklQNElrSFVZRVZPblhveGovQk5LTElPZS9LRDg5NFlOdFM3bk12?=
 =?utf-8?B?bGVtdkp3ZytjcHNDaTdmblhTZUJwS2wvQUtpTXMzZmEvUGFuTVQvSnR5SFFG?=
 =?utf-8?B?WTA5T05TcytjZmN0RmdsbkRUaE12YUttV2pBdnJTc2FyYkR4ZTM3VVRaNE8y?=
 =?utf-8?B?dDdEWXg1enNvUVZzWk56aCtDaVlOU1JReDNQQS9sRlloYlhVbVd5VE54bE4r?=
 =?utf-8?B?a01ocU80WGhPTFFQNy93dDZvYTFqSUl1bGVLQ0FVelA3VnhCMlltQXJiS0hy?=
 =?utf-8?B?WXNTTmUxbUhnSmxkQlF6U2FLNDkzdVJaU0RSVFNId093YzVPYUdrN0hrSVRM?=
 =?utf-8?B?WTdKUVUraHNVd1grSSs2L1hKK0YzMlVsQTI0MXRTTisvNlBvRHB6M3VqVUFY?=
 =?utf-8?B?TFRINnlNeThjTkE0VzlVSVI1c2tCcE4yaTRJRWxRcmppUXUzZWVFUnRkQ1gv?=
 =?utf-8?B?SjRGTkZFK1ViS0JYbk5KakxZY211dC8yYy8zaVRQaVVUYzA4R3dVQzYxejBJ?=
 =?utf-8?B?TWc5akhhREU5WVhGWEJMSTBPSGl0QlpqMVRuRlVGbm95cW0zREljQWE3VUhF?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b90fc4-26c7-40c9-52e3-08db940858a5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 09:59:37.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AkwALbXVXmOLTkXmFZVRdZN0zq5dGcxtt5zYJa1CnwyJHAc8gcVslf4oWRiUw1xD3NLYnhgH71e/mPGZ5EiMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5444
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 17:32, Ryan Roberts wrote:
> On 03/08/2023 09:37, Yin Fengwei wrote:
>>
>>
>> On 8/3/23 16:21, Ryan Roberts wrote:
>>> On 03/08/2023 09:05, Yin Fengwei wrote:
>>>
>>> ...
>>>
>>>>> I've captured run time and peak memory usage, and taken the mean. The stdev for
>>>>> the peak memory usage is big-ish, but I'm confident this still captures the
>>>>> central tendancy well:
>>>>>
>>>>> | MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak memory |
>>>>> |:-------------------|------------:|------------:|------------:|:------------|
>>>>> | 4k                 |        0.0% |        0.0% |        0.0% |        0.0% |
>>>>> | 16k                |       -3.6% |      -26.5% |       -0.5% |       -0.1% |
>>>>> | 32k                |       -4.8% |      -37.4% |       -0.6% |       -0.1% |
>>>>> | 64k                |       -5.7% |      -42.0% |       -0.6% |       -1.1% |
>>>>> | 128k               |       -5.6% |      -42.1% |       -0.7% |        1.4% |
>>>>> | 256k               |       -4.9% |      -41.9% |       -0.4% |        1.9% |
>>>>
>>>> Here is my test result:
>>>>
>>>> 		real		user		sys
>>>> hink-4k:	 0%		0%		0%
>>>> hink-16K:	-3%		0.1%		-18.3%
>>>> hink-32K:	-4%		0.2%		-27.2%
>>>> hink-64K:	-4%		0.5%		-31.0%
>>>> hink-128K:	-4%		0.9%		-33.7%
>>>> hink-256K:	-5%		1%		-34.6%
>>>>
>>>>
>>>> I used command: 
>>>> /usr/bin/time -f "\t%E real,\t%U user,\t%S sys" make -skj96 allmodconfig all
>>>> to build kernel and collect the real time/user time/kernel time.
>>>> /sys/kernel/mm/transparent_hugepage/enabled is "madvise".
>>>> Let me know if you have any question about the test.
>>>
>>> Thanks for doing this! I have a couple of questions:
>>>
>>>  - how many times did you run each test?
>>      Three times for each ANON_FOLIO_MAX_ORDER_UNHINTED. The stddev is quite
>>      small like less than %1.
> 
> And out of interest, were you running on bare metal or in VM? And did you reboot
> between each run?
I run the test on bare metal env. I didn't reboot for every run. But have to reboot
for different ANON_FOLIO_MAX_ORDER_UNHINTED size. I do
   echo 3 > /proc/sys/vm/drop_caches
for everything run after "make mrproper" even after a fresh boot.


> 
>>>
>>>  - how did you configure the large page size? (I sent an email out yesterday
>>>    saying that I was doing it wrong from my tests, so the 128k and 256k results
>>>    for my test set are not valid.
>>      I changed the ANON_FOLIO_MAX_ORDER_UNHINTED definition manually every time.
> 
> In that case, I think your results are broken in a similar way to mine. This
> code means that order will never be higher than 3 (32K) on x86:
> 
> +		order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
> +
> +		if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
> +			order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
> 
> On x86, arch_wants_pte_order() is not implemented and the default returns -1, so
> you end up with:
I added arch_waits_pte_order() for x86 and gave it a very large number. So the
order is decided by ANON_FOLIO_MAX_ORDER_UNHINTED. I suppose my data is valid.

> 
> 	order = min(PAGE_ALLOC_COSTLY_ORDER, ANON_FOLIO_MAX_ORDER_UNHINTED)
> 
> So your 4k, 16k and 32k results should be valid, but 64k, 128k and 256k results
> are actually using 32k, I think? Which is odd because you are getting more
> stddev than the < 1% you quoted above? So perhaps this is down to rebooting
> (kaslr, or something...?)
> 
> (on arm64, arch_wants_pte_order() returns 4, so my 64k result is also valid).
> 
> As a quick hack to work around this, would you be able to change the code to this:
> 
> +		if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
> +			order = ANON_FOLIO_MAX_ORDER_UNHINTED;
> 
>>
>>>
>>>  - what does "hink" mean??
>>      Sorry for the typo. It should be ANON_FOLIO_MAX_ORDER_UNHINTED.
>>
>>>
>>>>
>>>> I also find one strange behavior with this version. It's related with why
>>>> I need to set the /sys/kernel/mm/transparent_hugepage/enabled to "madvise".
>>>> If it's "never", the large folio is disabled either.
>>>> If it's "always", the THP will be active before large folio. So the system is
>>>> in the mixed mode. it's not suitable for this test.
>>>
>>> We had a discussion around this in the THP meeting yesterday. I'm going to write
>>> this up propoerly so we can have proper systematic discussion. The tentative
>>> conclusion is that MADV_NOHUGEPAGE must continue to mean "do not fault in more
>>> than is absolutely necessary". I would assume we need to extend that thinking to
>>> the process-wide and system-wide knobs (as is done in the patch), but we didn't
>>> explicitly say so in the meeting.
>> There are cases that THP is not appreciated because of the latency or memory
>> consumption. For these cases, large folio may fill the gap as less latency and
>> memory consumption.
>>
>>
>> So if disabling THP means large folio can't be used, we loose the chance to
>> benefit those cases with large folio.
> 
> Yes, I appreciate that. But there are also real use cases that expect
> MADV_NOHUGEPAGE means "do not fault more than is absolutely necessary" and the
> use cases break if that's not obeyed (e.g. live migration w/ qemu). So I think
> we need to be conservitive to start. These apps that are explicitly forbidding
> THP today, should be updated in the long run to opt-in to large anon folios
> using some as-yet undefined control.
Fair enough.


Regards
Yin, Fengwei

> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>> My intention is that if you have requested THP and your vma is big enough for
>>> PMD-size then you get that, else you fallback to large anon folios. And if you
>>> have neither opted in nor out, then you get large anon folios.
>>>
>>> We talked about the idea of adding a new knob that let's you set the max order,
>>> but that needs a lot more thought.
>>>
>>> Anyway, as I said, I'll write it up so we can all systematically discuss.
>>>
>>>>
>>>> So if it's "never", large folio is disabled. But why "madvise" enables large
>>>> folio unconditionly? Suppose it's only enabled for the VMA range which user
>>>> madvise large folio (or THP)?
>>>>
>>>> Specific for the hink setting, my understand is that we can't choose it only
>>>> by this testing. Other workloads may have different behavior with differnt
>>>> hink setting.
>>>>
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>
> 
