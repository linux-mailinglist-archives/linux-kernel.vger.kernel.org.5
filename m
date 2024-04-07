Return-Path: <linux-kernel+bounces-134319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369EA89B047
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17B8B2164E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BFA179AD;
	Sun,  7 Apr 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A0TTcDfb"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603614F78;
	Sun,  7 Apr 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712484292; cv=fail; b=Mgi3jVBqYoTU1S6WSAp+sfKAGRhi3tnifQONJo9Iu/tXOUfVfUX7iYVp+JWwqgTIRXIJvc5VcfTZe0ltd1fs/KHcZ3audK2ijmbvCwNTHCTSH0liL5p2RIqoKhftd8EPACEyWqkmCktqVwkqd0j8eXefyZ5f9WbhOkQiJ+LP2jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712484292; c=relaxed/simple;
	bh=U8IclA8d6abvKpqV0QVQ0xX2VeVV/CKXRc4sVIXPJA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gXU0K89f9VJyatGmUYEDydujyoQXjH20N2Pd57zMewjSL+Z1SN+maJ7nACE+O5Yx8WYFOu4nUybR61AM2VWp8W3eqZhKC8d9xd2BOdoXwkcSL4SbAdSHIrvaARIwbSvNAa1etxRDzY4YFDo/f92gzVotZ5mnDje5GETiVuU0puI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A0TTcDfb; arc=fail smtp.client-ip=40.107.22.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPsuvuQenSVip5nup0jA0z5fk5pMu4C3Y624NFzToMPs0kAzUWfZ72dK/Ipp/lgCuIGZCISEwAKmGLBItiWJC3VijQeEoJdaeqrk6/tTRJ309QNYjaQgeR7shimGLNT1LyYjoQ/ebSurw3sFdsTfGCQqfDSz3BkIQnlPRJ2V94Tgju4TQ0AGbAAYr9uCvGPcvyc9SfWnT6hQgOdVnS0AoPNSh1vU1sqkcXnwPioUa6i0VrZ02gILos93y0ro2Lo5GUFwdT0CEZuuwb0BPa0NZ5zSUMlI3rdaPtEt4oQ/JL/j67OV8NGMC8Mg4yUeZ8cT59zz0OrYCvNNuYqrG2BKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8IclA8d6abvKpqV0QVQ0xX2VeVV/CKXRc4sVIXPJA0=;
 b=bVyb1gOxEvdemGOXQH+NXEFlZzf7rABs5gCn9Vac+pFz4ZMiOapH7kzkflH22yuCa5rvmF7IAIdUvrmVfWa/21HDfwuHfIbY9A0ZIm6WsLdQEwydLRPeVrZSNoUVijLrxtSRASJ/h6dqUkNJ2XpolbX+hZl16Fg3KNCncvyNkD2Isx6XTCZsrcnS0Fx+BQfibRAgPsFp2OEDrsN60qLneRjyN5WhH01fW590sSuqmr0KfDU8qGOxUBzC6/y0c3ioAX11O+v3jHrY/h9GW1iJfNxeUUUtju3SJ8ImzuqCz98mRN+mYgfGy5eY0xeu1IpffpqN2q0qvLZ92dgwxgoO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8IclA8d6abvKpqV0QVQ0xX2VeVV/CKXRc4sVIXPJA0=;
 b=A0TTcDfbLDRttDVjS/k6vSLHkJdYkvW2H3Gn11vNUY9vXS03bXy9i6BckbGCyR7KcHq00CdpT/yNcp39K/dw6XswwfjEyz/P8Q/wQBUZ011ayIFsGbw6gchJeunWQaQTK4EMdNs82/m+U9UnPd4NywiIUPRh+Fe89lwrYy5dYgs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 10:04:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 10:04:47 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
Thread-Topic: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
Thread-Index: AQHah1U2hf+AkPhDj02wsn9yNtLUjbFbE9+AgADkvNCAAItFAIAAEwgg
Date: Sun, 7 Apr 2024 10:04:47 +0000
Message-ID:
 <DU0PR04MB9417C5B9BDD9E0B47E7494C088012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-1-9fc9186856c2@nxp.com>
 <614b5107-656d-4d41-99c1-77941c48342c@kernel.org>
 <DU0PR04MB9417932A6208128FBBB22C4188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <09f6b752-6b72-49d7-b248-6faba2fd13a7@kernel.org>
In-Reply-To: <09f6b752-6b72-49d7-b248-6faba2fd13a7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM7PR04MB6870:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6z80GCAaR6JovIQpN/4aTQ54ckll7HLTpHsAzfflJ3SGQJTPkz0nQzbuEJOJIBBkbvNFZB6tOSfL1jYIlL5wIbjGbPvrK+4QzKPpH+K9i6IIS2wTQ3SWS1aWE0Cz7hArxYcvjLbUX8a3+mhYbQU2qAtXsMAzkpH/pZaKV5qiz0KlAEOkPRnXeB1OczKLLqDuqr8QDlSer9PQ3j+tdQPHBamPj22rM5n6PS76yIVaIDBkbikx/hUJCfS0u/zOmqLw7B1LA3eTNRKdnUsWV/AVB4L66++bWD5rrt2V10zajuhCT4BlIIGDkpnVyI89Dl07iRQekcj752lVgUan07D54XEZlh5aDrKNZ65UZQhwwRzBbNL8+kOt+9j+tJ0UpyyIVORzhUxlwX2V/9tTWh3zrOViKyxFD7UdgSIfdGX0njfOf8rsqi4V087MweiaoF0vaX99C0l6TbAScnRW/1F35nRFjPYJDyhfg/xhwdm9E0rPxG3RU7rUgf0YJ0C+VISCsjuXCZAhxUpGuu0kdTgoE9j7UHuzxkHHFFv9j6rOX5BK72CIgQ3AMCOk0RJYx3eixB017C06K4TUuEjKJXxOQIpdqP+NA8PRtLGk0mvPvLey6bxX9RyTyRdSoCduQMFFfa2WOIxaMcqCFRIrgEw4Ey0B2Msj96dGTNGzkAX+pl0HAKniStZr5em6pm9dhmvLiRdIlXTHvHTC49Z6JUkg4A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlpKMVVzTjFtZm1EZVVhUEpyYVd2c3ZUTCtRM1VDUVltZ3QycEVIUHdqb1dK?=
 =?utf-8?B?ZkwrbWpoTWdYV1M1UCtyNG9XOVhzZS85VmJqR2RiODZFc1dBeDVQMWtGeEZw?=
 =?utf-8?B?aklqTlRPbm5QNXJVT3lFa0EwM0tiR2hJWjB3QlFCbDk3K0dMaHRjQ3hEYjh2?=
 =?utf-8?B?ZkZTU24ybGhFa3FwaUhzVXBNVjZyYmdZaS93N1FRenpiaStabVlaYkkxQjNE?=
 =?utf-8?B?MnhVenFPdG1NTWgraml3WllvUWJFc1kxdFFRVmF3aUcycWwxRHlSenJQVHkx?=
 =?utf-8?B?NDFxciszdzhVYmxyUFB4NTMwUFc3bTc2ZHJhY2Jhd1l1L3diWXJMVm1mZStD?=
 =?utf-8?B?aEF2QVRhTnk1UHNBZk9GQURORVVwVGEzQkV3aVVsL1ZuN3NpQk1JMEg2U3hx?=
 =?utf-8?B?M1QrSjA2S3ZVcXJJM2J3RnFUekViRFZHeXIrZVJOQUo2TythMG0vODRjVTEr?=
 =?utf-8?B?eXdOeDNhRkRMdnpKWlhvK21hRUQrQ3Zua1RFcWY2VkVoMlFrYjljRWZCWHU1?=
 =?utf-8?B?OTZkbmxBM1RRZDUvQkxqaERxK3c2Z2hsa1Z1ZWovMjZ6bHZ5SzE4dUE5dGRB?=
 =?utf-8?B?SVU1Q09pZFpySWZZT3FGVDNSdlBYSDByeFBtMG5ZZ1Ayckl5Nzh4aERKeFRs?=
 =?utf-8?B?MVgreitLaEhFMkdCeGpPamw1cDdJc2xMejEraDhENjBkR0dCMlV2Nm5FYUth?=
 =?utf-8?B?OEZpbW1hVm1rbG5mNEpWdVFVeGRHSFp4b0NHODUzK1Q1YVFjeU5MWlczMW0r?=
 =?utf-8?B?SGJpTWxzVWpsK1ZyNG9QM3crQ1hHZ0pqdTV3V3FzUitpUEtBa0MzblJmb2FL?=
 =?utf-8?B?N3lHb3JDN3IrRDZrajJrVXRoOHRMUmtNTEgxVy9wVTErRzd0QVVpSmQwU2Jv?=
 =?utf-8?B?YlhEd3lObTN6QkNNUEhNTnhUUlM4cFFqS3pxdFQzMTNTZ2dZMWhFQzZ1Y3VE?=
 =?utf-8?B?WmtaQjk5UDNtUXJPNHVqT2wxZWJFbnVtekttUXJ6YTlUU0tjNzMwek9DOWxX?=
 =?utf-8?B?WFlmM0d5a1NVNHVpYUIvemJVUTl2SjRFOTIrK0J0KytFZVBBWjBmTnRHdFVw?=
 =?utf-8?B?OCtpV0drRkJWcGhrUThtckdXRVlSbGEzRjZGNjYzU3ZxL2ozek41R3RDY09E?=
 =?utf-8?B?RGZ6MDFLT1l6K0dDdGkzTFV1UTUzWndTUDJ0SWRDU1ZCLzR5b2Nha2Z6YXRN?=
 =?utf-8?B?bmdDaExjeGNtc0cxaWI1N0hKMittMTZINm10MGhTYy80RFMxQWp2MGxBVTBY?=
 =?utf-8?B?WGFBZWxldTNJeEFwMTdxUFcwOHlOSHpQS1lXKzJ6aExUcktlK1hrdWM2VlBx?=
 =?utf-8?B?dGZkdVhDc3U5bXUwckliSnFJN3JLM1hvM2ZZY3cxZkR1ZGpOdU1OZS9XUmtC?=
 =?utf-8?B?cFBwMUc1bi9mTXAydEMwbUN3RkVXWWl5aDY1M2hyWkUreWxMMEplVmRGSitl?=
 =?utf-8?B?R3BsYVNBYjE1TnhqWHE4NkNTdk8zcmhLL3BiRDliRk45NG1UZ0RtRHQzWDFC?=
 =?utf-8?B?MEpudTZ4MDJ5dHpGSTN2WFliRWdkZmNiZkhvckRBaXYvM3hEUnlyWEJtaFNW?=
 =?utf-8?B?cDkyRzE2cVFtVzlSUUJOZjZoUGJVcUxnUFl3eFpMN2graWQrODA0eUlxQUNw?=
 =?utf-8?B?MXNaTisvamNlb3dRQVFpWVVnRkN6MXVxUWtDb2V1TW13a1B4OUZkQVNhRnoy?=
 =?utf-8?B?bE1kQmpXU2x1VVF0NzdWR0xiTW5PRHNDQmVkaEIzamd4STJ3N01mOHpzTFoz?=
 =?utf-8?B?N0liM3pQeXllNXBYVHFWK09PRnFLU1ROM3pqNUtGaUxobGJ3L0MvczRGblJx?=
 =?utf-8?B?Rmh0L0lPMEhiQ3lMcTZ2bGpCaXpiQjFKVFF0b0dJRkZvdE96dEExRTh6emVl?=
 =?utf-8?B?ZXpQTVlvMWNETEd6TDFOWVM1eU01dU9ycnJTdVV5OTJNcnNKZjMrdW1laVhn?=
 =?utf-8?B?OTk1MlpPTDFNRmNjSmEyYzBDaGVTdUdrZFVQcG5tMVFHUFVlVldqMDREMzh0?=
 =?utf-8?B?NFpaQUZsU1h6R0VRR04yZ1lWZWJMNWdxenB5QVhLVFBYcUVwSzBxT0lob3RD?=
 =?utf-8?B?RXcycWRZQTdCckNPSXlSRytLR3g3RmZ2VGVKcEZTZG1WUk9sSm4xUk1ZcDNQ?=
 =?utf-8?Q?WGR0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedae07b-c745-4d88-f87c-08dc56ea285b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 10:04:47.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Z6lqFTkYm8507cxVblWzNcVU0xuBsMmSDybGW+48vgJJRXPweI4xBQxs3iSvw4eC2E/1jHkemhLJcly8rxU0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6870

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBhcm0s
c2NtaTogc2V0DQo+IGFkZGl0aW9uYWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gDQo+IE9uIDA3LzA0
LzIwMjQgMDI6MzcsIFBlbmcgRmFuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDEvNl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBhcm0sc2NtaTogc2V0DQo+ID4+IGFkZGl0aW9u
YWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gPj4NCj4gPj4gT24gMDUvMDQvMjAyNCAxNDozOSwgUGVu
ZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT4NCj4gPj4+DQo+ID4+PiBXaGVuIGFkZGluZyB2ZW5kb3IgZXh0ZW5zaW9uIHByb3RvY29scywg
dGhlcmUgaXMgZHQtc2NoZW1hIHdhcm5pbmc6DQo+ID4+PiAiDQo+ID4+PiBpbXgsc2NtaS5leGFt
cGxlLmR0Yjogc2NtaTogJ3Byb3RvY29sQDgxJywgJ3Byb3RvY29sQDg0JyBkbyBub3QNCj4gPj4+
IG1hdGNoIGFueSBvZiB0aGUgcmVnZXhlczogJ3BpbmN0cmwtWzAtOV0rJw0KPiA+Pj4gIg0KPiA+
Pj4NCj4gPj4+IFNldCBhZGRpdGlvbmFsUHJvcGVydGllcyB0byB0cnVlIHRvIGFkZHJlc3MgdGhl
IGlzc3VlLg0KPiA+Pg0KPiA+PiBJIGRvIG5vdCBzZWUgYW55dGhpbmcgYWRkcmVzc2VkIGhlcmUs
IGV4Y2VwdCBtYWtpbmcgdGhlIGJpbmRpbmcNCj4gPj4gYWNjZXB0aW5nIGFueXRoaW5nIGFueXdo
ZXJlLi4uDQo+ID4NCj4gPiBJIG5vdCB3YW5uYSBhZGQgdmVuZG9yIHByb3RvY29scyBpbiBhcm0s
c2NtaS55YW1sLCBzbyB3aWxsIGludHJvZHVjZSBhDQo+ID4gbmV3IHlhbWwgaW14LnNjbWkueWFt
bCB3aGljaCBhZGQgaS5NWCBTQ01JIHByb3RvY29sIGV4dGVuc2lvbi4NCj4gPg0KPiA+IFdpdGgg
YWRkaXRpb25hbFByb3BlcnRpZXMgc2V0IHRvIGZhbHNlLCBJIG5vdCBrbm93IGhvdywgcGxlYXNl
IHN1Z2dlc3QuDQo+IA0KPiBGaXJzdCBvZiBhbGwsIHlvdSBjYW5ub3QgYWZmZWN0IG5lZ2F0aXZl
bHkgZXhpc3RpbmcgZGV2aWNlcyAodGhlaXINCj4gYmluZGluZ3MpIGFuZCB5b3VyIHBhdGNoIGRv
ZXMgZXhhY3RseSB0aGF0LiBUaGlzIHNob3VsZCBtYWtlIHlvdSB0aGluZyB3aGF0DQo+IGlzIHRo
ZSBjb3JyZWN0IGFwcHJvYWNoLi4uDQo+IA0KPiBSb2IgZ2F2ZSB5b3UgdGhlIGNvbW1lbnQgYWJv
dXQgbWlzc2luZyBjb21wYXRpYmxlIC0geW91IHN0aWxsIGRpZCBub3QNCj4gYWRkcmVzcyB0aGF0
Lg0KDQpJIGFkZGVkIHRoZSBjb21wYXRpYmxlIGluIHBhdGNoIDIvNiBpbiB0aGUgZXhhbXBsZXMg
ImNvbXBhdGlibGUgPSAiYXJtLHNjbWkiOyINCj4gDQo+IFlvdSBuZWVkIGNvbW1vbiBzY2hlbWEg
cmVmZXJlbmNlZCBpbiBhcm0sc2NtaSBhbmQgeW91ciBkZXZpY2Ugc3BlY2lmaWMNCj4gc2NoZW1h
LCBhbHNvIHVzaW5nIGl0Lg0KDQpvaywgbGV0IG1lIHRyeSB0byBmaWd1cmUgaXQgb3V0Lg0KDQpU
aGFua3MsDQpQZW5nLg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

