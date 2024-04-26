Return-Path: <linux-kernel+bounces-159478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7E08B2F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EEB1F2232D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A389978C66;
	Fri, 26 Apr 2024 03:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNdQ2Ilm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC89E570;
	Fri, 26 Apr 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102905; cv=fail; b=py+vOiYht6xW1Cfknqs2XYmabmWmBrWbSWAR6ziDxwLusKutV5AOIui65JJTpNH+b/p2t4f4FTZILr7P6IenEiOdYgCfnuqRHgZR3vpmH54aKL6EycDCrP9jaBaNsQAmT2T9YanTroU8QVxNkZbAQuqTZlvcFtEISZNf+Pw91eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102905; c=relaxed/simple;
	bh=wvHDScQA9E4OMQPle9MoIlPvob+qvDHiUHghLe3BYPs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ruA41rbNGt5HXvRpPQOT2Vz5ZDtJXf+2HLyBCvNHzMlu7KBurvBKNvLrHvUZSCZDBQUBxdWNV1mSKmqq1rcIz8lHlDpzfIvr7ILB7UOOg/ksrAtXLqjBpuMccEXnvg6ILH+Y9at4GgwzX3k82qje7mS2L1gHmSwFa8sSzIX9NT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNdQ2Ilm; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714102903; x=1745638903;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wvHDScQA9E4OMQPle9MoIlPvob+qvDHiUHghLe3BYPs=;
  b=XNdQ2Ilm3yRvH8TvQwct2IMy5JbfE95kI50bMgVebMBsna53wVvQqKV7
   tvpeI/Z6qNWX4EmWS6IS/ZuUjxY2h5PfYdUbcRbd14JZENi3Zi1HbyUwJ
   +1/MYnCHh8btiOUxqHe0SMpfwCP14TI+PPSOJbYm7FbVmMhgI91E5WrlQ
   lN1tUGZH7xzEaTk/VKZxnyHmZFpFhgbv1ojg2GUCr8y4jHBXB72Yxxg7p
   tAwYpz1AGt/EmYhxwxzmHh9vhzcO4glrqr4bixhPu/4I+v1mIAL/C/gNL
   yET+vRa9SyyE2wiPQUypkkAm46iVyBLLYuKBAzkxm/q+8FhcfEE6UvkOX
   w==;
X-CSE-ConnectionGUID: oQJRU7xcTL23jPxpPZCKew==
X-CSE-MsgGUID: 8k+PRuFIT4GrE3Ovadt+Pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13610120"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="13610120"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 20:41:43 -0700
X-CSE-ConnectionGUID: oP3lDPgTQZmAmQ4+WR8r1Q==
X-CSE-MsgGUID: rdaquhhPSNqLkR/XG4kiEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="25171091"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 20:41:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 20:41:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 20:41:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 20:41:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge6Dp+S9DG6QhJcvhEyIhEscedgDhj+tz8VoeshSlYVcDpakvSpoB5jhJiyCWL90bV/GJhnyu3RJsfh8PbpLOGNcVgqJwG9DmnUm+AsnPUNVjNuTUhoxu73C1T/iFnkL4fPOzYG7d595xPLx0eTgYPwPtCkYSGRqLrXUJ8my1kf4Xrksnm9FBvGh3RW7cHRT8u8t5+U/YIMdKm7AYfhzGydPql0CxIjambklmQHsU9jdVluLdij73wp2YZ1Z81nFUiOW4iuBefiaYfHof5L60HFAeqBt3Fj7kBVbIdVTCDL4q2vKg9vxXAq7cEbMrwt9ivZDcMFz5+bcW1YJ3IUSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBtgMXQTjQ+LQXaGpJlWroSDV0/ux79PNwxiJk1PwYY=;
 b=Ja5xiQj3tVfzK2YLR0X6iPuOpSPD2aT+KQe28wVYF58wO9woKDuEm134x8In14Zk7DI7s02CNwza6Rvqp83gSL3SZtBICSNmX5+u+05/9ejQVhsvUQsqJlWu1HaiAdModApAsnMT/QE7ZZDIqlavlG9VZ6Sg1xgdnhUE1rczhQ07afllNu3f0k46TMVsxwJ+OdVW5j3BjM+k7g2Q/qhrMp2o8Y10ozKpAZcBQs+6/Sz0no2Xh+FJ0zXK6HWPDym/KaZ8pKX2EmM1N1WNsc6KDJ36Sy0dVQjUI5pUbh4d8yS6KckBSHNwaQ205k9EkIcXCKMP9DNjn/pij0NeWHBJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ1PR11MB6298.namprd11.prod.outlook.com (2603:10b6:a03:457::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 03:41:40 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 03:41:40 +0000
Date: Fri, 26 Apr 2024 11:41:25 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Will Deacon
	<will@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Valentin Schneider"
	<valentin.schneider@arm.com>, Marco Elver <elver@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, David Matlack <dmatlack@google.com>,
	Friedrich Weber <f.weber@proxmox.com>, Ankur Arora
	<ankur.a.arora@oracle.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/2] sched/core: Drop spinlocks on contention iff
 kernel is preemptible
Message-ID: <ZisiZUWgERCZbc9w@chenyu5-mobl2>
References: <20240312193911.1796717-1-seanjc@google.com>
 <20240312193911.1796717-3-seanjc@google.com>
 <ZioJN6ClnlFIQIBg@chenyu5-mobl2>
 <ZiqJOJEBshsQLl0M@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZiqJOJEBshsQLl0M@google.com>
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ1PR11MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 0168b969-3f58-4a0e-877d-08dc65a2c865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Au2hZQgAkpIxe7Zil7EMjnVFD9t+tOIiZio4HX+jYHOQEKX7r3L1CMUo4eB3?=
 =?us-ascii?Q?TRjqtircIPkDuiZEsdr1woZ22XpC4+x6UoF8zPiy43C7it0a0VlxO09wYmFn?=
 =?us-ascii?Q?gfkomDSyrCk5JvPde1S2M/Dk7sPeauP56orRr2q8zmChcdW8VHk4b3or5BYc?=
 =?us-ascii?Q?kCw3Nc7vkPHTIpAnpvoxVCWOwiI0+UuWH2paxVgvw0wJhJKRJqNKV/AHF3o2?=
 =?us-ascii?Q?MwtPYEvz+JQMECjBazxW93Sgp4QUWqcyF6ZySv8NsEzes5YQbMamUkSJ8Aio?=
 =?us-ascii?Q?4E01EolbGvPWlCjJJLYubyply6b6LGcsLC7KiC9ji8Sb8GbyUuiv7wUyqSRs?=
 =?us-ascii?Q?R8CGfTwRUtTS13ulWTlaI7U1Jc31xuoUymVGfEw9/VzIRL683+fVHEZ0ApIZ?=
 =?us-ascii?Q?aP4Cmynymd5qrSvy6xE9G6lL3pXQUwvIYx+LqnMKgzhZKQePyWydEnwTGf0/?=
 =?us-ascii?Q?hTeLX3zAqDBeDQSpSeAu5WTv/TqKiIBonpFB46zbfldY1hPVKiZt7gL+fN5d?=
 =?us-ascii?Q?OThpA8v+dJxjvC5rfG0twQRQqYkkQR8jKeqLOwfBpmLX+WioYWKezQL43949?=
 =?us-ascii?Q?LYaO2gIv5HZaRcE/8v/rkKmzOX1jTK2ORuwcjkXlvvtu+h28VQCVrSRWmCqf?=
 =?us-ascii?Q?XEg47obFqF1M2mFBqKGsUnDl9qUMpSxAq0hJIet4ZFIFhZwsC0HytFZWxESV?=
 =?us-ascii?Q?8siUhPW1hFbX4eI+bR+zjaErMcrrkduWsPhgISfJGClx1Ul9dLL+SqEjkqfW?=
 =?us-ascii?Q?vL9GD3TMeZMNiKhwoC1uoECC3v0s5EyX6Vr7K7sIo8Tm7dtV1l35N3O1fdQZ?=
 =?us-ascii?Q?q6hgNu+uhle9lX+74JlTyHNkXRZgPoz+kSzyfHtU7Tcbj7ekmOyfK/9LE+ZW?=
 =?us-ascii?Q?V5leZbWxIMLvz2JeSwhde8LuYUWlTUdRaVIefkaGFeYq03yHEN2SghPEpgxP?=
 =?us-ascii?Q?GX5VQQBdMbsiLQm7hAMNXQTN4JadtIqQ/8MYWMqB0oMDhEo8Eyk+WVa3zub0?=
 =?us-ascii?Q?8ebweblKlS6T6Agyvb2Y0hcci8ma34LAEQbcJ0E1vVmykUxo0lNZjZjBg9F8?=
 =?us-ascii?Q?CjaEIfN9wxeJaoN6iF10Zeibu3UVE0X8OC0Qpy7ood/eluB6fvWJ2R/u/VhQ?=
 =?us-ascii?Q?1LsEM/s2ljK3xpiecDtVo02217xJNR2fjdEt56FkG/k4oBetCGBKRihuJSQ2?=
 =?us-ascii?Q?P15ija3EUZKXQrR0L9xLV1Xil+Loc4LNoB53bWKM0XyWvxS0Ip6mwRP37vMR?=
 =?us-ascii?Q?67U+0kB40Js/7xnzqnVKIendiEuYssW3Z9JYIJSo3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ljwOxsaDvSe3rSMBX+PnCk8NNoYFwhFsqruBw3SS01FKp05WUT7QgZOJYbqH?=
 =?us-ascii?Q?SryRGp7az0Se8tPVetkk2QvgSYZX2mRF6AEAI3QbEssY2kh7eWzAj+7romza?=
 =?us-ascii?Q?E/jZdUUohR3gpdzf6ZGmSXohxOw9apr79MCnaMj3KHr7Y+N1VkuQv2SXbAPp?=
 =?us-ascii?Q?YePkBXa+s0JhirFRaGhkaxW74XHD5yudBG5l/U0YEcX9rDmTp8o6q19ZbLzh?=
 =?us-ascii?Q?2Ag8V9h92WI16AvJ5mKm8zTt7QVYj+I6hu7kdnXxXkC5H1P7RufZoGCEgr1r?=
 =?us-ascii?Q?8W6zEmNQoynUPdIzWlwM+BW0fwMVk28+qBLyWUaXycdmxg0bQygYtTlx7JqF?=
 =?us-ascii?Q?BVWXnUHyjPxL0AQF+g+jlx8uVWI211AEJI4zeSUu/0GA6XufeTVevhVqNlQg?=
 =?us-ascii?Q?oQbqtGY+8RqZBcFtVy5pa4/ws8Dc0XD4at7KJ056E+S0uiwI6P+kdU3YpW7e?=
 =?us-ascii?Q?KuJsrJRl+oK/H4PFCxypstUjpc3BDLvnJjkabaKMzM9YQjzIAvzf9GiGaChT?=
 =?us-ascii?Q?xf1TP1Au4s+QdGcjCzTxdzfBi5v70pivxHyI7D+NpH3QjiJkUVe8SGbJWlWv?=
 =?us-ascii?Q?dZXsY0hP4pNk3xyEcU3u8fkpTx5gS9e6VRTHGe/7lXXPnD3w9eMn1fL24n5U?=
 =?us-ascii?Q?Erktv+fbf7U6zpTESf3JdE4V4cKYBOdhWfUaRceyLM0L/MbhdDUNCFdDci2D?=
 =?us-ascii?Q?0NDsE1xZoqVWUoOsE/7oxzgZjkxgE9N8z5SxQQtvNfY57M30WAx3vHGgn39o?=
 =?us-ascii?Q?sag43Qv8wKLNZxeFvDeiXarplXChA4bobEJcuLAFOtaBxON3ZKm6IzN50VUJ?=
 =?us-ascii?Q?zXcZP/9yYLSsrHtqtEY8rxfy/2+oPLecSBNAGj9eU0JcepP3VQe/TVLTqabD?=
 =?us-ascii?Q?z+WOZoZ9lVpEUO2o0ERCWra3jhtNKCp0npP1m5UupDIsoXosX3mYeqxXrNhz?=
 =?us-ascii?Q?ELG/dx8XsUdsT9gD+6B16S90vxFviN1rGYD5p9d9x+pFM+D7gmj7v7CimDME?=
 =?us-ascii?Q?X3MkqfdebURrvElu8uAh+wtsjo96FlN8Tf3kLA4OU8ejjMY21m0YfCYZ5jm7?=
 =?us-ascii?Q?rhugJIx1GKXJuV98MAtU2NeME9Js3RFkFM+gUIp2NQ7WAP4OJG/Z3RB8CA/1?=
 =?us-ascii?Q?zhQL68MO0O2JOKAA9x4rIlIjaKztlbralHsVHE6ogRIiid5m2zM49LCBnAoE?=
 =?us-ascii?Q?NTDC7dV/q7YE23SNJn3hnX5A0de6R8/rnnuMu6Sx5lV8wX5dGO8DBmNmDXRR?=
 =?us-ascii?Q?+g/V5Lo3Fs3JqM2ZPPiJrz5wgDm4bO+B5l0KaO9itB702pwGNqBJHbQvFwRJ?=
 =?us-ascii?Q?NfTZYSfXrZMQ5Q28REEO3nSdMLgHCV50sPDY8sSeWlSWdBwJP1Ny3VTdoJSv?=
 =?us-ascii?Q?d8Q6kopSBT4NUCM7Mms2DwIWoW7ivAG7GkoQJJldXR+GzTmaC4OLlLNdA5Uw?=
 =?us-ascii?Q?IcfoJC2I18Yg/tVRovP4h/aIi7gQTTT26VhPc+xvuFLoLbXYjX/Gw7FvfyJq?=
 =?us-ascii?Q?IXpgXjNYjiGA/1S9FnFs+LJx8axySrVQPvDGNkl3uvmKYlUABjQSnxWwSRUC?=
 =?us-ascii?Q?v8bRDp8MGKAJY5VU1utWC+/X36oMchLZeqFcZ8qJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0168b969-3f58-4a0e-877d-08dc65a2c865
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 03:41:40.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECuFY29qgDMNZzRuBNAxn33k2FuS33DR13tzhztm4/mGTctEJmaajtC5IP3g6n3mc+8sn3WiyZBmV5QxJUunzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6298
X-OriginatorOrg: intel.com

On 2024-04-25 at 09:47:52 -0700, Sean Christopherson wrote:
> On Thu, Apr 25, 2024, Chen Yu wrote:
> > Hi Sean,
> > 
> > On 2024-03-12 at 12:39:11 -0700, Sean Christopherson wrote:
> > > Use preempt_model_preemptible() to detect a preemptible kernel when
> > > deciding whether or not to reschedule in order to drop a contended
> > > spinlock or rwlock.  Because PREEMPT_DYNAMIC selects PREEMPTION, kernels
> > 
> > It took me a while to wonder why PREEMPT_DYNAMIC selects PREEMPTION
> > in Kconfig, then I assume that you mean the static config is CONFIG_PREEMPTION,
> > but the live preemption model is "none" or "voluntary", which makes the
> > static check of CONFIG_PREEMPTION in spin_needbreak() and rwlock_needbreak()
> > invalid?
> 
> Yep, exactly.
> 
> > > diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> > > index 3fcd20de6ca8..63dd8cf3c3c2 100644
> > > --- a/include/linux/spinlock.h
> > > +++ b/include/linux/spinlock.h
> > > @@ -462,11 +462,10 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
> > >   */
> > >  static inline int spin_needbreak(spinlock_t *lock)
> > >  {
> > > -#ifdef CONFIG_PREEMPTION
> > > +	if (!preempt_model_preemptible())
> > 
> > The old version checks against static CONFIG_PREEMPTION, now we check
> > the live CONFIG_PREEMPTION and static CONFIG_PREEMPT_RT, just wonder
> > if the rt check is needed here?
> 
> It's required, as CONFIG_PREEMPT_RT=y doesn't imply CONFIG_PREEMPT, and
> CONFIG_PREEMPT_RT=y is mutually exclusive with CONFIG_PREEMPT_DYNAMIC.  I.e. a
> CONFIG_PREEMPT_RT=y kernel will look yield:
> 
>   CONFIG_PREEMPT_RT=y
>   CONFIG_PREEMPT_DYNAMIC=n
>   CONFIG_PREEMPT=n
> 
> which in turn generates:
> 
>   static inline bool preempt_model_full(void)
>   {
> 	return IS_ENABLED(CONFIG_PREEMPT);
>   }
> 
> and so just checking preempt_model_full() would incorrectly return false for
> CONFIG_PREEMPT_RT=y.

You are right,  I missunderstood the definition of preempt_model_full(). For my
understanding of this patch:

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu

