Return-Path: <linux-kernel+bounces-29720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DDF831274
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E38B221AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52BF9477;
	Thu, 18 Jan 2024 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ivzVvRFI"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2030.outbound.protection.outlook.com [40.92.103.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C796FBC;
	Thu, 18 Jan 2024 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705555768; cv=fail; b=iUTGVuM+gdvJ47r1h4eVD/Y8VX3uVVzLBE9gZszrKZExDau1lTn0VdlhSRvQqXl/M9FKrdnZ1nRuj5JA69bQ9D+3T4YCO/+xixv7d7AreN8/Lcn3qjITbE6tI7APkvFOgWTQpGS/AtnExBwn3Zut0b8U85c8RJ/BCjdBp98Z/WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705555768; c=relaxed/simple;
	bh=irmwVZqw9LjEd+rW34PVa4D3sTl/MleIolEGDlkCzhE=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-TMN:X-ClientProxiedBy:X-Microsoft-Original-Message-ID:
	 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=EEQMl++opP3/KHpPzHQqfC5HbjLNNE+rtlsslTkaohXaKegAHzHzXiZ1q94GB+qgCDaBw756g8jAH9e+QAbJSeJT59HzNdtAX6ViKAVjTIDfTDQu7ouh3sctSTvouQjvGsfi0RsTkfwB5mBHoZvmvCiRl7QDUiuBuojSC/qOiqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ivzVvRFI; arc=fail smtp.client-ip=40.92.103.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fV/t1/S/HItXqiltrsMad4aIzkbqRv7fT8kjsufVknFemwQGo59NfLnSYz5w1/IZRc0gPuIuJS2SIqGanxsFgm7X6XGs+lgS1czYahgt6tB9S/PFvX4j8Qvtf2otswQ6BfOj1SMVIcHLNSr6FG/9yjeQ32tewis4vqoSYbcy93+YpwPeevts2/6U3JY37hTbyL/4QwjToyiyfhBsHh0241pCBn+iSd7RT8ShOHFpoTKs/2x6y91Bu+qlx0TYLuNUWuWfQnrVu4Ef6hgdyZqV9ITpqgubVW+2wuHdshrKZsVZAn6nELBx++Hpj6Y/k+INiBb0XrC0olrIZfbtfpI+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2h4G8xrbvBgaMO4F82y9JQEUJGPPo0y5alIn7i3Upc=;
 b=nQsPm7RT4OrFYJB82D6VADoRbe40oq61UvcCzp9vUyQv5aiwll4MW8MDYrSS8hZk5WkeI7BqecZsJnlAFe/OZ7/jzHW1rgg1s9HumJYw23Vm09PuxLGczcckFL1Vz+mweQ9IlBj2XKDg6CLCdQhFVVE8PpLUckZrtzalrq+q2BUPoi802HnpwRFrXvveVst7IO7UT0N6v9RDltJPHC5z98vMJKn+9dLKt1G7L7x13lSScrJG8U3xZx7LJ+ppXb61jWjvL73P5bOtMOnY6KD+Jxqvi0g4riy8sdIJLc7JCSVs10oT67hDZl7jEA8/7xgLKvmJjX0ai/CRdN80ybubOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2h4G8xrbvBgaMO4F82y9JQEUJGPPo0y5alIn7i3Upc=;
 b=ivzVvRFIdAtw3EGaH9wNbz3p2jXUoRniKBralhG5YY5H+N4ACweuAm7mQBTMoHT4l5g10GVpcRPCpvQPklbKPI6EIDaL4Y4uJxmag05h16NyJknbbv9tbsv3NnV9uQml/3RLMv61SVqKvWmsgxGCPrGccnD/C5ZcwcMDVpkm6nb9DMlGCZlLSlfEkL0b/7tKcjk0BosFUFj78C8LnkzXEhCjIGimpHJaNMOoGPJmUvRkT/kJPfqtgRI2+AyxcMvr0kEG/RRVxQnKImeq7ronjhjpXC/Nw+/A0kz3bFnthYtQpnGgtqJllzMg2vQsbWHMJxsnqNYTAMhwvt3iD3iQQw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB2138.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 05:29:18 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 05:29:18 +0000
Message-ID:
 <MA0P287MB2822FBA18674540BA85035BDFE712@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 18 Jan 2024 13:29:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] dt-bindings: soc: sophgo: Add Sophgo system
 control module
From: Chen Wang <unicorn_wang@outlook.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1705388518.git.unicorn_wang@outlook.com>
 <598b1026fdf9989bc48e5e10d1034b37947d3b80.1705388518.git.unicorn_wang@outlook.com>
 <f4a46311-2e12-458b-98a8-d3caa2c95517@linaro.org>
 <MA0P287MB282232DC6DF6290F5520BA89FE732@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MA0P287MB282232DC6DF6290F5520BA89FE732@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [QWUKPSKxFwTw2iValkzxG5JyU4cffBhb]
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <285064b2-e5de-48a1-aef1-26d9e5cdcd72@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB2138:EE_
X-MS-Office365-Filtering-Correlation-Id: fc58cddb-7249-424d-0a83-08dc17e66966
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2GG1alpgk52Msh+GtGFo2X4bCTPJmiMMivNv6Ddhi6HDMy2zgmXQHpEh0m+csBUUNgcH+d7MxR7ot5G1FnTCLhvAKL86oVIqYFjueBGQm594JnPtQlm8F8C/mtMvZxrDn2q7TcMVYx765EFqdaALNPf61m0NiPT6VURWhJOlXUHERAgk8O4MnIkSGkKAOECavRhmqDscX6x5my3jHFHVXO49e4Vr/10fzoAJr6hVtdiAWKcuWPBYYivoGzJaIUHe8f+wxkPfY/YXvHUKUUgCB9tTMMkGUZVsFPwDmuZgWE2a2TjWQDw0GLHu0z/xR5jntNVHIEdBGhww8JI2BFj4PhSTSUCvLYxpxmHBSWke6QOsab7C5fGDp4SbQgLTPQ/7x2UoWf8/MUVDQaNNQ+EiLn09mWjqPb3z59t55oywSZYsKwbyk5jwRqWmzGePI7TnBU37ot9gd1+R7IHcJe+O6dYccEWXBQAKdr6L5xL+77SyahxrzAkMPct6w919n1OkWdWDbMcaW3DQ9fhXLnaI3VDgeiEpcV1+BXYkQUIrNlrmdmWQRBFUOJtfesimkoSBqqN7H6cgQg4BONYzzc3hyUwU8HppSTK75amUvlKc1XWVbAkCSy5Lk5OS/nWg+5PZBd5JSuJYQ1cV1gQijE34SQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVFvNWNVclhDaTNWcEpvdERZbjAxSzc4aXFxZmFxdTJJb0QrazBUSE5lL0Uy?=
 =?utf-8?B?TVdOVG1Ga08rcHRKZW45RHFLd0pSN2NteWZtb1hYQnF2VzJ4OGRyajFnd0ZT?=
 =?utf-8?B?aDAvbzRibm14dkYwUzYrRE1TeDNlcCtrYzBKMmZxQjBwdnlSelFIUjMyL2J6?=
 =?utf-8?B?Z1dvK2RQUWdJTksyZ2w0MkI2bDBBWGNPcDJYbjlVUGxzWVIwWlJkUStpOXlj?=
 =?utf-8?B?cVl3aWUvZU9OOE14Vk9JM241Q2hVdVBLb0RtMmVVd09xZXB6Z0JyOWl6Wnc1?=
 =?utf-8?B?Y0pYTUtPVnpyUitPYjRsUWtrZnhhR2E4UHVWdXloci9kTFFGallhUlpoVjhJ?=
 =?utf-8?B?TmNWWEFpNmo3cW1RaEg0SVBIR0Z3RWpndkxSbzVVdHRtY3Fsc0RxdUlZRXJo?=
 =?utf-8?B?L2NvNFJmd2NoMWs0SkZlZXBzOHZkMW5yMmhGNnQzYnhvNWxieXBBUGlUczlQ?=
 =?utf-8?B?d0lNU05zOFVWVnkwYnpTLzVsRC9KUHV0cVVkSHF0WGFWdXBOTkdaUDZoVzdp?=
 =?utf-8?B?K1kvMjlZWXdVL2JxbHNCRnYzdHhHS3VuUmNHZnBjNVVIbXMyakV5bVNvbGc1?=
 =?utf-8?B?aXRVemdVc3ZQSW5RMUdieGJEcXFMV2ViQnV1UWJmemN4M0hybk1UdDgzbjR1?=
 =?utf-8?B?b0YzUW81SEpQV2xDbjh3UWc1N1I0ZG84bFdSOVdPV0oxcFExeGZTdFhhVDFU?=
 =?utf-8?B?R3pIc3BlSGlSVG5Va0NtMEc5TUJmRFdlc3lMWWdBZE0yUmtGTHBON3I1WVJK?=
 =?utf-8?B?NXp6U1l4ZTErR3BZdUR5OXFJU0wrc1lYVkFNUFdNbjNTL28rV0k1S2NxUmZ0?=
 =?utf-8?B?Vno4MTVlc1pUWTZnRHoxcnVjSVZ5c3hLT3Z0T0tBRzJGeFFsZXYwQ3pFcC8z?=
 =?utf-8?B?aEl3dTZlbytEdDl3UHFSa3RuVmFWTGd5YlV3ZGlZZWF5L21iaGF3R0hSV2V0?=
 =?utf-8?B?TFBnV2hhejU5SGN1bURLVmIvaWhITCsxeFMydm9BT29kNkQrNnhmalJxNi9B?=
 =?utf-8?B?a2Z6V1lpYjc1dDgycjBkT0Y2SGxDbTFBa2lBS2piYVN3b21WaFV5VU1mcHRm?=
 =?utf-8?B?M0dVOUM3TVlQdllNQWFHMDAxY1Z2dUxtck9HcGFicCtTMmh5MDM4TVFHQlZ3?=
 =?utf-8?B?VDZzU3ZQUmMrK1FLc09vWVhQd05LNjl4Y3FOV3lSSkxpK1drOEt1MXExRkYr?=
 =?utf-8?B?K1hoajV3NWhOMDdEL1pFczlST1pDU0lNaStwd1N4cDZTcWpHLytHbHo1L0Jt?=
 =?utf-8?B?a0lGQWpFYWtMdUIxK3BSOHd5RFVIUXJldy9WT016cUlGMitzNE9vYzFXdUh3?=
 =?utf-8?B?SWhKUE1iYkxvOXkrQlNIK3RwTWlpTTloUU42emFoR2luZXZnVjlJY2pVTTZL?=
 =?utf-8?B?bHRWSHUyNlZyekM5RHR3K0t0cWp2N214dTBUWXJOV1RsVXlZTUNuSnV5RkxC?=
 =?utf-8?B?TDN2a3l5VVZ2VFk0c0N2NzZZbC9Rc3JHSDkyb21sRjBaZFNhRTBPVmoreXpM?=
 =?utf-8?B?b3pub3RhS0F3Lzc5RWV2K0NCRTlLRkt3TWRlZWlyblN1dWxLOHJlb1E5RXhY?=
 =?utf-8?B?L0dvNHNpcS93VElPK1ZlQ3B0aWhOek0vajNuWkFJRjhXTzNlWk5sQnI0YUo1?=
 =?utf-8?Q?PtNo4IvvrZCwAZQucovlx56cnK4/ugAO23uA+0UtDFTw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc58cddb-7249-424d-0a83-08dc17e66966
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 05:29:17.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2138


On 2024/1/16 19:37, Chen Wang wrote:
>
> On 2024/1/16 18:06, Krzysztof Kozlowski wrote:
>> On 16/01/2024 08:21, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> Add documentation to describe Sophgo System Control for SG2042.
>>>
>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> ---
>>>   .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 46 
>>> +++++++++++++++++++
>>>   1 file changed, 46 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml 
>>> b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml 
>>>
>>> new file mode 100644
>>> index 000000000000..7b50bb56b4cf
>>> --- /dev/null
>>> +++ 
>>> b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>> @@ -0,0 +1,46 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>>> http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Sophgo SG2042 SoC system control
>>> +
>>> +maintainers:
>>> +  - Chen Wang <unicorn_wang@outlook.com>
>>> +
>>> +description:
>>> +  The Sophgo system control is a registers block (SYS_CTRL), 
>>> providing multiple
>>> +  low level platform functions like chip configuration, clock 
>>> control, etc.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: sophgo,sg2042-sysctrl
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clock-controller:
>>> +    # Child node
>> Drop the comment, it is obvious. It cannot be anything else.
>>
>>> +    $ref: /schemas/clock/sophgo,sg2042-sysclk.yaml#
>>> +    type: object
>> Why isn't this merged here? You do not need the child node really...
>> unless the clock inputs are specific to that clock controller and you
>> will have here more devices? But where are they in such case?
> I don't see more devices will be included later. It should be ok to 
> merge them into one.

hi, Krzysztof,

After some double check, I find we will have more devices in 
system-control. For example, in the SYS_CTRL area, there is also a 
section of registers used to control the "General Purpose Interrupt". 
The pcie controller of sg2042 will use this interrupt controller which 
is defined in SYS_CTRL, we will add it in later work.

Specifically, the distribution (offset) of registers in SYS_CTRL is as 
follows:

- 0x0C0 ~ 0x0FC: for some PLL clocks :

- ......

- 0x2E0 ~ 0x30C: for General Purpose Interrupt:

- ......

- 0x368 ~ 0x3FC: For some gate clocks

So it seems that it is still necessary to keep the current child node 
method, and it will also facilitate future expansion.

What do you think, please feel free let me know.

Thanks,

Chen


