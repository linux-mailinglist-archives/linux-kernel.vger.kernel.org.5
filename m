Return-Path: <linux-kernel+bounces-33908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A541B83701C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C820E1C2934B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962161E481;
	Mon, 22 Jan 2024 18:07:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121171EF01
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946859; cv=none; b=GqL2s9Id8emz/O5aEZ5JlTTKjfdlvjcv7WnLTMod+H9xpI0jEUDu1t6SD/MpeR4CDgwxbUgABRXu5wfJFE1cYUZcwov/wfIgqfxVw7jbXv2mgj5xeChyo9glVOKW5cIdnQ20QZKbBkHUQYH5JIk37PrqaBKh0iF1ReznpvuSWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946859; c=relaxed/simple;
	bh=a1V8nMlLGuaoXYkm95iLtidMc039ORpQ5I8LW9TY0OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYZ9XiYJ1tOswjmLa7SFrqfdc5lxGdzHhXJXA9LdYbHAsm3c1C9Us3Mvv3s5g26ZIgy1qkl2CojhynkcznEcTm+buFbRyR5IlPPTsJ5aJxAbtsHHxviYxes8phT0QC5buowdtPUY8V/lwhyiRE6kvbv6GdSVa+CmpkEfIHmormI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA7E61474;
	Mon, 22 Jan 2024 10:08:22 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 352643F5A1;
	Mon, 22 Jan 2024 10:07:34 -0800 (PST)
Message-ID: <b1f38afc-2dc6-5663-393f-4c1a4b4e2ac8@arm.com>
Date: Mon, 22 Jan 2024 18:07:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXT] [PATCH v7 06/24] x86/resctrl: Access per-rmid structures by
 index
Content-Language: en-GB
To: Amit Singh Tomar <amitsinght@marvell.com>, "x86@kernel.org"
 <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
 Linu Cherian <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "muhammad.zahid@nokia.com" <muhammad.zahid@nokia.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-7-james.morse@arm.com>
 <MW4PR18MB5084AC18E19386E5B83C0F0EC6A0A@MW4PR18MB5084.namprd18.prod.outlook.com>
 <27ddb859-a67e-9a9d-7135-c4829c5b27db@arm.com>
 <MW4PR18MB5084D16A8BE24416D05F8853C6762@MW4PR18MB5084.namprd18.prod.outlook.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <MW4PR18MB5084D16A8BE24416D05F8853C6762@MW4PR18MB5084.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Amit,

On 21/01/2024 10:27, Amit Singh Tomar wrote:
> -----Original Message-----
> From: James Morse <james.morse@arm.com> 
> Sent: Monday, December 11, 2023 8:03 PM
> To: Amit Singh Tomar <amitsinght@marvell.com>; x86@kernel.org; linux-kernel@vger.kernel.org
> Cc: Fenghua Yu <fenghua.yu@intel.com>; Reinette Chatre <reinette.chatre@intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H Peter Anvin <hpa@zytor.com>; Babu Moger <Babu.Moger@amd.com>; shameerali.kolothum.thodi@huawei.com; D Scott Phillips OS <scott@os.amperecomputing.com>; carl@os.amperecomputing.com; Linu Cherian <lcherian@marvell.com>; bobo.shaobowang@huawei.com; tan.shaopeng@fujitsu.com; baolin.wang@linux.alibaba.com; Jamie Iles <quic_jiles@quicinc.com>; Xin Hao <xhao@linux.alibaba.com>; peternewman@google.com; dfustini@baylibre.com; muhammad.zahid@nokia.com
> Subject: Re: [EXT] [PATCH v7 06/24] x86/resctrl: Access per-rmid structures by index

> On 31/10/2023 07:43, Amit Singh Tomar wrote:
>> -----Original Message-----
>> From: James Morse <james.morse@arm.com>
>> Sent: Wednesday, October 25, 2023 11:33 PM
>> Subject: [EXT] [PATCH v7 06/24] x86/resctrl: Access per-rmid 
>> structures by index

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c 
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 2a0233cd0bc9..c02cf32cd17c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -735,19 +768,20 @@ void mbm_setup_overflow_handler(struct 
>> rdt_domain *dom, unsigned long delay_ms)
>>  
>>  static int dom_data_init(struct rdt_resource *r)  {
>> +	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>>  	struct rmid_entry *entry = NULL;
>> -	int i, nr_rmids;
>> +	u32 idx;
>> +	int i;
>>  
>> -	nr_rmids = r->num_rmid;
>> -	rmid_ptrs = kcalloc(nr_rmids, sizeof(struct rmid_entry), GFP_KERNEL);
>> +	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), 
>> +GFP_KERNEL);
>>
>> [>>] Is there a chance, it could result in "ZERO_SIZE_PTR", and we should guard it against ZERO_OR_NULL_PTR in the following if condition?
>>         It might be related, while testing the snapshot[1] (and subsequent snapshots has similar change) on x86 platform, Zahid is seeing Kernel panic:
>>         
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pu
>> b_scm_linux_kernel_git_morse_linux.git_tree_fs_resctrl_monitor.c-3Fh-3
>> Dmpam_snapshot_v6.2-23n695&d=DwICaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jR
>> uCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=yHcjuc1ZrYfPWXGxTPifeglinf_gMfy
>> AgnvZfOw-ZD2zRG8G61IfH8hignwaxlV6&s=X3Ie_NqTHtzN2ttkl3yiTYHzNpkWW2wPPI
>> DJ7XTWW40&e=
> 
> Interesting - I didn't think this could happen. Could you share the full splat?


(this bit here is your reply?:)

> Unfortunately, I don't have  access to the test set-up where this splat has been observed.
> However, I have requested Zahid (Cc) to provide the splat logs.
> Additionally, from what I've learned, this splat has been observed on an x86 machine that
> doesn't support monitor groups. Do you see this as problem?



> This would imply idx_limit was zero, so boot_cpu_data.x86_cache_max_rmid would be -1.
> But wouldn't this happen before this patch? idx_limit has the same value as nr_rmids on x86,
> its only MPAM that needs a different value.

Your 'doesn't support monitor groups' explains why boot_cpu_data.x86_cache_max_rmid is -1.

As you've said you're testing the whole tree - not this series, I suspect this is coming
from "x86/resctrl: Move monitor init work to a resctrl init call", which moves
initialisation of filesystem structures to filesystem code.

It looks like I missed that get_rdt_mon_resources() can bale out before calling
rdt_get_mon_l3_config(), which I think would explain what you hint at here.


Adding this to the "x86/resctrl: Move monitor init work to a resctrl init call" should fix
that. (It'll be in the next snapshot I push)
---------------------%<---------------------
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index b3f245c85e00..791554db7c69 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1030,12 +1030,14 @@ int resctrl_mon_resource_init(void)
        struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
        int ret;

+       if (!r->mon_capable)
+               return 0;
+
        ret = dom_data_init(r);
        if (ret)
                return ret;

-       if (r->mon_capable)
-               l3_mon_evt_init(r);
+       l3_mon_evt_init(r);

        return 0;
 }
---------------------%<---------------------


Thanks,

James

