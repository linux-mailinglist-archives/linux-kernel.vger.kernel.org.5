Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3278813E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbjHYHt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjHYHtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:49:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956231BF0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:49:37 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P7aTsF005272;
        Fri, 25 Aug 2023 07:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YA28SoTXnqsLcbhveyni9EZnPYbWoQSXFT49hPS6LAA=;
 b=jWqlKhkutb/M8RKbGutVtKw5Dg/AUUpXXORJJMFo/8xcqksMvr+NGy1P/vs+jPJmKeEx
 xkXFUo0l0yn2fMbwxxDp0i1EbkCq9UR0SJBTZv4fsp5spMBlo02oUF7XWFClCg6lFNMB
 IzJKKVtjVcSsscqaTYUg6oxZe9BSkauIhwvRCYhFCcbeOC7JffyapGPyrb+5d+538lnK
 JIVwtjNsensmCx5eo8zWhna20jyt9UF8MgTDLoVBNleiotjTPDFjMiMSWXh/sAr+hS81
 qkevqIkxqrWmfN5iiRukipUHLMXtwD1lORQLKtU64CS+SA0tsmLFrUpTuYA8elacT51W dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spq1rhtkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 07:49:05 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P7ampl007904;
        Fri, 25 Aug 2023 07:49:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spq1rhtjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 07:49:04 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37P5KgLD027323;
        Fri, 25 Aug 2023 07:49:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn20swvq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 07:49:03 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37P7n2kq55181742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 07:49:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EE195805A;
        Fri, 25 Aug 2023 07:49:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D53465805E;
        Fri, 25 Aug 2023 07:48:57 +0000 (GMT)
Received: from [9.171.40.203] (unknown [9.171.40.203])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 07:48:57 +0000 (GMT)
Message-ID: <8561f192-ccd0-c2e3-3115-8cf09a7d3e55@linux.vnet.ibm.com>
Date:   Fri, 25 Aug 2023 13:18:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 0/7] Optimization to reduce the cost of newidle
 balance
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <cover.1690273854.git.yu.c.chen@intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <cover.1690273854.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vSN3N6_hnOQMs4kgmWa8LWYhUBN3c5_B
X-Proofpoint-ORIG-GUID: PsJrEGBRdwlGBFoGaN2dbQ6Gxm5HwDO5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_05,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250065
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 8:03 PM, Chen Yu wrote:
> Hi,
> 
> This is the second version of the newidle balance optimization[1].
> It aims to reduce the cost of newidle balance which is found to
> occupy noticeable CPU cycles on some high-core count systems.
> 
> For example, when running sqlite on Intel Sapphire Rapids, which has
> 2 x 56C/112T = 224 CPUs:
> 
> 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
> 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
> 
> To mitigate this cost, the optimization is inspired by the question
> raised by Tim:
> Do we always have to find the busiest group and pull from it? Would
> a relatively busy group be enough?
> 
> There are two proposals in this patch set.
> The first one is ILB_UTIL. It was proposed to limit the scan
> depth in update_sd_lb_stats(). The scan depth is based on the
> overall utilization of this sched domain. The higher the utilization
> is, the less update_sd_lb_stats() scans. Vice versa.
> 
> The second one is ILB_FAST. Instead of always finding the busiest
> group in update_sd_lb_stats(), lower the bar and try to find a
> relatively busy group. ILB_FAST takes effect when the local group
> is group_has_spare. Because when there are many CPUs running
> newidle_balance() concurrently, the sched groups should have a
> high idle percentage.
> 
> Compared between ILB_UTIL and ILB_FAST, the former inhibits the
> sched group scan when the system is busy. While the latter
> chooses a compromised busy group when the system is not busy.
> So they are complementary to each other and work independently.
> 
> patch 1/7 and patch 2/7 are preparation for ILB_UTIL.
> 
> patch 3/7 is a preparation for both ILB_UTIL and ILB_FAST.
> 
> patch 4/7 is part of ILB_UTIL. It calculates the scan depth
>           of sched groups which will be used by
>           update_sd_lb_stats(). The depth is calculated by the
>           periodic load balance.
> 
> patch 5/7 introduces the ILB_UTIL.
> 
> patch 6/7 introduces the ILB_FAST.
> 
> patch 7/7 is a debug patch to print more sched statistics, inspired
>           by Prateek's test report.
> 
> In the previous version, Prateek found some regressions[2].
> This is probably caused by:
> 1. Cross Numa access to sched_domain_shared. So this version removed
>    the sched_domain_shared for Numa domain.
> 2. newidle balance did not try so hard to scan for the busiest
>    group. This version still keeps the linear scan function. If
>    the regression is still there, we can try to leverage the result
>    of SIS_UTIL. Because SIS_UTIL is a quadratic function which
>    could help scan the domain harder when the system is not
>    overloaded.
> 
> Changes since the previous version:
> 1. For all levels except for NUMA, connect a sched_domain_shared
>    instance. This makes the newidle balance optimization more
>    generic, and not only for LLC domain. (Peter, Gautham)
> 2. Introduce ILB_FAST, which terminates the sched group scan
>    earlier, if it finds a proper group rather than the busiest
>    one (Tim).
> 
> 
> Peter has suggested reusing the statistics of the sched group
> if multiple CPUs trigger newidle balance concurrently[3]. I created
> a prototype[4] based on this direction. According to the test, there
> are some regressions. The bottlenecks are a spin_trylock() and the
> memory load from the 'cached' shared region. It is still under
> investigation so I did not include that change into this patch set.
> 
> Any comments would be appreciated.
> 
> [1] https://lore.kernel.org/lkml/cover.1686554037.git.yu.c.chen@intel.com/
> [2] https://lore.kernel.org/lkml/7e31ad34-ce2c-f64b-a852-f88f8a5749a6@amd.com/
> [3] https://lore.kernel.org/lkml/20230621111721.GA2053369@hirez.programming.kicks-ass.net/
> [4] https://github.com/chen-yu-surf/linux/commit/a6b33df883b972d6aaab5fceeddb11c34cc59059.patch
> 
> Chen Yu (7):
>   sched/topology: Assign sd_share for all non NUMA sched domains
>   sched/topology: Introduce nr_groups in sched_domain to indicate the
>     number of groups
>   sched/fair: Save a snapshot of sched domain total_load and
>     total_capacity
>   sched/fair: Calculate the scan depth for idle balance based on system
>     utilization
>   sched/fair: Adjust the busiest group scanning depth in idle load
>     balance
>   sched/fair: Pull from a relatively busy group during newidle balance
>   sched/stats: Track the scan number of groups during load balance
> 
>  include/linux/sched/topology.h |   5 ++
>  kernel/sched/fair.c            | 114 ++++++++++++++++++++++++++++++++-
>  kernel/sched/features.h        |   4 ++
>  kernel/sched/stats.c           |   5 +-
>  kernel/sched/topology.c        |  14 ++--
>  5 files changed, 135 insertions(+), 7 deletions(-)
> 

Hi Chen. It is a nice patch series in effort to reduce the newidle cost. 
This gives the idea of making use of calculations done in load_balance to used 
among different idle types. 

It was interesting to see how this would work on Power Systems. The reason being we have 
large core count and LLC size is small. i.e at small core level (llc_weight=4). This would
mean quite frequest access sd_share at different level which would reside on the first_cpu of 
the sched domain, which might result in more cache-misses. But perf stats didnt show the same.

Another concern on more number of sched  groups at DIE level, which might take a hit if 
the balancing takes longer for the system to stabilize. 

tl;dr

Tested with micro-benchmarks on system with 96 Cores with SMT=8. Total of 768 CPU's. There is some amount 
of regression with hackbench and schbench. haven't looked into why. Any pointers to check would be helpful.
Did a test with more real case workload that we have called daytrader. Its is DB workload which gives total
transcations done per second. That doesn't show any regression.

Its true that all benchmarks will not be happy.
Maybe in below cases, newidle may not be that costly. Do you have any specific benchmark to be tried? 

-----------------------------------------------------------------------------------------------------
					6.5.rc4			6.5.rc4 + PATCH_V2 		gain					
Daytrader:				55049				55378			0.59%

-----------------------------------------------------------------------------------------------------
hackbench(50 iterations):			   6.5.rc4	6.5.rc4 + PATCH_V2(gain%)


Process 10 groups                    :       0.19,       0.19(0.00)             
Process 20 groups                    :       0.23,       0.24(-4.35)            
Process 30 groups                    :       0.28,       0.30(-7.14)            
Process 40 groups                    :       0.38,       0.40(-5.26)            
Process 50 groups                    :       0.43,       0.45(-4.65)            
Process 60 groups                    :       0.51,       0.51(0.00)             
thread 10 Time                       :       0.21,       0.22(-4.76)            
thread 20 Time                       :       0.27,       0.32(-18.52)           
Process(Pipe) 10 Time                :       0.17,       0.17(0.00)             
Process(Pipe) 20 Time                :       0.23,       0.23(0.00)             
Process(Pipe) 30 Time                :       0.28,       0.28(0.00)             
Process(Pipe) 40 Time                :       0.33,       0.32(3.03)             
Process(Pipe) 50 Time                :       0.38,       0.36(5.26)             
Process(Pipe) 60 Time                :       0.40,       0.39(2.50)             
thread(Pipe) 10 Time                 :       0.14,       0.14(0.00)             
thread(Pipe) 20 Time                 :       0.20,       0.19(5.00) 

Observation: lower is better. socket based runs show regression quite a bit, 
pipe shows slight improvement. 


-----------------------------------------------------------------------------------------------------
Unixbench(10 iterations):			   6.5.rc4	6.5.rc4 + PATCH_V2(gain%)

1 X Execl Throughput                  :    4280.15,    4398.30(2.76)           
4 X Execl Throughput                  :    8171.60,    8061.60(-1.35)            
1 X Pipe-based Context Switching      :  172455.50,  174586.60(1.24)           
4 X Pipe-based Context Switching      :  633708.35,  664659.85(4.88)           
1 X Process Creation                  :    6891.20,    7056.85(2.40)           
4 X Process Creation                  :    8826.20,    8996.25(1.93)           
1 X Shell Scripts (1 concurrent)      :    9272.05,    9456.10(1.98)           
4 X Shell Scripts (1 concurrent)      :   27919.60,   25319.75(-9.31)            
1 X Shell Scripts (8 concurrent)      :    4462.70,    4392.75(-1.57)            
4 X Shell Scripts (8 concurrent)      :   11852.30,   10820.70(-8.70) 

Observation: higher is better. Results are somewhat mixed.  


-----------------------------------------------------------------------------------------------------
schbench(10 iterations)			 6.5.rc4	6.5.rc4 + PATCH_V2(gain%)

1 Threads                                                                       
50.0th:                                   8.00,       7.00(12.50)               
75.0th:                                   8.00,       7.60(5.00)                
90.0th:                                   8.80,       8.00(9.09)                
95.0th:                                  10.20,       8.20(19.61)               
99.0th:                                  13.60,      11.00(19.12)               
99.5th:                                  14.00,      12.80(8.57)                
99.9th:                                  15.80,      35.00(-121.52)             
2 Threads                                                                       
50.0th:                                   8.40,       8.20(2.38)                
75.0th:                                   9.00,       8.60(4.44)                
90.0th:                                  10.20,       9.60(5.88)                
95.0th:                                  11.20,      10.20(8.93)                
99.0th:                                  14.40,      11.40(20.83)               
99.5th:                                  14.80,      12.80(13.51)               
99.9th:                                  17.60,      14.80(15.91)               
4 Threads                                                                       
50.0th:                                  10.60,      10.40(1.89)                
75.0th:                                  12.20,      11.60(4.92)                
90.0th:                                  13.60,      12.60(7.35)                
95.0th:                                  14.40,      13.00(9.72)                
99.0th:                                  16.40,      15.60(4.88)                
99.5th:                                  16.80,      16.60(1.19)                
99.9th:                                  22.00,      29.00(-31.82)              
8 Threads                                                                       
50.0th:                                  12.00,      11.80(1.67)                
75.0th:                                  14.40,      14.40(0.00)                
90.0th:                                  17.00,      18.00(-5.88)               
95.0th:                                  19.20,      19.80(-3.13)               
99.0th:                                  23.00,      24.20(-5.22)               
99.5th:                                  26.80,      29.20(-8.96)               
99.9th:                                  68.00,      97.20(-42.94)  
16 Threads                                                                      
50.0th:                                  18.00,      18.20(-1.11)               
75.0th:                                  23.20,      23.60(-1.72)               
90.0th:                                  28.00,      27.40(2.14)                
95.0th:                                  31.20,      30.40(2.56)                
99.0th:                                  38.60,      38.20(1.04)                
99.5th:                                  50.60,      50.40(0.40)                
99.9th:                                 122.80,     108.00(12.05)               
32 Threads                                                                      
50.0th:                                  30.00,      30.20(-0.67)               
75.0th:                                  42.20,      42.60(-0.95)               
90.0th:                                  52.60,      55.40(-5.32)               
95.0th:                                  58.60,      63.00(-7.51)               
99.0th:                                  69.60,      78.20(-12.36)              
99.5th:                                  79.20,     103.80(-31.06)              
99.9th:                                 171.80,     209.60(-22.00)

Observation: lower is better. tail latencies seem to go up. schbench also has run to run variations.

-----------------------------------------------------------------------------------------------------
stress-ng(20 iterations)	   6.5.rc4	6.5.rc4 + PATCH_V2(gain%)
	 ( 100000 cpu-ops)

--cpu=768 Time               :       1.58,       1.53(3.16)                     
--cpu=384 Time               :       1.66,       1.63(1.81)                     
--cpu=192 Time               :       2.67,       2.77(-3.75)                    
--cpu=96 Time                :       3.70,       3.69(0.27)                     
--cpu=48 Time                :       5.73,       5.69(0.70)                     
--cpu=24 Time                :       7.27,       7.26(0.14)                     
--cpu=12 Time                :      14.25,      14.24(0.07)                     
--cpu=6 Time                 :       28.42,      28.40(0.07)                    
--cpu=3 Time                 :      56.81,      56.68(0.23)                     
--cpu=768 -util=10 Time      :       3.69,       3.70(-0.27)                    
--cpu=768 -util=20 Time      :       5.67,       5.70(-0.53)                    
--cpu=768 -util=30 Time      :       7.08,       7.12(-0.56)                    
--cpu=768 -util=40 Time      :       8.23,       8.27(-0.49)                    
--cpu=768 -util=50 Time      :       9.22,       9.26(-0.43)                    
--cpu=768 -util=60 Time      :      10.09,      10.15(-0.59)                    
--cpu=768 -util=70 Time      :      10.93,      10.98(-0.46)                    
--cpu=768 -util=80 Time      :      11.79,      11.79(0.00)                     
--cpu=768 -util=90 Time      :      12.63,      12.60(0.24) 


Observation: lower is better. Almost no difference.
