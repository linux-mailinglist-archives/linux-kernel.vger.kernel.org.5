Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6A7D067C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbjJTCaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjJTCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:30:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B01124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697769019; x=1729305019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qLxWikaq8cdbfBku1JwrTbvk/+476CNGDSKU2IQQTL0=;
  b=EvZ1wtxY7c7Rh9lCBcDQUnEHPEBlme510y2f/yl5X5tEwC3BKNbKvy4R
   btYfU2lkriVc3QsGEt/u0WGuV1EbtcJYQVM77d7QwAkoZl0MIlSRavhp8
   7KP6BvkIpY3LQ3xjXNUo1EmjGE2DqWy9yGj3BQGMxlLAec+AAexT5T6NF
   3BlwMSzJeex/n5nFtRVvLLlhYWgdb+Ltm+7C7FRo3E5Jwm71354ukav4l
   nFXLKuODnE6/WJFMqwx7LYHWytSCvAEqhAZ2auhk3HWHl4EFJ3VbawCx8
   B16wBLohzw/A6pQ3G03N5Imo9yG/yF2+o+on2yb96nvjoRO8sVVnQQh0P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472640274"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472640274"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 19:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="1004453895"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="1004453895"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 19:30:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 19:30:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 19:30:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 19:30:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCrIJWITvgCnIpVBhi2dpf0g2hr8lg4EQT86gJbr4fyzBr1kbX70YzVRpL8LN4PjZek4x4BAq4pF2wVsMMtXzpKLtG39cNsnZ6DLR594ob3HtVLikfJeQTYS5wUWHEX7IR7bgYh3Ty8zw7BSf4LLmeIPBtcb2HxvZFDEq5kdEcDu+RabknexYSzYaqB6Yfalt/HvdcPqXVOduu12OJYv8eKqnqXSHcEHVGCAlhTIPDe9Nn/P9H9nGb9SckFepBBH4rT7AUnXVzk8RSHZQo7gr9eNkoG3R7jMy5Jit8xu/NoEUD/M6/zRYOeeX6QZQ7U5bx0qFXZY7B6lixOS9TOT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DraazRfIoi9f41hnmkAZFv6DoAi9orwefnJdBpugGE=;
 b=Z2mB3lKu9OjgeJo1FfKxUJ14OMFzghcrbG7B05ZedAc4OllZM1mjGyR+ffw8qR+s/d3VgtTtfN4n7z0w+ImSe44C6HP8/PA0eDitL05F4bh4hG9KZ6Ym82VLkuM73IIrUwtU6Qn2c1kTDZWgmfiH3pkvrM/tqGpwLYKP4BXQUneuxCheSOfPwtdQUVHU6a/7/hwNq0u3k4QC23OZ45QFSeaUIGvPFJb1u2uTlAdaa/DvxFBpkSh12k5yDl6g43SxLO/0e+4YgiXX6/9wGgNLwarDvkzcpRmRYvnzxvbL3qtypTaN1sDVbfve7DBfpgG9HRKgLWPFzIBmX5bSI/EwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 02:30:15 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49%6]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 02:30:15 +0000
Message-ID: <b9042fcb-05df-460f-87b8-4d7a04d3bd5e@intel.com>
Date:   Fri, 20 Oct 2023 10:30:08 +0800
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
 <fd389af5-d949-43dc-9a35-d53112fe4a60@intel.com>
 <05d596f3-c59c-76c3-495e-09f8573cf438@linux.alibaba.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <05d596f3-c59c-76c3-495e-09f8573cf438@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW3PR11MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a5a1e4-7215-4e90-acb7-08dbd1147e45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqU7po6DP5zvS/LoiiKgL5k0txasgy4VgqBUU3/reUKKOBa3umK/4RbhuPpZzTaJAgE0GI2s4uLi/WWnrE1FixX0fVcqoJLgc3oByiUefyrQ/GSu4pr/OvxL7/R5CoyrHQZGH+flnd9BDEVxCJvvgx5h8ZQOIy5ncBaZmAleKsSt1HpmafiFJQhIhHFqKERitUWkk6pbeFV+aOiYto89RNh2EkfcVYanrGPcuYPcgyqtRK2l7Q3OmqymEcUyFYq7mFjfH3/yVAZ0b+bPOUP379tNpWEBb4EzJqUgSh1HYggKGrKZgJkozrb80xKfyZS142cMEnreaFm+AwFYxm7AXFFEncFLyDLihK+mKnocdvcWnGgx5eN+Ww3CnP8UZqwBtAt6wpoCTyxz8aEL4zqVkIbfx8iD/NkDgGQCFmsQGXK0OTB8t+EyTWU7TwFE3zP3VpyK+CMBzbTEtaFLuKjP4peEu3S7MWwBIGeaABt/8zMEJH78gsFFhiyP6LtafPbMZ4ehQWOObUfuWipUdZT86YXJZaWFK9xjkjzHIiHLKTi0ydTqG/vMjiIiMbccFf96hRozeVONVYAeFrIufTmUqYo9inOQ13dCcT7EvgWdoz7X4b5W5qn2NPXZaedfSaGiLKf2UIMDNYws8O8ga1kkbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6512007)(6666004)(6506007)(110136005)(316002)(66946007)(6486002)(66476007)(66556008)(478600001)(83380400001)(53546011)(2906002)(2616005)(26005)(5660300002)(41300700001)(4326008)(8936002)(8676002)(31696002)(86362001)(38100700002)(82960400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c09YeXFOakd2bDFTNDMrSldPdVZVdnZYQUxDa213Y0NjQmVFNFRyM1ExNVVV?=
 =?utf-8?B?R2F4b3IrbnE1QzlZSVFMZDk1M0ZFNUdCR3J2UEppWGpMY3c5UDlCRmJRUjBS?=
 =?utf-8?B?cGNvc2tibW81QUZGL2xycTNIVWhmWElTdlYwOXFBWGhwZUN5S0Y3aTVQTkRB?=
 =?utf-8?B?T0FrWlg3bUlXRUZhUUN6SDRiSDhZTGNrWjFpaTk1QlJkdko1dTRhU0JBNHFn?=
 =?utf-8?B?Y3FSRDNVRzBJcVhRU2NmOTA3cVFHMFRxTlZCWHVYcE43SjMrNGdHaHlHNTAw?=
 =?utf-8?B?dzRCMnhmMjFSdnlhSm1MeWxTY2dYbmExVWVna2RmdGFtWHgrVHNKMEU3VWd5?=
 =?utf-8?B?aGprR05yZVB1b0ZLZ2RlYmVMV2FoSDlrdGJHZ1g4Um00ZXdkRjdSTm9zVG5m?=
 =?utf-8?B?QkJaVERzU3Vob0dwcVplckhNNWNKMUFYZTF1b1YyZmhNc3J3NjFDaFpMbG9w?=
 =?utf-8?B?dm9LR1UxMUhZSjA3K1pUczJZR0x4L0hiYUQrUldCQWMvRms0NTl2dENZRkVl?=
 =?utf-8?B?ejJaNnBYdHRJNCtmQk5SS0dBMDZSN01SYVNTWUdkNEFudFU5S242Z3NVcFg3?=
 =?utf-8?B?TkZHYmY0dFh0elZ1TVVlcUU4UHpKT3FXMU9lSmpnVVkzQWh3alJscDlRQWJT?=
 =?utf-8?B?Q2o1dTZRZnMwc0I5eFo0Yk1iOG8wcEVQR2dybUhUY3plQzFLTk5TeDBOV05E?=
 =?utf-8?B?Tm1XTHRaNnErTGs2OGc1SnQwMkFhTFp3YkV3VE1NdkdzaVQyalVUOU0zN25o?=
 =?utf-8?B?NlRMUTUyWUNhM1ZWdnhubzdkd1BJZTU2TVZqbW1zOHpNUWRZMmFwUXBqQzlk?=
 =?utf-8?B?dlkvSFRPOGhiR2ozR284c0wrQ0FiRFRqMzhUa1BsM001RllHSmNhN1UzbkRP?=
 =?utf-8?B?TEtEUlFvMUhZd0ZnaG84M2dlNnhvUy9jVEk5blFNMWdYMFZRY2JRbk9iOHB3?=
 =?utf-8?B?a292UVJZd2p5eElGd0ljbExWditHbUxLM24rWG8wbS9hZlRVTVI2am9HZVVI?=
 =?utf-8?B?SlBIM3F1NS80V0ZhVGd3aE5DcHgyRFhueFczMEY4TWwvODRUU1RudjdwWFQ5?=
 =?utf-8?B?UHhsRmlnbC8rRFhCWVFQakVlYy9NRWJONnBNQWxkM0FMcjZ5dmtDS01iSzFw?=
 =?utf-8?B?NlVXZnp1eXBtQW83ZWxmeUltYXpVbmQyVHZuVFpsSzZGdjZhQk4vOE1ZZDdI?=
 =?utf-8?B?akdaRWU3OXo2VUhUV0hmVDJQWno4QVd4UFlvNkl6MFZnNzRJUWhQeDhiYWMy?=
 =?utf-8?B?TDZtVWhHZ20vTlpBaFZ1dFNSUG9aa2xLRm1ZcWxmSDR4aEQ2SVVueGV1V0xD?=
 =?utf-8?B?eVF0dE1nUzNFVjEvOFBEV0lhaWkrRTZESXdYcU1qbEZCdHU3eGhnaHl3OXNW?=
 =?utf-8?B?OVI0eE5sMXJZMFlJcy85aWNic2QwdFR5ZUtpV2xReXRBNWxBaStnZ0xMU2kw?=
 =?utf-8?B?NFpxRFV6RDNmMHplbS9yc2t2ZUYvOGpUdVVBM3cwVlozaUdtM0p3WUdDcFlJ?=
 =?utf-8?B?VG55eE5pRkJpdlhCeXZzRXpockg0NWREanVsVTNaTGZNSGplZ2o1VUd3NFdE?=
 =?utf-8?B?bzF0YlYyRXN2U3p1Uno5aGVUbkFmbDArTDBvSHZEdXJZT0gyWWhUNWpLNW1G?=
 =?utf-8?B?c0FNWWJOSnYvSTJpekNLSGZ3cVpCc1dzWnN1ZlBnOWJzdlNROEFhVGhIWlU5?=
 =?utf-8?B?V1NFY3NqTDFnNWZkRVZSOVg1dU81T3JUTU1BZ1pJaXFvb2lVZGNmSzUvWGZ1?=
 =?utf-8?B?WUZYZG9hMnZOcURmSkE2TENmUXg2ZEt3RW1udGljL2daT0hqdmg2cFB3ZEQ1?=
 =?utf-8?B?MEhYcGxqcm53YmxnZm5BYlBzZjE4R0ZYWFFGYm96UExyNzgra3h5cGpnRVBD?=
 =?utf-8?B?aUx3bSt6YlVMUmVGdkhvTmszekZrVUJYSTY2aVdIQzNjeUpZREJQMllqSEUw?=
 =?utf-8?B?c3hpenFCRzJXTmZnejNxcm5Pc28wakVZcmlyMGo0L2owOWFzcUxma1N1UnBn?=
 =?utf-8?B?VE1qZXUrT2JKeCtMVFh6b1ZNRVJWVVpkR1NnRS9kWFFkMHkxL1pBTHczTCt1?=
 =?utf-8?B?MEVZTEJiUUVtOG50clRqcnZKK0x3VkkwR1JsRzRITUI5OWI3OC91Mm5uV2xR?=
 =?utf-8?Q?XM5pNyQiOYdiXpCVzxkJBAlA+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a5a1e4-7215-4e90-acb7-08dbd1147e45
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 02:30:15.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTRQd7gPiYgNIXpitDtatSlXACIhWZF1f96bVvHxO1hIlQp4dkOzodXFrr0UrLSKJIdbyZiz+BjNClrlJz0png==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
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



On 10/20/2023 10:09 AM, Baolin Wang wrote:
> 
> 
> On 10/19/2023 8:07 PM, Yin, Fengwei wrote:
>>
>>
>> On 10/19/2023 4:51 PM, Baolin Wang wrote:
>>>
>>>
>>> On 10/19/2023 4:22 PM, Yin Fengwei wrote:
>>>> Hi Baolin,
>>>>
>>>> On 10/19/23 15:25, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 10/19/2023 2:09 PM, Huang, Ying wrote:
>>>>>> Zi Yan <ziy@nvidia.com> writes:
>>>>>>
>>>>>>> On 18 Oct 2023, at 9:04, Baolin Wang wrote:
>>>>>>>
>>>>>>>> When doing compaction, I found the lru_add_drain() is an obvious hotspot
>>>>>>>> when migrating pages. The distribution of this hotspot is as follows:
>>>>>>>>       - 18.75% compact_zone
>>>>>>>>          - 17.39% migrate_pages
>>>>>>>>             - 13.79% migrate_pages_batch
>>>>>>>>                - 11.66% migrate_folio_move
>>>>>>>>                   - 7.02% lru_add_drain
>>>>>>>>                      + 7.02% lru_add_drain_cpu
>>>>>>>>                   + 3.00% move_to_new_folio
>>>>>>>>                     1.23% rmap_walk
>>>>>>>>                + 1.92% migrate_folio_unmap
>>>>>>>>             + 3.20% migrate_pages_sync
>>>>>>>>          + 0.90% isolate_migratepages
>>>>>>>>
>>>>>>>> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
>>>>>>>> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
>>>>>>>> immediately, to help to build up the correct newpage->mlock_count in
>>>>>>>> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
>>>>>>>> pages are migrating, then we can avoid this lru drain operation, especailly
>>>>>>>> for the heavy concurrent scenarios.
>>>>>>>
>>>>>>> lru_add_drain() is also used to drain pages out of folio_batch. Pages in folio_batch
>>>>>>> have an additional pin to prevent migration. See folio_get(folio); in folio_add_lru().
>>>>>>
>>>>>> lru_add_drain() is called after the page reference count checking in
>>>>>> move_to_new_folio().  So, I don't this is an issue.
>>>>>
>>>>> Agree. The purpose of adding lru_add_drain() is to address the 'mlock_count' issue for mlocked pages. Please see commit c3096e6782b7 and related comments. Moreover I haven't seen an increase in the number of page migration failures due to page reference count checking after this patch.
>>>>
>>>> I agree with your. My understanding also is that the lru_add_drain() is only needed
>>>> for mlocked folio to correct mlock_count. Like to hear the confirmation from Huge.
>>>>
>>>>
>>>> But I have question: why do we need use page_was_mlocked instead of check
>>>> folio_test_mlocked(src)? Does page migration clear the mlock flag? Thanks.
>>>
>>> Yes, please see the call trace: try_to_migrate_one() ---> page_remove_rmap() ---> munlock_vma_folio().
>>
>> Yes. This will clear mlock bit.
>>
>> What about set dst folio mlocked if source is before try_to_migrate_one()? And
>> then check whether dst folio is mlocked after? And need clear mlocked if migration
>> fails. I suppose the change is minor. Just a thought. Thanks.
> 
> IMO, this will break the mlock related statistics in mlock_folio() when the remove_migration_pte() rebuilds the mlock status and mlock count.
> 
> Another concern I can see is that, during the page migration, a concurrent munlock() can be called to clean the VM_LOCKED flags for the VMAs, so the remove_migration_pte() should not rebuild the mlock status and mlock count. But the dst folio's mlcoked status is still remained, which is wrong.
> 
> So your suggested apporach seems not easy, and I think my patch is simple with re-using existing __migrate_folio_record() and __migrate_folio_extract() :)

Can these concerns be addressed by clear dst mlocked after lru_add_drain() but before
remove_migration_pte()?


Regards
Yin, Fengwei

