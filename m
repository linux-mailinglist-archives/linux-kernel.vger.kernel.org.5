Return-Path: <linux-kernel+bounces-141984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D08A25C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BFB2849C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF931BC3C;
	Fri, 12 Apr 2024 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="GQrsspQX"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2118E1A;
	Fri, 12 Apr 2024 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900066; cv=fail; b=LkpENSU5cnZaJNR3AlC8De0e3gMw22Iw/PFa8ZV0fEhUsHIcsURQ3/nxJ3aRk4xFKuAZrx3qiWPHPja243fRfovt5DK/7RtZIaHdbWBemL2Qs+qligD0nP3HDHR72p128KOfWViQWBKyn6KRpw3mOuB4tyYfpOupcTRu42zbDCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900066; c=relaxed/simple;
	bh=RsTphoj7hY5c7H3BSxbQd6JlkTYUg4is/+nhIrvr9no=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EDat0wo6AXX9Y7u9kpP0OjODOCDjBlWNSCZiixc5oDkGt1UQ7BteyeXuAKs5fVzZe/0NEtCCTbB49VinIP8XFNM9lmppzkffDUiGwX8GC8QyGNq+3m+jb2ymKwEloDnV6kUGVqgRJHQMu1pVbrtZo9EBFDXq/9OT8u5ANS7MJBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=GQrsspQX; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C4ADvp009071;
	Thu, 11 Apr 2024 22:34:09 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xewph06e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 22:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhjJEXk9waCQkfGm4O5WJ3UxHGcY0QoZHxbLpU+/0sbfj50kX1BoCjmGfTreQ7W5x9vdE+JbFmbeQIFRXRb5Y0k6l7vMiU+HmyvA66wT5DSrV0/eAiPXj0Z1uE3pQzUWEFjhLk3c/TCI+eR0WhnPP1GhVDyAW+PXMGljVyCoR4SzPjIf/1yhK+ilqmENd7Qlrns4ewM5ByCmnVTuCVGu7+WNp16ZwCsvI7i8jkGddrv4lP/KMTZIG5Y2cRq5yBov9bsEblSKRVbV2TbuLl+KYO3O5r3g5m41eXhfVLUS6O4UZZTJXNY+lTw8RAfH2k7susfUQ2R1VEwoc6y5N0OdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsTphoj7hY5c7H3BSxbQd6JlkTYUg4is/+nhIrvr9no=;
 b=hmpzfehQmLUWBZszEElZwIIglXdpNOcQfrkeTdgE5O1iPIA8coldHREp10EFScqBrJYjE527IVVAsrWwR+hN1p3WjkglfHt243j5zip2feiSMCETK3RD9Y8Kace5Gn3jaFr7AmV7rzkl8bDeUkiup6Jv9UtJLs4VrRWO3mEvBDoScauW5t2zqp+z6l0I+CdU4OL3FgTHeq0q7tDhosHwsTNCAh2HllhWRV5jatWOy/ypyUEZaESTB9sFl8Oq76OwFHYYbNR+hQVnaJRJjDFSjU95fRemgFxPswKKhyzNMP88pNBWgqOLlVTGB/09DCetZa3ufQEtVhps7PeiNyX8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsTphoj7hY5c7H3BSxbQd6JlkTYUg4is/+nhIrvr9no=;
 b=GQrsspQXHSTnJtWiv1ssYs+DLYB2ed7P0DVWvuaWD2UA+4u6L/6MSv0ht7XkY+lWzxGXg/ZPOf2TPifA1YJIAfiHolBboWsvuaBzfTJ1s0hwUlyCtASlmEC2iquIPG7m1BDbwRO/fqCQfBxVPF3zY7CMF062nqtDkv5ofMzpBJc=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by PH0PR18MB3863.namprd18.prod.outlook.com (2603:10b6:510:49::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 05:34:07 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::7a73:d694:187e:642d]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::7a73:d694:187e:642d%4]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 05:34:07 +0000
From: Suman Ghosh <sumang@marvell.com>
To: =?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>
Subject: RE: [EXTERNAL] [PATCH net] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT
 implementation
Thread-Topic: [EXTERNAL] [PATCH net] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT
 implementation
Thread-Index: AQHai00WP2j9CSH4WUSeSWAnoh3ajbFkHb1g
Date: Fri, 12 Apr 2024 05:34:07 +0000
Message-ID: 
 <SJ0PR18MB5216D2276BA11D5C5E31D6A6DB042@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20240410134303.21560-1-ast@fiberby.net>
In-Reply-To: <20240410134303.21560-1-ast@fiberby.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|PH0PR18MB3863:EE_
x-ms-office365-filtering-correlation-id: 43dc646a-ea83-41b4-b19d-08dc5ab22c2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lSOGArDTsLDOR97eGzOIN6sW6jGXOOqkUM9azE3Sqy7HP283ozYWB9aidxaE8u0vBIHaqcJKxffEJ1Si6BAgeS42LrDfXGB1kMmcfwjZzTyAyVPLG5kmFVPHfTz30SXTDm6dwZctkkYd7yhOqBGPUvzdpXdnkeM6VjTMmPITh3b7FgL89hGtpHPC62aMdGsmkFztR2RKkXChqxBFiStPcxA/cK9Bc7xBCuWwvNL/1rQ9GOuIvY2C0eeh4Iezr42GEIAngww+baeL/VEJiQ+eQSimDciZtWixa/5VY4YYJ/3R0Xww2/LkOEeI2mmlAKKxdSbJWqjQkMOZqMke3u8m95MZ51maJlvkM4V/a+FIFwMJ3XsWlgGdajH+XG3NTMRox5cKOLj/YTdlIU+5Oxu90zQP+lguZkcxvokVrisNcRnG41SZwNFpEpJ25X8uFoXQpUSaq6eeYCMuRU3RUd6zKli7Yl9f028y7DYitqV14erVht/e+JmhuSMLgWxTR19SoEHEskO07ltCo2TIp6A67nrOAM3tTSFWG8GGKU/MQ/dFXW/V4Ib9qwDM5A0rmt0AZ7yz4ePiJuCSw/iEMF2voRzskBs6QNY1I2McnIDCNdeHQjCxaEnemZxjHvU6MDUsKWFtcNigad35uD4fFvWwyXHa8GILnsMujRh5IungOCLT9RBTK14r3bjeAYhbz5dlcdDPai5L1myD2Iu4s14NVWtIdc77A88O9XDxgysWZ0Y=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SzBFZlQrdFg2WDBxSkRzRm1oNHYvb2RlRlZDdm5zc3FuaWNYNU9CS2hCc0tV?=
 =?utf-8?B?KzFUd0k3TU1DcC80N3Zkd2RteDByRDR0QzF1RitCSk8zRGd3eng4TVlmaDlu?=
 =?utf-8?B?NUhnSlA2L0R6Sm90Zmwyeks3S0xUSDREZkt5eTdLME5FNFhxTkZKQzEvdFRw?=
 =?utf-8?B?RTVEb0JxdkRwMmk5UjQwbkpTSHZTUk9vbFBPTk9VdnZTb1NNNmgydnBRdFlZ?=
 =?utf-8?B?NGdzUFRKNkF3SWQ3b3VkNjhtdkYwMnNQUHhRTjQ0Mll0cEd1SVhpMm9URk1r?=
 =?utf-8?B?Qk5ZVVgrYXoxZ3VUVzRwZFo2djVCeFZYeGVKaW41M3V4V0hyelp1VDg1dlJ6?=
 =?utf-8?B?QnAzRXZpd2diQVI0dlBqN0k2cVg0MWpzMUlSNWxUUU9XYkN2Sjc1bGhrQzJz?=
 =?utf-8?B?emR0UldZOVQ5MDBjSTh6Nm82aFZWSmJBdDc3ajJZTjNBOWNIcDJjQUNqQ0dP?=
 =?utf-8?B?UkxEaWpZR2NvYzlXZSthOTlLY2wrTnk3cm9NV0hoWUNNN1B1cWU2Zm0rWTNT?=
 =?utf-8?B?L2pleXBKbzQ2b29qaEFVTEhtYVNyMFpORjhjdlRhQmdQdStsZFhSQWFneEpm?=
 =?utf-8?B?ZXl2dkZCOG5Bai9rZHlLWW0vMmJTU3ZFd0sxZmYrZEpuZ3NjTy9Rd0EwU0ZN?=
 =?utf-8?B?aDRHc21zc3ZVYSsza3pPS1FDVDd4K3dXR3JsVGtBSmM1UDVtNXRmaDRxU3Z6?=
 =?utf-8?B?cmtFVHVvZ0RaWFY0cDBrZDlIZks5QWh1bG9KczZLMkd2Ym1yK2hSMFpmTUli?=
 =?utf-8?B?UStZWlJGOS9VWGx3a2dBM3JKNk90MU5CVytQYm9FQjlBTlBGS0F6ejdiOVJp?=
 =?utf-8?B?c3p4Z3JubFg5cUswQjcxRWM5MWw3aDZhVlY0eHlVNGYyZE9JdldzWFgzQzRv?=
 =?utf-8?B?ZGZHN0VkL3BoTnVEMWVRd3RVaEU1Q1Fid0lESHp2TkM4WEs4dHhjbGoxYzBt?=
 =?utf-8?B?WStqK1ZUUnJLSzBUdHdvY3BLSFczZ0pWd2F5MGU1V01kZ3NNSDVYQzY1MUln?=
 =?utf-8?B?S0pSTHFvMWRHZWZSbVVJT09yYjh4OTZCK01lcXp6MUxzN3pXa09XcGIyamRV?=
 =?utf-8?B?RVZKWFFvUXZuSzZEMHVST1dsTU5sa21ZbGZWeTl4Uk9MSWdKQWx1SUZXa3dh?=
 =?utf-8?B?Witjc1ZtU3JZalRQZ0dvUEVvdUxzMW5MYWlxWGVBcUEzYStrdTZJYTNWcUFq?=
 =?utf-8?B?MnNhQXNXVk51SlhvY3RDTC9tSHJvTjdQKzc3WHNCQUVTc1drOVFHbmd4a0Nx?=
 =?utf-8?B?MVhlaUMvK3daZEEyTnB4c2V3MTlGVGZ6ZzFjUllUaHpqL2VWTzM3bFRMQUFQ?=
 =?utf-8?B?YlFRRDI5V1NKSmpHbmwvR001VUVEbk9kUmJCWS9OWjdjeHRDK2MyUXZNRkpt?=
 =?utf-8?B?cWRaQWVWYlFUa0QrSkFleCtyMCtQWUlWQTlOU0RhaW80QTBWWXBaQTJvZ2I3?=
 =?utf-8?B?VzJ2UURNcW5mWks1azZ4M0FwY0g4T3dsaGttSzFabDJUV1d4bjg3aDNnTnAy?=
 =?utf-8?B?bEltZUIxS0M1eTREOGF2OThKQ21udDkydXpKVmFyaUVoYlJxWTBSUmNBaGZx?=
 =?utf-8?B?eVJmOGtNTzAxWWoyRytzVWtVVUN4a05BYmppY3JGa09FL29RdzBRMjJNVHEv?=
 =?utf-8?B?TjNiekc4M0hwU0duR2kySHE5Z3dXcmRTcEdMNThFZWhuUGZ1MmF2bWpBTlph?=
 =?utf-8?B?WjV0TXM5OHR1TWJ2QlBsZnhDOE5abENxVlRyam9yK0tjMk9OOHpHdGZ0Rnh1?=
 =?utf-8?B?a3NCYkZ6YStTT1RVcy9GQmNnS1VqVWlWdjNuYWxHZGo2eTltKy9pdzMrcjVm?=
 =?utf-8?B?bksyZHV6YmVyT2xYbWVKVTdMaENDN0JsVWhZTkFra2FhN3R3TDZHcmh6Qysr?=
 =?utf-8?B?VDZGQkY5K09HemFvVk05RlpNRlROUGpmdStMUWFXUVFTeHdBcFJ3bUFzYURr?=
 =?utf-8?B?U2hMSWVBSHpLaXRZTHNCT1c3STNXRVhzZmQ0ZllyUmpJMHZ2ZWlEQUVKbkRq?=
 =?utf-8?B?TkN6RlEyZDFqVXhXeDRmN3ZsamorbVBKU09xZEV2NzRhMkIydmtldlk5TlNv?=
 =?utf-8?B?M1JOc0w4UTJ1bklXaEcraFZVczNMYWpNQzcyT0tOUTJqTkNwOGxDTkVObVNn?=
 =?utf-8?Q?kQPRIp5pkUrtTtEOb+Jbn6RCv?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dc646a-ea83-41b4-b19d-08dc5ab22c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 05:34:07.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0FMB0iw2YvYRBwYj6sIhclDvzBvQgrdELK15ZCLm+ROGnMAKRAOwzVuZ3KZVwFot0kJGjx2261LtHnU1hKLdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3863
X-Proofpoint-GUID: qpXFds5plRB1bkQHsAqxO7W7inlMi6me
X-Proofpoint-ORIG-GUID: qpXFds5plRB1bkQHsAqxO7W7inlMi6me
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_02,2024-04-09_01,2023-05-22_02

PlN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIG5ldF0gb2N0ZW9udHgyLXBmOiBmaXggRkxPV19E
SVNfSVNfRlJBR01FTlQNCj5pbXBsZW1lbnRhdGlvbg0KPg0KPlByaW9yaXRpemUgc2VjdXJpdHkg
Zm9yIGV4dGVybmFsIGVtYWlsczogQ29uZmlybSBzZW5kZXIgYW5kIGNvbnRlbnQgc2FmZXR5DQo+
YmVmb3JlIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMNCj4NCj4tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+VXBvbiByZXZpZXdpbmcgdGhlIGZsb3dlciBjb250cm9sIGZsYWdzIGhhbmRsaW5n
IGluIHRoaXMgZHJpdmVyLCBJIG5vdGljZQ0KPnRoYXQgdGhlIGtleSB3YXNuJ3QgYmVpbmcgdXNl
ZCwgb25seSB0aGUgbWFzay4NCj4NCj5JZS4gYHRjIGZsb3dlciAuLi4gaXBfZmxhZ3Mgbm9mcmFn
YCB3YXMgaGFyZHdhcmUgb2ZmbG9hZGVkIGFzIGAuLi4gaXBfZmxhZ3MNCj5mcmFnYC4NCj4NCj5P
bmx5IGNvbXBpbGUgdGVzdGVkLCBubyBhY2Nlc3MgdG8gSFcuDQo+DQo+Rml4ZXM6IGM2NzJlMzcy
Nzk4OSAoIm9jdGVvbnR4Mi1wZjogQWRkIHN1cHBvcnQgdG8gZmlsdGVyIHBhY2tldCBiYXNlZCBv
bg0KPklQIGZyYWdtZW50IikNCj5TaWduZWQtb2ZmLWJ5OiBBc2Jqw7hybiBTbG90aCBUw7hubmVz
ZW4gPGFzdEBmaWJlcmJ5Lm5ldD4NCj4tLS0NCj4NCj5UaGlzIGlzIGEgYmVzdCBndWVzcyBvbiBh
IGZpeCwgSSBkb24ndCBrbm93IGlmIGl0IHdpbGwgd29yaywgYnV0IGhvcGVmdWxseQ0KPnNvbWVv
bmUgYXQgTWFydmVsbCBjYW4gdGVzdCBpdC4NCj4NCj5UaGUgbW9yZSBjZXJ0YWluIGFsdGVybmF0
aXZlIHdvdWxkIGJlIHRvIHNldCBhbiBlcnJvciBtc2cuDQo+YW5kIHJldHVybiAtRU9QTk9UU1VQ
UCwgd2hlbiBgdGMgZmxvd2VyIGlwX2ZsYWdzIG5vZnJhZ2AgaXMgdXNlZC4NCj4NCj4gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdGMuYyB8IDcgKysrKyst
LQ0KPiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0K
PmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMv
b3R4Ml90Yy5jDQo+Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMv
b3R4Ml90Yy5jDQo+aW5kZXggODdiZGI5M2NiMDY2ZS4uZjQ2NTVhOGMwNzA1ZCAxMDA2NDQNCj4t
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90Yy5j
DQo+KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJf
dGMuYw0KPkBAIC02ODgsMjIgKzY4OCwyNSBAQCBzdGF0aWMgaW50IG90eDJfdGNfcHJlcGFyZV9m
bG93KHN0cnVjdCBvdHgyX25pYyAqbmljLA0KPnN0cnVjdCBvdHgyX3RjX2Zsb3cgKm5vZGUsDQo+
IAl9DQo+DQo+IAlpZiAoZmxvd19ydWxlX21hdGNoX2tleShydWxlLCBGTE9XX0RJU1NFQ1RPUl9L
RVlfQ09OVFJPTCkpIHsNCj4gCQlzdHJ1Y3QgZmxvd19tYXRjaF9jb250cm9sIG1hdGNoOw0KPisJ
CXUzMiB2YWw7DQo+DQo+IAkJZmxvd19ydWxlX21hdGNoX2NvbnRyb2wocnVsZSwgJm1hdGNoKTsN
Cj4gCQlpZiAobWF0Y2gubWFzay0+ZmxhZ3MgJiBGTE9XX0RJU19GSVJTVF9GUkFHKSB7DQo+IAkJ
CU5MX1NFVF9FUlJfTVNHX01PRChleHRhY2ssICJIVyBkb2Vzbid0IHN1cHBvcnQgZnJhZw0KPmZp
cnN0L2xhdGVyIik7DQo+IAkJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gCQl9DQo+DQo+IAkJaWYg
KG1hdGNoLm1hc2stPmZsYWdzICYgRkxPV19ESVNfSVNfRlJBR01FTlQpIHsNCj4rCQkJdmFsID0g
bWF0Y2gua2V5LT5mbGFncyAmIEZMT1dfRElTX0lTX0ZSQUdNRU5UOw0KPiAJCQlpZiAobnRvaHMo
Zmxvd19zcGVjLT5ldHlwZSkgPT0gRVRIX1BfSVApIHsNCj4tCQkJCWZsb3dfc3BlYy0+aXBfZmxh
ZyA9IElQVjRfRkxBR19NT1JFOw0KPisJCQkJZmxvd19zcGVjLT5pcF9mbGFnID0gdmFsID8gSVBW
NF9GTEFHX01PUkUgOiAwOw0KW1N1bWFuXSBEbyB3ZSBuZWVkIHRoaXM/IElmIHVzZXIgcHJvdmlk
ZSB0aGUgY29tbWFuZCAidGMgZmlsdGVyIGFkZCAuLi4uIGlwX2ZsYWdzIG5vZnJhZ3MiIHRoZW4g
dGhlIGFib3ZlIGlmIGNoZWNrIHNob3VsZCBub3QgYmUgaGl0IHJpZ2h0PyBJZiB3ZSBhcmUgaW5z
aWRlIHRoZSBjaGVjayB0aGVuIHdlIGFsd2F5cyB3YW50IHRvIHNldCBJUFY0X0ZMQUdfTU9SRSBy
aWdodD8NCg0KPiAJCQkJZmxvd19tYXNrLT5pcF9mbGFnID0gSVBWNF9GTEFHX01PUkU7DQo+IAkJ
CQlyZXEtPmZlYXR1cmVzIHw9IEJJVF9VTEwoTlBDX0lQRlJBR19JUFY0KTsNCj4gCQkJfSBlbHNl
IGlmIChudG9ocyhmbG93X3NwZWMtPmV0eXBlKSA9PSBFVEhfUF9JUFY2KSB7DQo+LQkJCQlmbG93
X3NwZWMtPm5leHRfaGVhZGVyID0gSVBQUk9UT19GUkFHTUVOVDsNCj4rCQkJCWZsb3dfc3BlYy0+
bmV4dF9oZWFkZXIgPSB2YWwgPw0KPisJCQkJCQkJIElQUFJPVE9fRlJBR01FTlQgOiAwOw0KPiAJ
CQkJZmxvd19tYXNrLT5uZXh0X2hlYWRlciA9IDB4ZmY7DQo+IAkJCQlyZXEtPmZlYXR1cmVzIHw9
IEJJVF9VTEwoTlBDX0lQRlJBR19JUFY2KTsNCj4gCQkJfSBlbHNlIHsNCj4gCQkJCU5MX1NFVF9F
UlJfTVNHX01PRChleHRhY2ssICJmbG93LXR5cGUgc2hvdWxkIGJlIGVpdGhlcg0KPklQdjQgYW5k
IElQdjYiKTsNCj4tLQ0KPjIuNDMuMA0KDQo=

