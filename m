Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790747E70BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbjKIRso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344837AbjKIRsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:48:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44DF1BFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699552121; x=1731088121;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ycVyfPhQQju8V8FeC+eZsamXUIrOUGU3Onu6tePC8gU=;
  b=fpBA2qXqzx6y8z4EJ+YrNPp2iAdqOqT9192TKMWyRgDnv4NV11GeK5Br
   4uoo3O1bMgcWgyfCJ3YGBsv9GzKuNrMUfO8HqKiTKs617LoLfFm8oieXp
   VEa8s/MfACHlwfU4IVNtLXHIDHU73ym8O9w+r+ahean0nuUEkIoaUS9Kr
   429wvBAwL+pWk82zu5Q+XjhWVE24NK1ySeE5et1yGh8aBdSuKfll14Chc
   gM3CgeYfoNzg31o6phGNnEmInIV6a4IAIIfHCbj1OBsLJV25nQyzPZCr3
   scBT2kWplHJRKOY0NlG2MRBEMZVDf7gHVvEnf3X97SKxAx5HgntzRhftU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11584455"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11584455"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="739909171"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="739909171"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:48:35 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:48:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:48:34 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:48:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjzBcuBYEjtUdz4BUlOsxAWFVj+gHcGZPpv7PZXFKauNE+ROqRkAGVCde95ZBKKcL1lzGSs/D+i+Wh+OuwsjUocx/IbKuRdvUNMDxRrlbXUKxibk0Jj9rE0QsElt3NaY0sCvNeodOWyWC/uU9732tzNLbEZIpK+z8x0PcnekZk22kUDhXMhM5KZ7LhnHZyhS3rsUnjmDzu4+DxowyouMcpkG/iQUIm8MEKWZmkJwnhtMGOTLby8rUgblC+fjaKgic+IOXNQN44o2RUw89k9E/CWiewZekZ7b6a+ZS9FBGEUu72UDYZGm/W9ZUPRjyWStaGx7CqDnKDrn6Js6vAy42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgHkh0quWBndQt+mTMgIPFhKAziqu4KiAZV3/nFPg6c=;
 b=AmozkElolPWWSWDPdfSRPyozTFlT0Q9RXtTLzXwlYwEYW91Hi3A+NHpwDSvpvlMx/KC51pBkQu8s+C3ObgjZaNEOEP8yMZ062azDgUdllc0kjrkRJaiVaf02UyWpXC5ljx6c+3WLfeke31uc4dPLT5YmcWS9FQYxygihjvN4M3tTT1tJ6JCeazH6cO4X99ero1rj9XgLeniAwnj4Jkyl6Wt5ihiDnjicEN/XDwsdb5f4NaFZ+cRC2i+GCq857yuwpChbJ8nHPUvX0ufkHhaczwKY/wPZQ2ZOnGr5J4zh7ScvBeD2cTWnd6uEQlGm/fog/BmeZxXzSh7CjBKlikoikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 17:48:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:48:32 +0000
Message-ID: <9084cb79-22bd-4cb3-b48d-f0d8d71aa47c@intel.com>
Date:   Thu, 9 Nov 2023 09:48:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-22-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-22-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 80aaeeec-4d3f-4f89-8811-08dbe14c1730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztYOe6vbh0JUtr+zXfX/QhZ76WUVxdVa7yi1TYbq0yikO5kXWb2pyfbnLkLznbQ10oVZg/8PJcJ+/LRIs1vsize7dwj3g+Ay4uR+VE4UYAr35XNoGW1829x262EX3q+GEXv9ts43PZFnDphUBnzoisuCKmzs3JV8Qdr1Z82jC3G0GxY7kMQUa+bmwRGrHsb/DBXWSPICxvT1DbOg2SeeyrFz0b44aLyEViqYhL3iAM/oAECm2omEyk/rM4ALEIu5fMuVb3oQ/alNnwOnN58U/zPJsGEsjU21Po7LLnAiG570GCEbky2S3AWeO8vciVwbxwJvNgodzgDbu2PFCncS6K9Z2dOYh+KDXzeCkRA93OI7jG51xRmE3fXpkjkWCYgzq4tIqX0GhzLT4Trjrrn2tDVDJNtM+cgTDgsWzrPHJZX6/Utzy919EQLq3z65aT1uqTvk7Ap3eJnQ/5E1od5Jmjr5/YuxLp6fRtH1uKPBER5YD0PBu+PtH/nQZ+V5h2GxWHyc6ni3oDgMwLKy2yaQVfw9dsaQJRuofaciayOzNRRixG3r497dv4b4cRZC+uO0qytOF98HCP8HpQZy7iHtqZNrX/tqzR5oAFE8Iw/E2asZxjprwVhmLKAXmDD0Al0PehpuDfnISXi/igDBV8VRxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(82960400001)(83380400001)(6512007)(53546011)(36756003)(26005)(2616005)(38100700002)(6486002)(478600001)(31686004)(66946007)(8936002)(8676002)(4326008)(31696002)(66556008)(66476007)(54906003)(316002)(86362001)(5660300002)(7416002)(2906002)(44832011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lJVEkzd3hIVGRYRC9TdUp6cjlZWC9xNGQ2ekFnOWppLzZ5UngwRSt1R0Y2?=
 =?utf-8?B?NDFwcVhjYnVuNjdpdlRpMmNQWDVQUHhkcG8vUFVBTTE5Sy9YY2p4MzBiRTRr?=
 =?utf-8?B?VnJWYmZ5RUVBcDhvcmxJYURBR2JBS0pRd0hmdnZOdkxIOWxmOXlYeGRnTDda?=
 =?utf-8?B?U3E3Z1A4U0lJcys1M1lxQ3M2bE1RN2t4MEwzQ29jTEV4bUJJZWFXUlU4YjRa?=
 =?utf-8?B?eDVDU3p2cTFXaHNQM1hnT0pBUVkyb05iNUdqZWNBVHNVdUZTL2Q3VUtYUnJu?=
 =?utf-8?B?clBFc0p2VGV5enZkNHJVMEIxdFpXUS9wc3V3V0xXUktRRmtIWUhicU9UV0RT?=
 =?utf-8?B?ZGYyOVYwZ3ZpRXdvTC9GbWsyb3VjNlJXbWdWTTdTS2wxQXh3aDlFTzFmSldE?=
 =?utf-8?B?Y1dScnllYm9nS0ZCUlZwRVRWQk1DcWI1T1Z4Nmlndm1Ka0NKa2JCdU1jczlN?=
 =?utf-8?B?SkRkQVNjMFZ6MTZsaWZXd0srSGJ0RGxxZUcyQ0FYa1huOWhoNWxRL1JrWmxn?=
 =?utf-8?B?TjhQNEFnWWE4dEExc2ZJazRMYm9tQ3pZaEhLRDNCcTVGWWlZYTBlaTgwdTVP?=
 =?utf-8?B?YWdUV25oNkhIR3AvWWdUNWRCMXF4cVRLaE15c3VpUnFRTWtqRXBpeStranBs?=
 =?utf-8?B?ZEtNZEV5MHB0WDluQzF5Z0RUVzFOWU9RWnhqdks5Vmhyc2VJSTBpaVA5UGpF?=
 =?utf-8?B?WW1BYUhWaUZhblFHTUFmVFVTQzlPcjZmbERzWmJBbDJXZXcyNTZrZ0RYTU5k?=
 =?utf-8?B?S25Ib3Y0OElPRkNEVEFUVzRBUEZYSER2ZG9EeFFSVDVpWDB0ZEgzb3JlTWZQ?=
 =?utf-8?B?TXpjM3ZMVWFQRnRiT0M0dXNHS1RMb25jbmJBRkFSa1liU211Z01xWGF5b3lI?=
 =?utf-8?B?ZnpUWlV1SUxqZ3FmSlgvdEpyakt6NlVpQjdPN21kSmtXWmRxcHZlOHF1YTVp?=
 =?utf-8?B?emF5T3QwbHJiMVFUZ3hZcGtITHNGU2JybFQ4V2dEOFBRVXgyakxzU0cxNzd0?=
 =?utf-8?B?WnV1U0Zna3U0WmZGREcrZjNScVNReis0aVVUVFgzV21peDNEcll4ZUYrRlFV?=
 =?utf-8?B?VFFCdXRpanNvdEhZcmtCSk9KU1lFOTRRK3BVWmRja05idlFEYVZrb3R4MWVp?=
 =?utf-8?B?SEU4WGx0MDE4cGdZU0wra0JpME5GTGtObWJTMGFySElXSXhxQ3ZXbUdXSXRa?=
 =?utf-8?B?L1FUcXJqeEtpVjEwbjh0RFRSeDB6M3RqaWk1VUNSQ2wxMWdaL0FKUUZ1a2Ex?=
 =?utf-8?B?WEltSEZPb3Z1eXlGRnUyUHB3RzJwMStSdEhSNVR1dVRKdzRQYWdycm5yNUlF?=
 =?utf-8?B?bjNJQ1BmTnQxWHJOOXdVZ3RMRXhFS3hocVB0ZzE1TnVLUDBIVGZUeFlrYitz?=
 =?utf-8?B?WllSZiswRkd2M0luTitIRHVXaHltanBNRmlvaTVYN0orM2xZeWxJTlJWWVlD?=
 =?utf-8?B?aENyMS92M0tjbXRTTy8yQWd4YUVoY2F1Y0NGbWNwUkdmYWRzazBjTGh4YmJy?=
 =?utf-8?B?WWxwdGJEWEhDUCsvK0lzM2JPa3lvMGMybG5WakRlQWVUTkRJTy9tdlVCZndv?=
 =?utf-8?B?bHVGTlZFWHVabVpTMTRRTnhMSFVQN2JBUUVNcDRsUk9FRk1WdmVtaTVUNlFF?=
 =?utf-8?B?K3FMS3ZWQ0FxTTBkeHhvd3ZFbXFwTXl2bk5xVU96RTNOYmJTOU56dU5JWFVy?=
 =?utf-8?B?TnNoOFNUNDkvNVo3RVRaOWF1RnppaVAyWkJFQnF4SC9pSVlWY3RKaVZBbWdi?=
 =?utf-8?B?UXd5YzJQTG9xTWVZa1BnRGJRbloxdzUreVpxd0Z6cDJJcDNyZFB0RWY4Yk1B?=
 =?utf-8?B?bE9nRUxCbGpQcVpiNUowYklYT2ZQU29yOTgzQmxxSDhhNmtNSXBSL2VteU5I?=
 =?utf-8?B?dFpLMmF6dlE4UW1wdHNmSi83eHc3SXB6NVpzblRXMHJqcGpod1JlVStyMGdu?=
 =?utf-8?B?eXR1ME51em9VNkM4WEY2ZWpwbTYxZTAyeU1maEV4c1kwMEVZNjd0UE5KeUcr?=
 =?utf-8?B?ci9HUGJMR1hrUEJZYmVMUDNUTTJDb3FLczlqRjJONU5VeTdTUHRkODNnUmcr?=
 =?utf-8?B?b3h4T0hnMEg4bUZuVWRWVDFvVWorbXdSbFNaN05QdkhNcmFwcWVNNVFJTzBT?=
 =?utf-8?B?d1k5TUNtU2ZEZVVtUWNzZjBjRmhnUFkzQ0hxNHBPdEZ5R0R2OG4xV0RNcnhl?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aaeeec-4d3f-4f89-8811-08dbe14c1730
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:48:32.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riNtkpQRaFcE7/fZlKmMa5ADQVTM1Tk0cyH8YObGjDE0huOXRIdHM/VZDwj5QSBbBPmafpaubCDwTmRy0myThBJopNimUjxhhfnMBQJPTu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> When a CPU is taken offline resctrl may need to move the overflow or
> limbo handlers to run on a different CPU.
> 
> Once the offline callbacks have been split, cqm_setup_limbo_handler()
> will be called while the CPU that is going offline is still present
> in the cpu_mask.
> 
> Pass the CPU to exclude to cqm_setup_limbo_handler() and
> mbm_setup_overflow_handler(). These functions can use a variant of
> cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
> need excluding.
> 
> A subsequent patch moves these calls to be before CPUs have been removed,
> so this exclude_cpus behaviour is temporary.

Note "A subsequent patch". Please do go over your entire series. I may not
have noticed all.

> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Rephrased a comment to avoid a two letter bad-word. (we)
>  * Avoid assigning mbm_work_cpu if the domain is going to be free()d
>  * Added cpumask_any_housekeeping_but(), I dislike the name
> 
> Changes since v3:
>  * Marked an explanatory comment as temporary as the subsequent patch is
>    no longer adjacent.
> 
> Changes since v4:
>  * Check against RESCTRL_PICK_ANY_CPU instead of -1.
>  * Leave cqm_work_cpu as nr_cpu_ids when no CPU is available.
>  * Made cpumask_any_housekeeping_but() more readable.
> 
> Changes since v5:
>  * Changes in captialisation, and a typo.
>  * Merged cpumask helpers.
> 
> Changes since v6:
>  * Added the missing dom parameter to some kernel doc.
>  * Re-added use of cpumask_any_but(),
>  * Expanded comment above cpumask_any_housekeeping(),
>  * Added some more comments for good measure.
>  * Added explicit IS_ENABLED() check as gcc-12 doesn't seem to work this out.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        |  8 +++--
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    | 33 ++++++++++++++----
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 42 ++++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 ++--
>  include/linux/resctrl.h                   |  2 ++
>  6 files changed, 72 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 1a74e9c47416..7e44f2c40897 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -586,12 +586,16 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
>  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
>  			cancel_delayed_work(&d->mbm_over);
> -			mbm_setup_overflow_handler(d, 0);
> +			/*
> +			 * temporary: exclude_cpu=-1 as this CPU has already
> +			 * been removed by cpumask_clear_cpu()d
> +			 */
> +			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
>  		}
>  		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
>  		    has_busy_rmid(d)) {
>  			cancel_delayed_work(&d->cqm_limbo);
> -			cqm_setup_limbo_handler(d, 0);
> +			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
>  		}
>  	}
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index a033e8e32108..64db51455df3 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -552,7 +552,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		return;
>  	}
>  
> -	cpu = cpumask_any_housekeeping(&d->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
>  
>  	/*
>  	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c4c1e1909058..f5fff2f0d866 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -61,19 +61,36 @@
>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>   *			        aren't marked nohz_full
>   * @mask:	The mask to pick a CPU from.
> + * @exclude_cpu:The CPU to avoid picking.
>   *
> - * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
> - * nohz_full, these are preferred.
> + * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
> + * CPUs that don't use nohz_full, these are preferred. Pass
> + * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
> + *
> + * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
>   */
> -static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
> +static inline unsigned int
> +cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>  {
>  	unsigned int cpu, hk_cpu;
>  
> -	cpu = cpumask_any(mask);
> -	if (!tick_nohz_full_cpu(cpu))
> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
> +		cpu = cpumask_any(mask);
> +	else
> +		cpu = cpumask_any_but(mask, exclude_cpu);
> +
> +	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
> +		return cpu;

It is not clear to me how cpumask_any_but() failure is handled.

cpumask_any_but() returns ">= nr_cpu_ids if no cpus set" ...

> +
> +	/* If the CPU picked isn't marked nohz_full, we're done */

Please don't impersonate code.

> +	if (cpu <= nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>  		return cpu;

Is this intended to be "cpu < nr_cpu_ids"? But that would have
code continue ... so maybe it needs explicit error check of
cpumask_any_but() failure with an earlier exit?

>  
> +	/* Try to find a CPU that isn't nohz_full to use in preference */
>  	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> +	if (hk_cpu == exclude_cpu)
> +		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
> +
>  	if (hk_cpu < nr_cpu_ids)
>  		cpu = hk_cpu;
>  

Reinette

