Return-Path: <linux-kernel+bounces-94222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DFD873B99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA2728B1FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC76136668;
	Wed,  6 Mar 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="e0UIraOr"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973CA136647;
	Wed,  6 Mar 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740927; cv=fail; b=Dd57anr40MlLAvegtWHjRGZmBCpfT7E5V/R5XaMDJgJK7ooCJHtqeIJjdB0gWuJ7qdxLRiHBf7TCBGM9DuzUADMU3L4MD+R8zDlyoYukVFJhOTJ/GxLrytwr+oTFTa+TEOJ2szvgMl3HGTN+nnbMrCjAcJq58GvP8JN/qxRXuso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740927; c=relaxed/simple;
	bh=HxtvtGzkZ+gx1Fefr4j5VjeDYOmaaSBWLBOn73Efke4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=taXFODwog9+dI9wSMErEyV/u7kH86NuFr++sF4W2IkCzhqqlTdHVyIaQsb6Gxa/XCDBYpFYUKoyUv1HWY2sJOLn1sBy1T4UYGnazc/+tVSDmwn5QON4/466URgTfj6MSHgUp0pBkGr6K2kQp6Z0F86PcmQTji5aL3IzmtXkff4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=e0UIraOr; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4269p7Gt005433;
	Wed, 6 Mar 2024 08:02:02 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wpp7bh95y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 08:01:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7AjcXzubByKMhhGDRbZtroIqVlFtPYcTnOrlzEscuakJpHoFjZ863ng/IKo5WZeHHoFmrXHcWS48/MzEI6579t4sQiboh95a+9BNx52WXoGrQA7UJxsA/GkhF0ZMKJ2sVakh92h+izEzha2u6CeVSeHXYhnI5rUvcmmFlZItWYw6L5tmTQD0DOLuaajnk0S2ro5Mo+vJym++rawgEn80PqBPPCJsOJFEIvOpY3eTGoV2Oavv0DO+86OunyTqJpd2oG2LBAJ17qTZNIfylr3UuR1jBYRg2gtBHrDZ2m3FJlajjiuzR/KVPrjT9DYh/WQ5gnfklGMqKGSrvim6qabbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxtvtGzkZ+gx1Fefr4j5VjeDYOmaaSBWLBOn73Efke4=;
 b=P53TQ+69YOegERwDtFSRXXeguBM43FaH6brWAqFPJhkqkWImvlM09TfMiXqZg9ie3/b8P7sf1ju+v1glbItUhCkFjjjrcnKwmCbLnw20sdS9HSmHgM1SlcM5BIxNJhP9pMxNmyfzpPqgCSlOLEuCUxTXX2yiG2uFa5ZaZQTkaGJE47nFYjnCO2uElwgdwE2Ddvhjq9UdEuo+GTg25UMf0E1PS6Tn6jUXgIOLEbb0noSiYgBdVfwed4YZ6cibGggnR3K0AIvs+BBQHwJHrDzXFl+3JYCJn5X+GLWuj46Nf69q09OcAZ3qf9zq0W0zHRt38TIrqsOQR7TI0gOBHcWe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxtvtGzkZ+gx1Fefr4j5VjeDYOmaaSBWLBOn73Efke4=;
 b=e0UIraOrsh8Y94bulvewOfmrBc7T3o7SZ/MsSPlzFTyk2S+csYlAteN+IxvmoCrsQJ/8cG7+X29NdcnM955weASdH0HSQV+ZDxRVPPYe0vjyAOPiGwXlYBoMhxs4wMXLJMZ6XkHZYhlPAZhRORE0QE1QiYUc58wVaKPlvktTdZA=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by MN2PR18MB3655.namprd18.prod.outlook.com
 (2603:10b6:208:260::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 16:01:49 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::89ce:35b4:c4b0:c7ad]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::89ce:35b4:c4b0:c7ad%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 16:01:48 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v6 1/5] net: wan: Add support for QMC HDLC
Thread-Topic: [EXTERNAL] Re: [PATCH v6 1/5] net: wan: Add support for QMC HDLC
Thread-Index: AQHab7T+VZwBD2/sKUebfcwkOc5ebbEqt4SAgAAnIyA=
Date: Wed, 6 Mar 2024 16:01:48 +0000
Message-ID: 
 <MWHPR1801MB191837C8907B39F67893F0BBD3212@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240306080726.167338-2-herve.codina@bootlin.com>
	<20240306105651.1210286-1-rkannoth@marvell.com>
 <20240306143743.5732b298@bootlin.com>
In-Reply-To: <20240306143743.5732b298@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|MN2PR18MB3655:EE_
x-ms-office365-filtering-correlation-id: 68bf4297-b4af-4645-f31d-08dc3df6badb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Oi1kPAPHYNIzu9mE6CFPpJuLyyUWxdgNN1FwqDFOLn3xrHV41IXqVdW8mGXoiy9TJUmFE+FA/pamAYbYFYUxHEebn6V9/kyLn12lll/avPumLMpLbZgeZAJPFgUms8Vz8E+CifqRq/Yp/uHbHLC/U+sDZ9Cbyo+3tucItQnu7rsQBE6gChK32aKAtFiL6Nj4Y9oxvLv6h7AzvPPpvAEWLfNLSMiBppmMx0aTNfwKSBeNvGR+yxdk3V7XhFfCVHymJK0wm9Ush/1vzZCHIqLynjPhOKWAPQOolbRuDRkCuQopJ4hVA/tvBoFP6Dxf3ZXILuvDoMGdXR+jpfjoEwl2CzBquokQb/uM4gd6fNd5rZ/SnID7nYHPSHUBaGMx5ZnhoCjy6tIg3KigI+3ulbJL17g6V21bw+5LDRWCcBgwT41wFekNhCzdkBs4NHwuJJMdoOBMUEczLiMrllI96FV0Wk5/JMrZt9+pZJYRHW/K5x81ole6bXqG40ujWtfjVXA3jbLuwtwzVbB1ryqcgJS5mUdQ07eIpMqhG1ku8yiZ5tflq69PHNJ+jKku1Q7gGrsNzTgpCl7p3TtFdgJrSWe3G65aPYClY0z7+0LKyEPySX+5jrJrIMNftpRMy0J00bfMXEgi9NB4xCnMJTFzpEyXDAcxJTrzBEabdtzgqKX8dsQe+3oagx/w1FODiiF7sRPrqs92jitcHTJ5EJb/e0WKkfITAuZfnqF0LohlYOxfIZo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TzBXNkFZM0ZUQzFqc29lbEhwcGM0b1NodmMxYzgxYjFRSDlTS2lJUkk0dm5s?=
 =?utf-8?B?c3RzWExiRnEzOFpVVUhiQnoxTDRuWXo2UmFCTmlQbWtFbldwS0hnMVI0RVNa?=
 =?utf-8?B?RE5jZzgvaU5SL2NsRTdIS21JKzhQQjN6M05YdExqcy9mQWxMalZuTmM3ZG0y?=
 =?utf-8?B?Vkt6eFp1ZzFGSDhLMjhqcmMyWlBmVUc0dndCcFRacUFsOEJxb0FzS0tHNklU?=
 =?utf-8?B?ZmZyU2g5Q2E2RHF1dWIraTlncHRaRERlYmdmTHhsUGI2YVN4dlhjVGozMUkw?=
 =?utf-8?B?QWdySTJYV3FTbkdjV0FlNmFEdTlIcmhEd05GMlpTT0x1eVBaV0xYRXgrSVBv?=
 =?utf-8?B?MU5KUUxuNWdJU251T0p4QWIvODd6aTVTQWtLbFo3R09wWC84eDc0YmNWSTlC?=
 =?utf-8?B?M1lBM2FOSmJuMVdDZnB3UXUrTzZ4cEVsOVRmU0FnUisyVGhEWldkSnovMUNK?=
 =?utf-8?B?akJRdjNIb25NSGluOGZUK2FCT1IwcTllN2JxVEdpZEVlMkZpcmpFMUd3K0Vx?=
 =?utf-8?B?LzFjbTBXSnBVZlNpN1JLaXJaZXUzWTJ5SVRFeVYzT2N5U3UyNUFtS3FXUkdv?=
 =?utf-8?B?c3hoWDZ0dll6SGx0RzJGcEFkWUVUb1FHZUVBOFM0Vi9Cazc1U01teGJaNVlJ?=
 =?utf-8?B?OVZLNEl5U3hkRUVSU2FPYkJBWU5CQ0dJUmJlQVA1YnFQZTU5dEd6ZE1LMVhO?=
 =?utf-8?B?RW9vWDkyWllaaEhHTTdBVFhHL050SHNib3lYQktlRlM5Qi8rRHgyU2pESytt?=
 =?utf-8?B?azlRSk92N0V5dDd5K01VRjJQbnl5UldXeDVYdnZlNEZwcG1UVUhtNHRyNTVG?=
 =?utf-8?B?L3QydHpGeVg4T0p4dmJxdHlCTlNNUElhWGs1MVdTd2VCcUpOeEpQNlAyWWl6?=
 =?utf-8?B?dXBEMGQvTE9aQU1KYWl1bzlMenZ1MnhGZldhZHZXejkrcHgxeHZUME9ISmQ2?=
 =?utf-8?B?YUNpTTdxMHZ6bld0UnRRc3NtcGxacXFKRjN4WUhBb01CRThIV0g4ekhWODgx?=
 =?utf-8?B?UEowQ0NrU2h1VW4xOWFEazc2VThnd3ZrZ0pxZHhuZHNiNXBaeXFkLytoVmp4?=
 =?utf-8?B?cUJsdnQrY0JCR3gyd3BFOEY5WHA5T3FIaG1WOVVhY2U4ZmVXenNlb1cyMS9B?=
 =?utf-8?B?cUsyUWpWb3hiNXBJOWhWb0tQM1pFYUgxVnJ0NGdhN0dKd3gvRXhUNFJHSmlQ?=
 =?utf-8?B?RUNTeFJPVFhwTmUxS1dSeFNHWUdHRlYrbFZvR3luN0h6VHc1NDdZMUk4NEV1?=
 =?utf-8?B?cEp6NW1McXVyNnJKelcxVHMwT2ZSWVRicEI3aWpYN2NPekQ5dENMTW1TMmo1?=
 =?utf-8?B?L0lOL1dFcHdMZTJxS0NqRzhDUmh6a3pUYS91WFhBMVByRVdSUjRkbXdlNkxD?=
 =?utf-8?B?VUdqOG9RMTNyVlFVNU03REoreFg1SmFsdmVLRkpUZWo1S0hZVjZGdDRBRURS?=
 =?utf-8?B?dldLWHVrd2hDVlJYMkpKTzdpZWhsTVI0L2ZmUktENXpHbFRQVGx5MkJDVyti?=
 =?utf-8?B?TEtreWg3YllQNHowYXRuQXRFUHZ2S1hPNUVBOHdPOGU4bzdJTjZSalR2MDR1?=
 =?utf-8?B?Ynl4ZXBacVcyMUNiSFZRSXdDbDBqeG10VXVVLzVNTWJiQzUxbjNHOXZKRjg5?=
 =?utf-8?B?bHR3bUQwT1NVaTJDak1scnBvWjdnMUVNVHdsYThzdXJKT1JlZzFrVHlFbXha?=
 =?utf-8?B?VFFveDhiZDFPdW9HVVZZMGQ4M1Awc0JqU1ZTY0Z4NXJUdVBHKzJvMDd3ckRa?=
 =?utf-8?B?NEEybENnM1RxZFVBM2s3RThoRytCd2cxTVFsUWpORlVJRkFNODc1VW5CSkRX?=
 =?utf-8?B?cUpHa2greHZTNWxXaXlRb3VuSW5WQjFLRGlIWFJEZjNMbFIvdnk4dElPL3Vn?=
 =?utf-8?B?RHFsc1RJUW80ZHNpTGpRdHYzN0RzcmVCK1RxbTB4R1RGOG9EdHF1VGt0bXM4?=
 =?utf-8?B?WVlLUGFjOUp1V3FvVjFTaUxyMGN5REtmekxPWGtoM2Q2MkhhaUYxMCtCVXFh?=
 =?utf-8?B?c0gybWtVNGt0TzBxVTVwaTVQSURTeEdiRXJGSkhpOXNoS0ZBTEs2YzQ5MUFy?=
 =?utf-8?B?VVhJZ1FzcjdBMG5idEFqNmVLMW1kRnRkZW9nTE4yb0ZFU0JJZHFwKy9aK21y?=
 =?utf-8?Q?nbAIAm7IkWNxbTZ7bca5UXAE7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bf4297-b4af-4645-f31d-08dc3df6badb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 16:01:48.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ze2upXnNk32/1vHd6xZJ9QcvRbj47s47NRlAhiMLh4GoH/Pzis7ziKYI2F4RKpKoyunbEBzzikh/6kTJxw/i3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3655
X-Proofpoint-ORIG-GUID: UJ5msiSIbdyUf-aC1sik9Dnz4d2J5niT
X-Proofpoint-GUID: UJ5msiSIbdyUf-aC1sik9Dnz4d2J5niT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02

PiBGcm9tOiBIZXJ2ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNvbT4NCj4gU2VudDog
V2VkbmVzZGF5LCBNYXJjaCA2LCAyMDI0IDc6MDggUE0NCj4gVG86IFJhdGhlZXNoIEthbm5vdGgg
PHJrYW5ub3RoQG1hcnZlbGwuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFU
Q0ggdjYgMS81XSBuZXQ6IHdhbjogQWRkIHN1cHBvcnQgZm9yIFFNQyBIRExDDQo+IA0KPiA+ID4g
K3N0YXRpYyB2b2lkIHFtY19oY2xkX3JlY3ZfY29tcGxldGUodm9pZCAqY29udGV4dCwgc2l6ZV90
IGxlbmd0aCwNCj4gPiA+ICt1bnNpZ25lZCBpbnQgZmxhZ3MpIHsNCj4gPiA+ICsJc3RydWN0IHFt
Y19oZGxjX2Rlc2MgKmRlc2MgPSBjb250ZXh0Ow0KPiA+ID4gKwlzdHJ1Y3QgbmV0X2RldmljZSAq
bmV0ZGV2ID0gZGVzYy0+bmV0ZGV2Ow0KPiA+ID4gKwlzdHJ1Y3QgcW1jX2hkbGMgKnFtY19oZGxj
ID0gbmV0ZGV2X3RvX3FtY19oZGxjKG5ldGRldik7DQo+ID4gUmV2ZXJzZSB4bWFzIHRyZWUNCj4g
DQo+IFRoZSByZXZlcnNlIHhtYXMgdHJlZSBvcmRlciBjYW5ub3QgYmUgdXNlZCBoZXJlLg0KPiBx
bWNfaGRsYyBkZXBlbmRzIG9uIG5ldGRldiwgbmV0ZGV2IGRlcGVuZHMgb24gZGVzYy4NCj4gDQpB
Q0suIFVzdWFsbHkgSSBnZXQgY29tbWVudHMgdG8gc3BsaXQgZGVjbGFyYXRpb24gYW5kIGFzc2ln
bm1lbnQgZm9yIG15IHBhdGNoZXMgaW4gdXBzdHJlYW0uIA0KDQo+IC4uLg0KPiA+ID4gK3N0YXRp
YyB2b2lkIHFtY19oZGxjX3htaXRfY29tcGxldGUodm9pZCAqY29udGV4dCkNCj4gPiA+ICt7DQo+
ID4gPiArCXN0cnVjdCBxbWNfaGRsY19kZXNjICpkZXNjID0gY29udGV4dDsNCj4gPiA+ICsJc3Ry
dWN0IG5ldF9kZXZpY2UgKm5ldGRldiA9IGRlc2MtPm5ldGRldjsNCj4gPiA+ICsJc3RydWN0IHFt
Y19oZGxjICpxbWNfaGRsYyA9IG5ldGRldl90b19xbWNfaGRsYyhuZXRkZXYpOw0KPiA+ID4gKwlz
dHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPiA+IFJldmVyc2UgeG1hcyB0cmVlDQo+IA0KPiBEaXR0bw0K
U2FtZSBhcyBhYm92ZS4gDQoNCj4gDQo+ID4gPiArDQo+ID4gPiArCXNjb3BlZF9ndWFyZChzcGlu
bG9ja19pcnFzYXZlLCAmcW1jX2hkbGMtPnR4X2xvY2spIHsNCj4gPiA+ICsJCWRtYV91bm1hcF9z
aW5nbGUocW1jX2hkbGMtPmRldiwgZGVzYy0+ZG1hX2FkZHIsIGRlc2MtDQo+ID5kbWFfc2l6ZSwg
RE1BX1RPX0RFVklDRSk7DQo+ID4gPiArCQlza2IgPSBkZXNjLT5za2I7DQo+ID4gPiArCQlkZXNj
LT5za2IgPSBOVUxMOyAvKiBSZWxlYXNlIHRoZSBkZXNjcmlwdG9yICovDQo+ID4gPiArCQlpZiAo
bmV0aWZfcXVldWVfc3RvcHBlZChuZXRkZXYpKQ0KPiA+ID4gKwkJCW5ldGlmX3dha2VfcXVldWUo
bmV0ZGV2KTsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwluZXRkZXYtPnN0YXRzLnR4X3Bh
Y2tldHMrKzsNCj4gPiA+ICsJbmV0ZGV2LT5zdGF0cy50eF9ieXRlcyArPSBza2ItPmxlbjsNCj4g
PiA+ICsNCj4gPiA+ICsJZGV2X2NvbnN1bWVfc2tiX2FueShza2IpOw0KPiA+ID4gK30NCj4gPiA+
ICsNCj4gLi4uDQo+ID4gPiArDQo+ID4gPiArc3RhdGljIG5ldGRldl90eF90IHFtY19oZGxjX3ht
aXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UNCj4gKm5ldGRldikNCj4g
PiA+ICt7DQo+ID4gPiArCXN0cnVjdCBxbWNfaGRsYyAqcW1jX2hkbGMgPSBuZXRkZXZfdG9fcW1j
X2hkbGMobmV0ZGV2KTsNCj4gPiA+ICsJc3RydWN0IHFtY19oZGxjX2Rlc2MgKmRlc2M7DQo+ID4g
PiArCWludCBlcnI7DQo+ID4gPiArDQo+ID4gPiArCWd1YXJkKHNwaW5sb2NrX2lycXNhdmUpKCZx
bWNfaGRsYy0+dHhfbG9jayk7DQo+ID4gPiArDQo+ID4gPiArCWRlc2MgPSAmcW1jX2hkbGMtPnR4
X2Rlc2NzW3FtY19oZGxjLT50eF9vdXRdOw0KPiA+ID4gKwlpZiAoV0FSTl9PTkNFKGRlc2MtPnNr
YiwgIk5vIHR4IGRlc2NyaXB0b3JzIGF2YWlsYWJsZVxuIikpIHsNCj4gPiA+ICsJCS8qIFNob3Vs
ZCBuZXZlciBoYXBwZW4uDQo+ID4gPiArCQkgKiBQcmV2aW91cyB4bWl0IHNob3VsZCBoYXZlIGFs
cmVhZHkgc3RvcHBlZCB0aGUgcXVldWUuDQo+ID4gPiArCQkgKi8NCj4gPiA+ICsJCW5ldGlmX3N0
b3BfcXVldWUobmV0ZGV2KTsNCj4gPiA+ICsJCXJldHVybiBORVRERVZfVFhfQlVTWTsNCj4gPiA+
ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlkZXNjLT5uZXRkZXYgPSBuZXRkZXY7DQo+ID4gPiArCWRl
c2MtPmRtYV9zaXplID0gc2tiLT5sZW47DQo+ID4gPiArCWRlc2MtPnNrYiA9IHNrYjsNCj4gPiA+
ICsJZXJyID0gcW1jX2hkbGNfeG1pdF9xdWV1ZShxbWNfaGRsYywgZGVzYyk7DQo+ID4gPiArCWlm
IChlcnIpIHsNCj4gPiA+ICsJCWRlc2MtPnNrYiA9IE5VTEw7IC8qIFJlbGVhc2UgdGhlIGRlc2Ny
aXB0b3IgKi8NCj4gPiA+ICsJCWlmIChlcnIgPT0gLUVCVVNZKSB7DQo+ID4gPiArCQkJbmV0aWZf
c3RvcF9xdWV1ZShuZXRkZXYpOw0KPiA+ID4gKwkJCXJldHVybiBORVRERVZfVFhfQlVTWTsNCj4g
PiA+ICsJCX0NCj4gPiA+ICsJCWRldl9rZnJlZV9za2Ioc2tiKTsNCj4gPiA+ICsJCW5ldGRldi0+
c3RhdHMudHhfZHJvcHBlZCsrOw0KPiA+ID4gKwkJcmV0dXJuIE5FVERFVl9UWF9PSzsNCj4gPiA+
ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlxbWNfaGRsYy0+dHhfb3V0ID0gKHFtY19oZGxjLT50eF9v
dXQgKyAxKSAlIEFSUkFZX1NJWkUocW1jX2hkbGMtDQo+ID50eF9kZXNjcyk7DQo+ID4gPiArDQo+
ID4gPiArCWlmIChxbWNfaGRsYy0+dHhfZGVzY3NbcW1jX2hkbGMtPnR4X291dF0uc2tiKQ0KPiA+
IHdvbnQgaXQgcmFjZSBpZiB0eCBjb21wbGV0aW9uIGFuZCB0aGlzIGZ1bmN0aW9uIGNvbnRleHQg
cnVuIGluIGRpZmZlcmVudCBjcHUgPw0KPiANCj4gV2UgYXJlIHByb3RlY3RlZCBieSB0aGUgcW1j
X2hkbGMtPnR4X2xvY2sgc3BpbmxvY2suDQo+IA0KPiBndWFyZCgpIGNhbGwgaW4gdGhpcyBmdW5j
dGlvbiBhbmQgc2NvcGVkX2d1YXJkKCkgY2FsbCBpbg0KPiBxbWNfaGRsY194bWl0X2NvbXBsZXRl
KCkuDQo+IA0KPiBXaGF0IGlzIHRoZSByYWNlIHlvdSB0aG91Z2h0IG9mID8NCkFDSy4gVGhhbmtz
IGZvciBjbGFyaWZpY2F0aW9uLiANCg0KDQo+IA0KPiA+DQo+ID4gPiArCQluZXRpZl9zdG9wX3F1
ZXVlKG5ldGRldik7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBORVRERVZfVFhfT0s7DQo+ID4g
PiArfQ0KPiA+ID4gKw0KPiAuLi4NCj4gPiA+ICsJLyogUXVldWUgYXMgbWFueSByZWN2IGRlc2Ny
aXB0b3JzIGFzIHBvc3NpYmxlICovDQo+ID4gPiArCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpF
KHFtY19oZGxjLT5yeF9kZXNjcyk7IGkrKykgew0KPiA+ID4gKwkJZGVzYyA9ICZxbWNfaGRsYy0+
cnhfZGVzY3NbaV07DQo+ID4gPiArDQo+ID4gPiArCQlkZXNjLT5uZXRkZXYgPSBuZXRkZXY7DQo+
ID4gPiArCQlyZXQgPSBxbWNfaGRsY19yZWN2X3F1ZXVlKHFtY19oZGxjLCBkZXNjLA0KPiBjaGFu
X3BhcmFtLmhkbGMubWF4X3J4X2J1Zl9zaXplKTsNCj4gPiA+ICsJCWlmIChyZXQgPT0gLUVCVVNZ
ICYmIGkgIT0gMCkNCj4gPiA+ICsJCQlicmVhazsgLyogV2UgdXNlIGFsbCB0aGUgUU1DIGNoYW4g
Y2FwYWJpbGl0eSAqLw0KPiA+ID4gKwkJaWYgKHJldCkNCj4gPiA+ICsJCQlnb3RvIGZyZWVfZGVz
YzsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlyZXQgPSBxbWNfY2hhbl9zdGFydChxbWNf
aGRsYy0+cW1jX2NoYW4sIFFNQ19DSEFOX0FMTCk7DQo+ID4gPiArCWlmIChyZXQpIHsNCj4gPiA+
ICsJCWRldl9lcnIocW1jX2hkbGMtPmRldiwgInFtYyBjaGFuIHN0YXJ0IGZhaWxlZCAoJWQpXG4i
LCByZXQpOw0KPiA+ID4gKwkJZ290byBmcmVlX2Rlc2M7DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4g
PiA+ICsJbmV0aWZfc3RhcnRfcXVldWUobmV0ZGV2KTsNCj4gPiA+ICsNCj4gPiA+ICsJcmV0dXJu
IDA7DQo+ID4gPiArDQo+ID4gPiArZnJlZV9kZXNjOg0KPiA+ID4gKwlxbWNfY2hhbl9yZXNldChx
bWNfaGRsYy0+cW1jX2NoYW4sIFFNQ19DSEFOX0FMTCk7DQo+ID4gPiArCXdoaWxlIChpLS0pIHsN
Cj4gPiBEb3VibGUgZnJlZSA/IGkndGggZGVzY3JpcHRvciBza2IgaXMgZnJlZWQgaW4gcW1jX2hk
bGNfcmVjdl9xdWV1ZSgpDQo+IGZ1bmN0aW9uJ3MgZXJyb3IgaGFuZGxlciBpdHNlbGYuDQo+ID4g
U2hvdWxkIHdlIGJlIHByZWRlY3JlbWVudCBvZiBpID8NCj4gDQo+IFN1cHBvc2UgYSBmYWlsdXJl
IG9uIGkgPSA1LiBUaGUgaXRlbSA1IGlzIGFscmVhZHkgY2xlYW5lZCAoZG9uZSBieQ0KPiBxbWNf
aGRsY19yZWN2X3F1ZXVlKCkgaXRzZWxmKS4NCj4gVGhlICd3aGlsZSAoaS0tKScgc2V0IGkgdG8g
NCBhbmQgb3BlcmF0aW9ucyBhcmUgcGVyZm9ybWVkIHdpdGggaSA9IDQsIDMsIDIsIDEgYW5kIDAu
DQo+IA0KPiBXaGVyZSBpcyB0aGUgZG91YmxlIGZyZWUgPw0KPiBEbyBJIG1pc3Mgc29tZXRoaW5n
ID8NCk15IGJhZC4gQUNLLiANCg0KDQo+ID4NCj4gPiA+ICsJCWRlc2MgPSAmcW1jX2hkbGMtPnJ4
X2Rlc2NzW2ldOw0KPiA+ID4gKwkJZG1hX3VubWFwX3NpbmdsZShxbWNfaGRsYy0+ZGV2LCBkZXNj
LT5kbWFfYWRkciwgZGVzYy0NCj4gPmRtYV9zaXplLA0KPiA+ID4gKwkJCQkgRE1BX0ZST01fREVW
SUNFKTsNCj4gPiA+ICsJCWtmcmVlX3NrYihkZXNjLT5za2IpOw0KPiA+ID4gKwkJZGVzYy0+c2ti
ID0gTlVMTDsNCj4gPiA+ICsJfQ0KPiA+ID4gK2hkbGNfY2xvc2U6DQo+ID4gPiArCWhkbGNfY2xv
c2UobmV0ZGV2KTsNCj4gPiA+ICsJcmV0dXJuIHJldDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4g
PiArDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEhlcnbDqQ0K

