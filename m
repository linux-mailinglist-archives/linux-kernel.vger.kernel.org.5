Return-Path: <linux-kernel+bounces-46273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39321843DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F1FB25C15
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C606BB26;
	Wed, 31 Jan 2024 10:55:35 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7E69DFD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698535; cv=none; b=C+uSXEAAKb2tZ+BgGuRArmhE1RpFpAas/Ycf2g3eI5K7rwIc3Zno7hGBKTNc4wNZWj0/pnTB6320ZGA2TjQrGO8Dm8BJCMYzzketWG4NdUBOwZf73HFZk6WK4YKmBC/jsjUTV+O4tCIzpOJ1IhZ3RcoDeMsTqLYzi6yBRVJNTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698535; c=relaxed/simple;
	bh=aG8P/MkBiA/Gv0nPUKkQbjHE1IRLe9SjeeOS0X57tks=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eoQdS5wAAPsPkD99Iqe3xMaUUGCIEES6MdzrX5+e0Vxt3BOUXTKiV7VKXKbLo/gLeOobKq/Z4k6W4uxQVFVYZhH15YNkFGPHPmWHbzHCkaAnZZx1TZ5861rlk1MMTWrPrbzo9f5u6k2fY1uDGF16wtz8WGeNZg12ibiemvRc6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1706698529-1eb14e0c7e326a0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id YFLiBZ57oHCTKoq5 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 31 Jan 2024 18:55:29 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 31 Jan
 2024 18:55:29 +0800
Received: from [10.32.57.248] (10.32.57.248) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 31 Jan
 2024 18:55:26 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <7f869bc1-9129-48b2-b0fd-483c790a8d1b@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.57.248
Date: Wed, 31 Jan 2024 18:55:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC enabled for
 Zhaoxin CPUs
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC enabled for
 Zhaoxin CPUs
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <mcgrof@kernel.org>, <peterz@infradead.org>,
	<j.granados@samsung.com>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>, <LindaChai@zhaoxin.com>
References: <20231228075705.26652-1-TonyWWang-oc@zhaoxin.com>
 <20231228075705.26652-4-TonyWWang-oc@zhaoxin.com>
 <20240117225158.GD13777@ranerica-svr.sc.intel.com>
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240117225158.GD13777@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1706698529
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3710
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.120187
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------


On 2024/1/18 06:51, Ricardo Neri wrote:
>
> [这封邮件来自外部发件人]
>
> On Thu, Dec 28, 2023 at 03:57:05PM +0800, Tony W Wang-oc wrote:
>> For Zhaoxin CPUs, the cores' highest frequencies may be different, which
>> means that cores may run at different max frequencies,
>>
>> According to ACPI-spec6 chapter 8.4.7, the per-core highest frequency
>> value can be obtained via cppc.
>>
>> The core with the higher frequency have better performance, which can be
>> called as preferred core. And better performance can be achieved by
>> making the scheduler to run tasks on these preferred cores.
>>
>> The cpufreq driver can use the highest frequency value as the prioriy of
>> core to make the scheduler try to get better performace. More specifically,
>> in the acpi-cpufreq driver use cppc_get_highest_perf() to get highest
>> frequency value of each core, use sched_set_itmt_core_prio() to set
>> highest frequency value as core priority, and use sched_set_itmt_support()
>> provided by ITMT to tell the scheduler to favor on the preferred cores.
>>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> ---
>>   drivers/cpufreq/acpi-cpufreq.c | 56 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 37f1cdf46d29..f4c1ff9e4bb0 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -663,8 +663,56 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>>
>>        return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>>   }
>> +
>> +/* The work item is needed to avoid CPU hotplug locking issues */
>> +static void sched_itmt_work_fn(struct work_struct *work)
>> +{
>> +     sched_set_itmt_support();
>> +}
>> +
>> +static DECLARE_WORK(sched_itmt_work, sched_itmt_work_fn);
>> +
>> +static void set_itmt_prio(int cpu)
>> +{
>> +     static bool cppc_highest_perf_diff;
>> +     static struct cpumask core_prior_mask;
>> +     u64 highest_perf;
>> +     static u64 max_highest_perf = 0, min_highest_perf = U64_MAX;
>> +     int ret;
>> +
>> +     ret = cppc_get_highest_perf(cpu, &highest_perf);
>> +     if (ret)
>> +             return;
>> +
>> +     sched_set_itmt_core_prio(highest_perf, cpu);
>> +     cpumask_set_cpu(cpu, &core_prior_mask);
>> +
>> +     if (max_highest_perf <= min_highest_perf) {
>> +             if (highest_perf > max_highest_perf)
>> +                     max_highest_perf = highest_perf;
>> +
>> +             if (highest_perf < min_highest_perf)
>> +                     min_highest_perf = highest_perf;
>> +
>> +             if (max_highest_perf > min_highest_perf) {
>> +                     /*
>> +                      * This code can be run during CPU online under the
>> +                      * CPU hotplug locks, so sched_set_itmt_support()
>> +                      * cannot be called from here.  Queue up a work item
>> +                      * to invoke it.
>> +                      */
>> +                     cppc_highest_perf_diff = true;
>> +             }
>> +     }
>> +
>> +     if (cppc_highest_perf_diff && cpumask_equal(&core_prior_mask, cpu_online_mask)) {
>> +             pr_debug("queue a work to set itmt enabled\n");
>> +             schedule_work(&sched_itmt_work);
>> +     }
>> +}
> sched_itmt_work and this function is a duplicate of what the intel_pstate
> driver already does. It might be good if consolidate in a single place
> if you are going to pursue this approach.

Thanks for your suggestion, will change the patch code in v2.

Sorry for late.


