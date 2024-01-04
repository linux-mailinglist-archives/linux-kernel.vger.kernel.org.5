Return-Path: <linux-kernel+bounces-17127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E208248AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596C91F2264C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A604E2C691;
	Thu,  4 Jan 2024 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vdKuLnb4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1462C681;
	Thu,  4 Jan 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7jET+G3u97x39SBVpggpEaEbPd0CFrevizKJ41LEH/Aodn2wWZU/3xZ42t0BidGXxrjumOxlmpLtRK7qcg2KHQLoWXFE4fWLnRj6qpMxbWBAd4DBBKhTYKvzKNgW2u8x66f3H7H3hQ4yHDr0Ygw6Lc08t2L/aw/qupik1G88v2vM8NsSWxRhfaH2Py4PNHDh1rYmv013fbTNFyRCSA2e6rTLZ/lLQqOqVNTkv3YY7iOTRtAQdKechUWu2WQPtraKvs38FKLrXq44qDA9biPSYNdwyZh3DpzDvzFfJOZfIgLpO1REjuMbXlqzT/wqD2DCwlfhCK+IByZ7AGrTX2Zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+g5EKLalG8P+bWkoYdnXjdQ1ZxcS807tWxacAYa7PE=;
 b=RcatYVN0iUo4m7P0QPZKHcg9i7tOioYtU0SWCdqLU6GeDgweDzTPlWgXe89lRbAVHVTdQhkGIOUX2XTOOt6BPi4+s4zggF9Zf/2KqehmHUnL3AYK9a2w0C7eqrZZtudGUMeUUil3HpTE3EWjvru0+R4w9mWM+FfQh9fqSqKEizpVd8AzhdPygKKmK2Cm9OP+CUiO/pzgrYX+HtyNcLaeY/NQpdNY1oCY1MN0uFxIos8niVlugvjDBzD5Dg08+/RAUceL6iVpOrwgy+LLIlITXHbXTviUIGE+quegxNk+JcAeoX3p5kq1Rw8S9CpePWbzfSqw3ltJbU8SC8UYky7nUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+g5EKLalG8P+bWkoYdnXjdQ1ZxcS807tWxacAYa7PE=;
 b=vdKuLnb4j5OyTWpaFGiMiAdSQX/S9vgjV7mD3YdY7q82TA29nPcXdkelxx3Ec1CLhLadTRNkfEsuKhiF0dazUYziP3oX5kA8p7SRt7ZDYpWksNPML5iMw6WARDGjrDTQB0gXM7ySk37YjcuHb2HAtNaCOM2ZsbSgO1bNO4EMgek=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYWPR01MB8478.jpnprd01.prod.outlook.com
 (2603:1096:400:175::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.9; Thu, 4 Jan
 2024 19:09:48 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78%5]) with mapi id 15.20.7181.009; Thu, 4 Jan 2024
 19:09:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Support Opensource
	<support.opensource@diasemi.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Input: da9063_onkey - avoid explicitly setting input's
 parent
Thread-Topic: [PATCH] Input: da9063_onkey - avoid explicitly setting input's
 parent
Thread-Index: AQHaM7spcaFVxQzVj0aWvnobzcBporDKG4WQ
Date: Thu, 4 Jan 2024 19:09:48 +0000
Message-ID:
 <TYCPR01MB1126942265F2B95741501A78286672@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <ZYOseYfVgg0Ve6Zl@google.com>
In-Reply-To: <ZYOseYfVgg0Ve6Zl@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYWPR01MB8478:EE_
x-ms-office365-filtering-correlation-id: ca0361a5-16ac-45c3-0532-08dc0d58b8ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Q7J7lHSvMWomKKmcxIucDApTFrVjzprp0UmQ+vHAYfl1JLKFFXnY4GvWRMiPr2TfgWRRBGte/Guz1B5RyqxRDAo1PeDF9hpe13RUKm2e7djpm80TfoxJSDqyLUcPefnPM/gLr1vd+f2FgUllE2C45QhIQyH5wuucbIzq7ARnMG4/sdcRZ2Rm0M+liWoRXacgTb58LS3MeW6Paml8LVomJPvT1Y/rmxtbKSDkijT0QdjNYIIe57ekICCi7Lp4XEaDWWR2kw34B44HVEBzOjfZrgSvUPoIXZrHUD8jb4ueN/4KDgSMho6vXDjtA3BsgjvDrXvlnw2hIs754R7twzDVYIsCu9KEkdd4fECi8GUYZhiwPxMI06WB3EPyI49fFRh027oJy1eluDvRdDLMOuI59m6VnbBc9yPWYk+Hi/QnRQZnTqbOF4rm1+mVulMgX56ZFWB+ytYSxnUIyieGlMIz3TBLz1PP6nM/X1CckMCveyPDrTEwYevUek69L/xqpHBJoaeZVm15gbzQUAj5feQvgTyCCpGPEkuA5tKgPxK79u7FQvImaURDzsOu+r6XkDh3Q1ikH/70IKRvfUTMgLXBsI0yQ7Kk87QqRZ1LQMiLbTLA2e/8dpLCMJfwzKMBBcTj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(7696005)(53546011)(478600001)(9686003)(71200400001)(6506007)(38100700002)(122000001)(86362001)(33656002)(2906002)(5660300002)(38070700009)(41300700001)(83380400001)(316002)(110136005)(66556008)(66446008)(76116006)(66476007)(66946007)(64756008)(54906003)(52536014)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nIb7pyp641aFKKhv5Z01IJsMOrBG2OBJRzJsBD3xlyvlrvjCi7PXdHbL4cCm?=
 =?us-ascii?Q?K2U9TmxA3fagoDJu6JzUqCID9v1MW2Ggw9hjHLKAf11IuY0bZabU3E+atHL7?=
 =?us-ascii?Q?O/1m6qaJoG8Q7yJzRObxevPIuhBUM/PX5i9NjRrUXC7QEuT9zmMuHZYCey8m?=
 =?us-ascii?Q?IGRcJ8BGdqbVc6+Ce8FrKSOnk2jxfpCjHWuECc6wsubgxIewjnimfU94bSBW?=
 =?us-ascii?Q?GjCa/nTGyuBFtjA5E0Gsl82gt0knJI1FN8n8NyT8kYV9c40KPlEgW/w8vA2/?=
 =?us-ascii?Q?7TlulgIYZNyELLQhmiZzptI2dhdfSDsoutHhGgMq94hthAN8WFht0aXo/eXI?=
 =?us-ascii?Q?0yry5vOKpeEw4Xk+UxOjNnutjww4+CK2xXTQMtIpuwwiMMB+09wavpSBKhA2?=
 =?us-ascii?Q?peWCTUr1VDHF49QNXrXhoNBfnh/FwQuIHZO+Hhe58vsqf6+v5USqU0Vj5yCJ?=
 =?us-ascii?Q?44B03f8LEFDAiMfwgkXIc4MR/HGtSixGlP/qzD0K4vzCSDB6uyJSU4UVJJcY?=
 =?us-ascii?Q?ZD1xrNAHdgrT5v3hITn0kvXVktCG3vOi7FCXB/IpgfCoj4S4baJdfU+V1mrL?=
 =?us-ascii?Q?r1l9kqCTGSd8wjKVhAE62J20ZPdywdkGXN6t0xDZG5gUcicygFM0Joe4jEVG?=
 =?us-ascii?Q?w6ldSYrAgzVWYlzoEAWeVtyjheCaSR66BntSCPJIDXYT8vySCyaZZwTM0fXe?=
 =?us-ascii?Q?ISqpPEA8HFIsew5+Q/60urHoaitI1qy3fnTlhZZNV8Nt4NyxFiJaYvZARTbE?=
 =?us-ascii?Q?gX4076P8LPPqE1dZbfollrQVgNW7f2rlrMqFzhxLaujmjlldykGQhgocVvSl?=
 =?us-ascii?Q?RLvt6ChLgLjyiJIYURXRgrxAlHMtEoKlUXpWjjAKsAt2dznqrorlTOxAcHkP?=
 =?us-ascii?Q?/wp7Qox8PPEa3vX7rlS4BP4qlHOco4pkKPKUJuOywi+ARE90c3Zxy56Fp63p?=
 =?us-ascii?Q?pjo7xpLPTOWaMla1FkgBd/ugKjw98dArUGkcgin710f0+G7NSAIKsAEQUFpt?=
 =?us-ascii?Q?z39KqD1YhkYvbFg1f+HuCHyLrPk4YeHsQIiGMPEgj8Gr0pTK9ZZ0vuWB5hn5?=
 =?us-ascii?Q?yDES3cRkGFD9eqOqumJThgkoHKnP7kHHaB4xG5vFdo1g3GqKcxlR3RzXigAQ?=
 =?us-ascii?Q?G4UxHHH/UA+2AR1KL6YkG7bwkU9kT+hFk5/oLqnwBA7wmw4FIvbvBErXTore?=
 =?us-ascii?Q?R8QMdX7o03z8/PgFMFndCLvegl4AR313wP4YkJKA4u2x1C/5F6iWcCG2quC5?=
 =?us-ascii?Q?hHxhe1D43sFqU1htab2s90+CteTflSsx/J3kzkqu2hkIq2GI203tzUdmWQeA?=
 =?us-ascii?Q?4WJY1iQCuCzoKQrpm/Sj8CE88yC1PAauCCnZDQaGTPBI3ROujvHo1byQouEp?=
 =?us-ascii?Q?REpaCtPfwhLVMHLNT8kDRV0zzeplU5NYmPZxf7Pe0n0RlDwAnUKeLJVDBeRv?=
 =?us-ascii?Q?yArA7pMvnwg7Dg0vYT46SMk0hXs/rClTbNuQCM0JVZG6X6pu/eerB10b6OcC?=
 =?us-ascii?Q?6SbxyY1dSBFp5Ds4QmY4KJOkwp+fze1wP163xXvleDklPfM49tahrZZM9KwU?=
 =?us-ascii?Q?b4STt5JzgfMsi6OcMXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0361a5-16ac-45c3-0532-08dc0d58b8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 19:09:48.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXED2/cLVlkWGX0E0o1z6xkp7tJn31qvwBx+B5S2v/5vLfz/9NI6vocRRAa2zIKRxxSap1AXt5VfSd2EO3DD/4zlSODJZ9wkTkaydLvGoug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8478

Hi Dmitry Torokhov,

Thanks for the patch.

> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Thursday, December 21, 2023 3:10 AM
> To: Support Opensource <support.opensource@diasemi.com>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] Input: da9063_onkey - avoid explicitly setting input's
> parent
>=20
> devm_input_allocate_device() already sets parent of the new input device,
> there's no need to set it up explicitly.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>  drivers/input/misc/da9063_onkey.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/input/misc/da9063_onkey.c
> b/drivers/input/misc/da9063_onkey.c
> index ce499c28a7b2..c338765e0ecd 100644
> --- a/drivers/input/misc/da9063_onkey.c
> +++ b/drivers/input/misc/da9063_onkey.c
> @@ -211,7 +211,6 @@ static int da9063_onkey_probe(struct platform_device
> *pdev)
>  	snprintf(onkey->phys, sizeof(onkey->phys), "%s/input0",
>  		 onkey->config->name);
>  	onkey->input->phys =3D onkey->phys;
> -	onkey->input->dev.parent =3D &pdev->dev;
>=20
>  	input_set_capability(onkey->input, EV_KEY, KEY_POWER);
>=20
> --
> 2.43.0.195.gebba966016-goog
>=20
>=20
> --
> Dmitry

