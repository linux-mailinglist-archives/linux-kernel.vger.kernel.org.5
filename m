Return-Path: <linux-kernel+bounces-142615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C638A2DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103DA283FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4B755E4A;
	Fri, 12 Apr 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="rTf9JJs6"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4054FB1;
	Fri, 12 Apr 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922779; cv=fail; b=AqkE4zvEcjPcOBBAtqa583lSu/N1pn6wxO04rEsgx+P4bGy+e7PBvXzLRmUGBcI8YjmsL05oE7R6aUoPHtqHvvrR+tC8az4f9HpeEmnK/fS47ZqDDsvVw2LSIGsYEYbEkkCeSYxa9+FY3oDV1BJEbb5KW2kE5BfFTp7TpwszwZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922779; c=relaxed/simple;
	bh=qROenWD3zTjU24STwEximWRjXfmkwFddTOtN18rp264=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nkCCmJV+VpNk1DTFrk3gXye9PYXNSv55fAhIMEkHAH6gZXwLOsfI+/wZ12hzf10wIonO6NDArjCs+deRMf234V2FugfTlTwOMerSG7S5CiIEfh+qGeuf9+vh1LLQqC3dHW/3RTHjxH5EVi2D7jCzdZ60BfLnaY0RGNYTfPP+0Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=rTf9JJs6; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CBlprN002445;
	Fri, 12 Apr 2024 04:52:47 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xexsah3x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 04:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WACRtv3vIMW2nhQZmP5bXrl2JnNkziOii42Ju/MjyjmWIvmhCogoCx8qulpYit4pPh/FlsXDX+V145EB9FrgKKvOOk5QxM3FsgeXoJl/oFe5KTbt0N6oC7W/ghGO6GuF3zNYsFaJE1XRzNbwT/BqCc552PR+3xGN3WOQEnTlmBY9MkY199rsjLpM/VHukBm7/AKIdHJmvuSjTK6laakWrOW52+7GPhTWH2A3/5p06dxim2gRxR7DEaK/InsHf7bV9DHeUi38nB5jAcgO2NIOXywWkyMugxrzC0jl9JuQ2kNw5MJwdAtRAq/13nifH4174XdtnaJA+TVaSdXkHHOgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qROenWD3zTjU24STwEximWRjXfmkwFddTOtN18rp264=;
 b=lcY4qjXa5AnC2hBfx6LjdeIYKsU/i3Pza28QY9B+o+mlXaexTCTiH1L+ZPHSg/csIxQVQPexoXcTrask9fJgthUuFn3Jjh/xKos1Im0MDWYbIz3W8LfnDIOfLpQ1NNfGeJBCV7S5plgV0vk77Dr8g5I0zWDy/zAQ++J8jNIP4yZzsqhjDJANJc8tQWYlFphUr8SgvvQN1h5blf4AUblR+g3ItsnFE4rqzirQczb503n/7LXmSfItYcV8HLHfNSAcVvXhQh23WgGf/VQBo2PL+yF7aSXd9uNEdiZ/P+jJYkaOLTZ7860nZ4RYiiu0qdFJcuufT51g1PX4p9OLhA0o/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qROenWD3zTjU24STwEximWRjXfmkwFddTOtN18rp264=;
 b=rTf9JJs6bhE7ttlGk0TtIFdaLft0QhIMtzqltPj9pVxK+0EoHAbnb39AsxBr7gzmIpBcRR1EOF4bXPaB1iVDV2VzHuyzH3I+cY22ut4JZ3Fnq1T8HbhhXofNdlcHYlOUwE3lntZRMig7GSYus9SPkhLlt0kSWr8WGm1E4YuGEqs=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by SA1PR18MB5766.namprd18.prod.outlook.com (2603:10b6:806:3a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 11:52:44 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6%6]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 11:52:44 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: =?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>,
        "David S.
 Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Suman Ghosh
	<sumang@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation
Thread-Topic: [PATCH net] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT
 implementation
Thread-Index: AQHajM/uzmLfhhhbPEaU+wPC3Uy1cg==
Date: Fri, 12 Apr 2024 11:52:44 +0000
Message-ID: 
 <BY3PR18MB4737C1B91191F2982909A859C6042@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240410134303.21560-1-ast@fiberby.net>
 <SJ0PR18MB5216D2276BA11D5C5E31D6A6DB042@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <27ac48c0-b19c-4104-8ec9-08232e3f42f6@fiberby.net>
 <235918fc-9b9b-4efa-8258-69bd5c7d40d4@fiberby.net>
 <5fb7638c-e70a-49ea-94d5-6b7f3e953255@fiberby.net>
In-Reply-To: <5fb7638c-e70a-49ea-94d5-6b7f3e953255@fiberby.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|SA1PR18MB5766:EE_
x-ms-office365-filtering-correlation-id: 67480090-d8a9-45ca-b914-08dc5ae7108e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JaE+bI3/Z/hnmyc6GdCm994n15ZVxF03nv24j5qfM0YCclC/UzIriw6aA4CUh5aYJrdYk2pbPbaMSME4xnx8gKAWrHCYN6R5iioyQFcKKksHArQC5ldGjwR6OOiJ3i4QeINnJYdu/P8MEA2SKVzri6us/SpFXOya7KT4N6zcdS6NCIBfLS06Wm34RoaTcDWzCT26iquGC+1NUOD/tni8kyE2DMAn6DVakVC6w9+rwqRWSfXkp0ZESJOhBp0nHHOLqIZ1CIIwzha7BxBnfnWQIfO1G9ANi6u+qxFv3WSfC5635okEAjWeo9F+SK0he0ml6OZ/9RxcI0QmxlDQe64n9hYB/eFsvX8ntS5NAdcW7Dzb6WcjNPLx/LELPGjkABU2Zu13iaBKg7SAbsU/bB+AzncdGYLEww+kzfQZYOuQRRSB2ol/X53c59nieZ/kKP+m9whXLCQWFFmMEGXTIkE3EW/pvjQXg5GuvVn/dUwM6rZ2DX3cUaNoCWipReCf8Bn5mXw2WLDzEWb2qEFEu2o3omTZ3D2zB2uyXkQzZ9KpWulshIquD+vloRrCkA48mljm6nbfXgdy38vK3Gptm95X4TNIMaL6enteTtB3buxBKrVdQzT3ne1MCa+D/7I3G5rqAgiBbLkGUvHepyctHKin0BswVsWNC/ivrjzfu0cuPw7096i/Qd8rdTeWXsdVjcExdSga0FeOU81i9o3B2vBxjL9eCngxtWMCrLTIcq+dZt4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QjNlOEtUZHpPSER2TFFJcnF5Mkc0Rk9uK1RsS0lQVkw4L2s2eDMzMU5nSUNp?=
 =?utf-8?B?a3Vab09xQlJSZ3BPTTBSSE16T2w4Rld1TzBFTFo1ZWZtMVF3YjVHVC9zL3RF?=
 =?utf-8?B?M1B0T2JpZGF2bzZJZUJXdnIvVUVXaU5RMURNeHdxczd4N2dCTm1EWWRTY29y?=
 =?utf-8?B?RDVlM2o0dGlRNitkNlcrZktZSUZvWFJrekhVdnA0OC8vS1hWc0dYMUdWY1Bj?=
 =?utf-8?B?TVBXY3Q1VytZSmRsQ1pFYlliRWlvRmRvMUtyZ2pGY0hodG1mTnBIZnljb3Vt?=
 =?utf-8?B?WUZYbzNHWXRNUXVEbFV3amN0Mk4rYmFuMDVqNEpqSFZzWVQ1Q0NKUzhrTWk3?=
 =?utf-8?B?ZHFkemNmMXF3WGJsbldXQXErcmtyVWg0YWN2d3VpR1A1VkZQSGxJc2l0K3Jl?=
 =?utf-8?B?WWZjZUpMcXIrcG9GeEFveFFNdktZdStFbGpRMjZVRmhpV1REWGZyVWEzZ1py?=
 =?utf-8?B?aERvb1V3M3RHdm1kSlFNSmg4RjBJN3hVTFN0TmJyNnFnWnZERVJaZnN4NGpC?=
 =?utf-8?B?aytIelNRVm44ZXl2OUFwRjFobWQ2dVFOYVBYemFnbVQzcWpoVmtpTlUrQ00y?=
 =?utf-8?B?UkhkYTZzRDFOYWY4WmVxVWVpcStIenNQQWFOTjZhcjlmR0ltanc2ajJseXd2?=
 =?utf-8?B?TW1HYmhuMGxlVnMwMWlCaERMUzd4Tjd5K0NYQTVLSkdQRW9ycDNpcXRmckFU?=
 =?utf-8?B?bDhET1BYUWlzbDJsZ0xsR3JGd09RWDE5RWJsaWFMT2lnYmhESkNnL0Z2NGlP?=
 =?utf-8?B?UW45WDVmWnk3dmJsSlVzZHNEbjhWcDJ2VGdwdWlsMmRBRWc2TzV0ZWNLQVhY?=
 =?utf-8?B?Y2FkcVBEODdFOTdCM0pBeDkxbmZwNkttclJWYlNNUUtsditUVkt6azJPc3cv?=
 =?utf-8?B?eFBUbzgzTStKQzVWTlJMV1lrQkppQWtmUS82U3c3aDMxS0pTSXZIVDQ0Q3VU?=
 =?utf-8?B?WmJXWXl6UXV0c2V3SmIwNE5weUU2MWk2V2ZaSnZDZFRTT2dBdnh6SVZQaTF4?=
 =?utf-8?B?cnYwdjRBNjFTemszb1hBWGgyc0Z4S3V6T3pXcCsyWHVNc1dRcFk4ai9LaDJS?=
 =?utf-8?B?UThjUEh2NTJzK01xU2V5ZGJTVS83UXFUS0VYV0NBUlEvdm0rY1V2L3phSGs3?=
 =?utf-8?B?NW1jZnFJWXJLUTMyRUZFSzdpM080dEFqdXJDZGlBNTFnMWNiSEtFYnBINHNW?=
 =?utf-8?B?ZGh3NUtNQy9CWnI1QzJtTDVKSjhCL1BFdGhpc1E4ZHhLUTkxczZXNWloSFRx?=
 =?utf-8?B?UHhFWHFROXByNWViQmlmT0VRZ24zeGR2ckZxUCsxY1JSaXV5NFE5Qm1lSVJk?=
 =?utf-8?B?Q2swTHZ6VE82akJaYkF2c2ZzQWFZYU1qKzg1UXdWN25zYWYraFlVVEM4T0hF?=
 =?utf-8?B?ZTk2WUhFeUxTekdKN2tMUTBYYzlFRXpQL25Fb3UxWU42cDh0REM2b1NPM0JK?=
 =?utf-8?B?Y3BTenppeFlyNVZGZ2VhYlVwZlZNRkNIbnRSUXFYdXRyNktNeW1oU2tEUVJE?=
 =?utf-8?B?STkxbzk5Yjh4a1g0b3lnaXYvSmZpRjdCZzlLaHFsb1VIQUY2RktDclAwTFJV?=
 =?utf-8?B?Y3dLTzRIN2IreEFPQTNKbHFUdVlhQ3RNa1JtS2swWktHNStkMXZoZDdXY2l1?=
 =?utf-8?B?RlVHYzJCM1VwQlo0cTFGUEpYaThHMDM2cFJ1enJnc3dzYm9vT3F0MXhHQjdQ?=
 =?utf-8?B?ZGhaUU5ma0Y5Rm1Ld3Z4eDUzVTdObXczRmxuRkRZNDhDTGxCeDNTZ1RkMjBu?=
 =?utf-8?B?QWQxQzJUU3EyS0Q5eUZORVFCZktuc082SVU3ZjJOOG9VT20vVFZXcFpSTldQ?=
 =?utf-8?B?dSs0ZXV5RHBucC9DTGg1U2ExZzJXNWhxTzFjSm1DK0dvUjBlRTY4MkRIRy9N?=
 =?utf-8?B?bkwzaDR5NzhwTmh1K3p3cGc0MWJJMVRuUk9pMmZUNnFaVFZHWHZlUk9VSEd5?=
 =?utf-8?B?UitOTGlwVmJ0QTdNdUNURjFyOVY4aVlsMmk3ZnVSdXE1N3ZGanI5N3ZrR0xC?=
 =?utf-8?B?d3QzQXhoYU1tZTFZci9tWHQzbnFBb01qZkRzUWZ4UTM4U2lVVXdRQUlwVjhY?=
 =?utf-8?B?VVRGTitZcmxaRkgwNUx5U3A2NUdkNXpYSlV6WWdZS3kxRW1PaHIybFRuUlhi?=
 =?utf-8?Q?XLTlHha+rSW7+a7/eSfkUtZIy?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67480090-d8a9-45ca-b914-08dc5ae7108e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 11:52:44.1106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGptfo31WZm+PLBwdQfpc8IOG8PmtafjfyzFMdUq//N2Es/U27q5SrcbH0eR3p+P3EGbT5nrjvwsTXXk02WXnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5766
X-Proofpoint-GUID: JDqwOyk9X-D3U-AkosjMOuwGUehcvIsV
X-Proofpoint-ORIG-GUID: JDqwOyk9X-D3U-AkosjMOuwGUehcvIsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_08,2024-04-09_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXNiasO4cm4gU2xvdGgg
VMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMTIsIDIw
MjQgNDo0OSBQTQ0KPiBUbzogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pjsg
UGFvbG8gQWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPjsgRXJpYyBEdW1hemV0IDxlZHVtYXpl
dEBnb29nbGUuY29tPjsgSmFrdWINCj4gS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4NCj4gQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFN1bmlsIEtvdnZ1cmkgR291dGhhbQ0KPiA8
c2dvdXRoYW1AbWFydmVsbC5jb20+OyBHZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2FrdWxhQG1hcnZl
bGwuY29tPjsNCj4gU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhIDxzYmhhdHRhQG1hcnZlbGwuY29t
PjsgSGFyaXByYXNhZCBLZWxhbQ0KPiA8aGtlbGFtQG1hcnZlbGwuY29tPjsgU3VtYW4gR2hvc2gg
PHN1bWFuZ0BtYXJ2ZWxsLmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBuZXRdIG9jdGVvbnR4Mi1wZjogZml4DQo+IEZMT1dfRElTX0lTX0ZSQUdN
RU5UIGltcGxlbWVudGF0aW9uDQogDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gSGkgbWFpbnRhaW5lcnMs
DQo+IA0KPiBPbiA0LzEyLzI0IDEwOjI1IEFNLCBBc2Jqw7hybiBTbG90aCBUw7hubmVzZW4gd3Jv
dGU6DQo+ID4gT24gNC8xMi8yNCA5OjAxIEFNLCBBc2Jqw7hybiBTbG90aCBUw7hubmVzZW4gd3Jv
dGU6DQo+ID4gSSB3YXMgYSBiaXQgaW4gYSBodXJyeSwgdG8gZ2V0IHRoZSByZXBseSBpbiBiZWZv
cmUgYSBtZWV0aW5nLA0KPiA+IHNvOiBzL0ZMT1dfRElTX0ZJUlNUX0ZSQUcvRkxPV19ESVNfSVNf
RlJBR01FTlQvZw0KPiANCj4gSXQgd2FzIGp1c3QgYSBmaXggZm9yIG15IHJlcGx5IHRvIFN1bWFu
LCBzbyBJIGFtIGEgYml0IGNvbmZ1c2VkIHdoeSB0aGUgcGF0Y2gNCj4gaXRzZWxmIGdvdCBtYXJr
ZWQgYXMgIkNoYW5nZXMgUmVxdWVzdGVkIiBpbiBwYXRjaHdvcmsgWzFdLg0KPiANCj4gSSBjYW4g
c3BpbiBhIHYyLCBidXQgdGhlIG9ubHkgY2hhbmdlIHdvdWxkIGN1cnJlbnRseSBiZSBKYWNvYiBL
ZWxsZXIncw0KPiBSZXZpZXdlZC1ieS4NCj4gDQoNClBhdGNoIGxvb2tzIG9rYXkgdG8gdXMuDQpQ
bGVhc2Ugc3VibWl0IGEgdjIsIG1lYW53aGlsZSB3ZSB3aWxsIHRlc3Qgb25jZSBhbmQgZ2l2ZSBh
IHRlc3RlZC1ieSBhcyB3ZWxsLg0KDQpUaGFua3MsDQpTdW5pbC4NCg==

