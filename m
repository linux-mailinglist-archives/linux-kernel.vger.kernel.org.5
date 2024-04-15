Return-Path: <linux-kernel+bounces-145746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ABB8A5A54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D4E1C22025
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7DA155A26;
	Mon, 15 Apr 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgoTWH9D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550D84D24;
	Mon, 15 Apr 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207918; cv=fail; b=KyOANRHkD+WHai+LAQ56KqfrK7p3MN4d3loVGO+24A7V0Qd0R45tpSWbpu/eJVEuyucN7YAiHnOaDfQynX54NGAAoObqXBjl1/BRY3A5mlggbE+m3MD09pa/8lmtAqLHk5NfVZ84WKF52Mz4JE/tpzU6if6DBmAlT/1foAATloE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207918; c=relaxed/simple;
	bh=utTtKgwOWETogSsJRDn9Jib30vg+ATS3Yzm9N6ZshhI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C60LaGljJPothOk9PRUq6eLlLscvLOj3es7xslH2PMeIgb0ciKtKPPdqWyIrGIRQZojovdqOpdigKxJI29cGjJC/s3SzVbIyG6/fqwUfssozLW/pJmJSlzeyvF5ei7OG20QJ0mx1sgE60JWeDF8AHxCEpfAiUlItTtIb781vidM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgoTWH9D; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713207917; x=1744743917;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=utTtKgwOWETogSsJRDn9Jib30vg+ATS3Yzm9N6ZshhI=;
  b=UgoTWH9DAqXDmSJ7ri/DV+DNIkYl3sES/22O59nY7kaFKu6T/29fnuuf
   E1pZRYvN1wfNWjirqIVdsuQYpjAyslXebg+EwbKkOhKeC4w/xB+78HBSP
   qwAVbnaQk9nUSrPj/edJ/OYz3cnpPmjTy+zSTvdG6PxX5F1v1Q3BXZDk8
   PbjhemNhtq3BI67BKj9O2rcL5Oj04xQj7lF6aOVo0K8tB8Vz4HJduq1Q4
   yIr2Jcul8lGtOVY4ZlmXK0zSTOP3TWNu3YWLSIHjXS2h+c8sjTBxRoLPX
   7tZBHlLx99RgDwEXz+mfEX2+bzPtV9rFqDM8Ckj8rl2j8QaeYEhQrbRth
   w==;
X-CSE-ConnectionGUID: I6KWeSQXR5WvyZfmNpvkzA==
X-CSE-MsgGUID: h/b6B8yWRvel4nZXWXpiew==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19766020"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="19766020"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 12:05:16 -0700
X-CSE-ConnectionGUID: aj9zeFwBQxmdKkzoW5KRfw==
X-CSE-MsgGUID: 2NQWjY++SpecKEBXg/e2nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="53204847"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 12:05:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 12:05:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 12:05:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 12:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjA5mpJkbGfm+oAVknC1d18Zu7DTBxY7b365EdKx3x9NCJnTxYE7d8jwU19gkRfw/U6f/Ul12NW2uKB5/gIcn9kaD9C5lEaGR+BB91YgU0d7q2PXLt327Vwo8cfQi0hU8uagj9HRmN0GG7qYET7sxao7S253ElU/XP6v5bnRLBNGTyftu8cE8SaN4wpGJLmBmm3RlvM7Vm7ggid5/M22kS8XolSZ+l66hZyc0Yp868TepeBVY62LIjS0Y0HxEd1nvxEQcQ/d7aRA0AH42JOk6gMA4ftXT1Za8igaYtfd3LWn2MkUudTo6YQ/cfn/WqSXEgXu7Cl9mdtFizGDI81MwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eT7lzIseO+s5VnZNy6s4ntLt/RvokmkVmW3eZhHHak=;
 b=gNsa0kBYcjytdOoo1uCgvghGXp1Xp1prjUXjjpkf7qsIMkXEz74Uy6B/S/0t0S5NqCDkGmiS5iyv/A+e5d7q1oWplXzrJtkqM0ac2bdBpM37nZ7M8yrQazjBbz6dH2+kF+R+hmzGZS3swH9i6TdJIKcQh3fZBYxf7jjey1K7iVFfhRnVdJfoQ8VwlLmHmZ/8N8quby8VhO4IqxpaRmsiTjx1YPJTFulO8Gmjm43strKe4s5Ln7QzFMuEhm159h5Ev2iKeCgj51AHZKXYjZHKt4v9caj64r76SuPMiEnOZDdlAVcauxqrd0fPFs7sdkLQtOVk0SlrTGWjydM+yyNuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:05:10 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%5]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 19:05:08 +0000
Message-ID: <d9856482-0693-a97a-4429-b574ffad1349@intel.com>
Date: Mon, 15 Apr 2024 12:05:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 26/30] dmaengine: idxd: Assign parent for event_source
 device
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mark Rutland
	<mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Will Deacon
	<will@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <gregkh@linuxfoundation.org>
CC: <linuxarm@huawei.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, "Yicong
 Yang" <yangyicong@hisilicon.com>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>, Atish Patra
	<atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, Andy Gross
	<agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Frank Li
	<Frank.li@nxp.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Vineet Gupta
	<vgupta@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	<linux-fpga@vger.kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Liang Kan <kan.liang@linux.intel.com>
References: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
 <20240412161057.14099-27-Jonathan.Cameron@huawei.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20240412161057.14099-27-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::39) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f9df7d-b20f-47f4-cd95-08dc5d7ef78b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jj60lXo2bgHrQvALmbLw040YqLI1lCZUGkJYJbzGmT0pvj7oXumTB1LqW3U0IFuT7b4JHO8B8kol8RCtDB2R5BlokkdAYR5ELIKGLUjzzdIUPF9joT1tQ1YBD1NlYula/e+sm96lHMS2Ok3WjHzt7a69pMqlOd43WwA6MEZN09dJsbzYDI5Z9xh5c5AyIoxY1IcaIMKSYgGs4K2SJHXv3NHmqn9xM8XMS0HtXGqJp1dVC9BxyshXIdW2aSY7GH1j0yvpUt1HZy32wWN9B/OvtELeaRvY5LMBlyiBqqBkAvdaDDphbYcf2LwJktgBqBiWCead79Z5vjLiit6U4f8mfFalIQzZ7aMr01AeC0O8KsuU/cLmOBNLzSwThAxkhmZaZseg0MhLFBuztmwj1ZAapNrKJQ5W2E3rRyZ0Q47Q9bdGWb35R4hkZsa0B9ehGQCq+ANiaG3JoQDEx8LhuwOMyXeSJCnH2DalpGUr+5KSLtF8bljWw4eW8HEzaCWWwoin81+8Yuc7lHb2hCpBUHaEWkdVgFZFlIeVDLNT1UspZ2bgwtKhMVvSTdbq7xZxGR1FRZedxjbnt27DWMwwDwIoLzkKzjZNT7DNdWz6yaSMBy4zbr8h5Ryk/4ThqMmVn82RDsIG+bUQLyWyCHkMvGB6fNDg+EH/1082Kuj5H0te6Ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TisrLzBLM2UyTWpIbTE4b0pCMUc1eCtxdlRxK01LNnBDZ2RIbGJUdjFFQjZS?=
 =?utf-8?B?Qll5VnNaQW1GZmVHMVlBTXFVMFJhaXNhbnU2K3VyemRLVzNXaFNabVB3aWRx?=
 =?utf-8?B?RExFVW4rWG9aY0FjZFFJVDd3WWxDTUFwUkdlSUFYTWZOSloxRG0wNm5abXl4?=
 =?utf-8?B?TWtIZThtcDhxcVo1RGxqWTc3dzZMQi9NRzBiYWN3akdOYUY4YjhiS1Fmbm5x?=
 =?utf-8?B?eTVIU3R0MUxnWDlKNHVHQWJ4QzJ1dm16b0NwQVJrRVkrdkZsOTRRVkVPQnVS?=
 =?utf-8?B?alNjVnM0NUVCWHo3M2l4RmR3dWEvYzk3S0hUUDRyT1pTdm1zWjlHd3FQYkF0?=
 =?utf-8?B?UGlpZU1WTlVTTEdPaHNFTVIrQVRNMnFwREtXeGpUeUtNRnh5SXRuOUdjK1lV?=
 =?utf-8?B?K0VwT0xSZG5FT2JYS1NjVG8rQWhwYnlBbjlqaUZxamxMRlIzL2ZrNmwxVE9B?=
 =?utf-8?B?V1dtcHJYTGJYcTJ5QStKZC94V2Y0QUhaUnZsdlJ4dk5aMzNCVnVVMk0rN0pi?=
 =?utf-8?B?MytiY3JZQW5RTld6NUdWWGtkUXFKcUwxK1pZNWJoTjJpbldCQ3NodFBldnh0?=
 =?utf-8?B?QUsyczZRbStGWll5S0lMTmNTL2NYcmU3cnZwSUZZemwrdHRXVjlWaHVsaS9P?=
 =?utf-8?B?aW0xb2xXWWx2N3RCbTE1YnJnb1JlVWlLMVpZRFI0dS9LaVgxMmN2UE05dFJZ?=
 =?utf-8?B?M2x6NVpxZzZRVjNrajJpRFFWWHBVeHRsTTBSbW5JSVZuSzNDQ2k0SlViSTZI?=
 =?utf-8?B?Rk1EQmVXdUZYbVNlejJndm9ZQlMzeW1oTUdqL3dQVWNESjlTTXU3aVZNN2lJ?=
 =?utf-8?B?SHJxTjJVZnUyNTZDaEd5ZVVNQlBPSFVBTDNiWXVYWjdnOFlURkVScWd6ZFRY?=
 =?utf-8?B?V0IyN2tmZXkydE1MK3pHTTdBYlFUNGg5bjU2RTcyMHB4VHFyeGxXaGtIcVN4?=
 =?utf-8?B?a1p4Z3JpYmh2Zlg0OGRhR1dGSmpUKzhkUzRyNkszZ2FtaDNNM0lvY1hnejdp?=
 =?utf-8?B?ZFRMVzgxc2xrZWt5Y05oQ2pISWhtMG5jTU5vRG9FTGxuSm51blZNY2NvMXpK?=
 =?utf-8?B?cDQ2bk91a1RtckdQTlZzcVU5T0pTdkhxeUhKanJGOHJQNFJ4bDlPaUhLOUxI?=
 =?utf-8?B?VnRwbHV3RDJYMmVQY05lOHdleWhZUGc0aEcyM3dHanI5NUVocmczTU1qcDk1?=
 =?utf-8?B?Ynl6UE1jS1dpeUZONXJYVTliVUR2c2ZmVEo2dXpNbVJneXFpSEdMbUdHa0Fi?=
 =?utf-8?B?eHNOZHYxZERDVkdKOW1PZkJtbmtZYlR3QmZza1ZIUzJ4aVZDSlYxdml4NUVr?=
 =?utf-8?B?UkdhdloxcVpPeGRZMlZUWTh3Y1ZHMHVwNldQRk9UdlpVdFgyaitGWWwyYzVE?=
 =?utf-8?B?US9qbkdySExUc3dEYlRXZ1lJTlBHNUdJS3NQZmluZVovQS9Eak52RnpQWWUr?=
 =?utf-8?B?TmxoNUFQZm1oUjJ5Wnp2cC9abldxU1hPbVlUUGtQVVcrQzZtVVc5UWtVZ3RR?=
 =?utf-8?B?Qlg2UjFTU2Qzbko5QWpEWXhwM1pYQzlmRnB4eGo3QlpKM3p2WDhEViswV1p3?=
 =?utf-8?B?MkNpUlpZMlhlQWJkaGNrSGlZeER4TkFQNGVIazNCRk1abkFubXZKNGtVcEdG?=
 =?utf-8?B?QmxtdUpuZVRBZU9VR01Cc0FHSFNwYVNJZk9kVkdxVHVWTHNza0lrNklOczBS?=
 =?utf-8?B?MUNQdUdEWmpWUnVYRC9HWHdCSCtRRldtOWtJY1dPc1NCQTlYcUVyS2haemQ4?=
 =?utf-8?B?a2ppcUY0YWVVNzlXOGtFQWJTa3UweGVwcmFCTFRQQTBIOU1MeG1NTkdXSVcy?=
 =?utf-8?B?QTZsSzVzdi9GR0I2c1YvNkF1QU1TdC9vWFpkU0t0Z1hYWC9pQmw2ZGIxVTYz?=
 =?utf-8?B?RkdjaWlPZ3hyN1V6Z2lOMlRqL2Q2R3BzdXJzQTVoWUJsZG0yNnZJMkJua3py?=
 =?utf-8?B?aEtuMEFEUkNUUkdWaHlDejQxblo1TUc4THo1a3FucnRVSnZiZWlscmR0d2w2?=
 =?utf-8?B?TWV2NjBNd0dwVHVXY01nMlRPczJ6MzFMeWNDd2VOelBPRFBZVlRqUWN0VjRJ?=
 =?utf-8?B?N3FKd1pWNCtTV2RJSzdVNjNoc0RwYmZ4Sjc3bjBhMmZvYkhjdHRsNlplUjY3?=
 =?utf-8?Q?r0yrS1kaWJJZdEYek6A6xPJU7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f9df7d-b20f-47f4-cd95-08dc5d7ef78b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:05:08.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEWjjfzt299bQCjiphAVaNKYdH+QEMea9YvXCXaDepCdRew8/3zqAGT1bfp9YIKFC8RzgW5v/umAk0sizrWMow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com

Hi, Jonathan,


On 4/12/24 09:10, Jonathan Cameron wrote:
> Currently the PMU device appears directly under /sys/devices/
> Only root busses should appear there, so instead assign the pmu->dev
           s/busses/buses/

> parent to be the iDXD PCI Device.
                   s/iDXD/IDXD/
> 
> Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Other than the typos,

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

> ---
>   drivers/dma/idxd/perfmon.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
> index fdda6d604262..fbb586eed0b3 100644
> --- a/drivers/dma/idxd/perfmon.c
> +++ b/drivers/dma/idxd/perfmon.c
> @@ -477,6 +477,7 @@ static void idxd_pmu_init(struct idxd_pmu *idxd_pmu)
>   	}
>   
>   	idxd_pmu->pmu.name		= idxd_pmu->name;
> +	idxd_pmu->pmu.parent		= &idxd_pmu->idxd->pdev->dev;
>   	idxd_pmu->pmu.attr_groups	= perfmon_attr_groups;
>   	idxd_pmu->pmu.task_ctx_nr	= perf_invalid_context;
>   	idxd_pmu->pmu.event_init	= perfmon_pmu_event_init;

Thanks.

-Fenghua

