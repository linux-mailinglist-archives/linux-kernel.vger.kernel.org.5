Return-Path: <linux-kernel+bounces-156480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0808B031B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1709B1F256E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D8B158218;
	Wed, 24 Apr 2024 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xzh9Vblm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4B156C60
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943318; cv=fail; b=gFq5g15MGzara77lTyEpSuGHrY29DZb2uHZPGJYa7qs1DCIV0hqo8OVRd95eIrcDTPa3zTMcvpafQpS9sR4WrJ3zqmDTqBCsbzgmpjx2jloR9KifgDkFLEfHu1rIYKHX1tPLd3FWA6GbKte2ZS825DVnZH5xnIwWN3yCQOBmeGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943318; c=relaxed/simple;
	bh=bPrD0bmKmOxRJEHcxRgNj2A9J1cZUG6d/bN6SrEUzKY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VCrFpBrq9csZbpqgd2driE1rt0HWacsFlkRcH0ymL4W29Fl9CpnM04JKqp2MK/f/p0jq0K7eLigu6FnqDWUY6afIRW+Pw0RF21TbASRYBz9tH1CeyWk/C3x6RkabVNEGUeXjDeUd5iZjFqd90K8Zt207clEDAme3h+M6W08utv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xzh9Vblm; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943317; x=1745479317;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bPrD0bmKmOxRJEHcxRgNj2A9J1cZUG6d/bN6SrEUzKY=;
  b=Xzh9VblmI6ECwTD8j3ejQ8PYJbPo8TcuqwNPo5wDWOC9t6YRDywYLOlU
   YfKNa7BgqtEPqy5LH0mGotRNfeWzB9wrFfPLoi9IhWyN81Xz3hv98CI/B
   Af/M/mdk1QzZ+8lmphrEu0JJlXC4Qybloz8h3AHO3RGf7C8lCYxxOvMb0
   4Ns+KGxeWn/Z9HJ8W4ghDJVx70Zl44RRfK64UGD+36OiWwoVj9BN2Ns+9
   DM7nYb5WXxaGHGKtkVUI8ZshMtrt+u/OK9ONb4JgMjKURwM8fqyPjnpV0
   VexFftZyclBRHj22kdqrZzn4QBX0azMM1l+I5CAGzNs71WVHKfQUVR/8E
   w==;
X-CSE-ConnectionGUID: RZNsLDXjRuuNaJ/nn+f8pg==
X-CSE-MsgGUID: fuvOpd+JQeeK7yFiZxNP0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="12491952"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="12491952"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:21:50 -0700
X-CSE-ConnectionGUID: nDmTK1U1RTaaLKUyHkCNDg==
X-CSE-MsgGUID: /OSGfX3NRwiGhVxJUNqw+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="25226794"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 00:21:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 00:21:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 00:21:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 00:21:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 00:21:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4ZQw8kvofkM+ZhNopYLgnMO7LUSl8Xi1gqt5jVuUnrKxXAeTrNB+psf+XW2DKD+tjEJDb1iaqzj+K1EPSYKbFlqpgfT6ZBkW0j47OI4SyaYYMfUPQImH/AaqF9G+B9d70TkK6yv+s42daCAh5MAsNy9bwE2LfeheNWOZFRuF8fXMrwWb1JVi8jmjWBmJG5Uwt+eIbKzE/Gq1+EKQqkElOkMB3jVN/yJTpMMUvvLEACmIP2Inv5TvWCvy0ZwZ7FKRUhg4RKjCb6L2of7/7JANBuahol7P147mfkThcS+vgXp1GEsmW1LlF9KyLdCKwrWch3wNT5E06iS1PFFcAtpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xU8Tmm+xAomIwwyttK3Xwg8kBWk7IpyCQ325IiGVZ38=;
 b=lWiebcSgioalSs0gOGWknllqkkQY0vE3QG37Vp45cDUIDYisc4m35QHYXonn36m3QI47IPRpQ/cOau+PcVP6fIUkYvwkD5r1BMmqKidJEyBykaeG2YMVxO0duTo97kZObUw6iKeS/3lbc5e9ioYCEE9K+K00lPjvbQjVrq9Z6cqNG85BnDYGS04rnnnI6kPIkLL5ZgULN0KQ2l+tbqO6Y5LwC8vsXIUF3JPZ0pfWrAzGVmnY+9SUB/FgwZ9CY46s5UUj8zLCpFi0d38L3nO0p8dCpikaNbQyx6IxU5vtqLll3VTS/u36zcPdj2++imV9d+1e3JoZR7Ll7YYNZDq4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12)
 by DS0PR11MB7621.namprd11.prod.outlook.com (2603:10b6:8:143::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 07:21:47 +0000
Received: from MW4PR11MB7056.namprd11.prod.outlook.com
 ([fe80::ff2a:1235:d1ba:4f93]) by MW4PR11MB7056.namprd11.prod.outlook.com
 ([fe80::ff2a:1235:d1ba:4f93%3]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 07:21:47 +0000
Message-ID: <a922af6e-7b57-4802-809d-72d36c0b468f@intel.com>
Date: Wed, 24 Apr 2024 12:51:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH CI 1/3] drm/xe: Store xe_he_engine in
 xe_hw_engine_snapshot
To: =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
	<linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Matt Roper
	<matthew.d.roper@intel.com>, Zhanjun Dong <zhanjun.dong@intel.com>
References: <20240423160626.77110-1-jose.souza@intel.com>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <20240423160626.77110-1-jose.souza@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To MW4PR11MB7056.namprd11.prod.outlook.com
 (2603:10b6:303:21a::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7056:EE_|DS0PR11MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac8d340-234f-47fa-8876-08dc642f33b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3FtcTN4UmRQSUlHVGRtbjlhakF2U09VV2lMOVRIczNPKzJ5cmRQdVNabThx?=
 =?utf-8?B?elMzTmhjaitmRWQzL21JVVp6WlpPV1BCRTVvbThVVW44S3UrSEkyb0VOZ3dZ?=
 =?utf-8?B?SFdIeG14eFdmTGlWRE16L2F4c25vMGQ0eU01TTBXUnN3ME9TRjdPblk3eTJh?=
 =?utf-8?B?MStlOTdVRFU4SG9PQ3VIaU5WdDlTSXM3NGs3cjd2QTdneVVPTW1RbDd6ZFZp?=
 =?utf-8?B?Z3lWRDNSMnFvNG9VTnNIZld5bDhMSDNTZXdQNXkvcFdHZ05LYWlHTVFLUE0x?=
 =?utf-8?B?UUxDNWgzOStsM0xxTmlRb3diVzF2QVJGY0NZVUV6MjlXSGUvdHg0WGxHUkhz?=
 =?utf-8?B?UVl5ZTltdU4wVkZoOERPM3YwTjdmaUh3MlNhdGtlRHRsdFMvRWNjMW04ai9B?=
 =?utf-8?B?endrNkNVcGJsRUljR3BTMEZHam9ML3ozNGJIcDlzeUo4SUlpK2NESHdzMC9w?=
 =?utf-8?B?QWZhUnhnMVkySWFDV1d5UmR4VEFDSlVFSFNDelgxeng2UjV2dGJBdXVHL2Jq?=
 =?utf-8?B?bHd3dFhvM0FqUE5LRXZUNlVIL1lZbVQ4RjVoeU8yaytJNEh4V2dITWIvVEVP?=
 =?utf-8?B?VkRYZWl4b3Q5Q3kvaTJzaWhzZ0VWTHlZd0RUNWlDRjR5NDJvbittZW1MbnFV?=
 =?utf-8?B?VzF4S2dIQUxTU2U5eWw3Si9ybU1UWVJscnYvR3h1WVl3Sjg5VW8wTEYrRWZ0?=
 =?utf-8?B?MXFUbnd2TTJTM2dERjFsL3ArMmRJVVNTNC9Xa1VlWlFTUHpwcjdpVlIrL2NS?=
 =?utf-8?B?bVpOOFFEZUo2UzNhMmhQTFVTQmJWdUplVmlnL21IUktrbVQvREhFWldYdVVO?=
 =?utf-8?B?NEQ2RmZBcm9qenlmTGlKdjBnRTkrVXpYVG15VGV4dzVkMTA0a25FazlRUm1N?=
 =?utf-8?B?NXZLcGUzR2R1YVhURUtab25yQXNFMG1wODNUY1F1byswZER3ajBTb2Q0Z2dr?=
 =?utf-8?B?UFRtMEQ1TkNMNjcrVjM2V3ZJK1BrRDJyVTdxUDNQaXY2Q0RzU3pJM3ZUb3Bn?=
 =?utf-8?B?OXdLU1kxZXU2M0ZITm9BWFpzL0t1cENyRHlQRnRTbGUxaVg4eW13RHZYOWxu?=
 =?utf-8?B?S1ppRThrY0lsKzZQOXpNUFY0SFFMSHFYcGlTS05OTGpxc3pVbnR3WVJVQllJ?=
 =?utf-8?B?RFlMeEQxbmgvWCttaFk1WlpqeEhDeHVVWkF4ZWN1WlcvaTdvVTYwWk56YmVi?=
 =?utf-8?B?QVVoNnMySUc1OUhnUjF0ZkVXaWhSNWszajhMZW4ycDYzRFFNNTFaMHpBaUx6?=
 =?utf-8?B?UTd4SzV3bFhOdTUyeEttSngwQ25tRHN3NVRWNUNFZUF6N3gwUnBYNEZ2eVhJ?=
 =?utf-8?B?akdtSWlhZzZYQktHeld6WGVFaEFjVCtVSmxoWURwRXZmR3hCRnRML09sMERF?=
 =?utf-8?B?SE1iOStkbzA4UXE4ZHo5R2VSQU5MUitWQThIRHQ0WlBVNHZIRWFTSVBGUUhB?=
 =?utf-8?B?cGlsaGJmNE5leXQ5ekk1MXlBVkRVcVhSc1RaYW5DbkNmdU1OeUNmdkMrd01l?=
 =?utf-8?B?aXZhbU5CelM1Z0lIdS9VM2JFbHNIZGRWbVVPTFcrQTdPeHB0Z01mdTNBU2hS?=
 =?utf-8?B?eEhpaDFOT09veGl3OFdYaGhLcDBXV3YyeDN4WlFNVi9RK1BkQVZrcm13K3ln?=
 =?utf-8?B?bnQvdHFianBGYVY2OEhSVWhHWjBLTTdEQlA1Uk1UdGtFR3RPVkFRRXZpS0ps?=
 =?utf-8?B?WHl3T2RYWTVMZXhrYmUrNS93RTM1ZlppblFaN0doQ0IyNy8yajk2cTh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDFBZFl4cUZJQW92dGlBUXRlNWRQczdlcUdmRnh2c1o1bGVpZEdONklVSXdD?=
 =?utf-8?B?Z1VZc3Z1bHNUMzdiVTkyN0tBUkRJRVNpMHNhTyswK1VYVTQ5TTNLekgrdXA1?=
 =?utf-8?B?cHRjM3k2cG9QNmFJMHdtZ2xrZEtPTDdwSWM2ck1xQXVDalRtSHpxNWRHWG55?=
 =?utf-8?B?eWZYcTIzZ1FBM2NJN1FSZm5sem5sYnZOZVhWcTVpYWw1R3dyTGxBbTF1WHdZ?=
 =?utf-8?B?S0U4RXRaOUNaQ0hWVlErNTVmcDRCL2dmR2JxdzNLVXJSRU9TYnY5OVh4TGN0?=
 =?utf-8?B?cUJDTEJjbWJmbytrTlRwOEVUTW9XclMrVk5vYzJuOXJiVzkzdmpBS0hTV0Zp?=
 =?utf-8?B?bldSSGZyMGRpSXg1QklqcmJKK1N6bEJGWXVjRFBWQlBzM3RsMi9NeGJOK3Zl?=
 =?utf-8?B?OEg4TWVhSWZTdzRTY0Z6TjExNFF1cTlJRjNKU1NwT1d6VEsxN0g5NHRXdDJq?=
 =?utf-8?B?Q3lXa1JEQUMzTk4vZWJjV0YwbzlBWEFER2I4VGVuUjRoeExXSHhBT0dNbzlY?=
 =?utf-8?B?Y0h2ZWVMWjlBZGNNWGlDSXZvNUh2azRjWkk3V0xxaGpyeUJ4ZU1EVkJnTHpn?=
 =?utf-8?B?UmZ1dGdPTWN0YWo1NkxQSkpoUEJHWXc4MTZPQU1jT29PWE00VGswd0d4VVQ5?=
 =?utf-8?B?cXJUc2Q3OVNZRlpDdnV6NEs4bVY4RGVsRkVoV2hpTWxkb3hTWkNkYzI4dUlU?=
 =?utf-8?B?RGFuMzg5YXRKQ2x1ZHB1WGRqY2FRUXR3WXlvaGYzb3RhWGU0YzY3Q3QwZjJQ?=
 =?utf-8?B?RVV2U2srcmpJMEs3a01nYWtveG8rdFhBSU5Dd0lVKzlMc05CMGM1WVFGM2xv?=
 =?utf-8?B?a0ZmR3htUTRhUWZ6dzIvUmc0cjA1V0NONmlHdHRDK1E4SDhpdEIrc09vSUJy?=
 =?utf-8?B?dURuT2trWGk4bHFUOGNpYVlRUlE0VllQVUg5WnpKam4yMlpZQTFjSWd0dG8x?=
 =?utf-8?B?cGRCUEFhamVLdE5yK0tlVmFQNkJWVEw0dHZqQlhvYUp6ZkF4dlhnRFNYY09N?=
 =?utf-8?B?a2t1N2NGOWJWeTVEUWpNT3YycUxaQ2ROWGdEeFUrcDR3TjRTTzhTbmwzMjkv?=
 =?utf-8?B?R2VNbllNckptaXM2TnZnKytxM2ppM1orenZWUHJ0UzQxd05CcGZVZTVaZ2hs?=
 =?utf-8?B?YmNUZ0hLVVFxTFFreHlyMkRSU3V4ZU1WNVRRZjRPV2RLRFdjcCtqUFE3UFNE?=
 =?utf-8?B?YWhURGc3OFFXeGprUDluVCtsR2pOTlJqR0pqSUFuOFRMNk5Lc2ZaNVQ3RWtF?=
 =?utf-8?B?YlhIdUZPM1l2UlVjbTg0UmdWckZhSTkxNE9RamtEampGcDgxYWZMVjdFTGVE?=
 =?utf-8?B?UEJQVm92NU8vMW9hTlVmMTFxUmdHU1I1VFJEMzA1OEgvWklMZEk5cU9Hb0FE?=
 =?utf-8?B?elByS05xK0FmWDBRQW5uY1B4a0FhR3ltSkpUMC9lTGY1aDF2MFRRYVBJWGNv?=
 =?utf-8?B?TW9yWFk3U05aNFdSTXhmcEpYUUQrdE5UNEZ4S0gwK2w1TTFPdEx3TnM0WnRt?=
 =?utf-8?B?bUh2Y2ppYU03SVp2TnVnWk5sd0JvSnNPSXh2TDdOMmcyNU1UY3hINE1yYytG?=
 =?utf-8?B?OWMwRDRpbGV5R2c4MkI2QVptZUN4NUNBUUVjTURmWUxrREdIV0ZnSVhWb2I3?=
 =?utf-8?B?VE8rN3h6ZXZKdDZjWGcvWGlxeXN6RXNOSzVMd3BQNGRUZi8zMUJZK3VDUUd2?=
 =?utf-8?B?MC80NUhaelh6ZTVKci9VcXphczY4bndoUHhTRXczTVFvM3hYMTZ4YXlhcjBp?=
 =?utf-8?B?NkptbEFaVVM1bmxKZWZ6aEUrZGtFcTE3YTFpd3c1dGc0NngzNkhad3BCTGcz?=
 =?utf-8?B?K3VCYmNxck53VWQydTdQTVBHZDVGRENoTTJpZmdNZCtoUXVteUNGckJScHJx?=
 =?utf-8?B?dkxHRjQ5bGY2RlBCeksyK1ZhMmlqMnRQelgwU1lQOGkyeHFrRm1tU2Nlbkx1?=
 =?utf-8?B?cVpPTUk4WkpHdWw4SlBPbjVuWW1XS1pHRGUzZGYvdUpUWXVYaXdSbjR0WGRl?=
 =?utf-8?B?ZjFKWU5mNFZkNGJzbHJPKzNob3V5ak5pWUQvM0hjZ08rUGRHQ3dJTWZoZTlO?=
 =?utf-8?B?L0JLeEF0bk1nd1dKQTEvbkRDNmZid1VjSi9CUUdtWTZjQnVzcEh5d0tSUG9X?=
 =?utf-8?B?MHBZT1pJWjF1UDZlWVJ6MkdEYys2bEFGQmFBRVRzOURYN21jMFhWSEhBWGRP?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac8d340-234f-47fa-8876-08dc642f33b5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 07:21:47.6542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPTPqbSLJbW9iAVzYiItKUKFKok4BItgdOEoYy03Wchgn8LlKCYg7r8QyKeX92KahtzjWvJIjPqWpdwoOOT45+EJ/VQlkdGjncaGRFho+4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7621
X-OriginatorOrg: intel.com

Typo in commit.

s/xe_he_engine/xe_hw_engine

On 23-04-2024 21:35, José Roberto de Souza wrote:
> A future patch will require gt and xe device structs, so here
> replacing class by hwe.
>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Zhanjun Dong <zhanjun.dong@intel.com>
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_hw_engine.c       | 6 +++---
>   drivers/gpu/drm/xe/xe_hw_engine_types.h | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
> index 455f375c1cbd6..c84dbe8a8ed1d 100644
> --- a/drivers/gpu/drm/xe/xe_hw_engine.c
> +++ b/drivers/gpu/drm/xe/xe_hw_engine.c
> @@ -791,7 +791,7 @@ xe_hw_engine_snapshot_capture(struct xe_hw_engine *hwe)
>   		return NULL;
>   
>   	snapshot->name = kstrdup(hwe->name, GFP_ATOMIC);
> -	snapshot->class = hwe->class;
> +	snapshot->hwe = hwe;
>   	snapshot->logical_instance = hwe->logical_instance;
>   	snapshot->forcewake.domain = hwe->domain;
>   	snapshot->forcewake.ref = xe_force_wake_ref(gt_to_fw(hwe->gt),
> @@ -842,7 +842,7 @@ xe_hw_engine_snapshot_capture(struct xe_hw_engine *hwe)
>   	snapshot->reg.ring_eir = hw_engine_mmio_read32(hwe, RING_EIR(0));
>   	snapshot->reg.ipehr = hw_engine_mmio_read32(hwe, RING_IPEHR(0));
>   
> -	if (snapshot->class == XE_ENGINE_CLASS_COMPUTE)
> +	if (snapshot->hwe->class == XE_ENGINE_CLASS_COMPUTE)
>   		snapshot->reg.rcu_mode = xe_mmio_read32(hwe->gt, RCU_MODE);
>   
>   	return snapshot;
> @@ -887,7 +887,7 @@ void xe_hw_engine_snapshot_print(struct xe_hw_engine_snapshot *snapshot,
>   	drm_printf(p, "\tBBADDR: 0x%016llx\n", snapshot->reg.ring_bbaddr);
>   	drm_printf(p, "\tDMA_FADDR: 0x%016llx\n", snapshot->reg.ring_dma_fadd);
>   	drm_printf(p, "\tIPEHR: 0x%08x\n", snapshot->reg.ipehr);
> -	if (snapshot->class == XE_ENGINE_CLASS_COMPUTE)
> +	if (snapshot->hwe->class == XE_ENGINE_CLASS_COMPUTE)
>   		drm_printf(p, "\tRCU_MODE: 0x%08x\n",
>   			   snapshot->reg.rcu_mode);
>   }
> diff --git a/drivers/gpu/drm/xe/xe_hw_engine_types.h b/drivers/gpu/drm/xe/xe_hw_engine_types.h
> index d7f828c76cc5f..27deaa31efd31 100644
> --- a/drivers/gpu/drm/xe/xe_hw_engine_types.h
> +++ b/drivers/gpu/drm/xe/xe_hw_engine_types.h
> @@ -158,8 +158,8 @@ struct xe_hw_engine {
>   struct xe_hw_engine_snapshot {
>   	/** @name: name of the hw engine */
>   	char *name;
> -	/** @class: class of this hw engine */
> -	enum xe_engine_class class;
> +	/** @hwe: hw engine */
> +	struct xe_hw_engine *hwe;
>   	/** @logical_instance: logical instance of this hw engine */
>   	u16 logical_instance;
>   	/** @forcewake: Force Wake information snapshot */

