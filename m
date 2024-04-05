Return-Path: <linux-kernel+bounces-133227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4DB89A0D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C291C232CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73A16F8FF;
	Fri,  5 Apr 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uk8ZphZ8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D416F85E;
	Fri,  5 Apr 2024 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330254; cv=fail; b=XLBc4jE4YU9Or2tv6HWLF8uS0DfKY/MiU7l42QE4KvETmTCtBaBFq9BEb292spBQxJ7dfaOn1rt4dDJg9YWST1t6AuhnJOz05fsi+4lr3Uh2um1oEmn4GacjmgJ/jjQUiff3GWaFBxAQeK17k5o60Ro9RySrzfPjbsusA9twxiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330254; c=relaxed/simple;
	bh=dsfRNxJ6LfvzL8E5LJ5sM8aog75ZAGmDN3OFgH9cy3I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YDV+C8w8r84eZPaXiW+/yVh/x+xl8unGznUmq8nm4HM9IjdsfyXIhwKPSWsu5q5/7hKAp2Ka7WgTZ8moMH7SUPkVPlOxJ0EHomJ3yWHVJZib0UnpYXoLrdj5PfojBD+6ZpXjyTNxVOkkUzG0l1O6ilTeWcehVk7rrKpCgoSNt8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uk8ZphZ8; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712330253; x=1743866253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dsfRNxJ6LfvzL8E5LJ5sM8aog75ZAGmDN3OFgH9cy3I=;
  b=Uk8ZphZ8AEI1R87ocLrsSGIF2OYQj6cZwlc9ByLIpvIiz+Na/2YrkULw
   G+qlcb8RPfHhJzuGgsJh1au0gY2wrynVb87d/D6rlUmTFjCgkKRa59jN2
   S4rq4/EgcAhs0FsRtcbweWQsmyceME+wBTZFm5sgjR8LsyioAeGsxBr9V
   BCwwy4/ZWDLeiqHCw0PHXA6UFYmtDa7NNuc5fmFb5Dmwn4oBxyAsJMALC
   ffjfISl7gzls27aB82FZz/nyfpA/UBQnQjSIAZQYj0YyUORm2xtwtsgFC
   ZrQ9EwJQYoDXmM7gIdIoz5WhYQ3Merq5P4F9Iad8VjzqlaqX4hqaNJ16H
   g==;
X-CSE-ConnectionGUID: aQcpfMjgQc6tzz5Gwmh9sw==
X-CSE-MsgGUID: Vh1tHdh0S1i7EQE79LMksw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="30141217"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="30141217"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:17:31 -0700
X-CSE-ConnectionGUID: Wz7MCup4TKutb8VNCP1LZg==
X-CSE-MsgGUID: ig4IabW5QIqyS6T0uvC9nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23884993"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 08:17:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 08:17:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 08:17:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 08:17:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 08:17:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG2/bcJ/yKM7B3YZbnbwiWAmwk8W4C7YAJ0Liq7CUfKQobHZuRRjguC1x0kCIsEQmCbBXZxE0g7okPmIXvcpxaEz6IXy7b7xmv5Vzf3fUeDipqyTD994nFJYW3We/xhLBVEtGwJCXMg1VzQaAyj995QYxUuCgBxYCgjd4pCqT8ZblYknxFoA2zF1aUK2XSaMQoNLS3ZWlzzytYDAO6VYag8nU5JFW+gFia4yl/Z6TVxVdS/xmudQXjGLehzrI9WjXWqwKkhBAJXGqyrhfqNvDlfchBFAVhLDbTXllabzsl/nOLy5AcItl+KYPwk0/R2eC9QkeYHwI+WqMziw3o+eCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG+xksG2yMFl8FLFDTBKjtteSqfAssyX9OA4WeO682Q=;
 b=d4CdHXKinrF5my0LKfMWKN2tc2MnFl+237XWLCk5zAj2DsZmv0VAJ0B3V/ieIi9Od5SeTm/P0yijJvRSeBHxtrTq0m5iIYX3QP+cikauO+RN5sHFfyJCHWAQc/yoxaNZkLUF7aBAwg2DbKx3fa5RYs0Oqk1dFlJEUlN8tffFxWgEX2DmLtKQpLvhJB8r93lTifbXtNQAdwyyl3z3wIdfPplLIJ4u8YgbfpqlFTjTNNCtVypZkR0zHDaLX7Vm/gkqfYLIG3amKr4GvQKZo8jjbZNI2UVzr15zJRe1nuFaGZb2OIcG1GBuztoH2uTii1YCNN6yxJnxXMw4gRJSOl88WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV3PR11MB8578.namprd11.prod.outlook.com (2603:10b6:408:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 15:17:27 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 15:17:27 +0000
Message-ID: <bbdb5c3c-1a2a-4fa3-8e08-2e1a3fc51b85@intel.com>
Date: Fri, 5 Apr 2024 17:15:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/7] netdev_features: remove unused
 __UNUSED_NETIF_F_1
To: Andrew Lunn <andrew@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
 <20240405133731.1010128-2-aleksander.lobakin@intel.com>
 <f6d9db1c-bde2-4704-a3cf-69e84a5a6fd3@lunn.ch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <f6d9db1c-bde2-4704-a3cf-69e84a5a6fd3@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::25) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV3PR11MB8578:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ey7/45jKeP1CFo/LohFDvXt4RsnBdNujnQQRYsvLEBlRUw7uR17UEeBLQJ0QVlniEAqV8tVwS69ztZF1KU4w8Pea0rhmQIy5Hb9cUyvlg/kf/pMaGky1WukPy+/eVSIHvGF4bSw2fiUmmKi4Uz4GtzWjx8mV72SVswFlWqIwSp8oQDZHt1kqaoTBfKDOsJ/UaLPZ0uQP6/9E+txgFeCyPQX8kES4RmTt8rHyY4CW1xLc4ZsRPfU9tloR94PDA/iWpZhnkdoYyv+9xc0+6jr07VuE9dkHiHHLC1u8pu9jLug0Yve/bTZmOJJVGIIV86YZyN75wg80MikD7YM2sfix2huqD1YV1zvk5lvL3R1YHnlRtF7gx8QvXH/QQHoT4fN0I0Fjxqee4ryeu4Z6g8fa4/1orItiqjJPDqtoGAgkOtM5dNyCAXPQaHvRJMjFpsTABEwBhRHXnrXwgGR3CjkBaEqrIFUIIFWRAbLNJmhKwG+g69LVQH4UiOE9OvxFw9CVQBlouKVDbxS+6kc5Ykhh9KLP+QtkukMK7sd1ZMERjiLM97vDAgh9NfX6ZroSsbKwa5l8VzCJAiSBdMwR0MIoZ+sqewmgFpb49LcboYmTdzjaWK//JoDVgFoVnE+V4DXfqYjVvEq0YDCV5S0ojT5+7QuaJZDdqq+FKlfhPdghSQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T05rVktoOGhiU3BXL04vcUM1OUFTdWIyaGdmeGpDMVpJYVZ4SENtWkxZMXdk?=
 =?utf-8?B?MzJQalp1SGFOL0tUZk5ISmwvNURWTnhzNTNjS0oyOUdJbGZOVnM0RU9HNWRK?=
 =?utf-8?B?U2p3YWp5QTRLVjc2a3I4ZmVBTXQweXZ1S1ZVRkd1QnlDdnhOV2QzV3hERFZO?=
 =?utf-8?B?S1lud1lTL1VVcWpYYmtaa0lyNm5aS3k4Rk4wRUsvcy9nVXJBQ1MxOUduLzlT?=
 =?utf-8?B?b0ZuaGJRM05DUzhESEVpNmpseVZ3UjNyMzdBdEwzb1JGZEJYK2hRaDZpQXcw?=
 =?utf-8?B?WVlCWG9UdWRyb0Yva2svNXF2Mllsd3loSmNrVUp5RGhrcTlTKzQxdVVIajlX?=
 =?utf-8?B?Y3daSGdEZHhabmNISzJ4UHhuUUovNHA4OW56NWNKYWJNNEFpRzZjS1k5NFNq?=
 =?utf-8?B?MXdaTnEvVWZGS3BYZkhMRDgzbTNnQUw1YzlRcHA5V2tZdHdVdEdOOVRhNEZ2?=
 =?utf-8?B?UTduSmV0N1NqNDNmUXk0SmpQWU94RnBSa2dXU29abkhZYTJYMkNRYnNtM2pp?=
 =?utf-8?B?Z1FDZ1hZUjRtWTIwRXRyRjlxTnE1em5vZW5RNnJmUStPMHprb3A5ZlVHR2Ur?=
 =?utf-8?B?OGtzSHJmcUw4c1VjYlcwUThhRkxhK284THA3U3UwL1VZWXVCQzhPM1V2bzIw?=
 =?utf-8?B?TnBvZnlKL0tDZzVKdmVQY0hGN2RDd3BxZGtlWmN2ZDZJOWRraS8yWThMMDJG?=
 =?utf-8?B?Nm9VYll3aW1samk1UncxQmhtN1cwa0U2dlZNZzhWV3lZRkp6UUxhUzAxOEJL?=
 =?utf-8?B?emhsZWdsY1l6T2xUNjlJUDJNcTFtaDJmUlhkWXZUZG9yVkhqbytLYmVsdUdH?=
 =?utf-8?B?ZmMwNWQ5SXcrek5ZN09jVmg5eFlMbndnWWtnNnB5SWJuQktXS2IvUVJjUWIw?=
 =?utf-8?B?R3EyZFpYaFF4TzRXOVJnOGt4ODNNYnBYSkVQL0hvK1JTNXQ4SFdvOGFkZmps?=
 =?utf-8?B?RFpBV2dmSVlVR2FsSG9lVDBFR3JwTDhVVGhLS1NqcDl3OWQrNGFCMmV2Vjgw?=
 =?utf-8?B?eVFSMDE5bW1KSFVkSWRIUUdHV2Y3Zmd2TnNXbDMrQmJvWHcrWHp5NFdTM0lP?=
 =?utf-8?B?SkNNaHgyZm45K2N5R2hrakhEZFRsUUhBOTJIMEhHd2NOTjJlUnFUSVlrS0NO?=
 =?utf-8?B?dytXeitOZVUyYWZ2QzJBanNDQ2NLMDRTWVBRcDBWclhJeFJHY0trcEpHcHFn?=
 =?utf-8?B?L3dDLy8xMTVCRGM5ZDRnMlNFc0N2d01NREkxYVJSdE4zRnVaaGo3OGxRWkUz?=
 =?utf-8?B?c0Q3d3JmWElML1hPVjBKUkJNdnB2U2VMSTI0NitDS1k5WThHb204SFlybGFS?=
 =?utf-8?B?bW1jZEZhYXdiUjB0U1ZmN091K2M2c2ZWcU9RWWRDNjFyWm5SZjk5WlowZ1Zo?=
 =?utf-8?B?ZVl1SC82ak9oN1gvelBVVlJwV3hhYmlrcC9WaVkxWituNThuOHAzeWoyeG1G?=
 =?utf-8?B?aDZHSlhkbmJmb2VDMWVrVy9DeHR0R1JXR0c2TGZtVElmTXJpZVRiNGtjMXp2?=
 =?utf-8?B?SEl2bjB2K2ZndUJUd2FTbkhPakVsVmEzZ0dGMWh6ZXAyOGF3TCtiVkRzQkJY?=
 =?utf-8?B?ak4rZ25aVEpEalplR3FMaXZYWkphWGJIQmdqR01SdkpmQTJ3NjR6dTV1NFFt?=
 =?utf-8?B?K0FLY1FsWkpYbS9Nb0hyNUhnOVdRT0RPMUhaRWpZWVl0R1EwY21aOGY4ZHRq?=
 =?utf-8?B?eXA0VzJsMURwUjdnWldtVVppa2JpcGpKb0hjaUtTTVA4ODR3dmVSckdrYTQ2?=
 =?utf-8?B?czk4QUdXalhia2xMSkVhdG5xMjJWZTNlM0kzOTNkaGpJMEhDckV5MThhbUJJ?=
 =?utf-8?B?V3VOTHZWUTFla0RHQkVkN3MrNkZsa09Ba1UvNE5wWkJPQld5dElGdk9SVzhk?=
 =?utf-8?B?eUpQK1ViazdqM09WbkYwOUlQZ0JTM3pDSmIyVWpDODdDYkZFNFYwblpNUlh0?=
 =?utf-8?B?Z3lBK3h4UkVDWWdmUmwxMUEwZWpTR1RrRnEwUW5YYzkyVVV2bDN4cGozOEcz?=
 =?utf-8?B?WDJLT0xJcDRNRHJueHlNa1BYbGFjenFCTksyWDNBYmlvVzRlVWNqeTZpeWhF?=
 =?utf-8?B?a256d2cvQmlVY2Qxd0R5aHlUbDRFV3ZJZCtHZ1lmZndKcXM0NGlQNEk1aU5r?=
 =?utf-8?B?eUt3YWZxVUw5dXNGOCtWSTZKL0lMM0JJQzI3elZlM2JPcjAzUjJWeEtYclBF?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05746eb9-88e7-44d5-66d6-08dc558380c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 15:17:27.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq9Bnvo8XDCZ6Dr52xfUX1onUWCTJKk9CNFDPte6Rxc+0Z9ZoJOJfHRRSN54Qyz7evzLK3FSdaOAFoL4M+ck2j+D4BGmsPe9h/Ba5qpOnho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8578
X-OriginatorOrg: intel.com

From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 5 Apr 2024 16:12:50 +0200

> On Fri, Apr 05, 2024 at 03:37:25PM +0200, Alexander Lobakin wrote:
>> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
>> ("net: remove NETIF_F_NO_CSUM feature bit") and became
>> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
>> Remove this bit waste.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  include/linux/netdev_features.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
>> index 7c2d77d75a88..44c428d62db4 100644
>> --- a/include/linux/netdev_features.h
>> +++ b/include/linux/netdev_features.h
>> @@ -14,7 +14,6 @@ typedef u64 netdev_features_t;
>>  enum {
>>  	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
>>  	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
>> -	__UNUSED_NETIF_F_1,
>>  	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
>>  	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
>>  	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
> 
> Are you sure this enum is not ABI?

Why should this be ABI? It's not a part of UAPI and Ethtool receives
these bits together with string names.

> 
> It would be good to add an explanation why it is not ABI to the cover
> letter.
> 
> 	Andrew

Thanks,
Olek

