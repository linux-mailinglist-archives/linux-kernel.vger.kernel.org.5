Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EF0784FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjHWFfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjHWFf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:35:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24998E54;
        Tue, 22 Aug 2023 22:35:28 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N4ogIm004899;
        Wed, 23 Aug 2023 05:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ol6Jy1Bf/FmfaifZ05G/YHcAHaQnT5VOAu/i2s5OvsY=;
 b=WQZFlUmEz1tgK/X80SWHDlmJSHWGuJfALc5FEjb13vcr369Dd73Zw1WTdO7LPgM1K7wE
 163tk1VgV67GYcH3uawwXsT8RoRDeAEwrNPnNWlqtG7h/WyNnnZQk8Msvaiwo7+spkgC
 MAhA6AJJTz9GA8pcWOhBHNjzMRupzGXSZth4e+UVbgg0IQJIc0oDvKHUjjNLpN/ajDQa
 bkXzrOkvPuWuTfXxYlLek34iGWQ9s54sWdKvMsUgGjhZlHIw4+XAEc9kZmBDqLimHscK
 Z4Sz1TQ5sSDYJDHSbELYD7JHkvBv+Sx2ON5Fbg4Fi6AL0OFwvwnylRWXmQTazr5t4PeU zQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn24j17c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 05:35:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37N5Z9Gn013888
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 05:35:09 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 22:35:07 -0700
Message-ID: <5d5ad774-3269-232a-db15-751726742460@quicinc.com>
Date:   Wed, 23 Aug 2023 11:05:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] irqchip/qcom-pdc: add support for v3.2 HW
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230822-topic-sm8x50-upstream-pdc-ver-v2-1-3035b8d388f7@linaro.org>
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20230822-topic-sm8x50-upstream-pdc-ver-v2-1-3035b8d388f7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OAD46GUd0NwrUnW3M9VIQnHkWBqKsdiv
X-Proofpoint-GUID: OAD46GUd0NwrUnW3M9VIQnHkWBqKsdiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_02,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=794 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230051
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

@@ -142,8 +163,17 @@ static int qcom_pdc_gic_set_type(struct irq_data 
*d, unsigned int type)
>   		return -EINVAL;
>   	}
>   
> -	old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
> -	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
> +	if (pdc_version < PDC_VERSION_3_2) {
> +		old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
> +		pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
> +	} else {
> +		u32 val;
> +
> +		val = pdc_reg_read(IRQ_i_CFG, d->hwirq);
> +		old_pdc_type = val & IRQ_i_CFG_TYPE_MASK;
> +		pdc_reg_write(IRQ_i_CFG, d->hwirq,
> +			      pdc_type | (val & IRQ_i_CFG_IRQ_ENABLE));
> +	}
While above is correct, i don't think we need version check in 
qcom_pdc_gic_set_type() as bits 0-2 are always for the type in old/new 
version as mentioned in v1.

Adding one line after reading old_pdc_type should be good enough.

   old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+ pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
> +			if (pdc_version < PDC_VERSION_3_2) {
> +				u32 irq_index, reg_index;
> +
> +				reg_index = (i + pdc_region[n].pin_base) >> 5;
> +				irq_index = (i + pdc_region[n].pin_base) & 0x1f;
> +				val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
> +				val &= ~BIT(irq_index);
can use  __assign_bit(irq_index, &val, 0); here.
> +				pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
> +			} else {
> +				u32 irq;
> +
> +				irq = i + pdc_region[n].pin_base;
> +				val = pdc_reg_read(IRQ_i_CFG, irq);
> +				val &= ~IRQ_i_CFG_IRQ_ENABLE;

__assign_bit(IRQ_i_CFG_IRQ_ENABLE, &val,  0); here.

other than this..
Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>

Thanks,
Maulik

