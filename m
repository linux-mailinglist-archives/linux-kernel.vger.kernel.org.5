Return-Path: <linux-kernel+bounces-23167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C845882A88E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C53A1F2450B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC2DD2FE;
	Thu, 11 Jan 2024 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Gpujpq8U"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2021.outbound.protection.outlook.com [40.92.102.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092BD28F;
	Thu, 11 Jan 2024 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmhJFUmlu6cG9g+elP7yEVzRY7aJnXKpRbD3KSSQVTO6Lzl2pVFPoKEW0PsJHOH7uacQ4/jg0ZQz5NkVXE4rugUWAfQTCA6p5CnAqYyj4+Q6y0NFY7R/YghrTrZeBGCgBt3SSMV6GDINltugwJUU4nvOFBNYMWIbDsaaVZUjXBNMBtxz0qxpgNpqK6mwrNI5ob43WMl/4HSzKvcveY4oU72qZY/I6SA3Q9KGc4oRjnSmgiFBRyfWpwdKoikCtm6AxaBQSTXHk1GDo1utXO83xGP3rGxT2UTMZzy/Z3NMdfEWI5VLgIU3qYDFVrMdltrrfmexwCTOQhbkCg8C3Sc4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5Q2CXAzo8QXxBCjIDZ+PmHrEaVTmtdHIJmr3i9eM/0=;
 b=PUyDWkXy2dZr4G7eGTQlBlKPZdMgv1VEDpikywVe6nNBGkUgoDJ4Xfk0RFcYnXW8fARfaP6BJvhW3rwNIb0ZSlMdqgFwoUt2NxZBxbzBTfKYy6Y1yOVcsVXS/zqfl8lFRfw/2fTJbK6KaoikX416GR6NgSAzcfqFmMXAnsYrJHhdpe6iV/la0vyXNsVjkW7Mv+TVy9kXaNeB7V79+8uDmC+6cKtEDi+kgt4/AtcXavhuXQ4+EyFZ6zUpRViyjFIz0MeDHNjecOQnFW85OffLj1goEVkJQK83cFD2RjlwIn241+92hX0b7FZvCKMR0xYiT+vpcpRienPlosJYMkv+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Q2CXAzo8QXxBCjIDZ+PmHrEaVTmtdHIJmr3i9eM/0=;
 b=Gpujpq8UsDNW8H6xDrxjr8cn/1WWsoBvwDPbvf1nOVx9Fw2eUuNwirTANp+g+Ywihq1JggsjiWWvWR0QeQO4dOGbVuBB6TUCUh3m6my/JZ4P0aq0WLx3M7P4TiKZmGxxot0gluK2L+W5SfZ0+LD6u1ciX46cSfJhZD2xc9mxwTKAjTN7X6lQ4huVX+9sLvPTmEHh81VGSWyn+rlNJ0GtlH7TbCIwkhusV7hg/rhzvGfiJUD9Bpr2P4w3OLU18Rie111MjTOZRIvNZvUXesv44YwpFTGf5jUwIQEwHrSfbJ/378HZxUwEZDUzoXVD2pUlPnvo1OvBnv7gW6oZRrvLtQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB0836.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:17c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 07:51:36 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 07:51:36 +0000
Message-ID:
 <MA0P287MB2822494916A3B8C32C91A668FE682@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 11 Jan 2024 15:51:24 +0800
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
X-TMN: [kRAWShPlY8lgkfwV8Wm3FMqtYrkzL/pa]
X-ClientProxiedBy: SE2P216CA0067.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::9) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <450739f1-e82d-4ce7-9158-5d464bfeebce@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB0836:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fbad9d-0526-4a23-5f22-08dc127a21de
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CShyUm4nf3tqBy7sOj/48semb6zcFDH0MFcympdSKqQzCi1biGtSnwC5r6CpUCLP35sd7KcjZ+hv5nNwM+t1d4kbbckJ1eitDcof17P5YGD3pVbC0b1h+X2SR2WD0ut/IxYom+i3tX1YTYQYHYqkxm7zN7FocQyaSymKu21paNuFuYR40U0r+DlDttLLqoRU1rIfv+qLHn6yFsP0E/EAHoI6/7tlEOstVaBBHZltjVLowkUGafVJ79iY3MxSDyui3kQ/KyCTDlFUNcg6F3C8Sj84ju85grQmHxZ6e8cHDxKQlPauRN6klCOm2XoJX7WiDV6Ndbstct5vnUfV13yt0vvj+yC0WN3MADOQO2rvwh2cQLwNEIlhNPEZxkwGyCYW767Ne2eQ+LvnJFMjeePJlyDXw58FX6cOX6Sn9gbdvJR/iF+41TgBFFDVWZ+/vP0+mfRZOTprVtwKYtbS25eeAEx38IH73Ig8LS4fiJQP2CYZpLnwGm2Okomw5LQvfhctUi+sHT4GcTzFlChpjG1e1TOMpW6ZTFj2bjGIQ6de2edQ80FERY8nx4MbQUDLIxpsF+l/FnuyPaposgNH8LtFBqEqQi5i/XX1QzPD7zewwt2VbL+bepsBZQv5AxKLUwEFdWnTgFNL3jK1w2J+5bY6hA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zkl5YWVsTVlFQkcyU1V3Q3pTVU5RbGwwZmhTaW1oT3RiRGVPL2VURnpFRzNr?=
 =?utf-8?B?eFByVlJFakY4VmN6UW92MjZhUDVONDRzQUgrV0gyVnUveGM3eU1uZHdvVitG?=
 =?utf-8?B?Um4xVWo5c2dkZEFLVkZJMXNkNG9LNjR6ZXFVdXZ1Z3A1aWo4SkFxY1ordDdW?=
 =?utf-8?B?SFdJREhwVS9tMERjNWNlTjBsR0xGQkZ1VTIwc1J5ay9TbDBLOTZVQkpmcng1?=
 =?utf-8?B?eVZwdzZPaE92MnNmSzQxTGdjem5kUkRId3RydlJ0VlBXZWpwRGRGc3NvclAr?=
 =?utf-8?B?SitzSVo4RVlhSnhLMlJxaUtJZlE5QU81OHdkRnd6aTZxdGtON0N4RWNQNW1m?=
 =?utf-8?B?LzB1WFhBT21wMm1wTnl4RTJNNWozL1BrT3NsUUxmM0syN3A2ZHg2dGU5RUo3?=
 =?utf-8?B?T1VDeVl0THRXcDE1dHBDeUNVRnRWYnlzMmVpRE1LSnlwTFdUU0RYV0h4RjBx?=
 =?utf-8?B?RDZYOWg2VFhzMUFLRXdqZmU1WE13YXBSclJ0Qy85eVdXMFJnVDNoMmxPMVEy?=
 =?utf-8?B?TC9HNHVJdXFhNUNpL0NUNHZoVUh1TklxM2JMRSsxakVwVmQvanJyQXlJaVFH?=
 =?utf-8?B?VFRDNVJMUzRMT3FtdFVST1A4V3I1N1krbk15b2xkRVFVc2k4V0E2U0ZWQWxC?=
 =?utf-8?B?YU90Q1NoK2pBV3YveGszR2NYR1Z2QWNJZURFNktJcmt3YjR5dXRSL20vSDhw?=
 =?utf-8?B?OGRWellvdTZjQUZIS0RSSG5kTjRYQU9PVG5aSlhxaXBLUVV5OEpIVGhhT3Rv?=
 =?utf-8?B?bHdlUGU4OWF1Znk4K2grRzNCNE1FUHFnUVMwUzg1YWFPTklvaVpkVFR3d1pr?=
 =?utf-8?B?d25wZ0p4eS9WZnBvTXR1V2k1d29PblhOQnpPRGhVRTZiT1g3Y3JNajlHS3NU?=
 =?utf-8?B?TGhTOERxazBjcnVmSXZyWjdsODhudlJIT1V5b2ZkT29BSHRaSytOQ1diOFZ2?=
 =?utf-8?B?UmZZZGN6MEhpTWIxeWFvZTRjZnVxNWg4dUlQWHZjRURlV2Fnb1RnMzkyOXIy?=
 =?utf-8?B?akVDY29QUGJrQjJBUXJ5QWxBcEpranQ1RGUyd3kzSzZYT2NLWmxSWklJdjc0?=
 =?utf-8?B?cDExYnMwK3pXdllLY2lDTXEyY2JrVEd0ZkY5UGhCbGZ5UHpORGlGNFRBY0VZ?=
 =?utf-8?B?YWFGeTJ4QkxLVVY0eFdMVVA1UDVEQmxpcSt5eVR3Z3NCZW9vNHNHUFRkdHJ3?=
 =?utf-8?B?UDBFemtiRzd5TmwzdWtra3F3b05GZGJ1NVBRSk43dThGWDRXMUNZeDFZbi9T?=
 =?utf-8?B?M25PMWw3YUlteUttNG9WR05xOWM1aURheEV1VW1sWDdudGZpanI0VUpDUCto?=
 =?utf-8?B?RXNjTFpOYWpOTUYyMU1ibi9MZGI5alZHL0VtbkZlelJuZ1RXbjJha0JWRzRZ?=
 =?utf-8?B?SE55R1BMeG9iMGVPelpva21yV2hMT01JbFF0dmZwR3QvL3NNTEJ3V2Foc3h6?=
 =?utf-8?B?YnJjb3FnRW5paG5NWFNoVjBGQzF0bGhQZmpBWTE2SXB5Nk5La0ptQThUY3dx?=
 =?utf-8?B?YTNLdWF0dGhodGl3OWpLRVZWMlhiVmUvR3E4Wkl1QUV1WFRQWkFuZUdWQmVw?=
 =?utf-8?B?Q1ZiQlYrbnNSMEJQL25FN2RRUVkxdDJMUVBraGx5TGhuR0JPWS9yR2J5MDNi?=
 =?utf-8?Q?kUEtNwtBlVsA3bBytV52C8Chl2alMlwf7ghvXGh+Dmws=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fbad9d-0526-4a23-5f22-08dc127a21de
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 07:51:36.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0836


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

sys_ctrl: system-controller@7030010000 { compatible = 
"sophgo,sg2042-sysctrl"; reg = <0x70 0x30010000 0x0 0x1000>; pllclk: 
clock-controller { compatible = "sophgo,sg2042-pll"; #clock-cells = <1>; 
clocks = <&cgi>; }; }; clkgen: clock-controller@7030012000 { compatible 
= "sophgo,sg2042-clkgen"; reg = <0x70 0x30012000 0x0 0x1000>; 
#clock-cells = <1>; clocks = <&pllclk MPLL_CLK>, <&pllclk FPLL_CLK>, 
<&pllclk DPLL0_CLK>, <&pllclk DPLL1_CLK>,; clock-names = "cgi", "mpll", 
"fpll", "dpll0", "dpll1"; };

```

With this change, we describe the plls defined in system control as 
pllclk, as a child node of system controller. clkgen will use pllclk as 
"input" because pll clocks are parent of div clocks .

But there is another remaining question about the gate clock. For those 
gate clocks controlled by CLOCK, no problem we will provide then in 
clkgen, but  for those gate clocks controlled by registers in SYS_CTRL, 
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
     clocks =      <&pllclk MPLL_CLK>,
              <&pllclk FPLL_CLK>,
              <&pllclk DPLL0_CLK>,
              <&pllclk DPLL1_CLK>,;
     clock-names = "cgi", "mpll", "fpll", "dpll0", "dpll1";
};

```

So, can we put all gate clocks in clkgen to simplify this?

Thanks

Chen

> Cheers,
> Conor.

