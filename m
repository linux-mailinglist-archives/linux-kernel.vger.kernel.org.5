Return-Path: <linux-kernel+bounces-137738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1EA89E680
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EFC1F221CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39D71591EF;
	Tue,  9 Apr 2024 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AO95fNXE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B415921D;
	Tue,  9 Apr 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706985; cv=fail; b=ROznL8Jv3kgHnu+OkkY9KMgGpsTgqppf58sTM/Eqh7jq/QLs9ZckSd25GWaqL4kI0JIHmvj/tFdNo4/uEu6MrpRwGg9bSM4WE+bySie3m7X0CvMm0+P8QskRQ+OPYxavzLtRB+Qmz49nosiUu28sO0HEvanh9aEfR4gaLWlgVvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706985; c=relaxed/simple;
	bh=W1AP2WXZ5HjUacA8qESDhQJWZADiWVxalivAUaHFMPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EM0Tz4LyNJ+DfEXUzfpYCXHEIAStx7m5HQrI4Sj332Q6PJ7pTQryat/dm5rNGvw1VJjgPrrUv1VkQgtKUZ3fG+s0HnEmV216/G09JubcaVLwJlDvtB7gw1giGVB3yPvtl1Pceh16fKhUT6zCKAa8SzU7SoGkzL84b3g06RkZ2n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AO95fNXE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706983; x=1744242983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W1AP2WXZ5HjUacA8qESDhQJWZADiWVxalivAUaHFMPw=;
  b=AO95fNXE5X7g/2MR3xdEJxzezZcYuBTY7Dl4MIzoJjRRAVrvUs3+HpVc
   hLuOI89hTl1TN4bQSPfMU92JuHO6N5mNv0N0MX+hM0lm7QeRI3uXvGbsM
   1FSncwsAClHmnHIMLQGIqQhJZC6ixDkReGydl95YhEOfFYkiwmrGPvNeQ
   8EO0YgRGMdQeF25dJv6R+h6zhmHnCuo+hTa5iSi87QxM5puVyIl0yDY4i
   9aIGxXKUvLV4oPG7SYXPRF6vJfGf/qVtjJptCByOvvVH6K5AH0H7sAe1f
   1YJKFqpVruCz7oBhMOBS3C+1EEHNPs7k+uSzTa6FImefySkR855QLCAAs
   A==;
X-CSE-ConnectionGUID: iqvd1TqiRQuYhEk6clPAhQ==
X-CSE-MsgGUID: 9mowoJFQTBqdI5MTp137AQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8227395"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8227395"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:56:23 -0700
X-CSE-ConnectionGUID: 6bAp+b1jTuuNFgIsQZwrtw==
X-CSE-MsgGUID: sWUN2RvmSgKl5UNqa236bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20411807"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:56:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:56:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:56:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:56:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:56:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWVzkXlBCnPhaHgRzkrx8CKPDZ+fUsbPCQMC4tAcFSw304VtB3tOoCYX12fP9hTBdiK4l1QuGnILIDJguRxpOXdZMl+vFWw1uPz69eUFRiI+XNLB82SeMcGgVY+qavLNI0tDGW8fb/nrQNRNKC/Cqd+bg0LoLwDCbfuP56mORpopl4fNIlr4YU1n82TTrA3oMto5VRpGmImVKkohKuZb0ObGfIdquJSsTCK7o2HfGmRIFwFiF+CdK+hd7UJQIF2amsFZcX5jGComrg3W0NQZCb5c9JyANmB/Xbo4eBmiU2lC6u6vwrCXkzYtGdnnjWNKhMFE6SSYdQpcQNQbBAXWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1AP2WXZ5HjUacA8qESDhQJWZADiWVxalivAUaHFMPw=;
 b=Vn4nUUUXkrjuQ2ucOfcCWT8EtaswbXGYL4bDGGLYX/vYmwFiIfN+eHiAtkQKMY4e4RbOljBUBm8Lv656WnDLaA42qce0CjF02ZdFX3UxbvAoeV3bCGkK0PCKFvHHOmpgc0Ym2AaYKmZJRrtXRc/WEERHCVR3P31WNwBHzK/mL+Z7YREuiNm1RIqlIlmqPtFkVbX4TnDRHRnrf3kYZLWbayyppqZRm3s4tTqAQM6/Dteu4wN6F2MKTx71aWuQI6HgIJfYZOAfIho431MHR5p2txAXo915nbr8XkT+bLuqd28QIo3Ob2dswz5btaN/KIkH7NTD7VMbPnU35qjUiFRtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 9 Apr
 2024 23:56:19 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b%7]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 23:56:19 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Rix, Tom" <trix@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "russ.weight@linux.dev" <russ.weight@linux.dev>, "Pagani, Marco"
	<marpagan@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 3/9] fpga: dfl: migrate AFU MMIO region management
 driver to dfl_feature_dev_data
Thread-Topic: [RFC PATCH v2 3/9] fpga: dfl: migrate AFU MMIO region management
 driver to dfl_feature_dev_data
Thread-Index: AQHaiteNpHD83WeT8kCnMCjh3oqZa7FgnVaA
Date: Tue, 9 Apr 2024 23:56:19 +0000
Message-ID: <1aa50550adfb3917e94dd4f553ee88005133cd15.camel@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
	 <20240409233942.828440-4-peter.colberg@intel.com>
In-Reply-To: <20240409233942.828440-4-peter.colberg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|CO1PR11MB4929:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DNLBgQDQP3pqMNFAFa1IAc43eXBPCY8PwCgC6fzGM/jSFmXebTZtvTmqA4xjE84O/XCKf+8hOAq97RN3Vj7rJtwXJvBO3V1JgwsfVKw5cSAqhulks8OybzD53UZlzF4Ar17e+iPxpFb1f/+Q23RAmbkMd+QB7TRFUjVCBGHou33ba/39YBzO0P+7cFMz/+qoue6Qe2QashRAC9GNmR0q/dZCMtOjjG0bK6uW64HLeNMkviqfdrUIXw+fcKBgLZbMhLr1QWWrchHfOm5TSGNX84G9eXxBjUQn/SFtQ7BRkQ4uJ3Pu50qgS6iLgOoO0SXqmwCnFHpohoGmY1r4W+1nrwyZOgh7RwB2DUCwEUk33woqHUHtfgUhsapbdAxWMVu/MIPGQySpyKx2C5J6vGLH/p+Z+KZXgQiPV+UVBWoOg/r0CWly12c7wUY57z7dDGyTcqFCmx7Z884A5t0CI46tH9RZTgEoHfRm17fCdjgxsyMuRCKFN+ZbsovLbgp+y4NQhCaja2ikT9oWSkPwkXFX9jhr5VvSIo3VBfLmlqYFBXl8FmGDrUeVCxFwqsWKRvHjY/+tvRK1DBGlfqxfH2hdVmVq9LpGyW4LhYttEYyUXjg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTB2RGxLVnE1RkRSYmJLNVEvQy8zUUZ4a2Y0TnJPREx0aUh3eEEzbVd5UG9H?=
 =?utf-8?B?QkhTdXpxMlgxWmJMdUd3YnhTZFBxS2gyN2xYV1NzMVNId2xxem1YSldsa2V5?=
 =?utf-8?B?bmp6WDJnRVdMZ2t2Z2JPOXlhY1FCaEpvaVZEWGRKd1pzUnFHYU5vTWJ4S09v?=
 =?utf-8?B?bkFLVW1yS0dOc1g1UGhiY1ZScnFtR2t0UXdtWk05OTRFWUxOSE5MeVFWYnhO?=
 =?utf-8?B?THFaS2RYSkdYMzVCQmQ1aUdzUlJtV05YUEcwR1ZzY3J3a1hCR1lYQ2k3SSsr?=
 =?utf-8?B?b0FpUFppNzNlTHR2M2Fta0w4aGlMVXJRbEFsbS9JZEhtVDY4bnRJZUFvYkU3?=
 =?utf-8?B?eFZmcWRZV0NNTTFOU3d5cE1qNGNHTTlrK1BmY1M4QlExb1lHODZTejUyL0px?=
 =?utf-8?B?VU9NcUtrMDYwdE1lQkFaQ2ZTbi9MRHRlUE1aeC9ZV1RhbnNzNWRib2VUS3NV?=
 =?utf-8?B?SGNUWTJsZ1ZIWURQSFdEb3lGd213QVk2K1ZJclJDS1pEUWNBTmNpVElScWxC?=
 =?utf-8?B?ZXpIWG9PeDVTMUYvWGxpa2xLWnVHdG1mMzZSVnpvbzc4aCtJVXZVMDlwTFlD?=
 =?utf-8?B?RFFzOHI2Y0prZHNRMWV2SHRSZmFLcExIVS9uZWRNdVcwQXJtbzhrL3JmWjFl?=
 =?utf-8?B?WnhZcExlSFVIVGM3eUs0aG9la3JSbjNsYXh4SzNnZHhtdzF1bjBoRlVGdDha?=
 =?utf-8?B?WHM5YVVjcXNuS05hT082WHRmYjJCOWtEZ0JjZTZPOHFJcGNxcU94Wmxwem5G?=
 =?utf-8?B?RUlpc3NBQUw3SXppRStIN00rMDRvSUd5WlN2bnB4SzJ2Sk1TKzNFbDhWeUdF?=
 =?utf-8?B?S1lKSHIxL1ZRcFdYM0RoSmc0NEhPaXBKQVhXTGtFRG5Gc2xvdkgyL1FONXZ3?=
 =?utf-8?B?QzkwOWJpczZTd2RrZnk1MFdVc096c0xiLzBoemQ2ZjlOVTVNNUVDSFFvcjdK?=
 =?utf-8?B?ZWVhOUlGZGM5SnhVeERNTnc3T1NCNzR0dnNTckdkdy9XOEZTQVY5Q0Zxbzl2?=
 =?utf-8?B?UkcxZEJmR2dWSndIc2dGVVcwajFpZnJNaEkvcDBMbHBkZ1p1N05UMzhvSDJ3?=
 =?utf-8?B?cHlNNXE4OHY4L0E4NnNjWWVhRWJIczJjVDhtdXBkZkd5SlRmREk0N0RDbjBv?=
 =?utf-8?B?MlRKZDNiRWZBYUZWZGh4QVNhaEQrdDZHdGNJQmhONWg1eHJmbFVzMzJGVUlN?=
 =?utf-8?B?UFFzNmV6M3gxcXM0K1RqMnJkSmEyTkp3aGZOR0t3Y09LT2ErZGNyMmtaNUlU?=
 =?utf-8?B?aTR2VnJJRmJHeWx3dmhOa2VrTjVNSkdYcHhqbzFVQXVhQ3ZkWHF5dmhCdlZG?=
 =?utf-8?B?by9vU1ZxYVY1QVFvQUMvamhGZnV1bWxqemdzM3BnRThJdjNpQ2lTRU9jN2F1?=
 =?utf-8?B?NVBLRUxRU0JLbTNINUhrUXRqaThkT1UvVWpSNWt2eEhudG9GOUsvaE5QZ2hu?=
 =?utf-8?B?UjV6c3NjcnhCdEZ1U3RLY3F1R2ZCdlhmR3U1ZjE2UlIydWRHa3dHaEtTRStk?=
 =?utf-8?B?QUlNV2NINWZYUGVLejZLeUNUV0lNQmZnYVFGUkVWd2NUSHJQRVB1VU9zRmo0?=
 =?utf-8?B?WldGSm1kTVBqZ1Y2RXNIMGVtWFY2OTlhSThQUzA3azkxbFlBd3RVbUVSajI4?=
 =?utf-8?B?ZHVyUHc5Y0xEVGx1ZHFIcitWMk1ZenVYc0Y3Z0srOVREcGNFYVhkK0hzbTU2?=
 =?utf-8?B?TzQyelZpbXk0OTErYXI4M0RzNVBkQysvZndTWFRoLytDY05hV1BYU2NoZWJi?=
 =?utf-8?B?NC9FRGN0NzA3U2Rwc2dhOXJaZzAyR2JxRE40OWI5VWJNYkFVOGpGaGc5Y1ky?=
 =?utf-8?B?dEFvSXFubGNKVll5TWdKYWUwbGpJMzV4WjNWdll1TzI4eFFJRzFUZ1VEcVZp?=
 =?utf-8?B?R0Y1WmVOU0t0VkZVbHFMY2twQ1E5dzRVMm9PaWEybWR2emhkOHZSajdpWnYz?=
 =?utf-8?B?b1NCOXBkSHRpTXV0KzMwOTJPdGxzNUlaZFFMWjBySnJ3QzlIVFpGSS80T0RZ?=
 =?utf-8?B?WmhLckpHcFoxSG10aWRrOWQ5RWtha1RnMGYwL2lGN25TSWFFMXVscEQxaFJw?=
 =?utf-8?B?Mml2a0FDSkhjSnRTTVcrZEVFU1ZHd0R5bDc0djJFdkIvaWVrdE9rQXFkdFdS?=
 =?utf-8?B?alBjMCs1NnVKK1N6NW8xMGR1MGtpRHR3c1JXS3ovdlhzcGFNRlk2RUVxTk43?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1633CE5623453A45888617F6DDD406F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072e5403-4c66-4e2f-149c-08dc58f0a702
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 23:56:19.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Odj82xFKJbuY9S+NofWYwoC6BSQPk7DgGol0KGp5+xLpmpVWbHNw/Kp0V0MQco0kf9de4dusoEKzZ4mSlDXkyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTA5IGF0IDE5OjM5IC0wNDAwLCBQZXRlciBDb2xiZXJnIHdyb3RlOg0K
PiBUaGlzIGNoYW5nZSBzZXBhcmF0ZXMgb3V0IG1vc3Qgb2YgdGhlIHN5bWJvbCBuYW1lIGNoYW5n
ZXMgcmVxdWlyZWQgYnkgdGhpcw0KPiBwYXRjaCBzZXJpZXMgZm9yIHRoZSBmaWxlOiBkcml2ZXJz
L2ZwZ2EvZGZsLWFmdS1yZWdpb24uYy4gVGhpcyBpcyBkb25lIHRvDQo+IHNwbGl0IGEgc2luZ2xl
IG1vbm9saXRoaWMgY2hhbmdlIGludG8gbXVsdGlwbGUsIHNtYWxsZXIgcGF0Y2hlcyBhdCB0aGUN
Cj4gcmVxdWVzdCBvZiB0aGUgbWFpbnRhaW5lci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBldGVy
IENvbGJlcmcgPHBldGVyLmNvbGJlcmdAaW50ZWwuY29tPg0KPiAtLS0NCj4gdjI6DQo+IC0gU3Bs
aXQgbW9ub2xpdGhpYyBwYXRjaCBpbnRvIHNlcmllcyBhdCByZXF1ZXN0IG9mIG1haW50YWluZXIN
Cj4gLS0tDQo+ICBkcml2ZXJzL2ZwZ2EvZGZsLWFmdS1yZWdpb24uYyB8IDUxICsrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9u
cygrKSwgMjUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2Rm
bC1hZnUtcmVnaW9uLmMgYi9kcml2ZXJzL2ZwZ2EvZGZsLWFmdS1yZWdpb24uYw0KPiBpbmRleCAy
ZTdiNDE2Mjk0MDYuLmIxMWE1YjIxZTY2NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9mcGdhL2Rm
bC1hZnUtcmVnaW9uLmMNCj4gKysrIGIvZHJpdmVycy9mcGdhL2RmbC1hZnUtcmVnaW9uLmMNCj4g
QEAgLTEyLDExICsxMiwxMSBAQA0KPiAgDQo+ICAvKioNCj4gICAqIGFmdV9tbWlvX3JlZ2lvbl9p
bml0IC0gaW5pdCBmdW5jdGlvbiBmb3IgYWZ1IG1taW8gcmVnaW9uIHN1cHBvcnQNCj4gLSAqIEBw
ZGF0YTogYWZ1IHBsYXRmb3JtIGRldmljZSdzIHBkYXRhLg0KPiArICogQGZkYXRhOiBhZnUgZmVh
dHVyZSBkZXYgZGF0YQ0KPiAgICovDQo+IC12b2lkIGFmdV9tbWlvX3JlZ2lvbl9pbml0KHN0cnVj
dCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSkNCj4gK3ZvaWQgYWZ1X21taW9fcmVn
aW9uX2luaXQoc3RydWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSkNCj4gIHsNCj4gLQlz
dHJ1Y3QgZGZsX2FmdSAqYWZ1ID0gZGZsX2ZwZ2FfcGRhdGFfZ2V0X3ByaXZhdGUocGRhdGEpOw0K
PiArCXN0cnVjdCBkZmxfYWZ1ICphZnUgPSBkZmxfZnBnYV9mZGF0YV9nZXRfcHJpdmF0ZShmZGF0
YSk7DQo+ICANCj4gIAlJTklUX0xJU1RfSEVBRCgmYWZ1LT5yZWdpb25zKTsNCj4gIH0NCj4gQEAg
LTM5LDcgKzM5LDcgQEAgc3RhdGljIHN0cnVjdCBkZmxfYWZ1X21taW9fcmVnaW9uICpnZXRfcmVn
aW9uX2J5X2luZGV4KHN0cnVjdCBkZmxfYWZ1ICphZnUsDQo+ICAvKioNCj4gICAqIGFmdV9tbWlv
X3JlZ2lvbl9hZGQgLSBhZGQgYSBtbWlvIHJlZ2lvbiB0byBnaXZlbiBmZWF0dXJlIGRldi4NCj4g
ICAqDQo+IC0gKiBAcGRhdGE6IGFmdSBwbGF0Zm9ybSBkZXZpY2UncyBwZGF0YS4NCj4gKyAqIEBm
ZGF0YTogYWZ1IGZlYXR1cmUgZGV2IGRhdGENCj4gICAqIEByZWdpb25faW5kZXg6IHJlZ2lvbiBp
bmRleC4NCj4gICAqIEByZWdpb25fc2l6ZTogcmVnaW9uIHNpemUuDQo+ICAgKiBAcGh5czogcmVn
aW9uJ3MgcGh5c2ljYWwgYWRkcmVzcyBvZiB0aGlzIHJlZ2lvbi4NCj4gQEAgLTQ3LDE0ICs0Nywx
NSBAQCBzdGF0aWMgc3RydWN0IGRmbF9hZnVfbW1pb19yZWdpb24gKmdldF9yZWdpb25fYnlfaW5k
ZXgoc3RydWN0IGRmbF9hZnUgKmFmdSwNCj4gICAqDQo+ICAgKiBSZXR1cm46IDAgb24gc3VjY2Vz
cywgbmVnYXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2UuDQo+ICAgKi8NCj4gLWludCBhZnVfbW1p
b19yZWdpb25fYWRkKHN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSwNCj4g
K2ludCBhZnVfbW1pb19yZWdpb25fYWRkKHN0cnVjdCBkZmxfZmVhdHVyZV9kZXZfZGF0YSAqZmRh
dGEsDQo+ICAJCQl1MzIgcmVnaW9uX2luZGV4LCB1NjQgcmVnaW9uX3NpemUsIHU2NCBwaHlzLCB1
MzIgZmxhZ3MpDQo+ICB7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJmZkYXRhLT5kZXYtPmRl
djsNCj4gIAlzdHJ1Y3QgZGZsX2FmdV9tbWlvX3JlZ2lvbiAqcmVnaW9uOw0KPiAgCXN0cnVjdCBk
ZmxfYWZ1ICphZnU7DQo+ICAJaW50IHJldCA9IDA7DQo+ICANCj4gLQlyZWdpb24gPSBkZXZtX2t6
YWxsb2MoJnBkYXRhLT5kZXYtPmRldiwgc2l6ZW9mKCpyZWdpb24pLCBHRlBfS0VSTkVMKTsNCj4g
KwlyZWdpb24gPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnJlZ2lvbiksIEdGUF9LRVJORUwp
Ow0KPiAgCWlmICghcmVnaW9uKQ0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gIA0KPiBAQCAtNjMs
MTMgKzY0LDEzIEBAIGludCBhZnVfbW1pb19yZWdpb25fYWRkKHN0cnVjdCBkZmxfZmVhdHVyZV9w
bGF0Zm9ybV9kYXRhICpwZGF0YSwNCj4gIAlyZWdpb24tPnBoeXMgPSBwaHlzOw0KPiAgCXJlZ2lv
bi0+ZmxhZ3MgPSBmbGFnczsNCj4gIA0KPiAtCW11dGV4X2xvY2soJnBkYXRhLT5sb2NrKTsNCj4g
KwltdXRleF9sb2NrKCZmZGF0YS0+bG9jayk7DQo+ICANCj4gLQlhZnUgPSBkZmxfZnBnYV9wZGF0
YV9nZXRfcHJpdmF0ZShwZGF0YSk7DQo+ICsJYWZ1ID0gZGZsX2ZwZ2FfZmRhdGFfZ2V0X3ByaXZh
dGUoZmRhdGEpOw0KPiAgDQo+ICAJLyogY2hlY2sgaWYgQGluZGV4IGFscmVhZHkgZXhpc3RzICov
DQo+ICAJaWYgKGdldF9yZWdpb25fYnlfaW5kZXgoYWZ1LCByZWdpb25faW5kZXgpKSB7DQo+IC0J
CW11dGV4X3VubG9jaygmcGRhdGEtPmxvY2spOw0KPiArCQltdXRleF91bmxvY2soJmZkYXRhLT5s
b2NrKTsNCj4gIAkJcmV0ID0gLUVFWElTVDsNCj4gIAkJZ290byBleGl0Ow0KPiAgCX0NCj4gQEAg
LTgwLDM3ICs4MSwzNyBAQCBpbnQgYWZ1X21taW9fcmVnaW9uX2FkZChzdHJ1Y3QgZGZsX2ZlYXR1
cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEsDQo+ICANCj4gIAlhZnUtPnJlZ2lvbl9jdXJfb2Zmc2V0
ICs9IHJlZ2lvbl9zaXplOw0KPiAgCWFmdS0+bnVtX3JlZ2lvbnMrKzsNCj4gLQltdXRleF91bmxv
Y2soJnBkYXRhLT5sb2NrKTsNCj4gKwltdXRleF91bmxvY2soJmZkYXRhLT5sb2NrKTsNCj4gIA0K
PiAgCXJldHVybiAwOw0KPiAgDQo+ICBleGl0Og0KPiAtCWRldm1fa2ZyZWUoJnBkYXRhLT5kZXYt
PmRldiwgcmVnaW9uKTsNCj4gKwlkZXZtX2tmcmVlKGRldiwgcmVnaW9uKTsNCg0KQW4gaW50ZXJu
YWwgcmV2aWV3ZXIgY29tbWVudGVkIHRoYXQgY2FsbGluZyBkZXZtX2tmcmVlKCkgaW4gYWxtb3N0
IGFsbA0KY2FzZXMgc2hvd3MgYSBtaXN1bmRlcnN0YW5kaW5nIG9mIG9iamVjdCBsaWZldGltZSBh
bmQgbWF5IHVudmVpbCBidWdzLg0KVGhleSBzdWdnZXN0ZWQgdG8gZWl0aGVyIGRyb3AgdGhlIGV4
cGxpY2l0IGRldm1fa2ZyZWUoKSwgb3IgbW92ZSBmcm9tDQpkZXZtXyooKSB0byBwbGFpbiBhbGxv
Y2F0aW9uLg0KDQpJIGNvdWxkIG5vdCBmaW5kIHNwZWNpZmljIGRvY3VtZW50YXRpb24gb24gdGhl
IHJlY29tbWVuZGVkIHVzZSBjYXNlcw0KZm9yIGRldm1fa2ZyZWUoKSB0byBpbW1lZGlhdGVseSBm
cmVlIGEgcmVzb3VyY2Ugb24gZXJyb3IsIGJ1dCB0aGUNCmRlc2NyaXB0aW9uIG9mIGRldnJlcyBn
cm91cHMgYWR2aXNlcyB0aGF0IGV4cGxpY2l0IGZyZWVpbmcgdXNpbmcNCmRldnJlc19yZWxlYXNl
X2dyb3VwKCkgaXMgdXN1YWxseSB1c2VmdWwgaW4gbWlkbGF5ZXIgZHJpdmVycyB3aGVyZQ0KaW50
ZXJmYWNlIGZ1bmN0aW9ucyBzaG91bGQgbm90IGhhdmUgc2lkZSBlZmZlY3RzIFsxXS4NCg0KV2hp
Y2ggaW1wbGVtZW50YXRpb24gd291bGQgeW91IHByZWZlciBhbmQgd2h5PyBEcm9wcGluZyBkZXZt
X2tmcmVlKCksDQptb3ZpbmcgdG8gcGxhaW4gYWxsb2NhdGlvbiwgb3IgbGVhdmluZyBldmVyeXRo
aW5nIGFzIGlzPw0KDQpbMV3CoGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL2RyaXZlci1hcGkvZHJp
dmVyLW1vZGVsL2RldnJlcy5odG1sI2RldnJlcy1ncm91cCANCg0KVGhhbmtzLA0KUGV0ZXINCg0K
PiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gIC8qKg0KPiAgICogYWZ1X21taW9fcmVnaW9u
X2Rlc3Ryb3kgLSBkZXN0cm95IGFsbCBtbWlvIHJlZ2lvbnMgdW5kZXIgZ2l2ZW4gZmVhdHVyZSBk
ZXYuDQo+IC0gKiBAcGRhdGE6IGFmdSBwbGF0Zm9ybSBkZXZpY2UncyBwZGF0YS4NCj4gKyAqIEBm
ZGF0YTogYWZ1IGZlYXR1cmUgZGV2IGRhdGENCj4gICAqLw0KPiAtdm9pZCBhZnVfbW1pb19yZWdp
b25fZGVzdHJveShzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEpDQo+ICt2
b2lkIGFmdV9tbWlvX3JlZ2lvbl9kZXN0cm95KHN0cnVjdCBkZmxfZmVhdHVyZV9kZXZfZGF0YSAq
ZmRhdGEpDQo+ICB7DQo+IC0Jc3RydWN0IGRmbF9hZnUgKmFmdSA9IGRmbF9mcGdhX3BkYXRhX2dl
dF9wcml2YXRlKHBkYXRhKTsNCj4gKwlzdHJ1Y3QgZGZsX2FmdSAqYWZ1ID0gZGZsX2ZwZ2FfZmRh
dGFfZ2V0X3ByaXZhdGUoZmRhdGEpOw0KPiAgCXN0cnVjdCBkZmxfYWZ1X21taW9fcmVnaW9uICp0
bXAsICpyZWdpb247DQo+ICANCj4gIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVnaW9uLCB0
bXAsICZhZnUtPnJlZ2lvbnMsIG5vZGUpDQo+IC0JCWRldm1fa2ZyZWUoJnBkYXRhLT5kZXYtPmRl
diwgcmVnaW9uKTsNCj4gKwkJZGV2bV9rZnJlZSgmZmRhdGEtPmRldi0+ZGV2LCByZWdpb24pOw0K
PiAgfQ0KPiAgDQo+ICAvKioNCj4gICAqIGFmdV9tbWlvX3JlZ2lvbl9nZXRfYnlfaW5kZXggLSBm
aW5kIGFuIGFmdSByZWdpb24gYnkgaW5kZXguDQo+IC0gKiBAcGRhdGE6IGFmdSBwbGF0Zm9ybSBk
ZXZpY2UncyBwZGF0YS4NCj4gKyAqIEBmZGF0YTogYWZ1IGZlYXR1cmUgZGV2IGRhdGENCj4gICAq
IEByZWdpb25faW5kZXg6IHJlZ2lvbiBpbmRleC4NCj4gICAqIEBwcmVnaW9uOiBwdHIgdG8gcmVn
aW9uIGZvciByZXN1bHQuDQo+ICAgKg0KPiAgICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIG5lZ2F0
aXZlIGVycm9yIGNvZGUgb3RoZXJ3aXNlLg0KPiAgICovDQo+IC1pbnQgYWZ1X21taW9fcmVnaW9u
X2dldF9ieV9pbmRleChzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEsDQo+
ICtpbnQgYWZ1X21taW9fcmVnaW9uX2dldF9ieV9pbmRleChzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2
X2RhdGEgKmZkYXRhLA0KPiAgCQkJCSB1MzIgcmVnaW9uX2luZGV4LA0KPiAgCQkJCSBzdHJ1Y3Qg
ZGZsX2FmdV9tbWlvX3JlZ2lvbiAqcHJlZ2lvbikNCj4gIHsNCj4gQEAgLTExOCw4ICsxMTksOCBA
QCBpbnQgYWZ1X21taW9fcmVnaW9uX2dldF9ieV9pbmRleChzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxh
dGZvcm1fZGF0YSAqcGRhdGEsDQo+ICAJc3RydWN0IGRmbF9hZnUgKmFmdTsNCj4gIAlpbnQgcmV0
ID0gMDsNCj4gIA0KPiAtCW11dGV4X2xvY2soJnBkYXRhLT5sb2NrKTsNCj4gLQlhZnUgPSBkZmxf
ZnBnYV9wZGF0YV9nZXRfcHJpdmF0ZShwZGF0YSk7DQo+ICsJbXV0ZXhfbG9jaygmZmRhdGEtPmxv
Y2spOw0KPiArCWFmdSA9IGRmbF9mcGdhX2ZkYXRhX2dldF9wcml2YXRlKGZkYXRhKTsNCj4gIAly
ZWdpb24gPSBnZXRfcmVnaW9uX2J5X2luZGV4KGFmdSwgcmVnaW9uX2luZGV4KTsNCj4gIAlpZiAo
IXJlZ2lvbikgew0KPiAgCQlyZXQgPSAtRUlOVkFMOw0KPiBAQCAtMTI3LDE0ICsxMjgsMTQgQEAg
aW50IGFmdV9tbWlvX3JlZ2lvbl9nZXRfYnlfaW5kZXgoc3RydWN0IGRmbF9mZWF0dXJlX3BsYXRm
b3JtX2RhdGEgKnBkYXRhLA0KPiAgCX0NCj4gIAkqcHJlZ2lvbiA9ICpyZWdpb247DQo+ICBleGl0
Og0KPiAtCW11dGV4X3VubG9jaygmcGRhdGEtPmxvY2spOw0KPiArCW11dGV4X3VubG9jaygmZmRh
dGEtPmxvY2spOw0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gIC8qKg0KPiAgICogYWZ1
X21taW9fcmVnaW9uX2dldF9ieV9vZmZzZXQgLSBmaW5kIGFuIGFmdSBtbWlvIHJlZ2lvbiBieSBv
ZmZzZXQgYW5kIHNpemUNCj4gICAqDQo+IC0gKiBAcGRhdGE6IGFmdSBwbGF0Zm9ybSBkZXZpY2Un
cyBwZGF0YS4NCj4gKyAqIEBmZGF0YTogYWZ1IGZlYXR1cmUgZGV2IGRhdGENCj4gICAqIEBvZmZz
ZXQ6IHJlZ2lvbiBvZmZzZXQgZnJvbSBzdGFydCBvZiB0aGUgZGV2aWNlIGZkLg0KPiAgICogQHNp
emU6IHJlZ2lvbiBzaXplLg0KPiAgICogQHByZWdpb246IHB0ciB0byByZWdpb24gZm9yIHJlc3Vs
dC4NCj4gQEAgLTE0NCw3ICsxNDUsNyBAQCBpbnQgYWZ1X21taW9fcmVnaW9uX2dldF9ieV9pbmRl
eChzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEsDQo+ICAgKg0KPiAgICog
UmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIG5lZ2F0aXZlIGVycm9yIGNvZGUgb3RoZXJ3aXNlLg0KPiAg
ICovDQo+IC1pbnQgYWZ1X21taW9fcmVnaW9uX2dldF9ieV9vZmZzZXQoc3RydWN0IGRmbF9mZWF0
dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRhLA0KPiAraW50IGFmdV9tbWlvX3JlZ2lvbl9nZXRfYnlf
b2Zmc2V0KHN0cnVjdCBkZmxfZmVhdHVyZV9kZXZfZGF0YSAqZmRhdGEsDQo+ICAJCQkJICB1NjQg
b2Zmc2V0LCB1NjQgc2l6ZSwNCj4gIAkJCQkgIHN0cnVjdCBkZmxfYWZ1X21taW9fcmVnaW9uICpw
cmVnaW9uKQ0KPiAgew0KPiBAQCAtMTUyLDggKzE1Myw4IEBAIGludCBhZnVfbW1pb19yZWdpb25f
Z2V0X2J5X29mZnNldChzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEsDQo+
ICAJc3RydWN0IGRmbF9hZnUgKmFmdTsNCj4gIAlpbnQgcmV0ID0gMDsNCj4gIA0KPiAtCW11dGV4
X2xvY2soJnBkYXRhLT5sb2NrKTsNCj4gLQlhZnUgPSBkZmxfZnBnYV9wZGF0YV9nZXRfcHJpdmF0
ZShwZGF0YSk7DQo+ICsJbXV0ZXhfbG9jaygmZmRhdGEtPmxvY2spOw0KPiArCWFmdSA9IGRmbF9m
cGdhX2ZkYXRhX2dldF9wcml2YXRlKGZkYXRhKTsNCj4gIAlmb3JfZWFjaF9yZWdpb24ocmVnaW9u
LCBhZnUpDQo+ICAJCWlmIChyZWdpb24tPm9mZnNldCA8PSBvZmZzZXQgJiYNCj4gIAkJICAgIHJl
Z2lvbi0+b2Zmc2V0ICsgcmVnaW9uLT5zaXplID49IG9mZnNldCArIHNpemUpIHsNCj4gQEAgLTE2
Miw2ICsxNjMsNiBAQCBpbnQgYWZ1X21taW9fcmVnaW9uX2dldF9ieV9vZmZzZXQoc3RydWN0IGRm
bF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRhLA0KPiAgCQl9DQo+ICAJcmV0ID0gLUVJTlZB
TDsNCj4gIGV4aXQ6DQo+IC0JbXV0ZXhfdW5sb2NrKCZwZGF0YS0+bG9jayk7DQo+ICsJbXV0ZXhf
dW5sb2NrKCZmZGF0YS0+bG9jayk7DQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCg0K

