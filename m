Return-Path: <linux-kernel+bounces-129322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BE9896893
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599F228B1F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D586630;
	Wed,  3 Apr 2024 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f8Dw+r1t";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eiP5OsAH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2AA5C909;
	Wed,  3 Apr 2024 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132519; cv=fail; b=XYA0SndKDVNNf0iWhZhPuBj2Ugv6iAZgBT9iJqiy0naiTGETemvmdQFUBdNKl+RLFnd/uLv5qCcuk2VPrZAlJc59NJLDGKC9jy1kzw7WAqQvT0H6n6KCnoZnOAgY6rBTCK7EYW56Dt6AQEjfIc7Er1RNfM8cnTE7SngCYW2H0Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132519; c=relaxed/simple;
	bh=A3jwPI551pCL3d0vT/GkzSMndyOIwO/+RZb8HZzY7pc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cqdYJskiJg09oPih3AcbMK20VhBabl7C+DI8KqjruN7GO/bvWVaUcgdG65g4WOk31XM3V1I/3Alh44fBSjBCrxA0/sjTnLn4UZoosb7nZ3qSBzMierp0tJQkZjX6J6mzwERVFLxExUx9Hs850mBzzTmytoXVMLYg2KStYT384xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f8Dw+r1t; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eiP5OsAH; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712132517; x=1743668517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A3jwPI551pCL3d0vT/GkzSMndyOIwO/+RZb8HZzY7pc=;
  b=f8Dw+r1tbYjibAZ35ll0F5uqnA5oRo3vyNvsMWcd2MhqSzjwIaLV6gsD
   L4u7B7KtJqokNJg9x5GWg/21ZKcnG6adGt+xh8KOOqvppy3FsJpufXubT
   on9DEVjSeFtPxClIpn2cwsDP/vvlSgqpaKxU4vyhwv12sfl5IAyAudoQL
   eHvzVvSV++Di8A/ogPAdXj3L49mcPTsvBhQjOgEk+xVILDTUo1ma9ovx9
   fgG+rVk30/SNscn8xqhg+hA23y/eh0ANU8i2MTNsgVPOVPvgr/JvvUAo9
   Ar/lE2VY0FcQWbsw4YCUl6QIC2MNUZPgdmjsHFWjST6am2YgJmnkBoX8j
   A==;
X-CSE-ConnectionGUID: 7GBnM6L8Sa2ba4QMyAVg/A==
X-CSE-MsgGUID: btWGWTKZQKKe7nptQ0Wfbw==
X-IronPort-AV: E=Sophos;i="6.07,176,1708412400"; 
   d="scan'208";a="186536880"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2024 01:21:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 01:21:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 01:21:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmmkcTPMTidmKl8AQPXCVVhVf2QHwtoEvthLoqg6/EYfX+uq28fK7DyUEvMkh7ip00uoLZUqVeKMtC/fESU+FXjHTs6VmhzeuclS96c0Rzk+eHumMQjNQfQWqlyJZ8tPdY7Jg73l4h6hbQlGoEf6QlgVd6tUTzio4DNPfu58GS70dY+jymcQsHTtnQzyB9EkwneVl7U4O4o3EW0nwsHkAbSNwOfFt/rDiE4AL4U/QLSHoDlX0AP4YE+KoFclEa/cz9qwhJVUPnBTTM0iKQfHb2S56ZTiLSRCjGQjLLwHWNE4KMK3rGwgS7pSKnRnZmtKJivY2a47BXgSgR+os3V7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3jwPI551pCL3d0vT/GkzSMndyOIwO/+RZb8HZzY7pc=;
 b=l81+06xErpFZDvsVRmaXxooyLeaQ86tHfvV0sEYLH1eTroOxEE4ahc4IvewDy+8UJ5PpweLsDDJSw/uJAsCfGaPmnZ+0vqn4neVAtnLMIP9PSLmjzeTfEZmeZ2/Gd4HpX2wxgT9z+J/qYIHCamHPWNMFg673GLNACcoQvHehQ5ijlqKDmKD2UTTSD3RsSE+I1ybe3MyTKfSIPHZwulBQNgixvreP909ep4KrJizkJktDV2RBEgHJ9B/LF6v+dSfMge+ceL7lGQzMbTnvo4T9reapMiGeFEpjQxF9xd1qATy7ocL4Y6Y8y2TSXER5Pguy5HnQgQz7C1Qcsf6CF5ZUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3jwPI551pCL3d0vT/GkzSMndyOIwO/+RZb8HZzY7pc=;
 b=eiP5OsAH0KC4Taoh1PHuASFbRkKMT6RnctcoRD5oKhHspnT0gEU7qRwee9MD8zzstWJvwAlHdsFizZFBF04FgT7MsniKVuGYNAwPIo0zLod+vn3d8hoH40hHTViK2AP5/H4rkGG8n0gO9p2V6fGVTY3ZjdIhqOLkZtcXo6VE7dg0aFRAfLcCKwFuaa2aZhFMH5O6QW6tSRcIVmH6TLApokPEbxdektZ3NVvYa9QJnKy6bMHXX2VjUVzPG+PkGRakQLz6WlhLiGaO31HXjGiaq+5roZHJe2Zi86oRVlc3TAbj8MbpnYOaVsjLHyOtmp8g76Q3jXyYv7JqBulQODNo4w==
Received: from SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 3 Apr
 2024 08:21:33 +0000
Received: from SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::9409:3a27:4eb7:404d]) by SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::9409:3a27:4eb7:404d%7]) with mapi id 15.20.7409.031; Wed, 3 Apr 2024
 08:21:33 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <san@skov.dk>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 6/8] net: dsa: microchip:
 ksz8_r_dyn_mac_table(): ksz: do not return EAGAIN on timeout
Thread-Topic: [PATCH net-next v1 6/8] net: dsa: microchip:
 ksz8_r_dyn_mac_table(): ksz: do not return EAGAIN on timeout
Thread-Index: AQHahP+i9XD11Ji5GUCtsqLAbavjgbFWNj+A
Date: Wed, 3 Apr 2024 08:21:32 +0000
Message-ID: <19d14454e8908909d22c3495ea43afc5ffb03f69.camel@microchip.com>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
	 <20240402131339.1525330-7-o.rempel@pengutronix.de>
In-Reply-To: <20240402131339.1525330-7-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8047:EE_|PH7PR11MB5818:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sfO1QEiExE8mgGYt1tZw/jtKoXUGXaMsyX1ED4qxQtve4IybzTb1Oh1+cnp41qu+5v7lWDcp/LwpYi71GnMCO+etbr+Wip5bBzRl+6XUQwgalbmKtXMKj8OHgsVKQ/cQsnuv4cex72flUIoG2A7VJwOg3fUa/ezQLjwtXCXiGp1fywnkpsKxpxiNV8gV62/+l0aoL1Ey5+5CldNATGzkq5eFYKC1KuSHI68m3mSSOJEnnJuebQbTRpnnQQlK5Naw7uk+FbzxnjRs3atRag8noxwtuSlaPk4RIBbes6N8rayQDaMFF///SGrMU19JNMCuRSafNNlK/DLIQST7u5qYul34InFoV19OurZTc1b2Y1L7fvePYcMo0nSwfIlm9T56i5QXOweATuBu5NAEXo0fwu14vwGGRcORIdB/SOCvs5t4TQrmguHwLjojh7WxU48havM0XYOQP9eQjhXoU4nbqBHd3sjfiKiHAedcTNC9oItO5Pfe/oCIa5BWhkSj6esQ4KZE6Wk1qB0mYtc1zVGZ7iVEoMnnr0NgXYwYMwTeL+NFsRXR8VPwsu4osiRAwWHqj5jV0SCYA0fg7d03wUguSH9xstlEWgoUKKLEb0bchlabJyhTCEJGeCDqRY80GkClZZv0kpMxmTRMoNAE3cTsLVZbjJP54T/uBtM9KHxsmM4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emlCMGt1SlJhWW93TEdzZ1F5VktRU25DaEdEbW9uTXRpbGVJMFhPNXdEUHRv?=
 =?utf-8?B?QUhVZGpRYXZDVGJFQXp5L3NWbTBTYUExeisybHlWc1VPSEducFFhN0QyQzdE?=
 =?utf-8?B?Tlhnemk1ZUNFTk9BL1FOazllaHBRN3FGMExOR3dYOU0weUtlZVRnS0Y1N3Ar?=
 =?utf-8?B?N2dEQXB6ZFM2TFJiS0d2b3RYeHBtZysySUFuQTg1VS9YN25tVTJTNG10a2ps?=
 =?utf-8?B?UElmZlQ3QTcrbWo0U2VWdkdSWUh3Y1pLZ2kvblZldWt2Tm5HWjBzVEhBTlZa?=
 =?utf-8?B?ejlIa2xmbHRJVEtVRlFSUFBUL2pobldWWWkwcmhkM0xJbFhESlBvcy9zQnRH?=
 =?utf-8?B?blJtWktGNGtXK2NkdTJTV0VWQWxVVXlKdFZkMGtjeTdBRUpjZTA0ejAwcWhw?=
 =?utf-8?B?ZjdpN2FHZXBDN0pXMExtKy9YOENXWmpZVDBxU2syREhJaTRJdndUSjJ0K3Rn?=
 =?utf-8?B?WVVETXplN3dOWmlLMmFVVWJ6eVNMNTlrQlg4aCttTWo5NXFLV05kL245Mm5l?=
 =?utf-8?B?TytORGVDYWVQM21PSlZDN0M0alpPVFNxRkhMT3dVM1FzRDZjYUUrQmw5dGFK?=
 =?utf-8?B?YXNSaUtYK2pmOUN1aFBPN1hDNktLVnRoTEJXcndISzlPdmdYLzY0U0hkQ3hl?=
 =?utf-8?B?RkNaNklOdzRmUWN0NHoxRXdXOG41RWp6YVhyNFpCM2Ezb2FXYWdZcmMyOExW?=
 =?utf-8?B?Tk1EeXEzVmhVM3JUcDgwdjVWT0tIUlgzQ294ZHNXWUtiYWw0L2M0SENMRUhu?=
 =?utf-8?B?dVd5TTFiWUZaRVVnZTh1ZmNrQ3dlWE5ERVpSYkxCOTVtYlFnb0NjaUIzRk9l?=
 =?utf-8?B?U283Tm16WHBVNGYyR1YwSG9odmdMUkZjamd0Vy9jQXM2YytTV0M3U0FCcGxy?=
 =?utf-8?B?bUlCMTREdHE3QzFWaGlHWUphTkFTODdQcy9YRHplWTFCa0VnTVlMUWkzK2I4?=
 =?utf-8?B?RGkvaDlEdVZENEljM0NoWkNucjNITnZ3M3ZBK2V3b2l2ZXZXblR6WHh1N2V6?=
 =?utf-8?B?Y2c3RktQa2xkdmRzWVJSTldEbmo4VVdJdUd1YTgrWllsTTJaRG1UNTlONS9J?=
 =?utf-8?B?dGJ2dHYzZzBJUGR4dDU3Ty9mUGQwOEZVcXM0M1YveUtjWklGSUJidjhpTzFB?=
 =?utf-8?B?UkxlMXVaS1ZlTkZWbmp4aU9pY2lNWXZaamFJMEpFbHA4VHdCWTFvUVZCaU1n?=
 =?utf-8?B?U3Bnc1JNOEY1RmZOd0VjMVppdHlQSTZRdG1IMWRDMWo4bVdrUDZ3bkw3NmVm?=
 =?utf-8?B?V0ZYQS95OTR2ZHdHNU1wMDc3UkRSdmJsNkJFRFB3S1JVYkhldy9TWkFFVDR4?=
 =?utf-8?B?SnhNZ1l0K3ZIbGE4b3hBbGRSd1RYcmMvN1ZNQmtsZG5RcXd3a0Foek9KNUdp?=
 =?utf-8?B?bGpKRm03bmxGcm1aOWkyV09kaFJ0Ymg4eWZFMnNleW1ud2MyV0xwc3lMWk1W?=
 =?utf-8?B?d0FVeVFHbDJqS0swZnZlcWdwTDRhbWZsbDlpbHJDWFpyV2F2TkRzRmhCS0I4?=
 =?utf-8?B?SmZjemFyNnNsaVl2Tm0zSW9MdkxLZCtUbjF5dlFCSmlVeUlldVRQeE5sekpi?=
 =?utf-8?B?LytJRjYwQldrRWtBZGJBSnJqQ1h0dnpPR0tnM3pZUUlYS3RHZEVkQ1k5T1Jw?=
 =?utf-8?B?QkJJeXpXUG4wSVQ0bzFRbDMweVNFVWpEaXF2UzduZmVvdXRJZUZVeDNkbndK?=
 =?utf-8?B?YTBjdGF0SEJ1aERYb29BMWhzbitpR2VxVEk5R0lhdFlrMDNscGVHekMyL2lI?=
 =?utf-8?B?NE4xOXpHcGE4akEzZWhnTnZHTHBWajQza0VGNFNDTGZNVmZvMU8zK2c0ZzFQ?=
 =?utf-8?B?ZHh4NXArbStGRitoaXhDWHB4eVVyTHkyR2RvdWFpUHNqa2J6RFJRK0gwYS93?=
 =?utf-8?B?MzlydDJXOS9wblVvekhNRjJpaE1ySUJFWWMwOVBWczJtdjk2ZGtlMWNCaVlV?=
 =?utf-8?B?WVZSekFDSU0yTmRTaDk5UVp4ZTloMFA1aVV3MFlWbDB6SGJDTmZPZm85MDhW?=
 =?utf-8?B?cFcxQjdzTVF5RXRibmJYQ3VEdGZZRy9sUVgxNTYzTkY0WnZyTmtYVkNXWGNr?=
 =?utf-8?B?YlRCaDQ1TUZra0pGcnZpV1ZHQytJUENWeWNCRnJqK3NjWE5ydUV1SE1lbmp1?=
 =?utf-8?B?SWRsTTU5aWJIZDBsaXFEV25OU09RQnNzVERZU0dMWlBxNVM0UXBNRUh4OGJ5?=
 =?utf-8?Q?72yj/HWNBpv7gq8rGibfe4c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BD1CCD4ACA8FC44B79EFC1F679F0F3F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daad14d-5052-4f1c-5c8f-08dc53b7123e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 08:21:32.9377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbQLFRhAOf7JZ+5bC3mdxeMy5s0GJD1djCVo8P8GC7vDATkPxGw1WGuP3zu0q6bCG0/Pk5kiPVTT1pB0ZDx9kjlG1/WtGHBXAXpKRzxVLfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818

T24gVHVlLCAyMDI0LTA0LTAyIGF0IDE1OjEzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBFQUdBSU4gd2Fz
IG5vdCB1c2VkIGJ5IHByZXZpb3VzIGNvZGUgYW5kIG5vdCB1c2VkIGJ5ICBjdXJyZW50IGNvZGUu
DQo+IFNvLA0KPiByZW1vdmUgaXQgYW5kIHVzZSBwcm9wZXIgZXJyb3IgdmFsdWUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQoN
CkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQoN
Cg==

