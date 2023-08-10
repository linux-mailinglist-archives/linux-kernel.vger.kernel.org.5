Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CEC777C85
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjHJPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjHJPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:44:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B4E26B6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:44:26 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AFV0aj002173;
        Thu, 10 Aug 2023 15:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W6HbqaxlGyAO2on1EbXw/Y399wjEpJX9NnGNU5Xc6LM=;
 b=HqrrAVyhCpWrnR2y7XouK7fradu4WfVArvNDfft08VdhOk8VZTzRICv8+xdd4TjbtfMn
 uQb6o8vOI5B93clWmefn/zdjSK/c0P9pxmgWeLwXDfXf0O7+l6VQKCWuQ6AsWIx6x/Bp
 7nneWs2F6G+UC+Yw868bt0KW2rPQ/PBcJnQBM5jt7IHI0Ks8VY/nkHf/hbyESYfiYaSU
 QybcMu6uGGkaBliuobPeaHlzCHzyUIrvvG/OipFeSPMANpd9a/8C0PIX8f5Xvq7V2xvq
 VQxj1LN1sTyRSE/rVcy40oLv2kYrVpoe/LbgjdN47yy7BadBA32HrZESNuAZE6t0g+a2 uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sd2kv0cey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 15:44:12 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37AFe8CZ014934;
        Thu, 10 Aug 2023 15:44:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sd2kv0cee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 15:44:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37AFLGri006421;
        Thu, 10 Aug 2023 15:44:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sd2ev84qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 15:44:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37AFiAg32360018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 15:44:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDC695805A;
        Thu, 10 Aug 2023 15:44:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 159835805E;
        Thu, 10 Aug 2023 15:44:08 +0000 (GMT)
Received: from [9.179.28.167] (unknown [9.179.28.167])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 10 Aug 2023 15:44:07 +0000 (GMT)
Message-ID: <5f0824ea-d7b6-61f5-db89-1727bae83595@linux.vnet.ibm.com>
Date:   Thu, 10 Aug 2023 21:14:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH] sched/fair: Skip idle CPU search on busy system
Content-Language: en-US
To:     Vishal Chourasia <vishalc@linux.ibm.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de
References: <20230726093612.1882644-1-sshegde@linux.vnet.ibm.com>
 <ZNPedInw6Cgh++Xa@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <ZNPedInw6Cgh++Xa@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oCVD6jSkQr3lqVIlFs-O0QqD2ojgDMD5
X-Proofpoint-GUID: ulfyZEnMV22GL6WENHfF2GG9pfeJzM90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_13,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=789
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100133
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/23 12:14 AM, Vishal Chourasia wrote:
> On Wed, Jul 26, 2023 at 03:06:12PM +0530, Shrikanth Hegde wrote:
>> When the system is fully busy, there will not be any idle CPU's.
>>
> Tested this patchset on top of v6.4
[...]
> 5 Runs of stress-ng (100% load) on a system with 16CPUs spawning 23 threads for
> 60 minutes.
> 
> stress-ng: 16CPUs, 23threads, 60mins
> 
> - 6.4.0
> 
> | completion time(sec) |      user |        sys |
> |----------------------+-----------+------------|
> |              3600.05 |  57582.44 |       0.70 |
> |              3600.10 |  57597.07 |       0.68 |
> |              3600.05 |  57596.65 |       0.47 |
> |              3600.04 |  57596.36 |       0.71 |
> |              3600.06 |  57595.32 |       0.42 |
> |              3600.06 | 57593.568 |      0.596 | average
> |          0.046904158 | 12.508392 | 0.27878307 | stddev
> 
> - 6.4.0+ (with patch)
> 
> | completion time(sec) |      user |         sys |
> |----------------------+-----------+-------------|
> |              3600.04 |  57596.58 |        0.50 |
> |              3600.04 |  57595.19 |        0.48 |
> |              3600.05 |  57597.39 |        0.49 |
> |              3600.04 |  57596.64 |        0.53 |
> |              3600.04 |  57595.94 |        0.43 |
> |             3600.042 | 57596.348 |       0.486 | average
> |         0.0089442719 | 1.6529610 | 0.072938330 | stddev
> 
> The average system time is slightly lower in the patched version (0.486 seconds)
> compared to the 6.4.0 version (0.596 seconds). 
> The standard deviation for system time is also lower in the patched version
> (0.0729 seconds) than in the 6.4.0 version (0.2788 seconds), suggesting more
> consistent system time results with the patch.
> 
> vishal.c

Thank you very much Vishal for trying this out. 

Meanwhile, I am yet to try the suggestion given by chen. Let me see if that works okay.
