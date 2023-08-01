Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED41476A8BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjHAGMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHAGMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:12:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3410C1;
        Mon, 31 Jul 2023 23:12:01 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3715V9bB016641;
        Tue, 1 Aug 2023 06:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6dNMOPwz0tV094irT4sD0V4XMKMRN8Qjuh3wYCdhz5o=;
 b=UYnkSd1U5r3FkGnr6QqXlNSVHQjvN9cCkVndkosJi60JNnYceUAIgzkFCoo92IWR89IC
 AS4t8tRRYN5hWlL7GNRT+M8GpbcOnw7g8jsPc+gKVyR8L5lvOdwaemcDrsWFWl+TJZl2
 hbxpi/dk7xHVmOwT8z2Au6rtUU0vhnu0I6c9ArQO9h/ugjKnQi0mH0PpWS/UjLy/LnGk
 YIlgI9YExjVjSzkjVb+nPhkX70XgHBcV1n4eUcLw/6OwX3VTL/XPtNeDoq/v2p8LUBZL
 UQHnvet9N+2GkglGC2WtB8Z/v4RyF/XVNvw9r++BzHXk7RkLr4q6n+vBkpPySMtgc65Y Ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d8gt7qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 06:11:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3716Boqf014425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 06:11:50 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 23:11:46 -0700
Message-ID: <195c7961-92cc-b41d-52ba-383b10dd9c75@quicinc.com>
Date:   Tue, 1 Aug 2023 11:41:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 2/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-3-quic_kbajaj@quicinc.com>
 <f6fab6b7-0cfb-6aa5-2043-6c789709d04a@linaro.org>
 <f38f3a60-28c1-7566-3772-21edb70d4c9c@quicinc.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <f38f3a60-28c1-7566-3772-21edb70d4c9c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Beql-8vAudona1Y582V54cqAmLaH91hU
X-Proofpoint-GUID: Beql-8vAudona1Y582V54cqAmLaH91hU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010056
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 1:55 PM, Mukesh Ojha wrote:
>
>
> On 7/27/2023 4:14 PM, Srinivas Kandagatla wrote:
>>
>>
>> On 24/07/2023 09:38, Komal Bajaj wrote:
>>> For some of the Qualcomm SoC's, it is possible that
>>> some of the fuse regions or entire qfprom region is
>>> protected from non-secure access. In such situations,
>>> Linux will have to use secure calls to read the region.
>>> With that motivation, add secure qfprom driver.
>>>
>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>> ---
>>>   drivers/nvmem/Kconfig      |  13 +++++
>>>   drivers/nvmem/Makefile     |   2 +
>>>   drivers/nvmem/sec-qfprom.c | 101 
>>> +++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 116 insertions(+)
>>>   create mode 100644 drivers/nvmem/sec-qfprom.c
>>>
>>
>>> diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
>>> new file mode 100644
>>> index 000000000000..bc68053b7d94
>>> --- /dev/null
>>> +++ b/drivers/nvmem/sec-qfprom.c
>>> @@ -0,0 +1,101 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>>> reserved.
>>> + */
>>> +
>>> +#include <linux/firmware/qcom/qcom_scm.h>
>>> +#include <linux/mod_devicetable.h>
>>> +#include <linux/nvmem-provider.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_runtime.h>
>>
>>> +
>>> +static int sec_qfprom_probe(struct platform_device *pdev)
>>> +{
>>> +    struct nvmem_config econfig = {
>>> +        .name = "sec-qfprom",
>>> +        .stride = 1,
>>> +        .word_size = 1,
>>> +        .id = NVMEM_DEVID_AUTO,
>>> +        .reg_read = sec_qfprom_reg_read,
>>> +    };
>>> +    struct device *dev = &pdev->dev;
>>> +    struct nvmem_device *nvmem;
>>> +    struct sec_qfprom *priv;
>>> +    struct resource *res;
>>> +    int ret;
>>> +
>>> +    priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +    if (!priv)
>>> +        return -ENOMEM;
>>> +
>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +    if (!res)
>>> +        return -EINVAL;
>>> +
>>> +    priv->base = res->start;
>>> +
>>> +    econfig.size = resource_size(res);
>>> +    econfig.dev = dev;
>>> +    econfig.priv = priv;
>>> +
>>> +    priv->dev = dev;
>>> +
>>> +    ret = devm_pm_runtime_enable(dev);
>>> +    if (ret)
>>> +        return ret;
>>
>> Any reason why we need to enable pm runtime for this driver? As Am 
>> not seeing any pm runtime handlers or users in this driver.
>
> Thanks..
> Yes, it is not needed as of now..
> looks like, it got inherited from qfprom.c by mistake.
>
> Same need to be corrected in Device tree, if any
> unnecessary reference is there related to this..

Thanks for pointing it out.
Will drop it in the next patch series.

Thanks
Komal

>
> -Mukesh
>>
>>
>> --srini
>>> +
>>> +    nvmem = devm_nvmem_register(dev, &econfig);
>>> +
>>> +    return PTR_ERR_OR_ZERO(nvmem);
>>> +}
>>> +
>>> +static const struct of_device_id sec_qfprom_of_match[] = {
>>> +    { .compatible = "qcom,sec-qfprom" },
>>> +    {/* sentinel */},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, sec_qfprom_of_match);
>>> +
>>> +static struct platform_driver qfprom_driver = {
>>> +    .probe = sec_qfprom_probe,
>>> +    .driver = {
>>> +        .name = "qcom_sec_qfprom",
>>> +        .of_match_table = sec_qfprom_of_match,
>>> +    },
>>> +};
>>> +module_platform_driver(qfprom_driver);
>>> +MODULE_DESCRIPTION("Qualcomm Secure QFPROM driver");
>>> +MODULE_LICENSE("GPL");
>>> -- 
>>> 2.40.1
>>>

