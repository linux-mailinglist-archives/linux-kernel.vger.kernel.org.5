Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5217E76E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbjKJB5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKJB53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:57:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3707D60
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699581447; x=1731117447;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J05Be78+Tin0qjdLpPITOdsimh9c/tHEnI+Ajiz6FT0=;
  b=T7fU0TnRI4yVGARlh2ucLgScLcYED7FTf4gjEX6HfVrV2WjJrM4GLIeH
   QOM11C8epqalCDDQNaRfFzHTLMF2nIUVkQny+WIB0IveRjdQaXGdfBTsL
   pE49aulBpEVEab0+fkA0Deit7Qlj6GShZY+qA1/SC/PARUM+brzOWMkjp
   E73aHVNlmreBNtPHtzw8B7GwI0BLKUg/6sWrWKyHpfoi54g9Wo5s9t2/v
   X5hFQqIRv7XMSuSNIOTpKDzLpW4SWTfPHgKu+HZutfdIK26t2wFLzV7PF
   Jj9qM8JatmbK3M/zvC+7iUUJTPPg9VS5F0Iqneok+DNA86LKcVh66Fotq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="389922668"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="389922668"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 17:57:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11725690"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 17:57:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 17:57:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 17:57:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 17:57:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw/JxegTnm5bVErnzgq/IFKLarkClDhNnsXC8pf7wSpTEZKcWX9qP3LpjNlxnDLAYvoeKWDnOknOzSmK5CiVlStDK3nKBcxTBcd6iT3Ie980jo6ZwzettRKVGNlPeVDyQRAXFZbs0caW8oM9Rn1jb3Y5Z1TH9DwKfl3mg5CipuAHIC4RcC19ekYVn4vBWwlkwk/yKCPsehw7D8BY5Yn5XujIZqb7jDRhdX8DQLYOABbzacxkhrTMhqyqMYNWuIMkViY1CgS9taObltx0Eo6GHMkSkwP+UPW8OUVD5e29Z+wAAShoWldnU7TvbRqlqLSNE3xhSbYjmpNPPTavLK3fGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNzp8QECXxqehaNp0p45lrTTDVen6d+EJIe0SkHlYS4=;
 b=OjWeW3hlMqoe2As5pIVtPR+GXKwvRJ/O1XGVqV/yzwHlETRh3oyXXV+wrpAyBLhxstFCmdvoRJ5QzwA+KmUpFhSe7D0F5E7GNw6XaMqBr3EyIaaZObn3ydQ2Exn6iP0sY2uO02JMLgEA0c1P/z4aQ2TJs/A686xKdWCng55mMEkM35FETUIZbvN70h4/QwXK7FNrrb7ImrsQhEcPF+y3a3tFt7ZHUmLCrsLbP6uTQ6sv8ZoEx7lny0gfFimm3T2aqJClgHVvRDVu6IRIUgpNntH3AAYMD0M5Y1zvoSXPDKA+FSIeYoaFMimTMmh7heaoqnjEnVcebZpUQN4qe6F9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH3PR11MB7179.namprd11.prod.outlook.com (2603:10b6:610:142::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 01:57:23 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::53f6:8fa2:1b02:6012]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::53f6:8fa2:1b02:6012%3]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 01:57:23 +0000
Message-ID: <648aa9dc-fc42-4f28-af9a-b24adfdcd43d@intel.com>
Date:   Fri, 10 Nov 2023 09:57:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
To:     Yang Shi <shy828301@gmail.com>,
        "zhangpeng (AS)" <zhangpeng362@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        <lstoakes@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <vbabka@suse.cz>, <peterz@infradead.org>, <mgorman@suse.de>,
        <mingo@redhat.com>, <riel@redhat.com>, <ying.huang@intel.com>,
        <hannes@cmpxchg.org>, Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
 <CAHbLzkqEytFbRoHU3=Y85tmTQ--XVQpwhVEXgDN0ss_PPv8VGA@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAHbLzkqEytFbRoHU3=Y85tmTQ--XVQpwhVEXgDN0ss_PPv8VGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH3PR11MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2909afdf-fc19-45cc-8335-08dbe19061a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPzb4FTPRqIzvk59w4Fm8nS0sy6oxnYFkgxxxSzlvbcOdOKnjVyO7WBIdaMB+HyA2Hdm8bJM1Lulsy5G1D2H1eyjUvx7/SqE42jEM6Im9/SOA2BnIeDxVh0g2XLMWcVH805OvdpA1LMHZO3hoyLkoZUUlzFtGpwLAiFPm1oyqDnbuVA+Mfxi79gIX/anurhNcijTggNmE8iNlQlpqqLzXmcqrACQ1il1clWnfeI0tLxDwbS5Lyfn9BydzI+OfBOdkWgGpPEwQ6xjD0Xujyoii7rWgRrBHELiUII64E1tsT3NLyz7SOkZDEAEiMoWlUt6rm6gWpcPxfz4S4WlSr/geC3jPBtF3YzcH+oAoiQiGovHa9HEcG1ZAKbqkmXMHl4mUnxLPbINauvUoWT38OJgmDkjZaIKxBa4aNqxB6qUewmKOTiWrqNF2t5Jrk5vdYkZ7EXwMnFw7q3zV8unCHAmdkLmS1pSr+qjP9V0KvmXC9WA6LM/Lb+7eAGJKydoWMoqxnBGGdGJSYX9Fy2PRHfD4C7Av88AY3Gn5ylt28Ww17/SPX+fvjDJwuHkF7yhic/HdtPiPqkF5gOrIqN+k0vFgxzyzG6E52vrFt1jVsLpfXP2Ymb3ZRZuYYlA/xINSTz95UiA10jfTNe6lY+E3NqLPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(82960400001)(38100700002)(5660300002)(31696002)(83380400001)(2616005)(6512007)(478600001)(6506007)(6666004)(53546011)(31686004)(6486002)(36756003)(316002)(110136005)(66946007)(8936002)(54906003)(66476007)(4326008)(8676002)(66556008)(86362001)(7416002)(2906002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGM0WFRNVEdVaFF1UDU3RSt4Q3BEdXBuQmFvbU5XUW5ZQ1hEWVVIUm54ajAw?=
 =?utf-8?B?Nm94NmRKNUhMZjJLRjZmOUdqRWpBOTBqNUVLNWdhRWd6OVdnZVA5RGkxcmNC?=
 =?utf-8?B?ejhnTWpjK0FOMFpJNWEveG02MXdMYVF3U042b1B1VjhXOTk0QjZNck9HSkVj?=
 =?utf-8?B?ZDFWK3p3VkZ1TW5CNElubTlTVTBZSElhRi9ETDJWb21YcGVHTlRzZHNSZDVn?=
 =?utf-8?B?V29pbUJhcVF6dHpET29OUmZjNXdXb0ZGNTJmeGhWc2ZLdjNjbk9URVZqZkhP?=
 =?utf-8?B?ZnBJdjczcFAyOUZNenM2OU5TeHRNdk9yKzVGdjRFOUEwVTg5RTM0aFZkWDNa?=
 =?utf-8?B?M0M2SDg3cnFaeFV2SEYzS2ljcVNFanVqQkJxYkhSd1RXRzMrL3l5VTFienVl?=
 =?utf-8?B?UmJ0NkwrZ2E1Z3JuK1lGc0VsWlZzK3RCRVZ6eXJzdkdHOFduSzRiY01FbWxz?=
 =?utf-8?B?Q1FNNUdFMU1qMFdOLzZMdGdmWHRUcGMyUXpEZUZJVWh3VldMTXR0b2dQYnly?=
 =?utf-8?B?ZE9MZm4rMVhFOC9sUmxOTE5RWC9xQ3BFQzhrWFJPd2g4cVRQeEpOZnRScnQx?=
 =?utf-8?B?YURTZ1ZxazVvQ1F5OVFHbm9TVTcrdlZmUGhmSTBGMTV0MHp1V0t6S2F5OHp1?=
 =?utf-8?B?WjE3ejN5R2lMd1JlUjE1VlFydzBmcEZxRk9pTWRNZ2s3ZjhlSWlzSVVCYzhn?=
 =?utf-8?B?dDRUVHpBd2tkY2w1cFIrd1BZcFRmZGJxaStCZlZ0cjBWeDg4SmlkcHpDN1cv?=
 =?utf-8?B?OGsvRk9EbG9Ka2p6WWRjdCtSTmx0MVVUcjgrd0ZkZyttOWYrOC8wbmYwb280?=
 =?utf-8?B?YWtzWjJ2WHM2bXByVDZmQU1oNHhuVEhib0NwWVIyYnNTbmJUblJVYnUrcTFO?=
 =?utf-8?B?RXYyK0VUVytld0czZklDbHkzTTFYNVhmU0JWemNETUJ1VVhBaURBL0wzcVlj?=
 =?utf-8?B?M3VGOFF0N0tIUVpoczgwYi9JWWE3bGwxd0FMcFlLam4rWmJIZ2hzd1BoMzVS?=
 =?utf-8?B?U2lOeUpqNzNQZ29XSTUxL3RnVW9VOFZXb2xMSDJNMDNPWktJTkRZSjJ2dDRh?=
 =?utf-8?B?VWlRQ2JocG9WaXRtMzQyOUlsWFhMa3pCa0gwZDNtVkRRWWNrWWFqVDBtVDRw?=
 =?utf-8?B?WWJ4a214Z1lNK0JINkZrdEhGb0RsQ2pDTmR1bW9yZTdnT3JibVNXbmxtQ2tP?=
 =?utf-8?B?Y1djTUFHeUJWTVdPVFlFc0JqczBrMDBDeUdsdGltRHRncUMzOHM0RENHSENi?=
 =?utf-8?B?MEt6Y0RWd2UvY2thUVlWelhHOHVFN3dkcUNsaWVQZnV0Q3J0UzZTbXVkdFJD?=
 =?utf-8?B?TXJYQ3hJN0swWk1yUUo0VFY2dFBFSm5raGkxZEJ6U2d6WnArcm9ySEJyL1Zy?=
 =?utf-8?B?cy9KYUxQa0ZTSlRDVFNmY2Y0ZGNyeHhmSXdyTUxzRDdIelNlL2JWckU4TTl6?=
 =?utf-8?B?WlFmNnNDbld4djNDNkpXZlExeGgrSEEyYXlyRWVuTGR1bVF3R3ZuWE0vTUJ2?=
 =?utf-8?B?ajRJMTVXWFV0bVVIMU9HV2xnZEZLU1BhZCs5U0YwSloyMGQwc1NPV0IvL0FG?=
 =?utf-8?B?Zk1aZnNPWDQ1elpKNlF5cDN5a2ZrNjNjNGMrTldaN0dhU2k2dEZOMncza2RB?=
 =?utf-8?B?bk5VT0dta0RLcy9LY281L3BQeXVBeFpvb2FwOFIvZUcwK043b0poNzZ5UDJO?=
 =?utf-8?B?STNUcUpsM3NoeFhzYXJrRmswa25pUzdreWlnd0FvQ2hHbEZlWkVtRXd3Y21o?=
 =?utf-8?B?MTh5VHV6RTN1UnZPd21ZSkszMnhmT2N4d0t2N1F6RFNCZUZsWkdlbVlJYjl2?=
 =?utf-8?B?M005dnpnUWg2K1BHSEJDS2VMaUlIRHJTdW9VUENiT3ROVGtXNlhLMlNMOHhJ?=
 =?utf-8?B?d1hoUU1FSGpSV3RSaDRPMVRIMFRVTmpPcUo4T1FzMUN4cjdnS1pkSDV1R3pI?=
 =?utf-8?B?eWFjN0JCYS9IR09BckhFTUpXbytSRXE5bkF3Y0tMM0RrZ0JYWUg1SGtXdXFR?=
 =?utf-8?B?bFBvbmFHck5tSUdMN09BaXNVdWg5d2JXNkV0N0pyM1E4SFY0QnJlOXN6eWJX?=
 =?utf-8?B?NFFYRWtJVEU4NDhOenFtV2ljVGtoVlR6c0NUc0tOcXdUUWtZdU5uTG52RE9Q?=
 =?utf-8?Q?kSuarkgGGvsqI3l6WdVy2+XwU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2909afdf-fc19-45cc-8335-08dbe19061a9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 01:57:23.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFMdQvcgFcOnL1o0N0PXSODz44TDaKK6DLNQ/fCtKYwrzLetK1R91PhdrPAclYdfmBpVCfi32SZm3B6n5ZK1kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7179
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2023 6:54 AM, Yang Shi wrote:
> On Thu, Nov 9, 2023 at 5:48 AM zhangpeng (AS) <zhangpeng362@huawei.com> wrote:
>>
>> Hi everyone,
>>
>> There is a performance issue that has been bothering us recently.
>> This problem can reproduce in the latest mainline version (Linux 6.6).
>>
>> We use mlockall(MCL_CURRENT | MCL_FUTURE) in the user mode process
>> to avoid performance problems caused by major fault.
>>
>> There is a stage in numa fault which will set pte as 0 in do_numa_page() :
>> ptep_modify_prot_start() will clear the vmf->pte, until
>> ptep_modify_prot_commit() assign a value to the vmf->pte.
>>
>> For the data segment of the user-mode program, the global variable area
>> is a private mapping. After the pagecache is loaded, the private
>> anonymous page is generated after the COW is triggered. Mlockall can
>> lock COW pages (anonymous pages), but the original file pages cannot
>> be locked and may be reclaimed. If the global variable (private anon page)
>> is accessed when vmf->pte is zero which is concurrently set by numa fault,
>> a file page fault will be triggered.
>>
>> At this time, the original private file page may have been reclaimed.
>> If the page cache is not available at this time, a major fault will be
>> triggered and the file will be read, causing additional overhead.
>>
>> Our problem scenario is as follows:
>>
>> task 1                      task 2
>> ------                      ------
>> /* scan global variables */
>> do_numa_page()
>>    spin_lock(vmf->ptl)
>>    ptep_modify_prot_start()
>>    /* set vmf->pte as null */
>>                              /* Access global variables */
>>                              handle_pte_fault()
>>                                /* no pte lock */
>>                                do_pte_missing()
>>                                  do_fault()
>>                                    do_read_fault()
>>    ptep_modify_prot_commit()
>>    /* ptep update done */
>>    pte_unmap_unlock(vmf->pte, vmf->ptl)
>>                                      do_fault_around()
>>                                      __do_fault()
>>                                        filemap_fault()
>>                                          /* page cache is not available
>>                                          and a major fault is triggered */
>>                                          do_sync_mmap_readahead()
>>                                          /* page_not_uptodate and goto
>>                                          out_retry. */
>>
>> Is there any way to avoid such a major fault?
> 
> IMHO I don't think it is a bug. The man page quoted by Willy says "All
> mapped pages are guaranteed to be resident in RAM when the call
> returns successfully", but the later COW already made the file page
> unmapped, right? The PTE pointed to the COW'ed anon page.
> Hypothetically if we kept the file page mlocked and unmapped,
> munlock() would have not munlocked the file page at all, it would be
> mlocked in memory forever.
But in this case, even the COW page is mlocked. There is small window
that PTE is set to null in do_numa_page(). data segment access (it's to
COW page which has nothing to do with original page cache) happens in
this small window will trigger filemap_fault() to fault in original
page cache.

I had thought to do double check whether vmf->pte is NULL in do_read_fault().
But it's not reliable enough.

Matthew's idea to use protnone to block both hardware accessing and
do_pte_missing() looks more promising to me.


Regards
Yin, Fengwei

> 
>>
>> --
>> Best Regards,
>> Peng
>>
