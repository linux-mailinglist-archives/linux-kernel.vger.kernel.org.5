Return-Path: <linux-kernel+bounces-87797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20EF86D926
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9501B1C223C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303436AFF;
	Fri,  1 Mar 2024 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T8S/N7OX"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287F2F5B;
	Fri,  1 Mar 2024 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257781; cv=fail; b=WTvtucwzP3XDznWDJnWvTs3tZJWKUcuJQ8lmPrqCfZ9Fe2NfhsNVwK05HdYuti6IsXgMwiXUlUlFHPegSU/Kg407+bjSydC7/JcHPH/wPR77QBCnLCgAy3nQmmz7jNi9Ylpbr+M/G/M/SKv1bHfujZuPbEUiPAXHrYCAMVHdCo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257781; c=relaxed/simple;
	bh=4mO+ES9KKsjWe2b5DQD1IM378IpxZIYnKSecmtEzdZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eQB9tRq27YLYS7iJONFp8a6Mr17qhGD5XGmCJ0lWFDJBDVwRLfFCrnLTBIbhVPuYRTGg/bdt0v+ZX3kVKaKc/rE5Hn0yRZ8UAo1V/Uw2jpH1rngjU4T5rwVNmQcxyGK0ICqV7K+sq248YaKfgzomfS75psP7j031xVC3XYAAg6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=T8S/N7OX; arc=fail smtp.client-ip=40.107.15.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djbjpQutxHMHuXm56J1tVCoGpgv74XvMQ14qKcpamT78j4sMLqGCPwUdsAn+oXGp/tsxWz1YONpewu/6HMG05ackVgZWZQ3arI4teQpiN7dj+BODb4Tk5E2af2STcoaD7ntV8vlBRzdIU+tpr8Xxr+FC0EeQ4cUIEPwgB3/MMC2t2QSgljAAqJ72EEoG3wNelmusurSzVPUb1sLUeFjJXPNC/0yuFhLtzQLpSF2U4GAGuygvdnpe8ckjWQbXAk9q7f4s5eELGdVN91IeAiDc19xoiSdqoHjtHqtUQNnjDdySiy0nO6pJaDbz/FM1q8W8Eu8u95hnaLhEqpAhd8mecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mO+ES9KKsjWe2b5DQD1IM378IpxZIYnKSecmtEzdZI=;
 b=X5jPij+X3FbRi4S+7T2N9BRVot3sEYVo6MBA/s9XIu+9j6hXdgl11E0pSR4psNUAriaq4VLavBsLp7DXNd8anpmPXOin91YejLm/ej/eq2l32pK8q7FY6QsHhY7LLySFxDmteu15ZTfN8qO0am6sxU7n4WxVxKbwjQuy95FQOMsukndntz+5UrjDX9PBn4sakwBg+Hsv0hCFQ6gpaQJAZB9iM+vzQ9a+5Amx4BBxQboPlzXdj45QxxQeZJJixJEAVlP9nEKXxaj+LMvYSEfPxNxklgUA52LoYxjPcxIQXWnsmjo4566adpxrOI42QA82HDTgMugpIVc+Rnh2Y0I3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mO+ES9KKsjWe2b5DQD1IM378IpxZIYnKSecmtEzdZI=;
 b=T8S/N7OXo9RgnbA6TJ7DFqM40klsLyntbfHmsbFG1SHRqn9uCZW1KsiSMus73dNSwRm6VCgwJt5Y6UeC1ltNQ7Gir3AiYWlQC7fcy1jVLEpmtM1OG3lvv7Z5/aEHMWhTB6Oj7/Qvixxz1D34PP2ghHNkvj1CvEcd7WEpCz0hOUY=
Received: from DB6PR04MB3141.eurprd04.prod.outlook.com (2603:10a6:6:c::21) by
 AS8PR04MB9208.eurprd04.prod.outlook.com (2603:10a6:20b:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 01:49:36 +0000
Received: from DB6PR04MB3141.eurprd04.prod.outlook.com
 ([fe80::4c4f:6b0f:3a10:f5d5]) by DB6PR04MB3141.eurprd04.prod.outlook.com
 ([fe80::4c4f:6b0f:3a10:f5d5%4]) with mapi id 15.20.7316.023; Fri, 1 Mar 2024
 01:49:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: John Ernberg <john.ernberg@actia.se>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	dl-linux-imx <linux-imx@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH net v2 2/2] net: fec: Suspend and resume the PHY
Thread-Topic: [PATCH net v2 2/2] net: fec: Suspend and resume the PHY
Thread-Index: AQHaav1/Ffv5x8jH7kmxx77YLYL/oLEiG6+g
Date: Fri, 1 Mar 2024 01:49:35 +0000
Message-ID:
 <DB6PR04MB314117D7D5473B31FCA47495885E2@DB6PR04MB3141.eurprd04.prod.outlook.com>
References: <20240229105256.2903095-1-john.ernberg@actia.se>
 <20240229105256.2903095-3-john.ernberg@actia.se>
In-Reply-To: <20240229105256.2903095-3-john.ernberg@actia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR04MB3141:EE_|AS8PR04MB9208:EE_
x-ms-office365-filtering-correlation-id: 39cf8ca1-f74c-416c-5726-08dc3991d955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hGO7ESiY0yDScUwWRbiEQ2NUjTv+XDto+rtpHfEOJFEZwOru0ktlFxUhtoXVAs+sAZfGQr+kHhGkGTXFZbzMi96x/+jQFmySwlh46JpNeYKt1rTOnnqR3WnyYJ2DtjPT5PpLAlDe+8JEnHG2heK4OKMFud7olpNdBmm30fFQkKHdcAwRuzEmToBHV/RV1gaoGSzBu1JXkJPEH2yMXwAvckHMwjYdOmrYORL9v+Eb+oQ215r+qIm+sBJCX3C3IPP29FbzcgJGVwO1kJjVPflWg/eE7YnGbjbjL3qp2xC3HnHUebT4wbJKyTTktuwm7ckQqdnlxvd3Mvs7GoU7F6l1XL4pIqQ1l+pC/FJFc6ZvzHYuYSdNjpWOukpxtHRUcmb5EQ3cDPg0LPvSO1NIAPTblUd4khFCgMvFaXovWl1ckl60hWY/ZOtBpiIx0hetSB7FfepbMi0qgFj6imGd9I6MoUFR10vFHkbQHZD8XAq5fQCGZp9KAhPFDcQNdbVOWabgCcAdldGKwNrddiwQnHq404Yo5lZnsUyu/mxkqBEfi7sjD1EPs5ixtuQZ6PaUPvknf66cdcq1JE+bADxIDDdt6ICJrnWU7Ik+VYEEqGF7ALbNRUJCnQ5c/vO86t1ljsX0fCFMzZlN376Rq3COwdMIAg4+N0WaX5amzKGE7Nbp4O0pHC8wB3iYApfgNBDiq/DLLD2ZY+dx9o9H3iprawNJBuLqpaeo7C+dP5Pxo5DVuwA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3141.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WFc2VDZKNk1hcW1hNFdOWU80WktkUjErbW1SdWpuRnh5QlNsZmI5aEhOZlkr?=
 =?gb2312?B?KzhUSXlKZm1VLzBBK1NHS3o3VTNITW1UZ29XUXBjRVRMTDUvbEhCTkNlZkdk?=
 =?gb2312?B?WWlNaEtGaXhwZTkwYVEzRGx6ZEVSRzhVUDE4YzFYSjRlWi90WGI5VzVCZkNn?=
 =?gb2312?B?RHptenNBWHBtOGpiSkZLTmtvcXVrbmVad0NkOFlBM014Z0d3TFRZRzRqa0NQ?=
 =?gb2312?B?TEw5eUJPTnhmMXlCalNpd2t2d2JEN3ZabHVEOXVGK3VtaEFvTlF3eDhWOVNG?=
 =?gb2312?B?cjlaelhSQ3lpTlAxR1BjeXlTOXlqSE1CZUpMWjBpeDdVV3BRMzNQYSttVVUy?=
 =?gb2312?B?Y1FycHBpUVcyVGx0NkVyMFVMYndJVTkrOXVycjgxQ043Nml0c0VtNDZ4ekVs?=
 =?gb2312?B?c1lWNndiZzJYcVR4UzZxYmkvdTUvWHc0L1BRbUEwMmc5Mm45SGxhZGtjcExl?=
 =?gb2312?B?aHlrczNmNGtEVnhpV1ZmUkJyWEVkRlY4QU5pcHlOcDdqOEJYRUlLbHE4RDhQ?=
 =?gb2312?B?cXg3a2h1QmYzdHlxenpuc0lmOXRQMVQ5WFBoSEhGajhUS2Y0NktBZnBNTnRC?=
 =?gb2312?B?RWNjTWV4djM0N1FEL2JsLzNBb3NwTTlabFpBUmdodnFJRjlHUjN5aW9ZZFRm?=
 =?gb2312?B?Q0w1MzlySGUyUm05Ykc5TWl0RHRhTDlIUEp6NVhLbTRVYXpJTnZrQkhVM3Rx?=
 =?gb2312?B?N01YbVJHQ1NTWWhnQ1hOYWFkUnFsSmRUbWgvZS96MDNibGErZ3AzMzNZdnhV?=
 =?gb2312?B?SU1hSkNVdzZodHZQejVabGdHL01INU14TXJSZFJQZkxnNlU2REx1bzVSZWo5?=
 =?gb2312?B?cm5UdXBSNHp6d3dwNDN4Zm51M2gzMjBKU29tdi9KTmNqbVNsN3pJS0xCdng4?=
 =?gb2312?B?T0R6dDR6M3k1NmYycDhpV0ZtYjd1UXg5VHRIWTdCTEVva1RvQWx1RVFrTGFa?=
 =?gb2312?B?cDNYSzFxSzgzZUR3THV1OXRaUVdPZDRFajI3Yy9jMWJUa1kwa1ZUajZjVVhu?=
 =?gb2312?B?MHdlU2o0bXEyZTFjWGptWjhVUmVOUXBVaFBjU2VudUIrNE5jZ0FnY1l0ZUJW?=
 =?gb2312?B?ZXhLTlgrcUFoUHNoY0JlWklBYmhNdjhVNFNwWlNwR3BMNTBrU0t2VzRKWjNm?=
 =?gb2312?B?TXNkU0EwNk9OUnlEai9rQnZ1UWd6dEJwcXpkdm9nZXEra3Q3a2VuYWRxZVV0?=
 =?gb2312?B?YVJncHZnL2JrQ0ZIUktZajlROExhVm5qekhWalJFSlRTMndHUXB5ZnNyTC9E?=
 =?gb2312?B?TjJmOU9SMUIxb1UycE9LSXJaSWQ0eVpHS1BLNW5scU1PU2l6ZzhSb0JMZFZ0?=
 =?gb2312?B?SlduRi8yNW5TUUJaa3RUUHB2eFl4a2luaVhDUmEyR2hLQ2h1NGdXZ1ptWTFl?=
 =?gb2312?B?bk1YaFVZdHdmMkVkcVVrclVxRFkvVlBCR1grSEhjcmZFaFVEZTk1bUtWV1Nx?=
 =?gb2312?B?Z25KMy93TU5wZGZzcTJMRENienhxVzFsRUlxUkJqTmRSL0krS0cvV1JyVEpJ?=
 =?gb2312?B?SVJyVkpKcEhQSGFLOGtrTnZ0N0xiOWNHbDJtdnlZbUVpZldkT0NrNDlvZWR1?=
 =?gb2312?B?SWJlZ25YazRvaVozdDd3RkJhNHRkRWRabTJZb01uOG9Lb1B6RUhZWnVycEFM?=
 =?gb2312?B?dSszRmd3dnV6VVVTbGdWbENXdGlzY0U4VGE5WDY4UG5ROU12WHBCcFQ3WGhX?=
 =?gb2312?B?VTZQYXZYdUlvbnRYNGtsRU9kemt3ZkVBb05EVlJ4aFdoYjdvZFVKRjFTOVdm?=
 =?gb2312?B?UXFlZkJEQmFnY0N5NHo5OFYwVXFKY3JUM1lmb1kxd2c1UGo2TUxxbEdQWWRY?=
 =?gb2312?B?aDFoT3R6Y2IraXRhczBObjdDdGk3RS9UdjB0bkU4NnJLdTJlNnRlaU1QSVJX?=
 =?gb2312?B?Z0FrRHd6S3Vwd0g2UnBKS0VMY0d4aEhPaHpDNnJWK1h6OTVNVy8zUHF4bVJU?=
 =?gb2312?B?eWpFeVNLUlNnSXpROFhVR1g0VUFMUTR2M2phd3d4RCtWUG1RS0piYmlJRVRR?=
 =?gb2312?B?TVg4L21yTms4T2lrUjh1VnZsTXM4MTJZQzd6b3FMQXNKS3RiV2MrRjl6ZXRk?=
 =?gb2312?B?RG9RUDFxbG5GL1NPclBadyt0NVdNTXE0eXpXekRaVlNQUC9GTmNuaUVmaUU1?=
 =?gb2312?Q?DC98=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3141.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cf8ca1-f74c-416c-5726-08dc3991d955
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 01:49:35.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSISWma6+tWY5wZtU92bn7sOkbqEAldW4HhXUq2l0RT5qT94pv9U5Tw9ZdQfzNCULqSsjF1bsuF/5jR77fSVeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9208

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIEVybmJlcmcgPGpvaG4u
ZXJuYmVyZ0BhY3RpYS5zZT4NCj4gU2VudDogMjAyNMTqMtTCMjnI1SAxODo1Mw0KPiBUbzogV2Vp
IEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2Fu
Z0BueHAuY29tPjsgQ2xhcmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IERhdmlkIFMuDQo+IE1pbGxlciA8ZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47DQo+IEpha3Vi
IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5j
b20+Ow0KPiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPjsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSm9obiBFcm5i
ZXJnIDxqb2huLmVybmJlcmdAYWN0aWEuc2U+DQo+IFN1YmplY3Q6IFtQQVRDSCBuZXQgdjIgMi8y
XSBuZXQ6IGZlYzogU3VzcGVuZCBhbmQgcmVzdW1lIHRoZSBQSFkNCj4gDQo+IFBIWXMgdGhhdCBh
cmUgYWx3YXlzLW9uIHdpbGwgbm90IGVudGVyIHRoZWlyIGxvdyBwb3dlciBtb2RlcyBvdGhlcndp
c2UgYXMNCj4gdGhleSBoYXZlIG5vIHJlZ3VsYXRvciB0byBiZSBwb3dlcmVkIG9mZiB3aXRoLg0K
PiANCj4gU2luY2UgdGhlIFBIWSBpcyBwaWNrZWQgdXAgdmlhIHtvZl8sfXBoeV9jb25uZWN0KCkg
YW5kIGRyb3BwZWQgd2l0aA0KPiBwaHlfZGlzY29ubmVjdCgpIHdoZW4gdGhlIGxpbmsgaXMgYnJv
dWdodCB1cCBhbmQgZG93biByZXNwZWN0aXZlbHkgdGhlIG9ubHkNCj4gY2FzZXMgd2VyZSBwbSBp
cyBuZWVkZWQgaXMgd2hlbiB0aGUgbmV0aWYgaXMgcnVubmluZyBvciBvciB3aGVuIHRoZSBsaW5r
DQpuaXQ6IHdoZXJlDQoNCj4gaGFzIG5ldmVyIGJlZW4gdXAuDQo+IA0KPiBUbyBkZWFsIHdpdGgg
dGhlIGxhdHRlciBjYXNlIHRoZSBQSFkgaXMgc3VzcGVuZGVkIG9uIGRpc2NvdmVyeSBpbiBwcm9i
ZSwNCj4gc2luY2UgaXQgd29uJ3QgYmUgbmVlZGVkIHVudGlsIGxpbmsgdXAuDQo+IA0KPiBGaXhl
czogNTU3ZDVkYzgzZjY4ICgibmV0OiBmZWM6IHVzZSBtYWMtbWFuYWdlZCBQSFkgUE0iKQ0KSSdt
IG5vdCBzdXJlIHdoZXRoZXIgdGhpcyBjb21taXQgc2hvdWxkIGJlIGJsYW1lZC4gQWZ0ZXIgY2hl
Y2tpbmcgbXkgbG9jYWwNCmNvZGUgKG5vdCB0aGUgcmVjZW50IHVwc3RyZWFtIGNvZGUpLCBmZWNf
c3VzcGVuZCgpIHdpbGwgbWFrZSB0aGUgUEhZIGVudGVyIA0Kc3VzcGVuZCBtb2RlIHdoZW4gY2Fs
bGluZyBwaHlfc3RvcCgpLCB0aGUgc3BlY2lmaWMgbG9naWMgaXMgZmVjX3N1c3BlbmQoKSAtLT4N
CnBoeV9zdG9wKCkgLS0+IHBoeV9zdGF0ZV9tYWNoaW5lKCkgLS0+IHBoeV9zdXNwZW5kICgpLiBC
dXQgdGhlIGxhdGVzdCB1cHN0cmVhbQ0KY29kZSBtYXkgaGF2ZSBjaGFuZ2VkIHRoaXMgbG9naWMu
IEknbSBzb3JyeSB0aGF0IEkgZG9uJ3QgaGF2ZSB0aW1lIHRvIHNpdCBkb3duDQphbmQgbG9vayBh
dCB0aGUgbGF0ZXN0IGNvZGUuDQoNCj4gU2lnbmVkLW9mZi1ieTogSm9obiBFcm5iZXJnIDxqb2hu
LmVybmJlcmdAYWN0aWEuc2U+DQo+IC0tLQ0KPiANCj4gdjI6IE5ldyBwYXRjaA0KPiAtLS0NCj4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgNiArKysrKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGluZGV4IDhkZWNi
MWIwNzJjNS4uYzUzOTRhNGQ4NDkxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZmVjX21haW4uYw0KPiBAQCAtMjUzOSw4ICsyNTM5LDEwIEBAIHN0YXRpYyBpbnQgZmVj
X2VuZXRfbWlpX2luaXQoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkvKiBm
aW5kIGFsbCB0aGUgUEhZIGRldmljZXMgb24gdGhlIGJ1cyBhbmQgc2V0IG1hY19tYW5hZ2VkX3Bt
IHRvIHRydWUNCj4gKi8NCj4gIAlmb3IgKGFkZHIgPSAwOyBhZGRyIDwgUEhZX01BWF9BRERSOyBh
ZGRyKyspIHsNCj4gIAkJcGh5ZGV2ID0gbWRpb2J1c19nZXRfcGh5KGZlcC0+bWlpX2J1cywgYWRk
cik7DQo+IC0JCWlmIChwaHlkZXYpDQo+ICsJCWlmIChwaHlkZXYpIHsNCj4gIAkJCXBoeWRldi0+
bWFjX21hbmFnZWRfcG0gPSB0cnVlOw0KPiArCQkJcGh5X3N1c3BlbmQocGh5ZGV2KTsNCj4gKwkJ
fQ0KPiAgCX0NCj4gDQo+ICAJbWlpX2NudCsrOw0KPiBAQCAtNDYzMSw2ICs0NjMzLDcgQEAgc3Rh
dGljIGludCBfX21heWJlX3VudXNlZCBmZWNfc3VzcGVuZChzdHJ1Y3QNCj4gZGV2aWNlICpkZXYp
DQo+ICAJCWlmIChmZXAtPndvbF9mbGFnICYgRkVDX1dPTF9GTEFHX0VOQUJMRSkNCj4gIAkJCWZl
cC0+d29sX2ZsYWcgfD0gRkVDX1dPTF9GTEFHX1NMRUVQX09OOw0KPiAgCQlwaHlfc3RvcChuZGV2
LT5waHlkZXYpOw0KPiArCQlwaHlfc3VzcGVuZChuZGV2LT5waHlkZXYpOw0KQXMgSSBhZm9yZW1l
bnRpb25lZCwgaWYgcGh5X3N0b3AoKSBkb2VzIG5vdCBzdXNwZW5kIHRoZSBQSFkgaW4gdGhlIGxh
dGVzdA0KY29kZSwgaXMgaXQgbW9yZSBnZW5lcmFsIHRvIHJlc3RvcmUgdGhlIHN1c3BlbmQgb3Bl
cmF0aW9uIGluIHBoeV9zdG9wKCk/DQoNCj4gIAkJbmFwaV9kaXNhYmxlKCZmZXAtPm5hcGkpOw0K
PiAgCQluZXRpZl90eF9sb2NrX2JoKG5kZXYpOw0KPiAgCQluZXRpZl9kZXZpY2VfZGV0YWNoKG5k
ZXYpOw0KPiBAQCAtNDcxNiw2ICs0NzE5LDcgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBm
ZWNfcmVzdW1lKHN0cnVjdA0KPiBkZXZpY2UgKmRldikNCj4gIAkJbmV0aWZfdHhfdW5sb2NrX2Jo
KG5kZXYpOw0KPiAgCQluYXBpX2VuYWJsZSgmZmVwLT5uYXBpKTsNCj4gIAkJcGh5X2luaXRfaHco
bmRldi0+cGh5ZGV2KTsNCj4gKwkJcGh5X3Jlc3VtZShuZGV2LT5waHlkZXYpOw0KPiAgCQlwaHlf
c3RhcnQobmRldi0+cGh5ZGV2KTsNCj4gIAl9DQo+ICAJcnRubF91bmxvY2soKTsNCj4gLS0NCj4g
Mi40My4wDQo=

