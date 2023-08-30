Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1717678DABE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjH3ShC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241269AbjH3GtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:49:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5726194;
        Tue, 29 Aug 2023 23:49:11 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U6J9JY022057;
        Wed, 30 Aug 2023 06:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sjcB/zP1GlW4bSweX/jHCt6rr1IvV2ny/ysyC9tku/Y=;
 b=Hj4LmG3IHQn5Z+skrvp+R5RL0aaaPo7xxmRhPL2zXkxeYWdT+tPW8j5MXHqa3ho48R1R
 xMQM6c3YYB89vmykQep119hi7ccZ6fk9oyzR6V+Q61phyt0smHqHoUe+8+17csswOq5g
 I7ZRozgCvY+R5gkZTit0R4frjD+7ija6m2NT6ZujARl/YOEtybgUQiQmwLlmsdY09ATm
 gPPTvAxwO3GR19d79ksaXq5NGUxYJnqlImZxq4CfJo0CKLMRK9G84wtKfgdrWLbA2g+A
 WgMg30m2Uu6rcKinSROmsYxKiLfBAdeH67FDvvRS0hOrjn5M+tfH3YVri8Y5vtIdcTBb bQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssy5q036v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:49:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U6n5dV005748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:49:05 GMT
Received: from [10.201.2.48] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 23:49:00 -0700
Message-ID: <f7a350a9-5580-c3b9-a917-69a9b16dbf41@quicinc.com>
Date:   Wed, 30 Aug 2023 12:18:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
 <20230829095423.760641-4-quic_gokulsri@quicinc.com>
 <f457ee94-81d0-bd28-1432-ba2828dabb79@linaro.org>
 <efe09cb6-7b67-9307-28e7-99e238a3672b@gmail.com>
 <0941e2f4-6b58-a4e7-3dda-c1723f5503ac@linaro.org>
 <CAOX2RU4j57H51ceYdKk9K-2ZNO7N4MDA6BOKrP2N3DNbphQAow@mail.gmail.com>
From:   Gokul Sriram P <quic_gokulsri@quicinc.com>
In-Reply-To: <CAOX2RU4j57H51ceYdKk9K-2ZNO7N4MDA6BOKrP2N3DNbphQAow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7b3YUJ90RD9dh2J_8E-_Nb9OYsHfkzr7
X-Proofpoint-GUID: 7b3YUJ90RD9dh2J_8E-_Nb9OYsHfkzr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxlogscore=726 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300062
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>>    #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>>>>>    #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>>>>> +#include <dt-bindings/clock/qcom,apss-ipq.h>
>>>> c is before r.
  Sure, will update.

[...]
>>>>
>>>>> +   cpu_opp_table: opp-table-cpu {
>>>>> +           compatible = "operating-points-v2";
>>>>> +           opp-shared;
>>>>> +
>>>>> +           opp-1008000000 {
>>>>> +                   opp-hz = /bits/ 64 <1008000000>;
>>>>> +                   opp-microvolt = <1100000>;
>>>>> +                   clock-latency-ns = <200000>;
>>>> And the rest of OPPs?
>>> Hi Krzysztof,
>>> IPQ5018 only supports running at 1.1GHz, but its running at 800MHz
>>> by default from the bootloader so there is only one OPP.
>> Isn't this contradictory? If it is running at 800 initially, then it
>> supports running at 800...
> I can only guess that it's not validated at 800MHz.
As per the h/w design team, there is negligible power or thermal benefit 
by lowering to 800MHz clock.
Hence, 800MHz opp wasn't included here.
>
> Regards,
> Robert
>>
>> Best regards,
>> Krzysztof
>>
