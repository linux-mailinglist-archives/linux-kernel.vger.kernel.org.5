Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD127E028A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346628AbjKCMGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346653AbjKCMGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:06:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF34D57;
        Fri,  3 Nov 2023 05:06:41 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3BZGQA031141;
        Fri, 3 Nov 2023 12:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kKIHQVcNCXx8xzP1vq3F8HzZ8M04S9wN1C8UYOfoloA=;
 b=FPWERMw0r5QgRbvxUes7znJKuko1j+Qnt/Q7jqFKQSaiAnMyetfMEUrKjelOaqMEDTYd
 N8RAChAlsOcs0IOO+X5fFLQFe1ogTu2ab81C6h1A/A5m2FphGrdrLJUmMCZAaj1N/4Fn
 isTIQXetsGjlHgC5zsd5QY99irG5OeaKn9lytNfYLvb+dCgMP26w3y+iKgiDyytQ5Cc+
 HQwmLLT4+ORubG218bNe58rWdlC/mzyoKbJd7tBPZGQmThJD+fj7vpOUDg9T5TR+Q3RW
 qnrC6beojyI0enTHjB9uCkgWkAUMqn4+zychmw08B1RC8a2JpNIQx4NZjoqy864nPzfO nA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4v8mrh7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 12:06:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3C6Iv4008003
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 12:06:18 GMT
Received: from [10.216.26.1] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 05:06:13 -0700
Message-ID: <02a67a6d-30fd-4b15-349d-1cd8afab13ca@quicinc.com>
Date:   Fri, 3 Nov 2023 17:36:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 1/5] mtd: nand: ecc-qcom: Add support for ECC Engine
 Driver
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <qpic_varada@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
 <20231031120307.1600689-2-quic_mdalam@quicinc.com>
 <20231031162856.1d9e3246@xps-13>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20231031162856.1d9e3246@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YIFGWj8pYVzMeszAA2MTkWchuZn1GNCH
X-Proofpoint-ORIG-GUID: YIFGWj8pYVzMeszAA2MTkWchuZn1GNCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030101
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2023 8:58 PM, Miquel Raynal wrote:
> Hi,
> 
> quic_mdalam@quicinc.com wrote on Tue, 31 Oct 2023 17:33:03 +0530:
> 
> Commit log is missing.

Having a separate device node for ECC was NAK-ed
https://www.spinics.net/lists/linux-arm-msm/msg177596.html

It is fine to drop this patch ? keep ECC support inlined in both
raw nand and Serial nand driver.


> 
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> 
> If Sricharan is a co developer you need to use the right tags. Please
> have a look at the documentation. Using the two SoB here does not mean
> anything
Ok will fix

> 
>> ---
>>   drivers/mtd/nand/Kconfig    |   7 ++
>>   drivers/mtd/nand/Makefile   |   1 +
>>   drivers/mtd/nand/ecc-qcom.c | 198 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 206 insertions(+)
>>   create mode 100644 drivers/mtd/nand/ecc-qcom.c
>>
>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>> index 5b0c2c95f10c..333cec8187c8 100644
>> --- a/drivers/mtd/nand/Kconfig
>> +++ b/drivers/mtd/nand/Kconfig
>> @@ -61,6 +61,13 @@ config MTD_NAND_ECC_MEDIATEK
>>   	help
>>   	  This enables support for the hardware ECC engine from Mediatek.
>>   
>> +config MTD_NAND_ECC_QCOM
>> +	tristate "Qualcomm hardware ECC engine"
>> +	depends on ARCH_QCOM
> 
> Same comment as Mark regarding COMPILE_TEST
Ok
> 
>> +	select MTD_NAND_ECC
>> +	help
>> +	  This enables support for the hardware ECC engine from Qualcomm.
>> +
>>   endmenu
>>   
>>   endmenu
>> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
>> index 19e1291ac4d5..c73b8a3456ec 100644
>> --- a/drivers/mtd/nand/Makefile
>> +++ b/drivers/mtd/nand/Makefile
>> @@ -3,6 +3,7 @@
>>   nandcore-objs := core.o bbt.o
>>   obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
>>   obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) += ecc-mtk.o
>> +obj-$(CONFIG_MTD_NAND_ECC_QCOM) += ecc-qcom.o qpic_common.o
>>   
>>   obj-y	+= onenand/
>>   obj-y	+= raw/
>> diff --git a/drivers/mtd/nand/ecc-qcom.c b/drivers/mtd/nand/ecc-qcom.c
>> new file mode 100644
>> index 000000000000..a85423ed368a
>> --- /dev/null
>> +++ b/drivers/mtd/nand/ecc-qcom.c
>> @@ -0,0 +1,198 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * QCOM ECC Engine  Driver.
>> + * Copyright (C) 2023  Qualcomm Inc.
>> + * Authors:	Md sadre Alam		<quic_mdalam@quicinc.com>
>> + *		Sricharan R		<quic_srichara@quicinc.com>
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/clk.h>
>> +#include <linux/module.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/mutex.h>
>> +#include <linux/mtd/nand-qpic-common.h>
>> +
>> +
>> +
>> +/* ECC modes supported by the controller */
>> +#define ECC_NONE        BIT(0)
>> +#define ECC_RS_4BIT     BIT(1)
>> +#define ECC_BCH_4BIT    BIT(2)
>> +#define ECC_BCH_8BIT    BIT(3)
>> +
>> +struct qpic_ecc_caps {
>> +	u32 err_mask;
>> +	u32 err_shift;
>> +	const u8 *ecc_strength;
>> +	const u32 *ecc_regs;
>> +	u8 num_ecc_strength;
>> +	u8 ecc_mode_shift;
>> +	u32 parity_bits;
>> +	int pg_irq_sel;
>> +};
>> +
>> +
>> +struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
>> +{
>> +	return container_of(chip, struct qcom_nand_host, chip);
>> +}
>> +EXPORT_SYMBOL(to_qcom_nand_host);
>> +
>> +struct qcom_nand_controller *
>> +get_qcom_nand_controller(struct nand_chip *chip)
>> +{
>> +	return container_of(chip->controller, struct qcom_nand_controller,
>> +			    controller);
>> +}
>> +EXPORT_SYMBOL(get_qcom_nand_controller);
>> +
>> +static struct qpic_ecc *qpic_ecc_get(struct device_node *np)
>> +{
>> +	struct platform_device *pdev;
>> +	struct qpic_ecc *ecc;
>> +
>> +	pdev = of_find_device_by_node(np);
>> +	if (!pdev)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	ecc = platform_get_drvdata(pdev);
>> +	if (!ecc) {
>> +		put_device(&pdev->dev);
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +	}
>> +
>> +	return ecc;
>> +}
>> +
>> +struct qpic_ecc *of_qpic_ecc_get(struct device_node *of_node)
>> +{
>> +	struct qpic_ecc *ecc = NULL;
>> +	struct device_node *np;
>> +
>> +	np = of_parse_phandle(of_node, "nand-ecc-engine", 0);
>> +	/* for backward compatibility */
> 
> There is no backward compatibility to handle upstream

Ok will fix in V1

> 
>> +	if (!np)
>> +		np = of_parse_phandle(of_node, "ecc-engine", 0);
>> +	if (np) {
>> +		ecc = qpic_ecc_get(np);
>> +		of_node_put(np);
>> +	}
>> +
>> +	return ecc;
>> +}
>> +EXPORT_SYMBOL(of_qpic_ecc_get);
>> +
>> +int qcom_ecc_config(struct qpic_ecc  *ecc, int ecc_strength,
>> +			bool wide_bus)
>> +{
>> +	ecc->ecc_modes = (ECC_RS_4BIT | ECC_BCH_8BIT);
>> +
>> +	if (ecc_strength >= 8) {
> 
> If your engine does not support more than an 8-bit strength this
> condition seems a bit strange.

Max ECC supported 8-bit only, forcing it to 8-bit.

> 
>> +		/* 8 bit ECC defaults to BCH ECC on all platforms */
>> +		ecc->bch_enabled = true;
>> +		ecc->ecc_mode = 1;
> 
> ecc_modes above, ecc_mode here, not very clear what this is.
> Please give meaningful names to your variables, not just the bit name
> that this is capturing because here it's unclear what this is.

ok will fix in V1

> 
>> +
>> +		if (wide_bus) {
>> +			ecc->ecc_bytes_hw = 14;
>> +			ecc->spare_bytes = 0;
> 
> Spare bytes depend on the flash, you can't use constant values like
> that.
Ok will fix in V1
> 
> I also don't understand what wide_bus is and why it has an impact of
> only 1 on the number of ECC bytes. Please make all this more explicit.

wide_bus 1 means 16-bit wide and wide_bus 0 means 8-bit wide.
there different configuration for ecc config for 16-bit wide bus
and 8-bit wide bus. This is recommended configuration by IP team,
Will reconfirm this with IP folks and come back.


Regards,
Alam.
