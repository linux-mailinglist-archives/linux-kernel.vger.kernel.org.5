Return-Path: <linux-kernel+bounces-135093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F55F89BB12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829191C21B00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E03B298;
	Mon,  8 Apr 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JTrXtsKl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D83A1D3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566811; cv=fail; b=s1ZIUIJ+oQvAfk5sq/6qVEmqQ8TPgOUYbxmXsMwyeqX0cImL5GrkdyxjXJuPBqyeK+nJbd3HkkrQAc1G6TTx3zyJh9rGtJVf/QiMeKUxBhUs8KIw5P3nEHRYCunIYHgwzanpxt85MifraNQmVAj8GVG7V1lz+/2LrlRE01CKwrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566811; c=relaxed/simple;
	bh=uRp9fdAISYMx0zD0Kq9vRyDt+Wsxa0SPF//tiI+5mbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N2oGE1ll3sZJBpUe2qQDEfvkxI2ZqwTQuUbrPAka9YxnaHnZ3cWVLgp/eK1XD+ctZU49w0CC469cj4fi8uVvVu5zWmCLrh7gcSdIjscTgiyX+JshmKfJMw/FxSxMhTflnkl+dFplvAR37OShgxFSo9C7n822/586TV/sqOaNSBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JTrXtsKl; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712566809; x=1744102809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uRp9fdAISYMx0zD0Kq9vRyDt+Wsxa0SPF//tiI+5mbI=;
  b=JTrXtsKlArx5kuNlluT9oP/c6mBZCAPsLOwOmciFfIb3rXqrK9S/Otc8
   1IIj3YexDAc6qECBLMOUjtQ81GL3bg80DHrtkD8d0EyvrpemgP4uMLnGu
   VXK4dkJSkedWRtA4COY9mExten0bZYZZhLHaptWXHmEAfPo546e12vMq0
   2PWSZ0i9NUnU9z3+WSv8RfqubCDusKYv08/cnAsy9wi2VzTK+tyuMDatq
   PaaGlNq58p2X8shZ5ZXvjzN+rahYW9HYo9FEqo0P7wtsdYAsjv3llmqc5
   1ZycyxyAdSefIG1O3uk2esMOHkG61sUiQF4yLHH1iyrZorTuSz9enn4ge
   g==;
X-CSE-ConnectionGUID: BHtLgByvR2SGl8nZoNmSCw==
X-CSE-MsgGUID: HQxBy2uBSSisPv4fdPGPmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="11625390"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="11625390"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 02:00:08 -0700
X-CSE-ConnectionGUID: RidDxI7XTiCkhK33itUJ+g==
X-CSE-MsgGUID: 689rq2TETpKfRD50Opo7kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19857897"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 02:00:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 02:00:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 02:00:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 02:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeT3S7+O3OgSuWR6ASnYHbrje+eA1j42z1PF7YeA2ZfgjIEO9ymcx9Ok8Ki1LMWSc2NJ2j1t9kIGhWuNFbJhPrrYTh4MVNv8vxRSMEISUnBLH7nf51hZbEm3iL3Gbz8j8KeDGOMSQ5GRiEs19zW98xokzwFGedbyvx6RVwzc9ihFdaYezZtHsvVT3Adn/HPzBa+hh6zhJne4irYrK2DXJ90qISauMLIf4vOMWZV3sgv49d9ISwtkvBvPhSCdwaQ3L/SAdYkbKDfiEvGqORxuYbayE6pbnBqeX7XkKttb/+Brgw1+72soYBUpopmIBafn8hyNfB40lpz1IRG+g9GchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRp9fdAISYMx0zD0Kq9vRyDt+Wsxa0SPF//tiI+5mbI=;
 b=Vw5zhgkVcyA7e66p9MoZ18G2qYFV3VZzlwmUvORo0tVzabX19Lvl2+Ov1y1hmLqYKfMgzt+bdjuiTyNQ2lAsrm//AxfywXZoJBaMIh82wXTmfMMf8A/X0/hc5yUrwPzv8jBLYUOfKDRzx+biA9dsSUC2v7hT4LhuziamroT3qxowV+vHp+N3GQZPHcZxz7IPg47/vYBu3SR92na6LwkbwWJlg06v2qopDNaIz8TZfYsGkvOcDE+pozcBIFWd3FfSWHaAx3MHZWbB6r4pRFknrLqAr3iOlA4GdBHN2nQkuE4tTdE3H4Wx71W6j62Ehynqb8AVXP62q8sui8AC5JO86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 09:00:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 09:00:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, YueHaibing <yuehaibing@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steve Wahl
	<steve.wahl@hpe.com>, "Anderson, Russ" <russ.anderson@hpe.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
Thread-Topic: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
Thread-Index: AQHae9GlBWpgQbFT6kOw3+M6DonKQrFeC4YAgAAHtgCAABq18A==
Date: Mon, 8 Apr 2024 09:00:05 +0000
Message-ID: <BN9PR11MB527627689CCBBFEAFC6745568C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <Zfydpp2Hm+as16TY@hpe.com>
 <BN9PR11MB52765241E3261B58BE93E8A88C002@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ec0ff625-855c-4dba-b19f-db050671fbfb@linux.intel.com>
In-Reply-To: <ec0ff625-855c-4dba-b19f-db050671fbfb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7300:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GaYoc5quNybxUOmRSRkN1D2vy8gcAARRyLheXUY4cvoweS0FfnUIcJLn/mdS0SWbSclOMtkMzMn1ISzVzyZ0NR3YQBPUy4qv9Xo3Ol1t04Usc+qzfrv7PpH+18UzjoA87HANwkjfwF0wm0uGjrbBeUwXdnSbwUWocGd8/h/FYqD9l3Iwa0Y1tRriW2AXHuOfmpaxXUAbkn+eEZVZO/o1wElEVdhUGLXfop6vuCskKwLmZibguWed0nR5O5wQgLx7Qma/T6J4ulkQnQP264WKL0Bf/3FQ0xjrU0dFlmoA525uulkWQYzgms8q0DjPvudnd4tNJ9WbL4uSeTbcyHaVF4o+fX8XAUvhFfbrKttoHP3xvyWPkvXSSCSYL+AsXv1cQD8sl3vsaGVEfSaG1ULpNaVvIwcmn+rjhmNoFkOwomoMFrntxGlH15OD0qJSVgoFUU+u6Xe8aJqNuFbKZkTtfZliDnXBXST8KRUlsnQ7jmavx1Hhdx98IcfqJoPC13gb/TRllAQcERqmEoJA/Tc/e/nEUE+aZeGtuZiCyea0Dgt+J2v6jzHsiIaeBI3w2lr7pdjmyR7NDmxkUtQCrDgKj5wHBQtUjw/bMRmOEXT7pAQUc32QZBvAH/epEYWMBd5UfiBUPF2uQYDYJQT5E89hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0VaT09GQVNsVXRTQnNiNzN1RDlqR0pERUMxYllueUkyMStBSXVWNlZoR0tn?=
 =?utf-8?B?QXhiVTRzbTBtZzRqWmdQaEhCbG5jM29MeUtEdkQ2US9CRU9adTR6UFlIR29s?=
 =?utf-8?B?anRtWVpxRTJja05lem9EaWZFTnA4MnJFNTYzUWlkTU1qaHg1M0VKeXV6aE5H?=
 =?utf-8?B?RlRBZjVPbUNsSUdSdk9jOFZBc2Y1Q0cyeTduejFCNjZkaUFiSnA5a3NLYmpR?=
 =?utf-8?B?NklCbGVoUzRhMVFueVZRN1Z0aitESnB5Mm1Iam41ZSsyR2kzZHllL2pFRzZE?=
 =?utf-8?B?anV3TW92SmpSSFRNRVdNTENldWI5OUNLR1kzamtoeXdrSkpETzE5VndEZElt?=
 =?utf-8?B?NXRGcUlzakoxcUZSWnQwaHJJWEVMUmx2bklrSW5sN2hCTDNRT0pFQ09HNFM5?=
 =?utf-8?B?QzFKYzJCc3UyRkVoSkZQZnFFenJOaVY0blpWNk5rQ2o4eWNPVE1YTGt2VEx0?=
 =?utf-8?B?a0ZibGpmTE45RWUxMmo4QVBMaEJjTm9OSXBxbWhtTWpWcWt3eWNKak5PLzFT?=
 =?utf-8?B?Zko2R1Q3QnZzM1A1V2c1YjZnM01ZOTg4elJNNzlNV0NBdnV5SzNFYWFqMUMz?=
 =?utf-8?B?Wm84KzlWTHE4eG9TSjhlTzlEKzFzTzZDRkFUQ1pDaUkyaE9DdzYzTUxTUVFy?=
 =?utf-8?B?V3RvYVorSC9Ia3JRQjFYY2l1bTE5SkRFUzFJclVRR3V0a0w0M0RuaEgrZDNh?=
 =?utf-8?B?cmYwUGlCTkVka0VCajZINURLM2hLbCtubTRyMGdPaU9BUlo1Y1UrbktwekpL?=
 =?utf-8?B?SkVRS3RGWEpVQ3hDMlpmT0lqc29yU2YzZ2F1TUNWY3EzaFVWeHVETXJMRFR2?=
 =?utf-8?B?dUc3OW5LaWtxWk5aQllob01EVFE1TW5Ya05jQ1lSSFIxbFJEV0RnbG9Obis5?=
 =?utf-8?B?aTBUaHd2QWVJenkwU2Q2aENQcllMTzl3WFpSWTZaMHMrT0lCWkNKc0RxT1R0?=
 =?utf-8?B?MUY3SDEvblZ3SkhaU1Fjb0ZFeWx2S2s4M1NicmZVSEtkbCsxSk5jMFFpL1ZU?=
 =?utf-8?B?dFFTd2RCZGtOeGJQa08zVlRBU3JvN2NQY1ViWWJueHpUQ1lua1c2UW45S3FF?=
 =?utf-8?B?QWVoNXo0M2FZM011a3RhM25kbmwrNUt3bGd0ZndoNmJNby9MWFlTMmlxeHYv?=
 =?utf-8?B?QlY1Q0NjSFVQYnFKdWsyV3RsYk1VTWpkcXlOT1dlTzYyZldrM2ExUjVqQ21R?=
 =?utf-8?B?VEJPSHovT0YwK2Y5MWxQclhreURobjhYMU1BN2xBL2VNOTBMS2Nja2RKMzhp?=
 =?utf-8?B?MnhQaFRLcm1seVJoQUx4SlRYOUUxTGU5K0FTdHBMRzN5WG5vb2R3M3ZYOHpj?=
 =?utf-8?B?K2pOb1JrYzhJWm51d0NsTy9kaEM0NDhka2dlMUx5TUFRSHhDSWVpOWVrR2lq?=
 =?utf-8?B?bWcveUtBMnZjOGNseWpvbUxwZ2ZUV0psTmVrS3h5Q0Y2bHVXenBjR0RrcHNE?=
 =?utf-8?B?cFAyWEg0TEJTVVpOWmpGbnBwNWp1U0JSNGJGcDRkV29JZUh4YThObkFwS24z?=
 =?utf-8?B?V0xLV1VQVUdJQkRDZ045c3NXczVDYUZSQWx0MHlsSmtDMWMxMm91dk1RWENI?=
 =?utf-8?B?ak5DRzJTL05TNVJ5eGk5RkhWdFdPMFdJVHdBOXM5UkN1ci9rMVhqb1gyMkRG?=
 =?utf-8?B?dVFkcWFOeWpad2JHOWJxOVdaMzRjc0xpaXZuWVBnV3JyUVVQUU5idFBtdU54?=
 =?utf-8?B?dktHU3hORzVsNkd0ZSt3d25tbXlIVndKSGEwMU53UGFrT3NzVXZzUjhHdTNs?=
 =?utf-8?B?N1NnODRpY0ExKy81S29vdWxBMTdUMSs0QWswSnF4ZzJEZlNHdnN6M1ozL0hY?=
 =?utf-8?B?RTJyaHpiTGhENVZscDRaa2paNWc2eHdWMFF1WjdybFNtTU04Sy9SVVdobThk?=
 =?utf-8?B?TTNSRlZPL3Jsei96ek9STUthbU5rWEppTHlmcFk5UEhKank5Q1B5WXNEcEdM?=
 =?utf-8?B?S3JxTHQzNm5Dc2ZHdWpLejkvdnBrKzltOXNvU0V1UFk4SGtGbUIrYnFMQ1pi?=
 =?utf-8?B?MElhYUcrMVY0L2ZuaE9tMTRSRWZpSFUzb3FnbndPK05HeEFQZU1QRjZhd1I4?=
 =?utf-8?B?bGtQc1o2and4WFVGbUhlNDN3cG1vaExqelNaWDdhN2VQS0kyM215aHM4MzlO?=
 =?utf-8?Q?z1UlKl73etPPKHlLJKDCl+Hmq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ad6336-3211-4f57-d993-08dc57aa486f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 09:00:05.0639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCTPmjokMvsXXcvW7Dmt6brwUDwNuOsvmfb/CGk38Ra4FO4xJr0hFJ1MTqzHD0EQiEfSawQ3ySFCd8LzrZlYwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIEFwcmlsIDgsIDIwMjQgMzoyMiBQTQ0KPiANCj4gT24gMjAyNC80LzggMTQ6NTQsIFRpYW4s
IEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBEaW1pdHJpIFNpdmFuaWNoIDxzaXZhbmljaEBocGUu
Y29tPg0KPiA+PiBTZW50OiBGcmlkYXksIE1hcmNoIDIyLCAyMDI0IDQ6NTEgQU0NCj4gPj4NCj4g
Pj4gVGhlIEludGVsIElPTU1VIGNvZGUgY3VycmVudGx5IHRyaWVzIHRvIGFsbG9jYXRlIGFsbCBE
TUFSIGZhdWx0IGludGVycnVwdA0KPiA+PiB2ZWN0b3JzIG9uIHRoZSBib290IGNwdS4gIE9uIGxh
cmdlIHN5c3RlbXMgd2l0aCBoaWdoIERNQVIgY291bnRzIHRoaXMNCj4gPj4gcmVzdWx0cyBpbiB2
ZWN0b3IgZXhoYXVzdGlvbiwgYW5kIG1vc3Qgb2YgdGhlIHZlY3RvcnMgYXJlIG5vdCBpbml0aWFs
bHkNCj4gPj4gYWxsb2NhdGVkIHNvY2tldCBsb2NhbC4NCj4gPj4NCj4gPj4gSW5zdGVhZCwgaGF2
ZSBhIGNwdSBvbiBlYWNoIG5vZGUgZG8gdGhlIHZlY3RvciBhbGxvY2F0aW9uIGZvciB0aGUgRE1B
UnMNCj4gb24NCj4gPj4gdGhhdCBub2RlLiAgVGhlIGJvb3QgY3B1IHN0aWxsIGRvZXMgdGhlIGFs
bG9jYXRpb24gZm9yIGl0cyBub2RlIGR1cmluZyBpdHMNCj4gPj4gYm9vdCBzZXF1ZW5jZS4NCj4g
Pj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRGltaXRyaSBTaXZhbmljaCA8c2l2YW5pY2hAaHBlLmNv
bT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNv
bT4NCj4gPg0KPiANCj4gS2V2aW4sDQo+IA0KPiBKYWNvYiBoYXMgYW5vdGhlciBwcm9wb3NhbCB3
aGljaCBzaGFyZXMgdGhlIGlycSBhbW9uZyBhbGwgSU9NTVVzLg0KPiANCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyNDA0MDMyMzQ1NDguOTg5MDYxLTEtDQo+IGphY29i
Lmp1bi5wYW5AbGludXguaW50ZWwuY29tLw0KPiANCj4gSG93IGRvIHlvdSBsaWtlIHRoaXM/DQo+
IA0KDQpJJ20gYSBiaXQgY29uY2VybmluZyBhYm91dCB0aGUgbmVlZCBvZiBsb29waW5nIGFsbCBJ
T01NVSdzIGluIERNQVINCmlycWNoaXAgbWFzay91bm1hc2sgaGFuZGxlcnMuIHRoaXMgb25lIHNv
dW5kcyBzaW1wbGVyIHRvIG1lLg0K

