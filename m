Return-Path: <linux-kernel+bounces-137739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0EF89E683
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43526282EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62FE15920B;
	Tue,  9 Apr 2024 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z89fzQ7u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265C158DDE;
	Tue,  9 Apr 2024 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707106; cv=fail; b=VEv8n2u6sqymwzPJ1RbLk+z2Wx3hmEiQ0WAoV1qPKXu3L/ZY7yUDKj39NHOOzIFy0sIYDR/7SxGVMWraQGeIjxALti8LuLARsilWzRI8oTJdlmm7XxSuWXrWB3yekYbmRORcuXHFceamZHXec6BsS1LbFj6oo2qsTue8YwcC5lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707106; c=relaxed/simple;
	bh=TIzPRkHKq3FM/hitLlV2hw4L7BcPCAIwVY77AuTpF6Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Un+USWQbedl/hXBEnBHaHJI665yY6U5ixZf3AAuw7Bo/ScPyTHDapRHG0PR3qWqAM0WOPCAI+2E0fGehOe60+x0fVr7yeEC1J4RVS/9Xx1lEm8FDeGPXgWVghIHQMGV7n0ugCCfkvjEXmvdgT+PM9e7EI+ZqRwXT+gvQ5Q4jmZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z89fzQ7u; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712707105; x=1744243105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TIzPRkHKq3FM/hitLlV2hw4L7BcPCAIwVY77AuTpF6Y=;
  b=Z89fzQ7ug7S1gzrMZSyW+UYHAwVegY1tvLEJeyRVNUiRV6RZYyHO65hk
   f0cpJ7wNVthcQPdgGVrKjB1SfpCjyQTl4GDj3zC/PZs2DJrd2b9Kj9B6x
   nhPJB3Bc1Q0DRykGpzS4to43o+OLJLeSRiAET95ui38MDJQpEtTJ9QTsR
   8X4yOa2Hv+JUE326kTdLEotgvwy8vveefevGKpbUZ5FkTU8y6CJPGywJi
   4iiibDD8EfrQB5O340JhOy3KaXvYPWYAaZSYETdBrBhn7IksmX8pKjPAe
   Pu2k2kNyR24iB0SLQUSCLJ3M58zQat6m8GPCzkv3dwlBRxI80pbyqWz1I
   g==;
X-CSE-ConnectionGUID: mMemZDtgSrSfil3F6nLk9Q==
X-CSE-MsgGUID: 6fWrmwVhQJiCLASdvcBQ5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8276462"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8276462"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:58:23 -0700
X-CSE-ConnectionGUID: nf5ALM/9QQafv4gAEKtRwQ==
X-CSE-MsgGUID: B9r3p46zSgqJuw/k8DjbSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24991684"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:58:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:58:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:58:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:58:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:58:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le6/xpmTnNvke68JnT7eEIqnkwJiAC+7aYvss+CF7AJ2WiET5xLmZdk9d43faq/8waK8LCMf++USVcISzDxHaN5QL2ZoUCv57WGKKHzMtjECyEkRG+3At8gl3q4AK2DIo0ijJi7NEKtJvwHNjsTgy3NwcXhw7q9gHPWdY3y1kft1jHTn4QJaP63SUwB5Jn2SQ7CJbZZ4j3N3YIzpXKF0EEZm0nYJSHbcU19632gtCHlzwexut4aknnr0e28w8vV09tjJVU92PBfFG6wRr65lr2j65RKM4N7jSqPrNUZTjtUB3sLMAyAUIgpDptXWm9FaM+SkCqSghIkGtoVh0EnmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fJ9gU6hFJ9HKnX40GOJXWU2L9R4/NNYuvWjMO/APsk=;
 b=KTraQg1wd+ob2h0t1zEja+015w94bQmN1aHPGrmkIU9/jAy0fyHUlFmoKYi7FdxhBnIc9XqzZBAEevcg1UvPqhn5MG1iYqqfuuKzl+hIV8pkhJ+jauHVgjDeXJ8K3IXuWR0nokW+Mq7l0XQpu95Bq4hZqizC/G+RWwBQNpwVGwrs9PnH5XWCYzEzT9fph6YRzUUZPtOKAC3bjHkzxEuJEmJ+imlpdtixsqjQy/YhhOb3QacsWYp7Y4ioyVndxriSlto1hptoVcXFKU/qBzSlViguwWd483KBVnCeyJE2vbyIc1+JHCLDQbI13zEzzJXD7i6mCeqqgJB0jZHVzv2NlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6945.namprd11.prod.outlook.com (2603:10b6:806:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:58:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:58:19 +0000
Message-ID: <1353da1d-4f48-434f-9582-cb89524f869f@intel.com>
Date: Tue, 9 Apr 2024 16:58:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/3] net: mirror skb frag ref/unref helpers
To: Mina Almasry <almasrymina@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Steffen
 Klassert" <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, "Boris
 Pismenny" <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
References: <20240408153000.2152844-1-almasrymina@google.com>
 <20240408153000.2152844-3-almasrymina@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240408153000.2152844-3-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:303:8d::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6945:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jlw+2auKuMwLR2cW5KRaVW3uJXk5TjXQ1DMRSkloh3iJix9ho6k5HnDBe0VAEus4GO48DM+Z7vtfbtdU/+W09vhS+5R3k+/lowrYoSBv3rILLVospTetIu+TQWBATI6dyJKfFdoSjHM/8yeaPs3NqcocvbXeBYqsTKuCfa9V3n2B1xbCjjbgJhZL/Ay/5iRrJK8g45zrVE2yvmrw6Xubx0hYN6DxYAkSNoL2Hj+staxZ/S/uL/b43G6cOAAujQunPYOfM2IfyD8KfTW6RUWPYxv51ueG/YqxkPszUZJ+hXiZPHI3vp+tLaJN7aZ+91iBpSu+jnUeM9CUfM3QHDqnX6t0Cmh7pdOyZtmlD5y36zKChM/dOenvjLZpch1IHv26ePShNIzcxlBFkjnQwfvFOd5RVHX2lRzT78Np4NvkuKi9W/g/xJTZmrwGR/2pJnXu0Xmwlhk5QI1YZKvQWUYfNrJuGgwphGjSdDrYRmPtIJuB7Pyafy0ghMTC0kA/n88RVjWkqExoNW1BvE806JZPNHqAVX2JSpFzUyEZLBm+IVhonMyWLASweDBWQ5nNi9rD9RpWyOa5qE3WjjwrYBY7pG0tK8YfWw4tYkZpkW4r+fido9HQMyAK6CvvqSPKX4zls0y9yTSN+47K3TrfocBMaIekLEHEpcu8FYZ659QGO4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEdyb3NPaWl1clY2K3RvQTZLZFphbDVRTHRNSkhJc1lORXdLTmEza0t5bnhN?=
 =?utf-8?B?NFlRWUt6dTUyWTh1YmFLcnRabkloUjJjclMvcU9wdlBpanJadXduazMwNE92?=
 =?utf-8?B?K3dIcjhaOXI5cGpoS0F4N2hoV3dYTXY0Nld5NkxzOVU1cGxrMGpQT0VmcTRU?=
 =?utf-8?B?NVhtVjBmczBxSThWQys2LzI5RDlkM3dqSkZUSzJ4ZXQ1RUdTN2p4QnpaQUNa?=
 =?utf-8?B?Tjd3cWdmSGhmUm1mUWxNdGdDQSs5WmNhM0pYcTlFUDVQa1RqYnFDb2JIUklS?=
 =?utf-8?B?bkhQVG1ocHlhYnZTbXJtNTN5UjhPR2N3Nk8xNkp0TlBFL1phOVlKaDlJT2VB?=
 =?utf-8?B?bGtpYWRyUDdETnpZR2MvcHJsN3BlQkRrL2xadysyQWpLdys0L20vWEljQm9Y?=
 =?utf-8?B?ZWxtWVkzalVheDNlb3hsR3BCK0JTQVZrVGRyMm9lZmVJMjVsZUtZem9JaExW?=
 =?utf-8?B?U3BpYjBtY1Vra255bHdJcHp0dlo4c2x0VWx3UFE3bnA5SlJpNFpkWWYzUVVV?=
 =?utf-8?B?TlR2THVVd1IvU0Y5Rk11NGtMWk9VWk96ZHNhYzk4RTEvZ0RhZkNZc2pOVm5r?=
 =?utf-8?B?dW1qeUhkWUFKYzFYczJOTkJkc3kvam1Na2FyNXdnSGZmcVBvL0hpTlNaZDBh?=
 =?utf-8?B?WVVrNkhlaks4cmRFWWc3clJHaHNNSTJ1Tm8zZStvMXhmdTZFOCt4dk5hRThN?=
 =?utf-8?B?Z2llVURBMnpoUlNhN3ZuK0ZQQnZ4QldZZjRUQXExcXM0bmJySWtOTncxSXVz?=
 =?utf-8?B?eE5QL3VvY1BtWE5xUXdCeWdKaXpKRDc3SFRVRG5zQXk2MjVqQ3gzKzZnMTJs?=
 =?utf-8?B?akhzZFJqQUdraWRKWXlIWUhBMGtUNTJ5aFpLTzdSQ0JWKzBBdXNBR21MVldV?=
 =?utf-8?B?UzJYZm9tL2dxMEJ2RWFybEpzRTZnRlR3V3RxK1hHU0c3Rk5BNGFrZlNNbjBK?=
 =?utf-8?B?NTNPMm5HRzdUY3o3RFlVTlFZMmxrNjcvQnZBM2RidG4zN2cxZjR3VExYWWFm?=
 =?utf-8?B?ZGE5UkRjUFMvYU5JSk9aTEE5cXZ5SmpmQXhjdFRtQjQ2R05aMStjdGk4dS9R?=
 =?utf-8?B?UXlENW1hemI1Z29OSU1ZMytZdnBrM2VtTnhseW41YVZacnNENmhXaGJLRXp6?=
 =?utf-8?B?RExDS0FPT2NZVjBuTHR0V05kQmVqdVhIcFpNb2Z4NEVSZlB1M3R5TTE1SDNC?=
 =?utf-8?B?SmpiRGJka0NpTlZjd3dpZS9jenBoNnljcUJ5V3IyVGxBSXAxZnhQSGlHOUho?=
 =?utf-8?B?OC9OdFZ4NzVwV0RIdE8ydHh4SmZMRGdtbG9Jc2xyYllRRUpBU201c1lwOVNR?=
 =?utf-8?B?dmZzQlVZbnpWY2xJM24vYTRVYVBMeFVsNUx4VzcyWTFZbkZNSVhUNDV5ZllK?=
 =?utf-8?B?SVJqZWpMcDBRaDBvZ1VrcXd6amNQTmlHS3AxY014Q29ISFpvSXA1cGhsNk9S?=
 =?utf-8?B?UmhZTThJdFFPSDU0cDExMXNJc1ZqR2RPeUxWSXB1OFl5NjdlUFVMbkUrWkhD?=
 =?utf-8?B?bmFDcDI0em9PVWRrVmVXeTZkQjhFTDg5UTI4MlFaOThtQ0FxYnFJTFZ3bks4?=
 =?utf-8?B?OWpTdVY5UFVNTjJXTjRmdW42TVNBNlV2SzZCTWZxOEdkQUl6S1Vlem53aS9k?=
 =?utf-8?B?eWpGdHo1cEg0c1NHTkgzNml5cndhbUtiWkJKWktrU0tZSU1LL3RJRmhnYktL?=
 =?utf-8?B?L0RBMGVvV2IvbnY4T21YNG8wVEwzUGxyY3VMVUJNa0laZVFsNVlaQ2FrNzM5?=
 =?utf-8?B?UjM3YU9JNjVpVmpBT2gvb3RKQlRSZkxTOVRyQ1NvNXpmTFpkOEpEb2ROWC9t?=
 =?utf-8?B?SUZrcERKSGFNTmwrRXdoYmVteUYvRVJNbGNLb05NTzZuZ0EzRDJwV25yaU81?=
 =?utf-8?B?a1R5YnBtK0p0SVQ1SStndTdZZzhIcEd1YlhLR2wrOXpWbDlpU0NFc2s2YXdI?=
 =?utf-8?B?Rlg0Syt6VUFIK055bkZpS0tLVUhjTG5Ia1NUVHViU0NSUzBCalgwWXdWUGt5?=
 =?utf-8?B?cjNWY3lLRVZobXlOR0FTam1ZKy9rTk5xUThVSFpHd1d1WnhTQ3p4ZHp0VUNY?=
 =?utf-8?B?NzkzMjVPT29IaUUxZDVnT0VZZFZQKy9pdlZCam43aG5JTmkreGhUQ3ZxQ3pi?=
 =?utf-8?B?aURLYkU2S2RvbmZNZUlJN21UWkdmeTV0OFdhNEZKbnlIYWdGdXBDUTB1TkxR?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc277460-bd49-47c7-6b41-08dc58f0ee88
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:58:19.7852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGoxStNdw/at8HEmW02GUPZsZIhLz6o56LyQ3uMe3epoXbJdZno1erkkr1uy9rk9Ipn7Qt6UPe8b6lJTvPO9i4b51KczJuHzU4k6NUU5VOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6945
X-OriginatorOrg: intel.com



On 4/8/2024 8:29 AM, Mina Almasry wrote:
> Refactor some of the skb frag ref/unref helpers for improved clarity.
> 
> Implement napi_pp_get_page() to be the mirror counterpart of
> napi_pp_put_page().
> 
> Implement skb_page_ref() to be the mirror of skb_page_unref().
> 
> Improve __skb_frag_ref() to become a mirror counterpart of
> __skb_frag_unref(). Previously unref could handle pp & non-pp pages,
> while the ref could only handle non-pp pages. Now both the ref & unref
> helpers can correctly handle both pp & non-pp pages.
> 
> Now that __skb_frag_ref() can handle both pp & non-pp pages, remove
> skb_pp_frag_ref(), and use __skb_frag_ref() instead.  This lets us
> remove pp specific handling from skb_try_coalesce.
> 
> Additionally, since __skb_frag_ref() can now handle both pp & non-pp
> pages, a latent issue in skb_shift() should now be fixed. Previously
> this function would do a non-pp ref & pp unref on potential pp frags
> (fragfrom). After this patch, skb_shift() should correctly do a pp
> ref/unref on pp frags.
> 

The description sounds like a lot is going on here, and at first I was
thinking this should be split further. However I think that would just
end up with a lot of needless thrash.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

