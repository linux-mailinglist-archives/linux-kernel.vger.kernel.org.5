Return-Path: <linux-kernel+bounces-124376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDACA89167F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF091F232E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90C535D3;
	Fri, 29 Mar 2024 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qM0Wm+Aw"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2123.outbound.protection.outlook.com [40.107.104.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D354F83;
	Fri, 29 Mar 2024 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711706784; cv=fail; b=jCE1g3/Txkl9QFa2TXIrJYT28iMrRtkrU8b2Qa56F+VqZgGNUtcLG/ywSmld+ZHKOxxHCTvz/iNvzKl9IaVit9la7HtPCoSRoBLjetJm8WlcfXlp1mU4gZaOSeBxijJX8t6p41LnA9fZavrK9NYOiHe0IWPWH6W/6ccq+i/Wq4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711706784; c=relaxed/simple;
	bh=TbM4Lx8GaXy3KMIq7HXTOZsuSSecHw3QHobzcqLZ/Ro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=evbS5UQwDydoviOpU3nPMW+2KMpZVmiZ2zWabkvYTQszEr3H2nxoxgLBQa2X7hfMVO5M+kWpRY3nrUJObmFIjg+tCgd9RTFfWpDgBn0zEgAHPCbPRt+TEuXhxlVWte235cs9kb1AmPAbtahr2yNjjbCxt3PCsBFe0073MdxsF6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qM0Wm+Aw; arc=fail smtp.client-ip=40.107.104.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieJeVJdwETL2vOA4G2HksA7Iz+beo+8VL2DNaHHGt973uJ6KuBW3R9g6f+QynSM5r++7NpRuyt/DMEdp+dK530cK7yi3+Q39vf6k15kVAciY/s2GdiSKZ8ArcXrLv8awYu1DzYmGXVBuVPjxyfBHHSYs93PnHKbdPkEPen3IbVjdDUJ2o6Dkk2YQWN2zu3646qMogfXPzvlNf4JXhTihIxD6orsL0NcMY8RQSYud5bSvFRu48AYD9v6Xm4prpDQcKvnagXPJoD1OJxLQrEsQfQ2TwDHdJotLg9aUuqq8vTkxNeXeqT3RFbYBB9KoKyEOrXYZRWTe87RmjFNNJ+KgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbM4Lx8GaXy3KMIq7HXTOZsuSSecHw3QHobzcqLZ/Ro=;
 b=Nggm9536AucGTXOQO/EexZQRe3zbvZ1hiyHTEz2h3BRDXOr0rWD5SMzuXOzfczmGLh61mFw2MIoNlgB8DMC+ZPOhbeeRXokhITxzC6y7FSDwHk3IyXYY2qzOTkv8ephuP7x0gI08PX36g/nxcDGY4EYbg3NrcjvQk3axZBhvqgCk71aR6SAek1xA6BEIVnQZmRZ9zMwCzjzX10/gydw9SDv2kfoswBkpzlzPd/epXCzHJXMQ6Tsap5BfdXnqAOECVJF7d7rmp62bs/dK8GPnwyXhHkfjsUvl6a1LzhIJJs2macy+7wV27CGUpTlG2f2JVXfp+hs5ZXR2oHxbgM4esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbM4Lx8GaXy3KMIq7HXTOZsuSSecHw3QHobzcqLZ/Ro=;
 b=qM0Wm+AwOFjuhi73HLfKmoEo1Z2ufW6pzSU/sv3pTk0A9zaicckmagQWCZYOsBezJ4pqTPDxw/MvOdsPGq2wIZdY7c6wXk2bdpXxe0uOpG68E4aBQxeg485S4q2MM+gac/vhTgBRrSBvMC8YNMNT77G53hRaisRTy3wq9cNl9qE=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA1PR04MB10293.eurprd04.prod.outlook.com (2603:10a6:102:450::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 10:06:19 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 10:06:19 +0000
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
 AQHab2onJLj7by1TDUGmc5gbcJq9YLE4nU6AgAD7hoCABXXFAIAA1QEAgAAD/+CAAIccgIAA07QAgABoFOCAAvNSAIAEIpWAgAXgVOA=
Date: Fri, 29 Mar 2024 10:06:19 +0000
Message-ID:
 <PA4PR04MB96386917877832602F221282D13A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	 <20240315094927.GA6624@francesco-nb> <ZfTspRKFgrO9xCTH@google.com>
	 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
	 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
	 <ZftaJEIeNfV7YrVo@google.com>
	 <PA4PR04MB9638F5037D1AB9BCF51CC9D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <Zf4rDifM6bLuqpX2@google.com>
 <4e5f3741819e457c5c79d825c6520cb9ee531b95.camel@sipsolutions.net>
In-Reply-To: <4e5f3741819e457c5c79d825c6520cb9ee531b95.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA1PR04MB10293:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A2cyTbhhXcfVW7xBIKKN03Tsyjh0RmC1daEsf4gqdDdCGZwSTTT4cFSJU6NxzceduDR2gNkppc2oS+YARttqx6I3/ysKjIWh2jiAYhis47hckC7VB0CZPTR57+ZDkR8Ga95+71miWq2FL96EzJKJBiabp9JsQfhu9LkOrrjT6xwhBo3ENjO5N1hs2RVQ+BWErJwZlp6/WAd5aE2sfGs4zRPDMTD+wqV/VS/Z0KqO3v/eOZ0K6tFaT2jZWNOol2Tcy7RF60066Mmo7pfVTyZDT9PKiwl1GN1VO4dbB7FoWbLYAw2/hx5ntiRYPlvw2qGlXtKueWF7p3pguz/CiD7oiuPLfu5W9SuSxo7uQBKSb4jFOZGvDwMgkU6EiGZXj56R6OSDt+CI8Dg8Vzkn69vi4xM5dCtEcovojrNsB+Jh+39W4ym0X/zKRi+isWTJuWcGbrhlNnZhRfhhZhp4Ec/FjmVXJH9q7m0DwuWWQcr61NbA7YIBCWFML2uJnOiI31b30EBcdnjKe47iY9Zl9HOPqSN+C/FWGPrEbHRZJW3deTttpSuloQ8kaAGJDTLbRAZHW5Gu0MThKmGRajOOs+9Jq7Ow2wnB/5krf8EKdlCgcQs6Q7Cn2V10FsGyhspyHvFRs8i5i7Eg6vdXCTbPiV455rq4n1NjsRHuOfhu39MVdLg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekExUUNUYjFPNTM3SXZIQmx5amJYdUV2NzFIbXFXKzgwWmdhcGh6UlpJNjZD?=
 =?utf-8?B?VFpHd1dtL1RTRUlKUko4MmxSOENUeVVNbXQvMlQ1THMrWnE2NmFjc3hzK0cx?=
 =?utf-8?B?bUhCSmhRc2h1WDhZRlF2L0dwR3gxaXJVS3pHTVlwQnc3RXhZMVBLMjMweC9u?=
 =?utf-8?B?NU16dWhQY1k0RVFBNmJoV2Rpd2lTeGlXdm9TVUtSRDh0UThqODZPTTRIeGg2?=
 =?utf-8?B?UE1yVVZscEticzYzWjJyK2FNUXQ4c2xGK0NMK282ays1NThiSWFrVzd6SWZO?=
 =?utf-8?B?ZnpxTmlTTnM2UUxmZzVyZzhyc3loM3ZIUmMyQkMwcHNTajFSaDZSWHRnTVBU?=
 =?utf-8?B?YWoxYkpnVS9zRFNNMnJJUjVRVlZFVnM2RTRRaDhUK2NpNFZyUVI5bSt5bUc0?=
 =?utf-8?B?Tjg0bWJhSUl2N0V0MVIwZndHNTVQdDF0NWo4cXZaQytiUWxuVS85b25DZlVE?=
 =?utf-8?B?N1RYVVk5QjNuYXJONHVWVjc3ZVY0M2gybW5tcXBUZmo4U0YwMlJoakVkSkJq?=
 =?utf-8?B?ZnliVm1SejY2NXVxZUY5c2tRQ0d5NXAvZGpyekFwbWVkb1JvZCtkTnR4WFFr?=
 =?utf-8?B?VW00YVpON1RVQWIwamZJY3hLUVhMMWVYQmE4UWNhb3Y3dUZ3T1BjK1luam5J?=
 =?utf-8?B?OEE1NkpPcUROWFBWN0xyaWVDOUVESWNSd0g1L0EyTEhDaE9HOEJYQ1FadlpB?=
 =?utf-8?B?S05ieVYrTXhWKzBxVVJrL2Q2T2h3TWRITW9hUXVVUW1INC93RGNvMnRKYUpk?=
 =?utf-8?B?RTFHcktkRlhBc3g3QXRBNW5mZ2hoUUZra3ZqWGgxc3h3blVQd0FMS3Fta0Mv?=
 =?utf-8?B?MEh0dEhMYmJLOENGMFBSelk4UnlBNHBZL0doSnRLZlM0VWl6YWdwU2dCMmdn?=
 =?utf-8?B?S0xRNzFYUHIwdmw3V3RCdUc0b2lleUxLNkljYXhndlAzWXBIK3V1cXdIQjhG?=
 =?utf-8?B?a3RscUZSZVpodXRrYzdHc0djOWMxSkZiZ0hyK2pPWWYxMitoK1UyZktzV3FE?=
 =?utf-8?B?VWZPNUxXVzJCT1JwTjlvNFBCVlJFRldqMW9FWnY4ZlBDL1ZMTTBIOElQcmRO?=
 =?utf-8?B?Yi9HU0gyaU9hdkNlVkNoNHcwc21FU1FVNDMyZldoZkh6VW81dUdOVklqSXdX?=
 =?utf-8?B?Wi9sSExnTk84bE1YN0hmZ3VRVFNqQkxlODdMSHNMa2lWdDA4cmFQVXcvOFNO?=
 =?utf-8?B?bWYwdXhxUytVNFlVREdTYWJyaitGL3ArY2FBWXJCdDBFMEF4QW1WY2JFc3pW?=
 =?utf-8?B?Q3ZJbVo5VmxLazR6S3JucWk4Z2w5Y25xQmQyc2xqc3htRHNhQVg0QlFpTDU4?=
 =?utf-8?B?Vk1lYnJ5T2dPMzhmdElRb3VLdDFCbDhIZngxeHZXZm1KK0xSTTFjM0RvcnQv?=
 =?utf-8?B?VXVCb1BTRElYdUtTNUY5WEtnQ0ZQOW9Vek1PVUlQMm9lbUk3dHhLblVyNnMw?=
 =?utf-8?B?U01WaW9UbnpxTWhJSHlGTmVleDQvcU5McmQ2TVdYWXdmOC80Rk1Ta1hRYjBt?=
 =?utf-8?B?RXQ0a3RHbVpDMW8wcUlQcmxKZVA1YnpxbTNkZWswWUtrNUtwVjlndkN4UDJF?=
 =?utf-8?B?eUk4cG1iTXMzdVE3dkFxN0toSUpEWk9La2VNbXZmYzExQzMvRUs3Y2xYYjhR?=
 =?utf-8?B?OFFsSFZUQ2gwNmJubEQ5QjliMjJablJ5S3BXZGxvaFJmckl6Y1ZmazlkZkpK?=
 =?utf-8?B?NVVlYjZUemxFZ0pSVHl3amFqUWVtb2g2SmJTZW85eEVLUVpXM00xc1JHZnJO?=
 =?utf-8?B?K0pEdFBGWXNNM052aENLcEZuVVFlOW4xVnBiR0swcFdacjdGdGQzL2JLVzVy?=
 =?utf-8?B?bGRDcGNqTWxoanM2c2ErTUprVWVkY2N5S1cyc2F5dFVYYkllclRxaWlFRHdO?=
 =?utf-8?B?a3RxdzlnOTN1Vzk1c3R2U05DNldwL2pDallpUjJMREIzZTJlUHl3aXhCSU40?=
 =?utf-8?B?bzdhOGVUdERXeUc4VWd0OTNGY3c1WG1MUVhHbG54eHBubGM3cmVyVmg3Zk9E?=
 =?utf-8?B?ZGRuZU5LcUwzMGlFZEp5S0EyWlhqbmhKcEdmd3VLbnFxS1ZuaXVJVkxPTnNK?=
 =?utf-8?B?VjVFSThxeVdCUEh1ck1oZ3BqcmpESkFpMEhrQitJaHB2V2NRanNyTlR5eWZT?=
 =?utf-8?Q?sVZNCqQib4dEtHum1n3chEuqj?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace512b3-ad22-4b77-bcdf-08dc4fd7e142
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 10:06:19.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hu3vrcS1+iob3D10DSKS7hbX4CTUHlkoqkGC8TQ93bfUW++PUX5V07kIgnEMDHnmejEiE5fP/iHwEXJQKAW53g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10293

PiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50
OiBUdWVzZGF5LCBNYXJjaCAyNiwgMjAyNCAxMjoxNSBBTQ0KPiBUbzogQnJpYW4gTm9ycmlzIDxi
cmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+OyBEYXZpZCBMaW4NCj4gPHl1LWhhby5saW5AbnhwLmNv
bT4NCj4gQ2M6IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY29AZG9sY2luaS5pdD47IGt2YWxv
QGtlcm5lbC5vcmc7DQo+IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgUGV0ZSBIc2llaA0KPiA8dHN1bmctaHNpZW4uaHNpZWhAbnhw
LmNvbT47IHJhZmFlbC5iZWltcyA8cmFmYWVsLmJlaW1zQHRvcmFkZXguY29tPjsNCj4gRnJhbmNl
c2NvIERvbGNpbmkgPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBTdWJqZWN0OiBS
ZTogW0VYVF0gUmU6IFtQQVRDSCB2OSAwLzJdIHdpZmk6IG13aWZpZXg6IGFkZCBjb2RlIHRvIHN1
cHBvcnQgaG9zdA0KPiBtbG1lDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVt
YWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBh
dHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAn
UmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIEZyaSwgMjAyNC0wMy0y
MiBhdCAxODowNiAtMDcwMCwgQnJpYW4gTm9ycmlzIHdyb3RlOg0KPiA+IFdlIGFwcHJlY2lhdGUg
aXQncyB3ZWxsIHRlc3RlZCwgYnV0IHRlc3RpbmcgaXMgc3RpbGwgb3J0aG9nb25hbCB0byB0aGUN
Cj4gPiBhcmNoaXRlY3R1cmFsIHF1ZXN0aW9ucy4gQXJjaGl0ZWN0dXJhbCBxdWVzdGlvbnMgYXJl
IGltcG9ydGFudCBiZWNhdXNlDQo+ID4gdGhleSBhZmZlY3QgdGhlIGZ1dHVyZSBtYWludGFpbmFi
aWxpdHkgb2YgdGhlIG1haW5saW5lIExpbnV4IHdpcmVsZXNzDQo+ID4gc3RhY2suIElmIHRoZSBh
c3N1bXB0aW9uIGlzIHRoYXQgKmVpdGhlciogYSBkcml2ZXIgaXMgYSBjZmc4MDIxMQ0KPiA+IGRy
aXZlciAod2l0aCBmaXJtd2FyZS1NTE1FLCBldGMuKSBvciBhIG1hYzgwMjExIGRyaXZlciAod2l0
aCBob3N0DQo+ID4gTUxNRSksIHRoZW4geW91ciBzZXJpZXMgaXMgYnJlYWtpbmcgdGhvc2UgYXNz
dW1wdGlvbnMuDQo+IA0KPiBNYXliZSwgbWF5YmUgbm90LCBhY3R1YWxseS4gVGhlIGF1dGggY29t
bWFuZCBfaXNfIHNvbWV3aGF0IHNwZWNpYWwgaW4NCj4gdGhhdCBpdCBtb3N0bHkgaGFuZHMgc3R1
ZmYgZG93biBmcm9tIHVzZXJzcGFjZSB2aWEgY2ZnODAyMTEsIGJ1dCBkb2VzDQo+IHJlcXVpcmUg
c2VuZGluZyBmcmFtZXMuIEFzIGxvbmcgYXMgeW91IGRvbid0IGhhdmUgZnVsbCBvZmZsb2FkLCBh
dCBsZWFzdC4NCj4gDQo+IFRoZSB3YXkgSSBzZWUgaXQsIHRoZSBpc3N1ZSBoZXJlIGlzbid0IG5l
Y2Vzc2FyaWx5IHRoZSBmYWN0IHRoYXQgdGhpcyB1c2VzIHRoZQ0KPiBhdXRoIGNvbW1hbmQgKGFu
ZCB0aGVuIHJlcXVpcmVzIGFzc29jLCBvZiBjb3Vyc2UpLCBidXQgdGhhdCB3ZSBzZWUgaGVyZQ0K
PiB0aGlzIGlzICJncm93aW5nIiB0b3dhcmRzIGEgbW9yZSBtYWM4MDIxMS1saWtlIG1vZGVsLCB3
aXRoIHRoZSBjb2RlDQo+IGR1cGxpY2F0aW9uIChhbGJlaXQgbGl0dGxlIHRoYXQgaXQgaXMgdG9k
YXkpIGltcGxpZWQgYnkgdGhhdC4gVG8gbWUsIGl0IHNlZW1zIGxpa2UNCj4gdGhlIGZpcm13YXJl
IGlzIG1vdmluZyBpbnRvIHRoZSAib2ggd2UgY2FuJ3QgZG8gYWxsIF90aGF0XyBpbiBmaXJtd2Fy
ZSINCj4gdGVycml0b3J5LCBhbmQgdGhhdCBicmluZ3MgaXQgY2xvc2VyIHRvIG1hYzgwMjExLg0K
PiANCj4gQXQgdGhlIHNhbWUgdGltZSwgYXMgeW91IHNheSwgbWFjODAyMTEgaXMgZG9pbmcgbW9y
ZSBhbmQgbW9yZSBvZmZsb2FkDQo+IGNhcGFiaWxpdHksIHNvIGl0IHNlZW1zIGxpa2UgYXBhcnQg
ZnJvbSAidG9kYXkgdGhlIGZpcm13YXJlIHJlcXVpcmVzIGFuIGFzc29jDQo+IGNvbW1hbmQgcmF0
aGVyIHRoYW4gYXNzb2MgZnJhbWUgcHJvY2Vzc2luZyBpbiB0aGUgaG9zdCIsIGl0J3MgYWN0dWFs
bHkgbm90DQo+IF90aGF0XyBmYXIgYXBhcnQgYW55IG1vcmUhDQo+IA0KPiBOb3cgdGhhdCBtYXkg
YmUgYW4gaXNzdWUgaW4gdGhlIHNob3J0IHRlcm0sIGJ1dCBJIHdvdWxkbid0IGJlIHN1cnByaXNl
ZCBhdA0KPiBhbGwgaWYgZGVzaXJpbmcgdG8gaW1wbGVtZW50IEZJTFMgYW5kIG90aGVyIG5ldyBm
ZWF0dXJlcyBpbiB0aGlzIHNwYWNlIHdvdWxkDQo+IG1ha2UgdGhlIGRyaXZlciBtb3ZlIHRvIGFz
c29jIGZyYW1lIHByb2Nlc3NpbmcgaW4gdGhlIGhvc3QgYXMgd2VsbCwgYmVjYXVzZQ0KPiBpdCdz
IGdldHRpbmcgbW9yZSBhbmQgbW9yZSBjb21wbGV4LCBqdXN0IGxpa2UgYXV0aC4NCj4gDQo+IEF0
IHdoaWNoIHBvaW50IC0geWVhaCB0aGUgQVBJcyBhcmUgc3RpbGwgc2lnbmlmaWNhbnRseSBkaWZm
ZXJlbnQsIGJ1dCBhZ2FpbiB3ZSdkDQo+IGVuZCB1cCBpbXBsZW1lbnRpbmcgc29tZXRoaW5nIHRo
YXQgZXhpc3RzIGluIG1hYzgwMjExIHRvZGF5IGFuZCB0YWtpbmcgaXQNCj4gaW50byBtd2lmaWV4
Pw0KPiANCg0KTXdpZmlleCBpcyBkZXNpZ25lZCBiYXNlZCBvbiBhICJUaGljayBGVyIgYXJjaGl0
ZWN0dXJlLiANCkFzIHNlY3VyaXR5IGZlYXR1cmVzIGJlY29tZSBtb3JlIGNvbXBsaWNhdGVkLCB0
aGlzIHBhdGNoIGFkZHMgV1BBMyBzdXBwb3J0IGJ5IG9mZmxvYWRpbmcgdG8gd3BhX3N1cHBsaWNh
bnQvaG9zdGFwZA0KV2l0aCB0aGlzIHBhdGNoLCBhdXRoLCBhc3NvYyBhbmQga2V5IGhhbmRzaGFr
ZXMgYXJlIGhhbmRsZWQgaW4gd3BhX3N1cHBsaWNhbnQvaG9zdGFwZC4gDQpXcGFfc3VwcGxpY2Fu
dCBjb21tdW5pY2F0ZXMgcGVlciBjYXBhYmlsaXR5IGFuZCBkZXJpdmVkIGtleXMgdG8gZHJpdmVy
L0ZXIHZpYSBjZmc4MDIxMSBhc3NvYyBhbmQgYWRkX2tleSBjb21tYW5kcy4gICANClRoZSBjZmc4
MDIxMSBjb21tYW5kcyBhcmUgc3RhbmRhcmQuIEltcGxlbWVudGF0aW9uIGJldHdlZW4gZHJpdmVy
IGFuZCBmaXJtd2FyZSBpcyB2ZW5kb3Igc3BlY2lmaWMuIEl0IHNoYWxsIG5vdCBicmVhayBhbnkg
ZXhpc3RpbmcgYXJjaGl0ZWN0dXJlLg0KDQo+ID4gSXQgbWF5IGJlIGhhcmRlciB0byBhZGQNCj4g
PiBmdXR1cmUgYWRkaXRpb25zIHRvIHRoZSBtYWM4MDIxMSBzdGFjayBbKl0sIGlmIHdlIGhhdmUg
dG8gYWRkIG5ldw0KPiA+IGNvbmNlcm5zIG9mIGEgbm9uLW1hYzgwMjExIGltcGxlbWVudGF0aW9u
IGluIHRoZSBtaXguDQo+IA0KPiBOb3Qgc3VyZSB0aGF0IG1ha2VzIGEgZGlmZmVyZW5jZSBmb3Ig
bWFjODAyMTEgaW4gaXRzZWxmLCBvYnZpb3VzbHkgY2hhbmdlcyBpbg0KPiB0aGlzIHNwYWNlIHdv
dWxkIHRoZW4gYWZmZWN0IG13aWZpZXgsIGJ1dCB0aGF0IHNob3VsZG4ndCBiZSBtdWNoIG9mIGFu
DQo+IGlzc3VlLg0KPiANCg0KV2l0aCB0aGlzIHBhdGNoIE13aWZpZXggc3RpbGwgYSBub24tbWFj
ODAyMTEgaW1wbGVtZW50YXRpb24uIA0KRHJpdmVyIGNvbW11bmljYXRlcyB3aXRoIHdwYV9zdXBw
bGljYW50L2hvc3RhcGQgdmlhIGNmZzgwMjExIA0KSSB0aGluayBob3cgZHJpdmVyL0ZXIGNvbW11
bmljYXRlIGVhY2ggb3RoZXIgaXMgcHJvcHJpZXRhcnksIEkgZG9uJ3Qgc2VlIGEgZGVwZW5kZW5j
eSB3aXRoIG1hYzgwMjExIGhlcmUNCg0KPiBJJ20gbGVzcyB3b3JyaWVkIGFib3V0IHRoaXMgaW5k
aXZpZHVhbCBwYXRjaCB0aGFuIHdoYXQgaXQgc2F5cyBhYm91dCB0aGUNCj4gZGlyZWN0aW9uIHRo
aXMgZHJpdmVyIGFuZCBmaXJtd2FyZSBhcmUgdGFraW5nLCBhbmQgSSBmZWFyIHdlJ2xsIGVuZCB1
cCBpbiBhDQo+IHNpdHVhdGlvbiB3aGVyZSBvdmVyIHRpbWUgdGhpcyBkcml2ZXIgYWN0dWFsbHkg
Z2V0cyB0byBhIHBvaW50IHdoZXJlIGl0IHNob3VsZA0KPiBiZSB1c2luZyBtYWM4MDIxMSwgYnV0
IGJlY2F1c2UgaXQncyBzdWNoIGEgcGllY2UtbWVhbCBhZmZhaXIgKGF1dGggZnJhbWVzDQo+IG5v
dywgZXRjLikgYW5kIGxhcmdlIGFyY2hpdGVjdHVyYWwgY2hhbmdlLCB0aGV5J2QgbmV2ZXIgYWN0
dWFsbHkgZG8gdGhhdC4NCj4gDQo+IFRvIGJlIGZhaXIsIHRoYXQgbWlnaHQgYWxzbyByZXF1aXJl
IGZpcm13YXJlIEFQSSBjaGFuZ2VzIGluIHNvbWUgd2F5LiBJIHVzZWQNCj4gdG8gdGhpbmsgdGhh
dCB3YXMgc29tZXRoaW5nIHdlIHNob3VsZCBuZXZlciByZXF1aXJlLCBidXQgSSdtIG5vdCBzbyBz
dXJlDQo+IG5vdyBhbnkgbW9yZSAtIGNlcnRhaW5seSB3ZSd2ZSBjaGFuZ2VkIG91ciAoSW50ZWwp
IEZXIEFQSSBpbiBzdXBwb3J0IG9mDQo+IExpbnV4IGFyY2hpdGVjdHVyZSBtYW55IHRpbWVzLCBh
bmQgb3ZlcmFsbCB0aGF0J3MgZm9yIGEgYmV0dGVyIHByb2R1Y3QgKG9uDQo+IExpbnV4IGF0IGxl
YXN0LikNCj4gDQo+IEFsc286IERhdmlkLCBJJ2QgYXBwcmVjaWF0ZSBpZiB5b3UgYWN0dWFsbHkg
dG9vayB0aGlzIGRpc2N1c3Npb24gc2VyaW91c2x5OyBzbw0KPiBmYXIgeW91J3ZlIG5vdCByZWFs
bHkgY29udHJpYnV0ZWQgYW55IHRlY2huaWNhbCBhcmd1bWVudHMuDQo+IA0KPiBKb2hhbm5lcw0K
DQpJIHRoaW5rIHdlIGFyZSB1c2luZyBzdGFuZGFyZCBjZmc4MDIxMSBjb21tYW5kcy4gSG93IGl0
J3MgaGFuZGxlZCBiZXR3ZWVuIGRyaXZlci9GVyBpcyBwcm9wcmlldGFyeSwgaXQncyBjYXJlZnVs
bHkgdmVyaWZpZWQgYW5kIHNoYWxsIG5vdCBpbXBhY3Qgb3RoZXIgZmVhdHVyZXMgb3IgYnJlYWsg
YW55IGFyY2hpdGVjdHVyZS4gDQpXZSBkbyBub3Qgc2VlIGEgbmVlZCB3aHkgZHJpdmVyIGhhcyB0
byBiZSByZWRlc2lnbmVkIGJhc2VkIG9uIG1hYzgwMjExLiBXZSBjYW4ga2VlcCBhZGRpbmcgbmV3
IGZlYXR1cmVzIHVzaW5nIGNmZzgwMjExLg0K

