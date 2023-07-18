Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545A67575B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGRHwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGRHwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:52:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D436C2;
        Tue, 18 Jul 2023 00:52:16 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I7hGVe013888;
        Tue, 18 Jul 2023 07:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oQ6BOhiyyrFevBw4ynJ7O3649893Zgi0w2EtY3I9Inw=;
 b=Sm8rK76Ri+mF7jHMxjUWqGiAcGSmstOlWa3rsmQETH/18bbftcRhDgVqkTb4Lv6iyZUk
 p05PV8z6gtvQseMZkqeH3zszFNymJ6VE7VbPYm3xNKKpQyxU8+vpiiVXgLGDXfn5qvJ6
 HN2+0ELNX6m8vdaiymsGq6x2600ejGVLRUAPeB4mwJWM0gD6d+J1jSVoCO9YIa3X3WPk
 vF1VwJCEdvM99J4Yhd5oCQ6Cwwev5BJ0QmsDHHCbocRLfJDHWqQe8LSGmabD/od76KNO
 qhtYRAitqt4hiLoiSZdidlObdSh32OQ9mDdsf/gf8oonmuUmHmENVnKU6KRFCtIuq3KA ww== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwfj78ud8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 07:52:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I7q7MP030165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 07:52:07 GMT
Received: from [10.50.3.220] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 00:52:03 -0700
Message-ID: <2adb5ee2-7876-cdf1-d0c6-437615b4f52c@quicinc.com>
Date:   Tue, 18 Jul 2023 13:21:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 4/7] usb: misc: eud: Add driver support for SM6115 /
 SM4250
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-kernel@vger.kernel.org>,
        <bhupesh.linux@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <gregkh@linuxfoundation.org>,
        <stephan@gerhold.net>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
 <20230718061052.1332993-5-bhupesh.sharma@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20230718061052.1332993-5-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w6giwMxFqSCAA8ImGtdm2dVVwcy_YUgB
X-Proofpoint-ORIG-GUID: w6giwMxFqSCAA8ImGtdm2dVVwcy_YUgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180070
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 7/18/2023 11:40 AM, Bhupesh Sharma wrote:
> Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.
> 
> On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
> needs to be accessed only via the secure world (through 'scm'
> calls).
> 
> Also, the enable bit inside 'tcsr_check_reg' needs to be set
> first to set the eud in 'enable' mode on these SoCs.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   drivers/usb/misc/Kconfig    |  2 +-
>   drivers/usb/misc/qcom_eud.c | 76 ++++++++++++++++++++++++++++++++++---
>   2 files changed, 72 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 99b15b77dfd57..51eb5140caa14 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -146,7 +146,7 @@ config USB_APPLEDISPLAY
>   
>   config USB_QCOM_EUD
>   	tristate "QCOM Embedded USB Debugger(EUD) Driver"
> -	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on (ARCH_QCOM && QCOM_SCM) || COMPILE_TEST
>   	select USB_ROLE_SWITCH
>   	help
>   	  This module enables support for Qualcomm Technologies, Inc.
> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> index 7f371ea1248c3..a5b28fc24116a 100644
> --- a/drivers/usb/misc/qcom_eud.c
> +++ b/drivers/usb/misc/qcom_eud.c
> @@ -11,9 +11,12 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/sysfs.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
>   #include <linux/usb/role.h>
>   
>   #define EUD_REG_INT1_EN_MASK	0x0024
> @@ -30,6 +33,10 @@
>   #define EUD_INT_SAFE_MODE	BIT(4)
>   #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
>   
> +#define EUD_EN2_EN		BIT(0)
> +#define EUD_EN2_DISABLE		(0)
> +#define TCSR_CHECK_EN		BIT(0)
> +
>   struct eud_chip {
>   	struct device			*dev;
>   	struct usb_role_switch		*role_sw;
> @@ -39,6 +46,7 @@ struct eud_chip {
>   	int				irq;
>   	bool				enabled;
>   	bool				usb_attached;
> +	phys_addr_t			secure_mode_mgr;
>   };
>   
>   static int enable_eud(struct eud_chip *priv)
> @@ -46,7 +54,11 @@ static int enable_eud(struct eud_chip *priv)
>   	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
>   	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
>   			priv->base + EUD_REG_INT1_EN_MASK);
> -	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	if (priv->secure_mode_mgr)
> +		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_EN);
> +	else
> +		writel(EUD_EN2_EN, priv->mode_mgr + EUD_REG_EUD_EN2);
>   
>   	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
>   }
> @@ -54,7 +66,11 @@ static int enable_eud(struct eud_chip *priv)
>   static void disable_eud(struct eud_chip *priv)
>   {
>   	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> -	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	if (priv->secure_mode_mgr)
> +		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_DISABLE);
> +	else
> +		writel(EUD_EN2_DISABLE, priv->mode_mgr + EUD_REG_EUD_EN2);
>   }
>   
>   static ssize_t enable_show(struct device *dev,
> @@ -175,9 +191,37 @@ static void eud_role_switch_release(void *data)
>   	usb_role_switch_put(chip->role_sw);
>   }
>   
> +static int eud_find_secure_reg_addr(struct device *dev, u64 *addr)
> +{
> +	struct device_node *tcsr;
> +	struct device_node *np = dev->of_node;
> +	struct resource res;
> +	u32 offset;
> +	int ret;
> +
> +	tcsr = of_parse_phandle(np, "qcom,secure-eud-reg", 0);
> +	if (!tcsr)
> +		return 0;
> +
> +	ret = of_address_to_resource(tcsr, 0, &res);
> +	of_node_put(tcsr);
> +	if (ret)
> +		return ret;
> +
> +	ret = of_property_read_u32_index(np, "qcom,secure-eud-reg", 1, &offset);
> +	if (ret < 0)
> +		return ret;
> +
> +	*addr = res.start + offset;
> +
> +	return 0;
> +}
> +
>   static int eud_probe(struct platform_device *pdev)
>   {
>   	struct eud_chip *chip;
> +	struct resource *res;
> +	phys_addr_t tcsr_check = 0;
>   	int ret;
>   
>   	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> @@ -200,9 +244,30 @@ static int eud_probe(struct platform_device *pdev)
>   	if (IS_ERR(chip->base))
>   		return PTR_ERR(chip->base);
>   
> -	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(chip->mode_mgr))
> -		return PTR_ERR(chip->mode_mgr);
> +	/*
> +	 * EUD block on a few Qualcomm SoCs needs secure register access.
> +	 * Check for the same via vendor-specific dt property.
> +	 */
> +	ret = eud_find_secure_reg_addr(&pdev->dev, &tcsr_check);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (tcsr_check) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!res)
> +			return dev_err_probe(chip->dev, -ENODEV,
> +					     "failed to get secure_mode_mgr reg base\n");
> +
> +		chip->secure_mode_mgr = res->start;

There are multiple instances where the addresses are being mapped from 
the dt property without using the devm version. Either we should switch 
to the later or ensure that these addresses are unmapped in the removal
path of the driver.

Thanks,
Souradeep

> +
> +		ret = qcom_scm_io_writel(tcsr_check, TCSR_CHECK_EN);
> +		if (ret)
> +			return dev_err_probe(chip->dev, ret, "failed to write tcsr check reg\n");
> +	} else {
> +		chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(chip->mode_mgr))
> +			return PTR_ERR(chip->mode_mgr);
> +	}
>   
>   	chip->irq = platform_get_irq(pdev, 0);
>   	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
> @@ -230,6 +295,7 @@ static void eud_remove(struct platform_device *pdev)
>   
>   static const struct of_device_id eud_dt_match[] = {
>   	{ .compatible = "qcom,sc7280-eud" },
> +	{ .compatible = "qcom,sm6115-eud" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, eud_dt_match);
