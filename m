Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC83758635
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGRUnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGRUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:42:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21D6BD;
        Tue, 18 Jul 2023 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689712974; x=1721248974;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fA2EGfixGd5/l8/JAjqmHGYKFE6rMo/SPSiuMaNJi4o=;
  b=K+W5aA3vgWXN7sLaF9SMkmLPnCyJT1ymNbNeV4b5vWuEV4hHbjQprWVC
   4IKQtTiJi14UazZuSUg78644kXy42rWLxD1cmaXcfIR5af8Ag0JCYWvxX
   uFVWyTtNhoyvi+a7i9Rrwgxe91q1lOtw+0H57MdHHi1tqDr1JCG+xoFwz
   QPL6Jxykub90x3o+CeA2IpoXlobiZiDqDdWJmiAviNZaEuFjCGIrDh7Pw
   wP6ULUYGluCF2ga1NSv8Zd0MXyF3kPD8gRoGzX/c1lUJlQiBjMH+FNyKd
   GD2qkGjAQed/tq3LV1DTjadpUHBR0nhjsS1zan34dSgXDtLgKX8O4JuY4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="368954873"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="368954873"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 13:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="789199563"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="789199563"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2023 13:42:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 13:42:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 13:42:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 13:42:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkpBKiqeib+pZ/AGb6Kr+B0av69JaNYntz2KOyPjHRnFGFbkXdb00m2FSVwm7K2qGiqUsj4ga/4Xp5NnjpIESFWzMXmZD/2IrzMVGqigbMkciuXlSTQjSDdzKpHkxazO+h+vh3WWrGm4M1IPlAGO09NMnIdZTWB+peLhAarOG/l8NBC3tC4e0Dmy4Vce8/2zN75H+Wcj22fJT3G518JsFjyVoECIBis6ObQdGO3c0LN5wc9owL86kSr1ONGvM/Lb0V3CYaEdsdPbKmD246/tREEoFBiNzMVLiTWIi4QGMpuKBzqfccB3IM5K9GezvdOiYt+7IvJPqB7MICTT3m+Fkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXbSwcwNPv9eb9EhE7bSUlgvQHf0ujk0SQG+D+gFWf8=;
 b=QcVrC1oU5QNVomcn0sR3GJdc/eZlLA6UnrhWZBjhVSLxBf1yE/DKzDL+l/ruUqTJxgJ0RuhuKIlXWmjnpNiShDGOxf8I0gRcAruG8x9Bd6114iGVwhSvE9tmCL+TIzkQspcrjJKVsp4OERxGbkYboympkL27VuaFdohMPW2+x72njMhr4epWkvkXYV95Ywrisi+fYcNy0EmvDTCUnzS+xrhMhqLKWRTAInzCwSObv3bZPBEPpIszeoWAOkU7IqVNOui0hqg3X+HSRz4uWXbRSlsUw5cV9S/BnNhQHzsGVolxbA2h7v5ovNK7JKubIZg/cwQo9NLn/wvDbuHwo4bVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7890.namprd11.prod.outlook.com (2603:10b6:208:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Tue, 18 Jul
 2023 20:42:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 20:42:23 +0000
Message-ID: <a907fe31-3877-c4f0-7acf-785c28fd2e1f@intel.com>
Date:   Tue, 18 Jul 2023 13:42:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/8] x86/resctrl: Add code to setup monitoring at L3 or
 NODE scope.
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
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-5-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713163207.219710-5-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D04.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:c) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 622fd83c-9ec5-461c-376e-08db87cf7d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h755MtHp4/1Ap4RpGaqJExieKq75zRnBq7/dCh02zcAHJU3hYrpD1KYWXF+8pmdAqXUPM5LwvJyBHhDJsVSdDnqR5guJY0tLd9ZVZrUWq3oA6QxWi+VVtpD/4n5Vhwi8Pr8WBzhQHmKIeG4yf9cDGqn8o9m1PXUVm7CT1vUNlMr3ZX0Bpx/XAKz7gAR8pQZQl2ResSoeJpbxHoMwqgBLTItjY9Nn5vSoolIgDMsbamThKJz3lmIu2a20ib7Rb6wOzfgcjO9hg20JaaPLfK6ORXuJ7FJZaPdhfadIEnxG0ZfT9CTrP0X3+QUJ/9mhXdx1Ooatx+5qsdbdl4iChuGCBfUqlgwiESdf8TV/dVWI2AwcgPdiqN5YtyqozLTo6k5FhlExlxjLWNRtDtZzCQRmLYJshgfxKcfQ/tzpVElbXXu5YRKlM8HMuY4H5KyFmh5FxPTpqa6puyS/heHvxdmNCrAVKadj6YH52HR5tI9afMlij5X3oEhqbQBNTRykqLpY4eiHqJU4JNrv75XOpsNeO2qi5wjVRIWbHDHViTQs697koAPvubgPSEB867xkxa3E3ftMhd8DUzcK3OHrsrv3I/bf5Svf9jI6SveBJ0cau2+8LqEsNTFPobw16DJ98H6gbbVFpius3O5jnRDhyI0X+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(2906002)(44832011)(7416002)(83380400001)(5660300002)(6512007)(26005)(2616005)(6486002)(186003)(53546011)(6506007)(36756003)(82960400001)(110136005)(38100700002)(86362001)(8936002)(8676002)(31696002)(478600001)(54906003)(316002)(66556008)(66946007)(4326008)(31686004)(41300700001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3ZYYmhiSzRVTVNTRFUvNzF6Qy9LQ2hGQVN3ZHplVnU1SXdQOEVDY0lLcEwv?=
 =?utf-8?B?T3hmTm4xV2tGc0I3cFpibERnanFraXFGZXhQWURMU0xnd1pwZktrNURmcGdo?=
 =?utf-8?B?cEdVMWRsaHJWaWdSV3I1VEtxcjZEZ0FKSklsbnh6WllXTldVVGt3a2FNMWhh?=
 =?utf-8?B?WHFFSzJBdzcrNXJzTVlKUzMyNnZhWE5EMC9OcWVvcjZHZGxFSXJxSG1GeXN4?=
 =?utf-8?B?S0dZZ1dpeXIvaEE3bytmMk5RNkFsR2liNEhHSWJMSE8rQ0xhRXY0NWUrS2VO?=
 =?utf-8?B?TzFIcUxKWHRRS3lhM2N3Q2M5dkRRUmdpaUwxU2xBVzdwTUsraGFEbGZ3dFU0?=
 =?utf-8?B?dXB6TkRCYzZ2UnlaamdNbTVzNXVKWDNuVW5mRERzYzNveHZPQ093K0ZVVVZV?=
 =?utf-8?B?REt1azlUd2p3Y1hkZldYaEdtWTVOSTg2Wk5QN1JhZXNuajdPRXovQjhheTdG?=
 =?utf-8?B?d3VLTnlyOHE0OGpIaFEzeDdJQ0FwUkpkWXlTOUs5ZjJVVUR0aXdKa2NXWVlI?=
 =?utf-8?B?d1d2MDlsNjdoQWswcU1BeUh6dHdwenZQOVJiR2pKOTZVRDBiTzBLV205ME1v?=
 =?utf-8?B?VldKaXVUSDJGdmpZOHJpK2RuaXlIcXpCSmh0TEhkdXh6WnBIWEhYdGgycHZn?=
 =?utf-8?B?eVRJZzVWbGpWVW14d2doTnFUZ2I3eEMxWW1nM2M2YjR2U2swV1M3eUtoQ2s4?=
 =?utf-8?B?di9uRTAyUmNnVjBRZDBGM2dLdnFzQ3ZTbFlzSitRVmo5OUNTcEs0d3pVem9j?=
 =?utf-8?B?eU9jZmdNUFdHNnUxRERpL2g1aGZrUTZDRlVHTmIyRHg2WkF1SlpsbFhDOERK?=
 =?utf-8?B?bGlVUnVPek4wWjVaUWFRVjRKSkhzUkt3b215VEx6YVdVMDBmRC9oS0tJLzVK?=
 =?utf-8?B?WlVkcGg4L3ZhZE5HZVJpTTlWaEErNFRaVEMvSVh6akJhVEIyN0Q3YVpmN1p2?=
 =?utf-8?B?Y3NUM1VUVkhueHJsNTI1SXNUWUVyUFkweHBvbk4rcHUwcGtrWjhwRVZwUzh3?=
 =?utf-8?B?NlRtRkxLN0lYL011Q1hmbFBDRkljR3g0aTNDeEdPU3hFSGJpL1BsVzJvWngv?=
 =?utf-8?B?ZFh4MFBNM3d1SXdHY3BPNmJTMjg4U3gwUFB0Uk5lY0ppS1BGNkN5UStvSEpO?=
 =?utf-8?B?KzJuNXEwZVVwaGl3dG1lbmFHbWJZSTRiTGd0T3hIRWVWUzgveEZ1MC8wcDQy?=
 =?utf-8?B?T3hKSkp1STVFc3Q2VE9VeVpvT1FTZ3UxY21nMDZSM0paYVBMaW1IVTR2WUc4?=
 =?utf-8?B?R21JejNzOHVSUCsveUNGTHVxSXNITXd0VnY2MG9RWWx1eWxMWmJxNzBpOWNP?=
 =?utf-8?B?VHI1UzBMNUwwSWtUNjdsUGRWMGNnV0JWcFFCcDVidmRvWjdZdFRRUW4wZTND?=
 =?utf-8?B?NE1DbFNaVk1QUy8rR2ZuS0grd21kUGUrWGlLUWU3QUZqZjQ5SDNCZmRlS3VL?=
 =?utf-8?B?RXFWNEVHY21hQ3RkTXFZY2pNcm5QQzVOem5zcGZybXM2N3dUTXQvRTMwLzgv?=
 =?utf-8?B?Snl6L0RqaXQ4SjJzNUNQNHgvRGo4UUN3MmpsTk5aYnU5WFVWQUcrUmIrMHJF?=
 =?utf-8?B?QkpaRlNUYU1IYnh2NFNMVU1BY0xLeFN4SGd1dmhHLzhQaDdZbDBNU1lZV21a?=
 =?utf-8?B?eUVHOFRiN0FOZjlQSGdIRmIrQVd0eHdKNnBOemgrcytwSkpIOTloMytUbHFI?=
 =?utf-8?B?R2ZENmk3NWtPcnlpbE04NzlqRVFCb0R1b2VUSGRWUXpJTzBuK0dKclV4dEg0?=
 =?utf-8?B?WTRjMzA3OElhUjJPZExTaDBncW16RjNua0dwcGlnUUliaCtKSGNLdDhCL3ZK?=
 =?utf-8?B?aUY1UnR6SVg4bHE3OUEra3pQUXdQUGhGR003aEw1SEZNdjM4M0lFRkdWa3Ju?=
 =?utf-8?B?UjZTWmJYa3RhYW83VnVLbm9FSnhyWVFsU1NQZ3QvNm1DSmhINSszb2ViUXlV?=
 =?utf-8?B?aFMyWi81UzZPQVdHN1JBVE1pazdDeXhHVmlVeFg2QXJCS0UrS051alFOcGVX?=
 =?utf-8?B?TVM4cUMvYS9EMUloRE4rQ3RGQUNDL3VqdHlkRUVKT3FXazRKbUlEWTNuK1Fo?=
 =?utf-8?B?eUQ4ak5ZYml5MThnZmRxK0V1SjM5RmJoY0RsUWRWaVVueFl4cjlmck05VWJl?=
 =?utf-8?B?cDRuMGN3bERqS3FETUxDdGdJenl1MUl2T1BsNUxPQ0RpTlY1RE1RbXh5bHls?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 622fd83c-9ec5-461c-376e-08db87cf7d26
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 20:42:23.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 926ACVRdl1k4WZTrsaMpT8J7/nRh3jUyMFcQRLpnwQj0kQkTBNJFnNthldNCGQo/SG0JMx6b0/DRevj2AMf8OnXkrcEmLdvnYaymdDGW+LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7890
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Regarding subject: "Add code" is not necessary.

On 7/13/2023 9:32 AM, Tony Luck wrote:
> When Sub-NUMA cluster is enabled (snc_ways > 1) use the RDT_RESOURCE_NODE
> instead of RDT_RESOURCE_L3 for all monitoring operations.

This duplication of resource does not look right to me.
RDT_RESOURCE_NODE now contains the monitoring data for RDT_RESOURCE_L3
with related structures within RDT_RESOURCE_L3 going unused.

> 
> The mon_scale and num_rmid values from CPUID(0xf,0x1),(EBX,ECX) must be
> scaled down by the number of Sub-NUMA Clusters.
> 
> A subsequent change will detect sub-NUMA cluster mode and set
> "snc_ways". For now set to one (meaning each L3 cache spans one
> node).
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 7 +++++++
>  arch/x86/kernel/cpu/resctrl/core.c     | 7 ++++++-
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 4 ++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
>  4 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 243017096ddf..38bac0062c82 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -430,6 +430,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  
>  extern struct dentry *debugfs_resctrl;
>  
> +extern int snc_ways;
> +
>  enum resctrl_res_level {
>  	RDT_RESOURCE_L3,
>  	RDT_RESOURCE_L2,
> @@ -447,6 +449,11 @@ enum resctrl_scope {
>  	SCOPE_NODE,
>  };
>  
> +static inline int get_mbm_res_level(void)
> +{
> +	return snc_ways > 1 ? RDT_RESOURCE_NODE : RDT_RESOURCE_L3;
> +}

Need to return the enum here? It may be simpler for this helper to
just return a pointer to the resource. (Although the need for a
separate resource is still not clear to me.)

> +
>  static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index e4bd3072927c..6fe9f87d4403 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -48,6 +48,11 @@ int max_name_width, max_data_width;
>   */
>  bool rdt_alloc_capable;
>  
> +/*
> + * How many Sub-Numa Cluster nodes share a single L3 cache
> + */
> +int snc_ways = 1;
> +

Since snc_ways is always used I think the comment should provide
more detail on the possible values it may have. For example, to
a reader it may not be obvious what the value of snc_ways should be
if SNC is disabled. Also, what does "ways" refer to? (Also mentioned
later).

>  static void
>  mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
>  		struct rdt_resource *r);
> @@ -831,7 +836,7 @@ static __init bool get_rdt_alloc_resources(void)
>  
>  static __init bool get_rdt_mon_resources(void)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *r = &rdt_resources_all[get_mbm_res_level()].r_resctrl;
>  
>  	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
>  		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 9be6ffdd01ae..da3f36212898 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -787,8 +787,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	int ret;
>  
>  	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
> -	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
> -	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
> +	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_ways;
> +	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_ways;
>  	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
>  
>  	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 418658f0a9ad..d037f3da9e55 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2524,7 +2524,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  		static_branch_enable_cpuslocked(&rdt_enable_key);
>  
>  	if (is_mbm_enabled()) {
> -		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +		r = &rdt_resources_all[get_mbm_res_level()].r_resctrl;
>  		list_for_each_entry(dom, &r->domains, list)
>  			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
>  	}

This final hunk makes me wonder why the monitor.c:
mon_resource is necessary at all. A single helper used everywhere
may be simpler.

Reinette
