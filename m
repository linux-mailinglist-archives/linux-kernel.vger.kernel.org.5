Return-Path: <linux-kernel+bounces-133731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365B889A7D7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0B01C2191E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5021C32;
	Sat,  6 Apr 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNXoeRuI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20377C8E9;
	Sat,  6 Apr 2024 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361883; cv=fail; b=LgFVqvPAUxSwEXzOii3hNf3cnaXhV5DcGMpZXWfkyWFSkf1xvsPUP9uNIfko+jleawEyFIDHrgDjM26KDTca4B3Xy5wNBFtxA57TPLSBUjjgY+eQ3dtQEF5r608E+4eSU+nsm23j/uNIwMa+DEXZff9si9VJvqunx2SxL0QS9as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361883; c=relaxed/simple;
	bh=QVeIifgjgC+qKbw5JqGHffOHsb/WaJ6NXpnNJIn7oDQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cd6GCXnVMdUTu6F9z05n0o4Acj7634AGQdnA731/p6jjpjAw9ufloh3J3fuHxgzoqSv0gNzFtOY8uCZfJm7J9HEU3xBZmHJ182qyua2ueH2D9ltBegJnWXdUd9qPOCLUsc0cIo7WkCbD/CKUMgUmbjSxNDJEAyaidRZmCbgU/E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNXoeRuI; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712361882; x=1743897882;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QVeIifgjgC+qKbw5JqGHffOHsb/WaJ6NXpnNJIn7oDQ=;
  b=SNXoeRuIjIpAjxeW9VQNPAtUOP8c1cJLfJxQc4/By9h9VEHFlsBWHycG
   B8uGjzsk5rsaWusTj8o0X8U/E010RfP/gfmvAXDcH0aMChl0L/zON+1Cq
   hfIaOL7AXGHZZ3pmCmaBsD6xliAqVjSETakmcowWQq7sgcJtxly+lkiuM
   eOLLpc8nE8mT2RB6TDUA8HsQ1ZoAF0qPAAgZAuVUEfGwEkSTwz9wKqDtL
   oE+D37gT2OFy31+snbBENpLCm33C6SoL/paxQqkjtGJQmwguS19yKRUZB
   dclraxQveOcNRn4GVanViIeERYqJS0wGHp2cL0GaYtHJgaC72lDeA949Z
   w==;
X-CSE-ConnectionGUID: iQgOEbHYT/mPb+e2ptbfSg==
X-CSE-MsgGUID: JR4avEzgTvymwCF3MnZEZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7879556"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7879556"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 17:04:41 -0700
X-CSE-ConnectionGUID: Ipw/Zf7kRACcfuB3crE7DA==
X-CSE-MsgGUID: twh0DtJ2TzaybK2LZFthzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="24064808"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 17:04:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 17:04:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 17:04:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 17:04:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 17:04:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDdCqmkO7Ty3C9IWztibQdP6Hdya2odWtoE2XRsAAnj33R/7iX538BpEg8rjflVqCTWZA8QPr/BREGbAMkcNEPBXHSHCpu8A66QOphExogURcWtXz7SbHkMgHEgyXobOFqqUhscfYzUSTl9NDk5/yUc6wA8ggxl6zxS4EM9S5Qqgxhy2WQeoy+9Hx5d6+SntYLTQa3AGmTZ121bZBQd/wuXz3UmUaXewTH9GzaqbfbSuljEEVQ5PkLh6NZ+/YVT3fXjj3CASuu4B0rv3ZEFUSQ1fRMgxPahN0y3OryZ8bxlg5eldSUXQxYMgqbNgq12Xs4RloB5VMYX9ozwbgRSVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60+4PSmIrnT0S3tcikZgSmWz5D9zKBLsBZyvlovSCas=;
 b=bOJ+gN6qG1USfioEJJXnGEYndW+fnB0dZ7Zxtl+g12PPRrub9xB8ejnHt3NUUasQlC3G8pvgBqpxdm18/0ezVo5HXlbMETgybqhzpRx5266kMMo6dvUAjqx69eRtJUlP1h0Pq4G5CX2Oa2nR+ynoPvTOys0CflpImmSjq9Hs9g+mNZdjdCOl+45EC4nNBgZmhYRaJOhh+ZzkMReHGiSZOJwgkxcFZjdEGe7WRouSLbwTOoq9KKegtUj/eTVWIl+3boScOlZX0zRNGDu83wXuwgXxX3gXRBuq8YMzKXbDVxdg737e/qk/ERHyzwWOE5aCOUHKdObEngQq5UNygKhlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5928.namprd11.prod.outlook.com (2603:10b6:510:144::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Sat, 6 Apr
 2024 00:04:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Sat, 6 Apr 2024
 00:04:37 +0000
Date: Fri, 5 Apr 2024 17:04:34 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>
CC: Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Harold Johnson <harold.johnson@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, <linuxarm@huawei.com>,
	<linux-api@vger.kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240321174423.00007e0d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240321174423.00007e0d@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:303:85::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5928:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJh/mdteVb0wzzs0pk+sqJhsZA/LRI8mHssK4sVhRVuDgSl2bi/h1gbfoT33kgSicGptBbfdK+NQb8fG0Wp2Hx7kcbmbk3f30m+i0REzmvA3d3z2IgljoRCUE5cxDaKKn/5qD8Hvs847tOeVK0+YwROgNsFzFnjNhRKN2C9u2AMH3yOR108KuVEg8rNRZ+uW0sMhuei4VEj7b/c690YFLN+DpwNi9qw/BPcbR41I+nUwYKUzgpFG2ETSNSqUJZYJnFczj+udjbC/dh5zpfsUoyb/Sxf6W5tJebx8mEmseiXA3VuXAhVDB+jfCdlmTEMeewDDKjJgzjSifQtokN6Ru3XK7zGvFYwrmv74pv6vchMOZnfj9krFBRYRJjOPM3iFGABBtldNqQXc0Dt2aK+YXDFJodoy9DsT2LmBjqM3kiPXKbsfUqTYtizMkU+x8zOceoQCwUR7Buidpk1WLhnLsUPXJU/xuL6OdlBNq3wHGP3cF99FdO/hdl5avTpQ7Sa9Di6ChbKxs6sTSYp90eq34R6AazFQYZoeZH4DvxzjM24G/SDmk8egpXTyWEc88AJWkIBbexTxacuDLuwInssqZvFKblsCErwtmIUPoufmqz6iSVz9XrJUrHk+yBi8aWz7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yxLgh3cHseONTI52Qym+4WZ4/m3Ar90BkV8TWh07mgM2NN6X/WIaW6FS2iDa?=
 =?us-ascii?Q?+zx2TF82X5oHXqpFTI3PNhoW+NPtg5DOhQtYtyTlyOP/3tXGLgF5lkxafGMA?=
 =?us-ascii?Q?vZmlfpgn2/NhLntDY1ttzXsRampliLmBRz3Ir4cCddInQCglgSTof6FRkkXy?=
 =?us-ascii?Q?5SqYSKJPzQSSMBBWJ0BnKY8qd5AVhRc4vFva3QgaSsW95hjCuoWMxUeyFgBs?=
 =?us-ascii?Q?V/QBqimX6Se4DQ8Jz8qG/yqwWvp0n3eR3GbH0npqK8Ws9qOWVtY85cA6epzn?=
 =?us-ascii?Q?7UE4jppv0+VO7kNdC3LwOI4hZpGhHIWauTM1iUvEqcgQV+4JmCjTtRK6xNsg?=
 =?us-ascii?Q?4Pn3/hVxwmJ1NkUWlUCiiIE7ZTSl0xFI9TbyJEJJfKyngMi2NCZ0EUK7ixnM?=
 =?us-ascii?Q?c59Ll+jQrsEgpMG9GKmXvd1W8W7REkEXgB9VydXWjg2LnKxMLerENKMY2JJY?=
 =?us-ascii?Q?O4VEIDhCgQimb2zHepaQ5B++ZPkaMdMetOUy6DbejhP3b/gcv1W6hbBP0l1z?=
 =?us-ascii?Q?r2g3yCTSjCxtLiRN1kBuRDGcezYmMRDWcBKJCmLFxXz98jixbUpu72dIEq2p?=
 =?us-ascii?Q?Raqhpc2R+B/rbsSxIIgDdhscL6+WhuSxHbstD55JfIJw/TqUuVdEFISuKTjD?=
 =?us-ascii?Q?cxHn4XapbpJUgKcVN9cjCsDlH7aLnONhL9jEKKcHQ8BVL0zc07GLxCYtWb5Q?=
 =?us-ascii?Q?eeeDjB8GK3Rhh9wYnLwv5vuY1bxCpWB1Rb+H1bcrNolPLPZzth4yV1nO/2nC?=
 =?us-ascii?Q?VDtk2cV2gPxB3tAVOiN9n2bPIDwLyUR/Wli9n9YwQ6up7+CjGCLbNudjCHgt?=
 =?us-ascii?Q?/tQh5asaQcu0yfO06uYuUkOvktxlt2TCiimJin4CdFvfuOvn+dn/FvFumSR5?=
 =?us-ascii?Q?2/omfoJGP4oJCPvIWcmO3UD7gjrloEt/2AH95+Ea/r1fbzlGoYETgKN7VNzu?=
 =?us-ascii?Q?oMZ9gsUlFSdrfruReMhT3cEKi9o2MdiCEaWJ6YRivG7GQZKqZP5OwujRZxcI?=
 =?us-ascii?Q?5NJ3UQg3TY0LYeiJoDQTiMEzanBPRq3YvPZHhiy1K8LpBgS0t0jLlkjIJk66?=
 =?us-ascii?Q?/D5htaRxIw1drjQhKsH50IFCVA6zLSa2orrMcF4PjlCkZFR7Xr/ONF2c/X1u?=
 =?us-ascii?Q?pFPtSJB2er8vf+v6BiGr7bGTilGGUDjpsDUn3yaZsuq5x0QlTG+rndUOgBQz?=
 =?us-ascii?Q?KEz7uBCikraGVnC5nExHH3nWeZ+M088l0zj3fdZbbxWwUC7CH9SnhWvDiqHD?=
 =?us-ascii?Q?NojDl6Z6b6DX45nVT0KwNkpf0hE4qKuFo311aDNElD6pMKJuo3wRuyRdF22d?=
 =?us-ascii?Q?JQdgDQSuHmSfflyOslWrH8egHk6noyqgeG7XZe72u6BL36irPvH19FaOEEy9?=
 =?us-ascii?Q?40KCvsbgHvffR+zlpeT8r2OOydZP45DIfI9qx8Zyr06cIwAZ6osUxh14LEUJ?=
 =?us-ascii?Q?Vd5imVPOoK0a3O9gCXi205BugjMrPM5edvZWJtPoWPjctscU7ynx8rDRBuv2?=
 =?us-ascii?Q?7UNuYE3tRsopNHgqInSCtVVGaJABPMZmaS303fdls20Ixt+djSRHDoG+yAFm?=
 =?us-ascii?Q?SOnvQ5ZkkNtXJQHmu4D1nET985Ljul44+/2nlM7oY7+1boJ59onvUCrK1f9g?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 150033bd-f7b2-4f50-9089-08dc55cd25b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 00:04:37.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2NAx4VhxPp8Q7tRdKl0qzR2OuiYhPxoBNvNdZDp3h/ligA+suzcJC9TBr8mBBlkEPjX6mLF4P+LLE518k3E17hHqtCK0O+SYVOC1fhk04k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5928
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> Hi All,
> 
> This is has come up in a number of discussions both on list and in private,
> so I wanted to lay out a potential set of rules when deciding whether or not
> to provide a user space interface for a particular feature of CXL Fabric
> Management.  The intent is to drive discussion, not to simply tell people
> a set of rules.  I've brought this to the public lists as it's a Linux kernel
> policy discussion, not a standards one.
> 
> Whilst I'm writing the RFC this my attempt to summarize a possible
> position rather than necessarily being my personal view.
> 
> It's a straw man - shoot at it!
> 
> Not everyone in this discussion is familiar with relevant kernel or CXL concepts
> so I've provided more info than I normally would.

Thanks for writing this up Jonathan!

[..]
> 2) Unfiltered userspace use of mailbox for Fabric Management - BMC kernels
> ==========================================================================
> 
> (This would just be a kernel option that we'd advise normal server
> distributions not to turn on. Would be enabled by openBMC etc)
> 
> This is fine - there is some work to do, but the switch-cci PCI driver
> will hopefully be ready for upstream merge soon. There is no filtering of
> accesses. Think of this as similar to all the damage you can do via
> MCTP from a BMC. Similarly it is likely that much of the complexity
> of the actual commands will be left to user space tooling: 
> https://gitlab.com/jic23/cxl-fmapi-tests has some test examples.
> 
> Whether Kconfig help text is strong enough to ensure this only gets
> enabled for BMC targeted distros is an open question we can address
> alongside an updated patch set.

It is not clear to me that this material makes sense to house in
drivers/ vs tools/ or even out-of-tree just for maintenance burden
relief of keeping the universes separated. What does the Linux kernel
project get out of carrying this in mainline alongside the inband code?

I do think the mailbox refactoring to support non-CXL use cases is
interesting, but only so far as refactoring is consumed for inband use
cases like RAS API.

> (On to the one that the "debate" is about)
> 
> 3) Unfiltered user space use of mailbox for Fabric Management - Distro kernels
> =============================================================================
> (General purpose Linux Server Distro (Redhat, Suse etc))
> 
> This is equivalent of RAW command support on CXL Type 3 memory devices.
> You can enable those in a distro kernel build despite the scary config
> help text, but if you use it the kernel is tainted. The result
> of the taint is to add a flag to bug reports and print a big message to say
> that you've used a feature that might result in you shooting yourself
> in the foot.
> 
> The taint is there because software is not at first written to deal with
> everything that can happen smoothly (e.g. surprise removal) It's hard
> to survive some of these events, so is never on the initial feature list
> for any bus, so this flag is just to indicate we have entered a world
> where almost all bets are off wrt to stability.  We might not know what
> a command does so we can't assess the impact (and no one trusts vendor
> commands to report affects right in the Command Effects Log - which
> in theory tells you if a command can result problems).

That is a secondary reason that the taint is there. Yes, it helps
upstream not waste their time on bug reports from proprietary use cases,
but the effect of that is to make "raw" command mode unattractive for
deploying solutions at scale. It clarifies that this interface is a
debug-tool that enterprise environment need not worry about.

The more salient reason for the taint, speaking only for myself as a
Linux kernel community member not for $employer, is to encourage open
collaboration. Take firmware-update for example that is a standard
command with known side effects that is inaccessible via the ioctl()
path. It is placed behind an ABI that is easier to maintain and reason
about. Everyone has the firmware update tool if they have the 'cat'
command. Distros appreciate the fact that they do not need ship yet
another vendor device-update tool, vendors get free tooling and end
users also appreciate one flow for all devices.

As I alluded here [1], I am not against innovation outside of the
specification, but it needs to be open, and it needs to plausibly become
if not a de jure standard at least a de facto standard.

[1]: https://lore.kernel.org/all/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/

> A concern was raised about GAE/FAST/LDST tables for CXL Fabrics
> (a r3.1 feature) but, as I understand it, these are intended for a
> host to configure and should not have side effects on other hosts?
> My working assumption is that the kernel driver stack will handle
> these (once we catch up with the current feature backlog!) Currently
> we have no visibility of what the OS driver stack for a fabrics will
> actually look like - the spec is just the starting point for that.
> (patches welcome ;)
> 
> The various CXL upstream developers and maintainers may have
> differing views of course, but my current understanding is we want
> to support 1 and 2, but are very resistant to 3!

1, yes, 2, need to see the patches, and agree on 3.

> General Notes
> =============
> 
> One side aspect of why we really don't like unfiltered userspace access to any
> of these devices is that people start building non standard hacks in and we
> lose the ecosystem advantages. Forcing a considered discussion + patches
> to let a particular command be supported, drives standardization.

Like I said above, I think this is not a side aspect. It is fundamental
to the viability Linux as a project. This project only works because
organizations with competing goals realize they need some common
infrastructure and that there is little to be gained by competing on the
commons.

> https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/
> provides some history on vendor specific extensions and why in general we
> won't support them upstream.

Oh, you linked my writeup... I will leave the commentary I added here in case
restating it helps.

> To address another question raised in an earlier discussion:
> Putting these Fabric Management interfaces behind guard rails of some type
> (e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the risk
> of non standard interfaces, because we will be even less likely to accept
> those upstream!
> 
> If anyone needs more details on any aspect of this please ask.
> There are a lot of things involved and I've only tried to give a fairly
> minimal illustration to drive the discussion. I may well have missed
> something crucial.

You captured it well, and this is open source so I may have missed
something crucial as well.

