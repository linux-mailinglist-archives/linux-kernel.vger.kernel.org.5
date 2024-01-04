Return-Path: <linux-kernel+bounces-17125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3838248A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982091C21E8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524E52C1B7;
	Thu,  4 Jan 2024 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="pQPLRmpD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8BA2C196;
	Thu,  4 Jan 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx+29DXzGCP7HTv1g733U8Oi7xVgWZyhXCaKv6vqvl/kGd62019SXPm0X6i2i5sVEz4DuVRlh4AYyjPW3DyWMscZ9R+Jty6nLNhHcLfknFJI6cPBa8jkuzog89Kf+p+JLuk1MKdcouoiMIBb15XhA4xNxLL262EEa+QUbzdgYBP/NHB3EBpVAhIhNylpv1pDRQXO//djdV0ryxJXKIhSJ+amTJ5I6GpY0B3eXzW4TseOnC6fRE9Q4/DftlrPPz4YH+6EIPJv8T7v9mRRJSDhUzKG5H8gufrYi7YuVB4MQ9vcLtA9HJpEtGsyNKmbcEt+3nv0lTVtWYW4S1qJiIwEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z10tDpSS7zcI1GcGPYySQZsV1uZOAqQBU2byh7kdAOA=;
 b=nYsR9e/xmiyHqqG5O63PHznpOiapLAQ2kILKo/Fl/4jfaPk/Cqkq4XLe4gWNt5dNirmc3U9VU7vIokegnUiJP0vtzZzAbvFop9Q1S/pknvMCOm+zXjp/XB+eas8aONX+MLdPO68WA3PBc7AoAnZ52FtAhN5OfV9jVGG/msoYDIN0O5DBL9Nh1ujaY7w1KVq+m7vKQVjcfOtMmE5UtLJ+ZNfF1p/VoTWDmxBe3tNE0v0aAo1vB0Yn4CJXy1kol1PbpnnCWiSxlozGrjn2cWHU6SfA5p1Zrt0e+l1CTxFou5bzNVOlvUFAM4B2EMS5+SG55d6MfueajoSMuYsGRiShEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z10tDpSS7zcI1GcGPYySQZsV1uZOAqQBU2byh7kdAOA=;
 b=pQPLRmpD2Ytspy0031e2bACmvqM6LTRfaWkn1bHl4YEfVT1uehInWrbQX0UcCvCrCBSW5ax0ECbrP1b+rnQ1sM6qMPPrr/FfspzOwfIbG4l8+LrG2LrMvy6gTSBcIFWVXOr7/rcZITd18cjD8nz/RlTe4wF0AOnWm1QPviJxkKI=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYWPR01MB8478.jpnprd01.prod.outlook.com
 (2603:1096:400:175::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.9; Thu, 4 Jan
 2024 19:08:55 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78%5]) with mapi id 15.20.7181.009; Thu, 4 Jan 2024
 19:08:54 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Support Opensource
	<support.opensource@diasemi.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Input: da9063_onkey - avoid using OF-specific APIs
Thread-Topic: [PATCH] Input: da9063_onkey - avoid using OF-specific APIs
Thread-Index: AQHaM7sSPNjMGyCnK0uUxJqt/la6lLDKGx/w
Date: Thu, 4 Jan 2024 19:08:54 +0000
Message-ID:
 <TYCPR01MB11269AA2B4A9372ABF78E5EEA86672@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <ZYOsUfKceOFXuCt5@google.com>
In-Reply-To: <ZYOsUfKceOFXuCt5@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYWPR01MB8478:EE_
x-ms-office365-filtering-correlation-id: 44d8e101-97ab-477b-79aa-08dc0d5898ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LecBiAMq+/nVfVv7uoxcya/B1Yx6x9I00jBIUcG4axQ9QDQWxN0GFahgIZWgJ3/7VpGOBWV0aDtGkfAEHKKuVJMZKqvunktR3J9sbyQgw5w22NNN1uMJnONhWO1ziCWEUZVVFXpTN7ZiitycZ4ydXpMLc8y/++AkH0pXgZNzrklA+J+8fero5n3STFzy32mT5N6ZZ8QJLBWbDUmUlZ2yXA1BPgcPNqn0NHBXu5DmtRv79AYH8rqGOx1wT/YLWMbMgET7Bh01VjwqbpcJJZ+gPSVhUqZyX5ldBKYJbqjHzGFKIGJiDfHti5PRwDUzRhtrTESpJ2eXPTpLLO+D8bkCHeO2w1Gg3U6MD3mD4nrXb/R/EHGhwrgV3/wIfzZp4l+YSo9vXDRxIrjkFiFX/8O8F0eiE4FnCdFMRPWAKLzFdIAkbQ6bFZO5zuN0n3FP2TJNp+YB0NDkUnh9Sh2b7S3S38LbeVqix3XyCMovbt9U7ijGIpF67MP2Hinx8NtEyCTiHiVwvCL4bgcsz+1Onmh9VjlcPpFasVhfOG9weA8TyOksptevjzVS+PEb1pYZld+znpEyt4/pQ3e+3z5E6MK01zam+6CN4ezVCVsxnBS+rWJmBq2kYmXhl1Z/O0btvHQ0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(7696005)(53546011)(478600001)(9686003)(71200400001)(6506007)(38100700002)(122000001)(86362001)(33656002)(2906002)(5660300002)(38070700009)(41300700001)(83380400001)(316002)(110136005)(66556008)(66446008)(76116006)(66476007)(66946007)(64756008)(54906003)(52536014)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qqx6JeGVGmHdSTKjrXbSguzEjzQTOi6P43Obxdf24Q8u4Rw3BBGQgztJPyWM?=
 =?us-ascii?Q?VRbhpHR9HUjEyq3AC82vhybi5OLPaCqPWE6p+j5iTphw3zruYN0bbNB+3J3x?=
 =?us-ascii?Q?adWyOCj0zT05Guss9thOUZVTZK7z47PAeREZQA74lqZSA2ZFQOaWmuDTAxRD?=
 =?us-ascii?Q?+p1qsh4eSPeT0zONa6EfSDPbvDP6RJihjUUniBIeYy1U9A37mqODOlJ79OIn?=
 =?us-ascii?Q?b5GVtj8e1NabKvJ6mak/no+J+wxxHJdxWPMU/Rz9VPZs3Lc0BpRGLNaPFjsZ?=
 =?us-ascii?Q?cbz4q5zCKm0B0AWlP/os5s/Du1LYwVTMnznxofy6k2jxHzKfqr9URMFfVTXx?=
 =?us-ascii?Q?mY0duzhSgdyuV/VEXC20J9DY8VEnjklglSRUEP5G4IiR/sLcF1s3kQJCpwv+?=
 =?us-ascii?Q?b4Xp+zspO5Eupq2fr5xz6X8zQ0uiDA/5RN6Za3utzzMvsjnHIxH01aVh78JT?=
 =?us-ascii?Q?B8vJmEMJH080O9mqyzC8sGW5zY8M9DB1Jah1Bsf0p5E8FAzCr4a/bKbDU2dw?=
 =?us-ascii?Q?G6tzGYBi++yMEch2hphOh76ZfQVeF7JJAkM5pCW6OlWk41eLuacZXffml2QH?=
 =?us-ascii?Q?7K7uIbWlA36S6wZzZePQ4lXSgVrJ/d0bKi/N4DgQ8YEf6yX1p2IBOAqfBqDB?=
 =?us-ascii?Q?LO5nZ49miSKs5l4jwjEbtPQNz/p2olxOvfaqeVEOD5XsNGF4xv40s/m/7YXh?=
 =?us-ascii?Q?EyVOgI20zRXRu+CRQQyFh/NeHot0/TaL+JcaEWwBpN9IzEEn3NSowyvYpzL7?=
 =?us-ascii?Q?b2oNhiHA3kuKgVTje48vtnQpOdBxt4FJ7C8tdgHxTzOfdYrVgxcX0/iVgE1K?=
 =?us-ascii?Q?rEpLmB0dWnQWxJjIf6M7Yfo8stI3EeJNCmO4h/EhUCZ10JHyMaKXPLnuu5w3?=
 =?us-ascii?Q?kJDP5s6K21XxpJ0J02jPN8GTo56WUq827jYfAPiU+fNJnWowzkvGNVsAGY0i?=
 =?us-ascii?Q?2WUAYA19Sw2xqYcLop9sa5k8PF/SMSP7Nr5TMIQZVZt9bn7kry9WyjFaJw8E?=
 =?us-ascii?Q?M4W8h+/Kly00uun+vcB96xeXjVslYzhVwnNHJQmsMyLRGkiGb5eDXh7HPXYn?=
 =?us-ascii?Q?hDJHO62t3tBh+3UtTqwHHkOH3AVSVHn44v+YjTIME+3qisYT/fs76HSjUgHJ?=
 =?us-ascii?Q?B59JL0o9FZXk2QgaOWh2hLlagrQoepcwPTvXWPdOJR2Yp6oG2ssfS0tscCRF?=
 =?us-ascii?Q?GhEgOjXO3wAC1a/3m4gU1SjVKxSpG1TFVRA/0XQa5/yltg17ZpBu0JBxlrT4?=
 =?us-ascii?Q?5AOzHxe/hEIGyl4AWwQIIDLN13alwOQ1kRnPEm36rWYWvvhHHt+Q4ptIcqJF?=
 =?us-ascii?Q?nYAPEu+5bIP4gijwMFPBnZHkmWEMkRe5qkoAUQ5GupdqVvjf37v34VrE/hqI?=
 =?us-ascii?Q?2UAV4eQPHvQAyM0KuCiNpIEPtSXSsnSj5IvchMo8qgzZOp9NkEHagq9ooHpR?=
 =?us-ascii?Q?98IRYbQQ3/eCoZdZrbIKvWhJlWyECRJgIgtq7m+qHQe6J8MJ3sSzzM2riDKQ?=
 =?us-ascii?Q?dFXZQG427yRX51kJeZU1tHKj4WQJ4v2XLiz6m91dJxg5YDo8nvqolR5ifF/K?=
 =?us-ascii?Q?tgY6gfTRnWk7WlpnsSk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d8e101-97ab-477b-79aa-08dc0d5898ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 19:08:54.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksak0os4MU1PVVzcZqXx5B11j3f7ftEBeDGPDjXJcNZO/2T5U3AMaPRCayHWuZRNh0Qtrv2vbtfYq1tQ27XoAjy16u2yq/6pU5RAALD56ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8478

Hi Dmitry Torokhov,

Thanks for the patch.

> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Thursday, December 21, 2023 3:09 AM
> To: Support Opensource <support.opensource@diasemi.com>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] Input: da9063_onkey - avoid using OF-specific APIs
>=20
> There is nothing OF-specific in the driver, so switch from OF properties
> helpers to generic device helpers.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

> ---
>  drivers/input/misc/da9063_onkey.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/input/misc/da9063_onkey.c
> b/drivers/input/misc/da9063_onkey.c
> index a8b7f1cd0ec2..ce499c28a7b2 100644
> --- a/drivers/input/misc/da9063_onkey.c
> +++ b/drivers/input/misc/da9063_onkey.c
> @@ -9,11 +9,12 @@
>  #include <linux/errno.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_wakeirq.h>
> +#include <linux/property.h>
>  #include <linux/workqueue.h>
>  #include <linux/regmap.h>
> -#include <linux/of.h>
>  #include <linux/mfd/da9063/core.h>
>  #include <linux/mfd/da9063/registers.h>  #include
> <linux/mfd/da9062/core.h> @@ -199,8 +200,8 @@ static int
> da9063_onkey_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, -ENXIO,
>  				     "Parent regmap unavailable.\n");
>=20
> -	onkey->key_power =3D !of_property_read_bool(pdev->dev.of_node,
> -						  "dlg,disable-key-power");
> +	onkey->key_power =3D !device_property_read_bool(&pdev->dev,
> +						      "dlg,disable-key-power");
>=20
>  	onkey->input =3D devm_input_allocate_device(&pdev->dev);
>  	if (!onkey->input)
> --
> 2.43.0.195.gebba966016-goog
>=20
>=20
> --
> Dmitry

