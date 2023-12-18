Return-Path: <linux-kernel+bounces-3200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C8581690F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776DF1F21A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B978510A26;
	Mon, 18 Dec 2023 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p3PmU5y1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2024.outbound.protection.outlook.com [40.92.102.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F1125A1;
	Mon, 18 Dec 2023 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz6jeoWW9+EAJ2w9UaDUhI2gLbCOMmCNBdAzjh9bzMMPQjvvdTFSpF2F8K1rBU1kjdjzIl3FTnKzLWHV1FrJOn76MFZKeRqzxDt/PuWodKcpiazGPsTmuk1qx62xcos34S2nmBSz0li3J10PW4qMsLTJDGTus+xzrDceSqB6mIUvVMLCbMuNd91hQ7reJxkMeoAetgp0jvid2t6PkjbR3l0hEXyv27zGu7DkpORUoSy/3GhfrRAzjYFam1X3LmpdRBt8+h7yoSojQC81RRIBr7727+ucW2GobXvo6gnnOEcMZpeH50b9aNJF6kKLVPNu43j+O60kOR0yFhQecrLZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdsLKFZllj5am9ey8Y6lQBE5tT85FrHO+rNiYLQapho=;
 b=JfK/v63CiUObiEEI817nGLgOi9wkz21yTOO8UarX03k2aKxGSVHyU3ZFhnaE1Os75FF+WwEb4mSQz/CTUlsFY2fCaRzHchaXX//nnYM+t1wse+mvBTAdSfWmUTgTM/fArPI70f3YQCRnIzrGZSUhF/uZIOQ5I7+oD+QTpI7Boxaz/8NR2eTUAdDJsoz5TKqsBFHcb8c694lHUbcQa7hWjWHdVLP0TGhdqwRtveGzu6UO1kAQnEqdC3uJvY6e6ZvVnrNsshFO5QTPqh7WTy8Q0jp+RKAh3pvV4TgdgsPJ8tfFzEAJabaH0zo9s1dQhJgYCInDTtp0p/sL6WAM8rrK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdsLKFZllj5am9ey8Y6lQBE5tT85FrHO+rNiYLQapho=;
 b=p3PmU5y1NrK+VXLue0+2R9uhRvL4ysK4k6BlNTJxrHOJdiDR14RX0HrIliBHVPwP6GNxllIlHdJIx0Vtlrj1+I/FGbUugz3l+jODWOy6J2wsGw7v/fXEYbre7ro6NrPDhrnci+Wk9qvkn2GNcDQfKuGq3LrB96cjx3tL1kU3N0fFCHgT9Ip7LL/YEo3KemVlfOC4P8+iGPBziuJ5kMYm2lEyD9NEVTRochyLOK7OP4TsuySOQjl3CUHEO0FOPrVy0P2ZUa+ev2MJ0E5Bvne6dW5MC1jsPMWlvpYudwVHFnpvUuDcH1bxv6Wz5ya/OCwWc4PPCrj/7PfklIRZjGWaxg==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN3P287MB1480.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:194::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.37; Mon, 18 Dec 2023 09:01:57 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 09:01:57 +0000
Message-ID:
 <MA0P287MB0332B44AC5FC2A6FE831686EFE90A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 18 Dec 2023 17:01:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] clk: sophgo: Add SG2042 clock generator driver
To: Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com,
 robh+dt@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1701997033.git.unicorn_wang@outlook.com>
 <d1aa4f76f360ebd7b790a4786641f1b0188dbba8.1701997033.git.unicorn_wang@outlook.com>
 <20231208-opposite-stand-fc92fbaaed9c@spud>
 <MA0P287MB0332A937E4DF0044594B19CCFE8EA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <20231212-unnerving-rule-1052a5b7253e@wendy>
 <1b4b88035d7524ad3d6de7c6084e3f07.sboyd@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <1b4b88035d7524ad3d6de7c6084e3f07.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [2NE3vRZQQOA1lCqdJ0JFY+eSdyJQK9zk]
X-ClientProxiedBy: TYCP286CA0173.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::16) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID:
 <2102cca8-c880-4f31-a8e9-568b31318455@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN3P287MB1480:EE_
X-MS-Office365-Filtering-Correlation-Id: feab4b92-16ee-435c-8dae-08dbffa7fc87
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n5jVcb+1EjRW74EcbLiyztbGMZNYm+TNyNePN32h5FWzk+7114LjeiCtQPFzr/Prww8ktWjy7aw4BSumBuJcavCrwzDeKsIvRoZ53hbZAYNWkUQQbJe9qBMjmRD6og+7OmVB/xoNG9v/NcMbrILcmWJmAq1PAH2v97de2h2/0Y721quskF1IRlI3qHVFiwrvDG384FNkC+FroX1kDmwW/mOOycGMdDUCeSPZsYlShUhuYZPk/7Gu4D8LdfwkdK6n4KUnDuGfXtr41CuEBS5XDm7jseIPfSS4Bgogor/9vWW/EEAy14Vwbrtt632HqeARfdK5jvN9uqy1KYZV2W8lZLgVvaiLs45oIXawNEPE5NwQxza2A3P3+1xrFI6Ua3y8icOzANZi4ztgniYqcl+W4HP2tWUOokNUVn2fad/Cd3Dz0Sk5p2vH04G9l5XiIvYVmsP+enFPHRbkAHIM4GYflieXeu6QlYtY1taOwpeZPSXyEjPmFEzcpHBa11brlu752kav97W59wAbR9vxs8kdZx6sfw/FpFCdfNilVPTbec4PZDw1UVRRf9ifonOgnKJ6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGoyTlc0SUtuQ2lubFQyVnRUS3puTUdDakljanRLNTgxdGJoTHhQL1R1azFT?=
 =?utf-8?B?c1BaYlN2MVhZM3Q2R0pvU3hpTVJrQkxEanBUT2c5VGpLUE1IOXZzbXQybVlu?=
 =?utf-8?B?VkpiQ0ZLWnQzcHdzRHdWQTErVzdDTGZOOEZXa0tDOTRGaTZOMExNS2NPMS9Y?=
 =?utf-8?B?UDFPMzBwL2hxRjM1WGgzSWVZVGVnRk5kdnBqa3NjQXVjb0pPSzZwSWhKU0pK?=
 =?utf-8?B?TFM3Y0phWGRxY2dsTHBvdk8vblplb24vYTRJSnVUbWJDVTc4c201VWhpRERn?=
 =?utf-8?B?NjM3Q2phUVlGSklxUTQ2Tmpyam4rUzAwSkdCMjdYWDdBUEU5Uy9wZ1c5M0Vw?=
 =?utf-8?B?OTVYUWxPNFhXcnd5LzlIdC9NMzloNm1Wb1R2bmNjdko4Um8wYmx4bnRUemQ4?=
 =?utf-8?B?YXBGTlNLanlQaXdpVUFtWllRcUZNeFFXbW8rVmJhdmdodnBNR3pxUmNYaFZE?=
 =?utf-8?B?Nzc0ZDBIb25KS1V1SlluOW9uVEZEZnRJbFgrQmRwTU5QZ0ZGbVp0NXBoZ2tP?=
 =?utf-8?B?YnVMSlg4SXRhSEVWMHVIUlB0TThTVmNPOTQ0VnRWbHc3T0xlcHJKdjdoWkVM?=
 =?utf-8?B?QkdJSVJ4QSt4SnovSCtRcHJHbnhNbzc3c0RkNDk1Z0lLZStXV1EwbnE4cmFY?=
 =?utf-8?B?NHA0a0dnT0wrTnAwclhtN1Q4ZEFTY3cvV1Qzbi9nM2s0aDZFVFBYVllXUVZz?=
 =?utf-8?B?QnNSa2RYM3JzbDBnV3ZHS2lqZFRjeGhsZzk0YzZ0b1I4Nks1OUhxY2dGUXJC?=
 =?utf-8?B?UllKZGNoYm1kNit3UlJBVFFNeHZ4bGZ2Yy9aSG94TTFBVGZobFZyMWpybkZB?=
 =?utf-8?B?KzRhbkpMeWZHMmYzRDZPamNia2VCUGZ6eVk4SVFmTEttY1JoZVpidWpLV0xD?=
 =?utf-8?B?aE1yblFmMWttRXBVQ2Jyc1Erd3AyamJNRHhLaVI2Um84QmliblV1QzU3L1ZC?=
 =?utf-8?B?Ui9TWTBRN2JtOFViOEUzc21jbE5rVHd1eTdOenF5enM1c1FSSmowS3FkbDRI?=
 =?utf-8?B?dmhrQU9jdFdhR1dVNnNxZUM2TDQ5WmU5ZE84Y0ZmcjVoOW9UbTdOU0REN3Ey?=
 =?utf-8?B?aXh5NDk0dmZPVmxOS0Fwb0pjdVc5b2p6WXV1UERzZDdjY280NFhNTlNLSEEy?=
 =?utf-8?B?T0RXY1k2ZW92UEd6STZJN1VuU2U0SkRqK2FIdHVzS3VyN0hFVW5wZ2p0aGU2?=
 =?utf-8?B?K240R0ZLd0RGRVcvY0VVbW5BMTA0Qm01aWdIaGk5L2t0VzlxaE15d0JibnF5?=
 =?utf-8?B?K3MyWWtrYjd2WlRUS1JlNDc0OWJEVDZRY1BkNkFFZzV6akxJTDY3UWVJa2c5?=
 =?utf-8?B?T0c4N1cwUzROM0V1MjhTbVdCTE9uZ1h6S0JmNkdwVExnTkU1SWtyeVZ2Q1Uy?=
 =?utf-8?B?TS9GdlJGeVpINnB2dno2M2kwRTF4Z2Noa0tnRk5Yb1VSblRMbndjYTBsMEVH?=
 =?utf-8?B?ZmpqZWlJVnVSbHQ2MzFsbGZrak1qaEpVZkFGcUlmR1lDb3kvenVPZ21td3Zm?=
 =?utf-8?B?YStNQUpZTFovdlNmU1pCM3R1akFEWklWVlh3a1ZaQ2wyaWluK0dLK3pSdzRQ?=
 =?utf-8?B?dy9qVnI0dFJMQVo2eU1XdXBKTzlxTXdhazBBejBtYmp5OU9RT3NmZ2NoYy9j?=
 =?utf-8?Q?gUjgbs5vDxSbAV+8xb5qAVI90MC2aGq3wccMloxrOWNg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feab4b92-16ee-435c-8dae-08dbffa7fc87
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 09:01:56.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1480


On 2023/12/14 8:15, Stephen Boyd wrote:
> Quoting Conor Dooley (2023-12-12 00:37:39)
>> On Tue, Dec 12, 2023 at 10:22:28AM +0800, Chen Wang wrote:
>>
>>> On 2023/12/9 0:47, Conor Dooley wrote:
>>>> On Fri, Dec 08, 2023 at 09:14:32AM +0800, Chen Wang wrote:
>>>>> +#define ENCODE_PLL_CTRL(fbdiv, p1, p2, refdiv) \
>>>>> + (((fbdiv & 0xfff) << 16) | ((p2 & 0x7) << 12) | ((p1 & 0x7) << 8) | (refdiv & 0x3f))
>>>> IMO this should be a function not a macro.
>>> Would like to listen why it should be a function instead of a macro? Any
>>> experiences you can share with me?
>> Readability. A function, which could be inlined allows you to break this
>> up and make it easier to read.
>>
>>>>> +/*
>>>>> + * Based on input rate/prate/fbdiv/refdiv, look up the postdiv1_2 table
>>>>> + * to get the closest postdiiv combination.
>>>>> + * @rate: FOUTPOSTDIV
>>>>> + * @prate: parent rate, i.e. FREF
>>>>> + * @fbdiv: FBDIV
>>>>> + * @refdiv: REFDIV
>>>>> + * @postdiv1: POSTDIV1, output
>>>>> + * @postdiv2: POSTDIV2, output
>>>>> + * See TRM:
>>>>> + * FOUTPOSTDIV = FREF * FBDIV / REFDIV / (POSTDIV1 * POSTDIV2)
>>>>> + * So we get following formula to get POSTDIV1 and POSTDIV2:
>>>>> + * POSTDIV = (prate/REFDIV) x FBDIV/rate
>>>>> + * above POSTDIV = POSTDIV1*POSTDIV2
>>>>> + */
>>>>> +static int __sg2042_pll_get_postdiv_1_2(
>>>>> + unsigned long rate,
>>>>> + unsigned long prate,
>>>>> + unsigned int fbdiv,
>>>>> + unsigned int refdiv,
>>>>> + unsigned int *postdiv1,
>>>>> + unsigned int *postdiv2)
>>>> This is not the coding style btw.
>>> Agree, will fix this.
>>>>> +{
>>>>> + int index = 0;
>>>>> + int ret = 0;
>>>>> + u64 tmp0;
>>>>> +
>>>>> + /* prate/REFDIV and result save to tmp0 */
>>>>> + tmp0 = prate;
>>>>> + do_div(tmp0, refdiv);
>>>>> +
>>>>> + /* ((prate/REFDIV) x FBDIV) and result save to tmp0 */
>>>>> + tmp0 *= fbdiv;
>>>>> +
>>>>> + /* ((prate/REFDIV) x FBDIV)/rate and result save to tmp0 */
>>>>> + do_div(tmp0, rate);
>>>>> +
>>>>> + /* tmp0 is POSTDIV1*POSTDIV2, now we calculate div1 and div2 value */
>>>>> + if (tmp0 <= 7) {
>>>>> +         /* (div1 * div2) <= 7, no need to use array search */
>>>>> +         *postdiv1 = tmp0;
>>>>> +         *postdiv2 = 1;
> why not return 0 here?
>
>>>>> + } else {
> And then de-indent this?
>
>>>>> +         /* (div1 * div2) > 7, use array search */
>>>>> +         for (index = 0; index < ARRAY_SIZE(postdiv1_2); index++) {
>>>>> +                 if (tmp0 > postdiv1_2[index][POSTDIV_RESULT_INDEX]) {
>>>>> +                         continue;
>>>>> +                 } else {
>>>>> +                         /* found it */
>>>>> +                         break;
> This can also return?
>
>>>>> +                 }
>>>>> +         }
>>>>> +         if (index < ARRAY_SIZE(postdiv1_2)) {
> And this condition can be removed.
>
>>>>> +                 *postdiv1 = postdiv1_2[index][1];
>>>>> +                 *postdiv2 = postdiv1_2[index][0];
>>>>> +         } else {
> This can be the default after the loop.
>
>>>>> +                 pr_debug("%s can not find in postdiv array!\n", __func__);
>>>>> +                 ret = -EINVAL;
>
>   /* tmp0 is POSTDIV1*POSTDIV2, now we calculate div1 and div2 value */
>   if (tmp0 <= 7) {
>           /* (div1 * div2) <= 7, no need to use array search */
>           *postdiv1 = tmp0;
>           *postdiv2 = 1;
> 	 return 0;
>   }
>
>   /* (div1 * div2) > 7, use array search */
>   for (index = 0; index < ARRAY_SIZE(postdiv1_2); index++) {
> 	 if (tmp0 > postdiv1_2[index][POSTDIV_RESULT_INDEX]) {
> 		 continue;
> 	 } else {
> 		 *postdiv1 = postdiv1_2[index][1];
> 		 *postdiv2 = postdiv1_2[index][0];
> 		 return 0;
> 	 }
>   }
>   pr_debug("%s can not find in postdiv array!\n", __func__);
>   return -EINVAL;
Thanks, Stephen, I will improve this.
>>>> Reading this function it makes me wonder if (and I am far from the best
>>>> person to comment, someone like Stephen is vastly more qualified) you
>>>> should model this as several "stages", each implemented by the
>>>> "standard" clocks - like clk_divider etc. The code here is quite
>>>> complicated IMO as it seems to be trying to implement several stages of
>>>> division in one go.
>>> The objective of __sg2042_pll_get_postdiv_1_2() is straightforward: based on
>>> the formula defined by the TRM, with input rate/prate/fbdiv/refdiv, we can
>>> get the possiblle combination of POSTDIV1 and POSTDIV2 by looking up the
>>> table of postdiv1_2. We will later use it to setup the clock register.
>>>
>>> Though the codes looks a bit complicated, but accually it is calculate with
>>> the formula : POSTDIV = (prate/REFDIV) x FBDIV/rate, I just separate it into
>>> several steps to make it easy to understand, I have listed the formula in
>>> the comment on top of the function.
>> I understand what you are doing, I did something similar myself
>> previously. My suggestion/question was about using the "standard" types
>> of clock that the core provides to represent as many of the clocks in
>> this driver as is feasible.
> I would not twist the code to conform with the basic clk types. If
> possible it would be good to use the helpers for these things, but I
> wouldn't split up a clk that is a complex divider with multiple stages
> of division into the basic types just to make it fit. I say this because
> every clk takes more effort to maintain in the clk tree, it has a name,
> pointers, etc. If you can keep that self contained and logically it is
> really one clk, then go for it.

Thanks, I will double check if we can reuse "standard" types of clock as 
much as possible, or just keep current way.



