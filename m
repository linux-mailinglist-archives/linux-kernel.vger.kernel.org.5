Return-Path: <linux-kernel+bounces-146287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 899D98A6337
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE96283334
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB013B7A8;
	Tue, 16 Apr 2024 05:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0NziSDQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E73A1BF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246480; cv=fail; b=bwJvbKlbYSg6ckNSw/jIBw1mwHTGwLmoSrI3T508TfVdXM3HH85iaKJprOHTfUX1IX+tDAmvZPBREhJiEypthMRkZTvUdJLK2uI2h9yQZYETR6ogcONAfnKfSXrU0w+KY4Y2a8XxSb+QDv0b2wtOm4GekW9uRohHkc+PV+tf9B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246480; c=relaxed/simple;
	bh=tUTRSyxKYM7em+7cZ0j8poHb+i0bTHAKNPIBGGia9+o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M1QV9NIF70puTTUlBZR1SV72qJ4ACWFKw4iuh6K9P5EthaAd4XauwddhGRP3vwyFbnLYgy9bSEJnFut9vuxJYVW74l288oEN31hS7IJNKliyyeJL0JJOv5l2BYywGyyYtXJJcGOeGFKKx84f+dirEp7resXUthFRn/szocpvw/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0NziSDQ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713246478; x=1744782478;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tUTRSyxKYM7em+7cZ0j8poHb+i0bTHAKNPIBGGia9+o=;
  b=H0NziSDQes5HKGc2KJoQ4UMvJ1TpcZGRB6hYi2MOSabOMl+E7a0n1UKO
   ogLRo2ZVhaSVM6yfD5WMq4L9rZpP0QfRpwyZb1opNilz7RCRAMILmowjv
   KNZC4yfHEuTYf82MPI4p9V1egXRmnNhHNdybHk/k9jiCZMfJaRYBC2Cju
   Y2b0BCx562Xn1LJja0h+vz9XBWt3SyX+Fz8YgGgYKbwfICGO2tTQfzFze
   I3c54xXCWBKQW4/LEucBvND6qZfxJ56j5OfrEEgGTq93/RmevpVPGP0BA
   GDplJPnQbSNfKDtdatBEwUuLdk2Nl2n02groCeKVVT9uR9/7PUN+OIgdk
   Q==;
X-CSE-ConnectionGUID: jATy3zPjTDSRfpprO+HgWw==
X-CSE-MsgGUID: jg6IYmAqQBKpnF5Nst2AiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8584131"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8584131"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:47:58 -0700
X-CSE-ConnectionGUID: FQxcGQ6xRFORsZalsNpKoA==
X-CSE-MsgGUID: td3t6l0/TjSqwF1r/1fTOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22223296"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 22:47:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 22:47:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 22:47:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 22:47:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 22:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvAKANVs6zR73+SS17iFpzN0dXdwrTfyTorT8xL6MUoLuUXiFrh/GXrFuOrtYuXwv3Uyg/IBuHbSs4HJeBySOD7L5jkN4W/1QyARuoaikLNxw5vRv8RMU5xLILfyZ84grG6KesZp1YKPdMr+nWJTNvfqLjmPZ4PPaSTWv6631kWpfB40WY+LD1Ti7PE8yvtpCEWWdQJQX/p1vbGKZHdgYhAVYraCMt5B07xjSZMgsOnQrxtCQ2uL2fEGoRngB0XGmpVkXNdid8X6fb6jsTxrgc0C81SDxC9YNCOLYVgiK4VYcTRTgoVu7RS5BTKlzAvZzBe3H89gCDhwzh7f244F/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TruajbSghbJIBrwh0mHpj3/gl0v8MEhfG1lvzrRWFRE=;
 b=P6EfqzPfIrlI5LVZycY4+sjv8vAubBrvEUMEPBnxNXaPCql5+w/ItRvJnm7oIxqtCqgJ8OEKhyPaD4FfZesAUcqeXE5TvFLSXFVuCmB2T1JILbddpdoPoNbWJ22AvN+O0OFyvRb5k4Hf1c7rqz8tsE/wYU7mWrRELPWWlyXRTw1lDXeCQXfeyBXMnzRpQ6UnoG+1VqQzCFHIE970BodhiCvn9th+Y2HKANPLf7fHQUtA/kzIhnEUm6YcjwBR/WX9O8FQtZsezNlusBtrThSrNoN7GhlyB5q75rNWXKu1V+oBAz6ePcSDTPS8GAYkpMYskuDLfs9WbdmkCvLN83PHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Tue, 16 Apr
 2024 05:47:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 05:47:53 +0000
Date: Mon, 15 Apr 2024 22:47:47 -0700
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
Message-ID: <661e110326bd2_4d5612949a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: BN9PR03CA0792.namprd03.prod.outlook.com
 (2603:10b6:408:13f::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: d67f88df-645f-4483-0159-08dc5dd8c202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ePQXI7PktzVKJoDIrDWnWlOZSzu4vdf6E4BuhxKEFPBiLm/T0kJssjKKyedgC7G1fhyP2Pge+3qG18nnWXIg4WQ8DWZeduTElIsJlNc7n0zDZrvCqIxDF0TQ8ADGp+RM9eQj19ZOwLgEU17hLNdlBeSWeD04PfPary4FTBbccyMXmr5YNWPK2/nDf6NYVJarCyRByRrlc6DeM1L8h2w0lEaizF8kT0h3WNyDJ3fzmJlDCD9Z8Rth1io2XfJazWfS6Btb4TnobSqDKgNjmoaiax/zEOSdmJC9jbKBG9o2m+h69Pr+ou5GXh9hrxdCPGupPnG7Lx2jd6eZgLz4EfiZoY8yuDHQE6RJYWtaSe5lSqAvzRV4Pycnuoqd+a1/pAIOdIpAqaL1rf4nZpS83febjBsuWvlKJeamLXYmU6++w404OWY/pDPm0zg4pOxq5W/pkLhVV8VtyrJznTgaQRDpUW6CPqFgVMCqWx+EQIagyYYdlZfXfbxKDrBElvZx0Hwpd3sE2j3QNk9ngeRhVi7MfBuFzBqi5Cb/jEX+QdfwBf5yV+hBOI8xvRI9A1S7vCshgACyWkcMsCjizZGCd+IYGyNs9+4ZbJZcKYRDXYHfgyOop468QQ+ieclRCieR0ECbwJS7d4j4buzexvlVdKfYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/2OmrA8wKpgTHK7QfRVVMjbw3/1sPSBEKWyPx8ok0vZ+BdJML3BZum6QSgnp?=
 =?us-ascii?Q?v2zEoSzUwKQPAUy/hv6dQwtv1U/PTf0E6BuMoOCiE3raltSkFumR/gK0THzB?=
 =?us-ascii?Q?FWVvuPiEaIxQRW0E8qcRdEu/JGDLfeR/J3PmnAszc/3Yhm3VyrnFFq6QSbii?=
 =?us-ascii?Q?c6O8BbCnI1TEyCIitmeWOc3RQ5r+i8sOzoZzeZl8S7oldPhYulJOBAeOXK5V?=
 =?us-ascii?Q?CLMMrnCzMpVJ02NC8FG0HmBRTFtxnaFiS1PRKxO2nXw2TqcPe2cQ/hafta30?=
 =?us-ascii?Q?O4uOy98qT6waDNz9+yat+2DsCno9YnK5F2mylr4NyH+6oEgpNSLBLkUlyzKy?=
 =?us-ascii?Q?4nDATIiftKF/dZortQYEir7NMHJd7hnzKrEdRypX52td2vCiTnX9EaVzS2l4?=
 =?us-ascii?Q?fREdjKGQXt7/sgElLYNu69+DK81mW9DiavfGQM/2lpA8chRwvNQD8PZyS137?=
 =?us-ascii?Q?ejpMHrfyYXwHJ3tNIotLoivgbnRVdp5pqeIqJZbGhckEThq8f8mmkPE+wxt5?=
 =?us-ascii?Q?S4UQlQivX2x+HTKDyDNmG5/XL4cq/lJ1epgBJyI72SNO8GdIG6jcQKaIueC/?=
 =?us-ascii?Q?P86nNFIfTHiWqpqiGGOncGkx17hcXuWFuzzz4UdBE2SQGu60I9QpC/ZjBHG7?=
 =?us-ascii?Q?iRPHhIa3HbtZw33hXFp4pPlkDaPZhCUaaV8Ut9Ik2cw17pYFXrKPvog2MPvz?=
 =?us-ascii?Q?rztzG0HGRmJTQVpymSmDvytOdKGJOsZv0tiVG3FeXNf4OAiihvJUJISoLBHy?=
 =?us-ascii?Q?ZQD0f02uljr12IsG4xfdy+hhxZcoyeU6P9DTrAFQvzgqotV9fgjYxXQFL9GF?=
 =?us-ascii?Q?CX4LbxGHD8TesIQuhbaB1tsvKmButjPmKSHsyrbzIq/lhNNnvfAuv6487adg?=
 =?us-ascii?Q?rFswIUsy3rApOupjFUsHz6gPlEyIkbcKHj0CbXL02ExysTX4eoYJcr/RTACk?=
 =?us-ascii?Q?FJB9H7t/jpxN41ddu2I2P+Wkp9g9HIqbQgrmcDWpFeJIAxj8P/9t+UjhCLpA?=
 =?us-ascii?Q?68CE1ezZU2tuWhLbDrYB1qDM/2qUY81+CDHU142Ss6EoWUg0cmh3qQyNs0iD?=
 =?us-ascii?Q?gADDj3dw3+syQZS97FXPfyjObuuGIA4qSQWIZpQefugQ2iZ3aKE+JTEuTr9X?=
 =?us-ascii?Q?ntUEVdG74wzKNo3OAgkJy4uE0jIlNVeWmPM16rMGjVPTGRdrRSd8PY9WdPl4?=
 =?us-ascii?Q?VSZ39fyBAjRA6LEmnrlqSKuqUfLtS8o2qz8B4xdtur6lrlslbJstSJTi2viJ?=
 =?us-ascii?Q?0wF1ZPIA1yZDWAUcJRle4mXHEPHDuMG4853awCMo7PsdAr2H95Jki5n5Tu9V?=
 =?us-ascii?Q?kCOGLAxTXZ7xY/d2poUW/k75YGScKkwVOFsryLEkeKOSYEcFnjtwqY/fArOh?=
 =?us-ascii?Q?rfJkr8kVby5ahTUaeroDPPHaNKpOHhDNrRX6DxY04YUeGbzTHYjw5EYZweXC?=
 =?us-ascii?Q?Uc/ssIPz69BCXskuiCPl098WcOKS7XhKvfVZnAlFFKKp3o9UPnxJYwpjDpGJ?=
 =?us-ascii?Q?Yy3MsAb4ZjNIM8VqvQV3Hpvu9X8S//q+FVc1/rZIrxzauh2MSAbVegUE66za?=
 =?us-ascii?Q?ZCE4pdu344tm0H6HbtseLWpIXvNnbJPmaXhobsRtA+JW69QNFMJpVhZexakv?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d67f88df-645f-4483-0159-08dc5dd8c202
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 05:47:52.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zai/OhcCnysKvadDQjz+O5fbN8cCqr1pKRjYhQObgFXHMpOIj8L5jetwvtuYnh0CK56c3U9JsOskcnHxUGazDkjuqHf+YVwL324MroGSpjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5322
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
> +
>  static int try_advance_write_generation(struct tsm_report *report)
>  {
>  	struct tsm_report_state *state = to_state(report);
> @@ -144,7 +150,7 @@ static ssize_t tsm_report_service_provider_store(struct config_item *cfg,
>  
>  	return len;
>  }
> -CONFIGFS_ATTR_WO(tsm_report_, service_provider);
> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_provider, provider_visibility);
>  
>  static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>  					     const char *buf, size_t len)
> @@ -165,7 +171,7 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>  
>  	return len;
>  }
> -CONFIGFS_ATTR_WO(tsm_report_, service_guid);
> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_guid, provider_visibility);
>  
>  static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
>  							 const char *buf, size_t len)
> @@ -186,7 +192,7 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
>  
>  	return len;
>  }
> -CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_manifest_version, provider_visibility);
>  
>  static ssize_t tsm_report_inblob_write(struct config_item *cfg,
>  				       const void *buf, size_t count)
> @@ -333,7 +339,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
>  
>  	return tsm_report_read(report, buf, count, TSM_MANIFEST);
>  }
> -CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
> +CONFIGFS_BIN_ATTR_VISIBLE_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX, provider_visibility);

Yeah the same callback specified multiple times feels like something
that should only happen once at the group level.

