Return-Path: <linux-kernel+bounces-150339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B38A9D99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10856B22387
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E77168B00;
	Thu, 18 Apr 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQ1YTdA9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2535F15FA72;
	Thu, 18 Apr 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451866; cv=fail; b=Qe1ckq0/OM3XEMopHY91i9piXqwQ5ynXYa6DrwHTleRoB42u8wNlnBbtdmlPRKrqThEVKz0Yv0ZJxtASdtq+0/ITSXhNZDETAKnvNByRg/G0+vsC/qb73kRQnzpTBejrXSFpMU/Ppihf726nT7of5opY3fg9i38iLnkkAyUkcck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451866; c=relaxed/simple;
	bh=QJF5yUluj/wIPk2I/FWsOEykrvinwcVajG5OlBYb+bU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ecy6ZXqbh+LZqGPboAnAtGhhYKW7Q/YxCgm0GYZ+xc4B7rLpFoIcPeZC29D/5Czmtgv46gbIdkH4syzM9QI4axCJgXAYXpU9e397yT1dxd4LDFCdWSQoKfIVjlq6NoedmQud9VEtVR1UHmGVc988PDonWwLHozi0KDRXJWHTvz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQ1YTdA9; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713451865; x=1744987865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QJF5yUluj/wIPk2I/FWsOEykrvinwcVajG5OlBYb+bU=;
  b=iQ1YTdA9ihSl2oBf5u0yaaGPVCURohAB47LBkPER6VK8rigDwPn+CAK2
   lh01kTpDPnI6xULidLKXeJdBhC9fVQLD6xQAE0fZRILDsjjvmUiyXPq8U
   SSaQPvfaXXc0BoAydoVcN7RRAZH6rA42qrDvZCyonh2ERVA5X3KCKFqwm
   4CO/QyeDsDjKbsOMUE6hN2fqzn01hZdE3A1RNnB2JWy4VD4mRANHXh/MI
   4FuIaq5TQXqpl0kKV2kMUqUyVjas/xOZIs0UJoHLiLQQnYQjWmNxc5dtT
   trTJn8Irrh1TFovJY/LVmWQ+gqeCCrgt7XjwtX+tTJeFU96QcmAgpeDYo
   w==;
X-CSE-ConnectionGUID: IRhg2tCnQ8Suybc29jy3qg==
X-CSE-MsgGUID: WkS981geQiCXjCYmhhmMtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8837712"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8837712"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:51:05 -0700
X-CSE-ConnectionGUID: v/VECkUISRyRw0R4kRPyAA==
X-CSE-MsgGUID: BCRc9/3ISc+t9fyA08m41Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27818425"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 07:51:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 07:51:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 07:51:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 07:51:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 07:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exVsA5On33rqeuez7B1Ti83LyfYRvJjHPk2AJpnQG03zrW09XIL6oSqmdlf2ZE/Bk4K/po51twuVVBV2vEUFuJGp6p1btXfnO7zieusQgF5YSA/pF8x+oJamVo9+v2sVbAIRR9KNBlrqD1qs8Il0j6LjWmV0peIo68arOMkOs+iM0DN/rN6+yMid0XrLZw7E2+bWZmGxwU6+NeLf1c+VSD9u31L9ae83U8T3ZbqKmT/lsApZkitUTGXjUfY97Av5ab4Sysv2zWrYUMxmty407xFVTfycaxFZHstYz/aT5nC+C/SBv5E+CcIHhpPFsLafCLaZc4WfPLYaJ2JGKqRPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJF5yUluj/wIPk2I/FWsOEykrvinwcVajG5OlBYb+bU=;
 b=GCeG6C3bkLI9NkGJnI8y+B8ZsRaDtRaFB2Dw1j7JpMw7/l/tjJ7cFsPXwWPlhKitTOGj274u32UC52V/j2+OAABv7GsJPiZPzbdBs1mAJcjTIcfsvcc1NdVUWoEoSrFmA7IXEabDXlejaiJJc+8S+LY/3sUVy2ZMEyI1hR5b4aBlZ+CNp3FL3FPXhXR1hw2nAgmBxwHrIP4Y/AMV82K88z7tpZny1wuuGfHvZfRiRxmR+R0EDuBERarECkB6JXtqCNn+vaCXfcvAhSvmo2kc1GnQskuWyKzVtIaA9xCwW2SOyFA5zE99iLmmm66/I8kcUkhjE27aHlbF4RDw89bFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Thu, 18 Apr
 2024 14:50:56 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf%6]) with mapi id 15.20.7519.010; Thu, 18 Apr 2024
 14:50:56 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>
CC: "patches@lists.linux.dev" <patches@lists.linux.dev>, "Luck, Tony"
	<tony.luck@intel.com>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jdelvare@suse.com" <jdelvare@suse.com>
Subject: Re: [PATCH v3 50/74] x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
Thread-Topic: [PATCH v3 50/74] x86/cpu/vfm: Update
 drivers/hwmon/peci/cputemp.c
Thread-Index: AQHakEQwGnZ4qOKG40CUyk3on+cyGbFrfA0AgAAIgICAAAjkgIAABZ0AgAJ2DoCAAAXGgIAAEDYA
Date: Thu, 18 Apr 2024 14:50:56 +0000
Message-ID: <f0b67e10b79e7e57846f792a0671434ce20c878a.camel@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
	 <20240416212216.9605-1-tony.luck@intel.com>
	 <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
	 <SJ1PR11MB6083D0DFBC7DE286F986A453FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <8690bcea-3ff4-49f1-a671-16583b8d241e@roeck-us.net>
	 <SJ1PR11MB6083C8D12885057BF3A0A6AAFC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <7cb09d67409c94284928243d8ffb1f8a3128d849.camel@intel.com>
	 <f1d02e4f-a947-4af1-a7c0-9f7c12c57b3e@roeck-us.net>
In-Reply-To: <f1d02e4f-a947-4af1-a7c0-9f7c12c57b3e@roeck-us.net>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|CO1PR11MB4788:EE_
x-ms-office365-filtering-correlation-id: cc0aee54-49ab-4dbf-a221-08dc5fb6f3f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SgpMWyzyZ0CGioSWfyqRb3BWaZi1OVF5sqv5TCuDqid0bthaxQv9spfOd9iGi3rFEjAvEx9FortLAuhoUcjQpvTanxrM2HsalQZ0rMULZ4Oqda+3VCgQS+S0TkICkxcmPsUqU11QjAedutA8q3oxjjEgUFJFqBar+JCtTtZleLR6y9O/8m3bDxl2+wtgKmRpZ7VUkn7oHr2KMcBchGYh76JqEaAwiMEVLO6YnDUuEK7N1XAitvX/BXJtbnYExNBXSBjG/N3NbFLo1Ks29AINKl+1IwLNjajDhVKLDNXh9jBOTngEAROQ33hb+mypGszazLCrUiE+4KdKxcFDQeswA94sxvsUFrwUiOaQZk09lG64v/HatwRUBexuaYzwHjGvetJlrzX5XhudJblGzJbi8PP7B4G+GmKkL0dcHHtKUI7+AJfn7+0qnraz9F/q7Oqmv8YtWJYfgnnDSFlQDIHVoI0Yam9gOM4FUvAT+eliW3kjMq96qq6Gz2/Wunf6pMxM+Mag29NaumqmgyH0kviHC8A+Xy4x4rXLymPKYdCnlp0rLfeNh4ERP9T84mYA28FTsdFZoIaqHmaJetV3cQgMoeoCeJQvphXPj7BgAyZoM3c5SvAxlg+StVYscC9DzjjzOR8kUmkyKPOPYGpvdPPgakFPLacNiMQonUSZ+NKe13BvvdvC3iVPrBsgs0VbL+QdeRxFsWNB+8zhThK+0yyu/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDNSNlhXLzBicUw3c3U1N3grQkJ2bm1FeWJPMmRvUWhmbE1OZWZKWFM0RFRZ?=
 =?utf-8?B?MWNNWVhMVTZPYkthVUhuM3Y0aEwrSmpRWFExVzJjVzFaTXljY0JNNlJoYnZC?=
 =?utf-8?B?NmxzVFZxbGsvcnRhNXBvM29FN2Y4cGtvUjloQnNRUnVyYlFqTDZtTE50WkZM?=
 =?utf-8?B?QzBqWnd6a1RjS2tjN2xyeFpUVFVyRlBvNElLSXZhTm96L2RkZ2E5Smg0WDJ0?=
 =?utf-8?B?U1FRTHhpMXlHcGpvaDROQmhZZ25STkhmd1JMTWVnVzkwNjV3UDBxN0pqU25K?=
 =?utf-8?B?bFRoeGpXWVRqK0lwL2dWUHJSS20rcXErMzRuVTMwcXQ5Sng2dHRzTXNmOE9h?=
 =?utf-8?B?UkFIZmRGRjRKZ1Zrb29HNjlIb21BY2Z6bXNkN3V4OU5rUzBJWXNhZjc1VC9x?=
 =?utf-8?B?alNiYTNXUHVURDBwaURuUE1pMWcxNVcrVFkvUUMrUlo1bkFWQzRBOEpUZmRu?=
 =?utf-8?B?a0VOZUZ0YzNEYWR5T0tXSFlqcjdZbEl2Nk1xL3VCTlpGSlh6ZkdNd0ZpaU53?=
 =?utf-8?B?SWkvcWorZytoVmVJclFXNDMwNVhUbUp3RVBwbFFUWDFyOVN0ZjBjMGt0QzAr?=
 =?utf-8?B?cmJXSDhudTYzaGFMYmlrSUNKUjA3ZnlLdlUxUnZLTlM5Qks5R1RaNXpCUVdS?=
 =?utf-8?B?bnIyaUtMeGdFdWllSzE0WlJHK0NUNmJCN0llUFpCc1VSNXI2VHJiMXNVbzhP?=
 =?utf-8?B?QXg4SXBaM1FlWjlKT1BVTVFpaExCS3F4eldITGVQTzBGazNVK3RpLzlKM1lH?=
 =?utf-8?B?QVkxbzNkS0w5bEt0SkZFSXNPMXdTTGU5SWJDcTgxS1ZqTmQ0U3FNRDRRNmpn?=
 =?utf-8?B?dkRYZXpsSVNkdS9pTnc1SVE1VDNRRitlcUwzazg0a2dIRy9qM0VnT1lxeSt2?=
 =?utf-8?B?ZnJDSEw3Mm1QRGRYNERYWXZ6TUJ4YnhaQ2hVWG5WekcvVEhnRTl5VEhWRUZV?=
 =?utf-8?B?WHZHR0EveFUyNlc3MTRSbnc1b1RLeFFZeHVKUlpKNU9PaUZaZWZTNDJJOE5R?=
 =?utf-8?B?U2VFNFAySnk4bWhSRG50RUd1THJKaEJGUVFDajJ5Z2Y4bXJFQlJWSnJGaEdO?=
 =?utf-8?B?ZThadzZseDU0dk5RaDlMb2JCRVV6SjdMNlQrNGpBQ0VKbC9nR2JHZ0RPeXJ6?=
 =?utf-8?B?TnZJMjkxWlVNc3hhMUxqY3lUN1JCdEFsZjFEeWFJeWZBZjZqUGl3cXNROHVR?=
 =?utf-8?B?eFdGUjZzbDh6TVZ0NUpPU1F3dDhucmQ2SXBCYXNPSFhmNFhWbStVeW5haTBl?=
 =?utf-8?B?bE8xMjRDUnNUUUxxQkx4NE9oekdvdTZWdm9iNWNZdEJGUjdicnk4dS9keW1s?=
 =?utf-8?B?WTE0WFVXM2E3di9hQ0x2R2dMQ2xnd0dKdVFORVpXOHFHUFY4d0M5d1ZkK3JR?=
 =?utf-8?B?VHZSRXVqL1MvVEl1eWlLWjhUZnRzVWtsWUJBVDN3VVhpdHN6ZTg4L0JZZGNR?=
 =?utf-8?B?MVMrWGtJc2Z4dStFODhsbnl1L1grREdXNGpIN1pXQTF1SzJTV0x2aHhQYzVX?=
 =?utf-8?B?czNTamdLOFhLRUtSWWVGUGF6THlONGR0bXVZbmUwb09wZTlSVnA5N2NoQVds?=
 =?utf-8?B?TEt1TFRCZ3NxOXJydkY3ajN3d2NnMHlBemMwSGMydHlPRkppK2JpbHljWGc4?=
 =?utf-8?B?bkVZckZCSzFzSlpmMjFMRzZzbHd3OXg2Sm4yT2FiY3E5dXFVMFBudi9RNVlM?=
 =?utf-8?B?djQ1RGxDZUQyQ2Q0ZXN2UWU1K3V4MlFyVXN2dXo1STZmS3Y5TDZpcGFtRWpR?=
 =?utf-8?B?cEhhK2JpdmRlZlplOHFxT3crMWFzZmE3MEE3K1dOTkFybDNYbVI1OFQyWmtL?=
 =?utf-8?B?Q01kUnRPdDk3VFpwMzdhbHkvdTZJM3pscjl0UmNZNXB5bkE1UHpTd0Nmb0dV?=
 =?utf-8?B?eERBRVA2Z2VqeHpWaU9Kb0w3dlVaMnBveGJETHBoSlRqei8rUnpFT1gyeHc0?=
 =?utf-8?B?NUoyb2FaSmNCZGh4RHZRZlBwNFRaWVRuWG9mck9BMmFQam9wQk9na3l6dm00?=
 =?utf-8?B?M2Mvb1pkOFBUM3ZGNW9LQ1ozRzdLNngzZ2dqakFjaTg3WWRYVndub3Y3Ymhi?=
 =?utf-8?B?KzR1b3pTN3VZNng0ZzRIU1Y2RlROUnFpeUkvWnM0cDNGQkRuOWZzQVJkdkx3?=
 =?utf-8?B?QzJxSjQ0ZHorTTJudHJXbStoZ1g2SmZmVXhPRmdrRDA1WkNrMWEwU1NveEpr?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CECDAE7D9DB1D4EAA96E56F9E78DF5E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0aee54-49ab-4dbf-a221-08dc5fb6f3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 14:50:56.1003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oT+h9zVFqgFDkRSF+nRbmEk25jmiZn6HfhqmQsg7+8if5U5QkJVlAHB0WS8iUm3+DjjyREHSF9LtvVBGVI20qYKgiMZ9Oss6xP6m5jjtTqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTE4IGF0IDA2OjUyIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiBUaHUsIEFwciAxOCwgMjAyNCBhdCAwMTozMjoxNVBNICswMDAwLCBXaW5pYXJza2EsIEl3
b25hIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyNC0wNC0xNiBhdCAyMzo1NyArMDAwMCwgTHVjaywg
VG9ueSB3cm90ZToNCj4gPiA+ID4gSWYgdGhlIENQVSBkZWZpbmVzIGFuZCB0aGUgbmV3IG1hY3Jv
IGFyZSB0byBiZSBrZXB0IGluIGFyY2hpdGVjdHVyZQ0KPiA+ID4gPiBjb2RlLA0KPiA+ID4gPiBt
YXliZSBpbmNsdWRlIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NwdV9kZXZpY2VfaWQuaCBmcm9tDQo+
ID4gPiA+IGxpbnV4L3BlY2kuY3B1LmguDQo+ID4gPiA+IFRoYXQgd291bGQgbm90IGJlIHdvcnNl
IHRoYW4gdG9kYXkncyBpbmNsdWRlIG9mIGludGVsLWZhbWlseS5oLg0KPiA+ID4gDQo+ID4gPiBH
dWVudGVyLA0KPiA+ID4gDQo+ID4gPiBMb29rcyBsaWtlIEkgZGlkIHRoYXQgdG8gcmVzb2x2ZSBv
bmUgb2YgdGhlIG90aGVyIHBlY2kgcHJvYmxlbXMuIEJlY2F1c2UgSQ0KPiA+ID4gYWxyZWFkeSBo
YXZlOg0KPiA+ID4gDQo+ID4gPiAjaW5jbHVkZSAiLi4vLi4vYXJjaC94ODYvaW5jbHVkZS9hc20v
Y3B1X2RldmljZV9pZC5oIg0KPiA+ID4gI2luY2x1ZGUgIi4uLy4uL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2ludGVsLWZhbWlseS5oIg0KPiA+ID4gDQo+ID4gPiBpbiA8bGludXgvcGVjaV9jcHUuaD4N
Cj4gPiA+IA0KPiA+ID4gU2ltcGx5IGRlbGV0aW5nIHRoZSBpbmNsdWRlIGZyb20gY3B1dGVtcC5j
IGJ1aWxkcyBPSyBpbiB0aGUNCj4gPiA+IGNvbnRleHQgb2YgYWxsIHRoZSBvdGhlciBjaGFuZ2Vz
IGluIG15IHBhdGNoIHNlcmllcy4NCj4gPiANCj4gPiBIaSBUb255LA0KPiA+IA0KPiA+IEl0IHdv
bid0IGJ1aWxkIG9uIG5vbi14ODYsIGFzIGNwdV9kZXZpY2VfaWQuaCBpbmNsdWRlcyA8YXNtL2lu
dGVsLWZhbWlseS5oPi4NCj4gPiBJIHRoaW5rIHRoZSBzaW1wbGVzdCB3YXkgdG8gc29sdmUgdGhl
IGlzc3VlIGlzIHRvIHByb3ZpZGUgYSBjb3B5IG9mIFZGTV8qDQo+ID4gbWFjcm9zDQo+ID4gYW5k
IFg4Nl9WRU5ET1JfSU5URUwgaW4gaW5jbHVkZS9saW51eC9wZWNpLWNwdS5oLg0KPiA+IA0KPiAN
Cj4gSSB0aGluayB0aGUgcHJvcGVyIGZpeCB3b3VsZCByZWFsbHkgYmUgdG8gbW92ZSB0aGUgaW5j
bHVkZSBmaWxlcyB0byBhDQo+IGdlbmVyaWMgZGlyZWN0b3J5LCBzdWNoIGFzIGluY2x1ZGUvbGlu
dXgveDg2LyBvciBpbmNsdWRlL2xpbnV4L2NwdS94ODYvLg0KPiBBZnRlciBhbGwsIHRoZXkgX2Fy
ZV8gbm93IG5lZWRlZCBpbiBub24tSW50ZWwgY29kZS4NCg0KWWVhaCwgdGhhdCB3YXMgdGhlIGlu
aXRpYWwgcHJvcG9zYWw6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjEwODAzMTEz
MTM0LjIyNjI4ODItMi1pd29uYS53aW5pYXJza2FAaW50ZWwuY29tLw0KDQpVbmZvcnR1bmF0ZWx5
LCBpdCBlbmRlZCB1cCBiZWluZyBzaW1wbGlmaWVkIHRvIGp1c3QgaW5jbHVkZSBhcmNoL3g4NiBk
aXJlY3RseS4NCg0KLUl3b25hDQoNCj4gDQo+IEd1ZW50ZXINCg0K

