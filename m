Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DA753797
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbjGNKMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjGNKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:12:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA01BB;
        Fri, 14 Jul 2023 03:12:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E6HxIq029244;
        Fri, 14 Jul 2023 10:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RR+/IxyhJsXlxLzbwwwL7vp7nrADziSnHJ10gpkT6K0=;
 b=Wqgrlv7qtvnN7Lznqqo8URJMR7ogpQMuTLSNVV7MqZLxvSLmD5BGCk6caG2ASD+nDpvM
 G5Cv50EWP9AW4rLxw/5WtS4sKYWP3nw+IjTKIiALjp5qdrlV4YX6eCX7DLu61tc8mB8K
 dzNhQjolIyuDtPxLLmvqZaDHK82Y9gz9Ukq03w77auoqrWoXt+vyGUKs+kU5WMFA6XI2
 mKNhx0DsFNr7mT2DepUreT1EAI5oPdvBDYSL2FHPUqI632L4XDu4CSAETNYzhs+iPaX2
 rW3ZCWF1eydFc/WMmXz9ornrRRwYX779WcDTUxvfWPhe1zTYYI/ODPq9i3aOIspNOLgv QA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpu91ecc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 10:12:09 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36EAC8ZF019373
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 10:12:08 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 03:12:05 -0700
Message-ID: <b76c7a9b-8ed6-97da-bdfa-47cc7db51ff5@quicinc.com>
Date:   Fri, 14 Jul 2023 18:12:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
To:     Will Deacon <will@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <corbet@lwn.net>,
        <catalin.marinas@arm.com>, <maz@kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_satyap@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_songxue@quicinc.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230711082226.GA1554@willie-the-truck>
 <84f0994a-26de-c20a-a32f-ec8fe41df3a3@quicinc.com>
 <20230711102510.GA1809@willie-the-truck>
 <67c2621f-4cad-2495-9785-7737246d3e90@quicinc.com>
 <ZK5X9bXQT7GBxNHj@FVFF77S0Q05N.emea.arm.com>
 <604ac52d-4336-744f-2ab8-44d1c93fbaa8@quicinc.com>
 <ZK_d86ApI1FCHhTL@FVFF77S0Q05N.cambridge.arm.com>
 <e02b9969-a3ca-a80d-1d32-25d2bf4c72b6@quicinc.com>
 <ZLBLwG2LJ4gZLfbh@FVFF77S0Q05N.cambridge.arm.com>
 <6d1a6691-f858-71bf-97fe-97e13fcb93b6@quicinc.com>
 <20230714082348.GA5240@willie-the-truck>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20230714082348.GA5240@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ocEaWh3K4kLE3lDSXpUuBQnFcI3-ftKt
X-Proofpoint-ORIG-GUID: ocEaWh3K4kLE3lDSXpUuBQnFcI3-ftKt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140091
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/2023 4:23 PM, Will Deacon wrote:
> On Fri, Jul 14, 2023 at 09:56:27AM +0800, Aiqun(Maria) Yu wrote:
>> On 7/14/2023 3:08 AM, Mark Rutland wrote:
>>> On Thu, Jul 13, 2023 at 10:08:34PM +0800, Aiqun(Maria) Yu wrote:
>>>> On 7/13/2023 7:20 PM, Mark Rutland wrote:
>>>>> Are you saying that LSE atomics to *cacheable* mappings do not work on your
>>>>> system?
>>>>>
>>>>> Specifically, when using a Normal Inner-Shareable Inner-Writeback
>>>>> Outer-Writeback mapping, do the LSE atomics work or not work?
>>>> *cacheable* mapping have the LSE atomic is not working if far atomic is
>>>> performed.
>>>
>>> Thanks for confirming; the fact that this doesn't work on *cacheable* memory is
>>> definitely a major issue. I think everyone is confused here because of the
>>> earlier mention of non-cachable accesses (which don't matter).
>>>
>> Maybe I can have the information collected in a summary to see if that
>> helps.
>>> I know that some CPU implementations have EL3 control bits to force LSE atomics
>>> to be performed near (e.g. in Cortex-A55, the CPUECTLR.ATOM control bits),
>>> which would avoid the issue while still allowing the LSE atomics to be used.
>>>
>>> If those can be configured in EL3 firmware, that would be a preferable
>>> workaround.
>>>
>>> Can you say which CPUs are integrated in this system? and/or can you check if
>>> such control bits exist?
>>
>> We have CPUECTLR_EL1.ATOM bit can force LSE atomics to be perform near.
>> CPUECTLR_EL1 is also an option to EL1 kernel drivers to be configuarable.
>>
>> Try to a detailed summarise of the whole discussions, anyone can ignore some
>> part if you are already know.
>>
>> * Part 1: Solution for this issue.
>> While we still want to have options to let third party and end users can
>> have options:
>>    1.Disable lse atomic cap.
>>    2.*Disallow* far atomic by "CPUECTLR_EL1.atom force near atomic" and
>> non-cachable mappling for lse atomic only.
> 
> Sorry, but this still isn't making sense to me. Which CPUs do you have on
> this SoC?
cpu is cortex A78/A55.
> 
> My understanding of the CPUs from ARM is that LSE atomics are not supposed
> to be sent to blocks that don't support them. That doesn't mean you have to
> do everything near, however -- you can still execute them at e.g. L2.
> 
> For example, the Cortex-X1 TRM states:
> 
>    | Atomic instructions to cacheable memory can be performed as either
>    | near atomics or far atomics, depending on where the cache line
>    | containing the data resides.
>    |
>    | When an instruction hits in the L1 data cache in a unique state, then
>    | it is performed as a near atomic in the L1 memory system. If the atomic
>    | operation misses in the L1 cache, or the line is shared with another
>    | core, then the atomic is sent as a far atomic on the core CHI interface.
lse atomic is optional to CHI-B for example, some system may have cpu 
feature register have lse atomic feature, but the far atomic is not 
accpeted by CHI side. It will be simiar issue that we do.
>    |
>    | If the operation misses everywhere within the cluster, and the
>    | interconnect supports far atomics, then the atomic is passed on to the
>    | interconnect to perform the operation.
>    |
>    | When the operation hits anywhere inside the cluster, or when an
>    | interconnect does not support atomics, the L3 memory system performs
>    | the atomic operation. If the line is not already there, it allocates
>    | the line into the L3 cache. This depends on whether the DSU is configured
>    | with an L3 cache.
> 
> So something doesn't add up.
> 
>> * Part 2: Why we need the solution
>> 1. There is also some case far atomic is better performance than near
>> atomic. end user may still can still try to do allow far atomic.
>> while this driver is also use kerenl LSE ATOMIC macro, so it can be running
>> on cpu don't support lse atomic and cpu support lse atomic already.
>> while current system, cpu have feature register said lse atomic is
>> supported, but memory controller is not supported is currently not yet
>> supported.
> 
> I think you're forgetting the fact that these instructions can be executed
> by userspace, so the kernel option is completely bogus. If you're saying
> that cacheable atomics can cause external aborts, then I can write an app
> which will crash your device even if you've set this command line option.
> 
For apps like userspace also needed to check the system capbility as far 
as I know.
> Will

-- 
Thx and BRs,
Aiqun(Maria) Yu

