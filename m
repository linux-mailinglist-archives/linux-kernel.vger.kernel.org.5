Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEA879FD86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjINHxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjINHxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:53:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36101BF6;
        Thu, 14 Sep 2023 00:52:58 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E6JbYW025804;
        Thu, 14 Sep 2023 07:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Yp6S/Y75kMgrlTIQpeC4sOoOh9eolwxJHQpMwOxlpbI=;
 b=oZSdr2zTvvWJD5oji3f+6XT2WeqtoFnLLRud27HFt4QRqBUFfu9qpAkVMi/L+iwzfDdF
 KckGaYYKqlzt5l28HB0io8w5/C50PcjieKXe4fK0PAYu5byE+aVzk5JuLvni0upjd6HS
 BqQa43v7ZB6l2Rz6bRkMWQNUvz8VozmCygmqXiYiVfDa77aCDWJIZarBhtb/vnrg4Pb7
 Huf5/hLs7kpiT7joDix5Q4h/DmDeLKijrQTHMviQ78Of30xTROOAfg1Spt7AnL2Rkuxg
 vvplOcQQ3TDhI7VSNvN0iKZYnM+BYup2Css5zUFjm0HZHHrKC8cvdNMNVaR4BCQnhMKF 8g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3qqa8wpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:52:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E7qhWF008178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:52:43 GMT
Received: from [10.253.32.174] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 14 Sep
 2023 00:52:39 -0700
Message-ID: <1a1922ec-a8ae-4a42-d8a9-921450592213@quicinc.com>
Date:   Thu, 14 Sep 2023 15:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 4/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230914054639.13075-1-quic_luoj@quicinc.com>
 <20230914054639.13075-5-quic_luoj@quicinc.com>
 <357805c5-bedb-8972-bcf1-fabaaaf90ad9@linaro.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <357805c5-bedb-8972-bcf1-fabaaaf90ad9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8o6Trep0c22O8tZ9bjLSKwO9LYIYkC5i
X-Proofpoint-GUID: 8o6Trep0c22O8tZ9bjLSKwO9LYIYkC5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_05,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=789 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2023 2:15 PM, Krzysztof Kozlowski wrote:
> On 14/09/2023 07:46, Luo Jie wrote:
>> The clock controller driver of qca8386/qca8084 is registered
>> as the MDIO device, the hardware register is accessed by MDIO bus
>> that is normally used to access general PHY device, which is
>> different from the current existed qcom clock controller drivers
>> using ioremap to access hardware clock registers.
>>
>> MDIO bus is common utilized by both qca8386/qca8084 and other
>> PHY devices, so the mutex lock mdio_bus->mdio_lock should be
>> used instead of using the mutex lock of remap.
>>
>> To access the hardware clock registers of qca8386/qca8084, there
>> is special MDIO frame sequence(three MDIO read/write operations)
>> need to be sent to device.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig       |    9 +
>>   drivers/clk/qcom/Makefile      |    1 +
>>   drivers/clk/qcom/nsscc-qca8k.c | 2178 ++++++++++++++++++++++++++++++++
>>   3 files changed, 2188 insertions(+)
>>   create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 865db5202e4c..c95ada6a1385 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -203,6 +203,15 @@ config IPQ_GCC_9574
>>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>>   	  of ipq9574.
>>   
>> +config IPQ_NSSCC_QCA8K
>> +	tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
>> +	depends on MDIO_BUS || COMPILE_TEST
> 
> This is SoC is for both ARM and ARM64 worlds?
> 
Thanks Krzysztof for the comments.
This chip is independent of the ARCH, which just depends on the MDIO 
bus, both mips and arm are supported.

>> +	help
>> +	  Support for NSS(Network SubSystem) clock controller on
>> +	  qca8386/qca8084 chip.
>> +	  Say Y or M if you want to use network features of switch or
>> +	  PHY device. Select this for the root clock of qca8k.
>> +
> 
> 
> Best regards,
> Krzysztof
> 
