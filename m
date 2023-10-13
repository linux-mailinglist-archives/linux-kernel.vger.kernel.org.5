Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0E7C8EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJMVYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJMVYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:24:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D6395;
        Fri, 13 Oct 2023 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697232249; x=1728768249;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P17F4pYCMkBoNQypAkky65TanqUPLsZR88XubikQiKQ=;
  b=hoGK7dPsKBi1JYgOTpRQNbJwhtVwSMRBA0LSjpRfeU9RlTAyxRh1/L3u
   nBvvtYeLWlpaENZ8FX5qSC3anK5I/BTgTwLLMzBP3itpx6+3jZ6euBIJe
   H5jlV4wkAVGE4C79bRFI7qIWnMhSMfu5siafQ7U7E/Gl9iA6isAhoAlQL
   1pIEEZvwmb1BAC3tf/mm8k+hfkkz0O1G1f22if+eFapDvx4h9v/e5G/M8
   8MJOlRW/y51BD74a1uI1/ST12LaMbGGBMQieMQwxg0OIuxAWCiOflSVmm
   8zJBoGuyBy9iZvtHNm9LJTg+/Vw1YfbS6aubjVvJYV+wYUAwxd6Sf5C//
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="364632743"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="364632743"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 14:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="1002109929"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="1002109929"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 14:24:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 14:24:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 14:24:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 14:24:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtUopHpUikfdiA5A3IR3yewwso5g4dIhQdd7flzP/OCPb5ZMP0CIDHuNehp0HvXxjgtc08AQxRelxlejMIwTvs8lNOAsTGuziEl5R8QshDa88s58hYncDYrvoJ7B+Rixhz2W/c8ixJUbKzHBoRfpmpb0gN1yCyWKoKPi6JbReNJ7+5A7juw5PihgoqZ39PKpG5umzzqL/7scdNmfvqkEIk3ZCVE2ExRoOIeeKNZE+/oRlMExYhDELLfwEAtfTMFaZiJRu50NdtCAIcR/LRttwXGPiv249bf0HQFUlQyDtfChfxCOGd1jxfOhzqbKYqxCDqbQZGP4bq0csFBC5ZEoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH3hmjIcjgaVxgVQNsZ0u+xINMxRqxBRImJtxDe7HlU=;
 b=hkwj7fw15CQuTZzmhEU/vwqRgDPgK221+EmK5db5uZgXaUCo7DVBPBY+HTlxDiv6UiBEiKDB5M2AobjZwi8EHpsb8YHVM3mATjKCA5Atuw0aPKZ9QON4p8RHr3DTKjk9eWAiEqXV+R/D68Ob0vfCx8gB90dCstZW0NxFzbVsG42fCxzsR6HG5OUhzdsNsvNOszZ1KtRgUDhKOnaIsEs8B13gsMTfJgabu4PgkBd14vOMweXO86Z9cM0CxcUXPlBYlbPql6gOdrJqSL58wz2soGJP23Bd43f/ATaX7mc/E3k65ZoHHAdkq0aQQZljt0fpE1Fd4+XgtwMlgZYcCPtzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 21:24:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 21:24:00 +0000
Message-ID: <d4a33013-0448-4c36-a168-b3a953024962@intel.com>
Date:   Fri, 13 Oct 2023 14:23:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
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
References: <20231013202602.2492645-1-babu.moger@amd.com>
 <20231013202602.2492645-5-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231013202602.2492645-5-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:303:2a::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7ba867-73b8-4073-7242-08dbcc32b776
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5DfYRVFP4I+3Lqc2FRyZowKVnIzDfAbLnbEqCUYJ+nMrGJaRAA6t1zGdNij0TSD5onCjQzI2ByujCR3F4m/F50P0CbxPS1nJ5HWCYRce8fAtzYVQa4YcRpLExSO8fxujsIqMTnNJn0C4j6mNm2y/Jo+Gx70V3f9q1ggJWvP0tQqJjnNMQYwcvzo0xIUhEeMkM18v6UU+oFh2U8Sw6fomMQHJJmfCshvxe1hRj3QhlzL4HRt9nD5rXyOGW37ItMmIVfnWt7CXbR4evE+yXeghMclXWJr+5Ydy+7i9NxA/WEMDW2XvzYHw5aBXnbkyrmOvuQK/egojocfjIldXuGzOfLfdXyjQpq83hhJTlUhW8AG0KVEj0X3VoKIMIatudN3R4/Pl1MZa2PDa0VMQQIUOl2gwtq4QdLXiJ4JSsFkLCRAOhIL9mJQ2lqX1kftWWm75IMjzHy0g0PdbJufe9K3+2nKav92SWfYONudh9SIUQb8JnFImp6z19svvgszxrW4Z+SLnw7E99jNyu6/hIQtYjooaAAEKurgkBGnfgcC/nymcRVD0cziZPX5GWAKlifytoUW4PWbE1/+RzFKwGBE0AetMijtaK9QCK/sK6c/Lf65cB5ec4h3u3Vqg9d5LNj2g90/YYUam8iI+hZQY2NIDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31696002)(2906002)(7406005)(38100700002)(5660300002)(8936002)(4326008)(7416002)(8676002)(41300700001)(44832011)(36756003)(82960400001)(86362001)(83380400001)(6512007)(478600001)(53546011)(6486002)(6666004)(6506007)(2616005)(31686004)(66476007)(66946007)(66556008)(316002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUl1WWQxRm1vVVRhRi9nKy94dmZmd0dYSkdOQlIveWxWYmJkWHpzSXhoY0NV?=
 =?utf-8?B?Yy96WjgvRmE1K2dsbXdMdHV6Y0hEbU9iZVdQODdkZ1h4L2Z6QUFURk5tVE9W?=
 =?utf-8?B?N1A5dXNsV2hDUitWY0xOZDUzZUxNT2Y1ZnYrOGVDNENER2psZW1zMG9HZktZ?=
 =?utf-8?B?Zzk0NkJUcXZLZXcyZzJvRW9rdk5uOFdQVUh3NHp2OUxpQjdLeUt1bU00alh2?=
 =?utf-8?B?dWVLUW9QQjkzR2tibWdmT0tycGhWUmxJOThod1FGdGxHK3Q5MWtxcGxSbTA1?=
 =?utf-8?B?OVF2dkVlN2d6cXhIcFgzWGIxa1JERWlUWHNlV3NIdmg2S0MvOW9LVEtqYlFx?=
 =?utf-8?B?WGpnQjdKbzFGWWZnK04wM1hRTk95SnFpQU1UM3lxUHVKOUt2Z2lCWWRLQXlX?=
 =?utf-8?B?SVJXWEcvS1J2SFBlRmxKQVUzWTZWNHR0THhQRm9wSXFIdTdzNDBkelp0eXVm?=
 =?utf-8?B?RDc1cEIxbFE3SEVwWGdjVXJndjN1ZXJaZFJiQnpsYkc2SUtzNS9vek1XU3NG?=
 =?utf-8?B?c09VRHZMOHBuWi9nR3dvcGxnNWdXcDBaWldZWkxKc29vbkZNd2s1dDNzOGdm?=
 =?utf-8?B?RDVrbThzTGN5UnlQTXNGdzM5czdTSFcxcHVRanh6M3hRbjNFaFRtS0ljeWh0?=
 =?utf-8?B?WWVqWmY2RmorVndVeXgwcWgwajA2VC9ZNlRnTXFMRlU4N01XSWdQVUFtRDls?=
 =?utf-8?B?ZkNoYW5tOWxwMVQ4eVVFQnhybW1lS3dDZEttcU5TTWh2aW5rY0pxRjJ4SVor?=
 =?utf-8?B?RnBlZkFtN1d1ajVEZVRQa2FtQjhVeW1CcndBcE9zVitldmJZaE5Pcmpsa3hU?=
 =?utf-8?B?YnRWMVJjdTN3ZlFDMDZEbitua3BVbWpEa3ErY0VLcXFndFlXSGpYTXcwMHNy?=
 =?utf-8?B?V3BkU0RNMWtJQmtJWUhyWDdZZjJqQjR4eDlHeUQzOWoycjJQNnk2c3hTcG1H?=
 =?utf-8?B?VkZvb3NON3ZROWVRRVFUZVlkUi93MzNxRVI4MU80SzBTZ3p6dHlLTGs2bm9z?=
 =?utf-8?B?VFZ1UExtN1dPSjhUb3dGUmNQdTZlOG5YNmN1blFzOS9SM3pwV2dpK2VGV1pm?=
 =?utf-8?B?Qzc3NjRlb09mZXNYT2xzbzRIK0hMS1R1ckdzeUk0YkpabVVIR0o0dlhVd1A5?=
 =?utf-8?B?NHE0NUU2UnFrajhNL0RmZnlseHRFZnVkU0c0NktydzA1ZzJYLzdLOFNGMWFG?=
 =?utf-8?B?bytkcUQxMHROZFZjcFYwV29LVXBpNDlkSFRNNGQ5aTdkQVNDR05UaWwxQmMw?=
 =?utf-8?B?YklwWlNXL0RzdzNuZjZNTThiSFlZRjc4SkI4aEJDN2x1d3BHQlBRby9uazFl?=
 =?utf-8?B?Uy9EWUxhVVN5SmxqNlZTbGRSdVMxd2NOaTJ4ckZGc1VUS0pPVFVZZU94K245?=
 =?utf-8?B?V05keW03SGt0TTh3RWkvbGI5UHF3VlVHbHlCeHl2U1JrdXlwNG5PTkM5a2Uv?=
 =?utf-8?B?VjdGYk5xU3h2Sjhzc1RsQ3cxWDJ0VGxZV25qY1VYYkFYWE5TWHptV2RRbTRy?=
 =?utf-8?B?eGxpUlJ6RVptY0Y5cWhtSkZvMktGbWcyNERQSUtOa0FBVWRCU2puZmtTQXJ0?=
 =?utf-8?B?K2ROVjV5U1ZhMENha1VySW5CZ3NGbWF5M3drckRJcFpQZHRER2MxN01Hdnpn?=
 =?utf-8?B?ekQ5UHlzcmNZRDNqWnRnVUQrVnQ0aVQvZDAzV1VCSDZJV1pCOGp6VUdLWmtt?=
 =?utf-8?B?djF5em9VRFNNSVBzVW9VZS9tL1hSeTdPbXFGVHc1OUdXK0s5TjN2VE9teXVs?=
 =?utf-8?B?YTVHZEZRakdiTGtMd01uWWVVTldpb0h4WW1lS1paSmZlOWZ2U25JNm5NKzN6?=
 =?utf-8?B?UlJ6bldsQ2VFeUpqdTFobkdodCtOZDJYeDhtWHNHa1cvYXgzWWJKZjJXTWNq?=
 =?utf-8?B?MG1jYTNhTEFSSm9ndHpOS0IxTFRid2szcGhuYnY3TU51TGZ1MWpkSmdWQU1X?=
 =?utf-8?B?aHY3MTh2RUlwbHl4MEhRb2RtdzBCWVMreHUwUXJJd0VPVndqUmtPLythZHc5?=
 =?utf-8?B?RU1INURzT0FTa2pVQ3RGdzdtUFJiTnFBSEFHWUM1UDg1ek5iNmtiai8ydG9D?=
 =?utf-8?B?NjV0blhxdWIrT2lsMUs3akRqVDRSS095ZElDOVFhWU5BVEpDNkF1WDRuRktY?=
 =?utf-8?B?WEdPYi95NU52YTFRUG9vWDI4V09mODgvOVRlVDljbk0wNk5GVnFGUnJHQkYw?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7ba867-73b8-4073-7242-08dbcc32b776
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 21:24:00.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oLvGIpFkbJ0GYhcSkQYHXs5Hif0gX67ZnGeNghFPfpmgd6jVud9GGjZCMRO4Z3q7tSiatV+2K3Mp2Almdy8knzUTlWpz1kCC5e6Fa77A9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/13/2023 1:25 PM, Babu Moger wrote:
> resctrl uses RFTYPE flags for creating resctrl directory structure.
> 
> Definitions and directory structures are not documented. Add
> comments to improve the readability and help future additions.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v13: Fixed the format issues in the documentation. Needed few minor format
>      changes to address the syntax issues.(Reinette)
>      Removed "Reviewed-by and Tested-by" flags as the patch has changed.
> 
> v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
>      to Documentation/arch/x86/resctrl.rst. (Boris)
> ---
>  Documentation/arch/x86/resctrl.rst | 64 ++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 178ab1d8f747..1163da74f734 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -369,6 +369,70 @@ When monitoring is enabled all MON groups will also contain:
>  	the sum for all tasks in the CTRL_MON group and all tasks in
>  	MON groups. Please see example section for more details on usage.
>  
> +RESCTRL filesystem implementation notes
> +=======================================
> +RESCTRL filesystem has two main components
> +	a. info
> +	b. base
> +
> +	/sys/fs/resctrl/
> +	|
> +	-> info
> +	|
> +	|  (Top level directory named "info". Contains files that
> +	|   provide details on control and monitoring resources")
> +	|
> +	-> base
> +

Could you please do a "make htmldocs" and then ensure that the output looks sane?
The resulting output does not look right to me. For example, the above turns into
a single line that looks like:

/sys/fs/resctrl/ | -> info | | (Top level directory named "info". Contains files that | provide details on control and monitoring resources") | -> base


The spacing also looks off when viewing this in html.

> +	   (Root directory associated with default resource group as
> +	    well as directories created by user for MON and CTRL groups.
> +	    Contains files to interact with MON and CTRL groups)
> +
> +	Note: resctrl uses flags for files, not for directories.
> +	      Directories are created based on the resource type. Added
> +	      directories below for better understanding. The RFTYPE flags
> +	      are defined in arch/x86/kernel/cpu/resctrl/internal.h.
> +
> +	info directory structure
> +

You removed the separator in order to pass the syntax issue but now there is
no indication that this is a heading and the content becomes harder to understand.

> +	-> RFTYPE_INFO
> +	   Directory: info
> +
> +	-> RFTYPE_TOP (Files in top level of info directory)
> +	   File: last_cmd_status
> +
> +	-> RFTYPE_MON (Files for all monitoring resources)
> +	   Directory: L3_MON
> +	       Files: mon_features, num_rmids
> +
> +		-> RFTYPE_RES_CACHE (Files for cache monitoring resources)
> +		   Directory: L3_MON
> +		       Files: max_threshold_occupancy,
> +		              mbm_total_bytes_config,
> +		              mbm_local_bytes_config
> +
> +	-> RFTYPE_CTRL (Files for all control resources)
> +	   Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, L3CODE, L3DATA
> +	          File: num_closids
> +
> +		-> RFTYPE_RES_CACHE (Files for cache control resources)
> +		   Directories: L2, L3, L2CODE, L2DATA, L3CODE, L3DATA
> +		         Files: bit_usage, cbm_mask, min_cbm_bits,
> +		                 shareable_bits
> +
> +		-> RFTYPE_RES_MB (Files for memory control resources)
> +		   Directories: MB, SMBA
> +		         Files: bandwidth_gran, delay_linear,
> +		                 min_bandwidth, thread_throttle_mode
> +
> +	base directory structure
> +

Same here.

> +	-> RFTYPE_BASE (Files common for both MON and CTRL groups)
> +	   Files: cpus, cpus_list, tasks
> +
> +		-> RFTYPE_CTRL (Files for CTRL group)
> +		   Files: mode, schemata, size
> +
>  Resource allocation rules
>  -------------------------
>  

Reinette
