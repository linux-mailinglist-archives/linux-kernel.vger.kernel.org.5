Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1D7678F9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjG1X3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjG1X3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:29:36 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947C63AB1;
        Fri, 28 Jul 2023 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690586975; x=1722122975;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OVSK/FhcVG3J3JAy/eAThT2eJILFcv0R7KE7X3dwCM4=;
  b=CXNShaiQEdwyo/Ly0BFBvQuwyhzeC6QBnEiVZknTJbgUajMBywljQjjd
   ukNAPDy0yjoJDYDoXmpkHFon9TEQNulfJS8iPfkaxhx2R95s6FalQE20O
   ws/7PJ55ngvRcUstw4VDkekGKDEsYoUhcnysrJwmWo9nCgjCdKls0ZdNw
   LDQ7XfjH+u4XLFXPAeebmh3yFJRpBr/hDKrxRvuvRmK22MNCDuxcGaLAH
   q0Z7fiyfS2F4BgEkNake8e8JaP3dsQ3V+OgEw1EYelqVrrl31Ke4kMZaH
   FZTnz62AIWJ51AOCeE1KJjgYRtphcz5raZuKeTxEnbbyUm/v77zbfBUlC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="348998375"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="348998375"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 16:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="797586077"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="797586077"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2023 16:29:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:29:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 16:29:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 16:29:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW1ZHVM9Id0DltqmnsYq60NoGT5d+MSvgghqFC+mXJEdy9T11r58dxRW9vsJDY4kw+T00DOu4qFRmDQmy9kjm7EnMmDRgsaw/GDU4krV2mx3pBZ84AqcBsXcsewASWW/93qiLsl99OwZSccTf+KV4Shv57aT+/r0uxw0uoIQUNLQOpBdX98jcqhDaTuikveZAmL4UzWkwb7OdtDeNmJ/xdGkWN6BkC85TnI/xmPnzRdpjHXE2HMglLgcDp7vcOQ86HFsVeocGO5SR/qc+aD3uMEH2CU2IH6lCI6eCaVh6Q5NsUhQPTTJGnOi8Y7l/ovBgQAef8knaxTgP+sYVNPj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZz1mjuM3pKwSq6TWIg8UQwzI78DXQQ44/5FznZYPws=;
 b=KF7ixPbcrCOGckHcefyYhGUVAa9D5wJf0vocDKySJIgXi4G4n2MBh/LVLtFt5iSns6t+oYuGgKSbp6Yq1ZdjlrGScJu+6p45MfADsCqqB95Xsz3240X3mHvUN+OrSSTieRIxKnXofx0OE9bTpAoRNjnkTUIOPa1+Xk76JpcABV8zf+p0YY+mShXBrka/a3YdQ3n4uEw7uDqy706xbNZvSb8K2jTMcplEoGXxXhtYz3FBf9gRKWDffQGbjjGlFvFRSRUVcGQ5eZ8TjH6jxTOZmrrpQ/teMnfI3cuFJOnFxg1QsvPv6L/NALGBgykrjupnW6N3UWL39Py7YfijEEmVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH3PR11MB7324.namprd11.prod.outlook.com (2603:10b6:610:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 23:29:26 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6631.035; Fri, 28 Jul 2023
 23:29:26 +0000
Message-ID: <7dc2b325-e6ca-2a02-9a89-bb9e314d379a@intel.com>
Date:   Fri, 28 Jul 2023 16:29:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl/memdev: Avoid mailbox functionality on device memory
 CXL devices
To:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230728-cxl-fix-devmemdev-v1-1-dbd3269b3295@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230728-cxl-fix-devmemdev-v1-1-dbd3269b3295@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH3PR11MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5890f8-4fb9-4868-d6d1-08db8fc27b93
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEICIo01RvlfrBvzlwdouV+2eCVVE/zCV1tduzdQvQrm68c0XJx1D9QcNzju9OGQFwbda9Maj3M84YgfuKUP6d7VMKD5OPKcTjo/i/N8lzhjZ6j7JZ1h4bqdAVI2hwO7ukA2drkQ1QOx+aAduEqFszxtAFmPQ3MdeVlvDszhf5cCkG4fM5F1SanrRZcmEfyxWq12p+YfBnqXikAMTh3ljoEc+0/6IjYazjquYlD6YIuNQczFVESFz/23wmpUUebewudbaWT7mpZHP9d2OsEeH3RaqY4XBEdtH5bOCOnS39XNwL1ZkmXNJULaJZJl+F+VqLmiyN/qM7iaoiMfhpKZ4nnsTk9wyXUZ1OaDVK8/mVC+UGTbYkUxYfMR0DRkuLjSweiZgc1TGSAMe/0jDWLAHFFKenqJTybN2x1QY4WTM4SsQHByuUfXOzLAlb7M+JX2D9B6W7Dd3Cl+bh/yEqjTdKzoRV0uRDwalj3g7ou+cq8e8EmEuCk6r0F+IUpbHrHK6X6s5x1rhIoR2sO+hkzYlE+f6dTanhMa7r02LN4MK/7JLBOUB3KeL5qEsO5uN4xPvJCiXweKirWq7lKvAahPAYnu3Pnw+CqY3A35/eQx9iWAg7s0OpiH14Cz6pfQMxqQVSxy7cFOOB2/R+9MIwPipgxzQAk+op8JtFaooWhpfTZOwVHkn9ds+7GzQUnQujJS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(41300700001)(2906002)(8676002)(316002)(15650500001)(8936002)(31696002)(36756003)(86362001)(44832011)(5660300002)(966005)(6512007)(53546011)(26005)(6506007)(478600001)(6486002)(82960400001)(6666004)(83380400001)(186003)(2616005)(31686004)(38100700002)(4326008)(110136005)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THR6bUY1TzVFeVBCeEJqblFTOFhtS3RnMnRTQlJlK3huWlFjTjBkQnVSdStC?=
 =?utf-8?B?V0RLd1IwN25mY1FnWllwcmxzTTFXOGJrd2xNSmNVM0VKRFN2RFE4bHN1cXho?=
 =?utf-8?B?U0R1SHB1Tnl6UlZQcmVORzVZOWdNRXR2MTJ4aVdleklsS3NZVzBBZjBrclZ3?=
 =?utf-8?B?cHprbkp5UktJQXVUNEhSQmFMRytleHdudmR6aFpEV3JBbThXaXV1Vlo2Zktv?=
 =?utf-8?B?K1MzdXRiZTdkTWU0dnEzRWFHMjFDMjErOVlxYlRvcTUrY2FyeE9TNXFHdTFa?=
 =?utf-8?B?TkF1SnpCbHg2R2JDZ1g1Y2ZSY1VLY3lxV3pBSGNueisrb2lZa1dWaS9LVWhC?=
 =?utf-8?B?ZThBWFNRVG8rYnQrdGdyR2c2NmxFNlVFNWRYbWd5LzdnVEprY3YvbjkvUGRE?=
 =?utf-8?B?SU9mNi9RaHcvVEd0YW1qaXJoNHVRMDI2U2tadFY3MGFoSE5yaS9kSkE3QVZF?=
 =?utf-8?B?UVFrSGVpR0pxTzVBU3RPaUNVL21xV0UxOW5FVHM3TkJyLy9JYnpkQ1NlRndV?=
 =?utf-8?B?bjl4STFUSFAxaEhpbXVJUHl2WlNDNG5vNGt2UjFqeXZIYjZoWTBSR3R3Q1Y5?=
 =?utf-8?B?WnNSZDBabnEycGxBYzd6WEhCUmNDQ1MrUTh1T2tUVWlHUXdkajBCSzNLWGdi?=
 =?utf-8?B?bDNlRDhCWnFkRHlLVUdUbXd2dHR5SDR0c2xmZCt2citUSTN5T3I0NUMzZVdP?=
 =?utf-8?B?NzZTdVhXWTFmbkNTNDNsODB3eVpkUGphWWp6eUhBNUtoYkFDc0cyZHJQYzB0?=
 =?utf-8?B?dVZiZGRIeDJhd2wyUUIxcTI3dnlHVTloa0dWcG5DZkI0bDJ0N0ZJUVNMenRp?=
 =?utf-8?B?Yzhyb2dRSENFQ0NuL2F5bkhvQTZ4YnRIM0pUaE5uMkUyQWFQMHZGUVhOMVR1?=
 =?utf-8?B?VGZjSjZuNlhZb3NWQVVzRTdkem4yTHJhdmtkdDlWSHBiZFJCSkJhb3ZEbHkz?=
 =?utf-8?B?UXdoTHNUbnRUWUs0bnNnbFZ5WSs5cThGbHVLVExpMkY5amVSWVd1M2JQbURZ?=
 =?utf-8?B?U2dud2xmNXhKZGsrRlRYQmNMbCtpTlZVdHhJRGdyMjhuMlVzRExZSWkwTmoz?=
 =?utf-8?B?U3Jpd0Q1MnRnMFA0Ynp0Q2UwaFlwVnBZODhoZEkzUUdiejVLMFpLbldIMG81?=
 =?utf-8?B?cDNSUi9PU2gzRWZvQW5ueHhOa013UXdtQjNnMzJDQlFvdHhKa0NqUkUrWGRZ?=
 =?utf-8?B?bmM4aFVuLzNwQ0ozRDhFNWorbVRPQ0RRa1AzVTdnbmdBQlFIdDJjcEErNEQz?=
 =?utf-8?B?aXdUMzNjd1dLbGpEbHNNQXhmaFI2VVdKRCtBOXZxUU0zSEtMN0ZtSVRRaVdk?=
 =?utf-8?B?RFZkUXQ0bnc5dTB6YzRhb1lkU3BvZ0hXa2wzR3dreERTSy9xWnk4TXd1RWZU?=
 =?utf-8?B?Vi9VYWhOSnNmdHR0UklGazlWNXdmeHd0bSt4SVJaS3VyNXJJK0JrWHBpdHcz?=
 =?utf-8?B?UCtJeGJXeUJhU3NpK3VNOTUwQkhSS041bSsycHNnbHNYZE1SeGxQaTh1UHJx?=
 =?utf-8?B?Wm1Rc0JVYVRsMkxUejM2NUs3NklJNXFoMDNWOCt3WVl6ZHF2R2t1R1dWSEJS?=
 =?utf-8?B?VWZqZi9VNE9pUlBySU9jKzlnRC9WblNnWUNWdmxXK0Q1UnJmV3duVE1YRHVh?=
 =?utf-8?B?MHBZampsc1o2SGhyWUVpT3hUMzlzdmoxbU1GZjRmOWNaeGNhd1owSU03TTJv?=
 =?utf-8?B?cHZyRXVSckxoditCYVE5b2hYcHdEc2FSOTk0b0VQZURqdFowYkhhMm4yaWZu?=
 =?utf-8?B?MWw2VXVocy9TSUppM1QwenZaUWVhNmpjcXlLZHdsOWpYTHhUSXgvdlU4MUhJ?=
 =?utf-8?B?Rmo4cDZheU9yd0QvUm40bUp0WmVuMVU5MU9SZVJocG9Fa0xpVHdISzIwdito?=
 =?utf-8?B?T2FvdXdGVk5hZGFodFl1S1lJREpiUisxVDVJTTVHTmRSWVEyc2VVdzZOR1dP?=
 =?utf-8?B?ZVpjMEF3aUExRFg2WGphQm10bFlTcDZjRVlROXJ0aUxOVjFaYmovWEhaYXly?=
 =?utf-8?B?OU5BS0VTREdsU1l6MDY4N0F6UVJwR054Ykpja3BLaEpKNG1uN3VTa2lZK1Z3?=
 =?utf-8?B?T2Y4QlEyVys5VkgrQzlRdjRvclBFcHMvV1o5ZHR0NHpvTHY2TWVyYit5Qlk2?=
 =?utf-8?Q?lndW9p8wscni79tf4yyz8DUcV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5890f8-4fb9-4868-d6d1-08db8fc27b93
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 23:29:26.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btZg2xSTJ5uORpvdRKh/rN6BOXlbQk+SN6LndZfLNKNjRgS15dDzp9H+4IEhoNQPsUS5dghbeuSASwKGzDIITA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7324
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



On 7/28/23 16:00, Ira Weiny wrote:
> Using the proposed type-2 cxl-test device[1] the following
> splat was observed:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000278
>    [...]
>    RIP: 0010:devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>    [...]
>    Call Trace:
>     <TASK>
>     ? __die+0x1f/0x70
>     ? page_fault_oops+0x149/0x420
>     ? fixup_exception+0x22/0x310
>     ? kernelmode_fixup_or_oops+0x84/0x110
>     ? exc_page_fault+0x6d/0x150
>     ? asm_exc_page_fault+0x22/0x30
>     ? devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>     cxl_mock_mem_probe+0x632/0x870 [cxl_mock_mem]
>     platform_probe+0x40/0x90
>     really_probe+0x19e/0x3e0
>     ? __pfx___driver_attach+0x10/0x10
>     __driver_probe_device+0x78/0x160
>     driver_probe_device+0x1f/0x90
>     __driver_attach+0xce/0x1c0
>     bus_for_each_dev+0x63/0xa0
>     bus_add_driver+0x112/0x210
>     driver_register+0x55/0x100
>     ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
>     [...]
> 
> Commit f6b8ab32e3ec made the mailbox functionality optional.  However,
> some mailbox functionality was merged after that patch.  Therefore some
> mailbox functionality can be accessed on a device which did not set up
> the mailbox.
> 
> While no devices currently exist, commit f6b8ab32e3ec is incomplete.
> Complete the checks for memdev state to bring the code to a consistent
> state for when type-2 devices are introduced.
> 
> [1] https://lore.kernel.org/all/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> 
> Fixes: f6b8ab32e3ec ("cxl/memdev: Make mailbox functionality optional")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>


I think you'll need to coordinate with this patch from Davidlohr?
https://lore.kernel.org/linux-cxl/20230726051940.3570-4-dave@stgolabs.net/



> ---
>   drivers/cxl/core/mbox.c   |  9 +++++++++
>   drivers/cxl/core/memdev.c | 26 ++++++++++++++++++++++++++
>   drivers/cxl/mem.c         | 18 ++++++++++--------
>   drivers/cxl/pci.c         |  5 ++++-
>   drivers/cxl/pmem.c        |  3 +++
>   5 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..eb1758fb8cdf 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -482,6 +482,9 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>   
>   	dev_dbg(dev, "Query IOCTL\n");
>   
> +	if (!mds)
> +		return -EIO;
> +
>   	if (get_user(n_commands, &q->n_commands))
>   		return -EFAULT;
>   
> @@ -586,6 +589,9 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>   
>   	dev_dbg(dev, "Send IOCTL\n");
>   
> +	if (!mds)
> +		return -EIO;
> +
>   	if (copy_from_user(&send, s, sizeof(send)))
>   		return -EFAULT;
>   
> @@ -1245,6 +1251,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>   	int nr_records = 0;
>   	int rc;
>   
> +	if (!mds)
> +		return -EIO;
> +
>   	rc = mutex_lock_interruptible(&mds->poison.lock);
>   	if (rc)
>   		return rc;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f99e7ec3cc40..629e479f751b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -201,6 +201,19 @@ static ssize_t security_erase_store(struct device *dev,
>   static struct device_attribute dev_attr_security_erase =
>   	__ATTR(erase, 0200, NULL, security_erase_store);
>   
> +static umode_t cxl_memdev_security_visible(struct kobject *kobj,
> +					   struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (!mds)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
>   static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>   {
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -332,6 +345,9 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>   	struct cxl_region *cxlr;
>   	int rc;
>   
> +	if (!mds)
> +		return -EIO;
> +
>   	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>   		return 0;
>   
> @@ -380,6 +396,9 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>   	struct cxl_region *cxlr;
>   	int rc;
>   
> +	if (!mds)
> +		return -EIO;
> +
>   	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>   		return 0;
>   
> @@ -480,6 +499,7 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>   static struct attribute_group cxl_memdev_security_attribute_group = {
>   	.name = "security",
>   	.attrs = cxl_memdev_security_attributes,
> +	.is_visible = cxl_memdev_security_visible,
>   };
>   
>   static const struct attribute_group *cxl_memdev_attribute_groups[] = {
> @@ -542,6 +562,9 @@ static void cxl_memdev_security_shutdown(struct device *dev)
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   
> +	if (!mds)
> +		return;
> +
>   	if (mds->security.poll)
>   		cancel_delayed_work_sync(&mds->security.poll_dwork);
>   }
> @@ -997,6 +1020,9 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>   	struct device *dev = &cxlmd->dev;
>   	struct kernfs_node *sec;
>   
> +	if (!mds)
> +		return 0;
> +
>   	sec = sysfs_get_dirent(dev->kobj.sd, "security");
>   	if (!sec) {
>   		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 317c7548e4e9..4755a890018d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -132,12 +132,14 @@ static int cxl_mem_probe(struct device *dev)
>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>   
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	if (mds) {
> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_inject_fops);
> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_clear_fops);
> +	}
>   
>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>   	if (rc)
> @@ -222,8 +224,8 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>   		struct cxl_memdev_state *mds =
>   			to_cxl_memdev_state(cxlmd->cxlds);
>   
> -		if (!test_bit(CXL_POISON_ENABLED_LIST,
> -			      mds->poison.enabled_cmds))
> +		if (!mds || !test_bit(CXL_POISON_ENABLED_LIST,
> +				      mds->poison.enabled_cmds))
>   			return 0;
>   	}
>   	return a->mode;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..93f6140432cd 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -122,7 +122,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>   	struct cxl_dev_state *cxlds = dev_id->cxlds;
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> -	if (!cxl_mbox_background_complete(cxlds))
> +	if (!mds || !cxl_mbox_background_complete(cxlds))
>   		return IRQ_NONE;
>   
>   	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> @@ -624,6 +624,9 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   	u32 status;
>   
> +	if (!mds)
> +		return IRQ_HANDLED;
> +
>   	do {
>   		/*
>   		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 7cb8994f8809..f1adfdd1a2b3 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -70,6 +70,9 @@ static int cxl_nvdimm_probe(struct device *dev)
>   	struct nvdimm *nvdimm;
>   	int rc;
>   
> +	if (WARN_ON_ONCE(!mds))
> +		return -EIO;
> +
>   	set_exclusive_cxl_commands(mds, exclusive_cmds);
>   	rc = devm_add_action_or_reset(dev, clear_exclusive, mds);
>   	if (rc)
> 
> ---
> base-commit: 20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
> change-id: 20230728-cxl-fix-devmemdev-5003ce927f68
> 
> Best regards,
