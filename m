Return-Path: <linux-kernel+bounces-130838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF545897DC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3B71C2170F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C861CABD;
	Thu,  4 Apr 2024 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDqdFqo0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED61B59A;
	Thu,  4 Apr 2024 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197996; cv=fail; b=QpHP4gO8uOCEBzFRQsF2fJjfKDKEH4VvFZ3yiiiBbzrPuGk6PhytIDgSxsT2E+FV9bjFGnNJl5IoVSeWuywPxd0oADdqlZCnt7UiZFLBrCJvp9ulm+DvZTOsI8dM11Ebqe6ckpR8zIw8gT99ECHGwSqAsJBzpc3LE7wjJbl7yzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197996; c=relaxed/simple;
	bh=qUcIE5d2JnVvMow/U80qtWcfZHcuh2NlkTJDHYBRlFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bpTObnCm9LpB3uvt9Aev3tGhAClCzwrhwg4lxrB06V1063byb58xah5KaIx6SQE/vmMC8li5YGJsxf4Wpgnsg3ZaOk6xWxcWKXVk3so9u9F1JPyqx99AfpkEtXNzSAJQrXUI1BPtkMLtEu1VVsdA3cc108EdX5rU3Psq7A8KeaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDqdFqo0; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712197995; x=1743733995;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qUcIE5d2JnVvMow/U80qtWcfZHcuh2NlkTJDHYBRlFU=;
  b=UDqdFqo0rYTKwz4kB3xsHj6jFuPz8hmnqqquvZX0VPxJ0hsc8w9Y8Yn1
   aEr1hXaSZgFU4Z0iK06xHwVTUmoTbZpKj1SlKYpB+yq73pu4d+k6mvuHJ
   2qBuUuE+VDZITU8SCI7911nAe1eLHqHP80oRwXw9efXrmmQJloNPpWglA
   E4fCFnPIhRX+svP+kaEFUazKxm6jWN/2//1aKrquJSKKQbwADNZfByBZL
   GiN4E8d87PcOQL4IB1shRNz6BfsrTCuSfIrCnPQ9Ax/JfC/A81Njx+464
   qmWXSyj/Xd38/Rs4QA2Pf+Am8/qA1JdMF1GCuZ9teKjjLcAIuto7FQZlZ
   w==;
X-CSE-ConnectionGUID: RWoSBAmMSA68iN11jtgoNw==
X-CSE-MsgGUID: CvZaJS0SQKC45TTtBZK1Jg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7384280"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7384280"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 19:33:14 -0700
X-CSE-ConnectionGUID: MGZQWqNkSzyK5FbLnim0ig==
X-CSE-MsgGUID: kRtXpjvOTIKDjKu1Xb1jfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18668499"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 19:33:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 19:33:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 19:33:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 19:33:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoVVI63q29cN5xCwKCQejxNZRIPN3TcgBDgG6lUoXNUX41eFOcXo2YKFCwVm0as5zmKHcED1os95IlxfoP8+WCF7ULIcIQpXD6C9OjqosIDRIs+ZfDs16oB5Wh9x3h4zUInBAORedRYt5TSXNOj7s0KFx9GWalNdt+LCp9B+luNVWciE5kMAkoT7qhjAXXPmXg6h7yKuCrSPmMdl84bin8uJGmt2t/6XR/Ha5tSzi7HCXLB/6DFptuoi9zHSEgLokt3CDtNbfHhpYtwc454LijqXTEE6Drt2Aji/6J5Txg1jIzzShXC+ZMBiU21aNX/OW3BWxSygHKNb0ZJ4y+FvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzl1dJJV9/MYbdL2RKGbp/SQeh77AGxxVeSRY0xiE3U=;
 b=Yh8YpgrnW+wrEgRe/YiaHZUSkwGNK6h4wSnE67La//EEtvPzfZw05kclAqyhs72ElBnoRf0AMpNyRwIK4+Axcf9kovnft3FcC/eEqeaVVVXOii4Q+gRoiMzkh21YPneCJW9dGlhZ9gasw+i70PrLNQLO/zMFB/kesRcZoy2DR7TBpYwJs4ybqwchBlcB92//OaFgjusFAAvEJe2kM2V73FpHJ5HU1hWYNPr2xpGmAqf1Y1fwFZ/0WR0mKL6B5fuosYS7esh+rfatiy78Wv5eKczJSkJYPqpA4SMqtUnvNiQOdwuQ0KPkSlwX0lovIyJjQ3GzA62mT18lhSTaTvvArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7737.namprd11.prod.outlook.com (2603:10b6:8:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 4 Apr
 2024 02:33:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Thu, 4 Apr 2024
 02:33:06 +0000
Date: Wed, 3 Apr 2024 19:33:04 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH] dax/bus.c: replace WARN_ON_ONCE() with lockdep asserts
Message-ID: <660e116027bf6_24596294ba@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240402-vv-dax_abi_fixes-v1-1-c3e0fdbafba5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402-vv-dax_abi_fixes-v1-1-c3e0fdbafba5@intel.com>
X-ClientProxiedBy: MW2PR16CA0070.namprd16.prod.outlook.com
 (2603:10b6:907:1::47) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7737:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvkMIjXygfHCzPOi4i8ib9M2hLrKT9RT02N3OhA34v4qVCirse0b8h5rtCIRHbJNTTOMoJFZNhoxzCitApqjqXW8R9DDvnZYv6viSSvh5tOKh0g/52JqDjzw0jzquGYMWmMo4UtDwsT5IeI16Fk7f/rySF/lokqfowGgIjwdOCNRTRDMV8wXmS0qU7juFNl4mn20WZYg9KUvqpsCDwzMRMyCzFr8/MLI0VxrOBiZEuiZU0OifHhjSkTjaHWkrEYqxFbjjbEujWlajIGEfptY1m59FextuwPrly2pgpi7T1BX+7TtWCVWH2Ypl5CH14eTArYvMzMPVWpqaaI24G2F/ygbN6MVf+onEOv1vzdAfBbgPEpdqyb4u2DvO5y6AHv1ddxODZj77OtVM9pJfdcjSWZ68Dj+fKCqjUKB89nB+5QFsJzGWaCIfAYtPiRqxa4GvucQEBr3ltbXWgt9CUr4Shj1Zm9vsbG+SxQoycvyQm7fGm8RqEezht2ICez9onw/LZudNx0SNHuiBwvjm2w6y0IJ7EGMIkvEzYa8FbGOlLAtCBaH6Lo12HuSnsJl1ISy0A38F9UZ5+yr+OMTdH4rcrMZTOU3ZTdWYp7lwnREXKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVgr02F+itSUfqlvh/z8q/MinH54dxtPHkZVBbhvgCLR24Fp4qQUnEUNfkO7?=
 =?us-ascii?Q?PWIaOuRHkkJwBUYRG+xZv4daQfak9IYQMSj+Hv/ihawvBMlUb/pLRnnWC3xg?=
 =?us-ascii?Q?6CuixuyO7VGBU6AgiGXTycy1atilK2YXcZMFBEM5VYPBvqIzJjs1771NLwQ6?=
 =?us-ascii?Q?NzuRE0C5ccZZADKILeVLEAkKyEfum+z21qPIP0NR1l7qbkloySinxe6hxy5F?=
 =?us-ascii?Q?S2CuZ0HJSfhYJ1gxmiX05EouaBNwPOdzP1vsSTxyMgndFAXEF6nUT6vcCDKL?=
 =?us-ascii?Q?Sj0ETtOUgmlFzBdfkElB33hUJEYMB9a0ZczvlIpMoVTJC3PNNhlr70bWS6z0?=
 =?us-ascii?Q?gEhKyNqLRYAHLEBnu7xyvLwtKze2An9Q2Je1YaaffWOTfxfrPhaMzGGKdBAC?=
 =?us-ascii?Q?y7Ydv6aVx7p52ZkoG4d3bkdHgdh8OgFiWxNrC0NuLNJ2BS92aAXy166BHAHs?=
 =?us-ascii?Q?68m2b+U3p9QtjuaSf+JdyFwjFb5qJ/tieKDdwIEO09o9vmyxMfqcVOXfzSTf?=
 =?us-ascii?Q?PCf6OI6DGeMFLOvSPaxmpY2/KgImXqkpIYf53jwHK4aDwn8sXTyC/oNfT+5e?=
 =?us-ascii?Q?MjgL4Vd5j3NKI8PtxfQVssNzPSJWfQGFA3gFdUTAhkjUp7BSalsST5RefkyS?=
 =?us-ascii?Q?0Zjzr9P6ZKekS6nZHuEOilqLvQQlwWInMfgdaRWKXEFLlHhQohm7GocDkek3?=
 =?us-ascii?Q?uaAi0P3GapLy6V0nKh17/JsOriyK/ToCgssrzjoh5b4lppUBRUVnBAKJfJZO?=
 =?us-ascii?Q?Z6hbZxxKernVBbPDgrPUZveQ7tolZLVODH9rZNm22BzZ1bFWuIOzSWp2N+dT?=
 =?us-ascii?Q?7RU9xASOW7cvBrkES29rNgwP3MRvW36RK+ZtFVzitL5Jgc1WmxTIELC+VOvK?=
 =?us-ascii?Q?EGa9bdJBeFdHOY2vG+rJutvEmqxQvCm0wJg/12ANmClhfV597X+ZsIgygB56?=
 =?us-ascii?Q?Rgrxi8YGXuEdL77rRYznUdV8HkXec/lRJZmYYnu7YMwX4MedjSWdHKdBgAz2?=
 =?us-ascii?Q?IrTUiI1qFesBagVwsPE+iW8wmGcRzvZ76KolqYIS6842eXu4seVYluL41Xon?=
 =?us-ascii?Q?hOqm69w4i4W0t59djcy5lhhJA3qCmt8Yl1leV3CCxtUPU4HK09/dH5jhyHaX?=
 =?us-ascii?Q?CzvgrgVkqu3g0JQMUZbeud+ygxLGDKZRV1xN1+O9VtxEbTnmd95ihsXRlvGF?=
 =?us-ascii?Q?ucbgdJsWtBewISHNYaFtQ7Wo0cBSkYwzSoY/OtjdPC5ZpJVAf2W29WnC3v/V?=
 =?us-ascii?Q?Nk1jmdc+6sZuiBUWLmb8U1knIIMeVVxvUjGO5RSvCADczRWwzJlS+NXaDHWg?=
 =?us-ascii?Q?VmpSN9BYfxSA82mdHGpnKaNBzmLdwiW8MoqOuUcKqEpwoyjkXL5et7hfqpgX?=
 =?us-ascii?Q?Utn/IRmF9SauUacw/wZ5J+5PYJL6z4is/CY5KGatUykZPd4ZT2L5g+55RZHZ?=
 =?us-ascii?Q?H7DlDuAkU6WIoyfD7S1Uq0IvZ+UUhRezwyjnkSpmq+CJ35g/c8Wfa3OQ8Umc?=
 =?us-ascii?Q?d+kdsjE6c6s/l4FbnekJytW1NkRhBUfnH/ZuB+5Dx4hEm5BzJiEg4NLdFpx/?=
 =?us-ascii?Q?NAZCswncOg3SRdYnAkk/xPuvm84e9BK/ZrfZK27V0p3F1QkMQ3GH3Zxqwj1J?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac027ca-81af-4b26-162b-08dc544f8f72
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 02:33:06.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWmJJspzewh1K6qZX5eQ5HO3UihY7Y2K+NK8/BFaHb2+uiMflJwQcOQXllQJ714lPvMyFa1FbIjArnf5JuBvcvIpKMAzfOKuDpAoiz9wlw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7737
X-OriginatorOrg: intel.com

Vishal Verma wrote:
> In [1], Dan points out that all of the WARN_ON_ONCE() usage in the
> referenced patch should be replaced with lockdep_assert_held(_write)().
> 
> Replace those, and additionally, replace a couple of other
> WARN_ON_ONCE() introduced in the same patch for actual failure
> cases (i.e. when acquiring a semaphore fails in a remove / unregister
> path) with dev_WARN_ONCE() as is the precedent here.

/me goes to look why failures are warned vs bubbling up the error...

> 
> Recall that previously, unregistration paths was implicitly protected by
> overloading the device lock, which the patch in [1] sought to remove.
> This meant adding a semaphore acquisition in these unregistration paths.
> Since that can fail, and it doesn't make sense to return errors from
> these paths, retain the two instances of (now) dev_WARN_ONCE().
> 
> Link: https://lore.kernel.org/r/65f0b5ef41817_aa222941a@dwillia2-mobl3.amr.corp.intel.com.notmuch [1]
> Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 797e1ebff299..d89c8c3b62f7 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
[..]
> @@ -726,7 +728,8 @@ static void unregister_dax_mapping(void *data)

..and realizes that is hunk is confused.

>  	if (rwsem_is_locked(&dax_region_rwsem))
>  		return __unregister_dax_mapping(data);

This is bug. Either it is safe to call this without the lock held, or it
must be safe to always acquire the lock. Anything else means the caller
needs to be refactored. Conditional locking is an indicator of a deeper
problem with code organization.

Yes, this was not part of the fixup, but the changelog led me here
because no WARNs should remain at the end of this effort.

I think the confusion results from replace *all* device_lock() when some
device_lock() is still needed.

> -	if (WARN_ON_ONCE(down_write_killable(&dax_region_rwsem) != 0))
> +	if (dev_WARN_ONCE(data, down_write_killable(&dax_region_rwsem) != 0,
> +			  "unable to acquire region rwsem\n"))

In a context like this that cannot return an error directly to the user
process making the request, like in a sysfs operation handler, then the
locking cannot worry about signals. This would become an uncoditional
down_write() lock. So down_write_killable() is typically for request
contexts where there is a user process waiting for a result. For
contexts like async driver probing where we might be in a kernel thread,
and definitely in functions that return 'void', it is a bug to use
fallible locks.

