Return-Path: <linux-kernel+bounces-159438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC88B2EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1261F212D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9511879;
	Fri, 26 Apr 2024 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+3hLsKk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AB17F7;
	Fri, 26 Apr 2024 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098098; cv=fail; b=iUzUL34Ft8YhW8hE8A0AXMcX6XFCWATZQtF/sno3dywbLw+lCjumRhkLYE7W9kvevtKg6u9oObcuOeY8bCuEHwTnnICy/fzmFgODb3aN04e2/3QxHpDmPu5Rnx8UJjTq6SwkDTgN15WX+FCISWWvAIJBhw5GfH/wCA2Qvv4b/Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098098; c=relaxed/simple;
	bh=zByGzEdLmO+gEXXcuXqOUdCPP1Y59Y3LufBC20InrOU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kaCpazxyB7wz9Xq87V5M4LK0obQ3enaCA8GlhXMyJxfVNZJ9oMqJcZVLdF0O5vgyc4+rG0Of2T6ql0oGghMSvsbBLiUKDuZDNWX2XooIgwGiTbTp+UwBgk9UnWxl2vywdlWmynq59j3pBNNwDJDbHS7Rz4mL/w8c7BqlKGu1lrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+3hLsKk; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714098096; x=1745634096;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zByGzEdLmO+gEXXcuXqOUdCPP1Y59Y3LufBC20InrOU=;
  b=X+3hLsKkkSQpwdmtt6lwewvevgSSatIwVdH7r7/q3nQ4OiN50vLfFLs/
   QQvJMTmCk6JoTgkiZ5f32Hz0o90jyk1fqfkXSX08EKhAhrZk5oc+7jUPf
   kD5MFyqeF0NidZ1DbnOl9FJUymyzWiw5S9fIOMhKelC8XJAghushKfpQL
   ozfvs6gjYf79ATRI8ciYec9fLvDPgCUwVITEkdk8/oW4iVpGTo+oFWGBu
   +DjGA3mvSCwqw8JNFPliRHiejAgbcY3su/DRtDrRT8byOo2sd6mJ7UKHN
   WEwPK6Z/uIzv6dLCtN3JEqzgD4zySJCwWNKGiK9YzsIS/9fIgvuLzyDY4
   g==;
X-CSE-ConnectionGUID: elPL7TxDQ0SQG9ovIHDMPg==
X-CSE-MsgGUID: PQ9JG1e+QK2O2i2uNJs2oA==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="27277355"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="27277355"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 19:21:35 -0700
X-CSE-ConnectionGUID: W+UjLRPxSa6uLvANij511Q==
X-CSE-MsgGUID: 3b7hWn9OTV+MfhQTqFfNoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="30088888"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 19:21:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 19:21:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 19:21:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 19:21:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHtkVyjdf5VRj9RalPDtKvqLU+zaGxHKtnUQun/Q+K1gyHoOlsqpcDCNLpluh/t0UMu6bGBtXmfMVSSuzNa1I5otRQT9fJDEZAX/iS4SBbVn2YhXLKM7vrki9TDbBmGZMs7IOrFgMsYiBmHHpoEQ+xFpQ+6yeuVHBHmgYaw1YKy8t+3I7BZH0FrRyk42MarRCLWz9Fdx1uoZch50Ldh4XqV9WK+TThrfmuESPapH7Jf3i9Y+cYF2Okl8nXFa7bf1He7OYz7/kBQB5iekBbKt99ClsFGjl1elZuM/+OgnHATgRtgIL3x+HmFh84ve5qK8F4XviA2HVYDjyL05LCTqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxExqNCYZ5RLkqC/Gqdtcnu5HCPPYXXDppzFFnapuqA=;
 b=k7vvPYFuaFg1NBSxBB0pwh/DR3b1vXQRELXjqPPybs38Bw+FAkFg9jU9ROumcmhjRH4QmNWXRAgYfGmrApOMxIyVEQpT+9td/6q/uuI50o1Hzd9qrbX4ZCPFa8rMAcbTt0quBwLEDYg8V2CgwQriYiOLNNDuoGOMCKAvWwmLs+nEEKolw68fTxMdDpOPFMCq2u9/uplwGvvi0TcFPdLEF9LJOJGirK4VrW2UuaZj8lHNO49XQ+sTjEt6iQCjgei3roUUZ3QfRTSYIJwY+vbcC/POQDnpUXG3NaF2PKsUUxiWUTDbMG7pWizEh+a7CZjH/50zECAhyXrEtQ3yJBLmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8708.namprd11.prod.outlook.com (2603:10b6:610:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 02:21:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 02:21:21 +0000
Date: Fri, 26 Apr 2024 10:21:03 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, "Adrian
 Hunter" <adrian.hunter@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, "Anne
 Macedo" <retpolanne@posteo.net>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ben Gainey <ben.gainey@arm.com>, Changbin Du <changbin.du@huawei.com>,
	Chengen Du <chengen.du@canonical.com>, Colin Ian King
	<colin.i.king@gmail.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	"Ingo Molnar" <mingo@redhat.com>, James Clark <james.clark@arm.com>, Jiri
 Olsa <jolsa@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>, Kan Liang
	<kan.liang@linux.intel.com>, Leo Yan <leo.yan@linux.dev>, Li Dong
	<lidong@vivo.com>, Mark Rutland <mark.rutland@arm.com>, Markus Elfring
	<Markus.Elfring@web.de>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Paran Lee <p4ranlee@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Song Liu
	<song@kernel.org>, Sun Haiyong <sunhaiyong@loongson.cn>, Thomas Richter
	<tmricht@linux.ibm.com>, Yang Jihong <yangjihong1@huawei.com>, Yanteng Si
	<siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, zhaimingbing
	<zhaimingbing@cmss.chinamobile.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [perf dsos]  f649ed80f3:
 perf-sanity-tests.Check_branch_stack_sampling.fail
Message-ID: <202404261025.187f2487-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 884aceb5-e4fa-4e0f-8822-08dc65979029
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?putwow/EGiz3AL4u+rirBeqdn/n9FPvRQgRt3Yea2BiJW9VD5GF84JBu2AH2?=
 =?us-ascii?Q?IM6RDAe7uYxyRiwGnZPUbWaNpZN8rmFGvzfUIw6m6OGL3EEluYTc6AoxiQjc?=
 =?us-ascii?Q?IsxSShTzyM3wXRZleyObjq1nSllxQg5vU8HUNbzXULY7pQT1Gc1E1hq3Giye?=
 =?us-ascii?Q?O/QN+qNVh2erXDmXiAftV4lh22W5fotiuiswnR5ww9M2npCehFGiqpFwZIvx?=
 =?us-ascii?Q?gPO31NO5oXlDxBCbLnw28ti6kGbr4K+6SjXlBDqP0QFo8iZ+OI7saGidlkIT?=
 =?us-ascii?Q?S9tsUIHJVEwlVHxLu4k3XwbN/19sCalQad8a86CVMSl1HdafvXR2hG4YzR3e?=
 =?us-ascii?Q?/4k88cY8Ms6sblbrpP6Jc/LtwSpLwgvGuGWxvpRvp2gjP38W6ygTlGYMHm5u?=
 =?us-ascii?Q?w/+Sf+wA7cc+4Hy9YSgDyF3RSlBSOX0iMXSIYKxF+G4A2Xn6IXnt4bT2YSmX?=
 =?us-ascii?Q?1jKbWyv03FagFkfRn4D1TsczF5m6MzkbA6+5IehGvjR1Su1qUcMi5TQpV4si?=
 =?us-ascii?Q?WQ4lAgk94ELJVCQXHXfQlcwGC55NVST6qtOTfqRdVyJ1MvFnKAbICQZMvlVe?=
 =?us-ascii?Q?m+j2lc9eaFfokyWadWEwjYifC0BtyWG3C7BQZpdFCQouAKlduETiLs1h9ZB2?=
 =?us-ascii?Q?aQEbxgZz79M7Fut1r6G9Usl9v58+nli7gsvb543/zqlYCeqBUyHKa94ZwhQk?=
 =?us-ascii?Q?Rg8/MyeC2kbYp+TaNmDaBHPOZuQkUHqLZ18bPTrt4TqX/CB0hJd+RxcmWqez?=
 =?us-ascii?Q?V5HzVosJ25tVOX5Dr2jnc+nvgTrbXgCQwNW+Qp4rpzQuyIKTxNF08JO7/zfW?=
 =?us-ascii?Q?MOOJPpAIy7iKBeYQUchLCbKgSEIFT3NA94DK3Ne6JPOHwhNX7zGeHMBOFB6M?=
 =?us-ascii?Q?M1uRapSr12TEZLUTrQp1AxXK6uw3j8gYzjTR0z9nym7ROsNL55mqx5l7zMFU?=
 =?us-ascii?Q?2KRI7qIOa4Z1gJW6vE9bpVunFym5H14RAnw5pNeDQ9fFig4E9lasTjX5c/qC?=
 =?us-ascii?Q?cZUaOQIvPArBJ86P4Ky3xs+B5ZMYrhD5jiY/yfmviJcEhbIEKwCERMr8fBOq?=
 =?us-ascii?Q?ec/mlGhfAMasUOEAJGhUJrvvbpI3Y43F8rvVx7JJMp5tsqGekcph5l+vh0U7?=
 =?us-ascii?Q?xWD19xjUFcCG3YuEuLNmdlZXO/EpEyFQ87gMHw1JgW1pfzq7CjPcGVng8IV7?=
 =?us-ascii?Q?O0UXnLOJDdFIrE0nnaSYiGAJXzTi9sLPQIX0fMhDAWsQlpL0K2Qv+CJYxMk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67c840RiZVVtf4lap7CMiA+KhPJB+yva4qZh2gcse4FDM6q+Ci2Py2kf5QLq?=
 =?us-ascii?Q?QBed0tiVfLYKmkes30zjwo9ffm9TbcqUc3JiPa2IcARDy6QvuqnITfiPKJMW?=
 =?us-ascii?Q?6jLHwYS/P5sfek7MmnxPFYzJa+cHgjChi0sLi/pWvOZkNKO3IOIzuYWwVAon?=
 =?us-ascii?Q?BYF/Cogf9NZ1oGyKB/wxnKgmzPwx1nIabN7WmKHyyFDXpPgaO7PkxAWL7IWd?=
 =?us-ascii?Q?7p9eRs3GfACaVrDx71QcBwEZz222sfUq1hY2imHuX9zuduTCMzCnUl8DL4Ti?=
 =?us-ascii?Q?A/OkJ8a7U81gdm0sBjRoyPtAkCLAasUazFbTUAPvvS0Ip7pdDaL+D6iPr999?=
 =?us-ascii?Q?6rJ8C06cV3DGU8iFF0GMe4GKL6GNqqVEWAQQUK1CsW5BL9qQ6oLTVHYJhCgh?=
 =?us-ascii?Q?1sD42WaYMPCOyFXcudvPbi8GtfHJg3I0332GjMMWDyjnrSDSrcitMzPfyZ0L?=
 =?us-ascii?Q?uWuivFXHxzdVVUOXPamN424MSp0/KkqswNCi8udHEMZgZob5kY/C7cWGDY1Y?=
 =?us-ascii?Q?L6b874+/+AE6XuETzBqokG07XgTZ9MvvtIHnitjk1xuAQiW5KVjZzDbNamHM?=
 =?us-ascii?Q?2caffUmEc15O6mia5XAmvsrhpBhfXKSbNd542oL1tIq/omrwrBSAMU2liR1r?=
 =?us-ascii?Q?U29HyiyjyublcH+N61OCzQ/vGNvAHvKLGG001qDzzxigH+0Du/c/vgV/hOeB?=
 =?us-ascii?Q?kDFZUrL7gQ3u/h1m074cd5xrZecrUMwvzUpVaX/pxyY+sJNf+tasJn4howsR?=
 =?us-ascii?Q?1bxQcSnaRbDSbm38sz0syAp+jUbI0TMdUsMmn0JYE2THTNYAfACRNMFS2evz?=
 =?us-ascii?Q?Ot5ZdrHFTXaLLeOQDPN+gvN3ZTcv5Z14swcDmahg/I1oMJnAZMMr7M0OBpMY?=
 =?us-ascii?Q?E/BK5uuYazU/nOyy9/bLExFKqWxyN4C1fFZ1WevwN/CJRF+10HTArJvRP4Od?=
 =?us-ascii?Q?E1RIfUOxfUjufh9BZTfQGqJvDgxHDmNsTVJH10cog6qGRAEoimOXeKMqigni?=
 =?us-ascii?Q?z/Af3bESfa/sSAMANrb9N93rfe85dpIMIacDUdTr7O98bwentBUAMLnoC7yA?=
 =?us-ascii?Q?jJmjlXNpr5gep/RpPuE8/P81qfngoF+WRu3tnEKf233pxqZcFe7Z2wveK3gj?=
 =?us-ascii?Q?eLvgWHQ1euq5uHdOb9TeSEzuIDZjHRgB9hRkej2Fs3wSQ1HtSMoaq108mrXr?=
 =?us-ascii?Q?bUUWj81LjzqiA1b1C52GGz/VxRK63hfKlgYkojH2YiHIYXw3+dM50WDmZTQf?=
 =?us-ascii?Q?cXe77IIEPGnuFBE4/hXdSqQLWhrYjCw+n8ohyO8dfzws35ePUG5NBXL3/ef5?=
 =?us-ascii?Q?MARXUD0Boi/IOCQAy73j/zgcBMIZu+ml0G2Cqo+t/LJtZVEv5SDpURitT8lz?=
 =?us-ascii?Q?CGzaGvbE7kj36wdEmI052ChHPYeQk6bRvzCUOpQrhs8NytFdrioHxzXGpPah?=
 =?us-ascii?Q?QjvMEFz+ndZdi4iupTF68+6HYFyd+5MkS7I8RJxlKH2aeh1gAvoQc55Uyz2u?=
 =?us-ascii?Q?gGt60WHcjwsKpCJMDXtvqzXv2O9pT3keEogPwUQTqz7SMZ1bUSMSoz95Brta?=
 =?us-ascii?Q?oJ76CCKXyyQri+JRSIHFdooipCMup2rMQfnKS0R95jPwUkFC8+RGGEhgL8GT?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 884aceb5-e4fa-4e0f-8822-08dc65979029
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 02:21:21.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQgWZBtK0ZueqQZN9C/kfr9U0vGLt+u7kIkR6YExGXzAPxDKsnWMHIxHIUIO2OSmDHI5MLemjR87uBgIzEkHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8708
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.Check_branch_stack_sampling.fail" on:

commit: f649ed80f3cabbf16b228894bb7ecd718da86e47 ("perf dsos: Tidy reference counting and locking")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master a35e92ef04c07bd473404b9b73d489aea19a60a8]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc



compiler: gcc-13
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we also noticed other failures which do not happen on parent:

83acca9f90c700ba f649ed80f3cabbf16b228894bb7
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     perf-sanity-tests.Check_branch_stack_sampling.fail
           :6          100%           6:6     perf-sanity-tests.Lookup_mmap_thread.fail
           :6          100%           6:6     perf-sanity-tests.Object_code_reading.fail
           :6          100%           6:6     perf-sanity-tests.Sort_output_of_hist_entries.fail
           :6          100%           6:6     perf-sanity-tests.Symbols.fail
           :6          100%           6:6     perf-sanity-tests.Use_vfs_getname_probe_to_get_syscall_args_filenames.fail
           :6          100%           6:6     perf-sanity-tests.build_id_cache_operations.fail
           :6          100%           6:6     perf-sanity-tests.perf_pipe_recording_and_injection_test.fail
           :6          100%           6:6     perf-sanity-tests.perf_record_sideband_tests.fail
           :6          100%           6:6     perf-sanity-tests.perf_script_tests.fail


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404261025.187f2487-oliver.sang@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240426/202404261025.187f2487-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


