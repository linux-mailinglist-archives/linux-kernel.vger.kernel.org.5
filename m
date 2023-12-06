Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318128064BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376447AbjLFBcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjLFBcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:32:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6799F1AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701826376; x=1733362376;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z0xBID9WLEmmIH6h4WGwg2+IzDTDfXE5uzpPUBed8a4=;
  b=VOGCF++s5ehpX+CDPRuwaTYhCPDXdBspBrYH7Q8E7VBy81+BwAO33SDy
   mexMXjfi+NytoUrpgI1iJrr03BKoGhIFnNUtvot+I5tWzwVCaBmBSDZLR
   Kg7dsOpYXMF+X8x5X5FL+ZXPA8xWzB3yStdvJ6x8zZGIyRqztnmiLV0Nj
   D/GQRbFew7bzvu3vIkUsasgk4IL9vxCVVYm1rmfeC81rU7ZzZFSK8XTZP
   4jz/zKU0elZw+34HMicpN07cpJoAawveOjU3btHeXmN5/pbHzJ1xIg3Ia
   qqiXADvNvokU72vdMNZT/PLLawvjWYVZwjMz+C1ZJ2gEk0L44IVGutw9H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373446687"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="373446687"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="837145881"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="837145881"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 17:32:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:32:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 17:32:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 17:32:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+knZPlNZTsN1eXHLDRMpN9nLTOsBaL8Dyi8gC+Vq9U8UgJodt2T1hW5nj9wxhb4t85OiRomnuKNo+UsMdHf+jvrJgK0B0vzkNlUYzCXFR3D9ehyotT9rCeVyHYlGkj6VVfprnG8MeTR1B7CKHJ0n674Fa474nZ/0xVskx949qqFd9tyyFXPi5hMjqjkiXlqhICUASNb3kLpPQDgUQrzuN5zVHCwVdndwX0kvmdKhac3FALGO0EgyWXLYTmK4e3xKUvc+HD6Mx/t7mIedxBmKiU0+Tuk/8Uj+Y213Zg75mMFHDhcdVBdPUCWbsNfxGvL5+BZKejMnybYRzhj29JxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6UGz3qVl6Qr0+64p5cYZyYguWlKGGSmPB/3W4IsUVk=;
 b=Lb7dfeArNGgH3AaQyPljByslq3bj+2NEyAc1mHT/O03NfJMwIf4i1dGlVe+U/U32nITLyfs73AeVF9BReNdTIjdk0op5kTA1+RxaVz6rnY2mpu1AAB8YbaI7wQB0+/hrt5DvOnO0X4iaah8BoXSAtH2yB0z8ykMj0NYfMh1OShFv4C+A4HoMzFJXzYBW0t8/YVV0uZufKkdL+39QcJHHSzOofp/CfN+D9z/rRrrN0YmGAP5t4gaEX5hW6NaSPgixD2dcH2b467z/7pTkAVpqthP0DatZet4BRBU0kGvWE9kWzUdwbED4kUPRBJIr5Fqp4tDj92vViti3OAGO2dB/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BL1PR11MB5254.namprd11.prod.outlook.com (2603:10b6:208:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 01:32:52 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:32:52 +0000
Message-ID: <12d26867-c6cf-4927-bc89-124a0179dfe4@intel.com>
Date:   Wed, 6 Dec 2023 09:30:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/39] mm/rmap: convert folio_add_file_rmap_range()
 into folio_add_file_rmap_[pte|ptes|pmd]()
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
 <20231204142146.91437-8-david@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-8-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BL1PR11MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: 67246929-65e2-485d-69f1-08dbf5fb43a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fh/3oMoej4HZTamvCseZi5uZA0YKTCY9jDxL3GYcqzhXYj3so7pabgl/vBFRSU6tDe7fgwPwBIMDlye3vqfDMajRMRzLDDTESClSU1teTg8+vjY0mOxSUCgln0RNB/LvGzuP09NGDH8O5ii/bGqDxmdP9R8mhFYb5jOux2b6o/xCy025LR+W2EUtQx1I5baMBGtwMI7BNts389bnM4XND7RmS8uOjwr9qMvZZI6zG/5xBd99oO0LXSwS2W/YzWwWblu/Nif7lSyFCMPcwZuscD+SEUGFbZKF1Evfb5kR+VoQpUlwaHmJIgooxw9sUhdlII2d5n/3Q5WiSDOI3pDLyuxAm+kSWk09btje1+28ubxn58oM4mkKMeFkX9HUYE/LFmemJbg8Lf7LcNLSFZH0wWi80ZqYgsxUtmld8as8IYkBzrUFHOGCtKOYkLOuIk9n2wpy7POFOrXdfDcyZ3mDni/CGx+vPq59NgWPrihvUxj20JUI+st12tnbBnK8WOL3YRLyhxOMpjflCXGEPe3F7Xp2eFheQXpwpWDDmchdhcL7j7GNXEa1F9TLqES3Fxhij5NdjtCXQnYm//+RJ0/2QJy8eglQPuefhdSy8m4C2QufUgOXtjAGTAhMmnRMT3JNElAHYXMOBsL+tPLxXDxgoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(316002)(478600001)(6506007)(6486002)(8676002)(2616005)(53546011)(6666004)(26005)(54906003)(4326008)(66476007)(66556008)(66946007)(83380400001)(8936002)(7416002)(38100700002)(5660300002)(6512007)(82960400001)(36756003)(2906002)(86362001)(31696002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGI3MlRnanNsUU9RYy8rZzltWmtnQTZ0MVdsRUcvRkJvZFZVUmh0amhGZ0s1?=
 =?utf-8?B?b2M2T2dxS1J1VTlucnJKTGJUcXlKOHRickMxczQ1VmhFb0E2dUFEY3dlSm1a?=
 =?utf-8?B?RkE3cWl2TXpsQUFlb1BkY1V0RHc0by9hV2IraG5SRThhK0I2YmRqeEFldlVN?=
 =?utf-8?B?WERURHpYbjFodTJsV2szTTAvay9GdjE1OHlnZ3V3U3ZkRk9xR3pJYkt6RGxB?=
 =?utf-8?B?VFdyT0JpOGw2Kzh3TEZMY29JOEM2ODZBbU05em9BdkQrdlNhWm1lNUNNaVBL?=
 =?utf-8?B?c0dpRnM2UjAxRlBieXk0b2ZqTVc4VFFjSkpleTR6c0VQNm1ZVWh4aG9kVHBS?=
 =?utf-8?B?TWR5Yk1uMFBiQUwydDd6cXF4ZDZPbFBjRlNSSmNkZnVBY2xVdWU4d20waVpL?=
 =?utf-8?B?Vm1yTUU3SkJPNmpKSjdGN29GbW1ra2xUWC8vT3BUZVU4L3lYQzBUQXVUUlVB?=
 =?utf-8?B?TDF0OHNBelNiakZTMFpDU0ZkL1pySzBOWTVyVHlyNlQ0b1RyZVFJc2RLQUY1?=
 =?utf-8?B?ODBmN1Z0SnR0cFVnWnMwUzM4WUpQRDVzUXNwcWN3WUswQjlBWXlhWHkwV3VL?=
 =?utf-8?B?MHM4d3J1OTl0czQvY2Rhd21OMGlZdWJ2U0NoencyWThHVytrek5HaUxQckRY?=
 =?utf-8?B?akhXZU1TcXhHMmJKOGdMYkI0eEVtaklqcWg2ZkxrVnZJNEFFVkJCZmdLSUhY?=
 =?utf-8?B?bGdxOHcyTEFGd3J6QktoTUJ5OHBCcHJwcjA5WmhKZTNsaDdHQWpOWXArem9B?=
 =?utf-8?B?ZjNhZUxsU25EalhidzR5OXlmcGFFY3pDTk02Sk9TMDM1VXV5VFpWNkhvSEdk?=
 =?utf-8?B?TlNXM2I2cUFJTDNXSW50bHVXRzFDK3dML1VlclBNZW1seXBTOXBQaWxYblp3?=
 =?utf-8?B?TmY1VmlDRFF2WE9ncnFEaDBFNWJJRUF6TnhRdHFYVnRrdmlpekhWakx2M1hj?=
 =?utf-8?B?YWdycFpzREEzbDV5QmZHUm4zS1crTkdPb0xZRnpOZXRyMmwvYVpuSUpUY3JE?=
 =?utf-8?B?end2MjEyL295d0xMc1NDVVJaeTdVaFQ2WmxEUGhza2VYY3FTZ215T2k4U0sx?=
 =?utf-8?B?cEJkblRQeHdsMGNDUmFYdjlrMWlEVVM4MmdCdzRYbEJxLzUveFNoeFhXMk1y?=
 =?utf-8?B?b3JBbDNmZ1hSWlZzT1ZNZXVMOGlSZElkUjI3YUs5SnpwbnRyQzQ5dld0MFRK?=
 =?utf-8?B?SW9na1doaVgwMXVkZUt2MGNaNzIxUEVDRkNiazJrVGI5L2krWnYzVExHTFhT?=
 =?utf-8?B?aTRtSGlkdkRXT3Q2Zkd6akE1MVB5L3hkSmlhK05WZFcrUWRCRCt1S3RKTW5k?=
 =?utf-8?B?TTgzVXRkTUtHQ1h3bmU0cHhwMzdIUStiQmRtTE1QN254ZDVKR011WVhzOUNx?=
 =?utf-8?B?dGpUbnhyV3Q5ZHVXQzFnMTBXaFNpdS9USTZZdGJ4bkdxVW5QQmFZd2YzVVB3?=
 =?utf-8?B?aTFPckRuRlRoaXNsR1RVUjhYZi9PREFJY01lLy9KTUZWaFpnY3dhdm13MzFo?=
 =?utf-8?B?Z0x4RndBNDdWZGFVTE1peXg5UXNWeWRUbmt4ZjNoYUVOL3ZQM0dnRzBFK2V6?=
 =?utf-8?B?Z3hHd0ZwNit0VmtaUk45M3YvRFhUaUFFTHFDL2lCeFFkNjhEVlJSS0QvcjBQ?=
 =?utf-8?B?RVQyak1SQ0hVUDUrYmlrSFdUNCs0RXpENWFKSVdYbFJkWDhXZWtwZmFYU2JG?=
 =?utf-8?B?b0M0YXRCaVNRUVQ4d0VLcGF2cVBTZnZrK0tUR2pPN3hEYnFOSHY0dFQrck5l?=
 =?utf-8?B?M2t1TUM2ZlJWTXJRbmo0L1VTUkFxaE9hbUM3R2VhSTVyU24rVnRSMkZjNnpB?=
 =?utf-8?B?N2R6cnFGc0QrZi9SVC8xQUVPZXd4NFh6QWRqb2dQcWthUTdMS0xRcCtkTjdS?=
 =?utf-8?B?anlUZ2M4dTFCeURJSmpZQS90YmY0cnlOUWJGSmUrWVA3UlRiZWFNb09uYlgr?=
 =?utf-8?B?Y2drb01kSjl5MHdWeHBUUXltdjBleFV4VE8rN3VPSGFyVjkxbEN4eDZHVkRo?=
 =?utf-8?B?SXBid3EzZ0xaeU5lZjFUeTNVcWRKZ0U0MW9pRFB4bVRHQnJqemZCcTVkS3Fv?=
 =?utf-8?B?N0F4NWJCMDJLV3FOTS9qVDJjamZSVFEzd3g3VitOZUhxOGNCYnFLQkg1UGN5?=
 =?utf-8?B?V2lidnVzMDFFUWhFVXFsMUhuK2V2YjlsL0swelRDSjEwelk0a3JiU1J6ckxu?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67246929-65e2-485d-69f1-08dbf5fb43a3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:32:52.6003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgAU2PyWyQJ8wWNJyAKBV7jRoiavmYhExhFwK7PNj/yHq05IyFyiYwshmlIiyfo0jucAZ8DgJvlwe9cey1dpMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5254
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/23 22:21, David Hildenbrand wrote:
> Let's get rid of the compound parameter and instead define implicitly
> which mappings we're adding. That is more future proof, easier to read
> and harder to mess up.
> 
> Use an enum to express the granularity internally. Make the compiler
> always special-case on the granularity by using __always_inline.
> 
> Add plenty of sanity checks with CONFIG_DEBUG_VM. Replace the
> folio_test_pmd_mappable() check by a config check in the caller and
> sanity checks. Convert the single user of folio_add_file_rmap_range().
> 
> This function design can later easily be extended to PUDs and to batch
> PMDs. Note that for now we don't support anything bigger than
> PMD-sized folios (as we cleanly separated hugetlb handling). Sanity checks
> will catch if that ever changes.
I do have a question for the folio which has larger size than PMD in the
future:
   Will the folio size be only just like PMD size/PUD size? Or it's possible between
   PUD size and PMD size?

   If it's possible between PUD size and PMD size, will the mapping be mixed PMD mapping
   and PTE mapping or just PTE mapping. I suppose it could be mixed because of efficiency
   of page walker.

It may just be too early to consider this now.

Regards
Yin, Fengwei

> 
> Next up is removing page_remove_rmap() along with its "compound"
> parameter and smilarly converting all other rmap functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/rmap.h | 47 +++++++++++++++++++++++++++--
>  mm/memory.c          |  2 +-
>  mm/rmap.c            | 72 ++++++++++++++++++++++++++++----------------
>  3 files changed, 92 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 77e336f86c72d..a4a30c361ac50 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -186,6 +186,45 @@ typedef int __bitwise rmap_t;
>   */
>  #define RMAP_COMPOUND		((__force rmap_t)BIT(1))
>  
> +/*
> + * Internally, we're using an enum to specify the granularity. Usually,
> + * we make the compiler create specialized variants for the different
> + * granularity.
> + */
> +enum rmap_mode {
> +	RMAP_MODE_PTE = 0,
> +	RMAP_MODE_PMD,
> +};
> +
> +static inline void __folio_rmap_sanity_checks(struct folio *folio,
> +		struct page *page, unsigned int nr_pages, enum rmap_mode mode)
> +{
> +	/* hugetlb folios are handled separately. */
> +	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> +	VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> +			 !folio_test_large_rmappable(folio), folio);
> +
> +	VM_WARN_ON_ONCE(!nr_pages || nr_pages > folio_nr_pages(folio));
> +	VM_WARN_ON_FOLIO(page_folio(page) != folio, folio);
> +	VM_WARN_ON_FOLIO(page_folio(page + nr_pages - 1) != folio, folio);
> +
> +	switch (mode) {
> +	case RMAP_MODE_PTE:
> +		break;
> +	case RMAP_MODE_PMD:
> +		/*
> +		 * We don't support folios larger than a single PMD yet. So
> +		 * when RMAP_MODE_PMD is set, we assume that we are creating
> +		 * a single "entire" mapping of the folio.
> +		 */
> +		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
> +		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
> +		break;
> +	default:
> +		VM_WARN_ON_ONCE(true);
> +	}
> +}
> +
>  /*
>   * rmap interfaces called when adding or removing pte of page
>   */
> @@ -198,8 +237,12 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
> -void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
> -		struct vm_area_struct *, bool compound);
> +void folio_add_file_rmap_ptes(struct folio *, struct page *, unsigned int nr,
> +		struct vm_area_struct *);
> +#define folio_add_file_rmap_pte(folio, page, vma) \
> +	folio_add_file_rmap_ptes(folio, page, 1, vma)
> +void folio_add_file_rmap_pmd(struct folio *, struct page *,
> +		struct vm_area_struct *);
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f18ed4a54971..15325587cff01 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4414,7 +4414,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>  		folio_add_lru_vma(folio, vma);
>  	} else {
>  		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
> -		folio_add_file_rmap_range(folio, page, nr, vma, false);
> +		folio_add_file_rmap_ptes(folio, page, nr, vma);
>  	}
>  	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a735ecca47a81..1614d98062948 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1334,31 +1334,19 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  	SetPageAnonExclusive(&folio->page);
>  }
>  
> -/**
> - * folio_add_file_rmap_range - add pte mapping to page range of a folio
> - * @folio:	The folio to add the mapping to
> - * @page:	The first page to add
> - * @nr_pages:	The number of pages which will be mapped
> - * @vma:	the vm area in which the mapping is added
> - * @compound:	charge the page as compound or small page
> - *
> - * The page range of folio is defined by [first_page, first_page + nr_pages)
> - *
> - * The caller needs to hold the pte lock.
> - */
> -void folio_add_file_rmap_range(struct folio *folio, struct page *page,
> -			unsigned int nr_pages, struct vm_area_struct *vma,
> -			bool compound)
> +static __always_inline void __folio_add_file_rmap(struct folio *folio,
> +		struct page *page, unsigned int nr_pages,
> +		struct vm_area_struct *vma, enum rmap_mode mode)
>  {
>  	atomic_t *mapped = &folio->_nr_pages_mapped;
>  	unsigned int nr_pmdmapped = 0, first;
>  	int nr = 0;
>  
> -	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> -	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
> +	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> +	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
>  
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
> -	if (likely(!compound)) {
> +	if (likely(mode == RMAP_MODE_PTE)) {
>  		do {
>  			first = atomic_inc_and_test(&page->_mapcount);
>  			if (first && folio_test_large(folio)) {
> @@ -1369,9 +1357,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  			if (first)
>  				nr++;
>  		} while (page++, --nr_pages > 0);
> -	} else if (folio_test_pmd_mappable(folio)) {
> -		/* That test is redundant: it's for safety or to optimize out */
> -
> +	} else if (mode == RMAP_MODE_PMD) {
>  		first = atomic_inc_and_test(&folio->_entire_mapcount);
>  		if (first) {
>  			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
> @@ -1399,6 +1385,43 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  		mlock_vma_folio(folio, vma);
>  }
>  
> +/**
> + * folio_add_file_rmap_ptes - add PTE mappings to a page range of a folio
> + * @folio:	The folio to add the mappings to
> + * @page:	The first page to add
> + * @nr_pages:	The number of pages that will be mapped using PTEs
> + * @vma:	The vm area in which the mappings are added
> + *
> + * The page range of the folio is defined by [page, page + nr_pages)
> + *
> + * The caller needs to hold the page table lock.
> + */
> +void folio_add_file_rmap_ptes(struct folio *folio, struct page *page,
> +		unsigned int nr_pages, struct vm_area_struct *vma)
> +{
> +	__folio_add_file_rmap(folio, page, nr_pages, vma, RMAP_MODE_PTE);
> +}
> +
> +/**
> + * folio_add_file_rmap_pmd - add a PMD mapping to a page range of a folio
> + * @folio:	The folio to add the mapping to
> + * @page:	The first page to add
> + * @vma:	The vm area in which the mapping is added
> + *
> + * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
> + *
> + * The caller needs to hold the page table lock.
> + */
> +void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
> +		struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	__folio_add_file_rmap(folio, page, HPAGE_PMD_NR, vma, RMAP_MODE_PMD);
> +#else
> +	WARN_ON_ONCE(true);
> +#endif
> +}
> +
>  /**
>   * page_add_file_rmap - add pte mapping to a file page
>   * @page:	the page to add the mapping to
> @@ -1411,16 +1434,13 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>  		bool compound)
>  {
>  	struct folio *folio = page_folio(page);
> -	unsigned int nr_pages;
>  
>  	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
>  
>  	if (likely(!compound))
> -		nr_pages = 1;
> +		folio_add_file_rmap_pte(folio, page, vma);
>  	else
> -		nr_pages = folio_nr_pages(folio);
> -
> -	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
> +		folio_add_file_rmap_pmd(folio, page, vma);
>  }
>  
>  /**
