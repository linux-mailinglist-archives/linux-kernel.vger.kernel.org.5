Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5398A793378
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbjIFBsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIFBsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:48:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405611BB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 18:48:42 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3861g5Pa028393;
        Wed, 6 Sep 2023 01:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=x3YtfnG4uC0WZSCl+n8Bgg/NMH3S6XbppsRAX+R0E3w=;
 b=G7k84CvQjktIn7cqcG6DTssBDLD392WYMRQN56YgEv3lDUh5vA8PnIIGqzhUo8xP5LBX
 uJDEv/JM8C9JYt5ZSfVSCeNrx0rV1h0vgaLdhMpxvcXgU0KfcxW2qNrnKyuXSQrgNJeV
 PNZ8J+GzDVjznI9v+fwn4EsWOI1gziShL335X8jINi9gQ2Gr0lH33AYSpdHczoGDol6k
 0NkLqiPoN9+mEBatGf2wg4Z8E+Vp3/ZRyuXB/c7GrSXCqQB5BcEw4INosUYPrPSaoDQp
 kwAheE4pK5k+A/t41/1uxlK0sLJyYDuhiKZ9oMmbBxpQ5ENlI1QdmhweOR1SLpRljHRQ vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxg0503mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 01:48:18 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3861gGYg028625;
        Wed, 6 Sep 2023 01:48:18 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxg0503m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 01:48:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3860jS8l012232;
        Wed, 6 Sep 2023 01:48:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjy13x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 01:48:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3861mGQl35455512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Sep 2023 01:48:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FD2A58056;
        Wed,  6 Sep 2023 01:48:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11DCD5805D;
        Wed,  6 Sep 2023 01:48:11 +0000 (GMT)
Received: from [9.171.19.125] (unknown [9.171.19.125])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  6 Sep 2023 01:48:10 +0000 (GMT)
Message-ID: <e96c04b2-0c63-74f7-b7ca-357177ef3eb7@linux.vnet.ibm.com>
Date:   Wed, 6 Sep 2023 07:18:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: optimize should_we_balance for higher SMT
 systems
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yu.c.chen@intel.com,
        ricardo.neri-calderon@linux.intel.com, iamjoonsoo.kim@lge.com,
        tim.c.chen@linux.intel.com, juri.lelli@redhat.com,
        rocking@linux.alibaba.com, joshdon@google.com
References: <20230902081204.232218-1-sshegde@linux.vnet.ibm.com>
 <ZPMVcTFmtvshJRYH@gmail.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <ZPMVcTFmtvshJRYH@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HML7rYIO71-jz7JtV_hjhxp-Qg7dIgc0
X-Proofpoint-ORIG-GUID: rijr9LxmwEGtvs-Kw22MXh916kfbCbJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 mlxlogscore=843 bulkscore=0 spamscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309060012
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/23 4:28 PM, Ingo Molnar wrote:
> 
> * Shrikanth Hegde <sshegde@linux.vnet.ibm.com> wrote:
> 
>> should_we_balance is called in load_balance to find out if the CPU that
>> is trying to do the load balance is the right one or not.
>> With commit b1bfeab9b002("sched/fair: Consider the idle state of the whole
>> core for load balance"), tries to find an idle core to do the load balancing
>> and fallsback on an idle sibling CPU if there is no idle core.
>>
>> However, on larger SMT systems, it could be needlessly iterating to find a
>> idle by scanning all the CPUs in an non-idle core. If the core is not idle,
>> and first SMT sibling which is idle has been found, then its not needed to
>> check other SMT siblings for idleness
>>
>> Lets say in SMT4, Core0 has 0,2,4,6 and CPU0 is BUSY and rest are IDLE.
>> balancing domain is MC/DIE. CPU2 will be set as the first idle_smt and
>> same process would be repeated for CPU4 and CPU6 but this is unnecessary.
>> Since calling is_core_idle loops through all CPU's in the SMT mask, effect
>> is multiplied by weight of smt_mask. For example,when say 1 CPU is busy,
>> we would skip loop for 2 CPU's and skip iterating over 8CPU's. That
>> effect would be more in DIE/NUMA domain where there are more cores.
>>
>> Testing and performance evaluation
>> The test has been done on this system which has 12 cores, i.e 24 small
>> cores with SMT=4
>> lscpu
>> Architecture:            ppc64le
>>   Byte Order:            Little Endian
>> CPU(s):                  96
>>   On-line CPU(s) list:   0-95
>> Model name:              POWER10 (architected), altivec supported
>>   Thread(s) per core:    8
> 
> Ok, so the performance figures are pretty convincing, and the approach
> is fairly simple - so I've applied your patch to tip:sched/urgent,
> to address the performance regression caused by b1bfeab9b002.
> 
> Thanks,
> 
> 	Ingo

Thank you Ingo. 
