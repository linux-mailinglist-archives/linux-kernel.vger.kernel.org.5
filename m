Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B07767FCC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjG2Nzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjG2Nzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:55:45 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0A21980
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690638943; x=1722174943;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kBJsMgSr1EpJI6GC3RmcdZ0iYg+0kUyJL2MSr1zw1mU=;
  b=kHUPtcthcs6fdIJvJRy5QxtIlKvnD7qm3ZAw0mSa0nB+gWeIcxGhrEzE
   3MXi7nY9F4eAPTAoQYD/jYs2sB0/Gq8moH6jHUqpw0UeTV1uJ0KWhYEN2
   ZoLFMetpjLHvalGoMedun1YmXbOH7Zy7Q6VxPq1e1uc6an/dZYVbEA46+
   GW8GKYHcV/WNtMShTqWZl0i8Mp4lQZ4iNGkNHlDQUinYuakGW2iHOUpMG
   Dd+yL9g0gY/Pv5k9EbZ0QZB5ZtKrXO1EUdeCpUkf07N9DKU4Ra5ZZB5E4
   7vkfYcymo2vZvYCGq8E5Zc7SzqClFHZFphpdDUUYMAbVOOSBMh1uUFLHw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="366233132"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="366233132"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 06:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="974402884"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="974402884"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2023 06:55:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 06:55:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 29 Jul 2023 06:55:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 29 Jul 2023 06:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzkLik9mFs3YVGwky6eMOoItBorfYblETCACIj8Pkijt7bpY24RPHCD5zenDHn46Xq58S9E9NNv+Z4QI5ARnnkbPESWu6fW0LlNvv35LID6BX9nB/+3HfxWNxd4zQKIasWx2b1Fpdcf8KotLFAv3yumhFlqwsLjLY+nPnioB5ru1WohbTIeqEO70wOVsxQPHLRLngyXJh97/chYakhqUH/cOSQFNH7M1rhhvEBcHZ3wQj7LIKkHgeR7lddF27ypl3lkXLxozQHpe8QSPp3YmG4w/jVjFdERDB9681PZ/iu7gogqawLSdGqKMICYu7MO8WKbmG2jgiknfR4ioPbAVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRiRfamemMACO0eEDtwQIrv1oxhnc3mN9N+YrK6iRek=;
 b=ehU2oflqUImPr1JZYrh46pDWoEU1u/73fUydUeI8SCuWJtdMbcaFSFW98ZJwK5DP0G+IqXCs7lZCdJVr8M1eUqcqKpAWKnri6vl6XHzBi2ERcKp3MebeUZztkxWHIR5KWGzQsKFTUKXqiw5BQYHliO9TnsZkKEjMJuP9Bul++zq0cLSlu9ls4UyVsVYIlt591LJ+aVlzdf0Ub6HVz2JprwpQh4pHId25Zrg52amFSwHsBnZbGsZRm1eg/vm6sqXCwd8AYwxKwrkM44jfyR3sMT9N5yEFC11PEtB0wPY1tqvScD8Im09TmVD8KKaVHGoGvVB+RFryhclb9q1DX6c6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 29 Jul
 2023 13:55:37 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.039; Sat, 29 Jul 2023
 13:55:37 +0000
Message-ID: <58dbb25a-690b-754d-0f37-ff26876bc373@intel.com>
Date:   Sat, 29 Jul 2023 21:54:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <david@redhat.com>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>, <hughd@google.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <20230728113412.65741d2dd23228d0e2c0cb8d@linux-foundation.org>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230728113412.65741d2dd23228d0e2c0cb8d@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: bea72223-5cf4-46f4-032c-08db903b7cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ath3XzGmsOQscnHvmnIlekKMOY5anSprox117wN1CPprrofL5uH4k2ifitRV1/nTIrt0q1xb7z+yV5xdHFOzePM3H/YTTkwd3mDT/O8KRE8liWJ+rUxLOwlChNI0cpAVO2irz1vcY89IV8g815r+RWfRtHgwTQ13AspDwCVhFHf2iDIPLFzFOb7H47HQ+DptMVvscjt7bZwZbs5WeH4RlKfcYGp2cdxLFTZa9y8iZVkGzI2VXSdKu1TC9b3ad38I5zaPgBmSf6k0PaCn0YcieTOhcyGhQdOx4BM8t9R/+L/kkScDxGPhFKXUlJ8ebC9DZ9ZS+HAK6JrFG6ClwpYRC/WQIgBNdMPxN8ew5mcjkyuEMDWeLM3QGzJIi4f5uGiTB4lChMYonj9nDTMxqxCdb4q9XUDNXAy7mC3KiYIL1aeLf/ZF6ZWyS2fWzmdqoYbOMpXoUB8If1Xawur76jcUj2IbzAxTfcZGTV/UNHBVJGi39oYBCAFXK/s69tJLPIRsInot6F99IeNdkbVUqYta+9lWDTpsFGtdGXHgPfVyAXgNyZseV1bMmHnB762oJ+ps+IqAL9XiDnl3Oo26vdT+qGEnoVt1YN7W3bjwd60VCzIuYxPowludi6s3dExOY3YQttZHm7uAW8odaoV8eBIv/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(82960400001)(41300700001)(31696002)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8936002)(8676002)(31686004)(38100700002)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzhkZ3M3S3JQSU4vQmM0WHMwUm1UMnVzeTRjY3N4RUt5bmJlRzY5MGxncm1O?=
 =?utf-8?B?MWY5UFd4SE1vdjdhaDR3T29QWnY2aHBLdUFzcU40aHpxa29nWTBlUC9uTFA0?=
 =?utf-8?B?dE01OXhtcThSaWVZaC9mYWFacjNGMnkybExGQk5QbUpCbVFqMjV3UHkzbzBY?=
 =?utf-8?B?WXEzQkQzM2dmbTZSeGszWnNZNnZGNXhkUkdwUEdEVkJHQmxRcEpmSEQwaUVx?=
 =?utf-8?B?REo2VVplMlVqZ2xJT2JDR0pNam1ZVTZlMXZZb2NXcStQM0tIWjFTcGNVbkd5?=
 =?utf-8?B?Qmt4WmFxS3VRa0dvb1B1Y0JNNVFIUVdNWlQrbEprSFdNdXdWU0VuRFRMcWpC?=
 =?utf-8?B?clRIc1VSOC9FUXVBK2tLOW1RTENscVlnd1g3eGZ4cVFHSnZDVHB5YTE1cFlh?=
 =?utf-8?B?YkhpeFpIUS9Ba0RQdXd4azJ4WFVKdy9sNnJiakQ1ZHdLZkVPeklUMkF5QmNT?=
 =?utf-8?B?WGZFZ1prZnRVT1QwY2g0WjNOTTI2QmI1NWdpOEpqZ3lhMXJmaWVvN3lPZ0ht?=
 =?utf-8?B?L1lGM1JlYU1xOG5kTGhDQ3p6UXJvWTljUjQvdUFmQmtoeXVWN2plb2Q0bVdW?=
 =?utf-8?B?TWFsM0N0d3hhK0MwMlBCOUZ5MnE0V3p5djFhc01lNWp2Y2VNL2VVczk1aHBm?=
 =?utf-8?B?aGZudWVDRlJ0SzJFNlBDY2QrQ0RVNkZuekY3anQ5eVI3ZjUxRDRISmlPM2lk?=
 =?utf-8?B?Y2hsYjdDWUFaK3pCMnhHTjNMUi9KcjE1ODMyOTl3QmJzQU1JMHpyU3RLVXVh?=
 =?utf-8?B?NjNWcUZjYStLS0ZrcStaSVNqSlVKMFdUN3lGRXgrSGh3aFpRakRXVzBuN2hp?=
 =?utf-8?B?Q3Y5NFpZY3I0dFMwS1QrclYzWDBTVWsxRlhubHpsYkdhV0x1THBPczJpUVdL?=
 =?utf-8?B?OFRoRUdYNmlxVldFb2psU2M5aUlKMUF6eDliV05RWTR6cEJNMWdHQ1puQVFq?=
 =?utf-8?B?d1Z6T3I2a3JQRlZldW85b2VuRjExWUxHWUFqWkhpeTQ5UGtWVTN1MEg0MW5R?=
 =?utf-8?B?MHBGM0c0SWtKNlMwZjNic0lxdTlINklzUXZlRGZXM0JFZXA5YU93T1JWdkNX?=
 =?utf-8?B?SWRnNWFNamZlYkU4NjEvb3pvbFJjeXFWZ082aUxCRnppcXBxclJPbzBzZE1I?=
 =?utf-8?B?eElZMHBNMFNtWkloUkswS2EzTE1uOVpkUnJnT1BTRXJ6QmNhSk5FN3g5OWsy?=
 =?utf-8?B?ZDc5T0VveHdpRkpHYzVCV0lIb2xtYTcvcXZOY2NwK2VYMWdRZnJab2ovdUta?=
 =?utf-8?B?a3d6Qlo3RmN4UlY5dFdTNy81K25nbGZ6WTg4ckhuWHRvTFFXWlg5Qno1STlk?=
 =?utf-8?B?TmJZYjlqVjRycklUUzZrU0RYajVFYzhSbnpTbGhlOE5mUUluR3YvakQ4QVlG?=
 =?utf-8?B?QlFkSzNUWkVEalJycVYrWUVXUjBKeTdmYmdzdWhuWjJvcUJzRERUUTc1bUlk?=
 =?utf-8?B?d2dKMVNBYkxMNlY5VUErV2x6WEd2RGVGR3M4L3o1WUcvaFpNYmVaTnlJOFhW?=
 =?utf-8?B?Zzcwc3U0VGpyTTFLcUhuZVY2R0krMTMwZmJXdStpYUpndlJoVzVhNFVpdVFl?=
 =?utf-8?B?N2hXOGJtV3BTVXFLNFFyaURBSjZiWGNnbGdJNDh1ZGZPbVhMRzlXVkZHVlpK?=
 =?utf-8?B?MXF1VHdCWXhLNEV0Wi9Ha3gxTElJbTVBY2M5MFROWHhGblAydGFKbngzUXgr?=
 =?utf-8?B?T3VJU3IvcFpvSnp3SHF0Tjc3eW5MamFuYzFRR0tiemtRVkxzVy9QSXVxTlFt?=
 =?utf-8?B?L29kbTFkR3FMQ29MenBuc09SQmJEL3FoOUZ5RlpDWmpBV3NKa3NCTisyRExp?=
 =?utf-8?B?OE44ZHNqWVhkRzhERzl3R1hRcXZuU3E1VmFHWHlEN0ljUlVpdG9ZYlE1ekQ2?=
 =?utf-8?B?ZEZqaS9ZWC9YSTdkU1NSQmNhWERGT1Z1QVpkak1abFU2RE81ZkpUYlhFTloy?=
 =?utf-8?B?UVl5UENEaG1rek5FQit2SENCdE55Zkl2VXVHRFlyZnozU1RGSHczQ2JBL0xM?=
 =?utf-8?B?azcxUXh4N20wSjRtQTJDbzQ0eWZuOEhHU0NkcGFqWDA3aGJRTnVYS0lTbUwy?=
 =?utf-8?B?anFpVi9OOFo0WjE3Nlk0MEMrM0dJV0hPNnU2VmdRV3ducVE0QnhSVXlPV3Zp?=
 =?utf-8?B?NXhlMnZ1Z29Yd2VrRmtYV3J2SUZkYmtkcXVBQmg5ZHFXeVladnpjNmhmUHJy?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bea72223-5cf4-46f4-032c-08db903b7cab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 13:55:37.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjP/2ukbyuXWobmPlCK94d0fcoJnE8Hw3okr3SlD1NHfwTeyCqjkl+WxpyRHM66iqkLm7sSBPunbqALN1/351w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/2023 2:34 AM, Andrew Morton wrote:
> On Fri, 28 Jul 2023 15:09:27 +0800 Yin Fengwei <fengwei.yin@intel.com> wrote:
> 
>> It will be used to check whether the folio is mapped to specific
>> VMA and whether the mapping address of folio is in the range.
>>
>> Also a helper function folio_within_vma() to check whether folio
>> is in the range of vma based on folio_in_range().
>>
>> ...
>>
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>  				   bool write, int *locked);
>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>  			       unsigned long bytes);
>> +
>> +/*
>> + * Check whether the folio is in specific range
>> + *
>> + * First, check whether the folio is in the range of vma.
>> + * Then, check whether the folio is mapped to the range of [start, end].
>> + * In the end, check whether the folio is fully mapped to the range.
>> + *
>> + * @pte page table pointer will be checked whether the large folio
>> + *      is fully mapped to. Currently, if mremap in the middle of
>> + *      large folio, the large folio could be mapped to to different
>> + *      VMA and address check can't identify this situation.
>> + */
>> +static inline bool
>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>> +		unsigned long start, unsigned long end, pte_t *pte)
>> +{
> 
> This looks crazily way too large to be inlined?
Oops. Yes. You are right. I will make it not inline in next version. Thanks.


Regards
Yin, Fengwei

> 
>> +	pte_t ptent;
>> +	unsigned long i, nr = folio_nr_pages(folio);
>> +	pgoff_t pgoff, addr;
>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>> +
>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>> +
>> +	if (start < vma->vm_start)
>> +		start = vma->vm_start;
>> +	if (end > vma->vm_end)
>> +		end = vma->vm_end;
>> +
>> +	pgoff = folio_pgoff(folio);
>> +	/* if folio start address is not in vma range */
>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>> +		return false;
>> +
>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>> +	if (addr < start || end - addr < folio_size(folio))
>> +		return false;
>> +
>> +	/* not necessary to check pte for none large folio */
>> +	if (!folio_test_large(folio))
>> +		return true;
>> +
>> +	if (!pte)
>> +		return false;
>> +
>> +	/* check whether parameter pte is associated with folio */
>> +	ptent = ptep_get(pte);
>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>> +		return false;
>> +
>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
>> +	for (i = 0; i < nr; i++, pte++) {
>> +		ptent = ptep_get(pte);
>> +
>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static inline bool
>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>> +{
>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>> +}
> 
> And this doesn't.
