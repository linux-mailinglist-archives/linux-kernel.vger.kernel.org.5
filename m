Return-Path: <linux-kernel+bounces-135111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E1189BB4C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85281C20361
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3AD3C47D;
	Mon,  8 Apr 2024 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mj+POLxq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F03B799
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567537; cv=fail; b=H6TRj+c62AW8OuPh11MjG9zaR0yIZnlZFq3dY170XydYUXDdJC2dBib23Fxmtyzbvp/jZbmasLEEWKj4S0kyPW694CVyMXjArR9gMygsuThBHolCCktgWkgqaX1WPsynpn5owMAKeacwlDfDwGRROmbjpjaxRliSQLJPiYP4rkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567537; c=relaxed/simple;
	bh=a3M+3H1BbLxvizHbPt/dIpvYycDW6g2LsqzHpTLk6Mk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NAY816ziWxplSF/FZIBShg4VGOxByRvYTPQi/Kn9baSpSstLoBtQDzFzfuWCL3ewU5bBv9IkjMAfZEBgOEsVtWddw8mjst8vyviMBk7MVGGicbTYGrMWZFz5EcIuHz2K1m6IO7UFKSahUFKtrbMPS2coqxIaWxjU/+D+TSNs6r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mj+POLxq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712567537; x=1744103537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a3M+3H1BbLxvizHbPt/dIpvYycDW6g2LsqzHpTLk6Mk=;
  b=mj+POLxqhEsMgerSpL0fVdAP582AQhs27v6CLqkH7AtbF5ynvMpYloVH
   UNMqiN5abK/zrpJG6qWo50lVUz92Dq99pf8xQoWIaV2GpCyL17tSx4rEX
   rvZaCY9sQZcqE6ljRhAX0h5QvjVvnte1CBG4Bm7Rg7db8Rxf8VAKfX7HG
   vhHw4OI0e8N7qKAwg1T6OpxsDiQ9/kXkqSyZNlDuojPzW/0sQ1hGf+H4U
   iKP78iSGZbuJKVyNxGfSwdFYs1K75+feMNjTNF8oBFVoJx2Z3KM2Sgm9t
   q5qPhKDEhvxGcgoJ8i65fl00yAYsU7QQsKDYs7rm/qzQGDrCXmUCEfK70
   Q==;
X-CSE-ConnectionGUID: nduJ6NJURIiHLbzgkHIJZw==
X-CSE-MsgGUID: luimVjLqRNqLBcMN5Mmezw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7700593"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7700593"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 02:12:15 -0700
X-CSE-ConnectionGUID: T2/siBYxSsaIRUsv00izNQ==
X-CSE-MsgGUID: /OVQS2j2QzyTllp0Qpbh6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="20391278"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 02:12:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 02:12:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 02:12:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 02:12:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 02:12:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDAeEDEtkjFQn3IlNajyinpqtrwcDfmSW5Go7K07TuMbIN4r+SdaskSKhTY9Wa6t2yObK86UL51uMTvZhV7HshqD0mJ8CejyWMNNHRORe4GO16BTH1HFw0XWRIM0pzoFs5D8ugU2qXfibS63TPBZj6lP7T0CCRGOCOf1H3sCQ1lilf0xt9Ezcb9zyJuSV2ycV0Nj3pDzs8Va0+cu7yWPIJY56e+VjedJBRVbbPxh5wEE6SfsGo6AN81r/XIZHitCXC9BwRoHi+qhWmPy3NMOYrTF0Bi083TqoUP7hoGDbFd4nb8dkwKMuWbxuZu8zHDt8C874SrZ06hrxJ8MErhpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3M+3H1BbLxvizHbPt/dIpvYycDW6g2LsqzHpTLk6Mk=;
 b=d0th5HwMLiLwOgyi98jwZ/GWm4GJZ6N1KtRCpwqNDFHRrTtuChOpUfQocC6m4WlJ2Q8zyqVQjByd9310Su4sthcGRULEWhG9WiBM4FFNVYqgoFPWzNoaPzxKEj2QpwXUBR9t4w8762kn9NYNDwDn/4Go+7FuIm4IznK8pAqlsjDW80tUHWBLv46QpEifSkCXnt0IG6aO5zqJX9KsuOg8UShqxTmlS8ZD9I31YCSl2WR5vLONkHj1cdVMZ8td4bRFsFJ/v8T8pKvVz9D7AHsfQDrg7nyIp1gMfBqCbFjgy/AkN593iDcm3PJloN918FoAhnnqvPTdbB5LJLQ6GDii2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 09:12:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 09:12:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<helgaas@kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
Thread-Index: AQHaiIkfDCiYXSWkLUGWnjJZsYe/DLFdt7FQgABARYCAAB6p0A==
Date: Mon, 8 Apr 2024 09:12:11 +0000
Message-ID: <BN9PR11MB5276B1AC2C1342F3B78D98C98C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407011429.136282-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52760913F36DACBC612088668C002@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fafddce6-155b-4a50-b63e-46005364181e@linux.intel.com>
In-Reply-To: <fafddce6-155b-4a50-b63e-46005364181e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PR11MB8760:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+nx8CQ0EehalgnRvnTIavppn+uQlPhdFc9yLvV/usNe5cUKvUf8hOPPnaoVjQkLZaJB2k7IX0CoYtDWyA5lo1WXAGcDOjhi6PohVt5tP2f54k5EZgc+zmxigOHEsFHSwG/r01r3zKByXncja8ztiJi2ThObKbx9XPaoH9hszbrk26tGe9VWoEqovZR12rPRv5R/VlJmGQ5/AY/3VDTi/VLQrDeidsdiVVhC+Fern/EvlcaqKCe5/+TW6F+Ov2e2c/9X3zI/ad0YmWvyrEuBOXy0ThoJ/b6aU4shnWID4VYJAVZ3lBCd5OjC37+1c0ozDY1qinvro8Jli88wVrqdtG39mQjXgZhYqtDsgMHP3Wg4UZPAqtwDqOUU4b+c245puNJ00GUGyCMekFEBQO3uWlvRr64DDHu8f6NBh0wtdlzyo74l9Jb5DBxUs3ZbPRp1WpL1Vs0q5VN1gvMy3bkALmJZVoJIdlYIa/LdsG0ad6HRAyappc6raRQTqW8mP80cjO4zVwuOOFRgR+t8OebM3edaCWrudjvfUodxmkCLjMI28NQ0oK2XduVC0jGgQBh42sKZ0xhmGUyZ/gyTD0nmO4HbyfJRiDyYhkBcfL5UNU+q+x/IEZ6pn++B2jxqF4qqmKWvxlgwCKp0PM8+7Bv6I1LpnAnpbtQF0e2uRWfMxtY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGd0eTZhbVpKVm9PRTZmRDgvV3k5VE01dVErdTcwWkJWeW80UzRHVEE4Rmdt?=
 =?utf-8?B?MWQ3S2dIb3U0aldveXd4OW5zK09admdaa3ZrbVppbzJrV0JFTWhuaTFCbGVJ?=
 =?utf-8?B?eEpzeE9mUVBMZ3lKbmJBbUpqa1I1anptcURkbjJFZ0cxazh0ZWNwV2hrRmd0?=
 =?utf-8?B?aFNNWmROZDFXc2hyVXE4QmpwNzl1aFE4WG5EZGt5b0tNQWc5VVRTT3hQcDZC?=
 =?utf-8?B?aUEra0lUbDMwOVRTTUhlVnc4KzlKWm0yRE5aQlpsV3gwWXNpaC9YemxrRGtI?=
 =?utf-8?B?dWlaalFmTWJua0orbUhBNkE0bGh2YldJTWRRK1ZBdlFTR0x4M0o4bVdLdFky?=
 =?utf-8?B?UmZlUHd6c1pQVFZ0STZXSzlrNXJLTUl3QS84NjhSeVRuRDk0dklJTEdFdVlQ?=
 =?utf-8?B?QzZSd3VSWXRVTEFBZ29DU2VxbnJtRWFEWjdod2E2UlJWMzhOM1E4Q0RPK050?=
 =?utf-8?B?d01RaWVQY0Y1b0NwbUh5L09kVnA1QUZqcDl5TWNtd0JVQVRRckhDdWJSN0tX?=
 =?utf-8?B?WU1aM2QxZkFub3ZvcUlzVjhJNjNlSWZ6VHZOdUZaYlRPeWFKb2ZhS28rSkpl?=
 =?utf-8?B?dFdsRG9YUlBvU1IvbHJxMUYxbHJlWUpaemJlZlFwd2J6S3lRdEQvaEJ1UlFJ?=
 =?utf-8?B?TnRmZzl6OVNnNkFTbDdYMjh1bXNKNW0xWWtJTFBzVTdqajYrUWZ3SHU1eEsw?=
 =?utf-8?B?dGovcGpSOUZlbTBEbEovNDBzQy9tUm1aY05CWWR6YWZ3UXJJWS95UEhUQklo?=
 =?utf-8?B?OUNTTk1EbVgvUFNFUGI4YkZseHBhTEdEbVBGNEpMOFBVeUdaTlRiSHA3RUd1?=
 =?utf-8?B?cU9aRFQ3WHBaN3p0RjdlTURmWGxZUC9QSTlKLytINlBhMUxWYkhnWmdCUlk5?=
 =?utf-8?B?Skx6dmNxK1AxcGNaOWhoSUZGck1NTzc3WExxNjVlb25QdVRaUDU5L1puYmpj?=
 =?utf-8?B?eFc3M1JhbktueWEySkhFd3BBczBNWThFOCtQeWVvQjNXTTZhUkxwNWRFcElh?=
 =?utf-8?B?angxeE9NMVVOVWh4ejZVR0x0SHRGRVFIbGJ5QWk4QWFYWmxmbEhIRk9TWlJa?=
 =?utf-8?B?cGtZQllmQ1VZUER2UGVSc1o4amF4WG1od1VaUG02WGJyN01aTWxEbVZrZ3pQ?=
 =?utf-8?B?dFpoYnp5VWJUNWxCcStsaWNpL3pQeEx6ekdQQ3g5MVpteXhkVW80N1dDdGpG?=
 =?utf-8?B?Y2RUYUpqR1dmTWhvaU50VUZjTnBxWVFoMVAvZGtxWVNsaDZycnBxc21wWWJ5?=
 =?utf-8?B?MU52MmV5Q3lyT3ZEbHlIWnFiUS9hRVQyRElZV0c4Q2V2N09SVmV3WFRhVkIr?=
 =?utf-8?B?VHk2MWttSG95T3IxZ2dWM0NnZGw0Yk8vY2I0L3RQQkpqRVArTzB0ZXFtZW10?=
 =?utf-8?B?dGVNT1Z3eVhxak45MzZUUDJ5RlZMNTV1TFA4dVIzd3B4Z1pIQTRxOXpZWUxK?=
 =?utf-8?B?bjF6VjBTNFV4VzFlTXFUbkNsK1VqMFBPbE1aSTJFWVdLV3A1Mmp3eG9UNkdF?=
 =?utf-8?B?RXluRzZWVm40bXZFQTBremdJVW9zakdVbG1KOUhiMFlNU1VnV3NqbEpyMFgx?=
 =?utf-8?B?akdLQ295K3RtNDhyTURYUHY0bHpTZGtsUUQyRG1SQWRxaU1MMW1ZVjlSd3lE?=
 =?utf-8?B?L3RPdnBrWXZya3BsRWVESktzSytFQ0xTN092Vk01TVYwdWdtU0Y1RGhacUMx?=
 =?utf-8?B?MEEyQ3o0UzhGeXlmODFvRldJOVV2Mi9sNHBzOEwvNCs4UUIxWU93dXc0elZK?=
 =?utf-8?B?U2xiVW4yQ2FWcnBmd1FTS3p6MGtZRWtPZ3g3b2hpeUZLRy9TTFVoZktrTFpW?=
 =?utf-8?B?SE8yQkd4aCtuUUZJYXdlME1qMGZqWnh4d015elhkclcvU3NJUmNnbHZkMjNR?=
 =?utf-8?B?QjVHU1dmc3dNNU9RVFl6eW9jTEU3YTNLdmNKUFhITUZBSTdtZEdLSE5lalMr?=
 =?utf-8?B?MmhkM1gyTnNhd3JTdm81cTV0dTZqUHI2Uk16SzloTVBwSC80VnJ4cDZ6RGlr?=
 =?utf-8?B?RXJ4UnhYbG9ObkV1VUtFRi9OM0V0SEFZVjZhRFd6UDRUVUhpZFRxcW9OWU85?=
 =?utf-8?B?bWVTWmVxMllRbm1MYzFUc1F5V1NyVzYrR2xsMFk3WW5VMjZZbDdSYlBCZnhB?=
 =?utf-8?Q?hp/Yhh5HvYLZ3hZZw9N70GGl2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bb2478-6b79-492a-b4ef-08dc57abf973
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 09:12:11.5620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+oap75YI46ix19eAAxzWImxnu4jgnCu+hT7c5NxijHPItW9ngwKwzxLX9MAW+ntxAYdSNg/RosLkb5y9v3I4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
X-OriginatorOrg: intel.com

K0Jqb3JuDQoNCj4gRnJvbTogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4g
U2VudDogTW9uZGF5LCBBcHJpbCA4LCAyMDI0IDM6MTUgUE0NCj4gDQo+IE9uIDIwMjQvNC84IDEx
OjUyLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHU8YmFvbHUubHVAbGlu
dXguaW50ZWwuY29tPg0KPiA+PiBTZW50OiBTdW5kYXksIEFwcmlsIDcsIDIwMjQgOToxNCBBTQ0K
PiA+Pg0KPiA+PiBDb21taXQgMWE3NWNjNzEwYjk1ICgiaW9tbXUvdnQtZDogVXNlIHJidHJlZSB0
byB0cmFjayBpb21tdSBwcm9iZWQNCj4gPj4gZGV2aWNlcyIpIGFkZHMgYWxsIGRldmljZXMgcHJv
YmVkIGJ5IHRoZSBpb21tdSBkcml2ZXIgaW4gYSByYnRyZWUNCj4gPj4gaW5kZXhlZCBieSB0aGUg
c291cmNlIElEIG9mIGVhY2ggZGV2aWNlLiBJdCBhc3N1bWVzIHRoYXQgZWFjaCBkZXZpY2UNCj4g
Pj4gaGFzIGEgdW5pcXVlIHNvdXJjZSBJRC4gVGhpcyBhc3N1bXB0aW9uIGlzIGluY29ycmVjdCBh
bmQgdGhlIFZULWQNCj4gPj4gc3BlYyBkb2Vzbid0IHN0YXRlIHRoaXMgcmVxdWlyZW1lbnQgZWl0
aGVyLg0KPiA+Pg0KPiA+PiBUaGUgcmVhc29uIGZvciB1c2luZyBhIHJidHJlZSB0byB0cmFjayBk
ZXZpY2VzIGlzIHRvIGxvb2sgdXAgdGhlIGRldmljZQ0KPiA+PiB3aXRoIFBDSSBidXMgYW5kIGRl
dmZ1bmMgaW4gdGhlIHBhdGhzIG9mIGhhbmRsaW5nIEFUUyBpbnZhbGlkYXRpb24gdGltZQ0KPiA+
PiBvdXQgZXJyb3IgYW5kIHRoZSBQUkkgSS9PIHBhZ2UgZmF1bHRzLiBCb3RoIGFyZSBQQ0kgQVRT
IGZlYXR1cmUgcmVsYXRlZC4NCj4gPj4NCj4gPj4gT25seSB0cmFjayB0aGUgZGV2aWNlcyB0aGF0
IGhhdmUgUENJIEFUUyBjYXBhYmlsaXRpZXMgaW4gdGhlIHJidHJlZSB0bw0KPiA+PiBhdm9pZCB1
bm5lY2Vzc2FyeSBXQVJOX09OIGluIHRoZSBpb21tdSBwcm9iZSBwYXRoLiBPdGhlcndpc2UsIG9u
DQo+IHNvbWUNCj4gPj4gcGxhdGZvcm1zIGJlbG93IGtlcm5lbCBzcGxhdCB3aWxsIGJlIGRpc3Bs
YXllZCBhbmQgdGhlIGlvbW11IHByb2JlDQo+IHJlc3VsdHMNCj4gPj4gaW4gZmFpbHVyZS4NCj4g
PiBKdXN0IGJlIGN1cmlvdXMuIFdoYXQgYWJvdXQgdHdvIEFUUyBjYXBhYmxlIGRldmljZXMgcHV0
dGluZyBiZWhpbmQNCj4gPiBhIFBDSS10by1QQ0llIGJyaWRnZT8NCj4gDQo+IEkgZG9uJ3QgdGhp
bmsgQVRTIGNhcGFibGUgZGV2aWNlIHB1dHRpbmcgYmVoaW5kIGEgUENJLXRvLVBDSWUgYnJpZGdl
IGlzDQo+IGEgcmlnaHQgY29uZmlndXJhdGlvbiBmb3IgdGhlIEFUUyBzZXJ2aWNlLiBUaGUgUENJ
ZSBzcGVjIHJlcXVpcmVzIHRoaXMNCj4gaW4gc2VjdGlvbiAxMC4xLjEsIHRoYXQNCj4gDQo+ICIN
Cj4gQVRTIHJlcXVpcmVzIHRoZSBmb2xsb3dpbmc6DQo+IC0gQVRTIGNhcGFibGUgY29tcG9uZW50
cyBtdXN0IGludGVyb3BlcmF0ZSB3aXRoIFtQQ0llLTEuMV0gY29tcGxpYW50DQo+ICAgIGNvbXBv
bmVudHMuDQo+IC4uLg0KPiAiDQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgUENJLXRv
LVBDSWUgYnJpZGdlIGlzIG5vdCBhIFBDSWUgY29tcGxpYW50DQo+IGRldmljZS4NCj4gDQoNCndo
YXQgaXMgdGhlIHBjaSBjb3JlIHBvbGljeSBvbiBzdWNoIGRldmljZT8gcGNpX2VuYWJsZV9hdHMo
KSBkb2Vzbid0DQpwcmV2ZW50IHN1Y2ggZGV2aWNlIGFuZCBJIHNhdyB2YXJpb3VzIHBsYWNlcyBp
biBwY2kgY29yZSBkbyBoYW5kbGUNCnRoZSBQQ0lfRVhQX1RZUEVfUENJRV9CUklER0UgdHlwZS4u
Lg0K

