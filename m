Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47103800CA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379076AbjLAN4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379060AbjLAN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:56:48 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01526BC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:56:54 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DYtPe005182;
        Fri, 1 Dec 2023 13:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : reply-to : from :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=3ZxkDESyoMAB+q846kEjbTqewcNq0RNz7Qif+xxbj9Q=;
 b=EaDUnKn7xUFk6SB7J7PAhYxRBOaQEsHrhBo5RMC7X7KJxCAnlmAvPDFaYFdQ/uUIiFfd
 60WXYK4hByzMTDixjjqHGf3LBLWMkTmedwJJzjnVLJxfhq3quWqrvlfxJygyDeiwRle6
 nsAl9JtbbbgEg7DI5U+k4TEPi1aXbTUpwGjXURtGZMUvvdh26k3M1S6NEAs3GKSO08f5
 5Er0YcyFW9sAdbbZKsuNkqnpBxHx6zCGUVW3YF1jrpfFwpCRSYeoQc2fG1LSEzz+v71N
 f2dxMK9Z0BlVY5VSDRtixEPGxM651waZEXXK5iG8DbwCNesOntsGm9HapyZoJ+nnuYFW 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqgg9rnn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 13:56:50 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1DZVfP006941;
        Fri, 1 Dec 2023 13:56:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqgg9rnn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 13:56:49 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1Dn3ww002612;
        Fri, 1 Dec 2023 13:56:49 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8p5bet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 13:56:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DunOs26673808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Dec 2023 13:56:49 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E79B25803F;
        Fri,  1 Dec 2023 13:56:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB4CB58064;
        Fri,  1 Dec 2023 13:56:42 +0000 (GMT)
Received: from [9.171.1.191] (unknown [9.171.1.191])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  1 Dec 2023 13:56:42 +0000 (GMT)
Message-ID: <37cd9872-7a59-d614-fbcb-ef9e1eae185c@linux.ibm.com>
Date:   Fri, 1 Dec 2023 19:26:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] sched/fair: do not scribble cache-hot CPU in
 select_idle_cpu()
Content-Language: en-US
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Chen Yu <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1700548379.git.yu.c.chen@intel.com>
 <35e612eb2851693a52f7ed1ff9be5bc24011136f.1700548379.git.yu.c.chen@intel.com>
 <3dd5ae53-a914-bfd1-285e-e206ba0c58bd@linux.ibm.com>
 <CADjb_WTFrPAgf5h1af4GuMFJ8UrDjzCPb_K+SZFo5s80xcniVA@mail.gmail.com>
Reply-To: CADjb_WTFrPAgf5h1af4GuMFJ8UrDjzCPb_K+SZFo5s80xcniVA@mail.gmail.com
From:   Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <CADjb_WTFrPAgf5h1af4GuMFJ8UrDjzCPb_K+SZFo5s80xcniVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z9Q6Gdce9sa6Y3cLpH73qM9RjoiOVdp1
X-Proofpoint-GUID: PWGXZ1nAXgwlkvi-QbK2kAHeysvu4yoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=977 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010094
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/23 12:13, Chen Yu wrote:
> Hi Madadi,
> 
> On Thu, Nov 30, 2023 at 1:26 AM Madadi Vineeth Reddy
> <vineethr@linux.ibm.com> wrote:
>>
>> Hi Chen Yu,
>>
> [snip...]
> 
>>
>> As per my understanding, if the task which tagged a particular CPU as cache hot has woken up before
>> the cache_hot_timeout, we still don't allow that task to run on that particular CPU. Is this correct?
>>
> 
> Not exactly. When we reached select_idle_cpu(), we have already
> checked if the wakee's previous CPU
> is idle or not in select_idle_sibling(), if it is idle, we don't check
> the cache-hot tag and return the wakee's
> previous CPU directly in select_idle_sibling().

Yeah..got it. Thanks.

So, the way another task(t') can select the cache hot tagged cpu(tagged for task t) is when t' gets 
it's target cpu as this cache hot tagged cpu from wake_affine() in select_task_rq_fair. 
The other way being /* pick the first cache-hot CPU as the last resort */.

> 
> thanks,
> Chenyu
> 
>> If correct, then why don't we let the task to select the CPU if it's the one that tagged it?
>>
>> Thanks and Regards
>> Madadi Vineeth Reddy

Thanks and Regards
Madadi Vineeth Reddy

