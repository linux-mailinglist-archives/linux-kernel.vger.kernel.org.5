Return-Path: <linux-kernel+bounces-146315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962CD8A636E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C75A1F21FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF2E3BBF5;
	Tue, 16 Apr 2024 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TB1US/iV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A933998
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247537; cv=fail; b=gE6S4Kf6qLOITL2EE7FStNmkBTKm/tCsmX+ibLmihw2kAMROqPqHis8qD3UHqTXV1iyKJlQJDe/eZyHTkxIENFwDUn5Zp/LxXeqgkpsxKgsRSAHTJ3RqonbV91QnkgkT+9hYs/SuK/qDQQFPiK26X+yMo8D8CX/ZTzD1N24m0tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247537; c=relaxed/simple;
	bh=z7BeCgqNwItHEh+VWcJoDfPbJSfS3PBNu/ZQaTkEvGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VIeu83XiDpQXeZwDbmJvXqy4SN07/KUYG9bUfx055d8ITKCL/1uY9mt5cX0UAhdTZmJo7lGSczbr8PMVgMWtaNAW6nDoPrC9YduLnavsNrGejiMPorUVEixHJO0K43u6hCulkyaNQcw55MoDh74yvIYzORk25wQnncg9HC6to9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TB1US/iV; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713247536; x=1744783536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z7BeCgqNwItHEh+VWcJoDfPbJSfS3PBNu/ZQaTkEvGo=;
  b=TB1US/iVmVg1bn5A4CWJ1IkUYqvdbRApdfdWVRLKziWGnifQWMw9IxbS
   dTmMfMKL8cact+iGtiP/RlY/E1KRtP5nJZCGbYWNJJW7yb3FuBRBIOjX1
   7B3jRje+xw72hvnO9GZbWlOZcL+/Bri8Xmv+X9q1X+3HF5VI0pfRiq4UA
   0mzZfk4J9UwxrlLwPp7wUnGVNUGxeGN8+ZAJrVSWit3rRxXvwg0jjJClD
   4xkbWaktMcEaPKIomvmOIxTcwQgL426fJwP+nzaqu0D2XKTzuAZw/WN1F
   BULJCZQL44s9E/Lk1EXNOWvK3hBaTAYxktyACqDxpo5/dqi2/PfGzd/h9
   Q==;
X-CSE-ConnectionGUID: S4+oLdLnTQyXymE3ZzihGA==
X-CSE-MsgGUID: D31yoRIiTASEZWTnn+qS+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8545767"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8545767"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:05:35 -0700
X-CSE-ConnectionGUID: BEazFD0MQU+W9vDxWxlSUQ==
X-CSE-MsgGUID: KOfLgmjeQKq83BMtfbUfaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26806784"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 23:05:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:05:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 23:05:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 23:05:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMYtITZvZPUYhRMR+f0hsh1KwYRPjQurvWPU1zO9dj491d9tJw91qWtJcUzFytSPANIjwwtYOkxiMxM2rt3uzYGEFBJduu4HvMkfi9/4lep3F786v0HgXeYTCSPOJDouPyzpvrHl7k+a2DyPzQLI8DI53G83SLef6Z+G1W9IwVxKIE0m4W8Bg/62E2bWgGIwoEEOWcE/gI5VTrOMiLiQvnX/7g+CHLBBxW8DuGJkz4hqTSalPRh6LCmiP0sQBGiybknrD41Inozc7vcAflQDfqMJWSbKf0jDpqDWa65N3ItDuLqgS0iGCd3q8FIn/OqbFntYyGWHsYDFjYgf8H4DBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2Kqp7AAO/+3T03+7NcRrxzngrbG+g26MsZktvHyD/I=;
 b=N4YDkXuZzdFBbRbvgLxkEOlCQJzEAQ1eEn8bsrlrhQIm0v16erH0cn9MIL+z+ck+8e7N8wDGg/dtRa+VA2HTNegYuKKrdHetMCOD5KHVRvfDvbod3vY/z2MRRyWLZ5yQcTOe37OTcrCx3PRi8vP4Yd9UzH0S+ilvtN/oZt6OY3t/r1SbbQrg0fFWXfPkyhZRn20i+k5gPxAP1MGPFEl7UFpabKVmKSWyc8YLunHQzQqP/6qChem3V9dwEJKk+nt5jqXCNI51buLWWx7lBHM4xzdABcFP8km1H5fBR79GCZiSe79QccFBwzqX8Hzo/ILK2EzaNiTCHmIhmpVaJvN+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Tue, 16 Apr
 2024 06:05:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 06:05:32 +0000
Date: Mon, 15 Apr 2024 23:05:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
Message-ID: <661e15292be3_4d561294d6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
 <1f6f4477-0f2a-434a-8c89-3b5d51d61581@linux.intel.com>
 <19d69960-e548-a2e6-87d9-c463f2851613@amd.com>
 <e286883d-40ef-d749-26a8-7ec6fbd81eae@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e286883d-40ef-d749-26a8-7ec6fbd81eae@amd.com>
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: c45fab62-0804-4954-e1f1-08dc5ddb3938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Wt+0wT0NDTn8XmLuv5uMp/vO46/MFlXxhu6HlSRF7pCxnaWdfgO3a2F3Ja5Z/Lh9rPNAXZ0PIp8n+/9y/2OwglddXaTUMULl7mMaGYuXCz997Asrg2zI0G0YMtEJftNXxLxpEN55m0dMclvBP4bUSbxpkBZhDyAQNe5lCpXWPlEjBcH0/DoDqiiWlttym5pTD1SpmZEZ4xIRoPajx0DhZHCHDBVpcN6ltr5qQCOKSAuazHB5ZTnLeyPPIF4cBakhNspqFuKvbRoU5G6v+QPhYwGr3XYCd8QAUaHYjillNII6yFBCp8vyd0GFiycslXsSvZvh3Usbxut26HgDr9vb1Ob/HtFgDB/PS/ZJFuDkoL2NFaw2S1azRERwiBEblM0mhaGzAdcMa2peblKGXNJIdtba938Jjxw9RuPjB3NdvyNz2NdC1LLHhIO2hkhs+oaVoEjAi0WiuU4mV7KWOITCDLFLpp56zh1YgwHSW9Xrk6FEmXy6LfULk3q29BrHM9+9MmjEXZJbJPJOdwSVkKlEXqsZVMEuVpK2oVzsiV1xiDPM2ZTDJBnKHnpQBoDiOrzMqxb6+pnq0hwYHxuLxT9qq05f84HeYAj5XpzTd4iWNHQQoSAmHzbM/EPB1jIY0vx56Tdg3y1YHC21nN36GZ6uiDrx87aObUbg03+35Zl5hA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ruSPQLLPY1V1oo1sSFEjw45ot2Z+a7vFZlkVZuM30rdKJNFJetjn3Bxkvb8K?=
 =?us-ascii?Q?+xfr2rDyL7L7iWcakM0rGRQQsdh9ZMRSgP1TvbJ5Ho/oImvbmzM97+ohV5md?=
 =?us-ascii?Q?BPASrlOYBgtYhyY88gM8zLAJBn1fOSoKDNn4QJrY/j5BeiO56TAvRj05GWVc?=
 =?us-ascii?Q?y8wp9zMc87c2yFXtrAycABc05oj0KyACasOwt3HjHMXmzbUg4LP13FQbL0IU?=
 =?us-ascii?Q?YaSr4G9ONdURKcCLZJ9IYx73zj3ClHNvKwGf9GeC/iPgO+Hjg+BzCY4sMCit?=
 =?us-ascii?Q?rM51FMV42N9xXCbclLnhHIID/AZYmzpHGEvgI5yyBha47eRrSJfx5iy31t1b?=
 =?us-ascii?Q?ppM3kxM21MXKEvqSeOQ+fDRSegGaOqCjP+h4C368uAkxaJJVdXKulYzdkX/R?=
 =?us-ascii?Q?Eset9I57AMoGfe2MF1BoIMHv8aNWNUi6QPCouYpYRFd08DgJ6Y8w76Wb1H/Z?=
 =?us-ascii?Q?nIYcFIvH2t9m8lgDoW9XARaJsVSOUzRiVU7xpYtK8JzJvVabla/BCm5xj5yK?=
 =?us-ascii?Q?qGIbXW33OonjyBgGMeKIPPXwvek/gRoLL4xVXVBCWXybC8I+2FPoK8vVxdns?=
 =?us-ascii?Q?kfRZq0XgeA+1x2xGQYABjAek7+JUxA0hk140akvnkLpjP3dNd+4pe9V4SthF?=
 =?us-ascii?Q?8fCxmB9rIVDBQtAuRRM+JGLyKGJ8i1jLgQo8UiXj2jybOcCsG0cqkySAtE7Q?=
 =?us-ascii?Q?0Md/yNQQVtl9K7NWkvZ4pnJH9xoSllcVCXO2tdloRc1+T+fpXYs+PVbc3+pH?=
 =?us-ascii?Q?mHoPnjucFBt5ss0t0pA8reLgt9vJ2ahYtJu7EPTCptxsStVmvSHDZAe9sqUC?=
 =?us-ascii?Q?fpcLhimJBQHQfMhVPA5868pVez+gUNOtXLtDU7ipQHwUvur35OUAHSnPe8hu?=
 =?us-ascii?Q?TrF4apyKVhH76elv3+yvGmbLjJszcffKCF7tcUwhBYBXwXQ8w7xdwZOcbmmG?=
 =?us-ascii?Q?kN/3EdeyN9RziSHPctT1aJCEsaL3hyyrozwuojTwLnPQRnlMvYSZnogJGnaI?=
 =?us-ascii?Q?hK7kOzcOf8QlN0unIChao5XRBeNXRobUPD5HRZ1xoHEIaE853FPTM6tO8RkG?=
 =?us-ascii?Q?a5NGerPkHdG3Ez4i/TUj/nycoI9VwWBeeauoaMJmcNeKEOC19/NEi7LWo9hR?=
 =?us-ascii?Q?3KN0hKPxmJ15bUGQu6b3OhqzrshNED1rNzsunfaYM6A4ua2NINSrflPIN2ml?=
 =?us-ascii?Q?aJEw6Z3RoXZD57zwuUOIM3W0eHLAKw+ll8bM1A0GaZQAgA9Qc23LG1DNoukJ?=
 =?us-ascii?Q?DqgfxyW6XXQJlq4Zl+78jyADVefGss/GiWqDF6mn42k6D30hCBUIzwtmgDhT?=
 =?us-ascii?Q?VXsbUczukQ28pTb7Rd3B/f/YOpvyVsrYJbkZ4qMvKx+HnVsU0yKo5RTboiyk?=
 =?us-ascii?Q?0LtXyXqF1r/UUUqXBe3KnvxNI93d51kAWt/Lrs9jcMDIpJyBkxNSY7Hqmg3v?=
 =?us-ascii?Q?lDLakC1BorlEMtX/ype1BQuy/2Q3wn0Qa9F0ibPqoJ9BVdJLuxubteRTdZ0N?=
 =?us-ascii?Q?8cho0d88S99Sy7JZLPhxvN6aMZPcAAGdxzOdw+Xo2CYMHQ0xUUP+sZ9zNbWH?=
 =?us-ascii?Q?g8FT1k5hFORtOww2dsoV8KHUMprrdO0Xshhz5WfOJDbGDEdlh9QLl9+6TZAw?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c45fab62-0804-4954-e1f1-08dc5ddb3938
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:05:32.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knAF3hXh1FRfFpRxZffRerOcsJy2xJvbEg1aOcik4OcNgmlr16j2G6boL+5HjtDs5pQrfF175eaCUlCwwXYC8i7wY9wW1gkoCmHG9K6RcaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 4/12/24 10:52, Tom Lendacky wrote:
> > On 4/9/24 13:12, Kuppuswamy Sathyanarayanan wrote:
> >> On 3/25/24 3:26 PM, Tom Lendacky wrote:
> >>> Config-fs provides support to hide individual attribute entries. Using
> >>> this support, base the display of the SVSM related entries on the 
> >>> presence
> >>> of an SVSM.
> >>>
> >>> Cc: Joel Becker <jlbec@evilplan.org>
> >>> Cc: Christoph Hellwig <hch@lst.de>
> >>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>> ---
> >>>   arch/x86/coco/core.c        |  4 ++++
> >>>   drivers/virt/coco/tsm.c     | 14 ++++++++++----
> >>>   include/linux/cc_platform.h |  8 ++++++++
> >>>   3 files changed, 22 insertions(+), 4 deletions(-)
> >>>
> 
> >>
> >> Any comment about the following query? I think introducing a CC flag 
> >> for this use
> >> case is over kill.
> >>
> >> https://lore.kernel.org/lkml/6b90b223-46e0-4e6d-a17c-5caf72e3c949@linux.intel.com/
> > 
> > If you don't think TDX will be able to make use of the SVSM attribute I 
> > can look at adding a callback. But I was waiting to see if anyone else 
> > had comments, for or against, before re-doing it all.
> > 
> 
> What about something like this (applied on top of patch 13):
> 
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index efa0f648f754..d07be9d05cd0 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -12,7 +12,6 @@
>   
>   #include <asm/coco.h>
>   #include <asm/processor.h>
> -#include <asm/sev.h>
>   
>   enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
>   u64 cc_mask __ro_after_init;
> @@ -79,9 +78,6 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>   	case CC_ATTR_GUEST_STATE_ENCRYPT:
>   		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>   
> -	case CC_ATTR_GUEST_SVSM_PRESENT:
> -		return snp_get_vmpl();
> -
>   	/*
>   	 * With SEV, the rep string I/O instructions need to be unrolled
>   	 * but SEV-ES supports them through the #VC handler.
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 0d2c9926a97c..68c881a50026 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -1036,6 +1036,17 @@ static int sev_report_new(struct tsm_report *report, void *data)
>   	return 0;
>   }
>   
> +static bool sev_tsm_visibility(enum tsm_type type)
> +{
> +	/* Check for SVSM-related attributes */
> +	switch (type) {
> +	case TSM_TYPE_SERVICE_PROVIDER:
> +		return snp_get_vmpl();
> +	default:
> +		return false;
> +	}
> +}
> +
>   static struct tsm_ops sev_tsm_ops = {
>   	.name = KBUILD_MODNAME,
>   	.report_new = sev_report_new,
> @@ -1126,7 +1137,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	/* Set the privlevel_floor attribute based on the current VMPL */
>   	sev_tsm_ops.privlevel_floor = snp_get_vmpl();
>   
> -	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
> +	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type,
> +			   sev_tsm_visibility);

I would have expected this in tsm_ops, but yes I think a callback lets
this fixup the ugly "extra" attributes situation as well.

