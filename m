Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E50810990
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 06:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjLMFiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 00:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjLMFiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 00:38:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D42DD0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 21:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702445896; x=1733981896;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4L3vwbbSWcHyjp9VkVXi6Nvb2/yoZ0u33vWPTMUntf8=;
  b=FobBYMKb7HoyKE2C5Argj3LKdGE1HmrXt+QPwQhDLZqohuYbDmcN2WqU
   G2gzWeYSGYrUlqIKy5nWk77ORMj8TTJiLHxvvMqFM4GFiFTddK8Koci+T
   xadIUpUYdaOG24zX1PbA53D53b+9Vb19jTxXQFe3P0ObXn6yibD+d7OUL
   Z4yPkukHLUsgdLJr2Sqs0xkjja89OdVNn81htVykzz8ThhcD7m8i7KT1h
   GspsfnJNNuCJkTRBIgoPj/TKRTXIM9w5oNaieHArD6V9iYN8E55VNCgQQ
   IXDFNuoB20nvROajYI1gljIIDrG4T5XB/DylYLBl4yqCRhL/kz5avqhi0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1758453"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1758453"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 21:38:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="808038188"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="808038188"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 21:38:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 21:38:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 21:38:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 21:38:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 21:38:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CybwUBnGtu1kNPsMY3dqtMYsLLt6pbW9K1uhzJTlxjgtes8j/95DRMDKc7dnSw1zF7Gfqs4BEe5vkuXjkLsPYOji9mxG9Xv4NVtB2/YVIBvj5uj1dwioin8eu2vvY4sG2ptTYpCEV4j+ZwdomHEw6iqVH52ASCNZ0xTSgtpNRAoa2/KRTMqVCJj4MbLg1vLSIFwh2ciK/DoFnsqiaYYKWBD29fBzf4v3u+o7ui86lHrCvorwj/Du/4yugUE7Ih3q8Cdb5BPQkWeSomJFcBBeiGvdEJV76VudXvManuiYOGLNnipaNxW7NxXtMuAw13pbWiXakMusicqPiwlSf3ZDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+rojhFGtclpwyvuhynDJZMvviirAAsEfkmUKkX1nNw=;
 b=JMPP3I47OyZcT7v7hOb84RbDseK7LNOSbl+ENV7P7nKA41Zc8oh13f58Nyc0TP998zSdLYFvUiqtKljJFjKx1h/Ge/EWZIHWSI8MuypU2N8os3j/BWO1hVvh0oCWXzETd8M2tEaM9qos+PbMVhLZlNNjP1nGqxF50mMErc9wbWSO3m/GIdOUwqTMtjHl6njk+8835x0dbPkx466dvUSFgIscP+9yQlT5tX7HTEKU1oUrXLZYwDtq96aQGEHxqMJBEKZZdJ9j/y37VltiTaVk98LaXeHKCMP9XbzCPdAccupSDtxNne4qT+S/PosMY//x7cLB2hsd8r2cj1E4t1usYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Wed, 13 Dec 2023 05:38:12 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 05:38:11 +0000
Message-ID: <d4b2c0be-1885-455c-8f26-a23b3db537c6@intel.com>
Date:   Wed, 13 Dec 2023 13:33:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/39] mm/rmap: convert folio_add_file_rmap_range()
 into folio_add_file_rmap_[pte|ptes|pmd]()
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
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-8-david@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20231211155652.131054-8-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS7PR11MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9f31e4-2a76-4e6b-9ec6-08dbfb9db17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66JZuK3Y4im2jwvEbmQoKgErjS9tUBFP3J8DKCEjxxq43dTuMiYJEmyKyK2SnIO7NPGUNP/FPmok6Z2Wp3Pm2MbXwPwdp/HKB5RdHGktCpTiftoR6q7GxHpZGX9BFBA4MVsiIgHWtkuum3Cgu3oWKAcOawbv9DV8he618ZRb36BaXW2ghgoGg+hNPVS3tgBvlH+tI0P3VdlFKGLlUOpcs25DKwGgGExVaFrbmZKKcSTUEBDb6mBGe3PdjI7cOWY3hd5ddIea3F5aqa+v71OJMBbQLUGZGumgLuNtKUQwxYMam95NKtfJXhEReJw9gJ06ZkvcIpKD3MYh3t+aSw+LAMktZcce/ffetCF4Yrj0oLIS/594eSTTvDNWrmRE98aHOwKCyKDrP5o80dmyFFD6BaxJ0eydef2ESYBDAx+mNfjdfd5tXbcx5y+BGr1FZfC2lpojIy35Hft8EPupHAy1RBKL1FWYdRoG/stYaZbIJms3RS//JvIvWK3xnKBoe7O6IETbErQTWa6Bpirjfi45irJRMscERuizgoGHybBZBT2yev79fXKWUMCOw62snpOIqZbS229jTDMmuyDVKSzfqyNR9XlYrT9BoA5lembhA/Wr54CHqRsZNxtGSMzoQINmEJ0MfI/AGb61gFG4cBnVmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(7416002)(5660300002)(8676002)(8936002)(4326008)(41300700001)(53546011)(6506007)(66946007)(86362001)(31696002)(82960400001)(316002)(54906003)(36756003)(31686004)(66556008)(66476007)(2906002)(26005)(83380400001)(6486002)(6512007)(2616005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXkxQW5NTWFPamkybEx0eUU4eXY1UlpCeHRNUWZwR0piLzRxZFFLbzNCNC9C?=
 =?utf-8?B?bk1yaGc4ZUFpV0lNUGFqZzAyQVVua3hPQ1BKVlE4RHlMRWFtZndTY2hEdjF2?=
 =?utf-8?B?a1dDamFQbjhjNGVoNURUcjh0bnUxcEVrakhXdmxHS3M0b2lPWDRBUlppd1hW?=
 =?utf-8?B?ZUo3V0Jla0FySXA0dUhiUjgvZVF4WS81aHl0SS9IT2VsOWUwSmhiZFBIYWc1?=
 =?utf-8?B?N3Y0TnZtR3hqMlRKSUQwZXJ1SWZXOTBwOWxOWHhiZHFEdUprS2NqU3h2dXll?=
 =?utf-8?B?ZHBaTWN5SjNXMHdOeWtHWGxDQzdzRG5ieFVEMlFwMU5wenNmdVZIbE1pdzFB?=
 =?utf-8?B?M2NFaGhqMUpZVUswTjdKY0Z2QW1RcmRTWFoxZFdNalhJMGRUNHBZbjR5QUxp?=
 =?utf-8?B?QzRMNk1PSDZ3bnFNcldwMllhTWpSc3ZpLzd1a2RUUUZhN05ZL3Z1aElMVTla?=
 =?utf-8?B?TnhCVDA2R2dsOGQ0SFZMVlZJaUIxZHZydEROTjNWSzNBNzZPYnM2eGtWczZt?=
 =?utf-8?B?ZEtMeGxma3JPRzFITGVqRXFEdzN0Y0lWSlVjUVRXN20yMHYyWGs5T3hMMUlT?=
 =?utf-8?B?SFF0WE1FNUVJdDdDaGtpRzZKUWJmNldEMW91NjJoZGptNEFQd2lLK0ZYYTUv?=
 =?utf-8?B?cnlPVGtFNmQzL3B2TFYzSElzSGxPYmZUSDdrZUN2Y0hWczY0TjhZUXhOYU1h?=
 =?utf-8?B?RXozeTgrL1lZR2FPQjZLYnFjU0NzZUhQMWpwcDkzaHVHZUx4MGliS3BNa3RG?=
 =?utf-8?B?dFRuRDc1YkNhZFlZbXVGMVpRZzQzWFhXclU5dXhtYUZqQnRJRjZncmZ0ZHBp?=
 =?utf-8?B?YWQ2dThIQkZzTVVrbk9kNEh5V1YzMXpkVXh2M3ZWM0RpeWE4MitFc2M5NGZp?=
 =?utf-8?B?b0x6a0tkTFJMT1BKbTJ4cjl4eUQ4L3FiMGdjSURJS29LWDZHN3NKR2xGSHVH?=
 =?utf-8?B?eGQxQUY5Z0FXazh2SlpBVVhsY2krWWtrbVduRWpkQ1NhbGZJaHFCTDQ1SmEr?=
 =?utf-8?B?aXgzNlVRcWZzMHVldlRENVJrb2laU0F1SUx3ajlycURYU1l6QjJvektFVkNv?=
 =?utf-8?B?TCtvY3VXL2pQWXFQdU5QYThBYlJyeHZVV2hXcHp0S3Q1Tmsrd3VLbHN0UTQz?=
 =?utf-8?B?andSbTRzQXUwMHhLdVRRQU1BaXRXV0E0ZjBaejBQbDlrc0o4L1A1WFhjZnow?=
 =?utf-8?B?SGRndE5RYm1Cc1VPQ0NmcGFtT1FnYnNqRjZQU3lPaHJtTHpQS250Qk9ua1Jq?=
 =?utf-8?B?bkZYTVJrbWZjYmJaOFlWZEpLcjFWajNhUDRTeFI2L3VpdUdmYzdmQmU4UlQ1?=
 =?utf-8?B?RXNKeEwzQml0VHh4VWNGbENwL3d5TktIQmZaT1pZb2NBdDJyeXRCV3Y4aCto?=
 =?utf-8?B?M05CUzdlWDV0WElvS3ZDWmhpc3dtZFdPNUs0MHRiVnlnUXlCeVh4Y3JscjNq?=
 =?utf-8?B?L3NKc0dxWnkwV2JCbG15SE44Y0xxM251aWFLRnpueURlMXdnMDU0b3kwMjUx?=
 =?utf-8?B?NjArOFJ0cXZxNTRaRUtoWkdOc2RiTHBBTFc1RXhNVUF6bGtKbExJenFoZFhH?=
 =?utf-8?B?cEo1ckFjeS95MHVzOVBBU0M1ZkVhQk04WW1xRkxZVDlXOVVIY3Q1WTd1WS9R?=
 =?utf-8?B?Z2xvUS9QZ3N2U0NmWm9yRDkzK2FDSVZKc0orNW1OU1NrQm1YNU9vaHM5K3VL?=
 =?utf-8?B?T29GM0R6eStDTTFDY3Bpck5GQWFJSUZIL3YwM2dqajBobTE5UmxDbC9xajRi?=
 =?utf-8?B?YjRPRE9xc0liOUdqaTdjY01BeG5RcWNaRGhMdDV2aGR3RldPU05CTG9HVldj?=
 =?utf-8?B?SGhHWC9hOHNqK0hVRzQvWlpPenVDd3lDUHh6ZUZxSWtia2ZJR0QyTXE3NlRm?=
 =?utf-8?B?azI3WlBLWmRldHZ2SXVNT1BLTEJRa3N1K0NOaGZ0a3ZUWk96a1hUbW96R2pj?=
 =?utf-8?B?dzVlUkNtWmtWOHhyVFVCSEpWSjNPMDBFTGQvZkhTUk1kbUZ0b016dyttakFV?=
 =?utf-8?B?d0N3dmR3R2szdldSeXk2a2VDa21xUkw3VGZlMlF4WWdIVENHT0hnTWpsVFpn?=
 =?utf-8?B?eEhiSFlRUytxOVpUMWpJSTBCOWdCU3NrSUZkVlk0NU55TndINlpKRVZDWGNu?=
 =?utf-8?Q?BtuRqyzD8Ho17Is8YRowtup0m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9f31e4-2a76-4e6b-9ec6-08dbfb9db17d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 05:38:11.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hg+/BoroJc2BPMoHYjUTxAjlHEKmwk33uicOxmtxo2yx9zMlrxHv8/LZQy8IApShVagdsiiRDklObCDdJQ2mDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
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



On 2023/12/11 23:56, David Hildenbrand wrote:
> Let's get rid of the compound parameter and instead define implicitly
> which mappings we're adding. That is more future proof, easier to read
> and harder to mess up.
> 
> Use an enum to express the granularity internally. Make the compiler
> always special-case on the granularity by using __always_inline. Replace
> the "compound" check by a switch-case that will be removed by the
> compiler completely.
> 
> Add plenty of sanity checks with CONFIG_DEBUG_VM. Replace the
> folio_test_pmd_mappable() check by a config check in the caller and
> sanity checks. Convert the single user of folio_add_file_rmap_range().
> 
> This function design can later easily be extended to PUDs and to batch
> PMDs. Note that for now we don't support anything bigger than
> PMD-sized folios (as we cleanly separated hugetlb handling). Sanity checks
> will catch if that ever changes.
> 
> Next up is removing page_remove_rmap() along with its "compound"
> parameter and smilarly converting all other rmap functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

With one small comment.

> ---
>   include/linux/rmap.h | 47 +++++++++++++++++++++++++--
>   mm/memory.c          |  2 +-
>   mm/rmap.c            | 75 +++++++++++++++++++++++++++++---------------
>   3 files changed, 95 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index e3857d26b944..1753900f4aed 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -191,6 +191,45 @@ typedef int __bitwise rmap_t;
>    */
>   #define RMAP_COMPOUND		((__force rmap_t)BIT(1))
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
Maybe rmap_level for enum name? To me, PTE and PMD are level instead of
mode.


> +
> +static inline void __folio_rmap_sanity_checks(struct folio *folio,
> +		struct page *page, int nr_pages, enum rmap_mode mode)
> +{
> +	/* hugetlb folios are handled separately. */
> +	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> +	VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> +			 !folio_test_large_rmappable(folio), folio);
> +
> +	VM_WARN_ON_ONCE(nr_pages <= 0);
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
>   /*
>    * rmap interfaces called when adding or removing pte of page
>    */
> @@ -203,8 +242,12 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>   		unsigned long address);
>   void page_add_file_rmap(struct page *, struct vm_area_struct *,
>   		bool compound);
> -void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
> -		struct vm_area_struct *, bool compound);
> +void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
> +		struct vm_area_struct *);
> +#define folio_add_file_rmap_pte(folio, page, vma) \
> +	folio_add_file_rmap_ptes(folio, page, 1, vma)
> +void folio_add_file_rmap_pmd(struct folio *, struct page *,
> +		struct vm_area_struct *);
>   void page_remove_rmap(struct page *, struct vm_area_struct *,
>   		bool compound);
>   
> diff --git a/mm/memory.c b/mm/memory.c
> index 8f0b936b90b5..6a5540ba3c65 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4515,7 +4515,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>   		folio_add_lru_vma(folio, vma);
>   	} else {
>   		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
> -		folio_add_file_rmap_range(folio, page, nr, vma, false);
> +		folio_add_file_rmap_ptes(folio, page, nr, vma);
>   	}
>   	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
>   
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 41597da14f26..4f30930a1162 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1376,31 +1376,20 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>   	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
>   }
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
> +		struct page *page, int nr_pages, struct vm_area_struct *vma,
> +		enum rmap_mode mode)
>   {
>   	atomic_t *mapped = &folio->_nr_pages_mapped;
>   	unsigned int nr_pmdmapped = 0, first;
>   	int nr = 0;
>   
> -	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> -	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
> +	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> +	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
>   
>   	/* Is page being mapped by PTE? Is this its first map to be added? */
> -	if (likely(!compound)) {
> +	switch (mode) {
> +	case RMAP_MODE_PTE:
>   		do {
>   			first = atomic_inc_and_test(&page->_mapcount);
>   			if (first && folio_test_large(folio)) {
> @@ -1411,9 +1400,8 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>   			if (first)
>   				nr++;
>   		} while (page++, --nr_pages > 0);
> -	} else if (folio_test_pmd_mappable(folio)) {
> -		/* That test is redundant: it's for safety or to optimize out */
> -
> +		break;
> +	case RMAP_MODE_PMD:
>   		first = atomic_inc_and_test(&folio->_entire_mapcount);
>   		if (first) {
>   			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
> @@ -1428,6 +1416,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>   				nr = 0;
>   			}
>   		}
> +		break;
>   	}
>   
>   	if (nr_pmdmapped)
> @@ -1441,6 +1430,43 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>   		mlock_vma_folio(folio, vma);
>   }
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
> +		int nr_pages, struct vm_area_struct *vma)
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
>   /**
>    * page_add_file_rmap - add pte mapping to a file page
>    * @page:	the page to add the mapping to
> @@ -1453,16 +1479,13 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>   		bool compound)
>   {
>   	struct folio *folio = page_folio(page);
> -	unsigned int nr_pages;
>   
>   	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
>   
>   	if (likely(!compound))
> -		nr_pages = 1;
> +		folio_add_file_rmap_pte(folio, page, vma);
>   	else
> -		nr_pages = folio_nr_pages(folio);
> -
> -	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
> +		folio_add_file_rmap_pmd(folio, page, vma);
>   }
>   
>   /**
