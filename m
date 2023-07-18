Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4B47577A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjGRJRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjGRJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:16:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423DD1989;
        Tue, 18 Jul 2023 02:16:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I7tBVO006337;
        Tue, 18 Jul 2023 09:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6UY3mA8JU1z+rMDnfpEi65NaBIbbqhF+wr23GQYgRvE=;
 b=F37Aa/yDIb56ETzuILLhkrVUHUsMiuBb1Wj0ZS5ReBW0dka2sLZkQ/gxcjE93C3yIxQt
 tr6qBOcN3KeQ0VhsmbRoyoGM9pEFeKcTibTWn3YCD/uW+66if67w2COLiT333hdaIppS
 +VMefakEApzx2EY9PiSV1A3iCeLP/lcEJcFgQm/R55cB6+tG5FYYP4spUf8MaCXqLKGs
 M6Z/DD8r/hQdwj0jeToBXEf2acJTmvyLGwx/czJKXxUFMt8eQRE5NfvIJJ6EU5/dC8/c
 QzYCQXKM1Chu2GCwGNFJKGD8Hy3PoISsb5o57ICHt1IcuMd+Wna5fPMipOL8mH2uLYn4 hQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwps585mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 09:13:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I9CxEL021663
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 09:12:59 GMT
Received: from [10.216.57.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 02:12:51 -0700
Message-ID: <e32b7dff-8735-e5a2-a782-e5fd6ca79934@quicinc.com>
Date:   Tue, 18 Jul 2023 14:42:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-5-quic_devipriy@quicinc.com>
 <fa2fae05-7ff3-ec6b-45a9-b256b9d5d92c@linaro.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <fa2fae05-7ff3-ec6b-45a9-b256b9d5d92c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YMfWCmMZUbJdsLl2ySMjhQPQxQ1VjxRI
X-Proofpoint-ORIG-GUID: YMfWCmMZUbJdsLl2ySMjhQPQxQ1VjxRI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=896 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180083
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2023 3:26 PM, Krzysztof Kozlowski wrote:
> On 11/07/2023 11:35, Devi Priya wrote:
>> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 based
>> devices.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig         |    6 +
>>   drivers/clk/qcom/Makefile        |    1 +
>>   drivers/clk/qcom/nsscc-ipq9574.c | 3080 ++++++++++++++++++++++++++++++
>>   3 files changed, 3087 insertions(+)
>>   create mode 100644 drivers/clk/qcom/nsscc-ipq9574.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 263e55d75e3f..5556063d204f 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -195,6 +195,12 @@ config IPQ_GCC_9574
>>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>>   	  of ipq9574.
>>   
>> +config IPQ_NSSCC_9574
>> +	tristate "IPQ9574 NSS Clock Controller"
> 
> I think you do not run arm32 there, so missing depends on ARM64 ||
> COMPILE_TEST

Okay, will update this in V2

Thanks,
Devi Priya
> 
>> +	depends on IPQ_GCC_9574
>> +	help
>> +	  Support for NSS clock controller on ipq9574 devices.
>> +
> 
> 
> Best regards,
> Krzysztof
> 
