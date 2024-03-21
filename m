Return-Path: <linux-kernel+bounces-109641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25976881BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479701C213B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7BCC2E3;
	Thu, 21 Mar 2024 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GBTU9Xi+"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2080.outbound.protection.outlook.com [40.107.15.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FD28FD;
	Thu, 21 Mar 2024 04:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994083; cv=fail; b=FjnE1J3jgANCBpaMoB/0Md77xmtdxX+ihrR1ZX2mGHuvRP8OVWTuoHZCd4fENcj01ELjbJDm3SbNQkD1HozE+XIq1N/g4IIP5OD7CdT4/5gjZbJz4w9Mdiqf+cQ4kUkeO/kGV3h/lbj5P7a6C2GmX+Fh0sCn/vYpbiHOwyO1UMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994083; c=relaxed/simple;
	bh=AhA2cTvf4P3OVVRUcfo8YcwHyBqQKkXcQmC8wFXf/0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WhGqLpVEEozE7KCdIgP3ue2JlIVF+61mjV70YPYQksYF3MqWkgHdVN/Z8YdlNZ+WyhtbeywkKAc1TDFcy3/8ycKi99PjVBlC7jwEyExiPgo24Sa92XLTTIUtbf/y/UDG2bpSvQZRR3Y6FGZVpu+VeNeFNGlcjUqo917GGY51Yq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GBTU9Xi+; arc=fail smtp.client-ip=40.107.15.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSAjG42y1aQAU2Pt4oNXV7m6+Z3UMsEFim+G85r9By66eUwNWM9htoiqwv/fGsac4p6UPyWHg+f5LT3TG/iZXf2R/mUF2TEZDB08jd+kRoodzXbSZs+c4duPtwGyB68kltfXeVmvCB31r0MjaDF3Tw4sqJtxOc1xSvDpqdJEYVvPXpL7G6KtzuotWTfmIXhPnQCp698dmFXmAZDt/WEkOgUDqXTmWADmneB9QgG6KuxgFBTI2ihhU7HYdWHl9/7YG9NT6GAXpl5XpYfTYRoWDCk3QNpuSB01jM4lvo2rXk2DxwVHDqeg8BgwOyYOEr3jOKi232YdHvF+MF0Rb3ZHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhA2cTvf4P3OVVRUcfo8YcwHyBqQKkXcQmC8wFXf/0k=;
 b=W03c9b/+dOPU2TBPn3HCNsF1Hm0/bqWbevIZDr33Fzv7iOnelnSL5WYEfPWRbrklcbTrXJyDc3++S/BcKU59wGE7JtiLodB67O5IbDlZlHsFC3G5o3eXIt7bq0rS1GxKg5IQuZHr6IjGpbvZCaauM/ptbwfjMv/BVshJrOaKuuGZWVZ+9RWDkw5PbutF4Ut2VFke6u07SJy3ALcKc+tYHZmjIS3r40qbyViFjpLkv0WWfN5mvruwVztXzUVeWza2ityRKn8jvfCFj+95UB/qjJiS0pHfBIhiAUjQxtqvJjVL/yBiZbYyH2gEcGGrzXfkUyVT7leKaw8AX7FitZdFrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhA2cTvf4P3OVVRUcfo8YcwHyBqQKkXcQmC8wFXf/0k=;
 b=GBTU9Xi+iRpdZpdwi7Cp/1sK9sWxW8DB+8MtWLih8JLrUJbLbFk0PFTvtm7BR6wHIsH4yDCJvFcUCQR/862dQm9ndOu1kG/3ytbCmiG/Y4GNfXePEFIEofzTO6jOj0isU78grW0nzyYm7Ght3hUI8CvSZ8O0NT9qoW5M5XJfpP8=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 04:07:58 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7386.030; Thu, 21 Mar 2024
 04:07:58 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Francesco Dolcini <francesco@dolcini.it>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	rafael.beims <rafael.beims@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHab2onJLj7by1TDUGmc5gbcJq9YLE4nU6AgAD7hoCABXXFAIAA1QEAgAAD/+CAAIccgIAA07QAgABoFOA=
Date: Thu, 21 Mar 2024 04:07:58 +0000
Message-ID:
 <PA4PR04MB9638F5037D1AB9BCF51CC9D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240315094927.GA6624@francesco-nb> <ZfTspRKFgrO9xCTH@google.com>
 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
 <ZftaJEIeNfV7YrVo@google.com>
In-Reply-To: <ZftaJEIeNfV7YrVo@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB7775:EE_
x-ms-office365-filtering-correlation-id: 123861c3-c7b0-426b-bba6-08dc495c7e20
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wmIqzk3zLpRTdIC+uxpSt8Jk944nrIMQGF7AkxyzyJAlIPRlRXgJJSM1vtAxPw7zYi0KGPXFefUXTMG1Qzr7LEbU0Izqao5v+0mbIDmEl8MvTM6DlEYUN3TGdrbm0hK/az+JdtnQw2uXybWEUCZRff5dTEjbMatBxmS31iWH64akv29UI8GbiKOV5gwUl9VtOcGDQ+hXu1v54IU+f48UjOaRG8qlJAOLAR95afIIP1sKj3Vs6Eqa0TWY5GQ937L7OQSXQDvwrL4RaIO4ageyhY/FaWmgJ0jvHdgtbYdwALkSl96QEjslY62bG1nseyFJu71AGdlK+df94lPFy4J5EgQOC6pxXiPs4eLD6lwjBzXu1Mq/7F6Edha5HZ62hzXLf23pMTlKMoCjtal2HZXaO9pGOm1oS9N6qWSDP9Zfbk0evQa1Cv+niTMTTn1YMvwfRTQZdMk60bLGAYcARoNsm8xqpIq9W7E2f4Ov030ol+8U2bYrPxdaQ5DqcU8b5I5luEw0fIibi0tGyyOXm1qgDUJTD0j9/Y0VkEeN5XToJK6z7BsIvEQkogzbqyIX20WyCO7WCO3lyA6h8q5aEltsTI16rwuKSetNnagJuD6sFEF39+mYuc0GNGva/X4c1Pm5G8hxWFKwuCyMRoLv1Kqf9IoedtkQQYny1Ayq+DGSosODVSKv2IooSKOY/KEclzNdlV0ySvqSApVYGInACjHmQZg4Oy668BB06dGIzo+smiE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nFRymueha+bAh4tnduywl4aXBePWywTYwO+C3wkGPRZRPP2QtTF3dkdjjBhF?=
 =?us-ascii?Q?ul2dlC09NlNvUeHTExaO4FGyKI6ZUAGE9+jxhVdmdIXXatE7U0hy0fKxHGj9?=
 =?us-ascii?Q?MrA+QUOcuDOmP1tBB/OJVJZtrp267Psvo2ZvEJfjG2Oqtb+NFvLuNY0faZ1D?=
 =?us-ascii?Q?vdOv+PEq5H00OeX880QLh3NNj6nTrVYqBVAXNz1EX6nuHxka4q9AahjugXYS?=
 =?us-ascii?Q?njSpWvz4mQy8Q7snYgEBqZjT5hI0y424Xxe8aQEjpGurJT5iq754PeuyAUCF?=
 =?us-ascii?Q?PBpMfk3Xlw54OTeblVTv9lQ5H+5svjpeY1lKE0phMSDGG43MoRDziEfS052E?=
 =?us-ascii?Q?nN0AspD8DDCwpQYPAVziIkj9r9qW3j1J654E075UO9GF5+2YmRQ+1dOorBEA?=
 =?us-ascii?Q?QQEJ3Qk5uS81aHA5138gbIOPDU8YJS9ccyA7NpxD8ezbuevfyavSwdWXtmCA?=
 =?us-ascii?Q?kyFhP0wqxh0qWDJbj+5BZFnUh80l5aJhnmY9w88Ev56WVvTWbmcp1xPKfnCD?=
 =?us-ascii?Q?Acimy2MirmAyqGzKD8o5VFkVT4XtjXYrlPwTOj9VqTrmMiKKW2r/+jo7tHuq?=
 =?us-ascii?Q?LhdBFlOARBY1uQFicviZ4ix0gs+xNVeNOxsd8PuqxTq9za4pZwlzEHoM2DNw?=
 =?us-ascii?Q?9St23aEp/+5mSOroZRKCvJQKZiIGApdw3PTNSiIBuIJQ8UmXPJ9A6F5vYWMh?=
 =?us-ascii?Q?aI14M2OLqhwv5vGfMySIFQ6wu+VXJBHlFwnL+XKcuO2hpD7UHYdDR2w3W3/E?=
 =?us-ascii?Q?xJdfxhlqGE7VAo0yIOl6CF/svrxxMtE3nYc7csvPtrkFvo7UkF5/kCvJElPl?=
 =?us-ascii?Q?tgjkHJ8s4+hQ83UvOIxLccraVsMVdPmqBQQ6AAk+N9+NT8QlEfzj1apbi29q?=
 =?us-ascii?Q?Dl6oH4w7ueI1Da6l44tW67RW+FqEw9WPPzPzf15dJN2xNt13KD/R+AlDUYWL?=
 =?us-ascii?Q?PtxZcEAGFBq0OnsYmaRRZEKDMUTuo4kXibczya2Dn+Ff2K4OT08aRNnAhdom?=
 =?us-ascii?Q?UoLo2tSEkz6ZXGvxaMkrErFlEgc8oXczZ9LDWF46WOtFo8ZwGWAlaNHX2rEj?=
 =?us-ascii?Q?nPpyMMyBRMjNCQCo7POxGDUDX4Zg/Wq5dYcFXSszu27VSHuMH/dHhgGphdIs?=
 =?us-ascii?Q?PXMUQLLJPXyAUtDRPwJmlSo1F6xqA0pwgNvUIifP81llJbu9I9fQIsWvZoO4?=
 =?us-ascii?Q?TcGzHwEPe+FYCRsRdLPgETqsuG5H/FA8aLoUXYDrSMw64wIBeV6/modBdvaG?=
 =?us-ascii?Q?U8cQRqT95yRxi5EP6ffqZVm9DKcOlFMqw6fHMNGPcX+X7rfeHDCK8lW33TKX?=
 =?us-ascii?Q?xZ9PPCDZgt0cwN52JGcG3ttgSRM0HRC73m/yyvW82+K6kgGE7siVSXVoVJ8u?=
 =?us-ascii?Q?QFvsKUsCJnYHS8PlJ3O0ubbKTbk/0lx6oAeIVlqCN4JBwsT7M2ycUYbMP1Aj?=
 =?us-ascii?Q?I6VA7en6+efSK2WpzqkZf6N7sVY52k5pxnHDfINEtEkmBJRYJgdpCWBDy9MA?=
 =?us-ascii?Q?bnXK1qMd9AYZ/lrj9ByBktCE2Wq9hQ62jVfnRg9pBtZNUBv3QFac9o0yOBK/?=
 =?us-ascii?Q?x6+94/wVx4Hgx2UOjF/pgwL2rohEAStHVLmPJV0K?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123861c3-c7b0-426b-bba6-08dc495c7e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 04:07:58.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qjs0oX3M3dErJMzdC0o2JMBD9qAg/C2i0BBJhw1agJNHLtZepvsD/ThryjxsRX1JZarAhoyM8wGprL5VHNarQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775

> From: Brian Norris <briannorris@chromium.org>
> Sent: Thursday, March 21, 2024 5:50 AM
> To: Johannes Berg <johannes@sipsolutions.net>
> Cc: David Lin <yu-hao.lin@nxp.com>; Francesco Dolcini <francesco@dolcini.=
it>;
> kvalo@kernel.org; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; Pete Hsieh <tsung-hsien.hsieh@nxp.com>;
> rafael.beims <rafael.beims@toradex.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support =
host
> mlme
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, Mar 20, 2024 at 10:12:45AM +0100, Johannes Berg wrote:
> > On Wed, 2024-03-20 at 01:10 +0000, David Lin wrote:
> > > > >
> > > > > Also decl.h should probably _shrink_ rather than grow, a number
> > > > > of things just replicate ieee80211.h (such as
> > > > > MWIFIEX_MGMT_HEADER_LEN really is just
> > > > > sizeof(ieee80211_mgmt) or so? Not quite correctly.)
> > > > >
> > > >
> > > > This can be done for feature patches.
> >
> > But this is a feature patch :-)
>=20
> I'm going to hazard a guess David may have meant "future"?
>=20
> But yeah, I get overwhelemed at how similar-but-not-quite-the-same
> definitions in this driver sometimes. It definitely could use some spring
> cleaning.
>=20

Sorry. Typo. I will modify it in patch v10 instead of future patch.

> > > > > So yeah, agree with Brian, not only would this be the first, but
> > > > > it's also something we don't really _want_. All other drivers
> > > > > that want stuff like this are stuck in staging ...
> > > > >
> > > > > So why is this needed for a supposedly "firmware does it all"
> > > > > driver, and why can it not be integrated with mac80211 if it's
> > > > > no longer "firmware
> > > > does it all"?
> > > > >
> > > > > Johannes
> > > >
> > > > Our proprietary driver is cfg80211 driver, it is very hard to
> > > > create a brand new
> > > > mac80211 driver and still can port all tested stuffs from our propr=
ietary
> driver.
> >
> > That basically doesn't matter for upstream at all.
>=20
> +1
>=20

Yes. Sorry. Please check my explanations below.

> > > BTW, vendor should have the choice to use cfg80211 or mac80211 for th=
eir
> chips, right?
> >
> > No, that's not how it works. The choice should be what makes sense
> > architecturally.
>=20
> And to put some specifics on it, that's what's described here:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwirel=
ess.
> wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fmac80211&data=3D0
> 5%7C02%7Cyu-hao.lin%40nxp.com%7C26588fdd1b6e4898479808dc4927c350
> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63846568232661160
> 6%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3Di3RTFqEZN3djd9L
> RsgxgdgXfiuCln%2BBy6%2B0akWYLvT8%3D&reserved=3D0
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwirel=
ess.
> wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fcfg80211&data=3D05
> %7C02%7Cyu-hao.lin%40nxp.com%7C26588fdd1b6e4898479808dc4927c350%
> 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638465682326623950
> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D5erX1KaKcB5j6GzN
> u2bb0wt0j7DgUckO5hsazc1z%2FlM%3D&reserved=3D0
>=20
> (I don't consider myself an authority on this stuff, for the record.
> But:)
>=20
> I've often felt like the SoftMAC designation has a very fuzzy definition.=
 Or, that
> definition is very much subject to the whims of the hardware/firmware ven=
dor,
> and can change from day to day. For instance, it feels like there are ple=
nty of
> "fat firmware" features in mac80211 drivers today, where pretty much
> anything and everything *might* be handled in some kind of firmware-offlo=
ad
> feature, in addition or instead of on the host CPU.
>=20
> But a key point that *is* a pretty hard designation, from the mac80211
> page:
>=20
> "SoftMAC devices allow for a finer control of the hardware, allowing for
> 802.11 frame management to be done in software for them, for both parsing
> and generation of 802.11 wireless frames"
>=20
> AFAICT, mwifiex firmware still isn't allowing "parsing and generation of
> 802.11 wireless frames" in any general form -- everything I see is still =
wrapped
> in custom firmware command protocols. I do see that the AUTH frame looks
> like it's essentially duplicating the standard mgmt format, and uses the =
driver's
> TX path for it, but there isn't a corresponding ASSOC management frame th=
at I
> can see...
> ...so I really can't tell how much control this firmware *does* give the =
host
> regarding arbitrary 802.11 frame management.
>=20
> But that's pretty much business as usual for anybody but the vendor in
> priorietary firmware land; I can't answer pretty much any question, other=
 than
> what I can glean from a driver.
>=20
> Brian

Yes. This change is to offload wpa3 features to host. It's well tested and =
doesn't impact existing features.

David

