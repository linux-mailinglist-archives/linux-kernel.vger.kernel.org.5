Return-Path: <linux-kernel+bounces-131143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70B48983A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AC71F211F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8657353B;
	Thu,  4 Apr 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0m4FHq4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56E3D96B;
	Thu,  4 Apr 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221158; cv=fail; b=FN5rfk7LN2JlwZQ9WDwxdLwFgpeGa/ATBPuwmGXAk5hNtzoJHrBRF6KNjRp1UcKxOOWxm5XSIRz1Ggt0PvRNgcVoKa82lbHJuDHkp6FcBcGw/5DdvRldxkM244i58GMb69/KxZrITxR5JPDeLav38Kmtqamu1zvZ47IWjbkw/hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221158; c=relaxed/simple;
	bh=Ase6oa/viYXf75roZi6c+IUJL5jQn98F5F5StdluSjA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvOU0Bykk6P8vaX7tTrFV+7tOf5/Py0eMaJ4KhUwJ1u2GGKr0C0IDrSCqHwRUHdmWD5M9gDX0rLcssb90iIrVzQhdF0xZvWUh9Kvt64emzqc+rjZHtGNvl102UC0YmlQrgJgv5oMqfUyeH0VpMVKMJPCakVEdIJ8XIL8hfYHxgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0m4FHq4; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712221156; x=1743757156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ase6oa/viYXf75roZi6c+IUJL5jQn98F5F5StdluSjA=;
  b=h0m4FHq4fCpMc9G/jFF92k4PPv9Cojnkml9k2PQyWswSVKhGsBISJC2h
   6lyBFm7Kb/+oBwZFq1qFcHkRfyev5iW5zxioP1AIU9iKGPtGk7n4zBTrf
   1WMIxoMwiOCTwjFhOFVAwQvxojKbXDJ/BzS8YgBrKVmO5n5TUwJyl2MTA
   /yJQ3BTpkVzIKVfUp7dNaOAeohdMhw0EvxFfKzSwFXEQRGJ+S+aREJiYm
   6hSREM2tE51UxUEToqhmR3gncT83pWwyT+XoIbByYERiHoMlTEjtqpPa0
   gYXQ24ZSq40RKWlMVG1vh6m6PTClZy+bRAEskOkz99+pS9grAtRbOmN+Z
   g==;
X-CSE-ConnectionGUID: lPW04rzoQqqMMdOycyM/Dg==
X-CSE-MsgGUID: G576zHGxTJerCB0CpsA3ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7726578"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7726578"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 01:59:15 -0700
X-CSE-ConnectionGUID: /L3g5SNQRR21YD6qE/SMLQ==
X-CSE-MsgGUID: FQ5oRMyHSQSlC0UoQURSpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18751649"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 01:59:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 01:59:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 01:59:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 01:59:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2QjTZRbmLmzDKglMJkjnpnPphiECAuhpdfcr+Bo1RLenoagPubt1Kigc2xzy0n4Mu30BcBoorYhdRbp9wOpdrR83SPB49bwAZJPmgKsEAdgG0u+8v4UKCvzlE745o5eOBXT1iNRRbldlMGA6mYz4jeUvk4wfBG5yga1gO0kYZJ2T4lmkCCGSWC4ipLfRrHbCejlNNtmbo8ZjvOTWQtLNLqromPYEbCrxnS0efnlZw9eoBtiLTe8q6QqvpjgAoeP5KXo/KBTjwN7NCs1Ffnfh/ba5Utlws5m7U+FdyRJHOToW+aZH8xmX3z9mWUC8lVrEdr3wSQJKP+hqT6e8sKxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFiA2tBsKctiQtIhZNnD29B029FDVC3C0fQ1AVAWHqA=;
 b=KEUotvTcUUJ76ezGyKes3mypDJ1BCgTbQhIE+S5/L29uqWjL03zE4lYqk/bXKFNz2IDXE9pW8ABv38hKucDvBEiUmJvPXaQqmZ1eYyyTV+PU/PG80+HmYxw4+0ETPyVDW7S2gskePds3EiW/7tYNJusMLlEU069LlSYk4iRvu3XWeLo8rx1J9L8S/I5pg6S7rgQQYWzxbC7KerCLUtxWOAee4fBEoPo7luyA7JF5j7sQJu8OleaSunnaKvxLqpdJ2nk3GKmHjr2gKzZEfO+YL8SihUeGrHl+tR78ZfnteNuM4IttcHqADGerJ025KYK97wyiIjDyqFll0jALoZhduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.21; Thu, 4 Apr
 2024 08:59:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 08:59:12 +0000
Message-ID: <2d9e139d-2b7c-4edc-bb5f-32d067598e5c@intel.com>
Date: Thu, 4 Apr 2024 10:57:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/tcp: move TCP hash fail messages out of line
To: Dmitry Safonov <dima@arista.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Francesco Ruggeri <fruggeri@arista.com>, "Salam
 Noureddine" <noureddine@arista.com>, David Ahern <dsahern@kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240403132456.41709-1-aleksander.lobakin@intel.com>
 <CAGrbwDQ40DWXZ1AYesdXMXrb3HWW6bs6dAYVaUrwDriCekwg3w@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAGrbwDQ40DWXZ1AYesdXMXrb3HWW6bs6dAYVaUrwDriCekwg3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::22) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5199:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zB0Yo9Y+kideX1Z7SjLzhWH4T+LRDj6E2PoSUCWTmuaATTZ8VAne/a9z3+62p14PvC7DsXlwSpoThgnGhZkM/Dr7UZtUCfl9wGNxq9EYaqzwzv7c0g76ZjXtI9H+gXP3WckAYjLei8jpZwSeVBe4byptg/0dbtGzJHy3m6+0G/Qc3XAbwqtqT5e5YJtWtQZf3WvZSOI26mEilyFml4I/tW78PHToLziqQkTYbeCf1GbL7zzhWRqa/MQ8cXW6ir18iTXQ9Fzy9wRZHH0fj86uG96IPKPAKbWLIHBnIVCWu72p0W/T2CPQ7Aphn5sMmF0qAjBjh9/0ahJNwqJj487/bs4u+gam+/g2+QrG9k4NLZwZlmBTzdtaZy/ay6WrQquW3NMP6G8RlCCeMcfPJmH1zs1i62L9BjcM6M/PjPQjyvq6STpDiGkvvD4lgAE2vrXFcwTZGNTgUX2Nbtl/3dwtJuGHiV9pZ/b94gOG9MurE4CZU9x5lWrxQ2dPHjYNbTpJQqsoWIivuT00jDLBhwY6UoBOGb5PAsKpRJ036e5FygZOyYkcNDjkLIEI+mSCLtQUG7EyCb73+KyXG5Hk0DaiVwJL7hMBBhiJSpgZzoRXkCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0lJeElPbnF0R2RFOVplcW9jRVk1QkJSSTRndlRiZXlPblpUL3llMjNCMmlo?=
 =?utf-8?B?eStsYmticTAxN1hJQmEwdWxvWG1WdmN0Uk1kYkMyZzh1NkEzeU9iL2VuK2JD?=
 =?utf-8?B?cVpETXB6Y1dEaXRtK0twK2VkdjEvNHd6VGVydGs2RUQ3UW1DWUYxTnFocEIw?=
 =?utf-8?B?aElHdFlXaUJrVVltSTY2WXlwUGNIUUluTlpYcEEzbWNNS3hWSFhnZE9BQzlp?=
 =?utf-8?B?TUJJQmFwOUJ5elhVNlVyZDBvbllXWjFIRjNucU5zZVc5YUNzVHZJMjlZUE4y?=
 =?utf-8?B?VCtob3B3cmtLdTlrMSs3MkFVdTFoQ3QxNjhPVHQxVVhkYjRRS0REU01rZG83?=
 =?utf-8?B?NVZlVWtLZlh4RjkzTjR6QmRVY2pETHJDNFJNY2RQakQxUHdZbi9qMnJCQlZl?=
 =?utf-8?B?WS9kMXNOL1ZrZlZXU2JjNjVvS294M2pUV0owd3o0Y3ZmbGg5MUpJZkZxajNY?=
 =?utf-8?B?ZlgrVGRQeG5ha3BoR3U4T0pUbStFdEdkNk5vRlFSdDR5ckF6bUJRSGw5cnJu?=
 =?utf-8?B?OWM2VFREWEpDT09HOHBrbDRQaWdVNzJoM05veXdBcEhiRnFxaVQrOHUyOFhu?=
 =?utf-8?B?WS93bEFvZzhhZ2tZdDJUYlpheTVDTExHdVM1WlNDeVRxS3dJYlMycitvUjF2?=
 =?utf-8?B?T2RjdzdPNGR3Nzlua0lmRmdBVjMzL2JydzBJbTY2eXpZeXJ6Yk5RZFFZTUpH?=
 =?utf-8?B?N0pwaWgvUy9KSk9SeGdXTENJZGowSTY0dXlVajZ2QkNLdUZWZllzeFR4UGZx?=
 =?utf-8?B?MUp3akdYR3l0c2JnWnMwS0Jrc3l1N3ZTZkdvTUNaUmZ4b2gxdlZzYjA5R0hu?=
 =?utf-8?B?dUdPanpUSlIyOU9yT0x6aGZDV3BRZDRKa1dQanVJWGVaSjMyditrcUl0elFL?=
 =?utf-8?B?bVdmOGhuaGYvb3UrQW9CSVVieGJIb2t3cW9ydElqSGMzcFUyNm1aRVk2WHlp?=
 =?utf-8?B?V3o5UVhmS1VpWGxmbnV2cGx3WjBjZ1hkdnNwQlhGRnZqY0tGZTcwTUdoNWpS?=
 =?utf-8?B?QmtGU3JiQ2NSNjJlTzVLYklTZTRrUEo4QWdBUGxQQzRwWjdaNUlyY0loSGpk?=
 =?utf-8?B?d3p4Q2hxV0YxOE1iblNzV1FPc1pvblRXRUJZUmtJbEtLRTZwdjBDNVREd0Nh?=
 =?utf-8?B?Yi9WNGlZRjBCRlF2RFFXT1Vhb20zT3JGRFdTQ29QVFNWMmdRL3JlM2dESTZp?=
 =?utf-8?B?OGxhWVpVM2JsenBDcnNLbGdCRWdRc0Rmb2YzSS9lRitlZnhLazNZWjU3V09u?=
 =?utf-8?B?ZjcrMEk2cUlzampYRnh4NTVuYlRsWnl3eUxGSmZTZFpDZGUrNEdUOXVoU09Y?=
 =?utf-8?B?clZVT3o2UU1UTUhTU3VKTXhZNkMxZ2FSd2t6UHRUTWVXZitQQ1pOUEpSUllw?=
 =?utf-8?B?TlFZQVB6eTA0Nlo0WVNPbnczWHNlczlmZ1dRS0pzMEFGc0hrd1VxNVVLMDcw?=
 =?utf-8?B?Q0hsTEdKUHY3angxazVlU0w2K0FhQzlGS2dXZldNejEwb1Y1USt1aUlVNFNC?=
 =?utf-8?B?TkRmNzFlSzlib0ZNcjhMdWRzTVJoN3AzcTd2MkdhNU1qOVJESm1Jak1BYWpY?=
 =?utf-8?B?WkdMUFJGajJkT1o1NkNDQW5iNzlXdCtOWGhHdHhBOFMxaHQzTnMvWWhoVTZE?=
 =?utf-8?B?VUhQenJqemx5elA0WnZUeWtGMFZkY1hVRVR0SituM0UralhmczZtODZCcHRm?=
 =?utf-8?B?ck9zNmZRWFJZNThNTjFWOFZPZHQ3Umx6QllVcFhqSFUxOUYrTVJGWVFzc2tZ?=
 =?utf-8?B?ZFVGaG5PaWR1VTdzWUdLaU85UGFxZWJKa2lYdXc4b2R2OURmQ1hJTjNaT3Fx?=
 =?utf-8?B?RkRzRGtvaWJiRUZuWmt0NW5YQnJCbG1tMldsbHpDUnVtVzd4YkpqZFpkVlVH?=
 =?utf-8?B?aUF5dUhKRUVYS0FqYzhqQ2VvZVlzUnpJMmlrL3lTOEgvbDR6L1Z2dVBnc1BS?=
 =?utf-8?B?REpZUkxNeDBPb3Z2MmxqY0w3ZG1zdXU3bUxHcUZVRjVhQWptM2lUNU1rVjVU?=
 =?utf-8?B?UlRhNXhKSmxBY3d3WWFWMjdzY1ZCUTFDeXJNcnhmdGs0dEFLMVU4Qk8zaVlW?=
 =?utf-8?B?S0NRdUdlK2lTRWFLUWxNM3lNZ1lDYWFhdW0yWFBmbUZxZE5meG5KRitIR1FG?=
 =?utf-8?B?aWhXN0NZSzRtMCtieDloQm1zNmdHc3E1OXErMXhYejJWR2lVS3U5ZHJwTmJk?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afbc376-3cf0-4e1c-0fc1-08dc54857f37
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 08:59:12.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFsjcryPXOHAFJ5I4OYubEYUokZr9YcWsFuyESesgR4raBwJrKt4Yci0imrQ5EBeAWtTv3xSrPXtdlfvc4dA2AfhuPFOBmzPABYDsxB0ARA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com

From: Dmitry Safonov <dima@arista.com>
Date: Wed, 3 Apr 2024 18:00:49 +0100

> Hi Alexander,
> 
> On Wed, Apr 3, 2024 at 2:26 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> tcp_hash_fail() is used multiple times on hotpath, including static
>> inlines. It contains a couple branches and a lot of code, which all
>> gets inlined into the call sites. For example, one call emits two
>> calls to net_ratelimit() etc.
>> Move as much as we can out of line to a new global function. Use enum
>> to determine the type of failure. Check for net_ratelimit() only once,
>> format common fields only once as well to pass only unique strings to
>> pr_info().
>> The result for vmlinux with Clang 19:
>>
>> add/remove: 2/0 grow/shrink: 0/4 up/down: 773/-4908 (-4135)
>> Function                                     old     new   delta
>> __tcp_hash_fail                                -     757    +757
>> __pfx___tcp_hash_fail                          -      16     +16
>> tcp_inbound_ao_hash                         1819    1062    -757
>> tcp_ao_verify_hash                          1217     451    -766
>> tcp_inbound_md5_hash                        1591     374   -1217
>> tcp_inbound_hash                            3566    1398   -2168
> 
> I can see that as an improvement, albeit that enum and the resulting switch
> are quite gross, sorry.

I know, but that's the only way to move that print out of line.

> I had patches to convert those messages to tracepoints (by Jakub's suggestion).
> That seems to work quite nice and will remove this macro entirely:
> https://lore.kernel.org/all/20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com/

Oh sorry, I didn't search lore for the related patches before sending.
Sounds good! My solution can be dropped then. Just make sure you have
the same code size reduction in tcp_*_hash() :D

> 
> I need to send version 2 for that. Unfortunately, that got delayed by
> me migrating
> from my previous work laptop. That was not my choice, resulting in
> little disruption.
> I'm planning to send the new version optimistically by the end of this week,
> at worst the next week.
> 
> Thanks,
>             Dmitry

Thanks,
Olek

