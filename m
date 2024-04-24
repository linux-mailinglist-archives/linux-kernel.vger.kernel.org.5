Return-Path: <linux-kernel+bounces-156186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F78AFEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB8E1C22803
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C9F13B2BF;
	Wed, 24 Apr 2024 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mslXr/HL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C16129A7E;
	Wed, 24 Apr 2024 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927500; cv=fail; b=r4kzFjkX4PP+JWxNzq8g2DvIlu4w1IVtx0F3urEMZZfJZIbxZdaFGEhKNRS8oV6HE9i0d2IngvQU5imDIKZ84klTmWX9UT5a5/v1DPASZAsFID4L1Ua2k1AFa1qgScEk3fIcdiFlW+mbJPlxldK1TZDq8JNF6Pg1mIQZp3k04ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927500; c=relaxed/simple;
	bh=T+HFl6oJhR1M34PbS3EonvgPHU1hFzkIzGsBFFjUN8I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jlL2VJ/y+/2RdI3Ukz/wArUgGVr0poVtd8CS0ybvCiXAt8Tll3hHjVubQWUtXsYPEuH7LrRGK5jG+nIusiTFsUTe25adXB6bLVHMilkIVwPV5uR9/rZDZXPP5qigS8BJXZZA+nIukRPCKY+s0njPYhy0WgKfSsRpneBZEMu6r6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mslXr/HL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713927499; x=1745463499;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=T+HFl6oJhR1M34PbS3EonvgPHU1hFzkIzGsBFFjUN8I=;
  b=mslXr/HLnA3U9d/mobYTwNv5ayG6aP/fy4n7cEmEKUEue04LG8g/tQ6r
   xsc95kCoU4feTOoa8DWE2kelsRxICHO4n28GaGeIZTMgdciuj8x1AFHco
   jACdtUDoVTrh4kEkCh2ci3byLMYLgMecMZGKz1ylPYRHofg3vFJXLiYig
   Mo75SvNFZR67qCL6cYTdfBc6/9cwzbuAgVgV1R0Vh1ozwprQtABEt2owF
   SmAF/QNTV0Bh0UBpvmu7P9nnke5LxGBF37xN52FeQQS45B+Lxi/XQNcR/
   /NFBUOFqQjrHf/fQjHUwsY4DxUb0II6e/A7RAQPsvcamjIudXmo70tDjx
   Q==;
X-CSE-ConnectionGUID: N4ll6zKGSLCcwA8BI0ZLdQ==
X-CSE-MsgGUID: cKSMXuP0TYSEFAao9W8rxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9704876"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9704876"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 19:58:18 -0700
X-CSE-ConnectionGUID: 5FB0gXYpTayagFyXbDT7ng==
X-CSE-MsgGUID: 5JoLcyoeRGy2ojA8LbmfkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24598353"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 19:58:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 19:58:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 19:58:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 19:58:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHR5YyHMuvTOIYLPGlrlfrNpkUKueRSShvdYOl4p13K+eYy/EfDAM4nXC82eoRvRbiakBYuVcBUiIXthNFgxnyNLQMHOmIgBp9HFNcFTOoteyuddxZKGZ6cr6ZqQ1dSC5+Nrt3VYxEByHYngbXmqkEAs67GgJqcGgIbfOJh8OsMLkt3F5qxtdsvopizyzYyoqEy9kDgE2MjQ2OpldC40Yu2m/AG0p5l63ygCcCJ3tHuFUoiyhOvLPFm7jP3Y1HvXSWpujLS1DienUib2yjzB2a/pRyr93HWD5XpiEk8glH7nTrRgMC6X83kiTXAoFWcrVUDcKnuU4wJL8U61v42DEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7Rk+YqGO89egvdafI4K7NpsecFF9InYsD6F1xTCT0s=;
 b=Q7FKt6CsFjd6MhDa2v4etkOz4OdFwwSaggX8+kp0XtSEdIMZQlPnqPqAiIYdizJ1gHaf5U1PGvWnd3vPIrrFm8p7/kGf8pCrzoTgjXO86cWgIEtH2JphSbaL1uvWZz73dnJtkYWizNGGhiHkgU77GiAPm15MsNdw+P9CTGhPs2NbuPpqhQHvMn5PWbRBvwzhiq+LO5ITZAQ51Xc5tHeGjcwjIiUfayqFAFdCC4H/O1el0J4LxIgLp0vP3h+xgNLpOBtsk7OmGWIwav1YRPor7u9/8bURPbPAsfC0yyGMGM1SP/YKcG2H46ABrSConSabZ/9cUmsImwUqrAZbSAh83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Wed, 24 Apr
 2024 02:58:15 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 02:58:15 +0000
Date: Wed, 24 Apr 2024 10:51:41 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet
	<corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, James Clark
	<james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH v2 3/6] perf test pmu: Refactor format test and exposed
 test APIs
Message-ID: <202404240706.4zQmkds8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240423031719.1941141-4-irogers@google.com>
X-ClientProxiedBy: TYCP286CA0195.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::13) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|PH0PR11MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: b857d58f-2ea5-4915-90a3-08dc640a633e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EMZ4afBSvt57LZK6I4N/Sm/sL6byIXH9Wrx/BzDZV2jhbS9u2lv7tFODg8HO?=
 =?us-ascii?Q?q3blaTeIZObR3y/WC3ZzueVw84ppS72E/sm1R43BY+cZBQAuWMBu7v9wwcWj?=
 =?us-ascii?Q?SDwGV4T4FSPLUHR7hzMgd2Rxn6bdCDMBlpCGF5SrodKCDnA2FsPvnFpMpFAp?=
 =?us-ascii?Q?x9HyGpvmpUtw+Tw+/MUAPHQs/qCqvgVage1nKDafBmIG2lsJcrQEsbP/XzgI?=
 =?us-ascii?Q?pLgdKNX/xQ/dSfOJGiFnVt36yprvnJKg1FLoc3WZtPjWf3nLSJbaFYYMhQQk?=
 =?us-ascii?Q?wwMIAC4d6lc/WQcX/nKbc0Dah6WZ8ELc6tMswMKAYQOkmn0Ys1qHyf+VR9co?=
 =?us-ascii?Q?mlba6idTPIuEKjRKc4QOHZIMSJ/c+cQutn2+/L4GEQNuLRVB82LAvzePPUqF?=
 =?us-ascii?Q?v4KCW+4xu4hGfCvahgo2la0T+FZiAf8YxYsDzaUfmJ9fCkJt3Wk3tJ6drSAl?=
 =?us-ascii?Q?3b4ysuinVGblWNkJND+dwTVvRqNJACwUfOLSSIxJIaln14Lw9eeXgniRzUSV?=
 =?us-ascii?Q?Q8/CfnxCaLpW434Kpy4e5n//0tnNzaBQUjNnSEYio4w2doGC8Lv0mKH5yEL8?=
 =?us-ascii?Q?mTpg8S1dQdHjzqp9/LT4eE6BH5A0xndMnwxtEypvzanOAdiOS87foi5KYWKk?=
 =?us-ascii?Q?dSTJ1RMNnofwiT9nHkmtjsi2k6r9O4Q2ab5+mRcze0qULyau9lSRTk/pYfbt?=
 =?us-ascii?Q?ZAUNOMi1L/YP3JNxXykh4/jEi2YzDFK0AEgCV75XWIUOzZaA/S2evWusfXbV?=
 =?us-ascii?Q?x6nPFi2sXOy3cAtCH8bArPTzjnkB84dDJNZW+dMCZrsdjwiYRxcoCN6Zjfnn?=
 =?us-ascii?Q?c+ayq52rMThlnEfZawTPDm6pWBjAD1p0fBN30Qa/2aYzYgHLWaGv9udd5UGj?=
 =?us-ascii?Q?5LkpbLfZ+AsZZ1Kim2+nmPMa3WVPfkQM39tCEJB8Udacg2ZrZQr3k+aP/lYS?=
 =?us-ascii?Q?cc13YrOy4pD4vPWg/qB8kC+oji0NsozaBlrjVhhgvMcnaLQn5jzlwfywb0Xg?=
 =?us-ascii?Q?msEtdRQZII/in3s+ot11OpTJQazdLuirgZqn2DzBQL8sEVG4aTRM8qermrUV?=
 =?us-ascii?Q?3ix2r0x9UOtZdA1IwAV6AQ1tdlw4xTw0hac+4ISReyOPzFFvAmkAHzkdPpaX?=
 =?us-ascii?Q?1cpxlPFUn04HVWyRZa/NspVG9T1fqKCVvZUF8/pX6K4ZquXbGdRKu+uZuEx0?=
 =?us-ascii?Q?499dGJFpx+X984q+C6wb9QOo8DTXNJaEJMieeDWG9UqY5JkECp5DfgPoDaDb?=
 =?us-ascii?Q?U84V6g48XlqceUMVxNisTWaPg8PyZU81sgLpYXngJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBaoJGq8Vba6JBDTpCKnRtg/GtQEPdlrgHSLflHUxySU/wjHfRmbmDeM5vWU?=
 =?us-ascii?Q?YFRvi7MO60zKDZxpvLJ1Q9PT5+ynbI7J3vG0QiQraofsZ5se5quWDyLMHgex?=
 =?us-ascii?Q?Jw4YzUy331Glbxk1YCZ26JthPH0Vkak4ZTdarebyswNy3Dgtitsv1hjmz+I0?=
 =?us-ascii?Q?Hnfx0NtvyTNvB1omMBXTb3IKaa9YP0q/VkgbCZn//QGRvEU9JVYda7fihttu?=
 =?us-ascii?Q?qczhRtf+p3qHViKXh+45nVvuz9RLA3IB6IpN0lEgdMEvdlFlXtwAqt1/SCXL?=
 =?us-ascii?Q?t//GTrWA4SWPni5pW085vKkWKUyC2hqi87ujiGBoPodOmTt+8kHJZysZKujs?=
 =?us-ascii?Q?xAnSymHWXIS15RxZ2AKZQwIvEVJ4e9bmOZikKi6PBLW937si58T2LcyOTUf0?=
 =?us-ascii?Q?IgptdhgeKBcBoDx04tFf3zFS8L2ec7b0Hq4p9JWkYEZaw6f+B8lJRQsyOoY8?=
 =?us-ascii?Q?EgYEFv+0I9qakHnUyRXoG0sab4+aylNFi+iIjKfHyvLorIerwWyufG1ZDtPx?=
 =?us-ascii?Q?N5aZ2CgOXvMBlK/b5F1OlYcHVMo/mdi/ozdYLwFWd2ncZP7FTRd9VwTBW/zX?=
 =?us-ascii?Q?bqkVihAnw+WIA1XRbWKLRmND8Lpcy0nrxHWZRQYx/J7HDV8dDo36ZWstOjQr?=
 =?us-ascii?Q?q7K14B3U8L/PbreaqMa93HYA3Q96CHz4dA1DMrDuv+mR2+mEPAxbmtwfQlqr?=
 =?us-ascii?Q?DOsT+BqVXzDkSm1qTG+wSKIaZwUgDmGepbVCbPwVk6PFgWYjHQkbxKNW8MRl?=
 =?us-ascii?Q?DENpRRxpLxycFKu1fAIVq4blamyPAgjPXW+4avzKWnRMT4P0UVOmoQi8RAXK?=
 =?us-ascii?Q?4OVe3Cjbhw5lEAVZG1YZIrE8sg9+kTU4pm7dkU+UODFC36wVawwJ5wgxKihh?=
 =?us-ascii?Q?X28IUvyHKDUam4yEoBtGhq+rIR3r+dxszwD6zc7fqZI25sBFiuRGXU8UaFMI?=
 =?us-ascii?Q?ik48BG6FvbJaFIzclKiAIJjBnF3HUFqcFFSxaTKz0I8yK/eA8Jp6ExU3hUHV?=
 =?us-ascii?Q?lfbGVeKKuSFu2eUdizOx3BjHLVJaK/4/67mgYM3nSFjtzKE3r47MwYeyDWR6?=
 =?us-ascii?Q?TiLASS6/udtUdq2Ezrrj+c/nEhjxafBDdrpR6LOYLfyiLOk9OLCoT/PpOWC8?=
 =?us-ascii?Q?akRZsOpGKPCEVKwd+QdjVAwcBuRgTLgSF9hNXTOx9ruDCfa7IulPrC1cwSLY?=
 =?us-ascii?Q?GpX0oeJ4kajUcnQkhQ0pd2w4RJcouT+nG+zJjMrO9j9WmaltwBtQmIgdznZX?=
 =?us-ascii?Q?veywyTvU4+xDY1tkAzb2HsCCYHezaJ364bmGP7m3doj5vYl+JG4JwH1C/9Pa?=
 =?us-ascii?Q?GMu2N5Rpl0Hl6mCS+15NYRq5Kd1dr0QZ+Is1geF73nsVRbd31wCve62AkzwW?=
 =?us-ascii?Q?yi9yUZBoP9jSMw80hbhtTVw245aAoqVoTFWyA2grc8ffVIVdQLwM4TQ+UpvI?=
 =?us-ascii?Q?kGtMmZtpAhjysofvHGHEQ/a+wf/mJL0ibRun3HPFhSCXv82otTUNfamUPZGB?=
 =?us-ascii?Q?T5/h/IRJ6JeKevVbquAacblXJ1/5bfag3iiSc7yyssZyd0DvV76WksaiNhZp?=
 =?us-ascii?Q?6WjOzzlQSjMgffFTT2aZPphGnXrP6cvoxOw50gsp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b857d58f-2ea5-4915-90a3-08dc640a633e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 02:58:15.8286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMh+ZfR4g+rSyYATfqiHUUXVfMX55knrQuMXyWxEN9ZrQQO/JYD6jXLXcmpeTZHOBJ6TQASyL0b4GcvMq/zQww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-OriginatorOrg: intel.com

Hi Ian,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v6.9-rc5 next-20240423]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-test-pmu-events-Make-it-clearer-that-pmu-events-tests-json-events/20240423-112057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240423031719.1941141-4-irogers%40google.com
patch subject: [PATCH v2 3/6] perf test pmu: Refactor format test and exposed test APIs
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202404240706.4zQmkds8-lkp@intel.com/

All errors (new ones prefixed by >>):

   tests/pmu.c: In function 'test_pmu_get':
>> tests/pmu.c:84:9: error: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Werror=unused-result]
      84 |         write(file, "9999\n", 5);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
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


