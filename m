Return-Path: <linux-kernel+bounces-104551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199F187CFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B711F23276
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571BC3C680;
	Fri, 15 Mar 2024 15:02:40 +0000 (UTC)
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020003.outbound.protection.outlook.com [52.101.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB01BDE0;
	Fri, 15 Mar 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514959; cv=fail; b=Iw40sWZN2LmtOjo8UgGMCZDn6SqcZuDdjBQbnmyyzgVvA/0EhM7itxgutsqGNTX4NL+Q6xetW/PLjtNhKoRFNfupbJVlcKWHejA6qRm0Nn+Fo6SQTzaiXNDOp0rUGBPaNZAdBUiNCHGMdhBPYEu1bGRWIUUcRMDuYf+MtyVS810=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514959; c=relaxed/simple;
	bh=44Gd69tslcHERy5lERFJpGyNA5JCYJMhNL7NRhKTKvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nmlku2Svn36RH51UKUpgSp6cLIIHTMvXYwMSy7h8DCAASOvAPxqeOANudbYNmSg8DeONDjY0ykkClzCT+EafWrqesEpXNzA/Mw7AcHwUj64lpEwtstUFUGs0UV/wasyiqqYfy5aDJV0hj4nYKuj1pX7+WhX81yA6xq8vXAITLNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvKXWN90dg/3cLJHgzad4P0/BoZGx1YTp6GQHpT3n4MgAYlKQ1R9PbhyZDKL5TJym/43CUKMi4DwOhRO8hdgS70QyRJ1hoFN8rIgcnDVrLqa1lyQSKdmRHvYh4h+u70OMFR//UaxZokcoqP4chFjueVjIZ0jI1HoXVqoIoL+F/0cczz4zrGY6f0lsTVSGIzEY5oGWZLDmUSueRWjPicA86u708rlC9HoKvTGDdBXVMBrTtAJs47e4ilOnbc5Vho7mRgDPPK8+32eoui59e3yYqJrhsVDeGOXKlLLYR6gzPKvsNvT0+w3GHHTF4H6Ji8gbCwdKQfwUjv0wA6ltciiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj9yYpEFhQ97HDuWeWMkR27ENtZ/viDMk289IOr/fpk=;
 b=AIYDTCdElYgv8HmgHcYHKIb1SNJ9e1aTTvOJaF0cHQ8XTKnsk5vMezX5hM/VwkbG65KaIZ3SA70Qn0o9jxf6iJXq1YO84jjbcauK4ZeW1n4uANHlF1J5xWv71Ys27xJtVmPxvo+gOHN+L8LPhdjdS+qk88hyZmINgKcIvGq8vJo3zIlIzfI+/d74E3sc4X9zaSDi3joXGoo5cZAMOHW6hW8fA32g/lb5m3y8e/bjmjjWYuHWp51DHtE7oNwqSa9Nnu5WZx1L0PRd0qsCXCUpVG9EKK8KyYYa4gkwrr8x8hzNoW33727obvr8mIZm/Uiq7zXarwGATDNXPWgR6uXAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1df::8)
 by MA0PR01MB8804.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 15:02:34 +0000
Received: from PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::ad41:a27c:4185:70f2]) by PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::ad41:a27c:4185:70f2%4]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 15:02:34 +0000
From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To: Dragan Simic <dsimic@manjaro.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Lorenz
 Brun <lorenz@brun.one>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: add &gmac2phy in rk3328-rock64
Thread-Topic: [PATCH] arm64: dts: rockchip: add &gmac2phy in rk3328-rock64
Thread-Index: AQHadrR1BtvEvHuwW06uVnwsXYgXPrE4f/8AgABjXK4=
Date: Fri, 15 Mar 2024 15:02:34 +0000
Message-ID:
 <PN3PR01MB10135290B74FD411720E431989A282@PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM>
References: <20240315084018.2200581-1-himanshu.bhavani@siliconsignals.io>
 <96a53f8560b3563328eaf7b9d6f63d87@manjaro.org>
In-Reply-To: <96a53f8560b3563328eaf7b9d6f63d87@manjaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB10135:EE_|MA0PR01MB8804:EE_
x-ms-office365-filtering-correlation-id: e68c8753-79dc-40ce-557b-08dc4500f1ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FjwsAeemIawAwhSoYEgUd7pue33r/QchGhYjl7ae3v7VwhEg8wPVnk688hVvExtVnUy3VDzqOPgwbBPdHhxoxP4Qa0qEV7mzvj+yKw6bhRia9BRRDyMYygsgQpxhcWAVs3cz7E1ayR2FI4gs7NZc3lCFlp/UirZoX/BixuxrvcFIKVVHSzbt0SqVBDcoDKeMp5g2TGoX1iOWcDx5KFAlZL183J5rNXCFer0dkGIIwtf5Vk2wSv2zGY/HGyDGSKDDwZexO6XZkvEfvVVEyNIriOBvNyHmmZqn7NuiA5Iju/Pew8fBHA3+uv0O03CcG16IOAXGnhpihYRip67996AOV6Vx9/3t2z9/saoZ28RvoogupIv2oDnJ1D+G5hVtsMEuW3R0zSr6WGjWbi+q1jhVLfyRMbgO3yHL1f6m6Z1RX1a0AeX6hAae5+Nu0BzcA0mOqZi58wikxz3AO/hKtnO/S2z2TZecd8Tv8jQadRaHkyuL4DewPLZeknQa8o4T30U7aKGdlCv7RB7iQWgQHuIXRM8/YNCuxbxhvJlEUlKVAKpNePd5uQjs27YwfSPC3h5bvRDb4Ow21884JqwVh3aTSdTMTtkzSpu7GYwZNn/q2fZJLpev6ddg0rmGIrkgkvLTn1R/FdW1/gSrc68IXUIaF9Sj3IWPjUCswMF/Isk1xhA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FAe8+KxCvjU4wTOwuPWjJ/ZRIdOUKjtGq9sE/7A0+ozV1fbuio4/jGmMvK?=
 =?iso-8859-1?Q?Aq7pWsAv5P0YHJ7A2201KQvTFpOyhVb+75EweTjzw1XZU2r6j5BMZ1grDQ?=
 =?iso-8859-1?Q?SfdAgwI8d9lR4Id2gI1M7d0kLp1NRrkWgrn0yPLdEboaT1flx818UuIImm?=
 =?iso-8859-1?Q?nR9hKAMnGc1Y8xzpiFpTysJ2clKI1KUK2bB1220UX41CLM6NGHM9A4wUYy?=
 =?iso-8859-1?Q?SIRCNAw47Q5s7yHfzIXCvwO2TKZgZIuwVR4AG/jphfugfBjm7MuGecPGdt?=
 =?iso-8859-1?Q?QlB0+0hbBd+ROiI74e5nbCmRuUIvK4I0kGWLOdgbkKd5eRCPDN0M0i7Ok0?=
 =?iso-8859-1?Q?ljdmueyEiYuzqJYBIw9GTc2+rtLj2VoXp0RVuAxcXHUtCXIhMVGSAQ9v30?=
 =?iso-8859-1?Q?zOQwEJBeaJak0vI4hA6Sp6ZU60ehpwthOXUjBKa/2Cq1CU1Oht7DRrH3og?=
 =?iso-8859-1?Q?7zcmphbhk+EQ9owt5nXk0FYR0gXEU6I+8lVLSzwCXCy3JkRzL5Dm1busZf?=
 =?iso-8859-1?Q?IhwJmak2E+kDYPLP4MmO97Jp9sTK25IHyKvX/CvhzNJ1ABfZmeKJe//yJa?=
 =?iso-8859-1?Q?IbdTPsPNFKLlalNmUgsDvwJJNUcb3nFPnD+rucJqvOa+3BOWzo0YhC5rXB?=
 =?iso-8859-1?Q?/CoXr4QnZAQXd6jiUSHrmRVjKe2CghEFmLDXFzlHy5Ig8Das1PJybmQKsj?=
 =?iso-8859-1?Q?uvGC8WIE/JR6VFDVLy2dJqZ02/92ONfIV2wUCBn/tmbJjz4UXx5YDw0XGx?=
 =?iso-8859-1?Q?oQYw2y2meY60jdcECWmBzkyaNPVSh1nPzo2fTjZWyD0EnQGPLj4WKncfb7?=
 =?iso-8859-1?Q?eYaM66tLiRmz/bJCN0OH5jcTnf+H2J3bnKgiwrxqMUMiVKi8nNS8DrQXNZ?=
 =?iso-8859-1?Q?xLiLCbiqp4z5kbrqnLBCFnZnomnWY7Bm+yAQ9EB9E9QhOY2u17u8t6yYG6?=
 =?iso-8859-1?Q?lamxaH8MxwhDRNqHQCNiKs/PXSD8NeI0TlyPf0t400BVa7p5SrPb9zKz7u?=
 =?iso-8859-1?Q?bstBVy54Y1PgOIZAnAHGPVNPBQdb/WvHBb9N4khmij6MtWmQlW7tPHe1X0?=
 =?iso-8859-1?Q?UE4G/7Fo4dA/bc1QuvORlG6CzHAB90PucVRPKQttGl7jgT2Z5JgL122LhX?=
 =?iso-8859-1?Q?jezHULxRF+piWFvAWXUlJmIqeb3VyLJ/iB6GAs4+Kn8ObvSePQsCDU/eyC?=
 =?iso-8859-1?Q?Yy0rtWvE+z7OVQjqwSx484y9vjghMBnD8Rpwl852L+jXbGBwLoFc45c/Al?=
 =?iso-8859-1?Q?qpkWLOy2lCJSQBpvirTvcgLGY+elNtMexI+b7ggvPbkY2BfsXfpK6wlvBD?=
 =?iso-8859-1?Q?bDil1ubH38wYFagidlbPVlPr3Lm3mOV4QKiZTKCojVLfz/UW5SwaGWoVMa?=
 =?iso-8859-1?Q?FtjTYIvTJtitzIFYWEHfr3a6z4wiO8FcJy+Gg8kOJXwqdwe81OucMh53Tk?=
 =?iso-8859-1?Q?X3CJuYPt+bOVdas6VC/q+eunX0VcrnT3PoCjirXckD2STrBXI4oHSxJ3AA?=
 =?iso-8859-1?Q?YTKDhPAhcaX53p3cUrljmXrRBjd/65u39tfXQ545D9MfA5QSKYHzQ5YG0T?=
 =?iso-8859-1?Q?of261RptqcVuOypjVjYXeeovDJfphlopctqBpuc2m7XEIcJ7M1rlZmOM+6?=
 =?iso-8859-1?Q?Q6o2joFwg5dNP1AUrIQENM/KxdbwXDnwqRp4EMs4lwaRFeWaRFb007kg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e68c8753-79dc-40ce-557b-08dc4500f1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 15:02:34.0848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRF4B8K8jGvPkr/53UnS3RejDUaJB0TLnhV9v2+hAp4awgaGKKbCoa2GRkuIMBq7kuPG2dKPufS2v2ehz7fnwbUkS+30IqdfIhJnssBdgYnE1iPqwdfjb7dcn3GcwZMV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8804

Hello Simic,=0A=
=0A=
>Unfortunately, this isn't an acceptable change to the Rock64 dts file.=0A=
>Yes, there's the second built-in Ethernet interface in the RK3328 SoC,=0A=
>but the Rock64 layout doesn't expose it as a separate physical network=0A=
>interface, i.e. it isn't available as a port.=0A=
  =0A=
I was wondering if the Rock64 lacks a port. =0A=
According to this link: https://pine64.org/devices/rock64/, =0A=
it seems that there is a physical network interface available on the sbc.=
=0A=
=0A=
>Such a change would be fine to be applied to the dts by hand, by someone=
=0A=
>who actually adds a second physical network port to their Rock64.=

