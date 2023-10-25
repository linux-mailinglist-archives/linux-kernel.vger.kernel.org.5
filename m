Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9157D679F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjJYJy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjJYJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:54:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5369128;
        Wed, 25 Oct 2023 02:54:21 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39P8s1gt005815;
        Wed, 25 Oct 2023 09:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7wMO74w/KQMo+4s9Z0A2HrX+bIjpx9iGlyOA0PG/ad4=;
 b=fDalulYI2WuDlOyjB/RfQhy53FS3TMA6/rGNwiUHXMmV2ZeSdnzVb57XHSDLBioB1ixx
 SFYaywyg3BGuYEctknE3SWmjKk8gNAVER/SfyW7wvu0KvfHMzFNv9/RtmeDGZX4li9np
 mwzO9FbzM3rbzCHslVRLD2VOenErwtLWIyjVGb4/ts2ow6tB6MIqVVIgKgcFN8njtGif
 SQUZz5kWt2lb95TOaA2Apsm821JxRFIs87+ZBU1GKS/o0LxP0EWB+a0scaH7iYcJGfJP
 zF+GxaPP25tRSdCKZ70+qNMOHt2HI+RUlHndwahzd6H0woVFipMz6M5xA1fxh+dJY3vw +w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txuj7gkrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 09:54:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39P9sFC7019754
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 09:54:15 GMT
Received: from [10.233.19.96] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 02:54:12 -0700
Message-ID: <060e80b9-e403-45b7-8627-e7b33b223688@quicinc.com>
Date:   Wed, 25 Oct 2023 17:54:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v6 3/3] input: pm8xxx-vibrator: add new SPMI
 vibrator support
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-input@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_kamalw@quicinc.com>,
        <jestar@qti.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>
References: <20230922083801.3056724-1-quic_fenglinw@quicinc.com>
 <20230922083801.3056724-4-quic_fenglinw@quicinc.com>
 <CAA8EJpoW8DJOTVHBu9_+BQs5DtxyJu3xrCfDNyYHn2MeHZHV4w@mail.gmail.com>
 <12887370-0ada-359b-8a4f-18a28495c69a@quicinc.com>
 <ZRhKAWYBLcBZHc73@google.com>
 <8697d115-9aa7-2a1c-4d96-25b15adb5cca@quicinc.com>
Content-Language: en-US
In-Reply-To: <8697d115-9aa7-2a1c-4d96-25b15adb5cca@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1q0bmqWI62j_b-3zaFjdSuN-lMjk9_TQ
X-Proofpoint-GUID: 1q0bmqWI62j_b-3zaFjdSuN-lMjk9_TQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=714
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/2023 12:01 PM, Fenglin Wu wrote:
> 
> 
> On 10/1/2023 12:17 AM, Dmitry Torokhov wrote:
>> On Mon, Sep 25, 2023 at 10:54:45AM +0800, Fenglin Wu wrote:
>>>
>>>
>>> On 9/24/2023 3:07 AM, Dmitry Baryshkov wrote:
>>>>> +
>>>>> +       switch (vib->data->hw_type) {
>>>>> +       case SSBI_VIB:
>>>>>                   mask = SSBI_VIB_DRV_LEVEL_MASK;
>>>>>                   shift = SSBI_VIB_DRV_SHIFT;
>>>>> +               break;
>>>>> +       case SPMI_VIB:
>>>>> +               mask = SPMI_VIB_DRV_LEVEL_MASK;
>>>>> +               shift = SPMI_VIB_DRV_SHIFT;
>>>>> +               break;
>>>>> +       case SPMI_VIB_GEN2:
>>>>> +               mask = SPMI_VIB_GEN2_DRV_MASK;
>>>>> +               shift = SPMI_VIB_GEN2_DRV_SHIFT;
>>>>> +               break;
>>>>> +       default:
>>>>> +               return -EINVAL;
>>>> Could you please move the switch to the previous patch? Then it would
>>>> be more obvious that you are just adding the SPMI_VIB_GEN2 here.
>>>>
>>>> Other than that LGTM.
>>>
>>> Sure, I can move the switch to the previous refactoring patch.
>>
>> Actually, the idea of having a const "reg" or "chip", etc. structure is
>> to avoid this kind of runtime checks based on hardware type and instead
>> use common computation. I believe you need to move mask and shift into
>> the chip-specific structure and avoid defining hw_type.
>>
> 
> Actually, the main motivation for adding 'hw_type' is to avoid reading 
> 'reg_base' from DT for SSBI_VIB. It can also help to simplify the 
> 'pm8xxx_vib_data' structure and make following code logic more 
> straightforward and easier to understand(check hw_type instead of 
> checking specific constant reg/mask value), it has been used in 
> following places:
> 
>    1) Avoid reading 'reg_base' from DT for SSBI_VIB.
>    2) Only do manual-mode-mask-write for SSBI_VIB. Previously, it was 
> achieved by giving a valid 'drv_en_manual_mask' value only for SSBI_VIB, 
> having hw_type make it more straightforward.
>    3) Not writing VIB_EN register for SSBI_VIB. A similar strategy was 
> used previously, only write VIB_EN register when 'enable_mask' is valid, 
>   checking hw_type make it more straightforward.
>    4) To achieve different drive step size for SPMI_VIB （100mV per 
> step) and SPMI_VIB_GEN2 (1mV per step).
>    5) Do different VIB_DRV mask and shift assignment for SPMI_VIB and 
> SPMI_VIB_GEN2
>    6) Only write VIB_DRV2 for SPMI_VIB_GEN2.
> 

Hi Dmitry,

Can you please help to comment if this looks good for you?
I actually have pushed a V7 to address your last comment before you made 
this one.
V7 change: 
https://lore.kernel.org/linux-arm-msm/20230927-pm8xxx-vibrator-v7-1-b5d8c92ce818@quicinc.com/, 
just want to know how to move forward.
Thanks

Fenglin

> 
>> Thanks.
>>
