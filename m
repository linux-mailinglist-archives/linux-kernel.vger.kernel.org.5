Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B639753177
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjGNFq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjGNFqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:46:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E8A211C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689313566; x=1720849566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9o9Jy3kgAn8XsbAMZ+JkTIQ2hMYXDK2SXjy10vqUtTc=;
  b=Zmq1xMjjaG+zHMpJdtUbdPKTvSZGquPUkyXFa1dkSKR/TuvsY8GqnQJn
   TiTSexe8ZQfcfFVeORS7+XcnxumSA85YZ6N/QjpVdJa3JM4rAMoh1AS9M
   qOdfVPZDGVAtfoDHPZdoX1Igq+Wd0h2V2vNtT3pdEgeS+w7vXtUPMoQkX
   jLkKcLljPfShSC2tZ7/aoTgffxNIWeBBCYXMDnAsAeny0S1bbNjx3/FXE
   NTBY1qq0sIG6xG7DCGdVrgptrI+3kZy/F8TfxrHgJw0ynNBM6OYiQXxEC
   /1fHTz/V+JC9A79BdAje7iEYfHrNLM49LVP++jjvCQsGvvXOCssG8V9/l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431568168"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="431568168"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 22:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846338937"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="846338937"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2023 22:45:51 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 22:45:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 22:45:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 22:45:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bxf0XHV9k9hNR9Jo/xU0a4F4C5CJJh6+CTrNXllvhYnBfra0q57gg3Pmc1wifoJpRaoxwKJMetJVtHlCQ/PK5huX/FRA99a0yUfviyRZXkCCgM8f7buzm+OKj6/X1dYRcEk0oSOjOtGhnBt4zcybMCanj7xSLZ/OyLkcRksdddR/0TrU+zIDfbs8iLm2ZgxPeNFlJTKAqp2BZdjC3hS1uz9BHQmQDjBbigWkkN+NvWrXXV4MS/rTiAlKQWjnqS9kOhWvveO3hOztF91XyUZS90HPl3+nr+Y3ZQBCLY7awox3StcBF6lQpE0vSokwQ22h+rqPnbb6Yt0UprxR2mP8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RdB9gylo6MVBRy9QZDaI6R/VSUTqzDR4t3aIPOc46k=;
 b=E3CY6xAMUQUgmmkYqrk1RV8Qa5SWgeQmapgNNNXUccari2AN9u1GOPkq7i0KoldEvdM9ffHYfx83loumYxRYvx7aa+5CBdjlY2AKZ+yqV5vqzlA1r6dDZn/YTaVXQxBv4fXiEU/XdVVhsS1QDOMfsm9xdJrKPgcREipdCydgioTaB77MlPQMcLJJhbs7U/o6TVWxPaeasCdTymJyb/v/W03gl4D4dBhg4eDFRKZWt4l33/34XXdSu3QJmG6swZBjJtPb2jlS2y5OHRUwsJa0oLghm5n7UP+ey+zm8bpt+WtmTCxiTQ8o41NcdZmAgSTa3ePUWkm8aO5GR83hcfvonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB8163.namprd11.prod.outlook.com (2603:10b6:8:165::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 05:45:48 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 05:45:48 +0000
Message-ID: <9112669e-544f-f628-bdbb-e62c0dce700b@intel.com>
Date:   Fri, 14 Jul 2023 13:45:38 +0800
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
 <c7d06f91-1552-9afa-a0ae-396bc9c703d5@intel.com>
 <7e21e99-8f8a-6f31-601c-a73ad6a0e87f@google.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <7e21e99-8f8a-6f31-601c-a73ad6a0e87f@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ba5713-fd8c-4c6a-32de-08db842d9368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPZbAsTurnri/P2roIDGE0/yL2WbkfGtfQQuDa40++Sx/bPPGaIesHRlBB+zmuZzj0KYI5F9nmRb4bFGK+kYMcIynIhJVREfb7EVuuxPUh0C3mL/bwqMIsLv2eEEI77dABORBEz+rGX78DPrtE13RpThIpjYR8yUYWbkfyIc/kPLASO7jGRkcV7rB2R0NLXRjq8DeiEintCIM5s6zcwJQDN844ICBU2ZfM6MoGeucoJByogzV94/Ug3jtTFK0hcg4UmbvNt7fyk2cjNOYbzr8+VSkZougQBBKcRvqVvpdNvrCg67lKx1x8JT0aoXvdYZ207uzHsMn30K3Ky+l8cU6sn7QoCEredS0g+37YH4XSS7Wm9J5/sElDXiiufB7SBV8Rb1MPfSfrh7PHi3/lP6Qp439Qz5QEEnJRIbpkxV10XgjCn1v5qpJmi7Wy7A2eddxiFhjwfFhoE/rkBsCBFHYk68jzQ9Im/7cA5k6EGjcktXZkVd/RwX0n6Rz5aK+Lt/lUAY6TDX/UkrB+qVXWxcIWMBG6FvL5DJuqCKiXblNLBONb6Zhi+l4vpnYdkpJ8kEnBTNbfmDVsvuCA8zF+Fchv+Mvu0NHdNxAqJ2RldNYnoS4F7lEt6pPxRvoMJjE02CYnllIpBq5eM5XepEdXlGew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(31686004)(66899021)(2906002)(478600001)(6666004)(6486002)(8676002)(8936002)(36756003)(41300700001)(316002)(4326008)(6916009)(66476007)(66556008)(66946007)(82960400001)(83380400001)(38100700002)(6512007)(31696002)(5660300002)(86362001)(26005)(2616005)(186003)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk5lTEZFMXhPSzU3OVpxZW9TQ3VsY3BNYy9VK0pzTVZ6dkRhSjEwWFI0cTRw?=
 =?utf-8?B?UmZQYmxxQ1JFNlRlREJxM1hOTjVSV3g3RW1kT3piMWFVTmpCK1VxbnB1TTV4?=
 =?utf-8?B?bHd5WWpDcFpzdlZhNFM0K0cxd2F1U0lwaHlDblpJSCswaThHSVVIVDRpL3Uy?=
 =?utf-8?B?U2o2QlF4Z0lUbDJOa0pYQ1pWM2JiOE5KeklEZCtGWFM5TktQVEdjb1pvZkNK?=
 =?utf-8?B?SlE4ZWtqczM1MVBScndMc084cTA1MnZNQ2JqRTB1bkJNRllhTGhMeWdzNkIv?=
 =?utf-8?B?dlRzWUxKWE5Pbmx6YVdBdXZLZkdVNlloUHhOa1BsWXVnR0oxL0R3NFpWOUdi?=
 =?utf-8?B?TWNTSFpQTnpjbSs5UFNvbmcyNE84ditFS2U4RmRaU2w1YjVEdi81QS9vdy9r?=
 =?utf-8?B?TnRmSG5nRFRQdWVvNjAvTVArQXJrQktUZ3h0cHFqRVQxM0ZsTTZKUlJEcTNl?=
 =?utf-8?B?K1ZueGhFTk9OdWlNYVZWa0RkZEtZVmxibW0wYmNqcktheEZMdEJvYVFlUldn?=
 =?utf-8?B?NXJLVGt3aldtbm9PdlNTQlRoWlJnQWZXdFMvdGxnbzlCQ1RxcmIvSzFBVVdp?=
 =?utf-8?B?cDdtY3RDMnY4VVVHQVdmMC9iNWVLVG9LT055ZG5ZSW9vYVBNa1ByYmVGVlVh?=
 =?utf-8?B?a2xVMGs4M2FLdElVVlV4Qk9OcDZMQWMrU2szVHpjcHZKVURYbDFFQ1FiTWtQ?=
 =?utf-8?B?ZCtQWU41cnUvSTFFczJjbFkxQVdOVmNmdDFvcTdPRjNFTEQxUDFKeE5RSXpS?=
 =?utf-8?B?L1NHNlYzR1U5cDJ4eENQWjlrbzhCSnVCOStPQ1poQWNrWnRHWnpqZ3NlZG9S?=
 =?utf-8?B?UEdnVURpNE04dmZFY0lYN0NvUG9va08xSWd1VjlBOEpJYWF3Tk9MZ1JJamVF?=
 =?utf-8?B?YTlwQlFEblRmSEZScjhQN0NjM0UweW41cTlKRC9HTzYwdGpWRHNCSUNWS2Yw?=
 =?utf-8?B?ZTNIK3dBREptZWFBc3lJWk5hZ2hRK0JaOVpFR1paanhQay9NYVIrMUUxaG1H?=
 =?utf-8?B?ZmJXVWxZMHRMajNtV2JTMVJTeTI4clBuU0FBcjhKdWdpUWNCeUVUTk5ld2oy?=
 =?utf-8?B?TGZqdzBmMFcrOTZUeVN2c3dTbmR2QUdzSE16R2hzenJLcXc3TnBEeEp3a3VB?=
 =?utf-8?B?WS91U3U3d3ZmTXpTanJUaDArRUNKU3l2ci91R0IyMEpZUk9Nd0FKZEErYkpv?=
 =?utf-8?B?bm5KNm51YmJrVlQ3VVBiT2dTQzAza01EaDdVQkcvdjF4Uk51cGp0M0NyMUs2?=
 =?utf-8?B?dHFNZlhjRDMrRGlxYWtPS011TW9xVEUvNDlyemFLbi85QkhSSFFhaXZ6emQ3?=
 =?utf-8?B?S3l3dWN4eHlhQ2Evbi9oRUpBZkJQV2xpYUpqT1BoUlQ0ZlFNMHVkcE9nM213?=
 =?utf-8?B?KzNrblg2Tm16Qm9vZmtnME5NTk1TSHJvZXZxdnBkMmx3RWp1ZEF6dEh0dFZG?=
 =?utf-8?B?QzZwK1lzcVF6cTk1clh2VmN5elFZZnNTZU16Z2FPTko0MnhNRS9wZDZPMFpm?=
 =?utf-8?B?OGpZdytFZEZLeXFFQ3RvYzZWREhyVThwREVIQW1BZ1FYWFZ0S1NXQXB1YUda?=
 =?utf-8?B?M0pMME1jb3Y3ZkxhMHlyMnBKTlFGWGwyRng1elZLd0ZhWGkyUThsWWdiNm1B?=
 =?utf-8?B?MWJCNUJaRXVSYzNkTlBvMlF5aUFoc0ZqYXNvR1B3ZTN4YldIWmZQYURFNklZ?=
 =?utf-8?B?UVhJdGVQdmY3USthSjdYL3JDL3doVnVyd1BHY0RTN2V2ZFdFcC96cmdQdUFh?=
 =?utf-8?B?UXNDTnM4dWNSMHBUNDRuaFpUd1cxQTRabXF3emkvTytBWFM4VTlobjRWOEpB?=
 =?utf-8?B?QlhyV3p0SzJnVGFDbC9NZUpwSmM2bFppSktrSnkrY3Z5bXhnR0lCZnVrVTZr?=
 =?utf-8?B?UXBJZnAzOWdWWi90a1dBOU83U2ZHb1hqS0pNdzRKc1h4SXE3MXFRT2E2d3c2?=
 =?utf-8?B?SWVLMlBONkxHMWhKNzAvR09Jb3REakQ3SXBub29YejVsaWE2RXc2L00vNUtQ?=
 =?utf-8?B?aE5wTVhnSE5aVmQ2TnhlbWZtMmJOamVTTDBLMjU0OFZMcmR3NENvYTJHcm1v?=
 =?utf-8?B?a0RyWGJkdEFhaEhxUmt6aXJGSkN3WXYyQTVMSkdvYWVkcGJLbC9mL0ZwOGRv?=
 =?utf-8?Q?GAzE3Lgp0l+KD6GXA92Lwcktw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ba5713-fd8c-4c6a-32de-08db842d9368
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 05:45:48.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1Yv0Z5TnIU9RwDrZdhBWJmbN6hT9UA0YHlaDsSxT+axHmYdVWQ3PHrLiKW3x+kmcuTywbXrKa1GiF43UG/0GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8163
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



On 7/14/2023 11:41 AM, Hugh Dickins wrote:
> On Fri, 14 Jul 2023, Yin, Fengwei wrote:
>> On 7/14/2023 10:21 AM, Hugh Dickins wrote:
>>> On Wed, 12 Jul 2023, Yin Fengwei wrote:
>>>> On 7/12/23 14:23, Yu Zhao wrote:
>>>>> On Wed, Jul 12, 2023 at 12:02 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>> --- a/
>>>>>> +++ b/mm/internal.h
>>>>>> @@ -643,7 +643,8 @@ static inline void mlock_vma_folio(struct folio *folio,
>>>>>>          *    still be set while VM_SPECIAL bits are added: so ignore it then.
>>>>>>          */
>>>>>>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
>>>>>> -           (compound || !folio_test_large(folio)))
>>>>>> +           (compound || !folio_test_large(folio) ||
>>>>>> +           folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
>>>>>>                 mlock_folio(folio);
>>>>>>  }
>>>>>
>>>>> This can be simplified:
>>>>> 1. remove the compound parameter
>>>> Yes. There is not difference here for pmd mapping of THPs and pte mappings of THPs
>>>> if the only condition need check is whether the folio is within VMA range or not.
>>>>
>>>> But let me add Huge for confirmation.
>>>
>>> I'm not sure what it is that you need me to confirm: if the folio fits
>>> within the vma, then the folio fits within the vma, pmd-mapped or not.
>> Sorry. My bad. I should speak it out for what I want your confirmation:
>>   Whether we can remove the compound and use whether folio is within
>>   VMA instead.
>>
>> I suppose you answer is Yes.
> 
> Yes (if it all works out going that way).
> 
>>
>>>
>>> (And I agree with Yu that it's better to drop the folio_test_large()
>>> check too.)
>> My argument was folio_test_large() can filter the normal 4K page out so
>> it doesn't need to call folio_in_range() which looks to me a little bit
>> heavy for normal 4K page. And the deal was move folio_test_large()
>> to folio_in_range() like function so simplify the code in caller side.
> 
> I realized that, but agree with Yu.
OK. I will rethink this as both Yu and you suggested same thing.

> 
> It looked a little over-engineered to me, but I didn't spend long enough
> looking to understand why there's folio_within_vma() distinct from
> folio_in_range(), when everyone(?) calls folio_in_range() with the same
> arguments vma->vm_start, vma->vm_end.
madvise could call folio_in_range() with start/end from user space instead
of using VMA range.


Regards
Yin, Fengwei

> 
>>
>>>
>>> This idea, of counting the folio as mlocked according to whether the
>>> whole folio fits within the vma, does seem a good idea to me: worth
>>> pursuing.  But whether the implementation adds up and works out, I
>>> have not checked.  It was always difficult to arrive at a satisfactory
>>> compromise in mlocking compound pages: I hope this way does work out.
>> This is the purpose of this patch. :). Thanks.
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>> Hugh
