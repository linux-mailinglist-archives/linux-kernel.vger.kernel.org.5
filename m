Return-Path: <linux-kernel+bounces-158921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEF78B26BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41126281C42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B04814D439;
	Thu, 25 Apr 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGgSn0ll"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F561103;
	Thu, 25 Apr 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063433; cv=fail; b=qJA8wylOTa8W7F+o4nwlpDljY66TULO8jbNC96clMcUlF0XFAxG+BzAbhq2QHdMb3+bF9egnqnr+JWLgusHySYD4Uowf8o/wRcK+AvVLBpTNkJ8FBw9ZsdJswQOSy9c8aIYO9hTlEhNucVB00KpCGTuaTgK3hMOhABvGEaCsGyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063433; c=relaxed/simple;
	bh=vXHOZx3CQdMyPf1MB+4z9lN0WGcK8T7AAgvViwTsNDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uNF/Cjox7I0eRyUtd5HYD9oIk1chrtHeE9ss3dK9U9DWaj3Ep0VWMGPuxGF9XIf+/LNX6ENCL5lm5/3DidyyL3oaUq/aBm09TLrrjMmtFmJ0xW2fGVXI/3kwrp/sbg8BoMhZfg30emq4DHl3kp6beR2GtVejgkVPLBL7sRz28OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGgSn0ll; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714063432; x=1745599432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vXHOZx3CQdMyPf1MB+4z9lN0WGcK8T7AAgvViwTsNDo=;
  b=hGgSn0llm3BdjyAVFLCMz6+8L2sdY/QW4YmdFbrg6RKLZobgULj4I2sz
   6McE14aA4igxJ06YcVA75EA5e2QMIx5CFOPUjG20B30LkUsNz33ZZOU7/
   vUBFEczJLeS+JA5m3IrRVs1lx6gEvdGfRbQqihCWU/5Ro1plZsDO58vHS
   O+JQop587Vfb12FXV15VzKVzKj/oFkaXjD7ePkl8RIkfM9DDeO95Qv8+E
   g2jJCbP1GUh/FmSeDeT+7ARmmutjmMrosPt6QkbOn8DRCusgTHBfR0hJ4
   RGzSVmbXKzJNuVTSKkOFoplI3/Ms503fQRkXR5C6uz8qMFpBOaSg+gN23
   A==;
X-CSE-ConnectionGUID: YFDG7OXgSv+sroUpZrC9Uw==
X-CSE-MsgGUID: BB4fHI83Rt66MCIKDnDM9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="35156122"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="35156122"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 09:43:51 -0700
X-CSE-ConnectionGUID: lGIdi4CPRZOdGQV+Tkt2GA==
X-CSE-MsgGUID: ldJGEdpYRKCS1RDsOtVF0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25154431"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 09:43:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:43:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:43:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 09:43:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 09:43:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMCZpsxqvFsk+ZxLxYPaZKtAMGM5rxL/v1G17WEaBXpaRbDUT1qpBh9RJe7S4g1gXnVWFeQ2rhyaHVtjCZhoRCE7W1+pZrCdo5Lhxo4vffIRJD8ZD78XmVgoVdX5SGgl7lz8MluucKIRM0Wxl7l9LRqjyAkq9xRg3bbXUMFgQU+xFl5aidb9DM6TMId+RuJgJw+Rq5R8aAs/V2MET69BKVd9EYsxK8WQ7cxla2Ogqt1B5AEgNVlzpYo4ZL6bUe8BHk4gjMdljTfxvp+3CyQZC3Eme0iQ9uRQW8/ybtkMtxpUSvAnaV31zjnjc589sl2RMtodx0RMZU0W25vkhg6wUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXHOZx3CQdMyPf1MB+4z9lN0WGcK8T7AAgvViwTsNDo=;
 b=GVa/yp3nMGuGlTGNWMMiYBHMQ3SsO/NO175yHH1q3t7I7CywZwsvwjC4Jm2LqOuXXAfb5fz5uvzEn2qUzLUZ8zDTz32YfUAKLzEtTSuQYpFSFieNGQA6YkkGpAGHneLYro0plB/nnOjgRqHQejtDibQRdFf2ljQB5fX5YY6fAfCT32XsAurMOjoFPb/NhdsXu956jXqlmqhTaNM+GHUWE4hSpwhK2sCvG1y8pTROLRw/AD5YTHsbb4n0ykujNZMMgWQWumDQBcssNxDkRGB6VP0VMzOXjovcGP3yv1VgWktrxAKTYF+u6isr/c9h9iIVSda0ZO0A6WxbG4D/rv3vFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 25 Apr
 2024 16:43:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Thu, 25 Apr 2024
 16:43:47 +0000
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
Thread-Index: AQHalnNar7XX+ZqDf0iu4dNZJO0KwrF5I4AAgAAOShA=
Date: Thu, 25 Apr 2024 16:43:46 +0000
Message-ID: <SJ1PR11MB608328873B5AA9BD7ECE6BC1FC172@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181503.41614-1-tony.luck@intel.com>
 <3f70c656-f583-4360-b321-31a0e92fc844@intel.com>
In-Reply-To: <3f70c656-f583-4360-b321-31a0e92fc844@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7948:EE_
x-ms-office365-filtering-correlation-id: ca774653-35bc-4cb6-b63f-08dc6546e092
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?UUppUFNkbllaa2NlZ1VTb3FRcWpNZ1gvTithYUNXVWtPeTRxQlB4VWVOdFlF?=
 =?utf-8?B?Vy9mSXhvZHk2VWdldjJyQVFuN2hEbWM3ZC9tV0VrNHBVbGVZWVVQZlRtQmow?=
 =?utf-8?B?V21BTHdIOHNtUTQ1T1NWc1ZvdHVhUU45T3JiQzlYbmwrWmc1M1pmNDRVS3Vo?=
 =?utf-8?B?b3psenVmcWE3T3lDTnJwSDNKOUJvTDRhK2ZwSnVsNVh5TWNBS1FaMk1PRlgz?=
 =?utf-8?B?bFp5MHY4aTZETUErZDdoUEgxNXdKSXhqWGhvbDNadUxPQldyeWFIVS9PaEFI?=
 =?utf-8?B?MWFxTE1zNUt0RXNCcmp6SnplZndjcGwrWXcyTFVFbjYrS3VDc2Z3WmVzWkVB?=
 =?utf-8?B?VElpemZrQWpSV1A2R2xWZllnU2h1d09hRnN6L3BuQ2dXVmlQQ2FmZ0Z3eXlq?=
 =?utf-8?B?NEo0VTVQeGhOdmdlQ0hubzR2eWlVQVRvOXVzWEJvNUl2MC81aVhpOEdnUHJ1?=
 =?utf-8?B?N3FqcFMzS1JPbkl4aCtRamM1enltUEh2TCtCMEFtRWF0WCszc2UwSllIUjZR?=
 =?utf-8?B?dVZuWksvWjZnN1ZUNW1pK2p6UmxSbWRWR2g4SWJWcWtPT2w2Smk4Y1IycTA1?=
 =?utf-8?B?S3pqZnFTdXBZVElXNW1wRVBYVTdNbHdJY2ZtS0lGekVTY0c0VFY0YUJJVldv?=
 =?utf-8?B?cWdVK050NFovZk9zWnVWK0pqK1Y2bXBIazZIcnIrSVVhM1k3L3d1OVlpOFQz?=
 =?utf-8?B?Vk5MQTVOUnhPUWxEeXlyalB3MWlyL0VZVjJzaUF2MmsrRnJMUnUxenNmV2tT?=
 =?utf-8?B?bVVvVGdQTjVIOHAzWHR5dUYyU3pvZ1YvWXVONmN4RDZwS1VqY0VselpJejg0?=
 =?utf-8?B?bk1qak44ZVg2akNoaWdaL0ZHZkFYNkp4bGptMVNkV09ubXovaU5aZ0ZuWlZP?=
 =?utf-8?B?MWY2a1M5eVhIL0xZdUs5QWxRVVZ0N0wwTStWUkk1eWFGVVVhMXJOdFVqcHRN?=
 =?utf-8?B?TnVKNlJzTTdQT2JjdUZRemJBODhpeW1WOHBKOGo0Z2dNTmc5S29oeXgxRWNL?=
 =?utf-8?B?cDRieFlhaEVYV1hYM25pMmppZGdWOHJvNlRrNEQzL2o3RDlwUnNuWkpaRHpW?=
 =?utf-8?B?UW1CTVJRRTdpbkt0bU5NSHB3OVdiMEI2WVVTUGcrcTZJSlpHdFFodG9WcndO?=
 =?utf-8?B?RXpVTkRsUDBJeDZkdmNOSWd6WG5acXQ4VmV1L3VHNnBySDJiZGZ1cDMzalNk?=
 =?utf-8?B?eGV2dm82TjFFVVZnZGlSNTlqMmREYm9XY3dtTmg3cHVQQVE3UU5NcVhhRGRm?=
 =?utf-8?B?VXo0eWszMm41WFlmbjcxWEQ0SmxveU80MFdDWFh4VXJYdmxKcUlwWDZHQ2FP?=
 =?utf-8?B?VnV4QkZnRGpnNWV1K3g1NFU0dm5nenBLZ2szOHhPNkdNTVQrY3lXQjJmQWh6?=
 =?utf-8?B?dythcEFCVTN2bFNNelBKdHZRQmFCbHF5dnFzak5aUzdNMEpzUnB4QXVpSU1u?=
 =?utf-8?B?amVnaXVkaU04MzNleitBbXRFTDVBLzVFNjRGZzZFKzdTRkMzeVk4Mys5L0s4?=
 =?utf-8?B?ZUR6YThZbVpidTVhWEYrcmJKV1pmZ052UWlOZGJ5RHU4WmE0dXEzbjZqSE11?=
 =?utf-8?B?NWFBZG9RNG1sQnp1S01YZDZ3bkNOcUFCS2QxUFVnUmFBS3hjMXYwMDQ4S1Az?=
 =?utf-8?B?UCtBNFFFZUFVRWxrQWtLaHZnTkNmMlVkdjNydDhwSHZ2Vkh3cHdkbkVpWVFN?=
 =?utf-8?B?OTNRNWhYYW5xeE01dEdzWThuNHFtb2dKQ1pDSEdhbXRnVVlkWGJLdHJ0bFVD?=
 =?utf-8?B?cFhTbWhXRnNVWUt5b3l5SHYwSW5QbXBnRUFzMnNWSjlUelI3ZmpSNUlHRWZw?=
 =?utf-8?B?TE1FQXM5bFlFSTcveW0xdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3R2NEVycHArSzl5STVuckxqTzVOTU1saS83ajFlbGwrTTkrK1Myc00xUW0x?=
 =?utf-8?B?bThKb0FHZDZzc3FOZkNXcEZaakIvK2oxdFplTUc5L3JoU2dRQ3ArSDZlcllL?=
 =?utf-8?B?ZXR4N0FtRzhLbzZ2cXl2YTBmTnRkRUdORFJTNDJ6Sk5OaGNkS3lhV1hRR2l6?=
 =?utf-8?B?YkovWHNtSmplQlJURFhEdy96NmFSbUhnbHlNdEd0S2MzVlFZRnVIRjRCUkZJ?=
 =?utf-8?B?SlNrbWRLc3dmZlVWUGZFSDJkTFBUb3pZSkkyVVFxSlpmMnBLMHNRUzJocHNt?=
 =?utf-8?B?dDA1aCtjSzhRUGZZbjN3N2xGU09weXEzOE15SlpCVm51ZEtxcCs3dzIwK3F6?=
 =?utf-8?B?T2Yvd0hCQTRuOHo0NE1Kb1RSM0VQanJvZ3lCMUEvWS8rWUdLNklHTFI1bEhD?=
 =?utf-8?B?TUhZWk5ybUVkV0lHRCtncTVZUmZ4Y1VPZ3lieVhoT1BXWW54RCtMRW5USlEy?=
 =?utf-8?B?WjUxb0kwU2ZPNGhuU2JEWlluRjdYTkRoWkpZcEVrZWZYTDRKRFBWNVlld2hX?=
 =?utf-8?B?bUdHMzJhOG9SY2JaRkoxUlBTTDBrSHJsSERFWWZpYWEyc3dyV0x3Rk9EMWtn?=
 =?utf-8?B?cm9QM3RxcWFlNHV0bWhwVWoyMEhEZGtBN1JIbTh6RzY3eWFLQjlpUWpjKzdD?=
 =?utf-8?B?anVyT3EyajRDMmxxYlJUalM2VHJXTXpvOHNxemQrV2F2MlQ0L210dHYza29Y?=
 =?utf-8?B?S0psUEpMcVpKREQvV1ZXbzFGS0lidnh5OGJvZzUvQU0wb0pCWVM0ZndxbG41?=
 =?utf-8?B?bFF4cGprRXdmWEM0c0lJaEdhb1dCdjlhNzVDSUVZSWg2bHY4NUU0V1FxZngx?=
 =?utf-8?B?b2M5VTlUWEh2dEpTSzl2a1VwV0tCR20yemZkcDBxem0vVjdXQ3VwRDVadFYw?=
 =?utf-8?B?THFEeExwTVMzN0RndENWTmJYSkw5b1laSUJyQXM1SXN5ZnNmSzkvYUd6QVZV?=
 =?utf-8?B?eTlHcjBMT1pMVmp3UjBqQnV4bUFuemVVWFdRRnVHdEpQU3haN3Nva3dITVJO?=
 =?utf-8?B?U0tsSlhxVXA4WkJ3dVZ6OCtkekM1YmhmS0VPdU5uaXJMWHpIUVgwV01tZWhQ?=
 =?utf-8?B?V0N5SkdJRkV1L05uc2c1cERCYnFEaERsYmhuL25GUm1OcWNCSzljZEpUWTg4?=
 =?utf-8?B?SlR2Nkx2Vzh5VW1ZMlJ3cmdwdGdiWGRxL3RUSUwwb3BQWFVZcW5oejVjYlc5?=
 =?utf-8?B?dDY1eDl6L0RZekNyVlJ5RjRTdUZVcDFRZzZSRjJqVGlYeUxUUjRORm9YeUE2?=
 =?utf-8?B?eHBXcnJvK3RyZEFrWkZYN1RQNUtHN2NQTEU0K2F6enBjMklhWW4rWUd1K0xh?=
 =?utf-8?B?TE1QK1ZhTzNTa1VVYm9SM1pYZzZvcXlJMGFacUdMVXV0dkFGbDhnMDRUc0xW?=
 =?utf-8?B?Mzg3Vkw1a3dSb0FmaGZQeUJINWU0L25ZaXpnc3JWeXExWHFSRmxKYS9adUtL?=
 =?utf-8?B?TU5YRzlMcTczR3FMTUdJQm5NYVpiQ2hzdXlaWitqSEhPMUdJN2hqVWkyNHI2?=
 =?utf-8?B?M25DZ2dIZ1hTWk5uNVdOQ1ZKTjZNc1Mzbm5Id3V3V2g0U2lOY0tWQVNYVytx?=
 =?utf-8?B?bkJLdU1lb3l1TTRjTjVUaHdyRmZGYk5oYW1PSUJzQmFXZnpSejVOeXNKZXVu?=
 =?utf-8?B?TENFeE1VL0J5bDhXbjlFRmxWc2pYWTlqdFh5d3ZZTHRnRFM1Uk9NUWF6aTE4?=
 =?utf-8?B?UzA4U1NjWk1yVWZKQzB4SzFjendhaTRMeXA2M1RhZXd2bVR4MkVRM1ZDOWlO?=
 =?utf-8?B?MnRQbFVEYXk2bEFCOUR5L1RpTTVJTmdiaHg3NHhSU05aaWJFK2ppQ2tYc1pt?=
 =?utf-8?B?R3ZiQVFSQmpzY1BlYTV1RlN4NGlMTWpmenQwcFBlbE9WcFlkclJKdTNqWXJ5?=
 =?utf-8?B?YThyWHZDVmk3UWNxL2lGWXJzVnpaR3BWZGJBcFdOZGFMczJjRzI5UzdaUkxx?=
 =?utf-8?B?ejRKWWJNQzBHNFlCUmZ4MitiUTJOa3BOOWtxMVRDUXEyU2wyNU9pM1JYbEtn?=
 =?utf-8?B?NGo2MlJhdm5FRWRWdyt3d1lneDN5QmxrSU5NbXFOYTBNdEpuVVMyOVJTaXFp?=
 =?utf-8?B?V01rSkhkM2hrZ29hL0JocjhqbjFrdXBnMDJ5NzRPMFQ2NFE4VGRUNTY2Slc4?=
 =?utf-8?Q?Zonqj4KnW+qO77c8iMnYczlCN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca774653-35bc-4cb6-b63f-08dc6546e092
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 16:43:46.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+RdPXEtJOlzhKRU+d9VOQC5EJs7+QGEUMyk2qjwuEeflDPJZ957dwcmGQdDm9KajymU9V3jclSKFuWpg5WtiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com

Pj4gQEAgLTQzLDc1ICs0Myw3NSBAQCBzdGF0aWMgYm9vbCB0ZXN0X2ludGVsKGludCBpZHgsIHZv
aWQgKmRhdGEpDQo+PiAgCSAgICBib290X2NwdV9kYXRhLng4NiAhPSA2KQ0KPj4gIAkJcmV0dXJu
IGZhbHNlOw0KPg0KPiBJdCBhcmd1YWJseSBtYWtlcyB0aGVzZSBlYXNpZXIgdG8gcmV2aWV3IHdo
ZW4geW91IF9hcmVuJ3RfIHJlbW92aW5nIHRoZQ0KPiBleHBsaWNpdCBmYW1pbHkgNiBjaGVja3Ms
IGJ1dCB3aGF0J3MgdGhlIHBsYW4gZm9yIHRoZXNlPyAgVGhleSBjYW4gZ28NCj4gYXdheSBub3cs
IHJpZ2h0Pw0KDQpZZXMuIEkgZXhwZWN0IHRoYXQgb25lIHdpbGwgaGF2ZSB0byBnbyBpZiBzb21l
IG5vbi1mYW1pbHktNiBDUFVzIGFyZSBhZGRlZA0KdG8gdGhlIHN3aXRjaC4gSSBkaWRuJ3QgZGln
IGludG8gd2hhdCB0aGF0IGZ1bmN0aW9uIGlzIHRlc3RpbmcgZm9yLiBCdXQgdmVyeSByZWNlbnQN
CkNQVXMgaGF2ZSBiZWVuIGFkZGVkLCBzbyBpdCBzZWVtcyBsaWtlbHkgdGhhdCBmdXR1cmUgb25l
cyB3aWxsIGJlIGFkZGVkIHRvby4NCg0KLVRvbnkNCg==

