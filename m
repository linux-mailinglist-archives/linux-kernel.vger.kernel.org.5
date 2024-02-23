Return-Path: <linux-kernel+bounces-77818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA7860A92
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3717C1F24DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57109125D8;
	Fri, 23 Feb 2024 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eArZXtaw"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30165C2DA;
	Fri, 23 Feb 2024 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708668220; cv=fail; b=ce7U7MDd3vI1xEyIQWAwtizpIoEpd6Z/SZp2InXmOSK82ou4He0WlDgEzAU21+gmOUFmO2oGCrpPbAHpx5jgJJwQPESdeEmulrBNou2uEFr4ujslck7Xs2Wd890WcGacGQ3hwA+yCGmWD/pZuzkroPauAH/GaVgaQCrQRVDpTPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708668220; c=relaxed/simple;
	bh=zfNwztIGiy3mhIaKHvx+Bx/We7otZzljKLLSaSTAXC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lvhR+Gg1URJd1B0nrOaxdN5Hi3FnCdww2gSRtx1V+MKGv2ZUWWmc65eWxXgMegutzPVNScV1JNvAExEwF32XtI/BX869VUTs1SxkI/ht/UVZ3PwTjyTAzMgaKiYmFSvuSLbBGoK3zfZeHvEYD08cR7ZR/7lv6Lw9KaElyoOAdhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eArZXtaw; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENZxIDvaMk7jV7ztpaBzl6VSeaHJB8s93xqS7TAmARNvopaIflKlAEaRzge66yTKgDEEr+gAM/rxHF38RjFQ9O1vuiZGtMiiFnsi5VUnpgGxUuM8y8S0byFv8QaKdOHwhB7vllI5HqTgR4HJZ/0XuN01c+uunpNx5/bHkQQLfLM0ksU56Vmkuh47ynJCzNjBzXZhPpwY2goJ5HKEfOIIjHCoh/9zspH1vw4QiUF4d8/6FyA6OjLBhW4oSmUf4xqiQ7/5DUGorMIz1CAA1wsjNmUdPUxxSKAZRZ3Wquin+EqpMDdnEZQUGXgvyXoh4+dHCFDSfqefzzaPhOOMTODmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfNwztIGiy3mhIaKHvx+Bx/We7otZzljKLLSaSTAXC8=;
 b=Ok9uaQ1+PFy7R0JvEVvYN29C3/Dj9Oe3w77FPm7+MUavMXNcqhGdzcNrdEFe1iPqrSj4bSfXeLFtGcWWYdUcWQKb+oxcQcazmIDOsDOuPzpI7WQGXiToWuDGxH5513dqmjRY79H3yCyx5fLrPKj52C4k6Vtcn9uwh2numhxCxsZJYtJ3Io0gb0Ac/+Kgo6wochaX0WqHxrFLYd/rCmhE5g2KELH7VnXkDGTyY43M6KgBtHjouoiIrrXmwebfN4OS2hmcfJ6peV5qG5R7DbHNMbbbuO3I0gys7+dUv/TXIPjovl3wC7QYxplAte7OjNBWdREc78A4v//drxfUm4C26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfNwztIGiy3mhIaKHvx+Bx/We7otZzljKLLSaSTAXC8=;
 b=eArZXtawDxh58tyMXNg4Kl5O7R4J2vxOSQRnvAtZTvYZOERLSaztXXU4LcbkVC8NJaqeXBk7hXWDMCRzJzNQt9Y60UeTwgbsU/Sju3w8H+A/Vym4mY/YvJ4mK4v/V/awY+s9PuY/QMtmGXcN0tY+ppx2RRjcbHXTnCHz+1hIqdU=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DU2PR04MB8807.eurprd04.prod.outlook.com (2603:10a6:10:2e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 23 Feb
 2024 06:03:34 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::fd19:496c:4927:ac32]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::fd19:496c:4927:ac32%7]) with mapi id 15.20.7292.033; Fri, 23 Feb 2024
 06:03:33 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, dl-linux-imx
	<linux-imx@nxp.com>
Subject: RE: [PATCH net-next v5 7/8] net: fec: Move fec_enet_eee_mode_set()
 and helper earlier
Thread-Topic: [PATCH net-next v5 7/8] net: fec: Move fec_enet_eee_mode_set()
 and helper earlier
Thread-Index: AQHaZI40bGTUllTgWkeEg4uOZAfRsbEXcW+g
Date: Fri, 23 Feb 2024 06:03:32 +0000
Message-ID:
 <AM5PR04MB3139B5D33C36819D51919A5088552@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-8-o.rempel@pengutronix.de>
In-Reply-To: <20240221062107.778661-8-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DU2PR04MB8807:EE_
x-ms-office365-filtering-correlation-id: 6e4871c6-4a25-4a2a-04d0-08dc34352a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xaZ0n+gtLCyVsiVWajzQgCiT5BYKvtArERYXxZB0tSdd4y79bKTPAg55QbjpNTmtji9PWf4fCYnpD4tFkOxbdBSIl29goJxy9xAFR1NGEjdtWTLHyU+IqCtSgGaYJb6goshdcljCEDWwpLWHnbTwgSPTgVkvCspw/nIKNgzSfQL51UjTwHp/dBs0drrIe9rVNftJzM8Gnbg7fhXoHOF2xH2lJwpY+FzdUgNTiaeKh3aRU1/Xg9CEvAQ1dSuCPa/AAWlV8oux03mriKUFObh5s28t8kxCMzGIEGMB+4n2Bx7CnPRBXyrtlVoo9MrqnhigUPlOZJ7NBy7ib1SOTJQ+w7F0lduOKpIgsWnNoxi/XsY5siPGkoBTODpAgFkpBL7GvKSHmJcOy/7mh0kVxVg2rGL6X4mZ7yTT3UmqzCUHRDh4I/SEN8FpMJXHaHHklt34fMMK8qcrxuguy3UU9TjAd9rxd6yE9zVI1tYF46VZVT6l/bbuGUwI/2iQsj2CL0Twk/cezv9LApbM7PVQzn6RNajJmqrX9q/eftYEMvKTXKsRfc3iXh+rtMEPD8dIRlunHnovapURChjHaWIk/dXVxx3TGD4ul5QGN6+OWaFCL4NDiREZhryC5tE9WeZ/n3nd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VEJlODBGckFjSXZZOTB4cFhpRGJnaXlJNXllNk9KYTc5VVZPdnZtYmJSamov?=
 =?gb2312?B?dGIzSW9OQmZ3WTRaMG94NVhWN0lCbzdzbGJJeWhuTWhnbXhQN01ES3hhNDdy?=
 =?gb2312?B?SjhpRTcyS2lnVlMxQkdTbXRWYmVRTEpMSUhYZUJnaDA3bi9nZjh3czJNUEVo?=
 =?gb2312?B?c1hrcGZnQmRWS0gweE9XNGlUMEgwa2dvNmZxT3pvOXVYQm40dVpXdncwRnZi?=
 =?gb2312?B?NzZ1a2hjcGNjQ1ZrNnJWSU0xeDlzZlhsenZoYUNydmFYUHNKMy80ZFM0bVUr?=
 =?gb2312?B?ZE9aTDlyb09qWGd2WlIzaVJTdWo5UEFqdk9rQ1ptZEdKWTVlTWd2cU5vcnlG?=
 =?gb2312?B?Y09KZStrdzlsUnVZU1pOSGNCbHJaOVdCZmdHWVo3Z2dJRVk0RXlHby9WQ09I?=
 =?gb2312?B?SW9EeitzcWs0TFlTVUp0VE1CV2kvYVloUVhuNzNZN2hDaU1lZkhvWi9TUS83?=
 =?gb2312?B?VUc2L2kydDFFZGREbFBBZzBkVjh0ZjV3N0JVUjlLNDEycDkyeG5rZVU3WHJh?=
 =?gb2312?B?bVZMK1VBV3hWa1U4TnBIanFMSTBFSTlnSU5hVzdNRnBEcVBEaE5vSGdGOERj?=
 =?gb2312?B?T09YTzQ2dDFCWHhWU0ZyZnBMYWh1azNIK3JXT1oxTFlZZndZaHhDYm8weEZj?=
 =?gb2312?B?VkhZbTZwcFI0d0J6N0VxNXM4aUQzLytBRm9HelduUnRzM1A2cVQvUmpsNGJw?=
 =?gb2312?B?ZTlFengvSEcwTDNTNlFEY0JjMmRZWVpWMGplMlhSbXZYMEZCZ0pEdEllWXpJ?=
 =?gb2312?B?Nlh0YlY3amd3WlJ6ZjVZME04WWMwMDUveDhBMFdGMWUxQmdHM1VLR0ZOcmpO?=
 =?gb2312?B?T2RmRjBpUXBZQ1g2Y1R4cWc5U1ZGZG1jRitPODQzWTZCY05KRFlNTU1HM3or?=
 =?gb2312?B?SE12azQxQUMrZ0dvWnlMR2t4RkdaM2tkUUgwZEhtTko5YzZ5RHR0aUVnUmE3?=
 =?gb2312?B?WjVmMkI5bHFKc3RBdWFCdmFsRTBrdjd2UTduZTkwWGwvL3cySUNsRDlwWGZY?=
 =?gb2312?B?aUwrY2pzSHRQeTIrQTlLVzl6Z1VBQjJSMVppTStqd3FOLzJGNDQ5S0xzWlpT?=
 =?gb2312?B?cUhJc0xlUzk0eEN1ZmlicVpvdGVMQnBrMlFnOXg0SWNSZ3FWMHdaT3ErR2Mv?=
 =?gb2312?B?MWNQZFZEZFhsLzJiWkc3UTZKRkJ4RTZsVVhyd01QMEt5NXdOZHNNMCtkQ01z?=
 =?gb2312?B?dVUwcXNZR0ZzWFpDTDhRTzNNZlpUQ0RPYThVUVpiSjlRNTd5YUhaMjM3YXdk?=
 =?gb2312?B?RXphL0ZGSzc0WTY3WWlEWWhQNTIybXJFYXRiWVpiam45TnlBeU1VY2dpWnNU?=
 =?gb2312?B?K1ZkMHR1ckNwR2lFclhjRE5UamZlSHpvZ25kaFgwWlNydWFMTCt1RGhnYzJ6?=
 =?gb2312?B?eUNrckZFS2xqNHRFUzRnZzRCUE9JYmdFbDFrR1FGQlArLzF6MUJrQ3g4bVhu?=
 =?gb2312?B?ZkpXbi9LNHVUeVhNWkJRclFYa1FVYUJOaHFZMXhuQTZTeU14VkFSby9SSWZy?=
 =?gb2312?B?NkJqZXE1Wm1nbFRDZU12d3FvOTNNaTVDSlM4SFkwaWV5VlcwdmRXMHRrNkRa?=
 =?gb2312?B?SEg1OHp5VmRUdm9BbTNETVdQSXE5aDdac2h5SUwza2JHdGkvYXJDckE2V1dJ?=
 =?gb2312?B?cVVNOGV1eGlsOHVsU2Y3NUFPVEN6RVNYa3N5WFBOUWlxbFFzMWNzdHdwSGw3?=
 =?gb2312?B?RkdmSmZoaGhIWGFwUWUxSStPUzE3WG9NdTBOUEJYY3JXSmUraDJKS1JaRW9i?=
 =?gb2312?B?MFdSNGNZMjhPZ3doTm50TjliT1h4TGxCOXAyY0VHUndYZHBkWE8zamhEc2JH?=
 =?gb2312?B?NkRBM2xuYXV5Y2JWdDJuQXZxRzNYV0UybEpNZGlHQkJ4Qkx6TW1IUVBhVmZl?=
 =?gb2312?B?a0w4MFlhQWlURTRKUTBsRlNmbmpoS0w4S1IweXZFeDkyakd5R0F5UithVmhq?=
 =?gb2312?B?c25zQTRDR3BHWk5NMlRZT0tNUmQ5SDhqU1pzZ3J3NFdHNlBKYk1MbmlwWi95?=
 =?gb2312?B?dGVweFpKY29VQ3ltWHh4cTU1Y0htZGR1WXlJV3hucUZCMTBiOCtFeHNVNC9W?=
 =?gb2312?B?STJUNzJXTTZtMzlUeG1OMU1yNnFrZ2tYbXpVcUliSXFkWEhaaHZoSWFSOTVL?=
 =?gb2312?Q?DpZk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4871c6-4a25-4a2a-04d0-08dc34352a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 06:03:33.0613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBe4ZgIyWzXT0gIl40oRIDseHL2Vr2xwqCAZIdY3QaKXDV1GMW+p+qTQBIj5e4T44+y96XipDm3LiMIFWs7EoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8807

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbGVrc2lqIFJlbXBlbCA8by5y
ZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjTE6jLUwjIxyNUgMTQ6MjENCj4gVG86
IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsNCj4gRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47DQo+IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0
LmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47DQo+IEhlaW5lciBLYWxsd2VpdCA8
aGthbGx3ZWl0MUBnbWFpbC5jb20+OyBSdXNzZWxsIEtpbmcNCj4gPGxpbnV4QGFybWxpbnV4Lm9y
Zy51az4NCj4gQ2M6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT47IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgU2hlbndlaSBXYW5nDQo+IDxzaGVud2VpLndhbmdAbnhwLmNv
bT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47DQo+IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBuZXQtbmV4dCB2NSA3LzhdIG5l
dDogZmVjOiBNb3ZlIGZlY19lbmV0X2VlZV9tb2RlX3NldCgpDQo+IGFuZCBoZWxwZXIgZWFybGll
cg0KPiANCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPiANCj4gRkVDIGlz
IGFib3V0IHRvIGdldCBpdHMgRUVFIGNvZGUgcmUtd3JpdHRlbi4gVG8gYWxsb3cgdGhpcywgbW92
ZQ0KPiBmZWNfZW5ldF9lZWVfbW9kZV9zZXQoKSBiZWZvcmUgZmVjX2VuZXRfYWRqdXN0X2xpbmso
KSB3aGljaCB3aWxsIG5lZWQgdG8NCj4gY2FsbCBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFu
ZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gU2lnbmVkLW9mZi1ieTogT2xla3NpaiBSZW1w
ZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgNzUgKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0K
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGluZGV4IDIw
N2YxZjY2YzExNy4uYTJjNzg2NTUwMzQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
cmVlc2NhbGUvZmVjX21haW4uYw0KPiBAQCAtMjAxNyw2ICsyMDE3LDQ0IEBAIHN0YXRpYyBpbnQg
ZmVjX2dldF9tYWMoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+ICAvKg0KPiAgICogUGh5IHNl
Y3Rpb24NCj4gICAqLw0KPiArDQo+ICsvKiBMUEkgU2xlZXAgVHMgY291bnQgYmFzZSBvbiB0eCBj
bGsgKGNsa19yZWYpLg0KPiArICogVGhlIGxwaSBzbGVlcCBjbnQgdmFsdWUgPSBYIHVzIC8gKGN5
Y2xlX25zKS4NCj4gKyAqLw0KPiArc3RhdGljIGludCBmZWNfZW5ldF91c190b190eF9jeWNsZShz
dHJ1Y3QgbmV0X2RldmljZSAqbmRldiwgaW50IHVzKSB7DQo+ICsJc3RydWN0IGZlY19lbmV0X3By
aXZhdGUgKmZlcCA9IG5ldGRldl9wcml2KG5kZXYpOw0KPiArDQo+ICsJcmV0dXJuIHVzICogKGZl
cC0+Y2xrX3JlZl9yYXRlIC8gMTAwMCkgLyAxMDAwOyB9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZmVj
X2VuZXRfZWVlX21vZGVfc2V0KHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LCBib29sIGVuYWJsZSkN
Cj4gK3sNCj4gKwlzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSAqZmVwID0gbmV0ZGV2X3ByaXYobmRl
dik7DQo+ICsJc3RydWN0IGV0aHRvb2xfa2VlZSAqcCA9ICZmZXAtPmVlZTsNCj4gKwl1bnNpZ25l
ZCBpbnQgc2xlZXBfY3ljbGUsIHdha2VfY3ljbGU7DQo+ICsJaW50IHJldCA9IDA7DQo+ICsNCj4g
KwlpZiAoZW5hYmxlKSB7DQo+ICsJCXJldCA9IHBoeV9pbml0X2VlZShuZGV2LT5waHlkZXYsIGZh
bHNlKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsNCj4gKwkJc2xlZXBf
Y3ljbGUgPSBmZWNfZW5ldF91c190b190eF9jeWNsZShuZGV2LCBwLT50eF9scGlfdGltZXIpOw0K
PiArCQl3YWtlX2N5Y2xlID0gc2xlZXBfY3ljbGU7DQo+ICsJfSBlbHNlIHsNCj4gKwkJc2xlZXBf
Y3ljbGUgPSAwOw0KPiArCQl3YWtlX2N5Y2xlID0gMDsNCj4gKwl9DQo+ICsNCj4gKwlwLT50eF9s
cGlfZW5hYmxlZCA9IGVuYWJsZTsNCj4gKw0KPiArCXdyaXRlbChzbGVlcF9jeWNsZSwgZmVwLT5o
d3AgKyBGRUNfTFBJX1NMRUVQKTsNCj4gKwl3cml0ZWwod2FrZV9jeWNsZSwgZmVwLT5od3AgKyBG
RUNfTFBJX1dBS0UpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2
b2lkIGZlY19lbmV0X2FkanVzdF9saW5rKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2KSAgew0KPiAg
CXN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpmZXAgPSBuZXRkZXZfcHJpdihuZGV2KTsgQEAgLTMx
MjEsNDMgKzMxNTksNg0KPiBAQCBzdGF0aWMgaW50IGZlY19lbmV0X3NldF9jb2FsZXNjZShzdHJ1
Y3QgbmV0X2RldmljZSAqbmRldiwNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IC0vKiBMUEkg
U2xlZXAgVHMgY291bnQgYmFzZSBvbiB0eCBjbGsgKGNsa19yZWYpLg0KPiAtICogVGhlIGxwaSBz
bGVlcCBjbnQgdmFsdWUgPSBYIHVzIC8gKGN5Y2xlX25zKS4NCj4gLSAqLw0KPiAtc3RhdGljIGlu
dCBmZWNfZW5ldF91c190b190eF9jeWNsZShzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwgaW50IHVz
KSAtew0KPiAtCXN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpmZXAgPSBuZXRkZXZfcHJpdihuZGV2
KTsNCj4gLQ0KPiAtCXJldHVybiB1cyAqIChmZXAtPmNsa19yZWZfcmF0ZSAvIDEwMDApIC8gMTAw
MDsNCj4gLX0NCj4gLQ0KPiAtc3RhdGljIGludCBmZWNfZW5ldF9lZWVfbW9kZV9zZXQoc3RydWN0
IG5ldF9kZXZpY2UgKm5kZXYsIGJvb2wgZW5hYmxlKSAtew0KPiAtCXN0cnVjdCBmZWNfZW5ldF9w
cml2YXRlICpmZXAgPSBuZXRkZXZfcHJpdihuZGV2KTsNCj4gLQlzdHJ1Y3QgZXRodG9vbF9rZWVl
ICpwID0gJmZlcC0+ZWVlOw0KPiAtCXVuc2lnbmVkIGludCBzbGVlcF9jeWNsZSwgd2FrZV9jeWNs
ZTsNCj4gLQlpbnQgcmV0ID0gMDsNCj4gLQ0KPiAtCWlmIChlbmFibGUpIHsNCj4gLQkJcmV0ID0g
cGh5X2luaXRfZWVlKG5kZXYtPnBoeWRldiwgZmFsc2UpOw0KPiAtCQlpZiAocmV0KQ0KPiAtCQkJ
cmV0dXJuIHJldDsNCj4gLQ0KPiAtCQlzbGVlcF9jeWNsZSA9IGZlY19lbmV0X3VzX3RvX3R4X2N5
Y2xlKG5kZXYsIHAtPnR4X2xwaV90aW1lcik7DQo+IC0JCXdha2VfY3ljbGUgPSBzbGVlcF9jeWNs
ZTsNCj4gLQl9IGVsc2Ugew0KPiAtCQlzbGVlcF9jeWNsZSA9IDA7DQo+IC0JCXdha2VfY3ljbGUg
PSAwOw0KPiAtCX0NCj4gLQ0KPiAtCXAtPnR4X2xwaV9lbmFibGVkID0gZW5hYmxlOw0KPiAtDQo+
IC0Jd3JpdGVsKHNsZWVwX2N5Y2xlLCBmZXAtPmh3cCArIEZFQ19MUElfU0xFRVApOw0KPiAtCXdy
aXRlbCh3YWtlX2N5Y2xlLCBmZXAtPmh3cCArIEZFQ19MUElfV0FLRSk7DQo+IC0NCj4gLQlyZXR1
cm4gMDsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIGludA0KPiAgZmVjX2VuZXRfZ2V0X2VlZShzdHJ1
Y3QgbmV0X2RldmljZSAqbmRldiwgc3RydWN0IGV0aHRvb2xfa2VlZSAqZWRhdGEpICB7DQo+IC0t
DQo+IDIuMzkuMg0KDQpSZXZpZXdlZC1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo=

