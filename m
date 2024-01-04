Return-Path: <linux-kernel+bounces-16284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7067823C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D04B21937
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DDB1BDDB;
	Thu,  4 Jan 2024 06:26:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0901CA97
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1704349605-1eb14e0c7d0f330001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id RGkaLamIqvszrLYd (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 04 Jan 2024 14:26:45 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 4 Jan
 2024 14:26:45 +0800
Received: from [10.32.65.162] (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 4 Jan
 2024 14:26:43 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <8cae91d2-81d8-4d06-8e4b-c2c227f4eac9@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.162
Date: Thu, 4 Jan 2024 14:26:36 +0800
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
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<mcgrof@kernel.org>, <peterz@infradead.org>, <j.granados@samsung.com>,
	<ricardo.neri-calderon@linux.intel.com>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>, <LindaChai@zhaoxin.com>
References: <20231228075705.26652-1-TonyWWang-oc@zhaoxin.com>
 <20231228075705.26652-4-TonyWWang-oc@zhaoxin.com>
 <CAJZ5v0hEd-NV5WoRPOZgZwxNS6M=TKcw7DpDUM9MWFYAaa+1Mw@mail.gmail.com>
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <CAJZ5v0hEd-NV5WoRPOZgZwxNS6M=TKcw7DpDUM9MWFYAaa+1Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1704349605
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5179
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.118962
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------


On 2024/1/3 23:37, Rafael J. Wysocki wrote:
> On Thu, Dec 28, 2023 at 8:57 AM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
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
>>          return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>>   }
>> +
>> +/* The work item is needed to avoid CPU hotplug locking issues */
>> +static void sched_itmt_work_fn(struct work_struct *work)
>> +{
>> +       sched_set_itmt_support();
>> +}
>> +
>> +static DECLARE_WORK(sched_itmt_work, sched_itmt_work_fn);
>> +
>> +static void set_itmt_prio(int cpu)
>> +{
>> +       static bool cppc_highest_perf_diff;
>> +       static struct cpumask core_prior_mask;
>> +       u64 highest_perf;
>> +       static u64 max_highest_perf = 0, min_highest_perf = U64_MAX;
>> +       int ret;
>> +
>> +       ret = cppc_get_highest_perf(cpu, &highest_perf);
>> +       if (ret)
>> +               return;
>> +
>> +       sched_set_itmt_core_prio(highest_perf, cpu);
>> +       cpumask_set_cpu(cpu, &core_prior_mask);
>> +
>> +       if (max_highest_perf <= min_highest_perf) {
>> +               if (highest_perf > max_highest_perf)
>> +                       max_highest_perf = highest_perf;
>> +
>> +               if (highest_perf < min_highest_perf)
>> +                       min_highest_perf = highest_perf;
>> +
>> +               if (max_highest_perf > min_highest_perf) {
>> +                       /*
>> +                        * This code can be run during CPU online under the
>> +                        * CPU hotplug locks, so sched_set_itmt_support()
>> +                        * cannot be called from here.  Queue up a work item
>> +                        * to invoke it.
>> +                        */
>> +                       cppc_highest_perf_diff = true;
>> +               }
>> +       }
>> +
>> +       if (cppc_highest_perf_diff && cpumask_equal(&core_prior_mask, cpu_online_mask)) {
>> +               pr_debug("queue a work to set itmt enabled\n");
>> +               schedule_work(&sched_itmt_work);
>> +       }
>> +}
>>   #else
>>   static inline u64 get_max_boost_ratio(unsigned int cpu) { return 0; }
>> +static void set_itmt_prio(int cpu) { }
>>   #endif
>>
>>   static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>> @@ -677,7 +725,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>          unsigned int valid_states = 0;
>>          unsigned int result = 0;
>>          u64 max_boost_ratio;
>> -       unsigned int i;
>> +       unsigned int i, j;
>>   #ifdef CONFIG_SMP
>>          static int blacklisted;
>>   #endif
>> @@ -742,6 +790,12 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>          }
>>   #endif
>>
>> +       if (c->x86_vendor == X86_VENDOR_CENTAUR || c->x86_vendor == X86_VENDOR_ZHAOXIN) {
>> +               for_each_cpu(j, policy->cpus) {
>> +                       set_itmt_prio(j);
>> +               }
>> +       }
>> +
>>          /* capability check */
>>          if (perf->state_count <= 1) {
>>                  pr_debug("No P-States\n");
>> --
> Have you considered using the CPPC cpufreq driver on those platforms?


Thanks for your reply.
The ACPI cpufreq driver is used by default on Zhaoxin platforms. We added
Zhaoxin preferred core support and did related tests based on the ACPI
cpufreq driver.
The CPPC cpufreq driver is currently used on the ARM platforms. We have
not yet considered using the CPPC cpufreq driver to support the Zhaoxin
preferred core feature, and we also unclear how well the CPPC cpufreq
driver works for the X86 platform.
At the moment, it seems that it is more appropriate to add Zhaoxin preferred
core support to the ACPI cpufreq Driver.

Sincerely
TonyWWangoc


