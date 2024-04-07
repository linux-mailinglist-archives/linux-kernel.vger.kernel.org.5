Return-Path: <linux-kernel+bounces-134253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19E889AFA9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3FD1F21FEA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89985111AA;
	Sun,  7 Apr 2024 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFq8H9Lv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5811C0DC6;
	Sun,  7 Apr 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712478286; cv=fail; b=CTCpzV6XM5ZtsLVmkIThLMcmImxvKZAYzDDGGAmY356rEvSGuYZiyFH2T3tb1fgTvNDmYIf3NTg+RLchXdZvKA+Pwz7YKsKEt42/6tJHUOoSDSojSRwUHdpeM3lN29bmFu2E0ceT9igtItwNASArybtJNZPQt7Ih4rmlhRLX4Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712478286; c=relaxed/simple;
	bh=akuAmn4WyWS8pP6beXiTz3231dftTjMhWklahY9WGeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uXiCHHC9/xMByuwtcUm+Q/XxN+MlwAZFx2bp+pxQHnY/lB17xThdwmcFtpBkNElrrUktTYiTCGCmvB0QAefneGUVhcH7mxAwRMIFgYR4Q20SQTVNloElIfmcXFabmtr1jDwtGCLIGtC1R/k3ZAgwE/p2S6M7Q6xEHYk6pbm1qXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFq8H9Lv; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712478284; x=1744014284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=akuAmn4WyWS8pP6beXiTz3231dftTjMhWklahY9WGeU=;
  b=PFq8H9Lv9r7v1j/aH4zUALVgurXVbqqmLhBj3CMv717QlIl65StUpyk5
   5XFuJ+Gay4/LW0lwVJMpZKQiZ1bqr67wouLnMQ6dYL6VOGcbx0YKtc/ie
   ikb3UVE7XveEjXsVBcVK8LRWpvnLfA39wbDY3NSIBjfxUFfroKdIdLInI
   Yu9Mi39Bqcl273JQFyJrj7vHvLGYY461U49Q5qmMQtjYsB+gZS5ja/vHW
   MOg2V6efqMYHv6SFy9LjjQaLdlk7yQIUPBSTx9CkpiupY3VJa73+EnoV1
   y3yeh5cpikgCYEd8cthS0asaaeSVEOEFfjzLn4RJJmdw5HRSXQZ/EhQGx
   w==;
X-CSE-ConnectionGUID: W5grCIYoTJKrHDr4jZPaqA==
X-CSE-MsgGUID: DbwFZVr6TCq5ZZikvh/36w==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7624026"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="7624026"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 01:24:44 -0700
X-CSE-ConnectionGUID: gAdyroVGTdu/DxMm7tzSAw==
X-CSE-MsgGUID: hQp7dMdASf+iTRdguPAMdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="19437947"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 01:24:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 01:24:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 01:24:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 01:24:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 01:24:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGKAgbqS8GyxMrUdbveZwqkiTHGFFPysW85iB8SA52SY0SqV9RrV/aaySgXUGG8PqONvD3o9kNRFInt/ss4LsWyYPXhw+fUcEZ9NSpKSd4pxDomq5Rc9OLRpLgQwSEjy8m58j6224jFLWnYbpAasYuP789KckASpTCcWMhJ9PbpSU3aemDYJ8peJsu9msv2uK5mqmNKIj06mozy2Hb/cdzcbbU6t+m96q3xykRWQ1WQYAYc70IZxdCXeF/3nYncs6S1sN6EIRZhQVe29BPoWLwEeGzue7+Ao9lbt03Pdog8xHtm8bIoIU5JTcWaGkpiZCHpDglrJE+IVFZIl7liTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akuAmn4WyWS8pP6beXiTz3231dftTjMhWklahY9WGeU=;
 b=iKnWq3YgqJTABtS8j6ipLjdje3PR72N3JWlSxRkfZFa59hqIScEb50nC8tFe4QvQvYVQthF0gtE3B7SmVPCuFqoAuGfzSWd/9/8J8pIUDHalm8/moezfbBRV/0NcvARaBhlJGT+4N2nqxsmuq/RoAq+M4C5P9nHQn+PNwyhj06eGmK6mwn3JgwEHtB2OKDTMLI+5oD7pyAKA3vEpU2ec0Bmm1aniuoBjRJ98FTZXvRL4w4mRZYaJ9IVASBFeloVuuCtDUhDWpGevp3rv1F0nn5KCfp5niPmJPo32OVPvKjJY3sAh/Psql5b7TGHNWvAJC5NulFU13b78RICOHt/qig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB8202.namprd11.prod.outlook.com (2603:10b6:8:18b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 7 Apr
 2024 08:24:40 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7452.019; Sun, 7 Apr 2024
 08:24:40 +0000
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
Subject: Re: [PATCH 3/3] hwmon: (coretemp) Use a model-specific bitmask to
 read registers
Thread-Topic: [PATCH 3/3] hwmon: (coretemp) Use a model-specific bitmask to
 read registers
Thread-Index: AQHah72GbzYUSgau9UqJ7GYKY57P8rFcepQA
Date: Sun, 7 Apr 2024 08:24:40 +0000
Message-ID: <6411e721a1cd559f59aecd8ac57a941cdaa13ff1.camel@intel.com>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
	 <20240406010416.4821-4-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240406010416.4821-4-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB8202:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTssi5C0LieJI9iQ4/wuTfwqakIhwPZSFSUva7BVTJvj2DFbz2C7OkSeULvL7YKgA9742IemPRXn9zYQdchV4WgP3UyOu02YLE+0o8VR7Fl2wbQv8sUjufU/8zmHTeU2jU4o1uSFUBZ+P1tLQ+gJBr8AK4dk7ApIK090S5hl0S4CvoEoZyBadl4FugTYT4bFZhs91MuB0tNM2B2kPDFDcaz4NYPxebtnIGMjorThCzdaY+T3HsG+GpdlOthwC7tBk1SA+j+S4pstTK6PxQc5zI0T09nEx4yo8537cX1psdW92ibUdlhx/bVouHPnMLUaU0TFn53uuVHXX6Hiaw7CDYFvcIwv+hf92/qAheuaoZg+E0SDpNsKJjm+SnbYIK6OO1JVe0LxzX3j5o4nZiC/Yi8LpCVLi1Obhv+oQygRrxIzf4kxvn7F3fWVd6SQj4B8Z5X5jWtQqaF8lql3/Any560TNbC4uzllVySNm6KMHQ2lllu/wyesSQh+arzAcu1xLEZOzY1JuysiEviSUI89kihTt/eXDqycvtQ7lW3vwdodzN7rinTNA6KA8GQmPGjxqmVWmFXODanuRtC/lOXqipU0WdmdJqGl4jHpXtvU6iW6Yp/SGt+IGMIqEgDM8Wyckr9+h1hO+CrMrD5hUogv76MQS7uNbDfZVAv11eKfcqM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3ZsZ3dCa014T3JCUUM1c01SdGlFWWN0bEl3ajRPNHpKOXl5MS9qVHZ5eklU?=
 =?utf-8?B?TlBBeUtBcnBJcm9RUzJEV3paSmxjYzFnelZNUTBKMEcvQXZTaFBOdG1Kdlk2?=
 =?utf-8?B?TWZiMDdtQndPNW9pc3o1MUJ1UklrYldkNEdtU2RtV1YwNFdValBrV2FVVzdn?=
 =?utf-8?B?bGtnVitaYmU5ZXA1Y0RrbDVmdkFBS3Z6Y292MVhMT3Ryd1ByU1N4azUxbjZv?=
 =?utf-8?B?VG4xeDNWMk5ubmNvUUdoS1JuRFhJUDBxeG95ZVZuWEdWSUk3M0JoYVRXOERr?=
 =?utf-8?B?ajFmR2V6Ky9ocm5uMldid3BXRjc3NVJwbkg5OSsxcnNyL25uamxLL2Qrcnhy?=
 =?utf-8?B?RFk1ZDZMWEJZbE0rNWNNZUl4dzFXWFRIQmprSitwMjFLQnViR3d3dStwK0NM?=
 =?utf-8?B?WHhMMTBvcSs0VGpRcU1GVDNyalBQVDBUWWFyb09XSXZWQndpZDFESlBGUXV1?=
 =?utf-8?B?ZkhXbWNFMVNhV3R1YjhVVnlFYjU4VENBMzE0cHJmQUlOcG5iR1hsVzQwL3V1?=
 =?utf-8?B?azRRMy92YTZJQUFmOXU5R2hqdUFPSWt3ZkwvWndoRGZtcHlKcExPdUtRMm1V?=
 =?utf-8?B?VWc3K3VzVjZnTm0xSEhEOU01L1BpTnhyUW91UmZWZWlpR3hEWmxoZXBQb2pk?=
 =?utf-8?B?bVdkTEkyL0s5aHhCL1B6WjJRL2RsekR4YktYM2JIVzd5TlRNYjVQUE9VMyty?=
 =?utf-8?B?aWh4UnpwR29kc1A5T3AvNFM2VnpwNWVCd2ZQT0gzcEt4Sm1hSnJZUEswZ0JZ?=
 =?utf-8?B?cnAyYVBYWlRkN2JITWJUZ0xFUmM5TkhpczVFRFJuMEQ5cHI1N0dHZzZRbjZN?=
 =?utf-8?B?V0hrQ2xUVHpqb2V3cUxIQzNZaWlySXJpeW1sM2RYbktMQWJOYXFFeXVxaDMr?=
 =?utf-8?B?UFhHR2k5M3hYdkRTaFJ0N2Zmc2NhaHMxNDRUdFduWFo3eTRPaExvbG9MQXlQ?=
 =?utf-8?B?emNpNnRsZHdENDREdHhjVmVacEJtYUVaVzBYUzc4cEhpaGpLUTQ5VkJnNEdm?=
 =?utf-8?B?UlZEdVN5N3ZWM2tCTEtaSFR5QkVKQkI3ZFpUSlR6alFER2hZcVlkZy9Vd1FM?=
 =?utf-8?B?WHRnU0pCYmR1VXcxU3lPTytjaEZiWnNYVEpiSjdGZmorTzJ6blhYQzVjV1k2?=
 =?utf-8?B?MDlVUXd2SFJQRER4RkVlU1c3YjB4Uk94N0VZU0JNSkE1UTdoZWFJMzNQM0RU?=
 =?utf-8?B?VWhISkdOemxzWnVBYzlsdWVvOTVFNHlJV1lyUi9IdnkrZkh0VDBFY3YrTldG?=
 =?utf-8?B?SzRObU1kd0Z1ZytEWmh5TDR6ZzVSQ0Z2RVNCdjhaUzhVcDZQakN5Rkg0Z3FN?=
 =?utf-8?B?Vi9DUzF6MDNwMFB5dGdRb1l1ejN2UHlNMi9qKy83aGIrTGhaTUF2UmJBUW45?=
 =?utf-8?B?eENSTFNmRzNEOEtGZ2Q1aW9MY0dBZ0VCVkVYd0ErakxycGx6ZEpvSVF3R1Fs?=
 =?utf-8?B?MWJMNHNQeHVnOW9mRm82WE1kZlZIREVnNHY3Vm1EbC9mcHduRW8rZm5iQjYy?=
 =?utf-8?B?dmNWdlM5Q3REMjVaRmdWUjNySTc0K0FRdk5MY3JIMmNLTEhEdnhQUlBuVkZX?=
 =?utf-8?B?U0RnM1p2bC9CeERQWkRpNlR0VWJwNVdEbW5GOXVrVG4zNVdZaXRwZnEwNjl4?=
 =?utf-8?B?ZlFtOXZQaWtSQStXdURhdHV1NUw1MTlyV1FEa1lwR3YreG9Kb2MvTDc1RXZs?=
 =?utf-8?B?VjVlN08rUktHdTdxZUhmYU1OS2ZobXNoL1ZuR01RTlNUZDBhVEFTenRrWTB0?=
 =?utf-8?B?Ym55T3lhaFR5U1hFdk9uY0VLalZkWnYwdDVoUk1FTFZ6M3pvZFFnK3hDT0RP?=
 =?utf-8?B?NktIMEFIZmJsT3FxZFcwd3Z2TjRTaWVVbXRGQnJUQmt3SGk1TVhSSytQZHdR?=
 =?utf-8?B?L25ya1VXRmR3Z3FtNjBBMGhHS3VSYWJRWDRpdCtUTkFZc21xUjJackowNzkz?=
 =?utf-8?B?QkRBK2gwQTRCM1FTeTdhODBHTE9yN29iMFUvTHZkeURmYlJTTy9yK1BCbUZG?=
 =?utf-8?B?T2xPTllHemxvVmR0QWlXL3hTLys5L21UOWxkRGRmVjJNVVRjZ1ppdEtRdmdE?=
 =?utf-8?B?Sm15M0ZieFlNY3BvUHJaSjlwMGlxbkNsZXhSQk54Q0x0UVhOQzRXVE1sZUU2?=
 =?utf-8?B?YnhvWnhvSkgzamlRanBnb3B6Qm5PVnRMcHpaQkw5QnRqVklybVk2RE5STTQy?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F65FDE3F7C0914EA6F43DE0CDC61C76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef412b1-8ce4-4f3f-d6d1-08dc56dc2bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 08:24:40.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejZlW8awF61boxa0IQZ8co/iscFpjst0v0/yFP4VlD/ucd58C4Kqznyjp2zJdfdS46ClLw/iJWNAuhXJ/FfgHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8202
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA0LTA1IGF0IDE4OjA0IC0wNzAwLCBSaWNhcmRvIE5lcmkgd3JvdGU6Cj4g
VGhlIEludGVsIFNvZnR3YXJlIERldmVsb3BtZW50IG1hbnVhbCBkZWZpbmVzIHN0YXRlcyB0aGUg
dGVtcGVyYXR1cmUKCkkgZmFpbGVkIHRvIHBhcnNlIHRoaXMsIGlzIHRoZSBhYm92ZSAic3RhdGVz
IiByZWR1bmRhbnQ/CgpbLi4uXQoKPiBkaWdpdGFsIHJlYWRvdXQgYXMgdGhlIGJpdHMgWzIyOjE2
XSBvZiB0aGUKPiBJQTMyX1tQQUNLQUdFXV9USEVSTV9TVEFUVVMKPiByZWdpc3RlcnMuIEluIHJl
Y2VudCBwcm9jZXNzb3IsIGhvd2V2ZXIsIHRoZSByYW5nZSBpcyBbMjM6MTZdLiBVc2UgYQo+IG1v
ZGVsLXNwZWNpZmljIGJpdG1hc2sgdG8gZXh0cmFjdCB0aGUgdGVtcGVyYXR1cmUgcmVhZG91dCBj
b3JyZWN0bHkuCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vY29yZXRlbXAuYyBiL2Ry
aXZlcnMvaHdtb24vY29yZXRlbXAuYwo+IGluZGV4IDYxNmJkMWE1Yjg2NC4uNTYzMmUxYjFkZmIx
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaHdtb24vY29yZXRlbXAuYwo+ICsrKyBiL2RyaXZlcnMv
aHdtb24vY29yZXRlbXAuYwo+IEBAIC0xNyw2ICsxNyw3IEBACj4gwqAjaW5jbHVkZSA8bGludXgv
c3lzZnMuaD4KPiDCoCNpbmNsdWRlIDxsaW51eC9od21vbi1zeXNmcy5oPgo+IMKgI2luY2x1ZGUg
PGxpbnV4L2Vyci5oPgo+ICsjaW5jbHVkZSA8bGludXgvaW50ZWxfdGNjLmg+Cj4gwqAjaW5jbHVk
ZSA8bGludXgvbXV0ZXguaD4KPiDCoCNpbmNsdWRlIDxsaW51eC9saXN0Lmg+Cj4gwqAjaW5jbHVk
ZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cj4gQEAgLTQwNCw2ICs0MDUsOCBAQCBzdGF0aWMg
c3NpemVfdCBzaG93X3RlbXAoc3RydWN0IGRldmljZSAqZGV2LAo+IMKgwqDCoMKgwqDCoMKgwqB0
am1heCA9IGdldF90am1heCh0ZGF0YSwgZGV2KTsKPiDCoMKgwqDCoMKgwqDCoMKgLyogQ2hlY2sg
d2hldGhlciB0aGUgdGltZSBpbnRlcnZhbCBoYXMgZWxhcHNlZCAqLwo+IMKgwqDCoMKgwqDCoMKg
wqBpZiAodGltZV9hZnRlcihqaWZmaWVzLCB0ZGF0YS0+bGFzdF91cGRhdGVkICsgSFopKSB7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUzMiBtYXNrID0KPiBpbnRlbF90Y2NfZ2V0
X3RlbXBfbWFzayhpc19wa2dfdGVtcF9kYXRhKHRkYXRhKSk7Cj4gKwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmRtc3Jfb25fY3B1KHRkYXRhLT5jcHUsIHRkYXRhLT5zdGF0dXNf
cmVnLCAmZWF4LAo+ICZlZHgpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIElnbm9yZSB0aGUgdmFsaWQgYml0
LiBJbiBhbGwgb2JzZXJ2ZWQgY2FzZXMgdGhlCj4gcmVnaXN0ZXIKPiBAQCAtNDExLDcgKzQxNCw3
IEBAIHN0YXRpYyBzc2l6ZV90IHNob3dfdGVtcChzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBSZXR1cm4gaXQgaW5zdGVhZCBvZiByZXBvcnRp
bmcgYW4gZXJyb3Igd2hpY2gKPiBkb2Vzbid0Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiByZWFsbHkgaGVscCBhdCBhbGwuCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKi8KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGRhdGEtPnRlbXAgPSB0
am1heCAtICgoZWF4ID4+IDE2KSAmIDB4N2YpICogMTAwMDsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdGRhdGEtPnRlbXAgPSB0am1heCAtICgoZWF4ID4+IDE2KSAmIG1hc2spICog
MTAwMDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRkYXRhLT5sYXN0X3VwZGF0
ZWQgPSBqaWZmaWVzOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gCkJlc2lkZXMgdGhpcyBvbmUsIHdl
IGNhbiBhbHNvIGNvbnZlcnQgdG8gdXNlIGludGVsX3RjY19nZXRfdGptYXgoKSBpbgpnZXRfdGpt
YXgoKS4KCnRoYW5rcywKcnVpCgo=

