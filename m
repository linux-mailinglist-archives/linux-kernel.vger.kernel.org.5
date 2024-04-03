Return-Path: <linux-kernel+bounces-129411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2B0896A67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97411F2675C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD6871B54;
	Wed,  3 Apr 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FF67252l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7845008;
	Wed,  3 Apr 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136166; cv=fail; b=BANUl8gd9GVaOLWNZKgqV6iDFbw/A/a2ROmG59pZ44KyckAjawe08UDfK6tSztGUUupN7oF64B6BQ2cTFf5PoVe64Cg7RJ8NJHyZMz3i2qadS3CnOeJ4VHMh2+SEE1BlUqn+Dddg0tz2brF+Snu1L+kKnFZCgnQYMZL/h/VJjok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136166; c=relaxed/simple;
	bh=CGRaXExU8YghGC8fsjwr0uXQmG5YAeflZ6MPImZ0OHE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W1BiYmUih41Rjmk86dZSD48UvEziYy5ppwPNEBJs0c8YaxgX56b98VTU+MJjiwfizTlERG2SJfOPQajSEnpVP+GBuvzKSl27xkanThuOJucWEW4VJ5i10OOWIfC7GkUUS3IBdKwdQ5H1THAdPRK+MsIAdgdZ4XHY6vhqJVm3Vjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FF67252l; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712136164; x=1743672164;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CGRaXExU8YghGC8fsjwr0uXQmG5YAeflZ6MPImZ0OHE=;
  b=FF67252lyGRui6iDzbkHcZp5tlic/QNuiAIHt7caQl3+HTiwQIJUcCma
   kQO2+n/E89CyAVTeRzWNBQBhfoknjtsPaiCBk82Z65Z2jkFEWcZaIPvZD
   NLXZhhWlvPJqETyJ2CRifMVE9bquLQeqCK8gLAMX3ozo+1o+exBLHxYvG
   yi57tAdHX3dTForuBG6LDVKR0Je6J7wzMFHLdec/H8ZD0qTt/AVEgZkky
   0akrYUUVh22+sNeg81xeFuQQYFYLZHAe9QuKNWpiteoO4yj/kmVhV8ikZ
   qbePZ4Fw0fqUnmo3rsId8KEkx6SzTh8XrvlTk8r1ZERQ6l/CaKXaPUF6O
   A==;
X-CSE-ConnectionGUID: N7gd3xbfTVSKg93p52zGCA==
X-CSE-MsgGUID: WyjU4ANRQXGVyHbZ67rHXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24812178"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="24812178"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:22:43 -0700
X-CSE-ConnectionGUID: Q4Ee0//JQoqFM1KnoCeLcA==
X-CSE-MsgGUID: 5kPCuoemTrCL+FZXHlpeZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18413016"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 02:22:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 02:22:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 02:22:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 02:22:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 02:22:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+JAilur8P/rsQqU3JRptlszOo8yRbtOX++h1RlCo9nRkMG+V6y5pSM8yl6Q2CwNOvprDEnPiYhjMuhsZIkRsugPBZNkbJIrcmsB+QBYMcXrIwkpjNehlEG3+gDn8xH9uncW91WNyAFGi498NaDwLkeCIwLahzvP3DhvAhj9Kszpf8K6R0nioJGFb9FPNC+B3SNFZITUKZEXmP+o+CAjGr1snJLGZQypl/5MFM9e+JXJ1atnW8cac2QlXr28Ftf+bmYHtVl94R7gnjD+MKEmydkSg398iR+iQcoIKanB/p9+c01QuJiBR6Qv72giqaOW93HVJm4ZKcPLSHTyIFKjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgiX9v8BsBUGK3yMgkur4mDl5ofAHfDGTCqnnHhqShU=;
 b=ERw8X9IHHNYH07BxlMxEEuF9AYPwuzbofyS+RYp2rbu4TxQB3mw/Y4OPYBYhlI/LTWVLfhY57V7v58w/YagRHsrYnX5zdBHboHen/Qxb99kZI9sJmveoKWqcke8Lve16Nh/HPHxe0XpAOioUExj46rYoXeHHCYBbmaykpbxmZmEGXvS2IKGJwocqSRySQAWUKoLr3ZkDyhIgQd+hCyTWLXBH9aYJx+rnXeFasmWrma+eVwSd5Y2fZx2FbxnwbSfZxc1f/0lWI1Q56cJ8Sgq4OY3iDpTSIoDC98MrJ7F870p1fwGibS+wlEJpkq5elULEKqw9umusAcQGdSYzDnRhsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.21; Wed, 3 Apr
 2024 09:22:37 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 09:22:37 +0000
Message-ID: <cb05bde3-ee23-4e52-9df2-07b4c247d60c@intel.com>
Date: Wed, 3 Apr 2024 11:21:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] page_pool: check for PP direct cache
 locality later
To: Yunsheng Lin <linyunsheng@huawei.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240329165507.3240110-1-aleksander.lobakin@intel.com>
 <20240329165507.3240110-2-aleksander.lobakin@intel.com>
 <5699d031-d6d2-9cae-7025-2589eb60c0a0@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <5699d031-d6d2-9cae-7025-2589eb60c0a0@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0098.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7123:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4PFZhFWSinx3jFF/hqB1T4vsG91LdwMCQh48mKCrNkaiDB2OPZ8Y8mx6SQrmnsPcstNuyUfoacCVsr0d6RqRC30bELD0Y3/DRu9WJKgupZdYzfXi69lznKRNA6uVq6XT0ba0uIwltqASROy2gq3OOyfS65OGXSVOCFS0VWZbi14nPBbaFttKj+6wFo6YcfwEpe9rdlAUHS3OZBCq9RG/PksYUsGmw/8p+v8WOc+XfuQwQI8tFu8yNQdLBmU3ucvLA1JzeHD2Y0NW+9YGkVe4RocPaXRfbowATjuUjWFee164uxLEviy3QD59lrQJofw+fnIU3B0aDrA6lZgzq7Ze51c7vQrdMTDZUykM4qCBnFNIW8Om9axRNrNFNXrhVQpq6wAY7Uvhv4p/iFrDgJ7YSPrAC7HlU7JVX2DSPVHTupvY+aKpw+bGwVSLkmiciKM4US7WDgaSVhgHXITQFU9vUB8cFntCleltRxa32LPvnkUnPXrivPM9UjB9WtTkCO9Th2mJGYXcPjCYccrmBtrbkAIQMwTeRs+xUcSRmFaA3A/578hYiQiPpJU/arzsLY+Vszq2x3rNYg0KDQtzkH037m4xmRJkou1/ea2o86TfF+O/RSp4jkBsGRlpVZpDZxxPaWsTr6vbkKv99EmgMEqqDc9EZEcK2nlbTeKS04RGSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0FEbEVCamNjVEx0WVIxNzFsVDB6ZnUwUHdoREp4YXV4Z1pwVks1ZW9RWWNp?=
 =?utf-8?B?TkYrZGlwK1dDSXZCeDhnK09Na1c5NFhtV2pQUHltV2VyaEJ0MElxUFJISStY?=
 =?utf-8?B?d1dqUGpETUZpRzRqU3QxeGdJSElyeUdWMkczRWxjK0VJQ281OEtZTFlDT0hu?=
 =?utf-8?B?MHdvT1BNTDR5QlpOTnV2VlVNY0FpZnp2UzhvNmpWVnpwTitDeU9QcnlLd0pv?=
 =?utf-8?B?VlhMWms3T2YvYk1NdDA1UUtnZ0tEUVVlS2g4Q3lZTGJhbXVFam94WENiQm92?=
 =?utf-8?B?TVhLcHhMcWYyWGhzYmVsZTFNaG5RdEpPVVZqdlkyUmxlZ3dwcHoxdnBRanZJ?=
 =?utf-8?B?Nmp6OFpvTEVKMzRiSDkwVXkvREF6TWwrNjRuMVYrMnRTWEZyQzAyeUJlN1dG?=
 =?utf-8?B?RkJoczRVK0VydmVUYVpXVzRQeE4wQmpZd3BMWUY3UXdxbWpzKys3SzlGMWtJ?=
 =?utf-8?B?Qmdteno5YkF5WlVpWEpEU1JOMkJTbUdMdzZWZEJrRGFqNzJ4UndJNVBSc0k5?=
 =?utf-8?B?djMrakVYMWhmZkRuRXUyZ3Fqdk83VUJnbzlibG5tczJUTWJJTUNJdHpOVnpp?=
 =?utf-8?B?SURRTW0vTDBUSEMrdW1TTlY4RklpM3d4b0IzRGtzRWZYVENsa2pYV3M2aEh2?=
 =?utf-8?B?b3lqbGo4M0k4VURIYUVPNDFoOWdOQUtic1Y0K01KMFhWZVhiUDlnTTBPbGI3?=
 =?utf-8?B?OXI4ZHEvSTVHNEZLNUttNXVORHlSSGtZU3g1WnVzekRocjArbUs2dk04Y1d5?=
 =?utf-8?B?Zm8xTkdCVGVoSG9wVXJPdVVBV29rT0wwVldqNWppZExHcHVnbFAzd3FLS2cw?=
 =?utf-8?B?M09pOWdUSnd3S0ZrOFplU3lneWhoQ2IyK21ITk54Nnl2aWoxZ29iVDIveklU?=
 =?utf-8?B?eXV1RUxjQi9FU2N4REpFdGJ4L3hhdHlkV3crY2wyZjhSTDBmV1ZWWFNzWjFm?=
 =?utf-8?B?WXdJV1JORVIvUzRwZ0pRT3ZlaTJaakdPNy8yc25jTUszSGx3cjh5NEZOaHps?=
 =?utf-8?B?Ylc1RjhNNmVCUnI2Z3JnUlJxS1kxekJrMTdhNFJyMXEyNnhWQ245eW9yS0da?=
 =?utf-8?B?T2Y4TTVWajZZMDRHQ2VGT3o4NzRtYUhXanRYeDZpWERkbDAzRjNZRzBCUFdv?=
 =?utf-8?B?SHJqQTJ5eXVOV2p3dW5ZYTdMY3kvei9jVjZXaWkxcFYrNGFGS0dSZEZObXVD?=
 =?utf-8?B?elhaVVZ4bFdmeXhUYzR4ZFJqTzBIdVhDVW9jQ0pCU2ZiUWVwRldMZzl5NUhz?=
 =?utf-8?B?V09FdUI4dXV2MnduMVRoTTh3Si9Rd2I3OG5QOHlQdU9jc1YzZjdvOEVNT2I3?=
 =?utf-8?B?WWJCL1ZmN3YweWlkelJnRGM1MmJKMHFSZSs0UHdnSC9hTXQ5eGo0elZtdy82?=
 =?utf-8?B?QTIxZE94SmpObG4yTDl5SVBvZEpnbG9OYzF3SHRYTjdiWjhxT2w3VUJ3ZkNZ?=
 =?utf-8?B?MVZSK01zZis2eDBRTVM1bFQ3dHYxM21SNEtpZWJCN0ErZzlPSlN4OHU1WlJI?=
 =?utf-8?B?NUtzYytOV3ZLVWM4UWd2N1A4RFRlOU4wWWVFVUgzYlZuNE1xV2hsVytlM2hn?=
 =?utf-8?B?d0NPM0pzUkt2dzNDSHFnRzhmcXF5eDZZbkxLcU0wc1pxS29Ld09vVDFWTDhO?=
 =?utf-8?B?NG5oRnZhQWdSM1lqSUYwbHppM1VaYnQxVkhqNkthYzkzVWJKSFNMWHkyME9X?=
 =?utf-8?B?aDVzUGx5RVhLSk8wQlhhUnZsK1FNTUhEZTNibkR0eGpjOHJqaEVYS1drMXNZ?=
 =?utf-8?B?bXdlZ0Y1cUc0b3l1aVJtWU12LzRVMVVxZjZkckdTQWVIeXVjUEwvS0czTmZH?=
 =?utf-8?B?L1c0WnA0UkRSWmR3TS9RTWhNMzNrTlZxbVZMUkcyTmFsN1hkaGE4ZHc2TXlq?=
 =?utf-8?B?ZGNkOWdBK0xtaEwyS1h5WU5pMmprVUZwa1k0bUpxbWdCMGcxZVlhR3lCb2k5?=
 =?utf-8?B?WDdWOUpCbzE4ZjNzS2RBQmtVczdUWUVIdmd0QjJ3bGk0VjFxZE0zSnJDY2wv?=
 =?utf-8?B?SWdzZ3VlRzliRXJqQmo2K2IzTDhSZXNRQ0dHUW5ySTBxcDg2czRUb3dQSTVy?=
 =?utf-8?B?ZXcvdVg2OEFreWdxMUdCdWpPVGJkbXNPRlBPOHdTeGVEQlBsWEs1QlltajFF?=
 =?utf-8?B?TVpnOTc4d1d0V09yWDNDQ1MvYnVvWmJyUnJMT3FzMzIxSGRqNUlOS1Z1M1Fu?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e69200-922c-4d99-f095-08dc53bf9a30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 09:22:37.2592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viaDArQUcKug5esfDPPydMc0wUeRztxFTdu3leNUGkE/9xFci4rjbnyTHffzQ2vpawVxy+dwMEDe27fJXD0H4iJNFSe0sfUCNokPnKCfUfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-OriginatorOrg: intel.com

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Sat, 30 Mar 2024 20:41:24 +0800

> On 2024/3/30 0:55, Alexander Lobakin wrote:
>> Since we have pool->p.napi (Jakub) and pool->cpuid (Lorenzo) to check
>> whether it's safe to use direct recycling, we can use both globally for
>> each page instead of relying solely on @allow_direct argument.
>> Let's assume that @allow_direct means "I'm sure it's local, don't waste
>> time rechecking this" and when it's false, try the mentioned params to
>> still recycle the page directly. If neither is true, we'll lose some
>> CPU cycles, but then it surely won't be hotpath. On the other hand,
>> paths where it's possible to use direct cache, but not possible to
>> safely set @allow_direct, will benefit from this move.
>> The whole propagation of @napi_safe through a dozen of skb freeing
>> functions can now go away, which saves us some stack space.

[...]

>>  void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
>>  				unsigned int dma_sync_size, bool allow_direct)
>>  {
>> +	if (!allow_direct)
> 
> It seems we are changing some semantics here, in_softirq() is checked
> even if allow_direct is true before this patch. And it seems in_softirq()
> is not checked if allow_direct is true after this patch? I think we might
> need some assertion to ensure @allow_direct really means "I'm sure it's
> local, don't waste time rechecking this". As my understanding, it is really
> hard to debug this kind of problem, so in_softirq() is always checking.

It's implied that setting @allow_direct to true means "we're certainly
able to do that, we're certainly in the softirq context". I haven't seen
any code which would set it to true outside of softirq context and it's
counter-intuitive TBH.

> 
> Perhaps add something like WARN_ONCE() or DEBUG_NET_WARN_ON_ONCE for
> allow_direct being true case to catch the API misuse?
> 
>> +		allow_direct = page_pool_napi_local(pool);
>> +
>>  	page = __page_pool_put_page(pool, page, dma_sync_size, allow_direct);
>>  	if (page && !page_pool_recycle_in_ring(pool, page)) {
>>  		/* Cache full, fallback to free pages */
>> @@ -969,7 +994,7 @@ void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
>>  static void page_pool_disable_direct_recycling(struct page_pool *pool)
>>  {
>>  	/* Disable direct recycling based on pool->cpuid.
>> -	 * Paired with READ_ONCE() in napi_pp_put_page().
>> +	 * Paired with READ_ONCE() in page_pool_napi_local().
>>  	 */
>>  	WRITE_ONCE(pool->cpuid, -1);
>>  
> 

Thanks,
Olek

