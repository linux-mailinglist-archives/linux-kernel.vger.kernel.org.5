Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD3804961
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjLEFgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEFf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:35:57 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2060.outbound.protection.outlook.com [40.92.103.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD11109;
        Mon,  4 Dec 2023 21:36:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn2+G48cjt2Wa9O3TmkfWCiBDTtwSMtGqv76WfKA6PSHbFbqqqvJyi23J47EPxkEkGfEpOP0EwGrEFpG30nhL++VQ+DzRPbLwpp1QNgF98MJf9SXjPgDETxDNuWjITd5GVeXXZpF27TRfDUtcLXvI6/Pr2ebQ/221ClUgQOS/bzmrxppHVt7WCY4vELDY6q+bonB8iMZGiBmVa9y3Tz5OScRsb1FmtIvymS01DhQVtXh4WDK0tkQKHBkK0LvLCmzaod1LTPdfmrF4kJmZ1qb3xjknCc2DTBNfxKfUWtIfnlbeDQ6KfSW/8ccJRRz+fPgzGdK04aZ1ysjBL3FDCP2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LyD8TxeK9QC4uvDhMRO4bEj18VIqFR+zp5cNEbI+Q8=;
 b=Sgk4FcGQ3k+Dd5N8eOpQ2TLf+tXt4rI86S18VSnETZaurEdLnD6TPMScl2cU6DMp5hQbkHU5IMO0ksPTvnIvOsps9qfpToOhH50/Ssi/xOjZlTrz6voijLR/sLOCGS45Qyz4chGTNAFPbwskDYDPLZLuG2tmOJvJORiVJB00Ol/0aFCkt2iG0oyBCQ5VdnlcCkCyhPFgH8IF21O/9oceoYOnLcF1TQBL/Ng+lM8dNHwpCVHJ13K3l5spmBcmSo7Xx63OGVwXTXR23yH642I8rtT7+K0P8J5qyxYHwTDfkH2FKFjhzLQkJhNYb49JRDQggNiC3EMUFicAWT5X6cma5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LyD8TxeK9QC4uvDhMRO4bEj18VIqFR+zp5cNEbI+Q8=;
 b=Tz8jVGk9wMztuHjpvUfSSHG1gE6IjvWb/3wGKxU1kDY/N366gBzHavdWMS4HkHK+WcqDi5ESZJe1Z7N3OJMkJ+xfeLOHIInm3pCgIJCsribAiRJ6T50GtJKZoIMTgf1kuyNVONTLe+e/1kCcoLqHydhbrYs+U8BQ8hg+YR8mxX9qz/NuHwdGx4U1zhiEC/mYL8fgz5iocp/3W8//1caEkxI+FftnqntjFoNChLi5Jck27w2c4kxoadrHqu9Rkwck7im5aLeLB6p6GIN8lPJ8xBhdALQjyiqoT/3cugeXZ3kWHUZLQm6zPryNjq8TT373jjShD37GRBBwUAnKie1WPg==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN3P287MB1847.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Tue, 5 Dec 2023 05:35:54 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 05:35:54 +0000
Message-ID: <MA0P287MB033276574107F5031C153DDDFE85A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Tue, 5 Dec 2023 13:35:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] clk: sophgo: Add SG2042 clock generator driver
To:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, samuel.holland@sifive.com
References: <50302e6035a9a83b002d51e21d39d3890d27290c.1701734442.git.unicorn_wang@outlook.com>
 <IA1PR20MB4953C3278ABEA3B840C11712BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953C3278ABEA3B840C11712BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [AI7Q7sUt81d4CL8FPu6XmIuNP8cthvfj]
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <eb7b3717-8d23-4d25-bce1-6e3e060cbf7f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN3P287MB1847:EE_
X-MS-Office365-Filtering-Correlation-Id: ab432cbb-313b-4065-198e-08dbf5540c61
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkBQ9iaSb4asw3QX0eTWiv5i6QSIvwET5/1kDZTSPGrVZ1iagSZD7IvWy+5G4Dlum59bCA423GDmeonFao6jvT6eEGRE2bFuCxs74TK7BALW7zvGy2wPfDUHBPVvxI1NM8s3kx39hvIl6rON5RCf72ZPmX5y4l3UWfMqBfigG2Avq0k29/z1MQKFUNmRHqE7x/hgnNbRiVbAtiXBSy9cPf1XIuvJWJIC8Xy66EoCqoUbt73pdhgLvg7OnubU85BSIIC4JMrMSBL+9bQ89so9+V1UsvPsGKg6zIZe7ldpY8zsPlWwCuKR/CcmUfA5xZe1WUEWrdNteV8BEI6Q+GgdXStsCiTz6fEVQvY1qiRdtlGXWGg6sqP8Kfb4nWDcGy/1RjYtItdKFqz5slC8UKq4/5z9PKcQSKcNJwKd0gIGHfIqqREUgiAqeQENqqP1y+CUQ7G+CPxIzwgp0MISmuvzI//GEVVwua67djw5O9UskLSjJtD0o3MtFLf7o77jW5LLwSHta7/9qdjRaAnVp6chdOMX9UY4jp2Bx2bQGr+lUg5c6c5l+qNWjm+D+J9OKVyD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2RjcVd4SEpjUkFaTUFBVmlrZVg2L0JiSlFqMWdRQ0Fac01PNEJvMXUzSmp5?=
 =?utf-8?B?OTBjaXpnUTJEdStNam5tRW90VmZ2a1cwZFo1elYxR1pBS3l6Q200am52ZWZl?=
 =?utf-8?B?RWdPR2gvWXJqMzJBOXYvZkRmczZNL1JnY3VRRkRMYXlZNUx4VFRhZTZTbDlW?=
 =?utf-8?B?UXdnM0tSVlM4M1M2aFVOMHYyZm5iaS9oN2FlZHpkZ0hFRUpaTVpzYUdRMUs2?=
 =?utf-8?B?cWQzVFdmMTRDdjNOczlqZU9tTHNvQmt2c21QRnRES1o0cnJFbi9WNzVjek85?=
 =?utf-8?B?RnYxL0FFdndGY2hZYkdWQ282SVRxL1ZPRURwaGVtd3BYd3UyeEJIbW5wYXdk?=
 =?utf-8?B?dkgwWStjWm9HNFlmM3NVdnFIbWROOStIbWRGTWs5aG1FNHFhNmtIVjYxRHFZ?=
 =?utf-8?B?aG1UekxXV2lUWFA4eGxaRDhQbUg3YXh0VTRuZzZlUjRDK3UwZEU5VEh1cWls?=
 =?utf-8?B?QUo1bXZwWUdWdmJaOGwvL056bXZmTkRVbWRsQi9pVWdxVUdTV1NnWHNreC9Y?=
 =?utf-8?B?MVgySGszZ0xlaVpWWmJ4MGlab1dURlozdTRMeEhKZFYzT0FGc09vUDNJQ3ly?=
 =?utf-8?B?TDRSb0lmNngzQTJkeTlZRXlMMVZ1YjF1WGpSak45L25kcmhucFZLbEEyZ0ZN?=
 =?utf-8?B?Tm5NS0tnNVArUC9tWUZrckdkS3k5ZkJ1ay9Tb3hOeXhNWmlSZGl6cG92dHA5?=
 =?utf-8?B?NlhNaGdUUGZtS0NyRnVSR1VzcGtCREtFbnNUVWJJbjhSNUhpa0x5dURiakJt?=
 =?utf-8?B?OWhGMFVhZFAzcWtEaGJTa1Rwbmo0cHl4R2lac3ZNcTlwR2lNQ0FiQmJIb0hq?=
 =?utf-8?B?c1dQaXMvN1poV2dKbVlBMStiSnprTU9hTTdiTHBla2lSV3dSNHZYMFVxU3E0?=
 =?utf-8?B?S1BHaGxLd0hDV1ZRTkNMV3VueGR3NUJIckdBbWt5L1Rtd2k2a1FxdWtwZERp?=
 =?utf-8?B?Nk1KYklEdGh5V2QySzhReGw1Zkh3N282V21NQ3hMQklmYVljbzRhSmJTQW84?=
 =?utf-8?B?RGRhZ25xcUpMbU5ZNG1aUWZKQlMzcHA3NWpLUlNKZWtVNnlPWCtpWC9VZTgw?=
 =?utf-8?B?YW9rYXJXdzF1ZHFTQjRuZ0tJeXNQM21mY2hzM0ZMUjFJbmtTaGtCZklEdTVT?=
 =?utf-8?B?dUIyTEpVWUZ5dEpWa0JDR0tvWDBnWnpJY3JnUDFFNEVlKzFiSWRCYThvYkxi?=
 =?utf-8?B?QkRYcm5TRnlkNFdLTERxVW1xa3F1dFp1MlhJYUpiZktFZWxwWUpqaTBueWVX?=
 =?utf-8?B?WERMZlJkQktlR2ZXMWUyZmlZakZsUVJVenByZGZBcnRMYzhSL2tZRkJyM0FG?=
 =?utf-8?B?SVVpdUJKUWpnbHpTc3krYzdGeHRLeGZoMk53WVRDbDlBVjdGeG4zejdMejVP?=
 =?utf-8?B?ek8zS0FXTi9hWTQ0NERXTUhSL1JDQ1c5YjlhNzN3S003QW1OTUtlUW5kN1dU?=
 =?utf-8?B?SEs1eVVhM3dzUStaRytoZFVLb2hXZEZKTVRWOHV3T0gwcGlhNHF4b0ZtUThU?=
 =?utf-8?B?TDR0OWJ0cnVIVkJRVjNWY2xNcEdoVzNWbklUZHB1QU0vQ3Izbk94OUZtQ0ls?=
 =?utf-8?B?WGxBcStVYk54S2IzcG16UU52V0JJTjNhS01rYklWOVNjdFJ5dlpYQlJBR2Zw?=
 =?utf-8?Q?6Z1VmTdYoCjAIK3uhnSZMha7ZSuCgY9+Sg8XewSx+hC0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab432cbb-313b-4065-198e-08dbf5540c61
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 05:35:54.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1847
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/5 9:13, Inochi Amaoto wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add a driver for the SOPHGO SG2042 clock generator.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>> MAINTAINERS                            |    7 +
>> drivers/clk/Kconfig                    |    1 +
>> drivers/clk/Makefile                   |    1 +
>> drivers/clk/sophgo/Kconfig             |    8 +
>> drivers/clk/sophgo/Makefile            |    2 +
>> drivers/clk/sophgo/clk-sophgo-sg2042.c | 1371 ++++++++++++++++++++++++
>> drivers/clk/sophgo/clk-sophgo-sg2042.h |  226 ++++
>> 7 files changed, 1616 insertions(+)
>> create mode 100644 drivers/clk/sophgo/Kconfig
>> create mode 100644 drivers/clk/sophgo/Makefile
>> create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
>> create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 97f51d5ec1cf..c9c75468f2cb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20269,6 +20269,13 @@ S:	Maintained
>> F:	arch/riscv/boot/dts/sophgo/
>> F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
>>
>> +SOPHGO CLOCK DRIVER
>> +M:	Chen Wang <unicorn_wang@outlook.com>
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/clock/sophgo/
>> +F:	drivers/clk/sophgo/
>> +F:	include/dt-bindings/clock/sophgo,sg2042-clkgen.h
>> +
>> SOUND
>> M:	Jaroslav Kysela <perex@perex.cz>
>> M:	Takashi Iwai <tiwai@suse.com>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index c30d0d396f7a..514343934fda 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -499,6 +499,7 @@ source "drivers/clk/rockchip/Kconfig"
>> source "drivers/clk/samsung/Kconfig"
>> source "drivers/clk/sifive/Kconfig"
>> source "drivers/clk/socfpga/Kconfig"
>> +source "drivers/clk/sophgo/Kconfig"
>> source "drivers/clk/sprd/Kconfig"
>> source "drivers/clk/starfive/Kconfig"
>> source "drivers/clk/sunxi/Kconfig"
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index ed71f2e0ee36..aa5d2cf0b6a6 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -119,6 +119,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
>> obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
>> obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
>> obj-y					+= socfpga/
>> +obj-$(CONFIG_ARCH_SOPHGO)		+= sophgo/
>> obj-$(CONFIG_PLAT_SPEAR)		+= spear/
>> obj-y					+= sprd/
>> obj-$(CONFIG_ARCH_STI)			+= st/
>> diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
>> new file mode 100644
>> index 000000000000..b0fbe4499870
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/Kconfig
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +config CLK_SOPHGO_SG2042
>> +	bool "Sophgo SG2042 clock support"
>> +	depends on ARCH_SOPHGO || COMPILE_TEST
>> +	default ARCH_SOPHGO
>> +	help
>> +	  Say yes here to support the clock controller on the Sophgo SG2042 SoC.
> Please add RISCV to its depends. Not all the sophgo SoCs are in the RISC-V
> platform, Some are arm chips. It is not good to build this driver
> in that arch.
ARCH_SOPHGO is only defined in RISC-V arch, so I think RISCV should not 
be needed as depends.
>
> Also, the condition ARCH_SOPHGO is duplicate in the Makefile. Please
> remove one of them.

Don't undestand your question "the condition ARCH_SOPHGO is duplicate in 
the Makefile ",  I think you are talking about Kconifg, what Makefile 
are you talking about?

>> diff --git a/drivers/clk/sophgo/Makefile b/drivers/clk/sophgo/Makefile
>> new file mode 100644
>> index 000000000000..13834cce260c
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_CLK_SOPHGO_SG2042)	+= clk-sophgo-sg2042.o
>> diff --git a/drivers/clk/sophgo/clk-sophgo-sg2042.c b/drivers/clk/sophgo/clk-sophgo-sg2042.c
>> new file mode 100644
>> index 000000000000..421ebcc7192b
>> ......
>> +		}
>> +
>> +#if defined(DEBUG)
>> +		pr_info("registered [%d : %s]\n", gate->id, gate->name);
>> +#endif
> Drop, no need for this.

OK, this log should not be needed, I will remove it in next version.

