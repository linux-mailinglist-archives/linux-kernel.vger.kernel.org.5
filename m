Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC4806415
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 02:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376416AbjLFBZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376353AbjLFBZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:25:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0EA1A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701825912; x=1733361912;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0mMbZ6ajPksa++Olw21FT/W0LMMXx0sv00DnGurUT/M=;
  b=ZlLrDnGj3SpRDHNBkm7x8ScTuS1YL1FfsWO467sSfPTd6XHDzkLiQlzt
   1QOJPQTDEASYtBbqw/dl6ONRastazH8qt1osInUIGPedE2KBgA7HpCzyk
   DZi8H9ipdlOmUTH2ycu6IyLAVhGdKfye25LsnTLVqDYkWLDg225QKMJZm
   v8MnygftQE06gjIlGouSWcg+I0inLWbTtY7DNYVVobTn+bjm/i8cTOPNb
   M/YWEKg8fEB9fR8Ij4crNxfSu32RB8dsTr1Hgzc3FKjCWAWACk+e90eVc
   S3dmzdWTAhrk5N/kvdlZBgqas+brFxzSuWWKeNeV9sIqKZ5LgcUnHC9B2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391155150"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="391155150"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:24:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="771123418"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="771123418"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 17:24:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:24:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 17:24:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 17:24:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciKDRSPf0sTMiIkzdsArkch84WdJzTJu30HXAlwZ1nYAZK1IgK9xotZD8CeHySmXom9CRA7D0uNyjbH1sEf6C9t579mUlkah8JbfKe9ai/2Ef/N9PZA0rZ0TJ5P80DU8DIlhNaTUH5jo0k8mA1IXw20lRD6znlOkNtltW3Gn4VTPcZr5gM2TC9h20HPTwikn53VqzVMohZii63FFM+Duwb5WI3pt52ZGd8zJuoMp8KzSQez+O2RbV+DiZKYeym+f3Zjjs0+5KLzei/IjJ/op5T/QRBtRPH4efSjJHT+NMeeZ9FwwssM/Y0G0AoZ26QhnuyUFSegRlXhZOKcmbY6dBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah0qUI+E2KqYyZ66gDDnze/d6bs9zluZTMSD3TQzGxk=;
 b=VnZVx1TIUz/t3FbVjFcrYfGwIOS+dwXfyoF3RbwIoBImDu3ku25PrVqk1tgX2iCe/Fx0EPu4j0hhMv6na74aBX+UA6aNwJQj0l/CVwxPfvSP0RH5CptCBfdpce3oLRE8zC+FnPl8/C0ReQpQkbO2IwXrsD28J5+NKsRLPXVF+d4NqVjGjrVq9ER/JgO7+ai16uUH+lrcBDaeZ/y9rRgrdPv5tb/x1QVU+N1YgFnRcYC3P7HqdVHAapTZfm9BAhEUkxFeKZs1BN/1+eRTHTYGJzy1nb+6JMJ3q9LERzHG6wAIWvf3GBxaCo8pN1BJa0WjKoxqjKFx7tbSDnwT6AT7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 01:24:48 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:24:48 +0000
Message-ID: <70cc29f2-6018-4794-ace9-d96077cfed6a@intel.com>
Date:   Wed, 6 Dec 2023 09:22:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/39] mm/rmap: introduce and use
 hugetlb_add_file_rmap()
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
 <20231204142146.91437-4-david@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-4-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: ec681715-86d2-49e0-39eb-08dbf5fa2365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpx5rwLAc4LKxIAb+7m14/ZIbdO1FbO1R3krV8cxKEEyc9KYmT+tSD1ecF6PziMLHTx8PUVkRfzUKtwgo9wIdFFqTgsjM3cw8YNB8x7yDSS4UQ5eRmRFQ8UDU/PXw0F+LM3UyG6BUwO0lVES3NakiDtREQNbBDrY9iKNeIM3F8X+ras2qqwZNgFXJEK+hgMcYlyCV6Ebwh0shP/5cqv9VCKL9G3jeoCHuKJtslXKoRXX1syG7YjmvVR5ltdXgV2cpITj3VwTFtpBZVWoVA5HrXGAJpNWVVArzUmCwSvu6Rsrs2wLy+FOtYP9YgSBcGjvXQbQoCqN1Fq/tiKkzuQi7jgRsggNft0h7RkH2APuZQjB2WyQYq48jJrwRXrIfuJXcXOtBskd84QWFCHxvjyYlZ25Y+PS2i1EEjWzGgjhsQW/WFQJ86F6ajOxdAP5MowOOaLNAyScLg7CZDkdb3iMMDmAs7W1Up53DB61SYSZBelbw+62Dkdw8rtMDAC4EIJmyVJm48ESJFwumtECDxF2r5bKTSPOgBp9QtPtquqARxH6U/brEhUxwfR5OOu/5h+e3VYcfIK3t5gIHsrQIeiYbl5aOyXi1RdXHxMgZTJGeIr7dxLZ+hZfO95Nyq4oxIOiAEuCsAJqWaRFX5VaWq4yGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(82960400001)(31696002)(36756003)(478600001)(6486002)(2616005)(26005)(6666004)(6506007)(53546011)(6512007)(8936002)(8676002)(4326008)(54906003)(66556008)(66946007)(66476007)(83380400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE9PaWtjZ3ZCVHFTRUdzRzFYRk1HUlIyaG5IcTByMnh5Tm1wVXBycUhuTnlt?=
 =?utf-8?B?bjNwQ0cvcTFQbzAvcE5xTjJ6bkZhZ3dTZ1RtYU05SisvNDVCOGxwQm1YZnhC?=
 =?utf-8?B?V1VvSG1KVlRCTDZ2c3g5ODViUmgxVm5la2RZMGN1RGd1RTVkNlV5MTZKaEVz?=
 =?utf-8?B?YVVicEFSNUV5bEpRZTUrcHNtVjhwNmxCM0kwQ3l0VTY3TENwVXFGTEtXOVRC?=
 =?utf-8?B?UElDM0FsWVpJaUNmQ3BYQTFLcnFXWm10QjhsUSs0M0p3c3hJU1ErQmV5Mk5C?=
 =?utf-8?B?K2VSb2FtSTRnNlBpUTBIOVkvc2xKOEMzSHRsYmkvNDUwK3RiMkI4ajNHM3pa?=
 =?utf-8?B?b2NOcUcvaVFseGpPWElRelhWdDhTM1JqOXc0UmJxbHFsTjJ5Umxqb0xUQVpX?=
 =?utf-8?B?bmMrZFRhbmROWDVoMVBiR1oxT1VpNE5kUVYvOXE5Y092KzdPM2dGZXJGcVNU?=
 =?utf-8?B?SnhObHZMNEJMZHNtdDVvdmdhalZNekNTaXFQT05mQW1qais5ekhLbTlqd0JQ?=
 =?utf-8?B?WWkwc1NIUEhMK1hVak9xdnYrVXh6ZmF4VUFlMExZbGJyUTdObzhkOFRDMEl4?=
 =?utf-8?B?L2E5aW90TVp6ZHpRR2FTQ2Q5OXR5UEdJUWZWenlWa01LRjY2ckoyQWViTmNH?=
 =?utf-8?B?dTh1SGwweUxhOTZqUmVLY0t2b3ZMMW5QY25SSXMyRkFyTWJHSFh2ZzA1YXpp?=
 =?utf-8?B?OC94YXRYMzB4RFZ6OHlzOVFvVlJ1Y3lvcGNkSDc5UTFqRmQ1Q3hBdUgxQjBO?=
 =?utf-8?B?NnF2MjZ0K2ZRcDJOSEtjZkF2OXd2eENDbGpWWTJQdzNRQlhFRW1NRmNIdm95?=
 =?utf-8?B?b04yN0g4aTNPVHR1UjBpNzRQbzZha2Zpam9QVU1MWFAxczRISFVBd0hrR1dx?=
 =?utf-8?B?NGNFYjdMUGRPUmlTa2hybjR4NGxIVy9TbUdVWm5waVp2dkpLUFdoRkU0WmNv?=
 =?utf-8?B?M055VlFhU1Jjb3lRQVVEL3d6anhrMm5ZeEtGM2xFTlpyUXNYb2Ira0hNRHhl?=
 =?utf-8?B?QWtmVXpLSEcxa3RVbUxhek1UYjl0dXY0SE1xaVhvYWxyUE9PclFVckVyRjlm?=
 =?utf-8?B?ZEFwZGdGVWFKK2NQRUdEbEtzVmZyRG5BalFDWDNQYzdxUE9tYXJJeDZtenl1?=
 =?utf-8?B?SVMyTjZ6MzF6Skl3ZXE2LzN0bWpEc0dPbG43V3JrcWRrS0d4Tlo2N09hOUNU?=
 =?utf-8?B?REk2L0c3V0JJRG1VeC9Ycjh1V2VwY1k3WHovUFpyRjU2amM4Rm5pdERldkdS?=
 =?utf-8?B?OGlqNEhDOVVTMUtYTVdaWE02ZHhVeGNDazBKbkc3ZGZobDQwb3dwWk4vMzZZ?=
 =?utf-8?B?M2tpY0E1dUUxbmVYZXN6cVhqR0daUmxKd1pHNndSVElhRWlUK2RQRnNEK2xx?=
 =?utf-8?B?alkybTkxUTl5VjdZT1RyTlIvZjVyaG1EaFJoM1hOd3hGcXpjVUluN21GQTk0?=
 =?utf-8?B?VDBEOE5DaDVhU1lYUEdqQ25GajVSdExjUzJLVEIrTVh2SXZTdGJwVFI3TkVL?=
 =?utf-8?B?ZTU2eXE3V0dwUkxLRjFTWjk4L1B1QmJIbkVyOUVJb0ZMVkNaa0t0U01LMnVE?=
 =?utf-8?B?TXZCN3NSQnJiK28xZ1k3cklrMGRqVStsV0tucFhlQVNIdHB1eWFaVWIrTXJy?=
 =?utf-8?B?VTJZRTNiRlFVUDJLMXRIRmlVRHdiRC9hdDJjT3BUdStzLzlrUXVwTkc5K0VN?=
 =?utf-8?B?VlhBZmpsbU1UV3VJbGM1NlN0UURLR2pYTG1IZFpTcWM5c3hmYllFMnF0Uk53?=
 =?utf-8?B?SEQxdGVxeEJ4UDNpMDBocTlVNCtMYkNwS09XNS8wdVRRRDJYTGhzaS9KOEQr?=
 =?utf-8?B?RmhWUXNQRGVzQUQyM0dPeHk4UW9IYzRFWkw1RG5nS2loNHEvVkl6WXoramg5?=
 =?utf-8?B?QURJV3pYYzlvZzRYNjBxUUYzZUwrQjZFL21reExVWXV6LzRtdExwb1IraXJ6?=
 =?utf-8?B?ZDdyNXM4WW1UYlFiOGFDNlpidjFHNUhKY3hhSFYwVHpSb1ltMURRMHRyaHNh?=
 =?utf-8?B?R2I0RFdvOTFCVVdHZ3RRZzRUMyt0dnNQYTE2WExCSlNnMlBEY2VEbm0yNDY4?=
 =?utf-8?B?RFpETkg4UkdHY0FwVGplUHhpbzVRdnRJUTlrMTJyRlh5SjA1WCtTVlo4aDhG?=
 =?utf-8?B?endyRWc1S3ViaHlydUJmVTBlNTk5UkF0WWVWY2NYamROY1F4UFR6SE9IbDRv?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec681715-86d2-49e0-39eb-08dbf5fa2365
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:24:48.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C63fS+VgvEuebgMNya2RRGMb7id13kLbh7ayr84peeNyjcHFc4MCU81Rr+M5PLYIH+oNYJ2HnbrCEbc9BjKRlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
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
> hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
> For example, hugetlb currently only supports entire mappings, and treats
> any mapping as mapped using a single "logical PTE". Let's move it out
> of the way so we can overhaul our "ordinary" rmap.
> implementation/interface.
> 
> Right now we're using page_dup_file_rmap() in some cases where "ordinary"
> rmap code would have used page_add_file_rmap(). So let's introduce and
> use hugetlb_add_file_rmap() instead. We won't be adding a
> "hugetlb_dup_file_rmap()" functon for the fork() case, as it would be
> doing the same: "dup" is just an optimization for "add".
> 
> What remains is a single page_dup_file_rmap() call in fork() code.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>  include/linux/rmap.h | 7 +++++++
>  mm/hugetlb.c         | 6 +++---
>  mm/migrate.c         | 2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index e8d1dc1d5361f..0a81e8420a961 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -208,6 +208,13 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>  void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  
> +static inline void hugetlb_add_file_rmap(struct folio *folio)
> +{
> +	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> +
> +	atomic_inc(&folio->_entire_mapcount);
> +}
> +
>  static inline void hugetlb_remove_rmap(struct folio *folio)
>  {
>  	atomic_dec(&folio->_entire_mapcount);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d17bb53b19ff2..541a8f38cfdc7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5401,7 +5401,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  			 * sleep during the process.
>  			 */
>  			if (!folio_test_anon(pte_folio)) {
> -				page_dup_file_rmap(&pte_folio->page, true);
> +				hugetlb_add_file_rmap(pte_folio);
>  			} else if (page_try_dup_anon_rmap(&pte_folio->page,
>  							  true, src_vma)) {
>  				pte_t src_pte_old = entry;
> @@ -6272,7 +6272,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  	if (anon_rmap)
>  		hugetlb_add_new_anon_rmap(folio, vma, haddr);
>  	else
> -		page_dup_file_rmap(&folio->page, true);
> +		hugetlb_add_file_rmap(folio);
>  	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
>  				&& (vma->vm_flags & VM_SHARED)));
>  	/*
> @@ -6723,7 +6723,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  		goto out_release_unlock;
>  
>  	if (folio_in_pagecache)
> -		page_dup_file_rmap(&folio->page, true);
> +		hugetlb_add_file_rmap(folio);
>  	else
>  		hugetlb_add_new_anon_rmap(folio, dst_vma, dst_addr);
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4cb849fa0dd2c..de9d94b99ab78 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -252,7 +252,7 @@ static bool remove_migration_pte(struct folio *folio,
>  				hugetlb_add_anon_rmap(folio, vma, pvmw.address,
>  						      rmap_flags);
>  			else
> -				page_dup_file_rmap(new, true);
> +				hugetlb_add_file_rmap(folio);
>  			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte,
>  					psize);
>  		} else
