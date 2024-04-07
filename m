Return-Path: <linux-kernel+bounces-134250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A455C89AF81
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32832282CA6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA7111A8;
	Sun,  7 Apr 2024 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4PuUW4w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4AE546;
	Sun,  7 Apr 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477617; cv=fail; b=jHO+KVBLcehnbNgl/63nXtDKXb2+jcVra7NU2rUhmStPk6XyryEmHSXiW1AkpiME3YJQow5JAAz50HSQI7QBXbhXg5NKsQbTWiX2ZuwoCe4cHAJxfxcLsChC1SZKhaiSY2TMQx+ljWB5lhvIRrdN8XVWdUomPjwbc6zOk9Hifxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477617; c=relaxed/simple;
	bh=dixjK+0GjGXAz+oEh/PyRhbJ7anMsI1p0hJ0fX2NQrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=doXb5q8JFYM6QYzXifw8Ru/8XKT4zHTIfLeYGjvgDGXcWjtwn9L9nL/QbSVzQ3W3WPyIiciGBHNHcqxcUfE9Hkqos5hE51xPWxPH1iGxYNjbQHc4YyY3hCXMPSzGSZ4W01o8XjewrZ44gt41E78AL+8p6/16VzSJ8mhy4UmfbMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4PuUW4w; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712477614; x=1744013614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dixjK+0GjGXAz+oEh/PyRhbJ7anMsI1p0hJ0fX2NQrc=;
  b=S4PuUW4wpWOvSxigxHmgiHRSJy2baoRTjPq+eu8tcINofnnEgf2w7XP7
   Mj5ZhjtaVYkEOVgREkakTK5f2Tselp1/lBZrkkKbDqfw58UoDDWKxHsH1
   xtMvE/pqYwxEMo2RdMCNdj8u+wwfnZZ8aJ6IxdJgOIsVXF29WG2L+ep5b
   3gqO5tfR3ZlljOIKljpe7FJEAxM5lNJJWvvgEnQoQnnNVCRynwm5JExV4
   /Ut/EwKJ4GlpDX5hKePDdpbJbjrk/fa/4T+kZ8w1Jw2kPZ5RXBH9Uhp8x
   cs8m0u6D9Ob0dUevcuJ7LMpi45BAouxXxOqLoGAI8CgJRprXIgBSwaa+i
   Q==;
X-CSE-ConnectionGUID: 6rIHz91uQTqWxJmA9oOkPw==
X-CSE-MsgGUID: mI/yBpvTQX+BagF/Gtb+Nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7623475"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="7623475"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 01:13:33 -0700
X-CSE-ConnectionGUID: 7iWoufFdRDSmXC8pBl8R8Q==
X-CSE-MsgGUID: DsxQFNyqTBWQKtdGqoYYQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="20019352"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 01:13:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 01:13:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 01:13:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 01:13:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 01:13:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdGlyggxvbwcAPdEBFfjj7CPstJsjOiNhYzUJbb2GnKjYD/cXE24JIM77Gsg3eJI6xOyHzxA8BkniNOMYRjAEzMvH/29JzSAkU8njb+55fZSCC6iQ3HxoiJBBkzfcKRGREpm7BDbDIPzC3WUQIPVJ+M2arcXr+HHeTiXZq4OZFk6LUQ+3VgrBIuuinWjtLKddflXmeN4vBMKRfRVF4Eu/mUThDzYT6sxgP7GlV3wF4IepDVwfju3UoOyYcsT7t0VPGaDvMkqw2t0fSu/Peyx3xGUbM7JYnGld2XRO8eEX/cKxoY6cDpUmDBW/Icc4gRhAoYQ9v0Cpt0cD8NIkvg6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dixjK+0GjGXAz+oEh/PyRhbJ7anMsI1p0hJ0fX2NQrc=;
 b=TZVJddFJ7iYhxGWYsndT3wRdSUxF+SLtE6U9lq5o1o3TA7Q7OG54UoxB+IFy9LUZMTFAAa33w4IyuDq9dqov5hBIWleIhlcPg3eC9mGJWChVjqOmUbtaotCFn4hqhm+06WvZrXgszcEEjGoQunuvYIwdA8xkwsqzc1sMqeSh8AYumkoKo0Ba+qORcUrl0TuzXixO1Av43MUi1k/IIoIB40CJjVWhEKAD/6+wR8LhLCrKEWp0K99mVgQty8joOjgli180d7Sk5WBw5M1zSIB2yCjnUv/E2rdHSHR0dQFh/JSWfv2xwoZSkscSVpdAAYNpv+sNnKLbj7nDuNrCXEprvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Sun, 7 Apr
 2024 08:13:29 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7452.019; Sun, 7 Apr 2024
 08:13:28 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>,
	"ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "jdelvare@suse.com" <jdelvare@suse.com>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Neri,
 Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH 1/3] thermal: intel: intel_tcc: Add model checks for
 temperature registers
Thread-Topic: [PATCH 1/3] thermal: intel: intel_tcc: Add model checks for
 temperature registers
Thread-Index: AQHah72G3wZLzIoN9EiybzMRHcAg2bFcd3SA
Date: Sun, 7 Apr 2024 08:13:28 +0000
Message-ID: <5e86524413ec2cfeb1096f49851bf18837c7e50b.camel@intel.com>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
	 <20240406010416.4821-2-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240406010416.4821-2-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|BN9PR11MB5227:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/II0cMpGarNGYkvUDJKYCPwq3s8bhIkU6fKEKTlQ3agZu5Z5fGij4HZBaS3Y4LUjcbVGcuglLJhzCdiqVBPPWfBok9bMF97mu01oR6qfEbtX0Gaj+gmL23uznxK82dZ/K5eN+Zdmut7aV9O/O3LcTNRkTx2bd519zrVIkQ9MzdRjHZG/3oWJS/GLHYjPa7xj+ijA6m4MFegE1Ayjx0bvlz8Qced8fwqiJLnd1MYGJRr94pxaJSVJFg3HSNmpp0oRDOtgqYjg13uw5CCFETddVEa+RqbfIdke4sk4NsiU88DiUrxSTs9Y8xzlG2S8YICikIliUmspgnVLX4EHEnaLsmz89RQ4XqsIR/OVkhhw0Aukp/rVaqNYxUYNGwNqDkxLnThd31tIR0z3wB3gc8U5kEIzLszTX9eGqN9Kfd3JguLa/jzfvQS93rFkmA3NBedL3SRu31rsQPu78NsSNtra3QlXnhNbmFYci5w52BVzDOYOYrAYWviWMqBWrZ3C4aBqckwMyjXPEQXYfjnjUVvT+T3JCW0ox+Tbc9ml49yUMi6O7WulGSp2Mgd4ct3LgrS2ya4ww2TEv7sXl4zDYlGGTlnY5HlfyZABRTJCLErYDZI8RZnopB/ufem9AHEPyXRNMyFCI1ZJPueZNcDkf0BzGd6/n/9v8Jeslbst/MBlPg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHNnNGhwZU56L0Z2TXlJU0JXQ1VxQWtuQUtTYkhWZEdOUzdMeDI0cXU5UWhz?=
 =?utf-8?B?bmpTdFF0aFp3Rng1VTRhbGM1MURkT3R4TEZEMzVkUFplL0hUdSs3b0pJNmx3?=
 =?utf-8?B?SzhhaVlwQUtNdGt2b3BWanZiV0Q0REFTL2FndjUvVm9KT3pScTFoTnkwSXVJ?=
 =?utf-8?B?OXlZZ1F3VjBOZnkwMU55T3Bxam4reDE4VmwzdnVRQjIvaUVEYVdGNzBpcWNK?=
 =?utf-8?B?Wmc5aVhvVXFiTXh5clQ2UXVNRFhkQ2Zldi9ISjU1WXdUUElXWmRPaG5qUWhv?=
 =?utf-8?B?Znc2eTlQaFowQ08zQzlraFMyc2hmL2VIaHNxRHo0Um0wbkNadTZscjhXcWtU?=
 =?utf-8?B?UjhuL2lFdzZEenZvL0oyWVI3UGpmYWFTbjNHelhEZm1rZTBuU2lhQk1qbHFE?=
 =?utf-8?B?c1NjNHZBWUgvbTVmd0pUa2VCdXM2ditheGJvTlBQekRlZ3FkVW02d2xLemFk?=
 =?utf-8?B?TnRYYXBwS1djS3BnYzg0OVdoT1laK2dNd1pZdzV0QXhkbFlIRzh5L3FwSVJM?=
 =?utf-8?B?Mk80Z3RFWTc4czlNZGh3RWV4OWFXQTFPSFFoRkpMT2swTUpHOFJmZzdwdlpv?=
 =?utf-8?B?OUp5dmwyOVd3emE5TUtqazVXWmVDS1ZKK2dST1hYcU5wSUFDWmtiNWhEaWJW?=
 =?utf-8?B?ekp3eU0xMVJLUWUrMUE5TkxWMEZUcHoxSFJBQlVqSjU3emdSMzBGZVhpankz?=
 =?utf-8?B?QnRPZnVkOVdvMCtJLzgvNHkxZWVlbVRDY1YyblpybW1SWDIwdU11Qjc0aEpQ?=
 =?utf-8?B?ODQ5T0tYYXVmTG81S0dBRStwaUlTL1VSTVdCSGUyQlB0N0p5bnBwUTd4WTQw?=
 =?utf-8?B?Z2dHWElCZng0Y3l6WUN3NzNGVjNReXV6VXI1cnNvcHdJeXhOcExBYnFmTWdt?=
 =?utf-8?B?MUhkZEdJMDFiNVd3TkNzNUplczVZNXMwYllxSXJrR1NFQ3Zldy81YkxKOXpr?=
 =?utf-8?B?ZzB4Z1Nhb0hkWHBWdHo3QnBLS0lBNlZCSkd2USs4T3N5OGpjMUVibTFzTHFa?=
 =?utf-8?B?S3JuWXQvT1VBVnMzQzNNayswbVg3UHFubTNKWGQxL29YNENRSVJ6TEgyYUEy?=
 =?utf-8?B?WHJyRDRydUl2ME9sQ2hVNUloR0t1V3hwSThiNUZqZVVxUnVjMlJpQy9Fa2tM?=
 =?utf-8?B?RTBES01MaVBpNTkzT3FJTkZEdVRZL3lFbUdQR1E3SkxnWVFSSEt5dmpHMk9F?=
 =?utf-8?B?TXcyNlFHL0tsT2Y4TTU0bjlUZm5qdHk1ck84cHdlelpySkVhSkNOTENzSXNJ?=
 =?utf-8?B?c3hMeDV4S2NEcjJWQzRuNDgwVzVRSkdsVmpRTjlSaHhac292V25YZHFScitH?=
 =?utf-8?B?NTVMVElWelNuWURhWkROQWJueG5zaWhtc2RrSzJPZ3lCZmNxc1dmTU92SmhD?=
 =?utf-8?B?bTBzT3ptQW85OVlZL2VrcTdLU2dCRUtyTUNtenU0bXlaQkpnd1p2UEJjSWlt?=
 =?utf-8?B?K1R1bDhRY3NEMkFmNURYdWprYnJqcFhzV3FzNmtyY0hVVkNyR0VXSWtLUEJU?=
 =?utf-8?B?ZGhEeVZEc3pCZllBcmpCZ0R0eXFKRStNbDM5VHhsVnRvVTg4Y3R3a3lMUE9B?=
 =?utf-8?B?UmZEN3JTdWZFV3JzUGw3eFhaeHBWRVE4SU1jUkp0YzFOUnB0MWxMa3dCK3ZJ?=
 =?utf-8?B?N1UySEZkdXA4VmVIWFlBeTNNT1VOd3AwUWV1akVsQVMrcTRmbkJIVVRNeFJq?=
 =?utf-8?B?R29yamo4SkdWUHhXZFcyQVF0MkxLWVRDRWNSbnBCUlF4WDhOdWJxN3cyRGJ6?=
 =?utf-8?B?endmUzMzMjFNd2ZVK05JblNSdGdTRndYOUo3SFRsNjhJRUpJWEozdUgxbVE5?=
 =?utf-8?B?YjlDM01CRDZZUmYwS0VaU2U2ZjZmVjVvRHkxeXRlLzFXSW5MUW00cHJwSGRN?=
 =?utf-8?B?SG5HVGNrTXNxaVdPRHhqUTMxL0sxNzFJZ25iK2JzNmpubHB6aFo2TkNZMnVq?=
 =?utf-8?B?NG9hN2dBRHFHWXZQMmF1OFV3SUN3aVZxL3UxRDdwSE92bEhCUGdzOUd0eitq?=
 =?utf-8?B?cWp0dlRLOWwrZ0FCN0M1VXd1UG5PZm9UOVZITHV6R1FLWC9kbkF6WVpmV1NK?=
 =?utf-8?B?RnFoQm9VMmllRjhCQ0UxaWhkaTg0b0FuL0NHMGkrWGZZTkFuY0E1UnVwUzEw?=
 =?utf-8?Q?MT2Ygape0enmKEB39IkBU6BVb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C846117FB8CFA24DB4EBA9C10A22EE9C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fda44d-66a6-42a7-1475-08dc56da9b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 08:13:28.5860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDmmaakP4X5z5cnHotfGaqvpgS8dEasrZXM8jc9wxsOZ7FGf5W4UUh1x+XLSx9y3XiKLTdZLUh+jKHiMPahghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com

PiArDQo+ICsjZGVmaW5lIFRDQ19GQU02X01PREVMX1RFTVBfTUFTS1MNCg0KRnV0dXJlIG5vbiBG
QU02IHByb2Nlc3NvcnMgY2FuIHN0aWxsIHVzZSB0aGlzIG1hY3JvLCByaWdodD8NClNvIEknZCBw
cmVmZXIgdG8gcmVtb3ZlIEZBTTZfTU9ERUwgaW4gdGhlIG1hY3JvIG5hbWUuDQoNClsuLi5dDQo+
IA0KPiArDQo+ICsvKioNCj4gKyAqIGdldF90Y2Nfb2Zmc2V0X21hc2soKSAtIFJldHVybnMgdGhl
IG1vZGVsLXNwZWNpZmljIGJpdG1hc2sgZm9yDQo+IFRDQyBvZmZzZXQNCj4gKyAqDQo+ICsgKiBH
ZXQgdGhlIG1vZGVsLXNwZWNpZmljIGJpdG1hc2sgdG8gZXh0cmFjdCBUQ0NfT0ZGU0VUIGZyb20g
dGhlDQo+IE1TUl9URU1QRVJBVFVSRV8NCj4gKyAqIFRBUkdFVCByZWdpc3Rlci4gSWYgdGhlIG1h
c2sgaXMgMCwgaXQgbWVhbnMgdGhlIHByb2Nlc3NvciBkb2VzDQo+IG5vdCBzdXBwb3J0IFRDQyBv
ZmZzZXQuDQo+ICsgKg0KPiArICogUmV0dXJuOiBUaGUgbW9kZWwtc3BlY2lmaWMgYml0bWFzayBm
b3IgVENDIG9mZnNldC4NCj4gKyAqLw0KPiArdTMyIGdldF90Y2Nfb2Zmc2V0X21hc2sodm9pZCkN
Cj4gK3sNCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGludGVsX3RjY190ZW1wX21hc2tzLnRjY19v
ZmZzZXQ7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX05TKGdldF90Y2Nfb2Zmc2V0X21hc2ssIElO
VEVMX1RDQyk7DQoNCnRoZSBuYW1lIGlzIG5vdCBjb25zaXN0ZW50IHdpdGggdGhlIG90aGVyIGlu
dGVsX3RjYyBBUElzLg0KDQpob3cgYWJvdXQgaW50ZWxfdGNjX2dldF9vZmZzZXRfbWFzaygpPw0K
DQpbLi4uXQ0KDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ludGVsX3RjYy5oIGIvaW5j
bHVkZS9saW51eC9pbnRlbF90Y2MuaA0KPiBpbmRleCA4ZmY4ZWFiYjRhOTguLmUyODFjZjA2YWVh
YiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9pbnRlbF90Y2MuaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L2ludGVsX3RjYy5oDQo+IEBAIC0xNCw1ICsxNCwxMyBAQCBpbnQgaW50ZWxfdGNj
X2dldF90am1heChpbnQgY3B1KTsNCj4gwqBpbnQgaW50ZWxfdGNjX2dldF9vZmZzZXQoaW50IGNw
dSk7DQo+IMKgaW50IGludGVsX3RjY19zZXRfb2Zmc2V0KGludCBjcHUsIGludCBvZmZzZXQpOw0K
PiDCoGludCBpbnRlbF90Y2NfZ2V0X3RlbXAoaW50IGNwdSwgaW50ICp0ZW1wLCBib29sIHBrZyk7
DQo+ICsjaWZkZWYgQ09ORklHX0lOVEVMX1RDQw0KPiArdTMyIGdldF90Y2Nfb2Zmc2V0X21hc2so
dm9pZCk7DQo+ICt1MzIgaW50ZWxfdGNjX2dldF90ZW1wX21hc2soYm9vbCBwa2cpOw0KPiArI2Vs
c2UNCj4gK3N0YXRpYyBpbmxpbmUgdTMyIGdldF90Y2Nfb2Zmc2V0X21hc2sodm9pZCkgeyByZXR1
cm4gMDsgfQ0KPiArLyogVXNlIHRoZSBhcmNoaXRlY3R1cmFsIGJpdG1hc2sgb2YgdGhlIHRlbXBl
cmF0dXJlIHJlYWRvdXQuIE5vDQo+IG1vZGVsIGNoZWNrcy4gKi8NCj4gK3N0YXRpYyBpbmxpbmUg
dTMyIGludGVsX3RjY19nZXRfdGVtcF9tYXNrKGJvb2wgcGtnKSB7IHJldHVybiAweDdmOyB9DQo+
ICsjZW5kaWYNCg0KZm9yIGludGVsX3RjY19nZXRfdGVtcF9tYXNrKCkNCiAgIDEuIHdpdGggQ09O
RklHX0lOVEVMX1RDQw0KICAgICAgYSkgZm9yIGEgcGxhdGZvcm0gaW4gdGhlIG1vZGVsIGxpc3Qs
IHJldHVybiB0aGUgaGFyZGNvZGVkIHZhbHVlDQogICAgICBiKSBmb3IgYSBwbGF0Zm9ybSBub3Qg
aW4gdGhlIG1vZGVsIGxpc3QsIHJldHVybiAweGZmDQogICAyLiB3aXRob3V0IENPTkZJR19JTlRF
TF9UQ0MsIHJldHVybiAweDdmDQoNClRoaXMgaXMgYSBiaXQgY29uZnVzaW5nLiBJTU8sIGF0IGxl
YXN0IHdlIHNob3VsZCBsZWF2ZSBhIGNvbW1lbnQgYWJvdXQNCnRoaXMgZGlmZmVyZW5jZS4NCg0K
dGhhbmtzLA0KcnVpDQo=

