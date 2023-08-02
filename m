Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B68676CF1F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjHBNrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjHBNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:47:15 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FFEB2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690984033; x=1722520033;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AE4gp+Ycx9uXPGdvaMddL9xXo2oOxGGPpRKIVchEkgM=;
  b=SOgj9EPTemK/vkE+yNiRgKxjkKwQhYpTRXhOIWN2ppBGeUrU1BJdtGNL
   tixp8KK01cMVgH9+21XU0dIhy8CZHy3BQBUyZSXdL1wO85amYLYbP15jV
   2eAGuaWZjH/DDv6V6kEh1ORgLmjKe2mElkcSxHfu/bHbde2lC6GQwV/Jl
   vLVTR78rtrQ5OHC7zZPM/erQTxN9V6lnZ3eX90RvgxAF6D66JsZHKzAc0
   ESf9pDnhmMH8PPIUlU0C4lWhXRfgnpaUf3s3GChfneEtwewR6pzYsJG52
   0r9gz8g6O+GdmyncxvS1lNIGXFevjI93nlcPNmWHVUvJNG31xawj7OrA0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="373227291"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="373227291"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 06:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="764225644"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="764225644"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2023 06:47:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 06:47:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 06:47:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 06:47:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtLkH3UVDJRZ+QP1LFSWmN4XwJyJ8vxSDxuknCvU6mXkAfmgPOqmU5HqSsthujOcE5WF90hG5Lk9GFWkkdAh02c+Kzh5WujXhQDSH47xcNY5lFWVvQdQ/mO7LQV4yw5eW2UkaKh7W07bFSAMx2nBoDQNu1fwM+EkRuJVWQRFyUIpGHHbbK5o5BZDbchLzM6r1DcCmljwBgsh0JtcDgWcqoAt5nrZLNZlbK1yAEp6BUg6veC9rHZ3puajhi7IWHavZz/nMXoQaOotztTJ1b/8ye+4G00zOovwrBipVAlo+dC4i0dp7/dvDlMTSYGE8vkpfU+w0f/3O4DIMm+8o0p0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epi5k72rFSFbULdTHs6OVLmj6mQgTyQsIApppgNuZgY=;
 b=C1ek1Qkc+AhXdNh2bAnLfP+NiHpLOjdeDGxreVeYJi6t9uj+FNfyZ/mECV7pup3RdQMUxzOuVuLRU6diSksxXrjNtAhk+RX6skF6z/KWPmH2/mHiIfQ7gzYjHmv1SDpv/LdP7HK0HJ8jpTpBvnJ0g5P2agcRmro9Q0pccSRlH+MA4KKGWH6bsprY60f1E86lddbSpL98ERH1lI4EzjWS7+MFfDS1qkpu9tvSTp9R4ZXdu4sUC8Qcxi30UO14ZvvtlEEPj/7V1TqPkDagzTNh1xXXGZuu8qxiaytGcArvI/3hB+FFZIgYREdfBi7whtryYX2z+ippxeVt5luTqQnNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB6842.namprd11.prod.outlook.com (2603:10b6:930:61::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:46:58 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:46:58 +0000
Message-ID: <286cbca6-ab5e-ad06-ea2a-89ea08ee53d4@intel.com>
Date:   Wed, 2 Aug 2023 21:46:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <david@redhat.com>,
        <shy828301@gmail.com>, <hughd@google.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <55c9e3f7-099d-6f57-32da-1f318a9688a0@arm.com>
 <eb50a427-3738-c1bb-b8cd-8636902deffb@intel.com>
 <65a36b41-d69e-4072-cfd2-253ed6e4e040@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <65a36b41-d69e-4072-cfd2-253ed6e4e040@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 431c1328-49fb-4dc3-6df2-08db935ef0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFO3zM4soUgNe2vDKbw/5E02s+ykKET8ot52R0fx60AauvvgmMSCl1/069Rp8xTo+LvCTc3ctPhjCMOiJ0d9cpC0Wd55guj1Ohu9pAG168UBHZrPevYVS0bBEpXUlmeBbaVd51M4smWFLEP9zUWy6dBUfmRAC6hj32xu4w9P2StsVjGTp2QxdTUMfZ72BwTmu0WNh5sV7K5u3QGBgPFYpmq+fqr16P6pkjOK4TUxpyHWWoyF/T0os/xgoP1yoe2jdpEh7kjJAK9T0Oa8jwZzkpDAo9tIJgx6XJfqnjB2vnp71RazC780NlKMVc8a5hmH3kmV8dCJ52GwApoqQyzMBxF0g+n+ssJHn21yQk/BM/81DxV7Bi7XFvY6TLPrRuYLBJKOxcLHqQN6C3nnSSC/Rip5r/r4OD0H2fodV3umPc1bLTReRNgp8LgAY/9Wn0zRwDD0qrEDc3l9ZCBwIzyKmnFkr11sLaL0hkbiY2riAitlDhSpZ4Xc9MBWmlJjVCpjTzIwmDYxNml+H3MG8njUZ22IZnBekJsIHAfSCH9WyQlFIAkB/63Q92l6RoPPT4lCGqVE9SofR4kmg3DIixLho8W4NNzlhWUOe9pWPiAtuVtKyFC7AWq6X8jo8JzBP9sg90qvPW1wEa13f4BIK3Uh/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(2906002)(83380400001)(31686004)(36756003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(53546011)(6486002)(66946007)(66556008)(66476007)(6666004)(31696002)(82960400001)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW1vcFNJV1dKR2hycTAveTRBZjJoS0NzSytWMHRRT3FNNEdzWUxCS25QMERE?=
 =?utf-8?B?RVpNY3JiYlJqM09nS2xUUHUzL1hLZU1mdTJBY3Y5ams4dVF4SC9EZENCR3RO?=
 =?utf-8?B?QlI5bFVNcVpmbVRhQ3BrK2RmT09IczBBS2hKeDZIZmRJSmhwb055M3o1R3Vj?=
 =?utf-8?B?QnhPQnpCMTMvZDlSWmtyUWRsdkNtMDFMZXJzWGRaWW9jc1dGc2FGVkRJbDhY?=
 =?utf-8?B?RFpwRGtVZVQ3dDFWR3RoOTAxZC8vazFzNW1SUklOUHBwbEVTNVNyb281a0M1?=
 =?utf-8?B?RUQ4WG1iUWZKbUZHQk5waFlCaEdrVjl0YkhZK0dldkdMNVNiVlFraVZmdDF0?=
 =?utf-8?B?MjVVbWZrMjI4QS9LUnlxZ2Jhb0dVWmUxR0lsRzZEZHJiOVBrVFRHbGpzdFhJ?=
 =?utf-8?B?T0VielphSXhpSGprNmJPWXVNZjhGcEhneVY0S1F6T3UxZG5MUllTYmlzTFJE?=
 =?utf-8?B?TjRHWGVWZ0syeFAxanh1dVpzbGVYaU9sUEVFMGQwR2VkakRkVVM4b1JQL1hQ?=
 =?utf-8?B?MVdLT3ZKS0FaUjF6eGhlZGcyQzZINmxFMmsvRlRmcjRIM3lIWkdYSjZuU3RE?=
 =?utf-8?B?d3Y5Y3ZvRW1JdnUvUzg1Rm1WRjRLczAxdGNVTTdHUjI5djFpRG41THNvdFVX?=
 =?utf-8?B?blYzZjI1MnBtNlJsaGRIcHpBb0tiZWxZZVFOTzRta2x6WE1pQ29yZnNSNFlK?=
 =?utf-8?B?eUo3R3RUdTh5aWJjSUQ0Y1RDcmVOcXpzajF4MFZMTWFIQ3lraWcvclVwUEpy?=
 =?utf-8?B?UTlxOUk1eGNxanQ4T2NScFpXcHEzb0l6S1BTRWxIOVRuemtjN0xQalBVOU1o?=
 =?utf-8?B?T0o0Tkdsd0NlcVNFSGZNcmRpY3lOWXpmVjcwNnFrRkJIcEc3Uk9PbjhWOXlP?=
 =?utf-8?B?MHdzRCtMYUtaY0p4VDFwQW9XaHBEUENQOVUvcnp6Tzg2SVpjNUgzemtHYWpQ?=
 =?utf-8?B?em1zWWhwSVlXdU1RaTlna1M5UzRwWkZ3aEc4eThsN1ZFZUp5U01DdEh1aWNi?=
 =?utf-8?B?L1RkNTNqNlJFdytjLy9Rb2p0MkVlRjc1WXgyRlZjRUNBVUE0QWhFTWl5d200?=
 =?utf-8?B?YUJzUU9UNzZGcy9vU1JleU1UdE1QK3Y5bUJ5S0FHNVFWYnBSdDMwUWQzcDJq?=
 =?utf-8?B?eWY5TCt2M1A5dGJhL1ZXcDhQTVd5OHQwa2ZhWDhhL0xUNjVVdTJDeHlpOHNk?=
 =?utf-8?B?RVh6STJsT0UwbEphNSs5a05EYnBrRm9FRTNORVVPc05wUUhUUkxsRExNdHhO?=
 =?utf-8?B?bVJWem1xVlJmZjFDRURtL25wNnRGNFhMc3loNm5sdkxRSWhxMXFnbk5mTlRl?=
 =?utf-8?B?emZteE1icGsxUVl4bFVmWUVzd0VwSEpKRmdxLzZFMEFxOVU4VTIvVUpSelFp?=
 =?utf-8?B?eHhMUDF3Zlg4bWpUKytISENaSU9rQ2RxNHhic0Ercjd0TzVMY3dVVG96bWFx?=
 =?utf-8?B?clF5N1ZuU3hzL3dzNTNUVXdTTWp0QVRNbjQ4eW9Yb3UydUtjV0xPbWJtUWJq?=
 =?utf-8?B?UlVGNkZNS3M0ZGNUeS9lY1c0enQ4c1g0Z0FpWGs5UDBDbWFqLytNb1lKV21J?=
 =?utf-8?B?MXByNGtJOUlvTElVa0R1K2xQVTdPak5VM0FhYm40cHY3b1lNMGd2Rm1jN3Ex?=
 =?utf-8?B?ZHVBdGZZQzQ0Q1pCblhLOFZ1UXV0TlQwSk5UdVJEOGNSNU9NMXR0ZmZQYjdt?=
 =?utf-8?B?TFpDcllaU0xoMXZpdmorZlBxeFF3RXBhQ0FGZ1U2dE9qZldKd2FkbU95MGFW?=
 =?utf-8?B?VWI3NXNIaENaYWlNTFZlRU9WRW4yRS9UQ0hsRVNGckRPbFIwaHNqM2UwOVo1?=
 =?utf-8?B?alMxaHMvZU1ZOUNGTXBWQlpHanE0ZTRUQ1Z3U3RmQUdRRm90WEpGeXcxLzh1?=
 =?utf-8?B?eFk0d1Zyam1ZNllBbTgyS0xhc3RuMWV4aVd2OHBWQmhWSEVORC9qZTFDUGJV?=
 =?utf-8?B?a0dxZGp2WmpUUTFqaTltN1d6Y1hwejR2MW4wVDJjMWl4Q1B4ektrQkZzVG82?=
 =?utf-8?B?NVU0YnJJZ1R2UC9yd3JwVWdTY2pCSXJSMFNNUUdmcCt0QXNZS1Zkc1JZZFlC?=
 =?utf-8?B?dG9VQlBMeVpJRUhWUUY5UkZPTUVWaWI5RWc0SC9sMVVONms0ZGFSMEdkZVcz?=
 =?utf-8?B?d2J0Q1ROTkFzUHd2dlRZWWI1RmtBQ0FPK1NQNTZvaXAwOGpJRllMd0haSG5y?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 431c1328-49fb-4dc3-6df2-08db935ef0ac
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:46:58.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RKJ7mD8UoC8XulsqC02U9Snc2oOx+x8XRCNiTvjihpkL/1EQWnK3gvIfiaGGoadaIHnDW9jJu485Um0RriffA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6842
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 9:09 PM, Ryan Roberts wrote:
> On 02/08/2023 13:50, Yin, Fengwei wrote:
>>
>>
>> On 8/2/2023 7:14 PM, Ryan Roberts wrote:
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
>>>> +/*
>>>> + * Check whether the folio is in specific range
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
>>> This api seems a bit redundant to me. Wouldn't it be better to remove the vma
>>> parameter and instead fix up the start/end addresses in folio_within_vma()?
>> My understanding is it's necessary. As for madvise, we need to check whether
>> the folio is both in the range of VMA and also in the range of [start, end).
> 
> But in folio_within_vma() you pass start as vma->vm_start and end as
> vma->vm_end. And in this function, you narrow start/end to be completely
> contained in vma. So surely there is only really one start/end you are
> interested in? Just seems a bit odd to me.
madvise() will call filio_in_range() with VMA and real range [start, end) passed
from user space.

> 
>>
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
>>>> +
>>>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>>> +	if (addr < start || end - addr < folio_size(folio))
>>>> +		return false;
>>>> +
>>>> +	/* not necessary to check pte for none large folio */
>>>> +	if (!folio_test_large(folio))
>>>> +		return true;
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
>>>> +	for (i = 0; i < nr; i++, pte++) {
>>>> +		ptent = ptep_get(pte);
>>>> +
>>>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>>>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>> +			return false;
>>>> +	}
>>>
>>> I don't think I see anything to ensure you don't wander off the end (or start)
>>> of the pgtable? If the folio is mremapped so that it straddles multiple tables
>>> (or is bigger than a single table?) then I think pte can become invalid? Perhaps
>>> you intended start/end to always be within the same pgtable, but that is not
>>> guarranteed in the case that folio_within_vma() is making the call.
>> If pte is invalid for any reason (pass wrong parameter, not fully mapped etc), this
>> function just return false in page table entry check phase.
> 
> Sorry I don't think this covers the issue I'm describing. If you have a
> pte-mapped THP that gets mremapped to straddle 2 pte tables, don't you have a
> problem?
> 
> example for 4K base page set up:
> 
> folio_nr_pages = 512
> first page of folio mapped at vaddr = 2M - 4K = 0x1FF000
> 
> If you then call this function with the pte pointer for the second page in the
> folio, which is mapped at address 0x200000, that pte is pointing to the first
> pte entry in the table pointed to by the second pmd entry. The pte pointer can
> be legitimately manipulated to point to any entry within that table,
> corrsponding to vaddrs [0x200000, 0x400000). But you will end up subtracting 1
> from the pointer, intending that it now points to the pte entry that represents
> vaddr 0x1FF000. But actually it has fallen off the front of the table into some
> other arbitrary memory in the linear map. 0x1FF000 is represented in a different
> table, pointed to by the first pmd entry.
Yes. This can be an issue as hold the second page table lock can't prevent the first
part unmapped. Let me add another check vaddr align to folio_size in next version. 

Regards
Yin, Fengwei

> 
> 
>>
>>>
>>> Also I want to check that this function is definitely always called under the
>>> PTL for the table that pte belongs to?
>> Yes. I should spell it out. Thanks.
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
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
