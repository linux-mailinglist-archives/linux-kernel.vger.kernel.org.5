Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C347A328B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 22:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239403AbjIPUso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 16:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjIPUsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 16:48:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D0186;
        Sat, 16 Sep 2023 13:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmWrh/MAaq/g1tBHF2DvozU6r2pl7lCgJUMKleLCDPw3zUhsqr1bk5yIZtZY5em4gX3JtJnwTHvpdlAkAyB2C6SieE+MZLX8krOt55kjTRifcvMEgXJSHUJV1WL1rlzsNnApToEghN28zW6l9smd2cdFsr3D5iW1aX04L0d/BNjh5SWwPoRlV3+hkzYKX3JSLK0okmKPSy/M/7E4qlrz5MBHDTM2Yyl2kBlHDQ/z3IBuAhiNEBQcsOegP9l3uaedKE3fcPsQ6Q10g8Mrqrozct1/sJuoe6rX+Gn5Dz2s/xW624s1RhuPSiEEn3uqcjiW/SnQTEJB0e7o6TjcyOIkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvYva0zb8zZVd0sIGwudbo2mSbWmSz1SO3slBDb+dCg=;
 b=dAIQ/8wogtL/ukRprNIXI8ya1tPRq+9NW03RXRuuN2rOS4bv2+OxoQ2LZDq976h5jIjtlj52Gydnnon8HtoSU3i4rBG8Fp9qGBOUPX9cfSXq62DZ7OEfWIZyzOduDn6ZBmRzUHgTxVOb6WIjigd9JcFQDhCaN7gLN1ib6WE6FmFF9ZYqf5bx1Xb3ups48WDG6F2Dq7UQl1nblkfQh5iZSSKfvOi2weeZlMpNNC2gPzpgFkre6e4t7mdt3Nb5dG9RN5nFd9W1+N2VFQqH4lHjzewrZII7U3lgRVh64ABKVzg6MaJH7rzy22fjhF22hjxDAiqNW7g+bUwtn15M6Rjnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvYva0zb8zZVd0sIGwudbo2mSbWmSz1SO3slBDb+dCg=;
 b=bJTE6wglRTAC9sXsUww6x+1m5cvnXTwldm7eKhMAHfzIWxJeEvOqI8iJ9Jm9Fw5zkQOTa65a8sA+MgRz8OtdHzbsCxN7YcoLiNLteYKD5YQ9kYG7JToCn4Jd2ZVOrZLqXCOwxUT8l0XDlg8636aMWy72GDv530xKnZn73GakIL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CYXPR08MB9183.namprd08.prod.outlook.com
 (2603:10b6:930:e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 20:48:01 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d08d:a749:aae3:ac0]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d08d:a749:aae3:ac0%3]) with mapi id 15.20.6792.023; Sat, 16 Sep 2023
 20:48:01 +0000
Date:   Sat, 16 Sep 2023 15:47:55 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: Re: [PATCH 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZQYUe46/rj8jqNvg@nixie71>
References: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
 <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
X-ClientProxiedBy: SN4PR0501CA0001.namprd05.prod.outlook.com
 (2603:10b6:803:40::14) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CYXPR08MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: deaf6b1e-62c8-4250-b66d-08dbb6f63776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kX//oQqu2rsLQeK2m005jGJlAIn3xNK8V7uC+DQTF/TpUoTeQjojpUXBo7ExsUO/kfsCcU9+ERectjWCXuScaJUFEPitvHMeLQ3WckR/uYO2u+w/h5Efv7xHMt7dr4C9OAsMB8WskdleKwNUncSRhwoPf/jSyZ5l5F2jFLR9PdsoOyxU/cFVsT42LjD/Qf6eE8fU/GYEzb+633ZUZ+QfJZZicIXP7ZQ4WuWu0n3sZEgYWCqV8lj43zb1NAE5AkRSePr7G5X8btfBoMJJ/Z8I+RwVfLMx6Sgl/jqI21phNDMVVDKd9G4aOyhTNc1AU1xHx8y7sGc9how/63OE0rtrybpo724+Hd6uSzfdw/h2f2roeAiWC/0waRr7t7Ua3QlgRVhvo2uuC0ojATuEhc7JrfBAseRuMRctQ5ycV4KEzAxL9Uf/gI6q8Sn2fZCrF3iyHF7L/41h8gRI1K8ZgP1iKzjliEfRL8faiAY+WBEnyFz0NtCMfRMMyfDH2Fu1x9APERvpqRgB2GnUVJiGqsClFW1QZlIQ5O2mLO8QV47F3L2uAWkq7Z1JFQwFPHZcTduh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39830400003)(136003)(366004)(396003)(376002)(186009)(1800799009)(451199024)(66946007)(33716001)(66476007)(66556008)(6916009)(66899024)(54906003)(316002)(26005)(83380400001)(6666004)(9686003)(6512007)(6506007)(6486002)(86362001)(38100700002)(478600001)(30864003)(2906002)(7416002)(5660300002)(41300700001)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NnzEvoc5dEpMrofdVkXAtJDTH76Zfbii4sPP6ZkQTIOz24CfLJkrRuLl6aWN?=
 =?us-ascii?Q?s/9x959YxDIbjmrrIesBE2ueD0ki0mZZkzAUrPHqxNHgBYoP0k2SPlAiAb/d?=
 =?us-ascii?Q?kRAS6wPPcHIjSv4HvBMTisd89uBG3z2czZglnihnmuDo5RjcOQ9Vk4L9eMJB?=
 =?us-ascii?Q?Q3PXOpvAQmQ+6T5U6LHxM7XwT2h0wBudcA/14xYVG7Ucqr8ZvabpGikOk/A6?=
 =?us-ascii?Q?NCXz1Ikg8/GuDjzQ7ZE+3E/EFJlr/I/+rWECoasqDrz8Z8QdXjOfjyq7qXJi?=
 =?us-ascii?Q?T292uA28I8KkxTGsUSNmErxT3WWnEwzItUToEIx6I5zWRVyvNsS879EOsvSm?=
 =?us-ascii?Q?bSlSIrQTiQF8C/BPx7mmqaIdhGNEtihnWHmuJ60taeGhw9E7djalYlC1eJof?=
 =?us-ascii?Q?yXJn8DcrR//ogvXRp5f44UBHWEPTZ+kQHKoK7gFmVqv/T+lnX9EIeyK/06YD?=
 =?us-ascii?Q?wYHzcsOX1XrB+hA4Dw9o7jFCnCOGHlI1zvp8xYgAUQ1ixBdyCkCUG+Yju/Lc?=
 =?us-ascii?Q?Hb+lodaCuCnjOKSpy8dOZwMC3y1vtE9ikBhnBLKkfppqU0WCJk9bO/Svl1JU?=
 =?us-ascii?Q?9Y3MBzkX9tSgwqKnui94QtNO/53hDBGveOWTruG21gBV9zOwjZCuNd4NYZoZ?=
 =?us-ascii?Q?AJX40u7+Pgrhz2jkXnXyD2no5oSJ5/GrTXkXFhXHFgoUs98eDNEAxKn/kjrX?=
 =?us-ascii?Q?+VGHL3Tl+SW30XAXlIJ0JGrJL+TZLASXkTlGoIflkn1Z3nweO8OzXnbx74e2?=
 =?us-ascii?Q?dOMkjtg9+CJNHb6fhHgYw0ejvhfTeAIeXReRcIEx2NlZCyLWPlGLvLi2FAVc?=
 =?us-ascii?Q?6EXtJJSEelNB70qpD+krCdmIuOvk0L8Od13OaeaD/DKGfQ9JyaLfaTJa5IE2?=
 =?us-ascii?Q?wn6O+UBRV8o06/twfDoACw+qaZ1eQiKyLVkvtXdun3lJ229a+74WY+n8b3VC?=
 =?us-ascii?Q?6OAbnr77WgkpWwFTQGafNgxc9oVe1+H9U2NYMq5xpi0brl036MZLcy/z7knV?=
 =?us-ascii?Q?6twv/03/lprGDBW5JyxIo+fNBz+r3AMySUb1aMz5rPVQ1wIzmDRDWhv7Zq2D?=
 =?us-ascii?Q?F9egXkY3dPsU8CASDRDervjSyn4hhXqv+ctjbbNlMR2GtNewlkZ/bdxXYxXn?=
 =?us-ascii?Q?3qJ7zYk4CvPuntAec6hsPQP4zokBsHVJ9iUkJBn4ncI+vaTCV1r+iv7H3leh?=
 =?us-ascii?Q?Pid3JFTUQvhnevGTsuZ2YCdTbWkXHONb19/ZHgZufKGWGgYnmcnCxK6yTztq?=
 =?us-ascii?Q?WX1s3v1WQYlB1cGOqvLIT2CDi9yLCi8hH3e+Y+oaH4BBxv2jtphD9oYvTPO8?=
 =?us-ascii?Q?Npe5WBRvxasogBSQtpMgG9I4Gun/xfsDrPBRLEHDnfIC6hU8H6FigDf7OByi?=
 =?us-ascii?Q?OCr2xxXC9lTSOe9U8ujWFA8u/Ob3YK9LlWoy7FWYN6wSw9zRMhMyLV+qD+t0?=
 =?us-ascii?Q?P+YWZj0s96ms1MrvgB+IAPXWsIFG63eegwZkuhj+mWAuZin+l0uA+XksTCB6?=
 =?us-ascii?Q?93BQOqD3KmhgbH2fHUl35MEBUU6x/To+5cR0nBj+nw/hPPlkqF4Nx1dtdKGE?=
 =?us-ascii?Q?YBsZdN3rRemB2l/ftGp53lLM8yi5wJhX4MgaFrrJ?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deaf6b1e-62c8-4250-b66d-08dbb6f63776
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 20:48:01.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Dvt7b1CwBzKoLTcbRuf9ik2usYS8wKUa+kIevy0+KJipKDEJbZEtBG3+Gzvw3zZRnelxeQtZ5Gag1Ul3KMmig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB9183
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan and Jonathan,

Great work! Just a few minor comments below.

On Wed, Sep 13, 2023 at 03:25:30PM +0200, Stephan Gerhold wrote:
> From: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> 
> Add a simple driver for the Himax HX852x(ES) touch panel controller,
> with support for multi-touch and capacitive touch keys.
> 
> The driver is somewhat based on sample code from Himax. However, that
> code was so extremely confusing that we spent a significant amount of
> time just trying to understand the packet format and register commands.
> In this driver they are described with clean structs and defines rather
> than lots of magic numbers and offset calculations.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  MAINTAINERS                              |   7 +
>  drivers/input/touchscreen/Kconfig        |  10 +
>  drivers/input/touchscreen/Makefile       |   1 +
>  drivers/input/touchscreen/himax_hx852x.c | 491 +++++++++++++++++++++++++++++++
>  4 files changed, 509 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..c551c60b0598 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9331,6 +9331,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
>  F:	drivers/input/touchscreen/himax_hx83112b.c
>  
> +HIMAX HX852X TOUCHSCREEN DRIVER
> +M:	Stephan Gerhold <stephan@gerhold.net>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml
> +F:	drivers/input/touchscreen/himax_hx852x.c
> +
>  HIPPI
>  M:	Jes Sorensen <jes@trained-monkey.org>
>  L:	linux-hippi@sunsite.dk
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index e3e2324547b9..8e5667ae5dab 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -427,6 +427,16 @@ config TOUCHSCREEN_HIDEEP
>  	  To compile this driver as a module, choose M here : the
>  	  module will be called hideep_ts.
>  
> +config TOUCHSCREEN_HIMAX_HX852X
> +	tristate "Himax HX852x(ES) touchscreen"
> +	depends on I2C
> +	help
> +	  Say Y here if you have a Himax HX852x(ES) touchscreen.
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called himax_hx852x.
> +
>  config TOUCHSCREEN_HYCON_HY46XX
>  	tristate "Hycon hy46xx touchscreen support"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 62bd24f3ac8e..f42a87faa86c 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
> +obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX852X)	+= himax_hx852x.o
>  obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
>  obj-$(CONFIG_TOUCHSCREEN_ILITEK)	+= ilitek_ts_i2c.o
> diff --git a/drivers/input/touchscreen/himax_hx852x.c b/drivers/input/touchscreen/himax_hx852x.c
> new file mode 100644
> index 000000000000..31616dcfc5ab
> --- /dev/null
> +++ b/drivers/input/touchscreen/himax_hx852x.c
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Himax HX852x(ES) Touchscreen Driver
> + * Copyright (c) 2020-2023 Stephan Gerhold <stephan@gerhold.net>
> + * Copyright (c) 2020 Jonathan Albrieux <jonathan.albrieux@gmail.com>
> + *
> + * Based on the Himax Android Driver Sample Code Ver 0.3 for HMX852xES chipset:
> + * Copyright (c) 2014 Himax Corporation.
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

Please explicitly #include of_device.h.

> +#include <linux/regulator/consumer.h>
> +
> +#define HX852X_COORD_SIZE(fingers)	((fingers) * sizeof(struct hx852x_coord))
> +#define HX852X_WIDTH_SIZE(fingers)	ALIGN(fingers, 4)
> +#define HX852X_BUF_SIZE(fingers)	(HX852X_COORD_SIZE(fingers) + \
> +					 HX852X_WIDTH_SIZE(fingers) + \
> +					 sizeof(struct hx852x_touch_info))
> +
> +#define HX852X_MAX_FINGERS		12

Well, that's a new one :)

> +#define HX852X_MAX_KEY_COUNT		4
> +#define HX852X_MAX_BUF_SIZE		HX852X_BUF_SIZE(HX852X_MAX_FINGERS)
> +
> +#define HX852X_TS_SLEEP_IN		0x80
> +#define HX852X_TS_SLEEP_OUT		0x81
> +#define HX852X_TS_SENSE_OFF		0x82
> +#define HX852X_TS_SENSE_ON		0x83
> +#define HX852X_READ_ONE_EVENT		0x85
> +#define HX852X_READ_ALL_EVENTS		0x86
> +#define HX852X_READ_LATEST_EVENT	0x87
> +#define HX852X_CLEAR_EVENT_STACK	0x88
> +
> +#define HX852X_REG_SRAM_SWITCH		0x8c
> +#define HX852X_REG_SRAM_ADDR		0x8b
> +#define HX852X_REG_FLASH_RPLACE		0x5a
> +
> +#define HX852X_SRAM_SWITCH_TEST_MODE	0x14
> +#define HX852X_SRAM_ADDR_CONFIG		0x7000
> +
> +struct hx852x {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct touchscreen_properties props;
> +
> +	struct gpio_desc *reset_gpiod;
> +	struct regulator_bulk_data supplies[2];
> +
> +	unsigned int max_fingers;
> +	unsigned int keycount;
> +	u32 keycodes[HX852X_MAX_KEY_COUNT];

Nit: might as well make keycodes 'unsigned int' for consistency; I also do not
feel the newlines are necessary.

> +};
> +
> +struct hx852x_config {
> +	u8 rx_num;
> +	u8 tx_num;
> +	u8 max_pt;
> +	u8 padding1[3];
> +	__be16 x_res;
> +	__be16 y_res;
> +	u8 padding2[2];
> +} __packed __aligned(4);

What is the reason to include trailing padding in this packed struct? Does the
controller require the entire register length to be read for some reason?

> +
> +struct hx852x_coord {
> +	__be16 x;
> +	__be16 y;
> +} __packed __aligned(4);
> +
> +struct hx852x_touch_info {
> +	u8 finger_num;
> +	__le16 finger_pressed;

It's interesting that most registers/packets use big endian (e.g. x_res) while
only this uses little endian. Is that expected?

> +	u8 padding;

Same question with regard to trailing padding.

> +} __packed __aligned(4);
> +
> +static int hx852x_i2c_read(struct hx852x *hx, u8 cmd, void *data, u16 len)
> +{
> +	struct i2c_client *client = hx->client;
> +	int ret;
> +
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.len = 1,
> +			.buf = &cmd,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = len,
> +			.buf = data,
> +		}
> +	};
> +
> +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	if (ret != ARRAY_SIZE(msg)) {
> +		dev_err(&client->dev, "failed to read %#x: %d\n", cmd, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

This function does not appear to be doing anything unique (e.g. retry loop to
deal with special HW condition, etc.), so I do not see any reason to open-code
a standard write-then-read operation.

Can i2c_smbus API simply replace this function, or better yet, can this driver
simply use regmap? In fact, that is what the other mainline Himax driver uses.

> +
> +static int hx852x_power_on(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	int error;
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(hx->supplies), hx->supplies);
> +	if (error < 0) {

Nit: if (error) as you have done elsewhere.

> +		dev_err(dev, "failed to enable regulators: %d\n", error);
> +		return error;
> +	}
> +
> +	gpiod_set_value_cansleep(hx->reset_gpiod, 1);
> +	msleep(20);
> +	gpiod_set_value_cansleep(hx->reset_gpiod, 0);
> +	msleep(20);
> +
> +	return 0;
> +}
> +
> +static int hx852x_start(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	int error;
> +
> +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SLEEP_OUT);
> +	if (error) {
> +		dev_err(dev, "failed to send TS_SLEEP_OUT: %d\n", error);
> +		return error;
> +	}
> +	msleep(30);
> +
> +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SENSE_ON);
> +	if (error) {
> +		dev_err(dev, "failed to send TS_SENSE_ON: %d\n", error);
> +		return error;
> +	}
> +	msleep(20);
> +
> +	return 0;
> +}
> +
> +static void hx852x_stop(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	int error;
> +
> +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SENSE_OFF);
> +	if (error)
> +		dev_err(dev, "failed to send TS_SENSE_OFF: %d\n", error);

Granted the function is of void type, should we not still return if there
is an error?

Actually, I would still keep this function as an int for future re-use, even
though hx852x_input_close() simply ignores the value. This way, the return
value can be propagated to the return value of hx852x_suspend() and elsewhere.

> +
> +	msleep(20);
> +
> +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SLEEP_IN);
> +	if (error)
> +		dev_err(dev, "failed to send TS_SLEEP_IN: %d\n", error);

Same here; no need to sleep following a register write that seemingly did
not happen.

> +
> +	msleep(30);
> +}
> +
> +static void hx852x_power_off(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	int error;
> +
> +	error = regulator_bulk_disable(ARRAY_SIZE(hx->supplies), hx->supplies);
> +	if (error)
> +		dev_err(dev, "failed to disable regulators: %d\n", error);
> +}

Same comment with regard to function type; it's nice for internal helpers
to be of type int, even if the core callback using it is void.

> +
> +static int hx852x_read_config(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	struct hx852x_config conf = {0};

No need to initialize.

> +	int x_res, y_res;
> +	int error;
> +
> +	error = hx852x_power_on(hx);
> +	if (error)
> +		return error;
> +
> +	/* Sensing must be turned on briefly to load the config */
> +	error = hx852x_start(hx);
> +	if (error)
> +		goto power_off;
> +
> +	hx852x_stop(hx);

See my earlier comment about promoting this function's type to int.

> +
> +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH,
> +					  HX852X_SRAM_SWITCH_TEST_MODE);
> +	if (error)
> +		goto power_off;
> +
> +	error = i2c_smbus_write_word_data(hx->client, HX852X_REG_SRAM_ADDR,
> +					  HX852X_SRAM_ADDR_CONFIG);
> +	if (error)
> +		goto exit_test_mode;
> +
> +	error = hx852x_i2c_read(hx, HX852X_REG_FLASH_RPLACE, &conf, sizeof(conf));
> +	if (error)
> +		goto exit_test_mode;
> +
> +	x_res = be16_to_cpu(conf.x_res);
> +	y_res = be16_to_cpu(conf.y_res);
> +	hx->max_fingers = (conf.max_pt & 0xf0) >> 4;
> +	dev_dbg(dev, "x res: %d, y res: %d, max fingers: %d\n",
> +		x_res, y_res, hx->max_fingers);
> +
> +	if (hx->max_fingers > HX852X_MAX_FINGERS) {
> +		dev_err(dev, "max supported fingers: %d, found: %d\n",
> +			HX852X_MAX_FINGERS, hx->max_fingers);
> +		error = -EINVAL;
> +		goto exit_test_mode;
> +	}
> +
> +	if (x_res && y_res) {
> +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_X, 0, x_res - 1, 0, 0);
> +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_Y, 0, y_res - 1, 0, 0);
> +	}
> +
> +exit_test_mode:
> +	i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);

Nit: it would still be nice to preserve as many return values as possible, perhaps
as follows:

+exit_test_mode:
	error = i2c_smbus_write_byte_data(...) ? : error;

> +power_off:
> +	hx852x_power_off(hx);
> +	return error;

Similarly, with hx852x_power_off() being promoted to int as suggested above,
this could be:

	return hx852x_power_off(...) ? : error;

There are other idiomatic ways to do the same thing based on your preference.
Another (perhaps more clear) option would be to move some of these test mode
functions into a helper, which would also avoid some goto statements.

> +}
> +
> +static int hx852x_handle_events(struct hx852x *hx)
> +{
> +	/*
> +	 * The event packets have variable size, depending on the amount of
> +	 * supported fingers (hx->max_fingers). They are laid out as follows:
> +	 *  - struct hx852x_coord[hx->max_fingers]: Coordinates for each finger
> +	 *  - u8[ALIGN(hx->max_fingers, 4)]: Touch width for each finger
> +	 *      with padding for 32-bit alignment
> +	 *  - struct hx852x_touch_info
> +	 *
> +	 * Load everything into a 32-bit aligned buffer so the coordinates
> +	 * can be assigned directly, without using get_unaligned_*().
> +	 */
> +	u8 buf[HX852X_MAX_BUF_SIZE] __aligned(4);
> +	struct hx852x_coord *coord = (struct hx852x_coord *)buf;
> +	u8 *width = &buf[HX852X_COORD_SIZE(hx->max_fingers)];
> +	struct hx852x_touch_info *info = (struct hx852x_touch_info *)
> +		&width[HX852X_WIDTH_SIZE(hx->max_fingers)];
> +	unsigned long finger_pressed, key_pressed;

It seems these only need to be u16.

> +	unsigned int i, x, y, w;
> +	int error;
> +
> +	error = hx852x_i2c_read(hx, HX852X_READ_ALL_EVENTS, buf,
> +				HX852X_BUF_SIZE(hx->max_fingers));
> +	if (error)
> +		return error;
> +
> +	finger_pressed = get_unaligned_le16(&info->finger_pressed);
> +	key_pressed = finger_pressed >> HX852X_MAX_FINGERS;
> +
> +	/* All bits are set when no touch is detected */
> +	if (info->finger_num == 0xff || !(info->finger_num & 0x0f))
> +		finger_pressed = 0;
> +	if (key_pressed == 0xf)
> +		key_pressed = 0;
> +
> +	for_each_set_bit(i, &finger_pressed, hx->max_fingers) {
> +		x = be16_to_cpu(coord[i].x);
> +		y = be16_to_cpu(coord[i].y);
> +		w = width[i];
> +
> +		input_mt_slot(hx->input_dev, i);
> +		input_mt_report_slot_state(hx->input_dev, MT_TOOL_FINGER, 1);
> +		touchscreen_report_pos(hx->input_dev, &hx->props, x, y, true);
> +		input_report_abs(hx->input_dev, ABS_MT_TOUCH_MAJOR, w);
> +	}
> +	input_mt_sync_frame(hx->input_dev);
> +
> +	for (i = 0; i < hx->keycount; i++)
> +		input_report_key(hx->input_dev, hx->keycodes[i], key_pressed & BIT(i));
> +
> +	input_sync(hx->input_dev);
> +	return 0;
> +}
> +
> +static irqreturn_t hx852x_interrupt(int irq, void *ptr)
> +{
> +	struct hx852x *hx = ptr;
> +	int error;
> +
> +	error = hx852x_handle_events(hx);
> +	if (error) {
> +		dev_err(&hx->client->dev, "failed to handle events: %d\n", error);
> +		return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hx852x_input_open(struct input_dev *dev)
> +{
> +	struct hx852x *hx = input_get_drvdata(dev);
> +	int error;
> +
> +	error = hx852x_power_on(hx);
> +	if (error)
> +		return error;
> +
> +	error = hx852x_start(hx);
> +	if (error) {
> +		hx852x_power_off(hx);
> +		return error;
> +	}
> +
> +	enable_irq(hx->client->irq);
> +	return 0;
> +}
> +
> +static void hx852x_input_close(struct input_dev *dev)
> +{
> +	struct hx852x *hx = input_get_drvdata(dev);
> +
> +	hx852x_stop(hx);
> +	disable_irq(hx->client->irq);
> +	hx852x_power_off(hx);
> +}
> +
> +static int hx852x_parse_properties(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	int error;
> +
> +	hx->keycount = device_property_count_u32(dev, "linux,keycodes");
> +	if (hx->keycount <= 0) {
> +		hx->keycount = 0;
> +		return 0;
> +	}
> +
> +	if (hx->keycount > HX852X_MAX_KEY_COUNT) {
> +		dev_err(dev, "max supported keys: %d, found: %d\n",

Nit: these should both be printed as %u.

> +			HX852X_MAX_KEY_COUNT, hx->keycount);
> +		return -EINVAL;
> +	}
> +
> +	error = device_property_read_u32_array(dev, "linux,keycodes",
> +					       hx->keycodes, hx->keycount);
> +	if (error)
> +		dev_err(dev, "failed to read linux,keycodes: %d\n", error);
> +
> +	return error;
> +}
> +
> +static int hx852x_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct hx852x *hx;
> +	int error, i;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
> +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
> +		dev_err(dev, "not all i2c functionality supported\n");
> +		return -ENXIO;
> +	}
> +
> +	hx = devm_kzalloc(dev, sizeof(*hx), GFP_KERNEL);
> +	if (!hx)
> +		return -ENOMEM;
> +
> +	hx->client = client;
> +	hx->input_dev = devm_input_allocate_device(dev);
> +	if (!hx->input_dev)
> +		return -ENOMEM;
> +
> +	hx->input_dev->name = "Himax HX852x";
> +	hx->input_dev->id.bustype = BUS_I2C;
> +	hx->input_dev->open = hx852x_input_open;
> +	hx->input_dev->close = hx852x_input_close;
> +
> +	i2c_set_clientdata(client, hx);
> +	input_set_drvdata(hx->input_dev, hx);
> +
> +	hx->supplies[0].supply = "vcca";
> +	hx->supplies[1].supply = "vccd";
> +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(hx->supplies), hx->supplies);
> +	if (error < 0)
> +		return dev_err_probe(dev, error, "failed to get regulators");
> +
> +	hx->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(hx->reset_gpiod))
> +		return dev_err_probe(dev, error, "failed to get reset gpio");

Can the reset GPIO be optional?

> +
> +	error = devm_request_threaded_irq(dev, client->irq, NULL, hx852x_interrupt,
> +					  IRQF_ONESHOT | IRQF_NO_AUTOEN, NULL, hx);
> +	if (error) {
> +		dev_err(dev, "failed to request irq %d: %d\n", client->irq, error);
> +		return error;
> +	}
> +
> +	error = hx852x_read_config(hx);
> +	if (error)
> +		return error;
> +
> +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_Y);
> +	input_set_abs_params(hx->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(hx->input_dev, true, &hx->props);
> +	error = hx852x_parse_properties(hx);
> +	if (error)
> +		return error;
> +
> +	hx->input_dev->keycode = hx->keycodes;
> +	hx->input_dev->keycodemax = hx->keycount;
> +	hx->input_dev->keycodesize = sizeof(hx->keycodes[0]);
> +	for (i = 0; i < hx->keycount; i++)
> +		input_set_capability(hx->input_dev, EV_KEY, hx->keycodes[i]);
> +
> +	error = input_mt_init_slots(hx->input_dev, hx->max_fingers,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error) {
> +		dev_err(dev, "failed to init MT slots: %d\n", error);
> +		return error;
> +	}
> +
> +	error = input_register_device(hx->input_dev);
> +	if (error) {
> +		dev_err(dev, "failed to register input device: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hx852x_suspend(struct device *dev)
> +{
> +	struct hx852x *hx = dev_get_drvdata(dev);
> +
> +	mutex_lock(&hx->input_dev->mutex);
> +	if (input_device_enabled(hx->input_dev))
> +		hx852x_stop(hx);
> +	mutex_unlock(&hx->input_dev->mutex);
> +
> +	return 0;
> +}
> +
> +static int hx852x_resume(struct device *dev)
> +{
> +	struct hx852x *hx = dev_get_drvdata(dev);
> +	int error = 0;
> +
> +	mutex_lock(&hx->input_dev->mutex);
> +	if (input_device_enabled(hx->input_dev))
> +		error = hx852x_start(hx);
> +	mutex_unlock(&hx->input_dev->mutex);
> +
> +	return error;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(hx852x_pm_ops, hx852x_suspend, hx852x_resume);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id hx852x_of_match[] = {
> +	{ .compatible = "himax,hx852es" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hx852x_of_match);
> +#endif
> +
> +static struct i2c_driver hx852x_driver = {
> +	.probe = hx852x_probe,
> +	.driver = {
> +		.name = "himax_hx852x",
> +		.pm = pm_sleep_ptr(&hx852x_pm_ops),
> +		.of_match_table = of_match_ptr(hx852x_of_match),
> +	},
> +};
> +module_i2c_driver(hx852x_driver);
> +
> +MODULE_DESCRIPTION("Himax HX852x(ES) Touchscreen Driver");
> +MODULE_AUTHOR("Jonathan Albrieux <jonathan.albrieux@gmail.com>");
> +MODULE_AUTHOR("Stephan Gerhold <stephan@gerhold.net>");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.42.0
> 

Kind regards,
Jeff LaBundy
