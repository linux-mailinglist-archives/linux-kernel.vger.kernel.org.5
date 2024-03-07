Return-Path: <linux-kernel+bounces-95189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558DA874A72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E6E1C2293B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB220839EF;
	Thu,  7 Mar 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="ep4SWQeW"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B851B950;
	Thu,  7 Mar 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802796; cv=fail; b=qaWB23n6a/1fO+RmB8Gi4bs56gcnwQMEUqM5rl+XzkbmQf8Zc/1ytZEMBDMqswIwkQRyvq94c9crCrw2jG7WL+eRx5iWryza34K3sNktfP7u/JZwIC4M8JhSdOEIbPYpf59rudkfcvd/NGKtLXdTIqvplQCrYmMVa5/vGQSvWog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802796; c=relaxed/simple;
	bh=/iu/BsETsB+ZXF9/ciX9XGUt0auZJnKOufdLfdOR+pc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Of5bS6M4HrbqO89ZWTJZ+IqHPZ0kW55AOq7Kah489DSbMDBISOim3t1Qw1dqomIJvhdR0KyuCEiUqEDRo9w2WvEvaI/iFbwuA3ODpK8flP5neButDFA7PNcuvXLi7IaTnRmdOADuowlg4b5qquI7+L9UoaRpXIJ1kIYq1XBRGFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=ep4SWQeW; arc=fail smtp.client-ip=40.107.247.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdTqzpiVull1wwSAA4A8s2qkw4F1AEZDYCPTTu1J66UYA7GgpXQr+dKT3mRfxO8gDaVCoe343f6oIN9IV/LPQwdF30x1GJC/lukIZ8pC3kkWgrNd92J32M7YBuKvutH/sbmo4Anl556gJCajIkGSNQbX1toIzEYU9GJYt4iWXR64ZZCjLHsiRVQ0tRXEgCZ0j6BFD560UI3p4shQGcSs8lTtbLp0J4pT6PxrjqDST2xWcS8kXmSusReznNc0Ii7zXIKEUM+XgcKQbNbk2cZGypcvFBxkkfYouvQX8HlWVWnMkvVvsoVAAeZhfR5NicVzX5qYv+oxrSfmSKq9tWFkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iu/BsETsB+ZXF9/ciX9XGUt0auZJnKOufdLfdOR+pc=;
 b=LgRB89xrUOS5mQmMTf4Fw+HrpennbnkVPskFlYjAiEeBeDUOEaQ72czVKBHwLeiK2Og+f028eQeB/O1nhzo4yn1WxoJuky9pf6vakHPsjdZdAKFisnK5Ew+DHAGUuJ3TOj3nBppCQLqwaGQF6BGHHjjMOanNB/SbeUy7YJQ355poZtQ+R+p8DORlEjFf2gSQpM9vNDfdCp2owIjfY87SSLhOshVKNYqs48BkA4rc/2rrQejG17SCdVFFCpb3W10SVqh3DPxdiII0+KkEqatj5BVJudmLgO7QJU7z24Rmo+2tmroaKphJprNHdQJitXFTLtTKyxk/QVWKl6ioymVCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iu/BsETsB+ZXF9/ciX9XGUt0auZJnKOufdLfdOR+pc=;
 b=ep4SWQeWA4Euic0cwUHSf0UCGHpNKQfMnzy2j7b5X27JKLm7mSTVf5sw4ZrmKwLgEMA5h3Q31Ohi7d6vEFx4SEP0t5VSX3ayx383S1Be+tHkJULhxeYAFl/b4e2hDtbEYP5XfZ9ZuunDdqSKhQnHuLQso7MN7DghQc8ZJzJeIHQ=
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com (2603:10a6:800:1a4::13)
 by GVXPR06MB8684.eurprd06.prod.outlook.com (2603:10a6:150:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 09:13:11 +0000
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41]) by VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41%2]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 09:13:10 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"xiaoning.wang@nxp.com" <xiaoning.wang@nxp.com>, "linux-imx@nxp.com"
	<linux-imx@nxp.com>, "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>, "joabreu@synopsys.com"
	<joabreu@synopsys.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>, "m.felsch@pengutronix.de"
	<m.felsch@pengutronix.de>
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-imx: add support for PHY
 WOL
Thread-Topic: [PATCH net-next 2/2] net: stmmac: dwmac-imx: add support for PHY
 WOL
Thread-Index: AQHab+scVJOjKV/i6ECTY9fbEkaV4bEq+0gAgAEEOgA=
Date: Thu, 7 Mar 2024 09:13:10 +0000
Message-ID: <ddd2f984-e5e7-4708-a013-bfd668794466@leica-geosystems.com>
References: <20240306172409.878928-1-catalin.popescu@leica-geosystems.com>
 <20240306172409.878928-2-catalin.popescu@leica-geosystems.com>
 <bbe3e611-a310-41f5-a037-4b7d5e914b94@gmail.com>
In-Reply-To: <bbe3e611-a310-41f5-a037-4b7d5e914b94@gmail.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB6911:EE_|GVXPR06MB8684:EE_
x-ms-office365-filtering-correlation-id: ea1565f0-ac65-4010-d504-08dc3e86cf59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5gjLyWPnc/6s7kFDWJ4tJ3IbnyU9+FZFjIX94S52iZhpJ3gTNwDoN+QVryCrUmn0a+caGXjxo+KbEQYBA8s6XjYIWLpFsJ7MN7YMiGnl7CnkxI1Yu5N7xytpWNBjkYD/rEAwK9sWhs/1cFkrbKZWOkB6nLCu8aWEXXFjzQWELrMIS9ZF+NdYP4haRb8qRqHLuvxK5M+XThKAO1xO+gh2w71bLHqTE3j53UFWB3n3YEZ+OujynCHDsjZfMLdCQp5sTajUmjl7k3hppGgW+iag6WxV1xfM/W/Kowl2cO6m80uSSMffNzhskNWCwQqf38L1eO9vFNvo9WSVQi35+OxqBQC62VlwuEttPLC786WCQBoAUZBFZ0L3Y+EWRfDTN/KrgwDrb/2HwXggp8Io0AMBBwkWe/fxkRnoC6Jd1/++u8CjE9cMfadZOQzlL3J9fsD2HggEAw/wPRxMuz1eDyYcgOnkaRrtgX662kRfeig6lQ9SGORHW0sLUpCRGceH8BfdqlOHJfvYtpQdv9e6O2Zx4JwzCyrddYmZEROz/7wKPkrOX5qKZ5QTn+UiFEuawx6fhTbxV/oCGymb3Lfz9leLVEb3ySvjw5UCCLcQXQfafY88DCYjBeHTJEPm/9ZyKSUiA5cFufJbJe3j4K/SMirFM2oMo1F2K8x3XEefqF8EkrC37mfT78cX/GyBcZY9xZgTBgtaCG83MA5b6ejovVH81iUpWvHxrmFYgMrtLLX/upU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB6911.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjQ2L25EVmdYK2tRbllKeGhZdXBIUjhFV0hzbzNWT3FmSm92Y3c2RFVMRTFK?=
 =?utf-8?B?MS9vUVBUcjNLZVdqSlRydllIZVNiNFVJQ0Y5SnNTanZ4bng0MnVmWFowdFR6?=
 =?utf-8?B?UklqOTVtUGxRYW5lMFdNRWFyYWZWTHJ4cWFRVzdxVDdNWW5xejhLZGJUM2M4?=
 =?utf-8?B?ZWt4Y3VqZS8yRENKVzQvdUJyWDlEbTlhT2xpNjFRNXFMVTgveFlqa0xVcFNZ?=
 =?utf-8?B?bkZmdGpaRUVkUFBJUUhsUW1hazJZRHdpMm42NXY5TlJxUUdNR2lPYnRkWmV5?=
 =?utf-8?B?dGVVVVZTSHV5ZHY5SnY4dTk5SWlDSTFZKzhqN0RHYWtuNEdqbVIvWDNhbWk0?=
 =?utf-8?B?ck4zeEJROU1WbDZrRnhpSEo5V05ReGhoUnlhOHV5NVZHamNKUkJnWk10Y2Nr?=
 =?utf-8?B?MlV2WFhwcHp5V2t1d3JTMGgyVU5iVGpMYzJwWG9BdU9kdU9aVzV4bElkaDJq?=
 =?utf-8?B?QklWZjRlcll3Q0NGRGpsOFlmUlRjd2pCYjRqV0pSVC9iWjZFWWlUb2ovU0N4?=
 =?utf-8?B?YnNScUtKVDJjbFhJMlRpK0V0WDBNRVd1N3RHMGlnOC9rSmlIQmsrV3NxcU1n?=
 =?utf-8?B?OW56ajlaZ0EwQ3pNOFovNHBaRzZwZXdZdFZ2ekRWdmkxQ0tEYnJPa09ZQ2Yr?=
 =?utf-8?B?NUZxbEhjaEpYQmlGUnIySlR2Njc4NVJjK0JJN2UzVzVqRGNYN1YyQ2JEK21p?=
 =?utf-8?B?blFORktiaUlVTWVNdnJTUDBVVFhDNVc1Y2ptc29sbXJTT0Z6NmdPbTQ3UGVn?=
 =?utf-8?B?THZseERPeTVRTEYvUEFjZG9waVZkcktiY01aUVhIZEsvMTdDaENsTTAwSVg2?=
 =?utf-8?B?dEJXeVZHWThyODFITy80S25RVHJ5RnozbDdPb0hKRHhDTEVCN252V3RIUkp1?=
 =?utf-8?B?UHNPbU1Wa21RVDY3ZUVjQkF0UzNwZVdqY3BDYTI2ZWhBMWdQNy9yaXp5SnVw?=
 =?utf-8?B?Y0U1Q2FkSE9KMjJrd3JTOUM4UnlCanBjRmc1bWVmSmZWSFA4MHB0TjVxSDM0?=
 =?utf-8?B?SDBuUXg4U3IwaDYyaGtxb2tVV3kvU00waFlaMC9zUUVnZWZyQzlqL0RyNUZK?=
 =?utf-8?B?ak9iRVY0MkdMcmIrQkE3USs1dVFIVkFkZ1RybGpzSFREU25jcHFjcjNPSFpw?=
 =?utf-8?B?eDhiTjdlSEVlRmJub3doZWRQbU96cWluZVEyU3JCc2dsc2tqU0pUcWh5eEZM?=
 =?utf-8?B?a0Z5ZVpQV2swYzlJbC9RQm1rL01IWEdoSlJ2aUltR3R0SnNtLzExRTg1eTZ2?=
 =?utf-8?B?L0IyK1NsSGY5dGJhOTB4amdxR09YWkx0RnhKa3ppQUFydHQ2eUY0WWhYcUN5?=
 =?utf-8?B?Ky9uM3NQT2syOHQraUFLRXl4VEZGMTVIZTdRQ1JTcytLdDZDZU1UTFM0cDgr?=
 =?utf-8?B?UGlyVEZhVDRiM285TnI2SXRvVUNiQm51NmVNcUU4MmJ3SlMvY2FOc01QV0R3?=
 =?utf-8?B?cDRWcUd0cmloQ3M0SEZSQ3U5czBMajNKampnSDVwaDEwd0NEVDJoQ3NZYytT?=
 =?utf-8?B?SXQzcXZPTkN5SFFXbHhHdENrU0t3ZGwzRGZZUG9weUNqSGVEWUVNT20vcnRV?=
 =?utf-8?B?eHZsSW5IdUpRUnVMRFZzTGowYzlzRVczMjJlVlNWQ3MydlFCSE55T2RYYlFw?=
 =?utf-8?B?dEFwM2tobDFBVnJuUHp1MzFXUVFIL3VzZDJJMW1LM2JuNUpGbzBNWmdwZ2d4?=
 =?utf-8?B?UjFqbkUyM0xTWEcycCtnY2RrVUEwdWFzTk90eVA3dGlUUU1IRzQxK0s3RXNI?=
 =?utf-8?B?NjJlNzBvZDBxZlVqZnFRTEczOVJOVlBHRmlmZllaZHNYY1J6cEtjV2FoQ0lE?=
 =?utf-8?B?WldZc3diVko0akRoREc5Y2J6aHkyMjkvZE1WMlg3Y01lcGFsVHlXZ2x0UDJk?=
 =?utf-8?B?V3ZLNHdtVDUvUEVEQ0tiSnBUaHJVaXp5UGtLQ2NFQldpVVBJREVUK24yYmdT?=
 =?utf-8?B?ZkcrQmpDeEs1bVN4OG5IaXJFNWtHRVB1U3d5MDBwVVBuS1h6THdMWVMzMW1P?=
 =?utf-8?B?OVhQcTVIYVlXazRUMFFPT0xQZnFnNkFYY2I2dXMrSldYTEs5Z0N5WHJMbzNG?=
 =?utf-8?B?MXJWZzhzUXhRalBJMGhVTnlkek1GRlArQzRLSnJCeDBDWjVwWXBESzhzaGFS?=
 =?utf-8?B?V0VEZ05uV0F0cXFuVXBiZFdtQm5xZ2ZxRW9kWmJhQU51RHhTbmVNT3dBczRj?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CAE2F71502DE44E8AAE1FC71A4B9CCF@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR06MB6911.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1565f0-ac65-4010-d504-08dc3e86cf59
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 09:13:10.5026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnpY3mZb4y3KoQ4TzH5rMn8S++xACWvVELJ3TkbNeNNYrhcy/BqQBOIWmoGkjjxOW6pWaSBKf901wUiUxxodMKx70n7tAdhF9wczBK4qbiIY3xJv0F+QjAc2oCECAEWl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB8684

T24gMDYuMDMuMjQgMTg6NDEsIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6DQo+IFtTb21lIHBlb3Bs
ZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIA0K
PiBmLmZhaW5lbGxpQGdtYWlsLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IA0K
PiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0KPiBU
aGlzIGVtYWlsIGlzIG5vdCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2UuIFBs
ZWFzZSBiZSANCj4gY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2ht
ZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyANCj4gZW1haWwuDQo+DQo+DQo+IE9uIDMvNi8yNCAw
OToyNCwgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4gQWRkIHN1cHBvcnQgZm9yIFBIWSBXT0wg
Y2FwYWJpbGl0eSBpbnRvIGR3bWFjLWlteCBNQUMgZHJpdmVyLg0KPj4gVGhpcyBpcyByZXF1aXJl
ZCB0byBlbmFibGUgV09MIGZlYXR1cmUgb24gYSBwbGF0Zm9ybSB3aGVyZSBNQUMNCj4+IFdPTCBj
YXBhYmlsaXR5IGlzIG5vdCBzdWZmaWNpZW50IGFuZCBXT0wgY2FwYWJpbGl0eSBidWlsdCBpbnRv
DQo+PiB0aGUgUEhZIGlzIGFjdHVhbGx5IG5lZWRlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBD
YXRhbGluIFBvcGVzY3UgPGNhdGFsaW4ucG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4N
Cj4gTm9wZSwgdGhpcyBpcyBub3QgYWJvdXQgaG93IHRvIGRvIHRoaXMuIFlvdSB1c2UgYSBEZXZp
Y2UgVHJlZSBwcm9wZXJ0eQ0KPiBhcyBhIHBvbGljeSByYXRoZXIgdGhhbiBwcm9wZXJseSBkZXNj
cmliZSB5b3VyIHN5c3RlbXMgY2FwYWJpbGl0aWVzLg0KSSdtIG5vdCBzdXJlIHdoYXQgcG9saWN5
IG1lYW5zIGluIHRoYXQgY29udGV4dC4NCkJUVywgZHdtYWMtbWVkaWF0ZWsgZG9lcyB0aGUgc2Ft
ZSB3aXRoIGJpbmRpbmcgIm1lZGlhdGVrLG1hYy13b2wiIHdoaWNoIA0KaXMgYSBjb21taXQgZnJv
bSAwMy8yMDIyLg0KSSB1bmRlcnN0YW5kIHRoaXMgd2F5IG9mIGRvaW5nIGJlY2FtZSAidW5hY2Nl
cHRhYmxlIiBzaW5jZSB0aGVuID8/DQo+DQo+IFdoYXQgc29ydCBvZiBXYWtlLW9uLUxBTiBkbyB5
b3Ugd2FudCB0byBiZSBkb25lIGJ5IHRoZSBQSFkgZXhhY3RseT8gRG9lcw0KPiB0aGUgUEhZIGhh
dmUgcGFja2V0IG1hdGNoaW5nIGNhcGFiaWxpdGllcywgb3IgZG8geW91IHdhbnQgdG8gd2FrZS11
cA0KPiBmcm9tIGEgUEhZIGV2ZW50IGxpa2UgbGluayB1cC9kb3duL2FueSBpbnRlcnJ1cHQ/DQoN
ClBIWSBpcyBUSSBkcDgzODI2IGFuZCBoYXMgc2VjdXJlIG1hZ2ljIHBhY2tldCBjYXBhYmlsaXR5
LiBGb3IgdGhlIHdha2V1cCANCndlIHJlbHkgb24gYSBleHRlcm5hbCBNQ1Ugd2hpY2ggaXMgc2ln
bmFsZWQgdGhyb3VnaCBhIFBIWSdzIEdQSU8gd2hpY2ggDQp0b2dnbGVzIG9ubHkgb24gbWFnaWMg
cGFja2V0IHJlY2VwdGlvbi4NCldlIHdhbnQgdG8gd2FrZXVwIF9vbmx5XyBvbiBtYWdpYyBwYWNr
ZXQgcmVjZXB0aW9uLg0KDQo+DQo+IElmIHRoZSBmb3JtZXIsIHRoZW4geW91IHdvdWxkIG5lZWQg
dG8gaW50ZXJyb2dhdGUgdGhlIFBIWSBkcml2ZXIgdmlhDQo+IHBoeV9ldGh0b29sX2dldF93b2wo
KSB0byBmaWd1cmUgb3V0IHdoYXQgV2FrZS1vbi1MQU4gbW9kZXMgaXQgaXMgY2FwYWJsZQ0KPiBv
ZiBzdXBwb3J0aW5nIGFuZCB0aGVuIG1ha2UgYSBkZWNpc2lvbiB3aGV0aGVyIHRvIHByaW9yaXRp
emUgV2FrZS1vbi1MQU4NCj4gZnJvbSB0aGUgUEhZIG9yIHRoZSBNQUMsIG9yIG1heWJlIG9ubHkg
dGhlIFBIWSBjYW4gYWN0dWFsbHkgd2FrZS11cCB0aGUNCj4gc3lzdGVtIGluIHlvdXIgY2FzZS4N
Cj4NCnN0bW1hYyBhbHJlYWR5IGNhbGxzIHBoeV9ldGh0b29sX2dldF93b2wvcGh5X2V0aHRvb2xf
c2V0X3dvbCB0aHJvdWdoIA0KcGh5bGlua19ldGh0b29sX2dldF93b2wvcGh5bGlua19ldGh0b29s
X3NldF93b2wuIEJ1dCBuZWVkcyBmbGFnIA0KU1RNTUFDX0ZMQUdfVVNFX1BIWV9XT0wgdG8gYmUg
c2V0LiBPdGhlcndpc2UsIGl0IHdpbGwgb25seSB3b3JrIHdpdGggTUFDIA0KV09MIHdoaWNoIHdl
IGRvbid0IHdhbnQuIFdpdGggdGhlIG5ldyBiaW5kaW5nIHdlIGp1c3QgYWxsb3cgdGhlIE1BQyAN
CmRyaXZlciB0byBjYWxsIHRoZSBQSFkgZm9yIHRoZSBXT0wgY2FwYWJpbGl0eS4gVGhpcyBkb2Vz
bid0IGZvcmNlIFdPTCB0byANCmVuYWJsZWQgb3IgZGlzYWJsZWQsIGFzIGl0IGlzIHN0aWxsIHVw
IHRvIGV0aHRvb2wgdG8gY29uZmlndXJlIGl0Lg0KPiBJZiB0aGUgbGF0dGVyLCB0aGVuIHlvdSBu
ZWVkIHRvIGFkZCBzdXBwb3J0IGZvciBXQUtFX1BIWSB0byB0aGUgc3RtbWFjDQo+IGRyaXZlci4N
Ck5vLCB3ZSBkb24ndCB3YW50IFdBS0VfUEhZLCB3ZSB3YW50IFdBS0VfTUFHSUMvV0FLRV9NQUdJ
Q1NFQ1VSRSB3aGljaCANCnN0bW1hYyBkcml2ZXIgYWxyZWFkeSBzdXBwb3J0cy4NCj4NCj4gcHct
Ym90OiBjcg0KPiAtLSANCj4gRmxvcmlhbg0KPg0KDQo=

