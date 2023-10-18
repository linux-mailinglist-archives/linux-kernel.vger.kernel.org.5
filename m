Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873F87CD9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjJRK63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjJRK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:58:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D8AB0;
        Wed, 18 Oct 2023 03:58:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I8AGg2019114;
        Wed, 18 Oct 2023 10:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4vkQKvJML8wn2+HrI9TYl1IsbWBqKkY1/P/UoPqJVfg=;
 b=OrbLMqn8vTBKwwVe9AX6LzJNauX/sNt0mmDZZQiI3HmZVWdgwELSIOjBhE4iiDYjEooZ
 hDJfhMWGbZW97DKzoPIOnB4ULXvY6fQ4tUWeROPrpfZKnnxFdREL9KwMg9ljJbXimfYC
 K0CMSEPfzRRfxSAHhHPajsnI1FAP3jvyZAnx1wSBVJ8Psi8W3oabaJkQIApBTRc+q6Gm
 wHblQHq0GQaZ0JRl7GzUZv2vCJfq0TaNIEkEIq/m2lf49qSXH8MvxX3v+q+nDBwQzTeF
 XfJobKMQ3MffqclogUDAfVwG6GVQ9WUM8R9j5UhcXogCIPuQ+SkKi0U6EhHqxb5nyy4+ /A== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt9kjrk9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 10:57:56 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IAvsjE003972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 10:57:54 GMT
Received: from [10.216.39.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 03:57:49 -0700
Message-ID: <97067546-784c-bb42-fe1c-14348b70e65f@quicinc.com>
Date:   Wed, 18 Oct 2023 16:27:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V2 3/4] clk: qcom: Add ECPRICC driver support for QDU1000
 and QRU1000
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
 <20231011090028.1706653-4-quic_imrashai@quicinc.com>
 <c656a6b8ac2feefda16e6d1d548a9f80.sboyd@kernel.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <c656a6b8ac2feefda16e6d1d548a9f80.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gEnBrIkB-tinfmWw9eSpK4V1vzp9JFgi
X-Proofpoint-GUID: gEnBrIkB-tinfmWw9eSpK4V1vzp9JFgi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_09,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=665 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180090
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2023 1:49 AM, Stephen Boyd wrote:
> Quoting Imran Shaik (2023-10-11 02:00:27)
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 3194c8beb06d..60a981ff2bac 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -667,6 +667,14 @@ config QDU_GCC_1000
>>            QRU1000 devices. Say Y if you want to use peripheral
>>            devices such as UART, SPI, I2C, USB, SD, PCIe, etc.
>>   
>> +config QDU_ECPRICC_1000
>> +       tristate "QDU1000/QRU1000 ECPRI Clock Controller"
> 
> This needs a 'depends on ARM64 || COMPILE_TEST' type of line here.
> 

Sure, will add this in the next series.

>> +       select QDU_GCC_1000
>> +       help
>> +         Support for the ECPRI clock controller on QDU1000 and
>> +         QRU1000 devices. Say Y if you want to support the ECPRI
>> +         clock controller functionality such as Ethernet.
>> +
>>   config SDM_GCC_845
>>          tristate "SDM845/SDM670 Global Clock Controller"
>>          depends on ARM64 || COMPILE_TEST
>> diff --git a/drivers/clk/qcom/ecpricc-qdu1000.c b/drivers/clk/qcom/ecpricc-qdu1000.c
>> new file mode 100644
>> index 000000000000..e26912f3dd39
>> --- /dev/null
>> +++ b/drivers/clk/qcom/ecpricc-qdu1000.c
>> @@ -0,0 +1,2466 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
> 
> What is the of.h include for? Did you mean mod_devicetable.h instead of
> of_device_id?
> 

Yes, will remove of.h and use mod_devicetable.h in the next series.

Thanks,
Imran

>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
