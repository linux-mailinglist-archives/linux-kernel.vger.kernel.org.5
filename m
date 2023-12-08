Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064EC8098AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjLHBlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjLHBlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:41:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FA01729
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701999664; x=1733535664;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DiO4UeZS0doj2OLCMUqyoHZY/pfgokyrxrC5PdhHnGU=;
  b=JXUrXeesteTPGwh2lYukDBOeaAQVNeC8q7Skiv2/Z0DNEYUsLVsiVA/1
   GkGHoHrHSPa1LGGsIY+zLgoPY2jG9kmIz7/ewqvb8R8aH8qiy6WwfssJl
   FwU1F9eCvbQeSVFbDckNU/TqaFoVi/yNhrG1s8dcOHQLnhBgehgew6+8h
   p/MIiq5TyuMpy5Af19vvz9Ns8/Ws09IV9K6rFRTZhTbY7LiEAvR6EyuAU
   kOE9/m38NGO+I1mzd9nNUfUzMW4bytoySIWTmuHRSUHT6l13DCv4ulE5h
   sr4IvwMRfdC/YqypAsLjycTyoHksx+pALLZ2OPvqYPtlUB8Pz4xdy0R45
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1409173"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1409173"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="915780923"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="915780923"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 17:41:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:41:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:41:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 17:41:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 17:41:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N43b87c3LQLB3cjgO4/mKiNFxPzO+4tbMmSitSryOVxJdiS1XyOalgsUkd/IhSMNE7hf7FudhtM8PDsQJPxDdz1sf63l7ftl4dkWt2JxxrKCbYE0ijcH70tPq40LifxcIxlI8oTTuS60e+on0ZIc4e31R1DaH1zoKY1/XsMWUapdYQmHy2QFe6b4nWrcTJ5n+AkiV9BMZW3IMaWl7Ykg/sTr4gEDp+VrXigN7qMuES1KmjDOUEpFSShFe6xdwYywvbps3FYnCZWnpo7HzhbYxmqccHdX6T8Li2vKRDctdKmhwo0Q4sMGbdy5SB0Mal2Ka1dlqOT2mYFVvPUmkQRpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp53dzqv5V9i8XndcJRhwh6hr1J9ch/wTDcf/tQJhbc=;
 b=MoCKxhGxTQcwhy0udF/UUn2DK8J8QOQmJDIbAgrynxVyfXs89GTMqJYLaRd0acxMKqtVNl1q0RzgBeovr2qFhs2WfXB3Z3qoxZhYRDlbrnMXlZ8FigioEfmqt7LP1/x93OIzwEtEfEIy0R/Gp6DbMst9CZsD1sQoY5jYi0FmJibMKkol0Soiqjm2j+ZcTRguAT4WO/YL/zyIjrjJWOBoXnAPdZNcxj+ovrCxqnH+BLApmO+c0EBaFR1zikTnEzE7rsBBOZOiV1bmYHu6dG/NFCT2pdr7VT0j0CFvVWoE/PW7ncyjTeI3j6faQoEzcIDpRGkrSnb4kq4C3a92DV0cfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 01:41:00 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 01:41:00 +0000
Message-ID: <0ec525a5-5ee5-4254-9c4b-340fc9de0db0@intel.com>
Date:   Fri, 8 Dec 2023 09:40:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/39] mm/memory: page_add_file_rmap() ->
 folio_add_file_rmap_[pte|pmd]()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-9-david@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-9-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 26292f66-0646-4944-909a-08dbf78ebafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: day6tuoclej1qW116er4v1AHN5HofPIxZC+2PXhgJ4LOIeipv+AUu3UNN7REKPUjiU6pGkQEyjZpE50O5BiAh4EHoTHKUgfq7e+I+rjh6H+g1ZGrdkY760fPMmcMdcwd1U7CATdlP54kXkP4qoACRl6rWxC/R5HqyQ6PqEovXsaASlBST7dbuNdGvrVyS5nh4fOODa3nNTUKnj6NRWa5JswjBcmScbdbaYpNFPOdfoxIejlRDa05QzmnDMpvLZQJPVCXaCYhsEFXIqL5Gh/KEJFte6+e+X+76rl4nFvv4KtKGMKMRtgs6uYpw01WfgZZKR4wsr57Q3zeuq1FelaRLmuKI+t430XQdxok9v9rKMPN3TlehiDTYgQEOWzCr3bzccnkcNH8EmdKh1EqsqUuYgNG5vzJYpQ7X3ZDcCGsg5OBVMureUUgkX+wwHNmMumRqxJHSIqlI/bYzgsY9b7djoIXr6nIdIsqx6BhnMlt5LK2DKKgRzLkkIxGj2EgjHfI6A7kjGEfoXBEh09H+l7CZlyFltS7YDFwd94NdKI9LvtclAQrhCW/ktI/4xvMaOSlJu16JCn1xhU9G0GgaZj1zMfy/J84nBJ0/Zc4QxMCKItx9YqSa3ku1/wkniLhGYDPS8W600NYiLvkjPQ8q5UgwxuJeK4UEkvQ24yRj2aZiXBBQwKB/+c7mhZwBor4i3lBmE0rxalXtMBIZ9ZSIC8FZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(66556008)(5660300002)(66476007)(54906003)(478600001)(6486002)(2906002)(8676002)(4326008)(6666004)(7416002)(316002)(31686004)(8936002)(6506007)(53546011)(6512007)(26005)(2616005)(83380400001)(41300700001)(86362001)(38100700002)(36756003)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldZaVg5N0NpSTdSTkxOa0NWM1VVMkVmUVEvYjZBVVdDclpBZ01OcXVtOHVV?=
 =?utf-8?B?K3JiYmU5aGtxd1lMam84YjNqOUhuU1h0RStEai9lZUVaR2FEd2ZsdkxVZVhk?=
 =?utf-8?B?cmNVSUU2Z3hWcmNnTERqeGpsTUJHUWp5OEJhZ29kQzBiSlJQMm5Dc0J2NVlz?=
 =?utf-8?B?OEluZG1MbzNMUXNXeE9qN0xzVnVERk52UEJCc0J6clFlRkdNVi9hWUtRYlZt?=
 =?utf-8?B?TEtDK29kWmY3S0NKbTZpWFA3THpWbm0xQ3JTRk5QOUNmclZFUEtVTitWQzZl?=
 =?utf-8?B?ck1abnFOcHdjWWNCa2liYmNReENKb0RTdzM5TlgyRXJxWW5JVk5wdUcyUllC?=
 =?utf-8?B?bDZ6cklabkRUbENpY3VFSGNqZTViTCtkSWIrR0ltcUN2SkdSV3JVQ1dEK2kv?=
 =?utf-8?B?NHprc3U4UTVYcmxhNEZtRDI1MHB2WkN0MitMVmVZUlN4VGMzem5adUdweFlv?=
 =?utf-8?B?MW9uSkd2MWhLd3ZJejNHWFltOFdHWnljWlFIQngwbE1wSktsdjdDclRGZWFq?=
 =?utf-8?B?alVqa21JNXVVREVmZHVPWlZYV01iaEJ6d1d1cnhXdVo2SDNrTlVzMWxPOUhC?=
 =?utf-8?B?ZmNFQzJmSzdwamZOTFljL0dpOWJENkJvYzN0akpWSHpxL0lCaFlGMXBPblhj?=
 =?utf-8?B?VklkbWJrRzk0YlhsMWhyV3hUK29TSEozaWJFd2VTeEh2OTlzZXVTbEpUVDF6?=
 =?utf-8?B?d0tjNHExbWY4akVkc2EwY09tNGVuNmhONVVBMDFwWjNPL0ZKcXdNbmlla3I2?=
 =?utf-8?B?ZW9UaW10eEFlV1ViZytpTXBZYlM1alFEN1ppNmQ4VGdWblpFYWVTMjhwNTVK?=
 =?utf-8?B?SzlHL1NIUUp4K2I4aDFMTDRCcnF3YjNwY2dWQ0hxb0diT0taRVh6WUppTlVv?=
 =?utf-8?B?VUNMMXZzeFJlQ3ZjaTZEYzlLd2FNNW9kRC9mdmFLYzVEUjg5aVJxNFhtMVNz?=
 =?utf-8?B?cWZDREFPV3pLWm9ybDFXWExOU1hCemhaSDlUUGUyZVhySEFKaEtZM1poYXVk?=
 =?utf-8?B?ZGkxUEhsT2cwZlQ5cWsxOXNxSG9FRGxnaGtVdjJUcjE5dmh4WnlBZnJyUk44?=
 =?utf-8?B?Yk9MUm1WZi9tUEZEZzIzN2ZZNHkrejYzV01SV0h6SkNqa3VUSWd2WTRoMlIv?=
 =?utf-8?B?MVp2SHlSL1V3RVNTUVNWU1RsQ0RHTDJYMURIRnd5L2JrWU95MmhjMnNEVDI5?=
 =?utf-8?B?MXptcGJvdzJKeWRvaGFXeUpyM05JcXBOODJBeTNUZEMrcnZHY0VRYzg1b0Zy?=
 =?utf-8?B?cUU5cjVvY2pYYXRleDkybFFoVTdUOWx0OTRnYndObWZhaWpUYytDZi8zRytZ?=
 =?utf-8?B?NUlLemdyQlNyNkowYlpVVTFqNzhEbGI1SFVydHJiOWJzQ0RzUVJwSVViZGZn?=
 =?utf-8?B?TGVZUXF0enp6azR3SE5IbnJzR3NkNUZLUGx3NHFJdHR1dFRrQzYyQmlWeXQx?=
 =?utf-8?B?THVweHJrRHNib0dsbFBleHRBOFVwUzF3U1RweU04alc1SFJtU1FLQ1p6cjkx?=
 =?utf-8?B?dS82TERSVWVyL0VTZDVSdDZYaHgvVndWTjJ3MDcxRXBjbWJ6c2xGRWlzSjQy?=
 =?utf-8?B?NTY2MEVRVjNOVzdqUFRHSVJYZEJjdjdlMVdhejJtemdBM0t6djU3Sk5wK2c5?=
 =?utf-8?B?L2VYTFI1MHNtMDFkT0cycDluNXhISDN2VFZWMk5VZ2VJNGl3cTFkSlRQVFht?=
 =?utf-8?B?cU90WVZhUVhhM3BwQkh2czFyMEtubWFKTHVNbUsvM25BMlpiZ0ZtK1hIejc4?=
 =?utf-8?B?RDNPOUwyb09NenZvaXdIelNQV1ZjL2ZzVDhMS2VaeUgyNkZ1NHA2ZFBlWGNK?=
 =?utf-8?B?K3lSSEdZVjJJUEE5QWVydXJ0dzVHUnhFaVRqYnpNYkxORlJQQ0tjNktOZGxI?=
 =?utf-8?B?R3lqL1hwYTVnd0xkSHRpYktBWHpFT1lWOXByNWxuQ0JRTFJ3NEpnUElOWWRS?=
 =?utf-8?B?REYxcWVBbm1DYWhqSUVvMHlFS0x0ZURXOXd2NGNzMDZiUFIzMG1DUVVmUnF0?=
 =?utf-8?B?QmFHZVZJSWdJVkt4bjhVbDZGeGIzV25nbjZlZXFzT3pGcG5mdkxod2k5YThM?=
 =?utf-8?B?aDVXY28wbFhJYkVnZHRoYlFlWkFxQno4Z3FIRk1hVmRXamV1ekFqNllhMlJC?=
 =?utf-8?Q?EmU+eoWsCDQmJiA9Y482rqJNd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26292f66-0646-4944-909a-08dbf78ebafc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:41:00.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/Co97M4jBC/++HTXryxMsnUdt0agrnfcazBt6C8sritFz1Nv+4JoBlfNoUw+RLjuBKAl1DIVizr+rHmrnSWtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2023 10:21 PM, David Hildenbrand wrote:
> Let's convert insert_page_into_pte_locked() and do_set_pmd(). While at it,
> perform some folio conversion.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

Yes. I make sure my RB tag this time. :).

Regards
Yin, Fengwei

> ---
>   mm/memory.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 15325587cff01..be7fe58f7c297 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1845,12 +1845,14 @@ static int validate_page_before_insert(struct page *page)
>   static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
>   			unsigned long addr, struct page *page, pgprot_t prot)
>   {
> +	struct folio *folio = page_folio(page);
> +
>   	if (!pte_none(ptep_get(pte)))
>   		return -EBUSY;
>   	/* Ok, finally just insert the thing.. */
> -	get_page(page);
> +	folio_get(folio);
>   	inc_mm_counter(vma->vm_mm, mm_counter_file(page));
> -	page_add_file_rmap(page, vma, false);
> +	folio_add_file_rmap_pte(folio, page, vma);
>   	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
>   	return 0;
>   }
> @@ -4308,6 +4310,7 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
>   
>   vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>   {
> +	struct folio *folio = page_folio(page);
>   	struct vm_area_struct *vma = vmf->vma;
>   	bool write = vmf->flags & FAULT_FLAG_WRITE;
>   	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> @@ -4317,8 +4320,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>   	if (!transhuge_vma_suitable(vma, haddr))
>   		return ret;
>   
> -	page = compound_head(page);
> -	if (compound_order(page) != HPAGE_PMD_ORDER)
> +	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
>   		return ret;
>   
>   	/*
> @@ -4327,7 +4329,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>   	 * check.  This kind of THP just can be PTE mapped.  Access to
>   	 * the corrupted subpage should trigger SIGBUS as expected.
>   	 */
> -	if (unlikely(PageHasHWPoisoned(page)))
> +	if (unlikely(folio_test_has_hwpoisoned(folio)))
>   		return ret;
>   
>   	/*
> @@ -4351,7 +4353,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>   		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>   
>   	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
> -	page_add_file_rmap(page, vma, true);
> +	folio_add_file_rmap_pmd(folio, page, vma);
>   
>   	/*
>   	 * deposit and withdraw with pmd lock held
