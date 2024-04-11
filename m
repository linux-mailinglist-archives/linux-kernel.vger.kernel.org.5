Return-Path: <linux-kernel+bounces-140321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045C8A12C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CA61F224CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95A31487C3;
	Thu, 11 Apr 2024 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+8aCwvh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8311F147C86;
	Thu, 11 Apr 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834072; cv=fail; b=N8U93FSdHcR/+mInEzbx1mmlZafA8Y4l13A1mM67UwE4gI1FXHI1CQe/Yu+YvYZHpL0BLly03BYrmnt4HghXU4GBEnCQnvsT8330PWuEepiwx0YaVSZRBEpzV/4I/oh5BqtCe+BsSnvMXA1lp8pejJduW19GnMMv8jbI7Csrz5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834072; c=relaxed/simple;
	bh=5VTBFh0LEYoNQsPPqF89OvhVGrNRn9zxM8LvZPyhTLU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J+YrMx91xU/stjHdQLx7kEK6CzOAybldVHTSh5Jv+lnmGpqbprTi0lsDqdYjrMwxPAivxdYoKz0fpKGpMq27Nn2sGaW2AAydREQY1If5X4Wp2YYgOvMnJpzbZxVOr49NFgUBWVLaUUTfs4sWSF26A4hbQVtFgxM7eQ2dopBf+WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+8aCwvh; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712834071; x=1744370071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5VTBFh0LEYoNQsPPqF89OvhVGrNRn9zxM8LvZPyhTLU=;
  b=O+8aCwvhjs5MKMEKUxabHXLSNSb576c4dBHZXSwuefs5rn7BJDucoOEm
   B9CC3WrnFKoBHBK5Ol6LoWAWzH60e0rQiDjTjIGZP6mknwcXkVcyu8Eu6
   pfIZf7Al/DpTHDzk/7DvPd7RDclkc7QpqiMgKIMBXOlOxXSmiUEkT04bj
   YbLQ7DSuiZtnbZs0WZ4aSy8K6avsbDGpvKXZvo1Wl9EGn2tgZmyPw4AXX
   Ze4AUdenU2gxZhWxvBt4fhbaW++RdlqK5tKECHJctdyBgcaDbiZDrBmkh
   Owxro5tildAoNh5H+MkQmHVoNdinXwr8RIj5ztu+9tbTio16q/MLkWUUf
   g==;
X-CSE-ConnectionGUID: QglIWYJGQdCJr2szo4n54A==
X-CSE-MsgGUID: n5GXrKP8QnK0K0PA15/avg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19628130"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="19628130"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:14:29 -0700
X-CSE-ConnectionGUID: x38YZeh4TrKVBwwLFhVUVg==
X-CSE-MsgGUID: pgFnCclMRrCyN+CQiqnO6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="58289634"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 04:14:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 04:14:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 04:14:27 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 04:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBCnBFp9a0JzWouaVb1ljtyql84Nz52/TpW7N8601wgLd5xuNDDJQQ+p+rOqeZAv9rQYsQsNw0ZjS5r/dfnL62vOEw8lWgAzbY0R+L74hW+cuuKyJv2e5XfInWM7mNGoM5SvH1aN3XDmMECBLkdnOFRhYkN2035MR1o9Wp9vbjzQs40NFI9/A1k300b+AQfCvMCf0FY43OIvNghccm3ZW6aFM43lACPeNPWNd5i1ZKRLtk/5+r9K0sTxqr5v91F3c7CWuzpa98oIGECbWthbxqnXm/WJQryoDycG4Ztc6fc1iB2FjqDVjQC0cz/TKHHkqiKNswl0fUB2qgxsm1ErHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip3hW/vcmTYKwOYaFixe4kuqqG8kDKt4sA3lkuXVue4=;
 b=SBljyebddpGmTChmlLtC+BsvERNZ09gxogtYYLwyoA/Vt+nq9tmuVUtv2NLpf/c8ie3iQ3eGCvc0sSQjN5tHIlL4CF38eW7RzwikaQFGlORBuz1aP49/503VxEpA7gGSsBoDMT7JlQKww61K0x0LN5GAeiGhcCcisG8FQdbjBKl4CRi/A8+5ZCMle//i8oe8WZ5hHLVs3CMbmfPIwlOIJ9lpHwoqIHFFGMto7u2BZQHZ+ScHsI/UYDqdQTX6zJQ1aSC7GCThNBDAbf70a/PXy+HMcpN0uH5TBOS6s0328Tn8teELbja5bcT/iiL5BT/pr2MEDDq1Q7fJIiAri1HAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7676.namprd11.prod.outlook.com (2603:10b6:610:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:14:25 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf%5]) with mapi id 15.20.7430.045; Thu, 11 Apr 2024
 11:14:25 +0000
Message-ID: <b9804c32-9ba2-493b-bfb8-a6ac4f108175@intel.com>
Date: Thu, 11 Apr 2024 13:14:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: fix struct_group_tagged() parsing
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jonathan Corbet
	<corbet@lwn.net>
CC: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>, "Dan
 Williams" <dan.j.williams@intel.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Keith Packard <keithp@keithp.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <linux-doc@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240411093208.2483580-1-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240411093208.2483580-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0283.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: f055befe-3372-4460-5566-08dc5a188be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ni/yvY+z4xjvcM0OAStoUthllE3AiWYEBRLpMjHk86WeCm5dfWzWD5fgFEwesLmeYHW7JpbefOZQsFhenuXlWqy1kY13MwOb+vwFcR+dmvZQ3lcmSnxxY9DgI5yL9lE9wYBa/1o5iiTPk5axLjHl/yq3hYJZUYBse+HlzgXfnYKFIdrXGQ6MQxKrf8fE19ety/aMN9mN0hhKPPLx8xBA+Eu86rZ39ZJI2eVJVY2lB/eDBe5ZVbo0yjXbznvVbj5j/dK82TU0UEfBcLVf6YxMMGwGspt/Nu/JJfPSmUy+hTuwm7yDCLgsnHT88d9pGK+HOFDpHgCPBh5yPO2GNpRZ1Io/YCdUZZCV1ro7pFBEKwsBjvT+AIecqhg2bEUazi9xUDVX8ahDWO9oyJjqW8v7NePaGFK/k0p9LWmzORs8wICSUKfkEMueZTVplDNegQ9aw2g1vqCno3KgKOd8KYATaiHJCmasatfdyxte7c8c85hPE33JigI3nUjsom4jH8vKrhy3qDo8Ni6UpByhh3ROdeoT/2Xup7cXa535Hwrclj7FXQPZGtXJx9Z0T7yDfB4I5mJMaa2a/RQaSoN48NuKvxH4n/QnajBN/jQFRhyrhhER30KdVUiKq4BEw8i8CjMiajxZbRPIv4oDNStGa0UvBZYx8fxOB5MXdOtbMxVUW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2Z1SUZkZFNQYjVEODQ2aDM1cnh6NlRTeU1Vcks2eU92ZEVWN2xZc1QxbHly?=
 =?utf-8?B?VFBoSmlya0FtSGxFTDM0TnB6SERlL3ZzWmlzdS9rUVZnRkxaNTV1ckRHb0tF?=
 =?utf-8?B?OTA3TjFkYVQzYVNjV2FLUmhBUGtRbWIwbEs1dStCaktLTnVkejZKWmFnNUdH?=
 =?utf-8?B?T2xEOWV6UUw4UkQwWDRhVzdMWlNuZFhFS0I3MlAvbGdWclQ3SUl2OGVLZ2g4?=
 =?utf-8?B?azZLdHBMTlpBdjIwZ2FKWVpRLzRML001Q3RCSlphQjZ1Zjd6SkI4N01NZFZo?=
 =?utf-8?B?YnpWWm5xSW9oaTRPcUp5TEhHSTFhaTRtMGI5WmlZV3p5bjdtaW5SdVVmeEky?=
 =?utf-8?B?UUMxbXpyaGIxMUoxYjl2ZjdwQ1FqQW1YTm1VUlVkaStkakFwMmZDdkpWSitl?=
 =?utf-8?B?cVA3NFQ2eDNCRUNyQW1zNHJNYzQzd3Q5QitENVJmQXZmbW9sS1MvdVVHQVFC?=
 =?utf-8?B?RlkvYVFyZWx3QzBwZzVZYlNtYjNIOXp0ajdGV0QrVVViaWVBdUcyOEFJQzdP?=
 =?utf-8?B?K3RwcWtuL3pxb1JwclhsYSsvUjZtU2p5WU9pS0NOdUdLc0J5NFd1eVJVdU0x?=
 =?utf-8?B?ZnJuc1hvNk0zYjZCcE5zRmhFRXExQzl1azNxL29Rd3pvNHBpSW1jOXFkdUVq?=
 =?utf-8?B?a0o0amFycVprR3hUMjNZZTcyZFBzaEJNSDNlQ3lTZjFHMHc2dFh6SWRURnBq?=
 =?utf-8?B?YXRJZ01aZStHcmdRUEs0dXpUTmhPYlhGNkNGNmUrbC92ZHlMbGwrSjNYc25w?=
 =?utf-8?B?SGJPNzZxVWlBYjJDZlRjbWVMdU1pRjdjUWlNcXRacjhWcHdwR3FUNFgrV1Vy?=
 =?utf-8?B?bmpUaC8rbTR4VWE2UHRibG15K1BmRDVNSC9Sd00xZ2hDTjh5bmhYR3ozM3NG?=
 =?utf-8?B?azlaenQzNFVkbU1aWjF2aENoNXhxMGhpVnF0NWN1bVZvaTVqbFV1MU1sTnQr?=
 =?utf-8?B?UFpOSmo3L2RvVHdTa09mdk10eGFSZFFMQmxJNm5kRjc1bCtFVmVwSVFzc3RB?=
 =?utf-8?B?cjIvUElrQ0RJam5FaWF6dE51bUw2aEJYaDdVa1RkOUcrZ0oydWY3ZnBLZjJM?=
 =?utf-8?B?OEJVeEg4VGFFaGlUc1FyTzBWR2crRUF6OVJ1L3B5Y1ExU1FqbnFwRDQvRCs3?=
 =?utf-8?B?WWNaKzExYjIrT3UrQXFuL01od0l2ZjFDcmoxaVBYRVNTZENZaW92WXpkajdo?=
 =?utf-8?B?QUs1bGVvQTFwYzVMOGVjaVJ5RGdsRGtQK3RYbElKU1hNWEczYnpmakZPdFR2?=
 =?utf-8?B?YmZjUEJWcXdVd0ZyRmVjcGkrcEkvdHVvdkdQMVFHS3NCakZoWWFuRVF1K0Ri?=
 =?utf-8?B?bUVqVDNhZmdHMDFSWk9va09tdldONlNDNGNtOElsRlZRNTJodk5NYXNENGFr?=
 =?utf-8?B?MklWVHJ4VGlhVUhUdnpuVEVkL0VZMGhabExEaUFyTkJsV25Yc1I3ZVdZdGZT?=
 =?utf-8?B?MEdOSDFQaHJCYVlxREQvbGY2SmJNQmNXMnY3amh6N0JCVkJrZ0Z5V1JjM2FL?=
 =?utf-8?B?ZUVWRURiekFuOE1LOW1ZdTEwTlVRY0h2b2szTllLRzQ3NHFkOUp4U01MTVU5?=
 =?utf-8?B?VUZnUWhyMnBydkZpZnZjRVdDeTM0N0x5bHpuS1VwQ2E0Ri9yc1VFdDVGWlRH?=
 =?utf-8?B?NDUrZ2ZmNGF3ckdXTlB3Q2ZlUit2QWMxVllxSGpzQk5ONUZwbmRZQzE3SVkv?=
 =?utf-8?B?dlcwRUVZSTlmNFVOaHEwMWRqRGN1K213YmNJYVM3dmcrTHcwR0V1cXliN2U3?=
 =?utf-8?B?VW5DME5uYnZVQ3kxZk5EL1N6dHBPS3BhNDAwTkZ4dEdIUlJxcGhMeUQwUTJQ?=
 =?utf-8?B?VGJxK3g3V0dvLzJacEpnbjdpeWpUK0E1WFd3QVZCN2hRUVM1aDgwNUUzeGdp?=
 =?utf-8?B?cS9EdGtzUVFZV05MMzlMV1ZBck1uRGs3UjFSS2p4QUNCZGhWK1NjQXlYTFg4?=
 =?utf-8?B?WE5ZTWVzRzEvZXVmb0VGMXR5NStFTG1CTmh1Mk1RZFh3UmhKTGs5bkVjN2hm?=
 =?utf-8?B?am5rNS9jRFEwWVBQK0hUNzlCYUs2bm1JZGx3a2J0c2hqd2o0SzNHR3N6UDBq?=
 =?utf-8?B?dFF1SkpVajcyOU1YdFdJY2lxSTR6ZEhXSU84Z3pMUnBXaWJDM0hzQ0g2dHF2?=
 =?utf-8?B?MGtNaUw4VVpPS0dWV3dRZlViL3FPbTlwL2dsVmxITnlJNGd3S1Z2aElUdlh5?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f055befe-3372-4460-5566-08dc5a188be0
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:14:25.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoUPlXdZX9GCrrK3dhJeUKGIDQtyuTzK1vvemvCdDfcP5LLWTReHJLmWcBHxXcec4Q95/BeNzDZK0oMs6rkNPWMiTjKvDzXuWbYjcPYPIfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7676
X-OriginatorOrg: intel.com

On 4/11/24 11:32, Alexander Lobakin wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> kernel-doc emits a warning on struct_group_tagged() if you describe your
> struct group member:
> 
> include/net/libeth/rx.h:69: warning: Excess struct member 'fp' description in 'libeth_fq'
> 
> The code:
> 
> /**
>   * struct libeth_fq - structure representing a buffer queue
>   * @fp: hotpath part of the structure
>   * @pp: &page_pool for buffer management
> [...]
>   */
> struct libeth_fq {
> 	struct_group_tagged(libeth_fq_fp, fp,
> 		struct page_pool	*pp;
> [...]
> 	);
> 
> When a struct_group_tagged() is encountered, we need to build a
> `struct TAG NAME;` from it, so that it will be treated as a valid
> embedded struct.
> Decouple the regex and do the replacement there. As far as I can see,
> this doesn't produce any new warnings on the current mainline tree.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240405212513.0d189968@kernel.org
> Fixes: 50d7bd38c3aa ("stddef: Introduce struct_group() helper macro")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   scripts/kernel-doc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 43a30f2de513..01ac8f794b30 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1152,7 +1152,8 @@ sub dump_struct($$) {
>           # - first eat non-declaration parameters and rewrite for final match
>           # - then remove macro, outer parens, and trailing semicolon
>           $members =~ s/\bstruct_group\s*\(([^,]*,)/STRUCT_GROUP(/gos;
> -        $members =~ s/\bstruct_group_(attr|tagged)\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
> +        $members =~ s/\bstruct_group_attr\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
> +        $members =~ s/\bstruct_group_tagged\s*\(([^,]*),([^,]*),/struct $1 $2; STRUCT_GROUP(/gos;
>           $members =~ s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/gos;
>           $members =~ s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
>   

I would complain on code that matches `[^,]*` part with 0 characters,
meaning no tag for struct_group_tagged(), or no attrs for
struct_group_attrs(). In such cases simpler struct_group() call should
be suggested. However, that issue was presented prior to your patch.

This is clearly an improvement, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

