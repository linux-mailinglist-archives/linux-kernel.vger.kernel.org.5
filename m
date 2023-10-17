Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539DF7CBAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjJQGRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJQGQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:16:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A1DF0;
        Mon, 16 Oct 2023 23:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0kyFpZAkeUBuAIb62Z8AMDweujSenFkTD50raf2INLu0bUot3T+R6mNl7j/a4bIdmhGTnYFBG3E4J+gYQsAfad4dEBTdBKxrQN3BszUR6Ve1Dw1euksf3l5iv1A/HcESquz9AXXsbENHyU+RZrfbJ0FctvDFm6kfDjyVwCVOS3y9LaNhpXyEAFd7cIoh8PyQMkhNVPz3seBY8TeyQgzGu8SWgipyaVWnWS2xk6ep96nDlN9OvkHmRMwGm6LZuUxE0hAO+kF6z6sSzFahFDs+JYJwXR9yRdtWH/R+eglyY38Bcao46ZmbfzcCuOn6fJwdMhkPn+rhrAYZZpyB5MeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp/SQ/wqMpsrkmhDxWc8rKOhVk+yRiLdcrBmk1SzIkg=;
 b=YNTty2B+Hduf27UmkOcTSUhaqqlI01jLaZ/vx3udGviUygN3SmNAszCrN6go2V+WGNRH3rpg9iAPIaz2+cb2aCIfA7jIy/v7JrEdEbqjShOfjzlP07HMrZOUu7BY8sVcd/j0PdMOjN8AofgwuP5CtOs7DQYp8LX2MPkemPRsRl8+P+SadkU4J6EyrXaoSHIoD7ve7PYb5Tttcr8it76/ooMSS3sqCcgI7lXJJ57XCsRIufElVz12J9AGc6PkvuDfZjGVKMtSoS27xhEqiC43x9XMZx6+VI6gwj+jIvVojIkuwOcnPrm/E3DkEDdeUKYDzhp8qjTZeyAvHTnLG2XIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp/SQ/wqMpsrkmhDxWc8rKOhVk+yRiLdcrBmk1SzIkg=;
 b=uxV5Po2un3YC+twFzgoUx9WmdEuuI1RB5cxe98dab7ZVzijdB3mP4Bve3NF6VWXNnDLZHV2+VYthq5fLP7o+q44grpuPYeQ4pX/AX+yabgLziBOhYewaxMuUI/7iH5DJiCWySjwuccpsSqmYgimjNhy5SvOFU0n8E5AdvYBsnr055C2oehyEWjaTIWGxjrxxqp+Q8nqskRkrS+6OE9jnVUNLpaV+tpWbESTbtBLKt5da2j5txOwiIo1zLFO/nUph86+FqjTjc8Icp48P784gh+hMQM30A02G2R0QSJONlXspBNKGQeLW3jSRbz5C+pkSmgvX6zS6JaOV6IE4QqCRVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SI2PR03MB5513.apcprd03.prod.outlook.com (2603:1096:4:123::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 06:16:03 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 06:16:03 +0000
Message-ID: <3238e57a-1141-53ad-8170-c6ad9df03acb@amlogic.com>
Date:   Tue, 17 Oct 2023 14:15:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH V2 3/4] clk: meson: c3: add support for the C3 SoC PLL
 clock
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
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-4-xianwei.zhao@amlogic.com>
 <1jil7ax64i.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
In-Reply-To: <1jil7ax64i.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SI2PR03MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 70719a3a-e69f-4035-5578-08dbced889e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOoQelbb20khlR+2jjVLdm2EjIw7c3Gbybxfj8UTQ2F5owm5qhZDzaiM0+lc7mGrTr9Kt1JOLngcQ91CTj60OBgWTdbN8HdcbqmZqXbXfOeNHCgr3c4t+2KNXvof8UL+lWMMDxdxegraOySnPyy4D4KRvA3sF433klwI6wVCmSzynov9Wb/YDYaPAu38CbwVJkhmtnFa2JJn5ZV5OfXJsN06NS/+WA2IdPiIybS3UMhqOXg2U3LmFoPTQmiiGdSaDpY01BxUGD/PJLF1GLM86cQS5/DOqIJUvEqLvc69Ny8mjdIktY7Y3Uu/UVM5ZiQhAFVkRVI8uYoYFjzAAuhh7hTTkZVrV0BYbEvJtgq2iD0nwAKWLHfudqfXb6bMRuZXWSz2jPcHlKR7XvoLdNvo8KoDj3s9Z7OPQLNB6RmdfKKvmgE9ICsDY8s4os3u9w1venL/0gyj5BvibDB/n3MSV9ppxl95fuFTYWWr2q3P2/2dvyl433qVXHLobqYXJCGKPERyN3CILDqLQA3wjInNY13IowMJLxKAtI/eiBB55oJMglqRjtqebwSyfmDhZUddCfRwYLDY5SpwEJoGOtaXuKKK09G+JGBA7zHVigRsq3hOsiBov4P6OY8biSy9HjdtBGySibprcryGfajzfoHyc7+4ZHr1BxqQx2tUy/y+v0+ANVBcJC76PCqP/wUH3xssG8P4vpytDXoOO/hqMJ1ZTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39850400004)(366004)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6666004)(107886003)(6506007)(53546011)(6486002)(478600001)(6512007)(66476007)(316002)(66946007)(31686004)(26005)(2616005)(36756003)(83380400001)(54906003)(66556008)(41300700001)(38100700002)(44832011)(5660300002)(7416002)(30864003)(8676002)(8936002)(4326008)(2906002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N216WUcwVXNEdW1UZTZlTVoycUxva2w2VTVobkZKU3lMM0ZFMnhNejAya2JP?=
 =?utf-8?B?WjV4UFJPeE1wSFhKSHpNTkE1OTFBV0Z6TzEyZWdDcXdTY0dIdmlhNTVTZUVP?=
 =?utf-8?B?V0tIalpKZGQ5RkZUOC9hVkl0eUFTSHZVVE5VWENIRllJLzFkeng4Kzl3RXRu?=
 =?utf-8?B?UUdSOW9OL1Rma2d6bWJPM0JLOXFyU0x5d3Vvb0JKTmUzWUVkLzR1SXNQWS9Q?=
 =?utf-8?B?MTBueG5BenVuNHdVWUg0RXBTaUVtYXpJenRhVWFBM3poK2N4c1ZXUm5QZXFq?=
 =?utf-8?B?Ry9RbU1oT1lVMllSZGNOVlU2T1ZFMEtxL1VMbHQ4YysrdExqUVpjdWpzc1JF?=
 =?utf-8?B?d1RoTGhmbHJOL3I3RHpFZkxuUnIvbFFQekZ3UjJDa2V0YkhxZU9LUGM1V013?=
 =?utf-8?B?bUpFMjhRVml2RXB5dk9UeHFjK09CSVJGRlNnUVAxU1ZDMWVlTDdsM25Gbm95?=
 =?utf-8?B?clpJMXk0T2ltbDh5V212RVIxVGZYOW1DQ1ZhL1lqK1Mrb3ZlREdHaFBIbTZ0?=
 =?utf-8?B?VzExR0gwS0p5UndNQ3JKUDlpdVcyZGhwMW01TUZNc2lLK0NRMmdEc3ZOZyt4?=
 =?utf-8?B?YXRscFZTSVlYdWRrM1pqZTA1Ym5JbzJZZHc3Ukt0V1BPNW0vdmlnQyticXEv?=
 =?utf-8?B?a3VseW9Hbkl0WXdUSFBIaEVxTEw0K1BQNXJrZTFReFdSak0xTUdSdExNcFdz?=
 =?utf-8?B?VUxLdUZFU1E3STB5Y0Z0U1hXbVJNSlNYbE5yeVh6ampiS3ptWVoxUC96Wnht?=
 =?utf-8?B?Ty91UEJLVjVtM2x6cktRSUpiSTRGQkR2cThJL3VwNVc2T3h3emFLTzkrOVRo?=
 =?utf-8?B?Y1JMOG1DTWRBdWJoNTBObGFGL01TS2N4b2Z1QzB6c2JwdTJCK0lFdW5IVEc2?=
 =?utf-8?B?S2huSnpLK2ZKMm1FWXp2NGVPWU4yY0N5Y0lXK3RxQ0FYSy9QdWZlbzV6UlVa?=
 =?utf-8?B?S1lnbVRlQlZ2OEJEUzZnK0JXZ2VZTXJ5Qm54OElRek9IYW01bnN2NjNTUys5?=
 =?utf-8?B?eVJ2a0s0b05xQ0hINFlzcnVVdnFCLzNTRi9HTG5sMVRkRTdCRjV3a1daRSs5?=
 =?utf-8?B?bzFVMVJTRGEySWptRXFrN3dCT3JVditucVd3V2JUZWRvL2ltR0VJeVVqY09H?=
 =?utf-8?B?M3dwYlR6MXUxanNhRnFRZHFZbDVYeGJibTJTZENxQjRuNm9Eckp0THhadWpQ?=
 =?utf-8?B?SHN2aFl4ZkNQNk9jZjgwVjlRVEprcXNrTEppNXpzb2wwZU84bFJBYlE3UXdB?=
 =?utf-8?B?RlNmNTZpOUsrdk11ZGdtZmdRUGhxS2VnbDErSzl0SmthMmYwOUZQa0xvZ1Nl?=
 =?utf-8?B?RUhweUd1QkkyK1dMbnlTNi9nenVSRjE0Q2dzdTdiN0piN2dzVG9TL3k5NTNF?=
 =?utf-8?B?SWdaNitwaGVsS0JRck1qVGlJN2N3YStSM1NJU2ROeDJUMGhDQkg4QXVteTVM?=
 =?utf-8?B?ZjhwTWNvQ0FOT3AzbjUzZkgzOGltUUdmOXNaaGxNZTJpR2lCT0xhZ0pjYi9j?=
 =?utf-8?B?MTZxUUxIeVV1QXJVcGs3TWVGS2t3cjVMNUh0ai9jUFI3TlRPeUJqTkVyQk82?=
 =?utf-8?B?UFpWRWZhUm1hWHV1TTcvSXhVM3Nud1pCMjZOWmhOM2lhZEYvcVZxdWp0TlFJ?=
 =?utf-8?B?YTV1VjJjRGdLckk1UXZWSlY4bXhqNVFaSjlsdUNXVE14cTlnZ2dvWGR4L2Zu?=
 =?utf-8?B?djZPaVVwZ2lCbWc5VlczSXVTMFRRWEYxNU8yWStvVlpPc3g1NFE5WStYZDl1?=
 =?utf-8?B?YWNIYkNBUm45YWowdjFiV1Q3ZnlsNWk5VlpETkIwT3V4UUx3aE91RElDNmh5?=
 =?utf-8?B?UGZSWjU4QmtKTC94QStDeXRGRjZSaDAwYmxLdHFHYkpIRmhndEM2Qy9MWU45?=
 =?utf-8?B?OVkrdCtVcE8wUWdHOFhlWDRVekM0Q3g2b3BrY2RTT0pzQitPdHF5NzBIaHkv?=
 =?utf-8?B?K1ZyUGpEc3puU0NBSmM3MU9wODhRUHE3aXlUaFNVeWFXcGtHZkdud1AvdGhx?=
 =?utf-8?B?d0FiTVl0RTZlTmFNVTFwL21rZExYTkR3cHFmR0hmSEdYdjBtM1M5TVRkV3pU?=
 =?utf-8?B?TjRoeXdZTjRXREtRanVsbis2aXBPMkJMNWJtOUxSeWllUGxKbjkwaFZibjMz?=
 =?utf-8?B?WXhRRkt4TjJFcTR2QmZEbWRkUEp1UnVodm5sNHFVY215RXRwZ2Y1ekhoMzZK?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70719a3a-e69f-4035-5578-08dbced889e6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 06:16:02.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pTIxGpyT+cqnPUMIxNvdYBQ7CJpXXne1kkmYrp8OV5JjWNFdhDXcDcNxkpKjSzA9xJDqFSZF/s8kbqO17xd0ACy5kJ59kIXANUhHwmwXmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5513
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,


On 2023/10/13 15:49, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue 10 Oct 2023 at 14:29, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> 
>> Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>> V1 -> V2: Delete macro definition.
>> ---
>>   drivers/clk/meson/Kconfig  |  12 +
>>   drivers/clk/meson/Makefile |   1 +
>>   drivers/clk/meson/c3-pll.c | 808 +++++++++++++++++++++++++++++++++++++
>>   drivers/clk/meson/c3-pll.h |  35 ++
>>   4 files changed, 856 insertions(+)
>>   create mode 100644 drivers/clk/meson/c3-pll.c
>>   create mode 100644 drivers/clk/meson/c3-pll.h
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index c5303e4c1604..76be4bbd2afb 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -128,6 +128,18 @@ config COMMON_CLK_A1_PERIPHERALS
>>          device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>>          controller to work.
>>
>> +config COMMON_CLK_C3_PLL
>> +     tristate "Amlogic C3 PLL clock controller"
>> +     default y
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_PLL
>> +     select COMMON_CLK_MESON_CLKC_UTILS
>> +     help
>> +       Support for the PLL clock controller on Amlogic C302X and C308L devices,
>> +       AKA c3. Amlogic C302X and C308L devices include AW402, AW409 and AW419.
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
>> index 000000000000..97619bc7ab79
>> --- /dev/null
>> +++ b/drivers/clk/meson/c3-pll.c
>> @@ -0,0 +1,808 @@
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
>> +#include "clk-regmap.h"
>> +#include "clk-pll.h"
>> +#include "c3-pll.h"
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
>> +
>> +static const struct clk_parent_data pll_dco_parent = {
>> +     .fw_name = "pll_in",
>> +};
>> +
>> +static const struct clk_parent_data mclk_pll_dco_parent = {
>> +     .fw_name = "mclk_pll_in",
>> +};
> 
> I'm assuming this section relates to Documentation section 6.6.3.5 MPLL
> because all the fixed clock looks very familiar.
> 
> Because of the naming of another clock below, I'm not quite sure. Please clarify
> 
MPLL is not included in C3 SoC. Document was not updated to reflect this 
change.
Mclk_Pll is  designed for sensor in C3 Soc.
>> +
>> +static struct clk_regmap fixed_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data){
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
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fixed_pll_dco",
>> +             .ops = &meson_clk_pll_ro_ops,
>> +             .parent_data = &pll_dco_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fixed_pll = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_FIXPLL_CTRL0,
>> +             .shift = 12,
>> +             .width = 3,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fixed_pll",
>> +             .ops = &clk_regmap_divider_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
> 
> Need a comment about why this is using RO ops
>
Will do.

>> +
>> +static struct clk_fixed_factor fclk_div40_div = {
>> +     .mult = 1,
>> +     .div = 40,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div40_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_div40 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_div40",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_div40_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
> 
> Don't see div40 in the diagram, where does it come from ?
> The div40 is  an alias of  fixpll_clk50m in sec 6.6.5.3 about FIXPLL.
>> +
>> +static struct clk_fixed_factor fclk_div2_div = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
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
>> +     .data = &(struct clk_regmap_gate_data){
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
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_div2p5_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fixed_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
> 
> This one is wrong if I follow the doc.
> It is supposed to be fixed 8 divider taking it's source directly from
> the DCO, skipping the OD post divider ... assuming the doc is up to date.
> 
No, C3 SoC div2p5 is not skipping the OD post divider.
>> +
>> +static struct clk_regmap fclk_div2p5 = {
>> +     .data = &(struct clk_regmap_gate_data){
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
>> +     .hw.init = &(struct clk_init_data){
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
>> +     .data = &(struct clk_regmap_gate_data){
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
>> +     .hw.init = &(struct clk_init_data){
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
>> +     .data = &(struct clk_regmap_gate_data){
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
>> +     .hw.init = &(struct clk_init_data){
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
>> +     .data = &(struct clk_regmap_gate_data){
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
>> +     .hw.init = &(struct clk_init_data){
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
>> +     .data = &(struct clk_regmap_gate_data){
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
>> +     { .reg = ANACTRL_GP0PLL_CTRL1,  .def = 0x0 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL2,  .def = 0x0 },
> 
> This should re-init GP0 rate on boot which is not desirable in case the
> bootloader had already set a rate (for splash screen for example)
> 
> Sugguest you drop these
If I drop these ,set rate will be failed.
There are two differences between C3 SoC PLL and the previous SoC PLL.
It recommends reconfiguring PLL according to time sequence each time 
when C3 PLL set rate. When previous SoC set rate, it set frequency 
related parameters and  enable PLL after directly reset PLL about 
previous SoC.
When setting C3 PLL, you need to reset a pll lock rst bit, otherwise the 
PLL lock bit will not refresh.
> 
>> +     { .reg = ANACTRL_GP0PLL_CTRL3,  .def = 0x48681c00 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x3927200a },
>> +     { .reg = ANACTRL_GP0PLL_CTRL6,  .def = 0x56540000, .delay_us = 10 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0x080304fa },
>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0x380304fa, .delay_us = 10 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0X180304fa }
>> +};
>> +
>> +static const struct pll_params_table c3_gp0_pll_params_table[] = {
>> +     PLL_PARAMS(150, 1), /* DCO = 3600M */
>> +     PLL_PARAMS(130, 1), /* DCO = 3120M */
>> +     PLL_PARAMS(192, 1), /* DCO = 4608M */
>> +     PLL_PARAMS(125, 1), /* DCO = 3000M */
>> +     { /* sentinel */  }
>> +};
> 
> Why can't C3 use mult_range for GP0, like the other SoC ?
> Doc says DCO can do 3 to 6GHz
> 
The mult_range method is time-consuming and not suitable for scenarios 
requiring high frequency cutting performance.
We generally only use a few commonly used frequencies.
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
> 
> Please put that table next to the related divider
> Same for other instances
> 
Will do.
>> +
>> +static struct clk_regmap gp0_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data){
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
>> +             .table = c3_gp0_pll_params_table,
>> +             .init_regs = c3_gp0_init_regs,
>> +             .init_count = ARRAY_SIZE(c3_gp0_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "gp0_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &pll_dco_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap gp0_pll = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_GP0PLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 3,
>> +             .table = c3_gp0_pll_od_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
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
>> +static const struct reg_sequence c3_hifi_init_regs[] = {
>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x08010496 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x38010496 },
> 
> Same here, this an hidden hard coded rate init, with enable on top.
> Please drop this
> 
> If you need a specific rate after the init, use assigned-rate in DT
> 
>> +     { .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x0000ce40 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00000000 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a285c00 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x56540000, .delay_us = 50 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x18010496, .delay_us = 20 },
>> +};
>> +
>> +static const struct pll_params_table c3_hifi_pll_params_table[] = {
>> +     PLL_PARAMS(150, 1), /* DCO = 3600M */
>> +     PLL_PARAMS(130, 1), /* DCO = 3120M */
>> +     PLL_PARAMS(192, 1), /* DCO = 4608M */
>> +     PLL_PARAMS(125, 1), /* DCO = 3000M */
>> +     { /* sentinel */  }
>> +};
> 
> Again, why can't HiFi use mult range ?
>
The mult_range method is time-consuming and not suitable for scenarios 
requiring high frequency cutting performance.
>> +
>> +static struct clk_regmap hifi_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data){
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
>> +             .table = c3_hifi_pll_params_table,
>> +             .init_regs = c3_hifi_init_regs,
>> +             .init_count = ARRAY_SIZE(c3_hifi_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hifi_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &pll_dco_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap hifi_pll = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_HIFIPLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 2,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
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
> 
> I cannot make out what all the mclk section below relates to in
> documentation clock. Could you please clarify ?
> 
>> +static const struct reg_sequence c3_mclk_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x20011063 },
>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x30011063 },
> 
> Again, hidden rate set on init ...
> 
>> +     { .reg = ANACTRL_MPLL_CTRL1,    .def = 0x1420500f },
>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023041 },
>> +     { .reg = ANACTRL_MPLL_CTRL3,    .def = 0x18180000 },
>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x10011063 },
>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023001 }
>> +};
>> +
>> +static const struct pll_params_table c3_mclk_pll_params_table[] = {
>> +     PLL_PARAMS(99, 1), /* VCO = 2376M */
>> +     { /* sentinel */  }
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
>> +static struct clk_regmap mclk_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data){
>> +             .en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 9,
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
>> +             .table = c3_mclk_pll_params_table,
>> +             .init_regs = c3_mclk_init_regs,
>> +             .init_count = ARRAY_SIZE(c3_mclk_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mclk_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &mclk_pll_dco_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk_pll = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_MPLL_CTRL0,
>> +             .shift = 12,
>> +             .width = 3,
>> +             .table = c3_mpll_od_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mclk_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk_pll_clk = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .shift = 16,
>> +             .width = 5,
>> +             .flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mclk_pll_clk",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk_pll.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
> 
> 
> "mclk_pll" then "mclk_pll_clk" ... that is confusing
> 
Maybe mclk_pll rename mclk_pll_od.>> +
>> +static const struct clk_parent_data mclk_parent[] = {
>> +     { .hw = &mclk_pll_clk.hw },
>> +     { .fw_name = "mclk_pll_in" },
>> +     { .hw = &fclk_div40.hw }
>> +};
>> +
>> +static struct clk_regmap mclk0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .mask = 0x3,
>> +             .shift = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mclk0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = mclk_parent,
>> +             .num_parents = ARRAY_SIZE(mclk_parent),
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk0_sel_out = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .bit_idx = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk0_sel_out",
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
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .shift = 2,
>> +             .width = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mclk0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk0_sel_out.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk0 = {
>> +     .data = &(struct clk_regmap_gate_data){
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
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .mask = 0x3,
>> +             .shift = 12,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mclk1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = mclk_parent,
>> +             .num_parents = ARRAY_SIZE(mclk_parent),
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk1_sel_out = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .bit_idx = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk1_sel_out",
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
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANACTRL_MPLL_CTRL4,
>> +             .shift = 10,
>> +             .width = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mclk1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mclk1_sel_out.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk1 = {
>> +     .data = &(struct clk_regmap_gate_data){
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
>> +     [CLKID_FCLK_DIV40_DIV]  = &fclk_div40_div.hw,
>> +     [CLKID_FCLK_DIV40]      = &fclk_div40.hw,
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
>> +     [CLKID_HIFI_PLL_DCO]    = &hifi_pll_dco.hw,
>> +     [CLKID_HIFI_PLL]        = &hifi_pll.hw,
>> +     [CLKID_MCLK_PLL_DCO]    = &mclk_pll_dco.hw,
>> +     [CLKID_MCLK_PLL]        = &mclk_pll.hw,
>> +     [CLKID_MCLK_PLL_CLK]    = &mclk_pll_clk.hw,
>> +     [CLKID_MCLK0_SEL]       = &mclk0_sel.hw,
>> +     [CLKID_MCLK0_SEL_OUT]   = &mclk0_sel_out.hw,
>> +     [CLKID_MCLK0_DIV]       = &mclk0_div.hw,
>> +     [CLKID_MCLK0]           = &mclk0.hw,
>> +     [CLKID_MCLK1_SEL]       = &mclk1_sel.hw,
>> +     [CLKID_MCLK1_SEL_OUT]   = &mclk1_sel_out.hw,
>> +     [CLKID_MCLK1_DIV]       = &mclk1_div.hw,
>> +     [CLKID_MCLK1]           = &mclk1.hw
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const c3_pll_clk_regmaps[] = {
>> +     &fixed_pll_dco,
>> +     &fixed_pll,
>> +     &fclk_div40,
>> +     &fclk_div2,
>> +     &fclk_div2p5,
>> +     &fclk_div3,
>> +     &fclk_div4,
>> +     &fclk_div5,
>> +     &fclk_div7,
>> +     &gp0_pll_dco,
>> +     &gp0_pll,
>> +     &hifi_pll_dco,
>> +     &hifi_pll,
>> +     &mclk_pll_dco,
>> +     &mclk_pll,
>> +     &mclk_pll_clk,
>> +     &mclk0_sel,
>> +     &mclk0_sel_out,
>> +     &mclk0_div,
>> +     &mclk0,
>> +     &mclk1_sel,
>> +     &mclk1_sel_out,
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
>> diff --git a/drivers/clk/meson/c3-pll.h b/drivers/clk/meson/c3-pll.h
>> new file mode 100644
>> index 000000000000..92a08196a46f
>> --- /dev/null
>> +++ b/drivers/clk/meson/c3-pll.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2023 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#ifndef __AML_C3_PLL_H__
>> +#define __AML_C3_PLL_H__
>> +
>> +#define ANACTRL_FIXPLL_CTRL0                 0x0040
>> +#define ANACTRL_FIXPLL_CTRL4                 0x0050
>> +#define ANACTRL_GP0PLL_CTRL0                 0x0080
>> +#define ANACTRL_GP0PLL_CTRL1                 0x0084
>> +#define ANACTRL_GP0PLL_CTRL2                 0x0088
>> +#define ANACTRL_GP0PLL_CTRL3                 0x008c
>> +#define ANACTRL_GP0PLL_CTRL4                 0x0090
>> +#define ANACTRL_GP0PLL_CTRL5                 0x0094
>> +#define ANACTRL_GP0PLL_CTRL6                 0x0098
>> +#define ANACTRL_GP0PLL_STS                   0x009c
>> +#define ANACTRL_HIFIPLL_CTRL0                        0x0100
>> +#define ANACTRL_HIFIPLL_CTRL1                        0x0104
>> +#define ANACTRL_HIFIPLL_CTRL2                        0x0108
>> +#define ANACTRL_HIFIPLL_CTRL3                        0x010c
>> +#define ANACTRL_HIFIPLL_CTRL4                        0x0110
>> +#define ANACTRL_HIFIPLL_CTRL5                        0x0114
>> +#define ANACTRL_HIFIPLL_CTRL6                        0x0118
>> +#define ANACTRL_HIFIPLL_STS                  0x011c
>> +#define ANACTRL_MPLL_CTRL0                   0x0180
>> +#define ANACTRL_MPLL_CTRL1                   0x0184
>> +#define ANACTRL_MPLL_CTRL2                   0x0188
>> +#define ANACTRL_MPLL_CTRL3                   0x018c
>> +#define ANACTRL_MPLL_CTRL4                   0x0190
>> +#define ANACTRL_MPLL_STS                     0x01a4
>> +
>> +#endif  /* __AML_C3_PLL_H__ */
> 
