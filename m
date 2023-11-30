Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83D17FE949
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbjK3GiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3GiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:38:08 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2089.outbound.protection.outlook.com [40.92.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A59CA3;
        Wed, 29 Nov 2023 22:38:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEARcJvMZ15c644taDkHmqlE3IzKHnEqiPG5sHagibo8QysDwipwHo++801aPAxPSA5ic9PfcP6Je11vED4XgVOHSXTTGiLbAaTPfGvVmI5FEGwO3bPUU0VoCO79MDWydDj0xMHZ8DPhV7Zwa1NDJ8WQhEj62is+MErPD/Kb3pUnepVd+LpmYcSEsTey1sGDpasz0tfvShisAHl+Z3LIHtnliy1XQHevgq7ZPWWnsBkwJL0C5bBx16LGYakorX/NNKi+Z6ZL03U7JzTKUZfwgMHnFukxmmyT2LHpEsnjXZ2qWwvITxueqkamf1oaVAqpdZnNc7uAwr+UuZlHEPpCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFUnN5+Z/T+3Sn/F8l87wL+5TkPSteAcYQs0rK6dcaw=;
 b=Ag+cnllIVeMGa+xK+Qou2r1vfbK+ywNXASl65AFJR2aSz1+ZWaJh6wd85wQ8tqUzmC7jFvIz6tmBcrJtW/j0OaKAnM3f3+f8066wvt8NuK5gBKlkBdc9BocL1NnE6B9gQfJg9Ay8fghc2jezl6Rpf9sccjdXTiOE+QXsVLQS9shghj/RbBN5YK4RE8AG9hvCU/nWyuUU04thEsOHv3IBJLUVmiTTOqY+Z0USS4PiakkIfCb/FkdMJN/DMzLhmDfPvPMylzngODTUIKpI131RoMjgs9MTYtkaADkCFdqxVSPdMYVETcHNwqr/YrB7zIl7IQGaJ9WYarCUBp/R0T6iHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFUnN5+Z/T+3Sn/F8l87wL+5TkPSteAcYQs0rK6dcaw=;
 b=er7nT+LxFYKmy96nXKw1gmLdasT0T1OfsmHzWWmwhOFa0x6N1I/JC+3zfdIdXmERcSVXXqpe3qAYyONKIwjMEZByyreFIgkr4oW9gF8F2wRazKgOkDz4hGTMObe6ZJT/mgkV17ZFMwiD5RvRow7JMeYWpXsPGEfaDzpvqIQynReB74Ca0Yy0JoVMluYchuzw/GuT0Sp0v3kIKyrKvtRaFkY2yVwUlLxmwljVets7TTIKdcNy+OozvGFPCnWp5ZtTMeZx5fNUNi+PPHqByTKw4uU6IUaSIRqDGq1SuqiBFtnngp/JmA+x9/ZD8p0Uz544iquMpmxE7bkldjsCues3Lw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB0133.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:da::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Thu, 30 Nov 2023 06:38:04 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 06:38:04 +0000
Message-ID: <MA0P287MB03320824AB953465E00394FEFE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Thu, 30 Nov 2023 14:37:53 +0800
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
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <2a268c8c-ce55-4321-b390-092b8df61407@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [Z5PXKzV1h+cLQJ62JNHz8SqROQojsi9c]
X-ClientProxiedBy: SE2P216CA0014.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::11) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <bf84cebd-fe99-4977-a9b4-c0863e211b3e@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB0133:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6c8fae-9f95-40c1-d67d-08dbf16ee6e1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFfcfx6+Mx+qWbwUDl/Ltvv5SiE7+Mb41+EgF4iPKbWjVLPR/sI2NyvxkF7V3mi5bLwzD/BqYEB0H0XSdYXkBl88CeA4vmvF5aPzONYFZOpYzGNIT9WSYN8Ywknr+G3TtbyAWR6fFCb7SDdT3NUUntwX0+cfqCAZQie+5gTwXGGLallI4XgBicgdcln4PKYtlfSujnBMo4Ah19c6UCYO+svIoUO/IIKRw54NAlZykDstYrKLUuDMK/S+y0+ORAC/d781/WiEZHp0Fgmt7+neItK+rqjQIZ1q9SCh0v6Yu6vVqhACPqMQaVjxHisycGSGfkFmk5R5cyhDSCKZfRU7i/oaeg4AjoP9xkPPjUPRpW8Mp3ABSt4OWuJQKzJ77xWfUz01owc/6SgPRDjumQbafOcQ7/xpRQIA333zGaSdnOGEbzV6UJsUSHjNgwkxlHH1kZAVWTkCsekTH9L+Zw50fOQOE3zFtxSA5qEq3q/koRJMxHt8Ue8Nx9VR6bqHjChtphXlCAaH/YSN9qW8pVcU7N45Br1Tl2Jao+gr2HYWdt3LnhLCINu+IoDBtxYKbnRALUQlKmFlR5kL9vzUG2s5/T3CHiS0L3Tgdx1G8N2NVEo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlFCVUJoZ0YrclM1eklOeUZueDZnN0RjSDN0QlJBZzhYL2ViWU5sb2gwUXND?=
 =?utf-8?B?bGY3QzM5UDlhM3EzME9VbENnc0daYWZuRlRTSDFoWWlqNXJDc2hyT3ZSbHFt?=
 =?utf-8?B?Ykt5YlJ4bENHSW9ENmMvYVJVVVBNVGlrZlMvc2Z3L1k4eVcvdG0xS1UxcE5L?=
 =?utf-8?B?dHhZMUQveldXZjhkZHdTWDgrWGd5L1dWeWROdlEzNlUzZFFqelZBaUJFWW4w?=
 =?utf-8?B?Ti9KWEE2WEloMTVyZmtFUXFOTU04RG5PbWVRNzNUZ3ppWHhma2xEemkxZDVQ?=
 =?utf-8?B?Mll1a2ZUMm9lUHZzYzFyOHJvbEZuMTVrYklzT3l4d0o5S0k5cWdMbzNoeGJ6?=
 =?utf-8?B?N2lna0xuWFZ6RDFkRFFrWU1TN1dyamxabGFZTEpoN0JQb1pxQlhrTmNyY0Vo?=
 =?utf-8?B?WG1qN21sNEcvOUlLNE5OdlJpSmRpN1R1T25hclhXcFZ3NHd0VVBlMlZnVUUw?=
 =?utf-8?B?RDJQZ3FqZzQvNzlQejZ3K1dKbEJHUTFSZWlXRkJGUXZWdUJSUy9yWnRON0J3?=
 =?utf-8?B?eG85MXphY1JYV2IyWjRIbXp3UUN1Rk5XWUdQTVZMNzlpY25uNHQwL1pUY2l2?=
 =?utf-8?B?Z0pLNE5kRENVUWYrQUJGT0dVdlRnZ09XTnA3TjQ1bjZuS1IrekhTbEVRM0dB?=
 =?utf-8?B?NytBaHNNNnJ3TWZ1VFVtSDI1UHVGdVR2NHFYQ0pCMlRUZEhaYjF5cEtzeXdZ?=
 =?utf-8?B?NkV3Z3U4bjAwVW5lRWNVK1VvSVBvV0FvdnFwUy9FZFFtOUFGanNWejNrbTNu?=
 =?utf-8?B?MHlNTU1tVDRtMFhCVkg4SUdSWjZGMWhZQjRpQ3pmWlNiZTUxcmlYNXRRaHM1?=
 =?utf-8?B?UXk3TkJaWk0wSHRHOVVwck52NE9DeTZZS29wWEh4QnJiR2F0T20weHJuTG5y?=
 =?utf-8?B?ZjhnVlVBNTdrN2tFM3ZnenZ5RWwwQmJoa2NadzBkSDJXR2Q3VUhjcWNCQ1Y5?=
 =?utf-8?B?NXhGZUg0Qmo5YU84NCtJVy9IcGJMSW90K3RPU1Y4a01CVk85cmFzcDZGNEQ5?=
 =?utf-8?B?eXhrN2ZHY2Y2M3lNWUc4N2FLRmV6M1BXOVJtVDY4a1p6L2ZtaUVpZ0prUG9Z?=
 =?utf-8?B?YUpvNHFRVWZUaWNWZjN1U2IyZy9pQnltZm43bHB2YmY5bWZPU0lwbjA3RVRD?=
 =?utf-8?B?dVlFQWhxQkNJMnhibWlWS1FCNHJxbTZ4U1NJeXZnU3ltSlpMSGNmTVMvWHBq?=
 =?utf-8?B?b3pzcTBPeWZjT2thd3lwQ1dudmJ4bkFRUnVQVFVKZFo2MVhrVVNQbEYwWmVR?=
 =?utf-8?B?Y0YvZkl5SUwzaTkrdEdUYWlsc0pyelFsaXZ2YXdWYm5zZDM4S3JyQUo3ZWFK?=
 =?utf-8?B?OVlrN05nVlVJZmlxVWRHdHBzc2REMDV6VXFrK1l4WXJYbk9qcnRWS2xpaVVJ?=
 =?utf-8?B?cVZOTXppR3lUSGNiY2JsSWtlNjhMbzF1OEs4Z2tRSnkxSllUeks1M2wyWjdS?=
 =?utf-8?B?VWI0Q0EycVFqa2M4QUxtR3lIZ3lySWlvSDNZUU1VZkhwRVI3eXV5bk9CSytn?=
 =?utf-8?B?VFd4bkxFMkJqUnBqVXoxaEJPK3BSeXpTL3RWM2pDeFkxWFd2S2o5cFFvOGdu?=
 =?utf-8?B?QjkrMWRSb091NS9Vb2V4ZkpzcVQyekZkYmR3QUkxYXRvQkJya2dXR0lvRnp0?=
 =?utf-8?Q?2NiZOA0pyoXh7w/tTWfinMcwLOZDKeWT57cQN7yDmfvM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6c8fae-9f95-40c1-d67d-08dbf16ee6e1
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 06:38:04.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0133
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/27 17:16, Krzysztof Kozlowski wrote:
> On 27/11/2023 09:07, Chen Wang wrote:
>> On 2023/11/27 15:12, Krzysztof Kozlowski wrote:
>>> On 27/11/2023 02:15, Chen Wang wrote:
>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>
>>>> Add a driver for the SOPHGO SG2042 clock generator.
>>>>
>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> ...
>>>
>>> +}
>>> +
>>> +CLK_OF_DECLARE(sg2042_clk, "sophgo,sg2042-clkgen", sg2042_clk_init);
>>> No, this should be platform device. It's a child of another device, so
>>> you cannot use other way of init ordering.
>> hi, Krzysztof,
>>
>> Thanks for your review.
>>
>> I don't quite understand your opinion. Do you mean CLK_OF_DECLARE is
>> only used for platform device so it can not be use here? But I think
> No, I meant you mix init ordering: you depend now on syscon earlier
> initcall than CLK_OF_DECLARE. Do you remember which one is first? If
> anything changes here, your driver is broken. There is no dependency, no
> probe deferral.

hi, Krzysztof,

I found that the initcall method cannot be used for the clock controller 
of sg2042. We need to initialize the clock earlier because there are two 
dw-apb-timers in sg2042 (Sorry, I have not added them in the current DTS 
of sg2042, will be submitted later). The initialization of these timers 
(timer_probe()) depends on the initialization of the clock controller. 
If we use the initcall mechanism, it will be too late for the timer. So 
it seems better to use CLK_OF_DECLARE provided by CCF.

I have a question here that I would like to discuss. The design of 
sg2042 is like this, according to the design of memorymap in its TRM:

070:3001:0000 ~ 070:3001:0FFF SYS_CTRL 4K
070:3001:1000 ~ 070:3001:1FFF PINMUX 4K
070:3001:2000 ~ 070:3001:2FFF CLOCK 4K
070:3001:3000 ~ 070:3001:3FFF RESET 4K

But also as per hw design (I don't know why and I don't like it also :( 
), some of the PLL/GATE CLOCK control registers are defined in the scope 
of SYS_CTRL, and others are defined in the scope of CLOCK. That's why in 
the current code, I define the syscon node corresponding to SYS_CTRL. 
The purpose is just to get the regmap of syscon for the clock controller 
through the device tree (through device_node_to_regmap()), so that the 
syscon defined in SYS_CTRL can be accessed through the regmap from 
clock. The clock controller driver itself does not rely on other 
operations of syscon.

So based on the above analysis, is it still necessary for us to define 
the clock controller as a child node of syscon? In the version v1 of 
this patch, I actually did not define the clock controller as a child 
node of syscon, but only accessed syscon through the phandle method. [1]

After more read of the TRM, I believe this situation only exists for 
clock. That is to say, there will be only one child node of clook under 
syscon. From a hardware design perspective, CLOCK and SYS_CTRL are two 
different blocks. So I think it is better to restore the original 
method, that is, restore clock and syscon to nodes of the same level, 
and let clock use phandle to access syscon.

What do you think or do you have any good suggestions?

Link: 
https://lore.kernel.org/linux-riscv/20231114-timid-habitat-a06e52e59c9c@squawk/#t 
[1]

Thanks

Chen

>
>> this driver is still for platform device though I move the clock
>> controller node as a child of the system contoller node. System
>> controller node is just a block of registers which are used to control
>> some other platform devices ,such as clock controller, reset controller
>> and pin controller for this SoC.
>>
>> And I also see other similar code in kernel, for example:
>> drivers/clk/clk-k210.c.
>>
>> And I'm confused by your input "so you cannot use other way of init
>> ordering." Do you mean "so you CAN use other way of init ordering"?
> No, I meant you cannot. If you want to use syscon, then your driver
> should be a proper driver. Therefore add a driver.
>
>> What's the other way of init ordering do you mean?
> The one coming not from initcalls but driver model.
>
> Best regards,
> Krzysztof
>
