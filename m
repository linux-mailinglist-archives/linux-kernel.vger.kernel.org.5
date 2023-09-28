Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5387B21CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjI1PyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjI1PyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:54:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33669B7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695916455; x=1727452455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ylUZIRaAaQTu3xzBYTIxJQba7FBfSxZ4R8/3JLk85iM=;
  b=Zo2lCtjMXCnkStBRo+OumKR/N8fcG/kfI4M9EmhelZd4lG6mpPngbgb6
   mL2h07WJKd5dCnSPCf+GDTgQfwJyBVGeIxy0wFApn4CbPRxKv9ZsMU/kx
   0HqUJ1m6hYNKHd5my35Grg29IoiGTL4lnPVZhbrjCPd3RVquvzcdpql6w
   nzo9Ko3PWqUk+S/3oWuHh6zjSOY1irpUGcayY16Nw48tSv74dJhmcWGKg
   ajLJ7p4En1WEkkd7i0JfcP1wY7o3xOtBf7CnEdjlgUrJ8ABCKbvNlAAw0
   xRkdce+NVpp6w1nHXjttSuiRLG7pDnIpEI5LqWs4fkUAp4WfMLudpidAr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="384907079"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="384907079"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 08:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="726277007"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="726277007"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 08:54:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 08:54:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 08:54:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 08:54:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 08:53:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbjJ4rGF5eOx2qONvNCCUyGc6vivsln40/9OisBbFyEqsKXUvZxg3Hzj0h+o2xoHiJzJaXMlmsl4OYn8yA+N0pQ1eMSPjW+modcjyC+YIbr0WrnN0yMeCPQ116E8daG9/YoShXtlWOlyMtM4D4jEx/S0OM44FYKQLgE2f70ZUxx73R1CZ7+NkOS6mE+3V6ygni31+CTp9okt4DCKxdJ3WMWu6U42S08Aplv7sTAADKlVm4vtO0Dv8yPq8g1cNohUSSYVsNNHafTwNGGAAevyCWj48F8uXIlo/JubcYBIe6TbFaNIiqGxC++DegcuNRkdbIqdlKsBNwhb+A/uSI+5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC6FZFLDiB50lNnUJchw6Dvmc5LW0WMvHOOjeYnhMiM=;
 b=PE9UixpNHekhCRr6J8WSR2O8y/litoqs7ecWuX/cg0sJd+2OSKaZsoo5GAhuuvwGkfVgdApsMGNFgumINvubRRUh2Ylwq4y6pVTozgoMPIrOrlEP0hy1E/zVy9zb6ydN3YiZ/50cfDaoim18uAaHcDKf3aelWLA4+dDR7dQpRJjlz8W1ezwUHaDsjulrifY9N6Dv7q/m/Cnx86Q8KqX4NAt1GEOcaz69cJZFtU2eu6MQ3ImxOC0m06ywRMVsDqmNFAtBb/adGsyzHJuaf2OxgBZo8XJV76nwOUiuBsARsd1gmV+NCzoKdreD12dCqhqMwHly2K0s6sMimhS+CDRYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 28 Sep
 2023 15:53:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 15:53:57 +0000
Message-ID: <8a5d1211-8acb-762d-ae36-bf508b082ef4@intel.com>
Date:   Thu, 28 Sep 2023 08:53:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel
 CAT
Content-Language: en-US
To:     <babu.moger@amd.com>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
 <9751cbaf-8653-d32a-6058-13c251c59b3d@amd.com>
 <4sxjxe4cgvookcobwbrmsoeszjordi3bpjg22zxut3lanjc46j@xpqt6nblx6uc>
 <13b360ac-4292-5056-6d00-6eb1d4186b11@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <13b360ac-4292-5056-6d00-6eb1d4186b11@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:907:1::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe572af-ee60-4fa5-13b0-08dbc03b200f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFdlyVmLrHt3u4v/TWjlhLlGOK8sf/FiGB2ADpCjsfJexyg9HenVKfP8RDEGvZmp782EFi+KPkmkCNv5eouWG8wgHcfdoLxBUaYPSsAruD3AZ5YB0BcibMiXjWXyHLALC0SxAng0kca0I8f7gc6kVeZaXlCxk1D3RRZRCqt6fHnpmgBsMoatrqfIpZBbp+JKrmF4jCKkXCL2fANKSVpDemJsaQAsLIbOjJmINWlKJnmoIOVlKIjsoa0/ueWw7OHwegtqdvBHABWtDnWoXd0euGNdQe1K5Gd1B+glPi/AwMfQq7dFJgOaXFiYpGht4nV7Ed2gDw6xvxonV3fKja4b1tCRcb3x7xLAUnoe369orzT+i89SKpLmvreHu3FhWWHtikZWsyvzGXy3iHDIczkh4ZjryhVIOy5JuET6C0UnXY5paiHQECJX/7VyK19abC3uo+qEidmR/HDa2AT27+MF37O688MWSzgWjiOWutgewfVlX868w9gowXNc9nIxzSrMFlX6cKt7CIGtZz6aRIIxTzbDz8y8kcCF3Y3QT9DbN4khP5kV10vUAnoPm7qH2yCcebrfgjH7+vmcyPa2Aj915OdizBsvEvGBWxKSucuaQeaNa4AY92aOLJXdSZNai+gC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(6666004)(31696002)(44832011)(5660300002)(31686004)(66476007)(86362001)(6862004)(54906003)(36756003)(6636002)(8676002)(41300700001)(8936002)(66946007)(66556008)(4326008)(83380400001)(316002)(2616005)(26005)(478600001)(37006003)(966005)(53546011)(66574015)(38100700002)(6506007)(82960400001)(6512007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGhTNG41d25Bem92Njh6UHpEZEY1VXcvbU9HWXFicHNKb1VmcXVCTGZVV2I1?=
 =?utf-8?B?UDBvUDJEQVRHTGg4YUFHR3I2MFdHZUJ5eVpXUWUvRkU0TmQ2WkpCcTF4Rnp0?=
 =?utf-8?B?VWZpdDBMTXBPbTBRYTJwRmozQ29SRzFScmgvRWxOZ1hIcnNrRTQ2V0J4L2Fj?=
 =?utf-8?B?OHZVZTJlQ3hjNFBDWFgzVnBTSEJHQ2EzRXlxdFV2UHBtZWkxWjI0OUhwWmE2?=
 =?utf-8?B?dUVHeW55TkZQdkVBL1pPQm9qWS9VTnQveTJRVjlGZzJqN2JvSFRyakVrU1gw?=
 =?utf-8?B?L2VyZFlaVUwyZVhoT3RDemJ1Y1E2WjZZWDBsd3RueTZENTZkdVFFelkzS1Fq?=
 =?utf-8?B?OUhwbytSdkkyZnAyci92SEViQmxhdmgxNWFPMlpwTk5KSGY4cHRWamJDQ1pD?=
 =?utf-8?B?N2JsdURjaDkxS3NJS1hmOXRmamRBU0cvbXV0RnVWK004VWZzUzRMcm9uMGIw?=
 =?utf-8?B?S2VPckJiQVVYSVFIeFh6WlcrTmQ5NXpXbG1hZEpEZVJHT2xjUlB3UkJpUFJZ?=
 =?utf-8?B?VUR5WHQ0NktGVWJCRVpuQ1J2RjVBdDJkT05jUDZPUG9oMzBEOXR5dnovZ1Bw?=
 =?utf-8?B?b3g1ak1KMXVSalZZT1pHZ3lZZnZZNTJIVHJ3b2tLUTk1MVh2Umg3L1V1VUxQ?=
 =?utf-8?B?YzRWNVNnTmRNNFRNaW44WDgrVG91Wm5YOVh4VnR4Zy9ya1ZuRjFxdi92RE5G?=
 =?utf-8?B?QTEyOVg4S0RjUmp1eWtrSE5LK1c5TDQwbXpERmk1Z2pZUjZINFhoeXYxOHBn?=
 =?utf-8?B?ejh6YVBtOEZTWDIyNmtlbDhpS2VWMzY1bFVPcDNzZnZ6K3lzUnNSd3JZYTNB?=
 =?utf-8?B?UU8wS1JHZEUwSThZVHFWdUxnM0dxald2Nmlpd2hwVHBtL2ZOdmZYZ2FZempZ?=
 =?utf-8?B?djgrY2RneGNhM1F3Qm5Db3JsR0hudVpwbzRwL0haTlNrUEJDb3krWGlnczFW?=
 =?utf-8?B?U1pjZlFnZkhrVXo3TmQ3bjFMeWphRnNzalNPa3dQdmk2THh1bG94VVoxYjFJ?=
 =?utf-8?B?VGdsWTl3aHZZNHoyTUk0OUZDdFdEY0ZIdUUvSENWWGo1Nkx5QklaWTdrMEFo?=
 =?utf-8?B?a3pSRnlobzBWQjg3Vis2T1U1anpSeXgvRElzQUpmWWl4aUt2Ukl3VEsxMHBs?=
 =?utf-8?B?QTZCcW1VYmpVNm1zN2lURXAxc3NKK1M3ckQ4a3kvV2lvWUY3c2xUSjhBbXMr?=
 =?utf-8?B?WU44NklYOU4vNGErSGQyZXJjQlVOMUVyNjZGUzZJV0dHeWVSbDB6S0RxcWFM?=
 =?utf-8?B?am9WWFpXckoyUm9vNVpqc1pVdG1TV1lyV0QyL2xBaWJNblh2dkg1RmE2Wm9l?=
 =?utf-8?B?UG9iZG9nYVNhOE5zSWRaVGhpMnVmaU4zaU5nRFFkaHNabko4OVJ5bFcvMXM3?=
 =?utf-8?B?RUJER25EQXZNSUxubXI4ZE9qaFA3YXk3QmczSmpuYXRrOFVUR3lqdi8wNy9j?=
 =?utf-8?B?TVRZcGdITHNDQ1c3VHM0cHJXNGxWTUpGeHFJL01WWnBISnFJZUJtRi9yVWE3?=
 =?utf-8?B?aGJZWW5aaXZxY0tVRHg2cXVUR1FJUjEzZDUvdXdhUE12VU13ZzY4cWV3RnJp?=
 =?utf-8?B?VHBjYzcyTHJrVWtMb1lEbXlHZU9TZ2hCMkRFdU1Idk90SWYvMW5oa0RHcmhk?=
 =?utf-8?B?NFFoY29tK096b2pyTFRkeDJ3cm1aVUZ5czM2aktpcW1VZk9NcGViYW9jZkw5?=
 =?utf-8?B?TXc4RW5yMTlBWjM4Kzd4OUttS0Rvc2hLaHlQeEVzSUp3TmdYdTJHU0IyRllo?=
 =?utf-8?B?NHg0T2VmMjRDNTFOTkptbjZVTWZ0MFVRL2pTYWR6NnRCcS9nL1RIK2RsM1RU?=
 =?utf-8?B?TXNJWUtldDBRZVovemloVzVOdVphb3orSHNEOUxyQUJoNEFXdnhCRTdwS1Fy?=
 =?utf-8?B?V3Q2c1ZHOGNBQm1PTWdIUUNoRFBuaHNwbFdBS1dFZERaZ0lxSmEvUmlzZTIy?=
 =?utf-8?B?K09nYkQwUnpoL1FTK3JRVEhQMnZsR29zQXA2ejRNZWx1UWxmL1EzNWozc0o5?=
 =?utf-8?B?NVJaODQ1OTArL3Rsd0ZHS3d2UnhuM3AvalY1RkI2Q3pQTlYrdDdPeHNYRVlD?=
 =?utf-8?B?dlVaWVArMHh6Mmx3TTlEWUxpNEUvTDliczdoeXVOTFFUWmRPNnkxU252WFdV?=
 =?utf-8?B?czhybExvc0FaY3BXRWtteUFpUmF2UHpjU2lTTFlMY1JESndQdXBVSm5xWW15?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe572af-ee60-4fa5-13b0-08dbc03b200f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:53:57.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjV/koeR/K+WoTUurxStVI6krYYpgdt1RUg7kGct+jKe7F3CMrkCIGdDzesxL138qjD0CdhwT1d/IcEeH6Ozpg7XrdpA1/xtZfBIXuJaL6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/28/2023 8:08 AM, Moger, Babu wrote:
> On 9/28/23 02:06, Maciej Wieczór-Retman wrote:
>> On 2023-09-27 at 17:34:27 -0500, Moger, Babu wrote:
>>> On 9/22/2023 3:48 AM, Maciej Wieczor-Retman wrote:
...

>>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>>> index 030d3b409768..c783a873147c 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>>> @@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
>>>>   	r->cache.cbm_len = 20;
>>>>   	r->cache.shareable_bits = 0xc0000;
>>>>   	r->cache.min_cbm_bits = 2;
>>>> +	r->cache.arch_has_sparse_bitmaps = false;
>>>
>>> Is this change required?
>>>
>>> This is always set to false in rdt_init_res_defs_intel().
>>
>> The logic behind moving this variable initialization from
>> rdt_init_res_defs_intel() into both cache_alloc_hsw_probe() and
>> rdt_get_cache_alloc_cfg() is that the variable doesn't really have a
>> default value anymore. It used to when the CPUID.0x10.1:ECX[3] and
>> CPUID.0x10.2:ECX[3] bits were reserved.
>>
>> Now for the general case the variable is dependent on CPUID output.
>> And only for Haswell case it needs to be hardcoded to "false", so the
>> assignment makes more sense in Haswell probe rather than in the default
>> section.
> 
> Here is the current sequence order with your change.
> 
> 1.
> resctrl_late_init -> check_quirks -> __check_quirks_intel ->
> cache_alloc_hsw_probe
>    r->cache.arch_has_sparse_bitmaps = false; (new code)
> 
> 2. resctrl_late_init -> rdt_init_res_defs -> rdt_init_res_defs_intel
>    r->cache.arch_has_sparse_bitmaps = false; (old code)
> 
> 3. resctrl_late_init -> get_rdt_resources -> get_rdt_alloc_resources ->
> rdt_get_cache_alloc_cfg
>    r->cache.arch_has_sparse_bitmaps = ecx.split.noncont; (new code)
> 
> The code in (3) is going to overwrite whatever is set in (1) or (2).
> 
> I would say you can just remove initialization in both (1) and (2). That
> makes the code clearer to me. I assume reserved bits in Intel is always 0.
> 

I believe Maciej already addressed this in his response to a similar question
from Peter. Please see:
https://lore.kernel.org/lkml/xnjmmsj5pjskbqeynor2ztha5dmkhxa44j764ohtjhtywy7idb@soobjiql4liy/

Reinette
