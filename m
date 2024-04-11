Return-Path: <linux-kernel+bounces-140043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325208A0ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1AEBB2BA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA36813EFE6;
	Thu, 11 Apr 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HxMxeeZA"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B588524A;
	Thu, 11 Apr 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822263; cv=fail; b=J8iZMYKmGiqLhk9vnlnUpGb2mcMr9ZjDnroZ0LzA4xxD9+KnbOnT7fQftg/C7zZFDo/Hce3lPw121HEGk1PnGVQ89X24QRWWk93e7r6uNBr9XuPi00AR08ulbCSScZPs3lTQf+Yuhta4acgjf16AbAs2AFwWHrexKHPQToy1yO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822263; c=relaxed/simple;
	bh=3gIgMqDs78SpfhfFt9N5gm8e6AmdnO8ZGiKeiZTsUBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PIDXxTNcx0pg3fOeS0bVK0lHcx0kON1Zd3cC9jyDjeqsALENquLVg6nzSXtic5ogn9RhPtv6Bc9DcdeNeTl9v5ajYnkxBtEADXJZomsO/7nNVraN8a8O7vvfWypUwH+Az1cjvjb5H5HIlrp6qUwsEsgmFLIYfVCbG1MEAump9Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HxMxeeZA; arc=fail smtp.client-ip=40.107.105.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjo3pSxk6htVPlsThfp+5JTb8HUxeWk1JgJS8OJT4u9QsGifwa7xXXDvuykiljgSUlV/Dvy8RgB3kRr5XrCFUW/Pbdmvg0Yem1GjoBOgGbBR5g95BquKqbf/+7WCsiVIFYY7GQdQgc337ow5C8GAJIvOkZRaJaHJ2LV66XNZGk6YEzsTvTSHwE6bcMX5xnqiW7DeZMJlJLp+n/dQCVfV1mEr6TgW/sIAcfy8HQVf/CwXb5bboWdgXiBQHVhzea8ZQ0YcsCOME1ZVkPFAhm7lLmxOd2WGo8y1mjokXfCRHwWABdQH1DBmD8YBbBtIezwmi402sqdHD9BzBBTFFnfNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gIgMqDs78SpfhfFt9N5gm8e6AmdnO8ZGiKeiZTsUBA=;
 b=CR3KvT26tdZMqO9wjrZk6d4405Yg0k+m1rFNYya28uTSoSxczXxHCijID7DQUDDWGnaSoFoXEMQAqGYZ9igDoBLxrdblh1siHusf+WPacM3fzvQaIsJe5eDfENhTcSYzlO6wJhWdH2GJFlPCt0ZNPwFYwRWnn3M4FerRYdGugovgP9J9MeyfE6iDNNGUIW9PUwLQi/p3/B1UtpRoGHlhK2xV88VNoRpu44crhfracEIsD/UyzzfqosYq4CnKuCAzpMI/xXF+Vsjd+kzscYs59QfJmdMsl+z97sgMGuEBok6d16z9u4Hq9du8M6fqVMyoVc3w1wAWmEN/mCzmi40PeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gIgMqDs78SpfhfFt9N5gm8e6AmdnO8ZGiKeiZTsUBA=;
 b=HxMxeeZAf91IWxaxpv9GBwFPkjmfd+DusL5p9f6Zrnle1L2VDmoBv1mS/HRwAIqiXpfO7k7BxxJtOTL05Oo2Y7u4EI2JB11hEFan4kGbDUBNt1WYXGWBkr5xyn6CNS5mTenz4ZTWwVo25q1URfPK3CnBMsPiulSNSdBkRDN1XTo=
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by DBBPR04MB7691.eurprd04.prod.outlook.com (2603:10a6:10:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Thu, 11 Apr
 2024 07:57:34 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::fa84:b970:e920:615a]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::fa84:b970:e920:615a%5]) with mapi id 15.20.7409.046; Thu, 11 Apr 2024
 07:57:34 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>, Brian Norris
	<briannorris@chromium.org>
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
 AQHab2onJLj7by1TDUGmc5gbcJq9YLE4nU6AgAD7hoCABXXFAIAA1QEAgAAD/+CAAIccgIAA07QAgABoFOCAAvNSAIAEIpWAgAXgVOCABsmkAIAL6AowgAAHoQCAACsP0IAAfPsAgADo3ZA=
Date: Thu, 11 Apr 2024 07:57:34 +0000
Message-ID:
 <DU0PR04MB9636AF728C818073435A0E90D1052@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <ZfTspRKFgrO9xCTH@google.com>
	 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
	 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
	 <ZftaJEIeNfV7YrVo@google.com>
	 <PA4PR04MB9638F5037D1AB9BCF51CC9D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <Zf4rDifM6bLuqpX2@google.com>
	 <4e5f3741819e457c5c79d825c6520cb9ee531b95.camel@sipsolutions.net>
	 <PA4PR04MB96386917877832602F221282D13A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <ZgxCngq_Rguc4qs8@google.com>
	 <DU0PR04MB96365F2B6AFD856655D6A66CD1062@DU0PR04MB9636.eurprd04.prod.outlook.com>
	 <5cf6b243c3967cd5a630f8f8e5bf17f7c9010f01.camel@sipsolutions.net>
	 <DU0PR04MB96366A0E1FEBD7440F7536D0D1062@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <7af985e13d3254de73f9d68e1ad4ad1f81b5fd59.camel@sipsolutions.net>
In-Reply-To: <7af985e13d3254de73f9d68e1ad4ad1f81b5fd59.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|DBBPR04MB7691:EE_
x-ms-office365-filtering-correlation-id: 523b412c-1862-47d5-6ffb-08dc59fd0c39
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6RmaRwSAXC4a5A9kX1aIHUOLh+8iLh4krKHKXnx2NLLNMtSdWv90BXUGs7UPZquSBGeo5ERkSErXpZ4qDU82LPl04mBuM1xntb7p5D6lh1cU1Y0aF4O3nIKoLpD0+c43F3diNXpZoV4zhLNmS49D+iNZuFWQGWcKeQ70+QZdk7xzQ3LBoE2Hc+Iuhm4o62KvdjGEBBix+ZqqubYz2a3FxN1OLWGKG77DVYU8FamTxnYZlrmPbQMCWGF+fvQswTBHQNOb8GZBfGU5hMvJwJDJn5rC1JlqHxr5+mizr2L8ELJFUOIXwZkii0WKJiLf7BmPkNUcsZdSjVHy51Wgy/TSrSaur18hy/w4WU6pLcRzn2sdxoxBZD8pXxwfaCsMLG2InZN0c56PDoSpoia0joGpW94JQsAxfUCw7qfMFMQe7u8IvFx0HVTEjXViLu31FTwYTAVAZm6iXoWRdW9J+gdU26B2Hpv8zeVuCOnilJ5bOA17txPXcGMdJmcY2VfAuHR6A7PR7ItQnZSaW9S+WV9w0k9uogJ/mdl4vB1nBEv+yjXiILL/O2fJ3grNyVgQPjfIQuDwkenXXF7CyPAAsVx3ZlzbvPliOEGd++9P0ZDNqbfzxFObVKexhyfj+uURUBau/pzuI82+5k5Itje9LNwmLsCxViwvFI9YiYAnDQzkbyVP3lRaVkXLrJOZB/5J6KG+2zazMJLcBWxNC1OVJRTkOg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEI3M1N4aFdDNW1DUWEyalBjNXVGeCtUdm9yNDZtbVdsWVEvZWZWNktVSzh0?=
 =?utf-8?B?dUtwc2VTNnROU2p3cXFmd2tudkJ4QURLbm5wVGdPSVhZUngzOWQ2QmhBSGdv?=
 =?utf-8?B?Vk9kZU1JQXNnTlM4NGd3RDg3MDNxOSt2ZVc4c2ZMdGs3S0JleFlKd281YWhW?=
 =?utf-8?B?WW0ydE40c3NTVVlQL3dhTnBaMXFJbEh4VmsxdlJlZURjcnkxRFUvd3NDQk83?=
 =?utf-8?B?K0FlYTBDWVUyN3dqZ2ZqMzFzV3NuTTh5bjljVFJaMXU0TFZDSUhQZHRkaUJW?=
 =?utf-8?B?cE9GblFGNGlUcStWbHJIWlRGRGlxNHJ3MStHbjJjaWFwUlhyWGl4N05rd0wz?=
 =?utf-8?B?cTJOV0RoRDMra1NETFdja29kUkRjZHpBN0xtYXE3aHhFenJMaC9LdFBkdzBP?=
 =?utf-8?B?dm5CbzducldoREQ0a095dDkxM3NJR3M3MXZkTnFBL1dGZmxPT0pzeVRqUDVh?=
 =?utf-8?B?a1oxUzRaSjBXNGRmU3p1K1BZbjZQOVdvNzI1UDNqRWtHd0g5LzRHdUx3NW14?=
 =?utf-8?B?L3JmcTJ2NkF5bzZiMkR3UlA2a1VqRURieDNZZEtURTRiWWEra1lrbTJMNzh6?=
 =?utf-8?B?YkhpTVZGYk9MNHJlWWNLZlk2RjNNcnZuRys3R01YRkIyQ1pxZFQ4eUd6Y0x3?=
 =?utf-8?B?eUhhaUgvTUhLSTFuMWdTaUQzMUYzNXpHRGpEQ0FCZGhjeElwQjlLVzNCRkRW?=
 =?utf-8?B?Q2Z5Zk9rWHZjb0h6UXIzS01La0hKRDJiTkN5OXYvRC9LV3I1eEU5QU5zVnhJ?=
 =?utf-8?B?OXJBMVpkclAxSEE5aWhWb0pGSm9kamlTbzN4ZTdmcStNcW9Udk9aZHprTFNO?=
 =?utf-8?B?NjBGQ1d1OCt1RVV2VmVFRGJlakx2MVByT2Fld095V0NaYnFvellWL1FESGJC?=
 =?utf-8?B?Mmx1R2NDTFJDb2hGMGFkc1VEaFNLZC9sbWNBVzg3VVl4b1FZelNWZDdHTmpq?=
 =?utf-8?B?VWYyZG5wNXVuK1BKZzM4N0JZZGpPOTBDK08zcWhyajVRQ3p6eFNSTEJhSDhH?=
 =?utf-8?B?VXJYdWhVZXJUVzR6Rzh4RWxIRDdoenB4MklybWVYQ045UGtwK0hBQjZJaDln?=
 =?utf-8?B?amREb0tFRy8zby9VVlpKcVRWVlFrV2ZmZlJmSFEyanJ4WVNPTHZuRTI3V3VR?=
 =?utf-8?B?YStvNm1RWC9IY0hYcVhQS0ZBdnUxaUhVUDlpSW5EcFkrQy9TMGZiT21zcUxE?=
 =?utf-8?B?VW9BY1dCUzV1Rm5LZVlBNDFsSlZJR1k3ckV4aWJMZ1RpaTFZTGtDNHlaTXJU?=
 =?utf-8?B?ZkNabXhUQmhjVlcrL3pCbERLbGZxL0F3OEFUYnZ3WWVKeEQxZWlsWVNZbFlG?=
 =?utf-8?B?K0g2NUpVL0oybHdTYTA4bVoxaFhiVllWdVYzd0o5UWw3Rko3TXI4b1FnQ2xH?=
 =?utf-8?B?dzJMOFh0YnUxUlUzSUVoT29ONFVIRE1FSXdKbW4wUVlyTUk1blcxemdMeGo5?=
 =?utf-8?B?SkxaYzlJM1lKd3pIM1hlYlVuS1ZDN2l5dUluVlJoVTduYTN6TzBRcjJJa3Jy?=
 =?utf-8?B?ZTBiYzR3bDdOZHNabWhHcFVmUjRIWmpMZlBJdXl3d1RMVTZ2UmkxUlYrTXZ0?=
 =?utf-8?B?WnpOT29JSEVjWGQzenVjMk5kdkY5MUV3ZzI1Y0h0bGlreDl6Rndmd0EvV0xW?=
 =?utf-8?B?dk9zOE56Q3RURlUxTm54alhBLzJadGxrTHFBVEtkR2hHc2RUT0w3MnhSa2dk?=
 =?utf-8?B?amRERlBSVFowcVFNVUhwbnp3Nkx2SVZhVHVaTjdQZnNCVHlTV05SWVlhMlh4?=
 =?utf-8?B?eVV6cjNIWVc0d2Z3S0Ryem43d0dOSEw0b1lCbyttLzlDWDhXQVZhcjEvVTl1?=
 =?utf-8?B?TS9WMjZ3YXNKTUJtc0lRZjB6d0NIVWhiaWNqNWR5c3RUbnV3VWlhY3R3dGhF?=
 =?utf-8?B?L05UMW5UamlDSDg4N1dnZWNEOE1DSUp3cGZEazZlRUtzaC96eG83d1hHMnpL?=
 =?utf-8?B?cUliNDRYODJzd2ZGZkR6dWl2RU5EbUh3UFdIajd0T3NVUk1wdDdKUjRtbkVi?=
 =?utf-8?B?VkdpZU1GaEJhRThuVWpDR0FpREovOXFrdGMzbTNoY29Ic21Lb2FaaHBBaGRI?=
 =?utf-8?B?UG1XeWpPdUROaThoSjdpZ2Q5d3hkaytkN2hTbkpLNjQ2WUlFcFdJRVZYTXRh?=
 =?utf-8?Q?4sOOBa4sOvCkImHD97vGghS3N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523b412c-1862-47d5-6ffb-08dc59fd0c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 07:57:34.6297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsW5DxkEhhR0aefAZFowomq+7rYATOzLZ3pxX6VcinUm0uqrztrp7Ac7ojinTnxm9gpzFANY87ocGafzYXzPog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7691

PiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50
OiBUaHVyc2RheSwgQXByaWwgMTEsIDIwMjQgMTo1NyBBTQ0KPiBUbzogRGF2aWQgTGluIDx5dS1o
YW8ubGluQG54cC5jb20+OyBCcmlhbiBOb3JyaXMNCj4gPGJyaWFubm9ycmlzQGNocm9taXVtLm9y
Zz4NCj4gQ2M6IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY29AZG9sY2luaS5pdD47IGt2YWxv
QGtlcm5lbC5vcmc7DQo+IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgUGV0ZSBIc2llaA0KPiA8dHN1bmctaHNpZW4uaHNpZWhAbnhw
LmNvbT47IHJhZmFlbC5iZWltcyA8cmFmYWVsLmJlaW1zQHRvcmFkZXguY29tPjsNCj4gRnJhbmNl
c2NvIERvbGNpbmkgPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBTdWJqZWN0OiBS
ZTogW0VYVF0gUmU6IFtQQVRDSCB2OSAwLzJdIHdpZmk6IG13aWZpZXg6IGFkZCBjb2RlIHRvIHN1
cHBvcnQgaG9zdA0KPiBtbG1lDQo+IA0KPiBPbiBXZWQsIDIwMjQtMDQtMTAgYXQgMTA6MzMgKzAw
MDAsIERhdmlkIExpbiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gVGFrZSBSeCBkYXRhIHBhdGggYXMg
YW4gZXhhbXBsZSwNCj4gPiBJbiBjdXJyZW50IEZXLCBCQSBzdHJlYW0gc2V0dXAgYW5kIGRlLWFt
cGR1IGFyZSBoYW5kbGVkIGluIEZXLiBQYWNrZXQgaXMNCj4gY29udmVydGVkIHRvIDgwMi4zIGJl
Zm9yZSBwYXNzaW5nIHRvIGhvc3QuIEFtcGR1IHJlb3JkZXJpbmcgaXMgaGFuZGxlZCBpbiBob3N0
DQo+IGRyaXZlciAoTXdpZmlleCkgZHVlIHRvIG1lbW9yeSBjb25zaWRlcmF0aW9uLiBXZSB1c2Vk
IHRvIHdvcmsgb24gYSBkcml2ZXINCj4gdGhhdCB1c2VzIFJYX0ZMQUdfODAyMy4gSXQgd2FzIG9u
IGFuIG9sZGVyIFdpLUZpIHBhcnQgd2hpY2ggaGFzIG1vcmUNCj4gbWVtb3J5IGFuZCBwb3dlcmZ1
bCBwcm9jZXNzb3IuIEJ1dCB3aXRoIHRoaXMgY2hpcCBidWZmZXIgcmVxdWlyZWQgZm9yDQo+IHJl
b3JkZXJpbmcgZG9lc27igJl0IGZpdCBGVyBtZW1vcnkuDQo+ID4NCj4gPiBBbXBkdSByZW9yZGVy
aW5nIG5lZWRzIE1BQyA4MDIuMTEgaGVhZGVyLCBGVyBrZWVwcyB0aGUgTUFDIGhlYWRlciBpbg0K
PiBwYWNrZXQgZGVzY3JpcHRvciBzaW5jZSBwYWNrZXQgYWxyZWFkeSA4MDIuMyB3aGVuIGFycml2
ZSBhdCBkcml2ZXIuIEFzIHBhY2tldA0KPiBkZXNjcmlwdG9yIG9ubHkgYWNjZXNzaWJsZSBpbiB0
aGUgZHJpdmVyLCBNd2lmaWV4IGhhbmRsZXMgdGhlIHJlb3JkZXJpbmcgaW5zdGVhZA0KPiBvZiB1
c2luZyBtYWM4MDIxMSByZW9yZGVyaW5nLg0KPiA+DQo+ID4gV2l0aCBjdXJyZW50IEZXIGRlc2ln
biwgdG8gYXBwbHkgbWFjODAyLjExIHdlIGVpdGhlciBjaGFuZ2UgRlcgdG8gcGFzcw0KPiA+IHBh
Y2tldCBpbiA4MDIuMTEgZm9ybWF0IG9yIGRyaXZlciBuZWVkcyB0byBkbyB0aGUgY29udmVyc2lv
biBiYWNrIHRvDQo+ID4gODAyLjExICh3aGljaCBJIHRoaW5rIGRvZXNu4oCZdCBtYWtlIHNlbnNl
KQ0KPiA+DQo+ID4gR2l2ZW4gZXhpc3RpbmcgRlcgZGVzaWduLCB3ZSB0aGluayBpdOKAmXMgZGlm
ZmljdWx0IHRvIGFwcGx5IG1hYzgwMjExLg0KPiANCj4gSG1tLCBJIGRvbid0IHRoaW5rIHNvPyBJ
ZiB5b3UgaGF2ZSBhIG1hYzgwMjExIGRyaXZlciB3aXRoIFJYX0ZMQUdfODAyMywNCj4gdGhlbiBv
ZiBjb3Vyc2UgbWFjODAyMTEgY2Fubm90IGRvIHJlb3JkZXJpbmcsIGFuZCB5b3UgaGF2ZSB0byBk
byBpdA0KPiBzb21ld2hlcmUgYmVsb3cuIEJ1dCB0aGF0IGRvZXNuJ3QgbWVhbiB5b3UgbmVjZXNz
YXJpbHkgX2hhdmVfIHRvIGRvIGl0IGluDQo+IGhhcmR3YXJlL2Zpcm13YXJlPyBZb3UgY291bGQg
ZG8gaXQgaW4gdGhlIGRyaXZlciwgd2hpY2ggeW91IGFsc28gaGF2ZSB0byBkbyBpbg0KPiBhIGNm
ZzgwMjExIGRyaXZlciBhbnl3YXksIGFuZCB0aGF0J3MgT0suIER1ZSB0byB1c2FnZSBvZiBSU1Ms
IGl3bHdpZmkvbXZtDQo+IGV2ZW4gZG9lcyBpdCBpbnRlcm5hbGx5LCBhbHRob3VnaCBpdCBkb2Vz
bid0IGV2ZW4gaGF2ZSBSWF9GTEFHXzgwMjMuDQo+IA0KPiBCdXQgdGhhdCBnb2VzIGludG8gdGhl
IGRpcmVjdGlvbiBJIHdhcyB0YWxraW5nIGFib3V0OiB0aGUgYm91bmRhcmllcyBhcmUgZ2V0dGlu
Zw0KPiBmdXp6aWVyIGFsbCB0aGUgdGltZSwgYmVjYXVzZSBvZmZsb2FkcyBoYXBwZW4gYW5kIGdl
dCBzdXBwb3J0ZWQgaW4gbWFjODAyMTEuDQo+IFNvIGlmIHlvdSBoYXZlIG9mZmxvYWRzIGZvciBo
ZWFkZXIgY29udmVyc2lvbiBhbmQgb25seSBnZXQgc29tZSByZW9yZGVyaW5nDQo+IGRhdGEgIm91
dCBvZiBiYW5kIiwgdGhlbiB5b3UgaGF2ZSB0byBoYW5kbGUgdGhhdCBpbiB0aGUgZHJpdmVyLiBV
c2luZyBtYWM4MDIxMQ0KPiBkb2Vzbid0IG1lYW4geW91IGhhdmUgdG8gdXNlIF9hbGxfIG9mIGl0
Lg0KDQpGb2xsb3dpbmcgam9icyBhcmUgZG9uZSBieSBGVzoNCg0KMS4gTUFDIDgwMi4xMSBSeCBw
cm9jZXNzZXMgZXhjZXB0IGZvciBCQSBidWZmZXJpbmcvcmVvcmRlcmluZyBhbmQgQU1TRFUuDQoy
LiBDb252ZXJ0IDgwMi4xMSBmcmFtZSB0byA4MDIuMyBmcmFtZS4NCjMuIEVtYmVkZGVkIE1BQyA4
MDIuMTEgaGVhZGVyIGluZm9ybWF0aW9uIHRvIFJ4IGRlc2NyaXB0b3IgZm9yIGRyaXZlciB0byBk
byBCQSBidWZmZXJpbmcvcmVvcmRlcmluZy4NCg0KSWYgdGhpcyBGVyB3YW50cyB0byBsZXZlcmFn
ZSBtYWM4MDIxMToNCg0KMS4gVXNlIDgwMi4xMSBmcmFtZToNCiAgRHJpdmVyIHNob3VsZCByZXN0
cnVjdHVyZSA4MDIuMTEgZnJhbWUgYW5kIG1hYzgwMjExIHdpbGwgcmVkbyBqb2JzIGRvbmUgYnkg
RlcuIEkgdGhpbmsgdGhpcyBkb2VzIG5vdCBtYWtlIHNlbnNlLg0KMi4gVXNlIDgwMi4zIGZyYW1l
Og0KICBEcml2ZXIgc3RpbGwgbmVlZHMgdG8gZG8gQkEgYnVmZmVyaW5nL3Jlb3JkZXJpbmcgKG1h
YzgwMjExIGNhbiBoZWxwIHdpdGggQU1TRFUgd2l0aCBmbGFnIElFRUU4MDIxMV9SWF9BTVNEVSwN
CiAgYnV0IGNmZzgwMjExIGFsc28gc3VwcG9ydHMgZnVuY3Rpb24gaWVlZTgwMjExX2Ftc2R1X3Rv
XzgwMjNzKCkgdG8gaGVscCB0aGlzIGpvYikuDQogIElmIHRoaXMgaXMgdGhlIGNhc2UsIGl0IGJl
Y29tZXMgcmVkdW5kYW50IHRvIHBhc3MgODAyLjMgZnJhbWUgdG8ga2VybmVsIHN0YWNrIHZpYSBt
YWM4MDIxMS4NCg0KU28gSSB0aGluayBjZmc4MDIxMSB3aWxsIGJlIG1vcmUgc3VpdGFibGUgZm9y
IGV4aXN0aW5nIEZXLg0KDQo+IE9yaWdpbmFsbHksIG1hYzgwMjExIGRpZG4ndCBldmVuIGhhdmUg
UlhfRkxBR184MDIzIGFmdGVyIGFsbC4gQnV0IG9idmlvdXNseQ0KPiBhZGRpbmcgc29tZXRoaW5n
IGxpa2UgdGhhdCBhbHNvIHJlcXVpcmVzIG1vcmUgdXBzdHJlYW0gZW5nYWdlbWVudCA6KQ0KPiAN
Cg0KWWVzLCB3ZSByZXF1ZXN0ZWQgODAyLjMgZmFzdCBmb3J3YXJkaW5nIG9mIG1hYzgwMjExIGR1
ZSB0byBvdXIgcHJldmlvdXMgZnVsbHkgUnggb2ZmbG9hZCBGVyB3aXRoIHZlcnkgcG93ZXJmdWwg
V2lGaSBTb0MuDQoNCj4gSSB0aGluayB0aGUgcXVlc3Rpb24gaXMgYWJvdXQgdGhlIGRlc2lnbiwg
YnV0IEkgYWxzbyB0aGluayB0aGUgZGlmZmVyZW5jZXMgaW4gdGhlDQo+IGFzc29jaWF0aW9uIHBy
b2Nlc3MgYXJlIG11Y2ggbW9yZSBmdW5kYW1lbnRhbCwgYW5kIHlvdSBfZG9uJ3RfIChzZWVtIHRv
KQ0KPiBoYW5kbGUgdGhhdCBpbiB0aGUgd2F5IG1hYzgwMjExIGRvZXMvZXhwZWN0cywgdGhvdWdo
IHlvdSBhbHNvIGRvbid0IHNlZW0gdG8NCj4gaGFuZGxlIGl0IGluIHRoZSB3YXkgbW9zdCBvdGhl
ciBmdWxsLU1BQyBkZXZpY2VzIGRvICh3aGljaCBbY2FuXSBvZmZsb2FkIGV2ZW4NCj4gQlNTIHNl
bGVjdGlvbi4pDQo+IA0KDQpGVyBvbmx5IHN1cHBvcnRzIGFkZCBzdGF0aW9uIGNvbW1hbmQgZm9y
IEFQIG1vZGUuIEFzc29jaWF0aW9uIGNvbW1hbmQgaXMgdXNlZCB0byByZXF1ZXN0IGFuZCBhZGQg
Y2xpZW50IHN0YXRpb24gdG8gRlcuDQpGVyB3aWxsIGhlbHAgdG8gY29ubmVjdCB0byBBUCBhbmQg
cmVwbHkgcmVzdWx0IHRvIGRyaXZlci4NClRoaXMgaXMgYW5vdGhlciByZWFzb24gdGhhdCB3ZSBu
ZWVkIHRvIHVzZSBjZmc4MDIxMSBpbnN0ZWFkIG9mIG1hYzgwMjExLiBGb3IgbWFjODAyMTEsIG1h
bmFnZW1lbnQgZnJhbWVzIGFyZSBwYXNzZWQNCnRocm91Z2ggaWVlZTgwMjExX29wcy50eCBhbmQg
c3RhdGlvbiBpcyBhZGRlZCB2aWEgaWVlZTgwMjExX29wcy5zdGFfYWRkLiANClRoaXMgd2F5IGNh
bid0IHdvcmsgd2l0aCBGVyBmb3IgY2xpZW50IG1vZGUsIEZXIGNhbid0IG5vdCBiZSBieXBhc3Nl
ZCBmb3IgYXNzb2NpYXRpb24gcHJvY2VzcyBmb3IgY2xpZW50IG1vZGUuDQoNCj4gVGhlIHRoaW5n
IEkgd2FudCB5b3UgdG8gdW5kZXJzdGFuZCBpcyB0aGUgcmVsYXRpdmUgYXJjaGl0ZWN0dXJlIGFu
ZCBob3cgeW91cg0KPiB3b3JrIGZpdHMgaW50byB0aGlzLiBJJ20gbm90IHRlbGxpbmcgeW91IGhh
dmUgdG8gY2hhbmdlIGl0IHJpZ2h0IG5vdyBvciBkbyB0aGlzDQo+IHdvcmsgZGlmZmVyZW50bHks
IEkganVzdCB3YW50IHRvIG1ha2Ugc3VyZSB5b3UgYWN0dWFsbHkgdW5kZXJzdGFuZCBpdC4gVGhl
IGFib3ZlDQo+IGFyZ3VtZW50IGdvZXMgc29tZSB3YXksIHNob3dpbmcgeW91J3ZlIGFjdHVhbGx5
IGxvb2tlZCBhdCB0aGUgZGlmZmVyZW5jZXMNCj4gbWFjODAyMTEgd291bGQgaW1wbHksIHdoZXJl
IGJlZm9yZSBJIGZlbHQgeW91IHdlcmUgcHJldHR5IG11Y2ggaGFuZHdhdmluZw0KPiBpdCBhd2F5
IGFzIGlmIGlycmVsZXZhbnQgdG8gdGhlIGRpc2N1c3Npb24uDQo+IA0KPiBqb2hhbm5lcw0KDQpU
aGFua3MgZm9yIHlvdXIgY29tbWVudHMgYW5kIHN1Z2dlc3Rpb25zLiBJIHdvbmRlciBjYW4gSSBw
cmVwYXJlIHBhdGNoIHYxMCB0byBsZXQgdGhpcyBwYXRjaCBiZSBhY2NlcHRlZD8NCg0KRGF2aWQN
Cg==

