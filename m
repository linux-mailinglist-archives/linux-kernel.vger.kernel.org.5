Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BAA7F5A07
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbjKWIby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjKWIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:31:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35AED49
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700728318; x=1732264318;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NiOt7q/s7vY16mQ6FoKFKII5Zzz1SacsBW/6wYHhwu8=;
  b=eXq1yfCOgAB01qK4LuAepSsE26zu0JWMr3NVXgCr+YpBRpfIY5sfTrKS
   v+i7o449YQZapMip4e3tEtjBe3A90bR94PY5J4j3gwN4mT2YfXgV9+yFz
   WjEunT2d8g9LJK4rCxJbbgRfOmEjSpiLTD32I6E2VGnCm1t+rGSJJvesf
   nOnJgt1p2o9VfqcyPCOCBPbKY/RH9H1tEP9Z1sOv0OXFQafJWk69kovTv
   jB5fIORAKeslaRJsZm44FIU9rMD9eSSN05Eg13G+y5QMiuWgwTaxAcMj2
   Iw31ifS2rCxyagasH0SM3+Xl49gIxsexJ8vqxlipHO7Jimd1Tx14/AGjQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478424367"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="478424367"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 00:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837730540"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="837730540"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 00:31:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 00:31:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 00:31:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 00:31:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 00:31:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrAYKZ91DX5oJzC6bddE9WKXeqJs7CIU6xeNhA7snUYvZSxQnmmaK9xwx8fNKTGvgk4rl+Kuu2HMj2JHlP6I3oRsYZkodDfmoJvsXnVViI0zs6fDhxCwITlg8vtFM23pNpHbLIkdKK7WkaDn6p7uK5U2gPYqSoRkrmE/wiNoBwoouxfyeDGjxxfXPgAUpFVXU3kgnw7dLyWm1d1u5Gr6MfyxeIDRVWyG1gIyzajTZe3AqwdtPb+99X7NXB+N53LrUXzRNzz3w51HHl6N/8u62yhHlWilG7Zg4C8L0c0TmMfwuy0qurcMQ+VhtWRit83HEeQ7fjJuVtgpCPVZQbpipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRN7rPA8aejJfgy34h6zIBGRbRxsLIGBc/hL3OIJ9og=;
 b=UactFNPK6yYPv2jD+JGCOMrm6pJOa4OCpJddiN+YxdoKB0ncgbatYe95AnG87m0zLf55d28BKFSa5yBH32Z/d/ChUwcTSen9bKhNSgDTATBCXO+n7bTOli2egfj/64ASRj1bhjdGjaeArV27EPCQz51/fh5MqqnXbVLB5G6PWboieQG4XB/Qv5SIszlNPfCTB70SGx7/MKNQB5Nbs/nWHe1waA5FDMgkpIr8I1bPbMN1P6b5mCd3FfSJnq9ofWaOWr0V+8TdturlGEWtexBQiqGOzXbFW56g7sJImAp56j8GKU88gJAWpE/5t6+7JFGcQun68ryPD3pNDOMVhhutOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by DS0PR11MB7960.namprd11.prod.outlook.com (2603:10b6:8:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 08:31:34 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::50f0:1dd8:29fc:3f87]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::50f0:1dd8:29fc:3f87%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 08:31:31 +0000
Message-ID: <1f29e229-d07a-41e2-97da-b6720bd5f2d7@intel.com>
Date:   Thu, 23 Nov 2023 16:29:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <ying.huang@intel.com>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
 <f4dba5b5-2e6e-4c5a-a269-4abe8fe2bcd8@intel.com>
 <b0d869e4-108b-8ffe-e9f7-65c4d98f2bf8@huawei.com>
 <801bd0c9-7d0c-4231-93e5-7532e8231756@intel.com>
 <48235d73-3dc6-263d-7822-6d479b753d46@huawei.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <48235d73-3dc6-263d-7822-6d479b753d46@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|DS0PR11MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eb9e15-cfec-4a20-fcec-08dbebfe97de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nLaLGePDzQKO+SFiKcXROrhiG4egdWvwE8tVYPnn7RNYm4kaBciOsojx5GPe3/uO27a0NzgmZ6hK1+lrbP3JSon8K2YBz2diL506sjOdSt/UiiF2Lpg0ryx6KhWnNy7hqtOg32MgpHLiwS/1URApzDhl0eaUAfd8SvZJNNuQI+NksXF4n917GOaeS8klh/NsHGNXPnLg400uM0EtU5ieBdhv2y5DjsWrSscCSCpoKASpoM+Vh2wkjjZm1RBMY6CmpYkTmjGtk25Wcm8ecpIGjPbgkQ3ATVkoz4305HnJLgvlAq4xuEVPC5oT8XKNIKpq0GVy67JaqcH+p6oZuNSvqlFiYdWfiXb1eC+3rioKk9KUD09SLM/OZzYJ8rMaIsezkfVlW7ioxlyI6h+MH6GpPXGndTTFmsipYZRFk252AwxWpHgAu+Lc1i3WgLVT+pn7Ux6ITXEQQMZfcwLkBI1TIpd/ERtRf3vKTU5XGDhuttq1E/XANsaHqrXe8yl2WbAOhckd7G4jE2J1op3vGI0ictrKrE1cG8bhxGQ9lTua+vwSy5m5F74lXmtfMm/STtrIsXab2tH9GxPXTOM8fscCf2Yl2sOSxH2EOS4zJNj4jepL7qC1gLn2l6a1UtHPQaq4xf/BLxm11uFZzq0XCMCVK4On+gY6+yFO8BglYc3PIFUl7yLwyvWu2i9lHzP/H6A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(7416002)(2906002)(8676002)(8936002)(66946007)(66476007)(4326008)(66556008)(316002)(41300700001)(6666004)(6486002)(6506007)(478600001)(966005)(53546011)(31686004)(26005)(2616005)(6512007)(38100700002)(83380400001)(66899024)(82960400001)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnNteVBIMitncTE0V0lDRGdSMnVETmRiQnRNOFVGazV0cFBON09jWGpRQzRq?=
 =?utf-8?B?UHM3aWV6UTdrZGgrVmN5b3hkYi92MDZyTkpiaW9XdUNzbm4yYjdmQnlEMDNt?=
 =?utf-8?B?TmN3YS8rRjdERUdoMDdIZTYyN3BMeWJHNzFmTGJiV1FROUZUTVAxcUJFN3gw?=
 =?utf-8?B?SUFzRHdPVWQ0UUJJMWU0U0pGYjZXK2k3Qjl3Vm5jZ1RNblBLdVJWMzcza2ZT?=
 =?utf-8?B?b2h5UVNZTGl5OHBEVVFTU2ZrK0EwYTVMVi9nengwaHllZnplQUUwazhRQi80?=
 =?utf-8?B?Y0lRMkRyQzYyTVBjRjR4Wk1WdC94dTIxTHJ4SWZGNGZyTmpaeEowRFhNcyto?=
 =?utf-8?B?QXVlcjY2TnBNckdPZGFtbzlkNjd3bHNwaWdwMENZNS8wWlZrbFd4SjdlcDVR?=
 =?utf-8?B?a01ITjR2b1ZjN1I2YUk5KzdieUVTMW5MN1VsVCtRVVJ6d1BUSUEybTluTHhx?=
 =?utf-8?B?QU5xL1FpMzV2d1BDUmp6MDNJdEQ2WUNyTDVGVGJOSnNZRFlxcGZxWGJyem02?=
 =?utf-8?B?ajNWYjdXeHFlanFNaThTMEsxYmZYYTcyS1hKelNvM2x3YTBxdlg2S1RsK1RB?=
 =?utf-8?B?Qis5N1RONDBrVGR4Vk5zb1ZTdTFNaVJNMER0U3o5TlBLN1pUdE9kdkV6ZzVW?=
 =?utf-8?B?YlpscTBhenZEam82SVE2S3I5R2k3SU95amdZZVQxd3B2MEFIeDJVTXZMbmRX?=
 =?utf-8?B?aEc1dkY4Q0xDcEZuKzlURWMwZXpXb3hteXV2WGlobld1ZWNaRG5TSDc2aHk4?=
 =?utf-8?B?dGtLdmtVbWp3UW1rSkZXWk5CU1Vqc0tFR3hqeUs0T0FGbVVoR2p6eDNYemsy?=
 =?utf-8?B?MUZDL1psODFpN0hpN3o2LzJ5YzhMV1BZZi94dkRMODdEeTkzQjI0NUJiTnY0?=
 =?utf-8?B?ck5YRU5qZDR6Z2UrZXhNVWtyb0J4Q0FXYjhncGc0QzN6TEtOVGIyTWwzYjg2?=
 =?utf-8?B?SmZRcGMxWXVyalJiZTN0Y1B6NzJqSENRaUJONkhOVFhzbVBNN1NqYkZINFBy?=
 =?utf-8?B?S0x3cGJYTGR6K1lFTkhUdDdwVzE5UGtYR2JOY251RVBKby8zalpNSmd2TjhM?=
 =?utf-8?B?b1JIczNhaTJQUkttSHJVVVU5YXV2bjU5YzRUNFpqRVdSaVlpK0FEdVlFTmpp?=
 =?utf-8?B?czZYVjQwWEhNeFhuazlxT1ZUT3FISkNoK21IdlltQmxGVmptNHhlRGd0aEJ0?=
 =?utf-8?B?MzZMQjBCaU9sZGNlRitkTzgzclBkYjl2aDI1a3VSb3NCU2svUytKcit3L0Rq?=
 =?utf-8?B?V2ZyeFFLVzZLRXM5MVk1QlhMOTM0NnY2R3hBUFpjY0pvYUl0VE1ad05PM0FV?=
 =?utf-8?B?dW5oeWhENVJXMFJnRVhFOVROQTVqNFVuZ0NMejBOQ2JPbmd4YUI3UGlnNThN?=
 =?utf-8?B?a2xaeDhyTVNrd2tSOFlHUkpPVUNTOGwvbCtlVkpmbU1xR3NTWVU2MUlrb2Zt?=
 =?utf-8?B?UWxWVjNyekk1WFQ1eUNicVRIc2NSYm10NFVMTkJtd0djcFRyOGdmYVNrZDZk?=
 =?utf-8?B?Z0FOeXVkN3Z0NEt2eWN4Tmc4d3g4U2lSdHZQbXZYcC90WVlYNzFlWWY2T3Iw?=
 =?utf-8?B?VXBFZ3BneWMwQTNBbDdDeFR2b3NtU0Z5V0N6Z2FkbXoxd2UvM1FEcExGSmxI?=
 =?utf-8?B?NmRCaXhESXlsOWVjL0IyN3dvNFlzNFU3WmwvbjRhbHNsZFdUV3NwNmU0U1dU?=
 =?utf-8?B?TFdSU3Vtdzk0OHlQTU9OMExYSGFYektuR0VaSnFMVGN3ZVFPc2N0OXpLWk1n?=
 =?utf-8?B?YlM0RkNoK0tCYWRtQk10NlZIeHVNQklVeURwcjZNL0pvc2RqZUNiOGNudEIz?=
 =?utf-8?B?N2paV3dCMXN1UDZpR3dOWkFQRmpobmYyK2ZBdksrMHVnWkRaY1hVL1pKdmNH?=
 =?utf-8?B?Z3lmRG1ZYzd5QW9hNGcrSGtXZnpwSnFZaVhDcXlZM0ZLR3lvQW1LOGtQMklw?=
 =?utf-8?B?dzRxUUpvN09HUEd1VlRTUVA4OG1IY1dkUGYwTWFTYXdTKytVQk56dUNaRGM0?=
 =?utf-8?B?bjFYR0VWNFY4OUZ4Rng0bi9INzZGUVdTdmVyZHJZb3NCN25URVVsamZNSXV2?=
 =?utf-8?B?bGgzU3RRbFZNT2dRaUdTV29ZL3BtV0V1czdCZDk4REtzRThiU08wL2N0SmtO?=
 =?utf-8?B?NWcxMmRydkNrRko0YnFYd3phMENZZ1lpU3cyTUI5VzhMbXAwRG0yeEJNS2dB?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eb9e15-cfec-4a20-fcec-08dbebfe97de
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 08:31:31.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+B4wpJacFpmswmZJF4PFkVjX0jUGFYZv14ODa3h5z03X4nVjzwcxc3tpUnCkjD9XTvLn5o4c4qnfaVDOiUBoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7960
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



On 11/23/23 15:57, zhangpeng (AS) wrote:
> On 2023/11/23 13:26, Yin Fengwei wrote:
> 
>> On 11/23/23 12:12, zhangpeng (AS) wrote:
>>> On 2023/11/23 9:09, Yin Fengwei wrote:
>>>
>>>> Hi Peng,
>>>>
>>>> On 11/22/23 22:00, Peng Zhang wrote:
>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>
>>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>>>> in application, which leading to an unexpected performance issue[1].
>>>>>
>>>>> This caused by temporarily cleared pte during a read/modify/write update
>>>>> of the pte, eg, do_numa_page()/change_pte_range().
>>>>>
>>>>> For the data segment of the user-mode program, the global variable area
>>>>> is a private mapping. After the pagecache is loaded, the private anonymous
>>>>> page is generated after the COW is triggered. Mlockall can lock COW pages
>>>>> (anonymous pages), but the original file pages cannot be locked and may
>>>>> be reclaimed. If the global variable (private anon page) is accessed when
>>>>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>>>>>
>>>>> At this time, the original private file page may have been reclaimed.
>>>>> If the page cache is not available at this time, a major fault will be
>>>>> triggered and the file will be read, causing additional overhead.
>>>>>
>>>>> Fix this by rechecking the pte by holding ptl in filemap_fault() before
>>>>> triggering a major fault.
>>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>>>>>
>>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>> ---
>>>>>    mm/filemap.c | 14 ++++++++++++++
>>>>>    1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>>> index 71f00539ac00..bb5e6a2790dc 100644
>>>>> --- a/mm/filemap.c
>>>>> +++ b/mm/filemap.c
>>>>> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>>>                mapping_locked = true;
>>>>>            }
>>>>>        } else {
>>>>> +        pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>>>>> +                          vmf->address, &vmf->ptl);
>>>>> +        if (ptep) {
>>>>> +            /*
>>>>> +             * Recheck pte with ptl locked as the pte can be cleared
>>>>> +             * temporarily during a read/modify/write update.
>>>>> +             */
>>>>> +            if (unlikely(!pte_none(ptep_get(ptep))))
>>>>> +                ret = VM_FAULT_NOPAGE;
>>>>> +            pte_unmap_unlock(ptep, vmf->ptl);
>>>>> +            if (unlikely(ret))
>>>>> +                return ret;
>>>>> +        }
>>>> I am curious. Did you try not to take PTL here and just check whether PTE is not NONE?
>>> Thank you for your reply.
>>>
>>> If we don't take PTL, the current use case won't trigger this issue either.
>> Is this verified by testing or just in theory?
> 
> If we add a delay between ptep_modify_prot_start() and ptep_modify_prot_commit(),
> this issue will also trigger. Without delay, we haven't reproduced this problem
> so far.
Thanks for the testing.

> 
>>> In most cases, if we don't take PTL, this issue won't be triggered. However,
>>> there is still a possibility of triggering this issue. The corner case is that
>>> task 2 triggers a page fault when task 1 is between ptep_modify_prot_start()
>>> and ptep_modify_prot_commit() in do_numa_page(). Furthermore,task 2 passes the
>>> check whether the PTE is not NONE before task 1 updates PTE in
>>> ptep_modify_prot_commit() without taking PTL.
>> There is very limited operations between ptep_modify_prot_start() and
>> ptep_modify_prot_commit(). While the code path from page fault to this check is
>> long. My understanding is it's very likely the PTE is not NONE when do PTE check
>> here without hold PTL (This is my theory. :)).
> 
> Yes, there is a high probability that this issue won't occur without taking PTL.
> 
>> In the other side, acquiring/releasing PTL may bring performance impaction. It may
>> not be big deal because the IO operations in this code path. But it's better to
>> collect some performance data IMHO.
> 
> We tested the performance of file private mapping page fault (page_fault2.c of
> will-it-scale [1]) and file shared mapping page fault (page_fault3.c of will-it-scale).
> The difference in performance (in operations per second) before and after patch
> applied is about 0.7% on a x86 physical machine.
> 
> [1] https://github.com/antonblanchard/will-it-scale/tree/master
Maybe include this performance related information to commit message?

For the code change, looks good to me.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>


Regards
Yin, Fengwei

> 
>>
>> Regards
>> Yin, Fengwei
>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>> +
>>>>>            /* No page in the page cache at all */
>>>>>            count_vm_event(PGMAJFAULT);
>>>>>            count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
> 
