Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F7E7EBE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjKOIBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOIA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:00:58 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2113.outbound.protection.outlook.com [40.107.255.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A86ADF;
        Wed, 15 Nov 2023 00:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnUBaRdsRy1itpY8GbK8seVyCYE6fiDsueaV3wKk1GZR2b0KeVLIJa9KI/kBi7my/UgTcQcjlQqI7E9RH/BAuvll/eGJNgJ/eFjgzSszeK0ZK+MRA0M8YsTIVcEighW7nsY/fnRGICYeFq3FI62fR+lRygmutvhStObfN6hddb2tYpPyNyvqHf80HU2WtnHoxJesHygmnhb6L6wCSuH7uIstNBwmAKoDLD9rdBvbBqjHjS+252PmivgKVUvk3RBvm0NPKu9HYRbWOb0SiClEXXXm+ESHyspVN8YiRBALNCDLgRnMtsKxtu1N0SzoDq2Ni5NPYsma+gYEFkzrENJjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1URQbptIF7/IttYDh8T0nJMYMq83SDtavJhviliuFA=;
 b=Ac0OWcrjpoIwYyjYwjTZXvgD+Q/JPa+iVUQMLcROs4CwWeAznZL60WcvVVCNYl3Xw4A4O1rh1N5mtY1NDMJBDL0NsLQCoYNh6DRo0Rrr0S35b0pAQvhDsYd0kTyV54RbOT7a4PpDsPtMPuFpNiKI+KWESJyB9qZcjtkRWcNh9jOT25hci71K/sSTVvtQjAhdQ79nqb4kCUYnP2bsl02ZS6kZgXQLMljLK/0grjVkbqAg8p212vCJWzmCrLkVSH0KZWQEMZeWDosjZX+Z3LttosXvxPNwIsZwf4ZMVMiyLlLlRr0avpuYxlu/BYbniXSXVsbH0wo0LuQvizYb9GWYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1URQbptIF7/IttYDh8T0nJMYMq83SDtavJhviliuFA=;
 b=JCV1xOXhs+Pvmwsb/PELTzt7qUr82NWP3Z7a3VCrrMKEQdi7ivgYVR0vZhSVR7u+84Qx4SiX+wvsiox0DGabdrZ6VeRRrOzc3zdFpb1wevglAjWKKEUI55FifKOE/g6+lkVMyq6TY2YpaIe/hhZuea/b/sPbDVg1fb3r9CFl95uJ1HXRyXf8iXmLMKWOl3w0C8rq8celczev4Aiz41lm52Fjqpr9WF19yz6l+Trdaj/LvE5LQmZ+ZE4hnHkWNKzmh5292dVjf/Ge/TjIi9TS0R/MUEOkZYsuCB2kddUOSwFEEWapOuIi4Q5ICjv0q1CRkmfuaW7sZ7k28R4u9oNpng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY0PR03MB8348.apcprd03.prod.outlook.com (2603:1096:405:18::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 08:00:45 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::31a7:e96f:8abd:9a10]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::31a7:e96f:8abd:9a10%6]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 08:00:45 +0000
Message-ID: <aa6a06a6-7b3e-4598-ab3b-5fa9ecb93aaa@amlogic.com>
Date:   Wed, 15 Nov 2023 16:00:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/4] clk: meson: c3: add support for the C3 SoC PLL
 clock
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
References: <20231106085554.3237511-1-xianwei.zhao@amlogic.com>
 <20231106085554.3237511-4-xianwei.zhao@amlogic.com>
 <1jttpobov2.fsf@starbuckisacylon.baylibre.com>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jttpobov2.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::31) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY0PR03MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f180a6-f0a8-49d1-f272-08dbe5b0f846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcBWJK7m6Y5iU5k9YIJPmWc5GIej549SYFYyqpGpbWa3huzIddGsjp2hGxuG9sKLbiX5iMQ1pCTKG77OounU6JvpTdvrgx1lS1BlAJjORDU3GpqlSZCtDM5h0HoCVVcyH5LPro7RAJO1ylkxU4V6lg5wmA8zpUvsBJyy0ROg3Z76Urc2N6SWmKk0PIyXJSWlGvY8Ix6r8klyuZ0QYUVM8UFe8L+9ShKcjYSrnczla0wdNGnd9XVHS2SL+oumgEY4phFip8X6YaTVWb4VyxJ8Oyr9aY5Ld8RAQlRM6j2QBjpakH6KTcqC+itgjgClLV6tbj/ph3GJp3py3xnuFB3BCZlI7UQkr8tYK6z+E5d9hWF1isDG+J3eoXBfTwhIO7P6NyS+wPgE5eOVZoxasS33rOXU/T0vaOC+RjgNeXYiNxLkeLv//KyBnH7QDS3s78H53pWXaff3obgM8fXMm1L6yvGY9fSUkeC5oQJ+tg6Z/ZUb+X/dMwu5+PGBZo73l8R8PxkVzRv54WpJdivxKM2KcfPgEedV61LcR4QiAHArp3D88sqa46znpv52anAMzhv9jHNCOCxnWSV3XvWqig/LNsBy74vHbff1yvpxDZrxO7Z/JHWZI2xdYQjvocwA2mYHpm8IkbMx3Aei5mTmnar0rDWzE5p+tiJu/ejtUsILwP0A2zC/fhyIz9GqqHR9PhVDt5IERav5V+0Kjt2UR0ENR1HP9jwI5tzY6u0Yk9MbuHuwMhqtfMXJmJ1FEo2amtlc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39850400004)(366004)(396003)(136003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(54906003)(66556008)(66476007)(66946007)(107886003)(5660300002)(478600001)(316002)(8936002)(8676002)(4326008)(31686004)(6666004)(6506007)(6512007)(44832011)(41300700001)(31696002)(86362001)(83380400001)(7416002)(2616005)(36756003)(53546011)(38100700002)(26005)(30864003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmQwb0lpcFAxOXZBaTVISk9OOVR1QzZweUwwam83STBwNlB1VDF3NzJuS1J2?=
 =?utf-8?B?ZHdVSG8xR0dKZCtBTVEvS2RNY3p3SnE0clJQOE5DVHF3a0Ztakhrb2g1YUxY?=
 =?utf-8?B?RkZJK0JUOFdjTmxkL2RQU09Ea1RiamVVS09zbzd5MWg4TzhONElpdVR4UTZl?=
 =?utf-8?B?Z2lKcVBhYzdwak9uMGx6N0lrUFFZK3RBd3YzSzI0N1NtcHFyUU9GcUhOM1N1?=
 =?utf-8?B?bmJzTHlOYzZSSFJjZGE1cXFJSE9HWkN3QzI0VGJTLzQzVVg5QTdsUHRqQmQ3?=
 =?utf-8?B?c0FLeW5jZ2hIYU9wVWZwNDNIS1FmWlkya1ZieUJ4czRRRTFSRU85RTgrYUFo?=
 =?utf-8?B?YWlHRUtpSXlEMFhudFZLRHprMkhmU3haMjFRVGZqTlRiRDgzTWFpT1VVU1JJ?=
 =?utf-8?B?KzNmckNRV1hMeXhWdXg4NzU1U2NXdXA1TDdhU3ZiWFpDMFhDZGFQRTZJV0FU?=
 =?utf-8?B?Z0tvL3FNSGwvbW45NGEvc2dwNjAzRngycm5teVY3MyswNVd6MVNLRjMwRlhj?=
 =?utf-8?B?MDI4VG91S3BiNG1zd2ZFN3RGOWRtOEFBRUlVazR1bDR5Qytic2tIc2lTQmZx?=
 =?utf-8?B?bmI4am5zeCtDaVJZbTBRbS9JU3RiZUFqMGlXL3kyZStXTDlYay9wZ3BkS1dG?=
 =?utf-8?B?eVkwTC93dUJ5cjR2cEg5RUZBRURpNUt1V3JYamJRWHNnbFQybXVwdDlXZ01k?=
 =?utf-8?B?UHZwOUFEZUdLYTFkY1FNNmlWZFhGUm1kMDI2dFlZRVVJWWlOVGNleHlZdUN4?=
 =?utf-8?B?U3BqWW02NW5CRUx3TjVhRVRQYjRaeEJxa0JEQVp2d0YwYjltYkszOXhQSGNk?=
 =?utf-8?B?SkVkc2VlQkRwZ0lQZXVJS3ZBdmU0Y3k3bGlRdGs1djNBVWRjZjJ4KzFXUTly?=
 =?utf-8?B?Rnc0R3g4c1RpeVA4SThTbTViWVZmQTNDS2pvYjVwbDdYdXAvZmVmNFRncFhn?=
 =?utf-8?B?WTlZWDZvZ0VVSkwrTXJHRmFybHBHMmZFWDQrVmNPb1h0eWhBY2l0K0VMdTVm?=
 =?utf-8?B?N2NINUNJdjh0bFRMYlI4K1EyTDVjcXc4bmJrZ1dUWkdwREdZb0VkanhOUmpk?=
 =?utf-8?B?Q2lmY3VmVE1JRW4xZElmSUJTdEhVcFM4Y2ZzVldYaEEyT29MNHlyLzR1S2JI?=
 =?utf-8?B?Q1VKbXVLWE1Fb1JVaXdaOVA5azZtb1UxSUxsaFlyTmxwb21nRkF6R1V5cGZ1?=
 =?utf-8?B?WjhLb25jTFJaaUlsWHovV0VBVUVlSm9NbTlwd1FqL3FUenZpRnNibVB1WkF3?=
 =?utf-8?B?WnZ5T0ZhckRQckhCMkhWek9UaTJ4Kzd6NEhKVmxLV01RQkFrejIzd3lVSTNN?=
 =?utf-8?B?YVd0cFM3THNVY0VkZ293SHZjQmllUXcvMU8zV2k3Q3Vva01JSHlxbXFXZXVp?=
 =?utf-8?B?b0JNTTJVVVA0eVExb2tvUnFCTWdGSUxaQWNDOThQdGx5RlFhNHY4bEJnR2ZR?=
 =?utf-8?B?L2ZtUWxDWnUyMVhETm9vaTJqNkZqTlVON01HZ2wyS25pKzN2c2k3d2tWc29S?=
 =?utf-8?B?K1NvV25jUnJkQUxsV3k0YXRiMzg0bHE3eXJrMTFjT1czNkhKVUdsNzF0bWw0?=
 =?utf-8?B?ckN0SjZ4NmJ3SGlYRlpqSE9zdW1McmtpR001UXVlc1pTSjh6R0MrTVVHZG03?=
 =?utf-8?B?RFJFMSs0bklsdWlwOVR0bytSMC9sMkl6dkpvR3o5bnVGTkZ5T0drQVpSVXlU?=
 =?utf-8?B?a2ZnY21Wa1NLb21ZUi9pWnFWQUQrOXBxd2FlcThpT0tHTFF0TU4xbjNMeFpC?=
 =?utf-8?B?RjNrZVNiU2l5YTVkL1RzTmtKemtSNDdZNmNBdTBIRE1RRCtISnUrejBlRk1Q?=
 =?utf-8?B?Y25uRFd1eVd5dXBzK1lKb3JsK1d3dGpGOWU1VTFiNEV6SFFsVDg0NmNOaTZw?=
 =?utf-8?B?elI2RFExMFRDSFNMaDFGbXlxWlljVEtoKzRmcEF6V2tZR1prVVErYjQyM0dI?=
 =?utf-8?B?T1BMWndnZkdQSmc2Y2c3dVpBNWFhSWh1WE1NNW5zZGdXNVNpSnJMWXBPMnJT?=
 =?utf-8?B?alBndzVaV1J0YklVTWJYaWsxWGcxcm01eXFFT0dxK1RnU0x2eVBMY1ZwY09w?=
 =?utf-8?B?emd3WVZjQjJrUDU1UEtyZHNIR0lUSDVuNlBUcUorQTFaVTg3YWl0Z0ZyQ2dM?=
 =?utf-8?B?dkhySFVnc3dNUlEycVF0TW93cW5BQUFBUThyd2kzdTlDaEVqQ29ZUUhkb1My?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f180a6-f0a8-49d1-f272-08dbe5b0f846
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 08:00:44.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAARyZhDPT7emAR1EDzbt4u1Ga8Lg1fqf4Be5PkKuDKtkkT7+GKzjvcT9KW2UmED3JITuY8/QpjBEGSIkMf8dV7MRjUZys0hbU0nCiQJA6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8348
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,
     Thanks for your reply.

On 2023/11/14 18:25, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Mon 06 Nov 2023 at 16:55, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> 
>> Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.
>>
>> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
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
> 
> What do you need that for ? you are not the using the clock consumer api.
Indeed not use, will delete it.
> 
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
> 
> "This clock has a fixed rate" ?
> 
> Just wondering, is it really the ROMcode doing this ?
> 
> I'm sure the ROMcode must do some init but from the information
> that has surfaced recently on IRC for the GXBB and GXL, it
> looks like the final fixed PLL init is done by the bl2. Is it different
> on the C3 family ?
Look at Chuan Liu's descriptions.
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
> 
