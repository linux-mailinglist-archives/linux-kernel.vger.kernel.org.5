Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3607EBAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjKOBNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOBNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:13:00 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2033.outbound.protection.outlook.com [40.92.103.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739CECB;
        Tue, 14 Nov 2023 17:12:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcwQsLbt9TpYZzHKnouxqZ3I+WvctIxdjEGFgoss0wtEra35eLfLeYSgYmaetQEfmfPWG4E3ufXUUpHtN3xNVPk5zbk7ZessQsFPGuqsPoEma0grpvXzAjoiAcOt6B4yinjmhOshKNcGmqyFcOQjwvLnr3eeGyqarKlkiljI2MisMM4NFpD0iRD3U+LSyQDFkQOhm32ND7Ijr8I24DXyVlyB4/cyGy9YAWll5FQQ3ckFOvHiEiKud1xDP4Mdf/gFkSqXfuj0MSzNJXtXbWA5kXEiA0cBk20jfo7wO03k/X6sKpkM6Y8BP+YlFbX8hkH8NPhbmbMHtR2p6jKO97Dg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPNzcwVTvOBWi4YQcsaKIkfPbkm4DJ4Ff/enwf6/rXo=;
 b=d/rrBtCObT25nlmls/LXpz7ZHdbFee7s+sbQZFZ1dsKxiBloRzRJcVOEnLFPKwxturO1h8CKFDsGfpkbXo4WsOoyl8QzeCj8AmWR7js10nLKQVIhxKQ+SHcbaBqNXMOm1QpOiOxMAXNZH+1XwOfyYjz2uYbJwtuz2fM9ZiqpXWrIu2awMez61iW4dYQ0J6cD/7O6E6FewaM1KgpqZy50tZgdg2akFb8fxcjTJ7lU+Jx0H35H3DhUytP8/ADDyYh5B5qyFvSj+CoP4VmMY4UKLI7uIMRDErRB44ENBG1AzDzUAkKjctVqhnCawtZajKBcrFoU73l7gkKfDx0RANXitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPNzcwVTvOBWi4YQcsaKIkfPbkm4DJ4Ff/enwf6/rXo=;
 b=uFhzGOOB4CZqDxXXiAIz2OZNYzYDCwuK+Cn1o2TWQjJb8qspJ+uCcN3vSOAB+uDhzppVMxmP1cbx1AvwVCouMeTRyFfH3fyCaeKEVUg5eQLth8MHD83DK4hIbq+vnobkVzeUVKyAR5qlvmvEOzyq8hXxxqHxTUFY2Yhq4pyIe8WtsJUc2S4OeiLzkcZl/HN4UhwkDMvcVnDDYAYFNqhTLI2+cn7DmBhx34/ju5Jq0IPMs5J9m+mcZVNriWit45Qy1icS3DscEB/lTpl25IE3dCd50wOVK/7L6AcStfWDjDZUPmYMVX+vgOEoWvirtYNwYW+mQpd9cDxc1PXh4Ie8Mw==
Received: from PN3P287MB0324.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d6::7) by
 PN2P287MB2372.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ab::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.18; Wed, 15 Nov 2023 01:12:47 +0000
Received: from PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a24:3fd5:dd38:3ecd]) by PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a24:3fd5:dd38:3ecd%4]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 01:12:47 +0000
Message-ID: <PN3P287MB0324B37658F300238640DCBAFEB1A@PN3P287MB0324.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 15 Nov 2023 09:12:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: clock: sophgo: Add SG2042 clock
 definitions
To:     Conor Dooley <conor@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <db59acdc99357d52ede5fc9738bdb161649c8fa1.1699879741.git.unicorn_wang@outlook.com>
 <20231114-spool-hemlock-f69291a8cfa4@squawk>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231114-spool-hemlock-f69291a8cfa4@squawk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [CEChej6wHWO4bZUJPbWeGI+zKGWbWR5O]
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:d6::7)
X-Microsoft-Original-Message-ID: <2d60879b-de2b-42ee-9b0d-b4c850f39559@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB0324:EE_|PN2P287MB2372:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3e9922-cf24-4837-24b8-08dbe577f9cd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13moVOEWehUEXW8xRVED509dgbsJM2lmV7jtD/i69Scf/1isRv2lmwWKC9twtMpbCRMRir14MzDZRVb0bANPz17vLOEirjT/Xs5AoAA72CW39yDvL3gSaotRxEOcEvPv9YBzBpPMr1H7GhP7LDrnS3iX4aIPl+ix+oTzaQKqABsIpi9yaaXt9iPtlNryaBWGbXYDU71E09Cv/g/JWyBv5yRqGtyFp/xtm3P2zER1Y6a5feV9/oucIz+Z/4PBa/v0qduRo2y7cQ+Sj2GYEuKrtXJR6joQ5HfrUXrYmFCmWzsvEkFB1vOO74UQz5xil4Qj/72vKekxaZztUgO9lVjWUPkl42ImbxwEDi9Qy85qJj/DAd1YnM9LPafrYH7puR11BY4emREn9FWEjifq7k4jb5lxSZD6/1eGykGYTXX6D19HZxGU2oczQrPLIhcV+KDf923BWsgJAk5tVoY2pagN1ne1g4fVA9PDiSRwbYWuAjfcqJu3X1cafTIMa2XvT9BLdFsCjh6ilyt8f85/KFFMIOXFqIvo1uThvNeE7p/CquMMfm1JEFLbL3zjX0L23pVd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEZWQ3VLb21keE96TVpkTjJTQWJuQ1FFcVByRW1lTGgyYXh1aUwxWGh4Qytu?=
 =?utf-8?B?WDQxcjQyeDlWd1RSdy96MVhmU2xLT1ZHZjd5QVlEVEQ3Q01GMTBlN2QyOSs3?=
 =?utf-8?B?STF1UklDZFBkalRqTm1maDY4bGIwUHc1SXNINi9MbHlicnhtM1FYYTBySjl6?=
 =?utf-8?B?dEZRbTk4UjZLTjNvbmpQUjc1MC9Ub1JWNytWSERobnhaa3laZEpRWnAvOWhn?=
 =?utf-8?B?MHRjR2ZnK0ZwYW1WbDJFcnIvbExPSDB3RzgzQWY4TmlMd0IrWWxZdmZmMFNN?=
 =?utf-8?B?QmJPcHVGeXo5WEF1bE1odDh0a1UvMlhZdFptVmtLUjczQXA2N2pRYWQ4cE1M?=
 =?utf-8?B?NVpEM2pGSGM2blgvUG9ONTVFcEowK0hNWnY4eUw1a1hwVWRxNTdWS3RrOUwv?=
 =?utf-8?B?YnBsUDNxVEZKZ1NHT2dNYlhGaVF2cjlTdytXQUw1OXZjOEQwczRKcE9ESjdD?=
 =?utf-8?B?NEc4dlZSbTZkMnBvZVRoR3RQeVNNd0JmSUpLT1c1SUlkNEZBclpzVFpDODdH?=
 =?utf-8?B?MkN1N25mSXRxaFp4K0xzRzNKcllOc1Y3QXFlZ3NleGZtOVhidXBySkVIajJW?=
 =?utf-8?B?bmQvZTRKTGt2MWl5S3FRd1FhU0I1VUxmNVdQZ0Fwb0htZWNlVkZEMy9wTVN4?=
 =?utf-8?B?elVHSm5EeHI3QS9RVGNSbzBiTHlLRUhEVnExL1MyVEJ4ZjRVK0FYZDNrVU5S?=
 =?utf-8?B?SXppY0VKQ3pyM1c5UXJaM2JmMnJlRk03KzQ1UW02emdkbjFIZzFpZmw3Mncz?=
 =?utf-8?B?MTJaYk16NlJkSVpIampEVktIR0JmRGQ4ckxMTTVpZUFJMWlvL3pZVEJXd1I0?=
 =?utf-8?B?d2twNG5mQ2tUZlgxelArMGtGUFFvNWNVMlorSlU1dVBGZFM2R3hnNXhFN2JX?=
 =?utf-8?B?eW9WdG5QbWtDd3hqSTZEY3B2SE9kV1BtTWQ3MkVqVm5pSEp3QXJhRGxEN29P?=
 =?utf-8?B?dEtGZVFBeHJQUExQUmhtdkhpVnpyNGpPWTFJVkZMcDg3Umd0eEJMRFczMXpM?=
 =?utf-8?B?dXhJTXlXWWYycDVZMXlXZ0liOU5XMFZyaWJJaEJiemhKRTQ2WUVYdU04OWhV?=
 =?utf-8?B?eU13b3pNNVE0RXhvMGNGY0owQUNLMG9GU3pOeGdrVTVvUTFYcDg0RU5BS0pP?=
 =?utf-8?B?UWMra2lHTkdhSWJ6QkFpdzRPb1RIUzc2N0VPK1hzbnBGZ1BCMVVONStuRTR2?=
 =?utf-8?B?a2FGa2RaYUxFK3BYdjh2Y082L3FLTTdJdHdWdUIxTktEK0E4YW1Ub3NZeUN2?=
 =?utf-8?B?b3pzUmVVaU13Rko3SHVaZEI4TTNXak1IZkdXeGFlQ2hleFRiR01WK2tqeVJV?=
 =?utf-8?B?RllHV3JqVzFITlFISnhFWGhtTDlWOTBGRU5VL1YvYU51eWFYT3NOdE5nQWkw?=
 =?utf-8?B?d1hNU0owL1FubndaTHcyNUE3aUx3WDJ6QittZDA0dkcxK29nMkJTdFFtRGlC?=
 =?utf-8?B?V21takp0WDJTSTgwS01qRWM4T3JIcnY1YWxzSTJtVEVrTEFaSkhIZVM5QUFD?=
 =?utf-8?B?eTljdmFSc2RvckNrdEJQVnMrNHNOb0wrNzdkNE56OTcyOXNHRmZHWEdjOC85?=
 =?utf-8?B?V1l6cVIrcXdnSHQrRWQrSHV6dTgxVWh6NnJzaWs0cE5WM3ZyMnJEelRrbUMr?=
 =?utf-8?Q?Kwc6LXEiGhmtxu0gWCIoTPbTUb8qPwXnpTp/sRuEluvE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3e9922-cf24-4837-24b8-08dbe577f9cd
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 01:12:47.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2372
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/15 1:35, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 09:18:25PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add all clock outputs for the Sophgo SG2042 clock generator.
> This patch can be squashed with the patch adding the binding for the
> clock controller.
>
> Cheers,
> Conor.

Thanks, I will handle this in next revision.


>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   include/dt-bindings/clock/sophgo-sg2042-clk.h | 169 ++++++++++++++++++
>>   1 file changed, 169 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/sophgo-sg2042-clk.h
>>
>> diff --git a/include/dt-bindings/clock/sophgo-sg2042-clk.h b/include/dt-bindings/clock/sophgo-sg2042-clk.h
>> new file mode 100644
>> index 000000000000..a8e05c00c3bf
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/sophgo-sg2042-clk.h
>> @@ -0,0 +1,169 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>> +/*
>> + * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__
>> +#define __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__
>> +
>> +/* Divider clocks */
>> +#define DIV_CLK_MPLL_RP_CPU_NORMAL_0 0
>> +#define DIV_CLK_MPLL_AXI_DDR_0 1
>> +#define DIV_CLK_FPLL_DDR01_1 2
>> +#define DIV_CLK_FPLL_DDR23_1 3
>> +#define DIV_CLK_FPLL_RP_CPU_NORMAL_1 4
>> +#define DIV_CLK_FPLL_50M_A53 5
>> +#define DIV_CLK_FPLL_TOP_RP_CMN_DIV2 6
>> +#define DIV_CLK_FPLL_UART_500M 7
>> +#define DIV_CLK_FPLL_AHB_LPC 8
>> +#define DIV_CLK_FPLL_EFUSE 9
>> +#define DIV_CLK_FPLL_TX_ETH0 10
>> +#define DIV_CLK_FPLL_PTP_REF_I_ETH0 11
>> +#define DIV_CLK_FPLL_REF_ETH0 12
>> +#define DIV_CLK_FPLL_EMMC 13
>> +#define DIV_CLK_FPLL_SD 14
>> +#define DIV_CLK_FPLL_TOP_AXI0 15
>> +#define DIV_CLK_FPLL_TOP_AXI_HSPERI 16
>> +#define DIV_CLK_FPLL_AXI_DDR_1 17
>> +#define DIV_CLK_FPLL_DIV_TIMER1 18
>> +#define DIV_CLK_FPLL_DIV_TIMER2 19
>> +#define DIV_CLK_FPLL_DIV_TIMER3 20
>> +#define DIV_CLK_FPLL_DIV_TIMER4 21
>> +#define DIV_CLK_FPLL_DIV_TIMER5 22
>> +#define DIV_CLK_FPLL_DIV_TIMER6 23
>> +#define DIV_CLK_FPLL_DIV_TIMER7 24
>> +#define DIV_CLK_FPLL_DIV_TIMER8 25
>> +#define DIV_CLK_FPLL_100K_EMMC 26
>> +#define DIV_CLK_FPLL_100K_SD 27
>> +#define DIV_CLK_FPLL_GPIO_DB 28
>> +#define DIV_CLK_DPLL0_DDR01_0 29
>> +#define DIV_CLK_DPLL1_DDR23_0 30
>> +
>> +/* Gate clocks */
>> +#define GATE_CLK_RP_CPU_NORMAL_DIV0 31
>> +#define GATE_CLK_AXI_DDR_DIV0 32
>> +
>> +#define GATE_CLK_RP_CPU_NORMAL_DIV1 33
>> +#define GATE_CLK_A53_50M 34
>> +#define GATE_CLK_TOP_RP_CMN_DIV2 35
>> +#define GATE_CLK_HSDMA 36
>> +#define GATE_CLK_EMMC_100M 37
>> +#define GATE_CLK_SD_100M 38
>> +#define GATE_CLK_TX_ETH0 39
>> +#define GATE_CLK_PTP_REF_I_ETH0 40
>> +#define GATE_CLK_REF_ETH0 41
>> +#define GATE_CLK_UART_500M 42
>> +#define GATE_CLK_EFUSE 43
>> +
>> +#define GATE_CLK_AHB_LPC 44
>> +#define GATE_CLK_AHB_ROM 45
>> +#define GATE_CLK_AHB_SF 46
>> +
>> +#define GATE_CLK_APB_UART 47
>> +#define GATE_CLK_APB_TIMER 48
>> +#define GATE_CLK_APB_EFUSE 49
>> +#define GATE_CLK_APB_GPIO 50
>> +#define GATE_CLK_APB_GPIO_INTR 51
>> +#define GATE_CLK_APB_SPI 52
>> +#define GATE_CLK_APB_I2C 53
>> +#define GATE_CLK_APB_WDT 54
>> +#define GATE_CLK_APB_PWM 55
>> +#define GATE_CLK_APB_RTC 56
>> +
>> +#define GATE_CLK_AXI_PCIE0 57
>> +#define GATE_CLK_AXI_PCIE1 58
>> +#define GATE_CLK_SYSDMA_AXI 59
>> +#define GATE_CLK_AXI_DBG_I2C 60
>> +#define GATE_CLK_AXI_SRAM 61
>> +#define GATE_CLK_AXI_ETH0 62
>> +#define GATE_CLK_AXI_EMMC 63
>> +#define GATE_CLK_AXI_SD 64
>> +#define GATE_CLK_TOP_AXI0 65
>> +#define GATE_CLK_TOP_AXI_HSPERI 66
>> +
>> +#define GATE_CLK_TIMER1 67
>> +#define GATE_CLK_TIMER2 68
>> +#define GATE_CLK_TIMER3 69
>> +#define GATE_CLK_TIMER4 70
>> +#define GATE_CLK_TIMER5 71
>> +#define GATE_CLK_TIMER6 72
>> +#define GATE_CLK_TIMER7 73
>> +#define GATE_CLK_TIMER8 74
>> +#define GATE_CLK_100K_EMMC 75
>> +#define GATE_CLK_100K_SD 76
>> +#define GATE_CLK_GPIO_DB 77
>> +
>> +#define GATE_CLK_AXI_DDR_DIV1 78
>> +#define GATE_CLK_DDR01_DIV1 79
>> +#define GATE_CLK_DDR23_DIV1 80
>> +/* DPLL0 */
>> +#define GATE_CLK_DDR01_DIV0 81
>> +/* DPLL1 */
>> +#define GATE_CLK_DDR23_DIV0 82
>> +
>> +#define GATE_CLK_DDR01 83
>> +#define GATE_CLK_DDR23 84
>> +#define GATE_CLK_RP_CPU_NORMAL 85
>> +#define GATE_CLK_AXI_DDR 86
>> +#define GATE_CLK_RXU0 87
>> +#define GATE_CLK_RXU1 88
>> +#define GATE_CLK_RXU2 89
>> +#define GATE_CLK_RXU3 90
>> +#define GATE_CLK_RXU4 91
>> +#define GATE_CLK_RXU5 92
>> +#define GATE_CLK_RXU6 93
>> +#define GATE_CLK_RXU7 94
>> +#define GATE_CLK_RXU8 95
>> +#define GATE_CLK_RXU9 96
>> +#define GATE_CLK_RXU10 97
>> +#define GATE_CLK_RXU11 98
>> +#define GATE_CLK_RXU12 99
>> +#define GATE_CLK_RXU13 100
>> +#define GATE_CLK_RXU14 101
>> +#define GATE_CLK_RXU15 102
>> +#define GATE_CLK_RXU16 103
>> +#define GATE_CLK_RXU17 104
>> +#define GATE_CLK_RXU18 105
>> +#define GATE_CLK_RXU19 106
>> +#define GATE_CLK_RXU20 107
>> +#define GATE_CLK_RXU21 108
>> +#define GATE_CLK_RXU22 109
>> +#define GATE_CLK_RXU23 110
>> +#define GATE_CLK_RXU24 111
>> +#define GATE_CLK_RXU25 112
>> +#define GATE_CLK_RXU26 113
>> +#define GATE_CLK_RXU27 114
>> +#define GATE_CLK_RXU28 115
>> +#define GATE_CLK_RXU29 116
>> +#define GATE_CLK_RXU30 117
>> +#define GATE_CLK_RXU31 118
>> +#define GATE_CLK_MP0 119
>> +#define GATE_CLK_MP1 120
>> +#define GATE_CLK_MP2 121
>> +#define GATE_CLK_MP3 122
>> +#define GATE_CLK_MP4 123
>> +#define GATE_CLK_MP5 124
>> +#define GATE_CLK_MP6 125
>> +#define GATE_CLK_MP7 126
>> +#define GATE_CLK_MP8 127
>> +#define GATE_CLK_MP9 128
>> +#define GATE_CLK_MP10 129
>> +#define GATE_CLK_MP11 130
>> +#define GATE_CLK_MP12 131
>> +#define GATE_CLK_MP13 132
>> +#define GATE_CLK_MP14 133
>> +#define GATE_CLK_MP15 134
>> +
>> +/* MUX clocks */
>> +#define MUX_CLK_DDR01 135
>> +#define MUX_CLK_DDR23 136
>> +#define MUX_CLK_RP_CPU_NORMAL 137
>> +#define MUX_CLK_AXI_DDR 138
>> +
>> +/* PLL clocks */
>> +#define MPLL_CLK	139
>> +#define FPLL_CLK	140
>> +#define DPLL0_CLK	141
>> +#define DPLL1_CLK	142
>> +
>> +#endif /* __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__ */
>> -- 
>> 2.25.1
>>
