Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB278064D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376457AbjLFB0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjLFBZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:25:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E258DD64
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701825950; x=1733361950;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/znkgoquJKmMIlqHmV3YaToUK7JJ4DZA89Oa+q7EQU4=;
  b=DzPRrGjaWjsxebHT1StN/tSGk0GqGQBFzRusmPk28g1r3ymNXfY2MTXc
   rPWWgu99bUqDCoNQeTNfSHBeA5BT9jiYn3vDPoFk4iB42maKxRMpXGa4h
   j1fQKlvFjmGaKM1yxbHyAlOqSZY1AhqYpMmAI8p8ZkInbGEaU4LbUkffx
   cj9ASZZWwPd08vPvnGZz9uXJb+SXfQkXlQNHg6VJQQspSe+V+JcIhbOUp
   4413i4JzaWKys9UGwC8NIVQ7WHB8Tjg4k+X1fs32pev6733ZHJHiwYHdm
   OV4iQg56/VSWNSr3UUAkX0CCk7x+BRxz1PEK8OBS2XiNuS48b/gsCbixC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1051500"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1051500"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:25:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="764528519"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="764528519"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 17:25:48 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:25:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 17:25:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 17:25:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7JZiGAcV2ltwOJ12d4f9ZPh2Cg6iZ8HP2ile8S4gOdz+H0D/eNRj11jBmaJWJTH9alQfz7Xz3/fViNvLfj38jlMwX28PuGZc3f2sdATganVCvOpRYrGRX3i7eHSQ+lodVVGAGw8CdI1bEoDD0dnDPNuIburoVAH/2kV0+VH+3SDlwZRiTD7aST/7/tkjPJQzBx8ZctAWikhLMCP8hLJ4BdulSvQlzyC43cMhaxzIIw1y/pVToLfNz1Neb0r7+tpSLYfRD1icFA+kiYh3Ak1Aou//bnv12bceYt62TG9051dOH7tOBsUxnoWzgmpmTPPJ4j3kNIrMBWAUnEHmE7IEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhdVUT8Ebl12HF4GeMYOq5VjDq+F/Wg24rV7N0AA8hA=;
 b=Gm3zbWY0nK2xhnS41TMo1QjsOP4WG4unBRqYfDpgeOCFHkFD9FcdIAiBKlJQNCu+NvdhtDYFuoIBcGi9qlQizaoc1QZiepP1rFYrWdvuCc1ULsVYYYSNlf1tjtwS71T9zalCxL2nvPRcUhSND+0njSi9E1S7Dpf3Uq1DhWO1ZL7qqngWoKa0FIdJr6H6khbbUSD91kDE6Zj2U8EFKaqPaHndDXTdlKLdeYANcgIYp4n1Jt5z1dWBrXHT6UdkhnX8UND60S8FMvRg3CYRJF1kVs1KAuypvK3v7ihvwmvYflkTzLlJmg7cz12qDqRdPi6eggDIOFVobwmbkStZNXmlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 01:25:45 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:25:45 +0000
Message-ID: <17c69db0-a796-4a3f-95df-5f965af35ba6@intel.com>
Date:   Wed, 6 Dec 2023 09:23:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/39] mm/rmap: add hugetlb sanity checks
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Ryan Roberts" <ryan.roberts@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-7-david@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-7-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 9046ace3-3147-4fbb-89e7-08dbf5fa44ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7AhQCWaPYi13IGO4+b99ds8WV/gC3y35x11+gMbglNi4JbFZrJOzrlb77mOx91YBJSeAx59h4yNTQnwC38VoQQjy+ZFyj43nNqSmD/T9AtBrXwOvFbyEUV2oNyoYU/N0Fw2ahF+8WnT0IoZVAij8o54YxrfodAuUR6r4T1SUMjuHRLFfEHH56m9Z3N523Wr+QEtsmG6BATROmWKK0NkjW/0T6uPPZ3JmmZ3IoSF2gYIpR46bW0wZEOWhAMRcmsa7Wx5eudfLuJaMj0tjQs2FhM9kD/Z6PwRKsvfs8CJd6d4gBZVovmqHE/lN24hbuYt7AdY33j6aUsnswiGjclrOFi7xtp9U44j/s7xvs0c957b6hkrTRYkFAq+2pi0ipG4UjDpvLFf2HnD0+LWGRUxrurqnI31XOCuNnqc7CQqBpZlDw+H6gB8lrEpkwFjg1E+xeFe1OtN9YsIuC7VfKw9v/sLN7cO+mP1ovrMz7QrPOQqEH/ZTCusH3bGZ11WyFC+pIkL0Aq4FMEvVZt9qPjHWgJicuRfdtmxGCjFddguA5hwFzAOGqdvWodRgaIX1In7Z9+0riUuubOCA24P0SFva5PQBMZzx+58jqfYgdk0Xhc1G5vYILcqMVauLKy6eCsl5yhXTxy/gQ1Nu+NdHx0Lhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(82960400001)(31696002)(36756003)(478600001)(6486002)(2616005)(26005)(6666004)(6506007)(53546011)(6512007)(8936002)(8676002)(4326008)(54906003)(66556008)(66946007)(66476007)(83380400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXFBcFlUcERqZzhxMlJ4VHJsWVZNY2VsTVpyaitrTzk3L3FNdWk5TlpudFlt?=
 =?utf-8?B?RFIzL1NkM1lVZ3VoVUNxQmVoMnpIcFhmek4rNFVxbEhsYnhMWHVoRnZFZFIr?=
 =?utf-8?B?cjRvc0s3ckIrK24vSkJ0elVTRklLRzdFMHQ1QXVJWXNNNmxaWUhGSnl0b3ZM?=
 =?utf-8?B?Q3FySzRDN3hkS1hMVmpNeHBEYy9icGZkbmowS2JGSkN6SUdOZEhaOVZSemhp?=
 =?utf-8?B?R1hJVk1VeWM0a0ZjWmlmaGhuK1RaTlVjbjVwbzZHRjVGOUQxZGg4RzdDYVVD?=
 =?utf-8?B?N1BicEtlL3hwZGEyME5nR01BR2RtN2kzMjB6SUxFOUVuOUFPMDBReWJWTjhC?=
 =?utf-8?B?TGpzMmN1WVhzR1d3MGhMM1hCRWZ2Mk9LaFo0VGhERDN2QW8wWWM2TzhFcjNq?=
 =?utf-8?B?L1JhV1VWUFlJVXJIVTg0R0pKWkpjQWJnS1VwVG82dVFKOEJVTTlSeVFEUlpF?=
 =?utf-8?B?VHJnTGMvNm5tRGZkRFRxVElhTTVhQ0xjM2cxM1VXTFpHb3VCb1JUQ1gvUXlD?=
 =?utf-8?B?eVFiWndtQll6TnhCVThNWXZNWkZaaENYTVkvQ0wvbnI3S3gxcEpMbTd3TnhV?=
 =?utf-8?B?a3M5ZCtMU0wxeEdmbjVnWVZJY0FDeEVWeDFzQlgwZmFIZzA1UHltS1NHbVdQ?=
 =?utf-8?B?V0pvZVZvaW13NXFYLzJDL2hHVy9LNFRYaXNjWGp6ZXhUSit4cVVJeDh1ZmNH?=
 =?utf-8?B?eTA4Z3pydWs5VCtEblBFVlpsYm1sSWJjaG1wb3VYWGhOVXowVHhxbEFvU3pu?=
 =?utf-8?B?RkcyWWk2TFNXbHQzQ2gyQktpR2h6MVhHZHZPdnBxaWNxdFBtUDEzdU5HU2tx?=
 =?utf-8?B?dDlQL0V1ZWdKaVBZbFhIbjVuaWdtd3p1ZDZJbjNQWjhKRHMwS1N2d2MweFZL?=
 =?utf-8?B?SUFHTGM4eWgzTmxRTlhFTWZrR3A5dEhVNzJJTXZvdERUS2pOWUo4TnF0Yk9G?=
 =?utf-8?B?Y0Y3Z2JGeHZqU09rMDNrVjE4UkRhOHFRTDJmVjNwS0MybWc3UXNsMnIyOUhS?=
 =?utf-8?B?UHA1ekw0cmMreWt5SW5iclBOR05paFlSTTRVWjIwMGZlbEkrN2ZIMEdRMm1U?=
 =?utf-8?B?Z1p6VXk0UFFaaUdTUnNJdWx0bWxUcXlnU1ZPeVE1ZldWVEtnT2JQN2tVOS9h?=
 =?utf-8?B?YkNOeERkNjBXd1RlMXZQNmxDNkJWUUhVbDAxdUh6S20yWlozTzlRY25PeHZN?=
 =?utf-8?B?aGwvZDhoZ3E4dDZoYVJ3bm92K2I1eDYvc0dCdVZtTFdHZDZBTUJWMlFGa0pt?=
 =?utf-8?B?Y1hsdE4zVytmUE05eUVqYWxHTjE1eXI0clprQjgrNHBYb0lsZllUSjkwVVhV?=
 =?utf-8?B?ZXl6UUExWWRnbnRNU0RxL3dTMEI1TkFJOXNuZlBjb3B3MXc2Nmx6cjQ4c2ly?=
 =?utf-8?B?OFpDWDBYeWtnNzdUMGpEbUhSSjNuUEZzZTZBeUNGd2Q4Y3ovS1IrUkd2enVo?=
 =?utf-8?B?WEFYNnZrbG0raE8yOEtjb0NJMnJoN3JHdWUwWXA2SFlSd3ZVUzVQZFBTSzJE?=
 =?utf-8?B?VUg0UklmUFh4d2FpUk8wV2JwSEdFWEtuWTEwdHBLc0RQUmRoa2tkekFMb3Jr?=
 =?utf-8?B?S29kbTZ2UytTbDZXazhMYlgvZk5SeW81dE9MSG80dTJUVDB4c21QVGw2eGdo?=
 =?utf-8?B?QThKRTRKVEd0ZWtNWkZuQk0vaHRTSHE0cGhseVQwZTFVNEhPbE1hZXArbmRS?=
 =?utf-8?B?MlgwbncyY09hVHRjQ2VaMW96RTRVSzZjT05WaXR0bXNnMU1zbTZmYnJJTlZp?=
 =?utf-8?B?N3R0WEtDQU9oRUtqcGo0QjgxdTRLZVZGbklCaFB1aCtKc1F5dGtRWndhckw4?=
 =?utf-8?B?RVJLK2NZb0VMbjRpekFMajBjUVQwUVVWN0hDTU5EVGFFNWtsNy9rU1pSY3cx?=
 =?utf-8?B?N0FzemphUVhtaUpPZWVxZElLQ1dVekd1eDhjdmE5T3JSVFdsd0p5YkVwWDFS?=
 =?utf-8?B?RzVTbW5walhJd214RkprbSt5RGJZcUV4dzhmSEVxTlNWT3NidGhOcnJDTlJr?=
 =?utf-8?B?UXF4ZDNuN1F6WGZ4cUZMZ05XY1NoYmh5Q0YyZ3Z0THVvZHJPYVlzMXRrT09H?=
 =?utf-8?B?UEhDTTRiOEFQVUlzTDB3ZVhQcEtjVHZCcmxqWUlRM1daWjNlK0VuUzYzNGxj?=
 =?utf-8?B?QzJSMWtKWnh5bnBuMUxmRWcwQS9IYTMrRXR4cTJhN3gwc05uUUpDdXNIRVBL?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9046ace3-3147-4fbb-89e7-08dbf5fa44ec
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:25:45.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0b1vCBwT5gjilxXVd3r3oOLl/rQdZIWxuzP5nSXbc7pMy0vjSneh3EHi6wi8AOC/kh9NVpy9z2N9xwdqtc45A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/23 22:21, David Hildenbrand wrote:
> Let's make sure we end up with the right folios in the right functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>  include/linux/rmap.h | 7 +++++++
>  mm/rmap.c            | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 3f38141b53b9d..77e336f86c72d 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -212,6 +212,7 @@ void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
>  		struct vm_area_struct *vma)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>  	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>  
>  	if (PageAnonExclusive(&folio->page)) {
> @@ -226,6 +227,7 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
>  /* See page_try_share_anon_rmap() */
>  static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>  	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>  	VM_WARN_ON_FOLIO(!PageAnonExclusive(&folio->page), folio);
>  
> @@ -245,6 +247,7 @@ static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
>  
>  static inline void hugetlb_add_file_rmap(struct folio *folio)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>  	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
>  
>  	atomic_inc(&folio->_entire_mapcount);
> @@ -252,11 +255,15 @@ static inline void hugetlb_add_file_rmap(struct folio *folio)
>  
>  static inline void hugetlb_remove_rmap(struct folio *folio)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
> +
>  	atomic_dec(&folio->_entire_mapcount);
>  }
>  
>  static inline void __page_dup_rmap(struct page *page, bool compound)
>  {
> +	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
> +
>  	if (compound) {
>  		struct folio *folio = (struct folio *)page;
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2f1af3958e687..a735ecca47a81 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1313,6 +1313,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  {
>  	int nr;
>  
> +	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>  	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>  	__folio_set_swapbacked(folio);
>  
> @@ -1353,6 +1354,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  	unsigned int nr_pmdmapped = 0, first;
>  	int nr = 0;
>  
> +	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>  	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
>  
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
> @@ -1438,6 +1440,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  	bool last;
>  	enum node_stat_item idx;
>  
> +	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>  	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  
>  	/* Is page being unmapped by PTE? Is this its last map to be removed? */
> @@ -2590,6 +2593,7 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
>  void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  		unsigned long address, rmap_t flags)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>  	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>  
>  	atomic_inc(&folio->_entire_mapcount);
> @@ -2602,6 +2606,8 @@ void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  void hugetlb_add_new_anon_rmap(struct folio *folio,
>  		struct vm_area_struct *vma, unsigned long address)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
> +
>  	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
>  	/* increment count (starts at -1) */
>  	atomic_set(&folio->_entire_mapcount, 0);
