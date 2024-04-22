Return-Path: <linux-kernel+bounces-153007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE88AC771
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D998B214F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054AB502B4;
	Mon, 22 Apr 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4KBi8rF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B01524A5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775675; cv=fail; b=oPPfjL6iwkSD7R3sTeytm6crjH6yFFeAWq0x1wpBD5kCN/Fua0gvuEotHaCC2lmatFLEPPQWmeGrCEegMXy0onQm9JcU+FqVdLfu0oHQf9HUT+dlXpoqA5wFRHXPnjrWHHiKa4f7YQAa6+iaDd7EigFcrSEtgj/RnGLxkJTS2Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775675; c=relaxed/simple;
	bh=FbYqODz2MhevX/VCh2Jrop6FqvpU8CBFYoRmg0GV3CA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OVGqas5k0HoSr2HsyD9fEv29YKX2Je1aSJloYTid66pK6T7AwY27M1cj6slQK4VKgpm/BPm31smBV5kVjWomQkjwi5O+40qJLz4TGquiJkbJs8PJ17R9+iUFYMP7AdEQq8RtxS+9uMfmGJDW42knws4Q2IqQCEzabsrlgM5wRnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4KBi8rF; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713775673; x=1745311673;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FbYqODz2MhevX/VCh2Jrop6FqvpU8CBFYoRmg0GV3CA=;
  b=h4KBi8rFkYC2MN3dP+7318omRDCBXgXctrimsJqAmctEsQmdWrT3jO6y
   4ef1OUPerxTfXHPfIC0ONw/PZaGFxgYl66dDecwRPWdvOuZs3DUwg5yHc
   /l7Qmq8CvdaVy3wWO4uEaLSde9/vcGNuTQKO5jtIKmlsWhcmw51TwbN/n
   OvEd5wJJaVKZ7HGko4G5A3FM4LZNv9Fvsseyw5AocSmY/sWwK4+5FMe0v
   q5BslvdK7g5f8jwosuagVqqJf47vdUnem0Cl8tVGzhJ7p2xKlWhlFEvLT
   NOeCR4SrpacPBt9epH8WAZzJDhiHDJrPomkx9b7SwzkyBWE5awrzU+xYs
   A==;
X-CSE-ConnectionGUID: uzr4l6sbTLeoqTW8RhT0dA==
X-CSE-MsgGUID: Fej07VVXTluMMBu+noGdzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="26821972"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="26821972"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 01:47:52 -0700
X-CSE-ConnectionGUID: Eff/2bGLRia5TfQm+EiGxg==
X-CSE-MsgGUID: XaBVuygjT5CyTujuaJrZBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28719818"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 01:47:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 01:47:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 01:47:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 01:47:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 01:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/TDuZYPPkQ2SaTKOqCabFkYGKiZzf9OmQGWfLeWB3m5bKVRXuyC4leZ/av/+cOqtmZqtCkxkmfsjh1zYSEauOoNTZ82WRkTpAAdfqw1HJKk2qQPTtbBmn3MbKeCYxe63Fruw5V950iIBjDSt7Pu4MdiAxB1/Tzl8DZZdgvKiKCNmmBgWZ2u134iGsARydJ69ffClFuwREP2DXbboSHQO39MODX12Vj0AHoFBcqmhAROAxx9e5ppuuNM+Jd1jd8rQ0CPZOaW60OLv9vXgNrQ21blWYo7kXY5jGRTzY1F+DzXS0XkKhxSPlESihqwqeCTTLgtWB8G5TNFGHDPcfYn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy2xhY162Zj30DcIAvOk3PlFxpKdIqI9Mv2eSNdg1X4=;
 b=e9BxTaffWRJujuCst6TMb+ixZsNa/hJvN7Er5IaF2uKD8n8HACCOVqOy9Ik12ujCK6DCnplW+6iGMC4zkZ1E/1uHIdyYiyQnpiNYYCaa13A/5mgqRGOCwYDVzOFdPNxJBq9T6g0vUOYZsm5hSeBvE5qU2Fv2qlFHlnBb+NAFxmhLzdvX3Pwg8t2SsmIBVBQZA8D6h/awuofO8eS84b0JswKHIhQqE2sUFQXP6rgfv5nQKZiMJJhq9lXTsXncdOVaa0HDDyCujUMn1yYMikrmCJubNocV1S5rz8az4o/kNXBSCyMewcqIbmvC29ZtP+hNRWCQMeZN0iM4YDa1nxZH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 08:47:48 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 08:47:48 +0000
Date: Mon, 22 Apr 2024 16:47:31 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Xuewen Yan <xuewen.yan@unisoc.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <ke.wang@unisoc.com>,
	<xuewen.yan94@gmail.com>, <di.shen@unisoc.com>,
	<linux-kernel@vger.kernel.org>, Sergei Trofimovich <slyich@gmail.com>, "Breno
 Leitao" <leitao@debian.org>, Igor Raits <igor@gooddata.com>, Tim Chen
	<tim.c.chen@intel.com>, Yujie Liu <yujie.liu@intel.com>
Subject: Re: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds
 when reweight_eevdf
Message-ID: <ZiYkI4qn2nvdmktq@chenyu5-mobl2>
References: <20240422082238.5784-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422082238.5784-1-xuewen.yan@unisoc.com>
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 552a9bc3-ef2f-4e81-ef20-08dc62a8e30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iW4SxKrFVS9fkVVqBj9GGOF5b8VvbmRq7kt8t6nXX2R3n19mBM0ibYyIC7yc?=
 =?us-ascii?Q?ucfQpRD32gtyZ/d76vVXKfbthKPOZZQ/9j340nAZxhx0imAPWMgB3HOpAv4w?=
 =?us-ascii?Q?EzWfceDWolPW2mR3vdNdHmhkhywZ0uNKT0Lwt2/Zar5KzJNP13F95+gkjSXK?=
 =?us-ascii?Q?X0AJlepzbSx08OwfBjsefiw9ERobJEm6Vo09sKlFnRXdpjIJ07zwGIg+KNcu?=
 =?us-ascii?Q?tTrGY1t/5gQw2gUzns3b/STDwsMtrBRgtnjhCW78jsMaK9zJY1joSQMDKFPi?=
 =?us-ascii?Q?OJM+/prvIg+CgkokBlt1zThm4fTMvUXMxdj1nldv/twnA4qyYBL60PRXPOk/?=
 =?us-ascii?Q?HrIFtG61QHutY+MWwY3SVP1u8EBCRLVaQUBM9GHcw3tkaBF9OuhtvjWTa/1a?=
 =?us-ascii?Q?9wjczmatSKouxqsud9C8wlwlAqwGj4mBzhtkI3Zn/iqSBbowhoWD5ZbdBk/V?=
 =?us-ascii?Q?/n+Mchfzc2ur3v5F8DeokEvSZWp5T9ioRMxupzbjHouxQiOMN7uTax6H/gdv?=
 =?us-ascii?Q?lpI5mJA5nUtOh3pZWQ2VAvlLFoMOD5MfdiA7v9hoCLCJiioehFWDjMDZrTTU?=
 =?us-ascii?Q?1iVUYx8Rc/mWr3Y+JKBFtiv9A7IBIVs/AVCOSB6LVaSK9WVUKarhMZd2fjUW?=
 =?us-ascii?Q?Z7hlYKhNSKOYRCpqmWi1N4dOVQuTdkJnUIZha7If2IjDvN0w7yk0vdsMU6e3?=
 =?us-ascii?Q?Tme9mpG8LcsWTvG42l95OenzboX9Ji1MJEvL6WaFr+4Aq4SC27HzsfjgXvx1?=
 =?us-ascii?Q?ACJtB2MSm1hm3szfV26eaPEMxscguMrInfoUcl2mYdmEOOFJ3iiw0EMAbWdq?=
 =?us-ascii?Q?snk/ooN1yiOn+3GP7eKxy7cMB9HLjP75mUWGSBl/hiI8/khHESzZZbmuNExh?=
 =?us-ascii?Q?c4QGhFtPTUMkq8Rkjx0jBuBvH0PA+ANTl/d5qcb4f5QxJ9T03jQNTgQiqGjc?=
 =?us-ascii?Q?GLjpzEbYBbPf/Q9R+UxAHlVxNuBlh7mkdp4eTEK3OObWqwHaYMeQ5rnLIwFB?=
 =?us-ascii?Q?jfOlZcmVm2jXrGAzndYiUWJMdJxTsuC+FeC9AWQx7HFgc/OViqm4+5tc/aGB?=
 =?us-ascii?Q?IguVtN80F+s5EffMvDG6t2zRu7eK2zc2sBx4TxNfMpcWh/sGkaMhUgibHHqb?=
 =?us-ascii?Q?kA0rH7+W1pp2x0wcHmErMqOMEPYpYB904AKuA4K9N8L1FxbzEP1X6QOT+O/A?=
 =?us-ascii?Q?no5Ej5CsQWYM0g9ADvfhnj2Jdo2db6IkqFsFEYae0kuKhm3fpBVPUxXsD2E?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LplJ7X9dHDX/SZ2Iw+oIS7FhVkJxy8vVa2NPYSEwvI+pMn4vld4VDORCWTGH?=
 =?us-ascii?Q?pNhoDyO+1hccpVMNoBjkST/k5hTQ18ImtQH2xs4rEwWM1pXPh4+mQJMsVpx8?=
 =?us-ascii?Q?8gQxcNoT16waKVsXCAH0P9s14AVnbFsnjB39ly0RyFs1+Gs3iVX+pGq7oiCg?=
 =?us-ascii?Q?Mbvl3ZbVbpp5D9A100EMZ6cOsgmGwc1tD7jijhMcv8wOpVJbcRamN8OUmAlz?=
 =?us-ascii?Q?qqtOOLZ4Im1Ttp69Fx+/1dsep2aHJbAFz4Z0F75HiUcyR3KeLfSu86Mfll7y?=
 =?us-ascii?Q?PC2irY8084n7KbUWkLOm0O9tjObX+oKgyqNoOtuSl4pCHkS4l/KEa8pbAaee?=
 =?us-ascii?Q?q8wjHlrrJP460jGpfU4R8mM60ABvqavrGqYn/2qfdidYqHG1QwT32N0kZOdi?=
 =?us-ascii?Q?C4jWKtQlFrQd7TTk0+q8/isYsJIUT/UT8gR5wo14qZIw7/DavqyaHveCrPKX?=
 =?us-ascii?Q?cMa7Eib2y1kqZbSC3uw+E5aAxkFZPy8+IWTHDDhYZvFSg9eeLiBsfanXBFhV?=
 =?us-ascii?Q?65x2rg0CwBmtDIMaY/KhEeQyAcxM6nchyq4QOs+UB06AY3Ztww0q9Ssxh0sO?=
 =?us-ascii?Q?fluvOIs9SlWYuz/+vzudYRUcE5ivcpPryqZTz/RZEtuCn2OJj0TTq04HUZaK?=
 =?us-ascii?Q?V92IcobRRomVzMpeQdYlE0MWCnZmrGMETVmaukVd0baHstXshCbSxbaa8Oj8?=
 =?us-ascii?Q?/Bu7HxOKPJyfJH+eruofknqQ5ogkDDyHYjiaNctEhMizW1aSqhbX5kyzIDnw?=
 =?us-ascii?Q?Rs1pc/FACLszsQq4Vh9dN35rYc7YCAuoyPgjK/7pL5ifcFwE9hoPaKGldf6z?=
 =?us-ascii?Q?aZ+nhUg+5YKxOxGaIwSPb78OQ1sWNrxScziDsekDtYlUkGulGBLw1P6LH+64?=
 =?us-ascii?Q?rw8QWHleKb8CBlViz5r5NFulfscujMRXSEFblLvPo9BQCCQyw5zShaSzeotp?=
 =?us-ascii?Q?tm7kglgCrdLz/xkE9RxdIHwiOmcEnoPTSSLqtt9g0JthYBMXEszB3zUW12qw?=
 =?us-ascii?Q?OUMqfO0wXqKlKq+Q28kwPrf2PhazF/TPLXYldKTSz56KgPSJvcgtgF6l2Mvh?=
 =?us-ascii?Q?xh6AharbFgOWV4C8Qeqdak922xI+JVlScjs0uz5082OnjVYiul0dUjjlbF1G?=
 =?us-ascii?Q?5eW9pDcFHhvqOcyCDlA6w92Om1/YxJs7QBZ59feI10PZu7F93uEVD3cIyIXH?=
 =?us-ascii?Q?EAKiBl2ecjSO9R3vIHCzPkfkEmz0SsZNUBnkTwM0x1wo4hf85TtglglyQQ37?=
 =?us-ascii?Q?CNx+eryxrMr8xVXKp3DkUVLXhlVU2eCORYnHmoK2dniBn9iF0Z3WEHCIVbOj?=
 =?us-ascii?Q?GhBeW98S6kGab6RGHYXW4g1mALBOj+h8OKo79MeXioeigEYfeziUyc/XkClc?=
 =?us-ascii?Q?XMvjOQxjIP5JEweSdHiQa+eOeXLNhBpGQCwgUkbSNg0kfuLcj9MlJ9v1trZA?=
 =?us-ascii?Q?ywE7HP/xYJv+xpMDHhPNuYjOfJhPfY0SI091n4fKKfGbWJd+izDDSHJ15OzH?=
 =?us-ascii?Q?MUZQoOxuZ3dEW/TNoK00qUzaPF2eGNd3mTTKewEi9eTA6Vx4xl0EYRzRBsx7?=
 =?us-ascii?Q?uv9D8V6EjqwD3eU/laBoLOyqSAaT+lM7qhyJdOsv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 552a9bc3-ef2f-4e81-ef20-08dc62a8e30d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 08:47:48.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Yvw17egSgQyrE+4vanNwOjUJ/rbA5L2rzmeXjey23pwfN0dt10tFGs/O/8mLnQMIwpI02jM0BvxVR58EzIs9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com

On 2024-04-22 at 16:22:38 +0800, Xuewen Yan wrote:
> kernel encounters the following error when running workload:
> 
> BUG: kernel NULL pointer dereference, address: 0000002c
> EIP: set_next_entity (fair.c:?)
> 
> which was caused by NULL pointer returned by pick_eevdf().
> 
> Further investigation has shown that, the entity_eligible() has an
> false-negative issue when the entity's vruntime is far behind the
> cfs_rq.min_vruntime that, the (vruntime - cfs_rq->min_vruntime) * load
> caused a s64 overflow, thus every entity on the rb-tree is not
> eligible, which results in a NULL candidate.
> 
> The reason why entity's vruntime is far behind the cfs_rq.min_vruntime
> is because during a on_rq task group's update_cfs_group()->reweight_eevdf(),
> there is no limit on the new entity's vlag. If the new weight is much
> smaller than the old one,
> 
> vlag = div_s64(vlag * old_weight, weight)
> 
> generates a huge vlag, and results in very small(negative) vruntime.
> 
> Thus limit the range of vlag accordingly.
>

Thanks for the fix.

Might also add comments from Tim suggested here:
https://lore.kernel.org/lkml/ec479251e6245148b89b226f734192f6d5343bbc.camel@linux.intel.com/

A fix tag might be needed.
Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
 
> Reported-by: Sergei Trofimovich <slyich@gmail.com>
> Closes: https://lore.kernel.org/all/ZhuYyrh3mweP_Kd8@nz.home/
> Reported-by: Igor Raits <igor@gooddata.com>
> Closes: https://lore.kernel.org/all/CA+9S74ih+45M_2TPUY_mPPVDhNvyYfy1J1ftSix+KjiTVxg8nw@mail.gmail.com/
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@intel.com/
> Reported-by: Yujie Liu <yujie.liu@intel.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---

Cced Sergei, Igor, Breno who have encountered this NULL pointer issue before.

From my testing, with this applied I did not see the NULL pointer exception
after running trinity for 100 cycles, so

Reviewed-and-tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu

> changes of v2:
> -add reported-by (suggested by <yu.c.chen@intel.com>)
> -remork the changelog (<yu.c.chen@intel.com>)
> -remove the judgement of fork (Peter)
> -remove the !on_rq case. (Peter)
> ---
> Previous discussion link:
> https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/
> https://lore.kernel.org/all/20240130080643.1828-1-xuewen.yan@unisoc.com/
> ---
> ---
>  kernel/sched/fair.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03be0d1330a6..64826f406d6d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -696,15 +696,21 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
>   *
>   * XXX could add max_slice to the augmented data to track this.
>   */
> -static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +static s64 entity_lag(u64 avruntime, struct sched_entity *se)
>  {
> -	s64 lag, limit;
> +	s64 vlag, limit;
> +
> +	vlag = avruntime - se->vruntime;
> +	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> +
> +	return clamp(vlag, -limit, limit);
> +}
>  
> +static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +{
>  	SCHED_WARN_ON(!se->on_rq);
> -	lag = avg_vruntime(cfs_rq) - se->vruntime;
>  
> -	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> -	se->vlag = clamp(lag, -limit, limit);
> +	se->vlag = entity_lag(avg_vruntime(cfs_rq), se);
>  }
>  
>  /*
> @@ -3761,7 +3767,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  	 *	   = V  - vl'
>  	 */
>  	if (avruntime != se->vruntime) {
> -		vlag = (s64)(avruntime - se->vruntime);
> +		vlag = entity_lag(avruntime, se);
>  		vlag = div_s64(vlag * old_weight, weight);
>  		se->vruntime = avruntime - vlag;
>  	}
> -- 
> 2.25.1
> 

