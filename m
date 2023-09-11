Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68279B870
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350856AbjIKVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbjIKSON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:14:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC46110;
        Mon, 11 Sep 2023 11:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694456048; x=1725992048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0fhpWyIlQEI6eqQRXLcOQ8iRl4gGm+eKRlM2IuEPyFk=;
  b=XUEe+FewcAE8uGkIy/FcLlyIMyLeztgdWi8hSSF+mRx7r8W7BUi0ksCP
   d/dEsevbFnU0qzpsqddZFCTPuQ5oiXj/Vjt7mC+AaGOzGuvctPgi1l9ZH
   hGkM8AuFk4CHyh8GGlurwhNMOHvZY055FKsOk1qqm8rMq26OFkR7Lzi9u
   jqoVdBAZEkr0ojsQbuDBaIaUWY+aIN7eTRzlCUvDmGFSGwPvlZBKBiKyB
   rJGBXz8ykMCzFfl6z7dUEOSPahvDjbaWy2Poa4pQeweiQ4r5afvGjpp/6
   GOUdVYoihNkqcKkDBNPK69lXt3HeUS1RoPX/PIeUJ6jl4jy2ZmRgHGIWf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409124411"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="409124411"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720071674"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="720071674"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 11:14:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 11:14:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 11:14:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 11:14:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 11:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyU7ifwHXYn5fQsnEcFVp35FzcqzIwvkhtF6wUp2VE26mHD8uqoPAofWaxvqWonMWd/dM5lG2rYwhURuGYNClx/MkiB3XIUExl/SShC7IuFllgf5GCdqRpOVXxPHAy9oKrahRa5FzmEB6Q82PGtfXcjiS+WJSd5+h6phahyP82RNH6e/cZb/Usjc47T/MJ7vYV3n6uVr7PNiyX3s07INdQS4TbuRJMXTVAzh9yZawX9tHF+fAKVjeC91AWmyLbXSR1kDNW2/Bx54UlbeWpWF3z1e+k9zpo3H7gsd3FYHr3NHeMJ8f14TwQeiYy5V7j+V0uvaDZtRt67ipFPyfHO+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2nLrW523QVi3nc6ZiLvf3k36CZi1P3ulANNtHrm890=;
 b=Whhr8YkULGDwrSz+qSY/LNcIJ4cG17pGHbNrfybugoiiU2+ZqJRUte2S2O/OzRJ3POZI1F3oq/fEP9PtCPIxMtlfEIGtPeuaPyYgVGV/yLxc5xzvapZA0uhRFZXAu0y+vUQeQ+NCXonmxa9F3+hXr7UOsf+29SvQ8+nyiTusuZWrZhgWFn9bjSnbGAmBXl3km/Q8KywpVly6vDMlE0P6s1bKwfJYFPo3BpTaZXWwdcj5OukH3OlcB+0QD07jwvhnYljpKOH+rfSZs0DarlwT5tjR166z74l96LU1V0m+Ls/DAp4W1YhPv+Eye2e3j9UKF4VaxWaW3r6NKfksPWrbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 18:14:02 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6768.036; Mon, 11 Sep 2023
 18:14:02 +0000
Message-ID: <f4458988-1b3c-92a6-d628-4154a15bbb74@intel.com>
Date:   Mon, 11 Sep 2023 11:14:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 9/9] x86/resctrl: Display RMID of resource group
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-10-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230907235128.19120-10-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH3PR11MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c7d72f-49e4-4a39-0988-08dbb2f2e05e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xciHfngRXK3OovVLILpyQM43tr4OWD6GfBB3jFdF8gv0z1FBUlXK1qCmUthDPy6oV8tWP+OWnj1bR2eb9rtfpB/wmEP48CZ57dSQgJZfaOv/7dGa5KkQWbuRdSCg/oNOknig2KjkNmIXlGv+bgcof5hDcK8Z2kNVzmybXXGLe4959Beo4UDoFe7eOQPLGOL+f4cEogXkJjVf4GR2nqXs56WwmnFoC/XnAEOsLbonTBQha1wiQiy0KnLjT/8fasC9ZPgqna3+91zjJ90hdA8hJo3u66Q9752NFfFlFmfhVKZTAsxKSmf/BWIGVrFxdecxqf3w+EFIQzzKELfQg06/5KHiHvTmp5V1NtIHWWB7G3j3SYEiezb+OGoUwJINC8Ny5htlDnC4Pwqfa7lk5l5aVvf7S0BhdhfQdbx4z6tPzVcC2rArI3T8vYTBvxclC1g59vC7jPeUocClptx8vP5T2GpROIq5uqYl1B/tjrMKsIFXuuQ/BkSHpKVlHWxU3rXV3AMvM383bOVxKYnRDHchOtGxHjSmoQ/9VCGMz1hkV63xMHqHtWHa3F72TAZwO0iE0Q9hJUEVI3BzWHy3Ha//2F5ylyuFkG6G7t0vs1RlEjpSiss5xKirKmRQN78w/qY0JCvIHETcgTsS9maCL5leUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(186009)(451199024)(1800799009)(82960400001)(31686004)(53546011)(6486002)(6506007)(36756003)(86362001)(31696002)(38100700002)(2616005)(41300700001)(26005)(2906002)(4326008)(66556008)(83380400001)(6512007)(478600001)(8936002)(8676002)(7406005)(66476007)(5660300002)(7416002)(44832011)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RvQ2lHdlJWS09kdHNDKzg0YXpFdVJIcUJXS2plc2swbFpEdERsR0lYeita?=
 =?utf-8?B?Vkl1OUdDemVKaFpGMnRSbXA3SEcxTGx0TXNBYWFzdzh1Wnp5UHEvV1ZYUGxP?=
 =?utf-8?B?UmZxK2JXdUgrTUlLOWdXRDFkbkFQSkJuWWI1Q2pNdktBbkg4dnhJc1R0SllP?=
 =?utf-8?B?Y3lPYU9pUEpvaUJqSEhyTHFXbzYzTmZjZzlSeFNiK3luY01rcUdxL25lelpJ?=
 =?utf-8?B?b1hvLzZWckt0dnRDcGh4aUI1YTZQRzVJQjNRQi85bW96dW5NZ29HUUkxVS80?=
 =?utf-8?B?b09XM0NuZXd4ZlphRmlXanp6NVN5TFJkZEczdTFuR1pQQkdzR3ZpS3JlbUt2?=
 =?utf-8?B?VDExck52VmpZYnZZU3BvalZkanBoMFR6ZUl6SmR2Y2NzV00vM3AyS1FMNno0?=
 =?utf-8?B?MGV6TXcwYVgwTnJSV2R4Mk53RGV6eG5USXhma2M3VGNqWE9ZQmpEYlNQc0dt?=
 =?utf-8?B?Q2V1NXE4VzMyYURCa01ROW5qWUJkM3hCWU1jV040QnQvN1RwOCtaQWNOZ2FY?=
 =?utf-8?B?YlFUZHBPZ3loVXViZ3E2ZHZPWW1sMlRaS0drYzRZelVSNmt1MTU1WFlETEhL?=
 =?utf-8?B?eUVkNUErOENtUnBLZE1FZHphSlNwRHdWdnpxZHd6TDZiM0pKYWxGMkRMdHFG?=
 =?utf-8?B?U01mWHIvUWNKSFdncjVpeGxZZmU0cVZQS1c2eGtQTWs2TVpaM0VrMDRGays4?=
 =?utf-8?B?ejlvdlA2YmZiQ0ZETXdMaFlFQVhoRXdsNW5JZDkvOXBiSjRVb0dNTDJOazRZ?=
 =?utf-8?B?SXNhK0pXWFl3b2dGcGJCVlc3RFRqd3ZqUUJMK0pDT2pqWWc1RWowS0d0aFFD?=
 =?utf-8?B?Ykcxcm9oN0pBbkl2RUx3S29acllHaWFodTIraElXTHFiNXpYQVBTVVNrVjFv?=
 =?utf-8?B?ZDkvWkhIZ0FRYm8yUzlEdEd4bWRrT3o4Z2NqOW9CbFRhZml1VGI5WGlwY3o5?=
 =?utf-8?B?QUNGeXpxd3lLMGJxbmRPaDV0Rk51clN4RjA4SWlEVWpqa0V5cStlQnNlSXpi?=
 =?utf-8?B?Z3FyZTB5OVkvaWlwSnFHd3RqTnB6NjZEeDZpRjY3ZmpLbXFtNy9jbVd3dnpU?=
 =?utf-8?B?UTFzSTRXcjY3RUw3ZW40c3d1NUgzeWVQRUN6dTlDckE3VnhYOThWdzB4V2Qx?=
 =?utf-8?B?YXgvSWFGU1NqWmxjYllsRk9IY2hrdkdTcEdJbEQ5UE5xM3hpY3ZPSyt5eVla?=
 =?utf-8?B?cCtsdDRVUWlVUTFKTmZVbW1BcmVqZ3QyMGtwdS9zOUMrZWlZSCttdmJwSjc1?=
 =?utf-8?B?VjZLblp5UVFVMDBFR002SFp6YWJ1azNqUTEwaXZzMGNIUUkxRTRyWmN1WGdz?=
 =?utf-8?B?SFNhRXBRZkQ4dnJCY0Q2Z2FFNlV5c01mOG1WZnc1OE1KUWVNT2gwSnZaclBk?=
 =?utf-8?B?Kzgrc05RdjNGaEk5Qm9Lc2pibGlia3BZZG55M2Zabk9CUzlsMEpUOXhSRDNz?=
 =?utf-8?B?ajdoTmp0MkRhbnFnbGYrNmpHZFZZSTJOMlpycHo0c1c3ZWNJV2J6dnF6T2d6?=
 =?utf-8?B?L1ZyTENpajluMXZQalZoYUE4NXZ1bFByR0VqTU1zRjh2UFQzOWx6cU9udm5J?=
 =?utf-8?B?OS9BQjNncWRoMHJnNjVRUTc4bllRVFZILzVQSFVmdTBDRGVYenNjYUc3RWJE?=
 =?utf-8?B?RU1HMUlPS2V6c1FFb0MzVzhKVk5iWDZhL0lqTVRDUVVkN0ZlUW1MMy92bmYy?=
 =?utf-8?B?Nkk4Mm1DNWxQbHVqMUVCdnc0ZCt3YVpzUXlEc2VnZlN0S0V2R3JyUGxOWmhp?=
 =?utf-8?B?ZTd3bytDK2h2SGVvMXh2Zm9KajB3V1ZwSkVnSi9VNm5ueW5zcjdmY3d4c05s?=
 =?utf-8?B?TTdMWERwbTdTWk9rSWpjWDE2N1NqU09TS1NycUMvUmdPREtkQ21SZkpVYmlF?=
 =?utf-8?B?a01YWGFkaUdpQWRMTmJhQ3I3K1NUb2l6YXF3WHFVcG82QXlBWUNpa0lyQ0pS?=
 =?utf-8?B?ZUN3SEdNYUdUb2J6V0NOb213S0JDSkVuK3NYTmpHMytLeVh0QlE2d2VRZmdS?=
 =?utf-8?B?REQ2M3ZBeXVLUGo0UldlY3VNTEZMTVppVnlKZTdGYWlHT2Z0QkhmQ05veHF4?=
 =?utf-8?B?dWQ0RkRvazFKSkJYUmkycFk0bnpuRnhZcDdYQ3ZUbHRrQWljWHFmM05mZ1dj?=
 =?utf-8?Q?eZA46gjS3zVTT8M0YM+AfvpB4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c7d72f-49e4-4a39-0988-08dbb2f2e05e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 18:14:02.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XY0O/FoPEscGFa/3Jr4iADHlGJR2kUZMHRKidaCtjuYvzjPuP2Tmz4d/MFMTf68Nua2cXQNmhWITnhg7/krxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Babu,

On 9/7/23 16:51, Babu Moger wrote:
> In x86, hardware uses RMID to identify a a monitoring group. When a

s/a a/a/

> user creates a monitor group these details are not visible. These details
> can help resctrl debugging.
> 
> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
> Users can see these details when resctrl is mounted with "-o debug" option.
> 
> Other architectures do not use "RMID". Use the name mon_hw_id to refer
> to "RMID" in an effort to keep the naming generic.
> 
> Add the flag RFTYPE_MON_BASE, which contains the files required only
> for the MON group.
> 
> For example:
>   $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
>   3
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   Documentation/arch/x86/resctrl.rst     |  4 +++
>   arch/x86/kernel/cpu/resctrl/internal.h |  6 ++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 38 +++++++++++++++++++++++---
>   3 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 54691c8b832d..98b0eb509ed4 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -369,6 +369,10 @@ When monitoring is enabled all MON groups will also contain:
>   	the sum for all tasks in the CTRL_MON group and all tasks in
>   	MON groups. Please see example section for more details on usage.
>   
> +"mon_hw_id":
> +	Available only with debug option. The identifier used by hardware
> +	for the monitor group. On x86 this is the RMID.
> +
>   Resource allocation rules
>   -------------------------
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index ccdbed615d41..b4910892b0a6 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -296,6 +296,11 @@ struct rdtgroup {
>    *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>    *	    Files: cpus, cpus_list, tasks
>    *
> + *		--> RFTYPE_MON (Files only for MON group)
> + *
> + *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
> + *			    File: mon_hw_id
> + *
>    *		--> RFTYPE_CTRL (Files only for CTRL group)
>    *		    Files: mode, schemata, size
>    *
> @@ -315,6 +320,7 @@ struct rdtgroup {
>   #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>   #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
>   #define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
> +#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
>   
>   /* List of all resource groups */
>   extern struct list_head rdt_all_groups;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 8be0fb323ad3..fc830ffce82a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -795,6 +795,22 @@ static int rdtgroup_closid_show(struct kernfs_open_file *of,
>   	return ret;
>   }
>   
> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
> +			      struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
> +	else
> +		ret = -ENOENT;
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*
> @@ -1856,6 +1872,13 @@ static struct rftype res_common_files[] = {
>   		.seq_show	= rdtgroup_tasks_show,
>   		.fflags		= RFTYPE_BASE,
>   	},
> +	{
> +		.name		= "mon_hw_id",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_rmid_show,

Similar to showing ctrl_hw_id, is it better to rename 
"rdtgroup_rmid_show" as "rdtgroup_mon_hw_id_show" for arch neutral naming?

> +		.fflags		= RFTYPE_MON_BASE | RFTYPE_DEBUG,
> +	},
>   	{
>   		.name		= "schemata",
>   		.mode		= 0644,
> @@ -2535,6 +2558,7 @@ static void schemata_list_destroy(void)
>   static int rdt_get_tree(struct fs_context *fc)
>   {
>   	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> +	unsigned long flags = RFTYPE_CTRL_BASE;
>   	struct rdt_domain *dom;
>   	struct rdt_resource *r;
>   	int ret;
> @@ -2565,7 +2589,10 @@ static int rdt_get_tree(struct fs_context *fc)
>   
>   	closid_init();
>   
> -	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
> +	if (rdt_mon_capable)
> +		flags |= RFTYPE_MON;
> +
> +	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
>   	if (ret)
>   		goto out_schemata_free;
>   
> @@ -3255,8 +3282,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   			     enum rdt_group_type rtype, struct rdtgroup **r)
>   {
>   	struct rdtgroup *prdtgrp, *rdtgrp;
> +	unsigned long files = 0;
>   	struct kernfs_node *kn;
> -	uint files = 0;
>   	int ret;
>   
>   	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
> @@ -3308,10 +3335,13 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   		goto out_destroy;
>   	}
>   
> -	if (rtype == RDTCTRL_GROUP)
> +	if (rtype == RDTCTRL_GROUP) {
>   		files = RFTYPE_BASE | RFTYPE_CTRL;
> -	else
> +		if (rdt_mon_capable)
> +			files |= RFTYPE_MON;
> +	} else {
>   		files = RFTYPE_BASE | RFTYPE_MON;
> +	}
>   
>   	ret = rdtgroup_add_files(kn, files);
>   	if (ret) {

Thanks.

-Fenghua
