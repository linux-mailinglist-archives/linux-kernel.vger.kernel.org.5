Return-Path: <linux-kernel+bounces-27337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF08D82EDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E411F246F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F71BC5C;
	Tue, 16 Jan 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aVtdOKKH"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2011.outbound.protection.outlook.com [40.92.103.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0891B800;
	Tue, 16 Jan 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1dWFzTvzJG+PQD+b+X2z91q8ejtQxTg2NLPRtsYygo50erX6/nx33PMgG+T4wZkHa3GMqEZdMlYiPbjFITzCJJQ5zJO9tE/gjygzOetUwnBES6FIblB7QXa2kZBO+Cbhgf7pssJm0P4kIf/xqSxGy/YXYPLRFsiBdm5esQ3zpTc29synS6eUkcCrVUARVqg7bKoERBn/Nd+QwkR26nPiQOINQrsOCMXL6gqrrNqERJCQsrVH8vDpfk9indOOlU/zXg5dimtYFaWlDrY8IeoEf5/OInRHHIOI/pJIvi/+LnbKxxFAf7+9ykjBoMyRv8CrrWGrbk2tBjsob4jw7Gzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OzH72il6OjBv1RX7nVH1YTZit25IECfY+31A3wpbk0=;
 b=YEu+GaqTGSe0od1MxCqW3jyabmxsZeU7re+wzFfiHzHFfKE8W4RRxMQ+tdrkho6KQf3UA8CsYosLWPzwkGlRO6pTVbgc7DbUWHocDdrGpQJUFQH3K0+twVHwCtPI8qsI1276hhZHF8Vpyxi75QIbXhJp6m4fdGY05HdKqs3CMATlKIN7ntMlla0sxaLOSufFpI+uu0mYDC8/Jx6zeAIrLCYNob0qTb6IdyOA8SyTTE0XkrIaqLseEZGrAXbzxQyC2qeu8UN9gbfdo7VZLvSKNHaAx7cKlqImpznecT3LJ4f3sXYw0pdZRTUZCHz5wqYEG5YkThLdiPR5F4aoh+U4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OzH72il6OjBv1RX7nVH1YTZit25IECfY+31A3wpbk0=;
 b=aVtdOKKHRRoAgf5ZRQxcjNpPhGwII/Nt9dTedtc29iIKBnvR/E3rGv5eC+Tco0wuBReP+V1+Q6l1WQoaZ95QrnRaZixAhJS4AcaH+Vw2XSub2pOA2SIeDkjkhgRUQkI8ge0NxmBhnFrooX+Yr6guXwfdMGpibbU7FSpwIUhyVdhrW9htx0EwWDB5Qep604DtRcjhkmrEduUymHdFbydwBcFUhOusBJzDPH4t6HrQjlxZTFG0CMiZRZpDTnweTZVqJLowm83UfTRJhf7wABxT8qwtRm+BpsLfMhexrgOkDHgkkECGurkHBApoEX3NqO6aAJEyEzrSxfZyD3uVJwdM9w==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1847.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 11:39:50 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.027; Tue, 16 Jan 2024
 11:39:50 +0000
Message-ID:
 <MA0P287MB28223124A3B5F121EA9055FEFE732@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 16 Jan 2024 19:39:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] riscv: sophgo: add clock support for sg2042
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
 <a9f369bf-48ab-4b6d-bd9e-b51e47bbe535@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <a9f369bf-48ab-4b6d-bd9e-b51e47bbe535@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [OYbHeiVMaJteuo2QkdC+6r35LSKGphfO]
X-ClientProxiedBy: TYCPR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:405:4::17) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <40c794f9-0f7a-4ee1-8105-6274be92c7a4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1847:EE_
X-MS-Office365-Filtering-Correlation-Id: fdaa63d8-a198-4867-ca3a-08dc1687d970
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RKyUymoz6sijufIudk4gxfm3idYg/jivDB/cKulHoW+ePip7NktLw19vKW5omg6+Pq5EHMKTZ9FFQ/0y/GMiOEA+z6Qgbuhzc05gXrT/VfKVfhvrgFIISfaF6Q21kta7diGQ5yI7aooJatE9J3nwpkqY/qHL285FbQfJzthmJT+wfxVZseAkpKPOXMj+5d2SqMmRHUrszqT7d5bjRbIbOJMeHpS7WBoFPbKVs7PwSWH02WbYdOsRePwyezgFkLkcKcj0oLF6ebdPul2rqijwDHGamLexw/Ce8ZiTStt+F8Yu5lD4k4/m29zagMMIuspIQxmSyek3IGpnx3RWLH8Wup9FuUN6tdtWsnx/8TOGXMqlBBk3nx1Rw35X8Yp7+KS+gyvINRHB+QdR5GT9ptFdvxBHBN4Qq10UPdwHQfXwP/K5UHAHVYHLOR7B27Nw/M1wENvVykjEy7hplnXq7YXtc5IlB6EHJE4tSkYTTFgDdLWvaWnJM0EBY1JI/1xnLsX5yS9Rqnaqre+oTEu1/b/yFEp4B74/5ObAMEim+x1u/JcJY5zdk+Tize5wDu3akGHDZZ6fwDTMalGadrCQ0KrGXiH3rY7w2raMucq85tA8U/oyl8Xke7HISpXWG2clCScj6gDbAcjWpTWhNyVanqnFtw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU94R3M2S1RpbnZCSHFyS290djZVbDZEL1piSkQzMUY2b2lNc1FxSTR6UDF6?=
 =?utf-8?B?bHA4OStxZnVNQkIzczlHUkk2Z3J6Rkt1d3hBVEtvNFZYdUlEZXA2ODdkVlEz?=
 =?utf-8?B?MWtTSDQ1VE1oajFMejZUTVljcmpRQ2lRYmNsLytyUzZHTi9kcXoybFRaS1Bn?=
 =?utf-8?B?azZyVkFmckczOGhlb0RmTURrSGtNc2VqeHFKMGJyNWNmU1YwMDZJaFFLYXB4?=
 =?utf-8?B?RGFsSmpjVXdSaEFYMTlJU29zUDhXLzZDZ1VTTjIySDZZVU84Nmh3eG4zTzU3?=
 =?utf-8?B?eWsrbEFnTC9TR0tXcjBWYlJKUXA0YmxOS2tPT21oWjlLczkzc1J6TnNENmZp?=
 =?utf-8?B?REFwaU03cmJ6SC95YnU1WUN3RkZOd3psWGtySmlBSE13Ykg4amxOd3JMSlpF?=
 =?utf-8?B?bSs0eW1yWDJVQlE4cGhVeWZhYUgzMGdjUHIzQ2VNK1JNUGczeWIvYmFnZDhj?=
 =?utf-8?B?ZkZuUkRuZWRGdUM2T2crQkt3UjhQUVJkSHNwTys3NG1LWTdOVG0yaTU2T3Iz?=
 =?utf-8?B?eHRIOFF2V2MzbmdwRVpBVktRZmZaZmJJT3V3ZGVBNktxa2NyckZNNGpDQi9T?=
 =?utf-8?B?cHNTb0ZpeHc1V2RZUGV0RWxBMTB6MmIrNzZjTHkwS1ZkenRGNXpYenlVSlNi?=
 =?utf-8?B?SExQbU9KQlVxSG4vWDhybmdRU1U3Ly9HNHF6bHRWS0VmWnBEVmx5NHNmQ21T?=
 =?utf-8?B?bkhyYk9ENVd1WGVxOHF3bGM1ZlQxWk8yS2ljS0RPTms2eWljRWpQZFhhTG1z?=
 =?utf-8?B?SVVlb1V1TmtZN2Yxd3FpYmFhbkMyV2s3RzN6SFdTKzVBVUxEb1VsZjhDMzJY?=
 =?utf-8?B?d2l4ZUZyNUdjeVhHL3RuK3VXdEpKTHBXcXVBdGd6KzFlYTkwM3N5UHpvZUVo?=
 =?utf-8?B?UmpBaXkzd2RtM3NQeTR1N2xzanMvbURkOG0zdzFocGxPNjVJUEFJdlFsTnlH?=
 =?utf-8?B?MUk1SDlWSUdrNU8wOExGSm85U2NWQkxwZmVWd3RrN2hBMHdPWUpnbFAwQ1VK?=
 =?utf-8?B?SjBNd0dlTjEyWVFHY2MwQUlZNmpEd0tENCtQRzVYTFdhQzRMcnp0bVN6a0Rv?=
 =?utf-8?B?bHBnNzdFN2JBY01XYU1nYWVoMTNxVTlwYTVWaGl4andYZkVEOXp0bUJiM0xC?=
 =?utf-8?B?emJuekZRVUpqV0JqblhOWXNEMWFTUVY1M2xUOExLL2RyR3FaQ3NuaVpwRGJY?=
 =?utf-8?B?eXNqVEF3a2NtbWZCWGpoNVY3R0JSOUs4OS94aXNiZ2pPbkJHQ3JPdDNTRm1I?=
 =?utf-8?B?blZtTTBHVUxRTkJDR2Z5N1EwSjMvTDA1TFo1QW93SEh3ZGNsc1M1ZzlqYk1L?=
 =?utf-8?B?bkF0NXNOT2xwU3RVd25VbUpZV2lmeGhGRkdKVXZJa0ZQeS8yOE5kK0JOTUdF?=
 =?utf-8?B?R1VrV2VvczEyTnFJNlhnNzY4Ym12dFNDK3hZUmg0UmZITFh6MnVvbXIxclVN?=
 =?utf-8?B?SDZOSFFwUXdZZkNncVpNNkwwL2FTYkdKV3kwdmxEeVQ2VHZzRGhBQkcvR3VG?=
 =?utf-8?B?OG41dmM3bGIrLzFkQWlBV0VlalBwa1RXYjlWeHVHemJLTXRQRTVQVGY3RGps?=
 =?utf-8?B?RmpwLyt0VU92YjgzZVMxMGxNdlJmWnJmeUZOREJsb3JjUWoydXlMY0xVU2ZN?=
 =?utf-8?Q?B5izhvyoCfg496O0eTObPGF2PF3CYS6fJBApVGj/A5WU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdaa63d8-a198-4867-ca3a-08dc1687d970
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:39:50.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1847


On 2024/1/16 17:47, Krzysztof Kozlowski wrote:
> On 16/01/2024 08:20, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> This series adds clock controller support for sophgo sg2042.
>>
>> Thanks,
>> Chen
>>
>> ---
>>
>> Changes in v8:
>>    The patch series is based on v6.7. You can simply review or test the
>>    patches at the link [9].
>>    
> ...
>
>> Changes in v1:
>>    The patch series is based on v6.7-rc1. You can simply review or test the
>>    patches at the link [1].
>>
>> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v1 [1]
>> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v2 [2]
>> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v3 [3]
>> Link: https://lore.kernel.org/linux-riscv/MA0P287MB03329AE180378E1A2E034374FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/ [4]
>> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v4 [5]
>> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v5 [6]
>> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v6 [7]
>> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v7 [8]
>> Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v8 [9]
> lore links are useful to previous discussions. This shows what was at
> v7, but I cannot see my comments and compare whether you applied them.
Ok, I will replace them with lore links in next revision.
>
> Best regards,
> Krzysztof
>

