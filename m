Return-Path: <linux-kernel+bounces-134664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0B389B49C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896D41C209C6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A4B44377;
	Sun,  7 Apr 2024 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWAZ3WXD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E041DFF2;
	Sun,  7 Apr 2024 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712532271; cv=fail; b=puG8bugFXHWIRevBCGNKhNDFdvEFYps+p+F0PY6aoFrs0lGzv3vqp3kTxdEHJ1s0+EWWsyniKW5XnQbsANxjjaL/5xim7aJSh23FkF4gLMl90S6PEom+ilFklZI/yO+13iKr8xL5wbZjDYB9JI+VmO+vBHtY/mPUjuFNQpg+lDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712532271; c=relaxed/simple;
	bh=h4OAq3oXTKqktcXCSA0q/6o9Jxh2Pdfc1OfIf356CX4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JSFcmD1AQ4ABmVNoO0RPL+GCmer9HzU+Z8fpN8F2Qq7NIgoPeGoPLwQ600gQIASDJNwHDVHfoMvuTWqkT9BRbTFiflI2yea2fVUyCgeuWImdm2VeAY3bsKtqVoZd+ChnkBJTNCMZTZt6ndm6I1R9gyV9SJ6V4SOhos6CZBFd9CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWAZ3WXD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712532270; x=1744068270;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h4OAq3oXTKqktcXCSA0q/6o9Jxh2Pdfc1OfIf356CX4=;
  b=UWAZ3WXDuEo1IAIxivyvqGxP7QifvIkZvVHrvN8N1i/UmRgSMjtf+t2i
   jGkRJW0aR8wu7bB8xBHNlo7F9A/71zeWbVAGtQQi+UhE/qx+g6fVUYeFh
   pR9cctdpEfTut05OJagWCMOBVmraectgVbc6oeiWRassDOlhedihjrYV6
   EkxLjCuJr3KBo7d+rSrS+M2JwqfGfJL1dL/ZVExOz68Y/6E0eJbItT/Os
   xOkHBrowyTboj6bjEplUg3CZemtQgT8ElZlYwW3IzQPWGW537vX3rT28Y
   LzzFne8G7OSTHmTv3NBhLKwNzVbHvrwuJ15PT6To3zvQhkfO7NsFom5EQ
   Q==;
X-CSE-ConnectionGUID: np/px1LES9q5vDlKs7J9zA==
X-CSE-MsgGUID: xyhKLq7RRNumjWUdiin8ow==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="33191071"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="33191071"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 16:24:29 -0700
X-CSE-ConnectionGUID: sOMWdxfrS7eAJNJSMEHZcw==
X-CSE-MsgGUID: S5vhBcLmSIOTDKawdSTAQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="19723069"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 16:24:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 16:24:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 16:24:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 16:24:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFTs2iTpeLH9Y9HW0+sGw+rEeZ9C00jUUPpJ77rQWhL64dIbVInuwbYvs/smqj5XI+nNjKkJ98koi+gfzFczOx1JVZzodt7Ra/bgiArY0kTiCbGfjusfiZ66fMuN6seg4USTxdMutX+65FzV1m1ywSDBBwaXsqP1nJg8CWn1MODTMamd9/LLJL9hdM+65SQ55vu77wOxzEtT9h5rRS34IFVOduMfBaTUfU6zVcuXKQWn8VUrk6+KImAt5HO7ZdCyfpISDI9brvdxRkZQqxooubTsJ52M3FlZq3ThfAxNa8LuHqm3GtlHNJbXVJHHtDYrDhQ8GqODd/eUAU4LeOVlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CphyaM7fN0goF8MolvEGPoKFw4s34qawARwKFnExEg=;
 b=QBl0lTyh9ADiw0X6WN0L8L2ZRx8f3uyBcQR3UoqYyqyFTc1fVytWfFj7FNZv0QWHUzS6IGdqGXiqk7IPx67whaaK16bqGWfAzukQStKXvB3+xlW6tSv7u09ORm7FRKgUUKL/JCZijlF6sPqy7OliIaWnfAtHR3ygEICgFbDsAxvK6zRhOaNaV+yijm6OiLD9bJF8HeoYgR2/qb5Q9du8XI/xJ2NeDL2x0AZv5zcoWWxV9+OK1kSqL/11nOpcxJfQD6tN3oNI3WnYBIpLx3yX7LxBIh+yTZpqCni5J9HYUw+I+iTTXJy3IqaA0mqea+q+SlO6dpLw9GHtqmeWspYf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by CH0PR11MB8144.namprd11.prod.outlook.com (2603:10b6:610:18d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Sun, 7 Apr
 2024 23:24:21 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7452.019; Sun, 7 Apr 2024
 23:24:21 +0000
Message-ID: <13bb2f0f-5894-4366-be53-44658144a23d@intel.com>
Date: Sun, 7 Apr 2024 16:24:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/14] x86: Support Key Locker
To: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<dm-devel@redhat.com>
CC: <ebiggers@kernel.org>, <luto@kernel.org>, <dave.hansen@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <mingo@kernel.org>, <x86@kernel.org>,
	<herbert@gondor.apana.org.au>, <ardb@kernel.org>, <elliott@hpe.com>,
	<dan.j.williams@intel.com>, <bernie.keany@intel.com>,
	<charishma1.gairuboyina@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240329015346.635933-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::49) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|CH0PR11MB8144:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMpmD7n8Zug3Xon9cyN3AvuFU0Eotr9DE2bs/BC15OQFEFq9NGWKhDBFEaVhvQ4dPIEXptY86dAXdIMiI2GC798M3pPVYx+tNtj2IJlXg91Vs/mqQcW+SosFUE9gbIcPlsWVMLxRCWz0SVBOI18aIH23go3J7ZZrO4GPryPZ6Vn0enXFTv4yPIEGVJ6gquKjWRWwjUxmb9dNWQR6Pv5O+U8dCD8wX8A1V1SYUH/gvmHnIJZacbI5MLYawVwuEWnwqGUhXIW3/T8ZQe4NFl/mZTpeskU/mmcWP9D1DtAXT1yhG87OwXvFUf+AnWg9P4y2qyjo5VXW8y6nd21uIlVoOWATTCjmBKak+cUL6jZfJXW9uAleEYGyP8APCX8vfrzIa14ltO7W22WhWVy9WimRXtyqBhVOCJKZ9aPoxBgkshcgkHl8zcd1Mw/xEDr6LXOomRFUMRCXPzqQV9tHe/50X7Ye1zTAEoK320BQBySYhq+DcPxAcOpm+TQXFx40PD4iSZiLYzz2ZmzO3L0gUbTMSHGYDDeZUVEsX6ywwIwR0HWfis0FjB2St+7VeefkR3BX3pGH0d6GOPRnTNqholHezvOkfaIDYmvmF/D57nBgMztjOoWElkAebnIQgcSQ5K6W9V2RzEwIGubQT0bT/HU3k5QIuKBytgJviSCyF3wYfMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk91dXkzQ0VSTXhXcDR2cjdVMjBJdEdZNEhJbEc1RWJLeE5jd1NrMDlNNVBh?=
 =?utf-8?B?b0xuRFdjRnJDNVYwRkdHOUMwK3ZNRjYzd2xJSTM2RDJiU3JETmpQNkxUNEIv?=
 =?utf-8?B?aml5L3ZTS3NkcnNOMTNOWElzazlxKzNFS0IvN3AvLzJMbGdnZlZobWdNbStB?=
 =?utf-8?B?TlRRWGIvWWdjeVEza1g1NzE1QU1HaEhXVGtCMzdtUFo5cmlvOElYZW1yRW5O?=
 =?utf-8?B?NTc0dU4vMUYyUW14cEVSV0VWUG5xVUtHWmxROHQ2d2JUQkVEOTVZdDllc3Jn?=
 =?utf-8?B?R29HcXJLY2YwMEs4aHFyRitKODB1R1YvTlhrZG5VcUV6dzZKWVNFU0FqS0xl?=
 =?utf-8?B?eEJMeWxPNFByNzh2VjN6bGgzWHUrMnBKblJ0Z0RIMnlZMjZKSm5uTzBvdkUz?=
 =?utf-8?B?bGRHZkpFOGd3VHUrdnVmclZtTGY4YTJkTUIwYTFSUitYSTBBcTkwaFl5L2xP?=
 =?utf-8?B?c2k0VXRqRzRxRXBkWFlDS1A3SWR6RnJOQjNTRkZUMGtIM1RBVWxlb01acXdH?=
 =?utf-8?B?cnIyak9CaDkyclZvVVhyalJxRno4Z2ZNTXNhNTlyQUcwSUowOVpaZUZqZTBJ?=
 =?utf-8?B?NmJtV0ZqQ05kdW1JV0NwaWw2ckNUVnFZR21uNFN3RUZSMHphRHdRTy9idUpC?=
 =?utf-8?B?MHVjRHhPQWNnVGVuZmEwZXJXREs3bnEySFpBKys1eUx5SUtyYjE0YkxvbWVK?=
 =?utf-8?B?UVdQU2h6UndocUZtZ2ZqTi9YTUMyS1k4UlNzVVp2S01xZGE2bjdIaWxuOUJS?=
 =?utf-8?B?NWZ4bktsTnJnbWZtR1NnZWx3ZkRtUE85YVNMblpIWWZIN0RSeHV4WlAwU1Bu?=
 =?utf-8?B?dVhjSjRnT2hjbVhFMXN2d0dRMkt2eVl1a3dodVFLUkZyMFF4bnZOTjVEK3p3?=
 =?utf-8?B?TndCWHorSk8rUkYwNm5yc1RoK2tHa1hSQkdkSC9UZXNHbHo3Zkd3blhjNFZp?=
 =?utf-8?B?MzdscnpJODJyeVE1a2swS0U4Ync3SEhtK1NJVS9pNnpRZHBEaTdIdWdSNElq?=
 =?utf-8?B?ZEkrc2taNHNISUxLTm5lMkF6cEVuS2VaQ3dvT3ZTRE96RjdJcTgvcTBsUmtr?=
 =?utf-8?B?UGNOV3BCVXVZbmZwUW14WS84QnRmWkJpalY4b1hLNy9DZzZUOGJQbmYxWnFn?=
 =?utf-8?B?TSsyTjZ4d2w1YkVKLzR3NlFEbjhTYjRwamRnYm1SN1FwVldqdWJTbE9MNENa?=
 =?utf-8?B?OStwRGxmOHc5RWVrUlBIcHpON2pteGRWcHd1UDRBMVJaSnc5TytBY0V5dG0x?=
 =?utf-8?B?bURZZjlhRnBUcHpaSEFHOERhRHRzVkVPS3hmMy9nZXBrRmZWUGxRdWZ0VHFw?=
 =?utf-8?B?cDV3WFlETnZUK0JiU1RjQnVuSzgwUHk0RWo0MURlemRlY1VMVEQ0WGhvc3Vu?=
 =?utf-8?B?MCtHSWxZVEpTSG9nVzhoQmFmTG5LUmlNcXFlVS9YVjdrNUVjWFFlY01ZMGpn?=
 =?utf-8?B?c3FRa3NoVHYxdE0zdFJCRzFjbVRhTXVmT1ExQUNNZXNtUEhIUzNDWHIwK0tT?=
 =?utf-8?B?SVNiMWYvYm1jYitBQlVHSnR5a3JuRDhhejN6ZkNkTU9FTUwycEJUZzFlQlZY?=
 =?utf-8?B?WTNCVjB2cTVxc0Y1ZnZITzlDcjE4QXhqeTBPL0dBMXFNZXVORVE5ZWlpL0JH?=
 =?utf-8?B?ekZJYVlpQWlVdGU5RFYvSS95WFNBNjlUQm1tMUVhVWh4azFWckxxYi92cysz?=
 =?utf-8?B?R3pFeFZCeUg5RFNzT0dadnM0ems5NTd5alg5WGdoY0VDMkdTb0NTREVPV25M?=
 =?utf-8?B?Zy9xeVFKbkM4WGRFRDV5cGdaUEYwWHVFVmlNYkYyV25ZRmpjNEkxRVV2VmI0?=
 =?utf-8?B?d1V4alR3RHFxS0JaYlhnU3dwTTdHR2ZRUGh2NlJnZ0dnVmFIOFZFcDhWWC8v?=
 =?utf-8?B?dHg2Sk5UaG5UMEtWb2VTKzZvU0VES1liMzVDczlOTTk3TEdUcXdRa0tiUkk5?=
 =?utf-8?B?NFh3SU9ycUlYWitVNENQL1pjaG9CbkFZdmw2bE1BQndGaEpsbVN5LzBmNHNU?=
 =?utf-8?B?ZHhmOUEwUUViQ3VNQ2hXVzdNcDlFLy9nQXlBTXpNcmh0T2dOZFJiM1AwUXlB?=
 =?utf-8?B?VWh6T3BqQ1JSYm11Z3dBaENZS25wV3JvZDRPdFJyRTI3YWNBaGt0T3hsK3cx?=
 =?utf-8?B?YmtwT0JaU1JjSWpwUnVsVFl1MnJIOHpFSElVVVE2bW96VStZL3JOSWo5dzZs?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f44d07d-027e-492e-4f5a-08dc5759da95
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 23:24:21.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8n8eSPF3+75awA540e9nw8NXDzd9RgB3ZF+FY88vGtphSbkZyL7VmU4JEntCt+vsFfDM7ugZRZqDzTdA0uPZ1uFG1GOz2HuvCQgNF0OxKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8144
X-OriginatorOrg: intel.com

On 3/28/2024 6:53 PM, Chang S. Bae wrote:
> 
> Then, the following is a summary of changes per patch since v8 [6]:
> 
> PATCH7-8:
> * Invoke the setup code via arch_initcall() due to upstream changes
>    delaying the FPU setup.
> 
> PATCH9-11:
> * Add new patches for security and hotplug support clarification

I've recently made updates to a few patches, primarily related to the
mitigation parts. While the series is still under review, Eric's VAES
patches have been merged into the crypto tree and are currently being
sorted out. Once things settle down, I will make a few adjustments on the
crypto side. Then, another revision will be necessary thereafter.

Thanks,
Chang

