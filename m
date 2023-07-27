Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E949E7654F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjG0N0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjG0N0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:26:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3F271D;
        Thu, 27 Jul 2023 06:26:46 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RBdTKC020078;
        Thu, 27 Jul 2023 13:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jjWj5lEM3h2Rk9dh7enVIxrYzl1hR1WUbwdA0CpM62E=;
 b=NRq1cl2KtEaQAnYEDd/s6JaN/6dhpRalZN/de7w1DY661aNLb9Kgrl4qs3qoh/37LcL8
 pZ4jvWIg39alAF7vVTai8MO9WohvghnlGEtLzAo53gsqJwxAAFqRUlHNT1lYkAvzjDtr
 NraAVpGWRUI3Xud02eXkkXjyatY+QckSUjYXFQzhgdKOhFEl3jf5pEcUhxHkrmkQwy6D
 FXcXPDwxq2bIG/hBe+hbIbCSulEQJlyopMvBGBprTY0lpz+GhRvy2JjRXb7yaDNC7Per
 VnpJLovZuKpax3cf2If1Qirz/Gc9eNdNHFeYIDHOsLZN1F4DhOeJ0zFhciTYR4dFrWS3 qA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s34x6jjyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 13:26:42 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RDQfVp031584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 13:26:41 GMT
Received: from [10.216.12.191] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 06:26:38 -0700
Message-ID: <9fd66ca4-36f2-e6c2-fdb3-76e00e1e954b@quicinc.com>
Date:   Thu, 27 Jul 2023 18:56:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-3-quic_kbajaj@quicinc.com>
 <9f417fea-38cf-942b-514e-99b47f27c544@quicinc.com>
In-Reply-To: <9f417fea-38cf-942b-514e-99b47f27c544@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d0ejwwke46VDVtMhRrA7Ub4NAnNpD6bC
X-Proofpoint-ORIG-GUID: d0ejwwke46VDVtMhRrA7Ub4NAnNpD6bC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270121
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2023 12:09 PM, Mukesh Ojha wrote:
> Hi,
> 
> Some questions, may not need to be addressed if the reason is
> known
> 
> On 7/24/2023 2:08 PM, Komal Bajaj wrote:
>> For some of the Qualcomm SoC's, it is possible that
>> some of the fuse regions or entire qfprom region is
>> protected from non-secure access. In such situations,
>> Linux will have to use secure calls to read the region.
>> With that motivation, add secure qfprom driver.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/nvmem/Kconfig      |  13 +++++
>>   drivers/nvmem/Makefile     |   2 +
>>   drivers/nvmem/sec-qfprom.c | 101 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 116 insertions(+)
>>   create mode 100644 drivers/nvmem/sec-qfprom.c
>>
>> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
>> index b291b27048c7..764fc5feb26c 100644
>> --- a/drivers/nvmem/Kconfig
>> +++ b/drivers/nvmem/Kconfig
>> @@ -216,6 +216,19 @@ config NVMEM_QCOM_QFPROM
>>         This driver can also be built as a module. If so, the module
>>         will be called nvmem_qfprom.
>>
>> +config NVMEM_QCOM_SEC_QFPROM
>> +        tristate "QCOM SECURE QFPROM Support"
>> +        depends on ARCH_QCOM || COMPILE_TEST
>> +        depends on HAS_IOMEM
>> +        depends on OF
>> +        select QCOM_SCM
>> +        help
>> +          Say y here to enable secure QFPROM support. The secure 
>> QFPROM provides access
>> +          functions for QFPROM data to rest of the drivers via nvmem 
>> interface.
>> +
>> +          This driver can also be built as a module. If so, the 
>> module will be called
>> +          nvmem_sec_qfprom.
>> +
>>   config NVMEM_RAVE_SP_EEPROM
>>       tristate "Rave SP EEPROM Support"
>>       depends on RAVE_SP_CORE
>> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
>> index f82431ec8aef..e248d3daadf3 100644
>> --- a/drivers/nvmem/Makefile
>> +++ b/drivers/nvmem/Makefile
>> @@ -44,6 +44,8 @@ obj-$(CONFIG_NVMEM_NINTENDO_OTP)    += 
>> nvmem-nintendo-otp.o
>>   nvmem-nintendo-otp-y            := nintendo-otp.o
>>   obj-$(CONFIG_NVMEM_QCOM_QFPROM)        += nvmem_qfprom.o
>>   nvmem_qfprom-y                := qfprom.o
>> +obj-$(CONFIG_NVMEM_QCOM_SEC_QFPROM)    += nvmem_sec_qfprom.o
>> +nvmem_sec_qfprom-y            := sec-qfprom.o
> 
> Are we just doing this for just renaming the object ?
> 
>>   obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)    += nvmem-rave-sp-eeprom.o
>>   nvmem-rave-sp-eeprom-y            := rave-sp-eeprom.o
>>   obj-$(CONFIG_NVMEM_RMEM)         += nvmem-rmem.o
>> diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
>> new file mode 100644
>> index 000000000000..bc68053b7d94
>> --- /dev/null
>> +++ b/drivers/nvmem/sec-qfprom.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/firmware/qcom/qcom_scm.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +/**
>> + * struct sec_qfprom - structure holding secure qfprom attributes
>> + *
>> + * @base: starting physical address for secure qfprom corrected 
>> address space.
>> + * @dev: qfprom device structure.
>> + */
>> +struct sec_qfprom {
>> +    phys_addr_t base;
>> +    struct device *dev;
>> +};
>> +
>> +static int sec_qfprom_reg_read(void *context, unsigned int reg, void 
>> *_val, size_t bytes)
>> +{
>> +    struct sec_qfprom *priv = context;
>> +    unsigned int i;
>> +    u8 *val = _val;
>> +    u32 read_val;
>> +    u8 *tmp;
>> +
>> +    for (i = 0; i < bytes; i++, reg++) {
>> +        if (i == 0 || reg % 4 == 0) {
>> +            if (qcom_scm_io_readl(priv->base + (reg & ~3), &read_val)) {
>> +                dev_err(priv->dev, "Couldn't access fuse register\n");
>> +                return -EINVAL;
>> +            }
>> +            tmp = (u8 *)&read_val;
>> +        }
>> +
>> +        val[i] = tmp[reg & 3];
>> +    }
> 
> Getting secure read from fuse region is fine here, since we have to read
> 4 byte from trustzone, but this restriction of reading is also there
> for sm8{4|5}50 soc's where byte by byte reading is protected and 
> granularity set to 4 byte (qfprom_reg_read() in drivers/nvmem/qfprom.c)
> is will result in abort, in  that case this function need to export this
> logic.
> 
>> +
>> +    return 0;
>> +}
>> +
>> +static int sec_qfprom_probe(struct platform_device *pdev)
>> +{
>> +    struct nvmem_config econfig = {
>> +        .name = "sec-qfprom",
>> +        .stride = 1,
>> +        .word_size = 1,
>> +        .id = NVMEM_DEVID_AUTO,
>> +        .reg_read = sec_qfprom_reg_read,
>> +    };
>> +    struct device *dev = &pdev->dev;
>> +    struct nvmem_device *nvmem;
>> +    struct sec_qfprom *priv;
>> +    struct resource *res;
>> +    int ret;
>> +
>> +    priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +    if (!priv)
>> +        return -ENOMEM;
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    if (!res)
>> +        return -EINVAL;
>> +
>> +    priv->base = res->start;
>> +
>> +    econfig.size = resource_size(res);
>> +    econfig.dev = dev;
>> +    econfig.priv = priv;
>> +
>> +    priv->dev = dev;
>> +
>> +    ret = devm_pm_runtime_enable(dev);
>> +    if (ret)
>> +        return ret;
>> +
>> +    nvmem = devm_nvmem_register(dev, &econfig);
>> +
>> +    return PTR_ERR_OR_ZERO(nvmem);
>> +}
>> +
>> +static const struct of_device_id sec_qfprom_of_match[] = {
>> +    { .compatible = "qcom,sec-qfprom" },
>> +    {/* sentinel */},
>> +};
>> +MODULE_DEVICE_TABLE(of, sec_qfprom_of_match);
>> +
>> +static struct platform_driver qfprom_driver = {
>> +    .probe = sec_qfprom_probe,
> 
> Why don't we have remove/remove_new callbacks?
> Same comment apply for drivers/nvmem/qfprom.c

Ignore this comment; Something new learnt with devm_* api
implementation.

-Mukesh
> 
>> +    .driver = {
>> +        .name = "qcom_sec_qfprom",
>> +        .of_match_table = sec_qfprom_of_match,
>> +    },
>> +};
>> +module_platform_driver(qfprom_driver);
>> +MODULE_DESCRIPTION("Qualcomm Secure QFPROM driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.40.1
>>
> 
> -Mukesh
