Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B107B6B55
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbjJCOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbjJCOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:22:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B38DA;
        Tue,  3 Oct 2023 07:22:28 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393DY2E7022458;
        Tue, 3 Oct 2023 14:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=33hDEjn26IoY0UwO9m13o3FDWUvndMGMRpZb2amAhyc=;
 b=TLkQZL9VRq3dIBNTTrp7CZ6M2IoiMrr1Afu5YkuNRiUNUNal++CbI2GlkmJ1tzMtfBhT
 YSdqcOhKj/TGt3vUE0R9ZfJvP1V5OBhm6mnmrwMGrZ2617bNYjM5WCN3b0gofPNKB4Kj
 ULjrQWl0xm7CV1HYJHPvnzAELq9gUTh7QfNDWddERNrlwkassDAtT8ADwH5bXNBUSzBm
 LqxAcOaJi77idrf5oWQGvfVdxw2FRsP2MsUejN9Pp/xQybwTO7LSRdLD3xwYK6/MW3WO
 6j9fB+KjCbcncCG83x/DX817Q0mpgTi9zyKlLmOTOf1zGdZxCXc6fAADH7qVCLu7wh+M fg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg1v3ae7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 14:21:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393ELuRq015613
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 14:21:56 GMT
Received: from [10.216.32.208] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 3 Oct
 2023 07:21:46 -0700
Message-ID: <7975c638-29cf-45ce-9d76-b8a93d750eb7@quicinc.com>
Date:   Tue, 3 Oct 2023 19:51:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] phy: qcom: Introduce Super-Speed USB UNIPHY driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_kathirav@quicinc.com>, <quic_nsekar@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-3-quic_ipkumar@quicinc.com>
 <412492d1-fcc9-481c-9d28-b208a644ba1d@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <412492d1-fcc9-481c-9d28-b208a644ba1d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PQ6R0Ov6kkmUg4xQywtKaqns5mIc1-ai
X-Proofpoint-ORIG-GUID: PQ6R0Ov6kkmUg4xQywtKaqns5mIc1-ai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=802 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2023 10:48 PM, Dmitry Baryshkov wrote:
> On 29/09/2023 11:42, Praveenkumar I wrote:
>> Adds Qualcomm 22ull Super-Speed USB UNIPHY driver support which
>> is present in Qualcomm IPQ5332 SoC. This PHY is interfaced with
>> SNPS DWC3 USB and SNPS DWC PCIe. Either one of the interface
>> can use the it and selection is done via mux present in TCSR
>> register. This driver selects the PHY for DWC3 USB and handles
>> the reset, clocks and regulator.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/Kconfig               |  11 +
>>   drivers/phy/qualcomm/Makefile              |   1 +
>>   drivers/phy/qualcomm/phy-qcom-uniphy-usb.c | 322 +++++++++++++++++++++
>>   3 files changed, 334 insertions(+)
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
>>
>> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
>> index d891058b7c39..7257c8455c53 100644
>> --- a/drivers/phy/qualcomm/Kconfig
>> +++ b/drivers/phy/qualcomm/Kconfig
>> @@ -154,6 +154,17 @@ config PHY_QCOM_M31_USB
>>         management. This driver is required even for peripheral only or
>>         host only mode configurations.
>>   +config PHY_QCOM_UNIPHY_USB
>> +    tristate "Qualcomm USB Super-Speed UNIPHY driver"
>
> Can we please have more specific driver name? As I wrote earlier, 
> there are two other (different) kinds of Qualcomm UNI PHY devices:
> - DSI / HDMI UNIPHY on apq8064 / msm8974 / msm8960 (?)
> - USB QMP UNI PHY drivers
>
> Adding a driver called UNIPHY, which is not related to those two kinds 
> sounds pretty confusing to me.
This UNIPHY is different from above mentioned ones. This a custom 
version for 22nm on Qualcomm IPQ5332.
Can we name the driver as phy-qcom-uniphy-usb-ss-22ull.c / 
phy-qcom-usb-ss-22ull.c ?
>
>> +    depends on USB && (ARCH_QCOM || COMPILE_TEST)
>> +    select GENERIC_PHY
>> +    help
>> +      Enable this to support the Qualcomm USB Super-Speed UNIPHY 
>> transceiver
>> +      with DWC3 USB core. It handles PHY initialization, clock
>> +      management required after resetting the hardware and power
>> +      management. This driver is required even for peripheral only or
>> +      host only mode configurations.
>> +
>>   config PHY_QCOM_USB_HS
>>       tristate "Qualcomm USB HS PHY module"
>>       depends on USB_ULPI_BUS
>> diff --git a/drivers/phy/qualcomm/Makefile 
>> b/drivers/phy/qualcomm/Makefile
>> index ffd609ac6233..c3e0112a7a70 100644
>> --- a/drivers/phy/qualcomm/Makefile
>> +++ b/drivers/phy/qualcomm/Makefile
>> @@ -17,6 +17,7 @@ obj-$(CONFIG_PHY_QCOM_QMP_USB_LEGACY)    += 
>> phy-qcom-qmp-usb-legacy.o
>>   obj-$(CONFIG_PHY_QCOM_QUSB2)        += phy-qcom-qusb2.o
>>   obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2)    += phy-qcom-snps-eusb2.o
>>   obj-$(CONFIG_PHY_QCOM_EUSB2_REPEATER)    += phy-qcom-eusb2-repeater.o
>> +obj-$(CONFIG_PHY_QCOM_UNIPHY_USB)    += phy-qcom-uniphy-usb.o
>>   obj-$(CONFIG_PHY_QCOM_USB_HS)         += phy-qcom-usb-hs.o
>>   obj-$(CONFIG_PHY_QCOM_USB_HSIC)     += phy-qcom-usb-hsic.o
>>   obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)    += phy-qcom-usb-hs-28nm.o
>> diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-usb.c 
>> b/drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
>> new file mode 100644
>> index 000000000000..fdfc9c225995
>> --- /dev/null
>> +++ b/drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
>
> So, is it a USB PHY or UNI PHY (where I would expect that it handles 
> USB and PCIe?)
It is a USB PHY and the PHY name is UNIPHY. Added the usb in the file 
name to differentiate it.
>
>> @@ -0,0 +1,322 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/reset.h>
>> +
>> +#define PCIE_USB_COMBO_PHY_CFG_MISC1        0x214
>> +#define PCIE_USB_COMBO_PHY_CFG_RX_AFE_2        0x7C4
>> +#define PCIE_USB_COMBO_PHY_CFG_RX_DLF_DEMUX_2    0x7E8
>> +
>> +/* TCSR_USB_MUX_SEL regiter bits */
>> +#define TCSR_USB_MUX_SEL                BIT(0)
>> +
>> +struct phy_init_tbl {
>> +    unsigned int offset;
>> +    unsigned int val;
>> +};
>> +
>> +#define PHY_INIT_CFG(o, v)        \
>> +    {                \
>> +        .offset = o,        \
>> +        .val = v,        \
>> +    }
>> +
>> +static const struct phy_init_tbl ipq5332_usb_uniphy_init_tbl[] = {
>> +    PHY_INIT_CFG(PCIE_USB_COMBO_PHY_CFG_RX_AFE_2, 0x1076),
>> +    PHY_INIT_CFG(PCIE_USB_COMBO_PHY_CFG_RX_DLF_DEMUX_2, 0x3142),
>> +    PHY_INIT_CFG(PCIE_USB_COMBO_PHY_CFG_MISC1, 0x3),
>> +};
>
> We already have this issue in QMP drivers. Could you please move data 
> definitions to come after all struct definitions?
Sure, will move this definitions.
>
>> +
>> +struct uniphy_cfg {
>> +    const struct phy_init_tbl *init_seq;
>> +    int num_init_seq;
>> +};
>> +
>> +struct uniphy_usb {
>> +    struct device        *dev;
>> +    const struct uniphy_cfg    *cfg;
>> +    struct phy        *phy;
>> +    void __iomem        *base;
>> +    struct clk_bulk_data    *clks;
>> +    unsigned int        num_clks;
>> +    struct reset_control    *reset;
>> +    struct regulator    *vreg;
>> +    struct clk_fixed_rate    pipe_clk_fixed;
>> +    struct regmap        *tcsr;
>> +    unsigned int        usb_mux_offset;
>> +};
>> +
>> +static const struct uniphy_cfg ipq5332_usb_uniphy_cfg = {
>> +    .init_seq    = ipq5332_usb_uniphy_init_tbl,
>> +    .num_init_seq    = ARRAY_SIZE(ipq5332_usb_uniphy_init_tbl),
>> +};
>> +
>> +static int uniphy_usb_mux_enable(struct uniphy_usb *uniphy, bool 
>> enable)
>> +{
>> +    struct device *dev = uniphy->dev;
>> +    unsigned int val;
>> +    int ret;
>> +
>> +    if (!uniphy->tcsr)
>> +        return -EINVAL;
>> +
>> +    ret = regmap_read(uniphy->tcsr, uniphy->usb_mux_offset, &val);
>> +    if (ret) {
>> +        dev_err(dev, "Mux read failed: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    val = enable ? (val | TCSR_USB_MUX_SEL) : (val & 
>> ~TCSR_USB_MUX_SEL);
>> +    ret = regmap_write(uniphy->tcsr, uniphy->usb_mux_offset, val);
>
> regmap_update_bits()
Will update.
>
>> +    if (ret) {
>> +        dev_err(dev, "Mux write failed: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int uniphy_usb_init(struct phy *phy)
>> +{
>> +    struct uniphy_usb *uniphy = phy_get_drvdata(phy);
>> +    const struct uniphy_cfg *cfg = uniphy->cfg;
>> +    const struct phy_init_tbl *tbl = cfg->init_seq;
>> +    void __iomem *base = uniphy->base;
>> +    struct device *dev = uniphy->dev;
>> +    int i, ret;
>> +
>> +    ret = regulator_enable(uniphy->vreg);
>> +    if (ret) {
>> +        dev_err(dev, "failed to enable regulator, %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    /* Perform phy reset */
>> +    reset_control_assert(uniphy->reset);
>> +    usleep_range(1, 5);
>> +    reset_control_deassert(uniphy->reset);
>
> Error checkig, please.
Sure, will add.
>
>> +
>> +    ret = uniphy_usb_mux_enable(uniphy, true);
>> +    if (ret < 0)
>> +        goto err_assert_reset;
>> +
>> +    ret = clk_bulk_prepare_enable(uniphy->num_clks, uniphy->clks);
>> +    if (ret) {
>> +        dev_err(dev, "failed to enable clocks: %d\n", ret);
>> +        goto err_assert_reset;
>> +    }
>> +
>> +    /* phy autoload delay */
>> +    usleep_range(35, 40);
>> +
>> +    for (i = 0; i < cfg->num_init_seq; i++)
>> +        writel(tbl[i].val, base + tbl[i].offset);
>> +
>> +    return 0;
>> +
>> +err_assert_reset:
>> +    /* Assert phy reset */
>> +    reset_control_assert(uniphy->reset);
>> +
>> +    return ret;
>> +}
>> +
>> +static int uniphy_usb_shutdown(struct phy *phy)
>> +{
>> +    struct uniphy_usb *uniphy = phy_get_drvdata(phy);
>> +
>> +    clk_bulk_disable_unprepare(uniphy->num_clks, uniphy->clks);
>> +
>> +    uniphy_usb_mux_enable(uniphy, false);
>> +
>> +    /* Assert phy reset */
>> +    reset_control_assert(uniphy->reset);
>> +
>> +    regulator_disable(uniphy->vreg);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct phy_ops uniphy_usb_ops = {
>> +    .power_on    = uniphy_usb_init,
>> +    .power_off    = uniphy_usb_shutdown,
>> +    .owner        = THIS_MODULE,
>> +};
>> +
>> +static int qcom_uniphy_usb_mux_init(struct uniphy_usb *uniphy)
>
> Inline this function please.
Will do.
>
>> +{
>> +    struct device *dev = uniphy->dev;
>> +    int ret;
>> +
>> +    uniphy->tcsr = 
>> syscon_regmap_lookup_by_phandle_args(dev->of_node, 
>> "qcom,phy-usb-mux-sel",
>> +                                1, &uniphy->usb_mux_offset);
>> +    if (IS_ERR(uniphy->tcsr)) {
>> +        ret = PTR_ERR(uniphy->tcsr);
>> +        uniphy->tcsr = NULL;
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_uniphy_usb_clk_init(struct uniphy_usb *uniphy)
>
> Inline
Will do.
>
>> +{
>> +    struct device *dev = uniphy->dev;
>> +    int ret;
>> +
>> +    ret = devm_clk_bulk_get_all(dev, &uniphy->clks);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    uniphy->num_clks = ret;
>> +
>> +    return 0;
>> +}
>> +
>> +static void phy_clk_release_provider(void *res)
>> +{
>> +    of_clk_del_provider(res);
>> +}
>> +
>> +/*
>> + * Register a fixed rate pipe clock.
>> + *
>> + * The <s>_pipe_clksrc generated by PHY goes to the GCC that gate
>> + * controls it. The <s>_pipe_clk coming out of the GCC is requested
>> + * by the PHY driver for its operations.
>> + * We register the <s>_pipe_clksrc here. The gcc driver takes care
>> + * of assigning this <s>_pipe_clksrc as parent to <s>_pipe_clk.
>> + * Below picture shows this relationship.
>> + *
>> + *         +---------------+
>> + *         |   PHY block |<<---------------------------------------+
>> + *         | |                                         |
>> + *         |   +-------+   | +-----+               |
>> + *   I/P---^-->|  PLL  |---^--->pipe_clksrc--->| GCC |--->pipe_clk---+
>> + *    clk  |   +-------+   |                   +-----+
>> + *         +---------------+
>> + */
>> +static int phy_pipe_clk_register(struct uniphy_usb *uniphy, struct 
>> device_node *np)
>> +{
>> +    struct clk_fixed_rate *fixed = &uniphy->pipe_clk_fixed;
>> +    struct device *dev = uniphy->dev;
>> +    struct clk_init_data init = { };
>> +    int ret;
>> +
>> +    ret = of_property_read_string(np, "clock-output-names", 
>> &init.name);
>> +    if (ret) {
>> +        dev_err(dev, "%pOFn: No clock-output-names\n", np);
>> +        return ret;
>> +    }
>> +
>> +    init.ops = &clk_fixed_rate_ops;
>> +
>> +    fixed->fixed_rate = 250000000;
>> +    fixed->hw.init = &init;
>> +
>> +    ret = devm_clk_hw_register(dev, &fixed->hw);
>
> devm_clk_hw_register_fixed_rate()
Will change.
>
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fixed->hw);
>> +    if (ret)
>> +        return ret;
>> +
>> +    return devm_add_action_or_reset(dev, phy_clk_release_provider, np);
>
> devm_of_clk_add_hw_provider().
Will change.
>
>> +}
>> +
>> +static int qcom_uniphy_usb_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct phy_provider *phy_provider;
>> +    struct uniphy_usb *uniphy;
>> +    struct device_node *np;
>> +    int ret;
>> +
>> +    uniphy = devm_kzalloc(dev, sizeof(*uniphy), GFP_KERNEL);
>> +    if (!uniphy)
>> +        return -ENOMEM;
>> +
>> +    uniphy->dev = dev;
>> +
>> +    uniphy->cfg = of_device_get_match_data(dev);
>> +    if (!uniphy->cfg)
>> +        return -EINVAL;
>> +
>> +    uniphy->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(uniphy->base))
>> +        return PTR_ERR(uniphy->base);
>> +
>> +    ret = qcom_uniphy_usb_clk_init(uniphy);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret, "failed to get clock\n");
>> +
>> +    ret = qcom_uniphy_usb_mux_init(uniphy);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret, "failed to get USB mux\n");
>> +
>> +    uniphy->reset = devm_reset_control_get_exclusive_by_index(dev, 0);
>> +    if (IS_ERR(uniphy->reset))
>> +        return dev_err_probe(dev, PTR_ERR(uniphy->reset), "failed to 
>> get reset\n");
>> +
>> +    uniphy->vreg = devm_regulator_get_exclusive(dev, "vdd");
>
> Why do you need the exclusive control here?
Will change it to devm_regulator_get().
>
>> +    if (IS_ERR(uniphy->vreg))
>> +        return dev_err_probe(dev, PTR_ERR(uniphy->phy), "failed to 
>> get vreg\n");
>> +
>> +    np = of_node_get(dev->of_node);
>
> No need to get/put it, just use dev->of_node directly.
Sure, will change it.
>
>> +    ret = phy_pipe_clk_register(uniphy, np);
>> +    if (ret) {
>> +        dev_err_probe(dev, ret, "failed to register pipe clk\n");
>> +        goto err;
>> +    }
>> +
>> +    uniphy->phy = devm_phy_create(dev, NULL, &uniphy_usb_ops);
>> +    if (IS_ERR(uniphy->phy)) {
>> +        ret = PTR_ERR(uniphy->phy);
>> +        dev_err_probe(dev, ret, "failed to create PHY\n");
>> +        goto err;
>> +    }
>> +
>> +    phy_set_drvdata(uniphy->phy, uniphy);
>> +
>> +    phy_provider = devm_of_phy_provider_register(dev, 
>> of_phy_simple_xlate);
>> +
>> +    ret = PTR_ERR_OR_ZERO(phy_provider);
>> +
>> +err:
>> +    of_node_put(np);
>> +    return ret;
>> +}
>> +
>> +static const struct of_device_id qcom_uniphy_usb_of_match[] = {
>> +    { .compatible = "qcom,ipq5332-usb-uniphy", .data = 
>> &ipq5332_usb_uniphy_cfg},
>> +    { },
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_uniphy_usb_of_match);
>> +
>> +static struct platform_driver qcom_uniphy_usb_driver = {
>> +    .probe    = qcom_uniphy_usb_probe,
>> +    .driver = {
>> +        .of_match_table    = qcom_uniphy_usb_of_match,
>> +        .name  = "qcom,uniphy-usb",
>> +    }
>> +};
>> +module_platform_driver(qcom_uniphy_usb_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm Super-Speed USB UNIPHY driver");
>> +MODULE_LICENSE("GPL");
>
--
Thanks,
Praveenkumar
