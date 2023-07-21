Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7E875CC1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjGUPkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjGUPkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:40:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED21030EA;
        Fri, 21 Jul 2023 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689954000; x=1721490000;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FG5/yKy5eqBl14VzQYbKaTSF6lD9xiXPNKivd67mwmU=;
  b=KwJGuZWz0uqzAOUTuh+wfelOn1LhFWjoSv5CyfXfL6WUssTkD4JuzPmQ
   0gaClhJ4wlcTV3BlzpTvwgkfGdXEDNYdcmsRdKBpPDOy9DwC50jhKCALl
   CmKRs4ZohOgoUw5jVAV+OfbOF/MkrOzh9WS9fNNQvsi/iglL1JNil0bnK
   riVV5ePrZApS5sfhCznJeaQlZ0EmBXWafWQ6R62QNVNJgHsYaBcWMDkt+
   526iu2HDv4ubStBfOBbxFdGOc+y1pjW2vhoCYdjGWhlVAHAUyGK6fN6pc
   SMExiC2e8q11CUZ0e7jGEYvEQFtDSJFl37YHl2/s7Mnht4cZUo8fkKSUr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="346652171"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="346652171"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="718865577"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="718865577"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2023 08:39:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:39:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:39:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 08:39:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 08:39:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoLsJQxcToLs0KBP1Fz4/XmfFTIQLEpa7uzSE4+flBb0JtWU8UqJSPLzeV9hv2fEVoa8kwKMSGvP0svV186JRtuJgO0QZz6+QQBaA2+MTVVoHkOsUs33Chohy2cs97iY4b66ZbqTfpFzp3eeM2B6DSDTfwq9uHCTny2Rad2Uy+gnvHEINlTd2i0n57vwtjg6oF+Wt0RRKcLRFVbFwt3sU9StsG+lWYyk6z3oaLM3ymw3w8Nxb87cHH86FsDHe9LBZ9IMIX82a2lA2fObQPpIOBbcjlf9npvdz8F1UKzwLDe3sDBStR9ZELYLTwVOFScg22aLl1HWdKI3nCpNXbIZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfEcHniJ0l3zARp+vFRg1pQ10pVdOZYwGwfn8Ii+oQk=;
 b=d4E2hG5+WOv8Es+9AKxBj9dtVrNifqW77Q1QCPNgY9WUPeFdLRlqvuwtpuKZr2qCWppbBiBhzVdfnn21WENI2X+q28YF5HTQlnkwsq8yQ8Ws0+sLX8GKfHUHEx+eK3aoAyr9EhBp/dJKxg6uDIgCfWlYGGzIjw9XT8+8PpQBL/utQO01LESimaFNh0Sunec2NjtLJI7+2ux2jcv6Exgoy1hI8A8f8iG9F8eMDjvFBHtp1OmS2uK9IMnkXPGWtPbwYdwvkSYRAvq9aFr/Q+VswnPLpJHRH1xlVs5RJda2jppdMSLItLCytuNYgzpryDw3uwJcio5coiGxheRP1pJCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 15:39:08 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 15:39:08 +0000
Message-ID: <ebd284ad-5fa9-2269-c40e-f385420b27c3@intel.com>
Date:   Fri, 21 Jul 2023 17:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle PP
 pages directly when in softirq
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-10-aleksander.lobakin@intel.com>
 <20230718174042.67c02449@kernel.org>
 <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
 <20230719135150.4da2f0ff@kernel.org>
 <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
 <20230720101231.7a5ff6cd@kernel.org>
 <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
 <20230720110027.4bd43ee7@kernel.org>
 <988fc62d-2329-1560-983a-79ff5653a6a6@intel.com>
 <b3884ff9-d903-948d-797a-1830a39b1e71@intel.com>
 <20230720122015.1e7efc21@kernel.org>
 <e542f6b5-4eea-5ac6-a034-47e9f92dbf7e@intel.com>
 <20230720124647.413363d5@kernel.org>
 <406885ee-8dd0-1654-ec13-914ed8986c24@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <406885ee-8dd0-1654-ec13-914ed8986c24@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed8dbb8-0b24-46df-2953-08db8a009f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEA/Xo7qvK09oC6YlQ54YemD/UrCmV7xtUKnw5Yy5zlh1uw98xK6xZScquCdzvK4aIKpuJZeryDorZKbQyzHL3V9Dhsv8qMG/ONA0MQk5IimCKdhxDNfurpN56xfZP9GYWE04WYlMMYO77dQa7TzHRTo+q+sWRA0SXOcEHEpPwUPiaZAdGyGQh9d7/SvUa9P+yk4/9zdZk+4IoG082jgiK0o+ctyr0Ovu3/hi+Bj4B1h+u3rcrc11aVVhH+WoDBYtvk9K0JoQ5sDo9qHKDVUnmc4M8VuguAjiYdNczhP+5fQThxFKgbxEApXg+dJ+jf5fruIKg0VDNyjeZg50hGZd+e6ufriT+y2GhgqIVWKG+vGxuHQj1HkWY5otF4/KjoyLlbOlBVwlrPL1SlvjwbuFYcUv94qiNjjxbU+EBv9SBGdskV558UgHJhryxyp2TAINScCqNuVJ8/w3I74sz7WAFmlUzTy0qGwEdHPsznptvGRAtZCyje+wY56CjrKuIZCb4NikAesU1ls5FSJLhopWrK31Pt2KHJ4znRrAx5GGpAvkKgTSke3qeXOVOwU40AyhofNz3i7qStfLy1mRaVTefIm1Jdch3U8P0kf/HCLdkl2FOJzLqeS6SmTHoxcS1ijluD0I9QKEioixvI9A8HoRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(186003)(6506007)(478600001)(26005)(31686004)(66476007)(66946007)(4326008)(316002)(53546011)(41300700001)(66556008)(86362001)(7416002)(8936002)(8676002)(54906003)(6666004)(6512007)(110136005)(6486002)(5660300002)(31696002)(36756003)(2616005)(82960400001)(83380400001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkVCeVlWNXcyK1dWSC9rdVAzSEtZVVhkWlFaV2xodEtrSHN6TUZLd3czVXpi?=
 =?utf-8?B?K2NZTEpEVXlRQ2JTaG5Lbkk2NUxmUXZPZUdyYld4S1Fxb2NXY1ZNS2FXeEdS?=
 =?utf-8?B?RWZMbGFPbFBSS0xGQkVaOGREcHBaZWdjQkpnSWxWWWU1ZHNOMW4xdzBNUzNk?=
 =?utf-8?B?T0s2b0xLR2UrTk00dVYzVjVXTjhQaFNHSDc3UjMzUkNJeVFlTDFnZS9uK1ZU?=
 =?utf-8?B?c3FRTGExaldrNWJ4ck5aR2xBell0YjNVU3ZrL1hPMFBaMTFJa016b2J4VHJ6?=
 =?utf-8?B?ZEJzNzkxaWVFbVdnMzlTT01NTmE4OXlBSTZ3OHZsa0pVSldwT241NEVIb1NS?=
 =?utf-8?B?UG9qR0lJRlhLU3VKT2ppbDNrZittaWJaVk5VSHB3SjZDN050VFRxOXNyaFRw?=
 =?utf-8?B?SnAxUy96ek5nMys0T1c3aUR5ejQ1TFNsblc3SXlucGE5R1RqMmxNalhuWUVa?=
 =?utf-8?B?WnBZT25PVVhucU5rN3lockdCUFQ5ZVlTcEtDdkxaakhlY0w2TjY5dndWTUJR?=
 =?utf-8?B?NDhFdGttN0ZwSTNOc2NFTTI4a3RFQnFpYlNySk83SS91RkpadUh2VWliQzFy?=
 =?utf-8?B?cFJ3ZEhlM0FIVEx4alk3UEJ1TTlMSWdFUnpIUzdaeVRRa0UvZmczUU9rUGd4?=
 =?utf-8?B?V3pDQnZwVWx6YWdYbmNQYzcrL0ZKd24yMDVuMXNEeE13a1FtNWR4WjcxcGl4?=
 =?utf-8?B?OXptazJaSU5NNXgvdFpvM3JBTFYyMlhlTEczUHZlQUlNNURKbTNDU0cwR2hR?=
 =?utf-8?B?b2VtMytGa3dDbURPT2dnWi9jM1NZemtVayt0NUJzcnBGZEJOU202Q3dHUmQw?=
 =?utf-8?B?alE5UmY2ak5XQU5CeG56Z2NvU3grVlJsTTZrRWZlVzluZ3Z2WWFnYUl0ZUNx?=
 =?utf-8?B?Z2R2QjA4N2dRT3Q0ekF6TjhjcGpVV2tHME9IMUhJbDJnakxTeldDV0VJbytS?=
 =?utf-8?B?UHM0SituTkR4VVhMclprQUsvaytZL3NuNHc5V0x4U2NKUGxsSEZ1Qmo4WmJS?=
 =?utf-8?B?bzVaK1h1UGJzZ3FERFJ0NkR1NmNmZFppS1E4N01sbytValF1dlMzZ2R1WWlw?=
 =?utf-8?B?ZElOcEJ2VVVmL1ZmZUEyL2xqZkpaWFFIYkRXbXJGcU12ekNFR2N3ZGpEVU9l?=
 =?utf-8?B?Sm1PdVlNV3gwQnhXNmhBSnluQkRiSTZ3YjJLTVY0TUlxZHZTb1JjY01GeFYx?=
 =?utf-8?B?L25sSFkwdGZXWW9yeEZoMDN5aTRyaHVPQ0dMRDBlNW5GOGhCTXBNaHNFRWtK?=
 =?utf-8?B?eW0zTVFJNDFycklOUnV5VXpHWW5CTWZ1WFp2bkdINEVuRGp3MlNEYitWdVM5?=
 =?utf-8?B?MmVUWTdTNVplT3B3VCt5WGUyRUQ0U2F0bk5vcWZiRmlXbENBdzd3ZlBQWmd1?=
 =?utf-8?B?N0R0RVkvam9KYjlxaUVCeVFoTlJUV2doL3cvZDdDVUlwSWxUOHdZdkt3dGVn?=
 =?utf-8?B?T0VHQkZkZ3RpTFFJK3NJazFkdmpkak9UQ291ZzRFeVpOb3QzZXF2RDl3RGJG?=
 =?utf-8?B?aURFbVdVTHVmZFo4M3Z5anFtZ2ZON0QyWEt4Yng3OCs0VTNkYmF5a1h2enlV?=
 =?utf-8?B?ODcrUmZXRDg1RUg5UUlOaGVqQnhRcDBBT0JPeFQ3M29QZVA2VWRXOU5GWFRa?=
 =?utf-8?B?cXBjamhRbnBmZVA4RSsyU0FBY2J3NXMzWTdUM0F0ZEN1SHlOWWprc0lBcUh1?=
 =?utf-8?B?a2dweHpQdko4d1pwcmdHa0RiL290b2xSREU4UzdOY2tDTGtHYUhJeWJ5Smxx?=
 =?utf-8?B?bjEyc1F2T0NtKzdOYUczSDhGOEFzL3pBU2tES1hNYWpqSzZsdTVRRVQzVFBS?=
 =?utf-8?B?RVdTWncrbTluZ3BKRWhTRUhvRE5ydG00YVMyKzl3aWd6cTB4QzBJMit2Uy9V?=
 =?utf-8?B?ZkJLbXcyRlRFejVPWGlaamdBeWNGTGppMWd2TTlVU1FVY2pkelFHRTVuMEhJ?=
 =?utf-8?B?UnBtbmgxYWFTcWYzSWdDeWd1VVphWVZBaWxobVRlUStsTG1UWDN1RDVUajBj?=
 =?utf-8?B?Z3MvdVZSWWNwQks2RXlJeERGN1NJd2R1L2NrWEFlZ25mWitUek1xV0M1NXlJ?=
 =?utf-8?B?T3hYZ2FHQllzQ1ZTWUU4U1lYUVlaaWNIM1BZMkcyMTFybGYzTzZNMFNsODZM?=
 =?utf-8?B?UXplNzQ4eHUySStFY0NmU1Z6aG1jWW4yamZzMCs1VnM3MklacnRZRVJaOUhX?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed8dbb8-0b24-46df-2953-08db8a009f2e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 15:39:08.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzzA3ooXE5xnbVyPknrJcbo9XGTjlAi9t+digRc8v3oxF3qztUJOTh+0DJoy+pPgdctokbVIQAhZHw8uX2hpAfcnaI/Nld4lNQq9py/s3mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Fri, 21 Jul 2023 19:53:33 +0800

> On 2023/7/21 3:46, Jakub Kicinski wrote:
>> On Thu, 20 Jul 2023 21:33:40 +0200 Alexander Lobakin wrote:
>>>> We can as well check
>>>> 	(in_softirq() && !irqs_disabled() && !in_hardirq())
>>>> ?  
>>>
>>> Yes, something like that. Messy, but I see no other options...
>>>
>>> So, I guess you want to add an assertion to make sure that we're *not*
>>> in this:
>>>
>>> in_hardirq() || irqs_disabled()
>>>
>>> Does this mean that after it's added, my patch is sane? :p
>>
>> Well... it's acceptable. Make sure you add a good, informative
>> but concise comment :)
>>
> 
> Does it mean ptr_ring_produce_any() is needed in
> page_pool_recycle_in_ring() too?
> 
> As it is assumed that page pool API can be called in the context with
> irqs_disabled() || in_hardirq(), and force recylcling happens in the
> prt_ring.
> 
> Isn't it conflit with the below patch? as the below patch assume page
> pool API can not be called in the context with irqs_disabled() || in_hardirq():
> [PATCH net-next] page_pool: add a lockdep check for recycling in hardirq
> 
> Or am I missing something obvious here?

No, Page Pool is *not* intended to be called when IRQs are disabled,
hence the fix Jakub's posted in the separate thread.

Thanks,
Olek
