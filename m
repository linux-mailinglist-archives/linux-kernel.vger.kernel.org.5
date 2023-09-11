Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FFF79BDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349644AbjIKVeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244318AbjIKUFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:05:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77239185
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694462730; x=1725998730;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HBdX5KeWaSDqToW35k40RFJ2rDwAwinBISmI4suAW2M=;
  b=DYzF780VHPf1O6Za968Tbr4NflXTmnyIoNCR+RkBo7tccsaaWf/uMgkB
   ElHdkRxtFcmm1szn+oF3o2H1N7TEsMLwsEDippq7XGxIUcYYkEB36V15j
   CWn6o3GLoPPk1pYOOfnX8On2dMoxSOgJOXUShB+SAT69lVVXUiCnALRUM
   ZnWshKeHiBHLs9QRooq75FqHqiVMaJ4snjMUAT2msFGACBRAXLyJOaAW6
   9sJ0YfWT1mA6ht5R2BtX0Js8YT1W3ikSuDLAKeoXX/U0gbTiQ8DcBNFzZ
   FzDnFnbZZCRZOoJHsuXGiObVjZtvtqAyuMdwpOxfSujydQ2FoTl+vD+4q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363224934"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="363224934"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917163662"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917163662"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 13:05:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 13:05:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 13:05:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 13:05:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSiGCUtvaPvLHVBGmarVvZvhyar9Y/+SbTSoc0JgNS+5HIsdQynZf9THCEVHkx4REPuRvKwiZ7fhydIAq+4/lxGMVeDrdrE/51jjIShm9Sq1ondlKpxFuU3QpbxJeWK/Q6zJ31elnU6zy+ioodA0dkpAUw39hIGOqmUPoTdIG9ZgqjAF8KlP+F+B9IqZujYJ9vOsSn6gGIl6PzVacm/i5wf3TU9VzMD4jmE2/iA9ZWHV6+kPzHJvP5IRBgGSyl/DUQNW8k6YCZMCdT1AW6iK+5Kb5lklEx4di2g4xu56Ae6kSp8hIvgNdqnW5BNFXWckGrKwV6dyC7yeimYwVm1Uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVP0IxfsVUIKdcJveworyoKCRn2w2n/TJtZxg69tPWg=;
 b=eFI/50C+yLOLuz0dlblIqzXOWCQfDnDOntcJnaZnUT+qeNMvqcsZF+jRFzTaxuY6HNJoh4+k0D1AulzhC0xTDiPbmkq7S90RpkLtJJolOZQBtjWbBomKiO6aPSXotE9M2uoOqM9UHAvD+jw5XdwzHW18jhjSCwfUBaFkTtXYJw+BJChp88KdH9O6SS1/c/Tkwyco7ZQgeM5WT+aaxKWqyUlhFSM2nn3CgTXjge4sqDuCyTOTtuu51UbMt8XRUT79TcZw8io4s5fyPMN9UhJyxqZmeBhlw2IX/f8eOQVobx5VrdQEoZgBURuTYBmjtlst6cTXCfqNDBSmzKf5wNKtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5386.namprd11.prod.outlook.com (2603:10b6:408:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 20:05:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 20:05:20 +0000
Message-ID: <4c89d09f-c5a9-892a-4c7d-bdef0204547a@intel.com>
Date:   Mon, 11 Sep 2023 13:05:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] x86/resctrl: Enable non-contiguous bits in Intel CAT
Content-Language: en-US
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>
References: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
 <1bd3aab725a4e2948530095eb48b11bcc4028f8e.1693557919.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1bd3aab725a4e2948530095eb48b11bcc4028f8e.1693557919.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:303:8f::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 929f0e7a-a710-4c05-8bd8-08dbb3026ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ax8q60aDLWMvTtje4uNCMKzHv3VoTjXOG9brKlbR5Q3hhuiAv0V2/S1CVyKOHm9oyhRfCT/H869M8unI8nwhbcDJeAt1QYgQz/EHp3XNnYQxVVkhlvGUqq3cJrVi9Kc/lT7wDt1uZleY4dbrfMLI7ZlPY4Dw/e2V9ZoSj5aUWuy9VpUZF5RmfmAI3dcp9AMjImY0NcvfBm2c3blW4d07jFJfn3+kv2V/SP7j4BdqxcmNnUBDD/DWd3/WqwriBF4q9Wsv9w7ScqoGJ786uRyDFneBz7ZPAmaZ+KEUy61VAcBLHCLaCeJmHdRDKRDO2kUcQOv2sRj7H3gwve5bngqZhPcoU8ln4DwPtEPCuwpJQ/Ysueh5Y9O39k6XiKI5aLJD4kc4+Hr+y1v5ARGyYhDVdPE99V8iiZyK4lsIRg17Pa6mE4SENdg8wx2hWKpahsOp8T0F7GpFxLRV6ohF4jRAQ5RVeRXtAuHAXIWVJzVqpKkvd4gRd/CDxUblANtoPYALj+To80oqDBQqWeBuvQfyA4jzL1fVbwl50P3SObdRaCbZa2HizCoNrAmGVzsS1+zkZkEHHzXcHA5c1abXrV+E9+eJwU6xLO7sAMGKm9SeYuHIMoxsAodnu6/KuBTevXmwrYtalVYVuHDVIUlwBTubkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(1800799009)(186009)(451199024)(36756003)(31686004)(2906002)(44832011)(31696002)(86362001)(82960400001)(38100700002)(8676002)(8936002)(4326008)(83380400001)(5660300002)(26005)(41300700001)(6512007)(6486002)(6666004)(2616005)(53546011)(6506007)(478600001)(66476007)(66946007)(66556008)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3J3eWFoeVY0bFBYSG5NUHNhVVFGQmFYSmRBeWpxd1h0UkRzRUlkdEpJaXRj?=
 =?utf-8?B?YjU4bUtOMHR3bDg4ck5JYkRhVW9aakxWNFJpVVQ3MXBUNlAxdFF0aGdoaita?=
 =?utf-8?B?VkRxZDNhN0JMaEM5SmRVV2s3bUNIeXNmbUZKZjAzcGxtTUZmR28zMHI1ZlI3?=
 =?utf-8?B?Y0E3MWxzdXFGanV3cStkWGxwcVI1bGxCdzg3NlBvWUx6cFpOVFZEZ0IrcEtC?=
 =?utf-8?B?eWNVeGpPdnJmZkJqSVJYMHFqcC8xQTF0Vlk3WFJ4M1BFVjNqemwzMFpvUXFW?=
 =?utf-8?B?dHh3ZmFZeVp6dU9hN0FlMEVnTUFBOTQ5VFhHcjJKcHBFdnZ3cGpnS3lha1lr?=
 =?utf-8?B?aWhPZFllZGtkVm54Q09uKzd6TkZnRnNHbWJkMkFENysvVEpzZHN4MjhoYmNL?=
 =?utf-8?B?bHJGM1pXYjdUbWRmWm9MUnVsY3ljYVpBYTI3T3BwZ0c4azlUa01sdkdpWGIr?=
 =?utf-8?B?LytoRGRNbXhOMmdhM0NBRnRLT1VXSit2aVFxNVdSbUFmZ2NSb3lrZU9kTGpF?=
 =?utf-8?B?MVBydzBHaDFKUmFmeGxRNXRLUTJOY1JJRVY5NENrVDJ1QktsRHIxcHJNWDhO?=
 =?utf-8?B?RVJ0TkxUeCt4d1F3SXNTcElMMlZuL0FEdjlrRDYyb2QxZjl5QU1EdzFTL2dy?=
 =?utf-8?B?VG44a1BLSHB3WFpqQW9QT2FCbFIzNHJXazJnSDlITG0vVlV3bUhMeHNWQ3ht?=
 =?utf-8?B?QXU1UkxKR1VtQkUvQkNHWG5qVGdYT1Z2Z05YalJCWStuNXc0blRha2lKZCtS?=
 =?utf-8?B?YTNrR2Q3ZGFLNDkyMUQ4N1RROEJJc0ZQZ1NJTzdOWlUrcEJQYjlvNEl6YnV0?=
 =?utf-8?B?eXp1YjRQUnRzYy8vaFpUaUNsSGU0SGFkeHJNYkdJR1Fjb3V2eGFCOENSdHVV?=
 =?utf-8?B?eUtyUzJ4Mis2dGdoS200bUN5YldDdzh1YkhlSEhzOW51b1NPQmdxdldmMXdt?=
 =?utf-8?B?TFNEaHdoS3F6OXNPVVpEQzY4Y2kvZXJRb2p3MkR1ZXZmNVBYeS9YZWx5SHpq?=
 =?utf-8?B?dVMrWGY5TnQxNEd2bFVsTWl2OE15bXhPVm1uWjN1dE10VCtmbktWOU43dUtn?=
 =?utf-8?B?UVVOYU1POWhsOWdzTjZqMEpsdndIdHg4dG5sRGx3K0NHSzkzWkZ1TklPOWp4?=
 =?utf-8?B?bk94NWVUMHhHUEVOb0MzemlKSVFSMElNU1haTGJQM2dKNzdxckVwM3JkRTlI?=
 =?utf-8?B?U1ZwZzhNRURYTmJrcTh6Qlc4YzVKVnRaem53cGtHUm5SNDJIRFU3eTVLN2Q2?=
 =?utf-8?B?QklYMjdJaGJHUVZ6MVE1OGFLM0VGUVo3L3l3QTd6ZTVweVU3VXlaSjdET0wr?=
 =?utf-8?B?Y0x3eWp2S2FxN2xKYUt3ZVVuMEw3S3pkaUNXMDBxcHIyaTQ0aUpxVXd1V2Ur?=
 =?utf-8?B?VlVLaEUwRVZvRHhQM0RBV3puRFhjZGVKU05KNklyTVJTK1B1MFdodGRycUUy?=
 =?utf-8?B?S1BvelVHVVhaNDVodWlkamVxYTZ6N291NlhINGpvV2VDVU1kbTlQaEkreDBE?=
 =?utf-8?B?Rmpzd3EyZUZXeVhRNWFoRGF3VDZjQXBodm9FYTdJbTNKRyt1c3lqWXhIa3l2?=
 =?utf-8?B?aDhwall4ZW5XdG56L25xV09QbmF0UWw2d3E2K3ZYV3plNDFoSW01aWZON0Qy?=
 =?utf-8?B?YmloSzVaU1JYcEY4c0dyQ05mK05PMnBXekFGTnFTQkwwaElJamhXNUpKbXZN?=
 =?utf-8?B?bEtuN25iNFNSbWRRdUpHRXNoejlnNXFiM3V0ZkUxNyt6cEk3ZitSWWJHdVBL?=
 =?utf-8?B?UjVuUjh4aThNVXRubmpzbEtGN0k2WXB5cngwQUVOcXQ4K0ovajE3OTd3dmhQ?=
 =?utf-8?B?ZGdoaHdhbFhJZFYxY0QzTnZNekpkSGswZG5LQTMxVzIrcmlvRi80N041UXpI?=
 =?utf-8?B?azY3bUsySExGYWdGMzY2WGxGV0RGVWZGQUVwdzJONmhFTk5UZVBWbU1DZ3F6?=
 =?utf-8?B?SFpGQjN2NWg0RVZsek5SWnJEUTZCc2tQRTlsVy9VZE5NZHZyNnRON3RWbDlB?=
 =?utf-8?B?UXNSWHo2dHFYVnNId3lPL3VxQ3p0UDk5Z2NraWFua3VLVGk5ZTJKdU5CSFlN?=
 =?utf-8?B?ZU9ZOUZtV3Y3ZEVpRU5wUGs2TVphUThNNEx2MjFiNmtFbVhaSkVBQW14MzR5?=
 =?utf-8?B?emg4MXlYMU1tSE8wdGdoRDBBR2I3dU45VUJSR2FlclpyblZndHhHNGJJTW80?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 929f0e7a-a710-4c05-8bd8-08dbb3026ca2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:05:20.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aviev6uzTQWctDq5/I1rFy1AV0cFk7XUNRp0gXiIqcUZeV/yKaJ1VFXn4zFPWTBBTC70N7WGcg5eY6RoJABcMvDss1Qjxtqzv99CkJtzw/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5386
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On 9/1/2023 1:55 AM, Wieczor-Retman, Maciej wrote:
> The setting for non-contiguous 1s support in Intel CAT is
> hardcoded to false. On these systems, writing non-contiguous
> 1s into the schemata file will fail before resctrl passes
> the value to the hardware.
> 
> In Intel CAT CPUID.0x10.1:ECX[3] and CPUID.0x10.2:ECX[3] stopped
> being reserved and now carry information about non-contiguous 1s
> value support for L3 and L2 cache respectively. The CAT
> capacity bitmask (CBM) supports a non-contiguous 1s value if
> the bit is set.
> 
> Replace the hardcoded non-contiguous support value with
> the support learned from the hardware. Add hardcoded non-contiguous
> support value to Haswell probe since it can't make use of CPUID for
> Cache allocation.
> 
> Originally-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 11 +++++++----
>  arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
>  3 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..c783a873147c 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
>  	r->cache.cbm_len = 20;
>  	r->cache.shareable_bits = 0xc0000;
>  	r->cache.min_cbm_bits = 2;
> +	r->cache.arch_has_sparse_bitmaps = false;
>  	r->alloc_capable = true;
>  
>  	rdt_alloc_capable = true;
> @@ -267,15 +268,18 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	union cpuid_0x10_1_eax eax;
> +	union cpuid_0x10_x_ecx ecx;
>  	union cpuid_0x10_x_edx edx;
> -	u32 ebx, ecx;
> +	u32 ebx;
>  
> -	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
> +	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
>  	hw_res->num_closid = edx.split.cos_max + 1;
>  	r->cache.cbm_len = eax.split.cbm_len + 1;
>  	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>  	r->cache.shareable_bits = ebx & r->default_ctrl;
>  	r->data_width = (r->cache.cbm_len + 3) / 4;
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		r->cache.arch_has_sparse_bitmaps = ecx.split.noncont;
>  	r->alloc_capable = true;
>  }
>  
> @@ -872,7 +876,6 @@ static __init void rdt_init_res_defs_intel(void)
>  
>  		if (r->rid == RDT_RESOURCE_L3 ||
>  		    r->rid == RDT_RESOURCE_L2) {
> -			r->cache.arch_has_sparse_bitmaps = false;
>  			r->cache.arch_has_per_cpu_cfg = false;
>  			r->cache.min_cbm_bits = 1;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b44c487727d4..782e2700290b 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -87,10 +87,13 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>  
>  /*
>   * Check whether a cache bit mask is valid.
> - * For Intel the SDM says:
> - *	Please note that all (and only) contiguous '1' combinations
> - *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
> - * Additionally Haswell requires at least two bits set.
> + * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
> + *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
> + *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
> + *
> + * Additionally Haswell requires at least two bits set. Since it does not
> + * have CPUID enumeration support for Cache allocation the non-contiguous 1s
> + * value support is disabled.

The second sentence can be misinterpreted. non-contiguous 1s value support is
disabled on Haswell because Haswell does not support non-contiguous 1s value,
not because it does not have CPUID enumeration for RDT.

>   * AMD allows non-contiguous bitmasks.

(connecting to comments in following patch on this topic ... notice how the above
comments use the term "bit mask" and "bitmasks")

>   */
>  static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 85ceaf9a31ac..c47ef2f13e8e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -492,6 +492,15 @@ union cpuid_0x10_3_eax {
>  	unsigned int full;
>  };
>  
> +/* CPUID.(EAX=10H, ECX=ResID).ECX */
> +union cpuid_0x10_x_ecx {
> +	struct {
> +		unsigned int reserved:3;
> +		unsigned int noncont:1;
> +	} split;
> +	unsigned int full;
> +};
> +
>  /* CPUID.(EAX=10H, ECX=ResID).EDX */
>  union cpuid_0x10_x_edx {
>  	struct {

The core of the change looks good to me.

Reinette
