Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326D88065DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376351AbjLFDun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjLFDum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:50:42 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2016.outbound.protection.outlook.com [40.92.45.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFEED40;
        Tue,  5 Dec 2023 19:50:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM3teHhSxqVhrJX9hTtfJWRqgeP3v3l2jGmcr7Q9ZCX/eW931dsmUP1yOunynS4WgFpE0r356FxZgu+dDZQj57nATqQWR5Fc7cICpH748KYRZo0oOFL4fG4ZQO9nxI4IqTolwpgXYg8O2eijQMr74JtTgbqTGu7140Aa6CsKusSnFdxYeOnaE9AJoxTp0HLm6FhK7BR8YnFBREyBAsFyxbSln8SeEvTUCRu+dwu8MntBBjp8x0SirVqD0TTb4pzulU+rgTYHtelfxiTVn8sIZeNq8QqFz+i7OP3YmQdmdMOiRsRonlrt7GrKfXbHlfD/e+CsxpA9+lE/nA7tiUzN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG/6z50X6p6ppi7eA/sSq2w5wF7VvOa5gNSKjBMobFQ=;
 b=mpRNA+oUfTanNl7lcrqiGpiBV23QNzdKkeU6QsuFTZoOfdQrTeU+v5wzG6BmEbWx2arpxPAo1/WkdihKGm2hq+TTLmiE0qz+EUm64jS86hn1TanB8n0rjlF8wG1zUkc/Ls2OWFT71Bc0r5eI+LrPNC3O/Dr5FGgtimC0jqCZ4ZRA8QEzyyCEire0oyU8QN72PElg0I+euaVNa0NGCLF+pZ61l/lhLdInj9mOslVxpVn0l4NFuLaq6E4V3Pp9lyslMdaIbW15oFbur5R2eo+KZZYdhX+BxwOhNRK2c46BfIcJNIsnroy1L660FvMH5Sw4EEwv2Vrp8acDfamtiDjm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG/6z50X6p6ppi7eA/sSq2w5wF7VvOa5gNSKjBMobFQ=;
 b=KhzDqOtsD2yqK+999Q3FcwNWqiitcLHRDnaamJUNiwRZIfniCS4sQPzSzVFyMvPI1mO8L1bztZ9NDDGp75RGzga30j2MRTsO7jZMrok/862BwZ+byYfljFVpVqsEwJSe7l8A8/sUx/76wgfN+X32noawy67KaQK4Jw1nxr4m1NYCC+HgjEAJou+8xDFFePlSXSULm1CZ/UK/uQFZt/H2PGSS9MsIRFNO2zaBEuys93zPeSTlRr0kAGt3xawZufSNg2nFFDI602FVzKHzl7n+QSWUZWFtur5cTyWJpHIGtfLuWG0wJWmFIF+d9WA+8ffPYr1cUxvU2wZBFAEznC+nVg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB6535.namprd20.prod.outlook.com (2603:10b6:8:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 03:50:45 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Wed, 6 Dec 2023
 03:50:44 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chen Wang <unicorn_wang@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
Date:   Wed,  6 Dec 2023 11:50:50 +0800
Message-ID: <IA1PR20MB49534B8B9A3014560209D8FFBB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <MA0P287MB033292C3BBCDB66952BEBECDFE84A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
References: <MA0P287MB033292C3BBCDB66952BEBECDFE84A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [9OCW3s76VZDYSMnfO3pVndBR4kS0+HxZxPhnjF9IG7s=]
X-ClientProxiedBy: TYAPR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231206035050.398551-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 6756f967-db50-48db-a6b4-08dbf60e8640
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjGTRBbylyQH7t+lm/ilGQq5ddpGzQuSl5rD3tMNNKdLjn60k0f7G2K0IGKIZhI9A5bo7cko6nH6iWHRevHcRwxCfYQ+5AmbV9Wp9NfNWpeRR0vLsA5aHocG5F23lOFa8REkXLQQPFt9UvYmAvBitwXt24vfHm9ftiJXkzbxQY9bppMz6XoEQ5ES81CkBryWI1UzKXb/rq4uIserf/pFRD5HFb7X/FjITDiDonXdcJd0fye9O8Wn2o3UmNJQqi6kgnrffDAnWszGuMhKYqCYwpUSmXOM5IV7UgLX0ir5+uYp/jXD8JkjCfsxOZJesnbwN1zjg78KHFiqr7jLJSPIBVQqv5zhaQ1SHCDKl/NdKVDjzxMl9QT29TlNk8FJmGOM1/5nuPqqJ+bivqa8UZGP6c5myZXiUxNTBhqH8sri+VHXml1s2dgcnWDyQ+Fx3DzH9U95TdUYuGGT0QUhYaNckfCjs9VuafsVOjfU0IoI29ljfudwYpXtyVxd3taemfYPxg6zVygNHxgqlYJ6oQ2XeNoK7V1O2zQBedJlJyh2TY86qb0v9WWKwvpzdvryqtHGK0VelFzJwF6o7VYXHZskP+Xa3AXJitk/WEMD5jPie6yc4IhvvyARsZwleqM4yy3b
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vj9TPY7stC1CEmF4IMEcg/X3dvNL9b4BqBjHhmGzHJk3QTIJ+/a8luyzL3PC?=
 =?us-ascii?Q?IsGAedSaUet+VzAI9T8MczRWcaTkxcvKuqPN1guv6hmDJA8iWs0j4eMXPGjE?=
 =?us-ascii?Q?863nbKtPW4OxRpN8T/9pQz4/2yR0+JkyCzXoagxamgDRrITdloCYX7xlMmle?=
 =?us-ascii?Q?GWABbPnqeGwxZZc+N/TjYlWUrbJGldCFErr5oPRChs1BdS0Y1mDrt/JW9dvI?=
 =?us-ascii?Q?+Ch5JQcbbVwbZOTCxPvdjF6oyYjETkiOMRQ9gDaE9oRV4W2Y5BDWRvRMNVQ0?=
 =?us-ascii?Q?gCyibz+uDYygQbE7ffXvKnXlzbXXXT5KRWXMF0sdS9uVtayu73Rjfp5VQN5F?=
 =?us-ascii?Q?Be1P9uwMwjYKotG+HmxAFMyow+Zk9iEG8s/Jc5WyKWL1OiAEmsaIW6RgbsAR?=
 =?us-ascii?Q?r6M4EAxvmJjeQiSasdDYnYV3S3kE00/iO9QaIcWK2VQ36S+DZd8eoKfyEinJ?=
 =?us-ascii?Q?iqKFAsNC4Qdvq7yS5sekCJ1AB8+GF+vReALVkmjjVtDZzwrpmU7h8f1n6BR0?=
 =?us-ascii?Q?TlTaysHZvt8+0tyi7ga2VfL1njL9aOtKSScnRbLu0Opw/j7E9tqMyEJdk4P9?=
 =?us-ascii?Q?7Ukqwr4H+UZfVcikXI2Cq7aEv16ivS4ObGCAkTDhMwEnSpBmHzktMzoHjxsB?=
 =?us-ascii?Q?Hwy9wDjHAIJjpFy36klqbcXURRsew1QS9w1FUuYfYhcBK7bhQLT1vNUMp78g?=
 =?us-ascii?Q?7zxv+lBgXZ2NyqBmJ2F91qJ4Gn31Ch5P4ZOPLMrIFGxu7KtbxNCD8lLrec7P?=
 =?us-ascii?Q?ufm5YHOX4uimngcgKJoXLbyYxQ5pweOtTc3f6WtDbmvj6XXpVtyt61hLN1e0?=
 =?us-ascii?Q?/tUzdpr4v337m9vsJlX0gxSEI0sEPtFhFyj1tZJpS9Q3XCiloxQ4jrTSJHDW?=
 =?us-ascii?Q?YwQ+ysNhYIGQC6qjTw4CdlGqgkovg9FSwKjWCPP+jrBiOJUL9arAoH5ROKIA?=
 =?us-ascii?Q?VRpy/uwn7UmYrPE45ErCABr0Ng3ZHLBa0/W3GXBHNzzYk52PNurzbPaOkkZi?=
 =?us-ascii?Q?xLFGxsezQ7LjJieGdR2N87e9rSDGrh+Rlg+DcYfj34sK8hVRySeI/wv0Pw/L?=
 =?us-ascii?Q?VBe0dJPJDf7mvEhw6QS9xkIRZtIozdUm36R0CSP2TzBNcqWym4yaYQLZvpRC?=
 =?us-ascii?Q?PmUkDp8zpkVgiH8NEgpze3u9Q+iTCQTEjVEpa0hTxzzlCAOCbFqMuv1XptKb?=
 =?us-ascii?Q?FOum+Et+nV40GFUt6480YhwgszkKHlYzbnccpRCk5Z9MfxBz7TkD1UK/vJE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6756f967-db50-48db-a6b4-08dbf60e8640
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 03:50:44.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB6535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 2023/12/5 19:55, Inochi Amaoto wrote:
>> Add definition for the clock controller of the CV1800 series SoC.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
>> ---
>>   .../bindings/clock/sophgo,cv1800-clk.yaml     |  53 ++++++
>With more and more sophgo products coming, I suggest add one subfolder "sophgo" for sophgo clock drivers, and this is what I am doing for sg2042, you can have a look of my patch.

Can you share some more convincing reasons? Otherwise, I suggest you may
change your file path. I have not noticed anyone doing this except sifive.
And I still have some doubt on this.

>>   include/dt-bindings/clock/sophgo,cv1800.h     | 174 ++++++++++++++++++
>>   2 files changed, 227 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>>   create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>> new file mode 100644
>> index 000000000000..388be5bfa163
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo CV1800 Series Clock Controller
>> +
>> +maintainers:
>> +  - Inochi Amaoto <inochiama@outlook.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - sophgo,cv1800-clk
>> +      - sophgo,cv1810-clk
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Oscillator (25 MHz)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: osc
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +    description:
>> +      See <dt-bindings/clock/sophgo,cv1800.h> for valid indices.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    clock-controller@3002000 {
>> +        compatible = "sophgo,cv1800-clk";
>> +        reg = <0x03002000 0x1000>;
>> +        clocks = <&osc>;
>> +        clock-names = "osc";
>> +        #clock-cells = <1>;
>> +    };
>> +
>> +...
>> diff --git a/include/dt-bindings/clock/sophgo,cv1800.h b/include/dt-bindings/clock/sophgo,cv1800.h
>> new file mode 100644
>> index 000000000000..a71ad2a93153
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/sophgo,cv1800.h
>> @@ -0,0 +1,174 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +/*
>> + * Copyright (C) 2023 Sophgo Ltd.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_SOPHGO_CV1800_CLK_H__
>> +#define __DT_BINDINGS_SOPHGO_CV1800_CLK_H__
>> +
>> +#define CLK_MPLL            0
>> +#define CLK_TPLL            1
>> +#define CLK_FPLL            2
>> +#define CLK_MIPIMPLL            3
>> +#define CLK_A0PLL            4
>> +#define CLK_DISPPLL            5
>> +#define CLK_CAM0PLL            6
>> +#define CLK_CAM1PLL            7
>> +
>> +#define CLK_MIPIMPLL_D3            8
>> +#define CLK_CAM0PLL_D2            9
>> +#define CLK_CAM0PLL_D3            10
>> +
>> +#define CLK_TPU                11
>> +#define CLK_TPU_FAB            12
>> +#define CLK_AHB_ROM            13
>> +#define CLK_DDR_AXI_REG            14
>> +#define CLK_RTC_25M            15
>> +#define CLK_SRC_RTC_SYS_0        16
>> +#define CLK_TEMPSEN            17
>> +#define CLK_SARADC            18
>> +#define CLK_EFUSE            19
>> +#define CLK_APB_EFUSE            20
>> +#define CLK_DEBUG            21
>> +#define CLK_AP_DEBUG            22
>> +#define CLK_XTAL_MISC            23
>> +#define CLK_AXI4_EMMC            24
>> +#define CLK_EMMC            25
>> +#define CLK_EMMC_100K            26
>> +#define CLK_AXI4_SD0            27
>> +#define CLK_SD0                28
>> +#define CLK_SD0_100K            29
>> +#define CLK_AXI4_SD1            30
>> +#define CLK_SD1                31
>> +#define CLK_SD1_100K            32
>> +#define CLK_SPI_NAND            33
>> +#define CLK_ETH0_500M            34
>> +#define CLK_AXI4_ETH0            35
>> +#define CLK_ETH1_500M            36
>> +#define CLK_AXI4_ETH1            37
>> +#define CLK_APB_GPIO            38
>> +#define CLK_APB_GPIO_INTR        39
>> +#define CLK_GPIO_DB            40
>> +#define CLK_AHB_SF            41
>> +#define CLK_AHB_SF1            42
>> +#define CLK_A24M            43
>> +#define CLK_AUDSRC            44
>> +#define CLK_APB_AUDSRC            45
>> +#define CLK_SDMA_AXI            46
>> +#define CLK_SDMA_AUD0            47
>> +#define CLK_SDMA_AUD1            48
>> +#define CLK_SDMA_AUD2            49
>> +#define CLK_SDMA_AUD3            50
>> +#define CLK_I2C                51
>> +#define CLK_APB_I2C            52
>> +#define CLK_APB_I2C0            53
>> +#define CLK_APB_I2C1            54
>> +#define CLK_APB_I2C2            55
>> +#define CLK_APB_I2C3            56
>> +#define CLK_APB_I2C4            57
>> +#define CLK_APB_WDT            58
>> +#define CLK_PWM_SRC            59
>> +#define CLK_PWM                60
>> +#define CLK_SPI                61
>> +#define CLK_APB_SPI0            62
>> +#define CLK_APB_SPI1            63
>> +#define CLK_APB_SPI2            64
>> +#define CLK_APB_SPI3            65
>> +#define CLK_1M                66
>> +#define CLK_CAM0_200            67
>> +#define CLK_PM                68
>> +#define CLK_TIMER0            69
>> +#define CLK_TIMER1            70
>> +#define CLK_TIMER2            71
>> +#define CLK_TIMER3            72
>> +#define CLK_TIMER4            73
>> +#define CLK_TIMER5            74
>> +#define CLK_TIMER6            75
>> +#define CLK_TIMER7            76
>> +#define CLK_UART0            77
>> +#define CLK_APB_UART0            78
>> +#define CLK_UART1            79
>> +#define CLK_APB_UART1            80
>> +#define CLK_UART2            81
>> +#define CLK_APB_UART2            82
>> +#define CLK_UART3            83
>> +#define CLK_APB_UART3            84
>> +#define CLK_UART4            85
>> +#define CLK_APB_UART4            86
>> +#define CLK_APB_I2S0            87
>> +#define CLK_APB_I2S1            88
>> +#define CLK_APB_I2S2            89
>> +#define CLK_APB_I2S3            90
>> +#define CLK_AXI4_USB            91
>> +#define CLK_APB_USB            92
>> +#define CLK_USB_125M            93
>> +#define CLK_USB_33K            94
>> +#define CLK_USB_12M            95
>> +#define CLK_AXI4            96
>> +#define CLK_AXI6            97
>> +#define CLK_DSI_ESC            98
>> +#define CLK_AXI_VIP            99
>> +#define CLK_SRC_VIP_SYS_0        100
>> +#define CLK_SRC_VIP_SYS_1        101
>> +#define CLK_SRC_VIP_SYS_2        102
>> +#define CLK_SRC_VIP_SYS_3        103
>> +#define CLK_SRC_VIP_SYS_4        104
>> +#define CLK_CSI_BE_VIP            105
>> +#define CLK_CSI_MAC0_VIP        106
>> +#define CLK_CSI_MAC1_VIP        107
>> +#define CLK_CSI_MAC2_VIP        108
>> +#define CLK_CSI0_RX_VIP            109
>> +#define CLK_CSI1_RX_VIP            110
>> +#define CLK_ISP_TOP_VIP            111
>> +#define CLK_IMG_D_VIP            112
>> +#define CLK_IMG_V_VIP            113
>> +#define CLK_SC_TOP_VIP            114
>> +#define CLK_SC_D_VIP            115
>> +#define CLK_SC_V1_VIP            116
>> +#define CLK_SC_V2_VIP            117
>> +#define CLK_SC_V3_VIP            118
>> +#define CLK_DWA_VIP            119
>> +#define CLK_BT_VIP            120
>> +#define CLK_DISP_SRC_VIP        121
>> +#define CLK_DISP_VIP            122
>> +#define CLK_DSI_MAC_VIP            123
>> +#define CLK_LVDS0_VIP            124
>> +#define CLK_LVDS1_VIP            125
>> +#define CLK_PAD_VI_VIP            126
>> +#define CLK_PAD_VI1_VIP            127
>> +#define CLK_PAD_VI2_VIP            128
>> +#define CLK_CFG_REG_VIP            129
>> +#define CLK_VIP_IP0            130
>> +#define CLK_VIP_IP1            131
>> +#define CLK_VIP_IP2            132
>> +#define CLK_VIP_IP3            133
>> +#define CLK_IVE_VIP            134
>> +#define CLK_RAW_VIP            135
>> +#define CLK_OSDC_VIP            136
>> +#define CLK_CAM0_VIP            137
>> +#define CLK_AXI_VIDEO_CODEC        138
>> +#define CLK_VC_SRC0            139
>> +#define CLK_VC_SRC1            140
>> +#define CLK_VC_SRC2            141
>> +#define CLK_H264C            142
>> +#define CLK_APB_H264C            143
>> +#define CLK_H265C            144
>> +#define CLK_APB_H265C            145
>> +#define CLK_JPEG            146
>> +#define CLK_APB_JPEG            147
>> +#define CLK_CAM0            148
>> +#define CLK_CAM1            149
>> +#define CLK_WGN                150
>> +#define CLK_WGN0            151
>> +#define CLK_WGN1            152
>> +#define CLK_WGN2            153
>> +#define CLK_KEYSCAN            154
>> +#define CLK_CFG_REG_VC            155
>> +#define CLK_C906_0            156
>> +#define CLK_C906_1            157
>> +#define CLK_A53                158
>> +#define CLK_CPU_AXI0            159
>> +#define CLK_CPU_GIC            160
>> +#define CLK_XTAL_AP            161
>> +
>> +#endif /* __DT_BINDINGS_SOPHGO_CV1800_CLK_H__ */
>> --
>> 2.43.0
>>
>
