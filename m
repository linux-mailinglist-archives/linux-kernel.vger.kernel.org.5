Return-Path: <linux-kernel+bounces-24170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C474B82B87D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE22EB24F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A07F1;
	Fri, 12 Jan 2024 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U8+Sx7ov"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2061.outbound.protection.outlook.com [40.92.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD962A;
	Fri, 12 Jan 2024 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNe7P51xiotUYISj5QbJm7cf7PrgWATpDO9UqnAQZF7EH+JebSgY0Fral9RhCOL/A+wJ2ONCcEbDKmESJbVo1TYluDYUenLLdxadhJhLPpp61qN5RO9hIOa7UzfL9ciXGbbDfCSthxXnYk1eN8jUG+jpFZPNAbzn1L8/rvmARw0ueUq9odKpMvUQj61y/1Ebh2M3keEt5xqYit2AoumLcc0A94MU/BeHdDF/dGflFzta4gm41vLV2fXuJt5Nyz9so+K+aQUUtd2rvmu2+qFQPreOz22nCjtchM7c8x8HoYfZj0Bp7RTmabynMwTk1HBo0CTBBSQFjl23JPI+bpLIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9kVQZnXE/uUOfQbQSwcJbg26xZPeHWzcal4YdTT9Ro=;
 b=OpSPJRiwnrcigUwK72d/xxRu6V+aFR9eIyJZ5DzDVtNFniJ7F7qu8Pwn1cdafp/HBBcZ15Tm/b4n09ntJhX/T15MqeHLSx7gwvAma3r/RdjAj8Z7SOElnh6oqmd+TduoZrabh+l11VyQ7LY82IBB10C57yAibGfitcstiaPpevdHrB3zbz/usgZNdT47ijVrc0tyudF3dWBfrLuvhqVnbHdgkKfy7if6ofIXgEMlFtjim4yjm9Kn3dahKXWl/hlEY+vURqv28mhjXcAQpfdgc3Fsh9VSSfZSVUgu1WIyae0JoXWMuB7Kyixp4TxrBH4La56D/3KuCztxO8xMqhFeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9kVQZnXE/uUOfQbQSwcJbg26xZPeHWzcal4YdTT9Ro=;
 b=U8+Sx7ovNLzKwQX1lY9cji3dA3Rg58O2d4uDWZuXu+DIh4zBrzfHJ3SvLc97WyfAU82HI8M/EMQfUhwHFci5MhI5MspnyGop+loHmJHgmUVeEQu1eLZMm+PKWAL15sKirfjH2LQP6qxWahUQuBmF947qE17jeblt/W2deQgOMu7saOqC8uLiRSOlTOuFPr06mcvhOWLnyPqESOdCa6839miCiGSOL8OJoS2WZH7hX/z7vOSSqqPWBhqN/T5feNgASc1aYUhCMva6QDvzKjW5tUtmuMChTCUoac7/ltggFvLthLhKTfKUHPYs3UU1BmXOFXyW7BgQeo2RwFCLnoXcWg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB0436.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 00:08:20 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 00:08:20 +0000
Message-ID:
 <MA0P287MB28229BCC9EA83507B99A9F3BFE6F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 12 Jan 2024 08:08:15 +0800
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
 <MA0P287MB282224A6097B4FCCF721C89AFE682@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240111-jolly-prize-930931cc648a@spud>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240111-jolly-prize-930931cc648a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [7Ro8edSJX28TDvykVjkNY3YOxshrW1Y9]
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <e4a18848-4f1d-456a-8eaa-dc5b2168ad13@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB0436:EE_
X-MS-Office365-Filtering-Correlation-Id: 16127ebf-f67b-42bd-39fa-08dc13029493
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VR9SD13ptM95FuVFBHrHCKrYdwNzUATsuRLslMOJk2yaCDuKPHuXLzmRsgVaQXP50ec0LTmaFycERw9hM2ofaBZ8u4A9uUZ6UEsuvY64uycfglL+omuKVYqYNA5WqxXJf16A6v4tC0vlvaM/ebEvNqkSMN8Dq5Ov00CkUpoR8AoMfS1sSF/WI0CW3IBJ9ohB0fw6/7K7MgDq6faDNwUC4QuWJ1lDdqRjJbYPFWhHBHTxViP6bTE3qG2dYsaVtIDoV5dJICK0xm/XE0b2ue5rZwCBXt3Y96PTV8MGN0Mv5uFqvI4PaAC9LxWgDL1NYPtsaZHIJACXLpoi1Kcii+wqtWxw+nOkVkVh4kcM7GYUsicbA/IahM/TLFRJBA0ZBYXQY6qwmPT0Nv+4rxEFDCm6jsRruAxusxR3PLm91IWMb+YbjMmeiDKY+mLDhgG3vb49NGEgoavM56aj3EuNA1QrtQ+BhMWH+VX/PgJbyS8fGGRkirsEXLENezbaBScIX73siVTcR+exLq1bYcnuUiUgWVxQP/h5izPdqgktjdYa2PCl5LpqKelI6WlNDpLz/zUB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REFHS0NEdXpGT0xrK2NGem04WDRKYXNSUngydXdEVU1QZUFrYUVlYmJIczd2?=
 =?utf-8?B?VnZSNkRIKytnMFlXM1hXK29rY29FSnNKODlUZS9xb29vNXZVb3kzbUlIOFdX?=
 =?utf-8?B?R1ZEWWpxQWtsSmRrYkRsVHlHY3RoeUdybmp1ZjRNc0ZnYVJaS0t1dGgzZmVK?=
 =?utf-8?B?K1JjL0xYU2tLOCt2MDZLTG9WWFB3QmlsU2NjVTZqR1J5VXdLWXdsZm1zejkx?=
 =?utf-8?B?KzF5eDVzR3doMTN4c1crMm5RNUZ5cTNMd29RSTNVMkJsNTdUL2FLYkVNelh6?=
 =?utf-8?B?YlFDVmZuWTR5WFdPcFdKTHNNbzVQbDB1TUxlQk8yeEF3TTlvZnJZZjB5SzV4?=
 =?utf-8?B?dEl0OVplM0VCdEU1dThnMlltR2pLeTY4Ui83Uy9ycTQ1MGlaaTNnaktRUHJQ?=
 =?utf-8?B?VkZhRmtDbFdSNlNMcFB6bmJkekFRR3BudkIwWTRKc3JFZEtWdnBwRTdhTEN4?=
 =?utf-8?B?OExHa2lPaUt3SkRGcU1idnZtTi9UczVIQnFNcHhYQk01ZGdOOWJmRWg5Vlow?=
 =?utf-8?B?c3Y3MHFmcjZ3eFpTZlZEeEs4cEozSDhGeEtKTjl6NGpjV2FaYXJkR1pqTjNU?=
 =?utf-8?B?QzdIbm42aVdySkFkK3gyVERLa2pFWHBXM1dGa0lGQ1Z4OWROSVNpZzZOSjd1?=
 =?utf-8?B?QmlmL25oeHZrWkZ6SlJWeFUxVjlJU3FGSmFqME1OZkhjWnpqQ3FpV2o4SE1t?=
 =?utf-8?B?bmYxMmpwUStRVng3Wnk2cEU0UnREVHpJUTFRd1pSY1kwcjQrRUV4WGc4blAw?=
 =?utf-8?B?S0duU0NDTDBrL0ZZeE9hWE81d2ZSVFllRlUyM0hFWi90VGZQYUtTcUJQN3B2?=
 =?utf-8?B?SU10MkFYOFVaM3M4MmI0Z0pWVjdJR3NNYVJRbk02MmhheGR0dzZMTzJoc0ZK?=
 =?utf-8?B?R2wzbkpEb1BVRTlyKytCbysweDJzUmpWZVNTVVRocHA5S2FaakcrTDQ2R0Ja?=
 =?utf-8?B?MVpxeXNydkZ6NFB0cUpFc1o1aUVmeTdHb0VBejliZEZscGFLR0k2SGhIcThK?=
 =?utf-8?B?OTRrR3VsVWtPZWliaUFOaEE2Yk95eVlIeS9Fb3d5YnJpdW5odlFRQkg0QkxM?=
 =?utf-8?B?b2t6TElzNDI0bDV2VmxDekJnYkg4MU1wanNuOUptZHBlc3Y3V2xIZTMwd0oz?=
 =?utf-8?B?bGFkYUlRandHSms2a2VNVHpRandwaXFkVGs5ODRIeXRqQkV4TkRjYno4QjdF?=
 =?utf-8?B?YlczVTBaUlBkTTh0RW91UlVIdDRvVkl5UVVidE1FRk9HRE0xUEl0M3RTYSth?=
 =?utf-8?B?bWcrUVJVeVdFZnAyU3dkOG5ETFNJUlFna0tLQ1FQZFRBRUV4ekpvcDVvdjFv?=
 =?utf-8?B?aWZ1N0RxNkp1YUNsY3pNZndDVFQzblFxcWtORjQvRzNYTHZyYUNpMlNGUy9T?=
 =?utf-8?B?eWNXR01oYUhhdGs0Mk5JRVJiZ3pYZ0VRdXJMTXZ6UlVXdzd6eVFsYmFzaitl?=
 =?utf-8?B?WElqSTZyUjlNUmo5dHRxMU1lYVBFaDA3N3JmbjVKYUZPQjFNVGc1cEtiM3pi?=
 =?utf-8?B?Q3JuZDlhck9ISVdQc0crOUtRSFF5Tms1TURaeUsxejQzd3hMeVM2QU4wT2Vx?=
 =?utf-8?B?VlpDMUpPUFJEcHJVODZ3bGl1NGszTXp3THZNbm5BVTZvUmFZMTg1WVZJVk5U?=
 =?utf-8?Q?ZvsZkVajzQ9FQHxbdRcq/uY3Rc+5y9dw36MDhkSOH4ok=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16127ebf-f67b-42bd-39fa-08dc13029493
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:08:20.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0436


On 2024/1/12 0:58, Conor Dooley wrote:
> On Thu, Jan 11, 2024 at 04:00:04PM +0800, Chen Wang wrote:
>> hi，Conor，
>>
>> There are four types of clocks for SG2042 and following are where their
>> control registers are defined in:
>>
>> PLL：all in SYS_CTRL
>> DIV: all in CLOCK
>> GATE: some are in SYS_CTRL, some others are in CLOCK
> When you say "some", do you meant some entire clocks are in SYS_CTRL and
> some entire clocks are in the CLOCKS? Or do you meant that for a given
> clock, some registers are in SYS_CTRL and some are in CLOCK? It's the
> first option, right?

It's the first option.

>> MUX: all in CLOCK

