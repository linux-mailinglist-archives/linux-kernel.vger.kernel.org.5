Return-Path: <linux-kernel+bounces-97331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5247E8768DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBAB1F23A3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417481CD0A;
	Fri,  8 Mar 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="aCCyi6T1"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DE1F164;
	Fri,  8 Mar 2024 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916629; cv=fail; b=IDBIMHg7bi32rZn/jdfolQV4Z1wbohy5qnYTI9wMgU//7j0Yqy3fISnpw1qiYpoiB+o5aHuo3yW+KfLmmiB4CqJcNhfwwR4G7AwN/V9mb2yzfRTX+6gs3BQqk3+fYXv9UZiYqHeT/0HFKSnIo7h3qq9a/wwtvY4iSJOP/DNp1pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916629; c=relaxed/simple;
	bh=l+cf9kUMzsSwOQPcRykbJ/uR1wOtN1cuWZiB94rQAvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBNiHZFYAEehwDn+/S8QpqS7HqMEpK06mo562eSoSQo8g8tJe/+9/F/Ps07d0Kop5QR+mtFlEt/e/O+Hcuv2qNHvYE8Sm6fmTZxUXmZSCtwZBaQtFFm8um6+aEnBRgkVpbZsTEvkCKh0goVGdz1LtOphwpouYv5o2axIo2YZfGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=aCCyi6T1; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQhvy8rZJF2ObRut2O2/B1Nmhq+GfRzkiA7BD3qMmyl3+KqJ/IeOd7WpR1RFc/LeJEQPELQ90qKv87bW3wgzSl55MgOgsdyADd46btEkHkhdERy7wD8Q+VUbnAcI8wN977/807ZE83NU0s2G5MsVepYTSdrKVen8V5o9Zc+xz3OVDPyCiAbiJOtVkURd0yX3vtmHLxJu47gO0mvfQg18u2m0oWJwmZRuN1fnh/0dcL3KnMNfgqRSikELIUAk5TyVngeWjTO80Hrn4nZbVcLVOMjin5Swc6TL2NsZeHQrWqdnFgS+q3aEFXGRCDssNXu1u458aTiopgKy44Eym2UcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+cf9kUMzsSwOQPcRykbJ/uR1wOtN1cuWZiB94rQAvw=;
 b=GbYYgXFLS9dHIc6IX2x90V+j4ftg6lIFFaMiStsTBb8zvDnV7NN5sBW256ENmtMZSWZ3MptseP/oEq/9IhRWBQAsU8L+PkRAKf9GTg0ToiG4XcT+BAaNWIYBnzSHqTeJaCtr+3nvPdys3u234+z4Z6sPgQ/M1aDy9K3jokOFuYcu8onyOqOtE6Rsi/3XdMQ7ZHoB3znX0r/QRMvSd9A291jOavu03b69FLS8P25wY7CCnJe4pbXdNUVH2rZge1XLaS0p+Ryc3QF+pxxm7AlCI2sagt+7wZKvgNswIG0m5PYLk7HJMjVwBOjNjx+mP+krQ2Pk/5IV/CFugYx6MReMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+cf9kUMzsSwOQPcRykbJ/uR1wOtN1cuWZiB94rQAvw=;
 b=aCCyi6T13laKS0vWCIo5Ijcq+URyyj7UlImqKQKIyaVybO+QBHQZMb+nMLRMAP+wHWMXGh/Mo7x7TZPLk0mLsviEJ4hD6MANn6L4caeVfn502Pj88m/3lVqSiwbBaU/qecmhJjQBy9Hz/znFUer0JjH8zHBfKQJi4BsdOTfrmRA=
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com (2603:10a6:800:1a4::13)
 by PAWPR06MB9010.eurprd06.prod.outlook.com (2603:10a6:102:38e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Fri, 8 Mar
 2024 16:50:22 +0000
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41]) by VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41%2]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 16:50:21 +0000
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
Thread-Index: AQHab+nNNjxI3+NV+Uir0lLTLIYJU7ErVY4AgACd/ICAAh4MgA==
Date: Fri, 8 Mar 2024 16:50:21 +0000
Message-ID: <f8bfbe80-f308-4b8d-b8f0-5a5f6ca5fa0e@leica-geosystems.com>
References: <20240306171446.859750-1-catalin.popescu@leica-geosystems.com>
 <8de1d4e3-6d80-45a5-a638-48451d9b5c15@lunn.ch>
 <b53818a7-66a4-4c7a-b687-efaea6cb9e4e@leica-geosystems.com>
In-Reply-To: <b53818a7-66a4-4c7a-b687-efaea6cb9e4e@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB6911:EE_|PAWPR06MB9010:EE_
x-ms-office365-filtering-correlation-id: 176c536e-cbbe-40f6-3fee-08dc3f8fd7c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yLO4rgrt2XkId4Ewx7GYX+OcsnFxp/rkiWhrP1ServDeRkXJkgaG0JnlLz/fgcdv1eaBtknyi9knRepHguu9oRA5/plHwoJkaJhMfvv3y0j/Ht94bZoSW+3qHTUyynsSsk/irX4Gaf554j8hMvffHdaM9+1W9MzfKdN5jAICLFiO48O5tAj109zWRzhLkFgtF3CZ3FAzbvb/Ap6TckCwD2vLqfZ6OwzEoBX1r5GlRBQe1EfBicYocF/C3r53D58qA2hbvej3MRfpBBQgpLPsomnmMQi8erGcp/+FxB57DcYQrtohm2XyYOQK2XQFosI8jAoFYZnlvSfyQKrcAAi5535C+UF52i8GYsLMVjDQQhczjlpKyweeF5yhz5UnML9zlFNyXGpjqY4tuNEmD/O6kFhWM0bNAj0wPwoFXuRdW9TsgPmoRyXxfg6HS/+aom134qvUECwL4J3IXMmknSjngz+pzolDTxZQHxcctTNT2OAMRKA6wYDIut5X3tf6MI3+3f2MZv/uQgZrOVGtqsKntO7+wmhhxcMbhqVCtWbTc1ZKEC91cRyF0Mlp1JmwMnG58k5Vdrl6mXVT1qyyQ2dUoRyDRbBGtcCRPbNAEFX7OEiTcFiKSSuV+if5T9LQsEDpUDRi+5d6UFzPoMpaGDe/k7kj48tyyS/VKtSQc4a3wS1CnU3WDUOV6/+iofbW/iko4OLsk6BL5blX+wCEdu0j6Fuopq8rmbDho0aYYDqM4eM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB6911.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEZLMEhtQmJkQU9IK0cyT2hWa205Y1drZzJ6S0hPckdtVEViWkVQVmx3MHY2?=
 =?utf-8?B?ak04ZDZXTDhBWXVGNG1Fbmt2dGFuYm1aZ0NRbVhKNjlRT3RsWWRhT001TFFP?=
 =?utf-8?B?Qm1sTk9QWmErRHBSQVQ1NXMvZFVZZXN2Nmt4UGhCQnlwVk5wWlptRTV3S0E2?=
 =?utf-8?B?WE5aaUdLVDJQaFUwV0hqMjJkZ2dpNm50OUdPMzJzMnd4RTF3cEl5ZThzVXRF?=
 =?utf-8?B?VzEyd3BuWFNocTdYZFUvT1JIRFFkbWQ4YVUyaFgySHRZQVMyY1h5M2pJbUQv?=
 =?utf-8?B?UmloNGJDWXhnM1B5dTFLMnZoWHVubDZFQ3Frek1iVDNGZTlWSmdydHRGdStK?=
 =?utf-8?B?RFVpdnBFdk5ucXR2ZHFGTTM0YU84b3VocXlZNFFRaUZTNFgvV2xGQ0xPVVph?=
 =?utf-8?B?RVp0Zm43QnRxUVBtMVlyTnIxd1dlRlZaL3FXQWNUMXNkanBwSEFjRW5GbTJQ?=
 =?utf-8?B?bzBhajZ0Q2RaQjhsQVlYSko1NkFScTA0ZURJdmFwck1GWkg0UmlvSWVmTnlM?=
 =?utf-8?B?Y2QvS20xTmFyQjR2OUlxclByM0M5V1Q2UTd1bGNqTXd0QmFjemVpQXlOdW4r?=
 =?utf-8?B?Y1ltTmZINjhmT0xGbldDZmNCWUxWYjNDUlFIUldldjE5QjVQL0xhRnhEczdS?=
 =?utf-8?B?WVRsa25Iem9zS2JzOUFReWxYd3BzQStvd25iUkc2N1RaUUZrcHU0eXNXSFVM?=
 =?utf-8?B?VEdXUzE5WHkxU21WVGlmemFrVU9wb000K2xKRng2ajNBM0N6ODA4bWwydlor?=
 =?utf-8?B?U2RUamR4alYyL1dEOSs2cDgydGVNdnFQM0x5dXVSRmdXUFEwQnhVME9pMUVo?=
 =?utf-8?B?U0hRYlcrcHNwY1BjZ2Mrb1JGbHhoL2g1L2xDOFFSQkd5TUl5MXhVSFpRQjhv?=
 =?utf-8?B?RFhyMGJ4andrR1R1cW5XNG9wR2MvSjBjNE1Zc2dza2RkYVRPdTNvenowOERW?=
 =?utf-8?B?TVRaYXRidGtXUlUvYkRTQ2tNbVIxRHpzejBXOUN6eHhBL0pablY2Z1ozcnZO?=
 =?utf-8?B?MG51YUl3bzBsRmY5VVBFTy9ZVTNPcWJBb3VLaHZRK2hzTmZwREtieWdEc2RK?=
 =?utf-8?B?clVtYk1CU2hPZUNmMFlGbWNlT09tNzdrL2IwcjBVaTdTNG9qdnZudGVmVDlr?=
 =?utf-8?B?QURyeDltY0QzYjZzUVVmM3VHd3djMzBTcHJOa2t1bkszdjBDb0p0ZHUvMzE2?=
 =?utf-8?B?UUxPakp3Z3dpRzdqaFdNMTlqZW8yK1hoYTd2K2F3L28yb3RFTWdHa0RSa2F0?=
 =?utf-8?B?SE41RUp5S2k0RHNDWXZVZmdEeEt6VUlta0pQdzdGTU5SSjF2bGZ0aDJvSVBU?=
 =?utf-8?B?dTA3RU5qdjFaMERWTGE4M1F3KzFsM3QvbzhRdTJyMU5sVldGSmtJZUlWRURM?=
 =?utf-8?B?ZXJITnRjblBrOHVCQmRtTkFiUUJLRjJrUms1SzJpY1hvQXcrcnpoYzZQZzJP?=
 =?utf-8?B?YWNIWUw5U1d1Q2tFdXQ4MHlJNzJXbTRQWGNGMXFSMmtaUW5GQjJrUkpoZ29j?=
 =?utf-8?B?YTg2RmhVOXdZS0RDMDNzd2RjS2tRL2poR1VQY3g2eUsxdmZTUFdjR1ZkUVBn?=
 =?utf-8?B?ZnhvRUlFVzhiK3lIdmJtalVJWjF4dTVzM1ljdS9nUFloK3Rqd3VhdzVTVFZV?=
 =?utf-8?B?ZzB1bmtJNmpRSWFET3o4WVRkZm1VREN4MGFIUmR2MkR0MEQydW1YVkVIWGJU?=
 =?utf-8?B?cFBVazZac1V3Y3JBaVhKNnR1eXkzYjhlOUJZWnlSTDh3L2lnRXpPTnp1eHpM?=
 =?utf-8?B?TFlUQ1F3aW9xaXRacG91WHk0QlFOMHhEemNZNi9kRFhleTNaMHdKYnA5VWg3?=
 =?utf-8?B?amkzdjhLTTRUVkl2cGRDL2p6Ynl0NXYya2M5dUhUUjZTZVhYR0tuTDAvZW9Q?=
 =?utf-8?B?c2w3eFNpVjE5Qys1VlhuVnVuZFUrSEYwQ1lxQ1NDNk9SdGZGWUc4K0NFL0Jj?=
 =?utf-8?B?aVI1SkhaekVtYVdqY2QzKytYWkdnbkY0eEx1bEFUTlBuNk5IZjhERUhoS0hB?=
 =?utf-8?B?UUZ1QUQ4ZVE1T3Zsc3FhTkIrczhiOU8vbEYvandwTHNscTJFWHlTTERVUFVq?=
 =?utf-8?B?NjJrMjJPTzJHNjZlT0o0eVptS1cvV2wrdTk2MkR4WmhsMXZBc284UTU1ZXY2?=
 =?utf-8?B?Q1J5dkhIRVFPYlgyakJBSTY1RkVtU1I0d3NxVFdTTkt4bzh1T3RUTThmUlBr?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E280C2EA7E7CA4D8570447AA1A5BCEF@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 176c536e-cbbe-40f6-3fee-08dc3f8fd7c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 16:50:21.2329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9CHQM2d9f8T37kEeChNlkXXAmLy7n2YdFr1vDuVK8qbFN3HD0ueV7k8jIb3FyoOfuQiJmO3bc7SawkJB/UywYxFj/bEadTElqzN4Mb0rjzJoNXFKQ4TKd8wdQi7wui0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB9010

T24gMDcuMDMuMjQgMDk6MzAsIFBPUEVTQ1UgQ2F0YWxpbiB3cm90ZToNCj4gT24gMDcuMDMuMjQg
MDA6MDQsIEFuZHJldyBMdW5uIHdyb3RlOg0KPj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhh
Z29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlj
a2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFp
bC4NCj4+DQo+Pg0KPj4gT24gV2VkLCBNYXIgMDYsIDIwMjQgYXQgMDY6MTQ6NDZQTSArMDEwMCwg
Q2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4+IFVubGlrZSBvdGhlciBldGhlcm5ldCBQSFlzIGZy
b20gVEksIFBIWSBkcDgzODIyeCBoYXMgV09MIGVuYWJsZWQNCj4+PiBhdCByZXNldC4NCj4+IFRo
aXMgaXMgcmF0aGVyIG9kZCBiZWhhdmlvdXIuIElzIHRoaXMgc3RhdGVkIGluIHRoZSBkYXRhc2hl
ZXQ/DQo+IFllcy4gSSd2ZSBjaGVja2VkIGFsbCBUSSBldGhlcm5ldCBQSFlzIGRhdGFzaGVldHMg
dGhhdCBhcmUgc3VwcG9ydGVkIGJ5DQo+IGxpbnV4IGFuZCB0aGV5IGFsbCwgYnV0IGRwODM4Mngs
IGhhdmUgV09MIGRpc2FibGVkIGJ5IGRlZmF1bHQuIEhlbmNlLA0KPiBkcDgzODIyLmMgaXMgdGhl
IG9ubHkgZHJpdmVyIHRoYXQgZm9yY2VmdWxseSBkaXNhYmxlIFdPTCBhdCBpbml0Lg0KPj4+IEBA
IC01NzIsMTEgKzU4NCwxNyBAQCBzdGF0aWMgaW50IGRwODM4MjZfY29uZmlnX2luaXQoc3RydWN0
IHBoeV9kZXZpY2UgKnBoeWRldikNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPj4+ICAgICAgICAgfQ0KPj4+DQo+Pj4gKyAgICAgaWYgKGRwODM4MjItPndvbF9lbmFi
bGVkKQ0KPj4+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+Pj4gICAgICAgICByZXR1cm4gZHA4
MzgyeF9kaXNhYmxlX3dvbChwaHlkZXYpOw0KPj4+ICAgIH0NCj4+Pg0KPj4+ICAgIHN0YXRpYyBp
bnQgZHA4MzgyeF9jb25maWdfaW5pdChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPj4+ICAg
IHsNCj4+PiArICAgICBzdHJ1Y3QgZHA4MzgyMl9wcml2YXRlICpkcDgzODIyID0gcGh5ZGV2LT5w
cml2Ow0KPj4+ICsNCj4+PiArICAgICBpZiAoZHA4MzgyMi0+d29sX2VuYWJsZWQpDQo+Pj4gKyAg
ICAgICAgICAgICByZXR1cm4gMDsNCj4+PiAgICAgICAgIHJldHVybiBkcDgzODJ4X2Rpc2FibGVf
d29sKHBoeWRldik7DQo+PiBTaW5jZSBpdCBpcyByYXRoZXIgb2RkIGJlaGF2aW91ciwgdGhlcmUg
bWlnaHQgYmUgc29tZSBCSU9TZXMgd2hpY2gNCj4+IGRpc2FibGUgV29MLiBTbyBpIHdvdWxkIG5v
dCByZWx5IG9uIGl0IGJlaW5nIGVuYWJsZWQgYnkNCj4+IGRlZmF1bHQuIEV4cGxpY2l0bHkgZW5h
YmxlIGl0Lg0KPiBJIHNlZSwgSSdsbCBtYWtlIHRoZSBjaGFuZ2UuDQoNCkl0IGxvb2tzIGxpa2Ug
dGhlIGlzc3VlIEknbSB0cnlpbmcgdG8gYWRkcmVzcyBpbiB0aGlzIHBhdGNoIGlzIG5vdCANCnNw
ZWNpZmljIHRvIGRwODM4MnguIFJpZ2h0IG5vdywgZGVwZW5kaW5nIG9uIGlmIHRoZSBQSFkgaXMg
cmVzZXQgb3Igbm90IA0KZHVyaW5nIHJlc3VtZSAoZWl0aGVyIHRocm91Z2ggbWRpb19kZXZpY2Ug
cmVzZXRfZ3Bpby9yZXNldF9jdHJsIG9yIA0KcGh5X2RyaXZlciBzb2Z0X3Jlc2V0IGNhbGxiYWNr
KSwgdGhlIFdPTCBjb25maWd1cmF0aW9uIGlzIGVpdGhlciB0aGUgUEhZIA0KcmVzZXQgdmFsdWUg
b3IgdGhlIEJJT1MgdmFsdWUuIEkgY291bGQgc3RpbGwgbWFrZSB0aGUgcGF0Y2ggYnV0IGl0IA0K
ZG9lc24ndCByZWFsbHkgbWFrZSBzZW5zZSB0byBhZGRyZXNzIG9ubHkgZHA4MzgyeC4NCg0KQWxz
bywgSSdtIGEgYml0IGNvbmZ1c2VkIGFzIEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzc3VlIGlzIGFs
cmVhZHkgDQphZGRyZXNzZWQgYnkgdXNlcnNwYWNlIG9yIG5vdCAoZS5nLiB1ZGV2ZCB0aGF0IHdv
dWxkIHJlYXBwbHkgV09MIA0KY29uZmlndXJhdGlvbiBhZnRlciBzdXNwZW5kKS4NCg0KSWYgaXNz
dWUgc2hvdWxkIGJlIGRlZmluaXRlbHkgYWRkcmVzc2VkIGluIHRoZSBrZXJuZWwgaW5zdGVhZCBv
ZiANCnVzZXJzcGFjZSwgdGhlbiBQQUwgc2hvdWxkIGVuZm9yY2UgV09MIGNvbmZpZ3VyYXRpb24g
Zm9yIGFueSBQSFkgYnkgDQpjYWxsaW5nIHNldF93b2wgY2FsbGJhY2sgYWZ0ZXIgc29mdF9yZXNl
dCAocHJvYmFibHksIGF0IHRoZSBlbmQgb2YgDQpwaHlfaW5pdF9odyBvciBhZnRlciBwaHlfcmVz
dW1lKS4NCg0KPj4gICAgICAgQW5kcmV3DQo+Pg0KPj4gLS0tDQo+PiBwdy1ib3Q6IGNyDQo+DQoN
Cg==

