Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9F7825B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjHUIlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjHUIlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:41:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAF2A9;
        Mon, 21 Aug 2023 01:41:37 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37L6iJTT026842;
        Mon, 21 Aug 2023 08:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5G2kWXFBNydEkl+NRD/kiWcZiaatGrDVYBA/jsz/mrk=;
 b=Oae2d2udsQSssjhFYdDtZ2+bEDkU2cBeSYrnFWkWQvWac5hVMOVA2HcE/cWsJUu94Nk1
 7uCWWflIYQazewCGfiT3bqStbhsjS36iweR5J+0lV7lSmo/JO8ayTeuZsMiY/2/1UqSj
 djglVYfqG8me9ElXiF9O2Fc7Lh9aW49iAjYIBIPMlWhzW37PN+x5ZSmfM7tMkDCricQk
 K2xL9PU0p5plMqi7U1pWWv/M94txft/LbnxGjzeCpmHQmti84VnadNhqHByGQn7F/Fsh
 nfKkJJ3BiML7eFr2DTkflMCwfL4o8I/NTEm24Hg144ZPjU5CVLeXG8PUNL+H29smns7Z mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjnu1315b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 08:41:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37L8fKdw031773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 08:41:20 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 21 Aug
 2023 01:41:17 -0700
Message-ID: <0439125b-2952-229b-497f-c44592621410@quicinc.com>
Date:   Mon, 21 Aug 2023 14:11:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] irqchip/qcom-pdc: add support for v3.2 HW
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230821-topic-sm8x50-upstream-pdc-ver-v1-1-6d7f4dd95719@linaro.org>
Content-Language: en-US
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20230821-topic-sm8x50-upstream-pdc-ver-v1-1-6d7f4dd95719@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ztkru9g_zK5LgYZeqEQP9hW7YnwX5vhZ
X-Proofpoint-GUID: ztkru9g_zK5LgYZeqEQP9hW7YnwX5vhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210079
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/21/2023 1:00 PM, Neil Armstrong wrote:
> The PDC Hw version 3.2 and later doesn't have the enable registers
> anymore, get the HW version from registers and stop accessing those
> registers starting at this version.

Starting PDC v3.2, enable bit is moved from IRQ_ENABLE_BANK to the 
IRQ_i_CFG register.
we need to set enable bit to tell PDC HW whether IRQ is enabled / 
disabled in order to wake up from SoC sleep states.

>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/irqchip/qcom-pdc.c | 64 ++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 53 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index d96916cf6a41..620efb9fcc96 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -26,6 +26,13 @@
>   #define IRQ_ENABLE_BANK		0x10
>   #define IRQ_i_CFG		0x110
>   
> +#define PDC_VERSION		0x1000
> +
> +/* Notable PDC versions */
> +enum {
> +	PDC_VERSION_3_2	= 0x30200,
> +};
> +
>   struct pdc_pin_region {
>   	u32 pin_base;
>   	u32 parent_base;
> @@ -38,6 +45,7 @@ static DEFINE_RAW_SPINLOCK(pdc_lock);
>   static void __iomem *pdc_base;
>   static struct pdc_pin_region *pdc_region;
>   static int pdc_region_cnt;
> +static unsigned int pdc_version;
>   
>   static void pdc_reg_write(int reg, u32 i, u32 val)
>   {
> @@ -183,6 +191,25 @@ static struct irq_chip qcom_pdc_gic_chip = {
>   	.irq_set_affinity	= irq_chip_set_affinity_parent,
>   };
>   
> +static struct irq_chip qcom_pdc_gic_chip_3_2 = {
> +	.name			= "PDC",
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_disable		= irq_chip_disable_parent,
> +	.irq_enable		= irq_chip_enable_parent,
> +	.irq_get_irqchip_state	= irq_chip_get_parent_state,
> +	.irq_set_irqchip_state	= irq_chip_set_parent_state,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_set_type		= qcom_pdc_gic_set_type,
> +	.flags			= IRQCHIP_MASK_ON_SUSPEND |
> +				  IRQCHIP_SET_TYPE_MASKED |
> +				  IRQCHIP_SKIP_SET_WAKE |
> +				  IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
> +	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +};
> +
we should not need to have another irqchip defined for same as these 
remains same for old/new version.

Not sure if you have access to downstream change, or let me know i can 
post the same.
In downstream we do like...

The 3rd bit in IRQ_i_CFG in PDC v3.2 is for enable/disable,
The 0-2 bits are for the IRQ type in all PDC versions..

     #define IRQ_i_CFG_IRQ_ENABLE   BIT(3)
     #define IRQ_i_CFG_TYPE_MASK    0x7

and modify pdc_enable_intr()

        if (pdc_version < PDC_VERSION_3_2) {
                index = pin_out / 32;
                mask = pin_out % 32;
                enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
                __assign_bit(mask, &enable, on);
                pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
        } else {
                index = d->hwirq;
                enable = pdc_reg_read(IRQ_i_CFG, index);
                __assign_bit(IRQ_i_CFG_IRQ_ENABLE, &enable, on);
                pdc_reg_write(IRQ_i_CFG, index, enable);
        }

and qcom_pdc_gic_set_type(), add line to only take 0-2 bits from 
old_pdc_type as they are for type.

         old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+       pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
> +		if (pdc_version < PDC_VERSION_3_2)
> +			pdc_enable_region(n);
>   	}

you will still need to clear enable bits in version 3.2.

Thanks,
Maulik

