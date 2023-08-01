Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101AC76C080
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjHAWhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHAWhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:37:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4801BE3;
        Tue,  1 Aug 2023 15:37:34 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371MGlnn007551;
        Tue, 1 Aug 2023 22:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bhrIWGIneu9mmTul72Q6nGdWxkny8cxueses2kgomZo=;
 b=Oqe0uVIUrWD6ZIMZ9GVnzkK1O1ug+5g00ZIXefb2vZ2zPrPw0pqZNShYkjnFrtcKMzPV
 yDiznCJiAa2Z6cfG32lYLQ5SSdRTWCkR0+QdT9lCM2uW4vG0Mv9it1XuI1rxonefGsEe
 UVEee56RhtZEp1lA5uWP/mblnzbfldVHhKr35E99f45BjJd0EOgRNhw5qdDmCupZJ0Xb
 7R0Q4K8ha/3K3sUoUMOE7NiXXP9c0dOaOG8ArzA29ti9pdZ//knTBNae6LW4UmLRgrq0
 x2xmpmP2JlG6J8dwZ044lT2TyDyAqO0QaSZDdKR0o7bJLGfWriLrMUoQmty46PPpyvq4 8A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6rhate9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 22:37:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371MbIjv026939
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 22:37:18 GMT
Received: from [10.110.118.24] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 1 Aug
 2023 15:37:16 -0700
Message-ID: <2fa11648-6d51-feb7-4d75-6429b13c682f@quicinc.com>
Date:   Tue, 1 Aug 2023 15:37:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/device: Add sysfs notification for UE,CE count
 change
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_psodagud@quicinc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20230731220059.28474-1-quic_djaggi@quicinc.com>
 <3e2bf03e-2bc1-445e-d8ce-4975c044eea0@quicinc.com>
 <ce06c845-f3c8-a733-dc21-ee0ba4b4ca68@quicinc.com>
From:   Deepti Jaggi <quic_djaggi@quicinc.com>
In-Reply-To: <ce06c845-f3c8-a733-dc21-ee0ba4b4ca68@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f8InXImUNaZNPOnQEieOOEdblc2wZdtl
X-Proofpoint-ORIG-GUID: f8InXImUNaZNPOnQEieOOEdblc2wZdtl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_19,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=619 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/2023 10:48 PM, Trilok Soni wrote:
> On 7/31/2023 3:40 PM, Trilok Soni wrote:
>> On 7/31/2023 3:00 PM, Deepti Jaggi wrote:
>>> A daemon running in user space collects information on correctable
>>> and uncorrectable errors from EDAC driver by reading corresponding
>>> sysfs entries and takes appropriate action.
>>
>> Which daemon we are referring here? Can you please provide the link to 
>> the project?
>>
>> Are you using this daemon?
>>
>> https://mcelog.org/ - It is for x86, but is your daemon project 
>> different?
>>

No this daemon is not used. Daemon is under development and it is more 
specific to Qualcomm use cases.
Based on my limited understanding of mcelog, this daemon is handling 
errors in an architecture specific way.
By adding support for sysfs notification in EDAC framework, drivers 
which are not using any custom sysfs attributes can take advantage of 
this modification to notify the user space daemon polling on ue_count 
and/or ce_count attributes.

>>> This patch adds support for user space daemon to wait on poll() until
>>> the sysfs entries for UE count and CE count change and then read updated
>>> counts instead of continuously monitoring the sysfs entries for
>>> any changes.
>>
>> The modifications below are architecture agnostic so I really want to 
>> know what exactly we are fixing and if there is a problem.
> 

In the change set, adding support for user space to poll on the ue_count 
and/or ce_count sysfs attributes.
On changes in ue_count,ce_count attributes, unblock user space poll from 
EDAC driver framework and user space can read the changed ce_count, 
ue_count.

As an example from user space perform the following steps:
	1. Open the sysfs attribute file for UE count and CE count
	2. Read the initial CE count and UE count
	3. Poll on any changes on CE count, UE count fds.
	4. Once poll unblocks, Read the updated count.
         5.Take appropriate action on the changed counts.

#####################################################################
Example Simple User space code Snippet:

#define MAX_POLL_FDS     2
char ue_count_file[] = 
"/sys/devices/system/edac/qcom-llcc/qcom-llcc0/ue_count";
char ce_count_file[] = 
"/sys/devices/system/edac/qcom-llcc/qcom-llcc0/ce_count";

struct pollfd *p_poll_fds = NULL;	
struct pollfd poll_fds[MAX_POLL_FDS] =  {0};
char data[100];

  poll_fds[0].fd = open(ue_count_file, O_RDONLY);
  poll_fds[1].fd = open(ce_count_file, O_RDONLY);

/*Read Initial value before poll and set poll events*/	
for (int i = 0; i < MAX_POLL_FDS; i++)	
  {	
	ret = read(poll_fds[i].fd, data, 100);	
         poll_fds[i].events = POLLPRI ;	
  }
p_poll_fds = &poll_fds[0];
while(1)	
  {	
     /*Block on poll until ue_count or ce_count change
     ret = poll(p_poll_fds, sizeof(poll_fds)/sizeof(struct pollfd) , -1);
     /*
      * Read the changed UE/CE count. lseek()
      * or close/re-open the changed fd
      */
     for(int i = 0; i < MAX_POLL_FDS; i++) {	
	 if( poll_fds[i].revents & POLLPRI)  {

	   ret = read(poll_fds[i].fd, data, 100);

            /*Take an appropriate action*/

	}
      }
}
######################################################################

> + CC linux-arm-msm
> 
> Please keep linux-arm-msm in CC if there is a next revision.
> 

Noted.


--Deepti
