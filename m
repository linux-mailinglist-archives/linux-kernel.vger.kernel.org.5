Return-Path: <linux-kernel+bounces-2984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B80A8816590
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9051C22141
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A6D53BF;
	Mon, 18 Dec 2023 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dR3Ri75M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2042.outbound.protection.outlook.com [40.92.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534463A3;
	Mon, 18 Dec 2023 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdiWDuuhkT0OwMdn/3pcr6gvLLqAK3Dsdj68UYGC1XCOUwO5BlROfDCfmBUQUT8b8S9RWIPeH1LGuTbBnP0Lmf/aP1mg+x4gvd5xYsAI57yskkZVFyk/2frjiE8vdf/fnkzxduvmXzcGowA6gWIwrzTuGzSJWd6Zh1Anp+nUljJG9Msqj29ole7SkUWnN3t4zgjaGlKSletNUPN59wvhKgMWoRIH6Up0yEBRru+haQAOMAljmEDijQeMWrbKivaiXp3GAyrhJ+d34+YYFsCemcv9cpEmi9byVz/uA3182+UeXVscRs06PzPnSbqz7d3jUP5uAU+BoM4ZKXNlo6uZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlKZ1ObwWbK2jcMFNVxzoz3p0EP8fERlePLmjIj1Wik=;
 b=LB76CQatTx+Q8R58/PwCfJyr1f6XIWR3/q86p4Yas0FaPa+/KV8EvYhUGZSzkUqgn/70NvDASogvCJXHX/yzUcIe8oC2KVG+n6E4k1hEvUDS+HesExQlE/h8O1pDVokTr3HmQU1DP7mQyjTKYaH5xFMbqe7Nw8OX112J2ahHygVb/S39O5vvwZsagh1ivxvTAxPIMbLIto2/bCn+P0K4QlV+bfcIY/4OqmdwZuJC7jvfahRh1ogMLi33EoYxQcIlXTfny9fBNwJKoalw4aS4AMfyY91u+BVY4vjTXOI375IJWkuFdW6+fvKmBB4edWv1voJC4iD+oDc2QaJiihOcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlKZ1ObwWbK2jcMFNVxzoz3p0EP8fERlePLmjIj1Wik=;
 b=dR3Ri75MLkWgPdSeEZeb1uLyv8LgMTVW2uW5/GDloQke9ouz8tjVRXPGe1WU3XGW87OJ4bG2/am51ROL6SBCStKxnGJErn99SUeRBK4CPeSQXhL003cUlAmonjjORL/1JIi1EW30pxu4aW83tfNJBvZPBwZmOQR/D3LrmW9D71z2C4xVZTTztaR2iRaL50xq3dkQnSqvX69eQhdYi+3zZeNiAdv/zt91bZNs387oylclIZINfQk4jKE0Ds5PDSfsk0NBK8RdXhEmGcVCWUOiFmFfBZznJ3Ait6nIx9rdn3SO0p75BQWYCkTvK/nN3wCLhcpGdzJtJF4FgI7rx7cuDA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB6138.namprd20.prod.outlook.com (2603:10b6:510:2bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 04:06:43 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 04:06:42 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	qiujingbao.dlmu@gmail.com,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/4] clk: sophgo: Add CV1800 series clock controller driver
Date: Mon, 18 Dec 2023 12:06:28 +0800
Message-ID:
 <IA1PR20MB49535284E78A301FCFBB5882BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAL_Jsq+1y3mdfzLwr3sdeOGkRHaEPJo0Gr=g4Y6dAX=5AfTdfA@mail.gmail.com>
References: <CAL_Jsq+1y3mdfzLwr3sdeOGkRHaEPJo0Gr=g4Y6dAX=5AfTdfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [5ciQcQKc3jxC3nmTSrQ8QnP5nWrdfzwwVK6f/PQ3ZUw=]
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20231218040629.574658-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 96131c45-4ca2-42fd-1944-08dbff7ebe40
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l45pEuKkOL7M1WazgKRhhmHA5+0+9S+4BmIIiA8KLnD2zK1NJc6B8oLiRmRdBOwDYpWUVsqqFjFo4SnnFxmSd2l7gp6+Qy/l1gtFvN1UvExNEC6xcY2O3K6mPBTEm/adBBVCPSr1c4ww0iqgU13PagQQ4B9prEIvd/RGZ0jgqNjlfbk39zEaC+c/+uJsSqP/WEnV2YYah40kiiDMN947ZDuyK1IQ9Vd5fbsWUEYOpDN+cZoMWj02o9KvT1SLBsGUOvJsvH80Y0z6zNfhuzPY2HyqOhSy9QcCCynh3RexRmwL9oNhhTqmd8fWCJANUP8liXYVIHYH7vz2giTJ1accu0VgnpTJM3QmNcGZQ7BfW3enCAAwY8ZDM5zHks7Qn1EB8ZCz+K7zl7ww80C8z4mX0iNy7ig9tAKMMG+Gm7J54QCOsA9WTxZOLA/BH7LaSTVZGJSZRHBUEQ7xG+MoO7Fq+oaYqIyvNXWNPPjIAOYIZM0ADG++9sOEbzVxbZy+nwr+ihiEQr0P2bpyx67xyV9SFWqAWJ3KMq3a/IEn5uzmI2Q9b6J3Cx/JVWW+ZpZ8WM1pEF4DwAWkjw/rJ8vHndX6Z58k1bwR/U2e0flPCMK7IBoqNrUg6c62+MHSHUxkgHwqv2aWXiPzlDjRWABvwa5CIicNzM0Dz5pFLMAamURiodI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEFPdGdERzBtTXMvb25VTS9KemtJVHpNeHNWZjF2QXZWM1Z0YXNDcGdSZWdu?=
 =?utf-8?B?RU9Va1FYRDFLZ3RhbzFuM1pIS0UvU0VyRFhiMTZQYXJFU1BseUZSRXRFZFU4?=
 =?utf-8?B?MXpEdGk5Zy9KQzg2c3EwYlp3QXd2ZW0ybUdvYlorbHpId2JMUkVxazFwK3FQ?=
 =?utf-8?B?RWZhRkwxb1JHeUVZVlBmYXlDTkphd3dCQit5b1FQK05GdTFLMW55WEpzSlhz?=
 =?utf-8?B?eDhMcWNEUFk4a2QrNFN4QzQ5MTRCdkVpMHBJZHNrODVkT0p2S0JHZG5ERDMz?=
 =?utf-8?B?VkxsdGh2VU5aUFFKREFSU3J3T1h3VzNnRzMyTHJabzVta01mdnNOUm1lRUZ3?=
 =?utf-8?B?UHA3YUR1T3FUS3RpVGxDVDlDeDFSYlEvdFZ3M3FqOFVKZzFGamRzUWtXcDAx?=
 =?utf-8?B?eEpFRDBmSVI1NDJzbVJ6Tk5zalZ0L3pYQ01YbkJhNi96dElPVmx3NnZSV3A0?=
 =?utf-8?B?aW9iNk5TTmFqalAvQUcvbjJ6UnQxZ09Ea20xNFBEN09wVXVkUWp5aUtCRGVW?=
 =?utf-8?B?NlZtRll3Uk9MeDVvT21QZFdYdXEzdmd2NG5QWGNEVTNUTlFLREJBZGVlaURq?=
 =?utf-8?B?RkVTL0xpM2J0VkV1SDNra3E3cWlOTURxc3ZCY1c0YXNQdnV5SUU4bEgvNy91?=
 =?utf-8?B?bUhtM3l6U2JqYmZtNmw0M1ZVa1lOSGd1SnVSdE0zRStRT2luaGFxL2xFbGZj?=
 =?utf-8?B?ZVBZN0diZDROR05VOVFqTDVyM0VpbGJWVFVJL21XYklkNmkvNXA3MUN3V2hH?=
 =?utf-8?B?dE02aVhNa0FucjdCUjFuY3dqYVRtTFdBQkxCYUVZVmhaUmJFdytjYlBhcFVo?=
 =?utf-8?B?czcwRXJEY1NsSWxkOXRRc1lCbXM1OUVUWC9oZnlJVWxCOWdqQ1p0NU8xTTVT?=
 =?utf-8?B?ZEUzT1RIMTdreWJWaFJ0QjFkZVpEWFZiTzl0RjJrRU1pL200RkRaMHhDbG1w?=
 =?utf-8?B?K3hRMjZsSytMSDJ1Ym1DWXhOLzdYUENvU29YS3dCNHhSOS8vNHNNdU1FSUNi?=
 =?utf-8?B?TzVkY0ZIOE9HYzVQUThPazZSbnpFY2hqQWZacm9LWEh3RFBaWWRLajd4ZU5i?=
 =?utf-8?B?MFJIY2tRSmtCUHVUYVRmL2NPbG5yZUNsVjNjL3d0QUdXRlc1V2VHdWpoOUNz?=
 =?utf-8?B?NitLVGJlS2s2ZFdzemRWaXlkTWsxajZjaW9sQ0hINXFyTEh6cWdsc2VzRDk0?=
 =?utf-8?B?eDNUY05CRVpHUnZnWWhRQTNoRlM1WWRBSVpnYzJSWDVydlQyVUNBRWxPakJv?=
 =?utf-8?B?ajNFNnRPUWRnc2JzdmhLOWRzZ0d5M0xhemppVzdTeTlpRnFHdlpoM0NDb0tU?=
 =?utf-8?B?cTA2aXJQYTNqbWViYjJwNkpvbHBTRWpuTExzK2hyZWNDZTlRbFMybUZuKzMx?=
 =?utf-8?B?NGlQSllnRE4rRjNESzQvL3hhUFhUZ3lId09Oc01qQnJnZXlYbHN1UTk1cnF6?=
 =?utf-8?B?V01EV0FHYkcycTZrYjNmRVdnaGxPMVVMemF6c3RnaEJoSlExMkVNWWRTV3lq?=
 =?utf-8?B?cVdZN3h1TlFKbGhGQmNmYXlmMWxySEpaYlFHbXl6UWc5SHRDbEp6eUI5bUMr?=
 =?utf-8?B?WlJMOWtWT2I5MEFpTWNqUUdQWHVBNDFsZVV6eFZrY2ZzV0ZtTDNQOWlxQ3F6?=
 =?utf-8?Q?rzWeBTTk6xiKMwKTAOvQlEMhCLOQVO5EN+XKTK+8Ihuk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96131c45-4ca2-42fd-1944-08dbff7ebe40
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 04:06:42.8275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6138

>On Thu, Dec 7, 2023 at 2:37 AM Inochi Amaoto <inochiama@outlook.com> wrote:
>>
>> Add driver for CV1800 series clock controller.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV180X-Clock-v1.xlsx
>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
>> ---
>>  drivers/clk/Kconfig                    |    1 +
>>  drivers/clk/Makefile                   |    1 +
>>  drivers/clk/sophgo/Kconfig             |   12 +
>>  drivers/clk/sophgo/Makefile            |    7 +
>>  drivers/clk/sophgo/clk-cv1800.c        | 1574 ++++++++++++++++++++++++
>>  drivers/clk/sophgo/clk-cv1800.h        |  123 ++
>>  drivers/clk/sophgo/clk-cv18xx-common.c |   76 ++
>>  drivers/clk/sophgo/clk-cv18xx-common.h |   85 ++
>>  drivers/clk/sophgo/clk-cv18xx-ip.c     |  894 ++++++++++++++
>>  drivers/clk/sophgo/clk-cv18xx-ip.h     |  266 ++++
>>  drivers/clk/sophgo/clk-cv18xx-pll.c    |  465 +++++++
>>  drivers/clk/sophgo/clk-cv18xx-pll.h    |   79 ++
>>  12 files changed, 3583 insertions(+)
>>  create mode 100644 drivers/clk/sophgo/Kconfig
>>  create mode 100644 drivers/clk/sophgo/Makefile
>>  create mode 100644 drivers/clk/sophgo/clk-cv1800.c
>>  create mode 100644 drivers/clk/sophgo/clk-cv1800.h
>>  create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.c
>>  create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.h
>>  create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.c
>>  create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.h
>>  create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.c
>>  create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.h
>>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index c30d0d396f7a..514343934fda 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -499,6 +499,7 @@ source "drivers/clk/rockchip/Kconfig"
>>  source "drivers/clk/samsung/Kconfig"
>>  source "drivers/clk/sifive/Kconfig"
>>  source "drivers/clk/socfpga/Kconfig"
>> +source "drivers/clk/sophgo/Kconfig"
>>  source "drivers/clk/sprd/Kconfig"
>>  source "drivers/clk/starfive/Kconfig"
>>  source "drivers/clk/sunxi/Kconfig"
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index ed71f2e0ee36..eeae7ae93f89 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -119,6 +119,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)         += rockchip/
>>  obj-$(CONFIG_COMMON_CLK_SAMSUNG)       += samsung/
>>  obj-$(CONFIG_CLK_SIFIVE)               += sifive/
>>  obj-y                                  += socfpga/
>> +obj-y                                  += sophgo/
>>  obj-$(CONFIG_PLAT_SPEAR)               += spear/
>>  obj-y                                  += sprd/
>>  obj-$(CONFIG_ARCH_STI)                 += st/
>> diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
>> new file mode 100644
>> index 000000000000..d67009fa749f
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# common clock support for SOPHGO SoC family.
>> +
>> +config CLK_SOPHGO_CV1800
>> +       tristate "Support for the Sophgo CV1800 series SoCs clock controller"
>> +       default m
>> +       depends on ARCH_SOPHGO || COMPILE_TEST
>> +       help
>> +         This driver supports clock controller of Sophgo CV18XX series SoC.
>> +         The driver require a 25MHz Oscillator to function generate clock.
>> +         It includes PLLs, common clock function and some vendor clock for
>> +         IPs of CV18XX series SoC
>> diff --git a/drivers/clk/sophgo/Makefile b/drivers/clk/sophgo/Makefile
>> new file mode 100644
>> index 000000000000..a50320764200
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_CLK_SOPHGO_CV1800)        += clk-sophgo-cv1800.o
>> +
>> +clk-sophgo-cv1800-y            += clk-cv1800.o
>> +clk-sophgo-cv1800-y            += clk-cv18xx-common.o
>> +clk-sophgo-cv1800-y            += clk-cv18xx-ip.o
>> +clk-sophgo-cv1800-y            += clk-cv18xx-pll.o
>> diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
>> new file mode 100644
>> index 000000000000..8176ee672190
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/clk-cv1800.c
>> @@ -0,0 +1,1574 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/clk.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>
>You probably don't need these 2 headers and the implicit includes it
>makes are dropped now in linux-next. Please check what you actually
>need and make them explicit.
>
>Rob
>

Thanks. I have fixed in the new version.

