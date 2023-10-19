Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC47CF866
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbjJSMJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345852AbjJSMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:09:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7101E1722
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697717233; x=1729253233;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V6DEYsvVzHdzxd5JPwN7PzzvbB0eecLQTGhZpdQnI1s=;
  b=KYGNR0+tYpDnhC1pHUCA5itK+/khLa4aAbYRugoMWkr83b968NUw58NS
   /7uWK6P13KGeaf66XnmuDterrSAThDhObsbVx30pMiCx4a4d987pwoI3Y
   Zbf+pwHE27Xm1YOuMj9GtJWpCZ4dV0M2BBDkpIw4h0LjZ5QhSNSMe+rhd
   Pmb6VWjh3y54hiIc35DUcLzim+rGlk/gPCZxvyxEhG0x+qnNXxW0oOG6U
   RYSCx47XMcXReDxDKpw2b7x7GOYF8O1I+f9QQXPexH7YG8qNV/Y81gyY8
   w17IRlp1xStBFAmp0KOSSV2lhw6YoQiMPHWBk7c002dj+XyTAPw557hvf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="371296758"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="371296758"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="880620158"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="880620158"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 05:07:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 05:07:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 05:07:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 05:07:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 05:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l01jfFOczSNYqbG+ynAMfxaROXBEJ6yo6VceWnys+Nk2/RcRm0yU27e7HNt9arcok6Hq+HFDFEbH87fyRUZI8UF+MM6t8jaVaJOCjXlpLMIPmcYfQBYrFHKJrSuWo3XQd8NJW/jjX57+u9jcdszWiqdlgk6ewwgJvrybbXqVqoN9LO/HqaUzI3YR/JryvF47DNIXSeTIU2stDncDg/xa2DqFm2zKK32sH6H7xGdlrs/lJQ17vW9YpJNiwopJuwYHq7MV549Qo6WoBILiXl6pHt0TbH7wRVEngH88GaPIA0i6Jb3gHx49Y3qL7qLTIfsasx4iEPlc9hsOr4HogU2qYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N75zuDpRJmh/FnB9nOYU2Ye3bfIskFGasDIETQTQ5s=;
 b=HbA338+ch9+dA5OyFs0kkdCcIcNPQpOKjsgDX332zTM9oz2W9XHzT6MXbAHkkH+7evKm1EX18GkiQGlPEtblN0sXuuKal6N6DcJbI+FR354MTY8W4pi/6gGg+R7PgxN9BJ+ZhD2I8tccKsZRNH+YDnpT+X0DYZ5JzZqyMNR4KT+REaaHj1JnYKlgYknreubODHpf9r0gifFF7rln7/NNMeOzgF5502ywIdu3W7ryYcn3X4sPQ8zPmCe44zGJcS3K5UnVQocnWuGHs4FQKAFHjCWHfrvPL5Qk65b3UFDeiIPbZMspQXIYpu+aNIQQdeSj7T81F6SJMyC7DjLpWSBJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 12:07:09 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 12:07:09 +0000
Message-ID: <fd389af5-d949-43dc-9a35-d53112fe4a60@intel.com>
Date:   Thu, 19 Oct 2023 20:07:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
CC:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <hughd@google.com>, <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
 <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com>
 <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ad721be-b81e-d279-0055-f995a8cfe180@linux.alibaba.com>
 <27f40fc2-806a-52a9-3697-4ed9cd7081d4@intel.com>
 <e8099116-6f78-cb4a-5036-1d7e38b63e52@linux.alibaba.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <e8099116-6f78-cb4a-5036-1d7e38b63e52@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH3PR11MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: de4b183d-fa04-40e6-4fae-08dbd09beb4b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHCBdQT1IAX2MSsQeAA03GaDe/ACUKOwXz/bkd5tGDouU9o2T8rAwsJigpsnSiCBXjOKDkwEuWdrkRxHCUamhsWMJ54eH6xwixgtCzLxjotYdkxyrgw8SxlerBrffYAyyKV8G2I36vqLpne635jeYDrO3E9vkcb10LDUSL0GnkrKhsBYGrdUQXPtmWr9ENYB0w892KUXu5cCgbzNpHKnc7QUOIldzmGaybZaGEZpjKw+y1/EbjK52O9oIIquj2dzJra9e9/B8E+wBQzb6rMQdBISZ1UVQeWp7SlJAqUBTp1Wl/BS167GgtHhkI9NSyMrlqwpnIF1yBINlhxDuoskHqQ+01PHaSiVQkafyPPK6FTDRFRvdi4ouyJxH2RAUuDOcyiUn1LbvLJ/xM9aAodrdBmNChuJIlc2znVIdM6aXCjdjiUkWKwnXI8eMtrP2O3qn+pMQRyxD5FJRUH3PrS9rJXKq7GkT06eQkf5DS1wY7FMiXtQEXU0FSFIWE8+wSet5Y/LFK4GiZVY9nzTpsBczIDZbkVZ2wnz2lnrBU7sWJqLaLF0ajnP1SI5XWKTAYN5An4TfRdd3RbGmmzLPzxgnSbUssnKj+Ow8DoYcFP9Bl6UVzB4szK/HABaNbfVoF7t+zcwH2VN3CnbyUFecxibDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(316002)(66556008)(66946007)(66476007)(6666004)(8936002)(110136005)(478600001)(6486002)(8676002)(5660300002)(41300700001)(86362001)(2906002)(4326008)(38100700002)(31696002)(36756003)(6506007)(6512007)(2616005)(53546011)(83380400001)(26005)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndza0VHK0VqK1ZJVVFlbldBeWFleFJ0Y3pGUTljSE5vVDE1bloyU1EwekQ4?=
 =?utf-8?B?ZXlhb1lHK2d4VkN5YjZ3OGh0K3R0UG1MVWJFN2VPdGx5MmYvY29KQXdUcnJZ?=
 =?utf-8?B?Ry9NYjN5bllpSzhhdm4zMGVJeHlMNm9oZHJtWjZtU2pTU0dVU01MR1pscVZn?=
 =?utf-8?B?emZjUWhSV0pmaEFoRGNzSE1iVVdRN24zZG0yczhVODRkSTNyWmJuaUV6ZTg2?=
 =?utf-8?B?TU11QWlBamRYeHVZcXl6RnJMRFlXY1pKNzV6QU1SRUVNd21JNUFjWHR0K3M3?=
 =?utf-8?B?VlZRTXR5U04ySkRvUThhK1ExM3hwZ3hxSnBuMzdWQ0c1dTZkd3BHU3dsdDZh?=
 =?utf-8?B?KzhMU1dnVEhSQVdGcTZnbUlMSndjeWgzVEh5VkFmWXJhd3U2VzVYN3RZZlVG?=
 =?utf-8?B?QVRydkFlMEVnRExuMTNscnJyNzJYRTQzNWF1WTd0c3o2V0FkUXFkLzdaYmxh?=
 =?utf-8?B?ZEgzTHpwZHRIUDFPdi9NVXhJQ1F3OGJDVDRmZE1FUFNOaTMzdHhNSFNnR0lG?=
 =?utf-8?B?dkh2VEdTU1ZCZ25tVW5rdTZzRkxwL2ttbHptdExxOU1qdk1VTWpuclRyNzNL?=
 =?utf-8?B?ZW8rZ1RWa2JUV1BUb3NQa1Z0eUFqR2FDeXhqd0duWDZlR05raUpGTW1KbHE3?=
 =?utf-8?B?QUFDS0NOMWFkWUsxL1pOME1uVjhxNlJVT2p4L3V5QVlJN09mVm1MSTMwTTdv?=
 =?utf-8?B?SzVqMTNoWldpeGxtU0t5UUtEcExUV3Q1Q2c0V05PU2F0T0IrakxNS0JmVE9h?=
 =?utf-8?B?eENkUlh5UnlzcTA0dW5KSGh5azIrbzY2bURJNDIzU3BRcFA3N2YwQXA3aFRH?=
 =?utf-8?B?QXA5QjJJR1NTTnUzU25mNFcxOUtyUFJHSmFGOUFwTWQ3S05iTnZCaFRTelds?=
 =?utf-8?B?OG9haDdZc0h2bW1CWUwxZ1pwM1p1aUtpK2RYakdmcUo4SXRua1hSeXZBY2F3?=
 =?utf-8?B?YnZEelh0Y2FWZ0YrQlRIL1Bnb3pxMXowRVN1SkpxbUt0dmNRTmxDWE5vZmVl?=
 =?utf-8?B?Vy9VS1R2V3B4VmhkWHdWNGhIWkFZNThWamRaNGEwZndEdFJnbzh3SjJQdXRq?=
 =?utf-8?B?TWxwK040dW5hTDFCRmx0MU95Rjh2aEpRRCtScTI4THlKUCswZ0JNMHhjaFhK?=
 =?utf-8?B?NGZIaXFaWWJ2eDR3RDFTeURlbGZoMWsyTEZuM2h6QTlZNGZQcVdlZE5pKzFs?=
 =?utf-8?B?WWZkM3Ezb1RFSUptUUs3ZVZiS01TUmdNa1FhT241QVJ5ZGlnMUwvaUFXU2Vs?=
 =?utf-8?B?K3gzcllYVGttVXZ0YUxqK1QvWEY0U2ZUZElNUGEyaTBXd1lycERvQ0d0U0NE?=
 =?utf-8?B?R0NyZ256VDhDZGFRRkxJZkh0dTNYTjRlUkdwUzdhNkc2S0pzaEpicHFJTnRt?=
 =?utf-8?B?ZEE5dFlpZ2JCOFllM2pDVUJpU2xWMHlsaDZTVWMzYU1iUXpVRGY3TExZaU1B?=
 =?utf-8?B?MEM0b055QVpjM2FVbWhUNlJFSFozYWh0a09iVHRsVjJyb0g5eEp3S0Mwb05n?=
 =?utf-8?B?TkhvekNsZUwyVUlCOWd4LzQ0RlB0ZkluVmtHMmcxRXZ4REh5SWFHcWdvWmUr?=
 =?utf-8?B?eDBFOUF0MFgyTUdxRE5Sb3dXZDY4Y0hXZndxTHNwcGNtVFhFZ3FnOXNOL0cv?=
 =?utf-8?B?bGFqelJTV1ZzaG1lK2pYQnN2dkM0c1ZVU2dUMW1vUXBWMHljamppOEwwMVpN?=
 =?utf-8?B?MVdLSGtPbzBlUGhqdTdIR3E5MnNyc0wxclBYVzdrdU5QeUtGcXNlWkRVSUpI?=
 =?utf-8?B?TXVrbXREbW03M3BSZXV4VkhDVFZzZVMyMURjVnd6NFh4OFMyQzg5RCtSNlVl?=
 =?utf-8?B?Rkl5MWRWRjlJWEZuTXk1NDgyUEdDbVBFWk1tQURiVHVUQ2RBNlNSTFAva3lS?=
 =?utf-8?B?bGRiZ1dIYkZHYlhIaER0N0plV3Y1N1o0U3JmNXJzb2VRWjRBSVpjVm4wZDZY?=
 =?utf-8?B?aXJkdUF1MHJ2Rlc4c1FOeVNOdHRuNnllTmhkUHM0aDBjMTJxeGFEZnFwWjQw?=
 =?utf-8?B?Z2pySGE3OXNWZVRleHIxVTQ2bXNFTmt3UGZlNGdHM2pWM0ZpMmRhRm1ESnlF?=
 =?utf-8?B?b0RWMUFJc0xpT1FVbTF5ZjQwR0FGbjJoSExsbWVqTkc4Y0wyMnQ4ZkMxS3pD?=
 =?utf-8?Q?TSjr9A3mxX2SgaJ4NDTNk9VHX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de4b183d-fa04-40e6-4fae-08dbd09beb4b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:07:09.0395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: je2nd7PAIsSwLhq9sqDWeNNIcmBcVMJxKy5MxGc2yEnZJWUK2vBSLVwizLRRgJGeUdS9o3fGXFuaPqaT36/unQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2023 4:51 PM, Baolin Wang wrote:
> 
> 
> On 10/19/2023 4:22 PM, Yin Fengwei wrote:
>> Hi Baolin,
>>
>> On 10/19/23 15:25, Baolin Wang wrote:
>>>
>>>
>>> On 10/19/2023 2:09 PM, Huang, Ying wrote:
>>>> Zi Yan <ziy@nvidia.com> writes:
>>>>
>>>>> On 18 Oct 2023, at 9:04, Baolin Wang wrote:
>>>>>
>>>>>> When doing compaction, I found the lru_add_drain() is an obvious hotspot
>>>>>> when migrating pages. The distribution of this hotspot is as follows:
>>>>>>      - 18.75% compact_zone
>>>>>>         - 17.39% migrate_pages
>>>>>>            - 13.79% migrate_pages_batch
>>>>>>               - 11.66% migrate_folio_move
>>>>>>                  - 7.02% lru_add_drain
>>>>>>                     + 7.02% lru_add_drain_cpu
>>>>>>                  + 3.00% move_to_new_folio
>>>>>>                    1.23% rmap_walk
>>>>>>               + 1.92% migrate_folio_unmap
>>>>>>            + 3.20% migrate_pages_sync
>>>>>>         + 0.90% isolate_migratepages
>>>>>>
>>>>>> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
>>>>>> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
>>>>>> immediately, to help to build up the correct newpage->mlock_count in
>>>>>> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
>>>>>> pages are migrating, then we can avoid this lru drain operation, especailly
>>>>>> for the heavy concurrent scenarios.
>>>>>
>>>>> lru_add_drain() is also used to drain pages out of folio_batch. Pages in folio_batch
>>>>> have an additional pin to prevent migration. See folio_get(folio); in folio_add_lru().
>>>>
>>>> lru_add_drain() is called after the page reference count checking in
>>>> move_to_new_folio().  So, I don't this is an issue.
>>>
>>> Agree. The purpose of adding lru_add_drain() is to address the 'mlock_count' issue for mlocked pages. Please see commit c3096e6782b7 and related comments. Moreover I haven't seen an increase in the number of page migration failures due to page reference count checking after this patch.
>>
>> I agree with your. My understanding also is that the lru_add_drain() is only needed
>> for mlocked folio to correct mlock_count. Like to hear the confirmation from Huge.
>>
>>
>> But I have question: why do we need use page_was_mlocked instead of check
>> folio_test_mlocked(src)? Does page migration clear the mlock flag? Thanks.
> 
> Yes, please see the call trace: try_to_migrate_one() ---> page_remove_rmap() ---> munlock_vma_folio().

Yes. This will clear mlock bit.

What about set dst folio mlocked if source is before try_to_migrate_one()? And
then check whether dst folio is mlocked after? And need clear mlocked if migration
fails. I suppose the change is minor. Just a thought. Thanks.


Regards
Yin, Fengwei
