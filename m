Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7917F91DF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 09:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjKZIou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 03:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZIor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 03:44:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC0910B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 00:44:52 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQ8EMWD000372;
        Sun, 26 Nov 2023 08:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LWBaxfEcJqew4koUElNXFmccPOZsTaAjSFOjT/xq2bg=;
 b=fr3feU0THWg1PtsEPFpnQaCcYPCBliyzJ8tO3jN/m4LQhy62Yj2UolfmQPR3t2E5e3SH
 HY18OiMGwLdOOBnF150coTkQMCihVu273zme6g7Nmhgyis9w2CcnWUaPzQel152WKRuB
 faQnZrgIt2ReH9u2QZkOO9MKfwBwdY4ZMvbkJw4jodnsnQXr9zbojZmgex+A6Gz1AWH4
 sKznZzDIKEsRrb0mZS2syJ8aloKTyZ35EQgJyBVVL3rZ7fWOVwAyYumqAszFXXp41/xz
 T+9xA+3ZBHHzfGEHG8r0hloCdcsE/hUxE0DLmm31YPsTotJiRVQDEnuI5AYJHYqi5gMx jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ukv6q5tuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Nov 2023 08:44:32 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AQ8hPEB008521;
        Sun, 26 Nov 2023 08:44:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ukv6q5tu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Nov 2023 08:44:32 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQ549tr012213;
        Sun, 26 Nov 2023 08:44:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrk1kbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Nov 2023 08:44:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AQ8iUdn27001378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Nov 2023 08:44:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB3E158059;
        Sun, 26 Nov 2023 08:44:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7250758058;
        Sun, 26 Nov 2023 08:44:22 +0000 (GMT)
Received: from [9.179.0.249] (unknown [9.179.0.249])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 26 Nov 2023 08:44:22 +0000 (GMT)
Message-ID: <23e9a0f2-be96-4eb6-0242-2865180c1d6c@linux.ibm.com>
Date:   Sun, 26 Nov 2023 14:14:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/3] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        cover.1700548379.git.yu.c.chen@intel.com
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1700548379.git.yu.c.chen@intel.com>
From:   Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <cover.1700548379.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sx_zAQOCuwBQR_K1QYGz75T0vq7WPpcs
X-Proofpoint-ORIG-GUID: -T2yv7bvm1qYd3ftqZE6oqja2A9ibrCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311260061
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu,

On 21/11/23 13:09, Chen Yu wrote:
> v1  -> v2:
> - Move the task sleep duration from sched_entity to task_struct. (Aaron Lu)
> - Refine the task sleep duration calculation based on task's previous running
>   CPU. (Aaron Lu)
> - Limit the cache-hot idle CPU scan depth to reduce the time spend on
>   searching, to fix the regression. (K Prateek Nayak)
> - Add test results of the real life workload per request from Ingo
>     Daytrader on a power system. (Madadi Vineeth Reddy)
>     OLTP workload on Xeon Sapphire Rapids.
> - Refined the commit log, added Reviewed-by tag to PATCH 1/3
>   (Mathieu Desnoyers).
> 
> RFC -> v1:
> - drop RFC
> - Only record the short sleeping time for each task, to better honor the
>   burst sleeping tasks. (Mathieu Desnoyers)
> - Keep the forward movement monotonic for runqueue's cache-hot timeout value.
>   (Mathieu Desnoyers, Aaron Lu)
> - Introduce a new helper function cache_hot_cpu() that considers
>   rq->cache_hot_timeout. (Aaron Lu)
> - Add analysis of why inhibiting task migration could bring better throughput
>   for some benchmarks. (Gautham R. Shenoy)
> - Choose the first cache-hot CPU, if all idle CPUs are cache-hot in
>   select_idle_cpu(). To avoid possible task stacking on the waker's CPU.
>   (K Prateek Nayak)
> 
> Thanks for the comments and tests!
> 
> ----------------------------------------------------------------------
> 
> This series aims to continue the discussion of how to make the wakee
> to choose its previous CPU easier.
> 
> When task p is woken up, the scheduler leverages select_idle_sibling()
> to find an idle CPU for it. p's previous CPU is usually a preference
> because it can improve cache locality. However in many cases, the
> previous CPU has already been taken by other wakees, thus p has to
> find another idle CPU.
> 
> Inhibit the task migration could benefit many workloads. Inspired by
> Mathieu's proposal to limit the task migration ratio[1], introduce
> the SIS_CACHE. It considers the sleep time of the task for better
> task placement. Based on the task's short sleeping history, tag p's
> previous CPU as cache-hot. Later when p is woken up, it can choose
> its previous CPU in select_idle_sibling(). When other task is
> woken up, skip this cache-hot idle CPU and try the next idle CPU
> when possible. The idea of SIS_CACHE is to optimize the idle CPU
> scan sequence. The extra scan time is minimized by restricting the
> scan depth of cache-hot CPUs to 50% of the scan depth of SIS_UTIL.
> 
> This test is based on tip/sched/core, on top of
> Commit ada87d23b734
> ("x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram")
> 
> This patch set has shown 15% ~ 70% improvements for client/server
> workloads like netperf and tbench. It shows 0.7% improvement of
> OLTP with 0.2% run-to-run variation on Xeon 240 CPUs system.
> There is 2% improvement of another real life workload Daytrader
> per the test of Madadi on a power system with 96 CPUs. Prateek
> has helped check there is no obvious microbenchmark regression
> of the v2 on a 3rd Generation EPYC System with 128 CPUs.
> 

Tested the patch on power system with 46 cores. Total of 368 CPU's.
System has 8 NUMA nodes.

Below are some of the benchmark results.

schbench(new) 99.0th latency (lower is better)
========
case            load        	baseline[pct imp](std%)       SIS_CACHE[pct imp]( std%)
normal          1-mthreads      1.00 [ 0.00]( 4.34)            1.02 [ -2.00]( 5.98)
normal          2-mthreads      1.00 [ 0.00]( 13.95)           1.08 [ -8.00]( 10.39)
normal          4-mthreads      1.00 [ 0.00]( 6.20)            0.94 [ +6.00]( 10.90)
normal          6-mthreads      1.00 [ 0.00]( 12.76)           1.03 [ -3.00]( 9.33)

It seems like schbench is not much impacted with this patch(The pct imp of schbench is within the std%).
I expected some regression in wakeup latency while searching for an idle cpu which is not cache hot.
But I guess limiting the search depth had helped.


producer_consumer avg time/access (lower is better)
========
loads per consumer iteration   baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
5                  		1.00 [ 0.00]( 0.00)            0.93 [ +7.00]( 4.77)
10                   		1.00 [ 0.00]( 0.00)            1.00 [  0.00]( 0.00)
20                    		1.00 [ 0.00]( 0.00)            1.00 [  0.00]( 0.00)

The main goal of the patch of improving cache locality is reflected as SIS_CACHE only improves in this workload, 
when loads per consumer iteration is lower.


hackbench normalized time in seconds (lower is better)
========
case            load        baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
process-sockets 1-groups     1.00 [ 0.00]( 4.78)            0.99 [ +1.00]( 6.45)
process-sockets 2-groups     1.00 [ 0.00]( 0.97)            1.02 [ -2.00]( 1.87)
process-sockets 4-groups     1.00 [ 0.00]( 3.63)            1.01 [ -1.00]( 2.96)
process-sockets 8-groups     1.00 [ 0.00]( 0.43)            1.00 [  0.00]( 0.27)
process-pipe    1-groups     1.00 [ 0.00](23.77)            0.88 [+12.00](22.77)
process-pipe    2-groups     1.00 [ 0.00]( 3.44)            1.03 [ -3.00]( 4.00)
process-pipe    4-groups     1.00 [ 0.00]( 2.41)            0.98 [ +2.00]( 3.88)
process-pipe    8-groups     1.00 [ 0.00]( 7.09)            1.07 [ -7.00]( 4.25)
threads-pipe    1-groups     1.00 [ 0.00](18.47)            1.11 [-11.00](24.21)
threads-pipe    2-groups     1.00 [ 0.00]( 6.45)            0.97 [ +3.00]( 5.58)
threads-pipe    4-groups     1.00 [ 0.00]( 5.63)            0.96 [ +2.00]( 5.90)
threads-pipe    8-groups     1.00 [ 0.00]( 1.65)            1.03 [ -3.00]( 3.97)
threads-sockets 1-groups     1.00 [ 0.00]( 2.00)            1.00 [  0.00]( 0.65)
threads-sockets 2-groups     1.00 [ 0.00]( 1.69)            1.02 [ -2.00]( 1.48)
threads-sockets 4-groups     1.00 [ 0.00]( 5.66)            1.01 [ -1.00]( 3.56)
threads-sockets 8-groups     1.00 [ 0.00]( 0.26)            0.99 [ +1.00]( 0.36)

hackbench is not impacted.


Daytrader throughput (higher is better)
========
instances,users                baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
3,30                 		1.00 [ 0.00]( 2.30)            1.02 [ +2.00]( 1.64)
3,60                 		1.00 [ 0.00]( 0.55)            1.01 [ +1.00]( 1.41)
3,90                  		1.00 [ 0.00]( 1.20)            1.02 [ +2.00]( 1.04)
3,120                  		1.00 [ 0.00]( 0.84)            1.02 [ +2.00]( 1.02)

A real life workload like daytrader is benefiting slightly with this patch.


Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks and Regards
Madadi Vineeth Reddy
