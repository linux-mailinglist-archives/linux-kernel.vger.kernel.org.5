Return-Path: <linux-kernel+bounces-164884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C6B8B8474
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C737F284796
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D70282E5;
	Wed,  1 May 2024 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bulNMw7L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4B1C69A;
	Wed,  1 May 2024 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714532837; cv=fail; b=ZQ7pQlh9xojFGbPrN0i5E+eNUuJ3+NHIbRFxrkDPv65D3S+Rj8Ch7YkR0BQuz+yMRux9Ug/ZtHd6IcNHSdFU9ykwOZm61wUOBjZmd3sqfNopKGDnz7JHnrxEJH07rh2+lfHQpMeWl6xloR7uyts77FEIhQ/nJ1+dYcZRUH3+R84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714532837; c=relaxed/simple;
	bh=xjgTjI14KiIyX/HsToLAkpyLPsbqox928UxELbDPaZc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qU/gR2fCepZWVjb6Eu+HpxCHp6gUHKLkCGyfJ8wBxzRMjFLXQAGykXR+RQE8CFGQkdkNsZX3aeS95/pUTJcPUbpw8thPZkge7ruZLf65QgyRvB7T+B4rNtaJiCHj9V2S1ouXyQOZkRowpS/Og6rndoWSpF4DoMxXb2b/ZM34XiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bulNMw7L; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714532836; x=1746068836;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=xjgTjI14KiIyX/HsToLAkpyLPsbqox928UxELbDPaZc=;
  b=bulNMw7LzGC25ee1e+KpHHeBp9bwEaI3M4GNa0BSsN5Qd3bIe6YWNpb1
   wPL/PB/4zPe3g67iIeEZNr38DqN3WSoHChAQ+3xQMTiFtXOvJ7suE9zyo
   zfegTB3E2Q1N1hDVx0nvIZnDGBEb9qetJuPgsbNP7SuWfkQSuEyyLRdcF
   Cms70y9l/YzwWhvgodVf2cdrCJjagtb3xR2Xuqt/iK7mSF85v6Hb1TMZg
   PumssjRv3xem2vgWQ6TEpuTYo0uIKiiItR4omlAKSSJD8LXTPWdFtiTcG
   kdOvpLFQQgudHLzb9WPxv+Mom+DiT/LpchtrTm1rJKXwbkBGayJuemhrS
   g==;
X-CSE-ConnectionGUID: fV3Omhu9ScqG+bpBCfWJ8w==
X-CSE-MsgGUID: npFC7UqLT2WCOU71V1BzuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10095929"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="10095929"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 20:07:16 -0700
X-CSE-ConnectionGUID: 20khM6zWT8WIrzapKSWHiw==
X-CSE-MsgGUID: SdmPL9xEQKqdNOpHqP0I0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="31458823"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 20:07:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 20:07:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 20:07:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 20:07:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 20:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0uRB61ElcHYvMyIvAA1GyMReW1pSNuD0lB/csH4OP/9HDN+czudA6NHUTRBPemuhoIVT6T/kOW672S2EpLbL4QXlKL4YrYr/C6b2HwQGja3vN0u7ensJtrpG3rfLrBvBAZE45twhjUFIoocMNprpAMZZrFQvAS9P3h5/3IsoSIrXSonbKaB2aVogDTHXZ5jBwsK76PqGB/lBkO+xLUKXl/8jwGP2XkgUwB/jk4u7MQhjW4P8L+bz7nL36iM5ncFvv1bH6NlinRx8dkJQNjqudCqGm7qrXQp4AlOEBgj3NlQtKYnjePpYdbOQovte8t5zhsRwK0DLgSpC6zH5dIctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3oJLXlQ1W04vr+VsJ/MFmEKrk9JxyjyJAetWaFz5+g=;
 b=EMCYy2p7SxJYwqmUT21MD8lU2ksZeSxdcziYwD4zpQGNHClzRzML4SXjbeh64JQcpSYGC5rF4CJkDtgT7JhRi0wR9GK5YFE/zXDrz2m0wf6kxT7vb0l8xtS6/QW4KXFyplmO0xuniMDNt2nPhPvOarIJHu6EEgaQCD0mku7fyoNRiwdMRCsfqjLx9UBVnd909jNExxq6DGrtqwzILIDTGlJ/JxDAp/oFwCPr+0zXcdC3Z26w652b7kZ+YywJildVVLn9nlK5eBiNwzmVukoqTosWajtPpqzXjbDl+DG3zT/ZgCccLV+wLXEtdqNUbkebBZ3aPHFqRSKfmO0Ij9ZCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by CH3PR11MB7250.namprd11.prod.outlook.com (2603:10b6:610:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 03:07:03 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::35d6:c016:dbf5:478e]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::35d6:c016:dbf5:478e%7]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 03:07:03 +0000
Date: Wed, 1 May 2024 11:06:51 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Randy
 Dunlap" <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>,
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3 3/6] perf test pmu: Refactor format test and exposed
 test APIs
Message-ID: <ZjGxy5/kZuLIC3ya@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429200225.1271876-4-irogers@google.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
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
X-MS-Office365-Filtering-Correlation-Id: 0bb4590d-48c1-48b6-5636-08dc698bc659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IZV4aJW/n5fgymkct029VE/1ptkQP5Kuh3DzgH2pdjqzsnv+ASmB7cXRG5Ut?=
 =?us-ascii?Q?aqMvsS+Qhbw+s1WI1IHDmxfL21rOJ1RHwkMQ31QHjuqn+YQIY7TDrRGxCLLN?=
 =?us-ascii?Q?MjpJm7Lf1dMiZvZ1bUB3OqrgLnUgXKY8Jh6KmoLiGDK6tB7nQ9QehMG8cvwB?=
 =?us-ascii?Q?idfgI+1Mvv8x9jDQ5ozRkyc4rwYGFRsWHxSEqGyRcvopk9/JYelzzgia+W9Y?=
 =?us-ascii?Q?3AmMksV8HDKkdK7q9WBkhehNU+sUraO2civhmZmFa9iweYd/eMmP4i66Xy9w?=
 =?us-ascii?Q?/fOaeYW+QzJfcUIMTJ2MA3LHHnL89Z3AIXhNNekiZg7ubsZDOryRvGfifYFj?=
 =?us-ascii?Q?LqmoTd+9zqPv37tVZ/PJhQwSj7PLu6uKIL0o2kGDNVZnxw7I8Xn3ttKSRvEK?=
 =?us-ascii?Q?+/QTJsjW4i/1chluqcAe6rhY/40wSBhId7U9qke2M+n23X2AZNf7KlVagN5y?=
 =?us-ascii?Q?5YyWhXJkoxYLdpexl4aSYIzl9CZGs4UQ1178aRQcnQD6V9OWBqhhMQWHC6eF?=
 =?us-ascii?Q?90K+wKJuVBMad5FElHobhwSNX7Mde+SrdY72gHF+7cYK6zYkfbqpavAxMYA/?=
 =?us-ascii?Q?x05Uju3ehSF+6bz4A0ovxIU1Zi+pJZd1tSRaup4fC6ZcuI25rv+dT4e6+xrL?=
 =?us-ascii?Q?Vc1u3WFuiulf3UcOdKInpyaYFZJOBWtT+w9xdVlJltDycoDR28lIcSfZX0Px?=
 =?us-ascii?Q?zyMTVSL5DNSX26KwuGl5lrFi7xW44bzVamTOhYxYLXhFWEmosUDCcH/JZTSs?=
 =?us-ascii?Q?QgaOODnIJY4HudKuGwUplIzlp9HJs2ujEVXH+ozPHkbF/V4rIRHfTYtcX0DO?=
 =?us-ascii?Q?MZV4b04hL6mHAfaJWGYL2o+9rrecxZpkwvGLBDxkX9LAun3MSdikkoob3wsZ?=
 =?us-ascii?Q?w0/sNY49ooUaKr7J/rKiIjpfjPGkmy/IKkX7UeLwPLXr4M3P0DJLElsxJ5m8?=
 =?us-ascii?Q?R6vORoyUPQLquY6AL9aqH0WHfIfNp8r44f2QlgVIeOnHz5RSS0+5/KSSYNc8?=
 =?us-ascii?Q?dfWxmdz9hqQcfo5XPxVtilIFQzv4EHwQ0xURVKL2WhW26eytM9FjHKeJ9kCn?=
 =?us-ascii?Q?QqYYAqZz5vQfNTtd06wGyXJ+H6hYhlTrvq6wVfbag99JTdxCWCsKNoOyYjRd?=
 =?us-ascii?Q?W7wVGc+KIDZs49yBHV8g/sES/eYwiyIzzjscvaWySJ8J8WJ3E+XR6Xkn9fSR?=
 =?us-ascii?Q?/qInlsMlxIRVJCiZvF94iZIFvbcgHApPg7Vrcp6LRUQqxaPXppFXGurn4DVY?=
 =?us-ascii?Q?6S5kLmaWd9H/MJWK+069bZs2YhU467xNmD9A0fLIfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DVvKGBor7xMmeaecsS3801+BXf46G8HnFHtC4YB8I7tXBevXynEwveFVsNF?=
 =?us-ascii?Q?IX6e663MsSPlTgFA0CPzwbh6gwR4nQ90/zXNiu2/sQTJ8UC8r6vgwVN6DoW7?=
 =?us-ascii?Q?EfymIDPz+WZbETFKGTqZs1S1Ie0fyGMk7lXMNQkPUNGcSuSr+bft67BFTuSD?=
 =?us-ascii?Q?zQQKUANcs4Y+euP4D6r4b7/jmmADCSEjWCO8K0CtmOUuBATrzE3/bTBBO7KA?=
 =?us-ascii?Q?94DDsrvqhlBUwjhd8kARU9/iNMbGZfknBXihS6ZwtUEkjWydf2nb8AcX3L8s?=
 =?us-ascii?Q?gY31qipzSy8RiBldqQTlDODvfvwF79ZwkG0DqpVyFPGj26svtdjiXwHmDueM?=
 =?us-ascii?Q?rWfPYv+DXH91YTHOJ9u4kjzSIfhT3xMrKvlCpVB/Ab5x1vo1p7WUH8lD31GS?=
 =?us-ascii?Q?suSHEkb4HcMW7y4C24Tm3OZesw6/28h9Zg7qn4ElafrAUJg0Y9xIqz6uhCZR?=
 =?us-ascii?Q?bUChdwJ5FWeIJY+yhYqhaid44/dCozngmPC0AApPx8kKzHqqS0s5XHfBE22U?=
 =?us-ascii?Q?t5FooDvq5rs4hb5cukZuXE48FGYOuRv6yeGmJferdEEUU9aMxdMDOPtsVkrA?=
 =?us-ascii?Q?AeovxaHCdzDmpUzg7UBnN40u44Y+lbb78EjatQo867cwEqd8hfm6h1DgoE1A?=
 =?us-ascii?Q?tipzgOZtwo7oOmNwnv3DQd8DREbvEurPf+qmUCecH0puCEJpAr73qwbDtrkl?=
 =?us-ascii?Q?PMQ065hk8sH7vv9aCSilQ7iLDkN8HiSlan+tNjVpZuAEEoZzdLxbsXnxfjqP?=
 =?us-ascii?Q?ikBMgDGbHO/F8VOun8QBOQyecl6jfZNIki+3yl69hAE2OBgDnoSmuiyGVi/2?=
 =?us-ascii?Q?JE7iih0x09x2YdHaQDwWdEHAwOUOL/YmxrLzhhEvXfEKVuDT5nEGlD5OkQet?=
 =?us-ascii?Q?pfYZ42gAbQTwzwEJQpFDJcph4dWDMvvCXio9yhZ5OMh6+EivDZm7Gd5DYg0K?=
 =?us-ascii?Q?PF5U44YNtBYdDvhNjyhlY6Zk33xHL+c2GCXOkPAErdL9i6+hM+qnrm0IkLqf?=
 =?us-ascii?Q?krzoQaACHiD5Zo9/O421z6bA9XEevWHEq8IvC8lk+CxgL+Iu/IG6qIv881ec?=
 =?us-ascii?Q?9L8NIU9RinH8K3PF+iMHuJMVoAh3GnlSQUWNiNvHDuZNGldO7XY3u8W3po5t?=
 =?us-ascii?Q?T/g/29EMNNWjlW52s2NSocXr8e1KfHfwBnYbjg5b8w/rhf8pHW8EnRfaV6DM?=
 =?us-ascii?Q?LnJ95lONWz4EXq9VUUIodtXbJ158/ARA6C/Kvb94mjfLZ5zCHwIfFFWDTZvk?=
 =?us-ascii?Q?U1W1eZEcYs42S5gPQU48HQJWjBdNT4Gr1qLiBrL90WM/zGlX20Kp6ZOrf7Cj?=
 =?us-ascii?Q?+xTfx26UjictMlaOX4nnT3iChb+yX/IuncUS+jqcpTigUFU14gNSyMnbyELd?=
 =?us-ascii?Q?ZkkLl/FUi+KtcF5oNQPTWwtJ0ynmtqdlYN/3s64iPXd3fS0zYDx9u4njDSC5?=
 =?us-ascii?Q?shplzGBr/yjGYp62T8LasvQBjbDW9UoTuxNORgEbK4aYZE5I1mrJvXwj++bI?=
 =?us-ascii?Q?ys5b3yJPNqI76fgS5RXi6v+Uyd7ODYtqlz6CmxD84fRc4sSuHNelUMWLFtsh?=
 =?us-ascii?Q?7UEHsabAfPR0M2gOJfxmppMTmM2A/tpTguoh1ODMfzYreP+LPoHZpipCFkiz?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb4590d-48c1-48b6-5636-08dc698bc659
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 03:07:03.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXu2ZoolaSgAHkDqeOmKD9BEX+y67R/2KcvG5RCafENSasdX0XJhEEGd1GREodxMvKHpqaLqk4TDXflfvQ0X5Q==
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
patch link:    https://lore.kernel.org/r/20240429200225.1271876-4-irogers%40google.com
patch subject: [PATCH v3 3/6] perf test pmu: Refactor format test and exposed test APIs
:::::: branch date: 20 hours ago
:::::: commit date: 20 hours ago
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404302348.8fXJfenz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202404302348.8fXJfenz-lkp@intel.com/

All errors (new ones prefixed by >>):

     PERF_VERSION = 6.9.rc5.g00252012d0a2
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


