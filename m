Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933687DB262
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 05:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjJ3EEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 00:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3EEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 00:04:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FF6AB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 21:03:58 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U3itPu017379;
        Mon, 30 Oct 2023 04:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aUBSFLad13w2Gnt+FqCyDcyoBIV9kAQ5o4XY5n66cNU=;
 b=eZcdGFWk3J3cDTObzsbCo464LpPo6lMNdRuOMdYZ0GgW9PrwWKnfOkHyXzb2575vGylW
 4EPDhsxwHVdlOpmYz8IrbrJ11bSQiVm30ybs1MOz5YWImYtYQv9RAY1B/p02I5YTw3MY
 W2Q5PxG9Brr5lwjjiZCKrbTSUePJ5ISPkeA/68L0El7RuyIEXfc2FZqmFU61DB5neh14
 k51wD1aYMGkXeK1XJGNuGs47kahuA569LEXOEzXfKrgdpqqL4q1brkFBw+hdhl563J+L
 fN0TpUVzlV2Xl6SAJ5TPf6mOLmg9qoDZ1kcQ3U7AqIb+D3qn1i0a9fYqEeSYTVZT9T1m HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u24ujgaes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 04:03:34 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39U3kNb4021858;
        Mon, 30 Oct 2023 04:03:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u24ujgaeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 04:03:33 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39U11am6031377;
        Mon, 30 Oct 2023 04:03:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1fb1p173-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 04:03:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39U43Wga3015380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 04:03:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36DE558068;
        Mon, 30 Oct 2023 04:03:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E78A658052;
        Mon, 30 Oct 2023 04:03:28 +0000 (GMT)
Received: from [9.179.2.241] (unknown [9.179.2.241])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Oct 2023 04:03:27 +0000 (GMT)
Message-ID: <27d88cac-95d2-4861-b79c-410e3cfd96a9@linux.vnet.ibm.com>
Date:   Mon, 30 Oct 2023 09:33:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix the decision for load balance
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
Content-Language: en-US
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20231027171742.1426070-1-keisuke.nishimura@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a4GqfDIwk98yrqgs1MdUe55k5zgk_6Da
X-Proofpoint-GUID: j_XJmRp7Ec7AQ0wi4G5PULa1B2TqOLNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_02,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/23 10:47 PM, Keisuke Nishimura wrote:
> should_we_balance is called for the decision to do load-balancing.
> When sched ticks invoke this function, only one CPU should return
> true. However, in the current code, two CPUs can return true. The
> following situation, where b means busy and i means idle, is an
> example because CPU 0 and CPU 2 return true.
> 
>         [0, 1] [2, 3]
>          b  b   i  b
> 
> This fix checks if there exists an idle CPU with busy sibling(s)
> after looking for a CPU on an idle core. If some idle CPUs with busy
> siblings are found, just the first one should do load-balancing.
> 

> Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> ---
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2048138ce54b..eff0316d6c7d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11083,8 +11083,9 @@ static int should_we_balance(struct lb_env *env)
>  		return cpu == env->dst_cpu;
>  	}
>  


There is comment above this /* Are we the first idle CPU? */
Maybe update that comment as /* Are we the first idle core */

> -	if (idle_smt == env->dst_cpu)
> -		return true;
> +	/* Is there an idle CPU with busy siblings? */
nit: We can keep the comment style fixed in this function.
/* Are we the first idle CPU with busy siblings */

> +	if (idle_smt != -1)
> +		return idle_smt == env->dst_cpu;
>  
>  	/* Are we the first CPU of this group ? */
>  	return group_balance_cpu(sg) == env->dst_cpu;

code changes LGTM
Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
