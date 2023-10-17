Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B43F7CBFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjJQJw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjJQJw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:52:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B218E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:52:54 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H9fRcZ003255;
        Tue, 17 Oct 2023 09:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : reply-to : from :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=oU0HjmAKuWhTRhBGrd4EgXNWqPXOJd9D5a0zINwtKQo=;
 b=XxnvNY3m32lN3z1ZitZmlNvU3hys2xVOk3LZQP3DkcTHhF0iiXOYmfBiXgVgASf1DiFn
 mcxFTiFBiD9WwfGiEnQugqBbH+INChb2IvC3VQzJmY8qooLTrCsnYyJHEwhmj9bDJxbJ
 RSw8txgmmp3iyCYsCrwSVn3zmbm0d3+aQ2CJEGy6twyt2gumPu4QZLcQEWdZZo4LNUCQ
 IxNkOeCCVTnBXyZk0grRBNQmong16Flq5fzMsbhE6nnNVuNDnYG+hcn0XJJbhKRWu+2c
 dep+S+OzXNak8VE9exFU/1u/WwPjDn/vzDi/MwnFgh7nUUZnKjxBvTNTUBfV3Yu3Q4Q8 Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsqk2h4y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 09:52:31 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39H9oDwS001007;
        Tue, 17 Oct 2023 09:50:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsqk2h0u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 09:50:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39H8t1ZV012871;
        Tue, 17 Oct 2023 09:49:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5py83sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 09:49:32 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39H9nV0j49152378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 09:49:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B938D58061;
        Tue, 17 Oct 2023 09:49:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3A445803F;
        Tue, 17 Oct 2023 09:49:25 +0000 (GMT)
Received: from [9.204.206.228] (unknown [9.204.206.228])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 09:49:25 +0000 (GMT)
Message-ID: <3f98806b-fd74-cfba-b48c-2526109d10a3@linux.ibm.com>
Date:   Tue, 17 Oct 2023 15:19:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
Reply-To: cover.1695704179.git.yu.c.chen@intel.com
From:   Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <cover.1695704179.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dnE5T0sniQzHuXGiI9zDL__cO01Qxyvm
X-Proofpoint-ORIG-GUID: DkEtEqRYhMpE0MTWtHQN_mqHj5ecHtrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=851 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170082
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu,

On 26/09/23 10:40, Chen Yu wrote:
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
> Thanks for your comments and review!
> 
> ----------------------------------------------------------------------

Regarding making the scan for finding an idle cpu longer vs cache benefits, 
I ran some benchmarks.

Tested the patch on power system with 12 cores. Total of 96 CPU's.
System has two NUMA nodes.

Below are some of the benchmark results

schbench 99.0th latency (lower is better)
========
case            load        	baseline[pct imp](std%)       SIS_CACHE[pct imp]( std%)
normal          1-mthreads      1.00 [ 0.00]( 3.66)            1.00 [  0.00]( 1.71)
normal          2-mthreads      1.00 [ 0.00]( 4.55)            1.02 [ -2.00]( 3.00)
normal          4-mthreads      1.00 [ 0.00]( 4.77)            0.96 [ +4.00]( 4.27)
normal          6-mthreads      1.00 [ 0.00]( 60.37)           2.66 [ -166.00]( 23.67)


schbench results are showing that there is not much impact in wakeup latencies due to more iterations 
in search for an idle cpu in the select_idle_cpu code path and interestingly numbers are slightly better 
for SIS_CACHE in case of 4-mthreads. I think we can ignore the last case due to huge run to run variations.

producer_consumer avg time/access (lower is better)
========
loads per consumer iteration   baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
5                  		1.00 [ 0.00]( 0.00)            0.87 [ +13.0]( 1.92)
20                   		1.00 [ 0.00]( 0.00)            0.92 [ +8.00]( 0.00)
50                    		1.00 [ 0.00]( 0.00)            1.00 [  0.00]( 0.00)
100                    		1.00 [ 0.00]( 0.00)            1.00 [  0.00]( 0.00)

The main goal of the patch of improving cache locality is reflected as SIS_CACHE only improves in this workload, 
mainly when loads per consumer iteration is lower.

hackbench normalized time in seconds (lower is better)
========
case            load        baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
process-pipe    1-groups     1.00 [ 0.00]( 1.50)            1.02 [ -2.00]( 3.36)
process-pipe    2-groups     1.00 [ 0.00]( 4.76)            0.99 [ +1.00]( 5.68)
process-sockets 1-groups     1.00 [ 0.00]( 2.56)            1.00 [  0.00]( 0.86)
process-sockets 2-groups     1.00 [ 0.00]( 0.50)            0.99 [ +1.00]( 0.96)
threads-pipe    1-groups     1.00 [ 0.00]( 3.87)            0.71 [ +29.0]( 3.56)
threads-pipe    2-groups     1.00 [ 0.00]( 1.60)            0.97 [ +3.00]( 3.44)
threads-sockets 1-groups     1.00 [ 0.00]( 7.65)            0.99 [ +1.00]( 1.05)
threads-sockets 2-groups     1.00 [ 0.00]( 3.12)            1.03 [ -3.00]( 1.70)

hackbench results are similar in both kernels except the case where there is an improvement of
29% in case of threads-pipe case with 1 groups.

Daytrader throughput (higher is better)
========

As per Ingo suggestion, ran a real life workload daytrader

baseline:
=================================================================================== 
 Instance      1
     Throughputs         Ave. Resp. Time   Min. Resp. Time   Max. Resp. Time
  ================       ===============   ===============   ===============
       10124.5 			    2 		    0 		   3970

SIS_CACHE:
===================================================================================
 Instance      1
     Throughputs         Ave. Resp. Time   Min. Resp. Time   Max. Resp. Time
  ================       ===============   ===============   ===============
       10319.5                       2               0              5771

In the above run, daytrader perfomance was 2% better in case of SIS_CACHE.

Thanks and Regards 
Madadi Vineeth Reddy

