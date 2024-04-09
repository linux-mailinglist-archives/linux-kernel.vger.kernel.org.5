Return-Path: <linux-kernel+bounces-137737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A9889E67E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072CA1C22723
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C721591FF;
	Tue,  9 Apr 2024 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzC44ZdZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1324158851;
	Tue,  9 Apr 2024 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706980; cv=fail; b=GNp+ONoLBbmdQPxITduzKFkfSTJUcCLdZytSzcDZlXyNK/hKB3e0wEJBStJZMcjcVfQHzxbLPKOUxgFcGWbhcTg1+i4PeqtfC9rdKTEi/ZkZiq9Tdt3xhUnte64aMN1hzdB3kPYCkbzsUDDR/hhlT9fpzDiTh4aAv/c+YueYLxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706980; c=relaxed/simple;
	bh=LRUhS/78RoY9ZjXSUqX9bo6vMUrstkUwoQoprUleyd8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tgNXSSrqdJQg4xpFH3x4SkiKXbATi78X0Xi46KApm9JNMlMAe08M5y11P9ZTBmDlWXbS37YX+D1L5zGaMB/SL96YVhl0GRPoPoDvT/if/lVpVZmJSQl7ovpMQN8hg622fmE2oSjr9TJJl2R4Xt+1lxw3QJ0OPAd+wp5y5+YYxzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzC44ZdZ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706978; x=1744242978;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LRUhS/78RoY9ZjXSUqX9bo6vMUrstkUwoQoprUleyd8=;
  b=nzC44ZdZT2D6XSxElCRcxwPNbgg7t5rONulYSpBHTo0/sCdEJO8UBUuK
   ndXqXHx859s9L/Hrs0o/XUyxJ0TiN1Jz08pAXMICUkswfOvgKPRc77i5Q
   aQKphhm2VlTwdU535ZCenRSd6yMwwmAFavCastZHVZwKum/ZSVMHr3xeF
   gxipi/A5Ze+L09vV47OnZk6RsiNayYFv/EuRNUmPaCu+Rl6JvvTORJvC4
   ypxbAZNo1X4tBMfEpUPdsVdIp5cthgjWi23vA8I5+HNBVYNf6RlZEdgyP
   h2W4n5DIx5O9DdpziMsxCrYlYCjp+T9DwDphrGKLBkiMyxug4TTGmIKyU
   g==;
X-CSE-ConnectionGUID: GJIP9eeVQNW4xBfVarKf2g==
X-CSE-MsgGUID: rycGv6fdTiKnuRD7/0l+ow==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8276296"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8276296"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:56:17 -0700
X-CSE-ConnectionGUID: 3gBtxnXSSrGWm3v9wgj/pA==
X-CSE-MsgGUID: IqaDHd3XTN+/YmjMtQ5naw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24878486"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:56:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:56:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:56:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:56:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifn9QtzJ0D9icDqbM91DabTZkGy4NQjOuzKEJEbxbeB0DB73M055TAJDXZnDwgcDTasFlVV8Mtj4GiWtz5EGMYApAoqs/BZOzniIUj3+oNHd8auSwliTMvg0TAbsCTiKBcjtO+jfIzN+sPEn43hLuuTf7LRGaUO9WJjEbvjQ06yUmiaeshQLNztrKS/+e31CigmC054oSlKqrnXlwKgyIBiu6uBhoKIJh5lcjdJpTfn/WGN1MvVMHmZCBqxGVs420PS/dJeXygZttJhZ3URkKwuvVvY0CRplu8lxo5ZaqHXunbjnMqpbmLkAIDpRAzvzxYMB1whPI6tY7YxWI5jD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiMqh1y4IklxSw/bSDgov2nNGzHbf9MxfCQa12OjruY=;
 b=DD+Z9a06KtLPEg5ZkP5xDe0XDa58SHH0eozYLN2r/1WgVWJVGcyqV/UL05oDcF5/PsIliiaHqf2lsgzHVOM5zWJZA4sS0OmWNN+wq70/zGC55HSe0bp1yFKWWbJOHSZRyrrydaeiCcoCrYE6UHrTFeQ8d6sIwHowADCmQWG4s+3EjbUgX9PLsO9Z+GwX2nxYLPzbwxwx4bLV4tZDzAsziBG2Thi1IC6yk3mVq+IeKUpf1QWXEFDYEkJTd93Kgmf3uIYS9WICYmvHhaD2c7Vpxqg8XOYVz5ZmHpq1aCcgrDjZiX0llAqyjdjUmTcfnUQjP49u7Zbcj0tCzXvCWz2OIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6945.namprd11.prod.outlook.com (2603:10b6:806:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:56:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:56:10 +0000
Message-ID: <5dfe587e-b868-4066-8597-63cc3578e928@intel.com>
Date: Tue, 9 Apr 2024 16:56:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/3] net: make napi_frag_unref reuse
 skb_page_unref
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
 <20240408153000.2152844-2-almasrymina@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240408153000.2152844-2-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:303:b8::18) To CO1PR11MB5089.namprd11.prod.outlook.com
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
X-Microsoft-Antispam-Message-Info: ovn0NBIfN/weDmQkzSpbOV9paT115weB1fUL0LLhmZ2tMAUWMTXhkODecXsq+tBE9xNLb7JZfKYNCr8QqeHCRMREHaHb8EMu3wcWf2Nt1OfeoFi0dDruixCoho/umDHeJxFGhTJfD5yG63xLDAO539nKuQkebdtqjZlAoaxCkuGXQCbsSdA/Xsjce/ycyhRJoc7qm2OLfWjQxyMGQ4NKk+WAPguV2/jw8/AA3f8QkticHu3t4P+5haj/D576d9mejJ8Wgm6Y4GFR/kCYyqlRgYIQqSDMV1r5SxGKAYjStxQh7ivzNlZ9A2trbt4blFxLNzQnpW3QRhViIjVJsNhB6FsjPTVD3muiFeJH8fq23cW3V5LrNUY1/UWmgXDS1b+GWe0FrzON6P7atIx1QamD2Nk6OgYnn1YrS0JcCTRDNQ6wX2exxFGoo+ZMWpXx+IEfAByO4X3BeBL+7d/Wq4GNr0tCsbveVaJaJRKpTzUAt0ykzngt9SRXi26yKRRzVMVTcoHwCqWSXXhBN7A5ryGo94U+R8myQ/m7CYDxF3oGiMV/Yrjr+NyCRud1h9VjUL4RmmJpD9JQ5/6yA5RPTsMP8nEM8iV8jPP0t4wHU0yBUIf/JDbHPBbGy+0AqEiGI6m4agfG9zbT3rOWfGHrM/WfhWvbCQhXqXSs2QXUHvu8CXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2t2YWJkaTFQbXhWc1hUK2VvNm5NUmFLQ3g5YVJIU3VOSHp0NnlmaTJiT09J?=
 =?utf-8?B?elA2bDRoQkZUeHlMM3VkU0ZXT2wrY0VkM3dQTUhqTEtFM3B4anIwU2JnT3hl?=
 =?utf-8?B?OHBIK25GVGgrWnVGZTZiUmNvQ2lmSjNNUStyWjliZ1ZrZTZldUw1cVdaeS9S?=
 =?utf-8?B?NkVBeGMvUVloN3dZYldRbEEzZW1OWkI2eVcwQ3NzR1ZHNDdmb09acFhybnpt?=
 =?utf-8?B?bnVCMGRiV3RYc1dPVFY0eWw2eDMwL2hhYUdBcXUzb284OGhTdzcwSmVCQmFK?=
 =?utf-8?B?UkFiMFR2SUFjcGFrMTVzTmFXaWRQT3NPbHRsMEZzK2wyR0xDbU5IY2NNalB5?=
 =?utf-8?B?RHFZWU5vOG8xdVFZeUpiR1JMU2VLRVB0ODIrSXU2c01tNXVncWtqVTZGdFR3?=
 =?utf-8?B?YUJjMmkrMXlybjJEUWxsMWVFdmpMa2hzZ0VJWERteXBiY0dBbkJoL2R5SUJr?=
 =?utf-8?B?MmxRV1grU1FqTyt4VVVCYmErOUpTUlkzcDBQVE5vMkxsVGloRjgrMlJxblpN?=
 =?utf-8?B?dHM5MXFtTUxYQXZ5WGVBWEhyd3E3MEZsTnRyQ2VIeGtkK1BrNGc4ZEhKTmxH?=
 =?utf-8?B?UnluQjVQYS81UkU2WnhqVlNoUXJHOU5neEdEUFJqYmErQWcrZDFvN1h2RWY2?=
 =?utf-8?B?d1g4NllZdEMrdjhCOFdHN3NuRnc1eUVxbXF1bWhYVWh0Z1g3ZDB4c09XekZD?=
 =?utf-8?B?WG9HaWVYT3BCUGliTVQvSm1PcFk1NkdSZ0lQMk15VDMvVC9qZ2NPamlKcitB?=
 =?utf-8?B?azhBWi95dDl1R2VqMkxxTmpWeEFxZmJpYkxLaGIrbDBxK3o4QjRJRXdTOW5s?=
 =?utf-8?B?T1VqOWZhZWJkTHlpMXNYMUpXUXFJNSsvVTFvSmRsajZOTW1XRXE1M3dzTXFS?=
 =?utf-8?B?dDBXTlJ6OG5xa2xIZE05a0taR2FIdUROZUJDSUcxaHpQSHErRjBlZGtuTGtm?=
 =?utf-8?B?RVhWcHpCOW1IY2U5Y2Y4OGtFc0kyM1kxZGVkSGRUbnk2WlFqeVZINE5Bb0Ev?=
 =?utf-8?B?WStXRUJCbkR6RG9IYWd6RlhrYW83cGdvWStZM2l3Ukg4TnVtaC9nK1FOVnpq?=
 =?utf-8?B?RStSblpJcTJBRDcyVWZaRjJ5Q0hSTzJUVFJvRm16bFVOMmNCNE85MVF1VnhW?=
 =?utf-8?B?K01wRng1cFN2YUlGbVZrR3NTZVQ3V0xRNWphUy9iQjNWak9tZUlMdmRYZE9v?=
 =?utf-8?B?R3BYelJEYnRKTU1YRHEwVkJmeVZSTUc2ZE1Oa3hpTkxiOTVuNzR0VktKa202?=
 =?utf-8?B?bjR3aUVwNzhma0p0bWpRYzMvSjF5VjdHT2h1ZXZ4QlcrRUdmeWltNGdZeVlJ?=
 =?utf-8?B?dUJxcUxOL1lWZ2dDRklZSXJCZnhVYlc4M2pYRUM0RXhNakJKM0thV0xwS2Vm?=
 =?utf-8?B?cnhDYlB2TE9MZkhRVi85OHN4TStJYWFTdjhIeW5DNXlWODdyNEpRNjBYcEl2?=
 =?utf-8?B?VHZTNEdtRXJqckNKS1A1bEhZelRMNllYSHJuNmxhUXhqb1pLc1dmaUI0MHln?=
 =?utf-8?B?dUFla1o2eWhxTW0rS05WOWxVZ1FKbEJjWExwVDFsZUFqSDZ1eFptOEsxUnB6?=
 =?utf-8?B?eWc5NGtRYjlrTW1teElGK3BtaFR3WXcvQmRwd21GbVBWWWxXdnhNbmFqRWJ1?=
 =?utf-8?B?VmZFSWFSWHZQQU94MzZsR1JwdTNEeTVkVWxYTjk3ZnlpT2ZYVEY5VHVBZUND?=
 =?utf-8?B?MmlUZVpFRC9kQ0NZS09KQWJscnl0alQrNnZlZWIzZk5GM25rdkRUTTZXd1Zo?=
 =?utf-8?B?MVNsd3ZsVjhoUjhleUVwMVdlUjdOdGU3Znc4YmN2RVdWY3k3OUZlQkxNT1JU?=
 =?utf-8?B?ZlBJZ1BESFpMQ1ZZS2xNZnFaTm9nTE94VEpqSVUyRHhEeC9nbGdJZWlEMlJM?=
 =?utf-8?B?ZFFrMGxmS0wwL01EOGV6OEdqYmc0dGxsNDI0SndCY1I5Zy9sNXZQSjZwK2xx?=
 =?utf-8?B?SE5XWW5SbmxnQi90UlhhcHgwa0RSWlI3YUNjbUQwZXVGdWpLVU1KeWZzTHNs?=
 =?utf-8?B?MGtEc1pMMGJBZ2JtcFUySC9DZGM5Q3VzWE9MaEE5MzVNc2pDVk9ndm5ranYz?=
 =?utf-8?B?Sk9Cdms5UmVrVnprYTZKWEpGeGdScmlZWEJNdU1rdjhLWWNlelBQQm5YT210?=
 =?utf-8?B?QStyQkpCM2VrSENwNndmdEdNa1pyc2haNUdmQWkxRm9tcld0NXEwQXdwYmU2?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba22ee80-d1cd-47da-3b0b-08dc58f0a195
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:56:10.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYjLKAzoXaYI94At+8D72cpMs2y8HVrXCc+Nzpju/bwHF3TyJ9TmsOe7Vol0MicJRKztvg72aPySlytvDknpjWpishu5JdpWant9O2mJgow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6945
X-OriginatorOrg: intel.com



On 4/8/2024 8:29 AM, Mina Almasry wrote:
> The implementations of these 2 functions are almost identical. Remove
> the implementation of napi_frag_unref, and make it a call into
> skb_page_unref so we don't duplicate the implementation.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

