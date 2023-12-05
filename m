Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ACE8062DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbjLEXWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEXWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:22:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A0135;
        Tue,  5 Dec 2023 15:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701818530; x=1733354530;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SBe6eu2i0z4aHkqePmfFzO7KUK2SiNRIUk5L9rjZj+w=;
  b=CPygRuJFW+Wxym6EO2We1F812epCjwZnf/Vmx6QAgoPjO5h7XQjC9AeY
   IvKVCAKM0sldT5M0GCEsFMjmycLEgQ56IObPkoj8zKpd+6fB1AGJl6Sbz
   fcIOIyuzmQ2u/YCBztfEABboHrLuIY4JdNOyRjIyNf7cWe5CU6f6OIf9q
   jOe83yKbXinlyJ/gagB0mIwnJnXDfhC3gVINHc7TZQ2BSlJ/cmIzxsDfH
   dYotib0HCUi2UyCI5jFPmSmOqAzj1ZzlfNzU/WK1w5eie7DPKVnBzWaIK
   YfWNJpiZDrmSjkajdoYjjis4UkBW/zQzXEkGs1itdyxknRsft0Etww4B2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1032923"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="1032923"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841635860"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="841635860"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 15:22:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:22:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 15:22:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 15:22:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2Cx/OdKDstvmlrRbKsZrfCeI75n3PImHZYcDPJt/85+LwTfKFCqDYpV2945ViYa8AA6ozGvp2KE/axg/iSEk4asU1A62HDs46mC0nR/UVm4ifdZ/iE66T9VYrlWTRzdjD1p6AazJ+W+InthlMievlWAA+RioqV4DYzH/to6984PS5t4KPLyJyNckNrq65gEnmtW/PMYVtMS5M/7EQZ/mVv9UxQ07+LwwxHU9RWYZmkmoaPlDCrWdHWTqg9vbTPbS7iXSyzY5U02VXCYJsNCV8aPIIXbcbVTvFDpOYy9nfECgchkU/ai21xgyP0lL4fqxFuLP9F/5vUYGtihcp5O9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lFKg2PwXxb+YdLem1VuklDzjaZRDoYsZib5dnVFNHM=;
 b=d/hbiuO7zKfJo7AbWZ+khpa/kq/fWpe8rqhmGixcpIUgGusMYMz72D95tSfG2vr5NRf4RKimH/uq9jjTBbUROHwu1MVG4+xXJUGSCzKlGKMmpEFwekskb56Nrk17uXuMHpdEdwUkLOE5Hza292AsDTSOWGnXvrvOPG0+BF5Gvpnp9vQUNPb6P6FE7JOpzykLryACVyQVzHJAg7eRi1O7KENF5orfqLHHyspMaL0tU6M80nkv9VZUeevniyn+rPwsyNFbRuTrf0K9dEhiroQplvGHfoq/pJaVwbUfX27Oh08gYzgKrcqq7990cfFayF+tU2bzkKUR00sEnxtonqF70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7311.namprd11.prod.outlook.com (2603:10b6:8:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 23:21:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 23:21:58 +0000
Message-ID: <47f870e0-ad1a-4a4d-9d9e-4c05bf431858@intel.com>
Date:   Tue, 5 Dec 2023 15:21:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <jmattson@google.com>,
        <ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
        <kan.liang@linux.intel.com>, <nikunj@amd.com>,
        <daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
        <rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
        <maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>, <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <20231201005720.235639-3-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231201005720.235639-3-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdf2986-fc85-402d-502f-08dbf5e8fa24
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDTVKFPCwh0h0lBqJf5gzwb9KFme8YtGjUqCX7maDWEfalcr0dHJyRv8TAzgsJU+aIefpbq8JKY1bwh4ykBTn9Ew/wMMUBDjO9pgaQ+GlbADs40nbyn7lHL3O+VRGMrBMDDzt1wmWWiANhobpD8Dq2WzOKLw68K0tbKDlIZN2yOG0M35x8ReXhT2P8hsOXpm1NCaL3MjTwfNMYOr8FhYn0MbVoQPAfSHoYoTQQ8Fi38PhMUbxDmQzYeLEWa4lL2dxEWpXfiqMwrEEFCTsLb5KlekbJ3sMWGl0wXJQ7d+2scmrPtWyR6Gw7TKZm7qmy7QIqMC88txKsmXtIEARSnWnHAqn8yva15h+eoq9gvA7ZeK/o/Ak6kWm7gaiahyScprDPQn21TlTR9/4540BWbicogCHsa8twiuexFVREKzwT/2GvL4q6ySxaBxXAiLAdDmmtxrdUmTeXRKGDks1pcS6qkJDu+F6hB4XRGz/Dq7HFpOsm6viaHsj6/5jzPURwXHfyQN1sc4ePYxKHmXgdneWuzLtG5owrEbyyosfEyXh9v6YpcV4k+gHeBJMKLZi0aSTUZWs6P1rEiNQZ+6RxOIUU0j5DWQNhHkMDANVBj+Zffu09Z2g7/LqsgGuFCDwlWjZTe4zLppRY+UU/nqxExLXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(5660300002)(7416002)(31696002)(86362001)(41300700001)(38100700002)(82960400001)(6512007)(31686004)(26005)(2616005)(53546011)(6506007)(6666004)(36756003)(478600001)(6486002)(966005)(44832011)(4326008)(316002)(83380400001)(66556008)(66476007)(66946007)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elZJOFRJbVQzTWhBT3BDMDNFdk1BNCsyYU9jZEdsZUgyVG5oY1B3ZVFrc09q?=
 =?utf-8?B?VUFGdllLZklyeHR1ckJvTkI0eUkxSk53MWg3ZEVaTXovcFNkNmVhdStKUE5p?=
 =?utf-8?B?RTRlMEVUL2dFUlhOQ0VLY1hCK3g3UHJEeVpUQkxuRUcyUFk0MUJraXJvRGt6?=
 =?utf-8?B?WHNYSUhnSmdsMGg2ZktjZDE1cDYyMzJYL0JVR0dhQTdoUU9DTFA4TlJvbVhE?=
 =?utf-8?B?T3NsZGY3ME84L0N3VmxDR1lwS0dTSlJReTNyT1I5UkJiL1V1dXJEQ3Riak9h?=
 =?utf-8?B?UjlYMGtyak5TL1VueTZLUVRGRmhJT2tzdmVnZ2pOUTJPcGZEV3FNL3hiaGRP?=
 =?utf-8?B?NVljUzJWRmdieEdWa1d1czJqL0xhUWsvYkREMTZRa3hOV1JxQzVvOXcxVWoy?=
 =?utf-8?B?cXRjWHo0ZzFiSkswT2l0bU5mcGlsazdLK2Q3MDM3V01SYWRZOGw1YTNXMDMv?=
 =?utf-8?B?UEN5S2Q0VGZHcHV3aUowTmVkNmlMWXQvYnNReWYvZWlpMUlndHRDUlNaYWUx?=
 =?utf-8?B?NUEzZHpjdmdYNW10RTdLMm14TFBsWHVoeTdPalJCQlkvKzg4VXY5OGU4bG9H?=
 =?utf-8?B?TTBoY1QwSDhXVXBodEJyK0dqRnphcFhZeG14cTVOY2QyTVhCL1owbkxuODh5?=
 =?utf-8?B?eGszY1RUcXF4Y1BQdHFmR1BGT25SaXNyc2RYMktVTFh6NDBISU1RZitMc3h0?=
 =?utf-8?B?c1U4TnFxN1ZCclJua1BMZWtZQWRlQWxUbFFJdkI4bC8yM1NUelNSdVZKNjlk?=
 =?utf-8?B?ZUxPRXczTTc3NEdYcjJzelk2bTZTUnJNdWNiUnBiK3c5M0prMTkrZEJVeXFQ?=
 =?utf-8?B?dDRHOTROMjlDQUpnOXNtSUdZeElrV1JBWHZYMWwxQTJvNEl4dHVnWEV5RDZs?=
 =?utf-8?B?c0NZUVNObEJUQldnUERFMTBldVZNMllaT2lzL05EM3IwUVJ5MEZOYU85MHhD?=
 =?utf-8?B?WFVEcUVhWW9oTk11cS83RzRLcmprZUl6aDhGUXNwenBjeEMwU2pIdGQ1d1lQ?=
 =?utf-8?B?cURuV2lIVmZVSnFCWDlMN25tUzVTU0ZxaGt4MHcwK2VmYmN3MXBQOVFlbHQv?=
 =?utf-8?B?VW54b1Q2T3R3U3dtY3NmMURWVjlzL1cvSUVtT0tMcEdUZUpLUldKVzkweVMz?=
 =?utf-8?B?WGJMNnY5WnUvVU5DS25FU2J5TEhXQ2h1Sk5zaGR4b053MkZBVTl0RHJZSmdK?=
 =?utf-8?B?OTNKNnNZMUNhNXNZSkU1REwzRTN1S2ZXR2ZKN2RqcHNLd1d3TlFPdG9HbDE4?=
 =?utf-8?B?YnhabUFvOUVEU2JEU0xCS2RqdmpXVlkvUDViWEVJcHJrKzRzdXVHVHhKTGdJ?=
 =?utf-8?B?YUhwTTF5RitDUkxIbTJxenUxb0RJTlFxUnVBNVBudTNBb0NLbDBaSmtObTRX?=
 =?utf-8?B?cFBuTkMxVXR5cVc3M2h2MmZ5a01UL0gxbWt6UklOUVQxcVJETGdzVHRPSHdt?=
 =?utf-8?B?OXU0QWQ1YUlNZmNDSzVSdHFNc1dET3BvZEtrNkMxcnljUHF4blA4STgzNDVD?=
 =?utf-8?B?YmZLQkEwdy9TK3pEWVNzNE9vNUFxMWRQYnRVZkV3bXdEZng4dHdkRnRKaUwv?=
 =?utf-8?B?N1ArRkxqNkJDQ3VHb2s1QUFqb3A0ZlNzRzRFRmdLR2UyVGVrdmhYaTZCcXFQ?=
 =?utf-8?B?SkI2SGtscU4wTVlQdzZjNm5xMXg5a1BjYjR0T2lHTUNJZjFMc1gvUHl5Q3U3?=
 =?utf-8?B?Ry9xWVcxRWVDdEVrNFNRSkdScC9EYUZleThYWVZnRUM5Q0lROFZIclVoWmli?=
 =?utf-8?B?YVd0LzN4N29pdGM4UCtWZFFoZVpOTVJCOWFtVFRHSG5DVUhHMUFFK2tqR0Rh?=
 =?utf-8?B?b0FCK2pwZEZHZVVOZUh0R0ZUZ1dYaUxqdkl4ckJTN3owcEU0UXJaWithYVpp?=
 =?utf-8?B?b1cxdUFxNkVwWlhGR1lVUHlNTHlZV2tKVWVPcGZNUkYvT2tBdDNtYW5RSFZG?=
 =?utf-8?B?ejhhV2QyMEk0WHJoVVR0Uk5IbHZ4bm9ueVZFN2drNTRKVi9adjArZ25iZFQy?=
 =?utf-8?B?SWJiWHJqOTkxNHpNbDZqbUhMRjBDZkU5RnpRRkR5RkhJczdRL3VqNkFDTGhZ?=
 =?utf-8?B?NEl0RmhLRHB3NDhudElGdXVtcGtobUlFemJ0VFVKcXE2V09OOUFtdU11Z3hF?=
 =?utf-8?B?TWZ5SThwdDdzTHBRWlU1ejFOOG82aFhSS2JqNGNXN1g5bXUzS0V2Q09ZRjk5?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdf2986-fc85-402d-502f-08dbf5e8fa24
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 23:21:58.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU4P6glcrBW/kR4PhavnxMVd9Okc8qbYK7FNtMXn7Bi1XZWaIMRD2XxH7C7gPoSp0N1nVkPZBm4Ly3X5GXf+9aCVI4URSKTVxpUtr40tzA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7311
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/30/2023 4:57 PM, Babu Moger wrote:
> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
> supported, the bandwidth events can be configured. Currently, the maximum
> supported event bitmask is hard-coded. This information can be detected by
> the CPUID_Fn80000020_ECX_x03.

Be careful here ... the original meaning is the maximum length of the bitmask
and the new meaning is the maximum valid bitmask. Looking at the AMD spec
it looks to me that the original meaning is still valid, the number of
bits available in register to configure the bandwidth types is still the same.

There is additional information about which of those bits are actually supported
by the hardware.

> 
> CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
> Configuration] Read-only. Reset: 0000_007Fh.
> Bits	Description
> 31:7	Reserved
>  6:0	Identifies the bandwidth sources that can be tracked.

So above means that only bits 0 to 6 can be used for config of event type? This
is done in current implementation and I do not think this should change.
Learning and using the supported events from hardware is new.

> 
> Remove the hardcoded value and detect using CPUID command.
> 
> The CPUID details are documentation in the PPR listed below [1].
> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
> 11h B1 - 55901 Rev 0.25.
> 
> Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")

Please highlight the impact here to understand if this is
stable material. This also does not seem part of this series.

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  4 +---
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 11 +++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index d2979748fae4..524d8bec1439 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -50,9 +50,6 @@
>  /* Dirty Victims to All Types of Memory */
>  #define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
>  
> -/* Max event bits supported */
> -#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
> -
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
>  	bool				enable_cdpl2;
> @@ -117,6 +114,7 @@ extern bool rdt_alloc_capable;
>  extern bool rdt_mon_capable;
>  extern unsigned int rdt_mon_features;
>  extern struct list_head resctrl_schema_all;
> +extern unsigned int resctrl_max_evt_bitmask;
>  

Why is this global and not resource specific like other monitoring
properties?

>  enum rdt_group_type {
>  	RDTCTRL_GROUP = 0,
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..c611b16ba259 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -127,6 +127,11 @@ static const struct mbm_correction_factor_table {
>  static u32 mbm_cf_rmidthreshold __read_mostly = UINT_MAX;
>  static u64 mbm_cf __read_mostly;
>  
> +/*
> + * Identifies the list of QoS Bandwidth Sources to track
> + */
> +unsigned int resctrl_max_evt_bitmask;
> +
>  static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
>  {
>  	/* Correct MBM value. */
> @@ -813,6 +818,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  		return ret;
>  
>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
> +		u32 eax, ebx, ecx, edx;
> +
> +		/* Detect list of bandwidth sources that can be tracked */
> +		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
> +		resctrl_max_evt_bitmask = ecx;
> +
>  		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
>  			mbm_total_event.configurable = true;
>  			mbm_config_rftype_init("mbm_total_bytes_config");
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 69a1de92384a..6c22718dbaa2 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1547,7 +1547,7 @@ static void mon_event_config_read(void *info)
>  	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>  
>  	/* Report only the valid event configuration bits */
> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
> +	mon_info->mon_config = msrval & resctrl_max_evt_bitmask;

Original code still looks correct to me. Just like before the first seven
bits of  MSR_IA32_EVT_CFG_BASE contains the event configuration.

Comparing with supported bits would be an additional check, but what does
that imply? Would it be possible for hardware to have a bit set that is
not supported? Would that mean it is actually supported or a hardware bug?

>  }
>  
>  static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
> @@ -1621,7 +1621,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>  	int ret = 0;
>  
>  	/* mon_config cannot be more than the supported set of events */
> -	if (val > MAX_EVT_CONFIG_BITS) {
> +	if (val > resctrl_max_evt_bitmask) {
>  		rdt_last_cmd_puts("Invalid event configuration\n");
>  		return -EINVAL;
>  	}

This does not look right. resctrl_max_evt_bitmask contains the supported
types. A user may set a value that is less than resctrl_max_evt_bitmask but
yet have an unsupported bit set, no?

Reinette
