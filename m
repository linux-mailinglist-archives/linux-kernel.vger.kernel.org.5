Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD19879F059
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjIMRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjIMRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:22:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29181A3;
        Wed, 13 Sep 2023 10:22:46 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DCVEi6016097;
        Wed, 13 Sep 2023 17:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hvCVL4Af4zagYv23G23r8OybsiJ9AMifzesX0uokHy4=;
 b=aXaynT4iAd0eQlmE3oVU0KPcCYUpFbl6wCDiJNFPDbcvuE5n74kIW+RrOxQuv+E80gdN
 USEV2VhTdtz3Oowi3gjTs2/RnvM8l8wSuXATTz9hU4ZP4QywJvZYw3hdjwrtanlYz/ip
 Rma8zDrA+1GUmOWOWDSx6pUBJfiNHg3MU/CXWgkUVDVOjb0QCdkbRd1kVs+wcOmlMxuF
 UfX7Amvs5H07UtC3iUshauJU8+CacBrX/zi5MJGGOlIU9bcgztWA/a+erM0BtrA8+/KL
 EUORGuizeEalT1mA7t8XDYVHEXfCGaR97oumvlFhAjDqtKzbj7iZEtfzUOSYaPikct/X ng== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3003j83v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 17:22:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38DHMUOp029014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 17:22:30 GMT
Received: from [10.110.7.172] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 10:22:27 -0700
Message-ID: <d7b5fd59-8e35-79c8-cf6f-63a8b188593a@quicinc.com>
Date:   Wed, 13 Sep 2023 10:22:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] EDAC/device: Add sysfs notification for UE,CE count
 change
Content-Language: en-US
To:     Deepti Jaggi <quic_djaggi@quicinc.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_psodagud@quicinc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20230731220059.28474-1-quic_djaggi@quicinc.com>
 <3e2bf03e-2bc1-445e-d8ce-4975c044eea0@quicinc.com>
 <ce06c845-f3c8-a733-dc21-ee0ba4b4ca68@quicinc.com>
 <2fa11648-6d51-feb7-4d75-6429b13c682f@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <2fa11648-6d51-feb7-4d75-6429b13c682f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LN7Q61oFen1MjrVjZPA_sug_q1HWMtg1
X-Proofpoint-GUID: LN7Q61oFen1MjrVjZPA_sug_q1HWMtg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_10,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=672 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2023 3:37 PM, Deepti Jaggi wrote:
> On 7/31/2023 10:48 PM, Trilok Soni wrote:
>> On 7/31/2023 3:40 PM, Trilok Soni wrote:
>>> On 7/31/2023 3:00 PM, Deepti Jaggi wrote:
>>>> A daemon running in user space collects information on correctable
>>>> and uncorrectable errors from EDAC driver by reading corresponding
>>>> sysfs entries and takes appropriate action.
>>>
>>> Which daemon we are referring here? Can you please provide the link to the project?
>>>
>>> Are you using this daemon?
>>>
>>> https://mcelog.org/ - It is for x86, but is your daemon project different?
>>>
> 
> No this daemon is not used. Daemon is under development and it is more specific to Qualcomm use cases.
> Based on my limited understanding of mcelog, this daemon is handling errors in an architecture specific way.
> By adding support for sysfs notification in EDAC framework, drivers which are not using any custom sysfs attributes can take advantage of this modification to notify the user space daemon polling on ue_count and/or ce_count attributes.


Did you look at the rasdaemon then?

https://github.com/mchehab/rasdaemon - rasdaemon is also used on more than one architecture including ARM. 


> 
>>>> This patch adds support for user space daemon to wait on poll() until
>>>> the sysfs entries for UE count and CE count change and then read updated
>>>> counts instead of continuously monitoring the sysfs entries for
>>>> any changes.
>>>
>>> The modifications below are architecture agnostic so I really want to know what exactly we are fixing and if there is a problem.
>>
> 
> In the change set, adding support for user space to poll on the ue_count and/or ce_count sysfs attributes.
> On changes in ue_count,ce_count attributes, unblock user space poll from EDAC driver framework and user space can read the changed ce_count, ue_count.
> 
> As an example from user space perform the following steps:
>     1. Open the sysfs attribute file for UE count and CE count
>     2. Read the initial CE count and UE count
>     3. Poll on any changes on CE count, UE count fds.
>     4. Once poll unblocks, Read the updated count.
>         5.Take appropriate action on the changed counts.
> 
> #####################################################################
> Example Simple User space code Snippet:

All of this resolved in the EDAC framework by tracing per my understanding. If any changes required
we should extend the rasdaemon and show the usecase to explain the it better?

This is very old link but if you follow this patch series you will understand the tracing events in the EDAC
and latest EDAC framework code will help. 

https://lkml.indiana.edu/hypermail/linux/kernel/1205.1/01751.html

-- 
---Trilok Soni

