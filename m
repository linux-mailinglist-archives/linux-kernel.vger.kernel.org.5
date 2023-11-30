Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C347FEDFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbjK3LdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345195AbjK3LdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:33:00 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2065.outbound.protection.outlook.com [40.92.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0404910E2;
        Thu, 30 Nov 2023 03:32:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS2aIsRQ0Tf/6FaQzgU2ZrronB3p5puhrTLnVf40wxnl9am/2UmnHF+fjpCZQVnWq9eiYOUlYTcdB179QF7lyraMISDjNgX+aR4qWIZ50LuhqcAWhte5x2tOhmeY6U3SH8xz6e9IFpgbnELHvMrv90xDv+mH9U7Q6xdyINcuWfJwm1l3guTnzp+GzmoBRxB/FAFIeP8rJnPg1HBRcyzzSQdy9O5QEZaL7p8DZN5+oeo5hQjn8nwsbFEjyt9ukcQ4Bn60LWQWicJY9XiRBaTkmJXLgGqR5+f2dhzQEVBTk5i1ZAHB9CaP8stgDS0afei8WubN6RShDTmHIIh1tQvP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ySqHa3to6LVZ5DNI4EE3X0iC915mESko3uK92pW0Og=;
 b=R96V7Z2rwFKHbWYFPSuuvbQrM0NustjIBfE4a4V8Z0EMbJ58CYPnRrAyWrIH/c8upvoQQDUq2C1SfsAUL7afFEcGQOELShOs8dXzOQp3Fp0oCocIgLszzYo2H+Hym0isyTmkLdrqtC6X/B/jv8XnmR165C98eYnRRUYZ71JhwYdSkFC71uR/6R3pkZ/waFZSZJMl8jq+1Qu0pajUgDhggC8XY2UXKwrUjU7m1AuU8EmBHloCT0gEWgHuoVz+waH0GcbGKHab7YO20JmT+K2DVDWOJqarTxZoqHB/ZUQwBYn5vgbiNZDdvtDUKJ15OUf9g9hOvPHLK8+nea3jcYP9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ySqHa3to6LVZ5DNI4EE3X0iC915mESko3uK92pW0Og=;
 b=c8dA60KQsxYF+kFNlI++SJrDNXTp2w4QerUzZgTS/Zg+uyhAxBR0jItBt8FeFD1jHVcAdY/0kxX9rGqdPNG58T54NIg3JE+H2SDRBaaz+7TLjI5oLDaiiCc6PxXMYjrUnfB0yEmcsNFd9GuitC3JXq5htqzjA6MevdT+bRKhAMheE/XrQiFGW/XOWywkQBfaA4QXy3S1WoolhkbmBd6gwVaP78Waf+0IVz05+3l+vZlEP9v5bGElXRKUufOFi45x2c30WPOu8Zaa5mJ7hZVSwgm0HX4poGwddDoJI0Ms+JB+M/Zhu/egsrFWHXO64uf9/iEt36dwKLRMjyHR954U3w==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB0419.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:bf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Thu, 30 Nov 2023 11:32:47 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 11:32:47 +0000
Message-ID: <MA0P287MB033285E834F030852F5526A0FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Thu, 30 Nov 2023 19:32:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: sophgo: Add SG2042 clock generator driver
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, richardcochran@gmail.com,
        robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
        xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
        inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1701044106.git.unicorn_wang@outlook.com>
 <c06130afb4bdc1890b4e8d29388fa6feef1f1826.1701044106.git.unicorn_wang@outlook.com>
 <81d421c8-bfd6-42b5-9da1-f067792f8f48@linaro.org>
 <MA0P287MB03329CFBA3BB6A4E4F322F99FEBDA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <2a268c8c-ce55-4321-b390-092b8df61407@linaro.org>
 <MA0P287MB03320824AB953465E00394FEFE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <20231130-enlarging-decode-31dc66f4490b@spud>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231130-enlarging-decode-31dc66f4490b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [5MZuf4iJYQIzVY2VCTPvPhC10L8E/9ac]
X-ClientProxiedBy: SE2P216CA0013.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::8) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <42d7a4e1-ddcf-4014-af1c-96be444d7804@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB0419:EE_
X-MS-Office365-Filtering-Correlation-Id: fc79f6c0-0790-46a3-9348-08dbf1981337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuYe8gi/QGOjbyUk7jrOdK4rQvnOXlkMJ1+Lv7j336Z8cNAGicswQSfnelo+/lSNHmih8yQe47gxBDq7BHCr1L4z4QHluLJWX/LL2hGIxCXdxFaOEkoPF2nPm+hGvmAETIO5dpGe3rQr63SDOxdgo/FLKAl2Ed5lQhd3MMDbWMR7i5x2DG+Es4puxG/LD7TfggUhXD9Wbrw4/E52WLWAwehh9HkXxr1hsJ/u2EmFCHWt51L1e6v5KxmIV8Y8M/J0U+rSl9yhgpyKI+CYk5Oz+wNmi2cUnnA1zGuEtKEpNDDq8VBL6ZP8ebuxlFduO+/oyxP79TH7EJAxCZoyMo1AqT0aRTXenO3TghiYN4sG9WeCdXJ79paAmJjL9mQ3S5lYB4fk1q9MTSUiJTsrhs6pVtERtgde8R8uaoSQE5RjXFSPhuL4ciq/GUO9UP0sVAjMneTnJKQHM8iZzEPGjPbhZgJ6Z1/mpk5WrpUOhL1nVVsvHFVlQJhX+JhHHeSJohOTzvnbrL2bxv/5criDb1eXBMapDiorhJj7GtAlJpMQMMCdXflJUfFhgkAUjB1OSu6xzYjRhsQxvB29WIrH/l9uNp8TtpHYAdikbKviserBTGU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZndlN0tUVEY4OE1uN2F3S2ZjZGt5Z1Avc0hTS0lKbU1MNjlQekNNdVFhS28r?=
 =?utf-8?B?cWRMVkdMRkFTT0djbGNoaHRSQmwrT3lLVXhXcGU3N2ZjL1dvU2hMRkVtOEZl?=
 =?utf-8?B?YkptL2dkVkRDNnMxV3ZkMHB2S09Tb1RxM3J6cmtjZVBqVFk2cklJaklOd290?=
 =?utf-8?B?WWhRakNFZmVwN1dWeUtBK3NuWkdvVFpBOGpPTDZ4VnEwVjV0OTR3aVVoKzhk?=
 =?utf-8?B?eEN1eW1IUUJ2S0cydXlSdGIzSHpPeldyRkN0N3g1Y0NYOU9lREk2Y2poeXMw?=
 =?utf-8?B?NkNjUWw4Z040TDRuNzFrUEdOYnF0ZlplZ2N1Szl5RitPNVpSWVp1S3NTbVEw?=
 =?utf-8?B?S2p2bTdaa0ZxWFJGc0FBNUpiOS9xd3NjMzFyc2lZM2lsanh1Q2ZMRkh5b09v?=
 =?utf-8?B?WlJNYnc3aUM0VVZVRm94enFPdU90VjR5MCt2c2pjTnU5bWxlNTduZVNPY3FB?=
 =?utf-8?B?cVhSYUdncHE2YVJUOFZmQ0pwMS9JZWtYNk9QOWZpaThhN3FUWEdXZFB2Mjhr?=
 =?utf-8?B?Tnd3VXVieGRicEpCWlZUWWZ6YTEvNGFuTGQ4SjlRblB0NktyLzh1Q1NvRVZF?=
 =?utf-8?B?ZEhjN29kc0gxaVN4dnNkeHhCY0hEcWtudTN0aytNZDNyejRacGJpZlg0ZHpL?=
 =?utf-8?B?cTh6UFE5d1VKbU1uVHhPR2JXcXBGNDAvOFdsdlZHa1J1d3YrVDBVMDJMOU5B?=
 =?utf-8?B?b3hWMUh6YUhkTld3WkRqMVhLcDJiSis0VmFEb1VPQjVjeWRGYjE2eDA3K2Fu?=
 =?utf-8?B?S0tQN3R6Tyt5WjVuaGY1eXBkWGR3WDVUYWkydjlnQklnSC9OMXFpYjlYZlFE?=
 =?utf-8?B?VjVyeHZSZjhjY1NxQ0I1aFYrbEhGNDlIdy9iaHBRR2hSZFc2TFQ0bFR2c3gz?=
 =?utf-8?B?clhwY1pzOWtGdlV4QXJsTEFjeTB1dWYyc1Q0ZWtMVmtoZ0RLcU1wYU5TSFg5?=
 =?utf-8?B?ZWd1dTVnQjVZWEc3djY2bUlHZ1RLTStDNUxvM2FNWXhBYWxlU2d6YjNSSmVq?=
 =?utf-8?B?SnBRZTlxa3IyTmdaNHBIalllQkxrSEYvUGQ2VU1kSXRoTjd5UGdYZU95OGds?=
 =?utf-8?B?cm1KeVRLbGZ4QXhka2tjTldxZHJOeVl3czZjUS96Mm9XeVhXSEVLRFd4TzZj?=
 =?utf-8?B?dThVTXZzUVdldGNySGhIQTRPRGV6Y1BsL1MvTXJFZzZCS1NGQ3BpdXBYcFRS?=
 =?utf-8?B?U3ViZ3l2blFCelZKZHFqTjlXZ0ljU2wzOHY2MzlUSWFyMFZpZ2lnb3Z3dGdR?=
 =?utf-8?B?aXBsT2tRNWkxbndjRE1uNlpKMldESkozcHJxYitJSFNlOGpoNy8zMjcrL2V1?=
 =?utf-8?B?UlVRcjRvekFuZEEweVZqVXZta1JucE1KNDJpUWJRU2JNR1RLQ3N0TCtsYXhS?=
 =?utf-8?B?eW05TVJUNzN3Z3hDbnhUMWZiNTF6MUpZZTUwWUl3KzRCQnJOdWhVRk8vZFVz?=
 =?utf-8?B?VFJiTlRpa2dRcjJ3WDdhOStFM3RJSjNjUTJoM2ltekNHam9OaUNDajVHWDRm?=
 =?utf-8?B?dEtxY3llQU9oNUhVMnpKZ0p5OW9ycHMxU3JBQTJucCtrNFIrbGllT29vSHVx?=
 =?utf-8?B?L1ZYSGVyL040U25KUUQ3RWl3UEc0cFF4c25OSk9uSmxHUkpKMFphbCt0ZjNW?=
 =?utf-8?Q?mgmY3Y0P331CeBCJZCPQWd4JwxL2+jj0nASHOIPqbWPs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc79f6c0-0790-46a3-9348-08dbf1981337
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 11:32:46.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0419
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


On 2023/11/30 16:12, Conor Dooley wrote:
> On Thu, Nov 30, 2023 at 02:37:53PM +0800, Chen Wang wrote:
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
>> I found that the initcall method cannot be used for the clock controller of
>> sg2042. We need to initialize the clock earlier because there are two
>> dw-apb-timers in sg2042 (Sorry, I have not added them in the current DTS of
>> sg2042, will be submitted later). The initialization of these timers
>> (timer_probe()) depends on the initialization of the clock controller. If we
>> use the initcall mechanism, it will be too late for the timer. So it seems
>> better to use CLK_OF_DECLARE provided by CCF.
>>
>> I have a question here that I would like to discuss. The design of sg2042 is
>> like this, according to the design of memorymap in its TRM:
>>
>> 070:3001:0000 ~ 070:3001:0FFF SYS_CTRL 4K
>> 070:3001:1000 ~ 070:3001:1FFF PINMUX 4K
>> 070:3001:2000 ~ 070:3001:2FFF CLOCK 4K
>> 070:3001:3000 ~ 070:3001:3FFF RESET 4K
>>
>> But also as per hw design (I don't know why and I don't like it also :( ),
>> some of the PLL/GATE CLOCK control registers are defined in the scope of
>> SYS_CTRL, and others are defined in the scope of CLOCK. That's why in the
>> current code, I define the syscon node corresponding to SYS_CTRL. The
>> purpose is just to get the regmap of syscon for the clock controller through
>> the device tree (through device_node_to_regmap()), so that the syscon
>> defined in SYS_CTRL can be accessed through the regmap from clock. The clock
>> controller driver itself does not rely on other operations of syscon.
>>
>> So based on the above analysis, is it still necessary for us to define the
>> clock controller as a child node of syscon? In the version v1 of this patch,
>> I actually did not define the clock controller as a child node of syscon,
>> but only accessed syscon through the phandle method. [1]
> In that version of the code, clkgen, your DTS, looked like:
> +	clkgen: clock-controller {
> +		compatible = "sophgo,sg2042-clkgen";
> +		#clock-cells = <1>;
> +		system-ctrl = <&sys_ctrl>;
> +		clocks = <&cgi>;
> +		assigned-clocks = \
>
> +		assigned-clock-rates = \
>
> +	};
>
> It had no register regions of its own, just what it got from the sys
> ctrl block, which is why I said that. The syscon block looked like:
>
> +		sys_ctrl: syscon@7030010000 {
> +			compatible = "sophgo,sg2042-syscon", "syscon";
> +			reg = <0x70 0x30010000 0x0 0x8000>;
> +		};
>
> which given the register map does not seem like an accurate reflection
> of the size of this region. The "0x8000" should be "0x1000".

Thanks for your carefully checking.

The history is when I was working on v1, the description in TRM was:

070:3001:0000 ~ 070:3001:7FFF SYS_CTRL 32K

Now the TRM is updated and the SYS_CTRL is divided into 4 parts.

>> After more read of the TRM, I believe this situation only exists for clock.
>> That is to say, there will be only one child node of clook under syscon.
>>  From a hardware design perspective, CLOCK and SYS_CTRL are two different
>> blocks. So I think it is better to restore the original method, that is,
>> restore clock and syscon to nodes of the same level, and let clock use
>> phandle to access syscon.
> This sounds two me like there are two different devices. One the "CLOCK"
> region at 070:3001:2000 that should be documented as being
> "sophgo,sg2042-clkgen" or similar and the second being the "SYS_CTRL" at
> 070:3001:0000 that is called something like "sophgo,sg2042-sysctrl".
> Having more than one clock controller is not a problem and sounds like a
> more accurate description of the hardware.

Yes, I agree a new "sg2042-sysctrl" is better and "syscon" should not be 
used as per input from Krzysztof.

Actually in the TRM, the "SYS_CTRL" is described as a block composed of 
many registers for different misc functions, and controlling of clocks 
are just part of it. The hw designer scatter clock registers into 
differnet area of registers and make people confused.

>
>> What do you think or do you have any good suggestions?
>>
>> Link: https://lore.kernel.org/linux-riscv/20231114-timid-habitat-a06e52e59c9c@squawk/#t
>> [1]
>>
>> Thanks
>>
>> Chen
>>
>>>> this driver is still for platform device though I move the clock
>>>> controller node as a child of the system contoller node. System
>>>> controller node is just a block of registers which are used to control
>>>> some other platform devices ,such as clock controller, reset controller
>>>> and pin controller for this SoC.
>>>>
>>>> And I also see other similar code in kernel, for example:
>>>> drivers/clk/clk-k210.c.
>>>>
>>>> And I'm confused by your input "so you cannot use other way of init
>>>> ordering." Do you mean "so you CAN use other way of init ordering"?
>>> No, I meant you cannot. If you want to use syscon, then your driver
>>> should be a proper driver. Therefore add a driver.
>>>
>>>> What's the other way of init ordering do you mean?
>>> The one coming not from initcalls but driver model.
>>>
>>> Best regards,
>>> Krzysztof
>>>
