Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20764757B88
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjGRMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjGRMKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:10:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AB919A1;
        Tue, 18 Jul 2023 05:10:45 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IBTbtf003046;
        Tue, 18 Jul 2023 12:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cl7vvBSj+vK/+YKHsnApVQB39LSReFzTOz9chWqUJjw=;
 b=f+R6y5Z0bofo9HHEXzfJUN6nqE7FbVVuHdx9/kBe1tZobfHFy9R8ZfQM1V8r6hrEqhdF
 oyFYAmR+Crlstfl22F+vGDjohTJb5O7kdDmVR53ORHBv1x90+deYfqpm+JVqHzFZbnYB
 Pp/oBh0hGtZQTPW/3qsslB2oU5mxqjZJuOEL0r3nKcUH7iEcJ/PV7XF1avU+1+7B/22J
 +dW8Gkmi32MevKCT9xtTPvaiyZ6EPjv/IKwOUHC89xV5QRF63lwjoerx1J9lf3UBdAZt
 vS43WArWPxZtpAdM3yuTy7MGKQpaOmd6mK8eoUDPBtrzRmsuR5OEUb8T4is+MVPzTEJG Qg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rweag1gr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 12:10:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36ICAakU016605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 12:10:36 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 05:10:28 -0700
Message-ID: <d038e912-9917-e581-c42c-bca712687734@quicinc.com>
Date:   Tue, 18 Jul 2023 17:40:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 10/13] remoteproc: qcom: Add Hexagon based multipd
 rproc driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-11-quic_mmanikan@quicinc.com>
 <2061a641-4b97-1aa6-27cd-99f01a785033@linaro.org>
 <54f06704-a849-7049-5956-31cb4765a1eb@quicinc.com>
 <8cf34ab3-fa8b-90f4-215e-bbfb0c41fade@quicinc.com>
 <bc56e3be-7d0b-5420-978e-125d66ae8f72@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <bc56e3be-7d0b-5420-978e-125d66ae8f72@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x_sC7oCfWfguyRPwPN3ld5RJQWHf0P7B
X-Proofpoint-GUID: x_sC7oCfWfguyRPwPN3ld5RJQWHf0P7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_08,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=453
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180111
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/2023 4:25 PM, Krzysztof Kozlowski wrote:
> On 30/06/2023 12:29, Manikanta Mylavarapu wrote:
>>
>>
>> On 6/27/2023 6:09 PM, Manikanta Mylavarapu wrote:
>>>
>>>
> 
> Do you see the lines above? You quote my reply and claim it is you who
> wrote it.
> 
> Please fix your mailer, it's making discussions unnecessary difficult.
> 
> 

Sure, i will correct it.

>>>>> +      Say y here to support the Qualcomm Secure Peripheral Image Loader
>>>>> +      for the Hexagon based MultiPD model remote processors on e.g.
>>>>> IPQ5018.
>>>>> +      This is trustZone wireless subsystem.
>>>>> +
>>>>
>>>> ...
>>>>
>> 	I didn't understand. Can you please elaborate your comment?
> 
> https://en.wikipedia.org/wiki/Ellipsis
> 
Got it.

>>
>>>>> +    int (*powerup_scm)(u32 peripheral);
>>>>> +    int (*powerdown_scm)(u32 peripheral);
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * qcom_get_pd_asid() - get the pd asid number from DT node
>>>>
>>>>   From node name? NAK. It does not work like that. Node names can change
>>>> and you did not define this number as part of ABI.
>>>>
>>>> Probably you wanted unit address.
>>>>
>>
>> 	Yeah i got your point. Each of the WCSS PD's are internally
>> 	represented in Q6 with their corresponding "spawn" bit numbers.
>> 	I will use same and remove the "PD-" hardcodings.
>>
>> 	Is this fine ?
> 
> I don't get what you are going to use, so post a patch. Talk is cheap.
> 
> 
Sure, i posted a patch. Patch available here
https://lore.kernel.org/linux-arm-msm/20230718120501.3205661-10-quic_mmanikan@quicinc.com/

Thanks & Regards,
Manikanta.

> Best regards,
> Krzysztof
> 
