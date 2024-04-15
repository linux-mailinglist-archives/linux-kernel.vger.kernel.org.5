Return-Path: <linux-kernel+bounces-145687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 378F88A5984
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CA3B221CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96305137C2F;
	Mon, 15 Apr 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEU+ReTz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB871E877
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204195; cv=fail; b=n2fjjfiBQ0WnWDPibJ7e6TldTXaqFqc7uEQJu9v6xrU8UgVEVSpBiRrI2zidCS0suFolyKmeTkzn2d5StudIzr5lopywKfAIDpsWVwlf6QncDZBVDzFu1hBn+/hIuJlpXz2pBFAcPHqs1km7aGs8mI4MnSyYbmUWXQIlbj9K8lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204195; c=relaxed/simple;
	bh=Gf7ya+vC9RurEq10AFAZG4DLV/YJxB5sKsGsKmV21lQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KlZzZNk1MorDHImCKoXGIt6G86VK3j/fd73H4iP4P6GrMX6Ue2oXpPkLIYFDpyOtypubTm5hdsp1pE/j6ecM+A3NCZwHvdYUuEAjRm2ZBtwITuxOzGqg/EyPwPczKiNp5J5SQVedDgshNVOBllJ7P/t0UqLIFDZANq4Z+C43zTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEU+ReTz; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713204193; x=1744740193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gf7ya+vC9RurEq10AFAZG4DLV/YJxB5sKsGsKmV21lQ=;
  b=YEU+ReTzBiiH5pIpvqKOdZlgDDzu/eB7ltTYCmvVUcy3sVL0koj8Idy+
   au5Eq+f3izKL4Qb8wPVPqwo9Gn4dqN/lj4C1h+GyyTfX5gBkI3RmMnSiL
   wszhpOHEk1S6zw4XLa+FgaVSaYbLYPVNBlhWtoR2ctHoGt/MBaO2WhNGV
   K4EXjCjnX5hi4APytrwYYDUrW5o0CBTKseb4l2QMnpgdRdyLxQ/LlIGqL
   PMzh0iPwm5fpKFQGWQeW2uw4yPBTYngThYgKWC59xT31OMUVCBc51rbp2
   zdtY9FKP4vajcCmAS+01JjQn2rSqEXrDyDYrFHwrnYg60h3eDZvD8llfd
   Q==;
X-CSE-ConnectionGUID: pwnzYqr5RUaHQhNLPV/fzQ==
X-CSE-MsgGUID: /c/5NuOmT5ePWaqKY4uUJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8829778"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8829778"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 11:03:12 -0700
X-CSE-ConnectionGUID: +I5cIiK0STCka4qPL1FW4A==
X-CSE-MsgGUID: RzBMTq+NRlexuDgO1C2YXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="59433462"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 11:03:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 11:03:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 11:03:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 11:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfmaUIAQulvVWR+1WlZbHMRCOq9vofkh+aQiAcP+8ml5Thge9XP+EtoCZWsLKKTVIpuMQ/citK3r9sKECNM0UBXE/w4y4WBhpZ1Ch8kf11BkkP9IDY/8jNoD9fqE3NOMNl4Nil9uCNVQA+Xyj8+WRvJ1jGEKTNlWLQNVHx7Yf21/EDPCtSv2igRI2blIoR62/f55U9oOahOnKMmZinYnkkVo33rLtsoSQalJNEzaPEc/v7aG8PtszW/NP3hbkppnjKOXOgH73fL9+juw0jEfm8lG2XwhPP3QlTVZTM1o7LPA9K5RO8kXwQbhhb/xfVWjsSjHgZWJrzAhzlTWySmv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6fqittegDsTd3HDRhnjwS9MaKnrURaSJLvbTGimSYE=;
 b=GYVdCwO8rB/HrdATCmjYR850JnmWtF+9RHwIptWFL5OJHWat33Q6F3vx/hHhHCGbAOW81t9PLwKvUe12l2DqkXAr3DbnkCI+9YmHwD80KbhsErrpV7SP2tJ2Ru1MyexaiMPMCsl9Xr8YhDnFJnST7drsuYEHATjzHm55VgSW5RYn2S9e/k7Z8faVecq5t/Mjf8CeX8ZcgMz7stSBqcPmG1PzN1uAEdLPa7R2H+RJXsqdVlhydzq4TKl7wGHMvKwJB3R/36auQ24TpizGfh1GRhiROp3NgIfLW5Wk2DfzcUPmcvKEj4S3TUyHh6Z7ND+P5CS/gzNKLhNbwfGHuO2Eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4854.namprd11.prod.outlook.com (2603:10b6:510:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Mon, 15 Apr
 2024 18:03:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 18:03:08 +0000
Message-ID: <fe8e56bb-55bf-4130-876f-3047da182da1@intel.com>
Date: Mon, 15 Apr 2024 11:03:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/31] x86/resctrl: Move resctrl types to a separate
 header
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-9-james.morse@arm.com>
 <0ba51259-cb7a-463e-aabd-f88bd0c4007b@intel.com>
 <ZhlegNN3zZ4Q1lk6@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZhlegNN3zZ4Q1lk6@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: e135b81e-2cb6-4016-70ff-08dc5d764e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SbWXJ4ydgFlbP0Boy7gcxYlZtllfn3RsAj7W1bL2C10CnolNM70chzMHrNOzUbrgkDy1hYA4s+AFwkNeMCxuhGbz5N1n/OTdTWhcTuLg3MDLXwqdzuVcKP1KquChlrj1KqxJcvGjIHYfsv/te3/nEwUYlgRsRjWH1XYTCyTCKAtwpvGrUqFZAUl3bSbJRQ19AHeggJN96/yF2O2ToDBI18kQmlZTvC0MrhInrV/CTDDG3SqbZfSkawxKi8KJH38cBeJCMGiHgUVGG5BjiYhqk65Iv3nPPs70bBSNJBcjf00R/j9iVfIARS61jyqkVU8aRpNm215jhhUwY1AAXNPXgOHllYXl+aH/QnsoJsgsdOFd0DhN6AmyedfzPq0QoCzk7FtgYECZXT91cEH5/KwqAX6GdKb5mdlE2lZeX8+ZJG96ch4mTHo1ruho8G2W4h7hjb1beyP1T7eAQvMBAFWELTkNg9w5sm4qwEJDofZXkpEGwb6ouD/yYKzlRQ7NsPT9hS9vn1wWA/EJTVaHbFMJpAhzscsryBHj++iBr4gh/oIfhfZgTlHwVtYKuql2J9QbDigVqteptacrDrr8JWgKaBLg2Gmeh8gT14erd9cFyZjSaH/F8ZhYWQrrrHbwYA56s3iPy4cbgrltWEP0r7X17g1hB1U+2Vy7MuVECNOENA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnRNbFBoZDdkNWhBa05KMTlYZ3lPRTJIMU1xR0l6NWFlNm1BYmJFbldxOFB1?=
 =?utf-8?B?ellwRlBPSzlGUm5nb3VkZnMxTW1IUUh3eGJZbmRUTW1JcVJNUTZTeGdIYkdp?=
 =?utf-8?B?b3I5cHhJSjRnQS9lNDBPeU1Wb2pQZnB5engrazdCcVcrZFVZQUVZUFY1dEhV?=
 =?utf-8?B?emswa1pKdmNqZEN4Q1UvamVMV2VpZUhCOGNMNDIzSU5xemVXSUdZdEVYUWhO?=
 =?utf-8?B?TDRQR25SN1ZmeDdYc0NhZlBRQTRZdHFncVhSSFplSHlON01ETmt2QlpzM3lM?=
 =?utf-8?B?RUUya2NvUFg2dXFsLzB6M2tERnczQVY0RTJTTmxUY2ZlWUQ3amNESExCOERn?=
 =?utf-8?B?SFd4eUx1TjE1eUZMVmpwZndjZ09iZHFZV0I3WWptNmZQVlNaRUo4d244V1JP?=
 =?utf-8?B?VnN2WGNXeVhJSi9oVVBvTEZNTDZQUkQweUNSWjNPL3h1eWRsRFptUnFKdlJG?=
 =?utf-8?B?STVQQjU0bWhpZU9YNTBsOS8vYUw5UDh0bXBySGdMMFBFT0xrSFd0ZEF2dkMz?=
 =?utf-8?B?d1pnaUdJMmpuMmcrc0ZOTnVGTXlvZHQvVXBJTjRzb0J4NjlBenc3RHNnbCsx?=
 =?utf-8?B?Y3lpVzZ6UnpxcXp0ajRWOW9Nd1huWnNXYklxWThxaFNyV1RndW9vdUEyUVpv?=
 =?utf-8?B?YjV6YS9tK2Y5R3VZMkdnb0g1c1I3VndzY3UxUVdYZ29vblpQWUlnWDNUZ25Y?=
 =?utf-8?B?c2xkdVBUSjBLR3k2VEtYaFFzaFpzd0ZmbWNWWDZxelA3aHhxdlhnVWM4M3R3?=
 =?utf-8?B?M3hhNkZTdlVkNGZBZ1VSeTBDYXRKSWF1M0F4SFZlSUpqTmN0azdYV2R2elky?=
 =?utf-8?B?S0xtT1dpUHpyTE9iUFVqa2Q0UkM5cktMMWgxU1BoZDFFYzNVKzBHcXQ5U0dC?=
 =?utf-8?B?M2k5NmpPd1IxL1NnWldnaGMvaWNJbWRNSDNhSlNKczEwSGNYZUtDV05aT0xE?=
 =?utf-8?B?eER2NFd1c2VUZ0V1ZUVoMVVja2pVekdNcUd3ZzR0UXNFRExnRUU3L2llSVQr?=
 =?utf-8?B?YnkveHJCcVF0UXBvdGFHdnY3RUZFL3I5SFEzaHMxNWdmT056SDN4K0l2Yyth?=
 =?utf-8?B?cDI5dC9lTWZuMWh6TERBajI2SGJ3WnZQQldHVzJ6QlZLNHZGM2ZTemtqUFVz?=
 =?utf-8?B?V040eDNNbVZiL2txcTliQk5hc1dxV1cyZDRmTkNXMENqUHh0czZsYVBWV0Ir?=
 =?utf-8?B?YWRNOTYwUDNtVWRLSGtvWmdxMVczMEFlOTkvZzkyV204K0NKU092ZGRxVkxY?=
 =?utf-8?B?eGF0aWJQYU1LRWYrN0tUcHZ6VFMyc3I3RjduNVNMejBZWExCRjdZYWZYT0pM?=
 =?utf-8?B?VURMYTRyVFBMRktDWW1tZGNjZ3Y2L1FYUXh5ZnhNRkdHNVNDV0lCaldhMzQy?=
 =?utf-8?B?UjR4SGx2NVo5SEFzcGhBdzV2Uzl6VDFIQit2Mzl0WmU1eUg4TFFYTVg0WS9j?=
 =?utf-8?B?eDRGaUJxSWJWZmVCcE43d1lwVU9YMmpGenFCdnNRcno0NmVHTEtLdGZDSzdT?=
 =?utf-8?B?dG5BMmUvUm0wdGlwaUVic25RaFhGKzcvRjhmaWNpeWpDTHhqRGhNeWhKMmx2?=
 =?utf-8?B?TExZcktaWmxtejJuNjJ5WTBqVnZNSmNpSUVybm9aTFNiYVBSamEzczEwTDNp?=
 =?utf-8?B?T0JMckUrRE9kMmR6UmxCNUcxbU5HTUtoTWVtRitUUlZKMFh5ZmVTdDdyenBx?=
 =?utf-8?B?REdlc1NjaG84bkFtNDUyT0lucFZzdTVIaEQxdTI5ZmFqZllRT2xKSWlwSDBm?=
 =?utf-8?B?NGdGZzFDRmd3TjJQd0JXR3BGWi9Bb245K3FnOHBiNStLcWdRWFRTR0FjR0Ni?=
 =?utf-8?B?eDkrZmlIMmk4dENZSy9MeTZwVHNtd0plRHJRVzFSZ2dZYWVVV2FLQURIeThs?=
 =?utf-8?B?UjZyU2F4RHVkRHNCNGJJaFFoNVRtWnRLbU0vZFBzQXJ2cmxqTGJGdE5MS3BV?=
 =?utf-8?B?Nk1lSmg2TkVxWFVEYzlzOUtmZGIvSklOcDZ1Zmk4VlB2SHRjbDBJTzhzNTF4?=
 =?utf-8?B?WDFvbEMwcEdkNmNwdzg3WUF1dnp0UjlXd3JwZlhqR0FCNHdUODdXTWNDZ29v?=
 =?utf-8?B?OTBOSS9JUThrR0xpbUhhU280Vzl6WGxwMmtjc0tsYkIwZVlHMGlrVTIzRGQ5?=
 =?utf-8?B?SzY0cGEwdGtXalVMVk8zb1g5bEllelduRjZPMG1CdFF6Y0h1c1B5dWpkZC95?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e135b81e-2cb6-4016-70ff-08dc5d764e9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 18:03:08.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYZS/qrzKiQ6VJFN6N8jWKXOaMSLqqD84UCKPop/u2U0eznridO4ROGCbTjA1PJb9YwW31+MgNAI+fyu4zkTmhWT59P6DX+jM6pYMJR8C1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4854
X-OriginatorOrg: intel.com

Hi Dave,

On 4/12/2024 9:17 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:18:00PM -0700, Reinette Chatre wrote:
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>> To avoid sticky problems in the mpam glue code, move the resctrl
>>> enums into a separate header.
>>
>> Could you please elaborate so that "sticky problems in the mpam glue code" is
>> specific about what problems are avoided?
> 
> Maybe just delete the the sticky clause, and leave:
> 
> 	Move the resctrl enums into a separate header.
> 
> ...since the next paragraph explains the rationale?

In the x86 area changelogs start with a context paragraph to
provide reader with foundation to parse the subsequent problem and
solution statements (that are also expected to be in separate
paragraphs in that order). 

>>> This lets the arch code declare prototypes that use these enums without
>>> creating a loop via asm<->linux resctrl.h The same logic applies to the
>>> monitor-configuration defines, move these too.
>>>
>>> The maintainers entry for these headers was missed when resctrl.h
>>> was created. Add a wildcard entry to match both resctrl.h and
>>> resctrl_types.h.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>
>> ..
>>
>>> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
>>> new file mode 100644
>>> index 000000000000..4788bd95dac6
>>> --- /dev/null
>>> +++ b/include/linux/resctrl_types.h
>>> @@ -0,0 +1,68 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2024 Arm Ltd.
>>> + * Based on arch/x86/kernel/cpu/resctrl/internal.h
>>> + */
>>
>> Could this header please explain how this file is intended to be used?
>> What is it intended to contain?
>>
>> Reinette
> 
> Maybe something like the following?
> 
>  * Resctrl types and constants needed for inline function definitions in
>  * the arch-specific <asm/resctrl.h> headers.
> 

ok.

Reinette

