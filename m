Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9302B79060B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 10:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351771AbjIBINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 04:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjIBINK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 04:13:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F241170F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 01:13:04 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38288mLB019231;
        Sat, 2 Sep 2023 08:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=Rfyw+V7QrqDJVjNARll09Sp5KpQMjOEzhh9MQKCyTBc=;
 b=GjPM7r4imVDCKY3SumWia4zaCIqUI+eoXU6JuCmQQT10rE5jVb9aPsqzXQPBJ6SATiKF
 AYvHg5b6PhLfZjuxbKcuqYPj3jdTl7t/E/APeWkeZ5cPcSUSNshxE2Pq9fKCQ81wAKkB
 oaKQubO++Q3iwbCmJp+LP6zH/sVXKJRVmxPMpQM65D+AwB9wtMwMJYeBhOMlKr7nAWDS
 JPWGuwFGCWwibxRtyaFzTdETPwFZI+9jgwnTChRbmK0szdy/98W9ln3M7pbw3+NB7vDo
 /eLg368iz2SfvO/I3RynXHnAbkz5KmsHccRsX5tJXW30ydtPJA1z/HqA+PYM64xk9tkd 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sv0vwg9ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Sep 2023 08:12:33 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38289ri6022043;
        Sat, 2 Sep 2023 08:12:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sv0vwg9ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Sep 2023 08:12:33 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3826KqH2014107;
        Sat, 2 Sep 2023 08:12:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxktqmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Sep 2023 08:12:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3828CUDC55509462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 2 Sep 2023 08:12:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A82E020043;
        Sat,  2 Sep 2023 08:12:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5097220040;
        Sat,  2 Sep 2023 08:12:26 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.95.19])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat,  2 Sep 2023 08:12:26 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, yu.c.chen@intel.com,
        ricardo.neri-calderon@linux.intel.com, iamjoonsoo.kim@lge.com,
        tim.c.chen@linux.intel.com, juri.lelli@redhat.com,
        rocking@linux.alibaba.com, joshdon@google.com
Subject: [PATCH] sched/fair: optimize should_we_balance for higher SMT systems
Date:   Sat,  2 Sep 2023 13:42:04 +0530
Message-Id: <20230902081204.232218-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: evHbR5BLbExeCVmqjTt5u5vxxb1PLhWj
X-Proofpoint-GUID: 654Q11v3viXrKNoU0CdSQCjqoSNj4MDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-02_06,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309020074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

should_we_balance is called in load_balance to find out if the CPU that
is trying to do the load balance is the right one or not.
With commit b1bfeab9b002("sched/fair: Consider the idle state of the whole
core for load balance"), tries to find an idle core to do the load balancing
and fallsback on an idle sibling CPU if there is no idle core.

However, on larger SMT systems, it could be needlessly iterating to find a
idle by scanning all the CPUs in an non-idle core. If the core is not idle,
and first SMT sibling which is idle has been found, then its not needed to
check other SMT siblings for idleness

Lets say in SMT4, Core0 has 0,2,4,6 and CPU0 is BUSY and rest are IDLE.
balancing domain is MC/DIE. CPU2 will be set as the first idle_smt and
same process would be repeated for CPU4 and CPU6 but this is unnecessary.
Since calling is_core_idle loops through all CPU's in the SMT mask, effect
is multiplied by weight of smt_mask. For example,when say 1 CPU is busy,
we would skip loop for 2 CPU's and skip iterating over 8CPU's. That
effect would be more in DIE/NUMA domain where there are more cores.

Testing and performance evaluation
The test has been done on this system which has 12 cores, i.e 24 small
cores with SMT=4
lscpu
Architecture:            ppc64le
  Byte Order:            Little Endian
CPU(s):                  96
  On-line CPU(s) list:   0-95
Model name:              POWER10 (architected), altivec supported
  Thread(s) per core:    8

Used funclatency bcc tool to evaluate the time taken by should_we_balance. For
base tip/sched/core the time taken is collected by making the
should_we_balance noinline. time is in nanoseconds. The values are
collected by running the funclatency tracer for 60 seconds. values are
average of 3 such runs. This represents the expected reduced time with
patch.

tip/sched/core was at commit 2f88c8e802c8
("sched/eevdf/doc: Modify the documented knob to base_slice_ns as well")
------------------------------------------------------------------------------
workload			   tip/sched/core	with_patch(%gain)
------------------------------------------------------------------------------
idle system				 809.3		 695.0(16.45)
stress ng – 12 threads -l 100		1013.5		 893.1(13.49)
stress ng – 24 threads -l 100		1073.5		 980.0(9.54)
stress ng – 48 threads -l 100	 	 683.0		 641.0(6.55)
stress ng – 96 threads -l 100		2421.0		2300(5.26)
stress ng – 96 threads -l 15		 375.5   	 377.5(-0.53)
stress ng – 96 threads -l 25		 635.5		 637.5(-0.31)
stress ng – 96 threads -l 35		 934.0		 891.0(4.83)

Ran schbench(old), hackbench and stress_ng  to evaluate the workload
performance between tip/sched/core and with patch.
No modification to tip/sched/core

tl;dr
Good improvement is seen with schbench. when hackbench and stress_ng
runs for longer good improvement is seen.
------------------------------------------------------------------------------
schbench(old)		            tip		+patch(%gain)
10 iterations			sched/core
------------------------------------------------------------------------------
1 Threads
50.0th:		      		    8.00       9.00(-12.50)
75.0th:   			    9.60       9.00(6.25)
90.0th:   			   11.80      10.20(13.56)
95.0th:   			   12.60      10.40(17.46)
99.0th:   			   13.60      11.90(12.50)
99.5th:   			   14.10      12.60(10.64)
99.9th:   			   15.90      14.60(8.18)
2 Threads
50.0th:   			    9.90       9.20(7.07)
75.0th:   			   12.60      10.10(19.84)
90.0th:   			   15.50      12.00(22.58)
95.0th:   			   17.70      14.00(20.90)
99.0th:   			   21.20      16.90(20.28)
99.5th:   			   22.60      17.50(22.57)
99.9th:   			   30.40      19.40(36.18)
4 Threads
50.0th:   			   12.50      10.60(15.20)
75.0th:   			   15.30      12.00(21.57)
90.0th:   			   18.60      14.10(24.19)
95.0th:   			   21.30      16.20(23.94)
99.0th:   			   26.00      20.70(20.38)
99.5th:   			   27.60      22.50(18.48)
99.9th:   			   33.90      31.40(7.37)
8 Threads
50.0th:   			   16.30      14.30(12.27)
75.0th:   			   20.20      17.40(13.86)
90.0th:   			   24.50      21.90(10.61)
95.0th:   			   27.30      24.70(9.52)
99.0th:   			   35.00      31.20(10.86)
99.5th:   			   46.40      33.30(28.23)
99.9th:   			   89.30      57.50(35.61)
16 Threads
50.0th:   			   22.70      20.70(8.81)
75.0th:   			   30.10      27.40(8.97)
90.0th:   			   36.00      32.80(8.89)
95.0th:   			   39.60      36.40(8.08)
99.0th:   			   49.20      44.10(10.37)
99.5th:   			   64.90      50.50(22.19)
99.9th:   			  143.50     100.60(29.90)
32 Threads
50.0th:   			   34.60      35.50(-2.60)
75.0th:   			   48.20      50.50(-4.77)
90.0th:   			   59.20      62.40(-5.41)
95.0th:   			   65.20      69.00(-5.83)
99.0th:   			   80.40      83.80(-4.23)
99.5th:   			  102.10      98.90(3.13)
99.9th:   			  727.10     506.80(30.30)
schbench does improve in general. There is some run to run variation with
schbench. Did a validation run to confirm that trend is similar.

------------------------------------------------------------------------------
hackbench				tip	   +patch(%gain)
20 iterations, 50000 loops	     sched/core
------------------------------------------------------------------------------
Process 10 groups                :      11.74      11.70(0.34)
Process 20 groups                :      22.73      22.69(0.18)
Process 30 groups                :      33.39      33.40(-0.03)
Process 40 groups                :      43.73      43.61(0.27)
Process 50 groups                :      53.82      54.35(-0.98)
Process 60 groups                :      64.16      65.29(-1.76)
thread 10 Time                   :      12.81      12.79(0.16)
thread 20 Time                   :      24.63      24.47(0.65)
Process(Pipe) 10 Time            :       6.40       6.34(0.94)
Process(Pipe) 20 Time            :      10.62      10.63(-0.09)
Process(Pipe) 30 Time            :      15.09      14.84(1.66)
Process(Pipe) 40 Time            :      19.42      19.01(2.11)
Process(Pipe) 50 Time            :      24.04      23.34(2.91)
Process(Pipe) 60 Time            :      28.94      27.51(4.94)
thread(Pipe) 10 Time             :       6.96       6.87(1.29)
thread(Pipe) 20 Time             :      11.74      11.73(0.09)

hackbench shows slight improvement with pipe. Slight degradation in process.

------------------------------------------------------------------------------
stress_ng				tip        +patch(%gain)
10 iterations 100000 cpu_ops	     sched/core
------------------------------------------------------------------------------

--cpu=96 -util=100 Time taken  	 :       5.30,       5.01(5.47)
--cpu=48 -util=100 Time taken    :       7.94,       6.73(15.24)
--cpu=24 -util=100 Time taken    :      11.67,       8.75(25.02)
--cpu=12 -util=100 Time taken    :      15.71,      15.02(4.39)
--cpu=96 -util=10 Time taken     :      22.71,      22.19(2.29)
--cpu=96 -util=20 Time taken     :      12.14,      12.37(-1.89)
--cpu=96 -util=30 Time taken     :       8.76,       8.86(-1.14)
--cpu=96 -util=40 Time taken     :       7.13,       7.14(-0.14)
--cpu=96 -util=50 Time taken     :       6.10,       6.13(-0.49)
--cpu=96 -util=60 Time taken     :       5.42,       5.41(0.18)
--cpu=96 -util=70 Time taken     :       4.94,       4.94(0.00)
--cpu=96 -util=80 Time taken     :       4.56,       4.53(0.66)
--cpu=96 -util=90 Time taken     :       4.27,       4.26(0.23)

Good improvement seen with 24 cpus. In this case only one CPU is busy,
and no core is idle. Decent improvement with 100% utilization case. no
difference in other utilization.

Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b7445cd5af9..6e31923293bb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6619,6 +6619,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 /* Working cpumask for: load_balance, load_balance_newidle. */
 static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
+static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);

 #ifdef CONFIG_NO_HZ_COMMON

@@ -10913,6 +10914,7 @@ static int active_load_balance_cpu_stop(void *data);

 static int should_we_balance(struct lb_env *env)
 {
+	struct cpumask *swb_cpus = this_cpu_cpumask_var_ptr(should_we_balance_tmpmask);
 	struct sched_group *sg = env->sd->groups;
 	int cpu, idle_smt = -1;

@@ -10936,8 +10938,9 @@ static int should_we_balance(struct lb_env *env)
 		return 1;
 	}

+	cpumask_copy(swb_cpus, group_balance_mask(sg));
 	/* Try to find first idle CPU */
-	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
+	for_each_cpu_and(cpu, swb_cpus, env->cpus) {
 		if (!idle_cpu(cpu))
 			continue;

@@ -10949,6 +10952,14 @@ static int should_we_balance(struct lb_env *env)
 		if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
 			if (idle_smt == -1)
 				idle_smt = cpu;
+			/*
+			 * If the core is not idle, and first SMT sibling which is
+			 * idle has been found, then its not needed to check other
+			 * SMT siblings for idleness
+			 */
+#ifdef CONFIG_SCHED_SMT
+			cpumask_andnot(swb_cpus, swb_cpus, cpu_smt_mask(cpu));
+#endif
 			continue;
 		}

@@ -12914,6 +12925,8 @@ __init void init_sched_fair_class(void)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i), GFP_KERNEL, cpu_to_node(i));
 		zalloc_cpumask_var_node(&per_cpu(select_rq_mask,    i), GFP_KERNEL, cpu_to_node(i));
+		zalloc_cpumask_var_node(&per_cpu(should_we_balance_tmpmask, i),
+					GFP_KERNEL, cpu_to_node(i));

 #ifdef CONFIG_CFS_BANDWIDTH
 		INIT_CSD(&cpu_rq(i)->cfsb_csd, __cfsb_csd_unthrottle, cpu_rq(i));
--
2.31.1

