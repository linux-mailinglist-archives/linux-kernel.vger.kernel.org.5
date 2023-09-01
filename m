Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E184278FD68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346306AbjIAMjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjIAMjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:39:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E610CF;
        Fri,  1 Sep 2023 05:39:45 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3818aSZT004423;
        Fri, 1 Sep 2023 12:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k1kev0CaEjHSf9FHyvneqGylMQtr6Je4H0t2FJvzYfU=;
 b=GNdch/3uHQM6uiXAw8+vaaRBBLYHf3sULrBBBAzLSeD2M8Rbbn674g7dPsvA5LOa4Ipx
 PCoParouCC9aFyPRqok85xEOJHw4xdrH90nKQL3kZi7Xl+PWb2YUPGlyzSQsuuMV15CN
 nR/NMt6RFpAQ0z1cWj3NMh+QOysr+Y1UENDY0X3QD+MqIRig3UZ5kRrjceXBoYP+Gbl3
 E/3yYX97ydRhXcIQQ7fO4rI6XBL38yqR9MFylrBC2JmtL2VsRAyb08GJgKaW8UZMr4G7
 DAMS2oqlU1OUWvLyJVDxFaeFpenp6FdJiRZcugMwmGHYoduqKRPL42YNq0SlurXpQbqo cg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3str1nkexu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 12:39:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381CdalX029982
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 12:39:36 GMT
Received: from [10.201.203.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 1 Sep
 2023 05:39:32 -0700
Message-ID: <7a2612ae-7ab0-5aaf-c903-d2d58f89f5ea@quicinc.com>
Date:   Fri, 1 Sep 2023 18:09:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] arm64: dts: ipq5018: Correct uart1_pins pinconf
Content-Language: en-US
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Ziyang Huang <hzyitc@outlook.com>, <agross@kernel.org>
CC:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <quic_gokulsri@quicinc.com>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <TYZPR01MB5556F902BF64AF857C3ABD44C9E5A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <49fbae87-ce09-23af-6bcd-459b5646e680@nexus-software.ie>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <49fbae87-ce09-23af-6bcd-459b5646e680@nexus-software.ie>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u1IIqYurAniy2UKzdph7GcVPAVzqhdxF
X-Proofpoint-ORIG-GUID: u1IIqYurAniy2UKzdph7GcVPAVzqhdxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=982 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010118
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ziyang,

<...>

>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 9f13d2dcdfd5..91b98020e1c6 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -104,10 +104,10 @@ tlmm: pinctrl@1000000 {
>>               #interrupt-cells = <2>;
>>               uart1_pins: uart1-state {
>> -                pins = "gpio31", "gpio32", "gpio33", "gpio34";
>> -                function = "blsp1_uart1";
>> +                pins = "gpio28", "gpio29";
>> +                function = "blsp0_uart1";
>>                   drive-strength = <8>;
>> -                bias-pull-down;
>> +                bias-disabled;
>>               };
>>           };
> 
> So this change will have the effect of changing the console on 
> ipq5018-rdp432 from gpio31-gpio34 to gpio28, gpio29.
> 
> Have you verified that change on hardware or the schematic ?
> 
> https://forum.openwrt.org/t/add-support-for-xiaomi-redmi-ax5400-white-version/140879/22?page=2 
> 
> 
> This has the wrong UART pinout ?
> 
> Is this change something that should be expressed for a particular board ?

  Infact again checked it, the correct pins are "gpio20", "gpio21".
  It works so far because u-boot has configured it.

Regards,
  Sricharan
