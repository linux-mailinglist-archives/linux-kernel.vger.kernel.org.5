Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583C5785311
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjHWItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjHWIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:46:23 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2113.outbound.protection.outlook.com [40.107.255.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5280A1996;
        Wed, 23 Aug 2023 01:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GG6CrBDqTDGXB6lqW3W4cGoI3ENs5Z7dF2LZm9yNKhg87E48eW7gRpiTdfkihMMfVA3fna7f12M0kexRpA1Hv2yAUqcxuDIBLWTHmMzDrwHz73wupuQSLpfn4POUMtmL4WfoURUUOyj1AGhK2nd8c5+1vdjFMTPFF1mccSrh6OHhpUAFl9V5ulUAg6dEPguG4Ksvri/gN5Qd5d35mLdAL8XHpaQ8Vv4QNv2aM3JdbscxL6+yKKWA6VPL/+eNspYw0oSjiX7jcfRwG0Z4NtlsUJNUyUux/g9X8Yx9EpP8PI7X6it3w1VHG79PYV7y+ALDcE3oo1dyE4dcQbYvHXKhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6x4ZAug8mOYy9zS3oHoDGyvaPiz290JgStnzkKSkuU=;
 b=OISrBypJiSM6x3iVWPYH2cchg38NX7sGI0GDFwgoVAjvpQIg/FseS59OffuHOVvxyFwpQD/vwAwcPuVosFczRwK0fxzVydE50cTfNc+uS/PfQfoqnOBFZqv4SaU+OZrRKMZiXjTtc7jHBsHWXmkPiL1OPuYOCzZD/mNaHcZNg0ehfqzXsXODLz9Ahs/AxaMniomjCIUDcpAARc5SBN5qSsW0fExhbw6vsSrZVXrzZCCqeDK/hJRCTIh2iYi5IN4TLuO40VzUmuS7iEHZ4eF/Go4lKCRwjCUqQB86KZzOhUC3TpaaA+6zMAwAP0LtPBYlb8uMGeYlB2R+2UakM7/MLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6x4ZAug8mOYy9zS3oHoDGyvaPiz290JgStnzkKSkuU=;
 b=wk3HWJED8kN9OUSPDPsxOO7pixkM94d+GfuuTRVN+cWOLAgNjFKOzGz3TU8tDdDi73/ua94AUL2lo0ug1pSyryG95bIrEeDxNAFI+EJ1RXOssbdUJgYEJnDnEjVr7nZvPOt7wEGe3PrvYH8sTwPa7/8SNFz+I5U6w+uYPN0Nlx1eZmRY2fzUg1n05lvd0QJOXnevWOXdkqn2AteBVK3dfwIa1ma/fWutbcsrissJFfhHGZqmjkL1A+Dj9s/utURoxOvE9XZJBySdSobNVlyJNXpJFHe7ZB6vQIt/n7paWu5z4jG7apXba8yI+mffQMVqR3Ti2t/YLKtYqItmefJNeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SEZPR03MB7245.apcprd03.prod.outlook.com (2603:1096:101:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Wed, 23 Aug 2023 08:41:55 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed%4]) with mapi id 15.20.6678.029; Wed, 23 Aug 2023
 08:41:54 +0000
Message-ID: <7cb18947-282d-0a3c-bec0-2059d1cffd51@amlogic.com>
Date:   Wed, 23 Aug 2023 16:41:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V10 4/4] clk: meson: S4: add support for Amlogic S4 SoC
 peripheral clock controller
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230822082750.27633-1-yu.tu@amlogic.com>
 <20230822082750.27633-5-yu.tu@amlogic.com>
 <1j7cpm9nfb.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1j7cpm9nfb.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|SEZPR03MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 454c7be6-f836-45a1-cefb-08dba3b4cd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Its0yQ7FaHHy3Lc/sNxvRL/La2cgA82oJGoM647kyuG5SaCiI9211X3Dw91fzL/knNMHHC6k1brqCUc0KHyFx2Z7I5Xnx276SnIN5ini6PfNyvzX4ujD57BH3ZhFJWxVwxp5pNu3LLDZCOhxM4qLsl5HmebC7Dx9nsfYn931xawnG3GBcLFtDThn6hCb8S8juU63yEtzKHVGp3666md1m5a7c+b+SHtr71AZqaWPT/9+4nYjBNvSHqac1kkvvS54VGpv5xRrtMeOJFDHCEqs+NMv8A/fct3VWgQBVsNaSyTJ8diyA6BUJgOpGuuK/zBVl4iGTUSiZILUmEYSzLHphlcpZe46xnVVBsfS3j0QZFC5xJ/3aysrfjoYki5FXeo6qM8+Pw0fJ6hIZvGDus6Vsxu/uT7Wdsh5Dnn7ZL71nMhhM1I0nnyqdotbaqNJk5jPTY3ZsnewWfms0e/RqXjdamRJDOv+uDnUq4c0Q1eol0t8SxMXCoVjUsg/dhHLzokN7NZ0uzq4XpK0OlUEFiqQeHzYPdpdFN1Kz8cx1cF7FSbqZsQNUlKqe/fF1k05RXoy7jGSG/QJyqXBpqSbUxTx1geL7yBX+nVHIbKB0hfGmhrOLCebGGDUnuEbhoI2gaR4HKRjgwlKmr4yIf4B3jLciaSC101U0MhkRcNLRjxFg/SRqlTST7xVV1vV+ZQE6N36emxvwjUrgTi0n2lo42fAl34j17uz6W745A7DFE0PFAdPnt+1eY9hcRZ111CXgt9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39850400004)(346002)(186009)(1800799009)(451199024)(86362001)(31696002)(44832011)(5660300002)(8676002)(8936002)(7416002)(30864003)(4326008)(2906002)(36756003)(6512007)(6506007)(53546011)(6486002)(6666004)(2616005)(26005)(921005)(107886003)(478600001)(12101799020)(83380400001)(31686004)(66556008)(66946007)(316002)(66476007)(38100700002)(41300700001)(110136005)(45980500001)(43740500002)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slc4U0RsNTU3S3NkRXdNOHJaL3hXZzJTcFY4TlFicXhnK3ZFVnViT2ZJbXND?=
 =?utf-8?B?Q24yTCtTajVuZW9rSW4xSyticWpySzRCdmRJNWI2V2M1YWQ4TW1oYXQzbFNw?=
 =?utf-8?B?bU1LelE3TUJNTzIvaEx2SGpITGRmZXJLQkxrK0ExWkp6ZU5ka09zU1lnYW1n?=
 =?utf-8?B?dC8yWWFuNnB1MHNaYTA0eVVqc3lBM25zNHBZdnpkSVpTWE9KVkxoNXBGY1Y2?=
 =?utf-8?B?azhWUEZUWUdhRjJiZW0vOENYYjFZd01VUmJtT0lPRDFjRTV2U05PUzdRTHha?=
 =?utf-8?B?OE0xTVFONlh2TjJBSHoxN0dadFo5QjUrMUo1d1dQSjg0OWFFcEZBQTM3UU9Q?=
 =?utf-8?B?bHBFVG0yTVJjU0pxMFU4Wm5JcGVWTE45TTIxNmIzeTlma1RpNW1BcW1IMU1P?=
 =?utf-8?B?aTJzSGJEYVV4cWVUWUREcGtra1V3L1NFMEh5azJXTlJHYTRjKzNoaEtWeWNN?=
 =?utf-8?B?UFdCKzd2VGtCbGpJbklSSytuaFFOd1NYVm42MEFvS1ZzdzZTK28zU1FlL2Vw?=
 =?utf-8?B?UG4yKzAxc2ExKzJoVXJYWFNvWXV0bFcvU1RhU3VyM0RCdDlUeFp2TlZ4UTRL?=
 =?utf-8?B?M1Y0UFFLOWY3MXZmNXd0cFlpNHhRZE5mOXJTWEpGeGRnUUx0dDJwaE9BaEdQ?=
 =?utf-8?B?V1BmQ2MzcHhIa3UwMzhSOEw1UHlUQ0RpQW9pejVvcWJWdG5rZ2p3eWd5RzhO?=
 =?utf-8?B?TWxremFOZDFTS0NjMWVGdll2cjdxRldUdkU4aG50dEo0SXNXY2ZXSm5OYzZV?=
 =?utf-8?B?ZW5VNkdoTEZ0Vml0M0w2UDRXdWhuczlUL2w2ZGJvb1h4UFZMekZSSWFCenVX?=
 =?utf-8?B?aWpsOE1IZThzaWJocC83KzNhZ2dUVEtVSFBOUXR3aW5hd3ZDSnpMQ0RTTEdZ?=
 =?utf-8?B?WUhOaVI0dFRRdCs3OWdvMTNUck5MQzdRc0dyQmNkS010dVZQSHl1Sm9HQVlq?=
 =?utf-8?B?cGVmbUJRMHFYVWVpSVRDY0Y5NFI1em5aQlc3Y3BZVU01UHJOV1Q1bndvRU5k?=
 =?utf-8?B?R0xDY0JIVkNqeUNpU0Nkakk4RkdlekJDZFcydlpCanNNV2wwZ2MxYk5wckR2?=
 =?utf-8?B?NFJXTElNV0k3WjFXdGNNUlVvd1RzMUF0cmZ0YkZZL29vZyt2NVEwZFRwNEZu?=
 =?utf-8?B?a3pjVEpUdXFVVFhtNDJ3YnVrS1gwWG9xTFoxODNxMFBBanJwMURRTWFLbnVu?=
 =?utf-8?B?eis4QjZLR1haMTJWSGJnQjc0bnltWXVEdVpxcWtTeWhIN0JqVUZBei83Q1ZS?=
 =?utf-8?B?RXptbnJPOTkxWS9KemFaSGx1ZlJ2VVhpT2VuV04vcHc2UkkzUU1RQXVKRnhG?=
 =?utf-8?B?VTNYWlZsVXN0amVvVHIrOUkzWUxqTVRzR25IbTlxWVJiajZmRloxT3FjaFZk?=
 =?utf-8?B?Q2ZKWmlxMWsvdFBuRmJUa2NINUlsZVVQZFd0b2ZpV1l3S25IOE1mdEZMMVR6?=
 =?utf-8?B?NUNmU1Q4MThsaTZybmFPdEp5ZFlHSHdFSUFocE0wK25MRXdRV0I1V1hXMHF2?=
 =?utf-8?B?bys3cVh6ZzVWREMzL3I3cE50Q1FoTVdpZ2w2Wk0xTlJxNC9abUNVWWI1YkVr?=
 =?utf-8?B?T0MxOGNaeFBaLzlRUWg1UlhwRkpZS0hLRWdwQUcxQlNXVWYwWjhhck5iOTdn?=
 =?utf-8?B?MXNoODhIRGtTZGVKWkRoMjlsRlJWRHlkTzJVaEVzQTdLRGdyTmlnOE5OWkVY?=
 =?utf-8?B?K3dmajh4UE52dlRSZUtFTTYyTFJmSG5zNS9yV2hUcUFOeUloNCtOREFmOWtJ?=
 =?utf-8?B?dDRRZWhBekhZMXdWdlc1MEJEbzlsNldCNmcrK3BpalhqcWF1YmRXMnhRdW1W?=
 =?utf-8?B?Wm5ueXhFQ25LNHpKczJNRXNpTUoyNTh3d2RsZmxkTk9DWnY5WkpsRUFsMCtH?=
 =?utf-8?B?c3c4eEdPOUcvSUF2Vi9FSEFtWk1YeU9wbmhRYk9yNnVRV1Z0RWJuTHExU0FJ?=
 =?utf-8?B?U2dZYlRCa2JOcjA5TDM3ZE5xK29oVU5uWldGRUkwS25DZ2J1TFA2V2kzQ1JB?=
 =?utf-8?B?ZStvUHpXaHFEL0MzdFQ2ZnYrOG1SQ1JkZVdmUDNCWUcrWDVVcEhCUTE4b3BK?=
 =?utf-8?B?VmRMWmVLMDNKRUFodlREVmVQYjRxeWl3MTlHTWh1QnEweWx3NUp0RCsvUDVv?=
 =?utf-8?Q?LNRSb87gY1J1B7oU4Cket9phZ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454c7be6-f836-45a1-cefb-08dba3b4cd99
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 08:41:54.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVhGV+KWbLyM8c50xKSY8Udj3hwc+Yz07wSgGKEZCdsZluP9ffX3E8pRKFBssqZHK9M2/Wnp6TqV2OPlb+kV2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7245
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/23 16:13, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue 22 Aug 2023 at 16:27, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Add the peripherals clock controller driver in the S4 SoC family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig          |   11 +
>>   drivers/clk/meson/Makefile         |    1 +
>>   drivers/clk/meson/s4-peripherals.c | 3787 ++++++++++++++++++++++++++++
>>   drivers/clk/meson/s4-peripherals.h |   57 +
>>   4 files changed, 3856 insertions(+)
>>   create mode 100644 drivers/clk/meson/s4-peripherals.c
>>   create mode 100644 drivers/clk/meson/s4-peripherals.h
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index e90982d77598..c5303e4c1604 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -156,4 +156,15 @@ config COMMON_CLK_S4_PLL
>>          Support for the PLL clock controller on Amlogic S805X2 and S905Y4 devices,
>>          AKA S4. Say Y if you want the board to work, because PLLs are the parent of
>>          most peripherals.
>> +
>> +config COMMON_CLK_S4_PERIPHERALS
>> +     tristate "S4 SoC peripherals clock controllers support"
>> +     depends on ARM64
>> +     default y
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_DUALDIV
>> +     select COMMON_CLK_MESON_VID_PLL_DIV
>> +     help
>> +       Support for the peripherals clock controller on Amlogic S805X2 and S905Y4
>> +       devices, AKA S4. Say Y if you want S4 peripherals clock controller to work.
>>   endmenu
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 612cee923890..9ee4b954c896 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -23,3 +23,4 @@ obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>>   obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
>> +obj-$(CONFIG_COMMON_CLK_S4_PERIPHERALS) += s4-peripherals.o
>> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
>> new file mode 100644
>> index 000000000000..60de4beb1561
>> --- /dev/null
>> +++ b/drivers/clk/meson/s4-peripherals.c
>> @@ -0,0 +1,3787 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>> +/*
>> + * Amlogic S4 Peripherals Clock Controller Driver
>> + *
>> + * Copyright (c) 2022-2023 Amlogic, inc. All rights reserved
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-regmap.h"
>> +#include "vid-pll-div.h"
>> +#include "clk-dualdiv.h"
>> +#include "s4-peripherals.h"
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin_clkin = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_by_oscin_clkin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct meson_clk_dualdiv_param s4_32k_div_table[] = {
>> +     {
>> +             .dual   = 1,
>> +             .n1     = 733,
>> +             .m1     = 8,
>> +             .n2     = 732,
>> +             .m2     = 11,
>> +     },
>> +     {}
>> +};
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin_div = {
>> +     .data = &(struct meson_clk_dualdiv_data){
>> +             .n1 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = s4_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_32k_by_oscin_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_rtc_32k_by_oscin_clkin.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_32k_by_oscin_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_rtc_32k_by_oscin_div.hw,
>> +                     &s4_rtc_32k_by_oscin_clkin.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_by_oscin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_rtc_32k_by_oscin_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_rtc_clk = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_RTC_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 0,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_clk_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_rtc_32k_by_oscin.hw,
>> +                     &s4_rtc_32k_by_oscin_div.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* The index 5 is AXI_CLK, which is dedicated to AXI. So skip it. */
>> +static u32 mux_table_sys_ab_clk_sel[] = { 0, 1, 2, 3, 4, 6, 7 };
>> +static const struct clk_parent_data sys_ab_clk_parent_data[] = {
>> +     { .fw_name = "xtal" },
>> +     { .fw_name = "fclk_div2" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "fclk_div7" },
>> +     { .hw = &s4_rtc_clk.hw }
>> +};
>> +
>> +/*
>> + * This clock is initialized by ROMcode.
>> + * The chip was changed SYS CLK for security reasons. SYS CLK registers are not writable
>> + * in the kernel phase. Write of SYS related register will cause the system to crash.
>> + * Meanwhile, these clock won't ever change at runtime.
>> + * For the above reasons, we can only use ro_ops for SYS related clocks.
>> + */
>> +static struct clk_regmap s4_sysclk_b_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 26,
>> +             .table = mux_table_sys_ab_clk_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sysclk_b_sel",
>> +             .ops = &clk_regmap_mux_ro_ops,
>> +             .parent_data = sys_ab_clk_parent_data,
>> +             .num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_b_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .shift = 16,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sysclk_b_div",
>> +             .ops = &clk_regmap_divider_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sysclk_b_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_b = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .bit_idx = 29,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sysclk_b",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sysclk_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 10,
>> +             .table = mux_table_sys_ab_clk_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sysclk_a_sel",
>> +             .ops = &clk_regmap_mux_ro_ops,
>> +             .parent_data = sys_ab_clk_parent_data,
>> +             .num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_a_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .shift = 0,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sysclk_a_div",
>> +             .ops = &clk_regmap_divider_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sysclk_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_a = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .bit_idx = 13,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sysclk_a",
>> +             .ops = &clk_regmap_gate_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sysclk_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sys_clk = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SYS_CLK_CTRL0,
>> +             .mask = 0x1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sys_clk",
>> +             .ops = &clk_regmap_mux_ro_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sysclk_a.hw,
>> +                     &s4_sysclk_b.hw
>> +             },
>> +             .num_parents = 2,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_clkin = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_CECA_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ceca_32k_clkin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_div = {
>> +     .data = &(struct meson_clk_dualdiv_data){
>> +             .n1 = {
>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = CLKCTRL_CECA_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = CLKCTRL_CECA_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = s4_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_ceca_32k_clkin.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_sel_pre = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_CECA_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_sel_pre",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_ceca_32k_div.hw,
>> +                     &s4_ceca_32k_clkin.hw
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_CECA_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 31,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_ceca_32k_sel_pre.hw,
>> +                     &s4_rtc_clk.hw
>> +             },
>> +             .num_parents = 2,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_clkout = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_CECA_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_clkout",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_ceca_32k_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_clkin = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_CECB_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "cecb_32k_clkin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_div = {
>> +     .data = &(struct meson_clk_dualdiv_data){
>> +             .n1 = {
>> +                     .reg_off = CLKCTRL_CECB_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = CLKCTRL_CECB_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = CLKCTRL_CECB_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = CLKCTRL_CECB_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = CLKCTRL_CECB_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = s4_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cecb_32k_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cecb_32k_clkin.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_sel_pre = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_CECB_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cecb_32k_sel_pre",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cecb_32k_div.hw,
>> +                     &s4_cecb_32k_clkin.hw
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_CECB_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 31,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cecb_32k_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cecb_32k_sel_pre.hw,
>> +                     &s4_rtc_clk.hw
>> +             },
>> +             .num_parents = 2,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_clkout = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_CECB_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cecb_32k_clkout",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cecb_32k_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_sc_parent_data[] = {
>> +     { .fw_name = "fclk_div4" },
>> +     { .fw_name = "fclk_div3" },
>> +     { .fw_name = "fclk_div5" },
>> +     { .fw_name = "xtal", }
>> +};
>> +
>> +static struct clk_regmap s4_sc_clk_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SC_CLK_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sc_clk_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_sc_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_sc_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sc_clk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sc_clk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sc_clk_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sc_clk_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SC_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sc_clk_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sc_clk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_12_24M_clk_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>> +             .bit_idx = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "12_24m_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", }
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_12M_clk_div = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "12M",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_12_24M_clk_gate.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_12_24M_clk = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "12_24m",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_12_24M_clk_gate.hw,
>> +                     &s4_12M_clk_div.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* Video Clocks */
>> +static struct clk_regmap s4_vid_pll_div = {
>> +     .data = &(struct meson_vid_pll_div_data){
>> +             .val = {
>> +                     .reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>> +                     .shift   = 0,
>> +                     .width   = 15,
>> +             },
>> +             .sel = {
>> +                     .reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>> +                     .shift   = 16,
>> +                     .width   = 2,
>> +             },
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vid_pll_div",
>> +             /*
>> +              * TODO meson_vid_pll_div_ro_ops to meson_vid_pll_div_ops
>> +              */
>> +             .ops = &meson_vid_pll_div_ro_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "hdmi_pll", }
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vid_pll_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VID_PLL_CLK_DIV,
>> +             .mask = 0x1,
>> +             .shift = 18,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vid_pll_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .hw = &s4_vid_pll_div.hw },
>> +                     { .fw_name = "hdmi_pll", }
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vid_pll = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_PLL_CLK_DIV,
>> +             .bit_idx = 19,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vid_pll",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vid_pll_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_vclk_parent_data[] = {
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "gp0_pll", },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "mpll1", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 16,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vclk_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vclk_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 16,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vclk_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vclk_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_input = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_DIV,
>> +             .bit_idx = 16,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_input",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk_sel.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_input = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_DIV,
>> +             .bit_idx = 16,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_input",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2_sel.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VID_CLK_DIV,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk_input.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VIID_CLK_DIV,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk2_input.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 19,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 19,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_div1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div2_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_div2_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div4_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 2,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_div4_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div6_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 3,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_div6_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div12_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL,
>> +             .bit_idx = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk_div12_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_div1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div2_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_div2_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div4_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 2,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_div4_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div6_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 3,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_div6_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div12_en = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VIID_CLK_CTRL,
>> +             .bit_idx = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vclk2_div12_en",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div2 = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_div2",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk_div2_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div4 = {
>> +     .mult = 1,
>> +     .div = 4,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_div4",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk_div4_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div6 = {
>> +     .mult = 1,
>> +     .div = 6,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_div6",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk_div6_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div12 = {
>> +     .mult = 1,
>> +     .div = 12,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk_div12",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk_div12_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div2 = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_div2",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk2_div2_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div4 = {
>> +     .mult = 1,
>> +     .div = 4,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_div4",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk2_div4_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div6 = {
>> +     .mult = 1,
>> +     .div = 6,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_div6",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk2_div6_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div12 = {
>> +     .mult = 1,
>> +     .div = 12,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vclk2_div12",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vclk2_div12_en.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* The 5,6,7 indexes corresponds to no real clock, so there are not used. */
>> +static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>> +static const struct clk_hw *s4_cts_parent_hws[] = {
>> +     &s4_vclk_div1.hw,
>> +     &s4_vclk_div2.hw,
>> +     &s4_vclk_div4.hw,
>> +     &s4_vclk_div6.hw,
>> +     &s4_vclk_div12.hw,
>> +     &s4_vclk2_div1.hw,
>> +     &s4_vclk2_div2.hw,
>> +     &s4_vclk2_div4.hw,
>> +     &s4_vclk2_div6.hw,
>> +     &s4_vclk2_div12.hw
>> +};
>> +
>> +static struct clk_regmap s4_cts_enci_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VID_CLK_DIV,
>> +             .mask = 0xf,
>> +             .shift = 28,
>> +             .table = mux_table_cts_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cts_enci_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_cts_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_cts_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cts_encp_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VID_CLK_DIV,
>> +             .mask = 0xf,
>> +             .shift = 20,
>> +             .table = mux_table_cts_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cts_encp_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_cts_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_cts_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cts_vdac_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VIID_CLK_DIV,
>> +             .mask = 0xf,
>> +             .shift = 28,
>> +             .table = mux_table_cts_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "cts_vdac_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_cts_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_cts_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* The 5,6,7 indexes corresponds to no real clock, so there are not used. */
>> +static u32 mux_table_hdmi_tx_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>> +static const struct clk_hw *s4_cts_hdmi_tx_parent_hws[] = {
>> +     &s4_vclk_div1.hw,
>> +     &s4_vclk_div2.hw,
>> +     &s4_vclk_div4.hw,
>> +     &s4_vclk_div6.hw,
>> +     &s4_vclk_div12.hw,
>> +     &s4_vclk2_div1.hw,
>> +     &s4_vclk2_div2.hw,
>> +     &s4_vclk2_div4.hw,
>> +     &s4_vclk2_div6.hw,
>> +     &s4_vclk2_div12.hw
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_tx_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_HDMI_CLK_CTRL,
>> +             .mask = 0xf,
>> +             .shift = 16,
>> +             .table = mux_table_hdmi_tx_sel,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdmi_tx_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_cts_hdmi_tx_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_cts_hdmi_tx_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cts_enci = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL2,
>> +             .bit_idx = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "cts_enci",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cts_enci_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cts_encp = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL2,
>> +             .bit_idx = 2,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "cts_encp",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cts_encp_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_cts_vdac = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL2,
>> +             .bit_idx = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "cts_vdac",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_cts_vdac_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_tx = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VID_CLK_CTRL2,
>> +             .bit_idx = 5,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdmi_tx",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdmi_tx_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* HDMI Clocks */
>> +static const struct clk_parent_data s4_hdmi_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", }
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_HDMI_CLK_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdmi_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_hdmi_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_hdmi_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_HDMI_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdmi_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_hdmi_sel.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdmi = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_HDMI_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdmi",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_hdmi_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ts_clk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_TS_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ts_clk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal",
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ts_clk_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_TS_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ts_clk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_ts_clk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/*
>> + * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
>> + * muxed by a glitch-free switch. The CCF can manage this glitch-free
>> + * mux because it does top-to-bottom updates the each clock tree and
>> + * switches to the "inactive" one when CLK_SET_RATE_GATE is set.
>> + */
>> +static const struct clk_parent_data s4_mali_0_1_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "gp0_pll", },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "fclk_div2p5", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", }
>> +};
>> +
>> +static struct clk_regmap s4_mali_0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_mali_0_1_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_mali_0_1_parent_data),
>> +             /*
>> +              * Don't request the parent to change the rate because
>> +              * all GPU frequencies can be derived from the fclk_*
>> +              * clocks and one special GP0_PLL setting. This is
>> +              * important because we need the MPLL clocks for audio.
> 
> The last part of this comment does not make a lot of sense to me.
> MPLLs are not among the possible parent of this clock, did you mean HiFi ?

Sorry. It's HIFI PLL, and you're right.

Do you suggest that I delete it or change it to HIFI PLL? I will change 
it in the next edition as you suggested

> 
>> +              */
>> +             .flags = 0,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mali_0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mali_0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mali_0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mali_0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mali_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_mali_0_1_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_mali_0_1_parent_data),
>> +             .flags = 0,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mali_1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mali_1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_mali_1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_mali_1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_hw *s4_mali_parent_hws[] = {
>> +     &s4_mali_0.hw,
>> +     &s4_mali_1.hw
>> +};
>> +
>> +static struct clk_regmap s4_mali_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_MALI_CLK_CTRL,
>> +             .mask = 1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mali",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_mali_parent_hws,
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* VDEC clocks */
>> +static const struct clk_parent_data s4_dec_parent_data[] = {
>> +     { .fw_name = "fclk_div2p5", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "gp0_pll", },
>> +     { .fw_name = "xtal", }
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p0_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdec_p0_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_dec_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_dec_parent_data),
> 
> Nitpick: .flags = 0; to clearly show that you stopping rate propagation
> here too (like you did on s4_mali_0_sel - no need to copy the comment though)

I will change it in the next edition as you suggested.

> 
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VDEC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +             .flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdec_p0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdec_p0_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VDEC_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vdec_p0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdec_p0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p1_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdec_p1_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_dec_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_dec_parent_data),
> 
> Same here and also where applicable in the rest of the driver.

OKay.

> 
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +             .flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdec_p1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdec_p1_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vdec_p1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdec_p1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_hw *s4_vdec_mux_parent_hws[] = {
>> +     &s4_vdec_p0.hw,
>> +     &s4_vdec_p1.hw
>> +};
>> +
>> +static struct clk_regmap s4_vdec_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 15,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdec_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_vdec_mux_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_vdec_mux_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p0_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC2_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hevcf_p0_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_dec_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_dec_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VDEC2_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +             .flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hevcf_p0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hevcf_p0_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VDEC2_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hevcf_p0_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hevcf_p0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p1_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hevcf_p1_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_dec_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_dec_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +             .flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hevcf_p1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hevcf_p1_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hevcf_p1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hevcf_p1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_hw *s4_hevcf_mux_parent_hws[] = {
>> +     &s4_hevcf_p0.hw,
>> +     &s4_hevcf_p1.hw
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 15,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hevcf",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_hevcf_mux_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_hevcf_mux_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* VPU Clock */
>> +static const struct clk_parent_data s4_vpu_parent_data[] = {
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "mpll1", },
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "gp0_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vpu_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vpu_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_sel.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vpu_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vpu_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_sel.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLK_CTRL,
>> +             .mask = 1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_0.hw,
>> +                     &s4_vpu_1.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data vpu_clkb_tmp_parent_data[] = {
>> +     { .hw = &s4_vpu.hw },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", }
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_tmp_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLKB_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 20,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkb_tmp_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vpu_clkb_tmp_parent_data,
>> +             .num_parents = ARRAY_SIZE(vpu_clkb_tmp_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_tmp_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLKB_CTRL,
>> +             .shift = 16,
>> +             .width = 4,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkb_tmp_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkb_tmp_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_tmp = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLKB_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_clkb_tmp",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkb_tmp_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLKB_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkb_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkb_tmp.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLKB_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_clkb",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkb_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_vpu_clkc_parent_data[] = {
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "mpll1", },
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "mpll2", },
>> +     { .fw_name = "gp0_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p0_mux  = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkc_p0_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vpu_clkc_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkc_p0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkc_p0_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_clkc_p0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkc_p0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p1_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkc_p1_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vpu_clkc_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkc_p1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkc_p1_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vpu_clkc_p1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vpu_clkc_p1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_hw *s4_vpu_mux_parent_hws[] = {
>> +     &s4_vpu_clkc_p0.hw,
>> +     &s4_vpu_clkc_p1.hw
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VPU_CLKC_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vpu_clkc_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = s4_vpu_mux_parent_hws,
>> +             .num_parents = ARRAY_SIZE(s4_vpu_mux_parent_hws),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* VAPB Clock */
>> +static const struct clk_parent_data s4_vapb_parent_data[] = {
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "mpll1", },
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "mpll2", },
>> +     { .fw_name = "fclk_div2p5", },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vapb_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vapb_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vapb_0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vapb_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vapb_0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vapb_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vapb_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vapb_1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vapb_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vapb_1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vapb = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .mask = 1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vapb_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vapb_0.hw,
>> +                     &s4_vapb_1.hw
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_ge2d_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VAPBCLK_CTRL,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ge2d_clk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &s4_vapb.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_esmclk_parent_data[] = {
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_esmclk_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdcp22_esmclk_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_esmclk_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_esmclk_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_esmclk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdcp22_esmclk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdcp22_esmclk_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_esmclk_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdcp22_esmclk_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdcp22_esmclk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_skpclk_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_skpclk_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdcp22_skpclk_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_skpclk_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_skpclk_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_skpclk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hdcp22_skpclk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdcp22_skpclk_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_skpclk_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_HDCP22_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "hdcp22_skpclk_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_hdcp22_skpclk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_vdin_parent_data[]  = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .hw = &s4_vid_pll.hw }
>> +};
>> +
>> +static struct clk_regmap s4_vdin_meas_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdin_meas_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_vdin_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_vdin_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdin_meas_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vdin_meas_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdin_meas_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_vdin_meas_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "vdin_meas_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_vdin_meas_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* EMMC/NAND clock */
>> +static const struct clk_parent_data s4_sd_emmc_clk0_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fclk_div2", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "fclk_div2p5", },
>> +     { .fw_name = "mpll2", },
>> +     { .fw_name = "mpll3", },
>> +     { .fw_name = "gp0_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_c_clk0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_NAND_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c_clk0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_sd_emmc_clk0_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_c_clk0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_NAND_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c_clk0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_c_clk0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_c_clk0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_NAND_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_c_clk0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_c_clk0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_a_clk0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a_clk0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_sd_emmc_clk0_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_a_clk0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a_clk0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_a_clk0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_a_clk0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_a_clk0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_a_clk0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_b_clk0_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_b_clk0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_sd_emmc_clk0_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_b_clk0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_b_clk0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_b_clk0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_b_clk0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .bit_idx = 23,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "sd_emmc_b_clk0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_sd_emmc_b_clk0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* SPICC Clock */
>> +static const struct clk_parent_data s4_spicc_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .hw = &s4_sys_clk.hw },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div2", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +};
>> +
>> +static struct clk_regmap s4_spicc0_mux = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc0_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_spicc_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_spicc_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_spicc0_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_spicc0_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_spicc0_gate = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .bit_idx = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "spicc0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_spicc0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* PWM Clock */
>> +static const struct clk_parent_data s4_pwm_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_a_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_a_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_a_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_a_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_a_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_a_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_b_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_b_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_b_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_b_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_b_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_b_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_c_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_c_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_c_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_c_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_c_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_c_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_c_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_c_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_d_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_d_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_d_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_d_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_d_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_d_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_d_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_d_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_e_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_e_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_e_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_e_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_e_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_e_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_e_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_e_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_f_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_f_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_f_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_f_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_f_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_f_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_f_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_f_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_g_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_g_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_g_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_g_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_g_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_g_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_g_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_g_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_h_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_h_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_h_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_h_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_h_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_h_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_h_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_h_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_i_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_i_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_i_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_i_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_i_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_i_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_i_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_i_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_j_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_j_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_pwm_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_j_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .shift = 16,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_j_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_h_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_j_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "pwm_j_gate",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_pwm_j_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_saradc_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_SAR_CLK_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "saradc_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", },
>> +                     { .hw = &s4_sys_clk.hw },
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_saradc_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_SAR_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "saradc_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_saradc_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_saradc_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_SAR_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "saradc_clk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_saradc_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/*
>> + * gen clk is designed for debug/monitor some internal clock quality. Some of the
>> + * corresponding clock sources are not described in the clock tree and internal clock
>> + * for debug, so they are skipped.
>> + */
>> +static u32 s4_gen_clk_mux_table[] = { 0, 4, 5, 7, 19, 21, 22,
>> +                                   23, 24, 25, 26, 27, 28 };
>> +static const struct clk_parent_data s4_gen_clk_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .hw = &s4_vid_pll.hw },
>> +     { .fw_name = "gp0_pll", },
>> +     { .fw_name = "hifi_pll", },
>> +     { .fw_name = "fclk_div2", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "mpll0", },
>> +     { .fw_name = "mpll1", },
>> +     { .fw_name = "mpll2", },
>> +     { .fw_name = "mpll3", },
>> +};
>> +
>> +static struct clk_regmap s4_gen_clk_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>> +             .mask = 0x1f,
>> +             .shift = 12,
>> +             .table = s4_gen_clk_mux_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "gen_clk_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_gen_clk_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_gen_clk_parent_data),
>> +             /*
>> +              *  Because the GEN clock can be connected to an external pad
>> +              *  and may be set up directly from the device tree. Don't
>> +              *  really want to automatically reparent.
>> +              */
>> +             .flags = CLK_SET_RATE_NO_REPARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_gen_clk_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "gen_clk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_gen_clk_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_gen_clk = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>> +             .bit_idx = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gen_clk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_gen_clk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data s4_adc_extclk_in_parent_data[]  = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fclk_div4", },
>> +     { .fw_name = "fclk_div3", },
>> +     { .fw_name = "fclk_div5", },
>> +     { .fw_name = "fclk_div7", },
>> +     { .fw_name = "mpll2", },
>> +     { .fw_name = "gp0_pll", },
>> +     { .fw_name = "hifi_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_adc_extclk_in_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "adc_extclk_in_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = s4_adc_extclk_in_parent_data,
>> +             .num_parents = ARRAY_SIZE(s4_adc_extclk_in_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_adc_extclk_in_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "adc_extclk_in_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_adc_extclk_in_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_adc_extclk_in_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "adc_extclk_in",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_adc_extclk_in_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_demod_core_clk_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "demod_core_clk_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", },
>> +                     { .fw_name = "fclk_div7", },
>> +                     { .fw_name = "fclk_div4", },
>> +                     { .hw = &s4_adc_extclk_in_gate.hw }
>> +             },
>> +             .num_parents = 4,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_demod_core_clk_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "demod_core_clk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_demod_core_clk_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap s4_demod_core_clk_gate = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "demod_core_clk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &s4_demod_core_clk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +#define MESON_GATE(_name, _reg, _bit) \
>> +     MESON_PCLK(_name, _reg, _bit, &s4_sys_clk.hw)
>> +
>> +static MESON_GATE(s4_ddr,            CLKCTRL_SYS_CLK_EN0_REG0, 0);
>> +static MESON_GATE(s4_dos,            CLKCTRL_SYS_CLK_EN0_REG0, 1);
>> +static MESON_GATE(s4_ethphy,         CLKCTRL_SYS_CLK_EN0_REG0, 4);
>> +static MESON_GATE(s4_mali,           CLKCTRL_SYS_CLK_EN0_REG0, 6);
>> +static MESON_GATE(s4_aocpu,          CLKCTRL_SYS_CLK_EN0_REG0, 13);
>> +static MESON_GATE(s4_aucpu,          CLKCTRL_SYS_CLK_EN0_REG0, 14);
>> +static MESON_GATE(s4_cec,            CLKCTRL_SYS_CLK_EN0_REG0, 16);
>> +static MESON_GATE(s4_sdemmca,                CLKCTRL_SYS_CLK_EN0_REG0, 24);
>> +static MESON_GATE(s4_sdemmcb,                CLKCTRL_SYS_CLK_EN0_REG0, 25);
>> +static MESON_GATE(s4_nand,           CLKCTRL_SYS_CLK_EN0_REG0, 26);
>> +static MESON_GATE(s4_smartcard,              CLKCTRL_SYS_CLK_EN0_REG0, 27);
>> +static MESON_GATE(s4_acodec,         CLKCTRL_SYS_CLK_EN0_REG0, 28);
>> +static MESON_GATE(s4_spifc,          CLKCTRL_SYS_CLK_EN0_REG0, 29);
>> +static MESON_GATE(s4_msr_clk,                CLKCTRL_SYS_CLK_EN0_REG0, 30);
>> +static MESON_GATE(s4_ir_ctrl,                CLKCTRL_SYS_CLK_EN0_REG0, 31);
>> +static MESON_GATE(s4_audio,          CLKCTRL_SYS_CLK_EN0_REG1, 0);
>> +static MESON_GATE(s4_eth,            CLKCTRL_SYS_CLK_EN0_REG1, 3);
>> +static MESON_GATE(s4_uart_a,         CLKCTRL_SYS_CLK_EN0_REG1, 5);
>> +static MESON_GATE(s4_uart_b,         CLKCTRL_SYS_CLK_EN0_REG1, 6);
>> +static MESON_GATE(s4_uart_c,         CLKCTRL_SYS_CLK_EN0_REG1, 7);
>> +static MESON_GATE(s4_uart_d,         CLKCTRL_SYS_CLK_EN0_REG1, 8);
>> +static MESON_GATE(s4_uart_e,         CLKCTRL_SYS_CLK_EN0_REG1, 9);
>> +static MESON_GATE(s4_aififo,         CLKCTRL_SYS_CLK_EN0_REG1, 11);
>> +static MESON_GATE(s4_ts_ddr,         CLKCTRL_SYS_CLK_EN0_REG1, 15);
>> +static MESON_GATE(s4_ts_pll,         CLKCTRL_SYS_CLK_EN0_REG1, 16);
>> +static MESON_GATE(s4_g2d,            CLKCTRL_SYS_CLK_EN0_REG1, 20);
>> +static MESON_GATE(s4_spicc0,         CLKCTRL_SYS_CLK_EN0_REG1, 21);
>> +static MESON_GATE(s4_usb,            CLKCTRL_SYS_CLK_EN0_REG1, 26);
>> +static MESON_GATE(s4_i2c_m_a,                CLKCTRL_SYS_CLK_EN0_REG1, 30);
>> +static MESON_GATE(s4_i2c_m_b,                CLKCTRL_SYS_CLK_EN0_REG1, 31);
>> +static MESON_GATE(s4_i2c_m_c,                CLKCTRL_SYS_CLK_EN0_REG2, 0);
>> +static MESON_GATE(s4_i2c_m_d,                CLKCTRL_SYS_CLK_EN0_REG2, 1);
>> +static MESON_GATE(s4_i2c_m_e,                CLKCTRL_SYS_CLK_EN0_REG2, 2);
>> +static MESON_GATE(s4_hdmitx_apb,     CLKCTRL_SYS_CLK_EN0_REG2, 4);
>> +static MESON_GATE(s4_i2c_s_a,                CLKCTRL_SYS_CLK_EN0_REG2, 5);
>> +static MESON_GATE(s4_usb1_to_ddr,    CLKCTRL_SYS_CLK_EN0_REG2, 8);
>> +static MESON_GATE(s4_hdcp22,         CLKCTRL_SYS_CLK_EN0_REG2, 10);
>> +static MESON_GATE(s4_mmc_apb,                CLKCTRL_SYS_CLK_EN0_REG2, 11);
>> +static MESON_GATE(s4_rsa,            CLKCTRL_SYS_CLK_EN0_REG2, 18);
>> +static MESON_GATE(s4_cpu_debug,              CLKCTRL_SYS_CLK_EN0_REG2, 19);
>> +static MESON_GATE(s4_vpu_intr,               CLKCTRL_SYS_CLK_EN0_REG2, 25);
>> +static MESON_GATE(s4_demod,          CLKCTRL_SYS_CLK_EN0_REG2, 27);
>> +static MESON_GATE(s4_sar_adc,                CLKCTRL_SYS_CLK_EN0_REG2, 28);
>> +static MESON_GATE(s4_gic,            CLKCTRL_SYS_CLK_EN0_REG2, 30);
>> +static MESON_GATE(s4_pwm_ab,         CLKCTRL_SYS_CLK_EN0_REG3, 7);
>> +static MESON_GATE(s4_pwm_cd,         CLKCTRL_SYS_CLK_EN0_REG3, 8);
>> +static MESON_GATE(s4_pwm_ef,         CLKCTRL_SYS_CLK_EN0_REG3, 9);
>> +static MESON_GATE(s4_pwm_gh,         CLKCTRL_SYS_CLK_EN0_REG3, 10);
>> +static MESON_GATE(s4_pwm_ij,         CLKCTRL_SYS_CLK_EN0_REG3, 11);
>> +
>> +/* Array of all clocks provided by this provider */
>> +static struct clk_hw *s4_periphs_hw_clks[] = {
>> +     [CLKID_RTC_32K_CLKIN]           = &s4_rtc_32k_by_oscin_clkin.hw,
>> +     [CLKID_RTC_32K_DIV]             = &s4_rtc_32k_by_oscin_div.hw,
>> +     [CLKID_RTC_32K_SEL]             = &s4_rtc_32k_by_oscin_sel.hw,
>> +     [CLKID_RTC_32K_XATL]            = &s4_rtc_32k_by_oscin.hw,
>> +     [CLKID_RTC]                     = &s4_rtc_clk.hw,
>> +     [CLKID_SYS_CLK_B_SEL]           = &s4_sysclk_b_sel.hw,
>> +     [CLKID_SYS_CLK_B_DIV]           = &s4_sysclk_b_div.hw,
>> +     [CLKID_SYS_CLK_B]               = &s4_sysclk_b.hw,
>> +     [CLKID_SYS_CLK_A_SEL]           = &s4_sysclk_a_sel.hw,
>> +     [CLKID_SYS_CLK_A_DIV]           = &s4_sysclk_a_div.hw,
>> +     [CLKID_SYS_CLK_A]               = &s4_sysclk_a.hw,
>> +     [CLKID_SYS]                     = &s4_sys_clk.hw,
>> +     [CLKID_CECA_32K_CLKIN]          = &s4_ceca_32k_clkin.hw,
>> +     [CLKID_CECA_32K_DIV]            = &s4_ceca_32k_div.hw,
>> +     [CLKID_CECA_32K_SEL_PRE]        = &s4_ceca_32k_sel_pre.hw,
>> +     [CLKID_CECA_32K_SEL]            = &s4_ceca_32k_sel.hw,
>> +     [CLKID_CECA_32K_CLKOUT]         = &s4_ceca_32k_clkout.hw,
>> +     [CLKID_CECB_32K_CLKIN]          = &s4_cecb_32k_clkin.hw,
>> +     [CLKID_CECB_32K_DIV]            = &s4_cecb_32k_div.hw,
>> +     [CLKID_CECB_32K_SEL_PRE]        = &s4_cecb_32k_sel_pre.hw,
>> +     [CLKID_CECB_32K_SEL]            = &s4_cecb_32k_sel.hw,
>> +     [CLKID_CECB_32K_CLKOUT]         = &s4_cecb_32k_clkout.hw,
>> +     [CLKID_SC_CLK_SEL]              = &s4_sc_clk_mux.hw,
>> +     [CLKID_SC_CLK_DIV]              = &s4_sc_clk_div.hw,
>> +     [CLKID_SC]                      = &s4_sc_clk_gate.hw,
>> +     [CLKID_12_24M]                  = &s4_12_24M_clk_gate.hw,
>> +     [CLKID_12M_CLK_DIV]             = &s4_12M_clk_div.hw,
>> +     [CLKID_12_24M_CLK_SEL]          = &s4_12_24M_clk.hw,
>> +     [CLKID_VID_PLL_DIV]             = &s4_vid_pll_div.hw,
>> +     [CLKID_VID_PLL_SEL]             = &s4_vid_pll_sel.hw,
>> +     [CLKID_VID_PLL]                 = &s4_vid_pll.hw,
>> +     [CLKID_VCLK_SEL]                = &s4_vclk_sel.hw,
>> +     [CLKID_VCLK2_SEL]               = &s4_vclk2_sel.hw,
>> +     [CLKID_VCLK_INPUT]              = &s4_vclk_input.hw,
>> +     [CLKID_VCLK2_INPUT]             = &s4_vclk2_input.hw,
>> +     [CLKID_VCLK_DIV]                = &s4_vclk_div.hw,
>> +     [CLKID_VCLK2_DIV]               = &s4_vclk2_div.hw,
>> +     [CLKID_VCLK]                    = &s4_vclk.hw,
>> +     [CLKID_VCLK2]                   = &s4_vclk2.hw,
>> +     [CLKID_VCLK_DIV1]               = &s4_vclk_div1.hw,
>> +     [CLKID_VCLK_DIV2_EN]            = &s4_vclk_div2_en.hw,
>> +     [CLKID_VCLK_DIV4_EN]            = &s4_vclk_div4_en.hw,
>> +     [CLKID_VCLK_DIV6_EN]            = &s4_vclk_div6_en.hw,
>> +     [CLKID_VCLK_DIV12_EN]           = &s4_vclk_div12_en.hw,
>> +     [CLKID_VCLK2_DIV1]              = &s4_vclk2_div1.hw,
>> +     [CLKID_VCLK2_DIV2_EN]           = &s4_vclk2_div2_en.hw,
>> +     [CLKID_VCLK2_DIV4_EN]           = &s4_vclk2_div4_en.hw,
>> +     [CLKID_VCLK2_DIV6_EN]           = &s4_vclk2_div6_en.hw,
>> +     [CLKID_VCLK2_DIV12_EN]          = &s4_vclk2_div12_en.hw,
>> +     [CLKID_VCLK_DIV2]               = &s4_vclk_div2.hw,
>> +     [CLKID_VCLK_DIV4]               = &s4_vclk_div4.hw,
>> +     [CLKID_VCLK_DIV6]               = &s4_vclk_div6.hw,
>> +     [CLKID_VCLK_DIV12]              = &s4_vclk_div12.hw,
>> +     [CLKID_VCLK2_DIV2]              = &s4_vclk2_div2.hw,
>> +     [CLKID_VCLK2_DIV4]              = &s4_vclk2_div4.hw,
>> +     [CLKID_VCLK2_DIV6]              = &s4_vclk2_div6.hw,
>> +     [CLKID_VCLK2_DIV12]             = &s4_vclk2_div12.hw,
>> +     [CLKID_CTS_ENCI_SEL]            = &s4_cts_enci_sel.hw,
>> +     [CLKID_CTS_ENCP_SEL]            = &s4_cts_encp_sel.hw,
>> +     [CLKID_CTS_VDAC_SEL]            = &s4_cts_vdac_sel.hw,
>> +     [CLKID_HDMI_TX_SEL]             = &s4_hdmi_tx_sel.hw,
>> +     [CLKID_CTS_ENCI]                = &s4_cts_enci.hw,
>> +     [CLKID_CTS_ENCP]                = &s4_cts_encp.hw,
>> +     [CLKID_CTS_VDAC]                = &s4_cts_vdac.hw,
>> +     [CLKID_HDMI_TX]                 = &s4_hdmi_tx.hw,
>> +     [CLKID_HDMI_SEL]                = &s4_hdmi_sel.hw,
>> +     [CLKID_HDMI_DIV]                = &s4_hdmi_div.hw,
>> +     [CLKID_HDMI]                    = &s4_hdmi.hw,
>> +     [CLKID_TS_CLK_DIV]              = &s4_ts_clk_div.hw,
>> +     [CLKID_TS]                      = &s4_ts_clk_gate.hw,
>> +     [CLKID_MALI_0_SEL]              = &s4_mali_0_sel.hw,
>> +     [CLKID_MALI_0_DIV]              = &s4_mali_0_div.hw,
>> +     [CLKID_MALI_0]                  = &s4_mali_0.hw,
>> +     [CLKID_MALI_1_SEL]              = &s4_mali_1_sel.hw,
>> +     [CLKID_MALI_1_DIV]              = &s4_mali_1_div.hw,
>> +     [CLKID_MALI_1]                  = &s4_mali_1.hw,
>> +     [CLKID_MALI_SEL]                = &s4_mali_mux.hw,
>> +     [CLKID_VDEC_P0_SEL]             = &s4_vdec_p0_mux.hw,
>> +     [CLKID_VDEC_P0_DIV]             = &s4_vdec_p0_div.hw,
>> +     [CLKID_VDEC_P0]                 = &s4_vdec_p0.hw,
>> +     [CLKID_VDEC_P1_SEL]             = &s4_vdec_p1_mux.hw,
>> +     [CLKID_VDEC_P1_DIV]             = &s4_vdec_p1_div.hw,
>> +     [CLKID_VDEC_P1]                 = &s4_vdec_p1.hw,
>> +     [CLKID_VDEC_SEL]                = &s4_vdec_mux.hw,
>> +     [CLKID_HEVCF_P0_SEL]            = &s4_hevcf_p0_mux.hw,
>> +     [CLKID_HEVCF_P0_DIV]            = &s4_hevcf_p0_div.hw,
>> +     [CLKID_HEVCF_P0]                = &s4_hevcf_p0.hw,
>> +     [CLKID_HEVCF_P1_SEL]            = &s4_hevcf_p1_mux.hw,
>> +     [CLKID_HEVCF_P1_DIV]            = &s4_hevcf_p1_div.hw,
>> +     [CLKID_HEVCF_P1]                = &s4_hevcf_p1.hw,
>> +     [CLKID_HEVCF_SEL]               = &s4_hevcf_mux.hw,
>> +     [CLKID_VPU_0_SEL]               = &s4_vpu_0_sel.hw,
>> +     [CLKID_VPU_0_DIV]               = &s4_vpu_0_div.hw,
>> +     [CLKID_VPU_0]                   = &s4_vpu_0.hw,
>> +     [CLKID_VPU_1_SEL]               = &s4_vpu_1_sel.hw,
>> +     [CLKID_VPU_1_DIV]               = &s4_vpu_1_div.hw,
>> +     [CLKID_VPU_1]                   = &s4_vpu_1.hw,
>> +     [CLKID_VPU]                     = &s4_vpu.hw,
>> +     [CLKID_VPU_CLKB_TMP_SEL]        = &s4_vpu_clkb_tmp_mux.hw,
>> +     [CLKID_VPU_CLKB_TMP_DIV]        = &s4_vpu_clkb_tmp_div.hw,
>> +     [CLKID_VPU_CLKB_TMP]            = &s4_vpu_clkb_tmp.hw,
>> +     [CLKID_VPU_CLKB_DIV]            = &s4_vpu_clkb_div.hw,
>> +     [CLKID_VPU_CLKB]                = &s4_vpu_clkb.hw,
>> +     [CLKID_VPU_CLKC_P0_SEL]         = &s4_vpu_clkc_p0_mux.hw,
>> +     [CLKID_VPU_CLKC_P0_DIV]         = &s4_vpu_clkc_p0_div.hw,
>> +     [CLKID_VPU_CLKC_P0]             = &s4_vpu_clkc_p0.hw,
>> +     [CLKID_VPU_CLKC_P1_SEL]         = &s4_vpu_clkc_p1_mux.hw,
>> +     [CLKID_VPU_CLKC_P1_DIV]         = &s4_vpu_clkc_p1_div.hw,
>> +     [CLKID_VPU_CLKC_P1]             = &s4_vpu_clkc_p1.hw,
>> +     [CLKID_VPU_CLKC_SEL]            = &s4_vpu_clkc_mux.hw,
>> +     [CLKID_VAPB_0_SEL]              = &s4_vapb_0_sel.hw,
>> +     [CLKID_VAPB_0_DIV]              = &s4_vapb_0_div.hw,
>> +     [CLKID_VAPB_0]                  = &s4_vapb_0.hw,
>> +     [CLKID_VAPB_1_SEL]              = &s4_vapb_1_sel.hw,
>> +     [CLKID_VAPB_1_DIV]              = &s4_vapb_1_div.hw,
>> +     [CLKID_VAPB_1]                  = &s4_vapb_1.hw,
>> +     [CLKID_VAPB]                    = &s4_vapb.hw,
>> +     [CLKID_GE2D]                    = &s4_ge2d_gate.hw,
>> +     [CLKID_VDIN_MEAS_SEL]           = &s4_vdin_meas_mux.hw,
>> +     [CLKID_VDIN_MEAS_DIV]           = &s4_vdin_meas_div.hw,
>> +     [CLKID_VDIN_MEAS]               = &s4_vdin_meas_gate.hw,
>> +     [CLKID_SD_EMMC_C_CLK_SEL]       = &s4_sd_emmc_c_clk0_sel.hw,
>> +     [CLKID_SD_EMMC_C_CLK_DIV]       = &s4_sd_emmc_c_clk0_div.hw,
>> +     [CLKID_SD_EMMC_C]               = &s4_sd_emmc_c_clk0.hw,
>> +     [CLKID_SD_EMMC_A_CLK_SEL]       = &s4_sd_emmc_a_clk0_sel.hw,
>> +     [CLKID_SD_EMMC_A_CLK_DIV]       = &s4_sd_emmc_a_clk0_div.hw,
>> +     [CLKID_SD_EMMC_A]               = &s4_sd_emmc_a_clk0.hw,
>> +     [CLKID_SD_EMMC_B_CLK_SEL]       = &s4_sd_emmc_b_clk0_sel.hw,
>> +     [CLKID_SD_EMMC_B_CLK_DIV]       = &s4_sd_emmc_b_clk0_div.hw,
>> +     [CLKID_SD_EMMC_B]               = &s4_sd_emmc_b_clk0.hw,
>> +     [CLKID_SPICC0_SEL]              = &s4_spicc0_mux.hw,
>> +     [CLKID_SPICC0_DIV]              = &s4_spicc0_div.hw,
>> +     [CLKID_SPICC0_EN]               = &s4_spicc0_gate.hw,
>> +     [CLKID_PWM_A_SEL]               = &s4_pwm_a_mux.hw,
>> +     [CLKID_PWM_A_DIV]               = &s4_pwm_a_div.hw,
>> +     [CLKID_PWM_A]                   = &s4_pwm_a_gate.hw,
>> +     [CLKID_PWM_B_SEL]               = &s4_pwm_b_mux.hw,
>> +     [CLKID_PWM_B_DIV]               = &s4_pwm_b_div.hw,
>> +     [CLKID_PWM_B]                   = &s4_pwm_b_gate.hw,
>> +     [CLKID_PWM_C_SEL]               = &s4_pwm_c_mux.hw,
>> +     [CLKID_PWM_C_DIV]               = &s4_pwm_c_div.hw,
>> +     [CLKID_PWM_C]                   = &s4_pwm_c_gate.hw,
>> +     [CLKID_PWM_D_SEL]               = &s4_pwm_d_mux.hw,
>> +     [CLKID_PWM_D_DIV]               = &s4_pwm_d_div.hw,
>> +     [CLKID_PWM_D]                   = &s4_pwm_d_gate.hw,
>> +     [CLKID_PWM_E_SEL]               = &s4_pwm_e_mux.hw,
>> +     [CLKID_PWM_E_DIV]               = &s4_pwm_e_div.hw,
>> +     [CLKID_PWM_E]                   = &s4_pwm_e_gate.hw,
>> +     [CLKID_PWM_F_SEL]               = &s4_pwm_f_mux.hw,
>> +     [CLKID_PWM_F_DIV]               = &s4_pwm_f_div.hw,
>> +     [CLKID_PWM_F]                   = &s4_pwm_f_gate.hw,
>> +     [CLKID_PWM_G_SEL]               = &s4_pwm_g_mux.hw,
>> +     [CLKID_PWM_G_DIV]               = &s4_pwm_g_div.hw,
>> +     [CLKID_PWM_G]                   = &s4_pwm_g_gate.hw,
>> +     [CLKID_PWM_H_SEL]               = &s4_pwm_h_mux.hw,
>> +     [CLKID_PWM_H_DIV]               = &s4_pwm_h_div.hw,
>> +     [CLKID_PWM_H]                   = &s4_pwm_h_gate.hw,
>> +     [CLKID_PWM_I_SEL]               = &s4_pwm_i_mux.hw,
>> +     [CLKID_PWM_I_DIV]               = &s4_pwm_i_div.hw,
>> +     [CLKID_PWM_I]                   = &s4_pwm_i_gate.hw,
>> +     [CLKID_PWM_J_SEL]               = &s4_pwm_j_mux.hw,
>> +     [CLKID_PWM_J_DIV]               = &s4_pwm_j_div.hw,
>> +     [CLKID_PWM_J]                   = &s4_pwm_j_gate.hw,
>> +     [CLKID_SARADC_SEL]              = &s4_saradc_mux.hw,
>> +     [CLKID_SARADC_DIV]              = &s4_saradc_div.hw,
>> +     [CLKID_SARADC]                  = &s4_saradc_gate.hw,
>> +     [CLKID_GEN_SEL]                 = &s4_gen_clk_sel.hw,
>> +     [CLKID_GEN_DIV]                 = &s4_gen_clk_div.hw,
>> +     [CLKID_GEN]                     = &s4_gen_clk.hw,
>> +     [CLKID_DDR]                     = &s4_ddr.hw,
>> +     [CLKID_DOS]                     = &s4_dos.hw,
>> +     [CLKID_ETHPHY]                  = &s4_ethphy.hw,
>> +     [CLKID_MALI]                    = &s4_mali.hw,
>> +     [CLKID_AOCPU]                   = &s4_aocpu.hw,
>> +     [CLKID_AUCPU]                   = &s4_aucpu.hw,
>> +     [CLKID_CEC]                     = &s4_cec.hw,
>> +     [CLKID_SDEMMC_A]                = &s4_sdemmca.hw,
>> +     [CLKID_SDEMMC_B]                = &s4_sdemmcb.hw,
>> +     [CLKID_NAND]                    = &s4_nand.hw,
>> +     [CLKID_SMARTCARD]               = &s4_smartcard.hw,
>> +     [CLKID_ACODEC]                  = &s4_acodec.hw,
>> +     [CLKID_SPIFC]                   = &s4_spifc.hw,
>> +     [CLKID_MSR]                     = &s4_msr_clk.hw,
>> +     [CLKID_IR_CTRL]                 = &s4_ir_ctrl.hw,
>> +     [CLKID_AUDIO]                   = &s4_audio.hw,
>> +     [CLKID_ETH]                     = &s4_eth.hw,
>> +     [CLKID_UART_A]                  = &s4_uart_a.hw,
>> +     [CLKID_UART_B]                  = &s4_uart_b.hw,
>> +     [CLKID_UART_C]                  = &s4_uart_c.hw,
>> +     [CLKID_UART_D]                  = &s4_uart_d.hw,
>> +     [CLKID_UART_E]                  = &s4_uart_e.hw,
>> +     [CLKID_AIFIFO]                  = &s4_aififo.hw,
>> +     [CLKID_TS_DDR]                  = &s4_ts_ddr.hw,
>> +     [CLKID_TS_PLL]                  = &s4_ts_pll.hw,
>> +     [CLKID_G2D]                     = &s4_g2d.hw,
>> +     [CLKID_SPICC0]                  = &s4_spicc0.hw,
>> +     [CLKID_USB]                     = &s4_usb.hw,
>> +     [CLKID_I2C_M_A]                 = &s4_i2c_m_a.hw,
>> +     [CLKID_I2C_M_B]                 = &s4_i2c_m_b.hw,
>> +     [CLKID_I2C_M_C]                 = &s4_i2c_m_c.hw,
>> +     [CLKID_I2C_M_D]                 = &s4_i2c_m_d.hw,
>> +     [CLKID_I2C_M_E]                 = &s4_i2c_m_e.hw,
>> +     [CLKID_HDMITX_APB]              = &s4_hdmitx_apb.hw,
>> +     [CLKID_I2C_S_A]                 = &s4_i2c_s_a.hw,
>> +     [CLKID_USB1_TO_DDR]             = &s4_usb1_to_ddr.hw,
>> +     [CLKID_HDCP22]                  = &s4_hdcp22.hw,
>> +     [CLKID_MMC_APB]                 = &s4_mmc_apb.hw,
>> +     [CLKID_RSA]                     = &s4_rsa.hw,
>> +     [CLKID_CPU_DEBUG]               = &s4_cpu_debug.hw,
>> +     [CLKID_VPU_INTR]                = &s4_vpu_intr.hw,
>> +     [CLKID_DEMOD]                   = &s4_demod.hw,
>> +     [CLKID_SAR_ADC]                 = &s4_sar_adc.hw,
>> +     [CLKID_GIC]                     = &s4_gic.hw,
>> +     [CLKID_PWM_AB]                  = &s4_pwm_ab.hw,
>> +     [CLKID_PWM_CD]                  = &s4_pwm_cd.hw,
>> +     [CLKID_PWM_EF]                  = &s4_pwm_ef.hw,
>> +     [CLKID_PWM_GH]                  = &s4_pwm_gh.hw,
>> +     [CLKID_PWM_IJ]                  = &s4_pwm_ij.hw,
>> +     [CLKID_HDCP22_ESMCLK_SEL]       = &s4_hdcp22_esmclk_mux.hw,
>> +     [CLKID_HDCP22_ESMCLK_DIV]       = &s4_hdcp22_esmclk_div.hw,
>> +     [CLKID_HDCP22_ESMCLK]           = &s4_hdcp22_esmclk_gate.hw,
>> +     [CLKID_HDCP22_SKPCLK_SEL]       = &s4_hdcp22_skpclk_mux.hw,
>> +     [CLKID_HDCP22_SKPCLK_DIV]       = &s4_hdcp22_skpclk_div.hw,
>> +     [CLKID_HDCP22_SKPCLK]           = &s4_hdcp22_skpclk_gate.hw,
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const s4_periphs_clk_regmaps[] = {
>> +     &s4_rtc_32k_by_oscin_clkin,
>> +     &s4_rtc_32k_by_oscin_div,
>> +     &s4_rtc_32k_by_oscin_sel,
>> +     &s4_rtc_32k_by_oscin,
>> +     &s4_rtc_clk,
>> +     &s4_sysclk_b_sel,
>> +     &s4_sysclk_b_div,
>> +     &s4_sysclk_b,
>> +     &s4_sysclk_a_sel,
>> +     &s4_sysclk_a_div,
>> +     &s4_sysclk_a,
>> +     &s4_sys_clk,
>> +     &s4_ceca_32k_clkin,
>> +     &s4_ceca_32k_div,
>> +     &s4_ceca_32k_sel_pre,
>> +     &s4_ceca_32k_sel,
>> +     &s4_ceca_32k_clkout,
>> +     &s4_cecb_32k_clkin,
>> +     &s4_cecb_32k_div,
>> +     &s4_cecb_32k_sel_pre,
>> +     &s4_cecb_32k_sel,
>> +     &s4_cecb_32k_clkout,
>> +     &s4_sc_clk_mux,
>> +     &s4_sc_clk_div,
>> +     &s4_sc_clk_gate,
>> +     &s4_12_24M_clk_gate,
>> +     &s4_12_24M_clk,
>> +     &s4_vid_pll_div,
>> +     &s4_vid_pll_sel,
>> +     &s4_vid_pll,
>> +     &s4_vclk_sel,
>> +     &s4_vclk2_sel,
>> +     &s4_vclk_input,
>> +     &s4_vclk2_input,
>> +     &s4_vclk_div,
>> +     &s4_vclk2_div,
>> +     &s4_vclk,
>> +     &s4_vclk2,
>> +     &s4_vclk_div1,
>> +     &s4_vclk_div2_en,
>> +     &s4_vclk_div4_en,
>> +     &s4_vclk_div6_en,
>> +     &s4_vclk_div12_en,
>> +     &s4_vclk2_div1,
>> +     &s4_vclk2_div2_en,
>> +     &s4_vclk2_div4_en,
>> +     &s4_vclk2_div6_en,
>> +     &s4_vclk2_div12_en,
>> +     &s4_cts_enci_sel,
>> +     &s4_cts_encp_sel,
>> +     &s4_cts_vdac_sel,
>> +     &s4_hdmi_tx_sel,
>> +     &s4_cts_enci,
>> +     &s4_cts_encp,
>> +     &s4_cts_vdac,
>> +     &s4_hdmi_tx,
>> +     &s4_hdmi_sel,
>> +     &s4_hdmi_div,
>> +     &s4_hdmi,
>> +     &s4_ts_clk_div,
>> +     &s4_ts_clk_gate,
>> +     &s4_mali_0_sel,
>> +     &s4_mali_0_div,
>> +     &s4_mali_0,
>> +     &s4_mali_1_sel,
>> +     &s4_mali_1_div,
>> +     &s4_mali_1,
>> +     &s4_mali_mux,
>> +     &s4_vdec_p0_mux,
>> +     &s4_vdec_p0_div,
>> +     &s4_vdec_p0,
>> +     &s4_vdec_p1_mux,
>> +     &s4_vdec_p1_div,
>> +     &s4_vdec_p1,
>> +     &s4_vdec_mux,
>> +     &s4_hevcf_p0_mux,
>> +     &s4_hevcf_p0_div,
>> +     &s4_hevcf_p0,
>> +     &s4_hevcf_p1_mux,
>> +     &s4_hevcf_p1_div,
>> +     &s4_hevcf_p1,
>> +     &s4_hevcf_mux,
>> +     &s4_vpu_0_sel,
>> +     &s4_vpu_0_div,
>> +     &s4_vpu_0,
>> +     &s4_vpu_1_sel,
>> +     &s4_vpu_1_div,
>> +     &s4_vpu_1,
>> +     &s4_vpu,
>> +     &s4_vpu_clkb_tmp_mux,
>> +     &s4_vpu_clkb_tmp_div,
>> +     &s4_vpu_clkb_tmp,
>> +     &s4_vpu_clkb_div,
>> +     &s4_vpu_clkb,
>> +     &s4_vpu_clkc_p0_mux,
>> +     &s4_vpu_clkc_p0_div,
>> +     &s4_vpu_clkc_p0,
>> +     &s4_vpu_clkc_p1_mux,
>> +     &s4_vpu_clkc_p1_div,
>> +     &s4_vpu_clkc_p1,
>> +     &s4_vpu_clkc_mux,
>> +     &s4_vapb_0_sel,
>> +     &s4_vapb_0_div,
>> +     &s4_vapb_0,
>> +     &s4_vapb_1_sel,
>> +     &s4_vapb_1_div,
>> +     &s4_vapb_1,
>> +     &s4_vapb,
>> +     &s4_ge2d_gate,
>> +     &s4_hdcp22_esmclk_mux,
>> +     &s4_hdcp22_esmclk_div,
>> +     &s4_hdcp22_esmclk_gate,
>> +     &s4_hdcp22_skpclk_mux,
>> +     &s4_hdcp22_skpclk_div,
>> +     &s4_hdcp22_skpclk_gate,
>> +     &s4_vdin_meas_mux,
>> +     &s4_vdin_meas_div,
>> +     &s4_vdin_meas_gate,
>> +     &s4_sd_emmc_c_clk0_sel,
>> +     &s4_sd_emmc_c_clk0_div,
>> +     &s4_sd_emmc_c_clk0,
>> +     &s4_sd_emmc_a_clk0_sel,
>> +     &s4_sd_emmc_a_clk0_div,
>> +     &s4_sd_emmc_a_clk0,
>> +     &s4_sd_emmc_b_clk0_sel,
>> +     &s4_sd_emmc_b_clk0_div,
>> +     &s4_sd_emmc_b_clk0,
>> +     &s4_spicc0_mux,
>> +     &s4_spicc0_div,
>> +     &s4_spicc0_gate,
>> +     &s4_pwm_a_mux,
>> +     &s4_pwm_a_div,
>> +     &s4_pwm_a_gate,
>> +     &s4_pwm_b_mux,
>> +     &s4_pwm_b_div,
>> +     &s4_pwm_b_gate,
>> +     &s4_pwm_c_mux,
>> +     &s4_pwm_c_div,
>> +     &s4_pwm_c_gate,
>> +     &s4_pwm_d_mux,
>> +     &s4_pwm_d_div,
>> +     &s4_pwm_d_gate,
>> +     &s4_pwm_e_mux,
>> +     &s4_pwm_e_div,
>> +     &s4_pwm_e_gate,
>> +     &s4_pwm_f_mux,
>> +     &s4_pwm_f_div,
>> +     &s4_pwm_f_gate,
>> +     &s4_pwm_g_mux,
>> +     &s4_pwm_g_div,
>> +     &s4_pwm_g_gate,
>> +     &s4_pwm_h_mux,
>> +     &s4_pwm_h_div,
>> +     &s4_pwm_h_gate,
>> +     &s4_pwm_i_mux,
>> +     &s4_pwm_i_div,
>> +     &s4_pwm_i_gate,
>> +     &s4_pwm_j_mux,
>> +     &s4_pwm_j_div,
>> +     &s4_pwm_j_gate,
>> +     &s4_saradc_mux,
>> +     &s4_saradc_div,
>> +     &s4_saradc_gate,
>> +     &s4_gen_clk_sel,
>> +     &s4_gen_clk_div,
>> +     &s4_gen_clk,
>> +     &s4_ddr,
>> +     &s4_dos,
>> +     &s4_ethphy,
>> +     &s4_mali,
>> +     &s4_aocpu,
>> +     &s4_aucpu,
>> +     &s4_cec,
>> +     &s4_sdemmca,
>> +     &s4_sdemmcb,
>> +     &s4_nand,
>> +     &s4_smartcard,
>> +     &s4_acodec,
>> +     &s4_spifc,
>> +     &s4_msr_clk,
>> +     &s4_ir_ctrl,
>> +     &s4_audio,
>> +     &s4_eth,
>> +     &s4_uart_a,
>> +     &s4_uart_b,
>> +     &s4_uart_c,
>> +     &s4_uart_d,
>> +     &s4_uart_e,
>> +     &s4_aififo,
>> +     &s4_ts_ddr,
>> +     &s4_ts_pll,
>> +     &s4_g2d,
>> +     &s4_spicc0,
>> +     &s4_usb,
>> +     &s4_i2c_m_a,
>> +     &s4_i2c_m_b,
>> +     &s4_i2c_m_c,
>> +     &s4_i2c_m_d,
>> +     &s4_i2c_m_e,
>> +     &s4_hdmitx_apb,
>> +     &s4_i2c_s_a,
>> +     &s4_usb1_to_ddr,
>> +     &s4_hdcp22,
>> +     &s4_mmc_apb,
>> +     &s4_rsa,
>> +     &s4_cpu_debug,
>> +     &s4_vpu_intr,
>> +     &s4_demod,
>> +     &s4_sar_adc,
>> +     &s4_gic,
>> +     &s4_pwm_ab,
>> +     &s4_pwm_cd,
>> +     &s4_pwm_ef,
>> +     &s4_pwm_gh,
>> +     &s4_pwm_ij,
>> +     &s4_demod_core_clk_mux,
>> +     &s4_demod_core_clk_div,
>> +     &s4_demod_core_clk_gate,
>> +     &s4_adc_extclk_in_mux,
>> +     &s4_adc_extclk_in_div,
>> +     &s4_adc_extclk_in_gate,
>> +};
>> +
>> +static struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +};
>> +
>> +static struct meson_clk_hw_data s4_periphs_clks = {
>> +     .hws = s4_periphs_hw_clks,
>> +     .num = ARRAY_SIZE(s4_periphs_hw_clks),
>> +};
>> +
>> +static int meson_s4_periphs_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct regmap *regmap;
>> +     void __iomem *base;
>> +     int ret, i;
>> +
>> +     base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(base))
>> +             return dev_err_probe(dev, PTR_ERR(base),
>> +                                  "can't ioremap resource\n");
>> +
>> +     regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +     if (IS_ERR(regmap))
>> +             return dev_err_probe(dev, PTR_ERR(regmap),
>> +                                  "can't init regmap mmio region\n");
>> +
>> +     /* Populate regmap for the regmap backed clocks */
>> +     for (i = 0; i < ARRAY_SIZE(s4_periphs_clk_regmaps); i++)
>> +             s4_periphs_clk_regmaps[i]->map = regmap;
>> +
>> +     for (i = 0; i < s4_periphs_clks.num; i++) {
>> +             /* array might be sparse */
>> +             if (!s4_periphs_clks.hws[i])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, s4_periphs_clks.hws[i]);
>> +             if (ret)
>> +                     return dev_err_probe(dev, ret,
>> +                                          "clock[%d] registration failed\n", i);
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, &s4_periphs_clks);
>> +}
>> +
>> +static const struct of_device_id clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,s4-peripherals-clkc",
>> +     },
>> +     {}
>> +};
>> +
>> +static struct platform_driver s4_driver = {
>> +     .probe          = meson_s4_periphs_probe,
>> +     .driver         = {
>> +             .name   = "s4-periphs-clkc",
>> +             .of_match_table = clkc_match_table,
>> +     },
>> +};
>> +
>> +module_platform_driver(s4_driver);
>> +MODULE_AUTHOR("Yu Tu <yu.tu@amlogic.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/clk/meson/s4-peripherals.h b/drivers/clk/meson/s4-peripherals.h
>> new file mode 100644
>> index 000000000000..56f8f28a913e
>> --- /dev/null
>> +++ b/drivers/clk/meson/s4-peripherals.h
>> @@ -0,0 +1,57 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2022-2023 Amlogic, inc. All rights reserved
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#ifndef __MESON_S4_PERIPHERALS_H__
>> +#define __MESON_S4_PERIPHERALS_H__
>> +
>> +#define CLKCTRL_RTC_BY_OSCIN_CTRL0                 0x008
>> +#define CLKCTRL_RTC_BY_OSCIN_CTRL1                 0x00c
>> +#define CLKCTRL_RTC_CTRL                           0x010
>> +#define CLKCTRL_SYS_CLK_CTRL0                      0x040
>> +#define CLKCTRL_SYS_CLK_EN0_REG0                   0x044
>> +#define CLKCTRL_SYS_CLK_EN0_REG1                   0x048
>> +#define CLKCTRL_SYS_CLK_EN0_REG2                   0x04c
>> +#define CLKCTRL_SYS_CLK_EN0_REG3                   0x050
>> +#define CLKCTRL_CECA_CTRL0                         0x088
>> +#define CLKCTRL_CECA_CTRL1                         0x08c
>> +#define CLKCTRL_CECB_CTRL0                         0x090
>> +#define CLKCTRL_CECB_CTRL1                         0x094
>> +#define CLKCTRL_SC_CLK_CTRL                        0x098
>> +#define CLKCTRL_CLK12_24_CTRL                      0x0a8
>> +#define CLKCTRL_VID_CLK_CTRL                       0x0c0
>> +#define CLKCTRL_VID_CLK_CTRL2                      0x0c4
>> +#define CLKCTRL_VID_CLK_DIV                        0x0c8
>> +#define CLKCTRL_VIID_CLK_DIV                       0x0cc
>> +#define CLKCTRL_VIID_CLK_CTRL                      0x0d0
>> +#define CLKCTRL_HDMI_CLK_CTRL                      0x0e0
>> +#define CLKCTRL_VID_PLL_CLK_DIV                    0x0e4
>> +#define CLKCTRL_VPU_CLK_CTRL                       0x0e8
>> +#define CLKCTRL_VPU_CLKB_CTRL                      0x0ec
>> +#define CLKCTRL_VPU_CLKC_CTRL                      0x0f0
>> +#define CLKCTRL_VID_LOCK_CLK_CTRL                  0x0f4
>> +#define CLKCTRL_VDIN_MEAS_CLK_CTRL                 0x0f8
>> +#define CLKCTRL_VAPBCLK_CTRL                       0x0fc
>> +#define CLKCTRL_HDCP22_CTRL                        0x100
>> +#define CLKCTRL_VDEC_CLK_CTRL                      0x140
>> +#define CLKCTRL_VDEC2_CLK_CTRL                     0x144
>> +#define CLKCTRL_VDEC3_CLK_CTRL                     0x148
>> +#define CLKCTRL_VDEC4_CLK_CTRL                     0x14c
>> +#define CLKCTRL_TS_CLK_CTRL                        0x158
>> +#define CLKCTRL_MALI_CLK_CTRL                      0x15c
>> +#define CLKCTRL_NAND_CLK_CTRL                      0x168
>> +#define CLKCTRL_SD_EMMC_CLK_CTRL                   0x16c
>> +#define CLKCTRL_SPICC_CLK_CTRL                     0x174
>> +#define CLKCTRL_GEN_CLK_CTRL                       0x178
>> +#define CLKCTRL_SAR_CLK_CTRL                       0x17c
>> +#define CLKCTRL_PWM_CLK_AB_CTRL                    0x180
>> +#define CLKCTRL_PWM_CLK_CD_CTRL                    0x184
>> +#define CLKCTRL_PWM_CLK_EF_CTRL                    0x188
>> +#define CLKCTRL_PWM_CLK_GH_CTRL                    0x18c
>> +#define CLKCTRL_PWM_CLK_IJ_CTRL                    0x190
>> +#define CLKCTRL_DEMOD_CLK_CTRL                     0x200
>> +
>> +#endif /* __MESON_S4_PERIPHERALS_H__ */
>> +
> 
