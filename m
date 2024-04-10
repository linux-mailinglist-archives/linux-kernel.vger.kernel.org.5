Return-Path: <linux-kernel+bounces-137742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F589E693
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC19D1C2165E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E765C;
	Wed, 10 Apr 2024 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SASo5uhr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7E621;
	Wed, 10 Apr 2024 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707447; cv=fail; b=msqcGmjcuJBHanLEbwXQVaBtOqwFBqF7kQ6MENNIj0AiTlyAY+dMJh0zk8qgkleWzlV8GhZBIkmXu99u+dOhu1+32DL6wvVhHpkDgQ675+/7mSEctIL4yKdbWkT5+rr1xV4e/Tli0xkGNOhkGaup9NVKItToTtLcFBtHvHT+oxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707447; c=relaxed/simple;
	bh=DNJYDpZoPWJFVgRSwzo3wca7ACzHWW/gwdujTlFXsrQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uAQ4NHIWBe7J7QHOsfOjnv5PP/21VCZ4utEqgGvTAt/Hr52nXaS+47WtYKcWkjfn47AC8mKRAJHTlA7jnYd3vSVPvrzTn1gnpdIG81hRI0fBAtnu6guFPeoLTTdlfyuhdU95mkirVU3+0RutGAFyFB3PKCg7aLOzQwrhwoSTocA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SASo5uhr; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712707446; x=1744243446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DNJYDpZoPWJFVgRSwzo3wca7ACzHWW/gwdujTlFXsrQ=;
  b=SASo5uhryoSiKpEJe931vA/lCWtJ6Jm11LX+zuU1rRFU5Bj0R9VwUERX
   p7f0zbxF5G1jgYKtGNz+le6ekIh6g4M8qTGOMcPrYNXP5xXn34kf7CsF/
   pgymMeZIaoUz6rDg5UJF8jpUmT4lfGpCwP2Q50LIjF7hq3t8p0vgz6TAO
   96o4cF4YOB7gmhMo2ediOX+xafyA5anN+25A2QOFcVPF8Hs6r67xrMr9g
   6PczZHNlrynWSCzAh6pEsDgug962pshkCES4zaD8mnSjWX9HiQU1anRfJ
   PEsPDCpU1c5PQu7Vvbr/m2HjxibubmaD2dwrA8qIhc6rCT2PtWgQ8kxrq
   Q==;
X-CSE-ConnectionGUID: KcRss9sAQyWaMJNOpEb53g==
X-CSE-MsgGUID: DStT2BhGQhiCM86iTWxf2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19476865"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19476865"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:04:05 -0700
X-CSE-ConnectionGUID: JSn7n1X/TLe61+libUkHmw==
X-CSE-MsgGUID: nGphSp6oQ3aIJdkMDEMdNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43630727"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 17:04:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:03:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 17:03:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 17:03:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfO/rqyg4VpdsTCyNL/e9a/SAJVgV34lvY4cr3lrrlLU+3mtG6r+t9HpOvgHxgQ5Bw7tCuaih90aRYZcOH9olHJKzmLc9POSch9QmCP07WNQkluaz72Kr1Tm7WH7OAhkXHFCzFn2XVw074m+hiV3wIswsL7vqlFbmtQyMQoLPxU4YUmvrNe1ner300XSgWpszPLBCbz6kaed1IKXvEXs9eq3J33BOtkaPEp0bCCJLdFp8ME+llQnLX8n4FMJG+Vrepw07Kr1htY32pYFI+wFQXIBsZVOnNLitknOjQWtZxGuxNQm+iUPHLVN47BZ2MuczSP1iThavS6uc6t6t4NZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5SbX1nymkKLOJg5fFzojXgXjEqlon8bzmmUJ7D0wIo=;
 b=c/sNoO9j6JSnBg7QaNBhMufFobOxXzIeaXSiLvSmOanBAgl+T/KdwDTUPIkDdMUNTsrXFkMWeFsa8SD6MPAyVEk2J7k8KSA4idJ4ISZS3fPACo+jBwG2ogN29J0cIL3/NJW25tax7h0FXrWECu9BLCM/5PDnLUV8eEq0d/6axFpfwPrZJ6ctwgfZZxzjLLR0oTjFWuK8aNwuDlWNrDaKgPfO6ors1esLeuhktjlMfhPa5clzDUcsqPf5IKGk3FDWdZilS2xHH8C5AZtKBdnTcPGJNygG9USF/q2z5htK541DVa5LjHEXO1pGbj3qUXXPN1299UB7YLuBV1XzcG7+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 00:03:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 00:03:57 +0000
Message-ID: <33c44fe4-a682-4c7b-b910-60bac93cce7d@intel.com>
Date: Tue, 9 Apr 2024 17:03:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: sparx5: fix wrong config being used when
 reconfiguring PCS
To: Daniel Machon <daniel.machon@microchip.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>
CC: <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240409-link-mode-reconfiguration-fix-v2-1-db6a507f3627@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240409-link-mode-reconfiguration-fix-v2-1-db6a507f3627@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0305.namprd04.prod.outlook.com
 (2603:10b6:303:82::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6860:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erqboAzemgbSeAVAudAbEuMxjbOQXl/1Jd+aX5WRS20+3ow7G8RuPv3/rislWFhF8rvNo5XLwUrUmotkkzTWe2UpBocphdvfv1lgfx6OZsokJlLK/MMPdtYqhDqlifoAHwsI1sA4Q46Fr9Yf6exXcS4wPvAR0ReDvvWWSwAYOZeal6fwvxVEz0rnAzC1pSTIRqnDLa8YoW7wlj+gEuIlfV9B0DNoCNPvfuynYBDZi0jTiq9/D55+oxnFzdsCHAKmGZdvQE5rq0+9sXixdC2EiPQF8k2d1mDnlOFOBuiWqfpyR7+zIxDKFMQyzr6GjYwW+0pzZyvYSoyNGXSCej04j+a7cPFxRN9mUe1+edpdob4Y6y4lgh/i5KVKnhGKTM/8S4Jn7CUGKYlVewvfFqPNfEgwcOBOkNtXUS18ERLqhPv59a7xz0AG77kvtdVfgi5UsSSea1m9uXuoOg+EhSLDXXyo+4aoHQuTnonH3Lcz4wk3zncTasL03hTkADY2TBwqTpmI8HWx8fk27kLH7u1UaEn0oTXWwNGZltJ0Q3UmN7uBIAleK2O8K+3MZ3Nu4WWDApRBJhJl/vSUvA2NU5UFyplKLkzBHTVSbzrgTUQQjvWzGO/6+cFyaDWCbCXdo5qfMJifrLuu6qI0RlbMZHWtjToAIUnJTBo6Lc/RuJsV0zY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUhjWUM5ekZwUkNGZXdqck5Wcnp1eXNwLzB4RWFBMVFYdmJoUFUwc3F2aVdh?=
 =?utf-8?B?WlJvQk1GVFlaQW5wVnhoazZDR0o1dUU1OXptWlhoRmJ0T3dZbzFGQk01ZUJa?=
 =?utf-8?B?MDNPcWN5UXVBbFFWWDB1aEZzMlhrRWFaSytBSWFqV0RwTEMwaHJOMEhoU0JM?=
 =?utf-8?B?aWVrNWt4Wno5L1U4V0NsemhPRXR3UTRvbmxUT2g1TitwZGR1ZjYvY21zOWd6?=
 =?utf-8?B?dWRpYUZtTXUrLzVYWGRsVk1OdXFkNDNjQmNwblRKOTN3bzZ6S2VPT3l3bDJk?=
 =?utf-8?B?TFRTaDIwZDNLZUl6SHB2L0l2aXpwb0NvNVZiN0hmSHVPcytpalNSMkUxZTJ4?=
 =?utf-8?B?WG5oaHJ4bXQyRlovQzJFWEtaRithb2ZZaHJLRGpDTFFwQ0dXc1NkQy9JWVNN?=
 =?utf-8?B?c1BFQ2ZlQW9TQzdUcjduaStYdnVVQWFXd3ltYVROc3ZNYWZaZ3JiKzAwQnZh?=
 =?utf-8?B?eERkQlhDUEVZSzNSNlVOTnNDbzlPRVBPUFp5WlVSU2N2N0l0dVFyN2FjUjFn?=
 =?utf-8?B?ZlRwOGRRQnFwWmwvL0V4WXdvN21wOTVvbk92OVB6UW5hMFJzRytvVXNySFRC?=
 =?utf-8?B?L0lHbVhublV4NksrN21GdVBIZ1NlRDVscXNMckhnMnhyVUQvb3FVcG4wNGg1?=
 =?utf-8?B?SnBSQjVCR1JodVQ4ekNKR0dvRWFzaEJycHB3dUlpUGZTOXZNbFp2cENCdVdB?=
 =?utf-8?B?c1p3dk9IdUhLSmlodFRvdC9OdnpMNDBDSGpWV0haRzdUdEZhZUNXcno2ZUI4?=
 =?utf-8?B?djJVRG0yZmJZbEhtR0t2SzJzaWkrZmkyT05MQXN3TWpYWXk2ZVFkMVIvY21X?=
 =?utf-8?B?RzNGRmtUNFd4Q0VDVFJIalZWTVpnQ2hXdUI2ZWZkWldwYlBwNzdoaGV4SnY4?=
 =?utf-8?B?Y2FpT0w0aWRDTVhkZk1WcXFrVFU1RkZINFJ2QzUwcFJDQUVnVXhCSEo2a2pC?=
 =?utf-8?B?YUtrZHhGRGR5TEJTalBpNkZBeG1uOGJQQ0tvcVNpTWJ6cFpyUFUwZkptQThs?=
 =?utf-8?B?OHlhcENhZ0wvTkdna2V5dzNTTEIrNGRQYjBERlJLNGEvQ0pQTGIvM29EaVJo?=
 =?utf-8?B?dVdzcEt5VEpmOSs2bUdjN2VqQ0FuTVdRWjZFNlNDeG5rZVh4WnNsTjZhRDFV?=
 =?utf-8?B?a05GYmV4STNrRW4vaUlFakV0dVFaQlltVXcvWFo1alJhREc4STFtc2NLeEll?=
 =?utf-8?B?by9odzNKZlFDSUJCSE96U0QxcU9uVWQzNWNDckVTNjFoR1hOeDRGZVNNa2RI?=
 =?utf-8?B?USt4RjNSVjFLS1BNN0N4eDlCa1gzN29wTzBMd3ZZYmd0UkdPQUZQNGh4N01X?=
 =?utf-8?B?YjNlWVVLS0xZOWl3dmdNd0laU2k2M3VWcVhjN1cwMlFack1tQURoZ3JUU3Zn?=
 =?utf-8?B?bm96bEV2MFduY283Tmt5enNzVXdXckdGOVBZOUJoVTc4ZWpPTkc2OWVYeGpD?=
 =?utf-8?B?R0NJTlc4RjBMb3V6TGVSNzJ4Qnp0Q0xjY0w2UEJ2K0ZkbkxsM3QzK1lPdmN2?=
 =?utf-8?B?emtkelVyOElVZm1IeE0reTl0SG43QlJZdjdLeGZ1Q1R6ZHU1VHdmaHR2SFJE?=
 =?utf-8?B?RmNLTk93anVMR1cveFJWUmNvc3o2cm9xVmoxbk1Ja2dKREZ6ZExUSnhxOEFo?=
 =?utf-8?B?ZkpwRzQzaStONmc3SGcwOC9UOGhIVWN1RC80emd6UDMzSEdYM01wMXR2V0d3?=
 =?utf-8?B?N1hUYXBpVXNkSTZzZ1lxd045TER1L1RRTHNJTitqNCtEZm9xQlNGd2psQzM0?=
 =?utf-8?B?c1ZKR2xOUnRSRXA3Y0lrc1NFSE1PdnFxQzdteEpSYVlPWXVJS2JxNnhaVVFK?=
 =?utf-8?B?NWRGNjBaVkpyVG5pNDR4OXdzOHBodkkwSWRsNkRHeGdCaDNLQmErUUU3NUpt?=
 =?utf-8?B?QW1VTzJ1WGdNdjVZdDNKeVp1b01QS3lpUkhwTkZWKzdDekdUM0RGVTZoQ3g5?=
 =?utf-8?B?RmhTbXNyNFJEd3F6bkRmT3ZtNVJPYTFBcHI4ZWp2U3RwNklRdzFmSStFRVk4?=
 =?utf-8?B?c0hjdWMrbjNBbFBnZm43OURXd2hNRHRhaDlIeVR6eFlnMmQ2eHJ1M3AyR0Nv?=
 =?utf-8?B?dGNHMW83OU80YlZkYzI5cEdxbjFHeDhnYUV6amJVMXFoa2s1elBVYnBvTTRp?=
 =?utf-8?B?VnU1c3dXSEhtbUs1TGhWbFlUN1RxWE50SmdKZmRSdEtJbFkxdlAyejVSeElL?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e9fe14-59fa-4ced-babd-08dc58f1b7e7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:03:57.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbsgwg362DDmtLUkt0DncUezjJmOMvxuRwWiPocxjonevjjD9IMWV92A4ty7CIjwHyxKR+qpEhBK8sXFbIUW2ZLGjscK0KHd/9ovo81TuoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860
X-OriginatorOrg: intel.com



On 4/9/2024 3:41 AM, Daniel Machon wrote:
> The wrong port config is being used if the PCS is reconfigured. Fix this
> by correctly using the new config instead of the old one.
> 
> Fixes: 946e7fd5053a ("net: sparx5: add port module support")
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Changes in v2:
> - Rewrite subject and commit description
> - Link to v1: https://lore.kernel.org/r/20240405-link-mode-reconfiguration-fix-v1-1-c1480bc2346a@microchip.com
> ---
>  drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
> index 3a1b1a1f5a19..60dd2fd603a8 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
> @@ -731,7 +731,7 @@ static int sparx5_port_pcs_low_set(struct sparx5 *sparx5,
>  	bool sgmii = false, inband_aneg = false;
>  	int err;
>  
> -	if (port->conf.inband) {
> +	if (conf->inband) {
>  		if (conf->portmode == PHY_INTERFACE_MODE_SGMII ||
>  		    conf->portmode == PHY_INTERFACE_MODE_QSGMII)
>  			inband_aneg = true; /* Cisco-SGMII in-band-aneg */
> @@ -948,7 +948,7 @@ int sparx5_port_pcs_set(struct sparx5 *sparx5,
>  	if (err)
>  		return -EINVAL;
>  
> -	if (port->conf.inband) {
> +	if (conf->inband) {
>  		/* Enable/disable 1G counters in ASM */
>  		spx5_rmw(ASM_PORT_CFG_CSC_STAT_DIS_SET(high_speed_dev),
>  			 ASM_PORT_CFG_CSC_STAT_DIS,
> 
> ---
> base-commit: 1c25fe9a044d5334153a3585754b26553f8287b9
> change-id: 20240305-link-mode-reconfiguration-fix-df961fef5505
> 
> Best regards,

