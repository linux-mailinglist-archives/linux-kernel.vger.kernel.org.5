Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1BA753B73
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbjGNNEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjGNNEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:04:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88FB30EB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:04:31 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ECpSHr008314;
        Fri, 14 Jul 2023 13:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=w4+geHdkTt4xjZYuWRIlwjfLArPn3uNucukI3vFimTY=;
 b=Xr/2cIuQLr64hlZaMYNC7qVnwWSSbxE4lKXvTNtEIFaLoMvqhf+LafVTCnVOXdaH82CJ
 tZ//VNS/QVSZ17ylxffOV407c7WEK09ehb66UTRbg82YIFRV3Y3ReI/UMztBl7v4Cl8p
 /BrGGaRRDNy4DBcm6tRc24Riny2UuZsm/dh509AEN5KdzNUdlVG4kuDjMr4YotGLAVE+
 0YrZf1uoE2CbsbErV9+BWmjvy0QPsOSyD03FzCz82PDrAh8k/AwWs+clt5UGFKCNCz9G
 iojWQoE7w88GmIQ8LIn7e+UBLW5/nymPu9Wm+711Txbgz75cl0Yyp1/8jsZ3JsBSSpCx UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru6r3gbb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 13:03:08 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36ECqnlH013901;
        Fri, 14 Jul 2023 13:03:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru6r3gba2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 13:03:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36E87bjD019663;
        Fri, 14 Jul 2023 13:03:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rtpvth89h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 13:03:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36ED35bo8389362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 13:03:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE52A58061;
        Fri, 14 Jul 2023 13:03:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5FD65805A;
        Fri, 14 Jul 2023 13:02:53 +0000 (GMT)
Received: from [9.171.88.96] (unknown [9.171.88.96])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 13:02:53 +0000 (GMT)
Message-ID: <29f8bc23-9b17-0a21-baa5-3eee1322f8f0@linux.vnet.ibm.com>
Date:   Fri, 14 Jul 2023 18:32:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch v3 4/6] sched/fair: Consider the idle state of the whole
 core for load balance
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>,
        shrikanth hegde <sshegde@linux.vnet.ibm.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <807bdd05331378ea3bf5956bda87ded1036ba769.1688770494.git.tim.c.chen@linux.intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <807bdd05331378ea3bf5956bda87ded1036ba769.1688770494.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yfAd4jSDSsgD_t4mn1zOjBysiNfei-QK
X-Proofpoint-ORIG-GUID: R-OTjWATuO2x6Kx-TX0kBSQU06kRryVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/23 4:27 AM, Tim Chen wrote:
> From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> should_we_balance() traverses the group_balance_mask (AND'ed with lb_env::
> cpus) starting from lower numbered CPUs looking for the first idle CPU.
> 
> In hybrid x86 systems, the siblings of SMT cores get CPU numbers, before
> non-SMT cores:
> 
> 	[0, 1] [2, 3] [4, 5] 6 7 8 9
>          b  i   b  i   b  i  b i i i
> 
> In the figure above, CPUs in brackets are siblings of an SMT core. The
> rest are non-SMT cores. 'b' indicates a busy CPU, 'i' indicates an
> idle CPU.
> 
> We should let a CPU on a fully idle core get the first chance to idle
> load balance as it has more CPU capacity than a CPU on an idle SMT
> CPU with busy sibling.  So for the figure above, if we are running
> should_we_balance() to CPU 1, we should return false to let CPU 7 on
> idle core to have a chance first to idle load balance.
> 
> A partially busy (i.e., of type group_has_spare) local group with SMT 
> cores will often have only one SMT sibling busy. If the destination CPU
> is a non-SMT core, partially busy, lower-numbered, SMT cores should not
> be considered when finding the first idle CPU. 
> 
> However, in should_we_balance(), when we encounter idle SMT first in partially
> busy core, we prematurely break the search for the first idle CPU.
> 
> Higher-numbered, non-SMT cores is not given the chance to have
> idle balance done on their behalf. Those CPUs will only be considered
> for idle balancing by chance via CPU_NEWLY_IDLE.
> 
> Instead, consider the idle state of the whole SMT core.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f491b94908bf..294a662c9410 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10729,7 +10729,7 @@ static int active_load_balance_cpu_stop(void *data);
>  static int should_we_balance(struct lb_env *env)
>  {
>  	struct sched_group *sg = env->sd->groups;
> -	int cpu;
> +	int cpu, idle_smt = -1;
> 
>  	/*
>  	 * Ensure the balancing environment is consistent; can happen
> @@ -10756,10 +10756,24 @@ static int should_we_balance(struct lb_env *env)
>  		if (!idle_cpu(cpu))
>  			continue;
> 
> +		/*
> +		 * Don't balance to idle SMT in busy core right away when
> +		 * balancing cores, but remember the first idle SMT CPU for
> +		 * later consideration.  Find CPU on an idle core first.
> +		 */
> +		if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
> +			if (idle_smt == -1)
> +				idle_smt = cpu;
> +			continue;
> +		}
> +
>  		/* Are we the first idle CPU? */
>  		return cpu == env->dst_cpu;
>  	}
> 
> +	if (idle_smt == env->dst_cpu)
> +		return true;


This is nice. It helps in reducing the migrations and improve the performance 
of CPU oriented benchmarks slightly. This could be due to less migrations. 

Tested a bit on power10 with SMT=4. Offlined a CPU to make a few cores SMT=1. There is 
no regression observed. Slight improvement in throughput oriented workload such as stress-ng. 
migrations are reduced by quite a bit, likely due to patch. I have attached the test results there.
[4/6] sched/fair: Consider the idle state of the whole core for load balance

Test results: 

# lscpu
Architecture:            ppc64le
  Byte Order:            Little Endian
CPU(s):                  96
  On-line CPU(s) list:   0-17,24,25,32-49,56-89
  Off-line CPU(s) list:  18-23,26-31,50-55,90-95
Model name:              POWER10 (architected), altivec supported

--------------------------------------------------------------------------------------------------
baseline:

 Performance counter stats for 'stress-ng --cpu=72 -l 50 --cpu-ops=100000 --cpu-load-slice=1' (5 runs):

        260,813.13 msec task-clock                #   33.390 CPUs utilized            ( +-  0.10% )
            42,535      context-switches          #  163.543 /sec                     ( +-  0.13% )
             9,060      cpu-migrations            #   34.835 /sec                     ( +-  1.07% )
            12,947      page-faults               #   49.780 /sec                     ( +-  1.76% )
   948,061,954,432      cycles                    #    3.645 GHz                      ( +-  0.09% )
   926,045,701,578      instructions              #    0.98  insn per cycle           ( +-  0.00% )
   146,418,075,496      branches                  #  562.964 M/sec                    ( +-  0.00% )
     1,197,661,965      branch-misses             #    0.82% of all branches          ( +-  0.17% )

            7.8111 +- 0.0162 seconds time elapsed  ( +-  0.21% )

 Performance counter stats for 'stress-ng --cpu=60 -l 50 --cpu-ops=100000 --cpu-load-slice=1' (5 runs):

        253,351.70 msec task-clock                #   28.207 CPUs utilized            ( +-  0.21% )
            41,046      context-switches          #  162.828 /sec                     ( +-  0.16% )
             6,674      cpu-migrations            #   26.475 /sec                     ( +-  3.42% )
            10,879      page-faults               #   43.157 /sec                     ( +-  1.68% )
   931,014,218,983      cycles                    #    3.693 GHz                      ( +-  0.22% )
   919,717,564,454      instructions              #    0.99  insn per cycle           ( +-  0.00% )
   145,480,596,331      branches                  #  577.116 M/sec                    ( +-  0.00% )
     1,175,362,979      branch-misses             #    0.81% of all branches          ( +-  0.12% )

            8.9818 +- 0.0288 seconds time elapsed  ( +-  0.32% )


---------------------------------------------------------------------------------------------------
with patch:

 Performance counter stats for 'stress-ng --cpu=72 -l 50 --cpu-ops=100000 --cpu-load-slice=1' (5 runs):

        254,652.01 msec task-clock                #   33.449 CPUs utilized            ( +-  0.11% )
            40,970      context-switches          #  160.974 /sec                     ( +-  0.10% )
             5,397      cpu-migrations            #   21.205 /sec                     ( +-  2.01% )
            11,705      page-faults               #   45.990 /sec                     ( +-  1.21% )
   911,115,537,080      cycles                    #    3.580 GHz                      ( +-  0.11% )
   925,635,958,489      instructions              #    1.02  insn per cycle           ( +-  0.00% )
   146,450,995,164      branches                  #  575.416 M/sec                    ( +-  0.00% )
     1,188,906,011      branch-misses             #    0.81% of all branches          ( +-  0.28% )

            7.6132 +- 0.0381 seconds time elapsed  ( +-  0.50% )

 Performance counter stats for 'stress-ng --cpu=60 -l 50 --cpu-ops=100000 --cpu-load-slice=1' (5 runs):

        236,962.38 msec task-clock                #   27.948 CPUs utilized            ( +-  0.05% )
            40,030      context-switches          #  168.869 /sec                     ( +-  0.04% )
             3,156      cpu-migrations            #   13.314 /sec                     ( +-  1.37% )
             9,448      page-faults               #   39.857 /sec                     ( +-  1.72% )
   856,444,937,794      cycles                    #    3.613 GHz                      ( +-  0.06% )
   919,459,795,805      instructions              #    1.07  insn per cycle           ( +-  0.00% )
   145,654,799,033      branches                  #  614.452 M/sec                    ( +-  0.00% )
     1,177,464,719      branch-misses             #    0.81% of all branches          ( +-  0.23% )

            8.4788 +- 0.0323 seconds time elapsed  ( +-  0.38% )
--------------------------------------------------------------------------------------------------------

Tried on a symmetric system with all cores having SMT=4 as well. There was reduction in migrations here as well.
Didnt observe any major regressions when microbenchmarks run alone. Such as hackbench, stress-ng. 

So. Here is tested-by. 
Tested-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>



> +
>  	/* Are we the first CPU of this group ? */
>  	return group_balance_cpu(sg) == env->dst_cpu;
>  }

One doubt though, Here a fully idle core would be chosen instead of first idle cpu in the 
group (if there is one). Since coming out of idle of SMT is faster compared to a fully idle core,
would latency increase? Or that concerns mainly wakeup path?
