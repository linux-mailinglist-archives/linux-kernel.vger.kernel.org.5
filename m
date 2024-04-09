Return-Path: <linux-kernel+bounces-137662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1619C89E59B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D71D1C21FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DAC158D86;
	Tue,  9 Apr 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfynT8fC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB115884B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701316; cv=fail; b=qbdW9+UWPvZcG5ucP224tkYnT/gq7Yi/NirrEi3zoFwbENvsl7gq/n4a76eBnKojkYbKsV/dlyZvKu16DsZZBD6ACVRksZNAc/RZ+RHuMZxBmDAtrWi1gKP5Zhn4wfhztQ66dopo1E3yi3Xj8LGmpX8P4/U1oXRSH0TxYzB464c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701316; c=relaxed/simple;
	bh=HXSDmMVOOWpanwlkJIE4RkBzYPkpfDKA553IIfX9G9E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S4iS2RF3sLOnEgOgEgCaMqBn8wNQ/3iYBVQN/+xh8p1OP8N4zBDqyK5byZ8dacker7XZg8Chb3E60I4RZkAcdDUcHOQJj7dQCCxc2ujYqnHabDa1Gkq2LVAjO/UJMadQ84KEzB+74LT0P70oXy+1odeQHyOpm1CSxfK0ystp3R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfynT8fC; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712701315; x=1744237315;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HXSDmMVOOWpanwlkJIE4RkBzYPkpfDKA553IIfX9G9E=;
  b=OfynT8fCDxRbAOAYWxJ3UuwSwx93pRa3vIYfIZ9clWSfkZqly8kcl4mF
   zjKIbEaJ5Rl7NIaWFlCGMrLn2Enj5ioTOiQJwr+aItU4joMEi9SRvotVj
   Nx5P+sBtKjhZuxLPI96A8tbXPPReipPJT/dc/9HWKmX41IiSYmqdAjd8F
   pBYFtATGgu65fsfhns7F8oDoksYuTf283vFUztoW+VbWTjWv3M5s11SZ5
   ouOj8WrqDU+9eHzqTyvX1PVccpvpYaAYWdVO/p5Q5wondxQC6u+BCneNM
   NCdidF5b+E3+UiSXUzKayHkhZAoOzWd520HJE1hgds6ncxVeWPopjZW+s
   w==;
X-CSE-ConnectionGUID: YcO+uWAcQ5CF8UUbr3k62w==
X-CSE-MsgGUID: qkuYDhD+QlyZd/ZYpyuSgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18608271"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18608271"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 15:21:54 -0700
X-CSE-ConnectionGUID: a8a42L8yQ/+u+pNJrTV54g==
X-CSE-MsgGUID: fHuno0xWRjGjeIVfrGVGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20400348"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 15:21:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 15:21:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 15:21:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 15:21:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 15:21:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQv9pwDtjkhlsbpBkJ9LOqGpRUXbdwpEpfDIaSL/iWvXdQ9byGK8wLYqIBpCOi7++PI/8SbM3h0M/hP+w/zaDDSAhKqdHjeDRKArIc8Y1f52iFZW+EqxgeqMSkU2VuI33WqIVT6oQlpVR1GFSfviF8dJc6S/GgDCoEg3alLiHCDoNG6KIpHpcbZnU6TN7Z8QYU15CQZzcySlR8+sJMFZRN/wQKeMAwH4HfflefmzneGM/jr2+tvZ2dB8MKwhAeO3/03zb7ai97W5oYn8QAGdvil8gGRd/XVxV3gAWWKZBT4Hp972Qy72jPKcqWo/sBQBFwU0tPdQVa+bzRDGJE7KiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iE7arn5MWYtGGVRV8TkKCSdaLnidNfTQHfYHptKyKos=;
 b=nTLGO61oOGlORHQJKWsV3cWyrGs6eL8/9078CBmzmdVmQkSAc8NQNvvsuTRmhyrVaIOz2cFwlF5HWzbfdbN9MrsuL+2VsB/bhU4ZfM4PTLCO82pd6ghW0NRgsqzH4TvpeMNDmmoclEWdbK/n8sehbRmkQiB8kbEhJwwSQYgq/7cYzyCuyLA4GJL9ADly8qjzcv1145j4zRI7dC9SRfHcvw9MDg5lVZ3c79yIAjk7ndP3gXAgN4IIrTPbYbQ7VnHRjcRkO4aJ1P64VWJjb6eEmWtHAzzKUDYUjD9+BygBrfMOJt8dc4SaQUdDcxNW1tuKd+lln9jIdZaOAYFLDjzHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 22:21:50 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::7607:bd60:9638:7189]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::7607:bd60:9638:7189%4]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 22:21:50 +0000
Date: Tue, 9 Apr 2024 18:21:45 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>
CC: <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>, Jonathan
 Cavitt <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v4 2/2] drm/xe: Remove devcoredump during driver release
Message-ID: <ZhW_eTyS6Irp619S@intel.com>
References: <20240409200206.108452-1-jose.souza@intel.com>
 <20240409200206.108452-2-jose.souza@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409200206.108452-2-jose.souza@intel.com>
X-ClientProxiedBy: BY3PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::15) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|MW4PR11MB5890:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2i7ums9cdFDcuAWvVaKB4mElwV7vt2iG/rCJpWF1hdjcBxSeZRgf3ZBqOyuRo/WRdz8L13ywGEvunC4tFrEL6QQaMtFJ8ptj2URPwLKcx7qJldYp7k5nwmNXupLrvmw36C4FKAFpO1++6rXVi39oqiPdnIiFsfLOWwAXuAOxFDFc7cqP59Cttv2kkeWKywq8U0ocQv5jFLfQXNFM/Tc1rH+J48zhZTvm7hopbnk8xbOt8KcVrDP62wWviY84kUOSyxkYiOm5dmpfP2I/9qyXc7FhG5fesA2X4Jsz2bjBvFsdyDNwcLiyrYiuO0/N9UyMAjRuJfJxFx9hweW/vFVTB1sg+V0OH1LOX1X7GqgTnVeJ5z33L7ayGecpKm7K/OVNSZ/feq+pzTNd7jZjQV+tBsZ2xt67sOuqQ29eYPeMkPPoWf160AQDSZ0MhVAAyfNQkKGz6k2nbccBNA2agvdzVvfeNDHXgZPk5oJdxUGXvylm9YfD8UZAaTQYmV06k15igqXj2K+53GX0ZEiR8jdQFLNSZ2sl5uARKZWoMw6uYcxPlxUGSqGUFw7hyBCKosX9qBZflbHB5z94iELR0K7JXyNXwho3yUiV27oWae+TNKYqIT+gcsm8ejFcXjhZPe0YYQIltI3z+K68nougCNRzkMRpEK78Q6ruJ8hG93xAjeA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rdlDzt80Y0E9R7e26ZLQdapbpBR3GAjTC01VzrQvyym8xvl/BF+hlVJazg?=
 =?iso-8859-1?Q?59Knzhf6ndYhxx6D+iR+4qdwji1gq1BaXOgoez4zmRbDSmEIrg1nj4pSKg?=
 =?iso-8859-1?Q?PzyIkq6tKaqkzWULK02HSvlsDCs9nlj1hcdb0Vu06zuJeCHS9LvFO/4uGP?=
 =?iso-8859-1?Q?EldOt8N4MVuB8iTt0GojGORN6VLVz2ud21SzFRjxdoyn6JsWVrXUr+XbDw?=
 =?iso-8859-1?Q?LHKFdhC1r0+y6uY7oflwhOX83/9Q/IwqkVr6ypqf6ALJe1Qjmy1iC6rOWO?=
 =?iso-8859-1?Q?N8M4gRiILbQx4ifwVI+74B+YvnS59UWWeQ7FAyIrwoQFZQX0p1B0UbqjlE?=
 =?iso-8859-1?Q?k8tggKAxJF6/1J5zF1KVIJO54Zd9XYwp30g9mxyPcqTljV5M7Zff2skGNc?=
 =?iso-8859-1?Q?8VKA5JiPPRNxVIxdnKoBOSYD/eF/hjbYH5MlLMvYqWPrCbonCLBKOUOeQC?=
 =?iso-8859-1?Q?teUqw8efiXYR93zFubjAjDPCNcFgbzsOcTsFJOwQtFHyrpnsaJ7fYEY5XW?=
 =?iso-8859-1?Q?zrsvaWtIlf9VBzttpu3RmSYrXoEE/ySFVqcmXxuAPm/vfAjioKuGd+GZxr?=
 =?iso-8859-1?Q?ixLhri5MftFdizs470S6hbe577g0RuTyA3qVy7N072lNKnNJI0g5mRsAiB?=
 =?iso-8859-1?Q?tXSLn1Nbil35czgGlt1U2PphrnK7/xkrorpt06F9b+pb3zI/qTXyGdmqkB?=
 =?iso-8859-1?Q?fscfVQjffSITOUAEP5akonJKcbXdWTabOU3HpOIj0ns2imFNyo7tKfPm0n?=
 =?iso-8859-1?Q?HAwAPMhtYd4U2zM+Lly0p1ozpuZ9owTaAbGia3dLjSDgbFf5kUHXEe09Nt?=
 =?iso-8859-1?Q?mzwShZvQhnpQIAPANaM95+BityFZ3oOEQikOyhBeDf5Z3NwVg0v9Cv208k?=
 =?iso-8859-1?Q?QgfPttg+qwMcyDPZY3bDLWChAp+dr3Gyu4jYtlUHESqKdugIfWeSV7G+Xm?=
 =?iso-8859-1?Q?NlHQ9s2bCBxaxct6Yg7w6rfpvjgpDqSkHPI1Y2ri2v5siR0O5kyOvbVI/N?=
 =?iso-8859-1?Q?v6Yso/VpaVBIxKg86/0IwUFkYkwKrP4PTatjiPjKgViFiTX55l+vVwL4ah?=
 =?iso-8859-1?Q?Z4jAW/56GBfZ31J99M9ruJJUkB2XRZWGQqbFUCflzPNWzpBC5+h9xzOo+M?=
 =?iso-8859-1?Q?Fw0w/M85aVNF+mzsgqNjlBK/857xJDmgXnvA2EsZwiX+RjQVGV7WRqwS25?=
 =?iso-8859-1?Q?m/7fAjWrh9o0AZnn1LjDNiH2cNsKKLOOiz9+GGlyJvVPbzYgE45DbM5EJO?=
 =?iso-8859-1?Q?lkrieHWaggyA8Md2bXQM+YeNfBkmnvOBg8Kdtzzn8XdPcvV7+SRMR1x/FB?=
 =?iso-8859-1?Q?hhQ7Hz7fbK0uqKHk03E4rTZvEfZTPCKgRVzQ/puhyUZlAeKt5hU0R9ZCdy?=
 =?iso-8859-1?Q?xBZFNMDvjTPJRHvTqxp/unInvUjT5IsP476x07ZVaoh8gwhV2CAtfxEIBR?=
 =?iso-8859-1?Q?VErvwZrgwYg9tsA9+0tn79C7QAEjpD35d+T8DsziWtsXQp6qNYgmygdP6A?=
 =?iso-8859-1?Q?vx79HdjVY8PhQslIN6FMMa8D0OKlUI/7tu1j6mzblNtlhfji5tzdl6nU1Z?=
 =?iso-8859-1?Q?LtHZqjFXJUm+io0pHtoUx+OMl8m9aZKun1gJBdA70lSD23vGg95yQgfeot?=
 =?iso-8859-1?Q?z379L6c1xIcAMy25f3u0na3h0zgjpU1BZnF18SueIsz6f1sdgc9ZIEYg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90863b0b-5b53-4cb4-9eb0-08dc58e37363
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 22:21:50.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCpzQIzyPG2PGgpJTwSl3I/JfVJwWSZUiM1JlcjlJvKa7a6kpEVXHqR9+f/X7s7vtk3ej9Dpb9xc63wR6MYjYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
X-OriginatorOrg: intel.com

On Tue, Apr 09, 2024 at 01:02:06PM -0700, José Roberto de Souza wrote:
> This will remove devcoredump from file system and free its resources
> during driver unload.
> 
> This fix the driver unload after gpu hang happened, otherwise this
> it would report that Xe KMD is still in use and it would leave the
> kernel in a state that Xe KMD can't be unload without a reboot.
> 
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_devcoredump.c | 13 ++++++++++++-
>  drivers/gpu/drm/xe/xe_devcoredump.h |  6 ++++++
>  drivers/gpu/drm/xe/xe_device.c      |  4 ++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
> index 283ca7518aff2..3d7980232be1c 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -9,6 +9,8 @@
>  #include <linux/devcoredump.h>
>  #include <generated/utsrelease.h>
>  
> +#include <drm/drm_managed.h>
> +
>  #include "xe_device.h"
>  #include "xe_exec_queue.h"
>  #include "xe_force_wake.h"
> @@ -235,5 +237,14 @@ void xe_devcoredump(struct xe_sched_job *job)
>  	dev_coredumpm(xe->drm.dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
>  		      xe_devcoredump_read, xe_devcoredump_free);
>  }
> -#endif
>  
> +static void xe_driver_devcoredump_fini(struct drm_device *drm, void *arg)
> +{
> +	dev_coredump_put(drm->dev);
> +}
> +
> +int xe_devcoredump_init(struct xe_device *xe)
> +{
> +	return drmm_add_action_or_reset(&xe->drm, xe_driver_devcoredump_fini, xe);
> +}
> +#endif
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
> index df8671f0b5eb2..e2fa65ce09322 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.h
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.h
> @@ -11,10 +11,16 @@ struct xe_sched_job;
>  
>  #ifdef CONFIG_DEV_COREDUMP
>  void xe_devcoredump(struct xe_sched_job *job);
> +int xe_devcoredump_init(struct xe_device *xe);
>  #else
>  static inline void xe_devcoredump(struct xe_sched_job *job)
>  {
>  }
> +
> +static inline int xe_devcoredump_init(struct xe_device *xe)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index 9083f5e02dd9e..ce27d0d1bdb34 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -20,6 +20,7 @@
>  #include "regs/xe_regs.h"
>  #include "xe_bo.h"
>  #include "xe_debugfs.h"
> +#include "xe_devcoredump.h"
>  #include "xe_dma_buf.h"
>  #include "xe_drm_client.h"
>  #include "xe_drv.h"
> @@ -513,6 +514,9 @@ int xe_device_probe(struct xe_device *xe)
>  			return err;
>  	}
>  
> +	err = xe_devcoredump_init(xe);
> +	if (err)
> +		return err;
>  	err = drmm_add_action_or_reset(&xe->drm, xe_driver_flr_fini, xe);
>  	if (err)
>  		return err;
> -- 
> 2.44.0
> 

