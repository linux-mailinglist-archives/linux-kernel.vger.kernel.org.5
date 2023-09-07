Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC3679797E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbjIGRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbjIGRPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:15:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DF11FE2;
        Thu,  7 Sep 2023 10:15:23 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3875JJSI002719;
        Thu, 7 Sep 2023 08:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zYSiZKcqjofmJB3YOsjeMHdm0Ui8NJbYbGJHWganPAk=;
 b=LqtRl3+hhykR60yVvNkcqly4x9jRKpl2n7Lx3yEUigwvTn1KCoWme9EpzgLUGpxgoUZT
 IY/0cD2B+oU49ggcg4qVARRc9h9D4tDJ2W80IaBRFWpp1iRhvyGP+FETUSooOlGzRlRw
 H7I+JVtEWpPQpFxOZXw7dADX/Ovve/xVFLeimvbzvxy82ay6dX6PC1jURYMVm0pumu9e
 MmmHOR2171pKKXMWvFXAw4oQ5GnuNS4IvugAH5oXJxRfWE52BFth6ZFD92yh7i2Y9974
 i+GuAPDr4iTAkY7RLRy217yqsA22pSVStgd0nfhAbNwfjcWXB3U7KRoWWE36mlCJMZh3 5Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxq23avp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 08:36:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3878av27027116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 08:36:57 GMT
Received: from [10.253.72.245] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 7 Sep
 2023 01:36:52 -0700
Message-ID: <16d09acf-7bdd-04ee-6faf-936c0366df03@quicinc.com>
Date:   Thu, 7 Sep 2023 16:36:50 +0800
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
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <27ae3297ad161fd67706db70b402db04.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VRxQAguK-7FX5pyDKWqIWXCfx-FVhl1m
X-Proofpoint-GUID: VRxQAguK-7FX5pyDKWqIWXCfx-FVhl1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070074
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2023 5:36 AM, Stephen Boyd wrote:
> Quoting Luo Jie (2023-09-01 02:18:23)
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 263e55d75e3f..785cb6eb514f 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -195,6 +195,14 @@ config IPQ_GCC_9574
>>            i2c, USB, SD/eMMC, etc. Select this for the root clock
>>            of ipq9574.
>>   
>> +config IPQ_NSSCC_QCA8K
>> +       tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
> 
> This needs to be limited by a depends.
> 
> 	depends on MDIO_BUS || COMPILE_TEST
> 
> perhaps?
> 
Yes, the driver depends on MDIO BUS, will add this depends in the next 
patchset.

>> +       help
>> +         Support for NSS(Network SubSystem) clock controller on
>> +         qca8386/qca8084 chip.
>> +         Say Y or M if you want to use network features of switch or
>> +         PHY device. Select this for the root clock of qca8k.
>> +
>>   config MSM_GCC_8660
>>          tristate "MSM8660 Global Clock Controller"
>>          depends on ARM || COMPILE_TEST
>> diff --git a/drivers/clk/qcom/nsscc-qca8k.c b/drivers/clk/qcom/nsscc-qca8k.c
>> new file mode 100644
>> index 000000000000..f9312735daf3
>> --- /dev/null
>> +++ b/drivers/clk/qcom/nsscc-qca8k.c
>> @@ -0,0 +1,2179 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
> 
> Is platform_device include used?
> 
will remove this.

>> +#include <linux/regmap.h>
>> +#include <linux/phy.h>
> 
> Is the phy include used? Where is the mdio.h include?

there is no PHY include, just the mdio_device is included, however the 
mii_bus->mdio_lock is needed by this clock controller.

so "struct mii_bus" is needed and included by the header file phy.h,
the mdio.h is included by phy.h.

> 
>> +
>> +#include <dt-bindings/clock/qcom,qca8k-nsscc.h>
>> +#include <dt-bindings/reset/qcom,qca8k-nsscc.h>
>> +
>> +#include "clk-branch.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>> +#include "clk-regmap-divider.h"
>> +#include "clk-regmap-mux.h"
> [...]
>> +
>> +static const struct freq_tbl ftbl_nss_cc_mac5_rx_clk_src[] = {
>> +       F(50000000, P_XO, 1, 0, 0),
>> +       F(125000000, P_UNIPHY0_RX, 1, 0, 0),
>> +       F(125000000, P_UNIPHY0_TX, 1, 0, 0),
>> +       F(312500000, P_UNIPHY0_RX, 1, 0, 0),
>> +       F(312500000, P_UNIPHY0_TX, 1, 0, 0),
> 
> This frequency table looks like the parent should change rate...

Yes, the parent need to change the rate for the different interface 
mode, PHY_INTERFACE_MODE_2500BASEX use 312.5M, PHY_INTERFACE_MODE_SGMII 
use 125M.

> 
>> +       { }
>> +};
>> +
>> +static struct clk_rcg2 nss_cc_mac5_rx_clk_src = {
>> +       .cmd_rcgr = 0x154,
>> +       .freq_tbl = ftbl_nss_cc_mac5_rx_clk_src,
>> +       .hid_width = 5,
>> +       .parent_map = nss_cc_uniphy0_rx_tx_map,
>> +       .clkr.hw.init = &(const struct clk_init_data) {
>> +               .name = "nss_cc_mac5_rx_clk_src",
>> +               .parent_data = nss_cc_uniphy0_rx_tx_data,
>> +               .num_parents = ARRAY_SIZE(nss_cc_uniphy0_rx_tx_data),
>> +               .ops = &clk_rcg2_ops,
> 
> ... but this doesn't have any CLK_SET_RATE_PARENT flag set. How does it
> work?

since it has the different parent clock rate 312.5M and 125M for the 
deffernet interface mode used. If the flag CLK_SET_RATE_PARENT is set, 
when we require to configure 25M clock rate for example, it may lead to 
the parent rate changed(312.5M/12.5 or 125M/5), which is not expected, 
the parent rate(312.5M or 125M) can't be changed, since the parent rate 
is decided by interface mode(PHY_INTERFACE_MODE_2500BASEX or 
PHY_INTERFACE_MODE_SGMII).

the work flow:
the parent of nss_cc_mac5_rx_clk_src is selected as 312.5M or 125M 
firstly, then configure the required clock rate of clk_branch.

uniphy(312.5M or 125M) ---> RCG(nss_cc_mac5_rx_clk_src) ---> clk_branch.

> 
>> +       },
>> +};
>> +
>> +static struct clk_regmap_div nss_cc_mac5_rx_div_clk_src = {
>> +       .reg = 0x15c,
>> +       .shift = 0,
>> +       .width = 4,
>> +       .clkr = {
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "nss_cc_mac5_rx_div_clk_src",
> [...]
>> +
>> +static struct clk_branch nss_cc_mdio_master_ahb_clk = {
>> +       .halt_reg = 0x19c,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x19c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(const struct clk_init_data) {
>> +                       .name = "nss_cc_mdio_master_ahb_clk",
>> +                       .parent_hws = (const struct clk_hw *[]) {
>> +                               &nss_cc_ahb_clk_src.clkr.hw,
>> +                       },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> 
> Why can't we simply enable clks in probe that are critical? The regmap
> operations are complicated?

since these clocks with the flag CLK_IS_CRITICAL are the common clocks 
needed to be enabled for all devices no matter what work mode(qca8084 or 
qca8386) used, which is base clock to enable to use the clock driver, to 
enable these clocks by using flag CLK_IS_CRITICAL is simplier way and 
can simply the device probe driver and device tree definations.

> 
>> +                       .ops = &clk_branch2_prepare_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static const struct clk_parent_data nss_cc_xo_data[] = {
>> +       { .index = DT_XO },
>> +};
>> +
>> +static const struct parent_map nss_cc_xo_map[] = {
>> +       { P_XO, 0 },
>> +};
>> +
>> +static const struct freq_tbl ftbl_nss_cc_sys_clk_src[] = {
>> +       F(25000000, P_XO, 2, 0, 0),
>> +       { }
>> +};
> [...]
>> +
>> +static const struct qcom_reset_map nss_cc_qca8k_resets[] = {
> [...]
>> +       [NSS_CC_GEPHY1_ARES] = { 0x304, 1 },
>> +       [NSS_CC_GEPHY2_ARES] = { 0x304, 2 },
>> +       [NSS_CC_GEPHY3_ARES] = { 0x304, 3 },
>> +       [NSS_CC_DSP_ARES] = { 0x304, 4 },
>> +       [NSS_CC_GLOBAL_ARES] = { 0x308, 0 },
>> +       [NSS_CC_XPCS_ARES] = { 0x30C, 0 },
> 
> Lowercase hex please.

will correct it.

> 
>> +};
>> +
>> +/* For each read/write operation of clock register, there are three MDIO frames
>> + * sent to the device.
>> + *
>> + * 1. The high address part[31:8] of register is packaged into the first MDIO frame.
>> + * 2. The low address part[7:0] of register is packaged into the second MDIO frame
>> + *    with the low 16bit data to read/write.
>> + * 3. The low address part[7:0] of register is packaged into the last MDIO frame
>> + *    with the high 16bit data to read/write.
>> + *
>> + * The clause22 MDIO frame format used by device is as below.
>> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>> + * | ST| OP|   ADDR  |   REG   | TA|             DATA              |
>> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>> + */
>> +static inline void split_addr(u32 regaddr, u16 *r1, u16 *r2, u16 *page)
> 
> split_addr() is too generic of a name. Please namespace this function to
> something else.

okay, maybe convert_reg_to_mii_addr?

> 
>> +{
>> +       *r1 = regaddr & 0x1c;
>> +
>> +       regaddr >>= 5;
>> +       *r2 = regaddr & 0x7;
>> +
>> +       regaddr >>= 3;
>> +       *page = regaddr & 0xffff;
> 
> Instead of this can you use FIELD_GET and have some macros for the part
> of the address? Something like
> 
> #define QCA8K_CLK_REG_MASK		GENMASK(4, 2)
> #define QCA8K_CLK_PHY_ADDR_MASK		GENMASK(7, 5)
> #define QCA8K_CLK_PAGE_MASK		GENMASK(24, 8)
> 
> and then rename 'r1' and 'r2' to something else?
> 
> 	*reg = FIELD_GET(QCA8K_CLK_REG_MASK, regaddr);
> 	*phy_addr = FIELD_GET(QCA8K_CLK_PHY_ADDR_MASK, regaddr) | QCA8K_LOW_ADDR_PREFIX;
> 	*page = FIELD_GET(QCA8K_CLK_PAGE_MASK);
> 
okay, thanks Stephen for the suggestion, will take this in the next 
patch set.

>> +}
>> +
>> +int qca8k_mii_read(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u32 *val)
>> +{
>> +       int ret;
>> +
>> +       ret = bus->read(bus, switch_phy_id, reg);
> 
> Why can't we use __mdiobus_read()?
> 

yes, we can use __mdiobus_read and will verify it, thanks.

>> +       if (ret >= 0) {
>> +               *val = ret;
>> +               ret = bus->read(bus, switch_phy_id, (reg | BIT(1)));
> 
> What is BIT(1)? Can it have a #define? What if ret is negative? We
> shouldn't treat that as data, right?

okay, will add the "#define DATA_UPPER_16_BITS BIT(1)"? which is for 
writing or reading upper 16 bit data when BIT(1) is set.

when the ret is negative, the ret should be not treated as data, will 
take this case into account in the next updated patch.

> 
>> +               *val |= ret << 16;
>> +       }
>> +
>> +       if (ret < 0)
>> +               dev_err_ratelimited(&bus->dev, "fail to read qca8k mii register\n");
>> +
>> +       return ret < 0 ? ret : 0;
>> +}
>> +
>> +void qca8k_mii_write(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u32 val)
>> +{
>> +       int ret;
>> +
>> +       ret = bus->write(bus, switch_phy_id, reg, lower_16_bits(val));
>> +       if (ret >= 0)
>> +               ret = bus->write(bus, switch_phy_id, (reg | BIT(1)), upper_16_bits(val));
>> +
>> +       if (ret < 0)
>> +               dev_err_ratelimited(&bus->dev, "fail to write qca8k mii register\n");
>> +}
>> +
>> +int qca8k_mii_page_set(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u16 page)
> 
> Regmap core has support for picking pages. Can that be used here?

Hi Stephen,
No, we can't depend on regmap to pick the page, since the MDIO bus is 
shared by qca8k device and PHY device, if there is a PHY device access, 
even if the page is not changed, we still need to configure the page 
again, so the page is alwasy configured for each register access, the 
sequence can't be interrupted.

> 
>> +{
>> +       int ret;
>> +
>> +       ret = bus->write(bus, switch_phy_id, reg, page);
>> +       if (ret < 0)
>> +               dev_err_ratelimited(&bus->dev, "fail to set page\n");
>> +
>> +       return ret;
>> +}
>> +
>> +int qca8k_regmap_read(void *context, unsigned int reg, unsigned int *val)
>> +{
>> +       struct mii_bus *bus = context;
>> +       u16 r1, r2, page;
>> +       int ret;
>> +
>> +       reg += QCA8K_CLK_REG_BASE;
>> +       split_addr(reg, &r1, &r2, &page);
>> +
>> +       mutex_lock(&bus->mdio_lock);
>> +       ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
>> +       if (ret < 0)
>> +               goto qca8k_read_exit;
>> +
>> +       ret = qca8k_mii_read(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
>> +
>> +qca8k_read_exit:
>> +       mutex_unlock(&bus->mdio_lock);
>> +       return ret;
>> +};
>> +
>> +int qca8k_regmap_write(void *context, unsigned int reg, unsigned int val)
> 
> These wrappers should be static. Please run sparse.

okay, will update this.

> 
>> +{
>> +       struct mii_bus *bus = context;
>> +       u16 r1, r2, page;
>> +       int ret;
>> +
>> +       reg += QCA8K_CLK_REG_BASE;
>> +       split_addr(reg, &r1, &r2, &page);
>> +
>> +       mutex_lock(&bus->mdio_lock);
>> +       ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
>> +       if (ret < 0)
>> +               goto qca8k_write_exit;
>> +
>> +       qca8k_mii_write(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
>> +
>> +qca8k_write_exit:
>> +       mutex_unlock(&bus->mdio_lock);
>> +       return ret;
>> +};
>> +
>> +int qca8k_regmap_update_bits(void *context, unsigned int reg, unsigned int mask, unsigned int value)
>> +{
>> +       struct mii_bus *bus = context;
>> +       u16 r1, r2, page;
>> +       int ret;
>> +       u32 val;
>> +
>> +       reg += QCA8K_CLK_REG_BASE;
>> +       split_addr(reg, &r1, &r2, &page);
>> +
>> +       mutex_lock(&bus->mdio_lock);
>> +       ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
>> +       if (ret < 0)
>> +               goto qca8k_update_exit;
>> +
>> +       ret = qca8k_mii_read(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, &val);
>> +       if (ret < 0)
>> +               goto qca8k_update_exit;
>> +
>> +       val &= ~mask;
>> +       val |= value;
>> +       qca8k_mii_write(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
>> +
>> +qca8k_update_exit:
>> +       mutex_unlock(&bus->mdio_lock);
>> +       return ret;
>> +}
>> +
>> +static const struct regmap_config nss_cc_qca8k_regmap_config = {
>> +       .reg_bits = 12,
>> +       .reg_stride = 4,
>> +       .val_bits = 32,
>> +       .max_register = 0x30C,
> 
> Lowercase hex please.

okay, will correct this.

> 
>> +       .reg_read = qca8k_regmap_read,
>> +       .reg_write = qca8k_regmap_write,
>> +       .reg_update_bits = qca8k_regmap_update_bits,
>> +       .disable_locking = true,
>> +       .cache_type = REGCACHE_NONE,
> 
> Isn't this the default?

yes, REGCACHE_NONE should be the default value, we can remove this line 
config.

> 
>> +};
>> +
>> +static const struct qcom_cc_desc nss_cc_qca8k_desc = {
>> +       .config = &nss_cc_qca8k_regmap_config,
>> +       .clks = nss_cc_qca8k_clocks,
>> +       .num_clks = ARRAY_SIZE(nss_cc_qca8k_clocks),
>> +       .resets = nss_cc_qca8k_resets,
>> +       .num_resets = ARRAY_SIZE(nss_cc_qca8k_resets),
>> +};
>> +
>> +static int nss_cc_qca8k_probe(struct mdio_device *mdiodev)
>> +{
>> +       struct regmap *regmap;
>> +
>> +       regmap = devm_regmap_init(&mdiodev->dev, NULL, mdiodev->bus, nss_cc_qca8k_desc.config);
> 
> Why can't we use devm_regmap_init_mdio() here? Is it because the device
> needs special data marshaling per split_addr()?

Hi Stephen,
No, we can't use devm_regmap_init_mdio, which is for the standard PHY 
device access(clause22 and clause 45), but the clock device needs the 
special MDIO sequences for the register access.

Thanks Stephen for your previous time and the detail review comments.

> 
>> +       if (IS_ERR(regmap))
>> +               return dev_err_probe(&mdiodev->dev, PTR_ERR(regmap), "Failed to init regmap\n");
>> +
>> +       return qcom_cc_really_probe(&mdiodev->dev, &nss_cc_qca8k_desc, regmap);
>> +}
>> +
