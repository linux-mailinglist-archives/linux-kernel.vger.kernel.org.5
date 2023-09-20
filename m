Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4E7A720D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjITF3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjITF3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:29:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B538CA3;
        Tue, 19 Sep 2023 22:29:30 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K58bSj017764;
        Wed, 20 Sep 2023 05:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HgPVRe2GPXoADfxLn/c6DVH3ZFGuhOF64AX0q4GrC2M=;
 b=ebG9ek12U9bpNAzcMxzqDTo+tbszQc8AvX3YRhDC05AhVjBaf4anViTC0Uz0d8wd+RQR
 dAlOJJORX2okzP+6GfA/qFNS+y9lStTDbpAIGegbgmm8hwEgcRGukAUC0psud6WqGxAZ
 3m3koqR71+CQ65te/gacBjcD486VAz4KTBeW61lgkYlNlUbygOy2TzEt/lYufjUIjXPP
 /URCJc1uV/BVKj1J/JxcPol8REbfRWEpd9eF2YBIFItzKyaPu5m5sjDJ2gbTkVe9jKgI
 r+7OYtP9cFWtzEuANv2Zk5O27Vx7NdmfhMGdRZhlYycA7zQrNitvxcOcDhnaYRPMOeXN SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7spegyvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:29:21 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38K5IFtU015394;
        Wed, 20 Sep 2023 05:29:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7spegyv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:29:20 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38K3FDUe016841;
        Wed, 20 Sep 2023 05:29:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd22a4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:29:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38K5THMi459480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 05:29:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B47A258057;
        Wed, 20 Sep 2023 05:29:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B45A58062;
        Wed, 20 Sep 2023 05:29:15 +0000 (GMT)
Received: from [9.171.25.30] (unknown [9.171.25.30])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 20 Sep 2023 05:29:14 +0000 (GMT)
Message-ID: <0b3c7c1b-9905-cded-dc86-17296a10152a@linux.vnet.ibm.com>
Date:   Wed, 20 Sep 2023 10:59:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] cpufreq: Rebuild sched-domains when removing cpufreq
 driver
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     vschneid@redhat.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20230918112937.493352-1-pierre.gondois@arm.com>
 <ebc8f4cd-1ac6-e7c8-8e20-53bca964ce56@arm.com>
 <e25d912a-906d-82da-5b09-f2256ebfbfe3@arm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <e25d912a-906d-82da-5b09-f2256ebfbfe3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xd1hSlDH74JGbVn8BZynAQALHnvcps2V
X-Proofpoint-GUID: HY9JJPsCDFM0STLyGMsu3SpWgINIqaio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=528 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309200041
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/23 1:19 PM, Pierre Gondois wrote:
> 
> 
> On 9/19/23 01:03, Dietmar Eggemann wrote:
>> On 18/09/2023 13:29, Pierre Gondois wrote:
>>> The Energy Aware Scheduler (EAS) relies on the schedutil governor.
>>> When moving to/from the schedutil governor, sched domains must be
>>> rebuilt to allow re-evaluating the enablement conditions of EAS.
>>> This is done through sched_cpufreq_governor_change().
>>>

Hi Pierre. It looks correct to update when removing the 
cpufreq governer. 


>>> Having a cpufreq governor assumes having a cpufreq driver running.
>>> Inserting/removing a cpufreq driver should trigger a re-evaluation
>>> of EAS enablement conditions, avoiding to see EAS enabled when
>>> removing a running cpufreq driver.
>>>
>>> Add a sched_cpufreq_governor_change() call in cpufreq driver removal
>>> path.
>>
>> Rebuilding SDs when inserting the driver is already covered by
>>
>>    cpufreq_online()
>>      cpufreq_set_policy()
>>        sched_cpufreq_governor_change()
>>          if (old or new gov eq. schedutil)
>>            schedule_work(&rebuild_sd_work)
>>
>> So what's missing is only a sched_cpufreq_governor_change() call when
>> removing the driver, right?
> 
> Yes exact, removing a cpufreq driver (e.g. `rmmod cppc_cpufreq.ko`) goes
> through:
> cpufreq_remove_dev()
> \-__cpufreq_offline()
> 
> so the path you mentioned is not used in this case.
> 

One Doubt, while looking through code. Not well versed with this area. 

cpuhp_cpufreq_offline is being registered with CPU hotplug. That ends up 
calling cpufreq_offline. This may cause non desired issues.
1. rebuild of sched domains twice instead, once by CPU hotplug and once by this.
2. offline/online of CPU (non-SMT) may not disabling EAS. 




> Regards,
> Pierre
