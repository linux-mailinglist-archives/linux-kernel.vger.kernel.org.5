Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9167903FD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjIAXV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjIAXV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:21:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500683;
        Fri,  1 Sep 2023 16:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693610513; x=1725146513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fvP3WH8Vm+Y6AI8JD5kWooCLLKtZmZ0QbvG3ItDHshw=;
  b=eUUhZAlGF5sktm14A6M5Z9uzD22bV8uTDPKSsQk+qA/0S3OiTAiOi+lb
   X1pTn1x1hoIIA068QkR++XgO+UgnhVhUzhbC748AmCO5HAlA4lJHnIfs/
   +WBq/YX3LNgDtv0ZGkMUuGSxKDRk4Zi5IlaW0/+76tgoCBczbocwkztqv
   T8uRQh/lWQ94T1BD9bK5ZcHUJi0QESTsi7psDBtq2QvRPidju+aLeJmQM
   rYXN6jtlQ5qAHg+6tlmqmgvWXDfS5av/4b4pYTjn+wBKCuBIwP5xLM3Cr
   sI67Un6WWVnFRzZ+FYHGC/vjGz/6fIAKm+zANwPFGeiMWZqsfu+KdNBhp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="376258309"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="376258309"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 16:21:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805611968"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="805611968"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 16:21:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 16:21:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 16:21:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 16:21:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keuSJ6awc6wMCoqZKasn6a/RPGaCQnib1YXNZGAViVPrrek3p681UuK/mia4MtKZWlptQuHdfnDxFt8vAkVVF4xp/JKBEI9myDiH549H5EwhFcc/1nC3eB8ex4obf3yyXw2Qxt0AfrCUy5+Hvj71My7hqlfTg+sbodlD2h+mlJqK2RSn4A9GpVjCZ/m9RbjrMyFComOM0yOufZF2PxO2H0qGgFV6i7kRCIb+gyC9Bg0Afy4glQ9g8geBx3cJRwXq40WxaVHtPHv/wtj2a78VmfqCRxAiG8aPB3Dkv4JpmzFh2rrS/cwBU3gUgg2WFR7CAfFwUGMhvLXM+DDt1bY8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgjgNrdSc9e6bIja6npmD6c3LqnLwR1W4jIdept+N2A=;
 b=aXYPpRG0LUZg56XMRGUKdnUIgnWFUY5Juw4r8GZdhOPjWxbGe3964p8u3bOGLfhU0+cNDDSIVLxKOFk2EW17OsWXsl2HBChCKYLVhjsAUf1FdMT+yAaxDXKGaoIenG6HYOsxQtdzp+sYsnqhGFcwvNK0/XLTOPIt+22HK0j//aALUnu/XibnMljVO9PPtJaTuj9WnVvqeVD1YHBT8bK2tHIVTN2lza7n8BxCUsY1MnP+Yj3CuLJJnQf6YdLxliiAdy/HS/4d7y5ANXDKKXm8099bEhoLE/O4dlF12oxZ+lvp4/RWg+gWJ6d40vo25p0inznOWE9SqKk3YZxbLS1bGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 23:21:42 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 23:21:42 +0000
Message-ID: <d6af932b-4e1b-103f-77f0-d91c2f3fd75a@intel.com>
Date:   Fri, 1 Sep 2023 16:21:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-7-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230821233048.434531-7-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0158.namprd05.prod.outlook.com
 (2603:10b6:a03:339::13) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA0PR11MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b95e212-a293-4b94-5e50-08dbab42336c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrp6A7fQoNZ6/HmzjQEX/bHDFI9QUaen9xiKuyF2uYuzcTnk10kKdMDsAi5lioDNc13nap65X6ARc+bnTsL2I9QaIQaDm29YpTQmmKb4+nNm6aC/FdvwiZGvgjvYbVDlgslSBDTPd2O9MZWHFJg7iiY2YdDZ68fgsWl9AEYCaL8NiYTwWScpccPk6T5T65iqnU9hV1OAhKK7sCN+HqQo6rNajIlmLju3t4rqs/Pdc3NcZpBWnCwsMdsHbg9XBYDh2faH02B3VHKlE9ICubcMKoNu0+5UMSlqnNivC/6FbNs0iOdutTr+RTrym5iqGgShL8/csL+bQBR+XWT4oen/H5gklmnfOlnypaIWWzxUYhwTXgQuTBhecUUW/zbcwS9L9lOtjdelrKh1LOd8CtwDOHJ5cDGZSEJNcS/NpGZPn6uytz9aPKEBLgrKbcsYj3fTouFi7ZVGXesNCqR3PvA4bwGuVXt4tiipBLT6jH8C58aSPFNfOtpqFW9UpzazFN/eq/tvyepSdpmxbmnqbbPHGU9rpIgIAJ1WIIWr0vp4IrIn+DzOZmzpqJ04+n7yJaHmE7SxEObz86kT15mq7ZsXSM89u9FrXABjvNIIeJahElgzlukyPnhZPkCLSjUvOT6YhrLZEkiqv7/yOAM+WKQgUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199024)(186009)(1800799009)(478600001)(31686004)(2616005)(38100700002)(66556008)(66476007)(53546011)(6486002)(83380400001)(26005)(66946007)(6512007)(82960400001)(6506007)(2906002)(44832011)(5660300002)(8676002)(41300700001)(316002)(7406005)(7416002)(8936002)(86362001)(36756003)(31696002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHJlNkg0MmtMdGE2WlNvU2JXWllrZUE4dytvNnpDUExiQnhTQUk4OXh5cGFI?=
 =?utf-8?B?UGp2VGVMYURMeEkwRTVqbWxjK3c2OEtDR2RyVE1Tc3htMTU3eGhGVkhUOU9R?=
 =?utf-8?B?WmRaZVB0TjlHK09FQ3orOWwzdkJBNC9Kanc0YnZiWkF3a1JVTDlQRmxiODdI?=
 =?utf-8?B?T2lUNFNzV2g3d09MSEV6cU5ydy8wSHZpNU1WL0p6b1V0N1lETm9UTmtFSkdW?=
 =?utf-8?B?azBmOGJObExBRHBUd3FjbVdaSTUwU0VkQzJ4ZlZsVmR4VTRUTk03Wi9RNk1q?=
 =?utf-8?B?S1FJelFUUytpVmEvbnlmcE5JU2RyN2tNOEJ1S1Vzd3I3K0RJMHlNeDhIN2dB?=
 =?utf-8?B?eTZ3Uk5sYjlQdk9OaXRxUWNOaVZSamZmR0szc09ZRSt0MFZWZ3FHY2gzS2x2?=
 =?utf-8?B?S2dtbWtOWDRMS3ViV205d0NXSmVmMENLQ1cxdTN5b1hGODVwTU1TV0RzUWFj?=
 =?utf-8?B?L3IwV25SRzlmWXo5ODRzZFNXbE5CV0tYeEMzSXFuRldTcnhXQmViaDVrWExi?=
 =?utf-8?B?Z1ppbnZzM0l3TnRkZ0dnWE5OV2RYQW1Lc09pS1ArS0lXQ1hXd0ZMYm1DSFgr?=
 =?utf-8?B?QWFPMEtYTERvT1gyK0tzSHpZOHcxemR3UzBYQlVFSVJJelhETnJGQUJlTUVX?=
 =?utf-8?B?NE96TU8wTTlkTTN0Q0pvVFdQcEdGTHFRcGhpVDh2UDE5TGllbis1alNuUnhU?=
 =?utf-8?B?c0lIMVZNZHFmNzJCTXpCYmRDVU5QLzBIRXN0ZkxycnppT2tQd3RkbnUzeUhS?=
 =?utf-8?B?TzVTTWdwVnFmOE9mTnBrMGlaT2Z4S3ArRnhJWlYzQ09haHE5V1pJc3E2bmdI?=
 =?utf-8?B?QlgrenU1bTl3Vm5VL2ZHaW1qWXhhQi85VjhKK2lRQ0JpWGsxNzZMQjludEEy?=
 =?utf-8?B?ajN2bHpJM2dYb3pJejVxNU9TY2RXL1dPOVBLL2dQempBZWF3bzkxZjI5aUpR?=
 =?utf-8?B?bXBaZDdyaW53TVRsbmtMUXRQZ01vZ2hsWFplN3FIS0loWXJ1K0NLWm1tWkIr?=
 =?utf-8?B?ZUd5SmcwZ1JVbWNwTlJ4dDRMZVVKZFV6QW9sY1ZJWGNSMmVlVS9IaHJld014?=
 =?utf-8?B?c0dSZ2RlNTUrd3RSK2dydG1WZlkrZnVLNm5oZG9LeU1xNndGTHYrWWFFeUJs?=
 =?utf-8?B?N2V0R1EwcmYrN096SHRmNXRXT3VkeWtjWjNhMnFrSk1lRkpNaEhNMU9NQmVm?=
 =?utf-8?B?WTFlSGJTRTEzM2l5MXdDVGo0VlY0QXNJUVlQdlJ6S1FMRjZzcXNUM0Y1L0Vo?=
 =?utf-8?B?TG9MZyszd1ZQYW52Znk5c0RTSFoxb0haN09RWFBMTFZiOG9ZQWNEcHU5a0s4?=
 =?utf-8?B?MFIvU1BBa01RazROZCtBMytaYmdKQUFrdytuSHVVUGV4UjNpb0MrUDJXVHV1?=
 =?utf-8?B?ZW5ZWk5sWmJLWWtPQWZKTys0NENiZEI4S3Iyb1ZFVnlxR0g3aDRRcWR6NUJB?=
 =?utf-8?B?Y0pnOHFRV1JDTWo0QTQxc21jVzUva05SMUVxVVRpVkFMOStBL3F6VElVMlhH?=
 =?utf-8?B?cmJhOTRBZERGblhWSDYrUEdYQXNBd25FM213MmxwUHVqZSttT1plQzZiZWps?=
 =?utf-8?B?UjJ1REN4My9oMmdhYjh1SFdYNGlEeUhGbGpLbG14SFRLNm43bUhaWWF5bkRM?=
 =?utf-8?B?S0FOL0wyUHF4STdUNUh5cFRPazVKeTZKdmNLUkNLaHp0TWlsMjlFblhRU1kw?=
 =?utf-8?B?dCtQOTNKM1lKMEs4WU5hWVpPZmRYNWFLTityMWpGV3RYbEQ1UkthbmtURHA1?=
 =?utf-8?B?OU1iN0VnelZoMkh5ZGxGY1M0amFHenU1bkkyWkZBV2xvOGd2eWF1Q2lDRWFK?=
 =?utf-8?B?YVVRWTYwOGZJT1Yrb3ZOYWZGeWNWK0lUZThZSjlFK1RFQWRnR3RCV1NLTjF0?=
 =?utf-8?B?K2VhZTNNMTV3dlpYeWt3dFJyc3h1YVlYNmNRS1BGYnhoYXB2akcvUXlKR3Zy?=
 =?utf-8?B?Q1F3NGdBQ1RiRlVSN2pEQVE5eHBRR2FwK09nNVE3UmNuWHZ3UWV0OHM3eHlv?=
 =?utf-8?B?a2FLdytIckUxZDl6NkZxekFkbWcyZVp2VGtsUkRNRFRuRnpvQmErS1pJbnFJ?=
 =?utf-8?B?WGxnclJUQlhiQWFQdEFJSC80N3M5UmpiRWEzZDRJRFRZQ2RYRGY2OHhOR3NN?=
 =?utf-8?Q?U2ZBG/TnP4NIV3CCu9miANLao?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b95e212-a293-4b94-5e50-08dbab42336c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 23:21:42.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnkXxlEipYVfGbL8Xoj3gCKCzVXyH/gx+JoW456kWVtfgVzU3cg32kvEJfvUz5zXXfirBSweb4Jda1I4kSjf9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Babu,

On 8/21/23 16:30, Babu Moger wrote:
> The default resource group and its files are created during kernel
> init time. Upcoming changes will make some resctrl files optional
> based on a mount parameter. If optional files are to be added to the
> default group based on the mount option, then each new file needs to
> be created separately and call kernfs_activate() again.
> 
> Create all files of the default resource group during resctrl
> mount, destroyed during unmount, to avoid scattering resctrl
> file addition across two separate code flows.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
>   2 files changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index b09e7abd1299..44ad98f8c7af 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>   void __init thread_throttle_mode_init(void);
>   void __init mbm_config_rftype_init(const char *config);
>   void rdt_staged_configs_clear(void);
> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
> +void rdtgroup_destroy_root(void);

These two functions are called only in rdtgroup.c. Why are they exposed 
here?

>   
>   #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 80a4f76bc34b..98f9f880c30b 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2516,10 +2516,14 @@ static int rdt_get_tree(struct fs_context *fc)
>   		goto out;
>   	}
>   
> -	ret = rdt_enable_ctx(ctx);
> +	ret = rdtgroup_setup_root(ctx);
>   	if (ret)
>   		goto out;
>   
> +	ret = rdt_enable_ctx(ctx);
> +	if (ret)
> +		goto out_root;
> +
>   	ret = schemata_list_create();
>   	if (ret) {
>   		schemata_list_destroy();
> @@ -2528,6 +2532,12 @@ static int rdt_get_tree(struct fs_context *fc)
>   
>   	closid_init();
>   
> +	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
> +	if (ret)
> +		goto out_schemata_free;
> +
> +	kernfs_activate(rdtgroup_default.kn);
> +
>   	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>   	if (ret < 0)
>   		goto out_schemata_free;
> @@ -2584,6 +2594,8 @@ static int rdt_get_tree(struct fs_context *fc)
>   	schemata_list_destroy();
>   out_ctx:
>   	rdt_disable_ctx();
> +out_root:
> +	rdtgroup_destroy_root();
>   out:
>   	rdt_last_cmd_clear();
>   	mutex_unlock(&rdtgroup_mutex);
> @@ -2654,7 +2666,6 @@ static int rdt_init_fs_context(struct fs_context *fc)
>   	if (!ctx)
>   		return -ENOMEM;
>   
> -	ctx->kfc.root = rdt_root;
>   	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
>   	fc->fs_private = &ctx->kfc;
>   	fc->ops = &rdt_fs_context_ops;
> @@ -2824,6 +2835,7 @@ static void rdt_kill_sb(struct super_block *sb)
>   	rdt_pseudo_lock_release();
>   	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>   	schemata_list_destroy();
> +	rdtgroup_destroy_root();
>   	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>   	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>   	static_branch_disable_cpuslocked(&rdt_enable_key);
> @@ -3705,10 +3717,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>   	.show_options	= rdtgroup_show_options,
>   };
>   
> -static int __init rdtgroup_setup_root(void)
> +int rdtgroup_setup_root(struct rdt_fs_context *ctx)

Since rdtgroup_setup_root() is called only in this file, need to add 
"static".

>   {
> -	int ret;
> -
>   	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>   				      KERNFS_ROOT_CREATE_DEACTIVATED |
>   				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
> @@ -3716,6 +3726,20 @@ static int __init rdtgroup_setup_root(void)
>   	if (IS_ERR(rdt_root))
>   		return PTR_ERR(rdt_root);
>   
> +	ctx->kfc.root = rdt_root;
> +	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
> +
> +	return 0;
> +}
> +
> +void rdtgroup_destroy_root(void)

Ditto.

> +{
> +	kernfs_destroy_root(rdt_root);
> +	rdtgroup_default.kn = NULL;
> +}
> +
> +static void __init rdtgroup_setup_default(void)
> +{
>   	mutex_lock(&rdtgroup_mutex);
>   
>   	rdtgroup_default.closid = 0;
> @@ -3725,19 +3749,7 @@ static int __init rdtgroup_setup_root(void)
>   
>   	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
>   
> -	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
> -	if (ret) {
> -		kernfs_destroy_root(rdt_root);
> -		goto out;
> -	}
> -
> -	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
> -	kernfs_activate(rdtgroup_default.kn);
> -
> -out:
>   	mutex_unlock(&rdtgroup_mutex);
> -
> -	return ret;
>   }
>   
>   static void domain_destroy_mon_state(struct rdt_domain *d)
> @@ -3859,13 +3871,11 @@ int __init rdtgroup_init(void)
>   	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
>   		     sizeof(last_cmd_status_buf));
>   
> -	ret = rdtgroup_setup_root();
> -	if (ret)
> -		return ret;
> +	rdtgroup_setup_default();
>   
>   	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
>   	if (ret)
> -		goto cleanup_root;
> +		return ret;
>   
>   	ret = register_filesystem(&rdt_fs_type);
>   	if (ret)
> @@ -3898,8 +3908,6 @@ int __init rdtgroup_init(void)
>   
>   cleanup_mountpoint:
>   	sysfs_remove_mount_point(fs_kobj, "resctrl");
> -cleanup_root:
> -	kernfs_destroy_root(rdt_root);
>   
>   	return ret;
>   }
> @@ -3909,5 +3917,4 @@ void __exit rdtgroup_exit(void)
>   	debugfs_remove_recursive(debugfs_resctrl);
>   	unregister_filesystem(&rdt_fs_type);
>   	sysfs_remove_mount_point(fs_kobj, "resctrl");
> -	kernfs_destroy_root(rdt_root);
>   }

Thanks.

-Fenghua
