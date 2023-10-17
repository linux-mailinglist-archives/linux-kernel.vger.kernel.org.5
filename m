Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B057CB944
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjJQD01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjJQD0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:26:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E018F;
        Mon, 16 Oct 2023 20:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpkxpLB09wJffsexIwKgW9PbTHoUg1beLHCuGone73zecF0kDuzg1q9/NvVhsz5fLDdZ/lx7yLWpqbTomN1mKlfS58iuE80BsOk2lQeA3DbAc7q7PBe+pSk2ZDskhTn1OAiAa2et4ZyuE8GNVY66KjGx5n5qF7X8I8XRxYE6aZVILHvKMFJljbH6jOHwnUNziNtUaZ7ygD8NpF9QrOQ0D7Bu1gReKAJnYdkKLcpMv9eqcspweZv6xszQgwubvL8aizoXmyC1HQVbQbOeTt6XEtZhzEVR0tYfI2YBtOkK3FluRvYPCgVZh67/qPKRuKnAcdcuaZ1BCtydAUTcoHlBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bypP7mVsVoFVufSBrsBnT1pi+1K/Mm928Ys/+Zx7NXw=;
 b=ac84XaW4GE+0sfxSH4JUQcifZfP1piSYruaWF2V9xZTWrzlZNQPa2sujemlAUM9S5ENT59Fg4ex/HPwmi/TZNS0flcOLOVNXohxSLPukSfkBhCjrTrqnnsvZK4qVFGV7Xc0SpepFsI/noCTZoHQ8PfzHpbQE8uItF+6f6qYhaKmeUzJWkY1uHDjiVMU1Vx/roRfwDYANIianLKt7L+yobWNSm4qbsb0mnOyyDypsXUD6qMSNXwm8ZFY+ilXUHA8dG+G2zb201hPqn2MEkb3UsB5Quzwt6Z3DDePe1SXI6YeMzoileqCztu2+Gw2tZ/gadYfs6jYj9gGaEe5nP2y9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bypP7mVsVoFVufSBrsBnT1pi+1K/Mm928Ys/+Zx7NXw=;
 b=Lf/HfEnI+z4ifc6KPkRLqPhL1/f3vdXEP7Jwfo0sZZKG4BTwVeOKzQ+EBaHrTT2pZPEAIlM2elVFAmezHmGUFEQ4+8r7/GxvYhnAd+B6io2Cxjt5hfg2SCqBPZQnl9tZtg71blrzFnezPTc8Ik3+21HxLYpnkmxCmAFCoEZTSYS0U0Cv4VzRr5duOc81aFbjy7S5VG/rAnicXm8RIK7aa3onQ/xG7iYy+uO0+PXnFPuHqR3fqxyh147fk+2JSsit07Kxy8SVgwJm87fwsmkGHzOmLqzAS4OU3ynKNPKY2sRLu61Ddz+t1DQy7qs9VRaMYD6g4OIiZi3xyKw9vA+l9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB8301.apcprd03.prod.outlook.com (2603:1096:101:1ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 03:25:29 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 03:25:29 +0000
Message-ID: <376968a3-a0f0-3045-96fe-881c2e36be7e@amlogic.com>
Date:   Tue, 17 Oct 2023 11:25:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 4/4] clk: meson: c3: add c3 clock peripherals
 controller driver
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
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-5-xianwei.zhao@amlogic.com>
 <1jedhyx51m.fsf@starbuckisacylon.baylibre.com>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jedhyx51m.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd7cb67-fcb5-4a4a-04ed-08dbcec0b5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n54EmfRif7YQJ5xVSa4ew20RGIdbss/JTgxmoCmOa+wkpaGfOilts/S02Jg8lHP4fC2Lgt1nJIugBSO07ug5EHYUtsQh+MKM7bNIKCCDFBYFtHaWJIZyRACCCxCr7OcDmthT4bUTxHYo5Pn8x2gEcQn/HLHagR0Vu7vPrRUcSaynKTlKd1kHPWt+yafLrneIrya8ro0+l5b3sKyU5t769QSEM51s2WJFuMYxt8yWYQz4FuPutHPG/AzNPDms7xyhS8StQFSqOsH4w41xtPE9TujmkCisMe5F8y47nZc4dIvncQho/N1riZ2LDVx8sF+B51GrPAx+cg99WA8DrXKdMAAWi8vtlrA394NxlppCtIHNKJkbyySDsuXI3NXYBJzP+FKmUCSERqK1UoZcJjqH39sH4aQqiFb1+zZ0yM+dp1qhOiBt1CdBavpKoFWdjk7Xr7mygRBHOu0US1lZzrYAdnDMMTwQeswww0PMWuIGUFOyKzvFM0i6T+ZgDUNBp+gbQ1N5h5O1qL4IQaTZaiv/yYxaS+jtF3tLOxQTNhrxm27GZrdg5vaenFgpGrqUjhI0EgZliCocPrw71rHvIVfVFFmu/OBFDduHTmoOKMO2Y72xqE+HVuGaQGzrsFsoYye5MJoDfiXTpAS6yOMrH8l7OPUIa3gvdnWnNBWilnKmYK+EXTJJHoMtEBxYgFvcZW8kcMrwCzJ8XGWxQ5voxawkCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(136003)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6486002)(38100700002)(478600001)(2906002)(6666004)(6512007)(6506007)(7416002)(54906003)(316002)(66946007)(66476007)(66556008)(8936002)(5660300002)(41300700001)(4326008)(44832011)(8676002)(30864003)(107886003)(83380400001)(53546011)(26005)(2616005)(31686004)(36756003)(31696002)(86362001)(45980500001)(43740500002)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9hcWR1WGZpNUl6eGQzbXV5cWkvT3hBekd2K2J5Rm9DbHVrSXhURW0zWVhu?=
 =?utf-8?B?cW1jT1dTekFVdFl0UmRiTG82YmhFSmdyT0cyTWdPSWpGbndVc2NJbjFOTTly?=
 =?utf-8?B?QytYdFJhaEVxL2VTd1dJbDRpLzRtKzk3OWwrSHZDUnNuYlFDb21JdUxONmg3?=
 =?utf-8?B?alEvUit6VUZSZnRsL0czTjdaZ1R1Z0d1eWJKNUlLVHZoaU5JTXN1c25HbVBN?=
 =?utf-8?B?SlYyNm9oVlVxUkVOQWdKVk5xNkp6aS9GSzZ6OUVYQXhJS1MvUlplSXRDbVhy?=
 =?utf-8?B?NzRpTkl5ZDVhVktQR2xUUGUvM25GVjdhdDlPbW10VG1GU0pWamV0ZmdiV1hq?=
 =?utf-8?B?SlhpazBvZ2Job3VESUdlVVh5UkQ1Nm1XbXdXVVU5TjNGSVRkdWphOHNKcm5o?=
 =?utf-8?B?NUhockw0WU9hVEUxSERBWDBXblBFd3BwOW9DYWJsdkJYMWhQREttTXlMYzZI?=
 =?utf-8?B?NFdLWHFMOFEvZXI2d3kvclk3WEhUQjFEZFhaTnZ4QUNQNnZaa2g2VWdSbWpD?=
 =?utf-8?B?MzFsMnZTVVVRQVhCU2lINnRtVzlxQnlDeGF3NFpJWGROdXg1a05xLzNwRWF6?=
 =?utf-8?B?VTkvUjBxWUVRdDBMU0g1ZW1LU0wwRU9YWG52NVE1Skl2NzNhdjJqMVNzdjJ4?=
 =?utf-8?B?UWF0aUY1U3ZhMEkxbXVaZkRGaFZtSmQ4ZS91dnZSSmRyaGtnVHQ5L0YrOEow?=
 =?utf-8?B?bGpGQ0pjYUY3TjZISWJ4UkdHSGh2WDdSemd6R2NjMWRHdStWa0VRUkJ1dDRV?=
 =?utf-8?B?UmpEZXRoZkZ1UnFvQnhhOVlORzl5a1lXeE5iNnlSZVVlOGhpTVZ2NHBRN3d0?=
 =?utf-8?B?L01xbHBBVmkyVWRnTU56MFVIekU0aytHYVNQR25XMmRBZHFURkNBeWh1SG1r?=
 =?utf-8?B?ZWJBdXFvV01HSG1tY0tCRzBEU2R1NU1waitTTGVGb3VrV282cWpTZjNueHlJ?=
 =?utf-8?B?VVBnSVgzUGV6STk0N0dFd2lWMlJBdHUxeVF1WUlVNzFLUGN5U0xLRnZsQkhz?=
 =?utf-8?B?bUJiZzRFM0tBSFJ1VVBmYTZZdThJZk9wdHN6VWlnbHdWNjErc0hGT21FOVNB?=
 =?utf-8?B?ckpWNUd3NGVyM1ZlenNDOTdDbHNZNHphc21oeS9aYURTd05SRGRqekEwdUIz?=
 =?utf-8?B?WUh2VTlrUDgxbVZQMGVKTnA1TERKaitXQjRtRUl3cThmY0VvZ0pHT2U1S1JK?=
 =?utf-8?B?Y2JGSS91MTE2U21OOFNHWXo1NjQvWWhtWjVWSHllTTJiUURkMkNrbndOb2pS?=
 =?utf-8?B?K1FzdndSODVVdlFSQ3M4aGF1M2VHR3FpRWpyTTJTVTkwY09vV0wwYkhXcmlz?=
 =?utf-8?B?WXdaVWRhckJhaEFKVzlEdk8wS1JMcGRCQUlhZGlhK0RQN1drc1ZzaHJiR1lk?=
 =?utf-8?B?WlkyKzJpcFJjNTZ0YTRWb05qOVFOYkYxU3M3ZlE4WWlPY0s2STF1SWN6Nk5D?=
 =?utf-8?B?WUVPYXd0SnZTZjJGbHJuRXJNR2Q4bkZaeFpSK2ttNkIzTzJIVitRalFPcXJn?=
 =?utf-8?B?bS9nRVlUU0NqNXBrZmRMTk8wQ2tFM1JKUmtLRkFudGlPWXdlUEoyRHh2NWZM?=
 =?utf-8?B?bVZDckhXOHVlZ3pVd1Fjd25RUjZWLzEydUlzRlpnS3h1bDAvNEZ4T1hGOHNI?=
 =?utf-8?B?SnVBOGhkaklqanhYVnJJV28vcURqVjl4UjJ5SDNjbnBwcGpGbUFJaFplTkpL?=
 =?utf-8?B?QkpkRlAxUmlBK3VHUk54TWIrWktOZE1jYnllcHAvamJibWoxOXBIemR6SFU5?=
 =?utf-8?B?SHJWSTROWGZMckVXTTd6Y0VMQXNkWVJjNE5SdEptN1IzckNVWTlvM0gzdEQw?=
 =?utf-8?B?M1hpNUYxYWtUZW9OTHRzejNLUyt0OTZqTWV6TGExemtaeXp4YytHT2xwMGVt?=
 =?utf-8?B?cGdKbDQ1b1hyR1h6SEVBQU9xZkhZd255OWxTVi9aMlhudVR5NE1IRiswVHZL?=
 =?utf-8?B?b2lJRmo0U3lMVXpEM1VZbUhvLzlnT2szdUY1allGaFJ6SkhCaTNwWWpEbXZH?=
 =?utf-8?B?L0d2aVl4M3N1azZpRi9hYW1uMEVTUndObWFnRXBLbXZyb29lRXFlWHNiUDZG?=
 =?utf-8?B?YndQTWRiRVkyM0JtS0tKRUFQR3BXbkdJRFNTRm5vVUlXSHBGMHBzZ3haQTg1?=
 =?utf-8?B?ZkVwQkZhSENwck5ST3NHdVY1NnJtMy9JS3VscHBKMEVNWms5ZTRqbnU0cWV4?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd7cb67-fcb5-4a4a-04ed-08dbcec0b5d1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 03:25:28.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKBPj3RFdfRVbA6nnh4ZBwk1CtgJL/kB9TUrDYiTc6UTrrRuIIQKTWVIgroyBz6YF/HT/uPSmrOKiLcrq9jIke+kl/Ek7Iq7aYz4BLIKssI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8301
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,
      Thank you for your reply.

On 2023/10/13 16:46, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue 10 Oct 2023 at 14:29, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> 
>> Add the C3 peripherals clock controller driver in the C3 SoC family.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>> V1 -> V2: Delete macro definition.
>> ---
>>   drivers/clk/meson/Kconfig          |   13 +
>>   drivers/clk/meson/Makefile         |    1 +
>>   drivers/clk/meson/c3-peripherals.c | 3096 ++++++++++++++++++++++++++++
>>   drivers/clk/meson/c3-peripherals.h |   48 +
>>   4 files changed, 3158 insertions(+)
>>   create mode 100644 drivers/clk/meson/c3-peripherals.c
>>   create mode 100644 drivers/clk/meson/c3-peripherals.h
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 76be4bbd2afb..c8d59d28c8ff 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -140,6 +140,19 @@ config COMMON_CLK_C3_PLL
>>          Say Y if you want the board to work, because PLLs are the parent of most
>>          peripherals.
>>
>> +config COMMON_CLK_C3_PERIPHERALS
>> +     tristate "Amlogic C3 peripherals clock controller"
>> +     default y
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_DUALDIV
>> +     select COMMON_CLK_MESON_CLKC_UTILS
>> +     select COMMON_CLK_C3_PLL
>> +     help
>> +       Support for the Peripherals clock controller on Amlogic C302X and
>> +       C308L devices, AKA c3. Amlogic C302X and C308L devices include
>> +       AW402, AW409 and AW419. Say Y if you want the peripherals clock
>> +       to work.
>> +
>>   config COMMON_CLK_G12A
>>        tristate "G12 and SM1 SoC clock controllers support"
>>        depends on ARM64
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 4420af628b31..20ad9482c892 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>> +obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>> diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
>> new file mode 100644
>> index 000000000000..2931cb20299a
>> --- /dev/null
>> +++ b/drivers/clk/meson/c3-peripherals.c
>> @@ -0,0 +1,3096 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Amlogic C3 Peripherals Clock Controller Driver
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
>> +#include "clk-dualdiv.h"
>> +#include "c3-peripherals.h"
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>
>> +
>> +static struct clk_regmap pll_in = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = OSCIN_CTRL,
>> +             .bit_idx = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pll_in",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mclk_pll_in = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = OSCIN_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mclk_pll_in",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data rtc_xtal_clkin_parent = {
>> +     .fw_name = "xtal",
>> +};
>> +
>> +static struct clk_regmap rtc_xtal_clkin = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_xtal_clkin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = &rtc_xtal_clkin_parent,
> 
> Why can't you inline
> 
Will do
>                  .parent_data = &(const struct clk_parent_data) {
>                          .fw_name = "xtal",
>                  },
> 
> like for the other clock ... please be consistent
> 
> 
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct meson_clk_dualdiv_param rtc_32k_div_table[] = {
>> +     { 733, 732, 8, 11, 1 },
>> +     { /* sentinel */ }
>> +};
>> +
>> +static struct clk_regmap rtc_32k_div = {
>> +     .data = &(struct meson_clk_dualdiv_data){
>> +             .n1 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = rtc_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &rtc_xtal_clkin.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data rtc_32k_mux_parent_data[] = {
>> +     { .hw = &rtc_32k_div.hw },
>> +     { .hw = &rtc_xtal_clkin.hw }
>> +};
>> +
>> +static struct clk_regmap rtc_32k_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = RTC_BY_OSCIN_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_32k_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = rtc_32k_mux_parent_data,
>> +             .num_parents = ARRAY_SIZE(rtc_32k_mux_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap rtc_32k = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &rtc_32k_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data rtc_clk_mux_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .hw = &rtc_32k.hw }
>> +};
>> +
>> +static struct clk_regmap rtc_clk = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = RTC_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_clk",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = rtc_clk_mux_parent_data,
>> +             .num_parents = ARRAY_SIZE(rtc_clk_mux_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/*
>> + * Some clocks have multiple clock sources, and the parent clock and index are
>> + * discontinuous, Some channels corresponding to the clock index are not
>> + * actually connected inside the chip, or the clock source is invalid.
>> + */
>> +
>> +static u32 sys_axi_parent_table[] = { 0, 2, 3, 4, 7 };
>> +
>> +static const struct clk_parent_data sys_axi_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .hw = &rtc_clk.hw }
>> +};
>> +
>> +static struct clk_regmap sys_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = SYS_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 10,
>> +             .table = sys_axi_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sys_a_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = sys_axi_parent_data,
>> +             .num_parents = ARRAY_SIZE(sys_axi_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap sys_a_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = SYS_CLK_CTRL0,
>> +             .shift = 0,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sys_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sys_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sys_a = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = SYS_CLK_CTRL0,
>> +             .bit_idx = 13,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sys_a",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sys_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_IGNORE_UNUSED,
> 
> As usual, a comment is expected when using CLK_IGNORE_UNUSED.
> It is very often not appropriate or justified.
> 
> Same goes for the other instances
> 
Will do.
>> +     },
>> +};
>> +
>> +static struct clk_regmap sys_b_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = SYS_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 26,
>> +             .table = sys_axi_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sys_b_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = sys_axi_parent_data,
>> +             .num_parents = ARRAY_SIZE(sys_axi_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap sys_b_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = SYS_CLK_CTRL0,
>> +             .shift = 16,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sys_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sys_b_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sys_b = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = SYS_CLK_CTRL0,
>> +             .bit_idx = 29,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sys_b",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sys_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_IGNORE_UNUSED,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data sys_clk_parent_data[] = {
>> +     { .hw = &sys_a.hw },
>> +     { .hw = &sys_b.hw }
>> +};
>> +
>> +static struct clk_regmap sys_clk = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = SYS_CLK_CTRL0,
>> +             .mask = 0x1,
>> +             .shift = 15,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sys_clk",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = sys_clk_parent_data,
>> +             .num_parents = ARRAY_SIZE(sys_clk_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap axi_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = AXI_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 10,
>> +             .table = sys_axi_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "axi_a_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = sys_axi_parent_data,
>> +             .num_parents = ARRAY_SIZE(sys_axi_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap axi_a_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = AXI_CLK_CTRL0,
>> +             .shift = 0,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "axi_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &axi_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap axi_a = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = AXI_CLK_CTRL0,
>> +             .bit_idx = 13,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "axi_a",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &axi_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_IGNORE_UNUSED,
>> +     },
>> +};
>> +
>> +static struct clk_regmap axi_b_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = AXI_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 26,
>> +             .table = sys_axi_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "axi_b_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = sys_axi_parent_data,
>> +             .num_parents = ARRAY_SIZE(sys_axi_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap axi_b_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = AXI_CLK_CTRL0,
>> +             .shift = 16,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "axi_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &axi_b_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap axi_b = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = AXI_CLK_CTRL0,
>> +             .bit_idx = 29,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "axi_b",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &axi_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_IGNORE_UNUSED,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data axi_clk_parent_data[] = {
>> +     { .hw = &axi_a.hw },
>> +     { .hw = &axi_b.hw }
>> +};
>> +
>> +static struct clk_regmap axi_clk = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = AXI_CLK_CTRL0,
>> +             .mask = 0x1,
>> +             .shift = 15,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "axi_clk",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = axi_clk_parent_data,
>> +             .num_parents = ARRAY_SIZE(axi_clk_parent_data),
>> +     },
>> +};
>> +
>> +#define AML_CLK_GATE_SYS_CLK(_name, _reg, _bit)\
>> +     MESON_PCLK(_name, _reg, _bit, &sys_clk.hw)
>> +#define AML_CLK_GATE_AXI_CLK(_name, _reg, _bit)\
>> +     MESON_PCLK(_name, _reg, _bit, &axi_clk.hw)
>> +
>> +AML_CLK_GATE_SYS_CLK(sys_reset_ctrl, SYS_CLK_EN0_REG0, 1);
>> +AML_CLK_GATE_SYS_CLK(sys_pwr_ctrl, SYS_CLK_EN0_REG0, 3);
>> +AML_CLK_GATE_SYS_CLK(sys_pad_ctrl, SYS_CLK_EN0_REG0, 4);
>> +AML_CLK_GATE_SYS_CLK(sys_ctrl, SYS_CLK_EN0_REG0, 5);
>> +AML_CLK_GATE_SYS_CLK(sys_ts_pll, SYS_CLK_EN0_REG0, 6);
>> +AML_CLK_GATE_SYS_CLK(sys_dev_arb, SYS_CLK_EN0_REG0, 7);
>> +AML_CLK_GATE_SYS_CLK(sys_mmc_pclk, SYS_CLK_EN0_REG0, 8);
>> +AML_CLK_GATE_SYS_CLK(sys_capu, SYS_CLK_EN0_REG0, 9);
>> +AML_CLK_GATE_SYS_CLK(sys_cpu_ctrl, SYS_CLK_EN0_REG0, 11);
>> +AML_CLK_GATE_SYS_CLK(sys_jtag_ctrl, SYS_CLK_EN0_REG0, 12);
>> +AML_CLK_GATE_SYS_CLK(sys_ir_ctrl, SYS_CLK_EN0_REG0, 13);
>> +AML_CLK_GATE_SYS_CLK(sys_irq_ctrl, SYS_CLK_EN0_REG0, 14);
>> +AML_CLK_GATE_SYS_CLK(sys_msr_clk, SYS_CLK_EN0_REG0, 15);
>> +AML_CLK_GATE_SYS_CLK(sys_rom, SYS_CLK_EN0_REG0, 16);
>> +AML_CLK_GATE_SYS_CLK(sys_uart_f, SYS_CLK_EN0_REG0, 17);
>> +AML_CLK_GATE_SYS_CLK(sys_cpu_apb, SYS_CLK_EN0_REG0, 18);
>> +AML_CLK_GATE_SYS_CLK(sys_rsa, SYS_CLK_EN0_REG0, 19);
>> +AML_CLK_GATE_SYS_CLK(sys_sar_adc, SYS_CLK_EN0_REG0, 20);
>> +AML_CLK_GATE_SYS_CLK(sys_startup, SYS_CLK_EN0_REG0, 21);
>> +AML_CLK_GATE_SYS_CLK(sys_secure, SYS_CLK_EN0_REG0, 22);
>> +AML_CLK_GATE_SYS_CLK(sys_spifc, SYS_CLK_EN0_REG0, 23);
>> +AML_CLK_GATE_SYS_CLK(sys_nna, SYS_CLK_EN0_REG0, 25);
>> +AML_CLK_GATE_SYS_CLK(sys_eth_mac, SYS_CLK_EN0_REG0, 26);
>> +AML_CLK_GATE_SYS_CLK(sys_gic, SYS_CLK_EN0_REG0, 27);
>> +AML_CLK_GATE_SYS_CLK(sys_rama, SYS_CLK_EN0_REG0, 28);
>> +AML_CLK_GATE_SYS_CLK(sys_big_nic, SYS_CLK_EN0_REG0, 29);
>> +AML_CLK_GATE_SYS_CLK(sys_ramb, SYS_CLK_EN0_REG0, 30);
>> +AML_CLK_GATE_SYS_CLK(sys_audio_pclk, SYS_CLK_EN0_REG0, 31);
>> +AML_CLK_GATE_SYS_CLK(sys_pwm_kl, SYS_CLK_EN0_REG1, 0);
>> +AML_CLK_GATE_SYS_CLK(sys_pwm_ij, SYS_CLK_EN0_REG1, 1);
>> +AML_CLK_GATE_SYS_CLK(sys_usb, SYS_CLK_EN0_REG1, 2);
>> +AML_CLK_GATE_SYS_CLK(sys_sd_emmc_a, SYS_CLK_EN0_REG1, 3);
>> +AML_CLK_GATE_SYS_CLK(sys_sd_emmc_c, SYS_CLK_EN0_REG1, 4);
>> +AML_CLK_GATE_SYS_CLK(sys_pwm_ab, SYS_CLK_EN0_REG1, 5);
>> +AML_CLK_GATE_SYS_CLK(sys_pwm_cd, SYS_CLK_EN0_REG1, 6);
>> +AML_CLK_GATE_SYS_CLK(sys_pwm_ef, SYS_CLK_EN0_REG1, 7);
>> +AML_CLK_GATE_SYS_CLK(sys_pwm_gh, SYS_CLK_EN0_REG1, 8);
>> +AML_CLK_GATE_SYS_CLK(sys_spicc_1, SYS_CLK_EN0_REG1, 9);
>> +AML_CLK_GATE_SYS_CLK(sys_spicc_0, SYS_CLK_EN0_REG1, 10);
>> +AML_CLK_GATE_SYS_CLK(sys_uart_a, SYS_CLK_EN0_REG1, 11);
>> +AML_CLK_GATE_SYS_CLK(sys_uart_b, SYS_CLK_EN0_REG1, 12);
>> +AML_CLK_GATE_SYS_CLK(sys_uart_c, SYS_CLK_EN0_REG1, 13);
>> +AML_CLK_GATE_SYS_CLK(sys_uart_d, SYS_CLK_EN0_REG1, 14);
>> +AML_CLK_GATE_SYS_CLK(sys_uart_e, SYS_CLK_EN0_REG1, 15);
>> +AML_CLK_GATE_SYS_CLK(sys_i2c_m_a, SYS_CLK_EN0_REG1, 16);
>> +AML_CLK_GATE_SYS_CLK(sys_i2c_m_b, SYS_CLK_EN0_REG1, 17);
>> +AML_CLK_GATE_SYS_CLK(sys_i2c_m_c, SYS_CLK_EN0_REG1, 18);
>> +AML_CLK_GATE_SYS_CLK(sys_i2c_m_d, SYS_CLK_EN0_REG1, 19);
>> +AML_CLK_GATE_SYS_CLK(sys_i2c_s_a, SYS_CLK_EN0_REG1, 20);
>> +AML_CLK_GATE_SYS_CLK(sys_rtc, SYS_CLK_EN0_REG1, 21);
>> +AML_CLK_GATE_SYS_CLK(sys_ge2d, SYS_CLK_EN0_REG1, 22);
>> +AML_CLK_GATE_SYS_CLK(sys_isp, SYS_CLK_EN0_REG1, 23);
>> +AML_CLK_GATE_SYS_CLK(sys_gpv_isp_nic, SYS_CLK_EN0_REG1, 24);
>> +AML_CLK_GATE_SYS_CLK(sys_gpv_cve_nic, SYS_CLK_EN0_REG1, 25);
>> +AML_CLK_GATE_SYS_CLK(sys_mipi_dsi_host, SYS_CLK_EN0_REG1, 26);
>> +AML_CLK_GATE_SYS_CLK(sys_mipi_dsi_phy, SYS_CLK_EN0_REG1, 27);
>> +AML_CLK_GATE_SYS_CLK(sys_eth_phy, SYS_CLK_EN0_REG1, 28);
>> +AML_CLK_GATE_SYS_CLK(sys_acodec, SYS_CLK_EN0_REG1, 29);
>> +AML_CLK_GATE_SYS_CLK(sys_dwap, SYS_CLK_EN0_REG1, 30);
>> +AML_CLK_GATE_SYS_CLK(sys_dos, SYS_CLK_EN0_REG1, 31);
>> +AML_CLK_GATE_SYS_CLK(sys_cve, SYS_CLK_EN0_REG2, 0);
>> +AML_CLK_GATE_SYS_CLK(sys_vout, SYS_CLK_EN0_REG2, 1);
>> +AML_CLK_GATE_SYS_CLK(sys_vc9000e, SYS_CLK_EN0_REG2, 2);
>> +AML_CLK_GATE_SYS_CLK(sys_pwm_mn, SYS_CLK_EN0_REG2, 3);
>> +AML_CLK_GATE_SYS_CLK(sys_sd_emmc_b, SYS_CLK_EN0_REG2, 4);
>> +AML_CLK_GATE_AXI_CLK(axi_sys_nic, AXI_CLK_EN0, 2);
>> +AML_CLK_GATE_AXI_CLK(axi_isp_nic, AXI_CLK_EN0, 3);
>> +AML_CLK_GATE_AXI_CLK(axi_cve_nic, AXI_CLK_EN0, 4);
>> +AML_CLK_GATE_AXI_CLK(axi_ramb, AXI_CLK_EN0, 5);
>> +AML_CLK_GATE_AXI_CLK(axi_rama, AXI_CLK_EN0, 6);
>> +AML_CLK_GATE_AXI_CLK(axi_cpu_dmc, AXI_CLK_EN0, 7);
>> +AML_CLK_GATE_AXI_CLK(axi_nic, AXI_CLK_EN0, 8);
>> +AML_CLK_GATE_AXI_CLK(axi_dma, AXI_CLK_EN0, 9);
>> +AML_CLK_GATE_AXI_CLK(axi_mux_nic, AXI_CLK_EN0, 10);
>> +AML_CLK_GATE_AXI_CLK(axi_capu, AXI_CLK_EN0, 11);
>> +AML_CLK_GATE_AXI_CLK(axi_cve, AXI_CLK_EN0, 12);
>> +AML_CLK_GATE_AXI_CLK(axi_dev1_dmc, AXI_CLK_EN0, 13);
>> +AML_CLK_GATE_AXI_CLK(axi_dev0_dmc, AXI_CLK_EN0, 14);
>> +AML_CLK_GATE_AXI_CLK(axi_dsp_dmc, AXI_CLK_EN0, 15);
>> +
>> +/*
>> + * clk_12_24m model
>> + *
>> + *          |------|     |-----| clk_12m_24m |-----|
>> + * xtal---->| gate |---->| div |------------>| pad |
>> + *          |------|     |-----|             |-----|
>> + */
>> +static const struct clk_parent_data clk_12_24m_in_parent = {
>> +     .fw_name = "xtal",
>> +};
> 
> Can't inline that ?
> 
Will do.
>> +
>> +static struct clk_regmap clk_12_24m_in = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLK12_24_CTRL,
>> +             .bit_idx = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "clk_12_24m_in",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = &clk_12_24m_in_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap clk_12_24m = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLK12_24_CTRL,
>> +             .shift = 10,
>> +             .width = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "clk_12_24m",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &clk_12_24m_in.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data fclk_25m_div_parent = {
>> +     .fw_name = "fixed_pll",
>> +};
>> +
>> +static struct clk_regmap fclk_25m_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLK12_24_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "fclk_25m_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &fclk_25m_div_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_25m = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLK12_24_CTRL,
>> +             .bit_idx = 12,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_25m",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_25m_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* generate clock output */
> 
> That comment is not helping much ... what did you mean ?
> 
It seems superfluous, will delte it.
>> +static u32 gen_parent_table[] = { 0, 1, 5, 7 };
>> +
>> +static const struct clk_parent_data gen_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .hw = &rtc_clk.hw },
>> +     { .fw_name = "gp0_pll" },
>> +     { .fw_name = "hifi_pll" }
>> +};
>> +
>> +static struct clk_regmap gen_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = GEN_CLK_CTRL,
>> +             .mask = 0x1f,
>> +             .shift = 12,
>> +             .table = gen_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "gen_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = gen_parent_data,
>> +             .num_parents = ARRAY_SIZE(gen_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap gen_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = GEN_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "gen_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &gen_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap gen = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = GEN_CLK_CTRL,
>> +             .bit_idx = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gen",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &gen_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data saradc_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .hw = &sys_clk.hw }
>> +};
>> +
>> +static struct clk_regmap saradc_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = SAR_CLK_CTRL0,
>> +             .mask = 0x1,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "saradc_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = saradc_parent_data,
>> +             .num_parents = ARRAY_SIZE(saradc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap saradc_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = SAR_CLK_CTRL0,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "saradc_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &saradc_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap saradc = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = SAR_CLK_CTRL0,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "saradc",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &saradc_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static u32 pwm_parent_table[] = { 0, 2, 3 };
> 
> What's pwm parent 1, why can't it be used ?
This 1 corresponds to gp1 pll, which is currently dedicated to emmc.
> 
>> +
>> +static const struct clk_parent_data pwm_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div3" }
>> +};
>> +
>> +static struct clk_regmap pwm_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_AB_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_a_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_a_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_AB_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_a = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_AB_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_a",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_b_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_AB_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_b_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_b_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_AB_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_b_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_b = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_AB_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_b",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_c_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_CD_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_c_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_c_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_CD_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_c_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_c_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_c = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_CD_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_c",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_c_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_d_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_CD_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_d_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_d_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_CD_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_d_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_d_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_d = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_CD_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_d",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_d_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_e_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_EF_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_e_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_e_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_EF_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_e_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_e_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_e = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_EF_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_e",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_e_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_f_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_EF_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_f_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_f_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_EF_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_f_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_f_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_f = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_EF_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_f",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_f_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_g_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_GH_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_g_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_g_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_GH_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_g_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_g_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_g = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_GH_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_g",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_g_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_h_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_GH_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_h_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_h_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_GH_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_h_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_h_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_h = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_GH_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_h",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_h_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_i_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_IJ_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_i_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_i_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_IJ_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_i_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_i_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_i = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_IJ_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_i",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_i_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_j_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_IJ_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_j_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_j_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_IJ_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_j_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_j_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_j = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_IJ_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_j",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_j_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_k_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_KL_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_k_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_k_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_KL_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_k_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_k_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_k = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_KL_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_k",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_k_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_l_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_KL_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_l_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_l_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_KL_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_l_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_l_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_l = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_KL_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_l",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_l_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_m_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_MN_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_m_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_m_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_MN_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_m_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_m_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_m = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_MN_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_m",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_m_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_n_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = PWM_CLK_MN_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +             .table = pwm_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_n_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_n_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = PWM_CLK_MN_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_n_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_n_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap pwm_n = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = PWM_CLK_MN_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "pwm_n",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &pwm_n_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
> 
> Judging by the number of repeated block, a properly defined macro would
> be acceptable for the PWM block
> 
Will do.
>> +
>> +static const struct clk_parent_data spicc_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .hw = &sys_clk.hw },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div2" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "fclk_div7" }
>> +};
>> +
>> +static struct clk_regmap spicc_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = SPICC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "spicc_a_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = spicc_parent_data,
>> +             .num_parents = ARRAY_SIZE(spicc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_a_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = SPICC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "spicc_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_a = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = SPICC_CLK_CTRL,
>> +             .bit_idx = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_a",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_b_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = SPICC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 23,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "spicc_b_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = spicc_parent_data,
>> +             .num_parents = ARRAY_SIZE(spicc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_b_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = SPICC_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "spicc_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_b_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_b = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = SPICC_CLK_CTRL,
>> +             .bit_idx = 22,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_b",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data spifc_parent_data[] = {
>> +     { .fw_name = "gp0_pll" },
>> +     { .fw_name = "fclk_div2" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "fclk_div7" }
>> +};
>> +
>> +static struct clk_regmap spifc_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = SPIFC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "spifc_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = spifc_parent_data,
>> +             .num_parents = ARRAY_SIZE(spifc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap spifc_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = SPIFC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "spifc_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spifc_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spifc = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = SPIFC_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spifc",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spifc_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static u32 emmc_parent_table[] = { 0, 1, 2, 3, 4, 5, 7 };
> 
> What's 6 ? why can't it be used ?
> 

>> +
>> +static const struct clk_parent_data emmc_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .fw_name = "fclk_div2" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "gp0_pll" }
>> +};
>> +
>> +static struct clk_regmap sd_emmc_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .table = emmc_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_a_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = emmc_parent_data,
>> +             .num_parents = ARRAY_SIZE(emmc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_a_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_a = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_b_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +             .table = emmc_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_b_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = emmc_parent_data,
>> +             .num_parents = ARRAY_SIZE(emmc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_b_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_b_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_b = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .bit_idx = 23,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_b",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_c_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = NAND_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .table = emmc_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_c_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = emmc_parent_data,
>> +             .num_parents = ARRAY_SIZE(emmc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_c_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = NAND_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_c_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_c_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_c = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = NAND_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_c_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* temperature sensor */
>> +static const struct clk_parent_data ts_parent = {
>> +     .fw_name = "xtal",
>> +};
> 
> same  ...
> 
>> +
>> +static struct clk_regmap ts_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = TS_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ts_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &ts_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap ts = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = TS_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ts",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &ts_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data eth_parent = {
>> +     .fw_name = "fclk_div2",
>> +};
>> +
>> +static struct clk_fixed_factor eth_125m_div = {
>> +     .mult = 1,
>> +     .div = 8,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "eth_125m_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &eth_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap eth_125m = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ETH_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "eth_125m",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &eth_125m_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap eth_rmii_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ETH_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "eth_rmii_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &eth_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap eth_rmii = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ETH_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "eth_rmii",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &eth_rmii_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static u32 mipi_dsi_meas_parent_table[] = { 0, 1, 2, 3, 5, 6, 7 };
> 
> What is 4 ? why can't it be used ?
> 
>> +
>> +static const struct clk_parent_data mipi_dsi_meas_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "gp0_pll" },
>> +     { .fw_name = "fclk_div2" },
>> +     { .fw_name = "fclk_div7" }
>> +};
>> +
>> +static struct clk_regmap mipi_dsi_meas_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = VDIN_MEAS_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 21,
>> +             .table = mipi_dsi_meas_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mipi_dsi_meas_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = mipi_dsi_meas_parent_data,
>> +             .num_parents = ARRAY_SIZE(mipi_dsi_meas_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap mipi_dsi_meas_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = VDIN_MEAS_CLK_CTRL,
>> +             .shift = 12,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mipi_dsi_meas_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mipi_dsi_meas_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mipi_dsi_meas = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = VDIN_MEAS_CLK_CTRL,
>> +             .bit_idx = 20,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mipi_dsi_meas",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mipi_dsi_meas_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static u32 dsi_phy_parent_table[] = { 1, 2, 3, 4, 5, 6, 7 };
> 
> What about 0 ?
> 
>> +
>> +static const struct clk_parent_data dsi_phy_parent_data[] = {
>> +     { .fw_name = "gp0_pll" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div2" },
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div7" }
>> +};
>> +
>> +static struct clk_regmap dsi_phy_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = MIPIDSI_PHY_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 12,
>> +             .table = dsi_phy_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "dsi_phy_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = dsi_phy_parent_data,
>> +             .num_parents = ARRAY_SIZE(dsi_phy_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap dsi_phy_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = MIPIDSI_PHY_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "dsi_phy_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dsi_phy_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap dsi_phy = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = MIPIDSI_PHY_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dsi_phy",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dsi_phy_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static u32 vout_parent_table[] = { 1, 2, 3, 4, 5, 6, 7 };
> 
> same
> 
>> +
>> +static const struct clk_parent_data vout_parent_data[] = {
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "gp0_pll" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "fclk_div7" }
>> +};
>> +
>> +static struct clk_regmap vout_mclk_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .table = vout_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vout_mclk_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vout_parent_data,
>> +             .num_parents = ARRAY_SIZE(vout_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap vout_mclk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vout_mclk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vout_mclk_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vout_mclk = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = MIPIDSI_PHY_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vout_mclk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vout_mclk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vout_enc_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +             .table = vout_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vout_enc_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vout_parent_data,
>> +             .num_parents = ARRAY_SIZE(vout_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap vout_enc_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vout_enc_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vout_enc_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vout_enc = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vout_enc",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vout_enc_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data hcodec_pre_parent_data[] = {
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "fclk_div7" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "gp0_pll" },
>> +     { .fw_name = "xtal" }
>> +};
>> +
>> +static struct clk_regmap hcodec_0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = VDEC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hcodec_0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = hcodec_pre_parent_data,
>> +             .num_parents = ARRAY_SIZE(hcodec_pre_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap hcodec_0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = VDEC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hcodec_0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hcodec_0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap hcodec_0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = VDEC_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hcodec_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hcodec_0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap hcodec_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = VDEC3_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hcodec_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = hcodec_pre_parent_data,
>> +             .num_parents = ARRAY_SIZE(hcodec_pre_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap hcodec_1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = VDEC3_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hcodec_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hcodec_1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap hcodec_1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = VDEC3_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hcodec_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hcodec_1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data hcodec_parent_data[] = {
>> +     { .hw = &hcodec_0.hw },
>> +     { .hw = &hcodec_1.hw }
>> +};
>> +
>> +
> 
> remove extra new lines
> 
Will do.
>> +static struct clk_regmap hcodec = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = VDEC3_CLK_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 15,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hcodec",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = hcodec_parent_data,
>> +             .num_parents = ARRAY_SIZE(hcodec_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data vc9000e_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "fclk_div7" },
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "gp0_pll" }
>> +};
>> +
>> +static struct clk_regmap vc9000e_aclk_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vc9000e_aclk_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vc9000e_parent_data,
>> +             .num_parents = ARRAY_SIZE(vc9000e_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap vc9000e_aclk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vc9000e_aclk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vc9000e_aclk_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vc9000e_aclk = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vc9000e_aclk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vc9000e_aclk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vc9000e_core_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vc9000e_core_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vc9000e_parent_data,
>> +             .num_parents = ARRAY_SIZE(vc9000e_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap vc9000e_core_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vc9000e_core_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vc9000e_core_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vc9000e_core = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vc9000e_core",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vc9000e_core_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static u32 csi_phy_parent_table[] = { 0, 1, 2, 3, 4, 5, 7 };
> 
> Same here and all following instance
> 
This 1 corresponds to gp1 pll, which is currently dedicated to emmc.
>> +
>> +static const struct clk_parent_data csi_phy_parent_data[] = {
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "gp0_pll" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "xtal" }
>> +};
>> +
>> +static struct clk_regmap csi_phy0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = ISP0_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +             .table = csi_phy_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "csi_phy0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = csi_phy_parent_data,
>> +             .num_parents = ARRAY_SIZE(csi_phy_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap csi_phy0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ISP0_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "csi_phy0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &csi_phy0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap csi_phy0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ISP0_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "csi_phy0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &csi_phy0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static u32 dewarpa_parent_table[] = { 0, 1, 2, 3, 4, 5, 7 };
>> +
>> +static const struct clk_parent_data dewarpa_parent_data[] = {
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "gp0_pll" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "fclk_div7" }
>> +};
>> +
>> +static struct clk_regmap dewarpa_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = DEWARPA_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .table = dewarpa_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "dewarpa_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = dewarpa_parent_data,
>> +             .num_parents = ARRAY_SIZE(dewarpa_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap dewarpa_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = DEWARPA_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "dewarpa_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dewarpa_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap dewarpa = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = DEWARPA_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dewarpa",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dewarpa_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static u32 isp_parent_table[] = { 0, 1, 2, 3, 4, 5, 7 };
>> +
>> +static const struct clk_parent_data isp_parent_data[] = {
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "gp0_pll" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "xtal" }
>> +};
>> +
>> +static struct clk_regmap isp0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = ISP0_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .table = isp_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "isp0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = isp_parent_data,
>> +             .num_parents = ARRAY_SIZE(isp_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap isp0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ISP0_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "isp0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &isp0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap isp0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ISP0_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "isp0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &isp0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static u32 nna_core_parent_table[] = { 0, 1, 2, 3, 4, 5, 7 };
>> +
>> +static const struct clk_parent_data nna_core_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "fclk_div2" },
>> +     { .fw_name = "hifi_pll" }
>> +};
>> +
>> +static struct clk_regmap nna_core_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = NNA_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .table = nna_core_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "nna_core_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = nna_core_parent_data,
>> +             .num_parents = ARRAY_SIZE(nna_core_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap nna_core_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = NNA_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "nna_core_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &nna_core_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap nna_core = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = NNA_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "nna_core",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &nna_core_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data ge2d_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "gp0_pll" },
>> +     { .hw = &rtc_clk.hw }
>> +};
>> +
>> +static struct clk_regmap ge2d_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = GE2D_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ge2d_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = ge2d_parent_data,
>> +             .num_parents = ARRAY_SIZE(ge2d_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap ge2d_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = GE2D_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ge2d_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &ge2d_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap ge2d = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = GE2D_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ge2d",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &ge2d_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static u32 c3_vapb_parent_table[] = { 0, 1, 2, 3, 4, 5, 7 };
>> +
>> +static const struct clk_parent_data vapb_parent_data[] = {
>> +     { .fw_name = "fclk_div2p5" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "gp0_pll" },
>> +     { .fw_name = "hifi_pll" },
>> +     { .fw_name = "xtal" }
>> +};
>> +
>> +static struct clk_regmap vapb_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = VAPB_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .table = c3_vapb_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vapb_parent_data,
>> +             .num_parents = ARRAY_SIZE(vapb_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap vapb_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = VAPB_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vapb_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vapb = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = VAPB_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vapb",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vapb_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_hw *c3_periphs_hw_clks[] = {
>> +     [CLKID_PLL_IN]                  = &pll_in.hw,
>> +     [CLKID_MCLK_PLL_IN]             = &mclk_pll_in.hw,
>> +     [CLKID_RTC_XTAL_CLKIN]          = &rtc_xtal_clkin.hw,
>> +     [CLKID_RTC_32K_DIV]             = &rtc_32k_div.hw,
>> +     [CLKID_RTC_32K_MUX]             = &rtc_32k_mux.hw,
>> +     [CLKID_RTC_32K]                 = &rtc_32k.hw,
>> +     [CLKID_RTC_CLK]                 = &rtc_clk.hw,
>> +     [CLKID_SYS_A_SEL]               = &sys_a_sel.hw,
>> +     [CLKID_SYS_A_DIV]               = &sys_a_div.hw,
>> +     [CLKID_SYS_A]                   = &sys_a.hw,
>> +     [CLKID_SYS_B_SEL]               = &sys_b_sel.hw,
>> +     [CLKID_SYS_B_DIV]               = &sys_b_div.hw,
>> +     [CLKID_SYS_B]                   = &sys_b.hw,
>> +     [CLKID_SYS_CLK]                 = &sys_clk.hw,
>> +     [CLKID_AXI_A_SEL]               = &axi_a_sel.hw,
>> +     [CLKID_AXI_A_DIV]               = &axi_a_div.hw,
>> +     [CLKID_AXI_A]                   = &axi_a.hw,
>> +     [CLKID_AXI_B_SEL]               = &axi_b_sel.hw,
>> +     [CLKID_AXI_B_DIV]               = &axi_b_div.hw,
>> +     [CLKID_AXI_B]                   = &axi_b.hw,
>> +     [CLKID_AXI_CLK]                 = &axi_clk.hw,
>> +     [CLKID_SYS_RESET_CTRL]          = &sys_reset_ctrl.hw,
>> +     [CLKID_SYS_PAD_CTRL]            = &sys_pwr_ctrl.hw,
>> +     [CLKID_SYS_CTRL]                = &sys_ctrl.hw,
>> +     [CLKID_SYS_TS_PLL]              = &sys_ts_pll.hw,
>> +     [CLKID_SYS_DEV_ARB]             = &sys_dev_arb.hw,
>> +     [CLKID_SYS_MMC_PCLK]            = &sys_mmc_pclk.hw,
>> +     [CLKID_SYS_CAPU]                = &sys_capu.hw,
>> +     [CLKID_SYS_CPU_CTRL]            = &sys_cpu_ctrl.hw,
>> +     [CLKID_SYS_JTAG_CTRL]           = &sys_jtag_ctrl.hw,
>> +     [CLKID_SYS_IR_CTRL]             = &sys_ir_ctrl.hw,
>> +     [CLKID_SYS_IRQ_CTRL]            = &sys_irq_ctrl.hw,
>> +     [CLKID_SYS_MSR_CLK]             = &sys_msr_clk.hw,
>> +     [CLKID_SYS_ROM]                 = &sys_rom.hw,
>> +     [CLKID_SYS_UART_F]              = &sys_uart_f.hw,
>> +     [CLKID_SYS_CPU_ARB]             = &sys_cpu_apb.hw,
>> +     [CLKID_SYS_RSA]                 = &sys_rsa.hw,
>> +     [CLKID_SYS_SAR_ADC]             = &sys_sar_adc.hw,
>> +     [CLKID_SYS_STARTUP]             = &sys_startup.hw,
>> +     [CLKID_SYS_SECURE]              = &sys_secure.hw,
>> +     [CLKID_SYS_SPIFC]               = &sys_spifc.hw,
>> +     [CLKID_SYS_NNA]                 = &sys_nna.hw,
>> +     [CLKID_SYS_ETH_MAC]             = &sys_eth_mac.hw,
>> +     [CLKID_SYS_GIC]                 = &sys_gic.hw,
>> +     [CLKID_SYS_RAMA]                = &sys_rama.hw,
>> +     [CLKID_SYS_BIG_NIC]             = &sys_big_nic.hw,
>> +     [CLKID_SYS_RAMB]                = &sys_ramb.hw,
>> +     [CLKID_SYS_AUDIO_PCLK]          = &sys_audio_pclk.hw,
>> +     [CLKID_SYS_PWM_KL]              = &sys_pwm_kl.hw,
>> +     [CLKID_SYS_PWM_IJ]              = &sys_pwm_ij.hw,
>> +     [CLKID_SYS_USB]                 = &sys_usb.hw,
>> +     [CLKID_SYS_SD_EMMC_A]           = &sys_sd_emmc_a.hw,
>> +     [CLKID_SYS_SD_EMMC_C]           = &sys_sd_emmc_c.hw,
>> +     [CLKID_SYS_PWM_AB]              = &sys_pwm_ab.hw,
>> +     [CLKID_SYS_PWM_CD]              = &sys_pwm_cd.hw,
>> +     [CLKID_SYS_PWM_EF]              = &sys_pwm_ef.hw,
>> +     [CLKID_SYS_PWM_GH]              = &sys_pwm_gh.hw,
>> +     [CLKID_SYS_SPICC_1]             = &sys_spicc_1.hw,
>> +     [CLKID_SYS_SPICC_0]             = &sys_spicc_0.hw,
>> +     [CLKID_SYS_UART_A]              = &sys_uart_a.hw,
>> +     [CLKID_SYS_UART_B]              = &sys_uart_b.hw,
>> +     [CLKID_SYS_UART_C]              = &sys_uart_c.hw,
>> +     [CLKID_SYS_UART_D]              = &sys_uart_d.hw,
>> +     [CLKID_SYS_UART_E]              = &sys_uart_e.hw,
>> +     [CLKID_SYS_I2C_M_A]             = &sys_i2c_m_a.hw,
>> +     [CLKID_SYS_I2C_M_B]             = &sys_i2c_m_b.hw,
>> +     [CLKID_SYS_I2C_M_C]             = &sys_i2c_m_c.hw,
>> +     [CLKID_SYS_I2C_M_D]             = &sys_i2c_m_d.hw,
>> +     [CLKID_SYS_I2S_S_A]             = &sys_i2c_s_a.hw,
>> +     [CLKID_SYS_RTC]                 = &sys_rtc.hw,
>> +     [CLKID_SYS_GE2D]                = &sys_ge2d.hw,
>> +     [CLKID_SYS_ISP]                 = &sys_isp.hw,
>> +     [CLKID_SYS_GPV_ISP_NIC]         = &sys_gpv_isp_nic.hw,
>> +     [CLKID_SYS_GPV_CVE_NIC]         = &sys_gpv_cve_nic.hw,
>> +     [CLKID_SYS_MIPI_DSI_HOST]       = &sys_mipi_dsi_host.hw,
>> +     [CLKID_SYS_MIPI_DSI_PHY]        = &sys_mipi_dsi_phy.hw,
>> +     [CLKID_SYS_ETH_PHY]             = &sys_eth_phy.hw,
>> +     [CLKID_SYS_ACODEC]              = &sys_acodec.hw,
>> +     [CLKID_SYS_DWAP]                = &sys_dwap.hw,
>> +     [CLKID_SYS_DOS]                 = &sys_dos.hw,
>> +     [CLKID_SYS_CVE]                 = &sys_cve.hw,
>> +     [CLKID_SYS_VOUT]                = &sys_vout.hw,
>> +     [CLKID_SYS_VC9000E]             = &sys_vc9000e.hw,
>> +     [CLKID_SYS_PWM_MN]              = &sys_pwm_mn.hw,
>> +     [CLKID_SYS_SD_EMMC_B]           = &sys_sd_emmc_b.hw,
>> +     [CLKID_AXI_SYS_NIC]             = &axi_sys_nic.hw,
>> +     [CLKID_AXI_ISP_NIC]             = &axi_isp_nic.hw,
>> +     [CLKID_AXI_CVE_NIC]             = &axi_cve_nic.hw,
>> +     [CLKID_AXI_RAMB]                = &axi_ramb.hw,
>> +     [CLKID_AXI_RAMA]                = &axi_rama.hw,
>> +     [CLKID_AXI_CPU_DMC]             = &axi_cpu_dmc.hw,
>> +     [CLKID_AXI_NIC]                 = &axi_nic.hw,
>> +     [CLKID_AXI_DMA]                 = &axi_dma.hw,
>> +     [CLKID_AXI_MUX_NIC]             = &axi_mux_nic.hw,
>> +     [CLKID_AXI_CAPU]                = &axi_capu.hw,
>> +     [CLKID_AXI_CVE]                 = &axi_cve.hw,
>> +     [CLKID_AXI_DEV1_DMC]            = &axi_dev1_dmc.hw,
>> +     [CLKID_AXI_DEV0_DMC]            = &axi_dev0_dmc.hw,
>> +     [CLKID_AXI_DSP_DMC]             = &axi_dsp_dmc.hw,
>> +     [CLKID_12_24M_IN]               = &clk_12_24m_in.hw,
>> +     [CLKID_12M_24M]                 = &clk_12_24m.hw,
>> +     [CLKID_FCLK_25M_DIV]            = &fclk_25m_div.hw,
>> +     [CLKID_FCLK_25M]                = &fclk_25m.hw,
>> +     [CLKID_GEN_SEL]                 = &gen_sel.hw,
>> +     [CLKID_GEN_DIV]                 = &gen_div.hw,
>> +     [CLKID_GEN]                     = &gen.hw,
>> +     [CLKID_SARADC_SEL]              = &saradc_sel.hw,
>> +     [CLKID_SARADC_DIV]              = &saradc_div.hw,
>> +     [CLKID_SARADC]                  = &saradc.hw,
>> +     [CLKID_PWM_A_SEL]               = &pwm_a_sel.hw,
>> +     [CLKID_PWM_A_DIV]               = &pwm_a_div.hw,
>> +     [CLKID_PWM_A]                   = &pwm_a.hw,
>> +     [CLKID_PWM_B_SEL]               = &pwm_b_sel.hw,
>> +     [CLKID_PWM_B_DIV]               = &pwm_b_div.hw,
>> +     [CLKID_PWM_B]                   = &pwm_b.hw,
>> +     [CLKID_PWM_C_SEL]               = &pwm_c_sel.hw,
>> +     [CLKID_PWM_C_DIV]               = &pwm_c_div.hw,
>> +     [CLKID_PWM_C]                   = &pwm_c.hw,
>> +     [CLKID_PWM_D_SEL]               = &pwm_d_sel.hw,
>> +     [CLKID_PWM_D_DIV]               = &pwm_d_div.hw,
>> +     [CLKID_PWM_D]                   = &pwm_d.hw,
>> +     [CLKID_PWM_E_SEL]               = &pwm_e_sel.hw,
>> +     [CLKID_PWM_E_DIV]               = &pwm_e_div.hw,
>> +     [CLKID_PWM_E]                   = &pwm_e.hw,
>> +     [CLKID_PWM_F_SEL]               = &pwm_f_sel.hw,
>> +     [CLKID_PWM_F_DIV]               = &pwm_f_div.hw,
>> +     [CLKID_PWM_F]                   = &pwm_f.hw,
>> +     [CLKID_PWM_G_SEL]               = &pwm_g_sel.hw,
>> +     [CLKID_PWM_G_DIV]               = &pwm_g_div.hw,
>> +     [CLKID_PWM_G]                   = &pwm_g.hw,
>> +     [CLKID_PWM_H_SEL]               = &pwm_h_sel.hw,
>> +     [CLKID_PWM_H_DIV]               = &pwm_h_div.hw,
>> +     [CLKID_PWM_H]                   = &pwm_h.hw,
>> +     [CLKID_PWM_I_SEL]               = &pwm_i_sel.hw,
>> +     [CLKID_PWM_I_DIV]               = &pwm_i_div.hw,
>> +     [CLKID_PWM_I]                   = &pwm_i.hw,
>> +     [CLKID_PWM_J_SEL]               = &pwm_j_sel.hw,
>> +     [CLKID_PWM_J_DIV]               = &pwm_j_div.hw,
>> +     [CLKID_PWM_J]                   = &pwm_j.hw,
>> +     [CLKID_PWM_K_SEL]               = &pwm_k_sel.hw,
>> +     [CLKID_PWM_K_DIV]               = &pwm_k_div.hw,
>> +     [CLKID_PWM_K]                   = &pwm_k.hw,
>> +     [CLKID_PWM_L_SEL]               = &pwm_l_sel.hw,
>> +     [CLKID_PWM_L_DIV]               = &pwm_l_div.hw,
>> +     [CLKID_PWM_L]                   = &pwm_l.hw,
>> +     [CLKID_PWM_M_SEL]               = &pwm_m_sel.hw,
>> +     [CLKID_PWM_M_DIV]               = &pwm_m_div.hw,
>> +     [CLKID_PWM_M]                   = &pwm_m.hw,
>> +     [CLKID_PWM_N_SEL]               = &pwm_n_sel.hw,
>> +     [CLKID_PWM_N_DIV]               = &pwm_n_div.hw,
>> +     [CLKID_PWM_N]                   = &pwm_n.hw,
>> +     [CLKID_SPICC_A_SEL]             = &spicc_a_sel.hw,
>> +     [CLKID_SPICC_A_DIV]             = &spicc_a_div.hw,
>> +     [CLKID_SPICC_A]                 = &spicc_a.hw,
>> +     [CLKID_SPICC_B_SEL]             = &spicc_b_sel.hw,
>> +     [CLKID_SPICC_B_DIV]             = &spicc_b_div.hw,
>> +     [CLKID_SPICC_B]                 = &spicc_b.hw,
>> +     [CLKID_SPIFC_SEL]               = &spifc_sel.hw,
>> +     [CLKID_SPIFC_DIV]               = &spifc_div.hw,
>> +     [CLKID_SPIFC]                   = &spifc.hw,
>> +     [CLKID_SD_EMMC_A_SEL]           = &sd_emmc_a_sel.hw,
>> +     [CLKID_SD_EMMC_A_DIV]           = &sd_emmc_a_div.hw,
>> +     [CLKID_SD_EMMC_A]               = &sd_emmc_a.hw,
>> +     [CLKID_SD_EMMC_B_SEL]           = &sd_emmc_b_sel.hw,
>> +     [CLKID_SD_EMMC_B_DIV]           = &sd_emmc_b_div.hw,
>> +     [CLKID_SD_EMMC_B]               = &sd_emmc_b.hw,
>> +     [CLKID_SD_EMMC_C_SEL]           = &sd_emmc_c_sel.hw,
>> +     [CLKID_SD_EMMC_C_DIV]           = &sd_emmc_c_div.hw,
>> +     [CLKID_SD_EMMC_C]               = &sd_emmc_c.hw,
>> +     [CLKID_TS_DIV]                  = &ts_div.hw,
>> +     [CLKID_TS]                      = &ts.hw,
>> +     [CLKID_ETH_125M_DIV]            = &eth_125m_div.hw,
>> +     [CLKID_ETH_125M]                = &eth_125m.hw,
>> +     [CLKID_ETH_RMII_DIV]            = &eth_rmii_div.hw,
>> +     [CLKID_ETH_RMII]                = &eth_rmii.hw,
>> +     [CLKID_MIPI_DSI_MEAS_SEL]       = &mipi_dsi_meas_sel.hw,
>> +     [CLKID_MIPI_DSI_MEAS_DIV]       = &mipi_dsi_meas_div.hw,
>> +     [CLKID_MIPI_DSI_MEAS]           = &mipi_dsi_meas.hw,
>> +     [CLKID_DSI_PHY_SEL]             = &dsi_phy_sel.hw,
>> +     [CLKID_DSI_PHY_DIV]             = &dsi_phy_div.hw,
>> +     [CLKID_DSI_PHY]                 = &dsi_phy.hw,
>> +     [CLKID_VOUT_MCLK_SEL]           = &vout_mclk_sel.hw,
>> +     [CLKID_VOUT_MCLK_DIV]           = &vout_mclk_div.hw,
>> +     [CLKID_VOUT_MCLK]               = &vout_mclk.hw,
>> +     [CLKID_VOUT_ENC_SEL]            = &vout_enc_sel.hw,
>> +     [CLKID_VOUT_ENC_DIV]            = &vout_enc_div.hw,
>> +     [CLKID_VOUT_ENC]                = &vout_enc.hw,
>> +     [CLKID_HCODEC_0_SEL]            = &hcodec_0_sel.hw,
>> +     [CLKID_HCODEC_0_DIV]            = &hcodec_0_div.hw,
>> +     [CLKID_HCODEC_0]                = &hcodec_0.hw,
>> +     [CLKID_HCODEC_1_SEL]            = &hcodec_1_sel.hw,
>> +     [CLKID_HCODEC_1_DIV]            = &hcodec_1_div.hw,
>> +     [CLKID_HCODEC_1]                = &hcodec_1.hw,
>> +     [CLKID_HCODEC]                  = &hcodec.hw,
>> +     [CLKID_VC9000E_ACLK_SEL]        = &vc9000e_aclk_sel.hw,
>> +     [CLKID_VC9000E_ACLK_DIV]        = &vc9000e_aclk_div.hw,
>> +     [CLKID_VC9000E_ACLK]            = &vc9000e_aclk.hw,
>> +     [CLKID_VC9000E_CORE_SEL]        = &vc9000e_core_sel.hw,
>> +     [CLKID_VC9000E_CORE_DIV]        = &vc9000e_core_div.hw,
>> +     [CLKID_VC9000E_CORE]            = &vc9000e_core.hw,
>> +     [CLKID_CSI_PHY0_SEL]            = &csi_phy0_sel.hw,
>> +     [CLKID_CSI_PHY0_DIV]            = &csi_phy0_div.hw,
>> +     [CLKID_CSI_PHY0]                = &csi_phy0.hw,
>> +     [CLKID_DEWARPA_SEL]             = &dewarpa_sel.hw,
>> +     [CLKID_DEWARPA_DIV]             = &dewarpa_div.hw,
>> +     [CLKID_DEWARPA]                 = &dewarpa.hw,
>> +     [CLKID_ISP0_SEL]                = &isp0_sel.hw,
>> +     [CLKID_ISP0_DIV]                = &isp0_div.hw,
>> +     [CLKID_ISP0]                    = &isp0.hw,
>> +     [CLKID_NNA_CORE_SEL]            = &nna_core_sel.hw,
>> +     [CLKID_NNA_CORE_DIV]            = &nna_core_div.hw,
>> +     [CLKID_NNA_CORE]                = &nna_core.hw,
>> +     [CLKID_GE2D_SEL]                = &ge2d_sel.hw,
>> +     [CLKID_GE2D_DIV]                = &ge2d_div.hw,
>> +     [CLKID_GE2D]                    = &ge2d.hw,
>> +     [CLKID_VAPB_SEL]                = &vapb_sel.hw,
>> +     [CLKID_VAPB_DIV]                = &vapb_div.hw,
>> +     [CLKID_VAPB]                    = &vapb.hw,
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const c3_periphs_clk_regmaps[] = {
>> +     &pll_in,
>> +     &mclk_pll_in,
>> +     &rtc_xtal_clkin,
>> +     &rtc_32k_div,
>> +     &rtc_32k_mux,
>> +     &rtc_32k,
>> +     &rtc_clk,
>> +     &sys_a_sel,
>> +     &sys_a_div,
>> +     &sys_a,
>> +     &sys_b_sel,
>> +     &sys_b_div,
>> +     &sys_b,
>> +     &sys_clk,
>> +     &axi_a_sel,
>> +     &axi_a_div,
>> +     &axi_a,
>> +     &axi_b_sel,
>> +     &axi_b_div,
>> +     &axi_b,
>> +     &axi_clk,
>> +     &sys_reset_ctrl,
>> +     &sys_pwr_ctrl,
>> +     &sys_pad_ctrl,
>> +     &sys_ctrl,
>> +     &sys_ts_pll,
>> +     &sys_dev_arb,
>> +     &sys_mmc_pclk,
>> +     &sys_capu,
>> +     &sys_cpu_ctrl,
>> +     &sys_jtag_ctrl,
>> +     &sys_ir_ctrl,
>> +     &sys_irq_ctrl,
>> +     &sys_msr_clk,
>> +     &sys_rom,
>> +     &sys_uart_f,
>> +     &sys_cpu_apb,
>> +     &sys_rsa,
>> +     &sys_sar_adc,
>> +     &sys_startup,
>> +     &sys_secure,
>> +     &sys_spifc,
>> +     &sys_nna,
>> +     &sys_eth_mac,
>> +     &sys_gic,
>> +     &sys_rama,
>> +     &sys_big_nic,
>> +     &sys_ramb,
>> +     &sys_audio_pclk,
>> +     &sys_pwm_kl,
>> +     &sys_pwm_ij,
>> +     &sys_usb,
>> +     &sys_sd_emmc_a,
>> +     &sys_sd_emmc_c,
>> +     &sys_pwm_ab,
>> +     &sys_pwm_cd,
>> +     &sys_pwm_ef,
>> +     &sys_pwm_gh,
>> +     &sys_spicc_1,
>> +     &sys_spicc_0,
>> +     &sys_uart_a,
>> +     &sys_uart_b,
>> +     &sys_uart_c,
>> +     &sys_uart_d,
>> +     &sys_uart_e,
>> +     &sys_i2c_m_a,
>> +     &sys_i2c_m_b,
>> +     &sys_i2c_m_c,
>> +     &sys_i2c_m_d,
>> +     &sys_i2c_s_a,
>> +     &sys_rtc,
>> +     &sys_ge2d,
>> +     &sys_isp,
>> +     &sys_gpv_isp_nic,
>> +     &sys_gpv_cve_nic,
>> +     &sys_mipi_dsi_host,
>> +     &sys_mipi_dsi_phy,
>> +     &sys_eth_phy,
>> +     &sys_acodec,
>> +     &sys_dwap,
>> +     &sys_dos,
>> +     &sys_cve,
>> +     &sys_vout,
>> +     &sys_vc9000e,
>> +     &sys_pwm_mn,
>> +     &sys_sd_emmc_b,
>> +     &axi_sys_nic,
>> +     &axi_isp_nic,
>> +     &axi_cve_nic,
>> +     &axi_ramb,
>> +     &axi_rama,
>> +     &axi_cpu_dmc,
>> +     &axi_nic,
>> +     &axi_dma,
>> +     &axi_mux_nic,
>> +     &axi_capu,
>> +     &axi_cve,
>> +     &axi_dev1_dmc,
>> +     &axi_dev0_dmc,
>> +     &axi_dsp_dmc,
>> +     &clk_12_24m_in,
>> +     &clk_12_24m,
>> +     &fclk_25m_div,
>> +     &fclk_25m,
>> +     &gen_sel,
>> +     &gen_div,
>> +     &gen,
>> +     &saradc_sel,
>> +     &saradc_div,
>> +     &saradc,
>> +     &pwm_a_sel,
>> +     &pwm_a_div,
>> +     &pwm_a,
>> +     &pwm_b_sel,
>> +     &pwm_b_div,
>> +     &pwm_b,
>> +     &pwm_c_sel,
>> +     &pwm_c_div,
>> +     &pwm_c,
>> +     &pwm_d_sel,
>> +     &pwm_d_div,
>> +     &pwm_d,
>> +     &pwm_e_sel,
>> +     &pwm_e_div,
>> +     &pwm_e,
>> +     &pwm_f_sel,
>> +     &pwm_f_div,
>> +     &pwm_f,
>> +     &pwm_g_sel,
>> +     &pwm_g_div,
>> +     &pwm_g,
>> +     &pwm_h_sel,
>> +     &pwm_h_div,
>> +     &pwm_h,
>> +     &pwm_i_sel,
>> +     &pwm_i_div,
>> +     &pwm_i,
>> +     &pwm_j_sel,
>> +     &pwm_j_div,
>> +     &pwm_j,
>> +     &pwm_k_sel,
>> +     &pwm_k_div,
>> +     &pwm_k,
>> +     &pwm_l_sel,
>> +     &pwm_l_div,
>> +     &pwm_l,
>> +     &pwm_m_sel,
>> +     &pwm_m_div,
>> +     &pwm_m,
>> +     &pwm_n_sel,
>> +     &pwm_n_div,
>> +     &pwm_n,
>> +     &spicc_a_sel,
>> +     &spicc_a_div,
>> +     &spicc_a,
>> +     &spicc_b_sel,
>> +     &spicc_b_div,
>> +     &spicc_b,
>> +     &spifc_sel,
>> +     &spifc_div,
>> +     &spifc,
>> +     &sd_emmc_a_sel,
>> +     &sd_emmc_a_div,
>> +     &sd_emmc_a,
>> +     &sd_emmc_b_sel,
>> +     &sd_emmc_b_div,
>> +     &sd_emmc_b,
>> +     &sd_emmc_c_sel,
>> +     &sd_emmc_c_div,
>> +     &sd_emmc_c,
>> +     &ts_div,
>> +     &ts,
>> +     &eth_125m,
>> +     &eth_rmii_div,
>> +     &eth_rmii,
>> +     &mipi_dsi_meas_sel,
>> +     &mipi_dsi_meas_div,
>> +     &mipi_dsi_meas,
>> +     &dsi_phy_sel,
>> +     &dsi_phy_div,
>> +     &dsi_phy,
>> +     &vout_mclk_sel,
>> +     &vout_mclk_div,
>> +     &vout_mclk,
>> +     &vout_enc_sel,
>> +     &vout_enc_div,
>> +     &vout_enc,
>> +     &hcodec_0_sel,
>> +     &hcodec_0_div,
>> +     &hcodec_0,
>> +     &hcodec_1_sel,
>> +     &hcodec_1_div,
>> +     &hcodec_1,
>> +     &hcodec,
>> +     &vc9000e_aclk_sel,
>> +     &vc9000e_aclk_div,
>> +     &vc9000e_aclk,
>> +     &vc9000e_core_sel,
>> +     &vc9000e_core_div,
>> +     &vc9000e_core,
>> +     &csi_phy0_sel,
>> +     &csi_phy0_div,
>> +     &csi_phy0,
>> +     &dewarpa_sel,
>> +     &dewarpa_div,
>> +     &dewarpa,
>> +     &isp0_sel,
>> +     &isp0_div,
>> +     &isp0,
>> +     &nna_core_sel,
>> +     &nna_core_div,
>> +     &nna_core,
>> +     &ge2d_sel,
>> +     &ge2d_div,
>> +     &ge2d,
>> +     &vapb_sel,
>> +     &vapb_div,
>> +     &vapb,
>> +};
>> +
>> +static struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +};
>> +
>> +static struct meson_clk_hw_data c3_periphs_clks = {
>> +     .hws = c3_periphs_hw_clks,
>> +     .num = ARRAY_SIZE(c3_periphs_hw_clks),
>> +};
>> +
>> +static int aml_c3_peripherals_probe(struct platform_device *pdev)
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
>> +     for (i = 0; i < ARRAY_SIZE(c3_periphs_clk_regmaps); i++)
>> +             c3_periphs_clk_regmaps[i]->map = regmap;
>> +
>> +     for (clkid = 0; clkid < c3_periphs_clks.num; clkid++) {
>> +             /* array might be sparse */
>> +             if (!c3_periphs_clks.hws[clkid])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, c3_periphs_clks.hws[clkid]);
>> +             if (ret) {
>> +                     dev_err(dev, "Clock registration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
>> +                                        &c3_periphs_clks);
>> +}
>> +
>> +static const struct of_device_id c3_peripherals_clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,c3-peripherals-clkc",
>> +     },
>> +     {}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, c3_peripherals_clkc_match_table);
>> +
>> +static struct platform_driver c3_peripherals_driver = {
>> +     .probe          = aml_c3_peripherals_probe,
>> +     .driver         = {
>> +             .name   = "c3-peripherals-clkc",
>> +             .of_match_table = c3_peripherals_clkc_match_table,
>> +     },
>> +};
>> +
>> +module_platform_driver(c3_peripherals_driver);
>> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/clk/meson/c3-peripherals.h b/drivers/clk/meson/c3-peripherals.h
>> new file mode 100644
>> index 000000000000..ddcc23e25669
>> --- /dev/null
>> +++ b/drivers/clk/meson/c3-peripherals.h
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2023 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#ifndef __AML_C3_PERIPHERALS_H__
>> +#define __AML_C3_PERIPHERALS_H__
>> +
>> +#define OSCIN_CTRL                           0x0004
>> +#define RTC_BY_OSCIN_CTRL0                   0x0008
>> +#define RTC_BY_OSCIN_CTRL1                   0x000c
>> +#define RTC_CTRL                             0x0010
>> +#define SYS_CLK_CTRL0                                0x0040
>> +#define SYS_CLK_EN0_REG0                     0x0044
>> +#define SYS_CLK_EN0_REG1                     0x0048
>> +#define SYS_CLK_EN0_REG2                     0x004c
>> +#define AXI_CLK_CTRL0                                0x006c
>> +#define CLK12_24_CTRL                                0x00a8
>> +#define AXI_CLK_EN0                          0x00ac
>> +#define VDIN_MEAS_CLK_CTRL                   0x00f8
>> +#define VAPB_CLK_CTRL                                0x00fc
>> +#define MIPIDSI_PHY_CLK_CTRL                 0x0104
>> +#define GE2D_CLK_CTRL                                0x010c
>> +#define ISP0_CLK_CTRL                                0x0110
>> +#define DEWARPA_CLK_CTRL                     0x0114
>> +#define VOUTENC_CLK_CTRL                     0x0118
>> +#define VDEC_CLK_CTRL                                0x0140
>> +#define VDEC3_CLK_CTRL                               0x0148
>> +#define TS_CLK_CTRL                          0x0158
>> +#define ETH_CLK_CTRL                         0x0164
>> +#define NAND_CLK_CTRL                                0x0168
>> +#define SD_EMMC_CLK_CTRL                     0x016c
>> +#define SPICC_CLK_CTRL                               0x0174
>> +#define GEN_CLK_CTRL                         0x0178
>> +#define SAR_CLK_CTRL0                                0x017c
>> +#define PWM_CLK_AB_CTRL                              0x0180
>> +#define PWM_CLK_CD_CTRL                              0x0184
>> +#define PWM_CLK_EF_CTRL                              0x0188
>> +#define PWM_CLK_GH_CTRL                              0x018c
>> +#define PWM_CLK_IJ_CTRL                              0x0190
>> +#define PWM_CLK_KL_CTRL                              0x0194
>> +#define PWM_CLK_MN_CTRL                              0x0198
>> +#define VC9000E_CLK_CTRL                     0x019c
>> +#define SPIFC_CLK_CTRL                               0x01a0
>> +#define NNA_CLK_CTRL                         0x0220
> 
> Nitpick - the extra zero is not needed
> Since this is used only by c3 periph clkc - do you really need an header
> or can it be defined in the related .c file ?
> 
> (I know this is a pattern we have been using so far, but it is not
> really justified. No reason to continue with it)
> 
>> +
>> +#endif  /* __AML_C3_PERIPHERALS_H__ */
> 
