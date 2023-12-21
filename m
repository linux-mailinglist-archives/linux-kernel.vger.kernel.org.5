Return-Path: <linux-kernel+bounces-8208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D10881B3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E8C1C24592
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4336E2A1;
	Thu, 21 Dec 2023 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Z1imS8EF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3116DD0C;
	Thu, 21 Dec 2023 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BLAIA5j023361;
	Thu, 21 Dec 2023 11:31:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=99YJf+8k0EOTgNd7hulokQbW66/Zhks58YSOFbxIzr4=; b=Z1
	imS8EF3InYuxiSY/kECbMDOBUaFdAj9OnLX08a45a+Davt7scl4IJKmjKDxnESQK
	kRuRGydvWcZEnY5rIIOqdRhkJEZUAQJrHAOakmLO/dXGHApOtasrpse71OlUG70a
	GriChM/6p+fL4svvq/cvDCssFRKUxBQWwAy4a2mUXyrV0qu7N8pdaEo4M2MtEsZb
	1B2XZutX4AyWnmTItSFp/dVyJZ7nbM7iySTJxEcQiwZBsYSbpuWnQ1JMcoC1eNR4
	Q2xLPgj5Edq8ZbJ1kJLAAp/RxYEi066K57jPTQf2tJIbRflC4kLt2aY0MrSEJGhX
	hl6lOeknqyk2/LU5k0UQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v3q8104mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 11:31:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0FEFD100053;
	Thu, 21 Dec 2023 11:31:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EDF9524551B;
	Thu, 21 Dec 2023 11:31:54 +0100 (CET)
Received: from [10.201.21.240] (10.201.21.240) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Dec
 2023 11:31:54 +0100
Message-ID: <21f758cb-ae25-4d74-905c-0d4820f00070@foss.st.com>
Date: Thu, 21 Dec 2023 11:31:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] clk: stm32: introduce clocks for STM32MP257
 platform
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20231219130909.265091-1-gabriel.fernandez@foss.st.com>
 <20231219130909.265091-2-gabriel.fernandez@foss.st.com>
 <c98539f99030f174583d7ee36802b4b9.sboyd@kernel.org>
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <c98539f99030f174583d7ee36802b4b9.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_04,2023-12-20_01,2023-05-22_02


On 12/20/23 23:16, Stephen Boyd wrote:
> Quoting gabriel.fernandez@foss.st.com (2023-12-19 05:09:08)
>> diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-stm32mp25.c
>> new file mode 100644
>> index 000000000000..313e022c6142
>> --- /dev/null
>> +++ b/drivers/clk/stm32/clk-stm32mp25.c
>> @@ -0,0 +1,1826 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
>> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-stm32-core.h"
>> +#include "reset-stm32.h"
>> +#include "stm32mp25_rcc.h"
>> +
>> +#include <dt-bindings/clock/st,stm32mp25-rcc.h>
>> +#include <dt-bindings/reset/st,stm32mp25-rcc.h>
>> +
>> +static const struct clk_parent_data adc12_src[] = {
>> +       { .name = "ck_flexgen_46" },
> This is a new driver. Don't use .name here. Instead use .index or .hw
> and if that can't work then use .fw_name.

These parent clocks are managed by a secure world and exposed through SCMI.

If I use .index or .fw_name, do I have to expose 122 clocks in my DT node ?

This will significantly increase the size of the DT file

             clock-names = "hse", "hsi", ..., "ck_scmi_stm500";
             clocks = <&scmi_clk CK_SCMI_HSE>, <&scmi_clk CK_SCMI_HSI>,  
... ,   <&scmi_clk CK_SCMI_STM500>;

>
>> +       { .name = "ck_icn_ls_mcu" },
>> +};
>> +
>> +static const struct clk_parent_data adc3_src[] = {
>> +       { .name = "ck_flexgen_47" },
>> +       { .name = "ck_icn_ls_mcu" },
>> +       { .name = "ck_flexgen_46" },
>> +};
> [...]
>> +static struct clk_stm32_composite ck_ker_usb3pciephy = {
>> +       .gate_id = GATE_USB3PCIEPHY,
>> +       .mux_id = MUX_USB3PCIEPHY,
>> +       .div_id = NO_STM32_DIV,
>> +       .hw.init = CLK_HW_INIT_PARENTS_DATA("ck_ker_usb3pciephy", usb3pciphy_src,
>> +                                           &clk_stm32_composite_ops, 0),
>> +};
>> +
>> +/* USB3 DRD */
>> +static struct clk_stm32_gate ck_icn_m_usb3dr = {
>> +       .gate_id = GATE_USB3DR,
>> +       .hw.init = CLK_HW_INIT("ck_icn_m_usb3dr", "ck_icn_hsl", &clk_stm32_gate_ops, 0),
>> +};
>> +
>> +static struct clk_stm32_gate ck_ker_usb2phy2 = {
>> +       .gate_id = GATE_USB3DR,
>> +       .hw.init = CLK_HW_INIT("ck_ker_usb2phy2", "ck_flexgen_58", &clk_stm32_gate_ops, 0),
>> +};
>> +
>> +/* USBTC */
>> +static struct clk_stm32_gate ck_icn_p_usbtc = {
>> +       .gate_id = GATE_USBTC,
>> +       .hw.init = CLK_HW_INIT("ck_icn_p_usbtc", "ck_icn_apb4", &clk_stm32_gate_ops, 0),
> Please stop using strings to match parents, i.e. don't use CLK_HW_INIT.
>
>> +};
>> +
>> +static struct clk_stm32_gate ck_ker_usbtc = {
>> +       .gate_id = GATE_USBTC,
>> +       .hw.init = CLK_HW_INIT("ck_ker_usbtc", "ck_flexgen_35", &clk_stm32_gate_ops, 0),
>> +};
>> +
>> +/* VDEC / VENC */
>> +static struct clk_stm32_gate ck_icn_p_vdec = {
>> +       .gate_id = GATE_VDEC,
>> +       .hw.init = CLK_HW_INIT("ck_icn_p_vdec", "ck_icn_apb4", &clk_stm32_gate_ops, 0),
>> +};
>> +
>> +static struct clk_stm32_gate ck_icn_p_venc = {
>> +       .gate_id = GATE_VENC,
>> +       .hw.init = CLK_HW_INIT("ck_icn_p_venc", "ck_icn_apb4", &clk_stm32_gate_ops, 0),
>> +};
>> +
>> +/* VREF */
>> +static struct clk_stm32_gate ck_icn_p_vref = {
>> +       .gate_id = GATE_VREF,
>> +       .hw.init = CLK_HW_INIT("ck_icn_p_vref", "ck_icn_apb3", &clk_stm32_gate_ops, 0),
>> +};
>> +
>> +/* WWDG */
>> +static struct clk_stm32_gate ck_icn_p_wwdg1 = {
>> +       .gate_id = GATE_WWDG1,
>> +       .hw.init = CLK_HW_INIT("ck_icn_p_wwdg1", "ck_icn_apb3", &clk_stm32_gate_ops, 0),
>> +};
>> +
>> +static struct clk_stm32_gate ck_icn_p_wwdg2 = {
>> +       .gate_id = GATE_WWDG2,
>> +       .hw.init = CLK_HW_INIT("ck_icn_p_wwdg2", "ck_icn_ls_mcu", &clk_stm32_gate_ops, 0),
>> +};
>> +
>> +enum security_clk {
>> +       SECF_NONE,
> What is the use of this single value enum?

Yes, just a define is enough for the moment. I will have more 
definitions in my next series to introduce

security (clocks could be managed by a secure world or not).

>> +};
>> +
>> +static const struct clock_config stm32mp25_clock_cfg[] = {
>> +       STM32_GATE_CFG(CK_BUS_ETH1,             ck_icn_p_eth1,          SECF_NONE),
>> +       STM32_GATE_CFG(CK_BUS_ETH2,             ck_icn_p_eth2,          SECF_NONE),
> [....]
>> +
>> +static const struct of_device_id stm32mp25_match_data[] = {
>> +       {
>> +               .compatible = "st,stm32mp25-rcc",
>> +               .data = &stm32mp25_data,
>> +       },
> One line please:
>
>   	{ .compatible = "st,stm32mp25-rcc", .data = &stm32mp25_data, },

ok

>
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, stm32mp25_match_data);
>> +
>> +static int get_clock_deps(struct device *dev)
> What is the explanation for this function?

It 's to manage the dependency with the SCMI clock driver.


>> +{
>> +       static const char * const clock_deps_name[] = {
>> +               "hsi", "hse", "msi", "lsi", "lse",
>> +       };
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(clock_deps_name); i++) {
>> +               struct clk *clk;
>> +
>> +               clk = of_clk_get_by_name(dev_of_node(dev), clock_deps_name[i]);
>> +               if (IS_ERR(clk))
>> +                       return PTR_ERR(clk);
>> +
>> +               clk_put(clk);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       void __iomem *base;
>> +       int ret;
>> +
>> +       ret = get_clock_deps(dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       base = devm_of_iomap(dev, dev->of_node, 0, NULL);
> Use platform device APIs.
>
>> +       if (WARN_ON(IS_ERR(base)))
>> +               return PTR_ERR(base);
>> +
>> +       return stm32_rcc_init(dev, stm32mp25_match_data, base);
>> +}
>> +
>> +static int stm32mp25_rcc_clocks_remove(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *child, *np = dev_of_node(dev);
>> +
>> +       for_each_available_child_of_node(np, child)
>> +               of_clk_del_provider(child);
> Add the providers with devm?

ok


>
>> +
>> +       return 0;
>> +}
>> +
>> +static struct platform_driver stm32mp25_rcc_clocks_driver = {
>> +       .driver = {
>> +               .name = "stm32mp25_rcc",
>> +               .of_match_table = stm32mp25_match_data,
>> +       },
>> +       .probe = stm32mp25_rcc_clocks_probe,
>> +       .remove = stm32mp25_rcc_clocks_remove,
>> +};
>> +
>> +static int __init stm32mp25_clocks_init(void)
>> +{
>> +       return platform_driver_register(&stm32mp25_rcc_clocks_driver);
>> +}
>> +
>> +core_initcall(stm32mp25_clocks_init);

