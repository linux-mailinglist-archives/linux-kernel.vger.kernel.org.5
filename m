Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B597DBB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjJ3OOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3OOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:14:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AFBB7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:14:04 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDoRib024485;
        Mon, 30 Oct 2023 14:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qf1FSvwVcgKaq/tTfkCQ5FYVwbL6fYlm/tzw6/UI2vA=;
 b=dPut4q9jeYSqznN+vb/hkC9xuIWuzjptg/YynLPJ++xah46n0V0Bem0VGMg0tIWDplVk
 wNQ9jVmAlrC3nosoK+go3JaPBEO2dAkx9SRKuZr2ZDKVbuew1IK5Ll4Zccb71uHvDi8K
 +DJFRakTn/NhZYtDwewCMKYHvKNfmvqARIgtgjfukA+W2EVcav9PPulguC7xxx9tmt7m
 P91cekuuYL0s+WNrNEvepcme73xLDDEomzWu0icr1oF9IS9DIcsW8aAt0MstgtFJERg2
 U6/9Xc4nyXqagEmNRV8qUjo9/A9R+Yf+0Kq3KVf0hBDllGLOid1M6XSUBQEM2xTjqRrU 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2dqp8sme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 14:13:43 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UDoxDJ025735;
        Mon, 30 Oct 2023 14:13:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2dqp8sk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 14:13:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39UBxL3s007726;
        Mon, 30 Oct 2023 14:13:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmn9hkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 14:13:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39UEDfb326084092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:13:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78B3658059;
        Mon, 30 Oct 2023 14:13:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2258D58058;
        Mon, 30 Oct 2023 14:13:38 +0000 (GMT)
Received: from [9.171.79.141] (unknown [9.171.79.141])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Oct 2023 14:13:37 +0000 (GMT)
Message-ID: <3873b6cd-a983-41fe-8618-a5e5635a7c82@linux.vnet.ibm.com>
Date:   Mon, 30 Oct 2023 19:43:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix the decision for load balance
Content-Language: en-US
To:     Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc:     linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20231027171742.1426070-1-keisuke.nishimura@inria.fr>
 <27d88cac-95d2-4861-b79c-410e3cfd96a9@linux.vnet.ibm.com>
 <CAKfTPtC=H4P_Hn7koJfWwfqVc7UyWNzzyrFWymnoYVK3pJkiDQ@mail.gmail.com>
 <c78aa476-44c7-4691-ae6b-d4b5ebc83c25@inria.fr>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <c78aa476-44c7-4691-ae6b-d4b5ebc83c25@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ayX-7TOKj8GQjjCC5_OBC7kZrR9nRAIR
X-Proofpoint-GUID: M7RoVcEim-cjLZn_ijKuRUaElRoLWQ9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/23 3:32 PM, Keisuke Nishimura wrote:
> 
> 
> On 30/10/2023 09:05, Vincent Guittot wrote:
>> On Mon, 30 Oct 2023 at 05:03, Shrikanth Hegde
>> <sshegde@linux.vnet.ibm.com> wrote:
>>>
>>>
>>>
>>> On 10/27/23 10:47 PM, Keisuke Nishimura wrote:
>>>> should_we_balance is called for the decision to do load-balancing.
>>>> When sched ticks invoke this function, only one CPU should return
>>>> true. However, in the current code, two CPUs can return true. The
>>>> following situation, where b means busy and i means idle, is an
>>>> example because CPU 0 and CPU 2 return true.
>>>>
>>>>          [0, 1] [2, 3]
>>>>           b  b   i  b
>>>>
>>>> This fix checks if there exists an idle CPU with busy sibling(s)
>>>> after looking for a CPU on an idle core. If some idle CPUs with busy
>>>> siblings are found, just the first one should do load-balancing.
>>>>
>>>
>>>> Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the
>>>> whole core for load balance")
>>>> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
>>>> ---
>>>>   kernel/sched/fair.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 2048138ce54b..eff0316d6c7d 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -11083,8 +11083,9 @@ static int should_we_balance(struct lb_env
>>>> *env)
>>>>                return cpu == env->dst_cpu;
>>>>        }
>>>>
>>>
>>>
>>> There is comment above this /* Are we the first idle CPU? */
>>> Maybe update that comment as /* Are we the first idle core */
>>
>> I was about to say the same but it's not always true. If we are at SMT
>> level, we look for an idle CPU in the core
>>
> 
> Maybe I should update the comment with the additional contexts:
> 
> /*
>  * Are we the first idle core in a sched_domain not-sharing capacity,
>  * or the first idle CPU in a sched_domain sharing capacity?
>  */
> 


/*
 * Are we the first idle core in a MC or higher domain
 * or the first idle CPU in a SMT domain
 */


> 
>>>
>>>> -     if (idle_smt == env->dst_cpu)
>>>> -             return true;
>>>> +     /* Is there an idle CPU with busy siblings? */
>>> nit: We can keep the comment style fixed in this function.
>>> /* Are we the first idle CPU with busy siblings */
>>>
> 
> OK, agreed. Should I create version 2?

Yes. That would be good.

> 
> thanks,
> Keisuke
> 
>>>> +     if (idle_smt != -1)
>>>> +             return idle_smt == env->dst_cpu;
>>>>
>>>>        /* Are we the first CPU of this group ? */
>>>>        return group_balance_cpu(sg) == env->dst_cpu;
>>>
>>> code changes LGTM
>>> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
