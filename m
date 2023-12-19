Return-Path: <linux-kernel+bounces-5956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7030819222
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9101F25B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934813C6B9;
	Tue, 19 Dec 2023 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PGuCVDPq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6483BB47;
	Tue, 19 Dec 2023 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8KAjGbJ5Ns4DgZEQR2nE1yWKzhRytS5mJGsQgDpT4ybjKp4KUSdBjIFAFbfpwczgUo3G2DQ5idgviFvYCxuTp3WG5swAwru/WaA5zqQEgLtqO6ZSpVVRBm1ce8xewo1zBJtRRlT/eDDDQX9l39x7CwdpmDc9PhsC1e+UuiLhuDzNHP3glfXhlj8jVc7qn2ZOrzaiU0vYkZfxldOrH4rKlt7yY2upsuEevmcJAdskZhKE9wk4I12qDeEg0xLtUiFDIpkeGlh6uuCsH9qIiB4na+5pq+Vai5ct/5TMZjdjOpNo7W/m+qbVLqUiskVl+CXSLuZW3wW9hsrM6sX3J+ziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDAyDupEkTroc88GlXuwxe8qGsJo9vqG+aXTxpf1jzs=;
 b=X7xv2dOykQfzv4qZAEkDo62uUz7jLluVlFoXHvljFUz2W2ABE57uP2ksjSFN1maUPZ88e8BuEAMJ/7wkMSzw+T78o25omalrcmzrfd4MXhYCR5lyqojechiusoj7ZAtwYv6whEsuzNgrE4UoYDgbTU1YYM+M53e/DER+fYTlyDmdrPzCtnM9V7+2WZFisNKjRD7zZ2XZYc6HEY5A9Mp3n/oOjRFI3l1vdv6fTlrHVlyiT1Sh6Qc0GTfUvsaKI52A5655J9iplMPUMzzA3AJKxT+j90Njx1TJ+b0f2NrGrMg6Tr9nubxX7S9No4tWWmUJh1EhVUMAkXMAE/84eNSL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDAyDupEkTroc88GlXuwxe8qGsJo9vqG+aXTxpf1jzs=;
 b=PGuCVDPqPVVXkgLkZ6nz/lG0VfKMJDGsDYfDONXrMPNkrAAoHhRh1x8yYIHKcCHvwLu8NpRS3AArIPYCWjCnEcpnK7EnltC/2ZYbeAKpuokcBLKb716ZANyxsbzrTGjmfd6RBUX5mvHmdgjgbrgfF1umNVPEyXWn4/+ZK3ye6LEM7zaivKU3URsvmpxM1SGSBpR5qOd3WBPG4MqgM+ddm1fIhsUrdR3e64cF+lQ85q3Di0wc6hZ3eF0sVZEkCLgr8/nJ//ofvYZG6jlXJQD5FlEgWsH3R4Mb8fVAHN+GLUMg8c9/++XYy0MfwSVRCUHXmrvomkWjCbHRGvIdPf8OKg==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 21:18:34 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::e0a8:ea57:c1b2:28ab]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::e0a8:ea57:c1b2:28ab%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 21:18:34 +0000
From: Liming Sun <limings@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Christian Loehle
	<christian.loehle@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, David
 Thompson <davthompson@nvidia.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
Thread-Topic: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
Thread-Index: AQHaGiWuyqF2YA89PESSY+mtaOAx97COOQuAgASwglCAES9egIANNBpQ
Date: Tue, 19 Dec 2023 21:18:34 +0000
Message-ID:
 <BN9PR12MB50682F406ABEF9999CEEF1D0D397A@BN9PR12MB5068.namprd12.prod.outlook.com>
References:
 <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
 <3912dd1e-b15b-49a9-9c91-88e00e986efd@arm.com>
 <BN9PR12MB506854D38EA7E2702319F1AAD382A@BN9PR12MB5068.namprd12.prod.outlook.com>
 <66aa74f5-0613-49eb-80d3-ce4381f717ae@intel.com>
In-Reply-To: <66aa74f5-0613-49eb-80d3-ce4381f717ae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|CH2PR12MB4277:EE_
x-ms-office365-filtering-correlation-id: 647d9ceb-5220-42de-f17b-08dc00d80ed1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WWUrZMEgrFYpqCo3MT9AOI+tmkWQWIRss7qPcoSEs9/Ma6X+TSjccsHfj3hov/KU4HBqv9JYUrdMlrS26obzNovAZahzC9ewXXNA7a3bxfaXIAaGAEa1sRTOptTNxXhPHiaaaLQzLMmWvJzC5twhYAKFQQrARpbXbZuXD1zLNHraBjH7F+6dT/KBFMz5BNPBSx5FRwGmrVCMeO7CJnFJW0hwLokKuXFQGyb6sAl8tfKIicxOxipEhMxCWqXCvAOGaTCieHT9Jk7nbBtYZEdDvDWdKebOhCeb2Zr+ap9JkMMD40zdRYUKaOJ+fJMnr6BDMS07PdB88vjut7am1nOjZzi+vShf7iS6XArYeDI+5t7J6TGhI+S+fKylIqbLn4XeC3qdu4qOVp6S8zoU5nZzq/y2S8hCmKA6t0tR4EIhhbCOYiceDXHde/feBBqD6ANZwmLdk8YK7R7Fd4I1u9W2iMAc2/TXl/YEtxmAeGDF4meowZfKf4QzFjn3Zcg0hdlzGqKzELIpA5tJXDg48v8y/IO2RKPY2cCf0c8bRG6VRE7lYLHW+SaT6I9VpjgDQgjE1PjQlt7Gsd3BCs4hwd+jaY3Nyu7hh8/6W9VfZI4sDtI8xptkiWsfHHSgaBsV0lAdUbYaPl46Ar2H5aaHvEQtag==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(26005)(86362001)(38100700002)(122000001)(33656002)(38070700009)(52536014)(83380400001)(5660300002)(9686003)(7696005)(53546011)(71200400001)(8676002)(6506007)(4326008)(66946007)(76116006)(54906003)(66476007)(64756008)(6636002)(110136005)(66556008)(8936002)(66446008)(316002)(478600001)(41300700001)(2906002)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjNLQ3lFUElOVmRjbHp1OWFiUkNYLzF5QTNCM2xWdFdORm1qWlVzTWN0QXNK?=
 =?utf-8?B?bDczaGdmVlNEUnEreGpJcGc0SWlORHl1MTJxWkpFR2VxYlVsZUJEN2xOZjNZ?=
 =?utf-8?B?Q0swQTRSNGcwRGlEZXdXRlRoRThCSzZkc1BkTTdocmFsOU0vc2hNeHlCanRj?=
 =?utf-8?B?WVJSaDNRSVFVZmJ5WlNSZVZIU3ZtZWh2ZkJEbHZzMFE3NXRSYWVNU0MxVDly?=
 =?utf-8?B?SU83dTRLMFEwa1oyUjBKRVRuKzlYL2tSQmIyWjFObGlBUnNmM3BIMXBWV1VH?=
 =?utf-8?B?VXNacVFBeWx2eFNTTGhoUFcvNW1va0E0bmJxakQ3QmVSdGZ6dERGcGpDMFcw?=
 =?utf-8?B?R2Z6UHcweERlWmZKd0Mvek5XdDloZUI5dGFaSFpUR1VZNDF3RHM5UzBsYkdZ?=
 =?utf-8?B?OWNOTHZ5SGdJSWlLRndDNk5VbGYvOGk2UzZGN2lVeUl3Y1R5QTNRdy9lMlEz?=
 =?utf-8?B?dmRScUxZTkRYNUpySDNDNFpTNVJTOEN1MDVsZy8vTlMxQXpjQUtyMFJrazc0?=
 =?utf-8?B?MnRYZ0tRU0ZLUDZUNlZ6cFRnSElZd1o4RmIzZWFITUYzREhvWDJFYnJFcFNV?=
 =?utf-8?B?WkhnNjNXNHZCS08wNVgwa2pYUmgyaTM3YjFUblNlaTNBdEtEMHQyZXlGVkN1?=
 =?utf-8?B?eWRHdlBrQVJsd2N6eGdERitPemdKd1Q2VWkvNi9EK0txbGR5cmtaRGhPblhX?=
 =?utf-8?B?QnhLRXUvSUtaNW16ejJjWGM5S24vb3NqVlpQb0duVmNVRVJxR2xlY2pwMVMw?=
 =?utf-8?B?WFZ4US9OZ1d5blVQMEE5TmRJdXZhNmV6WFd2ZVFicTFZZXFZRndKZk8rZ1k5?=
 =?utf-8?B?cEdZV1haUlVHd1M2NjRmTTFPZVZsSkU1K2pVbEhJblgzdzVMTFE4bXRyekpO?=
 =?utf-8?B?M1Q5QXcvL09rYURXUDBQY3RrUEJ4djhVSkRLbHhNNlBwaTVOaWt4bWdpWkZR?=
 =?utf-8?B?WmVla2krOUJkUjlCanJZSzN6RFAwRnJmSm55clplTStZVUNkeVNQOW1ranlt?=
 =?utf-8?B?R2hkYnUyYnJOVEU5ekl1VGl6NFlETG1pemlCcGRSakFKYTFJbFFLVWRoWUdE?=
 =?utf-8?B?TmlYVklGZ1FKd1lGaW1CTEhJLzQrSjlUVHdmRGszYzNHbjRiWmtKQUVNUDl3?=
 =?utf-8?B?dDB0Z0JtNEpNbTdDZHRyUTVaOUVZVTRKWk00R2VDTE5CVHlvakJBMXYzUTVT?=
 =?utf-8?B?ZlJNcGhVSWZIb09QZnRRRzJubHFhVFg3dFpIajBJaGgvRjZKS281WExnS3pq?=
 =?utf-8?B?VUVJd0MyUGltVktJNHRjamlva1o5ZmMyZ2FMeE82YUQ2RzNrbFMvc3RCa1o4?=
 =?utf-8?B?RmR3RnlJZG1Kb3gzZmt3anB2S3FoOVRhNWdxVkxPaEFjaFBHQlJOS1lqL3c1?=
 =?utf-8?B?eVVKcndHdDdTeExJQWIzekEzWjBlQ0k4aTFaYzJsUXZaRmhOOTlTUXdSK0xj?=
 =?utf-8?B?MWx6SnV4VG5WUUZHS0hGYkY5eTdoM0g1eGpTQm9DQjBRWEs2N2JvRVg1TDlS?=
 =?utf-8?B?UjFPNUx5akFhNUFybks1b3RzNlpPZWVXUGFCQ2N5SXNjR3ZYb2RQNWdsVGpP?=
 =?utf-8?B?WGxXV213N3VuelJFZnhTOWdKdDRuM0pyL1VkKzVzY21KdzFBNVF6enRqMngy?=
 =?utf-8?B?ZXVCWnhRSkZCUlM0YjR3YUZTZ1ZtRGJlTXlWdURCWmI1RlFhK2ZneHJQbTRC?=
 =?utf-8?B?RmdXcnNvenpTaElZdXBCOW1FZnVVRVdtNEp2S1NySStGbG81MUllb0dGZDNJ?=
 =?utf-8?B?Uzlwd1FlSGZQNUREa2VKZ3VyQ3J3MXlKUWs1VDhYRE1UZXV4a2plV0cva3Nq?=
 =?utf-8?B?RnRhRmlPRTNnL1ZRczZTMDJIKzltUFdtZitQcXVBcXlNMUZ4V21UcnBXakFR?=
 =?utf-8?B?bk9wZjNIVm1UaFB2aFhnTmRqeW91VmVRbmxHSFZDbGViNXdseWhDVE1WWisy?=
 =?utf-8?B?MU5zNUZmTTFSVjc5UlVnbUZ1Kys0anludzFJdTQvZzhDblAyNUZmWVNITkV2?=
 =?utf-8?B?RS9GN290dUx0bC9WdHJrTWd4RDFweVFTVW9sbjk2NU9RZ2lzK3FaNjZ4YTN5?=
 =?utf-8?B?YTJxTnZhR0xlOUxCYTNJa1RMTUtNSDNncHZqU2x4R09vQlladm5Ed2NRUUlZ?=
 =?utf-8?Q?1hOs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647d9ceb-5220-42de-f17b-08dc00d80ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 21:18:34.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILvZIaFal8X6gM4dmzJuyhccqgoG4DDLCVrWiB8DiNB0eX6NGYDX8UyWiQ0CxHdwD0Z66rAm8hbo17wul0rh7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTEsIDIw
MjMgNjozOSBBTQ0KPiBUbzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPjsgQ2hyaXN0
aWFuIExvZWhsZQ0KPiA8Y2hyaXN0aWFuLmxvZWhsZUBhcm0uY29tPjsgVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+OyBEYXZpZA0KPiBUaG9tcHNvbiA8ZGF2dGhvbXBzb25AbnZp
ZGlhLmNvbT4NCj4gQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzFdIG1tYzogc2RoY2kt
b2YtZHdjbXNoYzogRW5hYmxlIHRpbWVvdXQgcXVpcmsgZm9yDQo+IEJsdWVGaWVsZC0zIFNvQw0K
PiANCj4gT24gMzAvMTEvMjMgMTU6MTksIExpbWluZyBTdW4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDaHJpc3RpYW4gTG9laGxl
IDxjaHJpc3RpYW4ubG9laGxlQGFybS5jb20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIg
MjcsIDIwMjMgODozNiBBTQ0KPiA+PiBUbzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29t
PjsgQWRyaWFuIEh1bnRlcg0KPiA+PiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBVbGYgSGFu
c3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IERhdmlkDQo+ID4+IFRob21wc29uIDxkYXZ0
aG9tcHNvbkBudmlkaWEuY29tPg0KPiA+PiBDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYx
IDEvMV0gbW1jOiBzZGhjaS1vZi1kd2Ntc2hjOiBFbmFibGUgdGltZW91dCBxdWlyaw0KPiBmb3IN
Cj4gPj4gQmx1ZUZpZWxkLTMgU29DDQo+ID4+DQo+ID4+IE9uIDE4LzExLzIwMjMgMTM6NDYsIExp
bWluZyBTdW4gd3JvdGU6DQo+ID4+PiBUaGlzIGNvbW1pdCBlbmFibGVzIFNESENJX1FVSVJLX0JS
T0tFTl9USU1FT1VUX1ZBTCB0byBzb2x2ZSB0aGUNCj4gPj4+IGludGVybWl0dGVudCBlTU1DIHRp
bWVvdXQgaXNzdWUgcmVwb3J0ZWQgb24gc29tZSBjYXJkcyB1bmRlciBlTU1DDQo+ID4+PiBzdHJl
c3MgdGVzdC4NCj4gPj4+DQo+ID4+PiBSZXBvcnRlZCBlcnJvciBtZXNzYWdlOg0KPiA+Pj4gICBk
d2Ntc2hjIE1MTlhCRjMwOjAwOiBfX21tY19ibGtfaW9jdGxfY21kOiBkYXRhIGVycm9yIC0xMTAN
Cj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBMaW1pbmcgU3VuIDxsaW1pbmdzQG52aWRpYS5j
b20+DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMu
YyB8IDMgKystDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LW9mLWR3Y21zaGMuYw0KPiA+PiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5j
DQo+ID4+PiBpbmRleCAzYTNiYWU2OTQ4YTguLjNjOGZlOGFlYzU1OCAxMDA2NDQNCj4gPj4+IC0t
LSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jDQo+ID4+PiArKysgYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYw0KPiA+Pj4gQEAgLTM2NSw3ICszNjUsOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX3BsdGZtX2RhdGENCj4gPj4gc2RoY2lfZHdjbXNo
Y19wZGF0YSA9IHsNCj4gPj4+ICAjaWZkZWYgQ09ORklHX0FDUEkNCj4gPj4+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IHNkaGNpX3BsdGZtX2RhdGEgc2RoY2lfZHdjbXNoY19iZjNfcGRhdGEgPSB7DQo+
ID4+PiAgCS5vcHMgPSAmc2RoY2lfZHdjbXNoY19vcHMsDQo+ID4+PiAtCS5xdWlya3MgPSBTREhD
SV9RVUlSS19DQVBfQ0xPQ0tfQkFTRV9CUk9LRU4sDQo+ID4+PiArCS5xdWlya3MgPSBTREhDSV9R
VUlSS19DQVBfQ0xPQ0tfQkFTRV9CUk9LRU4gfA0KPiA+Pj4gKwkJICBTREhDSV9RVUlSS19CUk9L
RU5fVElNRU9VVF9WQUwsDQo+ID4+PiAgCS5xdWlya3MyID0gU0RIQ0lfUVVJUksyX1BSRVNFVF9W
QUxVRV9CUk9LRU4gfA0KPiA+Pj4gIAkJICAgU0RIQ0lfUVVJUksyX0FDTUQyM19CUk9LRU4sDQo+
ID4+PiAgfTsNCj4gPj4NCj4gPj4gX19tbWNfYmxrX2lvY3RsX2NtZDogZGF0YSBlcnJvciA/DQo+
ID4+IFdoYXQgc3RyZXNzdGVzdCBhcmUgeW91IHJ1bm5pbmcgdGhhdCBpc3N1ZXMgaW9jdGwgY29t
bWFuZHM/DQo+ID4+IE9uIHdoaWNoIGNvbW1hbmRzIGRvZXMgdGhlIHRpbWVvdXQgb2NjdXI/DQo+
ID4+IEFueXdheSB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gaW5jcmVhc2UgdGhlIHRpbWVvdXQgaW4g
aW9jdGwgc3RydWN0dXJlDQo+ID4+IGRpcmVjdGx5LCBpLmUuIGluIHVzZXJzcGFjZSwgb3IgZG9l
cyB0aGF0IG5vdCB3b3JrPw0KPiA+DQo+ID4gSXQncyBydW5uaW5nIHN0cmVzcyB0ZXN0IHdpdGgg
dG9vbCBsaWtlICJmaW8gLS1uYW1lPXJhbmRyd19zdHJlc3Nfcm91bmRfMSAtLQ0KPiBpb2VuZ2lu
ZT1saWJhaW8gLS1kaXJlY3Q9MSAtLXRpbWVfYmFzZWQ9MSAtLWVuZF9mc3luYz0xIC0tcmFtcF90
aW1lPTUgLS0NCj4gbm9yYW5kb21tYXA9MSAtLXJhbmRyZXBlYXQ9MCAtLWdyb3VwX3JlcG9ydGlu
Zz0xIC0tbnVtam9icz00IC0tDQo+IGlvZGVwdGg9MTI4IC0tcnc9cmFuZHJ3IC0tb3ZlcndyaXRl
PTEgLS1ydW50aW1lPTM2MDAwIC0tDQo+IGJzc3BsaXQ9NEsvNDQ6OEsvMToxMksvMToxNksvMToy
NEsvMToyOEsvMTozMksvMTo0MEsvMzI6NjRLLzU6NjhLLzc6NzJLDQo+IC8zOjc2Sy8zIC0tZmls
ZW5hbWU9L2Rldi9tbWNibGswIg0KPiA+IFRoZSB0b29sKGFwcGxpY2F0aW9uKSBpcyBvd25lZCBi
eSB1c2VyIG9yIHdpdGggc29tZSBzdGFuZGFyZCB0b29sLg0KPiANCj4gZmlvIGRvZXMgbm90IHNl
bmQgbW1jIGlvY3Rscywgc28gSSBhbSBhbHNvIGEgYml0IGNvbmZ1c2VkIGFib3V0DQo+IGhvdyB5
b3UgZ2V0ICJfX21tY19ibGtfaW9jdGxfY21kOiBkYXRhIGVycm9yIC0xMTAiID8NCg0KVGhlcmUg
YXJlIG90aGVyIGFjdGl2aXRpZXMgb3IgYmFja2dyb3VuZCB0YXNrIGdvaW5nIG9uLiBJIGFzc3Vt
ZSBpdCdzIG90aGVyDQpNTUMgYWNjZXNzIHdoaWNoIGFyZSBhZmZlY3RlZCBieSB0aGUgc3RyZXNz
IEZJTyBhbmQgZ290IHRpbWVvdXQuIFdvdWxkIGl0IG1ha2Ugc2Vuc2U/DQoNCg==

