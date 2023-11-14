Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06D67EAC05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjKNItt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjKNItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:49:46 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E4319D;
        Tue, 14 Nov 2023 00:49:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRlPjUVCyaCnZjD6mozEgTD4dApBznuXy/cchxqMJJChgYaWQwzdIqrsYq+x46q7pOSlB/sJ+Dldg6kGDZYoBZMC1IaLFXkTedTbdSg0l80v653IQcsUsSLwYkt1/wX9Do6qSJfR4Ca2M0+WIWnLzaVIyurLB9nyYSRa/pFuz7fPJlZaXBqNkx9v6/yN4bVXI0ybt6OhL6ZAaQ0mT+dAuoZxwwQ8+3EnrVpafdn+HQW6JCPgfGDbW906urOIiUbYd3ii/YXrsj1fasnJ8PWcX4wNpqqZ4AVUORr4OY9yo1ewpT1hoTq0mZYA38V2G1Zxjqj460WBa0c7xLhrRamt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgHZZqQVTH0FqIWkC4Iv9cV+RtEGs4uaa9GD/y0cafo=;
 b=edajuc70hUFDsTK7F4L1OY+bgKXXYSrcGA6Prkv7xRWeI47FEfUOPNszfpNz5olTNgJhF+3KwVXYty7XaP1FBJZN6s8GYJo/TFTL6GqPwtJ9fr+Y1Y9zlQq14VFLF6L8ViUlPiv6WmH280EJDGHmMh4Ui2EvH965IuQMTdHgYbOxdQsw/fY0GIOEM2iVECfHLMtaXSHc0nxdRn7sBdejTVUrDq4SN3rQXQ5Ch2h1KMo6QQ55ylWprEgtZRWiH2dp7eQSxccoGar085KlqbIc7+p2RaNObAx1Wvm6Wm1jKMPiZTl8xOO/U18wZMwpx9Vwz9pVdfsIdmb8lGjUGv3z2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgHZZqQVTH0FqIWkC4Iv9cV+RtEGs4uaa9GD/y0cafo=;
 b=zOf404rd167+xQ89XHq5OYfIPbNy9oFVAqFBK5W1gKc/PP5SYFY9Id3DZ8Zx8dUD8nA/IY8ZOsreG+5WuUA2/fJ8QzaFN3UiYvNDcMHGMTdGiRYMJewdZ9SDJdwJT3olwLhUvwBPf4JZaUsVgBg6WmSPyEvGQ81Jr6MNJV3J24Ki9kwP2OQrO0GJkbL3qXabk73KaWnaGf13tIafDqJBfFzcz7/TeyQVlKTwPfGW4lvXAWZumOcSTB/Y0QypSIepxdsrIpsNU43ctcMigeg8xCHadDxtDM5fU1R0r7GdrHZ4t9z0sfws7dxkwaMqWrveyvUjaawLUqJmnbfPpXBYwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB7171.apcprd03.prod.outlook.com (2603:1096:101:e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 08:49:37 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::31a7:e96f:8abd:9a10]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::31a7:e96f:8abd:9a10%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 08:49:37 +0000
Message-ID: <bea3c7d2-ed0d-470d-bbe6-3dc19b41fd01@amlogic.com>
Date:   Tue, 14 Nov 2023 16:49:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 2/4] dt-bindings: clock: add Amlogic C3 peripherals
 clock controller bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
References: <20231106085554.3237511-1-xianwei.zhao@amlogic.com>
 <20231106085554.3237511-3-xianwei.zhao@amlogic.com>
 <8d9ec256-fbea-4711-966c-8c68d83eeb1f@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <8d9ec256-fbea-4711-966c-8c68d83eeb1f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::14) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 37253e4d-7d02-44e3-d2e6-08dbe4eea1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBUmYL1syod5ZRE2i26cQ1tGpCK9kBdPN1soZCgs2iWTeVhxKQFOXx211qq5RXJe0oiUSK39V+nf1q4rUJxyV8o4JGqQuJRnYdKzJsnNxKORHJ1fvVMAoZzZIuTl5i9oGmvWPA5rW8TYou/96YtxaOQfhgSH9+4lsCamR9t3zM77nlBitODx+cTp6bYrfyvmzel/Xfu0sEzbdxs6l1MlrI68hhsNYWTibRQkOHDvFCgN5R6ts+DNdEwhb4MU/355xO5DoQUbQAK6dsCyYbFfZ4zQcTkUpf0H7xJ6hjmpbUzcqBmWKw9ZlNxOMGiFdbvZb3JT+UkWfpAHrToaX/OAlG85ktXD5WgicYcEdjUHk4qLRoHbVtUaJWpEwCk0km8zp7w2ze10OsGVyHDHAv23Bmde6xZvItBK1a4HrjqKyANP2X+tX6VOREUPNN6/0s91IQXesBE+SyEo6uT6jqYBton2uYi4dLaqt5eb+duFFZuJZB3pEBsi8yG+y/J+XUb1I1HvlU5m3qV9M6NyIhCBG+TGFyux26KOzB6t/o6tt2YVKjcbUXSdCV6r5pTgt2ZBHqXxpMs20lqT/QAvRpPlBjqhGUydV00ppOUIbIKJ6tSiexYpJVWpIlLgGqrEp8viw13tbnhRBPNULjrXgAAVStGmq+GiJCReq4sW3n8ktCu6DyZmeWd+tBxq4kxg6HVbgcJngm74uXNf+dXnU32eciO6Bb+3M1Me+OityMKVAGb72XfWXTcHAe6rRl0wWCPl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39850400004)(230273577357003)(230922051799003)(230173577357003)(451199024)(186009)(1800799009)(64100799003)(316002)(66946007)(66556008)(54906003)(66476007)(6486002)(6666004)(478600001)(7416002)(5660300002)(86362001)(4744005)(31696002)(36756003)(41300700001)(2906002)(8676002)(8936002)(44832011)(107886003)(38100700002)(2616005)(26005)(83380400001)(31686004)(53546011)(6506007)(6512007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlZsalZoQ2V0SU1rNEZyMmluZ3dFb1JaaGR3Y3o2MWc2ZU5acWVCN0hDQzdx?=
 =?utf-8?B?MlhIN3NXbUlLRUV5RUZkRGI0Z2FRZ1c2TDNlODRrbzZGTzZPUUN2VzZEUzVk?=
 =?utf-8?B?cFhCTC82WVN3S3ZtUkNKajRyWkd5OVh0WDBEM3plYjVzT0JhMlM5ZkQybkRx?=
 =?utf-8?B?WHM1cGMyd0hMeTVrTzhBcVFLYXF6Y0JqWk1hcDNNZ1dzTFY4SURLcndVY3B1?=
 =?utf-8?B?dWVPQnZMSnFSbkFHREk2dGE5TDVSTEhGeEFVSUlwaFdIbGxQQ0kvUisrY0ty?=
 =?utf-8?B?bm5jWWZkTkFkdU90S0JrWnJudyt5OTM3QVdMU01DY2tCSmdobWJmMGxxS2Ra?=
 =?utf-8?B?VHhQdGN3TEliVWhJaGRDbXZpaHcwUUhtS05TUk5HV1Jma2d4Nm44bitzYVl4?=
 =?utf-8?B?VkREKzFGUkdoRmdSczNYRmZzTTdDbXJ1Vk16dTRXcURIN0VIcXgydU5COWd4?=
 =?utf-8?B?Zm91VHBOSjRSQ0ovRDRpaDVDYnhSWUY4dHA3czllYW5ndG1iUjB6ZndGUURa?=
 =?utf-8?B?enpPMmVJbU54QnZSMUxvdGQ3dFcvTTk5dGN4aHRnQmFXTG5JbG1iUlQvdWph?=
 =?utf-8?B?RU02Y2dFVitRaUNYcXdUb0V5TVo5L3JmenhNSWo5cDNmbG0yTCtBeDJnSXI0?=
 =?utf-8?B?dElJLzRhR3UxOU83eFJFMzJiNE9oN2tTRlh6VVVIQ2wyeVVJaUdJSFNRKy9L?=
 =?utf-8?B?Ykx4TVF5WlR2OURZTjQ1L1d6SDNjdWg4T2t6OE1weE9Mcnd2dlpnL0s4QjBZ?=
 =?utf-8?B?dWJQRVBGY21IU3VQZGJrUEI0R3Q0c2R2UzZlM1VYWmYzUThqWU9HcFJ1TTFa?=
 =?utf-8?B?ZUdnWjZsK1JIZUFPRUdRaGVOaEkwSDcwUWxRazNzemVXNGltRUNoWklaTUlv?=
 =?utf-8?B?WmpjUnJ1cmtPWkl4aUdiVGZMeVZVVEpvdjBmeDN5d0xsaXRmWTZMZzlIeG5J?=
 =?utf-8?B?cENVODMzQkM5VCtPOUVMTSt5WWI0V0dKNnhxeGpTa1JkYjArODFYQ3ZkTWRF?=
 =?utf-8?B?cGd1RHYyYks0bGl0U1dORVUxRlVOb0tDVnpyN0ErQXlDU0pJRzI2RTJrQUt2?=
 =?utf-8?B?RDgzT0k5ajVSeGEvZ1hPczJyL29zOWdOcEVybEllT0Q1RFdkaGlmY0JjdXVi?=
 =?utf-8?B?bUxMRml3SE9sblBhYzFKYVJ6aVJzWnVvT09oQ2NzRUxZQUJrVi9BUXBnV3dt?=
 =?utf-8?B?WklGWUhmVjQrY2k4NFFFV3p1S0JuTWtHMCtib05GRDhSZndKaGkxbnNwd3pk?=
 =?utf-8?B?ZGNMSjZDZGlJbTA3bHFDM2t5c2pKNnRET0NzUkdETDVuYUV2L2U5VVFJa250?=
 =?utf-8?B?UGhidFI3ZFVDTU9sNFNsR2NZeStzN3JnQllqSUZtUUJpRnJKZEVhQ3JidVlI?=
 =?utf-8?B?dXAxY2NlaW1iSnI1Nnp0ZU1zc2Y3N0lkVWVUQmFhUHZFazJhR0ZpdnBIaWJI?=
 =?utf-8?B?S04rQXZnWlVrVVhxMHVFTnRBcTVTZnJyMXVBRzF1NnVLRGFjYWIrY1RuZGpX?=
 =?utf-8?B?NVRPS2FzUXRPY0FCUVVTa2Ztem9hV24rVlJYSzRYZGN5MmJHVW9lU1RyNVJT?=
 =?utf-8?B?SHFBK0ZJOGQ0eExYbnozbHdUb0ppQm4zWVFLYlVybWxvYi9kZ1NTaUVGQnhS?=
 =?utf-8?B?MGpWNHNvTGRhS2c5alZmcFJTWmNFTHlXZVFJYkxkR1lNMnJ2VG8wK2FCd1Jj?=
 =?utf-8?B?Y05VOHFGdkFOZjU3Y205ci9NT2tFMFdLVG54NUViVVhLaWg2MmU5dXM4THFo?=
 =?utf-8?B?YXdHQ0lSd0dYSkpXVkJxSGVrbXZ6aXV0VnZPVVpvckVmSzhqZE5Jai96czZU?=
 =?utf-8?B?N2NtUGtTYkkrek9LNWJxSENJekZCenhkWkNzRy9KNVd3MjJ3ZzY1L2g1Q1Fs?=
 =?utf-8?B?UjZlZTBxY2toSmtYTUcvUlg2N1B5UWVVczlGMmcvbkpwN3FtdzJkaXJnaDFy?=
 =?utf-8?B?dXhjVFlLenJXVlp5TU9aS0FCQnI4SitVWGhDZDNMZHNLNFRYMkdxZUZiZEZG?=
 =?utf-8?B?KzloVytiNlhqcU5CNnpUbzJrREd1WUhDNUZLcW1McGdhTEI1L0dGc1Q0YU9B?=
 =?utf-8?B?dmN3aUsxckZiZ09pRWZyeDRJbmFaUUhhM0NoaDY2MkQvZEYxWC9QMXVlaDkv?=
 =?utf-8?B?Wmc5Qnp2NWkvNVFSSE9BV00wMEUwdDZPZDJGRUFRMHpCcVZmSWUvNk1nVkI2?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37253e4d-7d02-44e3-d2e6-08dbe4eea1a0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 08:49:37.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPeVpcW4KQeKEqBOH/gCOa90FYqTW2L0dpbuhD4UyY1MMIqjMpeYs+21wMSDkw82w77u+jyWgCMn8UGoXdQJlhAWgeyyRgbfWS2cT4RCMCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
      Thanks for your reply.

On 2023/11/10 21:24, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 06/11/2023 09:55, Xianwei Zhao wrote:
>> @@ -0,0 +1,237 @@
> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> 
Will delete redundant "bindings" next version.
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H
>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H
>> +
>> +#define CLKID_PLL_SRC                                0
>> +#define CLKID_MCLK_PLL_SRC                   1
>> +#define CLKID_DDR_PLL_SRC                    2
>> +#define CLKID_DDR_PHY_SRC                       3
> 
> Fix the indentation. In all other patchses as well.
> 
Will do
> Best regards,
> Krzysztof
> 
