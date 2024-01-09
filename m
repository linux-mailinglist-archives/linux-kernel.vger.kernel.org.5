Return-Path: <linux-kernel+bounces-20582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C68281DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE2C287C33
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F9F358B4;
	Tue,  9 Jan 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i+Uls7CB"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2085.outbound.protection.outlook.com [40.92.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12E22073;
	Tue,  9 Jan 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNXQzIbuDvNt3yvLGeXHqRFCbmo3lKAbbD2GrP3AYFuefTDkwgsoTEe2MasZ08cTYyMflYRbp3buoYU9C+SKu7WcJQi9yL/Hoat+wuFT6lLdk5gWl3oKhpQJVYvOP8vNuksYPcV7d8iwFGKE4BybjSp2QVADQ79eLZSvJpOaI2C+/2rrnfrZBJULBQq4+7T2+gXOXThn6PRKzZ1tTdoibS+pq2deOwYpUdWku22EQe1TRNjMHx5LSI1BUFQX3+w5+3m2H/IYEn7MsLYFJ7vuPflNtryZle3wd+ihSS0+zOdPc2mpYDnR5YSjSTxCNXYP5SgNPXGdCnI6mfVOCJqcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Kc1/acqdl4pVMo+iEYdsuQNi7GKCbRhheNIgkInaNE=;
 b=EmAQiMxoZxR2syCwa1KtemDgRy4XskEOgXonm32y8l596M+eQ2JZ4r5uYoVRkTfJCffbNOe8ULmUIkCM9Z4hVegjHGcSGGuymltg50SjAk18f38Du0eZr/TIk6HmFJKVkzF/nFfkyc0mtqA1aK0Lq2LSsTIjEfGn0fsKuTNtAmgtyyHN1xRpy4eLUtl3t5OLOvrscwldyB/s62iox3lUPtMFjBkvOUJrGsQCI57fNl4J8PosbJ6luX0gfsMf35tldzN7fQ97DxxF/pKoKZV9hUwNvrwNIfoJqpYpr23KQWdxfx/9KTUSyWmQRK9uGHgNj80qGfEC4uvd9Ktch09FeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Kc1/acqdl4pVMo+iEYdsuQNi7GKCbRhheNIgkInaNE=;
 b=i+Uls7CBCDqSs7KsK7OB1BN3T86l+DpULFZ2krsbXzohRNZYuEnFLtAldDnvEUcRuNk2PP67G3MH90x0ZQi8L+So0ZNZD+2ULSwFA2Gi06VqY86Mb8zuCWtilLQjbCW+az6Cuo3KBzgFTD23fjikQI8v16kEQf2zfnAfmTWGo9FQWHAKDSAMMfMN+8emgauXzBAxCNKrauYU4MxGAeCZ4GY7XIy4BZ7CXbdytXZe4tHMqUokmf3eS7aODvOxppKhyfU6GBCzk0LITrsnwG9WJHUH4ysRtrbWq4ZIalo67WyHss6eSL0OHLvR9ENY3OBX0KfWiL+VUCsZOHtB+tacew==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1015.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 08:26:39 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 08:26:39 +0000
Message-ID:
 <MA0P287MB2822FD86915185F6C908ACCFFE6A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 9 Jan 2024 16:26:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] dt-bindings: soc: sophgo: Add Sophgo system
 control module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <acebc88db3e5fcd2a2607b56842af7443a6e1289.1704694903.git.unicorn_wang@outlook.com>
 <cc7cc943-7242-4fd1-9b56-3ece0a418e05@linaro.org>
 <MA0P287MB2822E54A6DD36F914DB56E98FE6B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <1e1ef0a0-6639-4a4d-9b4e-50bcee3fb3c5@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <1e1ef0a0-6639-4a4d-9b4e-50bcee3fb3c5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [+mSGRKrQHKlzGy2bAV8g9Rub4dwtVboO]
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <25f684d2-3089-4a24-87b6-2c89cd63f5d4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1015:EE_
X-MS-Office365-Filtering-Correlation-Id: 69017170-43c7-4b9f-93ba-08dc10ecb25d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RJM7g6Je9rcku0GgxZyaaBcl4NnOIj9Jl7726+jDMG3Tbkgd4twKToRZWGUoiotzDBrUp1Akje3UpGUCdCUR167j/ie6How7iGd2DzPE8Ts/XEPthUlb8UWc9fKO20KLhSEwua1uUksfpj9LJRUQ1nFQ/FLY447Ms8zGwhx0cDmqKqusAonB1MgA26W2U8pYeKMz6FlumkuYVnGbb/ne7VjeRynHh4WMcaC7zw5CN6wcSd5SZI+GjCvrZgxaX9a5/EI/hMqUAQ05S1MZh1/eqwADs28Gy17lKKETO/cXvIjEk7dTY47yGny+rTndlrmcAlASiuJ5rYNlg0qDGWSUT3MmCKbJGFyvBE4fpkBOg6lOFyA6/oYujXTOLTk384EEIy/kArmHIR+sMiCxghbWFCMCP9dW/0xIaxJ8i+1nj5/DrCX9S1AbBMpQJ3Rt90jxKrzin7vhLfdhF4xo3Ok6F4AOVoU+oCifsN9nB6Fr1dZ7rallrhlvBMrWNilY6CHgl4rXDJF7NW/fhxrDL10CwUG3IOMbt1eOGDMZVQ+DmhJ64O90oB7pLvkkNOABr+x660GdtoQYQ2tjYu4MQyF5H15bhrGBUOGv3+xLMM983m9vjWPY4Ww18Y61ZbzHcf3jqcVuLA6+gXfjVphFhS7Phg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0xueXNEUkpOWXF0cEZUS1ZId1h3N0hCbkxXclRmUWZxM0NNZS9RS2RZL2x0?=
 =?utf-8?B?TVhVV2lGcmt6UStLN1NqS1Jid2xBTENoSzM5QUExT2RQbTRjOFZEQ3JqNzNr?=
 =?utf-8?B?UHh2ZVVudVVBYVBkamFWK3c4VEhDRU9Vb2RUd3FDeDBjN1lMNGxvbm5WanBk?=
 =?utf-8?B?SC9aNi95eDhzQTU1ejMzVVNKZ1kyQjk3OHdLaGdrVERENzJFVGtvbDJ6a000?=
 =?utf-8?B?UDQ3aXFRZ2c4NXQzeFZPVlhrOXBZM1FLYnZ6MHVjVUZWNmI2UDZSbXhLWmtL?=
 =?utf-8?B?TW9sMlJWa0hoZlBQaEVkb3M1ZHY3YmF2UjIvMXM1VTRRSWVVVS9RbHhDY1NI?=
 =?utf-8?B?UTZBc2MrSlRBYnhmSDAzem54bkl1N25HVHF1VG5HdjdtME4vUGVRMUozZy8w?=
 =?utf-8?B?TjYzSU5GWWVMaHU2ZVRiZkJUaGlCSEROSVNYN0VlSUd0WDRlUlVRR2dsN3Ew?=
 =?utf-8?B?amRzSzh1K1d1YkQ5NlJEOXRmcklrNU82VnBYaERwQkVzbExrRnpmcWtoVHpB?=
 =?utf-8?B?WlNlenFUWit5QjFuNGhITE1pVCtXRHZQKzZHMFRCbUFVMG5wRm4xVDRDcXF1?=
 =?utf-8?B?VVUxTFM4Mi96a0x1NkVRSFFxTzdPWitXczRQU3VOdmJaVGY4SXVlWW9oSkho?=
 =?utf-8?B?R2k0YTVWL2NYRzZId3A0WnN3N3lEVjB5eWM5TnZod3d6aWJSZmpEbkEzK0xB?=
 =?utf-8?B?V2hGT2MwOXVzbEplRHpYUGV0K3ZsalBFd0hZMWJjR0xqYUtvMmJkQ1FHNVRt?=
 =?utf-8?B?V2hjMXRqdGd3UklDaURqaEtpOGd5alpHN2VoZ0cwcXphMGMxMXVhVjZyQlJY?=
 =?utf-8?B?Mjlhdnphb2ljOFZnT0ZsWHBVTEZBWDB4SkFkTjF4MFlEcGFLZGk4bjd5WXRG?=
 =?utf-8?B?L1hFQnFsQ0d1V0RvQVRVc3RycVpJU3J4Z0Uza05DNHVZZEpsaGo1K0FmL2pG?=
 =?utf-8?B?dS9RenQySzZicmhPdlhSRmRxMUdDbTllUDlFUHBkcnk3Q09pbExSTFQyR0Zz?=
 =?utf-8?B?OHVpS3ZZK1lTL0ErWFdaRmhiczBucW05cFlsc0xJWWpySURla3ZWTytnYnh2?=
 =?utf-8?B?Um4yc0tXZ3pvU0YxeEFwNnZubUZ5STVwc2FXWGtBaTcxa3R3Q2YrWjUvSWpa?=
 =?utf-8?B?N01LcjhUSE1tMWcrcG9VTGRzdDJQQmpZR3hhQ3d6TEVSb0VGaEtHSXFIZmVF?=
 =?utf-8?B?TXp1eXk4NEhub2NTTWNDR1VSa2VYeFUvdmFETjRaMGZOU1gyamxjd1Z6R1pz?=
 =?utf-8?B?cGZBNk1yKzJ0N3MxZENWWG12YlRYQS96dkw5YUVyM0IwcU1HRnNQYlB1UUZL?=
 =?utf-8?B?bXYzT25wMmYxdVJ0bzhDSDRoS1k4clFvaFB4c3RXU1dVdXNCTHlTUHNsVWNn?=
 =?utf-8?B?TDlkYU1BTmhvTG54N1Bua2pMTG03SGg4ZmxlN1p0ckVEZ3VpWkhvcUoyMmtF?=
 =?utf-8?B?bmhqS1RTWlFTL2JhTXhJMXJBNGtrRHNRRG1TcWFBYTQvOEQvR1pZcUNCTUZH?=
 =?utf-8?B?OGQwK1A3T3hvV2hUTGgxU2Rrb0RTbnFWVVFrc0I1S0Z2RkVZV1BIVHYva2hi?=
 =?utf-8?B?WWV0aEEybzVtZkE4WENZY3dheExzRSt0Y3dwTTd0YXpYQ2NVaWR6N25hVHFv?=
 =?utf-8?Q?/cF0Fico/DJJxRRGj17Dw5mQGDyhBeRwELHuWBm7iBdg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69017170-43c7-4b9f-93ba-08dc10ecb25d
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 08:26:38.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1015


On 2024/1/9 3:36, Krzysztof Kozlowski wrote:
> On 08/01/2024 08:20, Chen Wang wrote:
>> On 2024/1/8 15:03, Krzysztof Kozlowski wrote:
>>> On 08/01/2024 07:48, Chen Wang wrote:
>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>
>>>> Add documentation to describe Sophgo System Controller for SG2042.
>>>>
>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 34 +++++++++++++++++++
>>>>    1 file changed, 34 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>> new file mode 100644
>>>> index 000000000000..1ec1eaa55598
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>> @@ -0,0 +1,34 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Sophgo SG2042 SoC system controller
>>>> +
>>>> +maintainers:
>>>> +  - Chen Wang <unicorn_wang@outlook.com>
>>>> +
>>>> +description:
>>>> +  The Sophgo SG2042 SoC system controller provides register information such
>>>> +  as offset, mask and shift that can be used by other modules, such as clocks.
>>> "offset, mask and shift" is not a register information stored in
>>> syscons. Are you really sure, that your system controller hardware
>>> stores offsets of some other registers?
>>>
>>> Show as some example of such offsets, masks and shifts provided by this
>>> hardware.
>> The system control module is defined here:
>> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-control.rst.
>> It contains some registers related to pll and gates.
> I do not see there registers providing shifts and offsets... just values.

Let me first clarify more what the "offset"/"shift"/"mask" I meant,

Use 
https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-control.rst#mpll_control-offset-0x0e8 
as example, this register is used to control Main PLL:

- Offset: 0x0E8, to my understand, it is the offest between this 
MPLL_CONTROL register and the start of system-control base

- Shift: the conlumn "LSB", for example, to locate the field 
MPLL_CONTROL.MPLL_FBDIV, we can first use system-control base + offset 
to get the address of MPLL_CONTROL, then use LSB(16) as shift to get the 
start position of this field.

- Mask:  still use MPLL_CONTROL.MPLL_FBDIV as example, use MSB(27) and 
LSB(16), this means the width of this field is 12 and with this we can 
get bit-mask for this field.

For SG2042, IC define clock related registers in two parts, one is in 
https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/clock.rst, 
and another in 
https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-control.rst. 
I define the system control node in DTS and just treat it as a block of 
registers array and after regmap I can get some registers address such 
as MPLL_CONTROL to access it from my driver code.

>> Some other clocks registars are defined in
>> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/clock.rst.
>>
>> memory-map is defined in
>> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/mmap.rst
>
> Please fix the wording because it does not make sense. System controller
> does not provide register information. Your datasheet provides register
> information.

Sorry, I don't understand why you say "System controller does not 
provide register information."? As I explained above, I did see the 
information about these clock-related registers from the system control 
module, such as the offset/shift/mask I mentioned above. That's why I 
wrote "that can be used by other modules, such as clocks".  How should I 
express, please enlighten me.

Thanks,

Chen

> Best regards,
> Krzysztof
>

