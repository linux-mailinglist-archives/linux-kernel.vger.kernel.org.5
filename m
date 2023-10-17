Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9727CC610
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343858AbjJQOkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjJQOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:40:47 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E95BA;
        Tue, 17 Oct 2023 07:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkbKUNRvrIXN9IsgAzZx4jv8/k1HJ2lnuAPPy93f3aYuETbqBeLAOiHmSRHH/CGGkHvXhOwmwUd2WeH0MPNw2qO+MRxjbvotjOo9XDfBZycW+F56G8V/SyXH8cIrhnrllnqYtBidzN3ZwYubiTk17MPCMGSQ4DPeAglwnmW6UHxaMUNW7t6onjL4b9/5IIsQUNH7O3JWOw7z6JjMXphhPmkZWSURA7cT3YM9GhdjvjdEECZchETaKcmsow9QXNhmU6hZOsR3JwqDAzs48gPsScshlfHrBK6UpAZvRzwi7Wy0JfX2OcKT4hLQwGGo1brf8R//IgfCyQ5ghiR2DB8YNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZIEgZsNX/nTiMHUpmbUtaEbqndXn4IlAocRgMJN4qY=;
 b=GV4anaY27rCaEo+wIT+y72n/yrteDhtOrgEXVQ9nBsUZwJXAiEXKLv8wYha0pUEVVYXcfJD+8Hn1lDYyhQAHVMwqyW4tmRrTfamPwLaOHl5sMDsGBbQ2e+k5DJy3AWEFgtHrSWh/uwVsRcGBcl8FKRwbycWEwxprVguQy427F19ZmooB3+Non0gqCB5gjo8UJXhJRXUyYVWrVRi5y6VmNbbnmqUp/Gdsh1ZsC9Ndls0XLPdmR8A1nAyeaiEO12m7rAjH32UNCOqwyrXs2gQaPy5eq0Sw6yucJo8j/AAUODVymbubPLxOJ5yD7RLa5JdXlisd8bi8wcGYLICB40SJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZIEgZsNX/nTiMHUpmbUtaEbqndXn4IlAocRgMJN4qY=;
 b=czMThm6DcILQdmGBBWrE0yZkwwNL7GUq6weUx6tk2+8jM6c0HWmUh1lojZxuHfOW8nJAeIKtGmxev0b+XilyOFNp2ZmnDCBIe7RXW/uVa7hIjFu/Pi5dFgew4YqmB/AIPpIieuQ+j53um7KlSX2jKhLCKGuzRaGIx05BWDaZAm7lCYxMzoH5eZ1eKAueN8CB24g62TYsmdKeWF2SE28bfg7Cj9I5QUF7gf/vGEtxNCl7T5yhkoegU7Ml8NW/3WYUH1IQ9Cht8HANyf5lgQN4EEEBCeDAM8ESODG/1qQjz1CAc43FiHzHrHKyTsqoLMJaADYgBwe27ZOghqqIbDTQcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by PSAPR03MB5589.apcprd03.prod.outlook.com (2603:1096:301:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 14:39:48 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::20eb:2a5a:77b6:4275]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::20eb:2a5a:77b6:4275%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:39:48 +0000
Message-ID: <8011f0c0-0d21-447f-9a6b-07ede7db8713@amlogic.com>
Date:   Tue, 17 Oct 2023 22:39:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/4] clk: meson: c3: add support for the C3 SoC PLL
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
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-4-xianwei.zhao@amlogic.com>
 <1jil7ax64i.fsf@starbuckisacylon.baylibre.com>
 <3238e57a-1141-53ad-8170-c6ad9df03acb@amlogic.com>
 <1jfs29v0n3.fsf@starbuckisacylon.baylibre.com>
From:   Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jfs29v0n3.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::20) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|PSAPR03MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fcba7b-e4e6-4552-f7c2-08dbcf1ee92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXBs/E++BIaBwjIHvdlqxNJyjPniLIhmFSrVp/Wa/j9fwCXMDP98+nr/7CB1ErPIkXydLzyhj/i12GRvyx8Wmlh5hQsG0QEuPoh2rPzWLgkyTF14Kz5F/ahAYrpWSCDdtmyjD8uZvAw4KOl5OnLvpbeljHfZ54PoOTtEqJIWZZ9WpvEDU8Ibhfgn/EdY00X5wtPlbU/ReAq012xu8RZZS6gRPwjYRffddZlpGMNee42JQLln9pNYm4gNHikUbjvYmADjscHuuEH058yz2HPql//5xxLQFf4IwyU1MQzBJUIZ9aN3zS8+SlDbgpW/7lJwvifd5VR8qlVUbnrVuCeka0m7eNR+FK8ojWzGbZDS/JDkP/6ZWOggRwmON1b+Ued2L5YkWWDPLJ84itJxijcuiU1tmXhB0qhQQh5KuqFdhGlYHsulroJvjb7yr3y7jNzuQIZkpVw1KihHSj6L/8PbKGTOZGWWDz+jtjvsJKufiqYj5dQ9fJI5k3Fq9lpWZWRN5dCrWXnRQbsCsDZwwmdIeEosNDe/gXvnvO0fueFUMCQ3AnOBojXqNBgKYZhqtdrMQBb/RprLAYfV3FkCq4qcBSsAH8Q7xfP5pCb6RYsWDUcULdE5ziArfCSgb1N+jjEXpv6zFiN1ALwy9EuUrJ9rrEs/VZBiz5YZ1By5PuRQRfPSXHrUcx5GZD2MGZOgZskiHRtOxDPDIsePUZxnr9DAMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39850400004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(44832011)(41300700001)(7416002)(8936002)(4326008)(8676002)(5660300002)(31696002)(2906002)(30864003)(86362001)(36756003)(478600001)(966005)(38100700002)(6506007)(26005)(53546011)(6512007)(6486002)(2616005)(83380400001)(6666004)(54906003)(66476007)(66946007)(66556008)(316002)(31686004)(110136005)(43740500002)(45980500001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBKdnVpNU5RM2x2U1NhQmtVdTI3bGRCVXdndW9Uc2NNaXZ0ZGd2OGNsZ2NY?=
 =?utf-8?B?Qk14QmYvdFAwVjhtd2twSHhhWU00d2VaaVZaemFKeFhxYW1EY1YzblMwdFRu?=
 =?utf-8?B?dzNFVkNOU2kyYjFDTTVtcWxLWks4bkRpY0h0bVVXU0ZrckVFVXdncjIrNmxZ?=
 =?utf-8?B?SmtsOW1jdW02RGdxa1NJenZGK0RwTDVjd0h0VUtXV0g4ZVRGdW03eVdBdXgx?=
 =?utf-8?B?QkxHL0Rxc0lFTmNtR0JLeW02Q1h5bkRBOUJ3bzgvM0FBUVA5cFAydDRHL0s2?=
 =?utf-8?B?VUQwM3Nld2Z6bXB4VDR6T2tObWJNZldCelp5K1drWlAycG9UYnkyMlpwRDht?=
 =?utf-8?B?djlna3FPZ0Y4ZUR6RDE0Q0lLOGJ1anpETlNKdmxhOCtSQlJIMlg4cUJZa0Q4?=
 =?utf-8?B?dzExVHBsbGQ0QlFkOTNobm9zUkJDSC8xdVF4QVRnN0t1NmF4OWs2aXJQQWU1?=
 =?utf-8?B?QjdEeVlBdFEvWlg1T285RTVvaHpUQUd3TWZ2bE85SjI1UnJKT0t2M0k2YStN?=
 =?utf-8?B?OUVzSDNZTFZyTGNES0RVS1lOQSszQlE3blNEbmJRZTI0ODNsS1g1b1VKTDli?=
 =?utf-8?B?TG5MMlhQR1p6b1lQREU0aXk2RkgrcnBVdksyc3lCRzMwbDIwWm1WbUtVcUFa?=
 =?utf-8?B?aEwxZlF3bE8vRytVeGR4K1BnOXd0NXU5aHdpOGU4WFZWZzZyMDdFTS9GYldk?=
 =?utf-8?B?V0FzVXlqbTRSWTZSNzVHdW5TcVEwMnpOTkN2eXhxME1uT3Q5Yi9oaGt1SVhr?=
 =?utf-8?B?VGhFRTM1NDQrZXZMZTFvdXNPc1NpSzhzUXF6cjE1cWc2dVFCSmdpL3FMcytk?=
 =?utf-8?B?T1hXV1pJNWkrRlpJVGRTZjF0UXJXMFk1M2huWFE4NVVrS0Fnbk92djduc1ZP?=
 =?utf-8?B?ZWFSL2RydEMwZStZU051MWNqN2FBSlNycENadXVuMVVycm45cmViaS9kMlNI?=
 =?utf-8?B?MzlWS2J3a051UWtnZTRiSWY2eG84dDRFNlRuYzJvMnpJMmxSQkVDcEwwdkpX?=
 =?utf-8?B?L1ZiZVQ2K3RmV0RkYllVekFtZm1FakFTZ1JIZG0vZXFobGtHKzJISiswY0Vz?=
 =?utf-8?B?d3owZXMwL21kZDQyMTFLOWd6VnRzeHdkMDlLZCtoY3ZaZW5XNXlsaTNYVTJj?=
 =?utf-8?B?MXFKbEVYeVBtZTRvOWNWQVRmb2dnalQ2OHdOOVlQdTNJUjV3Q3VRQ1ZVK3Qx?=
 =?utf-8?B?UmJzOEw1c09jSTBud1hKR05lVm5DNmtITkd6QWhDYUorVW5ETm5aYUloZWdr?=
 =?utf-8?B?NnVuaHhVakt1bmFBS3lYU1FFc0dSMjRENkVvcG81c1J2K3ErOTU0MkdoN1ha?=
 =?utf-8?B?Nnd3Sjh2d3p5dzI3NW50Y05mUjY1UThUaGxsK013SUM3d3NNcFFXQjhtWXVJ?=
 =?utf-8?B?RHIyK1hrTTA3c1VXc2tITWQwT1hjQXNMK0ZBTWN0K1oxYks0SkdVbUV2Wm92?=
 =?utf-8?B?NjRleFFFYTgwbU41bHVyYnVkWUZNTnBVcXRRWDBaOWRsL1dnUjBqM2J1b3N0?=
 =?utf-8?B?aXBsczRKeVNFVFI3SnlFWWFEbW9RQlhULyt1L3VHLzhYTGh0d3ZIckd5dFZq?=
 =?utf-8?B?WTdHSDEzLzdnR0NyZVBkN1drUzlCemdYNE5kOUVpM3lLZFcxbEpXeGRVQStD?=
 =?utf-8?B?Q1pSWEJPRXhzUktWR2lSdjJaa0VDV2p3dFo5aWFTNzVpSnVQQ3VMdmlRT0Vs?=
 =?utf-8?B?SXRHVU8xeVg0L1Y0QWVoN09laFdGeVM5amFGRHU4Y1J0bVVxYUt1QWJIU01m?=
 =?utf-8?B?QXFXTUZsM293OTN3WEdsclB0Z25GeWFWQ2xVck96NFcybEVZQzRTaUpQcDYz?=
 =?utf-8?B?WTZMS0ZicVFMUmdQbVQvQkFXeVhOaHFEWnZZcVVkeDJUN2EzZTR5WEc2U1pC?=
 =?utf-8?B?SDVza3c4bXZ4bFB3ZnZPbTBCVjA0ZEJWTWlaR3NmaXFuMEFPUHp3bnREUFNW?=
 =?utf-8?B?UVoyb3pZeWFjekpBVEgyRTFRNzM1RzNKQTdqS2ppbmIzdmVxMUZuQWszdS9Y?=
 =?utf-8?B?emtMZWVNc0trenlsNXVmT00rQ3IvVy9McTIrYkdqUE5vY0Z1d0ltV3NUNVhv?=
 =?utf-8?B?RUJSUjNnanFuUHIxL1ZacnJOSjkzanQxUlo4aDZ5andkWmYybkdiOXhTUG52?=
 =?utf-8?Q?AtXLZs3jCZkRx6weSg+uVvVfx?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fcba7b-e4e6-4552-f7c2-08dbcf1ee92a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 14:39:47.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWm7wPyWg0miFzKov2BuorpDxU0ei7RcIvoaIrvU0BTgA7QQy4DTkIv/fEJFbTOO2aUSnMV7GfiF47Sm/sUy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome

     Thank you for your reply.

在 2023/10/17 21:06, Jerome Brunet 写道:
> [????????? jbrunet@baylibre.com ????????? https://aka.ms/LearnAboutSenderIdentification,????????????]
>
> [ EXTERNAL EMAIL ]
>
> On Tue 17 Oct 2023 at 14:15, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>
>> Hi Jerome,
>>
>>
>> On 2023/10/13 15:49, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>> On Tue 10 Oct 2023 at 14:29, Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> wrote:
>>>
>>>> Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.
>>>>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> ---
>>>> V1 -> V2: Delete macro definition.
>>>> ---
>>>>    drivers/clk/meson/Kconfig  |  12 +
>>>>    drivers/clk/meson/Makefile |   1 +
>>>>    drivers/clk/meson/c3-pll.c | 808 +++++++++++++++++++++++++++++++++++++
>>>>    drivers/clk/meson/c3-pll.h |  35 ++
>>>>    4 files changed, 856 insertions(+)
>>>>    create mode 100644 drivers/clk/meson/c3-pll.c
>>>>    create mode 100644 drivers/clk/meson/c3-pll.h
>>>>
>>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>>> index c5303e4c1604..76be4bbd2afb 100644
>>>> --- a/drivers/clk/meson/Kconfig
>>>> +++ b/drivers/clk/meson/Kconfig
>>>> @@ -128,6 +128,18 @@ config COMMON_CLK_A1_PERIPHERALS
>>>>           device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>>>>           controller to work.
>>>>
>>>> +config COMMON_CLK_C3_PLL
>>>> +     tristate "Amlogic C3 PLL clock controller"
>>>> +     default y
>>>> +     select COMMON_CLK_MESON_REGMAP
>>>> +     select COMMON_CLK_MESON_PLL
>>>> +     select COMMON_CLK_MESON_CLKC_UTILS
>>>> +     help
>>>> +       Support for the PLL clock controller on Amlogic C302X and C308L devices,
>>>> +       AKA c3. Amlogic C302X and C308L devices include AW402, AW409 and AW419.
>>>> +       Say Y if you want the board to work, because PLLs are the parent of most
>>>> +       peripherals.
>>>> +
>>>>    config COMMON_CLK_G12A
>>>>         tristate "G12 and SM1 SoC clock controllers support"
>>>>         depends on ARM64
>>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>>> index 9ee4b954c896..4420af628b31 100644
>>>> --- a/drivers/clk/meson/Makefile
>>>> +++ b/drivers/clk/meson/Makefile
>>>> @@ -19,6 +19,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>>>    obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>>>    obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>>>    obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>>>> +obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>>>>    obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>>>    obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>>>    obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>>>> diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
>>>> new file mode 100644
>>>> index 000000000000..97619bc7ab79
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/c3-pll.c
>>>> @@ -0,0 +1,808 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Amlogic C3 PLL Controller Driver
>>>> + *
>>>> + * Copyright (c) 2023 Amlogic, inc.
>>>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>>>> + */
>>>> +
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/clk.h>
>>>> +#include "clk-regmap.h"
>>>> +#include "clk-pll.h"
>>>> +#include "c3-pll.h"
>>>> +#include "meson-clkc-utils.h"
>>>> +#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
>>>> +
>>>> +static const struct clk_parent_data pll_dco_parent = {
>>>> +     .fw_name = "pll_in",
>>>> +};
>>>> +
>>>> +static const struct clk_parent_data mclk_pll_dco_parent = {
>>>> +     .fw_name = "mclk_pll_in",
>>>> +};
>>> I'm assuming this section relates to Documentation section 6.6.3.5 MPLL
>>> because all the fixed clock looks very familiar.
>>> Because of the naming of another clock below, I'm not quite sure. Please
>>> clarify
>>>
>> MPLL is not included in C3 SoC. Document was not updated to reflect this
>> change.
>> Mclk_Pll is  designed for sensor in C3 Soc.
>>>> +
>>>> +static struct clk_regmap fixed_pll_dco = {
>>>> +     .data = &(struct meson_clk_pll_data){
>>>> +             .en = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>> +                     .shift   = 28,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .m = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 8,
>>>> +             },
>>>> +             .n = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>> +                     .shift   = 16,
>>>> +                     .width   = 5,
>>>> +             },
>>>> +             .l = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>> +                     .shift   = 31,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .rst = {
>>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>> +                     .shift   = 29,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fixed_pll_dco",
>>>> +             .ops = &meson_clk_pll_ro_ops,
>>>> +             .parent_data = &pll_dco_parent,
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap fixed_pll = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL0,
>>>> +             .shift = 12,
>>>> +             .width = 3,
>>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fixed_pll",
>>>> +             .ops = &clk_regmap_divider_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fixed_pll_dco.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>> Need a comment about why this is using RO ops
>>>
>> Will do.
>>
>>>> +
>>>> +static struct clk_fixed_factor fclk_div40_div = {
>>>> +     .mult = 1,
>>>> +     .div = 40,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div40_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fixed_pll.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap fclk_div40 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>>> +             .bit_idx = 0,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "fclk_div40",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fclk_div40_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>> Don't see div40 in the diagram, where does it come from ?
>>> The div40 is  an alias of  fixpll_clk50m in sec 6.6.5.3 about FIXPLL.
> Then maybe clk50m something is better name for it
OK,Will be fixed in the next version
>
>>>> +
>>>> +static struct clk_fixed_factor fclk_div2_div = {
>>>> +     .mult = 1,
>>>> +     .div = 2,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div2_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fixed_pll.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap fclk_div2 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>>> +             .bit_idx = 24,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "fclk_div2",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fclk_div2_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor fclk_div2p5_div = {
>>>> +     .mult = 2,
>>>> +     .div = 5,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div2p5_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fixed_pll.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>> This one is wrong if I follow the doc.
>>> It is supposed to be fixed 8 divider taking it's source directly from
>>> the DCO, skipping the OD post divider ... assuming the doc is up to date.
>>>
>> No, C3 SoC div2p5 is not skipping the OD post divider.
> I a bit surprised there would be a frequency multiplier considering the
> complexity of it, when skiping a divider is possible HW wise. Are you
> sure ?
This part confirms with our chip design engineer that fclk_div2p5 here 
is actually a clock output by a divider with decimal (divider factor is 
2.5). The divider factor in clk-divider.c is int, so this description is 
used in the software. Or what do you suggest would be a better way to 
describe this type of divider with decimals?
>>>> +
>>>> +static struct clk_regmap fclk_div2p5 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>>> +             .bit_idx = 4,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "fclk_div2p5",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fclk_div2p5_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor fclk_div3_div = {
>>>> +     .mult = 1,
>>>> +     .div = 3,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div3_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fixed_pll.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap fclk_div3 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>>> +             .bit_idx = 20,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "fclk_div3",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fclk_div3_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor fclk_div4_div = {
>>>> +     .mult = 1,
>>>> +     .div = 4,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div4_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fixed_pll.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap fclk_div4 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>>> +             .bit_idx = 21,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "fclk_div4",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fclk_div4_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor fclk_div5_div = {
>>>> +     .mult = 1,
>>>> +     .div = 5,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div5_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fixed_pll.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap fclk_div5 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>>> +             .bit_idx = 22,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "fclk_div5",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fclk_div5_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor fclk_div7_div = {
>>>> +     .mult = 1,
>>>> +     .div = 7,
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "fclk_div7_div",
>>>> +             .ops = &clk_fixed_factor_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fixed_pll.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap fclk_div7 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>>> +             .bit_idx = 23,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "fclk_div7",
>>>> +             .ops = &clk_regmap_gate_ro_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &fclk_div7_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static const struct reg_sequence c3_gp0_init_regs[] = {
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL1,  .def = 0x0 },
> This would change frac
>
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL2,  .def = 0x0 },
> This might be OK
>
>>> This should re-init GP0 rate on boot which is not desirable in case the
>>> bootloader had already set a rate (for splash screen for example)
>>> Sugguest you drop these
>> If I drop these ,set rate will be failed.
>> There are two differences between C3 SoC PLL and the previous SoC PLL.
>> It recommends reconfiguring PLL according to time sequence each time when
>> C3 PLL set rate. When previous SoC set rate, it set frequency related
>> parameters and  enable PLL after directly reset PLL about previous SoC.
>> When setting C3 PLL, you need to reset a pll lock rst bit, otherwise the
>> PLL lock bit will not refresh.
> 1. The amlogic off tree driver might using this for every set_rate() but
> upstream does not. this is only used for init.
> 2. We have a rst parameter explicitly for this. This bit is poked. It is
> part of the enable sequence.
>
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL3,  .def = 0x48681c00 },
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x3927200a },
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL6,  .def = 0x56540000, .delay_us = 10 },
> ---
>
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0x080304fa },
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0x380304fa, .delay_us = 10 },
>>>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0X180304fa }
> This definitely is not.
>
> For all I can tell, in addition to an hard coded rate,
> This disable 'en' and 'rst', put them back to 1 - wait 10us then disable
> rst again.
>
> On set_rate() here what the current driver would do with this (assuming
> the clock was enabled)
>
> - disable: rst 0 -> 1 ; en 1 -> 0;
> - set_rate : write m, n, and frac
> - enable: en 0 -> 1; rst 1 -> 0;
>
> If you think the current sequence used by clk-pll.c is not approriate,
> feel free to submit a patch.
Here's the background:
PLL design engineers suggest that it is best to reconfigure the 
corresponding registers each time the pll frequency is set to prevent 
extreme cases where pll lock may fail. At present, 
meson_clk_pll_set_rate() can also be configured properly before using 
the adaptation. The next version of this part will be adapted to the 
previous ops, and the clk-pll.c related patch will be submitted when 
there are problems in the future.
>>>> +};
>>>> +
>>>> +static const struct pll_params_table c3_gp0_pll_params_table[] = {
>>>> +     PLL_PARAMS(150, 1), /* DCO = 3600M */
>>>> +     PLL_PARAMS(130, 1), /* DCO = 3120M */
>>>> +     PLL_PARAMS(192, 1), /* DCO = 4608M */
>>>> +     PLL_PARAMS(125, 1), /* DCO = 3000M */
>>>> +     { /* sentinel */  }
>>>> +};
>>> Why can't C3 use mult_range for GP0, like the other SoC ?
>>> Doc says DCO can do 3 to 6GHz
>>>
>> The mult_range method is time-consuming and not suitable for scenarios
>> requiring high frequency cutting performance.
> Do you have numbers backing this up ?
>
> I might be wrong but I don't think going through the mult_range
> calculation is even a topic when you consider the time it takes to
> relock the PLL or the delay added in the sequence.
>
>> We generally only use a few commonly used frequencies.
> You do yes. A driver is about enabling the HW, not just what a set of
> people are doing with it.
Compared with set_rate() of table, muli_range takes longer time. In 
scenarios where the number of frequency points is small and performance 
requirements are strict, we use the table definition (for example, when 
sys_pll serves as the CPU clock source, the frequency needs to be 
dynamically switched quickly). muli_range can support more frequencies 
to adapt to a wider range of scenarios, considering that the next 
version will be adapted to muli_range
>>>> +
>>>> +/* The maximum frequency divider supports is 32, not 128(2^7) */
>>>> +static const struct clk_div_table c3_gp0_pll_od_table[] = {
>>>> +     { 0,  1 },
>>>> +     { 1,  2 },
>>>> +     { 2,  4 },
>>>> +     { 3,  8 },
>>>> +     { 4, 16 },
>>>> +     { 5, 32 },
>>>> +     { /* sentinel */ }
>>>> +};
>>> Please put that table next to the related divider
>>> Same for other instances
>>>
>> Will do.
>>>> +
>>>> +static struct clk_regmap gp0_pll_dco = {
>>>> +     .data = &(struct meson_clk_pll_data){
>>>> +             .en = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>>> +                     .shift   = 28,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .m = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 9,
>>>> +             },
>>>> +             .frac = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL1,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 19,
>>>> +             },
>>>> +             .n = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>>> +                     .shift   = 10,
>>>> +                     .width   = 5,
>>>> +             },
>>>> +             .l = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>>> +                     .shift   = 31,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .rst = {
>>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>>> +                     .shift   = 29,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .table = c3_gp0_pll_params_table,
>>>> +             .init_regs = c3_gp0_init_regs,
>>>> +             .init_count = ARRAY_SIZE(c3_gp0_init_regs),
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "gp0_pll_dco",
>>>> +             .ops = &meson_clk_pll_ops,
>>>> +             .parent_data = &pll_dco_parent,
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap gp0_pll = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = ANACTRL_GP0PLL_CTRL0,
>>>> +             .shift = 16,
>>>> +             .width = 3,
>>>> +             .table = c3_gp0_pll_od_table,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "gp0_pll",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &gp0_pll_dco.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static const struct reg_sequence c3_hifi_init_regs[] = {
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x08010496 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x38010496 },
>>> Same here, this an hidden hard coded rate init, with enable on top.
>>> Please drop this
>>> If you need a specific rate after the init, use assigned-rate in DT
>>>
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x0000ce40 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00000000 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a285c00 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x56540000, .delay_us = 50 },
>>>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x18010496, .delay_us = 20 },
>>>> +};
>>>> +
>>>> +static const struct pll_params_table c3_hifi_pll_params_table[] = {
>>>> +     PLL_PARAMS(150, 1), /* DCO = 3600M */
>>>> +     PLL_PARAMS(130, 1), /* DCO = 3120M */
>>>> +     PLL_PARAMS(192, 1), /* DCO = 4608M */
>>>> +     PLL_PARAMS(125, 1), /* DCO = 3000M */
>>>> +     { /* sentinel */  }
>>>> +};
>>> Again, why can't HiFi use mult range ?
>>>
>> The mult_range method is time-consuming and not suitable for scenarios
>> requiring high frequency cutting performance.
> Again, I'd be curious how this can be a problem when considering the
> time it takes to reloc the PLL.
>
> How often do you relock a PLL for HiFi use cases ?
The next version will change to mult_range
>>>> +
>>>> +static struct clk_regmap hifi_pll_dco = {
>>>> +     .data = &(struct meson_clk_pll_data){
>>>> +             .en = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 28,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .m = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 8,
>>>> +             },
>>>> +             .frac = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL1,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 19,
>>>> +             },
>>>> +             .n = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 10,
>>>> +                     .width   = 5,
>>>> +             },
>>>> +             .l = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 31,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .rst = {
>>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>> +                     .shift   = 29,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .table = c3_hifi_pll_params_table,
>>>> +             .init_regs = c3_hifi_init_regs,
>>>> +             .init_count = ARRAY_SIZE(c3_hifi_init_regs),
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "hifi_pll_dco",
>>>> +             .ops = &meson_clk_pll_ops,
>>>> +             .parent_data = &pll_dco_parent,
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap hifi_pll = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = ANACTRL_HIFIPLL_CTRL0,
>>>> +             .shift = 16,
>>>> +             .width = 2,
>>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "hifi_pll",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &hifi_pll_dco.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>> I cannot make out what all the mclk section below relates to in
>>> documentation clock. Could you please clarify ?
>>>
>>>> +static const struct reg_sequence c3_mclk_init_regs[] = {
>>>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x20011063 },
>>>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x30011063 },
>>> Again, hidden rate set on init ...
>>>
>>>> +     { .reg = ANACTRL_MPLL_CTRL1,    .def = 0x1420500f },
>>>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023041 },
>>>> +     { .reg = ANACTRL_MPLL_CTRL3,    .def = 0x18180000 },
>>>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x10011063 },
>>>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023001 }
>>>> +};
>>>> +
>>>> +static const struct pll_params_table c3_mclk_pll_params_table[] = {
>>>> +     PLL_PARAMS(99, 1), /* VCO = 2376M */
>>>> +     { /* sentinel */  }
>>>> +};
>>>> +
>>>> +static const struct clk_div_table c3_mpll_od_table[] = {
>>>> +     { 0,  1 },
>>>> +     { 1,  2 },
>>>> +     { 2,  4 },
>>>> +     { 3,  8 },
>>>> +     { 4, 16 },
>>>> +     { /* sentinel */ }
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk_pll_dco = {
>>>> +     .data = &(struct meson_clk_pll_data){
>>>> +             .en = {
>>>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>>>> +                     .shift   = 28,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .m = {
>>>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>>>> +                     .shift   = 0,
>>>> +                     .width   = 9,
>>>> +             },
>>>> +             .n = {
>>>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>>>> +                     .shift   = 10,
>>>> +                     .width   = 5,
>>>> +             },
>>>> +             .l = {
>>>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>>>> +                     .shift   = 31,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .rst = {
>>>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>>>> +                     .shift   = 29,
>>>> +                     .width   = 1,
>>>> +             },
>>>> +             .table = c3_mclk_pll_params_table,
>>>> +             .init_regs = c3_mclk_init_regs,
>>>> +             .init_count = ARRAY_SIZE(c3_mclk_init_regs),
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "mclk_pll_dco",
>>>> +             .ops = &meson_clk_pll_ops,
>>>> +             .parent_data = &mclk_pll_dco_parent,
>>>> +             .num_parents = 1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk_pll = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = ANACTRL_MPLL_CTRL0,
>>>> +             .shift = 12,
>>>> +             .width = 3,
>>>> +             .table = c3_mpll_od_table,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "mclk_pll",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &mclk_pll_dco.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk_pll_clk = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>>> +             .shift = 16,
>>>> +             .width = 5,
>>>> +             .flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "mclk_pll_clk",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &mclk_pll.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>> "mclk_pll" then "mclk_pll_clk" ... that is confusing
>>>
>> Maybe mclk_pll rename mclk_pll_od.>> +
>>>> +static const struct clk_parent_data mclk_parent[] = {
>>>> +     { .hw = &mclk_pll_clk.hw },
>>>> +     { .fw_name = "mclk_pll_in" },
>>>> +     { .hw = &fclk_div40.hw }
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk0_sel = {
>>>> +     .data = &(struct clk_regmap_mux_data){
>>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>>> +             .mask = 0x3,
>>>> +             .shift = 4,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "mclk0_sel",
>>>> +             .ops = &clk_regmap_mux_ops,
>>>> +             .parent_data = mclk_parent,
>>>> +             .num_parents = ARRAY_SIZE(mclk_parent),
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk0_sel_out = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>>> +             .bit_idx = 1,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "mclk0_sel_out",
>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &mclk0_sel.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk0_div = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>>> +             .shift = 2,
>>>> +             .width = 1,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "mclk0_div",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &mclk0_sel_out.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk0 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>>> +             .bit_idx = 0,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "mclk0",
>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &mclk0_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk1_sel = {
>>>> +     .data = &(struct clk_regmap_mux_data){
>>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>>> +             .mask = 0x3,
>>>> +             .shift = 12,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "mclk1_sel",
>>>> +             .ops = &clk_regmap_mux_ops,
>>>> +             .parent_data = mclk_parent,
>>>> +             .num_parents = ARRAY_SIZE(mclk_parent),
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk1_sel_out = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>>> +             .bit_idx = 9,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "mclk1_sel_out",
>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &mclk1_sel.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk1_div = {
>>>> +     .data = &(struct clk_regmap_div_data){
>>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>>> +             .shift = 10,
>>>> +             .width = 1,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "mclk1_div",
>>>> +             .ops = &clk_regmap_divider_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &mclk1_sel_out.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_regmap mclk1 = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>>> +             .bit_idx = 8,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "mclk1",
>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &mclk1_div.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> +static struct clk_hw *c3_pll_hw_clks[] = {
>>>> +     [CLKID_FIXED_PLL_DCO]   = &fixed_pll_dco.hw,
>>>> +     [CLKID_FIXED_PLL]       = &fixed_pll.hw,
>>>> +     [CLKID_FCLK_DIV40_DIV]  = &fclk_div40_div.hw,
>>>> +     [CLKID_FCLK_DIV40]      = &fclk_div40.hw,
>>>> +     [CLKID_FCLK_DIV2_DIV]   = &fclk_div2_div.hw,
>>>> +     [CLKID_FCLK_DIV2]       = &fclk_div2.hw,
>>>> +     [CLKID_FCLK_DIV2P5_DIV] = &fclk_div2p5_div.hw,
>>>> +     [CLKID_FCLK_DIV2P5]     = &fclk_div2p5.hw,
>>>> +     [CLKID_FCLK_DIV3_DIV]   = &fclk_div3_div.hw,
>>>> +     [CLKID_FCLK_DIV3]       = &fclk_div3.hw,
>>>> +     [CLKID_FCLK_DIV4_DIV]   = &fclk_div4_div.hw,
>>>> +     [CLKID_FCLK_DIV4]       = &fclk_div4.hw,
>>>> +     [CLKID_FCLK_DIV5_DIV]   = &fclk_div5_div.hw,
>>>> +     [CLKID_FCLK_DIV5]       = &fclk_div5.hw,
>>>> +     [CLKID_FCLK_DIV7_DIV]   = &fclk_div7_div.hw,
>>>> +     [CLKID_FCLK_DIV7]       = &fclk_div7.hw,
>>>> +     [CLKID_GP0_PLL_DCO]     = &gp0_pll_dco.hw,
>>>> +     [CLKID_GP0_PLL]         = &gp0_pll.hw,
>>>> +     [CLKID_HIFI_PLL_DCO]    = &hifi_pll_dco.hw,
>>>> +     [CLKID_HIFI_PLL]        = &hifi_pll.hw,
>>>> +     [CLKID_MCLK_PLL_DCO]    = &mclk_pll_dco.hw,
>>>> +     [CLKID_MCLK_PLL]        = &mclk_pll.hw,
>>>> +     [CLKID_MCLK_PLL_CLK]    = &mclk_pll_clk.hw,
>>>> +     [CLKID_MCLK0_SEL]       = &mclk0_sel.hw,
>>>> +     [CLKID_MCLK0_SEL_OUT]   = &mclk0_sel_out.hw,
>>>> +     [CLKID_MCLK0_DIV]       = &mclk0_div.hw,
>>>> +     [CLKID_MCLK0]           = &mclk0.hw,
>>>> +     [CLKID_MCLK1_SEL]       = &mclk1_sel.hw,
>>>> +     [CLKID_MCLK1_SEL_OUT]   = &mclk1_sel_out.hw,
>>>> +     [CLKID_MCLK1_DIV]       = &mclk1_div.hw,
>>>> +     [CLKID_MCLK1]           = &mclk1.hw
>>>> +};
>>>> +
>>>> +/* Convenience table to populate regmap in .probe */
>>>> +static struct clk_regmap *const c3_pll_clk_regmaps[] = {
>>>> +     &fixed_pll_dco,
>>>> +     &fixed_pll,
>>>> +     &fclk_div40,
>>>> +     &fclk_div2,
>>>> +     &fclk_div2p5,
>>>> +     &fclk_div3,
>>>> +     &fclk_div4,
>>>> +     &fclk_div5,
>>>> +     &fclk_div7,
>>>> +     &gp0_pll_dco,
>>>> +     &gp0_pll,
>>>> +     &hifi_pll_dco,
>>>> +     &hifi_pll,
>>>> +     &mclk_pll_dco,
>>>> +     &mclk_pll,
>>>> +     &mclk_pll_clk,
>>>> +     &mclk0_sel,
>>>> +     &mclk0_sel_out,
>>>> +     &mclk0_div,
>>>> +     &mclk0,
>>>> +     &mclk1_sel,
>>>> +     &mclk1_sel_out,
>>>> +     &mclk1_div,
>>>> +     &mclk1,
>>>> +};
>>>> +
>>>> +static struct regmap_config clkc_regmap_config = {
>>>> +     .reg_bits       = 32,
>>>> +     .val_bits       = 32,
>>>> +     .reg_stride     = 4,
>>>> +};
>>>> +
>>>> +static struct meson_clk_hw_data c3_pll_clks = {
>>>> +     .hws = c3_pll_hw_clks,
>>>> +     .num = ARRAY_SIZE(c3_pll_hw_clks),
>>>> +};
>>>> +
>>>> +static int aml_c3_pll_probe(struct platform_device *pdev)
>>>> +{
>>>> +     struct device *dev = &pdev->dev;
>>>> +     struct regmap *regmap;
>>>> +     void __iomem *base;
>>>> +     int clkid, ret, i;
>>>> +
>>>> +     base = devm_platform_ioremap_resource(pdev, 0);
>>>> +     if (IS_ERR(base))
>>>> +             return PTR_ERR(base);
>>>> +
>>>> +     regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>>>> +     if (IS_ERR(regmap))
>>>> +             return PTR_ERR(regmap);
>>>> +
>>>> +     /* Populate regmap for the regmap backed clocks */
>>>> +     for (i = 0; i < ARRAY_SIZE(c3_pll_clk_regmaps); i++)
>>>> +             c3_pll_clk_regmaps[i]->map = regmap;
>>>> +
>>>> +     for (clkid = 0; clkid < c3_pll_clks.num; clkid++) {
>>>> +             /* array might be sparse */
>>>> +             if (!c3_pll_clks.hws[clkid])
>>>> +                     continue;
>>>> +
>>>> +             ret = devm_clk_hw_register(dev, c3_pll_clks.hws[clkid]);
>>>> +             if (ret) {
>>>> +                     dev_err(dev, "Clock registration failed\n");
>>>> +                     return ret;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
>>>> +                                        &c3_pll_clks);
>>>> +}
>>>> +
>>>> +static const struct of_device_id c3_pll_clkc_match_table[] = {
>>>> +     {
>>>> +             .compatible = "amlogic,c3-pll-clkc",
>>>> +     },
>>>> +     {}
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, c3_pll_clkc_match_table);
>>>> +
>>>> +static struct platform_driver c3_pll_driver = {
>>>> +     .probe          = aml_c3_pll_probe,
>>>> +     .driver         = {
>>>> +             .name   = "c3-pll-clkc",
>>>> +             .of_match_table = c3_pll_clkc_match_table,
>>>> +     },
>>>> +};
>>>> +
>>>> +module_platform_driver(c3_pll_driver);
>>>> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>>>> +MODULE_LICENSE("GPL");
>>>> diff --git a/drivers/clk/meson/c3-pll.h b/drivers/clk/meson/c3-pll.h
>>>> new file mode 100644
>>>> index 000000000000..92a08196a46f
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/c3-pll.h
>>>> @@ -0,0 +1,35 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>>>> +/*
>>>> + * Copyright (c) 2023 Amlogic, inc.
>>>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>>>> + */
>>>> +
>>>> +#ifndef __AML_C3_PLL_H__
>>>> +#define __AML_C3_PLL_H__
>>>> +
>>>> +#define ANACTRL_FIXPLL_CTRL0                 0x0040
>>>> +#define ANACTRL_FIXPLL_CTRL4                 0x0050
>>>> +#define ANACTRL_GP0PLL_CTRL0                 0x0080
>>>> +#define ANACTRL_GP0PLL_CTRL1                 0x0084
>>>> +#define ANACTRL_GP0PLL_CTRL2                 0x0088
>>>> +#define ANACTRL_GP0PLL_CTRL3                 0x008c
>>>> +#define ANACTRL_GP0PLL_CTRL4                 0x0090
>>>> +#define ANACTRL_GP0PLL_CTRL5                 0x0094
>>>> +#define ANACTRL_GP0PLL_CTRL6                 0x0098
>>>> +#define ANACTRL_GP0PLL_STS                   0x009c
>>>> +#define ANACTRL_HIFIPLL_CTRL0                        0x0100
>>>> +#define ANACTRL_HIFIPLL_CTRL1                        0x0104
>>>> +#define ANACTRL_HIFIPLL_CTRL2                        0x0108
>>>> +#define ANACTRL_HIFIPLL_CTRL3                        0x010c
>>>> +#define ANACTRL_HIFIPLL_CTRL4                        0x0110
>>>> +#define ANACTRL_HIFIPLL_CTRL5                        0x0114
>>>> +#define ANACTRL_HIFIPLL_CTRL6                        0x0118
>>>> +#define ANACTRL_HIFIPLL_STS                  0x011c
>>>> +#define ANACTRL_MPLL_CTRL0                   0x0180
>>>> +#define ANACTRL_MPLL_CTRL1                   0x0184
>>>> +#define ANACTRL_MPLL_CTRL2                   0x0188
>>>> +#define ANACTRL_MPLL_CTRL3                   0x018c
>>>> +#define ANACTRL_MPLL_CTRL4                   0x0190
>>>> +#define ANACTRL_MPLL_STS                     0x01a4
>>>> +
>>>> +#endif  /* __AML_C3_PLL_H__ */
