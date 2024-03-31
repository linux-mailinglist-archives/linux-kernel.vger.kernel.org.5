Return-Path: <linux-kernel+bounces-126058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB23889318A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 14:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E9A282694
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE514431D;
	Sun, 31 Mar 2024 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nLb9Rfr7"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2129.outbound.protection.outlook.com [40.107.104.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9D2A8DD;
	Sun, 31 Mar 2024 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711886408; cv=fail; b=k0Esp7/CTdUbadjWwITIh3SDdJuOue53hrVLoiX27l24lCAJkH8SI3FBaOiC72PPyWFiQ0Kj8duHqQwd0N6QIiFEnvKwNs1rQmQOwAKaeZ+8JkQfYYTkaV0SgYRjNQ5+Um0osBWMBfI0kFJhM6nuICwgh0gkRU0Yld9MLeld21M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711886408; c=relaxed/simple;
	bh=QfnqUthQm8hjhlm05OfrfwQt6v1I5scGH7t9i4t7eVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=onHUfhv2aXCn+/iqV298rWUC79v6Ez0fEMGGZ4GCBay7/05Yi8qEG8zG99bl9mORSacCsIBDd5t4qiCllUmQz8NFnuGzR0azVV7Tv8gFacmO2hkW09g5bTuTHbQ7R2uyOvUV72y8nLaa67R1IbxPShIy5ngWwJBSaTUWFjr1STY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nLb9Rfr7; arc=fail smtp.client-ip=40.107.104.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHoIQb6kFDJa3rIY395jmI05H2o1yCRd4858g4x2RMTTJcm2XdJPIqrjFZs63mTIfnpyvH3hkEnpT9/ZJqWaZphzRvdQO+0pWCLEEk1KpVBtZR8YN57YGyPekz3aenAVrU0qHfvgn2qb29KVl/WirOQseRlTsgF7Suuw2wR6gRE9O6cVCiEx0KBrjcY2wiBz/TWwdMFyKdSW2OYnFkqTHnxmsLQ8vF+3zV+h0JAANmyeMLWSROtBWpOwuWEeHWTGVsIezjqrMGwcnJQH6wKcGBPzVfADBhv/6BA32SmzMIsfmg9QsCyBsIwspVDTWk602x08vCBmB17T8KdbN/10yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfnqUthQm8hjhlm05OfrfwQt6v1I5scGH7t9i4t7eVI=;
 b=P4+vXIreYctOWkxiTE6Geql5pCMnGz2Rc75V2D3V+bdcVx6ctWNKdwRI4XCrtGTCed+bzVPhS62SDZfWf6+6JF0aDZbpi7zren8dQnNAouB9T8CPKMVh0I+S0DG5OmZYuXWxHDI6C3qonooHJlvbcMSJMXRIecMMvBkrLYpjfMmqZicy2kEzL83kpYzvZWfnm/yPbhkpzaCeR/0gv9/1wmWlEa7SPEm/iaJ/kgcdbEFZOvdk0MTezKjGdsvp0n0UqZK9Rmft8sRV07Rk3L2/NLYG9Z0ddDbDAOCcZyq+2JIkRxpe3dv++tr6Zh+e9bAL/rKtN6K2eAdIOAeZ9xUE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfnqUthQm8hjhlm05OfrfwQt6v1I5scGH7t9i4t7eVI=;
 b=nLb9Rfr73Oj8uyvuJlRrsUbHuytta8/cR6K/JflTdrki5d/5ZNFODP9qvr33uTmbwamx7I5hux2vs6ZoPBQEU7nbOcUp9gPfJwTGTmJcZRlWvbQva+pvBsR4qHfivcPzJOUvBnKQccdOdMSEshs/FNTt1Rlr9GyHFmCtMKJYVkw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6875.eurprd04.prod.outlook.com (2603:10a6:10:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 31 Mar
 2024 12:00:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 31 Mar 2024
 12:00:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/4] Add support i.MX95 BLK CTL module clock features
Thread-Topic: [PATCH v5 0/4] Add support i.MX95 BLK CTL module clock features
Thread-Index: AQHafb8D/Pe+n4NV2E+w7m5684C/SbFI1+eAgAjyXbA=
Date: Sun, 31 Mar 2024 12:00:03 +0000
Message-ID:
 <DU0PR04MB9417426E1F8EA9560213E58488382@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
 <ce1b814a-6b1b-4773-ad29-b572d00f56c9@linaro.org>
In-Reply-To: <ce1b814a-6b1b-4773-ad29-b572d00f56c9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB6875:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vBmvIh5w2+5UF3hYLLIEUBTizZytc0mrXxRBzLl+w9dwaY8goN0x62bqaP3vET+/eDLx3yNZXVH8bl5DE1u8A80p9wzLUmuaIH4JlkfonfB8lFwgxvyH1669eaXQRfDrWkxMa+7VDBSsGXFpalyHWLqMRlAKjwEIzLmdYi+6bxqzdAFGMlVuMSaHiBwQqtK8KApJ1dnlOUNsQovsVGE8ZfW8mEcnJ5H8tSiCMpxf0yilnUsPjL1/JlbmXFUfBVntpvAaE/kCVD4TOWlnzjYUWjF/4J9kEiJPSmYMR3sdeScBzU6e2W6dQcxupOSoEGsBg/xXB0jSS1lN2k/ssximJaX6ClZV/M4XzhJeXBXJmAEUZU7kdZw32AFZOAv++eW+sr2Ku5SEn0RoK8KAuIZ7otKPLK1j0Gayn7AqRSj525iH7bN2OuP32O6Eq4BddbmbjZwXmrOfUyJz8bIHXjtTsluJiReZWiIqrMb5GUEZa0JuRhPBKs1mTugQo2mlmp0Ke6k5W24YTjPjmKollhBgO+PPdPiZBzoBCqQ0bc3NS9XEhjd5TXtCq+TixwpWTFUlUkiXxRfO88dGbsTIk78/CEdBkch2GwhRuG9sUS4DNBM14S8HZScyLmQWUQ2GncCPKqPFMNOogoLYyl0TOC2DPQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0FReEw4WDdpc2lIandKc2VyY29HVVZmNmM1ZDFjR2QxeFZZODVhN3ZmZTZX?=
 =?utf-8?B?VVZWY0U4MDZ4L3N5eU5iek9ROTRmVmY0WUd5TTA2TnBKMzdmSnYwS1Nrdytq?=
 =?utf-8?B?MmsreUY2TVplaWQ4TEFYUVhIMTdwK0NVVUpJNDRDN0RPVFk1Yk9iajVDamZq?=
 =?utf-8?B?cllUK2tWUU5wSnkyZStIRDFJKzUxVmhqK1ZnOUMzWSs0aTdKYTk3d2hoT0pp?=
 =?utf-8?B?OFdITnQxb0F1V1RoQ2QyWmZNOHU5RHVpNTdGakxmVmlxb0d0cW1KN1pBd0pq?=
 =?utf-8?B?bWNidzZwVVVLbmdRZHZpNHJaM3Btd1lpNjFQbmRPcnZ5RmZFRzM0azdoK1JT?=
 =?utf-8?B?VTZGcmdmMXRDREhIR3pQZ2VmN3ZrSXkyQXJwUklqTjJ2bnNBOTdISjhyNUtw?=
 =?utf-8?B?aVBKelhtMGExUzVjSkJ1elVKVXljemdnUkFURlRyeGRvcWkrbTZyTHJoTTh5?=
 =?utf-8?B?bEkxNDEzV2UxcXN6ZFJyNWhrYWVDRXA5T0tDa0xDYmVsMVhhWS8xTU8ydC9o?=
 =?utf-8?B?UjJiTVNjTWZIRFhLYTYwbDY1cVJpY09jWDlYNTRNaGxVNjdydUxEVkdwSDJE?=
 =?utf-8?B?d2dBNlJrZDJGT2F1MUltMEduK3NIZ0RyTEovUmhLUU9lTHlxMzB1NUpKbTky?=
 =?utf-8?B?K25malR6Kzl2VWNaVWN6ZTBOai9GNVQxc2lRRDhjRXNwREFZVWQ4cFJtWXhq?=
 =?utf-8?B?cWFwRU4zTUE4WXJRdWNzM2pzdkQwYzFoOUVHMTIwWE5aa0ZpZDZaTEZ0aytu?=
 =?utf-8?B?SFBPVXFlWDEzcWxrY2dqVEFab0RtNFk4d2doSEVkRUNTZTBYOFFlN0hsZ2xl?=
 =?utf-8?B?NVNwNmdMbVNTQ2hZdG1HZDA1SW8rUTJYTnNzZExjaSs4NmpDTFNwMzVrOEJw?=
 =?utf-8?B?UGEzMUd2RFlGTVhXbnFuNitLZDVXZXlqL0JIRUJtcTF5d0NLTjZwQjRjbXVP?=
 =?utf-8?B?azRwTlRYbkVycjRaVGhLQXJ0cFRmV2dDbkpiYXBSMXltNGZHWHQzVTZlM0xM?=
 =?utf-8?B?bWNvYTFTc1NsOGZwNDhFUnF6YTA0dW0vZklhVFF2T2VuN0F5Qm5RN3VZMEtO?=
 =?utf-8?B?UkNyMXVHTWlKaHUyZUFDb2dManhKWmMweExrVDhsdXZKRGwzaTNYMmRLKytC?=
 =?utf-8?B?dTVZMC9sTlVwNXQrWDNqYkRYV0w3OTFHVkFFdzlzWUNyWVA1V2ZvS2tKZzZG?=
 =?utf-8?B?QjkrUWVMR2I5QUNLUndWU1hMSGwvN2tHTDBmNWQ4dm5EekR1d3hOL2pHd0NI?=
 =?utf-8?B?dHorNjFlNlFnOXIrTUFpTE4zWWlDVTEzdllkU1pYVGR2QkVkTm9DODV5dGVZ?=
 =?utf-8?B?L3lVL01VdHhyOXREOWoxVjUxV0ZWTisvR3hTWlVLd3ZodVFSQjlta09SYkky?=
 =?utf-8?B?eVNxaEFJbkxIT3hCRWYzQkc5c2RvVU9HL3lDU2xqbTVsQ0pldHhFcGFnZTRZ?=
 =?utf-8?B?b0xvWVA2cytCbTFUaWJlZHBpQVpoNjFYWXlXY0ZhdUFud1A4MU5pTXQxTHJY?=
 =?utf-8?B?Tys1ZUJSaHQxK1NoRUQ5VXNOamwybWRHcFdiT042U3RpTHRsODdVdlF5YUpq?=
 =?utf-8?B?T2VHbURmWXdXRTJBRjVKcjNLRlNVZE1ydDl0dS9uSDgwR0x2REtJRGxkd1ZG?=
 =?utf-8?B?MGJBaUZ6MGRHWVZ3MXJnVTVJQlZsMzJEMmxHOXI4dDdpcmhvdzZBc1BJeGw4?=
 =?utf-8?B?SUxBZG9FTjZXdTNUTnhNZjhlVDdPbXh6ZjJQY1dzcGQ0M1dDQkxWa3ZSd2dt?=
 =?utf-8?B?UVh6M3kxSDZBOTg1azdYeitRTEs4T3hWNmN6eE5OS0F3ekFnbmZycys2TVVx?=
 =?utf-8?B?V3REMlVaZ2MzaXprMTJ1bCthaHErOWNyV2RGWEtLL0JtMktZM3g3blBwcjYz?=
 =?utf-8?B?UjE0ZTVlS3M4OFVWOUp6K01PUlF1ZFFPQnpLZzVOUkhKVGhOTW02SGsxRkU0?=
 =?utf-8?B?a3RzRVE4Y21sTThYeE5TenV5K3BsY3drdkliOUs3WVhidEFpWDhvdEJTNkZz?=
 =?utf-8?B?MlBBcFhVcCthSHN3WXkrM2UzejVRdU5qT3EzaW1kcTB6bFJ2K3VIU09VMU1F?=
 =?utf-8?B?RTRDVTVyU1hpdUJTZ2VlaTk3YUJ3enM1NStud3hsTDU0aE9EUFkvZXZDdFRv?=
 =?utf-8?Q?70m4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a6f582-7577-4ee4-1e39-08dc517a196b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 12:00:03.3925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yqVqIq2g9CnUesHn+X9/a8qV1paN7fEuuwTNHtRzKIsjSF6+CFWx/VEC2ypUoE/16ny54o4Giuy89k0kINAxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6875

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvNF0gQWRkIHN1cHBvcnQgaS5NWDk1IEJMSyBDVEwg
bW9kdWxlIGNsb2NrDQo+IGZlYXR1cmVzDQo+IA0KPiBPbiAyNC8wMy8yMDI0IDA4OjUxLCBQZW5n
IEZhbiAoT1NTKSB3cm90ZToNCj4gPiBpLk1YOTUncyBzZXZlcmFsIE1JWGVzIGhhcyBCTEsgQ1RM
IG1vZHVsZSB3aGljaCBjb3VsZCBiZSB1c2VkIGZvciBjbGsNCj4gPiBzZXR0aW5ncywgUW9TIHNl
dHRpbmdzLCBNaXNjIHNldHRpbmdzIGZvciBhIE1JWC4gVGhpcyBwYXRjaHNldCBpcyB0bw0KPiA+
IGFkZCB0aGUgY2xrIGZlYXR1cmUgc3VwcG9ydCwgaW5jbHVkaW5nIGR0LWJpbmRpbmdzDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gPiBDaGFuZ2VzIGluIHY1Og0KPiA+IC0gTWVyZ2UgYmluZGluZ3MgZXhjZXB0IHRoZSBvbmUg
aGFzIG11eC1jb250cm9sbGVyDQo+ID4gLSBTZXBhcmF0ZSBjbG9jayBJRCBoZWFkZXJzIGluIGEg
c2VwYXJhdGUgcGF0Y2ggcGVyIFJvYidzIGNvbW1lbnRzDQo+IA0KPiBXaGVyZSBkaWQgaGUgc3Vn
Z2VzdCBpdD8NCg0KU2VlIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDMxNTE2NTQy
Mi5HQTE0NzIwNTktcm9iaEBrZXJuZWwub3JnLw0KDQpUaGFua3MsDQpQZW5nLg0KPiANCj4gDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

