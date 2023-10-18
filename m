Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0B7CDE77
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbjJROKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344879AbjJROJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6619B;
        Wed, 18 Oct 2023 07:09:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IDkGLG017627;
        Wed, 18 Oct 2023 14:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=o4XBTkJlvarejnZV8pC470v6+3DYRzBxpiH+Yo4yy20=;
 b=Y2M5WhxHER5RKIvsMW6x4BCK6Yd7cRXarn7/Rdameqpf7ryiGrSAZccyo8/R9zy+w0bY
 JRU7b2K4D5xC3YGid8xwoKw1hsbiIYu94ZNSF9LEqzkPBzEgPsNw5W0aVtykBbn4u+NT
 JKke6kkBl1U8EZMUaacLywkPZ1Z4tc1GxBKLhralhC3EQ9z9UPhhj6706LHZF7SkVDEU
 C5UgxiCTyQAEEMDOfrd0of51xu9y+tF62ETfZSSl4yxbHOnCO1S5/AuVaeiX8KuXjSp9
 54gD0McHM8rSjZVysEtHq49IgFZ2B55RxyL7Zhy8tt0cxD6M6xcNRbIEXPh59s1TAul9 5g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt8xs952p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 14:09:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IE8vV8023216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 14:08:58 GMT
Received: from [10.216.42.121] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 07:08:49 -0700
Message-ID: <ee431c51-1474-47f9-b298-8ca284ea353b@quicinc.com>
Date:   Wed, 18 Oct 2023 19:38:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Add GPLL0 as clock provider for the Qualcomm's
 IPQ mailbox controller
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Sricharan Ramabadhran" <quic_srichara@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Marko <robimarko@gmail.com>
References: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ijw9qUUhIq2d-FlkW1rzCJGjGOrf2wun
X-Proofpoint-ORIG-GUID: ijw9qUUhIq2d-FlkW1rzCJGjGOrf2wun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310180117
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2023 12:29 PM, Kathiravan Thirumoorthy wrote:
> Currently mailbox controller takes the XO and APSS PLL as the input. It
> can take the GPLL0 also as an input. This patch series adds the same and
> fixes the issue caused by this.
>
> Once the cpufreq driver is up, it tries to bump up the cpu frequency
> above 800MHz, while doing so system is going to unusable state. Reason
> being, with the GPLL0 included as clock source, clock framework tries to
> achieve the required rate with the possible parent and since GPLL0
> carries the CLK_SET_RATE_PARENT flag, clock rate of the GPLL0 is getting
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


Bjorn, can this series picked up for v6.7?

There is a minor nit the commit message. The statement "APSS PLL will be 
running at 800MHz" should be "APSS clock / CPU clock will be running at 
800MHz" and this should be taken care for clk and the dts patches. Do 
let me know if I need to re-spin the address to address this.

Thanks,


>
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
> Changes in v2:
> - included the patch to drop the CLK_SET_RATE_PARENT from IPQ5018 GCC driver
> - Splitted the DTS changes per target
> - For IPQ8074 and IPQ6018 keep the CLK_SET_RATE_PARENT for UBI32 PLL
>    since the PLL clock rates can be changed
> - Pick up the tags in the relevant patches
> - Link to v1: https://lore.kernel.org/r/20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com
>
> ---
> Kathiravan Thirumoorthy (11):
>        clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks
>        clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks
>        clk: qcom: ipq5018: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
>        clk: qcom: ipq9574: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
>        clk: qcom: ipq5332: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
>        dt-bindings: mailbox: qcom: add one more clock provider for IPQ mailbox
>        clk: qcom: apss-ipq6018: add the GPLL0 clock also as clock provider
>        arm64: dts: qcom: ipq8074: include the GPLL0 as clock provider for mailbox
>        arm64: dts: qcom: ipq6018: include the GPLL0 as clock provider for mailbox
>        arm64: dts: qcom: ipq9574: include the GPLL0 as clock provider for mailbox
>        arm64: dts: qcom: ipq5332: include the GPLL0 as clock provider for mailbox
>
>   .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml          | 2 ++
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi                               | 4 ++--
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi                               | 4 ++--
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi                               | 4 ++--
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi                               | 4 ++--
>   drivers/clk/qcom/apss-ipq6018.c                                     | 3 +++
>   drivers/clk/qcom/gcc-ipq5018.c                                      | 3 ---
>   drivers/clk/qcom/gcc-ipq5332.c                                      | 2 --
>   drivers/clk/qcom/gcc-ipq6018.c                                      | 6 ------
>   drivers/clk/qcom/gcc-ipq8074.c                                      | 6 ------
>   drivers/clk/qcom/gcc-ipq9574.c                                      | 4 ----
>   11 files changed, 13 insertions(+), 29 deletions(-)
> ---
> base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
> change-id: 20230913-gpll_cleanup-5d0a339ebd17
>
> Best regards,
