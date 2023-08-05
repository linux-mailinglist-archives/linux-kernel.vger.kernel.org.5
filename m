Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244F077105E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 17:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjHEPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 11:38:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4A51A5
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 08:37:57 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 375FUUEo010871;
        Sat, 5 Aug 2023 15:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FJt9eh/pupGCRlr8VumiMH1NfPU6SVc2ENCGiSUG5hc=;
 b=H9a18q1LeW8KUJeht55IF5tnkiOJbQSu9OxQ9maTb4O6IbbsgUnAQeeJ97ju+5OeJX1a
 Nk8VJL6lD1xbh/ExUqiqlFZFjK6PdacLqTGzG+WkKpZzGufiJelnrdgfY5DwYsKMjuO7
 9BiN4QugwKAWvwyfEXrH+udz2/Oe5oLFNwFROVLsUq9LP2URGNRcBwPqUkcQOFQfrldu
 A/5PwZPrGu7RcDLNHUDdF9Vqdkm8MFdMomXa8VyzvImMDxbfOSogZMKwDljmjtXfCzYr
 YQ7LJ52J1tt8xtAC6iYzSmmXO3ERwEYLPHD5+B3UaQkbUotOKFHZt4w8QmrUbD8y1JqV Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9s4mr45a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Aug 2023 15:37:28 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 375FYODv022037;
        Sat, 5 Aug 2023 15:37:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9s4mr44n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Aug 2023 15:37:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 375FIA1R021623;
        Sat, 5 Aug 2023 15:37:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kmcq4bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Aug 2023 15:37:27 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 375FbQul24838804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Aug 2023 15:37:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8914758052;
        Sat,  5 Aug 2023 15:37:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCD5E58054;
        Sat,  5 Aug 2023 15:37:19 +0000 (GMT)
Received: from [9.171.19.239] (unknown [9.171.19.239])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Sat,  5 Aug 2023 15:37:19 +0000 (GMT)
Message-ID: <c8bca664-76cf-52d7-bd73-795b467c460b@linux.vnet.ibm.com>
Date:   Sat, 5 Aug 2023 21:07:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
 <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
 <cab82676-27fd-b4e1-2cd8-3d8d26b44aa0@linux.vnet.ibm.com>
 <447f756c-9c79-f801-8257-a97cc8256efe@efficios.com>
 <18912151-82c0-2936-10b1-f5fe7132287b@amd.com>
 <df826f20-d183-98d0-78cd-d11191f97b28@efficios.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <df826f20-d183-98d0-78cd-d11191f97b28@efficios.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VG5nhgsHe1vG4FZUxY3IWncR441Qq0rH
X-Proofpoint-GUID: B0oFBaOsYAYk-WAsERvAHngV6Cln5YjV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-05_15,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 mlxlogscore=944 phishscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308050147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/23 1:42 AM, Mathieu Desnoyers wrote:
> On 8/3/23 01:53, Swapnil Sapkal wrote:
> [...]
> 
> Those are interesting metrics. I still have no clue why it behaves that
> way though.

I was thinking this might be the case. some workload would benefit while
some would suffer. Specially ones which favor latency over cache might suffer. 

> 
> More specifically: I also noticed that the number of migrations is
> heavily affected, and that select_task_rq behavior changes drastically.
> I'm unsure why though.
> 

FWIU, load_balance uses idle_cpu to calculate the number of idle_cpus in the 
sched_domain. Maybe that is getting confused with 1ms delay concept. Likely 
sched_domain stay balanced because of this, and hence less migrations.
In select_rq_fair, prev_cpu will returned by wake_affine_idle since idle_cpu will return 
true more often. Hence task will get woken on the same CPU as before instead of migrating. 


on SMT systems, gain is further added by having the threads on single CPU, thereby
making it ST mode. That is subject to utilization. Running on ST is more faster compared
to running on SMT. 

-------------------------------------------------------------------------------------------

Ran the hackbench with perf stat on SMT system. That indicates slightly higher ST mode cycles
and ips improves slightly thereby making it faster. 


baseline 6.5-rc1:
hackbench -pipe (50 groups) 
Time: 0.67      ( Average of 50 runs)

    94,432,028,029      instructions              #    0.52  insn per cycle          
   168,130,543,309      cycles							  (% of total cycles)  
     1,162,153,934      PM_RUN_CYC_ST_MODE                                            ( 0.70% )
       613,018,646      PM_RUN_CYC_SMT2_MODE                                          ( 0.35% )
   166,358,778,832      PM_RUN_CYC_SMT4_MODE                                          (98.95%  ) 


Latest patch in this series.
https://lore.kernel.org/lkml/447f756c-9c79-f801-8257-a97cc8256efe@efficios.com/#t
hackbench -pipe (50 groups)
Time: 0.62      ( Average of 50 runs)

    92,078,390,150      instructions              #    0.55  insn per cycle  
   159,368,662,574      cycles   
     1,330,653,107      PM_RUN_CYC_ST_MODE                                            ( 0.83% )
       656,950,636      PM_RUN_CYC_SMT2_MODE                                          ( 0.41% )
   157,384,470,123      PM_RUN_CYC_SMT4_MODE                                          (98.75%  )


>>
>> Can you share your build config just in case I am missing something.
> 
> Build config attached.
> 
> Thanks,
> 
> Mathieu
> 
>>
>>>
>>> And using it now brings the hackbench wall time at 28s :)
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>>
>>>>>>>        struct task_struct    *stop;
>>>>>>>        unsigned long        next_balance;
>>>>>>>        struct mm_struct    *prev_mm;
>>>>>
>>>
>> -- 
>> Thanks and regards,
>> Swapnil
> 
