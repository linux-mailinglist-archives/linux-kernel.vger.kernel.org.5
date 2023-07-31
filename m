Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6FA7698FE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjGaOH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjGaOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:07:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9535BD;
        Mon, 31 Jul 2023 07:04:43 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VE29D1000344;
        Mon, 31 Jul 2023 14:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=44EAft8+SErIhjaX0y0L9mkTiIjyWhgHm696QG3Efeg=;
 b=ajXdod9xs6Hk0ZYYU09eu7rbxCipF0GQoxrHjRAjeM3Cc63fGnFhf0J3Er8cQT/+kuiq
 M2WZG3cYo/R6HlJNTMY2JK1XFKF8kKzaRbwCK1+1FOzu2c3KQKhj/LIA5kdHtdTZdo7Y
 zlIMf7FDHCr5ciWj8GIsLeNBqTHWiX2N7+twlyUAAe66kwgslMyjadXk7MDBKJBPMr1b
 EXYwJ4OywX+wyOMnFD8ZkhyU/qJRPxeqAdIVoLiOKvtQu3i0zkCD4TL5ggtyetMx82/I
 xTye5Mgz4X1xB5r9E6mNadMgwolNJgmmJxasWn+7tLdW08boIcimqrFIwD7J4PSNQduF lQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6a5012qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 14:04:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VE4So2005848
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 14:04:28 GMT
Received: from [10.110.115.89] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 07:04:27 -0700
Message-ID: <88de471c-a2e2-008a-fb9b-b8039b018209@quicinc.com>
Date:   Mon, 31 Jul 2023 07:04:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] firmware: arm_scmi: Add qcom hvc/shmem transport
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <sudeep.holla@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230724164419.16092-1-quic_nkela@quicinc.com>
 <20230724164419.16092-4-quic_nkela@quicinc.com> <ZMAASCqwMbqX7T7L@pluto>
 <fc42e319-0ead-db94-9335-e07ff780dfa2@quicinc.com>
Content-Language: en-US
In-Reply-To: <fc42e319-0ead-db94-9335-e07ff780dfa2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JZ_H8COxlm7-aCkQF-Llb0KlvBOjBGt6
X-Proofpoint-ORIG-GUID: JZ_H8COxlm7-aCkQF-Llb0KlvBOjBGt6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_06,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307310126
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/2023 10:12 AM, Nikunj Kela wrote:
>
> On 7/25/2023 10:03 AM, Cristian Marussi wrote:
>> On Mon, Jul 24, 2023 at 09:44:19AM -0700, Nikunj Kela wrote:
>>> Add a new transport channel to the SCMI firmware interface driver for
>>> SCMI message exchange on Qualcomm virtual platforms.
>>>
>>> The hypervisor associates an object-id also known as capability-id
>>> with each hvc doorbell object. The capability-id is used to identify 
>>> the
>>> doorbell from the VM's capability namespace, similar to a 
>>> file-descriptor.
>>>
>>> The hypervisor, in addition to the function-id, expects the 
>>> capability-id
>>> to be passed in x1 register when HVC call is invoked.
>>>
>>> The qcom hvc doorbell/shared memory transport uses a statically defined
>>> shared memory region that binds with "arm,scmi-shmem" device tree node.
>>>
>>> The function-id & capability-id are allocated by the hypervisor on 
>>> bootup
>>> and are stored in the shmem region by the firmware before starting 
>>> Linux.
>>>
>>> Currently, there is no usecase for the atomic support therefore this 
>>> driver
>>> doesn't include the changes for the same.
>>>
>> Hi Nikunj,
>>
>> so basically this new SCMI transport that you are introducing is just
>> exactly like the existing SMC transport with the only difference that
>> you introduced even another new way to configure func_id, a new cap_id
>> param AND the fact that you use HVC instead of SMC... all of this tied
>> to a new compatible to identify this new transport mechanism....
>> ..but all in all is just a lot of plain duplicated code to maintain...
>>
>> ...why can't you fit this other smc/hvc transport variant into the
>> existing SMC transport by properly picking and configuring 
>> func_id/cap_id
>> and "doorbell" method (SMC vs HVC) in the chan_setup() step ?
>>
>> ..I mean ... you can decide where to pick your params based on
>> compatibles and also you can setup your invokation method (SMC vs HVC)
>> based on those...while keeping all the other stuff exactly the same...
>> ...including support for atomic exchanges...if not, when you'll need 
>> that
>> too in your QC_HVC transport you'll have to duplicate also that (and my
>> bugs too probably :P)
>>
>> (... well maybe in this scenario also the transport itself should be
>> renamed from SMC to something more general...)
>>
>> Not sure if I am missing something, or if Sudeep will be horrified by
>> this unifying proposal of mine, but in this series as it stands now I
>> just see a lot of brutally duplicated stuff that just differs by naming
>> and a very minimal change in logic that could be addressed changing and
>> generalizing the original SMC transport code instead.
>>
>> Thanks,
>> Cristian
>
> Hi Christian,
>
> I totally agree with you and will be happy to include my changes in 
> smc.c if Sudeep agrees with that approach.
>
> Thanks

Hi Sudeep, Could you please provide your feedback on this? Thanks

