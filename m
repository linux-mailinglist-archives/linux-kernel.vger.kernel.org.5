Return-Path: <linux-kernel+bounces-12934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9BE81FCDF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA8AB21E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2EB63D4;
	Fri, 29 Dec 2023 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="ze9lEk33"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29459612A;
	Fri, 29 Dec 2023 03:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VstS91Y0mVQ0A3HBrl0IGYpSFlvJ0c9h9rEG1Gnp6TvjmIVjk81NH0uFxpt8yQOXmSBj6pgTjOCDBjD9MZWuse9WzFf49xJJ/4nJhRZJSNDbdzv7Ltm6Llo9wlF3ycAswy7H6uZYnbCjukcAsgRSHL0KNR8fPkGtJodXgyfb+kQLwz5GbQLzgnJwfrHB/sRxtvfw0wOCnFvKU3V0minTEbYzv8tdTRQCdgXv87uDa0QzYcjw+wKBOJSfSNCSS70pyV/h1le9LTXX4I76FEfnAbxj3rOFiK0bBywIZ9uqx7Vw2UmmvX1SwjjLyEsWpBtaIZAohDNfG+hmllFeeOtYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r06a9FkapPm3K+WWs/lqr7nSXZ7t/g+KBs+sNAWm+mM=;
 b=A4bFIOFVbMzlzO47Tbo9LC2VI1AUqV18jFacAogeY+ioSpUZH6heQCa4XEdMdscsjSZBWOYV1Alj+RgProc0myTpY425Hrc+uGMjfjZ31HB1jdzVGpDbJuSEDMAi1xP/FQJ6v+ZJgcMXQkNRQxnIpnd7ze89ymG08Jhwx8bKHD0/OenDhbzMBAypfls+jICZuibwEkNquvUu+HNnoJFwhlrd2wBJ6T0SdMuhMnYSreWipCA6PJs9X70yO1UvvTON6Pidd6Lvy2/C1sqjBS+62EjVXCYwmjUTraC5LHqiPJmtNIPmJjjRn1XDnNi2BUOY5NMBtspOlzJImZl+hililg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r06a9FkapPm3K+WWs/lqr7nSXZ7t/g+KBs+sNAWm+mM=;
 b=ze9lEk33jabIuiQCEk4b988005E9GoOavrn9wbkyLN4J1XTRbKO6bCQiRgDhHBb44soukpn20+KZQx7S/lZqVb+YlTaaOxbhjQZO/nYogJaRarGeMunUHQHaXxQrp/4PGaUHsHSu2/mHbj3uGXWP5SRvLqp3rH0n1017mrJK1vU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ2PR08MB8403.namprd08.prod.outlook.com
 (2603:10b6:a03:4af::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Fri, 29 Dec
 2023 03:44:38 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7159.006; Fri, 29 Dec 2023
 03:44:37 +0000
Date: Thu, 28 Dec 2023 21:44:31 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
	hannah.rossiter@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v5 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <ZY5An58Rffrcpfpn@nixie71>
References: <20231211121430.1689139-1-kamel.bouhara@bootlin.com>
 <20231211121430.1689139-4-kamel.bouhara@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211121430.1689139-4-kamel.bouhara@bootlin.com>
X-ClientProxiedBy: SN7PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:806:f2::29) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ2PR08MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8cc792-51eb-4185-7d73-08dc08207ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a2VmSnuOVvnpQqkt16SNJemGtRguSFgDJnPiy4pK2n3jycwceb/qgkUiufk7GsHUtZMoZSyDEGZNM12Eze1o8eC1WzmT6yTVb/ubo0nojk4JPgiY6IIlbEgdDeg54HHaAEYFyAyLP4yQCopnNAntnK34koYsxko2fLpLItWA/JI0nc/Afg2FIMKsKXYCu9o+IbKbAygQEIR96IDGzRDS/qkXQoMmRFrDtC+Cf0rUe572QMMOVBuFnH+oiffwTkco9T549Digul4QGVezRbz46OstzAfccEIIToXfTnzEoRDiOGBZUWL0zCNPHwoe/kndOgZl3cwqJM+pVFIwZNv5CF7Htlb1sQc3ptyrxIJmKP8eiFP9LgkQK3BZGJ9bRwauHh52wBmFVoeZWgd1e+aCxkJgLCjNLCGX83fn9L7mC/QwK9Ab4hk8dYeH8H7hahK1eAYX0xqHzOnrfVQSmHDiFjrzhLQuk0IATeYESPbq66LQL96yFDt0h436MeHZ6o7duBLI2nzJLy/176+EI28tFy01szQKfrk6gIUw0Syk3Rdjhzc4lynblLQV3EtiLX3A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(376002)(136003)(39830400003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(33716001)(6916009)(66476007)(66556008)(9686003)(6506007)(6666004)(6512007)(6486002)(8676002)(86362001)(66946007)(478600001)(4326008)(8936002)(54906003)(316002)(26005)(83380400001)(5660300002)(38100700002)(2906002)(41300700001)(30864003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eF3r/7Xzk/EB840ptQpdpJBPgo3rZIsS6TTNwou8o+wxqO0E+AUwfvPIeMCA?=
 =?us-ascii?Q?WrE34+GvNJTYiwZn98t6VW935SZu9is/iOXWNgTWykUxD/HIS10kwFIY/zK8?=
 =?us-ascii?Q?TvJiObqQBmASdz19g8udobX/UmRAX0z9qzv8Vv/QvM3lCez8zHb77sjhSIJv?=
 =?us-ascii?Q?yTWPpgKa+Lhckgk2tPzHoiGQsQ8TOJTQUBENN7ZpgXTcdwkg5e8ehhpyBPo+?=
 =?us-ascii?Q?fwksay9u5i90YpwjGLrkJhiViWYaJB/lmRHyIE0t2YWAZTJ2I+9X/XRfeQI5?=
 =?us-ascii?Q?diffjMfI7ZA6eZubNsbmKK6fnSA/Cjbcnztq3W1z44LtM9PJklEcXvW57igU?=
 =?us-ascii?Q?mrGiYU3+kPTsUGxJAtFKH19AOQApreJVnatSf4looreTaqx8TCWXpnQE2qMA?=
 =?us-ascii?Q?PVCPYUP5e0hKeJqX4zh9dRXhHqztu6Af+aGSL/hQ9cCW8I/e0f1xgZ5pl9qw?=
 =?us-ascii?Q?gB5EeevbNBGvOepIbWRZIJU4YVPHyQxQy93D9tDwhjwMZM+HnUB9K86RHZCR?=
 =?us-ascii?Q?dN3I+chXBNdpqFvxagIOKSNUtuqIwLIQ1BRpVzFBp4Gyd+l09h+qv01ZgYSU?=
 =?us-ascii?Q?f8o7lxAslTbuDYlRDJT4dvxZ+ASSkxKktrFJpNSYkuL/lTrsd3GsuIAJRktd?=
 =?us-ascii?Q?Q24TTsB0EGgiXExct2EFc6T9DIqoIKv6wQxl+7YgqLu61B7iPM2y/Ut1kOy/?=
 =?us-ascii?Q?eTojNUH4FKHfQT6BsXbx8nVNqW9cJ6C7m5PkjYfhmD3/DMwlvEKz9pt+7ixj?=
 =?us-ascii?Q?wbG8nVju7qWGKqQFi0p4omE8mf5+eG2WCQc1r5k18d2JtD+i0zJSBm6qu7Nr?=
 =?us-ascii?Q?F+0EhkIxs0xRCklRON3Uk0gMwhFfcO5lOKHguq612ffrA6uwYWq2WGQwC86l?=
 =?us-ascii?Q?7m9G0mwWKM0yjhaGkzFmQMx+lkbrSHRoZsN1e6Y27JXr8THzYmniZ/+2ufbS?=
 =?us-ascii?Q?DFO/RKjHEt+dfCjY5+b2CNFyASgC/xJEXI5e2xX8I18TF0rHDmYbk6p8/ben?=
 =?us-ascii?Q?BrovrEIqF8zTXgLtJoeVi1DxX72vp69Ro/VPh19XugTweYDS2HrkfNRJitKv?=
 =?us-ascii?Q?ZL+Tu+e38hCjrL8IRPUg1Va3h/UAa8NiSdymn11I8JDmW+BQNf+9Pwm11Tc+?=
 =?us-ascii?Q?wddkhgXH42ebaVEiWLJ/02rrtwj+3ed7dUQuTpY6OxL5ycqtrj1crVFCpm0y?=
 =?us-ascii?Q?578UDEcmz8I/PlxQk/LYC8Em59iT3dDyYSoKu9PF5xeXDA8oZLS9BeWEvzo8?=
 =?us-ascii?Q?cXUWRhwKH/lJ1BwKY9Dqr4/ZCP+QVTwjGgPNVofraHCJ6ZJ9e8V9hxEwU7rf?=
 =?us-ascii?Q?2YTAepO65W1NaM9SEsmuJtLd5e7XL2FVTiMiJix6VQC/IEJywXAYH9fWWeQH?=
 =?us-ascii?Q?UtAaegp1xxWd7nHLVA4ML2eEn9wYBfOdUhJqdVUPK1do9oeyI+n85Lq+N8Oo?=
 =?us-ascii?Q?uP+TbpUsUz+YXU3G07L3DNkLw48szNsSNvsom4Jy37AiUwYBUWVVW6WpSw3y?=
 =?us-ascii?Q?vOs6EYkhwYi02l3i+RbHKUCsMs38rkdrbp0yxt7zWudJV0yIDvagc9WVbmrT?=
 =?us-ascii?Q?XeV9PvnznraVbnK5GZ21iWhsiL5E2ALUf8bTk6eH?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8cc792-51eb-4185-7d73-08dc08207ad7
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 03:44:37.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej/gtnYa5hNgP26NiamgXyk5Y9MjS4UBvZe/15mZW6jez9NAbkG08gPLiGi8bpZRpJCZEO2Bu9jlvyTBgJ01zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR08MB8403

Hi Kamel,

On Mon, Dec 11, 2023 at 01:14:29PM +0100, Kamel Bouhara wrote:
> Add a new driver for the TouchNetix's axiom family of
> touchscreen controllers. This driver only supports i2c
> and can be later adapted for SPI and USB support.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  MAINTAINERS                                  |   1 +
>  drivers/input/touchscreen/Kconfig            |  12 +
>  drivers/input/touchscreen/Makefile           |   1 +
>  drivers/input/touchscreen/touchnetix_axiom.c | 667 +++++++++++++++++++
>  4 files changed, 681 insertions(+)
>  create mode 100644 drivers/input/touchscreen/touchnetix_axiom.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4752d8436dbb..337ddac6c74b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21436,6 +21436,7 @@ M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
>  L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
> +F:	drivers/input/touchscreen/touchnetix_axiom.c
>  
>  THUNDERBOLT DMA TRAFFIC TEST DRIVER
>  M:	Isaac Hazan <isaac.hazan@intel.com>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index e3e2324547b9..f36bee8d8696 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -803,6 +803,18 @@ config TOUCHSCREEN_MIGOR
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called migor_ts.
>  
> +config TOUCHSCREEN_TOUCHNETIX_AXIOM
> +	tristate "TouchNetix AXIOM based touchscreen controllers"
> +	depends on I2C
> +	help
> +	  Say Y here if you have a axiom touchscreen connected to
> +	  your system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called axiom.
> +
>  config TOUCHSCREEN_TOUCHRIGHT
>  	tristate "Touchright serial touchscreen"
>  	select SERIO
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 62bd24f3ac8e..8e32a2df5e18 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_TOUCHSCREEN_SUR40)		+= sur40.o
>  obj-$(CONFIG_TOUCHSCREEN_SURFACE3_SPI)	+= surface3_spi.o
>  obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)	+= ti_am335x_tsc.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
> +obj-$(CONFIG_TOUCHSCREEN_TOUCHNETIX_AXIOM)	+= touchnetix_axiom.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
>  obj-$(CONFIG_TOUCHSCREEN_TS4800)	+= ts4800-ts.o
> diff --git a/drivers/input/touchscreen/touchnetix_axiom.c b/drivers/input/touchscreen/touchnetix_axiom.c
> new file mode 100644
> index 000000000000..4ade2d1adba0
> --- /dev/null
> +++ b/drivers/input/touchscreen/touchnetix_axiom.c
> @@ -0,0 +1,667 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * TouchNetix axiom Touchscreen Driver
> + *
> + * Copyright (C) 2020-2023 TouchNetix Ltd.
> + *
> + * Author(s): Bart Prescott <bartp@baasheep.co.uk>
> + *            Pedro Torruella <pedro.torruella@touchnetix.com>
> + *            Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
> + *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
> + *            Kamel Bouhara <kamel.bouhara@bootlin.com>
> + *
> + */
> +#include <linux/bitfield.h>
> +#include <linux/crc16.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

As I mention in the v3 review, the entire of.h is not necessary in the
case of this driver; mod_devicetable.h is sufficient. Please see:

dbce1a7d5dce ("Input: Explicitly include correct DT includes")

> +
> +#define AXIOM_PROX_LEVEL		-128
> +/*
> + * Register group u31 has 2 pages for usage table entries.
> + */
> +#define AXIOM_U31_MAX_USAGES		((2 * AXIOM_COMMS_PAGE_SIZE) / AXIOM_U31_BYTES_PER_USAGE)
> +#define AXIOM_U31_BYTES_PER_USAGE	6
> +#define AXIOM_U31_PAGE0_LENGTH		0x0C
> +#define AXIOM_U31_BOOTMODE_MASK		BIT(7)
> +#define AXIOM_U31_DEVID_MASK		GENMASK(14, 0)
> +
> +#define AXIOM_CMD_HEADER_READ_MASK	BIT(15)
> +#define AXIOM_U41_MAX_TARGETS		10
> +
> +#define AXIOM_U46_AUX_CHANNELS		4
> +#define AXIOM_U46_AUX_MASK		GENMASK(11, 0)
> +
> +#define AXIOM_COMMS_MAX_USAGE_PAGES	3
> +#define AXIOM_COMMS_PAGE_SIZE		256
> +#define AXIOM_COMMS_REPORT_LEN_MASK	GENMASK(6, 0)
> +
> +#define AXIOM_REPORT_USAGE_ID		0x34
> +#define AXIOM_DEVINFO_USAGE_ID		0x31
> +#define AXIOM_USAGE_2HB_REPORT_ID	0x01
> +#define AXIOM_USAGE_2AUX_REPORT_ID	0x46
> +#define AXIOM_USAGE_2DCTS_REPORT_ID	0x41
> +
> +#define AXIOM_PAGE_OFFSET_MASK		GENMASK(6, 0)
> +
> +struct axiom_devinfo {
> +	u16 device_id;

Assuming this is a packed struct into which data is directly read over
I2C, this member needs declared as __be16 or __le16 depending on the
endianness of the device, and then all accesses to it resolved using
be16_to_cpu() or le16_to_cpu().

> +	u8 fw_minor;
> +	u8 fw_major;
> +	u8 fw_info_extra;
> +	u8 tcp_revision;
> +	u8 bootloader_fw_minor;
> +	u8 bootloader_fw_major;
> +	u16 jedec_id;

And here.

> +	u8 num_usages;
> +} __packed;
> +
> +/*
> + * Describes parameters of a specific usage, essentially a single element of
> + * the "Usage Table"
> + */
> +struct axiom_usage_entry {
> +	u8 id;
> +	u8 is_report;
> +	u8 start_page;
> +	u8 num_pages;
> +};
> +
> +/*
> + * Represents state of a touch or target when detected prior a touch (eg.
> + * hover or proximity events).
> + */

Nit: prior to a touch

> +enum axiom_target_state {
> +	AXIOM_TARGET_STATE_NOT_PRESENT = 0,
> +	AXIOM_TARGET_STATE_PROX = 1,
> +	AXIOM_TARGET_STATE_HOVER = 2,
> +	AXIOM_TARGET_STATE_TOUCHING = 3,
> +};
> +
> +struct axiom_u41_target {
> +	enum axiom_target_state state;
> +	u16 x;
> +	u16 y;
> +	s8 z;
> +	bool insert;
> +	bool touch;
> +};
> +
> +struct axiom_target_report {
> +	u8 index;
> +	u8 present;
> +	u16 x;
> +	u16 y;
> +	s8 z;
> +};
> +
> +struct axiom_cmd_header {
> +	__le16 target_address;
> +	__le16 length;
> +} __packed;
> +
> +struct axiom_data {
> +	struct axiom_devinfo devinfo;
> +	struct device *dev;
> +	struct gpio_desc *reset_gpio;
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	u32 max_report_len;
> +	char rx_buf[AXIOM_COMMS_MAX_USAGE_PAGES * AXIOM_COMMS_PAGE_SIZE];

Please use standard kernel type definitions (e.g. u8).

> +	struct axiom_u41_target targets[AXIOM_U41_MAX_TARGETS];
> +	struct axiom_usage_entry usage_table[AXIOM_U31_MAX_USAGES];
> +	bool usage_table_populated;
> +	struct regulator *vdda;
> +	struct regulator *vddi;
> +};
> +
> +/*
> + * axiom devices are typically configured to report
> + * touches at a rate of 100Hz (10ms). For systems
> + * that require polling for reports.

It's not entirely clear what this is saying; is the first period meant to be
replaced with a comma? It's also odd to see some comments limited to half the
column width of others. Please make another pass through these to give the
commentary a consistent voice.

> + * When reports are polled, it will be expected to
> + * occasionally observe the overflow bit being set
> + * in the reports. This indicates that reports are not
> + * being read fast enough.
> + */
> +#define POLL_INTERVAL_DEFAULT_MS 10
> +
> +/* Translate usage/page/offset triplet into physical address. */
> +static u16 axiom_usage_to_target_address(struct axiom_data *ts, char usage, char page,
> +					 char offset)
> +{
> +	u32 i;

It's more common in kernel code for iterators to be declared as 'int' than
u32, even if they're only used as unsigned integers in this case.

> +
> +	/* At the moment the convention is that u31 is always at physical address 0x0 */
> +	if (!ts->usage_table_populated) {
> +		if (usage == AXIOM_DEVINFO_USAGE_ID)
> +			return ((page << 8) + offset);
> +		else
> +			return 0xffff;
> +	}
> +
> +	for (i = 0; i < ts->devinfo.num_usages; i++) {
> +		if (ts->usage_table[i].id != usage)
> +			continue;
> +
> +		if (page >= ts->usage_table[i].num_pages) {
> +			dev_err(ts->dev, "Invalid usage table! usage: %u, page: %u, offset: %u\n",
> +				usage, page, offset);
> +			return 0xffff;
> +		}
> +		break;
> +	}
> +
> +	return ((ts->usage_table[i].start_page + page) << 8) + offset;
> +}
> +
> +static int axiom_i2c_read(struct i2c_client *client, u8 usage, u8 page, u8 *buf, u16 len)
> +{
> +	struct axiom_data *ts = i2c_get_clientdata(client);
> +	struct axiom_cmd_header cmd_header;
> +	struct i2c_msg msg[2];
> +	int error;
> +
> +	cmd_header.target_address = cpu_to_le16(axiom_usage_to_target_address(ts, usage, page, 0));
> +	cmd_header.length = cpu_to_le16(len | AXIOM_CMD_HEADER_READ_MASK);
> +
> +	msg[0].addr = client->addr;
> +	msg[0].flags = 0;
> +	msg[0].len = sizeof(cmd_header);
> +	msg[0].buf = (u8 *)&cmd_header;
> +
> +	msg[1].addr = client->addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].len = len;
> +	msg[1].buf = (char *)buf;

My comment here from v3 seems to have been missed; please check it.

> +
> +	error = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	if (error != ARRAY_SIZE(msg)) {
> +		dev_err(&client->dev,
> +			"Failed reading usage %#x page %#x, error=%d\n",
> +			usage, page, error);
> +		return -EIO;
> +	}

As I mention in the v3 review, you should preserve the original error code
in case of a negative return value instead of returning -EIO in all cases.
Please check my original comment.

I also recommend you call this 'ret' and not 'error', because a non-zero
return value (2) actually indicates success. In the input subsystem at least,
'error' is typically used for return values that can only be zero or negative.

> +
> +	usleep_range(250, 300);
> +
> +	return 0;
> +}

During the v3 review, I suggested you use regmap, since SPI support may come
later. You can override both I2C and SPI callbacks with your own in case the
hardware requires it. What was the reason not to use regmap now, and minimize
rip-up later?

> +
> +/*
> + * One of the main purposes for reading the usage table is to identify
> + * which usages reside at which target address.
> + * When performing subsequent reads or writes to AXIOM, the target address
> + * is used to specify which usage is being accessed.
> + * Consider the following discovery code which will build up the usage table.
> + */
> +static u32 axiom_populate_usage_table(struct axiom_data *ts)
> +{
> +	struct axiom_usage_entry *usage_table;
> +	u32 max_report_len = 0;
> +	char *rx_data = ts->rx_buf;

Please use u8 here.

> +	u32 usage_id;
> +	int error;
> +
> +	usage_table = ts->usage_table;
> +
> +	/* Read the second page of usage u31 to get the usage table */
> +	error = axiom_i2c_read(ts->client, AXIOM_DEVINFO_USAGE_ID, 1, rx_data,
> +			       (AXIOM_U31_BYTES_PER_USAGE * ts->devinfo.num_usages));
> +	if (error)
> +		return error;
> +
> +	for (usage_id = 0; usage_id < ts->devinfo.num_usages; usage_id++) {
> +		u16 offset = (usage_id * AXIOM_U31_BYTES_PER_USAGE);
> +		u8 id = rx_data[offset + 0];
> +		u8 start_page = rx_data[offset + 1];
> +		u8 num_pages = rx_data[offset + 2];
> +		u32 max_offset = ((rx_data[offset + 3] & AXIOM_PAGE_OFFSET_MASK) + 1) * 2;
> +
> +		if (!num_pages)
> +			usage_table[usage_id].is_report = true;
> +
> +		/* Store the entry into the usage table */
> +		usage_table[usage_id].id = id;
> +		usage_table[usage_id].start_page = start_page;
> +		usage_table[usage_id].num_pages = num_pages;
> +
> +		dev_dbg(ts->dev, "Usage u%02x Info: %*ph\n", id,
> +			AXIOM_U31_BYTES_PER_USAGE, &rx_data[offset]);
> +
> +		/* Identify the max report length the module will receive */
> +		if (usage_table[usage_id].is_report && max_offset > max_report_len)
> +			max_report_len = max_offset;
> +	}
> +
> +	ts->usage_table_populated = true;
> +
> +	return max_report_len;
> +}
> +
> +static int axiom_discover(struct axiom_data *ts)
> +{
> +	int error;
> +
> +	/*
> +	 * Fetch the first page of usage u31 to get the
> +	 * device information and the number of usages
> +	 */
> +	error = axiom_i2c_read(ts->client, AXIOM_DEVINFO_USAGE_ID, 0, (char *)&ts->devinfo,
> +			       AXIOM_U31_PAGE0_LENGTH);

If you're set on using bespoke I2C helpers instead of regmap, then 'buf'
should be defined as a void * as opposed to casting outside of axiom_i2c_read().

> +	if (error)
> +		return error;
> +
> +	dev_dbg(ts->dev, "  Boot Mode      : %s\n",
> +		FIELD_GET(AXIOM_U31_BOOTMODE_MASK, ts->devinfo.device_id) ? "BLP" : "TCP");
> +	dev_dbg(ts->dev, "  Device ID      : %04lx\n",
> +		FIELD_GET(AXIOM_U31_DEVID_MASK,	ts->devinfo.device_id));
> +	dev_dbg(ts->dev, "  Firmware Rev   : %02x.%02x\n", ts->devinfo.fw_major,
> +		ts->devinfo.fw_minor);
> +	dev_dbg(ts->dev, "  Bootloader Rev : %02x.%02x\n", ts->devinfo.bootloader_fw_major,
> +		ts->devinfo.bootloader_fw_minor);
> +	dev_dbg(ts->dev, "  FW Extra Info  : %04x\n", ts->devinfo.fw_info_extra);
> +	dev_dbg(ts->dev, "  Silicon        : %04x\n", ts->devinfo.jedec_id);
> +	dev_dbg(ts->dev, "  Number usages        : %04x\n", ts->devinfo.num_usages);
> +
> +	ts->max_report_len = axiom_populate_usage_table(ts);
> +	if (!ts->max_report_len || !ts->devinfo.num_usages)

This seems worthy of a dev_err(), otherwise the customer has no way to
know something is wrong with the controller's FW.

> +		return -EINVAL;
> +
> +	dev_dbg(ts->dev, "Max Report Length: %u\n", ts->max_report_len);
> +
> +	return 0;
> +}
> +
> +/*
> + * Support function to axiom_process_u41_report.
> + * Generates input-subsystem events for every target.
> + * After calling this function the caller shall issue
> + * a Sync to the input sub-system.
> + */
> +static bool axiom_process_u41_report_target(struct axiom_data *ts,
> +					    struct axiom_target_report *target)
> +{
> +	struct input_dev *input_dev = ts->input_dev;
> +	struct axiom_u41_target *target_prev_state;
> +	enum axiom_target_state current_state;
> +	bool update = false;
> +	int slot;
> +
> +	/* Verify the target index */
> +	if (target->index >= AXIOM_U41_MAX_TARGETS) {
> +		dev_dbg(ts->dev, "Invalid target index! %u\n", target->index);

Should this be dev_err()?

> +		return false;
> +	}
> +
> +	target_prev_state = &ts->targets[target->index];
> +
> +	current_state = AXIOM_TARGET_STATE_NOT_PRESENT;
> +
> +	if (target->present) {
> +		if (target->z >= 0)
> +			current_state = AXIOM_TARGET_STATE_TOUCHING;
> +		else if (target->z > AXIOM_PROX_LEVEL && target->z < 0)
> +			current_state = AXIOM_TARGET_STATE_HOVER;
> +		else if (target->z == AXIOM_PROX_LEVEL)
> +			current_state = AXIOM_TARGET_STATE_PROX;
> +	}
> +
> +	if (target_prev_state->state == current_state &&
> +	    target_prev_state->x == target->x &&
> +	    target_prev_state->y == target->y &&
> +	    target_prev_state->z == target->z) {
> +		return false;
> +	}

No need for curly braces here; please refer to the kernel style guidelines.

> +
> +	slot = target->index;
> +
> +	dev_dbg(ts->dev, "U41 Target T%u, slot:%u present:%u, x:%u, y:%u, z:%d\n",
> +		target->index, slot, target->present,
> +		target->x, target->y, target->z);
> +
> +	switch (current_state) {
> +	case AXIOM_TARGET_STATE_NOT_PRESENT:
> +	case AXIOM_TARGET_STATE_PROX:
> +		if (!target_prev_state->insert)
> +			break;
> +		update = true;
> +		target_prev_state->insert = false;
> +		input_mt_slot(input_dev, slot);
> +
> +		if (!slot)
> +			input_report_key(input_dev, BTN_TOUCH, 0);
> +
> +		input_mt_report_slot_inactive(input_dev);
> +		/*
> +		 * make sure the previous coordinates are
> +		 * all off screen when the finger comes back
> +		 */
> +		target->x = 65535;
> +		target->y = 65535;
> +		target->z = AXIOM_PROX_LEVEL;
> +		break;
> +	case AXIOM_TARGET_STATE_HOVER:
> +	case AXIOM_TARGET_STATE_TOUCHING:
> +		target_prev_state->insert = true;
> +		update = true;
> +		input_mt_slot(input_dev, slot);
> +		input_report_abs(input_dev, ABS_MT_TRACKING_ID, slot);
> +		input_report_abs(input_dev, ABS_MT_POSITION_X, target->x);
> +		input_report_abs(input_dev, ABS_X, target->x);

You do not need to explicitly report ABS_X and ABS_Y values, as calling
input_mt_sync_frame() effectively takes care of this by way of pointer
emulation.

> +		input_report_abs(input_dev, ABS_MT_POSITION_Y, target->y);
> +		input_report_abs(input_dev, ABS_Y, target->y);
> +
> +		if (current_state == AXIOM_TARGET_STATE_TOUCHING) {
> +			input_report_abs(input_dev, ABS_MT_DISTANCE, 0);
> +			input_report_abs(input_dev, ABS_DISTANCE, 0);
> +			input_report_abs(input_dev, ABS_MT_PRESSURE, target->z);
> +			input_report_abs(input_dev, ABS_PRESSURE, target->z);
> +		} else {
> +			input_report_abs(input_dev, ABS_MT_DISTANCE, -target->z);
> +			input_report_abs(input_dev, ABS_DISTANCE, -target->z);
> +			input_report_abs(input_dev, ABS_MT_PRESSURE, 0);
> +			input_report_abs(input_dev, ABS_PRESSURE, 0);
> +		}
> +
> +		if (!slot)
> +			input_report_key(input_dev, BTN_TOUCH, (current_state ==
> +					 AXIOM_TARGET_STATE_TOUCHING));
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	target_prev_state->state = current_state;
> +	target_prev_state->x = target->x;
> +	target_prev_state->y = target->y;
> +	target_prev_state->z = target->z;
> +
> +	return update;
> +}

I appreciate that some clean-up was done here, but it still seems you can
get rid of the 'update' flag. Can you not re-shuffle this a bit so that
you return true at the bottom of the function, and simply return false
early for the few cases where there is no update?

> +
> +/*
> + * U41 is the output report of the 2D CTS and contains the status of targets
> + * (including contacts and pre-contacts) along with their X,Y,Z values.
> + * When a target has been removed (no longer detected),
> + * the corresponding X,Y,Z values will be zeroed.
> + */
> +static bool axiom_process_u41_report(struct axiom_data *ts, char *rx_buf)
> +{
> +	struct axiom_target_report target;
> +	bool update_done = false;
> +	u16 target_status;
> +	u32 i;
> +
> +	target_status = ((rx_buf[1]) | (rx_buf[2] << 8));

Please use get_unaligned_le16() instead of open-coding this math.

> +
> +	for (i = 0; i < AXIOM_U41_MAX_TARGETS; i++) {
> +		char target_step = i * 4;

Please use u8 here.

> +
> +		target.index = i;
> +		target.present = ((target_status & (1 << i)) != 0) ? 1 : 0;
> +		target.x = (rx_buf[(target_step + 3)] | (rx_buf[target_step + 4] << 8));
> +		target.y = (rx_buf[(target_step + 5)] | (rx_buf[target_step + 6] << 8));
> +		target.z = (s8)(rx_buf[i + 43]);
> +		update_done |= axiom_process_u41_report_target(ts, &target);
> +	}
> +
> +	return update_done;
> +}
> +
> +/*
> + * U46 report contains a low level measurement data generated by the CDS
> + * algorithms from the AUX channels. This information is useful when tuning
> + * multi-press to assess mechanical consistency in the unit's construction.
> + */

What does CDS stand for, and what in user space is interested in these
events? I'm guessing some kind of production-line calibration tool? I
appreciate the additional comments in this revision; please add a bit
more here.

> +static void axiom_process_u46_report(struct axiom_data *ts, char *rx_buf)
> +{
> +	struct input_dev *input_dev = ts->input_dev;
> +	u32 event_value;
> +	u16 aux_value;
> +	u32 i = 0;

There is no need to initialize this iterator.

> +
> +	for (i = 0; i < AXIOM_U46_AUX_CHANNELS; i++) {
> +		char target_step = i * 2;
> +
> +		aux_value = ((rx_buf[target_step + 2] << 8) | (rx_buf[target_step + 1]))
> +			     & AXIOM_U46_AUX_MASK;

This looks like another opportunity to use get_unaligned_le16().

> +		event_value = (i << 16) | (aux_value);
> +		input_event(input_dev, EV_MSC, MSC_RAW, event_value);
> +	}
> +}
> +
> +/*
> + * Validates the crc and demultiplexes the axiom reports to the appropriate
> + * report handler
> + */
> +static int axiom_handle_events(struct axiom_data *ts)
> +{
> +	struct input_dev *input_dev = ts->input_dev;
> +	char *report_data = ts->rx_buf;

Please use u8 here.

> +	struct device *dev = ts->dev;
> +	u16 crc_report;
> +	u16 crc_calc;
> +	int error;
> +	char len;

And here.

> +
> +	error = axiom_i2c_read(ts->client, AXIOM_REPORT_USAGE_ID, 0, report_data,
> +			       ts->max_report_len);
> +	if (error)
> +		return error;
> +
> +	len = (report_data[0] & AXIOM_COMMS_REPORT_LEN_MASK) << 1;
> +	if (!len) {
> +		dev_err(dev, "Zero length report discarded.\n");
> +		return -ENODATA;
> +	}

Since you're expecting at least two bytes to get a CRC, it seems you should
check that len >= 2 instead of > 0, otherwise 'len - 2' below will panic.

> +
> +	/* Validate the report CRC */
> +	crc_report = (report_data[len - 1] << 8) | (report_data[len - 2]);

We can use get_unaligned_le16() here too.

> +	/* Length is in 16 bit words and remove the size of the CRC16 itself */
> +	crc_calc = crc16(0, report_data, (len - 2));
> +
> +	if (crc_calc != crc_report) {
> +		dev_err(dev,
> +			"CRC mismatch! Expected: %#x, Calculated CRC: %#x.\n",
> +			crc_report, crc_calc);
> +		return -EINVAL;
> +	}
> +
> +	switch (report_data[1]) {
> +	case AXIOM_USAGE_2DCTS_REPORT_ID:
> +		if (axiom_process_u41_report(ts, &report_data[1])) {
> +			input_mt_sync_frame(input_dev);
> +			input_sync(input_dev);
> +		}
> +		break;
> +
> +	case AXIOM_USAGE_2AUX_REPORT_ID:
> +		/* This is an aux report (force) */
> +		axiom_process_u46_report(ts, &report_data[1]);
> +		input_mt_sync(input_dev);

This call to input_mt_sync() seems unnecessary; we are not touching any MT
slots in this case.

> +		input_sync(input_dev);
> +		break;
> +
> +	case AXIOM_USAGE_2HB_REPORT_ID:
> +		/* This is a heartbeat report */
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void axiom_i2c_poll(struct input_dev *input_dev)
> +{
> +	struct axiom_data *ts = input_get_drvdata(input_dev);
> +
> +	axiom_handle_events(ts);
> +}
> +
> +static irqreturn_t axiom_irq(int irq, void *dev_id)
> +{
> +	struct axiom_data *ts = dev_id;
> +
> +	axiom_handle_events(ts);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void axiom_reset(struct gpio_desc *reset_gpio)
> +{
> +	gpiod_set_value_cansleep(reset_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(reset_gpio, 0);
> +	msleep(110);
> +}
> +
> +static int axiom_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct input_dev *input_dev;
> +	struct axiom_data *ts;
> +	u32 startup_delay_ms;
> +	u32 poll_interval;
> +	int target;
> +	int error;
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->client = client;
> +	i2c_set_clientdata(client, ts);
> +	ts->dev = dev;
> +
> +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ts->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio), "failed to get reset GPIO\n");
> +
> +	if (ts->reset_gpio)
> +		axiom_reset(ts->reset_gpio);
> +
> +	ts->vddi = devm_regulator_get_optional(dev, "VDDI");

I don't think there is any rule against doing so, but I have never seen any
customers name a regulator in all caps.

> +	if (!IS_ERR(ts->vddi)) {
> +		error = regulator_enable(ts->vddi);
> +		if (error)
> +			return dev_err_probe(&client->dev, error,
> +					     "Failed to enable VDDI regulator\n");
> +	}
> +
> +	ts->vdda = devm_regulator_get_optional(dev, "VDDA");
> +	if (!IS_ERR(ts->vdda)) {
> +		error = regulator_enable(ts->vdda);
> +		if (error) {
> +			dev_err(dev, "Failed to get VDDA regulator\n");
> +			regulator_disable(ts->vddi);

You're turning off VDDI in case VDDA fails to be enabled, but you never turn
either off in case the rest of probe (e.g. I2C read) fails, or any other time
for that matter. Please schedule the regulator_disable() calls using
devm_add_action_or_reset() so that they are automatically disabled in sequence
in case probe terminates early, or the driver is unloaded.

> +			return error;
> +		}
> +		if (!device_property_read_u32(dev, "startup-time-ms", &startup_delay_ms))
> +			msleep(startup_delay_ms);

This seems like it should be a constraint handled by the regulator core and
not your driver.

> +	}
> +
> +	error = axiom_discover(ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "Failed touchscreen discover\n");
> +
> +	input_dev = devm_input_allocate_device(ts->dev);
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	input_dev->name = "TouchNetix axiom Touchscreen";
> +	input_dev->phys = "input/axiom_ts";
> +
> +	/* Single Touch */
> +	input_set_abs_params(input_dev, ABS_X, 0, 65535, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, 65535, 0, 0);

As I explained in the v3 review, you do not need to do this. Please refer to my
previous comments.

> +
> +	/* Multi Touch */

This comment is unnecessary.

> +	/* Min, Max, Fuzz (expected noise in px, try 4?) and Flat */

What is the point of this comment, and the one below? Should fuzz have been 4?

> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
> +	/* Min, Max, Fuzz (expected noise in px, try 4?) and Flat */
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);

It seems you are forcing 65535 by 65535 resolution; is there no way to
adjust this? Most controllers can scale it in their FW. You should either
accept a customer-defined resolution using touchscreen_parse_properties()
and write it through to the FW, read it from FW and report it through
input_set_abs_params(), or both.

> +
> +	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);

This is unnecessary; input_mt_init_slots() will do it based on the contact type.

> +
> +	/* Registers the axiom device as a touchscreen instead of a mouse pointer */
> +	error = input_mt_init_slots(input_dev, AXIOM_U41_MAX_TARGETS, INPUT_MT_DIRECT);
> +	if (error)
> +		return error;
> +
> +	/* Enables the raw data for up to 4 force channels to be sent to the input subsystem */
> +	set_bit(EV_REL, input_dev->evbit);
> +	set_bit(EV_MSC, input_dev->evbit);
> +	/* Declare that we support "RAW" Miscellaneous events */
> +	set_bit(MSC_RAW, input_dev->mscbit);
> +
> +	ts->input_dev = input_dev;
> +	input_set_drvdata(ts->input_dev, ts);
> +
> +	/* Ensure that all reports are initialised to not be present. */
> +	for (target = 0; target < AXIOM_U41_MAX_TARGETS; target++)
> +		ts->targets[target].state = AXIOM_TARGET_STATE_NOT_PRESENT;
> +
> +	error = input_register_device(input_dev);
> +	if (error)
> +		return dev_err_probe(ts->dev, error,
> +				     "Could not register with Input Sub-system.\n");
> +
> +	error = devm_request_threaded_irq(dev, client->irq, NULL,
> +					  axiom_irq, IRQF_ONESHOT, dev_name(dev), ts);
> +	if (error < 0) {

if (error)

> +		dev_warn(dev, "Request irq failed, falling back to polling mode");
> +
> +		error = input_setup_polling(input_dev, axiom_i2c_poll);
> +		if (error)
> +			return dev_err_probe(ts->dev, error, "Unable to set up polling mode\n");
> +
> +		if (!device_property_read_u32(ts->dev, "poll-interval", &poll_interval))
> +			input_set_poll_interval(input_dev, poll_interval);
> +		else
> +			input_set_poll_interval(input_dev, POLL_INTERVAL_DEFAULT_MS);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id axiom_i2c_id_table[] = {
> +	{ "ax54a" },
> +	{},

Nit: add a space inside the sentinel like you do below.

> +};
> +MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
> +
> +static const struct of_device_id axiom_i2c_of_match[] = {
> +	{ .compatible = "touchnetix,ax54a", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, axiom_i2c_of_match);
> +
> +static struct i2c_driver axiom_i2c_driver = {
> +	.driver = {
> +		   .name = "axiom",
> +		   .of_match_table = axiom_i2c_of_match,
> +	},
> +	.id_table = axiom_i2c_id_table,
> +	.probe = axiom_i2c_probe,
> +};
> +module_i2c_driver(axiom_i2c_driver);

Nit: please add a newline here.

> +MODULE_AUTHOR("Bart Prescott <bartp@baasheep.co.uk>");
> +MODULE_AUTHOR("Pedro Torruella <pedro.torruella@touchnetix.com>");
> +MODULE_AUTHOR("Mark Satterthwaite <mark.satterthwaite@touchnetix.com>");
> +MODULE_AUTHOR("Hannah Rossiter <hannah.rossiter@touchnetix.com>");
> +MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
> +MODULE_DESCRIPTION("TouchNetix axiom touchscreen I2C bus driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

Kind regards,
Jeff LaBundy

