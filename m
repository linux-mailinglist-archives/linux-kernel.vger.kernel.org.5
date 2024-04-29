Return-Path: <linux-kernel+bounces-162670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42828B5EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA47282AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF1584A4E;
	Mon, 29 Apr 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qjh+D5a2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8224983CD9;
	Mon, 29 Apr 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407467; cv=fail; b=Et0zYZ9hR41Y+Dw2XXl8kBJOtxg2QybG9F/rKXD1KGeCWOJDErpZVvchvYJftTsNwMLq+/2HwnbGEwmqHuBZvmJQrU+it2OwR6TDiOA2lieop+17B73z18y07yVmpdwU3FMEqqigZzGpfA6cM5Vy0dpK6KWa/IBsVZ3xUsY5xfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407467; c=relaxed/simple;
	bh=xQe0Xlm5pvpXHxIjn7b/Q+q+UrE305yj2ED2ma5QSVE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TCy8X6FLlKS63sqIldUuMq+7WyzMS7JgxlaRrgW/zyjMy/hWedVNgf3FxwgbFXEt+k3xePkYbEWqHohIt5pgFiMOEIvoWEzqqDazcZAOoP4Ex92vxypo6fjpFUdsonKTlsXVDpVt9rIs9tRBmTZXnmT6rmoAWL+poVSuRi8KLvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qjh+D5a2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714407466; x=1745943466;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xQe0Xlm5pvpXHxIjn7b/Q+q+UrE305yj2ED2ma5QSVE=;
  b=Qjh+D5a2Ocs1Ya7oROfYfehuKbK5nyBidrh3Y/ZTqSzsw8xVYu4GjsJk
   C2HwgPJAQ1CXeNOgKXCNs1VDqjYrNaYCAHPPKfzb72+EjRq4RyKDls1cX
   8vKdg+EAaZuEjiPgAXdM7Jm6W7W7r7kXEKaEjO0iH9Io/fdaX6cVYgFeM
   ZLIlEd33ujex1KwxpgkYiVqVxyo3rWY00gq7m5i9IHXCq34SIM00eYTbG
   9us4SuwbLsiLoA9viSdSmc9hIQScPKY/ILJnLjJVKX4zOi4dqlso9NcKv
   a2yxKR/IqacsSMGYV4/7xgJBujvuJz19p3Kpg2mC9xLivR7U6gV8GbLi2
   A==;
X-CSE-ConnectionGUID: mrLshI+1S/upqOleobZkUA==
X-CSE-MsgGUID: 0OfOk6ujTyWr5QP35zvHPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10245698"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10245698"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 09:17:45 -0700
X-CSE-ConnectionGUID: VtzPZ7SNT/yHGOWFKa5KHg==
X-CSE-MsgGUID: 3oakHtgbQpSP6XOFr1K9qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26179157"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 09:17:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 09:17:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 09:17:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 09:17:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSw8ZCJrqBBtf2L+skU95juV/+zBwPZYvcMXegTbG8I9Urfbi7mzU4Tm/kJcupzkaQGF/DjQURHkj+SQTETd4rMoy++Xlu26kz9y5wvTssI9xDeDkm/oVi1hhYgtF+a0lR9spPj3Q/8Nim1+faMerDQ4h1r1Xj8qOCYG0ADuWP3NSS3ltDADObQxmzchgpGd9DGmx52LQIaEVk/6kF0lgojTeg9taOdt/kxXq4QdLdkX7vZu50FcTYBCLOaTj2USq+yRcPTKwxXT3zz8XYXQCSmZFxaTndA2h/BT0c+QCcs84Rp/QU0Ml6/qMsbA0VNDWfd1+PsBuTsT/QrI5oRGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTO4shhOaDjkjsz8ncZKKISlQ2EP5CEdq0j/K9RBd+E=;
 b=XO/qksWJPp4McAVs/QEiQYQTjdfIHxi6QH2MCcBAVRnvwgqBcJCtrmDuh0g/Tzy3gpBEFg5Sg7iuRjznXMG2my47OGn+f2e+r9dbNUUFxFbf09Sejgya8ywnjjRmO+qIs57OLkcWgyD88O7CGMlA03JRGaV85pCBvF1lmkFjMs3N+VwmMKsd62L0r1dD0hm9D/b6ca06tXPPNnOZeqmNzoIDfoHFDxHueV/pU1lv3KQiGjYdZaxeUBfOYTotnJWkFk1td6fXA3KSE9eyxda2tMdpj/g4y5hrW72ojsNtr2SKFKbh3S/fU/vmgRnbcttUI3UTGL6uf/9V3HoupOKd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 16:17:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:17:41 +0000
Date: Mon, 29 Apr 2024 09:17:38 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Li Zhijian
	<lizhijian@fujitsu.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/region: Fix potential invalid pointer dereference
Message-ID: <662fc8227e6ea_19ca3929472@iweiny-mobl.notmuch>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <18a295a2-b734-45dd-9c95-660a9e1f58e4@moroto.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <18a295a2-b734-45dd-9c95-660a9e1f58e4@moroto.mountain>
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b2e3f9-ec5a-4db1-6ec3-08dc6867e50f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DH3BKiVefRXh+XLj2uN+C82ifTwUV/aTcXZv1nYIAZ3+N10/IJ0jqtadiDPp?=
 =?us-ascii?Q?0nsFMxfDMLKSM23fMwkVdbtyZbxQvQgUvJvOF4XBw6d4PImGz+7V/UJgk+st?=
 =?us-ascii?Q?1hv+TGXvzCsoH9WurO5vqn7GNo3aJ2fm7xOAg2+T78wmV0GiZODy+D8zRDfL?=
 =?us-ascii?Q?Smreyu7pGK1NNncyCOz1rcSeDG5bnaInSf3YC1aO/4Lc9oPVdS4F0CylFXwf?=
 =?us-ascii?Q?s4+opqyXjzb7hfOg+czJslnTcroGr7iWg65V/6piWpgmcLMt9wr+jWkrleBE?=
 =?us-ascii?Q?A4TiXykesJHHx5BcK6iCEde0zyuJA4ps2vS5NxEVxp1kSGsQ5xj1FYo2+rEg?=
 =?us-ascii?Q?IbhBVRnBi9BRlGJGbCw1FSiRq4wq5y2OCzUyY1gk3N5L7XDjoM01cDowCQRN?=
 =?us-ascii?Q?l3Etrk+WBP/Nv8093vo3q0LGa+R1mIryYkjGFKjSDls6O/QI1tgbosy4npNY?=
 =?us-ascii?Q?qfVfbu3uaYGGvomqgJIzY+WEjt0YTFiXuPKZJzIG+dBS+R2CHjPhoKx3GKBl?=
 =?us-ascii?Q?xH5rt4jZW7d+wDQxfp9iACkZmTb2xTYtmpNsP3JhtyIOOGrwOT5/AUe3WL7y?=
 =?us-ascii?Q?w5EHqzCfCTF4Yb7YIEtJco/NgKler39uBuOx7dqEtPp8voeSX9mjXjJe5tUE?=
 =?us-ascii?Q?Yv8M2dnqAfqTWYGcEm8+Rwnt23vD3/QqyJcmMS6SKElH+Yt9LR0RE6OkVIB9?=
 =?us-ascii?Q?2z71RHX6t5N1mZYJPonPjP1Y7LmRKGltXWGw+YBpMhXKwUTTh+q91IpPDzqz?=
 =?us-ascii?Q?UzDSKoPkp5x1tG0Ez5kNJjc2137QhkqVtaw8/zc5v6YgCORJu2z2xqYSKnFb?=
 =?us-ascii?Q?9U1DlenqWrrpvqbd7hV4TPxR2vaC8v/3WOrK7NcyQmqzW30pL7Zuu1UDF8Je?=
 =?us-ascii?Q?T4GY5ammHAqJBhYam86er6oEDZSHtUpu+d8l4/VhbApSxJswtWRSFrWkG30F?=
 =?us-ascii?Q?UON982itgran878EqrLdWyNJK1aj1IMm3fkMXYJPIanJiBFbbxqZTwwFkP2I?=
 =?us-ascii?Q?LyDf4AYF9jhUBMf4pNZTYvmjMazq8jy7aBTK1D1VQseFnluRfAdPv8FoCfGx?=
 =?us-ascii?Q?e0swnLSHqmL2ASDfCJ34pTzEDui+1co5C2ju7hpZB8ByuK248d8gvQk1tV38?=
 =?us-ascii?Q?1LD2RG/1KjDoTP9LPUWMi0M1+qmPg7Ke4I9DTWSJrVcrTy41RsfG4D70IDc1?=
 =?us-ascii?Q?6uW410I2HStweEENSQAXw8YA2w7XWz6JpZpc+GZOjLimH/50iEO74AWsiE3m?=
 =?us-ascii?Q?E3hSRqVkSFcVBaYuw7KYoIOPd36VhCgi6qujlVZXPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4z7zbc/U0RcGHPxUQtt5/kqj7ilkB8x5BP0oHOhYhfECgbub+asVMx9PA5YG?=
 =?us-ascii?Q?MbrqNkiMD8QloeS6/frotkebaAHkBa04yqRaywWhyUTbXl6cnBWoecyLi6aj?=
 =?us-ascii?Q?WAkM/S0qBm0qiLoqz9+hIOE9K/jbcbAzuWdtt6whY3u8j4PQxbNfN0RDsNgE?=
 =?us-ascii?Q?/5d5rVMokypB6prKAI4Dbdup0CMNI+CcbFu73AXHLcC3RP8vi3F5tNJCK3XO?=
 =?us-ascii?Q?4/gAFL2cUC2zdNrr14fkjfhlLvCGL9d4NccXy6hEx9ig54B9UK/Pl8kAD8b8?=
 =?us-ascii?Q?OJwvN9/o3YMAU/yY5PAwM0AJDy43s79haE8A35ya9DWYSeotAwVAgbcpBYT9?=
 =?us-ascii?Q?oPc2Vl4+jdyIRYnY/Djf+4WKqMe0n5bcQMkBHtUq3a6MIsOBzl51KURIDcpq?=
 =?us-ascii?Q?C2TQ3px8Ut1sEjJZ0qqK3m/HKD5Hehl0nGBAu7rNgyLvBdQ6+BymdDg0uWf6?=
 =?us-ascii?Q?32Wl8u52UgFA48IuwyyCIjiEieMjy8RyCJRKHbaeMVCFCxX3C+SXPMoIctRn?=
 =?us-ascii?Q?EOVWblcjwWdOe0YxAgTnlD+CXOO6zXrFyQ+cpy+Gwx1p5BJKK6+M+xuZVFWe?=
 =?us-ascii?Q?xh7ZC4cv3Lh5xRd6cEoAk+9u9L1hglhRnhz5aW4NIVeq5MJjIQcA75XrGASR?=
 =?us-ascii?Q?TA4SmUnjza1FEf9e5P4Rojtf8RSNkOjCOBDCoP8gEVG3o/N2Y7cXmbBx/acw?=
 =?us-ascii?Q?NoV6v0j7+8gFFCh4h8IfR8YiSo8WhOq/1KY4SEyOQPesLBYBB6ay/s5LiYq3?=
 =?us-ascii?Q?NtX+RJqDl9ipOkmLz/aw2iqfa/IKRPOnHe6CHvyoMM8+Wa9Y2ltkYyKf1EDG?=
 =?us-ascii?Q?uQSSCzJOa5frBblBD/WbMBuQu50jk+CRImHIQ87uhEH+eAtcR20pDCFdWNlo?=
 =?us-ascii?Q?gRHgkybwo514oCipk51nH18q7vXgos/TRAlWHQCnHBjIAOMNky7AlbcLFY++?=
 =?us-ascii?Q?Firp1HWArT2mdUncPZ+EmWOP8EsBZp+OXOyKqRMT9wY6SBjVh6IP1wYxA8LF?=
 =?us-ascii?Q?NQQkG71RYZ2jILiau28rr4/1y7zFGwtvGq2LLpI4HMFaY6VhqTeE4pyvRhu6?=
 =?us-ascii?Q?4sP69hPjV2/kuuvl+EfkNkQzHsUkghDgy4tIhC+qdsBx30h2dA0jt/raDVyt?=
 =?us-ascii?Q?2fD+nXu077PWZrs18E4pOx6wmB789keULgA3A1giO1J15Hwwo830jmAnm7rg?=
 =?us-ascii?Q?NT5G2AXN3VFiKXKRBw+KGmonnGPn48Qyi2UlO1gSPs1shsbpPiZRSGhqRn4W?=
 =?us-ascii?Q?P/xf0WPw9DwIX/EyiBg0s22sDNaguhUQ98jBxqWL5kuhNFN609EkjmE9ycQL?=
 =?us-ascii?Q?S+NhWIqiDZxkJMpJD3NGRtdVc4ugC2aqs7Irx7YKOslx5a0znNjYA92SvcZU?=
 =?us-ascii?Q?gg3ZoZyk2YSdDUEPAdzU8VrmfMwoLVogNJVP+zlvpNJ/RR9QO5qPWCwzQxQY?=
 =?us-ascii?Q?6FZUjmj5fRPeMxaiKs1TeXgy1ou1+RKnZFMt1Viqj98v+8j9dbmm/gGcAdVI?=
 =?us-ascii?Q?Htuip6eYAluUF0PJ9hAq7/O03MibB/M6xdGNG1HvpiLymgcf1jzxFwMRqPiw?=
 =?us-ascii?Q?+FDZfLjqSb0Pkx7AMj5TeV/TAOA7xzu8YFxKC33h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b2e3f9-ec5a-4db1-6ec3-08dc6867e50f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 16:17:41.5163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoWEjEKl/ezyZOnhpSDkBT3RG8bz+5mbO2148W3C8bIUQoPBoxWj7bnMm207+ZXM9wUT4I9JrikQq3nOPJT1Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-OriginatorOrg: intel.com

Dan Carpenter wrote:
> On Mon, Apr 29, 2024 at 09:31:53AM +0800, Li Zhijian wrote:
> > construct_region() could return a PTR_ERR() which cannot be derefernced.
> > Moving the dereference behind the error checking to make sure the
> > pointer is valid.
> > 
> 
> No, this patch is unnecessary.
> 
> drivers/cxl/core/region.c
>   3080          /*
>   3081           * Ensure that if multiple threads race to construct_region() for @hpa
>   3082           * one does the construction and the others add to that.
>   3083           */
>   3084          mutex_lock(&cxlrd->range_lock);
>   3085          region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
>   3086                                         match_region_by_range);
>   3087          if (!region_dev) {
>   3088                  cxlr = construct_region(cxlrd, cxled);
>   3089                  region_dev = &cxlr->dev;
>                                      ^^^^^^^^^^^
> This is not a dereference, it's just pointer math.  In in this case it's
> the same as saying:
> 
> 		region_dev = (void *)cxlr;

Ah...  OK I guess we can ignore the change.  Still odd to my eyes though.

Ira

> 
>   3090          } else
>   3091                  cxlr = to_cxl_region(region_dev);
>   3092          mutex_unlock(&cxlrd->range_lock);
>   3093  
>   3094          rc = PTR_ERR_OR_ZERO(cxlr);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This check means that if cxlr is an error pointer then we will clean up
> and return an error.
> 
> regards,
> dan carpenter
> 
>   3095          if (rc)
>   3096                  goto out;
>   3097  
>   3098          attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
>   3099  
>   3100          down_read(&cxl_region_rwsem);
>   3101          p = &cxlr->params;
>   3102          attach = p->state == CXL_CONFIG_COMMIT;
>   3103          up_read(&cxl_region_rwsem);
>   3104  
>   3105          if (attach) {
>   3106                  /*
>   3107                   * If device_attach() fails the range may still be active via
>   3108                   * the platform-firmware memory map, otherwise the driver for
>   3109                   * regions is local to this file, so driver matching can't fail.
>   3110                   */
>   3111                  if (device_attach(&cxlr->dev) < 0)
>   3112                          dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
>   3113                                  p->res);
>   3114          }
>   3115  
>   3116          put_device(region_dev);
>   3117  out:
>   3118          put_device(cxlrd_dev);
>   3119          return rc;
>   3120  }
> 
> 



