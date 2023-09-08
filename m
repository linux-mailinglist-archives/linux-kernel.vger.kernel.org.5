Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C70679864D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbjIHLLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjIHLLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:11:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2520173B;
        Fri,  8 Sep 2023 04:11:02 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388Ak2B7032159;
        Fri, 8 Sep 2023 11:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/8Iag23OTLTsnB3VTqdLZcw964W/GLsNN3vAVREnXB8=;
 b=XEqdgYaG0sBF1uO5GqGg18Hc46txMAVn06RCM6Oblx523HdI4ah4AIcap8GkhjeHqLZP
 RyMctlNIoTHja1petZI7o3qcmtQ355LbHYZ+QvLTal0FPOw3+Ws3KXGU1QmTHPLSaOoN
 kTYleU1q7G4ZZjYBSuifihQHbKI0zx7A9pYZl7mIOV47TcC7YOmrk0ostrmw3+p/o+zu
 eum/Nex9hTJh0kkGQe3EAQ7Q2UNMMxtb0xUeEcNIrX0qOyTmjvXfngWn8Acm2pWq+pae
 nn+qll+CviczW+xkNzD+9VxsHa7Dh1STICqZk3SBBkSn2MrF4DQlMDu2PU9O4kZqJEPP fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t023wr1sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 11:10:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388BAjMw030631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 11:10:45 GMT
Received: from [10.253.37.110] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 8 Sep
 2023 04:10:37 -0700
Message-ID: <5a4805f7-f802-b1ba-9804-59c0fe6c7f26@quicinc.com>
Date:   Fri, 8 Sep 2023 19:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 4/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230901091823.30242-1-quic_luoj@quicinc.com>
 <20230901091823.30242-5-quic_luoj@quicinc.com>
 <27ae3297ad161fd67706db70b402db04.sboyd@kernel.org>
 <16d09acf-7bdd-04ee-6faf-936c0366df03@quicinc.com>
 <17681a9f756cc70a190c674c51b90140.sboyd@kernel.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <17681a9f756cc70a190c674c51b90140.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NDyKi8ESyM339EF2869YEohi7fuTbah0
X-Proofpoint-ORIG-GUID: NDyKi8ESyM339EF2869YEohi7fuTbah0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080103
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 6:45 AM, Stephen Boyd wrote:
> Quoting Jie Luo (2023-09-07 01:36:50)
>>
>> On 9/6/2023 5:36 AM, Stephen Boyd wrote:
>>> Quoting Luo Jie (2023-09-01 02:18:23)
>>>> diff --git a/drivers/clk/qcom/nsscc-qca8k.c b/drivers/clk/qcom/nsscc-qca8k.c
>>>> new file mode 100644
>>>> index 000000000000..f9312735daf3
>>>> --- /dev/null
>>>> +++ b/drivers/clk/qcom/nsscc-qca8k.c
>>>> @@ -0,0 +1,2179 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/platform_device.h>
>>>
>>> Is platform_device include used?
>>>
>> will remove this.
>>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/phy.h>
>>>
>>> Is the phy include used? Where is the mdio.h include?
>>
>> there is no PHY include, just the mdio_device is included, however the
>> mii_bus->mdio_lock is needed by this clock controller.
>>
>> so "struct mii_bus" is needed and included by the header file phy.h,
>> the mdio.h is included by phy.h.
> 
> Don't rely on implicit includes. It leads to compile errors if headers
> are ever split/moved around. Just include mdio.h as you use it.
> 
okay, will include mdio.h

>>
>>>
>>>> +
>>>> +#include <dt-bindings/clock/qcom,qca8k-nsscc.h>
>>>> +#include <dt-bindings/reset/qcom,qca8k-nsscc.h>
>>>> +
>>>> +#include "clk-branch.h"
>>>> +#include "clk-rcg.h"
>>>> +#include "clk-regmap.h"
>>>> +#include "clk-regmap-divider.h"
>>>> +#include "clk-regmap-mux.h"
>>> [...]
>>>> +
>>>> +static const struct freq_tbl ftbl_nss_cc_mac5_rx_clk_src[] = {
>>>> +       F(50000000, P_XO, 1, 0, 0),
>>>> +       F(125000000, P_UNIPHY0_RX, 1, 0, 0),
>>>> +       F(125000000, P_UNIPHY0_TX, 1, 0, 0),
>>>> +       F(312500000, P_UNIPHY0_RX, 1, 0, 0),
>>>> +       F(312500000, P_UNIPHY0_TX, 1, 0, 0),
>>>
>>> This frequency table looks like the parent should change rate...
>>
>> Yes, the parent need to change the rate for the different interface
>> mode, PHY_INTERFACE_MODE_2500BASEX use 312.5M, PHY_INTERFACE_MODE_SGMII
>> use 125M.
>>
>>>
>>>> +       { }
>>>> +};
>>>> +
>>>> +static struct clk_rcg2 nss_cc_mac5_rx_clk_src = {
>>>> +       .cmd_rcgr = 0x154,
>>>> +       .freq_tbl = ftbl_nss_cc_mac5_rx_clk_src,
>>>> +       .hid_width = 5,
>>>> +       .parent_map = nss_cc_uniphy0_rx_tx_map,
>>>> +       .clkr.hw.init = &(const struct clk_init_data) {
>>>> +               .name = "nss_cc_mac5_rx_clk_src",
>>>> +               .parent_data = nss_cc_uniphy0_rx_tx_data,
>>>> +               .num_parents = ARRAY_SIZE(nss_cc_uniphy0_rx_tx_data),
>>>> +               .ops = &clk_rcg2_ops,
>>>
>>> ... but this doesn't have any CLK_SET_RATE_PARENT flag set. How does it
>>> work?
>>
>> since it has the different parent clock rate 312.5M and 125M for the
>> deffernet interface mode used. If the flag CLK_SET_RATE_PARENT is set,
>> when we require to configure 25M clock rate for example, it may lead to
>> the parent rate changed(312.5M/12.5 or 125M/5), which is not expected,
>> the parent rate(312.5M or 125M) can't be changed, since the parent rate
>> is decided by interface mode(PHY_INTERFACE_MODE_2500BASEX or
>> PHY_INTERFACE_MODE_SGMII).
>>
>> the work flow:
>> the parent of nss_cc_mac5_rx_clk_src is selected as 312.5M or 125M
>> firstly, then configure the required clock rate of clk_branch.
>>
>> uniphy(312.5M or 125M) ---> RCG(nss_cc_mac5_rx_clk_src) ---> clk_branch.
> 
> Ok. So you're saying that the uniphy rate changes outside of the clk
> framework? That is potentially troublesome because the clk framework
> aggressively caches things to the point that if the parent of the RCG
> changes rates the branch rate won't reflect the new rate. It looks like
> none of that really matters in practice because the divider is always 1
> here, but this will be confusing if a driver calls clk_get_rate() when
> the uniphy rate has changed.
> 
> Why can't that be driven from the clk framework? Or why can't the uniphy
> implement a clk provider that supports changing rates? If that was done,
> then a driver could change the uniphy rate and the clk framework would
> propagate the frequency down to all the children, recalculating the
> rates along the way. It may even mean that there's nothing to do when
> changing these clks, besides perhaps changing the parent?
> 

Hi Stephen,
Yes, the uniphy implements the clock provider that supports changing 
rate, which will be upstream later, and nss_cc_mac5_rx_clk_src is the 
special case, which is only used in the switch device qca8386.

For the phy device qca8084(uniphy has only 312.5M fix clock which is 
registered by device tree), this clock nss_cc_mac5_rx_clk_src is not used.

The issue for the switch device(qca8386) here is the clock rate of 
parent uniphy can't be changed because of the clock rate requirement of 
branch clock, since the uniphy clock rate is decided by the current 
working interface mode(PHY_INTERFACE_MODE_2500BASEX with 312.5M or 
PHY_INTERFACE_MODE_SGMII with 125M).

For example, when the uniphy works on PHY_INTERFACE_MODE_2500BASEX, then 
the parent uniphy clock rate is 312.5M, which is decided by hardware and 
can't be changed. when a branch clock requires a 25M clock, the parent 
uniphy clock maybe updated to 125M by clock framework if the flag 
CLK_SET_RATE_PARENT is set here, but the actual hardware clock rate of 
uniphy is still 315.5M since the uniphy still works in the interface 
mode PHY_INTERFACE_MODE_2500BASEX.


>>
>>>
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap_div nss_cc_mac5_rx_div_clk_src = {
>>>> +       .reg = 0x15c,
>>>> +       .shift = 0,
>>>> +       .width = 4,
>>>> +       .clkr = {
>>>> +               .hw.init = &(const struct clk_init_data) {
>>>> +                       .name = "nss_cc_mac5_rx_div_clk_src",
>>> [...]
>>>> +
>>>> +static struct clk_branch nss_cc_mdio_master_ahb_clk = {
>>>> +       .halt_reg = 0x19c,
>>>> +       .halt_check = BRANCH_HALT,
>>>> +       .clkr = {
>>>> +               .enable_reg = 0x19c,
>>>> +               .enable_mask = BIT(0),
>>>> +               .hw.init = &(const struct clk_init_data) {
>>>> +                       .name = "nss_cc_mdio_master_ahb_clk",
>>>> +                       .parent_hws = (const struct clk_hw *[]) {
>>>> +                               &nss_cc_ahb_clk_src.clkr.hw,
>>>> +                       },
>>>> +                       .num_parents = 1,
>>>> +                       .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>>>
>>> Why can't we simply enable clks in probe that are critical? The regmap
>>> operations are complicated?
>>
>> since these clocks with the flag CLK_IS_CRITICAL are the common clocks
>> needed to be enabled for all devices no matter what work mode(qca8084 or
>> qca8386) used, which is base clock to enable to use the clock driver, to
>> enable these clocks by using flag CLK_IS_CRITICAL is simplier way and
>> can simply the device probe driver and device tree definations.
> 
> Sure, but it also means you use the despised CLK_IS_CRITICAL flag when
> it could simply be some code in probe that sets some bits for "boot
> configuration". The benefit is that we don't register clks that do
> practically nothing besides use resources in the kernel for a one time
> operation at probe.
> 

Okay, that makes sense, i will remove this flag CLK_IS_CRITICAL, and 
enable these clocks in the probe function of the consumer driver.

Thanks Stephen for the review and suggestions!
>>
>>>
>>>> +};
>>>> +
>>>> +/* For each read/write operation of clock register, there are three MDIO frames
>>>> + * sent to the device.
>>>> + *
>>>> + * 1. The high address part[31:8] of register is packaged into the first MDIO frame.
>>>> + * 2. The low address part[7:0] of register is packaged into the second MDIO frame
>>>> + *    with the low 16bit data to read/write.
>>>> + * 3. The low address part[7:0] of register is packaged into the last MDIO frame
>>>> + *    with the high 16bit data to read/write.
>>>> + *
>>>> + * The clause22 MDIO frame format used by device is as below.
>>>> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>>> + * | ST| OP|   ADDR  |   REG   | TA|             DATA              |
>>>> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>>> + */
>>>> +static inline void split_addr(u32 regaddr, u16 *r1, u16 *r2, u16 *page)
>>>
>>> split_addr() is too generic of a name. Please namespace this function to
>>> something else.
>>
>> okay, maybe convert_reg_to_mii_addr?
> 
> Sure!
> 
>>>
>>>> +               *val |= ret << 16;
>>>> +       }
>>>> +
>>>> +       if (ret < 0)
>>>> +               dev_err_ratelimited(&bus->dev, "fail to read qca8k mii register\n");
>>>> +
>>>> +       return ret < 0 ? ret : 0;
>>>> +}
>>>> +
>>>> +void qca8k_mii_write(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u32 val)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       ret = bus->write(bus, switch_phy_id, reg, lower_16_bits(val));
>>>> +       if (ret >= 0)
>>>> +               ret = bus->write(bus, switch_phy_id, (reg | BIT(1)), upper_16_bits(val));
>>>> +
>>>> +       if (ret < 0)
>>>> +               dev_err_ratelimited(&bus->dev, "fail to write qca8k mii register\n");
>>>> +}
>>>> +
>>>> +int qca8k_mii_page_set(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u16 page)
>>>
>>> Regmap core has support for picking pages. Can that be used here?
>>
>> Hi Stephen,
>> No, we can't depend on regmap to pick the page, since the MDIO bus is
>> shared by qca8k device and PHY device, if there is a PHY device access,
>> even if the page is not changed, we still need to configure the page
>> again, so the page is alwasy configured for each register access, the
>> sequence can't be interrupted.
> 
> Ok.
> 
>>>
>>>> +};
>>>> +
>>>> +static const struct qcom_cc_desc nss_cc_qca8k_desc = {
>>>> +       .config = &nss_cc_qca8k_regmap_config,
>>>> +       .clks = nss_cc_qca8k_clocks,
>>>> +       .num_clks = ARRAY_SIZE(nss_cc_qca8k_clocks),
>>>> +       .resets = nss_cc_qca8k_resets,
>>>> +       .num_resets = ARRAY_SIZE(nss_cc_qca8k_resets),
>>>> +};
>>>> +
>>>> +static int nss_cc_qca8k_probe(struct mdio_device *mdiodev)
>>>> +{
>>>> +       struct regmap *regmap;
>>>> +
>>>> +       regmap = devm_regmap_init(&mdiodev->dev, NULL, mdiodev->bus, nss_cc_qca8k_desc.config);
>>>
>>> Why can't we use devm_regmap_init_mdio() here? Is it because the device
>>> needs special data marshaling per split_addr()?
>>
>> Hi Stephen,
>> No, we can't use devm_regmap_init_mdio, which is for the standard PHY
>> device access(clause22 and clause 45), but the clock device needs the
>> special MDIO sequences for the register access.
> 
> Ok.
