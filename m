Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029947FEE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbjK3LnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3LnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:43:01 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2020.outbound.protection.outlook.com [40.92.103.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0293D93;
        Thu, 30 Nov 2023 03:43:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc6/bU0GIpO1Qd9E36+DUEClhVdmdwJROnCele7drX6tZncYHbYG+hffdn2BbZaiT520UYTnObVIbIxzzfkz025nVpoBOt42M41gn2vyXrHY5w0I3dcU4yHsGLuZz4JmSuFcG1xNW8U1X1My6oxgsmy1ccJGYibK+PmdW2Ahw8q1HkFDVGBO5HDXMwMpxsAPvkLPhR7PD9f3GTBXkRtz1ocA+M3HOJow2LOUEyQLNh2I9nXhz0Le9iLMQrgDcvC4L6VI9SDoyvh5K+1yZeGQEAPcZJNGkb9qh9KypcCt6u+x1u/DixIkYh+xZIIo9PDLH6MCa0ta8qOD2sHb9vb6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqpi8/f7bc9QFD4IgK4psVMD31YGvEDFP2wT8JLe1E0=;
 b=gK+wOri9WONcqTNM++f4qrXUPq9AfhGYDPe8zztAnhNgDf32AMxaRJfkiA5sdgTe0y8hKBsMAPAPxkO0o7PXPz0LpaqWZdW4LEZB7m53hEghW8biWmwp1jjzo+XtnwRrdnFT2jtG2JYXsZ6l4idfn7GrIbJWEvBq19ZC78zGLWfBCtbuSiDr7SRW6OIUc2/Flb1IPNa+F2mQmzpgCjmP+EntFSChmDExIoGr07GvtIrap1PrXVxN0U8tCc7piPnOhOZUzEvcn+MlqLtC4ggFFE8UjeJngD3zHOodQRUUp0/LQmseNY/Aw2u7aDkSMINBK2WFDfkQavXKYOVxuciJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqpi8/f7bc9QFD4IgK4psVMD31YGvEDFP2wT8JLe1E0=;
 b=os48WJPO1z9yMfgb+pEA3SJVhbjy7tL/UtAdgpkBmyEVWw3Y5DTYB2SkJwDhjDvQU2MsN+rX3V+ieo6rPfFEx/3dywOi0N9nx0L+HZrnS1Lt2X1F7+KjUEM32YBRYUM+6vF9sxGSSkNrIfeGoxAKksg66z1J1Jt2DuYOcersV3ydNMQ9bt4DYu5BUxMnN49eweMBbyMSFwZE9y1jMHsiOGXXDzjC1jm0UIqBx4XIebDY4ow9ewTZRmY3RAtVsRHL9Ww/MGrqLSENj+YIDVGJqSNqRG9FNJ5TnQ03NrYgYDyK49SllYuExg2IH8IU5vX7Ma+BPhYeavc37AErNY6e2g==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB1736.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:18a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.22; Thu, 30 Nov 2023 11:42:58 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 11:42:58 +0000
Message-ID: <MA0P287MB03329AE180378E1A2E034374FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Thu, 30 Nov 2023 19:42:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: sophgo: Add SG2042 clock generator driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
References: <cover.1701044106.git.unicorn_wang@outlook.com>
 <c06130afb4bdc1890b4e8d29388fa6feef1f1826.1701044106.git.unicorn_wang@outlook.com>
 <81d421c8-bfd6-42b5-9da1-f067792f8f48@linaro.org>
 <MA0P287MB03329CFBA3BB6A4E4F322F99FEBDA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <2a268c8c-ce55-4321-b390-092b8df61407@linaro.org>
 <MA0P287MB03320824AB953465E00394FEFE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <15a46a91-d539-4580-b676-1177fc0530a5@linaro.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <15a46a91-d539-4580-b676-1177fc0530a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [TXfuQSj0T+gkn6Tk4QI+/V5ezLs1NFQl]
X-ClientProxiedBy: TY2PR0101CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::17) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <3660fab2-da2a-4dca-9753-580b3fc7fabf@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB1736:EE_
X-MS-Office365-Filtering-Correlation-Id: 447bdfb5-a8fd-4e89-75b3-08dbf1997fb3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpWul07E8pr5nvDKiCVVBo7ghSbmbobkkHgYv/PnFU0Z4xqHLjh6+4PF/+tzCEnkZ1oab/eD0BNsf+gwBBepe7TfJIOOOgfbhZWK+QJX9Q/qUr6tpG2j9A+8+euvoxaeZXKAVAs3j84Te65pLX3qxWgJtA7kN55zc5u+q4xWW7Xxyh/k1fqOy4V+TadUrA4KJPHQ8gw1CRww0+z8nqAY8bvXfJZGf7Z6B3aaEL6QLq7f7KVriRcwre14Eokq2D3BbAb8LELEp4UujDPiuGk3K/lKwSZ67qBSirQo3dk25qdv7pLtBJWywhoznL3RlpQBX1mhYif8P2foJJdhdJ8XVily85Hhh9CAR/hYdLOXRb6yn0QGk3qQNcNQ5WQgV0wsjTw1N+3Q1V5hVq0eCxRGTKXLsTZmbnp+tbCE4oL7XPluFKK19bPHcOfugkW8q8xiWWu9n8u5lpGOY5Dv7MSnkwZhe9nrr/YvUHxEiX+duxbwTLRK9c/FIISbbBQHIi2EcoUFZEVY/OEchsKue3iXUVr7hNo7oNI/J2y/L3i9fDBnWUlv4aX2cXPCKXQEPgvb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWNJTHI4L1dKMVRHKytvTnlUQ3hNeTREVUlBUEIvZW5VQUJ5eS9mZldFaXRT?=
 =?utf-8?B?VC9nQ2ZmTTZDemFHeGJyUVFJT0t0VEMyOW9VYUhoMDdDaFpLby9mQ3FFVStE?=
 =?utf-8?B?cGMyVjM1bEdIV2h4UFI2aGxOMVlpRmk5d05Jd2s0WVhvZElIeDQwVUE2UVpT?=
 =?utf-8?B?ajNLVEtrNEVCYWZnL2FBa3d2bVkvbTkzZjJOZGJRVzZ6WEgzeWhja1o2cERL?=
 =?utf-8?B?M09MZkhZdGlNMGpHZkFxWlhsUFc1cEhWNXdvdjE2ZjdpelZLaS9JOS9DV3F3?=
 =?utf-8?B?aTBRN29GcmsxS0lBWTMrK2ZsVkQvYlhhNUtvWndlTDArVHVHZzdoSHNBL2RH?=
 =?utf-8?B?aVFVd0lSS1NBUW9rNHBtUWlmVnBmcXcrQWNUQjZMRkpvNXB3MjdXQlZwWlBv?=
 =?utf-8?B?Q1hOdFpHTzBON01MRlhJWFlnME05bzF3dGlHQVZkSjhwb3YwNENpNDU3Mjhh?=
 =?utf-8?B?VEp0VVdXa0dtK1EyeW9nWGx2YlFiTGpuYTJ3cUdkVEJVVzBSTk9GZzA3ejBB?=
 =?utf-8?B?NlhzblBPT1R4ZzN2NE5sVTJmaHZuRFh2UCs0d2F4UnpGaGtHdG45TVZCdldJ?=
 =?utf-8?B?dVB6bDZoSEJROTF4Q3N5R2owSm5DRk9QY2R2N0x2VFlNL1FkalZHSGx3V3k3?=
 =?utf-8?B?a1prczBGcjF4S2UwbFg3U2t1NHp3eWJTOFJ6WTFvajhaTmQyVENDVERuOWRn?=
 =?utf-8?B?RlJLeE1YOVZObVdtYkw4YmwvcWRDdDczMHN5ZUp1ejQ1Wmx4OUxEb0pvbmMr?=
 =?utf-8?B?WjBJKzJVSHR6S0t1cTNJaEg4Z25kamFzNzI1OWI4ZVZOWDhXQVlXL3A1Q3pw?=
 =?utf-8?B?U2pqemlIMzFwTjNGOGJxSmZWbVgxU1IwOXVhNEhza3g2OXdkbG5kcXFwVmNq?=
 =?utf-8?B?cFNwZG41UlhJRHdHZ2NBeEprRVpoalZ3ZnRKZlkwNDZ3YVZMN2h0MVdyeFYw?=
 =?utf-8?B?WWNDYUo1RzJ1RVNDSTN3VHQvblIyNGpjTllnOGdIS1kwNnMrTjJLd3VXT0dt?=
 =?utf-8?B?dzhJSFhNRWxrcFNUeFdCUGRrVG0rQlNvc0U2Q2FGNGtwUmdWMlM3MjJJalFk?=
 =?utf-8?B?UkRKazFkZlgrUFV5eUc2c3hsSGU4Z1Z3M1JscVpPQ2djQUhXaXloZ0xHZndX?=
 =?utf-8?B?b25ERSs5YkRtR2pJVWNZeCtCNGlrdzNYamxLakltRnFYLzRzbDB6L3c5bUZ3?=
 =?utf-8?B?K3BRZnZCQnpTaG9qa2taTnVjSitIcFMyWnhzd1ArWEZXWHZWNmowUTJxOVZ4?=
 =?utf-8?B?K2twV0QxaGFpckM5OGU3eGRjQTlMNTFuZXBKeDlYdEhOVjMvaWNZcTMrbDFN?=
 =?utf-8?B?MGV5VEJaU0M1RmhqLy9qUGlLaCswbUlUOWhUUFMvNDRJTmZ1djJSVjF4S00r?=
 =?utf-8?B?eW9JLysvdXRJcStRcFpwand2dFV4K0ErSm5oNFZSWENkcmR2azBJTkNtaW5h?=
 =?utf-8?B?eUdpZ0YwaUVJekh6UUs4a1FZQ1A4ZjdBYmh1bEUyOFlIU1hkNy9SNThVMmd2?=
 =?utf-8?B?aVorbkpkc05uQlpGVFg3aTdLbjdyeUxFdzI0eWJvNWVqV1RNaGZTb2pmMHBO?=
 =?utf-8?B?c0JFbC9TL3p1eW1Eek1wc0s1SEFvdTNrVUloSTZMc2JoZEd4TnNNMWdYM2po?=
 =?utf-8?Q?5W9AZiQxRwqt9gZAn/4FtaOzfhzXmLpNY76F4hzpj2R0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447bdfb5-a8fd-4e89-75b3-08dbf1997fb3
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 11:42:58.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1736
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/30 16:01, Krzysztof Kozlowski wrote:
> On 30/11/2023 07:37, Chen Wang wrote:
>> On 2023/11/27 17:16, Krzysztof Kozlowski wrote:
>>> On 27/11/2023 09:07, Chen Wang wrote:
>>>> On 2023/11/27 15:12, Krzysztof Kozlowski wrote:
>>>>> On 27/11/2023 02:15, Chen Wang wrote:
>>>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>>>
>>>>>> Add a driver for the SOPHGO SG2042 clock generator.
>>>>>>
>>>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>>> ...
>>>>>
>>>>> +}
>>>>> +
>>>>> +CLK_OF_DECLARE(sg2042_clk, "sophgo,sg2042-clkgen", sg2042_clk_init);
>>>>> No, this should be platform device. It's a child of another device, so
>>>>> you cannot use other way of init ordering.
>>>> hi, Krzysztof,
>>>>
>>>> Thanks for your review.
>>>>
>>>> I don't quite understand your opinion. Do you mean CLK_OF_DECLARE is
>>>> only used for platform device so it can not be use here? But I think
>>> No, I meant you mix init ordering: you depend now on syscon earlier
>>> initcall than CLK_OF_DECLARE. Do you remember which one is first? If
>>> anything changes here, your driver is broken. There is no dependency, no
>>> probe deferral.
>> hi, Krzysztof,
>>
>> I found that the initcall method cannot be used for the clock controller
>> of sg2042. We need to initialize the clock earlier because there are two
>> dw-apb-timers in sg2042 (Sorry, I have not added them in the current DTS
>> of sg2042, will be submitted later). The initialization of these timers
>> (timer_probe()) depends on the initialization of the clock controller.
>> If we use the initcall mechanism, it will be too late for the timer. So
>> it seems better to use CLK_OF_DECLARE provided by CCF.
> Sure, that's fine, but don't use syscon in such case.
Yes, syscon is inappropriate. As per suggestion from Conor in anther 
email, I will define a sg2042 specific sysctl to handle this.
>
>> I have a question here that I would like to discuss. The design of
>> sg2042 is like this, according to the design of memorymap in its TRM:
>>
>> 070:3001:0000 ~ 070:3001:0FFF SYS_CTRL 4K
>> 070:3001:1000 ~ 070:3001:1FFF PINMUX 4K
>> 070:3001:2000 ~ 070:3001:2FFF CLOCK 4K
>> 070:3001:3000 ~ 070:3001:3FFF RESET 4K
>>
>> But also as per hw design (I don't know why and I don't like it also :(
>> ), some of the PLL/GATE CLOCK control registers are defined in the scope
>> of SYS_CTRL, and others are defined in the scope of CLOCK. That's why in
>> the current code, I define the syscon node corresponding to SYS_CTRL.
>> The purpose is just to get the regmap of syscon for the clock controller
>> through the device tree (through device_node_to_regmap()), so that the
>> syscon defined in SYS_CTRL can be accessed through the regmap from
>> clock. The clock controller driver itself does not rely on other
>> operations of syscon.
>>
>> So based on the above analysis, is it still necessary for us to define
>> the clock controller as a child node of syscon? In the version v1 of
>> this patch, I actually did not define the clock controller as a child
>> node of syscon, but only accessed syscon through the phandle method. [1]
> I have impression you ask me if your solution is ok, but I already
> pointed the problem. Address the problem - how do you enforce ordering
> of syscon and CLK_OF_DECLARE? What initcalls are both?
>
>> After more read of the TRM, I believe this situation only exists for
>> clock. That is to say, there will be only one child node of clook under
>> syscon. From a hardware design perspective, CLOCK and SYS_CTRL are two
>> different blocks. So I think it is better to restore the original
>> method, that is, restore clock and syscon to nodes of the same level,
>> and let clock use phandle to access syscon.
>>
>> What do you think or do you have any good suggestions?
>
> Best regards,
> Krzysztof
>
