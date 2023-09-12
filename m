Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A272479D75E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbjILRQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbjILRQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:16:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F6110D9;
        Tue, 12 Sep 2023 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694538978; x=1726074978;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S6t7gT2rUP2JkFLbOE4QeQrvOf5rzPuHyw0n3gyUTHQ=;
  b=Uc3MZ827NQY3YhYIv5Ae6jjcvYGVqoo5ISeHwqxnPP9ylxjl/DZOq2nO
   Y04VyMbTKIgql//9tBBn5cgj6VDp7RSeP0xfinuCO5zXeBbIQFbb0mcnv
   6sh9iKLjPt1+jEKSBA9BJ235VCUQVc/olag3jfHhqjj245ZJXy+5nNAeM
   FzjJLmOy6odcw5DHEgKY6e4bK1pWHcFuG0nrZYdxvOlL2lVnXs5MnCs2t
   UpWuOAcl3glCQBYRjQUBr07tyKg0BEvE0Xv/Yv+1n5fnJ4ZEIPTFpomcG
   hpmz5dx41R2eMxSJzZ8WfFQq/XV569XIxBOUYORZzYAxHLFMEgfiuotnr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="444879837"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="444879837"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="720490652"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="720490652"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 10:16:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 10:16:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 10:16:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 10:16:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 10:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrGMx2TCGo6YFdZlqoXQ8LF5QkOeIVjDLXBxn0Sw4QB9pOdFHIeuS0cT8Et3HuIVBbqtFomM411H32ST2veX8ISX4N+JtluJbOmCjSFQNgGJyKRqXJMArD/9aHeOekNn25tb35/IbUheEYIfzVAvMAZY2BE907hB1cmjEyxvToEbmbcAe5iJZ5OOhu2yBbSmndXCtbN/5HKpnt0R/oH9OlikoHe+l3QZNKqpo6Gl+vKmJ46FJPD7WTsjoF7+zt26TVLBGZI22xDa7mc2hn5Ky/4TsCgPBQytIsrJEqRDH2KO+QpW1x/aIQ4INMUyd0MttCXWOTr+b7qzcjRu/opxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qbi/PNu7HWrOvO4N612a3hrs42YPqbQFDz5sxFXWKc=;
 b=JrzAYms/PyZiQWB+AjCzQo4n9lvE2YCwGFwks+6j2PoZswzlfH5Mw5f/U0QiYsJ306sf0BrA5U271yzeEd+6xVZH8+DUwD6rN3lnMFZtVyQme72A5G4iecOTPSIrL0tJxIoOMzUI5QpPlD9Kv85flnAd1Aj/X5ch5fNh8MPpSJErEsbxCX87ULDEWaTrKiJbsmHh5LMiX6QRcXTZgPPDPi5rmxwS6LfL+boew3TTdwaMDsZy0Bn2Ch1agpr0L33XYc9hewTkd7xo2xGHInANBXaptzorr2+3456fQP7AqcPmGYtuiiyB8n3OmXVW9QkQk5blXL/NEyZ+4ZOm7ND+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ2PR11MB8513.namprd11.prod.outlook.com (2603:10b6:a03:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Tue, 12 Sep
 2023 17:16:14 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 17:16:14 +0000
Message-ID: <39c906f6-910d-01c7-404a-8fe6a161ef2e@intel.com>
Date:   Tue, 12 Sep 2023 19:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
CC:     Yajun Deng <yajun.deng@linux.dev>, <davem@davemloft.net>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com>
 <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com>
 <CANn89i+AwmpjM-bNuYRS26v-GRrVoucewxgmkvv25PNM4VWPGA@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CANn89i+AwmpjM-bNuYRS26v-GRrVoucewxgmkvv25PNM4VWPGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ2PR11MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a3a12c-cb67-4625-720e-08dbb3b3f800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /K4lAZF0w4yNrOaP7u9zc8whstg/l3/2eeFkaxMnzZvMpC13YEO8kUetJHda7menxTBP1UAYiaujevkT9p8ZqkjPtMMhFVeM1P29k1zVP7l8/lQrButrtS1xoMYJxTN4smMu3EajUDju3sWVOacZLAO1kUF5PnZY7c4MvvAG8rIEdaAddvaGmJMzh46rAakqlvjnfshpt2ScCnoZUkrFglEhz6wJa3uUdYdueG+hUqQeAU6IuSw6GTRzm5/DkdW6F6uRplnn/kjezTNBiysIusf+E8pTIbnlxFICjYSnPqwqabzCXjZKf5djYV8Wg0aYWo6PGuTxPXiAbxWAF9kzlV3TtGnGUlTX0uRpgRIEPRWdqMEjkSZD3ONzmFLy+Bho7hNZMIri65mnLp9ykgtAjI1BcRorv9GigRJqzS3dy2Tl6qHXEGDSBjfRfrVRt4HT4XZGxPcAga1yrMGmhGagpOm5A4yr99A82gOpaF+mqTslJUcj+P0+yEW7g0gEkdcliqpQjOrGkXXqGvgKJeGYeOqA9l7rbf7YEWwgXErWo0226QpdWRp6UoXNJOK9QdoErrniQfrOMzhAwQOwHJHaU9UH5CT/O/WZETl3RbZmFvS03cbh7a5uPU/QnAZZWgolAZKLxicq75BKTQakrAf+xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(186009)(1800799009)(451199024)(8676002)(316002)(6916009)(66946007)(66476007)(66556008)(36756003)(26005)(6512007)(6506007)(6486002)(53546011)(6666004)(82960400001)(86362001)(31696002)(38100700002)(2616005)(478600001)(2906002)(31686004)(5660300002)(41300700001)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXB0cENXM0M5YkJpZS9XWGJzelFVamY5NGpaeWNpbXpqcWNnb00rSUFjOUxk?=
 =?utf-8?B?aHhDblNFNkZvNzE4QU96eUNMUllDSlNTSzRqaDhGWDlYaVJhVlB3YXBtSzl0?=
 =?utf-8?B?eWJJQjFIbm9BTEVRaHVObUs5T0d1ZUtLMFZYWlNhQjFvcWgvaXFCN2g1VzNo?=
 =?utf-8?B?QXRJaTBmQThaK1ZocW80Yy9zcU4rK2RDZ3BGS080NmZlR3lWUTBvTWZnR1VX?=
 =?utf-8?B?L0ttRitiZWNaWDc2aVU0QUxsSjh4YlBUSVo5cjJRM2ErMmRsYzNIcUpjYnhV?=
 =?utf-8?B?T240ajFhMkJYZk5CUmErM2hoM1cwSDNEM2NOYVF6MGRkcW4vWHJ4WVNEcUk2?=
 =?utf-8?B?Zmgyamh2c0pVNnluMDBmMExKbmI1dTRhRUNudXJucUdxdFFjcm5ad3JIbGdq?=
 =?utf-8?B?R0svMzQyRWlWcHRXY2VVQ05MWnpoNzRHaXJRMkpGM2xoSm91OHVQR1ZrbGpZ?=
 =?utf-8?B?Z1RuYVRLaXFrTFI4TjFkYVhUdlFUMTFUd29mb3JFd3lyYUJtbFhJbDFyVDRK?=
 =?utf-8?B?Q3ZpeWJodzFsbzBEbk1wZkhhcm9PKzh1UVA3aUdVYzkzY3kwaENGeGEwZnJM?=
 =?utf-8?B?bHpEbHIweldySG5QeTJQVU9YbnFaUEpqTVFzM1MwK295dEIyVDRXYXBNdkhu?=
 =?utf-8?B?bG5oVmg4Rko2Z1N3SUtWcGJvOWZxcEJiT29FT2cweUFFMzdvVmVRL3VqMUgx?=
 =?utf-8?B?eFVqaC9LbVlJT1lhd0pIaWYyRFdmOUtXbW03OE9kMWlPV3ZBelpoc0t2S3pJ?=
 =?utf-8?B?VThtWkZ2R1NKMzI2MTlDaHp6NEZETGhYbkpMWVdlL3dBZlRUSGZEeXYrYVdk?=
 =?utf-8?B?c0Fpb3pFdWVhZ0QvVUdTclZDNElIbXhlUE4yZDdicWNZYjR6NnpZeTVuaE9n?=
 =?utf-8?B?Q29mUURJTDhyNDEwbDVMQUZFNmtmM2E4K2VSOS9NQ2NBMDBMcHFlOVFqWWN1?=
 =?utf-8?B?TlNSMG5jL1RvcmZsNWlkRnU1cXB0MkxES3ZCdXE4TWdjS01iU1NTRUE4cGlG?=
 =?utf-8?B?NGc3TnVCclQ1NHVlRVJNQXZsVzJTYnZtY3NNaG1GcnB3Z2lodVZzSHk1Umx2?=
 =?utf-8?B?U2p3d1dXVmIxc3hONmI0bmtwc1NDSzhZdlNJL1huRE8ycEY3dVpaVFlldEpm?=
 =?utf-8?B?a1VIQ2c5ZVRlbGZZWkp0VFJCUHNNb25FOWZaWFgva3A4UTBML09kWHNpOWQ5?=
 =?utf-8?B?dC9USzY4MFZmckdSSWh6cFlmWjVrU2wyd1VsdDVLRUlsN044U3lzSEVpYnpw?=
 =?utf-8?B?c1EvZlg1eUJmSkxjZXMvYnpISzVwaCtxRWZ1c21lWnRVaE9kMzliU3N0ektn?=
 =?utf-8?B?NDJTVEZ2cUhqTzg0bUVqM2c0NWRjeWR4UWwyYUtMSjB4ejJIcTVBeU9KZVdE?=
 =?utf-8?B?enZ3MWM2LzB0U2FXTlU4UGRaNHFhdmE1TUllaVZpUFRLRHN1Wk5xb0tFMUli?=
 =?utf-8?B?Uk1Gai9temZad2JFajArVzUxaW1pVHlwZVN6dENlbm0vM1BwalB5bXlBMTNl?=
 =?utf-8?B?anJpVEpqaEk3M2pRTWVNOGlzSDhoN3lSYVJvVnA3K05keHMxdlZGenZXMlZG?=
 =?utf-8?B?RnVQUDA4OG9HTTRvOXFmOUtEQjZ2QWpHNUkvM3RDRVZXaHdhQnhZYkZJektD?=
 =?utf-8?B?dlJjMFJFNzVlbFRLdDR6a3JUMjNscHkvV1FpNVNRV3Y2cUFlMXp1cU1aRDhS?=
 =?utf-8?B?dlVhS3gya0Z3cUk3S1hyb2FpTzNzMkhZZUR5alg3ekQ5TzdjSlZ1K3NacWZy?=
 =?utf-8?B?ZmZoWCtrQlJaQ0VSanc1eFc4djkvR2xmYjZvUmpPaGtXQmUxQjZqUWtQcHlP?=
 =?utf-8?B?cHNDRjduMjVnVGZwd0YyN0xFRnNlQkpjMmZVRlMrTHpJLzBpb3JzM1ltZnRq?=
 =?utf-8?B?WTkyWUxnclEzbUV6QytMRTA1VjhCTm9OL0FyWEk2TEtOc3pRYzA1SkcxWVZs?=
 =?utf-8?B?b3VFNzhCaGJPSTVTaVM2WFRoSEJHbEJ4RUdZUlBSZk9oMEVrUHpEQVg4Mjlo?=
 =?utf-8?B?c2FRb09rZTNvbUw2bTdHaTVON0JIR3NGV3F4Qk5yOG03TUhUa3BlYlBYTXBN?=
 =?utf-8?B?NDRSTlFUTVpzdFVSSWJILzNYMXpOV0xUZytSZHZQWm9PZjMzVTNuRTdzZjFq?=
 =?utf-8?B?U1pPV2dvNlFSNk5CQWFOL1hHRS9iYnh6dzVWb2loYmZMYmxKdHp4Q29GK1p4?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a3a12c-cb67-4625-720e-08dbb3b3f800
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:16:14.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTTregOq4LMm1kliLU7CNXpec4nJdrktjxokdz77GMB3AbchEuNXCqTOTzCMnDdyzNzxUiX9xxkhywe7FTEJUziktk/olPZtLeHXzCmG/4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8513
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Sep 2023 18:04:44 +0200

> On Tue, Sep 12, 2023 at 5:58 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Tue, 12 Sep 2023 06:23:24 +0200
>>
>>> On Mon, Sep 11, 2023 at 10:20 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>>
>>>> Although there is a kfree_skb_reason() helper function that can be used
>>>> to find the reason for dropped packets, but most callers didn't increase
>>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>>
>> [...]
>>
>>>>  EXPORT_SYMBOL(netdev_stats_to_stats64);
>>>>
>>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
>>>> +static struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
>>>>  {
>>>>         struct net_device_core_stats __percpu *p;
>>>>
>>>> @@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
>>>>         /* This READ_ONCE() pairs with the cmpxchg() above */
>>>>         return READ_ONCE(dev->core_stats);
>>>>  }
>>>> -EXPORT_SYMBOL(netdev_core_stats_alloc);
>>>> +
>>>> +static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
>>>
>>> Please remove this inline attritbute. Consider using __cold instead.
>>
>> __cold? O_o I thought the author's inlining it as it's a couple
>> locs/intstructions, while the compilers would most likely keep it
>> non-inlined as it's referenced 4 times. __cold will for sure keep it
>> standalone and place it in .text.cold, i.e. far away from the call sites.
>> I realize dev_core_stats_*() aren't called frequently, but why making
>> only one small helper cold rather than all of them then?
>>
> 
> This helper is used at least one time per netdevice lifetime.
> This is definitely cold.

But then each dev_stats_*_inc() (not cold) has to call it from a
completely different piece of .text far from their. I either don't
understand the idea or dunno. Why not make them cold as well then?

> Forcing an inline makes no sense, this would duplicate the code four times,
> for absolutely no gain.

I'd love to see bloat-o-meter numbers, I suspect we're talking about
20-30 bytes.

> 
>>>
>>>> +{
>>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>>>> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>>>> +
>>>> +       if (likely(p))
>>>> +               return p;
>>>> +
>>>> +       return netdev_core_stats_alloc(dev);
>>>> +}
>>
>> [...]
>>
>> Thanks,
>> Olek

Thanks,
Olek
