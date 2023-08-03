Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B04476DF5D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 06:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHCETT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 00:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHCETR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 00:19:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141D5106;
        Wed,  2 Aug 2023 21:19:16 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3733fUsG008805;
        Thu, 3 Aug 2023 04:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=JPtysfcS0AIfNUZpM9ssd0qH1kDBkP2CB3k8ROMb0H4=;
 b=IbpFA0NSIYV2M4rubBeo3FwYMMGeSIXDtV1C2vYq2v9236a7GOC/SDq4qgHsSj8MRuoK
 AdZoYK8/3xn7xHGeclinuwpDhgIqez3ZzpVa1rfmEh5/Vd8iFnWkvEy0r8ldoXEzOefG
 qiOwuyKwUkKx+LgngUnsv9pcU31CwMxZsslbSTaAnFrBVlEEpLI2nzdGPkb+ymI2jjcZ
 ZCEhRFDP06la07bM29GfSRAmf/NC3DrgT2p2X46dyfH1B25tb3F5CjTeFLRBqjNlILbB
 PehSVGZv//xqtQLUhOm5OuN3gAvSXtxE1Tx2CMW9RkQU/57pEExEqG6jsvkZKPJy0Ngd kQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7sgnh8u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 04:18:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3734Ik2O026084
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 04:18:46 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 21:18:40 -0700
Date:   Thu, 3 Aug 2023 09:48:37 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     David Dai <davidai@google.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Marc Zyngier" <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, <kernel-team@android.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <80f47262-9354-472f-8122-5ae262c0a46d@quicinc.com>
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-3-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731174613.4133167-3-davidai@google.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g3g7Xtp3J-PsThVbTzWOpXLknSgYYInr
X-Proofpoint-GUID: g3g7Xtp3J-PsThVbTzWOpXLknSgYYInr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_01,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:46:09AM -0700, David Dai wrote:
> Introduce a virtualized cpufreq driver for guest kernels to improve
> performance and power of workloads within VMs.
> 
> This driver does two main things:
> 
> 1. Sends the frequency of vCPUs as a hint to the host. The host uses the
> hint to schedule the vCPU threads and decide physical CPU frequency.
> 
> 2. If a VM does not support a virtualized FIE(like AMUs), it queries the
> host CPU frequency by reading a MMIO region of a virtual cpufreq device
> to update the guest's frequency scaling factor periodically. This enables
> accurate Per-Entity Load Tracking for tasks running in the guest.
> 
> Co-developed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: David Dai <davidai@google.com>

[...]

> +static void virt_scale_freq_tick(void)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(smp_processor_id());
> +	struct virt_cpufreq_drv_data *data = policy->driver_data;
> +	u32 max_freq = (u32)policy->cpuinfo.max_freq;
> +	u64 cur_freq;
> +	u64 scale;
> +
> +	cpufreq_cpu_put(policy);
> +
> +	cur_freq = (u64)data->ops->get_freq(policy);
> +	cur_freq <<= SCHED_CAPACITY_SHIFT;
> +	scale = div_u64(cur_freq, max_freq);
> +
> +	this_cpu_write(arch_freq_scale, (unsigned long)scale);
> +}
> +

We expect the host to provide the frequency in kHz, can you please add a
comment about it. It is not very obvious when you look at the
REG_CUR_FREQ_OFFSET register name.

> +static struct scale_freq_data virt_sfd = {
> +	.source = SCALE_FREQ_SOURCE_VIRT,
> +	.set_freq_scale = virt_scale_freq_tick,
> +};
> +
> +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy)
> +{
> +	struct virt_cpufreq_drv_data *data = policy->driver_data;
> +	/*
> +	 * Use cached frequency to avoid rounding to freq table entries
> +	 * and undo 25% frequency boost applied by schedutil.
> +	 */
> +	u32 freq = mult_frac(policy->cached_target_freq, 80, 100);
> +
> +	data->ops->set_freq(policy, freq);
> +	return 0;
> +}

Why do we undo the frequency boost? A governor may apply other boosts
like RT (uclamp), iowait. It is not clear why we need to worry about
governor policies here.

> +
> +static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy *policy,
> +		unsigned int target_freq)
> +{
> +	virt_cpufreq_set_perf(policy);
> +	return target_freq;
> +}
> +
> +static int virt_cpufreq_target_index(struct cpufreq_policy *policy,
> +		unsigned int index)
> +{
> +	return virt_cpufreq_set_perf(policy);
> +}
> +
> +static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct virt_cpufreq_drv_data *drv_data = cpufreq_get_driver_data();
> +	struct cpufreq_frequency_table *table;
> +	struct device *cpu_dev;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	ret = dev_pm_opp_of_add_table(cpu_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (ret <= 0) {
> +		dev_err(cpu_dev, "OPP table can't be empty\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &table);
> +	if (ret) {
> +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> +		return ret;
> +	}
> +
> +	policy->freq_table = table;
> +	policy->dvfs_possible_from_any_cpu = false;
> +	policy->fast_switch_possible = true;
> +	policy->driver_data = drv_data;
> +
> +	/*
> +	 * Only takes effect if another FIE source such as AMUs
> +	 * have not been registered.
> +	 */
> +	topology_set_scale_freq_source(&virt_sfd, policy->cpus);
> +
> +	return 0;
> +
> +}
> +

Do we need to register as FIE source even with the below commit? By
registering as a source, we are not supplying any accurate metric. We
still fallback on the same source that cpufreq implements it.

874f63531064 ("cpufreq: report whether cpufreq supports Frequency
Invariance (FI)")

Thanks,
Pavan
