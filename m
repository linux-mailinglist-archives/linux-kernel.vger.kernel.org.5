Return-Path: <linux-kernel+bounces-140034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A08A0A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECAC1F25DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0BA13E89B;
	Thu, 11 Apr 2024 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZRFCE4wQ"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazolkn19011002.outbound.protection.outlook.com [52.103.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33A2EAE5;
	Thu, 11 Apr 2024 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822056; cv=fail; b=tBVp3bEkI0bdD7FFd+lLYs1ec8wC54z9ThhW14S5OAy3we9HGCGlrVs8xITilRMYcuMdqSUCr+YGuytqydNAPFc2/Uy+yuFhRtilRiZOWc2YNpXdu/JM1pa+m7q85ffKGXHGmhQb2uUiNq573a8+cFRjo/ez2sk6GvgOr37lRYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822056; c=relaxed/simple;
	bh=b7HYP3rxgQ5ebfPlGmEGaLKoryuqFEJH8XNbdBvGQB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SJ+Y+8RgmFbgv2kHIqYpK1WKifrC1uzXbyl/A4eOXd7Xe1JIPm2zxdP7GZ4WjIvwBwWLQR0BinImCEQOkOBo7ZWVlf5KkKhhKVOKHi7TAqAN4Z8ioA3P8YMgfrsiVEAVZe5ma3iVh5X+4m3TWr7e+kI1Nu6fq7dxlsCFaELHp7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZRFCE4wQ; arc=fail smtp.client-ip=52.103.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsQFkLNGfFH3AYfnEo0JPlo5pVnRk8jdryPV8tK7iYZ6ej7fYb+yhkQLAmFhCbGMWosq6WuTer3npvL3/Tc1RuJ/0BXSQIf31EH2ZnQlkIHAGjOhST4CvGe4etQpQkvDYONyaVaUrrth0MqiAeBFJuiUKN6t3TG2LhBbI+QYbx4ADxufdtY4oUN1i7mOKlD/8dLTBpx88HYklfatD/JWg8aL/kvGyj67nmf/d96CdQNAtS2cnIls21w4Abaa2WIIyg84MCadCKRR4pLtzMcDcWqkPZvWZs0R8NYLr18NQqYqRZ94q368NDePAuYfNHhXJGtcBz0SIPdGtkxmeIFUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoHbTDuqrEcbb1ZH0/ZeG+R9CdfvCP2AJjFcXLKY3NE=;
 b=Q9oESwSrgWHKduDTKUwLlosgzKE6fDnIxYvn1OjCOPscKFetb5tQgl4QjVvz+UN/ezgAs48Lru7U3/+yIfjytmGJNNtZR+YEb+Ya6HDnqA+bDpJXHbST9PFbqlFK9nJ7RI1x0ERDSfsZDymPk9UqptzSTVm/QX+QJnhgFb+Zpu245irfuw6IBdrrh0SE2CJx3v3nhuvA68Gz2rjB2XWhrAXz9AmI9X90g+cCD1J4ERAYqeeZ2AE6e4pKHzOEXBBTyKgIIUe0wrfuS8YCxz2fXS4PJPT8DXlAtHIQzRZGBKt+C4DbDuxVVByGZ/tmmMzKEnTZHHsWaFsnFOvqrSIqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoHbTDuqrEcbb1ZH0/ZeG+R9CdfvCP2AJjFcXLKY3NE=;
 b=ZRFCE4wQwgOL82ykCDLM9oM1U0twn6xH8ATh8GqVphRkOPmXI1I0sZKd1bqNF62LGSowRCMGo9KgDXvOYVPjtF+AdLbIdmDBrmJZLSgGgtSXThP+waLN8+AzRuRiiNYiGWP7vyTemzn+Ad2kduTQwwTojzvR3CCE1veImFtkQP1HPAfioMWLZtiT5Yfz98VplwJHw7IdZKPpXURLjvB6o4re0kURuWU3pXTz00uVrfCKUc9Z4L/1LzOYMTUmgxlFg9U4CjUiy1nIOgjYr5CS6mtUNqXd5wxzXJGJm6qljYnkFAo3KE5m4lnr97M1MD4Jq01fwMQXcTl1C68R+WGH8Q==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB5964.apcprd06.prod.outlook.com (2603:1096:101:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 07:54:08 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::351e:200b:add4:6478]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::351e:200b:add4:6478%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 07:54:08 +0000
Message-ID:
 <SEZPR06MB69599B8BF84A23C579C0047396052@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Thu, 11 Apr 2024 15:54:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] clk: hisilicon: add support for PLL
To: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>,
 Jorge Ramirez-Ortiz Gmail <jorge.ramirez.ortiz@gmail.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240225-pll-v1-0-fad6511479c6@outlook.com>
 <20240225-pll-v1-2-fad6511479c6@outlook.com>
 <8b517c5b165d2be77eaf02af1e031325.sboyd@kernel.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <8b517c5b165d2be77eaf02af1e031325.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [gBeDLBkLdwVCjC4appKv1w13MLu0x2nLsR82asbgl4aNV73HHzLjdLN9iM1+lfwg]
X-ClientProxiedBy: KL1PR01CA0155.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::10) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <66670d73-9095-4bcb-aa90-db1aa515d56a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb67eac-db25-4377-f85b-08dc59fc90f3
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT9T0RiVOmbr8zTeQMuNXWEo1DI7h3jT4JUuZt9LO4wMaFgmcGyU7Rrd56JEk0eDI6OiuDQR9CiiZxXdwDqhYWNy0dBTsj57hhDTbnc8sjkpGwWvI5h4pFHFsbHUEOeE1IyTSF5HT+nricSV+peIMZWshIOT/js0jlHyEM+zm2qkV1IxO2OH60ttVjhe1X0k8NdAbNS6Y6pvYGVJnKKXsOtnhO3HiGGZSE/JaEvatuk6M0zHtPwVMuQMb/PKLYRINAVqqSjRoAv4X9uasHrmge7oEabCx2TqWplWw6nGQwL2CdvuxFhhSaZ5ukN+91vKGTht7wyZA3vuJ8BawJTzaFPdYb3SUyCj2cqQzrM/ZB+jMiXdTwqJGuLVye8ClUEoJhez/bBlaoGQ2t5ibDNlBydALkpJnwelDVIl2NDl+/puEmtWSBFsPNdwICK77bl7k73V7W/v/lP24y82w7eROyOWb5LJozN/wzRFqLiOFAIzM6tmUwYZ/01THykYa4xLkaIi/la5hApP9kB/8rIQpbsGlp7G3S52Cb4CooHb3bq0FRv9jPG9ycOA81l6MvjqH5SHd186/rPgS/NuYRnWbHz+VQ4tSZo8d0vbY3ffHJ+ENB6Rm7dyAsX+wMbVYdPq2MWAA/aO+eOQHzuhYo8PuogVerDhRZb9db+dMrVSvh05xbTzr1zhZahn13J5vKuev53x57XmfNNRTtKKSOIdD9tOwurDfE4omuVtYt2tMs5qnAZx7vzBkPL/ez8iZSyRgkKxmjFjso7/BEPOVHiAeHgNkP3nUKzBVyrH4RRKEjbsxXUEMHqmzRKP
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3POqYmoKuTBOUM/Nc0GOJiEFlCWRgJ8HOhKB9M5e3jz/9NUWWcAbp9HuR5sdo6ag7nW36oFqVkdbG+KIdGul02T74EzysfBV14yM1kjTp1Ew6frCKzOvsF8I2deaT0f6qy5i5ydeI5iObF/oFM7ES15iBDeiplWTLoqIAmvkiz0o4OxCmPvmz0x37BqrQov4B8MA5Wir+53+mHZ+ipJo2Acb2JJTKNKHM1Mbf+BG7fr2qGLYDPxA9OxXX0BLoJ35RjO1SNBerMPp13hNSbN9WFVj0AP3DqTUsdKBTtu/vd3Cid01k6gh7LttcHBxLdceaslce109cxyKV4JmR2HtTR/CzldKeBKxRI+lDXkjhbKXcUCIRB06hGFJSrucbQQUw3SlNEsd5lv8IzIJ6ltubJ8LUc4KIJFPOrgcfgfH+DCGdtiNQ5vyAk8vfiZkC8YxrlhH1N1atfPS/OvDJGwe2KGYDjYlM+D6HhR8dmMHNEnL5E4i6LG76Z4sG8upljNh0cpYH1vwcmcoNUho8Ma1FFGegCtpBvHenm9XYahbSpEkpeaKSQers0HebSASIi8EPk67flOt+1bxo1eCnG4hlfJkVc75o1ks16SL+9ZOI9nqojGeoSFAolqwyiRGyVM8BcattQAv16SsBm2a3IQQVbLIp0GIcKBvTYfD9jyTLJy/ODqAqvNYpt1JBr9s4TiLMYgjpouO60DbGVvVG2ON7Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nzc4ZHQrejYrNmpVMFAxNFpGeXBZOFBVVTVtV3FKdjFNbnFGcnVBdEtPUGFx?=
 =?utf-8?B?NUtyVXlBOVFFRXZoOER1MENLQUtKSEMyQk5UUFprWlhodTdhQ1ZRZG9reEYy?=
 =?utf-8?B?b2JFU3pQNUpIcjVFeDR1UXEwMEdlY2Z6aExXOU9xR2pOUld1aXlIN1FVMHZN?=
 =?utf-8?B?aUJqV0Q3TEF3SVhzN2Y1NEpHWnVQelRwOGo1NjFUSGl3VjRSeklEdVd3MnRT?=
 =?utf-8?B?OGJFeVd1dm1pNkpJVmhtQVJzNE9Cb2p3d2dSV2plUEtGM0pJNmIzQUlBOFFG?=
 =?utf-8?B?Sk5DOFZlVldDa2R5WmR6K0ZCSWZMUWd1c3lpWk1Cd3Bqdk0xUUZ6M1J6djN2?=
 =?utf-8?B?bXY2V2t4YTY4bVA3UThyMytYYWRrbFZMckE5ZXg1QmxmNDlZbEZZaHExRVUv?=
 =?utf-8?B?QlYvMzJlZzlSZ29FS3RHUW9OU3VNVTFaQkp6MUZXRU9XNXl3WWY4VG8yZ3JN?=
 =?utf-8?B?S1VQRHBvWm8vQVVsMWc2SlMrQTVBTkxlcW5FQ1VOY1YzdHJ6Y1VQRzFzS0Rp?=
 =?utf-8?B?eDhCVGthZDZla0VRQXN3eHJET3lENEtTSkhVWXBYTFcxNVJvNFlNNUJOVXFF?=
 =?utf-8?B?RjZwSFd0WnhKaHRKV0xWZm5RTjNBZnFsSzJNTVl4aUt0aEUxcDNmVDBVZlNR?=
 =?utf-8?B?YUdTcmMyYStUelRqMUxsVUlxME5oYzFqN0lxSE9BY3hmL1dTYTJGZjQyM2VQ?=
 =?utf-8?B?TjZMNG9mMTE2R0FubjNGM3kzdFBvSmYvNTZwZTZuN0hoUnhuOEhDb2g0bHl0?=
 =?utf-8?B?b2NBSjRIQzBzMnVRZkdnQ05MY0xST3F6QUFhUE00dkhEMHNwaHJBTDVqbXMv?=
 =?utf-8?B?c2NBYTQ2ZFYxbUp2U0tHVktaeE1DR0g5OGNQQ2tJZW1pRmxBeEVEdFI1ckZE?=
 =?utf-8?B?ekZKVStwMmhyNXo1VlVLMjNDYzFWWkgwQXgyem5aSzZiSTFiVm80UnVDUmk4?=
 =?utf-8?B?Z3RJTVFVc0JXM09iejZyUW9rTjN4ODZYVmx3UlRSenZ2bEk0M0h2T3d6Um9p?=
 =?utf-8?B?ckdMOHNENlRxVDNuU0VuSzFyUDlIZlhhTFYvdzBmYkZaSUx1SDJYaGUwcFp5?=
 =?utf-8?B?ajNIZlFGeDRvSTZRNFVuSjNwMnhrczc2b1MyTVl6M21oWHpQa0NlelJiZVJx?=
 =?utf-8?B?SEM2ZVVJVWk5WXZCY2QwUjhtSU0vUkVZQWY4L0QvV0QwazdkVVBkRldFLzRn?=
 =?utf-8?B?a29ZOTRTbXNGNnhKLzcvK21YL1ZPcXJZVnVCUWxSQ3VaQXZzdDZFK3U5K2Rz?=
 =?utf-8?B?eHIzL0MvODd1Y0RtTUM0MmJKNmZxQ0FTa29tekV3L3ZHY1lwYXlVSzE2SkYz?=
 =?utf-8?B?ZFNhMnJzVjBtMzVKb2U0WUZFSEpJQ0lsdDc0RkhJem00RGYrUEVkaHlqV1FH?=
 =?utf-8?B?bndTTy81MTUyNkVUbGdHRlQ1VlV6eGpFMWR5MU8xUktzKy9KWUVIbDBObHla?=
 =?utf-8?B?UUlsbkxFaTFNUysxa0RtS3BZcWhJc2I2bzNWOHd6TzVPQjFFajZ6ajdHeWpN?=
 =?utf-8?B?aXlHaFVYWTk1TlhPalJKTW0xemFPNmtLQ2oyVUZ0ckFrd3FUWkJZL01Ca01V?=
 =?utf-8?B?TUJMMnZveDZqb2x6R05VVmkwcUg2RnZhMFZRK0ExTUZKYS9lNEZjeDZwaFJS?=
 =?utf-8?B?anAzVWRwTXptenJEMHIvMmEveGFMMzdOSFVVRzZHOGRVVlZYaWpnaS8rY0du?=
 =?utf-8?B?WlN6VTFFeTdTbHF1V0sxeEZLNEs5ZCtoc3pET3VsZmM0bVYvaloyN1N3bnhR?=
 =?utf-8?Q?1QTYBWkwjqZcORyqKsStt77+qNvYZ8xa4UPXUJR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb67eac-db25-4377-f85b-08dc59fc90f3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 07:54:08.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5964

On 4/11/2024 2:59 PM, Stephen Boyd wrote:
> Quoting Yang Xiwen via B4 Relay (2024-02-24 08:56:10)
>> diff --git a/drivers/clk/hisilicon/clk-pll.c b/drivers/clk/hisilicon/clk-pll.c
>> new file mode 100644
>> index 000000000000..c5c07a65fcf4
>> --- /dev/null
>> +++ b/drivers/clk/hisilicon/clk-pll.c
>> @@ -0,0 +1,171 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * PLL driver for HiSilicon SoCs
>> + *
>> + * Copyright 2024 (c) Yang Xiwen <forbidden405@outlook.com>
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +
>> +#include "clk.h"
>> +
>> +/* PLL has two conf regs in total */
>> +#define HISI_PLL_CFG(n)                ((n) * 4)
> Isn't HISI_PLL_CFG1 or HISI_PLL_CFG0 shorter then?


Okay. There aren't too many registers anyway.


>
>> +
>> +/* reg 0 definitions */
>> +#define HISI_PLL_FRAC          GENMASK(23, 0)
>> +#define HISI_PLL_POSTDIV1      GENMASK(26, 24)
>> +#define HISI_PLL_POSTDIV2      GENMASK(30, 28)
>> +
>> +/* reg 1 definitions */
>> +#define HISI_PLL_FBDIV         GENMASK(11, 0)
>> +#define HISI_PLL_REFDIV                GENMASK(17, 12)
>> +#define HISI_PLL_PD            BIT(20)
>> +#define HISI_PLL_FOUTVCOPD     BIT(21)
>> +#define HISI_PLL_FOUT4PHASEPD  BIT(22)
>> +#define HISI_PLL_FOUTPOSTDIVPD BIT(23)
>> +#define HISI_PLL_DACPD         BIT(24)
>> +#define HISI_PLL_DSMPD         BIT(25)
>> +#define HISI_PLL_BYPASS                BIT(26)
>> +
>> +/*
>> + * Datasheet said the maximum is 3.2GHz,
>> + * but tests show it can be very high
> Sounds like you're over-clocking. Just follow the datasheet please.
>
>> + *
>> + * Leave some margin here (8 GHz should be fine)
>> + */
>> +#define HISI_PLL_FOUTVCO_MAX_RATE      8000000000
>> +/* 800 MHz */
>> +#define HISI_PLL_FOUTVCO_MIN_RATE      800000000
>> +
>> +struct hisi_pll {
>> +       struct clk_hw   hw;
>> +       void __iomem    *base;
>> +       u8              postdiv1, postdiv2, refdiv;
>> +       u32             divisor;
>> +};
>> +
>> +#define to_hisi_pll(_hw) container_of(_hw, struct hisi_pll, hw)
>> +
>> +static int hisi_pll_prepare(struct clk_hw *hw)
>> +{
>> +       struct hisi_pll *pll = to_hisi_pll(hw);
>> +       u32 reg;
>> +
>> +       reg = readl(pll->base + HISI_PLL_CFG(0));
>> +       pll->postdiv1 = FIELD_GET(HISI_PLL_POSTDIV1, reg);
>> +       pll->postdiv2 = FIELD_GET(HISI_PLL_POSTDIV2, reg);
>> +       // We don't use frac, clear it
> Kernel comments are /* like this */
>
>> +       reg &= ~HISI_PLL_FRAC;
>> +       writel(reg, pll->base + HISI_PLL_CFG(0));
>> +
>> +       reg = readl(pll->base + HISI_PLL_CFG(1));
>> +       pll->refdiv = FIELD_GET(HISI_PLL_REFDIV, reg);
>> +
>> +       pll->divisor = pll->refdiv * pll->postdiv1 * pll->postdiv2;
>> +
>> +       // return -EINVAL if boot loader does not init PLL correctly
> Yeah we got that by reading the code, no comment needed.
>
>> +       if (pll->divisor == 0) {
>> +               pr_err("%s: PLLs are not initialized by boot loader correctly!\n", __func__);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int hisi_pll_set_rate(struct clk_hw *hw, ulong rate, ulong parent_rate)
>> +{
>> +       struct hisi_pll *pll = to_hisi_pll(hw);
>> +       u64 fbdiv = rate * pll->divisor;
>> +       u32 reg;
>> +
>> +       do_div(fbdiv, parent_rate);
>> +
>> +       reg = readl(pll->base + HISI_PLL_CFG(1));
>> +       reg &= ~HISI_PLL_FBDIV;
>> +       reg |= FIELD_PREP(HISI_PLL_FBDIV, fbdiv);
>> +       writel(reg, pll->base + HISI_PLL_CFG(1));
>> +
>> +       /* TODO: wait for PLL lock? */
> Yes?


The PLL lock is not implemented for some SoC. I guess it's okay to 
simply ignore the lock flag.


>
>> +
>> +       return 0;
>> +}
>> +
>> +static int hisi_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
>> +{
>> +       struct hisi_pll *pll = to_hisi_pll(hw);
>> +       u64 vco, ref_rate = req->best_parent_rate;
>> +
>> +       if (ref_rate == 0)
>> +               return -EINVAL;
>> +
>> +       do_div(ref_rate, pll->refdiv);
>> +       vco = clamp(req->rate * (pll->postdiv1 * pll->postdiv2),
>> +                   HISI_PLL_FOUTVCO_MIN_RATE, HISI_PLL_FOUTVCO_MAX_RATE);
>> +       vco = rounddown(vco, ref_rate);
>> +       if (vco < HISI_PLL_FOUTVCO_MIN_RATE)
>> +               vco += ref_rate;
>> +
>> +       do_div(vco, pll->postdiv1 * pll->postdiv2);
>> +       req->rate = vco;
>> +
>> +       return 0;
>> +}
>> +
>> +static ulong hisi_pll_recalc_rate(struct clk_hw *hw, ulong parent_rate)
>> +{
>> +       struct hisi_pll *pll = to_hisi_pll(hw);
>> +       u32 reg, fbdiv;
>> +
>> +       reg = readl(pll->base + HISI_PLL_CFG(1));
>> +       fbdiv = FIELD_GET(HISI_PLL_FBDIV, reg);
>> +       parent_rate *= fbdiv;
>> +       do_div(parent_rate, pll->divisor);
>> +
>> +       return parent_rate;
>> +}
>> +
>> +static const struct clk_ops hisi_pll_ops = {
>> +       .prepare        = hisi_pll_prepare,
>> +       .set_rate       = hisi_pll_set_rate,
>> +       .determine_rate = hisi_pll_determine_rate,
>> +       .recalc_rate    = hisi_pll_recalc_rate,
>> +};
>> +
>> +/*
>> + * devm_hisi_pll_register - register a HiSilicon PLL
> Use kernel-doc please https://docs.kernel.org/doc-guide/kernel-doc.html
>
>> + *
>> + * @dev: clk provider
>> + * @name: clock name
>> + * @parent_name: parent clock, usually 24MHz OSC
>> + * #flags: CCF common flags
>> + * @reg: register address
> Missing Return:
>
>> + */
>> +struct clk *devm_clk_register_hisi_pll(struct device *dev, const char *name, const char *parent,
>> +                                      unsigned int flags, void __iomem *reg)
>> +{
>> +       struct hisi_pll *pll;
>> +       struct clk_init_data init;
>> +
>> +       pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
>> +       if (!pll)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       if (!parent)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       init.name = name;
>> +       init.ops = &hisi_pll_ops;
>> +       init.flags = flags;
>> +       init.parent_names = &parent;
>> +       init.num_parents = 1;
>> +
>> +       pll->base = reg;
>> +       pll->hw.init = &init;
>> +
>> +       return devm_clk_register(dev, &pll->hw);
>> +}
>> +EXPORT_SYMBOL_GPL(devm_clk_register_hisi_pll);
>> diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
>> index 7a9b42e1b027..8c59f3927152 100644
>> --- a/drivers/clk/hisilicon/clk.h
>> +++ b/drivers/clk/hisilicon/clk.h
>> @@ -103,6 +103,14 @@ struct hisi_gate_clock {
>>          const char              *alias;
>>   };
>>   
>> +struct hisi_pll_clock {
>> +       unsigned int            id;
>> +       const char              *name;
>> +       const char              *parent_name;
> No string parent names for new code. Use struct clk_parent_data or
> clk_hw directly.


Would be inconsistent with other HiSilicon clock APIs. But i think it's 
okay.



-- 
Regards,
Yang Xiwen


