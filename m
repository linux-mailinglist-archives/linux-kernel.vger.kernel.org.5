Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE8C7558B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGQAAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGQAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:00:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E598D7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 17:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689552003; x=1721088003;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SSgoy19KPWkq8KXIpxXHxO1i5E3tuUQVOW82wEmMCxI=;
  b=dlt78gQ/Y4bYS1rvHu9PFvAr9s0Usdx6cKXWXgWvGdSd/NboAo1NdEwf
   IeH/JgfxfTbkGQF7+SErtamuUNpFhit6ubfqsIKxUBjdvuQ4HorqF5KJn
   WK5GUGN/I9GXg+0CY7ylVFPdEYzUVf7WF7TOAprlGZUqBsdLgYWcZ2xy7
   /pz/vdRQfqqFw9kK2rgfQGvyJXsj3FCiAjh0zPj/JNQZCyUZrO3Qq2boV
   IIvqpYnabbSm5ZWgNioPqL22fQMq/EbBQdqZ9o7bFkSlhkXuYN0c+AkyX
   7Yn+pX45cVC4OpSWPw/HKc+TOAxrtaQ3YK2bLhXtu27P6mQfGzpTJVzhJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="365853845"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="365853845"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 17:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="897009527"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="897009527"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 16 Jul 2023 17:00:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 17:00:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 17:00:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 16 Jul 2023 17:00:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 16 Jul 2023 17:00:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTkJQXKu96apimwHORBXJ9KrCo2rBEiVxfGdWohnEzYcyUa9IOclzH5lHkw3n5K4ifg4cVhsfSsNH9jaXDm6pj/ja1HPy72vHH489UwtQc/9ZhGtlfogEzK6CSb+mbUEsUzq/Ay+TAoJrGvOTlf5q10uqMtctEhw9xiJCl+Iagn56HALbtqnHLZJ9RcxNbdCdshQT1Jhh+eJUQDqVxtTSQ7ufrUAguQNi6BO/cCr1jOWPFE6Bz50qgGmgn2LV6ev86GU4DV+ec+Bl5ilHwHR88RPAOhaWMTEwfmYWzDMUfnyC6UyVCYlc+sakf6vVb7jvaoGy1o9PNkhGJXWtC21MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpYoD93e8VNgbia/Pzn8Ji6jfOd35naLg/pgwx+eD2o=;
 b=RHp8R7Yoo/dxkO9NUoPBdtVKxssQiFfJYmfVPdKwTCItbtm3o0s+QqTWqSqOQ+6iLZ/z2YPTIaR2UN73AMB1FoGK+CYzUBrcAMeF69OsZXp0hQFHqxDEsTyiusbOY9c5TUpCuu7WTMLnHU4dCDE4b2YBhUBwXOm7yeTT38rrQqzy5meGSESX79Q9WL8DF6UOqdFvzfgiEU2+jBP+RKT6PAcrx6rWP5o586H7rd+fDB9ubUuFuwQRYp4FdVfkFJXks50hh+pWHwFo1kD0JhRHhp6WARpv5CNH4+/bJa63ovSRVBhbyPnAmmm14lhCpt87DhaKS0NM9dAzljyhYhXyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW4PR11MB7104.namprd11.prod.outlook.com (2603:10b6:303:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 23:59:59 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 23:59:59 +0000
Message-ID: <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com>
Date:   Mon, 17 Jul 2023 07:59:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com>
 <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW4PR11MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c89f81-32eb-4117-bdae-08db8658c33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaVVSP6TFhKbJ/oMctprIxj3i+AHEwchhUBjVbqet9WmwRRLiP0hiBw6XfRT39qedFyB4Anm811Zx3Yy4r9L1bx8YOfYYsJUJybOiyF9l+y0yivof7589vtxnG7OdukWTIML1/UIDIU9vSWHVGg6VOLfak7qaBNWiCUGfoE8BYUpn/lBeuMsKj3bX/Qt38otJt/YpxtePvN5B+hy6qjlX17GsjODOb0/ARAsCZkcsuSvLcQYbSrUm8+ydqUHF9Wl/+cC8bkpIFCOl0DETCDf++mYlbw8Rgsto1mlzl4Vp37NUpEBMFnWvJmnSUnecRHQ+D6zPpaOYuLPGLEsTwIYdZVanAr28JpsshNfGswJ6krIKHpjk5Z2jvh4KsMTHN7RssZ/E0Xyvl7qXlvIcPzlYNqEK46ZKrST9ki4u6R3UVtJyIWj8A7kI5/1JvRn3BmSM2AWMB22XVHbizZAqaV6cD9iZa2ln3RBe/dO0vZ3Wm3V4Ij/CdBvSwjbUGURArH7sx/DO8xNWsk2wpj2GqE4AAnixV8xYUsbrDnfUjzSEnIWCFLIYPWygdnsCTuwc96srTTbMb8V6XmkQxpyPxRnUcHhFNtPZgZcpSBiP1NeOGUcxYs996vrZkjeWobiORwGEzV1hS/81vjI65D37yNIgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(478600001)(6486002)(6666004)(186003)(53546011)(6506007)(36756003)(26005)(6512007)(2906002)(316002)(41300700001)(6916009)(4326008)(66946007)(66476007)(5660300002)(8936002)(8676002)(66556008)(38100700002)(82960400001)(86362001)(31696002)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0x2bURBZWdoSkZ0MDVaRW5jN2FMaXAxeThqc3ByZjhrengwZENJZ25haFkr?=
 =?utf-8?B?KzZUcEVSL1FTb1prUWxUVHlRZnZPVjRWU3c1U3EybDFWZG5tcmJzZWpaTGZS?=
 =?utf-8?B?bGZ2a0FuMGJuQ1lNUDJJTlcySGtSN3prVG55TmxsVEs1emtsRVdNdURWZ2F5?=
 =?utf-8?B?RlYxYndVQXJJRDE2anVoWkV3aEFkVVVDcDdxcjl2VmNQVTJqZVFKeHFzQzNk?=
 =?utf-8?B?enlrWk1odW9oMkVkZ1NYTmxUVG1zMk5IaE9FaUZTY2cvT2ovV3Vuc3hhZkt3?=
 =?utf-8?B?NWZ0V3hUemRiQS92UDJmRnVnVjhxR2pFOTdHS3JnMXVDUGRsemZRTE4zc3Ra?=
 =?utf-8?B?UWZDNnNtM09HUkExdGU5YkVQdGJiWWdIcG5Ed3ExSXd5Si9nNi9qaUpHNDRk?=
 =?utf-8?B?dlo5SHFBUDJLeklnc09xdC9DajZkS0taZ3NkbUFpVjN5b2VualBVY2Zhd1Zq?=
 =?utf-8?B?Qjh3NHhQR1h2MlpKb254YVFONWUrSUpGM1F0akF1SFJzYTYxdkh4NjlHWnYz?=
 =?utf-8?B?NEhxKzNkeGdUYXl0RDVobG5YMDNhVE9PRnNpL2NJYWZnNzdKcmFIYUZ3TXo1?=
 =?utf-8?B?QVR4Q0V2ak1MMHJLajBQSzBFVkRsNVBIa0dlRmV5d1VLWGdrU0x0aTlDcmNM?=
 =?utf-8?B?QVdXcFhCWmFGbXlBak1iL1plUUFySjlaSlJpVytmMWFzODdVUEg1U2tzczBi?=
 =?utf-8?B?MVhzYXQ3RDhmRnFyRlRmRTVrQWo4OFlyRzNpVzM4c21DRG56c3FKT1puTDZY?=
 =?utf-8?B?L0RsR3BzMEt5cExEUnE1N1c1cHh0OHVoMHVKSWVnK3pMai9Td1p5Mlg4cXlQ?=
 =?utf-8?B?bDJvWFJLbjFmQnNBZ05uY0I3blQrT3NVOFA5UE4xb1p5cnpRa05LZmVrYld3?=
 =?utf-8?B?NndSc05qbzZlUzAzNHpyU1FxSC9QeVZqNC9ZMmlqc2pNZDIwdkFFZHZrQVp2?=
 =?utf-8?B?aFNheW1XMzI4RGZjWUc4UDQvN05HTHBkWDZOWlhIYlgrNWpnVnNEeTdwc284?=
 =?utf-8?B?NTRKeEtvZGZOZktjMlp1VWVYRktodkVLMmZJZXQvZGRoQzdnQlI4OHZOd0ZS?=
 =?utf-8?B?QnV1M3RhS09lNnlRbjYwQkk1QU1xYVR3RVl3K3BRU3lvdXhZOWZXNU5VQXl3?=
 =?utf-8?B?UVMzTHRxZEdRcDNvQjhLVmZlaWdqa3NYSjAwM2lTWlJpT1FEdWJudHFodEJZ?=
 =?utf-8?B?VWtuM2VsVjZUdkJ3bk1zdm5NUHJtS0N4cXVKVlN6YkFVUkZwSkhxUzhTMm0v?=
 =?utf-8?B?b1VPZ2E2d3ZKUmkrVEl1SU00WXl2cG9hL1hMMnVUck1BbTlWVFRBUERYZFd3?=
 =?utf-8?B?Q2p1bGNjUHJDd0gzcmpHdk52STNoUUpnSWk2Y3JaMUlMaTlxQ1dYQzFEK1dl?=
 =?utf-8?B?Q0JPR0RGZTJzL1lnYWhoZUNHZ1A4YXhHaEhtWjIvVXBqa1pIdXVUU3hiYld5?=
 =?utf-8?B?Y0c4bXFuVDVjL1Y4bXNCeWpzSFpYU3dJNDJNQ3MyRU1GZnVseVBlLy9HcWsr?=
 =?utf-8?B?am0xekF1dCtBZ0JMNytKSC8zZWFuNkVOd1VteWVQR2VhRTgwazJqMVBseVRT?=
 =?utf-8?B?Y085YVlWenkzeTJ4QnhjVEgwS2loRWNTTi9MbEpPbVFkak81dE1HenZWWk9h?=
 =?utf-8?B?Y1puY0NaYmZZQWE4TExiZml5OVNzQ2hLdU5CWUVmcG93cDRIeDlyUkVnVGgx?=
 =?utf-8?B?Q3d0NHFyY0sxYURBZ2t5R1RUQkd1bkVsK1U3ekJoQjhyellpLzNvY1ExMVlV?=
 =?utf-8?B?d3VsVHpPK0JJcmwyNmF2c3EySHZ1NUhTYjc4TFdzZ09oa3ZESk9jNFB5V2dY?=
 =?utf-8?B?dFRQZFVKZFIxY0QwSjRUYWVLeHFDNkJQWkdlbDIxSGxaeFVQN2NsaE41OGJv?=
 =?utf-8?B?djlWYTgzV3ZvTEsrOFM1UkZ2V1JkZUdPdnhrNkJta01NaDNhekFUU2FHeHNG?=
 =?utf-8?B?ZlY0cm9IbG1FM2FFZWplZWR4VU90VUQ5TjJkL09qSER1NktuUkRsbU5iQXVx?=
 =?utf-8?B?c1Z5blh4QitiWThKTnFiMjlveWZzRXd5RndjYnVtQ3FsYm9GbnN1OXJpM0Uw?=
 =?utf-8?B?RGNVaU53MzlSZGZnUlgzT0UxRVNzeWxoZU5UVU1oYlJPSDNNY3lXVExhZUIr?=
 =?utf-8?B?ZjI1WkRFdXNUU3lCVGlHV3FxbnFyczlXOHB1TmFwN28wYXRZS21CR241VEhO?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c89f81-32eb-4117-bdae-08db8658c33d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 23:59:59.6346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVZpOaMgPAy6JXihEaFB8rchEgj3+JVgzzgyCs+waawQktW6CJpqHJYe/woU7kJU6mKydXTj78rkjIa3H2pQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/2023 2:06 PM, Yu Zhao wrote:
> There is a problem here that I didn't have the time to elaborate: we
> can't mlock() a folio that is within the range but not fully mapped
> because this folio can be on the deferred split queue. When the split
> happens, those unmapped folios (not mapped by this vma but are mapped
> into other vmas) will be stranded on the unevictable lru.
This should be fine unless I missed something. During large folio split,
the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio will be
munlocked in unmap_folio(). So the head/tail pages will be evictable always.

> 
> For that matter, we can't mlock any large folios that are being
> shared, unless you want to overengineer it by checking whether all
> sharing vmas are also mlocked -- mlock is cleared during fork. So the
> condition for mlocking large anon folios is 1) within range 2) fully
> mapped 3) not shared (mapcount is 1). The final patch should look like
> something like this:
> 
> -  if (folio_test_large(folio))
> +  if (folio_pfn(folio) != pte_pfn(ptent))
> +    continue;
> +  if (!the_aforementioned_condition())
> 
> There is another corner case I forgot to mention: for example, what if
> a folio spans two (the only two) adjacent mlocked vmas? No need to
> worry about this since it's not worth optimizing.
Yes. The behavior will be related with whether the folio is mlocked or not.
But the worst case is the folio is split and each page is mlocked during
next scan again.


Regards
Yin, Fengwei
