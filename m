Return-Path: <linux-kernel+bounces-82583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B58686A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66668B2277D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2664FBEA;
	Tue, 27 Feb 2024 02:17:08 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD74A2D;
	Tue, 27 Feb 2024 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000228; cv=fail; b=HbDhCZR4pgrWT+w+7T/70gw8bTh0E8SV4VF9f4rkd63eVsbyT18q1Rf/16hXWfCJZa0CCT/rVqMYyK4SMWZagegwxoXz8kv7z0IZIlQx3axZ4AJU/WM9V3futFAikadDsZ0I5FPeV+X21otP0zZ5oi82pFVP4X6NLZHJJt68BG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000228; c=relaxed/simple;
	bh=uP/uCjvH8rULe/GeZo6TBM8HDRbxNQedOIwo23BFRqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jOr7C+sOO4ZbzbBRfJLtM078NVshICJSdgw+gnKt2KtyHPbKoWKFJrGO940+xO370OxNmeOSW4MD+Unxx+OPNj5Q+iA05kPaPSUb3RNXFqpkLDKESiiAjkt7wYPQ8jeORQmR9Qm9uT6HZ699jVdTDtQSuEoPtF/bphiAaqR/xAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJG9ecQIg9BoowzmRPvbSTBUS/2l4xo+uU3Q3EKa/bIsvi5Gaarh1QtARuqZqcN0pW+oj4qzgkBIZcZdXm47MjiH/vuzAgQBCA9ISfDYI0VjzZoyUvR36midWKwua1WyqWrc/utw3MxDCskT8yDqMgiTEIHWSkaJpSn7uK6wJoyY9a9H/O9Ew2dVLCT8nQ09DIZ5kntcIxxeyvkBS6LRrCZQBcpG9VOfS91utNTzox2bLgQk6bg4rUA6ftQZ4RQu5ev7ZZJLR8IGr5dCYniI8EugDnrw66w/lQONWR2oFQqaCKkH3Uy+cmycUQHrcO5ulDDqAgAzy0G8gcKCuT0ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP/uCjvH8rULe/GeZo6TBM8HDRbxNQedOIwo23BFRqI=;
 b=UgPHHBfP5Q4mKSq+IdmS72tKrLAU8pnqCzI3Pg261Iav1NvNq1AQfyA3jy0T+/LhiUscXkaXqZGp0fX5Y/jgrRKJW4RJtMnwH6FIF+UQjwUa1HcjR9Rq91Ak/f17UasuHluOpTtO32ixq/JWpljup41LTeJ+OdPjVehWg8pZC5eymdJH8ap1ee2XYltimbDlvw3RKLBie2gdeK9Vl+V/AxEgY/JPHtOQTmVe2wOhVVVAqo5FMne9fiG2WogzgIa756RQhEG4Pg9j32sWxhdOuBblqGg8FE0KfhhRZcOblwPBkAFBRjP3kaoVq3yNQYYHFYXqRJW3eFi15ykjW+ad4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1304.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 02:01:11 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0fb:daf7:3f8b:868c]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::d0fb:daf7:3f8b:868c%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 02:01:11 +0000
From: JiSheng Teoh <jisheng.teoh@starfivetech.com>
To: Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, William Qiu <william.qiu@starfivetech.com>, Leyfoon
 Tan <leyfoon.tan@starfivetech.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH] dt-bindings: pwm: opencores: Add compatible for StarFive
 JH8100
Thread-Topic: [PATCH] dt-bindings: pwm: opencores: Add compatible for StarFive
 JH8100
Thread-Index: AQHaaGW7VzRQ9wtUqUKZWkKdga1H6rEcRfqAgAAecoCAAQwPkA==
Date: Tue, 27 Feb 2024 02:01:11 +0000
Message-ID:
 <ZQ0PR01MB11608585A27081C61ACB93F8EB59A@ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn>
References: <20240226033945.816974-1-jisheng.teoh@starfivetech.com>
 <opzxowacxsagwgw3l33p6y7omzjokus2bi3ol5wizfwjwi2s44@3p5frb4ysji7>
 <20240226-greasily-balcony-cee5014f5b8b@wendy>
In-Reply-To: <20240226-greasily-balcony-cee5014f5b8b@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1304:EE_
x-ms-office365-filtering-correlation-id: 1296ecae-ee53-4433-d698-08dc3737f877
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IK5Tbh1sxvxZn26uJxcxnJM7ZL4SlLvHrzKExe0ML2CDv/NfMNEpDsg75RaqmBoVk3zBp8AmL7YK0MvfmtypLyZwa5LH6b1z2rR8N8cOCPnX4anH7Blok2E207EYQcgr+LRG0cerauKo6BeWRhls0MSfQXIr5lFPztpZkyT0kRNdhQGOy1dYjetxuoRiE2MNVwUQa3Nlj0y7NoczmcKzO2LdnOIc2fJfKaju5t4p/qpCyMjTVB1DbSRq2XnwQWwndJDEoF+ZuhS8d7FzA47atxIhhQLLXZ/kLkfsbriGEBUlrISSBmg3aJ/g05jGcMV/O9iedrfZMV1EsZNKEFYprdDb4J/oEvB6WJVqkxt0HMWz3DDxSUvnS0BpxRra/WSwwKiLMzl/+kDF6P8LtFcm2gum/MPUXNd+5vuSaLiAkTfKHVaTmqs2IjnetmNpR27L9Kzsi7vztWRvQx3/Tf+D6C7f64feVDzWpCjNrgy5N/Gc2Z3nFoxNg2BREf6nMxskCwxKaZQ3fOD1zepkpvJloj0XGU9ERL99yIIB77MRDzOrxhGzdhzVjEvfgDA5qcsZ2cYmaYqlRQZKHpPjBmwxNoBfxPhPvBw3T5ckeofqdnL3CxIJoEAr9eg6xkR1oukQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XEoGErlho1AAYwB0dDidiqhs1+Y6e1cUZeTMYVw9KHepCsR0b290LfpRXj?=
 =?iso-8859-1?Q?Ez6eLPoQiqQCzUedHBDS29GRLhSQGwTSCA4IHTuIvuw2bihFjEGauVmzWa?=
 =?iso-8859-1?Q?UfOR26Ru06QU/W6CnmHoyQsS16LaT9MS5CDzOp+F1T+i+Q28WM1Eb3NCZJ?=
 =?iso-8859-1?Q?PoZfO7SvT1NnoXwFLDf9kd0Vv7WKJgeQjDKw6xvq3bsi+iewhIl5m2rUJI?=
 =?iso-8859-1?Q?pg3MVA8QmGghXVfr3livsfBwETWSo6S6YrAiDeVXXHlGeCsqT2x9Uc4ZCf?=
 =?iso-8859-1?Q?q8hqr28klkSmcklCTqigjVGzt35zYQ4OcZck4h1CcL19cXjpV3cfH5R6Cg?=
 =?iso-8859-1?Q?nPanzc6QqTsDiK7f36H405AcRT8pov/MbJcRLPQ2Fa3QCJfvegsHWisslM?=
 =?iso-8859-1?Q?HEVGdSpV9/uPj6pAFgva8b/p3NGfgUm/gq+ttULlFJmOBVLyS+nXtvmmc3?=
 =?iso-8859-1?Q?ArwhsNAbEdqKRY1IRdh5Tha6Z+Pe+DF5IIX45VgMqRvd8ZuNfGNZ4eJtHF?=
 =?iso-8859-1?Q?iVEd6CCkKZAlDHZUlGZiIEq1vbw7ATJzynbaC1uu4kzCr8cRPjuC7WSUw8?=
 =?iso-8859-1?Q?EAAXDOktLei8woulHC3kJkWqHq1zhwg7FCoko1viUW9eOoFdinZkFuWRXE?=
 =?iso-8859-1?Q?1a8Wi0DVk8RPsUp5ARsWaka/JxMjG4Pu7jr75NxsvD6esfp+/I10eZtjSY?=
 =?iso-8859-1?Q?QErTLbJF1I21xdtVtYy/3QSC1eZ1KNGmmtuNXkyt1p8Vw+/UMq31q1Hwbn?=
 =?iso-8859-1?Q?F9Boa1V9A0G2jcq+5dMeNHLhdrvSpH5T5aIz2ncTysde9p3aDcEwnf1B7u?=
 =?iso-8859-1?Q?cM9H7UZHsMPEhrjtGQPh8BdMok6Vc/sH2iIIGsq6Trr2+oAtVfZU836GNd?=
 =?iso-8859-1?Q?HQzhmcoEr8Z/LsnGbkngTw6OlCp7dg/V91WCzeFPyJi8FDdKO7ysaRWwI/?=
 =?iso-8859-1?Q?R9SwWq3yUFKoYEVCQrzLOkqEuHb0CXcPLIaIV9C38+kkl0hfyLL8OTs5wA?=
 =?iso-8859-1?Q?XvH5lOw9eGJA2NYpAbiKA4KZc26n/+qyeblhKfhutZkGyyXA5zkGzP7/tN?=
 =?iso-8859-1?Q?WYpugOA9TUQYCODKNc97H7IMS6Cs+z356XkT4CGzNsyFXcy2fuA6I9NnVM?=
 =?iso-8859-1?Q?R6Wim7ztR2id3ZMbN0oCbz/adoIWCR3pMy1UtNGUfUJC736RHb4FbZ9ldh?=
 =?iso-8859-1?Q?/NYEpVEoSgQziDUcqFqNFDT0NYh7BC91dSppG1oJARtuFm6KcCTUi/ZU2v?=
 =?iso-8859-1?Q?Y/JqUG+MSIFVr+vfJlHwyQsotiM178W5Lscuq76aA6+N4p3mXfa1lt9F5Y?=
 =?iso-8859-1?Q?w6UZtBMHmGnkjHKRd/pZs5Dur9sF99aMWRXVvPbs6qZOg280kY1xxeRvRQ?=
 =?iso-8859-1?Q?MYKk3/0jfOIfxw8b6uo3lFb9zA6f46WMhV94icTBbLxjEwka+xb/t6RkW7?=
 =?iso-8859-1?Q?VbkUiOQ4NuYRE8Iepbvac/FWaB/mm7hLI4K6SXqFX2M+k3YwNPQpC+08e1?=
 =?iso-8859-1?Q?GHSPBcJm0psYDWgfxJzoM+CBGGDXurlb1muLD3iP6+BJ0WzpG692yUhqy6?=
 =?iso-8859-1?Q?P+68AqWqbEKhtIstPn8Wi7bnf5NxJKrHZlAib8NeFbkFYdBDtITXbuDo+f?=
 =?iso-8859-1?Q?H08aQMPoQKYaB/tB5UOszG9uqczfd0kClfRmSBWpFr9dWTAKS3iAnfuA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 1296ecae-ee53-4433-d698-08dc3737f877
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 02:01:11.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jAt54IDIELoJSMHu2ZclQgbHUlAiS3QNhpgrF9wiEDPyCmdRl8kaC9V2bi9esCk+ZNT0Fu0+cSa82q1WPK+IiPnWc6YXmTIVDWyP5ey0D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1304

> On Mon, Feb 26, 2024 at 09:11:23AM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >
> > On Mon, Feb 26, 2024 at 11:39:45AM +0800, Ji Sheng Teoh wrote:
> > > StarFive JH8100 uses the same OpenCores PWM controller as JH7110.
> > > Mark JH8100 as compatible to the OpenCores PWM controller.
> > >
> > > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > >
> > > ---
> > >
> > > This patch depends on patch [1] ("dt-bindings: pwm: Add bindings for
> > > OpenCores PWM Controller") in Conor's riscv-dt-for-next branch.
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/comm
> > > it/?h=3Driscv-dt-for-next&id=3D2529085831b01fcd02ff58ab4e2596d3b31bcf=
80
> >
> > I recommend to make use of git format-patch's --base parameter to
> > additionally(!) make this information available to the build bots.
>=20
> I like the "additionally" :)

Alright, I will take note of that. Thanks=20

> >
> > Looks fine to me.
> >
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >
> > Coner: If you're happy with this patch, please apply it in the same
> > way as the initial OpenCores PWM Controller binding patch.
>=20
> Ye, I can do. Although, I suppose this is an example of why the driver ma=
intainers applying the bindings is preferred, even if the driver
> patch itself isn't ready or there is no driver patch.
>=20
> Cheers,
> Conor.

