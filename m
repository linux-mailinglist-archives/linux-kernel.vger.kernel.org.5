Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B0C7DECE7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKBGgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBGgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:36:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C3D128;
        Wed,  1 Nov 2023 23:35:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A24Hib5011674;
        Thu, 2 Nov 2023 06:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z1hzAccBs35bbFDTQLkaAfIUEDshACC647nEMxIden4=;
 b=X/YRAJhj6Ho+Bc9iQHCjuBWdZ7ythyE39QQFN4qTGWJ4ysG4103l1zoRyjQ5RJvDM3gs
 KWbH2oDO3okAjKPo1WxD43EAvLtVsHWNhVN4qMWJ5Xo8hI9e7xhK1XlSW89kR8+9JW19
 nnp94rWbbBWRirj1lOfxnrZ/EME/bF+WfG77niqH52D/YDRXtggWOgNmcNXYbk6zaNhD
 GJ4+0pP69I52ORwHLGfsvUBYf/fvyXeFXslATUBGHiLvcsJAX0bOzWLprv+jMP3bG4yv
 LluNeLjoC1K6CvcOu7aGBelYjjSNZ/TlxDm2aFzSOiCjaoeUY3SySNuNu9ejYmKsfNw+ tg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3y5y0q7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 06:35:46 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A26ZjXs000469
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Nov 2023 06:35:46 GMT
Received: from [10.216.63.119] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 1 Nov
 2023 23:35:43 -0700
Message-ID: <0be16a8e-5f4f-4c26-d6b1-c090accfac5c@quicinc.com>
Date:   Thu, 2 Nov 2023 12:05:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] eventfs: Fix kerneldoc of eventfs_remove_rec()
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20231030121523.0b2225a7@gandalf.local.home>
 <9d71fc3b-f7a9-9f23-6fbe-a7665954cd30@quicinc.com>
 <20231101160035.12824b55@gandalf.local.home>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231101160035.12824b55@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JI0hggNqoyt6RMyP3qkVkpNEcpctw3Sb
X-Proofpoint-ORIG-GUID: JI0hggNqoyt6RMyP3qkVkpNEcpctw3Sb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=831 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020050
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2023 1:30 AM, Steven Rostedt wrote:
> On Mon, 30 Oct 2023 21:57:13 +0530
> Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> 
>> On 10/30/2023 9:45 PM, Steven Rostedt wrote:
>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>
>>> The eventfs_remove_rec() had some missing parameters in the kerneldoc
>>> comment above it. Also, rephrase the description a bit more to have a bit
>>> more correct grammar.
>>>
>>> Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode");
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202310052216.4SgqasWo-lkp@intel.com/
>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> Hi Mukesh!
> 
> First, I want to thank you for your reviews. We certainly need more
> reviewers.
> 
> But I need to also state that "Reviewed-by" tags should not be sent so
> lightly. The only times a Reviewed-by tag should be sent is if you
> participated in the discussion of the code, you have authored some of
> the code that is being modified, or are marked as a reviewer of the code in
> the MAINTAINERS file.

Thanks Steven for writing a suggestion note for me.

I will try to participate and take this in a good way..but i thought
for easier change where there is no discussion is needed., it is fine
to add if you have spent time in checking the code and change is proper.

> 
> For example, you added to the discussion here:
> 
>     https://lore.kernel.org/all/65dcdd9c-a75b-4fe7-bdcf-471a5602db20@linaro.org/
> 
> And adding your Reviewed-by tag is appropriate.
> 
> But when a maintainer receives a Reviewed-by from someone they don't know,
> without any discussion in the patch, it may make that maintainer think that
> the person sending the Reviewed-by is only out to get listed in the LWN
> "Reviewed-by" count.

I understand..

> 
> I review other developers' code all the time, and unless the code touches
> something I worked on or I'm marked as a reviewer in the MAINTAINERS file,
> I do not send a Reviewed-by tag unless I added some input to the patch in
> question.

Will keep this in mind.
To get involve in LKML discussion, Sending Reviewed-by may not be
important but the discussions/engagement/contribution is .
> 
> My advice to you is to keep up the reviewing, I appreciate it (I really
> do!), but don't send out Reviewed-by tags unless you are marked as a
> reviewer of the code, or participated in a discussion on that code.

Sure, thanks, will try to do my bit.

-Mukesh

> 
> Thanks,
> 
> -- Steve
> 
