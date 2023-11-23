Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED667F55C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjKWBLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKWBLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:11:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6C6BC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700701903; x=1732237903;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LLFUCyh0/O6FZPKXRj+qBugyD0+GKU+7g/ajgvE49ak=;
  b=O4ZGhAB+yIs/kPMLdd/n8S8x35e/ZJlYTt3hTw1RhnHzjOCNz64OKa26
   jq5rJDLRwvhG5YvkSIp2MHK87felmUMyQ4VJI0amFsTVkIzAtfxZEKH16
   tzG9FylzvoWk8pn5CL5j2B7uROgYqrc7qSatSWzUn9U5uXKZayaMNNg3E
   4UAmRKk8uFRKm9DoVd6NYCZzhsw2gBSsEOnfm+XErXy50vvnaWqok4NOJ
   rhiRvEXfcLMmfA58DKp0OZQyUQRfq+apUMp3ul1yAlwNxMUzoUsSJQX8F
   tb79chxr077K6teXeyM2xEV6Lc7yDhz8Z9hZvoCZmPqMJtJZyFbw4bjDT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="371526691"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="371526691"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 17:11:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="940444906"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="940444906"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 17:11:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 17:11:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 17:11:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 17:11:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBAs5liqP1SW5k8EH0YC/x7DDmaFTVqmnRxL/mfxQIF50/P/7pZwLvx2lbjWOZz9Dijfut7k65DD0aGvp6choUH5Ss2gN9/38xWUPaK2aRrNDrUlM9bLUj56gjpf6Pl/1TStRir1fUG7pKMBydo8mav9Cggpuc4zb6Fc+J2yIcrDvNV/oO9Ey8VEkJvbI+fbfGmB/LJ6PMChvoPGU8WcJxtKNfMt/Z4HVY+E1HKx74+wPo8DD0VzHZ8b/DYSPUApSbnVenRtiE2ONOtpxO/KCv5EnHNR3MJb344HJSAziUnrxnVNt3bRxmdAIEsoAVghuuRA+FV6LzdNLsedg9RGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1nPZLwbC8ELc2zHSR0BPSvkpV/2UPK6KtMbjeG0Uas=;
 b=Sfe1CMwMW1O25TVooJEKZN4PjfqTpTrDXOYtR2JXAnlQvdn9WQf9nKp+/bsAG3kZqMDuq3Mt7QONwItA0wBEX1NQlM7RszgIHecQYq18Aor8LnhPZE/mEZSYNCFJHiIKYfGfbe/g+zRKzf2QFgrioXrPDitFclu3KWJdriAlmmEKB4I0jyLU3hmJLIsqw82Nsj9smYIIh7Qgobtu5TTEq5euZxvF6F3cNkL7qbGbrAjgmTMKiVGeH8tFqBRVIB6fK4h+dr3EtJ0dAuxaj3q4PvMyEpLoPyh+mK8cnsmg4AeNIqNjDwsh6XjSM27t65Vb65BSS7hiLAsKuJ7MZPC1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB5261.namprd11.prod.outlook.com (2603:10b6:5:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 01:11:14 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 01:11:14 +0000
Message-ID: <f4dba5b5-2e6e-4c5a-a269-4abe8fe2bcd8@intel.com>
Date:   Thu, 23 Nov 2023 09:09:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To:     Peng Zhang <zhangpeng362@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <ying.huang@intel.com>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20231122140052.4092083-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: 4031455f-ec45-4961-0570-08dbebc11600
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SLwohBizQzwR6r6uLU6Jy6bRUDwyJ/wYZSSmw8Cj8OCrxalgFurBMMswWj6ZKhOYoZm3/leFR2zx+PitQ/qx/AIShsEnotq+c05V35Yx0wqtHmBg+NFT8yE5InaEbtF/RY4IohtkBOims9MS77eHWyXkPqmWRFDf8xyzT7y22W6+EaF7t/J8O2B8sAMtFCBXZQMgZR8XJMOHDrvBM/7P5k7br5bnIhsCu9uI21epalB6knYuirUoOrzWbq5REElORE8TogPuz3XxQytEHmxWxcl2G4kwPaJb66PlmJ7PEJcO0zZsTOkUFEJCI+QLt8xYXs5GiNKCUx1+HXdNQvPVIO6mp3N11oMc0x6ssLLa2GSp1BHoENFgxwALBJSl4kzRqW//ffysX7aHFJpFTTeYjcbT3AZz8JE+bvdyiMWf8jfmRLK3Y3jyKzANsUXmbKtWRhzpZbo53ak37NUZh+KO+puneRqllVgAzM1EZxhPRCJdIu5WG18dNh9rsGLndTmIvEaksxSY795JGNrwZypRVdN8TTmRu9x7ncEG4E9DjYsa76/kDG4B8IzapQC+aetG7UZ6HqKmQTS0VL77HJWTlFQxdX0y3paguQYiqnWFbYqBwRjh8oqNg1P+vwc4NaC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(36756003)(5660300002)(86362001)(7416002)(31696002)(2906002)(6512007)(82960400001)(53546011)(6506007)(2616005)(26005)(83380400001)(966005)(6486002)(478600001)(6666004)(38100700002)(4326008)(8676002)(8936002)(31686004)(66556008)(66476007)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0Vibm9EeU9LVmlWdzYvSGRoR3R1WkdkMWpJMVEwaUVlWDN1U0QzZzM3RmlY?=
 =?utf-8?B?d3A3UStLYWd6ZHdnK1MyT2FLbEtHT0d1UWM2eFBJaUFnZGtrME4zcVk5VlVW?=
 =?utf-8?B?ckEzbjAvMVVLUnVvZXJlcng1TXZSYVpqRSttVG56REQ2ZmVwT21RUmxGVXJz?=
 =?utf-8?B?U2FyTDAwY3RvcXZGUWRjR1E1N2V0MnBpNGp1M1dvRkswMHJvcWs4ZEFKQ1k3?=
 =?utf-8?B?NjdLeTRGbU8vcjZHWGhkd2wwTTJjWHl2VTlKM0ptRmNEWnA2Vis2VWpwazhC?=
 =?utf-8?B?ZzduZFNiSVZGaGxGZFhXeEd0VFBrbHZWTlgydkhrNitsUEsycTgrckc5ZWZw?=
 =?utf-8?B?OXNDNURmWVFXbjNzakR3REZpSCtEeGZNZzljK1puVDZWVkZhTzRTSjhsTGNx?=
 =?utf-8?B?TEdIRjhnUllMNnlMMGIxR0lSRmJIaElaUjJoTEg0UHBUclpJZHJBSDFBSGFx?=
 =?utf-8?B?SnBGVERNbUxTNTJNNytkeWF0VXU1QmxKV3o5TnpjUDV0K3YrMk9Rem4rYVVG?=
 =?utf-8?B?WVk3LzNHN2FYWnRyMFlBdFRlUWU1NDFodUl2NjY3NEVub0l0aUtUQ25QOW1F?=
 =?utf-8?B?N2RCNnBjdzZROEQrWmxpVHNtSjF2dGF3TXJVS3pwTUhLM2pMN1p5VjVmZHhX?=
 =?utf-8?B?NGpDdk8rQXNFSmFKZmpTR1hDZ1dLWUptZnN6a1ROSnhMRE1DTXMrWGdYdTZm?=
 =?utf-8?B?U3VtUnhxa0lkdVhseFdzbktQcmYvaDVGWFRoTHY4M3haeXl2N2RRNVUxMU1Y?=
 =?utf-8?B?UXl0M0FtWFA3SVRjUTZqNTBNRU1OTjErTm1JZGVLYWVuaFRnMXI1K0liSkow?=
 =?utf-8?B?Ukt4RTlyaFZOd3RoRDVrQkphYmltckRXcG9GUitySlZ5c2h0N1A0Uzh0YjAx?=
 =?utf-8?B?RHFtb2YxaDJzUEVISWRCc25Xazl0NkFEeldCYUdmYzloa3hMOXczc2NyU0I0?=
 =?utf-8?B?ZW4weFpDUVhDU3JkVzRSSWI2N0ZjTEMwRmRndGcvSUhKLy9rMEpiTFQzMWZz?=
 =?utf-8?B?eHJNb1JGWDNWaFRjcXdkWTBXN3lhZHdHR1JmL2VQVExYK0lNMnJCMDQ3UkFT?=
 =?utf-8?B?OXFzTnd4Y0VzWVJEcEpLZTlJVmprVW1vTjlBYm5zNER3eUVQMkhGWktRa1BB?=
 =?utf-8?B?K2pNVVpNQkZuRm82VFVQNnpvNzhWMGRPR25TQzhQNVFrQk5uVHF5MWZYaUdu?=
 =?utf-8?B?TEhmTnR3N3R4NStWWmVLbWxPaFdLeC9nTm90RGFxVTl6aFNlcldlQ3NITENM?=
 =?utf-8?B?NUVLVnhSWGxhMnRvVmE3V0pYVWZsZFA0Q2NVOTlCOXVUbTJjaGJXNnFaM05Z?=
 =?utf-8?B?WnVGY1g4Zlg4N1YzZW5TWVdWeU1Jbkp1QkxKaVFpeHdxR2dTcUNWVzdwazI2?=
 =?utf-8?B?RHRZZ2p3blFpOEUrUkZwb3FXNGh4ZmkvNnZwMVlOaUhYcnpoUy9DbjNJajlJ?=
 =?utf-8?B?QXY5bnh1c2UvNTlFMXVzZ0FmN0lpMzRjVHZ3R1dJNW5GYlZpTy85Y2VJRWoy?=
 =?utf-8?B?dEJISFpBRWI5cjdYbWVlVFpiL1N4eVlmY2FhYVlpUzFZeW5VWkV2ZzZtQ0NR?=
 =?utf-8?B?TmdIcm5kdzB0bXMrSFNPZjZvMCtIcnNyMHo1TDhUTkx3b29KakJoMXMwSUUz?=
 =?utf-8?B?YkVZY242T3FCQWFsdzBYMVpnWS9LOS95RFgzcExsQURkaDdtc2paZ2dwelVk?=
 =?utf-8?B?R2FhWGNnbThlMGthdzFWaHM4dDZLN3BENytxZFJ0V1FCSWVmcXpsVTRXMndl?=
 =?utf-8?B?UTVGeENjSUwxOW5iREYyazJjVTVTS0tINmZBbFFTQ2l1eXY2L0R3Yjd1UkNm?=
 =?utf-8?B?cnRzRDRFcnRWT2ErdkZ1RkFHSjMwOFhjU2ZMcnFRV1YwWCtTZFhoLzM5Vjg3?=
 =?utf-8?B?ZWRUM2xpcUwvS2h4QjIyRGRvMzBCT1k5SHZ0bG9iazBCaDNYYjNEK21GcmhM?=
 =?utf-8?B?Szg0bU0xRk9NWGdGYURpYU5meTgzTkhGRkIwczhRMFZqU3lqcHU1N0FmdDZV?=
 =?utf-8?B?WndhVkY2VTBvRXU2VFZkQy9lSGlxRnVsNkRxL2FocmRDeU5ORmJNMVBMTmht?=
 =?utf-8?B?UFFBWllBVU9pekpQSDVuSHlzVU5OYzBTcTFtRGxkZUx3VkpRd2xsMzAvdVVZ?=
 =?utf-8?Q?xfMnBCc/zIJfD4HeDsnP4EJlI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4031455f-ec45-4961-0570-08dbebc11600
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 01:11:13.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1acK8kxGxBcrRPtVloWRDe4CYvBVbEPy/oXhZwntmFcEF1ljv0vq8K40O1Pn+L1Xi2h1YCLPTC7E35ZF+8PMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5261
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 11/22/23 22:00, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
> in application, which leading to an unexpected performance issue[1].
> 
> This caused by temporarily cleared pte during a read/modify/write update
> of the pte, eg, do_numa_page()/change_pte_range().
> 
> For the data segment of the user-mode program, the global variable area
> is a private mapping. After the pagecache is loaded, the private anonymous
> page is generated after the COW is triggered. Mlockall can lock COW pages
> (anonymous pages), but the original file pages cannot be locked and may
> be reclaimed. If the global variable (private anon page) is accessed when
> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
> 
> At this time, the original private file page may have been reclaimed.
> If the page cache is not available at this time, a major fault will be
> triggered and the file will be read, causing additional overhead.
> 
> Fix this by rechecking the pte by holding ptl in filemap_fault() before
> triggering a major fault.
> 
> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/filemap.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 71f00539ac00..bb5e6a2790dc 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  			mapping_locked = true;
>  		}
>  	} else {
> +		pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> +						  vmf->address, &vmf->ptl);
> +		if (ptep) {
> +			/*
> +			 * Recheck pte with ptl locked as the pte can be cleared
> +			 * temporarily during a read/modify/write update.
> +			 */
> +			if (unlikely(!pte_none(ptep_get(ptep))))
> +				ret = VM_FAULT_NOPAGE;
> +			pte_unmap_unlock(ptep, vmf->ptl);
> +			if (unlikely(ret))
> +				return ret;
> +		}
I am curious. Did you try not to take PTL here and just check whether PTE is not NONE?


Regards
Yin, Fengwei

> +
>  		/* No page in the page cache at all */
>  		count_vm_event(PGMAJFAULT);
>  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
