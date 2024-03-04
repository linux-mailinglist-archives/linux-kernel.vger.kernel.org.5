Return-Path: <linux-kernel+bounces-90044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7FD86F944
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5191F217A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA28C79F4;
	Mon,  4 Mar 2024 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oxrTid9P";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mvFA29Kq"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985679C4;
	Mon,  4 Mar 2024 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527037; cv=fail; b=aWDeyVxR/fqoTlvfCX2xXWliiidK9rAxPmlp0WbGDMAq2kZ2ddQ2fBMSVfbxPm9xbCwbQzDdilgDQfwn1QgFhhgOFu3OqiuVbYHLm/uegNCPPvikwiJ7aZ8J+NErRiU1a7jgb34niLBDFdubhJwLfJkK2kIW+hBKG52N2sHUlp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527037; c=relaxed/simple;
	bh=cyQsGkqQJ6hGs+AVZzOKRrplzKrsdH/n4fR825mRdVs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kBAxiP2x792xxg6EA8YrROdMnBekYGI/X+rWv6JzbNtK2+cVMHrIDDl6FXBHRsZSFUkaMwh9gEJdtjdSQsGmroicXQ6hjbBiTTQCzPG7BKs7oxSQzy5tbG8UiYqWburR6NpnmPCa0EgCGZUNcAmUG4nHI1sMrCD1BKGkx+MxuzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oxrTid9P; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mvFA29Kq; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709527035; x=1741063035;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=cyQsGkqQJ6hGs+AVZzOKRrplzKrsdH/n4fR825mRdVs=;
  b=oxrTid9PbWX2miuTZ0c2kO7u+gQL8W1NyU0fIcZVqOQjJTscsSP9yyuz
   AROZ7wZ5BnIT7HsVv1Hs3GPondedISRfiKQFXIr/tBzxWV0GG0Y9URa5d
   lEfe1MPxpmozxujbqRndIulOkdNJwm3lGwlVeM2GnQn5FbPCf+YGjESMM
   SqCHLSqyDmWDK7Kg7iCmgRkbVgbKNZzU0ejh8FKgEh/ItBkdgrA3lKZHd
   7owrF6B7D6vurZtt3urpGhoUBvgqH4kqdVdHuON8gmcxBTaIM3HBkT4to
   +r7GYQvo5xKDyhmP3AyQdbUMHI8WWuXp8VW4Jia9pTusNlK6eEtJlEZ2U
   w==;
X-CSE-ConnectionGUID: 77hhtO1wRdyN3mFOjigOQw==
X-CSE-MsgGUID: tng6edZDRy6HxijsPHb9Tw==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="scan'208";a="17139474"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2024 21:37:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 21:37:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 21:37:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4gyx3nVrU0lie+adwa89cGsA850DhIRZY8yyE5RQWxmmbTLY9snuPEWSYDEdh/X4yPCuEL3Culue9SRJWz1/g6gzvq0mQ47jKTRUQdXMCd58VpPt11XHZ7X6f6RQfVjuWL6u4mEd68dtlL0EeAQoAat/4bowVu6t912NGhInXwO8Kk51LVW5NI+Vl5Wh9B98YGF2Tngtjv/CoU4EDYzoSXZwpElf+WFgd9gebNJwvxRSo1EbgywRRIJyzhsOKVIVprKIdnwSQbNn2D31tUzHwIwZImnwDLXydNps2rA7uHhgDcqlvw/SfVQAu9FxZKJDiOGdj2VWo/M4VEbngm7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyQsGkqQJ6hGs+AVZzOKRrplzKrsdH/n4fR825mRdVs=;
 b=bPBsTRTFIjNbL18AEFKTADrWPPkZyKNYaHZZEmxAAbxih6cYgtXP7xOBjNzeLxU/wLUzw+M4PHL/GhvcWtvcgqJg1qRa/5sxgiGUXvHq/aqn59MHxxIEJk5E1DRG5M3xp1kmKiZNgtoSQbcGgkgtIIJJ0OSEe7wLRlyC6nHk1ceUhCTK5egck1qPlzvxa6xF2+qlK7guWy9kMe5lSVQWnYADYP5KQuFDJ8WW64Mibw4KmpTySF8rRnoIdEFPO+G6QEWcD/CL8dM49VLAqofRatEu7SaYiyJ9YyFrImOyaSWeHfgIa4F3gjpQZd17kwgDt7cy8m6m9mH097ESrcI4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyQsGkqQJ6hGs+AVZzOKRrplzKrsdH/n4fR825mRdVs=;
 b=mvFA29Kq53+q9iNwXJemjtAHZVIlg/9WxMpoL0LCdWUanakpTc4Lgt8CGXtzdv1PCh0Ppg1IIb3PrkcWgRcCj6YLxlzYd+a6lQUldDn7O+ufGgVlxXMJWqfcYrGUi/Jy3kNgMVV1h4NalBhS7uDmKwZZnQC+V9FkKptYYgrXbL8u5wGwfO6oY+lBUJ4YQwKXrr5vxVIcEKEk4RmTS4PZzt/Vyr3jkMtD1jlzR3fuhNkdYMrgk+29zdJlxsio9gWjkgGVjX2s5shYnugLAVBQddhhjw5ylPt98Tq3dIjGQtJbxM2bft4ArY7SDRKZMjDhgXS4eaLfwuhhdCpZ6eLFew==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by IA1PR11MB8174.namprd11.prod.outlook.com (2603:10b6:208:450::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 04:37:12 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::29:ed7f:de5a:55bb]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::29:ed7f:de5a:55bb%6]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 04:37:11 +0000
From: <Rengarajan.S@microchip.com>
To: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <Kumaravel.Thiagarajan@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <Tharunkumar.Pasumarthi@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Topic: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Index: AQHaZZZL0nj0fFzSz0iXzZOI5AQ+c7EXclSAgAA2nwCAAACkAIAPZ0qA
Date: Mon, 4 Mar 2024 04:37:11 +0000
Message-ID: <53dd0d89466f0f06dfd2d63ab1ff29462a09aabb.camel@microchip.com>
References: <20240222134944.1131952-1-rengarajan.s@microchip.com>
	 <5bf4ba6d-d8e3-4ba6-a889-cfae8c3ddabe@kernel.org>
	 <e93048e64c3f8aa2731575d4b296c473e8dadb82.camel@microchip.com>
	 <254db026-5f9d-497f-ac44-c81d9d5947cf@kernel.org>
In-Reply-To: <254db026-5f9d-497f-ac44-c81d9d5947cf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|IA1PR11MB8174:EE_
x-ms-office365-filtering-correlation-id: 8e171fd0-265c-4d6a-1752-08dc3c04c25e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lnugxKJpIZVHYclARIVTFU5gnddjET2ESyDmDbvxDHGmWNUpkaoP0zpRjKX4kphWGUrqb2sOPXLBffW6V5T8pi8Dp+ebCrlYYS+kCTVtf9jiLDSJKzU/Gekg4BK+NlTHFfLTujDQbhG7uUY04Ebj6YIBiPkrsliDHXTaxeX8DMApzvoN77GFAYUYJ7R6d5xkWkwQ3m+1p7Cq9knMDYMRZ2kVpruSlPfnmRGhrFXB91TTvv/LeCCDN0FURrm6qtB6b7L0bOwsBnkIVMGh9xN1UXbKfTsqsbwug/ttkHWiiRdCsZnD7q6wX5sWaE3+pg21v96zwU9KO3MJex0qiBS9stk+bKE+EEshf0P+6qvsnLIcWU6BXt/JGGswcdH8MQIw+Yc3fwxfHkmFORV5KEw4Wr5gAHSXk4i9swN5G0aAdZMpMPSmRv4pZo627TdqSQu3iCUrE7ybdD3n/Wr/aRKZGvDMGKZ+qKTSxE9SvJwljUDrMGQA9lpPQgeELJlLxTNFKU48wPK6TJa4nqHDE3rtC2GRlbauqOTzc0wbtaYdQAiq3m1sfbBfTsgn7uAgwvom3NMbuXPZoQjWf22CGzehI4ZPIwIlQW6XkIdEfksogWs9syKCjCYzxNoMirDXzLatgWLFfg2LlQvZay/MQ/IjyUOy9oMG2+K/wxNfJY27Huc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2NPNHc0UXVURlFmTjZSdWxOV0ZFNHVTeEpYekdqV3dIWHV4dXo5cDVWVDR1?=
 =?utf-8?B?NHNXMkJ6RXRSQkN6WTlyQkQranRDVllGVEt1VG5JWXNzSmFYUE9GSDhBejZI?=
 =?utf-8?B?d3JtQ1FLd1hGOVY0STlPeUVDQUhULzd5c1Bhb3ZuUitJMEQrMkk4TXc0SjQ3?=
 =?utf-8?B?MmRYSjdYQ2N3MW5pR3MySzBXVElISGxCNlhZazJpNkRXcGplL0lTL0NkYTQ3?=
 =?utf-8?B?VENSOW9aeXpkTHdLQkZpdlc4Z2hIZGNsZHV5dmtvbGgzWFZLRmsrMVAxYUxH?=
 =?utf-8?B?SnJCNUlNQ0Rvbnl4MFdlTkFXVkFtQnlGeTNNZDVDK2JNcitRaWovbmczbmJk?=
 =?utf-8?B?NzA4dGNDeXNldUQrRDRKN3BaUzdnVnRBMTlwRnBpeVBDSFpYWUZSVXNlcnJ1?=
 =?utf-8?B?WkRiNzFud2pYVnVyQk12ZUM1aUprc2E1UThid09XNml3M3lmM0FKRTZXUy95?=
 =?utf-8?B?MUNQMUpqemhsN0xKUGtuMC80UHU0S0xITk13YnFMOXh2eHYxcjZVUzFvczJl?=
 =?utf-8?B?ZGlldWIxQjYrbkxzWXNPMEQ4eEFrK04zV0dMaGZiVTBBTytrZmQxbTdSV25y?=
 =?utf-8?B?ak41SndNUkVidGoxWXV0a25NNS9EcFdpU3R1Qmc4RW1scTJsUHJtWHNEU0Zp?=
 =?utf-8?B?bzZSdW9WbkVVTW1BT1JuVWRNSTVUWFIrM2J6VnRtdTZTYnRSazRweDFmZUJU?=
 =?utf-8?B?Z1h6akhRKzJNZXlTN04ybFc1RlFmdGFhVVEwbGtEY2VWaGJ5ajJORUZkUEpk?=
 =?utf-8?B?L0VkQzJJL1Bkbk11VFJHcTVyK3p3WFNnK0FmK2NtR3ZONnRCTXgzblNidy8w?=
 =?utf-8?B?RDRiNjgwYTNXS1I2c2ZnSWFROGpGbXVMZk9FK3M3bkRWK2pUcSt3TktDU0oy?=
 =?utf-8?B?QjBXNE1wSUJoaXlZaXpsMmxhNTk1ZklOMC9pQWY3Y1VXdURhMVVSNlNuYWQz?=
 =?utf-8?B?bzE1S0h6Vk4zck1nN0ZnUEpRYkdiRVkxL29nckx3SWZOdEE0UHJXUElsVmxp?=
 =?utf-8?B?RFJUWG95cWV4dldsNHIzdS9vZDZyTkdQZ29zcXo2L1hyR2pleEU0VHk1cVJT?=
 =?utf-8?B?T3dZZW9Qc05YOXVybmF4QThNdVMwbjlkMFRvVjVyakoxN2xMQ2ROWmZjajhl?=
 =?utf-8?B?WmJWTDdWMWFOTU1wN1RVOEdTMngxRjN3MDNCZkE5NnBKTCtuMXFqSEw5Ykov?=
 =?utf-8?B?Z3R5ZW0vN08vTndDTlYvTGFwV2l1WWxINm0vY0JjaUpIcUVuTWxHZGY4TGp1?=
 =?utf-8?B?MVJIQ3d4RW1nWGRNRm9DSEdqMWhpc1pVelZhY1JUekd2dG9EWlVHUW1sNWJu?=
 =?utf-8?B?VDdGNW9JU2orblpIcjEwOWdJMmNreGNTRmlmaEtZNmxGZEVSZ21ZcmpBY1c2?=
 =?utf-8?B?aHkyMXY4UDNGWmxtYTUzYXNWRlVRNWhDdWk2aFpSTTc4bC93dVRaSlBLWkpr?=
 =?utf-8?B?aWlYNHUwRDFyNlI5NTFIUllMSEN3SndNY1J1ZFRDK1Z5NTlaRE0rcGFSRzJi?=
 =?utf-8?B?SkIrZS9XNkZ1R283SzB2V1N5QmxFeXJaUlFlNlUrMncrTUFwWVNOM1FhcXBy?=
 =?utf-8?B?WXl3Y1hDc3FHam9LVU5RYThKTmk4RUpqYms3b0oyb1dDOUJSVEQxUjVBeWcy?=
 =?utf-8?B?Ukk1cUhnVTBHb05pQ0cxOFRrSTJrbTY5WmVHakJkRGx4TzRNVnJBTFpiRVp4?=
 =?utf-8?B?MnB6Z0NMWVRNV294KzV1aUFkRXhvODlaQS90LzJESmJ3NGlDVUw3cVorcnhl?=
 =?utf-8?B?QjM2VjJNRjlwL0tjQmVPazNoWFl2L09mYVRyQ2g0OWY3cG04OENMdndxZmZB?=
 =?utf-8?B?bmY5TXBNaUtLbDU5UDF0c1pGRUJ6eG15Tkx4ZVFLL09aNFdxUTI3MWl2WFI2?=
 =?utf-8?B?RTQ2SjE3YWlkRFd1Y0NRRTl1QkpwKzVGNTM3MEpjcVo3cDVEYXVGeE5LaHhK?=
 =?utf-8?B?OW5FeXhnblRVbElGbXZaOXZZdTVxeFhUM2FjQ1FvaGw4MFZwYmpHMXhSakNH?=
 =?utf-8?B?UG1RMDM3dE4xZnozbjEycVAvM0Z1YVpQdUVCMUhraDRKVk8zQWpqQUYyYkpu?=
 =?utf-8?B?dnAzODhwOGNtRWVuVXhBNWMxSVlxbjYrY2U4NjZicHpIU2I4OUFNdXNpOC9l?=
 =?utf-8?B?M2UrcDJEeFFIOFBHc25FbGUzeStrZko2Ui9GTDVidkt4Q0VPQThsaGVibURU?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15AAA812306F4440B1A6F92D90C4B86B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e171fd0-265c-4d6a-1752-08dc3c04c25e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 04:37:11.7747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjs3rOztButPLGKDjuM1NCGEZJ2BCG4cvj8sfBTJvWpyB1u+fBYSEJ8ovIsIgNxhiwb94qVpZhEpXvalmHLxmLbopYxch95nZ4UcgqbI4DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8174

SGkgSmlyaSwNCg0KT24gRnJpLCAyMDI0LTAyLTIzIGF0IDEwOjI2ICswMTAwLCBKaXJpIFNsYWJ5
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9u
IDIzLiAwMi4gMjQsIDEwOjIxLCBSZW5nYXJhamFuLlNAbWljcm9jaGlwLmNvbcKgd3JvdGU6DQo+
ID4gT24gRnJpLCAyMDI0LTAyLTIzIGF0IDA3OjA4ICswMTAwLCBKaXJpIFNsYWJ5IHdyb3RlOg0K
PiA+ID4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4gPiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+ID4gDQo+
ID4gPiBPbiAyMi4gMDIuIDI0LCAxNDo0OSwgUmVuZ2FyYWphbiBTIHdyb3RlOg0KPiA+ID4gPiBV
cGRhdGVkIHRoZSBUWCBCdXJzdCBpbXBsZW1lbnRhdGlvbiBieSBjaGFuZ2luZyB0aGUgY2lyY3Vs
YXINCj4gPiA+ID4gYnVmZmVyDQo+ID4gPiA+IHByb2Nlc3Npbmcgd2l0aCB0aGUgcHJlLWV4aXN0
aW5nIEFQSXMgaW4ga2VybmVsLiBBbHNvIHVwZGF0ZWQNCj4gPiA+ID4gY29uZGl0aW9uYWwNCj4g
PiA+ID4gc3RhdGVtZW50cyBhbmQgYWxpZ25tZW50IGlzc3VlcyBmb3IgYmV0dGVyIHJlYWRhYmls
aXR5Lg0KPiA+ID4gDQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gc28gd2h5IGFyZSB5b3Uga2Vl
cGluZyB0aGUgbmVzdGVkIGRvdWJsZSBsb29wPw0KPiA+ID4gDQo+ID4gDQo+ID4gSGksIGluIG9y
ZGVyIHRvIGRpZmZlcmVudGlhdGUgQnVyc3QgbW9kZSBoYW5kbGluZyB3aXRoIGJ5dGUgbW9kZQ0K
PiA+IGhhZA0KPiA+IHNlcGVyYXRlIGxvb3BzIGZvciBib3RoLiBTaW5jZSwgaGF2aW5nIHNpbmds
ZSB3aGlsZSBsb29wIGFsc28gZG9lcw0KPiA+IG5vdA0KPiA+IGFsaWduIHdpdGggcnggaW1wbGVt
ZW50YXRpb24gKHdoZXJlIHdlIGhhdmUgc2VwZXJhdGUgaGFuZGxpbmcgZm9yDQo+ID4gYnVyc3QN
Cj4gPiBhbmQgYnl0ZSkgaGF2ZSByZXRhaW5lZCB0aGUgZG91YmxlIGxvb3AuDQo+IA0KPiBTbyBv
YnZpb3VzbHksIGFsaWduIFJYIHRvIGEgc2luZ2xlIGxvb3AgaWYgcG9zc2libGUuIFRoZSBjdXJy
ZW50IFRYDQo+IGNvZGUNCj4gaXMgdmVyeSBoYXJkIHRvIGZvbGxvdyBhbmQgc29ydCBvZiB1bm1h
aW50YWluYWJsZSAoYW5kIGJ1Z2d5KS4gQW5kDQo+IElNTw0KPiBpdCdzIHVubmVjZXNzYXJ5IGFz
IEkgcHJvcG9zZWQgWzFdLiBBbmQgZXZlbiBpZiBSWCBjYW5ub3QgYmUgb25lDQo+IGxvb3AsDQo+
IHlvdSBzdGlsbCBjYW4gbWFrZSBUWCBlYXN5IHRvIHJlYWQgYXMgdGhlIHR3byBuZWVkIG5vdCBi
ZSB0aGUgc2FtZS4NCj4gDQo+IFsxXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYjgz
MjVjM2YtYmY1Yi00YzU1LThkY2UtZWYzOTVlZGNlMjUxQGtlcm5lbC5vcmcvDQoNCg0Kd2hpbGUg
KGRhdGFfZW1wdHlfY291bnQpIHsNCiAgIGNudCA9IENJUkNfQ05UX1RPX0VORCgpOw0KICAgaWYg
KCFjbnQpDQogICAgIGJyZWFrOw0KICAgaWYgKGNudCA8IFVBUlRfQlVSU1RfU0laRSB8fCAodGFp
bCAmIDMpKSB7IC8vIGlzX3VuYWxpZ25lZCgpDQogICAgIHdyaXRlYigpOw0KICAgICBjbnQgPSAx
Ow0KICAgfSBlbHNlIHsNCiAgICAgd3JpdGVsKCkNCiAgICAgY250ID0gVUFSVF9CVVJTVF9TSVpF
Ow0KICAgfQ0KICAgdWFydF94bWl0X2FkdmFuY2UoY250KTsNCiAgIGRhdGFfZW1wdHlfY291bnQg
LT0gY250Ow0KfQ0KDQpXaXRoIHRoZSBhYm92ZSBpbXBsZW1lbnRhdGlvbiB3ZSBhcmUgb2JzZXJ2
aW5nIHBlcmZvcm1hbmNlIGRyb3Agb2YgMg0KTWJwcyBhdCBiYXVkIHJhdGUgb2YgNCBNYnBzLiBU
aGUgcmVhc29uIGZvciB0aGlzIGlzIHRoZSBmYWN0IHRoYXQgZm9yDQplYWNoIGl0ZXJhdGlvbiB3
ZSBhcmUgY2hlY2tpbmcgaWYgdGhlIHRoZSBkYXRhIG5lZWQgdG8gYmUgcHJvY2Vzc2VkIHZpYQ0K
RFdPUkRzIG9yIEJ5dGVzLiBUaGUgY29uZGl0aW9uIGNoZWNrIGZvciBlYWNoIGl0ZXJhdGlvbiBp
cyBjYXVzaW5nIHRoZQ0KZHJvcCBpbiBwZXJmb3JtYW5jZS4NCg0KV2l0aCB0aGUgcHJldmlvdXMg
aW1wbGVtZW50YXRpb24od2l0aCBuZXN0ZWQgbG9vcHMpIHRoZSBwZXJmb3JtYW5jZSBpcw0KZm91
bmQgdG8gYmUgYXJvdW5kIDQgTWJwcyBhdCBiYXVkIHJhdGUgb2YgNCBNYnBzLiBJbiB0aGF0DQpp
bXBsZW1lbnRhdGlvbiB3ZSBoYW5kbGUgc2VuZGluZyBEV09SRHMgY29udGludW9zbHkgdW50aWwg
dGhlIHRyYW5zZmVyDQpzaXplIDwgNC4gQ2FuIHlvdSBsZXQgdXMga25vdyBhbnkgb3RoZXIgYWx0
ZXJuYXRpdmVzIGZvciB0aGUgYWJvdmUNCnBlcmZvcm1hbmNlIGRyb3AuDQoNCg0KPiANCj4gdGhh
bmtzLA0KPiAtLQ0KPiBqcw0KPiBzdXNlIGxhYnMNCj4gDQoNCg==

