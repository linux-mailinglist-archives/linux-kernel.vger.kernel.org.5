Return-Path: <linux-kernel+bounces-21596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E86282919F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AAA28681B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AA981B;
	Wed, 10 Jan 2024 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PXDeyqxd"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2037.outbound.protection.outlook.com [40.92.103.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0823B1;
	Wed, 10 Jan 2024 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzZ+1lPiU4ZSOS89m9PsEVAqLsEltxdn/547wAWnjXw8RaYkqxPGlw13emcrGY9bRkdE41NVIm97AIgur5QGY66ClOpr0BC8pLkXP8RVgx5DJsJDlZD7UMm7AF5OeNxIATbHvJF+HKvIltzQ+YvTdwfl8NIAj7m5jZsZY8C3cS10IwJIqbdNRDpwryAFGNogaQxGKd/lG/EE+I0jdGmaZW8fyTPYNsvOPH/qF7z5+rIn1velRBRrpfX6MVaWEsgRF8eNOKf2i6kOvWjIyZl5HPrW6nw5SzyoUBDQUWD3qyiEKyXjyCljzadV5lYkX0ZAfWafhsfdItckIQ7M1SxDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNuELUNym48UJ072ZAZ61tHoFZZCQ77oowsfdKiNtsk=;
 b=JSVCHgd7evXMwZGP0xG6FCd2J/IXcGGLKJDl19WEtHUYeyu5jfaryR6Ui+5xLdKPJtpyj5nweCaIu9n1AiReTMRZsHL9LBmLlb/eGeO3iDKe8g2UWKkSQgKj6Gb4auuH/3kZsJASOp2Dv6wOKS3dxsQC6t7j3q420Gw8noamePrMBcIOxX5t+wXYHRU/PcjNyA9zbdBLbNRo8COjk6bo/LHuMeuPt1XvBjE4MUapQL66QM8fE5LO0ca3lb8tc4HIF3ixsrzFiHztm4Tln+PRBg9WT3zYothbptEcftOvNkLUk7GzgBdPcqvl7BQe/RMEPaSL7qSlKpVXgyEF5htfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNuELUNym48UJ072ZAZ61tHoFZZCQ77oowsfdKiNtsk=;
 b=PXDeyqxdeUPYxhaLIPSgFxCNrhVDeMOIFsO48zqpRTFULVhyGe68ypRjO9eSyQE6OsK7iSgVtPtN+Z0kZ64h+b/AQCFAG7/gGL94YEhPb8IsYjS9ccQhxpFwodq0bidyITtPSYZ9x2hmCAEb+vQO5ZDhpAIKCQJcoX/UHS7Js1TO75z9opPtuDCBYxtEmcpzt8X9fz3mFGl+10BdBneDa0e2vncft8jSH7YahY5LcV08P5qesLyhlZTRuNGXmsZb6oe1gfhwun6hcS6Xjevqdd/QUqDBLG10rae5J5GCJjeh6wKWRLewFpJh5WWo7J7RXPDmCdYpldmHl+OQ+tUjYA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB2195.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 00:53:49 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 00:53:49 +0000
Message-ID:
 <MA0P287MB2822C7A3C1DC7786708E860BFE692@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 10 Jan 2024 08:53:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] dt-bindings: clock: sophgo: support SG2042
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <925d99d5b4ece01337cb3389aaea4b631894dd1d.1704694903.git.unicorn_wang@outlook.com>
 <f88b79c3-e44b-4136-ae56-10e1f2502e2d@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <f88b79c3-e44b-4136-ae56-10e1f2502e2d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [o5q9qnyUVBjD/JGz7KIBvW7mvlmTcjZv]
X-ClientProxiedBy: TYCPR01CA0181.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::10) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <49375060-3dde-4e64-9aa5-912e1b343d3f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB2195:EE_
X-MS-Office365-Filtering-Correlation-Id: 8619ecef-59eb-472a-a06b-08dc11769b2b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vsAvI6Ql+jiCmn63i6r82kH8QiLyu7V3d2bxyKHUIM4gTREFZ2Qbb4w+zzEZ0Y/3PsCzeC5udkjnZq/O5KouxBhFn2O+hq1y7/PVyRSeJ3VNMtNhj072KGpkJ4VOZBI0Sg0cyk+zWQxWBwnwd8vmwe6quxx8y0IXykNpI7sTEkK8m5Kpn48+G1LA2cQ2UBr1n3w+V95LvqfkQdTVBZjCPMJaixW3wbShe7KOp5AtfBjUtcYGkA0Y15d+mB8QLhnMfSOiAgMn11MuOTMAaCSvR1mtkgJl+jPZPMsR4YlBniCfJDgvTRLmv0HQvM7vz2dJAH0Jv93GnIiNfFXVRKEptHXAJp81G5nztxOgMSEx5dTzBDP4isLHHoQ9mkgpp+GzoSSuWpBFlMLciB7RSJDEOQLjFkdMJUoGQucs5jL+9Eikqa827M3UZB6K/dFwIXswyBvhXZ479jAG8BiYBv24fovyrMjh1xUDU8XxO1ZWXx2f+yV7lxs2cCKn1YXmH3ewTVfBbG6Fr16hfRXEZTdnKWJxDndFu3LsvsatHg1MUW5czUrahhMbFvXvMZsM9JCLngtNlKy8MSPyvvw6SJf+EXOnvM1+wM2PKmhgkKARklM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkhTZzlmNXZvWkhRR2p4VjhPSE1KcEVZYlBJTHo3VkQzWnp5NlBwdDRBR0FG?=
 =?utf-8?B?aWZBLytZaE1hU0dINHNLcUZoZzV4UzE0OUhyM1BYamU3ZFFkRkMwZXdJcFl4?=
 =?utf-8?B?QjZPQ01uL0VxV1JLMERDU1JRTUREWjBNdHNvbWxNZHhWMkI2UHFKNzEvUTRo?=
 =?utf-8?B?K0Y4S3VIUHBZWE50VFQrRjlUYWNjck5xT2hpRmpzNm05NUovb0NOa2J3TTQv?=
 =?utf-8?B?RGtEaExuYWk4cXUrcCtrUkZ3RWZCVStqVWxOa3ZPTWp1WDd5ZURwOGl3d25I?=
 =?utf-8?B?M1NQcnR1c3FLQWhJaEJiWmFYUGN4eGphMEh0aTZvYW5nTWxBUXFRVlkxbDE0?=
 =?utf-8?B?OHJLTGUwOW1Cb3BXMlV0UFhkM1hwcmgwc3YvTVdZT01Nc0lobTd0ZFhrazdL?=
 =?utf-8?B?L0w5cklOSCtHUExTMUw4VjQ4SjNTVTBUYWdDd2kvalNITkc3QmJNZnJraWtB?=
 =?utf-8?B?MHM4RDcvdW1pQ2Fqb3VMODFlYkFXZ05VSk1SSjZIUHU2eFJxNWJnV25MU2h1?=
 =?utf-8?B?aXVKVThRUHVMWTluTDJvYTVpTGFrQ3E2eXNOS3p3dHdGQUNiREsvR0xMS0FJ?=
 =?utf-8?B?TlJjNzlSTHcxTnlLM1BjV0k5MTl0Q2Z3dFgyclZMNkFoRDRMNUZabzYwZHlZ?=
 =?utf-8?B?d1pKblljWW9Qb01tZU5NSm9TNEtDWWtrTTRCUU1LeDU2RmhWTzMvMFE3UURU?=
 =?utf-8?B?MjZxYVBxbFlLRWdmMlQrVSt2S1ZBRkREdFdsYUEwOGhYdHhoNmxDSkhJREI2?=
 =?utf-8?B?NytuSThDSXhxV3IrNnNLMndMM0IrQ0doYW9EN3dNM1VWOTBXaFVtY1Q3V2VJ?=
 =?utf-8?B?SEZIZnpBVlRwSzY4ZnEyYldTOTZ2RXJneDVzN003VkZGdnQ1d1BiblJEZ3hH?=
 =?utf-8?B?aG5kSjBQLzVWNmZpYWRxbEdlUjZYampIZTB4NFROTFplbU1PdXI0Y3pHcUN6?=
 =?utf-8?B?NFVDb3JVVFBDVkJEK3lLUjFoU0dPcExBdXZDWDZsR0ZvMmR3SzVxdlZNYlRR?=
 =?utf-8?B?V2xnTjh2S1NUTU1VY256RXduMGVMR3ZkZXFUMVg4Qitvd2JITFF5Rkg4aGt1?=
 =?utf-8?B?dnJWRHRtWHUwdTFNVkdYQzB5NmZnZ3dBeHp5eFRVZG83aGttMGxocHIyNGVp?=
 =?utf-8?B?QnBSU2ZoWFcwV1c3V2lIY0R5ZG5iVjF4YnVSVXQxMUdtVTk5Wk1yaDljLzl4?=
 =?utf-8?B?SXRvUnhqMGY1R1gyWUR5dytNT21IZlVYY3J2RXVnd1p0YzdPSnU4RUk1NkI5?=
 =?utf-8?B?TU94WFNjYi9hL0NwMWZUSldDZktBbkFOS0tUQzRCTnFVcDJyWkZ5M3RkZ1VT?=
 =?utf-8?B?bWJPT3lMUTNuWk53dlNRWVI5ZWRLc0liK3dmOTdibzZtSVU0MWI2dE03b0xm?=
 =?utf-8?B?VTJWajY5TkZBOUlrMnZkMVVuMzV2WEV5dFY1NDFmWGxBUmhiejZrNFZCVVNE?=
 =?utf-8?B?b1EremdwWm41eStkcnV1OXpaVTdpa2tSSnlTbHFjUEJHeHVVaFE2RlhFR0tG?=
 =?utf-8?B?UGhwMkJIWGlub1U1Sm1FM0xDOHl2d0JibHV2Uno3dWFobU1oc2J0OTlVWDRj?=
 =?utf-8?B?UWNZME5ZWC8rQkpvSEE5UmNKQlBYak9ZdFIvbjdIYTk5K1kvSWtQdHZpWmVG?=
 =?utf-8?Q?w0d0TfH+tcuIvLuJkrjzZWUzdVCKyOFHd9g7ToXMntUc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8619ecef-59eb-472a-a06b-08dc11769b2b
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 00:53:49.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2195


On 2024/1/8 15:04, Krzysztof Kozlowski wrote:
> On 08/01/2024 07:49, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add bindings for the clock generator on the SG2042 RISC-V SoC.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>   .../bindings/clock/sophgo,sg2042-clkgen.yaml  |  53 ++++++
>>   .../dt-bindings/clock/sophgo,sg2042-clkgen.h  | 169 ++++++++++++++++++
>>   2 files changed, 222 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>> new file mode 100644
>> index 000000000000..f9935e66fc95
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/sophgo,sg2042-clkgen.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 Clock Generator
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,sg2042-clkgen
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  sophgo,system-ctrl:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to SG2042 System Controller node. On SG2042, part of control
>> +      registers of Clock Controller are defined in System controller. Clock
>> +      driver will use this phandle to get the register map base to plus the
>> +      offset of the registers to access them.
> Do not describe the driver, but hardware. What registers are in
> system-ctrl? What are their purpose? Why this hardware needs them?
Understood, will fix the words in revision, thanks.
>
>
>
> Best regards,
> Krzysztof
>

