Return-Path: <linux-kernel+bounces-111084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C498D8867B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A671C235CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207F1426C;
	Fri, 22 Mar 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="Gp5o3n91"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BC134A3;
	Fri, 22 Mar 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094298; cv=fail; b=AJg4LFT14stUQZimtng4ULpO32fT/D2nBfPhvesvSMJi5EN7uekltz/wgeLnjknGnmqZG5w+E/f7ZxcTIZ5sOSE2TdHpwtxYBQni3TAUwu0KoJl+PctXuDfLIyP8EVuwTCtohoiMbD7PVtoMxCFpUqqhvlTkzyaiabi/Lm7iVIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094298; c=relaxed/simple;
	bh=xRq/Zxl2XLAOeL7XpKDiwdsk3zCw0N1xnI9imPXT178=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J6fF0Z1/KQEbvWbl4K6sDQJKsTIpxygPTNVa/XCdBWskeaVkcqOnzCyxOfJoIgD2+p/RY1Uv/wAhAXLAuTMvgJr316slr+FIH9p7ZpeNzLMsTbrB76zPSsAzziUdlAQk2eMQBORhMect8wq1/Y5x0/I6g1COIYftuZidPMNvaMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=Gp5o3n91; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0hR4W1EtyukkcTygxKFt3GACn53VjjnkHGskkoAqPboVafM0WLWkMK1YdjpYicDkyS1ItZanzPRxTHswx+rENJ8Mh4YDkSWS0knx4FTMf4r0LmGngtOfYM8yokKTf9xfaTnTwU3MY/5pmf4ISYH3xzG9oEssfcSSUfHKkm0xl9+AgVoefvWkWMLpOUNeosyexp3Kx3WmNrHWtZaiGZZWzmGnDvdsUirhFEqmvzJaC2g+vwSYtclHGnhAqadzHW3TEndEmTaF6GAgwScThK15Qqb67K8C6XnQX/rs3p6t7u3O+yEczIJI0mPW9oo7aPIiIm4Fmmnp6OtBmXe9/UpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRq/Zxl2XLAOeL7XpKDiwdsk3zCw0N1xnI9imPXT178=;
 b=NAqUUvfXt8bsxiidUcL18A2iOauE74idQAaeMNQFKSG1cZFtYPUmYy8BVXZTuQjhwxWKGnyC05Nu0uE/am+fahNK3olIsaWa/wpetS9iw5p+cuU+7N281PVSuC2HC2z71nOjXQuLlqUCrd6iM6RoJn63xRqnG+sn8Ujq4A2/3Sp4IKMf8smfPQmRkObgIaxtNUfyFMJI77PgMuqKJnTT6w1lvQ3/KPOGndwYIzPZS3XTmFt4VNn0dnJF593ti/KClBxl3CyfPae3nCs9sK00P9hlX+QOO1pSPuRZ8ucneDjs2aSt4arJD/KDrlzolvX+lKdUJ4OdcCUquelVBe7+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRq/Zxl2XLAOeL7XpKDiwdsk3zCw0N1xnI9imPXT178=;
 b=Gp5o3n91CLvueiudqRakCaR1PzfBvYJoCHLSA/+3yv6GFtd5prbPd3FWrwB8raePeOvx46jmPAdMTbqbusVendeGHAdjLVsP4Zy7XwrXXtUoI/y4a6Dad4LX3M0QybvaqPguHP0je6f6/BLZJa0De9w48r6vXzhwWO8ekkiXIbA=
Received: from PR3PR06MB6908.eurprd06.prod.outlook.com (2603:10a6:102:8b::13)
 by AS8PR06MB7751.eurprd06.prod.outlook.com (2603:10a6:20b:332::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 07:58:14 +0000
Received: from PR3PR06MB6908.eurprd06.prod.outlook.com
 ([fe80::4f16:579f:7380:5341]) by PR3PR06MB6908.eurprd06.prod.outlook.com
 ([fe80::4f16:579f:7380:5341%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 07:58:14 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH next] clk: rs9: fix wrong default value for clock
 amplitude
Thread-Topic: [PATCH next] clk: rs9: fix wrong default value for clock
 amplitude
Thread-Index: AQHab/DCG/iHt9Eo40epYh1g6iaq+rFDfX+A
Date: Fri, 22 Mar 2024 07:58:13 +0000
Message-ID: <4181961d-9c38-4794-88c6-602cd5b6e6c6@leica-geosystems.com>
References: <20240306180435.1033052-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20240306180435.1033052-1-catalin.popescu@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR06MB6908:EE_|AS8PR06MB7751:EE_
x-ms-office365-filtering-correlation-id: 6b044598-f6fa-4f26-53a1-08dc4a45d376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 35Ys52QMmKw0aBhxn96yMWH3F2caYVi7igxReT2JP4Z/fZEExUA02Z6+4eDdcuXLZuQHBYAuqdHz6Et7eAJcBEVzPSgm4flbufKaI0cGBh8bpnRCUDJbVO+803DHKbFctLlZdT+/fDYSLXCD/qgREFoHVFxA7JSdQarwvguWo4tWrVEmFc3UFFkvREWyHlO5bN8hw6V31h33ZKYSFXeM1bzsFAxFysf2EJf72sEdg/m/nKhKefXwLlGZZGxogc30JGHPJrY12cBXKCbk1QdC+gviw+neovTJcfKleLbsnoc8H4pgSfB1XA+gxz0bmOsJ6wv7/aHXH2RCJF+VJkKoJ0WHUROArFxJqX2b47ZCgYD6KF2/AXSwLZnoUaK2QRXmL6gOaqnMQ39HXHQcOfyHTMiBp/WC/kE0q9ngCs9HoySBRU/t/vgZ4sycQRCDOOpFXgRasU2ofO5iigMqsqg+cQUs7k6wWrZQ9XfnwlQjDobeHBaJsmCRBb6pUcjMkuBvADCsA0LkBwWvc3mtbzUm33rYnJN3w8RpbECNcb9Md8TsRKXWQBINu6mS6bRyfzM3CUw0aUFWCmEZysc/HzHjDwQ5ZlNs1ZMGLt+HODhPP2/vd8gGLMy7M0gFWubk3a3pkWuWIIE95DtoSr7KKN9YiFQ37LHl42rSwX55vx9ySxaGJJCC4Nim7DrsCGu/FnolRKC5nBnp2/8yazNnmQ+kwrRfi3/Lb+DTK9FoKO8xKjE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR06MB6908.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXlOYkw2QjFFVk55ZE80SzRuQXoyR1praWMvTlM0YitEU0lpRzZyeE9RVHA5?=
 =?utf-8?B?b2JpWEhUK1NBMnpXNkVPWWtkUjlMMlQxVzFzS2NBS1FxRlNpVVAxVjlGcHZj?=
 =?utf-8?B?MW4rdElJZUR1WmdwVk8vWldtUzdIYWJOWTFQbElvTTRmM2g0QXFIeXZXcTFj?=
 =?utf-8?B?U1Vwbm03endvYTQyNGsrOTRvMXBySEVnc1BIUmdIWHZTL3dSaEUvVy82ZkpZ?=
 =?utf-8?B?MkxFU25RQ3JYY3JkZHNXeTJZZFpJOWVjZVh6OTMvdnVVazVLMjhYR1NLTTdI?=
 =?utf-8?B?N0ZrbC8zV2gzTFpuZ09XQVNuY2xMMk0rRDJIRVhoSWltd2Y2ZHRXcG5vd25i?=
 =?utf-8?B?SmwxWWZ2MmNYWVdnUGZxcnRzMzZsMzExZnZaNCtrdS9VbEtDall2NllvTDBa?=
 =?utf-8?B?UGFPOE8vcVFvOXNzOXREc2hFc0NmK2VsRFNOblcya2xvLzNOdzJuSXFjT0lL?=
 =?utf-8?B?dE52V0RYSDd2U3dOaHVodUdOUFBod1c1ek9rVllVenRhd2lzdFBEeEFoVitI?=
 =?utf-8?B?SHRhVDMwaS93R0RRZVZqN3JvNThzNGRTamE4K3VBL2RxcXU0WUNUT2kya3BH?=
 =?utf-8?B?SzhTdCtiVkd4d2ZreW1qUEg5empyUFh3bkFOdkl5VFd0Qy9YdXMwbDNMQ3g1?=
 =?utf-8?B?WkRzMFZQTXFuMVBONU1tbytRTHBNL3pDZTlyMytVcy9vM2pvY2FCcEgzbWcv?=
 =?utf-8?B?WFh6TytOUExCcktFSkEwS3plRU9vd3B4VzdaYk84QkNQZzRJWE43OEk1MnhN?=
 =?utf-8?B?bXp2RXB3bjlkVHdwSEI1Z3ZiRzVoOStYMEFlaGhwWU4rS0xEazI0ZWpyUGky?=
 =?utf-8?B?dmdwblcraDg2SEVFeVF5enFsSkdLZFJvZ2ZGa0xMNTk2UDF6MkVGMEpzODhZ?=
 =?utf-8?B?aVlSVnZFcWdZM0Q2aUh1cVJWQ2daV25GSUdWV2dnWHQ5blhPa21KYWd6T1RG?=
 =?utf-8?B?am13WkZST2pvV3JsVTFVekNyOWZ1MU9odlhSenM0NjRGbHNVa2EzRHVqODhG?=
 =?utf-8?B?WlJqdEMxc1BiVkZ4c1BtdUtlbHJ3dGJWQ21RWDc1YnBxcDlWaE1mYkNOUDEv?=
 =?utf-8?B?MXlvWVZSdXNzWFdja05LMXdnVFNkb3dsa041TzZxQVVVQ3N3QzBpNDgwaDRk?=
 =?utf-8?B?UzhNcGJXMnVEVHFadTBXNUNzNkNpcHRNelhXZnFqOHZoMUlSYmljTWR4U1BS?=
 =?utf-8?B?eWo3cWc3d05jTTVRNmdZcitsejJUM2daSHRxUE96U2ZzMUpqY0pQSk5xNHpj?=
 =?utf-8?B?djhCT2ZlbXZORExpcVNHVnZ1S0gwa1lsZHZRdGxza2puR0xXQ1ZzUGpjWVlO?=
 =?utf-8?B?djhXUFNzU0w3aDRFUEEzelVJNVVRMzZNZ0ZmM2pmMGJUV1lVQVhtN2tiZDUx?=
 =?utf-8?B?QmV5bFNrUVpCOWVRVmJSVWtueFNVcnlaVnd1WDRpeUZaNlR5UDhKS3cya0la?=
 =?utf-8?B?QzE4bWxEdlhuVjF1V3l1UFF2MzJjNytrQlhoOGRiRWlicHY2K3JWWWFibnhB?=
 =?utf-8?B?WDhITUFFM1VZUWIzU2gvM3RYeUZ6WEUzTm9IKzJnRTRFYTFRYml1N3ZLNmRC?=
 =?utf-8?B?bnBSMjBkMkh6L2ZYVTVQVVpCYjhPZGJHdjcrTHFUU25rYmlRQU9tZWlqTDMz?=
 =?utf-8?B?NWxDUkdzUjVyc2dydmVCNGdxVlVjV1UxZEY3aUVxTDc0b3c1aEttaGNiMGJI?=
 =?utf-8?B?am1ySVBqRGhiWkc5R3pvZEtGRGdQcjJmQ0JRRDBnTjlqT2toQmt3TTRLYXFO?=
 =?utf-8?B?TVlVMnRtZmU0emJ5R3MzRVFCOEo3N0ZmYVJyamZ2SGJobSs2NHFPalRQeFkr?=
 =?utf-8?B?YlpDVDhEQ0xNbjhiZERGNkRMM29hbkNuZVNTdVBSSUc5MmRjUWovcnUweFRw?=
 =?utf-8?B?dGRKL3RNT2MxaVZRT0REN21odXgrMFpSenNsT2pyeVpiTmZ1TXpuQm1PWjhC?=
 =?utf-8?B?c3dKZ2d1MWVyUXkvMVhJeFdlb1NmSWJOZk1ReFZtWm9odXBEeGp4T1pyVTlm?=
 =?utf-8?B?YXRVaXhOU09Xb3FCVjlJWURVTFFuNWFLWnUxWllqK1NrbkV3RGV6RGovV2pG?=
 =?utf-8?B?UmRGLzRJNU9HNnV6ZEhJTHJMR0J1YlpJQ0U1M0ZCRlpsMDhjNVpPcVNCaUxx?=
 =?utf-8?B?MnE0TTcycVEveUpYRDhoc3FPUXJMOWtBMWV1NWplUlBiVFR4R3d6dUtiZlpk?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <581F358B84EC1D41AAABA56985F9F99B@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR06MB6908.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b044598-f6fa-4f26-53a1-08dc4a45d376
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 07:58:14.0300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6T6IYxid+HPj37EdgNH0oEInXv59t1z0Q3XV21aHkptWaTBIMrfmdXAtxMykIfB78tA9SroDKRJfvhRDC9sAsYj3ggazYpAQ/P75evPFJ/y2IyVnqCEMoZMRY8xhgclI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7751

UGluZyA6KQ0KDQpPbiAwNi8wMy8yMDI0IDE5OjA0LCBDYXRhbGluIFBvcGVzY3Ugd3JvdGU6DQo+
IEFjY29yZGluZyB0byA5RkdWMDI0MSAmIDlGR1YwNDQxIGRhdGFzaGVldHMsIHRoZSBkZWZhdWx0
IHZhbHVlDQo+IGZvciB0aGUgY2xvY2sgYW1wbGl0dWRlIGlzIDAuOFYsIHdoaWxlIHRoZSBkcml2
ZXIgd2FzIGFzc3VtaW5nDQo+IDAuN1YuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENhdGFsaW4gUG9w
ZXNjdSA8Y2F0YWxpbi5wb3Blc2N1QGxlaWNhLWdlb3N5c3RlbXMuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL2Nsay9jbGstcmVuZXNhcy1wY2llLmMgfCAxMCArKysrKystLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2xrL2Nsay1yZW5lc2FzLXBjaWUuYyBiL2RyaXZlcnMvY2xrL2Nsay1yZW5l
c2FzLXBjaWUuYw0KPiBpbmRleCA1M2UyMWFjMzAyZTYuLjRjM2E1ZTRlYjc3YSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9jbGsvY2xrLXJlbmVzYXMtcGNpZS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xr
L2Nsay1yZW5lc2FzLXBjaWUuYw0KPiBAQCAtMjUsMTAgKzI1LDEyIEBADQo+ICAgI2RlZmluZSBS
UzlfUkVHX1NTX0FNUF8wVjcJCQkweDENCj4gICAjZGVmaW5lIFJTOV9SRUdfU1NfQU1QXzBWOAkJ
CTB4Mg0KPiAgICNkZWZpbmUgUlM5X1JFR19TU19BTVBfMFY5CQkJMHgzDQo+ICsjZGVmaW5lIFJT
OV9SRUdfU1NfQU1QX0RFRkFVTFQJCQlSUzlfUkVHX1NTX0FNUF8wVjgNCj4gICAjZGVmaW5lIFJT
OV9SRUdfU1NfQU1QX01BU0sJCQkweDMNCj4gICAjZGVmaW5lIFJTOV9SRUdfU1NfU1NDXzEwMAkJ
CTANCj4gICAjZGVmaW5lIFJTOV9SRUdfU1NfU1NDX00wMjUJCQkoMSA8PCAzKQ0KPiAgICNkZWZp
bmUgUlM5X1JFR19TU19TU0NfTTA1MAkJCSgzIDw8IDMpDQo+ICsjZGVmaW5lIFJTOV9SRUdfU1Nf
U1NDX0RFRkFVTFQJCQlSUzlfUkVHX1NTX1NTQ18xMDANCj4gICAjZGVmaW5lIFJTOV9SRUdfU1Nf
U1NDX01BU0sJCQkoMyA8PCAzKQ0KPiAgICNkZWZpbmUgUlM5X1JFR19TU19TU0NfTE9DSwkJCUJJ
VCg1KQ0KPiAgICNkZWZpbmUgUlM5X1JFR19TUgkJCQkweDINCj4gQEAgLTIwNSw4ICsyMDcsOCBA
QCBzdGF0aWMgaW50IHJzOV9nZXRfY29tbW9uX2NvbmZpZyhzdHJ1Y3QgcnM5X2RyaXZlcl9kYXRh
ICpyczkpDQo+ICAgCWludCByZXQ7DQo+ICAgDQo+ICAgCS8qIFNldCBkZWZhdWx0cyAqLw0KPiAt
CXJzOS0+cGxsX2FtcGxpdHVkZSA9IFJTOV9SRUdfU1NfQU1QXzBWNzsNCj4gLQlyczktPnBsbF9z
c2MgPSBSUzlfUkVHX1NTX1NTQ18xMDA7DQo+ICsJcnM5LT5wbGxfYW1wbGl0dWRlID0gUlM5X1JF
R19TU19BTVBfREVGQVVMVDsNCj4gKwlyczktPnBsbF9zc2MgPSBSUzlfUkVHX1NTX1NTQ19ERUZB
VUxUOw0KPiAgIA0KPiAgIAkvKiBPdXRwdXQgY2xvY2sgYW1wbGl0dWRlICovDQo+ICAgCXJldCA9
IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAicmVuZXNhcyxvdXQtYW1wbGl0dWRlLW1pY3Jvdm9s
dCIsDQo+IEBAIC0yNDcsMTMgKzI0OSwxMyBAQCBzdGF0aWMgdm9pZCByczlfdXBkYXRlX2NvbmZp
ZyhzdHJ1Y3QgcnM5X2RyaXZlcl9kYXRhICpyczkpDQo+ICAgCWludCBpOw0KPiAgIA0KPiAgIAkv
KiBJZiBhbXBsaXR1ZGUgaXMgbm9uLWRlZmF1bHQsIHVwZGF0ZSBpdC4gKi8NCj4gLQlpZiAocnM5
LT5wbGxfYW1wbGl0dWRlICE9IFJTOV9SRUdfU1NfQU1QXzBWNykgew0KPiArCWlmIChyczktPnBs
bF9hbXBsaXR1ZGUgIT0gUlM5X1JFR19TU19BTVBfREVGQVVMVCkgew0KPiAgIAkJcmVnbWFwX3Vw
ZGF0ZV9iaXRzKHJzOS0+cmVnbWFwLCBSUzlfUkVHX1NTLCBSUzlfUkVHX1NTX0FNUF9NQVNLLA0K
PiAgIAkJCQkgICByczktPnBsbF9hbXBsaXR1ZGUpOw0KPiAgIAl9DQo+ICAgDQo+ICAgCS8qIElm
IFNTQyBpcyBub24tZGVmYXVsdCwgdXBkYXRlIGl0LiAqLw0KPiAtCWlmIChyczktPnBsbF9zc2Mg
IT0gUlM5X1JFR19TU19TU0NfMTAwKSB7DQo+ICsJaWYgKHJzOS0+cGxsX3NzYyAhPSBSUzlfUkVH
X1NTX1NTQ19ERUZBVUxUKSB7DQo+ICAgCQlyZWdtYXBfdXBkYXRlX2JpdHMocnM5LT5yZWdtYXAs
IFJTOV9SRUdfU1MsIFJTOV9SRUdfU1NfU1NDX01BU0ssDQo+ICAgCQkJCSAgIHJzOS0+cGxsX3Nz
Yyk7DQo+ICAgCX0NCj4NCj4gYmFzZS1jb21taXQ6IDYxOTk2YzA3M2M5YjA3MDkyMmFkM2EzNmM5
ODFjYTZkZGJlYTE5YTUNCj4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwDQoNCg0K

