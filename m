Return-Path: <linux-kernel+bounces-158880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF338B262F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90762812F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450414D2A0;
	Thu, 25 Apr 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nS4ksS9a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0A12BF22;
	Thu, 25 Apr 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061944; cv=fail; b=YDtxG/kUKF7DwN5FP4I7rR0/rDRgl6U/79XTm7XbDr+U5xandclwABQ+0Oa7r5/nJriBm1aTIHfSPvYsBGcUKgQcnpXTR8NCqlKjFt8+zbjiss5xps+SmJ7fCraj6JjZ+z2YpJb+UCU6t9YP6yn2D52sTOZaJlaAO0/xNwsrHt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061944; c=relaxed/simple;
	bh=EW8HaJ3HSvp80syRR+KepiX+L9A3iVzXrsfk6knmHyE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AgV/gTMoB/J42IJjWX9CdY+mSObuMYFF6jSptAVwBQLFTfwgh6f8W65W4TODK8tcdT0dTRPmcoicUkqv8GPdtVKZDtmNUQSMC+7Dr1B8NuREDjuRt5AH+auJzbhNjbf7mhtcIXTTLBsRkB8mWUOPaHtObOYtbiwiym90Bfq9UYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nS4ksS9a; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714061943; x=1745597943;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EW8HaJ3HSvp80syRR+KepiX+L9A3iVzXrsfk6knmHyE=;
  b=nS4ksS9ao8peOO+OypA9qebVTNqcXxlRi9hzAXQzLj+4003+dZwfAStR
   OIyK366pU2S4SM4/9JA5T1El2y/jGb+h0k4b1iJLljy6+zDujBFUfibhN
   JvIuvnGsdHT8P3tWv41TaGwQdl7FZ4MQINGr6vLCxJfqGfC87zb6Jiz4f
   13MxwhF5Ko7gXrl6pGxn3S4gZagQgbxjMCS1TfF/i0Am+g5wsqAvxl77K
   nGkbSwlWWDyO9pEvEAwqrYFBJz0fSqDDkMGCWY6ce7WHdaDNPWynV15wg
   UWxE3Sso+HKXgI6kXWOs6Je4qnaRTDuIWh0QvK0FUmWyL2j+tQzinPCOs
   A==;
X-CSE-ConnectionGUID: W9DiRicSTsusolWFapZkQQ==
X-CSE-MsgGUID: J9O/G7I9SiyGju96j2ZAeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="12697489"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="12697489"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 09:19:00 -0700
X-CSE-ConnectionGUID: +0vJPFpfRJSybzExFB3jSQ==
X-CSE-MsgGUID: wIHX9jInQe6z2NascEfydA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29919504"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 09:19:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:19:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:18:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 09:18:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 09:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGzUfeom//wcn//HxIwk5He5gjbPyXt4wc4iOag9qCEz4vOOT4b13DKgRCExklU8w2qW6t1/5eOAI70g60/Ap8JyIXcquY8ZyAGO6r4CHIhFbZsd4BlkaREFogjtuhsUoW0yIiBlQOyWRWSbYlAUER7Pjgb9fxfgD7/xrOJ0RsoMo4ZS0v+bCCg/0v18vNuyzAnzCAdw2FSlF1nArtpb0+3/gdMm3dHkw93IyP0vWuCQF82Dw5ef0WWmUG3NNvTYX12+Op7hUTrCWwfaDqd96g/2sr4eIGUGdaa829sl42eMEnDkBNuntrIhtQlWGMbuhsxDJoKpAZF8SwYZmvFeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWspJJIfdnSbCDNENHT2+yyFXxenrDUlBaNCDDG8eTc=;
 b=ifzq/Ot0OThjNcgyqF/gNQ6tiy4NDCJe2kLOCuYHmRTFd+zyTWqfjHa/NzOtWVMflDwklaNRpEQn+0qTQTToWItnDrC9ICdRuu4tT+93Zjl/U810O6U4sPjLFpk8xHeZ2E8a2GqeER/bsjwrvncZVsP7blXKoSl43cU6QpulWIq2ZgBrc5aNM4+xLvYiR5cVUFpdqndl+O1tMg11EFdMI8siNvAH3KNy8RHJxZLofsp8vV2RpbgNgv25kIUZalXq5rsqYV6fN5xuiBCit37kGcczpcIqduPtSMXVzxJKVJB7kF5a1lJ+fvwbEtMb8C15EBVU9utzGeOGi5zHY9JcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7063.namprd11.prod.outlook.com (2603:10b6:806:2b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Thu, 25 Apr
 2024 16:18:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Thu, 25 Apr 2024
 16:18:57 +0000
Date: Thu, 25 Apr 2024 09:18:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Sreenivas Bagalkote
	<sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Harold Johnson <harold.johnson@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linuxarm@huawei.com>, <linux-api@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240321174423.00007e0d@Huawei.com>
 <66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
 <20240410124517.000075f2@Huawei.com>
 <66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
 <20240425123344.000001a9@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240425123344.000001a9@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: bf106bb6-b8b0-430b-7aff-08dc6543685b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J4Q1EJFjZnWvx1p2N+/5A/efQK7fHfobBuqNGmvNw3wu505JgGDFRak+Sn3C?=
 =?us-ascii?Q?SEdNgqwSGKxDrlUmkPu9+ce/J2HmAaV6Y7Q6x/z2uf0NDAL8D/HGWbvWlUXt?=
 =?us-ascii?Q?ZpJaKJqG6YYCKFTbxhWoQXQRrJNQk8wWgvchV9ygy1lMpfvVGal0OKLk3PL/?=
 =?us-ascii?Q?WEMjOhoSrFqrSGaECaMLN2vNMjHvmf/Z2v/4sxj8QX5A5FtfTPCZEjvpq4oq?=
 =?us-ascii?Q?1WJmCPqdaULjQBqtIfGVlWIPCJRt3Xlwf4FQf3Ka3fGS+a45JlIeU+HnMFwS?=
 =?us-ascii?Q?E2yRcnCMfy0PwXP19D9i6rhIsRublGW5eV9mhsseJGA1GYpT+BjaQ4R8Tly+?=
 =?us-ascii?Q?vA++AxiRHaQYXHZH9PF+q/uvdVeNyAdCBxxtGF5jRK78y8zqP8oG5IJiKjL0?=
 =?us-ascii?Q?ZQcP2rAWrb7JeXfnhtC7RJmashEm1q/kvbofiCv6tSHx8Ro7VmtAa60OD2cn?=
 =?us-ascii?Q?9lqd9mUbrLvHSmFfQFIgXdLbG3zMETccpb4OThuzjtBkokDZjuHd65qyfKo4?=
 =?us-ascii?Q?MtB+u/N/+T9KWGfVOunDv2TNH0jk7rYuMMfQIG51xtiWjBJ5/CqlJJOzzFwN?=
 =?us-ascii?Q?8XcGwtbNqSbWeqpyx0WHJ7FFut3/X7S5qkwyzLA1x79GMybWdvgwamikOpSz?=
 =?us-ascii?Q?DO36JjX6bTagk7JG9m76W5roPlVkI/6ASCUB1ucE0QjAe+jkfbZ/ys9bOd/x?=
 =?us-ascii?Q?fx8OokfLbM0sCCAD1fM6Gya7M/klauLziPRh5kXoNPeELBFF0QYosDqkwUld?=
 =?us-ascii?Q?X4xbOMPSuFAt+jOHHTleiK4AkPfGZwdBdfjO+J3RkxUsRsz+HqV8EeNWCxIg?=
 =?us-ascii?Q?BGlGRrYSVN0WgA5o0J8lMa+Vrco+gzrqvsWHPbXuJ9w5DYnGf3fL+dk2KwaW?=
 =?us-ascii?Q?zD7Qn/p1cnWiSs10+Q+U4YfQF4rH2ZehvLZ5XxUrUe2TN62FL7R97pOBBK0T?=
 =?us-ascii?Q?qi1t77X5AIbpBaEUh2mGoOYvp3nUH0fxy6Sikq54rpE+2+8eendTuAd4iIpg?=
 =?us-ascii?Q?470E1/MwXp+IffAuBzz7F/fVnsutxl4fbb5MtBc3ytYugQZPp6Qc8JRz2dqm?=
 =?us-ascii?Q?VWDnBXcsSGe+ApTkl9Mzz77uQM90qrALkI+0dcNU27jybct2zVSsp3wWQT4U?=
 =?us-ascii?Q?mmNpHEIciH33ZBmHS8cR27XZ23/75np4txyS0R9XPU5mIE7SYIeImoOpMpvi?=
 =?us-ascii?Q?5eBTQyQy4qPwLHSdaKTe7Ha7tRtOd1zJY+cXHCsjAnXS3BnxP7VvVF9zfRCT?=
 =?us-ascii?Q?0lmiB9ebS77FJn+YC2J6scpXEYwhijA5CP5BvlFUxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nx96QE+gB17Xw8eXcjk3fO3WJ4k3VU1LB1YntVBVgeKCHaKWKPdofUW1gax0?=
 =?us-ascii?Q?GK7dEyzDlI9yt8y3G8VSg3xjreH18zbgsU/IIYmDmwJLtKN6/IlWi1Mix5BI?=
 =?us-ascii?Q?vMSahMI2cy3J0JIPKdUFr32xKEfD/v5CSp0gUsHh6bAW+t/FaHgddhj3Cie6?=
 =?us-ascii?Q?vUlaoTnPwRRC4duSdGfhM4xe7t+Ft5yoTNI5Jxt/fWlESEPZ1FtS6n6epyWS?=
 =?us-ascii?Q?L8f56CCxPgKQDC7vgdyB+8qQbMr5X+hCVbxozDigOkBHfc5yEmGIp+emoEXn?=
 =?us-ascii?Q?HZ/SmxhT2KZbeIDWQTEfOw+0Mqp/UhqdhnFSaNki3ACMvZCDENpB8cEF34lM?=
 =?us-ascii?Q?6ufIssvqx4v5ezVqiRTeNCpvmx0oOAfHmC9olPV1paV9RYZ9apwNL99yoSA9?=
 =?us-ascii?Q?+u5lsFH9pQopk5zTwVGKv8Gw+y2fVK5PLkaRDNO2NUba0g5SCNxcFh4T5HlX?=
 =?us-ascii?Q?X4Vi85ZdaWZvb7L0zBwQ7MKm3+DWrFNcEFEK162fsYM2C/HnvhmZkLAQCB/J?=
 =?us-ascii?Q?7Ds4DOWMZRdujonoSbpD7q3a8B7zlZ6GorxI6ITxhRM3hZdCGisSA5Gpvkjp?=
 =?us-ascii?Q?LF4IafNv8lh3xBKW2oqudnZJVZYDW2JNHYspEFHY4M8J8MvDIKqtFjq+O52r?=
 =?us-ascii?Q?aYvycAI3SgV42PeRzWfDzne07VOL4t3MxFwI5+QAAuKXxGQ+iPhiAqt0IPAS?=
 =?us-ascii?Q?0vG14SDpijR9eepIEWQX4SXdc0dKs/l1hiouFkwk/BOIr6x9WOvQClxx4NLs?=
 =?us-ascii?Q?bQJT9DkMIuyLhrEQ0pRsf8dyAMnaJza3vSdfegG9ZhNxO5Z1V4VcQPheypc/?=
 =?us-ascii?Q?OiLdPBQymWqGLX77V7lwwolYj0Z8mwPXn2k1Pajs1KwmzJ+A5rqSiTcRRvUR?=
 =?us-ascii?Q?sXds9frpzUN6+SvVwcovMzj/SmYsdbyRP16doFUMuRPGjmpsodSKURtDEfgC?=
 =?us-ascii?Q?qno9fwQFhbEjqKFV4007vtHsmUXdCsyJi28rMpZqo8WcR0zL/L+aLfpbtKQ1?=
 =?us-ascii?Q?vwgdbtbEJuZ3yFL91S8ofNf7i+CCc0Ey7Tg5nFy9rWWHxsWHNFefJponduGe?=
 =?us-ascii?Q?nPFeYY7NJprKSHY0yMXH+7BnCeMXL1OaswNyuDql0U3r396ECgXz++ft+13M?=
 =?us-ascii?Q?DP25mb+Yze4cASz+bqOSNKJ6Uus/z2Bsmj/Mb/Sp3Ko7WhyiptllB1F9iEcB?=
 =?us-ascii?Q?2GE+6ATO+tqwiOyOsfbJayoWX7dXxrFtJD8VFuywP5Fn5V6OTVtoLHj/0+bY?=
 =?us-ascii?Q?FrnkUbxpjixruYn+MiLGAE6QLxuprr0m0sR9Bq1/sfB5F3NJrRax0TKUZRMq?=
 =?us-ascii?Q?5zZ5E+zH55mwJzi9958hpsUJBjGuVpMZO/rMKaSRARtKXY11zz6twq1odmmZ?=
 =?us-ascii?Q?5g6wwM+SvNVHIH/Gnn9wzOM78cj4u5zUaqFvyDtmaW0eEW0FTwLZayR3BzKB?=
 =?us-ascii?Q?1E5JokSAzxdynoLqhU5kW+1Ni0u64Pp7bDLvriSHSdpWi5jDXo5kI1BcK/SD?=
 =?us-ascii?Q?BYgH+XznBPKRPS6ljOXxprowiX9NGfR/wgGHxfPPuoXzVCGQ6QzjrH2fdeAw?=
 =?us-ascii?Q?fNM4ppP6P1WORo5sizRmciw8mp0eiBeiCW3WiEFbfyx3LC7gx+IHJ8pqps4+?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf106bb6-b8b0-430b-7aff-08dc6543685b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 16:18:56.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lD3i8NmPFAlB9MctKHMcvr506gjKtr9FST2BemrpTB3M13d+Ny/NfS61dmjBqRGT/hBb9SpKdFMMYnBqZm0yi5qQBgMM+YOiB5RPDbE72XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7063
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > Also, the assertion that these kernels will be built with
> > CONFIG_SECURITY_LOCKDOWN_LSM=n and likely CONFIG_STRICT_DEVMEM=n, then
> > the entire user-mode driver ABI is available for use. CXL commands are
> > simple polled mmio, does Linux really benefit from carrying drivers in
> > the kernel that the kernel itself does not care about?
> 
> Sure we could it in userspace...  It's bad engineering, limits the design
> to polling only and uses a bunch of interfaces we put a lot of effort into
> telling people not to use except for debug.
> 
> I really don't see the advantage in pushing a project/group of projects
> all of which are picking the upstream kernel up directly, to do a dirty
> hack. We loose all the advantages of a proper well maintained kernel
> driver purely on the argument that one use model is not the same as
> this one.  Sensible security lockdown requirements is fine (along
> with all the other kernel features that must be disable for that
> to work), making open kernel development on for a large Linux
> market harder is not.

The minimum requirement for justifying an in kernel driver is that
something else in the kernel consumes that facility. So, again, I want
to get back to specifics what else in the kernel is going to leverage
the Switch CCI mailbox?

The generic-Type-3-device mailbox has an in kernel driver because the
kernel has need to send mailbox commands internally and it is
fundamental to RAS and provisioning flows that the kernel have this
coordination. What are the motivations for an in-band Switch CCI command
submission path?

It could be the case that you have a self-evident example in mind that I
have thus far failed to realize.

