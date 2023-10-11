Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DE57C47FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbjJKCu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344862AbjJKCuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:50:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B697594;
        Tue, 10 Oct 2023 19:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7ataCgcZMUcPe/0BXOioCeFLdD/ZLXFYuRmGZE7Da8/AoGm09AIoxJn99PWgpVpbFx/jm5Vghu/9US3YpiDROosIc0luvwsusrdxuDyeI53PeHaFCdNCnEdv3y3ZTMjagQxx0cHxPWAEL9tpbR5VWI2spRoliwyx/6PAwQL7ilixcaHqCQEPXI0r91JmNvhjF/21kPTY1D4PaJzXd8AkOqWZFn+P0l9TkrUeL+1xLM0OOXSKI5eyRx4opgryp+c8v48eUU8PdKFMe9VEi7PzIdbz4M8/3Xy1Iv18ghXtZJ2S7wDEgu6mBki4vcQnXb7yXN6pJOidxAbCoK9XN1BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s74HjkzSQr56YXmtVLL8mK7Q8FfFT8/LksnS8c/3y1c=;
 b=WQenpPjAvpTczNqmBTAoMEoTH7X5kU+gvK3eHpCy3/VsKWDXm5+gv3JiMLKslLIUQfaB29oDqJYeG+/ZqTT3II6baoTw6KI8cQiwkTTFENXkE8mry/fP//PGJ+6/lerVsDTvpM41XQl+0HjKs9R2PhGiZTtBm/lKjL9g5gjuG8CpGis1gyZdtA+C+I+XPay6RTBmI9ofn3tuNjoPAbOlhSg+zyTObaiU5/yPcHDJoPbz5laNvqV3r4b4vzu6wAwj7aM6A8nepGToawCOUdrS6NWAzc28Av/9XpbHcBbYzf8yUUp7PzxCLUMIfucTYV83/gdKSaedivuxuMgtiymlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s74HjkzSQr56YXmtVLL8mK7Q8FfFT8/LksnS8c/3y1c=;
 b=j5Z2nNo3ldeMbtDtpQoomKQOXXygnVLk58rEZUoAGqKdc0ZhCvZPhS/0fmMrqFDwHTfbRpZaQCbq1WlWQT5HeJPM0LKbEHb/cFpuo/MKwKlC85mDGoVD5LJsTqFml9+tSUa1iwS6UFjDlQ393xqg5oF8TOagIAhJuYtc281WESWLAanEcU6B52j6qZEj4ONA45zENS4WqsRNjNNQvv9bjk6tbiCUqtLnauEFDR6ye5uLA+R1/h98GrtAUaZrWgwdxL7JlQWdCDNEDXSJJaIcbMP/8ahKPLXYlepP1qF3OJUxeyKgBCpHtf1Go5iC3YrLbtmHxxGMOmJTSkiBBgqwcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SI2PR03MB5771.apcprd03.prod.outlook.com (2603:1096:4:150::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 02:50:12 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6%7]) with mapi id 15.20.6863.041; Wed, 11 Oct 2023
 02:50:11 +0000
Message-ID: <291f03f9-72aa-2842-b44a-c88c812df4f1@amlogic.com>
Date:   Wed, 11 Oct 2023 10:50:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 1/4] dt-bindings: clock: add Amlogic C3 PLL clock
 controller bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-2-xianwei.zhao@amlogic.com>
 <20231010132151.GA557938-robh@kernel.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20231010132151.GA557938-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SI2PR03MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee20711-979f-44cf-3f98-08dbca04c94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tA1jHiInbtT6X6HDQk3P4vDy3jmA1Jrk+YJ31Zr3r8Rsr90DI2rSfjdoUMi5EJRk1pZY8ugZoca6tXrgNHR/5C2GdIh6XZMwbBFrKt78IdX4qoCXFNt4Wqh6FxY1KVb660K5PQxTACaZpsHZE7GJWFJAxBxkc+h07f2fb+Vg6+cADG3eQQFBL1d3zInspbuD27SphhwOV9xDpK6slykuy30KGXqUCYU619OrkrW0ZSvGfnT/G8WRiI36COqMnssdPLYoiij+XuRWjBm33YW7kn5MUTPVc51TU6hHcqLwbaoZhioFtl9u6Znk+Qjv0jtYYmXLGSFRlnXlsIrcH0TsLEAoyRA8gke4moqxbCG3spCLlRzZZYfZcSxZzFBvyq3fviOxKJNUw2+HVoFnH/B4R8tFmSOs07b7HbdRCebAKdItV5cMH5xhBt+kVeVDrYfHXS5cwXfjI20w1xckQ9dZKBpFwz7AUu1ZcJIRm2EYeLes04MSKoX9KFIgxZexFCyTFgUZQ32/BrQ5sPjSSjpTDWCs2yzNuCoybtLzpD4b1Nki+qzagVBgEtdXxlCvyqMtI/3ZSGxmkSU/5eTEF51bBTNlZvOocvyA1MpEQ+7mFJ6Q0kswiXYFUomLv3Xad8lLw2DVxo+EfoDJ5Acl7nfDlwV0BtxVq0iCnl7G6obXt4zd/oHMmsmY1AY8ofdwgrz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(396003)(136003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(26005)(53546011)(2616005)(86362001)(38100700002)(36756003)(31696002)(6512007)(4326008)(2906002)(8676002)(7416002)(107886003)(8936002)(54906003)(6666004)(5660300002)(508600001)(6506007)(6916009)(966005)(66946007)(6486002)(83380400001)(316002)(41300700001)(66476007)(66556008)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFRpengyUFpUek5WcFR3OEw2OURCYTBhWXVRT2JXa2xnSjM5WlBteGpXUWhr?=
 =?utf-8?B?V09DSElNWXhhcHFDUUVKQWdkZXdOM2ZTYjlzWmhrUUowTGU5WmJSVmNZZFh5?=
 =?utf-8?B?Lzg0MnkwM09qRWdNei9Kc1JYNXBOR2FJQ2xLT2dCTjYxaC9sNzFySmxyWTYx?=
 =?utf-8?B?QTNmdmx3NXBoRENpRGRKL1N6V0duU2s4enFXY2craTJ3UVdZZ2Y2d05yVW44?=
 =?utf-8?B?Q2szbFN0THlqSTFkVUxyZGpXQnlRRmJoc2haNjZPWE95V0U3K1kwdm1LaTFF?=
 =?utf-8?B?anhVOW5nZDBFeGxwNW9YQWVKN2xPS0ErdFlHQXlzZDRLTFBJaks0Rk96Z0dU?=
 =?utf-8?B?eDFBKzBNSjhSVVlJZW1hVUJYVm5zdlR1YW80SnY0eGZzdTR2SlpPOUFZM2pp?=
 =?utf-8?B?UzFwenRNeCtHeC9BMDg3a3l1N1NoOXk5T1djVlVGNXp0QW56RjdLbkNiMVdm?=
 =?utf-8?B?Smx4SkdQWEJnVEROcElNZHU2cFdKY3BRQjhEZlJJQm9JOENBRE0wSWZQd2xX?=
 =?utf-8?B?bzRpcHppRTE4MWozRmhBRXUwRzBXT2libElLZEZtb1JCUWFBWEtTQ21TTTlN?=
 =?utf-8?B?SHJjTThEN3l2T1BHUkh2ZlFxQVN4Lzl2UHpiL0prYXJMNThud2M0ZjF5STM4?=
 =?utf-8?B?L1FpQUZ1bEhLWEJ6WVRVc3JZZSt1K0hVb0NaWkdSeE1FK2N4b3paNCszQkFq?=
 =?utf-8?B?NnN4VDdCVHN6d3piMnBxS2srU01KWXc0ODY0YldLSnFjTDU0WndZWTJSWUNF?=
 =?utf-8?B?WHBiVEZVbDVLUXFFcTJGSlZRQ25DM1NvbXJSUktXbTNqWDVBNFhrK0VkL2x5?=
 =?utf-8?B?ZlpsSHlZNkhNUDYyb2ZOdHhBTTlGWkdaRGUyYWFaNlJzODdWYUJsWC92dW1z?=
 =?utf-8?B?TE9DL0hVZ1NEZjZhUGdKcXpTQkFUMGRXZ3pwRmdzMjB1QXk3QXR3K0ZwVm1z?=
 =?utf-8?B?RXFwanpSR0VaUXVxY2tvcklOOXJBa09RcjE4NjIvblUzcVcwdy81cnZidWt0?=
 =?utf-8?B?SEswa3VEc3hqOUNIemVjdjQrTXlxK25HSlo2NmhPNHlSNG1BQU53R3ZDbkF1?=
 =?utf-8?B?ckdSU2JzUXQvZWJZRjdPYXlTU252SWVmQ1lEUFVHeTI0YmgvN01yQ2tjOVdC?=
 =?utf-8?B?MFdma3czZUJhVEE0UmtabkRFRWFFNHpOY3VKMVljVmpibUxiT21kWjFJbWxM?=
 =?utf-8?B?WDVCcHNaTFBiT3B6TkZwSFpUcUgwY0RPWllOZWNCOGpZL1pqTTE2dEE2Ny9r?=
 =?utf-8?B?ay9henE5dTJQYjA2dzZFaGU3SUxza1M1TlZYN2NUM3RHTG9TQ0c1OEgrYUlL?=
 =?utf-8?B?ZFRaU0xYaHhvSkFYV3ZQNlJqN3hRWjhyMkI5NktnSkp0TVRtNjlabEpwaTV1?=
 =?utf-8?B?Z3hoU0VYTnEvTUQ3UWE3N2Y4RVltMU9PRXFqT216S1dlOU1xSkxmNTRPR3dy?=
 =?utf-8?B?aUFoWXhYZUxKVkwrQURQWlJNQU5BSHZzT2tzSkFoWFZSMzhQR3NRYnhUcFNv?=
 =?utf-8?B?ZkZVNkpTYm03YnlRZUEvZGxuYjNzOGVQWkpFNTZXbFBZWTh4UGU5ZHdnV2pZ?=
 =?utf-8?B?SU5wTldpZUIxZnJwM2xWVmQvMzc3bzNnYkxWOEZDRzFyRGFLWU9MZXJyd2h6?=
 =?utf-8?B?aU5pRHZKdW1ROTd2OXdZYUlWK0F6NG9janI0bHFQMitzTFR3bE1BL0s3WFZQ?=
 =?utf-8?B?dUtNY2diTTE2SVYvdkIwMlB2WjBoaWlkMFNQR2EwYVdqUU5yQmJGa1I4QXh5?=
 =?utf-8?B?a2YwTXRHdXRUZ2tWZzRBaWl2bm8vZG5FbjY2QkFDeHd1S2tBNStQVFhUbDYz?=
 =?utf-8?B?ZXliRURKVXhrcDJhZUFCMnk3UUtISEFoSENlWWdUQjlpZlo4a1Q3N3lzOVdC?=
 =?utf-8?B?MWx0YjJad2VXdDc1MWRTc0xkYnkzbUwrS3BVeExZS211UkluaE5JTC9IRXU4?=
 =?utf-8?B?MzEzdEQrckgrY3lFOHFYcGpOMTczeGJnMUltbHo0QUErWjIycXd2ejJKL1lr?=
 =?utf-8?B?RzlPTm5UaUNxa0FnQWRkT0FqRFZHL2g0bHpFZVB6SXByUmxSTW9BaWRCMmJ2?=
 =?utf-8?B?Vnh3VGJyNjkzSWpKT2duSmlhcS9aUjRWc2U5NXVyV3NBZzEybUtLc2xUYm5V?=
 =?utf-8?B?ZTVBZE51OW9BbWJZZWdubkMyUFY3WWYzc0NBSjhkNWxpaEdsbWRPZmtrKzBJ?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee20711-979f-44cf-3f98-08dbca04c94f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 02:50:11.4204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgPGxfY1snTYQtwNy1OCGKA40pddhv2lKxON3iQK8MbcapvYG9AgtJmMZq0NalcXRCBEVF6POsxxAKh98r4UWfJzROllW87BohBbs5t8YgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5771
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
     Thanks for your advise.

On 2023/10/10 21:21, Rob Herring wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Oct 10, 2023 at 02:29:14PM +0800, Xianwei Zhao wrote:
>> Add the C3 PLL clock controller dt-bindings for Amlogic C3 SoC family
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>> V1 -> V2: Fix errors when check dtbinding use "make dt_binding_check"
> 
> Your patches aren't bisectable. It's fine if you want to combine patch 1
> and 2 into 1 patch. Or just use the raw numbers here instead of the
> header.
> 
I will combine patch 1 and 2 into 1 patch in V3.
>> ---
>>   .../bindings/clock/amlogic,c3-pll-clkc.yaml   | 59 +++++++++++++++++++
>>   .../dt-bindings/clock/amlogic,c3-pll-clkc.h   | 42 +++++++++++++
>>   2 files changed, 101 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>   create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>> new file mode 100644
>> index 000000000000..a646992917b7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,c3-pll-clkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic C3 serials PLL Clock Controller
> 
> s/serials/Serials/
> 
Will fix
>> +
>> +maintainers:
>> +  - Chuan Liu <chuan.liu@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,c3-pll-clkc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 1
>> +    items:
>> +      - description: input pll_in
>> +      - description: input mclk_pll_in
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    items:
>> +      - const: pll_in
>> +      - const: mclk_pll_in
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>
>> +    apb {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        clkc_pll: clock-controller@8000 {
> 
> Drop unused labels.
> 
Will delete clkc_pll.
>> +          compatible = "amlogic,c3-pll-clkc";
> 
> Your indentation is not consistent.
> 
Will fix it in V3.
>> +          reg = <0x0 0x8000 0x0 0x1a4>;
>> +          clocks = <&clkc_periphs CLKID_PLL_IN>,
>> +                   <&clkc_periphs CLKID_MCLK_PLL_IN>;
>> +          clock-names = "pll_in", "mclk_pll_in";
>> +          #clock-cells = <1>;
>> +        };
>> +    };
>> diff --git a/include/dt-bindings/clock/amlogic,c3-pll-clkc.h b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>> new file mode 100644
>> index 000000000000..aa731e8fae29
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>> @@ -0,0 +1,42 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
>> +
>> +#define CLKID_FIXED_PLL_DCO                  0
>> +#define CLKID_FIXED_PLL                              1
>> +#define CLKID_FCLK_DIV40_DIV                 2
>> +#define CLKID_FCLK_DIV40                     3
>> +#define CLKID_FCLK_DIV2_DIV                  4
>> +#define CLKID_FCLK_DIV2                              5
>> +#define CLKID_FCLK_DIV2P5_DIV                        6
>> +#define CLKID_FCLK_DIV2P5                    7
>> +#define CLKID_FCLK_DIV3_DIV                  8
>> +#define CLKID_FCLK_DIV3                              9
>> +#define CLKID_FCLK_DIV4_DIV                  10
>> +#define CLKID_FCLK_DIV4                              11
>> +#define CLKID_FCLK_DIV5_DIV                  12
>> +#define CLKID_FCLK_DIV5                              13
>> +#define CLKID_FCLK_DIV7_DIV                  14
>> +#define CLKID_FCLK_DIV7                              15
>> +#define CLKID_GP0_PLL_DCO                    16
>> +#define CLKID_GP0_PLL                                17
>> +#define CLKID_HIFI_PLL_DCO                   18
>> +#define CLKID_HIFI_PLL                               19
>> +#define CLKID_MCLK_PLL_DCO                   20
>> +#define CLKID_MCLK_PLL                               21
>> +#define CLKID_MCLK_PLL_CLK                   22
>> +#define CLKID_MCLK0_SEL                              23
>> +#define CLKID_MCLK0_SEL_OUT                  24
>> +#define CLKID_MCLK0_DIV                              25
>> +#define CLKID_MCLK0                          26
>> +#define CLKID_MCLK1_SEL                              27
>> +#define CLKID_MCLK1_SEL_OUT                  28
>> +#define CLKID_MCLK1_DIV                              29
>> +#define CLKID_MCLK1                          30
>> +
>> +#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H */
>>
>> base-commit: 57b55c76aaf1ba50ecc6dcee5cd6843dc4d85239
>> --
>> 2.37.1
>>
