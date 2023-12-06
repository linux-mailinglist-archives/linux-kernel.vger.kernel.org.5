Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D765C8064CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376673AbjLFCI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376398AbjLFCI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:08:26 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2082.outbound.protection.outlook.com [40.92.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CCC188;
        Tue,  5 Dec 2023 18:08:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogm0AItwNDvLFrUuVaKmQbOhKs++4ObCScy40Pb0kofhZupARqj7Qx5wFv6G6Gywmsjlmn0aJADtUPaPs3yYF1jXB3Z8bli6yBmd8DMXAiHXPTfDrUo8scz9P4Zmu2JExaXL84sYARWuxi6DC8DTa5P7tVJPHd/ZY8IZYuXLNRAXXz2xea+J+J8Z2XJ89/TQcKWzmPOi//45MHFgFoDIO3WUVgNv/C/tGgKISiUcKmivb0F2Z6rmtnzZoBLjMN6rYX7ZBKW77pjxS/o2evaaCB6mWaFHCTNThZntVA8n4HWyf8BxaVBQ6ppZ62rG64nqcLakiyflUSTbhCaNkKBDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3NUx8ivV8+3IjrR5BMNttZ/nWGgimCVXCXJBdIBhNY=;
 b=ayKdDKannexvJInF6nnOrRNJZzWefF/V4vYaLJNnSbmYxg8PpegnQlhVCRGLLn3Tu+0Jb5hv2EX51gKtX1wI7KPfZLgD49CoxN95pcKz2H+rUD//oQk1RawJ/I1bZDSUJvwKo5scb1wbyIKBMFEO7Sa7EBNLIuZUoJI96a5k5hmIYIiRZ+9rLDHjemW3YwR90r4YWN11STZ6zbsbztsUm3n4cRLm1EVY06ymh8HyDKxKPDXrz6zPJLjW43gM/py7ImHQkFmHNdTy7JU6d3BpjJMnRuy9dFKBcNbp1WfWOPCxAHsSU9s4QK/4O4GDzzovbmuTKkNFYZXj1vSYJn6V2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3NUx8ivV8+3IjrR5BMNttZ/nWGgimCVXCXJBdIBhNY=;
 b=XzYBYRdGxV0gJNr71Ujtxv+p7EF3BviFB76YeclJqapAxAJrAAheHWbR4YlZHh7ClTGk7o5oAOe92ZrZ3fdKR7Vmid86OmzXJyX6NC0tkpYGB/PViLV/SNIJtGQRQAYlP0LEkJj+phHHCEf3a/fRUlSYw0jgTcJw6b97RjVodPl4QEv6+v0cLPLiv5Oma0Bg5zYxwtUevAulRYY+F2mmeorsb2KL5+Zkzy/fF2PLqN4IlZe98oVKToLHO/yRTvLwXX1/zFykKaqF2ngp8KyqoKzH0a0svl6FhVodF7O/NID/kB4rwNIT495pWNm0NMWWegDGAQc092gvOXbES175nw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB0092.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 02:08:23 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 02:08:23 +0000
Message-ID: <MA0P287MB033292C3BBCDB66952BEBECDFE84A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 6 Dec 2023 10:08:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: sophgo: Add clock controller
 of CV1800 series SoC
To:     Inochi Amaoto <inochiama@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <IA1PR20MB49532E1A3D8BA71FDBB444BCBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49535CCEBCC36C864B949CF5BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49535CCEBCC36C864B949CF5BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [IJrNwQLda/DDnvFKJmRCjC0D8BzBiqV/]
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <ab00cc04-c5b7-486c-8245-81816ae0c9a4@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB0092:EE_
X-MS-Office365-Filtering-Correlation-Id: a7be8585-9441-45f6-16dc-08dbf6003967
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RAnK4v5q9Sl2yPpGFK6zt1Ud2jtgo5WrcBwG4buvRHRksRgZApLr389TIpFiYMrdfe3zfqHIw+wv5tbnlT50IP4cafGOGR5SYqjwuonMG6xOWFANZaQTiLsCgRmpnB17lG3gy4whmqO4RWJvGX4wSHMm3WqHbDRX6jrZLPkhnJGRuljwGu8/MVoxLc1/zOZkATQkeqLQ7OGI6kclhQsc0IcC3wt3nAC88kaYR97Y6gXe7Fzv1FxUGWzy95+UTU7xCPQCfQmwyl9wGviIKqwOwryMmMJ7NdfmhnVRHsJPCshwwajczWnawirbQpChBWXbkf4AFJwItUWuW5pIZZzvo4ev8sdHrJ74Y8I+oGE8SlzmnmVhvIuTpAQAECJUuLwuSwa/pTN69onr/zxIukjFE+UN1rsFDtGEntKBYq3QVpDAm7w3pBv1Arb2OhabyEUQm/RMQOhRR9/vprmKuHFvxCj2AND5haSy0sYuXabIgJTi72k8yxuaihPvSyaEjkgMC0IpzaOtM+ajbwFscbrGviMyzHeYsqEcCO+v1EUPVTwf95/Q6BwV3R0HkBOjQSQ0FIaJdaCZ6PDTjcYZsN38rj93x+sLW3J3H4KgMZZAlQA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c080SlVWbUloMXVuUW9IUS9rQ25ZRWZOZFlHSThpZE5iYUVjZ2NYbWltVWVM?=
 =?utf-8?B?RlBneXhKWTFYTFNrNmRWdG94TkloYTBRNjNEMjh0YVJIS29xbDhwYktLTlBF?=
 =?utf-8?B?RjB5TVp6VEMrVUIyRVZUdHNoUldYODEvV3FTb1lvV1YwNSt2SmJJb3V3c0hN?=
 =?utf-8?B?bW8yTUhBQWUxOGJqVUg0bG5iRVkxcUhUVlFJTklkenljU2JodXg3d2N0cWNN?=
 =?utf-8?B?bllkejN1NEtOZVovUHpRY2hsdU1GRlVrY3paUTB0cStuUC9jRzhUQWpBNnN5?=
 =?utf-8?B?ejRZMERWQnhIeGVtdmNsd01QaGI1cXZQbkpZSUN3L3I3WCt2MHdITHhRZlFs?=
 =?utf-8?B?MXltbUNBd2lndW9Ja0RMd2M3Qjkrdzl2MmdOV2srTnVMd3l4OHNnUTlYb0Rh?=
 =?utf-8?B?a2RyMThKU0hzYkNnYUxxZ09EMVlua29rMGpOZEpTQ3BNWHJpb01Gci9TK0lI?=
 =?utf-8?B?MTNPK3lrYTQ3RlNqdGNsWWtsQVgzQkZzNEtnZW1rVmpOR05LaHF6blZVa0hL?=
 =?utf-8?B?c05HRGJwcGhWZm1FSzhSbmhTcExaMWJkSEdXV3d5b1JuYnU1UWplbXdGKytx?=
 =?utf-8?B?QlJKa0oraFVKa2ZiRGxhQm1xMkhnYVJOSzRUMXBiMlZCbUVITDNDT1Fia1Bn?=
 =?utf-8?B?V0dsVkhoWnpPUGx3WmlrTlVseWJtazFGMVpIVlFTUUQraWhVK3RSNXVlZUlZ?=
 =?utf-8?B?RTBFalVXZEpwUDl1RTJsamswRVczN25lYzc5N0F4YncvSlJjVTE5dTVxVEhk?=
 =?utf-8?B?cTRUb0RTdVl0Qm9sL1RETTRETytyaFE4RmJxRTV3VEZuamhuK2dxUy8wSWM0?=
 =?utf-8?B?Ui81Ly9RL3lSbTNnZk5pUzdYclNNVG5sUGhrQW1VTWVEUXRkYjMxck5TL3JL?=
 =?utf-8?B?L3BtMEhkUUVkNm1YMEdJdkNTVnVMdmFBa0hVN2J4RHRKNVhUMjhob0pwZFd6?=
 =?utf-8?B?S0ZYU0tPTUY2TjZMQmlaeFlNUGloc29ZRjZqM1lPa3lLdEc0U0M0a0llc3l4?=
 =?utf-8?B?Nlc1YjM1amV4OU5Ccy91dGcyWTBrdndQaWFQVSt6WU1mS0JrVDREN0ZLZ2dG?=
 =?utf-8?B?YmE1NkU4TUNTV0pxY2JTYW8vWUlyQlRPQUhHMXN1bVRNZ1dLVlR5ODNiUjFt?=
 =?utf-8?B?K25jbHRyMWpnUURHUUE2Mk1JVDd0bVhLajZ4eVpTTjJsVWdvd2lwL1Q1Zm9O?=
 =?utf-8?B?SGhMT0ZzR0VaYWd2NnpaT0FuQ2xPcENad0FTTjlRWUREYnNGMXJwUzlsWmhq?=
 =?utf-8?B?ZTJuMEg5bno3azViMlFjcTc2bHl6QU1KWUxmQmQvYlc4cHE5ZHJEd29IQ09V?=
 =?utf-8?B?NXFBaWVneFpybUFjQmZLK1VpTzZ3RkdYZTNVeGlYZGpWQmFLR3JzQjJuTGxI?=
 =?utf-8?B?M0JlSEUyUUNmVTFCemtDdFkwelZjVzBINmxVMFZiL005ZGc5b2JFMit5QTh2?=
 =?utf-8?B?T1QwR0IvMWMwaC9ydFA3NkhvQnE0ZWNqQ2J0U25DMVpOK3JxVEFNRk02c2pK?=
 =?utf-8?B?a3JXOGFsa01jOTRydjFnZ3gwb29pSU1oSXZBNkt2YkJzSURMZ3Bhd3k5OG11?=
 =?utf-8?B?N3QyZGlXdHg1M1NvMXFPb1BTZXl3NVhobVg0NndWN3NMNGF6em5IbGNWWnJL?=
 =?utf-8?Q?P49u2ZLqqImj5sihovCuwSA6xd8NcvngvFhakpEc8j/I=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7be8585-9441-45f6-16dc-08dbf6003967
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 02:08:22.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0092
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/5 19:55, Inochi Amaoto wrote:
> Add definition for the clock controller of the CV1800 series SoC.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
> ---
>   .../bindings/clock/sophgo,cv1800-clk.yaml     |  53 ++++++
With more and more sophgo products coming, I suggest add one subfolder 
"sophgo" for sophgo clock drivers, and this is what I am doing for 
sg2042, you can have a look of my patch.
>   include/dt-bindings/clock/sophgo,cv1800.h     | 174 ++++++++++++++++++
>   2 files changed, 227 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>   create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h
>
> diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> new file mode 100644
> index 000000000000..388be5bfa163
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV1800 Series Clock Controller
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sophgo,cv1800-clk
> +      - sophgo,cv1810-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Oscillator (25 MHz)
> +
> +  clock-names:
> +    items:
> +      - const: osc
> +
> +  "#clock-cells":
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/sophgo,cv1800.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@3002000 {
> +        compatible = "sophgo,cv1800-clk";
> +        reg = <0x03002000 0x1000>;
> +        clocks = <&osc>;
> +        clock-names = "osc";
> +        #clock-cells = <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/sophgo,cv1800.h b/include/dt-bindings/clock/sophgo,cv1800.h
> new file mode 100644
> index 000000000000..a71ad2a93153
> --- /dev/null
> +++ b/include/dt-bindings/clock/sophgo,cv1800.h
> @@ -0,0 +1,174 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Copyright (C) 2023 Sophgo Ltd.
> + */
> +
> +#ifndef __DT_BINDINGS_SOPHGO_CV1800_CLK_H__
> +#define __DT_BINDINGS_SOPHGO_CV1800_CLK_H__
> +
> +#define CLK_MPLL			0
> +#define CLK_TPLL			1
> +#define CLK_FPLL			2
> +#define CLK_MIPIMPLL			3
> +#define CLK_A0PLL			4
> +#define CLK_DISPPLL			5
> +#define CLK_CAM0PLL			6
> +#define CLK_CAM1PLL			7
> +
> +#define CLK_MIPIMPLL_D3			8
> +#define CLK_CAM0PLL_D2			9
> +#define CLK_CAM0PLL_D3			10
> +
> +#define CLK_TPU				11
> +#define CLK_TPU_FAB			12
> +#define CLK_AHB_ROM			13
> +#define CLK_DDR_AXI_REG			14
> +#define CLK_RTC_25M			15
> +#define CLK_SRC_RTC_SYS_0		16
> +#define CLK_TEMPSEN			17
> +#define CLK_SARADC			18
> +#define CLK_EFUSE			19
> +#define CLK_APB_EFUSE			20
> +#define CLK_DEBUG			21
> +#define CLK_AP_DEBUG			22
> +#define CLK_XTAL_MISC			23
> +#define CLK_AXI4_EMMC			24
> +#define CLK_EMMC			25
> +#define CLK_EMMC_100K			26
> +#define CLK_AXI4_SD0			27
> +#define CLK_SD0				28
> +#define CLK_SD0_100K			29
> +#define CLK_AXI4_SD1			30
> +#define CLK_SD1				31
> +#define CLK_SD1_100K			32
> +#define CLK_SPI_NAND			33
> +#define CLK_ETH0_500M			34
> +#define CLK_AXI4_ETH0			35
> +#define CLK_ETH1_500M			36
> +#define CLK_AXI4_ETH1			37
> +#define CLK_APB_GPIO			38
> +#define CLK_APB_GPIO_INTR		39
> +#define CLK_GPIO_DB			40
> +#define CLK_AHB_SF			41
> +#define CLK_AHB_SF1			42
> +#define CLK_A24M			43
> +#define CLK_AUDSRC			44
> +#define CLK_APB_AUDSRC			45
> +#define CLK_SDMA_AXI			46
> +#define CLK_SDMA_AUD0			47
> +#define CLK_SDMA_AUD1			48
> +#define CLK_SDMA_AUD2			49
> +#define CLK_SDMA_AUD3			50
> +#define CLK_I2C				51
> +#define CLK_APB_I2C			52
> +#define CLK_APB_I2C0			53
> +#define CLK_APB_I2C1			54
> +#define CLK_APB_I2C2			55
> +#define CLK_APB_I2C3			56
> +#define CLK_APB_I2C4			57
> +#define CLK_APB_WDT			58
> +#define CLK_PWM_SRC			59
> +#define CLK_PWM				60
> +#define CLK_SPI				61
> +#define CLK_APB_SPI0			62
> +#define CLK_APB_SPI1			63
> +#define CLK_APB_SPI2			64
> +#define CLK_APB_SPI3			65
> +#define CLK_1M				66
> +#define CLK_CAM0_200			67
> +#define CLK_PM				68
> +#define CLK_TIMER0			69
> +#define CLK_TIMER1			70
> +#define CLK_TIMER2			71
> +#define CLK_TIMER3			72
> +#define CLK_TIMER4			73
> +#define CLK_TIMER5			74
> +#define CLK_TIMER6			75
> +#define CLK_TIMER7			76
> +#define CLK_UART0			77
> +#define CLK_APB_UART0			78
> +#define CLK_UART1			79
> +#define CLK_APB_UART1			80
> +#define CLK_UART2			81
> +#define CLK_APB_UART2			82
> +#define CLK_UART3			83
> +#define CLK_APB_UART3			84
> +#define CLK_UART4			85
> +#define CLK_APB_UART4			86
> +#define CLK_APB_I2S0			87
> +#define CLK_APB_I2S1			88
> +#define CLK_APB_I2S2			89
> +#define CLK_APB_I2S3			90
> +#define CLK_AXI4_USB			91
> +#define CLK_APB_USB			92
> +#define CLK_USB_125M			93
> +#define CLK_USB_33K			94
> +#define CLK_USB_12M			95
> +#define CLK_AXI4			96
> +#define CLK_AXI6			97
> +#define CLK_DSI_ESC			98
> +#define CLK_AXI_VIP			99
> +#define CLK_SRC_VIP_SYS_0		100
> +#define CLK_SRC_VIP_SYS_1		101
> +#define CLK_SRC_VIP_SYS_2		102
> +#define CLK_SRC_VIP_SYS_3		103
> +#define CLK_SRC_VIP_SYS_4		104
> +#define CLK_CSI_BE_VIP			105
> +#define CLK_CSI_MAC0_VIP		106
> +#define CLK_CSI_MAC1_VIP		107
> +#define CLK_CSI_MAC2_VIP		108
> +#define CLK_CSI0_RX_VIP			109
> +#define CLK_CSI1_RX_VIP			110
> +#define CLK_ISP_TOP_VIP			111
> +#define CLK_IMG_D_VIP			112
> +#define CLK_IMG_V_VIP			113
> +#define CLK_SC_TOP_VIP			114
> +#define CLK_SC_D_VIP			115
> +#define CLK_SC_V1_VIP			116
> +#define CLK_SC_V2_VIP			117
> +#define CLK_SC_V3_VIP			118
> +#define CLK_DWA_VIP			119
> +#define CLK_BT_VIP			120
> +#define CLK_DISP_SRC_VIP		121
> +#define CLK_DISP_VIP			122
> +#define CLK_DSI_MAC_VIP			123
> +#define CLK_LVDS0_VIP			124
> +#define CLK_LVDS1_VIP			125
> +#define CLK_PAD_VI_VIP			126
> +#define CLK_PAD_VI1_VIP			127
> +#define CLK_PAD_VI2_VIP			128
> +#define CLK_CFG_REG_VIP			129
> +#define CLK_VIP_IP0			130
> +#define CLK_VIP_IP1			131
> +#define CLK_VIP_IP2			132
> +#define CLK_VIP_IP3			133
> +#define CLK_IVE_VIP			134
> +#define CLK_RAW_VIP			135
> +#define CLK_OSDC_VIP			136
> +#define CLK_CAM0_VIP			137
> +#define CLK_AXI_VIDEO_CODEC		138
> +#define CLK_VC_SRC0			139
> +#define CLK_VC_SRC1			140
> +#define CLK_VC_SRC2			141
> +#define CLK_H264C			142
> +#define CLK_APB_H264C			143
> +#define CLK_H265C			144
> +#define CLK_APB_H265C			145
> +#define CLK_JPEG			146
> +#define CLK_APB_JPEG			147
> +#define CLK_CAM0			148
> +#define CLK_CAM1			149
> +#define CLK_WGN				150
> +#define CLK_WGN0			151
> +#define CLK_WGN1			152
> +#define CLK_WGN2			153
> +#define CLK_KEYSCAN			154
> +#define CLK_CFG_REG_VC			155
> +#define CLK_C906_0			156
> +#define CLK_C906_1			157
> +#define CLK_A53				158
> +#define CLK_CPU_AXI0			159
> +#define CLK_CPU_GIC			160
> +#define CLK_XTAL_AP			161
> +
> +#endif /* __DT_BINDINGS_SOPHGO_CV1800_CLK_H__ */
> --
> 2.43.0
>
