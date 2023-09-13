Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3A479E46A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbjIMJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjIMJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:59:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDBF19AF;
        Wed, 13 Sep 2023 02:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694599160; x=1726135160;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HSLJwVgcFCs58MKh1DPh6CnbxJPFFR5byzsU32VD11Q=;
  b=i4A2OhuCyMOzavRIIjcRFWV4bqfshXhyG5vsaUYt8E5om4Brzr7B2Hqi
   4+TTef4peOvkSbtfjJA7b/l5rWDR/R4YaOkjA43QNVQugy0oiQNYjJztq
   3H17yvXmFaJIaAyeG34wky9zZN/xIzJoOTadYXCSqV3DSAMhEnW467vp0
   uGYjE9s570qNhK7pdmc26Z95KytSzOYS3emRyTWy7Xi8WqSJbyWTmaQVB
   FlM2wemEt8INcvD+e3E+4deMjfawHKNsCq2kr+5GHxFZXXtSHdQiW99xF
   lgZH1Qv1XEkkcFuMZL42xLjFcKc5Y2mjV2Muvtfu20jRW7IEQVRffuTeB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464985952"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="464985952"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:59:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747241741"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747241741"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 02:59:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 02:59:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 02:59:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 02:59:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 02:59:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J51MWVdMrgg45lLoebkiLOwhPynKv7QAA5AIX67NAM736j24QbQwaeP9UT5H31YulSHNRWoI2iGoXcM6xhVuwSK23Ztiv2lWtzR0wQcG6Fi8otS2eSI6iRXnBJa+Ij0qZCxuYoSIEgtYs7/r6MPo0Ed+s3+UwZwkf4nSHOqD43LBJZWB5L/LJJICxFJFbKDzE25L2663zk+71/TQpe0u8eR/SSCUyZGSCgqfU8FtDj9zTA/1jkmoxWgqcSLD713yx/AJvm6ZxnHD3YqpIwT+fvBGtcNJWBQZRbWn758ohh8sRWLS41J0ODvgh4n9Ck0dacTLTGhH4CkiK4i8jhSstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4LCOOcylXoKKS0E4mZWNg2Oyxwu9mjLDui4e4wRo5k=;
 b=nBp2TdYOigg7VoxjbDsc80+719xZGf5baB1ePzpftgNrQDXMk7pyNhxT00Wuh91vlLz4z9tQPGWBBvubW5NJA62w4XkN112UfPbDbdMahSdbA5oiNiQNi2+QxJtcgRO39BBH9R++F5Ji2wo0DrM3eUJnHZGoeoIW+ncBkYr83QCR3gR+SA7a0qC5TvlPBX9oTiRoeFJ31jBMEnidEWHQkOZyoiSH+RO1GIveUse8c+891CIwJlodfdc+hmur9CpKNb8rZr+QK7xJKtS9yKpOeHr8Y5Uw2zm9L5weT0buGvrPhCsPRVfrKfcuwnYhY6f4AmEN6nrMgh1hnoKU8PHGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SN7PR11MB7115.namprd11.prod.outlook.com (2603:10b6:806:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 13 Sep
 2023 09:59:11 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 09:59:11 +0000
Message-ID: <e6de7c0b-97cc-090e-a331-dc566019f54e@intel.com>
Date:   Wed, 13 Sep 2023 11:58:30 +0200
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
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <599cdff8-4865-3ade-0439-36e337891ca0@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SN7PR11MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 8994a53f-d321-4088-ca8c-08dbb4401406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U54OdwX6RkC+IbYuhhIlMuURTyjxI5kQ7M0vIW5qVPDHutbScHwPfJ+Y9GLsRPI4ugHYuNb6pHPgfP0Gmp+2WiAzpdKxQahjEjvwAkH9wYcsqC/CIjH1+CzX5lB7TLDzZptChG5YVuEmVmhgR4gKP1qv7N5dQXEd1KL21qNTtcSnTOZEPVRqL1V2Ruh87jx6XF6/SLyavOVGRczBCPHzFBJzuJSeAzSOEtuivekZXAGdviU0MUeK3VMzM8k0Cyg3qg3sGSdyOFEmZ+XAuHIETxZN+Qedn1dzNdLouCZOLJ9Gp9ZBMyhHuW759Ze3hTQVhpBc7pLJyZo9swo1qpxP3I/yx7AjhPy/VvGuJ8ScWpnYzOuIvfIHFD78zCOilSzF+txu4oz/2pDdriLg9JTlEBa9L4YM+m6g752o7wbw/l7A+EOqjj6Om7ovLYQDpkYuGYV0AYHI8jBbWc1uEXxqzrgBbcNqNHZHUMLmD+sGfrdkuEZmo4o0Z15speaXJ3sQWy5gC7Bmmj3WXvD3iGEjNQLzkl/0dbB8epsFUJjYcG6qZLckGQZzSzrsJ/u6Jxz6AFEDE2BEjBMnoCQb5WegjxfxlxVkD9kqw8EIi4bdEnwo12qfE7HO2dk2R0lnxFMuBctaFvCnfU83Ei7kuz3qsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199024)(1800799009)(186009)(6512007)(6486002)(6506007)(53546011)(66899024)(2616005)(26005)(6666004)(8676002)(38100700002)(2906002)(8936002)(5660300002)(4326008)(31696002)(86362001)(66946007)(41300700001)(36756003)(316002)(66476007)(66556008)(6916009)(82960400001)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2I3c2ZaRzJNSWxjTWpwZmdDWXlVekdIcktUTXRRbURvWnYxNlhrSk5GQjVh?=
 =?utf-8?B?bHBrMjRxbGZRcXV5ZjdyU2NmSmZ4N214TEJ3OTZicGRUNkhaVi85eGMxV2l0?=
 =?utf-8?B?ZHZzRW9ST2V2eElrN2xNdWN4eFlvalA5TzRGdWpPREp2cFExTGtQZTEvWFAy?=
 =?utf-8?B?OHpnUHl1WHlTVTVIM3orUjlIR3dnL3ZrcjAxc3hwd3YwRjhUMEpQQitnRTlj?=
 =?utf-8?B?VHhLY2E3MTRPV3lSTmU3TG42dmRFdGpkTjhhQTJFOFhSTGR4Nzd0eng0S290?=
 =?utf-8?B?RHVoTWRaMllwalRqTDROS2pDS3NqYzZ0dDBxejlMcTZrTWs4QWNEQ3NFU0V2?=
 =?utf-8?B?ZW1kYzNLbmRjWkU5YmRBeVhLYkFaZWlSd2V1VnRIUEVIa2MvLzh6TE5yeGtt?=
 =?utf-8?B?dWd2ZmpkaXkvYVdqUDU1TVFzNjdjaU1YeUpObkhSVUFsKzlXOTNuVEo5cm1j?=
 =?utf-8?B?ZzRJeXVhMlZYRllOZW1BV2xldWpsYUhtRWV6enVrTmpRb2RwVm1YT21EVTda?=
 =?utf-8?B?NUI0alFNVFJUTjNsN0VVZm5BamZCcG1BclErQnZUODBLRXIranNsYVpuUDdz?=
 =?utf-8?B?Y3llRGc3b05PQ1NlSytRRkNIRVR0QSt3Q2VEaUJYUklpS1E2eXp1TmhKSitX?=
 =?utf-8?B?OTlxa29ya2Fqcm1HQXA2MUxHaXZxeXVLUlEwZ1E1ZlZVeEl0dzVlQjRwVEll?=
 =?utf-8?B?NjVKMUlkanpHeUt0TmpVbGhPL3dWRFQ3V29KOG8vZTZ4ZTZUUVRrcjNnbWJy?=
 =?utf-8?B?V2lCeTZWNTNoNDg3MzhnVFNSbXhwYkYvNmcwYUR2Z2l0Q1lUTFVqL014MnJ6?=
 =?utf-8?B?anI5OHh2a3FuMDZINktiSyt2djBjbUwweDZabVdscjdRaUlaTm5xOTRpRHRU?=
 =?utf-8?B?aGVRK3pqakE1cVZjaHhYcVhRTzRLRHR1NTluVTg0MWY1NFZZR0lvMmN2b3Y1?=
 =?utf-8?B?ZmhCd0o0L2RpWkZhbjR2YlMxMG9VSTg5R0FVejZ5MS9La0J2OEFPeWcvMXNQ?=
 =?utf-8?B?dE96S3Y2OTRxNUhZYnVEaWJVZDg5MUVZQXpMTGFKcCtZbHFFREFpYWFDalk3?=
 =?utf-8?B?RjBGdCsrR2R5RXk3bisrR3RxZDFKeHoyOHV0NnJXUldIZ0NiSEh0OVJyT2VR?=
 =?utf-8?B?WnJHMkl3OGdaYnJzcEZ4aUM4ZHZCbVQwcDBXNnRGc3h4Q0t5WEVLamRMQjRZ?=
 =?utf-8?B?QUF2TFM2Slhyak1NT2tzZyttV0pncTgrcW4ydXZlb0FVRS9OYStGQS9URVpy?=
 =?utf-8?B?WG5TZ1FvZ1RCc3VPdS8vQUo3b1ZHNEJlekl1RjlSQ0luS0JOWVp2Q0phcFhh?=
 =?utf-8?B?cEhVMUpaQktIZmpSdFNFOER4cjZEMFJ1Mlp5RENYUU9LNUxoNW9vTU04UHdl?=
 =?utf-8?B?NVViRlcwYU51WE40NUdGTHhlN0FpTUY0RlRUbGNtK2l5bXhrMXh5eElLUFJM?=
 =?utf-8?B?MTBHbitYYUo1VUFaaDgxOEs5YVlNN04rTDFaYUJTeWxQVWt2UE5hV3paWjR2?=
 =?utf-8?B?Y3ZldlZRV3pWNVZPdWNBcXNtTm90dSt2bm02a2ZBeUhCenAwNTZ0YVV5cnIv?=
 =?utf-8?B?TkkxV0ZPWjhveGc0U3dIMWxQUXd6ai9UeS92OEpjNHRCY010RWIvSjRmK3VO?=
 =?utf-8?B?Q0VWemo2RW9xSjJieEMxSFRqbmhxMjdqemJwVi9ROEw1Mnl1aGpNYXZWUHdI?=
 =?utf-8?B?WlNCaFMreFdkQURGeS9SbU4rM3owNHVjL1M4eW5HS2dLMFNmaDNvZ0o3YlV0?=
 =?utf-8?B?R0JxblB1dTc2R0NRL0JYVDV3eXB5TmJvVmZpS3Y5L05uOGIxNzEybnFMaHlt?=
 =?utf-8?B?djdaVk54Q2hRWndjUnhKZE9hR1FqWFM1dThtQlZsVnJSdlQyeE1oVlFnNm90?=
 =?utf-8?B?T3E2Qk4xbXR4MGdBRGZVSmZNWXBqVGRaOCtYVkhIT2ExSUV4dUp3OTE2Z1lu?=
 =?utf-8?B?MVBjQ1hXSUlDR3B1N29LU3I1ZmFsdHVRSEZHZW1PeVhvd2M2R1RIYTZJN3cz?=
 =?utf-8?B?TklLN3h2SlV0RnI1RkhYTW1uSzU1ellBeHF2U2NhOHB3d1V5WGlReVFyUSs5?=
 =?utf-8?B?UVJQdjZaRkVZWHVqb2JTS2VwYnpVY2hYTk55YzZOTEI2TXk4RmlReHppQ1ZG?=
 =?utf-8?B?Uk9INkRXNHJkZkFIU2hBUnliUTVibmVMQjM3ZzRHRysyeERKWkxKb21nTFlm?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8994a53f-d321-4088-ca8c-08dbb4401406
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:59:11.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HRf8a2FBz8ZDmY+87gW9VQJJUcgY84bTmsZuYQCdREA9LUA5Tdo+DVXhL4toZ9n9TpV9Otb2fMx86TGYdXLj7ZhC+bIZwJjphEMOGh6AkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7115
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yajun Deng <yajun.deng@linux.dev>
Date: Wed, 13 Sep 2023 10:08:08 +0800

> 
> On 2023/9/13 00:22, Alexander Lobakin wrote:
>> From: Yajun Deng <yajun.deng@linux.dev>
>> Date: Mon, 11 Sep 2023 16:20:16 +0800

[...]

>> EXPORT_SYMBOL_GPL(dev_core_stats_inc); // Why not GPL BTW?
> 
> This may be a better option.
> 
> Just because EXPORT_SYMBOL(netdev_core_stats_alloc) before,  but I think
> 
> EXPORT_SYMBOL_GPL is better.

Ah I see. BTW, if you will still define increment functions as
externals, there will be no reason to export netdev_core_stats_alloc()
or even make it non-static at all.

> 
>  
>> And then build inlines:
>>
>> #define DEV_CORE_STATS_INC(FIELD)				\
>> static inline void						\
>> dev_core_stats_##FIELD##_inc(struct net_device *dev)		\
>> {								\
>> 	dev_core_stats_inc(dev,					\
>> 		offsetof(struct net_device_core_stats, FIELD));	\
>> }
>>
>> DEV_CORE_STATS_INC(rx_dropped);
>> ...
>>
>> OR even just make them macros
>>
>> #define __DEV_CORE_STATS_INC(dev, field)			\
>> 	dev_core_stats_inc(dev,					\
>> 		offsetof(struct net_device_core_stats, field))
>>
>> #define dev_core_stats_rx_dropped_inc(dev)			\
>> 	__DEV_CORE_STATS_INC(dev, rx_dropped)
>> ...
> 
> I would like the former.  Keep it the same as before.

By "the former" you mean to build static inlines or externals? Seems
like the first one, but I got confused by your "the same as before" :D

> 
> 
>> Just don't copy that awful Thunderbird's line wrap and don't assume this
>> code builds and works and that is something finished/polished.
>>
>> You'll be able to trace functions and you'll be able to understand which
>> counter has been incremented by checking the second argument, i.e. the
>> field offset (IIRC tracing shows you arguments).
>> And that way you wouldn't geometrically increase the number of symbol
>> exports and deal with its consequences.
> I agree that.

Ok, after this one I guess you meant "I'd like to use your approach with
static inlines".

>>>  
>>>  /**
>>>   *	dev_get_stats	- get network device statistics
>> Thanks,
>> Olek

Thanks,
Olek
