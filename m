Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55957574C9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjGRG7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjGRG65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:58:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B446E49;
        Mon, 17 Jul 2023 23:58:45 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I6gl92006965;
        Tue, 18 Jul 2023 06:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EAWS+c+IzVya2F5wKY86ZUuDYaCy4CUeVP9OqbPfYL0=;
 b=RLiwKQNhg9IiVnMbnOssuOpYzyDhbWHO2qAOe57UMkOqutLehtbnhsdwGuIZXaMVAKe/
 IFZzUvpzYGMnbZckAMAYnrpq5TS8Zt7IX/4fUC094t3+d45nxe1BBn+J69GD1825puOW
 /11PEBEa9/TM40Yi6eeCF28c/IPfWE1tGHjVG43+AdtV3ipMMocjt2ze/bxs9kpYx0dd
 R4fJr9M5+thAxx469lotEWN5yRuC+PQ2swt7NSQrFS9DulmSnOGanO+ff/SNiUaIHpQc
 C5yj0i1FswBEEXv+9Vz3EyMXIP1g3FVfCUus7emtGlVgaTwdcd5s2Ot5NPg5rwXYBz16 Qg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rweag0ss3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 06:58:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I6wdbT015362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 06:58:39 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 17 Jul
 2023 23:58:36 -0700
Message-ID: <86631cb4-6b99-c3a7-428e-4534891da4c7@quicinc.com>
Date:   Tue, 18 Jul 2023 14:58:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/2] Input: pm8xxx-vib - Add support for more PMICs
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_kamalw@quicinc.com>,
        <jestar@qti.qualcomm.com>
References: <20230718062639.2339589-1-quic_fenglinw@quicinc.com>
 <20230718062639.2339589-3-quic_fenglinw@quicinc.com>
 <CAA8EJpq_DGu3+kc_ex_2MUyiQFJvZhbWOc7NO6x1pO1Wx4RbNw@mail.gmail.com>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <CAA8EJpq_DGu3+kc_ex_2MUyiQFJvZhbWOc7NO6x1pO1Wx4RbNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CnARUE0AlEbov_YJkZM4G8PeMyj3wrVf
X-Proofpoint-GUID: CnARUE0AlEbov_YJkZM4G8PeMyj3wrVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180062
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/2023 2:44 PM, Dmitry Baryshkov wrote:
> On Tue, 18 Jul 2023 at 09:27, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>>
>> Add support for vibrator module inside PMI632, PM7250B, PM7325B.
>> It is very similar to vibrator inside PM8xxx but just the drive
>> amplitude is controlled through 2 bytes registers.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   drivers/input/misc/pm8xxx-vibrator.c | 48 ++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
>> index 04cb87efd799..213fdfd47c7f 100644
>> --- a/drivers/input/misc/pm8xxx-vibrator.c
>> +++ b/drivers/input/misc/pm8xxx-vibrator.c
>> @@ -25,6 +25,9 @@ struct pm8xxx_regs {
>>          unsigned int drv_addr;
>>          unsigned int drv_mask;
>>          unsigned int drv_shift;
>> +       unsigned int drv_addr2;
>> +       unsigned int drv_mask2;
>> +       unsigned int drv_shift2;
>>          unsigned int drv_en_manual_mask;
>>   };
>>
>> @@ -44,6 +47,42 @@ static struct pm8xxx_regs pm8916_regs = {
>>          .drv_en_manual_mask = 0,
>>   };
>>
>> +static struct pm8xxx_regs pmi632_regs = {
>> +       .enable_addr = 0x5746,
>> +       .enable_mask = BIT(7),
>> +       .drv_addr = 0x5740,
>> +       .drv_mask = 0xff,
>> +       .drv_shift = 0,
>> +       .drv_addr2 = 0x5741,
>> +       .drv_mask2 = 0x0f,
>> +       .drv_shift2 = 8,
> 
> I see that you are just expanding what was done for SSBI PMICs and
> later expanded to support pm8916. However it might be better to drop
> the hardcoded .drv_addr (and drv_addr2) and read address from DT
> instead.
> 

Right, this is the simplest change without updating the code logic too 
much. If we decided to read .drv_addr and .drv_add2 from DT, we will 
have to read .enable_addr along with all other mask/shift for each 
register address from DT as well because they are not consistent from 
target to target. I don't know how would you suggest to add the DT 
properties for all of them, but if we end up to add a property for each 
of them, it won't be cleaner than hard-coding them.


>> +       .drv_en_manual_mask = 0,
>> +};
>> +
>> +static struct pm8xxx_regs pm7250b_regs = {
>> +       .enable_addr = 0x5346,
>> +       .enable_mask = BIT(7),
>> +       .drv_addr = 0x5340,
>> +       .drv_mask = 0xff,
>> +       .drv_shift = 0,
>> +       .drv_addr2 = 0x5341,
>> +       .drv_mask2 = 0x0f,
>> +       .drv_shift2 = 8,
>> +       .drv_en_manual_mask = 0,
>> +};
>> +
>> +static struct pm8xxx_regs pm7325b_regs = {
>> +       .enable_addr = 0xdf46,
>> +       .enable_mask = BIT(7),
>> +       .drv_addr = 0xdf40,
>> +       .drv_mask = 0xff,
>> +       .drv_shift = 0,
>> +       .drv_addr2 = 0xdf41,
>> +       .drv_mask2 = 0x0f,
>> +       .drv_shift2 = 8,
>> +       .drv_en_manual_mask = 0,
>> +};
>> +
>>   /**
>>    * struct pm8xxx_vib - structure to hold vibrator data
>>    * @vib_input_dev: input device supporting force feedback
>> @@ -87,6 +126,12 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
>>                  return rc;
>>
>>          vib->reg_vib_drv = val;
>> +       if (regs->drv_addr2 != 0 && on) {
>> +               val = (vib->level << regs->drv_shift2) & regs->drv_mask2;
>> +               rc = regmap_write(vib->regmap, regs->drv_addr2, val);
>> +               if (rc < 0)
>> +                       return rc;
>> +       }
>>
>>          if (regs->enable_mask)
>>                  rc = regmap_update_bits(vib->regmap, regs->enable_addr,
>> @@ -242,6 +287,9 @@ static const struct of_device_id pm8xxx_vib_id_table[] = {
>>          { .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
>>          { .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
>>          { .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
>> +       { .compatible = "qcom,pmi632-vib", .data = &pmi632_regs },
>> +       { .compatible = "qcom,pm7250b-vib", .data = &pm7250b_regs },
>> +       { .compatible = "qcom,pm7325b-vib", .data = &pm7325b_regs },
>>          { }
>>   };
>>   MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
>> --
>> 2.25.1
>>
> 
> 
