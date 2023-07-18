Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2980C7577B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjGRJTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjGRJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:18:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41391172E;
        Tue, 18 Jul 2023 02:17:46 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I6ki2C011157;
        Tue, 18 Jul 2023 09:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A818KdEbeKHZBYB3z0nqPAcPR+tBDlEcmM3BgkJ0uw0=;
 b=G+WnkkLJ/m+IsK8wOUz7Gc9uGvUTbNp3erdFnzbZC29esUwgTYWEFLzYHyDpYSovhInL
 yHG+g2mFzqUGbf7S8GhvFsQYKzvtxjNnejBdIh1sch7vZnUGS+RReeT8OFYwEpG7Q7Et
 M3GPVUmI3oYW0jSaMF9vU2RbnmS/MQ9pq5JQT3W2HbTaOnm5pEnhHKhTreHxriJAbJMx
 +bvc3W0TGWhBJOBRsHC4KckKvx6BMPcqr4UGE62vP4wA8QJxCdUU74TvapY4Mc8VoUdg
 DDdYqCXh+6i/auwlDin0hfW7NymtDQvWuUR1P2QYXwR00iQte9ZnAbv6R/WuI48WB5pi VA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwnrrgah3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 09:13:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I9DtLF020566
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 09:13:55 GMT
Received: from [10.216.57.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 02:13:47 -0700
Message-ID: <01d03f4b-699d-934d-60ff-4c95e07063fd@quicinc.com>
Date:   Tue, 18 Jul 2023 14:43:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-5-quic_devipriy@quicinc.com>
 <31075ecb-7e3c-302f-a668-b872017e19b3@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <31075ecb-7e3c-302f-a668-b872017e19b3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j0AqwxugXVginvFePai1ZmuIYUbjpWqi
X-Proofpoint-ORIG-GUID: j0AqwxugXVginvFePai1ZmuIYUbjpWqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180083
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2023 4:20 PM, Dmitry Baryshkov wrote:
> On 11/07/2023 12:35, Devi Priya wrote:
>> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 
>> based
>> devices.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig         |    6 +
>>   drivers/clk/qcom/Makefile        |    1 +
>>   drivers/clk/qcom/nsscc-ipq9574.c | 3080 ++++++++++++++++++++++++++++++
>>   3 files changed, 3087 insertions(+)
>>   create mode 100644 drivers/clk/qcom/nsscc-ipq9574.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 263e55d75e3f..5556063d204f 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -195,6 +195,12 @@ config IPQ_GCC_9574
>>         i2c, USB, SD/eMMC, etc. Select this for the root clock
>>         of ipq9574.
>> +config IPQ_NSSCC_9574
>> +    tristate "IPQ9574 NSS Clock Controller"
>> +    depends on IPQ_GCC_9574
>> +    help
>> +      Support for NSS clock controller on ipq9574 devices.
>> +
>>   config MSM_GCC_8660
>>       tristate "MSM8660 Global Clock Controller"
>>       depends on ARM || COMPILE_TEST
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index e6e294274c35..8ba882186bff 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -29,6 +29,7 @@ obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>>   obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>>   obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
>>   obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
>> +obj-$(CONFIG_IPQ_NSSCC_9574)    += nsscc-ipq9574.o
>>   obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>>   obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
>>   obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
>> diff --git a/drivers/clk/qcom/nsscc-ipq9574.c 
>> b/drivers/clk/qcom/nsscc-ipq9574.c
>> new file mode 100644
>> index 000000000000..b6bed0d24059
>> --- /dev/null
>> +++ b/drivers/clk/qcom/nsscc-ipq9574.c
>> @@ -0,0 +1,3080 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
>> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
>> +
>> +#include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-pll.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>> +#include "clk-regmap-divider.h"
>> +#include "clk-regmap-mux.h"
>> +#include "common.h"
>> +#include "reset.h"
>> +
>> +/* Need to match the order of clocks in DT binding */
>> +enum {
>> +    DT_BIAS_PLL_CC_CLK,
>> +    DT_BIAS_PLL_NSS_NOC_CLK,
>> +    DT_BIAS_PLL_UBI_NC_CLK,
>> +    DT_GCC_GPLL0_OUT_AUX,
>> +    DT_UNIPHY0_GCC_RX_CLK,
>> +    DT_UNIPHY0_GCC_TX_CLK,
>> +    DT_UNIPHY1_GCC_RX_CLK,
>> +    DT_UNIPHY1_GCC_TX_CLK,
>> +    DT_UNIPHY2_GCC_RX_CLK,
>> +    DT_UNIPHY2_GCC_TX_CLK,
>> +    DT_XO,
>> +};
>> +
>> +enum {
>> +    P_BIAS_PLL_CC_CLK,
>> +    P_BIAS_PLL_NSS_NOC_CLK,
>> +    P_BIAS_PLL_UBI_NC_CLK,
>> +    P_GCC_GPLL0_OUT_AUX,
>> +    P_UBI32_PLL_OUT_MAIN,
>> +    P_UNIPHY0_GCC_RX_CLK,
>> +    P_UNIPHY0_GCC_TX_CLK,
>> +    P_UNIPHY1_GCC_RX_CLK,
>> +    P_UNIPHY1_GCC_TX_CLK,
>> +    P_UNIPHY2_GCC_RX_CLK,
>> +    P_UNIPHY2_GCC_TX_CLK,
>> +    P_XO,
>> +};
>> +
>> +static const struct alpha_pll_config ubi32_pll_config = {
>> +    .l = 0x3e,
>> +    .alpha = 0x6666,
>> +    .config_ctl_val = 0x200d4aa8,
>> +    .config_ctl_hi_val = 0x3c,
>> +    .main_output_mask = BIT(0),
>> +    .aux_output_mask = BIT(1),
>> +    .pre_div_val = 0x0,
>> +    .pre_div_mask = BIT(12),
>> +    .post_div_val = 0x0,
>> +    .post_div_mask = GENMASK(9, 8),
>> +    .alpha_en_mask = BIT(24),
>> +    .test_ctl_val = 0x1c0000c0,
>> +    .test_ctl_hi_val = 0x4000,
>> +};
>> +
>> +static struct clk_alpha_pll ubi32_pll_main = {
>> +    .offset = 0x28000,
>> +    .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA],
>> +    .flags = SUPPORTS_DYNAMIC_UPDATE,
>> +    .clkr = {
>> +        .hw.init = &(const struct clk_init_data) {
>> +            .name = "ubi32_pll_main",
>> +            .parent_data = &(const struct clk_parent_data) {
>> +                .index = DT_XO,
>> +            },
>> +            .num_parents = 1,
>> +            .ops = &clk_alpha_pll_huayra_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_alpha_pll_postdiv ubi32_pll = {
>> +    .offset = 0x28000,
>> +    .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA],
>> +    .width = 2,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "ubi32_pll",
>> +        .parent_hws = (const struct clk_hw *[]) {
>> +            &ubi32_pll_main.clkr.hw
>> +        },
>> +        .num_parents = 1,
>> +        .ops = &clk_alpha_pll_postdiv_ro_ops,
>> +        .flags = CLK_SET_RATE_PARENT,
>> +    },
>> +};
>> +
> 
> [skipped the rest, LGTM]
> 
>   +
>> +static int nss_cc_ipq9574_probe(struct platform_device *pdev)
>> +{
>> +    struct regmap *regmap;
>> +    struct qcom_cc_desc nsscc_ipq9574_desc = nss_cc_ipq9574_desc;
>> +
>> +    regmap = qcom_cc_map(pdev, &nsscc_ipq9574_desc);
>> +    if (IS_ERR(regmap))
>> +        return PTR_ERR(regmap);
>> +
>> +    /* SW Workaround for UBI Huayra PLL */
>> +    regmap_update_bits(regmap, 0x2800C, BIT(26), BIT(26));
> 
> Can we directly set the correct value via ubi32_pll_config.test_ctl_val ?

Sure, will check and update in V2
> 
>> +
>> +    clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
>> +
>> +    return qcom_cc_really_probe(pdev, &nsscc_ipq9574_desc, regmap);
>> +}
>> +
>> +static struct platform_driver nss_cc_ipq9574_driver = {
>> +    .probe = nss_cc_ipq9574_probe,
>> +    .driver = {
>> +        .name = "qcom,nsscc-ipq9574",
>> +        .of_match_table = nss_cc_ipq9574_match_table,
>> +    },
>> +};
>> +
>> +static int __init nss_cc_ipq9574_init(void)
>> +{
>> +    return platform_driver_register(&nss_cc_ipq9574_driver);
>> +}
>> +subsys_initcall(nss_cc_ipq9574_init);
>> +
>> +static void __exit nss_cc_ipq9574_exit(void)
>> +{
>> +    platform_driver_unregister(&nss_cc_ipq9574_driver);
>> +}
>> +module_exit(nss_cc_ipq9574_exit);
> 
> module_platform_driver ?
okay

Thanks,
Devi Priya
> 
>> +
>> +MODULE_DESCRIPTION("QTI NSS_CC IPQ9574 Driver");
>> +MODULE_LICENSE("GPL");
> 
