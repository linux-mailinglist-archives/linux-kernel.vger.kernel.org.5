Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29AF79C2BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjILC0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbjILC03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:26:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF389BFFD4;
        Mon, 11 Sep 2023 15:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694473178; x=1726009178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lq1BW5DL35DTTS6GcEfL8I2UFKPRpB7RMThI5EO5ePg=;
  b=joGGOYzuUBm5qw44YbfE+baSA/0MH2SO7uOlkAf9s47GKARePgjm9AqJ
   GLXp3cH+g81lMwQi7Yf4ubqAJ1wRN6ZGTXd7iZNbIWz7WKAQbJXubVQMN
   yNMhINUPa25eugiRUKbuNlA8FFvZimUmk5sd8GxvMWkKLLIWlz4exH+8c
   BatVbgUZsvP5dOQwLrkgGU9Wzk4PRfheGhckfBFcmo4G1rHx/brkkxN12
   +2Xt9KTs7oem35kT/3zWOMHXPj8jdH9DKxGoh3C4M+qCIWfha2vaJUuDA
   YKAuGQgFf/KLXeL0mctBQ6VhMAvSMtmMnbAqPY1yxATHkuM5tR0azt75D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="368481821"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="368481821"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 15:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990275434"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990275434"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 15:58:15 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 15:58:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 15:58:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 15:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyCUeJB3fagK6BjocVhbaF5ujL+gC9A/dxc0LtJooUGX1yf4QH5MBrWLCmclA4wFVzDL+/Zma7Y/bo+hEdLpRQrq51ITvUrrQ0767XTSC3YjICl0K4PXQmvu6JOY2N7121zni82SxTqL7sy7DTng5/NdQGUfcnLnAtCMmIssnaMBsppmnCjT+p+S4LmKwvacQI6As14UpQFaaoHG7TtyICf5T7DEUpPWvGVirieGfWLLq17VMkfQIQ27GxbNT5JbQTDnoOsr0RY9ur7ym02c7q1HCuhGbUi2CxXIKn12m9ufgKue2SzjggiU0MErn7pNRQVE++GECPRAvdaFqr1IHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPUsXl96ZFtDje5zA/5f0Bw0+/aM4ZrYLV2dytOG7yo=;
 b=Qj8njZKIq52chii7j5ZvjU+0dJSHrS7tUY0poVLbN40dxzgx+wzH9bXl1V1DF7CH55MkRcUO30QszROtvfsLSkcnZ2B+poOKqx/WgVY9El/Pl0bB6yXrm7b+vlKbq2Sg4DdZKotoOuFbvAPu8FVNd+7J86eGAUhYrjIIUhhb2lH/AFK8l+b92JaAT2WLoRsiFP/XEkbadjk47VAEf/5tiPaa44dYleEQ7K7HAxHJZ5qGeRFctNyRcanJfHuAc4ciiAf+3v+7iNyOII2xa9jcvOfX9I1PM9PmfqacyXNplJ+iWu/PJnpzd+uvXx1G322MJCM+34jklGwIFgevBKfXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 22:58:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:58:10 +0000
Message-ID: <b22da35c-ceeb-7116-b33d-4e596980bf80@intel.com>
Date:   Mon, 11 Sep 2023 15:58:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v9 5/9] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
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
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-6-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230907235128.19120-6-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:303:85::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: e00dc60a-5bde-45af-ec86-08dbb31a91f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYnz3jwtonD+xn2//+zzWRxIUtbMB5Eifuu926H/LcBleYDPJZIPI8Nov65mtZ9harlcFL6+wmifZc+nDXfFLLDJJnGPYdUVDVAVeCZ3DSuAWr/t3bqN2pAMPVtj0K2iHmmG1VwcNO4ncfnelD6FGUAqEaRH2aH3bkuwKrcGGuzMXzolhKEeoB2LW6KWNyE71Ma4OpZ90zsiAffrK+D4HJ/7Kvd3AkpCfPosdroTZGbN7C6+OxMm2EJpT7nfnYVF1c+9HcI3tesAO0oGZ0LrF7dpoNxXQGvJ/hqWIyJgAfdTxAqgYQ7oTcp1HZbUx3NvZ7ChTf0+pCtCBPqWGajjuv0VKafE+NgrCiiilw7LeiXfFhP1OfR7dcmnONrboGrfPDxnNpzgLsLgUSiXz3Kp6lc259ECePEpEoN7qaiT9/JwDto43VHPMVrRutSBR+XRm3Ok38hQtVINpOKORD0t4rv48w8K60SKfoROjxfYLLo7Ziv996QF+cDN1dio1Mme4Zal0Z3BtH+CSVIds5HH73AUlZysVWl6eSmdxZCRB/5Qynf4QDESvqPq9zBZZAMpTmwSxxUex18EsYxY00N3fpv32xzYpGdchTIIsE3aotC4EM9pCZnIyO1p4Ms0PDprUBmeNXCsNGY6RzNPNk4HOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(186009)(1800799009)(451199024)(36756003)(6666004)(53546011)(6486002)(6506007)(38100700002)(2616005)(6512007)(7406005)(83380400001)(2906002)(7416002)(66556008)(66946007)(44832011)(66476007)(316002)(478600001)(5660300002)(8936002)(8676002)(4326008)(82960400001)(26005)(86362001)(31696002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWI4OUphSms2dGFuNGl4WTFLMWZFczA5Qnl3RHJxQUx0eVJHMloyOEFianc2?=
 =?utf-8?B?Y0JIVDMvVHdJWEpOK0dBdXRxMy9oY1ppaG5vQk50aERBNVFRSTNiUjcwSmpq?=
 =?utf-8?B?Q1JQdDR6S3dtVDZCSitMYk9SWVZxdlp6SFNoUXh5K05aMTk2ZG8zUjdMTmdz?=
 =?utf-8?B?eXBuTjRYOGRoSUw5cDVzRmMyQ3VNaEp3cC9RdTgzcjBkM0c0ZTl5enlQV2Jz?=
 =?utf-8?B?YlZURnZHZ0dncXQyTGZuMDZHMmxXSWh0VmtRNldrRnI0WE85aTA1aG9RQjht?=
 =?utf-8?B?My84SWRLT2s3d1FxUDcvbCtCYUpmckNpUTNHZmtzTVhCVHFkR2VGUHFqek4z?=
 =?utf-8?B?aVcvSlB2VkM3MDNDN1pKQUloamJETC9ydlNMNmNEdDNyWFpCbnR3bmhteHkz?=
 =?utf-8?B?M09aaCt3bHY1a0poWWdJeE55U3VDUkl5b0tXNVo0eU83U1J0VlU0RFNXa0V3?=
 =?utf-8?B?S3V0RytWdy9FeVNKL1ZnYWc5QjZzWEU0VzVFSkNSWW5Nd2dzY3VjNjFON2M2?=
 =?utf-8?B?SWtubWhyd0Z0YXlGb3Y3ZDIvemM1WWx6QWtvUW9hSkJ3QlFnMUp1MkhYV2pF?=
 =?utf-8?B?T2htYTNralQ1bzVZckM1R2tuYVlNLzdKK2xMN3FKVkE2R3N1NWVzK3BIdXNJ?=
 =?utf-8?B?NUYxcG9hVlBLR01Ya2VuQS9Uejl1dnpaMFNETVNiclFxYUgwQjBVODFxUkpT?=
 =?utf-8?B?c2grWlF2K1phcGtrZFNVSkx6ZVBpS3ptUVE0VnI5d1U3NlNjZm9OWmhjUGVD?=
 =?utf-8?B?RWZwK3ByUEc1NGgwYTNjMEtUcDVFNmNScUJidzB1WHp2YUpqRG1oMitoREhz?=
 =?utf-8?B?UHpQMGNNMUZGc0JJL3Vqb2F0b0hoV0I0MjlRVmQ4Z1FVWllQZVVFZ2wwNE50?=
 =?utf-8?B?ZXJXLy9GZ1YrZWRzWXNCTGc2ZEl2YWpRTUZNVHk0QlIrWE1nL2ZpZFNOakRN?=
 =?utf-8?B?cEJKSlJ6MkpnSXJ2UjRnSk5FSHNRS0FxY0ZiYW5RQVRDWXNpeDQvdnhWbUpi?=
 =?utf-8?B?S2o2WTZUQmRRL24zY0N0UHZUNEhEVXpZZER4TE04TkZHSnFtWTcxTGpyMWpF?=
 =?utf-8?B?ZDVLZTAzcVFBcGhyNE5aT2ZadVJIOEt6N2ZsWm5yZDhCRk1SQXNFbFJkd2Ex?=
 =?utf-8?B?ZkhWWnNsQlRHM0FQQ0lVYkcwM28vdlhMMUNLS2p6ZWdMZVFhcXROUlZKRlM2?=
 =?utf-8?B?dGJiL1orQXdES2VCM3lHdE13M3VmZlNBeWgwTGs2dGt0QnZKc0l5cHBmUjlU?=
 =?utf-8?B?VXNIU29mQUt5UGEvcnhJc0tHOGJhNFZWRjF6M0c3Q1dFckFvcHdPZHkxTXov?=
 =?utf-8?B?UndBaUNOWHcrN2wrL21mb0drVFlEbU1tWlpDRkhES2k0WmszcXMzT1g5clk0?=
 =?utf-8?B?UW9VQmJHbWlkcmFRWjB0YThRNDhoN0hxYzRJOVRMSGZuVHVHQXBiWmhoZkpi?=
 =?utf-8?B?Z2N2b3QwWWxSZFNSTjhwWXFOYWx1dElhK0laV211T3VYWGE3YklscXpnSmhy?=
 =?utf-8?B?WjV3RW01YlNrTmtsNzIyVDMwYnJuUk1FSkw5enlsVEk5ajdyT1c2NGtxLy9S?=
 =?utf-8?B?REVKZzFNZUdkcWRsKy9HY1RUaDJkL1FmTmMxdmpCa1FRWUk5TGpyN0Q2YVN3?=
 =?utf-8?B?U3h6dVQ4TWUrRlg2ZTRQV0h3TG9NMVpiZFM4K1loaGxzbGE2NzdiemlBZGNZ?=
 =?utf-8?B?RnoxQkF5ekwvV0FkQmd4T0diMTFrM3JpWWtRelVnRjlnUktVbGFvYVprYVkx?=
 =?utf-8?B?eVNRL0ZQWVNmZXBVRmU5eHcvZHByM0JPRkM3cXJINnA4OEZhWFJJWUZjT2hD?=
 =?utf-8?B?L3YreENyaEgrS2poc3pCbkorbU9HMkhhUldBR1dzNy9Nby9PTFJiVjY2bitY?=
 =?utf-8?B?enFFT2VZQUhwRDBYNWI5NktEMmwxQm5ZaXNPeTd1ZGdOV3BoTnIyeDVPVDBh?=
 =?utf-8?B?dDNtTWwwSThSMlphYU80b0kxaWd4NTI1bCtRVE5uZnJOMm5CTjRza3dGcDBh?=
 =?utf-8?B?aWhSYlR6bWZWaFAwVHF3MnY1SFNlY2NhRVp6MFpSeUVERDhhUE55TDVQdm92?=
 =?utf-8?B?aFJZV2JoY0MxakVXb1VCNkY5SWtOL2VpL2dXODFNb2RUeUwyRnYzTlE0Z0s5?=
 =?utf-8?B?VlRJNHVLVTkzbGQvTW00MlZ1VDJOS2h2Z2hIM016ZzdQSzhPdVVMY3VwYUEz?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e00dc60a-5bde-45af-ec86-08dbb31a91f0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:58:10.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIkN9z+PgIqcY/KG0HHC+ueTYBnvYhwdenfcV+PFN4WzDnnAobcsrHmxZQO/Y4ZPHosOn2+FD4liCTF3E49nrY6aK7VQm0sCU747EJCXZcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2023 4:51 PM, Babu Moger wrote:
> rdt_enable_ctx() enables the features provided during resctrl mount.
> 
> Additions to rdt_enable_ctx() are required to also modify error paths
> of rdt_enable_ctx() callers to ensure correct unwinding if errors
> are encountered after calling rdt_enable_ctx(). This is error prone.
> 
> Introduce rdt_disable_ctx() to refactor the error unwinding of
> rdt_enable_ctx() to simplify future additions. This also simplifies
> cleanup in rdt_kill_sb().
> 
> Remove cdp_disable_all() as it is not used anymore after the refactor.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

This is one of the patches that received a change that was not
mentioned in cover letter nor in a patch specific list of changes.

Having a list of changes within each patch in this area is
helpful in reviews.

>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 ++++++++++++++++----------
>  1 file changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 35945b4bf196..34cb512be1de 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2290,14 +2290,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>  	return 0;
>  }
>  
> -static void cdp_disable_all(void)
> -{
> -	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
> -		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> -	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
> -		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> -}
> -
>  /*
>   * We don't allow rdtgroup directories to be created anywhere
>   * except the root directory. Thus when looking for the rdtgroup
> @@ -2377,19 +2369,44 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>  			     struct rdtgroup *prgrp,
>  			     struct kernfs_node **mon_data_kn);
>  
> +static void rdt_disable_ctx(void)
> +{
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> +
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> +
> +	set_mba_sc(false);
> +}

Could you please remove the empty line following each call?

With the above change you can add:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

