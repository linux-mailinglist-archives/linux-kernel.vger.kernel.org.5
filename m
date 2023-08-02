Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155BC76CE09
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjHBNMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjHBNMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:12:22 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E491DF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690981941; x=1722517941;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=YwW/mx/0efIWWqL0iIFHtaaAjq1DhZ4uVM/8DPP1hTQ=;
  b=HqxThnRQBUCCIvQfsyIG3mpQWW5QhbJyI7rpsEsKdLM/Q9a4eZcY/J0b
   D68lu4N52QXeJm+0FPOWlsC/iKub6t5/M3t6NC5QucFhJauRN4ABXi49o
   c0uBgvdV4QtzozDAQbDYPPGYG6MrsHE3/OVwjTosLf0rDI+eZBpWbuEFZ
   DehK08grZmqZq/bLOxYI3I8r9zUwcY+vz+QjLSi3iGs2dLIAY7b0BDjII
   17OpTHJWRwhVYzZVoUdW9ONE2Uzv5jp4Oo3qPRHgZoBT0K625YXCMOLkg
   vC3yDXFEBYCdj26WyrQMqgATs780MqVWjFan5RiSB+h0uy8NQnNSp0l+9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433413847"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="433413847"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 06:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="819216335"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="819216335"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2023 06:12:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 06:12:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 06:12:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 06:12:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmNhNPDe+xRrane2ZGU7WNHRuozpBMBC8KvlemjHb8qqEYTjcyl7o+DhBx7bGfhwne/IqOJ/ANQhp/lqzr+mDxf4IJOS099chiDmf1v5AhQ9i5/A4hdMH6eFQALIJgUdPLRFfJVF8WmoKe4Tg7NKH9dyTtyRc6wumMBXj86NFbFpwopF4wI21TLr93vWnlizZbEBvv7hXL7DuCJR0p97X3HrKn8mPux3IvVMcwGyDhRcDPkWqWqs/BZ8f/WijwgxPWPuQ7cnJqc9QhyRzi2FChD3zI0jk6w0t4UPnbyWJbur7AwkhCwMTihn0TuS+09Yiqf6Kqv2qn6FanrPOROoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWfE2mxeZaBFiSGQ82HbEukN2nCDUIu5xPkDOm4MlTE=;
 b=e9U6VkDpvUrWUYHQitfSzL1o/g+EdhYnU+zeunefsHAahIWyNnFKUS7hSghaLXvVPtK7FTWrMRQzo6R4SkepL3IhOh+X5Ds+HqJIdz4sFGIOe7YHIro+iPtrAeiOm221w2Bw7UI8QI0AtTa1yXWkDU705V1bu4tK7BqymwYfZAGgRg4bvVjW2Z5bCuVaEXZNZYGCbVRuo+BJtvAXsy55KyPWtEUcxxq+pE25AB+fYF7N+kd7Axc2lKEapp2SeUUz/KF8q2mf5NTdqrSM9+L9ktaMp/lvIUWiHsX6Gg7MghtwbtMHCZgVyo7hYc4NceLYeNnc6q/zYBG6mMdaUIZJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA0PR11MB8378.namprd11.prod.outlook.com (2603:10b6:208:48e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:12:17 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:12:17 +0000
Message-ID: <a6ff77ba-18f7-f3ed-3f9a-00f04edccdb3@intel.com>
Date:   Wed, 2 Aug 2023 21:12:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <david@redhat.com>,
        <shy828301@gmail.com>, <hughd@google.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <55c9e3f7-099d-6f57-32da-1f318a9688a0@arm.com>
 <9bba9369-e3f5-53da-bf8f-8ab887d3c3ae@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <9bba9369-e3f5-53da-bf8f-8ab887d3c3ae@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA0PR11MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d736c04-7e8e-4ca6-9825-08db935a1891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JfJpT5V3DB81UHXTjK1vTrfjlFnJfg31Fkl4vgE4dCwU+eXehr/GNm0ZDZ6hYFhSbLpNlhXtLSF30vHwMOBMel6EZCFMv60REReYoa80NBGPstqNz3ky8zYxOuRsjzo3XhYRH+SjV5hfYGXBoIIb64tfbWzwP3PD3yhD1aRKv3tRFO9opE37wFNXVr2NzsslZBtw1mn9WAiJ/ydkBvJ7aZo4aqnC3NWSpJg7Koo45ojFPDFcb9n3X2oWOgJQcQXlEwAZY/qq6f2ijlPRXzRYmMSz0tSCA6LzR2bzJm1tEGbcYEcWCrtr0fWCT2FT/sWvcFulYGCKs/8Ezjl2huOpt87CaljFZ93nDWwG6GXZkgq+l2DbeKoO7fEe32MMNuOWO09Z+nI5k3ai7+q7nf9UJtgIB2Ddjgza8Ezehs4WPVqxKalRVj0vPu1XaVKnPyONeyCsuQtJnVTvNoTa1zAos1JlGl0EB17DqYovh4XyuvNPAUzfmGjKdCTKjvRePIQ9jDcTe6mZD4LuWvOrU3v06TvO0W2gL0dxeb6gWRHB+BKfIsd756J/9LFGavD6xGzp4qnmJd30mmCuErJmtRpbLqzU58Z09wLqcHjbYria2sR3eHqZ9gb6nn9uDIgOXdy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(31686004)(8676002)(5660300002)(41300700001)(2906002)(8936002)(83380400001)(2616005)(186003)(86362001)(478600001)(316002)(53546011)(82960400001)(26005)(6506007)(38100700002)(66946007)(6666004)(66476007)(66556008)(31696002)(6486002)(6512007)(966005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZDUVZDbEZuNzlGNDk2UzFhTURLK2QvVnNmQ0o3cXg5ZDRFVVJFakJUazl3?=
 =?utf-8?B?Mk93NUhaMnZYVG9VYkVGNTE4VFJSM1BncU5EYmhLV2xDZDRNdnpWNVhHaGFx?=
 =?utf-8?B?UUlrNnRrWmFSRC9XajM5UWs1OUx5OEd5UE5MdXQ2YUF4a1ArU3FpZnE3YndL?=
 =?utf-8?B?Z2tlT3J0WUd6ZXRJUFloSXJqU0hLYXJQUC9TNWhZNHpDV1p6Y3JQY0x5QXcr?=
 =?utf-8?B?VFNzQUs3VS91RFB6dU5jRlBFUHN5WS95Wmt5NGpSU0VzTTBqbHV1VVVPOTd0?=
 =?utf-8?B?YW40THE1V1NGcFc0S1dGQVdnTWpJUTNaV3FGWEZhTGRYZUk1VjFNTHBGVzNt?=
 =?utf-8?B?d05neGwybnVuMzZxTHgvdU5MUHhNYmV3ZnRYWU13Y1lMQksvM1owS1F0VitS?=
 =?utf-8?B?aytDSm43NGVpUWJvRHk0N0JadU1JNlozUnJPdzR3Z1A4dmxGb2lLREl5L3BE?=
 =?utf-8?B?aENhd2V4NWRPZjNBWU1Wcm9rK2pzSXFJeEYrM1dXeXY3ZkZ1bkpWTFl3dDhr?=
 =?utf-8?B?d2VQSWxTdE5EbXUyRnpFUjVrSk5hOGQ5aUIza1hmM3Z4cVl5NmdLU0NPVXhW?=
 =?utf-8?B?dkE3QkFQL0JXb1huS0FPZXZwdFl4bGFodERKK292eUFmWnRtMWlVTGdsWi9L?=
 =?utf-8?B?VGpVSWZBbHBBcVgrVHEzdGNYaTFucGY0b1J6SUErSjVGODl3MUMycDJaVFdx?=
 =?utf-8?B?T2c5Wjg1NFJNR0NiYkxyeUliQ3d4ckl1clZ6eUhKS2Y4ZWdQS09OeE9Fa0FH?=
 =?utf-8?B?cDl5aU1RcEIwWm1HUVZnaFl2bWVKUW9xY0NaSnhLakVRSnhWVHQvb2tSQUs1?=
 =?utf-8?B?d3ZCd2J4SjFxZ1hJRFo5dVg0N2RIbEpYc1NBK0tXTmZLdEk5VmVoYmhSQU1m?=
 =?utf-8?B?NUl2aU9ZRWhldzNwV1B0aUVVVGtqZ1YwMi9LNkJTRGJON3FuelltZmxoVkhF?=
 =?utf-8?B?VWx2T21YS3NFSWpoamtjSnNJVkJWbDJwdFlPeVNBMCtxdWN6QzY5VEZKOFNy?=
 =?utf-8?B?MnllV0ZWbzRIU1V3VWRvZFlCeDF2Sllwczg4RFNLNzlsdlBDU3FMKzFQM2RG?=
 =?utf-8?B?TEJiVWcwMjc1ZEJLUHNUL2oxNTFGWTYyS1hPNmZZR0YrT3pYVGVUdHNtSVkz?=
 =?utf-8?B?YkhpeS9lZmcxYVhMN2pPeE5lS1VvMG9tcFFaMHBtTFFtcWZIOHJ6UVN3c3ds?=
 =?utf-8?B?V0JwTzQ4cEU2WnlXUEFpTloyR29pSXRnem9HZUJXZTNNc1ovVTNOUkhLUEV4?=
 =?utf-8?B?QVBMeDVRTUlla1h1UWF3Tk80Q1FsZVhFUUhoSGhYTEt6K0toWmFEeFNCemFM?=
 =?utf-8?B?WGNFaGd3bkQyWHRMY3JKOUNLb1RWNzd2MmRNYVFQZEZZQ2NIN0k1ZDJWSVk2?=
 =?utf-8?B?M2IrY0UvZnlvb04xYXMxMURVQjJzRlM0V0g2NGg1QnBxaWIzbGdWa1dBTEVq?=
 =?utf-8?B?ODFadmNnTGMrTVVrVVM2b2tCZDdoWDM2TFlPanJGUkdZdmtRc3BmYnF0TFRC?=
 =?utf-8?B?K05zSFdXcG5IVXVyU3VPWkVjMkcyUm55RjRyOEgxaUdJWjlqdDRsN05lZ002?=
 =?utf-8?B?YU1BT1RxRXpsR2ZMelN4SjVncUcyTC9CMWVITFAyL1YycjhRRThPcFhCa0lF?=
 =?utf-8?B?a3VQMEkvYVIrVlg2L2svWVdVVmNqQXc3V1ZLL0dXRzNZdEtNbVprM3lDL1Zi?=
 =?utf-8?B?VjB3MWw0dHdrR0JGNkRzS1FzdEY2eGt4SUdaS0tUWVVRMHh3SGZBY1NJOEFn?=
 =?utf-8?B?OU9YdWdnenFMN2hSS0VDeEsxd3NzSGtYWTgxRmhLUVBBMms3bGVrQy9YZkNZ?=
 =?utf-8?B?K1pMdENJYVllN2JvUVltR3NSQ1lqWjZXajQzWG5iR2ZjbXBjOFpGV29JVjdm?=
 =?utf-8?B?UExxNmxFSCt4dmh2MEZrMFJvVTVjS3BwOW9GTllvdEV1UHhVTUNrY3ljN2dO?=
 =?utf-8?B?KzNMenRpaUhhdnFrbldjclZ5SmZISWUzNkVFK2tLZGlBY0FPVTc1RnZhWEh2?=
 =?utf-8?B?VjdoVDFvYkZrcmVPaXdPLy8yd21DeGc5NllzVndqM0k3Q1dreGpCVjl5UnQ0?=
 =?utf-8?B?QTd5NkRiODhNZmVTVFNLbU1vbjQvZnZtOGJKYlg4UkphR1F4bkJXOTcrQmMr?=
 =?utf-8?B?dit4emtzSjE5LzNhcTlJdlN5OUxjNnE0SGdqVmtPUUpOQkh1YlA0KzRLcHBm?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d736c04-7e8e-4ca6-9825-08db935a1891
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:12:17.3945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12EK/j1JyPkDgaqk/o/C18nnjsjSd/vfNJjVxa5HhMPO+1NVyJawjX8wK2IHktX6Bnvn0w0gW2kNmyrBKrYeMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8378
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 7:35 PM, Ryan Roberts wrote:
> On 02/08/2023 12:14, Ryan Roberts wrote:
>> On 28/07/2023 08:09, Yin Fengwei wrote:
>>> It will be used to check whether the folio is mapped to specific
>>> VMA and whether the mapping address of folio is in the range.
>>>
>>> Also a helper function folio_within_vma() to check whether folio
>>> is in the range of vma based on folio_in_range().
>>>
>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>> ---
>>>  mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 69 insertions(+)
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 5a03bc4782a2..63de32154a48 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>>  				   bool write, int *locked);
>>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>>  			       unsigned long bytes);
>>> +
>>> +/*
>>> + * Check whether the folio is in specific range
>>> + *
>>> + * First, check whether the folio is in the range of vma.
>>> + * Then, check whether the folio is mapped to the range of [start, end].
>>> + * In the end, check whether the folio is fully mapped to the range.
>>> + *
>>> + * @pte page table pointer will be checked whether the large folio
>>> + *      is fully mapped to. Currently, if mremap in the middle of
>>> + *      large folio, the large folio could be mapped to to different
>>> + *      VMA and address check can't identify this situation.
>>> + */
>>> +static inline bool
>>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>>> +		unsigned long start, unsigned long end, pte_t *pte)
>>
>> This api seems a bit redundant to me. Wouldn't it be better to remove the vma
>> parameter and instead fix up the start/end addresses in folio_within_vma()?
> 
> I have created a function as part of my "pte batch-zap" patch set [1], which
> counts the number of contiguously mapped pages of a folio
> (folio_nr_pages_cont_mapped()). I wonder if actually this should be the
> primitive, which can be shared for more cases. Then your folio_within_vma()
> function could just compare the nr_pages to folio_nr_pages() to decide if the
> folio is fully and contiguously mapped in the VMA.
That means we need to unify the parameters. But I don't care about the page and
you don't care about the VMA. :). Maybe we can share the PTE check part?

> 
> I also wonder if you should change the name of folio_within_vma() to something
> like folio_test_cont_in_vma() to disambiguate from the case where the folio may
> be fully mapped with a discontiguity (although perhaps that's not possible
> because a mremap would result in distinct vmas... would a new mmap in the hole
> cause a merge of all 3?).
I don't think it's possible as mremap reuse original pgoff of VMA to new VMA. I suppose
it will prevent VMA merging. But I didn't check detail.

I hate to add the PTE check as it makes folio_within_vma() much heavy and can only
be called with page table holding. But MREMAP_DONTUNMAP could create the VMA which
just has part of folio mapped. And the first version folio_within_vma() can't identify
it.


Regards
Yin, Fengwei

> 
> [1] https://lore.kernel.org/linux-mm/20230727141837.3386072-4-ryan.roberts@arm.com/
> 
>>
>>> +{
>>> +	pte_t ptent;
>>> +	unsigned long i, nr = folio_nr_pages(folio);
>>> +	pgoff_t pgoff, addr;
>>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>>> +
>>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>>> +
>>> +	if (start < vma->vm_start)
>>> +		start = vma->vm_start;
>>> +	if (end > vma->vm_end)
>>> +		end = vma->vm_end;
>>> +
>>> +	pgoff = folio_pgoff(folio);
>>> +	/* if folio start address is not in vma range */
>>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>>> +		return false;
>>> +
>>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>> +	if (addr < start || end - addr < folio_size(folio))
>>> +		return false;
>>> +
>>> +	/* not necessary to check pte for none large folio */
>>> +	if (!folio_test_large(folio))
>>> +		return true;
>>> +
>>> +	if (!pte)
>>> +		return false;
>>> +
>>> +	/* check whether parameter pte is associated with folio */
>>> +	ptent = ptep_get(pte);
>>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>> +		return false;
>>> +
>>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
>>> +	for (i = 0; i < nr; i++, pte++) {
>>> +		ptent = ptep_get(pte);
>>> +
>>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>> +			return false;
>>> +	}
>>
>> I don't think I see anything to ensure you don't wander off the end (or start)
>> of the pgtable? If the folio is mremapped so that it straddles multiple tables
>> (or is bigger than a single table?) then I think pte can become invalid? Perhaps
>> you intended start/end to always be within the same pgtable, but that is not
>> guarranteed in the case that folio_within_vma() is making the call.
>>
>> Also I want to check that this function is definitely always called under the
>> PTL for the table that pte belongs to?
>>
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +static inline bool
>>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>>> +{
>>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>>> +}
>>> +
>>>  /*
>>>   * mlock_vma_folio() and munlock_vma_folio():
>>>   * should be called with vma's mmap_lock held for read or write,
>>
> 
