Return-Path: <linux-kernel+bounces-10713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE24481DABE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 13:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18656B215F8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E4046BA;
	Sun, 24 Dec 2023 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bpPb+9Ez"
X-Original-To: linux-kernel@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-os0jpn01olkn2036.outbound.protection.outlook.com [40.92.98.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF520F5;
	Sun, 24 Dec 2023 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbg9AeND6SUvaQ+yHk5eAEIQwyiVvrXiCRJcVGAwvPH727nlMv2SVLcgHL7uKVt0mBwTiJEJHt0SMF/fiK7LdvxQAjQ3UhdnOJ+sGeGGQFDvk+9g4Empx18wDbw4CFwJsmd9HEd6lXiQrYsboW3ySJIIaXTfJOy6H10OPHe17ZElAQAb6wjewKeKHrfzoQ+TMCrKCkKsPOKYthE5A3Q5gV4PMce+t8+PdxAWv5XX2YzaCnvKI8V6HfgQSBUuVG1cvYIkGWTRU1PP5kVN20g2m4FS3hZPSm5/XV5g91lzn9+m2YW8dVnC0gzjPPFbfhgUQxw+V0xo12SGLE+p9syhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWQibc5NKvPuYzlW5jeDxMBIMaVNDEsDR9+KQZFe+CM=;
 b=h1NuIA6P7yceb6lv5fr30xRDtkFqxWLz/2UQfIBq281UJi5H2ez5pgH5bPQa435dq9yLgFRpAIj9lNuzqXG4mUOo1zUSZNf6HKCVFE7l/wsFHBAtwxwK5wlC8hSOjV7n+xY0lMhVCcBUL0Ak7Q/lTIkx3U6fr2w/NfB/Dlj37StvtuIJFIlLfPqj0bzlIN9AnXMr1volGAiREeaZRaFhZl04eHwrGez0bZEz5IrqufqK+seaB9B3vBzg+BnNhChrOdaJEA3W1BJm6tzoP3oFlJvc9zfm2P/MxykBBj3B1aIh61fPR7h9EHYDSwHVVIeyux3zwkd1EzgSN/+0BUOQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWQibc5NKvPuYzlW5jeDxMBIMaVNDEsDR9+KQZFe+CM=;
 b=bpPb+9EzbXSLjPqjbLCdBPV+hJb7VcUUXq76M/GdFAmCyB9EoNegIU6nQSvgcHaw1gaIY9mVzSkpwRY3oikuFW/BfVqwKyeCTgVsysC7y2AdDKDMslezUX9UaknH/Dqfnsxj2ni397A8zvcu8xqg9hwZWy7FhtXx16APYy5nTWmSa1UmEGWuWbx7Z1a97/sj7MRRwgCc7qRmG7awWf7872E43k7hvZRW647TA40okoAZoe31wqB1rzgCWVNLnww+76I2yFLu5S9jbyv2hButvXj4TIYUTiw3V1B+rvgpHUvQBUiCGQm9RkHuLmU2f0W/VLodrXW3hhG6i7r377kt5g==
Received: from OS0P286MB0641.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:cb::10)
 by TYWP286MB3079.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 12:44:40 +0000
Received: from OS0P286MB0641.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3bc:35ff:e1d9:212f]) by OS0P286MB0641.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3bc:35ff:e1d9:212f%7]) with mapi id 15.20.7113.023; Sun, 24 Dec 2023
 12:44:40 +0000
Date: Sun, 24 Dec 2023 20:44:35 +0800
From: Zhang Ning <zhangn1985@outlook.com>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	lasstp5011@gmail.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: boot: dts: rockchip: Fix led pinctrl of lubancat 1
Message-ID:
 <OS0P286MB064153B62ECBBEED9C16755DCD9AA@OS0P286MB0641.JPNP286.PROD.OUTLOOK.COM>
References: <20231224075001.3032214-1-andyshrk@163.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231224075001.3032214-1-andyshrk@163.com>
X-TMN: [L413JATTD6zhewnoYwwVyh17306I0bns3aJQS57qkmZfiVEJf+ydifQlrnsWwuE0]
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To OS0P286MB0641.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:cb::10)
X-Microsoft-Original-Message-ID: <ZYgnsx6rmpy7KgBQ@orangepipc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS0P286MB0641:EE_|TYWP286MB3079:EE_
X-MS-Office365-Filtering-Correlation-Id: 06182430-0148-4ab4-afb5-08dc047e18a9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8imfxOhnBYV6G/O6Q6redJvuTuNfe2aVV9p4zuuSOcCshrZ33iHyeeeepKx93bOCGRBJAZUclqUfvFNfsUgMHuJ7OkAZWFudZJzWOdWJiQTF2WPdm3+LguGbDvg6uHsROZ68x9sTkQdNZPxluzup2uWxPNsaGsGdLwYFIEl4RVssBJI47fAxmyiMKHwOIGkAPqvnrLy3X57CE1+vb+BbP4Kil7X0hdc6uJIgpf2x4Dkc85i5rTxTAXyz8g0ihUCYEWcTuo6o738M1vFZlY8GdKFXpyPWAH5MO6/ALdN1R76ukXC/8Nl3C17vv6E1pNPPE1bJPf2eLorkgDKj+pV+3Sjpg50S/pNTpsl4FFRXnNR3Dpcqux/JEGm6ZZVEi9c1TtXJfjmtvLViNAdDgu8JRHpf0mhNBv5G2hHqtBkgd32fUxZqkLKGemcWXuV6zJlQInFULlKYCnWUazfPew3PFNPF9FW5ZzOAp6hXhEhluDjkxgL/25Vp1XYXWezf3bYv9TibnO6p8HXUSXX8kT6oPduXC3yJkjpfsq6d0JhTI9wfVNCw2MtM7saG+gXnYO7QVxq4EFkrTAHtgUthn29eCu1yeY97kh+9Xlsgw4x9RjI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHl3NkZDZURsaytkMWFWVlJZa2dJelVlTHl1YzlyQ3RxV0JETWpOZ1NIQ1pP?=
 =?utf-8?B?NFJqd0NvcDlzd3N4eHZaaklVSElCM2hySC8xbUpiL3k5RkppakpPa3JhRWVE?=
 =?utf-8?B?MUR0QTlXbEpDeEUrR2s4RUw4SUU1RWpONHlvcWxLMGdKY3h2MGhtQ2lDaEdk?=
 =?utf-8?B?YnNPV1Z1clB6c1dienBDcVlNU2RkMzNrazRvaHBqajE3OE5tQlZoQm5lNlFY?=
 =?utf-8?B?ZlFobU9yWUxKb1JaaU5ESzRZRE5lSGNRdCthVTF1eXRQUHNTVWpTdzVnRW9h?=
 =?utf-8?B?L21xa0x3T3NKN2tacWtxZFRldm1IMVN0cXdlRDc0WDBBWnpFU1Jqd2VsY3Ur?=
 =?utf-8?B?NEppbm9wbENqTkJtaW55L3ZQV09VMXRwcU1vNmJTUE82cXRTU0JudmJFUlZ1?=
 =?utf-8?B?RGZDaG5CcmJjSW0zajQyalA0YzdycjdLd0g5Nk5ldGJvbk4rbm9GUzlpYlpv?=
 =?utf-8?B?VUtxSk1DMXQyNm9TdmtjSG9mSzNmcEdRTC9xRVlqY0g5Nkw1RHRZTUhyY0Zk?=
 =?utf-8?B?MkZCRGpUdzJIRFR0dzJqRWxDTmcza1Y5S0QrNVlyQi9xSkd1aUU3NXUwejhN?=
 =?utf-8?B?Y001d2RYaTErYmVEeElQQWJ1WnpDNlpuNWtBdWdNbFVwcTQrYkNKdVJab3l2?=
 =?utf-8?B?VndVTEVOc09pa1FTYXpkMDNqM0lrTmtKTVNyVmdwSFNoSmFjdFovT0NBWW03?=
 =?utf-8?B?S01aZjBoVE42OXFFQk94clFLeUt5RWlVQ2g1akM0eW4vQjVUQzNRVmUxRlQy?=
 =?utf-8?B?K2JGUHZMS2NBU1l3UTJsSXRLaHlGa0FSQ2NFYUZESjdlMlNZTWQ3NmFjZExQ?=
 =?utf-8?B?RjlsMjI0RWNGYS9LRUZyM3d1OC9EVHdQdHFEQkd1UU1HZEJGdDR4OTZLUXVT?=
 =?utf-8?B?ZXpOd2toQ0dvRFJQN1o3LzRQRWFoVkw2T3JSdnRHNG1Bc1RhR1pPQU5BU0pJ?=
 =?utf-8?B?UklFMGloUCtXWUYrbzJTcE9ib1RhMnVNd0hMSm5DSlhVdy84OWRWZEtTdnFS?=
 =?utf-8?B?b1NyK3RRUGlJL0xaTVBIK1NkRGZHWjkwbGpCRlJ1ZXY4ajhyQXhiQ2gyeVVz?=
 =?utf-8?B?U292NFZZQkpwdi84VC92N0hlclNFN0x6VUhwNUZtRzBFNVRWRkNScU5FcUEv?=
 =?utf-8?B?NnFBUk1MZFhLblBwZk96Y3JqM1FnNmNRR2plVTR1WDVxM3p4UnBaMlEwQis1?=
 =?utf-8?B?WG9Nbm9jZlN1V2RoY1NNL0dId2VaUEo2ZUNidVJ1aExyQUVYcE5CK2RPUkhY?=
 =?utf-8?B?NitTcHNUMnFMR0RUUGtDVXUzK2ZLek00WTZNNm85cUtyNnlJS1ZsWDZmMFBn?=
 =?utf-8?B?VEduNWtVREo4eEJ5c3ZYektnUXpPOFZybWgwUUppVktySWFsalZ3a1ZPTXBl?=
 =?utf-8?B?TCszR2ZzS0sxSmhxN0lIQ0RzczRIMWJkV29rak5xZDVBOFl4ZFoxYTJzaUNs?=
 =?utf-8?B?MDJCN2dpcDRJSldrdnhpTlZiOURDL2VJeFdPUWpaSk5LZGZyWEN6RzBkR1M3?=
 =?utf-8?B?UDkrUnpjcThRZ3pXbi9ZVm5pcE0rTFRBcVBBNnh6UGVSajFLTmszaFBzd0Qz?=
 =?utf-8?B?QXN1YTlrbEEzSlpmc21JNG9WUHFacjRQd1ZZdy9NL3kweDRGemIyWS8vcXMz?=
 =?utf-8?B?Z2d3MUM3bm5HdE41bFp5L00rK1AvNHA5SW9FYnUxT1VKNjN6eFQ2WE9sQU1U?=
 =?utf-8?B?MnlyRTNqeUNnekJQSlZ4Mmw1V1hWVWYyazRzUnBOZk9KY2RzU3p6TDhHWlJ0?=
 =?utf-8?Q?Jq2oG3f7m8b99e4fKg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06182430-0148-4ab4-afb5-08dc047e18a9
X-MS-Exchange-CrossTenant-AuthSource: OS0P286MB0641.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 12:44:40.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3079

O Sun, Dec 24, 2023 at 03:50:01PM +0800, Andy Yan wrote:
> According to the sch, the gpio control sys_led
> is GPIO0_C5.
> 
> Fixes: 8d94da58de53 ("arm64: dts: rockchip: Add EmbedFire LubanCat 1")
>Reported-by: zhangn1985@outlook.com

Reported-by: Zhang Ning <zhangn1985@outlook.com>

in case if have rev2.

> Closes: https://lore.kernel.org/linux-rockchip/OS0P286MB06412D049D8BF7B063D41350CD95A@OS0P286MB0641.JPNP286.PROD.OUTLOOK.COM/T/#u
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> index 1c6d83b47cd2..6ecdf5d28339 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> @@ -455,7 +455,7 @@ &pcie2x1 {
>  &pinctrl {
>  	leds {
>  		sys_led_pin: sys-status-led-pin {
> -			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> +			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};
>  
> -- 
> 2.34.1
> 

