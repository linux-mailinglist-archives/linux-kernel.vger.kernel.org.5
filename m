Return-Path: <linux-kernel+bounces-158141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858C68B1C15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E8C1C22FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDC06D1C8;
	Thu, 25 Apr 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4fn7hs9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE6535A5;
	Thu, 25 Apr 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030928; cv=fail; b=QuBH8qx5SN0BohozY0uP4fc3b4rr7rwCNQvUN7UYZLIdBsyV2dnZ68t9NGSJTllTmkLoBSwmpPAiHW6J0+zk7MjKrV7xHgE9yF+6WuwFvJ5NmYnyFGfmWWSgEdS0pbCTPib6rsQsIKUlCabiv7SsBmYE24/6h+QGYtZbIPnTGhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030928; c=relaxed/simple;
	bh=3iv8FGkJh2wP8fO/bve+vkgKloViR6vxK28SNlcZE8Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DQfLZ//Jy6Wa3V1PGumRMsrET0UdyqHCjkLYI/JucPjhtS3VCW2CKfYQapbRemtRm39vOoqTApper8TAaFqwfsoJVgHaqA3tAdl5tqHEkd4Kp7hZJaqhugqEXdupjvM+U1UzA+2HD+vjA1aFhn2oE2gmPlB+QAkaebpwti+q3Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4fn7hs9; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714030925; x=1745566925;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3iv8FGkJh2wP8fO/bve+vkgKloViR6vxK28SNlcZE8Q=;
  b=a4fn7hs97r0sO2MiSjlE14dGlLFRY++bjuSp4RGp7zlaPeAb9Gufz2Mj
   iPbvo01quDKEyc3TMukf/33xfzLtxGwxUgdHvmVPttBbFADXwsnX7l2zy
   K1XwlKdSNO5dRQ5edacd+FVeeUJzcBHoxvghmwuPM6tSMshN0IT6X5Err
   P9j+O6oPRPMWrilO6MsbE5P97d4S8IIwX6qEPmMBoIuA60SabYkx0j1Ks
   saCjCLU4gZjmfQyRhenZgUd/kAmjvUO45bo6JZX8TpmtxNqUwrUQd6vaZ
   GtH8DEN0gx2vabbgEqq3VD9u/B5lcOGbYO9rUWPcno9jrlGN1L7wrZtZr
   w==;
X-CSE-ConnectionGUID: ZpRLa46NQ5ChpaVMgMyNzg==
X-CSE-MsgGUID: qSG9Fqt8QYOVxc7qz8LfHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13483797"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="13483797"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 00:42:05 -0700
X-CSE-ConnectionGUID: d5ASkcm8TyyWQwVt/v3cxA==
X-CSE-MsgGUID: VAs8Y5mwQ7KDG9530RCkkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="29442203"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 00:42:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 00:42:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 00:42:03 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 00:42:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMYJbNfx9EoSZ/uJjftVZzzl0JWq90zWNw63UtbMskqJNGpHCc8+VUIP6+rg63Sv5RctxdcOwXlZsWOgbMzfG4NIsjWnCgzNKry0TTgpb9kakW9Kj6ZXaNsKfqFHAaC9jLM7bYI0oxHiY2t1GWnR2/cuO7ZQ3VoiW7JLT2WUGTvLt+7miVgERYDwn0jt7TVxdHlXLgbMlFWY6gPy32iznfOn/70CQ6sQTcfu40L5XqUHpiQ3Mi0/sa2TPlXROGuYP4C3LLmIgFAWRBYSqSZLAvi1ggfYgad0XYVPJ0VGsOS/zR+Vvaglby5hEcGvAhIuB/cWLE7XvW7a2KHia4Yygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v6tfcwVMxFZBqlcF6OjembtsTNG0bIRDgEqqZ/Vq1A=;
 b=SoTJljwNdBKnipMSmwj6rVgWwQWtuAxhqWwJH0L1q6zEhh/uPlZUJ7nXdSXf7CU+ZNuPJUkdYNbXB0UaIpVQ7v5XggHaHcSnPwkcnKFH5tsgFuDYfgFozA7gPMx6AqKNPv3QfvHZutvupbghJx7UOSz3eXRs1/GjGfD8ZPURgL4+/46FcFMDomV/wrg1QrNb+Lij6ZDel+5rWAs6bKiw9XBi6mlLFHD11+kOKbaF1VTo3gdkHnB4YfX9eBoLGpnbWBV+BEgm8Tv1b8JwUqKMSl16KQFTEnRIHGXkrfcfe901p+K+ujfmrT7NC0TvkJwLB2UK3d+PGos0D9xo3h9rXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB7659.namprd11.prod.outlook.com (2603:10b6:510:28e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 07:42:01 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 07:42:01 +0000
Date: Thu, 25 Apr 2024 15:41:43 +0800
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
Message-ID: <ZioJN6ClnlFIQIBg@chenyu5-mobl2>
References: <20240312193911.1796717-1-seanjc@google.com>
 <20240312193911.1796717-3-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240312193911.1796717-3-seanjc@google.com>
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 0658d09c-29cc-450a-1500-08dc64fb316a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DQfZ+T3qTEnyJi9G9FsnIwj/P50St6dsoSAUP/MsO6sxaEnbtY27oMgB+xCU?=
 =?us-ascii?Q?i5vgWPeJqKv1vrbTEBX1RY1AEn8q+GqkpIhjBkF3DTVo7kIPXJEGkJA0NPBe?=
 =?us-ascii?Q?swbxB5EzL9sS6FdOY8ll5nOyaFrlF4FMu6dnfjA/vXNVOy7l8mgR+rT4cIeK?=
 =?us-ascii?Q?mYu18u62sXnGWJNWfEQlqsjflwsHPD6X4RerKBGO21yoG1ribAyIbHcKtbTG?=
 =?us-ascii?Q?6n0qNnISFkrHo1MZrdKWkBdKAWidZMN66jctSeyxKyr3Y9pjsJx1SPbzOBSI?=
 =?us-ascii?Q?MbSQCd3QLlrYeZ85Cm35deWKvsKRduxlniafZiTnbMeyjNJUrhccOTOTNPsb?=
 =?us-ascii?Q?wAJb67d9YQ2He4JUU7lZiNcmnohtTClBQZBq8hHqy851AHP6oJA3crX325lW?=
 =?us-ascii?Q?Ih2trnHzXd26Spjkohll5xz9X/Pb3QiTOqGSn42EtZrRXJHjGs0KbHC26RU/?=
 =?us-ascii?Q?mudEbEyzC96Qg/rSz5hYAGVm31IZdKej6D/kvoLq3tMqzKM7iEyMeBMG2dP8?=
 =?us-ascii?Q?fL2Otuhu1/7HowuoOuAOwb3o6QNU3iVRm1R1zSVMv9yrW3XZTucvWCgb0yGU?=
 =?us-ascii?Q?GVB+XPWU4rI1rQ5Od4JlQThNAenvMqaBekf3wBqYglkaX3bbQ2cIq6M6eXhq?=
 =?us-ascii?Q?paVn1+97aYlAdXm5uXSZqvO3qrKnqHzu/bw1W5W5vayy2sa4YAbolBtHxRZ3?=
 =?us-ascii?Q?5AdE6oAzw2dUqezQh1DZ2w2K//sSSlKXqvhqK1RNpyVBtQTa5gb3QnKhS+mM?=
 =?us-ascii?Q?5yOhabHwNCY1ERFimZmjxXflBHUNsX9GUAZ73Wf8iI80IOa6+Mzel/SljWcz?=
 =?us-ascii?Q?UGXdmznGucpYDNk9yRlbMEcRXpLlL9A2JqXO0u9MYuxVlIxssZ4yceS1Jdpf?=
 =?us-ascii?Q?waZbo7fzCVBB9M/lThpPIkhzqz11glLmy/uye9Ctk5kWEdcabz/2qQgDX9bx?=
 =?us-ascii?Q?fz5D+eUfTlNmDqyk9p85MbQn4rMtTmZagHwLC2Ue3/p34CWZoXviO9x0Q+rs?=
 =?us-ascii?Q?b4Z5J5SVzPKXaHlS7fAwiSZ6m9C1AQK7TyVqtbl5IDeJXw2ZhX0ybm//1a3B?=
 =?us-ascii?Q?uIpHwBerOrLpLWQuk1gusMd7uiLcLs4UY6oPKkds/LgjdcM2Q3UK6gw5nxQl?=
 =?us-ascii?Q?YsotvSsdEiyTt2CF4N1V7hPFlgu16av8fsMf+gq8v5t4TpSb/ekOKZETvssz?=
 =?us-ascii?Q?c7I4NGQVGJtNAk3YPO8kr5n8P4GTqfyf5PqmZz4L+KP2QAD5LWfd+ZOhJF2P?=
 =?us-ascii?Q?DNCTRF679wCd22LN8Dxmh2N8JD1eKon38zgDB6DTjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tEqBeKtiC3ZCBNPRM8zfL15pWbPoelrljkmFeaPZuiK6jxsOc/qFf9kx4BK2?=
 =?us-ascii?Q?Xd4VqvxSDuMhdR4VNT/Es7cJDvSuc4XQK7+bvULrFXTnM/NVJhPC5rZWgHMP?=
 =?us-ascii?Q?SGnf4I/cKdB3rWA21bXd3hBK+qdBslFAMKCkchd5KK/zpVVWcAxyXYx+h4cf?=
 =?us-ascii?Q?AaIPpEiNJISvaRHoxrXW/DP+lor94GJCMgVu+udUfeT0xbjvScG66YeScsAd?=
 =?us-ascii?Q?F5hLhElWwh2HzGjKCroLQrohM43DmAftOV/6b6V1uwug/bYNp827jvfyJMZu?=
 =?us-ascii?Q?rO9Pt2vlcHi7842TfjQRP9oWF3LKLXSqGbePnb45ymSkYmRAPQWgT0ojuCQ6?=
 =?us-ascii?Q?5xNQb5Ff6Cu5sNT61r6o1Z0bXVxXwIpS4mY/dM8atZH2bvxAvzD58YlMDh+a?=
 =?us-ascii?Q?VxWw6hO6ePFZlGGNoxDwKUA82NW76uLz62vkla+njGZxSQXaxkYCdinNNLgh?=
 =?us-ascii?Q?eid/p2cl4ytydrgxRIcc6EFbHD8pDRM+kCoCF0R06WPPwJ26H2KHcV7byqnC?=
 =?us-ascii?Q?sWULcgpJM99AdEP5dNfb83VLnJjAvnnQbHaN1KRwZgjlJ3r8nEOwbh5wgrYJ?=
 =?us-ascii?Q?wSKlGzR2pkfrhQB+23DwdKI9exIKKXcxgSdhrP3CHfW37t9+ZgVS/Lgl+net?=
 =?us-ascii?Q?C/QlGxyVaEojp/d6+l2biThyNqtSPthQPurX5wvudFwHST6tirSna1AroO8b?=
 =?us-ascii?Q?2bsp0MwbAtQYtkTAY5zwOUiG6TTls5wpBy2z2JfWn9GEPHKMun0jri1kfKDM?=
 =?us-ascii?Q?7B+LZoG9Zug4wCfhjTfOILSygK/r2IDUDTJudmzHDCJ2wYFHOA+tzORic+Ym?=
 =?us-ascii?Q?npRXNHclOJHP1Mb3HPLreKuRk8g2uevcNohQEomeanidIV2IN5nX73rTINF6?=
 =?us-ascii?Q?QH6F7RuI0tq+MxPJRJ4sra/0pSP08R/qT7N+6vo+wFx/844FvolGmFZLbRxf?=
 =?us-ascii?Q?896L/thJh0kdhK+qwAvT/4Q6PiEHBwKjXPt+a1NG9Fnl9CCF/+Dht7pR3On6?=
 =?us-ascii?Q?AZ4OBOnjfFae+fiR34lSh6iHGLMGPU7Nyhja5biDPRVco8kEWN+H+9MokJEs?=
 =?us-ascii?Q?ekvUmH4E8OYx+W+6OVmko7vVC3fkU9vR5SxkpSELeknySclrqU8Fi4hyxG3X?=
 =?us-ascii?Q?ydZyc1ivzOnkjO+DS07hSDimUVRSjlNPRk1Se7xjoBHRN1MP6JqZHlON4CWZ?=
 =?us-ascii?Q?7VHkCOECPNhaYbzdJnfSO6sfJPcHGyxT123MM53kAuViMFSPbLk4ETX/tDOK?=
 =?us-ascii?Q?yfrr5DZaWJ1j55WprnU79CyNyMwx0HE4gs0DOqcdTFNOc443lR+1ksBWUX4i?=
 =?us-ascii?Q?A/8OO1KIGQuOMWt0bjYRq70Jvamr7uZ1bGxVRBqibTb3kSLyDjc65b8TjIVK?=
 =?us-ascii?Q?hnEsdAbcbQToDkTcN/Ujoh/DK49rMpVnyJFKn+3H3pE+IDoj/dEBLBP5z90z?=
 =?us-ascii?Q?QG0a6KzXoIO8qn6Un4tAzxjzQFEEqfU8mxgQsT5qQ7IPSUb9TvZUa1zfbH4j?=
 =?us-ascii?Q?fvOWF6nbVrUgiMy6uQavafP9OICdTWVDvsLiElkhwRvKlNI5DQ82z/jrCJ4y?=
 =?us-ascii?Q?s660GgFFirgjarMeA2mgwrJb7UkVd8NVa1fAynRR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0658d09c-29cc-450a-1500-08dc64fb316a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:42:00.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ug79b28w3SinE362Jea2Y+wOPRjEFK81rUps6RndQsw6rcDJ82Gi6f1f5Zv4lEI+PHWlXFpwiEO+Xht4Aq/9gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7659
X-OriginatorOrg: intel.com

Hi Sean,

On 2024-03-12 at 12:39:11 -0700, Sean Christopherson wrote:
> Use preempt_model_preemptible() to detect a preemptible kernel when
> deciding whether or not to reschedule in order to drop a contended
> spinlock or rwlock.  Because PREEMPT_DYNAMIC selects PREEMPTION, kernels

It took me a while to wonder why PREEMPT_DYNAMIC selects PREEMPTION
in Kconfig, then I assume that you mean the static config is CONFIG_PREEMPTION,
but the live preemption model is "none" or "voluntary", which makes the
static check of CONFIG_PREEMPTION in spin_needbreak() and rwlock_needbreak()
invalid?

> built with PREEMPT_DYNAMIC=y will yield contended locks even if the live
> preemption model is "none" or "voluntary".


> In short, make kernels with
> dynamically selected models behave the same as kernels with statically
> selected models.
> 
> Somewhat counter-intuitively, NOT yielding a lock can provide better
> latency for the relevant tasks/processes.  E.g. KVM x86's mmu_lock, a
> rwlock, is often contended between an invalidation event (takes mmu_lock
> for write) and a vCPU servicing a guest page fault (takes mmu_lock for
> read).  For _some_ setups, letting the invalidation task complete even
> if there is mmu_lock contention provides lower latency for *all* tasks,
> i.e. the invalidation completes sooner *and* the vCPU services the guest
> page fault sooner.
> 
> But even KVM's mmu_lock behavior isn't uniform, e.g. the "best" behavior
> can vary depending on the host VMM, the guest workload, the number of
> vCPUs, the number of pCPUs in the host, why there is lock contention, etc.
> 
> In other words, simply deleting the CONFIG_PREEMPTION guard (or doing the
> opposite and removing contention yielding entirely) needs to come with a
> big pile of data proving that changing the status quo is a net positive.
> 
> Opportunistically document this side effect of preempt=full, as yielding
> contended spinlocks can have significant, user-visible impact.
> 
> Fixes: c597bfddc9e9 ("sched: Provide Kconfig support for default dynamic preempt mode")
> Link: https://lore.kernel.org/kvm/ef81ff36-64bb-4cfe-ae9b-e3acf47bff24@proxmox.com
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Friedrich Weber <f.weber@proxmox.com>
> Cc: Ankur Arora <ankur.a.arora@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 +++-
>  include/linux/spinlock.h                        | 14 ++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 825398d66c69..fdeddb066439 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4689,7 +4689,9 @@
>  			none - Limited to cond_resched() calls
>  			voluntary - Limited to cond_resched() and might_sleep() calls
>  			full - Any section that isn't explicitly preempt disabled
> -			       can be preempted anytime.
> +			       can be preempted anytime.  Tasks will also yield
> +			       contended spinlocks (if the critical section isn't
> +			       explicitly preempt disabled beyond the lock itself).
>  
>  	print-fatal-signals=
>  			[KNL] debug: print fatal signals
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 3fcd20de6ca8..63dd8cf3c3c2 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -462,11 +462,10 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
>   */
>  static inline int spin_needbreak(spinlock_t *lock)
>  {
> -#ifdef CONFIG_PREEMPTION
> +	if (!preempt_model_preemptible())

The old version checks against static CONFIG_PREEMPTION, now we check
the live CONFIG_PREEMPTION and static CONFIG_PREEMPT_RT, just wonder
if the rt check is needed here?

thanks,
Chenyu 


