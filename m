Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECC1776E69
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjHJDRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHJDRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:17:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D671BFB;
        Wed,  9 Aug 2023 20:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691637430; x=1723173430;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3kCvDczZ7gQwhvKudYvzTzTnOugBSXek8JoBZ8yIPIc=;
  b=BK/GEwXZoonzoLvJHDeIVCJAy4SXYLiQ4/HkArgvapavvT+y6N+vDT1A
   tK2uw0Wyc62LBxkP64jZe3v+tqZbLzYyDELBKPSK/tZ3VwB73bZbz0DlF
   cNhMK4ibceP1tLpdHQaZVpnPy23angu+aXXG/0nNXVLib6TzkH4vZy8ko
   Wx/8X6yew8ZxYj5Yiv27ZcPB4HjpYZBNTZCPluh8DpLgd92b72otiPOeD
   w5iB3Xls9m9ry+PxsdVfSivhATDDjoytieTQrAAoY6Hb3+rsNZ8k9ZG/v
   jbPXmUqX2VHryaYi9PolmRsUtb/mORMCdeuPGmAf8mBVsGmBDaV0clGyf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="371279826"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="371279826"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 20:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797445252"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="797445252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2023 20:17:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 20:17:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 20:17:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 20:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdpV74x8u7plvweu9ec+7AtktN6z+a7ZMU0NhEgKpcT2AOAAGxOOmdPAFjwrdGDU2B9X0Wq4GcuR0B3Re5mzyTLotQwFW1bFPtGZYFWSsEUYN2DWxSJ70u88EM3JHLPH9ZhS1oufhSDMzt5JZenwEd6/R3HPPU/KL5TwNTpVYo8UWYOXqhjtStZJqGFa1b19+UnlbsQ5HdvYm81CKe2y47EaMjZLDByTrsQOxUzi293Hciw3yJJ/IFHwxwYqTehxuo6qkkMHXCS4dwLOPNI6QMg8OjBZiCLdbuKK+mnOObDWRGI5wy+IlVkYt2vUpmzHoKgr4tVX55QPzTtv/ddmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDiDGF/+NFXqeghP7lalxvgQlAyok8L4wVCfNw2nKVM=;
 b=Uew56KKTuVWoy/R5C74fE6rHbuqCCnDX+VoPbxzZkMvItW02SARdfkrJ4cfVoZEsYzhPQ1i5NzClTOEFBO6r2mGbaBpEC6IGwUAKPK/KT1i9ZKIn1P229ry/+efBXyfCusVqCxHWs6BW+74J7fuz8+UGDo0OPTXyi6mdR9uLjUAbWQVhid1xyqulCi9Ch+7CUCc4Uvl90s5h9+2mIN7/eAbLldJxr9jNlu9Iomh3VSggAvzt/VA/teQsXDB5mNfUYxNgEeROl3/3M6tdaHtyxc2mGEkhuEiU8Y2f69LUPFgAPzB+mPBby29go4pMF4rnOBZaXfqSLL9BDXZW5mHX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Thu, 10 Aug
 2023 03:17:08 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 03:17:07 +0000
Message-ID: <adfdea09-571e-fe1e-6663-f1c78a79e830@intel.com>
Date:   Thu, 10 Aug 2023 11:14:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com>
 <181fcc79-b1c6-412f-9ca1-d1f21ef33e32@arm.com>
 <ZNPnLGNCnt5lfdy8@casper.infradead.org>
 <703bb7de-aba7-ee4b-c2fb-3562318072a5@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <703bb7de-aba7-ee4b-c2fb-3562318072a5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf26758-d362-45a9-5c47-08db99504705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6qOqF8nZS6ajV7wekdZwjI4mV5wM8RGm2yTM+e+zE2ZibqiJcuNHccIBfIoIRiVUVRFnrDtVhIpO/DjjffDRr6yyzdt+dPVArTHRqqoFC5HwQQ0cw1UVAoYF5AFqRNFgVkBCMZCcK1CkoKcEJQUK7zPoyEMhS2Gluuepm68L7oxowdAUsffnh89PigWrc9ELod/oVqnI6K0lIctsw2EIediOaMhICibcQnIY/s7or8lV/nLMTrMbn6qwoxexfImNT5b7YwuErymCyjePEcD0aKbYYS4wIq/7/+mMdXtEfxDWiniK7eYP+qe0C0OERtbNEaFzC8NrQUxdXcN1aNbXTVzj7DYbpJzdazFlnlm0gcQQG31E3GO/58TBPqMDIHtEvZ54S7j32sjP3y62XOw2oS5a3RliSmrPqeyDF/tAcoEHvWWSpO2+N3x/TvhCjHxUS32wCLz0x/XZ76McpOIfcJYDiX1i96c9Ha6LOXGiqVs3hMeyEtU2K9gS2zBkf0hOYzeowLjR2qGauU72vQuhjb1OTmWVjK2jw+l/eiFvA/EXHEIOcVtUkCpZVB96sQSx6gae+xMs0pHh4pdZHdz4w5vu14lVEnAW4QrQO4rG3dHXPq4sEQgxSo2hzzYjs2+oWl9sGmt175lGDPDTbl78Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(1800799006)(186006)(31696002)(316002)(2616005)(2906002)(41300700001)(6666004)(86362001)(31686004)(5660300002)(8936002)(7416002)(6506007)(53546011)(26005)(8676002)(110136005)(6512007)(54906003)(6486002)(82960400001)(66556008)(66476007)(66946007)(38100700002)(478600001)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJlc0p3cUUxSmkrSFNVSkZIaTFrbXlvNmszUlBQRFVJRiswZHNMZlYxdlJu?=
 =?utf-8?B?S3E5NXhUaWdmU3puQmpKWDMyZUNXZHMydlhqUENqcGJZUjNoV0hNSm9IazB5?=
 =?utf-8?B?M2hKWktMb1BmMlFpaGlGWUdsSyt2dVhTL25XWWVXaGZKblh3M0crVHkyU0s3?=
 =?utf-8?B?N1N3c2E5WW9XUDh1VE80eUxjajdvR0tnSnljZ2JaRmZ0RlVGeDdaNS9YMHRO?=
 =?utf-8?B?cmk3MW40R0ZjQVRPSGJkTEUyUGI1UUxwN1pxWjF6YmNxRTFjb1Ayd003UkZP?=
 =?utf-8?B?VTBTRWlycFZUWG9tcjVPTDI1OXlIcTZ5bkpJOXFXWm9QTk1nSUxENDdRTHYx?=
 =?utf-8?B?WUdQdWRXc3dmeTVLTWp4OG9ORVE4NGlQVUJkYXE1Ri8xU0g1UWJEWitLN3B4?=
 =?utf-8?B?a1YwdGhJREVpdWZIcmpiSXB0N3lJTjEwa21XNlhmbHNnVElHaVFKbForUWoy?=
 =?utf-8?B?SU5yM1ladkVUbGQzRlpXVFhheCtzWUVUSyswNCtwcHEvLzIyVWdVTGZYbFVH?=
 =?utf-8?B?ZGNiZ0RHM0JJWTZNb2YzOXNuYk53Ui94TUZ6R0Z3Lzg3L09uNlhDS1RPWGJE?=
 =?utf-8?B?U001NCtNT3NGNXBpdnY0YnNENGVBS0taekMxbzRHQUJZdGl5eDdBYTd1OTk1?=
 =?utf-8?B?MCtGbThhV2JhdWt4aVlkZnZsU05SWms1amtkKytCOG9hTzd1MmhGc1RSNUlY?=
 =?utf-8?B?Z1Y5RDRvbnpmYVU4aEFsR2QySVBGL3dGelFoaE43emtORjBkR3BhQXRSVXQw?=
 =?utf-8?B?V015RUVncHRsZXZNQmd5VWVBVk1DZGtFRk0yY0tEZ0cwemZ6Tms5dnBrSlEv?=
 =?utf-8?B?NlpPOXMrYnM5R1dWTUR2clpVNms4SWQ1RkYxbUlCRjRaL1RreDNPYXRkTXNi?=
 =?utf-8?B?T2k0TGl5bi83RHIwUXBzOHVBWENJK2NqQ3ExdC9yeEdPd0tXL2xreThyNWlu?=
 =?utf-8?B?TnliTndWYTltS3p6TWFDUE4zSkVkNFNYQVhGVHRRdSt5dk5xQUF3Zm9zYWZa?=
 =?utf-8?B?U1J4cGVLaERJTzQwOUV3L0NFMnM0YmI2MFBGclpRZUIvZWZWTU5wditWRitI?=
 =?utf-8?B?b3NsbHNtYnI3YjdXNnpHN3MraDQyOWJIWWNzTUlFbTJ1TWFXMThzTWFsV1NV?=
 =?utf-8?B?ODNOT3JRSEFIdEpVWWkyMXNzT3ZkSCtUbHRJQXZ2SkR5Y3BNR0tmb3BJZ2F3?=
 =?utf-8?B?NXVVMGhUTzJFdGNiSXcrdTRkT1dkVitzaFdLSkRYb0pCYjN4aFpVSklwSUtC?=
 =?utf-8?B?S2JpdkI0TThNUi9XaEFsSDEySzhxVWpnVndiTWU4ZTdramhqKzIvUk9SSGFw?=
 =?utf-8?B?bFpBYWR0a2NYK1JaTlQyb3pCSDdRVTViMTI5R2JQc2FlUVNvRHpxeWxXejJG?=
 =?utf-8?B?RzhnYkZZUkpscmJLTXJ4TG9rcWl5OTJlUXZxL3ZIZ1lJeTJzV0JCbzlFVjdn?=
 =?utf-8?B?c3prVjVpTUYxelFPYVQvdnozdXVGcnJpWmNwdXYzN1l1RkFSL2VCNmZzRkxJ?=
 =?utf-8?B?ZkZEK1cxSjFFN0RMVmZWbURndENCNmNaRkVlWEtBMU1BU3RBVGxpUmJsaHVD?=
 =?utf-8?B?ZDNwN21Pd0RqYjBWWEowT2RDRjFkWlltMG5ScEo2M1BkR0VqczVXM1ZpMnRN?=
 =?utf-8?B?YWJuVDFXbWFVbnV5ZS9YNFlqWlE1L01XeVVGTzZVVms0ejNpUTYvRm9mVHQ2?=
 =?utf-8?B?ZkpZdUdobCtIRFRiejZUMjJsUVRvUnVxZWhQQ21udHZVa0IwOHQwY0pPOXFE?=
 =?utf-8?B?V2FHekNTRS9EYVZEMGUzeENLTmh6QTRqNDJvQWMzUVNMK0ZUWENYQkg1UWk1?=
 =?utf-8?B?ZjZxbWtGQjEvSzF5SG4rbi9LdFpvVzFydEhIK2xGSklDUEpsNHI2azJ0Y3dE?=
 =?utf-8?B?dzRzTkZsSXlSY1ZTc1hiU1I3ZjdVTzA0a012NFZmUVhTR2lzbzRPREpQdXk4?=
 =?utf-8?B?eVdjc1VsUjIwTFhFaTk4N2dkMGNtbktsTUEvU1p4eWFiRExlb0RGY0Y3WG5L?=
 =?utf-8?B?V28yQUJDYjZGNjBuM3JMTWt3ZHJLNE9vbDB1QTFSbVU1RWVzZHBUblpqRkpZ?=
 =?utf-8?B?OHJrY1pQUW9Hc21SWjhQRWg2KzFUc0ZzUTZlWUZycVpzcEVEaExkdHFqTGM3?=
 =?utf-8?B?MUlzdTBMTExUSC9zQ2hqSWxMWjR2eWgzZ3hvdm1WRU84Y2dHVmRwVjNHOCtJ?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf26758-d362-45a9-5c47-08db99504705
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 03:17:07.4175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INHvsGPeAHKTJE9gGaEy97A8VNEqDjrz8II+iLtfTtXQi8mR1SOdyWWBFc3k0jQZKGlfQj5Ukp5hmH1AITmE6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/23 03:26, David Hildenbrand wrote:
> On 09.08.23 21:21, Matthew Wilcox wrote:
>> On Wed, Aug 09, 2023 at 08:07:43PM +0100, Ryan Roberts wrote:
>>>> +++ b/mm/hugetlb.c
>>>> @@ -1479,7 +1479,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>>>>       struct page *p;
>>>>         atomic_set(&folio->_entire_mapcount, 0);
>>>> -    atomic_set(&folio->_nr_pages_mapped, 0);
>>>> +    atomic_set(&folio->_total_mapcount, 0);
>>>
>>> Just checking this is definitely what you intended? _total_mapcount is -1 when
>>> it means "no pages mapped", so 0 means 1 page mapped?
>>
>> We're destroying the page here, so rather than setting the meaning of
>> this, we're setting the contents of this memory to 0.
>>
>>
>> Other thoughts that ran through my mind ... can we wrap?  I don't think
>> we can; we always increment total_mapcount by 1, no matter whether we're
>> incrementing entire_mapcount or an individual page's mapcount, and we
>> always call folio_get() first, so we can't increment total_mapcount
>> past 2^32 because folio_get() will die first.  We might be able to
>> wrap past 2^31, but I don't think so.
> 
> From my understanding, if we wrap the total mapcount, we already wrapped the refcount -- as you say, grabbing a reference ahead of time for each mapping is mandatory. Both are 31bit values. We could treat the total mapcount as an unsigned int, but that's rather future work.
> 
> Also, even folio_mapcount() and total_mapcount() return an "int" as of now.
> 
> But yes, I also thought about that. In the future we might want (at least) for bigger folios refcount+total_mapcount to be 64bit. Or we manage to decouple both and only have the total_mapcount be 64bit only.
This means pvmw may need to check more than 2^32 pte entries. :). I hope
we have other way to get bigger folio and keep mapcount not too big.


Regards
Yin, Fengwei

> 
