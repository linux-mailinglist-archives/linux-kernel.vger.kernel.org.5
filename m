Return-Path: <linux-kernel+bounces-13589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1261820875
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15AF283856
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F8FC2E9;
	Sat, 30 Dec 2023 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="Fe3bnA5M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72401E54D;
	Sat, 30 Dec 2023 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW2IKN+MtIaCP0gu8fjWVo7DrvIzcBFpSyZULv96ZjEJhenfuPQ7rbxdy0JWJvam/gdPmT8iMxK+BaZS4DkozPimmnBEGfSNRZ8QGHDORHUoCUjIYoL4XfTXJEdZlKDwj1aK5cUzpYYKX2fjznSGXuo2tUAVEZ7AwcQTgaZjt7jabz+yz3du28xcuGeJJJRc7vdZvKzSaBIKuphCzLRl8+2TZrqpEKjLN7r6dUJfcMvCiBTvrA66m7iyI2xlEAla0RLK+4GshaZ1UOTXmzQyuP9wu5lOgAfk5D6g6AAV2irUyp2YXPlrxFAXdXRiERtTZJf/y+7CKXpHXBdPVAzksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WspPLe3Z4kdTRjQKn361G865v1lMLpNQnp0t9EoxSKw=;
 b=MgvYdFjVr+g9+fNV6ng5N0jbnmNzc5NByOyiAscsQTPo+zyBOZywvjQ+8LuJNbUb2vpIEqXH+71Sloqpo4hMZkEB2h3bNKcJI7211q6j5kDoKhQGnP/+1UdHWD4D6CmQOoDnW/6ke9DK6xDyFgYRYs/JoZEs9J6UKOFslI56gLctUGWaXG3vK/SK9ayEb6Hr6JqK7b7G694XmwmEjnBW/E/kJcdl0fdDWoTMIKLHP4aCwwiumNUU6uACUa81+vJwWW71Ay65MO5QjhEvBLcVB1KGEmcNckv69hFSv6DDlCn1yHOiTc2Lg2lF2shm/UUmsuNxqFn7dl3lf+M/fdH1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WspPLe3Z4kdTRjQKn361G865v1lMLpNQnp0t9EoxSKw=;
 b=Fe3bnA5Mrnfuk7pDE+fawzJPrjvxLiP8u2JJoX05aCTLvnbaxCyvcBshT17asFu8+hm1mbELWjP9Na3BRE8D2QwtorheCLnozWxi0+Sh6oCYG/mVA6vmx9vibs7TFAc/i2mlKRfwW2puCIN6trD2vKLQA55Xo3mFs0gpBJcU2kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CH0PR08MB6908.namprd08.prod.outlook.com
 (2603:10b6:610:da::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.10; Sat, 30 Dec
 2023 20:30:06 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7159.010; Sat, 30 Dec 2023
 20:30:05 +0000
Date: Sat, 30 Dec 2023 14:29:59 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Bastian Hecht <hechtb@gmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/4] Input: touch-overlay - Add touchscreen overlay
 handling
Message-ID: <ZZB9x+0eNL8e+xI3@nixie71>
References: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v6-2-d8a605975153@wolfvision.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-feature-ts_virtobj_patch-v6-2-d8a605975153@wolfvision.net>
X-ClientProxiedBy: SN1PR12CA0063.namprd12.prod.outlook.com
 (2603:10b6:802:20::34) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CH0PR08MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a95d83c-451a-4fb9-7d08-08dc09761b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EPoWv7ZD1Pdk9KjBt3tRj4y6ai3Poza0puvWZieLXbv0X19DQ3lnTOWInFN0XZubq57kBseePFpIfYEdW2bsd52fAcJqzxcG+bUhFe0s5Eo6tudpFU5RFevMBPk7sPeYvNoBCr/jwOpkag7UNfKuTjVMDXWPKvNqP4cmzyIEGUrPAIYP7By7hJ4SQph0RUGKUXDazDM3AJ11QQCER4/FJFLlN3dInE4hMlHIqrTxI5LH37ygMRbV0b+u2SM2/46RLFP/AQxUyg2zzny39vgNfxE35x/Pdi/L9my1T39tGs5w9AF4sWmTLVKazpS8oIxwk1Sa8OokouybMyjXi8+nHVX8ZEwWp/4cS9/ucboP9ZMybARyIQ01Y+251z7qVVJgY+2OxPOl5v50sIGBR/y+x60NzHrwC6z/A8lb0c38qt/OKFP95CpQgYQn+tZ/B+/WNSGZWBm25VkMVgTo5kubuLJSqxss5tsMoToAE0DeOYv8R6eG5xgxmU2rmDImmqmSSfXqnnLkFeYQ2gtoj4R8yH0Fy2j9ePhhSohKJjC4dP3DX6ownsOXGOIv64Lo997s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(396003)(346002)(136003)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(26005)(9686003)(6512007)(6506007)(478600001)(6666004)(6486002)(41300700001)(33716001)(316002)(54906003)(66556008)(66946007)(6916009)(66476007)(4326008)(8936002)(8676002)(86362001)(38100700002)(2906002)(30864003)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MgUKSy6+/Rqp/07vRBsAPfhF312sOnOg7/hsQ5pzVC5lawLwcWldCZ/XEg/V?=
 =?us-ascii?Q?BOXEdu5drOPwPofhq6hn0ePgJyBGIif8kCmvkiVKAjwgiSuwwXbKSN8WtTfy?=
 =?us-ascii?Q?eSEoyTGeT2HeF+CxkDBtRc/WBkr7zQGFggxEQfY/UNlAzRar2P7vhifXT3mb?=
 =?us-ascii?Q?NTusGoQswjU6nct+BK1dXdA10v0rsat0tYBdG2O0ofQPxZW8u0jUSxgqD8du?=
 =?us-ascii?Q?o6UJbwpG+MvINJSedH2Bg+Lh8+grciGLT2jSONSEcNEzM7NsCS+ZQ0CqpxDX?=
 =?us-ascii?Q?z5K10mn8AgFmOLuTtsr7pGgeCv1y6peS1wSLyjOwZgfASuK+qR5aw2MttadH?=
 =?us-ascii?Q?g9o/XH2tS9b4UG4L1FHjeg14+xU2kLXA3dYfFQE42/Hsm9QqAZtC4w/UmXWT?=
 =?us-ascii?Q?bmNYVivxHqV4NVxy0xqFmm+xns78aYKkxoY4MT2ls4AvWhwvkuUUCupvf5Vy?=
 =?us-ascii?Q?emYXZaN50TngPRHcLr5sANqJCkZ/EGkULC2WS8QLeZ3ok+bx+U6OIHQHTEug?=
 =?us-ascii?Q?+si0WtR7nlkyqYCCiQfWb4/aSsPAaDFM960+qg4qrfJRGhyx+J5JmhWyy/Db?=
 =?us-ascii?Q?koGS9nnE4Su43PcUO2pZAn9odAPEzaSXNZNuUuUfhqHFcG8Se1tkcVDPJ+Ob?=
 =?us-ascii?Q?Espb5lbDT5Px5oG0MTbbPxZfzva5DAXjs0BbBWwXBqPVYyBqLDhoA0qwJxS3?=
 =?us-ascii?Q?sx8AF1irA5M0m+aCJlw3R6dUco8++9TlQ+M2CT2Y1nTVJ/QhnOjYTvDF877u?=
 =?us-ascii?Q?Sx4IvAvKM42wMVpCMRyxb/yrOcJbXI/osR/xuN95+Z/yv/ju7uglkVMW/7+h?=
 =?us-ascii?Q?nRJkO/evUdlTi11WTlB3T/VGVjgrZkKB+J0UlIepZsazUU73nUis3Khjnrvz?=
 =?us-ascii?Q?a9FcJ+5ZLPdodK8EDalkBqlCLhhFHr7RFGmMJF3uptnRtECAHrEvtYSHXOma?=
 =?us-ascii?Q?XEHINZpRPLmyREmQJlJrCepZ9iXfLQVMvsQzx0vPH5YVmwiB28Dubr+3rhSQ?=
 =?us-ascii?Q?blOUWWAZu9dok0z0CBKl5HDns4DK11uM+5IZVHvSxK+cKvyi0ciXJUsHFtpf?=
 =?us-ascii?Q?l22UUV3cKjb+ba1P4tWEgPOaFl4c6u9b0E/W3TtC5KjoHgoeAChYaQ0FLJUF?=
 =?us-ascii?Q?mhU4jiX+fP0ns54QeWg/xBNl2KaQm941J9ozr/aeOhQRbjUqBHkGz7UDK/PM?=
 =?us-ascii?Q?/QuG66Cn7ufSrlNVpdtM9HtYeJInsrGFrWLB3UPn7LbaZOAeLCno4sL7gU44?=
 =?us-ascii?Q?arHDD+ouETBbaAfKXLtOtamJc95ZRX6QmehNEhswS2TQ97adZpVXbJpNutI4?=
 =?us-ascii?Q?SM3+2zM1UCoQA7yES9VHb2Ok1iPQ7dhRfB+tyQvv+hj0B9cjYgK3hFXnmQhK?=
 =?us-ascii?Q?SSmRBjNs2n4Sz6cbXUnQkw2/eqUhG0CCePqtaa1xez5zUnmP3HGbffB2h64F?=
 =?us-ascii?Q?TfDyvLDXuapYmfnATiKp3RJiRfMSBTvcx4SMz54Ps0B2HoOrDMY/1Rz3LEFA?=
 =?us-ascii?Q?XI7KhYGWhbCOWqcG0TMRWggWgeXwQNuVNxQKzxUPkaMqfIecmgL5fajz54yH?=
 =?us-ascii?Q?986Mfoj6RTwiKLUJXtfZM3OrWL32oEDa9G3jRsOP?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a95d83c-451a-4fb9-7d08-08dc09761b3b
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 20:30:05.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWSy8I2cBWp245vwHuIO0QVSCD817fpXxwPxAm4tQkz84xdi6vXHC3HtzleCTTxTIXGqM1sar9GDHdq02e6cyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB6908

Hi Javier,

Truly excellent work; I'm glad to see this keep moving forward, and the
new linked list approach looks well-suited to this application.

On Wed, Dec 20, 2023 at 09:39:44AM +0100, Javier Carrasco wrote:
> Some touch devices provide mechanical overlays with different objects
> like buttons or clipped touchscreen surfaces.
> 
> In order to support these objects, add a series of helper functions
> to the input subsystem to transform them into overlay objects via
> device tree nodes.
> 
> These overlay objects consume the raw touch events and report the
> expected input events depending on the object properties.
> 
> Note that the current implementation allows for multiple definitions
> of touchscreen areas (regions that report touch events), but only the
> first one will be used for the touchscreen device that the consumers
> typically provide.
> Should the need for multiple touchscreen areas arise, additional
> touchscreen devices would be required at the consumer side.
> There is no limitation in the number of touch areas defined as buttons.

Having reviewed this version in detail, it's clear how the implementation
imposes this restriction. However, it's not clear why we have to have this
restriction straight out of the gate; it also breaks the "square doughnut"
example we discussed in v5, where a button resides inside a touch surface
which is split into four discrete rectangles that report X/Y coordinates
relative to the same origin.

From my naive point of view, a driver should merely pass a contact's ID
(for HW that can track contacts), coordinates, and pressure. Your helper(s)
are then responisble for iterating over the list, determining the segment
in which the coordinates fall, and then reporting the event by way of
input_report_abs() or input_report_key() based on whether or not a keycode
is defined.

I think the problem with that approach is that touchscreen drivers only
report coordinates when the pressure is nonzero. The process of dropping
a contact, i.e. button release for some segments, happens inside input-mt
by virtue of the driver calling input_mt_sync_frame().

It makes sense now why you are duplicating the contact tracking to a degree
here. Therefore, it's starting to look more and more like the overlay segment
handling needs to move into the input-mt core, where much of the information
you need already exists.

If we look at input_mt_report_pointer_emulation(), the concept of button
release is already happening; all we really want to do here is gently
expand the core to understand that some ranges of coordinates are simply
quantized to a keycode with binary pressure (i.e. press/release).

In addition to removing duplicate code as well as the restriction of supporting
only one X/Y surface, moving overlay support into the input-mt core would
remove the need to modify each touchscreen driver one at a time with what
are largely the same nontrivial changes. If we think about it more, the
touchscreen controller itself is not changing, so the driver really shouldn't
have to change much either.

Stated another way, I think it's a better design pattern if we let drivers
continue to do their job of merely lobbing hardware state to the input
subsytem via input_mt_slot(), touchscreen_report_pos() and input_mt_sync_frame(),
then leave it to the input subsystem alone to iterate over the list and
determine whether some coordinates must be handled differently.

The main drawback to this approach is that the overlay buttons would need
to go back to being part of the touchscreen input device as in v1, as opposed
to giving the driver the flexibility of splitting the buttons and X/Y surfaces
into two separate input devices.

When we first discussed this with Peter, we agreed that splitting them into two
input devices grants the most flexibility, in case user space opts to inhibit
one but not the other, etc. However since the buttons and X/Y surfaces are all
part of the same physical substrate, it seems the chances of user space being
interested in one but not the other are low.

Furthermore, folding the buttons and X/Y surfaces back into the same input
device would remove the need for each touchscreen driver to preemptively
allocate a second input device, but then remove it later as in patch [4/4]
in case the helpers did not find any buttons.

What are your thoughts on evolving the approach in this way? It's obviously
another big change and carries some risk to the core, so I'm curious to hear
Dmitry's and others' thoughts as well. I appreciate that you've been iterating
on this for some time, and good is not the enemy of great; therefore, maybe
a compromise is to move forward with the current approach in support of the
hardware you have today, then work it into the input-mt core over time. But
it would be nice to avoid ripping up participating touchscreen drivers twice.

Thank you for your patience and continued effort. In the meantime, please note
some minor comments that are independent of this architectural decision.

> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  MAINTAINERS                         |   7 +
>  drivers/input/Makefile              |   2 +-
>  drivers/input/touch-overlay.c       | 283 ++++++++++++++++++++++++++++++++++++
>  include/linux/input/touch-overlay.h |  24 +++
>  4 files changed, 315 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cf..3218d8694735 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22031,6 +22031,13 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/platform/x86/toshiba-wmi.c
>  
> +TOUCH OVERLAY
> +M:	Javier Carrasco <javier.carrasco@wolfvision.net>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/input/touch-overlay.c
> +F:	include/linux/input/touch-overlay.h
> +
>  TPM DEVICE DRIVER
>  M:	Peter Huewe <peterhuewe@gmx.de>
>  M:	Jarkko Sakkinen <jarkko@kernel.org>
> diff --git a/drivers/input/Makefile b/drivers/input/Makefile
> index c78753274921..393e9f4d00dc 100644
> --- a/drivers/input/Makefile
> +++ b/drivers/input/Makefile
> @@ -7,7 +7,7 @@
>  
>  obj-$(CONFIG_INPUT)		+= input-core.o
>  input-core-y := input.o input-compat.o input-mt.o input-poller.o ff-core.o
> -input-core-y += touchscreen.o
> +input-core-y += touchscreen.o touch-overlay.o
>  
>  obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
>  obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
> diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
> new file mode 100644
> index 000000000000..0a0646ceb755
> --- /dev/null
> +++ b/drivers/input/touch-overlay.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Helper functions for overlay objects on touchscreens
> + *
> + *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
> + */
> +
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touch-overlay.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +
> +struct button {
> +	u32 key;
> +	bool pressed;
> +	int slot;
> +};
> +
> +struct touch_overlay_segment {
> +	struct list_head list;
> +	u32 x_origin;
> +	u32 y_origin;
> +	u32 x_size;
> +	u32 y_size;
> +	struct button *btn;

I think you can simply declare the struct itself here as opposed to a pointer to
one; this would avoid a second call to devm_kzalloc().

> +};
> +
> +static int touch_overlay_get_segment(struct fwnode_handle *segment_node,
> +				     struct touch_overlay_segment *segment,
> +				     struct input_dev *keypad,
> +				     struct device *dev)
> +{
> +	int error;
> +
> +	error = fwnode_property_read_u32(segment_node, "x-origin",
> +					 &segment->x_origin);
> +	if (error)
> +		return error;
> +
> +	error = fwnode_property_read_u32(segment_node, "y-origin",
> +					 &segment->y_origin);
> +	if (error)
> +		return error;
> +
> +	error = fwnode_property_read_u32(segment_node, "x-size",
> +					 &segment->x_size);
> +	if (error)
> +		return error;
> +
> +	error = fwnode_property_read_u32(segment_node, "y-size",
> +					 &segment->y_size);
> +	if (error)
> +		return error;
> +
> +	if (fwnode_property_present(segment_node, "linux,code")) {

Instead of walking the device tree twice by calling fwnode_property_present()
followed by fwnode_property_read_u32(), you can simply check whether the
latter returns -EINVAL, which indicates the optional property was absent.

> +		segment->btn = devm_kzalloc(dev, sizeof(*segment->btn),
> +					    GFP_KERNEL);
> +		if (!segment->btn)
> +			return -ENOMEM;
> +
> +		error = fwnode_property_read_u32(segment_node, "linux,code",
> +						 &segment->btn->key);
> +		if (error)
> +			return error;
> +
> +		input_set_capability(keypad, EV_KEY, segment->btn->key);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * touch_overlay_map - map overlay objects from the device tree and set
> + * key capabilities if buttons are defined.
> + * @list: pointer to the list that will hold the segments
> + * @keypad: pointer to the already allocated input_dev
> + *
> + * Returns 0 on success and error number otherwise.
> + *
> + * If a keypad input device is provided and overlay buttons are defined,
> + * its button capabilities are set accordingly.
> + */
> +int touch_overlay_map(struct list_head *list, struct input_dev *keypad)
> +{
> +	struct fwnode_handle *overlay, *fw_segment;
> +	struct device *dev = keypad->dev.parent;
> +	struct touch_overlay_segment *segment;
> +	int error;
> +
> +	overlay = device_get_named_child_node(dev, "touch-overlay");
> +	if (!overlay)
> +		return 0;
> +
> +	fwnode_for_each_child_node(overlay, fw_segment) {
> +		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
> +		if (!segment) {
> +			error = -ENOMEM;
> +			goto put_overlay;

For this and the below case where you exit the loop early in case of an
error, you must call fwnode_handle_put(fw_segment) manually. The reference
count is handled automatically only when the loop iterates and terminates
naturally.

Since nothing else happens between the loop and the 'put_overlay' label,
you can also replace the goto with a break and remove the label altogether.

> +		}
> +		error = touch_overlay_get_segment(fw_segment, segment, keypad,
> +						  dev);
> +		if (error)
> +			goto put_overlay;
> +
> +		list_add_tail(&segment->list, list);
> +	}
> +
> +put_overlay:
> +	fwnode_handle_put(overlay);
> +	return error;
> +}
> +EXPORT_SYMBOL(touch_overlay_map);
> +
> +/**
> + * touch_overlay_get_touchscreen_abs - get abs size from the touchscreen area.
> + * @list: pointer to the list that holds the segments
> + * @x: horizontal abs
> + * @y: vertical abs
> + */
> +void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y)
> +{
> +	struct touch_overlay_segment *segment;
> +	struct list_head *ptr;
> +
> +	list_for_each(ptr, list) {
> +		segment = list_entry(ptr, struct touch_overlay_segment, list);
> +		if (!segment->btn) {
> +			*x = segment->x_size - 1;
> +			*y = segment->y_size - 1;
> +			break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(touch_overlay_get_touchscreen_abs);
> +
> +static bool touch_overlay_segment_event(struct touch_overlay_segment *seg,
> +					u32 x, u32 y)
> +{
> +	if (!seg)
> +		return false;
> +
> +	if (x >= seg->x_origin && x < (seg->x_origin + seg->x_size) &&
> +	    y >= seg->y_origin && y < (seg->y_origin + seg->y_size))
> +		return true;
> +
> +	return false;
> +}
> +
> +/**
> + * touch_overlay_mapped_touchscreen - check if a touchscreen area is mapped
> + * @list: pointer to the list that holds the segments
> + *
> + * Returns true if a touchscreen area is mapped or false otherwise.
> + */
> +bool touch_overlay_mapped_touchscreen(struct list_head *list)
> +{
> +	struct touch_overlay_segment *segment;
> +	struct list_head *ptr;
> +
> +	list_for_each(ptr, list) {
> +		segment = list_entry(ptr, struct touch_overlay_segment, list);
> +		if (!segment->btn)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(touch_overlay_mapped_touchscreen);
> +
> +/**
> + * touch_overlay_mapped_buttons - check if overlay buttons are mapped
> + * @list: pointer to the list that holds the segments
> + *
> + * Returns true if overlay buttons mapped or false otherwise.
> + */
> +bool touch_overlay_mapped_buttons(struct list_head *list)
> +{
> +	struct touch_overlay_segment *segment;
> +	struct list_head *ptr;
> +
> +	list_for_each(ptr, list) {
> +		segment = list_entry(ptr, struct touch_overlay_segment, list);
> +		if (segment->btn)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(touch_overlay_mapped_buttons);
> +
> +static bool touch_overlay_mt_on_touchscreen(struct list_head *list,
> +					    u32 *x, u32 *y)
> +{
> +	struct touch_overlay_segment *segment;
> +	bool contact = x && y;
> +	struct list_head *ptr;
> +
> +	/* Let the caller handle events with no coordinates (release) */
> +	if (!contact)
> +		return false;
> +
> +	list_for_each(ptr, list) {
> +		segment = list_entry(ptr, struct touch_overlay_segment, list);
> +		if (!segment->btn &&
> +		    touch_overlay_segment_event(segment, *x, *y)) {
> +			*x -= segment->x_origin;
> +			*y -= segment->y_origin;
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static bool touch_overlay_button_event(struct input_dev *input,
> +				       struct touch_overlay_segment *segment,
> +				       const u32 *x, const u32 *y, u32 slot)
> +{
> +	bool contact = x && y;
> +
> +	if (!contact && segment->btn->pressed && segment->btn->slot == slot) {
> +		segment->btn->pressed = false;
> +		input_report_key(input, segment->btn->key, false);
> +		input_sync(input);
> +		return true;
> +	} else if (contact && touch_overlay_segment_event(segment, *x, *y)) {
> +		segment->btn->pressed = true;
> +		segment->btn->slot = slot;
> +		input_report_key(input, segment->btn->key, true);
> +		input_sync(input);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * touch_overlay_process_event - process input events according to the overlay
> + * mapping. This function acts as a filter to release the calling driver from
> + * the events that are either related to overlay buttons or out of the overlay
> + * touchscreen area if defined.
> + * @list: pointer to the list that holds the segments
> + * @input: pointer to the input device associated to the event
> + * @x: pointer to the x coordinate (NULL if not available - no contact)
> + * @y: pointer to the y coordinate (NULL if not available - no contact)
> + * @slot: slot associated to the event
> + *
> + * Returns true if the event was processed (reported for valid key events
> + * and dropped for events outside the overlay touchscreen area) or false
> + * if the event must be processed by the caller. In that case this function
> + * shifts the (x,y) coordinates to the overlay touchscreen axis if required.
> + */
> +bool touch_overlay_process_event(struct list_head *list,
> +				 struct input_dev *input,
> +				 u32 *x, u32 *y, u32 slot)
> +{
> +	struct touch_overlay_segment *segment;
> +	struct list_head *ptr;
> +
> +	/*
> +	 * buttons must be prioritized over overlay touchscreens to account for
> +	 * overlappings e.g. a button inside the touchscreen area.
> +	 */
> +	list_for_each(ptr, list) {
> +		segment = list_entry(ptr, struct touch_overlay_segment, list);
> +		if (segment->btn &&
> +		    touch_overlay_button_event(input, segment, x, y, slot)) {
> +			return true;
> +		}
> +	}
> +
> +	/*
> +	 * valid touch events on the overlay touchscreen are left for the client
> +	 * to be processed/reported according to its (possibly) unique features.
> +	 */
> +	return !touch_overlay_mt_on_touchscreen(list, x, y);
> +}
> +EXPORT_SYMBOL(touch_overlay_process_event);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Helper functions for overlay objects on touch devices");
> diff --git a/include/linux/input/touch-overlay.h b/include/linux/input/touch-overlay.h
> new file mode 100644
> index 000000000000..df974eb46dd4
> --- /dev/null
> +++ b/include/linux/input/touch-overlay.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
> + */
> +
> +#ifndef _TOUCH_OVERLAY
> +#define _TOUCH_OVERLAY
> +
> +#include <linux/types.h>
> +
> +struct input_dev;
> +
> +int touch_overlay_map(struct list_head *list, struct input_dev *keypad);
> +
> +void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y);
> +
> +bool touch_overlay_mapped_touchscreen(struct list_head *list);
> +
> +bool touch_overlay_mapped_buttons(struct list_head *list);
> +
> +bool touch_overlay_process_event(struct list_head *list, struct input_dev *input,
> +				 u32 *x, u32 *y, u32 slot);
> +
> +#endif
> 
> -- 
> 2.39.2
> 
> 

Kind regards,
Jeff LaBundy

