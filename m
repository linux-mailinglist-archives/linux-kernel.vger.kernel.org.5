Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E5C75E225
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGWNst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWNss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:48:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58384183;
        Sun, 23 Jul 2023 06:48:46 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NDiBfw009438;
        Sun, 23 Jul 2023 13:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cMclTMBiKLFYEPbg2aJqeMfsroQrOFV2ZrOx1/pqiU4=;
 b=XGWibs54h5GgHRbtWLldPnuUhBawD+vr/X7UGv0ckN8TsQIvyyuXp7Dc5qLWfCSLoZ9o
 L/9Jg4lDhyADVimpywfryV8qabYqgMQ6ZQw5AgT+05/WgYRz1e/H6iH7/Zfl+qrx+rh3
 RPGRobi6xhQKWpo7+bOFaAJ71nIJ7oZt7gfyuDGZY8wh6XPv5Q5sFSQHdXGhhetw/IJX
 hhsebgIYRoj/tp7eDZ5kt3jDnROtd1oxvhf2z0tSthqrEHUCNoSK9c2GO9fp67wuPCFf
 Y7Yx7MpKHPcJjS3/g1kXUtsDcgdmFI/rhTZjZvdYaHaL/w7fRZGgKIaW2Q0FmYb1QBMz uA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s064dhpdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 13:48:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36NDmdR0009246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 13:48:39 GMT
Received: from [10.216.27.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 23 Jul
 2023 06:48:33 -0700
Message-ID: <2d790f7e-b373-f0ee-d978-fb78bc4f1ed1@quicinc.com>
Date:   Sun, 23 Jul 2023 19:18:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V5 2/3] pinctrl: qcom: Use qcom_scm_io_update_field()
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_saahtoma@quicinc.com>
References: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
 <20230720070408.1093698-3-quic_kathirav@quicinc.com>
 <z2isxt5zqaawkfgfdgogkimsutlvem7weoaatulhq2tcqt44rk@em4fvztj3eox>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <z2isxt5zqaawkfgfdgogkimsutlvem7weoaatulhq2tcqt44rk@em4fvztj3eox>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FaGS-JbVnQQj9Jm4O50NK_vdY9SkRngN
X-Proofpoint-ORIG-GUID: FaGS-JbVnQQj9Jm4O50NK_vdY9SkRngN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_03,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307230127
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/2023 8:39 AM, Bjorn Andersson wrote:
> On Thu, Jul 20, 2023 at 12:34:07PM +0530, Kathiravan T wrote:
>> From: Mukesh Ojha <quic_mojha@quicinc.com>
>>
>> Use qcom_scm_io_update_field() function introduced in the commit
>> 1f899e6997bb ("firmware: qcom_scm: provide a read-modify-write function").
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>> Changes in V5:
>> 	- Dropped the ununecessary paranthesis
>> 	- Updated the commit message to indicate the commit ID in which
>> 	  qcom_scm_io_update_field is introduced instead of simply
>> 	  mentioning the "last commit"
>>
>>   drivers/pinctrl/qcom/pinctrl-msm.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index 2585ef2b2793..5ecde5bea38b 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -1040,6 +1040,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>>   	const struct msm_pingroup *g;
>>   	unsigned long flags;
>>   	bool was_enabled;
>> +	u32 mask;
>>   	u32 val;
>>   
>>   	if (msm_gpio_needs_dual_edge_parent_workaround(d, type)) {
>> @@ -1074,23 +1075,20 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>>   	 * With intr_target_use_scm interrupts are routed to
>>   	 * application cpu using scm calls.
>>   	 */
>> +	mask = GENMASK(2, 0) << g->intr_target_bit;
>>   	if (pctrl->intr_target_use_scm) {
>>   		u32 addr = pctrl->phys_base[0] + g->intr_target_reg;
>>   		int ret;
>>   
>> -		qcom_scm_io_readl(addr, &val);
>> -
>> -		val &= ~(7 << g->intr_target_bit);
>> -		val |= g->intr_target_kpss_val << g->intr_target_bit;
>> -
>> -		ret = qcom_scm_io_writel(addr, val);
>> +		val = g->intr_target_kpss_val << g->intr_target_bit;
>> +		ret = qcom_scm_io_update_field(addr, mask, val);
> Be aware when you resubmit that this code has changed. So please base
> your changes on linux-next.


I applied and tested this change on top of linux-next before sending it. 
I hope you are referring to the Ninad's patch[1] which is not available 
on linux-next yet. I shall wait for couple of days before sending the 
another version or let me resend based on Ninad's patch. Please let me 
know if you are referring something else.

[1] 
https://lore.kernel.org/linux-arm-msm/20230718064246.12429-1-quic_ninanaik@quicinc.com/


> Regards,
> Bjorn
