Return-Path: <linux-kernel+bounces-167584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83D98BAB98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2850928382E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9120C15251F;
	Fri,  3 May 2024 11:30:42 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FA848A;
	Fri,  3 May 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714735841; cv=fail; b=hSgcrx1jOKBEQVpUxsOmqmqxWcEXKdhHM1u2u2/lhY56JPRiuxnEMntMYA6DOSjwfqAUZJrem+HaCJKjXwzaLdfPNw4iV1RqP02tr86tzt+99nIbq/ZtV6aPbwxRhQs6ohS4sGaYAMLfPcYOi1m0wVfL2MUHoIlG+SMUmkNqiV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714735841; c=relaxed/simple;
	bh=5hBBFVVnzXr2ppLgLOQg3aEs/dRzXELqUHmnYSaWtuk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YfRnjLbYo7eHax2GuamgmMxNEurfijt+XEo/FJ+SeXI7Su6L25NAzU77ZHSeCIelPu6amwy8WEqnIave5sCry9I+Lvk0DfdzxsvmyqeNwNpZ9lsc83j02QVqxj7+Hwa6KAsLRB9ELddPYzlczJyc+mQzY9/1/Edp3zdviVv8j3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWp7G86IB2VMTzOoTDkA3zOPhWuQH601sgzyaiBqmNjXGA4Fhh3iYqSrkUSmD5xF+W/gvgNeS+ekIVxtimwdtDKztu14SE9BuDqWsUyYUsi2ZpFm3HhpM2zTdhGbQppRBfLmoqzx9j2RtGmFdfqMqxZkKzznfkbmXwc97tDkMQ4VcUbckznTf9pwgggzd40We3/grkqdKOBVmVFbqG/wY8gxVp5MjCIWogJijeM9loIv24BQpwSPADWse4I21ERCbuNHrkbMlFM760FZO+mHUUOv5ydpstYUixHJ95a7tP/GP3Ug5cZyfISwCnPcZGUOQS2VC7v7P+94HisyFvAnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dld133fpG5e2vmkb1UFkpxIXQr+0SGIgHFAa8R4XqRI=;
 b=b7kplacfxNwmhShVFo/wB9kEc5k0Ovp+qcriiHeZbCN3iIR+zcJKFlk45kxctJyY9XLHRNbQDyyg6YRq/VPbTUvWQQ8bAynwLQ3rdzLnJKJFVWlx+8yerVpCqVsyVdTuCW/KqZAqoyVXc62SJ35O2Ilt7MjFvVhhmzajZox3Xn9T88nyFIym2zYqDui9A3o1fHv3Tx0Khkn6JmEUnxpHuP0Uz5CazLoiSIfnFWybC0jnDE6KinuvrE4P9MLhlOUr4sFytUchqeI2pbopJCGIWNwmliyJZzEB1Otzb+S//Ep4OU2gzRsI2RYHRaBq1heamBX5TIbFSD9H+AXp8eSy1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9) by ZQ0PR01MB1238.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 3 May
 2024 11:14:46 +0000
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 ([fe80::feb4:a4b4:1132:58f4]) by
 ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn ([fe80::feb4:a4b4:1132:58f4%5])
 with mapi id 15.20.7472.044; Fri, 3 May 2024 11:14:46 +0000
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH v3 0/7] Add Pinctrl driver for Starfive JH8100 SoC
Date: Fri,  3 May 2024 19:14:29 +0800
Message-Id: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: NT0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::20) To ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1176:EE_|ZQ0PR01MB1238:EE_
X-MS-Office365-Filtering-Correlation-Id: b9747905-08e1-4d0c-9a9b-08dc6b623da2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hECOiQARsye/5ZPlglz3pcsQrbnB3tuGjVLKT0xswhCafcYx7z12r4EaMDQuxQB5D93Yigyj/8LR+g+GiXRWKmhE4pZTHwEd2Ji+PAtgNPV0LChqpGSVBKWqonpXsjtNJxYRrH9dY5nXU4f2pKAkEdM6uI8CSS8hzlOtrOtQoGvoHDBvkHYh23O9393OYy6lsIuAiW3sA72SbmsAQZWby4Y3PnhhO13kE+U9iIsQvaRsvtHfZyHU4/tXpLegv3hkjvBxUv6NN13Tsd0M68P/BqWbZon/rIScMwaQR/9L8y5tl4sPOvIp2ATuN4ZH9wJYGQU8QmoaZdczlefJlqRFalbNDgR/YeNrAPqdlBBFoXuycY5C5DrjxNDL39F4fYOl2a2GWmzgdvQMncDgb9GeorCDVMtkN7+pVKMJ7+gkUKUj0kvxQS02hoBFQr5Q4TDONjOVnjPh8eclazGRGEXY7EMn60+erVFOr1woEv/169CA/5iCyMzvd+SWR2M5kbAhExkbo+poXhS9Y+c7FqzIFhlu0MwY47eTuhM4SwhbBRxc5pABP8828vR8+2xLH4xw0HjhG9uHfFsfuimNuiy33AL4xjpLIw542S6D1WTBgkA/EXLGaSg+i2UhEMm657tFVNGGezQ0Dsv5y6Cx5lcXXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(41320700004)(7416005)(366007)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVlER1luWmpXcGsyQUdSb1JDdHd6TUhkZ21CY2Z0MFlyWld0N0ZGcm9QMi9r?=
 =?utf-8?B?cE0rNTA3UCtvSG0wMFlVSGJ6d2pudVJJRk5WS0t6WlVaUVhzR0pGWTliZlRK?=
 =?utf-8?B?cm14TjFQc05OWFhRbkhXeTQ1a05SYXc5Mmp0eFFXMUdqdWRkbHlNWGxaOEZV?=
 =?utf-8?B?a3BzVFZOYlg2enEvK2VLZldOR1hqOVkzOG1sZ08xTXZFa1FGRlRUZFFKQkY1?=
 =?utf-8?B?S3QxVWdZbXgxbXovcVJYei8wSlN6dDFHWGUvRlRzcUFieHRoYWxxL29IaU5w?=
 =?utf-8?B?TFVkRVIxdDl2TEhuRzhVWm1nZCtURVhxWVRQdFNWRDhqVHN2ME5jUWk5SVNP?=
 =?utf-8?B?STZ6SDFmN0M3REI3dmJwRCtUQ1RuNHRFcGozcmpHRUtUMVFaMVhuRXNGWmZG?=
 =?utf-8?B?UVBmQmt1WUh1d014SDJLYk91TDBWYm9weXRVWnl1MlVyU05kSXJuZUtaMzVS?=
 =?utf-8?B?RVJQR1hBWDQ1V0lwb05ZSDc1dk5kbkZaMGFuekM1OHZmeE85c3NwZHBjVlVa?=
 =?utf-8?B?R3ZnSUtIbG4xZVg1SzRMdnZpK2U1SFFHaG9mRDFsZE5iUk1HZWYvOTZJdXUw?=
 =?utf-8?B?N3JUeDNyeUxLaDdmbUkva0JjK3lwdjhxRUlqVElrb2NYMm5uL1hXbmliSFp1?=
 =?utf-8?B?dVAxSWREWC83akJGTXU5a3B3ZXVFb29KVTN3clppL1N1OFM4Sk16WjU2dkpN?=
 =?utf-8?B?c01vY0ZXVDk2THZEbnZNSkVqcDlrNm4rZDJRR2RxKyt2VnJwNWdybkhLb2xU?=
 =?utf-8?B?Umd4VUN5WmFRTmRCb1RQS1ZKeVBLOGNwR1E4YXpNRC9lVkRXNVhJTjkyRmh2?=
 =?utf-8?B?NjRKc0ZLNzU3bGVLNE82Nk5BTnMxQjk5OGNNZWltakFTeHdwUmJIR2k4cmxy?=
 =?utf-8?B?bFBEVklhaFFXNGFSV21QeWNUdjdud3FpWjljWjFRYjVsVXgrU1Y3UnBSS3Uz?=
 =?utf-8?B?QzlrejNNM0FzWFRsZkJIUllWbWxwckZyQldLdlZyRlEwazBQcDdWLzVwZGtn?=
 =?utf-8?B?MFYzR1NjQ0xNYSs1aUpnRzNWM1Y3bzV3RWYvQXcwR1pVeGwwVU9zL2tpcmtH?=
 =?utf-8?B?NGd2TmNtL0NJSGs3b1Q2a0twVWJmcmY1ZjYyelFURWh6UW1hMTd1eGFtdXJo?=
 =?utf-8?B?Y21lTThaWE5hZnhqQ09rR1pHSFdXOElKN2ZRTXpBb2RwZ1piSG5LMXJSZC9F?=
 =?utf-8?B?SjNab3FYT0hkcXNhWHRCSSs5ZVZjUzF1OGZnSUpLUXRwQUoxc3NQMjRVdzZh?=
 =?utf-8?B?bXV5MlRpREVMY29NMURnTUFHUTBUZXdvNjJseExWRTZweFJ6Mnk2UmZRMzlr?=
 =?utf-8?B?bGFwZTJ0aStnbllXVHE2RG5LWmZvbmVJUnllRU5xN1pRRldlOGFrVEdnK0J3?=
 =?utf-8?B?Tkh2N0hCWUVjQ2RHVXErQjZYTHhoOW5waDVDTVZGZFBacjQ4RnpDWWlNdjlw?=
 =?utf-8?B?cGF2VHR4MUNnSzM1ODdjOWhIUm0xTEpIZ0NUck05bDIrMUw2TWpJOTdKWUdR?=
 =?utf-8?B?YlJSSW9BS0N0aHh2Uk1VVXFHV0hHWDZPTy9YU1cxVnZnb0JjdENoOFdWNHNj?=
 =?utf-8?B?VGM1SitWSC9UNDJ0U0ZObWhrS25pY2ZpYlBNaWRueFg4YXNPYXlHQm5hNmo2?=
 =?utf-8?B?c1ZncEpBeWx0cjBCTUQwcnJxTXZ1VnBESkpUOStwcUFiYTFsRUU4U3RIZktL?=
 =?utf-8?B?U282SVBIUmJQbDgxSU9IeFo3QkcrRkVGbkZiWUlOV1NuRlArRjVWblJ0T2o3?=
 =?utf-8?B?b0RGbHFlTU5UUEYxN05wTXJuYVhGQTF3bFJydGY4WFEwOFdaUkMwdjFuMDRV?=
 =?utf-8?B?QkxlQTYybERmZ0x1QW84ZFZRZjZjeE9zdkFHaVFTckxSMEtGc0lwMFExM2VO?=
 =?utf-8?B?bHBXZGtheEd6TUJ5c3Qzek9VQ0xtc1p1QUNqTE9kNWhFeGVFcnhKb3hmbzQ1?=
 =?utf-8?B?aVk5R3JQbU81YmFGU2JwSUF2Nm5GUEFyZ0hNZ2g0TkxLZWdSb3BYcXdkeFVs?=
 =?utf-8?B?cFlnTk9qVmFhcFlJaWQ2N2dKT2laK20yS0pNQU9KWGxTMHlZYUlKTVY3dTRF?=
 =?utf-8?B?SnFJRlYvRUtha2xZbzdTQUVENHlyVDZrVGFIQUdsdkZnMVZscGd0TitNdW1w?=
 =?utf-8?B?dXJlQ2FjNis3SlJvMXFzOEhlQnJ1TXVDWDMwY1dIVys5OGYybkRzdEZGbWV0?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9747905-08e1-4d0c-9a9b-08dc6b623da2
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:14:46.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiZXRHrI9XkJGUqs8WZi0eBeDBke0leAcwTGlUibzzqiJ0kIL/D1G1VlmaT7d+IDMJDbaMlgeyHJfU4pvuxiKcZnmmYvWh5Uf5CqNsV6tec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1238

Starfive JH8100 SoC consists of 4 pinctrl domains - sys_east,
sys_west, sys_gmac, and aon. This patch series adds pinctrl
drivers for these 4 pinctrl domains and this patch series is
depending on the JH8100 base patch series in [1] and [2].
The relevant dt-binding documentation for each pinctrl domain has
been updated accordingly.

[1] https://lore.kernel.org/lkml/20231201121410.95298-1-jeeheng.sia@starfivetech.com/
[2] https://lore.kernel.org/lkml/20231206115000.295825-1-jeeheng.sia@starfivetech.com/

---

Changes in v3:
- Replace "additionalProperties: false" in dt-bindings docs by
  "unevaluatedProperties: false" to allow reference to properties in generic
  pinmux and pincfg schema.
- Remove redundant keyword "allOf" from the "compatible" property definition.
- Drop all PAD_GPIO*_* macros from dt-bindings header "starfive,jh8100-pinctrl.h"
  and move them to DTS header "jh8100-pinfunc.h".
- Drop "GPOUT_LOW", "GPOUT_HIGH", "GPOEN_ENABLE", "GPOEN_DISABLE", and "GPI_NONE"
  from dt-bindings header.
- Add macros "PAD_SLEW_RATE_FAST"and "PAD_SLEW_RATE_SLOW" to dt-bindings header.
- Change the commit message of the main driver and sys_east domain subdriver to
  inform what SoC they run on, and to explain that the main driver provides 
  common APIs to all domain subdrivers to perform their respective tasks,
  and how the main driver and domain drivers work together.
- Add macros JH8100_SYS_E_NGPIO, JH8100_SYS_W_NGPIO, JH8100_SYS_G_NGPIO,
  JH8100_AON_NGPIO to header pinctrl-starfive-jh8100.h to represent total
  number of GPIO_PADs in sys-east, sys-west, sys-gmac, and aon (always-on)
  domains.
- In function jh8100_get_padcfg_base() of main driver, macros: PAD_GPIO47_E,
  PAD_GPIO15_W, PAD_RGPIO15 are replaced by JH8100_SYS_E_NGPIO,
  JH8100_SYS_W_NGPIO, and JH8100_AON_NGPIO respectively.
- Add function jh8100_padcfg_ds_from_uA() to main driver to convert uA
  (microamperes) from dts property drive-strength-microamp to drive strength
  value when setting the pin configuration register.
- Add function jh8100_padcfg_ds_to_uA() to main driver to convert drive
  strength value from pin configuration register to uA (microamperes) when
  reading pin configuration.
- Remove "of_gpio.h" and use only the gpiod interfaces in
  <linux/gpio/consumer.h>. 
- Remove cross-include "../core.h" from the main driver and move it to
  header "pinctrl-starfive-jh8100.h".
- Remove cross-include "../pinctrl-utils.h" from the main driver and
  add the function prototype "pinctrl_utils_free_map()" to header
  "pinctrl-starfive-jh8100.h".
- Remove cross-include "../pinmux.h" from the main driver and add the
  "pinmux_generic_*" function prototypes to header "pinctrl-starfive-jh8100.h".
- Remove cross-include “../pinconf.h” from the main driver and add the
  function prototype "pinconf_generic_parse_dt_config()" to header
  "pinctrl-starfive-jh8100.h".
- Replace "GPOUT_LOW", "GPOUT_HIGH", "GPOEN_ENABLE", "GPOEN_DISABLE", and
  "GPI_NONE" in the main driver by constant numbers 0, 1, 0, 1, and 255
  respectively.
- Update function jh8100_get_padcfg_base() to return base address of pad
  configuration registers for sys-west and aon domains.
- Update function jh8100_set_one_pin_mux() to support pad function selection
  in sys-west domain.
- Update function jh8100_gpio_direction_output() to remove
  JH8100_PADCFG_BIAS_MASK from mask so that when gpioset configure a pin
  as output, the pin bias setting (pull-up/pull-down) will not be cleared
  by the driver.
- Remove function jh8100_gpio_irq_setup() and the GPIO wakeup irq
  enablement in probe function from main driver. It is replaced by 
  function gpiochip_wakeup_irq_setup() in gpiolib core
  "drivers/gpio/gpiolib.c".
  The function gpiochip_wakeup_irq_setup() is added as the wakeup gpio
  irq setup function in the gpiolib core.
- The interrupt handler jh8100_gpio_wake_irq_handler() in the main driver
  is removed. It is replaced by gpio_wake_irq_handler() in gpiolib core
  "drivers/gpio/gpiolib.c".
- Remove the inline function pin_to_hwirq() from driver header file
  "pinctrl-starfive-jh8100.h".
- Remove cross-include "../core.h", “../pinmux.h”, and “../pinconf.h” from
  the sys-east, sys-west, sys-gmac, and aon domain sub-drivers.
- In sys_east domain sub-driver, macros PAD_GPIO0_E through PAD_GPIO47_E are
  replaced by constant numbers 0 through 47.
- In sys_west domain sub-driver, macros PAD_GPIO0_W through PAD_GPIO15_W are
  replaced by constant numbers 0 through 15.
- In AON domain sub-driver, macros PAD_RGPIO0 through PAD_RGPIO15 are
  replaced by constant numbers 0 through 15.

Changes in v2:
- Add "(always-on)" to document title to clarify acronym AON.
- Replace "drive-strength" by "drive-strength-microamp".
- Update "slew-rate" property in sys-east, sys-west, and aon document.
- remove redundant "bindings" from commit subject and message.
- Change regular expression "-[0-9]+$"  to "-grp$" to standardize client
  node names to end with suffix "-grp" instead of "-<numerical _number>".
- Use 4 spaces indentation for DTS examples.
- Update DTS examples in sys-east, sys-west, and aon document with client
  driver pinmuxing.
- Remove redundant syscon and gmac macros from dt-binding header file.
- Remove redundant register macros from dt-binding header file.
- Add "wakeup-gpios" and "wakeup-source" to aon document.
- Add "gpio-line-names" to sys-east and sys-west document.
- Update the description of syscon register usage in each document.
- Update sys-gmac and aon document with information of GMAC voltage.
  reference syscon and GMAC pad syscon.
- Fix the pinctrl device nodes compatible string too long issue.
- Move all common codes from subdrivers to the main driver.
- Change the commit log to "add main and sys_east driver" to indicate
  the commit of both main and sys-east driver.
- Turn pin_to_hwirq macro to a static inline function to hide gpio
  internal detail, and also, for easier code readability.
- Change "JH8100_PADCFG_BIAS" to "JH8100_PADCFG_BIAS_MASK".
- Change "#define JH8100_PADCFG_DS_4MA   BIT(1)" to
  #define JH8100_PADCFG_DS_4MA   (1U << 1)".
- Replace "jh8100_gpio_request" by "pinctrl_gpio_request".
- Replace "jh8100_gpio_free" by "pinctrl_gpio_free".
- Replace "jh8100_gpio_set_config" by "gpiochip_generic_config".
- Use irq_print_chip function to display irqchip name to user space.
- Use girq to represent GPIO interrupt controller.
- Update code to ensure wakeup-gpios is always an input line.
- Remove the jh8100_gpio_add_pin_ranges function and use gpio-ranges
  in device tree to provide information for GPIO core to add pin range
  for each pinctrl.
- Change "StarFive GPIO chip registered" to "StarFive JH8100 GPIO chip
  registered".

---
Alex Soo (7):
  dt-bindings: pinctrl: starfive: Add JH8100 pinctrl
  pinctrl: starfive: jh8100: add main driver and sys_east domain
    sub-driver
  pinctrl: starfive: jh8100: add sys_west domain sub-driver
  pinctrl: starfive: jh8100: add sys_gmac domain sub-driver
  pinctrl: starfive: jh8100: add AON domain sub-driver
  gpiolib: enable GPIO interrupt to wake up a system from sleep
  riscv: dts: starfive: jh8100: add pinctrl device tree nodes

 .../pinctrl/starfive,jh8100-aon-pinctrl.yaml  |  260 ++++
 .../starfive,jh8100-sys-east-pinctrl.yaml     |  222 ++++
 .../starfive,jh8100-sys-gmac-pinctrl.yaml     |  162 +++
 .../starfive,jh8100-sys-west-pinctrl.yaml     |  219 ++++
 MAINTAINERS                                   |    7 +
 arch/riscv/boot/dts/starfive/jh8100-evb.dts   |    7 +
 arch/riscv/boot/dts/starfive/jh8100-pinfunc.h |  504 ++++++++
 arch/riscv/boot/dts/starfive/jh8100.dtsi      |   46 +
 drivers/gpio/gpiolib.c                        |   87 ++
 drivers/pinctrl/starfive/Kconfig              |   59 +
 drivers/pinctrl/starfive/Makefile             |    6 +
 .../starfive/pinctrl-starfive-jh8100-aon.c    |  150 +++
 .../pinctrl-starfive-jh8100-sys-east.c        |  220 ++++
 .../pinctrl-starfive-jh8100-sys-gmac.c        |   89 ++
 .../pinctrl-starfive-jh8100-sys-west.c        |  164 +++
 .../starfive/pinctrl-starfive-jh8100.c        | 1103 +++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |  125 ++
 .../pinctrl/starfive,jh8100-pinctrl.h         |   13 +
 18 files changed, 3443 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml
 create mode 100644 arch/riscv/boot/dts/starfive/jh8100-pinfunc.h
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-east.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-west.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
 create mode 100644 include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h

-- 
2.43.2


