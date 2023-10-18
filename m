Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E194E7CE7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjJRTja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:39:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0873AB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:39:25 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IJR9h8019194;
        Wed, 18 Oct 2023 19:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : reply-to : in-reply-to :
 content-type : content-transfer-encoding : mime-version; s=pp1;
 bh=yOaHQCYUhLSQI4jFZybHkjI3bsaNRxLdTDXlGx5g6vU=;
 b=K1qDrbEnm4SJ7p4CnU7MLwgZ9g33134AcC+mmA9b5nszyPJFntvVd5TCD2DOY/CJqsjI
 tlQZJp/AenEyWu5IWW/V677EX0xyb76ohtORRuwIYDFsaRnTp+cFLhUwJVVQVSEjxFA9
 b+5DeElMzm7ZxCNKkW1vNjeYr0OcSq1J4bX0dOiicog0KJoQFvJ5VTK2FNw7pQk51jqU
 sr3+O2p9a7gP/u1aDE80ksZTKf3lAl8jt5YD97Hdx8ygNdzX+FKevvv/YH12TZOohEgR
 du45RoMJlbILrqVm826gFzvoBNnyA9QMgbaHPS+dZICasuDAa7YcuCMjC7ra5HrYq9+C Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnhf0bf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:37:02 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IJXQji001713;
        Wed, 18 Oct 2023 19:36:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnhf0as4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:36:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39II7o6l026875;
        Wed, 18 Oct 2023 19:32:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5askny8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:32:29 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IJWS8A40501672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 19:32:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33CAE5805F;
        Wed, 18 Oct 2023 19:32:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BDE758051;
        Wed, 18 Oct 2023 19:32:18 +0000 (GMT)
Received: from [9.179.4.104] (unknown [9.179.4.104])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 19:32:18 +0000 (GMT)
Message-ID: <eb45778d-3302-2ece-8d2e-319b1fcd071d@linux.ibm.com>
Date:   Thu, 19 Oct 2023 01:02:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
To:     Chen Yu <yu.c.chen@intel.com>,
        cover.1695704179.git.yu.c.chen@intel.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <3f98806b-fd74-cfba-b48c-2526109d10a3@linux.ibm.com>
 <ZS5rhO5XysGOUn4M@chenyu5-mobl2.ccr.corp.intel.com>
Content-Language: en-US
From:   Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: ZS5rhO5XysGOUn4M@chenyu5-mobl2.ccr.corp.intel.com
In-Reply-To: <ZS5rhO5XysGOUn4M@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _Jw2K_soGUUccuVN04o0MyIL4osYdIlH
X-Proofpoint-GUID: Vp9OO0cWkzQGZX84O52wlE1VUDeNIuVy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180159
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu,
On 17/10/23 16:39, Chen Yu wrote:
> Hi Madadi,
> 
> On 2023-10-17 at 15:19:24 +0530, Madadi Vineeth Reddy wrote:
>> Hi Chen Yu,
>>
>> On 26/09/23 10:40, Chen Yu wrote:
>>> RFC -> v1:
>>> - drop RFC
>>> - Only record the short sleeping time for each task, to better honor the
>>>   burst sleeping tasks. (Mathieu Desnoyers)
>>> - Keep the forward movement monotonic for runqueue's cache-hot timeout value.
>>>   (Mathieu Desnoyers, Aaron Lu)
>>> - Introduce a new helper function cache_hot_cpu() that considers
>>>   rq->cache_hot_timeout. (Aaron Lu)
>>> - Add analysis of why inhibiting task migration could bring better throughput
>>>   for some benchmarks. (Gautham R. Shenoy)
>>> - Choose the first cache-hot CPU, if all idle CPUs are cache-hot in
>>>   select_idle_cpu(). To avoid possible task stacking on the waker's CPU.
>>>   (K Prateek Nayak)
>>>
>>> Thanks for your comments and review!
>>>
>>> ----------------------------------------------------------------------
>>
>> Regarding making the scan for finding an idle cpu longer vs cache benefits, 
>> I ran some benchmarks.
>>
> 
> Thanks very much for your interest and your time on the patch.
> 
>> Tested the patch on power system with 12 cores. Total of 96 CPU's.
>> System has two NUMA nodes.
>>
>> Below are some of the benchmark results
>>
>> schbench 99.0th latency (lower is better)
>> ========
>> case            load        	baseline[pct imp](std%)       SIS_CACHE[pct imp]( std%)
>> normal          1-mthreads      1.00 [ 0.00]( 3.66)            1.00 [  0.00]( 1.71)
>> normal          2-mthreads      1.00 [ 0.00]( 4.55)            1.02 [ -2.00]( 3.00)
>> normal          4-mthreads      1.00 [ 0.00]( 4.77)            0.96 [ +4.00]( 4.27)
>> normal          6-mthreads      1.00 [ 0.00]( 60.37)           2.66 [ -166.00]( 23.67)
>>
>>
>> schbench results are showing that there is not much impact in wakeup latencies due to more iterations 
>> in search for an idle cpu in the select_idle_cpu code path and interestingly numbers are slightly better 
>> for SIS_CACHE in case of 4-mthreads.
> 
> The 4% improvement is within std%, so I suppose we did not see much difference in 4 mthreads case.
> 
>> I think we can ignore the last case due to huge run to run variations.
> 
> Although the run-to-run variation is large, it seems that the decrease is within that range.
> Prateek has also reported that when the system is overloaded there could be some regression
> from schbench:
> https://lore.kernel.org/lkml/27651e14-f441-c1e2-9b5b-b958d6aadc79@amd.com/
> Could you also post the raw data printed by schbench? And maybe using the latest schbench could get the
> latency in detail.
>  

raw data by schbench(old) with 6-mthreads
======================

Baseline (5 runs)
========
Latency percentiles (usec)                                                                                                                                                                                                                                  
        50.0000th: 22
        75.0000th: 29
        90.0000th: 34
        95.0000th: 37
        *99.0000th: 981 
        99.5000th: 4424
        99.9000th: 9200
        min=0, max=29497

Latency percentiles (usec)
        50.0000th: 23
        75.0000th: 29
        90.0000th: 35
        95.0000th: 38
        *99.0000th: 495 
        99.5000th: 3924
        99.9000th: 9872
        min=0, max=29997

Latency percentiles (usec)
        50.0000th: 23
        75.0000th: 30
        90.0000th: 36
        95.0000th: 39
        *99.0000th: 1326
        99.5000th: 4744
        99.9000th: 10000
        min=0, max=23394

Latency percentiles (usec)
        50.0000th: 23
        75.0000th: 29
        90.0000th: 34
        95.0000th: 37
        *99.0000th: 55
        99.5000th: 3292
        99.9000th: 9104
        min=0, max=25196

Latency percentiles (usec)
        50.0000th: 23
        75.0000th: 29
        90.0000th: 34
        95.0000th: 37
        *99.0000th: 711 
        99.5000th: 4600
        99.9000th: 9424
        min=0, max=19997

SIS_CACHE (5 runs)
=========
Latency percentiles (usec)                                                                                                                                                                                                                                                                                     
        50.0000th: 23
        75.0000th: 30
        90.0000th: 35
        95.0000th: 38
        *99.0000th: 1894
        99.5000th: 5464
        99.9000th: 10000
        min=0, max=19157

Latency percentiles (usec)
        50.0000th: 22
        75.0000th: 29
        90.0000th: 34
        95.0000th: 37
        *99.0000th: 2396
        99.5000th: 6664
        99.9000th: 10000
        min=0, max=24029

Latency percentiles (usec)
        50.0000th: 22
        75.0000th: 29
        90.0000th: 34
        95.0000th: 37
        *99.0000th: 2132
        99.5000th: 6296
        99.9000th: 10000
        min=0, max=25313

Latency percentiles (usec)
        50.0000th: 22
        75.0000th: 29
        90.0000th: 34
        95.0000th: 37
        *99.0000th: 1090
        99.5000th: 6232
        99.9000th: 9744
        min=0, max=27264

Latency percentiles (usec)
        50.0000th: 22
        75.0000th: 29
        90.0000th: 34
        95.0000th: 38
        *99.0000th: 1786
        99.5000th: 5240
        99.9000th: 9968
        min=0, max=24754

The above data as indicated has large run to run variation and in general, the latency is
high in case of SIS_CACHE for the 99th %ile.


schbench(new) with 6-mthreads
=============

Baseline
========
Wakeup Latencies percentiles (usec) runtime 30 (s) (209403 total samples)
	  50.0th: 8          (43672 samples)
	  90.0th: 13         (83908 samples)
	* 99.0th: 20         (18323 samples)
	  99.9th: 775        (1785 samples)
	  min=1, max=8400
Request Latencies percentiles (usec) runtime 30 (s) (209543 total samples)
	  50.0th: 13648      (59873 samples)
	  90.0th: 14000      (82767 samples)
	* 99.0th: 14320      (16342 samples)
	  99.9th: 18720      (1670 samples)
	  min=5130, max=38334
RPS percentiles (requests) runtime 30 (s) (31 total samples)
	  20.0th: 6968       (8 samples)
	* 50.0th: 6984       (23 samples)
	  90.0th: 6984       (0 samples)
	  min=6835, max=6991
average rps: 6984.77


SIS_CACHE
=========
Wakeup Latencies percentiles (usec) runtime 30 (s) (209295 total samples)
	  50.0th: 9          (49267 samples)
	  90.0th: 14         (86522 samples)
	* 99.0th: 21         (14091 samples)
	  99.9th: 1146       (1722 samples)
	  min=1, max=10427
Request Latencies percentiles (usec) runtime 30 (s) (209432 total samples)
	  50.0th: 13616      (62838 samples)
	  90.0th: 14000      (85301 samples)
	* 99.0th: 14352      (16149 samples)
	  99.9th: 21408      (1660 samples)
	  min=5070, max=41866
RPS percentiles (requests) runtime 30 (s) (31 total samples)
	  20.0th: 6968       (7 samples)
	* 50.0th: 6984       (21 samples)
	  90.0th: 6984       (0 samples)
	  min=6672, max=6996
average rps: 6981.07

In new schbench, I didn't observe run to run variation and also there was no regression
in case of SIS_CACHE for the 99th %ile.


>> producer_consumer avg time/access (lower is better)
>> ========
>> loads per consumer iteration   baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
>> 5                  		1.00 [ 0.00]( 0.00)            0.87 [ +13.0]( 1.92)
>> 20                   		1.00 [ 0.00]( 0.00)            0.92 [ +8.00]( 0.00)
>> 50                    		1.00 [ 0.00]( 0.00)            1.00 [  0.00]( 0.00)
>> 100                    		1.00 [ 0.00]( 0.00)            1.00 [  0.00]( 0.00)
>>
>> The main goal of the patch of improving cache locality is reflected as SIS_CACHE only improves in this workload, 
>> mainly when loads per consumer iteration is lower.
>>
>> hackbench normalized time in seconds (lower is better)
>> ========
>> case            load        baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
>> process-pipe    1-groups     1.00 [ 0.00]( 1.50)            1.02 [ -2.00]( 3.36)
>> process-pipe    2-groups     1.00 [ 0.00]( 4.76)            0.99 [ +1.00]( 5.68)
>> process-sockets 1-groups     1.00 [ 0.00]( 2.56)            1.00 [  0.00]( 0.86)
>> process-sockets 2-groups     1.00 [ 0.00]( 0.50)            0.99 [ +1.00]( 0.96)
>> threads-pipe    1-groups     1.00 [ 0.00]( 3.87)            0.71 [ +29.0]( 3.56)
>> threads-pipe    2-groups     1.00 [ 0.00]( 1.60)            0.97 [ +3.00]( 3.44)
>> threads-sockets 1-groups     1.00 [ 0.00]( 7.65)            0.99 [ +1.00]( 1.05)
>> threads-sockets 2-groups     1.00 [ 0.00]( 3.12)            1.03 [ -3.00]( 1.70)
>>
>> hackbench results are similar in both kernels except the case where there is an improvement of
>> 29% in case of threads-pipe case with 1 groups.
>>
>> Daytrader throughput (higher is better)
>> ========
>>
>> As per Ingo suggestion, ran a real life workload daytrader
>>
>> baseline:
>> =================================================================================== 
>>  Instance      1
>>      Throughputs         Ave. Resp. Time   Min. Resp. Time   Max. Resp. Time
>>   ================       ===============   ===============   ===============
>>        10124.5 			    2 		    0 		   3970
>>
>> SIS_CACHE:
>> ===================================================================================
>>  Instance      1
>>      Throughputs         Ave. Resp. Time   Min. Resp. Time   Max. Resp. Time
>>   ================       ===============   ===============   ===============
>>        10319.5                       2               0              5771
>>
>> In the above run, daytrader perfomance was 2% better in case of SIS_CACHE.
>>
> 
> Thanks for bringing this good news, a real life workload benefits from this change.
> I'll tune this patch a little bit to address the regression from schbench. Also to mention
> that, I'm working with Mathieu on his proposal to make the wakee choosing its previous
> CPU easier(similar to SIS_CACHE, but a little simpler), and we'll check how to make more
> platform benefit from this change.
> https://lore.kernel.org/lkml/20231012203626.1298944-1-mathieu.desnoyers@efficios.com/

Oh..ok. Thanks for the pointer!

> 
> thanks,
> Chenyu
>  

Thanks and Regards
Madadi Vineeth Reddy

