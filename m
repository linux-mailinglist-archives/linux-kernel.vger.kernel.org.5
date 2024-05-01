Return-Path: <linux-kernel+bounces-164883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A691F8B8473
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E4B20CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ADD22F19;
	Wed,  1 May 2024 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyZ3XRFW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FC1C69A;
	Wed,  1 May 2024 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714532765; cv=fail; b=B3bX01RG+2nZxuzoQj34o+YL0z9/Cc12K6GZtsUSAzL6gFee1J1olTddcn9g0YsM0I+3Ievos1hz89hF+8ej73WrXfRar9ZjpQoGNIKohmVYsCEZpnL3VYl5zsxOZ5UYOtgizZ+verukgsFDgLnfIt6ul4iLNDR0E4amGrn3yMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714532765; c=relaxed/simple;
	bh=se2hJaxnve73FOTvKaHCBGd55UYmvGpwj4xodEn5PuI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MElNjeCk0DpElBcOJYJh0Vk2Gn2H1Wnj673FWBwx8vT0+BG29AqxyXsYPC3ag26AM794IstQQ7xSgdzkz5Z7GNgiS3DdpuC0wn8Ycrn7WmAgOM10SSMwmUUSt2UQgPoFyJd3+vwoPAwl7dv4U+VGfd0G1wMkj2/RTefFyyuN+NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyZ3XRFW; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714532762; x=1746068762;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=se2hJaxnve73FOTvKaHCBGd55UYmvGpwj4xodEn5PuI=;
  b=iyZ3XRFWZAbCr+WBLkamj430MmaTwRwV2xOb3c8eeik07O2lcTWS6/sE
   wqbf5DWMey6dNbJtccCJRe8x+d14TdPbGluc4/JhFAkjTRUdEFBA+uX0l
   tRyS6+CNeBE1KAWcWJlO/I1Oo3oGSOctrmE/XGJXrlFwEaxxToe7YNagl
   nVmZ6cAaw8Ggq9W8ky4X6hoSyFqSXME+LORUAppSRZMWexbyU0Co6Y67y
   wjsz+pHaWeBa4865KlIkEx7jU9kAFNsWDBmQhGYkJMDgN51j0bknjUH+f
   vO4yfMAnnkP9bzT4y8iSIOveSxhqXCLlggKmIFaPWl6YX2dq0zGzIcgjh
   A==;
X-CSE-ConnectionGUID: i2n/NNxrR06Y8SEXrb/zWg==
X-CSE-MsgGUID: STcaSFfMR0GURbjsAuV0Bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21415295"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="21415295"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 20:06:02 -0700
X-CSE-ConnectionGUID: KQ0zDjR8T5GVr9/KP8qamA==
X-CSE-MsgGUID: zXteodrsSjyoKN7d2tHjlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="57844389"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 20:06:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 20:06:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 20:06:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 20:06:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 20:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQOz94IVXbzlw0T/DGe4Il4ey5Jg+TpDO2+47reBvnZYlPKE746J3UumSEX3FdjJ6PgbCVj24amRliqYYjyy1iirFJSoo96OkBWR0clXEiFRjpzh/C/FFSAgpMzbGZOVYc3zqi2do+dNKTvvIT6rlOD1AUTSC0U61p9qV1TpXZIkbYycqYUgYE8fMZkItV96BJI9NKAfLne2g7i5NO8+kH6NJi0zP2+W0lE3yMystSd65aM6EgggwYnuBuz1/AWS9MLIioEjesGMIYo7/i/ndLSDlvNiaMJL/gIrwVWYP3F7cHXaN3+LBj1sSNblYfmxBqteJHdiCZQfbFdYBNbfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVWdrXygftYMo00oNeiI1lGfNYxkGW2c12IfQnP5aoE=;
 b=g8DBpaighih3YWU/UA6Pa/Xyk9U20XRddWDm+e1BMa1dXAY8JtRa702JXVuSQrVRrda0LWOa5okGsN0j3AUgjvT/D6k7dwYPd5PfDCxotwtEpkl/YBvfkqpTHBaQCsqTncPaBmuTTKzXEjSNIeI99vlqlV+TGVuEOfxqoMsr+jl2Bzy2l4gWoRKcqx9/uNb0EqXzua3Fz5oMII44e90oJymIjxGtt7r91xUpx0TVpD3JiLCxYJEL5DY++teUnna6Jg8poHoUL8N2CDk49iWy2eklTQXXOPcxn/ReSy0GPCxi4d40VulCip32myMFt3aG7L+73bG2o8fOy4trt7lDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by CH3PR11MB7250.namprd11.prod.outlook.com (2603:10b6:610:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 03:05:58 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::35d6:c016:dbf5:478e]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::35d6:c016:dbf5:478e%7]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 03:05:58 +0000
Date: Wed, 1 May 2024 11:05:45 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
	<rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, James Clark
	<james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3 4/6] perf test pmu: Add an eagerly loaded event test
Message-ID: <ZjGxifxFjsVfaAdH@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429200225.1271876-5-irogers@google.com>
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|CH3PR11MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: b48ac8e9-21cf-4c2a-2ede-08dc698b9f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H9FbdNgeyfjm5nMJwXh0Vj4c9DDJNeCHZ1xmR2cq7l7gUBIaYw1Xz78Z6iwH?=
 =?us-ascii?Q?hizyfSXatuBURcHbBc3wrCWNQUMQMTxjJ4VdOUa560MmpYppATml+of9TDU5?=
 =?us-ascii?Q?zYO1JKPeCEVk+UvbpeDzQAg1fEnGaUDcwuxz1+MmbcCBoMizECex83OcFwZM?=
 =?us-ascii?Q?mFR0cvvk+42YU/14b4fUwiX1mK5x4vA2AQq2KUf9Esg7LtVfUoLAqzxdlMCw?=
 =?us-ascii?Q?9mEnroqeCmm9vZSzL44xcV7SuvZ8zBa34MmUQsJD0aPsyjN0rtxLnZPvEW4M?=
 =?us-ascii?Q?tsFhUFnRY9U6jH91TpMTRlYm6rwbGLvBK0a7zrivLD97amgeFASTuDL7ZQNf?=
 =?us-ascii?Q?X52fQ/6+y1OZSckNDRsUz65Y7RiYdsKPkE0G8ka88W4asG7w/ZSoKK+lMFVY?=
 =?us-ascii?Q?xWCMxi0zgaFFbWhClI5g7Zl+VQjCNulSPbMPL67Dq4BkumiWg0u/7YFsVt/Y?=
 =?us-ascii?Q?Iq/VNlgM1b7vY1Tcma3Hut/M37LdK27xkV85+AGTlaCUNDp4XkHG5IlXVYxz?=
 =?us-ascii?Q?Sd37EqxSk3CGCfy9J6i43+u42DaezL5tNgPJFTZ/Kzop+P2XxN7MwKY9eD+6?=
 =?us-ascii?Q?PL4YDKsttM92Hc3M8jn9V+xaYWCL1soDsKcXjNcRi8T8DwwFNznEfwHwT9JU?=
 =?us-ascii?Q?qSesVt4Ca431bDuMymxL+kUTWhy+aBc9MdJvEY5H3dMY7PpQfWXWG4c5gcYu?=
 =?us-ascii?Q?W2HH/gaqoBo7akUnhRBHbXxC1FeGaVw84y5aGrFc/I7Y6gBVfyxYYphePyi2?=
 =?us-ascii?Q?4NvbNitcUKjvCGa52uZibFaa3UgNmzLCf/nCNXZCxwwDWypEeUa3UmFb317M?=
 =?us-ascii?Q?msnY+gTbhvxdZ+S8/oanekE/Z+SxSK0933N253m4qFlPl4IWl+yU7pQBzRBD?=
 =?us-ascii?Q?oVqWIWV56Tut7JPypF05NCeWAQq7uDRNVlCW9BRRLvuqtTCPyWlbgRW0kbPZ?=
 =?us-ascii?Q?Wyhtt1KWQw5sZxCXmgYnrIFrWLIle+fKzhHiSVtwIIfX1GpOFW0OnE6nmTWE?=
 =?us-ascii?Q?El+W0Vewn/pxkVxjl3/oXIQmhxV40/xZT8P31WVCemcuO+s9WATyKyqSbC6W?=
 =?us-ascii?Q?zxgjysbAYMYe0gwA5tkFt9odxYzG1wac+mZ49PScUY958Q+K142hCfahwOIv?=
 =?us-ascii?Q?ui1aEP2ZQPW91v9be0UKM/Zzx08sXe5u58pkv2UsywlkSfQ9dXbUiJoFQJ+B?=
 =?us-ascii?Q?NOYI7J8mbDIhecUWvRpo/Dcfj7mbuoap+vOvpsNoy76kBikcK+CI15k7gzDE?=
 =?us-ascii?Q?uF5cEO3V7cWQE1wigSmbM+ZXm1ifpITbv95jbpAX/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ZytXwsaiqopljkgWKVQJo4FOZpU4ggNHgHyJPsri+p+ZujZ1+l7eNHstIUw?=
 =?us-ascii?Q?QyNlgxcfJAZ9ZXJtMDkgXnGGCDj0kCNmhrO1Zf359ycztAoydV41IKYWXveY?=
 =?us-ascii?Q?dvtiMkUippmDJpa3FslBKA37vNaYmgwfChfW0MU6jq6fyaGLR7mYNpmZhqy5?=
 =?us-ascii?Q?81pbBphMOZta/kKj65q2ascsv0R+QIRezbLcaHU/b++cBzHpcPpo5MorbLOL?=
 =?us-ascii?Q?BljlwOnVG6ze8Cd1IQBaRM4GOjYyHFcyQQ4N+yXyJTQRidRXtTQ/BU7ynEXI?=
 =?us-ascii?Q?H7myDfR6ZeZqxfGFQ0WZXA3GoHDxPY/UdMvtENmbbCPjbiJjhvAE+zprgviO?=
 =?us-ascii?Q?QGS2p300xcmdz6ED5d5LcTCmfSdOYX2sbz4s6dD/0OVC/tO3EWUlt+WCsasc?=
 =?us-ascii?Q?wOf/e3pqXGGbHI/0ivUbFiUicr0zR7Pr5FETsE6a4ohlG4Kd7NCamBzVSNQi?=
 =?us-ascii?Q?ePdNtqHig9doknzn4DTvDM4OoTtfKrpk+x6FDAeeZBgsk50ZpZpZbu+3B7uw?=
 =?us-ascii?Q?tNECNEPaCg4TZjHr1wLPL6/F4CmuTLjXL3HGy5T+lK5TSuHddUEVY9Ivb+wD?=
 =?us-ascii?Q?g0E8C08JbBNMoPzrokSirJel5Vu+3Dp8C2DU2sxiZnXDAYIm+ZAag529cZr5?=
 =?us-ascii?Q?DldsN2Mls4Ym8jNX/jxYKBNDJtECTbHqjgTa2ybc/FR1Q5JGbBEuV81gfoCw?=
 =?us-ascii?Q?4b50lK1ejUN770v7mgcMlx3+DD6PTOekYbqHIJQfg/M10sMEn+jiBOBdVF5n?=
 =?us-ascii?Q?DHi37Vu1p7Um41QL7SJ5iXRtI+fqyGZFHblAwVxbEg/1vewQyVMGK+/rMmkp?=
 =?us-ascii?Q?HGQKqCw15x6oHqV0vmq3UtiwM0GU6r164U1rpAiMYedOKxQ3h/xge4sHucmX?=
 =?us-ascii?Q?e9XhtmHLue3o6EeLZQKJZNh9c4bzJF/CnHiQzFBUV3hLyjaZ77xd2hGOFy+c?=
 =?us-ascii?Q?5IJTwxE2a4Q+58fLtH4sCzGQVwTITNwma9hixVEzxVrthLTHnEsNyi2DfiMZ?=
 =?us-ascii?Q?StJ685CaJrmrlyZhCaHJXQ9cErYQhrj7LnsH2ucDfr2RRsa+i8sjVSEPDdhj?=
 =?us-ascii?Q?/rkm/spXwyxQfocxKEeqiRggDkAX4tFPdWlNob6ENg4la5/7iQ3Qovd4zdl5?=
 =?us-ascii?Q?54PqropoLCEkhoEt3q9VC/WlS5BfH6z/TszPTBcKn4mSJ9XpglNajFf8z5lF?=
 =?us-ascii?Q?OVTX6xPNyM1PwaWTIy36xB7vQBogT1iU0d421rkNz4SwAa7z5qLaH4sB41mX?=
 =?us-ascii?Q?jQ/s9r4gG+b4+B7Lxra+VV0aLI4q5slKcLohckna+8hTZePXZ29iPC24DeJn?=
 =?us-ascii?Q?7x2MbSBCmQwTCRscp6u2BKIRPcYEXHR0v3qOJdkBTkW659Hu0r+PzncTgL1S?=
 =?us-ascii?Q?JoCW2qIqIhlcZR3rW5x+0rMwTECCgCsLQnqbwpJ6h/k3ZN5c4D12lYvRCDVR?=
 =?us-ascii?Q?SgfKaohtwZIAKOFUHaGt/AfG9nqeGQViSDbOqUCaMDslT0xvmhVSRiXTRCqE?=
 =?us-ascii?Q?Lt6PXDCqadLhGg3ukrPqOi5gTHnQ/GSP+KavEUxWrTwV5lvFNz510gxfsuoK?=
 =?us-ascii?Q?E5q/UBxhLVm2v/Ar7Sp+OV6haiQ4Hcj5xIZFblih0IrOO7SJZVQQJBPXI563?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b48ac8e9-21cf-4c2a-2ede-08dc698b9f7f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 03:05:58.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Dv/ODdCXbfZf8lf+1t2zC2rqM2UaFXrvtvmPwdC9NJNVk7fiOoo1HdppBYlAJPgUEJGctUPqtRfw8KWHeN9hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7250
X-OriginatorOrg: intel.com

Hi Ian,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v6.9-rc6 next-20240430]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-test-pmu-events-Make-it-clearer-that-pmu-events-tests-json-events/20240430-040959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240429200225.1271876-5-irogers%40google.com
patch subject: [PATCH v3 4/6] perf test pmu: Add an eagerly loaded event test
:::::: branch date: 23 hours ago
:::::: commit date: 23 hours ago
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405010256.1BDkfF0K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202405010256.1BDkfF0K-lkp@intel.com/

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All errors (new ones prefixed by >>):

     PERF_VERSION = 6.9.rc5.gea45a6cddbea
   tests/pmu.c: In function 'test_pmu_get':
   tests/pmu.c:89:9: error: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Werror=unused-result]
      89 |         write(file, "9999\n", 5);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   tests/pmu.c:128:9: error: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Werror=unused-result]
     128 |         write(file, test_event, strlen(test_event));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   tests/pmu.c: In function 'test__pmu_events':
>> tests/pmu.c:241:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
     241 |         return ret;
         |                ^~~
   tests/pmu.c:198:13: note: 'ret' was declared here
     198 |         int ret;
         |             ^~~
   cc1: all warnings being treated as errors
   make[7]: *** [tools/build/Makefile.build:106: tools/perf/tests/pmu.o] Error 1
   make[7]: *** Waiting for unfinished jobs....
   make[6]: *** [tools/build/Makefile.build:158: tests] Error 2
   make[6]: *** Waiting for unfinished jobs....
   make[5]: *** [Makefile.perf:727: tools/perf/perf-in.o] Error 2
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile.perf:264: sub-make] Error 2
   make[3]: *** [Makefile:70: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


