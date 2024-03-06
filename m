Return-Path: <linux-kernel+bounces-94228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60C873BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD54E28B4EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308D13540F;
	Wed,  6 Mar 2024 16:06:17 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF637135A52;
	Wed,  6 Mar 2024 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741176; cv=fail; b=iva9ugSqCTsfIZaf6QhlDYTWp1qQ1TR6Iw+oSQwRUtnYiXxQFz3EX3FbxN30F3c7wr90SkK7lQmg/uj3e+fOr/1L7zWITq5/iaoYVcGgC9HcUqVdcyL2sFUxKMAE6T79YX652B2MIQNuYYlanKKny3gdmpEmHkBtFpVKOxIsYuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741176; c=relaxed/simple;
	bh=2BVIZpV2Iw53wmdjYbJs8BO3RHnHAuYvlwVfSrclSow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NX71j/ZyzXOP+mCHc4mCd4h3kpv+8gQKnd5xntyKoW0w5lgAVhlbpGhWJnmsdBGCzvInNMm7DkaZ5T2GLl2yOdA0p1Bkb1kRt30I22I4cgW0gI8S/Gi1lDm6zks/Zg7L9zGNwhrsFaTq4QOSKBUQYZkmdPsrXWHCZKJV8Gug+q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEtd28K2kpY0M/RQozIHLyv/IWx5Fu4Vn9oC8/DEON5gdqioZI/BgbjdhTaHuSTA697QSHtVAX523zhkp6a8BLFXRzoeltTYvlaSgC7llLIunb902uz8C0YOfxpeKezyR55c/AUZaahwLiH1GCf3Ye76acoVO6seYtrCmNdsstzC2Run+MLSHKZBEOsOt3hTUgT6xId9tYTO/kWsAp9Byc19FD4gbW3ro8CibUOEIrcS7TvVm0M0BrTx0rz4GyLli6Jcx1jfDazsTwp/MOR4ykP4PEtqAqo+t2ifZ99qSn/0pDPmYRCZ7JMLUOzAHibyYxZXgRyzqNCEi/3p+lFPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euCVAdcK7KDmDrtZQ7R1aFcxAy45UFglzkhmoELsw54=;
 b=k57FndzPeYQJVnjdcnSQ8XhBqcR5v3s8GYSsgSbwXM+Yb63Y4ogNyOlYOawsId++qmqopfbuUgd8BNI9sRpJhJTxlhaMzyNazQ1he/58goeePI6iye0Oy1+7OSfA9Fx8KxF9wK2UimijfQJbZOTg6qVZvhwih9RLdfqDzAPzciE+zaMvdfgq/J/Cy0IxBN00DrbVGnZAmpfQ0swJo4hYCeU6bndrPv60gsRMr/ba7nLnYfwIDYqfSVnEUAzTi3dvKFl20/zx4R2LUwb5csiKOuhNTIcaTH3p4XvAH/Z33gdzP7UgjwXAouZiGGwJWgKe4/23r6fNwLpXkLwO8jdlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0571.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.53; Wed, 6 Mar
 2024 16:06:11 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::f6ed:1a18:3fbf:788]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::f6ed:1a18:3fbf:788%6]) with mapi id 15.20.7316.050; Wed, 6 Mar 2024
 16:06:11 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Frank Li <Frank.Li@nxp.com>
CC: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "joe@perches.com" <joe@perches.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "robh@kernel.org"
	<robh@kernel.org>, "zbigniew.lukwinski@linux.intel.com"
	<zbigniew.lukwinski@linux.intel.com>
Subject: RE: [PATCH v8 5/8] i3c: target: add svc target controller support
Thread-Topic: [PATCH v8 5/8] i3c: target: add svc target controller support
Thread-Index: AQHaWrDF4YqbxbLTO0S8kWb/HNrCK7ErCfUA
Date: Wed, 6 Mar 2024 16:06:11 +0000
Message-ID:
 <SH0PR01MB08411D27D7A3CD39CDDE618FF921A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240208170117.798357-1-Frank.Li@nxp.com>
 <20240208170117.798357-6-Frank.Li@nxp.com>
In-Reply-To: <20240208170117.798357-6-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0571:EE_
x-ms-office365-filtering-correlation-id: b02dfa58-6050-40ae-5e03-08dc3df757b2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cEhvcX1VZpAYdzm25rxEjiIudK2mAxTD9sdXUwztfBCPX4gV0r/MRlJDb/XQTr79FSjt5mfxNt6GGbv8LzCWxXuJez+rvxYvAbJ41Xd//nYg2EzWczaJX6BZb5TzCs+F5q2ltWCXb3LIg5Hw4wJ8lBEVL++CZvkFZgYnO9jV1Kh56ZGaFJHGFWo2bu91KpjpOiGUm1ryzZC9HxqcOCPf2lbyCKaLq4a+tJ1GIeoL8NLkwyQYihckB7nmo01vqvMlRfWaEc+EBhqYTUntAGnlIjiExBEFaS1R4LqVhxB2X6IbdDX4zMD46CzoIMJR+Pep6JtAa/0K1X7NXpnCo1xlEkt0jQy/u1Jb7jGg4N7fmbPQ8wjvwPQ4OaUkKinl5cRGPb+Ae0Xd1viJR2CvwN1+TrimzhSCvBaGptdnYdzjaslzm0FoW+fLbffkdaP8wk5T0/xx22HqHDLvRSUldKUab+D/fgbfZo74EsjQkYvONRSJgsUTKtFaHa/qo8nZyL52WetsARJ9bxwYvH+sx23M1dtzFQiRKkJAXTth1ZghZuxKnFiToOTLqKSqhDJ7rv/TFmmwVKroUQCSNSsJqISLlmsHh09LptiCu2MAdW1boyufTQ32IxHTCfSki1B7oDM4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HCc2XV8MNRehi9xNrYUY63qAzLwbaisc0cQkWhcAa5VO77IbbQyMAPfkQCAv?=
 =?us-ascii?Q?KZgRMChshg9wj/QOTTIK8WEhv0DkwFJONq9ZEugz3ZVBk6j8pgWP4yrP+e24?=
 =?us-ascii?Q?zyQyZelQY1GXAk9Zb0nBAMxkb+nL3I8u0/eianrEw/Cl66wCHI1arkRe5v/m?=
 =?us-ascii?Q?ZPiwlHmjwHu6iHqKL4qDZ+ZSpmw05x86qat/JrXe+fQNb+LHm1FqyEMr7agx?=
 =?us-ascii?Q?AIGPLXoLf6IBSR2lx5Omu9TMxp5vBvxl1yIIeCwi/b6xII58nLJ36W49/0JK?=
 =?us-ascii?Q?rt5uNhGh1hupUm2QxjAWF0XsOV4vzHFrYMEh1t6/nDv5OsTHiIoMLXTRMrKg?=
 =?us-ascii?Q?zvj3RDA0Tc2fn2w3V7CnxWj9KELudgPdkNTomiG5nHvhBGYvPdWKFzvRCGWI?=
 =?us-ascii?Q?NE9QxEIpbUin2NymR9G89vCNHPMJTsPKJJiXQgqwjVtmC/VX2xjqR+4pKdjM?=
 =?us-ascii?Q?jK5EJfijYB7mdQXbPcwGume+Ty0mjgPZOMyRdaeAZD8vnLfwio/DT57EzFfP?=
 =?us-ascii?Q?wcE3R1ka6P1nD2kcPzl44jHWE5Bs7TWKa5R8INa5Zd4wHEGX6PQwfdM6ZF8l?=
 =?us-ascii?Q?zkG0MXg4fic7S7UCdpZEcfcOgFvYON3GzXMGuSQWvm1gk79+zd1mgVoMOclI?=
 =?us-ascii?Q?98S+pVx+HFn8gW08EifVkRciJo0K7WqR3obk885upJWkvPcbz1Us+fkfgfXp?=
 =?us-ascii?Q?AWtnR38q4qTualrqN3FqwDJsoy2OQ/+ZOYZpo/QXCLFepWlT8GlC61MwhUwH?=
 =?us-ascii?Q?AR27lU1LzmfPbX9WzXUdf6b9s9qTuuL1Vip/wxF4VULmjT+4lf1zm0ieic/P?=
 =?us-ascii?Q?M+Gcl8hGb1WwO3VhSBVlmJv0JyNWRbdSXFUt7WGItjq5Eki3vS1oFAvmYW5n?=
 =?us-ascii?Q?UM+/cL9bQ+Jyt8o0aZ97gPg8f2G+anCYa96Pg2u/0lG7rnyUtXju+ejwGNOo?=
 =?us-ascii?Q?MH1ngQXCY08hLh7FnlccFFVLdeykXk+FKnAs8J8pXxsIIvqtx4BhjGyrHowZ?=
 =?us-ascii?Q?AhIHkcMbMBLU9Xlj7gHveSoAO4tcQxcNJjo+O4vHclLcyQWFJVfXZrUVk6EW?=
 =?us-ascii?Q?kchqQWxrJ1DMVAF++BJIQ+EX/Aa5ru8OCygJnfqasylXxDx4SzmR5y/yLWJO?=
 =?us-ascii?Q?8gGX5kiL/FJf/2rntYjbEnakrP9hc/Fr0AYPsgxvoIT5129IefWTCkJP5QgU?=
 =?us-ascii?Q?gCi3cel+HbKIHj0cyxMZVwEwcdFy1D9Rkp+p1gmLw7UZhRtJdwBf1Z1LR8K6?=
 =?us-ascii?Q?jwpHIwZlALkMd16rrJ1YRjkrIGp5xeJ9nC+AUKA37Lio5btDPmrqwS1GZ2oC?=
 =?us-ascii?Q?2IdS0jv4yXMkjrrww4089wJ7hNFgHXoiE/IPBXtjD7T+ytSK2lBTTaqehSZA?=
 =?us-ascii?Q?KT6gK/TR9Q3ZmfD4bbOnv9U+boAm+MLUTPjnYYDH9ujgHaL30f32fInuFHkg?=
 =?us-ascii?Q?i0YApsZZzDFEaF6+PsPlnoitL8X0gUqyhw3A+WnzEkur3Y6F0+X3abDCtt1D?=
 =?us-ascii?Q?7HG/9rNE4Khmzm8WtTjckzrS4h0n8HBoP8GanoJqpWNeCxPwDI85zvA0A20J?=
 =?us-ascii?Q?NZSZuLrEZL9RZwSz/fZsdoUhRwwFiPaKl3UzlSfXlXRPkeUEMsvJizZUKUtu?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b02dfa58-6050-40ae-5e03-08dc3df757b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 16:06:11.6804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KO0xZJx/FVttO4rRTRtrsUwiCawp/6vbTdIWMyNsl4CDZQd5xp1rZOumej0VYAtclFDlhbH9q0BHSzOE6hyd57EDc1gyn4MMXBBtbg0cSH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0571

Hi Frank,

Apologize I replied to the older patch series version. I copy the text from=
 there to here instead.

> -----Original Message-----
> From: linux-i3c <linux-i3c-bounces@lists.infradead.org> On Behalf Of Fran=
k Li
> Sent: Friday, February 9, 2024 1:01 AM
> To: frank.li@nxp.com
> Cc: alexandre.belloni@bootlin.com; conor.culhane@silvaco.com;
> devicetree@vger.kernel.org; gregkh@linuxfoundation.org;
> ilpo.jarvinen@linux.intel.com; imx@lists.linux.dev; jirislaby@kernel.org;
> joe@perches.com; krzysztof.kozlowski+dt@linaro.org;
> krzysztof.kozlowski@linaro.org; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-serial@vger.kernel.org;
> miquel.raynal@bootlin.com; robh@kernel.org;
> zbigniew.lukwinski@linux.intel.com
> Subject: [PATCH v8 5/8] i3c: target: add svc target controller support
>=20
> Add Silvaco I3C target controller support
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Notes:
>     Chagne from v7 to v8
>     -reorder header files
>     - add missed header files
>=20
>     Change from v3 to v7
>     - none
>     Change from v2 to v3
>     - fix build warning
>=20
>  drivers/i3c/master/Makefile         |   2 +-
>  drivers/i3c/master/svc-i3c-main.c   |  35 +-
>  drivers/i3c/master/svc-i3c-target.c | 776

I think putting target mode files under "master" might not make sense.
We might have to consider that we may have a "secondary master" mode.
Some other ways of splitting or handling of target mode is needed here.

>=20
>  static const struct dev_pm_ops svc_i3c_pm_ops =3D { diff --git
> a/drivers/i3c/master/svc-i3c-target.c b/drivers/i3c/master/svc-i3c-target=
c
> new file mode 100644
> index 0000000000000..06210ed0c3219
> --- /dev/null
> +++ b/drivers/i3c/master/svc-i3c-target.c
> @@ -0,0 +1,776 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2023 NXP.
> + *
> + * Author: Frank Li <Frank.Li@nxp.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/errno.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/target.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +
> +#include "svc-i3c.h"
> +
> +enum i3c_clks {
> +	PCLK,
> +	FCLK,
> +	SCLK,
> +	MAXCLK,
> +};
> +
> +struct svc_i3c_target {
> +	struct device *dev;
> +	void __iomem *regs;
> +	int irq;
> +	struct clk_bulk_data clks[MAXCLK];
> +
> +	struct list_head txq;
> +	spinlock_t txq_lock; /* protect tx queue */
> +	struct list_head rxq;
> +	spinlock_t rxq_lock; /* protect rx queue */
> +	struct list_head cq;
> +	spinlock_t cq_lock; /* protect complete queue */
> +
> +	struct work_struct work;
> +	struct workqueue_struct *workqueue;
> +
> +	struct completion dacomplete;
> +	struct i3c_target_ctrl_features features;
> +
> +	spinlock_t ctrl_lock; /* protext access SCTRL register */ };
> +
> +#define I3C_SCONFIG	0x4
> +#define   I3C_SCONFIG_SLVENA_MASK	BIT(0)
> +#define	  I3C_SCONFIG_OFFLINE_MASK	BIT(9)
> +#define   I3C_SCONFIG_SADDR_MASK	GENMASK(31, 25)
> +
> +#define I3C_SSTATUS	0x8
> +#define	  I3C_SSTATUS_STNOTSTOP_MASK	BIT(0)
> +#define	  I3C_SSTATUS_STOP_MASK		BIT(10)
> +#define	  I3C_SSTATUS_RX_PEND_MASK	BIT(11)
> +#define   I3C_SSTATUS_TXNOTFULL_MASK	BIT(12)
> +#define	  I3C_SSTATUS_DACHG_MASK	BIT(13)
> +#define	  I3C_SSTATUS_EVDET_MASK	GENMASK(21, 20)
> +#define	  I3C_SSTATUS_EVDET_ACKED	0x3
> +#define	  I3C_SSTATUS_IBIDIS_MASK	BIT(24)
> +#define	  I3C_SSTATUS_HJDIS_MASK	BIT(27)
> +
> +#define I3C_SCTRL	0xc
> +#define   I3C_SCTRL_EVENT_MASK		GENMASK(1, 0)
> +#define	  I3C_SCTRL_EVENT_IBI		0x1
> +#define	  I3C_SCTRL_EVENT_HOTJOIN	0x3
> +#define   I3C_SCTRL_EXTDATA_MASK	BIT(3)
> +#define   I3C_SCTRL_IBIDATA_MASK	GENMASK(15, 8)
> +
> +#define I3C_SINTSET	0x10
> +#define I3C_SINTCLR	0x14
> +#define   I3C_SINT_START	BIT(8)
> +#define   I3C_SINT_MATCHED	BIT(9)
> +#define   I3C_SINT_STOP		BIT(10)
> +#define   I3C_SINT_RXPEND	BIT(11)
> +#define   I3C_SINT_TXSEND	BIT(12)
> +#define   I3C_SINT_DACHG	BIT(13)
> +#define   I3C_SINT_CCC		BIT(14)
> +#define   I3C_SINT_ERRWARN	BIT(15)
> +#define   I3C_SINT_DDRMAATCHED	BIT(16)
> +#define   I3C_SINT_CHANDLED	BIT(17)
> +#define   I3C_SINT_EVENT	BIT(18)
> +#define   I3C_SINT_SLVRST	BIT(19)
> +
> +#define I3C_SDATACTRL	0x2c
> +#define   I3C_SDATACTRL_RXEMPTY_MASK	BIT(31)
> +#define   I3C_SDATACTRL_TXFULL_MASK	BIT(30)
> +#define	  I3C_SDATACTRL_RXCOUNT_MASK	GENMASK(28, 24)
> +#define	  I3C_SDATACTRL_TXCOUNT_MASK	GENMASK(20, 16)
> +#define   I3C_SDATACTRL_FLUSHFB_MASK	BIT(1)
> +#define   I3C_SDATACTRL_FLUSHTB_MASK	BIT(0)
> +
> +#define I3C_SWDATAB	0x30
> +#define   I3C_SWDATAB_END_ALSO_MASK	BIT(16)
> +#define	  I3C_SWDATAB_END_MASK		BIT(8)
> +
> +#define I3C_SWDATAE	0x34
> +#define I3C_SRDATAB	0x40
> +
> +#define I3C_SCAPABILITIES 0x60
> +#define   I3C_SCAPABILITIES_FIFOTX_MASK     GENMASK(27, 26)
> +#define   I3C_SCAPABILITIES_FIFORX_MASK     GENMASK(29, 28)
> +
> +#define I3C_SMAXLIMITS	0x68
> +#define   I3C_SMAXLIMITS_MAXRD_MASK  GENMASK(11, 0)
> +#define   I3C_SMAXLIMITS_MAXWR_MASK  GENMASK(27, 16)
> +
> +#define I3C_SIDPARTNO	0x6c
> +
> +#define I3C_SIDEXT	0x70
> +#define	  I3C_SIDEXT_BCR_MASK	GENMASK(23, 16)
> +#define	  I3C_SIDEXT_DCR_MASK	GENMASK(15, 8)
> +#define I3C_SVENDORID	0x74
> +
> +#define I3C_SMAPCTRL0	0x11c
> +#define	  I3C_SMAPCTRL0_ENA_MASK	BIT(0)
> +#define   I3C_SMAPCTRL0_DA_MASK	GENMASK(7, 1)
> +
> +#define I3C_IBIEXT1	0x140
> +#define   I3C_IBIEXT1_CNT_MASK	GEN_MASK(2, 0)
> +#define   I3C_IBIEXT1_MAX_MASK	GEN_MASK(4, 6)
> +#define   I3C_IBIEXT1_EXT1_SHIFT	8
> +#define   I3C_IBIEXT1_EXT2_SHIFT	16
> +#define   I3C_IBIEXT1_EXT3_SHIFT	24
> +
> +#define I3C_IBIEXT2	0x144
> +#define	  I3C_IBIEXT2_EXT4_SHIFT	0
> +#define	  I3C_IBIEXT2_EXT5_SHIFT	8
> +#define	  I3C_IBIEXT2_EXT6_SHIFT	16
> +#define	  I3C_IBIEXT2_EXT7_SHIFT	24
> +

There is couple of space formatting here that requires to be fixed.

Cheers,
Joshua


