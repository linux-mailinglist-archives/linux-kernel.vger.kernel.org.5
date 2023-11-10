Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1917F7E8167
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345579AbjKJS17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbjKJSZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A539EF4;
        Fri, 10 Nov 2023 00:34:22 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7fgGY031332;
        Fri, 10 Nov 2023 08:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t85307i1Ns8twulXqpKmb7N/N+DzRYDo54AqUe8XIUI=;
 b=UE2aVSrCqXVUQ5MMtjbpBC0WuDi3+kZIpFSTaW1LQOmYyvMNkqTxIybBfhfPZtGu8SEh
 Z2hGGw33jg3bDD/MQSh3Xp7e46d8uchE0l0BxZF4mF88ogLxRrX9Z5ytDDshFfUAo0QN
 J4FreL+rOJu6Ccmj7xNS9haKOmpuh34VTS6+E+6Ql5PL0TXrB0TuKRnpsgXVQVtpUb8n
 KLUCzKFEZBdxQGbpKHktoIVDi2a3y/UxK3CwnDqComkd0EwcHbBLM8SAm21seNhPk2Ys
 l/XDkwKGWFhg4juGIWPrl7rkfCfP1Hz3W9SUkjq2Ea2YP5CBab/BDAoEwI+VBTPzx+Pc dQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9f3k0b4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:34:18 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA8YIEu032105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:34:18 GMT
Received: from [10.216.7.246] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 00:34:11 -0800
Message-ID: <8a1ce949-204a-1c22-c554-67b31379eb7c@quicinc.com>
Date:   Fri, 10 Nov 2023 14:04:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 3/4] clk: qcom: Add ECPRICC driver support for QDU1000
 and QRU1000
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231106103027.3988871-1-quic_imrashai@quicinc.com>
 <20231106103027.3988871-4-quic_imrashai@quicinc.com>
 <CAA8EJpoGLCfrWQ5r8cOcqyWmF2ZTTqPxFy_HVzPC-A-dCiV48A@mail.gmail.com>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <CAA8EJpoGLCfrWQ5r8cOcqyWmF2ZTTqPxFy_HVzPC-A-dCiV48A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 94UJGMJYTGZoryzYw1CNxTaIr78Eq8IZ
X-Proofpoint-GUID: 94UJGMJYTGZoryzYw1CNxTaIr78Eq8IZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=675
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100071
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/2023 6:34 PM, Dmitry Baryshkov wrote:
> On Mon, 6 Nov 2023 at 12:32, Imran Shaik <quic_imrashai@quicinc.com> wrote:
>>
>> Add ECPRI Clock Controller (ECPRICC) support for QDU1000 and QRU1000 SoCs.
> 
> After reading this series I have one main question. What is ECPRI?
> You've never expanded this acronym.
> 

This is a clock controller for eCPRI Specification V2.0 Common Public 
Radio Interface.

>>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig           |    9 +
>>   drivers/clk/qcom/Makefile          |    1 +
>>   drivers/clk/qcom/ecpricc-qdu1000.c | 2456 ++++++++++++++++++++++++++++
>>   3 files changed, 2466 insertions(+)
>>   create mode 100644 drivers/clk/qcom/ecpricc-qdu1000.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index ad1acd9b7426..9e54afc67519 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -668,6 +668,15 @@ config QDU_GCC_1000
>>            QRU1000 devices. Say Y if you want to use peripheral
>>            devices such as UART, SPI, I2C, USB, SD, PCIe, etc.
>>
>> +config QDU_ECPRICC_1000
>> +       tristate "QDU1000/QRU1000 ECPRI Clock Controller"
>> +       depends on ARM64 || COMPILE_TEST
>> +       select QDU_GCC_1000
>> +       help
>> +         Support for the ECPRI clock controller on QDU1000 and
>> +         QRU1000 devices. Say Y if you want to support the ECPRI
>> +         clock controller functionality such as Ethernet.
>> +
>>   config SDM_GCC_845
>>          tristate "SDM845/SDM670 Global Clock Controller"
>>          depends on ARM64 || COMPILE_TEST
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 17edd73f9839..607ed0fabf36 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -65,6 +65,7 @@ obj-$(CONFIG_QCM_DISPCC_2290) += dispcc-qcm2290.o
>>   obj-$(CONFIG_QCS_GCC_404) += gcc-qcs404.o
>>   obj-$(CONFIG_QCS_Q6SSTOP_404) += q6sstop-qcs404.o
>>   obj-$(CONFIG_QCS_TURING_404) += turingcc-qcs404.o
>> +obj-$(CONFIG_QDU_ECPRICC_1000) += ecpricc-qdu1000.o
>>   obj-$(CONFIG_QDU_GCC_1000) += gcc-qdu1000.o
>>   obj-$(CONFIG_SC_CAMCC_7180) += camcc-sc7180.o
>>   obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
>> diff --git a/drivers/clk/qcom/ecpricc-qdu1000.c b/drivers/clk/qcom/ecpricc-qdu1000.c
>> new file mode 100644
>> index 000000000000..a430b7228c26
>> --- /dev/null
>> +++ b/drivers/clk/qcom/ecpricc-qdu1000.c
>> @@ -0,0 +1,2456 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
> 
> [skipped]
> 
> 
>> +
>> +static struct clk_mem_branch ecpri_cc_eth_phy_0_ock_sram_clk = {
>> +       .mem_enable_reg = 0x8404,
>> +       .mem_ack_reg = 0x8418,
>> +       .mem_enable_ack_mask = BIT(6),
>> +       .branch = {
>> +               .halt_reg = 0xd140,
>> +               .halt_check = BRANCH_HALT,
>> +               .clkr = {
>> +                       .enable_reg = 0xd140,
>> +                       .enable_mask = BIT(0),
>> +                       .hw.init = &(const struct clk_init_data) {
>> +                               .name = "ecpri_cc_eth_phy_0_ock_sram_clk",
>> +                               .ops = &clk_branch2_mem_ops,
> 
> This (and several following branch clocks) do not have a parent
> defined. From which clock are they derived from?
> 

These branch clocks are connected to the Muxes, that are sourced from 
the PoR ON external clocks which are not required to be controlled from 
the SW side.

Thanks,
Imran

>> +                       },
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_mem_branch ecpri_cc_eth_phy_1_ock_sram_clk = {
>> +       .mem_enable_reg = 0x8408,
>> +       .mem_ack_reg = 0x841C,
>> +       .mem_enable_ack_mask = BIT(6),
>> +       .branch = {
>> +               .halt_reg = 0xd148,
>> +               .halt_check = BRANCH_HALT,
>> +               .clkr = {
>> +                       .enable_reg = 0xd148,
>> +                       .enable_mask = BIT(0),
>> +                       .hw.init = &(const struct clk_init_data) {
>> +                               .name = "ecpri_cc_eth_phy_1_ock_sram_clk",
>> +                               .ops = &clk_branch2_mem_ops,
>> +                       },
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_mem_branch ecpri_cc_eth_phy_2_ock_sram_clk = {
>> +       .mem_enable_reg = 0x840c,
>> +       .mem_ack_reg = 0x8420,
>> +       .mem_enable_ack_mask = BIT(6),
>> +       .branch = {
>> +               .halt_reg = 0xd150,
>> +               .halt_check = BRANCH_HALT,
>> +               .clkr = {
>> +                       .enable_reg = 0xd150,
>> +                       .enable_mask = BIT(0),
>> +                       .hw.init = &(const struct clk_init_data) {
>> +                               .name = "ecpri_cc_eth_phy_2_ock_sram_clk",
>> +                               .ops = &clk_branch2_mem_ops,
>> +                       },
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_mem_branch ecpri_cc_eth_phy_3_ock_sram_clk = {
>> +       .mem_enable_reg = 0x8410,
>> +       .mem_ack_reg = 0x8424,
>> +       .mem_enable_ack_mask = BIT(6),
>> +       .branch = {
>> +               .halt_reg = 0xd158,
>> +               .halt_check = BRANCH_HALT,
>> +               .clkr = {
>> +                       .enable_reg = 0xd158,
>> +                       .enable_mask = BIT(0),
>> +                       .hw.init = &(const struct clk_init_data) {
>> +                               .name = "ecpri_cc_eth_phy_3_ock_sram_clk",
>> +                               .ops = &clk_branch2_mem_ops,
>> +                       },
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_mem_branch ecpri_cc_eth_phy_4_ock_sram_clk = {
>> +       .mem_enable_reg = 0x8414,
>> +       .mem_ack_reg = 0x8428,
>> +       .mem_enable_ack_mask = BIT(6),
>> +       .branch = {
>> +               .halt_reg = 0xd160,
>> +               .halt_check = BRANCH_HALT,
>> +               .clkr = {
>> +                       .enable_reg = 0xd160,
>> +                       .enable_mask = BIT(0),
>> +                       .hw.init = &(const struct clk_init_data) {
>> +                               .name = "ecpri_cc_eth_phy_4_ock_sram_clk",
>> +                               .ops = &clk_branch2_mem_ops,
>> +                       },
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_mss_emac_clk = {
>> +       .halt_reg = 0xe008,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xe008,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_mss_emac_clk",
>> +                       .parent_hws = (const struct clk_hw*[]) {
>> +                               &ecpri_cc_mss_emac_clk_src.clkr.hw,
>> +                       },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_SET_RATE_PARENT,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_mss_oran_clk = {
>> +       .halt_reg = 0xe004,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xe004,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_mss_oran_clk",
>> +                       .parent_hws = (const struct clk_hw*[]) {
>> +                               &ecpri_cc_ecpri_oran_clk_src.clkr.hw,
>> +                       },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_SET_RATE_PARENT,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy0_lane0_rx_clk = {
>> +       .halt_reg = 0xd000,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd000,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy0_lane0_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy0_lane0_tx_clk = {
>> +       .halt_reg = 0xd050,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd050,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy0_lane0_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy0_lane1_rx_clk = {
>> +       .halt_reg = 0xd004,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd004,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy0_lane1_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy0_lane1_tx_clk = {
>> +       .halt_reg = 0xd054,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd054,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy0_lane1_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy0_lane2_rx_clk = {
>> +       .halt_reg = 0xd008,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd008,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy0_lane2_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy0_lane2_tx_clk = {
>> +       .halt_reg = 0xd058,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd058,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy0_lane2_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy0_lane3_rx_clk = {
>> +       .halt_reg = 0xd00c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd00c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy0_lane3_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy0_lane3_tx_clk = {
>> +       .halt_reg = 0xd05c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd05c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy0_lane3_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy1_lane0_rx_clk = {
>> +       .halt_reg = 0xd010,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd010,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy1_lane0_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy1_lane0_tx_clk = {
>> +       .halt_reg = 0xd060,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd060,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy1_lane0_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy1_lane1_rx_clk = {
>> +       .halt_reg = 0xd014,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd014,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy1_lane1_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy1_lane1_tx_clk = {
>> +       .halt_reg = 0xd064,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd064,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy1_lane1_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy1_lane2_rx_clk = {
>> +       .halt_reg = 0xd018,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd018,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy1_lane2_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy1_lane2_tx_clk = {
>> +       .halt_reg = 0xd068,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd068,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy1_lane2_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy1_lane3_rx_clk = {
>> +       .halt_reg = 0xd01c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd01c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy1_lane3_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy1_lane3_tx_clk = {
>> +       .halt_reg = 0xd06c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd06c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy1_lane3_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy2_lane0_rx_clk = {
>> +       .halt_reg = 0xd020,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd020,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy2_lane0_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy2_lane0_tx_clk = {
>> +       .halt_reg = 0xd070,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd070,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy2_lane0_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy2_lane1_rx_clk = {
>> +       .halt_reg = 0xd024,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd024,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy2_lane1_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy2_lane1_tx_clk = {
>> +       .halt_reg = 0xd074,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd074,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy2_lane1_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy2_lane2_rx_clk = {
>> +       .halt_reg = 0xd028,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd028,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy2_lane2_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy2_lane2_tx_clk = {
>> +       .halt_reg = 0xd078,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd078,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy2_lane2_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy2_lane3_rx_clk = {
>> +       .halt_reg = 0xd02c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd02c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy2_lane3_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy2_lane3_tx_clk = {
>> +       .halt_reg = 0xd07c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd07c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy2_lane3_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy3_lane0_rx_clk = {
>> +       .halt_reg = 0xd030,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd030,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy3_lane0_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy3_lane0_tx_clk = {
>> +       .halt_reg = 0xd080,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd080,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy3_lane0_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy3_lane1_rx_clk = {
>> +       .halt_reg = 0xd034,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd034,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy3_lane1_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy3_lane1_tx_clk = {
>> +       .halt_reg = 0xd084,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd084,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy3_lane1_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy3_lane2_rx_clk = {
>> +       .halt_reg = 0xd038,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd038,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy3_lane2_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy3_lane2_tx_clk = {
>> +       .halt_reg = 0xd088,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd088,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy3_lane2_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy3_lane3_rx_clk = {
>> +       .halt_reg = 0xd03c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd03c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy3_lane3_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy3_lane3_tx_clk = {
>> +       .halt_reg = 0xd08c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd08c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy3_lane3_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy4_lane0_rx_clk = {
>> +       .halt_reg = 0xd040,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd040,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy4_lane0_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy4_lane0_tx_clk = {
>> +       .halt_reg = 0xd090,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd090,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy4_lane0_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy4_lane1_rx_clk = {
>> +       .halt_reg = 0xd044,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd044,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy4_lane1_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy4_lane1_tx_clk = {
>> +       .halt_reg = 0xd094,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd094,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy4_lane1_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy4_lane2_rx_clk = {
>> +       .halt_reg = 0xd048,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd048,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy4_lane2_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy4_lane2_tx_clk = {
>> +       .halt_reg = 0xd098,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd098,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy4_lane2_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy4_lane3_rx_clk = {
>> +       .halt_reg = 0xd04c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd04c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy4_lane3_rx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch ecpri_cc_phy4_lane3_tx_clk = {
>> +       .halt_reg = 0xd09c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xd09c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "ecpri_cc_phy4_lane3_tx_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
> 
> [skipped]
> 
>> +static int ecpri_cc_qdu1000_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +
>> +       regmap = qcom_cc_map(pdev, &ecpri_cc_qdu1000_desc);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       clk_lucid_evo_pll_configure(&ecpri_cc_pll0, regmap, &ecpri_cc_pll0_config);
>> +       clk_lucid_evo_pll_configure(&ecpri_cc_pll1, regmap, &ecpri_cc_pll1_config);
>> +
>> +       return qcom_cc_really_probe(pdev, &ecpri_cc_qdu1000_desc, regmap);
>> +}
>> +
>> +static struct platform_driver ecpri_cc_qdu1000_driver = {
>> +       .probe = ecpri_cc_qdu1000_probe,
>> +       .driver = {
>> +               .name = "ecpri_cc-qdu1000",
>> +               .of_match_table = ecpri_cc_qdu1000_match_table,
>> +       },
>> +};
>> +
>> +module_platform_driver(ecpri_cc_qdu1000_driver);
>> +
>> +MODULE_DESCRIPTION("QTI ECPRICC QDU1000 Driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.25.1
>>
> 
> 
