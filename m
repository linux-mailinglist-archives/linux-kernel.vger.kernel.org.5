Return-Path: <linux-kernel+bounces-77791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C3860A48
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3BBAB20D75
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7FE125A1;
	Fri, 23 Feb 2024 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lKoSLsZ2"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3B101E3;
	Fri, 23 Feb 2024 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666585; cv=fail; b=dqVdwJm39BLuxib2wQRazvpRuF4zKwoPpAFOk5WJBul1VQQ+2GNKehUawsZ4HnF977Su9x7hn7MAHQKcecOvkx/afk/GoUolyNaSHdwilSIe+J5MNR0FUC4gphqRAYncfETEmdP1J+GTQCHN0mS6eTlt7eoBNKW/pe8xfqsQAG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666585; c=relaxed/simple;
	bh=ReF10HgqF3VFQEmD5cCISoFbCf3EHDmU5JkDeztaFis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UTKr3oWsTmJNqI20N4dlvGpR3TtWa7sgd+m7wBj5Ovf3Y9lKmTVeHGIZWgWurZSoZcH+CGNs7uAvtRUkqebxqQrNRYMhlHGMXhTsJu2FnWJFhCXwgWrcDUVgHp5FL4Md+OJo2bnJSTm05JQ6FZS1WII6X+bkjLpmmepk+B/Ym2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lKoSLsZ2; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH86Rn/Ox1dIkscNp671oeXnpPGkGKuPGFCFhyXFRHjolftJ3mj5oXm1NT9G96ypaIOnIob8kE31MBB9rYrYE9keOGfnyLkLQExHChbuE7F5XKoyIFtNFaufbTUS5SjL4jrXu1hoDd4hqcyAIpzgmpvVbZiIvOZqdOpn6q2nb6qJheq6bkbXiggDip1YJdBzuru65+iEYJ52QOIOpuWoPtlI4/yvUzFD+DKrm7ld9MsfphCLL5x1uEB3TRjKdUv6AMI3Vb9o378QVXbkUrty5MZcrp/qHKE5+cjpjW9IrzlJgAYpgtXqcj0cbx8aD5ktSzs2FzptC611SmdwNrgBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReF10HgqF3VFQEmD5cCISoFbCf3EHDmU5JkDeztaFis=;
 b=XGkvX0VqM2vMw4o5SabzklabsfV4ac20IXD6AtOmuqAxJWmD4khisFB1R4gkogf9pdNRYp3mi6UXzFKp5PP5iNWWKeRjNUgVFiS1cX+Yu636BPPtWDAs1PWJlNKknZyPxzWZHFJ2xiXNn3pgljG9ieaGVjxFifOF6vIl4KC4/So5KVNf2Ubb0DVZJk60G8fN5p5y4PQScpEjr4nZqmMhiSLtRzyyX6emAAJyF5H/nmU3AaJmJUOImN6hYGKbmXOOCOrknGJCFaJ/ZU8cFtfHv5L3uBdsfJlH2Ul/xKvIx6Xoo3wgfOtwDMDGK6viMw7GOxu1/CVrNtgDywAWee1hzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReF10HgqF3VFQEmD5cCISoFbCf3EHDmU5JkDeztaFis=;
 b=lKoSLsZ2ISWygEgn9QDZX8ceGi9l/WmLgbWbpb1L4sAumWFWC1YqNmL3Fp3huf+WP/xT/+fkjP6+ga3KyYgvmZW7QasvCGOgtrE/hYctR9Rx2FGA/iTAw/A0OOY2h7Krz2MSw0qnaD3LyiqQldzMMlzC4R02yC7CX6b7lZLcF6E=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB9PR04MB9257.eurprd04.prod.outlook.com (2603:10a6:10:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 05:36:19 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::fd19:496c:4927:ac32]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::fd19:496c:4927:ac32%7]) with mapi id 15.20.7292.033; Fri, 23 Feb 2024
 05:36:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
CC: Florian Fainelli <florian.fainelli@broadcom.com>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH net-next v5 2/8] net: phy: Add phydev->enable_tx_lpi to
 simplify adjust link callbacks
Thread-Topic: [PATCH net-next v5 2/8] net: phy: Add phydev->enable_tx_lpi to
 simplify adjust link callbacks
Thread-Index: AQHaZI4yfGkQ/qlZBkGTMqLin9bhCbEXaKgw
Date: Fri, 23 Feb 2024 05:36:18 +0000
Message-ID:
 <AM5PR04MB3139BF92ABAE988EAD75088D88552@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-3-o.rempel@pengutronix.de>
In-Reply-To: <20240221062107.778661-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DB9PR04MB9257:EE_
x-ms-office365-filtering-correlation-id: 7de07d83-bde6-47d8-6209-08dc34315c87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2utzjnsIXFhzvuMGOXbsrVkXId3TUnVutMNgK+xjxmUz6prOYfzanrfsvR/QDljhOK1VsYpPeBKjkrm6uT7NmdTTk0IU1RT5KcN5mEOU1ikHg5SOq9a0FlQDZ4reLg9sPtiIy4TpZtP2b/SaItsFMdAp+2EMCrTLvtWY9KzrxLxp6nYVjq40zQFX0AhbC6Iw9TePPU3kwcNd0wlokuXqSGPMubNldXBpIcxy4zV00s363PjbodXLlaNwlyrjoWPlXvbSLw9V/3GZ/mxhUcYp03IgNWhrc0+fKGnubCwZBLxFNaa/uifOgBtOuHb7b18A7PhbbFKZ4JVOucfFidKobjq+fBEON1CHFy2rALyBWRbnPHPPFh/U1dMor828hGt4a6pjBdaDGMo7j3zQokRoAjQ0TNjoyqoz870xdDI+HNN8Hxq6H36V8quVUs6ABr/olc7pS6gU/4vY6fQs+lwPCaa18xwwXzmKeZNAutIchwv4pp49c249JSPI+1Bxs2C6FvQobdLFtRAJ1e0wKLrtoNPw/997yXEPKwKLkplOUuLLMlka9X3/pnGP0fOluoc3Dyuh3AjBDISNIOoBoGTlDIuUTdOPZKAtzKs90LGr2VOzZvvFV5CohZbhZDdFcEOt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eW1sTkREVnhxdEJaaDNJK2xYRzZJSElzRjE3NXZlWTNwWUZ5bEE1UHlRZExS?=
 =?gb2312?B?V1MwaWJYM1ZabmZhcE13OVpCUU1iU2ppTWVVbmk0WVlDTWFCZHJOSGY4UUYw?=
 =?gb2312?B?cU9yNncvb2ZqVTZzZTZZdnhTdXl1NnF5dkhieloxRjZCK3dOUHJZQVRNZDBs?=
 =?gb2312?B?MGlPWkNQVzIycDVjam05anZXQlBYaXlzZ3d5bXhHejhrT09vMm45YTB1aVRh?=
 =?gb2312?B?VEhWb1ZldVR6b0J4azZGMXA4TlJEOWZIVGI3MnFQZ0ZjQU9LQUVYRkxYNG5T?=
 =?gb2312?B?YWxzdkRYODlWMHp6STBhYmdMdmo4YnZHMHJ1T05MN01iUk5sWVJJekFiYzZO?=
 =?gb2312?B?ZFhCS3BOdHhvclpWNTBmQ2xCbk4ybGRzRnNlMkJOWUtYcml6WFNVUFBFeUJp?=
 =?gb2312?B?RzlZTUc4eTQyciszK3dFQVBDU2FLN08wK2sxd1Y5NTY1UzlHYm0wSlYxMmQy?=
 =?gb2312?B?bS9GZzZBdDVGUkxXempOVkNCVncyamErM1h1SWowUG5MMDdPODNtQzFlRnlS?=
 =?gb2312?B?V3gycGZZYWthM3BGcDcyaktIVytRN0pVNSs4Q29RMmd1VDVNTmM5bTRwU085?=
 =?gb2312?B?U2pMZkd6UEtsRkQrRnl1UElzMCtNUC9ZaDR3TmdqU2l2L2Q0bUhlZ0w2akxZ?=
 =?gb2312?B?aXFqbGg0bnNjdHNxT2RIVmJWTE1laDB2TGd4U3BMTGtHK0hod2pEYUx2L0I4?=
 =?gb2312?B?TlZmbDJiYjBBSWtZQ0RtZzRTMVpySWJRMjdIdGd2MXpocXpuYUpSQ042ZEJR?=
 =?gb2312?B?cWIyUk9lZVRnTmZQbkZMVVcrU2pRRlA1aFNwUk5NRDdySThFWGVybUxYemhs?=
 =?gb2312?B?Z0RZUWZuZUluNGJMdllFKzU2Qllmc1hYSHh1RExxaUxGcHlaV0JpVEpJL2hG?=
 =?gb2312?B?U3ArSVJIYmZTZGJJY0ZJYyszWEJpMVdGc0dEOTYxeHltZWQxcWo2NlVpb2Qw?=
 =?gb2312?B?THVXUXduNnpHanlTNitycGg3eEp1SmdPNFNmVmVWRzVUcmltYU10TW1RbTFM?=
 =?gb2312?B?cHNIM2JzTXY5L05kNnk5UXZHbHhvdW9CRmVwb1h0UklMQy9GQUhjR090emZZ?=
 =?gb2312?B?TTJhaTdPVC9JSEZGTGMrVjU3YStjN3dvNEdLWTNFTjFKTGtJeXczU254OVpt?=
 =?gb2312?B?bC80VTFDRmx6NkVmcFZoZVEyTU1QZllzUldXR3hjekt6blo2eXovZHBZRTk0?=
 =?gb2312?B?VTk5UllldUZxS0gveSt5SEw1NTJYZEpBczcxckFoRURpQ1hoaSszL3BtT1JP?=
 =?gb2312?B?NGhiL1ZVZnVvUldTL2RDMHA2QXlRcFNlbGtqaDY2a2p4eGlVemcwaWptaGtD?=
 =?gb2312?B?ZjFnUjNNWndYTlZESDY0MWU2UU0vTy81SGNoenpwc0JSVVpPWnFqd3B4SXpp?=
 =?gb2312?B?Y3dWRnFCdGpmUUVoay91bTVsZ2kveTBnNVhER3psSkV0K1RIQVRpNFp3U1Qz?=
 =?gb2312?B?WURtWnNCWWt3Y2JKc012MFRPNUtRVDBDZ05pd1RidlJQSjV3NmhLODhNdzZN?=
 =?gb2312?B?YVorN01FRkhSeEVWeC93QlR3dEkvU0NuSDcrQ0h4VkY0RERITUdhWWxZUm9p?=
 =?gb2312?B?VXIrS3BXc0hjcWJNYkxVendqZGR5MmdweHRGUUhoNEtGYVJCdEh1Z3RIZXJE?=
 =?gb2312?B?NVR4aUl0c29JZ3ZjKzFhNFdoYllQWWNvb0M5bFJGTjJueUx2SXhzOE5QOHdO?=
 =?gb2312?B?OFpjNzJ2UHhvWnM4a1c3eUV3ZHlTTmF2ZmluYUovUUVac2h0WDZseGk4S3Uz?=
 =?gb2312?B?dHlZSUdnRUMyWDRoVEcwcXlpMXJEVEJ6S08wQzVVbzJYSkJKbG9hNkpkQzZ3?=
 =?gb2312?B?eUtvd0lNaUNWQ0Y5VE1hdUhoNzgrZnE1bHpManFTRlhobjBMOG1sM2ZRclI3?=
 =?gb2312?B?Y2dBNVFsVEc3UWpySHFuQXlkNDNXblRCblJGNVdaZkRGTkIvZlV2MFpBRlEr?=
 =?gb2312?B?VnlMOEpaM3VyZjNhWDIweVVsR3RzUnpHby9BNGRnb21wTEk1K3lRRE1jTDdC?=
 =?gb2312?B?ME9pWUtyYXRoYWJyVm5UZnlqNks2RVI1L3RVem9wWEk4SXFMOHplcmNkUGRi?=
 =?gb2312?B?QTMxeDk2NlQ5Rk5tc0c5VHVUWGZnYkViYnIzRjM2OVhjK0ZQRXc3UjFuN3Zi?=
 =?gb2312?Q?pTGc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de07d83-bde6-47d8-6209-08dc34315c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 05:36:19.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jc5DQy966Borg6hsJa57it08Zao/Wisv+UwBeHLQFvWVPdhqKpA9pgCAXJ35E3Wd03sfvLigvTvO1GYP7xxDuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9257

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbGVrc2lqIFJlbXBlbCA8by5y
ZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjTE6jLUwjIxyNUgMTQ6MjENCj4gVG86
IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsNCj4gRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47DQo+IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0
LmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47DQo+IEhlaW5lciBLYWxsd2VpdCA8
aGthbGx3ZWl0MUBnbWFpbC5jb20+OyBSdXNzZWxsIEtpbmcNCj4gPGxpbnV4QGFybWxpbnV4Lm9y
Zy51az4NCj4gQ2M6IEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20u
Y29tPjsgT2xla3NpaiBSZW1wZWwNCj4gPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPjsga2VybmVs
QHBlbmd1dHJvbml4LmRlOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBTaGVud2VpIFdhbmcNCj4gPHNoZW53ZWkud2FuZ0BueHAuY29tPjsg
Q2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsNCj4gZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIG5ldC1uZXh0IHY1IDIvOF0gbmV0OiBw
aHk6IEFkZCBwaHlkZXYtPmVuYWJsZV90eF9scGkgdG8NCj4gc2ltcGxpZnkgYWRqdXN0IGxpbmsg
Y2FsbGJhY2tzDQo+IA0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IA0K
PiBNQUMgZHJpdmVycyB3aGljaCBzdXBwb3J0IEVFRSBuZWVkIHRvIGtub3cgdGhlIHJlc3VsdHMg
b2YgdGhlIEVFRSBhdXRvLW5lZw0KPiBpbiBvcmRlciB0byBwcm9ncmFtIHRoZSBoYXJkd2FyZSB0
byBwZXJmb3JtIEVFRSBvciBub3QuICBUaGUgb2RkbHkgbmFtZWQNCj4gcGh5X2luaXRfZWVlKCkg
Y2FuIGJlIHVzZWQgdG8gZGV0ZXJtaW5lIHRoaXMsIGl0IHJldHVybnMgMCBpZiBFRUUgc2hvdWxk
IGJlDQo+IHVzZWQsIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSwgZS5nLiAtRU9QUFJPVE9OT1RT
VVBQT1JUIGlmIHRoZSBQSFkgZG9lcw0KPiBub3Qgc3VwcG9ydCBFRUUgb3IgbmVnb3RpYXRlIHJl
c3VsdGVkIGluIGl0IG5vdCBiZWluZyB1c2VkLg0KPiANCj4gSG93ZXZlciwgbWFueSBNQUMgZHJp
dmVycyBnZXQgdGhpcyB3cm9uZy4gQWRkIHBoeWRldi0+ZW5hYmxlX3R4X2xwaQ0KPiB3aGljaCBp
bmRpY2F0ZXMgdGhlIHJlc3VsdCBvZiB0aGUgYXV0b25lZyBmb3IgRUVFLCBpbmNsdWRpbmcgaWYg
RUVFIGlzDQo+IGFkbWluaXN0cmF0aXZlbHkgZGlzYWJsZWQgd2l0aCBldGh0b29sLiBUaGUgTUFD
IGRyaXZlciBjYW4gdGhlbiBhY2Nlc3MgdGhpcyBpbg0KPiB0aGUgc2FtZSB3YXkgYXMgbGluayBz
cGVlZCBhbmQgZHVwbGV4IGluIHRoZSBhZGp1c3QgbGluayBjYWxsYmFjay4gSWYNCj4gZW5hYmxl
X3R4X2xwaSBpcyB0cnVlLCB0aGUgTUFDIHNob3VsZCBzZW5kIGxvdyBwb3dlciBpbmRpY2F0aW9u
cyBhbmQgZG9lcw0KPiBub3QgbmVlZCB0byBjb25zaWRlciBhbnl0aGluZyBlbHNlIHdpdGggcmVz
cGVjdCB0byBFRUUuDQo+IA0KPiBSZXZpZXdlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zmxvcmlh
bi5mYWluZWxsaUBicm9hZGNvbS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBMdW5uIDxh
bmRyZXdAbHVubi5jaD4NCj4gU2lnbmVkLW9mZi1ieTogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVs
QHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gdjIgQ2hlY2sgZm9yIGVycm9ycyBmcm9tIGdlbnBo
eV9jNDVfZWVlX2lzX2FjdGl2ZQ0KPiB2NTogUmVuYW1lIHRvIGVuYWJsZV90eF9scGkgdG8gZml0
IGJldHRlciB3aXRoIHBoeWxpbmsgY2hhbmdlcw0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3BoeS9w
aHkuYyB8IDcgKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC9waHkuaCAgIHwgMiArKw0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9waHkvcGh5LmMgYi9kcml2ZXJzL25ldC9waHkvcGh5LmMgaW5kZXgNCj4gMTQyMjRlMDZk
NjlmLi5hNTRiMWRhZjVkNWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9waHkuYw0K
PiArKysgYi9kcml2ZXJzL25ldC9waHkvcGh5LmMNCj4gQEAgLTk4Myw5ICs5ODMsMTYgQEAgc3Rh
dGljIGludCBwaHlfY2hlY2tfbGlua19zdGF0dXMoc3RydWN0IHBoeV9kZXZpY2UNCj4gKnBoeWRl
dikNCj4gIAlpZiAocGh5ZGV2LT5saW5rICYmIHBoeWRldi0+c3RhdGUgIT0gUEhZX1JVTk5JTkcp
IHsNCj4gIAkJcGh5X2NoZWNrX2Rvd25zaGlmdChwaHlkZXYpOw0KPiAgCQlwaHlkZXYtPnN0YXRl
ID0gUEhZX1JVTk5JTkc7DQo+ICsJCWVyciA9IGdlbnBoeV9jNDVfZWVlX2lzX2FjdGl2ZShwaHlk
ZXYsDQo+ICsJCQkJCSAgICAgICBOVUxMLCBOVUxMLCBOVUxMKTsNCj4gKwkJaWYgKGVyciA8IDAp
DQo+ICsJCQlwaHlkZXYtPmVuYWJsZV90eF9scGkgPSBmYWxzZTsNCj4gKwkJZWxzZQ0KPiArCQkJ
cGh5ZGV2LT5lbmFibGVfdHhfbHBpID0gZXJyOw0KDQpwaHlkZXYtPmVuYWJsZV90eF9scGkgPSAh
IWVycjsgSXMgdGhpcyBiZXR0ZXI/DQoNCj4gIAkJcGh5X2xpbmtfdXAocGh5ZGV2KTsNCj4gIAl9
IGVsc2UgaWYgKCFwaHlkZXYtPmxpbmsgJiYgcGh5ZGV2LT5zdGF0ZSAhPSBQSFlfTk9MSU5LKSB7
DQo+ICAJCXBoeWRldi0+c3RhdGUgPSBQSFlfTk9MSU5LOw0KPiArCQlwaHlkZXYtPmVuYWJsZV90
eF9scGkgPSBmYWxzZTsNCj4gIAkJcGh5X2xpbmtfZG93bihwaHlkZXYpOw0KPiAgCX0NCj4gDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BoeS5oIGIvaW5jbHVkZS9saW51eC9waHkuaCBp
bmRleA0KPiBlM2FiMmMzNDdhNTkuLmE4ODBmNmQ3MTcwZSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9waHkuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3BoeS5oDQo+IEBAIC01OTQsNiAr
NTk0LDcgQEAgc3RydWN0IG1hY3NlY19vcHM7DQo+ICAgKiBAc3VwcG9ydGVkX2VlZTogc3VwcG9y
dGVkIFBIWSBFRUUgbGlua21vZGVzDQo+ICAgKiBAYWR2ZXJ0aXNpbmdfZWVlOiBDdXJyZW50bHkg
YWR2ZXJ0aXNlZCBFRUUgbGlua21vZGVzDQo+ICAgKiBAZWVlX2VuYWJsZWQ6IEZsYWcgaW5kaWNh
dGluZyB3aGV0aGVyIHRoZSBFRUUgZmVhdHVyZSBpcyBlbmFibGVkDQo+ICsgKiBAZW5hYmxlX3R4
X2xwaTogV2hlbiBUcnVlLCBNQUMgc2hvdWxkIHRyYW5zbWl0IExQSSB0byBQSFkNCj4gICAqIEBs
cF9hZHZlcnRpc2luZzogQ3VycmVudCBsaW5rIHBhcnRuZXIgYWR2ZXJ0aXNlZCBsaW5rbW9kZXMN
Cj4gICAqIEBob3N0X2ludGVyZmFjZXM6IFBIWSBpbnRlcmZhY2UgbW9kZXMgc3VwcG9ydGVkIGJ5
IGhvc3QNCj4gICAqIEBlZWVfYnJva2VuX21vZGVzOiBFbmVyZ3kgZWZmaWNpZW50IGV0aGVybmV0
IG1vZGVzIHdoaWNoIHNob3VsZCBiZQ0KPiBwcm9oaWJpdGVkIEBAIC03MTMsNiArNzE0LDcgQEAg
c3RydWN0IHBoeV9kZXZpY2Ugew0KPiANCj4gIAkvKiBFbmVyZ3kgZWZmaWNpZW50IGV0aGVybmV0
IG1vZGVzIHdoaWNoIHNob3VsZCBiZSBwcm9oaWJpdGVkICovDQo+ICAJdTMyIGVlZV9icm9rZW5f
bW9kZXM7DQo+ICsJYm9vbCBlbmFibGVfdHhfbHBpOw0KPiANCj4gICNpZmRlZiBDT05GSUdfTEVE
X1RSSUdHRVJfUEhZDQo+ICAJc3RydWN0IHBoeV9sZWRfdHJpZ2dlciAqcGh5X2xlZF90cmlnZ2Vy
czsNCj4gLS0NCj4gMi4zOS4yDQoNCg==

