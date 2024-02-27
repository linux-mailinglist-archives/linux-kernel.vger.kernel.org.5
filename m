Return-Path: <linux-kernel+bounces-82836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF32868A66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7218284401
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43456467;
	Tue, 27 Feb 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="jgZbasDt"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F155E63;
	Tue, 27 Feb 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021010; cv=fail; b=ZGKqs1We5KunHx9ZUFxHjnIg4ZmXROTVjiVxJRtk+jis+Y8jlCckehQJVto+TpjkW4gqSYIhrnWCeMjNjldw5C/+6bjqYnjed2Y807nuAUsUY6vR7Ohm85kr0EKFH7apjvFlMUDkuf3rnahqXdZvklQIiB9bEjVoaZ46dyinJBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021010; c=relaxed/simple;
	bh=2aXjjui+/Y+WysoaCKVUZ3szcuP3PoTE9nx1C7B5m28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pDz5XW8BDe/sL74AYzRdAUhld+N3DbqfbwW/MME2LZTmFveQ6iGWFa1pYPeZQdV7YTo3M54Y1p74p1S2k/ueMzRIHTAbjRty9xC921PveC1N0sRGYOScwSXyFdp01vXCh4GwSlYemUylU0TWRFJBHQGMS42MeOpG0qALfh6z/t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=jgZbasDt; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuRyaYwa2pz6vDiu2TQEMB4xZEs3PM2e08QAiEcAMsoPQP2DxMQrGLhKMO/zftT/N4V8dBcJWo4/AWVPEjJKG7wbPSDMA2D1MwH4A9DV3q1eCIaIjKzZ/umyRJEoDflmqOz/rd1MHdwqOrzfmwonsbU886r82Sqk5AbJII8ZZ6IlOAoNQ1ybQMfQVjWJOZzIkDSYGnpshoFrF2BPToCNFVdbf63QlXYhVGLwDoimdWtn8M5U8grn3eY3EaXiV5EP9FAe0Kx1y5AfkcRJaicaS+NzcLDD/9PJqEY3Dmh9rEqhVTxO85Ciq426nk6rHndPpPIOGrLf3MZct6UxDkBjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aXjjui+/Y+WysoaCKVUZ3szcuP3PoTE9nx1C7B5m28=;
 b=a7hqutUXTXsA8gGsYpkFghG9kE7ZdMrqgluKR6aCpxegYd/jXvZZ+SHCeD4XVzrNj7njhwF/gbCw1uzeG8XLjGkYfV6oX/l37UfppAM4z+Nd2xZnQoxy4yguNzHXlj39NNj1MYRDKq85+j3GTRtTOD35Y1/CZUuDn0DXFe4a1r87P/LklAJrQag4xtAZ4Sb7OV/IQbNQAwYnIjfq87Fp3klkGiHHy9utE+R1UdW35euOVXJBgB/k8IgIg4LvTtVJA2WZWISqQeTjPTWwRiFg2eWNw8q/QZ1jGqWcpqaeLPxXE1dzUqiBqfmp/lDFxbsKfLz1C3if43AtrKS5jGqMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aXjjui+/Y+WysoaCKVUZ3szcuP3PoTE9nx1C7B5m28=;
 b=jgZbasDtksnG93XAY6NT2iEN9Cm6DilXzsqy1dmmsyxpzNnD5IP4gasP1WH/McBxHTnajU80asJIp2mgh7giK54/ZXoWaEXgI/CeM6I0RGnBq9gIgWAwL/TYmeWFHYh2O7UoYvBQy0gdkAYqxp6MGRVhwxOs9lyGPbzI69V8G1A=
Received: from DUZPR06MB9035.eurprd06.prod.outlook.com (2603:10a6:10:4de::18)
 by VI1PR06MB6621.eurprd06.prod.outlook.com (2603:10a6:800:18c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 08:03:25 +0000
Received: from DUZPR06MB9035.eurprd06.prod.outlook.com
 ([fe80::dae9:7adb:ec3f:e12b]) by DUZPR06MB9035.eurprd06.prod.outlook.com
 ([fe80::dae9:7adb:ec3f:e12b%5]) with mapi id 15.20.7339.009; Tue, 27 Feb 2024
 08:03:24 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Andrew Lunn <andrew@lunn.ch>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH net-next v2] net: phy: dp83826: disable WOL at init
Thread-Topic: [PATCH net-next v2] net: phy: dp83826: disable WOL at init
Thread-Index: AQHaaNAq607nuLsfukCb7rWI/pCBdLEc0quAgAAEXoCAAP42AA==
Date: Tue, 27 Feb 2024 08:03:24 +0000
Message-ID: <76dbf5d3-acab-416e-a621-aeba0af9e7f1@leica-geosystems.com>
References: <20240226162339.696461-1-catalin.popescu@leica-geosystems.com>
 <Zdy+Y8Mqs22yRrre@shell.armlinux.org.uk>
 <13a68356-235e-4945-8cf7-5b7a42b0bf46@lunn.ch>
In-Reply-To: <13a68356-235e-4945-8cf7-5b7a42b0bf46@lunn.ch>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DUZPR06MB9035:EE_|VI1PR06MB6621:EE_
x-ms-office365-filtering-correlation-id: ad106140-7cfb-4528-b45c-08dc376a92ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nwcA9HgBY1Va35BB+Xbte8g8I36vxVHjb/0e59qcgp0GgLd8wjGgs4417hdFEPXApaiCGMyCYltE55N6RaPUIzt9z81gCnl4qQDELUI2iPi3NCYlCNkR4OOZvHSGvVMvTHj9Kd/YMAc0jqfifXpc6qclfDXZ/9suS0Oem9zW7b1mJNqQl+sPOproFA0C5kyKHx54y7s++0hWjRCZzCxLZBEtsRhMmQmZIbd3hIIFVhaB2XAn367fEsA//aO95HRyiJD/gx+M/pZCgB8PDxYHFc0NPHK1bAS94iPWLfgxVCANEg8eSHxRe5oqoUvJshiAa2zKUzy7e6EoJu/GolUWB/CNDZN1uJBeX31oi7PN71S9ACt1scaJwFnO74BGyPudv2ylBftNGzDyIZL493G0TCRNO35kevMID4EH+FAA9V00vzH9OoQHUsNmXqogxR4GgGGnF/k5zPZgEtVXE8pmacb1QcA3R33NMFxQhzHIQvGQX1KavGU3DRil0MPGQbnV9WR3r8JEwkbh+VTuZpbk5ckxte2nRy7q55oVcBwiiW1d1IvGZUfWYITCrTQKrmf17KHh10A1Q3PbAZdURpdh6KKXtWW4Tjay06JvbKR9oZ5gsrURJBJAExsHRL1X/ywboAIUbQ/MNeWJ8sRc9WaVa/ImFPg3ffJDZjlxAHmgpge3Uwluj0Nu3SvPbP8OXyKpu33fDy5F0HDggITlqK2HowLrXxsytO3IpsoX1TFMpS8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DUZPR06MB9035.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bE5vSzhCVzlwSmtWUDhZQlJmN2RMRURUaHY5azVkRXZhb2ExSVFPbzl3bWMx?=
 =?utf-8?B?TVJ3aXl4ay9OT3RjYmlpcWUvanpjYWZHTlI3UjRpMkllRmtUTU5oeWl2WE5j?=
 =?utf-8?B?elVXYlIrbC9HQndsY1pJRmdoL2JLaGRRK3dsWlFQV2ljaHBtbkU0WlkzY1lC?=
 =?utf-8?B?Q0J0Q1M4V0ExOE00dmZwT3M0TE4xWmlscUs1Und5bkxVVXpYMjVKb0tQZlRV?=
 =?utf-8?B?QkV6aWFpZXl0MUR6NWtsTDV1RS9nVnRmTHdzZHpvaEZkZlZSOWVLTTE0MEJT?=
 =?utf-8?B?TGdJcEZZTzZqL1NkZmVlMHIyZzlqWUFZOTdYa08vdWRqY2NLS1crOCsvaGJt?=
 =?utf-8?B?ME1qN1hCYkVGbkh5VUIzSWt5YU5mWFpkcVRobjZCNUd6YlM5QVFhV0hMLzJl?=
 =?utf-8?B?bko1ZzZQUjNGUndocDF3ekpNQmVVY3NSckhpZ0Y2L0drTVg1YVMrdHFKVlIx?=
 =?utf-8?B?T1ducnlVVHRwaU1kVWpMejlkVkdFWU94WGlhSmt1MENFY2Q1ZE5nZnVoQkJj?=
 =?utf-8?B?SWRwNFpMRU84Q1VSY0crd042Y2R5RmQ2TnNuNVlLbzBNRysrOG4yTjlaZm0w?=
 =?utf-8?B?ZmRXYzQ1VndneFVLK1IrTDFHRU1Hazg5TTJBQWR2RFFkeUFkK3c5V0lCdW15?=
 =?utf-8?B?RE9ETWtZTDlxL3huSU90WGRNUThvdXRlUEdvY2RHeVljZktIT05lQnRUeUZQ?=
 =?utf-8?B?WEFXYWZuL1B4cWVCRVVQZEYrL0lNdHJqbUpqTDhIN3k2eGVWMVBQT2NaTmlh?=
 =?utf-8?B?ay9kVWdHNmFJZFg2T2Rpc0FvREx0YjlLanhSOVlnRWRzQXVkUkdRVXpYOHJw?=
 =?utf-8?B?ZDNlUDdsak5TM1FUdWlOcGhCK3o4SDBWbzY3cDRyZS92Q2FOQzdmN0t0eXpm?=
 =?utf-8?B?emVtMW5vdHFJMnp6VTJHUWN0MGNIWkZnRmx4eWhNdHVnaElNa3QzWHl4U0wx?=
 =?utf-8?B?czdMc1dlL1liUm9sMURJTHE2dnVNQXdRWlo3STRQbFJtSCt6MldlZHRkRVh3?=
 =?utf-8?B?Yll4TlA5VVppMlkrU1ZCQzB4NVI3S0swMWJCdUhsYzZFWDhRRDFRZkJub0Va?=
 =?utf-8?B?Y1MyV3N5c3BtVklBNzBrRHJyREdxdzRxbkVVY2d3MFJ1K1BOQ3lYS29rQTBr?=
 =?utf-8?B?U01nZ2x1UDZ5akZIc1lTNFRvVTVTV2VHN2RINTViQktZR1F4d2lPRzJlK1NS?=
 =?utf-8?B?UjZ1bFdzMWN3SUpnMUJ4Y0wrZENPdG1Ud2xMK0JSTUlSUUMvN3ljcEltOTVZ?=
 =?utf-8?B?Y2IzMEE5R2dzKzNuUndYYmJmbDdTYVFLNnliYkFaMGl0TzRPcGUwKzVSU0Ey?=
 =?utf-8?B?ckFXOWt0M25jZVM3UlZKaTc2VlhUd2ViQUpzS1c1dUlraEdrMXd1ZFZ2ZlN1?=
 =?utf-8?B?cjhoN0x5ZTBWLzcxdzduazczQkZGdmswdkU5QXAwWDdsQ0NnNHd3V1NUUUl4?=
 =?utf-8?B?REQ5c2ZPWGI5MFZVbzJpdjcrbHRvMURpeTR4cTkwWEVDMFlzT0xpV2d4UDI1?=
 =?utf-8?B?V2J3L1Q3M2hiUmxkZHNiZTVzMGJOVDZVenAzSW9JZ25RTTg5RTVDNlhPbHVV?=
 =?utf-8?B?ajNrTUVTOUp5SURHWUllVk10MjFUbCtFN0FpaThRS2podGdTSXJMM1RteW5Z?=
 =?utf-8?B?Y01jbnpET3NpZGJWbE0xTlRkY1ZzMW1UVU40U0hxQUFrTmdMZEhLK0hGc0dC?=
 =?utf-8?B?T2NGNERzdGZjb2RKRU9qa2JDOFEwV1NFNzNLWG5tMkpyL0tRZUdab0xyMnkr?=
 =?utf-8?B?UHFJK2VWZ3Y2dS9WZzlhNm9NdU1VSjV3S3gydnpJZ1pEUVZlVXpicUdFbmNk?=
 =?utf-8?B?OUNnZTRTNWNhQ3YzaTFJZ2JmVUtRUFVpM2JaTGxVSDNMVXcvUm8zem0wemhw?=
 =?utf-8?B?RElaR2JmSzBJVmxiTiswaHlrWGFUdklDcUEyMzAxbFdIMk01a2IvUytUQ3NW?=
 =?utf-8?B?aHVaRy9vdUZYSHVtYVpSZ3RybzdtQ2YvSDhRcU1zNWF6bGg4TGtGYmhWSkZv?=
 =?utf-8?B?eGRjK3RqZkNSWXRhZzN1MEdwdi9YWjJMQmhaYmE4VUFCTit1MkJmMmhMT09K?=
 =?utf-8?B?WTZ5c3g3MVZyZ2NDTS9IRzB6MlZqQi9kUVJFWjNaWEFIdFUzdFF0eUVNVnla?=
 =?utf-8?B?YlNpMUVLYmc2QVpuUExCclYvbjFFR0FkZUZneExuVUhqOWl5M3EzWGxJS240?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C27B9646BEC78540AEDDEFD498E81B5F@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DUZPR06MB9035.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad106140-7cfb-4528-b45c-08dc376a92ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 08:03:24.8211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGVoKNR36ZPCSuNgpjECd/s3A67aEOuDdfaiWrMq4qH8/VRqJ768dABk1zUIy+SCx91g/+uFmXtMFHuwFYm26nrGChH0HkVgyuYx1ZoI8NppzxlDyWncjibEb9bt+QZo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6621

T24gMjYuMDIuMjQgMTc6NTMsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBUaGlzIGVtYWlsIGlzIG5v
dCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFzZSBiZSBjYXJlZnVs
IHdoaWxlIGNsaWNraW5nIGxpbmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBseWluZyB0
byB0aGlzIGVtYWlsLg0KPg0KPg0KPiBPbiBNb24sIEZlYiAyNiwgMjAyNCBhdCAwNDozNzo1NVBN
ICswMDAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkgd3JvdGU6DQo+PiBPbiBNb24sIEZlYiAyNiwg
MjAyNCBhdCAwNToyMzozOVBNICswMTAwLCBDYXRhbGluIFBvcGVzY3Ugd3JvdGU6DQo+Pj4gQ29t
bWl0IGQxZDc3MTIwYmMyOCAoIm5ldDogcGh5OiBkcDgzODI2OiBzdXBwb3J0IFRYIGRhdGEgdm9s
dGFnZSB0dW5pbmciKQ0KPj4+IGludHJvZHVjZWQgYSByZWdyZXNzaW9uIGluIHRoYXQgV09MIGlz
IG5vdCBkaXNhYmxlZCBieSBkZWZhdWx0IGZvciBEUDgzODI2Lg0KPj4+IFdPTCBzaG91bGQgbm9y
bWFsbHkgYmUgZW5hYmxlZCB0aHJvdWdoIGV0aHRvb2wuDQo+Pj4NCj4+PiBGaXhlczogZDFkNzcx
MjBiYzI4ICgibmV0OiBwaHk6IGRwODM4MjY6IHN1cHBvcnQgVFggZGF0YSB2b2x0YWdlIHR1bmlu
ZyIpDQo+Pj4gU2lnbmVkLW9mZi1ieTogQ2F0YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBvcGVzY3VA
bGVpY2EtZ2Vvc3lzdGVtcy5jb20+DQo+PiBJdCBzZWVtcyByYXRoZXIgaW50ZXJlc3RpbmcgdGhh
dCBXb0wgaXMgZGlzYWJsZWQgaW4gdGhlIGNvbmZpZ19pbml0KCkNCj4+IG1ldGhvZCAtIGJlY2F1
c2UgdGhpcyB3aWxsIGJlIGNhbGxlZCB3aGVuIHRoZSBQSFkgaXMgYXR0YWNoZWQgdG8gaXRzDQo+
PiBuZXR3b3JrIGRyaXZlciAocmVhc29uYWJsZSBJIGd1ZXNzKSBidXQgYWxzbyBhdCByZXN1bWUg
dGltZSAtIHdoaWNoDQo+PiBtZWFucyBvbmUgY2FuJ3QganVzdCBzZXQgdGhlIFdvTCBtb2RlIG9u
Y2UgYW5kIHRoYXQgc3RhdHVzIHdpbGwgYmUNCj4+IHByZXNlcnZlZC4NCj4+DQo+PiBNYXliZSBB
bmRyZXcgY2FuIGNsYXJpZnksIGJ1dCBJIHRob3VnaHQgb25jZSBXb0wgd2FzIGNvbmZpZ3VyZWQs
IHRoYXQNCj4+IGNvbmZpZ3VyYXRpb24gc2hvdWxkIHJlbWFpbiB1bnRpbCB0aGUgc3lzdGVtIGlz
IHJlYm9vdGVkLg0KPiBZZXMsIGkgbm90aWNlZCB0aGlzIGFzIHdlbGwuDQo+DQo+IGQxZDc3MTIw
YmMyOCBkb2VzIGNoYW5nZSB0aGUgYmVoYXZpb3VyLCBjbGVhcmluZyBXb0wgd2FzIGRyb3BwZWQu
IEFzDQo+IHlvdSBzYXksIFdvTCB3YXMgcHJvYmFibHkgYnJva2VuIGJlZm9yZSBkMWQ3NzEyMGJj
MjggYW5kIGl0IHdpbGwgc3RpbGwNCj4gYmUgYnJva2VuIGFmdGVyIHRoaXMgcGF0Y2gsIHNvIG5v
IHJlYWwgY2hhbmdlIHRoZXJlIDotKQ0KPg0KPiBDYXRhbGluIGFzIGEgZm9sbG93dXAsIGNvdWxk
IHlvdSBwbGVhc2UgbG9vayBhdCBzdXNwZW5kL3Jlc3VtZSB2aWENCj4gV29MLiBBcyBSdXNzZWxs
IHBvaW50ZWQgb3V0LCBpZiB0aGUgbWFjaGluZSBpcyB3b2tlbiBmcm9tIHN1c3BlbmQsIHdlDQo+
IGV4cGVjdCB0aGUgV29MIHNldHRpbmdzIHRvIGJlIGtlcHQuIFNvIFdvTCBzaG91bGQgYmUgY2xl
YXJlZCBvbiBib290LA0KPiBidXQgbm90IHJlc3VtZS4NClN1cmUsIEkgd2lsbCBsb29rIGludG8g
aXQuIEkgYWdyZWUgdGhhdCBzdXNwZW5kIHNob3VsZCBub3QgY2hhbmdlIHRoZSANCmNvbmZpZ3Vy
YXRpb24uDQo+DQo+ICAgICAgQW5kcmV3DQoNCg0K

