Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12897558C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGQAPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjGQAPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:15:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C12E6E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 17:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689552928; x=1721088928;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=edXPKC512tUwQSew65urL/gPtSuHy4YezxnRmbFJYqk=;
  b=OVaU6WXmL9vLpw8UE34LGVAYX4A3nwb9aJbOSzsTlEXrcUTA9GJl4h2j
   u3OJ9C5PNwDvjbGTeXKpewNlPEDAbIaQm0IKZ3rU6v78O9RWMXycoyZrx
   u4ZnhMO26GMLDSnzMTtTJC+mJWRLtdFc8V6VIDi1g+YNFuavcos1LXXuu
   XRuOFVzgqubosqev9hHiQpGv6O8eyC4EqA5c5WXmTZxSSHNExcdgWyHW5
   PbSeoPss/rdyQoLuqv43pQU9Hd+K1mD0A3+Rl4mVIbItdQxkVykkA1iin
   8gfIaJ/omXNIXCM7Tt7dBprLxJ7yhB7Et70OwSEXCwJEQ8LW8J5yoR2kz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="365855381"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="365855381"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 17:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="897013963"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="897013963"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 16 Jul 2023 17:15:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 17:15:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 17:15:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 16 Jul 2023 17:15:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 16 Jul 2023 17:15:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpctTy8pr7pNH+AQ1jiAfDFoxT+/PcCycaDDZ0V3l7CgxMZQzuoWEUChoWXCh2+vNLkS5JeK08MEWldGjsUHdwq9JcP+gI00yxrkO69NuXPk5vj3qeHcX4hpcNK26oviU4f8y9dqmGeJ/wmWOYaEIzzEXrcmFmlFUhp1oQAkP0YDtp/EhELY6kCzosyoEJsVQfQInx6lC+IGVDSBroj+NwWVieWAIVfT78K2lpZJ0hg0rGuDrNz3rbxI4UN76m/nc5BGVtD02uo7hu+Eu+GqOSSfpvgVAxLGv9UyKcvTXN+SKZ/o9uYhbmZFtzqP0ilsPjmbwV6WZSfOvWnakyGXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5jcgzkR9B7pGwU8hxicYYieQpow4pw/kkh/Md2XNSc=;
 b=eqOpb+Qi7zG2WgOj8iMHndI+oKBALnG/O3kJCkSIEQm6RfEPJblqjn5kh0cRNHmMp4XIQn/vLJsppGzBE2a7BAeoihhf3fTbaIAgPkZOYeM2NvPEcq/kUpRY9B5fEpuvDgo6OaDtqNFwTq4FQtRM2PxKzo+56Gp/smaBiY2I8StOuW8a+I/rOOY0ztOnHPWb6QogweYW3biC9w1KTplqG16pqLkciNhy+VvJCnh+iPrt2V4fiVg0H5OKwc8AZS8RgLcWIYYKfGqGlAvIp7itl37+DgCZUCpUDwbU3hb/f5N7p1BgwkngPgTwoX4uJ0DrEa84ocjHm4h4qPemn2SEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB6444.namprd11.prod.outlook.com (2603:10b6:208:3a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 00:15:21 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 00:15:21 +0000
Message-ID: <eab84d78-6ae6-4db7-0474-35e439435913@intel.com>
Date:   Mon, 17 Jul 2023 08:15:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
CC:     Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
 <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
 <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
 <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
 <6C3EFBC6-DC59-4167-B51A-7231A55FE1D5@nvidia.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <6C3EFBC6-DC59-4167-B51A-7231A55FE1D5@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: f535eca9-2eea-4168-594a-08db865ae8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGY7ckUivjTvfahK+n8GeTeSjPdeb86xyDayuYY9Y86NufGGHzhrB8drOwjNsRnLoWwdOBZNc8BgXQYThSMejWPMvPWLcOMcoOOS3lenxe/eIGe0joeUQ2wIQtsGPyAm7Sm86kxxdcZXCscqbdqal3/uBeitKiXLpmKLpNBrsZb4M753ahdc+8+D9IwTgSbbJlS050Y191TyHPPdZQlMOSYtIVpFz+ig5z2w5JQCZ5rrtPiyJj7wamXNHyw/CIIXkehc7y4tbGu0zwlN1ELocWCnqvvrZRNwddif4SQpcwVgcndFoAp8XPZMhWRlotmJY+kitLjGxOSy2qdqGE/XphJazjHtRH2Txlq17wBMh6UKCqneeS9mbpb/63pNO6i/ijv1RvgVU90C8AIPWtiA34CKdYcqwMByunf2R8dFmn3aOlU3SxdAz9UxpHD0VG4ermnwb3bHwDP001FE1GyBnMbubXFZjRwXHKTOVN7fq6SFVExUtkocogp5nEwT7my6knzWm8LrRo/MaW5hgH3786K52B95HbvGcBjTCuuqXpZTqJAa6czx2/tSzse4JVP7Zm8VEGdew5mz8U04pprdj897oRLElU6EEQvFDeEngFSokc+frMPds4aSvlKyLtVvQvgX61sajENCahenRO+jaxZ1AeM7RQV0SOwGOfq8vnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199021)(2906002)(38100700002)(6512007)(82960400001)(966005)(83380400001)(2616005)(186003)(26005)(6506007)(53546011)(5660300002)(86362001)(31696002)(8676002)(8936002)(36756003)(7416002)(478600001)(54906003)(110136005)(6486002)(6666004)(316002)(41300700001)(4326008)(66476007)(66556008)(66946007)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNDYmFRWStOL1pKeTVYNlFSN2dkcVlwMWlDV3JrUHN1Q2VJK1lvTXNFMHJ1?=
 =?utf-8?B?UE55M1NBcTVDdXdEa2V4dEpnQUFKcCtHTFpPamEveTFTamxnc1VCQWkxbHJh?=
 =?utf-8?B?MjJyVlZOVStrK3krejEzdDRzSmV6ZmZIQkd3YUJ3U3BnWHVGSUE5V3NyRnVK?=
 =?utf-8?B?cExRWlZGUkRJMldhWXNTM3gzWVBEbUg4NUZJV1lseDFBRU5QTUtUWlJySlRW?=
 =?utf-8?B?aVEyTkhJMURQcFNuMm9vbGJmZTBWSU15emdMSzl3YllmMWdzcmU4djFac1lL?=
 =?utf-8?B?ak5XRnY2UXhJbFcvMkIwNHl3Rmgyc2tYZmxQVm5BbSthUzRrV294bkc0TC9Q?=
 =?utf-8?B?OTFYTUZFT0FYZGJJTkVCQjNWeXR3Z1hIbkdzcUFXc1N2MnFOWTdmRFhzaU5M?=
 =?utf-8?B?MDVWUklKa3pEd2lkSG41VzJaVGtPUGJxcWxCZHZaSmhXQnRCekw3ZXVvMmVG?=
 =?utf-8?B?MUM0SXo2eVJCZlpUYVJpcENSM2U5NmdZVzY3L2p2V05ubVU3L0xwR0FBYmJH?=
 =?utf-8?B?RE1BWks0S0FjUXRjZ2dyR3hjV0tpaGUyQVc0eDBMNnh3V2YvdUNhK2NCeCtl?=
 =?utf-8?B?aXhYMURDMWpSeUFnTUhOQ1k1RFFObVV6VTg2NzYwMFBJL3dsaW1WWm9BVHdT?=
 =?utf-8?B?elJ5bERXMG84anN6RkhRZ1VxL2MydXF4QjJiT21UUllvN3E2Wmh4YjVGckht?=
 =?utf-8?B?VkhXZUU5emFDbDQ1S3BMYWF2ckZqYnVQMHZtOFdtYjI3R2hJN0R3SVNPUTdx?=
 =?utf-8?B?YUFYMnFTR3hsUnRsMUVyeCtSb0E1UUJPMzhFMjZMZXB0TFBpeDVHd2NMZTFV?=
 =?utf-8?B?YTdXSmVPdnVCQTdYWkNuRS92TThYQkpMM2JkNnNIN0VwZG52V3N5N0c3M0Y4?=
 =?utf-8?B?UHNia0Z1ek9GQ1FiVTJkQmdsVjZIeTc3SjQ4WWZuQVhROHdyYjQxZkI0cmYz?=
 =?utf-8?B?RFk0Z29kOW1iMG5CS2xFZEJnTjBoTjU3ZFR6YWNvSG9kMkRaRERibExDREpU?=
 =?utf-8?B?OXFtQXFIS1B0UCtqcllsQmRCQUlEVnhpTUoyOEZzMEF5VUNmWGlONDVsOFFN?=
 =?utf-8?B?S0o3MWg2K0NVRE9VSFMrVFdxSGN4dlcxcGgvMzN6UzZiK1VYY1ArYk56dTRQ?=
 =?utf-8?B?dXk0WEVTeFRGRXgwVDgyZXlYb1FYSXhVZ2lUQzdIeERHVzJsNFBJMmQrQVlH?=
 =?utf-8?B?d1VOaE1ldTUyZ0F0NGdYUXVIM1BrbHo1N1lYTWpIUkNwbGxndjRrUDAyUWJL?=
 =?utf-8?B?dnhpbXBFb1poTFJFaG5ZNUo4M1BETWc5MFp0dVFEeTBvU2RJSnBMaUlGOFNU?=
 =?utf-8?B?SEt1ZnRSWFRPQXNwTllXNnBZeklzRnU0UHlSaExaVkZhRUhCalNBVXQ4Rk1Y?=
 =?utf-8?B?cWZ6VFNIdFRDdStsN3FPUDRBMG1WWTllcFZMRkhJajliMjNSQ3dpZEprQ2I2?=
 =?utf-8?B?c2JrVDRucVdFK0c1WkxQQXJxQmp0aHQ3L2RabXRCb1hqSTdUN2Ywc1hVUUFt?=
 =?utf-8?B?REkxNHlmK0JlRTIza0ZNZWxNU2NYU24zWHlINHpiVCtjdEpGSklYWkw0eHN6?=
 =?utf-8?B?alJLVDJiZGoyamxiSFhYUGQwRFh0ay9xK1R3Tm9BQTJKOEpJYVByMHVVUFRl?=
 =?utf-8?B?WTZ6bEdBTFNlUWVGQzZ3ZC92Q0poMmV6dXd1RjMwUEp1ZlhxOFBwMElmSmhl?=
 =?utf-8?B?Z3Z3djB5VUZvcko1a3UvdCtaOWp5TVByTnlMVDRCSnBzelk3N21wbzkxUmpu?=
 =?utf-8?B?aWRIbC9hV3Y0Nk4zdTNKaHJuM2hXRUVla1R1MkNRUEpuUDlQWjNTZDhZUloz?=
 =?utf-8?B?YzR2dnBFNE5NMFlYZmpibGRkanFCaTZsL1dEZHRrK3NpQ0tma1V4WTFpZWUx?=
 =?utf-8?B?TjRXZXhiQ0lSU3VXdCtGaHBvY2VWa2N1a3RYaUo4M1l5REQrSGxYT2NHblV5?=
 =?utf-8?B?Vkd6ck03cTJwMmtUSWtMS1Z2TmhaaUtIQUt6MGc5cmdkQlMxUUFvM3hTcVl1?=
 =?utf-8?B?RjNFQllCVnZEeUxuQTRyMnRhTU9UZTh3MkpqMkp4bVJHZElyYVBBRU11SEhZ?=
 =?utf-8?B?WjkvN3YrU3JoU0w4Y3ZHcnRPeE1iYUdVaXdhUngxR0h0QmwwVmVpY0REY0Fv?=
 =?utf-8?Q?SjIPHBub31KvHe/dTy5rGS5kw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f535eca9-2eea-4168-594a-08db865ae8aa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 00:15:21.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RIa0SNjGY9DLY8vtZm6Xb81ZEE49QZYPMLGlr+4J8nlUhrkdErd2crNjOy54fuPNMzdohcK0ZV+X4BhO4sW+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6444
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



On 7/14/2023 10:41 PM, Zi Yan wrote:
> On 14 Jul 2023, at 3:31, David Hildenbrand wrote:
> 
>> On 14.07.23 05:23, Yu Zhao wrote:
>>> On Thu, Jul 13, 2023 at 9:10 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/14/2023 10:08 AM, Yu Zhao wrote:
>>>>> On Thu, Jul 13, 2023 at 9:06 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>
>>>>>> Current madvise_cold_or_pageout_pte_range() has two problems for
>>>>>> large folio support:
>>>>>>    - Using folio_mapcount() with large folio prevent large folio from
>>>>>>      picking up.
>>>>>>    - If large folio is in the range requested, shouldn't split it
>>>>>>      in madvise_cold_or_pageout_pte_range().
>>>>>>
>>>>>> Fix them by:
>>>>>>    - Use folio_estimated_sharers() with large folio
>>>>>>    - If large folio is in the range requested, don't split it. Leave
>>>>>>      to page reclaim phase.
>>>>>>
>>>>>> For large folio cross boundaries of requested range, skip it if it's
>>>>>> page cache. Try to split it if it's anonymous folio. If splitting
>>>>>> fails, skip it.
>>>>>
>>>>> For now, we may not want to change the existing semantic (heuristic).
>>>>> IOW, we may want to stick to the "only owner" condition:
>>>>>
>>>>>    - if (folio_mapcount(folio) != 1)
>>>>>    + if (folio_entire_mapcount(folio) ||
>>>>>    +     (any_page_within_range_has_mapcount > 1))
>>>>>
>>>>> +Minchan Kim
>>>> The folio_estimated_sharers() was discussed here:
>>>> https://lore.kernel.org/linux-mm/20230118232219.27038-6-vishal.moola@gmail.com/
>>>> https://lore.kernel.org/linux-mm/20230124012210.13963-2-vishal.moola@gmail.com/
>>>>
>>>> Yes. It's accurate to check each page of large folio. But it may be over killed in
>>>> some cases (And I think madvise is one of the cases not necessary to be accurate.
>>>> So folio_estimated_sharers() is enough. Correct me if I am wrong).
>>>
>>> I see. Then it's possible this is also what the original commit wants
>>> to do -- Minchan, could you clarify?
>>>
>>> Regardless, I think we can have the following fix, potentially cc'ing stable:
>>>
>>> -  if (folio_mapcount(folio) != 1)
>>> +  if (folio_estimated_sharers(folio) != 1)
>>>
>>> Sounds good?
>>
>> Adding to the discussion, currently the COW selftest always skips a PTE-mapped THP.
>>
>>
>> For example:
>>
>> # [INFO] Anonymous memory tests in private mappings
>> # [RUN] Basic COW after fork() ... with base page
>> ok 1 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with swapped out base page
>> ok 2 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with THP
>> ok 3 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with swapped-out THP
>> ok 4 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with PTE-mapped THP
>> ok 5 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
>> ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
>> ...
>>
>>
>> The commit that introduced that change is:
>>
>> commit 07e8c82b5eff8ef34b74210eacb8d9c4a2886b82
>> Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>> Date:   Wed Dec 21 10:08:46 2022 -0800
>>
>>     madvise: convert madvise_cold_or_pageout_pte_range() to use folios
>>
>>     This change removes a number of calls to compound_head(), and saves
>>     1729 bytes of kernel text.
>>
>>
>>
>> folio_mapcount(folio) is wrong, because that never works on a PTE-mapped THP (well, unless only a single subpage is still mapped ...).
>>
>> page_mapcount(folio) was wrong, because it ignored all other subpages, but at least it worked in some cases.
>>
>> folio_estimated_sharers(folio) is similarly wrong like page_mapcount(), as it's essentially a page_mapcount() of the first subpage.
>>
>> (ignoring that a lockless mapcount-based check is always kind-of unreliable, but that's msotly acceptable for these kind of things)
>>
>>
>> So, unfortunately, page_mapcount() / folio_estimated_sharers() is best we can do for now, but they miss to detect some cases of sharing of the folio -- false negatives to detect sharing.
>>
>>
>> Ideally we want something like folio_maybe_mapped_shared(), and get rid of folio_estimated_sharers(), we better to guess the exact number, simply works towards an answer that tells us "yep, this may be mapped by multiple sharers" vs. "no, this is definitely not mapped by multiple sharers".
>>
>> The "mapped" part of it indicates that this does not catch all cases of sharing. But it should handle most of the cases we care about.
>>
>>
>> There, we can then implement something better than what folio_estimated_sharers() currently does:
>>
>> static inline bool folio_maybe_mapped_shared(folio)
>> {
>> 	if (likely(!folio_test_large(folio)))
>> 		return atomic_read(&folio->_mapcount) > 0;
>>
>> 	/* Mapped multiple times via PMD? */
>> 	if (folio_test_pmd_mappable(folio)
>> 		return folio_entire_mapcount() > 1;
>>
>> 	/*
>> 	 * First subpage is mapped multiple times (especially also via
>> 	 * PMDs)?
>>          */
>> 	if (page_mapcount(folio_page(folio, 0) > 1)
>> 		return true;
>>
>> 	/* TODO: also test last subpage? */
>> 	
>> 	/* Definitely shared if we're mapping a page multiple times. */
>> 	return folio_total_mapcount(folio) > folio_nr_pages(folio);
>> }
>>
>> There are some more things we could optimize for.
> 
> Before jumping into the mapcount, I would like to get some clarification
> on "sharer". Does it mean a page is mapped/shared by more than one page
> table entry or is mapped/shared by more than one process? Your function
> indicates it is the former, but for madvise_cold_or_pageout_pte_range(),
> I am not sure that is what we want. What if user wants to page out a
> page that is mapped by the same process twice? With current method
> or any existing proposals, it will fail undesirably. It will only work
> as expect with your creator proposal[1].
My understanding here is more than one page table entry based on:
  - Original code use mapcount() for normal 4K page. It's for page table.
  - If user wants to page out a page mapped to same process twice, maybe
    madvise_pageout() should be called twice for different mapping address.
  - It has more chance to fail reclaiming if pages mapped twice in page
    table entry. And more chance to be faulted in again.


Regards
Yin, Fengwei

> 
> Other places like auto NUMA migration also use mapcount to check if
> a page is mapped by multiple process with the assumption that a page will
> only be mapped by one process once.
> 
> 
> [1] https://lore.kernel.org/linux-mm/6cec6f68-248e-63b4-5615-9e0f3f819a0a@redhat.com/
> 
> --
> Best Regards,
> Yan, Zi
