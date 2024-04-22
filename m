Return-Path: <linux-kernel+bounces-153711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A9E8AD1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2BB1C20B90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D94153816;
	Mon, 22 Apr 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frRIkmvc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D21DDE9;
	Mon, 22 Apr 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803722; cv=fail; b=Hc52MBh9DvQJNwGnCOXrKlqmKN2f5YFzCcVJKLsZhPZWsA8Kr+6Xe8kUDcKVrXUQ7NETbvW913ylRLvV80vP1HER26L0A5bJ6gfdRvo49/vH0EcKwhGkPZ0JZJpMaOmWqzxlo3LDsJR2EHriLkNiT4iQe4GQAr7UXKUEnB4jUiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803722; c=relaxed/simple;
	bh=1JhmWi5eXvcwGyVT+TAsCYMe6+Q6k32MyCAEmvRpVjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e8yCL25IMTBREp3UXzXI/MAtcPwus1PiOveVkHtkyBLj/E/etoWT2vMqLr7+9zC1AF1IjdGWDMLlbYjcznXKxnQI73s6cHw9Racf2fGF2RxtEehLuU69KgdNzfb7iBWQBnjTaoBBwqSsRR8BZoEeN1Emda9jcfZ98n5gL3Xb+MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frRIkmvc; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713803721; x=1745339721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1JhmWi5eXvcwGyVT+TAsCYMe6+Q6k32MyCAEmvRpVjE=;
  b=frRIkmvc1heoc8UQy60u28T37Heptpw9H1Xc5GoctfFo9+FIu7FZPbrt
   mpo2Y0kM21s43GK+NszkLsjtbQnNvUPpL4XeAdVnBsIvfEVNn+jUtoHNJ
   eojKcy2Cq6+/fFL9g+h1xFWvTll03Hmmkapa9tGk1FMSMb/hrY2ETs1rY
   fRXExApiNPUkWvHI9tqnIO0t6nC7hXGqO0/CYFp2MYsCCQoIG3vRFZkc3
   mBFo70wVym98lbTi2nw3rd2HH54D32fEERPiZ8E8wfdj/Yfs6reg/Dx+n
   riDS9SqCn0vq2/Hf20P/iiN6X2j4ZqmksrBHOt+JqzzW66hO7mbvbgkOo
   w==;
X-CSE-ConnectionGUID: gZEjMMRrRJmY2uQA/SEHdQ==
X-CSE-MsgGUID: yCcPRroJRBmr4y9gYXVdNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9218177"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9218177"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 09:35:20 -0700
X-CSE-ConnectionGUID: klIrv8AgQ+OBBbwb/zMK2A==
X-CSE-MsgGUID: t1WkYsBmSoePpqroxNDnPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55281691"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 09:35:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 09:35:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 09:35:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 09:35:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 09:35:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsPGyDaw1kLEG4sc5qrpr/BRwaCNhueCPkxnxfzOXEt91hVOHWZsk8MZZ4usILpDTA6ZiqC2Ho1CwFouoOEzlNXGtYBSZwN0x5APMWKFrlW7ILe8z1sh3Klml6kYsUYqSkCZv0V0dl7vPp3CKBX7R85ixYG5TZpYZcRWhSBlpNMY8Cj8kZCmJP7E6HnCFfZvy7rDfm1AGcBgJ5XIrLxM/9NcmK8QQrUHnp/8sufgCJHN6LjAHCdhC/LeDTZ4DwkE1L2JnBZI23G/q529MIOba83OXiXREuBWU77PI7KLPck30UR1V+xNGMixe2VKdDjLdF7IELx1cHMP621IYfQXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JhmWi5eXvcwGyVT+TAsCYMe6+Q6k32MyCAEmvRpVjE=;
 b=Hn2+AVEdxrJu1O+613hbfgdCRYGICPlBR+SdptelvA9Q49rO9iIjnPEGkXkYvxp7RVDAs2J90W98Y/r2IXD4NKylEcu20anI+fOvl4PadihWL9itMi6XdHnDLm36E1njMypXa1nwILEcEzlCB1Gt7zARukEb76ftaM0/T+IZHALANLZkhdAFWpvBfHU4AXG+T8mwLtEjU+9fSGPRVz7CxBpig2VZLyjGOkq6k4VJOjqtDBsGoDzzTqdRaD/pMoNTD5Vez82a5CN3RWaZUmGfsB7KjmEI38eqouYht+hR81nsekFHQQeL4A7SGVDatnjLsm0v8+YLcCS6QuNb/XRpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6216.namprd11.prod.outlook.com (2603:10b6:8:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.12; Mon, 22 Apr 2024 16:35:16 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Mon, 22 Apr 2024
 16:35:16 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>
CC: "patches@lists.linux.dev" <patches@lists.linux.dev>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>
Subject: RE: [PATCH v3 50/74] x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
Thread-Topic: [PATCH v3 50/74] x86/cpu/vfm: Update
 drivers/hwmon/peci/cputemp.c
Thread-Index: AQHakEQwBnh1fvUg7kmXRylMjbAVKLFrfA0AgAABsLCAAA+0gIAAAzKggAJ4e4CAAAXEgIAAEDgAgAZleUA=
Date: Mon, 22 Apr 2024 16:35:16 +0000
Message-ID: <SJ1PR11MB60834BB7EF162E36DE58D29BFC122@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
	 <20240416212216.9605-1-tony.luck@intel.com>
	 <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
	 <SJ1PR11MB6083D0DFBC7DE286F986A453FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <8690bcea-3ff4-49f1-a671-16583b8d241e@roeck-us.net>
	 <SJ1PR11MB6083C8D12885057BF3A0A6AAFC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <7cb09d67409c94284928243d8ffb1f8a3128d849.camel@intel.com>
	 <f1d02e4f-a947-4af1-a7c0-9f7c12c57b3e@roeck-us.net>
 <f0b67e10b79e7e57846f792a0671434ce20c878a.camel@intel.com>
In-Reply-To: <f0b67e10b79e7e57846f792a0671434ce20c878a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6216:EE_
x-ms-office365-filtering-correlation-id: c84ad1c0-a20d-4e90-b6b3-08dc62ea3142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZCtDclk3MDZ1dWZTWHhWbURLenZUTzNENWVRMDRDSWJKNGpBNHZEUWU0UXR3?=
 =?utf-8?B?clMxUUxVMlpvM0hKTmtRdThncEhKdithcEU3UzdRY2tTQWtmd1VZZDVZZ0NN?=
 =?utf-8?B?YXJ0MFVCRndkRi90M3RVNVNCd2FiQTF2ait5MTJSaUJmOWZCUm5OK1E2RHpu?=
 =?utf-8?B?T052RU9EbW1XcFQ0YlVOdGtSeURtL2R0TERWOXMzWW41dDZoaEM5ZnpBMWsr?=
 =?utf-8?B?N0crMEtOZWJhNWM1bTNkNmdmU2VmMG1ObUdsdXZVUXhPS3BJU0xKc1gwTHVG?=
 =?utf-8?B?VTRlVnNlMjBNMzkzUmc5eUdXZDN4TVlUMWphK0F4NkFrUy83QTBldHo2RWI4?=
 =?utf-8?B?bU9xOEFoQnI1MzlESEE5cDljRDQzQk9OUDhmc3hra3FQaWI2SmhmTkFJUDl4?=
 =?utf-8?B?aTZBVkVDaVU1TGhEVlArRW1hZWcwQUlsTFQyTnpheC9JR01tN1ZMTFdXdThl?=
 =?utf-8?B?bXMxY1VYeVg1ajJZQWhYUGtMY3RPcXFsZy9IZTd0VzVTRFNCOFNpdkIxdzY4?=
 =?utf-8?B?QUVTSElXN3NIZlArcEdKdVJiOEg0M2RYdlNuY2JETGpvdE1DVDdoR2dUL0k5?=
 =?utf-8?B?ZnRaL1ZxY2tGVTdtQkZ1dnFieUNiMFBuRDlKWVA2VFFvckZaMHVzM1E5WXdV?=
 =?utf-8?B?YUcreFhlMkg4OUVYeGpDVkdEVGVCcGhuSnRyaGU5WUpqc0NsZDBNSlFVZG03?=
 =?utf-8?B?VldMVHoycDk4QzBVc2pJdTJlbWkraGFvWi9vemVacWt5K1dEdldpNWlSZGNH?=
 =?utf-8?B?UzJrREVCOGJwZXVLVU1tbCtUU3FVWHZoZXNTOXR0dEpadDRKeFlIME83eEU1?=
 =?utf-8?B?Y0RHdllaa2VGTWpDUHo2Uk81Y2FHM2k5enE4azJPSHFaSjVFMHBRYmZTTFZh?=
 =?utf-8?B?eVNUYU1qaDJTQXV4Q2JEYmhEdGNBaTBBN1lLL01Ecmx3L2cxUVpQRW9ZZytS?=
 =?utf-8?B?cEhvM2g5NFZaQnRVbmNjTmtCS2lxVDlwRnoxQ0szOTRxT0FjTENHcmhmb1RF?=
 =?utf-8?B?ZzM3M2FhSWdNbVVpUWEyeFR4ZkgvRms1RWovcVY3NWNFemxERlgwbFJQMzk0?=
 =?utf-8?B?M0plSTBuRDliL2FPc3lMbk03NUVPQ1ZYWFlYSHh2Uk11NGVqVXk5S0RjQmZT?=
 =?utf-8?B?c0Q2SWdoc1Z3MGdWTVlsUHpoQWtnTlhSeUN1UzNqSnJqVTRya1VHTE5kaUFw?=
 =?utf-8?B?TmpLdjFkNEtaRHk1R2dRMzhtc0tsQUYyNmxJWXh3cUdIOWVGRlRGdW1TQzM3?=
 =?utf-8?B?TFJTR0RwcEpMQ0lqN1ErK3NCbno4bmI2SWU3T1Njd0NCbDlyWlVFVzdPWk9s?=
 =?utf-8?B?V0FFRmJ1UnMwdHVaemZxQnovdlFTcXUwaWtQNWtNR0lwUVFBMW1RVWJKMDNH?=
 =?utf-8?B?cTI3UjBoMDdLTi9qVWVCWEVtZk45UE9DMHlHbU9nY1hWZkwrRlF5VW1Mc0F6?=
 =?utf-8?B?YytjalRjVU5Xb0YrZnhLOTVhblpyNzg1NCt4ZHViSHlOSlNpSWJJRkk4aHVX?=
 =?utf-8?B?VWNCb0c1aW1qZlUrMjlKbXJOQk5idzl2VnBlL2hhNWJ0cVJLQ1RPQ2tsd1FE?=
 =?utf-8?B?UXFldjZLcDJHQ25xVmRjVE5obG5kQ0Jzd2FnU3c4T1NLZXA2eGp3WTZObTRH?=
 =?utf-8?B?WlVqVjRBNkFCN3Yxdk93YnNLeGNJcDlEbmdiRWUzTHJhYm45dU1lTTZyUlVw?=
 =?utf-8?B?bW5pa21jK2lxby9HOUgyNTAraHM4b1RINkZuZTRJUnZDbmk5bi9jSDNiUWZN?=
 =?utf-8?B?bmFYNkhudCtycnRVblM1dDVsSXRRcDlIS1VCejZnQXJIWnh5Z3FqMkM0dUh6?=
 =?utf-8?B?c2d5K2NMRkwxREhUK0VPdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkdVWVZPdlYzaDJvbHltYW9NOWVZOVlUQjNDQVJ1VVR1ZUN4THZlZU1HdXo5?=
 =?utf-8?B?RjRiVEJBc0NOeFAwd2t5MDRQYzNrdnNJNG80K1RTRHAxbS9zRTJyNnRkdjR1?=
 =?utf-8?B?S2FXSzNha1ZXYUdnbXhyUjQ4UHh5QzB0c0h4UDBjTXF5RlJjMDNxSjh5ZWov?=
 =?utf-8?B?VlVoRkNCS0dVM0xqcWVta3BJTWk3bExYSk5GT0UvRVdUQitlTkxRR3d2NXBJ?=
 =?utf-8?B?TWEzMXBtdnZxMVhweFJadmJpWVFmc2xCSFNuUjZ0aXZBb2Y5ei9vd0NXNjNV?=
 =?utf-8?B?b2pGUVhJbGgxNXVHeVRFdmNWSUNERmdrTnRjNHJ6Um9VQnVXeWR1Y2NEblAz?=
 =?utf-8?B?Q2E0SjFzQ2d3RFRYSmtjUER6U1R0a1NhemY5RDZMWWdvSWl5R3dCalRYcWF2?=
 =?utf-8?B?YmQyYXVkYW9sM2gzOFlLVVMyN0Z1Q1kyRmtQUnZVVEFvQ1pLT2tnYWtBVjEx?=
 =?utf-8?B?ZXdqc3kxMEVmL1FQQm9FcjJmRkFSbXY4ellWWDY3cnFsUDl1QjNtcWZaZDZU?=
 =?utf-8?B?NVl3U0t3ZnhLbGdOenRMYTZONzBCQ2VxaGZZOGg5alQzWmRxU2N1NWhmelIr?=
 =?utf-8?B?SjY4Q1N3emZkdGJTeExpZ0lmcnczd3ZiWTI4U0tIUEhxTGNPVnI5MmpVbzNU?=
 =?utf-8?B?VmtzVW00TUI5cUlBblY1OFFROUFmS2JVb08vbEhlRUI3R0dFa0MzeEQxeklp?=
 =?utf-8?B?M2l5QXZBcDBHNVZ4OStHNmNMcWhEVlVpNnQ3ZE5hdEdxWFp0U0RsTWx1TEtX?=
 =?utf-8?B?Qk1SZ0QzSVhXT0x6WXdUaVF3cXpvRGd1VW85RlRTM3JCWXFVY3JXRmd0eHcr?=
 =?utf-8?B?Q1JSbXZJMXlsaDNYRlNjMmE2VU43M1BhUVZjMm1YNmFBcTEvL0NlOUtFRDRz?=
 =?utf-8?B?YnExUDZZZUY4T0FUdVBDQ2NJS05aOW9DcnVpZStNRFBrMUlPS2JaYmJvUUpC?=
 =?utf-8?B?djE4OFNsdXdNRzVObjJZMHNBODlRSU9sdldPOE9QNjZPU0Q0OGVkWllKR1R6?=
 =?utf-8?B?QlFUbkE4dDluajJNOTBhblYxNmhnMUxGTEp6QlIyR21BbmVPeVpXZ1pSUTJZ?=
 =?utf-8?B?Qkh4UmVwQzhHQ0pCbHFzRTRCWC9tOHdIbmJ0ZWlibE42c1FocW1DdlNBUE9k?=
 =?utf-8?B?NEFqY2Z5M0p5ZGZVU1dMcTFyTmtuQmhsVXY5dG8yWmFQaWhGZlBKSXQ3bm1o?=
 =?utf-8?B?U1ZoNGZGV3d4ZXlBdjlrQ2EzT0N1TWJBeTIxWnljTzdCTjJDSXZNS1BPK0Uw?=
 =?utf-8?B?SDdYTU10Vy9Ub3B0djE1RmwwQlIrb0xkcFVETXVhZEIxMTZ3amJUYzNPNmxE?=
 =?utf-8?B?WkYwREFqSWJmdUhRVm84bXd2aWxlR3RjTDg2U0hreEcxaWwyZGVjSUhwdFE5?=
 =?utf-8?B?SW1KTkJIWVpvL2VHN1VKVnhsamJRUStEdGVCSS81aXVWbU9mYW50RllhT3Nz?=
 =?utf-8?B?WGhRb2tkMTlpdEt1a0VZVkgvYnkyWjRKRzBUc3d4Zm84cDI4M2VaajBDZzFS?=
 =?utf-8?B?WWtwaDh0OGVGVUhsUUdjcTFXeUszNThqYWw1eU9QTW55MEordmkxZFhSQXlD?=
 =?utf-8?B?cWE3SlN0cXJIZngxZWExSmp3ZzF1ZXpMeWR0eXp3Y3ZwRDhhRndna3NuVGJp?=
 =?utf-8?B?eFRUL0cvTmdBT1BJNmJrVWZyMFJhVFp3MEF6akRiMUt0WS9nUDFFdjB0SW03?=
 =?utf-8?B?M0FNOXIyU2ozSEtIU2p4c3VBR1VycXc5VGp6b3RjWmxNUkZjYjNUUFMwSXJE?=
 =?utf-8?B?ZE5GQVlLT0FOeXFtNm5zZDJKb3hDRDVlNDJJUGNyNlNRQ0FFU3k0YUMyWGlz?=
 =?utf-8?B?YmdzNWJobGpZMXlHSElyVmJYSk5MWWVub1craHhDdjRMeExHNVRSTFJ3T1Fq?=
 =?utf-8?B?bWF5NTRqYmpBU3VENG1oYzZSeEpmV3R1UDdzUWVRNW16dWJYQk1SaHM5NDNz?=
 =?utf-8?B?N3JZQ2dwd0U1S3VPcGZMdi8xQWgrb2lGZEo1RUxTenV3WkxmTVVBVitPaG5J?=
 =?utf-8?B?bjhGYXFMVzZtVXhLN1o1eVJFRUoyVnFua0V3bjM3V3JRa1V3TVhNK1dHT0Fj?=
 =?utf-8?B?MnNaQml4Y3VKdE5QblFlSXl3WWhuYVBpVEJFYWxMYnE0bjhGTytsTXI0d3Fl?=
 =?utf-8?Q?gVGmsD3LhRz7zuPWRs+uOKrCx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84ad1c0-a20d-4e90-b6b3-08dc62ea3142
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 16:35:16.7752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XErioT1GayChDdJxH9bv45Or0oSqmY5i3h/TPhWdz/xxa07nSs+nyL/F1vRzq59bZkFi/9n37zONzWrqGa+eoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6216
X-OriginatorOrg: intel.com

PiA+ID4gPiA+IElmIHRoZSBDUFUgZGVmaW5lcyBhbmQgdGhlIG5ldyBtYWNybyBhcmUgdG8gYmUg
a2VwdCBpbiBhcmNoaXRlY3R1cmUNCj4gPiA+ID4gPiBjb2RlLA0KPiA+ID4gPiA+IG1heWJlIGlu
Y2x1ZGUgYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1X2RldmljZV9pZC5oIGZyb20NCj4gPiA+ID4g
PiBsaW51eC9wZWNpLmNwdS5oLg0KPiA+ID4gPiA+IFRoYXQgd291bGQgbm90IGJlIHdvcnNlIHRo
YW4gdG9kYXkncyBpbmNsdWRlIG9mIGludGVsLWZhbWlseS5oLg0KPiA+ID4gPg0KPiA+ID4gPiBH
dWVudGVyLA0KPiA+ID4gPg0KPiA+ID4gPiBMb29rcyBsaWtlIEkgZGlkIHRoYXQgdG8gcmVzb2x2
ZSBvbmUgb2YgdGhlIG90aGVyIHBlY2kgcHJvYmxlbXMuIEJlY2F1c2UgSQ0KPiA+ID4gPiBhbHJl
YWR5IGhhdmU6DQo+ID4gPiA+DQo+ID4gPiA+ICNpbmNsdWRlICIuLi8uLi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9jcHVfZGV2aWNlX2lkLmgiDQo+ID4gPiA+ICNpbmNsdWRlICIuLi8uLi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9pbnRlbC1mYW1pbHkuaCINCj4gPiA+ID4NCj4gPiA+ID4gaW4gPGxpbnV4
L3BlY2lfY3B1Lmg+DQo+ID4gPiA+DQo+ID4gPiA+IFNpbXBseSBkZWxldGluZyB0aGUgaW5jbHVk
ZSBmcm9tIGNwdXRlbXAuYyBidWlsZHMgT0sgaW4gdGhlDQo+ID4gPiA+IGNvbnRleHQgb2YgYWxs
IHRoZSBvdGhlciBjaGFuZ2VzIGluIG15IHBhdGNoIHNlcmllcy4NCj4gPiA+DQo+ID4gPiBIaSBU
b255LA0KPiA+ID4NCj4gPiA+IEl0IHdvbid0IGJ1aWxkIG9uIG5vbi14ODYsIGFzIGNwdV9kZXZp
Y2VfaWQuaCBpbmNsdWRlcyA8YXNtL2ludGVsLWZhbWlseS5oPi4NCj4gPiA+IEkgdGhpbmsgdGhl
IHNpbXBsZXN0IHdheSB0byBzb2x2ZSB0aGUgaXNzdWUgaXMgdG8gcHJvdmlkZSBhIGNvcHkgb2Yg
VkZNXyoNCj4gPiA+IG1hY3Jvcw0KPiA+ID4gYW5kIFg4Nl9WRU5ET1JfSU5URUwgaW4gaW5jbHVk
ZS9saW51eC9wZWNpLWNwdS5oLg0KPiA+ID4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlIHByb3BlciBm
aXggd291bGQgcmVhbGx5IGJlIHRvIG1vdmUgdGhlIGluY2x1ZGUgZmlsZXMgdG8gYQ0KPiA+IGdl
bmVyaWMgZGlyZWN0b3J5LCBzdWNoIGFzIGluY2x1ZGUvbGludXgveDg2LyBvciBpbmNsdWRlL2xp
bnV4L2NwdS94ODYvLg0KPiA+IEFmdGVyIGFsbCwgdGhleSBfYXJlXyBub3cgbmVlZGVkIGluIG5v
bi1JbnRlbCBjb2RlLg0KPg0KPiBZZWFoLCB0aGF0IHdhcyB0aGUgaW5pdGlhbCBwcm9wb3NhbDoN
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDgwMzExMzEzNC4yMjYyODgyLTIt
aXdvbmEud2luaWFyc2thQGludGVsLmNvbS8NCj4NCj4gVW5mb3J0dW5hdGVseSwgaXQgZW5kZWQg
dXAgYmVpbmcgc2ltcGxpZmllZCB0byBqdXN0IGluY2x1ZGUgYXJjaC94ODYgZGlyZWN0bHkuDQoN
ClJlYWRpbmcgdGhyb3VnaCB0aGF0IG90aGVyIHRocmVhZCAoSXdvbmE6IHRoYW5rcyBmb3IgdGhl
IGxpbmspIGl0IHNlZW1zIHRoYXQgbW92aW5nDQp0aGUgeDg2IGluY2x1ZGUgZmlsZXMgb3V0IG9m
IGFyY2gveDg2L2luY2x1ZGUvYXNtIGhhcyBiZWVuIHNvdW5kbHkgcmVqZWN0ZWQuDQoNCkknbSBn
b2luZyB0byB0YWtlIEl3b25hJ3MgYWR2aWNlIGFib3ZlIGFuZCBjb3B5IHRoZSBWRk1fKiBtYWNy
b3MuDQoNCi1Ub255DQo=

