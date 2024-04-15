Return-Path: <linux-kernel+bounces-145319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60C8A52A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D61C21FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EAF74429;
	Mon, 15 Apr 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="Vb+GPIUM"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02273500;
	Mon, 15 Apr 2024 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189898; cv=fail; b=fskbzc4AhdQryCdRRfpxzrN9Z93G8cbQf6K17qXOEXG8wDL2J7JVvV7sse5zelHzZtgXyunGuegzKQuWmi1UbJfvrLjD1JpIhK/fDSt8R5jWO1qY5S2TcuEVxeivTCqgH+3Lqd52iZw3PUayhG0IKMPMAZr3SAZB93NI/EYqEJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189898; c=relaxed/simple;
	bh=8XZbXuR/90CZAeLICoNSyXVo30R2i0WgZudW8Bq0+YU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=URupSTNS/vC3SsuKicagHBEnMAUji+Rwu56qemG+zBNvvZt6yz0bnLvNTHFe/u6k7WQ527bzwmJd1toZPLavIWOWaVFphZfYYQFcznd3GWDfsJj4HA+k+4cmIlLs2YZ7t7xzLe5OoQX+aiqiShfUesIH9epfa+RJ4GiSV1rH3Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=Vb+GPIUM; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4h87KOB7jF5bdvlTojJg1ZQa0HIXUBj5I0xKbtS1zpJBmTDjlTq0Sd2e+uCDhjlATVnVjMEyEiOrmIo4eUycd7rDtwNeV/sphn0NuJTGlI1lFcrGdGFlj7Di98rp088c7TQGbHI2QTWe/Tqkuw7fceaPJsEtytnHnz7DWT0weLGo2DgegpuigcjlVYgUGhrcg8qiTrMXw2GLr43AUay6seRxKCuUM5Vu6Kk/Nm0DQsciVLyq7pD8jLLD23KxUE+sD/x38VG1ciqFr5bVeyLZ2LI4ydiivCbq7lkMrguyAg/MnPapzqg93hbIoqxDRhnj1oi0k440e/JspO1fxKr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XZbXuR/90CZAeLICoNSyXVo30R2i0WgZudW8Bq0+YU=;
 b=K/IErerPPCXl5b1cWW/+SJKECcU9/MwSED3Vum0MCiuodZf1FBOSQO8XQdg56ygBUHh7+tmg4gtx8k5ZAfW3HGacvkGIZ4F9g581chT2gjhL0OmvgAyHng7xbNOP5ZkR8+p3OTWbEdX4MsUs89HhhOA/LBU0WDobZd761p3jqpMzqhUYUlAXEQJGrrciRD2AZ+w3QODTO+NLweD6moCB8gH6JFJYxovjaHXLcEPeL26bp2KiPFwYiWQnv9k11omBVkPUILw+umk0USA/T9xXQoCeCwBqp+rbWV3NW0vAMC9CkTThi296qdSRuY5zAYSacfveuOfSQSJ2n5xtiHNJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XZbXuR/90CZAeLICoNSyXVo30R2i0WgZudW8Bq0+YU=;
 b=Vb+GPIUMk3UoTBPJCUM+5d9zSg9rnFUsgpq4mowA8uYOIORBAnPRSswb7sYSpURE+QaV8SsI6/0LxxqyM8WpQhMXPlN4DZuNp+pSTldiKZTS/cALiND6GTmXo0HKXx+mBO7AseuJkj9VIbZ+3Ke+rqI3mbuJbKAaZ/IsmRK0N5Q=
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com (2603:10a6:800:1a4::13)
 by DU0PR06MB8525.eurprd06.prod.outlook.com (2603:10a6:10:355::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Mon, 15 Apr
 2024 14:04:49 +0000
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41]) by VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41%2]) with mapi id 15.20.7472.027; Mon, 15 Apr 2024
 14:04:49 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: "marex@denx.de" <marex@denx.de>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
	"marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH] clk: rs9: fix wrong default value for clock amplitude
Thread-Topic: [PATCH] clk: rs9: fix wrong default value for clock amplitude
Thread-Index: AQHajz2/CAcLUeXcq0+6b0QPKkpUFbFpXUUA
Date: Mon, 15 Apr 2024 14:04:49 +0000
Message-ID: <107565b8-3698-4f15-bd23-a406458229db@leica-geosystems.com>
References: <20240415140348.2887619-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20240415140348.2887619-1-catalin.popescu@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB6911:EE_|DU0PR06MB8525:EE_
x-ms-office365-filtering-correlation-id: ef435acb-c451-401b-92a3-08dc5d550373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XVA5B46phl3qmNXd11O9E7LSRng70YfOsgF1qYpXdBBjNOjQwpl9Yi71d3dAoKcQ96Rish8+wo2Vq/n67W/CWJ3m6yM51kvRcXTEjI1nOArEXz3quwzFgX0PVJlgylCeD3pufF1ymkpeYGZHRUKzFjwW2h5949mSSsa+aYV7SkQ+B6D7vbTLLe0+bMZzXtGTkjMsWQCYpOSBlmt81q23AkTo9hKh8FBdK5ZSJwVDj/ZleM9W87zlVw1zczClDrcOs99G5DL5+INmoExlSiJhF8CEPLsDRVuZ/+5jjgNVuV9XQfGjUXj5GSTW6eHyOods5dsEQoH58/bWat3FGZXi9m0Ge4taWhWgE3v/ck627EeGns7zdbeylxhXXSP9BrEUqRp6ZfF64AoMFiPK6gulMx4Mox5J+pIguh7cZ5SvA6rgXwe6hX+zFafAEAPbmJ8QSQgh0TCIUxO4Rc6/odu+uNlUJEI/4H6RlduGA50Vc63pNH6drudW91rH5yc4NAxxuIND9VB/DBigWNGfa29r2CLCuTc9oHBZeTImqStc6QUHGTZW25ejoaEsdk/VrseX0vT77Bob7EY7V/4j0+voYtPCBKaW2ah5cTcdKQMAPuYzy23BUwEHoQrGlzwFWHA1DT7K7up7uP0AsOzc2Fct7t99lL/rqWfnOrZJHqW0zm5H6fw3hL9iQTVlfzlmmY0TmdF0HJ7iXTWqSS5qShOOUupvIKLpNYzgiJ6b2/zjqSc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB6911.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEkwcWlQM3NsYUJjVTVMVGwrWDlvUWVCb0lQN2Q5NWM2Risvd2pMcWxTcDZU?=
 =?utf-8?B?Y29LaStmN1c1QlpzeE9TOWFUZFdRT3ZjWFVLQkZORWZYdWRaNGMzRkM4ZTRJ?=
 =?utf-8?B?dVIxY2Z2dWYvSU5IRzk2N1IrUmhsbE1CNFFuTWUzM0dEMnFPMVV3VGFzVCtZ?=
 =?utf-8?B?TW11RXZuQTdTazJvcVdudEFMSU9kNHJIWDFML2R2YU5UN3VMTnpGQnZWbGo2?=
 =?utf-8?B?TW1MaXR3V3NEbXJsbmduUzY2eHRqcU5PWkNLUzlnbVRFWlNTMTB0R0FMWFps?=
 =?utf-8?B?WXV1VC9vVTZoaGdhZllMcm1jVG9kQldkS2lrV1dvdHZvcFhycHRMQnJmNHd5?=
 =?utf-8?B?dzl1M3R1K25HRnZTNzZxN2hsNlhRTTB2NVZ6UXlrcDVZaUQ2YU40dHVqWkd3?=
 =?utf-8?B?WmJVVFVjZURxQ0VMb0JKeVVhWmhUeXpKckRYT3VScnhocVNxREVYYkVTbk9k?=
 =?utf-8?B?M2FzRWNzakdLWHN5b0JZOTFJVDcycTBOT3NHUnRBOFpYcktGcDJlRzVESnVY?=
 =?utf-8?B?U2QwY3hjKzU3aGpoaXZWdXVudkVnVTR3VWNRUDloOWVOYzhTWWp1VkpFeDN0?=
 =?utf-8?B?dHNxR016RjJPcmhOTHMyNTExVlByOGFwaEtYS2hZc1NLb1h5MUhaSHQ3UDlY?=
 =?utf-8?B?SGlkS0ZmS1o0eDh4U0k4b3FoT01kV09qdFBpcytIM3puUGV2N2JjaVN6SXFJ?=
 =?utf-8?B?eFNMeTNXRXdWSy9hSFRMMHcvOW0xdGxPaXFTems1bjR6ZXRWMWQ5a05uQ015?=
 =?utf-8?B?a0owVjNMN3IvNkw4OVdpTExtcEU4ZFBBajhpK2ppcUNDNUV3cUFqRlRIU3Jj?=
 =?utf-8?B?OG80RENFcjloaiswV2dTcEtRd1JXTTkvZ0VJNDlYakRyY0tzLzIrOS9sdm15?=
 =?utf-8?B?SHMreUlSNThQZ3BucWhOQzBNTTVqMml3aVhtUE9yRGpGSVdDMHByWTRaTlhl?=
 =?utf-8?B?V3g5bXMvTjN1NkVhV3YwSjNpbVRVTXZoSjFxM3Nlbk5YUXN0eU4wSVc1Mlpj?=
 =?utf-8?B?L3NCelNmVHVJczZZTzJPaEZ5TEdFdGpCRmRyUzJuYlhoVk9razdFNmlTaGpt?=
 =?utf-8?B?V29rWDExemJzSXVKYjk4bGk0ZGtBL00yTFNwUnhPeXBwQUZuaWFpaXFWY0w0?=
 =?utf-8?B?cXV6N2xWNFJYSEVYc0wrNGh6K3pmSG9qb05vMmNuR2VwTFh6NjJhUjBjWkNu?=
 =?utf-8?B?ejExb3FTWWdVWXFiYVhGbmFDMGhzSlphUC9LU0FaRjFmQ1FVZFdhV2xxRzN1?=
 =?utf-8?B?b2FnYXdtaGh0S3YyVS9CVC9VMzhnejhCL1hEeWdVdzYwV043S0pjaHFtZm9v?=
 =?utf-8?B?U0M2WFIzR1hpcTFOVHoxKzczejBaMm5OcEsrTE1zWHBVVUNrcklrcTQrVVNH?=
 =?utf-8?B?Qk9sdWd1MmRnMVAxUDlCN1FnUUtuSnVLWG1qS0UrNGRQTURsenJZbzhndHVy?=
 =?utf-8?B?dUUvQWtzUlVXRVVaTDEycUFpK2RQTHAyUUZOYU5sdWlHNm1KbzRIUkM2R1lV?=
 =?utf-8?B?NUNFb241L25tYmx2Ly8zM3VPQWwvV0F4SnkyeUdXQmxBcGptaEJ3NTlJcy9o?=
 =?utf-8?B?WjdHMmozSFNncUhKWWU5dDk3bFp2VGNXMm5qdG9tSnBjM3ArUVAyVFU5Wnps?=
 =?utf-8?B?cDlaR3lPRmxCVEFSaDcvZ052SGwwOHlEd2VRT3cvZUIrbExEUHo4RkhHVzln?=
 =?utf-8?B?TnF0MFpTQTlsN2U1ak5zZmhOdXE2QlgvdVhxTWIweUNFWkhzOTBxenpjRVdH?=
 =?utf-8?B?Z3FTblZBNnNadFU5d05hTTBiL3l0ZTdLeWh5SWhPcGhEcUpFRHFCamw0L0NL?=
 =?utf-8?B?em9KdEVjMFkvbjRUQ3BPWkRmK0pJT2lRWTJZWU12a3J2bUpQS3A2aThsMzZL?=
 =?utf-8?B?RGxnak5aNE1MNjJnZytqMnNadElmenVzWmNwM2pXV2FDbjJhQ1RZMlp5WTUx?=
 =?utf-8?B?MTh2UEtHY21xQlRKSUFNNEtMT3lWWWJvRU5ZOXBScUFITGhwUEtOdTdZMlJJ?=
 =?utf-8?B?cCsyOGZpRGRmdWNVa2x2ODVlWXNmLzQwdXc3ME42ZkJSSThFV0xOaGtGRmty?=
 =?utf-8?B?bXRDSVp5dDEwSE9GbFhhd3EybUcrL2xDM2tTdVZjRnp1dGRiZm1NZW00T29s?=
 =?utf-8?B?Nml4cmZOaGlRUU5uWHZoRzEvOXFlb0VkWkt4b25mdFMzQ1R0aWlWMUk1eGI5?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18E01B3E0D205B468B31C808E63255D8@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef435acb-c451-401b-92a3-08dc5d550373
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 14:04:49.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrPrWvxDFYrsgNPpu9V3+NT+zc/MRn6xgExyDQy056PiNzbb6+au/RQfRGGW1zgjk4iSJP79/SDba4QG1gkw2eL+vOyTSZIVyM+b4chG9x5Ql44lph+Kjpv/cFn2PKen
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR06MB8525

Z2l0IHNlbmQtZW1haWwgLXYzIGRpZG4ndCB3b3JrIC4uLg0KDQpPbiAxNS8wNC8yMDI0IDE2OjAz
LCBDYXRhbGluIFBvcGVzY3Ugd3JvdGU6DQo+IEFjY29yZGluZyB0byA5RkdWMDI0MSwgOUZHVjA0
NDEgJiA5RkdWMDg0MSBkYXRhc2hlZXRzLCB0aGUgZGVmYXVsdA0KPiB2YWx1ZSBmb3IgdGhlIGNs
b2NrIGFtcGxpdHVkZSBpcyAwLjhWLCB3aGlsZSB0aGUgZHJpdmVyIGFzc3VtZXMgMC43Vi4NCj4N
Cj4gQWRkaXRpb25hbGx5LCBkZWZpbmUgY29uc3RhbnRzIGZvciBkZWZhdWx0IHZhbHVlcyBmb3Ig
Ym90aCBjbG9jaw0KPiBhbXBsaXR1ZGUgYW5kIHNwcmVhZCBzcGVjdHJ1bSBhbmQgdXNlIHRoZW0u
DQo+DQo+IEZpeGVzOiA4OTJlMGRkZWExYWEgKCJjbGs6IHJzOTogQWRkIFJlbmVzYXMgOS1zZXJp
ZXMgUENJZSBjbG9jayBnZW5lcmF0b3IgZHJpdmVyIikNCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2F0
YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vvc3lzdGVtcy5jb20+DQo+IFJl
dmlld2VkLWJ5OiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gLS0tDQo+IENoYW5nZXMg
aW4gdjM6DQo+ICAgLSBhZGQgcmV2aWV3ZWQtYnkgdGFnDQo+DQo+IENoYW5nZXMgaW4gdjI6DQo+
ICAgLSB1cGRhdGUgY29tbWl0IG1lc3NhZ2Ugd2l0aCAiOUZHVjA4NDEiLCBkb2N1bWVudCBjaGFu
Z2UgYWJvdXQgc3ByZWFkDQo+ICAgICBzcGVjdHJ1bSBhbmQgYWRkIEZpeGVzIHRhZy4NCj4gLS0t
DQo+ICAgZHJpdmVycy9jbGsvY2xrLXJlbmVzYXMtcGNpZS5jIHwgMTAgKysrKysrLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGstcmVuZXNhcy1wY2llLmMgYi9kcml2ZXJzL2Nsay9j
bGstcmVuZXNhcy1wY2llLmMNCj4gaW5kZXggNTNlMjFhYzMwMmU2Li40YzNhNWU0ZWI3N2EgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1yZW5lc2FzLXBjaWUuYw0KPiArKysgYi9kcml2
ZXJzL2Nsay9jbGstcmVuZXNhcy1wY2llLmMNCj4gQEAgLTI1LDEwICsyNSwxMiBAQA0KPiAgICNk
ZWZpbmUgUlM5X1JFR19TU19BTVBfMFY3CQkJMHgxDQo+ICAgI2RlZmluZSBSUzlfUkVHX1NTX0FN
UF8wVjgJCQkweDINCj4gICAjZGVmaW5lIFJTOV9SRUdfU1NfQU1QXzBWOQkJCTB4Mw0KPiArI2Rl
ZmluZSBSUzlfUkVHX1NTX0FNUF9ERUZBVUxUCQkJUlM5X1JFR19TU19BTVBfMFY4DQo+ICAgI2Rl
ZmluZSBSUzlfUkVHX1NTX0FNUF9NQVNLCQkJMHgzDQo+ICAgI2RlZmluZSBSUzlfUkVHX1NTX1NT
Q18xMDAJCQkwDQo+ICAgI2RlZmluZSBSUzlfUkVHX1NTX1NTQ19NMDI1CQkJKDEgPDwgMykNCj4g
ICAjZGVmaW5lIFJTOV9SRUdfU1NfU1NDX00wNTAJCQkoMyA8PCAzKQ0KPiArI2RlZmluZSBSUzlf
UkVHX1NTX1NTQ19ERUZBVUxUCQkJUlM5X1JFR19TU19TU0NfMTAwDQo+ICAgI2RlZmluZSBSUzlf
UkVHX1NTX1NTQ19NQVNLCQkJKDMgPDwgMykNCj4gICAjZGVmaW5lIFJTOV9SRUdfU1NfU1NDX0xP
Q0sJCQlCSVQoNSkNCj4gICAjZGVmaW5lIFJTOV9SRUdfU1IJCQkJMHgyDQo+IEBAIC0yMDUsOCAr
MjA3LDggQEAgc3RhdGljIGludCByczlfZ2V0X2NvbW1vbl9jb25maWcoc3RydWN0IHJzOV9kcml2
ZXJfZGF0YSAqcnM5KQ0KPiAgIAlpbnQgcmV0Ow0KPiAgIA0KPiAgIAkvKiBTZXQgZGVmYXVsdHMg
Ki8NCj4gLQlyczktPnBsbF9hbXBsaXR1ZGUgPSBSUzlfUkVHX1NTX0FNUF8wVjc7DQo+IC0JcnM5
LT5wbGxfc3NjID0gUlM5X1JFR19TU19TU0NfMTAwOw0KPiArCXJzOS0+cGxsX2FtcGxpdHVkZSA9
IFJTOV9SRUdfU1NfQU1QX0RFRkFVTFQ7DQo+ICsJcnM5LT5wbGxfc3NjID0gUlM5X1JFR19TU19T
U0NfREVGQVVMVDsNCj4gICANCj4gICAJLyogT3V0cHV0IGNsb2NrIGFtcGxpdHVkZSAqLw0KPiAg
IAlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgInJlbmVzYXMsb3V0LWFtcGxpdHVkZS1t
aWNyb3ZvbHQiLA0KPiBAQCAtMjQ3LDEzICsyNDksMTMgQEAgc3RhdGljIHZvaWQgcnM5X3VwZGF0
ZV9jb25maWcoc3RydWN0IHJzOV9kcml2ZXJfZGF0YSAqcnM5KQ0KPiAgIAlpbnQgaTsNCj4gICAN
Cj4gICAJLyogSWYgYW1wbGl0dWRlIGlzIG5vbi1kZWZhdWx0LCB1cGRhdGUgaXQuICovDQo+IC0J
aWYgKHJzOS0+cGxsX2FtcGxpdHVkZSAhPSBSUzlfUkVHX1NTX0FNUF8wVjcpIHsNCj4gKwlpZiAo
cnM5LT5wbGxfYW1wbGl0dWRlICE9IFJTOV9SRUdfU1NfQU1QX0RFRkFVTFQpIHsNCj4gICAJCXJl
Z21hcF91cGRhdGVfYml0cyhyczktPnJlZ21hcCwgUlM5X1JFR19TUywgUlM5X1JFR19TU19BTVBf
TUFTSywNCj4gICAJCQkJICAgcnM5LT5wbGxfYW1wbGl0dWRlKTsNCj4gICAJfQ0KPiAgIA0KPiAg
IAkvKiBJZiBTU0MgaXMgbm9uLWRlZmF1bHQsIHVwZGF0ZSBpdC4gKi8NCj4gLQlpZiAocnM5LT5w
bGxfc3NjICE9IFJTOV9SRUdfU1NfU1NDXzEwMCkgew0KPiArCWlmIChyczktPnBsbF9zc2MgIT0g
UlM5X1JFR19TU19TU0NfREVGQVVMVCkgew0KPiAgIAkJcmVnbWFwX3VwZGF0ZV9iaXRzKHJzOS0+
cmVnbWFwLCBSUzlfUkVHX1NTLCBSUzlfUkVHX1NTX1NTQ19NQVNLLA0KPiAgIAkJCQkgICByczkt
PnBsbF9zc2MpOw0KPiAgIAl9DQo+DQo+IGJhc2UtY29tbWl0OiA2YmQzNDM1Mzc0NjFiNTdmM2Vm
ZTVkZmM1ZmMxOTNhMjMyZGZlZjFlDQo+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMA0KDQoNCg==

