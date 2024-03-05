Return-Path: <linux-kernel+bounces-91795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA07D8716BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317EF1F21D64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8707E58F;
	Tue,  5 Mar 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nE3R2q3B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739534C637;
	Tue,  5 Mar 2024 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623702; cv=fail; b=F+6q1mAAaAoNVYv3sQmMFvGmplxb8gjA6qfDPQgri7yigDfQpgxAhRSB/Hg/EFKW/225dEcNUapRCZvKV/R8rHIg6hCMl4BWjfKFAH4lLSPjxkBr2KVKRL7f0xbhrlwRVHmrValW4A+C2bsXpxNfmygTmshQAJlANPK5+IkPJQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623702; c=relaxed/simple;
	bh=WkqcFpqxfpN/KhsrEp3L6K8bNd4N5VP7218yHWWjXug=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tdjFSo0/EyzsyGd5BiNfakYJPcbvUS71/kBlr6rZfAgkrXTPAe986dX2UgpTpuZBSYXd/945AWkPR84HOYw0pG/o9fb8r3iedyLdzHnfCaTUz6p9mAQrKDIKdyglBb3wwDx3OievyvrVJkVKD/+IZST7GoIWneKD5tArf+3KC3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nE3R2q3B; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709623702; x=1741159702;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WkqcFpqxfpN/KhsrEp3L6K8bNd4N5VP7218yHWWjXug=;
  b=nE3R2q3B4C/jnSR5+hiRCmzdBqPogFZJYTH7FauvvZQpDpXRBdnSRf7o
   C6u83roATfbAo4ePwuPBMl/9D53Fz6bD7AmpdzpKcFgtWHPoVbt6gQAkZ
   LJOcCEVUdfNmjRw8aAM80VIesRcl0zItnOpu8gZQOCz2QFBFuybzFKfM9
   uxvQphqfEe6OQlmOGlACt+1PW79c4sLWYU5foX4RWB02eIla03y6K5LdP
   DSDRZn9GVitJ7yqV5SHDV20v+z49hxCUhBYRCTVWfQtfS/GBvJonuCgdh
   9piGKH7spleF5/0OKTWZ9mSf8iULKU6lkfCE/nwI6H2aCn9Aii5lL1Ao5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4325129"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4325129"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:28:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13964692"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 23:28:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 23:28:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 23:28:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 23:28:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 23:28:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DENz2N+1/DEZuZI1Rx/zULhQHy09wohv3aowf3ZikEmOepxFepvutj5SAVwSxuu86UaEhl2k/LhGFyhwzGgLlnhX2w2rVBGoz94Yg7LXvqpEHddIZ//8nKcxJMOfAbow0a1qXS72Gaohz4geQx0pYsJ95yKgU+ewz8dJanbfNc60LVubBjLQHSSHBpsU/BijFuOxRl3oURUXuVlkZnVmFEft8WkIdVkxiMCqGy/ayDgV/ab2k1YCWWuBAMZKWOgdZYsPqdwqy8hFUJqc9q3fJ8E+d0jZ515qgmwVgh/uMwkbe5N3Tp+uNdsVV6n0Slq5/ROKZCfa3dkTkuTRcUUh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7JNxqjbVgRvOYWf7FxVIkapxyvxPzYlhrvlMKN9KRU=;
 b=DeUPfKRdJuCGTYf31KA17xl/KZlQhMgxrYyd6Y6tOi1ZCENhS1MFoiImKarjx/0+qENbSWY7UexPtc8HiU6pqrilcwMoKV/WwE6bNgbX1ZF69RhH6kDG/U8UBI/NtI6hKz3jYMMtKis8v+jrCcDCourcQBobzTZKTLkZtHKMEewoZQGkz9bx3MPwfTbNfM6W96Fzw3eoHYqRlaXibuobiJu03abbNASwjLfMv6d7y5L3uxKx56nkyPUflSBH1SQWryR3QBuQllMYZl16XnLaNwjdfHcUMSo4V6oMcXn+OK+is5wEK/bOZ+0OGS6qvYMLyXGwxvD2NUUO7aHSvSa58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SN7PR11MB7565.namprd11.prod.outlook.com (2603:10b6:806:344::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 07:28:14 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 07:28:14 +0000
Date: Tue, 5 Mar 2024 08:28:03 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<x86@kernel.org>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: Cover-cover letter for two resctrl patch sets
Message-ID: <zhfckkyc7yr57kdcru3x4d2btuqq5dp3x5qdv26agfq2tlai4d@ice7se7vfctp>
References: <20240228112215.8044-tony.luck@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228112215.8044-tony.luck@intel.com>
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SN7PR11MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afd4762-46ab-4f84-85f5-08dc3ce5d16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0xSt6/EY5PzW6ohVeNSRQgzxSw+27AFaJDlrhoZOpmeH3Xv5uaDThac0UKzUDSCmDY+VjNXE8cDwNBxNSX5xTnGkJ6/FoZ/nOYv0XYi1WZxlle6RIcEWfGLs39vSeBAA04Pz4GfADdd/hHSoEABaf41YyFAr7+iOPaNsDwMYuwL9n8PE/TT0+AWZHXxTcBY49XyxrxLgwlxQ49uJsxi5wF4iIjRqYCXsA4mekyhnuLWcW/DZBVB4vX9IOzkl1FwWvHO7i17lKun0XXNLs9wahJ31oAY8V2GBVdjQHbApm4AsBPW+5Bp+C9nY7FxBlp+P/B8K4FTXnQkbVbcaM8h6I7ix5HBeaNjrbE1PD1v6wShFx8d7FU42vii1oJtIBDx38/45jvkuZHbnztisA7uGigLqlCR5noSXgra7D7zMkwADpreilDB/lj/vE48Rke0MQj3NlLbCfzqiG5ZqDtMD/c9jNembPTwyJ+gwbCAK5g5ykhcB7rlccTkxCMCKf0W4/VSyi8F4MiEyZd8jSZOJdAHnLW9JzhYFkxqEj5Hg7XCiuRfJGy72Euxt/0zWwSgFw5h2QJ7ueli0TWdemPXN9c4Y/rSv3NWASi7cj3KQE4nS4tZ7LMvPCxDtTzmOqkTGJtpHvvl9Agd6LV6xGz16/5/wgjffKXNz3MBIezZGzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wuljh3aE9euLVTZTumK2mbI5qnS1ElCLBl7l58AkZO66Z/7VS9Ee1+gNpy?=
 =?iso-8859-1?Q?Yml4QWu4l7TpMPKiuJ3DfMmiRPZGHuN9wcTNE+r7RjzjVMydxSyW8J0TEk?=
 =?iso-8859-1?Q?5LoFxbhNMMIfC7hUjtpjUpDNEEFObebCT8VpGzawlJ6UhGTvRj1xaQGNgX?=
 =?iso-8859-1?Q?nsTHW+70yUCBj+dxPbAb9YYyD+HQ1CJlprfSRYSsDO9urH3NwIGKe1bcJp?=
 =?iso-8859-1?Q?v+9jEDh+10h3lFlJRDEVkYGyJQrE9rTklbC3YSlS6OdxctzYEX59B4GLHe?=
 =?iso-8859-1?Q?c5Yl4hjWD53svw6bWbyKJmBi3pKoDv4MrmcHtNx/xUiGMOrPnLwwlYTbPB?=
 =?iso-8859-1?Q?xfWQbcAN0c5N3AxjbBla0uFbhKlvyeR1DQWhpZiokQ8EInaBvlgx8epJgh?=
 =?iso-8859-1?Q?a0ehuNrtuZBcZ6zMw47IkmJDXU4i1CEd7qR8mrPaOfJ1zv0ySoJNaA4n9u?=
 =?iso-8859-1?Q?uqeRAbmAsT0hNUxrilyHFy26h3B6AbvtA56LPfc2zfIMFnB0jZP3krS0EU?=
 =?iso-8859-1?Q?VbJ95fxGy7m6LsXFuogkNUlppYcH6gbd6bYdeQGlLF0MJOaezpY7Kg8L6e?=
 =?iso-8859-1?Q?FgXiMVo1jsdss1BH+UF0xQAZFbS/XLb35KYbenE/vf4B4T24dwyiNTyJNl?=
 =?iso-8859-1?Q?Wa5zEsmhdbYo8mtAaGA17laXebWmxqL5FbR7j1QDTB8HxqAONW0qOpq6oa?=
 =?iso-8859-1?Q?1vBEZFB4A+9y8gg5ynI81lroBLqveUeXBHu8kMMccWZwRe4MMLWNOBejO1?=
 =?iso-8859-1?Q?5pBQ+zOUCtkE4ly+VqrtMDkCcqKCemxIeyBCXsBle2a1HpQw3oohiD+KAV?=
 =?iso-8859-1?Q?fHVIRmV+bKRBBlVQ7pyY83FysPPwVAPhglp0i721pNdNlxV1D18pup/IbQ?=
 =?iso-8859-1?Q?EE135A9Q88gWU1pQgw44yNhRpBdNzznywQciwuGVr/4kLh6QNGfRJWTe7f?=
 =?iso-8859-1?Q?MpP9XsvKRNjdM3p3dWCCnwEmSoKnrOPsA8jk2VHxGhH49fAKC12MRvy4ft?=
 =?iso-8859-1?Q?FHmhWO9XNVjSbJySg4/LdgknPr8fo/l3mx1rf/HWtdXlW8A49vajpjQ84E?=
 =?iso-8859-1?Q?2aPP/sgpfatcz3YEZglPmxla5Clap9aIq+MRQ8HmJeCX4vwc54RJGFWXFO?=
 =?iso-8859-1?Q?VUoL4e0+P+hiGqAMu2+dNzQRtLr5LlOXrOMhUNUWcSiQQ92G2Dz8sVcsji?=
 =?iso-8859-1?Q?bn4u46Dnim/acsD6rCFZZwm4Pmu/lLc0Pe78sBwafwD6o/i7vAPS4S1Jc3?=
 =?iso-8859-1?Q?0MDVb7rQaf1j/q4vlXJ1qthOut2/3pRWVRJiVY9fQJP7e/SzvUx/YXRvMK?=
 =?iso-8859-1?Q?JY3Q8ta16gIhm2O4M4w+Ppn0s0mtaTv/eL2fbPK1lAOylLwy6DsxSeeXjx?=
 =?iso-8859-1?Q?6THmNlP7bHuD5MSvQMl3O01+ANXEkWbdr3t55OR1DzO/0vzlfEzfcMurLr?=
 =?iso-8859-1?Q?f5IknrtHCfEEYuc3uiNk2Rom0B/4xGy9SJ38Gri5Qkmn6h2x5bou8OlwG8?=
 =?iso-8859-1?Q?Acm/eF1BQFC7Lncp7hjseButm1hib3vZWlr6H8ffSb+onR+27gHCL8bebZ?=
 =?iso-8859-1?Q?GUvJz8j71YUR52sw9xx/mjEQOqvC382CQm4qPKirusioy00HCSBSh7Rqxs?=
 =?iso-8859-1?Q?WDPXgJeBc9Phr5zUYaF4m7ebUDWtKHuWDGP+8EiWdESU8Pd//83XVb+qN9?=
 =?iso-8859-1?Q?7eTgB8pcoh7u57RN8h0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afd4762-46ab-4f84-85f5-08dc3ce5d16f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 07:28:14.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1KdTqTvgtmfGmbrUErz18c8glc1Jz38/zJLQJLei9Qj/b6pP+2zXzC8wFcC7e6fuaWTxcbFelMws38POEJiRByekJ57H51NnDCs4GTLM0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7565
X-OriginatorOrg: intel.com

On 2024-02-28 at 11:36:51 -0800, Tony Luck wrote:
>Hook these two series together in threaded mail clients
>since the SNC series is based on top of the two patch
>cleanup.
>
>-Tony

Hi, I wanted to ask a mailing technical question.

My mailing setup with b4 is capable of downloading series by their message id.
With these two series tied together it for some reason doesn't want to download
the smaller series (even when I pass the smaller series ID it ignores it and
fetches the SNC one).

Do you have some trick or method to download a series with this type of
formatting easier than manually saving emails?

-- 
Kind regards
Maciej Wieczór-Retman

