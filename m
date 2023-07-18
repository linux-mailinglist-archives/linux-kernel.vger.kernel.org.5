Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10FB757147
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGRBON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGRBOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:14:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135EFA6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689642850; x=1721178850;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=87C9tdBp4qdjBr1uv/7ZsRs3xvDHgRpWBQKzbzMLvCE=;
  b=Hqo6iM4aEIETOJPrNDsZe/PxdTCryjHYntubAQJpTB2e/GzQoTjyF3JI
   mdkDkMwhKxSpqIR22SP1P1620Ps214hBT1x0EdZiodh7NV6M602KhyhAW
   BX/LTzfekCF5NC5NkYbTQOGw213fwl6Nuif+NhGXlAlINi95AJWAQFIu0
   swtGsLe1M8wp221eQlgE6njAla9OPkBpse+E1qH0iMxa/+5C01uI9kLG3
   RU4ZpMVeFWWz5q2ysRqsRcRWF+QRO2oZlFpuI7b6y+MoSs/nc/RnptZpd
   O7BVHXlhaUl3/0z3mSyzueT/lpwKhqr0H9GUpm8MDK30VDsFyr9l4yDbw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429841543"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429841543"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 18:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726745534"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726745534"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 18:14:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:14:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:14:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 18:14:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 18:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWtqpy2WxuiP8/bhKxed1GvT9XLeY/T0IijOGmANcqaQUlB/TVabAppVWrSDAZoJ2Xbs2hiQh9CdRwLvo76msvbH1k9zgcqj8Rzmz6iug31eQY+RYbo5Sd9AUPuYhDHIWhFrojObgtKqRtAUOjI05SimOha0GPuQJzQYx0JZbhQblvAOATz6eRRCWf1bsN88TVI0zrFtRsyuKsRsrw5p7D1jjCM3nGm1TZfEfagdBUltob9M8zqDxw5CEvMJcLBRAx2gGgVkWavcXwu7e++8EGmBkkaCup8zK+3V/6ZLyIiV04ynGxC6Onb1SnsfoVRt1i5aNxzXNayvwJir5qQ9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz3/wBEwf3puR1Y+hqxgjB4jKfgza71m8JeXSAgMLj8=;
 b=evCAV2vStAQ0jVOPXHgLGNd4QTPlNa/BvdUEMkLjjGMOdOsQTMxsf16tE7A6blvZsV72N157OUlC3PB05iLOSqk5t74AZ/rDxC5gIU9W4Olo5jrEaZWh/maJD87BjLQADCjUxi83ISlvI28k88w7kxMU+h0O/QZQBaL+kuQtwMXJjr7gIlG7Ws/xbgvGqduGBlni24vBFQD+dMP54BHtSCewlAl1RNW+gnLUGbEPjN1cWrERKggJf345U4e3GcKc2oUde+I949F1lrrH5gCvwIJnmZkibJXhn7J15XiM6duSnMmlCguiX3wset0WYVonB85d9b6sGVrdqr53BZFc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6391.namprd11.prod.outlook.com (2603:10b6:930:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 01:14:06 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 01:14:06 +0000
Message-ID: <779227c4-65e2-1608-0abf-f19eedc386a6@intel.com>
Date:   Tue, 18 Jul 2023 09:14:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/3] mm: Implement folio_remove_rmap_range()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "David Hildenbrand" <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-3-ryan.roberts@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230717143110.260162-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 1265e0a8-e513-439b-850b-08db872c4834
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvXxFDthyA01QSgmF7kuOnWzUF4847MRal30Ah61BQrehzth1QPGAFjdpYAPIsm6/b8mVNsdMtYCIdYdQeha67BNpHSZJPvA8aeWxatlPnqT6i8D991BHkpRkQcqhqtMAtjl9nCKEhYUkp+VxR9KcIZy9vz83jvYN30IeD5HavfGrd5Z27jitwsV52792vOETeItngpj3cGlHYB/9Vw4snLaQus2opZWu0F/4zEMKKD6rChWwdWaFL7bUBDfpT8rr3TMabP4kzmI0ejGORTFLa4sKmCx7FvKt4KKrEu40IpzlKD+XzefxZTgAkuYIQwezVyYmcF36wfNfGl8Rk9iZDq2J6tYYMMPhAxlKkB+07ob5+DvXNe5OdxOpTBHVApw/vNy2IO5I4eSdVZh64aGa7Y4nKtH97p6POLKTR0fCD51ZKIznkRTTv5zyPQgUCgarvndvIr9Ejer6dN1ZzTMZ5lkJNGQeQ9KbOSVcrq35Uk2B9trlMHBUDcKq7Nh67zk+fjPwD04N2upzoTRqfnmpEGWMeitXKRs5RyfBtYaVqwf/7xSSBXNXoef+Bn3evY+rU8tTqI11Exjar/hhUJE8eh09ZbmM7hGulPKZUTIm74tHeFv3wTRX+bbnXSHuvlZav2VZA7LudU8K/DNdEkPiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(31686004)(478600001)(6486002)(110136005)(2616005)(83380400001)(31696002)(86362001)(36756003)(2906002)(26005)(6506007)(186003)(53546011)(6512007)(38100700002)(82960400001)(66946007)(66556008)(41300700001)(66476007)(4326008)(316002)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RThJc2dzZ0RTVVV5Q0drUHdxT3RucjFaSWthTXowU1JZUDRaQlBwRnNzZ3Ir?=
 =?utf-8?B?VDYyRUNmdzZzVTlsTzJ2cUcxRklwd3ZhK3I4M1gzZk8raDVoMnJYZHhsL0JS?=
 =?utf-8?B?WTJ2WGM5UUZ6cEd2N2J3eklnMGVkYTEreUxRV09WUjhVeVlNTTdoUVB2dVpW?=
 =?utf-8?B?OXhCRG1jdTZvR0NNVTJBQW9jMHYzVUtDQ1RsbFR6YU9ldUU3akRBcHZ2ejZw?=
 =?utf-8?B?L2xzbTQ2NTZRTG9mcmE4YmZocUNUTHJQd3FISGR1ZTBqa0lKeVVVQk93eEpR?=
 =?utf-8?B?R1IwbTh4NUI4R2VzbFU5MFFXdFNxOFFtaDhaM1Z0RXZaclFCS1hsK1hGWTk2?=
 =?utf-8?B?TVVHYVhoZk8wU0Y4M0dBV1NpZW0rMmt1TWdLZDF2SVR0S3pmam45RU05dU1K?=
 =?utf-8?B?b1R6MThIMXFlcmNLZ05Ub3ZaMHcvOUtZWGNrQnZ2Wm9MaTg1dGZMb3g0VnRa?=
 =?utf-8?B?S3FIUXVGVEpzRlBQblZlazI2REZsaXBucEpjRHJ0UndzNWV5amxxVTBwTHRv?=
 =?utf-8?B?NkxwZ0psQjNxV0EvQ2Y0N2tkdXVzUSt1UHkvOEw0MU1YUE1DSWJicnQ5bHFF?=
 =?utf-8?B?eE80U0xKRzIwaXl5UGlxc00vV1grUzJMME9xczFQMkRqTnVCaXg0Znp6UDFn?=
 =?utf-8?B?UUN5dmlZTzkvQ0x6VTJhTGlUd0NyVHpFcFZoMzBaM2pyQnMybW5zcjUyWFFW?=
 =?utf-8?B?SVFYOW9uUTRML2lYS2NGd1dYQk5BRjU0SllFcldrRHBVZHJnakIvMUlUT3Yv?=
 =?utf-8?B?THJpdlZ0dHBMVEthRWc2MG96eUJzbDlGd2g5TnZhWGhaTTc2emFRa0xUTjZs?=
 =?utf-8?B?dXpRL3BpMG9xbFJmbWMrWmJkOXVjQlo1QjQyS2RlRmV6K0h2Zjh2UlE5Q0FY?=
 =?utf-8?B?cVcvVWZUMFdISzFmUm1qOTZzSmRpUXMzRkhQb05rUjdLVVErbWp4UFpOK0dJ?=
 =?utf-8?B?a2J4dURHSHdoTG9JWktGSkNZWWtqbExEOGNzeUs4M0p0MVo2VytXQ2JGbFR0?=
 =?utf-8?B?NkdsV2NDaGhpSzcrQUtRZWFMaGY4Wlk0ajJHejdmSWdzTXFOR2tYNXlFYjhq?=
 =?utf-8?B?L2RtL254WVVyS3QwSk1RQW83ZXlxZWNXcndHYVF3M1RWUUwrWjdZdDIvcU43?=
 =?utf-8?B?WmpHMlhLaXozbDF0TVk5VlVEbFNpVDZ2eEk0VDJsOW9LYWhpOTBHbnZFcm1D?=
 =?utf-8?B?cDFiMVdSOEgzMHdMOWhlZ2RDM25CZW9rME5ZNU50L2IvYUdwbU10VzQ2Tll0?=
 =?utf-8?B?b1kwMitWMDlaZGdoS0F4cnVIS2Jlc3NWczI1a2ltSS9KQVpIM1lCemdVdTdC?=
 =?utf-8?B?N1ZrK2VIWGpMN01Sd2sxR2N1dElTRS9FV1JMeitFUHNrYnNWWHVoZGx3K29s?=
 =?utf-8?B?aExpWUFjNTdMRTAzd29uUnlQRFBDdlkwNFVCRkNrM1lueGFBSjUwOS9XT2RV?=
 =?utf-8?B?MDFXY2tlNEp0bENxRnFuKzJkTHZlcW50c01ZNFpYMjJZYkUvZzhJSzAvY0py?=
 =?utf-8?B?QlB0NnhIRmVGLzNGL042Nmh6c2VSeWlrdmlFTGtLSFBobEk1MEZCOERFMldT?=
 =?utf-8?B?clQ3RE9FYWNqVGZyY1FmOHlXQVZEalpCbHJsRkl3VHNQNG1uQTdzWlh2bFUv?=
 =?utf-8?B?MSs0b3VaMkhRWTVoMko2T0s5ZktyNkVNWFB5WlhhYW1ZMFdJUlZHd3NQQTVJ?=
 =?utf-8?B?TzRGL01HM1AwRVFhRjMrQXlETmRDRVl3TTltRWtHaXNtbGQ0TFJvMCs2OURZ?=
 =?utf-8?B?SUpkeXlRRWZuSVMrZExrY216dU5LUjdkNkljWVBvTmVwV1lIcGNLVnp0bXBk?=
 =?utf-8?B?bW51WEthVFBhcnROR2VtWGorWmptK1JIVnJSM0hyNUppNlNPelJqVURFdGVD?=
 =?utf-8?B?b0IxbTNEdlNmVzNFMXdVVlo4NFZ0Wjh6aDVTZi9VZDZRRithdkt4THBKbUhR?=
 =?utf-8?B?bEtwSHhrbzMxd0xKa1Z2dzdvUDhBZ0dmWTRXVHlPclNFNmd6UTVJNE0zVFlm?=
 =?utf-8?B?NHdMMGJrU2pLQTRyeWFDamRLVWpudmQzUXR5ak5hYmVMRlBqU0FkU2RRUklZ?=
 =?utf-8?B?b3Ara0lYLzh1K1pMbXJpQUc5WHhDbloxblFyM1Y0YVhjRWtpR1ZvU3VVNnZk?=
 =?utf-8?B?R0dNRG55YTZTWW1GWU5JY1VIaXFnZ01xbXUvb0V1aGpqKzd2Y2xScGIxR0xq?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1265e0a8-e513-439b-850b-08db872c4834
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 01:14:06.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBe9Bel/nmQVMRBJ84qdLHdeFUfHqLFtYBpXpheqrzYoOHRkMN9hGE2dJBKBDAa6p2PnGODwfSjQYTzCrRgPMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6391
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



On 7/17/23 22:31, Ryan Roberts wrote:
> Like page_remove_rmap() but batch-removes the rmap for a range of pages
> belonging to a folio. This can provide a small speedup due to less
> manipuation of the various counters. But more crucially, if removing the
> rmap for all pages of a folio in a batch, there is no need to
> (spuriously) add it to the deferred split list, which saves significant
> cost when there is contention for the split queue lock.
> 
> All contained pages are accounted using the order-0 folio (or base page)
> scheme.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

Regards
Yin, Fengwei

> ---
>  include/linux/rmap.h |  2 ++
>  mm/rmap.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b87d01660412..f578975c12c0 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -200,6 +200,8 @@ void page_add_file_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
> +		int nr, struct vm_area_struct *vma);
>  
>  void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
>  		unsigned long address, rmap_t flags);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2baf57d65c23..1da05aca2bb1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1359,6 +1359,71 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>  	mlock_vma_folio(folio, vma, compound);
>  }
>  
> +/*
> + * folio_remove_rmap_range - take down pte mappings from a range of pages
> + * belonging to a folio. All pages are accounted as small pages.
> + * @folio:	folio that all pages belong to
> + * @page:       first page in range to remove mapping from
> + * @nr:		number of pages in range to remove mapping from
> + * @vma:        the vm area from which the mapping is removed
> + *
> + * The caller needs to hold the pte lock.
> + */
> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
> +					int nr, struct vm_area_struct *vma)
> +{
> +	atomic_t *mapped = &folio->_nr_pages_mapped;
> +	int nr_unmapped = 0;
> +	int nr_mapped;
> +	bool last;
> +	enum node_stat_item idx;
> +
> +	if (unlikely(folio_test_hugetlb(folio))) {
> +		VM_WARN_ON_FOLIO(1, folio);
> +		return;
> +	}
> +
> +	if (!folio_test_large(folio)) {
> +		/* Is this the page's last map to be removed? */
> +		last = atomic_add_negative(-1, &page->_mapcount);
> +		nr_unmapped = last;
> +	} else {
> +		for (; nr != 0; nr--, page++) {
> +			/* Is this the page's last map to be removed? */
> +			last = atomic_add_negative(-1, &page->_mapcount);
> +			if (last) {
> +				/* Page still mapped if folio mapped entirely */
> +				nr_mapped = atomic_dec_return_relaxed(mapped);
> +				if (nr_mapped < COMPOUND_MAPPED)
> +					nr_unmapped++;
> +			}
> +		}
> +	}
> +
> +	if (nr_unmapped) {
> +		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
> +		__lruvec_stat_mod_folio(folio, idx, -nr_unmapped);
> +
> +		/*
> +		 * Queue anon THP for deferred split if we have just unmapped at
> +		 * least 1 page, while at least 1 page remains mapped.
> +		 */
> +		if (folio_test_large(folio) && folio_test_anon(folio))
> +			if (nr_mapped)
> +				deferred_split_folio(folio);
> +	}
> +
> +	/*
> +	 * It would be tidy to reset folio_test_anon mapping when fully
> +	 * unmapped, but that might overwrite a racing page_add_anon_rmap
> +	 * which increments mapcount after us but sets mapping before us:
> +	 * so leave the reset to free_pages_prepare, and remember that
> +	 * it's only reliable while mapped.
> +	 */
> +
> +	munlock_vma_folio(folio, vma, false);
> +}
> +
>  /**
>   * page_remove_rmap - take down pte mapping from a page
>   * @page:	page to remove mapping from
