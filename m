Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9727B75614C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGQLNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGQLNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:13:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E761B9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689592412; x=1721128412;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tAuZDQM0NI9ggs9Ph/zcpb/3roFT7uB1pbhJcUvsCdU=;
  b=L6ysQmT4znJOQ8MVzPO5uZnLTwWfo0Iz1ks77bzuqSroDdv08b63fpC4
   f5Kvdv2BM4Kc/sNZaFPLzELfABrrzmjf8PHeItUZhvnC2fpEyLZgQjvHg
   JUymEPayKJSQ4m8r2jgzJV/hlPlgZ8PazX5d2cpVAQzgrRbozQuo0nkKV
   lcKXaZChLrL1d2s2qeu/Y6XtJkgA1xgD05q/RqKNzN15OPJHUdDV7HuPC
   QMEFSlj93q/XWKE5+L8YU8xUT+oY4WFa0GC74vW92aYgYpTC89fAzMkce
   x7ooC13fG26/nsmfVmSwZSTFufLvyuT6CXl/NilF5jYKzGQ0xdwVzw3kw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="432071483"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432071483"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 04:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="726505956"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726505956"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 04:13:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 04:13:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 04:13:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 04:13:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKuHdUbd60pMvGFhqvqDck1DtOHXSLcXezBGRiDCm1He2Vsi3woA8u5vTlKcezImTxuxDp0POKj2v7DSFU8/LPUFqjocSxwFVXBx5NPv3T1rJ0V66wN27Kl7lpahiDE7HSD2GxzD+KMtQzEN9yzsRnHuttKrzL/ru3PlsoRhXh2TFUdc9j8uWHgubOIKADcF347aQi1F57uG+uWo8o7kQgqM96qFRKqGr+LtlgDrTRyOTQ++73yoes1EC3JpbHsYhtoKtujRMbiayLfPhDScJ4tckJjNV8JQgxD8PcCFoesGZ+7TGinbHtJK6W0wWDsrUI8c1lF6C8wBaq2HEo+psw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdOYMME9vaB09mfUQFIGqrYqc00mE2khk93qpj0jES8=;
 b=R/ebQPrJCMMs3X2hZ0RLZrvjrueIW93qTAZNHfpEspgmIa8Wj73q/+SpKYWsMcpriJbs1jx3bNtT2awZCOwWQII7ymCCW/5eXxSDqBTzzJnJo1kSrTg15P1HGmmzd58ppauYNXfPs1+YCVzuDCDP4QlQM39Q6piOcO8wizdFGkPueJLf+hUCog/xiNOqq4x8KkzmmtTRlsxsiujmLQDys/DabG+Bh7+NIc78qCSUxrjSgik7qUvszCPTX8Rw/SUD273cA6CzXdRl57NUY7G/g1Hlge1qpWUlcRu6llmJ+qqOtG+bv9V4JbFcROGrd6HfOmB8IGhytul9y9ClqMYs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB7133.namprd11.prod.outlook.com (2603:10b6:930:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 11:13:28 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 11:13:28 +0000
Message-ID: <86c11e91-5dc5-a185-59a1-afa1e3295060@intel.com>
Date:   Mon, 17 Jul 2023 19:13:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/4] mm: Default implementation of
 arch_wants_pte_order()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-2-ryan.roberts@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230714161733.4144503-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 09345b19-3634-449d-55c1-08db86b6d8de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSewUi/Y6HY8GlAnFELA3FoBKMaAUGQnCAuKF/jzyoffANS6T0kLDXmDsQYVJ1vD6XPa7MlLsDh29K7cqLMe/5A8Sg3whD2kxSMocq/nRID65UcbIGwa5a8cQwcl0m7WywBdr3cwMtLd22YxZb0cIIoB417FVe7vumUxG4f/mBOVXlKI1+4+Ymw+0E0vnUD14TQh2gnF+AAJ3u4ibPETia/zTncRkQ0B/UCJPuIbVa5E2zcKdaCD94cI3nuomzQCWGw+aash87RehYGnF7+ojqj3iQOOixytDCy9Jlt7gVfaBQoTJFPNbFyGB61fyjSqA912aRB8HAaFIXMpEjdKA1X08sCWHQT2fklzojVQvvvACEx6FDuSHq2yqmwrbjTtn9g98DaKvYxlcV2dNgvBvJGkH0TLh3ICD9qagWaeU/cAyfb7m6VbvMfAYosotGLLK943K+j9T0LbmmRKxuLYmWf9k1QCUItHRu2ZpLquAikhGHwc10mkSF9928W1X+4sbLfAO2ifdvdL2SaL+RQn56ZyqW6YzA5Y2cVb1jJ6nKJLjmW2+3oWziZw8zzerIzy1jcTh9oeKES68zzLmqS6jx/AEg71xGYWcD3p2bGuJqniJeVYcWhAZxvgvoPJJHvgN6+yPPHprOS7yHX7eW+sy/82trYjg77Ui8LyZoBZICE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(2906002)(38100700002)(86362001)(921005)(6512007)(82960400001)(83380400001)(2616005)(186003)(26005)(6506007)(53546011)(31696002)(5660300002)(36756003)(8676002)(8936002)(7416002)(478600001)(6486002)(110136005)(316002)(41300700001)(66476007)(66556008)(4326008)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ald6L1JuR2hMenVQbnJzN2YwOERRdlFxRFFrS3FhM3lpWEUvS01ZbCsvbjR3?=
 =?utf-8?B?eklOT1ZQOXRjbS9YV3hCanlzYmltcGdTM1JvMDNrRWFxYzhDQzdXUjdxWWs2?=
 =?utf-8?B?N2QwdThIRlZ0ZWdQenlTQ3NKeDN5SkdsQnhIakYwaDJSem40UmRWYmhqV0RC?=
 =?utf-8?B?UmxDdy9aL3pabnZYYkNsVkVGMUp6MllFYVRmN0h6WXFFRDQrRjV3d203b2JV?=
 =?utf-8?B?K200UWFFcUR6aWpkaWgrZ0t6YWxZb1JzcktibFRCVXN0TXZRcXNVUzAwZWNL?=
 =?utf-8?B?TGNqYzJ1cm9FeDVlTTJPSURWOU85aGVwaU1oeXFFYytubWZjNXFPU0Z0cmVt?=
 =?utf-8?B?R2FTeitaNmxKUTEzOHFBQlVlS3BsN0g4NmJaWjVaZXdsbXpjUStvSnB5YnJS?=
 =?utf-8?B?bDRoUG9RMnkyNXhWNDhiYk5KNkdGaU5VSG8vRTkzUjQ2TG84UzBaNzhvd293?=
 =?utf-8?B?dUUrRXVETHFQRGNQdHVGODk0UFlnRWh0ZnVLVXdXZDVGRnl3Z1BScW42OGU0?=
 =?utf-8?B?Zkp0Wno0a09EUTNqMHg2YzBsbFBXY0xDK0VqcFQycVBPdnpJTVlUK21zWVpN?=
 =?utf-8?B?OVZLcHN6T2t2ejRmUkdkbHdaTHI2M0xETStGc1VHdm9GdkQxK3lnbmRlRU5S?=
 =?utf-8?B?QjF1N2Nsd1BucXJyWnZpRVpSczdEYzVHaE8wRGVpZDRZQjErVS8xblh0QmdT?=
 =?utf-8?B?dUVCZVorUWdoSXpOakU5ckdNNko0QnJGWEFOcXVia3NKME03Qy9aaGd4UUNM?=
 =?utf-8?B?SnBFU3I0eEFlYlBGdll4Zy9PcUc5TWRJUHlCV0ZkUkxlOUx1MFVmL1prU0Rj?=
 =?utf-8?B?dTh1QXpHWVZKVTluUHJONW5aTk8rZG9nTG1WdkNXMHBvWC9pWXhNSTYwRUww?=
 =?utf-8?B?Q1FVYnc4aVcvblV6Y3NlK0ZDWUpaUTZKQno0ektpeVg5VEp5OW1mVzNXV2FH?=
 =?utf-8?B?RmhEOU9aaVYrN3RmOFhFMTBBS2ozdTZ4ODBtMDdTbTFNbXVIa0tHaFlLeVV0?=
 =?utf-8?B?aTM5bkg5WEFCa1lzalM4ZTFkd1FleUR2eUp2V3RibGYrQlE1cXZsSWY3b28z?=
 =?utf-8?B?TFY1dFFJanlqR0E1OXdRQzZlSi9qNFlXUmVEcnRQV3dQaWNDb01iYlJJNDNz?=
 =?utf-8?B?N3N4SkI1WklWRU91ZFVDMkpkNlhjQzZ6TGZZRS9rZWI2VHFLV3dqZlNLT0hu?=
 =?utf-8?B?S0NjNTUweWd0ekM0Ynp1VUJINTJLNTN2V1VtckJUVzZoYnFuSEZodnlSWGl0?=
 =?utf-8?B?ZUFIcHF3SVhGdXhrbkVONVFzV3h1Z1ZqT3BxT0lsbWJ5Z2ZmUnhTWGxKcDNH?=
 =?utf-8?B?RmlwYW9BRXZ2YXNwdXpxV3FPaVY1c09VN2JYZ3ZvM05qenNTMThDbG1VWDFa?=
 =?utf-8?B?eWh3d2N2cDQ2SmpYazZnOENsSkVmNXJIbDVrN2xrUUNTMkI0TWNWWFl1QVMw?=
 =?utf-8?B?N0k3citCZ0c5N2Q3UzhTNUhJTERxWDdqcGUveG5xcjdqUzBXbEV1NFV4Snlp?=
 =?utf-8?B?bXZtMDJKZXVFQ3lKVjVSQm8xVDBGN3pvS0NSTEQ5UStudnRBZlBTQ2JsMmtM?=
 =?utf-8?B?VGNHY1JySGd4NFBnOGQ3T1JMV2kzZnpZVlRGRE51c1liQnltZnFPOHUxVW0y?=
 =?utf-8?B?YUNHNlRvTi9qeEVaaGY3THRGb0kwYXhKQlhXeFQ4YjJhL0FKVXJRRHJ2NW11?=
 =?utf-8?B?dk9wL2l0a3BkalNiQi9QVzVjVHFTUUpNWExhM091TTJnYjJYazhxZHd2RktT?=
 =?utf-8?B?eTk2OXlqckZmWDNTT3RQVEN0K1B5UzhJNE9yUGpiSWxUTG1TaCtLNlc2bHBw?=
 =?utf-8?B?TzJVYk5rQjgzbUlUbG9NVWR3ejRzZmJmUUlkN3p6U2NNQzBITmFraUl2UGlC?=
 =?utf-8?B?OUhVWG55c3JkVmpxOWhQSVYvYU14UmdScFRQaVJkcXY3L0RXMXRSMlRlQ1Ns?=
 =?utf-8?B?MmhJYTlrVXdKcHNIYU1PNUk2YVVSN1NDM3ZsVFdwOWdxZDZ1R1ZkbDdXbjMr?=
 =?utf-8?B?SmZDQzZ1ZXRiWUZ6ejRjWHNpazJPSGtMQlM1dDExanNOSGxFelhNdWc5UFpT?=
 =?utf-8?B?bDQ1Y2pjMG5LY3duR01KeVNhd1ZDQW9FTld3ajhjRnlmaWp5Qm5wbEZ2Ylpo?=
 =?utf-8?Q?Vfj4VvXi4yvjK+NhJpHWddTyH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09345b19-3634-449d-55c1-08db86b6d8de
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 11:13:28.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CCk2zjsC+Qx+XYjni04q6T9fRqZA2i+Bq4hiuPY8ubcdhlPMuY0us/ufiCwfDPA0CN/6MXTl593cASp3+y8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7133
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



On 7/15/23 00:17, Ryan Roberts wrote:
> arch_wants_pte_order() can be overridden by the arch to return the
> preferred folio order for pte-mapped memory. This is useful as some
> architectures (e.g. arm64) can coalesce TLB entries when the physical
> memory is suitably contiguous.
> 
> The first user for this hint will be FLEXIBLE_THP, which aims to
> allocate large folios for anonymous memory to reduce page faults and
> other per-page operation costs.
> 
> Here we add the default implementation of the function, used when the
> architecture does not define it, which returns -1, implying that the HW
> has no preference. In this case, mm will choose it's own default order.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>


Regards
Yin, Fengwei

> ---
>  include/linux/pgtable.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 5063b482e34f..2a1d83775837 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
>  }
>  #endif
>  
> +#ifndef arch_wants_pte_order
> +/*
> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
> + * to be at least order-2. Negative value implies that the HW has no preference
> + * and mm will choose it's own default order.
> + */
> +static inline int arch_wants_pte_order(void)
> +{
> +	return -1;
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				       unsigned long address,
