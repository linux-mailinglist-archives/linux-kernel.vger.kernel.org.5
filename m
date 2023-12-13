Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B0811EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442510AbjLMT2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442466AbjLMT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:28:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B18B2;
        Wed, 13 Dec 2023 11:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702495691; x=1734031691;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K2IY4Jh+kri3//JpSMmLgWq3d1k6T0hS7BYVZ0CHtFo=;
  b=e8yH6HJ5drZkMRl6t/iL005WvIwjNNxF5M1/PkFDn1MU19DJfP1JOCWD
   Hm7q15lcEvq2BZBt0VulPdslya61Rixayb0BLO62+if8S20Sby4NRDOdv
   Pj2CBDx2kSj86Csr9hPZ3mVM4W3ndF37dA2YoFsEp82EPPNw3ePWPwKVD
   sJQXUGF/qnYseSFXTiBKImuI8206UwFw/Hf04akY961H9h9kn1nMxBsZi
   VfkNZ58NgCUi/gxc0OAH3AY2Etot0igLAY3VoE1ku/gMQs5DogLwjQRiK
   +i3Wue38H/UzXy/oahRp1OPw3i0wyFEXV2dag6+xTk2plvAgRkEoUSZZy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8409492"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8409492"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:28:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="864728663"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="864728663"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 11:28:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 11:28:09 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 11:28:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 11:28:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 11:28:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMa5SocjFPYULlInWlY/1QLZDM0CDNTfTHCHSzBw0PwdhXOPgdbWNROwtB7XhaoLLfdcsSEy95kJS3+0VyVoJJt1TixNKU+30OmRc4THW5fuiwtWHuxptGrc7LDQ/gwmYTeC4oop4q8QQSP2fs2vFJpZSRqgdftfYbe/SbL56WeTFz9Td79ni+ApZERNaYG1XscZ2htLsuo2NH3kO+nJEV9m7AzhnPpNrTUl+lcvqkZASDR4bV04gLNtFsR3uKh6f4zJUClPZdeGl+OpaUvSbp/jeq7hwgnkoNrwZhEyHV/qOqwudAmWflD32jiIzPutQbQp/q0C2W3Nvtl0UWj+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xjbq1hrADnOvUCYVdc3IJAnRIL0uoY59gc+13OevhHk=;
 b=OKIuNSmYphB0qnV2A987dPlMTaU5WMl1c0BwAUYxnKwXZ8erpanuilLXMgk1xqM8yZQAo2VpgWDt/hlSK8qIbVs8AQPEBIZC4AvKiLNcBo5eu4knw/CfaUCgDLDQSLNfP7uv5kw7ZsO7AG4TTZEwp3MYDBOYaMWCFTKH7IMLRBDrc+1pP1qBeG/VFXM+3CqnmwCZNMtvM4Xq1empulDI5Kc332dPKbbcVgmRSFyLBr71GpJkp/vVEMT1xZsi0IqPhR/70TZX8uXSRnQuZKUK2TorJKHKv7oEPS/WthEYQrD10F4GVQ2Ycb+AWvSc4dW/gE7xSPWPsZofRRVWuW3i4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY8PR11MB7291.namprd11.prod.outlook.com (2603:10b6:930:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 19:28:01 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 19:28:01 +0000
Message-ID: <4ce89a5e-96f8-4939-b86e-f65c16f4bd4e@intel.com>
Date:   Thu, 14 Dec 2023 00:57:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: x86/mce: Is mce_is_memory_error() incorrect for Intel?
To:     <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
References: <20231206013846.1859347-1-sohil.mehta@intel.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20231206013846.1859347-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY8PR11MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 566c217a-9cef-4d3b-d037-08dbfc119e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5EYxDs+r7Lw4k8rTp5k66frcHz9ykxWf4Zq7Xcx7fFWgsFhGU3H6dnoVm7ZKB/tBUXMn/SwEjC/AE2FNaYpM020FnjGoZ5yaRWh9IE6PkJTcISLABp70UWNXoVIfbAVlVDnm5PoUCxYpxLFnYYCTJ8miSRDua9n2qlcaA01reN8U1GO3NoTvl/Hy/JHsUMTAFcd3ydIxzps9RkvyyqFZYOQ8gez9iQ2pjU8RFTLVJ4LZmD4LRcjLfUWzKVbWyrUywBruMk6yrAUpERS87ImyBdu81skOTSMEpE3s+p+DFpJMPRwjQxSfLkBTGxwV8Ndy+D3Q5OG7hFsNtCksT4SQdXIBsEbVv+wPkO8kO69lhNGN9oxESTealKSHlsZKzAZXXAtS+M4y5jMcfBZp3efuKNP6tRB78DczShDKBFLAS3xqNZ4QFagLEviCh5Qhk/uZTMEvFtCC4ZK5w8MqdREm0rq3tDCzEgWa3MCElClF9xF52ljv4t/iJ/10PKcqSXa+Ew7Dxok6icbahhFq3fT2KmZyfsZXaxClDweGBMYD5VCEcbd4RR1hXm6749YNXMvsvk4ikOnim/4fV6SUedReRoS6yHj9dvf2OzqA1z6gUQiSfHgsnQYHIi4iibXT9kVdRZO5gpQzwgxRJpx2jIKQpmrQFHwix3CJ34ib4q9BW7K/W3R3OECNs+p115wA9/m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(6636002)(66556008)(66476007)(54906003)(86362001)(82960400001)(36756003)(66946007)(6506007)(53546011)(31696002)(2616005)(6512007)(8676002)(2906002)(110136005)(6666004)(316002)(38100700002)(6486002)(478600001)(26005)(44832011)(5660300002)(41300700001)(8936002)(7416002)(4326008)(67010200005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXp0VVY3WlFQL3FjOUljeFl4cmRqdEFDTEhndE9HNXRlaXZuOXlYL2ZyWVFY?=
 =?utf-8?B?RDVCNkoxVzZ4WW9uU1JwYUpjamQ0cEs4am1XdjBEV1Q3Mk0raHF6SzhnOXh6?=
 =?utf-8?B?cCtPS1E3eDIwcnRHdWl4SStzcEEyVWlBUVd1bDBPSytnNFZwOWdFeXBCWjE1?=
 =?utf-8?B?ME80TC9UeDBIWURRUkJubVF3WVNjR1lUSisxWVZRMzMxVU5zakcwVVNRd2pZ?=
 =?utf-8?B?YzdPRVRZNERkR1NialdxVUNWaUJZSXNETVkwQXVpSVpYdmluL05UNTc5WE42?=
 =?utf-8?B?d09vYU91U0ErbEFEVG1Ea0lOK3J3NFJITlRjNFVMSDRpZjFqNTlmSEhNMkFk?=
 =?utf-8?B?cGFKRWZmdnR3VFhCaVQ0bEoxUEhXWXVUSVJ0MHluQWFobi9PWXFkaUo3UFJ6?=
 =?utf-8?B?WUx3ZEg1YS9CYWExNTZxM2w3N1hEdUZDV0Rub2FHeDZPdEtIMGtxUDBOYnEx?=
 =?utf-8?B?Mm1icXJhVG5zOHNXS0JiemVMeXlKZ29uZXM1aHBzK1Jhb09GR0hwVVVsOE1Q?=
 =?utf-8?B?a2tpeG43Z3NuMXd0d0o4WjJ3eWl2aGNBTXdUWUo3c29QRDN5MFdiUXVMRi9K?=
 =?utf-8?B?OG1QYU9Sc2VlU0NUVVgvR0lad2dGeFdOa1Z0MEVNVEdjdng4YVZHU2hEeDY5?=
 =?utf-8?B?YW9IcFI1N09uV0hHYkRVVjlpRnVOeTcyTHpKeTlyVHAwL2FNWm55K0U5RGxK?=
 =?utf-8?B?YVJkTDRBNzNhSVdMMnlscVhvMm51UXlsZ01OeDk2TzYrVkM5T2tOcE1zckM5?=
 =?utf-8?B?UjZINVhwWXZnS2F5SWZhUXlQU2pJakx0NVF5by9hWHpTTVlLUWEvRzBVRTJi?=
 =?utf-8?B?MEVRbEdJbS82eUFsdkdBRi9TOEQvUDlISUxTbHZJMk9zNFkwV0RHWi95MUo1?=
 =?utf-8?B?Q1hvb3hVZXk2TkU3aG82MEhLUlpZbWwrRXRMODJ2U1VGOERJdWRTdlVVSlFz?=
 =?utf-8?B?NFJSWk1weGpVTTRZNmVKbDNlNUljRkRkTHNWdTd4TUlRUjVGNFA4NnlFMmtQ?=
 =?utf-8?B?aEo0ZHhZMHdFNUlwTEVrdjR6cERZbklicGprZXhIYXQ3elZVT1c1YUFncU01?=
 =?utf-8?B?eERvbi9ReTRpV2VZNVZVUXZENlFFTEJZcFVBUlU5bXZKckVTdy9JUUt6QkhD?=
 =?utf-8?B?TDEyL1hTK1hSRlQveVRYREtzTTNrSUhvMkdvWHZ2Mm00b0Qxamd2UUdoNkxm?=
 =?utf-8?B?Uk9CK2dwOWZXSHFqT3hHUnFEMko4aWhvVXhyTGl0NGxvUWd4U28xNWlRRnBS?=
 =?utf-8?B?YUxoUTBxaWFJU1J0QksybTgyZm5CMjJQZFd3UU16Q05vWnZiK0Q4TG53Zkc4?=
 =?utf-8?B?bWhXRmRxQTJUTWNoMTd5RU5FY1ZHYmJjWmxVWlh6aEl1dlZKK0UxK3RHSGli?=
 =?utf-8?B?RVRLQ1U5UUN2dk5mYzFNcHBVN29iejF4emd0R3FodWZmcDRUOXk2RDJOZkRl?=
 =?utf-8?B?c0RMczluUXVRVk85NXpJZTZYMjk5OEwrUnAwLy9ndjBGYUtlUWZFVUxWeEhs?=
 =?utf-8?B?RjQyVXEwNWd5L2RFeHozWHJsWUx6NFhMYUY1eUZscm1XMnhJRWVadHlURU9w?=
 =?utf-8?B?QlBOaFUyNUZDUzh4NktQcXJodUxzRzNiV1RYMnRSeXpucGlicWI4VUZDVXkv?=
 =?utf-8?B?OEMra3ZUb3pEdE1lcjNpWktqTEVxTHZJRVRMRU9pcUd5WE5uaFIyWlBHTERk?=
 =?utf-8?B?WWRQZ0Z4VTJ3MkR2RXNHN0xUWVRJNkNaaFVmNmwyS2tUK2ZObzZ5aWRkeGhj?=
 =?utf-8?B?elFyZDJlZ01hNy9HK0F3T0NXWXFaMm9OdDFDSDZmTGYxY1ZYTDRaMmRCVm0y?=
 =?utf-8?B?Um91UHdTY0k4WUpjRWNldHdpTzZ0VXUySUpJVE1IbjdUOFc5R3BZenZ0SS9E?=
 =?utf-8?B?Ryt0Q3AzUXVuZ3hYS01veE1SNk0rVHdvK1M0cmpEc2JnVHVmNFVxTmdGZFBQ?=
 =?utf-8?B?aHBWVFhzL2p4NFhFNXVFbGNlRDcrY080TXh1RllWTDRERkVReFQwK01zVGJo?=
 =?utf-8?B?RGZJR051YXJPWEdFL3Zxa0YwL2xYbThMSmExSklzQkg1RUc1L0FPTmdiTk16?=
 =?utf-8?B?QmZrVEVWM1gvWEJxRmhwQ3ZhMHNydTh5TFhNWWZ1WkxiZVRFKy9aWkw3RERR?=
 =?utf-8?B?blkzcUZGWEd4S3hIeTZqc1dHMEozZjI5V3VtS1RBemdDUnRqQjFUSysyMEtE?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 566c217a-9cef-4d3b-d037-08dbfc119e70
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:28:01.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Z89JdCK/jgqQH4DWVIgW2uLQ9jEro+sLaqkPqRtIZwdxUDr/+EnCorg6xg3GzDvsasA/8B95RRs5MahlfIrfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7291
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

On 12/6/2023 7:08 AM, Sohil Mehta wrote:

In an effort to rewrite the below Intel specific comment in
mce_is_memory_error(), I think I may have found an issue. It would be
really helpful if someone can help check the analysis below.

> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 7b397370b4d6..d42122b1afea 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -482,7 +482,8 @@ bool mce_is_memory_error(struct mce *m)
>  	case X86_VENDOR_INTEL:
>  	case X86_VENDOR_ZHAOXIN:
>  		/*
> -		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
> +		 * Intel SDM: Machine-Check Architecture -> "Compound Error
> +		 * Codes"
>  		 *
>  		 * Bit 7 of the MCACOD field of IA32_MCi_STATUS is used for
>  		 * indicating a memory error. Bit 8 is used for indicating a


The full comment reads as follows:

* Bit 7 of the MCACOD field of IA32_MCi_STATUS is used for
* indicating a memory error. Bit 8 is used for indicating a
* cache hierarchy error. The combination of bit 2 and bit 3
* is used for indicating a `generic' cache hierarchy error
* But we can't just blindly check the above bits, because if
* bit 11 is set, then it is a bus/interconnect error - and
* either way the above bits just gives more detail on what
* bus/interconnect error happened. Note that bit 12 can be
* ignored, as it's the "filter" bit.
*/

return (m->status & 0xef80) == BIT(7) ||  ---> Memory Controller Errors
	(m->status & 0xef00) == BIT(8) || ---> Cache Hierarchy Errors
	(m->status & 0xeffc) == 0xc;	  ---> Generic Cache Hierarchy

The code tries to identify the memory and cache errors by masking the
status and then comparing based on the bit encodings below. But it seems
to be missing the "Extended Memory Errors" encoding which may have been
added after the original code was written.

Type 				Form
----				----
Generic Cache Hierarchy 	000F 0000 0000 11LL
TLB Errors			000F 0000 0001 TTLL
Memory Controller Errors	000F 0000 1MMM CCCC
Cache Hierarchy Errors		000F 0001 RRRR TTLL
Extended Memory Errors		000F 0010 1MMM CCCC
Bus and Interconnect Errors	000F 1PPT RRRR IILL

I am not sure what are the practical implications of getting
mce_is_memory_error() wrong. (This issue is completely theoretical right
now.) Any insights?

A couple of other points:

- The code seems ripe for a rewrite to be rid of the magic masks and bit
comparisons. I am thinking of doing that in a separate patch along side
of rewriting the comment. Would that be useful even if no issue exists?

- Relying on these bit encodings seems problematic in the long run with
the possibility of more things that could always be added. Is there a
better way to do it?

Sohil

