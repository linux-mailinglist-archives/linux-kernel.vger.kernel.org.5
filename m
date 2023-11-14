Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834697EAFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjKNM0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKNM0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:26:00 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA113E;
        Tue, 14 Nov 2023 04:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1ImY3IHNX5vu7BAl+e6Gu+4iW1Ag8hKsr9luWlse/IrBViVuMS3yaaTx+XLT8rmV0JDqehNybv/O8Slr1RiciGzPSkWiiOPktJZORzQPVo9bbUjaDEQzyF9bDvxM6FNsuw4Xlnif0FqA6ExRlDOSDME63txGIUP3XlDrfMGByl5lafBNEgdp5PRp35LLX4R8v2yZU4vZVE+U0doiavSVJdEX1r1toDSObKuW0+VKn9Q5GFvW2AooKhOvgoBfSjLn3xky95QvpMUJLF57aUlTyXcfyydw+TiE8iEh8IwhWY720Tp+v/fnbOfbsZ56XR9jrOJrv9mHU2dlJ8443sctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwSw0PfBLJSfaMei7ihTRbHsNA3zpcTgU2tVKcI3cW4=;
 b=Rg6+05Ccg0y0X55xfnQLAOnYS9Ss27z/mqRmYs2Zk0owX9PZsOqvtY1Kr9q7GyQcgFNVWUytXm6IxeDIEPCWpVDJ+mX3QBLsaL5d5jj/zKEIa2VXChFaNLMmzlGkrqCuzyyO30lW3l6ABUJYruFRphpiDHsywrSPgCE4qOXVr8uMm2IZ/H6YfSXX9R85pLhtcxcFwl8gVad5sDeZEQP9zdMXrJ257Gx/mWID1v7MsvEXFhtVFWbtu+4SjbBD3vSfqnctSBBt8BCuEGVDMtUjprCwe0ptGGPpAfm17zPVtE6midJE3IFqipkwS7osBjA8neJw9030Rs0lNNlztaeAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwSw0PfBLJSfaMei7ihTRbHsNA3zpcTgU2tVKcI3cW4=;
 b=AKGk2VRlrL+Rb8gOS9AJ8DF/1XjaohPhsWPCxPsQBuh+LakblaP1ZliyuTj/fYNN/XIV9EpoPKrml8rvQmMtFyrPfSTYkqeSCfOZjUiJTar83MXJ/hTjyHrS9tyimWe6Ujno74WUYj5jP5R4ZCOx60MTbzWndwBCMNw8CckOaFd0Ahq4NKQX1bQ8qyV147VzBEAnVmbsG/3OCicM9gwNFlXsrE2yDjTCbFNre+9TjbSN8LPmJonZpIYk8ewKK7j5KEcYhxnGkptWmIdRkrTTd3AX9oWqyyoybEOmiuyqR7ZozY1e6pAlf3zqXwXoGProBlFafj3z/DhjXLHItdn3cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYSPR03MB8682.apcprd03.prod.outlook.com (2603:1096:405:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 12:25:50 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::a1c1:dff3:a5c8:6f0d]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::a1c1:dff3:a5c8:6f0d%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:25:49 +0000
Message-ID: <a38a833b-1b1d-4f21-817e-0a6efd4fb212@amlogic.com>
Date:   Tue, 14 Nov 2023 20:25:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/4] clk: meson: c3: add support for the C3 SoC PLL
 clock
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20231106085554.3237511-1-xianwei.zhao@amlogic.com>
 <20231106085554.3237511-4-xianwei.zhao@amlogic.com>
 <1jttpobov2.fsf@starbuckisacylon.baylibre.com>
From:   Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jttpobov2.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYSPR03MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f659728-5a6a-416c-415d-08dbe50cd5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5w6f9uchAwcQIGu2dzxwZVVQxhoyXdJHTkeWBYrJq88pjNSSpPsL9OCK/L9U7RjjTFKJa9doWFY8DPESxKlIUDlUAdyUvk0+pK3mUI58ORf18KUbAf69d2Ixwc0uvZ3gW0sJGbOLpkd5H3BcS4y46C0B8lVH9UYIo+1/90wKFxEuJYVTmBsslQAr1kB23brfysRh8YA5xTKEu4dIO7Kz4jAhFzkFTLtCcRlKWsfumOex6ntUZo18Ho48MVnpf4W01/WL9Ov9vFN/O5HWG9GLBv2SGHzzqHTiJf2vVqsOAGpRn0YdsH+4us9X7XJywWj48Lj4YuLoEt6wUp4JojWtrtwtNHFCxvyA3O0vAag4gkQpbmyUqsZRSnnXJywj9uwl7aR5yQZmXVHy91g+t1lPj+ZN2ptsntUIgzUZ30Q4sZSaW+EM/ww0UyHik6E5eDTydZafdBRvDioFOceqlfamOlwkTOzvkyuHP1nxTmyhC8AvKEWq4H0OciU0hUy6E0IKm7l4b9q7LQ1EzdZIgIWd38lIvydF/RtDdHvQsK2Y1yJBcggAtCPeAYoW29HEUiQ4RXiy3BnYfWYtSBdJSWjk8eHCTMmOScyBHY7acmzjXTiKX0VcQRVL/KMauqnUO0uVaP3QFy5J8nLlz3QcmcUIQU09A1NhvHMeGnsiX/EUG87w9oxG868xxvSEMMI3Z7XolZhT2wVlODyUnZOvG4MhiXVCET2EgXR48jjRzzmxMXYN62sydRG0aT1Q/2jeElW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(346002)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799009)(64100799003)(6506007)(6512007)(44832011)(36756003)(2906002)(26005)(30864003)(38100700002)(83380400001)(41300700001)(31696002)(86362001)(7416002)(2616005)(5660300002)(478600001)(316002)(66476007)(54906003)(66556008)(66946007)(6486002)(110136005)(31686004)(6666004)(8676002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzY3THdOMHJFRkkvR2cvMGdyMkdmNDU4U2RSQ0JxUWo2TjVnM0ZLZkh6L3JE?=
 =?utf-8?B?bFlhY3llQUg4QUFYeWxFcDZPMHZGWk5ENjkzZGROcFpKWkZoZzdJNGNySSs3?=
 =?utf-8?B?SHZiZkV6YUtmYjcxYXNPWEs5cUh2WGd5WXJPOC9iZEZMTjhrT0VPSkVEUGt0?=
 =?utf-8?B?VDBDbitMTEVnQy9FYmw4c2RlMCtveld3Zzl4VndVZ1U1S29Gam9NMVFZR0Fp?=
 =?utf-8?B?Q3FhVHlpTzBPeWdJZ3RFc2pSN25TeEFVMTdYeUJsQ2NTOVF0VW13c3VqNnk1?=
 =?utf-8?B?VGNKUzlLU01qcjMzWnRzdU1MUFBvSE5DdnRyVWxiU001alFQdmZzRi91NDdx?=
 =?utf-8?B?QmFuM0U3Q1lxNi9kYlVuZHdrd3lKaHVmUG9WZU5iS3BhbjRyM283c1JFOFBP?=
 =?utf-8?B?bS93WWRhMWg3cWpxQUVUMUNSZ3BKaHA4MThGdCttSmN6SlpzN0RyOUNhaGRy?=
 =?utf-8?B?dmNBVkZ3QWozZ3V1bkp2OG5yanJWM3pRV0xsejdjNTZpNmllRjErcXdKeFU2?=
 =?utf-8?B?Y25DdU8vMGhWcXdqcmcwWC9oT3QybGllTHY1bnhoZGtXZFNrZm1wSlRBZkhG?=
 =?utf-8?B?VmtwbUhkUWRaMXRNMm9NWHQ5TTF5VWdSWE85V2N4ZmhGTzVablg0Z3lCZ2da?=
 =?utf-8?B?a2ZSSDRSZmtNUkRMdXZpMmlCZGN2dk5ZRDl3ZFprTDNEN0ZoVzludmhMdFVN?=
 =?utf-8?B?T0Z5MHNFNkxLZTF4S0pPZDJncERiKzFhaFVLeEVRSVdraEsxUFIvWDh1OE03?=
 =?utf-8?B?Mmc5MElodUllSlpTM09vTzBIaiszR243cjEwQ0pMY01CTXh2UmQwaHo4NU5R?=
 =?utf-8?B?MFQzM21jK0RSNlZrN3R6TW9IMk9mdzR3T28zQldtUUR4OUExK2ZwZWRuREht?=
 =?utf-8?B?eVBBZTJqYTVRT2ZVczZNanp1NXhyTE1adVJSdDMwOGVaa3VSemtNK3VKZUYz?=
 =?utf-8?B?MUE3QThYQ2J4M20zOGNjVkw3QlJlQmJBcFNyUFlwb0d3OEIzS2hxQzJPKzRQ?=
 =?utf-8?B?ZzdRTHZPQUxkT0JsVC95bGsxSFhFckhkUWhOWVova1hITDVsTGlKeWd2OVpo?=
 =?utf-8?B?THZJYkxZYm8zK25HYTN5dFMyVW1PblVFYklWUFZoS1BHTCtVRmxlTnlVRkQ5?=
 =?utf-8?B?OFdaUDJQSnAxaU9KS1ZuRGk0ZmlKK1JIbXl4UHdxUUd4cUlKemdwalZyZ1Z4?=
 =?utf-8?B?anB5MEpjUDdKbVU0bjIrMXhlc1dSMGNFSWhwUUtYcGdKTWwxUm5OV3k0MWdV?=
 =?utf-8?B?Mm8zZmpyc1Nudm1pUEM5eE5iQ0FlR0dkSzVBR0xVTFVVam55azhtRkpSL2Jz?=
 =?utf-8?B?WjFnWFg4S3ZmSFN2dzBRaHNWc0ttN1k2WEowUEtzTEJHaFNOZVJZU0tac2d5?=
 =?utf-8?B?KzFSamxwd2ZQUmZ6Y0syVlVJZERKdkpIZmMzdUtUWENLTnRWZDZSb2pBcVor?=
 =?utf-8?B?WlI0OTIvOGtDQnJmeUNLVjZZWkxzSGJUZldHSWZTSlZGZDNIdEJVYmRFdHNx?=
 =?utf-8?B?QktkM1l5N1ZPQzMzd1h5TnBPajdINGhwNjEzMmp5U0ROUDdVUnVZTk16NUJa?=
 =?utf-8?B?VXZBeHdqMjY0UWNuME5RRkp2QXVnQ1gzWVM3MkZsTUQ4S0QzdHZyR3FLYjVK?=
 =?utf-8?B?bW9uRlFyd1B6Wkdyc1VwdG9PYnNtTGVwSDVUdmE5aVp0L2lnRmRtbVBDdjJh?=
 =?utf-8?B?VUhZVWJVdE5jVWV3Z1JIcFJwdVkwbGFVL1doZFM4V21pdGFEdE1vRFFhL2ZS?=
 =?utf-8?B?ME5SWVBDc0pQTVB4Yk53WitzWVBlQ1JjamlDbk11dWlUTWlrTXJ4NFNXbWU3?=
 =?utf-8?B?U09TdmFLYUFyRFhtLytlZTdPQzZjVmdWWGtqdWFYNDBlK1pBOU40bHVvMUsv?=
 =?utf-8?B?UWliOExCT2JwUE8vV3RSNTVhU2t1Q0NFbU9kdUtxUkhWZ21PQlg0eUZhUElZ?=
 =?utf-8?B?WDdjbWdNdUNJak1oeE43WWFtRXd2OFdHMjYwNDVPd0xnM1RWbkFmbXkxakpM?=
 =?utf-8?B?NlFOQ05DdHUyYzhpVzdsV095ODNBSC9HdkxIRGRvRGdIVFRndEcxb1hZZVcw?=
 =?utf-8?B?aUNIUGo1SE5IUTFLSzQ3ZDM4NkNzeGpicmFFUUFScjVFZCtndnpmbDBGUHFB?=
 =?utf-8?Q?c/TGym7qMZLZ5egLgRSu25Afw?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f659728-5a6a-416c-415d-08dbe50cd5cc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:25:49.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cN+diD4yGcmnbt1Kq/j5Ihsgh8gtjigzjtX75FGjwA6FJF46gfspwKrL4s9+KsNiytL16vESlVXtwK15czsXXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8682
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/11/14 18:25, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Mon 06 Nov 2023 at 16:55, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>
>> Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.
>>
>> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> Just a few things to address
>
>> ---
>>   drivers/clk/meson/Kconfig  |  13 +
>>   drivers/clk/meson/Makefile |   1 +
>>   drivers/clk/meson/c3-pll.c | 895 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 909 insertions(+)
>>   create mode 100644 drivers/clk/meson/c3-pll.c
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index c5303e4c1604..eab796f3d25b 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -128,6 +128,19 @@ config COMMON_CLK_A1_PERIPHERALS
>>          device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>>          controller to work.
>>
>> +config COMMON_CLK_C3_PLL
>> +     tristate "Amlogic C3 PLL clock controller"
>> +     depends on ARM64
>> +     default y
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_PLL
>> +     select COMMON_CLK_MESON_CLKC_UTILS
>> +     help
>> +       Support for the PLL clock controller on Amlogic C302X and C308L devices,
>> +       AKA c3. Amlogic C302X and C308L devices include AW402 and the others.
>> +       Say Y if you want the board to work, because PLLs are the parent of most
>> +       peripherals.
>> +
>>   config COMMON_CLK_G12A
>>        tristate "G12 and SM1 SoC clock controllers support"
>>        depends on ARM64
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 9ee4b954c896..4420af628b31 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -19,6 +19,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>> +obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>> diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
>> new file mode 100644
>> index 000000000000..b663666e3755
>> --- /dev/null
>> +++ b/drivers/clk/meson/c3-pll.c
>> @@ -0,0 +1,895 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Amlogic C3 PLL Controller Driver
>> + *
>> + * Copyright (c) 2023 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
> What do you need that for ? you are not the using the clock consumer api.
Not used, delete it in the next version.
>> +#include "clk-regmap.h"
>> +#include "clk-pll.h"
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
>> +
>> +#define ANACTRL_FIXPLL_CTRL0                 0x40
>> +#define ANACTRL_FIXPLL_CTRL4                 0x50
>> +#define ANACTRL_GP0PLL_CTRL0                 0x80
>> +#define ANACTRL_GP0PLL_CTRL1                 0x84
>> +#define ANACTRL_GP0PLL_CTRL2                 0x88
>> +#define ANACTRL_GP0PLL_CTRL3                 0x8c
>> +#define ANACTRL_GP0PLL_CTRL4                 0x90
>> +#define ANACTRL_GP0PLL_CTRL5                 0x94
>> +#define ANACTRL_GP0PLL_CTRL6                 0x98
>> +#define ANACTRL_GP0PLL_STS                   0x9c
>> +#define ANACTRL_GP1PLL_CTRL0                 0xc0
>> +#define ANACTRL_GP1PLL_CTRL1                 0xc4
>> +#define ANACTRL_GP1PLL_CTRL2                 0xc8
>> +#define ANACTRL_GP1PLL_CTRL3                 0xcc
>> +#define ANACTRL_GP1PLL_CTRL4                 0xd0
>> +#define ANACTRL_GP1PLL_CTRL5                 0xd4
>> +#define ANACTRL_GP1PLL_CTRL6                 0xd8
>> +#define ANACTRL_GP1PLL_STS                   0xdc
>> +#define ANACTRL_HIFIPLL_CTRL0                        0x100
>> +#define ANACTRL_HIFIPLL_CTRL1                        0x104
>> +#define ANACTRL_HIFIPLL_CTRL2                        0x108
>> +#define ANACTRL_HIFIPLL_CTRL3                        0x10c
>> +#define ANACTRL_HIFIPLL_CTRL4                        0x110
>> +#define ANACTRL_HIFIPLL_CTRL5                        0x114
>> +#define ANACTRL_HIFIPLL_CTRL6                        0x118
>> +#define ANACTRL_HIFIPLL_STS                  0x11c
>> +#define ANACTRL_MPLL_CTRL0                   0x180
>> +#define ANACTRL_MPLL_CTRL1                   0x184
>> +#define ANACTRL_MPLL_CTRL2                   0x188
>> +#define ANACTRL_MPLL_CTRL3                   0x18c
>> +#define ANACTRL_MPLL_CTRL4                   0x190
>> +#define ANACTRL_MPLL_STS                     0x1a4
>> +
>> +/*
>> + * These clock are a fixed value (fixed_pll is 2GHz) that is initialized by ROMcode.
> "This clock has a fixed rate" ?
>
> Just wondering, is it really the ROMcode doing this ?
>
> I'm sure the ROMcode must do some init but from the information
> that has surfaced recently on IRC for the GXBB and GXL, it
> looks like the final fixed PLL init is done by the bl2. Is it different
> on the C3 family ?
At present, the clock source of most modules in the chip is fixed_pll, 
so fixed_pll is initialized in ROMcode as the key clock source of the 
system (before, the old chips such as GXBB and GXL were initialized in 
bl2, and the new chips were placed in ROMcode, such as S4).
>> + * The chip was changed fixed pll for security reasons. Fixed PLL registers are not writable
>> + * in the kernel phase. Write of fixed PLL-related register will cause the system to crash.
>> + * Meanwhile, these clock won't ever change at runtime.
>> + * For the above reasons, we can only use ro_ops for fixed PLL related clocks.
>> + */
>> +static struct clk_regmap fixed_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data) {
>> +             .en = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>> +                     .shift   = 16,
>> +                     .width   = 5,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fixed_pll_dco",
>> +             .ops = &meson_clk_pll_ro_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "top",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fixed_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL0,
>> +             .shift = 12,
>> +             .width = 3,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fixed_pll",
>> +             .ops = &clk_regmap_divider_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_50m_en = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_50m_en",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_50m = {
>> +     .mult = 1,
>> +     .div = 40,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_50m",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_50m_en.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div2_div = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div2_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div2 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div2",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div2_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div2p5_div = {
>> +     .mult = 2,
>> +     .div = 5,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div2p5_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div2p5 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div2p5",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div2p5_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div3_div = {
>> +     .mult = 1,
>> +     .div = 3,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div3_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div3 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 20,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div3",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div3_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div4_div = {
>> +     .mult = 1,
>> +     .div = 4,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div4_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div4 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 21,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div4",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div4_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div5_div = {
>> +     .mult = 1,
>> +     .div = 5,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div5_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div5 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 22,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div5",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div5_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor fclk_div7_div = {
>> +     .mult = 1,
>> +     .div = 7,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div7_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div7 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 23,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div7",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div7_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence c3_gp0_init_regs[] = {
>> +     { .reg = ANACTRL_GP0PLL_CTRL2,  .def = 0x0 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL3,  .def = 0x48681c00 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x3927200a },
>> +     { .reg = ANACTRL_GP0PLL_CTRL6,  .def = 0x56540000 },
>> +};
>> +
>> +static const struct pll_mult_range c3_gp0_pll_mult_range = {
>> +     .min = 125,
>> +     .max = 250,
>> +};
>> +
>> +static struct clk_regmap gp0_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data) {
>> +             .en = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 9,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 19,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &c3_gp0_pll_mult_range,
>> +             .init_regs = c3_gp0_init_regs,
>> +             .init_count = ARRAY_SIZE(c3_gp0_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gp0_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "top",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +/* The maximum frequency divider supports is 32, not 128(2^7) */
>> +static const struct clk_div_table c3_gp0_pll_od_table[] = {
>> +     { 0,  1 },
>> +     { 1,  2 },
>> +     { 2,  4 },
>> +     { 3,  8 },
>> +     { 4, 16 },
>> +     { 5, 32 },
>> +     { /* sentinel */ }
>> +};
>> +
>> +static struct clk_regmap gp0_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_GP0PLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 3,
>> +             .table = c3_gp0_pll_od_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gp0_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &gp0_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/*
>> + * The register corresponding to gp1_pll has permission restrictions,
>> + * The corresponding register is read-only in the kernel.
>> + * For the above reasons, we can only use ro_ops for gp1_pll related clocks.
>> + */
>> +static struct clk_regmap gp1_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data) {
>> +             .en = {
>> +                     .reg_off = ANACTRL_GP1PLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_GP1PLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 9,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_GP1PLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 19,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_GP1PLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_GP1PLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_GP1PLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gp1_pll_dco",
>> +             .ops = &meson_clk_pll_ro_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "top",
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_GET_RATE_NOCACHE,
>> +     },
>> +};
>> +
>> +static struct clk_regmap gp1_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_GP1PLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 3,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gp1_pll",
>> +             .ops = &clk_regmap_divider_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &gp1_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_GET_RATE_NOCACHE,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence c3_hifi_init_regs[] = {
>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x0 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a285c00 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x56540000 },
>> +};
>> +
>> +static struct clk_regmap hifi_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data) {
>> +             .en = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 19,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &c3_gp0_pll_mult_range,
>> +             .init_regs = c3_hifi_init_regs,
>> +             .init_count = ARRAY_SIZE(c3_hifi_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hifi_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "top",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap hifi_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_HIFIPLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 2,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hifi_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hifi_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence c3_mclk_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL1,    .def = 0x1420500f },
>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023041 },
>> +     { .reg = ANACTRL_MPLL_CTRL3,    .def = 0x18180000 },
>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023001 }
>> +};
>> +
>> +static const struct pll_mult_range c3_mclk_pll_mult_range = {
>> +     .min = 67,
>> +     .max = 133,
>> +};
>> +
>> +static struct clk_regmap mclk_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data) {
>> +             .en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &c3_mclk_pll_mult_range,
>> +             .init_regs = c3_mclk_init_regs,
>> +             .init_count = ARRAY_SIZE(c3_mclk_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "mpll",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct clk_div_table c3_mpll_od_table[] = {
>> +     { 0,  1 },
>> +     { 1,  2 },
>> +     { 2,  4 },
>> +     { 3,  8 },
>> +     { 4, 16 },
>> +     { /* sentinel */ }
>> +};
>> +
>> +static struct clk_regmap mclk_pll_od = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_MPLL_CTRL0,
>> +             .shift = 12,
>> +             .width = 3,
>> +             .table = c3_mpll_od_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk_pll_od",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk_pll_dco.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* both value 0 and 1 gives divide the input rate by one */
>> +static struct clk_regmap mclk_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .shift = 16,
>> +             .width = 5,
>> +             .flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk_pll_od.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data mclk_parent[] = {
>> +     { .hw = &mclk_pll.hw },
>> +     { .fw_name = "mpll" },
>> +     { .hw = &fclk_50m.hw }
>> +};
>> +
>> +static struct clk_regmap mclk0_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .mask = 0x3,
>> +             .shift = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = mclk_parent,
>> +             .num_parents = ARRAY_SIZE(mclk_parent),
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk0_div_en = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .bit_idx = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk0_div_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk0_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .shift = 2,
>> +             .width = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk0_div_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk0 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk1_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .mask = 0x3,
>> +             .shift = 12,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = mclk_parent,
>> +             .num_parents = ARRAY_SIZE(mclk_parent),
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk1_div_en = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .bit_idx = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk1_div_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk1_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .shift = 10,
>> +             .width = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk1_div_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk1 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_hw *c3_pll_hw_clks[] = {
>> +     [CLKID_FIXED_PLL_DCO]   = &fixed_pll_dco.hw,
>> +     [CLKID_FIXED_PLL]       = &fixed_pll.hw,
>> +     [CLKID_FCLK_50M_EN]     = &fclk_50m_en.hw,
>> +     [CLKID_FCLK_50M]        = &fclk_50m.hw,
>> +     [CLKID_FCLK_DIV2_DIV]   = &fclk_div2_div.hw,
>> +     [CLKID_FCLK_DIV2]       = &fclk_div2.hw,
>> +     [CLKID_FCLK_DIV2P5_DIV] = &fclk_div2p5_div.hw,
>> +     [CLKID_FCLK_DIV2P5]     = &fclk_div2p5.hw,
>> +     [CLKID_FCLK_DIV3_DIV]   = &fclk_div3_div.hw,
>> +     [CLKID_FCLK_DIV3]       = &fclk_div3.hw,
>> +     [CLKID_FCLK_DIV4_DIV]   = &fclk_div4_div.hw,
>> +     [CLKID_FCLK_DIV4]       = &fclk_div4.hw,
>> +     [CLKID_FCLK_DIV5_DIV]   = &fclk_div5_div.hw,
>> +     [CLKID_FCLK_DIV5]       = &fclk_div5.hw,
>> +     [CLKID_FCLK_DIV7_DIV]   = &fclk_div7_div.hw,
>> +     [CLKID_FCLK_DIV7]       = &fclk_div7.hw,
>> +     [CLKID_GP0_PLL_DCO]     = &gp0_pll_dco.hw,
>> +     [CLKID_GP0_PLL]         = &gp0_pll.hw,
>> +     [CLKID_GP1_PLL_DCO]     = &gp1_pll_dco.hw,
>> +     [CLKID_GP1_PLL]         = &gp1_pll.hw,
>> +     [CLKID_HIFI_PLL_DCO]    = &hifi_pll_dco.hw,
>> +     [CLKID_HIFI_PLL]        = &hifi_pll.hw,
>> +     [CLKID_MCLK_PLL_DCO]    = &mclk_pll_dco.hw,
>> +     [CLKID_MCLK_PLL_OD]     = &mclk_pll_od.hw,
>> +     [CLKID_MCLK_PLL]        = &mclk_pll.hw,
>> +     [CLKID_MCLK0_SEL]       = &mclk0_sel.hw,
>> +     [CLKID_MCLK0_SEL_EN]    = &mclk0_div_en.hw,
>> +     [CLKID_MCLK0_DIV]       = &mclk0_div.hw,
>> +     [CLKID_MCLK0]           = &mclk0.hw,
>> +     [CLKID_MCLK1_SEL]       = &mclk1_sel.hw,
>> +     [CLKID_MCLK1_SEL_EN]    = &mclk1_div_en.hw,
>> +     [CLKID_MCLK1_DIV]       = &mclk1_div.hw,
>> +     [CLKID_MCLK1]           = &mclk1.hw
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const c3_pll_clk_regmaps[] = {
>> +     &fixed_pll_dco,
>> +     &fixed_pll,
>> +     &fclk_50m_en,
>> +     &fclk_div2,
>> +     &fclk_div2p5,
>> +     &fclk_div3,
>> +     &fclk_div4,
>> +     &fclk_div5,
>> +     &fclk_div7,
>> +     &gp0_pll_dco,
>> +     &gp0_pll,
>> +     &gp1_pll_dco,
>> +     &gp1_pll,
>> +     &hifi_pll_dco,
>> +     &hifi_pll,
>> +     &mclk_pll_dco,
>> +     &mclk_pll_od,
>> +     &mclk_pll,
>> +     &mclk0_sel,
>> +     &mclk0_div_en,
>> +     &mclk0_div,
>> +     &mclk0,
>> +     &mclk1_sel,
>> +     &mclk1_div_en,
>> +     &mclk1_div,
>> +     &mclk1,
>> +};
>> +
>> +static struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +};
>> +
>> +static struct meson_clk_hw_data c3_pll_clks = {
>> +     .hws = c3_pll_hw_clks,
>> +     .num = ARRAY_SIZE(c3_pll_hw_clks),
>> +};
>> +
>> +static int aml_c3_pll_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct regmap *regmap;
>> +     void __iomem *base;
>> +     int clkid, ret, i;
>> +
>> +     base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +     if (IS_ERR(regmap))
>> +             return PTR_ERR(regmap);
>> +
>> +     /* Populate regmap for the regmap backed clocks */
>> +     for (i = 0; i < ARRAY_SIZE(c3_pll_clk_regmaps); i++)
>> +             c3_pll_clk_regmaps[i]->map = regmap;
>> +
>> +     for (clkid = 0; clkid < c3_pll_clks.num; clkid++) {
>> +             /* array might be sparse */
>> +             if (!c3_pll_clks.hws[clkid])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, c3_pll_clks.hws[clkid]);
>> +             if (ret) {
>> +                     dev_err(dev, "Clock registration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
>> +                                        &c3_pll_clks);
>> +}
>> +
>> +static const struct of_device_id c3_pll_clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,c3-pll-clkc",
>> +     },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(of, c3_pll_clkc_match_table);
>> +
>> +static struct platform_driver c3_pll_driver = {
>> +     .probe          = aml_c3_pll_probe,
>> +     .driver         = {
>> +             .name   = "c3-pll-clkc",
>> +             .of_match_table = c3_pll_clkc_match_table,
>> +     },
>> +};
>> +
>> +module_platform_driver(c3_pll_driver);
>> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>> +MODULE_LICENSE("GPL");
