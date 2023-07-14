Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA395752F87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjGNCtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjGNCtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:49:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0B32D5D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689302985; x=1720838985;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+fMC7BfZZH6Udrc7it0JlcjB+Q72+RSDH6ygregeRH4=;
  b=IVE+wSSUhHTNGBPsFtRVmXUdmKg4/t8HfpzLdGZvrsuDm061zZmfNeU7
   pKOmx6CDbbMLOIHgXVR/hnpdATzcnubzi9GzbYy2+IyDcBvVSIEYiiUiO
   PlJi0Yfi8CmEsOhX5UyoAuqnVS+ORqc0LlIEyeAAO2HE/0tPWuuXVhEl9
   sqIwiuhx4dcElIHWC/K04i5GX+Nc5Sqlm2QwIir8TOIQsUCIOz+q5pLks
   6ud6XWucT5rQ6TezsW5RM7EQ26mso1T3vDdJ0G+/iwMXlXYqAllluvTGQ
   bPzeZaM+9TfA+v6QxheciEwy5oXQumw3irRB7XIV4TG9xxq+lzsaFgmR7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365412059"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="365412059"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 19:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968853228"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="968853228"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2023 19:49:44 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 19:49:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 19:49:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 19:49:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa+kWDlmuFGzWJ5z0IfXvLDlzvJtCuvTrPQIOW7iPXGm4ztn9YrqdloU6fcnBvKKPvwG3nX8lIIkmNFv20M/D1eBbsxSqGFNIrx7PhWPpXkiJMeldG4wN1L555ZLNaAQHrC0W1PMBIKr3Mu2ClQXrn8PkSv/TRidpZlHPfrWTrBRo1T+XGo7US+izFhgQhTu/cGiocoQ5WFAMDy46UFtRVzw3alBHcWVr52AdQCG/ddZ9lA54fQhcIHltmzRIM6CHezLJyclLsQSJAOyov21bdbLbe+hnOZCgsOiUxuAVQoX2oCSZpnVy2y9Sz2dOpWAaabtvQnE+UjxOwnRDT6O2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKt1evRqsy8qXGqcEr5Z0SvIqgYCvSwAc1UocMolsYI=;
 b=V5lubnncz9+p4UMpQXNbKh0AkVleS1NXycmZM8RXAPLnPDxi950LBJXriYij5YczCv9VmPvmiTddA4/lb1SFppq6QgdRtmPQhWwASZSOcpAb/1GSV5694eZfP99wslFABK7mYqvue6w/VhKuzsaZ5ercv2NKVYOE3wkdC51X06FzTnscbTJwb//TF1I5UOJYUObXxmLzLdZG83rm3cxdCNSGEgg/YXM2S0fhPvFJui6n8/dyCmKdAzT2b87jhkMik3ro9ERoLRiOSODgRIk/zkPIKgrt9FKbe8Q0cqntcW5jLNouzito0eDU5dW/NqQqOw6Jqrw48Np5y8Akx4fwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB7268.namprd11.prod.outlook.com (2603:10b6:930:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Fri, 14 Jul
 2023 02:49:42 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 02:49:42 +0000
Message-ID: <c7d06f91-1552-9afa-a0ae-396bc9c703d5@intel.com>
Date:   Fri, 14 Jul 2023 10:49:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 2/3] mm: handle large folio when large folio in
 VM_LOCKED VMA range
To:     Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-3-fengwei.yin@intel.com>
 <CAOUHufZQ0EpyRZ_jAMxs8uNSQOz6uAkzVjvvgD+4wBvmgHJoCA@mail.gmail.com>
 <6cc5a915-a28c-983f-9b32-6040f033970b@intel.com>
 <6573e671-62e-b7b9-1aae-64336c32bf1@google.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <6573e671-62e-b7b9-1aae-64336c32bf1@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:54::17) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: d29c9788-c234-4836-6ec6-08db8414f918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eigSVKejRyYWK1ymggBzaR0D46d2H6/KEL39p/vx5RlpsIhPkKuWw2CyEpurelx0bLP0EIbGldgYM1nsc9tFJcGH7SpezVEmOwIQ2PIUPHlRx4SSTUVItq2A1U+j0pswAttidEbFnY4ji/YQ0I3EjlT5rI1HZDgUSgGptnl1A95KJAm15ida429EmT5NFe7L9IUicj5zHl7FAkO/BB3SVOUWK+0e3May1JQjwLG+Lklzf8qcQ+XJHNDzSM4uEALe7TFT2Og7L3Bs2df77kzAPrlfv7daKLXqJzuZgvtIcwAUiiNlDVVRbeYTC4u+wiwGnQbVQ2b/9Cm0pSqehMtxNqsEeqD1caiWRqE2AWn62+ur/ujitKAa4zgZwxw2EeQ8RWL2py4ibYEdURioJl4rjimyCtOoqZ3dnAWuFgd9I0iaxOg16xXLJ/zNprpWHpnNDJbPRgEqan1au1F6XszYhEtJ3EoA/L6G8yW40oRBfQLxEdzKRavhDxbuPyA4QWLEUAsZGM6EpdUgEL0PJ2oT973R86IkFV6i0A58fct8EJD56iBlHRX44DapDP4BN5z6sNSJcqaadVIK2Ti4FyGGeMYuaCgU9wzoDwJFwWZVBAVvH1R/dgyML+VTjZOfumNfpFwZTDdKa62n0wAjuQGXLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(316002)(41300700001)(8676002)(6512007)(31686004)(66946007)(6916009)(66476007)(66556008)(6486002)(4326008)(83380400001)(478600001)(6506007)(6666004)(82960400001)(38100700002)(31696002)(8936002)(86362001)(53546011)(66899021)(36756003)(26005)(5660300002)(2616005)(2906002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2lmelROdmgvZ290emljSnF1UWU4MDREd2IzR1FpdW1DbEwrMDBHQXBVbVQr?=
 =?utf-8?B?UXRJeUkvbm5lOWxUd2tCNUZCZ2xVbWdqemZNOUFUc24wakhsRGZydUNKK05z?=
 =?utf-8?B?TGthU2Zpb3gwSmxPZEtaRnkxWU5FWFlMWks0czI0OXhOSkhjOC83NEJOdmtJ?=
 =?utf-8?B?U09ZbzlvNEkvcmZWKzR4Snh4Mk45eGZMeXZhM2RqdWxmVlpMa3U2NnoxbWM2?=
 =?utf-8?B?M0U5S2ZkWm5rVlpqTm05Vnc0V3B5czFwWXV1aHNnc1RnbnROT2Z6d0dndDZE?=
 =?utf-8?B?VlRSWFROc1AwZklOL0VQQm4rc1hKSGZmN1FrNGpPTGtUdWQyVzBtSFNQc1ZU?=
 =?utf-8?B?WFJ0RzFVRXRBUm0wUTAzZE5oU0JqQ0NHaUtZUnlBRCtjeGJ5MmtlN0U5TG05?=
 =?utf-8?B?Sjk5VDR0SThqMXMraVdnOUpiUDRxVXF4b3I2RWZXait2R3BRUXl2TEtkbHM0?=
 =?utf-8?B?eVI4eXVTcXdnYWUyVm54Nm10bFBqb1RsbVVHYWQ4U25Vcy9tREh2NW05T2NN?=
 =?utf-8?B?cXpWQlhmVWFlcXV3QVJJS0tzWkx6TElCMC9OZndqTTVIRDFnRDk1R0hkUUxV?=
 =?utf-8?B?RnN3SmZrazlOUzAvb3gwTmNpL3pKcytERUZrb2Z5c3lZSWdKbUY1VjNLL3Q1?=
 =?utf-8?B?SVhSSkVVMTFTLzQ2NXpIcS9NVUI5bDgyanUvcDVoMDlUeXVWVHJHdjFMU295?=
 =?utf-8?B?emZkVzRKTTg0Qm1ZNyt2R002eVkxalcyT3JuUFVkV1FoWERCYUhoR25Cay9t?=
 =?utf-8?B?QWlCOVZHQ0picXhGa2NLR1FyNGFETWcxT3hKZ3g5SGJCWlpmWE5PRVVwYzRM?=
 =?utf-8?B?Rmw1TWRpZ2Y4TmVCc2JkVlc0VHNEUmhsZnlBS3c5VE53bXFZeVk1SXI4WmJu?=
 =?utf-8?B?ZXNCTmVKa0VyQTJPWkkzRXlqbkUwYnYvMEgvYlNqRmtsT2VqbHBYcXBpbTZ5?=
 =?utf-8?B?UC8vQ0MzaHg4cEVhMVhzNGZRdi9VUitVVVBQUlJEZGFWcEpzVWx2KzF1V0xv?=
 =?utf-8?B?N0t6aTBEVkphOVpseC90bTBRbEtGaGo1aTRqSjgxRnYwSC9xM3FxSXFNTTFx?=
 =?utf-8?B?S3BVWnl1S3ZBVHIzYnZjV1hQU01UM0t1M1hDK3FtZmZUdlRJT04xQnZ6aVRP?=
 =?utf-8?B?ZEh2MkZNcWdDZ1dnS1Y4TmhVQThrOEpURm82UjdQcDc5VDNnVFQ2NmNST2tV?=
 =?utf-8?B?U1R2b0lIZXMxTlBFVEFlZHoyL1ZGQVhFMDh0RFNWTklZYjJ5cUJJNUQwMnpY?=
 =?utf-8?B?c2FTVGpGcC9YUVZxdEtSYll0VHNoby9YdmtDZlk0Vk4xaXNYUGZVM0pVWHB0?=
 =?utf-8?B?MnRwY1Q0OHRSMysrL2orSSsrQXcwalc5UXUrZndycnI3N0NVSUxIRDN4N2hn?=
 =?utf-8?B?NnNoU1FwVjFJdzVuamlHNGsrbmtYaE1kS0Fhb25YYWNTb0x4UmppWWNMbGJ6?=
 =?utf-8?B?NkgwY1Y5RHN2bkVGTDBBcThkVmZYL29heGR5QVhMalBEaWQvRFkxRjQyV3dI?=
 =?utf-8?B?VmNSZng3b0krYnNVaDVudFZmQW1ETGFQaXhhMGczL0cxSXl4M25tb2N0T2xq?=
 =?utf-8?B?ZTFPVWxZNGg4NXRoRS9FUDRQOTN3a3FhbEMxTnpLZDZNQ2NXejd1b3lPK2pu?=
 =?utf-8?B?dGtlMTQ4NkxzYkRnWEUvdFUvdmxqU3dGU2dxU3Z4akZUWXlrVjVUVXhXeXpQ?=
 =?utf-8?B?WVJmSWFyQWg0RWNuZWF4YXlwQVRndFlWT3Q1dFhMcVVCSEZJbVFRclUzZm1h?=
 =?utf-8?B?S3FrWE10OTkraTdzZTU3ZlA4bG9DUFg3UGZPMXlCa01wbytiR2JoOEZLV1Z6?=
 =?utf-8?B?Z3hncDBTeUtUaVJXQnBaTzNxcXo2a25UMUdwcTgrVWRTc2J0QzVDa2ZROWJC?=
 =?utf-8?B?VGFTTEFCZ21rZzcyMlVlVHUyUDNvZVBJcnovNkVQaktaL3NLWkcwZkJDbHFj?=
 =?utf-8?B?WUI4bXNFQUdWZlJ0eUJIVkxacFV5bWdGVEhGOUl4cnBJdUxVSU9vaG01WFFD?=
 =?utf-8?B?ZWsycjZhdFBUemZhbjNZbklzVEN1Qm5FZHBRYjR2YjRWRktXWnUrYXhzdlI2?=
 =?utf-8?B?Ymtpa2M1L25Sa3R0WGxsV29JK0VLQ1JkZFliSGpzc0hHSVVoMFBxUkIvbEhi?=
 =?utf-8?Q?69jdHTbxN8/6jDj403meKgHDh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d29c9788-c234-4836-6ec6-08db8414f918
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 02:49:42.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpFkA6sveebJ8favwnBS5D8JhgbRoUAcCv4/WZGdp1iCt7D7RZVpCqTdppWSKz6OZP2hGIJlrdZYBEhXNJJJbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7268
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



On 7/14/2023 10:21 AM, Hugh Dickins wrote:
> On Wed, 12 Jul 2023, Yin Fengwei wrote:
>> On 7/12/23 14:23, Yu Zhao wrote:
>>> On Wed, Jul 12, 2023 at 12:02 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>> --- a/
>>>> +++ b/mm/internal.h
>>>> @@ -643,7 +643,8 @@ static inline void mlock_vma_folio(struct folio *folio,
>>>>          *    still be set while VM_SPECIAL bits are added: so ignore it then.
>>>>          */
>>>>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
>>>> -           (compound || !folio_test_large(folio)))
>>>> +           (compound || !folio_test_large(folio) ||
>>>> +           folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
>>>>                 mlock_folio(folio);
>>>>  }
>>>
>>> This can be simplified:
>>> 1. remove the compound parameter
>> Yes. There is not difference here for pmd mapping of THPs and pte mappings of THPs
>> if the only condition need check is whether the folio is within VMA range or not.
>>
>> But let me add Huge for confirmation.
> 
> I'm not sure what it is that you need me to confirm: if the folio fits
> within the vma, then the folio fits within the vma, pmd-mapped or not.
Sorry. My bad. I should speak it out for what I want your confirmation:
  Whether we can remove the compound and use whether folio is within
  VMA instead.

I suppose you answer is Yes.

> 
> (And I agree with Yu that it's better to drop the folio_test_large()
> check too.)
My argument was folio_test_large() can filter the normal 4K page out so
it doesn't need to call folio_in_range() which looks to me a little bit
heavy for normal 4K page. And the deal was move folio_test_large()
to folio_in_range() like function so simplify the code in caller side.

> 
> This idea, of counting the folio as mlocked according to whether the
> whole folio fits within the vma, does seem a good idea to me: worth
> pursuing.  But whether the implementation adds up and works out, I
> have not checked.  It was always difficult to arrive at a satisfactory
> compromise in mlocking compound pages: I hope this way does work out.
This is the purpose of this patch. :). Thanks.


Regards
Yin, Fengwei

> 
> Hugh
