Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC1C758836
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGRWGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjGRWGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:06:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6327E1BFC;
        Tue, 18 Jul 2023 15:05:48 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IKpN5l008353;
        Tue, 18 Jul 2023 22:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8rFBmX5DgEEydXEcTIyomIWP4zWEITCUOjOBSX0Y8vI=;
 b=VrQ24uCRWyFr9t1BpscO3IXZFINEy/9H0fTfedwdDZWTWey44NeY/bisvD/ofuI9Gn7h
 7I3v+zeaOm74ELnUfHtdU2aZSCDYvhYuS4ujnGX9u0YuNeyscrAGESQJPKuAyS8Bm0fb
 4iDGYa5QkiUysjStdvXxoXG0/Gs+7zp4OmCDh9rZAy678S2QwyVfWxGllKTZusO9tDpO
 6RDyPwF7ii+uFsRSq1JSmgrc+Hkso8Z4zegCMxibGrBIP5jQ8Vo61xh+EpZ+PQIRZFAC
 gw+S67n3cv0ehu3M5rSaq3DmjpwqniS/GIc1aXuajWtlM+kMrTeitrUAxF3E6XYthPhP 4w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwnrrhws2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 22:05:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IM5HMJ016014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 22:05:17 GMT
Received: from [10.110.49.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 15:05:17 -0700
Message-ID: <46bd234c-0b0c-0787-1824-e7cbff768393@quicinc.com>
Date:   Tue, 18 Jul 2023 15:05:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
 <xkw36iwjb47q7spf6qle5x3kcmx6fv7or6cwhlpkuvihn3xmt2@qhrhtug4htp2>
 <5c76250b-4415-950e-6aab-7ccbdc6ca83a@quicinc.com>
 <6uelwa7fpzbw757rbb2j3u4ogagypdzyqj5mykyhlkkkvrnfin@ttonjpfn7nxc>
 <d2d01794-ef13-07f9-7695-b56b58cc01ac@quicinc.com>
 <rum7gnnouoz2irn57taxn4j2aajkxf6em6ft6u4w3rxwsym2su@acgczsnl2huz>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <rum7gnnouoz2irn57taxn4j2aajkxf6em6ft6u4w3rxwsym2su@acgczsnl2huz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8zvWIFlvkw91mb8rppe_7bCZ8VFZlnlB
X-Proofpoint-ORIG-GUID: 8zvWIFlvkw91mb8rppe_7bCZ8VFZlnlB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_17,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180199
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/2023 12:30 PM, Bjorn Andersson wrote:
> On Tue, Jul 18, 2023 at 12:10:16PM -0700, Nikunj Kela wrote:
>> On 7/18/2023 12:07 PM, Bjorn Andersson wrote:
>>> On Tue, Jul 18, 2023 at 11:53:24AM -0700, Nikunj Kela wrote:
>>>> On 7/18/2023 11:29 AM, Bjorn Andersson wrote:
>>>>> On Tue, Jul 18, 2023 at 09:08:33AM -0700, Nikunj Kela wrote:
>>>>>> diff --git a/drivers/firmware/arm_scmi/qcom_hvc.c b/drivers/firmware/arm_scmi/qcom_hvc.c
>>> [..]
> [..]
>>>>>> +#ifdef CONFIG_ARM64
>>>>>> +	cap_id = readq((void *)(scmi_info->shmem) + size +
>>>>>> +		       sizeof(unsigned long));
>>>>>> +#else
>>>>>> +	cap_id = readl((void *)(scmi_info->shmem) + size +
>>>>>> +		       sizeof(unsigned long));
>>>>>> +#endif
>>>>> Please don't make the in-memory representation depend on architecture
>>>>> specific data types. Quite likely you didn't compile test one of these
>>>>> variants?
>>>>>
>>>>> Just define the in-memory representation as u32 + u64.
>>>> I tested this for ARM64, I didn't test it for 32bit since Hypervisor doesn't
>>>> support it currently. In future, it may add 32 bit support too.
>>> I'd not be surprised if the capability id is 64 bit on a 32-bit machine
>>> as well, it's not really a property of the architecture.
>> on 32bit machine, you will have to use SMC32 convention. lt will mean that
>> the parameters can only be 32 bit long. If you keep cap-id 64 bit in 32bit
>> machines, then it has to be passed in two parameters. Are you suggesting, I
>> make this driver dependent on ARM64 and only care about 64 bit for now?
>>
> I'm suggesting that the calling convention is one thing and the
> in-memory format for passing the information to the driver is a
> different thing.
>
> Keep the arguments passed in memory architecture-independent (i.e. make
> it u64).
>
> If you're saying that the calling convention would be different on a
> 32-bit system, then you are also saying that your driver _is_ 64-bit
> specific. Please confirm what the size of your capability id would be in
> such a system and make sure the Kconfig and/or the code, reflects
> reality.
>
> Thanks,
> Bjorn
It is confirmed that cap-id will be 32 bit long on 32bit machines. That 
said, I will make changes to use last 16bytes irrespective of the 
architecture.
