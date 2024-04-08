Return-Path: <linux-kernel+bounces-134737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D0189B635
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48391F21ACB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D82D1877;
	Mon,  8 Apr 2024 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6LoPNcp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2025184D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545409; cv=fail; b=Qh16ESGszwoUojmpAkC4/yRwHKkcmtVX4Io2qNCHfvNWoq8WRJowsKmfHtjHpRaCJRGcyPPrr0yDG0dU1QgNTUhDMFw6rIR/TjCE4g3VOiqIlkv3xFqJ+kYgszAyhoWxYVorbAIyeKAtBhPVOdbCUQy8hNzX3GTaBgD4zYGUyNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545409; c=relaxed/simple;
	bh=aqGLkSWLQouPPtYRrPcohK0AWF6hISHq17oQgVTPgW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShKbXhl3yLsUScibMOx0zMZs+AmlAP+gbh/yEGfZPqWudKFxeZdY0wKJMz/+DeoCA61xUf+t7ixUhs9+SBKvnXdQ4EPwTd/7Ll2L7PCebCDJOpwtKyaM5YAQCVO3vyQKPcCEijRn5X/jk8Sw/R2lYIj3RJ129D0YOhzA8OQLzUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6LoPNcp; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712545408; x=1744081408;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aqGLkSWLQouPPtYRrPcohK0AWF6hISHq17oQgVTPgW0=;
  b=f6LoPNcp4rQSuHutY3uPat0lpRdJtQW9iaMtHmSexwVbbgJxyG8wAol0
   FXzxM534I4HylfhGaL33rr6M6XNKJUfdpbxvER0xGDjGc1tw7aBbXLsJ7
   7Wu7VwXGNw4hdLMPMu4hpCAvHHozXyZphIQRpKmKXaG0OkcNUBECeXpRM
   4kdotc/ZI8kDVH0GiNTvXyWBnGmVbrU6rTFcfRIYcvOM+UaypZC9kCIzt
   tQPFSFaw3nMTIXQseUgz6jEbSAydPLzF5Gj4YswpxJzzZ90IpylffG2JV
   7Vxo7gy92UiQglH0gCbT42YJm9rvUHRqSFMtCLr/joEVaYDpln7KYR/yK
   Q==;
X-CSE-ConnectionGUID: N4lsjswmThqV2B43zCLezg==
X-CSE-MsgGUID: rF9c0+fkRXudB/aj12Irvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="30298771"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="30298771"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:03:24 -0700
X-CSE-ConnectionGUID: Prf8dROPS/K4pJ3PS7BUGQ==
X-CSE-MsgGUID: AKu+oUNqSp+DKTX93ETLaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="50943200"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 20:03:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 20:03:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 20:03:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 20:03:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 20:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXGo0b3LqcRVPGJxIb+ZKJNZLy7ZvyQF+B8pX1DVoWCYhGNxliLHfywAJxvCfRVr7G0wggS3m5zbIiVTyb1VW2rzOoi8H668rFuXWHF7Mb3htLyYOZ5mJRtO6/0ZkmieJzg41oFHlHJt9t8VuGf4CnhvG6b5jdw5JHwYEn0+LhTw++YR8er1eZqUZn1L/NfpyJBhYyNUqRVnPuAEVe/Y0V2rs7c1G1HbVL2q3QjBASTT9YmDHrClsVlOQW1XRXOc3jAXRbFFKZsKBR6YtLB+M3/IVa1PgwxtqqkafxuUUY+Nx9xWabQLRKtJ4R3aFf10j5gMwh/lArD3qziIeX5eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqGLkSWLQouPPtYRrPcohK0AWF6hISHq17oQgVTPgW0=;
 b=X2bli8qIU1g09VjfnUwZ6TtgQriSH0DY5TMKprGXyOGFCcoVu+d1hDUNKsaplFPWxOmtJ8RjVO3FCeHcAE218fi8SNTGWbG6UpBAFQ10htnZJgEkei2AcRbwjmBr998h7tUr7o2SbMsbnC2tsevJeaWR5xq7IZmZKbhO1211QSI8c9COWDhDwrVEPisLhxem0+QtRDWoVptEHlYdmhP0k1mh/M4MY0vkEhsF7QA/EVVq9mRcM0BcM8YG+TEHSVSEx/89CnIqlOTDrlgFYSWXXezvWxZKruwqRWUWemJYnUrOK5jfy7PXThW62lgJ/GcLmrFgUjRs1EyAvrBcloEaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 03:03:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 03:03:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/12] Consolidate domain cache invalidation
Thread-Topic: [PATCH 00/12] Consolidate domain cache invalidation
Thread-Index: AQHaflqt4JqYpqo6n0++IRRqba3zUrFMzouAgA+vEoCAAUf3AA==
Date: Mon, 8 Apr 2024 03:03:19 +0000
Message-ID: <BN9PR11MB5276B476EC7C098E153ABF168C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276088E9D595A903E9255E48C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2256b869-d0c2-49b4-b6cc-89e59d40386f@linux.intel.com>
In-Reply-To: <2256b869-d0c2-49b4-b6cc-89e59d40386f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7497:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/gbQvCL+jUNCto5ic3fXbj8srxa+7fDV3MX/FpLKlKmweDOliAKPdHEOjEda62CETy4Ir8DhbYNKD6Q//6B6YWhHuZq4KF9NnTLjdLbMS9J9R557m+S734KnIbk98E8QZI1aCl798tRFuYEQantouBgtDh01pNMn4jhki47n3gBoQQfE54ejcx9TQlWaAS0hYT0+9HTXt4WsoXBiWbAVW4nSthhUX6H/vHI2Ip3WoW47XMjgGSZxxJJ7OIYshTW01ZojNVHZJARDyINw3AFqZPBmVZJyCkKXKDUsHqNxNVoW0jMXszcf6M3i7DIRHMpxjsC1J5uFv6ry1/FDir0Vu4iBylDbVeeeHeSCLKs1ng//Lp+hvpzkK6imb12RwypQsNIijZhABL1ZS6UpiImcWawWrf/8BImh6L32VkCS575XdFdOuAmLjfEJeapGogT8k2algIv1BPUQ2TVGkYMbTbi4mn0msf56R5SqGFfKpRztbKVupmrXSRescSmUZj6rk6GPDNVP/f5kunL3a6NmELiIs0Kp99HrmI1mAB5Yu8D7BScjjn4oQ/YdbBKRJheaMLXLw+9d+EU8aKZpWyPZddRAtHAzXX1BOuilFfE+VY5+rAYBLaRFFY+ELjsaswy+Z1n2M2ks5HkdvBrFvwT8RHvOERuWVNW4bkQi079H8c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVJLUGpvejBiTzcwN3hzMkU1UENIdmlDRG9rcnlSV1FSM2JLL29EVFZJN1Ar?=
 =?utf-8?B?Y3owK0hYRGZScVFOdUx1U0krSDhJUElQTmZuclcxeTFkTlgyZngxZnYvTjAx?=
 =?utf-8?B?azh0aXlBNFhXaTViaXFYZlUyNm5kd3lCUm5oUjNieHpTM0hmMTNrZ2pTc0hR?=
 =?utf-8?B?R2svSjJWcndtYmlyb2xYbndEVnJEOHBYR1BlNWkveStUQkV6eCtMaHdBKytJ?=
 =?utf-8?B?cTBuZ29XTVFZU2U4a1JmWWNxMWRmNWxhZDV4dldBa1p5bW5vVWMyd0lBYkNy?=
 =?utf-8?B?RHNKQjM2TWVVME5DeUphcjRBMm1HZW5sSlJ4YXljay9XYWMxY1ZZOXNacS9N?=
 =?utf-8?B?SmQ5UHJaZWYzUWg0QitHbWlGenpIL1NhaUVZR3huS2ZwTDl0NWhBZjNpMVN0?=
 =?utf-8?B?SmdJQnBWcnpSZkJkbGsxbkVjbWdLUXlQWXJWcU5Sbk1ZanJOWElVWXpaVmZO?=
 =?utf-8?B?bnVtRzRVUHlycnpzNXIvSzJBbE11QTgvUnBQZnhmTVBzblVXaXNQekIrb0pj?=
 =?utf-8?B?aFEyV1AzR2kwMDc5dHczbFZpZHhOblhOT3hSZGlyZDNQT0VJRXZLNGtKNVRN?=
 =?utf-8?B?SWROckdEb0pMeVpwWHN3N2o3MEpMVExVM2JybTdzbTFhbUtEUW55bXdJT2lm?=
 =?utf-8?B?NkUwd3BETzB4S1B3eldQd3JZUVBRZEUrazlvcm5PWTgyZkFxT2d6OVRRcEVI?=
 =?utf-8?B?cURMTU52OXJ6VTZHT0VHaDN1TEhYZ0NwVkczVTVva3NpWGNxcFl1Sk5UV3Zi?=
 =?utf-8?B?VmttZzIyOVVYbU4zbG9DVGN2ZnNLOFZhN1BINitJdUl3TW1INnpmcW1SNVVL?=
 =?utf-8?B?Y2F5MW94WHJ1NjdIQlVqeVByTjV5WVlXTTRjRHI3TmcyUXl2TVcrS3ZrVHJO?=
 =?utf-8?B?dk95Z0ljMllIRm5lc2dsdktVK0YwK1hvNjI1WWRGS0N0NWIzRkNwckp0VGEy?=
 =?utf-8?B?TGlsMWRRZEZZS040T25qeUZuZVJZdGh1d2VTeUNEOHpyNWE0ekw5bWtOWkYw?=
 =?utf-8?B?eS85YlpVTk9FN2paYnpTaHBTak8rQlEyVzNWTnM4YjhtTFpoQW9UaWtjbkUw?=
 =?utf-8?B?MFVyOE8yWUJmQ2tXdVc0WGoyUDl0VGpFWE02Z1JSVGM1VzYwRkxzZHFES1p4?=
 =?utf-8?B?ZXlvRmlKdWZDK1pKWGRmN0xmSmVTMzdsYVBHemQrSGtHYXRtNXhVbXd4a05M?=
 =?utf-8?B?RFdmc1ZqWk5ycEVtRTMreDYzTG5veFdleDk5d1A2VlgzVVk1OG5TUHNXNThz?=
 =?utf-8?B?MWxBOVZlRzJUdGd2ZHBmaXJwbHdFSVphYXFZamFxd2pBMUVxRFhDMEtLeTlm?=
 =?utf-8?B?MmRaUUhTQkh3MlFrZThoWkN3SFlRUXZFeG5DVHRWby9RL3VkbUhhZmdaRnhT?=
 =?utf-8?B?UHZ4ck50ZlErdFVBRWZZdnJQQlhBUWxJanpjd3VHa3VrckYzdmdIeHJheWFJ?=
 =?utf-8?B?VmhIempNeFFvUVg5RnJRVDkrZTFqR1lrWWtVTmlLbGt3ZU1ZN0xETU9pcmU3?=
 =?utf-8?B?NkpjeG5NMldDMmszQ2NBRXk2NStpNFRaclU1M0s0RDFNVFRmZXV2V1NLSkxl?=
 =?utf-8?B?UXhiK3BqYTc2U2NiajhaMmtCbnMvTFdUc0JHekZ5RDJRTFNaWEY0aUdpbGVp?=
 =?utf-8?B?Ymh0Y1hKTnE1TUMxdmUyeTB2NFRIdVEwTFJpOUdJcUVOdy91dHU0anpCMjhQ?=
 =?utf-8?B?VzNzc0NJMUwvbTIva0tQUG4rdkNOb0tGWS9SdkhyckdaaDhHV2libmdnZ3Vk?=
 =?utf-8?B?NzV5bzRJMHVtVHZsRyt5Z255YS9vN3hlTmpFelNSbjUrV2NndFNpM2JmbUZV?=
 =?utf-8?B?RzliMVJPRUVkTmxtcTNiQUxXTXliZlBWeXpIajg1ZUJyUTQ1STZoL2w1VmFi?=
 =?utf-8?B?S0xaOXczczE0d1JvS3c1RlB2dVA0aWlQSktRYk5EdVNYTU1JZG5YV3o2TEFX?=
 =?utf-8?B?Tm1JVDgzMGlqdWlBUkJpTlN2blZKVHBrYlRtblZzbi9vL2pQUDJEWGFYRzhi?=
 =?utf-8?B?WXN6RHZHaEpkUlQyeTN6VlBaKzltZjJQclp5YzRiUFphbHZaOG5HRnlBc0pE?=
 =?utf-8?B?aTV2MUJFbXoxQmU3VWk5K0ExRFI3eTJNUmJJSmdRZUdpa05mMUxmM1B0U0Y1?=
 =?utf-8?Q?YZ92dwz86fgHw9EdjpJvvm9mT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3038c2be-cc56-46ba-5d6a-08dc577871d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 03:03:19.6927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onC1ivAAyQPun/G31ge9HC+t5XgPF8QwECKhY/DiyFli6LmLtllUg9qXhMbNyuMJAkQZOkk2Lcxefzw2zTg8Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEFwcmlsIDcsIDIwMjQgMzoyOCBQTQ0KPiANCj4gT24gMy8yOC8yNCAzOjU5IFBNLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHU8YmFvbHUubHVAbGludXguaW50ZWwu
Y29tPg0KPiA+PiBTZW50OiBNb25kYXksIE1hcmNoIDI1LCAyMDI0IDEwOjE3IEFNDQo+ID4+DQo+
ID4+IFRoZSBJT01NVSBoYXJkd2FyZSBjYWNoZSBuZWVkcyB0byBiZSBpbnZhbGlkYXRlZCB3aGVu
ZXZlciB0aGUNCj4gPj4gbWFwcGluZ3MNCj4gPj4gaW4gdGhlIGRvbWFpbiBhcmUgY2hhbmdlZC4g
Q3VycmVudGx5LCBkb21haW4gY2FjaGUgaW52YWxpZGF0aW9uIGlzDQo+ID4+IHNjYXR0ZXJlZCBh
Y3Jvc3MgZGlmZmVyZW50IHBsYWNlcywgY2F1c2luZyBzZXZlcmFsIGlzc3VlczoNCj4gPj4NCj4g
Pj4gLSBJT01NVSBJT1RMQiBJbnZhbGlkYXRpb246IFRoaXMgaXMgZG9uZSBieSBpdGVyYXRpbmcg
dGhyb3VnaCB0aGUgZG9tYWluDQo+ID4+ICAgIElEcyBvZiBlYWNoIGRvbWFpbiB1c2luZyB0aGUg
Zm9sbG93aW5nIGNvZGU6DQo+ID4+DQo+ID4+ICAgICAgICAgIHhhX2Zvcl9lYWNoKCZkbWFyX2Rv
bWFpbi0+aW9tbXVfYXJyYXksIGksIGluZm8pDQo+ID4+ICAgICAgICAgICAgICAgICAgaW9tbXVf
Zmx1c2hfaW90bGJfcHNpKGluZm8tPmlvbW11LCBkbWFyX2RvbWFpbiwNCj4gPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhcnRfcGZuLCBucnBhZ2VzLA0KPiA+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2VtcHR5KCZnYXRoZXIt
PmZyZWVsaXN0KSwgMCk7DQo+ID4+DQo+ID4+ICAgIFRoaXMgY29kZSBjb3VsZCB0aGVvcmV0aWNh
bGx5IGNhdXNlIGEgdXNlLWFmdGVyLWZyZWUgcHJvYmxlbSBiZWNhdXNlDQo+ID4+ICAgIHRoZXJl
J3Mgbm8gbG9jayB0byBwcm90ZWN0IHRoZSAiaW5mbyIgcG9pbnRlciB3aXRoaW4gdGhlIGxvb3Au
DQo+ID4+DQo+ID4+IC0gSW5jb25zaXN0ZW50IEludmFsaWRhdGlvbiBNZXRob2RzOiBEaWZmZXJl
bnQgZG9tYWluIHR5cGVzIGltcGxlbWVudA0KPiA+PiAgICB0aGVpciBvd24gY2FjaGUgaW52YWxp
ZGF0aW9uIG1ldGhvZHMsIG1ha2luZyB0aGUgY29kZSBkaWZmaWN1bHQgdG8NCj4gPj4gICAgbWFp
bnRhaW4uIEZvciBleGFtcGxlLCB0aGUgRE1BIGRvbWFpbiwgU1ZBIGRvbWFpbiwgYW5kIG5lc3Rl
ZA0KPiBkb21haW4NCj4gPj4gICAgaGF2ZSBzaW1pbGFyIGNhY2hlIGludmFsaWRhdGlvbiBjb2Rl
IHNjYXR0ZXJlZCBhY3Jvc3MgZGlmZmVyZW50IGZpbGVzLg0KPiA+Pg0KPiA+PiAtIFNWQSBEb21h
aW4gSW5jb25zaXN0ZW5jeTogVGhlIFNWQSBkb21haW4gaW1wbGVtZW50YXRpb24gdXNlcyBhDQo+
ID4+ICAgIGNvbXBsZXRlbHkgZGlmZmVyZW50IGRhdGEgc3RydWN0dXJlIHRvIHRyYWNrIGF0dGFj
aGVkIGRldmljZXMgY29tcGFyZWQNCj4gPj4gICAgdG8gb3RoZXIgZG9tYWlucy4gVGhpcyBjcmVh
dGVzIHVubmVjZXNzYXJ5IGRpZmZlcmVuY2VzIGFuZCwgZXZlbg0KPiA+PiAgICB3b3JzZSwgbGVh
ZHMgdG8gZHVwbGljYXRlIElPVExCIGludmFsaWRhdGlvbiB3aGVuIGFuIFNWQSBkb21haW4gaXMN
Cj4gPj4gICAgYXR0YWNoZWQgdG8gZGV2aWNlcyBiZWxvbmdpbmcgdG8gZGlmZmVyZW50IElPTU1V
IGRvbWFpbnMuDQo+ID4gY2FuIHlvdSBlbGFib3JhdGUgaG93IGR1cGxpY2F0ZWQgaW52YWxpZGF0
aW9ucyBhcmUgY2F1c2VkPw0KPiANCj4gWWVzLCBzdXJlLg0KPiANCj4gQ3VycmVudCBJbnRlbCBT
VkEgaW1wbGVtZW50YXRpb24ga2VlcHMgdGhlIGJvbmQgYmV0d2VlbiBtbSBhbmQgYSBQQVNJRA0K
PiBvZiBhIGRldmljZSBpbiBhIGxpc3Qgb2YgaW50ZWxfc3ZtX2Rldi4gSW4gdGhlIG1tIG5vdGlm
aWVyIGNhbGxiYWNrLCBpdA0KPiBpdGVyYXRlcyBhbGwgaW50ZWxfc3ZhbV9kZXYgaW4gdGhlIGxp
c3QgYW5kIGludmFsaWRhdGVzIHRoZSBJT1RMQiBhbmQNCj4gZGV2aWNlIFRMQiBzZXF1ZW50aWFs
bHkuDQo+IA0KPiBJZiBtdWx0aXBsZSBkZXZpY2VzIGJlbG9uZyB0byBhIHNpbmdsZSBJT01NVSwg
dGhlIElPVExCIHdpbGwgYmUgZmx1c2hlZA0KPiBtdWx0aXBsZSB0aW1lcy4gSG93ZXZlciwgc2lu
Y2UgdGhlc2UgZGV2aWNlcyBzaGFyZSB0aGUgc2FtZSBkb21haW4gSUQNCj4gYW5kIFBBU0lELCBh
IHNpbmdsZSBJT1RMQiBjYWNoZSBpbnZhbGlkYXRpb24gaXMgc3VmZmljaWVudC4gVGhlDQo+IGFk
ZGl0aW9uYWwgZmx1c2hlcyBhcmUgcmVkdW5kYW50IGFuZCBuZWdhdGl2ZWx5IGltcGFjdCBwZXJm
b3JtYW5jZS4NCj4gDQoNCnllcyBpdCdzIHJlZHVuZGFudC4gQnV0IHdoYXQgZG9lcyAiZGV2aWNl
cyBiZWxvbmdpbmcgdG8gZGlmZmVyZW50DQpJT01NVSBkb21haW5zIiBpbiB0aGUgb3JpZ2luYWwg
Y29udGV4dCB0cnkgdG8gY29udmV5PyBGcm9tIGFib3ZlDQpleHBsYW5hdGlvbiBpdCBzb3VuZHMg
aXJyZWxldmFudC4uLg0K

