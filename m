Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DCF78657D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbjHXCgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbjHXCgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:36:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714ED1AD;
        Wed, 23 Aug 2023 19:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPd+lP9ulH0akAIlNXJIX+Sak1cK5yiI4ujiWlA6MO+Wl9yTpIUlkSq/4velA/slRRfQmmdZ+Ff003hX7Gw0SaWMdZ+i+dqq0F4DwHWXVhMcADk2+rNdvPxyvFIhfavrVYAjFqB/1VfPj1c5kijM7Bd4SmnkNPbSEloUunuPXnQnGb9bmxdtkvUPSjM6B83M1f5TS5uvTolMbvUpCgGM33e0PjR7YEmTKttddP8aapXf/fx/C9vrWGoY/S04kLxZLaIJAhzTGVAx/gYtVchbV5VWSpzn3nkxK0230CPO9GcSMwb8NVaqsoD/IvgpH4/YZVsBT74Vq3bjjR9cqnBsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Gt58MMLJ2HEDNvg6fscJjf1+Mr+t8ICgAEJpqfIoYg=;
 b=OTj8BE7Thc8Au1KwQRhOkx9rOI0GCb5nnwaxq0cjR9q+ya8anogen4FZRxnMc8gQW6IPYVP2MCokvrjSg5rfYHrmLJjb3kNWwFzrLb5dy5qAPCGJJvh5bB2vzHYgDkdKAyZNHmEfywHSoo7ky+7wQpHgLMbOPmtlIXh5I/dVlcC/4FcCdg4rkMj/kCPsce4SxtCXNVzlc5BMKLXxBYrpbqKDnI8AZSso90AFgjzw9P/hc8wsNpSfumegsm8GBBJMcKGmK2yRBaQoe/DghHpqBUds4sK55eLkhRyxuZiF6yedkLid6OLP8uLlZaDon/ZLRN4d4xQ/5miqgG6+tash9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Gt58MMLJ2HEDNvg6fscJjf1+Mr+t8ICgAEJpqfIoYg=;
 b=lpvemQjZYjZaIRe8RkoUM/whIwyFMmXXdyBLvWfhpAZblk5d+TAAKJRw8gjUyvpt2aJf3V0mwCRDbfmrHQwPIctBuCtT7Q6KDqI8zGYEj3nYxpvYtYsc7DHLhiwsp7MqK3l88HpO3AjlumxkM61MZB7HJpNXdPE3LSTFksD6/PrpLqWaUHVPU+zblr46jiuync01gSGUh7MTyaQJgsGOCwPimca8lKe6x4cYqXLori4R3leFu5cuyjfk9XEZcEZZqEYGokaYcOa5dS3/Xtv0ZDhQCdVx+JQjR9oPhyFpLO/rBSWmTYrxZNUXxjniNcP0fZ2+9vmDTK+24ci5UTC3xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 PUZPR03MB6187.apcprd03.prod.outlook.com (2603:1096:301:ba::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 02:36:04 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed%4]) with mapi id 15.20.6678.029; Thu, 24 Aug 2023
 02:36:04 +0000
Message-ID: <a132b5d3-ae93-6ba6-e324-130897567477@amlogic.com>
Date:   Thu, 24 Aug 2023 10:35:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V10 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
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
 <20230822082750.27633-3-yu.tu@amlogic.com>
 <1jbkey9obf.fsf@starbuckisacylon.baylibre.com>
 <3fa20b2f-c87f-1896-7d6d-a72b5e8aa6ba@amlogic.com>
 <1j350a9ksj.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1j350a9ksj.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0086.apcprd02.prod.outlook.com
 (2603:1096:4:90::26) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|PUZPR03MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: b742655d-9dbb-47c2-ded7-08dba44adc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLbnFaVO+qOT0M1Zqj3pAfT3kGhjeDX4Jf15w8HnWnaobKJXDheeFiEuEsc2p879LqJ4a00XyYB8yu26GGuZHYzq/AsjxunDMiQ7e0aoBrNH3uYzhbN0iTbP14dHua70NS8XnHyM5jQC6V3z6IcfxCLmfX82CHl2RqPguFqV0/2x2lcU/nMnoHCWOOVs/2DGTppiVusQmsxzodN3LTCnkLpxp6g96JaP4cyAF1AphHEr+OEb2OW+v7uHCjjG31I2bx/zeuU/p1kB5gOcZgDfVtBbavMyp15sJHhyZeBfX2t3H2o502z4u/UxqUzibUFTKjsbCcf0xq6vdhzKJJG+XtreB9Y7PnSbQtUtIAwakh2zCVxVy9Rsx5sS7I8F4Lv4F/ZPh4RiPZg3CyD0PWXxsBhIpVFkr3M6j4NVvRqWe0E+kJb9cxN5A8nE13ukLlXPFtgTLpKOHeq/if5wUnteRZs9xeBARx4eHbSVfNPFiacp5nbcINyEJ0YaxRBBJ1X8ORcM2fHmJLTSH61+RwFWQ+TQuHBJUN15CHIHh5sVx4TjnmOdremQNkvKmeaAdoRozz2amjpi7zxS7D8gwobkFiCW2u+ybVuQpAVL9KynPKJOxipYy/Qk5be6KdMiuPzvGAisxNdAtDqUp3SPURORQcVoHQzeutio4Aq41B7pMiN6pmO2ZlESR5FLOlywl4s/OUaELgcP6eMjeZEpGX5YKqntCTFahxJehRaSaisGrmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(136003)(366004)(376002)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(107886003)(4326008)(8936002)(8676002)(36756003)(30864003)(2906002)(83380400001)(7416002)(44832011)(26005)(921005)(6666004)(38100700002)(66946007)(66556008)(66476007)(316002)(110136005)(478600001)(12101799020)(966005)(31686004)(41300700001)(6512007)(6506007)(86362001)(53546011)(31696002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0JDdGdORU4zc0hYUlgzcHFqbDJDSUVSVmdxNUlTcEMvVFJ0ang1eXBQYXla?=
 =?utf-8?B?WTh5dWxBNzRtUURUN3Rza3BoMFpwMUFOYktqN3I5ZVhwdFhNQmR1czRheUFh?=
 =?utf-8?B?aVR1cnVKcTlYYU9va1duMzZCL1gxaklNTVhGTSt5dTc1WFVNbkdaMCtZVGVy?=
 =?utf-8?B?YllCSEI0dkhtR2pwLzlrUkZ3OTRrZjV3SXhYTHpOSlFJYUxoL1Z5NTdDUDBy?=
 =?utf-8?B?WFBKQmJQM3B2RmV6ekdrU2RTd0NkZ3VFV1ZoVnBpbHVWczB1U0tCYTFFZnph?=
 =?utf-8?B?cWFxc1JoREg1NzN0bi95eGZPa3pwS21TSjBmdlJzbDAxKzB2MWUrWGdGU2VQ?=
 =?utf-8?B?TUl4bSt3Qk56eDVvYStQWk9sWEJEd3dGaDQyN0JpYzU1aE1BRUZHdzJlOUdt?=
 =?utf-8?B?WkkxUmZVQ3pGYkN1a0pndWdyK3A5R3dCWExzZjZLczU3MjZrQlBMU21TVVVu?=
 =?utf-8?B?MC9xc09uN3ZGYU0vYVBQUDRZSzVpWXhlMldvRWdQV0JFeWpOQmtHLzdYeW9X?=
 =?utf-8?B?ZGdNVkptNWp4alNUcTFna3E0K0tzQVlXQ3RBT3dNU3NuTlBNckVmVTA5L1JK?=
 =?utf-8?B?dDh6a0NSOGVJNy9PbGpzY3JOZjF2M1RJMWFFNE1zM0RMS2JOZTRnUjJrSE1E?=
 =?utf-8?B?UEU3Mm5HSkltdnE4a09vVzNEUW5DNUpPRE81YzRZY09EMlJ0NWNXbVBQOHNO?=
 =?utf-8?B?eFdDVEtRbFNYbHpYYkhVc3F1NHlyUGVGd2pjTlNjVFFGWEpOWUpXWGFWbEJj?=
 =?utf-8?B?a2I2TTRsYml2c095VURlN0UxMzV5dDBRT2VZajdRUklEQWJLYXZXVCsyWTVS?=
 =?utf-8?B?WWFrYWZ6S3Rlci9xRmIxVWxHVnUyWDlLMXJyT3pvWFJONWVTcDI1Y0VySlZV?=
 =?utf-8?B?QitMUW1wNkUrRHZYb21hejRJVVBnQnpoVkowUzNxWE83K29nUDJJWjF6YWVh?=
 =?utf-8?B?eU8xMEdNNHhlVWVpMW9OVkpMMi9wVzlpdFhrZHdvQ3k2SzUxUVBCc1FuV29O?=
 =?utf-8?B?VXlvNlArN1RDanNhYWkvRThQN2xtYUZuNExHMTJHdUJxMjJaRVYvVm0vRUN6?=
 =?utf-8?B?OUE0dkUxbjVSeGhVMmwxMTlzUG13c1gxTlViZkk4bjFnMEF1bUJUbmFqQUg0?=
 =?utf-8?B?Y0ZlSkJGV2dSSStNS0FnRDhWL0lJaUgvMFI0aE1Zdkl3cHR0bGxiT1NDamta?=
 =?utf-8?B?TW1xanljNnR6U0lzaDRoMUIrRkl6U050MjR5bnhYQzJ1UWVVSFVMOE05S1VH?=
 =?utf-8?B?bjNyY2ptTXZ1UmErRUVFbFFqY3JyLzd6T2krN1BlQitvOFBVL0VLSXRodW1a?=
 =?utf-8?B?ZVgvUUtVdFVqbnNSRDJJSjZBbkw3Z0I5WUxBamtVcGxXTUxoT0FlL084TVZa?=
 =?utf-8?B?TmY5ZzFiU2h5SkhjYmhkN043N0tvRm1QSzZqNm1naXJhdXJ0ZXFCVFFDdzU4?=
 =?utf-8?B?VEZPVWNqQW44ZndFVFIvVGhtT0J3ZFQxNHVnZm9iMmpBaEgrSENoM3N2RjZ2?=
 =?utf-8?B?Uy9kOERFODhtTllBUFYxd3A5SmtBRFdlN0EwTkZycWZtWG44RDAwYVZ4UEVC?=
 =?utf-8?B?dWNnSU4rQUk0WFJoc3F6R0w1a2J5bFVqL1BVT2xJVnROWWtGeXVzckpvYm9T?=
 =?utf-8?B?VkhhWHRwK1lUbTR2dTgrcEVWRkRJcUJHNitWQWM3YTltYXIrWWJpcHhLTytS?=
 =?utf-8?B?RG5oKzNveDUxSGh2N3p3UVFBenRNNXFhWkRwaEdqS3VhSVVlRFhTU2wwTGFP?=
 =?utf-8?B?RnJkSWFWTXJINE9XNEZLdWhVMnpkUVlyaXRibzNYN1lnbDdiOHhDWGpLZXBq?=
 =?utf-8?B?djJkUmlpc0J5R04xMFNxQzVyaER5cGhYYXVtTFNHblVyVmNLdmJRK2JhRzBG?=
 =?utf-8?B?ZjE3bVlxVGgxOVhmZHFiQkVhdE03QVNRR3B4UDhzVUd1YkdqZmg5NlZQZFl6?=
 =?utf-8?B?SjdjNXFSVXAyZE9RUGRZVjZsanhMU21sQmplVHR4SCsvaDR1WjF0cGJNcStS?=
 =?utf-8?B?dWwyOU1rUzNVbDRzRUJKQTZBbXhMTHN6S2lVYnh6dXYrUlR3MWFISTBnRERn?=
 =?utf-8?B?NWhTTGs0TlJ1cG0wZ1RoWW1nSHZFdnQrVGhjZzlIUG5JSnB6NUR0aklYNkFu?=
 =?utf-8?Q?jVI8Mg6D9PJ2XiWEUQUhfP3dZ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b742655d-9dbb-47c2-ded7-08dba44adc29
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 02:36:04.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dpi/NxclVBDJTW6yqp46flq/+klcebRsT2vx+fQQ1qCacCVNHOmnEqzrurVmDqyHDKskkEVwGlLyGqV6U0gd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6187
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/23 17:14, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 23 Aug 2023 at 16:32, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> On 2023/8/23 16:01, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>> On Tue 22 Aug 2023 at 16:27, Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>>> Add the S4 peripherals clock controller dt-bindings in the S4 SoC
>>>> family.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    .../clock/amlogic,s4-peripherals-clkc.yaml    |  96 +++++++
>>>>    .../clock/amlogic,s4-peripherals-clkc.h       | 236 ++++++++++++++++++
>>>>    2 files changed, 332 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>>>    create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>>> new file mode 100644
>>>> index 000000000000..e166563e7b14
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>>> @@ -0,0 +1,96 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-peripherals-clkc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Amlogic S4 Peripherals Clock Controller
>>>> +
>>>> +maintainers:
>>>> +  - Yu Tu <yu.tu@amlogic.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: amlogic,s4-peripherals-clkc
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: input fixed pll div2
>>>> +      - description: input fixed pll div2p5
>>>> +      - description: input fixed pll div3
>>>> +      - description: input fixed pll div4
>>>> +      - description: input fixed pll div5
>>>> +      - description: input fixed pll div7
>>>> +      - description: input hifi pll
>>>> +      - description: input gp0 pll
>>>> +      - description: input mpll0
>>>> +      - description: input mpll1
>>>> +      - description: input mpll2
>>>> +      - description: input mpll3
>>>> +      - description: input hdmi pll
>>>> +      - description: input oscillator (usually at 24MHz)
>>>> +      - description: input external 32kHz reference (optional)
>>> The bindings described here does not make this last clock optional, but
>>> requires it. This is going to be a problem since most platforms won't
>>> have this clock.
>>
>> Hi Jerome,
>>        Do you mean that we can delete the description of "external 32kHz",
>>        because we hardly use it?
> 
> Absolutely not.
> Optional ressources need description too.

OKay. I got it.

> 
>>
>>> You are missing minItems.
>>> Same below
>>
>> I will add it in next version.
>>
> 
> I'm saying that because you did not provide minItems here, it gets
> implicitly set to the number of clocks you have declared, making the
> external 32k a required clock, not an optional one.
> 
> You need to set minItems so the clocks is actually optional.
> Try removing the 32k in your example below and check how it goes with
> 'make dt_binding_check'

thank you I see. I tried. I had to follow your advice, or there'd be a 
warning.

> 
>>>
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: fclk_div2
>>>> +      - const: fclk_div2p5
>>>> +      - const: fclk_div3
>>>> +      - const: fclk_div4
>>>> +      - const: fclk_div5
>>>> +      - const: fclk_div7
>>>> +      - const: hifi_pll
>>>> +      - const: gp0_pll
>>>> +      - const: mpll0
>>>> +      - const: mpll1
>>>> +      - const: mpll2
>>>> +      - const: mpll3
>>>> +      - const: hdmi_pll
>>>> +      - const: xtal
>>>> +      - const: ext_32k
>>>> +
>>>> +  "#clock-cells":
>>>> +    const: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - "#clock-cells"
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>>> +
>>>> +    clkc_periphs: clock-controller@fe000000 {
>>>> +      compatible = "amlogic,s4-peripherals-clkc";
>>>> +      reg = <0xfe000000 0x49c>;
>>>> +      clocks = <&clkc_pll 3>,
>>>> +              <&clkc_pll 13>,
>>>> +              <&clkc_pll 5>,
>>>> +              <&clkc_pll 7>,
>>>> +              <&clkc_pll 9>,
>>>> +              <&clkc_pll 11>,
>>>> +              <&clkc_pll 17>,
>>>> +              <&clkc_pll 15>,
>>>> +              <&clkc_pll 25>,
>>>> +              <&clkc_pll 27>,
>>>> +              <&clkc_pll 29>,
>>>> +              <&clkc_pll 31>,
>>>> +              <&clkc_pll 20>,
>>>> +              <&xtal>,
>>>> +              <&ext_32k>;
>>>> +      clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3", "fclk_div4",
>>>> +                    "fclk_div5", "fclk_div7", "hifi_pll", "gp0_pll",
>>>> +                    "mpll0", "mpll1", "mpll2", "mpll3", "hdmi_pll", "xtal",
>>>> +                    "ext_32k";
>>>> +      #clock-cells = <1>;
>>>> +    };
>>>> +...
>>>> diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>> new file mode 100644
>>>> index 000000000000..861a331963ac
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>>> @@ -0,0 +1,236 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>>>> +/*
>>>> + * Copyright (c) 2022-2023 Amlogic, Inc. All rights reserved.
>>>> + * Author: Yu Tu <yu.tu@amlogic.com>
>>>> + */
>>>> +
>>>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>>>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>>>> +
>>>> +#define CLKID_RTC_32K_CLKIN          0
>>>> +#define CLKID_RTC_32K_DIV            1
>>>> +#define CLKID_RTC_32K_SEL            2
>>>> +#define CLKID_RTC_32K_XATL           3
>>>> +#define CLKID_RTC                    4
>>>> +#define CLKID_SYS_CLK_B_SEL          5
>>>> +#define CLKID_SYS_CLK_B_DIV          6
>>>> +#define CLKID_SYS_CLK_B                      7
>>>> +#define CLKID_SYS_CLK_A_SEL          8
>>>> +#define CLKID_SYS_CLK_A_DIV          9
>>>> +#define CLKID_SYS_CLK_A                      10
>>>> +#define CLKID_SYS                    11
>>>> +#define CLKID_CECA_32K_CLKIN         12
>>>> +#define CLKID_CECA_32K_DIV           13
>>>> +#define CLKID_CECA_32K_SEL_PRE               14
>>>> +#define CLKID_CECA_32K_SEL           15
>>>> +#define CLKID_CECA_32K_CLKOUT                16
>>>> +#define CLKID_CECB_32K_CLKIN         17
>>>> +#define CLKID_CECB_32K_DIV           18
>>>> +#define CLKID_CECB_32K_SEL_PRE               19
>>>> +#define CLKID_CECB_32K_SEL           20
>>>> +#define CLKID_CECB_32K_CLKOUT                21
>>>> +#define CLKID_SC_CLK_SEL             22
>>>> +#define CLKID_SC_CLK_DIV             23
>>>> +#define CLKID_SC                     24
>>>> +#define CLKID_12_24M                 25
>>>> +#define CLKID_12M_CLK_DIV            26
>>>> +#define CLKID_12_24M_CLK_SEL         27
>>>> +#define CLKID_VID_PLL_DIV            28
>>>> +#define CLKID_VID_PLL_SEL            29
>>>> +#define CLKID_VID_PLL                        30
>>>> +#define CLKID_VCLK_SEL                       31
>>>> +#define CLKID_VCLK2_SEL                      32
>>>> +#define CLKID_VCLK_INPUT             33
>>>> +#define CLKID_VCLK2_INPUT            34
>>>> +#define CLKID_VCLK_DIV                       35
>>>> +#define CLKID_VCLK2_DIV                      36
>>>> +#define CLKID_VCLK                   37
>>>> +#define CLKID_VCLK2                  38
>>>> +#define CLKID_VCLK_DIV1                      39
>>>> +#define CLKID_VCLK_DIV2_EN           40
>>>> +#define CLKID_VCLK_DIV4_EN           41
>>>> +#define CLKID_VCLK_DIV6_EN           42
>>>> +#define CLKID_VCLK_DIV12_EN          43
>>>> +#define CLKID_VCLK2_DIV1             44
>>>> +#define CLKID_VCLK2_DIV2_EN          45
>>>> +#define CLKID_VCLK2_DIV4_EN          46
>>>> +#define CLKID_VCLK2_DIV6_EN          47
>>>> +#define CLKID_VCLK2_DIV12_EN         48
>>>> +#define CLKID_VCLK_DIV2                      49
>>>> +#define CLKID_VCLK_DIV4                      50
>>>> +#define CLKID_VCLK_DIV6                      51
>>>> +#define CLKID_VCLK_DIV12             52
>>>> +#define CLKID_VCLK2_DIV2             53
>>>> +#define CLKID_VCLK2_DIV4             54
>>>> +#define CLKID_VCLK2_DIV6             55
>>>> +#define CLKID_VCLK2_DIV12            56
>>>> +#define CLKID_CTS_ENCI_SEL           57
>>>> +#define CLKID_CTS_ENCP_SEL           58
>>>> +#define CLKID_CTS_VDAC_SEL           59
>>>> +#define CLKID_HDMI_TX_SEL            60
>>>> +#define CLKID_CTS_ENCI                       61
>>>> +#define CLKID_CTS_ENCP                       62
>>>> +#define CLKID_CTS_VDAC                       63
>>>> +#define CLKID_HDMI_TX                        64
>>>> +#define CLKID_HDMI_SEL                       65
>>>> +#define CLKID_HDMI_DIV                       66
>>>> +#define CLKID_HDMI                   67
>>>> +#define CLKID_TS_CLK_DIV             68
>>>> +#define CLKID_TS                     69
>>>> +#define CLKID_MALI_0_SEL             70
>>>> +#define CLKID_MALI_0_DIV             71
>>>> +#define CLKID_MALI_0                 72
>>>> +#define CLKID_MALI_1_SEL             73
>>>> +#define CLKID_MALI_1_DIV             74
>>>> +#define CLKID_MALI_1                 75
>>>> +#define CLKID_MALI_SEL                       76
>>>> +#define CLKID_VDEC_P0_SEL            77
>>>> +#define CLKID_VDEC_P0_DIV            78
>>>> +#define CLKID_VDEC_P0                        79
>>>> +#define CLKID_VDEC_P1_SEL            80
>>>> +#define CLKID_VDEC_P1_DIV            81
>>>> +#define CLKID_VDEC_P1                        82
>>>> +#define CLKID_VDEC_SEL                       83
>>>> +#define CLKID_HEVCF_P0_SEL           84
>>>> +#define CLKID_HEVCF_P0_DIV           85
>>>> +#define CLKID_HEVCF_P0                       86
>>>> +#define CLKID_HEVCF_P1_SEL           87
>>>> +#define CLKID_HEVCF_P1_DIV           88
>>>> +#define CLKID_HEVCF_P1                       89
>>>> +#define CLKID_HEVCF_SEL                      90
>>>> +#define CLKID_VPU_0_SEL                      91
>>>> +#define CLKID_VPU_0_DIV                      92
>>>> +#define CLKID_VPU_0                  93
>>>> +#define CLKID_VPU_1_SEL                      94
>>>> +#define CLKID_VPU_1_DIV                      95
>>>> +#define CLKID_VPU_1                  96
>>>> +#define CLKID_VPU                    97
>>>> +#define CLKID_VPU_CLKB_TMP_SEL               98
>>>> +#define CLKID_VPU_CLKB_TMP_DIV               99
>>>> +#define CLKID_VPU_CLKB_TMP           100
>>>> +#define CLKID_VPU_CLKB_DIV           101
>>>> +#define CLKID_VPU_CLKB                       102
>>>> +#define CLKID_VPU_CLKC_P0_SEL                103
>>>> +#define CLKID_VPU_CLKC_P0_DIV                104
>>>> +#define CLKID_VPU_CLKC_P0            105
>>>> +#define CLKID_VPU_CLKC_P1_SEL                106
>>>> +#define CLKID_VPU_CLKC_P1_DIV                107
>>>> +#define CLKID_VPU_CLKC_P1            108
>>>> +#define CLKID_VPU_CLKC_SEL           109
>>>> +#define CLKID_VAPB_0_SEL             110
>>>> +#define CLKID_VAPB_0_DIV             111
>>>> +#define CLKID_VAPB_0                 112
>>>> +#define CLKID_VAPB_1_SEL             113
>>>> +#define CLKID_VAPB_1_DIV             114
>>>> +#define CLKID_VAPB_1                 115
>>>> +#define CLKID_VAPB                   116
>>>> +#define CLKID_GE2D                   117
>>>> +#define CLKID_VDIN_MEAS_SEL          118
>>>> +#define CLKID_VDIN_MEAS_DIV          119
>>>> +#define CLKID_VDIN_MEAS                      120
>>>> +#define CLKID_SD_EMMC_C_CLK_SEL              121
>>>> +#define CLKID_SD_EMMC_C_CLK_DIV              122
>>>> +#define CLKID_SD_EMMC_C                      123
>>>> +#define CLKID_SD_EMMC_A_CLK_SEL              124
>>>> +#define CLKID_SD_EMMC_A_CLK_DIV              125
>>>> +#define CLKID_SD_EMMC_A                      126
>>>> +#define CLKID_SD_EMMC_B_CLK_SEL              127
>>>> +#define CLKID_SD_EMMC_B_CLK_DIV              128
>>>> +#define CLKID_SD_EMMC_B                      129
>>>> +#define CLKID_SPICC0_SEL             130
>>>> +#define CLKID_SPICC0_DIV             131
>>>> +#define CLKID_SPICC0_EN                      132
>>>> +#define CLKID_PWM_A_SEL                      133
>>>> +#define CLKID_PWM_A_DIV                      134
>>>> +#define CLKID_PWM_A                  135
>>>> +#define CLKID_PWM_B_SEL                      136
>>>> +#define CLKID_PWM_B_DIV                      137
>>>> +#define CLKID_PWM_B                  138
>>>> +#define CLKID_PWM_C_SEL                      139
>>>> +#define CLKID_PWM_C_DIV                      140
>>>> +#define CLKID_PWM_C                  141
>>>> +#define CLKID_PWM_D_SEL                      142
>>>> +#define CLKID_PWM_D_DIV                      143
>>>> +#define CLKID_PWM_D                  144
>>>> +#define CLKID_PWM_E_SEL                      145
>>>> +#define CLKID_PWM_E_DIV                      146
>>>> +#define CLKID_PWM_E                  147
>>>> +#define CLKID_PWM_F_SEL                      148
>>>> +#define CLKID_PWM_F_DIV                      149
>>>> +#define CLKID_PWM_F                  150
>>>> +#define CLKID_PWM_G_SEL                      151
>>>> +#define CLKID_PWM_G_DIV                      152
>>>> +#define CLKID_PWM_G                  153
>>>> +#define CLKID_PWM_H_SEL                      154
>>>> +#define CLKID_PWM_H_DIV                      155
>>>> +#define CLKID_PWM_H                  156
>>>> +#define CLKID_PWM_I_SEL                      157
>>>> +#define CLKID_PWM_I_DIV                      158
>>>> +#define CLKID_PWM_I                  159
>>>> +#define CLKID_PWM_J_SEL                      160
>>>> +#define CLKID_PWM_J_DIV                      161
>>>> +#define CLKID_PWM_J                  162
>>>> +#define CLKID_SARADC_SEL             163
>>>> +#define CLKID_SARADC_DIV             164
>>>> +#define CLKID_SARADC                 165
>>>> +#define CLKID_GEN_SEL                        166
>>>> +#define CLKID_GEN_DIV                        167
>>>> +#define CLKID_GEN                    168
>>>> +#define CLKID_DDR                    169
>>>> +#define CLKID_DOS                    170
>>>> +#define CLKID_ETHPHY                 171
>>>> +#define CLKID_MALI                   172
>>>> +#define CLKID_AOCPU                  173
>>>> +#define CLKID_AUCPU                  174
>>>> +#define CLKID_CEC                    175
>>>> +#define CLKID_SDEMMC_A                       176
>>>> +#define CLKID_SDEMMC_B                       177
>>>> +#define CLKID_NAND                   178
>>>> +#define CLKID_SMARTCARD                      179
>>>> +#define CLKID_ACODEC                 180
>>>> +#define CLKID_SPIFC                  181
>>>> +#define CLKID_MSR                    182
>>>> +#define CLKID_IR_CTRL                        183
>>>> +#define CLKID_AUDIO                  184
>>>> +#define CLKID_ETH                    185
>>>> +#define CLKID_UART_A                 186
>>>> +#define CLKID_UART_B                 187
>>>> +#define CLKID_UART_C                 188
>>>> +#define CLKID_UART_D                 189
>>>> +#define CLKID_UART_E                 190
>>>> +#define CLKID_AIFIFO                 191
>>>> +#define CLKID_TS_DDR                 192
>>>> +#define CLKID_TS_PLL                 193
>>>> +#define CLKID_G2D                    194
>>>> +#define CLKID_SPICC0                 195
>>>> +#define CLKID_SPICC1                 196
>>>> +#define CLKID_USB                    197
>>>> +#define CLKID_I2C_M_A                        198
>>>> +#define CLKID_I2C_M_B                        199
>>>> +#define CLKID_I2C_M_C                        200
>>>> +#define CLKID_I2C_M_D                        201
>>>> +#define CLKID_I2C_M_E                        202
>>>> +#define CLKID_HDMITX_APB             203
>>>> +#define CLKID_I2C_S_A                        204
>>>> +#define CLKID_USB1_TO_DDR            205
>>>> +#define CLKID_HDCP22                 206
>>>> +#define CLKID_MMC_APB                        207
>>>> +#define CLKID_RSA                    208
>>>> +#define CLKID_CPU_DEBUG                      209
>>>> +#define CLKID_VPU_INTR                       210
>>>> +#define CLKID_DEMOD                  211
>>>> +#define CLKID_SAR_ADC                        212
>>>> +#define CLKID_GIC                    213
>>>> +#define CLKID_PWM_AB                 214
>>>> +#define CLKID_PWM_CD                 215
>>>> +#define CLKID_PWM_EF                 216
>>>> +#define CLKID_PWM_GH                 217
>>>> +#define CLKID_PWM_IJ                 218
>>>> +#define CLKID_HDCP22_ESMCLK_SEL              219
>>>> +#define CLKID_HDCP22_ESMCLK_DIV              220
>>>> +#define CLKID_HDCP22_ESMCLK          221
>>>> +#define CLKID_HDCP22_SKPCLK_SEL              222
>>>> +#define CLKID_HDCP22_SKPCLK_DIV              223
>>>> +#define CLKID_HDCP22_SKPCLK          224
>>>> +
>>>> +#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */
>>>
> 
