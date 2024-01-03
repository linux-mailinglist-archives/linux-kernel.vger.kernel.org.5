Return-Path: <linux-kernel+bounces-15926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705538235C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF19C2875EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10601CFB5;
	Wed,  3 Jan 2024 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="syp8seqG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9551CF8A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDOSYY2CQvro6eHN3y2AkC8RNuUKENaI4jxG7WtwtHPax7xqI2T0L7tU6sASyjwKKTZmU9OpECJLE/d44qWnPXBkHLi2aZDhqAexniCiuH1j+CNVp5Y41ARYhYxolQsvCz564BtOt9wmy/bpfg7jr4b9tm3uFB//yZtmBpPkyLS8g9sLHtrob+/30+EZ2V8OthpUnbHjNib73kq4ypUMhXX1QAdtbXdLSodTSVJJLOETHuzIVQ+sCMeUwvgglmFAbgDZbbI9Mp61DEM8l76aBE7fVcOWqg8lZlt83l5kTn9RIzu0h/lGhgUQum8bcijC2yEx95qtrAyoR3ESFRB+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4224ELxYLhWdqecWTtS+c2wwHL1iq6E3NMNUG8OCDIo=;
 b=QJ1VQ1jtYOH3oOvzFY4dvW8Kpiu8E40hnN44G/R+hxcdkuS524pEAklhYbwS2BBkhZgxZHmgD7+dRSamVUEXFbBU9K1cnqy/T60EU7Cv+VqeE+czguT22FU/8AmSS0w9dlO9vBfjUN7NzSQ6kQSz/WvWH7ah2qpdIdgUrs+/yWM5ekJwG87DOR4hUKCEflg8HovvjcawZlyRM4fRtxhs8tAmYLhmU2kwZ0ZKpU4k/5GIwxCBUWxigMac+7qEqbPVwXv6HyNJEl8uQyDNRyEAek+ZBM3OL0hWQU2hC+G39JmkO3pp469qHN8U77AQnme59sM3n7+R2HVkBE8Xf8MuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4224ELxYLhWdqecWTtS+c2wwHL1iq6E3NMNUG8OCDIo=;
 b=syp8seqGsxRxyH+ZIBgNuKrG12Tml10QYJ9hLK5VJh/1hrbkhz8WAO6f6S02cjHIRyAJ+ZT9Q8oN+96+LxvjMKgv3H5gj2uuxhXeS/Z/DcH1Q3Vhf4kTNCqKwoZ5cQzjNw6Wh1CowUAE4gsG0Dk+vXWHuD74zH8hJldGOVt4yVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 19:43:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7135.026; Wed, 3 Jan 2024
 19:43:20 +0000
Message-ID: <cf72ab6a-83b7-4609-8dec-7756f8ae5808@amd.com>
Date: Wed, 3 Jan 2024 13:43:18 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v8 13/24] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-14-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231215174343.13872-14-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 31283422-a61e-4d7a-8d8d-08dc0c943d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZqS+uU39rDcPcWcbRzOa7HK2yBuzxDLmyb72VAe/2a9YU+lo92T7lIA67r4U4ejiB/GjtA/3UmjIwxqGd+2QjjQI2X6lV69mlVGjeRZ9evND8PUl3R5OQnMNOR1VeXXmbG3vrG6TbEaH/BOs/VutkK265BmbSxHzXexztEceO0GKcIzzQL7XRIn5vY8fN4MCY68EXO5xsj7AtAYvzGX4F35efPBG3+aVlTW9ST3bt+Vd4Nto3ELTg3VinYlSc62KPguAVj/nyHWZ/tAJTCWOWD3JXFugWH45ft2U4/AThSECKltFU7RFVwS8Hp268ukPWjijvYX2mzhpqu/E4g8ovgvHQz5SArdN6iY9+wpqSmyvQzKzkuAEHFvNepT6fNH1cyzzXxC/MHnRJ/nb/z2lxvCups77jxL5TFJwtjT22O6WVIdWRmE5StP4G2qTvwREgCdaQsGpMY3AMzs2C77LxfgB36LQkDCDkmRz41i1v5QNKPWqrIa3ITibrpY6OEvCfkakARiugswKOButA1toMSurVMz10gE6NwnhXb2QGYQLpZm88jNewAYOk8BkCDf0cyu//jTan+nLvbf4Cb63E1+/XNETcOlEAKLzrDRaWHB4TCsu0gAxys1HR+aJfXIuh8AeKneWLOsmwQOXEPUrKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(4326008)(66476007)(66946007)(66556008)(6486002)(8676002)(54906003)(478600001)(316002)(8936002)(83380400001)(6506007)(53546011)(6512007)(26005)(2616005)(7416002)(3450700001)(5660300002)(2906002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWtTT1B1UDZVTTFvRUdxMnYrdUN0RStKQ1puWTNTUG5CWHY3UlN3eFpzMEVV?=
 =?utf-8?B?Y3doa0tYdGcyUllsOE9MSW5pRHZCc2ZjdXZXN0xqRjBMK0RJWDNKeG5HeFZM?=
 =?utf-8?B?OGVtTm5xa0Zqd24xVmtXdmJ6dDJLRjNEMTI4Zmx3TG9lSjlZdGdMMnA1R2lN?=
 =?utf-8?B?VXNNYSs1L3MwQUdjVVJ2MnBLZDVaVmk5UUpMRWI2dG5VaGI0eWVhZExiWk9T?=
 =?utf-8?B?UGl0QW5ydEhISjBoUFg2cDAxQk5qMHdua1FoNVkybjg2amJUbXg0SHpUckEw?=
 =?utf-8?B?SmNMMW44R2RVVTRPUVhNb2tsQTEyL1o2T2VzdkdsQkkvWW40dlFwZ2Z4MEdJ?=
 =?utf-8?B?b1lRTXlxUi8vZFFUK0VKeDdjNmdvN3Y2NTZOZXZNWE1pUnpjQ1VlcXNLelY4?=
 =?utf-8?B?OXBYR1k3ak1hY3IvNDBPTGQwOGZZZE1tSmtnOTJLT2tsL3ExRnRCblVxK0NZ?=
 =?utf-8?B?akpUZWIyY1FkK1R6QVhvSGFVM3BkTmdhSXFFTmJidGE3eEV4Q0ltemFaclRY?=
 =?utf-8?B?VktIUy80RUQxTlk1bnRpNkdHendZK2pHUHlWMkdEa3FWdlBkcEwrZEszTW9B?=
 =?utf-8?B?VTI1N3lScDI3SDlGNWpUeVp1RlVVY0NvSVh6ZWpWZ254S0NkTERwTkpnWGhT?=
 =?utf-8?B?a0tKb3E2QmpHK2VKdXFSOU9GeEtGeXljOGk5RnNLbXhPWjRmekdjaWNDY29V?=
 =?utf-8?B?M21HS1RoclBMZnB6Nmd1dUVreFNiMzQwckZ0Ry9tWTZhTHA2M2F0SjZxMnZN?=
 =?utf-8?B?c3pHSEROa3RlTzBZbzNGcy80cFcwSlJndG9ReWtpU1g2U3lVWVRkQmVPbWZZ?=
 =?utf-8?B?YXZtd0dlaDVCdnhzR2M2MEhPdUg3MFZCQzVZVlA2dDZ2Q1prT0JGKzQ3Umdx?=
 =?utf-8?B?dWx2cVVGazVndGFvYUQ5UDFaWTJhVWZXQVZVdzBIeTBlV0ZkalArR2lvM0ZK?=
 =?utf-8?B?Y1QyNkVSMjhZZmR4RDNLWW1Rcmw3ek8xZFdrV2tOTEMrZnNkbEtSem40YnlN?=
 =?utf-8?B?N2c1UkNncUVyaHVadzM2Q1lab05haE4yaVFhUzZZeUY1UEE5MEVHcFNNYk5a?=
 =?utf-8?B?VjZnMVdNUWNTOW9qcFJrUzJNM256NUE1ZzlSVTdOKzA2REdVN1lLaExGNENT?=
 =?utf-8?B?dThWcmlLRXVjTmE0RXNaT0ErUXh6Y1dLdmxDb2lCbldFa2VRcHBZTm53TGNG?=
 =?utf-8?B?QlFYVkk1S05KQmoxWWxXYVlnck1kc0RBTXg2UEVoZ2tQYi94ZEV6Q3pNdzhi?=
 =?utf-8?B?MW5OdjhNdVVFM3Znbmp4dkxPaDlaa2RDWEFVc1RFd3FTcGZNQ3huMFc4USt6?=
 =?utf-8?B?RUlzTEpoM3ZVM0hyTllZdlZFV0RDUGwvckxLNS9UbmNESWJwNkFoQTlrV1Jq?=
 =?utf-8?B?QTZPQ1ZkK0hORWFmMkk2WmZFbGNVdHlaR1JFRHNWQVFOOTU5M1UycHdVdFlZ?=
 =?utf-8?B?TGJlcjBuTDhYZEF5QU91S2hXK1dyS3VHRWhWWFE4RGF4cG05eGpUWkFWR25S?=
 =?utf-8?B?VU9JSkU1aWpoaVNpVTRpOUZwSm0zeW5vcDVrUUZLbWp5V245dU1KbmhGaFM0?=
 =?utf-8?B?c0R3UG9VWjFFRGxvbVFKTWErTGVpaXNsRkZCbE1oL1JQam9pb00waGNpZUpw?=
 =?utf-8?B?V05Yb2gxN3ZBZkk0QkcvUXhTTEFMdVp3SFFrY2kvUDdBeXZrYzU4dG9BUU1t?=
 =?utf-8?B?bVRuckttbSthVTNxamYzNWFLL1FlSzd5TkFwcEI4eFYvVUhtQXhkZ2hvRDk0?=
 =?utf-8?B?YWU3VFJqMlIwQW5PUXcvQjk3Ti94MXNYYWw2Nlh5R2Q3K3VCczFWRHFQTTF0?=
 =?utf-8?B?MEVTQ0d5ZnUxUnpJTVlEUFR4MEdsWVFRSmZ5TEkrbE4xT2Z6MktHVlJ3Vkc1?=
 =?utf-8?B?akoraFFtbFBFdVBrOVlvTzJPYklDOWp5a0E3ckdIRllQYk9aSjBlQnBzdmcy?=
 =?utf-8?B?RFFyYlZ4K3hyL1hUVVZodHQxMEc4TWU3ZDY4UmZFMXZiajJPT2JuNGsydmZl?=
 =?utf-8?B?bFZoZXdtZHl5aW42aG5qYUFabExGc3YwVUVMdW00NThTb0hFM0lrRWpHNjN3?=
 =?utf-8?B?YjZCT0NKTkFMMVZaZmJSTjA0cVVuQjdwdG1VOXZBNkcvQVVyQzdYOVlPWncz?=
 =?utf-8?Q?nB6M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31283422-a61e-4d7a-8d8d-08dc0c943d86
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 19:43:20.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIUE25UQkDrWHDpAznYKPrULXCpiY+1eGRecdoJ1s+YY9REZKsL42ZqBRuvoFm/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813



On 12/15/23 11:43, James Morse wrote:
> Intel is blessed with an abundance of monitors, one per RMID, that can be
> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
> the number implemented is up to the manufacturer. This means when there are
> fewer monitors than needed, they need to be allocated and freed.
> 
> MPAM's CSU monitors are used to back the 'llc_occupancy' monitor file. The
> CSU counter is allowed to return 'not ready' for a small number of
> micro-seconds after programming. To allow one CSU hardware monitor to be
> used for multiple control or monitor groups, the CPU accessing the
> monitor needs to be able to block when configuring and reading the
> counter.
> 
> Worse, the domain may be broken up into slices, and the MMIO accesses
> for each slice may need performing from different CPUs.
> 
> These two details mean MPAMs monitor code needs to be able to sleep, and
> IPI another CPU in the domain to read from a resource that has been sliced.
> 
> mon_event_read() already invokes mon_event_count() via IPI, which means
> this isn't possible. On systems using nohz-full, some CPUs need to be
> interrupted to run kernel work as they otherwise stay in user-space
> running realtime workloads. Interrupting these CPUs should be avoided,
> and scheduling work on them may never complete.
> 
> Change mon_event_read() to pick a housekeeping CPU, (one that is not using
> nohz_full) and schedule mon_event_count() and wait. If all the CPUs
> in a domain are using nohz-full, then an IPI is used as the fallback.
> 
> This function is only used in response to a user-space filesystem request
> (not the timing sensitive overflow code).
> 
> This allows MPAM to hide the slice behaviour from resctrl, and to keep
> the monitor-allocation in monitor.c. When the IPI fallback is used on
> machines where MPAM needs to make an access on multiple CPUs, the counter
> read will always fail.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v2:
>  * Use cpumask_any_housekeeping() and fallback to an IPI if needed.
> 
> Changes since v3:
>  * Actually include the IPI fallback code.
> 
> Changes since v4:
>  * Tinkered with existing capitalisation.
> 
> Changes since v5:
>  * Added a newline.
> 
> Changes since v6:
>  * Moved lockdep annotations to a later patch.
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 26 +++++++++++++++++++++--
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index beccb0e87ba7..d07f99245851 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -19,6 +19,8 @@
>  #include <linux/kernfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> +#include <linux/tick.h>
> +
>  #include "internal.h"
>  
>  /*
> @@ -522,12 +524,21 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int smp_mon_event_count(void *arg)
> +{
> +	mon_event_count(arg);
> +
> +	return 0;
> +}
> +
>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first)
>  {
> +	int cpu;
> +
>  	/*
> -	 * setup the parameters to send to the IPI to read the data.
> +	 * Setup the parameters to pass to mon_event_count() to read the data.
>  	 */
>  	rr->rgrp = rdtgrp;
>  	rr->evtid = evtid;
> @@ -536,7 +547,18 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	rr->val = 0;
>  	rr->first = first;
>  
> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask);
> +
> +	/*
> +	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
> +	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
> +	 * MPAM's resctrl_arch_rmid_read() is unable to read the
> +	 * counters on some platforms if its called in irq context.
> +	 */
> +	if (tick_nohz_full_cpu(cpu))
> +		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	else
> +		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
>  }
>  
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 8737a9d6caef..7e81268137b0 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -588,7 +588,7 @@ static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
>  }
>  
>  /*
> - * This is called via IPI to read the CQM/MBM counters
> + * This is scheduled by mon_event_read() to read the CQM/MBM counters
>   * on a domain.
>   */
>  void mon_event_count(void *info)

-- 
Thanks
Babu Moger

