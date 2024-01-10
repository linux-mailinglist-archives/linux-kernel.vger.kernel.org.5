Return-Path: <linux-kernel+bounces-21559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F5829120
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F16287818
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269F392;
	Wed, 10 Jan 2024 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MwSBEFMI"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2081.outbound.protection.outlook.com [40.92.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B3B180;
	Wed, 10 Jan 2024 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFG4MVsSdK6LO0wHO9kK3oT6qAotre/x1QStKsHZhFw/ObcqONo3QVgPGLJP6rK1AEYR0YR9EuwZ8xeB9eLEgX6ZVHLExEMWYkdbX+w3F8PBp0yAl7QTjLn0WGlvVNHbo/1PG0+6DaAQewiJ074LfFRh9/nEkWczQbWz080aZLu2/3CbaZT52TpdmyPKNPzMk2O0/8TIXpKIH3Zd/CENsxmEYo9caOPKohlxsn1epghKz6Ox7nUadWXGgDAEJXZrC08EPkktfEbvvaMcAnq9fPeCkIP4J+AF0SvPZ+UfDr71RXUtA8gD3lyVCa5woNGfNI1p22YLub41uVpD3PJS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLX0Y9YH1/XJdTwYr7OPASZHZRGTOTNDObSBZBW9Qj0=;
 b=cah/JdzOODDPGCOsmDS0XJEznVyAeWThUEP+X3gnobNnW0s/83jCCkKfZsv53guPIw+9lraNwDD/9D8oLS3PwR1ydNqfNTjjVxpl+lwZ6QkIDJF+w3P2LcPLo1P/f+LFVySzRPbfKyoE6YjQ3d+6euT1axhug98w2t6bqNKftZJk4GWRKbgzyuFAvxunIl/KZARd/pXC58tnNPNwFPmEvhRdIZzxaJpNcQFkwCnf5RSjLeg0fJhflMiw4oP7YBWAbBT1sD21Zdk8GMs7q85n1L4PUQwXWW+Hjyta3wXqjwrbAHXEfIYUXX7ts88G/ZVBIPxU5ehSGRUsiWnoYLUaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLX0Y9YH1/XJdTwYr7OPASZHZRGTOTNDObSBZBW9Qj0=;
 b=MwSBEFMIqLOU2dlWtgG8jDKqdYJonrslpegxVTMbGdrR7s7PzBsNCLmixs29gif3u/PftasS78LouA1VCOj1SE/D7TpnOAfMAFV9OWaagqKl+swBKVrSh1iiEid2N+SNfxfYdoec6uyn/d3hSG87cjMwDJJCJSHKOSNBRcPtUCnKsFQhGonuJ0gAPCJ4EBERtqbvv/nhLHukDYrCfamVGJ96JOzRUUvT+DGVBDy9Xi/IyI/AjNJaqxjXR6/hFPgWu9wQtyllbExFRHTLkuhrdV94Da/P4UivvBJRzkJip4gIeN/LmGCgQ4bOsL9e4saEFrxEQgAzSCPrqg4JixQ/iA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1836.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 00:06:09 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 00:06:09 +0000
Message-ID:
 <MA0P287MB2822D73E1E63ED48D0B1A271FE692@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 10 Jan 2024 08:06:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: reset: sophgo: support SG2042
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 conor@kernel.org, krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com
References: <cover.1704790558.git.unicorn_wang@outlook.com>
 <9798e2ea0c4e339717cc5c411e0db0188befdc58.1704790558.git.unicorn_wang@outlook.com>
 <5f724f59-8643-4f30-8cfb-8e3213b50118@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <5f724f59-8643-4f30-8cfb-8e3213b50118@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [AOzC5R6TViePh7MEX26hmm70Gr8Q7138]
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <35b58b98-3992-4a12-afbd-c33c0ace6f60@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1836:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2c4781-51ac-4160-0929-08dc116ff14e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7kaG/L7pMhLsEZrxE9zXiJ0Zp6J+QfHiIGmD1I03onOwkkezZcU2CjhfK8MVe9A0t/H83xdXUpu4N9BA/09D6vFMI5PUR3HXYtTUUjxHb6fgvBmhLh2uFI+2xeuLvjOERQ6L08J5c5O7R4US0+oGeLeg2ICr3nMH3bVzwpgp4su4PXRre98ZcmP57VgDe4z9Jp6Y2EQ5t9t0jpgKi16pQ+UFWMfYjx0sWy4ogfXPl2mgCetEJgSLR+XkLOUeX4w3iQpCsvU4CMTY6pAg9tbBBUx2qmNNNBblcAyP1atRMNMCBjp1QPzw9/gWhh/HCaz8BOCpGV41cHKEW3T/qZnj8ghI9gHeWFEjw/FY9Psi49vf0EpgLeFmjIHxuCxjqLHlis0DR+j1pSScyqGaTbX+7IYBjVkY3mCxWQgMZbRROM0oge9m+r2/jkJ2tOgOAmOHnpWHnU5LZUGZbrF++MNGiwSlkzE8zbjU1+Gy4qGCh5NteVlkJNYg12MPVIECMUjR7Bt68nT8Dvn3N4ev4kmB6siW3tcqqROS6JwwFZhCUr0KI4iwsgIsgQhdTwyRBYOnTrWPyL2sqQr/wG7UKoqDNaRAjpUiX1+TmVY89dlInXg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGV6TEd0U1pScVJVbndvSWNUc1ZwVHBxYUI2ei9OYkR6d2ZibElkZ0tyLzI2?=
 =?utf-8?B?c29VLzdqUXdzWjM3N2ZtdGVOZ1J3T2FZOUg0NEwwOFR6SUhRVldFRVBGK3JR?=
 =?utf-8?B?TzRyeEprdmZPd0lTT2RiOW4wOU9sVk45Rm9Jb1IwN0VmZkJ1NEdtQXhPQUJG?=
 =?utf-8?B?b3pjSThxU25TTGZHR3dORUIreFNlRkZ1aDJXUGhsYVFFdXFsZkhCZ3VPenJr?=
 =?utf-8?B?TDUxYXllWWV2SVBrS1o5dFVjSUE3SDQvaWJaampiYTU1d2wrcTNPN0Y0MUNu?=
 =?utf-8?B?T055UUNObHZYUzdHblY3Wk02OVUyUDBxa05VODlIaHYyTTdzZC9FR3VxZUJ5?=
 =?utf-8?B?WFg1UzZUZVlyTElmS1huMTZFdDd1YUJTTnpsRGxDYnRIcFpyNFNYdzVHMllW?=
 =?utf-8?B?Y2ppVUJPd1JyWTBkM2g3RWllZzA0dUFZSGsvRTNkTWcvNUx4S3J0Y0pDY1Z6?=
 =?utf-8?B?T2RtUXZiOGVXVVRXQ1JuNVN3TVFQaHpCUjN6ckZSdjR3VjIyeDlVSUhYSTZs?=
 =?utf-8?B?RUZUSEVObjJJT0RidnJuSXBsOFI5RUZuTkdQVzhMOVRrWHJpaitNSk5jNTRD?=
 =?utf-8?B?a1orMjc0eWZiN0hQdTlSSjlvQWNNaHBKOHRXSWhwT0x6dXF1NVJzelErOWt0?=
 =?utf-8?B?K3hrOE82YkxSNGpXZC90OHlwWGpCaGY1dVVGMExEVHZUTkxGYTYySFd1UmNW?=
 =?utf-8?B?dVhpUHpOVlZhWGtrZHd4S3FNS1lyemRZUm9teWgvc1JzNlQ1aDBPRGQrbUMw?=
 =?utf-8?B?UWlQSzhIbzVYWmZ6ZDFIMjNxam5FSFl4OVI2UVI4RDdDcjZnNk1vM1dxWURw?=
 =?utf-8?B?VFowc1EvSkg2blJ2UzlXaGMvQjRYdkV3ZkRGVXI2R1cyemJERFBUL255c1B2?=
 =?utf-8?B?SktCQkxwY1B0dVpDQ0tqVTErMTRHK25SUnNOQnU2YTVUWkhjWjh6N0NvK0dD?=
 =?utf-8?B?b3hVUzA4ZHlxd1hFQ0xwYU1PM085WWJhYlFYSlZlVWF3SCtoY0RiVW54NlI1?=
 =?utf-8?B?UTRGUkpObmZpbXJsUEx0N0RIWnJUQ2l6VFVlRmFLU3RoZ1UxcXQvQ2JLdnk3?=
 =?utf-8?B?V1RZT1ZCaGpYQXB2RGxZdmtzY01DaHMrZDlOS3ZtQ3REL0l3YXc2Y1A4MTVk?=
 =?utf-8?B?MTE1WGdka0JhV1JhTnQ0cTVXMDJFYmt1VFRCMEY2MG1XTm1sTTdtMUFqbldS?=
 =?utf-8?B?U2htZThESFRkREJJaGdqRlZCcWpNY1lzOVlwL2ZXbWN5cjBBSkYrMFlEQkt4?=
 =?utf-8?B?L3Q1eW1HYjhnRHBLZW5CRVpEZW5oVXhJNlhBZjhKWGt1Vk5LTVJscGNYWlFk?=
 =?utf-8?B?c1hZa0dVRHpKYWhTeVc1cTgyTTA2VWhYYjg4bVZOaVg4Z01oUGk2U2g0MjN5?=
 =?utf-8?B?MUJkRTZOdytmMTNzcFRaQlVMZ0wwSVdqWXVSQkkrVm9oVXVXeUNhNjRRSjAw?=
 =?utf-8?B?R1NKYzBMKzh0c1VFQkVaY2NjZk00QWFXazkyT1kvZ3g4YndWVVMzK0lFYnhp?=
 =?utf-8?B?amlaWkJCUDFGL0JENlNvUkwrUmNuQUZ2bktzR3NIZDIwYWMzZDBLQXNkc0Ri?=
 =?utf-8?B?N1N6RGFhYVZHbXdXMXltUFJxd3dOVzZyVXdWT1JRZkxMM2lHSWhwVER1bUxm?=
 =?utf-8?Q?nKOn0W6K/U2oHf+Q4r8u1sMVhrENI+/DGZ0D+uKJevM8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2c4781-51ac-4160-0929-08dc116ff14e
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 00:06:08.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1836


On 2024/1/9 23:19, Krzysztof Kozlowski wrote:
> On 09/01/2024 10:16, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add bindings for the reset generator on the SOPHGO SG2042 RISC-V SoC.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ...
>
>> +#define RST_UART2			31
>> +
>> +#define RST_UART3			32
> No need for blank line above UART3. If there is going to be new
> version/resend, please fix it.
Ok, let's wait a while for other review comments, then I will fix it in 
next version.
>
> Anyway:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
> ---
>
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you know the process, you can skip it (please do
> not feel offended by me posting it here - no bad intentions intended).
> If you do not know the process, here is a short explanation:
>
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>
> Best regards,
> Krzysztof
>

