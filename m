Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8775ACE1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjGTLUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGTLUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:20:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E8BB;
        Thu, 20 Jul 2023 04:20:43 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KAv7pD027441;
        Thu, 20 Jul 2023 11:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aRvHBjPf5Cd9kq73msKsZrYSowVGtw/H+W4XHYOpMHU=;
 b=U52BUTK0U/j/EYiKLwwZfwyIbAGWrRv81TmE4tFp/pNoqAeaugaV9nR4rslPH33TTWjF
 NBOzqaSmgKdb1JPH4ATjEtRNk5rmEZ7GBFAPgfjHdkW67OVObUVANPr71vtJb/aHOMWn
 nIS3TRkX3wPhE8/cb0F8oikWGSGcx4a3yU2MpWaQWn10+J88iKq+vPiJ9GsCMw53S+3y
 90rMba8WXZW/2e5weWtVx1rZIwVu/WocaKTGN8g2p9w4m60se46oyu3wG92oTaVnJD/J
 1MUiAO08LsZSs4DSe+2AQz29G/DnkKjiRrjjMEBNz0ShcyWwIbdH3vu598Xs4fbcAOX4 qQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxup4gxpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:20:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36KBKcOj026299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:20:39 GMT
Received: from [10.201.197.30] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 04:20:33 -0700
Message-ID: <15275174-4903-afd2-df7f-bc3d73a06d00@quicinc.com>
Date:   Thu, 20 Jul 2023 16:50:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5018: add support for the RDP415
 variant
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230720074846.20350-1-quic_harihk@quicinc.com>
 <20230720074846.20350-3-quic_harihk@quicinc.com>
 <af890343-824c-7b68-ba27-dbaa4fa5b863@linaro.org>
From:   Hariharan K <quic_harihk@quicinc.com>
In-Reply-To: <af890343-824c-7b68-ba27-dbaa4fa5b863@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QBjaUy1ZI2vlzW6ioBmVL0Qy7GyFCETm
X-Proofpoint-ORIG-GUID: QBjaUy1ZI2vlzW6ioBmVL0Qy7GyFCETm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 mlxlogscore=777 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200095
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 2:26 PM, Krzysztof Kozlowski wrote:
> On 20/07/2023 09:48, Hariharan K wrote:
>> Add the initial device tree support for the Reference Design
>> Platform(RDP) 415 based on IPQ5018 family of SoC. This patch
>> carries the support for Console UART and eMMC.
>>
>> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile           |  1 +
>>   arch/arm64/boot/dts/qcom/ipq5018-rdp415.dts | 49 +++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp415.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 6334e552b7c1..53df7f24488a 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp415.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp415.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp415.dts
>> new file mode 100644
>> index 000000000000..5c4b43f76a48
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp415.dts
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>> +/*
>> + * IPQ5018 MP03.3-C2 board device tree source
>> + * Copyright (c) 2023, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq5018-rdp-common.dtsi"
> 
> I don't understand this. You just added in in the same moment in
> different patchset, so why creating this fake dependency?
> 
> It makes review difficult, applying even more.
> 
> Please organize your patches in some logical work.

Sure, got it. Will rework this series and post v2.

Best regards,
Hariharan K

> 
> Best regards,
> Krzysztof
> 
