Return-Path: <linux-kernel+bounces-136548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E3E89D574
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAA91F214B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D37FBB3;
	Tue,  9 Apr 2024 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NhPthxJS"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2132.outbound.protection.outlook.com [40.107.247.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0687F487;
	Tue,  9 Apr 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654644; cv=fail; b=mghmJgamngMH0UJFI91LK3gYwOt1sjpna4ZG3YaZn74rpz/h8ly8fH03OXdLjzEE1NwgJxYxl7H6XrtKk2mf185vPplJbN9/TRfT7iPqMymFNVx7djU13XHCYTp0OgZfT6DTKG2MI4HsaKmuUSvuAwkKlRxhfMIQTsIEGL5lJO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654644; c=relaxed/simple;
	bh=MXFDgAGtQbdxEatI43qgtmqSrlOdEwygcS/jTMi/VCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xp5XFWPBj+om27/f8hFSXREn7T4+1iT541H7ZNSu6DGahDz9suepE6G4eUE21kY46Kvcj5N9Y7IsYITIg6OTWA0vv/f7kr5reHQ1MzqZ+IYFpQ8aQiSStZpwXAEeA+16B/E05nIl0cSuGhdzFGJaQZKXmEgHDM/9ZPIdrlG7VKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NhPthxJS; arc=fail smtp.client-ip=40.107.247.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKzEz9RN/om1BPAG3aiknCHhpsgdDRE7ezAbSww5sa7m7XiPdR6w6Sw0Vyn1DZ1GvN/Za83SoFhGq0u+rAn9taWNEMq8spN1Z0bUgEL1oPi0nDogQH8jMsHR5fPM021cXZ40if0vTgN2qjkq0xMTUBwbw5d0JCOaidSgfqzV+g0pTZnYeo5Rx1kubXzJlYTHKFCnB4rhJa3y8aZGuhnz2lWqAfFT9kHdDfSWyVU1imczbhYGSXKOQERYR7Z7wScVlm184IjiDUxb7gdzxOqBZuld20ALfXa9GwuD1AEGui51bFCy3Zpi6l4Bv5r4Jqm8kWKKsNefyobIuk0LTQZisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXFDgAGtQbdxEatI43qgtmqSrlOdEwygcS/jTMi/VCQ=;
 b=UeUr/VbrXa+EdI5RpO7gpk/qMo/zdGqFRA5FTbInyvuo2yfm6aclkNjZr61RtqPKTOvy0C9xWa15nUTAQ3VVWcqclGjE4DBJ3byJ53LubEJYH1xqBctTrVRaaTffPGSjeLeZhfwrK0SWxFV0laTvrHdmT+gqKxEdp7M730aKcNbOlHCNp9kfwqPyOocZ66MyzjMovxEoNgjtLpOOQ+yJAf8+HweoZ1QlpEn1nKQUyz2+oZ1O/VKOUMR0ycgLrSC5V8wP7F5z0vHP7FR1JO3p7IakXZiVdOImylXyo1Jd7EYLl8aYg4LTILuEoUN2kOaExvZDLOdaDd2yOweKI1lsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXFDgAGtQbdxEatI43qgtmqSrlOdEwygcS/jTMi/VCQ=;
 b=NhPthxJSCsgX9O5lvYu8yK7pTJDKNyRHEqm3OigIudVDw9D+8+PALLl01Eb3Bi9GkwFMUFO6OYY+PURLzR9QvBcXSjPeXLwDeBVP8rSYCamG/3+PpvKNpPZ8TxedeOJmr9XOfKCnGqkj+6/VdIF1LER/xsSMm5fa8CRjqJZZia0=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 09:23:59 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 09:23:59 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, Jacky Bai
	<ping.bai@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3] arm64: dts: imx8ulpx`
Thread-Topic: [EXT] Re: [PATCH v3] arm64: dts: imx8ulpx`
Thread-Index: AQHail+nywdf3ca0aU+dz+RGTBUGcg==
Date: Tue, 9 Apr 2024 09:23:59 +0000
Message-ID:
 <AM9PR04MB860474D9C7A1434D26B75A7895072@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240409070616.3868152-1-pankaj.gupta@nxp.com>
 <e63cd9ec-45f3-4ae7-8d68-e923b35d05f6@linaro.org>
In-Reply-To: <e63cd9ec-45f3-4ae7-8d68-e923b35d05f6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS8PR04MB7766:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NTcFMyqOIJf33lMQMwkIisOOjR4HNMKHz1axmsOFjxdJE/BCrb0jftgWje5Q3zX4XqcH7KYU7Qf4j8L6JR06HZ1mS7dVqSPFg0yV0221KorlkSwtcKrdHxhX4+MY14IwGsI4iSf0v5A1KcJmQ8a8UPvny4tAiMnsYyGvB5hx9LOSyWn5CPBhY89GWuWG4AtuISQ343IXPRZ99uNrK2omXUjeLrTG0fQsjCOI+dEK8oVqOK8vKHXhY7RNCFEDoP7+eufmyh6KkcX0tf2Z0NeYmqYC5Q0kE6BCFkhd87BKToimHdmyg/2msGxx0VT2hePIuyva393gaZt+0pB3AQ4LKTacMwwfaMRi+BsZuxdF5K9Z64czLS1Kfh5hXvyAbNPDrI1xbcrBB1reNogS61mtQ/sMm09WIZYYeIGhqkygxV4qi/DcMCogTSGfEGnjfwHjO/+FXjErNmynnB+jcSDpF6DLaCFu1IRGqHom1fW7GyeOEk3uo/LF44vBZ7jANpwPeYN/p35Zz6N3k2DOi2fcYB0YlNEiSJqFoXO84DKd3fy6XLW3G0Cs5vl1FJKGGmzYvnl7jG+5Ozs1bjKmhshcqmztqv/NSyrc3ogF2uaHd+ARWmHlmXmbn9IbF6XadE5X8HpOGtvsXiMmdBfzuSoS0hPREgFd8FQ9FzjqaIRVxIs4Co2sK+KY1T/AakQqAwQ0ZmX0Q+IL6r+I84MSjCFPbg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmNTQ3VvaU15S0JKN3g0QmEwclVSdHJIQk5iWXpzNlFVUS81dlJFdE9tTVQv?=
 =?utf-8?B?eG80MDROWlUxWitwL1lzYmVsTG5jeldEazhvV0Y3QnhlaHMxRTkxOHFJQTVK?=
 =?utf-8?B?S2YvYU8reUJwc2VxeDFyRVpsQU83Rkdrdy9HZ0cvS2ZwaTQ1ck9ETUFuY2du?=
 =?utf-8?B?OUp4MHpISC9ldlFMZFh2RXk3VU1KNU15cktuUG9qVUxWRnBsaS90QXQ0K3FU?=
 =?utf-8?B?VGx3U1pzQ3U4ekhlWjNteXF6WnJyZ080WVFpaFZCSkxKbFNKMXVncXh1YXNQ?=
 =?utf-8?B?WlRYQWxON0V5S3ZBckczZEZEZnZIeEZPaUt2NzNjckpaSlZHVVkwcU5KL3Fh?=
 =?utf-8?B?TTFGdzVJbVZuNU9Hc3MxQW5ORkx0WWRHUTFJQmpUM3REejlYM1lSMnlYTUlk?=
 =?utf-8?B?ejZQT0prWElrd0tjeGZ4V01kTDd0Q3Z1WWk1VkFLWGE3ZVc0eEN2RDZRRzZn?=
 =?utf-8?B?NURxb2tDKzN1bzFRYWk5TW5OajZSbFpQVVYvbzljdU5IN3FpYWxqZk5VcVUz?=
 =?utf-8?B?d2xDY1RtS2xQK2VUR0VoNTFyODVmVVRZVGs0WjZ6QzFYc0Q1eXd2a3JrY1dP?=
 =?utf-8?B?cXRYS000ZC9NL2VXcHNRbVRpNVRpdHM2TDhiR2ZGdjRpQVppVnBWaTBycUN2?=
 =?utf-8?B?OTY2R24zeFJ5RDFRTHlKK0xmRWxmNnRtMExKR3BCd0diNGVwK3BEaHhNV0la?=
 =?utf-8?B?ZXZZb0VQcHFyclgyTmhObTV0bm5Ob0NVUXV4dHJIQ1Q2OW5UQ3VFcVIyYUhk?=
 =?utf-8?B?alpvOGhOREZrQk9hWTMva0Q5MGorRmVCZ1V0cjljS1JOdmZoUDVaK0VmelNY?=
 =?utf-8?B?NXdQdkRQRWxvcVU5ZWRHNmZoNHRqTHYzRFY1TllhRk14VVA2ZzRrMUxNdkdS?=
 =?utf-8?B?VFVmYXhkczZCeTJEWFpLOVI5QzNhcTZFbTNNRDk1Y0E5ei8rS1QwRXp5QXdY?=
 =?utf-8?B?MjNrR3Y5V0t3SEtEQWJJV0ZYY2NJOS9rYXZlTkxONy9QRVU3bWJIS2J2bXhB?=
 =?utf-8?B?d0VLS3M1WGpUNklQRi84Y3VMTlFGeUxEUlJnVkhvWVNEV0t0OW9EaWEzTE45?=
 =?utf-8?B?YU1hZEMzSWJXS1pxQmE0MWEzWFVVd3NGSERLS0UxZ1RuWDV1TXp6bzd6N1l4?=
 =?utf-8?B?d2tNV1NyNmk3NDlBUGMweFFva3p0QTI2N1V6ZWtJdzZNU2dla2NRZEprSndL?=
 =?utf-8?B?NGtjMXdQcTNoVXhiVStMajl6aHhsaUxyNVYrUjJsTW1JKzhXMXhtSTBSQzAv?=
 =?utf-8?B?TGFlY2dmVUxYWHl1blVRcVg1eEQ1RXFZU1J1aUJzempIejBwUVZkNlU5a3kz?=
 =?utf-8?B?NXkrZC9RL295NlZEa0c0R2Rrc0xid1pUUm1qV3E5bFc2ZzVlWE0zdi94MzJu?=
 =?utf-8?B?bWhDNHNwRVV3TU9QamZybTM0MDEvZHB3eDBYdXdwVjA0Wkk3VjZzaGhwdHI1?=
 =?utf-8?B?MmJtZTMvemphL1NFTUVIUldQbzdQbGt3a0oxLzllbGc3WG9hWTc0WEhPK3Rm?=
 =?utf-8?B?eFBqcDRmODJ2ZmRQN21sdXdaNVMrUERhS0VXcmhRSlQxa2srUmNJTVdwRm9M?=
 =?utf-8?B?R0swNzRDdTd0WFBmOGtUZ0x0akxpQjVaa3pXOThnSitEL0xLKzEyS1BELzRP?=
 =?utf-8?B?ZlVWMnF5RlhyeFlrazlTckF5a1o3Snp1alV5Mk9aTTBZY1RLdVQvWDNWeVRS?=
 =?utf-8?B?ZzhKazVGTXhydytzNHpyTWdCVUNqb2ZXdHhOblJIQ0V3WmJJcWpkdXFvL1FF?=
 =?utf-8?B?ZmNmbG1PcW9zSFBsM2hCaVN4VlMvZGljN252dEViTng0SjY2YlBIWUx6K0ZC?=
 =?utf-8?B?S2NPWWlxTUdhMXVGQ3c5bCtLZnJOWHhMZnFqbldRUzJlS3ZydVh3REsrVmMr?=
 =?utf-8?B?eG13bjJBM1NHSDZmWU5iOGZOV2ZnWVlmWWhWbml1ZlhGN1IxeXJVTVBOQ2tX?=
 =?utf-8?B?V2ZDanIweUdXZTB6cGVRaUhZd2hoZnRkSUdTbGZqUk9JQS9nRFlHR2Mxbzh0?=
 =?utf-8?B?OVIxSkdUUURRR251azY2ay9Ra05jSkU3bXZ4c2JwYnRjVWpERmFjZlY5SCs0?=
 =?utf-8?B?Y1BIUnlZUDZyaXBoWkZ2K3ZRZmlkU3VPSFpMWm0zWVBPcXUzaVU4WXhUend3?=
 =?utf-8?Q?q7MRZp4dLF9LwvStikLzXQcaz?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d775aa2-aced-4ec9-193a-08dc5876ca0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 09:23:59.8868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpEja0kQpZ/6w7FiQvSGuXtQFUmLa9weehUa4x5aL2AYuQHdvUU4jyTPcG8wt/pUpxlKAoef5LAM5GYYb41QiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBB
cHJpbCA5LCAyMDI0IDEyOjU3IFBNDQo+IFRvOiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBu
eHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxp
bmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1A
Z21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgUGVuZyBGYW4NCj4g
PHBlbmcuZmFuQG54cC5jb20+OyBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+OyBCb3VnaCBD
aGVuDQo+IDxoYWliby5jaGVuQG54cC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNvbT4NCj4gU3Vi
amVjdDogW0VYVF0gUmU6IFtQQVRDSCB2M10gYXJtNjQ6IGR0czogaW14OHVscHhgDQo+IA0KPiBD
YXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4g
Y2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwg
cmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRv
bg0KPiANCj4gDQo+IE9uIDA5LzA0LzIwMjQgMDk6MDYsIFBhbmthaiBHdXB0YSB3cm90ZToNCj4g
PiBBZGQgY3J5cHRvIG5vZGUgaW4gZGV2aWNlIHRyZWUgZm9yOg0KPiA+IC0gQ0FBTSBqb2Itcmlu
Zw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVmFydW4gU2V0aGkgPHYuc2V0aGlAbnhwLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBueHAuY29tPg0K
PiANCj4gdjM/IFdoZXJlIGlzIHRoZSBjaGFuZ2Vsb2c/IFdoYXQgd2FzIGhhcHBlbmluZyBoZXJl
Pw0KW0FjY2VwdGVkXSBBZGRlZCBpbiB2NC4NCg0KPiANCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHVscC5kdHNpIHwgMzINCj4gKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDh1bHAuZHRzaQ0K
PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDh1bHAuZHRzaQ0KPiA+IGluZGV4
IDhhNjU5NmQ1YTU4MS4uOTQ2ZjJiNjhkMTZmIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDh1bHAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDh1bHAuZHRzaQ0KPiA+IEBAIC0yNTIsNiArMjUyLDM4IEBAIHBj
YzM6IGNsb2NrLWNvbnRyb2xsZXJAMjkyZDAwMDAgew0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICNyZXNldC1jZWxscyA9IDwxPjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
fTsNCj4gPg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBjcnlwdG86IGNyeXB0b0AyOTJlMDAw
MCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2ws
c2VjLXY0LjAiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNl
bGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxz
ID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDI5MmUw
MDAwIDB4MTAwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9
IDwwIDB4MjkyZTAwMDAgMHgxMDAwMD47DQo+IA0KPiBLZWVwIHRoZSBvcmRlciBhcyByZXF1ZXN0
ZWQgaW4gRFRTIGNvZGluZyBzdHlsZS4NCltBY2NlcHRlZF0gQ29ycmVjdGVkIGluIHY0Lg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

