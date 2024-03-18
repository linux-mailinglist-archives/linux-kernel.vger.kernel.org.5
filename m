Return-Path: <linux-kernel+bounces-106193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7BD87EA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C5128118E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E611E4CE08;
	Mon, 18 Mar 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="rWv0rn9f"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7D376EB;
	Mon, 18 Mar 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770842; cv=fail; b=A5KrtkM2LaJ7NpTmEOAzykaYhPSaYbXuD8WSLzdWeEyX92xw/+ml4MTSO30gKjh0XgqWAdx1/NMVV0bOX1QLcuefamPzpUC1fHW/FfBMDHdxW85Le0bDsaxxfOv/U6H0aRS47v4fT2ryiN/74uWs5Gz6J/vKw5OFgsx05q0c8Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770842; c=relaxed/simple;
	bh=tOSuoIi+lmnJF9Vn5y1sosW8XL6shboYx3A/eVS3lnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s0xAQAaJrVE0Cd0DebGvGIUbFgdCgboY1sYUjgKTHVEVYHg4qNH62zGo2lU4Nm3s2QlUkN33pD2qbZCN8MzG5ljNfsAIJNO8SXDfOvcUcl1F3gPbvN7DjYrwm2gQnviSM/ND8Ijgo9X0syY2uZk7b+cTI/gEspCBn/zg4dmqALk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=rWv0rn9f; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42I9gf6N010955;
	Mon, 18 Mar 2024 07:06:56 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wxk77gq21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 07:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD0aOTn6zgHLi6crE+FCQEEBMrthHP1qcX6UjV7p0EGtV+xbPL0g1JQzbCT+Do/fUJfjBCx7JnAq33NetMzdCKaY/iPFyyBsHSU1EnbRceSoySPrZ7J/6DMAypMFO+zh2FtOpim4mvLBKCWR9dxxlJgV80mGbnbizsvJ23GQPP2ZEytp+l70ibR65ISgrWaKUvoWiCwkdje0j2ycTMTjJ7j9bkbPeegT743STlUIKinGVIXZ0OXLm62dP34IO+RVgtnQ86B6Yfg3Mjjjkht0wrZWnRWgr2AS+ZPuiwrjtw0ooO/VTE+nbxJcF/URqJJr6HMkjRie7FCTGuBE1MU+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOSuoIi+lmnJF9Vn5y1sosW8XL6shboYx3A/eVS3lnI=;
 b=ECSQ2ncup76Iyg8viBBuw5VpSGGJYwU+IYaGKcTL4Xs/pUOiviBKb0zrZ0Da9abjFebPK/FceuRYUbHJVQz0TTynAhPODC9FSQnK0hK0N7jUY96UYUU1UCH08kFR/BRHUTcUmQizwsEov7Ii66WhhjFg5Rf8xhEpTWauTQ83+BcE17yRVFabfXjWKEnXtJ0t0tE7G0BKyVcS68Uwq9mQaWS25kx6/R2eZWPDHRgKpGt5tAvmmJWOsT8CWnHfVrcbISMC581Ci/gTMGzA2CDh6pcKdj8OeAFcTFvbX58c5sCcHliFRctMq62f5N1KDKch3eST6+WFlvmPgrlnsxZdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOSuoIi+lmnJF9Vn5y1sosW8XL6shboYx3A/eVS3lnI=;
 b=rWv0rn9f7wC26zI6PZN2nKThjCV6Ro7Q0bhnjRB9dRAvQBUgzGZQi5UIv9hVuPGdn1mQyQSlZB9OInh4gH1u+43b981OAAeESS65sgbFMSnjo4llX6g/6ariKPyKdERzjLNrAjYi7+LjYJm+uUrxrk6R8h9a1risWLWqnU/LBl8=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by CH3PR18MB6007.namprd18.prod.outlook.com
 (2603:10b6:610:1e4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 14:06:54 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 14:06:54 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Mark <mark@yotsuba.nl>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Hans de Goede
	<hdegoede@redhat.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Breno Leitao <leitao@debian.org>, Ingo Molnar
	<mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] netpoll: support sending over raw IP
 interfaces
Thread-Topic: [EXTERNAL] [PATCH] netpoll: support sending over raw IP
 interfaces
Thread-Index: AQHaeSmEOc7lRsQg302gwrYwJRCanLE9g3Jg
Date: Mon, 18 Mar 2024 14:06:54 +0000
Message-ID: 
 <MWHPR1801MB191845C94DD80E4CD6C8C962D32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240313124613.51399-1-mark@yotsuba.nl>
 <20240313133602.GA1263314@maili.marvell.com>
 <7C42FC4B-D803-4194-8FBB-19A432D37124@yotsuba.nl>
 <MWHPR1801MB1918F15413BA4766F29A8581D3292@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <57AE2A31-257C-4702-A571-C590A5DD234A@yotsuba.nl>
In-Reply-To: <57AE2A31-257C-4702-A571-C590A5DD234A@yotsuba.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|CH3PR18MB6007:EE_
x-ms-office365-filtering-correlation-id: a5ed6a64-3beb-47c0-8e19-08dc4754aa69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 saIl4/uroRRTQmr8icDnfJNBdf7vIfmCgZFo2nn7cdb3x9RXXmrJSzxYqys2t0XAeNCjZSlLXJHgWSBsHy9C5lX91ljcoghvFu+05+R0n5JXJw+nLIdYH9Hp1MrylIBVPCWyLQmXcJeJYXNuFne01AVfDaSdbZkF+oSOUljiBkjt930srU3OWjaT8cOw8KXWTC+oMiqaz2fOnxs7o8HzcwWlQl5fLtvBuoOIYzTMz+kYnSEzVe46bbG0ag+y759yZ+ZIjDPcynmHWR3ulq1JV4huNDquD/DntWiTS7pialm9kKrACIl5lC8wrdAWcwtcxkP+z6Rj1nlEIpUy03y2hiv1WC8hugELFxEJCURVEowN2Kb12e7xzVgM9UAP2lqK6ubH6zBSlwjtvBfhJCinfyqTGA2FGRqKOIsy1zHuS53BgDAnOD8cjtHkdOxQZg3y3Ey0TqznSvvWafMFFsWMMWawPqJBqY5nNK+c+xNToZ0uqbdJTvmAN/b+g80VD9IXJu/e9QJbk4LU3E0K7FfDTjWaQyKhFFaBc3udrUTkc5fmzmztelxBmP96CHu0jNiCC/NkiHBmxurlnKi7katTITqDQpMhYISdT670iw1eVCmusgoCMV1a2Sx/UiuLnlTBmuICJuRC9FHG8g7JM77O3HpU+CDSHhb8Am7x4J20HwL72ZQ56tt9XmOAhtbcwFPhNDCSF1Z9sBZVAwBVaa7PwQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c3o3M2RrYU9IWWxOY2tWK2ZweHBOTnpWbkxLOE42bGpyL2dPMHZaN0N1QW83?=
 =?utf-8?B?ZkQ2NS9OUVRGRk5sMXcxczdmZUpYaWgxZ3R6SzNFcEpQMGw4K00vVTUwRmpo?=
 =?utf-8?B?Y04zaHY4Vm1FTFdvSEF3NW0vdkxkbHlaZWpoU25DOXNtWld6aGpuaEZLbS9S?=
 =?utf-8?B?YXNJZ2M4N0RFNmxSd2R1cGcyam4rU08yRk1hYmpGeDZ5Yzd5KzRqZ01NRVpq?=
 =?utf-8?B?WjFpTGdtRkdlMDZ0ZzZQUUpGOTdjN1d4QzAyWFUxOWM4T1JORTQ5T2haSWxW?=
 =?utf-8?B?YWpPaE8rYm1HUjNHMytBTTYwd2t3TkJHQnZ2aDBMT3ozOHhaZGRaU0NBTGV4?=
 =?utf-8?B?WFVwWU9CNEpKV3hhNzREN0JNQWFNdWpzR1BRTkY3NDNVeHA0MEZYWUUzWVFv?=
 =?utf-8?B?L0l1cjdOdDUybm1GMVRMRVhEWXFLdDB3a3Z4SmFFdkVIdDZQbU5OZUYvbHlh?=
 =?utf-8?B?emM4bzdUWXQ4eERNVXJ2YWlOVXV4ZGpmY3pFV2cwc29jTTQwN3dJM1AvS1do?=
 =?utf-8?B?Z2lEOVc3MzViK1NIbVdBZGszWnQ3NkpMZTFZUlNUZXpUN1ZBWTNRcGVxMEZy?=
 =?utf-8?B?MnAyQmUvQ3RiTHZKZkJkU3YvNjE4aittNDNRNjA0M2lWU2JEaXJZRHNsTWhV?=
 =?utf-8?B?T2dudkZnT1BZcnFYZzgvV1JYTi9jMGxVOTdyMXZrU0xCSVZYZTVTaU83S2lI?=
 =?utf-8?B?d21VMDJMRTlWV1hqMHdvOGozUHhtR055ZktRQThHYjI1dndLM1phVE8vVHlW?=
 =?utf-8?B?K2J3aTJmRzhkZi80QjNieXU1TFhrSzFQT1pjWEJ4VkczSS9OTW9IMjk1Qngx?=
 =?utf-8?B?Q3h6OXF5aTBHOG1MWlhudjNQaU5BUTRYZVF2RTM4MkdyakdLUzRDMlk1NFU2?=
 =?utf-8?B?ejdaSGNGSndSTGVhbmRSblBsbU9DTlBoN3BubVdXNGlvRmg5MGQwdmc0T0hy?=
 =?utf-8?B?emZvOWhHT1pGdjQ0RXY4Q3hRTFVxZGxSd3BkWk1qTzNpSVdPRklYNWsxa2Qr?=
 =?utf-8?B?NmtWMVFWRkdzNWFLSXJIQjdEOC9PbkhmTEpuK014anFiSDJKSlYvUGlIZTkv?=
 =?utf-8?B?MEdlTjVHdkVKRC9Vcjl6TGc5K29Lc3lhNHB0bE1VNjNMbE9wazFnWDdObXlC?=
 =?utf-8?B?Sjh4NkdKNnBwOVNlZVB4d2Z1RC9WUVZpVGpTZEJuS3pIdVRPck1aQk83Zmpk?=
 =?utf-8?B?N3F3M3ZCbUpWR3VZVTZKaUs4ZmRrTlkrRU5lWlRCVzF5Z1JNZTdpZVpHLzY1?=
 =?utf-8?B?eEQ4TDM5ekJBejljdFZYdDF0VWpMZndHN1k2NmFyS082dkhrdjJoNHgzYmdq?=
 =?utf-8?B?Mm5TNFU0QSs3WDYwVG41M1g2b29BZ1VEYUVkaFNaeWpDTXdYL1p0YVM5SmhL?=
 =?utf-8?B?QkNNa0xvcTFROVpJQzduL05HTk5SWTVIeXdtSHlBaHJ5eUtETlV5ZlZtZzdI?=
 =?utf-8?B?OU1VUlc4aTM3TDAwZkh3TzliUmtuRkRMTmZacHRqNjE4cjV2V3lzZ1hldnBY?=
 =?utf-8?B?Mzc4SE5XUVB2anJWcGlISnB1Y3ZhOTZ6bTBwL1N0S3lEcW01TVNIOUYwMWM3?=
 =?utf-8?B?MzlYb3Q2S1AvaytYbTJMUWJFeG8vT3BHVVRtT2ZyQXc3SWtPZW9ZVlQySEs2?=
 =?utf-8?B?d1VSV0hwcXJNeUIzZmVMMXhncW9mb0wvbE9OMlVUYlZZS1ZTdERhUHhMWHBM?=
 =?utf-8?B?Qyt1dDlqSXV2MmFPeUFkaGtJRW1qdmxMcXdBM29XalRiWEJqM2hNSmhWR1FF?=
 =?utf-8?B?RjRXMGJPY0h5NkFHTUMwWkRoT0J2azNWSG1JdFBBUnUvRGZacXJqZ1NsRW9w?=
 =?utf-8?B?K2d6TEU5ZlFWVkJNUGgxY09DU3JxdFp3S1NqcWlodlBHZ2Q4cW9DNU02ZDNB?=
 =?utf-8?B?MzEvQ3J3SDYxdG84YitDczlVOG5FWG5iazRaTUZFT2g4TVFaM3ZTRFhuZzVh?=
 =?utf-8?B?NTFmRCtYWGh1TThVUUVhNTRsZWx6MWRXV0JPRG5jRHN2V2M5ZFg2RS8rVjln?=
 =?utf-8?B?c2RPSTNNN3FDMlZqZXk0TDJGUE9sZmJtaWpoRHJsb3dmdGtKVTF2UEFXQUdZ?=
 =?utf-8?B?WWhnRmFRYy9RVmNDMWhkYThUUVJkQWlQd0gxZmRuek4yVW1STGdMNVZ5VUR6?=
 =?utf-8?Q?CohQmBnzeOlwf1/vTUAkSuXjL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ed6a64-3beb-47c0-8e19-08dc4754aa69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 14:06:54.1431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6VTRWos9lg4+I24MMbnrYrjUzFczUHWIjVE32j6LLhBS5cZXt9ugdbpPB2/qt8mQtbG7vjmYIqo+hur22VEfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6007
X-Proofpoint-ORIG-GUID: 8NefiD-vYHfirzzZlkAlNo3Gb5Sw3HMK
X-Proofpoint-GUID: 8NefiD-vYHfirzzZlkAlNo3Gb5Sw3HMK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_04,2024-03-18_01,2023-05-22_02

PiBGcm9tOiBNYXJrIDxtYXJrQHlvdHN1YmEubmw+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTgs
IDIwMjQgNToxMyBQTQ0KPiBUbzogUmF0aGVlc2ggS2Fubm90aCA8cmthbm5vdGhAbWFydmVsbC5j
b20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBIYW5zIGRlIEdvZWRlIDxoZGVnb2Vk
ZUByZWRoYXQuY29tPjsgRXJpYw0KPiBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFr
dWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IEJyZW5vDQo+IExlaXRhbyA8bGVpdGFvQGRl
Ymlhbi5vcmc+OyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IERhdmlkIFMuDQo+IE1p
bGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNv
bT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhU
RVJOQUxdIFtQQVRDSF0gbmV0cG9sbDogc3VwcG9ydCBzZW5kaW5nIG92ZXIgcmF3IElQDQo+IGlu
dGVyZmFjZXMNCj4gDQo+IA0KPiBIaSBSYXRoZWVzaCwNCj4gDQo+ID4gT3AgMTQgbXJ0IDYgUmVp
d2EsIG9tIDAzOjQ2IGhlZWZ0IFJhdGhlZXNoIEthbm5vdGgNCj4gPHJrYW5ub3RoQG1hcnZlbGwu
Y29tPiBoZXQgdm9sZ2VuZGUgZ2VzY2hyZXZlbjoNCj4gPg0KPiA+PiBGcm9tOiBNYXJrIDxtYXJr
QHlvdHN1YmEubmw+DQo+ID4+IFvigKZdDQo+ID4NCj4gPiBIbW0uICBUaGF0IGlzIG5vdCBteSBx
dWVzdGlvbi4gICBMZXQgbWUgZXhwbGFpbiBpdCBpbiBkZXRhaWwuIE5ldGNvbnNvbGUgaXMNCj4g
dXNpbmcgbmV0cG9sbF9zZW5kX3VkcCgpIHRvIGVuY2Fwc3VsYXRlIHRoZSBtc2cgb3Zlcg0KPiA+
IFVEUC9JUC8gTUFDIGhlYWRlcnMuIEpvYiB3ZWxsIGRvbmUuIE5vdyBpdCBjYWxscw0KPiA+IG5l
dGRldi0+b3BzLT5uZG9fc3RhcnRfeG1pdChza2IsIGRldikuICBJZiB5b3VyIGRyaXZlciBpcyB3
ZWxsIGF3YXJlIHRoYXQNCj4geW91IGNhbiBUcmFuc21pdCBvbmx5IGZyb20gbmV0d29yayBoZWFk
ZXIsIHdoeSBkb27igJl0IHlvdSBkbWEgbWFwIGZyb20NCj4gbmV0d29yayBoZWFkZXIgPw0KPiAN
Cj4gVGhlIHJlc3Qgb2YgdGhlIG5ldHdvcmsgc3Vic3lzdGVtIHNlZW1zIHRvIG5vdCBhZGQgYSBo
ZWFkZXIgdG8gc2ticw0KPiBzdWJtaXR0ZWQgdG8gbmV0ZGV2LT5vcHMtPm5kb19zdGFydF94bWl0
KCkgYXQgYWxsLCB3aGljaCBtYWtlcyBzZW5zZQ0KPiBjb25zaWRlcmluZw0KPiBuZXRkZXYtPmhl
YWRlcl9vcHMgaXMgZWl0aGVyIE5VTEwgb3Igbm8tb3AgZm9yIHRoZXNlIGRldmljZXMuDQo+IA0K
PiBGb2xsb3dpbmcgdGhpcyBsaW5lIG9mIHJlYXNvbmluZywgZnJvbSBBUEkgcGVyc3BlY3RpdmUg
aXQgbWFkZSBtb3JlIHNlbnNlIHRvDQo+IG1lIGZvciBuZXRwb2xsIHRvIG5vdCBzdWJtaXQg4oCY
Ym9ndXPigJkgc2ticyB0aGF0IGFyZSBvdXQtb2YtbGluZSB3aXRoIHdoYXQgdGhlDQo+IHJlc3Qg
b2YgdGhlIG5ldHdvcmsgc3Vic3lzdGVtIGRvZXMgdG8gbmRvX3N0YXJ0X3htaXQoKSB0byBiZWdp
biB3aXRoLg0KPiBJdCByZWFsbHkgZGVwZW5kcyBvbiB0aGUgQVBJIGd1YXJhbnRlZXMgd2Ugd2Fu
dCB0byBoYXZlIGZvciBuZXRkZXYsIGJ1dA0KPiBwZXJzb25hbGx5IEknbSB3YXJ5IG9mIGludHJv
ZHVjaW5nIGFuIGFsbG93YW5jZSBmb3IgYm9ndXMgaGVhZGVycy4NCj4NCklzIGJlbG93IG5ldHdv
cmsgdG9wb2xvZ3kgcG9zc2libGUgPyAgDQpOZXRwb2xsKCktIC0tLS0tLT4gbmV0ZGV2IEEgLS0t
LT4gcmF3IGludGVyZmFjZSANCldoZXJlIG5ldGRldiBBJ3MgIG5ldGRldi0+aGVhZGVyX29wcyAh
PSBOVUxMDQoNCg0KPiBBZGRpdGlvbmFsbHkgZnJvbSBhIHByYWN0aWNhbCBwZXJzcGVjdGl2ZSwg
dGhpcyB3b3VsZCByZXF1aXJlIGNoYW5naW5nIGFsbW9zdA0KPiBldmVyeSwgaWYgbm90IGV2ZXJ5
LCBJUCBpbnRlcmZhY2UgZHJpdmVyLiBJIHRvb2sgYSBsb29rIGF0IHRoZSBXaXJlR3VhcmQgZHJp
dmVyIHRvDQo+IHNlZSB3aGF0IGl0IHdvdWxkIGVudGFpbCwgYW5kIGZyb20gbXkgbGltaXRlZCBl
eHBlcmllbmNlIHdpdGggdGhlIG5ldHdvcmtpbmcNCj4gY29kZSBpdCBzZWVtcyBsaWtlIHRoZXJl
J3Mgc29tZSBxdWl0ZSBhbm5veWluZyBpbnRlcmFjdGlvbnMgd2l0aCBlLmcuIEdTTw0KPiB3aGlj
aCB3b3VsZCBtYWtlIGRyaXZlci1zaWRlIGhhbmRsaW5nIG9mIHN1Y2ggcGFja2V0cyBxdWl0ZSBh
IGJpdCBtb3JlDQo+IGNvbXBsZXguDQpBQ0suDQoNCj4gDQo+IFNvIGZyb20gbXkgcGVyc3BlY3Rp
dmUsIGZpeGluZyB0aGlzIGluIG5ldHBvbGwgaXMgYm90aCB0aGUgbW9yZSBBUEktY29ycmVjdA0K
PiBjaGFuZ2UgYW5kIGludHJvZHVjZXMgdGhlIGxlYXN0IGFtb3VudCBvZiBhZGRpdGlvbmFsIGNv
bXBsZXhpdHkuDQpBQ0suIA0KDQoNCg==

