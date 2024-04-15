Return-Path: <linux-kernel+bounces-145989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C228A5DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C981F22706
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6365158A23;
	Mon, 15 Apr 2024 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CveODblG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293A1591E2;
	Mon, 15 Apr 2024 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221921; cv=fail; b=o7lCdY34GCVq4r8nlbWNdAxn8HB0nKTkUvTOqXgVDnK9++ffGFf9ZOcwE2EGpVWLCxBKnBHI53A3DoiVuAvAD0rg62akAf1Nv/QrmjbRUiiGQIKr3Gv5ocYus87c8OlM4XvopsWqUx/rsfZgwkfsZXLYZaU0JM/C7yBXaUaQxVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221921; c=relaxed/simple;
	bh=8VyNg6fWUxZ3J9syjwA85b1KGAbOn/n85jJEXko53A4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P99ueWbwN2M3goTjkKu4fDhoU0tvLcfz2cB6VKjh04EPG+XMDdR6lGatZKeIo+5famr+yt6Wr3ffmJ657dkkXx7GjB3+HM1NdwW4x8LCIoCC4CxG6bPR7Gru8Wu+G/iFlWo0RprMhXgr1kI5fTOoi28b9zcHMu01vV+uSnqvyaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CveODblG; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713221919; x=1744757919;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8VyNg6fWUxZ3J9syjwA85b1KGAbOn/n85jJEXko53A4=;
  b=CveODblGgpWlR+AF8UPxgqTTba+7l76xaKqJSWKTLcyZ5IHNYtIyYgWC
   3TyZBbiHL3LETBJeKztsFrsWkMbsDjUdCti8TZhffapfNP03m6y+gb5zl
   3ucMpUwFgvtHJioldi+Uso1sPMDzYw3nSxFLAFj/PBGB7tHXlN8JsR0k8
   kP6/eSEaCg+ta+uc04R0jG6TnIii0CWdkxh7vaLXZOFP5R63Rx6vIFVJW
   yEi5nGJKge6UWnWM8Qv3V5Y3XLi1ubxUmWEY5gOEzhU2X7s/3bCYfK0SW
   I90ENZ8lqpgE3GuE49M09ULNoMif0IXkP8SEWP60ed5UtRqdYchIyQ4Sj
   Q==;
X-CSE-ConnectionGUID: q0bsVicaTxGQQZF+J3LW9A==
X-CSE-MsgGUID: TM7lC8DuS9W5vb/RjtmJOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12412907"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="12412907"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 15:58:38 -0700
X-CSE-ConnectionGUID: 0+kZ2fIVQQOlYJOFy68KZQ==
X-CSE-MsgGUID: 517BCvslS2GZ22qOljWwPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22055872"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 15:58:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 15:58:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 15:58:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 15:58:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxGW5TJ5AdxASBcsM6fR7L3+yTFi9NaZYv4kVauVxIRFndYBHYrlc3Ub+8Qd075TtC5ZG/KEv85KRXjLILBY3+c54677vi3e2DtJM/4t09zHDLYzQHCLKNbWRWM2ZsEa8uCfFByAOWteHZEKr+2qj783JdVVI6nKlzdMYImuZlpm2RKpF/ywi9I6BqgmOUJNUb1X2vqYmNmJo7CFHiQIUmMrYVt6y0W0FYRNx2MVI8tKKX+OZNWLOBEc/+B6HAtThHyEKZQKqSfTXZsQaOgO5gBETq0HhLXC0mtV0+zpipW+pYK2WSBfzutWz/7UT4KDcIrRp7g/k/RQI25zbBeNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQ3umBeefK+x4NmdYLXXkFr0VbK5CR/P8yY0bw5Fkhw=;
 b=O7JRYikh/sHVQarcc4lpK/XFrNc1f8xPHEHIHZM+YuvnYraHUXe5YKs1mDQXFS3KSXZC4rzKvWB4PyVAzVFkRRfbS7589broR9Vs0bTtBhgv1ALxYZUMf8b9ZgQwtS8rHdE2q+nIIpMO9qVyXUS0uCzrwNewyN1633VAKThkv4KDOOY3cNXAEuuK94wcQUZHfs+apjGV/RJtB3lWMK3fP2tA7pDiSwJus18uEj6VVyhyaXNzwdQYcRxkccM0b+ga9C+dKDhioTSAMjbg8Yhzm0PybRIlk4iXkm/7CCt3KENVwNdA8XLaA1ytQLmJBO3emx2EgwB4MisCJIQNvG9MKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by DS0PR11MB8667.namprd11.prod.outlook.com (2603:10b6:8:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Mon, 15 Apr
 2024 22:58:34 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7472.027; Mon, 15 Apr 2024
 22:58:34 +0000
Message-ID: <2494f1ea-efa2-4c72-ae7d-1c363eb1fb2d@intel.com>
Date: Mon, 15 Apr 2024 15:58:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/14] x86: Support Key Locker
To: Eric Biggers <ebiggers@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<dm-devel@redhat.com>, <luto@kernel.org>, <dave.hansen@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <mingo@kernel.org>, <x86@kernel.org>,
	<herbert@gondor.apana.org.au>, <ardb@kernel.org>, <elliott@hpe.com>,
	<dan.j.williams@intel.com>, <bernie.keany@intel.com>,
	<charishma1.gairuboyina@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
 <13bb2f0f-5894-4366-be53-44658144a23d@intel.com>
 <20240408014806.GA965@quark.localdomain>
 <8fbab9e8-a2fc-4fb2-a9c3-e7336fa50118@intel.com>
 <20240415225420.GD5206@sol.localdomain>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240415225420.GD5206@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|DS0PR11MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: a1430b65-57c8-42ad-87d0-08dc5d9f93e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yoEyx2SDdq52zKoC87jZZgLXxtIQMRA0LzdZdhFCUTLeiuqX8it2hU+k/IAM5jdzoD4ONafthhO5fCobt8Lh8TlYEyRzExD2rSmN8vi6xJ0gUOTCMbbumc5vTy/eB8bAAi0UbRQWRTJZhKDHx/iFHHbm+hTNu3H5rcmktY4mjCwfI4LxTr3gX5QdFwfI8VxVM88+6E+8wDUxdwQ+5DbMhhrZN0bdastOjODLdI6tQ00wlHxcDuhIWKNe2eW9OimiPLnIHqTEy0CCSIqXLD/8SKyq81MWmfoHka6e6YqkqKKILTo/lN3hnOBhs39cx07yH96Ger7Ub4zzDr4i1O1IREcKWRYoCpNIpKV3UeQK1+bc58+Vjnn7JQ8E+1HFnwe5vfUelb0oVYApkhlx+uZNMeTTYNbUNuzyUmwT+0z5Ce9G2GyoAoDRlhSv9IfY3j1whNKX1mnPJ17cBTmayZC0YR+JwpwwFklIT6br6cDJH6fSsaOqO2F1UmUgT5xoSIKA3h6IkFivUU8Uz8d8FmriyHSuUBAFRjzXyM5C37t89igkiR8HlWo7MJJNFnVrL74LFdV63Zgwtqsf+gwmbQnTA0SQyicGHFoGRmT84bhOSdVqzqZgvlSBFcrnFLrNEW+LkZzkYCB99m98d0nC+OnDGuPO10lGlTUufkjp2jAnmkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmRXV05yczVVd3JRTTVNNjB4TE4vVElPTmZDa0JrR1ZsclVTbzRMSm5ieVoy?=
 =?utf-8?B?OXpKSWN2Q0h0RUdEREhvdTVqUi83cENTdDhib25nckFraC84UmxoUXNhaHBS?=
 =?utf-8?B?ZFlXOENhY01Va004OXR3NnBySms1RGJZMTRWcjE2VHVKblJMVXNDeDdlenZr?=
 =?utf-8?B?MVMxRlNldnBWK2NFbG9PWmw3M2xzUVZWSHdaMkF6aVRhVk1qc0s0YmVTR1FF?=
 =?utf-8?B?MjUzVjFWQUNLa0p0dkN5OVZIWGs3TndwZnp1RytodmQzdTFDNE1hdDR0ckU2?=
 =?utf-8?B?Y21BdzFPWVZNakx1T0VpUWNsRTBpaE1uRmhoOGtRY0hJV2IvUEtBTnJKdEdp?=
 =?utf-8?B?cWpaeU5yNlZXZFBuempkRzJqOVBseXBhZEhXRlA5VHFIZDlnUWU4Q1BpUmR2?=
 =?utf-8?B?SzE5NS8zUVV5b3ZhdUx4QkV2RTV4ZGgwdmVHeURyMkN5UzVzbjd6M1NERmFX?=
 =?utf-8?B?V2lZQTJpYlZ0bUhwUTN0Mi9iSTFuN25PcUFZcEEzdkJhb2lJbDZMVHh5dlZj?=
 =?utf-8?B?Z0owQkdOWXcwenlvNnUyMWlKdTZQSmpINTNoaSt0cjJFYXpzZHNRL2hIVmpY?=
 =?utf-8?B?WXgzdXRXd2M3bGFybDlsb0VwcDlpZDZDRWJ0dzBybmp6cXNvcmw2VVRxa2cv?=
 =?utf-8?B?ejB0aE11cytIUXUyYVBMYVBqc1RkdWRBVEJLNHJYT3RDSkI2MXBKR3VOMHJE?=
 =?utf-8?B?ZTR0d3paR0NvbHhDQUhicUE5NDlmYkFPUzlmQWlBZm5idjR4VWNZQ3dkQVhT?=
 =?utf-8?B?SG1jbkVXdkhHbEIwZmZaekY0andnZXBwK2RSSEVKL1VBWFhDNk1ZRHFYNXMr?=
 =?utf-8?B?VVBxVTlCekFuVWhUZis1TnVja01VaG1BVUpyb1VYVElXVjlZWTJDckxwTUNF?=
 =?utf-8?B?Q09XMXVxWVpLWXpURCtVMDQydUY1eUFrejMvZ056YURWaXpHSkJRN0hkWlhU?=
 =?utf-8?B?eFdXT2VsWlQ1MENpSHFiQy9MeXRkZjJEcnZZRW4xSERIUDZGc250ZUdlUWJ6?=
 =?utf-8?B?T0xoT2VweHhlWm5tRTFtR3dzTUM3TEZueHJlbHBjbWUwWUM2MGpjaUtMTmV0?=
 =?utf-8?B?WFd2MzhNOGZtRjI1b3RpcmlGRC8zVXNVOStWYUd5UytjejNpbDhWOXVQTU9p?=
 =?utf-8?B?VEJQZ0JHRDI1TnMwZHVwdkRyVVdlRFdqZytRQm1uelVzUWpGN0VUaTlrb2RY?=
 =?utf-8?B?WXVYcGZpb3RYckpoeTEyVHhDWDdOeXZ1SHl3eHdhdXh4T2pYbUpCWG9ySmdI?=
 =?utf-8?B?Nkk0emJiQzRNNEZtSTRqRlFtOVdsQXZZNGs1dUh3cVNLZkw4K1hQY0d0aFF6?=
 =?utf-8?B?VDVMOW1jbElUaU5zZDdHSjA1UjJ1eHpEWU1uWW94c1VPZlc4MDgyYjVqMUhu?=
 =?utf-8?B?RnZIQkJvVnptOERrQkE1WnlNM2dpQVNBM1NEbUlzM2ZYM00vdjE5UGdudXVN?=
 =?utf-8?B?OWhaNmRXcUdDVDFZNHZGakMrc1Z2QUh6QU4rR0o1YjZjdDdxbWQyVkJFZFBI?=
 =?utf-8?B?RjIvTTByRkhGQXVMUlkwYytmZkVWYzN5V05rTkhuR1NkanZsZjhWWEJQMHNt?=
 =?utf-8?B?QlF6azA0eFM2a1BVWEg3b1FjVUZ3OFZnTzVCcktBa0lLbnlibTVpNzhjWWc0?=
 =?utf-8?B?dk1zK25WeEVXU3A2RC9vNm9WeVpEbkJ0Ri8xSFNzVUZBTjRhN1pnVCtaWVlX?=
 =?utf-8?B?UkduM2I4ckM2K0lxemlMazhDZkhqa3ZLL1R6aUhiOTVMeXBxb1hFOVJheWhS?=
 =?utf-8?B?clBSU2Q4S0dYUWl1bytpTko0L2FZMVpIY3hWSGJNbElqNHlXaHZ1SkpxeFJx?=
 =?utf-8?B?UlJTWEh5VFk3cXplcVFiaXJPWUlUZ24ybEJzc2RnSnpHb01OeXloYmF0WXp0?=
 =?utf-8?B?M0VhWUtoYTJzNDdJS3BrcjJVTlhSNFF2aDZROHMvdndlSWw0SDdQdE40Yk5D?=
 =?utf-8?B?TVRwUGtWNW9jcXBGd3FabVlKMFdvbm1iVFJYNUQ0YTFEZ0NlSFhydDcwM3Yz?=
 =?utf-8?B?ajFaRWdwZ2ovazJ2enJldHRzelpkcmk1NDZUZmxzSjFuMi9KV3ExVWMxbWFJ?=
 =?utf-8?B?Y0dNbU8xNE1UMGhYbUZYOG9TZ0g3WXhDQkdCMER5bnF6UzAwR1VmUUgrSkI1?=
 =?utf-8?B?VnZlU05PS3dld1QwSDBDc0l1RmFSemZIWmZ5YzhTQmpFbW5kTUFFcTdCQlIr?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1430b65-57c8-42ad-87d0-08dc5d9f93e1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 22:58:34.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvuPhTPp9mZQUqULLYhxoHZkndHCzPmBZO8x12bqErHfsHd/kQSiFaKLhcvT+6v2khIYcnvXeXT3IOxx5EQS67arjCbSdSh2Gq1wCKLFb80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8667
X-OriginatorOrg: intel.com

On 4/15/2024 3:54 PM, Eric Biggers wrote:
> 
> Sure, you could still use VEX-coded 128-bit instructions for everything other
> than the actual AES (for example, the XTS tweak computation) though, right?
> They're a bit more convenient to work with since they are non-destructive.

Right.

Thanks,
Chang

