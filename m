Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD57A06FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbjINOMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbjINOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:12:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F94DD;
        Thu, 14 Sep 2023 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694700765; x=1726236765;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m4qLwI8WZITsGHhsYeKwStVPHy3A2zHn2o5F8ef58Bg=;
  b=d1rchVeLteHyBUQ7dHnbin+Z1UtfJazQXFWrJGxxjV7TNdeDMvUoXG3G
   5oz92Q9rNTXtBdwZfqi1cv/vvv0SDrjIJXmmfI3G3E/YTezaXFYYZSOJT
   LmEb0RjcMNwNaAPrxVAT5ShlGzJZpBgR6aHu1USNZtdJ/7+dP9ZkCmnQb
   Wmk1S/xGAzc7+wxytargxaDcCVE9bviF2cODs5SChrO6CG0ne/GdN+mAU
   wBgrAV0RmEW4iZqFF7EqOowuKsTKNn/NKvA5i2owIEaSqiu0wWgfz8V8G
   1UQgb8051QZBiOLEXxEKeZw8iJU1jpVkUy98ZC8+8QKl1lwtKTdDGvDEw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359219649"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="359219649"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 07:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="747773388"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="747773388"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 07:11:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 07:11:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 07:11:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 07:11:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 07:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKWVORyV7Jd+vIBO/HLks3/420l17sMPyAEROPRiWlTz/zuOir2V8mjTXd7ZIkfGSgj6FB0NTzbHmv0nzpXTstlVHUHB1Qk8s8gau1k5bkaOWJx27QrOBrhnh+Zf6FVDpO0z6xb9Y7c4rR64gEG5ktn7vPHEaXuQukGqnazjdbiourdhczMcsW4/AurVA3rShIf88C/uwKcpuo/EbX3x0HHCXUqu6+dmuZt2SWTHsWvFwlOMudBMb6JwIsV7PKt8I4tZJeOC+P+8d8GB7UE8srXQgTk5Zg3tmQbwxRfKCJeiL8Yphj3tUgTsNQuJSGSLd3HLCphy02F1/aB8MHOajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP8s7CV0Hl4Bg/CXbFwN/WXnTaIPqAeMfSlhN8ahMTA=;
 b=izqrToPfhaSKmVXdC8IrYVDP6uzJFgb16agsi1KcIDr8eqkTcafZw1bVe9+YTLEGrZStNvYEWO75lbdWZYbF/S+yE0I9tVTMqqfGIDgNDvcMxrqLzmYxlgUHtKtzxfrIQiYTxPay/1JuhLYlavOsE0vOJLR+fzZl9CnUI4EWVK6rP8l/uYfluX7zAdNbEYiUHxErVUoCku/Nxk+Ky4hk3LcDv5y7te7TRmQ56LZKUMDjEsx/P5spvtgRIar/Lmt16uUyvY+CImzW9tU1+a8+vWcOgZL/E3KTsRJ1YQFpnccPoOXRgWFC30Ir2KcGSaVDZuPG0spzHiDK5abFE+mIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA1PR11MB6735.namprd11.prod.outlook.com (2603:10b6:806:25e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:11:39 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:11:39 +0000
Message-ID: <48fe0346-40f9-b0f5-991c-8c17349849f7@intel.com>
Date:   Thu, 14 Sep 2023 16:10:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <9a1de9b3-b3cf-d26b-388e-c98294580bca@intel.com>
 <599cdff8-4865-3ade-0439-36e337891ca0@linux.dev>
 <e6de7c0b-97cc-090e-a331-dc566019f54e@intel.com>
 <dfe6cf9b-7cf9-f938-8ab1-a2d4c7741c64@linux.dev>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <dfe6cf9b-7cf9-f938-8ab1-a2d4c7741c64@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA1PR11MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 58408683-9a5c-414b-fdae-08dbb52c8348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rf4vmUqg0ZSSDMbOQeUqbWSG8j4axcBMLhays6wzAhCuuroQ29s8bt2D6WbeRmw2Aao4N5HEc3fKSmAvyEUThvjrrriz3PDcRMHkztRk+DplTi1G+8ysZQuY1gCKaJz1Z2ImAvIV2W9zrGU++7XNXHLetcSi9AUwnXHbcTo32FWaLt3IthAo0YOyLvgDPqR8/cTOxBLQMSKBIoubgnN51lhDuQa/L0JF+5InPIiU42acIoPR5yrfh7S2hFH0c/mat5y2iC0/8CoL1+4egTrXYkiWOehsAz/1eXZt/ZRZmd/B3fpnZFkuGucZ8r2vME2n+3Pq/rhY4P4MAEgn88QqWc7lKZcTOTng9bx5dPg56WGt0R0XXneWzuOXaTHwPTylWOv697uRVBouITRiM5J5HsawznDr0IWkcE9SHe/438q/ozVd6LCi621iwNDaLlxB0LQcjzeN2C0jRYjzwwiha6wbR9Taz0al6wl9Ei9PRDhcNUdot86jeshYXWgJyMhuyeIk29LIq8e7unBa2mpNuuVLs/DiB3ckstnW2+dtKyi/WXHJ3I7Yae5qjU1A/R9ovHCzryMmJ7FtN+U12SgtrfGhubWHO7rEluprE2R+1lawgsybBbWP8aNjkIfchaYxgUaERYTSgCBxdo7u5jhRZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(186009)(451199024)(1800799009)(36756003)(38100700002)(31696002)(86362001)(31686004)(66899024)(6666004)(478600001)(26005)(5660300002)(6486002)(53546011)(6506007)(66476007)(6916009)(66556008)(66946007)(316002)(8936002)(6512007)(41300700001)(2616005)(8676002)(4326008)(2906002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUVLZXh2QzJab1ZHTmp5S2dQVU5FYmQza2hDUy90R0JqekkzS3IvK2hsSjJI?=
 =?utf-8?B?T0szUUxiOGFNZG1kbjVoNzBOR2VmRFl5WVNySE1YenJCY2dQODhmUjBYc2Fn?=
 =?utf-8?B?ZmVHcUpUSDUxMjc0T3JUeDk1QS9OOEtObi9XMHd1UVkvQzZkSmRhaVJRb3da?=
 =?utf-8?B?S1VvK3VxZHNWT3hZdWJMbnZab2ZITjRjOGxHZVV3ZUlLOGJWRXJUbyswK3Ry?=
 =?utf-8?B?TzRqcjZ3SzY5emFoRWVwYjFJQ096cEJWMXUyc1Q5RHhyd0I1YVJJNHJTWTI3?=
 =?utf-8?B?ZGRtZ3VtNW9wUWdyalpEQ2lneGVnUUVYWHY2ZGIrazRjQkx0RjlyWU9BTjZw?=
 =?utf-8?B?KzVjcmxCdXNpekRHMFZPb2tuODZpbVNXdFNwbFNBTHpaM2RXeVBDckxyMm9u?=
 =?utf-8?B?MXhHUlhKVTBIbmsrcXJLSUtySjJLczFGMjdiYm1IS09uN1J4OTJMOU9xMmJJ?=
 =?utf-8?B?YW9VNmU5OUkwaGtPZzZObXYwYUhVSEQxRHBkR1AxS1podHhTVUxON3kvV2xP?=
 =?utf-8?B?MDBmakNTRTNNQ1RleEQ5WWNtdWpaS0VObnI1TDBmbTlsay8rNS9RWkEzcFBo?=
 =?utf-8?B?eWlrZHk1VUg1akllUnJlWnI4R25jNVdQOFh2ZmtCR3NIYUFhWXdCeVg2QlE3?=
 =?utf-8?B?VC83NHl4MDVmR3ViMU9zQTBJRElhQUQydjh4T0V4dVc5NVpWUlZhVTlGcGNt?=
 =?utf-8?B?dWpDUkNPTzludVNRaWsrbjhkQ3pyYUJGanhNdzI3MVNaN0ZwWjFiVG9ydjRv?=
 =?utf-8?B?QUJRckNteEhSRU5UZ29HUjFHbDNBRE9yMERlY242TURCZlpIZENSSFIxYVVQ?=
 =?utf-8?B?bURwOUtCQ0FqbEl3d3c4a1hoRHBWOEdhWm5VUUJmSEFTb3g1SnB2bzVDTStv?=
 =?utf-8?B?anZGZE1Fa1NBM3VvRlFySW1TVmNtdWx2eS9xK1FnRXp4N0NRYUhJSzZGS29o?=
 =?utf-8?B?VkdjL3M1L1ZIMmpwSmVROTg2YU5QRW5PcXhxU3huSjBNdm1CWDRyREM4Z0s5?=
 =?utf-8?B?WkFCeVdkRzE5RDNUSnlHWVVyenRLWVFQT0RSL2txeFFVYkNmVTdrWXphRXFj?=
 =?utf-8?B?QTF6OWlpZlZXZ3ZlK0dORzlxQUtiUjUxbllhSmgwem9tV3JSUHNKZXl0bWVX?=
 =?utf-8?B?ZFBzZG5kU3FtbjgzamIxTzlyMm1WeXUxeEJnSy9wSTgyTEhsSHJBQWtnM29B?=
 =?utf-8?B?K3c2UU1GZ3ZlbERKWnplc2I2VG00ZndSSEJ5N0xRUjR2Q3paWVc2R0IvOVZV?=
 =?utf-8?B?UTk0OEFTNkx6S2FBUmhGWTAwdDF4RGR5V3BoNHI2VDBmLzJ4VGlLT2dpZlpC?=
 =?utf-8?B?T3NwUGpsQzRTb0F6Y3hQbVAxbkVzeDE5YkhNM3JranRBaHJlLzFSRGZBSGJB?=
 =?utf-8?B?K0tod3ZRdzhUYXphRGJaODB0dTNyQzBZaUZkeTVGbS9nWW9ucVFrVC9uNU9w?=
 =?utf-8?B?SlF2RkxrQ0NzSG8xa1E4eWtwN05NWW9SNHJobmNnczVhSnI4WStNd2YvU2ZY?=
 =?utf-8?B?b1hlYW1EMkFuRnVISzBiNDBDU0ZjVlQ4YmFGbmYrVi9YWEYxYWdWQ2NmcXlx?=
 =?utf-8?B?Ukp3ODRISHRkQ1pqZVA5NEZTVWZlUEtkSTZsVFdsOVpzNDhUaEluMVNDTnNj?=
 =?utf-8?B?Z0dlbHAyNkFneGV5K1pGMFBQUGk0Vk5KZElVVEphV0JjQjhmZGUzc3BNK0FE?=
 =?utf-8?B?MFErbWJmbGlUc3pQT01ySmdPRHNrUHFIZnZwM1l1dHJsWjNLa0JHVHFrMXQz?=
 =?utf-8?B?Q2dlZFh1QjAzZFlIckZDZG9GTUdiakNIL1YwVFF4TkF5b203SlllbUZHcHFI?=
 =?utf-8?B?cUFOb0dNblBUdExuSGlVWXNDemFhbUo0SGU1VkRqRkJSd01QNWJEekF4NXpE?=
 =?utf-8?B?Uk5UYS8yWmZhTm5jS0hQMUtvN0lqWnF5eFhibzhRVlFEWGJjcFNWT1J0YW1o?=
 =?utf-8?B?RGJFUHMrM2RnVEY2dnJlOXF6cm82amVJbUI0SkIzTmc3bEROSTN4KzF4NXlS?=
 =?utf-8?B?SFhGOUZjb3FnLzgwc21mZGV2VTNnQ1krcnpmUmQ3Q3BHOWQ3SnpHdW1hdlpX?=
 =?utf-8?B?QzUySG8zSElPanlsSGlDZ2VXcWtyZzVmUnVkZWZHZEhDRyt0YlhGRndZWjFp?=
 =?utf-8?B?VitwYjA1RGxrazhoSU1DNmlYSkVQSmFSYWJDdVZ4eFBLNmYrd0dlMTRvV2Jz?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58408683-9a5c-414b-fdae-08dbb52c8348
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:11:39.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWTzi+Iv5EO9LzRfQPqazMn2o7iPhGHqhx1rU9PPYAiAOate1czzG3KQXZX9fkerAfqwDK2AkRk2e5mbANenijuymAhoyUA5GvZIv5P5Ss8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6735
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yajun Deng <yajun.deng@linux.dev>
Date: Thu, 14 Sep 2023 10:44:14 +0800

> 
> On 2023/9/13 17:58, Alexander Lobakin wrote:
>> From: Yajun Deng <yajun.deng@linux.dev>
>> Date: Wed, 13 Sep 2023 10:08:08 +0800
>>
>>> On 2023/9/13 00:22, Alexander Lobakin wrote:
>>>> From: Yajun Deng <yajun.deng@linux.dev>
>>>> Date: Mon, 11 Sep 2023 16:20:16 +0800
>> [...]
>>
>>>> EXPORT_SYMBOL_GPL(dev_core_stats_inc); // Why not GPL BTW?
>>> This may be a better option.
>>>
>>> Just because EXPORT_SYMBOL(netdev_core_stats_alloc) before,  but I think
>>>
>>> EXPORT_SYMBOL_GPL is better.
>> Ah I see. BTW, if you will still define increment functions as
>> externals, there will be no reason to export netdev_core_stats_alloc()
>> or even make it non-static at all.
>>
>>>  
>>>> And then build inlines:
>>>>
>>>> #define DEV_CORE_STATS_INC(FIELD)                \
>>>> static inline void                        \
>>>> dev_core_stats_##FIELD##_inc(struct net_device *dev)        \
>>>> {                                \
>>>>     dev_core_stats_inc(dev,                    \
>>>>         offsetof(struct net_device_core_stats, FIELD));    \
>>>> }
>>>>
>>>> DEV_CORE_STATS_INC(rx_dropped);
>>>> ...
>>>>
>>>> OR even just make them macros
>>>>
>>>> #define __DEV_CORE_STATS_INC(dev, field)            \
>>>>     dev_core_stats_inc(dev,                    \
>>>>         offsetof(struct net_device_core_stats, field))
>>>>
>>>> #define dev_core_stats_rx_dropped_inc(dev)            \
>>>>     __DEV_CORE_STATS_INC(dev, rx_dropped)
>>>> ...
>>> I would like the former.  Keep it the same as before.
>> By "the former" you mean to build static inlines or externals? Seems
>> like the first one, but I got confused by your "the same as before" :D
>>
>>>
>>>> Just don't copy that awful Thunderbird's line wrap and don't assume
>>>> this
>>>> code builds and works and that is something finished/polished.
>>>>
>>>> You'll be able to trace functions and you'll be able to understand
>>>> which
>>>> counter has been incremented by checking the second argument, i.e. the
>>>> field offset (IIRC tracing shows you arguments).
>>>> And that way you wouldn't geometrically increase the number of symbol
>>>> exports and deal with its consequences.
>>> I agree that.
>> Ok, after this one I guess you meant "I'd like to use your approach with
>> static inlines".
> 
> Finally, I give up this approach.
> 
> The new function dev_core_stats_inc() didn't called by external modules
> directly.

If it's called via an inline or macro or whatever, it still needs to be
exported.
Double-check that modpost doesn't complain on allmodconfig build.

> 
> So EXPORT_SYMBOL_GPL(dev_core_stats_inc) can be removed by anyone.

That doesn't mean it won't be needed tomorrow.
And I don't feel like it's a good excuse to define 1 external function
per counter instead of 1 external + static inlines for the rest. It's
not only about the exports.
Esp. given that I wrote almost the whole code needed for it to work in
one of my previous replies.

If you don't want to do that, I could take it over xD

> 
> 
>>>>>     /**
>>>>>    *    dev_get_stats    - get network device statistics
>>>> Thanks,
>>>> Olek
>> Thanks,
>> Olek

Thanks,
Olek
