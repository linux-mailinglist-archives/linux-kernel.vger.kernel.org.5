Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D27515EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 03:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjGMBzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 21:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjGMBzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:55:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B542E1FEE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689213305; x=1720749305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xr84KlchxJMKeSuoVMzMIy6EmXJWg8gFCGwngQdLAr8=;
  b=HbFu4aWlMa8qHC/ZBPZmBe99I5n7cjDYAtZKhPQxWSEOKIV5bDT6cdT6
   mDVCEQsLuuc5uIq1ypKywRsbdtLqc70KEZ+kkG+DvXLGbMYOirhs1j2Pz
   NYGNRERL8h9TnQ6xr/QcjoBDkR/I8ZNl7ndN3z+V5bKx7SEdoeKEtPo9O
   wwsrDUw5hZSy0OZmH4aATy0omGFClgHsgjMSXXdxOGMmXKQENG7nWA5vA
   CITHAp3Jc4TbwzbTlF4Nr0M6j08Nx4YwCkZsASiq2eM+gmuGW9mAw/4UJ
   vBnpYHV/DVXFoxe+BwzBa01mz3HnNuIezgJpPaZjZdy476Qp9I0qOMeBz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363927496"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="363927496"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 18:55:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="845856966"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="845856966"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2023 18:55:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 18:55:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 18:55:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 18:55:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 18:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myZvtMcHd8HytJcXZi98WEMKS4MJzJyXoR+IFJBxDdl0AMp+olGPG+eECZUBxtjICXzaXg24tPqoc2FodWmU20+kw+/WtVEjFZbtBXwDqZyAXwidhMJMSKmnpQvX79APrxoEVgn7oDZtxed2IlWmP4xK1jREBCyyRwx6Vh9zNvGKNFMSEODdd3Pc3VU6BMtv2Kq4qnd4Ys1YlWiB7c3K95YOdWCWArpKFnWF8JyDGATr5D60W8WbAZmKiwEQ2zMBPaBIV1bRgr7ALmCkwUEYMIrBsfbbph6Fs94+3AoLYly91qaRS6OIdxX1zFXuu9eA4jKLNsiJekJTKGZ1gmvoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRNDyoJ382nlw/muNwHspf9KAdWEt3TiLszmCKxgUHc=;
 b=GVV6eq9flYw5pYSDNTQj0MZtN1acmb2rsq95cU/bNRpw3TYGXjsfFaOSV8KuCJG14z4Qi+Yk3IPf+TIpnwcZIa3ii1zII9Q7aU9acdDTHY2Rg2YeD4zM2fWQO0BkgjPh3w408qI5E5gj63kilmtk4Ksw2BbEZEf0KxVU15PVPOiNxy3zeBEZW64NXqqsYxwQDqhe4lcZhaEbpU8bKEZNNIpLI/78+4eL7veldtSduV//xz9n5R2/YLW/YuYlAv9MeECY3S4rCpiypFavQtlBfT2c5HEpNBa57tUI7E+zB2AbMmjYaLwIZllNpUTGxEGBrhEyj8ikFgt66CxLmxiX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 01:55:02 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 01:55:02 +0000
Message-ID: <78ae828c-bdc3-7318-5a3e-fe95ad7ef5cf@intel.com>
Date:   Thu, 13 Jul 2023 09:55:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 2/3] mm: handle large folio when large folio in
 VM_LOCKED VMA range
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <hughd@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-3-fengwei.yin@intel.com>
 <CAOUHufZQ0EpyRZ_jAMxs8uNSQOz6uAkzVjvvgD+4wBvmgHJoCA@mail.gmail.com>
 <6cc5a915-a28c-983f-9b32-6040f033970b@intel.com>
 <CAOUHufbK87NBia8-3OnKwma3JVxe5mJ593yCy_a3HWC1tYH_EA@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufbK87NBia8-3OnKwma3JVxe5mJ593yCy_a3HWC1tYH_EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 579bf9e5-81ee-411b-8be4-08db83442bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5jYeKwmuTP8PvZG0e99yiSfrcLMEhxIuI6ciWTVF0ETJPpTchjyUk1uGFX+VjM4cRwel+Yi5xS4kggy7UXnULAfjMLukbjG328pabPaq/vfTSyrlBnzSkdTyp9ZO8kcGt9fAvCfppodNtRgwN8kiRjeBi9PeuEh/a0Q9hbIgp6plBgybk28/kUWpyaOpKrpi4C+FI1ld/Lh1ZUkD6L2FgFQcQgrJ5Qwn7PS3rcfczkSqj5qZVXtnl+smxQp5j2moDMQvAXaci1lQaA0Frpjsgkzx7ttamS0pTmTRjT+cUZB+Og5vhDHDHAaqNIWi1X190pDk3hS+TGuMTjrlSzflbcgC3e+afRCvPaAlJQRNxAF9TJsOu8gvaWXkNss1F5UqBF6+grZwYgRqNU6YM9mkG9QjJgxyoZIGdCrORCQ983PPp9XUP9Amt8jEO9LxaHGjR1bNx9/raLWncRbHGIHnVX8KzzpIEQEdEI117uYB973xO3zI+LOteRvD4N/Zi93Gr50Z2p3tQ4XuK9r8AOc6KI4FggkHfOkrmltpk7GOP348ZOiNHwhDQwVb6dcP53s7aiVCTuk4bADI+0K+fbwG7CwyU2gc+2nSbbpNG6IT+YzXYh9QPKoiqejw8xsYl5iQ5AWwRhi3PLDszft9sIzeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(6486002)(6512007)(186003)(53546011)(83380400001)(6506007)(36756003)(2616005)(31696002)(86362001)(38100700002)(82960400001)(26005)(6916009)(66946007)(66476007)(4326008)(66556008)(2906002)(41300700001)(316002)(31686004)(5660300002)(8936002)(8676002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2V5VXZFRjEweHhJc3V3bkZEK2RmMFFGRE9CS2FGWTIzN1g3OGNPZ0tmSzVx?=
 =?utf-8?B?Q1VjZDdIdG1IZ2dXOU5QV3gyNmY0QTZBb1dHOU93OUhGSFMvbGdFNklQQzdX?=
 =?utf-8?B?a3JHSEozWDlEY1J6VTI1b0JlZ0owRi9xVjNWOGFGYjUwemFUejNudUhKVnhF?=
 =?utf-8?B?Ykd3NkhTd3B1NmViUCtocnNjVXRpMVF1Q0hkMlcvbGFoaEpQeXN6YVAySXdl?=
 =?utf-8?B?cFlqSGFpdGJlNElzRUdQSGUxRHhtYXFsdjIrM24va2p2N0s5dGI3cDRHODA0?=
 =?utf-8?B?bmVMdzdxVVVZWkhSTFdIclhzZXFObDAxK1RFUElsSnc1N0ZtNzIvcVRzWktr?=
 =?utf-8?B?K2pTL1hGUDdDbjVkZmVzYWFWYUFqUFM3U2VXbXVMZzM1bkxreDRWejhJVzZl?=
 =?utf-8?B?bENUN2oyS2REQVl2VVljNFFBQUI1bUpXeVR0M285dzFLT2lmN0s2NlRiQVhI?=
 =?utf-8?B?d3g4eVAwUUxDUkVNVEVPb3Y3K3k2K3podUk3bXZyamU5QlVmdy85amVFMTFj?=
 =?utf-8?B?aU1uNjhuc2JjaHpIMVhwdFdBN09vVStvYmdvWU1EWHZxeUtLam51eDdVWGV5?=
 =?utf-8?B?eUgrbklseWRodnF6UkViUzhGeDhRN2JaM0lJSG9ZcG9Pa0NMTGZwQlh4ckdS?=
 =?utf-8?B?b3FVbWZXQ1ZxNE9WTWJzTDVrY2tSWCs4TzdvMzNwTm9CYlZIVFB4dWU1SHNN?=
 =?utf-8?B?M01ZZWxrdmFyUVpzZUNwSWZxVjFXM3JqWnFLVVdjcmoxenBQRFJaTG1HSHRa?=
 =?utf-8?B?T0hTVU1DNVI1MS9QMXVETEV4Rk8vdWp0QlJSVTB2OEtvK2xQbjVhbjVCVDJx?=
 =?utf-8?B?MlRBY2RXVnh2YzF4eUdPWnR6RkREaG1HY1NZbVF4bjMyZVVwMzJ1NGZOM1dy?=
 =?utf-8?B?T3dYR0RRT04yd2ZwRy9NSjJZRURhUDRKVHA3TWZaYlFHOHJyOWIvaFYxa0RH?=
 =?utf-8?B?YzdoYWE1d0dFdFFES0JheDFublptcWZpeWQ0MW1wMkhKWG9JUXZ2VzFNMWF4?=
 =?utf-8?B?SytuQzlZRm9uTFlFQTdnSlE1TzNiSW1pQVJ3QmFMQkg4UVhnbDNydzIraWxj?=
 =?utf-8?B?NlplRUMwN2lOeUNYMXpqMzNDcWZTUXFNY2g0aDVnSXByaDdHT204Qnp0eExj?=
 =?utf-8?B?TTNrVWtGTlMvS3F5NVdTbUd4ZnZuTy8zelRHa1h0Wnl0bUFENHptOENaeXdv?=
 =?utf-8?B?VVFVTXB5K3FGZnJxQlVWclFxYUFtblJwNUpHdnlqWFdFY1kxclJVeHBMM0I5?=
 =?utf-8?B?bGttZThNVnZSOTFFM05iOHFMNlBpOWt3Q05tTzBQREk3ajBoMUU1dTRKWEk2?=
 =?utf-8?B?b2ZCR2R6cG00eUFoSUIrelJvZytNUGY5bU1sUnZVU2JzL3JwdnBHR0l6ZmVu?=
 =?utf-8?B?bVhQbnBuUFliWENWQlhzbWZNc1hUNkFCakdsWm1wZTYvemQyaWJGTnpWRCtE?=
 =?utf-8?B?NjFSNlJMYzU5eUxNaE5YQzh1dm1WelBpLzY0anNMRlp0UENpZFMwYk5BNjVZ?=
 =?utf-8?B?clVyb3U4cldRR21kS09GS3ZkTWNzcWM5QTIzR1hOSDIyTm1IUjZJQzc0bHk5?=
 =?utf-8?B?MTNrUys3ZDFPSjhCS0gwM0VXaHRBNStEQ0V5WEhwdkt5bU5GYmRBbjd4YXhB?=
 =?utf-8?B?d051N01PYnhKUWFBajY2VkFZMjNzSVFOVnpaeTdhTVRTdWVQQzB6emlTQ2JR?=
 =?utf-8?B?SGtXc2U0dzZBMUtwOXp2S0IxelpTU21kWTJnWnVkNllKcjl1d3c5bEVSZDhU?=
 =?utf-8?B?bS81dDlpUmJXK1lJZG92OUZIRWhob0xFaktxUTNJY3Jac0RxY1lSQnRPUVgz?=
 =?utf-8?B?NTcvODgwZlVTRnM3c0VBb09LalNaNnREZldoR29HZ25uWGpEeURveUk3MXl0?=
 =?utf-8?B?TXZ5dElhLy9SNTJ4Z1BiYys4eG4wdU02WWR3M3h1cUplSnNvWFdBQWZ4alpF?=
 =?utf-8?B?Vjhmc0hGUmxHcWxVVGdCYlJnVGJpU1hJVnNNMlUyWENHQ3BiYmpyazZlYmx4?=
 =?utf-8?B?dXFBcjdvcE0rU1lLNG8zdW1PMk1vZll0NFV0TFFiZVpaa1NiN0hJVEJkMlBQ?=
 =?utf-8?B?a3lPNGtLN0dLWndrWXh5RW1LcHdML3ltcU4rMHZVRjBzQytieGFSSmFzOThG?=
 =?utf-8?Q?uWqz73/J0MyPR4SydvflLcWNZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 579bf9e5-81ee-411b-8be4-08db83442bbd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 01:55:01.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gz9IexaA5L16mPkvSxZ6IBK2+uiD5TKbhs9BVfgRmjICdjL65Sn2SrLA3BAozcEH62dqJKGxve5/hYZk5Y9vAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
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



On 7/13/23 01:03, Yu Zhao wrote:
> On Wed, Jul 12, 2023 at 12:44 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>> On 7/12/23 14:23, Yu Zhao wrote:
>>> On Wed, Jul 12, 2023 at 12:02 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>> If large folio is in the range of VM_LOCKED VMA, it should be
>>>> mlocked to avoid being picked by page reclaim. Which may split
>>>> the large folio and then mlock each pages again.
>>>>
>>>> Mlock this kind of large folio to prevent them being picked by
>>>> page reclaim.
>>>>
>>>> For the large folio which cross the boundary of VM_LOCKED VMA,
>>>> we'd better not to mlock it. So if the system is under memory
>>>> pressure, this kind of large folio will be split and the pages
>>>> ouf of VM_LOCKED VMA can be reclaimed.
>>>>
>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>> ---
>>>>  mm/internal.h | 11 ++++++++---
>>>>  mm/rmap.c     | 34 +++++++++++++++++++++++++++-------
>>>>  2 files changed, 35 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>> index c7dd15d8de3ef..776141de2797a 100644
>>>> --- a/mm/internal.h
>>>> +++ b/mm/internal.h
>>>> @@ -643,7 +643,8 @@ static inline void mlock_vma_folio(struct folio *folio,
>>>>          *    still be set while VM_SPECIAL bits are added: so ignore it then.
>>>>          */
>>>>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
>>>> -           (compound || !folio_test_large(folio)))
>>>> +           (compound || !folio_test_large(folio) ||
>>>> +           folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
>>>>                 mlock_folio(folio);
>>>>  }
>>>
>>> This can be simplified:
>>> 1. remove the compound parameter
>> Yes. There is not difference here for pmd mapping of THPs and pte mappings of THPs
>> if the only condition need check is whether the folio is within VMA range or not.
>>
>> But let me add Huge for confirmation.
>>
>>
>>> 2. make the if
>>>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
>>>             folio_within_vma())
>>>                 mlock_folio(folio);
>> !folio_test_large(folio) was kept here by purpose. For normal 4K page, don't need
>> to call folio_within_vma() which is heavy for normal 4K page.
> 
> I suspected you would think so -- I don't think it would make any
> measurable (for systems with mostly large folios, it would actually be
> an extra work). Since we have many places like this once, probably we
> could wrap folio_test_large() into folio_within_vma() and call it
> large_folio_within_vma(), if you feel it's necessary.
I thought about moving folio_test_large() to folio_in_range(). But gave
it up because of checking folio addr in vma range.

But with new folio_within_vma(), we could do that. Will move folio_test_large()
to folio_within_vma() (I will keep current naming) and make it like:

     return !folio_test_large() || folio_in_range();

> 
>>>> @@ -651,8 +652,12 @@ void munlock_folio(struct folio *folio);
>>>>  static inline void munlock_vma_folio(struct folio *folio,
>>>>                         struct vm_area_struct *vma, bool compound)
>>>
>>> Remove the compound parameter here too.
>>>
>>>>  {
>>>> -       if (unlikely(vma->vm_flags & VM_LOCKED) &&
>>>> -           (compound || !folio_test_large(folio)))
>>>> +       /*
>>>> +        * To handle the case that a mlocked large folio is unmapped from VMA
>>>> +        * piece by piece, allow munlock the large folio which is partially
>>>> +        * mapped to VMA.
>>>> +        */
>>>> +       if (unlikely(vma->vm_flags & VM_LOCKED))
>>>>                 munlock_folio(folio);
>>>>  }
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 2668f5ea35342..455f415d8d9ca 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -803,6 +803,14 @@ struct folio_referenced_arg {
>>>>         unsigned long vm_flags;
>>>>         struct mem_cgroup *memcg;
>>>>  };
>>>> +
>>>> +static inline bool should_restore_mlock(struct folio *folio,
>>>> +               struct vm_area_struct *vma, bool pmd_mapped)
>>>> +{
>>>> +       return !folio_test_large(folio) ||
>>>> +                       pmd_mapped || folio_within_vma(folio, vma);
>>>> +}
>>>
>>> This is just folio_within_vma() :)
>>>
>>>>  /*
>>>>   * arg: folio_referenced_arg will be passed
>>>>   */
>>>> @@ -816,13 +824,25 @@ static bool folio_referenced_one(struct folio *folio,
>>>>         while (page_vma_mapped_walk(&pvmw)) {
>>>>                 address = pvmw.address;
>>>>
>>>> -               if ((vma->vm_flags & VM_LOCKED) &&
>>>> -                   (!folio_test_large(folio) || !pvmw.pte)) {
>>>> -                       /* Restore the mlock which got missed */
>>>> -                       mlock_vma_folio(folio, vma, !pvmw.pte);
>>>> -                       page_vma_mapped_walk_done(&pvmw);
>>>> -                       pra->vm_flags |= VM_LOCKED;
>>>> -                       return false; /* To break the loop */
>>>> +               if (vma->vm_flags & VM_LOCKED) {
>>>> +                       if (should_restore_mlock(folio, vma, !pvmw.pte)) {
>>>> +                               /* Restore the mlock which got missed */
>>>> +                               mlock_vma_folio(folio, vma, !pvmw.pte);
>>>> +                               page_vma_mapped_walk_done(&pvmw);
>>>> +                               pra->vm_flags |= VM_LOCKED;
>>>> +                               return false; /* To break the loop */
>>>> +                       } else {
>>>
>>> There is no need for "else", or just
>>>
>>>   if (!folio_within_vma())
>>>     goto dec_pra_mapcount;
>> I tried not to use goto as much as possible. I suppose you mean:
>>
>>     if (!should_restore_lock())
>>         goto dec_pra_mapcount; (I may use continue here. :)).
> 
> should_restore_lock() is just folio_within_vma() -- see the comment
> above. "continue" looks good to me too (prefer not to add more indents
> to the functions below).
Yes.

> 
>>     mlock_vma_folio();
>>     page_vma_mapped_walk_done()
>>    ...
>>
>> Right?
> 
> Right.
This is very good suggestion. Will update v3 accordingly after wait
for a while in case other comments. Thanks.


Regards
Yin, Fengwei

