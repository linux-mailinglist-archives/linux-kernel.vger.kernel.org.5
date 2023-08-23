Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575387852C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjHWIeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjHWIbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:31:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709D71FED;
        Wed, 23 Aug 2023 01:26:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N8G1e2011553;
        Wed, 23 Aug 2023 08:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GlyOkSbeWlPKEVbbjapYJOUhwXIA4m7w8RYHyH7iTvM=;
 b=LWiFG7EzMWWlHsaEGW+zpfFZrI+VmWrtpxwqKDf3al4cEAC91KKRQTCsG5LNT6JywUxy
 rqVWe+yU/DTe5cPTdqnJAPQ8T8q422rCx1CUT7+uB/97CkIl9CBo+xiOBX7ooW5QRPXt
 eCdltUJsmUvlFKxQ0doQz7Xi9esXsKNXfx9FroaePk6ujPsF4xJQc+H2RfvhD3sHOkRz
 O8VtKcpy6q744dlKz+ZVe1hqzWz40297EidCEY3n1l9Tips2PEtQFCsv3hVsIHXZDQFi
 7tgg/+DZTOUK5/QtZQHSEU9oXbpntI2YrWQYsukD5k3HZfE6vbbuBVmktnw9bU0NQyKl kA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2t41eey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 08:25:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37N8PxlF014549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 08:25:59 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 01:25:56 -0700
Message-ID: <dcf0cddc-2a35-2ddb-1912-465e29413b9c@quicinc.com>
Date:   Wed, 23 Aug 2023 13:55:53 +0530
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
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <543b1f3d-60b6-44fd-bddf-eb35cc163e10@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UcN1_dw_aWnKY9423VQWx1YxiwGHUqsO
X-Proofpoint-ORIG-GUID: UcN1_dw_aWnKY9423VQWx1YxiwGHUqsO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230076
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/23/2023 1:16 PM, Neil Armstrong wrote:
> Hi,
>
> On 23/08/2023 07:35, Maulik Shah (mkshah) wrote:
>> Hi Neil,
>>
>> @@ -142,8 +163,17 @@ static int qcom_pdc_gic_set_type(struct irq_data 
>> *d, unsigned int type)
>>>           return -EINVAL;
>>>       }
>>> -    old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>> -    pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>>> +    if (pdc_version < PDC_VERSION_3_2) {
>>> +        old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>> +        pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>>> +    } else {
>>> +        u32 val;
>>> +
>>> +        val = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>> +        old_pdc_type = val & IRQ_i_CFG_TYPE_MASK;
>>> +        pdc_reg_write(IRQ_i_CFG, d->hwirq,
>>> +                  pdc_type | (val & IRQ_i_CFG_IRQ_ENABLE));
>>> +    }
>> While above is correct, i don't think we need version check in 
>> qcom_pdc_gic_set_type() as bits 0-2 are always for the type in 
>> old/new version as mentioned in v1.
>>
>> Adding one line after reading old_pdc_type should be good enough.
>
> Yes I understood, but while looking at the IRQ_i_CFG bits, I wanted to 
> keep the original
> driver behavior intact by setting remaining bits to 0.
>
> Adding this single line changes that behavior and keeps bits 3-31
> to the default register value, which may have some consequences.
>
> If you consider it's an ok change, then I'll reduce it to this single 
> line.
Yes this ok change to have single line and should not have  any 
consequences.

Thanks,
Maulik

