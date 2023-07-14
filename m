Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10855752F03
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjGNB4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjGNB4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:56:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B65E272E;
        Thu, 13 Jul 2023 18:56:44 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E1IpSv022241;
        Fri, 14 Jul 2023 01:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hEFYY1f/3z8thoYRinO1hnRR66bF9a/LRoOeYNqzDMY=;
 b=YPbSZIoSrdxZkqRXooOpvyWJkztdrEDPuI4Z66GfYSPEULY2ZeMvqpFEnpBYGjrLHSqL
 zqDB4Io+Jp2P9fFBvhs4MtiEbmgxq3NT/kSdW4SKXZUMmMp1iXOVAMTHU3suR0sBBAfA
 BZXNQsGSElexvRQh1AB92FWKdYH1brROdoN1lo1BpSkAC5wDLXSl5LND/ex5H3gqWare
 i02FmI6vgxpo8S2ZPI18dNoapx4cChQLznty7Qd+ljEP13dV5OnwTykDKldFFi8S2rzF
 oLwNzhqP2SGl1I5J7lC9+rwQYxk8qM4boF/c52I6n6/YKVJcsOdoniQW+PMfOqkR/3E1 AA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtptw0m0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 01:56:35 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E1uZM4011232
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 01:56:35 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 18:56:31 -0700
Message-ID: <6d1a6691-f858-71bf-97fe-97e13fcb93b6@quicinc.com>
Date:   Fri, 14 Jul 2023 09:56:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Will Deacon <will@kernel.org>, <corbet@lwn.net>,
        <catalin.marinas@arm.com>, <maz@kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_satyap@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_songxue@quicinc.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710093751.GC32673@willie-the-truck>
 <5cf15f85-0397-96f7-4110-13494551b53b@quicinc.com>
 <20230711082226.GA1554@willie-the-truck>
 <84f0994a-26de-c20a-a32f-ec8fe41df3a3@quicinc.com>
 <20230711102510.GA1809@willie-the-truck>
 <67c2621f-4cad-2495-9785-7737246d3e90@quicinc.com>
 <ZK5X9bXQT7GBxNHj@FVFF77S0Q05N.emea.arm.com>
 <604ac52d-4336-744f-2ab8-44d1c93fbaa8@quicinc.com>
 <ZK_d86ApI1FCHhTL@FVFF77S0Q05N.cambridge.arm.com>
 <e02b9969-a3ca-a80d-1d32-25d2bf4c72b6@quicinc.com>
 <ZLBLwG2LJ4gZLfbh@FVFF77S0Q05N.cambridge.arm.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <ZLBLwG2LJ4gZLfbh@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z00QfEMrs_mqRIbQ_hrhNZh7whI9c5II
X-Proofpoint-GUID: Z00QfEMrs_mqRIbQ_hrhNZh7whI9c5II
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=979
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140015
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/2023 3:08 AM, Mark Rutland wrote:
> On Thu, Jul 13, 2023 at 10:08:34PM +0800, Aiqun(Maria) Yu wrote:
>> On 7/13/2023 7:20 PM, Mark Rutland wrote:
>>> Are you saying that LSE atomics to *cacheable* mappings do not work on your
>>> system?
>>>
>>> Specifically, when using a Normal Inner-Shareable Inner-Writeback
>>> Outer-Writeback mapping, do the LSE atomics work or not work?
>> *cacheable* mapping have the LSE atomic is not working if far atomic is
>> performed.
> 
> Thanks for confirming; the fact that this doesn't work on *cacheable* memory is
> definitely a major issue. I think everyone is confused here because of the
> earlier mention of non-cachable accesses (which don't matter).
> 
Maybe I can have the information collected in a summary to see if that 
helps.
> I know that some CPU implementations have EL3 control bits to force LSE atomics
> to be performed near (e.g. in Cortex-A55, the CPUECTLR.ATOM control bits),
> which would avoid the issue while still allowing the LSE atomics to be used.
> 
> If those can be configured in EL3 firmware, that would be a preferable
> workaround.
> 
> Can you say which CPUs are integrated in this system? and/or can you check if
> such control bits exist?

We have CPUECTLR_EL1.ATOM bit can force LSE atomics to be perform near.
CPUECTLR_EL1 is also an option to EL1 kernel drivers to be configuarable.

Try to a detailed summarise of the whole discussions, anyone can ignore 
some part if you are already know.

* Part 1: Solution for this issue.
While we still want to have options to let third party and end users 
can have options:
   1.Disable lse atomic cap.
   2.*Disallow* far atomic by "CPUECTLR_EL1.atom force near atomic" and 
non-cachable mappling for lse atomic only.


* Part 2: Why we need the solution
1. There is also some case far atomic is better performance than near 
atomic. end user may still can still try to do allow far atomic.
while this driver is also use kerenl LSE ATOMIC macro, so it can be 
running on cpu don't support lse atomic and cpu support lse atomic already.
while current system, cpu have feature register said lse atomic is 
supported, but memory controller is not supported is currently not yet 
supported.
2. cpu feature of lse atomic capbility can be controled via options for 
the same image.
Can have GKI(generic kernel Image) + same third party drivers Images 
support multi systems.
--  *New system* fully support lse atomic
-- *Intermidiate support system* which only have cpu support lse atomic, 
but have memory control/bus don't support lse atomic.* (mainly issue are 
discussed in this thread.)
-- *old system* have cpu don't have this cpu feature at all.
3. better for debugging purpose, it would be easier for verify if it is 
this feature related or not.
4. *Disallow* from the developer side is not easy to control, expecially 
when they have the same code working on *old system* or *new system*, 
but failed on current *Intermidiate support system*.

> 
> Thanks,
> Mark.
>   

Thx for discussion in details.
-- 
Thx and BRs,
Aiqun(Maria) Yu

