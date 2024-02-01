Return-Path: <linux-kernel+bounces-47733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 691E1845211
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A821F25383
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C486159599;
	Thu,  1 Feb 2024 07:33:08 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2136.outbound.protection.partner.outlook.cn [139.219.17.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25276158D7B;
	Thu,  1 Feb 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772787; cv=fail; b=Nzjg3VyKy0Fx4k12Nj77PrEnUAP1mHKn0zet/XeAmIj5kHbL+20tJlYQp1bENQ1+2adiISE1t8P+aGzMwu7+cxbXz877U8/M5DIGGF3rziMsuOGlmqT5MZhqwcilyImnc1vsnSGG8+/kIpFG2ZAjGuCKYtXPxVc+ZLCubmkGzWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772787; c=relaxed/simple;
	bh=xmraogjip6m7bJrszvn6WNjxoBSDNtQi5998mdZB92k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ldlktb+kKRQIBzFvKzqWEJC7BjKyaRQv5nXskt/u5I4xBQUHix1+5APoIoZM4yA3HUGuHaeaz0Gcu672NB8uuLz2eJ7MMO01zZ95oEHeSBeEXsAkp/N4mEe3HcaAXHBZ7dVVg1rIsJx/2xelweTpjgVI+ps5VdUys/YlbM/eKOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9KOandXHsYvncD/wocBrO9ajxSMe9ri+HPjz20xz85Mq/CXy6+ep9O6vMCKmuDbTCmRlN8jmKzmXnl47cNdlXG/rNVbQTGeBd9gr55NCWmt0b6NbQzCZuAGLNEim24wiyqqi2EEmZ08iEsE9NiVuA+WCBB+eTP8DvsRRk93ADOQ4vdk7N+tseVqD0tlRY78yS+GMZLTTl+Kdqflrpy5zEfHCySfY2ydn+i+K5EdtHYRM4Kenn9GXZHDIjLevZ7uxWn0OSaLNq+kvNwuOt/lbvR8rUqHkYjrwIR1SlYk99mqvsWZJ2URgG3su/ZKBJFiW44PsEbfzLfEj4gq2AgIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IClRhUYUEeQsCbYaL7NRZzgSRJX5wzKdFnMlozQyGAA=;
 b=N8qGemhqYGfLYNEHJG3C7TYqAwjnYcmCkAqKhxQZuSwbKk3Kc/q7MZmr3evJ+cQ57GeZw/jpNw5gcS52zLoV1s0BTSgOkBWOAB9xT0QUlhl/eA9yrdybu8EQFZ60E9dFB5zPBYxi31DVyFlLQ6O6Uq0FLXNICBPrfMlMQeIQBjIFmYDjUdzVN5eiYIbJWSiW1GhWqClBPocJUPDx7LfQwKKVFy6hjBIh6GgQolXCS0g5GpSfrlezUmeMEDiVr3vir1N1tpg4S4oXcGKW3QkulkLdNu/7qnsOF46syNjDgk9n9SUD0LMTjQuzDzJ/M/O3LUfmlVOauqN7SN03o2tRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0589.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Thu, 1 Feb
 2024 05:59:02 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::f66a:7cf2:72ea:df3e]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::f66a:7cf2:72ea:df3e%6])
 with mapi id 15.20.7249.024; Thu, 1 Feb 2024 05:59:01 +0000
From: JiaJie Ho <jiajie.ho@starfivetech.com>
To: 'Herbert Xu' <herbert@gondor.apana.org.au>
CC: "'David S . Miller'" <davem@davemloft.net>, 'Rob Herring'
	<robh+dt@kernel.org>, 'Krzysztof Kozlowski'
	<krzysztof.kozlowski+dt@linaro.org>, 'Conor Dooley' <conor+dt@kernel.org>,
	"'linux-crypto@vger.kernel.org'" <linux-crypto@vger.kernel.org>,
	"'devicetree@vger.kernel.org'" <devicetree@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Thread-Topic: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Thread-Index: AQHaSFqmtg6Zzl/qkUuu0ddSCEXpi7Drn0sAgAgJJNCAAWlFgIAAAuxA
Date: Thu, 1 Feb 2024 05:59:01 +0000
Message-ID:
 <SHXPR01MB0670720DD9EAB09EE8A1B13E8A43A@SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn>
References: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
 <20240116090135.75737-5-jiajie.ho@starfivetech.com>
 <ZbNCKrTLXmPcsrSH@gondor.apana.org.au>
 <BJSPR01MB0659C3FE1262DF8CC7F7DA468A43A@BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn>
 <Zbsu39gZn2cGrnew@gondor.apana.org.au>
In-Reply-To: <Zbsu39gZn2cGrnew@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0670:EE_|SHXPR01MB0589:EE_
x-ms-office365-filtering-correlation-id: dda4fa90-3708-4b8e-f776-08dc22eae3a9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kg/90HdFbYux6mmgxsz5R18waTJLdL6alx6EIxUNdtwvca2iKWEZmYcHzoEqZkH4WapFmBMKP2cjOo0D9XpJ0tScuZLEaFPfMuqf9yahQpv7EMThqtzQM0QV2LhuYBwd7pcQJlhxwUp6bqpaHE4UjqTUYsMIKH45t7vp1qJyNY6hdYD2uv6C3Q5LAiLBrShs8HTEENo/2fy78hgLcD4WQF2VXKRi15RXH9CNYwKhk4chhN9ZzlE5VyQ6ArBYJ0JK0CU1Xi28oLOmjqbZgUnH2kPJtB5hEbvkfU13Mv9HQbYHn5syi4WrFg8bwgS2O5rX55Yi+T6wM0TzlaAVoJY1aXQNbTmcaVE4NwiE1LzrlhneKACqiC0MH7Qi4NRb8lZ9KgQYmzAVqkylZeslJZbmV/Xi3Jygwjja4quZUV3oN51sDFPvdrdOHsSXZOvqGQ5kKx/SQwqS8JPErMOCrig4cY4us7cHZC2Q4GoxSBeNTcboa4uvsfl5BzC1SF5CXwd0J+pybNXBEIbureC8DQTnJ3TsBIE88pmmLbMmBFCxxVXVDAeWiuKF2kaqzFxBMc8t
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39830400003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(4744005)(2906002)(40180700001)(41320700001)(33656002)(38070700009)(41300700001)(6916009)(64756008)(76116006)(66946007)(66446008)(66556008)(9686003)(54906003)(66476007)(26005)(508600001)(40160700002)(55016003)(38100700002)(71200400001)(7696005)(86362001)(122000001)(4326008)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3drY/i/lORMIawUZ3BCEmHJ/tLVXVfj+G3a3PJOcFo1jFIbPOd0SsrQu9pie?=
 =?us-ascii?Q?7snbSFbCtHBq7PDXWpAUUvCX2Dl/AKdRBmRM4Vpmt9eO9Xpe9zr0QHHyCNEd?=
 =?us-ascii?Q?2cTgan3CETOzOSvccpo2iLCNaDbzV+LCobZFk94TpeXtP0li9b5boIoitQ8n?=
 =?us-ascii?Q?gtQaz8chxajVOoU9coT0XiP87QJLsI5z048YPNE8MO6285dpbUEeN61JiDnV?=
 =?us-ascii?Q?lzii+waWuLZQhfbnzTaDDPRvha0hPV0p5TxzLFKTgowmIZCKIZ63qjbwhuJX?=
 =?us-ascii?Q?n+3ONOgCNXUff1KeIEaMq15lmMfZ+n+F9VpyUu1okR2vsOJyngf5Agin4hWJ?=
 =?us-ascii?Q?2fhMzBfBBu1Psi20g+yQaRUf9tAbPhLJSWG8S3qiPAfJfoJ6bhqG0SKXSicF?=
 =?us-ascii?Q?Jo4FfGzROLhXhK8cqD49zd5StX7mperGr+e3oZ1lcfx2SyBPDS61kB+F8UtT?=
 =?us-ascii?Q?ZtGUMkuFO7iMD/zZ2+J/uiw4s+PvDXg/X3DQ1Rc8FDXzre+PJo26DlyAyt5D?=
 =?us-ascii?Q?oXtEmqfKB9zH8cqXVmUxs64VU3IuhSpnm3aFYRr37562fjfMammP/xlwklQE?=
 =?us-ascii?Q?OGTkn7YUFc8g3P96QSmeOVreziaM1xcxnwF/y7tpMtoIaRlsZSjLvFbvQLWy?=
 =?us-ascii?Q?e11nRYsWfkXd3DEnbG0AmnO6IXy64K0ESj2Pu0fIOmZbJTL+jfvxnEgPxSco?=
 =?us-ascii?Q?ULXAHRKCiADG+Y+2kp1ISSk/xGItyl9TbzlbHtyWKHJta3LoiW7ds12yOsNu?=
 =?us-ascii?Q?LTCKOf791pJcCF34tTsMVNHFry8v1rn055S7gOjUlK1ZOpQ/+McYgvu2UEXR?=
 =?us-ascii?Q?36iqR9ddz/mYBYHy3XaJh+vhBZv7ZytgPY1Lq8syMERpCEt+3D1JfLAcg912?=
 =?us-ascii?Q?qUQiFLsAdVE2zDPBH+j0GkaJhZavfvFERu/ilHq/OdMkaSvWqnQ3JC0ciI0r?=
 =?us-ascii?Q?lv3G5hu7wp5VuqyEYgeRNDh7Jp1x+KD0fZqaJLkqwWtirgbnJW9fytjyeLsv?=
 =?us-ascii?Q?ioLCAvNfGsyd8nKNHGkHLApqJKIaVEThNHqzfgKMTqGly7e3lBvs94bQ1Kvi?=
 =?us-ascii?Q?c6xJYlPopX/1yvmManhcIqFe+p2TJfJaTTUlhPyCsQ+sXJMwJb7k50tZBHJN?=
 =?us-ascii?Q?d24mCMOzaSgkUESpf29CWPH6Va4wUdg4vXmMOOFV3oGcFnfWNnXAkXhBg2zb?=
 =?us-ascii?Q?GI9jAbDoPOJW5tiu+9+pgcslivzVPTHgN3/nZzXfHHT/4w+Rc1Cag9ngtDnl?=
 =?us-ascii?Q?crZSudpQvn+H408NCl40Cd4rBbR7pBMV/GYn1vgSMkWvWZqB8z+BtvfdPtfI?=
 =?us-ascii?Q?ATFGx90GMzKkg+JGBr1JKKH8TV5hS2Si7sZFHkVo01Vmt39oCovbN0KKjtO3?=
 =?us-ascii?Q?/7GJ/8DWsayEffbLI/Fy7jubkR1FikkXsxfID4WV8A+WOIFry++Rw2C4p6k3?=
 =?us-ascii?Q?RmTYthrPqMiXzH9DkRqz4RsvO4BwH/EJbYg8zmzecl2qusef9Gjsg1f94yPP?=
 =?us-ascii?Q?5B7iLbsdUGHOmgDVn8EsBBZwmz4TbygUndv0ei5Rj8LnBEk5UK/On4+PGQwe?=
 =?us-ascii?Q?OLDvaJshMbhXEhv2SJlQYUMVSBXEy+iH/hCrTNkP9+vYxu6k4r2gl3SW/0Gm?=
 =?us-ascii?Q?Hg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: dda4fa90-3708-4b8e-f776-08dc22eae3a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 05:59:01.6803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzWQFaIjR0oyT7QUI2KHrYPNcHxKZSObR6k8wo57vnFWPLj2TBo2a5ide/tW1x9ACLjkdQYQMUPun0yR4AsIWWaizXY//vSzCzzvj7Ogvgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0589

> On Thu, Feb 01, 2024 at 03:01:59AM +0000, JiaJie Ho wrote:
> >
> > I am using ifdef so unused codes wouldn't be compiled into the driver f=
or
> unsupported variant.
> > Is the compiled driver size a concern for such cases?
>=20
> The compiler should be eliminating unused code for you.  Is this not the =
case?

Currently, the object files defining new algo register/unregister functions=
 weren't included in Makefile for unsupported device.
Compiler will still check for these definitions if IS_ENABLED is used inste=
ad of ifdef causing build errors.

Best regards,
Jia Jie




