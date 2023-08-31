Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1555A78E62A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245210AbjHaGLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjHaGLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:11:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1CFE0;
        Wed, 30 Aug 2023 23:10:59 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V5WmGl030948;
        Thu, 31 Aug 2023 06:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fXMYq1GgugiApxviuhU/l2UCt3A4SW3Pp7aUIiZqVoo=;
 b=IZ6Y/x54NEd7YQytE+Ec/y/EHTYB8HO1HeTFWwQOaeImz1YQ8OaZlH3quOqUyU22kjer
 K4s+NLm+JgP/EIG/JVSiLoB7qJTNEb0qWCH/4q52aceuD0VNaaPkF4eWRE0wXeudAKEn
 75HcHaL3+lwR7HyVLZRroZIHs8yTEb3UIp2J7HRC1ZyMuBIjXiUOzkyJF66+5sRmB3uG
 JgnLjtx1GV4JhXhYq/3ZjywtL7pTW2Dfo4dS8g4SQl2cfU8CHK+Ib1TYq8r02sx+9zKW
 YK7Ogdoal5Jhf/NuQOtNtkCwl0qbgkX+mr3tMYkm7RWT4vx3uUFhmXd3C2/CCzdJTrcs VA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st6ct9pjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 06:10:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37V6Anxj010632
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 06:10:49 GMT
Received: from [10.201.192.51] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 23:10:44 -0700
Message-ID: <1aad08e5-d3a4-e3cf-3535-deb54ecf0169@quicinc.com>
Date:   Thu, 31 Aug 2023 11:40:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
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
 <f7a350a9-5580-c3b9-a917-69a9b16dbf41@quicinc.com>
 <CAA8EJpoE=oF86piKCnt-7-Nw8xa9nYg-TqSOaP1V-vb=Oxwwng@mail.gmail.com>
From:   Gokul Sriram P <quic_gokulsri@quicinc.com>
In-Reply-To: <CAA8EJpoE=oF86piKCnt-7-Nw8xa9nYg-TqSOaP1V-vb=Oxwwng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oVU8rjJsxSQBKBNtdRnQeXJJetB8JRWp
X-Proofpoint-ORIG-GUID: oVU8rjJsxSQBKBNtdRnQeXJJetB8JRWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_04,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=791
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310055
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/2023 1:12 AM, Dmitry Baryshkov wrote:
> On Wed, 30 Aug 2023 at 21:32, Gokul Sriram P <quic_gokulsri@quicinc.com> wrote:
>>
>>>>>>>     #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>>>>     #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>>>>>>>     #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>>>>>>> +#include <dt-bindings/clock/qcom,apss-ipq.h>
>>>>>> c is before r.
>>    Sure, will update.
>>
>> [...]
>>>>>>> +   cpu_opp_table: opp-table-cpu {
>>>>>>> +           compatible = "operating-points-v2";
>>>>>>> +           opp-shared;
>>>>>>> +
>>>>>>> +           opp-1008000000 {
>>>>>>> +                   opp-hz = /bits/ 64 <1008000000>;
>>>>>>> +                   opp-microvolt = <1100000>;
>>>>>>> +                   clock-latency-ns = <200000>;
>>>>>> And the rest of OPPs?
>>>>> Hi Krzysztof,
>>>>> IPQ5018 only supports running at 1.1GHz, but its running at 800MHz
>>>>> by default from the bootloader so there is only one OPP.
>>>> Isn't this contradictory? If it is running at 800 initially, then it
>>>> supports running at 800...
>>> I can only guess that it's not validated at 800MHz.
>> As per the h/w design team, there is negligible power or thermal benefit
>> by lowering to 800MHz clock.
>> Hence, 800MHz opp wasn't included here.
> Just my 2c. If 800 MHz is supported, it should be included. Even if
> just to prevent the kernel from throwing a warning about the CPU
> running at the unsupported frequency. Then one can use scheduler
> tunings to prevent the CPU from going to 800 MHz state.

sure, understood. Will add opp at 800MHz. Thanks.

Regards,
Gokul

