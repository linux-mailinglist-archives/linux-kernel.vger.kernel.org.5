Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F11B76E2AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjHCIPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjHCIPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:15:00 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B825572AE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691050020; x=1722586020;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RH1AQLW57ZzAav3mZpVB1cHNSskmdZhtrwv/wnadSpI=;
  b=MqNSuVGqFS8riovB33v1EsSAX+yEyQ+bXdp4jUIvlsl09ndxQ+4nuRZz
   oWu9fC3k6p4IB4YOBaCvl1XOJ18qjg9mUz6DYMu2ioHh3yLFiZ5hxLFcd
   88+QuoHcDaOjKymERJOqvSTEWXbr5Yx+fltDidFUrD0tbSTorsC6Yi5Ch
   3xU43vK4Lz7rcvUdaLEPlBh0qMNwwoD3TTM1pAAHQ+ffbkKaLbtJTGFpg
   /7R5CSktFz41q3T9IQc+1fSkn67laxyG8dqMAflIf+G8V+KSDqByczZqL
   s0NwBc1+Kq6ass67AnZxLz0dD9hAxNA789tBqtKBgvJENh1RLKbV5sp3b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="456179604"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="456179604"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 01:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729480503"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="729480503"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 03 Aug 2023 01:06:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 01:06:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 01:06:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 01:06:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTIkwoJiw7231Rtv2hcue2dAVu7nvp+TE/ua5/0+OX2EsC6AvUGVT3fM4hMs0ELY2MqLa46AhR9CT/PKcwBk75pA+KLtqTkYKU1rjVDI31MzTuVujph2F1Xp56dfx596ooIaskmd+tosSxdUxoqELVTlu7jfroEdT5cYXcS620NkLrlMP5ITgvHJxHGUXZK/NJKPlbBVNxvkCorxqHV6HzTwUtArzkoBfb6KvJbrvRwhFRQnkdVao/0TrHeEuAlFr45M/aFzwR6wKr3MHC0iR7E8mQo5GmTO+7QIOCwQ0LPlOFid/WqKMeZhP83QoieheSxH/hP8PzmgMQBB1shDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtPKtdeMqUsMh9lKgnhley37K7xqiaixM+Le/2cUbbg=;
 b=Y9pXfCBzkNJsO+TAORFBdFH3xtkg0kGNYySFn9N/k0Y+JRWlEvB5IF9HDydsaWVkXe0na7T7OdbWbAcQnSo6Vi7cg7Cu5f+1zmLeH5rCOfCj4l2MfQaBXUAm49e2a/olSTNxR9cdaBoDTT3UMCjBGKzTrTucXWSu9INfEJ6YrgExhrZyT1vifQHMKXTxrFehnF6UWr7JahmXSGdkE98ffaObon8jSSlzhb2AvjeD5TByyclJoXMEYtzBRBzG5/svVHWVW7+6kwzQxLlNPYbMbbXQXh0UHCrmmQsVlQYBfCPLJlsUlUwdxrdTIxYo/6fVJEKv1yhJ8kTNDG0yl3+ClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB6876.namprd11.prod.outlook.com (2603:10b6:806:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 08:06:51 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 08:06:51 +0000
Message-ID: <4ae53b2a-e069-f579-428d-ac6f744cd19a@intel.com>
Date:   Thu, 3 Aug 2023 16:05:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
 <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
 <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 42706d8f-729b-4926-6511-08db93f897c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZ2ynUcW+xFTOVdJyHRLOOE6IlJbPTifMfvOltb6WEVNl4zRfAhIDkG00KDbsLMMGUUWyvHIjnqXX1w/gb1cPMTXetipAofrub3qSfrNFy47D9yi8cIQWewC2hTQCm+Pevg4bCrpA4lP4rvAge5eryFGPUcYZ/2rrACMiq6gykW+cSYPSYHXdrbwvmdKAhJu9Jp6R33BnPqI9ssweDYdIpW8zBf+Idb1EQ7gappQs1aRrTQne9K4fiK2qXAs3tzLUE0kB74kWsyawk5bMoB7NrsjQ5phWTEz5xq6XBYQVh9kLsGgvaLKTnLJdJGu1IhSIfaSFqZTTWhKbWHg5w138qatbVwhRH3jvrZkV3GTFxJ05t6KhhGXTLqYG7m4XJ2Eb1EBaa2ssvI05nHqda471MGw8aWXg8bkrKAopBcAmSs+PfLA9D3xwz6C9leTZ24m0HfF8bDY89eMcMPWLwb9ygUcH9IgV16Q0B+jth18D2xpez8iiX/hCpxwWCI2ULiTkZRnz3UbdLF/Z5hEAfehFzNaHiLeOdPfkaMR0NZM6TF0eiLtgfxc9PEA8NfhN2KJtfzCBuYgk7p5rwMzylf1S4i3Aa/uE9omp/PcF41x/0e+j4xku6hJVgIOMCvzYtIc4zjvnC0Xf8zdrNok2BV70FjPJB97YjTAg+I7tf+w6xcigbJ3loSgXRTEWPHk9gBy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(66476007)(66946007)(86362001)(66556008)(2906002)(6666004)(6486002)(31696002)(6512007)(966005)(31686004)(4326008)(110136005)(54906003)(36756003)(478600001)(83380400001)(41300700001)(82960400001)(38100700002)(2616005)(7416002)(5660300002)(8676002)(53546011)(6506007)(26005)(8936002)(186003)(316002)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzRWTzVMNnh3QlpYRU54Vm02djdzQUNBVHpXZnVmWUVaTUVsVEt4T1hTeGY3?=
 =?utf-8?B?Sk9QZXk1RVB2SmhIOUpXTW1uNG1yQnZtK1M1NjFoNGxqbStlaDJFVTE1R0xh?=
 =?utf-8?B?SXdXSW9mMXNqd2pZc2tTUnl3QnJVVGpRNWpVMFNsRUYzUXZlZEV0Y1NLaWU2?=
 =?utf-8?B?dEVwRTZTaXc5L2JxS25XTmdsek0ybm5sNlB0Q0JVZytUbUY5ME0ydng5UFdq?=
 =?utf-8?B?VzBHRHZGYkJlMWtmMk9oVjFmY3JoUjYxZkxXbHUvY0dNVDVjQVJnZDVQYzh5?=
 =?utf-8?B?VjdqbTVVeFU4dXNYcDQ0SWZxNUNFb044Z2tQTkJQcmhrQU1ETUEzZFN3b0pP?=
 =?utf-8?B?WEVFaHZsM1VtKzBZVldpZy8rQVdLMXJCMUxFRVZ3Z2c3aHpmT1AwRWRScmhI?=
 =?utf-8?B?U2tyTFQ0NllVdFRMRmIvejNPeFdwWlA5TkJQOG1LZGR2SURrRlJqcWo0VnlY?=
 =?utf-8?B?bmhLcUNNUnpJTnNxcEJvc2RXNC8yMy9BVXM0WERTMG5PbHRxb2ZkNEQ0c05M?=
 =?utf-8?B?a2FjcTRMTFlJSC9EdEV1L2pBMjBFOUJTZEQ2OGFEMm1tZVlDNW9WbWpaMm80?=
 =?utf-8?B?QjM0ZmV6UW53VVhrbWlQaERWeVprSjgyUktER0QyRWMvdjJkejgrV241OEQy?=
 =?utf-8?B?TWlEbHlUdU5acGFXUHowK0xrRWNzcEJMQjZoTjV5Ym9JQ0toVGVteC8rZ09x?=
 =?utf-8?B?dm9qQkZFSStLQVo0YndUTDM5dXR2NmZHZlIwdWR5ZHU4aDdWOVlqL2k0elZF?=
 =?utf-8?B?c1VONSt2RmFZTE9WL29XRXZlTWRBeDVDWkUyWTVGczczSk5jaW1Nb2tGcjVX?=
 =?utf-8?B?VjA5cytUb2hDZ08xRGJiUzJLcWptYXBZUTdtZ1RnbEx6OEpKOEM2eHNiSSts?=
 =?utf-8?B?dHNwUlBrOEtLTWtZMGltbDZiMGlwUVNxSndMVk9VR203bmJ2ckRKdVFoNCtQ?=
 =?utf-8?B?eDAreFRaQVR4TE5QYVpweUh3ZEdSY3Y4YnRaVGwyalhPNkdiMkVrODc2dDNl?=
 =?utf-8?B?NFpNQS9tdjRMR1c3bFcyVC9ldkdCYW5uKzR3aUZsRG9xUTBPUmRiQlZXNDVX?=
 =?utf-8?B?UnRWczR6Um14cTMyLytFQ1czdjBzcGtKbm5MR2l0VGdtNGs3cExCNWRoTVcr?=
 =?utf-8?B?WGNycFBWdWJOek9LSytJOEVxWUxmVHJON1J1MmhPMnI1THJRU2RwYmxydi9B?=
 =?utf-8?B?NUZ2TElyMWpqUXM0TSs0SE1KakpFcXpDc0h3ekovb0FtQWp2M0RodVhBeEJ4?=
 =?utf-8?B?RTBiVXNWUVZZNGM3TXZtbTQrRHZlRG13K1BTWFplaEJNZ3JvektsVVNzbWdq?=
 =?utf-8?B?Smd5bis0RHBralJHcWxzQTRNbUpjZDJEeXhIMTN3SFlTVTFETEUrZ0JjaEFJ?=
 =?utf-8?B?OTlHVis0aW9KVUJ5b3RzaVpKVzFmVlpQM2J0cjAvUkNhZDZYNEZzdTlTZkZM?=
 =?utf-8?B?T0I4MFlXZW55SEpibzA3U1RSNmFRUzJTQzEzeDF6RlRmWG5SeW1uZ1ZGWlBJ?=
 =?utf-8?B?eFBXNkM4bW0xbEpRMEluSnBKU2ZtUk96MGdraDNpOFlGLyttU2NRTnVDQnRl?=
 =?utf-8?B?Y2JoMnlIV2tYcmZLSm9WS2F4QUxYYVpxZmFqaVZpWGllMmRZTURDZWN4VGY1?=
 =?utf-8?B?ZlRMUlptZjd3MEJGU05wb01wZnUyY2lGMTVEcEVUQ2xMNG04L3ZoQW8reXlV?=
 =?utf-8?B?a3lkcGNCN1VTRHlQM2I4UWtLV1JXaFRMcldoK3JweGFyTHZSYXBaOEY3WU1Y?=
 =?utf-8?B?aU5RZEZkT1FDUDlUMENvU3FtOHJzYlZENHY4L3d0OE9RZVBxL3lXeGl0Vi9W?=
 =?utf-8?B?ZXlzcEFUejVnTlJEOUZ1OUlXL1VocVdmS2xYYXU0LzljYXVQODJCaWlOTGNw?=
 =?utf-8?B?aExhTTUzLy9vMllyYXN3V2k2T2kxc1orUkx0ZHJ2UkxBdFp0UzIrZ3d0NEhl?=
 =?utf-8?B?b05IRnU0RXJDdThhVTFFb0U4cHZveTVOS2crQkJKRGtlY0pPYjRXUUM0UTI4?=
 =?utf-8?B?WXBXbksxc1ZZSm93dTU2ODNmclFFcjNQRTByZ3J4YVF5dlNxNXlFRlJmNzZk?=
 =?utf-8?B?b291akFFQ3ExMmUvTnRscGd1RUxHOFFua3BrV1JFUmhSTXExRU5pQkcyYVha?=
 =?utf-8?B?dkhPd1BGdFpET203K09hSlE2eG9iRGNxQ1FSU09mSlJoMU5QS2hEakM4TzlI?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42706d8f-729b-4926-6511-08db93f897c1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 08:06:51.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yBClTbKGqCNudic+KHfprSVvyZ8KELP8Lgc6hZRjspSs1/HEbfCJjHmk7sBxvcq+zWi6mDGpFKDgvtnBVH1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6876
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



On 7/28/23 18:13, Ryan Roberts wrote:
> On 27/07/2023 05:31, Yu Zhao wrote:
>> On Wed, Jul 26, 2023 at 10:41 AM Yu Zhao <yuzhao@google.com> wrote:
>>>
>>> On Wed, Jul 26, 2023 at 3:52 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>> allocated in large folios of a determined order. All pages of the large
>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>> counting, rmap management lru list management) are also significantly
>>>> reduced since those ops now become per-folio.
>>>>
>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>> which defaults to disabled for now; The long term aim is for this to
>>>> defaut to enabled, but there are some risks around internal
>>>> fragmentation that need to be better understood first.
>>>>
>>>> When enabled, the folio order is determined as such: For a vma, process
>>>> or system that has explicitly disabled THP, we continue to allocate
>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>> fragmentation so we honour that request.
>>>>
>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>>>> bigger). This allows for a performance boost without requiring any
>>>> explicit opt-in from the workload while limitting internal
>>>> fragmentation.
>>>>
>>>> If the preferred order can't be used (e.g. because the folio would
>>>> breach the bounds of the vma, or because ptes in the region are already
>>>> mapped) then we fall back to a suitable lower order; first
>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>
>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>> mechanism allows the architecture to optimize as required.
>>>>
>>>> Here we add the default implementation of arch_wants_pte_order(), used
>>>> when the architecture does not define it, which returns -1, implying
>>>> that the HW has no preference. In this case, mm will choose it's own
>>>> default order.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  include/linux/pgtable.h |  13 ++++
>>>>  mm/Kconfig              |  10 +++
>>>>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++----
>>>>  3 files changed, 172 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index 5063b482e34f..2a1d83775837 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>>  }
>>>>  #endif
>>>>
>>>> +#ifndef arch_wants_pte_order
>>>> +/*
>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>>> + * and mm will choose it's own default order.
>>>> + */
>>>> +static inline int arch_wants_pte_order(void)
>>>> +{
>>>> +       return -1;
>>>> +}
>>>> +#endif
>>>> +
>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>                                        unsigned long address,
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 09130434e30d..fa61ea160447 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>
>>>>  source "mm/damon/Kconfig"
>>>>
>>>> +config LARGE_ANON_FOLIO
>>>> +       bool "Allocate large folios for anonymous memory"
>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>> +       default n
>>>> +       help
>>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>>> +         faults, as well as other per-page overheads to improve performance for
>>>> +         many workloads.
>>>> +
>>>>  endmenu
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 01f39e8144ef..64c3f242c49a 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>         return ret;
>>>>  }
>>>>
>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>>> +{
>>>> +       int i;
>>>> +
>>>> +       if (nr_pages == 1)
>>>> +               return vmf_pte_changed(vmf);
>>>> +
>>>> +       for (i = 0; i < nr_pages; i++) {
>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>> +                       return true;
>>>> +       }
>>>> +
>>>> +       return false;
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>> +
>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>> +{
>>>> +       int order;
>>>> +
>>>> +       /*
>>>> +        * If THP is explicitly disabled for either the vma, the process or the
>>>> +        * system, then this is very likely intended to limit internal
>>>> +        * fragmentation; in this case, don't attempt to allocate a large
>>>> +        * anonymous folio.
>>>> +        *
>>>> +        * Else, if the vma is eligible for thp, allocate a large folio of the
>>>> +        * size preferred by the arch. Or if the arch requested a very small
>>>> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>>>> +        * which still meets the arch's requirements but means we still take
>>>> +        * advantage of SW optimizations (e.g. fewer page faults).
>>>> +        *
>>>> +        * Finally if thp is enabled but the vma isn't eligible, take the
>>>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>> +        * This ensures workloads that have not explicitly opted-in take benefit
>>>> +        * while capping the potential for internal fragmentation.
>>>> +        */
>>>
>>> What empirical evidence is SZ_64K based on?
>>> What workloads would benefit from it?
>>> How much would they benefit from it?
>>> Would they benefit more or less from different values?
>>> How much internal fragmentation would it cause?
>>> What cost function was used to arrive at the conclusion that its
>>> benefits outweigh its costs?
> 
> Sorry this has taken a little while to reply to; I've been re-running my perf
> tests with the modern patches to recomfirm old data.
> 
> In terms of empirical evidence, I've run the kernel compilation benchmark (yes I
> know its a narrow use case, but I figure some data is better than no data), for
> all values of ANON_FOLIO_MAX_ORDER_UNHINTED {4k, 16k, 32k, 64k, 128k, 256k}.
> 
> I've run each test 15 times across 5 system reboots on Ampere Altra (arm64),
> with the kernel configured for 4K base pages - I could rerun for other base page
> sizes if we want to go further down this route.
> 
> I've captured run time and peak memory usage, and taken the mean. The stdev for
> the peak memory usage is big-ish, but I'm confident this still captures the
> central tendancy well:
> 
> | MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak memory |
> |:-------------------|------------:|------------:|------------:|:------------|
> | 4k                 |        0.0% |        0.0% |        0.0% |        0.0% |
> | 16k                |       -3.6% |      -26.5% |       -0.5% |       -0.1% |
> | 32k                |       -4.8% |      -37.4% |       -0.6% |       -0.1% |
> | 64k                |       -5.7% |      -42.0% |       -0.6% |       -1.1% |
> | 128k               |       -5.6% |      -42.1% |       -0.7% |        1.4% |
> | 256k               |       -4.9% |      -41.9% |       -0.4% |        1.9% |

Here is my test result:

		real		user		sys
hink-4k:	 0%		0%		0%
hink-16K:	-3%		0.1%		-18.3%
hink-32K:	-4%		0.2%		-27.2%
hink-64K:	-4%		0.5%		-31.0%
hink-128K:	-4%		0.9%		-33.7%
hink-256K:	-5%		1%		-34.6%


I used command: 
/usr/bin/time -f "\t%E real,\t%U user,\t%S sys" make -skj96 allmodconfig all
to build kernel and collect the real time/user time/kernel time.
/sys/kernel/mm/transparent_hugepage/enabled is "madvise".
Let me know if you have any question about the test.

I also find one strange behavior with this version. It's related with why
I need to set the /sys/kernel/mm/transparent_hugepage/enabled to "madvise".
If it's "never", the large folio is disabled either.
If it's "always", the THP will be active before large folio. So the system is
in the mixed mode. it's not suitable for this test.

So if it's "never", large folio is disabled. But why "madvise" enables large
folio unconditionly? Suppose it's only enabled for the VMA range which user
madvise large folio (or THP)?

Specific for the hink setting, my understand is that we can't choose it only
by this testing. Other workloads may have different behavior with differnt
hink setting.


Regards
Yin, Fengwei

> 
> 64K looks like the clear sweet spot to me.
> 
> I know you have argued for using a page order in the past, rather than a size in
> bytes. But my argument is that user space is mostly doing mmaps based on sizes
> independent of the base page size (an assumption!) and a system's memory is
> obviously a fixed quantity that doesn't it doesn't change with base page size.
> So it feels more natural to limit internal fragmentation based on an absolute
> size rather than a quantity of pages. Kyril have also suggested using absolute
> sizes in the past [1].
> 
> It's also worth mentioning that the file-backed memory "fault_around" mechanism
> chooses 64K.
> 
> If this approach really looks unacceptable, I have a couple of other ideas. But
> I personally favour the approach that is already in the patch.
> 
> 1) Add a large/small flag to arch_wants_pte_order(). arm64, at least, actually
> has 2 mechanisms, HPA and contpte. Currently arm64 is always returning the
> contpte order, but with a flag, it could return contpte order for large, and HPA
> order for small. (I know we previously passed the vma and we didn't like that,
> and this is pretty similar). I still think the SW (core-mm) needs a way to
> sensibly limit internal fragmentation though, so personally I still think having
> an upper limit in this case is useful.
> 
> 2) More radical: move to a per-vma auto-tuning solution, which looks at the
> fault pattern and maintains an allocation order in the VMA, which is modified
> based on fault pattern. e.g. When we get faults that occur immediately adjacent
> to the allocated range, we increase; when we get faults not connected to
> previously allocated pages we decrease. I think it's an interesting thing to
> look at, but certainly prefer that it's not part of an MVP implementation.
> 
> [1]
> https://lore.kernel.org/linux-mm/20230414140948.7pcaz6niyr2tpa7s@box.shutemov.name/
> 
> 
>>>
>>>> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>> +           !hugepage_flags_enabled())
>>>> +               order = 0;
>>>> +       else {
>>>> +               order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>> +
>>>> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>> +                       order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>> +       }
>>
>> I'm a bit surprised to see the above: why can we overload existing
>> ABIs? I don't think we can. 
> 
> I think this is all covered by the conversation with David against v2; see [2]
> and proceeding replies. Argument is that VM_NOHUGEPAGE (and friends) is really a
> request from user space to optimize for the least memory wastage possible and
> avoid populating ptes that have not been expressly requested.
> 
> [2]
> https://lore.kernel.org/linux-mm/524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com/
> 
> Assuming we could, you would have to
>> update Documentation/admin-guide/mm/transhuge.rst in the same
>> patchset, and the man page for madvise() in a separate patch.
> 
> Yes, that's a fair point. Although transhuge.rst doesn't even mention
> MADV_NOHUGEPAGE today.
> 
>>
>> Most importantly, existing userspace programs that don't work well
>> with THPs won't be able to use (try) large folios either -- this is a
>> big no no.
> 
> I think we need some comments from David here. As mentioned I've added this
> tie-in based on his (strong) recommendation.
> 
>>
>>
>>
>>>> +
>>>> +       return order;
>>>> +}
>>>> +
>>>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
>>>
>>> static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>>
>>> and use ERR_PTR() and its friends.
> 
> Yes, agreed. I'll change this for the next version.
> 
>>>
>>>> +{
>>>> +       int i;
>>>> +       gfp_t gfp;
>>>> +       pte_t *pte;
>>>> +       unsigned long addr;
>>>> +       struct vm_area_struct *vma = vmf->vma;
>>>> +       int prefer = anon_folio_order(vma);
>>>> +       int orders[] = {
>>>> +               prefer,
>>>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_ORDER : 0,
>>>> +               0,
>>>> +       };
>>>> +
>>>> +       *folio = NULL;
>>>> +
>>>> +       if (vmf_orig_pte_uffd_wp(vmf))
>>>> +               goto fallback;
>>>> +
>>>> +       for (i = 0; orders[i]; i++) {
>>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>>>> +               if (addr >= vma->vm_start &&
>>>> +                   addr + (PAGE_SIZE << orders[i]) <= vma->vm_end)
>>>> +                       break;
>>>> +       }
>>>> +
>>>> +       if (!orders[i])
>>>> +               goto fallback;
>>>> +
>>>> +       pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>>> +       if (!pte)
>>>> +               return -EAGAIN;
>>>> +
>>>> +       for (; orders[i]; i++) {
>>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>>>> +               vmf->pte = pte + pte_index(addr);
>>>> +               if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
>>>> +                       break;
>>>> +       }
>>>> +
>>>> +       vmf->pte = NULL;
>>>> +       pte_unmap(pte);
>>>> +
>>>> +       gfp = vma_thp_gfp_mask(vma);
>>>> +
>>>> +       for (; orders[i]; i++) {
>>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>>>> +               *folio = vma_alloc_folio(gfp, orders[i], vma, addr, true);
>>>> +               if (*folio) {
>>>> +                       clear_huge_page(&(*folio)->page, addr, 1 << orders[i]);
>>>> +                       return 0;
>>>> +               }
>>>> +       }
>>>> +
>>>> +fallback:
>>>> +       *folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>>> +       return *folio ? 0 : -ENOMEM;
>>>> +}
>>>> +#else
>>>> +static inline int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
>>>> +{
>>>> +       *folio = vma_alloc_zeroed_movable_folio(vmf->vma, vmf->address);
>>>> +       return *folio ? 0 : -ENOMEM;
>>>> +}
>>>> +#endif
>>>> +
>>>>  /*
>>>>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>>>>   * but allow concurrent faults), and pte mapped but not yet locked.
>>>> @@ -4057,6 +4178,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>   */
>>>>  static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>>  {
>>>> +       int i = 0;
>>>> +       int nr_pages = 1;
>>>> +       unsigned long addr = vmf->address;
>>>>         bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>>>>         struct vm_area_struct *vma = vmf->vma;
>>>>         struct folio *folio;
>>>> @@ -4101,10 +4225,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>>         /* Allocate our own private page. */
>>>>         if (unlikely(anon_vma_prepare(vma)))
>>>>                 goto oom;
>>>> -       folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>>> +       ret = alloc_anon_folio(vmf, &folio);
>>>> +       if (unlikely(ret == -EAGAIN))
>>>> +               return 0;
>>>>         if (!folio)
>>>>                 goto oom;
>>>>
>>>> +       nr_pages = folio_nr_pages(folio);
>>>> +       addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>>>> +
>>>>         if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>>>>                 goto oom_free_page;
>>>>         folio_throttle_swaprate(folio, GFP_KERNEL);
>>>> @@ -4116,17 +4245,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>>          */
>>>>         __folio_mark_uptodate(folio);
>>>>
>>>> -       entry = mk_pte(&folio->page, vma->vm_page_prot);
>>>> -       entry = pte_sw_mkyoung(entry);
>>>> -       if (vma->vm_flags & VM_WRITE)
>>>> -               entry = pte_mkwrite(pte_mkdirty(entry));
>>>> -
>>>> -       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>>> -                       &vmf->ptl);
>>>> +       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
>>>>         if (!vmf->pte)
>>>>                 goto release;
>>>> -       if (vmf_pte_changed(vmf)) {
>>>> -               update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>> +       if (vmf_pte_range_changed(vmf, nr_pages)) {
>>>> +               for (i = 0; i < nr_pages; i++)
>>>> +                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>>>>                 goto release;
>>>>         }
>>>>
>>>> @@ -4141,16 +4265,24 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>>                 return handle_userfault(vmf, VM_UFFD_MISSING);
>>>>         }
>>>>
>>>> -       inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>>> -       folio_add_new_anon_rmap(folio, vma, vmf->address);
>>>> +       folio_ref_add(folio, nr_pages - 1);
>>>> +       add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>>>> +       folio_add_new_anon_rmap(folio, vma, addr);
>>>>         folio_add_lru_vma(folio, vma);
>>>> +
>>>> +       for (i = 0; i < nr_pages; i++) {
>>>> +               entry = mk_pte(folio_page(folio, i), vma->vm_page_prot);
>>>> +               entry = pte_sw_mkyoung(entry);
>>>> +               if (vma->vm_flags & VM_WRITE)
>>>> +                       entry = pte_mkwrite(pte_mkdirty(entry));
>>>>  setpte:
>>>> -       if (uffd_wp)
>>>> -               entry = pte_mkuffd_wp(entry);
>>>> -       set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>>>> +               if (uffd_wp)
>>>> +                       entry = pte_mkuffd_wp(entry);
>>>> +               set_pte_at(vma->vm_mm, addr + PAGE_SIZE * i, vmf->pte + i, entry);
>>>>
>>>> -       /* No need to invalidate - it was non-present before */
>>>> -       update_mmu_cache(vma, vmf->address, vmf->pte);
>>>> +               /* No need to invalidate - it was non-present before */
>>>> +               update_mmu_cache(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>>>> +       }
>>>>  unlock:
>>>>         if (vmf->pte)
>>>>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>
>>> The rest looks good to me.
> 
> Thanks, as always, for the detailed review and feedback!
> 
> Thanks,
> Ryan
> 
> 
> 
