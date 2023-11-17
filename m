Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D087EEB8E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 05:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjKQD44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 22:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQD4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 22:56:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313B1A5;
        Thu, 16 Nov 2023 19:56:48 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH3pvgU011227;
        Fri, 17 Nov 2023 03:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JD74LyrVfJ5+0zuL5a4npyJr6/JmswcNLbfsuv62StQ=;
 b=HqGGnoDBB9ojXXzlNgHy84JtZ7hEsJNNP4wTZSk7wran7oShGXMifVHffhv5cOji2ASO
 Cvl2BTEJvkWo5F9SjWQTsq+jkUeczqdXdmqb1Fj6P5vHNRwOuifL4Vz5s6QsxVDYYPph
 Xg6tsZ+GU0BG8mNL21A+1TsYZnIo39xBxTjKB+t/sm+1bXCt9Ow428GnclmQpg9Y8wRB
 lCtT1TjQ65fOF58nXtzAI+Wz7E2XEAe/+vXz9XxlHSaKq/FhWayiu5uJWVVHorKPhJMn
 Vm9dE+bcgYpU+zbW2Ic+UgdGkhy59opFsrx02kjZfrQiS5uFjSD7LyKt+zzKzXOMQgWM dw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udms91npu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 03:56:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH3uYca031990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 03:56:34 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 19:56:28 -0800
Message-ID: <e857c853-51ef-8314-2a21-fa6fd25162ca@quicinc.com>
Date:   Fri, 17 Nov 2023 09:26:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] clk: qcom: Add Global Clock controller (GCC) driver
 for SC8380XP
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_tdas@quicinc.com>, <quic_rjendra@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
        <quic_tsoni@quicinc.com>
References: <20231025133320.4720-1-quic_sibis@quicinc.com>
 <20231025133320.4720-3-quic_sibis@quicinc.com>
 <483c4de3-951c-4ba4-89fb-36fcd44fa99f@linaro.org>
Content-Language: en-US
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <483c4de3-951c-4ba4-89fb-36fcd44fa99f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xppzeRldUZ6xeiYHVIbAYlFUMGKakAm7
X-Proofpoint-ORIG-GUID: xppzeRldUZ6xeiYHVIbAYlFUMGKakAm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=984 spamscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170027
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bryan,

Thanks for taking time to review the series.

On 10/25/23 22:10, Bryan O'Donoghue wrote:
> On 25/10/2023 14:33, Sibi Sankar wrote:
>> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>>
>> Add support for the global clock controller found on SC8380XP
>> based devices.
>>
>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig        |   10 +
>>   drivers/clk/qcom/Makefile       |    1 +
>>   drivers/clk/qcom/gcc-sc8380xp.c | 6812 +++++++++++++++++++++++++++++++
>>   3 files changed, 6823 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gcc-sc8380xp.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index ad1acd9b7426..013b3a1ad551 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -515,6 +515,16 @@ config SC_GCC_8280XP
>>         Say Y if you want to use peripheral devices such as UART, SPI,
>>         I2C, USB, UFS, SDCC, etc.
>> +config SC_GCC_8380XP
>> +    tristate "SC8380XP Global Clock Controller"
>> +    select QCOM_GDSC
>> +    depends on COMMON_CLK_QCOM
>> +    help
>> +      Support for the global clock controller on Qualcomm 
>> Technologies, Inc
>> +      SC8380XP devices.
>> +      Say Y if you want to use peripheral devices such as UART, SPI, 
>> I2C,
>> +      USB, UFS, SD/eMMC, PCIe, etc.
>> +
>>   config SC_GPUCC_7180
>>       tristate "SC7180 Graphics Clock Controller"
>>       depends on ARM64 || COMPILE_TEST
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 17edd73f9839..11b1f79e15c5 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -77,6 +77,7 @@ obj-$(CONFIG_SC_GCC_7180) += gcc-sc7180.o
>>   obj-$(CONFIG_SC_GCC_7280) += gcc-sc7280.o
>>   obj-$(CONFIG_SC_GCC_8180X) += gcc-sc8180x.o
>>   obj-$(CONFIG_SC_GCC_8280XP) += gcc-sc8280xp.o
>> +obj-$(CONFIG_SC_GCC_8380XP) += gcc-sc8380xp.o
>>   obj-$(CONFIG_SC_GPUCC_7180) += gpucc-sc7180.o
>>   obj-$(CONFIG_SC_GPUCC_7280) += gpucc-sc7280.o
>>   obj-$(CONFIG_SC_GPUCC_8280XP) += gpucc-sc8280xp.o
>> diff --git a/drivers/clk/qcom/gcc-sc8380xp.c 
>> b/drivers/clk/qcom/gcc-sc8380xp.c
>> new file mode 100644
>> index 000000000000..48c50f9421c8
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-sc8380xp.c
>> @@ -0,0 +1,6812 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/qcom,sc8380xp-gcc.h>
>> +
>> +#include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>> +#include "clk-regmap-divider.h"
>> +#include "clk-regmap-mux.h"
>> +#include "clk-regmap-phy-mux.h"
>> +#include "gdsc.h"
>> +#include "reset.h"
>> +
>> +enum {
>> +    DT_BI_TCXO,
>> +    DT_SLEEP_CLK,
>> +    DT_PCIE_3_PIPE,
>> +    DT_PCIE_4_PIPE,
>> +    DT_PCIE_5_PIPE,
>> +    DT_PCIE_6A_PIPE,
>> +    DT_PCIE_6B_PIPE,
>> +    DT_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE,
>> +    DT_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE,
>> +    DT_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE,
>> +};
>> +
>> +enum {
>> +    P_BI_TCXO,
>> +    P_GCC_GPLL0_OUT_EVEN,
>> +    P_GCC_GPLL0_OUT_MAIN,
>> +    P_GCC_GPLL4_OUT_MAIN,
>> +    P_GCC_GPLL7_OUT_MAIN,
>> +    P_GCC_GPLL8_OUT_MAIN,
>> +    P_GCC_GPLL9_OUT_MAIN,
>> +    P_SLEEP_CLK,
>> +    P_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE_CLK,
>> +    P_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE_CLK,
>> +    P_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE_CLK,
>> +};
>> +
>> +static struct clk_alpha_pll gcc_gpll0 = {
>> +    .offset = 0x0,
>> +    .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
>> +    .clkr = {
>> +        .enable_reg = 0x52030,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(const struct clk_init_data) {
>> +            .name = "gcc_gpll0",
>> +            .parent_data = &(const struct clk_parent_data) {
>> +                .index = DT_BI_TCXO,
>> +            },
>> +            .num_parents = 1,
>> +            .ops = &clk_alpha_pll_fixed_lucid_ole_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static const struct clk_div_table post_div_table_gcc_gpll0_out_even[] 
>> = {
>> +    { 0x1, 2 },
>> +    { }
>> +};
>> +
>> +static struct clk_alpha_pll_postdiv gcc_gpll0_out_even = {
>> +    .offset = 0x0,
>> +    .post_div_shift = 10,
>> +    .post_div_table = post_div_table_gcc_gpll0_out_even,
>> +    .num_post_div = ARRAY_SIZE(post_div_table_gcc_gpll0_out_even),
>> +    .width = 4,
>> +    .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_gpll0_out_even",
>> +        .parent_hws = (const struct clk_hw*[]) {
>> +            &gcc_gpll0.clkr.hw,
>> +        },
>> +        .num_parents = 1,
>> +        .ops = &clk_alpha_pll_postdiv_lucid_ole_ops,
>> +    },
>> +};
>> +
>> +static struct clk_alpha_pll gcc_gpll4 = {
>> +    .offset = 0x4000,
>> +    .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
>> +    .clkr = {
>> +        .enable_reg = 0x52030,
>> +        .enable_mask = BIT(4),
>> +        .hw.init = &(const struct clk_init_data) {
>> +            .name = "gcc_gpll4",
>> +            .parent_data = &(const struct clk_parent_data) {
>> +                .index = DT_BI_TCXO,
>> +            },
>> +            .num_parents = 1,
>> +            .ops = &clk_alpha_pll_fixed_lucid_ole_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_alpha_pll gcc_gpll7 = {
>> +    .offset = 0x7000,
>> +    .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
>> +    .clkr = {
>> +        .enable_reg = 0x52030,
>> +        .enable_mask = BIT(7),
>> +        .hw.init = &(const struct clk_init_data) {
>> +            .name = "gcc_gpll7",
>> +            .parent_data = &(const struct clk_parent_data) {
>> +                .index = DT_BI_TCXO,
>> +            },
>> +            .num_parents = 1,
>> +            .ops = &clk_alpha_pll_fixed_lucid_ole_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_alpha_pll gcc_gpll8 = {
>> +    .offset = 0x8000,
>> +    .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
>> +    .clkr = {
>> +        .enable_reg = 0x52030,
>> +        .enable_mask = BIT(8),
>> +        .hw.init = &(const struct clk_init_data) {
>> +            .name = "gcc_gpll8",
>> +            .parent_data = &(const struct clk_parent_data) {
>> +                .index = DT_BI_TCXO,
>> +            },
>> +            .num_parents = 1,
>> +            .ops = &clk_alpha_pll_fixed_lucid_ole_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_alpha_pll gcc_gpll9 = {
>> +    .offset = 0x9000,
>> +    .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
>> +    .clkr = {
>> +        .enable_reg = 0x52030,
>> +        .enable_mask = BIT(9),
>> +        .hw.init = &(const struct clk_init_data) {
>> +            .name = "gcc_gpll9",
>> +            .parent_data = &(const struct clk_parent_data) {
>> +                .index = DT_BI_TCXO,
>> +            },
>> +            .num_parents = 1,
>> +            .ops = &clk_alpha_pll_fixed_lucid_ole_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_0[] = {
>> +    { P_BI_TCXO, 0 },
>> +    { P_GCC_GPLL0_OUT_MAIN, 1 },
>> +    { P_GCC_GPLL0_OUT_EVEN, 6 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_0[] = {
>> +    { .index = DT_BI_TCXO },
>> +    { .hw = &gcc_gpll0.clkr.hw },
>> +    { .hw = &gcc_gpll0_out_even.clkr.hw },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_1[] = {
>> +    { P_BI_TCXO, 0 },
>> +    { P_SLEEP_CLK, 5 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_1[] = {
>> +    { .index = DT_BI_TCXO },
>> +    { .index = DT_SLEEP_CLK },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_2[] = {
>> +    { P_BI_TCXO, 0 },
>> +    { P_GCC_GPLL0_OUT_MAIN, 1 },
>> +    { P_SLEEP_CLK, 5 },
>> +    { P_GCC_GPLL0_OUT_EVEN, 6 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_2[] = {
>> +    { .index = DT_BI_TCXO },
>> +    { .hw = &gcc_gpll0.clkr.hw },
>> +    { .index = DT_SLEEP_CLK },
>> +    { .hw = &gcc_gpll0_out_even.clkr.hw },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_3[] = {
>> +    { P_BI_TCXO, 0 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_3[] = {
>> +    { .index = DT_BI_TCXO },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_4[] = {
>> +    { P_BI_TCXO, 0 },
>> +    { P_GCC_GPLL0_OUT_MAIN, 1 },
>> +    { P_GCC_GPLL8_OUT_MAIN, 2 },
>> +    { P_GCC_GPLL0_OUT_EVEN, 6 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_4[] = {
>> +    { .index = DT_BI_TCXO },
>> +    { .hw = &gcc_gpll0.clkr.hw },
>> +    { .hw = &gcc_gpll8.clkr.hw },
>> +    { .hw = &gcc_gpll0_out_even.clkr.hw },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_5[] = {
>> +    { P_BI_TCXO, 0 },
>> +    { P_GCC_GPLL0_OUT_MAIN, 1 },
>> +    { P_GCC_GPLL7_OUT_MAIN, 2 },
>> +    { P_SLEEP_CLK, 5 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_5[] = {
>> +    { .index = DT_BI_TCXO },
>> +    { .hw = &gcc_gpll0.clkr.hw },
>> +    { .hw = &gcc_gpll7.clkr.hw },
>> +    { .index = DT_SLEEP_CLK },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_6[] = {
>> +    { P_BI_TCXO, 0 },
>> +    { P_GCC_GPLL0_OUT_MAIN, 1 },
>> +    { P_GCC_GPLL7_OUT_MAIN, 2 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_6[] = {
>> +    { .index = DT_BI_TCXO },
>> +    { .hw = &gcc_gpll0.clkr.hw },
>> +    { .hw = &gcc_gpll7.clkr.hw },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_7[] = {
>> +    { P_BI_TCXO, 0 },
>> +    { P_GCC_GPLL0_OUT_MAIN, 1 },
>> +    { P_GCC_GPLL4_OUT_MAIN, 5 },
>> +    { P_GCC_GPLL0_OUT_EVEN, 6 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_7[] = {
>> +    { .index = DT_BI_TCXO },
>> +    { .hw = &gcc_gpll0.clkr.hw },
>> +    { .hw = &gcc_gpll4.clkr.hw },
>> +    { .hw = &gcc_gpll0_out_even.clkr.hw },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_8[] = {
>> +    { P_BI_TCXO, 0 },
>> +    { P_GCC_GPLL0_OUT_MAIN, 1 },
>> +    { P_GCC_GPLL7_OUT_MAIN, 2 },
>> +    { P_GCC_GPLL0_OUT_EVEN, 6 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_8[] = {
>> +    { .index = DT_BI_TCXO },
>> +    { .hw = &gcc_gpll0.clkr.hw },
>> +    { .hw = &gcc_gpll7.clkr.hw },
>> +    { .hw = &gcc_gpll0_out_even.clkr.hw },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_9[] = {
>> +    { P_BI_TCXO, 0 },
>> +    { P_GCC_GPLL0_OUT_MAIN, 1 },
>> +    { P_GCC_GPLL9_OUT_MAIN, 2 },
>> +    { P_GCC_GPLL4_OUT_MAIN, 5 },
>> +    { P_GCC_GPLL0_OUT_EVEN, 6 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_10[] = {
>> +    { .index = DT_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE },
>> +    { .index = DT_BI_TCXO },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_10[] = {
>> +    { P_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE_CLK, 0 },
>> +    { P_BI_TCXO, 2 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_11[] = {
>> +    { .index = DT_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE },
>> +    { .index = DT_BI_TCXO },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_11[] = {
>> +    { P_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE_CLK, 0 },
>> +    { P_BI_TCXO, 2 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_12[] = {
>> +    { .index = DT_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE },
>> +    { .index = DT_BI_TCXO },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_12[] = {
>> +    { P_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE_CLK, 0 },
>> +    { P_BI_TCXO, 2 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_9[] = {
>> +    { .index = DT_BI_TCXO },
>> +    { .hw = &gcc_gpll0.clkr.hw },
>> +    { .hw = &gcc_gpll9.clkr.hw },
>> +    { .hw = &gcc_gpll4.clkr.hw },
>> +    { .hw = &gcc_gpll0_out_even.clkr.hw },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
>> +    F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
>> +    F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
>> +    F(200000000, P_GCC_GPLL0_OUT_MAIN, 3, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_gp1_clk_src = {
>> +    .cmd_rcgr = 0x64004,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_2,
>> +    .freq_tbl = ftbl_gcc_gp1_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_gp1_clk_src",
>> +        .parent_data = gcc_parent_data_2,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_2),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_gp2_clk_src = {
>> +    .cmd_rcgr = 0x65004,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_2,
>> +    .freq_tbl = ftbl_gcc_gp1_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_gp2_clk_src",
>> +        .parent_data = gcc_parent_data_2,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_2),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_gp3_clk_src = {
>> +    .cmd_rcgr = 0x66004,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_2,
>> +    .freq_tbl = ftbl_gcc_gp1_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_gp3_clk_src",
>> +        .parent_data = gcc_parent_data_2,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_2),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_pcie_0_aux_clk_src[] = {
>> +    F(19200000, P_BI_TCXO, 1, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
>> +    .cmd_rcgr = 0xa0180,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_1,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_0_aux_clk_src",
>> +        .parent_data = gcc_parent_data_1,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
>> +    F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_0_phy_rchng_clk_src = {
>> +    .cmd_rcgr = 0xa0054,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_0_phy_rchng_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_1_aux_clk_src = {
>> +    .cmd_rcgr = 0x2c180,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_1,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_1_aux_clk_src",
>> +        .parent_data = gcc_parent_data_1,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_1_phy_rchng_clk_src = {
>> +    .cmd_rcgr = 0x2c054,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_1_phy_rchng_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_2_aux_clk_src = {
>> +    .cmd_rcgr = 0x13180,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_1,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_2_aux_clk_src",
>> +        .parent_data = gcc_parent_data_1,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_2_phy_rchng_clk_src = {
>> +    .cmd_rcgr = 0x13054,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_2_phy_rchng_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_3_aux_clk_src = {
>> +    .cmd_rcgr = 0x5808c,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_1,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_3_aux_clk_src",
>> +        .parent_data = gcc_parent_data_1,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_3_phy_rchng_clk_src = {
>> +    .cmd_rcgr = 0x58070,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_3_phy_rchng_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_4_aux_clk_src = {
>> +    .cmd_rcgr = 0x6b080,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_1,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_4_aux_clk_src",
>> +        .parent_data = gcc_parent_data_1,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_4_phy_rchng_clk_src = {
>> +    .cmd_rcgr = 0x6b064,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_4_phy_rchng_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_5_aux_clk_src = {
>> +    .cmd_rcgr = 0x2f080,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_1,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_5_aux_clk_src",
>> +        .parent_data = gcc_parent_data_1,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_5_phy_rchng_clk_src = {
>> +    .cmd_rcgr = 0x2f064,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_5_phy_rchng_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_6a_aux_clk_src = {
>> +    .cmd_rcgr = 0x3108c,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_1,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_6a_aux_clk_src",
>> +        .parent_data = gcc_parent_data_1,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_6a_phy_rchng_clk_src = {
>> +    .cmd_rcgr = 0x31070,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_6a_phy_rchng_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_6b_aux_clk_src = {
>> +    .cmd_rcgr = 0x8d08c,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_1,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_6b_aux_clk_src",
>> +        .parent_data = gcc_parent_data_1,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_6b_phy_rchng_clk_src = {
>> +    .cmd_rcgr = 0x8d070,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_6b_phy_rchng_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_pcie_rscc_xo_clk_src = {
>> +    .cmd_rcgr = 0xa400c,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_3,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pcie_rscc_xo_clk_src",
>> +        .parent_data = gcc_parent_data_3,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_3),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
>> +    F(60000000, P_GCC_GPLL0_OUT_MAIN, 10, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_pdm2_clk_src = {
>> +    .cmd_rcgr = 0x33010,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pdm2_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_pdm2_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
> 
> Again difference to sc8280xp - should this be clk_rcg2_shared_ops to park ?
> 
>> +    },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
>> +    F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
>> +    F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
>> +    F(19200000, P_BI_TCXO, 1, 0, 0),
>> +    F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
>> +    F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
>> +    F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
>> +    F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
>> +    F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
>> +    F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
>> +    F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
>> +    F(120000000, P_GCC_GPLL0_OUT_MAIN, 5, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap0_s0_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
> 
> Shared on sc8280xp - should be shared on sc8380xp ? Same comment for all 
> of the qupv3 .ops.
> 
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
>> +    .cmd_rcgr = 0x42010,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s0_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap0_s1_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
>> +    .cmd_rcgr = 0x42148,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s1_clk_src_init,
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s2_clk_src[] = {
>> +    F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
>> +    F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
>> +    F(19200000, P_BI_TCXO, 1, 0, 0),
>> +    F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
>> +    F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
>> +    F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
>> +    F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
>> +    F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
>> +    F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
>> +    F(150000000, P_GCC_GPLL0_OUT_EVEN, 2, 0, 0),
>> +    F(200000000, P_GCC_GPLL0_OUT_MAIN, 3, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap0_s2_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
>> +    .cmd_rcgr = 0x42288,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s2_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap0_s3_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
>> +    .cmd_rcgr = 0x423c8,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s3_clk_src_init,
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s4_clk_src[] = {
>> +    F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
>> +    F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
>> +    F(19200000, P_BI_TCXO, 1, 0, 0),
>> +    F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
>> +    F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
>> +    F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
>> +    F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
>> +    F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
>> +    F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
>> +    F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
>> +    F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap0_s4_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
>> +    .cmd_rcgr = 0x42500,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s4_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap0_s5_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
>> +    .cmd_rcgr = 0x42638,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s5_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap0_s6_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
>> +    .cmd_rcgr = 0x42770,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s6_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap0_s7_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
>> +    .cmd_rcgr = 0x428a8,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s7_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap1_s0_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
>> +    .cmd_rcgr = 0x18010,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s0_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap1_s1_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
>> +    .cmd_rcgr = 0x18148,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s1_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap1_s2_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
>> +    .cmd_rcgr = 0x18288,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s2_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap1_s3_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
>> +    .cmd_rcgr = 0x183c8,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s3_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap1_s4_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
>> +    .cmd_rcgr = 0x18500,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s4_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap1_s5_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
>> +    .cmd_rcgr = 0x18638,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s5_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap1_s6_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
>> +    .cmd_rcgr = 0x18770,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s6_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap1_s7_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
>> +    .cmd_rcgr = 0x188a8,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s7_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap2_s0_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap2_s0_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap2_s0_clk_src = {
>> +    .cmd_rcgr = 0x1e010,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap2_s0_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap2_s1_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap2_s1_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap2_s1_clk_src = {
>> +    .cmd_rcgr = 0x1e148,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap2_s1_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap2_s2_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap2_s2_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap2_s2_clk_src = {
>> +    .cmd_rcgr = 0x1e288,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap2_s2_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap2_s3_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap2_s3_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap2_s3_clk_src = {
>> +    .cmd_rcgr = 0x1e3c8,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap2_s3_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap2_s4_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap2_s4_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap2_s4_clk_src = {
>> +    .cmd_rcgr = 0x1e500,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap2_s4_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap2_s5_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap2_s5_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap2_s5_clk_src = {
>> +    .cmd_rcgr = 0x1e638,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap2_s5_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap2_s6_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap2_s6_clk_src",
>> +    .parent_data = gcc_parent_data_8,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_8),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap2_s6_clk_src = {
>> +    .cmd_rcgr = 0x1e770,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_8,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap2_s6_clk_src_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap2_s7_clk_src_init = {
>> +    .name = "gcc_qupv3_wrap2_s7_clk_src",
>> +    .parent_data = gcc_parent_data_0,
>> +    .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +    .flags = CLK_SET_RATE_PARENT,
>> +    .ops = &clk_rcg2_ops,
>> +};
>> +
>> +static struct clk_rcg2 gcc_qupv3_wrap2_s7_clk_src = {
>> +    .cmd_rcgr = 0x1e8a8,
>> +    .mnd_width = 16,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
>> +    .clkr.hw.init = &gcc_qupv3_wrap2_s7_clk_src_init,
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>> +    F(400000, P_BI_TCXO, 12, 1, 4),
>> +    F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
>> +    F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
>> +    F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
>> +    F(202000000, P_GCC_GPLL9_OUT_MAIN, 4, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
>> +    .cmd_rcgr = 0x14018,
>> +    .mnd_width = 8,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_9,
>> +    .freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_sdcc2_apps_clk_src",
>> +        .parent_data = gcc_parent_data_9,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_9),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_floor_ops,
> 
> diff sc8280xp..sc8380xp
> 
> Here you've used floor instead of shared ops, why is that ?

We seem to use floor ops for sdcc clks on all other QC SoCs and
sc8280xp seems to be the exception here. So I'll continue to use floor
ops for sdcc.

> 
>> +    },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
>> +    F(400000, P_BI_TCXO, 12, 1, 4),
>> +    F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
>> +    F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
>> +    .cmd_rcgr = 0x16018,
>> +    .mnd_width = 8,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_sdcc4_apps_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_floor_ops,
>> +    },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
>> +    F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
>> +    F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
>> +    F(150000000, P_GCC_GPLL0_OUT_MAIN, 4, 0, 0),
>> +    F(300000000, P_GCC_GPLL0_OUT_MAIN, 2, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
>> +    .cmd_rcgr = 0x77030,
>> +    .mnd_width = 8,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_ufs_phy_axi_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_ufs_phy_axi_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
> 
> This looks correct since you want to persist this clock in suspend 
> presumably.
> 
>> +    },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
>> +    F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
>> +    F(201500000, P_GCC_GPLL4_OUT_MAIN, 4, 0, 0),
>> +    F(403000000, P_GCC_GPLL4_OUT_MAIN, 2, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
>> +    .cmd_rcgr = 0x77080,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_7,
>> +    .freq_tbl = ftbl_gcc_ufs_phy_ice_core_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_ufs_phy_ice_core_clk_src",
>> +        .parent_data = gcc_parent_data_7,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_7),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
>> +    .cmd_rcgr = 0x770b4,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_3,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_ufs_phy_phy_aux_clk_src",
>> +        .parent_data = gcc_parent_data_3,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_3),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
> 
> but then why not ufs_phy_ice_core and ufs_phy_phy_aux_clk
> 
>> +    },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
>> +    F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
>> +    F(150000000, P_GCC_GPLL0_OUT_MAIN, 4, 0, 0),
>> +    F(300000000, P_GCC_GPLL0_OUT_MAIN, 2, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
>> +    .cmd_rcgr = 0x77098,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_ufs_phy_unipro_core_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_ufs_phy_unipro_core_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
> 
> but back to the parked clock here.
> 
> Shoudln't all of the UFS related clocks park in suspend ?
> 
>> +    },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_usb20_master_clk_src[] = {
>> +    F(60000000, P_GCC_GPLL0_OUT_MAIN, 10, 0, 0),
>> +    F(120000000, P_GCC_GPLL0_OUT_MAIN, 5, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_usb20_master_clk_src = {
>> +    .cmd_rcgr = 0x2902c,
>> +    .mnd_width = 8,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_usb20_master_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_usb20_master_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_usb20_mock_utmi_clk_src = {
>> +    .cmd_rcgr = 0x29158,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_usb20_mock_utmi_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
>> +    },
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_usb30_mp_master_clk_src[] = {
>> +    F(66666667, P_GCC_GPLL0_OUT_EVEN, 4.5, 0, 0),
>> +    F(133333333, P_GCC_GPLL0_OUT_MAIN, 4.5, 0, 0),
>> +    F(200000000, P_GCC_GPLL0_OUT_MAIN, 3, 0, 0),
>> +    F(240000000, P_GCC_GPLL0_OUT_MAIN, 2.5, 0, 0),
>> +    { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_usb30_mp_master_clk_src = {
>> +    .cmd_rcgr = 0x1702c,
>> +    .mnd_width = 8,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_usb30_mp_master_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_usb30_mp_master_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
>> +
>> +static struct clk_rcg2 gcc_usb30_mp_mock_utmi_clk_src = {
>> +    .cmd_rcgr = 0x17158,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = gcc_parent_map_0,
>> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "gcc_usb30_mp_mock_utmi_clk_src",
>> +        .parent_data = gcc_parent_data_0,
>> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_ops,
> 
> This is another discontinuinty with sc8280xp.
> 
> Could you have a look through the sc8280xp gcc and do an aduit for 
> clk_rcg2_shared_ops as against sc8380xp ?

ack, will do a quick audit before the re-spin.

> 
> ---
> bod
