Return-Path: <linux-kernel+bounces-88168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4086DE19
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198C6B278AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17A26A8AA;
	Fri,  1 Mar 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FQRRCmrh"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6D1E886;
	Fri,  1 Mar 2024 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284950; cv=fail; b=oJkeX5zNKCUXTZAbCVqoFWVT7cY2ItkwfbaxnuBMaE7BaKJrM36zMAUpbg+m0/H52BPGoUSjhBLQohVjjNERL5Q9ZajbffJuW2ZlvlrmH5tslJ0CTpWClXWhCAG4mmLJ6Wgl6uSvEcj+Dp690DDphQALt2jl4nAvx6dhi/3sDw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284950; c=relaxed/simple;
	bh=x6GcbqZ0+5G32RwwQEeuzMuRQ8K3W70L3TZ45Uy2PkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ED048kUJz3+ENz7aV+CBgzFhkh5o7zyWJnv8zraWyxL76JTqIKMiGb43ifIM695ndbzaUu7KGH9AyrTbwSr5R3Gk0pxETc5xyKWHofv8Qs8uhj6F84arcV867tfyovpkzIIM7E7ymba7TdwtR4t7F8Mv5YHcqhM23tQuRSaLdgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FQRRCmrh; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtV5oX8vlYK2w7Tto5LWs09Gx+nwPaO/bT8cfuSiKluADWVDTrGgZOJ9kHfWPaWmZ5jtoDRxh3Ahbbl+jSsi9bjX6yiDxyM1B7lgOk8eafOldj9ykq2O7k/Lmq7/2poY1cWVn89EIeFSxaH6UNe8dBRUUpT2RNwgtUNEpkLEz3b8X91R0yhuFyKMltY0/3lhdrMojSJuITeL8uie/j9NB1BOlAZMMcNDbplmQho8JgVEZ+VfL9cDpU4b+4yq6gxk6XZ1sgdw0fBHpwDqsXHghEJ4cp+jokk5J8bpe5DxqvAD7HCiQ59yTK04+FN7g+9ekpb0EIUuUuPWwTSIW41BlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6GcbqZ0+5G32RwwQEeuzMuRQ8K3W70L3TZ45Uy2PkM=;
 b=hrlFfwAdE8p6omZE2js2Kl77A8PdAfncVN27L9Y/p9U/DsUP1v9oPouiE2ia8JV/aKDzXGpANWMqHZU03Y+FIIHZXWQlDKVjtIlW3tiNlmgOmceHGOqMByq0NmJKkeoXufEd4LAarm90OPPgas9pE8Cbon5nICO4zwimiiFzp03jy1XkD0E8ye6niAVwpcDSGUbzZUxNzz5foHm/knp4DiTvDNqTkiW1GIfhH6r6xpHzZlrqiLrFZZxRjmZ+MZilCsox8abcHac57cU6x2u0Id2TuKtkhuB1TR5TYRxL8NYh/X//31ic9TNNto88cmoAhwO4k/tX2tYol4WSCqj+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6GcbqZ0+5G32RwwQEeuzMuRQ8K3W70L3TZ45Uy2PkM=;
 b=FQRRCmrhwZl1Qq9/KgZsUd3bbs5kIUA0eWHgzxEz2UJg3Zj3IWuy3A1ckTuum5iH759H2apPehv4BeK9KDpUZ1Zav7gUB6e0mvlEZ05m0Xg7A1PRxket7e8o/FQ/NTeeegnNtATXNuHanJ3Sj6+cmrO8IlgvrHnLdzo0+fq+PYY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9899.eurprd04.prod.outlook.com (2603:10a6:10:4de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Fri, 1 Mar
 2024 09:22:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Fri, 1 Mar 2024
 09:22:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Thread-Topic: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Thread-Index:
 AQHaaLLyfnmFjzyGqEimlBHwa2+g1LEcnfcAgAAaQQCAAKcG0IAD/moAgACytyCAAHjsAIAAGAyA
Date: Fri, 1 Mar 2024 09:22:24 +0000
Message-ID:
 <DU0PR04MB9417EAC31D3D7EC716A66C05885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240226130243.3820915-1-peng.fan@oss.nxp.com>
 <ZdyR_MWeqOWga8iQ@pluto> <ZdyoAsYGXK9GjHVx@pluto>
 <DU0PR04MB941710FB1400D0A17F99B6ED88592@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeCNyLxQOIazc07h@bogus>
 <DU0PR04MB9417C06FD66182C705238662885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeGJIvk_LqglqdBa@pluto>
In-Reply-To: <ZeGJIvk_LqglqdBa@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DUZPR04MB9899:EE_
x-ms-office365-filtering-correlation-id: 92fc0045-d579-40d1-f128-08dc39d11b01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cNre5tSsxV7BJeEWXrmG08fh60cnh2iQD0ysOQokncv/MaMmO8vWT6m14HAGKY8d99mIEcePltAb61Co8sSyHQdBr3FTlZXGlhsHh6i1lhW9SuAal9EK+quoeIEz1obPsm1kpKYHbNJqSwBe2l1CPSzJDfHPU3YicWUXzAsnYJ2JbNhXSaJQm/pqcnsY1rtDZHfKBOp2t4bPEseALwUoZBDWkW7voedP9X3ro+5/5ueXoWIUB2SoXkj9+UDrweALMSsTKnUEx0v/aLiLWCuY5czxJl2uXEXk8wboeQWXVo4cp4sGnuWVBFb+eSNoH95ksRLnTRPULibPXRfb+Km/4y6QzjKKR1QY6cR2XldEUzs7dhOxmA08vwN9hGcn6STA1UjgyAykcTtuqsa4/T+KCXbDdaJXPAI3E0U9swybT2oRaaOcmJb5Su7ccyQ08MJ5NPwqXm6ngsrPR36h+lBmkRtEDmUUWAEVJOdkTVGVLfI+ZWG4VluI9hAjhyZ2ozdDnIeRcNd4PNGQYhlVke9VdUobAISVFtmh2GeC7dK1tbJnHRXRbbnrhIzY6ws/jZS9hvoEke6NGTgZz+lozYFsYFG6HuWDq3D3dV0nwir+w45gOHCDll5FIFAW7/6KTZAoMq9rDlVlfXMwdoY7ANSQr2+8FD+Ymb+4zToGWKDxJ/8FNajY2nhrDifBDY6Qw8BSzv6gys2Cn5+fnt3sLcoIIdXEGz8Bh6oGOEygs6e/pmE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yHpEqYqKq3aUi3rLoewFnGS/YvmP2SjqweqV8c8WYfededL2XDsaSKdFRY61?=
 =?us-ascii?Q?HWCNZIu8Jne3iSPxRjrqDt5rM9kQHOLsSGhJqRKSFE8xxAfsOy+3tT6Cvd6l?=
 =?us-ascii?Q?wIU+o0/VC11bYJGKLUsRfz1mrKZjhaC7rUdRhYjbhzp4eScc8DQhZGMP2YhI?=
 =?us-ascii?Q?c+JkWCSxds6ZjlfzexhF2nqaoKTUm0A7wwo1mlvnu2MaPK3vZ/tYAtEIV4uM?=
 =?us-ascii?Q?88B6ZesAax3QlHUNXcshtc8RAfM6LpOrCP8BfOSfRocvGemwvwrvNeFzkdLA?=
 =?us-ascii?Q?5PZoK7YiMLFkOoEY8md3pfQW/45r9AWMb3ulTcsiuLGFO8alx6sGq1YquwYg?=
 =?us-ascii?Q?kjyh+OHKV5mZi5TG2NzCpfu4uTsa+jiMVZgsuDVuqnuOOT3wr5MthUVXfo5q?=
 =?us-ascii?Q?8i7BC93n7Wqw1tUdmyC9EJZsfEw12e0J6CYbIUWOvG/SLxvLhYyVp5Pa9+3q?=
 =?us-ascii?Q?ZILn5PYayGM0Eh547S6iiqmgWBPp42G+izkd07Oth2psWnoxXWZf03FbpMLU?=
 =?us-ascii?Q?9sUxTTN64XqpuhjhDNbXLXdICneSDvJYDWwstYTCW9lUedZz4YzX6N76fRjY?=
 =?us-ascii?Q?zXOPqWooLBx/oy0dTD3ciNXvphF1FXtc68yK2bKBhjIF131+f0J5YL4NBjji?=
 =?us-ascii?Q?wRCQ4pGW9NsdZtrPwsS1jcmy/i1WQjKFuaZ7fD5P0dqYIus97dghK1cGZ7aN?=
 =?us-ascii?Q?4UxIvwhe3ewFrupMe9RHOF33WT0Tc7AX/9ycO4x1pHAQ9F26p0QXdoyBKI9t?=
 =?us-ascii?Q?Jw7/p6g+UI+GVu2hHueDicfPqRLdb+5TYMpZdTqv0YCNtq9Bf6zORIlt6T3E?=
 =?us-ascii?Q?IDR1opaSOt7hHeV8ijz2xO/Eimz/C0J/FchbAUvMg7nEpeGXP++n4MjiUPyH?=
 =?us-ascii?Q?+7jz4FYWpcLb2KlCUvB1a2fU3XKhgEu3EQSc/A+3Hc5v0GdmGAGXXJrOildU?=
 =?us-ascii?Q?zIZ/NxUZCODvLiRcKY9HjFIDYnK1Z5GDMNspLibLDWjARFvpUNO95HGRjRrf?=
 =?us-ascii?Q?iQEyERoJ/KKS6JAWe0GCVhOTcSPKLvbDz1Lsz6zyHCiXYQ+voV93DrTKa3Sk?=
 =?us-ascii?Q?Zael4nQ3j/6fsmT1yMrqanBgliYLsGCHjqzqxZyN06eJIYoAYp9XBXjD+51c?=
 =?us-ascii?Q?/Un8NK/LJ1xXU4pNQZmsBGZB2b8ji8l+mSq2yBS4LqCZEjKlYJgQbbzbJDgL?=
 =?us-ascii?Q?AqfKjiFYqDr9mOpG5CvYGE7uJAZ1Ac1llHPjP+5NrC7Iadn49OkEdp6r+dFh?=
 =?us-ascii?Q?qRiJt1XnlIIz36rU5KPNdFrz4CH06PrWf3at7oPvcaXyA2Kgg6JeZ6U3GWAE?=
 =?us-ascii?Q?xxnrK5g9plZgG3ymdPDSSoVRcOvJKztwvNbmr/1EkfjDklo5jHrF4bIQI4nS?=
 =?us-ascii?Q?V9gTddvY/s+xl9mOZH/KeKh+W0kah68EWgSlrcvrxeWIsGbKllN+dUFaCbFA?=
 =?us-ascii?Q?PtOenhSnQs3kLmaBwSecGx+vjJHyQSDote/Jk8AY5gitrOAQZYAB8rCC99Sw?=
 =?us-ascii?Q?ZJeazlI3OubXgyd+kAM54Zwgf//ba86cNPtAtQj+Kut/i6tCrTz4sagVj+5n?=
 =?us-ascii?Q?BgsuOAIwn3pfSDKhRR0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fc0045-d579-40d1-f128-08dc39d11b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 09:22:24.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1DdwXIidJIjqzJbw9NoJ2oMeKEu5xEg0pxonvOq928ADlaGdovoWg4xJWMbnDfBhHL0I9BS0eEZouot8F8u7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9899

> Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system powe=
r
> protocol
>=20
> On Fri, Mar 01, 2024 at 12:41:29AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system
> > > power protocol
> > >
> > > On Tue, Feb 27, 2024 at 01:01:41AM +0000, Peng Fan wrote:
> > > > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support
> > > > > system power protocol
> > > > >
> > > > > On Mon, Feb 26, 2024 at 01:28:31PM +0000, Cristian Marussi wrote:
> > > > > > On Mon, Feb 26, 2024 at 09:02:43PM +0800, Peng Fan (OSS) wrote:
> > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > >
> > > > > > > Add SCMI System Power Protocol bindings, and the protocol id =
is
> 0x12.
> > > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > yes this is something I spotted in the past it was missing and
> > > > > > I posted a similar patch but I was told that a protocol node
> > > > > > without any specific additional properties is already being
> > > > > > described by the general protocol node described above.
> > > >
> > > > Without this patch, there is dtbs_check warning.
> > > >
> > > > scmi: 'protocol@12' does not match any of the regexes: 'pinctrl-[0-=
9]+'
> > > > from schema $id:
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F=
d
> > > >
> evic%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C3ef5d152a8e5463e9b
> 3408
> > > >
> dc39c47e41%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63844
> 87632
> > > >
> 86203182%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luM
> > > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DkRBV9FPk6
> Nrgu
> > > > Hs2SHpL74VlNUH6cYO1kAsW74CkaTk%3D&reserved=3D0
> > > >
> > >
> etree.org%2Fschemas%2Ffirmware%2Farm%2Cscmi.yaml%23&data=3D05%7C0
> > > 2%7Cpen
> > > >
> > >
> g.fan%40nxp.com%7Ccac77deb5f6a4b20460a08dc392ead40%7C686ea1d3b
> > > c2b4c6fa
> > > >
> > >
> 92cd99c5c301635%7C0%7C0%7C638448119832543335%7CUnknown%7CT
> > > WFpbGZsb3d8e
> > > >
> > >
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > > %7C0%
> > > >
> > >
> 7C%7C%7C&sdata=3D6MldIOUQ4hxn%2BRffwJJJ3jxXXtHCSxLUOa4JMWB0htU%
> > > 3D&reserv
> > > > ed=3D0
> > > >
> > >
> > > Why are you adding protocol@12 to the device tree ? Does it have a
> > > dedicated channel ? If not, you shouldn't need to add it.
> >
> > No dedicated channel.
> > The idea is we have multile Agent, the M7 agent may ask to shutdown
> > Linux Agent. So the linux agent need use protocol@12 to do the action.
> >
>=20
> Ok, so indeed you need, AFAICR, the node in the DT even without a dedicat=
ed
> channel nor anynone referring it: no DT node means no protocol initializa=
tion.

Yeah, so this binding update is needed, right?

>=20
> > For now, we have not finish implementing this in linux side, just add
> > the node in dts.
>=20
> On the linux side you should not need to do anything but adding the node
> @12, the existent drivers/firmware/arm_scmi/system_power_control.c
> driver when loaded will shutdown the system upon receiving the
> SytemPower notification....what lacks Linux side in these regards ?

" Ignoring unsupported system_state:" we have new defined
number here.

Regards,
Peng.

>=20
> Thanks,
> Cristian

