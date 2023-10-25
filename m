Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6D87D5F85
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjJYBjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYBja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:39:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6D11B3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698197969; x=1729733969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qYIIq66mV+nzemcrITkg3qQ44NUpLAfUtZR722fkL1w=;
  b=P56sHjbGkzJt1gQI/tU+wljwWQoNPNss3yGV5Iv43Vc8qPIqaNd4W1zg
   rBsvITgf3fRdNKO8DjLgxVsgKS5dh865A7GuGg0OLYtqt2okj9ZL/8C82
   22TsnM2XFlekWA8dJ4hzCebnlVlj85KtSg6d0It9EXVA9Jv8iTYfzdO7y
   XqoGyDrrvAUTqKnk+eKWbDjv6Mvdw15fHgegVGk4M6TtvdmJV3oQYAzIC
   ZdSK326TDI9h5SWu+9Cq2oaDjFBj29f64P/KJZ/m4/MZObvbjtFW+EUDF
   qW2t8mftpDXSyUDnDsF8+C9ACbmzDZdGcArLbH0NDwEHtbP/UvVQTSK63
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418337762"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="418337762"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 18:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="708536019"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="708536019"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 18:39:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 18:39:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 18:39:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 18:39:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4kz6LnHNAJMIQ8j0QupAMMe8E4wcGcAiCeHM1brM0yHA+RYRrehSZ+c+sqkpQ6CGtAtuVsKfpWPh+XvRFmb+2aCv6LNYUywR6N3/0QnZ7sdWxxnXzBwvigZkYFxafJBzq8aDompXzGd4SZ/PBpbywdF5Bx5TIwZs60F9jzQgb+0G6p2hlvnA7AH8bAuHWCZ2hpg39XWohH/qO0FmdnZt2zi5WIrB01T3f+S9GoQcWRtuQXQ4W9B0cNSSg7flAcxl09kU8Z2eq5Ma46+yg1WIkoG37Ay9xyjRXYEvFVtyQcZzae6ViaC/kjE0OD1rMtTnaErkzxd+zHSyEKOgKlf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjGEB+T4B8W6M5bWympgBp+Pb5Cds8dn64Oc7OhMWq0=;
 b=GWeQzWU9dz+/bKX8AunPFPLhmFm9Hko1ucNAljJfaD2eqcx0ANXImFsrzMeP4QOUJoRQ/IAUrDGu3RMNrPu68tr+en0Wl3LY9S7+/TwC0hx42VW2WcxYpAYX8AAe/LlXC2XyFarM7Rc5pa4eGWOHg0V3LSWlQiJbykQZRJ9e2xpEZQR+98DixUSASYRJFlV6yO1fPbO/47w4/EBZ0R+UuGdKV8GHgh8uGXqJgztyYMp//hFqyrh7JTDJTv5dmZ7ii+IBg2usfiq+Hs1sums0oZ1QQpELEZHM1QJLxWKj7mqgWFehigvCDYSMFj0ktJnyXMKu3+pWDl9KVgGMuuRz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 01:39:26 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::cc11:6433:f346:c503]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::cc11:6433:f346:c503%6]) with mapi id 15.20.6907.028; Wed, 25 Oct 2023
 01:39:26 +0000
Message-ID: <44e32b0e-0e41-4055-bdb9-15bc7d47197c@intel.com>
Date:   Wed, 25 Oct 2023 09:39:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>, <v-songbaohua@oppo.com>,
        <yuzhao@google.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0030.apcprd04.prod.outlook.com
 (2603:1096:820:e::17) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ef2fa1-9480-4104-8ce7-08dbd4fb38ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KII9T/x0JEHJJmGdhihEBZ34neJOayuNv3GQJDtc/2DU943zyFy4wAdZ5mCRj6i+Ny5U8sB8inpwU0iCpxZU6AweGgxXnEE5ZKFR9bYKtnEJRSQczGOqRzeZ/L5blHjd9ylW3yP7xsZvcz9513HB3awhVtIyjWm8/DB26YNCny2R8J32CrjKyXPcVVzeFybhuKn/km9qQKbYj1pdfera3VMk3I96Q7Y2CjmpooPS922Ky7yd57HHY2a7rvNPFhes3G8XtcYwnVC3WV//OyTmxanWDH4WwYZwg9cu/ZmVIb5NT76Re+BZ7pk7l6yvASqMixYkq2kupOAqUGFlMJFUUhJpf02m1cbLPLa6oSGxa3OvSiw9ychmSWpvoHUpSZhm32H6xyJy7Okf6g2ubB9x0+pJHe1jrqjM+lygymtIm8DwWES3p+P758vP+NZiYFaWXBYBAcwIna6pY+uToyh54A/MwIMKutPQSpcJ600lOrk03t12YB1f+MUugA9O3Jo3cjnxMaNvy/EOrgKc20hIHQTOYdQgYyxNPQAPO7QB/W969TBw8v9PEU5ozDmC+5l8n7oCLs8g17IkP6iLaViv6Qj3klgdBeqlZVIw5ORb4xnXY2n4+kDXzOGgZelNM77v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(41300700001)(38100700002)(82960400001)(66946007)(66556008)(316002)(66476007)(26005)(6506007)(110136005)(478600001)(6512007)(6486002)(6666004)(83380400001)(966005)(86362001)(31696002)(36756003)(7416002)(5660300002)(4326008)(8676002)(2616005)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTZ0clF4eldxVThrYWIwWmVrQ3Q2QlNYK0lac2haVlg3M01scERhejZ3VGhM?=
 =?utf-8?B?OTd3KzFmNXcxY20xY0w0VUpqdUo4Q3k4Qy9jVUdpejV6WlpleWpsUHJUem1G?=
 =?utf-8?B?V3hJWU52UEFlbk9qQ3lVRXFETkthY1MvWkRGZC9sKzlFSFk0OFAvYXFkWjAz?=
 =?utf-8?B?eUpOYjhWMUtnRitVZUpid2lEQW0vMHdvcEdKN0lhTHcyaFRubDZ3RU5VZ2RQ?=
 =?utf-8?B?QkdVZHZyYjl1bkZvcmtaQlVwQWJyMXRmUkZ5NVJ6MDZpSFppQ0M4a1FGUm9H?=
 =?utf-8?B?VUphMHF4SHJGTWJxOWlJaytHLzZoR2FwM2pWczBGeHZ1K1hvUndPaUgxd2Zv?=
 =?utf-8?B?WDNMQXMvMG1qQ1dmME80a2tGTTlBREgvTDF0bFJoZkZXczFod3hLdEhsYU5s?=
 =?utf-8?B?Q2ViUmNqM1I0QWdLN3RkaDd0T2JmTWMzMmhmamZSTmo1em5ZRE9Zd245Rk90?=
 =?utf-8?B?MlcyNmR4ci9teGJUZ3dzdTlNVzExcVEzYkkyS1k5NGZGMVg1SGpNMHR1WGlk?=
 =?utf-8?B?SktVWWlnZGI2MHFmNFRjQ1FnU20rTGRaNWZDak5XSk9zc1BqRUNZQjN6VDZz?=
 =?utf-8?B?Y20ra1FwM1ZQVWZ1T1ZqSGJjdVJpRGZQSVYvWnBYb29jWmZtWllUUG90dGdL?=
 =?utf-8?B?QWJCaVdXZDBqOUR5ZHUrTzYwa25PMDBxNmdyZnRSdElVZFBJcnRMUy85bjNr?=
 =?utf-8?B?T2t0QVl0M0QwMG1COUV2eEoraXZScnJLMEhVK0ZFdFBoVDF6MkcxbUgwTmtn?=
 =?utf-8?B?NjhZRS9YaHdzY2ZhWmU0SXV0S3dtZDRQdHFBRGZXNHlRclc1U2ovYVVBWFY1?=
 =?utf-8?B?NmpoZWRkanRIc0c4RUNmZXpPTGVzcVdJVzNIc0YvVEtiZGFMd29IMXd2VXR6?=
 =?utf-8?B?enRkVkliOFJHTUJsNGpkY0RMSXNsa0Jway9oM0Z4Q3d1d1lqMWcxcnFoZmtu?=
 =?utf-8?B?SnlnaWdlQnl4dkhvVTFTcHdJcHNFQzNvQUdsOXpDRWszaGhsOUUxQlowMnVK?=
 =?utf-8?B?amxrR2lKT1RyNjJSTldnczNkVUVnRkRZTVh6VlpvSVk2RWVvZk9GUVAxMWpm?=
 =?utf-8?B?SVh1R3orSnNWY0ZFbWlRRWJMcVY4VnlXUlZwSWc0d05hSG5sWGF3STI2SlV0?=
 =?utf-8?B?R1lTZ0hjNVZPUnVJTlJ0OThpa2dtK0RTallMa1ZnYTZUaUxGMjc1Q2tsS29w?=
 =?utf-8?B?REJWUjhCL2VBR2JqMi9iYmtXOHNwbXN6S2dVZGVoZVozOWNjTWdJUWFvZkZB?=
 =?utf-8?B?enBlTjkraXdUY2Y4UldrYXpwd1RlaWwzYzE3VlJ0b1g5THVTMjJLVzJBY09w?=
 =?utf-8?B?QldaMExzVnJvYmhBZXVPaDQ1MGZFM0syQk1iOXJVQndPc1JEV2E4TXphTUo4?=
 =?utf-8?B?WEpKWm1rQnh2VGxiSEN3TGRCSy9rZzAyd05YNjI2YkpIQ3p5NXhYOG4yVXFF?=
 =?utf-8?B?OHY1U044dzlTWEpJT2xycEZyRXNNWjg2MERLME5PbVp3K2hROTJSM2dvbFNC?=
 =?utf-8?B?aGtiMEN2ZHlYRzhvUXBlc2xlVlR0RjJFN1Q3S2F0MEpEYU5YTmdHK0Rxa2xT?=
 =?utf-8?B?RVM0M1FVdFpjclRxMzdPU0VHeXNqanMxVXlJejVSYm4xSGlRaHRVZFYwMTZW?=
 =?utf-8?B?dWpxdklnT2YzbkxQdld6MWhIcXNsQjNtTTNSeUdabWtycys2Z1RSRTg5a0dk?=
 =?utf-8?B?L3FpalFtV2kvL0U0S1FzUUxXWDhPSVFIVGRHRTMxZ3dibG5wNmpLYittVXU0?=
 =?utf-8?B?N1dKaFhRWEQyeU50WWhBYmZuNUxXQ0ZDRW9HMXNhbnl0dUtIU29nelVTMTNP?=
 =?utf-8?B?MWhmY3JBVzgyOVE2ekpxLzBlZzdtbnFBQ3ltUm1Sb1B2TUZWTGVYWUJpQTZE?=
 =?utf-8?B?b3N2QnpaYlAwT0g3aUlyc01TeGZkQXhtSXl4dUJiKzFzWFZGa00rUEhGSy9t?=
 =?utf-8?B?WHBTMktoR1N6QlYyVTBsWS9hb3RrWTVZUlA2aWtIQUVqWC9FN1YrcEJ0TzdD?=
 =?utf-8?B?Q1gycFF3NnY5bEJhakcwckRaT2NjRVYveFpxaU9PYVBmNmZub0dFNXl1T3E4?=
 =?utf-8?B?dG0wR1M4NkZrMmFrMjJXQ1lCTnVNWVpmRVZTWGlTQy9tVzU2cmdZaTMweWln?=
 =?utf-8?Q?54UPC+BOZdEuHHEJUVZN9T3fu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ef2fa1-9480-4104-8ce7-08dbd4fb38ce
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 01:39:26.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXk9H83GUkopXlEfW+E6zRoDQKyx4tF25R78gsEepK25rTh1SebrBNa/hibetI0mm+xYHDw57DCLSpf6qTcYGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 0bd18de9fd97..2979d796ba9d 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>>  static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>>                                          unsigned long address, pte_t *ptep)
>>  {
>> -       int young = ptep_test_and_clear_young(vma, address, ptep);
>> -
>> -       if (young) {
>> -               /*
>> -                * We can elide the trailing DSB here since the worst that can
>> -                * happen is that a CPU continues to use the young entry in its
>> -                * TLB and we mistakenly reclaim the associated page. The
>> -                * window for such an event is bounded by the next
>> -                * context-switch, which provides a DSB to complete the TLB
>> -                * invalidation.
>> -                */
>> -               flush_tlb_page_nosync(vma, address);
>> -       }
>> -
>> -       return young;
>> +       /*
>> +        * This comment is borrowed from x86, but applies equally to ARM64:
>> +        *
>> +        * Clearing the accessed bit without a TLB flush doesn't cause
>> +        * data corruption. [ It could cause incorrect page aging and
>> +        * the (mistaken) reclaim of hot pages, but the chance of that
>> +        * should be relatively low. ]
>> +        *
>> +        * So as a performance optimization don't flush the TLB when
>> +        * clearing the accessed bit, it will eventually be flushed by
>> +        * a context switch or a VM operation anyway. [ In the rare
>> +        * event of it not getting flushed for a long time the delay
>> +        * shouldn't really matter because there's no real memory
>> +        * pressure for swapout to react to. ]
>> +        */
>> +       return ptep_test_and_clear_young(vma, address, ptep);
>>  }
From https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/:

This is blindly copied from x86 and isn't true for us: we don't invalidate
the TLB on context switch. That means our window for keeping the stale
entries around is potentially much bigger and might not be a great idea.


My understanding is that arm64 doesn't do invalidate the TLB during
context switch. The flush_tlb_page_nosync() here + DSB during context
switch make sure the TLB is invalidated during context switch.
So we can't remove flush_tlb_page_nosync() here? Or something was changed
for arm64 (I have zero knowledge to TLB on arm64. So some obvious thing
may be missed)? Thanks.


Regards
Yin, Fengwei
