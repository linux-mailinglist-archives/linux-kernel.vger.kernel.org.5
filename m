Return-Path: <linux-kernel+bounces-24185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769E82B8B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BB2282E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97391A4C;
	Fri, 12 Jan 2024 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WPTU9Uwo"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97350EA6;
	Fri, 12 Jan 2024 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDH+yUTvgUX/bYR1auPqZp/+fpkEasDSLPejw1419jgPQ97Rv9tOB4KyJy1Q1Xe32Q04dOj8Xgs9KNHwckISV2mGwkQzQcABR9tWNPpa0lYvKwvPve16MJZr7Wi8mF5Id7jJ5ZWTcL/8hbDH+QW2Uh2CU6trR+jqjFX64WKdYKYxVP7P44J95xd5MyVfSFeabZLqFAc5DLjCtdcLn9+XqPVoU5I7gBcoZi6aDdpff1SwClRlHhkFld3OtOUZ4c2EidtxT8sWJtl/vjNghhyTBdLD9IuK/kM6rfa/RSp5mLUcgcasuZUCakrTwSH4/qczsuFCk0jYV11JWwyJSIt92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH1eYroDTV52Z7eusowWnJwSCTJjwrwIMWHC/rocFjs=;
 b=hBCJxr27z8r2Bgv3XrURtPxl0F5ACeZG3uxUxfzMIelbxRcjSqNv7GgVNx2DYbi0r8tBCrZz/FaYeNc27qkVLUu3iGeNkrKdMYXMDeIlBA5V8kEhkJiwdYl3omtYhdxaKa9xrBH60UVnNW8whWwDm/KVTFAEcsu5jc+nZa/7BvmYCDjczIE37ln//sqds0aqxpkAXcDQYyUzQ0Ypq5TrA4flG35xRTKOIo3xSvXyJLQfmWpAbPklDKVGSNW2urrNQPTOK9KTlgcaig5kee95J8Hp4GyKuiJ6HDJqbnegcydUa790K+dhxSgM7h0LcwNZxLkHmZKX3DZIWr0q3jqy7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qH1eYroDTV52Z7eusowWnJwSCTJjwrwIMWHC/rocFjs=;
 b=WPTU9Uwo/ghlZ2iFDJt1kC9jlcq+RPUV/I8RN1Cm4+kwMDaWzpdJQHPgxAxCZgrON1LCEpX4S+x3cVNtGMEvztfDUaTljVCxqsifa5GHhnYUcBIOxYgaNjD87R5QkvhCjRqKRLVXhQjmJJmNk4ZWCguIu1/T5JoiyHEXN6zsvXQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6877.eurprd04.prod.outlook.com (2603:10a6:803:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 00:44:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 00:44:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Martin Kaiser <martin@kaiser.cx>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: vf610: allow disabling the vf610 driver
Thread-Topic: [PATCH] gpio: vf610: allow disabling the vf610 driver
Thread-Index: AQHaRJ+WqP9gCRQCxEO4s+d81h4DHbDVVuJg
Date: Fri, 12 Jan 2024 00:44:10 +0000
Message-ID:
 <DU0PR04MB9417956F985780AD85FD733E886F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240111150429.681567-1-martin@kaiser.cx>
In-Reply-To: <20240111150429.681567-1-martin@kaiser.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB6877:EE_
x-ms-office365-filtering-correlation-id: 62f3b804-2fa8-43bd-a785-08dc1307977d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zwzm3Sv7w6uKiKzx/+ZdL89TfCglDgZoj4Ybv2A7smK0LGiWb8lPvmkldIfg8alZmcXIv2dJ75ZLHNFNjYG2BIYlaOpae9Ae0OBzwhO6HC3e8kghuP1qKsHp1LmR+oaH+82eT6gg3ohFUdZxF67FEt/pNwttISA7UQrE2v31LRvsbg/NXH2tdoHvP0eIWkSA/QsjaeV8MtNcQ0YyBkLF2tQfUwYVSy8jG93N4x5ohDp4EOg9DWJ+TAwhxeDNlRHIgyW2ud4FcxmYGWSYlr+jBWGTTyZExkygQ1EVRyj+BBH09ptevSDM6fx5jiLaPrY2pEXNKXIjS3JWJz8pgUxrwNgf2sYUNsKOeLIwaF9xuEjtM3e4Xr4hJPU3xBYE1Y+IFXcS1HV9ts0r2vot9ABBfN2YJrxEcUncBNKfnJGcWOD+fu6bTvHOCx+8fwmsna6NOc04LpN7B1fal9COCg2wvarFemZEdfLsv16iXuTFZFGHNR1YKrNBOho5i5BCi+89QwXN7uv/hK9Y1/TucTu//Xaw8gJtcUyWfSdt4KSdf7kSilxhU5w+nDQQQN7iKbanXggVZZSu75+RvDwUTGHxBmDQZsUU3Nz9G2DYRbsjS3mSrShmjM1DnaPKREs/tecd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(83380400001)(26005)(2906002)(38100700002)(66446008)(33656002)(86362001)(38070700009)(5660300002)(66476007)(66556008)(110136005)(54906003)(76116006)(71200400001)(41300700001)(52536014)(9686003)(122000001)(8936002)(8676002)(66946007)(316002)(44832011)(7696005)(64756008)(478600001)(6506007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?45lyMATeZi4ZR1qTe9S0Jg7mxSaQ1grtsPwmSIv7DmUuLs7fs8N6qCYEOK2d?=
 =?us-ascii?Q?qu4WvwuG+V5m4OBuORv7080uqhwUfS/8SUUkwVatUKhUunGmzcZPU13K5yY8?=
 =?us-ascii?Q?LAa7vIcedfjKhm7oby96rhN5Tic8fNoXjVZjDNuKz+C3kgM/GCFH86vrIgNj?=
 =?us-ascii?Q?SsilN6sRu0QRV18H9cyF7ABQiQBCOkj3EG39l4W8reDT98f+zRFc4L1zmlnw?=
 =?us-ascii?Q?j7ncQ9vKxVwTTnsS/xA2lKZKQQSOq42qRxTQLcZx3Nthh92MQLhkNeaPYpas?=
 =?us-ascii?Q?eexyN/dU5xFb/4M8Rplt0efPg3hGiNccDmX90LkV0Pdy2ID5vlHGUN5AhaL4?=
 =?us-ascii?Q?xfhqL+9KI3rZYYoEF0wiFVC+9plzPxNIu0CZV+AQ1NJ3B1PrWX89EzM/jG/c?=
 =?us-ascii?Q?aj+KHqDOMdoBr9ogwhePHgN8LXNmRV6jELWC8DURvB9bkDBpdMG891R6hDaj?=
 =?us-ascii?Q?OxXgkzomtwdJJDhluA7qhQfhp2RsJ0VVDOGbIKlHB4nCUyRkHv6+kC0+gOXT?=
 =?us-ascii?Q?dIbcKZnt+6jKhJN08VBL5vgheHIARxz7jGzn0vtt+SbBF8Hw1BIAJ2lMSAr7?=
 =?us-ascii?Q?Mt4r19/RQSDF5tDKksHv46U8dsvfxbwLIPDgzOngwjMixdl1TRRMkhWBiert?=
 =?us-ascii?Q?YYWnDTLrCnUwanG/xhC9590BbL4Ik/itD6UJQx6gfiGgryhJjiYAqOsnJoNl?=
 =?us-ascii?Q?IQuudhxXjOTG88MnzbLf8ejsvnUEetnB+QsCa3AyU2p4pCiwMccgrzaqL8Mx?=
 =?us-ascii?Q?+V0lyPXFwNtAeULuroi+B31sro+0TKfIn+3gbFm4qfe6uzEXUmoaXXnOfsDB?=
 =?us-ascii?Q?x+ccuLs500v1/+GL3essedJDn3SRE8nVI+esR1HX5BkKsRAgWm6a2odvN/JZ?=
 =?us-ascii?Q?hAp+K1N37Iwr7aLoxvO0OU8XvfTqr/OjkL7e0XAABS2Yx4MlMoWTPeSI6ozh?=
 =?us-ascii?Q?7zTVarHvHIqbvnxSfrklVr5ipch9S4NDi3Hp37+UWwkRg4dejZJi0dw5GjTw?=
 =?us-ascii?Q?wnZMhYOVLDGckceou3S/SxaVWbc866+9HqrT3WgcDJ5PlIExqhZUXU24fcF0?=
 =?us-ascii?Q?YXASePejLFD8E0p2cYhnI1fSn6VW3fgTmz78og9ALUks8P87K9EGOG3nTGw+?=
 =?us-ascii?Q?IV0lFJecxaHqK/roXFVGecitc4E/Zv5PjG4AGZ75YgJ5p/zHTvUZv822VCgn?=
 =?us-ascii?Q?0KlyQB8+v5TydS8O1Ra/dyjzgln5NF17+i5P+ehkFuBHRPvXkyLl7C9qWE41?=
 =?us-ascii?Q?X2xT7LWGJ5Xxa1LjQA3xltCU4KqjJJq/IRw2HIjOV3LVDHv3PkknheASma6u?=
 =?us-ascii?Q?vrK4jaqsh7Ic7+ZNSHa6uc7y9kQA46Qyjpi9BFmmbSgAne9XSf2QZvNdk+sE?=
 =?us-ascii?Q?AvCpp0/iVLSpLCorfP2gXgZLtlkaM9UqH8wJf7kp9svVY07tNYM/0k4ysx+2?=
 =?us-ascii?Q?ZorjWSmi4x1SclDEHcc9hrO3GPkdRK0LA29ylk2XuLN2Kw8ai7QdXomII7Qk?=
 =?us-ascii?Q?nmp1tT+yYLkrqLSw6kwCzasbK955EWH3zdXT516cxzJaQGd9+kcp7NNlJ1Jl?=
 =?us-ascii?Q?4JFEOi1OcKtXS3IGSp0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f3b804-2fa8-43bd-a785-08dc1307977d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 00:44:10.6705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqmsHFnBA1fgXvUDMdKYWIobZj2IjFyWubYnk9tWvVJ6F15C8ZB35EW5g493NOW7D8cH1966cpeCaQwjs/MSMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6877

Thanks Linus for Ccing me.

> Subject: [PATCH] gpio: vf610: allow disabling the vf610 driver
>=20
> The vf610 gpio driver is enabled by default for all i.MX machines, withou=
t any
> option to disable it in a board-specific config file.
>=20
> Most i.MX chipsets have no hardware for this driver. Change the default t=
o
> enable GPIO_VF610 for SOC_VF610 and disable it otherwise.
>=20
> Add a text description after the bool type, this makes the driver selecta=
ble by
> make config etc. i.MX chips other than SOC_VF610 can now enable the drive=
r
> from their board config.

This will break i.MX8QM,DXL,ULP/i.MX93 boot. You could add text description
to make it selectable, but please not drop def y. Or you need update defcon=
fig.

Thanks,
Peng.

>=20
> Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for
> GPIO_VF610")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/gpio/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig index
> 1301cec94f12..353af1a4d0ac 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -711,7 +711,8 @@ config GPIO_UNIPHIER
>  	  Say yes here to support UniPhier GPIOs.
>=20
>  config GPIO_VF610
> -	def_bool y
> +	bool "VF610 GPIO support"
> +	default y if SOC_VF610
>  	depends on ARCH_MXC
>  	select GPIOLIB_IRQCHIP
>  	help
> --
> 2.39.2


