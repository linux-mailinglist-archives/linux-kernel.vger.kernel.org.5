Return-Path: <linux-kernel+bounces-126060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA74893190
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 14:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E9D282472
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0811448DF;
	Sun, 31 Mar 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y07VpYWF"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA30290A;
	Sun, 31 Mar 2024 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711886869; cv=fail; b=TRHL7Gf4Esi8/RQlnvt3+kRZGJVQq0hd1Y9kaySJnfDosRnjiKRQmKpSaMrkh5mMw4LMHnh3RzqRZoGhVNxch2yiAUtaltVy6/HzIWy6CbGPkwW8yHwk85DacoW47A9C/wttGXRnL5jWkvMhgXnKaRhlT70MnAqLC7zuwNHq34s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711886869; c=relaxed/simple;
	bh=daogCPqBhWXV63Vka9bV7W+7SXBs/NWzzpJsHSkUpiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sPUiPraqaDYtzAYJGMgpbxUKSe7ZsGnOvdBbRJpuRGN1kZi9lxf0ADNkmQXud1qrmnw5upGY3nzAdIrYvPU6OgqqCjYm65RRXxIPTXeOqwIruL0esmKFqJ3JjXUx9eYGWWTdWDNQzoG0ZLQy6Ebge7deFCGKAwChGvWO+Pvt3eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y07VpYWF; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42VAgM4q003453;
	Sun, 31 Mar 2024 05:07:24 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x6j8g25es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Mar 2024 05:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuA82HrbFDxffSMMFi6ApSoqUmYWr8QNLTOn5vGd1RNbro+zaYUGsM2hojmdUCK9qitpHnEL2s+RjdnxJqHnH8tfhboKin+gbdCMQtTA3wGyYBEHc1TyKmxX9cK54uzrUdsbGj0zlnyYhkyP80uR88GWB7F4iq9r5ld4txtDTlQGPPRPGG72coP/qeQOrrETbCJMIvV/Dv+gLxP80XfGZG4IA254ctS/lMkSWrgMmBs/1maRgYOPOBxuIfCvYaeXvyOh4HNZkgAudCIGFHPbm2j9g3SyEGjfeFhlFtIfxTvkM/wLgsA6SwK64VIeeyI0SN5awIrqnG+FJHmVCYwaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daogCPqBhWXV63Vka9bV7W+7SXBs/NWzzpJsHSkUpiw=;
 b=avJ6BocpzwFHEC19cVxwbjpfETeZ3r02nXuokkQf09+wzh/LIFyr6WB/s2w7PyZ5esS27+8zJgvpXLvEf3nmjQF/YoAVlosquGVM0M8Z5Rhf9Fo2y9+7Ncmwd28hzyYZJZnEHSjob779TK35JJxH7D2LIzki7UbnWC1WyMk+HVtbc14Tb8rJDlE+5hvDP7DXIdOaK1ujqahS7RLjqf9q5nVs7XP7ErltudeEutexlE39d/Y6xOgx8suZcMTmZeX4nS6WVU9BKFHhhe71UyOL6vQ0cRuh1Td3fOl+0vrUyscvyAnJdrBD85j5245jGUmix53Gy0Nv96ScBUElcDbtpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daogCPqBhWXV63Vka9bV7W+7SXBs/NWzzpJsHSkUpiw=;
 b=Y07VpYWF/gD3/cxmVffTN5jubYhke3plJAte/V7gkf+yTof98MAc4zb6M+2mjF2WbQAOnFd0aXlUmZTSe45nAK4ivLR0fySoh5hlFmsHMNwehO7ArRnjKtbGoWidGjWv49UOsc4yVaqXrgRBqMrELNoVmDzJtwuXLSCATmeYWak=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by BN9PR18MB4298.namprd18.prod.outlook.com (2603:10b6:408:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Sun, 31 Mar
 2024 12:07:19 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81%5]) with mapi id 15.20.7409.042; Sun, 31 Mar 2024
 12:07:19 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Oliver Neukum <oneukum@suse.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com"
	<syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com>
Subject: RE: [PATCH net-next] usbnet: fix cyclical race on disconnect with
 work queue
Thread-Topic: [PATCH net-next] usbnet: fix cyclical race on disconnect with
 work queue
Thread-Index: AQHag2P6HvS3NH3Sc0u2PISNJphXbg==
Date: Sun, 31 Mar 2024 12:07:18 +0000
Message-ID: 
 <BY3PR18MB47078BF3C2AC43AF71D068F9A0382@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240321124758.6302-1-oneukum@suse.com>
 <SA1PR18MB470955BBB332D3A9F9A6F247A0312@SA1PR18MB4709.namprd18.prod.outlook.com>
 <04cfa214-4d45-48b1-87ba-500e3e501977@suse.com>
In-Reply-To: <04cfa214-4d45-48b1-87ba-500e3e501977@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|BN9PR18MB4298:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Q/yHKT5nqubJjI8EKZn/GsL2OnndGW45LBX7hZ2Ucr921sw3a4xT4bAA9/T0ukEsMSZ/rCHJfpVEmdTbFL4VnYh6xhWTfEydezNxifOADM9QdnL4d1feeZ7f5SeL7jdtZ+Gn9oC/WYJh3pp4jCiUYNwweqDNRQFHFQlQ4l9pPEb14m0z7FVJQ5Sh0VeEr1Mv5E+uOD1wGNhE/kXGAGolgbvu/XtOh81pfEsWwWfVUFV2QaqRnh/7bYQmfr7xNu6XE2glI5jraV/d06fcXfRLxoLOyYvqljLlqpzgHmMg5+9THfRao2icoK7efY1DZOuJuDh7IwKAAJnXZJmclRR4WCk95X4uqvfhJAfeal89biLIaFdqlR1uVLJqMivZPAB0CYIe42TyCcQ52+6BMJK/V4qrcwuipkOi7AIbzQ44Y5UdZln/A4HukeEcDJjOR3A23a30YENDpKk31bU/NYQwoD/Z/c1emmHDeJOY+rtjsuwYL4XcDHuVLEhWz6lxBkI/VabXgTE4VFL6hj1we/7GI1A/r41jaInH5CxUleBB33YNmKCTxxMQRaNgkd7pQWk0zI1Ms7iPCe1YW6BPRANoz+uRFqMh4HIvSHoIhe4u0DHUjkf86JiKJnCz5Vr08bThTLhVJoJxGIbLYZGPdATucsOxoTJxyG5vQHjtgrR4iYE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eHpiTWJhcXl5Wlg0L3dzeWhGZ0tGaE5RM3BoT1JVdVcyemkrSlpTbE8xckdv?=
 =?utf-8?B?bFJ5TlB3M2xUazBIN1hucVJYWmZHd1pDM0ZkM1ZzakxHMUR4VnFFQzVCaStq?=
 =?utf-8?B?ZzFJZlQzSDVBMjA2M0p0YzQ1YzRXeHFHRHY0bmRRYUhRU0M5QkZ6QXF6dS9z?=
 =?utf-8?B?dXhPY0I5RUxySkZIL1VYWmo5UU9QU2FOWFBuVmdQMVhGdFdGWFFOelFtbS9l?=
 =?utf-8?B?bkEvcEp4QWNuSmEwQ0NHNExqRVZRV3BtRjFMYmJwcThUVEZOWlcyR21zc1ZK?=
 =?utf-8?B?NkNmUVJ5WUs5cmpKaExncUo2V3RCdURWY3pYU3hSV1dEQm9DTXI0a05abzRF?=
 =?utf-8?B?VldkWXJ6QzhPb05ORGViT3JSQndyejJZaGVkOVp1Smt0RFd2ZlRYdjF1K0VI?=
 =?utf-8?B?czFxenljZjFURS9JT3pDcnBadkQvOWZNL2hOek9ObnVQOWh4MnRYQ2xwR3U3?=
 =?utf-8?B?Z3VyN1ZLbm1vRStYQVN5YlBFTWZwa2lWYy9pZUdZY3l0NEk2WTZBUW1kTEg3?=
 =?utf-8?B?VGVCVkNYMksyQ3c0MnpyRCtoVWZmTS8xZlhlbjBnaTVLUjZsSmlXRm5MRngx?=
 =?utf-8?B?VUNWS3oxQzZJVU05Lyt1eTRxdy9YbWJMN0xiT3AxbEkzUEI3Z2FQRytqYlIz?=
 =?utf-8?B?dFRKZWNRbmlnWFhvZTFLeWF5YUx3UUk1WVI0RXlLUDlBM2NLZ2lPaVhiV1ZW?=
 =?utf-8?B?aWtMeHdYYUtaRElBbnZHZmNsUVJ3M0JRYlA3NVRFVjhMSFRYS3R0N3RkRm51?=
 =?utf-8?B?ZjdPQ2Nnd2tzK1dNTTJVM3NNb1BlSFF2YVZxQjVjL3ZCMFdLczJjendET2d2?=
 =?utf-8?B?dEtxOEZUTnRKOEJsUzNTcXZwcWtGRE52VnRyQUZhbStTKzQ1c29KbzFxNXA5?=
 =?utf-8?B?REhaZjVpQldyRHhiSjBCYVROdmlqQ0YvTWVzeUdvMUI4K1FCY0pWMHNVUk5o?=
 =?utf-8?B?ZktTYTdwSGV4WXFBVFhSdVh0RVMrNUFMamhLUE96SWNpR3pIRE0rYmUrUjFp?=
 =?utf-8?B?SEJIL0J3dlRJUTNaVGtHZ3FTVldsSGczN0JJQUVNVm9BaFV6L1dCczRVenBI?=
 =?utf-8?B?TmRjM29XdHV3aW5yaG5yUEdnd3plU1pWMU5YUWM3UXZzM2NZUnBXT1haSEMr?=
 =?utf-8?B?QUlFOEtxaUsxeXN4dUlZZUFRU0cvQVNtVndOK2dGeXZvLzQyZmJhYnlhZE9r?=
 =?utf-8?B?S1pjNnRYd3hNMnhzY3o5Vng1ME4vMVNtNWxMdVpoUG1qVmx0cjZBOUhQYXJK?=
 =?utf-8?B?WDhLTEdYcmtPdjRGSUR0MitLQ1d3MlA0RnZuR3lCOWxRa0h2WWl3STkzU2dF?=
 =?utf-8?B?YzdycENMc1p1cFp6K1BsM2txRld1eUVEUjBTeVNlY2gzTWhtL21RZ29GN3NZ?=
 =?utf-8?B?NUJtOWI2b3N5K1hEOElRa25RQkFTZEpEYjRIVHVncDRESUhPYnNaMWFTL0dO?=
 =?utf-8?B?dkxlV2dtVmd1c2NrSkhpNlZ5VzRiY2pXem1GMW5pcE5wdnlyRDJVS25ITkVi?=
 =?utf-8?B?Sks4OGZydXlqNENpa29FNGZDanY1MkhJdkEvdFM3RW1panhCRDVmZGltOFcz?=
 =?utf-8?B?RWk5TG1DR0dJMUY2eURqWHhuQWkvOU1tVFBuQTVxQ0kwSFE2QWJ1bDFwaCth?=
 =?utf-8?B?dHloa3l2cjZ1VmM5UkhLQm9CQUNGTVFRc0JsUXFYT3A0ZXMvQ1dnRlZzRjlX?=
 =?utf-8?B?WEdRWVpQaU9lbEdlc0EwQk1HTWkyNzJaNjNYOXNLWmdoWFhMZlh3TEVhNThp?=
 =?utf-8?B?K0tDTjdUN3Q5Sm0wV25nU1VhYk9PT3I5TVliaERGQWNFVTFLK3N0djh1WWtI?=
 =?utf-8?B?eWpmSnVjeXZhczY1SVc4VGllOEVPTGhlSG5Uc01YdnVmSThlZ0wxc0E0cWZu?=
 =?utf-8?B?TmpOeE5SNi9sQVhid0lTK3paanFMb1FRYy9Wdi9PZVdFVUhVVjVHK3lMS3Ay?=
 =?utf-8?B?a25CU3BmUzRuOGVtc1RQczVjazNnZE9iekZScldpdmE0azRsYVdqUU8raUlL?=
 =?utf-8?B?Nm1LU3lGTEYrb1EyN0phSjUrejk2c1RreXdIdjFrOWdPWkhCdHYwUW4yNVR0?=
 =?utf-8?B?RWJxMm4rQldpcE1ISTB2QVlGYnFhWTdvTEkyaG9RTkNJSlliZmp3SkxxeU9y?=
 =?utf-8?Q?PyMsgKObEF/aFBdanN6o2RSWI?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d87d66-2ce7-4650-ff2e-08dc517b1d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 12:07:19.1000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqqXe+5Ks1aybhAfwfjStDQoO/xSaJWAn8fmF5Lvl5tb2I2bCV5Cfx/0XmNJvI0pta4cZ/Ww79PnklH7FUZA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4298
X-Proofpoint-ORIG-GUID: pBHId8Tku4ezlmOC1dxrTzelhSzZSYlB
X-Proofpoint-GUID: pBHId8Tku4ezlmOC1dxrTzelhSzZSYlB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_09,2024-03-28_01,2023-05-22_02

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE9saXZlciBOZXVrdW0gPG9u
ZXVrdW1Ac3VzZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjcsIDIwMjQgODo0MSBQ
TQ0KPiBUbzogU2FpIEtyaXNobmEgR2FqdWxhIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT47IE9s
aXZlciBOZXVrdW0NCj4gPG9uZXVrdW1Ac3VzZS5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBl
ZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29t
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gdXNiQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogc3l6Ym90Kzk2NjViZjU1YjFjODI4
YmJjZDhhQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBu
ZXQtbmV4dF0gdXNibmV0OiBmaXggY3ljbGljYWwgcmFjZSBvbg0KPiBkaXNjb25uZWN0IHdpdGgg
d29yayBxdWV1ZQ0KPiANCj4gDQo+IE9uIDMvMjIvMjQgMTg6NDMsIFNhaSBLcmlzaG5hIEdhanVs
YSB3cm90ZToNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwg
TWFyY2ggMjEsIDIwMjQgNjoxNyBQTQ0KPiA+PiBUbzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiA+PiBwYWJlbmlAcmVkaGF0LmNv
bTsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsNCj4g
Pj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiBDYzogT2xpdmVyIE5ldWt1bSA8
b25ldWt1bUBzdXNlLmNvbT47DQo+ID4+IHN5emJvdCs5NjY1YmY1NWIxYzgyOGJiY2Q4YUBzeXpr
YWxsZXIuYXBwc3BvdG1haWwuY29tDQo+ID4+IFN1YmplY3Q6IFtQQVRDSCBuZXQtbmV4dF0gdXNi
bmV0OiBmaXggY3ljbGljYWwgcmFjZSBvbiBkaXNjb25uZWN0DQo+ID4+IHdpdGggd29yayBxdWV1
ZQ0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZWVtcyB0byBiZSBhIGZpeCwgaW4gdGhhdCBjYXNlIHRo
ZSBzdWJqZWN0IG5lZWQgdG8gYmUgd2l0aA0KPiA+IFtQQVRDSCBuZXRdDQo+IA0KPiBPSw0KPiA+
DQo+ID4+DQo+ID4+IFRoZSB3b3JrIGNhbiBzdWJtaXQgVVJCcyBhbmQgdGhlIFVSQnMgY2FuIHNj
aGVkdWxlIHRoZSB3b3JrLg0KPiA+PiBUaGlzIGN5Y2xlIG5lZWRzIHRvIGJlIGJyb2tlbiwgd2hl
biBhIGRldmljZSBpcyB0byBiZSBzdG9wcGVkLg0KPiA+PiBVc2UgYSBmbGFnIHRvIGRvIHNvLg0K
PiA+Pg0KPiA+PiBGaXhlczogZjI5ZmMyNTk5NzZlOSAoIltQQVRDSF0gVVNCOiB1c2JuZXQgKDEv
OSkgY2xlYW4gdXAgZnJhbWluZyIpDQo+ID4NCj4gPiBQbGVhc2UgdXNlIGNvcnJlY3QgRml4ZXM6
IHN0eWxlICdGaXhlczogPDEyIGNoYXJzIG9mIHNoYTE+ICgiPHRpdGxlIGxpbmU+IiknIC0gaWU6
DQo+ICdGaXhlczogZjI5ZmMyNTk5NzZlICgiW1BBVENIXSBVU0I6IHVzYm5ldCAoMS85KSBjbGVh
biB1cCBmcmFtaW5nIiknDQo+IA0KPiBFaG0sIHdoYXQgZXhhY3RseSBkaWQgSSBkbyBkaWZmZXJl
bnRseQ0KDQpDaGVja3BhdGNoIHRyaWdnZXJzIHdhcm5pbmcgaWYgd2UgZ2l2ZSBGaXhlcyB0YWco
ZjI5ZmMyNTk5NzZlIC05LSkgbW9yZSB0aGFuIDEyIGNoYXJzLiBJdCBpcyBhZHZpc2FibGUgdG8g
Zm9sbG93IHRoZSB1cHN0cmVhbWluZyBwcm9jZXNzIHN0ZXBzIHRvIGhhdmUgdW5pZm9ybWl0eSBh
Y3Jvc3MgcGF0Y2hlcy4NCg0KPiANCj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvdXNiL3VzYm5ldC5j
DQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L3VzYi91c2JuZXQuYw0KPiA+PiBAQCAtNDY3LDEwICs0
NjcsMTIgQEAgc3RhdGljIGVudW0gc2tiX3N0YXRlIGRlZmVyX2JoKHN0cnVjdCB1c2JuZXQNCj4g
Pj4gKmRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgIHZvaWQgdXNibmV0X2RlZmVyX2tldmVudCAo
c3RydWN0IHVzYm5ldA0KPiA+PiAqZGV2LCBpbnQgd29yaykNCj4gPg0KPiA+IHNwYWNlIHByb2hp
Yml0ZWQgYmV0d2VlbiBmdW5jdGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVudGhlc2lzICcoJw0KPiAN
Cj4gSSBhbSBzb3JyeSwgYnV0IHRoaXMgaXMgdGhlIGNvbnRleHQgb2YgdGhlIGRpZmYuIFlvdSBh
cmUgbm90IHN1Z2dlc3RpbmcgdG8gbWl4DQo+IGdyYXRpdGlvdXMgZm9ybWF0IGNoYW5nZXMgaW50
byBhIGJ1ZyBmaXgsIGFyZSB5b3U/DQoNCkNoZWNrcGF0Y2ggZG9lcyBhIHByaW1hcnkgY2hlY2sg
YW5kIHRyaWdnZXJlZCB3YXJuaW5nIGlmIHdlIHVzZSBzcGFjZSBiZXR3ZWVuIGZuIG5hbWUgYW5k
ICcoJy4gIEl0IGlzIGFkdmlzYWJsZSB0byBmb2xsb3cgdGhlIHVwc3RyZWFtaW5nIHByb2Nlc3Mg
c3RlcHMoY2xlYW4gY2hlY2twYXRjaCBvdXRwdXQpIHRvIGhhdmUgdW5pZm9ybWl0eSBhY3Jvc3Mg
cGF0Y2hlcy4gQWxzbyBjaGVjayBjb21tZW50cyBmcm9tIEdyZWdraCBib3QgcmVnYXJkaW5nIHRo
aXMgcGF0Y2guDQoNCj4gDQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3VzYi91c2Ju
ZXQuaCBiL2luY2x1ZGUvbGludXgvdXNiL3VzYm5ldC5oDQo+ID4+IGluZGV4DQo+ID4+IDlmMDhh
NTg0ZDcwNy4uZDI2NTk5ZmFhYjMzIDEwMDY0NA0KPiA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3Vz
Yi91c2JuZXQuaA0KPiA+PiArKysgYi9pbmNsdWRlL2xpbnV4L3VzYi91c2JuZXQuaA0KPiA+PiBA
QCAtNzYsOCArNzYsMjYgQEAgc3RydWN0IHVzYm5ldCB7DQo+ID4+ICAgIwkJZGVmaW5lIEVWRU5U
X0xJTktfQ0hBTkdFCTExDQo+ID4+ICAgIwkJZGVmaW5lIEVWRU5UX1NFVF9SWF9NT0RFCTEyDQo+
ID4+ICAgIwkJZGVmaW5lIEVWRU5UX05PX0lQX0FMSUdOCTEzDQo+ID4+ICsvKg0KPiA+PiArICog
dGhpcyBvbmUgaXMgc3BlY2lhbCwgYXMgaXQgaW5kaWNhdGVzIHRoYXQgdGhlIGRldmljZSBpcyBn
b2luZw0KPiA+PiArYXdheQ0KPiA+PiArICogdGhlcmUgYXJlIGN5Y2xpYyBkZXBlbmRlbmNpZXMg
YmV0d2VlbiB0YXNrbGV0LCB0aW1lciBhbmQgYmgNCj4gPj4gKyAqIHRoYXQgbXVzdCBiZSBicm9r
ZW4NCj4gPj4gKyAqLw0KPiA+DQo+ID4gTmV0d29ya2luZyBibG9jayBjb21tZW50cyBkb24ndCB1
c2UgYW4gZW1wdHkgLyogbGluZSwgdXNlIC8qIENvbW1lbnQuLi4NCj4gDQo+IE9LDQo+IA0KPiAJ
UmVnYXJkcw0KPiAJCU9saXZlcg0KDQo=

