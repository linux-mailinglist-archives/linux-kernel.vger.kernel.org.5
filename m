Return-Path: <linux-kernel+bounces-111102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FA88867EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE2A282612
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618DB168A4;
	Fri, 22 Mar 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="SGtpKYOQ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FC101C1;
	Fri, 22 Mar 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094866; cv=fail; b=sldM38upt2Qg1XC2Sk0TBahaE15uAoPkcIsPF86GBMDiGrIAzgeWZycd+ynHDZQvJnfdLUgPDvWElT5+3XziSF+5Da1cOzT5ViDBaRzArkoF4eK2LWA5Ug7cDXznXPYeEew+/AeCX60lrGRHhT4cpCOhh7/0RPl4DuVRVFd7NlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094866; c=relaxed/simple;
	bh=1W3IeR4vpCQE79wK/+NeGQJaUi6l8sxunyIhglHqsW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YBsqwZxTAwDcC9vEdlWngXweQyZF8vPzZtwH20R/ARv1wzFWhiIVzSGa0Urjo3gx0QtyoCpn1d3BpSdqKeTWzA3uMqlz0l1k25mKRYK4EKxBYnhzgHG3yISxae2viAVzZ0Cb90B1i2Iy8UF5+EmieBSzizDIC6ITURFZBR4RI8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=SGtpKYOQ; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALVpBLK0eVibgMde4pdAJqE8GN+sR4192yzrPHQvRR4TvvJbAu2mrSi7DfbrTwL6HD4gCWmtlOe8Lnat5JVGyadTFYMveFR/4Tlf7FJiV4KY5VFSWbKe3oTWPGrEZ9zXe22hVNZrT2WpvtCNESDnwjlf2L2+PY1d0BGKG3wXgL/RWK8Ed2DlBJ24pREDa9KEbaewUbHw8/6j0cOu3MXl63G0fB0ghFPy6KAerf8zSTNCu+1NL82w3POyCU5zSnNYfsc44jhakZtVnsK9yXacUBcfuyrE3pCL01YF7xEMoSKA6VHADMOMqfl8zz+nDOQSQtK2itfbFpPtH+AHSPD//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W3IeR4vpCQE79wK/+NeGQJaUi6l8sxunyIhglHqsW0=;
 b=ZR5dOkNBMDQNkvcAxmL567fUaxMRrNBo2panqqMZZaCjOoCSqfA+Ti6xOkw1cQ1TKM0NRux32NvdyGL0IkrYSOd8+uGHULML1Eo24NSnsgGK+7GYNdh8J9ij2Ww8f0FZpAFSi7VhxLSIBPZWsuOSB/UwJ5RJozsqaPGaqz1EDno5LcuibJtF4y64t7pd39loihM8o0kG7gAZihEtaLm7LQlSr0ThxqhQkfuMEfa0Oy9HtKTGbwBG9ORANwzlu4rUJmnPmoSctym/JmAvJbhzkF0eKLw58qf6onSwe860r2/XzYchVsfNNVQC/yU7xmsIPV+ej5XCBM4bFzkCndIAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W3IeR4vpCQE79wK/+NeGQJaUi6l8sxunyIhglHqsW0=;
 b=SGtpKYOQmEKxyT3PwlAqznjytgL1gcC4c4vZVnV+qrg2+IpcWdFE5btRD3MrK0KaLwoAKzVco/HUXezQ6nnOpnZMFOa+GDZWDueaYX0vP625rlB3pG8Z81DxHe7mrPw+IHlE8JRyqk/MhM92q398MN/1R2CDjqz+uP+m1eawXv8=
Received: from PR3PR06MB6908.eurprd06.prod.outlook.com (2603:10a6:102:8b::13)
 by AM0PR06MB6450.eurprd06.prod.outlook.com (2603:10a6:208:198::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 08:07:41 +0000
Received: from PR3PR06MB6908.eurprd06.prod.outlook.com
 ([fe80::4f16:579f:7380:5341]) by PR3PR06MB6908.eurprd06.prod.outlook.com
 ([fe80::4f16:579f:7380:5341%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 08:07:41 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH net-next] net: phy: dp8382x: keep WOL setting across
 suspends
Thread-Topic: [PATCH net-next] net: phy: dp8382x: keep WOL setting across
 suspends
Thread-Index: AQHab+nNNjxI3+NV+Uir0lLTLIYJU7ErVY4AgACd/ICAAh4MgIAVbpyA
Date: Fri, 22 Mar 2024 08:07:41 +0000
Message-ID: <e9b85f71-f494-4fa6-acce-13ee8e147c21@leica-geosystems.com>
References: <20240306171446.859750-1-catalin.popescu@leica-geosystems.com>
 <8de1d4e3-6d80-45a5-a638-48451d9b5c15@lunn.ch>
 <b53818a7-66a4-4c7a-b687-efaea6cb9e4e@leica-geosystems.com>
 <f8bfbe80-f308-4b8d-b8f0-5a5f6ca5fa0e@leica-geosystems.com>
In-Reply-To: <f8bfbe80-f308-4b8d-b8f0-5a5f6ca5fa0e@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR06MB6908:EE_|AM0PR06MB6450:EE_
x-ms-office365-filtering-correlation-id: 3ed7eec3-d6d1-424e-5f85-08dc4a472586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7Q/MN342MwiMZrv/j6nNeq8vmdYldJAWxkLtN8tv2RVUXvhsQaFAsdcqNemiMzzqibXkIE8kQXSr1OlvbI++aqjx4Shu5VMKOrUys3uHC1XnArMO7+w5ui4uCYngZbBwiU94C/fkDvBULztkc2os75Yy9f2GWm00+FZHqZxZolAGvTgFhSqzmHvuiyCaVRReGW6JErs3Mmi2TU30fOyzNBYCNNeQUjHFMHLkFRbmvuWF/6VRuzI5dFk64dS3GsnjQVJvuAOP1wPkvqiwoIJyM+PuHstwv3FO0Il1ea7z+k2aeK0MNQD37E7vticsb09Yavy4wcX8rqKyjlhe7hVcuNU4FszSr2DdyfErikpE7N/fEOwL3iyElxjXOOaVbYlXtXcsk9OgdniXlgDEu7tk/CcjHgYsJUF5pXCddzTA3Oh7QzrEhguCAB0UVqDx0/thAjWXSf8gxXv4K6crcziSLNGYzNoO1hkHvWzTKw8GiVXveFgjHPsUKO/1NMzo8I9QUS40c8vuwIlO9E3/qpM4hQVihkIW3ZQWhtCayWCtbC4NEPJlKJDJzgvLE32001yEuCbXoWbcFXox5RNrTKZ80ba6rsj77yZpwNRxQONxdX+EL5nnR71oyIcfl+rJMOfneeHwmIpbA2i6oYkkT1ak2/f9Ncj8rzcB70WBU40pKlP8WEHqdpkwNoRnjah85wtZa8BIWm4d832ybZydAGfxY076c0MJGfR/vJtJ/u3Dw2w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR06MB6908.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFp3WHVBcVl2S084ZjI4aXhHbTF4Z3U3VDYvSTlxcHI5UFp6dDlRd1JTL0RO?=
 =?utf-8?B?MjRZejJwZkVjMjhteXV2UXpJVFg2SCt0b0xwS3RBeUZwUUVENytXMXByOG8v?=
 =?utf-8?B?NnQ0YnZ6amtzRU9YNUdmYVhUalFEUjgzSTdCMzBQOEN5a1ZYc2FIQUhjYW03?=
 =?utf-8?B?V2V2MENyM2pzMlNvRmg4TmFZN3YrQXNVNVdHOGRaS25pd2JJWmVmQ2Z3enNs?=
 =?utf-8?B?dFVXcnJUQTc2WlJIZElPQ0xuSkx1dGhmM3I3cGFoRUpaQjMvRTYyOExRMjl3?=
 =?utf-8?B?dnhCT3E2aGF6eXVGd3VWUDc4cjZpdGZVZjhSQk1sVjgrS2JST0FvckkxMHZW?=
 =?utf-8?B?K1YzS0JuQkdBUnRRNFNEUTkyTXR3SHhkZ1pJN3ovK2VadlhFT01EV3BIOXh0?=
 =?utf-8?B?MFRQWUdCQUhLbmx0ak5NS0JLc0p6K1J3VlFDc2RwT2k3WTdYRkQ2S3p0US85?=
 =?utf-8?B?a2RhWExoV0JlSFVidTNvNG9qTndseDRWVFpxZTg5Y2dOd2ZvSUUycVROdHRV?=
 =?utf-8?B?Y0FsUjVlYSt4VzA4ZjFPM1djc2daeERxWnAzNThhcVFoN1FrMjhuOWplbFdx?=
 =?utf-8?B?cStWMlJuV3k2UmQ4ZkRzSGNDeXQyWTFKNHZWT0dINEFLTnNGR3NTdEs5eTJG?=
 =?utf-8?B?MkIrWE9sV25vRnZMN2lRQjJrTFZYajlxYXhSOTdyVXhrMVBiMnlwZkV0QXJi?=
 =?utf-8?B?dC84d29vM0ZHSldWSkdnbElvUHNvenhOMGM1RVV4VHlzYzBsUTg2ZDBQQVNO?=
 =?utf-8?B?em9vNzVLVWFQMk1TL0RCai8zcEVyUnBIN0U4NGc4OHVsTGlCVG5NRmNucXFB?=
 =?utf-8?B?L2FjSS9HMUtCTWVycG1sRXhLTlpVeGtZNHRlOHZ5YlpyZDdvU1orYVdIVzZq?=
 =?utf-8?B?bWtldm5TeTd3aDdUZlBZK29oVEVnbEZBUW9aL0tiZ1lFNmtHUVVoQndnOWUz?=
 =?utf-8?B?TUNHay9ud2lKZ2k2SmVlVW9PY3EzZWViSkJaZ1d2T3M0UUw0dlpIaHZZNFdN?=
 =?utf-8?B?U21BYURwaHpiYkRPTDVZODYzQnI2U3lzcUFUWHIvQkg0aTN0ZUMzeHo3ZXJZ?=
 =?utf-8?B?bzdONms0RGVHYkxoY2w2SThSQnlWTGJmN0lUVkhyRXh5UGFVTGNmUEpKZkQ3?=
 =?utf-8?B?ZFNyTDFJcFlQV1AxMy8xazVvZjUrVC9vdDhDQ1A4OXdZVmVWUFlwQ1BOMzU5?=
 =?utf-8?B?eERSZVJrbDVUc0ZLQ0xQcm1nMUxsNjI5NWxmM2ZzdjR5T0V1R3FIY21nNmtV?=
 =?utf-8?B?TkxTbllERmtCdGcvcWw4V3liSVJQRmpZMlF4QktUK3dIUlFBbElFcGJXblda?=
 =?utf-8?B?Q05oZkRwd3BNNDByVU5KT0VZREd1cE5qUWlzN014bWhOME5jU0loVUFFbWdD?=
 =?utf-8?B?THloL0dmeGJNR2UzUTNxa3pwdmxPTnJxeXV1QTFucFl1azBKZXhTYXhRTEh3?=
 =?utf-8?B?TmY1a1ZCbGg0Z1dTMHlta05LNFE1OVV0Z0UwSkJ1VnNiay9SRWpFc3NwcTQ1?=
 =?utf-8?B?OGNYZ3dHY0tmOFZpZUs5WEYxR010VW1pdnUxYkhBTDV2TEdINWtBbzlSWEVy?=
 =?utf-8?B?Ym1MVTRTRFVZbzlodlgwZVAwQUwvOS95TzA0SFk1TktOcDlFNW81d0xUa05J?=
 =?utf-8?B?TnRvTGw2d0QrUkZqTktjZmptRC92V1dsM0Urd3RCREZjcm1GaDJzVmJyaXRv?=
 =?utf-8?B?Z0M5d1V1UjdSYVFwUmQzQlFTVE1NU0cvdUJ1bVZzTm1vc0RYNURGRU85NzY5?=
 =?utf-8?B?NDFHV2hLUGFUSDVxZmVDSVdwUkpIZVJrQTh2Q25QamNMeXAwSnhDZVFnVzJB?=
 =?utf-8?B?L2RhdjdBYmI0MUtNb21zZzlRWWdRUTZocU1TcHhqQkVyTmg3MXNHaW1tR3Jm?=
 =?utf-8?B?RnBWMDFjdGdQME1WV0tBcURGSWdCYjJ6ZnVzNm1JSnkydGIyNGVSWk9YVmlk?=
 =?utf-8?B?bFZjREMySEErNU1neEQzZVNPRG5IQWM3b3dlZ2pVOHkxZUFrNEdoLzFrb2Js?=
 =?utf-8?B?UGhUVWduaUYxRXVIRmVpY2hIVDZQOWpOMm5oTThsMlluT3FCT1BDZEJUbUZY?=
 =?utf-8?B?akVsbDV1cGVvTUlKS3lOZEduK1I1d1RWWjRXU3VyMCtVazFwWVVteDcvU2Fo?=
 =?utf-8?B?eDkrVDgzRmVlWjIvRnpwMTFBMGRrVlo4SjNhN1hpT0tsNmpPRkZnV0hQdDFk?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19411C5F4BF14B4EAF3D0CDB2721F2EF@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed7eec3-d6d1-424e-5f85-08dc4a472586
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 08:07:41.2288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LK6rgkdY/0Qyeu87pq8Fz0TbiGwXDyo2wTXzRD/pjqcFNoc9jvNdPSdWpbxPpyeJwu7G18bTFYw8/f9F+R2HaX38WfeT6NlaEZuFSBgvk+rFjOs91NXI8hb2IMGq4N/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6450

SGksDQoNCk9uIDA4LzAzLzIwMjQgMTc6NTAsIFBPUEVTQ1UgQ2F0YWxpbiB3cm90ZToNCj4gT24g
MDcuMDMuMjQgMDk6MzAsIFBPUEVTQ1UgQ2F0YWxpbiB3cm90ZToNCj4+IE9uIDA3LjAzLjI0IDAw
OjA0LCBBbmRyZXcgTHVubiB3cm90ZToNCj4+PiBUaGlzIGVtYWlsIGlzIG5vdCBmcm9tIEhleGFn
b27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFzZSBiZSBjYXJlZnVsIHdoaWxlIGNsaWNr
aW5nIGxpbmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBseWluZyB0byB0aGlzIGVtYWls
Lg0KPj4+DQo+Pj4NCj4+PiBPbiBXZWQsIE1hciAwNiwgMjAyNCBhdCAwNjoxNDo0NlBNICswMTAw
LCBDYXRhbGluIFBvcGVzY3Ugd3JvdGU6DQo+Pj4+IFVubGlrZSBvdGhlciBldGhlcm5ldCBQSFlz
IGZyb20gVEksIFBIWSBkcDgzODIyeCBoYXMgV09MIGVuYWJsZWQNCj4+Pj4gYXQgcmVzZXQuDQo+
Pj4gVGhpcyBpcyByYXRoZXIgb2RkIGJlaGF2aW91ci4gSXMgdGhpcyBzdGF0ZWQgaW4gdGhlIGRh
dGFzaGVldD8NCj4+IFllcy4gSSd2ZSBjaGVja2VkIGFsbCBUSSBldGhlcm5ldCBQSFlzIGRhdGFz
aGVldHMgdGhhdCBhcmUgc3VwcG9ydGVkIGJ5DQo+PiBsaW51eCBhbmQgdGhleSBhbGwsIGJ1dCBk
cDgzODJ4LCBoYXZlIFdPTCBkaXNhYmxlZCBieSBkZWZhdWx0LiBIZW5jZSwNCj4+IGRwODM4MjIu
YyBpcyB0aGUgb25seSBkcml2ZXIgdGhhdCBmb3JjZWZ1bGx5IGRpc2FibGUgV09MIGF0IGluaXQu
DQo+Pj4+IEBAIC01NzIsMTEgKzU4NCwxNyBAQCBzdGF0aWMgaW50IGRwODM4MjZfY29uZmlnX2lu
aXQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiByZXQ7DQo+Pj4+ICAgICAgICAgIH0NCj4+Pj4NCj4+Pj4gKyAgICAgaWYgKGRw
ODM4MjItPndvbF9lbmFibGVkKQ0KPj4+PiArICAgICAgICAgICAgIHJldHVybiAwOw0KPj4+PiAg
ICAgICAgICByZXR1cm4gZHA4MzgyeF9kaXNhYmxlX3dvbChwaHlkZXYpOw0KPj4+PiAgICAgfQ0K
Pj4+Pg0KPj4+PiAgICAgc3RhdGljIGludCBkcDgzODJ4X2NvbmZpZ19pbml0KHN0cnVjdCBwaHlf
ZGV2aWNlICpwaHlkZXYpDQo+Pj4+ICAgICB7DQo+Pj4+ICsgICAgIHN0cnVjdCBkcDgzODIyX3By
aXZhdGUgKmRwODM4MjIgPSBwaHlkZXYtPnByaXY7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgaWYgKGRw
ODM4MjItPndvbF9lbmFibGVkKQ0KPj4+PiArICAgICAgICAgICAgIHJldHVybiAwOw0KPj4+PiAg
ICAgICAgICByZXR1cm4gZHA4MzgyeF9kaXNhYmxlX3dvbChwaHlkZXYpOw0KPj4+IFNpbmNlIGl0
IGlzIHJhdGhlciBvZGQgYmVoYXZpb3VyLCB0aGVyZSBtaWdodCBiZSBzb21lIEJJT1NlcyB3aGlj
aA0KPj4+IGRpc2FibGUgV29MLiBTbyBpIHdvdWxkIG5vdCByZWx5IG9uIGl0IGJlaW5nIGVuYWJs
ZWQgYnkNCj4+PiBkZWZhdWx0LiBFeHBsaWNpdGx5IGVuYWJsZSBpdC4NCj4+IEkgc2VlLCBJJ2xs
IG1ha2UgdGhlIGNoYW5nZS4NCj4gSXQgbG9va3MgbGlrZSB0aGUgaXNzdWUgSSdtIHRyeWluZyB0
byBhZGRyZXNzIGluIHRoaXMgcGF0Y2ggaXMgbm90DQo+IHNwZWNpZmljIHRvIGRwODM4MnguIFJp
Z2h0IG5vdywgZGVwZW5kaW5nIG9uIGlmIHRoZSBQSFkgaXMgcmVzZXQgb3Igbm90DQo+IGR1cmlu
ZyByZXN1bWUgKGVpdGhlciB0aHJvdWdoIG1kaW9fZGV2aWNlIHJlc2V0X2dwaW8vcmVzZXRfY3Ry
bCBvcg0KPiBwaHlfZHJpdmVyIHNvZnRfcmVzZXQgY2FsbGJhY2spLCB0aGUgV09MIGNvbmZpZ3Vy
YXRpb24gaXMgZWl0aGVyIHRoZSBQSFkNCj4gcmVzZXQgdmFsdWUgb3IgdGhlIEJJT1MgdmFsdWUu
IEkgY291bGQgc3RpbGwgbWFrZSB0aGUgcGF0Y2ggYnV0IGl0DQo+IGRvZXNuJ3QgcmVhbGx5IG1h
a2Ugc2Vuc2UgdG8gYWRkcmVzcyBvbmx5IGRwODM4MnguDQo+DQo+IEFsc28sIEknbSBhIGJpdCBj
b25mdXNlZCBhcyBJJ20gbm90IHN1cmUgaWYgdGhpcyBpc3N1ZSBpcyBhbHJlYWR5DQo+IGFkZHJl
c3NlZCBieSB1c2Vyc3BhY2Ugb3Igbm90IChlLmcuIHVkZXZkIHRoYXQgd291bGQgcmVhcHBseSBX
T0wNCj4gY29uZmlndXJhdGlvbiBhZnRlciBzdXNwZW5kKS4NCj4NCj4gSWYgaXNzdWUgc2hvdWxk
IGJlIGRlZmluaXRlbHkgYWRkcmVzc2VkIGluIHRoZSBrZXJuZWwgaW5zdGVhZCBvZg0KPiB1c2Vy
c3BhY2UsIHRoZW4gUEFMIHNob3VsZCBlbmZvcmNlIFdPTCBjb25maWd1cmF0aW9uIGZvciBhbnkg
UEhZIGJ5DQo+IGNhbGxpbmcgc2V0X3dvbCBjYWxsYmFjayBhZnRlciBzb2Z0X3Jlc2V0IChwcm9i
YWJseSwgYXQgdGhlIGVuZCBvZg0KPiBwaHlfaW5pdF9odyBvciBhZnRlciBwaHlfcmVzdW1lKS4N
CkRvZXMgaXQgbWFrZSBzZW5zZSB0byBhZGRyZXNzIGl0IGluIHRoZSBrZXJuZWwgPw0KPg0KPj4+
ICAgICAgICBBbmRyZXcNCj4+Pg0KPj4+IC0tLQ0KPj4+IHB3LWJvdDogY3INCg0KDQo=

