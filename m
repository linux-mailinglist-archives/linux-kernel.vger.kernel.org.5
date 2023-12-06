Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E08280761B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442727AbjLFRJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442722AbjLFRJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:09:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A6D49;
        Wed,  6 Dec 2023 09:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701882574; x=1733418574;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rnTvQhy5v/zOiacWI9sAkQ7LFnCBSGILHBH2mUioDN8=;
  b=WgU6RMhxOcKc+gKGZRLDrQyK0HhX/7/LoX4h5Brn4BSb7sgmq61/rz9K
   QAIBY5sIur39AqfqO+Cs/4ZY7zjADghWTNAgCF4twW0508zzwpwhp9umm
   jE6AEMrq0a2YAuayI6j1DabcIq/ehBgQIgri7x4dmWeUT4SMX5jTzwdWP
   mq3pcM1/t8kkKTsW94JZtEBP8rhKsxeWzXXH/NrMrAF2SU8jB/e6+pws/
   cz/+GmY0enCGg3VsYpoKqvfAiqi8IXgyuYGIvOhPBDzndPzrveuNTLfJA
   xxechsm+cVlQqIn4eYkcKEbaojDSzsFDuNAyexeJEdUUIRhuqCGHgMf5m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="393822164"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="393822164"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 09:09:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="721145573"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="721145573"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 09:09:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 09:09:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 09:09:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 09:09:32 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 09:09:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPNOvIovHbXHayZ0C4GRiTi0ScPPQicro1QzW2uBP0CYbCUwlcgfx1L5WHYKWj2TWGiSMITIuhZkUiB30gsty59b+9oC9CZb2ZYZbTzmC6kwKPovpOu/s+f3yhRwbDS0k34ViqYjhKrQ4CJYjNnRuKwhQMx5EoKkQb4On2yFp+os2tZTEP7lcREncbI1Wh8S8gd08lqXXKSra1CIspg+kudfMAEghAy1B0k2YGsKY42Clqk1GqSfDEf8Hbp46fcZXO0F4ob2sfC5eTNH0gVuczIOSf1cBMTmvED4seAodI2Ola80Dj7qZPvHWFsX4X7d+ppX4/0+nZ4MpFJTo2+j/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpWWOou/LOJ3UV4U3sZ3YRJJRZmkRCk90jHGpntWNZU=;
 b=nq+GJ3n08EevsmvZh2lHtzhzfuF+ZxrqAxwlMGQS/8gUqetKtxMVY9GLBqjGuMr5JoiSBZ91ZMaOD5s14elu9BtTVlq8M6JxjfURHZaw9e8A8Zm1Vi2mIIiFNTCu4h7AspmAjIRYBGqIV7+FOzChzSVx1tZOSCKPXKPGCvRFJxLPyUpBjnahvdsiV/0ejcqquQ1ne9t8Bg4jMlZp7et0SW+unO3qypM7Rta+/mY1xDEA57+NVdYuefSbovGH7d3VgXoPzqJRt7Yld7DCurnHaZiWSjF80svdJxC1jruP9Kxy/ls4Hun8etexSizZzNceHQzuGGohgjt/ye+xR0ZSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6573.namprd11.prod.outlook.com (2603:10b6:a03:44d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 17:09:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 17:09:28 +0000
Message-ID: <68f2c64b-9d46-4077-a183-0abc21ff0535@intel.com>
Date:   Wed, 6 Dec 2023 09:09:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] x86/resctrl: Remove hard-coded memory bandwidth
 limit
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
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
 <20231201005720.235639-2-babu.moger@amd.com>
 <4bca7ca1-d452-4cb7-b721-b2273f9a71b5@intel.com>
 <90245ee3-8357-4375-b735-66acfe89ff90@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <90245ee3-8357-4375-b735-66acfe89ff90@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0316.namprd04.prod.outlook.com
 (2603:10b6:303:82::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe90623-3f67-4435-1ac5-08dbf67e1a35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrQnfBctWpsimO2O0M8js9GajhJFrCmbJnAVBV7XWWqzhDpRgdksOkcQzblBjY85XQjdRMyLdr1lOzbc76Kj8F5cryTUFG0sSTIrVurGGKEcqRZR7uMM99I2UjfADwOqMMAKAwdUiW0eR0xvyQpbwPSm0k2WHhYuhRtHzQQ1GNt5OH9OMnNrZVMDf56VWcBR56BOixWv/bAI2OjTrOoiFq2uLyL/ugmXy3ixbMYNVkHZLLHQ6OKPINf5yK19xLSDxGAR12PoNxSlo4lNaJxad6L8+8oJIjlxreNLfHimWP8GLRbGcQm4RLfC4/7SbUwAY1bQQ49YGkmb1RqALsaKbKdFClXWCdQVpgRW4I/3Edb1ykDmYMUkPLF6+Mg1u3ktjRogpbsebGQoZM1oNpnrWi1pweLm7tNn42BlHVrM9q8vSiSnvuZiNogjFw+oZIulwBACjcHkn29T/wvlq+HB0TZ5e2rhEMRfwmb6QJeL74HWJ6KgGpqGbv93J4EMZfax62CK+BqHv/BoBEnYOMBfzQ5w2svMrU69aDEKSXyv9D6D0iUwBvvInfg8WBAKFUiwgV1ZN3sAAJaSTlJC7TcJ1dJpmRHyU9wh9Xp/MRR4isi9IN1XP+hDTKiuCsWns6l0pZYQfEEQh3HNmlIlC30+CYmDb4OoE0YBNUvgo3Z8sGsxKk13X505kZx8UgsDTSTy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(6666004)(53546011)(6512007)(6506007)(6486002)(966005)(478600001)(66946007)(66556008)(66476007)(316002)(26005)(2616005)(83380400001)(4326008)(8676002)(8936002)(31686004)(82960400001)(44832011)(5660300002)(2906002)(7416002)(31696002)(41300700001)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzQ3ejRvTm1IeTNIdzU2SWkzK3U2ZGd6cXk1OWl5bG9YVHBOS2hUckVvN0RC?=
 =?utf-8?B?R200dlcvR1I1eUFTRy85MDR1a0ZyaW1ONXJXd1duWHc1RmRyOVl1d1lnc3Fj?=
 =?utf-8?B?RWIzYXRDUk9mMTZsL1RRYndaekZyZVBhVmMycldRT2VWd3dXZExnTTJlQ2hu?=
 =?utf-8?B?bll1UVVyWHdteUo1ZkhHL2RsVjhoMlY2YkJpY3VOcDEzbGRnWUpqRVpJeEVp?=
 =?utf-8?B?UkVleFh4c1FVSkxoUHNqWTU2S25jY3pWbzJ2WVAycnc2KzNOT1VQV0w2dmZT?=
 =?utf-8?B?QTd6VjBzaTlIZG42OElIcmxVY3FUN2pudlVmWEl3WVFzV09OM3hGR0FPYXNO?=
 =?utf-8?B?TUc1NTNvQ0lIVkJsTEhZclpKeExMWUh6NUlXRlZveTZtOExpd0IvNExBSjJK?=
 =?utf-8?B?OVE3b3FDQXV5QTRQNmlkd0orbGJKRTdxMmdDNGFmb3ZpTjBoMHkrTGNuckp2?=
 =?utf-8?B?eTh6ejJUcnU0T1FCOFc5NGlhSUJubFMxeTBvTnJhMG00WHAyWHNNSkFzQzE2?=
 =?utf-8?B?ZmVVMnN4VmU1UFd4VWlmOFlrRVBNR1FrOVNBU0k5cHhObENTZEtOdmV0S2tI?=
 =?utf-8?B?cnJPdS93TVlCM3BuTWpBcE9SV0ViVDNkcm90NWw2eFMzeUhKMGI3OFZzb1Bv?=
 =?utf-8?B?UW9CTEJ0eHRuVkdDQTFYT0haTG1vOFRZMUlNTUNyZTZlL2pIOHVCSlJBeWY3?=
 =?utf-8?B?aHF5L2YyaVduSU4rQ3FBdUxpU3hkQXE4ZEZEVTJSZ0Z2US9MTEV5Y2sxVWJQ?=
 =?utf-8?B?N21naWpwSEtPei9qZFFONkN3WDhwSllOd0t3Q0ptRVhDdXpCZmFiQ3hTME9p?=
 =?utf-8?B?bTRNRnZ6MHNYcXJjQ2ZjVUd4OWc5bENkdWNjbGFmcjRmZTQrdlJvMUhBU2d1?=
 =?utf-8?B?TWYzVGY4UjR6Ymo4RVZXS01oSFo4c3ptdmlFMythdksxaWhxSWVYSnJqdVBM?=
 =?utf-8?B?aStYTHUwQUVUVm1zWVdQMnF0Sks0TC9qeTNLQk1xMEMwV0xVTGJTd3VlT0x3?=
 =?utf-8?B?NTZCQWp6Y3FTN2hiVGxFSUxISmRMaFhtZlRXZWg4cjZ4aGFhYjIzZytOWHpT?=
 =?utf-8?B?US9WYlpNQU1aNmRIeUlaa2tjVUF5WkJ1dWJHZmVlMEgwUFJmWnpWYVlsR0Rt?=
 =?utf-8?B?NE1SUDhqK2JXaC9tSzAvL2JJWU5NelNvRG4zdk1CNURYdDFMS2NjUyt3Ziti?=
 =?utf-8?B?VWVCZ3JhWjYrbUxBb09pWjNBbElkUmtaQkNWd2ZqKzZRN3hjeXhJcWlwWktP?=
 =?utf-8?B?QWgzWUVrK215VHdRdDRlOVlLaUdUNk1RRFA4MW1LQUZVeVYrMENFUlBOY0Vj?=
 =?utf-8?B?UERzbVRkVW43dHdzZWdPWXV5d0xYODF0bzlMbE9qRFExN29oOExsRkFaYVcx?=
 =?utf-8?B?ODZZK1N1eFhLSUZKS2VFZndpa1ExNXc1Vm5tNXNXVTdSaTBlWmZ0WkVoczFq?=
 =?utf-8?B?Qm5hc09CVHVNRTYyaXRhK1V2aHJiSlZGV0VJK1BBaWkrb1VwZ2Urb09aT0d0?=
 =?utf-8?B?Mlp0aGhsNGtndmRwVHdmcVorTHM1b2NJVjR6YU5RYzNKU2Q2N1FOdVRiK3Bn?=
 =?utf-8?B?NDdOeWdkUElaTGhIOVVuYkprT05ETnQ2dG8zL2drMXF0YlJQOUgwWHJFbUw3?=
 =?utf-8?B?NFJMQ2o0SlNXVFNLbnNLODFzMTlnaWROemd4dDFYenpUZEN2eUpXN2xseTcx?=
 =?utf-8?B?S2JJMGw1cGFzc3EzOFpHeXY2eVpNTVJGbFhZb1Jta012RjFXZHJudXU0ajNy?=
 =?utf-8?B?QXc5RHJtR0oxcFludk82cDhkRFlIcG82REc4VVZWanFFd2djTCsvbllZbFJz?=
 =?utf-8?B?MUNvNW9icGw1R0Z3Z20vUUFUd0FCTlN4dFZvZ0d2N0s4MjJYWlkrbW5NbUEr?=
 =?utf-8?B?NE1jTmZ3S2JWRklIa05DK3UyTFZyaDdINmlRK0VwNHYyaGpLTzAwV1I1NnZB?=
 =?utf-8?B?c0x4MGQwRGV2S1k0b2hJYnQ5WGhEOGZsU1hLMkdXZDEvZkxZMU00WU5YYW1D?=
 =?utf-8?B?cko4ejlpbUt6aUR6ck15c05HOGNXd3lHN1ZUT1pnUzZ2dHZDZllxYW51Ukcr?=
 =?utf-8?B?YXFVWnozTGFJQWZVbXErMndRMVJWMGlqTU1JMklSVWpibkl5QmxOTUwzaENS?=
 =?utf-8?B?VlBYU0dHbnZ3SWF1cVlvWkJGWStBbE1HOTJIQ1hBazFUK2poWHdPbDVndXRP?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe90623-3f67-4435-1ac5-08dbf67e1a35
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 17:09:27.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egAUNQGeYNMelwrZ8uo9kwDShm58Mi3c6mbe3VK7hFD8mFiiAs2g+F9I0rwClHt0WlOkji7tlnA82ngM55P7onGz8JrDLGiCM4v5lIr/G7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6573
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

On 12/6/2023 8:29 AM, Moger, Babu wrote:
> On 12/5/23 17:18, Reinette Chatre wrote:
>> On 11/30/2023 4:57 PM, Babu Moger wrote:

>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>> ---
>>>  arch/x86/kernel/cpu/resctrl/core.c     | 2 +-
>>>  arch/x86/kernel/cpu/resctrl/internal.h | 1 -
>>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>> index 19e0681f0435..3fbae10b662d 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -243,7 +243,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>>>  
>>>  	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
>>>  	hw_res->num_closid = edx.split.cos_max + 1;
>>> -	r->default_ctrl = MAX_MBA_BW_AMD;
>>> +	r->default_ctrl = 1 << eax.full;
>>
>> This does not seem appropriate. You are using eax because it
>> it convenient but if you take a look at its definition it does not
>> match the AMD CPUID instruction output at all.
> 
> Not sure where you see it. Here it is.
> https://bugzilla.kernel.org/attachment.cgi?id=303986
> 
> Here is the definition.
> 
> CPUID_Fn80000020_EAX_x01 [Platform QoS Enforcement for Memory Bandwidth]
> (Core::X86::Cpuid::PqeBandwidthEax1)
> Read-only. Reset: 0000_000Bh.
> _ccd[11:0]_lthree0_core[7:0]_thread[1:0]; CPUID_Fn80000020_EAX_x01
> Bits Description
> 31:0 BW_LEN: QOS Memory Bandwidth Enforcement Limit Size. Read-only.
> Reset: 0000_000Bh. Size of the QOS Memory Bandwidth Enforcement Limit.
> 
> In this case, limit size is 12 (0BH) bits. Max limit is 1 << 12.
> 

I see it in the definition of the data type you are using. Specifically
it is:

	/* CPUID.(EAX=10H, ECX=ResID=3).EAX */
	union cpuid_0x10_3_eax {
		struct {
			unsigned int max_delay:12;
		} split;
		unsigned int full;
	};

How the kernel interprets the register does not match with what you paste
from the spec. This is an AMD specific function, __rdt_get_mem_config_amd().
Tt does not seem appropriate to use the register definition of Intel
systems if the Intel and AMD registers do not have the same format.

Reinette




