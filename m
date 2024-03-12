Return-Path: <linux-kernel+bounces-100544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B404879964
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9241C21542
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA96137904;
	Tue, 12 Mar 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="i067e7ge"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5286AC5;
	Tue, 12 Mar 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262283; cv=fail; b=f4jsqlLnScPcckEGCsp4VKS9PQDvp4DP26V7uNvIK3nLzQSHdIyNteQZmp2RbYubkN5P1T/4pZUz5aOKe68Moy3ssdex6IwvWm6rPTCW2QZ7t16EwkpmHXpDYAh1xLaFxLKfZb3aZQzQzQ9QDxjILXtohftWKAiBNJBXq2nK6EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262283; c=relaxed/simple;
	bh=uQlIRzi2joBdXdwzOo8rKYGenautgdtNgSsGZg3W11I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N42qlWKaqKyq0eMkfKSRkNROO+Vz0XaGVP/B5gMFka16hhOuocql8V16NqC2T0xHBttHuGtXxIr5Tp0pukzr3lhC0SYGJ3Fm0UnsJecyu4pIPDuvlHOm4ZAY1BbpywY2PyIdVBgM7FJRhpQN5EQyBmYM8yGU/QWiV/Dmx4rGomc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=i067e7ge; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CEHUUW025258;
	Tue, 12 Mar 2024 09:51:08 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wswdcx5k9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEyM5Cckti70wSAYPZBUhHHoy6KZF1cE0nakMQLVpJA9SN1nGIybVoo32OO2vP3mQ4xXgwi0zR8u04U0UqL6Aw9pA6NveWN1JYuu2LiwJLQrFyrQ5SoqVq1hUoCJZIFoHddI4PA50b14xUtLRj+92yRntsmrVr/CwD7x5vGFWyc3d7FiLekx3QEZEMygOPDK9YHNOErp2Wq8sgIHiwFHzVIGmgzz3xhWKSCjuMDGLt19MPsd5PjPr2CTFt2BWad7aD3oKElgaxQ2T7UX5W/sdXjQcDaV4hK1JDNiwaZ1Du0djoHOONGz7bWglWnJHlL1ehvor3kXXnJgPydwdI2NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQlIRzi2joBdXdwzOo8rKYGenautgdtNgSsGZg3W11I=;
 b=BA+p/8Ep8Ku08kXMN9kAUl9rFaffo7yib/foSxRXwn0iUgB0YY6sh1vnZ4o805a3FhMO4UEi0KjI9lQsmcI65x6xaWP0C0FpO84H8cgbhhWVLxFwA84aUfBdvSK/1z6KOLuKjCZFIrrsP8C+8IaiXVzrwuixplobhwGx20LoSrAYJlFqXH6LI9w+k7eFaIuRC/fDqJ4HGlqc/obkPLhVPY8QV80yyic9eKznyYV6/q+VX8+y10hLjZBXyxsC5O2ttrso7wCKg6F6yXvzQ6l37nezywgwtyr38wegcNVymTSLxYJheKEGB6tY0beY/KbuhOktxYJGNJPJCEqMZspgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQlIRzi2joBdXdwzOo8rKYGenautgdtNgSsGZg3W11I=;
 b=i067e7gem82PAYQicp0y5EkW2ETNzJwzTtoJbxD8scrMP6QfuCj/ayW3vcEEp4yvxrJc+F9aS8DyBktg7hf1JNZXiOchHrmpiEs2/wiRfQ3h3OEIzlEZ4idgLgnZrGjZlO3FJ1YwbfsLTnaP8BsXNVl3uNFEPbhy7LMXNWmKl7I=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by DM6PR18MB3457.namprd18.prod.outlook.com (2603:10b6:5:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:51:05 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::7471:7657:9316:1494]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::7471:7657:9316:1494%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:51:05 +0000
From: Elad Nachman <enachman@marvell.com>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Taras Chornyi <taras.chornyi@plvision.eu>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "thomas.petazzoni@bootlin.com"
	<thomas.petazzoni@bootlin.com>,
        "miquel.raynal@bootlin.com"
	<miquel.raynal@bootlin.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 2/3] net: marvell: prestera: fix memory use
 after free
Thread-Topic: [EXTERNAL] Re: [PATCH 2/3] net: marvell: prestera: fix memory
 use after free
Thread-Index: AQHac7s3vUK8tZMPLUKr+ABWB9D8bLE0QSMAgAASMCA=
Date: Tue, 12 Mar 2024 16:51:05 +0000
Message-ID: 
 <BN9PR18MB4251EB4DD8EFD839342FDC9ADB2B2@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240311135112.2642491-1-enachman@marvell.com>
	<20240311135112.2642491-3-enachman@marvell.com>
 <20240312164526.4a0e242a@kmaincent-XPS-13-7390>
In-Reply-To: <20240312164526.4a0e242a@kmaincent-XPS-13-7390>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|DM6PR18MB3457:EE_
x-ms-office365-filtering-correlation-id: 89ddacd6-b0c2-40e3-662c-08dc42b49b91
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 A/6jTif4jLaZaFMIMWXcPVHis67AfHDyun3lWysLHVzv+Jhwvuzr8frWysNkEYzqa8qAYF+u5g+2gx9h49mvBU7mIAZMLF+Zj4/PSZK3QnnZ149EKfGEicDAoz9PC2Q2kQMRSYkYmv8NFSAN/Qe0tMduKnqJEXUc7s79R6ilg/G1qS6FCUbiqiUw0M203VK4S9dJy4MO6E9koDrggoqg1z/rClYczR4PMfzU0GEbK02Xlil0jSnVXac4IRdlMRAkicAxkjdjp5tzix1YlKMh1lJ3AT2dxBH4ZRQzF3Vn4rCLl5ZAa1+IcWePylk3X7vrqkhy2b1Y4EsER/s5Ke2axDBPjW8+oK2HkcJHJuDpJANAzdw4EtNdhJLZXLpjEebCErEJOMy54qvW7wr5sF16HFTBa0cnKRvgd1z5PTcrK+0PeHIMouPAxZZropO7NNcd+mxnhatTTJIe4Hp0W0N67XXS+zsW1c9Itc7uipD87gOpfojuevibCzjIZk3YEuhY2S9Qmd43V5WdTgx/dLXPS6pTFdLDLjk3UBpUU5XhA+sGIS+0WPozjPi5OVQ1WdGf2bzz8a8tsbZ9aLsS3Gas0OuLR9ZfaJ+6ns88aY+mUF/KoAPdKHn390N9dTojf3+DNacLCsEkLyjjPrsQJkicqeT9GO2GejrdLsCka9hXxes=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RVhYcTNFelA4T1N6VldzbE80ZzJjR0V3LzlyT2JmMS9iQlY2TjNiNkNDQnVC?=
 =?utf-8?B?aWRUenpGR2lGNDkzR1lZd3BxRlZ5aW8yU1dTV01IdmZ2K2pUVTRkMDZyeStn?=
 =?utf-8?B?UnZ5ZGpYdWlrMzM0eGVsMFVVRXNoS015ajl6RXUwbHlvSURRNXFJK2VHTUpC?=
 =?utf-8?B?YlJXQzRtU0h4eFpHcDFRUHB1UTlSQVRibzB5alBEQ0tTWlM5cUI5dFhTbkdm?=
 =?utf-8?B?eExSY0w0aVhjTW1KNWNwL1IramNSVlExOXh4dmZ4THV2WFB3VUtha25yaHEr?=
 =?utf-8?B?ZFUwS0ZhN2dkU2VvQmRLenU0K0NUUEIxK2Fsa1AxUjd5aEdqajFTbk9MQlI0?=
 =?utf-8?B?L3h3aVFkbUx3ZThhNGtGVFYwSmZJbFA4Uml6UW5EMlpEZ0k4UlVkeGtZMXNP?=
 =?utf-8?B?UDlBMmpwcURBRnk0S0pJQU9YN3RrYjFoRFVHZFNVS0ZrNmdzSVVmNjdGNTJ4?=
 =?utf-8?B?dDdsY24wVWVjdzJaa2ViMG9FbWk0VDRQVS91QTlleTRTT1ZjN0VDaitxZGY5?=
 =?utf-8?B?Nms3WFpEckZEY0FuOW1oV3BhSnEzWUN1ZlNqRjFzQTdxcHVHa1Vsc2Q0WkhC?=
 =?utf-8?B?WmV0UjExZUQ5UW5ubUNMcHBrKy9qbThTcHYzMytLQ2dYMEtNRUQ4RlduS0Ns?=
 =?utf-8?B?YWJLUXlObXc0aEc4QjNZY21ONXhCT2Q4QzNHUTNuR0txM3lhSWo3bStwUjlu?=
 =?utf-8?B?TTY2NGRESDRlb3lLOFVzcDc0UGRVUC85ZnNvVlhrbWVlYndnRXp5VENwSXpa?=
 =?utf-8?B?OGJQNjR3cEZRYXdoeGV2cTBVSURnclpXTVN4VFV0eG5TcSswMDlOT21LZTEw?=
 =?utf-8?B?eHU3VFdYeXdyUjdjZ2VqZytGbVN2enY5M2NId2VtRHFIK3JzV2lIRXpIdXFX?=
 =?utf-8?B?S2pDVmZ4MmFuV3FCVTlRMnM2Znh4clRFUnJwTkY5TUo5M2NtL2syeEVjT29t?=
 =?utf-8?B?RWI0RnU0eGNjbVZSbHk5dktIZDYvQ3dleXFsVFQwbCs3bnBKZ3AxZzBOY0ND?=
 =?utf-8?B?VWloWDJpRmh3MHFlcExmaE1Cc3FXQXppdGd5STB6OWZ5bDhlVllHVTR1amV5?=
 =?utf-8?B?bXJROVJQTWdadHgydzgvNkl5WWF0U1NYT3had0dXZkxCdFdNUEhSNHZqYWtl?=
 =?utf-8?B?THI3OU1EeTYzNm5lenJKTUZ3cDlJdUFwMSt3M1hOVWdsM01nOW5QVnltRXdz?=
 =?utf-8?B?b0FKaFhWUXlEU0lQRFJ0eVZuTlp6RkhjcU03MG12QjBibU5UYXNra3ZmUzlj?=
 =?utf-8?B?VENoaUdNbm80citKdmZ3SDNONEs5Tk9KS1h4WXJka0RncXNabEhaRkt3blRj?=
 =?utf-8?B?ZFFyZENXeEdyUWpFYTR0bG1ybHVHWVRZQnlMSHY2T2xzMmpxNjhEY3dmT3NP?=
 =?utf-8?B?c3l2TFJoVit5ZGpOaXNFaVB4akE0NnlxdlJ5dDI4OWIzL043ZnJIUWV6aE1L?=
 =?utf-8?B?ZHplRVpKV0N0UVVxVFA0VDc3dkZRRWlSLzF3UTVhR3ZpN1lpVms3SzJqMUxk?=
 =?utf-8?B?MEV2RmxETk13cVB1TjN6cHdKV1d1T1ZxM0daYzZnZnMwbEJ5UHhoL3ZQaHdR?=
 =?utf-8?B?T295RmRWSmsyK1pzYUJtdTQxZlhwT2N0YmwyV1YrcFJpZVAyREt1aTBSZjhT?=
 =?utf-8?B?SU8zcEZ6MHFJTnhDaFlGUTRTc1dyamJSMmZzdm1uTmg1bjF5Ri9GT3lMRmNW?=
 =?utf-8?B?YVZHQXhlMm13cEk2L29QWnMzczRBMUMvUFl0MklHTDlQaGxMN25wWjh6dUxk?=
 =?utf-8?B?MnFqdUIyQkVMc0VSRFBtMGYwUXdIWkNFTWtQRXhzRG0zakdYOEdXcHJ5RkV5?=
 =?utf-8?B?d243RTBwU3NacU9NOVJ1RUNyT2s2cFlZS3AyM1N0cWR3aVZId2puUTdIVm44?=
 =?utf-8?B?cXp6d3UxQ1N1UE5WeVRjTXVMbHgyNkNYSWNuZnZPWUZ3bElxQUlFaEs3aXJu?=
 =?utf-8?B?Rys1SEpvdndxOEJCY3g4RTg1MytXek9YaTN2RytSeXBPSGo4cDBESkxUNjY0?=
 =?utf-8?B?Q3Y0cHVDWnMzSVZZbjg2TjJ1Z2xjdlZRV0ZLRUtWMkViMjJYOUxGZ3dBemY3?=
 =?utf-8?B?TXVBTTBkYzBjb3FDSVVYVnhCR25KUHBhOHorenlTRTU2aFdhdUJ4RFc4QjQ0?=
 =?utf-8?B?dW1GeDMzSGpmWWNja25Pb1BUdU5zV0o2VVdQYmVOdFpFd2tiYTdRK2RhbWYr?=
 =?utf-8?Q?TEjUJzKm2XUpNbbLSCgo8eLnGKNTtt+8ZZ5NbqUbvqXS?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ddacd6-b0c2-40e3-662c-08dc42b49b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 16:51:05.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loEapC637NKRnE1OZpQLsl5B3QmRRYt09HSUjEJdPpH3b+lMQ7T539TQ66XCDYv/qeoRkAAGH5x88+My9pkCrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3457
X-Proofpoint-ORIG-GUID: B0RTz4Ql_NUYG2nrnPS0KzDQ4CZsPBTJ
X-Proofpoint-GUID: B0RTz4Ql_NUYG2nrnPS0KzDQ4CZsPBTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29yeSBNYWluY2VudCA8
a29yeS5tYWluY2VudEBib290bGluLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTIsIDIw
MjQgNTo0NSBQTQ0KPiBUbzogRWxhZCBOYWNobWFuIDxlbmFjaG1hbkBtYXJ2ZWxsLmNvbT4NCj4g
Q2M6IFRhcmFzIENob3JueWkgPHRhcmFzLmNob3JueWlAcGx2aXNpb24uZXU+OyBkYXZlbUBkYXZl
bWxvZnQubmV0Ow0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVu
aUByZWRoYXQuY29tOw0KPiBhbmRyZXdAbHVubi5jaDsgdGhvbWFzLnBldGF6em9uaUBib290bGlu
LmNvbTsNCj4gbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFM
XSBSZTogW1BBVENIIDIvM10gbmV0OiBtYXJ2ZWxsOiBwcmVzdGVyYTogZml4IG1lbW9yeSB1c2UN
Cj4gYWZ0ZXIgZnJlZQ0KPiANCj4gUHJpb3JpdGl6ZSBzZWN1cml0eSBmb3IgZXh0ZXJuYWwgZW1h
aWxzOiBDb25maXJtIHNlbmRlciBhbmQgY29udGVudCBzYWZldHkNCj4gYmVmb3JlIGNsaWNraW5n
IGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gT24g
TW9uLCAxMSBNYXIgMjAyNCAxNTo1MToxMSArMDIwMA0KPiBFbGFkIE5hY2htYW4gPGVuYWNobWFu
QG1hcnZlbGwuY29tPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogRWxhZCBOYWNobWFuIDxlbmFjaG1h
bkBtYXJ2ZWxsLmNvbT4NCj4gPg0KPiA+IFByZXN0ZXJhIGRyaXZlciByb3V0aW5nIG1vZHVsZSBj
bGVhbnVwIHByb2Nlc3Mgd291bGQgcmVsZWFzZSBtZW1vcnkNCj4gPiBhbmQgdGhlbiByZWZlcmVu
Y2UgaXQgYWdhaW4sIGFuZCBldmVudHVhbGx5IGZyZWUgaXQgYWdhaW4uDQo+ID4gUmVtb3ZlIHRo
ZSByZWR1bmRhbnQgZmlyc3QgbWVtb3J5IGZyZWUgY2FsbC4NCj4gPiBBbGwgc3VjaCBkb3VibGUg
ZnJlZSBjYWxscyB3ZXJlIGRldGVjdGVkIHVzaW5nIEtBU0FOLg0KPiANCj4gTm90IGRpcmVjdGx5
IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaCBidXQgSSBhbSB3b25kZXJpbmcgaWYgdGhlIGNhbGwgdG8N
Cj4gcHJlc3RlcmFfcG9ydF9zZnBfdW5iaW5kKHBvcnQpIGlzIG5vdCBtaXNzaW5nIGluDQo+IHBy
ZXN0ZXJhX2Rlc3Ryb3lfcG9ydHMoKSBmdW5jdGlvbj8NCg0KWWVzLCBpdCBpcy4NCg0KPiANCj4g
UmVnYXJkcywNCj4gLS0NCj4gS8O2cnkgTWFpbmNlbnQsIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGlu
dXggYW5kIGtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2lu
dC5jb20vdjIvdXJsP3U9aHR0cHMtDQo+IDNBX19ib290bGluLmNvbSZkPUR3SUZhUSZjPW5Laldl
YzJiNlIwbU95UGF6N3h0ZlEmcj1lVGVOVExFSzUtDQo+IFR4WGN6ak9jS1BoQU5JRnRsQjlwUDRs
cTlxaGRsRnJ3USZtPVZuandVQnE0UVNfT25sXzA3Z3AxT1VwMlhvRw0KPiBwVC0NCj4gYlo1c25F
T0FnNWdmM0NNM2w1R1BnWFExcGIzR3pFYTZiYiZzPUdjaHpxSTNsSHlHdUZLaGVwRUZNRnNYd3AN
Cj4gNW9NU0g5aXF3Qlp1VHR6aGpjJmU9DQoNCkVsYWQuDQo=

