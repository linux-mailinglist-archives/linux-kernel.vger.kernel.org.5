Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E0773F68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjHHQqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjHHQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:45:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD0944468;
        Tue,  8 Aug 2023 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510186; x=1723046186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sSq9JAJw0BzGfL88jDeMmGXNdX/+MgQg12fEEVc8XXA=;
  b=j+5PLIGho4oeG5ui5rY5bLfnyQZfG4Gw/tqLf++YjiOR4a7v/+Ig6+Bb
   D0T0C6P8z2pDdFyuubMYlSNAalgRC9lxtU+gaZXgzl4ezuP6kWt7BLoNF
   VgQDZ62yQRG4ifvs8v8XS+x2FVHzfJhAyw9fdrsvBk7VWRGSbo5ht6t08
   I7uIhw2ppALGr1p1sL3w5rkHkwuRkipjZ1hQUdXq73+wLqcdKYCm9zlo1
   hhZb8t14Pzj76V/W1WR9tsgDL72PryryRMCaWQuTicT67DBeG3/2pEaoP
   fDxnChxwoBcBFvRfqBlEFB7mfbI+RYRxx30uvZxg9HoGKeeHeYY1KSz1D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437150671"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="437150671"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766379309"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="766379309"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2023 06:18:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 06:18:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 06:18:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 06:18:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJNxYAwB5QGJ0INpvAXbFLHHIawrERcJ824/2zzq0TM9GgzijqLbpdb2YReDllD6p75FBwe+1b0cki5AzH8MAbt6cbUwL7HUnp39AAPsiRpZsmmfJ+53wwjuEPv5lMxeleE3ljwXy6zMnszDDGyowhkLN5vKhiZPffAcF0DMLnElNsoNnCQNo3w3j4dzN+sBhBqA27X9TGzB9/RP1GyuD6INtu/Dqe9yaI1brNXtzo5FVtW7NqVSMQ4qIH/D0hK53AfWYOyK2osA8mnyZ6fBWn0A5v1AuMqfu/6OIQ4b1nnbXQl3fHas996si+Oxbrqywq0Tqo9IevS0DX/E3e9tBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWk1p+7nkZGnaV4T2Gl9vpaaI4zrBtYjBLLImWspLnk=;
 b=J2WgWCv8QZPeEXfMeOkWw2VO+Lrw1RjzRgciJOQFP183MCZuDoOQUGY0ogznnl7CBElZN4OXhlPb0hMskRH+FGYAkYW3xaatTAkjZQXbNQu0+2RWecidr+vB94PE5lUbMBD1mc5FfrWSBugD0lSxqzEdnz5q1BPc1Ghq0IKAXFVP0K/lyVdh88rL5w4iqgA+MTRhAPNW79PMyFk6Va9e5qNrLSKa8tc9+seaj9LaszrIOeMXAFJiREVs1+kioupDjRGWlWiAg6TmhKaLBaYeyp+5w/Pn67JJysAkzh8f6Pf9CwdsLIWchhjihzzrZaIxxAT5HpZTP6Vd9YfjIWj0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL1PR11MB5222.namprd11.prod.outlook.com (2603:10b6:208:313::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 13:18:01 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:18:01 +0000
Message-ID: <4e26eb3e-1cfb-2572-4002-b7abda022e5e@intel.com>
Date:   Tue, 8 Aug 2023 15:17:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v4 0/6] page_pool: a couple of assorted
 optimizations
Content-Language: en-US
To:     <patchwork-bot+netdevbpf@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <maciej.fijalkowski@intel.com>,
        <larysa.zaremba@intel.com>, <linyunsheng@huawei.com>,
        <alexanderduyck@fb.com>, <hawk@kernel.org>,
        <ilias.apalodimas@linaro.org>, <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
 <169143962373.20323.15736867821555960200.git-patchwork-notify@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <169143962373.20323.15736867821555960200.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL1PR11MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 73482dd7-4a12-4e51-49d0-08db9811e439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7baciLwSdBmp35K2Aa6zbyPn2vuiYJdqOPKGTfQNXmBvNAk/DMAYzKy8WH3njXMaZ+WPESsvg2huMfn264zHPlHWQUX+r44iioiBKRY9Z7ALObHn14MfKQYOgqQFMdkqueeGLdzF+fYv3+TSa4zUmzCcWMmKpPC7cMxX24/kEapJc5x5a8AlfRTrwJ8wIOW3RQPUb8EaMh8UrzoDhtdFsWUYm5tcPD+yQVoI6hBTgo5HEc1VgCUalBu2s8Q+7jXwD8nUfCz6ku4QurGvfPkZA2kKxQQGwfnLOSqyHWoX0spXXTER/v6bnqzQm20CMupl2NalgV+2dxdFWrxigtcY6iqoWrmKo9ElG1oZattHWLHTSnB7+7AUqaOV1lbbcGImvwGcMa4qki03F+WAT0K2iv/aM4EhJixH8PSZAZKwXltVyp/sk/SXgZjNmDPstNHOf5HJbiYrbwT6b81mrWjCE3RFDX2ckisYL4ckwPSwxcVMRbliYNZe7zu4vnoBExgZlLtCd8OhDwnTfhHcNws86DLAOCYOeW6L5TtJjTwXrKF+3bwTFfv9aKHD9iLOfpCzAq0Ad1li+gCIWqTqsjOzqL3E+s95dB/6khkLePr7R4KziGIiqIFesOhJUL/GOG/OL66LEPcB4KXknBaNu+jDXtkaOftJee3ktSCEdQMu6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(186006)(1800799003)(966005)(6512007)(6506007)(26005)(36756003)(38100700002)(5660300002)(41300700001)(7416002)(86362001)(31696002)(4326008)(66476007)(66946007)(66556008)(8936002)(316002)(8676002)(2906002)(6666004)(478600001)(82960400001)(2616005)(83380400001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?end6YTcrMnlOVGRselNwcnVyMU1GdHgrb29peE15YTJkUTdtUVFEb2VDQk5I?=
 =?utf-8?B?ajBUM3A2UUZoK2xzUlA3ZEtRZXRTRHlPNWNuemtTU0ZTb2NVVHBUbmZ4T1dh?=
 =?utf-8?B?Nll0cndCYWlIb2dLMTlURlFrczBjdkhPYlRhTVJTZkwrQjBWMm9adzh5Y1pa?=
 =?utf-8?B?M2hUSTZBalg3L3huS2hQT3NDTG5BM3dBTWplT094Vm11NUoxWUM5cGpZWFJV?=
 =?utf-8?B?MWpMLy95MS84SHU4STF2ZlZ3bVIzdWtubkVYN1BnL2FuaXRqclNCSHg1bWJS?=
 =?utf-8?B?WkFPMGV5cGNuWm9vdGZnbTBiYzdlN0NhTzlGMUs0VUpqN2JmcGRJWkFUTWNy?=
 =?utf-8?B?Vm1DYnFrSFltaEZxR0RUd0kyeWdVS0cyeTdGcncxRENvZ3ZtN3ZrYWlRbmFK?=
 =?utf-8?B?TEplTWxtOEpObFdaWmU5SU9WNTVCbUF6TFQ0QnFuSTZDUDdqa2oveXROV3FT?=
 =?utf-8?B?aCtma1NwZzhDbWhUSGZqdHFVL21tVGJicHhwUW9NcUZrQ2JhMGlSOSs1dDlY?=
 =?utf-8?B?bERyUk82RDhsMmxFMHI2b0QxSzVwR2NVRDdaQmVvQmp4Y2MwekxxTzRVN2FG?=
 =?utf-8?B?L244SFMwUzFUaGdPMHAwcUtjMVFsaS9XWmI4RDhZeWpOQTdIQ2p3OWhxbUUw?=
 =?utf-8?B?UkJlaDlJRENsdEhaMWFhakNnNDc4eDljdzdvZlZZVjAzeEZSQ0VKeFlsZU5t?=
 =?utf-8?B?UStKRlZqWjNWRXlCRWhpWmlxekxIamk3NWxxc1BNMFNIdi9NaW5NWGk3ZFJI?=
 =?utf-8?B?b0ZkbjNydG92YndBL2V6a2RwWXNKQ0ZzNWVGekZaSDZuWlNKcnhheFdoN2Nm?=
 =?utf-8?B?bTQ3YWdpTjEwczJ5QlBVT0NXRUxaazEzTkVRdHc0ckpPTnN4eEZTS0dMNmdq?=
 =?utf-8?B?c3gxa05tRWNPdm9jZkJmSlJ1TVhUUG9PRkRzaDcyLzd1MHlwM1ZBWmZpT2Ir?=
 =?utf-8?B?TzlyVkxYWG0xUzNwZzl6OXc1YUhYOHk5WU9pSFBOL0JnUGdXU0NYdGtXN3JT?=
 =?utf-8?B?Mk5CNHNLTnRVeXZYMmxhTXJxMkMvN1JybC9EV0xjNGpUVkFkTFVrSFlOT09O?=
 =?utf-8?B?KzI2MVhBcWpQaVpiOGlmUXU1SVNMb2ZQWGpiNi9MNytuY3pscnAzS2JQN3Rj?=
 =?utf-8?B?em5wMkhhS1JjT3lxeWlHL2xHUitQQ01mSUxxU3o4aEFvdVRIeHlPdCtOWnYr?=
 =?utf-8?B?NnhXZTVVclpvSVNaTFFydGxXVjE5R2VyWWhJOHk5RmI1VW9VWnJ2alF0Rzgx?=
 =?utf-8?B?YkZTeEJsSHd6UnBGWUpVbzhLazBXVFRrRDVrNVhRd21JL3hYRy92RVVvaElO?=
 =?utf-8?B?MEJuWDlhTmMzb3F1WWpvMjNZcHhMNUVKNUFnQ0xZNU1GV0RScnhGRENWQnlP?=
 =?utf-8?B?anFTWlN2bG81TmlrcDRCVHptYUN1Z2xneW1oeVBPUHhGOFpnSUxFcWhWWXRG?=
 =?utf-8?B?aTg0ajNSaHdaMVZJYTZpaFJ1aDJCRHhWdlNvejVRMHRvMmtBdFFMODR1aVFM?=
 =?utf-8?B?QzJGSFh1b09KMFdzT1N0ajU2cC9GWlZNQ1ZhQ0k2R1lZMWI5eUdGQVdXV3Z2?=
 =?utf-8?B?a0RTdHlSQXFQa29DaDI3ZDdybm9jdHh6WkdzYkpneVdoZzhyS0tPQTN5UUI1?=
 =?utf-8?B?ZmV3dmRjVVJQL2xFcER0cFI2cWRGV2ZMdGJ3WmRWckxvVE1ieFpwUksvaWp6?=
 =?utf-8?B?bzl5a0RlcTNrOTUzRnQwSTJvelkwd25aVmh1NTFGc0xKc1JOWWp0TjhNZGlE?=
 =?utf-8?B?cjNRMXRVQnVrVkV3MnlXWVhzSjJaNHhhMC95T29IS1lPeFFHMHZoWDNobWRy?=
 =?utf-8?B?aWQ1cEt6RmJvQlZ6UzlUcElPZ0IxeVdaWnpvUlRMemU1TEkrTG5nZ28zQ3hq?=
 =?utf-8?B?VGE5c1MzWGRjZFA1dEhrMFJSQVBxK2ZXUTVpQTlac0tGUnB2dTBSaTcxcDdL?=
 =?utf-8?B?dzIrTGd1V0hPNko1bUd3TysvaW5kN01zNmtGYnBVcUdRM3JBaUp0NXVzRTZV?=
 =?utf-8?B?aFZBMFNQcXJZMTUveG9TWXpoN3N2cC80VlRWamIwMmo4cVdhQWdZYUpVTkhp?=
 =?utf-8?B?NUc5NlJEUmd4ajNoakxmUXFpVFNEOUtIVlZxRVBXa2xHZllPb25aMWRIbWJq?=
 =?utf-8?B?ckQ1VG02dk9zR2pic3kwaXBGYnNzSGVsZ1VYZTdSMFh3KzA4NFFXUm9xcm5m?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73482dd7-4a12-4e51-49d0-08db9811e439
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:18:01.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uS8R87E+ZFzLxsWEhoSHYkq/XnWONw3Pm84nyefyqSBQngw6afTu2/vsU8RIn59Do9DWukQhfVb9aQooelAQEw1N8NHymPl3JYyN5SJwj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5222
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patchwork-Bot+netdevbpf <patchwork-bot+netdevbpf@kernel.org>
Date: Mon, 07 Aug 2023 20:20:23 +0000

> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Just got back from the long weekend and saw that mail, nice :D Thanks!

> 
> On Fri,  4 Aug 2023 20:05:23 +0200 you wrote:
>> That initially was a spin-off of the IAVF PP series[0], but has grown
>> (and shrunk) since then a bunch. In fact, it consists of three
>> semi-independent blocks:
>>
>> * #1-2: Compile-time optimization. Split page_pool.h into 2 headers to
>>   not overbloat the consumers not needing complex inline helpers and
>>   then stop including it in skbuff.h at all. The first patch is also
>>   prereq for the whole series.
>> * #3: Improve cacheline locality for users of the Page Pool frag API.
>> * #4-6: Use direct cache recycling more aggressively, when it is safe
>>   obviously. In addition, make sure nobody wants to use Page Pool API
>>   with disabled interrupts.
>>
>> [...]
> 
> Here is the summary with links:
>   - [net-next,v4,1/6] page_pool: split types and declarations from page_pool.h
>     https://git.kernel.org/netdev/net-next/c/a9ca9f9ceff3
>   - [net-next,v4,2/6] net: skbuff: don't include <net/page_pool/types.h> to <linux/skbuff.h>
>     https://git.kernel.org/netdev/net-next/c/75eaf63ea7af
>   - [net-next,v4,3/6] page_pool: place frag_* fields in one cacheline
>     https://git.kernel.org/netdev/net-next/c/06d0fbdad612
>   - [net-next,v4,4/6] net: skbuff: avoid accessing page_pool if !napi_safe when returning page
>     https://git.kernel.org/netdev/net-next/c/5b899c33b3b8
>   - [net-next,v4,5/6] page_pool: add a lockdep check for recycling in hardirq
>     https://git.kernel.org/netdev/net-next/c/ff4e538c8c3e
>   - [net-next,v4,6/6] net: skbuff: always try to recycle PP pages directly when in softirq
>     https://git.kernel.org/netdev/net-next/c/4a36d0180c45
> 
> You are awesome, thank you!

Thanks,
Olek
