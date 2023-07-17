Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C540975594F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjGQCBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQCBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:01:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E703A19F;
        Sun, 16 Jul 2023 19:01:50 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H1Q8gU003025;
        Mon, 17 Jul 2023 02:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DfJz2VDf1tHd5phO3+tWCj9//S5no9rj8sSeJFbAzzg=;
 b=ZkQMnvM4lzWdzTG7UCvj2sRU+W85f7UW7H7kuMEN+OkKAOEyMAmMoocAfNF44Y34wTwB
 zkLFxxGL/qVbbs3ab3SApMPbGPLSSYxTQLrN3Ea8T10f6rB9OddnR54pQYLE6zG+pb4R
 munQWW0ynXHFSL/g3Qq9zyBRKtJZpIskbndD4+7eKCC4XTqE96EpjtEUGUL67WgttXgC
 FrB7Dffbm156LNIAigafdfSAOpd6qlWUUhB4V71pqlwMHrS5KSNLHaNRWY0+LWRkr1qI
 l3pFrR1nKfUSme1TANsS14dWAB9eh/W1ysSqBQHNkeT6KgI8BeRpPl+7k+67CsIjK/Iz aA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0ea8p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 02:01:34 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36H21YRB012614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 02:01:34 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 16 Jul
 2023 19:01:31 -0700
Message-ID: <836603c6-16ac-5829-3d16-60aef66dd31b@quicinc.com>
Date:   Mon, 17 Jul 2023 10:01:28 +0800
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
References: <20230711102510.GA1809@willie-the-truck>
 <67c2621f-4cad-2495-9785-7737246d3e90@quicinc.com>
 <ZK5X9bXQT7GBxNHj@FVFF77S0Q05N.emea.arm.com>
 <604ac52d-4336-744f-2ab8-44d1c93fbaa8@quicinc.com>
 <ZK_d86ApI1FCHhTL@FVFF77S0Q05N.cambridge.arm.com>
 <e02b9969-a3ca-a80d-1d32-25d2bf4c72b6@quicinc.com>
 <ZLBLwG2LJ4gZLfbh@FVFF77S0Q05N.cambridge.arm.com>
 <6d1a6691-f858-71bf-97fe-97e13fcb93b6@quicinc.com>
 <20230714082348.GA5240@willie-the-truck>
 <b76c7a9b-8ed6-97da-bdfa-47cc7db51ff5@quicinc.com>
 <20230714120946.GA5597@willie-the-truck>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20230714120946.GA5597@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m0A_1Z2-64VBmPGbNQLuebqGPLHf4NBN
X-Proofpoint-ORIG-GUID: m0A_1Z2-64VBmPGbNQLuebqGPLHf4NBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_01,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=819
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170017
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/2023 8:09 PM, Will Deacon wrote:
> On Fri, Jul 14, 2023 at 06:12:02PM +0800, Aiqun(Maria) Yu wrote:
>> On 7/14/2023 4:23 PM, Will Deacon wrote:
>>> On Fri, Jul 14, 2023 at 09:56:27AM +0800, Aiqun(Maria) Yu wrote:
>>>> Try to a detailed summarise of the whole discussions, anyone can ignore some
>>>> part if you are already know.
>>>>
>>>> * Part 1: Solution for this issue.
>>>> While we still want to have options to let third party and end users can
>>>> have options:
>>>>     1.Disable lse atomic cap.
>>>>     2.*Disallow* far atomic by "CPUECTLR_EL1.atom force near atomic" and
>>>> non-cachable mappling for lse atomic only.
>>>
>>> Sorry, but this still isn't making sense to me. Which CPUs do you have on
>>> this SoC?
>> cpu is cortex A78/A55.
>>>
>>> My understanding of the CPUs from ARM is that LSE atomics are not supposed
>>> to be sent to blocks that don't support them. That doesn't mean you have to
>>> do everything near, however -- you can still execute them at e.g. L2.
>>>
>>> For example, the Cortex-X1 TRM states:
>>>
>>>     | Atomic instructions to cacheable memory can be performed as either
>>>     | near atomics or far atomics, depending on where the cache line
>>>     | containing the data resides.
>>>     |
>>>     | When an instruction hits in the L1 data cache in a unique state, then
>>>     | it is performed as a near atomic in the L1 memory system. If the atomic
>>>     | operation misses in the L1 cache, or the line is shared with another
>>>     | core, then the atomic is sent as a far atomic on the core CHI interface.
>> lse atomic is optional to CHI-B for example, some system may have cpu
>> feature register have lse atomic feature, but the far atomic is not accpeted
>> by CHI side. It will be simiar issue that we do.
> 
> Again, that should not be a problem. Looking at the A55 TRM, it explicitly
> says that atomics will be done in the L3 if the interconnect does not
> support them. The A78 TRM doesn't talk about this at all, so I defer to
We will check internally to see why it is not happened in current system 
which have issue.
> Mark (or anybody else from Arm) on how that works, but one might assume
> that it does something similar to the other Arm cores.
I checked other Arm cores like A720 TRM. It seems the similar statement:
If the operation hits anywhere inside the cluster, or if an interconnect 
does not support atomics, then the L3 memory system performs the atomic 
operation. If the line is not already there, it allocates the line into 
the L3 cache.

> 
>>>> * Part 2: Why we need the solution
>>>> 1. There is also some case far atomic is better performance than near
>>>> atomic. end user may still can still try to do allow far atomic.
>>>> while this driver is also use kerenl LSE ATOMIC macro, so it can be running
>>>> on cpu don't support lse atomic and cpu support lse atomic already.
>>>> while current system, cpu have feature register said lse atomic is
>>>> supported, but memory controller is not supported is currently not yet
>>>> supported.
>>>
>>> I think you're forgetting the fact that these instructions can be executed
>>> by userspace, so the kernel option is completely bogus. If you're saying
>>> that cacheable atomics can cause external aborts, then I can write an app
>>> which will crash your device even if you've set this command line option.
>>>
>> For apps like userspace also needed to check the system capbility as far as
> 
> That's not something you can enforce, so a malicious application can easily
> crash your system.
we provide the capability for sotfware to do the runtime compatible 
check. we surely cannot enforce that. If the software is align the rule, 
it can also funcational fine on the "intermediate support system".

By the way:
ALso the A720 TRM doc mentioned the uncachable memory case:
The Cortex-A720 core supports atomics to Device or Non-cacheable memory, 
however this relies on the interconnect also supporting atomics. If such 
an atomic instruction is executed when the interconnect does not support 
them, then it results in an abort.

So it is not a single one company's scenario as well, shall we have an 
option to handle this scenario?

Why the non-cacheable memory is forbiden? Does it only due to limitation 
of hardware?

> 
> Will

-- 
Thx and BRs,
Aiqun(Maria) Yu

