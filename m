Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE667E829F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346478AbjKJT32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbjKJT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A374FAF83
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699607079; x=1731143079;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BmkXrVBhtqS6a5fh9xFjSV2+N/Kjk5n34a+QwEE9pvA=;
  b=CAY5UOqbWXiJTKV4Tb2MTMVnfPt7I8G7sCI63EfIuMmyULt0Aul53K4Y
   +8J+plJ2q1WmL6LPHRgzju7Wef73NrI3/b89rP5CBuRPhsfmE4DbGBquT
   4d2L9mNEZnU940s55sTlsvJCB+GH5HZYYYtNKacc93O3qWexk2vyL1C0K
   nhEVPbzNxVWa6VZpIj9ItU4V4SeWVH3O5J+8u4tJl8WXj5fEyEX0B6Zje
   n54QXk6BsqJtZHKZ+PA41yFQBs/42IhU8IO/UcTI5OZal3gXDc0cc4KO2
   95TqwoR6Hb+Dc328iuD51p2LmcGk6sVCsuOORJEpVUFzBuZDT+OawF51K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375198643"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="375198643"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 01:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="757155938"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="757155938"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 01:04:38 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 01:04:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 01:04:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 01:04:38 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 01:04:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AExOEF6n7+QnAhkMiB6ZRmsktOu4Lbcdz47O451pcEEO1/OnvxiK5awPbXS56OJ0UHrb0SLoQapgiUgcWwJxJoleU5487K6NCmzU0w88ubvHEiQlF2dhe1k2m5Nr6dPo+I9dNrtysBc2g6iLdmZeYd4UNZbc2+rtnw6lGWgHaNObmwuDDlVXeFWV4R8RWaX2LtBymYGZqduOkely8A3QlCLh/q3zVbWIG1licw/tQC2gfzXLYfdMzx2yV1iElRNjETzirVvBxkBPNdFsz6feg1+LFqFjTCdaQ6fZCpJ7fUQWw+fs+P4sPbWObR08Sfbbrqy0DZU415q0fYrBBzq2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCVqrHlgnLxznzemVtd+QTQ4KEjwGGfh9j2cnNDKsrI=;
 b=lHWw7dTYoLLPovNnr3vRCjDuy0ZsN1Ie5/iMGHYU3GBb1Zi4mWg5MbU1pWNPIgF+jlhRi1GYhUl6oBOcsXOP2v52LoP5lAXSjwAdUl8OiAwHztGPbyUW91RqgQ4kqYODUjHDIo/RrNrA2z6jjzbUbkHJ1usIfJcN28zUKOn003zmke4XZJFz9LPHa0eZtOUxw54nykXx9h7rHN2B4yFWfo1m/D5uRGus2JO2grGghpbz806Oh/oqkXyX85uzrhOw82Vodp21Z+KXe4KFGnVKr/FZTXlSfx6ro9SiO2mjnbSPosmf5belBa5nXvys7DUPqveNh2JCfuhThhk4mlLrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Fri, 10 Nov
 2023 09:04:35 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::53f6:8fa2:1b02:6012]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::53f6:8fa2:1b02:6012%3]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 09:04:35 +0000
Message-ID: <2c95d0d0-a708-436f-a9d9-4b3d90eafb16@intel.com>
Date:   Fri, 10 Nov 2023 17:04:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "zhangpeng (AS)" <zhangpeng362@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <lstoakes@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <vbabka@suse.cz>, <peterz@infradead.org>, <mgorman@suse.de>,
        <mingo@redhat.com>, <riel@redhat.com>, <hannes@cmpxchg.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
 <ZU0WkMR1s7QNG9RZ@casper.infradead.org>
 <874jhugom8.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <874jhugom8.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb560cf-28f1-444a-12f6-08dbe1cc0f7b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cg09O+GqdpVAriNjVgAiVfluUg7+tem1emGAKLCA1bzmjpmFYYIxO3O4RdoPeaW/835ra8oPIWxVn4junsk6ZIXCH0+KtTiK7swkXKMCUjcuYy92HEXK4jYkaQlHQ3MDBWGnQpEUEaxFq5kgM71r+pLJ/sA8lnKd9dszYOt5X329HMc1IpLfqEebgxpNT2RDx/pYRO3kQC32OY6yWGHhqCFXK76kBAgg2TzThv0yTXbaT25r1rgicS7BYekIUJddj/eSk2lfiUhoAwjzkFvZ+BLoNKsMWyOn/jiNvOxqNCp8VrgOAiF/zzWNLegkZ4wHNR1E2BM2R2Sc8iyl/kcEuWIOBL2BoICV3HeBnm5OQLyrBo9Huyc+a3lSaBMZQiPzv8b/fkN3vsaPb/KfmX1EbNCRK7NrpnKG+kvgyW1jYkp22sk69Dq7tXfXL0iAk6bG6aq+NWBAgB9KywcSKDVRXGy1g9z9ZAT3wAvcdR69u+rEyxy8EVge8XjctqDybucu8ZgwqxBp8+qRcEmGXQ68EG4NkFDxuL0uYON4nsHkP4rZRyhdnssZ1ILUx8RC2AcnhWmbVqh/PwrD4KpDJw2VV1D/PRbrQbfvV6UuwxnfjVoOEa4sE7wENaqLwg9xKAvh+j8sra0gqt28OnMtO0F0YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(86362001)(31696002)(53546011)(6486002)(5660300002)(31686004)(316002)(8936002)(8676002)(4326008)(2906002)(41300700001)(38100700002)(54906003)(66476007)(110136005)(66556008)(83380400001)(26005)(36756003)(2616005)(82960400001)(66946007)(6512007)(6666004)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a01XSkJ5d2h3T0xzSFFic2RFdS9OZWtxOCtFRGdYQXI4RDJQZ0pGQ0xQMGh1?=
 =?utf-8?B?VkhVUzQ3K3pGemJVQ093T0I1VWg1R3Ixam1IQkhZTFNNTVFhQ2xhMCtTY2xU?=
 =?utf-8?B?UWpGbTM1aEVoUFRvNUh2dEZqczl2MENqVTVySU4vUTI0OEh4WlRabTMvaTNT?=
 =?utf-8?B?SnRQZHM1azVpVGZWWWF0U3g5WldCZHEra1B2TkpLZkt3amFzYXFkTHNXdDZy?=
 =?utf-8?B?UisrYTBwd2VVTDgzSmlYMkI2ZWtUZmhodnh5UG9GdmRlMXVaNU95NWFtZDRE?=
 =?utf-8?B?WTNlRVlmNjZ6bmh3RFRSc1VRV29QUkJqc3ZjVnhGQ0RvNTRKakxqbDJlRGNB?=
 =?utf-8?B?R2xyaDdXNkR3b2FROG0wT3dvcVArOFNqOEV0UXphZkxWNEt1bFBDa0JtSHYv?=
 =?utf-8?B?ZW5PS3kwc2VTUVdwQys2UkhqQjhmcnJ1VlVpM0tueis0S0c1SGFEanpyS1p3?=
 =?utf-8?B?ZEw3elBhNjkzeDhiaHQrbEFqV3NFZ0hTd0FObzBnZ0JXY2xuc3BLRUdlbUpK?=
 =?utf-8?B?L2h3alJucDczNHVkaWtZVnZ4S2VsRjBidktiZy9BbUpXTFovVXpRcHpBQVhO?=
 =?utf-8?B?THBTUVh5QnRyWWJvQ1FEeE1pMHFTR3ZiMEJkUFcxQnlNOXcxbGhvdTJrL01i?=
 =?utf-8?B?WnNzdzM0RnRka1F0VnVSN1AvV3JiS25sUkx5c0s3QVpscmgrMzlTTWFkSFVu?=
 =?utf-8?B?Zm5OTnlUak9NbEkvdDZxczFVVEN4S0tlbXB0dUE2czhGNmFiQUJIWDMzTHJs?=
 =?utf-8?B?TG1GOU85c0lFbTFmTHNhY29aV0JWK3RBZ1E1T2V2dkd0b2VDL3pkdmRsNVNy?=
 =?utf-8?B?YWF1NVcrOGJPWFdQYS81NHNGRGVSMzEzZDhtcm9zcVArUWg3N2ZTNzU1ZVYw?=
 =?utf-8?B?MUZ6T3R5WThkMDNmWDZWclBWSllQb3QyeEFMeW91Y0E3TDd4UDZQSzRpamZJ?=
 =?utf-8?B?SlpueVBwaUFzNjJpcVNBbE92ak02a2hsUnJYekNpQlhUWkp4TkdRRnl3SkJ2?=
 =?utf-8?B?Q3dCNGdIejc1M3JCUGN3SXFEdG5nOXdWQ3VNeHJHTUNjVEhpanF1em9YQjBB?=
 =?utf-8?B?STdUL05YdVd4d1VVMjZjRkxndjNTMmErdmh3UGVKaTBDdjRIMVZYa1BQK2ZR?=
 =?utf-8?B?VzRTYW5Nazhqb3pQRmFCZWhmUnVqbUtkU094dmRjc21NNFhEdVA2NUo3NFVW?=
 =?utf-8?B?YlU1K2ZkeWJ5dm1OQ1VmeEd6V0tlb3dmWmkvT2tKRncvNDNjcWJsT0ZBTXlv?=
 =?utf-8?B?TkNhSHpQT0NWYnRSWUc5bTZxdW1ORlZmVmhsRWcvTVFlVUEvamZZQ3d3V1lF?=
 =?utf-8?B?dU1STlBOUWpMUjZJZXl0Y3VMZ1JkOUNZczhIbWNEczBlWVg5UzI3SElnYjdt?=
 =?utf-8?B?TmNrZVhwYkVnWmpGMnlGdS84dTQxOHdYbEI3YWg0TUJNZ3Bic2V0d1VNSlhm?=
 =?utf-8?B?VGJmaTNVaEEzc2JDaWJxRTRBLzM3WG1LaFlEZHBpaTZiUW9KZ2UxK3NyTDBJ?=
 =?utf-8?B?aXpFQUt6RGE4RysreVYvbG0vTzBQSlI5ejMzWTdNS2l3OHZUUkY2d1AzOEhM?=
 =?utf-8?B?Mi9KTGxMY3krK3ppdEJPdmd5M2VBc3Y1WjYrTUFvcStKUEtvWEY0cHVSRmlw?=
 =?utf-8?B?QWxrd0xnR0x6WEpkdWhJSG1DMWFONUpUQWJZMEc4d1ZQa3NmOTVqcmZveFJi?=
 =?utf-8?B?aU9BVUw2MTQ2YTZ5eHN5clp4dWF1MGxQMWZXUlo1azhZd1pmZmdGcUUrTXda?=
 =?utf-8?B?UmJLZzlPRjE4Y052SWxuM21LL1pzVnY3TTkxZVl1SkFYTk1aNXVlak1OMWhO?=
 =?utf-8?B?U1NsVklScjJJQnJwSVI0MEduV2pnSUlHYkZ1MG9BWnlnWXdZZUhaSEIwcWpx?=
 =?utf-8?B?b1NFajhhZXhOeEV0S2FHRlp3cTVLNUlONU9UOWJJZkZyVk5XUXdRczd2aitB?=
 =?utf-8?B?OGw1TUpRd1ZQakVpSEVoYzFxMS9TM2xwL3lLU3YwdkVidWo4TmRJakRQV0pG?=
 =?utf-8?B?Z25tT2JIMHAwWXhkcnRsbU5OTk5Kamd4eWNuTTJPSi9tN0hqVHBHaFpBalF0?=
 =?utf-8?B?RWhpZW1kN0cyeCtiK01HRWpRY3NXVVhKajBYSDJUc1JyZWZrekwrTXJlSnFy?=
 =?utf-8?Q?gKhoPuPG9bTDY2DKcoeKP0+Z/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb560cf-28f1-444a-12f6-08dbe1cc0f7b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:04:35.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIbiFcDUuHBeelDl2RX1OANb9739i1f/DI2gauDRq5oEUH8BmyEVQ42S/klHS1Sv6FdnWVDLOdADzO6tYfKdsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
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



On 11/10/2023 1:32 PM, Huang, Ying wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
>> On Thu, Nov 09, 2023 at 09:47:24PM +0800, zhangpeng (AS) wrote:
>>> There is a stage in numa fault which will set pte as 0 in do_numa_page() :
>>> ptep_modify_prot_start() will clear the vmf->pte, until
>>> ptep_modify_prot_commit() assign a value to the vmf->pte.
>>
>> [...]
>>
>>> Our problem scenario is as follows:
>>>
>>> task 1                      task 2
>>> ------                      ------
>>> /* scan global variables */
>>> do_numa_page()
>>>   spin_lock(vmf->ptl)
>>>   ptep_modify_prot_start()
>>>   /* set vmf->pte as null */
>>>                             /* Access global variables */
>>>                             handle_pte_fault()
>>>                               /* no pte lock */
>>>                               do_pte_missing()
>>>                                 do_fault()
>>>                                   do_read_fault()
>>>   ptep_modify_prot_commit()
>>>   /* ptep update done */
>>>   pte_unmap_unlock(vmf->pte, vmf->ptl)
>>>                                     do_fault_around()
>>>                                     __do_fault()
>>>                                       filemap_fault()
>>>                                         /* page cache is not available
>>>                                         and a major fault is triggered */
>>>                                         do_sync_mmap_readahead()
>>>                                         /* page_not_uptodate and goto
>>>                                         out_retry. */
>>>
>>> Is there any way to avoid such a major fault?
>>
>> Yes, this looks like a bug.
>>
>> It seems to me that the easiest way to fix this is not to zero the pte
>> but to make it protnone?  That would send task 2 into do_numa_page()
>> where it would take the ptl, then check pte_same(), see that it's
>> changed and goto out, which will end up retrying the fault.
> 
> There are other places in the kernel where the PTE is cleared, for
> example, move_ptes() in mremap.c.  IIUC, we need to audit all them.
> 
> Another possible solution is to check PTE again with PTL held before
> reading in file data.  This will increase the overhead of major fault
> path.  Is it acceptable?
What if we check the PTE without page table lock acquired?

Regards
Yin, Fengwei

> 
>> I'm not particularly expert at page table manipulation, so I'll let
>> somebody who is propose an actual patch.  Or you could try to do it?
> 
> --
> Best Regards,
> Huang, Ying
