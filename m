Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21319799CF6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346422AbjIJHvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 03:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJHvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 03:51:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BBE119
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 00:51:33 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38A7oldh013675;
        Sun, 10 Sep 2023 07:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9txS/sar90T7+xOaEjMOJg+AvUaToWHqDas010cXiyo=;
 b=WZb6BkwMHcQ6RsPAaLQh7SFMnISjgplV6aYWhZmEPBR3LH0gXWu+qZe6qToo/9/1oyBZ
 oIJYlw5kkTof9SecXwnrVjiUWXkIKL659709Xt6oDzqtfiBBMHkOYMdckypU8SQTnH9r
 XIreRo97KLqkX2mbmpG5gLBILKH1+bB91xBwVeNK1yA9eX+Bass03UVZVkQeYFngEr6D
 gE+4yp6CgCziZws+V6XjFjXmVOdhnPEVsidQlu6PnnmFNhWi5R0vtpgjQZEJI9RKmrQ6
 jCmGiqZfpajbpqJqfCgxUwKNqUmUgbJN3FxMR6tusme0500CuDWtK6nUxQVgfMZ0xrWw 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t19s3805u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 07:51:15 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38A7pESQ014252;
        Sun, 10 Sep 2023 07:51:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t19s3805h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 07:51:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38A728PR012037;
        Sun, 10 Sep 2023 07:51:13 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dy2348-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 07:51:13 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38A7pClb6554262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Sep 2023 07:51:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D4D55804E;
        Sun, 10 Sep 2023 07:51:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00A9558054;
        Sun, 10 Sep 2023 07:51:07 +0000 (GMT)
Received: from [9.171.45.185] (unknown [9.171.45.185])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 10 Sep 2023 07:51:06 +0000 (GMT)
Message-ID: <b9397226-c9e4-346b-9f2a-91c21633f4ce@linux.vnet.ibm.com>
Date:   Sun, 10 Sep 2023 13:21:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/7] Optimization to reduce the cost of newidle
 balance
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
 <8561f192-ccd0-c2e3-3115-8cf09a7d3e55@linux.vnet.ibm.com>
 <ZO9fvgovn/MtLVzZ@chenyu5-mobl2>
Content-Language: en-US
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <ZO9fvgovn/MtLVzZ@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vtFA0vW_kRW3FPctsU03kohpCnL3YN9Q
X-Proofpoint-ORIG-GUID: rV50byoYEtJAMbl_CYI3zgQ2w6sRsNDs
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-10_01,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309100064
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/23 8:56 PM, Chen Yu wrote:
> Hi Shrikanth,

Hi Chen, sorry for the slightly delayed response.

note: patch as is, fails to apply cleanly as BASE_SLICE is not a
feature in the latest tip/sched/core. 

> 
> On 2023-08-25 at 13:18:56 +0530, Shrikanth Hegde wrote:
>>
>> On 7/27/23 8:03 PM, Chen Yu wrote:
>>
>> Hi Chen. It is a nice patch series in effort to reduce the newidle cost. 
>> This gives the idea of making use of calculations done in load_balance to used 
>> among different idle types. 
>>
> 
> Thanks for taking a look at this patch set.
> 
>> It was interesting to see how this would work on Power Systems. The reason being we have 
>> large core count and LLC size is small. i.e at small core level (llc_weight=4). This would
>> mean quite frequest access sd_share at different level which would reside on the first_cpu of 
>> the sched domain, which might result in more cache-misses. But perf stats didnt show the same.
>>
> 
> Do you mean 1 large domain(Die domain?) has many LLC sched domains as its children,
> and accessing the large domain's sd_share field would cross different LLCs and the
> latency is high? Yes, this could be a problem and it depends on the hardware that how
> fast differet LLCs snoop the data with each other.

Yes

> On the other hand, the periodic load balance is the writer of sd_share, and the
> interval is based on the cpu_weight of that domain. So the write might be less frequent
> on large domains, and most access to sd_share would be the read issued by newidle balance,
> which is less costly.
> 
>> Another concern on more number of sched  groups at DIE level, which might take a hit if 
>> the balancing takes longer for the system to stabilize. 
> 
> Do you mean, if newidle balance does not pull tasks hard enough, the imbalance between groups
> would last longer? Yes, Prateek has mentioned this point, the ILB_UTIL has this problem, I'll
> think more about it. We want to find a way in newidle balance to do less scan, but still pulls
> tasks as hard as before.
> 
>>
>> tl;dr
>>
>> Tested with micro-benchmarks on system with 96 Cores with SMT=8. Total of 768 CPU's. There is some amount 
> 
> May I know the sched domain hierarchy of this platform?
> grep . /sys/kernel/debug/sched/domains/cpu0/domain*/*
> cat /proc/schedstat  | grep cpu0 -A 4  (4 domains?)

/sys/kernel/debug/sched/domains/cpu0/domain0/name:SMT
/sys/kernel/debug/sched/domains/cpu0/domain1/name:MC
/sys/kernel/debug/sched/domains/cpu0/domain2/name:DIE
/sys/kernel/debug/sched/domains/cpu0/domain3/name:NUMA
/sys/kernel/debug/sched/domains/cpu0/domain4/name:NUMA


domain-0: span=0,2,4,6 level=SMT
   groups: 0:{ span=0 }, 2:{ span=2 }, 4:{ span=4 }, 6:{ span=6 }
   domain-1: span=0-7,24-39,48-55,72-87 level=MC
    groups: 0:{ span=0,2,4,6 cap=4096 }, 1:{ span=1,3,5,7 cap=4096 }, 24:{ span=24,26,28,30 cap=4096 }, 25:{ span=25,27,29,31 cap=4096 }, 32:{ span=32,34,36,38 cap=4096 }, 33:{ span=33,35,37,39 cap=4096 }, 48:{ span=48,50,52,54 cap=4096 }, 49:{ span=49,51,53,55 cap=4096 }, 72:{ span=72,74,76,78 cap=4096 }, 73:{ span=73,75,77,79 cap=4096 }, 80:{ span=80,82,84,86 cap=4096 }, 81:{ span=81,83,85,87 cap=4096 }
    domain-2: span=0-95 level=DIE
     groups: 0:{ span=0-7,24-39,48-55,72-87 cap=49152 }, 8:{ span=8-23,40-47,56-71,88-95 cap=49152 }
    domain-3: span=0-191 level=NUMA
     groups: 0:{ span=0-95 cap=98304 }, 96:{ span=96-191 cap=98304 }
    domain-4: span=0-767 level=NUMA
     groups: 0:{ span=0-191 cap=196608 }, 192:{ span=192-383 cap=196608 }, 384:{ span=384-575 cap=196608 }, 576:{ span=576-767 cap=196608 }


our LLC is at SMT domain. in an MC domain there could be max upto 16 such LLC. 
That is for Dedicated Logical Partitions(LPAR).
on Shared Processor Logical Partitions(SPLPAR),  it is observed that MC domain 
doesnt make sense. After below proposed change, DIE domain would have SMT as groups. 
After that there this max number of LLC in a DIE can go upto 30. 
https://lore.kernel.org/lkml/20230830105244.62477-5-srikar@linux.vnet.ibm.com/#r

> 
>> of regression with hackbench and schbench. haven't looked into why. Any pointers to check would be helpful.
> 
> May I know what is the command to run hackbench and schbench below? For example
> the fd number, package size and the loop number of hackbench, and
> number of message thread and worker thread of schbench, etc. I assume
> you are using the old schbench? As the latest schbench would track other metrics
> besides tail latency.
> 
> 

Yes. Old schbench.  and Hackbench is from ltp. 
I can try to test the next version. 

>> Did a test with more real case workload that we have called daytrader. Its is DB workload which gives total
>> transcations done per second. That doesn't show any regression.
>>
>> Its true that all benchmarks will not be happy.
>> Maybe in below cases, newidle may not be that costly. Do you have any specific benchmark to be tried? 
>>
> 
> Previously I tested schbench/hackbench/netperf/tbench/sqlite, and also I'm planning
> to try an OLTP.
> 
>> -----------------------------------------------------------------------------------------------------
>> 					6.5.rc4			6.5.rc4 + PATCH_V2 		gain					
>> Daytrader:				55049				55378			0.59%
>>
>> -----------------------------------------------------------------------------------------------------
>> hackbench(50 iterations):			   6.5.rc4	6.5.rc4 + PATCH_V2(gain%)
>>
>>
>> Process 10 groups                    :       0.19,       0.19(0.00)             
>> Process 20 groups                    :       0.23,       0.24(-4.35)            
>> Process 30 groups                    :       0.28,       0.30(-7.14)            
>> Process 40 groups                    :       0.38,       0.40(-5.26)            
>> Process 50 groups                    :       0.43,       0.45(-4.65)            
>> Process 60 groups                    :       0.51,       0.51(0.00)             
>> thread 10 Time                       :       0.21,       0.22(-4.76)            
>> thread 20 Time                       :       0.27,       0.32(-18.52)           
>> Process(Pipe) 10 Time                :       0.17,       0.17(0.00)             
>> Process(Pipe) 20 Time                :       0.23,       0.23(0.00)             
>> Process(Pipe) 30 Time                :       0.28,       0.28(0.00)             
>> Process(Pipe) 40 Time                :       0.33,       0.32(3.03)             
>> Process(Pipe) 50 Time                :       0.38,       0.36(5.26)             
>> Process(Pipe) 60 Time                :       0.40,       0.39(2.50)             
>> thread(Pipe) 10 Time                 :       0.14,       0.14(0.00)             
>> thread(Pipe) 20 Time                 :       0.20,       0.19(5.00) 
>>
>> Observation: lower is better. socket based runs show regression quite a bit, 
>> pipe shows slight improvement. 
>>
>>
>> -----------------------------------------------------------------------------------------------------
>> Unixbench(10 iterations):			   6.5.rc4	6.5.rc4 + PATCH_V2(gain%)
>>
>> 1 X Execl Throughput                  :    4280.15,    4398.30(2.76)           
>> 4 X Execl Throughput                  :    8171.60,    8061.60(-1.35)            
>> 1 X Pipe-based Context Switching      :  172455.50,  174586.60(1.24)           
>> 4 X Pipe-based Context Switching      :  633708.35,  664659.85(4.88)           
>> 1 X Process Creation                  :    6891.20,    7056.85(2.40)           
>> 4 X Process Creation                  :    8826.20,    8996.25(1.93)           
>> 1 X Shell Scripts (1 concurrent)      :    9272.05,    9456.10(1.98)           
>> 4 X Shell Scripts (1 concurrent)      :   27919.60,   25319.75(-9.31)            
>> 1 X Shell Scripts (8 concurrent)      :    4462.70,    4392.75(-1.57)            
>> 4 X Shell Scripts (8 concurrent)      :   11852.30,   10820.70(-8.70) 
>>
>> Observation: higher is better. Results are somewhat mixed.  
>>
>>
>> -----------------------------------------------------------------------------------------------------
>> schbench(10 iterations)			 6.5.rc4	6.5.rc4 + PATCH_V2(gain%)
>>
>> 1 Threads                                                                       
>> 50.0th:                                   8.00,       7.00(12.50)               
>> 75.0th:                                   8.00,       7.60(5.00)                
>> 90.0th:                                   8.80,       8.00(9.09)                
>> 95.0th:                                  10.20,       8.20(19.61)               
>> 99.0th:                                  13.60,      11.00(19.12)               
>> 99.5th:                                  14.00,      12.80(8.57)                
>> 99.9th:                                  15.80,      35.00(-121.52)             
>> 2 Threads                                                                       
>> 50.0th:                                   8.40,       8.20(2.38)                
>> 75.0th:                                   9.00,       8.60(4.44)                
>> 90.0th:                                  10.20,       9.60(5.88)                
>> 95.0th:                                  11.20,      10.20(8.93)                
>> 99.0th:                                  14.40,      11.40(20.83)               
>> 99.5th:                                  14.80,      12.80(13.51)               
>> 99.9th:                                  17.60,      14.80(15.91)               
>> 4 Threads                                                                       
>> 50.0th:                                  10.60,      10.40(1.89)                
>> 75.0th:                                  12.20,      11.60(4.92)                
>> 90.0th:                                  13.60,      12.60(7.35)                
>> 95.0th:                                  14.40,      13.00(9.72)                
>> 99.0th:                                  16.40,      15.60(4.88)                
>> 99.5th:                                  16.80,      16.60(1.19)                
>> 99.9th:                                  22.00,      29.00(-31.82)              
>> 8 Threads                                                                       
>> 50.0th:                                  12.00,      11.80(1.67)                
>> 75.0th:                                  14.40,      14.40(0.00)                
>> 90.0th:                                  17.00,      18.00(-5.88)               
>> 95.0th:                                  19.20,      19.80(-3.13)               
>> 99.0th:                                  23.00,      24.20(-5.22)               
>> 99.5th:                                  26.80,      29.20(-8.96)               
>> 99.9th:                                  68.00,      97.20(-42.94)  
>> 16 Threads                                                                      
>> 50.0th:                                  18.00,      18.20(-1.11)               
>> 75.0th:                                  23.20,      23.60(-1.72)               
>> 90.0th:                                  28.00,      27.40(2.14)                
>> 95.0th:                                  31.20,      30.40(2.56)                
>> 99.0th:                                  38.60,      38.20(1.04)                
>> 99.5th:                                  50.60,      50.40(0.40)                
>> 99.9th:                                 122.80,     108.00(12.05)               
>> 32 Threads                                                                      
>> 50.0th:                                  30.00,      30.20(-0.67)               
>> 75.0th:                                  42.20,      42.60(-0.95)               
>> 90.0th:                                  52.60,      55.40(-5.32)               
>> 95.0th:                                  58.60,      63.00(-7.51)               
>> 99.0th:                                  69.60,      78.20(-12.36)              
>> 99.5th:                                  79.20,     103.80(-31.06)              
>> 99.9th:                                 171.80,     209.60(-22.00)
>>
>> Observation: lower is better. tail latencies seem to go up. schbench also has run to run variations.
>>
>> -----------------------------------------------------------------------------------------------------
>> stress-ng(20 iterations)	   6.5.rc4	6.5.rc4 + PATCH_V2(gain%)
>> 	 ( 100000 cpu-ops)
>>
>> --cpu=768 Time               :       1.58,       1.53(3.16)                     
>> --cpu=384 Time               :       1.66,       1.63(1.81)                     
>> --cpu=192 Time               :       2.67,       2.77(-3.75)                    
>> --cpu=96 Time                :       3.70,       3.69(0.27)                     
>> --cpu=48 Time                :       5.73,       5.69(0.70)                     
>> --cpu=24 Time                :       7.27,       7.26(0.14)                     
>> --cpu=12 Time                :      14.25,      14.24(0.07)                     
>> --cpu=6 Time                 :       28.42,      28.40(0.07)                    
>> --cpu=3 Time                 :      56.81,      56.68(0.23)                     
>> --cpu=768 -util=10 Time      :       3.69,       3.70(-0.27)                    
>> --cpu=768 -util=20 Time      :       5.67,       5.70(-0.53)                    
>> --cpu=768 -util=30 Time      :       7.08,       7.12(-0.56)                    
>> --cpu=768 -util=40 Time      :       8.23,       8.27(-0.49)                    
>> --cpu=768 -util=50 Time      :       9.22,       9.26(-0.43)                    
>> --cpu=768 -util=60 Time      :      10.09,      10.15(-0.59)                    
>> --cpu=768 -util=70 Time      :      10.93,      10.98(-0.46)                    
>> --cpu=768 -util=80 Time      :      11.79,      11.79(0.00)                     
>> --cpu=768 -util=90 Time      :      12.63,      12.60(0.24) 
>>
>>
>> Observation: lower is better. Almost no difference.
> 
> I'll try to run the same tests of hackbench/schbench on my machine, to
> see if I could find any clue for the regression.
> 
> 
> thanks,
> Chenyu
