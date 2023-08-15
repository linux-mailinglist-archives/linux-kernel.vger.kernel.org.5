Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2094277D673
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbjHOWwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbjHOWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:51:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5CA1FF7;
        Tue, 15 Aug 2023 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692139902; x=1723675902;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PROML2zJ3g7Xj0dXaaZpcXFOlDHBxjo+GOF0IF6VS44=;
  b=cZjv3/1QuKTvZeFxtur8wjf4PxUIlSboXsEv8djUQm4Y4kwZdiIpRpQ1
   LnZWco/M9xnsZLRJ6rRG5E419VPCFr1SALmIHe1IjHtA8o2LR7ksrFixE
   2xOyZPchg/nK54Wu1Eyhtcd+zQKAu2iq4gQcsK0v5w2OZmMn87PxuIOFm
   iA9zo+vXLW3uqPQ6FzTCUH6+Zm9KvCkp/GhZB8kUga5MtMCKOQ3p44OLd
   bpIEmVCRBrTMKcBgSPlrcw3bAYHUsvdkRSpkBKQJxzOAuBKM+29zBzsl+
   9FUFNnOD0AKNxtigoK9hGDAtmM23v2fZX6tAIj3OCvNfabPG/Mq2SYjmq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403375068"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="403375068"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 15:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824012936"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="824012936"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2023 15:51:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:51:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:51:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 15:51:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 15:51:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG7Oh9K3fDwr6vRl2Kr0QJF5XA9eXMP20ouWnnYh823qMrMu1IzOmcSm1cdZ259wLxBkkou0dxBeuAH3F5MF4F1jqz/V+E3c/kEq8ndWUFMSGGOd+NbWkObwG9x5hv2Tvv6aapSz6D2sR61ARKbqQ5yBwbuUyjms0HXv4ZCNK53k9zf9jHbW4e+tujZSwqBjvzSQooPdQQbTHK4v3ie59DUNWHIfdbYKXhz8HiSVpUmfPSLhC7+laSsQQX8r7IR5Yd50GHQHqt3eueFBQxlzhUv8Go2mzM/D0MzFU3GP9/weL826/W37TeK8u1A873+xfknxHXC4dbWuAbOSlIJe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yty0uy6wVWtZXwE2rZ06JxJGcI9bf8Br+8RaHMXMCEo=;
 b=DFlDm8aF9ROIKVmFch+PrL5iAZIqJ6F57R5OH94/oipF4lFMxkFL0IVpcEn4Fs65KP4dt/mlO9Ht8T5dEjaxnptQodkKJu23gK3UFAdo43MoAZsu/HDZ/XRWxwPvJJNSfP3gZKGbzl7jKvHeLBjCRLffiFOMT90tqHZBlIzBoR8eDhB7R40ZhCVkRDw9ho/tZiRDrjKi2vIOuBys4h4Qikg1++fvV2L1uBiMXfDyo5eF6QDArUUR4RRNbztRHfc81wta4c3Hgale/1WtNDTR9AltY0GhkI0m8rXNV4JDolnLDfOxqQcqK04PDqkV3xJNq7ptLzZIXWw308Nbwxw0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 22:51:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 22:51:36 +0000
Message-ID: <820a0cb4-423c-ae61-79be-a134be9882bc@intel.com>
Date:   Tue, 15 Aug 2023 15:51:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 7/8] x86/resctrl: Introduce "-o debug" mount option
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178464934.1147205.6915303244307989200.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <169178464934.1147205.6915303244307989200.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: a321a874-0e7b-4cbe-ab93-08db9de22e22
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1vBdcrvGuewhc0YCqxPTJcAEqD5hfORDjm0GBKPxBuAcoMBppZoStq+s3ZA8sThb6KetM0JVzaUZZoBd6M5QiFln66C1srChmWWyxcrPTwCr7pWu8Ji8Dep7MY47h/o9hTPQgYykBEBr1CS8sLefOWdKU6Oopy+jc0ACApEe3Oeip1JFKvSdmyIOLm/5bJMuoyks08i5IoXYQfDgQ8Wv2TTYnY+jmMP7VsKx5Z/nammHcT9gT59n4kt4RgHqSu39r5dP5sAVmw71q2tCqq3+M9bx8nQWUVcFYwdEAWCAwcnAKg7RVd3g/Y9t3wiW3WBxk8i8vxLfnT5I3tvoRKY6wVx3TcFr6D9o8BOJNY4HqWbQxW0/b6l9z78QWudjuY0/oERn845tjdOwp0yXzBSYZdeeE92ext/TT2QO5L8ZCHAvinlYl/Bxer79UdQ7AHs7LGb6de3Hwv0+ejcNG9V5FR9I7eWgJsOWLG4EJjB5ChgmBA3R99bOBP9LlLOFUn1t4rvrL3Olcri+gJA/G5mYQjAZGSSyZp/I5/gqioEXPe7ah2HLfun7CryoV8XeHK+ZVceqOZciYcDnZZ6p7hB3x/OulJaLU4QQmtaTfLCsG+kVIWCtXbhjuyt4EMFuaD91UA6s4U6mxP1HnLldd2ogA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(26005)(6486002)(31686004)(6666004)(38100700002)(53546011)(7406005)(6506007)(31696002)(86362001)(36756003)(316002)(66946007)(5660300002)(44832011)(478600001)(82960400001)(8936002)(4326008)(8676002)(83380400001)(7416002)(41300700001)(66476007)(2906002)(66556008)(4744005)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUQ1V01xNG0wTUJ3Y2NGNmJhWjNTUVF0ak1ET3czdXN2TlJ6SzgwUkpQQ281?=
 =?utf-8?B?WXcxNjVVaUZHdFBwKzlQaTFoNHYyUXQwWDFjRXhXcDJXdTQra05zMDVZMjdB?=
 =?utf-8?B?WVQ2NDlnaFY1WlRQc3pCWTl1eEJYOWRwZGNVV3gxbHNwalN4S240ZWRUWE5C?=
 =?utf-8?B?bGxwWnBvWVRibUROREpzNXhUMEx4ZUpSWEZYa2xuYkZaUFErcHRoWGw2Y29C?=
 =?utf-8?B?T1BJV2FiNEdPNjlVV1kyRVBwZ1ZRK25oSUhkeGJ4eFZnMEFrRnkrNzVqYjMz?=
 =?utf-8?B?WDRYdjFLREVIL2lhOHZlaENJWWprQnQwMkg5NmZjSkxMZzkzQ1I0czBaMWdi?=
 =?utf-8?B?NEdqc1pXbHlkK3hNQjNSZ0pQaVNiNi9xbTgzR1NoYWoxNytVMis0MVpzeGZm?=
 =?utf-8?B?QXBJdUJnRlgzejM5R3F5cUQ4OEQxVUtPTjNiSnNDaWU4NnkraGNqa1g5dHN4?=
 =?utf-8?B?QWQwVloxNG5BWXY5TWl4N2dZYXpLRDRrU1J5d0VMUVR4WGN6d3FQN2JqeEJR?=
 =?utf-8?B?OWhFakxSUmQ0eTYrbVhtVFpRZldnTDZvRmJIRkFIY3V4ZGpqc0JQV1ZuTDZU?=
 =?utf-8?B?dWt3eStoSjhuL1FzbE9aenlOMkNrdGRIZVRHSi9McUJXRGVxQkZYLzdjMDZV?=
 =?utf-8?B?UmRRbjJ6Y2ZyUnlVeS80Qml2ZUhhdHNseUE3NndWdURVRTJoZFVFdythY1Vh?=
 =?utf-8?B?MzB2ck94QTg1NEs0cFlCRlVHNWcxMTlOU3hrR0N0SDMrRWl4MzJuc29xb1Az?=
 =?utf-8?B?aHEyMy9Wb1lKcWQ0L3JQVG1ZeG1iWWdIa1o2cnlrQW9sRjcyem94STdldlc5?=
 =?utf-8?B?TTNzQm5PeHZzVlpUNlNnUzJaTWpBY3dXWndPVVJoQmY3VURjd05XaWlnWmt5?=
 =?utf-8?B?aHFCR3RMbmNOeUhuN1RmK0VCUTBaMmpzREJmdzR4aDhkNjBhVHM1SXBxODF6?=
 =?utf-8?B?ejBZZ0pEL3hDVzNaeHJNTjR5aGdRT1hRanhYV1NjWUhJNDBSWWNwODJsdzVO?=
 =?utf-8?B?TkhwYXZpVEdJcDRIdmgxME1wZkZsZHE1WUU0TUlCeEJHNHZmUUNDLzNtM3Fp?=
 =?utf-8?B?NUt3eHNhckhJNHVnN3N1Z21hZktGdGl6ajVGUUdOVFBpTzZkYVhUWk5ldDJx?=
 =?utf-8?B?TDJUUG5udHpaOXR2ZXRKY1JEeVFBOUI3Tnd3aDBrV0d0RDk1b0YvOEljSk00?=
 =?utf-8?B?bTNGYUNOL1hOS09QZE1OYStIK0hnTGRFdkZXeEkwdmp4VjRBQlk5WGY4VTNK?=
 =?utf-8?B?aDhKUGhEWWNHcXdsNXREZmFsYmFaU3FTWVlxQ2FDdG52TW1lRDg0TC9Ka2Nn?=
 =?utf-8?B?QWZweklLeStlbHhYOUduZTkwRVZwbi9lcEV2Tm54bTE3KzNHSHJ5TUd5SGxN?=
 =?utf-8?B?ZVZVWXVwMEhpamY0VlFEckFsSWRSM0VsY2xPTmQwSXhhTVRISEo4UUVxcEVu?=
 =?utf-8?B?cDFDRXhLdlJSOEwwVDM0R1dFSzFlUU5ITlVwem1YV1diV3cyL1hEeXJOM0sy?=
 =?utf-8?B?aElJQ3hmSEwzS210alUzZ1kxVmNlVGl5d1BlVU5RbnBJS0Q4YkRHTU5RUGNy?=
 =?utf-8?B?dk42aEpJU2RwOGIyVXJLTXVTK3VveDZ1SXJTNm9rcnF6ZGt0dXJqK25id3hB?=
 =?utf-8?B?N2lMMXo4OVV5dnRSYXdWOGwybGJJeHUzeWlMZzgxM2NjK0daZ3k1aFQwY29F?=
 =?utf-8?B?S1Yza29JYTZIRDNOTVloK3c3ckdaUXlMbnEwUlpvSUkrdHRlT0ZaTnRFREhi?=
 =?utf-8?B?RzlXS1VObHhLaHpxOUF5R1BiaS9qMTFYZ3pIaFN3SkN1VjlieUY1ZU5rbWpu?=
 =?utf-8?B?NmdNSG5DUDRSdEliU2QyY1NzaHY1c0xzbzVOUk1RTWJqY2RMaWhsTms2OUpD?=
 =?utf-8?B?Ync1bzFVUXMzSStSTzUvQjRTU0szMXhNbmFCWUxscmZMRUpmazA2V2xUR3lZ?=
 =?utf-8?B?Z1RRTC9rbkJKWlc3VTJVeGFraFpoT2NrMXRtQzNUZ2FVWHU3Z29zUlh1ZlAr?=
 =?utf-8?B?SDlHQ2FOS2xTc213dHVlOG0yVk9NOXpIQzFURTFTRlhqMEg3M2ZoTVhxa3cv?=
 =?utf-8?B?VGt0WWVucjFrcEViaEROT3hPd0RCeWI5aVJpUlFhYmIyWXduQnpTcVRuRlkv?=
 =?utf-8?B?MjNVcXhsOEI5NTVDUmorN0RsZGNtQlBZdjV4WkUyMmJxZE54RldFYnBSRVJp?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a321a874-0e7b-4cbe-ab93-08db9de22e22
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 22:51:36.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMK9sjDSqU10YsatPE9UuIE72PXvY0hg6kt/Ow5uvokJFkK5UCElN7oW21LUzcvxK6g5OA83sGmTfgsdFPUwVC/uWKu6dbUg8QopPx3JE4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/11/2023 1:10 PM, Babu Moger wrote:

...

> @@ -2833,6 +2849,8 @@ static void rdt_kill_sb(struct super_block *sb)
>  
>  	set_mba_sc(false);
>  
> +	resctrl_debug = false;
> +
>  	/*Put everything back to default values. */
>  	for_each_alloc_capable_rdt_resource(r)
>  		reset_all_ctrls(r);

This should not be necessary as rdt_disable_ctx() should already
be called here.

> @@ -3713,6 +3731,9 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>  	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
>  		seq_puts(seq, ",mba_MBps");
>  
> +	if (resctrl_debug)
> +		seq_puts(seq, ",debug");
> +
>  	return 0;
>  }
>  
> 
> 

Reinette
