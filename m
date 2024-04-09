Return-Path: <linux-kernel+bounces-136328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4021C89D2B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1D7B21806
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD53762E5;
	Tue,  9 Apr 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="s2sO4mDn"
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4006E5EF;
	Tue,  9 Apr 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645702; cv=fail; b=BJzHuioticlGMXozwgpeiY4XEJ229S1YShGNgg6Bds/a76nLHjuUFaSS5QWJSdwnxU0227fIqZnOOB+BJHpUND/QLREy7xSeN9/GwuDcDDngZriDp16NXLSzuaWczdvAnGmsn5gGu6zlP4yUzPPKc4o/ua2631lo66wZsHy6Dto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645702; c=relaxed/simple;
	bh=7RNDreJujMDy9OZvDrIEV8wmrjfFvvOk/q4FoHNgV2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TEZ6NXUyMG8zmigwgxkttd2B3sAsbza3are2btwk6Rk+3iWbfJDfUrXpLqDgFt5SPotNfe1RyuYF1XrPV7I/wNdhqbgcNyggUnfARyuGkwlI5qLNBeBxu8FLgCdBCoyU2tW+OQEkSnmUyEr6vB/8la5vzzGONI0gqd1WRnaGTVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=s2sO4mDn; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712645699; x=1744181699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7RNDreJujMDy9OZvDrIEV8wmrjfFvvOk/q4FoHNgV2M=;
  b=s2sO4mDnRPmkuHX4TpKQIMdFuEuMd9IcJWFwYnQVHkgX9CXgM1sAInpw
   Milb2/858ry9vCB8ty2pgOlbvpvu8ZvYhAgWGJkpSzL5pF+R1RTLxs7z7
   Ij/cZHFAmGvAz0ISnWVjCV1D+/4WQeW0z0hZvWHL5+B/EQwcWq5AjLRlH
   SemuYDfkx9xCvRdd1rakIe5jr/ZSTBpCCSSDEOJLf5uDzzuxwPnK7WWzs
   1hEA096N0vw+z+7gORGV4wCiRmixShJY0Xnxf81mSZOhxep9n8CA11YPK
   vFLzAAXKLUSuesbeVqJb19ANlpYli0XNTc+0omi3f1rk38DC2EO7Pcbho
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="27487529"
X-IronPort-AV: E=Sophos;i="6.07,188,1708354800"; 
   d="scan'208";a="27487529"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 15:53:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=db2kfy2ystSdu6jrOmWlH1B9iWxkK3XJfaEVzwwKBoV5KEofNIPgQnUH3/nSbThUpR4iv9L9tdHP06HR2GE9CfPGTNYZxYJgrDuJCEvDIsjXx1exv/rr2Btldwf0oqWnqOmY4g7Ouw2uPo5HgfDvX0SYOL3/5VVbBGxKRF7YqSz9E1hkmxrIXSph4CH28bYgUNBVrrzXKpGrw7YAfLc1PViWWP+pHshFD6t5gqOgz8Gxy7kiUFb0x13tnRFA1hA7mx5bak/EupR6XSScI+Yau/TYFzDbsNIeuDF0YIKv1RLuroOw2lO4YOEP1NbGYO2tnIIapXskkNsFdtFBnoERMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RNDreJujMDy9OZvDrIEV8wmrjfFvvOk/q4FoHNgV2M=;
 b=U8vR9lCBbJIveVD1QTJCjcI4/zWdkJpPpfwTrVqotE7/JKpwGUQ4ev6UQ1hyP1nD0pG+h4FIeo4qpKxasv/wblzVKdLhDpmx7AbEIco9I90mm63KSzynk/sopxrqeGi0JjluKFbZvtXHP+ANdqDm4OVXp23dl8ZWV9DJwvttXuWdKHrvXYU38YemqFi2rBPwHS86Hq3Vd5a9s2sNnnhQ6Oc9TtV13os0ZD4sRFrg6a6eXcwCFl8ZqVY2ueml1djqWidETurlX1yAtqtS6t5+oiwZ/JqnK6ZRKcTmBVIBxU7fjP0EEd+1pfn7gpdQjU3gSTREFXWef03Avqxl4ZJoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYCPR01MB9879.jpnprd01.prod.outlook.com
 (2603:1096:400:221::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 06:53:38 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 06:53:38 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>
Subject: Re: [Problem ?] cxl list show nothing after reboot Re: [PATCH v2]
 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS
 window
Thread-Topic: [Problem ?] cxl list show nothing after reboot Re: [PATCH v2]
 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS
 window
Thread-Index:
 AQHaYPF+guY7ES5MRk+p0kfVt2bmsbFDTJAAgAagGoCAEEYNgIACSTEAgALXHACAAIBiAA==
Date: Tue, 9 Apr 2024 06:53:38 +0000
Message-ID: <eb28ffda-d6ee-4379-9d71-b67e9f80a58c@fujitsu.com>
References: <20240216160113.407141-1-rrichter@amd.com>
 <b0f5e2ce-d39e-4a8e-8f2f-ffa67b604e02@fujitsu.com>
 <24b8b11d-a7ec-42ce-9fa6-8a24701cfe46@fujitsu.com>
 <20240405175711.000032c4@Huawei.com>
 <df850be7-a9d1-4737-bc64-3fb682cd5691@fujitsu.com>
 <66147a3e5c55f_2583ad29433@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <66147a3e5c55f_2583ad29433@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYCPR01MB9879:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 y2ifu1Z5zrFbKS8nt9LkLkB77hK0XoT2n+Yam+KBvqniOIxVz8o11cbTOjCI0J2aymijkqaOKV0t0CV8w+ol/KfgjbyLwPZ7ZsihHusF72ATXeFTNScP5n8b6WakZido5dUKidHR4Njq5PThcp9qno7x/eicXt55uxBUU7B2dJiAA8moflKNxYdeDrKPRMyyJ//76+BfsBYOjJczbJZfKz4BCxrwBLNeRg9vQH8V8ot3ba2mwjYk4FkwpSBRpAIOiHICv7+wUidJdlPfI670Z9ac6lcumaLITRSKsAaET2MeDqcbkd3xLuGh6qwaCN10Z7eMuT1bkvl0s7nRFCprXOXezh1sTcCw9bX2JvB2aZHwCanRhkXeHu86WnfG54PrMRV7BBeIpKZ2diqqHxrfVUxAXhRWslSlqQbF+vbiyZXxzdE58k6zqNFIiGBXr1qm6GZEAs2KoppXtjT9LeKGL60nXmDTTuI6P/hQ6BcX1lQM7vsmp4VBs7yK+id6XuveRaHFcI3S+mw7joKm0gBXufoDsajrRA6Q5J0fVt9Wlbgke0BgILRXWuAuRlQJUEBc9EcAN1mo3XRL90mtFq737qEjL5dFfCt+NThbmN21VxV8H07sJxfQdO9fK7llVJMK1SaVh23V++njXqRZnCP5wSX9HLZ7quMkuhm8Z5ORDFN+y69vGiDSlziK6bru8RqEx/IC+Mp4CyGmhhGJGsvCIg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFBYMWhGaFVzNG9URXdiMVZ3aGFIMEUvN1B6bWp2QVJURDJBS0lUMHFDbnFP?=
 =?utf-8?B?SmpzdXRLSUdVTHVNMVFtNytuYlQzYi9iVFNxQ1RlU3FxVjUwclNJcmRYaWpZ?=
 =?utf-8?B?c0gxZ1RYK0dIbXRrZXRNNlVvbHF4ZTF4L3JKUmE4T21QaVFSOTViSUhFY3hr?=
 =?utf-8?B?cm4vcFVianF5Z3B2N3RnY2hFU2xBV3BCczYwbG5wcUdtUDk5TDArT216Z0hI?=
 =?utf-8?B?UzlDc2FkMjlOQXZaR3l3bHZnbGhoY00zbTE1VFlvZHRLaEx6TjNiNGlyLys3?=
 =?utf-8?B?b2FtREhEVWMwdWtHNGUwVVFEcG50L000Q2x5d1lkSE1peXoyVVRUUnU5dHZk?=
 =?utf-8?B?a3E5SlFBN3l4MUZjdFBubWJhUzNOZjBrMVJId3k5Vy9xMm5PZTFHSnVITG5x?=
 =?utf-8?B?SFFmQ1o0M0lVOWxvbEtzYnQ5OHlOZ1BSczhnQnpuYXNUWWU4QzhIRFNpTXk1?=
 =?utf-8?B?VFowUTJOT1hIV0RxYXlCaGs3akFEczljbGxnNjFjWHJ1TnF0TVFmTzFnVDNx?=
 =?utf-8?B?UGNrOGY0SWlNQitwaEVkRXd0RVF3cFNEUmxGYk9CbTdWYnQzcUVYWThOY3Jm?=
 =?utf-8?B?Yjc5WmUxRk1HR0Z5cmNIdmExdXZEaEtNK3FMRVpOOWZiY1Z4MEdTQ2NJenRF?=
 =?utf-8?B?ckF4WW44ZjVQSkpoMXc3R2dKVkZ6K0tJeFZ4S1Q5ZTZTNWtpTllHb0pIK2ta?=
 =?utf-8?B?eXREMUROQWt2Tko4NGlRVzlva3NROWVWMVh2b3hDbS9mRjgwZC9ZaWRxK04y?=
 =?utf-8?B?WUhJNUpFdHZ6UlpSNzF6TkhXbzFyWU5xY0tTNjJmVFpOS0VrWlpIT1JGZ0tH?=
 =?utf-8?B?Ry8vQ1dlTWNlL244SFZ1MzB4S2s3TUg0OVhrMjhlS0FGa013c1hzZ0VxL1pS?=
 =?utf-8?B?VmVtR2hkNS9SL010ek0rS3VsZUVscytaLzlHTmhqSnhZTzMxSTNzbWhSQ0pU?=
 =?utf-8?B?Z3hGcTZKTEZJQzhYUjg1U1NHTlppMG0zVE1rRUo4RnBCaVBTeXVSR2QwUlVD?=
 =?utf-8?B?TUtDcEJpa1dJNnEyYjNsQ1RsaXFKdmJnNVBBSFk1Q2FaL0ZPdEFpN0dmbGRz?=
 =?utf-8?B?UVFIVWtmMTNoWkRST2ZjYWZrRENrcEpDK29SamtWTllDM3k2QTJuak1Qc3di?=
 =?utf-8?B?Mkd3RnVVVFpiUVp6bVg5L21ma2NFMUJrclc1RFZBQTlsK1Jjb0lxZXI4U2gz?=
 =?utf-8?B?ZU9WK2ZGWHZkSTV3S2d1R29JRUxQU2Y3K2I1SGpRdTUwaC9VQ2dCVS9saTlh?=
 =?utf-8?B?YmR4cENPbllZQXVmaGV5ZGk0Z0tVQjczcUs1d1JWNHN0T0Q2WEJ5OVgyc2FM?=
 =?utf-8?B?SFhwYjViN000NlVxQ1k0bW1nSER6dnE5VVpuOExEWk1Lc3VIdHJUSnRLUnVL?=
 =?utf-8?B?NWFacWloRDVhelNYb1JGMXI4OTQrTVBxY2JlZkg4ekpkY0MxOThCVGw2SDR4?=
 =?utf-8?B?Y1RlTk1BOWRQdkdCQnNBSExQb0o4MVl2U3FCUmtzVG9raUNISjYzN0tLYnUz?=
 =?utf-8?B?TWFBL0pGVE5Bcjl3akJUZUw4bUFlbTM0L2NNRmVsVGNTTDJKMXBJd2IvL3di?=
 =?utf-8?B?d1pwa3lYZjlXNUU1em9PQ2tiU3FhQU5GRjVsYnJZUUlDclltMFZBYnNYY3dQ?=
 =?utf-8?B?UFR1SDlxQmVnOVR6SW1RakRhSStwZTl1dFl2SHVVaC9pTEhkdktOd3FRM2lG?=
 =?utf-8?B?WnVqMXFsWWhZNVBXclltaldmRDM1M0syV0JjVlJGVGdWWWgxQ2U1bXVmRTkx?=
 =?utf-8?B?QVRYeGZENkpoNjFuRTNtNE81ZVlQYVlTRmM2WEVXN1VYclUwVkF3czRsQ0JP?=
 =?utf-8?B?WjRydGlTd3BJcVFhSFJUcFJnQm5SMCtKeVpxV3hyTjJEOVVhTkE5ZU1JVDVX?=
 =?utf-8?B?OUR4RlFlVWUvelkxR1BFbmZzSVRRMUp3UitJMXNib2c5cmErU1ZKQUJDaGlT?=
 =?utf-8?B?WjNyVmYyRUs2bFpVQW1nTEo5U21YL2Q1Q0x1SXhzUk53NjJhVGN3VjNGWEFu?=
 =?utf-8?B?am5kZWo4dWRCalFqd0tOc2ZERjFVa0VnQTlHNmJnUmY4N1RxTWk3VGc1S01n?=
 =?utf-8?B?clJqU1pDd2ErTWlYaGNrQWJveUxFWTdIYUxCMDBYaEtURzFvV2NqNDRLNzlQ?=
 =?utf-8?B?cGZLTHl5ZDBGRFNGL1hNVTMzQ3VPV1F3OFRuUVJDMGhRWUFGOVlTVUF3WHVG?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B312842EDC30A44B1753E23174FE023@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qFQPFjVKpplUxJIHDWi+qMJinAhuWYDB+WFD7oygyTtjGteNUG2hr31MdGA3ft9sQNKj1UDnc8CSCG9nO35/wIeJ8r3lT/0KGhlLbuVPt4j6T+Nthte5ofsUJQccCl1I0WhOTDEHp8z888BaWIVWwKNm9JwNtsHfrbsC7JjGd5F3cGAzDVOWnLezRw3cqUxTXZoXKttZc3Mu7YjiAA6tBT2DURWZiXDYsvI04J7tI49JftkPG600C0UL+PSe/bUB5TY7BnGl8m1hFA9pUfUYrKKWPaZirS06fLD7VFsqh/Z+S0q1mPotE+G3xjohnGOkdI1CmnzPpiPo/3fM7fcm9mapek9IDIvIUP200jDr9IfDb2sWm0Zulr57Fo7UAhKu4F4B8/BgDnAtREBNhCF7ywaCFYZU+L23p8pnYmiXxWqEYglMdh54dQyzw2gdN6LH91ypkOViWFBkG+3SNewQv6OdQmCUUaC63cb4NrIh7mDBzm+JslQudSTO9aSMd86N5p+DC4Sq01S+3dIK3UuP/0DKW3bDw5h7X4zlt5rxTQcoYJynFHxNDqvLhaI1t5ianjHb9zhPVgKeF+rc51VGjP0970zxnw8IPz3ljXmdG6y+xy0afNstc9n69pVwodgU
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91e1d88-163b-408c-6de6-08dc5861c916
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 06:53:38.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPByyM5/YuQ5T13o76cko5YP4prBomEIBIW1con2oi2nhoYBX0YqLdrXqON3R76SYZjY2/xIHULzEDHZ0sFiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9879

DQoNCk9uIDA5LzA0LzIwMjQgMDc6MTQsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gWmhpamlhbiBM
aSAoRnVqaXRzdSkgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDA2LzA0LzIwMjQgMDA6NTcsIEpvbmF0
aGFuIENhbWVyb24gd3JvdGU6DQo+Pj4gT24gVHVlLCAyNiBNYXIgMjAyNCAwODoyNjoyMSArMDAw
MA0KPj4+ICJaaGlqaWFuIExpIChGdWppdHN1KSIgPGxpemhpamlhbkBmdWppdHN1LmNvbT4gd3Jv
dGU6DQo+Pj4NCj4+Pj4gQWxsIGd1eXMsDQo+Pj4+DQo+Pj4+IEluIG9yZGVyIHRvIG1ha2UgdGhl
IENYTCBtZW1kZXYgd29yayBhZ2FpbiwgaSBoYXZlIHRvIG1vZGlmeSB0aGUgUUVNVSBzaWRlDQo+
Pj4+IHdoZXJlIGl0IHJlc2V0cyB0aGUgIkRWU0VDIENYTCBDb250cm9sIiBkdXJpbmcgcmVib290
LiBBIGRyYWZ0IGNoYW5nZXMgaXMgYXMgYmVsb3c6DQo+Pj4+DQo+Pj4+IFBlciA4LjEuMy4yIERW
U0VDIENYTCBDb250cm9sIChPZmZzZXQgMENoKSwgRGVmYXVsdCB2YWx1ZSBvZiBCSVQoMikgaXMg
MC4gU28gaXMgaXQgcmVhc29uYWJsZQ0KPj4+PiB0byBoYXZlIGEgcmVzZXQgZHZzZWNzIGluIFFF
TVUgZHVyaW5nIHJlYm9vdD8NCj4+Pj4NCj4+Pj4gQW55IGNvbW1lbnRzIEBKYW5hdGhhbg0KPj4+
DQo+Pj4gSGksDQo+Pj4NCj4+PiBTb3JyeSBpdCB0b29rIG1lIHNvIGxvbmcgdG8gZ2V0IHRvIHRo
aXMuDQo+Pj4NCj4+PiBXaGF0IGFyZSB5b3UgYXR0ZW1wdGluZyB0byBkbz8gVXNlIGFuIE9TIHJl
Ym9vdCBvbiBRRU1VIHRvIGNoZWNrIHRoYXQgdGhlIGZsb3dzDQo+Pj4gbWVhbnQgZm9yIEJJT1Mg
Y29uZmlndXJhdGlvbiB3b3JrIC0NCj4+DQo+Pg0KPj4gVGhlcmUgaXMgbm8gZG91YnQgdGhhdCAq
dGhlIE9TIHJlYnVpbGRzIHRoZSBzdGF0ZSBjb3JyZWN0bHkqIGlzIHRoZSBPUydzIHJlc3BvbnNp
YmlsaXR5Lg0KPj4gUHJvdmlkaW5nIHRoZSBjb25zaXN0ZW50IGRldmljZSBzdGF0ZSBpcyB0aGUg
KkRldmljZSoncyByZXNwb25zaWJpbGl0eS4NCj4+DQo+PiBTbyBvbiByZWJvb3QsIHRoZSBkZXZp
Y2Ugc2hvdWxkIGhhdmUgYSBjb25zaXN0ZW50IGRldmljZSBzdGF0ZSB3aXRoIGEgZnJlc2ggYm9v
dC4NCj4+IE15IGNoYW5nZXMgaW50ZW5kZWQgdG8gbGV0ICpEZXZpY2UqIGVtdWxhdGVkIGJ5IFFF
TVUgcHJvdmlkZSBhIGNvbnNpc3RlbnQNCj4+IGRldmljZSBzdGF0ZS4NCj4gDQo+IFdoeT8gVHlw
aWNhbGx5IHRoZSBRRU1VIENYTCBlbmFibGluZyBpcyBmb3IgYmFzaWMgY2hlY2tvdXQgbm90IGZv
cg0KPiByZWFsLXdvcmxkIGZpZGVsaXR5LiBJZiBRRU1VIHJlYm9vdHMgZG8gbm90IHJlc3VsdCBp
biByZXN0b3JpbmcgdGhlIHNhbWUNCj4gZGV2aWNlIGNvbmZpZ3VyYXRpb24gYXMgYSByZS1sYXVu
Y2hpbmcgUUVNVSwNCg0KSXQgd2FzIGNvbmZpcm1lZCB0byBiZSB0cnVlIGluIGN1cnJlbnQgUUVN
VSwgc28gd2Ugc2hvdWxkIGZpeCB0aGUgUUVNVVsxXS4NCg0KPiB3aHkgaXMgdGhhdCB3b3J0aCBm
aXhpbmc/PiBKdXN0IGRvY3VtZW50IGl0IGFzIGEgcXVpcmsuIE5vdywgaWYgaXQgaXMgYSBzaW1w
bGUgZml4LCBncmVhdCwgYnV0IGk+IHNlZW1zIGxvdyBwcmlvcml0eSBnaXZlbiB0aGUgZW5hYmxp
bmcgaXMgcmVhbGx5IG9ubHkgdXNlZnVsIGZvciBrZXJuZWwNCj4gZGV2ZWxvcG1lbnQgYW5kIHJl
bGF1bmNoaW5nIFFFTVUgaXMgZXhwZWN0ZWQuDQoNClBlcnNvbmFsbHksIFFFTVUgZGVzZXJ2ZXMg
YSBiZXR0ZXIgc29sdXRpb24gdGhhbiByZWxhdW5jaGluZy4NCg0KDQpbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjQwNDAyMDE0NjQ3LjM3MzM4MzktMi1saXpoaWppYW5AZnVqaXRz
dS5jb20vDQo=

