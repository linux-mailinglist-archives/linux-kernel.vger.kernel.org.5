Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB075949F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGSLuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGSLuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:50:19 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612F210F1;
        Wed, 19 Jul 2023 04:50:16 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id C5A93100003;
        Wed, 19 Jul 2023 14:50:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C5A93100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689767414;
        bh=z/jbGOTt+7VfAj6Tdynwsy0zz1fBEl7P/RUmxJ8lhGk=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=QVfD+kSSXGV3jE3kAUyOQqvkAolU49V54Vdbvdqq2cflGHAyqVI+/UdPJFbynfe4u
         ZvDMdcC1syoEkaFEr2XewLJPy68nvfpKNSnAksHT087GZCN2czZqWuh9gc64i8woz2
         WlZJCdtq6mphlfVZXrJJ0ChHnkNlA84DhhROMjoIWq/E6439v+oM0/iUugWpKyiUmY
         3uzKQYKkstZ6DPLf7E5ZJwzo+UHjGSn22lLlbdnvLUn4VY7P49KSCEdoDhtXH6fz4N
         E43EXA7rBuWgRRldS+cd8BA8Tak/TIZj8XMPqbDbIaGWMWDoH2T+Zwa8kLeudO85kl
         5rCsjewdNiB5A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 19 Jul 2023 14:50:14 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 14:50:14 +0300
Date:   Wed, 19 Jul 2023 14:50:14 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     zelong dong <zelong.dong@amlogic.com>, <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <kelvin.zhang@amlogic.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible and DT
 bindings for Amlogic C3 Reset Controller
Message-ID: <20230719115014.2har4sool7d5edcn@CAB-WSD-L081021>
References: <20230719060954.14864-1-zelong.dong@amlogic.com>
 <20230719060954.14864-2-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719060954.14864-2-zelong.dong@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178721 [Jul 19 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 524 524 9753033d6953787301affc41bead8ed49c47b39d, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lists.infradead.org:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;www.kernel.org:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/19 06:59:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/19 07:00:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/19 06:48:00 #21640303
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 02:09:52PM +0800, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add new compatible and DT bindings for Amlogic C3 Reset Controller
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> ---
>  .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
>  include/dt-bindings/reset/amlogic,c3-reset.h  | 119 ++++++++++++++++++
>  2 files changed, 120 insertions(+)

As I understand it, updates to DT bindings documentation, as well as any
DT bindings includes, should be submitted in separate patches, per the
guidelines outlined in the following link:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters.

Krzysztof, Rob, and Conor, please correct me if I am mistaken.

>  create mode 100644 include/dt-bindings/reset/amlogic,c3-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> index d3fdee89d4f8..f0c6c0df0ce3 100644
> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> @@ -18,6 +18,7 @@ properties:
>        - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
>        - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>        - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
> +      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>  
>    reg:
>      maxItems: 1
> diff --git a/include/dt-bindings/reset/amlogic,c3-reset.h b/include/dt-bindings/reset/amlogic,c3-reset.h
> new file mode 100644
> index 000000000000..d9127863f603
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,c3-reset.h
> @@ -0,0 +1,119 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_C3_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_C3_RESET_H
> +
> +/* RESET0 */
> +/*						0-3 */
> +#define RESET_USBCTRL				4
> +/*						5-7 */
> +#define RESET_USBPHY20				8
> +/*						9 */
> +#define RESET_USB2DRD				10
> +#define RESET_MIPI_DSI_HOST			11
> +#define RESET_MIPI_DSI_PHY			12
> +/*						13-20 */
> +#define RESET_GE2D				21
> +#define RESET_DWAP				22
> +/*						23-31 */
> +
> +/* RESET1 */
> +#define RESET_AUDIO				32
> +/*						33-34 */
> +#define RESET_DDRAPB				35
> +#define RESET_DDR				36
> +#define RESET_DOS_CAPB3				37
> +#define RESET_DOS				38
> +/*						39-46 */
> +#define RESET_NNA				47
> +#define RESET_ETHERNET				48
> +#define RESET_ISP				49
> +#define RESET_VC9000E_APB			50
> +#define RESET_VC9000E_A				51
> +/*						52 */
> +#define RESET_VC9000E_CORE			53
> +/*						54-63 */
> +
> +/* RESET2 */
> +#define RESET_ABUS_ARB				64
> +#define RESET_IRCTRL				65
> +/*						66 */
> +#define RESET_TEMP_PII				67
> +/*						68-72 */
> +#define RESET_SPICC_0				73
> +#define RESET_SPICC_1				74
> +#define RESET_RSA				75
> +
> +/*						76-79 */
> +#define RESET_MSR_CLK				80
> +#define RESET_SPIFC				81
> +#define RESET_SAR_ADC				82
> +/*						83-87 */
> +#define RESET_ACODEC				88
> +/*						89-90 */
> +#define RESET_WATCHDOG				91
> +/*						92-95 */
> +
> +/* RESET3 */
> +#define RESET_ISP_NIC_GPV			96
> +#define RESET_ISP_NIC_MAIN			97
> +#define RESET_ISP_NIC_VCLK			98
> +#define RESET_ISP_NIC_VOUT			99
> +#define RESET_ISP_NIC_ALL			100
> +#define RESET_VOUT				101
> +#define RESET_VOUT_VENC				102
> +/*						103 */
> +#define RESET_CVE_NIC_GPV			104
> +#define RESET_CVE_NIC_MAIN			105
> +#define RESET_CVE_NIC_GE2D			106
> +#define RESET_CVE_NIC_DW			106
> +#define RESET_CVE_NIC_CVE			108
> +#define RESET_CVE_NIC_ALL			109
> +#define RESET_CVE				110
> +/*						112-127 */
> +
> +/* RESET4 */
> +#define RESET_RTC				128
> +#define RESET_PWM_AB				129
> +#define RESET_PWM_CD				130
> +#define RESET_PWM_EF				131
> +#define RESET_PWM_GH				132
> +#define RESET_PWM_IJ				133
> +#define RESET_PWM_KL				134
> +#define RESET_PWM_MN				135
> +/*						136-137 */
> +#define RESET_UART_A				138
> +#define RESET_UART_B				139
> +#define RESET_UART_C				140
> +#define RESET_UART_D				141
> +#define RESET_UART_E				142
> +#define RESET_UART_F				143
> +#define RESET_I2C_S_A				144
> +#define RESET_I2C_M_A				145
> +#define RESET_I2C_M_B				146
> +#define RESET_I2C_M_C				147
> +#define RESET_I2C_M_D				148
> +/*						149-151 */
> +#define RESET_SD_EMMC_A				152
> +#define RESET_SD_EMMC_B				153
> +#define RESET_SD_EMMC_C				154
> +
> +/* RESET5 */
> +/*						160-172 */
> +#define RESET_BRG_NIC_NNA			173
> +#define RESET_BRG_MUX_NIC_MAIN			174
> +#define RESET_BRG_AO_NIC_ALL			175
> +/*						176-183 */
> +#define RESET_BRG_NIC_VAPB			184
> +#define RESET_BRG_NIC_SDIO_B			185
> +#define RESET_BRG_NIC_SDIO_A			186
> +#define RESET_BRG_NIC_EMMC			187
> +#define RESET_BRG_NIC_DSU			188
> +#define RESET_BRG_NIC_SYSCLK			189
> +#define RESET_BRG_NIC_MAIN			190
> +#define RESET_BRG_NIC_ALL			191
> +
> +#endif
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
