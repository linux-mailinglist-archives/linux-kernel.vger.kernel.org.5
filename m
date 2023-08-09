Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F97C776C38
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjHIWfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjHIWfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:35:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C49DFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620532; x=1723156532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AEG4WBhRXR6+Yh4q/1UnQ3gSe5VuHH2yu065nKMleRQ=;
  b=P044jVmwzpBMUOHZT+5P/jgdEb/b3flDyX+AxXSY+haoG/r9weOV3lWj
   oyOld7Oy/PgLcicNKWSsFJ7F/OQ5htvTjvCDebFkIyKr3lZ6NkM/nhOk7
   AtUUZrvZXGDhJ9goSyqMB+93SzdjhEb9onHKCu/wGVzYQFTR9C6f9QWnv
   DGjK9JyJsOG4N1/mPakmgXANjw4vTXW9FNiKCbzx19OLp98BI2Ve/Lht/
   JFZB30/mJbbMi2/SxU8C/7N5C8WX2mHcCkGZPYLB2Ca+guO7J/EpbvlfH
   Yp3NtFPrSE9rYSxUp3YgPAplE4uIfj5hr1H7tug5Od5gby+wQ/18K/nFw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374961352"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="374961352"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:35:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875461244"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2023 15:35:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:35:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:35:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwHTtlvf6KOHUIyC1kWQsXcmGvDMW/xa9Ny2oKXYw7ovKiSpK13Jl6kIVavfVyvXbMTrON1Fgh6szJX7yahRepML6XQaoCqde7L/JHhb9c1uWF18Na/y/ggrqtuW/SyIxXmqH/gVwp5ukwbdLgZtcEY4Mnt98oX6LNqVUEBLzknbpWX+n+AjxDffPuT/KS+zb08Xb3uwKBOE6980Zyztw+IzCOTCGByjXS1xvODBJ0V1m0E7XcH889GNi5uJ2QxPHpmFr7iknWA6CkT2mifp/JztKmrpa217+a2cxdBftvYkIkAQ1Zr4QMRkVijNomOudTNLVB6lNdGMl8+sbqDKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf27/tDEBr/BRYYCwb1Hu3IPvcGX/9nw2Bv18RiwcJE=;
 b=j8j8sVZiLn2722DvMtmbg0oj6uds9bN/rLbxasPhuE8hmnbGmf2M69kAmQzAY8ZQpL+bnD22TPZSwhiULMY+jjxcO7mI4/8TiAj0hEQhw3mRdaaUi95JnYr0o4NkZ8IHqc22wfz17UK+rnlSXTuehlXRjL3hAcJuDKGis8H77cx10u3l2xPmi4Atd9Izpej3+LT3dGsmHTbDx6skJA+fiMAf2XnQWHAgRI2OTdTn8AiudSiSMIF6LVlMTCfW5pTLxRufUs6tWnldg2VQVTR6bVq6n+pYoVyEtlGws0K7LHNmZ7Yl7k2R2De2/mUTZiQdTe8URg2jSrFi21nL9dpuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 22:35:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:35:28 +0000
Message-ID: <192aa189-8b08-c8c1-15dc-722e196493f4@intel.com>
Date:   Wed, 9 Aug 2023 15:35:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
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
 <20230728164254.27562-13-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-13-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:907:1::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 9531e748-54d9-48e8-cc36-08db9928ee50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hh/poRiTgsWC2DRv6pBjrqCY+qaqfWM4bQyqaOGqitL7e6geSy2r9ksOCytAfODLChyjxrFcjlt4zucnEgp1PfWWlrwNUFHaTwkeillC25v9FShV658dQQSQRin/tcznS1XznFbyZz3nIqhsP4vwc+qJGgIXVD8Dv8oXUf9Cpk4Nyxl0EyDQNV4yiIYzj5Dhi5c6JQ8J0ywHcj777WSFN2bo7i1Mv23HrP9htx6+xE8VpOTGEuZRhPBQD9sPUr5dQ2LEbSrSuElDNLCI3kbOPc72sQJW7QHj4UuNp/u27JEcukw0q1GiO9swQ26MQyU1TDV8ujZILCQoaTs94fHc4mZTGtppj1UIf6j4bGhCJqSg1/QzrNn3gpAjfuNDxAMGdicJdLrxx8Z1e/f6jmpdzdMsihgkEtuQWd97ZTPINOeiA3RPVDivB7oADuRrSRvO5Y5MlveHyBFAIUr7H++6NTUzHWdQ8cAaEq0HbMMkQvb68GATULnkuGaVfXMWLlNU2qAs6kYZWRwTZR1NIagVcKY/2vLyvet2ghXhnn0rXatl02ov97x9s78GxxPdMx5rofYtE8q7Tqq78GwOHq+1v9POVnh5VxzhhvItjuXamwAtbU7QZPY8HVeDnAMcJxrO/yypDBvzWVUHbUiyR7y6kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(26005)(8936002)(41300700001)(2906002)(44832011)(5660300002)(31686004)(7416002)(83380400001)(8676002)(2616005)(38100700002)(316002)(53546011)(478600001)(31696002)(86362001)(66556008)(6506007)(6486002)(54906003)(82960400001)(66946007)(6666004)(66476007)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmpmWnovelpFckVhaG53eW40M25GeE9lSXlMeWZ0eDhvS2VodmZJMkhSNWlr?=
 =?utf-8?B?TEZ5V1Y4VGtsQ0F1RWp3WWtjL1NoQzRYLytpb2hUQUhydys4aUlBWThmVkRz?=
 =?utf-8?B?K05TSHZpWUZMNUQzWXI0NGQ3czhrWTVoT091TUVOYm8wdWtyUTc3SEJWMVlV?=
 =?utf-8?B?aUlVUnYzcDUwMUZHNHV3QnZaVzZKZ2tCTDUwdGVsOHc0S2pidFF0cHN5OHV4?=
 =?utf-8?B?TjBwdHFMU3VSbllqNEhkR2ZVL29ZUUhKb0Rjb1IvTmI3RUJJZStlVmlYbUNK?=
 =?utf-8?B?QTl5WU04SFdpSDRhVjA2YjJPZDNNLzU2dVNSdmJ6TUtzUWE0czMxdmlIVHpm?=
 =?utf-8?B?UEsvMVF6WGljNlJ2K1ExQzNnVzErbjBTdVpTRGR2NzV5SVp6RjNGL2tGVzR4?=
 =?utf-8?B?T012M1BjUVJyQ3pSbmM0SmoyYmlFVEFNT2FIT1NMWEozUTJ0WWxaZnF0R1hU?=
 =?utf-8?B?MmlhTnIvNmNWZ0QxTjgwaW5BSmRPMWJWSCtCM0FmS255OUlDeTlJdzU5RkhO?=
 =?utf-8?B?bmVJcW9LNElIcWZmVjk0TmkyUXZiYjBDaG5rMFkwNm1YYkxYV3lDeFRWZmxm?=
 =?utf-8?B?QTNDODNudEJ4TUkwbEM4Y2VEMm5kTkd2VExlV1dVZ0ZCQ0lQZjRjdWRhL3FO?=
 =?utf-8?B?SjNuY0JzZGdVd2o5OU5RTWxQUWpZaUlQbU9aRU9RQXBXaUVqU1FUUVdzT1Y3?=
 =?utf-8?B?eU9lamw1T0FscmYwR2hxQ256SzQyNUFmVXp2Y1VKeFRuT0kyakQ1TnlmcTlx?=
 =?utf-8?B?b0l1NFRxUEI0VlRXM0RMSCtpV2JrN2M0czdPNDMvM0pkRmRzekFKOXdrM0sw?=
 =?utf-8?B?UjdxMmZCRUtsNXkxTyszcnFMTkhES1NDaFlrOTdqWkNnYk1VakozQzRPOW5E?=
 =?utf-8?B?NldMSi8rZ1FrUmNnSWliTFFWVXR5aUpUSVEyMk1UeE9BbnlaeTcyZFN2eFRa?=
 =?utf-8?B?NWRubTJPRXdxL2pjSlV3TEpYN09jWXpLOHBDZHFoUEpuRGlFUDNYVWpGVHNZ?=
 =?utf-8?B?Rm9XZE95ZTRmMUdMUjFQS0crYTZ3NWcwaXVTQU14bk5rN0Q4T0F5VFE3Q2xH?=
 =?utf-8?B?dFZ6eEMzeUNxNWhMWUtOaU1MM252NVhZK1RZYm1oUmc3VVUyQ1JyRnRWeHVO?=
 =?utf-8?B?YmYvYVpqcG1PSWo1Z3V4d202U04rMVhxMlVHSThkRFhzUjdBMmtMMTlTb21j?=
 =?utf-8?B?UnVJbnc1a2RZMFNWcFh3SVNNMCt5QjZGeGRrM1RMUk9oUithMlpRM3pQQjB2?=
 =?utf-8?B?T210NUwxeUdWOGZQRDMxNEVkdDdxNzUyWFBraytEN0c5clpTbFpwWHNnN0RW?=
 =?utf-8?B?VlZHcUFYblBLNWhKZFVhVVh1NmhZSlkvS05MOGN0MWhITW81a0RNQVZTWjNj?=
 =?utf-8?B?T1B6YnN6T0JuUUFwdW5KRTRiRnpqNWlicUdheXpXOHNkSy9TSjB4QU1DckVr?=
 =?utf-8?B?clMwKzd3M1FYUkM1bFF1cmIrUHV6UE13ZGVwMkxmcE9uT29jS0R5c0RDbHlz?=
 =?utf-8?B?V3pMU2ZpU0h3dW9hVHZYNDdSc1pmb0xlL0h6b0lrSld4by81OGM3ZGRMSjMx?=
 =?utf-8?B?bjRPaEtteWd1dmJWZm1WaGE0c0NFM25SU1NUdzlDSmRJb3F5VTBoSTBMM04x?=
 =?utf-8?B?SS9uekdYVW5kdFc1am9adTU2QmJ4SmNLNkVqMTB6MStNa2RNdlBMQm45UTBX?=
 =?utf-8?B?cGhkSy9TcE0valpPQXR1NEhjWWdoVXp5ai8xRCtBZDd4UlIzTkMwU3FkYWFi?=
 =?utf-8?B?MVNSSUFJMUd2bzIwTGYwRm5jaXExUHF6NnlvdkNXTjhZUE5mcG03cnpmekU5?=
 =?utf-8?B?Y3hMcDY0VEh4SlVIMHU5N2JLNEUxeWEyWStmQlFZZzBWWnVXZ3M5V3pMOVlL?=
 =?utf-8?B?Tk1GbmlFc1A4T2VVbVdtcGlLOTJRYi9jbnduWnhzNzJkM1ZtUFdIdmhhKzBy?=
 =?utf-8?B?ODl6WmhnVnJMenVrd1JrdHNWUUJhYWJqUFMycHMrTDhoazlLV3NyQ1ljUWJS?=
 =?utf-8?B?dDZSbmJGbFgxT0Y5QkY3SUI1VnE0Q21PMVg0V0JhUCt2cHh2Nk9wdS9FNjdR?=
 =?utf-8?B?OVh5akxXV3owZDkyd2w3Y3BPZ3lVYllDTkR1RmFUOStlRTdyRlFrUXB1SlJE?=
 =?utf-8?B?bDdSYkRrVGpxamUyOEF0UnlWTHNqakFSMmNrQUpEWWhaa05JWUhia0NrbEJy?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9531e748-54d9-48e8-cc36-08db9928ee50
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:35:28.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oVce4bpNIt+XLEtPi7aK1TTUhWGTuDHOBxIVt3XVtEnkN1Bmo03UB/6HrrP1ow5UXduyTSECX0v3+0jRxaTQbutnjErd8mBVY8E1Ql5XDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:
> resctrl_arch_rmid_read() could be called by resctrl in process context,
> and then called by the PMU driver from irq context on the same CPU.

The changelog is written as a bug report of current behavior.
This does not seem to describe current but instead planned future behavior.


> This could cause struct arch_mbm_state's prev_msr value to go backwards,
> leading to the chunks value being incremented multiple times.
> 
> The struct arch_mbm_state holds both the previous msr value, and a count
> of the number of chunks. These two fields need to be updated atomically.
> Similarly __rmid_read() must write to one MSR and read from another,
> this must be proteted from re-entrance.

proteted -> protected

> 
> Read the prev_msr before accessing the hardware, and cmpxchg() the value
> back. If the value has changed, the whole thing is re-attempted. To protect
> the MSR, __rmid_read() will retry reads for QM_CTR if QM_EVTSEL has changed
> from the selected value.

The latter part of the sentence does not seem to match with what the
patch does.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v4:
>  * Added retry loop in __rmid_read() to protect the CPU MSRs.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  5 +--
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 45 ++++++++++++++++++++------
>  2 files changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a32d307292a1..7012f42a82ee 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -2,6 +2,7 @@
>  #ifndef _ASM_X86_RESCTRL_INTERNAL_H
>  #define _ASM_X86_RESCTRL_INTERNAL_H
>  
> +#include <linux/atomic.h>
>  #include <linux/resctrl.h>
>  #include <linux/sched.h>
>  #include <linux/kernfs.h>
> @@ -338,8 +339,8 @@ struct mbm_state {
>   *		find this struct.
>   */
>  struct arch_mbm_state {
> -	u64	chunks;
> -	u64	prev_msr;
> +	atomic64_t	chunks;
> +	atomic64_t	prev_msr;
>  };
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f0670795b446..62350bbd23e0 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -16,6 +16,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/percpu.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  
> @@ -24,6 +25,9 @@
>  
>  #include "internal.h"
>  
> +/* Sequence number for writes to IA32 QM_EVTSEL */
> +static DEFINE_PER_CPU(u64, qm_evtsel_seq);
> +
>  struct rmid_entry {
>  	/*
>  	 * Some architectures's resctrl_arch_rmid_read() needs the CLOSID value
> @@ -178,7 +182,7 @@ static inline struct rmid_entry *__rmid_entry(u32 idx)
>  
>  static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  {
> -	u64 msr_val;
> +	u64 msr_val, seq;
>  
>  	/*
>  	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> @@ -187,9 +191,16 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  	 * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
>  	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
>  	 * are error bits.
> +	 * A per-cpu sequence counter is incremented each time QM_EVTSEL is
> +	 * written. This is used to detect if this function was interrupted by
> +	 * another call without re-reading the MSRs. Retry the MSR read when
> +	 * this happens as the QM_CTR value may belong to a different event.
>  	 */
> -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> -	rdmsrl(MSR_IA32_QM_CTR, msr_val);
> +	do {
> +		seq = this_cpu_inc_return(qm_evtsel_seq);
> +		wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> +		rdmsrl(MSR_IA32_QM_CTR, msr_val);
> +	} while (seq != this_cpu_read(qm_evtsel_seq));
>  
>  	if (msr_val & RMID_VAL_ERROR)
>  		return -EIO;
> @@ -225,13 +236,15 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  {
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>  	struct arch_mbm_state *am;
> +	u64 msr_val;
>  
>  	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>  	if (am) {
>  		memset(am, 0, sizeof(*am));
>  
>  		/* Record any initial, non-zero count value. */
> -		__rmid_read(rmid, eventid, &am->prev_msr);
> +		__rmid_read(rmid, eventid, &msr_val);
> +		atomic64_set(&am->prev_msr, msr_val);
>  	}
>  }
>  
> @@ -266,23 +279,35 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +	u64 start_msr_val, old_msr_val, msr_val, chunks;
>  	struct arch_mbm_state *am;
> -	u64 msr_val, chunks;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>  		return -EINVAL;
>  
> +interrupted:
> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> +	if (am)
> +		start_msr_val = atomic64_read(&am->prev_msr);
> +
>  	ret = __rmid_read(rmid, eventid, &msr_val);
>  	if (ret)
>  		return ret;
>  
>  	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>  	if (am) {
> -		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
> -						 hw_res->mbm_width);
> -		chunks = get_corrected_mbm_count(rmid, am->chunks);
> -		am->prev_msr = msr_val;
> +		old_msr_val = atomic64_cmpxchg(&am->prev_msr, start_msr_val,
> +					       msr_val);
> +		if (old_msr_val != start_msr_val)
> +			goto interrupted;
> +

hmmm ... what if interruption occurs here? 

> +		chunks = mbm_overflow_count(start_msr_val, msr_val,
> +					    hw_res->mbm_width);
> +		atomic64_add(chunks, &am->chunks);
> +
> +		chunks = get_corrected_mbm_count(rmid,
> +						 atomic64_read(&am->chunks));
>  	} else {
>  		chunks = msr_val;
>  	}

Reinette
