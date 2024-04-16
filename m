Return-Path: <linux-kernel+bounces-146313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C798A6369
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328A71F21CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4743BBF1;
	Tue, 16 Apr 2024 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QowAR8t8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CC33998
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247409; cv=fail; b=DUhtaegx4mkklLzkyJ1fV/1YeEH+LwWHupokUvjz9T0Uphg5G1xKJjZi6e1Lm9e7nwxooRuH33XSHzQDNPAYnR0cuWIgN4tWsmudPrkOTOYuwa6YtlmaUq4EIk1Gphl/dQ0jCY5/IMWOKWRkYkUykbiN37jb89dvinTUBsxmi20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247409; c=relaxed/simple;
	bh=rIOUFsyh/D/LI9pzA9tG6mXw5W4eu3wuNoIVel/fMew=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f0Vf4ETf9snKZnhbswOsYzp0D08QIsMZji0p6P34rSVnG7Uz8JshQmElfGeMayBP8Hwy267RCGSlgmjEweGeBhI8iXZ0lfW5mrHF39Sk93WnmU7Bdvxy1GqveUED5Hufh+5CDXwZoZnbCmx2S3Ld9GLx+FdXLEMTEDpt2j6bjrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QowAR8t8; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713247406; x=1744783406;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rIOUFsyh/D/LI9pzA9tG6mXw5W4eu3wuNoIVel/fMew=;
  b=QowAR8t8LOvRNYhj2bk6QWaBbBprSG+rAW48Zb4skJBxneSnaoqVVall
   Yy7Ol0zRsL7X3ZbacOBlCcmnZ4MQOtbybG01bcstiyYYHEDnIBBCHXl1b
   EhvEsRDzl/USIIFgzGNdldy8QpchggEdOx5aOMBbEIsDn0SlUrbyB7A/3
   Q3uzC3wVdlNcdxCKaOvinXpA2Hm0o+1u+IjrlmNq5fMrxri+0MZDKhyM+
   owCs9Z1DGg0BQgVU5n9bTTF8lCQoZ53CS0FtRBNSo2ZT27eCaLlSjKR0z
   qcQ22kEOOXtVa38Ov11QSGEtQ6jDUGe3LgjKZLXqQec1qH3TEh2FDkWWW
   w==;
X-CSE-ConnectionGUID: 9wo0Of7ERqSpEJIHbO5mAQ==
X-CSE-MsgGUID: KIPczZNiS+aLPV2nh1liUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19815207"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="19815207"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:03:20 -0700
X-CSE-ConnectionGUID: Vw7XIE8jRFiWM/1L8PcAhw==
X-CSE-MsgGUID: eKtWV3/FTW+fnZRnwCucPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22052011"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 23:03:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:03:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:03:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 23:03:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 23:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzl41bIxS/d0Y8a9xOrhE0ip6wFgexUPqjTUw+iANcvnMCloaIqbP/GM8nTcLi29nj8u42J5H7G2zfjkLnyJ7NaBN1HSIcdyjwo1upcTHlhSDLuMIytDJNB74IoZcueNIZzouPth19iOlaXiMIWkJv58WqktnTM4VbDwQgfHNhWCODI4+vkd81VCWyB+hcJ4muRum8s3bv4/+JE+hBSoe538IS9xjIC5HOzSLJFqpBFtHtm006WrpGsdY/QgjMGHimh/UrY8ViVt9XwralRFE01hvVbFflhM+n72NvhWKYLRVNlJGPv6PxVSHi8errfsHNU8Mn3KANbbsrP5C+OoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFnCHGSiOmA7BxPAD0iqpPm23IGJvbs+2Ymjw3N03kg=;
 b=T6dsZRwXHyUDvgXn2Y+iLfOiPL5cHZqB5nZARQ/dL/X0geK7a5lsI45kFXT5TewFu3LHisMaH0DV0aK2zBuAyskADRVk/tspO5AR3TvgH8NYLT4bix4vNfa9MjEQMucnyI6zpawTTk422ZdeFry2ZAFChwVfyjZbvokRkJWBtHmQaf7kF0YWUoxa3ZC9xIInuU/8Qo40UFDbe4rkeAaggZs6E7nD+XsodOjenm4cw6KTHoo/52BiRrywDtK3a01JpFOf+VNt4GhrWxXXoJUNUVqvuI0I7JID5UnCh73c062xeN+GlvK59h+eEBGiNT7C7uNo52lZI16Arx0LYYwqRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Tue, 16 Apr
 2024 06:03:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 06:03:17 +0000
Date: Mon, 15 Apr 2024 23:03:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
Message-ID: <661e14a2cdb12_4d561294c7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 2475074f-d3e7-4674-c5ad-08dc5ddae90f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/J6BM6gvx2SnqWQsjwj57cko5+BjSxqcQVaoSv3IWmYFlY3Azhf3OrebFTuMyY/pK9o/tEkVv+8esBo8rjYdSV68GDKhDvVAOyZhKWR0JMxmpdtNSumuPDBdw9z4HlL7mDxuuCObnXsSCNhjuO5HiTFN7hicnsrbzZ1ObR1jAZsUb3OBJ6iRiPVN9EaLQhhFhwlzFAH7O9GXKH8bFDJUr0dlW4vwjr1q2yKiClvLuXGiQMNrGFkO1mCvbV4PnYbS9oT/ueFy/uSwymcsyUQb9RoXm2sAZTDWkeFvUDLHN5UfVTCmfIrhzpABiZvZ5pPX1RbK1UUSiFs4O/2/Oeq9yjUrX7v7i/oqLeMwaElMWwwsQ/VgFehOup8xvPGBJCmBPznvWGEOAnLOAx1fnBSCM0QZidmrp3DYCP+Xf4l854rmtrNBmwtvSYI14Gs+DxGjB4qDNripHGi4G6AGTJIt+4CscR5szH+L0tU601Yk/aR4zyoi2Tu4R+LSwta35jAMoUyu2spCXYNfex5sQy90cM+yy3Oyl79QLzklip8WfaHjo0w91L4am6uPB+xnWcW3oAD2kGEAM18WIUjmVPe2C5rLvs4Fa2/QEW7TAQRU0r+hYb0wS8AUAbEWFTTeR1gzW2B6r7amPcobTTc14aj2mNhJE97HChzFWWL+Rmlh/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZoD+3wP5L6fzoKE4wWaQFC0JX4Ixdjbcutjv0HabfHXKk+4s/tu1HHU7SuB?=
 =?us-ascii?Q?nutsI4kvlyfrW9bahqzNG8cWHxRTUrvqqC/xRYS0POpQCZWYwwVVs3m7o8Cz?=
 =?us-ascii?Q?0xpwGlnZHLNYRciEFnVlmKfx0T1rNEaNYa4ij1Tca1RsznatgmUgdp0kuxh6?=
 =?us-ascii?Q?5ygtIC7mjf2bBPqZ+HaHrkfbflA8x/zoXSV7ZuYMRDPlYS137dGuWQE8f4L7?=
 =?us-ascii?Q?riVto777VJfn5O6ov3DnajztR8mKiBq/aoM1CunkmQ3DsJZsswp4q057Rmfh?=
 =?us-ascii?Q?+OqflhQRvOc/xYrYlhFquhSvUum0rhAASMjdrPSjslAh0VSL403+CRxajL5w?=
 =?us-ascii?Q?ZgUn7lgbBZ7o/EgGA3gpbzcZq3RPHsmIRs4xEkMXB4gImjJJc1yU+/sJacIW?=
 =?us-ascii?Q?74yEbMbL/VR1EJaVDwzqpX/ugp8V7gARzoZn+4dG1EByybw6dOjKXVz89fBN?=
 =?us-ascii?Q?bWBUuaIu8RQ4T+lLLevkjh+9QgRW4utjMo+8txW32ALGAMVCpnuxRjYELHPr?=
 =?us-ascii?Q?nEKMEmQI9BtOh19nA+a7cVScfuDykmZZetcH0UkmusDK8iB+v+1nghawRd45?=
 =?us-ascii?Q?W8Dt27JfK/8yxIgYIYddztSGBBQfk4PKf+GF/XJXvz0+g4tfaMkrO3YiDU6w?=
 =?us-ascii?Q?G97Bu7W4EPFU2GZzPk6VBvQ1ipWuNnoHpVyXI7f8kBuHD3dM+fHztJ7g7yZn?=
 =?us-ascii?Q?KRKsB1LGyIn7Bq80+nsw/5H/EJZjoN2P4IoIDOnzallc818MvbcSO2YgqxPS?=
 =?us-ascii?Q?yLNJZcMALVrc00Zham7UbZ2N0xRKbdOivfOo6u7SidFt8bIMzS1hlHy3DidB?=
 =?us-ascii?Q?A6WUPwsaAiuRw4qhzxBA0te3hqp6VuoIe5LSIyN3WhySwblFeTg3vV4wdyRA?=
 =?us-ascii?Q?Ol6ebdqp1KINVyiS0N1DGH/ePtlkfeYsKfnEsyxOrcQq9rTMM8uP9yKpgb2s?=
 =?us-ascii?Q?O1rYYheXxQVQ5w0xW7SRO7EXzMOoIrdFtiW4BvgFxVQZAUj87xnusKke7Quc?=
 =?us-ascii?Q?lexAsAx4YFGzhab1ogF7D5X+kv56HYEdTJNsq6aakhTcTtrbryTw4Gkn5CNx?=
 =?us-ascii?Q?WE6rt+LU9JuzauC+Hc3XfCUeVRx6/CxLwKnOioj7e8QIV7pRW2zmk3u9lVwp?=
 =?us-ascii?Q?KgbQQKt31YCtZA/U0O59vcQ99vwLZ0auZoXPCMWrMyZPjpdY0Zk8pyC2ls9Q?=
 =?us-ascii?Q?OUajSjks2N79gW/A5vu+b8KA2P7X2693JiLqV9s2PTDg8WWB8hF1jVy5ll4Z?=
 =?us-ascii?Q?aoXoR9G+B2vAxSbYQxH6xsWZATpq23pBWlwX6SUBNGcTWRiJSLxecmXm6fGq?=
 =?us-ascii?Q?YBCq07q0Fxjuvn9kQlRc15aoQqlqb7PMGL+FyzV80HOqetNOmroofDQ3T9q+?=
 =?us-ascii?Q?AhZI2Mes2f6RJzS4BA+IdonTbtnrTsVHlDplWCtvd7q/CY+N1F4EkNaXglTU?=
 =?us-ascii?Q?cDsEZRB7K9HKaHI6uplECGYrm8+YYVYG+c5gaWTT2Mk3Jvc13aEGQKkwF/ND?=
 =?us-ascii?Q?kE+1uH6pcm5vTrTdqRJpB+Y+5ulGCLojPeSQkEYuBVrSvrJe2JzLJpebD+Y1?=
 =?us-ascii?Q?ih7cXWFSwiG5NHcWZe1RezMoTmWuhNGN0u33D3YaXNA/+ceFz8dmR+6a6OnK?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2475074f-d3e7-4674-c5ad-08dc5ddae90f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:03:17.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BrgY4rIkHOaJsgTcPOzcRnJnOHpwpirMsdffJaAZVVRkINOkhQN5qECxuZ0yTa/yQHc/T2l+K9cEui7V0qlWtVURKOc/9usGwbaGAUVpzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> Config-fs provides support to hide individual attribute entries. Using
> this support, base the display of the SVSM related entries on the presence
> of an SVSM.
> 
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/coco/core.c        |  4 ++++
>  drivers/virt/coco/tsm.c     | 14 ++++++++++----
>  include/linux/cc_platform.h |  8 ++++++++
>  3 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index d07be9d05cd0..efa0f648f754 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -12,6 +12,7 @@
>  
>  #include <asm/coco.h>
>  #include <asm/processor.h>
> +#include <asm/sev.h>
>  
>  enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
>  u64 cc_mask __ro_after_init;
> @@ -78,6 +79,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>  	case CC_ATTR_GUEST_STATE_ENCRYPT:
>  		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>  
> +	case CC_ATTR_GUEST_SVSM_PRESENT:
> +		return snp_get_vmpl();
> +
>  	/*
>  	 * With SEV, the rep string I/O instructions need to be unrolled
>  	 * but SEV-ES supports them through the #VC handler.
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index 46f230bf13ac..d30471874e87 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -64,6 +64,12 @@ static struct tsm_report_state *to_state(struct tsm_report *report)
>  	return container_of(report, struct tsm_report_state, report);
>  }
>  
> +static bool provider_visibility(const struct config_item *item,
> +				const struct configfs_attribute *attr)
> +{
> +	return cc_platform_has(CC_ATTR_GUEST_SVSM_PRESENT);
> +}

I expect this needs to be a callback into the provider ops because one
of the other use cases for this visibility check is to get rid of the
"extra" attributes and handle that visibility with the same mechanism.

