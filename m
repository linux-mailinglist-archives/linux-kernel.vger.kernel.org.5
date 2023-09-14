Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44127A0C10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbjINR5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240454AbjINR5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:57:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD561FFA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:57:29 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EHcD6q012538;
        Thu, 14 Sep 2023 17:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vOPcKnyHljDjibeB7w5ZE0BVr9lyfaAZZm+auMH3fKI=;
 b=FZjzhefRhhYighFQJJxXdtKJMvyivFrQGh8VnOrLfhGtc65BAaEf//3SlSL87glvMK08
 pio3LRfWb1Mx3dnRvO/R54N5xkYdE6br07j05W+dhSTRQfbX6WgoqH2/W5f0nmur2zfY
 QOODLWMwMDiUxOrHd61nKeGpOEMd2JUrHoJIqGk2kk56HBtgTz5mOKCiPStbTvB7j+XZ
 cKMsEfhYuWPK7W+CnJ6LwDHbru4Hb3qr6lnL3E5e5QNMEsu3Cj6RlpmEk/ZoTAAuu0Yc
 IEgl3B3+2JWafRIQmXcpJoSXGghwuHujuYME5pnJ6y2qr+IQnxvz9SoHKWfpqMLYhp78 fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t46gygu4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:57:05 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38EHkrcq022046;
        Thu, 14 Sep 2023 17:57:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t46gygu48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:57:04 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38EGmQk3024088;
        Thu, 14 Sep 2023 17:57:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t131tn58c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:57:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38EHv2Zl34865688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 17:57:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D549B58058;
        Thu, 14 Sep 2023 17:57:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43DC85805D;
        Thu, 14 Sep 2023 17:56:57 +0000 (GMT)
Received: from [9.171.8.153] (unknown [9.171.8.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Sep 2023 17:56:56 +0000 (GMT)
Message-ID: <7c6dd2ec-b9a9-b364-5a29-05336127e519@linux.vnet.ibm.com>
Date:   Thu, 14 Sep 2023 23:26:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
 <xhsmhil8cvi7s.mognet@vschneid.remote.csb>
Content-Language: en-US
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <xhsmhil8cvi7s.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o1_kDmx9PgOQStEn-Tr4dnw3ganXCgL-
X-Proofpoint-GUID: 3gBk3EaSDeoiu2c6BPXqTy2PLdHBQ-iW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=919 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 9:51 PM, Valentin Schneider wrote:
> On 13/09/23 17:18, Shrikanth Hegde wrote:
>> sysctl_sched_energy_aware is available for the admin to disable/enable
>> energy aware scheduling(EAS). EAS is enabled only if few conditions are
>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>> valid cpufreq policy, frequency invariant load tracking. It is possible
>> platform when booting may not have EAS capability, but can do that after.
>> For example, changing/registering the cpufreq policy.
>>
>> At present, though platform doesn't support EAS, this sysctl is still
>> present and it ends up calling rebuild of sched domain on write to 1 and
>> NOP when writing to 0. That is confusing and un-necessary.
>>
> 

Hi Valentin, Thanks for taking a look at this patch.

> But why would you write to it in the first place? Or do you mean to use
> this as an indicator for userspace that EAS is supported?
> 

Since this sysctl is present and its value being 1, it gives the 
impression to the user that EAS is supported when it is not. 
So its an attempt to correct that part. 

So, yes, this can be an indicator whether platform can do EAS at 
the moment or platform can do EAS and admin has explicitly disabled it. 

