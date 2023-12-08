Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755D08098B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjLHBmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjLHBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:42:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A11719
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701999737; x=1733535737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c+QWJpbDAtagLjhOzVlLoxD4aQhJcWOT0rHYgQsmy/E=;
  b=Ukb3RTvAslZShhDCywE+GwwSk9KcWuWcuhV9lCSsQHCHyUeg10TrXwVN
   lgISoKLNplm+orIR2k8jqgzrT6aagHZzaMWc1ejgNnhTkiJRKLcMyMcAI
   zFcGdof+NazRVrL1F/+82h2UXgNdNw5nfUnEFUqg4xN8Wbpky3FYXMp8W
   DavPUtT4YpALbv1pBdGyZR69aJL4N2bpw3lpOthTBHbU3K9G7tWgVBcCL
   uh9W07Cp/PNJ8OBt2k7Ljf6fOHKcTSc262y8G9uvpOuJYypGJeJTWcVmK
   SZfJ27akw1FLo/MJo/DKC+1NUrw4NWpjv2NcqVfC8UsDePScXuMG2H/Fq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1223595"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1223595"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:42:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842427019"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="842427019"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 17:42:16 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:42:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 17:42:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 17:42:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR99fwAOVHFUJqvXCLHzdmJ4QRJ2U4+n+FKNwFzwNyMyo5hLDlAM5zBOsK8pflKI7X3ny+G2UT0Sxe63IkoX6XDWo7FMx6Z1nCbJOVN+E7fWMn1RcOvfbRZpsa7qDcw2tekyjhzSm3mxppJjZGV49lZb5IOWBL+5ATez1H788CMraYEJNQuKId7NDrzk6NkTX1IDeBUudLYFyC7/pJv7ssPWtxTeYZLhlaG6a/hU/K7pX3T+j590z5yApPCbYj+WI9NU9KP7eaR6YUCipISf7wWr/VBjZ8jhboXZReOoN/tDAIuMVfFB6dUhkqjd9myZ8QLWVgAVU1XnHCxDjxCY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhLwtvi4OQQWxIdOW9b9KdSbexiUXkaAMX88jfSiqzo=;
 b=T6U1iMR5SZlY/eqwc8+3Sqbv9suOX8q4acVIOlszrv4tdlum6lRYjKAwAHK1n5pCeg3sE4TDvYWg34mx7kxW7ChSNrXDSDnHgIazmVmNodAQC0TJQRefvxUClH8QTTrg3awhKVV4aHKKfv6RoPOfL8FtubO8K1rprpzaJUp1qzu094d9Erw6GmnDxynSDyRwFV5Gf1CCQCbO3xk7vB8Z+ioDc+L9GSoNtNiTyPv55F306AwAQsMLfSJpw80LlDBHwrkIOrUwpkpDbVz1mOU1LYya+4j6kY2/oOrbDubr++vIwf5B1v9xvkW9oTRLo/ZTlgLEapTSQGO3vIfbcbHTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 01:42:14 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 01:42:14 +0000
Message-ID: <0a734107-292e-47fe-b2ac-d295ec3dd9a0@intel.com>
Date:   Fri, 8 Dec 2023 09:42:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/39] mm/migrate: page_add_file_rmap() ->
 folio_add_file_rmap_pte()
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
 <20231204142146.91437-11-david@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-11-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c7449b-1432-4971-e7ca-08dbf78ee732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wHp9QOixMoGC503XmNZUekvSCZYwYYYfs1zDvg8bHE0gcWP3DdUv2o9Ec2LvL9a3H+6GuBbsGEBi9BVEq/sNVtFG9KNdbLwdJRFHEWiGv+AayU4pl54XSyW/7UoUBSMbYIx0Po+0DlIPkTWwyr26RnVRHYyboA0VUGfOlmNSR0vAWYaZfp1l3uwlBzz4IYy2crtzvdMDHD71Uo8KIg05QlnrgF2qKS3egjt0cTJ2U0+CkTcHtfHUgm3M0OBKxt4vjKhNrWhcQZdNuKvVEVAMrHVLaEzWJ787r/xqEY/9MxsUq6ToS4CFY4hqQx533Au6Te8ag32gTyGJmGnVFz+EvWHvb064drW0Ku0Jx+M5cqFEKIF1QBKeqg030V6CzJLEZoVAFEUSkzAtCb3Vww7QHSp3coWtFSY6FIU9oZ3w1UX9uxC+W/8p/tGijeZ53naFLwVcPRPjPGZpWDKbL82A57c2IgoLdVvyMNRQlJuuShnF1dmTslJhwmq7z9RBoXfiaYQvANT4OrSnWKH6hDrUODms+Bg1V5T1A+oSyHEAD9yKxp0lo5metT3iOPAuHgynS31nNyMYcUWbBJqLllM9OTJKDzAoubFxEpTVssQbwmXzmSVCwytVN1WhgMRv+3Ocx6AYaPlD9QWIT1ZiVwov69RNTbBDgIvlGDPcfqouG6TQb/kGI6pPBlWqKvgkiTbd+Q3HepfKnlvJtiANKodrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(66556008)(5660300002)(66476007)(54906003)(478600001)(4744005)(6486002)(2906002)(8676002)(4326008)(6666004)(7416002)(316002)(31686004)(8936002)(6506007)(53546011)(6512007)(26005)(2616005)(83380400001)(41300700001)(86362001)(38100700002)(36756003)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWl3RzdzVUlIMS9BWjZpYTJFWmptZXZaUkdmc2l1RzJ1Wk03L2RDeDhNejUv?=
 =?utf-8?B?WE5UTnh0N2RwbE1ISmpxL3ZMZU5NYWNIVUZPSGZBR0ZFWmk3amNSWGdBRzNL?=
 =?utf-8?B?V1RFNWNONjE4NmpGVHlLZ1ZHcXVQdG5lQmJIbCtMUXZ1anlxMWRQc29xbTRt?=
 =?utf-8?B?cTNyb1VYcEFraG1OaVBmbHNkS3pJVXE3NWdNRmQ5eFk0UHBJdDdlZTd4eDNH?=
 =?utf-8?B?UmxIbjJvNWJpbGRLQnhib2xYUjV4SVBCSVdHRUN6ZlhCa2JrblhvUkxxTnJi?=
 =?utf-8?B?S1pkU1JVa1BnMjI1TkI2Y0FaNTgzWTAxa3RVSFU2WHRRTVhXL0N0ZHh2QW9q?=
 =?utf-8?B?ekFCRGtCTFJBSWRwTEI0Y3pOajZCVUdGMm1hQW1nL3o2TFcxcG5TdjdIa01y?=
 =?utf-8?B?TUFpWElNZzBHZzV2MFpvdExMd1lybEo1Yk05dEcrMlpvaWMzelc2emtIbTh4?=
 =?utf-8?B?TnhDL2xQN1p1VUVSRlZwSjROQ2prSGQ1eUNjNE1JN3Y0WDVMWXQvRytMRHRN?=
 =?utf-8?B?ekpZb3NEdVBoUG1nT1RzVHlHZEVRSXJzT1JlZDg1Vy9nb1JYMi9ZU0JBdktk?=
 =?utf-8?B?OTJCM05sc0ltUTFHKzhMamVZaFZ6RFNPbTQyUmh1ME0yQm5jUUdleUJRbDlL?=
 =?utf-8?B?NEJENDJaYXBFekVub3RPNlNOWEg4eERkcS9yaHRTbWtiUXBLQVk1empCU2ZD?=
 =?utf-8?B?QUJidmVuRzhwZVNGVmFuYXFSbHdCN3NMUkNTcU5SeWRMbFdHOVJQNWwzeVB4?=
 =?utf-8?B?OUE1cFFyK0FaN0hQek5wMjhvRlVHNGdBa1RaL3g3Q0VnaWJNdG41NndDSHJp?=
 =?utf-8?B?WXFsSCtwNTJrWW1TQ0FMT2FncnEzWHUxWnhKTkVqcjNvbFZtZDdleVcvSnpw?=
 =?utf-8?B?MmM4aWdUd3hOM1JhTDBKTHRrcXgrK2lpUUx2SWFmVW13Sk4wckNlMzNxVzVv?=
 =?utf-8?B?UExGa2g2T0lHKzVrcElWN2xxZjR1SWRVWkZJWVBkcjcwZmljckdUY2JkNnVI?=
 =?utf-8?B?SWRGRVVpMGZOMm93dmFxMmhNUllmYkMvcW5ON3JSNDZvNlV1ZVU4Z2ZwWUUy?=
 =?utf-8?B?UTlWcWhCRkpmZW9KdnBZcVpHb25vS3ZhbWc3Kzh6cDZuWEFTR2ttMXhmK0hw?=
 =?utf-8?B?Q1lpMWVqSWtWZC91dWlVUCtPYlpXWmdPaHBoeGFxMmhEZGpkOG85NjBGSFFr?=
 =?utf-8?B?VG5qL3pNVUhtTTBlL3NqZWFSVjUwN1FZVlJkU2t3RXkzSWJVYW4rdzZLdXJV?=
 =?utf-8?B?S0doRFRMYUtLcldPbW43OFpJNWswOVA1WFc0Y3A1dW9LemFrMXBVbG5MWUov?=
 =?utf-8?B?cHAvSTRzT2pUend4QXB1N3B0OVp0SDB0Vm1tZlNRS0JGdFduamM3aUJuako2?=
 =?utf-8?B?T21wOEttOE1vVmYrMXFvUVl2M0M3Vkh0bDJmUzFmeXpNR2Y5NjNNSkd0NVov?=
 =?utf-8?B?dEJzYjRNcW52QnRPVHd5Snk2RjlpbURjUGttcTltUGlTTy9KdDlVZmpFdFMx?=
 =?utf-8?B?SXAybUVIaFU4b24yWkQ2L1ZsZHV0WkhlSkVWNUUzTjJ0Y1FYZVUxZWt6N2hS?=
 =?utf-8?B?WkRidzNFOHhsTW5XY3M1NWRFTXZJazVjb0NOeXNOZjlIRUxMQjVnOENKK01I?=
 =?utf-8?B?azdUa3drczlQdmtUNXd4MmRqRCtJcjdSa1MzaTFiZ0dJazlwbmxscnpieWsy?=
 =?utf-8?B?amhEcDVmdnc1QVZIMWlXTS8va3RVUDN1Rkd0QUhQV3BvZXpGNXp3N0lJMllX?=
 =?utf-8?B?Uy9KbmJsd3lQSWRLT282NXRyT1g0UUVxdlR6OWY5YWNzM3FXM2c5LzlkcmRu?=
 =?utf-8?B?Z0YwMDJDcklkZk1YOHlLWHhQbE5FSTJHUCtzOVl0eGZibmJZU1RuYnFPems3?=
 =?utf-8?B?M2RSdFRYenhsZXZJaEJ0dkIvR3E2Z3V6RFNVR0NCdTRBcU1BaWJQb1hvYmZS?=
 =?utf-8?B?QnQweWpKTStCQUVaUER0a21TMWFkRXBCTWN1VVFvelg1YTZRZHhuc1RpVCtC?=
 =?utf-8?B?SkI0clo5bTlLME9HUWtqZzcxT0NyOFlUUExGYjRMS1pnWnNRbW1LOUQ1MnJ0?=
 =?utf-8?B?UlVJbTRoNDhFQVI5VXduOUErTGZJLzJia2kwOVB2S0JMc1pqaVJYS2VnK1I0?=
 =?utf-8?Q?++GE/7n6qXdV0yHuyZ57dk9qq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c7449b-1432-4971-e7ca-08dbf78ee732
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:42:14.1672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8MMmMaHX094xCSXbTSkDZORf9sqlxjdEH+gwE8OHbI+XKFXnSqke98DAtPwH9tJcbQaX/1KLuGJoijASsz21Q==
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
> Let's convert remove_migration_pte().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>   mm/migrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index de9d94b99ab78..efc19f53b05e6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -262,7 +262,7 @@ static bool remove_migration_pte(struct folio *folio,
>   				page_add_anon_rmap(new, vma, pvmw.address,
>   						   rmap_flags);
>   			else
> -				page_add_file_rmap(new, vma, false);
> +				folio_add_file_rmap_pte(folio, new, vma);
>   			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
>   		}
>   		if (vma->vm_flags & VM_LOCKED)
