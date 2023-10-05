Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B7B7BAED1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjJEWdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJEWdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:33:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE95DB;
        Thu,  5 Oct 2023 15:33:32 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395MSP5j009713;
        Thu, 5 Oct 2023 22:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6g9Cyjl5K6OG1jkcqwrpcexPvXh/RcSiBX825pOgneQ=;
 b=gQh1G/y9mUJFUoQgZK/H8e1Y/Q6hSsUHp5u0VMTmfMLqJB4vtfJVo+c+FqIRZwif46U6
 KEJ8SPGnm6JvOw8Yy/lrLKHHqA4cCRRxNSphq05XsyJSanSiTy0C85na3jIQCjccMCia
 tLhdaFzacbv3KlsbQ5rv9oytCorAHsNNokBw29QGERufl1p/rLA9rrGoT79oQhCz435u
 1fj5wlnh2WqxlvWkiFSMfWvPtg0/KtHotCOA40/7YwJWv75ZJmwfu4ZaBkXyJmUrmtcG
 zRoAWtEXnKy7q3JnJ+T4SzYIQ0lRI/jRU8SO1cXhqcfF5TeAeWl7S/rxmsqCthIPJ+lf yQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th8e1v2js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 22:33:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395MXGXg028924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 22:33:16 GMT
Received: from [10.110.20.163] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 5 Oct
 2023 15:33:15 -0700
Message-ID: <69b8ded0-7648-80bd-c41b-c591b0f861ef@quicinc.com>
Date:   Thu, 5 Oct 2023 15:33:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/4] firmware: arm_scmi: Add qcom hvc/shmem transport
 support
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-5-quic_nkela@quicinc.com>
 <20231003111914.63z35sn3r3k7drtp@bogus>
 <6246714a-3b40-e1b6-640e-560ba55b6436@quicinc.com>
 <20231004160630.pxspafszlt6o7oj6@bogus>
 <20231005222016.GI3553829@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20231005222016.GI3553829@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zWNE7LW-QekoHznHQ7t6FM-CyQDjR4op
X-Proofpoint-ORIG-GUID: zWNE7LW-QekoHznHQ7t6FM-CyQDjR4op
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_17,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050171
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/2023 3:20 PM, Bjorn Andersson wrote:
> On Wed, Oct 04, 2023 at 05:06:30PM +0100, Sudeep Holla wrote:
>> On Tue, Oct 03, 2023 at 09:16:27AM -0700, Nikunj Kela wrote:
>>> On 10/3/2023 4:19 AM, Sudeep Holla wrote:
>>>> On Mon, Sep 11, 2023 at 12:43:59PM -0700, Nikunj Kela wrote:
>>>>> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> [..]
>>>>> @@ -63,6 +66,8 @@ struct scmi_smc {
>>>>>    	u32 func_id;
>>>>>    	u32 param_page;
>>>>>    	u32 param_offset;
>>>>> +	u64 cap_id;
>>>> Can it be unsigned long instead so that it just works for both 32 and 64 bit.
>>> My first version of this patch was ulong but Bjorn suggested to make this
>>> structure size fixed i.e. architecture independent. Hence changed it to u64.
>>> If you are ok with ulong, I can change it back to ulong.
>>>
>> SMCCC pre-v1.2 used the common structure in that way. I don't see any issue
>> with that. I haven't followed Bjorn suggestions/comments though.
>>
> My request was that funcId and capId is an ABI between the firmware and
> the OS, so I'd like for that to use well defined, fixed sized, data
> types - if nothing else just for documentation purpose.
>
> These values will be truncated when passed to arm_smccc_1_1_invoke()
> anyways, so I don't have any opinion against using unsigned long here...
>
>
> PS. I understand why func_id is u32, but why are param_page and
> param_offset u32?

That was done to keep it uniform across smc32/smc64 conventions.

>
> Regards,
> Bjorn
