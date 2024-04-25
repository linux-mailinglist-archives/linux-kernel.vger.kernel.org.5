Return-Path: <linux-kernel+bounces-158930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320438B26DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0016283C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0FC14D6E5;
	Thu, 25 Apr 2024 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtMddMni"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AB14A4C3;
	Thu, 25 Apr 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064082; cv=fail; b=qxknTEXurAgP+OkUbDhe0yfY+R0oibTMiCttE9h2G9MZhwaJZRSJizeaM5Q7mU4qB5cdMwBW+qoPEitksOU4rZ003zSFSNHPsKEVMbfFGa4wUScQUdZNBY14HN95wNUajGpdTFD8wiIfJUPg1LrSoF8roIbPyoZFmHTfVoSgMIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064082; c=relaxed/simple;
	bh=iidEXO3SCpSNQbs4aiMBGo4lL8wxh4ZB8e+lc9CPAiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IWhpW5ZEviu7Ch/HbIdDpPjyYHNd0WB1MsvGpI6jQsgBbRYQ5twUhnZjj15OSJHS2IKX60NYd6woU9wREnepHSmQtT4GgO/iF59ZaLNW5Q2Oklnutx+RQ2L+uNp3xI+IV49LHDpLuQb2jiafgYz0yE8Oc9i8U+zdmTLsEDlQj5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtMddMni; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714064082; x=1745600082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iidEXO3SCpSNQbs4aiMBGo4lL8wxh4ZB8e+lc9CPAiU=;
  b=YtMddMniykUhj8gyKWUxI0hf/0NEoWeihAMv9teJg9y/yDIQNYGvUwlE
   s5HCvRWImiNhgbkV2oNJDrT8iQo3zR1cyxhNuv08ovMcK/M93fcHtffwg
   fs5AO8gsi0G9DsR+h11N1qRnGIjS4GUhyVg8AHAIfLTssb2xIdcmluG44
   jMMoWP9eBZz75w2WGfv6B+0nsirL1WEuRTBG8V0Lp3+YjL767mvg+ZJrA
   61SK9xVIFt8qPAKziUhdgLpoyYwNMvINUiLPXrqeQPec7eWmus5xlvbyN
   y6jvkQkDiFayzpawGXX1VP136dbi1ITrPxn6p4k/zSyYUZdOg5gMj7qEq
   g==;
X-CSE-ConnectionGUID: iFTsByMYQTesQIm7hLG3HA==
X-CSE-MsgGUID: IZT5ZKFlSLqXlORkQj+3MA==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9928085"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9928085"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 09:54:41 -0700
X-CSE-ConnectionGUID: yrNJFSMjR4mZTkMf3vJ43w==
X-CSE-MsgGUID: 5VI6veoISEm0s9N3w/yvnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="56315927"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 09:54:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:54:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 09:54:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 09:54:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNgvLws/BGAPCAd5HaYrD6ecR+1aat+nuPY/+oVkC6AfyU4OapR7jJf5FxlcZaNszwJ9bfRQVAU6P3CvThXxRGjnyHDuNpXoDJ6iM6EZ4h3aM0CimT9ncypOb/QsntWhGRZC0VfcjmDBJ21tD7XqlTr4LVv/mMXLomBVMw9phsJTqnCdeHM/jdpeuKoNCNMmWDWEI7AAylmAmiEwV14Pf6EgTswVTsn0b9zUobsO40w4P92jJGz4zlO0PNblTy1PD3NUXc3BO99iczcNXmchMIU8tzuAVq0NuZP9ieVfN7x1rP1DsKFeXM6PEyGDWBSMpWuYNKncfeCfq6jS5AqiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iidEXO3SCpSNQbs4aiMBGo4lL8wxh4ZB8e+lc9CPAiU=;
 b=jh7Ec0XfoQaeFNYW+mSu/QVsx1ndQZSWi5Vs9xVvu3f2ECv+AcGjhDd7XXeKQ9+77eoz10KLhcdOzsGXm3V5XKd04PHfdgifdVkemfafrVm9MH4aIZtopTH0sYJOS5uTW78YUhMIoQhfYa7vyB7Ss5EIGYEGxGi35tQqAdmbL7HLuNrawJpgMVDKFRx/5UvFMUaf4ZBAtK+gU+PamspMG5Mq34D8di0aMkwigur4hhKMVsc568Muiya/CdBDcnqTShWZaMts02fbZ9Ma89dx/KZH52v7vwlySxStzH/ixkVnKn0uGjiwRsCf9H4vTyVuyuczxq9gRZre1r52xyUGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7247.namprd11.prod.outlook.com (2603:10b6:208:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 16:54:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Thu, 25 Apr 2024
 16:54:37 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v4 24/71] perf/x86/msr: Switch to new Intel CPU model
 defines
Thread-Topic: [PATCH v4 24/71] perf/x86/msr: Switch to new Intel CPU model
 defines
Thread-Index: AQHalnNar7XX+ZqDf0iu4dNZJO0KwrF5I4AAgAAOShCAAAHeAIAAAUAw
Date: Thu, 25 Apr 2024 16:54:37 +0000
Message-ID: <SJ1PR11MB6083080471AE0000AE12C2DCFC172@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181503.41614-1-tony.luck@intel.com>
 <3f70c656-f583-4360-b321-31a0e92fc844@intel.com>
 <SJ1PR11MB608328873B5AA9BD7ECE6BC1FC172@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6f2053c9-4fa2-43f0-bde1-a93745332997@intel.com>
In-Reply-To: <6f2053c9-4fa2-43f0-bde1-a93745332997@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7247:EE_
x-ms-office365-filtering-correlation-id: d1c3045c-630a-48d6-eafd-08dc65486465
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NFphYzUvMzRVdlVEeDFVWHMwMXNaK25Mbm9jcFJWQWJzUE8zWGRrNkFPVXVt?=
 =?utf-8?B?ZExqNXFjUEtLNG95STNBLzBucFhRUjlidE81NUJCQ25OSGpvVEdqQmJQWHF2?=
 =?utf-8?B?Y0hJL3pDUnRUTEV2UXJGUEdDQVpWUW1YYzZlNHpYYWNxTkozNVhIS0V0NWo2?=
 =?utf-8?B?Kyt3Y0dtbFNob292WHdLMk1HMlVUUGFWRTBxSVFEdllHQ2FCTWZYTFVWbUNx?=
 =?utf-8?B?aUo0RlhHcWt2WmFUMHFSM2xBSDNnMW9qQkcxUDc4WUkxeGErcmtLRnB4NDZy?=
 =?utf-8?B?Rk8ydnZMcVlIbk5Hc01ic3oxUUh0Tzd0Q09ndTVtYk4vVVY0ZGhjSnZ3T2Q3?=
 =?utf-8?B?dEFTN2ZLN0ZnaWhmMXpDZkZTMk1YTm1XNGlFQUx6elczUWFFSFZKcGljcHV6?=
 =?utf-8?B?ZHh6N2VnRkpneE9xUGFDVWRIZDdZSEovMmkvK2xtVDhhbzY3bDMrMlRDN2FR?=
 =?utf-8?B?UGIrUWFPaFF3dG9KdndicGpmRnh5aHhRYnlSV1Zmc296RGtsdm5wRm5FWGl2?=
 =?utf-8?B?YSs4OG5rUkZJcUVKMXNXQ0VlZTMyR1hKaGNlYmhwTTZpV2Y5NDdkR2lNMEpF?=
 =?utf-8?B?V0o4WHNUalBKUlVWUi80Wk53NkZHL1d0YmlsZXIxb212cllWYXN6eTFsZFdV?=
 =?utf-8?B?VzI3UFc0UTlldVczVVlXTit5b1JsS1FVRmJYWk9PUlpjSzcrZ2hwMGh1M04z?=
 =?utf-8?B?a0xGeEs3cWxOem0rTGl4c3dVZVM5QXllU0pLWjluWGNmbjZ1VnkxS1c5N0No?=
 =?utf-8?B?bGVacmRHYjZYSmJJOFhEZGtsMXJDNXVtNjVzQlpQVTY3cmpicXRkMnJRV1JM?=
 =?utf-8?B?bnQzZWJaUW9oRFdiVmF6MjFSMmUveFZsUEZhZ0RBRXV3KzBxY1hicUZEbEdl?=
 =?utf-8?B?VVB0UitaRWVPbnFrNDRiemt5MGVSUnV0Vmc5bFlxRWoxaTlkc2RjMnFXd3Ux?=
 =?utf-8?B?dTRreUx0QmVSYkE3OFk5Yk5XdEllSkNKWXFqL21hc1FaUlVFU3B2Vm0wVTNh?=
 =?utf-8?B?NWdDNXZYczRlYmRqMXJIclR0TWVUWStLZkpaUEhYNGx5VU95cUJUOVJyVXBB?=
 =?utf-8?B?ZjhtQVhiQ2VWaEIwY2dOVXNNT1pGVnNQZWJQS3dJRURhOE1Rcll1Q3lNL1ZC?=
 =?utf-8?B?MW92TTdPSDEzc1Z6WjVFRlJXdXFlVzZ5UnZ6WTh2TnNoaHNvZFNRSUhqRHNq?=
 =?utf-8?B?SVUvenBneHBva2dOTll6VVJLeGE2RTlIV0R5U1hqQ0ppcktpV2I2R3RkWk5D?=
 =?utf-8?B?aHUvdzI4UXB3bXBXSXNHaG9pa0M5bGdzM2RlV3JiZ0d3TThsLzdWMXhOakw0?=
 =?utf-8?B?UW1wZDcxMmxlSy9jbTJWL3p3d1NnbVdHc1V2bDJaUW5XMzFrYi9rcktjRVBX?=
 =?utf-8?B?dTkzZnNCSjFxdDdhb0pGM0NsS296YXpjL1dZT3l2aGVTYi9ieFdEK3Q5ckZK?=
 =?utf-8?B?M1ZjS2s1WGd4bUFLRGZ2UVEvbVduT0Urd2VXaGN2SFRDZXM4WWlFNzBZaFBX?=
 =?utf-8?B?NGdkZWcxZUF4cUowZFBzV1ROQ3hwZzJzb0x0aHd0MlN3eFdHMnllWlNVWWpB?=
 =?utf-8?B?Wms3TnRCWXJvN2RqMmcyd2I3em9jQi9yNXVKTDZpZEpnTXZDK1BETDhzKzZJ?=
 =?utf-8?B?Y0R3bUxCYnVtU1Q5RFJ1VDFHYjdjdEwvUHhwZ1prNzBMQXVzS0s3dGltN1ky?=
 =?utf-8?B?eFF0TVA3MmI1R0Z6OTBvSUtld1VqN1h4aUN0amJ0RWQ4cVk5Y0x6TjZvdWY0?=
 =?utf-8?B?K2R4eWRab3ZlR1ArRVBOQSt6MjUrMVd4d0Q1QmRVMEVudXBHRis5aG5VQkhH?=
 =?utf-8?B?TVNHYWt4UFVFNExyQVRzdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUt2ZlNqbkNSNFRCcWxwcEVYRVlFRHhQRWhidEhqRzVHeWNLUWdwT3owclZJ?=
 =?utf-8?B?K3ZHMkJzUWRxVmFjME5LTm42eFZCMnkxalg1QVZuS3Bmb2VoZUhPL2gyamlj?=
 =?utf-8?B?RC9JY2F2ak9wbXhHQkpEZWhPNzZhOWo4dGxDaTlWVnF6VWhhRVJHYkVtOHBm?=
 =?utf-8?B?bFhxeWJTeEc0OXVlMEVsNmlNSzdoenJLc3ZlcDJPS1h4SmpHcmU0Y3UySjU0?=
 =?utf-8?B?aGRJMytyejUzN3VMRW4rQ1krTEROTDZIUmljSWNtVTkrTytoZzRDa1BnR2gz?=
 =?utf-8?B?OE12TVJONnpTTU1lbnpCbEQ4WVprNUJuUTNqL1JZemhNMm1PeTBCa0tzOXkz?=
 =?utf-8?B?bzk5ZXBieHp5aFVHcml0Zm9VQlkzdnFnVXQ1OHpuODZQRFluSitaWkJKeE8x?=
 =?utf-8?B?MDRHZ3RmZ3ZPRm1PTW9mdXdzSHY4aGZORFlzaG9lbW9pS0J1NVlpQjZwOEdi?=
 =?utf-8?B?bWFEQi82TFoyU2dsN0c4NXorU3ZHMmhCbjVyMXlsb0dxK0JwQmdHd2d6Witr?=
 =?utf-8?B?MkRlTVJkR3ZreTNIS085K1JPaU5Gck1tSXNETzkxa21OR1JIVk9ybFB0bGtD?=
 =?utf-8?B?U01KUVREcTUvWEFDKzlTcFJoalFDSktHRnVFOVNxTVU5dEg3TFNFL1JmVHZw?=
 =?utf-8?B?TnFQc3lHQ0tLdG5TcG5EcHJVVTBKV2NJSXJGa1Z4WEZFNTI0V3Zwak9RK2VT?=
 =?utf-8?B?akorMGpQZnBnRjNDVVR5bjd1aWJqOXNDbGJWZXhmQzEvRXBtekprT1QzWGt3?=
 =?utf-8?B?cUkzdFM2QXBEeXFiWkMvTEozb0NJSkJKTTdQaWtIWkJMM0hRdTJSWExMUHNP?=
 =?utf-8?B?aVByR2xjWlg0V1BuS2E3Y0daajZINW5PTEt6SG5YVkdnMmYzN0NFRkg4WnBJ?=
 =?utf-8?B?WFFOY0xZQmhrZ3BLaGNwUEVVVFJPYmhhd25xTUJSZFQ1QXZvRytOQU9pelhs?=
 =?utf-8?B?NXRqNmlNRkJmVXVKWkIxZk84cmRXVDlVQjhEcFNxQ1RBZWpJRGtYay9pVHFF?=
 =?utf-8?B?eGlkVkkyekY4QWRGQS9FZXNTeEw2eGYyQktvVUhlbE94ZnJmaENBZm16aEU3?=
 =?utf-8?B?R2phdmpGZHljTVp1N3JCWStOZ3J1R0NxdGRmb1NJempqRTBiZUJ3QUIyNzBa?=
 =?utf-8?B?d0Z2anhsMDF0Mzh0LzFTNTZ3YWE2UU9QVlN4Z0tPaExCdjFnekF6N29mNG1p?=
 =?utf-8?B?VXVPZE9BY2RNM0RJSHNxbDc4ZndIZDdrSXA5MFJwYXF4eTA0MU8wL0QzMVBV?=
 =?utf-8?B?bkE4bm55RWpHNWNBSUZNVzBBQ1dwOWVTZ0hoNmc5OEpRWHNnMHNXWmEzaE5U?=
 =?utf-8?B?bnhJSThhTC9QaHlCUk9BS1FzMnFWWXB5R2NIRDE0a1dIM2lid0N2bGd0K21Z?=
 =?utf-8?B?UG1pekF5Wm1FM0g0ak15cmREUHRGUGdvMWZCUS9DSDR3RFBNQWVPNXhOYWpT?=
 =?utf-8?B?L3pZenNvYTl2M3FIUSs2eW8wZ1FITGw5aGZyRENKU0JIOXRkMVg1TlZHaTlo?=
 =?utf-8?B?VUhXSUhxbFlvK2toTDMwZk9ZSlJid0xOTWw2TE5qaUVpeEtTd0xqSk92WG9C?=
 =?utf-8?B?TVJOTDlHcVRTd2JOL3FNelFHcjA3UnUyaGdVb1Arc0NqWnpyK1o4Rkx1L21T?=
 =?utf-8?B?eW85TWVXMlVGMlVQU3NNQW5Pb2p2UVhWQzFjU2hRQnR6T1FMYmhZN3ViYlZB?=
 =?utf-8?B?dDdzbnpJS3NGS3d0bmYrTW8zWmpKb1NhQkEzU3hTSjVNMjIzTFhaMEZqS1RJ?=
 =?utf-8?B?QmF1TzJkRndaZTBSR2hsNUN2cGE4cGFEc2VVNldhb05XQVhWclEzZHRVRHpD?=
 =?utf-8?B?MjJjYWlmYlJGby84VTRYZm00bU5yek9ZcFlZQUlPRTVjcnM0R05BK1VaaWIv?=
 =?utf-8?B?YWFURXNlT0JHM081OHdiR3ZoMEo4a2k2UE00bnU4ZlNkSC8yRGs0NGFkZ2JL?=
 =?utf-8?B?MnRZZDA4bkZLZ2k0Q0NiRnJDV2JZTHVzU09KV3I3TERXRGtnYU90TmZyVHJz?=
 =?utf-8?B?emkyaFk1ekFEWTk4RTVDbnFObStYdzgvQmhMUWlBaHl2b01uL2FkdFh4M0E0?=
 =?utf-8?B?dVZxTE1rb0Z4V1Ewbjd1R2ZvNmh5ZkFwQ3BnY1FPbDZpb2J6SE92bmExYTIz?=
 =?utf-8?Q?BC6Xrq5yNY4vOUxEeXqm5DV9k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c3045c-630a-48d6-eafd-08dc65486465
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 16:54:37.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4vtZYPjU90KIBcoDYVHjW49icSgSRzdeqypxCng7PRAcTfSQgmwaOUTL5QG5Da+vbdbLVUetP3rdpkeJ7pe/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7247
X-OriginatorOrg: intel.com

PiBXZWxsLCBteSBwb2ludCBpcyB0aGF0IGEgLng4Nl92Zm0gc3dpdGNoOg0KPg0KPj4gKwlzd2l0
Y2ggKGJvb3RfY3B1X2RhdGEueDg2X3ZmbSkgew0KPj4gKwljYXNlIElOVEVMX05FSEFMRU06DQo+
PiArCWNhc2UgSU5URUxfTkVIQUxFTV9HOg0KPg0KPiBpbXBsaWNpdGx5IGNoZWNrcyBib290X2Nw
dV9kYXRhLng4Nj09Ni4gIFNvIHRoZSBleHBsaWNpdCBjaGVjayBjYW4gbm93DQo+IGdvIGF3YXks
IG5vIG1hdHRlciB3aGF0IENQVXMgYXJlIGJlaW5nIGNoZWNrZWQuDQoNCkltcGxpY2l0bHkgY2hl
Y2tzIHZlbmRvciB0b28uIFNvIHRoZSB3aG9sZToNCg0KICAgICAgICBpZiAoYm9vdF9jcHVfZGF0
YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSU5URUwgfHwNCiAgICAgICAgICAgIGJvb3RfY3B1
X2RhdGEueDg2ICE9IDYpDQogICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KDQpjYW4gZ28g
YXdheSAoYXNzdW1pbmcgdGhpcyBpc24ndCB1c2VkIGluIHNvbWUgcGVyZm9ybWFuY2UgY3JpdGlj
YWwgcGF0aA0Kd2hlcmUgdGhlIHF1aWNrIHJldHVybiB3b3VsZCBtYWtlIHNvbWUgZGlmZmVyZW5j
ZSBmb3IgQU1ELg0KDQotVG9ueQ0K

