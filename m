Return-Path: <linux-kernel+bounces-122622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2575888FA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE15F2A6F03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB8A59B7A;
	Thu, 28 Mar 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="GuEXMZmt"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3232E645;
	Thu, 28 Mar 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616195; cv=fail; b=Ce2BXA1CH4/pIRuXBdFUrC3MLJAvNlWmg+wTvqMgqFrPzFL7x6VIUl6sutOo8nH2Lsl31MlfYNhAmNol5y79oeyAQrXOjQ1M9t3y5p2MDjX4Sxhd5Gzpqk4RFy34qR+SfB+HZhOfz6e3IokLcpqdwo+iTjBj/ukCD0Xmr+3+WcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616195; c=relaxed/simple;
	bh=QN3wkGrjx8E60QDE+bQ9su29NEehP8PG1/uPimSKTzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s2/SKKFZdaliL6H/prwvsf7tPpg3Q6Lx2z/7q7yqlLHWUKq/XLyuhWrRkYuB/eseR2SOsN5Ynh57B4AO6c+owjWvItPC6tE/swbpM5LUkDwCaVHtLxocyXrepSdk5Sb4rbepk9XCsLz2eOCjLshn4BaQTCEd8pR5D3ue7gtipys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=GuEXMZmt; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S4BMRJ011623;
	Thu, 28 Mar 2024 01:55:43 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x4jd1pa2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 01:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZM+3xFISA9uDOZgNf5WBB7cVogBe5R2j7zLHIWCzvgiAvddo0uimdacf6aGWJQN3CTgi0J2T9SngWICM6s8mxVCKs/fpZA4uoZu2TZ1v1q1VlZfDBB1o0XaEiweRlLyFQ0nDmd39kofuTrmQe4poXugTV7kZgNglSVbgW7ulvrM91MRQiwzsJemakUfIXCo1W9nXtdcCgpCZB5c99ScFxobVpc+iLbTcuCsLIEVKGfgNFTbdqIr/v1w2poa0hcEpcLVCI7PA9oqBYBiQZ2WtdLSwgEymiwfATUbowInwdBQ0OtAiW4WZrfTEgtIiKcG/bx8FSEbyGAotEUKkpqWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN3wkGrjx8E60QDE+bQ9su29NEehP8PG1/uPimSKTzU=;
 b=D43nZcd786Xl2uLCo3g0djWv8LHd9yPBe7BZaqUsxx6FvvLkPh58ratNo0jhgfy4uiEvmZ8ByirtxBSN65J0PN81DESaKdIXISKff70eFSQwauTBEFEfMc1rtV8Xm91hPn1zratw7o5nsm3y3WCvBuoKVyRViC1grCjq8MB9ABkaYONhdjlN1V2Vk+tsx4+pCIqRRmfzwb1KfOpah7WUncRUYtBpv3Fn+2JPSK8wfqwDdMtFWrn2C4qI7lAEcdG9g750LYaGFZaBGYoOIkHTRMR78PjDKMCN5QgKZ3dwibwNgn1UYBsvuyKkuuo2idvZ9allthDNxBJVC0zpKlLBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN3wkGrjx8E60QDE+bQ9su29NEehP8PG1/uPimSKTzU=;
 b=GuEXMZmtXPKrtJUSzNFktms0ypwsnX1t2EehvZwqB7CheEjv/1soBmE/ZMo1Jw5j0B4PwR37oZl4UEjWqwo5ZlcNXIpFTZFhqM6piUgOpPnD1JcBBJ0fJ14EXhslDgvOapRaetLNvw/Q8CXuFG1CRMsSL6PJDhA/enk7t2+1q7M=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by CO1PR18MB4604.namprd18.prod.outlook.com
 (2603:10b6:303:e3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 08:55:40 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 08:55:40 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: James Lee <lizheng043@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nhorman@tuxdriver.com"
	<nhorman@tuxdriver.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "James.Z.Li@dell.com"
	<James.Z.Li@dell.com>,
        Simon Horman <horms@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] neighbour: guarantee the localhost
 connections be established successfully even the ARP table is full
Thread-Topic: [EXTERNAL] Re: [PATCH] neighbour: guarantee the localhost
 connections be established successfully even the ARP table is full
Thread-Index: AQHaeQ/FomqULxvNBkC/k1/miqR3YLE9iUYggAFIJACABFCioIAJwzkAgAADoPA=
Date: Thu, 28 Mar 2024 08:55:40 +0000
Message-ID: 
 <MWHPR1801MB1918800A2309E838FD2CB2E0D33B2@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240311122401.6549-1-lizheng043@gmail.com>
 <20240311135117.GA1244788@maili.marvell.com>
 <CAPCnf4zS=FN0MHM2tQV0b468zN0yqRHbaNMsk3cDQ7Vu8wiHKA@mail.gmail.com>
 <MWHPR1801MB19185089A3147123D1E877D0D32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <CAPCnf4z0gp47TkxP+PFw3bd_Weh7=jn9Q2t-z6QB654Ckc36Pg@mail.gmail.com>
 <MWHPR1801MB1918BF213DD974CB5A6CF032D3312@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <CAPCnf4ysy032UZbHjtymkPHcJUOXef6ZUX13+L4yEC=eEYzLEQ@mail.gmail.com>
In-Reply-To: 
 <CAPCnf4ysy032UZbHjtymkPHcJUOXef6ZUX13+L4yEC=eEYzLEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|CO1PR18MB4604:EE_
x-ms-office365-filtering-correlation-id: b6b8c4b3-3fc0-4850-0e96-08dc4f04d831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YVWj3sUT25d/4RLi7QeFrmldKTs90zDQzYkNrnDGfkl9ikIV2Sw4y65oupaMBUP5WKO714OWLQttD7PYKVrkxntAqJGw9rcI6c/zRkAdsxDmZEnKsvbW1eRuY8AkehNEwnlJMzWR14+udnRNtGlKDRL6cIcg9kG7oRZU3MVdwOn2AgGdLGiMnYgbRDdc6iZgYClzy6yZMEHlm9JU9mPtfankVv1/9HFhCNK5sBpCF1DyCQHMD3R4rKNmXGWLtNWUpVUXtDOZG0ivLXT3ksSanzAGApdNblmIv0xjpmd2QInj+366k1fSmMtXq1OZbvVkTeDpkheq7x9DfnFTWsSJVE3FaBh/7Ze+r7lgQ+ixSrCPSLBvnmPeas64PWfqdWQILAkAfyL/8qWKljncbxytjcMIUCS3xplPDESPpcLeCWiK8QrL7sJP5B2Ea+Z3COq7AIbOdSX5xm7q9ZJZkwV02QGobXtueDHIurZ/rbgjQh1/RBWuKu6n9gmBKoc2um+1i5kAyfLi/sArCqkdRJGFZ5FImhFEMqRUDKtXQYNy2aAD8PPhx+zCijii1UXtsrjVAPiRU5Hq/HWVTUWpOISyMaqZawhHpcnYv7cpoQMTzyqu2711YBacPvDaklYfIwqkALUYj3KtBHA4XCxr3DYaSx7np8Al811JNUBGsT9o3CI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q0hlNW05bDJ5YkJvMUcrd3o2dDZWS1FvT0padEhrUWNOYVg1YXVQKzFqR2w3?=
 =?utf-8?B?SHM5d1dUOUR6Sk1KdVhwL2xvT21acXJjaTlEN2FUSHI4LzU4QmJxK0R2dmMz?=
 =?utf-8?B?N0FraW1nYytWa0dDWXNtQ1oxQ0V0aExKaDJnSDQyb1lNVE9iT0EyOHZsNG9V?=
 =?utf-8?B?U3lNenV4V1BJL1dobU1YbFU5RzhmbDlUZVFrQWxSay9KeVNsa3VBWStJNW1O?=
 =?utf-8?B?aWtldXhXNmZ3d1doQ201TVl4bkJxSUVvWmhHN1BpeUhMUVp4alJBdU41aDBE?=
 =?utf-8?B?RjJRVHlrL09pNWV4TThBSDZOYUFHYldqWEczN1A1WVV5aG5kSjR6RUZKdmFO?=
 =?utf-8?B?WUNEVVd6VjduT3RBek5meDkwWVZVeDlBekNtaVdOZ0xwQmNmYWgrbE04VkNw?=
 =?utf-8?B?dWgvZ1NGdVVRNVk1M0xKSnNRVEJ5R25qQWRISnlydWZaanJnN2M5bHF2ZEx1?=
 =?utf-8?B?MnVKak1RYUpHZHlZQ3p2R2hLTFlSSzNWTkFyYVN1WFEvT2RDTUk2dHpCUVl0?=
 =?utf-8?B?Ui85bHdKSUJpMGVxWUpJRGUxQXR6S1lIbzBGcFR2ZU9abzVvWGRqYmEwN0ZE?=
 =?utf-8?B?TEVyb29vL3FYcW9XeVpCUGRCcFVsbkNKaGRNTzViMDBhbExXd1RtNUJwc1V2?=
 =?utf-8?B?dlpjY04yWkRVcWpyL3lqNFNac282akR2c3pnbXBMUWMrcXMvMjlhZ0drM1Ux?=
 =?utf-8?B?ME5pZkVhMlkvU25qMWxhc2s5dXV4UmVVSXRwYVdCTkpSOVZ1ZXZCSWk4RS9T?=
 =?utf-8?B?VnB5T0dqUU0wLzdXYVBLOW10U0o1Sy9kdVVIcExOeCt5NHYveUxzNlczUFJs?=
 =?utf-8?B?dFkxQnArTHM3YkowcDBEckJaZHJ1TW9SazlUcEhsczhJaC91RTFCTm5zdGxS?=
 =?utf-8?B?TEV1dXpsRXArMFJDeGxadUxicG5SWjJ0TFJRTlpTTFZYcFMzOTEzNUNVcVIv?=
 =?utf-8?B?Uk5OMUtzRkwzdzhBVkJ5cUJtcmlIckxRbFNOSFIzM1NHdFljMjlRT3NVdkY1?=
 =?utf-8?B?THI2TkRPcjdjM2dhSUZzOG0xZWFEa284Qy9KLytHVmxDUWVKMk4ycVRUbmI0?=
 =?utf-8?B?THhyKzNzSUo5V0VjY3pmc2ZSZkMxYXNQSU91YS9XemkxRTdpRk9pSi9iU3du?=
 =?utf-8?B?SGpWWXZKZWtxOG93d3hQcXJKVXk5ZWpGOTZjbE1qT2FMU3cwTmRwdWlYeVpi?=
 =?utf-8?B?NUVHL3lqb0wyVFI1YWNmelp6WURNSjZBcndvWC9oQnc5d0tkS2p1SGlpQWpo?=
 =?utf-8?B?M25sdXlleEl5UjJ0RE5nT0xUdHo2Z1NZWHllYzNjTnpIcnRKOXpva2ZCQUYr?=
 =?utf-8?B?MTdYdjUwSVBNei9VZElvaVdoaVYvYkNUMmJraTl5QU5IVHU5Z1haeXpEMEFX?=
 =?utf-8?B?QzJIVVdKcmdxOXpIUk9BUzhndVZQNEtUWGZXYXFTTEtlR3BvcWg1eExhWm5w?=
 =?utf-8?B?cms5eFdWaW1SczVXaGNLeiswRmVadkY5dlN2dmEvTm9GcGFXN0pYUXJ2V2tR?=
 =?utf-8?B?c1pGYUlqQjJ2Vm11NmF5UW1kMnRJNXQwdDRJM2VxcTZJdHM3b0RySkJxbEFa?=
 =?utf-8?B?UUNieU5BTEJqaEZBbGduaFI0S0FUckVKcytnZHZoREM5TUpLOENJaENXeEY0?=
 =?utf-8?B?Mlh2VXluU29vY2RtN0JTS3pUZmtMRVVuSy9pZEI5SFJ6MWw5N1lTa2tjNVo2?=
 =?utf-8?B?WjZsSmVtT2hDQlBCQUl3WlEyYjFNNUNyRGtqNTdRVFNZaGhSYnQzbktyWXRD?=
 =?utf-8?B?YnUxbmVFYkRCZXczQm81eVpsMnkzRytEQmFta2E0QUhPTUVhYU4vbC9hWVU3?=
 =?utf-8?B?S0E0TDgveFZYeFJWUmRzUlNkMUF6ODloeU5RK3pOdkQra0Ftc05hREdmTm9J?=
 =?utf-8?B?TjlIR2lkbUhhdGgxQzJTMU9zdGliOFNFSEpySlRoRU12eVR6VllnVVlhaTBy?=
 =?utf-8?B?YzlENVRlM2xKODZ5TGhXZG44eWJNdU9rUEcreHptQ2lTMENYUTJmNFJSd2FF?=
 =?utf-8?B?ZHNCcTZHYll4OWgrQXdZL3RiY05WeDVDT2lpOE9tT2QrMXV5NWh3WFp2alJt?=
 =?utf-8?B?by8vcVp6RXBLNlIxUUNaeGhTRnU2M28ydXlrVTZYaE5UZkdQekJndDFoeTJs?=
 =?utf-8?Q?vqAsgFRjfXHvgWLuM0ZtLTBaN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b8c4b3-3fc0-4850-0e96-08dc4f04d831
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 08:55:40.5300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6c8UOrndUwGOrZprcs1AvNjCx9i/pnC6byxQ8C7jlQoNyTxQfHzY26wK0t8tVeV1kB8jFxAg9wpxa78pAWIHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4604
X-Proofpoint-GUID: FNUh1zp54m6lYekg_IH5pOX_c0CyYNm2
X-Proofpoint-ORIG-GUID: FNUh1zp54m6lYekg_IH5pOX_c0CyYNm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02

PiBGcm9tOiBKYW1lcyBMZWUgPGxpemhlbmcwNDNAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgTWFyY2ggMjgsIDIwMjQgMjoxMSBQTQ0KPiBUbzogUmF0aGVlc2ggS2Fubm90aCA8cmthbm5v
dGhAbWFydmVsbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOw0KPiBuaG9ybWFuQHR1eGRyaXZlci5jb207IGRhdmVtQGRhdmVt
bG9mdC5uZXQ7IGptb3JyaXNAbmFtZWkub3JnOw0KPiBKYW1lcy5aLkxpQGRlbGwuY29tOyBTaW1v
biBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJl
OiBbUEFUQ0hdIG5laWdoYm91cjogZ3VhcmFudGVlIHRoZSBsb2NhbGhvc3QNCj4gY29ubmVjdGlv
bnMgYmUgZXN0YWJsaXNoZWQgc3VjY2Vzc2Z1bGx5IGV2ZW4gdGhlIEFSUCB0YWJsZSBpcyBmdWxs
DQo+IA0KDQo+IEl0J3Mgbm90IGFuIGlzc3VlLCANClBsZWFzZSBkb27igJl0IHRvcCBwb3N0DQoN
CiA+d2h5IG5lZWQgInBvc3QgYSBuZXcgcGF0Y2ggdmVyc2lvbiI/DQpBU0ZBSUssIG9ubHkgaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9saXN0LyB3aWxsIGJl
IGFjdGl2ZWx5IGxvb2tlZCB1cCB0byBtZXJnZSBwYXRjaGVzLg0KSSBjb3VsZCBiZSB3cm9uZy4g
DQoNCj4gDQo+IFJhdGhlZXNoIEthbm5vdGggPHJrYW5ub3RoQG1hcnZlbGwuY29tPiDkuo4yMDI0
5bm0M+aciDIy5pel5ZGo5LqUDQo+IDExOjM35YaZ6YGT77yaDQo+ID4NCj4gPiA+IEZyb206IEph
bWVzIExlZSA8bGl6aGVuZzA0M0BnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBNYXJj
aCAxOSwgMjAyNCAzOjEzIFBNDQo+ID4gPiBUbzogUmF0aGVlc2ggS2Fubm90aCA8cmthbm5vdGhA
bWFydmVsbC5jb20+DQo+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IG5ob3JtYW5AdHV4ZHJpdmVyLmNvbTsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsgam1vcnJpc0BuYW1laS5vcmc7DQo+ID4gPiBKYW1lcy5aLkxpQGRlbGwu
Y29tDQo+ID4gPiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBuZWlnaGJvdXI6
IGd1YXJhbnRlZSB0aGUNCj4gPiA+IGxvY2FsaG9zdCBjb25uZWN0aW9ucyBiZSBlc3RhYmxpc2hl
ZCBzdWNjZXNzZnVsbHkgZXZlbiB0aGUgQVJQIHRhYmxlDQo+ID4gPiBpcyBmdWxsDQo+ID4gPg0K
PiA+ID4gSXQncyBub3QgYW4gaXNzdWUsIHRoZSBsb29wYmFjayBkZXZpY2UgY2FuIG9ubHkgYmUg
Y3JlYXRlZCBieSBrZXJuZWwNCj4gPiA+IGl0c2VsZiwgbG9vcGJhY2sgbmVpZ2ggZW50cnkgYWxz
byBjYW4gb25seSBiZSBjcmVhdGVkIGJ5IGtlcm5lbCwgb25lDQo+ID4gPiBsb29wYmFjayBuZWln
aCBmb3IgaXB2NCAsb25lIGZvciBpcHY2LCBpbXBvc3NpYmxlIHRoYXQgdGhlIG51bSBvZg0KPiA+
ID4gbG9vcGJhY2sgbmVpZ2ggZW50cmllcyBleGNlZWRzIDIuDQo+ID4gQUNLLiBJIHN0aWxsIGZl
ZWwgbGlrZSBhIGhhY2suIFBsZWFzZSBwb3N0IGEgbmV3IHBhdGNoIHZlcnNpb24uIExldCBtYWlu
dGFpbmVycw0KPiB0YWtlIGEgY2FsbC4NCg==

