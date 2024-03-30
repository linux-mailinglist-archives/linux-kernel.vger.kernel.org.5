Return-Path: <linux-kernel+bounces-125598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19144892938
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 05:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA4F1C211FE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2578BFA;
	Sat, 30 Mar 2024 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MrNL1UwF"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2092.outbound.protection.outlook.com [40.92.40.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024F8F40
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772205; cv=fail; b=kbF3zKSctLMqm/zOt35j3vTDV2TrtPtZY/kGBfUB1k6bqHvX616DK8c6S0a6JULgd81zSeU1RhbyY1/wxIlVoezJphQ4uyebF5IFoKXzxZ8GxBw9ENcyjtbRPUdRpI+A2aSrWMUYZWuj6gTl8PWgfBRApoDnrAIs8BjUo4rH0Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772205; c=relaxed/simple;
	bh=ux33UozO1JSMltgUHd+kwTVHrlS98DpN1FJRmsOr8M4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hjla7yBSdEikWhXQKfjtpX7O1h4fUqVRx1G3GqRSDguwaw4alu+MWItNZfZEt0Ilf9F3K57kSdtdPyoo//jTjJ7MNCULRETiXW5fxJH7YJFwY07OtyBJ6n6jw8htp5dTycD3TGZ4bGEhPdrkge5xn0BUtUEdaZtbm5n6NBlAv0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MrNL1UwF; arc=fail smtp.client-ip=40.92.40.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnSBZj2XEZutcCGZDqWKcc2ABbntwjF+vFe90r2cMLfbzJ6tf5RxNkUi25hr8bk9oKvrBg2Hm4qAgEAtBNzQzWIZWFQGjxWrEGrGg1Pnwh3aIxhXjSars5QxDWaT4CyQe2kfUpNswBPWLATXG5Ot75zeDPH4o35uwG4QByZ90DP0QZvvTW8D/oOOlT0asDM9XUk4nG4DwLouwMsWzJnkleacj+fj11s9lQLl7ogEZGPXBn3L91BLvpwNxM2J3KH3TCJMUD9I1Rh8WUO8IWCSSEtbICl4rTD79vexbcN/jl/GZRXruACGwbNHm9+lmBoWdcC5OQIss7soYgkGwsEm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux33UozO1JSMltgUHd+kwTVHrlS98DpN1FJRmsOr8M4=;
 b=UZh2F3oeA+gljJufcpqX0yTJVY2PrWg+50HRtHO9fIwXRPJFIpYatJ3DO9jQGptS2GruH+E3Um5q35FrfF0w/pzv4/98NmGMsO3tzMwt2HYd4W5FrG5tgbtROEmS/yvQRUcvjriJDBXUaqotsYPzggbgiMztNSKgCX9APVGbjneHKAaqJHlmAuO/RWvpVYy4ZPNym1SWl7lecvnB+R+w4isYlVulxtNdxMVgcpQrCmND2d4jvMIUWtRkfSWnh453AzM4cbanHAKbPaTqcKe0UK25FTnFz4yRP2viY7k1ayg/lFLxok0e4jCaTqwhE852tbYXJbNYuOioNdXjBu3OSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux33UozO1JSMltgUHd+kwTVHrlS98DpN1FJRmsOr8M4=;
 b=MrNL1UwFoGj5xsVubmit5lI5R4+pmE9mRLJpky8gMDoJA3Ss75Z1zTk2Y/FcqGCayp0o3z8apOPIsf4JYxPu3+4ttMCyBID0xjYQX9FksFUk+x+rwcWTvImri0DbMfzp7G1AMcKruShLxSj8TVx/p4Haq7tqLsDAcEkAj+g0HyfRjHJxuEzwZlod4TTUOw00Yk/PNC7BCxShvWWfHTU6yAY+ySCMBTzPs7JJIoisWmyqqzsWowSVx3o0TRiFM4k0KraGLBe0IRnX4O/sprnqgsrN7MssuXkPi20fQkQDkwP0NDfYbHX5udPSwtQ37p8Slq23uIR98kOemRI8BACPgg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB8722.namprd02.prod.outlook.com (2603:10b6:303:135::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Sat, 30 Mar
 2024 04:16:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.039; Sat, 30 Mar 2024
 04:16:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
CC: "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "bumyong.lee@samsung.com"
	<bumyong.lee@samsung.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>, "petr@tesarici.cz" <petr@tesarici.cz>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
	"lukas@mntmn.com" <lukas@mntmn.com>
Subject: RE: [PATCH 1/1] swiotlb: Fix swiotlb_bounce() to do partial sync's
 correctly
Thread-Topic: [PATCH 1/1] swiotlb: Fix swiotlb_bounce() to do partial sync's
 correctly
Thread-Index: AQHaf/lWraZcrrhkY0Gb6WUeMEQR3bFLGYkAgAMVBwCAAJj9YIAA0/eAgAAPnPA=
Date: Sat, 30 Mar 2024 04:16:30 +0000
Message-ID:
 <SN6PR02MB41578CEA46D8DD626829294ED4392@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240327034548.1959-1-mhklinux@outlook.com>
 <ZgO3HlYWo6qXaGs8@atmark-techno.com> <ZgZNAM337-UEY1DH@atmark-techno.com>
 <SN6PR02MB41574B5BC91B70AE74E51FE6D43A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zgd_JaCHzOOLqWUM@atmark-techno.com>
In-Reply-To: <Zgd_JaCHzOOLqWUM@atmark-techno.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [pCflmJqLYlkVm0duc7xcgVnFAqXEZVoj]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB8722:EE_
x-ms-office365-filtering-correlation-id: bd5f6790-c1d1-4126-4154-08dc50702d37
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OmTv1yFbD1VfJOKiQtuvQmrI9BWVOtgqSal50379uzAQcY0+9X1PR5DTBdPluZXmR33OdOPQL79biTOLB/ZOWKk+HOr2XawvblQI3IqlN+JV9/XIgVXLJcRld1FaxW5OkduoHh/blSwnS/MfqrCVHBZziqzjbziOWT852bvtX0XSjreI0tycyFAzeOpTPtkilmDGbUZeJ+BITAbEgav5xNzigi6L+B1a+kW90xgGci4xIT4lkhznrTpCwMtGzGwO8ITx3j8IkPJxPIB2WH64wjfcQ6i57r37T2uFHozCWMCxEdBvviUSVg76xSkwxVRdtrw0QHSCtiHjsr2QTrjkaUaDyZkEhlLPhstpKe+lB0OmYGc6XNSmWa9ydqcLydej1ojRBPYq6DcP+pVZ0Ym/nDrgh3VeY+Fzxi8Nlg6jgdeyRh7XfNxcSAtNzja5BXG9AzMw62HqHLOjO40GWLwmjd1Ed7tVGpLfNOj81GdD5ukiwdU/nBr7Ks9R+viYlNRRQH1J7s14rjnoeR1GOyFPbuy0KVX4D7rigAD61PZndrcnzA3cyr0PtkK8Pd6edHz7
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEhxazNVNmN0SlFUYWVxSW10UWlobU1EcW5aWDBRcSs0M29CQUhlMFp1OHEx?=
 =?utf-8?B?Zk1QZ0xoWWpSZTczdVhBeUNxclZnL1pkUXVnbVNVUEFweDNxc3pOWVdXYjZC?=
 =?utf-8?B?Rkg2NXQraGhxOGkwU3EyaXlSRFFWeUpnVkZJUnR0YXE2TExzeGxZYXE1VHlp?=
 =?utf-8?B?a2VGYVdPbkhvbm50WmcwUzgrSDhVeDlpL2ExTFFLUVdQWkVDRWVESHQ4RHdC?=
 =?utf-8?B?UHFYZnoramxGcHZSMi9ROHFqUWxWejJ5RGltVmE5WXhYMmJTSjY0aWVqQi95?=
 =?utf-8?B?YzZCYktSUkpzdnFsQmN6OEZqRWRlRXAzWEdpa21uRmo4aHNVbVNVMTBhd0w1?=
 =?utf-8?B?VlRFa1Q5YTRQR2pDQ2pUQ0MyVnRtY2lXZzNpMnJXQUpVODl5UVo0dE01THJv?=
 =?utf-8?B?djd3SDR2VlhuVG4vWGxZbGROY3VvZng5SURaeUtLK1YvZ0g4VHNKR3ZkYkQ5?=
 =?utf-8?B?bG4vWFhwQ3NDRC9ISGhpYm5wa0pPbkRrUisxZ09qbHJsSG4vdnpWcGo5dC8r?=
 =?utf-8?B?VURtKzc0NU1wOVM3NHQyM3hrdC9Fd21FQmR2V1dFZE5WVVErNUgweVdSQ0dU?=
 =?utf-8?B?RkFPbmZMYXhzNzZaNjBGeVhySTMyaWdyQjhWUWFzbFVnSDNCdFVFL3loekdv?=
 =?utf-8?B?WFJwVVNCVU9Gek50MDZCdEJueWp5QmphalhlME9NZGgvRzc2WW1ENU1DWFFh?=
 =?utf-8?B?aGZtM3dWOTVJQU8zcERTSFFvcUx0Tmh1OUlzN3UvME9BdzVKc3lXcktmR2Zz?=
 =?utf-8?B?WFZvMEduc25HUkw2S29UUE5FY25TcTdBMmFneFFaaWVYQ3Jpd0NkN2pobGp0?=
 =?utf-8?B?VktrUUhIeGZLVVZORWthWUFYVTcxY2RiZ2dzcERZU2M2MXpRNlRFOGJEWjU2?=
 =?utf-8?B?aFc0dkowNCtLOEJWUVYwU0xKdWZiNEhmN1BidUZhaTJyemVUenY5V2dtREJz?=
 =?utf-8?B?YnFZdXJ0cDVpOUU5TFNLdHlNdFZBSjZQdWRmUGl3RDdjaDg1UlBoaG9mK0t5?=
 =?utf-8?B?T2FFWHJzNTlyYnhIQlNuVTFxUlBVRHNCV0dEVzJSM0JMSjRUOUM4ZlRMYUdl?=
 =?utf-8?B?YlZIbXM4RFhzVlRwUzVwUkFNK0RtYWlsSElPbTU0em55cXgxekpmNm90bDh0?=
 =?utf-8?B?blNYMGdCRVZRK3NiZzRveEVxYVlhREpLaUJxelFEKzlTQUx4Wml2VEVQTXlI?=
 =?utf-8?B?TmJWR1J3U05kendJODZlKzhsbnJ4RWJjUlJLVEhMZHY5Y2ltRE5aRXR4a0dy?=
 =?utf-8?B?M0UxZ2FRSFpNWHB2QkxHSldGZUFHTjN3UThNTkJWOEFHWnhsenhjenBXb3FH?=
 =?utf-8?B?aVg2RGZXMUMrckJMNC90UC9zUW8wTk0xOVNaUm9pRlJSVnJobGJVUHpGcVU5?=
 =?utf-8?B?ZkFIV3gzd0ZYVDM1clIxT2xJckFPVkg3cWhmTm5JSHlHa2I3amNXZ3c5SmFH?=
 =?utf-8?B?L3JDVHljZkZmWDFtR3ZxV0tYWUY1R0dHdEpuNUtBV0lrNE5Md3BZMmIxWXFT?=
 =?utf-8?B?RVpSVnZxeGJQbGFTWkVVeFAvSUU2MkhUMk5GL0pCNmlWaS80TUErQUluV3BJ?=
 =?utf-8?B?U2dMMkViUnNOa1QxMzRqb3F6ZUxYK3ZMZURxOUxFR1pWQnNZS3ZDM1IwNElp?=
 =?utf-8?B?ZE5HNzVCVHd5TVRJUXQvMy9MdEI1T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5f6790-c1d1-4126-4154-08dc50702d37
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2024 04:16:30.4554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8722

RnJvbTogRG9taW5pcXVlIE1hcnRpbmV0IDxkb21pbmlxdWUubWFydGluZXRAYXRtYXJrLXRlY2hu
by5jb20+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjksIDIwMjQgNzo1NiBQTQ0KPiANCj4gTWljaGFl
bCBLZWxsZXkgd3JvdGUgb24gRnJpLCBNYXIgMjksIDIwMjQgYXQgMDM6MTg6MTZQTSArMDAwMDoN
Cj4gPiAqIHRsYl9vZmZzZXQgPSAxIC0gMyA9IC0yLCBhcyB5b3UgZGVzY3JpYmUgYWJvdmUNCj4g
PiAqIG9yaWdfYWRkciA9IDM5ICsgLTIgPSAzNy4gIFRoZSBjb21wdXRhdGlvbiB1c2VzIDM5IGZy
b20NCj4gPiBzbG90WzFdLCBub3QgdGhlIDcgZnJvbSBzbG90WzBdLiAgVGhpcyBjb21wdXRlZCAz
NyBpcyB0aGUNCj4gPiBjb3JyZWN0IG9yaWdfYWRkciB0byB1c2UgZm9yIHRoZSBtZW1jcHkoKS4N
Cj4gDQo+IFRoZXJlIGFyZSB0d28gdGhpbmdzIEkgZG9uJ3QgdW5kZXJzdGFuZCBoZXJlOg0KPiAx
LyBXaHkgb3JpZ19hZGRyIHdvdWxkIGNvbWUgZnJvbSBzbG90WzFdID8NCj4gDQo+IFdlIGhhdmUg
aW5kZXggPSAodGxiX2FkZHIgLSBtZW0tPnN0YXJ0KSA+PiBJT19UTEJfU0hJRlQsDQo+IHNvIGlu
ZGV4ID0gKDMzIC0gNykgPj4gNSA9IDI2ID4+IDUgPSAwDQo+IA0KPiBBcyBzdWNoLCBvcmlnX2Fk
ZHIgPSBtZW0tPnNsb3RzWzBdLm9yaWdfYWRkciBhbmQgd2UnZCBuZWVkIHRoZSBvZmZzZXQgdG8N
Cj4gYmUgMzAsIG5vdCAtMiA/DQoNCm1lbS0+c3RhcnQgaXMgdGhlIHBoeXNpY2FsIGFkZHJlc3Mg
b2YgdGhlIGdsb2JhbCBwb29sIG9mDQptZW1vcnkgYWxsb2NhdGVkIGZvciBzd2lvdGxiIGJ1ZmZl
cnMuICBUaGF0IGdsb2JhbCBwb29sIGRlZmF1bHRzDQp0byA2NCBNYnl0ZXMgaW4gc2l6ZSwgYW5k
IGlzIGFsbG9jYXRlZCBzdGFydGluZyBvbiBhIHBhZ2UgYm91bmRhcnkNCih3aGljaCBpcyBpbXBv
cnRhbnQpLiAgSXQgaXMgZGl2aWRlZCBpbnRvICJzbG90cyIsIHdoaWNoIGluIGEgcmVhbA0Ka2Vy
bmVsIGFyZSAyIEtieXRlcyBlYWNoIChJT19UTEJfU0hJRlQgaXMgMTEpLiAgV2hlbiBhIG1hcHBp
bmcNCmlzIGNyZWF0ZWQsIHN3aW90bGJfdGJsX21hcF9zaW5nbGUoKSByZXR1cm5zIGEgdGxiX2Fk
ZHIgYmV0d2Vlbg0KbWVtLT5zdGFydCBhbmQgbWVtLT5zdGFydCArIDY0IE1ieXRlcyAtIDEuICBU
aGUgc2xvdCBpbmRleA0KZm9yIGFueSB0bGJfYWRkciBjYW4gYmUgb2J0YWluZWQgYnkgZG9pbmcN
Cg0KCWluZGV4ID0gKHRsYl9hZGRyIC0gbWVtLT5zdGFydCkgPj4gSU9fVExCX1NISUZUOw0KDQph
c3N1bWluZyB0aGF0IG1lbS0+c3RhcnQgaXMgb24gYSBib3VuZGFyeSB0aGF0IGlzIGF0IGxlYXN0
DQphcyBiaWcgYXMgSU9fVExCX1NISUZULiAgU28geW91ciBleGFtcGxlIG9mIG1lbS0+c3RhcnQg
YmVpbmcNCjcgaXNuJ3QgdmFsaWQuICBJZiB3ZSdyZSB1c2luZyBhbiBleGFtcGxlIHdoZXJlIHRs
Yl9hZGRyICIzIiBpcw0KcmV0dXJuZWQgZnJvbSBzd2lvdGxiX3RibF9tYXBfc2luZ2xlKCksIGFu
ZCB0bGJfYWRkciAzMw0KaXMgcGFzc2VkIGFzIHRoZSBhcmd1bWVudCB0byBzd2lvdGxiX2JvdW5j
ZSgpLCB0aGVuDQptZW0tPnN0YXJ0IHdvdWxkIG5lZWQgdG8gYmUgemVybyBmb3IgdGhpbmdzIHRv
IHdvcmsuICBJZg0KbWVtLT5zdGFydCBpcyB6ZXJvLCB0aGVuIHRsYl9hZGRyJ3MgMCB0aHJ1IDMx
IGFyZSBpbiBzbG90IDAsDQphbmQgdGxiX2FkZHIncyAzMiB0aHJ1IDYzIGFyZSBpbiBzbG90IDEs
IGV0Yy4NCg0KPiBXZWxsLCBlaXRoZXIgd29yayAtIGlmIHdlIGZpeCBpbmRleCB0byBwb2ludCB0
byB0aGUgbmV4dCBzbG90IGluIHRoZQ0KPiBuZWdhdGl2ZSBjYXNlIHRoYXQncyBhbHNvIGFjY2Vw
dGFibGUgaWYgd2UncmUgc3VyZSBpdCdzIHZhbGlkLCBidXQgSSdtDQo+IHdvcnJpZWQgaXQgbWln
aHQgbm90IGJlIGluIGNhc2VzIHRoZXJlIHdhcyBvbmx5IG9uZSBzbG90IGUuZy4gbWFwcGluZw0K
PiBbNzsgMzRdIGFuZCBjYWxsaW5nIHdpdGggMzMgc2l6ZSAyIHdvdWxkIHRyeSB0byBhY2Nlc3Mg
c2xvdCAxIHdpdGggYQ0KPiBuZWdhdGl2ZSBvZmZzZXQgaW4geW91ciBleGFtcGxlLCBidXQgc2xv
dFswXSBpcyB0aGUgbGFzdCB2YWxpZCBzbG90Lg0KDQpSaWdodCwgYnV0IHRoZXJlIHdvdWxkbid0
IGJlIG9uZSBzbG90IG1hcHBpbmcgWzc7IDM0XSBpZiB0aGUNCmFsaWdubWVudCBydWxlcyBhcmUg
Zm9sbG93ZWQgd2hlbiB0aGUgZ2xvYmFsIHN3aW90bGIgbWVtb3J5DQpwb29sIGlzIG9yaWdpbmFs
bHkgY3JlYXRlZC4gIFRoZSBsb3cgb3JkZXIgSU9fVExCX1NISUZUIGJpdHMNCm9mIHNsb3QgcGh5
c2ljYWwgYWRkcmVzc2VzIG11c3QgYmUgemVybyBmb3IgdGhlIGFyaXRobWV0aWMNCnVzaW5nIHNo
aWZ0cyB0byB3b3JrLCBzbyBbNzsgMzRdIHdpbGwgY3Jvc3MgYSBzbG90IGJvdW5kYXJ5IGFuZA0K
dHdvIHNsb3RzIGFyZSBuZWVkZWQuDQoNCj4gDQo+IA0KPiAyLyBXaHkgaXMgb3JpZ19hZGRyIDM3
IHRoZSBjb3JyZWN0IGFkZHJlc3MgdG8gdXNlIGZvciBtZW1jcHksIGFuZCBub3QNCj4gMzM/IEkn
ZCB0aGluayBpdCdzIG9mZiBieSBhICJtaW5pbXVtIGFsaWdubWVudCBwYWdlIiwgZm9yIG1lIHRo
aXMNCj4gY29tcHV0YXRpb24gb25seSB3b3JrcyBpZiB0aGUgZG1hX2dldF9taW5fYWxpZ24gc2l6
ZSBpcyBiaWdnZXIgdGhhbiBpbw0KPiB0bGIgc2l6ZS4NCg0KVGhlIHN3aW90bGIgbWFwcGluZyBv
cGVyYXRpb24gZXN0YWJsaXNoZXMgYSBwYWlyLXdpc2UgbWFwcGluZyBiZXR3ZWVuDQphbiBvcmln
X2FkZHIgYW5kIHRsYl9hZGRyLCB3aXRoIHRoZSBtYXBwaW5nIGV4dGVuZGluZyBmb3IgYSBzcGVj
aWZpZWQNCm51bWJlciBvZiBieXRlcy4gICBZb3VyIGV4YW1wbGUgc3RhcnRlZCB3aXRoIG9yaWdf
YWRkciA9IDcsIGFuZCBJDQpwb3NpdGVkIHRoYXQgdGhlIG1hcHBpbmcgZXh0ZW5kcyBmb3IgNDAg
Ynl0ZXMuICAgSSBmdXJ0aGVyIHBvc2l0ZWQNCnRoYXQgdGhlIHRsYl9hZGRyIHJldHVybmVkIGJ5
IHN3aW90bGJfdGJsX21hcF9zaW5nbGUoKSB3b3VsZA0KYmUgMyB0byBtZWV0IHRoZSBtaW4gYWxp
Z25tZW50IHJlcXVpcmVtZW50ICh3aGljaCBhZ2Fpbg0Kb25seSB3b3JrcyBpZiBtZW0tPnN0YXJ0
IGlzIDApLiAgU28gdGhlIHBhaXItd2lzZSBtYXBwaW5nIGlzICg3LCAzKS4NCk5vdyB3aGVuIHN3
aW90bGJfYm91bmNlKCkgaXMgY2FsbGVkIHdpdGggYSB0bGJfYWRkciBvZiAzMyBhbmQNCmEgc2l6
ZSBvZiA0LCB3ZSBrbm93Og0KDQoqIHRsYl9hZGRyIDMzIGlzIGluIHNsb3QgMQ0KKiB0bGJfYWRk
ciAzMyBpcyAzMCBieXRlcyAoMzMgLSAzKSBmcm9tIHRoZSBiZWdpbm5pbmcgb2YgdGhlIA0Kc3dp
b3RsYiBhcmVhIGFsbG9jYXRlZCBmb3IgdGhlIG1hcHBpbmcgYnkgc3dpb3RsYl90YmxfbWFwX3Np
bmdsZSgpDQoqIFNvIHdlIHdhbnQgdG8gYWRkIDMwIGJ5dGVzIHRvIHRoZSBvcmlnX2FkZHIgdG8g
Z2V0IHRoZSBhZGRyZXNzDQp3aGVyZSB3ZSB3YW50IHRvIGRvIHRoZSBtZW1jcHkuICBUaGF0IGlz
IDcgKyAzMCA9IDM3Lg0KKiBUaGUgc3dpb3RsYiBhcmVhIGFsbG9jYXRlZCBmb3IgdGhlIG1hcHBp
bmcgZ29lcyBmcm9tDQp0bGJfYWRkciAzIHRocm91Z2ggdGxiX2FkZHIgNDMgc2luY2UgdGhlIHNp
emUgb2YgdGhlIG1hcHBpbmcNCmlzIDQwIGJ5dGVzLiAgSWYgd2UgZG8gYSBwYXJ0aWFsIHN5bmMg
b2YgNCBieXRlcyBzdGFydGluZyBhdA0KdGxiX2FkZHIgMzcsIHRoZW4gdGhhdCdzIHZhbGlkIGJl
Y2F1c2UgYWxsIDQgYnl0ZXMgZml0IHdpdGhpbg0KdGhlIG9yaWdpbmFsbHkgbWFwcGVkIDQwIGJ5
dGVzLg0KDQpNaWNoYWVsDQoNCj4gDQo+IA0KPiA+ICogc2l6ZSBpcyBzdGlsbCA0LiAgVGhlcmUn
cyBubyBjb21wdXRhdGlvbiBpbiBzd2lvdGxiX2JvdW5jZSgpDQo+ID4gdGhhdCBjaGFuZ2VzICJz
aXplIi4NCj4gPiAqIGFsbG9jX3NpemUgaXMgcHVsbGVkIGZyb20gc2xvdFsxXSwgYW5kIGlzIGFk
anVzdGVkIGJ5IHRsYl9vZmZzZXQuDQo+ID4gVGhpcyBhZGp1c3RlZCBhbGxvY19zaXplIGlzbid0
IHVzZWQgZm9yIGFueXRoaW5nIGV4Y2VwdCBhcyBhIHNhbml0eQ0KPiA+IGNoZWNrIGFnYWluc3Qg
InNpemUiLg0KPiANCj4gUmlnaHQsIHNvcnJ5IC0gc28gc2l6ZSBpcyBvayAoYXNzdW1pbmcgc2xv
dFsxXSBpcyB1c2VkLCBJIGNvbmZsYXRlZCB0aGUNCj4gdHdvIHNpemVzLg0KPiANCj4gDQo+IEkn
bSBwcm9iYWJseSBzdGlsbCBtaXNzaW5nIHNvbWV0aGluZyBoZXJlLCB0aGFua3MgZm9yIGJlYXJp
bmcgd2l0aCBtZS4NCj4gLS0NCj4gRG9taW5pcXVlDQo=

