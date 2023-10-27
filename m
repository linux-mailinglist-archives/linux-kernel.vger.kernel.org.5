Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9817D9095
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjJ0ID2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjJ0IDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:03:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DEA10E0;
        Fri, 27 Oct 2023 01:03:13 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5unHG001377;
        Fri, 27 Oct 2023 08:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QYe+vUUvmlRQVC9mRy1pQ1SesCPINZqupQyO3h+FoSc=;
 b=d6AOnXAhdV1qH03WCrcLYdHxv/17K0BVucyJt7Odx1ScdI94xwMceWiyr/OlnjVE7mbG
 yJGulWBcLGVTrr6QSezjnz1D1J8mk3RDxBnOllaOETpQ7h6trCYnayBNRP0BCv43qKzV
 rj4917oWd0jJ0rEWO0LmQSi0elR1aLYfd5X67zCS02PX6hO/Ham8JdvkOayJTtUn+bNG
 rpHxcaWBGS8Uumi7VQPSlHuYpyEumfcgeOitWQMCWtJgCyUWPg2Y3kHAT+2RgtEF9ths
 Jhd16DiiTdudahST86bdcgQTWnlWk4XwG533+EA2oA6YundLAXqX550mGtQLSiKlexry vQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyww71gde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 08:03:04 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39R833DX024079
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 08:03:03 GMT
Received: from [10.201.192.51] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 27 Oct
 2023 01:02:58 -0700
Message-ID: <544f270e-ad62-6b15-13e6-72ca32d46d31@quicinc.com>
Date:   Fri, 27 Oct 2023 13:32:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 0/3] Add APSS clock driver support for IPQ5018
To:     <dmitry.baryshkov@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <jassisinghbrar@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
References: <20230925102826.405446-1-quic_gokulsri@quicinc.com>
Content-Language: en-US
From:   Gokul Sriram P <quic_gokulsri@quicinc.com>
In-Reply-To: <20230925102826.405446-1-quic_gokulsri@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8HJ8AId7wDL6RMwi4tCqHenK_0bsnGWV
X-Proofpoint-GUID: 8HJ8AId7wDL6RMwi4tCqHenK_0bsnGWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_06,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=830 priorityscore=1501
 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270069
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone, a gentle remainder to review and acknowledge the change.

Regards,
Gokul

On 9/25/2023 3:58 PM, Gokul Sriram Palanisamy wrote:
> This series adds support for the APSS clock to bump the CPU frequency
> above 800MHz. APSS PLL found in the IPQ5018 is of type Stromer.
>
> - The first patch in the series adds the required a53pll compatible.
>
> - The second patch reuses Stormer Plus PLL offsets, adds configuration values
>    for Stromer.
>
> - The third patch adds dts nodes to enable the pll along with the cpu
>    operating frequency table.
>
> This series depends on below series
> https://patchwork.kernel.org/project/linux-arm-msm/cover/20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com/
>
> Changes in v3:
> - Addressed review comment by Dmitry in patch 3.
>
> Changes in v2:
> - Addressed review comments
> - Adds dependency on above mentioned patch series for dropping
>    CLK_SET_RATE_PARENT flag from GPLL clocks, GPLL0 clock provider for
>    mailbox
> - Add CPU operating point at 800MHz based on the review comments.
>
> Gokul Sriram Palanisamy (3):
>    dt-bindings: clock: qcom,a53pll: add IPQ5018 compatible
>    clk: qcom: apss-ipq-pll: add support for IPQ5018
>    arm64: dts: qcom: ipq5018: enable the CPUFreq support
>
>   .../bindings/clock/qcom,a53pll.yaml           |  1 +
>   arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 40 +++++++++++++++++++
>   drivers/clk/qcom/apss-ipq-pll.c               | 21 ++++++++++
>   3 files changed, 62 insertions(+)
>
