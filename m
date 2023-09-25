Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876637AE248
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjIYXaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjIYXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:30:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7CF139;
        Mon, 25 Sep 2023 16:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695684594; x=1727220594;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oc125R3Ds0OFhai/B606Gi/HzUx88oG63e7w6efasRg=;
  b=A20E/gzSYcM4W+nwtOa+14RoKqUG0gSzpTUHnJ3vwWTfbwApUEFQ4git
   z2gyoh9VJrOWtO/+7oRPAUyJlUNmhC4Rb9CbzDt0k4bqL3fMaKX7oDeFd
   e3aW1/bDQbKtds6R2rLC/XxpAjM4gK7Rtpg+SzdU5BassqEK+U7fvkUsj
   avfRS/EEnGHECMv+Yf630IAt9MNOhdRghy7etZAcN8GH7rXrMgxarT7Cg
   Yc0J1is9ITmo7DwpNBcI2RyUEY3J7lioQMZUoysQxjprXZhY5PTMLvd+n
   c8NSzhSZ6zseGNfYjEC/DDzmdUZ6yKNkOqgvdmBhIN/y/V0Oo1661i5XC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366498819"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="366498819"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="864179924"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="864179924"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:29:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:29:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:29:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:29:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFZelUW0Zx+W+7IsPhswzksbGYNgX5RjJTRvNpV/mj1PeAkG3HtmkwvZggK/GfP1Gz+KU7CR67/B9SjH50mpDT1edW9jE9EgPvC0ukvKWbhhY9irTv/1znYij/NxJkvKliB+HI57/3edu+u9WNQ8uktk4im3JjpBe6LVM0nNjUaF5Ce8xlt9ckJWC3+KgvdURRGSJbhvt1API8Euf1HrcHHWmfqYlwrEEgqAauYK2t1nmD0GXuSscuLcfjFPHA2w8uSTeUsCZcMYC89RSTvzUlOIG59QuAUYTfa24Y3Yngk2+LPoFyEhqY4UsK/lmAwbTsO1YfjnzoIp7dE8tefq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDZc5ZOGnfG9nJ6VgyyfZ24c3jXO9QcunTIPnMn2ADA=;
 b=adSx+gMxz+49/jHg5+5IkfAn9U1WPcGHKO74GLzbu80/JTltQ8sOimZawUY/VmIlBn4RZBoDvX8/xb3z4PEUAkry7aBarcROGPxaos5BoyY1/j4c97Cfq5ZjNByeIe47xabGDEI/OmcHqUcT+rVtS7CrZGY79MtBGPfiSJG4MOtPdpazFZnZtz0fDKTkyAWvecs4Ifvh4MmSLJuCzaMY/m2zYCFByKUM0mjJLuiH+AvJE9qj1k1y8GPHL+O4W0PRMQLwOjYG2eLscCNRYkpRZrxUArpv5iIgE7mYyecmfT8CpI3tf+aHkABRWEOOcwvrE8fVB57A/8uhwQygOVoM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7683.namprd11.prod.outlook.com (2603:10b6:8:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 23:29:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:29:47 +0000
Message-ID: <20c243fd-5068-b8a0-31d3-369b739ff1ca@intel.com>
Date:   Mon, 25 Sep 2023 16:29:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and enable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-7-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230829234426.64421-7-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 3799f341-892c-4632-47ba-08dbbe1f4e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXu9UlTs87tZeC23Xvr+oI7JNKKhH+52LgDOYV/daPVqMYwe3yizHFLHig45ESLZALih/hQFubtOTEhuxjXA9NCgGpmXiOo/GfTvi47i5m+Zj6XruBG7uiDH758F7yBO+ZVQcYkG9ngRaOjnTFFiJw2MN0KbFKjaO0ezGxuIuTqAkCBVAmfhDMJWnLegk+dOXdcabgbJ1zfWG1K6xclm5nLEqd0b/UeWj8bFqL+2v+YtZnNi6j+xR7xKhPxhTSxxI3bN+LuvewLSjgHEN2F9U3cTyFlcWindbBUxqCdDQuFlPOnmMIJuzmvgWyaHIt7zZoVg/syq6xU8LNALZn3rYA530YPkb23IQFtMJ0cQzscGt+ulZ4+rg+EMhAlajH6E4nIRrbvNasdhWDm7sATJQ/mgCZB1Zl52Zoj7Y0VpwiPD/qiU25kk1VsqnO1kgcBREUMNIZIPwLjgEPL7HcLvSTWGoFX2hPv0Vva5S+jjEhAyrOUmUFXryMaFUfy073Mk7BtzwivWoQfj5YwMJo6gFdzmAP6JI+C+cI1S1q0JRxASxkGom/ZLtBeeczVOv2Y8YEcnce0j/EC/coBguA8GtDh30Rm49Gy+8xitBdeEn4mfAYrBjmaKTqL+zbyIEVGJLrIQPP336znAcKyp4EdLeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(478600001)(2616005)(53546011)(6506007)(6512007)(31696002)(66556008)(110136005)(26005)(6486002)(82960400001)(66476007)(38100700002)(36756003)(316002)(2906002)(5660300002)(44832011)(4326008)(6666004)(7416002)(41300700001)(8936002)(66946007)(8676002)(54906003)(86362001)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUVBcWxWY09BQi9WSXlsTUNCZW0yTTVtejg1c2Q4OGF1RDV3MjlCYUtyeHpK?=
 =?utf-8?B?YWdKUGx1aWRJZDZCeGF5OFFaenpSTkJGWUJLOTBKQllQdFYwN3RSRTdxWHpM?=
 =?utf-8?B?UVFyTGlXeVExckdDOWd5OWdzVXhJQ3NSUUhPOHRBU2JBOGpPQ1h6MjlMb1ZD?=
 =?utf-8?B?aytMMityczhTTTNzL0JndjUyT3ZRYkcvVDhmc2tsZlFsTU9ybFN0RHBGakh3?=
 =?utf-8?B?Z1BGQWZhT0RFaGZTYUV0UTZncEMzWFZUTGlGUFhkMDhvSDE0bk1ZZFBTcFIr?=
 =?utf-8?B?ZWZLUjhaaHhxVTZOR01vK2E4bGR4S084ZUVQdWw5MDZoYktvSXhPTUt1UzhO?=
 =?utf-8?B?dmhWRDZtUmJDbmFrL05rZTlVS2lrMzBDZE05ZWNoYUpZWE9aU0k4UFVHU1pE?=
 =?utf-8?B?L3FPTmVpYVAwVlRnUmJOM3JMb0JSdXp1Q2RHU0xzMDhVSVFFUXRVSXZIRFlG?=
 =?utf-8?B?b2VwVlhJZlBIOEcrU1ErejVtaXdXSEk0Z1dWakQ5VWNsTW9WQVdDSnYxYUdP?=
 =?utf-8?B?d0w0Q0RhbXJ5bGUzN1RKZUN4U3BuSVEzTjBlbVFkQW1CUzl5Z253ZU92OFV3?=
 =?utf-8?B?eEhGU2RWLzd5UjNncVhIN3p0NUY2Y0kwTXZVYWVPdWFxRis3SU52RVFuWncx?=
 =?utf-8?B?YzZlOXo5eWpNa21BZ3dMMkQ2VklHZUlLRFpUcmdKYWtWUitlOGFBUEZqSkpz?=
 =?utf-8?B?VFZxSnFWTFNnWFRDekQ2cmk3d01KcHhtUmt6RFF4UGwwV0FKOXRDL3Qwanhr?=
 =?utf-8?B?NlpDaGRGTnIwS3B1NDFVM1J1dUhPdkRtcGdNRTlnRUlwd1pHRE9VQXQ3WWZm?=
 =?utf-8?B?Mms5emRuQjR3MHVTMldQNG00c1J3STc1d0RjUklBUUxOTTdJcGNxbmV1bmo4?=
 =?utf-8?B?aUdMR2lkTFNxdDBSRFNoWTMrZ2ZNS05HQmNKZE5NUVFpSlpUck9tM0Y3bEFn?=
 =?utf-8?B?ajlOc2VFb1BiYWozTFc5clRGOUVkTjZzNjBEWjg4dnNLWFd5bFNjU0N4RE4x?=
 =?utf-8?B?WTQzSGZzSWhCbXlMbFczMHVQTnhTVjVCTUwzc1RQdGVNb1N1RmVYZERCSWZw?=
 =?utf-8?B?bHN5SkE2aVB4cTRGOWFjTUg1eVUwRzBxa1o3ejlNNnlwY2k1L0FjR25YUnh0?=
 =?utf-8?B?LzBnYTJCV3ZxWjNOcjhFTGM0MFFmYzJCT3EyTUhFWGp4NVBtN09qbUY2SmQw?=
 =?utf-8?B?RThmaVFOcHZnNTEyRGpmdUpPalUzNEpPaXVEclFtL2VtR3o2NWpIUE1mSmgr?=
 =?utf-8?B?YU8xcVp4WVV0Z2RWUHhKSDU0S0lNTkkxNVI3M011MVZTd1l4STdUeklnbHVE?=
 =?utf-8?B?NnA5TTI1WC9Bd0VBUzNyaUtIdW9ob2llRUZ6Q0hvSkhpeEVtblB1eDJabDJF?=
 =?utf-8?B?ZENOOVdYVG5lU2w1RThWbVczQ3BBVEhaMzVUeUh0THZSTHY1NnY1bDNheDJr?=
 =?utf-8?B?VEx2emxPNUV3c3AwdWNMTE1NM0JMa1FjemxuQ25kUHFyQlFTUGRFRDhLVEpq?=
 =?utf-8?B?WWUwRFFqOTRlZyt4dUxvL21TcVNZSThRblFUcHcrQklKWFh1OGV3ZWVCV2lM?=
 =?utf-8?B?V0R5eGV2Vmx5OFRzQWVMNlpEYkg1WkZDZWZPVVZMOHp3aGRtSyt5MXoyNktp?=
 =?utf-8?B?aklPRHZKZVFKeVpjbUZ0NGFKWWdOd1B4RjBDL2VQTWNQOG9KdVlVeDB1VkVw?=
 =?utf-8?B?SnppQlpBQml6YnRseTQzeGJMaGQ5eUF4R0ZUdUtKdEE1YWdJUWp6YkNpbDRp?=
 =?utf-8?B?a21tL0tnamJxYWtCQkcva25wU3N2cnlVMENxUGJ2VytlZ3FpaHA3QmN1RnZH?=
 =?utf-8?B?R0JYOHNyRHZ3SUhDbE1UMGMxdU9tcGJlMUZieVRuV3U0MEtaQVVNV0orRGNz?=
 =?utf-8?B?VUwrTFpDWldEUlUwb2ZqbXVuOHlQRzdjeW5pRndSSDdBbWdsQm40Z1RkR1pw?=
 =?utf-8?B?RVRwVmlJeWdYQ0xLZGttWEtiRzI2WnBlSk5FVE9qVHVsRnpxOXE3ckJtTlh5?=
 =?utf-8?B?a1pRSmpVK2d0MHNTQzhwbnVCenlkMFUwYTRMYVBJajFmTG9jMGRkZU1BQzEv?=
 =?utf-8?B?YVNTM3BPeUcyaG5maGI1MFhpUCtEZE1XaE9YZTZmcjVDTzQ3NFRQcGZ4bk83?=
 =?utf-8?B?SnlSU3BBcllHV0lFekpzS1NTMzRLaXRRS3JSTGFZT3IyUXJJMkpxSkpPS1cw?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3799f341-892c-4632-47ba-08dbbe1f4e78
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:29:47.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrxrZQeTFa0pefmtIbU5zPxWLTamzc2B6Xege7S9FFwIfSg9ZJIH4XeV7mxpk5GolaaVExn7OHEV0zGTcB5+uNBwOMPQeZpphLN1uSSssBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7683
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/29/2023 4:44 PM, Tony Luck wrote:
> There isn't a simple h/w bit that indicates whether a CPU is
> running in Sub NUMA Cluster mode. Infer the state by comparing

Sub NUMA Cluster (SNC)

> the ratio of NUMA nodes to L3 cache instances.
> 
> When SNC mode is detected, reconfigure the RMID counters by updating
> the MSR_RMID_SNC_CONFIG MSR on each socket as CPUs are seen.

Can it be explained how RMID counters are reconfigured when
the MSR is updated?

> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h   |  1 +
>  arch/x86/kernel/cpu/resctrl/core.c | 68 ++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 1d111350197f..393d1b047617 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1100,6 +1100,7 @@
>  #define MSR_IA32_QM_CTR			0xc8e
>  #define MSR_IA32_PQR_ASSOC		0xc8f
>  #define MSR_IA32_L3_CBM_BASE		0xc90
> +#define MSR_RMID_SNC_CONFIG		0xca0
>  #define MSR_IA32_L2_CBM_BASE		0xd10
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index ed4f55b3e5e4..9f0ac9721fab 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,11 +16,14 @@
>  
>  #define pr_fmt(fmt)	"resctrl: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/mod_devicetable.h>
>  
> +#include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/resctrl.h>
>  #include "internal.h"
> @@ -724,11 +727,34 @@ static void clear_closid_rmid(int cpu)
>  	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
>  }
>  
> +/*
> + * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
> + * which indicates that RMIDs are configured in legacy mode.
> + * Clearing bit 0 reconfigures the RMID counters for use
> + * in Sub NUMA Cluster mode.
> + */

I think I missed where "legacy mode" and "Sub NUMA Cluster mode"
are explained. 

> +static void snc_remap_rmids(int cpu)
> +{
> +	u64 val;
> +
> +	/* Only need to enable once per package */

Sentence end with period.

> +	if (cpumask_first(topology_core_cpumask(cpu)) != cpu)
> +		return;
> +

This is an area I am not familiar with. The above code seems
to assume that CPUs are onlined in a particular numerical
order. For example, if I understand correctly, if CPUs
are onlined from higher number to lower number then
the above code may end up running on every CPU online.

> +	rdmsrl(MSR_RMID_SNC_CONFIG, val);
> +	val &= ~BIT_ULL(0);
> +	wrmsrl(MSR_RMID_SNC_CONFIG, val);
> +}
> +
>  static int resctrl_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
>  
>  	mutex_lock(&rdtgroup_mutex);
> +
> +	if (snc_nodes_per_l3_cache > 1)
> +		snc_remap_rmids(cpu);
> +
>  	for_each_capable_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
>  	/* The cpu is set in default rdtgroup after online. */
> @@ -983,11 +1009,53 @@ static __init bool get_rdt_resources(void)
>  	return (rdt_mon_capable || rdt_alloc_capable);
>  }
>  
> +/* CPU models that support MSR_RMID_SNC_CONFIG */
> +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> +	{}
> +};
> +
> +static __init int get_snc_config(void)

Could this function please get a comment about what it does?
The first paragraph from the commit message should be ok.

> +{
> +	unsigned long *node_caches;
> +	int mem_only_nodes = 0;
> +	int cpu, node, ret;
> +
> +	if (!x86_match_cpu(snc_cpu_ids))
> +		return 1;
> +
> +	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);

How about bitmap_zalloc()?

> +	if (!node_caches)
> +		return 1;
> +
> +	cpus_read_lock();
> +	for_each_node(node) {
> +		cpu = cpumask_first(cpumask_of_node(node));
> +		if (cpu < nr_cpu_ids)
> +			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> +		else
> +			mem_only_nodes++;
> +	}
> +	cpus_read_unlock();
> +
> +	ret = (nr_node_ids - mem_only_nodes) / bitmap_weight(node_caches, nr_node_ids);

My static checker complains about the above line risking
a "divide by zero" that may be the case if the bitmap_weight() returns
zero. You may need to ensure this is safe here before more static checkers
start analyzing this code.

> +	kfree(node_caches);
> +
> +	if (ret > 1)
> +		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_NODE;
> +
> +	return ret;
> +}

As discussed there are scenarios where the above may not provide the
correct value. Could you please document the assumptions of this code to
highlight this to x86 maintainers for their opinions?

> +
>  static __init void rdt_init_res_defs_intel(void)
>  {
>  	struct rdt_hw_resource *hw_res;
>  	struct rdt_resource *r;
>  
> +	snc_nodes_per_l3_cache = get_snc_config();
> +
>  	for_each_rdt_resource(r) {
>  		hw_res = resctrl_to_arch_res(r);
>  


Reinette
