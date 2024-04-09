Return-Path: <linux-kernel+bounces-136514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E547A89D508
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB8B283627
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3372B7EF04;
	Tue,  9 Apr 2024 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAyBpHGD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A77E580;
	Tue,  9 Apr 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653253; cv=fail; b=m6D+Jr6z34pkjofPmPPYOVwcWlYX3K71uPHDsa9P/4HDl5UeFyLmlnX6lQkry+qvjclOgWdvAjBf8G9Jy+mMv9A03MnR1KU1Gzeb90MxZTzvKFfHmg1kvBIMfhJ7IE+KOiQYlLnMXUVZdkced3lq1qC30DqjCgvhZiV4cREzCUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653253; c=relaxed/simple;
	bh=ipeW9eZEK6BvQFw96U3AMSG3OnRBnlfjmbFbz7lSDbM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GLW8AxRJ6/RcgvnzxOstnWFa8TgilCQEmiC0x1wnUabkYUvdcgsD+fy05BBsJqYKd+hRYWHDkEMtMtQXiWFxesQeTuFOc076/10sH0O/EUivZCZrJ9YrqxrQVG4/lRe4EHxVfzlJ9ZfpVZv4erFsMPejBcaNOE5I6ZZLPIewenA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAyBpHGD; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712653252; x=1744189252;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ipeW9eZEK6BvQFw96U3AMSG3OnRBnlfjmbFbz7lSDbM=;
  b=MAyBpHGDefY/z2bO6Puz0og9+IrmQzIDq69uNDcZoIVBRw2I6gZc08Kv
   5T5EI8L4uXE3icnWqsWvYTb3pR53xDbVWqIdDGmtmIJ7wrQo33Pg9kL1b
   3FzFIueyzPt4PTueFEsCPflSzA9hJH3T9Rlh6cQ9fP92U9tzDvYl7Kf2R
   AwyX3DYucJKUwqXksLst4+hKhkzcmkpuvGGUcQQ3MbrecIvpO6s4E61hW
   3ZmSVobD11cnylFQrj1lgK1sXv+HZGEsBhLqyY9VZFPlM9rDA9amILyXa
   rrh6U6yR1kpK8ZwPIZkX/zJwLDN9oc5goH6MaAMllqlb909Jo80rNOHZG
   w==;
X-CSE-ConnectionGUID: cfbpzEAJSTOGZ6zmUMxPMQ==
X-CSE-MsgGUID: zi/MDlgURAW8itWNl16i1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8188813"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8188813"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 02:00:48 -0700
X-CSE-ConnectionGUID: 8tkKTq7OTXOpMByXQjFPwQ==
X-CSE-MsgGUID: Yp9O+h7MQhaGekmVh8U9RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20076071"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 02:00:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 02:00:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 02:00:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 02:00:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 02:00:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9MTyD6kcHiyz/iy+bp9p+/7E/5HfqrWkDdMztSs2yjcDM21RqDnRix7CKz7EvyhsnmDsdKde4sHMOwAEUSjINw1O3aGy3G78l5know1qliEb/p4j9xEU8yZkErOTvt4rsFxN6Xkqru3U4NFn31F8sJvrL5dRNb0OpMj7Sfq0RZ8d3w1frYvn4SwtD7v9qXwhe5MwVWFou5ycCplT3C1mLt3fecB1Q6qhtIU9SIkBEPlKNMBYsgHJBm9K4sroNp9G0FslGFXZYzKB23qkyLpCp9bl7ZpL81TD4rU+pTv0KfLX1wVX6QUitBLNcZpoZ4Y0cIfLfGklYTBzwMEn1jJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jnayr4X27IWSidtX2ZChtV+ZUFmUx3+QGY8ASyObpuY=;
 b=Tly9OkXnMgaMsDURN392UmpqGMb/C/r3wD0e2ymAwsPKPqPR81DFO2eExuSsTDQSfRKfK9UljVGvdwZBBJH5vtAxblBSC3Z2lUZRAvgbXDkI54RXp8O523GxDECcnm31sVXuA04il+qCrCSlozXEav4niIyqwsfjM+qpdgWYsNBmu2IeNEfU+zdxU4ZMl2l0LwbUNOYzCLv5Iqd6oK8M5h8ZuskkcPxmjyy+KXKRCW6Ue2PGeL7VpbuIE938pbg87SyALQkxkbu9NO2ZBCtWyKN/yAQNt3lBtbezq1xC2JCdC9VklZhAy2gy47RjSNmMc3afKxYNgkHf6eY3LKyvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 9 Apr
 2024 09:00:42 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 09:00:42 +0000
Message-ID: <da430107-23ff-4984-b6ff-2f2e94f1429d@intel.com>
Date: Tue, 9 Apr 2024 10:58:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: dsa: lan9303: use ethtool_puts() for
 lan9303_get_strings()
To: Justin Stitt <justinstitt@google.com>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>, Kees Cook
	<keescook@chromium.org>
References: <20240408-strncpy-drivers-net-dsa-lan9303-core-c-v3-1-0c313694d25b@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240408-strncpy-drivers-net-dsa-lan9303-core-c-v3-1-0c313694d25b@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB4847:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYn3oYeJ5BgE81fGn2U9G3KGY2vdyjvjo3B70sxcdck5ILEqR/FzPRuhanWEi1EIlSdYCg98cz7lKy8TL5gLhQ7zard++wWlrcSa0kurzPnZaDRWaTWXtNMNRpDFiZycU+LdAAHxazCya96SGn6css44yQZZJyx6qEwxFmebtXbSHU/+2F/EpxN5C2EWsaeHy9BXgPWomWeTlmxh0Ed39qX0gb797qnOm3bubG0gutbx7ELxiiu/1aEjS/Mljhxp0hd4uwQaZo+G90UtE/GZH1US44L90t5223koFvM2kxhk+UqoNMCbOijnh8q/eMzzstXYBnTZuv2hrNsGX7dtc98hxTrtWu01OWfnjx2/mT2lM3BJ74y9Z/cCjU4g+bccsDLrQ/YTIgckLC9wzpRZK+Z3B8YtDLwgeVzn2p5aPfUk3Ky4CZwQjfFv95O2zXFLneIs1j3o5oOyL9a7RNMw7nxSjjpSdVE/0/WfH7Q2/yIrGV1rit2aTIvZyfivlM+Wnv7jiyH1XAmuoa9vM/6KI3t2V4BKHCoy4GV7z84pG/gMkaUz4xrr30v3w/so+HSBmtb0tSb+JtHTq9T281Mje5OEG5Zj1Hfb5xzuCPaZ+I13uwfVzqgQQ221CathaTHt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzMxeFZkTmNjUmlBOFk1ZzloK1Jpc0xBQjU2OUVsNWMwdHc1ejA3N2h3Q1Jm?=
 =?utf-8?B?d1puWnlJcnRZOTRwbXBlZWxjeHpCK3IvZ29JVjdyOXppNUhGNW1kZG9ERUxa?=
 =?utf-8?B?T29OR1QxWjA2REx4eDBDTExidU5HY2VjV1VQdlBsem05Qkk0T2tzcGF6aE1W?=
 =?utf-8?B?VmR1MW9zZDFReHBJRVNCTnZmck9Sam96aVVvbHdqSmtkZk1ySFFmMnI4SitY?=
 =?utf-8?B?Qk5mTkg0Nk9XSjFUekFGc3FBcDZEODRKT2VWUVZRbEhSbFgwelpLbUo4UkY0?=
 =?utf-8?B?Q0pGdkgxZkRHYjdHTzBLRndsWkR1enFNeWIxK0dKWGRha09BenFVSUJnV3lX?=
 =?utf-8?B?QlR0VFdXTUlBU29sMTEzU1hteW4yUTVha000K2JsMjQ3OU5mVFQzRndoUk14?=
 =?utf-8?B?c0hNUnJrUEwvTG1PZThuWUhJMnZjNEUrTUt1M0hvcFpNdmpNMU9pNUNXYmVJ?=
 =?utf-8?B?cjduUHhrbE5uS2d6cFNMdHhXY20wNy9OTk55aHZuME9OTXlIREphVkFmSlRZ?=
 =?utf-8?B?THd3SjgvbjBQTUVBYjI1cnBrZytMYlc0dWpzSVlDUldPYnhKa0tNakdWNERt?=
 =?utf-8?B?T21BVHlxVEd4eGhpQlZ1MVNEL2VmaEdoSHBmVG0zYVQ1UXBCRnBZNVpnOVRo?=
 =?utf-8?B?Qk4vVG9vTmVVYkV1c3RMWmV2aXNqQWd6cTI0R1RvcHdINVo4OTRla1doMW9T?=
 =?utf-8?B?bHhFcDZaR3JkbkVXbWUwZlZlNlI5Qzk5TWxNbU5RdkxCZkJtQjM1aGhJMXV3?=
 =?utf-8?B?aHhCbDdlclJFdEJtZUZZb256WnVuV2JoSW56U0g5bkhhdUJGL251bGNRbG5z?=
 =?utf-8?B?bXdDTHd4VjA3czkraWxTa1BhL09IV0VuYlhnNnNVN3ZFY3huK0MxMFRZVGh0?=
 =?utf-8?B?RlRXd21KdHRtZ2VldDZ3Q3J4NUdlQkMrL3JqaFJXU2pkNXZweDljM0c2YjY4?=
 =?utf-8?B?TmtldWRRaFYrMlh2Q2ZiUm45MDRzS1c2VWNDTmI2eTFybkFQNlhJbDMxTlVn?=
 =?utf-8?B?TW1vNXQxb1dYRDlWdlhOVzlyZWU1aDlRY0graDM4emNZUGNsME5mNUZzanVn?=
 =?utf-8?B?Y054aTR3bGxnQWprbDN5S0VSMEZrT1BzRkFTbDFrMlhSZGJsQXlKL2tOd3ds?=
 =?utf-8?B?ekMvd09rMXArVDB0L2NmN3cya29INTEwenZGMWY1dmdjcjhRcGwyeVRkWEpv?=
 =?utf-8?B?OXQ1UG1rRlU5M0tvY1VKY0QyUzlzemc3U29GUm9oWWRNUFAya0d0SGR3aEJ4?=
 =?utf-8?B?T1JkOXVOa2ttdndJL0FlZk0rcldiQ0twY0dLeFcwVEQ1UXFFQWc5YWZRNDFk?=
 =?utf-8?B?SjBjQTd5SkdpN2JkWS9PQkk3WFR1WHI3N2MyRWhMWHJoUkpRd0laZGlEQXNU?=
 =?utf-8?B?WmdyMTU0Y1RSL0N3cFhXbksxM05MWmZFWllWSWVDUHlsUlVXb3RxK0dpcVFm?=
 =?utf-8?B?QjJvcXFqZ1o2d29ZWGlIQmxteGVac08rV3ZXNTNuVENWM1FZa2dCSzRlSFYx?=
 =?utf-8?B?cmZMZjhMWTlocnNwaW5XalZRbnVpMGZ4L0Y4VUYrcnArZ1YwRDFYQTdpR1ho?=
 =?utf-8?B?Z2I5cjM1cythWXZtZ0t5Wnc4MzV0bTZHRzlJOEhyb2htTmZrN0ZWUmtpZWZs?=
 =?utf-8?B?NTFBNUNPMGU2NjhpRGwzd096WGQ3bG5ZRDVhM2pJNDBEcHRRUm5QVjF2Tm84?=
 =?utf-8?B?WWppSmRtd1pKUVRkSndJMXY4TnNCT0N4bHhYbE5PWFB3WC9CbDVCZ1V1WDNL?=
 =?utf-8?B?aDhOQVpLcFlOMjRIcTBHWVdrWlVYWTBVWHRIYWwwNVVzMW85YmkxZ0xmR1NS?=
 =?utf-8?B?ZG1ldXFacEI4ODBBWmVuR2JRWjBjdzdzSjRWb1NvT3I5aXRTbDBmNlB6bWNx?=
 =?utf-8?B?cDY4ejAxUllNUGk1aVJCU0lyNUplYzRVc1IyTEtERmpFSnZLcHpaSmFtY0xp?=
 =?utf-8?B?ZWl3bGYvdUtYMmtMOTBqNmxoS1E1YnVXQTAxbmtQSFpsOVBiNnhNWndkeHRY?=
 =?utf-8?B?b0JNN1QyYXJzN0tsc2VNKy9SVVNzM0YwQmVWcklsTjM4dHBEeURDL2pGQkUz?=
 =?utf-8?B?dDZQZ0ZNQlpQcGZtZlg0ekF1V0xLMlRXcUg2L0VtOEJSQTB2eDEvWTR1cDZU?=
 =?utf-8?B?WWFNQzYyZGgxcTFneU5OSGU1bDdScHUwVE01RTB1b0txTm5PYkgxRXROVER2?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3938a212-4da8-4e2e-c5a1-08dc5873891a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 09:00:42.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEhKWpq9RDMvgCNXlxX/HevO4OfxDx8IhCte1DotBEXP3BmUdFf52C7+F0jjnJQDlmTuU+hCLwA8hxu4rAYNLdczWEVxGVMW3Qxqj80KrP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

From: Justin Stitt <justinstitt@google.com>
Date: Mon, 08 Apr 2024 21:01:57 +0000

> This pattern of strncpy with some pointer arithmetic setting fixed-sized
> intervals with string literal data is a bit weird so let's use
> ethtool_puts() as this has more obvious behavior and is less-error
> prone.
> 
> Nicely, we also get to drop a usage of the now deprecated strncpy() [1].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> Changes in v3:
> - use ethtool_puts over ethtool_sprintf
> - Link to v2: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com
> 
> Changes in v2:
> - use ethtool_sprintf (thanks Alexander)
> - Link to v1: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com
> ---
>  drivers/net/dsa/lan9303-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
> index fcb20eac332a..04d3af0eb28e 100644
> --- a/drivers/net/dsa/lan9303-core.c
> +++ b/drivers/net/dsa/lan9303-core.c
> @@ -1007,14 +1007,14 @@ static const struct lan9303_mib_desc lan9303_mib[] = {
>  static void lan9303_get_strings(struct dsa_switch *ds, int port,
>  				u32 stringset, uint8_t *data)
>  {
> +	u8 *buf = data;
>  	unsigned int u;
>  
>  	if (stringset != ETH_SS_STATS)
>  		return;
>  
>  	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
> -		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
> -			ETH_GSTRING_LEN);
> +		ethtool_puts(&buf, lan9303_mib[u].name);
>  	}

The braces { } around ethtool_puts() aren't needed anymore.

>  }
>  
> 
> ---
> base-commit: c85af715cac0a951eea97393378e84bb49384734
> change-id: 20231005-strncpy-drivers-net-dsa-lan9303-core-c-6386858e5c22
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>

Thanks,
Olek

