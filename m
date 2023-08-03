Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6087B76E6BD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjHCLVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbjHCLVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:21:46 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A10127
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691061704; x=1722597704;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YgyqLJRFUtvJBhsK7dBOla0SBF6Ut9SPc9kAM0m+MuI=;
  b=IwOU/YYftOOBmv5nA8KlnkD/BowD5v4gGEFXWfV5HXjSW0hyFFZ6eI4D
   kGu7rfBBvB63J2x1boAyecs1x+n5iIPb/8sBoOyl2YwCwNf8F6Sk6+rBr
   qOjylTkd5CeAD9PJaAuYxgvRWgovdPY5j+CG//l1FvILZGkLiqXIKawBs
   9oDO2e43toawf63sjV1Xvwhr9barkGZjKJ+OPsxjxgwRQ8GvcieFeXNFE
   U7Vne9S7I2y8jOIZ1XXOECnG84kLz/8yjSYE/O9qiVq8xjEe/r5CU/SR3
   PS/jfYYotbMVX8jTHgoFD/emgdLyJq6m7p7DHEgg0YZa8iO7zSiEr8Ep1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350140136"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="350140136"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1060220994"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="1060220994"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2023 04:21:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 04:21:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 04:21:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 04:21:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 04:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEp/sukQp52nDKfuSB4Nodk3/EnKkQ/PD0bawGWlbkEq2oapVLDDESW6QMiIp0dXel7ngXAL/Do8itOkuWY0pzyK+N0ZhthR8OcStgjO5JVXQFGBVZYeiXdfD8lUEwu+37mNa/G8LGmNgmtnsRC/T5Ty1j+vKaKDeUaQ4lXL5dhBEv5AoXO6jRnHF72hTxUpHU/jYei4S20eWrXbE9Nx5RNhS1WhNEGhX09KEH1MmfgxIdrh/dK2H/6Ll1hcWqO0nuFDREMl/GQO4EsEQOV/kd106pP2bFJ96bzrHisug16AnK9kv2l8/UhVvfwNeFInicolfEg+S3uUfgyaKyN0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDmyXaxzh6oSeqaXtN6fmhQGF2t/wyQMwQ3ARXFQF5A=;
 b=BysH+xcYmPEmao44PueTfBrhpHSdvP9cZkQZ+D5XaV3UgSfjwbu+xkdQOzZ1yE97DVnNaPDVQxxUEC/7VKMo9hSKDwaCaDRQtcyFuG+YvtJz31ilvFIpTwg5HGsGGNFzR5uAGFV3GHhfzV4tZQOh5L4u7y4K5fdw9OT23wYTYOizGdCgIOseD2ONRVy0+1XLZ6tFm5Z/LIdoL7l8a69SznItTfKw0TBvXzghh1eR1YCougSp1YPRPsyWiBMASbFMkrJreSw1fe58aRkEy1WvBmDOU8fs2sxrOiU8fvy7+i6apy92w514OvvSLnIOQ17vpDa/X2ZzJZ4FQN6zjv0Fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:21:41 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::4e97:daa2:4c07:fc9c]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::4e97:daa2:4c07:fc9c%6]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 11:21:40 +0000
Message-ID: <5ce1b222-645a-20c9-d262-798430c8a9fa@intel.com>
Date:   Thu, 3 Aug 2023 19:21:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] iommu/vt-d: debugfs: Increment the reference count of
 page table page
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230625022808.42942-1-Jingqi.liu@intel.com>
 <BN9PR11MB527672460238BCBA63CD3CA58C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cf8b0163-56c9-0540-c635-b541132a77cd@intel.com>
Content-Language: en-US
In-Reply-To: <cf8b0163-56c9-0540-c635-b541132a77cd@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:820::36) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|CO1PR11MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: e138bc3e-b307-452f-31a4-08db9413cf3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeW0O3TQLWK6ONhD1G57HzX5si4RfdJuxnA/odDCKuIH2Tccm1elXbV07WEPQtwkU7YmI2eiqiwFh2cgJKcGSYOPy8PLrkEqHnC9Iqpkza/lii5JHdq653eRwb3eaaqETpJh0FvoajJN1chZHw776kCx5YnlSoilxbjvx7mCwu0wyGoHD9eH8YIR+2Chod0X/SgYUNEQ1UUYcFbWW1VprHpMFXISTsp3Y76v0ovkCIFhm/X7GIuGtrjBY8hSmHdISNYQB/7qkao1mCFTjehuRraUrcTVOk+wCne8UeOcNGeWL6lf4VWfhljGzpzOdReDCTrR/pJOhftkLiLJgDnKVGnrljqK6KO7h+KrSUcR/gu/EJM/8CnxwwYLT1FdRo9NXYcNgsnMoJ46eyqMTy+a/aA+CY8p9h4Ty3SUlPJuJM0lPjluWRphPTafybWb5FX3uzJJPeGw/fxYs5KLUUCqhtExJsGVu7Nb1NHqxAi2qwNrzC2fKpDW3b/f7ZOgwgzKsmu8cCv9/4TUJb6Pkv10UxLRZCrqfJ3v2nfgKIvGlMJNWb5+1YkxIx9fDnDHigoo9XmXumMRRB3NSkqRQ+vV6vy1Ty9adyhjgP11jdBjWdEwoMZmPCZZtah5fwxX4TCphJeetGFg0/7/0ZEt9eONlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2616005)(53546011)(83380400001)(6506007)(26005)(186003)(41300700001)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(316002)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(110136005)(38100700002)(82960400001)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRYendiZG5vVUVTVi9WZ2toMUJFbFJBOWx0ZTNmTXZLVElqQVNJNGh4MXpt?=
 =?utf-8?B?NVh0dHNaVmJWNXAra2pCeHJhd0NTL0ZVSXdzU3hUdklMaldPNWhRWXdBZU0r?=
 =?utf-8?B?VWtPYzRUa09GZ2dESnRyUy9EUElKSUtEYVdhVUVwZVhjSHJjT3V3UG5QamJW?=
 =?utf-8?B?WmkxWkkxV3RBamlwelR0S0JpYkJpWEFsZkNLalFQVyszSkprcVZ0RVk5SEFk?=
 =?utf-8?B?dUdhbEZJZG5Mdm1vbE9LemJPS1Z3WmdTNW5YMkRjOUtOcjRmUW1FQkpDaE14?=
 =?utf-8?B?Nkc0TzlZc2x2UXpuWTloci9zRnV3NTlNdVNqdDlYSVBlamhNODMreDF6VVBL?=
 =?utf-8?B?ckZWVFo2OGEycm0wL3prN2J6ZlNNV1FYVGdJZ1l0dnhheXZOT2dYU0F6b1dV?=
 =?utf-8?B?ZXBzeW9yaTN2dkJxQWc2bkJVQUREZzBTOGt3S0xvem5leGxwaUd5SzNIOXJ5?=
 =?utf-8?B?VjZGc0dSY1BnY2xTd1NIaUdycGxhSENjUEVTbGVFVEhZMUE4c0IzQXhtTXMw?=
 =?utf-8?B?M3FGY2t5YzJsRTk5cFNTaEgxaElhb2J0aElLQ01kY2RmaUhja3BvVURGM01r?=
 =?utf-8?B?eHJuaUczWEhYdFRDajNXdVJhMG1JeVB0UDhyOGxWRXpiYVdNcFdQRzN5emtQ?=
 =?utf-8?B?SGpHY3FTNjNjem1XQzlXaWFFY0tPdDlpSlJMT3FGbTVLdEFvVkp2MVF6ekpP?=
 =?utf-8?B?ZkFncGREUFduaFNKVmJOeHFkeWMrOFBDSVJYMENvZmZRWEZvOWdqamJYUkx0?=
 =?utf-8?B?K0hXdVlWZDRqU2RtSThFYnEwM3V4ZGZnTU1wUklUdFRYaER3N2IrVzdaWEx2?=
 =?utf-8?B?dXJ3cHF2ZkI3b0h3QzR2eTRCL0tBNWFHcGlqdlNITU1vR2FNTnM5TEwrYjFX?=
 =?utf-8?B?Ly80MFFFeWwybmpUQ0lUN3NCWWREaDlTM2tQU085Y3d3UUIyWWMvNGtCVjIv?=
 =?utf-8?B?RnNac2FLVzJXYnVzMXgvbUV2UnZMU2lzQk01T0Jmb0JVcXVDdEFNSnRwNXlW?=
 =?utf-8?B?bEgrRlkySEUrdkRsUG9nWkg2ODNiRVRxbFlNb2ZhdGNvU1I1Y0VMQ3R4Q1FN?=
 =?utf-8?B?MHBNdFNENXROLzVnQ2UyUGlZL1c3ZXpJMGkxQVBiLzM1aHVZNDJEbHV6SkNs?=
 =?utf-8?B?aENyNWhzN2IweFRNMFlVOTBTMlUzRElpQzF6TSs3djZMOWdsVWJXRy9HNXNr?=
 =?utf-8?B?NlRhQ3dLQ09rQWVFaWtiU20yMUNDSHdhd1NVSU5hU3oxUEF3YWNaajVXR3RL?=
 =?utf-8?B?dTBSMFFUakRZa3FkUkJHU05NWkdQdzhtQ2ZyWjZ1R1Y0MFRTNnV5Z0tuQjZT?=
 =?utf-8?B?bCtocFZjaWMxWkk3LytnWXQ4eXAxS2NrWDRienNBeURVZXZjU2JIYTRoblBm?=
 =?utf-8?B?ZVhEWTdkUEJMOUJVTmtHdVg4d3NmZXZ1dUk0bTU1YjdVdXYvSlhCTU9JTVVy?=
 =?utf-8?B?NHEyYTdEa1J1dkJQakhFcjgyam4zWFkxamtRU3hlK2owdmtIYUZ5K0VoQ2k1?=
 =?utf-8?B?ZEtuOWN5cDJPS3N4MjE1LzI4MmhvWUVQb1NCaDBZd1lTbXBEalRsMXA0VFVi?=
 =?utf-8?B?MVo3UGx4eTlYbElFSi9NZVVxKytJWG9DNmVkRFBkeWNyM3NDdXhzRWhaNS8r?=
 =?utf-8?B?L0lHMHRKZ1QvaUF5NGRobWdnbUlja0RxMTZ2aFZxajBaaDFjVVBGZWxvUlgx?=
 =?utf-8?B?b2cxSVRQTFZTdUtBSXhXRnZOVnYzTXVOMW5DbVFwUnFJKzBvT1ZXQmxDYlBV?=
 =?utf-8?B?eEtnakxRQXhZL2JTM0RqalBFWGU5ZHd0ZXFBMDVwdUVCU3hPY3hlZUx0eDVn?=
 =?utf-8?B?amR6R05OWVZCYW1HYyt6dHBEL0JzbUlqQkZldFdGRlVjUmVIbWVFRzJYSDJk?=
 =?utf-8?B?WHVJQWlrL1pxL21EVVV4YkFRbHpNNmtxM3ZHUDAxS3VBTll5RzhLbzBIR2g1?=
 =?utf-8?B?b09qeVc0T0wxU2w3K1d6THVFTm1kbzdEUzB3ZGZNQThVQmw5YThZZWlOOEla?=
 =?utf-8?B?RDVseXJlQksxeVd1SW5BcHJLZHJEZmJQbjd4alIrYVk1d0UvRktKazdpcVlm?=
 =?utf-8?B?K0JJcjV2NE50VXoxV2tNd2syblJlZlg4eXVMeUFUSDJBUUlhc1dvY1prWW42?=
 =?utf-8?Q?YKeqn9Mas8tqRHN0TVDKsDq6h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e138bc3e-b307-452f-31a4-08db9413cf3b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:21:40.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/Wacte57mLPvbjkBwtGl2uHmb0rc70XU1Zg9g79R10TF/d7bFI9pj/k6tzhy9ndzwovF/Sk0E9EHyl9NMqvDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4882
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 7/3/2023 10:48 PM, Liu, Jingqi wrote:
>
> On 7/3/2023 3:00 PM, Tian, Kevin wrote:
>>> From: Liu, Jingqi <jingqi.liu@intel.com>
>>> Sent: Sunday, June 25, 2023 10:28 AM
>>>
>>> There may be a race with iommu_unmap() interface when traversing a page
>>> table.
>>>
>>> When debugfs traverses an IOMMU page table, iommu_unmap() may clear
>>> entries and free the page table pages pointed to by the entries.
>>> So debugfs may read invalid or freed pages.
>>>
>>> To avoid this, increment the refcount of a page table page before
>>> traversing the page, and decrement its refcount after traversing it.
>> I'm not sure how this race can be fully avoided w/o cooperation in the
>> unmap path...
> Thanks.
> Indeed, in order to fully avoid this, need to cooperate in the unmap 
> path. :)
>>> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
>>> ---
>>>   drivers/iommu/intel/debugfs.c | 36 +++++++++++++++++++++++++++++++++-
>>> -
>>>   1 file changed, 34 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/debugfs.c 
>>> b/drivers/iommu/intel/debugfs.c
>>> index 1f925285104e..d228e1580aec 100644
>>> --- a/drivers/iommu/intel/debugfs.c
>>> +++ b/drivers/iommu/intel/debugfs.c
>>> @@ -333,9 +333,41 @@ static void pgtable_walk_level(struct seq_file *m,
>>> struct dma_pte *pde,
>>>           path[level] = pde->val;
>>>           if (dma_pte_superpage(pde) || level == 1)
>>>               dump_page_info(m, start, path);
>>> -        else
>>> -            pgtable_walk_level(m,
>>> phys_to_virt(dma_pte_addr(pde)),
>>> +        else {
>>> +            struct page *pg;
>>> +            u64 pte_addr;
>>> +
>>> +            /*
>>> +             * The entry references a Page-Directory Table
>>> +             * or a Page Table.
>>> +             */
>>> +retry:
>>> +            pte_addr = dma_pte_addr(pde);
>>> +            pg = pfn_to_page(pte_addr >> PAGE_SHIFT);
>>> +            if (!get_page_unless_zero(pg))
>>> +                /*
>>> +                 * If this page has a refcount of zero,
>>> +                 * it has been freed, or will be freed.
>>> +                 */
>>> +                continue;
>>> +
>>> +            /* Check if the value of the entry is changed. */
>>> +            if (pde->val != path[level]) {
>>> +                put_page(pg);
>>> +
>>> +                if (!dma_pte_present(pde))
>>> +                    /* The entry is invalid. Skip it. */
>>> +                    continue;
>>> +
>>> +                /* The entry has been updated. */
>>> +                path[level] = pde->val;
>>> +                goto retry;
>>> +            }
>>> +
>>> +            pgtable_walk_level(m, phys_to_virt(pte_addr),
>>>                          level - 1, start, path);
>> What about pde->val getting cleared after phys_to_virt(pte_addr) leading
>> to all the levels below 'pg' being freed? In that case this code 
>> still walks
>> the stale 'pg' content which however all point to invalid pages then.
> There are 2 cases for the page pointed to by the PTE below 'pg'.
> 1) the page has been freed.
>      It will be skipped after the following check:
>                         if (!get_page_unless_zero(pg))
>                                 /*
>                                  * If this page has a refcount of zero,
>                                  * it has been freed, or will be freed.
>                                  */
>                                 continue;
>      Debugfs won't walk further.
>
> 2) The page has not been freed.
>      The content of this page is stale.
>      Dumping these stale content seems to be acceptable for debugfs.
>
>      If all the PTEs below 'pg' can be cleared before being freed in 
> the unmap path,
>      the following check can avoid to walk these stale pages.
>                 if (!dma_pte_present(pde))
>                         continue;
>> It's probably simpler to just check the format of each PTE (e.g. whether
>> any reserved bit is set) and if abnormal then break the current level of
>> walk.
Thanks for your suggestion.
If the PTE references a page directory/table, bit 3 is ignored by 
hardware according the spec.
In the IOMMU driver, bit 3 is set to 0 by default.

How about setting bit 3 of the corresponding PTE to 1 in the unmap path
to indicate that the page pointed to by the PTE is stale ?

The code modified in the unmap path is as follows:

static void dma_pte_list_pagetables(struct dmar_domain *domain,
                                     int level, struct dma_pte *pte,
                                     struct list_head *freelist)
{
         struct page *pg;

         pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
         list_add_tail(&pg->lru, freelist);
+
+       pte->val |= BIT_ULL(3);
......

Then during debugfs traversal, check bit 3 of the PTE before calling 
pgtable_walk_level().
If this bit is 1, debugfs will stop traversing.
The related code in debugfs is like below:

+retry:
+                       pte_addr = dma_pte_addr(pde);
+                       pg = pfn_to_page(pte_addr >> PAGE_SHIFT);
+                       if (!get_page_unless_zero(pg))
+                               /*
+                                * If this page has a refcount of zero,
+                                * it has been freed, or will be freed.
+                                */
+                               continue;
+
+                       /*
+                        * Check if the page that pointed to
+                        * by the PTE is stale.
+                        */
+                       if (pde->val & BIT_ULL(3)) {
+                               put_page(pg);
+                               continue;
+                       }
+
+                       /* Check if the value of this entry is changed. */
+                       if (pde->val != path[level]) {
+                               put_page(pg);
+
+                               if (!dma_pte_present(pde))
+                                       /* This entry is invalid. Skip 
it. */
+                                       continue;
+
+                               /* The entry has been updated. */
+                               path[level] = pde->val;
+                               goto retry;
+                       }
+
+                       pgtable_walk_level(m, phys_to_virt(pte_addr),
                                            level - 1, start, path);

Thanks,
Jingqi


