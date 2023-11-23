Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C4C7F57C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjKWF25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKWF24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:28:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612FA1B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700717342; x=1732253342;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iwOnIX8gOehyrH/2mJuWnfrxzt9W1HaNSDfBN4dX9Mk=;
  b=LP88ZoOV4MBJRRa1efdI4rP3ozdFOUEMbi6UzCZ68Rv1ZkMl7MpNmoqp
   u4YGdZterecttaJ/uRzYepkBO47zAoeeTGRZgnBa+qjeNbgBiWSNPSNi8
   cOr43/z0zZut2gHk1zugQ4SmmOh/oJ9vd8T+nGk+aYBxlwcY5gz/k3qE9
   ZMbQwX5e2Jmdh6X1SyKjzaxLEh1AwxKcHB53cufflFd4kLayiT3T4Ir8r
   ZlUEGk4yhFwX1FePs9gVPJFSlnXgFz+U0Gl+GSAv/OHMqQnYxwbXHD5Wm
   ZKcaPi9fTgzPQWl21M69wYprYa68DX550yTVedAMDpWmCBOiM2bJ0INVy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="371553508"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="371553508"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 21:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="8543492"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 21:29:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 21:29:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 21:29:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 21:29:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqAPQufHCCxdmuIzxg/9lt+mhNoN/o02rYfIrqddNHg6XtuGaVVUDPVJiu4IdEGPSTuhnVAthBR7X0P0f3g+ydFf8RWzgSjJVrM8G6Bn7hvprPc4vvSj87xzypiwT/m2tAgUHjKOz1k6qlRuJm0xqRuQnWzG2JD9IXRFzZU1lWsVMyhM/RfWUznKQguPqhAi1FAJAM1SIRwxhWja0q0guSxlt7SsgBwUImXQ/G7rbSAz5HzltOoHn+zSfwq/vnXzGYZkpMcaKyEedAodGV0s435aw2yXeIavmI9cv+hVpQAM0lbXGb2SmWaTabclPXwf1UfxfZBS5KadFI8Elsw2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AngI0LgmCyzeGSyzNAaqTe4FdirgXHYKJjL2IFnKMg=;
 b=ZcGR8bEHMVA3AaexZz7TkkuC/4XboZxOvpQ787xmyoctJ+2UAssqCFnuOi2UJfRrzdxlLsfh76d0SqdFrIm9t8rtdiJrFJWOt8VCHHS5q1d82Yr2rLgb2SeGnxvX5ZZSt7dqEbimxaZhr8fMJInuzWQSkscKJVLBX13MNz6F+rGAnT5InOScZf9VyMCRPQSNWZvz9IM2SXxn7oTaovONv6AkWdC79Tvvx/hFNvnr2tPlgEJNB9fwAh14Lt5fow+C9NfLOun3f0HMTGsGNiBTqo+G1dJgvMzBTTd1JXVKO2RnxULbQLywta/XYpwIbrXAENKmDXKXB9qYqR7MqdUXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB8594.namprd11.prod.outlook.com (2603:10b6:806:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Thu, 23 Nov
 2023 05:28:58 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 05:28:58 +0000
Message-ID: <801bd0c9-7d0c-4231-93e5-7532e8231756@intel.com>
Date:   Thu, 23 Nov 2023 13:26:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <ying.huang@intel.com>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
 <f4dba5b5-2e6e-4c5a-a269-4abe8fe2bcd8@intel.com>
 <b0d869e4-108b-8ffe-e9f7-65c4d98f2bf8@huawei.com>
Content-Language: en-US
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <b0d869e4-108b-8ffe-e9f7-65c4d98f2bf8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9c9e2b-5662-432c-7848-08dbebe5172c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xJW173O2kAd2ikR5JPK5n+oKwMjemNuUBbr6SuCWVPqSQ9MalT0hYpfp9HAfRYwuN2raABrMGHVf+gDpn6/iBGQd/Ljw2mXLyMm7tHmP1bV0X6ziQf4WZiV1xsXFXYSGgRzdCkT4Npe+wpKq/EY5AWb241pSDQbLdkkyOcndg2ppKfHeKy3B1RIHdGKloaB2RMw3cc3hWPqb/DQqjUwcb5hjjc3jonkZu9kAUrazfuNg2Pmh+C8gskMByRv4UdRh+rDQqehg5U9WuZLMhLjNt/RIBDnFLWmBkrTaEGV+EP9q9QR4UfeZN2QjCyt89bNc0O+/6jPblU6DRKs42V6cPpNWLddFP7KJXNbbYrqVxELL9hL8ECoqp1hoaTwnucL0kqfduPIT26W39izyKKhvFlLFiLiGSxNNEhmpWtJe9D7G3PXO99l7y13FGGfOy7IiXZguoQ/EOTJ+/ueWvwPZ8ZK4M3Xeybsxhnp1sIK9EKF3c7XLDpeBsG2Y+14D++zPxW7jNTiJOvc/jAIjzJjqWLLfuXTSIrfZGj7bJRtvQ0hQ0co68ckHFfcVRdP7OSjw1Hkq1+LsgBBTIPm/euYQIadX/PWf7j9jw7eRkJpreKuxM2bQ13Nv1dJn3pCdUhd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(4326008)(6486002)(8676002)(41300700001)(31686004)(8936002)(2616005)(66946007)(966005)(316002)(66476007)(26005)(66556008)(7416002)(53546011)(5660300002)(6512007)(6666004)(6506007)(478600001)(83380400001)(38100700002)(66899024)(86362001)(31696002)(82960400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNSamZ5RWwxdnNFNGQ1TFV3dDE1ZDdvcTdwM1B2WjliZGVwZWRnbGZwUFdE?=
 =?utf-8?B?SFZmYzZJNW41d0tCSm4walNleTFYY3h0eFNhdzN2eUxYSlJDWFZ3TGc1L1I3?=
 =?utf-8?B?MUhkL1V2Umh3a2JZVm56dXVQdk9BajQyVWxuR3AyTFVFSzZjY3h4cnRRRXl0?=
 =?utf-8?B?UktORUdtS3Zkb0VTd1lLSXBjQmtMSHk1cC9EMGxtTGp1NXp4alo2ZnN6cjJU?=
 =?utf-8?B?WG9XdGptT2IvYS9XWFlhdFpNK0VROE5xYmJEUkpGdGRuMm9OV3dmUXJtbkcy?=
 =?utf-8?B?Vm5vUkZhR3crQTFZY3FpM09LaGhROC9zaW1DbHYwTVVQRTZpZFJhUWY0Vm5Q?=
 =?utf-8?B?bjMzeTlCUUJMM1dXN1kvYVVrZW1LMHM1Z215R1A3RXkzNW82cTNkZGZvQXVX?=
 =?utf-8?B?eU5TVHVJSUVpQXI1bll4OHZqZHE3ZGRielhlOEJyNy9QVnQzLzlScW1WTzgz?=
 =?utf-8?B?VmVPTHpKQlJDTlpsSDBlZXZ2VW43VGdvZFVTbVhRSW5QZ2cwSEpUR0Q0U1Vq?=
 =?utf-8?B?Und5aEd6aldJdk1GNW15OUYwMFBHdHg1aW83Mk5lQXJOQzhuMTJlUFNpZFh3?=
 =?utf-8?B?TVZWRUtpcDZwTzBLSFAycFhUSER4MFQxZVBiT1dTNXhUZGMxTjJBMGdGYWgr?=
 =?utf-8?B?amx2aDJpaTJlWlVvRkJsY3VRaUhyeWg3SFFRKyt0bzhod0E5VWFpT0IzcGRK?=
 =?utf-8?B?YzV4ZXNiS0FuTng4SnZDaWlvQjRXMEFtdUt4OVoyL3ZrVyt6MVFjcWVNZGZD?=
 =?utf-8?B?ZnNFUVM1NHY4SHZyaVV2blloL3ZUU1gyeWdUdFRQdzI5VElOaWNVbGxRRXQ2?=
 =?utf-8?B?TC9ORExSMXVSOFdYNzk3M1IvaE92Wnp3U3ZPQkNqa0Z4L3hUamY1Sm5ta25W?=
 =?utf-8?B?MnJGRm9KbW9ybkxEeEk4QVZDd05JR09WN2dZNjdQYTR1amtjcSs2aDFpVDVa?=
 =?utf-8?B?SXhBU0VpMUxOYU9UYktIbkpXYXpXMDdrMXhRY1lBczEvc1pEY2MyK05XU2c3?=
 =?utf-8?B?bnZpVjVCUzZqRnMvNVo3QTZreDU0eWdHR1ZSNGR1U0JSR0hNS0VjNXllUk5y?=
 =?utf-8?B?KzhpRE8wNjVqZWh3cFNkSVd6Q0lONE9LdytxQ3dXRUhnZEhXcDFmcjloWmt1?=
 =?utf-8?B?T2tydndoc2VlVTRHQTh4Lzl2ZkZyK3VRUXlzdVZudFYzMEVLUEx4K2tKRHQ5?=
 =?utf-8?B?dzhpWkE3SEFNbGR6SmdHN1VQS0t2TU52ZjNPSVd6a0NqZFMrVkVzK0xCeTZp?=
 =?utf-8?B?dEl4RG9FcndNeFZrQWNwWU1JQ09VMnJsdFU2VFp4anIvSnpaYXBSWnZmVjdL?=
 =?utf-8?B?THc4YjlteVFiL2syNGtMSHlVaGJEUU9KWFV4RFd3MUhkT2k1SmNJU3pCbkIw?=
 =?utf-8?B?VWV3MWlOemkxYkpUUUF0WktZZ01uN2ZDc0RBMGowM1l5SnlrRGY2Z0MvdGRF?=
 =?utf-8?B?Mnk0SkprRVgrNkFoQVZibmdnekp4akIwcXlDVEYzRDhZSEdZTmNCKy9tVzdD?=
 =?utf-8?B?c1VsMWpCTldGVXByWklSS0Y3dE05MU95c2UrdkdOWmVIMEVMdDdwN1g0ODRR?=
 =?utf-8?B?aFpnVCsrZUpYaFNqeWdJK2ttN2VYOVY3bytEcTdVVDJzVXdpQTRPaTBRaFRG?=
 =?utf-8?B?WDN4TE1yY2hrNDFlMitCNWNrdmRuYnB2cWFscnA3NWJzaXhaOVNIMEczS1dK?=
 =?utf-8?B?Z3orVk53NW9BVWJGSG9RSGlnRlBOU1hOdG04bWFMY3ZYUlM2Vm14eSt1dmgz?=
 =?utf-8?B?eWQ1OXNJcDVmOTNzZTRmTjUvd0Y2Y0paN3lUOHJQNndpZEdMb084MDArZ1oz?=
 =?utf-8?B?aU53WnUrbFlPdG1ST2xPWGNwSnk5VTIvNVMwblFWaFVxdkFzNU1BMWVFUDhk?=
 =?utf-8?B?SzdvREJSTWNMTTkwTXBUMVBxR1FmSGxPZ21VSFRRQTFuaU1xN2hIWENncVNR?=
 =?utf-8?B?K01SKzJRbjZvMkdXaVVoS09aTTJSM29ESEdKZ21qOVRQWUZXTnFPUzVLcWdF?=
 =?utf-8?B?TVBFcTJqdW15WTRESG40Y2JIMy9iQmJnOUtQa2N3WUN6Y2NYYW5kcU5NYVlB?=
 =?utf-8?B?cHRpOHpkc3dBTEljT2tPUTdaZHdXQjVLMDBZa1NPRHIycW5HY2I1ZlQzSzJ5?=
 =?utf-8?Q?f3CNEQnAb26/0WyuTwN+18W6B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9c9e2b-5662-432c-7848-08dbebe5172c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 05:28:57.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6y67foTKOn7K7aquupvwWZ9XBbCPPOt71pLS+5qMKZa6SeUyDtO6bpc5gb1TlLiPgswgiuyOkhXdMt+gnNLfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8594
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 12:12, zhangpeng (AS) wrote:
> On 2023/11/23 9:09, Yin Fengwei wrote:
> 
>> Hi Peng,
>>
>> On 11/22/23 22:00, Peng Zhang wrote:
>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>
>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>> in application, which leading to an unexpected performance issue[1].
>>>
>>> This caused by temporarily cleared pte during a read/modify/write update
>>> of the pte, eg, do_numa_page()/change_pte_range().
>>>
>>> For the data segment of the user-mode program, the global variable area
>>> is a private mapping. After the pagecache is loaded, the private anonymous
>>> page is generated after the COW is triggered. Mlockall can lock COW pages
>>> (anonymous pages), but the original file pages cannot be locked and may
>>> be reclaimed. If the global variable (private anon page) is accessed when
>>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>>>
>>> At this time, the original private file page may have been reclaimed.
>>> If the page cache is not available at this time, a major fault will be
>>> triggered and the file will be read, causing additional overhead.
>>>
>>> Fix this by rechecking the pte by holding ptl in filemap_fault() before
>>> triggering a major fault.
>>>
>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>>>
>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>   mm/filemap.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index 71f00539ac00..bb5e6a2790dc 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>               mapping_locked = true;
>>>           }
>>>       } else {
>>> +        pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>>> +                          vmf->address, &vmf->ptl);
>>> +        if (ptep) {
>>> +            /*
>>> +             * Recheck pte with ptl locked as the pte can be cleared
>>> +             * temporarily during a read/modify/write update.
>>> +             */
>>> +            if (unlikely(!pte_none(ptep_get(ptep))))
>>> +                ret = VM_FAULT_NOPAGE;
>>> +            pte_unmap_unlock(ptep, vmf->ptl);
>>> +            if (unlikely(ret))
>>> +                return ret;
>>> +        }
>> I am curious. Did you try not to take PTL here and just check whether PTE is not NONE?
> 
> Thank you for your reply.
> 
> If we don't take PTL, the current use case won't trigger this issue either.
Is this verified by testing or just in theory?

> 
> In most cases, if we don't take PTL, this issue won't be triggered. However,
> there is still a possibility of triggering this issue. The corner case is that
> task 2 triggers a page fault when task 1 is between ptep_modify_prot_start()
> and ptep_modify_prot_commit() in do_numa_page(). Furthermore,task 2 passes the
> check whether the PTE is not NONE before task 1 updates PTE in
> ptep_modify_prot_commit() without taking PTL.

There is very limited operations between ptep_modify_prot_start() and 
ptep_modify_prot_commit(). While the code path from page fault to this check is
long. My understanding is it's very likely the PTE is not NONE when do PTE check
here without hold PTL (This is my theory. :)).

In the other side, acquiring/releasing PTL may bring performance impaction. It may
not be big deal because the IO operations in this code path. But it's better to
collect some performance data IMHO.


Regards
Yin, Fengwei

> 
>>
>> Regards
>> Yin, Fengwei
>>
>>> +
>>>           /* No page in the page cache at all */
>>>           count_vm_event(PGMAJFAULT);
>>>           count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
> 
