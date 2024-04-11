Return-Path: <linux-kernel+bounces-141418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E698A1E56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FED0B31992
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6512EBE3;
	Thu, 11 Apr 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/yXKcGJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB51823A3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857245; cv=fail; b=GNByDZo9Bqiy09tD/tGdqy6+ejsLtA3xJb6JPOB4RYyYN3pM4hSl8S3i08fj5pB0607wtWEADdCRSwCejwT8OogLP1roSopBCPovdeCuurH94j5AX7S+OaW+oDClK9wjDUzARGLB9ZrHH4zRDUm3hZM8dcOl6mtIhVYesDbWKhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857245; c=relaxed/simple;
	bh=pvtBf03SeSLDAT52YvAtJlxBdef5Q3s1EaQExJnLm6w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AbOI6b7rq3cTypYLjqE12rfeJs32OM/CPMmB1NcPT8uDyPgF0tabulHsU49vPyeaqvRpoH9Dm2lEDeO2Z0Q8zd6wNLifbhQ7Ooko2pLl1Aw2d+PmDOmtZk9ZszPNDUi8folWmM8aYMbxAO6VYBZpJ1kX/jDYpZ/9H0yIlY2CPmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/yXKcGJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857244; x=1744393244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pvtBf03SeSLDAT52YvAtJlxBdef5Q3s1EaQExJnLm6w=;
  b=F/yXKcGJXrmooE5fi++JAeKgnLaQgc6VnhNmbNhnZhJcF1YXmuiDwQuL
   YophpuCiNG5tuygb2kSvlWtxLFRDLG5K6yYjHQMmE1mVfF8Ur92R6dX3k
   18kKwrjHGvmMxFaLXFPBUQonBZ0gpDwYqSWc6mmKuAkBYMBNvwKRAFmYb
   BRC5tAxRYgAmBSMfc5bldnf5kOThSDPOKFP0M7qYFE2GwMsTiSKW1+Iah
   vwPw1+6RMiSsVHX/NDwMUjYxvi1BGfLfJIPNjpRENUom0roWB0lOSc1ze
   j8GNuLk6c2F26lFD1SN8cHEmTujDEPlssNEi3Cgc4RR7gd6aVf1h1//Hc
   A==;
X-CSE-ConnectionGUID: xcPti18wTfa9GUTmeYh+mA==
X-CSE-MsgGUID: QiYY+mLNRR6z5Oq368/Tww==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8204620"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8204620"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:40:43 -0700
X-CSE-ConnectionGUID: ccnoR/FdRWeVwD02k3SEbQ==
X-CSE-MsgGUID: AGjac3N+QNOtDKTBjRAmBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21455561"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:40:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:40:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:40:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:40:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:40:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAg9jNYZiwxqLDTvj3fOJYgU23QmHvj76uzLKVQaIPpOWt+4LjpON+O3dsTk2WEFl+u1S7Y/Lisv/1XmQDvVtjyoVS53Ufi4skiFX69YJLgSBRKRTr9NTNvsHAACorhx/Xa/EFolQvINE4rvhXQaTqSs5c3fk5oatyHE1YZotVYuBtQAacY+lHdp8yv9VQo5A9kJfdeceanB9+bLcAml7E3ukp6LMvM04QuK3DqoajkNTEOPHfZMx2K3NslNp2rkc6Y8R80tL6qrB48OFEzQ4RIfqAAVMU9eMfvHAj4/0jdt0for2fOtImEHpIfP5oSS0qY61dhj/enPfBju7B81rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2Nonj+Q82DR099zuya2yUEjPVoapM7dgOxaHT1zmsQ=;
 b=ZWfNRQ6gyep+EvsBy7eKpkzWakTqRJyQCJ42+Be2uJxVemUHgWBFnmFknkqjgP68PjSR4KWqr7sBfPA7uC/XCsWi/r8uVmoWxGV3xRVhHVikOfHC1AZU5dqiMQQVqh9MAKzLaYCyisPJxsjTOGVjCptUTEQCBoO772ZpoLefC3WPauWaTcGZFOOprt4V7gwcGMZsrnS/iYEmYeDcKb8wo0ZHaG1L8p+j/S2OmAd6nuWOMjkPrJsHm9d9+bAYcOkhUykZSZulSGhLV30eyr/r36+CxI2BM+ADb+aQnT6K2W2ssH8kiAfbe+WB7dICn7DFmOV9jGmh/BN8C0onemrRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7823.namprd11.prod.outlook.com (2603:10b6:208:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 17:40:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:40:40 +0000
Message-ID: <095c100c-b5dc-45ad-a5d2-86bedfcc1bfd@intel.com>
Date: Thu, 11 Apr 2024 10:40:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 22/31] x86/resctrl: Make resctrl_arch_pseudo_lock_fn()
 take a plr
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
 <20240321165106.31602-23-james.morse@arm.com>
 <6589ae7b-95bb-4490-83ac-95904da7649f@intel.com>
 <Zhf1244gRHVueI2u@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zhf1244gRHVueI2u@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:303:86::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ea4e15-26c3-49d8-5e70-08dc5a4e8118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4K3adqlG1sZZk9XLWLSllPbWLwrOJf9TUrH0icjV681TGS3mJD5FmzWndKwoq3enduD3cLvfy+8LaMcbqMi3fjpbBfF/a7ZcjferNkatQCI3+7AiYHE18Yy48+ula5A9qwRxRW526cqVvkXOhuMsXfjHxyyLdFKZD5n91xiSVdhUn0mhthz4o+Xets49V/hYl0vLwgDbP3r2JVY8qCN1JBz1qtys0733PKQ0rLS2pEDBWp3mNZp1Dh0+coMMy9xzqtUnY+7sLZPuPWxNmKz4d1z/VyQN1oYByLj/YZuiRMXs/fAJeMqm7pG2LVw1FNAoIYlCLaQqsa5RSYlcBx5WPLlgDvY05mNH0aaKoBmI1XOPtPOq5MiX/SUpwk9aoQx4rRt04MI+exX77cSQKHy3RNgOkm1uxjfIpcc98ndZL4lFaMP3xd0/snSVA7Nf/ST+quFWL4pqGiRPZVNxsWnFsFYtPjDPg5fwGXp1hSTuxNNWVBYsk0CRXMh1ZAraE4r67ZMZkvCS3y2FsSgGeJqrTUXAN5ph3JtI4EXvfLyWWcK9YUfAn1HhQABKXxMKxIN+GNfirfeYd6W0Ewg9G3OSiTzXN78ZstmCkEeGLt3YfeX9djoUt7bndHJEnsdwjWQgjpNK9HPVMk496k5rl+76PnpxWnQ3LfcJCphLo1ctwXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXV2Qnd1R29jaFlPSHhHdzRqVEJkSmNaOTFqOUZlaVR5bmxRNkh1OTFGMVlM?=
 =?utf-8?B?WmdzVjVUU1AxNEJ5NGJpdzJwQUZIbW9aTFZkamI5UWhlRTFtdHZQMUhwRnhP?=
 =?utf-8?B?T0hvbTRaYngvT3NTSjQ2OFJQelB4a2t1Mnl5ZmY2SFZieVlLS3NGYkJZNTVS?=
 =?utf-8?B?WlhkZHlKRnBBbmVzRWZHaURZOU4vd1dLT2ZLRVhSeGVBYVZKUXBqM3R6UU9j?=
 =?utf-8?B?N1BNOHYrUk9jVVM1VjRPRWFzbStvQ3dnNjJZMy81OGM2bDZLR1ZXVXVBc21y?=
 =?utf-8?B?OTNzU1gwbWJSWWlHUGVUSThpNnFXdlN0anZ5N28rRFFkZzY2aU5jbCtyemFS?=
 =?utf-8?B?dFQ1ckNwcjNaK2dKRlBrY1FmL2FZd1hCVVgzRWJWdWRoK3Q0WDlDSlJPWWt2?=
 =?utf-8?B?SGZxdzlDZm1VVHU1bnU3bWVFMC93TkdSM3hYZ3J3OUhKZzA4RVE5a25hbXNI?=
 =?utf-8?B?RzJDM0ZVUnNEOWMwZ2F5UlgxTitId0tkalZQRHY5dzYrOWxSMkR0cUNXem1q?=
 =?utf-8?B?SFN5L2hsdlFFczVORndnYkVWQ2J2TEl6TUVGWWRsTFBBMnVYVTRRbUo2T2dW?=
 =?utf-8?B?UkkrNUwzM1c2ZUNQdVhGaURybm41V1JtRC92UlZHNDhPTFJocnV0dmg2VXVK?=
 =?utf-8?B?ODlrUXViN29WNk9NUnExcTdrbTBLTnhza2FHNGl6Y2NjUE85eGh6dWF5emNk?=
 =?utf-8?B?TWhQMUhFYzdDWUgxSCtvckt4T09hd2pBQ2hnZlJ4RG1ESlZ3UThWV2RmVnhn?=
 =?utf-8?B?eGxHOWp6L2dWTytSSHU2MkY2TmJVVnRiYTVoTzQ3NEhFQlhYS3QwdlpuRmhP?=
 =?utf-8?B?WnBkK0t4UG82eXo4dGVITnNoNGtPaTB6aDdpcmExOWdjK0NUd3hOd0tYV2Zu?=
 =?utf-8?B?ZW9Xc1NicHFkMHBOSEVDOWJEY3F5Y01ERGVycHRoU1BBY1Rpd1ZUeXVQRktX?=
 =?utf-8?B?QnlNc0RnVzVzSTAxVGw0ZXJJTVBkTElXOHdtZGdpUklBMlhWZU4zRGdNSmdJ?=
 =?utf-8?B?b3ZWTEg1UCsxdFNYa1VENk9kYmNMM000WTd5Q1RxWGFDRHI0ZjNhWFM4cFpM?=
 =?utf-8?B?ay9lSkR6NkRsOEQ1Visxb2lmTTFkNlpDdkloSXZyVUhuNENxU3N1aTRYZ3I4?=
 =?utf-8?B?aFpOY2w1SjZQQUNkYktINDY2eFJpeURVbVBIZEpOdHgzaG4zQkJzQzRFWHFB?=
 =?utf-8?B?SmcwWEw0WGpxUnhWOXlEZGp3WVB3QjkvWVA2YTMrSUtVRHM5NThxY0NCTzdj?=
 =?utf-8?B?UGxnWlc5cEZxbWZyNG14TjM3NkV6Y0JmYmxoOG1FcEtnYnBoTkFLOG5RL3kz?=
 =?utf-8?B?dnNZbnZFTkF3SmZjbEw4NlVRRUtxSlptQWV6L25yQVlyN3paUlNFWVk0Z2tC?=
 =?utf-8?B?dVA4NWV3S1lsSmFlbE9vY3hKRytMLzJrQmdYZVpZR0JDbll5bFhuUzBPZmxv?=
 =?utf-8?B?emx3TXRMYjFMYXhYMEFqUTFvTS91K0NqT2Vhc2lpZVVENkRtbEV6Sm9xemFn?=
 =?utf-8?B?d0hSckJEaldJU1R1T0N5eU0vRTZocEUyN1NxT3B1OFpDcG1yejY3dFh3dDFk?=
 =?utf-8?B?Qjh0dDltUFU0ZDNGdnhyQVJVZGNocW9FQ1RYZE04anMwNlQ2TTN4dDRYaWkr?=
 =?utf-8?B?SE41bEcxSzJWQmZ2S01FWU9PRE9Na3dPeFdDeUpPNEZsdDRqOGZlR29MSDhl?=
 =?utf-8?B?VGFQamRMbThCL0xjR3hmd0pqQzJoTHhrOUFaTVlBL2FQa2s5Rk51aUw2VEQw?=
 =?utf-8?B?R25zbis0OS9EYjRHdDlSNHFOclhXRm1JZm1JZHBJNVNKNDVtNGpiZzVTUDYz?=
 =?utf-8?B?czdVVVdlSDZiMTY1a0xzUHBlLzRsUk5kdXd5Y0QxaTY4OEZ0dnpVUHYxQUVL?=
 =?utf-8?B?NWx6d1JTT2gvd00wWlZteVpVem9zMWM4dVZhUG1NNlVFaFJER2dUV0JhYUkw?=
 =?utf-8?B?aDh5M2xCRGV6cmpSeFBpcnVPcDhlaWwvOXA2WmFOQkhHYzlNTlZXbTJjMllZ?=
 =?utf-8?B?akk3dUcyUjF4QmU3Y0RCNWt2ZDNheFhLN0JHV0hGcVdpaGFhYUNxV0hYLzc0?=
 =?utf-8?B?cC9ucGYxZ0dZMEFKTkhmSDQ5VXBTeW0rRHpsZ29JdDZ5VGNkbUJGYWZaeFRz?=
 =?utf-8?B?enY4a2RYRWwrS1pTVlZoMGFyUDB5TmlFUFJwVnQxMWVIZzRJRWluaU9ZcG9X?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ea4e15-26c3-49d8-5e70-08dc5a4e8118
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:40:40.0754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKnELePbnRHnolJOvC3TIqTUwzqYaY8pet2M+TkBnvFwyAeWy7oXrKM2ODW0A4XyP5wDxHzL+0tfGf6kQ6kvmRK4Clbr0ExqK8Z2Pb0ugGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7823
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:38 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:24:35PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>> resctrl_arch_pseudo_lock_fn() has architecture specific behaviour,
>>> and takes a struct rdtgroup as an argument.
>>>
>>> After the filesystem code moves to /fs/, the definition of struct
>>> rdtgroup will not be available to the architecture code.
>>>
>>> The only reason resctrl_arch_pseudo_lock_fn() wants the rdtgroup is
>>> for the CLOSID. Embed that in the pseudo_lock_region as a hw_closid,
>>
>> Above creates expectation that the new member will be named hw_closid,
>> but that is not what the code does.
> 
> I'll flag this for review, but I'd guess that this can probably just be
> "closid".  I'll make a note to consider what needs to change to make
> things consistent between the patch and commit message.
> 
> James might have had other ideas, connected with the remapping done for
> CDP emulation causing the resctrl closid being different from the actual
> value used by the hardware, at least for MPAM (see my response on
> patch 24).  I don't fully understand how this works for x86 though.
> 
> So long as functionality is unaffected, and this patch is introducing no
> new confusion that wasn't there beforehand, the exact name may not
> matter too much(?)

closid sounds good. It may be a good match for what is expected to be in
general/fs code. 

> 
> Did you have other concerns here?

No.

Reinette

