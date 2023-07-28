Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50C576671D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjG1I2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjG1I0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:26:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548723C29;
        Fri, 28 Jul 2023 01:26:21 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S5uwmT030949;
        Fri, 28 Jul 2023 08:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nIhIpM+nZlYrVmhcjX6AZNM3fVpwRFqZHOP+wRj7lH0=;
 b=WMM5u4lot6b48e2dAOv0zj08J6H6mVWwG9/bYUzOCzpZP2+iz04huo0XkRy/kLCOBBVH
 0zXCkIXJg71PTlKE+Oip1CjXNXdVrY0GC6En36FEGInZfvLVcwC9bOoQ7bpqg6t2A9sU
 uBTUWYmuzMzzhr/jcdDREKXnAalBSLJgHr5ILrN6yml31quYv9Z+GMhmscH1cM7b+SSy
 0gp2BKGErGUER9WeQZOvHs1+y52Gy3AKalLQJ4vYrKoM5bhopRM4+FBL8wIPdrk1JouO
 jOft/XTsEFuMiK8uvxMrzWuWmq4aiNX3UWL67I9CrYkcQ7mMeNw0Gp4E0fxEynv+ZJKK MA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3k7u2y7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 08:26:17 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S8Q51V015623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 08:26:05 GMT
Received: from [10.216.15.230] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 01:26:00 -0700
Message-ID: <f38f3a60-28c1-7566-3772-21edb70d4c9c@quicinc.com>
Date:   Fri, 28 Jul 2023 13:55:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-3-quic_kbajaj@quicinc.com>
 <f6fab6b7-0cfb-6aa5-2043-6c789709d04a@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <f6fab6b7-0cfb-6aa5-2043-6c789709d04a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y0Y4DRVlxpxbObHMycyFLqwQl1XWOOsC
X-Proofpoint-ORIG-GUID: Y0Y4DRVlxpxbObHMycyFLqwQl1XWOOsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280076
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2023 4:14 PM, Srinivas Kandagatla wrote:
> 
> 
> On 24/07/2023 09:38, Komal Bajaj wrote:
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
> 
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
> 
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
> 
> Any reason why we need to enable pm runtime for this driver? As Am not 
> seeing any pm runtime handlers or users in this driver.

Thanks..
Yes, it is not needed as of now..
looks like, it got inherited from qfprom.c by mistake.

Same need to be corrected in Device tree, if any
unnecessary reference is there related to this..

-Mukesh
> 
> 
> --srini
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
