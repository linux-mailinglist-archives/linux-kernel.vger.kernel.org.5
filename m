Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92574757309
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjGRFJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGRFJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:09:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A47012F;
        Mon, 17 Jul 2023 22:09:11 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I3FCU2022182;
        Tue, 18 Jul 2023 05:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=I1DxiGEZyd8QbRErBmMkW95iq3qQZEgJgDYHG45ZqJk=;
 b=DcelHJ+bHOLHzNtcztT678xFnsF61sBV0FnmR5rcOooiKmrhQJD2zDbbveKqdpbSw6Hm
 er+GW3ZOVWnwI5uW4sjE8s5k1miZKygnFA4q1DYbePhbH1OYFOvM3e+yfI5QBIHjPclf
 BdVxEsqDhFRBP+DHv/hQr5A75nfc/k8KJ9beyftgIPtkTZ3cn5bTOk56jGjXRZFr+7Sw
 AH+nYwBm5GmLoeadP/sHLXftQq+Lmbi5pxeA1rlqIwsCqasce5Zu80fly/wJ3sRwlmEc
 ilnuFCZu/xZ7r03SIq4QK4LHZm0OhFBdhkCSlKo/4f8HdKPYoAjRCkrafwSJYYvzsbdS dA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwcg6rs3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 05:09:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I596eP011767
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 05:09:06 GMT
Received: from [10.50.15.149] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 17 Jul
 2023 22:09:03 -0700
Message-ID: <760778dc-b0af-2adb-fa9e-4059a17a2cdf@quicinc.com>
Date:   Tue, 18 Jul 2023 10:38:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ninad Naik <quic_ninanaik@quicinc.com>
Subject: Re: [PATCH] pinctrl: qcom: Add intr_target_width to define
 intr_target_bit field width
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        <konrad.dybcio@linaro.org>, <andersson@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppareek@quicinc.com>, <psodagud@quicinc.com>,
        <quic_kprasan@quicinc.com>
References: <20230714061010.15817-1-quic_ninanaik@quicinc.com>
 <20230714203802.GA3972960@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20230714203802.GA3972960@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Tkq62HP2qQF8XeHOFrjPa39bLqdJjfK7
X-Proofpoint-GUID: Tkq62HP2qQF8XeHOFrjPa39bLqdJjfK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you all for the reviews.

On 7/15/2023 2:08 AM, Bjorn Andersson wrote:
> On Fri, Jul 14, 2023 at 11:40:09AM +0530, Ninad Naik wrote:
>> SA8775 and newer target have added support for an increased number of
>> interrupt targets. To implement this change, the intr_target field, which
>> is used to configure the interrupt target in the interrupt configuration
>> register is increased from 3 bits to 4 bits.
>>
>> In accordance to these updates, a new intr_target_width member is
>> introduced in msm_pingroup structure. This member stores the value of
>> width of intr_target field in the interrupt configuration register. This
>> value is used to dynamically calculate and generate mask for setting the
>> intr_target field. By default, this mask is set to 3 bit wide, to ensure
>> backward compatibility with the older targets.
>>
>> Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>
> 
> Very nice, Ninad.
> 
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
>> ---
>>   drivers/pinctrl/qcom/pinctrl-msm.c     | 9 ++++++---
>>   drivers/pinctrl/qcom/pinctrl-msm.h     | 2 ++
>>   drivers/pinctrl/qcom/pinctrl-sa8775p.c | 1 +
>>   3 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index 2585ef2b2793..6ebcaa2220af 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -1038,6 +1038,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>>   	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>>   	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>>   	const struct msm_pingroup *g;
>> +	u32 intr_target_mask = 0x7;
> 
> I like Konrad's suggestion about making this GENMASK(2, 0).
> 
> Please update that and include our R-b tags in v2.
> 
Sure, I'll change this to GENMASK and update all the relevant tags 
(Fixes and R-b) as suggested in the review comments.
> Regards,
> Bjorn

Thanks a lot!
Regards,
Ninad
