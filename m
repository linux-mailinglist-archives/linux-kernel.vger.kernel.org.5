Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8F6776C55
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjHIWjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHIWjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:39:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963FD2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620763; x=1723156763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dac+XZ2EMQtT3/U4cgim49neH1yxLuKDtRz4atrIzAU=;
  b=lZj++QYHGdveAEd8NlZgChOy+9RBZOZLt2gh5R8xrDc83hA3u9TIQC7j
   bv5h9LrjB0FfwuzfOQiBa+86n0kBGAASexZSnSDtq/SwLjfsHIzwBh9Yt
   ruPOo47AZ4dro/e55bGygdKDigAyKdvnpNwNF4D5q+lj3gMDoNabIJBNs
   EwAOW3Rps0o8bQmexfv1l1t3hxdztJslRnQz5CWt0kq35UyhbjDmZK+RF
   lRdRRuXUbPaYWyFZWsvmK11CKOHgzrTGf0P0hMP4+WjMG15wkTb+gWVbi
   ojA4HUvHpxgfHqqmjsqFZNSgAGBxiUOfHPzqpJEQjUetsQbPAeDZUN+jv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="368706356"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="368706356"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="708899249"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="708899249"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 09 Aug 2023 15:39:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:39:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:39:21 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:39:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7pBvJ9K+wYEmQymP3j2KO5kyiAh2BK+wziEmLPhJpeYNUs3iTz9Z3XeJbZNqne7TBLr8sTvAOWJKJFYtmFYT0wDkGPnhFeBZ1W+QP1mrLyETZev72r/ailYCofwVMLtYjQaCKh2csDwdiLWt0M+IgnERPQeqyoz/R8cExtfp1NfFOyo/uyl4IFeFZhdSKZ1OcLON4JIjei3BpDc6Sz6jfNfgVL3RsQf/3sYgdWzJzMEPxAan1z4btztnn7gwosruz1PHo6GbJFBRhZM3L2wgvfHo98gD7lqMsoLnsk4Qm5W9NQ8fOPPdBgq6w9xYFQ+v0ErdQJaMuxu3vVrmTrtHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uav2QbO7jM1uMuCCGmPvQGSOHHZT6yTpsJdZ9d44G5U=;
 b=aWgB+qaDclALP6G1wkK4PbQpkzoiC1WCp/GQszhOqwtl9qU4Kp9i7rHXGQX6nrfGER25f8OUEn6vic1M9gSdRLqOYb30xd4Oyn6t6MbKVJ9BwcfXbd7JYbKXFwHSKTCp2xMh0kohQzuKofbKtdnb0OEG3CxvDxlVW/6qIzNlAZOSL9FEkvkdrUWH+PoHKu2FpnmB+1KTAb/ASVJXCtYd2Tb5zu2pQVNdldERkvwOvmBjbEhnMB6WpB9ITXo2P9FBtk0TtYulO7/x8P67IhwZ1Zv0haKklo7kzH6sJmmzgkBK2NbtX+9oHmaY/4pQ88r2LHoDg9ZHnKXxtCHEyq1jkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Wed, 9 Aug
 2023 22:39:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:39:19 +0000
Message-ID: <6ba3568c-c28c-1445-7c18-d7c5dee7200a@intel.com>
Date:   Wed, 9 Aug 2023 15:39:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 23/24] x86/resctrl: Move domain helper migration into
 resctrl_offline_cpu()
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
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-24-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-24-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: b11cd07b-6822-4f21-5bf5-08db9929783a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yA2Q1Y9yNKrEyDuNq3F6/cg7KTYlVIdH9Zsg1qcQh8RJQ1Kyv02th2IrmHZJkXW3o5RSIHqCKnoROO04wUkjuITuybsg54/5Kdyfam3iTG86xfalseG+ojFG4jzXto+mGDmdeLdvJtJ/v0W3dvyG6GX/ckmasNAl/uUqBHSYOlGg8sVDRBtlKH2o1jr+MGF3tz8KFFGBAUbLzxAmyRRWdKPI3EyvPjpGpqnOpF+4JhGGJsFbSyFk4WL9Ww/aaerjTL7tQnqMU0UIGZI5mD22J25NJuJDbP+OApx7KYmQ2cejlQcf/0JFMGeTYUIRsROWy/3kCzyN4mOs5gOaPU+OJDGdpp55P46QEEyjWo1U2E158cj8PGmguNOcj3oBSBq+UrXxBy0ruodUA6CzGn9Yh196Pl9f0g77mfo7188pUbeUpnnHTZ7DMozVIJXs/FMKELjU1vsSDGU5AQk5Hce0avvkExryIIPSEFXhYKsIcNm/iObIVezHyoTqRfk/tci7ZMVaxV87QgNWUci9mMoyNF8VVVeTyI6ibqAUks/T0lKKbe2rClSUi/2Oc7U0P3Ttp5QZmF6JWyCMjg9DAFgaD/cLRv1gtJFlYE8bbV8nfOUxXO188Py6BjTbE9BzHGX7NzdWVk6qhWmAswzIXJG5sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(186006)(1800799006)(2616005)(53546011)(6506007)(36756003)(6512007)(4326008)(316002)(82960400001)(86362001)(478600001)(38100700002)(66946007)(54906003)(31696002)(66476007)(6666004)(66556008)(6486002)(26005)(8936002)(41300700001)(8676002)(2906002)(7416002)(44832011)(83380400001)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1WUW8wdnU5T0RSZmJUWFVva1MyWDkxQ1NxQnhBcVlHQ1pFc2V1c1liaEh2?=
 =?utf-8?B?VmwydTZ2aWZ6ZFpDQVZtMUlXSjAzNTgzQWh5c29zWXhvMWoyV3RISjQrbVFG?=
 =?utf-8?B?NWpNZGljVG1XNG5tcG5QcU9sUmZPOTgrZkYzOVN2b292V0ZsKy9QeVBTZS9Z?=
 =?utf-8?B?OC94aHZITVNVSVhZbEI0WW9tRG9uc0lYc3NuNzlFa0VXbkEzTVZUMmhLOG5m?=
 =?utf-8?B?VWdYTC9kSkN1dG5vTTBtcUNxWWpzcE9mMmlzRnp5SkloZ1hWblg2bU9EMENm?=
 =?utf-8?B?bkNJUGgzT2h4aTdUYktpVFNsUS9FTFJ4SkdVekFPa1dlZllSekhPZXpIYTZE?=
 =?utf-8?B?TUlKdkNmYWpZUGc4UFU3YzFCT2o5YlNNaWpSbjBUYzhsTVlpejRwdFdzS1pj?=
 =?utf-8?B?dWFYYjBFbUFZUUhzRkFsWFBaRC9HLzh3V0g0NHYxZUZQRDUvYkYrb2JnZWZT?=
 =?utf-8?B?WmUzYSsrc3paREN5dTRud2NVa3NxUG5NckRITTlSV2MzMjdnYno5RUNrNGcw?=
 =?utf-8?B?RUZmdUIxQ0RKSHJVU2xKSmQrRms2MlJWbFJrdVdqWU9oTzVsTXV3NjVtTlNk?=
 =?utf-8?B?K28xT1lmK2FlTXVmcVBKQi9tUXB4dk4zR0FVcVIwaFNoUTlBdm8xWHAxek5X?=
 =?utf-8?B?dGljaWFsQjM5MHlmOUErRWVWUjltYlA5cDQrUTg4am16Sk10bDFVRDMvSHd3?=
 =?utf-8?B?cE1pRVBWanRUMVBxWWl2MFFMYld2cGxFL29QbWVsZ0tZcmRaUzYrSURuMGk2?=
 =?utf-8?B?WHljaitxYmdzZXppdHhhTHNjcXd6R3prUTZlb0NTQ25Ud2dQK05sUlVySE4z?=
 =?utf-8?B?R1pFaHhiaWFwVnI3K0g3Mk92aEhxMS9kSWRBdjhkK3lPQUFBeXpBNWo3cURT?=
 =?utf-8?B?OXRwOEdCNkozUUdOWG1Qc0prTk1OdWRQTWd2eEFuYVRtMEVLVlJJbVhVTGhX?=
 =?utf-8?B?akl0cUtDSWwvTVJnSDFCd0hveGxOSDZoY3ZvRWx3T0tqbW1ZUDZhK3U0dWor?=
 =?utf-8?B?L1JWM2JUSnJqdHdiQ0pMR1BOWmFtWlBpekF0Y01kRUk0QzZ3dWczeG1VWENP?=
 =?utf-8?B?bnVmYXNvSUZadlhzWCtXZTRFaThGY0N3aWtqUy9EL2EvKyt3MHN5N1IyQ1Yy?=
 =?utf-8?B?TG80SzhLTlF1MU5qak96clpYVHQ0bzdOUDlMa0VWNFhEMHBjYzlVcXVzT3N4?=
 =?utf-8?B?b0tuRS9kcEwvS1ROY0xjMkxqTEROMkxMRlJ3KzJHTGRTZmdiais3cC9scVpr?=
 =?utf-8?B?NjlGR2Zyam9qckVaZE5EYWsxLy9IcnVNbjZLQzFBbi9BL3RUc1pUaUtUWG5n?=
 =?utf-8?B?OFJLcHFaRjhYTVJiY0FMYWRwL1MxOWhEeWRjZHFJcUw3VHdYbGhtQTZLQmxX?=
 =?utf-8?B?RUZjN3R1N2dCdjJWaDk4aStUMFN1Z3plM1B3YlYzUms5M3U5ckJCWHQ4VXE4?=
 =?utf-8?B?T0dJck1vK0xoVVdZQWhjYUFBdXR0QzRXWER0NEJQUGFhS01oTHdSNXRhYmtW?=
 =?utf-8?B?bU1PUGFiWW5kQ0RQbHZSR0RFZyszemtiaW1RWlhaZTJ0RktKbXpmVGVLTHBH?=
 =?utf-8?B?UE56WU1HZUxjMHRReDR5L2t0VDZkSXFLV2E2TUptZjVVRGxuOTlrTjk0alMr?=
 =?utf-8?B?TUxtY1FXbGh6aDVlYWpTN1VUZWVFSURwaWRDSmpNZE95MnRVSjU1bXBnU01X?=
 =?utf-8?B?ZHE0aHpRU3hTZytpSkFRNnlrbFVIQjR5VGt2OGEvTFZkSXU3SS9VUDA5Mktl?=
 =?utf-8?B?ZDRBVFlFVnoxT0NSQUQvV1RtUWdRQ2ZpTGI2aUxFcHpjUGljR0JpM2kydHNn?=
 =?utf-8?B?dmtuOXhteENDWXVLQmZWb0Uwd1dvMnU4NTZ2V0l2VUxRcDBFcHQzcE90eGFP?=
 =?utf-8?B?OGZ6VU1ES010Y1A4Z0FvN1ZQZGVKb3ZtcFA2STc0WVMxVldtVFpYU2VxRm0v?=
 =?utf-8?B?dFJkelFpMForY3ZwbXJXeGl0RE1lZDRsWndESXcwVnJVZUd0WU5uOUwwZWlt?=
 =?utf-8?B?R0VrZzFNOW5CNjFScWJoeUpsZFBjYmxsTVFPV1E4a0tqVzNHb29yblF5Yk1W?=
 =?utf-8?B?QXNPV3Znb2RtcHgwWUU4NUkyVXlCWUJQYlkvMTZxcjZpSDE0ZW45aFhWekdR?=
 =?utf-8?B?ZmFjc3pGbWQ4RjRrdjh5ZjVKNUNXWElmWWFld3RXeitBa3FNOXBkTHB1bTk4?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b11cd07b-6822-4f21-5bf5-08db9929783a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:39:19.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdMfqgCErdVjGdCVZlpZ4uAAAR/c5oVwZqBuWeXny1+Hut/8i3GESLH27E4kGfz/HX6HMHs9p28p/cWcFzz/LEzsz/KjnAFrgMEY6jUW4oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:
> When a CPU is taken offline the resctrl filesystem code needs to check
> if it was the CPU nominated to perform the periodic overflow and limbo
> work. If so, another CPU needs to be chosen to do this work.
> 
> This is currently done in core.c, mixed in with the code that removes
> the CPU from the domain's mask, and potentially free()s the domain.
> 
> Move the migration of the overflow and limbo helpers into the filesystem
> code, into resctrl_offline_cpu(). As resctrl_offline_cpu() runs before
> the architecture code has removed the CPU from the domain mask, the
> callers need to be told which CPU is being removed, to avoid picking
> it as the new CPU. This uses the exclude_cpu feature previously
> added.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 16 ----------------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 6eb9408a942a..edc0dd123317 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -578,22 +578,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  		return;
>  	}
> -
> -	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
> -		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> -			cancel_delayed_work(&d->mbm_over);
> -			/*
> -			 * temporary: exclude_cpu=-1 as this CPU has already
> -			 * been removed by cpumask_clear_cpu()d
> -			 */
> -			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
> -		}
> -		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
> -		    has_busy_rmid(d)) {
> -			cancel_delayed_work(&d->cqm_limbo);
> -			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
> -		}
> -	}
>  }
>  
>  static void clear_closid_rmid(int cpu)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 12a628b5d476..a256a96df487 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3892,7 +3892,9 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
>  
>  void resctrl_offline_cpu(unsigned int cpu)
>  {
> +	struct rdt_domain *d;
>  	struct rdtgroup *rdtgrp;
> +	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;

Please always keep reverse fir order.

>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> @@ -3902,6 +3904,19 @@ void resctrl_offline_cpu(unsigned int cpu)
>  			break;
>  		}
>  	}
> +

Can there be a l3->mon_capable check here to make things clear?

> +	d = get_domain_from_cpu(cpu, l3);
> +	if (d) {
> +		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> +			cancel_delayed_work(&d->mbm_over);
> +			mbm_setup_overflow_handler(d, 0, cpu);
> +		}
> +		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
> +		    has_busy_rmid(d)) {
> +			cancel_delayed_work(&d->cqm_limbo);
> +			cqm_setup_limbo_handler(d, 0, cpu);
> +		}
> +	}
>  }
>  
>  /*

Reinette
