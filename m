Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B49D79A461
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjIKHYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIKHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:24:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425BCCCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694417078; x=1725953078;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5B961ZYFAiKUkO8PfuIA4pOAk//aN0pcCl2YRQk0dzQ=;
  b=L4tOVBXppzVozPHLD5/zKBs2d8nDxAZGIkCT64U/kZpPFex4r2BrcI97
   LIj2VmLfSI/CiBbNgVLV64bzT0kcZ/dp5K4ecmEcejox6x8MNN1fb1U9q
   Y4htyJB/2zhx0hxnzIpyH/p2raUZ/MEsfGbtO19JH9AGaLLNiM7b/Q6gT
   KvFsLntvrPdMgrIkSzpTKKk6htZFVEFcGpGSiUvlgXz4K+SXCt3LW/LBj
   6jXNXXmkXm/y8FuIQseQRvlsrBACXwcMCAQv9rdEuDImG7bMa/c7hXOij
   I6RH+rH2rbhUJB6ur2Q28E3g+4hbkdx0Nwr0jst2ut/RJcCliuKIYlg15
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="377931083"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="377931083"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 00:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="746319294"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="746319294"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 00:24:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 00:24:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 00:24:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 00:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoFduAH5V69IpIzWxnZkT685VkEinXAowfAVo5c1SbfvWybuk6nNsqRQCCDB616SvNFb9zqom1u/aYcSAi2RQkwHH2eP/BokpUeD+M5B2AfiACfQ8ji1FHyvJAA5yZtBBKDDZNs/W+KspUQuGMdKkSkqs82HAkX5usEEtSTVKCpNTu/7TXN2NAlsNGiOxlF4eZBQNZSe3idcOdj3aJbwYbYtUmO526ipQKMZ/B0wk/9D7pZSF3Xpic9vUZ1f2HZhYIwL61J8hB/W0p/8jPxYw4FJU8PACxnIlXooc1qwjGvc5ZhMU3VBM70zW9YwF7aszmUWvmQRK4d2s8bxJZOK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKn4huzS9wEzQN8h5UwXw+msm3l0m/wgyeUrsfHLMzM=;
 b=AmZdhxaUh9BenT8qrlkvgJPPZnp0KGXTb2H/2EKO3GUqhxomFsg/W5xcUZu7yAs+vKHH8U0CMnvu/58aQA1c2Eia/hOvns+3FOqz78A01g1Kn+en9q2+8kKMJfD0+cSTvrNzQeQ6eJt86xlY6KvPDlj5NuWAQ9UHnmwpjyjKT4Q9N2R52HYHwdsDu/Mv2wVcWg88bwJWLH2SVjrYjCvMvEDea2SEB+sdAdBFNtDrL74w3/MQgpCag8i7bHIUAgrzJUmh2viy6zO8gLA3oLZZFRybcU4XkAVb3YfyWKDTZvCooxDg0P2wKdlWk1ZQqS/Ss1rwkDEcYdiV2zDw0k9mww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 07:24:35 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:24:35 +0000
Message-ID: <ba941c8f-381b-3db0-7ec6-ba1094759056@intel.com>
Date:   Mon, 11 Sep 2023 15:24:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <syzkaller-bugs@googlegroups.com>
References: <000000000000d099fa0604f03351@google.com>
 <ZP0xyFnnghM42GcW@casper.infradead.org>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <ZP0xyFnnghM42GcW@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 5247a3d5-9585-4cbb-c232-08dbb2982651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVzkmi49sCUSYFH+eI3HRqly6geOgFGZxmOMWJPOKCxf6MshEQwH4oXEl6jIS1geo+fnYd6WW+2r3t7YGqsMiD9x2iDM3cUFELBzQVLt7eywH5dDDKRICKnCz5RvKOug87zJ2w/ocLWJwuCjhki3K/5+FuXxvZ9mCezMomBL2HZ49aIMNakN9HAjtbD86uo4YuEYrh51CsWHHgUXZ04KTVndqOUpUb2qY4OXrnopXqD4QPvDfAGrsN26oow/8VRCDqzeIZY+ITAfEPg3ymZmKvBcbary4ubnnCAeihTUUHB6SWrMPTlo6AitMCaU0kzzuor52cbR8I+pJjMSPeDVI6dngXfNeI1ZsDMHCF5pc6DfCpkxy6MGMxrDvGELIWwft/jgqyGy2yZSOjZWV0p+WNKixJn2WPzx3R4AFQlbAgyYl5FT7uwwvOJf+yG0Wv3c9ZbFV5gPqyNGHGrw3Sww1m9WXCJ3IlHeKikljEf8MbH6EpW6Jt58ByCIpjZ2g69ndaInZtYzNKdF5SwBNJ/11jD63iRQ4PSdvyZf9+Hf6d8B6FBTxjbOzOHiWqiEOc8w+vxUIuGzLhVxtDVLufBQERCLEFkJARCTSSFBc6MoM4hosDCQJZOylrzGv7kU9AAd0cC6QmRQUmvz8CXX2ROUkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199024)(1800799009)(186009)(110136005)(31686004)(6486002)(53546011)(6506007)(31696002)(86362001)(36756003)(82960400001)(38100700002)(26005)(2616005)(6512007)(83380400001)(478600001)(41300700001)(2906002)(4326008)(316002)(8936002)(8676002)(5660300002)(66946007)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aElMSSszR3ZnODlML1hvcVpyV28yZUR5WWt3d21BamdHR3ZCY3B6dFlGWnZJ?=
 =?utf-8?B?UlJMbnUxMmhLZDVLSDZFSmdGOFNVckJ0NkdWd2VpWkJIbzRxUXlNNXdmOEhz?=
 =?utf-8?B?MzNtUXJ3NzVFREgzK1Vka2tFVVZIZEtpTHRUd05vUmh6OStHZ01aNGRQV0d5?=
 =?utf-8?B?eitvZ2VBQjh3KzdCYXBCdnNESU1vcjFjMUFFR2xnLzhPNG5PV0lqOENIM3RR?=
 =?utf-8?B?cXpKODRtR09hQXRLbnJ5dnd5ZVlCc012T2E1VSt3TmRjYWYvWU5PUUtHK1Zs?=
 =?utf-8?B?SXkyYnY0N1VVNnozeXlYUXR6SFFJSlNGU042MUhIMktWNk5WQzAxb0NIeFQv?=
 =?utf-8?B?UDhxdnhGRFIycjZYa010MUl2WUw0a1czdjQ1TkhGRmRlZ0w3N0Q0VGNVdTJy?=
 =?utf-8?B?V2h0eWpMME5iMi95S2R4WEhCaGtYZzBTci95Wkxmb0M1OEtwaWxVd0VFc05I?=
 =?utf-8?B?TGdUbWpnSEZ2dlg1YnNTa2QrT0VkaCtiWDdnejBJK3Fic1ZzVGxoQzVaZGd3?=
 =?utf-8?B?THZrUGtTbDZ3anZjR0EwcFBsZmdpQURwNlQ5VWE0MUhXQkJzaWoyb3ZsaFU4?=
 =?utf-8?B?bGlLWlR2dTM1MmJ4NDRKNE9uNzQ1TFRqNVI3ZVBZekcxOXZ6SU5oZkRHRUxn?=
 =?utf-8?B?R2JGUURZejVmWGZnNkFveVp5ZU9CM2FqUkwyWm5TcW5BT29LZFJWanVEc09q?=
 =?utf-8?B?eVNpOU42UjYzdkJBSWNGMEo4S0syS0pMenJMT1VlOHpNem91d04wTk54NTda?=
 =?utf-8?B?bXRKUWMxVThPdnE2eXBocmV3RkdicFBmbHRuTTBRaS9sWWxRMEdvNnQzb1g2?=
 =?utf-8?B?NnMwNnVldE9Ga1NiWjExYkY1Q3NmZDdndGphci9ub1E0QTYwYWRVYmZPN3Nl?=
 =?utf-8?B?TGFXelJ6aGE2Q2lCTVdBbUliZkRFamFGK0VyeThUL2xXQTlWOVBNbG9vRjhB?=
 =?utf-8?B?ODZNR1p3OEx1a0F0Q2JBWmhpMjI4QUVSbDQxanMzTytBRGU3R3BKZFRDK0lZ?=
 =?utf-8?B?MUlwaFBhcE0vbVpCZ1BFTGFGWXcwakpKa1dOUm9TYWlWMFlhR0V4dWhjOC9Q?=
 =?utf-8?B?RVlxVEhGT0hwei9zTjdzZlZKTTdDUEQ5cGhReUtsS1hQdGhaQVh5Qnl3ZTUz?=
 =?utf-8?B?WWloMXJuRExMd3ZBS2tiNk16eG4rdnVCZTdmcVlMSFJNcm5lMlJ6WllERXcw?=
 =?utf-8?B?ZVNVNmQvcjh0YWNjZlRxeTk4NXMvTXJQbnhKbk1KL0gyS2w2clQyMmJhUUFQ?=
 =?utf-8?B?bjMrWnpmcGZFcENvejhXd1M1bG8wN3gwcTl5ZzZHR09aa1F4SW1MVVVCWFFh?=
 =?utf-8?B?bWdGK0N3STNJWmVSbEJhV3lIRzBUeGhoUkYzdHp6MmpOaDhyQ1hzZHdHYndW?=
 =?utf-8?B?WmZXWlVRSm84T09VTEJmcG43ekcwYURtRXlWWEMzRmNlaTVuSllXQmNmaFl2?=
 =?utf-8?B?MElIa2lsRGpGZVgreDluNXA4Q1BGcEdYOGtKTXFBdkhxaURmcnN2VUxaVnAw?=
 =?utf-8?B?RSs5STZ2V1ZzTW5JWlBOU2dpN2w2b1NIZVJENXFqZ1VuaFplTjcxWGJ6eWln?=
 =?utf-8?B?L3Y4dFVxRDRVMllMTmsyb29ydzRtK1NYQ1N3eXQ1TitUcmZFeU83L1kzOUor?=
 =?utf-8?B?YzgwdFBJNFNHS1oyMDZUd3JmcGNUOUdXSmRyRVlpMDRPbU4vTWVhSWxVTmZO?=
 =?utf-8?B?U3c1R0tLalQ4dElMOGhzL3ZjeFBueXM4OEFqL3B0d20vNEpCbVprVy9SN0VF?=
 =?utf-8?B?a3VvWDNWbWpKS3NvcGVVZ3BXcmN5VWM5MUNZMlllSFZ4NjlXbitUYWp2bzE1?=
 =?utf-8?B?R0NOWmRSZklGRENKUWZPVzhibUlwNHg1NHUwZzY1TzlsMmJKby9QeS96OUpt?=
 =?utf-8?B?WSsyRmpLWTY5MEtEa0daN2JoZ2pRZ3pKY3RXMGU3elZmSWtmNENRNUVQcGJJ?=
 =?utf-8?B?NUZMQnJMWGhnOGJiN1JsaC9jWUp2MHRUYU9KUHdDaVBmeTEwU1JVbjlrSEFY?=
 =?utf-8?B?VnBVbzltY0UrR0tlQmpPWit6WGVVMUZqSWhHNTNySEtjTGNrOHZuRnI4cDJC?=
 =?utf-8?B?cDhENEhPVkpLT0dMZzREejhkaEdMRkJ1NDdkZFd2SUNnSUhDVkdIUWo3NG9k?=
 =?utf-8?Q?uQ2+8JyTqhWbSmP/wIXsUjaPh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5247a3d5-9585-4cbb-c232-08dbb2982651
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 07:24:35.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLAeUBGD/Cwb04jHINzmjrv9j7eJEtXGYd7aceuL7aHLaF6J6XNCJVWOJc60DkpZAdUKPRzm8kCIm4xCQX1pmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414
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

Hi Matthew,

On 9/10/23 11:02, Matthew Wilcox wrote:
> On Sat, Sep 09, 2023 at 10:12:48AM -0700, syzbot wrote:
>> commit 617c28ecab22d98a3809370eb6cb50fa24b7bfe1
>> Author: Yin Fengwei <fengwei.yin@intel.com>
>> Date:   Wed Aug 2 15:14:05 2023 +0000
>>
>>     filemap: batch PTE mappings
> 
> Hmm ... I don't know if this is the bug, but ...
I do think we should merge your patch here. LKP already noticed some performance
regressions. I suppose this patch can fix some of them.


I root caused the this "bad page map" issue in my local env. It's related with pte
with protnone on x86_64. So if pte is not protnone, advancing pte by adding
1UL << PFN_PTE_SHIFT is correct. But if pte is protnone, should subtract
1UL << PFN_PTE_SHIFT. I saw pfn_pte() had pfn ^= protnone_mask() and just realized
it.


The producer mmap with PROT_NONE and then trigger SIGXFSZ and create core file.
That will cause GUP with FOLL_FORCE and create protnone pte.

I submitted request to sysbot to test the fixing worked on my local env. Thanks.


Regards
Yin, Fengwei

> 
> #syz test
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 582f5317ff71..580d0b2b1a7c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3506,7 +3506,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  		if (count) {
>  			set_pte_range(vmf, folio, page, count, addr);
>  			folio_ref_add(folio, count);
> -			if (in_range(vmf->address, addr, count))
> +			if (in_range(vmf->address, addr, count * PAGE_SIZE))
>  				ret = VM_FAULT_NOPAGE;
>  		}
>  
> @@ -3520,7 +3520,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  	if (count) {
>  		set_pte_range(vmf, folio, page, count, addr);
>  		folio_ref_add(folio, count);
> -		if (in_range(vmf->address, addr, count))
> +		if (in_range(vmf->address, addr, count * PAGE_SIZE))
>  			ret = VM_FAULT_NOPAGE;
>  	}
>  
> 
