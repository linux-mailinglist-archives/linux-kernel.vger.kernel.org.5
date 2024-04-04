Return-Path: <linux-kernel+bounces-131765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E21898B90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D91F21D69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0432A12BF02;
	Thu,  4 Apr 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUe0utHt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75167224DE;
	Thu,  4 Apr 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245768; cv=fail; b=nGnZk0SvbXKtSy8lZ1qo84xN74eqS8bsJt74/6dI7RQMGyFJp4nsehdNfXjmQF8ULvGqZxCfk1VgC8mQXAF6Qrv0UC0cYA+FVKUwqseKMGYkLo7TPIO7uGmG2MwizTTZvUKCtFdujJbXoWoo2PrnT9stXaA/6PmhasM4PqBqWvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245768; c=relaxed/simple;
	bh=RTEf2TIJnfbEgPrX2XKPSxPotJPrwGrPl0V6qk353Ow=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NXmc5ph2OCzwddDAms10WiElmBBpEkrhNwz4JlgJtZtCBzCs0U6ugAMbxhnTnJo4rkfUEnx1l5s+y55Th+tZy5r5tmEiMYNxnUMwELuvBm4zLadTYtMcokVBlmkKXw7Xv/JQISB+75CZxDeAIbsIgU3/B8kFPbzu5fUDzq1uPUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUe0utHt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712245766; x=1743781766;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RTEf2TIJnfbEgPrX2XKPSxPotJPrwGrPl0V6qk353Ow=;
  b=KUe0utHttIDVky1lj235FsaJNw9sRftxPQIDqduejI/nNSwlAh4wU+XF
   qIRadSGUZczqZf4+s+2zsolevXAeT4D/SN4qcL3IPpYU+UdpQif29TtpN
   tgdSZnqIHYV3lWHXtGgIxaz/XDLIEI8hZ7/U6IaL29QY2FGaRP2RPWag4
   oU5AA2YoXvtbdhCCsOjQ/DmI7hL3A+yBFuONHGlL+Ul3ayXMIyumBOpaH
   EE31GTzJoO7hD4MPFHJOGz9Anu/ydD5KUpF1RukuajF6rf9bd8mC0JK2M
   iQpJwlLOos5938HWs8WKoBnFr6Jymd6ybvkzHfYRt46nsg0JSbMV1l5Cn
   g==;
X-CSE-ConnectionGUID: j9HaslfgRHmAnKqJDK+WiA==
X-CSE-MsgGUID: CsjLYutuREyjjvucjXifxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18897908"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18897908"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:49:08 -0700
X-CSE-ConnectionGUID: 09bMXkTgR0mKzFlDyRst4A==
X-CSE-MsgGUID: SuKmVpTcQymvVaNTVAJmNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18803916"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 08:49:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 08:49:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 08:49:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 08:49:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 08:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kF8ZTiBLU4PHIdjTwgOZjmXYHoz0Al8b4PfCDZGbqJUo939C/M7QiqHzlqRBphqa4C27iiVn+VNLsk+kmJgroACMfcPSQ0YMGcaNar9xF+XFmbqB79EzHdVZv8aYMU0Rz5SCcvyclaEZ1a149s0sFbw6dq2lukAkXy5WupPaLq9tlaZ7Q0IecbeTgEQujEPW6XqCoRlvMCjaaC1jE+ghIGNFcFL/r3B58mmADJ8mHngmOnpdNzKoTVdqWZqRoegz9rKbU6IuQpqjFiAPYJA+5HVNhynLSK2B+GEl82ZOc6DGYz2b2oWPxVtC5tiDq0Q5QpWwSEsap2wkcw/+9BLa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DD3kpEXv8UOFyh+YfcoaP2iFjnlJ32iQtaczenQuEM=;
 b=TTNwtigIlx3RpHWPkG8lASyJ0RRfquvnQqAv8kn+VGycTVKEEQczlQP+EX6YZjUw/9Trhl8OhQOhGSbD84AuR4UeFk6WZDm1MSoQf44L/Hts4B/hg7rUiYstjAs8hMroQBOsKIrAUftaVDl0cuHWcIGKld9wg1T/gafgKSZyauCXHY8qNLDL1Zv5BO/Rfb2rY/5oSwzU4DNxxvwGdE5Yk0r/TKOoqI2/fDka3LBuYxfv6Kk+4K4mTgxeQqqsX7rOE+7+IG6URcHci5WrnI9upNjju0ktSYyKxA6KbklLfGABiJXrwhOllcfK5PUYCBZwQ4qqUDrNi9zHTqqb1fhk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 4 Apr
 2024 15:48:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 15:48:22 +0000
Message-ID: <77f48552-5919-4a7b-b55e-f4895f90f81d@intel.com>
Date: Thu, 4 Apr 2024 17:47:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 15/21] ip_tunnel: use a separate struct to
 store tunnel params in the kernel
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Yury Norov <yury.norov@gmail.com>, Alexander Potapenko
	<glider@google.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <20240327152358.2368467-16-aleksander.lobakin@intel.com>
 <5f63dd25-de94-4ca3-84e6-14095953db13@moroto.mountain>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <5f63dd25-de94-4ca3-84e6-14095953db13@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB6223:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXZXr/Cwu0UKpKn5b+lVxtsctlOuDpXZltIYzZICtaaAdy/8czFUNUK1lq9ULPJ3ljcYwnoIUrXEirOVWiRKDRIj+Rsyfsr6SmvN5UI+N8UrmOtEPYpsVRHPLC2l6Ut3Wwq2hT/0K6I/YN35lHvUiPUQIp/mXN2KQlERdPltrngG9fBhrdHrkaFpb5ktE7GTPx4hFWJzYbHSFftwH8ZqPpEVtFUSDradP6Mz4+0RBUTpUcofGHMe599KI3CmVMzgxJMJlbQLO9VyqvCaaaEAERp/L0arVdL22R3jXykARmsyngVgmUr4ve9kgBjpHKS6SqZNanYdvAF9/0dvjw9h6UbSiP0nrh41ZOA66ZywAS/QmiEDQ3KosW4wbHTKcvtaG0OWWLmVl39JsAap1xmxRku6b5mEWVnnWuB9ffDJ1eJdx8Yc4xDNW3Ysmb4o3TtzmbfVeEhB68VZkUfpCDfI/PN4aOQvO7PHlpYGFAi/+mksLNVCtZNOsJ113bXZgLJFfvW2NS3c1VvkwvstKhGggrsHjH7nrhBsTebu9r7C2SZ3VBi2dnTrYJdCqVK70ZWRY6qEsLQLc5RqtM0j8cggqs8OaUrd652RUKITCs6o+8yyK1KAbysyoMc81QvDDLuqGaHlB+EivJIt1nMr8TSTs4nOvMsQboczKq/UuNekkc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWlON2Rva21HUzljVjlwbVBCVkZvcGFIdVA3WU15YktpM1gwYm1nTUdsN3dS?=
 =?utf-8?B?bGVSZFpGdHA5bjBpbGRaQ1VqUmd2dWUvdzl0aERwblZHbWFnd21RWmNYd0lj?=
 =?utf-8?B?OERtVlk2L25LMFIrKzY4eGJKQjNKdDJOc2VOeDVnZWc3Q3pGRmZWaHNDQlhG?=
 =?utf-8?B?aUw1WjR5MGZFZG8xV2ExWitYaEZjK3VkRUk5TnprQ1UyVTZVQmYycnRhOWFm?=
 =?utf-8?B?eG9FQWVxMzlFa3N6aG5ndXV3YWVDa1d4emUrQlhkVWJhaXRyUVRCOHFneUg2?=
 =?utf-8?B?RFRybVIxQXBzdmVlL1YrUWs5dVliZlhiZFpGN1FQaDZvYmQ3dU8ybzVCVjB4?=
 =?utf-8?B?OTJMTEFIRGU0WG1aMVBNbFFrYlE4N3NTM0dRTzFoYTBSYzZvYXN6ejg0d1ln?=
 =?utf-8?B?YnY1WThZdkNDL0xnYWVJaTdtREw0allyTmtNV0tBME1CZWhEQU8zSTVvWm4w?=
 =?utf-8?B?TU5WYmZTTlFjYjlyT0RlVWtJbWxXOW84cHUxQUYvNDdwMVRNdWp3Z2RZam5o?=
 =?utf-8?B?Z1JLSDRhelg1SnNrSEVpM0poejJjdFUycFQ0Q1hEZk84cmdPckFNSmdNcWln?=
 =?utf-8?B?aXVmRVhTZThTSWJtd2NGdUh6MHVzNGw4RFNadmIwRjZaQWpObEl3Q0xWQXA2?=
 =?utf-8?B?SW91SFo3MlhPSzRud1pJa2psV2J2NmI2OGp2QmZKSEQ4Z0VuRmJHdXpjRlhi?=
 =?utf-8?B?bGxuYWxvU0tyMGZqeVFCc052UjVOVmlMYlFtZVViRDErdC9yZEFrN0N1c21S?=
 =?utf-8?B?WEVqTzNvVVVuZUh6SGNMNzlYVmlHcDdGbDcwU0ZQbXZCS3NvcWJqN3ZTRnhm?=
 =?utf-8?B?TWU3ZzBjTGdMWkVWRWwxeWx6amZ6YlRQTTRKVFJ1azNpcENydG4wcGlGcEtL?=
 =?utf-8?B?OVB3dXd6R3V4Q1dFODRNVis5U00zeFh1cHc5d1RqVnN4dEZNR2swR2lpTTB2?=
 =?utf-8?B?SEY4TmpZVXNlNThYcnJUTit3TW1uY1d3MmZ3dndGbnNRbTdXekdXdXlaTzNZ?=
 =?utf-8?B?NlpkeERsMmdneW9UenA1NVRvVW44aFpBQ2hOWGZvWVZZL3FXa2NaTUhlSW5J?=
 =?utf-8?B?Wk5WaGNyUmYydmhDbEc0Tk40THA5VGYvVW4zOUZ0ZlNZUEV3MDNHNVlPZm03?=
 =?utf-8?B?T1VUOUhSQ0J3SlVZeWJWTG81MmNJMUY0aXFiZ205ZDlGTm5KaUgrWHU4NlJ3?=
 =?utf-8?B?cEJtWFpZUCs5TFlPNkxYc05FdXg4R2k2TG4zditUem8wWjNQaVR0VnM0M3Q4?=
 =?utf-8?B?aks2NUdNRXFlZDd6Q1hCMWN2dWpRMUdKcjlMbVhSOGo3a3FhVlJSVXpBbjlV?=
 =?utf-8?B?bGtGUkNUR29DcWJ1RDdQZ0U2MDJ1OEZoWlpaNFhvQUQ1TDUzU0NVQmdpOXVn?=
 =?utf-8?B?K0ZjOFJvaUYxUHVQbGs5blRuNW5HMzY2ZHBORHN2Sm5NZmpmR00rVXEyT0Nh?=
 =?utf-8?B?dFhxUGFBVU1tZmlia1ZpUnhIRnRURzl6TVpMMVJoUzNxcDlFL1pDTXVQSWFp?=
 =?utf-8?B?VVBjQjk0cHJhR0R1ZXl0SHE4bUNINEZ6QzNvaGpWOFZ6Q2MxYzFPYTJaeXZY?=
 =?utf-8?B?VFRSQVlRYzJUTDMxeE0vRVB1S0pRQjhzdzhqdkdWVU8xN0NiMUswbndmZDE2?=
 =?utf-8?B?ekhVSVFnRUxGN00vRUhkUklwREo2ZnA3c3YwNVJwOTJ4RGg3YzhuQnhoZFI2?=
 =?utf-8?B?UXJmNHg5VlhkWXNnMUVQc2ZscElKZ0Q0bFR3TkRtQ1F2NDJlaStWNGtsU2hU?=
 =?utf-8?B?amhpb2JSUG9jWnVnWmZhOVhwZGs1MU1odUltUEh1OWI4UmxwZG1JeTRvUUps?=
 =?utf-8?B?SWxGbHNPOEtYdmh2bVFpVWdoMWZkM1Y2VWlZUVBGUkZtQzBtcklUZ2EvUWsv?=
 =?utf-8?B?T01YVElUdFQrV2VMekIyT0IzYnhxS2VBUHBqS3dGWDlCdUJuWUpwdC9QendS?=
 =?utf-8?B?dE45N2xKM0VkYVRxTnRERmRLRSsrT3JNOXk1ZlpneVdNdzB3dGZ3QzRSNW5l?=
 =?utf-8?B?MjgvRFQ3VTcwM21WUDBzWUdvRFNDSGV0azdzcDkyS2FDYUg1MElrYXQvNHBR?=
 =?utf-8?B?QWZGK0xpbnlSS1NWbFdzWWM1TlE0R1FsMk45anVzV1QzYnV6dXZLQmUyR1By?=
 =?utf-8?B?bm40MWhNZ3d4a2NObXkyRmQ4NkZMdEFLOVY1YlFET253UFhkNnRUenMwdmdl?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b868d52b-6586-49a5-1eaf-08dc54bea81f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:48:22.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uogoPLm4C6yKBF4ZLGXXlTHwMXV6WRZgBUIixrdiueNb5ieMyz94wpLEaYB7LYNjOmHGRUMPnN/PlGCz9ucMTgAqvZBUCFbyp4IsN7NxaMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 4 Apr 2024 17:24:23 +0300

> On Wed, Mar 27, 2024 at 04:23:52PM +0100, Alexander Lobakin wrote:
>> +bool ip_tunnel_parm_to_user(void __user *data, struct ip_tunnel_parm_kern *kp)
>> +{
>> +	struct ip_tunnel_parm p;
>> +
>> +	strscpy(p.name, kp->name);
> 
> We need to clear out p before copying to user space to avoid an
> information leak.  So this strscpy() needs to be strcpy_pad()
> 
>> +	p.link = kp->link;
>> +	p.i_flags = kp->i_flags;
>> +	p.o_flags = kp->o_flags;
>> +	p.i_key = kp->i_key;
>> +	p.o_key = kp->o_key;
>> +	memcpy(&p.iph, &kp->iph, min(sizeof(p.iph), sizeof(kp->iph)));
> 
> And this memcpy() doesn't necessarily clear the whole of p.iph.

Oh, let me send a follow-up covering all this.

> 
>> +
>> +	return !copy_to_user(data, &p, sizeof(p));
>> +}
> 
> regards,
> dan carpenter

Thanks!
Olek

