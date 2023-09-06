Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A727934A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjIFFBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjIFFBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:01:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3559CC2;
        Tue,  5 Sep 2023 22:01:14 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3864eOIq020202;
        Wed, 6 Sep 2023 05:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eIZcKPwVL6+2epnQ/gz/nF5ciddoea6Nbp2GtZbFDeY=;
 b=RaMBREg5pTlf0SQVUGGeZmpt5JPdt3hegXEkrkQHrgKEI1RxR9eQwJ/rBXebAat4p7pu
 pn9HA3RziIWaL90wBDNIDPv0LjRv+56qndzIrqbNYDm5k2tvvv3DWFR6Tqguwtlkh8Fs
 76b0Z1K3ngXvBdZ52Zdeo5qqL85BE7BjFN3W7PbkEL9mqG8r+p5HV1yglhEPsheMUuA8
 ZNg6uyVNb6QHCLK/HgLmohmd3fWFBeZWaICaQF0bgCrajOFCMadtO9oIwan9bhVcpB5Y
 TpPnHYAl+UVMZUVx4+sfCtFBRRWJEBwC5DmTXn48Jf1YS5w7mYjpujtxvGaToO7rNv2/ IQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swprekjvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 05:01:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 386510at032520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 05:01:00 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 22:00:54 -0700
Message-ID: <131ad20f-ed64-11b8-e1d8-f48990115b21@quicinc.com>
Date:   Wed, 6 Sep 2023 10:30:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH RESEND 0/7] Add GPLL0 as clock provider for the Qualcomm's
 IPQ mailbox controller
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xlCtJKh4lnpZwYAdqx9t-wMSBzJ4Rv1s
X-Proofpoint-GUID: xlCtJKh4lnpZwYAdqx9t-wMSBzJ4Rv1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060045
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/2023 10:26 AM, Kathiravan Thirumoorthy wrote:
> Currently mailbox controller takes the XO and APSS PLL as the input. It
> can take the GPLL0 also as an input. This patch series adds the same and
> fixes the issue caused by this.
>
> Once the cpufreq driver is up, it tries to bump up the cpu frequency
> above 800MHz, while doing so system is going to unusable state. Reason
> being, with the GPLL0 included as clock source, clock framework tries to
> achieve the required rate with the possible parent and since GPLL0 carries
> the CLK_SET_RATE_PARENT flag, clock rate of the GPLL0 is getting
> changed, causing the issue.
>
> First half of the series, removes the CLK_SET_RATE_PARENT flag from the
> PLL clocks since the PLL clock rates shouldn't be changed. Another
> half, add the necessary support to include the GPLL0 as clock provider
> for mailbox and accomodate the changes in APSS clock driver.
>
> This is also the preparatory series to enable the CPUFreq on IPQ5332
> SoC. Dynamic scaling of CPUFreq is not supported on IPQ5332, so to
> switch between the frequencies we need to park the APSS PLL in safe
> source, here it is GPLL0 and then shutdown and bring up the APSS PLL in
> the desired rate.
>
> For IPQ5332 SoC, this series depends on the below patch
> https://lore.kernel.org/linux-arm-msm/1693474133-10467-1-git-send-email-quic_varada@quicinc.com/


My bad.. This is not a 'resend', this is V1.. I'm trying to get used to 
b4 and messed up... Will rectify it in future.


>
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
> Kathiravan Thirumoorthy (7):
>        clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks
>        clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks
>        clk: qcom: ipq9574: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
>        clk: qcom: ipq5332: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
>        dt-bindings: mailbox: qcom: add one more clock provider for IPQ mailbox
>        clk: qcom: apss-ipq6018: add the GPLL0 clock also as clock provider
>        arm64: dts: qcom: include the GPLL0 as clock provider for IPQ mailbox
>
>   .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml         | 2 ++
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi                              | 4 ++--
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi                              | 4 ++--
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi                              | 4 ++--
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi                              | 4 ++--
>   drivers/clk/qcom/apss-ipq6018.c                                    | 3 +++
>   drivers/clk/qcom/gcc-ipq5332.c                                     | 2 --
>   drivers/clk/qcom/gcc-ipq6018.c                                     | 7 -------
>   drivers/clk/qcom/gcc-ipq8074.c                                     | 7 -------
>   drivers/clk/qcom/gcc-ipq9574.c                                     | 4 ----
>   10 files changed, 13 insertions(+), 28 deletions(-)
> ---
> base-commit: a47fc304d2b678db1a5d760a7d644dac9b067752
> change-id: 20230904-gpll_cleanup-8b3e8b058c8b
>
> Best regards,
