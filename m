Return-Path: <linux-kernel+bounces-130950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1878980FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B10D1C2147F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F6343ACE;
	Thu,  4 Apr 2024 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1S9hF64"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95582233A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 05:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712208255; cv=fail; b=YphT5itmWpTZ2c8elr9Tnaki286I2PSHBwWZjoI1lfmuFh/E77kj/d1PRE6D3PhaTWALVDjlwzZEtNxYS1b6PEgowlgfjSdAHQu4QFypHCyL27rWluLlR/VfqgsYWS1i5nYd22Cy5JZvXHH+T1KM7fp9K88PuuQdOoDi2G2OYXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712208255; c=relaxed/simple;
	bh=EePZQPVFAn7aL5N1wkRnMrRLPjtkF/KL8LOyv/k7Omo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZfpN0q7XIODFrbkzUWaCr9W9oSK65xsjCUn72J96YuzncusXkRRwJJ7Qjh6uWsV7WpjHdtq29zJkVT1mi8hXb7517e/LLqEjXkSnMJP8y+DPHjjqkcylBsoiZWI6IcHwXOmbyXxo8Awj5+3hYBs3AAgpYed3sNuA+OD8xo4R+E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1S9hF64; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712208253; x=1743744253;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EePZQPVFAn7aL5N1wkRnMrRLPjtkF/KL8LOyv/k7Omo=;
  b=B1S9hF64vRUhFQmlqGbrUCSS/uR/ZUHgHeV8zx9uiZQVcuxA6fLe5QlG
   EuFacg8sH+sxZgbypuNsXTdXrFNKf2atRXVM0fB2L5qFv2YRmZjwTcMg4
   GUikYq08gvYqGiU1QnZDvk1X0LauMZA+voXN1xnH4ZZVapg2KQgp9SgD7
   tm1F+kxxg9ttzw3XH8ckzNxYXbj378H5X6sndrl1w9N2qd7484Y/Ys1W+
   6VOFxPkhUshAqNt/i5WIW/r3EpOj65rCy7rEuN3sXNkgDxNVEn7uonlDP
   yIgJCngfHFYx8Wj1NdYLCYpfhuAC6jfx7dA+V21cRckb38YZXUu454kcS
   A==;
X-CSE-ConnectionGUID: Lm6ULsW4SOu3ulM74gn8Wg==
X-CSE-MsgGUID: 7Dwk3JzXSdCqTuO6FWEmpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7373425"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7373425"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 22:24:12 -0700
X-CSE-ConnectionGUID: uoJBUIg8Tyuv9S/wlxvAew==
X-CSE-MsgGUID: 4XJnfcrVSl6KwMC/N8pQnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="23320641"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 22:24:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 22:24:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 22:24:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 22:24:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 22:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDpwt0IrtcNsSPlOvIIECFn7giEUVGm5I5WrwHl1VKAoVhxYF2kBsyHkN5Ohwzu/5r+0QR/f9KXncDBnudFwTAtX/2nsg4tUPnFzaZ3uJdncSAWf1b3fLpR9+k629HTcHRYPG3rfs13WGqNXv6CWXwRv9FkzWngTQ7Z8QZ268vXBz4+Weku4l+EfrGb/RDxs1tPdU7HXuYdecRfacOwgWvN0fGfzUqRsTeQ/c/0KKGvum75J8vfvGT0o6vuxJbd19/i4MWKxyoqI/5yDTp6WfXPEJu9ki8/qyanHH1mrhpMFcvRRJKpEddBYHjBxxtHRBhKlZNCXCXH3E3sSQRbN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6LgF91DsOJU6vChy3LbtPo0o2K3BAKqXItyl5BqlXg=;
 b=SiVGttrbSDcwezeOCRuw/gU2IwDKBv9vn0A/YULbM7kDn1Wcnru2oNa4brYlD8LYJ87HedJQER3k5RgWRPJ/IgkBQcx+EmCWdCX77Q0jzZjteY8pBkhRAsnozKcb3lmGDeB2frP0N575BCXgU1WmD0POJbjqmwHX8CsUEt0nd9Ilu+txv349CiIiHney3JKA4TyEUwwN+08Ms/sjQFtZPvQSULcjPlbbcrurVWGTtP/Q69vihEB6LqaZX8kpi5h5AXCgUyOXHVxN0Zc082ENnvLIYig4vrJ/tq0nyZLCQ4+mwSWamwChip4ndK8+8kab6jSzB+JFQSxHRsIZtWktQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 4 Apr
 2024 05:24:09 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%5]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 05:24:08 +0000
Date: Thu, 4 Apr 2024 13:08:56 +0800
From: Feng Tang <feng.tang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Zhengxu Chen
	<zhxchen17@meta.com>, Danielle Costantino <dcostantino@meta.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Waiman Long
	<longman@redhat.com>, John Stultz <jstultz@google.com>, Boqun Feng
	<boqun.feng@gmail.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH RFC v2 tsc] Check for sockets instead of CPUs to make
 code match comment
Message-ID: <Zg416EXHJa9CdI9L@feng-clx.sh.intel.com>
References: <62a0a0cd-3103-4e8f-b4c8-a91f12121e92@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62a0a0cd-3103-4e8f-b4c8-a91f12121e92@paulmck-laptop>
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB7303:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtPE5Ueu8X8zdlFU9RBIZuipvQxUJssEgArQptu9abKQ9HVTVmorOEIEGe+fAa9jXx18e2TpIxfgQMahn3ktFkOdPIEHnvDztmKysUcRZol8hZlsGwjaxeEUOsvU69o5zEfPdsokdj0ycp8kIJ3htaOFrsjRSLMfiGQ0n0pluNAUBDbzrFUCybZXXjfh7LPMj7prUvJqlRrlJnwdz6MMPXm5X2JPD6WMYGIqTM8E/3SO5I+Nx7Nwfv1+o8flRhKTlAes2+ddSfDspVUyk0X1YDycP4MabCMJxYRfXBwwU2/pTOeJW5mx8ok1LP2TLseehIrWTXlBXHAb36TpBu+lAvJ8hWf198GjcWGgZYhiEuKobJZhVEIQcD1wFcnj4H0rrNspVPgh4O424YVLv86Mi6tx/yxwfrjgwlC4hE5yOul8+fXahf8N33Mt75IiMNVkZRqjW2dsoToQN9e7O6jEoTpXokBlWBfHoBeMUWxUrAJmgponkzuwocpTLbGsoOWR470O7IKgUt/S7S5GbzzOlkYQrlCTJecBIW63yhoCH6RtLb1h7xkkPghKlYGDV5Z86nN/NRZMgT2yzgKNm2k94TZcsS//xaRbLAq3vdWIyxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJ8tEOqlgfrDzPZbftJnz498Rzd76Okud+h+/v7ZspESa7YLAFyUrOKR09kS?=
 =?us-ascii?Q?7jFm6b9VNY8xgTYvRV8M93GY/3pchNywj+oeCtcd4w5nVhyPrPfzMuUdlCG8?=
 =?us-ascii?Q?vu9GD6+vNK7wOsu16uF42EsMIBahqgtChMUgdi9BA8R8ERU1WGQocbzIFSri?=
 =?us-ascii?Q?3Q57nIpRa5DBpxygvx4vf4xqZ09nh1yck8vZuVC8FtzA7VbSlUzzvXm2sFu9?=
 =?us-ascii?Q?ZGXv1U48Eo/ZBNenmq3HKrry70zyWXbzHPlFd02SAIkcyzxLgzhHHU79s0/A?=
 =?us-ascii?Q?nJBnssgCdkGVTcdmNG+cVLTtGwD6eFwDw9qkYUR48vVxpVQpBO9CEjebkA3M?=
 =?us-ascii?Q?lkHaNyMxaL7gyXmXfpFzlsdDCAJ6ycQCPIJzfbgXb2+TBLClw3IEpeNa4FB5?=
 =?us-ascii?Q?9S/t17Tt2Hd7H2yJs3v7crlAQh0x520cjyEEfUyTGcjMuMZd7ZbPoDlhh+yi?=
 =?us-ascii?Q?ac+dp+oHMmxWfXd5a7KZc25e94cNaCYKnOsAIGMbKg1LBuCADG1WSwcosqFd?=
 =?us-ascii?Q?Zt/dfCQ78TSQgCh73d3xz2DmOXTt2up+5bNcMdj5bQIFvXXI/BMVYIpjgVSX?=
 =?us-ascii?Q?lzQy1L2lWZRBKXDuS3EWekmJkmEcZGP+hCV6yVKO2qgL4/8zpN+/DGt5MHV2?=
 =?us-ascii?Q?BfiNL68ieqoSEwN4cSOmjFe2QU+G7p3VY/TLO1hPZ+L5iFtTY6SlHHlVxo5S?=
 =?us-ascii?Q?V3xTeFHoWSAL5XxAzk1JSMlg/SAarfAly8hTzqwuqGuCr3MiH7u8vnwJ9Tge?=
 =?us-ascii?Q?N6f2byX4HP7QKRmPid79Q1TU45mr75xweuaRYPekiDME1wcVwmdlCqml+x9M?=
 =?us-ascii?Q?oYpdmJhYldB/kXMqyyePn3hvRSXakp0M2ljUZAT1IK7kSG4TfSUYJpeU/i6e?=
 =?us-ascii?Q?gDWMF6/YPwCBNp/YWK6dKmdzam3+xlwuiW4VoGCzJXe9G2deueQkRKhMPJDN?=
 =?us-ascii?Q?puU1zu9drEWw5JEww0G4oAlOm+jmYf5+4/K+amiFOV3iPW2vaPah3ALwzoL7?=
 =?us-ascii?Q?Qkq4HuNe3O/n9BOP2u2rnV8VgPciHOnmOhGFSdLNRGKNA5MLpqz7Z3cDdKII?=
 =?us-ascii?Q?MXX/6I/O5tGcvQJw56WmZoAEWCnBVMh816Tyox6LGGPR2AF8KWrSUnZCdtVO?=
 =?us-ascii?Q?9sZs2OoUpw3lPmSlWT4JLXLafOuRVFv+2trGiux1UzgMlAKtv+CoyYe1ulx/?=
 =?us-ascii?Q?M/eAR37JlcTBw+HI7ESE5VU3rbdMm74HfZhCl3HharS6AkInzNBEYsERw7W1?=
 =?us-ascii?Q?+Uf1gJAEIzbSv7nLt7OMOoDEra3+2KnAuAkO1h1UXxf4v4B2/tx81NCcNwZJ?=
 =?us-ascii?Q?YcoPq6th1fGBKuPzRtV7O6w5y7V93nxBgydGlR/rbo5irenk224t+3uq/IfC?=
 =?us-ascii?Q?lNdNZdhRfWa6BjMKU7pu6ioQwZ7XfeFBRla79zpOKu5sSS0+5PknhaRGm3ld?=
 =?us-ascii?Q?EpGrEIvkcp/wizhpRmjRpWovIMql9VGJyYBpJhGvKeWPEuIpL9ap2jJVqLuz?=
 =?us-ascii?Q?2NYZ7C5AVaLkdxD/CLWaqAPT8iKuF/3E88OagBCCA8Mpd9BnY8I1cQcsh4yZ?=
 =?us-ascii?Q?EMKEONT5OsC80dH/s0kKvVrz83QOt7IxNXAezFp8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a58eacd-a46a-40c6-6b38-08dc54677429
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 05:24:08.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAR6fMpT6V3s6yI0aQH+KeRsJFXEYlIykrVmRs6EIyKrUDCoHiuB5lKPEIYpdG7OgzDeIOFuMyYGwLadDLDldA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com

On Wed, Apr 03, 2024 at 12:10:41PM -0700, Paul E. McKenney wrote:
> The unsynchronized_tsc() eventually checks num_possible_cpus(), and
> if the system is non-Intel and the number of possible CPUs is greater
> than one, assumes that TSCs are unsynchronized.  This despite the
> comment saying "assume multi socket systems are not synchronized",
> that is, socket rather than CPU.  This behavior was preserved by
> commit 8fbbc4b45ce3 ("x86: merge tsc_init and clocksource code") and
> by the previous relevant commit 7e69f2b1ead2 ("clocksource: Remove the
> update callback").
> 
> The clocksource drivers were added by commit 5d0cf410e94b ("Time: i386
> Clocksource Drivers") back in 2006, and the comment still said "socket"
> rather than "CPU".
> 
> Therefore, bravely (and perhaps foolishly) make the code match the
> comment.
> 
> Note that it is possible to bypass both code and comment by booting
> with tsc=reliable, but this also disables the clocksource watchdog,
> which is undesirable when trust in the TSC is strictly limited.
> 
> Changes since v1:
> 
> o	Forward-port to v6.9-rc1.
> 
> Reported-by: Zhengxu Chen <zhxchen17@meta.com>
> Reported-by: Danielle Costantino <dcostantino@meta.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Cc: <x86@kernel.org>
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 5a69a49acc963..e938b990bea19 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1289,7 +1289,7 @@ int unsynchronized_tsc(void)
>  	 */
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
>  		/* assume multi socket systems are not synchronized: */
> -		if (num_possible_cpus() > 1)
> +		if (nr_online_nodes > 1)

Regarding package/socket number, Thomas' topology refactoring patchset
(merged in 6.9-rc1) makes topology_max_packages() more accurate than
nr_online_nodes(), more details in https://lore.kernel.org/lkml/20240327025105.2861341-1-feng.tang@intel.com/

Thanks,
Feng

