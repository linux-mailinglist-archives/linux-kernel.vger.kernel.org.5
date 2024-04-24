Return-Path: <linux-kernel+bounces-156195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9878AFF13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981871F242C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB412B158;
	Wed, 24 Apr 2024 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1FrN1ua"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6B1442EF;
	Wed, 24 Apr 2024 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927883; cv=fail; b=W7uTk9mhbhzlN38b620WRk3dDGrcw95i1/qd0VFrecuMjxlwo10EK/4XxaRpnCN5OYsAkMYZ2Bnyv34nDTcH5amvQZXbOYsXE/qw9agDzZbpYN0MUqW3CMUHeGL6hSXfhN07UT24ybtM9qOOEgNOi0/VM9qM8vjCjOFsEMQR7HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927883; c=relaxed/simple;
	bh=zFXUmCb6hbcsrBXWslEsZv99jvMd17D/IvkPb84vvHE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LLR9HFcSrN15RtGnfqmR7t2y59/yMtq7kJEduaO20WOb4ST0PFYxFRm9KOUsJAkVN4+RePWi63m+78Dj1VIE7typPh6uxHglYrnL5ZWadTViCmJYR/XBIHdGo+JQJFsn1x90zMVrs9P9Z0aJNRvvPVfxBuV77ZxRCv4gbqdgrdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1FrN1ua; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713927881; x=1745463881;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=zFXUmCb6hbcsrBXWslEsZv99jvMd17D/IvkPb84vvHE=;
  b=l1FrN1uadwy18b1tHcx3LlphAaS++VE6s2sHoD+2clWXTGXao57pLIj0
   LP8OISbr/O8vZ2JoBqjna9ZqucDi1/mOs750cQqCclH6XGOA8EogEPUvp
   LebXLO83HQrnpKqGeaXcnUyGF7yCVPlXb7GLCjW/0dLQOIhSmmNtZ1EJy
   uaeOxinsIahhoYqN3hXqqdoM4PqalVt+9zXtSqBsqAtFZ4vk12vM8UvNi
   2KZ6obciOwn8uT+nT2gLFAbw/FQ7bEK0YGNwpiNevirm4LF5DRmmVjpzg
   mK2LtGQ3/FbURaN56UtVW2R48R3SwbwQDhNB3aC4uu6fXVArNlIAjokYU
   Q==;
X-CSE-ConnectionGUID: DJHzzPN3T4yFOFV35/kHdg==
X-CSE-MsgGUID: nybMoN0bTIKu05LKmV7rOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="32028740"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="32028740"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 20:04:40 -0700
X-CSE-ConnectionGUID: MZD3GZrBR+Kx+TjkZ4DVmA==
X-CSE-MsgGUID: HYxYvmBGTDy6YS5R+EKF3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="29358765"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 20:04:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 20:04:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 20:04:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 20:04:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 20:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZ7qQIjSfvkec0wTX0nIbshXowQwYZvpJg8/sMh/sA+I47kpvqgI9wxpjl6zKyut5ix5YBXtsj3T7P0M9/U2cWARCblW0EYbKO1dwDYkVYt99T/Mq1tN++C+iwGlKzWA7uEE4HVK4hQpOLgZQxz07oiGV9XSkytTfYQw0lMVYMWGYhSofOrvlpvPleNTd2M6Xi9QhU71lIExxXCxAPSuKN/jaQct555AdKqMowruboMKNBlmY8s/+t+6SsYN6F+CbRkWzNSlJL875BsHCN+V3hYEdWtOdpJMudeKovPhZWLrowFBvhTQV2vfIZNCpCJUuBNYHkr4H9U1yuiQVO0wIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T34BATf8V5Xb8ZmHcW2lDs3g/Xm4yF1ft4SYd9Oqd6Q=;
 b=jsTJlSZLP6qmnC9mXfizWsaarBXi9zqdC6mHXR2Ifa4qA4FfVy7E0odybjfqff1IjiNznwuYsxpSwkF9FmD9thUf97rN0YWKsUSXWPlU+nbf2WXDzwCQjbq4cSNWnkF69/NeG/n1XsIj3hEPuZ3OexHH2Cq2XzNYorAonJm92DQ1cEP1CD/uHA/oe7FgYCvpH9/MBsteBM6ShX7aVjCsxN9g1aktGOijDbdy6o5xMwI6AdqPkFG7Y0H+AABjl/+sIdyCkAm0UnM4DofCWp1BDI4DLLex2qoYZfMY30IacLISZ06CzfUiZlo9kvFAL+9Cs+6r/KdsllDjgL8HAL3xsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by DS0PR11MB7460.namprd11.prod.outlook.com (2603:10b6:8:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 03:04:32 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 03:04:32 +0000
Date: Wed, 24 Apr 2024 10:57:57 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jing Zhang <renyu.zj@linux.alibaba.com>, James Clark <james.clark@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH v2 4/6] perf test pmu: Add an eagerly loaded event test
Message-ID: <202404241018.bgi3yFxj-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240423031719.1941141-5-irogers@google.com>
X-ClientProxiedBy: TYCP286CA0256.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::14) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|DS0PR11MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f6b4ba-091e-492c-4313-08dc640b4379
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uFekn2Uta+e9fpwbfjwt03MQNuwLdp5IQJwFOxKvfnhdT91BFiVTtlpQS+s+?=
 =?us-ascii?Q?QVoqfn8cSs/ipGU6Lg+NVLjELed84rnN4z31APMTRQR4ecH0M0wAZUT700ww?=
 =?us-ascii?Q?La7D+8ejruHW0Td+sPdag6xYNudzGKiZEnPgQ3FxJgmDiepiHi37yY29b6E/?=
 =?us-ascii?Q?k7LePHaQC++0qt78Kqevp0jMRwK1mXubAuAuYv4QVxt9/mbGP0ZPE6oT6Of0?=
 =?us-ascii?Q?/PFnLJw9vb7kOkHEaQKWZvjqgo6Aw7jTfNUJdYdsXHlbuoftKhz3O26xXcUY?=
 =?us-ascii?Q?zYbx1H4F3IMGYIWueKOmN0D7jj1lYHirjJfer/gZN0Rae6f+ViRiCxloizy0?=
 =?us-ascii?Q?T68u5V3nDcRG+4VTxogYFnKOAEXjXiDmd2Jb95WUOxCqgTBz8T96vrVJ/TTk?=
 =?us-ascii?Q?HL7MY5gMv0eq9ZsyDXr7SwkoN7jyAho04l8AfIatyw0fCs4vdC4w3pvy0KNN?=
 =?us-ascii?Q?HtdbUjjhGi0ZkIBlml9oBtmjTYQocUcqBINGNo6C1j26BASrlPxfmHrCcaDx?=
 =?us-ascii?Q?Mt8iwmfqoTXWYokRDnBOugfnASytv6qz3VsoM6GNasV368Z12EkC6ek8EqL6?=
 =?us-ascii?Q?bMbqDiu0vFc5EDCy5rcslM6WoaPWW4YHRzVdlOuF6Dt01h/XtkDjrYLJj40d?=
 =?us-ascii?Q?Zr/YPM8MwtEoc7K6MZswU9gRz8KkPYyyp058SALgAGvC0j+xdLDPudZJ0xxT?=
 =?us-ascii?Q?drYMdMQYBfJVT2V0Oxg/Cl0KaM7ZTSk53kNqQquGAFWF2pwtOgaDyBni4xPk?=
 =?us-ascii?Q?/U4HCsZy7gRMFi/cLNuBF68NjX/cZCrerXWA81DM2jvToXADPzHRcAmVQsc8?=
 =?us-ascii?Q?kcn9kugAawYuaiZA0piAWTGIqhDWtOeoK93cT+Ys0jCsZ7fH1wk2x41n3lfi?=
 =?us-ascii?Q?1++hgph50aHGl3hjWqq23At7JGLbuxDW3UwpbCKVIU5RuAGlolnsyuH8GI3O?=
 =?us-ascii?Q?GCaOy6qNUL7DRnQYX9LuZ4hQkbV3kxc+944RWKbJVeCLfktbQh+eXFp/q6uF?=
 =?us-ascii?Q?x2J02AomNfF4Jki21Gm/pRogscowKsnMfBiLr2ZIrQHE6vlGqr97UlCZiAmS?=
 =?us-ascii?Q?2lhyU80fYWkFLBAp2nO02gL7VyZuzBZoA687yXVMFmWdtEtg4nUkabmVHK91?=
 =?us-ascii?Q?bKYjhiwhljr0hUQETJwtkJ8/dQ/ZaMIzvvg6ZHckmDFGXSGBWJYF4n8k6E3i?=
 =?us-ascii?Q?0WmzoQyQQr6iWGG/CRG9IlNimMG1xuXpj16Z5kiuiQ1x7lmua/Rtk7LvmKDB?=
 =?us-ascii?Q?BVKM8Hz+38QTm19I8Rdk22JVQ63AjWEDM03K5hsU2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vvE3LQLyW7ZR9vBmnXW6qT8gvZ/PNBfuoitG4mGFsKj1S8ek7sq7hZlFGQFV?=
 =?us-ascii?Q?quV6tecvZRIUJX6QL6BH6XLZCNSXIb9wriPko255JcQno7ZIkNXMUW/oTM1s?=
 =?us-ascii?Q?zNomzJvVpB4gFKSyJ7AUvk9X1mqUQadrmT9xO7b+1gSFmaBm3OiK4yK7z5ni?=
 =?us-ascii?Q?7aAyP3H6k2r8oAdmEIuIvQ78SDTFzEaoghyp9+KOl3F32pAAo+wkoE62PJ7k?=
 =?us-ascii?Q?GmxUdPDfmSy64bF5GBVLatJRRJAbs20va6FUhmw5HcCedctFUwBVAivZQd2p?=
 =?us-ascii?Q?ajMcXMjL4oBvZiQBih+Ld/zjGN39cUQyRlEqF8irJVzn51ogAhIWUvT3B3eF?=
 =?us-ascii?Q?3gCRuqVhwq2PEeXhXTMA7d46QLDV8MUC1hDi7u/px+hC10eIhhW4aJjKbI3Q?=
 =?us-ascii?Q?BjMvv3vCvak3qVeUv+wzcJFvInBQPl7qvrZIPiBtdmBMjUerRahxOm+Cy7X4?=
 =?us-ascii?Q?UfJqWWy4ObTo66v1LsnRRe4jU2C3a0taonx0uMiDaj6nvKzfR8yvb1X0f5m9?=
 =?us-ascii?Q?POnWR2+PVWx8swSOMTP36NASAo/ceaCtA6G2zY5y5QZSDOoQfQ163IKRWnRO?=
 =?us-ascii?Q?Fe7uLcz/jvWAEYIbc8UemOiq6KvITWPFWpMXBS9c0HD+ol9T3cNlFSlG0nnE?=
 =?us-ascii?Q?H8oLzBFbd1Jz6OzsKKsBOXriB31VaTo6OD7fP+oaU1rkQIbCCZ9BZsJsunZA?=
 =?us-ascii?Q?65GZGSXF6fj7GM+vlZ109y1CTkMKEEn/bTf87dlRTvsUjMr1AUrpTaR2K8yg?=
 =?us-ascii?Q?Q3ID7MpcZu6mfbIzrJuS7kZYYHyLzxXggb/4lqHMcZfZGjR5AVIoQgI1HtHC?=
 =?us-ascii?Q?k8LejOnoLemFsNPe8G4i6NNwHWaza8mf5KE2nuHuolt4Ic3B0SMrpwQC+MOG?=
 =?us-ascii?Q?/50+mhDwpEKi+OS0RmTAdDxBJo/rv3BYAoicp0rzQ6rEiA7+aFWimYCHIwdI?=
 =?us-ascii?Q?I8bRYMaP8+NoCjQKeMBu5BUN2aVSYSQJNbNkbekIXU0U9zMkW8I+iuA7mtOs?=
 =?us-ascii?Q?7bvGfHBkX4jXFgb4nhIyeNNojAoWnLMRJKVEGXfxmeWEjEozt01mMZVcP28z?=
 =?us-ascii?Q?xOiL8a4TYf2kSUnt5AWu0En2eHtQirCNGiQrADTWoTHJ9dAAvWEwZnGp8Ooc?=
 =?us-ascii?Q?sR3nMVSSqWqk4GyaoMn4o0iLgDic5OZ9FB1tzFNxX1FN2Lj7S/eTfeokppcW?=
 =?us-ascii?Q?q0vciWFyijqRlgsllB6LpaiUTTHmM6QSBw3k5No/SxApep7x8WqLHejU2hDQ?=
 =?us-ascii?Q?MpFz8H8AXzeDrm9fgbzP8AuAp1wLuS0iOpTHpYYrOHcx/qtS85EmHBtyooWK?=
 =?us-ascii?Q?tSrjaJm4f+sSk6k2njcTyt0YPONGqodBlnhUBa1QEKkCP9Ub/1cwlJ/CBJlq?=
 =?us-ascii?Q?G1BmsOy48jV6bL8lYQS/e/YNejhWtXXc6VUZHNHgAxPgUcCDv59IudL19hgv?=
 =?us-ascii?Q?Z/9u6rTeAd1Ft9/Jjr2cLqBce3oclRPtyi3ngBymywat6r199jegViOf5sVY?=
 =?us-ascii?Q?npWgzLumWFQAp/n1uXZc/Oh7ymwG5BjcsfCdJUQJsn3sQuQsTRjZr8HooNGo?=
 =?us-ascii?Q?27SeG5dq0Wa6BrSRd5HDjRWK94IRHjw/f9/jXgs6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f6b4ba-091e-492c-4313-08dc640b4379
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 03:04:32.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGxfTcxYKnlIowBFZanSpTMsa8un7aKpzwHkgBGAX69SEe6eI5icV5NyzYGwXjGqEkdjcMWrvV9ihQ2DaUwCCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7460
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
patch link:    https://lore.kernel.org/r/20240423031719.1941141-5-irogers%40google.com
patch subject: [PATCH v2 4/6] perf test pmu: Add an eagerly loaded event test
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202404241018.bgi3yFxj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> tests/pmu.c:128:9: error: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Werror=unused-result]
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


