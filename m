Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA59C7CF276
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbjJSIYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbjJSIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:24:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F7181
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697703843; x=1729239843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZMfJoaQ8x90zsdvcPgYNcGE0esgo6AdbGgOyZctvDUY=;
  b=bPWSW5jbsc/u2Ir74gFaahFhnyd2PCMODcOzWoCpqomNlBqCJNI0QFhF
   zq3PHP3fRvLGE1lPY0JsQb1EM6DXHI32+IrrIEYSDyYrbqFXrj50Ji1Hk
   PiVQhXwdX4fjpkBwx0IUP+Nei6Ia8wskFoz571jYhUrqIrouxY+kDwTyD
   KMUhD8qBk5eoTHbWlNPJiDzkBQbIuk2oilXIUI1FzlE9rFTaFAQBv3zNP
   EeekA44yry0l37uJomqSU3fhsIoBKSWmKqIr+C4ktqkI2w2lv12y1+b63
   wGrOu0MmD0I2+LcgA5BkjVP8DehHsZVghya5WWzJaFPmMULqW8fKKvx2p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452668961"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452668961"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 01:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930523877"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="930523877"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 01:23:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 01:23:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 01:23:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 01:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFGkkhVOWPbFHXGK3Uj4ne5mt4vbIev91aO/IU1hdt1BjLXevdTedQd0HtbwWV8Mi1430iurE069fRjuv8wWmtTyzuySDwIK9eZ40fYcyYmSC5T+LpJ5wEZqQD8WJNbbeFh7sCx9EY50qp1xd0OZ/KFjkSr7ZEmQ961W3XsCY2OLkaht/cMiLDi+6y1H+5U4kL9DIYNrOMl3T/Zo6uqSav0wBfWMW5QOavyqMkE+eb/hYTn8U3ycbm2pLLPjZbHbqiD8TuEXipdiciSeIuNR3IBPEcxqbHciJy8XOC8vEKkxmvJo1IgFBHu4k8sA/jbVnyIUdpkfXI49HujAnb9zrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWqdzhO2v1O4LxudfHzsFfwvb2bfwWKrrwNJk+4TLMY=;
 b=KDG3VoH2bErCSlIWVmuYbK6MamG2/PZAaEIkd+CnOkzz4Vs4Rngf+kYEJ1p2GCFnLzibwm5HBPw//hnf6jkFQ4Q675ng1fUgi6cb89LDnfSENZOdHnQbr8W430vExnW3VYtsrt2dSTFxIocy5PrcYE43RDjesfpwuRO+U8fL3HuoYImbavPIAhVMV+0h5kocu2VL58TYXT2Q+U1/rQTVliYp/VWBHpsDja4pAuEiVXvF+Tc1k2HQmYA0snfHw9cEniYiWJLGa3/ZNR5jMa/iykkUTHrcPrdG9fkZ6dylLgm8O06YA6abQvZVmC0Y4Qtnb5Rv5WTOymQn+0D9PAATmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BL3PR11MB6316.namprd11.prod.outlook.com (2603:10b6:208:3b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 08:23:37 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 08:23:36 +0000
Message-ID: <27f40fc2-806a-52a9-3697-4ed9cd7081d4@intel.com>
Date:   Thu, 19 Oct 2023 16:22:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
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
Content-Language: en-US
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <2ad721be-b81e-d279-0055-f995a8cfe180@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BL3PR11MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: af10d8db-f898-4331-d5e2-08dbd07cb066
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLouawSsMkE8NCabG6Yn7Py8ZH0r/Tfhzm6Q+yo7pvRP0UeuJ0lPFe3MNAwhdwl+Qc9N6OrgzZwsAFWQ+JIko3rJ13qIpcwUnwAsMm8DUSr3ip3cf7ufA5JMXrsK7t07zCCxpx/pHSNgJcmqJLuEjiSEwk4o56Q1bzZ+IPc5z09DkBEWp0/h87E6nIAEGyZKmYHTyAPBcwGNZtS2OupSV702UNIbD1XDSF6nwhUpdArYUCTkIHKpSijgx7noZPqdDl4AJyo8Z411ojGsMO9wLPH97qFrzAADlbAjQphgFO+/sHA2Yt2DNQAmMX5H53JGJcrwx4StCPXUMgy3hKOOYpBCPFsRYHWu/t59dd04OcCmLuv9BK0uwEXLjd5hTjwwk9BP5mlduWu7otWdxTU0NZ976Vl8gGAcE0t/xdNXPikdrbLa1mmeNJjm0cxwfXZpASLG5x3WgXaRbI+skr+QIA18pX5f0NnM1D2gg0k7qpmZQWmlYoMGbc9tRGAXoUC1rL342drxPDf/r4IPx7fxnuIkd7DDhNP5SujLuc2Wf20IebKuClWNNIAJq9wQVXbwy4b4cJkmTzVXtuaWvnepGmG/RN0xLgMeoVp5bc5FhCTlGFp5+8mAhQ59rA6u3cCXW2HX+PyDZ7raj1H9VTRKsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31696002)(2906002)(66946007)(110136005)(66476007)(66556008)(316002)(478600001)(6486002)(8936002)(41300700001)(36756003)(8676002)(4326008)(5660300002)(86362001)(6506007)(38100700002)(53546011)(2616005)(6512007)(83380400001)(82960400001)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFNRXdmQnFTT1pIb2tRZXk5YklxYzNWNDJJY0xYVmRGa0J5NFkxcXdwYmZM?=
 =?utf-8?B?MVVKWk0wR2lEdUkwY09jWHFNOHVzd2o3aGJ6MzZJVklNSFBHbEhWRlpDT0Zu?=
 =?utf-8?B?U05nOFV2VnRhRDZMQTE1Z1lmaTFlUWcxUnpsSFN4MzVNUzcxQ21UWitucEZa?=
 =?utf-8?B?SFRsSmhGb2FWOGs3TDhnMjRvaytxSUg3bjBya2ZWZEo1YXZVQ01RM3FSSFZn?=
 =?utf-8?B?UEtGSFU5ZldqK3l2cGNuQlp2emdTMUFaK0FXOHpsYTNGNHQxcnhCRWQ2MUpH?=
 =?utf-8?B?bC9NdTJkL3ZJTksvYklJVGl0OEN5dXRJZmUzeGlMVzlpSWlWWnNxSWd2NW4w?=
 =?utf-8?B?eXFydkVOc0JMWUxjRk5vTkVZdGorQnQyc0RFMnhjVDBVZElXcklocTR0SnAz?=
 =?utf-8?B?VWNkKzRoZ21GTEsvVzZyNjdzYWgzN1d5WjFuTytUTU8waXBtSkNONHFEaDVp?=
 =?utf-8?B?eExVMUFvWUlGSDBJbVBTbVBHQU9CVmFFUSs3MG9ia29zMTF4OThjTjNqN2ds?=
 =?utf-8?B?VGJpcFZzbm4rQXg4VENMNmNRbkVkMnZZMEdRMUJ2ZnBwUFZnaUd2WnpUTjBI?=
 =?utf-8?B?T2VBeGVGenpQbTg0TlFZRWErSzN1My9Jenc1OVQvelVSOGYvVUxnV0gxMEhB?=
 =?utf-8?B?c28wWlRpOU1aMjZJU1QvRU1oY0d4Y1VhVGdIdXEzRXV1RnhTdGMvbjA4b3RX?=
 =?utf-8?B?K29BSCthUlppRVNrMldFYUFqTDdiSlhjSG9ITi9OMXJZajZUSUdSai9ibW1H?=
 =?utf-8?B?NmJQSDFUcDdVSjFxTU9LcU5rY3BqMzQyTFhWeGRGemdEU20ybytKMTZXNzls?=
 =?utf-8?B?UnAxQ0ZyUm9pZ3dYZkRQNzA2SzRVcjJ1Tnh0VlQvTlg0VTZOUEpTcm9HWTQ5?=
 =?utf-8?B?L1ZST3VlM3VtVWhMUTl2YVQ3NHc2MTFSQ2EzTndnaGUvYXdORUcwaDg0dm0y?=
 =?utf-8?B?aWljNXc1N2puZkoycjd6SzFFMEpuN3JlZzZjVU5kSVovU2FXS1B2aEtwSmY1?=
 =?utf-8?B?MmZVYWdNajh2dGd4UTNBSzlKU0c3UjBwbzRKU0laY3lGRFJFcURjaUFHYm5r?=
 =?utf-8?B?ZGVDS0tQNWxJazI3Y2ZlK3RvUG5iQWxXaGxhK3o4NnBBT3lSZ2pueThubVY3?=
 =?utf-8?B?bzg2REJ5N0w2SEk0UEY4MCtCdHRTVzYvUk1TS2phdUYvcDdUL0tBV0VEZ2dD?=
 =?utf-8?B?dC9EemJhaG84ZDdOM1lGdzd1aHhjZ3l4TjlVZ1ZWb3dhQmRESXJGY1VUbHE0?=
 =?utf-8?B?VytJTUJqRGdtclNmN2ZFbEc2K28zRStqeEREdVdNdm9RZm9senF6b3JDaUMr?=
 =?utf-8?B?RkhFTFlpYWE1dVdGR1dlc1BXYkU3a0VmU1I4VlZoQUM0SzFqejFQWDNLcXBI?=
 =?utf-8?B?T2FiSGlid2tkRUpreTRPaUQraFVJUE1PQkJNeWJ6cExlYlI2Ky82dmQ5WFUv?=
 =?utf-8?B?dmI5K29aazBlYTZvQ1YvUUlNcG94ZjVEMkxuZkd5UjE5akVpVE4rcUNXNk9O?=
 =?utf-8?B?Mk1LcEpieldlUXVhZjV5MlRsK3RrOGllVHdFYTNDSGRmUEdLUkV3SUlLVkFS?=
 =?utf-8?B?WXZvZ0J2NXpDa3g3RHlqakR6U1lzdzJTWXF4VVdHYm9IUUpmcDh2UFpEWmtH?=
 =?utf-8?B?THl4OGxxN3A1Z3VEMkVzaTFJS1dZajNHSjFja3Nsdk5kdnA4RUhNSm1oeVpq?=
 =?utf-8?B?eHR5YXhReHNJZmZoVk1RNUxRQ0dTZlZzZG1scU16azZQTTZQMjBGQ09VQmI5?=
 =?utf-8?B?TG1FMEFNZ0xxL0ZoNkZwdkRaUnlkdEwyTUhyNGtNN0VPeTExQ1NteGtKZHE2?=
 =?utf-8?B?YmdGazNlWVNEVm1UditaQkFiN2NPMjBVZkxtYmZHZXk5clgvQ0kybEZsdTRF?=
 =?utf-8?B?Nk01Q0daN0d4WmJTNjB3RzZtOEZQUklNZCtkWmpVL2o5RmtYVHNPeWpmalI4?=
 =?utf-8?B?cFlYQkY2VTFEQm5iQmZsSy9rOHhzdm13ZERKSFlpZ01YRHgvaHR1SHVlK1Ra?=
 =?utf-8?B?TFplRm1sc2JZNk85S2tmZ0RjMDlYMXFmbTdYcjZISHltWThXRjF4SGdadndZ?=
 =?utf-8?B?TUZqbktzSDFqUnRsRHROaUgvTjNKM3JjSXk4K2JRT3F3bmpSY3FVQVM1NVFl?=
 =?utf-8?Q?w7b5j3m9O1bsnsMYwCsN24mLv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af10d8db-f898-4331-d5e2-08dbd07cb066
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 08:23:35.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7wpABaVzAZHm2JQEe3Iie1uc15zZJ+L9N0W9M+ClQVDnrkLGd/3GRlsWFkQ8sdNwgzng9tV32GT3j+QQ8XMzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6316
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 10/19/23 15:25, Baolin Wang wrote:
> 
> 
> On 10/19/2023 2:09 PM, Huang, Ying wrote:
>> Zi Yan <ziy@nvidia.com> writes:
>>
>>> On 18 Oct 2023, at 9:04, Baolin Wang wrote:
>>>
>>>> When doing compaction, I found the lru_add_drain() is an obvious hotspot
>>>> when migrating pages. The distribution of this hotspot is as follows:
>>>>     - 18.75% compact_zone
>>>>        - 17.39% migrate_pages
>>>>           - 13.79% migrate_pages_batch
>>>>              - 11.66% migrate_folio_move
>>>>                 - 7.02% lru_add_drain
>>>>                    + 7.02% lru_add_drain_cpu
>>>>                 + 3.00% move_to_new_folio
>>>>                   1.23% rmap_walk
>>>>              + 1.92% migrate_folio_unmap
>>>>           + 3.20% migrate_pages_sync
>>>>        + 0.90% isolate_migratepages
>>>>
>>>> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
>>>> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
>>>> immediately, to help to build up the correct newpage->mlock_count in
>>>> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
>>>> pages are migrating, then we can avoid this lru drain operation, especailly
>>>> for the heavy concurrent scenarios.
>>>
>>> lru_add_drain() is also used to drain pages out of folio_batch. Pages in folio_batch
>>> have an additional pin to prevent migration. See folio_get(folio); in folio_add_lru().
>>
>> lru_add_drain() is called after the page reference count checking in
>> move_to_new_folio().  So, I don't this is an issue.
> 
> Agree. The purpose of adding lru_add_drain() is to address the 'mlock_count' issue for mlocked pages. Please see commit c3096e6782b7 and related comments. Moreover I haven't seen an increase in the number of page migration failures due to page reference count checking after this patch.

I agree with your. My understanding also is that the lru_add_drain() is only needed
for mlocked folio to correct mlock_count. Like to hear the confirmation from Huge.


But I have question: why do we need use page_was_mlocked instead of check
folio_test_mlocked(src)? Does page migration clear the mlock flag? Thanks.


Regards
Yin, Fengwei


> 
>>>> So we can record the source pages' mlocked status in migrate_folio_unmap(),
>>>> and only drain the lru list when the mlocked status is set in migrate_folio_move().
>>>> In addition, the page was already isolated from lru when migrating, so we
>>>> check the mlocked status is stable by folio_test_mlocked() in migrate_folio_unmap().
>>>>
>>>> After this patch, I can see the hotpot of the lru_add_drain() is gone:
>>>>     - 9.41% migrate_pages_batch
>>>>        - 6.15% migrate_folio_move
>>>>           - 3.64% move_to_new_folio
>>>>              + 1.80% migrate_folio_extra
>>>>              + 1.70% buffer_migrate_folio
>>>>           + 1.41% rmap_walk
>>>>           + 0.62% folio_add_lru
>>>>        + 3.07% migrate_folio_unmap
>>>>
>>>> Meanwhile, the compaction latency shows some improvements when running
>>>> thpscale:
>>>>                              base                   patched
>>>> Amean     fault-both-1      1131.22 (   0.00%)     1112.55 *   1.65%*
>>>> Amean     fault-both-3      2489.75 (   0.00%)     2324.15 *   6.65%*
>>>> Amean     fault-both-5      3257.37 (   0.00%)     3183.18 *   2.28%*
>>>> Amean     fault-both-7      4257.99 (   0.00%)     4079.04 *   4.20%*
>>>> Amean     fault-both-12     6614.02 (   0.00%)     6075.60 *   8.14%*
>>>> Amean     fault-both-18    10607.78 (   0.00%)     8978.86 *  15.36%*
>>>> Amean     fault-both-24    14911.65 (   0.00%)    11619.55 *  22.08%*
>>>> Amean     fault-both-30    14954.67 (   0.00%)    14925.66 *   0.19%*
>>>> Amean     fault-both-32    16654.87 (   0.00%)    15580.31 *   6.45%*
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>   mm/migrate.c | 50 ++++++++++++++++++++++++++++++++++++++------------
>>>>   1 file changed, 38 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 4caf405b6504..32c96f89710f 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1027,22 +1027,32 @@ union migration_ptr {
>>>>       struct anon_vma *anon_vma;
>>>>       struct address_space *mapping;
>>>>   };
>>>> +
>>>> +enum {
>>>> +    PAGE_WAS_MAPPED = 1 << 0,
>>>> +    PAGE_WAS_MLOCKED = 1 << 1,
>>>> +};
>>>> +
>>>>   static void __migrate_folio_record(struct folio *dst,
>>>> -                   unsigned long page_was_mapped,
>>>> +                   unsigned long page_flags,
>>>>                      struct anon_vma *anon_vma)
>>>>   {
>>>>       union migration_ptr ptr = { .anon_vma = anon_vma };
>>>>       dst->mapping = ptr.mapping;
>>>> -    dst->private = (void *)page_was_mapped;
>>>> +    dst->private = (void *)page_flags;
>>>>   }
>>>>
>>>>   static void __migrate_folio_extract(struct folio *dst,
>>>>                      int *page_was_mappedp,
>>>> +                   int *page_was_mlocked,
>>>>                      struct anon_vma **anon_vmap)
>>>>   {
>>>>       union migration_ptr ptr = { .mapping = dst->mapping };
>>>> +    unsigned long page_flags = (unsigned long)dst->private;
>>>> +
>>>>       *anon_vmap = ptr.anon_vma;
>>>> -    *page_was_mappedp = (unsigned long)dst->private;
>>>> +    *page_was_mappedp = page_flags & PAGE_WAS_MAPPED ? 1 : 0;
>>>> +    *page_was_mlocked = page_flags & PAGE_WAS_MLOCKED ? 1 : 0;
>>>>       dst->mapping = NULL;
>>>>       dst->private = NULL;
>>>>   }
>>>> @@ -1103,7 +1113,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>   {
>>>>       struct folio *dst;
>>>>       int rc = -EAGAIN;
>>>> -    int page_was_mapped = 0;
>>>> +    int page_was_mapped = 0, page_was_mlocked = 0;
>>>>       struct anon_vma *anon_vma = NULL;
>>>>       bool is_lru = !__folio_test_movable(src);
>>>>       bool locked = false;
>>>> @@ -1157,6 +1167,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>           folio_lock(src);
>>>>       }
>>>>       locked = true;
>>>> +    page_was_mlocked = folio_test_mlocked(src);
>>>>
>>>>       if (folio_test_writeback(src)) {
>>>>           /*
>>>> @@ -1206,7 +1217,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>       dst_locked = true;
>>>>
>>>>       if (unlikely(!is_lru)) {
>>>> -        __migrate_folio_record(dst, page_was_mapped, anon_vma);
>>>> +        __migrate_folio_record(dst, 0, anon_vma);
>>>>           return MIGRATEPAGE_UNMAP;
>>>>       }
>>>>
>>>> @@ -1236,7 +1247,13 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>       }
>>>>
>>>>       if (!folio_mapped(src)) {
>>>> -        __migrate_folio_record(dst, page_was_mapped, anon_vma);
>>>> +        unsigned int page_flags = 0;
>>>> +
>>>> +        if (page_was_mapped)
>>>> +            page_flags |= PAGE_WAS_MAPPED;
>>>> +        if (page_was_mlocked)
>>>> +            page_flags |= PAGE_WAS_MLOCKED;
>>>> +        __migrate_folio_record(dst, page_flags, anon_vma);
>>>>           return MIGRATEPAGE_UNMAP;
>>>>       }
>>>>
>>>> @@ -1261,12 +1278,13 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>>>>                     struct list_head *ret)
>>>>   {
>>>>       int rc;
>>>> -    int page_was_mapped = 0;
>>>> +    int page_was_mapped = 0, page_was_mlocked = 0;
>>>>       struct anon_vma *anon_vma = NULL;
>>>>       bool is_lru = !__folio_test_movable(src);
>>>>       struct list_head *prev;
>>>>
>>>> -    __migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>>>> +    __migrate_folio_extract(dst, &page_was_mapped,
>>>> +                &page_was_mlocked, &anon_vma);
>>>
>>> It is better to read out the flag, then check page_was_mapped and page_was_mlocked
>>> to avoid future __migrate_folio_extract() interface churns.
>>
>> IHMO, in contrast, it's better to use separate flags in
>> __migrate_folio_record() too to avoid to pack flags in each call site.
> 
> Either way is okay for me. And avoiding to pack flags in each call site seems more reasonable to me.
> 
>>
>>>>       prev = dst->lru.prev;
>>>>       list_del(&dst->lru);
>>>>
>>>> @@ -1287,7 +1305,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>>>>        * isolated from the unevictable LRU: but this case is the easiest.
>>>>        */
>>>>       folio_add_lru(dst);
>>>> -    if (page_was_mapped)
>>>> +    if (page_was_mlocked)
>>>>           lru_add_drain();
>>>
>>> Like I said at the top, this would be if (page_was_mapped || page_was_mlocked).
> 
> I don't think so. Like I said above, we can drain lru list only if page was mlocked.
> 
>>>>       if (page_was_mapped)
>>>> @@ -1321,8 +1339,15 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>>>>        * right list unless we want to retry.
>>>>        */
>>>>       if (rc == -EAGAIN) {
>>>> +        unsigned int page_flags = 0;
>>>> +
>>>> +        if (page_was_mapped)
>>>> +            page_flags |= PAGE_WAS_MAPPED;
>>>> +        if (page_was_mlocked)
>>>> +            page_flags |= PAGE_WAS_MLOCKED;
>>>> +
>>>>           list_add(&dst->lru, prev);
>>>> -        __migrate_folio_record(dst, page_was_mapped, anon_vma);
>>>> +        __migrate_folio_record(dst, page_flags, anon_vma);
>>>>           return rc;
>>>>       }
>>>>
>>>> @@ -1799,10 +1824,11 @@ static int migrate_pages_batch(struct list_head *from,
>>>>       dst = list_first_entry(&dst_folios, struct folio, lru);
>>>>       dst2 = list_next_entry(dst, lru);
>>>>       list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
>>>> -        int page_was_mapped = 0;
>>>> +        int page_was_mapped = 0, page_was_mlocked = 0;
>>>>           struct anon_vma *anon_vma = NULL;
>>>>
>>>> -        __migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>>>> +        __migrate_folio_extract(dst, &page_was_mapped,
>>>> +                    &page_was_mlocked, &anon_vma);
>>>>           migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
>>>>                          true, ret_folios);
>>>>           list_del(&dst->lru);
>>>> -- 
>>>> 2.39.3
>>
>> -- 
>> Best Regards,
>> Huang, Ying
