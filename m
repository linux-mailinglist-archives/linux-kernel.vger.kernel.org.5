Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F070279A490
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjIKHcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjIKHck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:32:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A2ACCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694417549; x=1725953549;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IXYkAW4mIni4ezg5KAcImj5oU6r8pKkJ6FIcHEF51es=;
  b=S5AnRk9ONo09CXpSJKRTKmrTFI8Ae1NZwfUUja41d32aPtPVBLFzPBfg
   qm43aplpZSJKnZPsI29sAdJO8WJ1naK8wOHLNwZpPxs7c0+vXDU99vwZi
   Zbb/FtgndFv4W9eHwUM5N3zAXZDYHP+6XSEgfyEyY+hKAJnI9BjpZfiPs
   CMnjKrsP1B5hMES/9fLNQteKqmNqpUZ0fnuw9QhGiCY7CM1cPmsgryUXL
   BTPihc5NH3eOMjmU+ryXkpNm8NcFkAlmu/zfIEjaOMNV70ZGfu12/JZuH
   KX1EfazZB7mRBTQs6c8fzO7HNYIOs7UJkTiiQ4v7Tp9nBvNGnAgs/9OaC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="376931069"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="376931069"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 00:32:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="833399956"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="833399956"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 00:32:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 00:32:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 00:32:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 00:32:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfPlZn/6h9OXJF/L/eGXhiiScwB9vChaEw50ORe8QOcXBki/4FleWpZjrqfB71bvNS7dzEWj9LBgVz8FZvyWVnT1wtkwML/UwVsMsREFIcdtvsRTSlJBUpvoJL+kMEN+pbPhET3X+AejoFwkyrK84NjTxt0PNCBMorcaAKT9hp6VD6U30MA/qXd9gnkn4SLe29lDQPapn9Qi6glrIU6iKnIFybiLenPD5A6djfjEWbpcAyf41DPRPM1J17eVDBsDAwajYlF+caiqj5H7qaA1BOJnyE1QUEJaOGtMJz/GvgcfBulDFH4WmPXX5Tag78JDwYOVaU7hVjauwpQ3i52vJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPPJbE6c/1mV31Rn7Ss9YQdxUG5LJtxISXRvqLaNThs=;
 b=YjRATTOfFiauXaLZjmZv8TM6eI7Uc4SrHvIJiH3fi6FSoh7HqA+tw0Z5SAVDL0e9IfIVcGgkSwmqn8bZscfQL2fWDdRP1xTrPuCcnPe7Cl5ArReKIo5rF1fvOXgbqMVr4cpuLUb+MT+vngVe3xxReu/dM9EG/o0uiJ20zqSiPKdYHW4nslqXlpWU71uSKSbPuPfwZP5sNDTqowVbuF63H/oO2Q9/lJdSTIEIT+cWpjrW033HM73XRAXEhj74pSWYAoORHSUUnxVn7sgRPndgmTmo5oZSnyK6iWQZuLhq2LqNVukFqJsujUsDvE2aBDEBPEuZnB29LlgXUe3Jqz59Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH0PR11MB5315.namprd11.prod.outlook.com (2603:10b6:610:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 07:32:21 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:32:21 +0000
Message-ID: <5f8423f1-26d1-2116-ce63-bfb4d5bc2634@intel.com>
Date:   Mon, 11 Sep 2023 15:32:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Content-Language: en-US
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <syzkaller-bugs@googlegroups.com>
References: <000000000000d099fa0604f03351@google.com>
 <ZP0xyFnnghM42GcW@casper.infradead.org>
 <ba941c8f-381b-3db0-7ec6-ba1094759056@intel.com>
In-Reply-To: <ba941c8f-381b-3db0-7ec6-ba1094759056@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH0PR11MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0f1648-cfa2-429a-5621-08dbb2993c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqEnmr829/m1/OLUCsiLT1J3Xb2HY6k0oilt7g9u9gjOLYTQ9pJJFZn9DVplOPuZRAdaPLvb9UCHL6/GLtJeIpz/mSBx6CJicZR1SHfpaCzXs67cNbcQLNew8nZZV8fpQUNpZ0jHIRyDLcnzCqTAmb5oJpc1W4QLDIV15dPfoPcY4bXJsBv4I0LjSMTmt1HQGl4IcxYIaUp27q3Z2Ap9cbnp6vkTk3xo5BJUutRDMRr9238npopzyeKrgzguhobEKSr93Flpkj70SOesNv0fa000K7IEFjsVJco9u7Zq6tIAcDmGCKNLA+LyFK+tI+ZFeWwBo1D3H5ZGmLKUfIm7Xw5HYxnDRmlYycrJBoaNJueCeDwd1kk7XBH8SCdDwWXshlenYW3WggNfU4/XNfvzUwW7zQ1DHD9OmHGhY+uCpwLMmdNxrKIyxnkcacrRjDpK/WbuUqgk6lxuhfT+nKI4mGQLp3GNwmIsE9BX6z5LM48n0U0CobaglV+TPwq+gyNN5DwaSVLAq2/8t7VCj2gfldt+p2SGTtObyxF64cWnMojtahDJHdbB0LsPv3QRFc3T9c1Esx1aRO7A8cecbe5JF0tKkXzHMVv8gRFeaatD5jmMfMQqlmV2qemjyBimzphOK8ykP5VewCidAVzI1Qcx5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(1800799009)(186009)(451199024)(6506007)(6486002)(53546011)(6512007)(478600001)(83380400001)(26005)(2616005)(2906002)(66476007)(66556008)(66946007)(110136005)(316002)(5660300002)(41300700001)(4326008)(8676002)(8936002)(31696002)(82960400001)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djZvOUQ1SytDUDJtZW5oN0Uza3lKdHY2QWxYSXg2clNPMCtoK0ppVkFsdGhl?=
 =?utf-8?B?OS9tTytYTWcxdWsyRmxnSGlVdGNiYkEweTBOa0t2TmRnTFRrQWtCbVk4SFdv?=
 =?utf-8?B?ZThvZERjSnAwUXVqTVkyL3h2RlFDNFNKZEtyYzk4dEZJZFc4a0U5MllEYWtC?=
 =?utf-8?B?djJXY0tqM1NJTlZJbWlDK3pXdERaY0REN0pYQy9ocEtTaVVJQSt3bU8rSThM?=
 =?utf-8?B?SXhidXBNaXpDNmd5UkxOVHRid2VjMzZsZ2NJUXBHdVJZaWczb3Q5NE5yT1M4?=
 =?utf-8?B?S0twNnBURmVhU0F4MWpBTzE2RjFMVEdiNlRoOGpodkVaWkxCNWJwa21mMWlX?=
 =?utf-8?B?MWFBL053WThMLzNpNStpeS82RkdhODZnWWlwTXcwdWxmS1BWcm53MVNsY3Q3?=
 =?utf-8?B?aGFhdloxR3B4VTViTlFVVk44QkF1dzBDd256UHkxY3pUbmNROHJhTU44QU9p?=
 =?utf-8?B?MFV1anU3VjlSbHBJM0Z5d0FEL3ExR3Y0dTY0QmoweFpVMnZVNCsrVWl0K21E?=
 =?utf-8?B?eWxFMnIzaVREQ0Qvbk52bkwvV1NyZzU0OXBLaVNFakl5WmlQRjM2SEtCK1pa?=
 =?utf-8?B?MEI4aE05L2wydXJBVThkYWZxRzl3NUszZDNJVE9peTM4dHA0NXJ1aGlBYXNO?=
 =?utf-8?B?Rk9IMUQ3WllwVXpGcVNYQThjZjh4L01vTlRTS3ZOUmhLbTBzM0w0Y1o2ZkE0?=
 =?utf-8?B?b3dVU3RrYzlvYXR6ZVdaVXVhemhvby9obVUrQkJPSmlrVkdtL04zTkp3aDI4?=
 =?utf-8?B?SmFpYlVJekZ3c1VLZlVPek1uc3F0aHBkTlpDNUt0U1dwWUpaS2pKZi9mNW5Y?=
 =?utf-8?B?SzZ3RzdxSnl1bWc2aTNtckVabll6YVI5NC96U0lxdTREbjZ6RUJNdklSSXJZ?=
 =?utf-8?B?M1M5bUpjNU52UjU3WlJaYmU4dGZnZDloRnI0ZEZoUncyTjZzYjBqdDc2TEwx?=
 =?utf-8?B?Uy9ZTGROcmx2d2hlL0RqR3JlU1VnQ2h6V1J5TVNKMkc1TXVkRFFFcVFpcFdw?=
 =?utf-8?B?akovTXRMRitpYVlnTDF2Q0dya2FISHlyT2xRWkxmNmp2N2pZZk0rdGN1MTdR?=
 =?utf-8?B?bUZkbXdtVU1nMVVjamRnQWVNRGxLVkF1REZ4QjRZQmZwL241VEhNWnpmM29D?=
 =?utf-8?B?Q3YwVUFUcXVVa3NBanhyd0pKWUo0S29DSlU3SmdLZWd6Qlp1bkhwUEhFODV6?=
 =?utf-8?B?VXlwdWNvRVFhS2wxazVUMURtdkc5NUR1c3NZWVFUbm9BUi9YUXY2cjdZN25n?=
 =?utf-8?B?dytNdHNxbXBLY0pVOE1uTzA5Q25mQ1VQVXdJZXRtR3RqcWpxazRObGZiQmgz?=
 =?utf-8?B?ajF0Wm5Qb0ZqVXdKQVg2dUtEbkIxcFFMZEU1QXUyNTljZlorVURkZUtyaEVa?=
 =?utf-8?B?ekJxa0xNcnltWnpPckI4ZGxIdjFZeXZVVThRLzJ2aEVzR1BkRldEOXlUdkNN?=
 =?utf-8?B?b2VJVzdQL0Q4QjFTdkh5OFd1dDRlZWFLL2RTalpQYnpuLzFpYXNlTXBnekdT?=
 =?utf-8?B?MzBqeTRibmI3NHA4QTh4ejRSQWZtcG5TVTltZnRwYmpPRUVpbnZ4MGNDZ1RF?=
 =?utf-8?B?RVp5WmpIakRqRXJVMSt4QzhqRVN5S2N3WmJ4L1pvNmlUdHpQd3R6UytHeWlJ?=
 =?utf-8?B?N29TTnl0ZkxiNVBNNHJpV1JVcUlGaUNKMUsyaVV2aFB4TGFWakZRa1B1UTJt?=
 =?utf-8?B?ZUp1UmQwOEVOSS9nRElTZllickJMcEE2eEl3Lzc5OERldloyWmpQQWRreHhR?=
 =?utf-8?B?aVlCb0xBUk01RXU5SGVzaW1MMEkvRUhqZU1qVllIM0RnVUhPcCsrdnN3N2Va?=
 =?utf-8?B?aVNaRjkvT3piQ1pJTjVDVVR0dTFRYk5ab3dzdHhZUWFSSzlGcENsQ2ZES1hB?=
 =?utf-8?B?SVpzYzhCUTZ1WFlDMU5QNzR6QUJXbGcwZC96eE5BT20ya1pSdlk3L0o1djYv?=
 =?utf-8?B?UUM1cHc5RXhCUFo4bWpKTW5DTXM3NmZabFVyV3V4UU8xY2REZWsrWllnZ3Fj?=
 =?utf-8?B?dDBBcllFb1dqTjBIMHYwSUlyM2pLMlpCbTZEenVsWGJWbjZjZy9paTZWUlVR?=
 =?utf-8?B?ZmxaeHY0ZS9zRGFPOU5uUVEyK0RXbE11cS9vbXJrR3JoMWsrY2VjRndZMnVH?=
 =?utf-8?Q?Frj0c1VC30XmMFOZK7jDMWFQh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0f1648-cfa2-429a-5621-08dbb2993c44
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 07:32:21.6359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/bBNlfpgJD+TciXwdsGMgWjSPCLVzd2l/TFA2aWw0E5KGbe5nAVc98asm90r9yiDXDK+3DHxOC0Rxrsf5OwFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5315
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/23 15:24, Yin Fengwei wrote:
> Hi Matthew,
> 
> On 9/10/23 11:02, Matthew Wilcox wrote:
>> On Sat, Sep 09, 2023 at 10:12:48AM -0700, syzbot wrote:
>>> commit 617c28ecab22d98a3809370eb6cb50fa24b7bfe1
>>> Author: Yin Fengwei <fengwei.yin@intel.com>
>>> Date:   Wed Aug 2 15:14:05 2023 +0000
>>>
>>>     filemap: batch PTE mappings
>>
>> Hmm ... I don't know if this is the bug, but ...
> I do think we should merge your patch here. LKP already noticed some performance
> regressions. I suppose this patch can fix some of them.
I will verify this patch to see whether the regressions noticed by LKP can be
fixed. Will keep you updated for any progress. Thanks.


Regards
Yin, Fengwei

> 
> 
> I root caused the this "bad page map" issue in my local env. It's related with pte
> with protnone on x86_64. So if pte is not protnone, advancing pte by adding
> 1UL << PFN_PTE_SHIFT is correct. But if pte is protnone, should subtract
> 1UL << PFN_PTE_SHIFT. I saw pfn_pte() had pfn ^= protnone_mask() and just realized
> it.
> 
> 
> The producer mmap with PROT_NONE and then trigger SIGXFSZ and create core file.
> That will cause GUP with FOLL_FORCE and create protnone pte.
> 
> I submitted request to sysbot to test the fixing worked on my local env. Thanks.
> 
> 
> Regards
> Yin, Fengwei
> 
>>
>> #syz test
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 582f5317ff71..580d0b2b1a7c 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3506,7 +3506,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>>  		if (count) {
>>  			set_pte_range(vmf, folio, page, count, addr);
>>  			folio_ref_add(folio, count);
>> -			if (in_range(vmf->address, addr, count))
>> +			if (in_range(vmf->address, addr, count * PAGE_SIZE))
>>  				ret = VM_FAULT_NOPAGE;
>>  		}
>>  
>> @@ -3520,7 +3520,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>>  	if (count) {
>>  		set_pte_range(vmf, folio, page, count, addr);
>>  		folio_ref_add(folio, count);
>> -		if (in_range(vmf->address, addr, count))
>> +		if (in_range(vmf->address, addr, count * PAGE_SIZE))
>>  			ret = VM_FAULT_NOPAGE;
>>  	}
>>  
>>
