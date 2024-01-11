Return-Path: <linux-kernel+bounces-23174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 278A282A89F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81304B2671F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76118D523;
	Thu, 11 Jan 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mQSaQjSC"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2073.outbound.protection.outlook.com [40.92.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E2D2E4;
	Thu, 11 Jan 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCI9l2J98Ny2Wz46daA3jIaHBs0/UJWFYlTYY05ZY+45+rf7Mj5Zb4HjoML+7AC78MCQXa60Us8sL32iFHyJ2aPY0R17GxxGgmvkmewItk9a8MfWuT3PsMQMD6fciQU5mFIGp7v2bSbq9G61Y/ySUHtOJdx0ITyniw4IMm+sQhJ3NHM9zry07UCciHlctF7t7XaawIy0hRnSVYMavOBXUL6vUfx5y3aSKGwzMb6pcxfLT0bmuSncIY8oNoZR8m88WvCcMn4VSYjgr6T+CTNgV38qctuDvWrV4iJN/WnEGGA/AZuZjE3ru1kjvKMwXmp7L8uDCJF/IZtvCsINF8excQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr3xnrBPRbG7aRr/m/snhZWPE1ml8yNO9oN2bLgxRX0=;
 b=BbdNIyF2lsPxrwygmZVB87M+WAZR7f66f4yACzMhkyipR6xAMHqxMkBBkl/EAlTc/cpzPK3qNd54V9BC9g/VyGWX5NM29jG+vfSHLLmRn67B+vWNDfjHAiloP7Dc5socWPKjYG2924jjcmMkq7TK/U/gOI+EcGQZM4wlIRqW70sxSnxnL/gPOVkOOH5Zw1p/pREcUa4K7DL96/m1hFQ1loK3kMNLXwrEhM+ARWfsWpenxP9U7/GyKzX8k7YaN7vRt5R6TfkFE6wNI0kT9I4azGW7rLUKE8j5Nhdu4nQjZC8ccbT4HcNABAlCJ2G1iuz/SxDnGobRacIVoUouSNndAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr3xnrBPRbG7aRr/m/snhZWPE1ml8yNO9oN2bLgxRX0=;
 b=mQSaQjSCCxEwwhmIsgIWlvIJV6X6Cw3LPGKQmEPgLedoHVcBVVV2X5CK15STkBWHXqQHVed8tvYgy9x6kIAg6s9FfRnIxGDBRFbJhw1yRAPpwlA+RK0uMA7RvVNUUWpxw0/XJvbpzCUjgSjlVzxm5kwq8W9Z7yMoZ/uW9lWReBGgQl2u/4nYKWS5xWYy7z5a2PRVdAJmC6GTLKLADKcVhs3VhBuG5bmlbqSUldNtQd+hgRTce2A04RQn2cMdXVc6p1GVLpc7VdoW6uyGgKBG3vhb/C1LgogAX0/GjjteL/pkphozdalAjJP7QT6yJaRAV8KOCyqtxoK6GUbkHnEtGQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0126.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 08:00:10 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 08:00:10 +0000
Message-ID:
 <MA0P287MB282224A6097B4FCCF721C89AFE682@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 11 Jan 2024 16:00:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] dt-bindings: clock: sophgo: support SG2042
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com,
 robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
 inochiama@outlook.com, samuel.holland@sifive.com,
 Conor Dooley <conor.dooley@microchip.com>
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <925d99d5b4ece01337cb3389aaea4b631894dd1d.1704694903.git.unicorn_wang@outlook.com>
 <f88b79c3-e44b-4136-ae56-10e1f2502e2d@linaro.org>
 <MA0P287MB2822C7A3C1DC7786708E860BFE692@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240110-untoasted-underfed-fe81479506f6@spud>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240110-untoasted-underfed-fe81479506f6@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [89K4NdIU0x6pnfsHCZGqYls1qVlXfmYd]
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <937ddde9-3309-4bb9-bc6e-5d90f8b91618@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0126:EE_
X-MS-Office365-Filtering-Correlation-Id: e5540cbd-73b3-401d-a9d1-08dc127b5510
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7kIKnZy28aoiCkZHqSQbfzmHP3yPG5s72ytREKxRG6kQKgF0WwXxE7gGoIpZN0jnDuMs200o5t+pQYsE8p5x3UeASDH1bI2h2U4U9hG2pXtJwgSUgqLMA1dFUunnSQRHaVrcNElaBwgY6xKtnsXMpkcGUl/lvRm5KZm8lPSWuj7pjIytRNYKHIB1s+6ayK2+4ru+YhbS/PqaCDr98jns+47CXmjvZPIlBoY8wrbpVH5ZZPS8iNvMq0a8CyHT3SfNvKcEuyGAXma0Lu8qLnlxkrhoe4nBkD7x73TfCAqy6t3yo5P0+ZkKEAQfUoYKXdAtNlKLjF161uZIHQG11NS0IkqsWU2q+Y7gZZVSHsme3LljtIge+TagTbYpaefcghAe+XY2FBUSqrddbP9Ej77BLpeNDTeQCxNu03Xcr6YaYdbHY3lKfmt0Ai6iHpwfjEZUVHoS4oDvNYP328IpQJXegQA0ewwMB2GDL9JpwdYSLPmwDR52TGQXVKpLyRVdutgAV2xdLS8PN5gTSYug6Tkr72VJjWPic9SJyqaNeu2hfShuzk9NKYx5F4GUQbFrV6B3D/XYSeBb0WOZtNa5buho/EAzleRUfmgcITJzQGdlmhhxwqQdKlK/VbbOx+SVEgTOIy4sYWUpEBvLaSnhdY9c6A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXFFWFhyOXZKQWJvMjl0d0N5bG1DeTdqdkVzVm9VM3J2d2RaTEFqM2tSeXM2?=
 =?utf-8?B?KzEwWkIrcG1iTHA5aHNLdzh2cG1FeWhQbU55MUpaSVd3TlB2R2hKLzlYOG5N?=
 =?utf-8?B?TEdtZ0pRZ1MyK0NmK1dnUDBIZ2R3YUkyc0tUd05YL2pnb1VUbWJ4TVdVa3dF?=
 =?utf-8?B?aS9Kb1FYSHpvTkJZd1Qrb3JKdmZWeThsbzlVQ1l0NlE1cysrbDdvSjU1UHBt?=
 =?utf-8?B?R3RaRzZJV2NPVE4yWGxEdHBLVHpkaW80ZkFhbW5sd0ZmTSsrazl2WWoxZklh?=
 =?utf-8?B?ajl2L1Fjb1pGWGxJb2hoaWovN0Mvcmp3dmhGVXE2YVBqR2M2TXgvV2M0emVN?=
 =?utf-8?B?Z1MwVGxkTURackExSGNqNGpJWkdxYndYMnRaUytsQmdsNDhjSEhzRHVoSDQw?=
 =?utf-8?B?ZW0zMVZ5d0lzckx4RW4xS1d4L2lPeFplOVVOOHJ2Z0pWSWtqbUVybGM4UUI1?=
 =?utf-8?B?RHNkbE9iNmQ5ZERQNk1hdjRRMm5LU0pCNmxreHdKQkVGTTVETFErZXJkbFBN?=
 =?utf-8?B?cUwzL0E3MjU2K25HY0tXRko4VjVVdTZlTExlMnhvNnpOaTlPV2RZcENZcUov?=
 =?utf-8?B?QlhXWk5yMk40cnBkOVpZWHova1VKNm5YRk12eldkWjdCTmxscXV3Tm9icGFU?=
 =?utf-8?B?SXNZY3NLWUpDRGhpdzJDZnJ3MUlaUUtkdXVsVi9KTEdrbFR6K2ZlTkRiYnFw?=
 =?utf-8?B?NTR5eloyemZ4eG0yeElvTmJrWnJXRkVVTExFdlFvMkJBQmhDVTBJZUtUT016?=
 =?utf-8?B?MjFiQnpsMEdUaDVDRUkyWGQ3dlRMamo2U01VbFVObWd4aTV0VTljUzhCZUIz?=
 =?utf-8?B?d3hFM2UxeUU2ZXJSNXhsSFltb3BCeDlKYVErNG9tTnhGczE2YzdPVUgxN1ZJ?=
 =?utf-8?B?Y2JXMGVvUElzbnRXR0RhT09aUnZ6UXdQSEozNjNVNjJOUkQyRWVIK3BGMFlN?=
 =?utf-8?B?allTSFY2ZTBEUSttaGlaRWdGZnFlMk1mMkQ1S3MxWnYwSGZ2N3Jla0xlZVdH?=
 =?utf-8?B?WklBTVhRSVZndUFVVTVaR3pLM0tjOWhSa1g3N2ZvTU41TDNOMmV4aVExdjZS?=
 =?utf-8?B?ajJhWXF1SFdYYUpnU2lGQ0pmYTlWbzltLzU2alB4SEg2K21NbXJtWG50UEc4?=
 =?utf-8?B?c2RIZmFISWV0MlF6NTBmWnR3NzRyVDh3T1lxSDFqWkxuK2ZUU1h5bmZTN1Ba?=
 =?utf-8?B?RmYxREFkYU5LL0d2OU5XdFBzdEtNUWhoS29weHpqRGhZT3QzWHpjcDZ5ZmxO?=
 =?utf-8?B?bU1KaTFFME5jcVJrVFVpMmhFalJnd3hWWERGOWM2VThpNWVucDRwamovdE56?=
 =?utf-8?B?VXBuYm5HRmJEcnk1QjZhMFdVMnRCZ2lTUjdpeXY4QlpqTmxIelFRRXR3M3JI?=
 =?utf-8?B?Z2tnMEhHMjVOQTdRVHVhS0taNWh5SHQvM0EvKzVIQU16Wm1hSXhvTUt6d25l?=
 =?utf-8?B?d3FwcndKT2IxR0wvV0J2T25xWFYrRDVhZmxPWnB6VzhsTXVLdFlOci82RzNq?=
 =?utf-8?B?NWxrY2RNV1pFNHI4dFMyTllmSkdjRUNqMGJNUFE3T09ncElXd2N3VjFyN1ph?=
 =?utf-8?B?bGJjQnBvc1ZRV0JIUXJuSGZyU0JwLzVDcEYzUkZFekxiYS9yaWZUUXZwQUhG?=
 =?utf-8?Q?2tcWM14ZjE1e+DJmYh50fK0DCCwCJH/jqcb6+z7BX3u4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5540cbd-73b3-401d-a9d1-08dc127b5510
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:00:10.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0126

Resent and fixed some format issue in last email.

On 2024/1/10 22:42, Conor Dooley wrote:
> Hey,
>
> On Wed, Jan 10, 2024 at 08:53:42AM +0800, Chen Wang wrote:
>> On 2024/1/8 15:04, Krzysztof Kozlowski wrote:
>>> On 08/01/2024 07:49, Chen Wang wrote:
>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>
>>>> Add bindings for the clock generator on the SG2042 RISC-V SoC.
>>>>
>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>> ---
>>>>    .../bindings/clock/sophgo,sg2042-clkgen.yaml  |  53 ++++++
>>>>    .../dt-bindings/clock/sophgo,sg2042-clkgen.h  | 169 ++++++++++++++++++
>>>>    2 files changed, 222 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>>>>    create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>>>> new file mode 100644
>>>> index 000000000000..f9935e66fc95
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>>>> @@ -0,0 +1,53 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/sophgo,sg2042-clkgen.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Sophgo SG2042 Clock Generator
>>>> +
>>>> +maintainers:
>>>> +  - Chen Wang <unicorn_wang@outlook.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: sophgo,sg2042-clkgen
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  sophgo,system-ctrl:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description:
>>>> +      Phandle to SG2042 System Controller node. On SG2042, part of control
>>>> +      registers of Clock Controller are defined in System controller. Clock
>>>> +      driver will use this phandle to get the register map base to plus the
>>>> +      offset of the registers to access them.
>>> Do not describe the driver, but hardware. What registers are in
>>> system-ctrl? What are their purpose? Why this hardware needs them?
>> Understood, will fix the words in revision, thanks.
> I hope that I am not misunderstanding things, but I got a bit suspicious
> of this binding and look at the driver, and saw that there are clocks
> registered like:
>
> | static int sg2042_clk_register_gates(struct sg2042_clk_data *clk_data,
> | 				     const struct sg2042_gate_clock gate_clks[],
> | 				     int num_gate_clks)
> | {
> | 	struct clk_hw *hw;
> | 	const struct sg2042_gate_clock *gate;
> | 	int i, ret = 0;
> | 	void __iomem *reg;
> |
> | 	for (i = 0; i < num_gate_clks; i++) {
> | 		gate = &gate_clks[i];
> | 		if (gate->flag_sysctrl)
> | 			reg = clk_data->iobase_syscon + gate->offset_enable;
> | 		else
> | 			reg = clk_data->iobase + gate->offset_enable;
>
> iobase_syscon is the base address of the system controller that this
> property points at & iobase is the base address of the clock controller
> itself.
>
> | 		hw = clk_hw_register_gate(NULL,
> | 					  gate->name,
> | 					  gate->parent_name,
> | 					  gate->flags,
> | 					  reg,
> | 					  gate->bit_idx,
> | 					  0,
> | 					  &sg2042_clk_lock);
>
> As far as I can tell, in this particular case, for any gate clock that
> flag_sysctrl is set, none of the registers actually lie inside the
> clkgen region, but instead are entirely contained in the sysctrl region.
>
> I think that this is because your devicetree does not correctly define
> the relationship between clocks, and these clocks are actually provided
> by the system controller block and are inputs to the clkgen block.
>
> | 		if (IS_ERR(hw)) {
> | 			pr_err("failed to register clock %s\n", gate->name);
> | 			ret = PTR_ERR(hw);
> | 			break;
> | 		}
> |
> | 		clk_data->onecell_data.hws[gate->id] = hw;
> | 	}
> |
> | 	/* leave unregister to outside if failed */
> | 	return ret;
> | }
>
> I had a much briefer look at the `sg2042_pll_clock`s that make use of
> the regmap, and it doesn't seem like they "mix and match" registers
> between both blocks, and instead only have registers in the system
> controller? If so, it doesn't seem like this clkgen block should be
> providing the PLL clocks either, but instead be taking them as inputs.
>
> Reading stuff like
> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-control.rst#pll_stat-offset-0x0c0
> (and onwards) makes it seem like those PLLs are fully contained within
> the system controller register space.
>
> It seems like
> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/clock-reg.rst
> is the register map for the clkgen region? It seems like that region
> only contains gates and divider clocks, but no PLLs.
>
> Am I missing something, or is this description of the clock controllers
> on the soc incomplete?
hi，Conor，

There are four types of clocks for SG2042 and following are where their 
control registers are defined in:

PLL：all in SYS_CTRL
DIV: all in CLOCK
GATE: some are in SYS_CTRL, some others are in CLOCK
MUX: all in CLOCK

For PLLs, yes, they are all controlled by registers defined in SYS_CTRL. 
About what you said "it doesn't seem like this clkgen block should be 
providing the PLL clocks either, but instead be taking them as inputs.", 
I am not very sure what your meaning of "inputs". I try to write DTS 
with my undrstadning, please help me see if it fits what you mean.

```dts

sys_ctrl: system-controller@7030010000 {
     compatible = "sophgo,sg2042-sysctrl";
     reg = <0x70 0x30010000 0x0 0x1000>;

     pllclk: clock-controller {
         compatible = "sophgo,sg2042-pll";
         #clock-cells = <1>;
         clocks = <&cgi>;
     };
};

clkgen: clock-controller@7030012000 {
     compatible = "sophgo,sg2042-clkgen";
     reg = <0x70 0x30012000 0x0 0x1000>;
     #clock-cells = <1>;
     clocks = <&pllclk MPLL_CLK>,
         <&pllclk FPLL_CLK>,
         <&pllclk DPLL0_CLK>,
         <&pllclk DPLL1_CLK>;
     clock-names = "cgi", "mpll", "fpll", "dpll0", "dpll1";
};

```

With this change, we describe the plls defined in system control as 
pllclk, as a child node of system controller. clkgen will use pllclk as 
"input" because pll clocks are parent of div clocks .

But there is another remaining question about the gate clock. For those 
gate clocks controlled by CLOCK, no problem we will provide then in 
clkgen, but  for those gate clocks controlled by registers in SYS_CTRL, 
they are child gate of the "clk_gate_rp_cpu_normal", which is a gate 
clock provided by clkgen. If I extracted those SYS_CTRL gate clocks and 
define them in system controller dts node, I may have to use 
"clk_gate_rp_cpu_normal" as their input, it looks a bit wierd becasue 
there are cases where each other serves as input. I try to draft below 
DTS to explan what I meant. I'm not sure if it can work and I'd love to 
hear your guidance.

```dts

sys_ctrl: system-controller@7030010000 {
     compatible = "sophgo,sg2042-sysctrl";
     reg = <0x70 0x30010000 0x0 0x1000>;

     pllclk: clock-controller {
         compatible = "sophgo,sg2042-pll";
         #clock-cells = <1>;
         clocks = <&cgi>;
     };

     somegateclk: clock-controller2 {
         compatible = "sophgo,sg2042-somegate";
         #clock-cells = <1>;
         clocks = <&clkgen GATE_CLK_RP_CPU_NORMAL>;
         clock-names = "clk_gate_rp_cpu_normal";
     };
};

clkgen: clock-controller@7030012000 {
     compatible = "sophgo,sg2042-clkgen";
     reg = <0x70 0x30012000 0x0 0x1000>;
     #clock-cells = <1>;
     clocks =      <&pllclk MPLL_CLK>,
              <&pllclk FPLL_CLK>,
              <&pllclk DPLL0_CLK>,
              <&pllclk DPLL1_CLK>,;
     clock-names = "cgi", "mpll", "fpll", "dpll0", "dpll1";
};

```

So, can we put all gate clocks in clkgen to simplify this?

Thanks

Chen
>
> Cheers,
> Conor.

