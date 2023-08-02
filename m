Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7158D76CB0C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjHBKin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjHBKiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:38:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D603586;
        Wed,  2 Aug 2023 03:34:24 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3722enkV012009;
        Wed, 2 Aug 2023 10:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BM3JTqUNkB3VLeEzuItMkXqV/Mnd5xo5sZOy+2pubXM=;
 b=mBDkhqwvTvvY5nCBV4w2bxt+cx+gPTcb9fAshFiiH3uePpx0RYNmyO07eTM7vM1KHirA
 4Q3IhcBjjQwsGmvsI1VQeZWnuC0QbUKi9QXKDqxwCI6FE5N7sq/BcKpdRGc9pTbDsM/z
 5OFZD+W883/YAcRuFvzHiWqNg6D/SC5ehj47rn1NYwLDDyvCIQG1IYAWhh5u/UX6bLrw
 4hKNSQ2JFY3C4Yr3CUz6on79xlxeT7jciHcBsorOtUfspv3hOZLJTBvc0Ln33m8UdSbN
 c5UgTqQsuv2NAynEV9yWz/Pmj90N6UG64abxiH3yFVxUIGY+xAofG/t47WiFFdvr3PAF Tg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7bw9hb7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 10:34:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372AYA3Z026237
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 10:34:10 GMT
Received: from [10.253.73.93] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 03:34:06 -0700
Message-ID: <8556fd68-edb1-5b97-6472-ae854f86190b@quicinc.com>
Date:   Wed, 2 Aug 2023 18:34:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
 <20230801085352.22873-4-quic_luoj@quicinc.com>
 <188bcc4c-7388-ca39-5c3c-629edd78cc9f@infradead.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <188bcc4c-7388-ca39-5c3c-629edd78cc9f@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Gg_GPSMSY9OuPWZJVsF9LIhjtd0JUmU7
X-Proofpoint-GUID: Gg_GPSMSY9OuPWZJVsF9LIhjtd0JUmU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=949 phishscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020093
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 3:16 AM, Randy Dunlap wrote:
> 
> 
> On 8/1/23 01:53, Luo Jie wrote:
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 263e55d75e3f..a17e8fa5a7e1 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -195,6 +195,14 @@ config IPQ_GCC_9574
>>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>>   	  of ipq9574.
>>   
>> +config IPQ_NSSCC_QCA8K
>> +        tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
>> +        help
> 
> The 2 lines above should be indented with one tab (only; no spaces).
> 
>> +          Support for NSS(Network SubSystem) clock controller on
> 
> The line above should be indented with one tab + 2 spaces (like the following
> 3 lines).
> 
>> +	  qca8386/qca8084 chip.
>> +	  Say Y if you want to use network function of switch or PHY
>> +	  function. Select this for the root clock of qca8xxx.
> 
thanks Randy for the review, i will update the patch for this.
