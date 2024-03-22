Return-Path: <linux-kernel+bounces-110908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E16D886584
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F262CB230B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647FBE66;
	Fri, 22 Mar 2024 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Mrxk+A4O"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E887BE5A;
	Fri, 22 Mar 2024 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078720; cv=fail; b=fzmlmgITNoALnPqdAfzoIDBJvVQoDn717ipizkmKdzuXIcwCG0Cf00zrqDxdIRrq608SqMuyFpPUxiNLFH1GK9SnNBYcChtSe93Q0AfZ/6OivTDeo2+AzCgRATmIVbrjh5+uORL6WfTMLVWCgiQ3mKGX6au8DUlMXhHbS/tnu/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078720; c=relaxed/simple;
	bh=yA9d88Krcs7AWN8yZPe8fsSZXzn1qqoV+1vxWjdIq0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TXe/d14nDh12GZcSYLjlB75hbl8/c1Z4wk2MCA0zS9LYNDn5XxwQcopmc4KSEupQzQKaKRhjfL7nfwEBhacp2m7Lh1lHvuUu2I1AnBTKfn0XrAy0bR0u4wZSAGJC9+H1HsF+RuJT22wpGemz45i1GzNa7R45aC73RYVvVezyN0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Mrxk+A4O; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LMhLEJ006650;
	Thu, 21 Mar 2024 20:37:56 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x0wx7gpb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRHx6xnmogajkECi0nQ90TrtQbrA7F1HP60N/cHvFdkBN5Jq/k7BvD3LxxOWFojpRM1FoDJcuAPvMFrfXzu5yRr0NpTZzuqA5WUPjgDpHwMPZy1Japk6RX30RUfhU46eCx4USCQ9hxMHe0Y7XN1n6eM8pVIhGR0d20JFxfeV9oKzH54LviXQeRx+Co+blQ2EwEFQYaewhHLPsgclogGyW54ZFuXUQh6pkFwHot402tZNNWLf1URAlUER+YztKcoPlMR00GA7d0sPDkx5TSOWk/V0UFjr6oB3r4K22E0O051ScLGKeYAnXIN1M5EmyX5WRmRFmqftuWYniEAufTDq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA9d88Krcs7AWN8yZPe8fsSZXzn1qqoV+1vxWjdIq0g=;
 b=P3KSZcs+KJpegBJL4rHf4YMZR93EqWu53v8fTSdNB+vnvfQhmf9efVdCM6rfUmCHJK5iUYqGVDjRQY3oI4hzrv8ika2p5AWdS0VwhvSvk6mH/IsTcYovC7qsrmGscStj9CI/6r4ffmG0ukAAmmDUhwmPQdD6RCWX4XuEs5EIbXJ8vtT1QpZ4pTKphbLRZIlnjHiebJE0s10N6yhK+6Nf++/PhuzvxxH5cc341lPzxewgyEQVgspSR+y/JwaEDOCJQE1lp1ZPRkt6Q+IgNYbk0hmDa8ztoRvTWvhyLuHRG6f88TcAxTlMrUvaVMcjD5NCOwYnQKxp8Nl9NzXhMlO9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA9d88Krcs7AWN8yZPe8fsSZXzn1qqoV+1vxWjdIq0g=;
 b=Mrxk+A4O/zYqPrOPDhFfUl/GSfuf+kpXuyMrUh1YKPTPdtgynbkuzKlD2M35lKlHhaX7zCdSgTSATRFKwhoR8OD0n1pZ+kMPogDJqcJozNdtCJ/X2uTLO7QH8FAMdQ50MSEVALAXoXz8tCKHkMEOvMGS1bihx8Gi3QIc5xXREUk=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by LV3PR18MB5615.namprd18.prod.outlook.com
 (2603:10b6:408:197::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 03:37:54 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72%4]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 03:37:54 +0000
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
Thread-Index: AQHaeQ/FomqULxvNBkC/k1/miqR3YLE9iUYggAFIJACABFCioA==
Date: Fri, 22 Mar 2024 03:37:54 +0000
Message-ID: 
 <MWHPR1801MB1918BF213DD974CB5A6CF032D3312@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240311122401.6549-1-lizheng043@gmail.com>
 <20240311135117.GA1244788@maili.marvell.com>
 <CAPCnf4zS=FN0MHM2tQV0b468zN0yqRHbaNMsk3cDQ7Vu8wiHKA@mail.gmail.com>
 <MWHPR1801MB19185089A3147123D1E877D0D32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <CAPCnf4z0gp47TkxP+PFw3bd_Weh7=jn9Q2t-z6QB654Ckc36Pg@mail.gmail.com>
In-Reply-To: 
 <CAPCnf4z0gp47TkxP+PFw3bd_Weh7=jn9Q2t-z6QB654Ckc36Pg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|LV3PR18MB5615:EE_
x-ms-office365-filtering-correlation-id: 90360e18-7f40-43da-83b4-08dc4a2175b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Qpr5EWBIhUMYyFlJ4szRgk4Ihiawg+jOg4V9O2nDWZW8GWWSOCgrxtIPGMPHHP55j9dOPle06dyha2WBXobZh86Mu7FvduCNf57VawwiMNqZQBs2lSL1lZSHwdOM4trTPMkYRVSn+F3hdVpe1nxQSVTJ/9el8xPat8k5e02+iisci5Xjm8HFlyWSCQHnGFJT2lQi6Yif6VmZiVzSIGkG96v4RaeVMIDS7f25byok+dcGDOmIZiS6FfglHFAKdZUHIgZXsXlMHoIKVVHGOzazEPWqL9FlrjSPLDdxUpSTUmPbKjXNJyYGU7EbhKfxqFVFyTOdk0CrNckUgRWkdIa/AA2feq5SoLpBboM4UkD+4BN4dP+DuU/pyO3ALz9cl1y0h5egIPUS3SvE4wZ1Hro6YjP902Wt7YHkDlFJ0CzXadoZmTIhFvZuQa/j+V4nVKWGuZY6i/8la9sNUlNWC+Vw/gRgw4wPQ10dE5xQBL1sTX9F9cvonbfouQVGC/8VH6yum5VIFWmeiWTQMnLwEiOhrhzWz8CjLVocSKRLDcTnVyaWMkTGXfrRQ5N9B3FNeBc/FeyJk1Wync1q4E/cEiVAPer4dEWg/VeVfYxEwyzO5Ex0C9yTj4sGz37t114uBNkxPNSELr3yDk/RsgnRdlyPUi97MikwCQRXj79m63dHF9GnJjjOQO7vxwf1ImMEOWwejKR8RL4771T7aJ9VRkiNbw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K2xiMTZxMTE3NU9mNDZFL28xQ2NlQ3VtT0dTMXZYNVpMSXpOVng3N0FLZEJJ?=
 =?utf-8?B?alRkWm5sRXlvZ2xqdmxMKzF4R2hEdFVhejEzL2NZMkVoVldCcGhETjNwVnBl?=
 =?utf-8?B?bGRaOE41ZG9NcE5nTHhzclFUdVJQNXIrcW1UVzdLNENaaXFCeUJtYkNadHA0?=
 =?utf-8?B?ZU0yUXlPd29CVVB4WDRGRG92YVRsMCt2NFFJQUhxYk1kNzZ2VkZUZjBLTWQv?=
 =?utf-8?B?QUxZYW4rKzJDOXFrU3JidGVtc21RenBpeEh3S2RyRVdFZGF5M29nK0xkcndL?=
 =?utf-8?B?Q2pwVTBSQStDZmoybUxCRHhvcEIvSXVpQm9ORWdOaEVVNTN0dXhrMWJ1MEhF?=
 =?utf-8?B?bTRLOHNhcVBPaTZscWg4RGZvT1BBUnF0VjZxVzd3dlBUVmoxOVEydThnTFhl?=
 =?utf-8?B?bmtISXdZL0IzNHVhWnJsRmRaeTdUK1BtdkRUdTBkRjZrcTcwbEVpLzZtVzVL?=
 =?utf-8?B?eEVmNEswd24rUnVyNTdCalg1cTErdTkzclhHQXF6WTQxbGV0RzRHODI0UlFo?=
 =?utf-8?B?M0JET1MxVFR4U3dpaGZ1ZXBncU5RRkJMZXdRVEZ1TEV1aG04RC9mdDJocVAw?=
 =?utf-8?B?ek15R3BoSlkwUXk3em43TWM5RnNQZEdQc1J1NWRBajd6QmoyL1g4YU1XUTZL?=
 =?utf-8?B?aG1WQVVlM29MNTZHRjJtRVkrYXdFZ01RbjB3YldSaG44YXNhQWNOajhlU2pB?=
 =?utf-8?B?ZGo0TmkyTkdDQnlLVHkydm1ua3FYMEZsdXh5RDJ1czFTWUlGdU9lSmpZMEsr?=
 =?utf-8?B?QWZyYlZLZjVwOFl3T3lHdUVqdm1ITiswMW5xWGx4Q2tKRjhTT0haZ3UxczN0?=
 =?utf-8?B?MGJWcUNIOEZMNmROcjM0bHJXTjFzK3lrSUxMOVVKeDQ1ZUc2aWw4TStjVFlm?=
 =?utf-8?B?OVNUbzRPV2FPQ2ZQNzMvb3FHRFJ6eHl5Nk9Selgvd0pkRHRaSlpXV280Nk13?=
 =?utf-8?B?Z1VaZlJjTVphdmwyMW56OG5CUmtMOXZUU2E1MEtjRDYyV1lSaU8zZy9ISUFm?=
 =?utf-8?B?WWFXdDA3QXNORmtmU1o2cU82d1BqZE9rMDdVWnBFaHBrVGtWZWphaFI0d3pa?=
 =?utf-8?B?VXF4aVNHblUydTZrM05BQUlPOVl5VldFdGd2L1lqZGJrc3ZwcmxZbjJnU0Z5?=
 =?utf-8?B?aXVlM0t3c3dHdHpPdXpncmZuYUdzUjVKUGszYkQ4bGVaNVJBT0JiZVVIRUtx?=
 =?utf-8?B?WUtHM2xDdm85bFpJYVYwOFU5OGtMU2hZR09tREpHVERDRi9BMzQyVnl5Zys2?=
 =?utf-8?B?cFh4SERkRk45NFdCWkVKK3U2a2lKQkVieE9qNGFCQ3U4bG1zbFFmcUhES0pS?=
 =?utf-8?B?SHBWdkFIc3RLYVZjOHg5Y1dUODd6L0x5eEhBSmliRDdHWVlEQXY3eStvVXF4?=
 =?utf-8?B?Rk15bUN5MGJ6R0FwS0lxaVl6WkpvK1JtUTViK3NWT0VrNUw4c3J3dEVRSmZm?=
 =?utf-8?B?anBNL0k1NFRVeUZXOHNDUGdXTVB3ZHFpQTVURkY5YitXcU9aUG5HakZ6MHVF?=
 =?utf-8?B?SUpqRnNadWNRSzIxWGpaRUVnT0ZqVzNUVkhkWFhmaFFiVTBvcVNBek1NdDRH?=
 =?utf-8?B?YmJHeUpJajNRQ0JnL0htQmFzdWxnS3kyVjdNcko0N01oc1NWa2c5dm10MVdZ?=
 =?utf-8?B?eGMxd0J3QW0wMWl0dkd5K29MUGVQaDN0aG1yVHBrMWE0U3NoMmdjWWRBdnRG?=
 =?utf-8?B?NkJ3VloxVkZXbGhSNEtmYW8rNmFkc2FJY2Q3K1g3UW90Uk1QNCsvWWtQVzRP?=
 =?utf-8?B?OWZ0TFo4T0creDV6TE01QnRxeDVEQjVkWDAzMC9xWDZvTDhBNXYvUjBWNEJY?=
 =?utf-8?B?V3JKQVA5Sm1SOGovY3NZMXVtY1VZUGMzdzdrdWhRdU9Ba0N5OEV6cXdra0Zr?=
 =?utf-8?B?M0loUG9kNXFGMTM4Y3pycCtFNzU3c2ZGRU5RM0ZwMDl1eWljTFdkQ1NuZXIr?=
 =?utf-8?B?Ulpma3Z5Y2FnZi84aXNrZU9sWGxCY0Q1andST09pbHgzbE1YNkZYS1JtbDAx?=
 =?utf-8?B?TS9tNGhCcnJmbDh5eitSZHl6TEQ5VUFvaG96L1pUK3pURWZIejhyRnMwSERM?=
 =?utf-8?B?dXNyZitqL1hEY1ZLTGxNVU1kMGQydVE4dTBWRE5VS3ZVQTZMd0V2VkZ5Wndx?=
 =?utf-8?Q?6EOqDugeSafHPigYMM3g5fZKP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90360e18-7f40-43da-83b4-08dc4a2175b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 03:37:54.8626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoJ2rAK2WF4YUIRjkgiq9bXv+qDdBFkDxgyYg5OZ/DKekctL4OV/mb12TSLV97GZ6dOtNm2cqz1fVh7i2777qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5615
X-Proofpoint-GUID: GpLiPFe_KMG-P-9pfNnUr0SQgDG3ucOK
X-Proofpoint-ORIG-GUID: GpLiPFe_KMG-P-9pfNnUr0SQgDG3ucOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_14,2024-03-21_02,2023-05-22_02

PiBGcm9tOiBKYW1lcyBMZWUgPGxpemhlbmcwNDNAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBNYXJjaCAxOSwgMjAyNCAzOjEzIFBNDQo+IFRvOiBSYXRoZWVzaCBLYW5ub3RoIDxya2Fubm90
aEBtYXJ2ZWxsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5ob3JtYW5AdHV4ZHJpdmVyLmNvbTsgZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsgam1vcnJpc0BuYW1laS5vcmc7DQo+IEphbWVzLlouTGlAZGVsbC5jb20NCj4gU3Vi
amVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gbmVpZ2hib3VyOiBndWFyYW50ZWUgdGhl
IGxvY2FsaG9zdA0KPiBjb25uZWN0aW9ucyBiZSBlc3RhYmxpc2hlZCBzdWNjZXNzZnVsbHkgZXZl
biB0aGUgQVJQIHRhYmxlIGlzIGZ1bGwNCj4gDQo+IEl0J3Mgbm90IGFuIGlzc3VlLCB0aGUgbG9v
cGJhY2sgZGV2aWNlIGNhbiBvbmx5IGJlIGNyZWF0ZWQgYnkga2VybmVsIGl0c2VsZiwNCj4gbG9v
cGJhY2sgbmVpZ2ggZW50cnkgYWxzbyBjYW4gb25seSBiZSBjcmVhdGVkIGJ5IGtlcm5lbCwgb25l
IGxvb3BiYWNrIG5laWdoDQo+IGZvciBpcHY0ICxvbmUgZm9yIGlwdjYsIGltcG9zc2libGUgdGhh
dCB0aGUgbnVtIG9mIGxvb3BiYWNrIG5laWdoIGVudHJpZXMNCj4gZXhjZWVkcyAyLg0KQUNLLiBJ
IHN0aWxsIGZlZWwgbGlrZSBhIGhhY2suIFBsZWFzZSBwb3N0IGEgbmV3IHBhdGNoIHZlcnNpb24u
IExldCBtYWludGFpbmVycyB0YWtlIGEgY2FsbC4gDQo=

