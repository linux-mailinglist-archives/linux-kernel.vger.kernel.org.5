Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F027B76F60B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjHCXPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:15:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1888830C2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691104532; x=1722640532;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/aISSZNS5wa4bDMzxnw0l7VhR3jVphORkdg+/0NTJxM=;
  b=gVTqiaiVKCEGKacihJQ94OlcvLTQx4s6e1oemjsqhb2FpSAHWBG8qsMo
   EvukPYr/CkFJi+Ume7dsIYuJWTs6D9wK3jw2obkWp+irMFDuKnAZPGLam
   XCHbERSmXLcuXIKh5hkQbZ+C4GEHVapLCARBk1d/HuCNDUDm+V31B9aEx
   nv27zTV8V496HhRNMTvTDEgC45KsXjmJAmP+XJtm/EQD5FtX/6e1WV1vl
   Cwqulqbskq2Hfj5Y59TNFRLnvxS/zMbIojfs6WiuW4hu+MXCEyxy2WIIe
   2PtEhsdk2WNf5G40ClDzyUzKZcjlEWFVW3tu2PvN0OeYsHpDIswcRDgAw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="360072330"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="360072330"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 16:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="764866380"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="764866380"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2023 16:15:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 16:15:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 16:15:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 16:15:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmNvyQG1j1tO+Iqc6QYwP4Sd1InkWg0sD2fZfayYnkMXE5Vp0vXHYeOb8cIOxNij+hYWFd6E5I6KVQ33mBgOhDmQ3O/PqAV0uHEe2QefN34s4m3YdlSDsqjGlQaymnqwiw+/BKWa/UobageJRd6keHxHXDP+UWgRZsSLNKjCJka5k8vlrq91UTd7ogqr/N2S2Hih5qWAVcHMkwYkEIXb/u4PnR1nqPRCCP9BQkoM2OFtEF1w+yQ6ZIHz5LIVHKSBLhPnGzMlVhJOe48EwALGdkVWITAEslQCAlkneacuN/y9Jw6AaHR3YQqCavmeu1aVBakzMhn8JJgmlSbJWYxkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQGVQ/QVKwKr0aRQLtdEZMD7Vd4mEq8X3E64uU4fuE8=;
 b=LgInNn0wp6oHjqhXBNHFMsZ7zi90JfLORt0guLujaybkkK+IL1h1a03R5qQ9w3YwoKLmS52Pq3PXo16YyJigtiy4yxedpdqSzh+CHUQL+XFdcFOET/q9kdAjudYHlwZ/3i6AyECfUMneStb/81xq6LgBxMAAGrSySEKYKUQmHArX+z5O5raQRK1HfMfnckHhAtd2Hae5JTDhIGkG3nGDo6hwYOPPHzdEJi5NPIFX6HFIx029Nt/5uZtSjUkm/Aj7GUmBBPpsN15uaf5waXSSwTdYBYHFNR7R90bWhBMf9bDVJOI9sxYOAd+VO4VQXkOUP5L5UxsFf8WZP2MnAisGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB4982.namprd11.prod.outlook.com (2603:10b6:510:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 23:15:28 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 23:15:28 +0000
Message-ID: <b9ec207a-8cbc-4014-1fb1-f1f437afd957@intel.com>
Date:   Fri, 4 Aug 2023 07:15:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <david@redhat.com>,
        <shy828301@gmail.com>, <hughd@google.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <502afc9c-0760-76af-d224-2a3428089850@arm.com>
 <66332544-c102-9134-a1a5-c4e4a82b66b9@intel.com>
 <0e7c6b9d-77c4-8c06-4c5a-fdf24c3b003d@arm.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <0e7c6b9d-77c4-8c06-4c5a-fdf24c3b003d@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB4982:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c1950c-c6d4-41b4-4439-08db94778691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXBWGSz+fjE/aEadaJu1UmP0+eQW7HtF2+mOTHav/OHgWeMLCMcJj7vNzR4N9sYlo+C5j1tTG+8LwnQx/sABYISVJmJISSbx5ZCPA/7/VoX0rPLdLeL2wGKnZvpxPEmtPHQGLOHHnd8UKJsGlVbJ9iMdbddctgrM2DB0v10Saowvcv5bCiIlKTp5K0harvl9mnhr3ZTN1YHWQJolsgs8O9ItrST01h31U4W4ZhlN7XPJUjSYqcKIJYpRT0wjsxdwZTuoWlwkzQTZS8W5xwoblKX+vbieHikAxGSxwcXLjtsKScmJVCyIcgDY2cM1U2Xx+gcTt+7/oX146NSh5yaqpQIMH8haF5sDzeXFI+FRWvprcGhhnKz7IVMGAzl09RP3tKVQ/wnFvcz6KBgefG6QtLeG+m+8Cr0LTnzaQpAfKs86ncrONY8N8tjaGxvuIv6Y/NuAg2scSoJ8hGHy1QkaCau+bWJAYuM5oUBsgF+iXEw3iN4HlFpTWRafklko5jSt/Alu6Ezrf58KpAJSOujD9kPHdHhsnheELR6ohFz8bruo1bJbhR8rH3aRTTCDqcy9aUtggaRrcgCN5ZuK7MXP3TIwoj0BYhrjg6wX/ZXHZ6i9ZXRjzNPolYcMbhNIOpfy1fAqGQY361tTeAP66GylNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(346002)(136003)(186006)(451199021)(31686004)(30864003)(2906002)(5660300002)(66946007)(8676002)(83380400001)(41300700001)(8936002)(6486002)(316002)(66476007)(36756003)(478600001)(6666004)(6512007)(2616005)(31696002)(82960400001)(38100700002)(86362001)(53546011)(26005)(6506007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTkveWNmeUUzY0lndit3ODFadGlRWXhVckJtcHd1cUR6QnVQWXluOHhLbWdN?=
 =?utf-8?B?TFdDOU5ZdStWVDN0V2hObGRSNE5mNkFmcTVGaG5HNjQ3K2FiMzU1SEtaTGZr?=
 =?utf-8?B?ZnpNYzVKY1BFTW1uemJwR3BHRitLeDMxdXYxTzJUMTF4QVFxZTVPeGo1RHN5?=
 =?utf-8?B?TFlaRlRycXBWOS9CRFNSOVYxMzRObWNualdZazh2Qi81d2k2OUx3aTVBUnBL?=
 =?utf-8?B?QXF1Y0MzL29sMXR4aVpxWDcrS081c0krWmNTOUcwTURWRTRMM1I2U0VlTEYv?=
 =?utf-8?B?OVY0eTNzbjJhM3k2TEpKOUtvUTdmNWRGZnU1VXdmd0l5bDBMK3YzcW5taUJG?=
 =?utf-8?B?SkxUM2Q5aTlvUUJ3aWlQcW5iaW9nTVNCSEFwcHN2M29jV3NWMjRPWVVjbmY3?=
 =?utf-8?B?WTZQcVl0Wm1ockd2ZTR6dk9uWGxxanRRNTdSbDhrbVJibUpycXlhRFMrVVBj?=
 =?utf-8?B?cmxNTkRzYVZxblJTSlNwMnlXSk5KTEdjekd0Q3dmb2JRaVJoYk1FWVdhb3Ra?=
 =?utf-8?B?UEdzSktWNVBGTkUyckYycDFOVHJCQmhOY0Y2MkVXM0VSRFJ3UVJ3VG10aDRS?=
 =?utf-8?B?ZlJicnczbGIza2dxUU4zZFVZRnk5TVkzenE0SWc4ZC9UQ0d5RityWEJLbnVn?=
 =?utf-8?B?djBDZXlFMHRvKzFRK2d4ZDcxc2M4VUpubyt2S1VLbllPdGhpSFRwcEFCNC9L?=
 =?utf-8?B?R3dTSG1oenZib0FzM0Rzd1ZPT1dRalBrSDFCWkVINnc5QU0xMlVvSllCSDNj?=
 =?utf-8?B?SmFZQTFGTytiZXVhVG9nTmhvVVBmU1R3R3hxVkpXTDR3U0IrQ21BUUNuV0ZP?=
 =?utf-8?B?V2VpWUxLQ1ovWXBJUzZKWTYyR29yckJhZ213alNXSVliS2NXSElDeE1Kc0t2?=
 =?utf-8?B?L1lnQlBYajY2MkNRWDFxY2hFUUQxdG1RQk51RjliSVpHYVlBZ1lwOG9qSStI?=
 =?utf-8?B?b3cxb3ZmUk9WMzdmSCt4empXYS9mbC9FaDFwcmg0M3BXQlJhVEtDOVRxWDFp?=
 =?utf-8?B?ZVAxcllEQXVvWXNmTVhGeksxT0tGSm0xU1h5UFJUdW54Q2pLNFB0RDIxSzJs?=
 =?utf-8?B?TFBOTUppUEJ1emwyL0ViSG4zcEJGaW5sclN3N01vejJJNjVhY1VRNjVFQXd1?=
 =?utf-8?B?TkY2T2FqNVJXcE5sOS9yMG5EVUNmL24rU2NBUitxNzhuY3lKcm9Xc2sxWkJ2?=
 =?utf-8?B?MEYwL2ovNk0vbzFOQmZweUFNL1ZwNkVVNy96bGFrcWl4MlRXREdXSWh0Y1lr?=
 =?utf-8?B?YzV1Ry9LOWU4ZVVwcW5BU0JkZm15QzlVMStmVXZZQ2ZlQ0Z5alZ4bklUTjkr?=
 =?utf-8?B?cW5hN3dkL0NUeGFPYTRhNW03ODdhRnhxNVRGUXZIV1VJYS96ZlBhNGFXU1J6?=
 =?utf-8?B?c2RpaWVLT21OOFZUMVprbnY0ZVdnTnhud0FPSTUzZ1lCT0JtbklWU2VDdE42?=
 =?utf-8?B?QzV5aEE3UjRWTVl4NU5WY0U4WitWcStNd1QwQWcxbWQxWnNEWVI0b3VvZWhR?=
 =?utf-8?B?UGtLSnBHdjlqcVRCMnRwV2ExYWEyRmYvQWdYQmlQWjdSUHJZYkk2NXBrMmhG?=
 =?utf-8?B?NmE0MWE1NUZCbG5uS292Y1Awa1M1amthTXc0cWFOSzZ4WHFVMHJDZGdVS05Y?=
 =?utf-8?B?V0dVMGFNUCs1ei9yWGtsMVZmbWZUU3RaL2N1bEJnTXkyNkFyRW9BTjV6SzdD?=
 =?utf-8?B?cFpYbWRzT0dpN3dYRkJmUDk2N3NTUnZpVmEzb1hoSW9sc21WL1YyRDNnNDI5?=
 =?utf-8?B?VlhVRkI1WnV1NWtVQzBBRExkbWEwd3VmRk9jcHRnSFFWQnRqYkhsK2VkWEh5?=
 =?utf-8?B?RmU0R0FoUGlBbC9mZ1p2ZzBBUVhOaGtqMTZDd0tFMTV6M1M4eVVTeGNjM3A3?=
 =?utf-8?B?YjZWUU5yMzV5U2E1UmU0QnRnYzBHMTJlK0NkMGxGc0tFSU02TzRUYnVTU2xY?=
 =?utf-8?B?YmZENXlZRmw4S0c4V3ZaT0lxRm80K0dDeGMwQXNVeDY4OXBYSHZoNzRrbHJj?=
 =?utf-8?B?N2E4c2pOWGZzUE9NNE5IVVF1TStFR0ZYOEdxUncyMFZvajlaRytMOTZ4Vmoy?=
 =?utf-8?B?VWszMm82TEl6SUx1WC9ZeGd1MHZpd21pM1NjcFJ6ZWI3d3JYUzRNV3RtczZk?=
 =?utf-8?Q?zuGCbezdzACL4mIh26HogTo/5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c1950c-c6d4-41b4-4439-08db94778691
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 23:15:28.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcBNhUykgDNWgsiibOVmpW+XT2uopz3A+zomDJNIn7ZJea2Rz6O5fLk/SgWOkC5oiUdX7qsNss7dAK9aMzvumg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4982
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2023 9:20 PM, Ryan Roberts wrote:
> On 03/08/2023 11:48, Yin Fengwei wrote:
>>
>>
>> On 8/3/23 17:58, Ryan Roberts wrote:
>>> On 28/07/2023 08:09, Yin Fengwei wrote:
>>>> It will be used to check whether the folio is mapped to specific
>>>> VMA and whether the mapping address of folio is in the range.
>>>>
>>>> Also a helper function folio_within_vma() to check whether folio
>>>> is in the range of vma based on folio_in_range().
>>>>
>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>> ---
>>>>  mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 69 insertions(+)
>>>>
>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>> index 5a03bc4782a2..63de32154a48 100644
>>>> --- a/mm/internal.h
>>>> +++ b/mm/internal.h
>>>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>>>  				   bool write, int *locked);
>>>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>>>  			       unsigned long bytes);
>>>> +
>>>
>>> Hi Yin,
>>>
>>> I wanted to take a step back and consolidate my concerns about this function. I
>>> should say that my understanding of the pgoff and index stuff is shaky and I
>>> could therefore be wrong about some of this; if this is the case, then sorry for
>>> the noise! But something about this function doesn't smell right to me, so I
>>> figure its better to raise it...
>> No worries. And thank you for looking at the code ans share the comments.
>> That helps me a lot. Really appreciate it.
>>
>>>
>>>> +/*
>>>> + * Check whether the folio is in specific range
>>>
>>> What exactly is the function trying to do? I *think* the intention is to figure
>>> out if a folio is fully and contiguously mapped within a range of virtual
>>> addresses belonging to a specific virtual address space? And I assume you want
>>> the answer to be precise? I'm assuming 'yes' for the below.
>>>
>>> I think the only way to do this is to actually check each PTE. And that causes a
>>> problem, because a folio can straddle multiple PTE tables, which causes PTL
>>> locking issues, and means having just a *pte pointer is insufficient if we need
>>> to traverse multiple pte tables. So perhaps you need to allow for a false
>>> negative in the case that the folio is not contained within a single pte table.
>> Let's check the users of this function first:
>>  mlock/munlock: Needs only care whether the folio is in the range of VM_LOCKED VMA
>>  madvise: Needs to check whether the folio is in the range of VMA and
>>           range [start, end).
> 
> Sure but those 2 ranges (the vma and the user-supplied range) are known to
> intersect, right? So really there is only one range of interest; the
> intersection. I would argue that should be done in a higher level wrapper, and
> is not part of the core primitive to work out if a folio is mapped to a
> particular range of virtual addresses.
>> This range is from user space. It could contain
>>           VMA range (in this case, we only need to check VMA range) or is contained
>>           by VMA range.
>>
>> So we check:
>>   1. Whether the folio is in the range.
>>
>>      To do this, we need to first check whether the folio->index is in the
>>      VMA range. If not, we know the folio is not in VMA range. Just return false
>>      without further check.
> 
> Right, so if the check fails, the folio is definitely not mapped by the vma, but
> if it passes, it *might* be. Further checks are required. So why is this useful?
> Why not just do the check that gives you the precise answer and skip this?
What check can give precise answer? I don't think checking PTE is right at this
stage. For following case (assume the folio is mapped in same page table and just
care about the VMA2 range):

|-----------vma1-----------|------------vma2---------|
                    |-------folio-----|

How can we tell whether the folio is in the range of VMA2 by just checking PTE?
And in this case, why not bail out if we see folio is out range of VMA2?


So only need to check PTE if we are sure the folio is in the range of VMA2:
|-----------vma1-----------|------------vma2---------|
                              |-------folio-----|

> 
>>
>>      Then, we will check whether the folio is in the range which is defined as
>>      [max(start, vma->vm_start), min(end, vma->vm_end)).
> 
> As par above comment, I would personally factor this out of the primitive.
> 
>>
>>
>>      This is the version in RFC as I was not aware of mremap case and forgot the
>>      page cache case. So if no mremap with an anonymous folio, this check is enough.
>>      But we need to add PTE check for mremap and page cache cases.
>>
>>   2. Check PTE for mremap in middle of large folio and page cache
>>      If the folio is normal 4K and if the folio is in the range, it's not possible
>>      the folio is partially mapped to two different VMA. So we are sure this folio
>>      is in the range.
> 
> But you test for small folio and exit early without checking the PTE. Given the
> index check only told you that the folio *might be* mapped, I don't see how you
> can return true at this point for a small folio, without looking at the PTE?
Yes. We can do this. You can check the discussion on the RFC version. I did move
the normal 4K folio check out of this function. Yu and Huge suggested to just ignore
the normal 4K as this API can' handle it.

The thing changed from RFC is that we need to check PTE here. I tried to avoid to
check PTE even for normal 4K folio.

> 
> folio->index is just the page offset within the file it maps (or the (original)
> VA/PAGE_SIZE for anon memory - I think?). And vma->vm_pgoff is the page offset
> within the file that the vma starts at. So you could have a folio that contains
> the contents of 1 file and a vma that maps another file, and the folio's index
> might fall within the VMA, but it doesn't mean the folio is mapped by the vma;
> its a different file.
> 
> Or perhaps there is an assumption in the function's spec that the folio is known
> to have at least one page mapped in the vma? That would change things... but you
> should make that very clear in the spec. And in that case, you can move the
> small folio check to the start and return true immediately.
Yes. "At least one page mapped in VMA" is assumption here. I will make it clear in
the comment.


Regards
Yin, Fengwei

> 
>>
>>      Currently, check PTE didn't handle the case you mentioned. But my plan is
>>      checking whether the folio is mapped cross page table (by checking whether
>>      the folio start vaddr and end vaddr has same value for low aligned to PMD_SIZE).
>>      If it cross, I will treat it as out of VMA range. Otherwise, we can reuse
>>      current check because we know the PTE pointer is always valid.
>>
>>      Obviously, the PTE checking needs hold pte lock as you pointed out.
>>
>>
>> My understanding:
>> pgoff is important if we have folio and VMA and want to know the virtual address of
>> the folio mapped to. Like first, check whether pgoff of folio belongs to VMA, then get
>> vaddr by:
>>       addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>> rmap_walk() also depends on pgoff. You can check the vma_address() and rmap_walk()
>> implementation.
> 
> Yes but the rmap is only traversing vmas that are already known to map the same
> file that the folio contains pages for. (See rmap_walk_file(): it grabs the
> "mapping" from the folio, then traverses the list of vmas within the range of
> interest "vma_interval_tree_foreach"). Its a bit more complicated for anon
> memory but I think the princple is the same.
> 
>>
>>>
>>>> + *
>>>> + * First, check whether the folio is in the range of vma.
>>>> + * Then, check whether the folio is mapped to the range of [start, end].
>>>> + * In the end, check whether the folio is fully mapped to the range.
>>>> + *
>>>> + * @pte page table pointer will be checked whether the large folio
>>>> + *      is fully mapped to. Currently, if mremap in the middle of
>>>> + *      large folio, the large folio could be mapped to to different
>>>> + *      VMA and address check can't identify this situation.
>>>> + */
>>>> +static inline bool
>>>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>>>> +		unsigned long start, unsigned long end, pte_t *pte)
>>>
>>> The prototype looks odd to me; Fundamentally it seems to me that you need the
>>> folio, start and end virtual addresses (the range you want to check that it is
>>> in), the pte pointer and the virtual address that the pte represents. That
>>> virtual address allows you to figure out the offset between the pa and va. Then
>>> you can look at all the ptes to figure out if they reference the folio's pfns,
>>> and use the va to pa mapping info to figure out if its within the specified range.
>>>
>>> I don't really understand why the vma is useful.
>>>
>>>> +{
>>>> +	pte_t ptent;
>>>> +	unsigned long i, nr = folio_nr_pages(folio);
>>>> +	pgoff_t pgoff, addr;
>>>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>>>> +
>>>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>>>> +
>>>> +	if (start < vma->vm_start)
>>>> +		start = vma->vm_start;
>>>> +	if (end > vma->vm_end)
>>>> +		end = vma->vm_end;
>>>> +
>>>> +	pgoff = folio_pgoff(folio);
>>>> +	/* if folio start address is not in vma range */
>>>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>>>> +		return false;
>>>
>>> Why is this pgoff calculation helpful? Surely it's only useful if the folio
>>> belongs to the same file that the vma is mapping? Otherwise the folio's pgoff
>>> might be referring to a completely different file than the vma's vm_pgoff. So
>>> you will get spurious results.
>>>
>>>> +
>>>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>>> +	if (addr < start || end - addr < folio_size(folio))
>>>> +		return false;
>>>> +
>>>> +	/* not necessary to check pte for none large folio */
>>>> +	if (!folio_test_large(folio))
>>>> +		return true;
>>>
>>> I don't understand why you don't need to check the pte for a small folio? As
>>> above, if the folio doesn't belong to the file that the vma is mapping the above
>>> checks seem wrong and you can't conclude that the folio is mapped in the range
>>> without looking at the pte?
>>>
>>>> +
>>>> +	if (!pte)
>>>> +		return false;
>>>> +
>>>> +	/* check whether parameter pte is associated with folio */
>>>> +	ptent = ptep_get(pte);
>>>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>>>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>> +		return false;
>>>> +
>>>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
>>>
>>> I think this could wander off the front or back of the pte table into arbitrary
>>> memory if the folio is strddling multiple pte tables.
>>>
>>>> +	for (i = 0; i < nr; i++, pte++) {
>>>> +		ptent = ptep_get(pte);
>>>> +
>>>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>>>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>
>>> Doesn't !pte_present() also cover pte_none()? So I think the pte_none() check is
>>> redundant?
>> I think you are right. pte_none() can be removed here.
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>> +			return false;
>>>> +	}
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +static inline bool
>>>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>>>> +{
>>>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>>>> +}
>>>> +
>>>>  /*
>>>>   * mlock_vma_folio() and munlock_vma_folio():
>>>>   * should be called with vma's mmap_lock held for read or write,
>>>
> 
