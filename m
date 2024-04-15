Return-Path: <linux-kernel+bounces-145078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0538A4F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4057B209A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7176F517;
	Mon, 15 Apr 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="fb6CibH+"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C45CDD9;
	Mon, 15 Apr 2024 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184800; cv=fail; b=S91KzI2CgAylxpTyjeTNLOJnSk0aYKA9KJwZQ/SwzXz381NfTjCgKN56ULpTe/U0WCjNGSu5RUH211/CQTFzWuJzimyjxFP30KJlJbNHbvmif2kiPc8RvpkzLHKeu9t9Fcy9oE9osA4t78nBzuOr8CFsL/NssrmUoogYGAw6SGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184800; c=relaxed/simple;
	bh=g3+ME7iqLTOc6n87xMZVPtOOipOBYTvVWmkEwwXcTIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n30xOXaHkzkiGN1QDfpseTeOr+t206jf7f9U1UeiUhWzvuYRu0CYsP8QGNeMpZV16aD2Lb0Tque8zAiiB9FJUNCSi0QKdUx/8QDc+qPqgKMbfCnGDY9PSL1eFgK0+YrfIrI4aXdfedr+4nywmP2TUDmuBWnwJQAfceO0KPo0fDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=fb6CibH+; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km8uJFedgkbEtPcmegw7eZvUCkDs206ejkwGbKU0Na25dLbg2CbM5ctjvz44FlnQeGfXU0mf044qlIl70znhz3x3U4pSYmY+vV67sJP9RyF4Dez9RGCo6VOKuZJA5pnkDEzVb+7HZaW5WF3B16LwNPCMfZYYf+6ZMVatKN3XoKETGLe7U5Wu/4Mz3qE8zwq+c7GnsbR79He0agGJJlNdDbgAr3ke/0QKqjjrbdX8Wo2mXoyu9+8Dwr3HGFPEUJcJj0tBw6RmygHcJ972QCNrhAEw40wUYSQpeWXXiXrJH1aYkdwsJvuLPGuEI3H03Mf4xIyzgqPh0y3q8WpoJ7VLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3+ME7iqLTOc6n87xMZVPtOOipOBYTvVWmkEwwXcTIA=;
 b=LeVoSHrLl17vlilKN2mctmy2evaKmHEmexfUG0FDUEd/tUH+xwWlxGOyJl2r7H6HTO+ZeIFOWetMM7C/LOQ2HxhC4TTHvEN8z4uO+l1B+kH5hq9YinRWAzzfXqZ9zt8uZFz4NlgYrL2E/RyHczIEcsPxa/62n2w1XWnLsyxG+70U05Yjumy+7Rwz8hZm2xgsgWHzq3g6/WtlVNFaUuZAOnG8XKqeRuoambWQiyJxP18y3+z5jr/0LZhM1SAfsfvjUkOcsME04cCyaQDll767HARYn3qqdRrtq/6qjlOfZDIfBY9ZSCehZPI2Chv/RR1rHrVMkcXPp1C79wz+mRqNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3+ME7iqLTOc6n87xMZVPtOOipOBYTvVWmkEwwXcTIA=;
 b=fb6CibH+IuJWyOwydLKF7CQbZkU9o3PZJ+ez5UuSiC9s85mJOzcek55tRJbInETlE9811zBDAZtcT8j+d0Qkz4jo2ccF3WyUTzMOXGFmxbEkSVZ8JlMIUJNGvozW2+8P3iZzWFj/HGIitdn3HA+4UUQO55KkSRCAFrZoo2sIZEg=
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com (2603:10a6:800:1a4::13)
 by DB9PR06MB8536.eurprd06.prod.outlook.com (2603:10a6:10:36b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 12:39:54 +0000
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41]) by VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41%2]) with mapi id 15.20.7472.027; Mon, 15 Apr 2024
 12:39:54 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Marek Vasut <marex@denx.de>, Stephen Boyd <sboyd@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, Biju Das
	<biju.das.jz@bp.renesas.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH next] clk: rs9: fix wrong default value for clock
 amplitude
Thread-Topic: [PATCH next] clk: rs9: fix wrong default value for clock
 amplitude
Thread-Index: AQHab/DCG/iHt9Eo40epYh1g6iaq+rFfzXkAgAVi8ICABFO8gA==
Date: Mon, 15 Apr 2024 12:39:54 +0000
Message-ID: <af1116d6-e615-410e-a2e1-344c3ae6c029@leica-geosystems.com>
References: <20240306180435.1033052-1-catalin.popescu@leica-geosystems.com>
 <a5595ba92a3d65a222398824b09d7d37.sboyd@kernel.org>
 <d55fce26-a96e-4653-a463-a277e232ed48@denx.de>
In-Reply-To: <d55fce26-a96e-4653-a463-a277e232ed48@denx.de>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB6911:EE_|DB9PR06MB8536:EE_
x-ms-office365-filtering-correlation-id: b7fae419-35b5-4be8-6219-08dc5d4926b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A0Ia7ofst0GJusgmBTc1f6Z5mM8b87n/RdT8xyRmrWuhK5RjPY1b/LyWUYBS8bsVkByq05Fn1U0OVLOzYd3iCWLmrH0gO+Ojo5SvqrDjmKEOlVaUUOYh8DAI9h4DiatPRrpP3a9Fa1VTilmy76MSwrdoCY2EPCed60NKcGSId+APNa/ZTyp6XN4CJyhAB4V25qcSO9xI4Di1IMv9N247Uyvk+f3setefIW6C14I0MSEqo0OlV42xRGiFAaVlbTOc8hqjFDy8espvj4BmQiUGk/7FjwzX1uAr18WL1Y4cHDCRfDd2DSXkPnZqsU55L+Z/gZnLhqi24uSfA1/a3BxsIoVzWsXyf8gAr54y08HtqjL089iBhgvLoROjWnS6ToOLsdfGQQ5R+Ji0rhklszJKfOhZhUGy98d35KYftQ+vdb9D8bsugh3e2ccntwk+0tplqS1qXtHn2aDlc3DFdlZN4mRGJm+dc3L3yCfBROsSahZSvF4q/JrgHdgrNYIieRtP/UZwPgsRQg7dY1/kAmtYfowS0jnlmIDWG5m2YGBkEUM70c/0MY3zoZpm7hKWSH05sqFNsc2JJjMbXh4VLp0ncT+1mkM22Uxm9zGYYgC9w1EQceBimIXvETy6AGGMNkhMAnFeuNqPQW1DuWPDVEKy3ifCjlTX2TQsJs2gkV3P07DhVMUTB8LUMrX+gdwL12LukqTWuKAbghSBzcRNUUp61I5sPjNyV1BBsiiLLEP4XZo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB6911.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHpxaEVtczFqcWRvcW9ZM3JxUVYyQ1N1MXQycDZ4aTk3bDROdmFiN2V5UmI2?=
 =?utf-8?B?YmJoQ1dVM1drdHZudXFIRS85aG05L25GNmUxZWdxOEdtWGZHSzVhdGdDdzBG?=
 =?utf-8?B?WkNjTmV1TUhsUjNESHllVUYvaWtiVnZTTWJWQWNOSUd6aEQyaG0yZTJLWHlq?=
 =?utf-8?B?RDIvUUNicnBCZW1INjdBalVCcE9MeWY0d1UzUVRBSis2UVVGY1g2QUxVMStL?=
 =?utf-8?B?TE9wdnVZTUxzcE9tME40MzV3b2QyZWs4aU1ESGQvNURVRlhaUWRKWnhKVkdT?=
 =?utf-8?B?UTdqZ1JUeVkrQnhqTVVtM2RoOVJoZ1pXVUVkYzgzV05BMzFlbWtINmF6dFlP?=
 =?utf-8?B?Tmw1VUtkTXkwUXA3NjN3VGl1SHoxaU14UWdna3JkQnQ4WVNqM1Z6T3hxQmtv?=
 =?utf-8?B?V1loUWZSUVB5TVdOeDdRa1lrVVAyVFhvQnAzaXJhNGlSa3pxVXdlZk8wenk0?=
 =?utf-8?B?RUhhd1J6ZFdEMHNYNWtSSXArbHFlcXFBVVRGSkQrYVI4a1p1LzNLZExySWla?=
 =?utf-8?B?WTM0MmFXR2VqUUEyVm1Nc3NOU3h4bDl2YVlESXBiSTVKYlIyNWk0VHRpZSts?=
 =?utf-8?B?TytWdU9GbDlCamZFckk0dzhzUmVTeU9mNFMyTHpNRVdLTFVjcndvYldDM29V?=
 =?utf-8?B?ZW95cjJOWGtlWDNURXVJNE9DR1Q1UU13Mzh4WVNSUmNFTFJWcE4wT0x6Ulp6?=
 =?utf-8?B?aWk4QytjdjZIeThJT2wzdDhybktTSjJ5UzdXd3MvT2s3N0lGck9mYk5QcVpW?=
 =?utf-8?B?WkgrbWI3ampTZjBiMG1OWFNQSDUvcUhCY21ucVJ6WGp4TkNsMG1DWlVIUC85?=
 =?utf-8?B?RUQzNUpJdXJvd2hsampKRncrdnhBR1ZBVnVaNlZ2b3F0Yk5kdmdkQ0g5aEw4?=
 =?utf-8?B?MXpIWW5IcThkeERJNXV2RkZLRmlqdW1ES1VTU0RDeEkyWFJqSUs0citmZVJn?=
 =?utf-8?B?bzhEWlVhL1lobjZEQ3lHbVlmb3haUEpPVUlZVWJPbVRqVmg0Wit1cks0TjN2?=
 =?utf-8?B?MEIvM3JUek5GL3czekFMZElYcmZ0Z2o1YUd2WmU1bUs2eDNIQUhFZ0diQXlG?=
 =?utf-8?B?N3dOSWdZRE8wVy9kc3g4RGlvczB4N3RTY3Q0NFgzdjVhdnJ4SjA2Vkk0OSs5?=
 =?utf-8?B?ODRFcDdjWTJDdmR0VHlSOTZiY2VlVUovSDBEQldkRDIxMEJ1MmFacVc1ajMw?=
 =?utf-8?B?STlBcXRJRGlaKzZnMWlSbE5tM2ZvTExYdFBJeUZ6K0NLbENpTWxwQzErK3Fl?=
 =?utf-8?B?anJaYnk0bW45Smt6blZDNm1iUC9tamNUM1B0dTA3TzhCQ1VZK3hneGhYK0Uw?=
 =?utf-8?B?YXRLSys3OUFSdVV1aXdqYkQrVkVubHZLL1lWUnRWb0h0azRaVmEwWSszcnZ5?=
 =?utf-8?B?RXBLOUZsNXc1aDRjRkJIQXRVSG9vSkVVVVIydHZxRCsyMXZOZzRqaVZtd1d6?=
 =?utf-8?B?WU5IYU1UV3N1NmkvZWZkUXlyMXFmTDZMVWdva0s0ZmUyamtUYzM1aVNlREUr?=
 =?utf-8?B?eXNBbzV6TVYyRXB1amZEZjk5VE1GeHdTQ093SlorWmNwS09DYVZUUk1nZzhh?=
 =?utf-8?B?ek0vcWxxWS83SmJ4MkFRN1VMTUIzblZrbk5IQ1NxMVVRTEMzbXZHOWNWT2Zw?=
 =?utf-8?B?MkN4cW9rYTFRR2NiR052MGw4Qkt1UTk1NXdvdGF2Ny9OZ3N0Qm9aREt5amIw?=
 =?utf-8?B?bzJObVI5S2J0bmhheWZWaFN5aHhDeWhTRC9ES0NIczBhTHlPWWxmUUNMZW9T?=
 =?utf-8?B?M2g3N29TMHYwc2djdEk5N0JZeUxsR3d6Q1VOTnB1TlVhaWJmcmFOMVNvYUQw?=
 =?utf-8?B?MFVvV0lUVmdUV2lwbTBIaUhIQU5wS2M1MVppQTVFT1NXNUFGbzY1TXRvaVdY?=
 =?utf-8?B?eHNkZ2pIam1adm1JdUh0aUxSRnljNGsrWTB4L0RhR0o2MS9TYWpxQVJEQkZU?=
 =?utf-8?B?NWRKcURnck9zQkYwbXFHcXJtb3ZWVkthSmt6Z2pzTFcrTGVaYmwwY21IQitQ?=
 =?utf-8?B?RDJ5QWorNkV6WGE5eE1XdUgwU1lXeUJNUkUrbHlKNzUySTA2WTdtZmM1aVRv?=
 =?utf-8?B?WGt0bUpTSWIya0pUVk0xUEk0ZjBxaS94dGlYS0xXYjZ1RDBGZTkvWm1jSkZH?=
 =?utf-8?B?amt2VjNRNUZrQmRjMGY3dCtYOUFDUGZhSUF6RGp1NjR4UDZiZHIyU3pDaEFV?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ED1DE2D162CF14B9DE4C5651845A7F7@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fae419-35b5-4be8-6219-08dc5d4926b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 12:39:54.2575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUf4jW/jqZxLpAhusI+wZ/vqxJ1bcpEMvDgyCHqBg4wGPZwv42O0PBiBFqeUizx3JGZzdrD5UzRToyLYAQJXkCs1pSceJ0I5O9DLkz8vX/wDpNk9Atx/JTUMl1gW/C7J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8536

T24gMTIvMDQvMjAyNCAyMDozNSwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+IFRoaXMgZW1haWwgaXMg
bm90IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIA0KPiBj
YXJlZnVsIHdoaWxlIGNsaWNraW5nIGxpbmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBs
eWluZyB0byB0aGlzIA0KPiBlbWFpbC4NCj4NCj4NCj4gT24gNC85LzI0IDEwOjE5IEFNLCBTdGVw
aGVuIEJveWQgd3JvdGU6DQo+PiBRdW90aW5nIENhdGFsaW4gUG9wZXNjdSAoMjAyNC0wMy0wNiAx
MDowNDozNSkNCj4+PiBBY2NvcmRpbmcgdG8gOUZHVjAyNDEgJiA5RkdWMDQ0MSBkYXRhc2hlZXRz
DQo+DQo+IDlGR1YwODQxIHRvby4NCj4NCj4+ICwgdGhlIGRlZmF1bHQgdmFsdWUNCj4+PiBmb3Ig
dGhlIGNsb2NrIGFtcGxpdHVkZSBpcyAwLjhWLCB3aGlsZSB0aGUgZHJpdmVyIHdhcyBhc3N1bWlu
Zw0KPj4+IDAuN1YuDQo+DQo+IENhbiB5b3UgYWxzbyBkb2N1bWVudCB0aGUgU0NDIHNwcmVhZCBz
cGVjdHJ1bSBjaGFuZ2UgaW4gdGhlIGNvbW1pdCANCj4gbWVzc2FnZSA/DQo+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogQ2F0YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vvc3lzdGVt
cy5jb20+DQo+DQo+IFRoaXMgYWxzbyBuZWVkcw0KPiBGaXhlczogODkyZTBkZGVhMWFhICgiY2xr
OiByczk6IEFkZCBSZW5lc2FzIDktc2VyaWVzIFBDSWUgY2xvY2sNCj4gZ2VuZXJhdG9yIGRyaXZl
ciIpDQo+DQo+IFRoYW5rcyAhIFNvcnJ5IGZvciB0aGUgZGVsYXllZCByZXBseS4NCk5vIHByb2Js
ZW0sIHRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KDQo=

