Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F343785445
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjHWJdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjHWJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:31:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF9A2D52;
        Wed, 23 Aug 2023 02:19:27 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N98U9Q008638;
        Wed, 23 Aug 2023 09:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LMffLJITcUGlt45ZfXcQvGXbGs+0YxDOsKfsxn3K5WA=;
 b=ldZAccMHDHie5Phjy0qqtuixzd7ZkkDu7prQXJlsTIcbYiv/YLG+LXFZPveTnOb/HiSj
 1CHZj9I+QVOsAgJXU4uBZ7DB2ilEUSRSiQUPMHMQzwmHwYTIm+Mrm2xzZp2CBlgK9sry
 GCQh+foMH+NjasHFJT7y0xYsyj0jCRnoh1X9BLWJxpFAYkvAsIBrw7qBz0LdPOcr5WKJ
 jN4+3CnDTPnywIYOJsbxr7VopdwSj7sX1BXkgKF7/thHYcB1oOuQlBVzENj1anrqIqsv
 v4TtV7/CJRaax8ZsTueshQ8HcOyrgjdvsDifv6BowS8baUvRhKiNtefYO9amTKd5WDFZ EQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2mvhe3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 09:19:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37N9JCvc018963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 09:19:12 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 02:19:09 -0700
Message-ID: <6613c15b-7951-12b3-cbfd-2961046de2b7@quicinc.com>
Date:   Wed, 23 Aug 2023 14:49:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] irqchip/qcom-pdc: add support for v3.2 HW
Content-Language: en-US
To:     <neil.armstrong@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230822-topic-sm8x50-upstream-pdc-ver-v2-1-3035b8d388f7@linaro.org>
 <5d5ad774-3269-232a-db15-751726742460@quicinc.com>
 <543b1f3d-60b6-44fd-bddf-eb35cc163e10@linaro.org>
 <dcf0cddc-2a35-2ddb-1912-465e29413b9c@quicinc.com>
 <ac1026c7-f446-482a-8abe-ac34786462a6@linaro.org>
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <ac1026c7-f446-482a-8abe-ac34786462a6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3JQIx0WCJlE_vWF4-kCZl48cseGSrxFO
X-Proofpoint-GUID: 3JQIx0WCJlE_vWF4-kCZl48cseGSrxFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=942 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230084
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 8/23/2023 2:21 PM, neil.armstrong@linaro.org wrote:
> On 23/08/2023 10:25, Maulik Shah (mkshah) wrote:
>> Hi,
>>
>> On 8/23/2023 1:16 PM, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 23/08/2023 07:35, Maulik Shah (mkshah) wrote:
>>>> Hi Neil,
>>>>
>>>> @@ -142,8 +163,17 @@ static int qcom_pdc_gic_set_type(struct 
>>>> irq_data *d, unsigned int type)
>>>>>           return -EINVAL;
>>>>>       }
>>>>> -    old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>>>> -    pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>>>>> +    if (pdc_version < PDC_VERSION_3_2) {
>>>>> +        old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>>>> +        pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>>>>> +    } else {
>>>>> +        u32 val;
>>>>> +
>>>>> +        val = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>>>> +        old_pdc_type = val & IRQ_i_CFG_TYPE_MASK;
>>>>> +        pdc_reg_write(IRQ_i_CFG, d->hwirq,
>>>>> +                  pdc_type | (val & IRQ_i_CFG_IRQ_ENABLE));
>>>>> +    }
>>>> While above is correct, i don't think we need version check in 
>>>> qcom_pdc_gic_set_type() as bits 0-2 are always for the type in 
>>>> old/new version as mentioned in v1.
>>>>
>>>> Adding one line after reading old_pdc_type should be good enough.
>>>
>>> Yes I understood, but while looking at the IRQ_i_CFG bits, I wanted 
>>> to keep the original
>>> driver behavior intact by setting remaining bits to 0.
>>>
>>> Adding this single line changes that behavior and keeps bits 3-31
>>> to the default register value, which may have some consequences.
>>>
>>> If you consider it's an ok change, then I'll reduce it to this 
>>> single line.
>> Yes this ok change to have single line and should not have  any 
>> consequences.
>
> I also remember why, it's about the final check:
>
> 184         if (old_pdc_type != pdc_type)
> 185                 irq_chip_set_parent_state(d, 
> IRQCHIP_STATE_PENDING, false);
>
> We need to strip out remaining bits of old_pdc_type of this won't work as
> expected, so I'll change it to :
>
> +       old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
> +       pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
> +       old_pdc_type &= IRQ_i_CFG_TYPE_MASK;
> +       pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>
> Is it ok for you ?

No.

         old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);

+       pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);

Adding above suggested single line is sufficient to make final check 
properly compare both old_pdc_type and new pdc_type, right?

But with your above change, It will end up comparing only bits 0-2 of 
old_pdc_type with updated pdc_type (which just got the other bits (3 to 
31) of IRQ_i_CFG register by the ORing it with old_pdc_type).

Thanks,
Maulik
