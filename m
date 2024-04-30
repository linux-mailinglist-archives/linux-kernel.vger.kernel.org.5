Return-Path: <linux-kernel+bounces-164675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E34F8B80F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40938281E94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D83199EA0;
	Tue, 30 Apr 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcMA9LEd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC4194C8D;
	Tue, 30 Apr 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507155; cv=fail; b=fLnkEv3pwZeKGuysFBlap/vQrjkmROM8qmExEGTDlRUcuEWyazTpsJysBb/BIfYpkZ+2DUa1bIdhNJg4tyjqx0OC2V0QYPjHDRImuENzuRKL2Ihlz3HIf02guVno5GzqY/Q6BvBMpY6rnKGmv3BeBn0fFl7trvkSkIpr3Wa1fiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507155; c=relaxed/simple;
	bh=DKZXId/spFkVC7GHHNkwdcehf3Jm4et0efHkhcE34gA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M0uOOrbE1dKO2OWqBOhukDXAGwHCId6R9fuFUX7tHLcT3B1hptDjdrovkm2TFed4T0NFeTEH200DmpcGU0dyrs+t/z//sMoPjYIeyHJ8g0J0/iFD+YpuUItp04QkIDOSbCgKjGTqHDMj5iWYW4rYf9ctgIgCxlPF1QPBydwXQlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcMA9LEd; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714507154; x=1746043154;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DKZXId/spFkVC7GHHNkwdcehf3Jm4et0efHkhcE34gA=;
  b=PcMA9LEdoHvMQo2jWsTO8j4aaZZLLBFsW1lZ6XCSBFI5j/3VfhOfmG56
   8z3uCEPp2i6rjb9UEXaxrrTIyOaxOynORTJzsf6bmB4rMotDOikVzwLiK
   OF4imOfRJ69cgSL/PMhSTrbuD86JSI4oAHTixijTw+Hp2MdCULDLhDIb3
   1w4R6RGHpi1XWajiPAxHkmUhn/WRMmPbhRx9E7Rjfde6FERBxGuzn8hfr
   w/7zguDNWWgUiEqww7BLzIXWuxLR8Zg39XALo3Ul9C9y5/y9vUBfsVONc
   md7vdxPHQsW5iePjMQs/Nc1CSrVtxznKMep00+7mh35vuSYHqc0liR75/
   Q==;
X-CSE-ConnectionGUID: oAmQCIVmQmSHxligD5300Q==
X-CSE-MsgGUID: 1W1w7TuYSKyh+HBySSL/Rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10359953"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10359953"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 12:59:13 -0700
X-CSE-ConnectionGUID: c4r10zNzRFiTTzfLWVskOQ==
X-CSE-MsgGUID: VWjHbj+KQyeGPLEF3Tdp4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26443312"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 12:59:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 12:59:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 12:59:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 12:59:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lL2a1orNYJLjX6Px4TUiklfIGb+3SE74gVYC/Tr9bTErkwppTJhwXNxQrBpbB1vRxkfPSCMsZECuGht6vohTXQb4h50sWOivdMuusHA8BbX/yVZLTW8pruCko5S7TDdo4d/lrFRVCctprKJ8Kjvr7/nsF/bQHj6yXpgR3ejqjssgffZeoE5k2YJPJPHHgzm1LGFrHxT7xovmSt7NIWM8UFGre2nUEmNeX0dR+H7/50d1KeWDoPKUd8qC4P1vfZiAIMbvPo5DCuEolNlxKWcxLYTvKVx3bs5noeusPt7PsJAcx/DhGGFReSw3LLuvtmFVsNaLUBmdrFMWtN+12YwLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhpjokHyXYIlD6v+4unQMSS8ZZS4ODj83YlSVzArbuc=;
 b=jaondRV21LYWUkrFgU9H3DRLUnXJE4wx3CWDUA+glaQ7UN23zaHWQamSugqSZrw24u5UDOfjPIA0YiH8ZLiALW64qsvJn+yY4LvHjkVX0w2VZO2NqoqqqqJIy3TVe1LICeU5vqQjmU7uJzeSG33yHv9wsxIae1vSjannsvEDItWnWUE+cAbhaqn0Y2rofSZ9bvpwMNd1lebPKmeHBL5wrCcAQHsS3CBWnRHwWZLrWpZJ/dcInSYAPpbwe7UeVKm6HZfD/PJTt0UKTySES2HrN12xmWGISxyZqeMpV8lTgs6ddj0m60Rd24FEeaZzwwjK0FFo7mDwxzaNPgv58zYE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 19:59:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 19:59:01 +0000
Date: Tue, 30 Apr 2024 12:58:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Li Zhijian
	<lizhijian@fujitsu.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix cxlr_pmem leaks
Message-ID: <66314d8343103_10c2129413@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240428030748.318985-1-lizhijian@fujitsu.com>
 <20240430174540.000039ce@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430174540.000039ce@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:303:86::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 77226b73-dd55-48f5-da6e-08dc694ffb2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?61E/7esVx0U3B0kMidNrrUF7MEpTdCESMsSMqNwecCJYV26gRic+T4fUyHne?=
 =?us-ascii?Q?NefhNgI8DG3XA6HPsdEikoqYuqin6XO/QHWRcEGgwJCcjfgrrctmVzIS7lI7?=
 =?us-ascii?Q?bRTaHDtJvySkBZDzUdh/6bFETJFNc62t24icdYbs7aUyfpvxOB+yB15rnoQr?=
 =?us-ascii?Q?Up5fTxn4WLOeCD1IOOKWub212IC5bf1rHwgr4rDsrEx92QnXV9jBbh7jVfuR?=
 =?us-ascii?Q?ir8opqX49xxRdEIzsx2GK9q5/TwqtOhubscCQZFb3TZx5eXmFqkZdY9ySgcR?=
 =?us-ascii?Q?P62Tj4G/mttOqkbv6qaJOSoHLwgSQvzRXE/jO83+JszH26BSILm0jrSEeXeV?=
 =?us-ascii?Q?46zWhPGWOkqxrvKnkgNNRR0z2lS3TO8z/pHm6WpYdcWl5Rhnr3Zzks0nxQ0u?=
 =?us-ascii?Q?sIOrkUVNcTSe0tMSPHQYHNYPhTxWZOrxFPcdS2nqjo739Zp4cCPEpSkXfXiN?=
 =?us-ascii?Q?vWofNmyMVmoMWCNdLxC14L6AVQELw08xkT55J/hBz9fRf+GaAT3XLqFvHQdY?=
 =?us-ascii?Q?l8Kvh53QDFFwFqRTuy1sUiY6iwCN3WCnnKOfURa4w+TRa9i0r2x1j6M8ywd3?=
 =?us-ascii?Q?TTd+IqOCwxPviw0ztHxt1wh9x/nUaM9/BjFi797BLuyTlEkr2TvsHzXTMxpf?=
 =?us-ascii?Q?n12LQfTY8w7S15oRZUyd1hthkxP7hrh8Gff/eLYxxjSTZPzImNPxi9Z9XPCe?=
 =?us-ascii?Q?yLOINeQufE9i9lpasgGVRlHwNZxlhHLhPbuASFAr4PaTT26kDsJfNX/cq7Ds?=
 =?us-ascii?Q?V0ZxQcdWizx8d/Nn2MDkNEZHgVEg9LzQqGt1JvIln5YI78HnEmxejBugo0Yl?=
 =?us-ascii?Q?0oJ6m2xcabbBcn/Ydu4l4ku609v6qaVYqauQet4OSKMOYdyqgI/tmVTTra+x?=
 =?us-ascii?Q?+ufORNu+DRp7rc4SSaKL4+QVYHya9siT947WeIacpTxgLpt7BpWc0+CRqYw1?=
 =?us-ascii?Q?UQWZSvxxEH7YLZ8ihjsXNM07+F4V+wolkUUKvOAdxDNP8c8yku5Z4zpjA2Tf?=
 =?us-ascii?Q?wteyLUXXd5oqijCuW6xEZoBt5cEBQrNYUzqsVCWYldfPAWUhcKxoUogn0cCQ?=
 =?us-ascii?Q?RgLXiGZFlJEfTKkTRED57izOMo1WPLx6wTMKReyjHfsqLdQaNcknL16GDMXP?=
 =?us-ascii?Q?v8QR8oNvA9bhChXfOzpX26vGo/ElxiLyB7H87E4d4Qc2qiVW+nHlJ41MF48i?=
 =?us-ascii?Q?zN4O9AogsxnspiA+KJRCjUg+5LLj1ZuQlj/o0eAtWCleMO7LHe+9fOX6c/nf?=
 =?us-ascii?Q?QdXSe9xEnyVZhO4FD+mS5fbY1gH1QsGiosL3r47+pA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2GlMW5jrKnWyKurtyTDHq5/M79Wc+kaToIjhOQ6YC84yMtNzm3PuljBGPUx?=
 =?us-ascii?Q?FyVLvTqvurtCrn1bEmo/Qpoc1kc8V484RgZTHvghmQD9ZaqYYMgZkvDzEs84?=
 =?us-ascii?Q?es5kgZMNiExrdQyjS8HefgK3JQ9E3gQj1W77gw1kE+Addh6f8JxoHcJzD3g4?=
 =?us-ascii?Q?Nc3c9RLxRURVO/1EP5JwHSDhYWefp6sss7O0RYlsUOOxeJliQaU1pja6G2bE?=
 =?us-ascii?Q?1D3Tvi6w7TO2yurUjNPLSdONE6zp+JFZ63vQClqEM7nQlJzrHwDiH2bz+muE?=
 =?us-ascii?Q?ovZfxZ88ZO0fOuh1PvGcxtVEDm3VvM7gdafxE8ljLO8Azp1+5MeFHjpVUX6/?=
 =?us-ascii?Q?h8/SdfgIzIDkKzO/4fj2g9uM7RtG7L7jCE0Zajo3BLnUXfCfpv6rZUWR64Bs?=
 =?us-ascii?Q?6vtMtekHe+Df7swTOQJq0ZmMSSWVdsDuhaDO4HOMPqGREuw8vdBBcX+gvcDz?=
 =?us-ascii?Q?UyJmXMXeUuqBng8wLB73KFbLK5w9xj10Uy2MwASsXMqUqRr5RCzB+Bb2xdth?=
 =?us-ascii?Q?Za4/Am1/6cMOJsUeE9C13QGEEjI7n7bWPvLPlGqkMiB5Cf9n+CIF81qZF+XD?=
 =?us-ascii?Q?SabqqqPzAg/a+zzDvnC0ph9ORWk/iFC+fYBYXsIohRcWfNiGcGFRucf9kJsF?=
 =?us-ascii?Q?uAeqcnn/mS7bFdSVoHdIqIIKEqSL2xEWirt8wwZ/HLDZBVyUj4XZbFm1aOXe?=
 =?us-ascii?Q?Z6h5eni/aJORslBeNGipTiE4zGVkT8VJQSzLuhrMg1cN76XDm88vLmNJhXWT?=
 =?us-ascii?Q?Z3Vzesy4Rmqrmetjphjz8P3P+Fl2bkuhU+lEKAOw2m88uh2s0pcTJAigMvmq?=
 =?us-ascii?Q?/XOya+B5Bf1O8BZ5L3hCgDr8tsWFjR2xo1EymtpM+Z44BbSbm/M05EuikvU5?=
 =?us-ascii?Q?ENzGDJjw6hiuM8qsVBXT+K9nUkXg94bx9PN5ZgMfUZ5iSz6NT6YN9+SrzT4z?=
 =?us-ascii?Q?4a2uNbH+nRAXVrR41nqHNxlxqs3aBGZbhRVWnOyALEtlWyavdxQFF9ei88oW?=
 =?us-ascii?Q?8RFcjhL/9Xmk7sEx3cMjc3yZb6GlJEoYIqa+yr6BMp8s2R7LP0rynGRMCE+d?=
 =?us-ascii?Q?OVITqngWMCfZGHi8QIptrCYhnHerEbzKndfuZHSmpuIEs16oH7bLzXl8rDjk?=
 =?us-ascii?Q?YMa3tYCoHreCad5TN+fxw0J0RQPmtLvbrNUrG4Fbx9DSggoZ+ttvwXVQ+abh?=
 =?us-ascii?Q?6uPzU7YM6SlD5NoE2sL4MJeiFxWGetENI9BLPy5X0WOzNYuqmtEDugFJV6ZF?=
 =?us-ascii?Q?jytU0IHco0WS7HkIs4Q18fWe7jTO4WCaSdw4a8onK4dpldzvIyKx/h7kl4Wv?=
 =?us-ascii?Q?ykkXjObj8+RhfYkGzdcJFkdnNWqVQatxOsFJqTy4P0x4k8YFkWzIGWz6hFda?=
 =?us-ascii?Q?PQdjogYeg9QwYkFssA8pdsmKUdaE3L3gKufnoG0+T9hyBIJrnTboItIVmSi5?=
 =?us-ascii?Q?c2cI1pemlGAzBrv8t1oHSMefkHJopH8Lp7APUv+ezXv6nqiDMa2e8AvPQZDW?=
 =?us-ascii?Q?s5fKa4LKL7E+bNl4JzVi1fPI2R09DqQQ4D7CoS3+VI+VOTO0f2em6Eeq0O0b?=
 =?us-ascii?Q?C9NlZ/5rCUbQmKI6yNcbvyo77XdhGUKN9tQ1Zcl6rBIkUut9+HocgYoJht1s?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77226b73-dd55-48f5-da6e-08dc694ffb2b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 19:59:01.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUQBz+rMOSN+ARcJwMdzTBpbAN7/akkR/2JKgE7vcF71Bfjh0oMDUH0aL5g0WZERfSWh3BHDfgyMtJqWUAadysEkWT1bYgXjObOccftIIqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sun, 28 Apr 2024 11:07:48 +0800
> Li Zhijian <lizhijian@fujitsu.com> wrote:
> 
> > Before this error path, cxlr_pmem pointed to a kzalloc() memory, free
> > it to avoid this memory leaking.
> > 
> > Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> Fix is good, but this looks like nice case for conversion to cleanup.h stuff
> perhaps better to just do that?  Would need a small amount of dancing
> on the final return to return cxlr->cxlr_pmem + pointer steal
> when setting cxlr->cxlr_pmem a few lines up.
> 
> Also guard for the rwsem.
> 
> Dave, Dan, worth doing or take this minimal fix and spin around later?
> 
> If you think this is the way to go.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I had spun up the conversion patch as a replacement in response to this.
However, after looking at that I think merging this fix with a follow-on
cleanup is they way to go because the cleanup touches locking, memory
allocation, and changes the calling convention.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I'll send the follow-on cleanup shortly.

