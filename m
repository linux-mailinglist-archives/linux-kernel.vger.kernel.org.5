Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0698D757E31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjGRNwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjGRNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:52:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88113C7;
        Tue, 18 Jul 2023 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689688330; x=1721224330;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GETKLMqAWkPybSuFJ2DzARDVOeOzqofyc132MEY5YSQ=;
  b=X/XFJifQx3I049nWQ7AUMYa/KWCCY07GHcU3bxypS2PcqzF0dXtKG4ox
   /8F2xcZoBbyUv/+ywpCgqvWBBmu8dXbMHwvnqk3lDo2GmjeukTFB8+mU1
   IIY9L4+cRojg8G/Vlo1Cz8yVS+naxIBQrbRVlalhSVjwXnLhYF+TvOyFj
   rN6ZXc0R4gr7DENbySchTk4qDdhVY+0ZhOwJd6u1tHfv4w9GlVuA0sZfJ
   1/DA6XFaAMuTJT0FqQUCckN9YKH+SHZuW/c3l1wFTlLejSNGcIZXHn+4y
   fO4npTZ4umXpYQO5JuZ/F1Bc/6Iop1Yf8G2blUbCaqc53hiTXSwKLX+XK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="452589567"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="452589567"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="970249242"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="970249242"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2023 06:51:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 06:51:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 06:51:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 06:51:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 06:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fThylvbL8AnHHNNq1nviCNIR63F54UjJ2/oN0flb78zzti7EzymLcqd3ApgmnZfb5CKzAS55lJW8qQr4WINb0nCCsCtOHmhkeOTsB0Bx9twOod1UtPygWWmmvvcTsrEQVKzQGABLQ9xr6NKb3hFtCjbvDoNN6GLqRulx/BOQ//Tv0PhwzOlDu8iJzzIbiq3zSlRhJyVyjDbGxuGqUmwwF+hyNf850KxFwUc378GSo1yapaENr5VuhKiAAHVgSjlSeCACkzvTf5JYFFUzdxEIcUVHCcVFJzr6Wf9MZ29J8a7QCrkx02wY9nCxZnA9U+GHkuRQX2QhFBXcOOYrHrCOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANOAwAwFFFNNtUzcpDpakeLKQAAQX1tkeEW9q5OY02k=;
 b=Wn6g2+y+ugiy7+pyj9ZwDv+MZoHW2+/XDRL30cSetO0ZH8r4rre4kXJ7yr2XWIubR0K39SPB5vXzWvPwpsFmyo26JSAhT6NIZnb3U4Tmtf2dEHyp4CgK7rNxEecwf0yTyEU9GFq529W3TCFm84ZR6TDUIxYVV+jp7xdyawR97L19mQtrb9xci5nkqqgFyybexXGeCOFmsRU8exNfKSTgpM6IAycKdoiacFG6Xa86AD7BFz3VOAYidoBNyQyk1XhTTJoAQaeGGdws+ia5/40BdQtRVG1GPdWJZq9Yt9UxcpOC8WHnmqHl91kX9wf0MpHiP3K+uwJP6BO87Ms8C+jtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB5551.namprd11.prod.outlook.com (2603:10b6:5:392::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 13:51:49 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 13:51:49 +0000
Message-ID: <e48185cb-3057-e778-75c4-d266a249088b@intel.com>
Date:   Tue, 18 Jul 2023 15:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v2 2/7] net: page_pool: place frag_* fields
 in one cacheline
Content-Language: en-US
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <brouer@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-3-aleksander.lobakin@intel.com>
 <ac97825d-6a27-f121-4cee-9d2ee0934ce6@redhat.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ac97825d-6a27-f121-4cee-9d2ee0934ce6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a6e1bf-865d-4551-c9ad-08db8796225f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfXQmt1vI8mSEKAN35dQKp7Qy5U+ZvxQb1rQW95GyqEYh/eIIPOCaxHppcAwZirx4R25OgVcOMF+dL3ClNMoTN7lwGrQb5SLbpBbQy683nYXPTIJFw65lLJ/mCHTumIiNUibiBwVZ9P9MBcAyzBRjjSK9dau89Ky1A/Rj9pKQ9/uTQShAmapA0UljZIutlfTat2lHmeE2atv/o1wedTL5dM9PN2lk/8xvj12ImUIwmL2kd18JfBY/ztYXvN0Uu2p/ybDPTtAGkWeVeUt7it1pk/r8WOXqtHDEdUjKD7skpCCQPo+j2vjFvLMtO4HSZf8Uo1L4585ahEIT6AbKcHFJE///VObAO3vbPoLzcUytEEr8xByC86IjQHh+fn8HaCxiv1pJrDzTCqL0JnErtdyftavfGqgP7hrQi3BwoKlJx+rY1J3WhREHBuvTHU0m9a6ayKN8dNH/++TGbf16yemo7EfVQVgyOmjJRI5mMxK+GF5gcvs52bkb+Lyqpu0el4yMh4vpT3FJrnT71IKhYB2Ziswl/x2y+RuyjZgEfsNgPe6o3gYX26pGf9fymgP/h/zJIM3OPv+3hzLOyvXxdsJzDxcNg04sXWMjWMKfRG75bDztGDDepbRALfwvNPzITxARY5eCY0ajhgKjoYgBKKP/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(2906002)(41300700001)(316002)(7416002)(5660300002)(8936002)(8676002)(86362001)(31696002)(36756003)(6512007)(6506007)(26005)(478600001)(6666004)(6486002)(83380400001)(186003)(2616005)(31686004)(82960400001)(38100700002)(6916009)(4326008)(66476007)(66556008)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0hST2tWV0tteHdNSW5tTTJndC9QYXlSWEtXb3JERkZOcGxTdHhEUUdteTZj?=
 =?utf-8?B?RENVcjZNeFNOQVBmRGZZOXM1SnVtdkZNbEdqU3J0N0NaNitHWldkbHZhR3BN?=
 =?utf-8?B?cDJEdVZVNWt6NGF3Vmpqc0YwK2pPdG1iK1dTaC9IVzNLa2NBNEtTM09jT1VG?=
 =?utf-8?B?cjFZMXRTUHdPYVlvSTlLTWJwV1RmeVBvZ2Z6MTk0RHQ0L21HQUZIZ2hqZGY0?=
 =?utf-8?B?RkRlRWtUeHpscHJQL1lFKzBpZGpveW5CN0NjcFR6TXJtV052eFhKTjRWSWxH?=
 =?utf-8?B?VDFwOWVxNDIwSVpwRzRBNHFBN2dRRU5LQ0x5WEtqMXhqVjVqdld0V2oyRlFa?=
 =?utf-8?B?bDBBVHY2djJmN2tveTFQQVZaSlRHMHFxOXBUTUtxWFBXdlBRMkppUE90ZmI2?=
 =?utf-8?B?R3lEQVI4UTJnVk9JSU5qeVY4a00wMkR5TzZBTG1ncEdNVE4wMEVZWWlxTXZk?=
 =?utf-8?B?cC85TUx4WExKeloybzdmMHg0dnNHVno0NkxLK0RkekJvMEZONGtNdHJtVUM2?=
 =?utf-8?B?M3ZTMm9GTzVzOTYwU2lQRWh5ZithNlJxdzVPM2RmRHpHWFBHS3lXR1JGblpp?=
 =?utf-8?B?NWlpbk1ZVUZsS29lZlNWZGpwY1J6RFgzRkVRMTNBckVsQ1FxekVHR3lxRUw4?=
 =?utf-8?B?d0VUcE53c3crRWVNVmNXRittOWlleXNyK1FwNlJQNGJEbUp0QkY4amFxZDgv?=
 =?utf-8?B?M0xuWWR1REFXdXBrNFgxcVFwRkV1U0JZQ295aUpvYmJGS1JmYjJBNHBwMHkv?=
 =?utf-8?B?L0FUQWpJL1NOcHlqMks5NC9Ua3VWYXU2dFloRHlieUE1Y0tYTzFBbzB4MEha?=
 =?utf-8?B?ckJ1UU5sZWdYdWdJV3A5ZktlVEZrUnNjWExLR0pmWk9kTWNvK2ltcExSemhx?=
 =?utf-8?B?Y2NZdFEwQWk1TU44ckdRYXpqelB6RVI5RS9KZjhGUHRzTm9WYU9OdFR6cHk1?=
 =?utf-8?B?T3FQaUNKRGlFNHRxUVdmVk53T1YxQmxUemtVZy9WaDhtZ09laDNIRGt4d3RD?=
 =?utf-8?B?dm9aa3QwVHE0UHBvb1hFdVdwY0tTYWsvYzVyNUpPUGR3WWt1U28rRjc4U1ZL?=
 =?utf-8?B?WG1UUnkyQTZYYmwrM0Zpa2x4ek02d1N1NmhRdDM2Q3N2aHQ5MEdQUFJGUTlP?=
 =?utf-8?B?N2pSOWg2UWN4VFFNNm5HM3BGTmkrWUM5cjFOcWlyb01mdHNKc3gyb2gzcWdE?=
 =?utf-8?B?RXY5TVZETmp0OUtMOWNUOVljMmNTK1VBeEtEbW1hZmdycE5pQnNONnAwZ2JG?=
 =?utf-8?B?c2FLZGQ4cVlDc3B4RXY4ZzFWZ3AvaS96eVFSblhvVlZlMGMxMUttQU1pTHYz?=
 =?utf-8?B?czFrL1hSNjR3N3BaL3VFRzdLTHdWbmxWd0RIRjR3NzJGV042NkNyRmVnRnAy?=
 =?utf-8?B?WUMzM29DUmpnN2NRVUo3T0JFQUtXQktoSTk4SmZlMmU3bVRjYWNBTEdGVHFh?=
 =?utf-8?B?WmM2UGhCdERxYjRwRXVhSU1RU01RejdScGg2UmNOWFlWemtpN25xUkx3ZGxi?=
 =?utf-8?B?S0w2b0Z3ZW9VMHhqOXF6T25DWnczWDRCNDViaDNVMENsb2pmSzZIRUY4blUv?=
 =?utf-8?B?dit1QWJDVmtCTDBiQWhROXRjSW5YMUUxdFBIK1crSFNUaS9wWENqK0JCSk9Z?=
 =?utf-8?B?UHZvTWsveURHN0NJaWZuY1d1T0gzMmhYTy9jZXk2Z1VEMHdOczY4TWJUYTIw?=
 =?utf-8?B?cEZkSWhhcFZXRnU3bCtQWUVlQVgxZjdFSk5ZMTVqQzZ1amV3czFHL2J2c0hs?=
 =?utf-8?B?TTIvQk15eWQ4UXU3b2pTR3cycFNFU3ZjVUJySXBFQzhubnZZLzNnOGd1Snkv?=
 =?utf-8?B?L0xHT245TUZqQmQ5bm9GK2pIYWJ2bXg5dTBFamxiZWdLUkpnU2FTTnFPNTZV?=
 =?utf-8?B?eVVyVlZVZm5GemZmZ1p5eDBrcEVIcE44U0RrbjFObStiK3NqbmE4SmdpZ1hq?=
 =?utf-8?B?MmVGcjBBaEdPM2J2WjVxUnIvbGZNU25JazBHRFQzMWNMcktRY3JLdEk0NGNK?=
 =?utf-8?B?U0x3RTU2SFdOOGNhNjlIU0dVblFJWTAzdU9tNkNBVnR4TDZyazgycG5xR3NR?=
 =?utf-8?B?QmdINGEyVitzOThNU3N0VC9ydkxxaDRnTmZ0ZHpzc0RET2Z5S29GTm5pUmpY?=
 =?utf-8?B?ZmdYby9QMmFLNTlXLzZHYU1kZkxRTjl0c1lVcmt4cmQxbXlGdFgzaGhDOHAy?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a6e1bf-865d-4551-c9ad-08db8796225f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 13:51:49.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kR/SoL4DEW3isnsVhAcSWK2HbW+BjAjgfnf7ANa1dPK1ByjvEUiQYec3q/7FWary4BRKsZxnpC4oI1g7Os6RuYw7YU6IxvXcRijoHfcvFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5551
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Fri, 14 Jul 2023 20:37:39 +0200

> 
> 
> On 14/07/2023 19.08, Alexander Lobakin wrote:
>> On x86_64, frag_* fields of struct page_pool are scattered across two
>> cachelines despite the summary size of 24 bytes. The last field,
>> ::frag_users, is pushed out to the next one, sharing it with
>> ::alloc_stats.
>> All three fields are used in pretty much the same places. There are some
>> holes and cold members to move around. Move frag_* one block up, placing
>> them right after &page_pool_params perfectly at the beginning of CL2.
>> This doesn't do any meaningful to the second block, as those are some
>> destroy-path cold structures, and doesn't do anything to ::alloc_stats,
>> which still starts at 200-byte offset, 8 bytes after CL3 (still fitting
>> into 1 cacheline).
>> On my setup, this yields 1-2% of Mpps when using PP frags actively.
>> When it comes to 32-bit architectures with 32-byte CL: &page_pool_params
>> plus ::pad is 44 bytes, the block taken care of is 16 bytes within one
>> CL, so there should be at least no regressions from the actual change.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>   include/net/page_pool.h | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
>> index 829dc1f8ba6b..212d72b5cfec 100644
>> --- a/include/net/page_pool.h
>> +++ b/include/net/page_pool.h
>> @@ -130,16 +130,16 @@ static inline u64
>> *page_pool_ethtool_stats_get(u64 *data, void *stats)
>>   struct page_pool {
>>       struct page_pool_params p;
>>   +    long frag_users;
>> +    struct page *frag_page;
>> +    unsigned int frag_offset;
>> +    u32 pages_state_hold_cnt;
> 
> I think this is okay, but I want to highlight that:
>  - pages_state_hold_cnt and pages_state_release_cnt
> need to be kept on separate cache-lines.

They're pretty far away from each other. I moved hold_cnt here as well
to keep it stacked with frag_offset and avoid introducing 32-bit holes.

> 
> 
>> +
>>       struct delayed_work release_dw;
>>       void (*disconnect)(void *);
>>       unsigned long defer_start;
>>       unsigned long defer_warn;
>>   -    u32 pages_state_hold_cnt;
>> -    unsigned int frag_offset;
>> -    struct page *frag_page;
>> -    long frag_users;
>> -
>>   #ifdef CONFIG_PAGE_POOL_STATS
>>       /* these stats are incremented while in softirq context */
>>       struct page_pool_alloc_stats alloc_stats;
> 

Thanks,
Olek
