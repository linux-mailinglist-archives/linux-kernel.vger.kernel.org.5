Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B034278E781
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjHaID1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjHaIDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:03:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7188CCE0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693469002; x=1725005002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MYlCYLJwOKg9KqzYp6FyYEb5ILZ33ZLTxjaN2bAPjYw=;
  b=Fi95iyAvqi5SiZ5b0Q4lNfz4mqZozCTFmFahuTO9sr59z+fTVStdRJls
   h4FUccdekwggCm/rHYsuNPBpZNvv0z5sluo2+WJlfEXRpFBojzKkxyCHK
   nPttA+1lUWJ44NgT558R71hDmUkWydzfTAvQ2ygnJeKF1MCGRe2ODLaPh
   0xAdhYMrUWJd9/3rMn6NcOBuOecnPD9gVx2iQc4DlE+EAORJ+s3rV3Ok+
   oSYjSulqhn4WD5IXG2mzO1HWKDz3O6bShqo9KWcLGc428LPXoxtm+6tBy
   gvko1D8i7Qs9Wvl9s6GDsrGdiOa94I/2kxPpt3VEB++9rFV9iKR4sZKdp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="439805655"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="439805655"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 01:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="809475900"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="809475900"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 01:03:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 01:03:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 01:03:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 01:03:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlF2XKCwQv9ov7fL8H2EH0EhqycyTHGh4GBuADH9XAK6RStoQIQZHdgqZGPj4kx9TBCbKrLbHc0awnPPX2LNq4H8MgGCM90pjlIZe1NPYYzaeokVYOTMwuXSxvg8D28ZB7rOGk3wI24aKe4YmZwzYxPJj7GMqOmNXeQEIgU48nxh0YkhcYL7EB0GHZ+AoDQKIxQoCaxwjjb7gmr2AumL4T8rkBXOYdMWLnt4hgr4haf7XyvDdzwEwAGyad2sZsozXJhyWcD7Zfi50sjbt01OII9PYFoIy/M0481yywiPTNU+ldMzI1y0SM00qm6i7zYfbsZlEEHYUoD/QfHTslqxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIWFNdQokoH2I0htT78hBPS5I4z39lvrJZVMq2rEBRs=;
 b=QBDsv5vqa0uFavENtQLqps/fqEFoeIl85MIqR8M+3j6TsYlPJK5u1TQSnPEOiUymAI1E/sdS/tRNOXBD5TsGKILXXzmz/JXLtT+zlQZxAiKsThvhBJYyV1qKjh4A/yLi7AKjbIKnHGaeMDcFN7U0KiA+yIkJkauCFM0S216EIIjuvq4wAaZOk4Mol45m5Ri/VY+meAEts1gHdoIjT4omeYWYTlu/IVHrUFTGwqdgG0QO2mFvPRygnaT/EoIUSYbBZ5VFZI8FJaxlCK1B1S0+lFohz6JnPeQabr+oUPhXBpTWXaXXoWawwCTa7/7tCiQGdOrJvrh//+P0o/UO+y3wvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BL1PR11MB5382.namprd11.prod.outlook.com (2603:10b6:208:31c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 08:03:12 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6745.015; Thu, 31 Aug 2023
 08:03:11 +0000
Message-ID: <747deb43-68c8-449f-b41a-91864820a699@intel.com>
Date:   Thu, 31 Aug 2023 16:02:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com>
 <87cyz43s63.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BL1PR11MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: 437d802e-e430-461c-b9a4-08dba9f8b879
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJ4deCx+KyAtpqsdQuEIcd4PKBK50gBnVsJOXXZwrUiaBeXPy8ilfoaRq9I4TiipcA45WHD9EAH1isjagKM/AyRpmU1UkyKft7YxHjRW/HB8l3vLTyyHsR6FjXJHqxkD5huf4qnKGnZHp8zcdWDJ7+DXvSBuzIAg+ccUhzjLIL4pYgIpODIGHkpphnT/IYh7vuN+rpF/Nb4LhyhXWJQe6C5wr0jCYmAE8cJcgEjoxwl/ERvzprtIQWRLux74en0UNCAXEQ3iH4yRfqImP++1dBfld5qHxG9cCRdoV2L/yOXqiXq80gN5GxcmP+s95621BmzA2+iafZotZZ2Te7Uxcg+Po/A/hNs0Kh3iZwzakJFhH0xBsLWRMtGtuxyGoiuA9+DtU/wuTpROI2W52YT1cIlNITDmscBecaTtqewCth/BBhjipqXPHynuBBjK1uuTXZDeBChgyuCqVVYy61oqEl81o8ATNALS6uz560JLmJRMnuKnPuDoglAEdIJS8Uo6wQGOS8ZetLTjnYQpE6gp1NECd46eAlbWLVJCybSlxgMaah86kOzl71y09nFHmBqx9LMu5u6GPTS3IpuyqjQTEoZT4GWo0jN7XQUgoISTQLRpQISIWMUD8+qM8tT1yivMh4uu+JqLS08hxJNf1ZcvJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6486002)(6666004)(6506007)(6512007)(53546011)(478600001)(83380400001)(2616005)(26005)(2906002)(7416002)(54906003)(66476007)(66556008)(316002)(41300700001)(66946007)(110136005)(5660300002)(8936002)(4326008)(8676002)(36756003)(31696002)(86362001)(82960400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW9UQXFhUkJwek9ab0JiVy81UHcvb2pJbGthL0s2UFl0a1JpczBTYUdZME1S?=
 =?utf-8?B?d2VRZENKQnFHeHQvL3RVVlFmVHcvWXBXZEpCRUFVQzVKVEJ6SFd4OVFJU2hh?=
 =?utf-8?B?aXNXdVBUelFRWkVZTkFzbFNWSkR6R2N2ZkxXNzE4UFduMWRMeXBBaFVVRjlH?=
 =?utf-8?B?cjd1VU50eWgwZ3NNQ3lXTWtadGhHaUVLeHA1Y3cwb0lSY0lyRStJWmRMaXNY?=
 =?utf-8?B?cGhhU2RQekg2dU5Uc3ZVS2dsdDF5QytpSmYvMGd5L3I5dEhpNWcvQlZLZ3o3?=
 =?utf-8?B?VGpnZ3JuYjRnaGdXN1E2clhoWkF6c3ZhL1N0UndiWEt4YlVFL0JnZEhTTExa?=
 =?utf-8?B?WnRQY3BLaVFJK3ZaZzloWFlzWW1sY2t3NDg5Y1lBYkduc1EycE11YVFWVVB4?=
 =?utf-8?B?YXBUdnYwaFU2QW1HdE9jQm9oMjhTYk01R0pjNlQvNFBadWc3S3hXK1IxRnJX?=
 =?utf-8?B?ZFN3dGJsZW9hcXRrLzUzSm1NejVyeWp0bHp5b0dWTTBLd0hwY2J2ekdJTFF3?=
 =?utf-8?B?Q21tdHJiUGljemJ4SGFFSzZlMHBoVnAvWTZCVVYwTTRLRURrcTkwcllXYndB?=
 =?utf-8?B?d2ovVUZHMUdHYVkwZm03TmIvanQvVmE2aEZ4cEhyVzFBbXA3cEJ2WHdxSVFQ?=
 =?utf-8?B?eHVYdTdNamMyTGh1amx0YmgrOFdycVAwb250Q3ZrQ2ZOaS9KaSt3WTUyejlY?=
 =?utf-8?B?bnJMNFFPY2lBSWJZNSs1RmNrdmJwODhaUFowV3U2VUtrZllqRHpHVVdJMEg1?=
 =?utf-8?B?S0IvVDRmbS9hbHJDWUF3QWE2dVlhNUlLZldKYjFUV2dRclpkL2pzRkJvaHhR?=
 =?utf-8?B?SS9lTkcwWlJtZjhlWFZ4Y3VsMHlwNnpaeHhBcTg3L2JFVHhZWUJoOFVwU3J0?=
 =?utf-8?B?eUhWc21uNWd0a3BpTWpZb2NmbUM5b3lzcm9SR1FUZjJhc1Nnc3BlNXB5SVAy?=
 =?utf-8?B?RTdjTFRsOFJ3VzVoZDUrdE9ubzZ5SU54MmZnazNPaTdmS1k4NjN5cmY0NWlj?=
 =?utf-8?B?S1Zrc2d3YjNVN0tCVmtxajhTeE5jRW9adFpSQ2xKQ1pKWDIwL1NUUUZPWFh2?=
 =?utf-8?B?SGlUWjVudEorRVRPMVIzNjMwVllzUzdCa2tZMXVpcXNxUmVvQzNHN1NMOG53?=
 =?utf-8?B?WkY3ak9peTN3WklwRHpDQ0hJRGVjdDQwaXJtZ0dWV05wYUdlbmRmM1FodTFp?=
 =?utf-8?B?cG9YUjBOdWNCUlBWdkllaTlnZ0tBQUl6MG5iakxpWFg0dGVwY3hPQTNkTDhO?=
 =?utf-8?B?d05pbkhHTFZ6RFB0c0xnWFJTU3Z0YWhqWVNkYytwTEpRbjdXdFFFWEtTdWxF?=
 =?utf-8?B?V0FTR1lYRW5rcU80L2VYWC93UGZPZHpUY3ViRUQxdy90U2NmZU52N3JWbXhn?=
 =?utf-8?B?VTBYMDhSYUZzejFLcUsvMTBwMkMrNXJkdjNlUlJoTkg2VWZKQVYzNFlmQ014?=
 =?utf-8?B?amNtQjIyVkptUVE2dnhVNUdtYjF2WkdJNGEyUVovTWVLcWthbi9FWmROZ2lD?=
 =?utf-8?B?Z0lZaGxxL2oxZjlhRzEwM291V29pbXlUMTJ6Y0ZQT1JZbG5rL3BqdGhRZldu?=
 =?utf-8?B?eUpobStOZ0wrOW9zU3RocGNaNFpScjI2emVFRlAvNUdpNkZWVng5OFI3RWl1?=
 =?utf-8?B?NGRUTm5TanN5L1FkOVV4dHhTNDVqUCtKV1ZmWkhzOWZTNGFOak8vS0g3Q2dO?=
 =?utf-8?B?cGFkV0c4S1hQcGhEUS9BL1hQTkszZXlROWVyK2taRExxY2xkSXM3V3l3dHpZ?=
 =?utf-8?B?S2Zrc2U5c0xudCt0Um42ZUpBRElWbitURll6YmdTcXJpV1BsVmJCdVUvbDR5?=
 =?utf-8?B?WXlHMFUrcHpQaTNKVnJzckFJWGhySGlYc283SHBSZmRxbS9YVHM2a0RTZldt?=
 =?utf-8?B?OHY3TTF1MkhieWFvd3BpalJONDMxMzRrRHc0MzJzT1pWMWxSMWYxbjAwQVoy?=
 =?utf-8?B?RHVTazFLbWwwWmFyS3V0U1J2ak5QM3ZQd1RpZko2Qzd3VW9wcmFrdmJBRUgr?=
 =?utf-8?B?UmtnR1VMQlk3a3haV3ZPa0lDM09DVU9HOTZSNW9sa1daMlR4MG9KRTdJU2pw?=
 =?utf-8?B?VzJLc3hNZFN1cmM2cnRFSFl5N292YmxLaXdNSjVyWTlBQmRuYkJvdmE0RVk2?=
 =?utf-8?B?WGo0djZtTVEzaTJIdHJrQlVVUm5JeTMyTkRLWFp3cnZ3enFMcEh3czVwa0NM?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 437d802e-e430-461c-b9a4-08dba9f8b879
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 08:03:11.8034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SppHvUg5erTYvfygdj5kszTZiNwmwxZL95HGZP/tz/js92oyNuIJcDAkHEPmiT/8ShAZORhANweuKrweYYzjCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5382
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2023 3:57 PM, David Hildenbrand wrote:
> On 31.08.23 03:40, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>
>>> On 15/08/2023 22:32, Huang, Ying wrote:
>>>> Hi, Ryan,
>>>>
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>>> allocated in large folios of a determined order. All pages of the large
>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>> counting, rmap management lru list management) are also significantly
>>>>> reduced since those ops now become per-folio.
>>>>>
>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>>> which defaults to disabled for now; The long term aim is for this to
>>>>> defaut to enabled, but there are some risks around internal
>>>>> fragmentation that need to be better understood first.
>>>>>
>>>>> Large anonymous folio (LAF) allocation is integrated with the existing
>>>>> (PMD-order) THP and single (S) page allocation according to this policy,
>>>>> where fallback (>) is performed for various reasons, such as the
>>>>> proposed folio order not fitting within the bounds of the VMA, etc:
>>>>>
>>>>>                  | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>>                  | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>>> ----------------|-----------|-------------|---------------|-------------
>>>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>>>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>
>>>> IMHO, we should use the following semantics as you have suggested
>>>> before.
>>>>
>>>>                  | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>                  | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>> ----------------|-----------|-------------|---------------|-------------
>>>> no hint         | S         | S           | LAF>S         | THP>LAF>S
>>>> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>
>>>> Or even,
>>>>
>>>>                  | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>                  | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>> ----------------|-----------|-------------|---------------|-------------
>>>> no hint         | S         | S           | S             | THP>LAF>S
>>>> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>
>>>>  From the implementation point of view, PTE mapped PMD-sized THP has
>>>> almost no difference with LAF (just some small sized THP).  It will be
>>>> confusing to distinguish them from the interface point of view.
>>>>
>>>> So, IMHO, the real difference is the policy.  For example, prefer
>>>> PMD-sized THP, prefer small sized THP, or fully auto.  The sysfs
>>>> interface is used to specify system global policy.  In the long term, it
>>>> can be something like below,
>>>>
>>>> never:      S               # disable all THP
>>>> madvise:                    # never by default, control via madvise()
>>>> always:     THP>LAF>S       # prefer PMD-sized THP in fact
>>>> small:      LAF>S           # prefer small sized THP
>>>> auto:                       # use in-kernel heuristics for THP size
>>>>
>>>> But it may be not ready to add new policies now.  So, before the new
>>>> policies are ready, we can add a debugfs interface to override the
>>>> original policy in /sys/kernel/mm/transparent_hugepage/enabled.  After
>>>> we have tuned enough workloads, collected enough data, we can add new
>>>> policies to the sysfs interface.
>>>
>>> I think we can all imagine many policy options. But we don't really have much
>>> evidence yet for what it best. The policy I'm currently using is intended to
>>> give some flexibility for testing (use LAF without THP by setting sysfs=never,
>>> use THP without LAF by compiling without LAF) without adding any new knobs at
>>> all. Given that, surely we can defer these decisions until we have more data?
>>>
>>> In the absence of data, your proposed solution sounds very sensible to me. But
>>> for the purposes of scaling up perf testing, I don't think its essential given
>>> the current policy will also produce the same options.
>>>
>>> If we were going to add a debugfs knob, I think the higher priority would be a
>>> knob to specify the folio order. (but again, I would rather avoid if possible).
>>
>> I totally understand we need some way to control PMD-sized THP and LAF
>> to tune the workload, and nobody likes debugfs knob.
>>
>> My concern about interface is that we have no way to disable LAF
>> system-wise without rebuilding the kernel.  In the future, should we add
>> a new policy to /sys/kernel/mm/transparent_hugepage/enabled to be
>> stricter than "never"?  "really_never"?
> 
> Let's talk about that in a bi-weekly MM session. (I proposed it as a topic for next week).

The time slot of the meeting is not friendly to our timezone. Like
it's 1 or 2 AM. Yes. I know it's very hard to find a good time slot
for US, EU and Asia. :(.

So maybe we still need to discuss it through mail?


Regards
Yin, Fengwei

> 
> As raised in another mail, we can then discuss
> * how we want to call this feature (transparent large pages? there is
>   the concern that "THP" might confuse users. Maybe we can consider
>   "large" the more generic version and "huge" only PMD-size, TBD)
> * how to expose it in stats towards the user (e.g., /proc/meminfo)
> * which minimal toggles we want
> 
> I think there *really* has to be a way to disable it for a running system, otherwise no distro will dare pulling it in, even after we figured out the other stuff.
> 
> Note that for the pagecache, large folios can be disabled and distributions are actively making use of that.
> 
