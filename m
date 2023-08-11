Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619A8778700
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjHKFe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKFey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:34:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D219AE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691732093; x=1723268093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=//jJEq/zBnLlJClD874gdlKb7pcVUjXRjJCVX/5jJVg=;
  b=CSk/8iPhR3N/sNVCH3ZaqO0TXjuwz0dHAEnoV9H3wzSWI5LSfmQZrF+m
   M9PqtV3h0xSImC+aC/OFDCgrOqlpLJUBjn4RwNn07QWt4d/4hBBdPt3NJ
   JJwOuQWp2q0ulH+kgx8fl2pYYRbIUl3RJFQAh+YACMvTyjxHL6DJMU5Pw
   pQZf4CFoHPrh9VQbmsCg7Sm98wSP172dRRXLvxsp9R5/XYR01eXq5wUeV
   PH8gsV8Qp0K5QejFc4toDAKEYT11gvtuDmPqo0BPNEnxoeClkaSm8gZoP
   hsPDgnX+FQeMZ483z20NFW99ku21fB9pxBw9UCkjqHh7L+JSL6m/xRMib
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="402573135"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="402573135"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 22:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="767542496"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="767542496"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 22:34:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 22:34:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 22:34:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 22:34:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht6w8hvx+/BThnPLJllaJmQ8z+KeIxDLXXPnQM48FDdBkCz384xK3BTLL++1iDg3JrcnYOQVCsqkt7NPVQISOuWDCHRrDFK4yD8FkLnikDNi4HfFtBEGenjqnAP16gx/tuXzllHCiM7NrnYN6nPVEU5I3f2Juc0ZyDrINYhQk8PDCSpi8FYxp54qFMZr1uNCwOAnAuQD9HjEy6bB3aLKkueoDz+pkHCKVDTSabA+rpvDL5CPj9vnFykwwdecAjlduhlhyN7qGrnnQJi1GWroOCFqi29nK4tWZ3D40ThzdG2pB8D+l8hvBL81zSbJLCFNeC5StP8m0hO2gH9F7iElnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2icdwHEG0N9PmL/Eon0uCNIKxL6XK5LF864gVPZ9Dyg=;
 b=GLP6Q+UOSdA6L6A742tua3zDDcMreT1wJ/sHE3Pik7BhYuvbsj+nnS3nevu+o80xLPBOIOMUcYfDFyc5stNeIlhcWdTd37e+cYWNm6Oh9Ix9VAb+YJFF1Q4y+ZWHrV4PwoqWxXQhNIwN0CcLNBkh2M98Ap/fciLF/Nk/70yYA7jFSAe+kuYvuhiE0m8kMTRWAVrF663kF4HGa8WHxuEVLBDtH/gunXERyOzvsxtQ1515JUClksn4HwqDUf/ZN/5Wx+4RbaSMS5gILxZ2OXbxSM2OBPQ6Soygahed7fICLWda9OLtmnUMvJ+mfl2EGJxGbQagZpjp0oCI8+6kWhIZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH8PR11MB6683.namprd11.prod.outlook.com (2603:10b6:510:1c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 05:34:22 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 05:34:21 +0000
Message-ID: <6f9c7746-6081-4eb5-a98c-575cebd09617@intel.com>
Date:   Fri, 11 Aug 2023 13:34:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
CC:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <CAOUHufbUGwc2XvZOBmTCzMsOHxP-eLB60EdysKYzrkRMScOyMg@mail.gmail.com>
 <f97446e3-85d8-4d14-9fc0-683b31925325@arm.com>
 <16B84D1E-F234-414E-BA54-5893B6318E57@nvidia.com>
 <627c9081-68f6-49df-a270-1a5e47741d31@intel.com>
 <E657B3C2-6E44-461D-9AED-D37FB708FD4D@nvidia.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <E657B3C2-6E44-461D-9AED-D37FB708FD4D@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH8PR11MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: ba780bb9-2b6a-4bfd-66b4-08db9a2c9d89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7L5cLYj8XzGiDLjRBrqHGKH3Dhcvn3qeNbl4NkpW9IPiuQqfxIdg9aBZRbPVIjHwOFGs5DAasJOCCeCfPzNCtbCIo+GLLhgnl607QyXabJ/56oIn6HUoJbhzMF0Wa331FlMoLfAefGg/7JDpVgSeG7uGSBVdcZ5indnvGL8BG9AcP/i2nzD8BMauKiI3oAvBOfJSqhgyXSKaQcu4Igr2uxp53D9fc38xf54vq8tGklWmXbagpo986DXRWFghDFTv+E5mVBb7cIFQ3c5yEnewvJ4Cn6Ek+C0xkzo5PIR7JapsLJ6XrDn76btn3UeP87WwubxU759lHYEyyUM4BMzfo2M+ImIQ1Ydt9TP6Ez+1q6AFRsuawjSsJUSRlYGQgEQWJf82amR095clrZ63S6xGgNeQBDrd9+v6wAnJ/HfGzR5++jr5U2Gk0PpobvDM0a/Ui2P6ewOndiRSqGY/3a4EeJkO9Z5SvSePTXNRRSjOJ6C51uwEP2thcjOSZgBZ0qOZQul1pmybXEJmkbcfGdR5xqY4NlXt6gD8Aa+QwfTQcil/bf4rk/AED+RBveT40LUNSma3itunLlHXD0o8XtqanPctaGrhPQyU2lSqUOxfz06SyNcboubFFWsBHoVKFSS+CmEH1oZnXZleymFBhCoZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(82960400001)(31686004)(8676002)(8936002)(7416002)(316002)(5660300002)(41300700001)(66946007)(6916009)(66556008)(66476007)(4326008)(54906003)(86362001)(2616005)(478600001)(966005)(6512007)(26005)(83380400001)(30864003)(53546011)(6506007)(36756003)(2906002)(6666004)(6486002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2dIOGtxOXc3SUpoOGR1NHBNUFJkMjlqb2NrcjRjc0tJWHZUaSt4RHNhVnRI?=
 =?utf-8?B?V0w2a05hcVd5QjlVeUtmYWs5Tkc5N1pjY3RPT01ENWl2T3UrUDhiRXdzN3JV?=
 =?utf-8?B?YVVsUERQeFBIajVqZjNoKytZUFdGNDFESVpsdmllTVZxVzhENThTdlZMYkZC?=
 =?utf-8?B?OFVqZ29WSndLTWI4am5HVnBiYnJGYkE4ekNpUk1QRDVEcWhRdVhYcThpb2Jo?=
 =?utf-8?B?RHlSOE1TUE5nWWNHVXI0c09MeVhmdlhHMWJ1bE40NERLR3RKRDNLWUdBL3da?=
 =?utf-8?B?dXcxdkVIUmYxdUgvS29QM3hBOXJQeEJBWFFaMmk1MExzWXBQakNqS3dFY1RL?=
 =?utf-8?B?TUk3V1pZdGVCYkl0Zm42RFB0WTZXVWdwalJRWEloblpDM2IySmU0dWpFWDRN?=
 =?utf-8?B?QnN0ODZFR0RmMFdnRGtFSnRGUnV6SVR0TTlEOW5LWWwrOHNLZk9Gei9icm9r?=
 =?utf-8?B?azhKWUt5bDNrY1FwVU12WW1OaG80cE11MjAvYWk3djNUNlZTS1owQkhBSDBK?=
 =?utf-8?B?VzRxYjdxSG1HZjFlUU8rbDdlclpBWFZ0a2s1S3BOMkliL0Q3eFF5WjAvTnhC?=
 =?utf-8?B?T3JqL3I2Q1hTelZJMVk2b3lNcWlpZTc2bW8yaWRET2FaR241YndSckkveVRD?=
 =?utf-8?B?cnpudjZDWlgreWM1enliT0J3ZkpXVEpoVkVOTy9UUmtveWRWTFdMOUJBQ3FP?=
 =?utf-8?B?Z2VOdFRjTCt3T3Y1VnZPTnFvYTlJVlc2WGw4SnFzcUd5Z005YTNpWlpmbTYw?=
 =?utf-8?B?OEdXb0ZRd2hranVVbW1XVkZrTjNCM28vUG9TYXAvekYyRGkrTzN5SzZmUnpt?=
 =?utf-8?B?aTJqNjJvTzl1S1pmM09iL0pBZGhoTXhPcnZINUR5ZGNQT2pSYzlnZndaN3h1?=
 =?utf-8?B?ZDhtSmtwQ2FLZEN0enBneUZVVnZUNVd5dlFLa0ZORkFDdTR3bTFsQWFRWk9r?=
 =?utf-8?B?ZGxIN2ZwWFMvVUhLVmdDSjI1SzZyb0p4U29RTUFLb2U0d0lYejJKVmRaK00z?=
 =?utf-8?B?eGthTnQ3c2FQSmdnajRkWHZRSVQyc0VERmVpa1hObFVyYklUR2NWSm1wWDZS?=
 =?utf-8?B?aURtZWw5MlhRVHNBNitmY2FVRkJsNDFzbkxrbmMrZGpWZFRRci80enl2VkhY?=
 =?utf-8?B?ZVBJMERpdzgwREcxVGszRXZhZVBWcmV4d2ZYVlUzMHQvL3FaUGY1ZW9aSjdZ?=
 =?utf-8?B?ZDc3VlBtY0d2OW4vQ3VrMWo2R0xJV05ncDlOakMra0NvQVRtSkFlVHBtSVFL?=
 =?utf-8?B?am5TMG1NZ1ZIcGVPbjB1M3ZmVlJmSzFhU09vR3Z5Wkh5MDZmQmtZeCs1RlVB?=
 =?utf-8?B?SWRJUGU4QkNKeiszeTg0REI1YStGaHc4NGlTWkR1WkpGcEUyN3Q1M0ZkRS9F?=
 =?utf-8?B?TXoxSll3dWlRVmhqN0E2L1F1SnBBYzd2ZTZVTDhZWW0xRFRCTG4wWnAva05a?=
 =?utf-8?B?cDV0MTRjYkRkMk1BZUtSK3QvZlBHSDZaZ21ZbVdoVDl6QmtuakZnZkJpY2dp?=
 =?utf-8?B?WlZMSjljeXBUZUFNR1lTWUZCTHYwMHJHRGdNVFdwdTJLMFJLOVpSTFl0c21L?=
 =?utf-8?B?ZkJDUElUTFFhbWF1SjBYWFJINVJhWkxXS3NzSzRvYnBvN0tqdkJ4SlErUDZh?=
 =?utf-8?B?SkY4Smh3c0h4bnAwMldkV1NLeldBdkdsN0hGM2plY3NiU2FVLy9RQ1B5OS9M?=
 =?utf-8?B?bDNKd2hJNmtKdXNURXJjc3FZUExhTXl5UnNQZ1pCL2ZqR0haWkh1T25SdjI0?=
 =?utf-8?B?azUzVCthSjRCYWJzREVrTWpPNnN3QzNqMzVoWVp3OGtJdmFaMjFtOVNjL0x2?=
 =?utf-8?B?UWl5a3RUOHQ1c0Y5cTN1NWMydmltbkJhZ2VNSS9QUWZBQ2o2eVkwbXFmdVBG?=
 =?utf-8?B?OXhDNmJzT3ZkTElRazJoYVJ6QVRDMVFseE1leVJtZmtPMFc1Z2hGcEptS2VG?=
 =?utf-8?B?S3NpbWRLZ2RCVEhBU2J6OXBTRHVESEIxV094NVNKWVNqNjROZDBidEEyUVB4?=
 =?utf-8?B?K3VmR3RBdUt1dlRCQWsvWGZXa3dMUWgwRkVFYlgzTFh0dmJyL01iRkx0TTBx?=
 =?utf-8?B?L0RqWHBEZXIzVFRJQlNwdmQ1Q2hkZFpSVlJwREJNbDMwV1NnMCt2bmlXZXlr?=
 =?utf-8?B?aVdKN2RuYVU2bkFSRjJmbWt5QWJZSFhxTHhPR0Njc0dtOG1OMHFKTmVybzRT?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba780bb9-2b6a-4bfd-66b4-08db9a2c9d89
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:34:21.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0oXCKkWUIKpbg9u3eCHuYfjl2XGg8iUMFuaR2OyKiVTxwQ92gnrD7DWh4I/W26Sdk//vRwqEdW2O+eMNoLTiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6683
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 9:04 AM, Zi Yan wrote:
> On 10 Aug 2023, at 20:36, Yin, Fengwei wrote:
> 
>> On 8/11/2023 3:46 AM, Zi Yan wrote:
>>> On 10 Aug 2023, at 15:12, Ryan Roberts wrote:
>>>
>>>> On 10/08/2023 18:01, Yu Zhao wrote:
>>>>> On Thu, Aug 10, 2023 at 8:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>>>> allocated in large folios of a determined order. All pages of the large
>>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>>> counting, rmap management lru list management) are also significantly
>>>>>> reduced since those ops now become per-folio.
>>>>>>
>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>>>> which defaults to disabled for now; The long term aim is for this to
>>>>>> defaut to enabled, but there are some risks around internal
>>>>>> fragmentation that need to be better understood first.
>>>>>>
>>>>>> Large anonymous folio (LAF) allocation is integrated with the existing
>>>>>> (PMD-order) THP and single (S) page allocation according to this policy,
>>>>>> where fallback (>) is performed for various reasons, such as the
>>>>>> proposed folio order not fitting within the bounds of the VMA, etc:
>>>>>>
>>>>>>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>>>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>>>> ----------------|-----------|-------------|---------------|-------------
>>>>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>>>>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>>>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>>>
>>>>>> This approach ensures that we don't violate existing hints to only
>>>>>> allocate single pages - this is required for QEMU's VM live migration
>>>>>> implementation to work correctly - while allowing us to use LAF
>>>>>> independently of THP (when sysfs=never). This makes wide scale
>>>>>> performance characterization simpler, while avoiding exposing any new
>>>>>> ABI to user space.
>>>>>>
>>>>>> When using LAF for allocation, the folio order is determined as follows:
>>>>>> The return value of arch_wants_pte_order() is used. For vmas that have
>>>>>> not explicitly opted-in to use transparent hugepages (e.g. where
>>>>>> sysfs=madvise and the vma does not have MADV_HUGEPAGE or sysfs=never),
>>>>>> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever
>>>>>> is bigger). This allows for a performance boost without requiring any
>>>>>> explicit opt-in from the workload while limitting internal
>>>>>> fragmentation.
>>>>>>
>>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>>> breach the bounds of the vma, or because ptes in the region are already
>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>
>>>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>>>> mechanism allows the architecture to optimize as required.
>>>>>>
>>>>>> Here we add the default implementation of arch_wants_pte_order(), used
>>>>>> when the architecture does not define it, which returns -1, implying
>>>>>> that the HW has no preference. In this case, mm will choose it's own
>>>>>> default order.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> ---
>>>>>>  include/linux/pgtable.h |  13 ++++
>>>>>>  mm/Kconfig              |  10 +++
>>>>>>  mm/memory.c             | 144 +++++++++++++++++++++++++++++++++++++---
>>>>>>  3 files changed, 158 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>> index 222a33b9600d..4b488cc66ddc 100644
>>>>>> --- a/include/linux/pgtable.h
>>>>>> +++ b/include/linux/pgtable.h
>>>>>> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>>>>  }
>>>>>>  #endif
>>>>>>
>>>>>> +#ifndef arch_wants_pte_order
>>>>>> +/*
>>>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>>>>> + * and mm will choose it's own default order.
>>>>>> + */
>>>>>> +static inline int arch_wants_pte_order(void)
>>>>>> +{
>>>>>> +       return -1;
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>>>                                        unsigned long address,
>>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>>> index 721dc88423c7..a1e28b8ddc24 100644
>>>>>> --- a/mm/Kconfig
>>>>>> +++ b/mm/Kconfig
>>>>>> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>>>
>>>>>>  source "mm/damon/Kconfig"
>>>>>>
>>>>>> +config LARGE_ANON_FOLIO
>>>>>> +       bool "Allocate large folios for anonymous memory"
>>>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>>>> +       default n
>>>>>> +       help
>>>>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>>>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>>>>> +         faults, as well as other per-page overheads to improve performance for
>>>>>> +         many workloads.
>>>>>> +
>>>>>>  endmenu
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index d003076b218d..bbc7d4ce84f7 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>         return ret;
>>>>>>  }
>>>>>>
>>>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>>>>> +{
>>>>>> +       int i;
>>>>>> +
>>>>>> +       if (nr_pages == 1)
>>>>>> +               return vmf_pte_changed(vmf);
>>>>>> +
>>>>>> +       for (i = 0; i < nr_pages; i++) {
>>>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>>>> +                       return true;
>>>>>> +       }
>>>>>> +
>>>>>> +       return false;
>>>>>> +}
>>>>>> +
>>>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>>>> +
>>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>>> +{
>>>>>> +       int order;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * If the vma is eligible for thp, allocate a large folio of the size
>>>>>> +        * preferred by the arch. Or if the arch requested a very small size or
>>>>>> +        * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER, which still
>>>>>> +        * meets the arch's requirements but means we still take advantage of SW
>>>>>> +        * optimizations (e.g. fewer page faults).
>>>>>> +        *
>>>>>> +        * If the vma isn't eligible for thp, take the arch-preferred size and
>>>>>> +        * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensures workloads
>>>>>> +        * that have not explicitly opted-in take benefit while capping the
>>>>>> +        * potential for internal fragmentation.
>>>>>> +        */
>>>>>> +
>>>>>> +       order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>>>> +
>>>>>> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>>>> +               order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>>>> +
>>>>>> +       return order;
>>>>>> +}
>>>>>
>>>>> I don't understand why we still want to keep ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>>> 1. It's not used, since no archs at the moment implement
>>>>> arch_wants_pte_order() that returns >64KB.
>>>>> 2. As far as I know, there is no plan for any arch to do so.
>>>>
>>>> My rationale is that arm64 is planning to use this for contpte mapping 2MB
>>>> blocks for 16K and 64K kernels. But I think we will all agree that allowing 2MB
>>>> blocks without the proper THP hinting is a bad plan.
>>>>
>>>> As I see it, arches could add their own arch_wants_pte_order() at any time, and
>>>> just because the HW has a preference, doesn't mean the SW shouldn't get a say.
>>>> Its a negotiation between HW and SW for the LAF order, embodied in this policy.
>>>>
>>>>> 3. Again, it seems to me the rationale behind
>>>>> ANON_FOLIO_MAX_ORDER_UNHINTED isn't convincing at all.
>>>>>
>>>>> Can we introduce ANON_FOLIO_MAX_ORDER_UNHINTED  if/when needed please?
>>>>>
>>>>> Also you made arch_wants_pte_order() return -1, and I acknowledged [1]:
>>>>>   Thanks: -1 actually is better than 0 (what I suggested) for the
>>>>>   obvious reason.
>>>>>
>>>>> I thought we were on the same page, i.e., the "obvious reason" is that
>>>>> h/w might prefer 0. But here you are not respecting 0. But then why
>>>>> -1?
>>>>
>>>> I agree that the "obvious reason" is that HW might prefer order-0. But the
>>>> performance wins don't come solely from the HW. Batching up page faults is a big
>>>> win for SW even if the HW doesn't benefit. So I think it is important that a HW
>>>> preference of order-0 is possible to express through this API. But that doesn't
>>>> mean that we don't listen to SW's preferences either.
>>>>
>>>> I would really rather leave it in; As I've mentioned in the past, we have a
>>>> partner who is actively keen to take advantage of 2MB blocks with 64K kernel and
>>>> this is the mechanism that means we don't dole out those 2MB blocks unless
>>>> explicitly opted-in.
>>>>
>>>> I'm going to be out on holiday for a couple of weeks, so we might have to wait
>>>> until I'm back to conclude on this, if you still take issue with the justification.
>>>
>>> From my understanding (correct me if I am wrong), Yu seems to want order-0 to be
>>> the default order even if LAF is enabled. But that does not make sense to me, since
>>> if LAF is configured to be enabled (it is disabled by default now), user (and distros)
>>> must think LAF is giving benefit. Otherwise, they will just disable LAF at compilation
>>> time or by using prctl. Enabling LAF and using order-0 as the default order makes
>>> most of LAF code not used.
>> For the device with limited memory size and it still wants LAF enabled for some specific
>> memory ranges, it's possible the LAF is enabled, order-0 as default order and use madvise
>> to enable LAF for specific memory ranges.
> 
> Do you have a use case? Or it is just a possible scenario?
It's a possible scenario. Per my experience, it's valid use case for embedded
system or low end android phone.

> 
> IIUC, Ryan has a concrete use case for his choice. For ARM64 with 16KB/64KB
> base pages, 2MB folios (LAF in this config) would be desirable since THP is
> 32MB/512MB and much harder to get.
> 
>>
>> So my understanding is it's possible case. But it's another configuration thing and not
>> necessary to be finalized now.
> 
> Basically, we are deciding whether LAF should use order-0 by default once it is
> compiled in to kernel. From your other email on ANON_FOLIO_MAX_ORDER_UNHINTED,
> your argument is that code change is needed to test the impact of LAF with
> different orders. That seems to imply we actually need an extra knob (maybe sysctl)
> to control the max LAF order. And with that extra knob, we can solve this default
> order problem, since we can set it to 0 for devices want to opt in LAF and set
> it N (like 64KB) for other devices want to opt out LAF.
From performance tuning perspective, it's necessary to have knobs to configure and
check the attribute of LAF. But we must be careful to add the knobs as they need
be maintained for ever.


Regards
Yin, Fengwei

> 
> So maybe we need the extra knob for both testing purpose and serving different
> device configuration purpose.
> 
>>>
>>> Also arch_wants_pte_order() might need a better name like
>>> arch_wants_large_folio_order(). Since current name sounds like the specified order
>>> is wanted by HW in a general setting, but it is not. It is an order HW wants
>>> when LAF is enabled. That might cause some confusion.
>>>
>>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/CAOUHufZ7HJZW8Srwatyudf=FbwTGQtyq4DyL2SHwSg37N_Bo_A@mail.gmail.com/
>>>
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
> 
> 
> --
> Best Regards,
> Yan, Zi
