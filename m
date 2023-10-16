Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C15B7C9FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJPGlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPGl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:41:29 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2135.outbound.protection.outlook.com [40.107.117.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED058E;
        Sun, 15 Oct 2023 23:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/DLTCLTJCpjYwVm8DJEor0Zw7QMmX2HRswzs4GvVFcSjZEZPlgqYfi6DkbcF5in4x5ASPrlipNjeKmbw/OrGdY2HmHlrNzhJ7qcKvwB+CXX/6cgdzKrt29aSkKkd9VXNLnfGS9xDOsrEZ6bAdqA4qXO+QXtt/hjBqLArrLKvwFE6u3QIp+pHdFMP9kBGqV91lRWE81PHRmXhBabXcXWprf0pQyqN798fUH0MYx5sElu63fy1sr5TdjB+T5oldfMhnBulXVw/hDfF59kNDDcIjkQYpS/rnQiAlA9EXvgsb4Iq+c2eXlXh5NN1jr7cMQNjP8EVuzMoTeAJ6Z3D4MhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVFK3r0GEoaXyBMF6BvTbPcXH6q6NW2aqcze9N4nl04=;
 b=NS5VMStd5noFLPRm85xzN8UZ01fEZDMfAGmoZPQvaZy2PI8FwRTh65roP21Uziis81E/OAKlUZY9c8Vk50EXrwErO2VSdB03xYjXiFFivDWFXQzJMwrhaoi+aRAiHVd0ae6ijVs5E08gnmbC5LOcURXEi3fiDkeZOZ6gH1+MGaoHwnEr5czWw3pYIvCg1EtEWOqlMyPYHw8cJZgFZze3Itb1HU2tbD0A5QJ5tAtc0HScdQXb1raktFSCaJO1SjxZvTh3MgKefe5x231d6xF5Sw1mlPdjgtPkFUb6S+f0OtrDKjDbJlOIruRMJ+dGEwsuuRCM9S7A2G5UmyKyQgs8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVFK3r0GEoaXyBMF6BvTbPcXH6q6NW2aqcze9N4nl04=;
 b=uX3XzTir5KS+gIl3CmJ5FQVFk0wt/JVL/C4e3+mn0OFaSZClKFT5C2YWzAr9nvF+5FozpES/BWdzWif0IYk2MC89syKLfT7OOXtlnYy5bjFVgXTBMW9yd0J65D7vVul2Q8ENaKAyRfjoj1fQ9TeZcxAtPM7RJT1IZIociK/B4xhpA/ZZcXOLI6Owm7p7QuBmg68HwLY2t/UYJBbZGJWRdhGN1puYOdj9hhFp3JapnJ5cA2TImsWiILm+j3hq2wV4aapS6JQbcEd4ZbfllI7xKYzr9lMNd4evej07fPujyc5J9xKRr/pV7dSpws2G0peyAHZtUxP9S5nbwTtKbisoAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SI2PR03MB5916.apcprd03.prod.outlook.com (2603:1096:4:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 06:41:21 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 06:41:21 +0000
Message-ID: <4da5dae6-6f94-9ab9-3a25-8ed7f4be30b1@amlogic.com>
Date:   Mon, 16 Oct 2023 14:41:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 1/4] dt-bindings: clock: add Amlogic C3 PLL clock
 controller bindings
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-2-xianwei.zhao@amlogic.com>
 <20231010132151.GA557938-robh@kernel.org>
 <291f03f9-72aa-2842-b44a-c88c812df4f1@amlogic.com>
 <1jr0lzvuql.fsf@starbuckisacylon.baylibre.com>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jr0lzvuql.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:404:a::29) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SI2PR03MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a66031-aefe-4344-10fb-08dbce12e7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPyKY3l12l6Eidolo/e9YY6z1dgs9QNQT5y6+ecSGtwoJ0plqFvCE9/y0pbFsH8gcHNF1mAOhMIX2fykCS//TgNbn4je6TzeVxoCXKTMVH1psBc1eSrAYtBKXF3Lye009L/rPd9LJqFf7hGHgDjVFMxkQxAg1cdFkEyCfRIj88WHE3Ra3JCkB87IA/zsEGIA+TP2VCH0Niu6nV2CcSy0CM+B+IbKqqDI9PSRpf/aljQW4vzHyAsw4HvyVBuj1H+tbGMVuSe0kDeVdeVfvmSqea0PfJ7ghtLsTJ8MtlSswlglqdEsAznAW0JY+9FozIsn2XW2+BpAixFOoDFLZpJwSLnLZ+NO1PmzyO+pPsTinuh7vuaGxMeNr73lyLiY8BBUDV7w5rFsgcCfQgaCecKtEtwORE6BdK84x9SAIxldvQFN1xkDWyg7dmkipEjHls76uRGt5cn7uQTjNH94cXU4cxp0a6n3LLfdPQdVoMn0a0iZmx006PJ2Wmd/PHLUG3z3KPMyJz1y3zO96d8+19MKtIfTDD/2RStgyp6nHz22xKarRhjlbvdpi2cjGhUECzuFD+d5XbhC6o2pJQZAl2b8KXPoUv2vKg5CaM483eM5+5x2QZiM5iRxO8iMnCI0oOpOOKefBRWKJOlKQJCDZ6NSTrZ4OqvpS0hZQ7+AUthztiR1FDfmK3Ea04+iaW0/94N9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(478600001)(966005)(6486002)(110136005)(66946007)(66476007)(54906003)(6666004)(66556008)(83380400001)(31696002)(86362001)(38100700002)(2616005)(6512007)(316002)(26005)(107886003)(53546011)(6506007)(41300700001)(44832011)(5660300002)(36756003)(8936002)(8676002)(4326008)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFF6NVRDNnlGL1ZnMlN5STJ1ZkRRdTU4Y2t2RUI0WjNhaUdRTXhKQjNSUkw0?=
 =?utf-8?B?TWlCSnovWWFhb0lwSmVOMno1WlAzRDlrRkdKT0RjSUJRaW1zVWtkcStwSlN0?=
 =?utf-8?B?QUhYb3BCbnlVa3BZRkVFQ2RwVC9TdkZTVzFVb21jUk1oNTVTeEFxZ0pFQ2Rp?=
 =?utf-8?B?dnRsYzlGeTg0WXVraGVLYW5nVUI0cGVTbXFyWTVFS1JPN0VNaTFmNUljWi9P?=
 =?utf-8?B?MzNDbmNqL2c5MFZtRjZMRzA3aWdPbmRkbDRBa0FBSlJxTkp3SVlwZ1JrUWRm?=
 =?utf-8?B?Wm03V1o1VnpQOE9CQkc2Z2wwRVJ5M25lUGlnN1QwdzNTUlQ2d0JGVkkyYlh0?=
 =?utf-8?B?ZDFJb2JpUktWWHkwWXJ6OXh5RUdFVm91MVRXdGovRVNqd3U5YUMvWXRyK2tB?=
 =?utf-8?B?Wk84SUY2eHd5SGhlK3h0SXo4YVhLSGoxM3FpZHlCY0dOWWg0d21zS1BiTWtT?=
 =?utf-8?B?azRXSnRMQ2dRVkRDbHhkeEhoTittZmtiL1pkVldmaUxqWjBFR05aUHJLR1Zj?=
 =?utf-8?B?ZFhXYjNjM28rTTBTWng5M08yU2Y0cTZ2Q0R3MmQxM1NFYXVqQU9QK1RIZ2lt?=
 =?utf-8?B?MGlHNDR2MEhzQnhSUlErd29mcGNINjhqNDcyaDNkRittTXAveDNkZTRRN2Jo?=
 =?utf-8?B?Nm1ma2hzUGxEMFpQL2JmOFRCR2kwaW41NHdkNnE3SjByZURKcEtRdEZZWnZj?=
 =?utf-8?B?RVdhWUxQYVhjWkVKdGxUTkk5NythSit2WFk5bG9GbDdIL20yM0g4R1JVYkFr?=
 =?utf-8?B?YUhsVUlxa3J6OFlxa0Jwa3JmN0k3MDk5bFV6eUZxTW9VaWp4UkJCVnpFTVpZ?=
 =?utf-8?B?NUNMWDVDbzRRYnR3clpMQVZLWUtpZzJYOUE1NG9UTWtySU5hU2hQb2RPYmFn?=
 =?utf-8?B?MVZneS8reFNMd2N5R0JFZkdkOGhsOURud1RSZUlxakJsZEovSEI1c2d5T3d0?=
 =?utf-8?B?NElOY1hpNVJObm9PNGkrQVlNaVprdlJWTnl4czBXcUhjWDY4STVYVWdlSWZs?=
 =?utf-8?B?TTFUSTBuOG1kKzVNT1NFeEQxOGdqUnV5MzdMSnAySTdOWlVXTngwMzJLOVRp?=
 =?utf-8?B?WTNVNlBEQVdHUzlXUzhMMWFHRndHSjltb0VVNS9RTWUyY1VlNUdJb3NGNVRH?=
 =?utf-8?B?TjJSL2VUU0p4K0hwOUdabm5qOXU3a3BQUml6c2NZcTJNMTh2Zy90MStrWG1H?=
 =?utf-8?B?bWEvTGNVRmZHUnU5NjlmSUsxOVVRaER6bC96NVV6dmh6ak9UQU9weEpRM0x0?=
 =?utf-8?B?YUpCSWhNOVRiMFcwUUZWQU41NkNaa3A3dWdtTkRqWmRLdHpLeS9jMjlmaURF?=
 =?utf-8?B?K25JdHRnL2V1eERhaE9XNlF4dFl1Q2NUZ0JCR1o3QkVoWTQyaUlkWmNhODhV?=
 =?utf-8?B?WDBYS2NpbDg2VitCajFuL294UVhDaUlJTkx5R1BFaUE3US9lbnRVS29HcHhl?=
 =?utf-8?B?MUVVV3YybEE0dmRVZlpKR3U3dlhoWnFQNE1XMm1aZ0NSd3g5aFJTR0YxT2lv?=
 =?utf-8?B?RjYrMHR5Z2JseXhOM0RTYUtOOTdnSkk1WkR1dHdKdmkrREpZeHZqQ25oVStZ?=
 =?utf-8?B?eTArUVVDb3BkWnZIWTdXUkx5SWYxL3ZzSERnNUVTUjRLbW1BbHlNNDZQaWhI?=
 =?utf-8?B?UFZ0U3kzSk1qcWVOU0psMDBLUjBqVytzQ1VjZmJCa3Z2Y2tVL1J4MnYxQXFT?=
 =?utf-8?B?aVByMEdFakFvenpST0Z4RFB4TVExMlVqSXFZaHI4c0tJZW41TkRoZ3Uva29B?=
 =?utf-8?B?dHVTR2FpbUlTMXhvdGpwWnlMNUZwSEdEUUtZR3VmN0kyS3BpOVl6SjZPMElX?=
 =?utf-8?B?bno3ODByVlBaeTJtZE5wNkE4d1VtU0ZUOEpoeGQrZ29Wb2JYZVVvMi9UU2JS?=
 =?utf-8?B?QVpkUXdmUVcxUnhoZ2ovSVcySWw5dkJVY2xjL3NIdmxuamgwT0QvZGI0M3BC?=
 =?utf-8?B?eGU0a290dmR4K0w3dmtLOXFVRXZNU1hUVEU3dWtKOVZaRWt1KzI3NW1jZ3ph?=
 =?utf-8?B?dGpmeU5KbHU5bWJjZEE5aG83VW1sZUQ3cGdVdGt5eVJsZXJTMW9VOHN0RzBR?=
 =?utf-8?B?WEJlTmZyRkdQN01BQ2FVUnZYYVNwenN6V2pVdHZTTGhkczh0aXQ1V2pUQzgv?=
 =?utf-8?B?Y3duYzM3Rko5cmE0YTAveVMrVis1TkhaNGhFZHR6YUZRYVFpaG1BSHFIakEy?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a66031-aefe-4344-10fb-08dbce12e7c1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 06:41:19.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cd3cBD1WCMFdKb2Ze5Ezq9LX/YD9Rr4MO48COWBU5vNyVI2kxhiK2GgWfzR/R+T7l2yqLvKCag9Q9iccPx+HIRPFnsvAjV4HCElenUcIAXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5916
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,
     Thanks for your reply.

On 2023/10/13 15:35, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 11 Oct 2023 at 10:50, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> 
>> Hi Rob,
>>      Thanks for your advise.
>>
>> On 2023/10/10 21:21, Rob Herring wrote:
>>> [ EXTERNAL EMAIL ]
>>> On Tue, Oct 10, 2023 at 02:29:14PM +0800, Xianwei Zhao wrote:
>>>> Add the C3 PLL clock controller dt-bindings for Amlogic C3 SoC family
>>>>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> ---
>>>> V1 -> V2: Fix errors when check dtbinding use "make dt_binding_check"
>>> Your patches aren't bisectable. It's fine if you want to combine patch 1
>>> and 2 into 1 patch. Or just use the raw numbers here instead of the
>>> header.
>>>
>> I will combine patch 1 and 2 into 1 patch in V3.
> 
> I'd prefer if you used raw ids or even fake node for the example, like
> <&pll_in> and <&mpll_in> for readability, rather than combining the patches
> 
Will do.
>>>> ---
>>>>    .../bindings/clock/amlogic,c3-pll-clkc.yaml   | 59 +++++++++++++++++++
>>>>    .../dt-bindings/clock/amlogic,c3-pll-clkc.h   | 42 +++++++++++++
>>>>    2 files changed, 101 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>>    create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>> new file mode 100644
>>>> index 000000000000..a646992917b7
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>> @@ -0,0 +1,59 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/amlogic,c3-pll-clkc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Amlogic C3 serials PLL Clock Controller
>>> s/serials/Serials/
>>>
>> Will fix
>>>> +
>>>> +maintainers:
>>>> +  - Chuan Liu <chuan.liu@amlogic.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: amlogic,c3-pll-clkc
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    minItems: 1
>>>> +    items:
>>>> +      - description: input pll_in
>>>> +      - description: input mclk_pll_in
>>>> +
>>>> +  clock-names:
>>>> +    minItems: 1
>>>> +    items:
>>>> +      - const: pll_in
>>>> +      - const: mclk_pll_in
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
>>>> +    #include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>
>>>> +    apb {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +
>>>> +        clkc_pll: clock-controller@8000 {
>>> Drop unused labels.
>>>
>> Will delete clkc_pll.
>>>> +          compatible = "amlogic,c3-pll-clkc";
>>> Your indentation is not consistent.
>>>
>> Will fix it in V3.
>>>> +          reg = <0x0 0x8000 0x0 0x1a4>;
>>>> +          clocks = <&clkc_periphs CLKID_PLL_IN>,
>>>> +                   <&clkc_periphs CLKID_MCLK_PLL_IN>;
>>>> +          clock-names = "pll_in", "mclk_pll_in";
>>>> +          #clock-cells = <1>;
>>>> +        };
>>>> +    };
>>>> diff --git a/include/dt-bindings/clock/amlogic,c3-pll-clkc.h b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>>>> new file mode 100644
>>>> index 000000000000..aa731e8fae29
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>>>> @@ -0,0 +1,42 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>>>> +/*
>>>> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
>>>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>>>> + */
>>>> +
>>>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
>>>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
>>>> +
>>>> +#define CLKID_FIXED_PLL_DCO                  0
>>>> +#define CLKID_FIXED_PLL                              1
>>>> +#define CLKID_FCLK_DIV40_DIV                 2
>>>> +#define CLKID_FCLK_DIV40                     3
>>>> +#define CLKID_FCLK_DIV2_DIV                  4
>>>> +#define CLKID_FCLK_DIV2                              5
>>>> +#define CLKID_FCLK_DIV2P5_DIV                        6
>>>> +#define CLKID_FCLK_DIV2P5                    7
>>>> +#define CLKID_FCLK_DIV3_DIV                  8
>>>> +#define CLKID_FCLK_DIV3                              9
>>>> +#define CLKID_FCLK_DIV4_DIV                  10
>>>> +#define CLKID_FCLK_DIV4                              11
>>>> +#define CLKID_FCLK_DIV5_DIV                  12
>>>> +#define CLKID_FCLK_DIV5                              13
>>>> +#define CLKID_FCLK_DIV7_DIV                  14
>>>> +#define CLKID_FCLK_DIV7                              15
>>>> +#define CLKID_GP0_PLL_DCO                    16
>>>> +#define CLKID_GP0_PLL                                17
>>>> +#define CLKID_HIFI_PLL_DCO                   18
>>>> +#define CLKID_HIFI_PLL                               19
>>>> +#define CLKID_MCLK_PLL_DCO                   20
>>>> +#define CLKID_MCLK_PLL                               21
>>>> +#define CLKID_MCLK_PLL_CLK                   22
>>>> +#define CLKID_MCLK0_SEL                              23
>>>> +#define CLKID_MCLK0_SEL_OUT                  24
>>>> +#define CLKID_MCLK0_DIV                              25
>>>> +#define CLKID_MCLK0                          26
>>>> +#define CLKID_MCLK1_SEL                              27
>>>> +#define CLKID_MCLK1_SEL_OUT                  28
>>>> +#define CLKID_MCLK1_DIV                              29
>>>> +#define CLKID_MCLK1                          30
>>>> +
>>>> +#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H */
>>>>
>>>> base-commit: 57b55c76aaf1ba50ecc6dcee5cd6843dc4d85239
>>>> --
>>>> 2.37.1
>>>>
> 
