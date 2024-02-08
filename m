Return-Path: <linux-kernel+bounces-57694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8031984DC6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71151F224ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B406BB38;
	Thu,  8 Feb 2024 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="OfTN2i+F"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A214263;
	Thu,  8 Feb 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383329; cv=fail; b=EuC3+itKUtQbYpQTKaF3trT8E/h1pyKXbWPejXV42RZ6LhGqAjI/S8WrC+rJ6IUK+4ezu+LYSyKcyVbTk/Za+8dcOMiHiXQjlFTSnY3CzB7rLmBfzZqHSL6EYuXDfE5fvpc3PtKFk8BYpLS+EbDrUBUqvaCuk0I1TfRgWrCYVJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383329; c=relaxed/simple;
	bh=JamfvdShnelpmOiFmZbVmi9ddVPs/DYNSbR1CoCBPfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CjGGMYvTzZ6odr3KVgaxfod9hcWVToJ68GTg2ytRC7NfmFqc8BbwaFrYTBjwfXwqH7U1lKj2/nu/pqxKz2ag9iFoupo7otP69izdkHz7DEq/vvqF1LUrn+23AhsPyuw6taLqazwm90ccDU7T8JvtW2TPrxmhgmdYqS2Irk6syg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=OfTN2i+F; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPqygopf9R9IZF1Kd4dRzCWaGO9lOic45C4g7z+op70/5WVHNU1wOt9iVRixSieq0yE49ZMiXxUDvjLLj66sgmRPv9fjrAsL9oHg9eb8xBUtViKcNbbkdmUpJts1H6Wy1ZJ7u8l84uDV+T9pBoKg0nUHFNIoefM8sdPhMxgEwLykgUaXCfJUWQH2gQrfzuP0oQICmGRrnHY4IVZ31WtAcfgTplpTqTK6PVBeDsYtRfJyPFhf1WHaGtRTMDphJ+EjulByREg++6lR044p4sFvurXc5fbn2sz2+nT52V64cFmmuZejfVJbgpn4VaKb4RV4q9m8yB976o4UupKLyHe4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JamfvdShnelpmOiFmZbVmi9ddVPs/DYNSbR1CoCBPfY=;
 b=h8QJlepswOi+XTZkiRr01xWpDX06E8bgH2puz5Jqz+WF4U4gmn+p1auAnQnnpCrT2SnoTyZG6FUBTxnFVGgteHfsCTqTKgFThWQ94yWV+N/fTzwaFiSXBx55slt376/d7MufwTvRXrq6nvegSy0+bSQy9dX4NQT+EKKGmfEgR1QT3PT2bT0qZtDh6IpWSZCfhZBIqiFDBJ9ywPRGmVGHClEal4ObJ1kwAxjNSDkrEIKHrrig4pW/a7shHmTRTxoGabg7cwAkoA7PEgzRk2wPQ2khHAD3rtJhhyiU0MTTnqUMQw9ETyH85PDiLUBKzCvxL//z/086Tol1VA89kTbuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JamfvdShnelpmOiFmZbVmi9ddVPs/DYNSbR1CoCBPfY=;
 b=OfTN2i+FjaBmdMCXDvPWUEBELvHhuWknVk3ASb1v6znE7dBpAXjwlsQ/x3E6cxw+OuRi4Zrhrm+HpmAGBb/y6YtWKAlGoTZljOx6yOGpJFCusy74yqchrr1abY1ztPszsPO8JFIFtXWvhi3JHD5bz+mk/6NVZfFuqDoAw5L+Hr8=
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com (2603:10a6:20b:59::18)
 by PAXPR06MB8344.eurprd06.prod.outlook.com (2603:10a6:102:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 09:08:43 +0000
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a]) by AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a%6]) with mapi id 15.20.7249.037; Thu, 8 Feb 2024
 09:08:43 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: dp83826: support TX data voltage
 tuning
Thread-Topic: [PATCH v2 1/2] dt-bindings: net: dp83826: support TX data
 voltage tuning
Thread-Index: AQHaWe9VCJAw32n0qU6/fjbc9pjQ+LEADwYAgAAUagCAAABlgIAABSCA
Date: Thu, 8 Feb 2024 09:08:43 +0000
Message-ID: <f35e239d-3f78-40e1-8d5b-4d7b949f08aa@leica-geosystems.com>
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
 <a4949983-f6ba-4d98-b180-755de6b11d0f@linaro.org>
 <83f00386-e741-4bde-bcfb-462fadde1519@leica-geosystems.com>
 <2c4e76f5-0a13-44b5-8ece-3deb957dd260@linaro.org>
In-Reply-To: <2c4e76f5-0a13-44b5-8ece-3deb957dd260@linaro.org>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR06MB4705:EE_|PAXPR06MB8344:EE_
x-ms-office365-filtering-correlation-id: d44ccc51-5141-43fc-e189-08dc28858c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9PVo3iNY3lEL8XaPNKGMnjyQbu+ecvpqSbsCPBMVU82Mg5onb5neVsrHZQwx0BwEKlBIs4MvjePczWnmjWrN5DzmZbTgCkpqqCNAzd7cgMta6iO/e1Y139xWuq/e9gnAyq8OEvojyKjDSyctsr6e21DYaoRaZnJAYPoFHsZ5hxsLaxAL/TSIJOgEaXPs7nCOVzhqjmiTd4WUlxVkM7FT55ocMYfBfUCcRpCsrhjdDWyl/jvRHn7NMUdGDkRHE0uvwE22LqyeWWfmixVECr8tUq2Ea2t2XnLDFCELwSlyt7ydPsD1nCBxv9N92D00viSpC+pinx/fFKYdZK1RpRJJrStoiCjyPCFLpno8OP/wYLqz7sphvdlDXQkwcLu45/hrd9/VnEEHdR2Hv+h8BK7mWIyzr/7KASEMOETjuDrAVLbQpXXxY+EBBESJx/8PxO6hZ6vinWMPJheGVOxeS3/zTqMK8uE3SiaBeskHy8yNgxSOAx8iFWCkP7hz4A8Ns9izblNNk2z6sLqU763Ajwlc1GMWFTQaqfajlQbThP/zkBy2ilt5X7t2UV8qV01oz9Ahex+GLU6TsfOnK8vIRGngT5embjM6WDr8HfZAGsdcINeqCMA86ybQuEd23xyz3blV3hYp7jztsk58tZggGyqReA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4705.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230473577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(31686004)(83380400001)(6506007)(53546011)(71200400001)(45080400002)(478600001)(6486002)(966005)(6512007)(2906002)(66556008)(66946007)(91956017)(76116006)(66476007)(110136005)(5660300002)(7416002)(26005)(2616005)(36756003)(38070700009)(921011)(86362001)(64756008)(54906003)(8936002)(8676002)(316002)(4326008)(66446008)(38100700002)(31696002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHBqcVh2ZE1MT3JnZ1h5OW1KNVJkU0NvZkFIbm1JYU81NHBCd05zRWJYRUVJ?=
 =?utf-8?B?REJkQ1RCME8wZ2tTdVJZZ1Jpc205b1dFRzMyQXVUM3NzK1R6SWsvMWRwa2FH?=
 =?utf-8?B?UlRyRnFEYTAwQlBvNnFXaWtoWW1rRW1XcWNWczBFc1RiQjRaR253ODMzZEph?=
 =?utf-8?B?QmxCalFvWjdlT2ZucVYrRnZYb3puOUZHNUZWckQ4WHNMMFZlS2lKRlgwWkU4?=
 =?utf-8?B?T2VFeTNQV3pKekVuVWZGS084TnNReXg1Z3lIbzN5dlI2cGRoaG9PWGNyZEh6?=
 =?utf-8?B?OHVnYkpKTGQ4cE04WmdrSzk4bjRrcG9KVERjSW5TQ2Jtd21oTVZzSVVZbml4?=
 =?utf-8?B?bVlUcXo2R1h2UjU0SmZpM0FuZjEwQ3hHaDVRcHpXdHM5dmFnSllVL1RRd0dy?=
 =?utf-8?B?RHBScDdUOGp2Nkp0c2xBdGZxNnBnRUhtY1c5cWFHdlVpeGFEUmc4Q09vTTlB?=
 =?utf-8?B?SnJBa3NVTG9oRDBya0cwSEtyOWFPVjg4Sm9pR2ZFN3NIbDc0QkRKb0ZINUoz?=
 =?utf-8?B?VXN1WURxRDBYdFMrYjExRmM0c0ZSZmJUSDdjYWhZcXByUnQrNk5ON0NyK21q?=
 =?utf-8?B?ZHhqa3Nmd1BjM0hVYkQ4SmdZVVpjQ3VMU04xQXJXWFdXQmkwNitZM05IcXNI?=
 =?utf-8?B?SGdiV2NRL0dHYXVkQkk1Q2N1czMrSzJqREpwODIxZVFDZ05KOWtzYkZBbzMw?=
 =?utf-8?B?WkQ2a2lMYjJvOEIyczVPaHVWZGQwcFdQUElFVWJMZVdQZk55ZlM5N1BhbE9n?=
 =?utf-8?B?T1BYZHR6ZGdsRy8yQU9pMHN6SXBxY21CbGRYUFlKU3dYMjkxQXNBeXRMVVk1?=
 =?utf-8?B?SW1yZkJodCtiR09xQ2MvWDc2U0hxV1N2cXYrYTQyUFZOMWZiN1BQVThreVZp?=
 =?utf-8?B?QmcxZ0UzdjN3UUZhQnppQmxlbkhWZGFKdzl4dXYyRXpXa0VXTkFWMXRIc2hO?=
 =?utf-8?B?MGFUQWdsMmc1SlJ5VjdPTkd0SjhyRGZwbDdmcm5kTHYwNlpFN1lndjMyTlEy?=
 =?utf-8?B?WlNlUjFZYTBNNDJOZThDVDBVQnBWMWRvcXZrbWxuaDFRSUZUZ0lHL2x3MERz?=
 =?utf-8?B?dkR3TjE2N3lwNkY4Tk1JUE5FbUNRak5TZUdnODUyeHNtTjEwMHRoc1NTOFdY?=
 =?utf-8?B?eHFqa3NBTDNva3hQUm5RY1h4YnVCcEpUT1BPRThEOXNPbkZtblFRMUdWbDRk?=
 =?utf-8?B?aDZhY1lxS2tad3dGaVVqcHZQSUZ3UnR4T0RQbVBVbG1MZjd2Z0w2MFY1NVVa?=
 =?utf-8?B?US9pejliU3ZOcTlMcm1mUklhd0FCQ0N4TU42SjJSMXhmdFQ0blBqKzBmbWxr?=
 =?utf-8?B?RVlQdHJ0bmVZRGdIV2VWNmxhb3dkUU0zRHFoaE5NTUxRa09ERzhGRFRPWnJn?=
 =?utf-8?B?N3NXVlNSNGo3ajliRWtYUTJHOUYvWGdPWmJSazBTZkcwdkx1RlRtaVJaUFV3?=
 =?utf-8?B?NDRwdE5WNXJPa2htR3d5QTJrVjlYWFhiMk01bDV0ZWhwSUdmWUhxR3p2czdu?=
 =?utf-8?B?ZFZOQk4zc1dyYTQxdk4yUDJiWU8yNGJvVW9LbnUwSXlscG5NSVlhVzR0Q21m?=
 =?utf-8?B?NXN6TCsvVXRSOXBFc1RmNlQwWDlhYXZCdVIrRDdyRW95M05ZMkNoUlJ3bS9h?=
 =?utf-8?B?N2JBZUpiTFk3RFU5TFFBa1hkd1F4OW45YldkaTAwUUgxekp3c3NkTHRjWjJt?=
 =?utf-8?B?SjBmSll2S0E0QndHNld5cG0yNllQYjR4dUFKR2tXWjI1SVliYmNrWEIvcFBw?=
 =?utf-8?B?bTkzZlZQdWNXWXJDME1Cak1obWdMbHpITWdvdndTY3lDZEtjaDN2dWZrWHZv?=
 =?utf-8?B?elFCQWtkVi9BU3lnemRsT0hCMUkxRjZUelpGcUxHd1U2d29OYTE0TUVXUFpk?=
 =?utf-8?B?ZUdMamx5cE5IeHV0ODRDczJsL29KK3ZFL2dDTjdCVk9VOFhEOFRCbGUwVm00?=
 =?utf-8?B?eEEzQ1N2YlZ2azNPbDZvMk9rdDAxY1lZcEtZVkhrbUh1eTNpdGtlVm9xTDE2?=
 =?utf-8?B?bWRYYkF4UEFjWURJaTVWWUVDZHNFYUMzS2xRMk5tUThEaGFueGliMCtRYUxq?=
 =?utf-8?B?YVV2VWRKdDQ3bG91OEUzVlJqRFdTajh5SmxZWDRKZ1pBTmFIZU81TUsrRWtq?=
 =?utf-8?B?QU12UEVJcnVGamJRbVQzTXNTbWYvK2NXZFZsaWRMYjFFUVFhemhjQWF1c0Qv?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2BD4F0EA65C3C419A3400C4FC95AE03@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4705.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44ccc51-5141-43fc-e189-08dc28858c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 09:08:43.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VyRaHNyYcwbwS0yAWbaL+zjujoyVI/1OOJb2tAtEBqf9g7nyZ8gN89IguXFkr0xt/d0mzqVpp9K+jPKX+/wGYc4VnBpG36FVUpOMsXdPu95/7qVZo2ynFCsWKy7cstx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8344

T24gMDguMDIuMjQgMDk6NTAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IFRoaXMgZW1h
aWwgaXMgbm90IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJl
IGNhcmVmdWwgd2hpbGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJl
cGx5aW5nIHRvIHRoaXMgZW1haWwuDQo+DQo+DQo+IE9uIDA4LzAyLzIwMjQgMDk6NDgsIFBPUEVT
Q1UgQ2F0YWxpbiB3cm90ZToNCj4+IE9uIDA4LjAyLjI0IDA4OjM1LCBLcnp5c3p0b2YgS296bG93
c2tpIHdyb3RlOg0KPj4+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20ga3J6eXN6dG9m
Lmtvemxvd3NraUBsaW5hcm8ub3JnLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0
cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4+Pg0KPj4+IFRo
aXMgZW1haWwgaXMgbm90IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxl
YXNlIGJlIGNhcmVmdWwgd2hpbGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMs
IG9yIHJlcGx5aW5nIHRvIHRoaXMgZW1haWwuDQo+Pj4NCj4+Pg0KPj4+IE9uIDA3LzAyLzIwMjQg
MTg6NTgsIENhdGFsaW4gUG9wZXNjdSB3cm90ZToNCj4+Pj4gQWRkIHByb3BlcnRpZXMgdGksY2Zn
LWRhYy1taW51cy1vbmUtbWlsbGktcGVyY2VudCBhbmQNCj4+Pj4gdGksY2ZnLWRhYy1wbHVzLW9u
ZS1taWxsaS1wZXJjZW50IHRvIHN1cHBvcnQgdm9sdGFnZSB0dW5pbmcNCj4+Pj4gb2YgbG9naWNh
bCBsZXZlbHMgLTEvKzEgb2YgdGhlIE1MVC0zIGVuY29kZWQgVFggZGF0YS4NCj4+Pj4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogQ2F0YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vv
c3lzdGVtcy5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBDaGFuZ2VzIGluIHYyOg0KPj4+PiAgICAtIHNx
dWFzaCB0aGUgMiBEVCBiaW5kaW5ncyBwYXRjaGVzIGluIG9uZSBzaW5nbGUgcGF0Y2gNCj4+Pj4g
ICAgLSBkcm9wIHJlZHVuZGFudCAiYmluZGluZyIgZnJvbSB0aGUgRFQgYmluZGluZ3MgcGF0Y2gg
dGl0bGUNCj4+Pj4gICAgLSByZW5hbWUgRFQgcHJvcGVydGllcyBhbmQgZGVmaW5lIHRoZW0gYXMg
cGVyY2VudGFnZQ0KPj4+PiAgICAtIGFkZCBkZWZhdWx0IHZhbHVlIGZvciBlYWNoIG5ldyBEVCBw
cm9wZXJ0eQ0KPj4+PiAtLS0NCj4+Pj4gICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3Rp
LGRwODM4MjIueWFtbCAgICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPj4+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3RpLGRwODM4MjIueWFtbA0KPj4+PiBpbmRl
eCBkYjc0NDc0MjA3ZWQuLjZiYmQ0NjVlNTFkNiAxMDA2NDQNCj4+Pj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwNCj4+Pj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwNCj4+
Pj4gQEAgLTYyLDYgKzYyLDI0IEBAIHByb3BlcnRpZXM6DQo+Pj4+ICAgICAgICAgICBmb3IgdGhl
IFBIWS4gIFRoZSBpbnRlcm5hbCBkZWxheSBmb3IgdGhlIFBIWSBpcyBmaXhlZCB0byAzLjVucyBy
ZWxhdGl2ZQ0KPj4+PiAgICAgICAgICAgdG8gdHJhbnNtaXQgZGF0YS4NCj4+Pj4NCj4+Pj4gKyAg
dGksY2ZnLWRhYy1taW51cy1vbmUtbWlsbGktcGVyY2VudDoNCj4+Pj4gKyAgICBkZXNjcmlwdGlv
bjogfA0KPj4+PiArICAgICAgIERQODM4MjYgUEhZIG9ubHkuDQo+Pj4+ICsgICAgICAgU2V0cyB0
aGUgdm9sdGFnZSByYXRpbyAod2l0aCByZXNwZWN0IHRvIHRoZSBub21pbmFsIHZhbHVlKQ0KPj4+
PiArICAgICAgIG9mIHRoZSBsb2dpY2FsIGxldmVsIC0xIGZvciB0aGUgTUxULTMgZW5jb2RlZCBU
WCBkYXRhLg0KPj4+PiArICAgIGVudW06IFs1MDAwMCwgNTYyNTAsIDYyNTAwLCA2ODc1MCwgNzUw
MDAsIDgxMjUwLCA4NzUwMCwgOTM3NTAsIDEwMDAwMCwNCj4+Pj4gKyAgICAgICAgICAgMTA2MjUw
LCAxMTI1MDAsIDExODc1MCwgMTI1MDAwLCAxMzEyNTAsIDEzNzUwMCwgMTQzNzUwLCAxNTAwMDBd
DQo+Pj4gSSBzZWUgYWxsIHZhbHVlcyBiZWluZyBtdWx0aXBsZSBvZiBiYXNpcyBwb2ludHMsIHNv
IHdoeSBub3QgdXNpbmcgLWJwDQo+Pj4gc3VmZml4Pw0KPj4gSSBjYW4gcmVhZCA6DQo+Pg0KPj4g
ICAgICItYnAkIjoNCj4+ICAgICAgICRyZWY6IHR5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ludDMy
LWFycmF5DQo+PiAgICAgICBkZXNjcmlwdGlvbjogYmFzaXMgcG9pbnRzICgxLzEwMCBvZiBhIHBl
cmNlbnQpDQo+Pg0KPj4gSW4gbXkgY2FzZSBpdCdzIDEvMTAwMCBvZiBhIHBlcmNlbnQuIEFzIEkn
bSBub3Qgc3VyZSBleGFjdGx5IHdoYXQgdGhlDQo+PiBhdXRob3IgbWVhbnQgYnkgImJhc2lzIHBv
aW50cyIsIHdvdWxkIHRoaXMgYXBwbHkgdG8gbXkgcGF0Y2ggYXMgd2VsbD8NCj4gU28gcGxlYXNl
IHNob3cgbWUgdGhlIHZhbHVlIHdoaWNoIGRvZXMgbm90IGZpdCBpbiAtYnAuDQoNCiJCYXNpcyBw
b2ludHMiIGRvZXNuJ3QgbWVhbiBhbnl0aGluZyB0byBtZSwgdGhhdCdzIHdoeSBJIHdhcyBhc2tp
bmcgZm9yIA0KY29uZmlybWF0aW9uIDopDQpJIGRvbid0IGhhdmUgYW55IGlzc3VlIHRvIHVzZSAi
LWJwIiBhdCBhbGwsIEknbSBub3QgcHVzaW5nIGFnYWluc3QuDQoNCj4NCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCj4NCg0K

