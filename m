Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205897BD279
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 06:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbjJIEBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 00:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjJIEB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 00:01:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B268ABA;
        Sun,  8 Oct 2023 21:01:24 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3992v5gj005208;
        Mon, 9 Oct 2023 04:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UPoBV0tpYtp00Iktwt7jFaHAr2exDNPVIF7CAnnrWt4=;
 b=e33XdJcL23YGaTK8eNexYBcsN6K6ITcApxHbqWcQcPINN2xZ4gsarPuNq20CDzOmULMR
 09nLDl0WidIQXq/ElS9mPvS4ivgvma0mnCzyJ1KD3gMorik5z0/tZ1lwlWSGlnFfm4nQ
 wJGPPR/1Ff+cnPUOXhE2ju7K4Qu49ro5QYb5X3ymDfS9e3w5kx96YQcQEKL/KVI4JCv0
 AJvPOoSP/apxpKLW3ZLdd55/ju/S83DVqsMEQw0y6t7/Aggara3+J7DWiE37gIEOf2+R
 PL49A2KZpiyVECSUYjvu/sgZmOcirSBsJskjF5uX1tAuxOik0pViD+1rgrNfRtvV1pkK hQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh8d1fgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 04:01:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399419Zh014243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 04:01:09 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 8 Oct
 2023 21:01:05 -0700
Message-ID: <8697d115-9aa7-2a1c-4d96-25b15adb5cca@quicinc.com>
Date:   Mon, 9 Oct 2023 12:01:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH v6 3/3] input: pm8xxx-vibrator: add new SPMI
 vibrator support
Content-Language: en-US
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
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <ZRhKAWYBLcBZHc73@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3Bzj844m0xToZHbAj8XtUbVmAwHNCio7
X-Proofpoint-ORIG-GUID: 3Bzj844m0xToZHbAj8XtUbVmAwHNCio7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_02,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=759 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090034
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2023 12:17 AM, Dmitry Torokhov wrote:
> On Mon, Sep 25, 2023 at 10:54:45AM +0800, Fenglin Wu wrote:
>>
>>
>> On 9/24/2023 3:07 AM, Dmitry Baryshkov wrote:
>>>> +
>>>> +       switch (vib->data->hw_type) {
>>>> +       case SSBI_VIB:
>>>>                   mask = SSBI_VIB_DRV_LEVEL_MASK;
>>>>                   shift = SSBI_VIB_DRV_SHIFT;
>>>> +               break;
>>>> +       case SPMI_VIB:
>>>> +               mask = SPMI_VIB_DRV_LEVEL_MASK;
>>>> +               shift = SPMI_VIB_DRV_SHIFT;
>>>> +               break;
>>>> +       case SPMI_VIB_GEN2:
>>>> +               mask = SPMI_VIB_GEN2_DRV_MASK;
>>>> +               shift = SPMI_VIB_GEN2_DRV_SHIFT;
>>>> +               break;
>>>> +       default:
>>>> +               return -EINVAL;
>>> Could you please move the switch to the previous patch? Then it would
>>> be more obvious that you are just adding the SPMI_VIB_GEN2 here.
>>>
>>> Other than that LGTM.
>>
>> Sure, I can move the switch to the previous refactoring patch.
> 
> Actually, the idea of having a const "reg" or "chip", etc. structure is
> to avoid this kind of runtime checks based on hardware type and instead
> use common computation. I believe you need to move mask and shift into
> the chip-specific structure and avoid defining hw_type.
> 

Actually, the main motivation for adding 'hw_type' is to avoid reading 
'reg_base' from DT for SSBI_VIB. It can also help to simplify the 
'pm8xxx_vib_data' structure and make following code logic more 
straightforward and easier to understand(check hw_type instead of 
checking specific constant reg/mask value), it has been used in 
following places:

   1) Avoid reading 'reg_base' from DT for SSBI_VIB.
   2) Only do manual-mode-mask-write for SSBI_VIB. Previously, it was 
achieved by giving a valid 'drv_en_manual_mask' value only for SSBI_VIB, 
having hw_type make it more straightforward.
   3) Not writing VIB_EN register for SSBI_VIB. A similar strategy was 
used previously, only write VIB_EN register when 'enable_mask' is valid, 
  checking hw_type make it more straightforward.
   4) To achieve different drive step size for SPMI_VIB （100mV per step) 
and SPMI_VIB_GEN2 (1mV per step).
   5) Do different VIB_DRV mask and shift assignment for SPMI_VIB and 
SPMI_VIB_GEN2
   6) Only write VIB_DRV2 for SPMI_VIB_GEN2.


> Thanks.
> 
