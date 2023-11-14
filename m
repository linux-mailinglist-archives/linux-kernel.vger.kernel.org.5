Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC9E7EAE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjKNLKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:10:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CC12C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699960227; x=1731496227;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=38kooHsej37j7TgCTVqf571uJlAm6INB06zv5lNWqVA=;
  b=hHMJH5oJbKmTxMvsPhXC+X33K8u+cU/TVcjt1alAfjh8oj748IZZ4f+Q
   GGMgCcJnypufGN/AeoS7qD60svEsqa5GiCkhgCVUqqSwx9Xb+DJblUx0n
   +20Btsppzl5vIkcwKEdxGY37A1J2j16ugmWwFWQ+qR96C2QC7i3p3qbhI
   gQRcLPh1Rxla+3ob3jNWAU5X08+bjmCrq5Y+ilEqSUAREZ4a1EYgBY9rv
   ieqPIfem9LPWHPWSHLwwXEBYZ7+v5cfaNUXw5+lCOXSR6tx5Rw81W43fh
   71xMuEL2piPCaFq/NOSglK5VKuSaH+LqWHiBIfIlp3DlQdvU3hceoIjgl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370830559"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="370830559"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:10:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="793759264"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="793759264"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 03:10:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 03:10:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 03:10:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 03:10:25 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 03:10:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkkKo9jL95VPJwhvG8aZYQ7kC77wTfwEdeE/UkAXyYpe5w14nP/0MWIIIKhJ1SMBPHSq8LQ5DwzkmyUbOgH4VS3KCkmchZUC9nATWGOgYru++OD50Pjhbj0b7V32XfTR+yGWUsCtXfYFHX1ZFBzyr8QxDq6fWcnNDIqB2CPR2XdgjsVXb64VgCYSPkVuY7q2Aps5mILcGXJcCNRDCPEgyoWaoqbZoHShLFD+4cl9TYgmE6UpPj99HycZt4oIextOs8SdFXr3WBBiGpnpmkuz2nGknAVMK4Mst9bCaZd+hf0hELLpqqOzSHHclZMJzi1Lvmdv1V74OgaziYIdC2V2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD6iYwtFCHPvV2Xy7d8MmXRhCyRUjFMSoN/1QL/Wao0=;
 b=YfYbZRgjgl12NlvDuBwSpmN9VVDL6GDOvGbqcU61mzMvyZoy+BRzBLvTWfPfUneG5fyj/aDAqAWs4QIcVpc6dSixBlKeg7jUD42R7TJOFbgVyTaxVOxDvJqhcWqPsnBqt6QTUle1oGMAO3mg+4g0iudUpKQVpYFMwljLk/Dv2kfvfOmF+5uBDmvGK+g6f900mr+TyoF8xJPIIYss49wmaOsyz4uH4NRoKBrHOWs0DwYgRLqFMrjjzivoCMaDS1ZUssOdFLyCnahIE2rnc+P/Ot2COVCi0p20Sx9zxC/l9gI9DHhnowhtrwL8IOqV4/mKVNhk8f7oxR6k0eW6hIt8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB5875.namprd11.prod.outlook.com (2603:10b6:806:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 11:10:23 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::53f6:8fa2:1b02:6012]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::53f6:8fa2:1b02:6012%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 11:10:22 +0000
Message-ID: <0e618256-2d34-429b-b694-6f150d8fda79@intel.com>
Date:   Tue, 14 Nov 2023 19:10:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
To:     Yang Shi <shy828301@gmail.com>
CC:     "zhangpeng (AS)" <zhangpeng362@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, <lstoakes@gmail.com>,
        <hughd@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <peterz@infradead.org>, <mgorman@suse.de>, <mingo@redhat.com>,
        <riel@redhat.com>, <ying.huang@intel.com>, <hannes@cmpxchg.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
 <CAHbLzkqEytFbRoHU3=Y85tmTQ--XVQpwhVEXgDN0ss_PPv8VGA@mail.gmail.com>
 <648aa9dc-fc42-4f28-af9a-b24adfdcd43d@intel.com>
 <CAHbLzkokzDAAfWoB8gsUpSUubAq+V-Gu_0pjpaGvKb83kA0Vww@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAHbLzkokzDAAfWoB8gsUpSUubAq+V-Gu_0pjpaGvKb83kA0Vww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ccc836-be87-4d7f-e198-08dbe5024ba9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+khZHbgumI5P5EO03Ls5EM5A2AxKwbEPszNbHXvxdn4PJjDMTzqo7XaYQHsG0hVDxEZTqdxtwxT37Fp1ylr/cjL6cZPmKuhensE8K7g3A8VOwmHvobbTt/Undf1sHc16AZlsaLiWRsBx6dDdaofluY6/L3/AoBX4D/lInOcQX2QUApFFghTnvMGY6u8svfZmQWx9tA8O945A3kHXEV3J4/gVxrcs1bXrD+GhSpaOp6ueWt45EjMNfdkz19AiO33oBqClMjCPhbdcJtDPclGoLi7Xd396VWbx17rE21lmWE2U+YAuR79n+rsQ5oIrUs57BCKN/e7bnNd8fD34/HvCQjwfCrSD3hUH+dU+4ng3USKzpHd4bo8OfVtGCAp5rCTWb/ivKaDGoFZcQC51HgChga+/oZTdSdmr8bVzIQjuYxxf4r86ZM0hpZ9LlT4J5qMaDxyqPQr0O1vwuzoOIkn1l2KjX3NfGodPDwcISsFoa0egBvtJVPLcXTxTWAURpCWm4yhpMWzycTj1ro3vxy+ombNgQoMoD7zIWC2b8YdG0ESTWwnMJGlWitaR8vkykzNAkw+YXS9IfiiS8dGNd/miGcKjjjdO/DFjUnKPYMJiUIdGTrrairDDPhuVVB5QOEdOa6Re7yy9rCQ0Fn0nX878g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31696002)(86362001)(316002)(66946007)(36756003)(66556008)(6916009)(66476007)(54906003)(8676002)(83380400001)(8936002)(4326008)(26005)(6666004)(2906002)(41300700001)(53546011)(6512007)(2616005)(5660300002)(6506007)(7416002)(31686004)(82960400001)(6486002)(478600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y28vb1UxU3N1akNRTDdybTQ3R2xCdkorek9BYXpSMGxOcG9wOWMwSHNrekVz?=
 =?utf-8?B?K1AxOE1IV2ExTTZJZEkxQXlBVkxDSGNFWlFwbXRqMnFwak8rdUU1cGpZVjVP?=
 =?utf-8?B?Q2pqb2ZpQy9sQ1lMa3JZUlhxSGlSVzF4RDFGSU90TW1BRjRaSUQ4czI2M1Fl?=
 =?utf-8?B?L1dsVzdaaDlvaFVtTGtiU2NaL0hpdk5mUTQzN2NZbnFyVHVkZG0yQmdXNW43?=
 =?utf-8?B?cFR3Y0lXeldzMHRmYW9jRnNabzR3ekJIaVNjSUZnSGdPcDFLVlhnclFOMHV0?=
 =?utf-8?B?TDJiNDFGTG9zUlBidi9VaWxTWmRtVSsyRlFIYmxXNHZwalNNSUdhVE1iQUFG?=
 =?utf-8?B?YzVVbnFvRkdlTTdvRzB1akNBZjJTS1Y2aDBiOG1EbzVxbDlvaW1PcW9YWHhN?=
 =?utf-8?B?MzdwdkJkU1NMK3pRVXZjc2JkUWZ5N0FHSGNTMHk2Nks3eDh0VWJGUkw0KzJO?=
 =?utf-8?B?YytTeTc4eHpiQm0rRElQQUk0RjdBamFGcVRWSXV4NDBmakNaZHhsZExqK2I0?=
 =?utf-8?B?cldtdmtvQWlhZm1xQnRWaTMwL0xPbFFXSjRpMFJHZ1hKYnFGZGc2bHQ3Nll3?=
 =?utf-8?B?TzM0dm9pcGdCNFN2a2VGVFpKUnRwY2U0L1BRWkd1emlFbUhnRnZvS2RZWXFD?=
 =?utf-8?B?ZjhkZWpoRzR0RmFWTTFaZUw5UEZJNE93OElRUjAyazhQanZXK25UWGk5MkNx?=
 =?utf-8?B?T0FpOStxNzkrN0RmOTV6cTAyQmFWRW9nbm1WTVhHWCsyaTN2RVBEaklzMEVr?=
 =?utf-8?B?a1JuVE9rdFRlU1pFSUhpMHFTanVFbSthRG0vcWVXNFR0UWtIL0VhYTg1ZGo5?=
 =?utf-8?B?QUxad0JqeHBQNG5rNHdWYmdCbFVNR3YwL09zeklQbHprdzV5eThyZFhYa09I?=
 =?utf-8?B?Wmw1WWN5OVdXdlZnakJnT2Y1WnRielhjbGdpb2t3cjVHM0FqaTlEQnhrVTdp?=
 =?utf-8?B?cXlZZzVST1M3TnJxUUNleGtSejhNdC95NDRJOXRaeS8vZWMvV2RIRmcrdG04?=
 =?utf-8?B?WjNsRFB2M3JPTGtZb2RsSXFGMnNSNlNPb09EYUkwRnB6cVVBTFB0bi9nSEpM?=
 =?utf-8?B?RGFpOEYzeG9pYTZ6SldYLzdrMlJTclUzTEZXNVpaVm5vS25sNmg0MEhQZDBy?=
 =?utf-8?B?eXczbHBCMnptWUNkbU9adllzZ0RkV0dQQXlYN3hBZG56cGVibWZwand0UDJC?=
 =?utf-8?B?alJpeHVhTlNIRjh0SDFLZkVvdXVKRUhJWnl6TWNIWDB0cW5vcE5NZUh0RXo2?=
 =?utf-8?B?SXg0Rmw1YUxLUG81NDI5TjRaaU0zbzVrdlFBOEZYeFUwa2J2TmxhZ2FvTDNC?=
 =?utf-8?B?TWFXRVUybUdwYjVSMm5oRXdBenFlRnlTYkdxL1F1Y1hmVmxoYXZMUnYxNCtH?=
 =?utf-8?B?VHFua0t4SkJSUmFERzBqdHB4R2N3QXJIdmZoQXIwWEFVcWkxR3k0NWRmMjlQ?=
 =?utf-8?B?MFJkekxkbkh6WGpCeFRMVkNucUJ1UkhCMytmYzJQT3VSa1p3UVgvK2h3NnRz?=
 =?utf-8?B?dDk4L3QxKzlFL1VsN2JzUXNENUw1TDYxeHhIQ2ZUaWVkdlJrVDk2cXBwVGdE?=
 =?utf-8?B?M3NTelg1UE4xQXdDY3VpYlpPazNGVnhHSnZvVHVCN0liODRkNUZpODFUcFhv?=
 =?utf-8?B?WmlmTE1OcmlFQTNMNlhLbEdOUzMwR3BmNUVsUi9xVitDVm9pcmJqYk4zL2Zw?=
 =?utf-8?B?eEUwYjNPY0gvMFo5bzFTK2tDTW5kVmtoMVV6aEc2R2M5WGtEWlluaFcxZGpW?=
 =?utf-8?B?a0lUR2gvR2U1TitzdUNROUhLU0g4V0dTenkvWDNxbHNUVFVWM1NHbWp0d2Mv?=
 =?utf-8?B?eVptWVF0aDdLdTFISWtXUnhpNDVFWmd1ZWRSQ2VFOUo2QXo5dU5sK1l2QndB?=
 =?utf-8?B?OElOckNWNUxST0ZIUUNyaUozWGxXdmRPRUNOUzBYd21aZDNuTGNPNzdBdnJV?=
 =?utf-8?B?WDhWdm9xTHRYYWt6aVZBVkpreXpuTUNQZVNkMENQL2tCMWc2aUQ4M0R2N1RK?=
 =?utf-8?B?aW80ZjJTd1c5QlYwQ29LQ1VMQmhHamN0emZXZ1l0a1V3ZHRIMUtXeUl4cWxi?=
 =?utf-8?B?NzgxaUVsZ0NoZERYem9tSy9OdzFrVFNlU01ROUdoSllkSFMxZUo1ZXNFUFAw?=
 =?utf-8?Q?NfWFOKoamq9BZfVaG90FAvE52?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ccc836-be87-4d7f-e198-08dbe5024ba9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 11:10:22.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0P3eI86/9MF/OspO0AnJd83iyuY3MSMXyByIeG+Wh5r+E6+FRZCn5odXgaeeaY2XYfMzb0MCIrYogU85TZ9nXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5875
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



On 11/14/2023 9:41 AM, Yang Shi wrote:
> On Thu, Nov 9, 2023 at 5:57 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 11/10/2023 6:54 AM, Yang Shi wrote:
>>> On Thu, Nov 9, 2023 at 5:48 AM zhangpeng (AS) <zhangpeng362@huawei.com> wrote:
>>>>
>>>> Hi everyone,
>>>>
>>>> There is a performance issue that has been bothering us recently.
>>>> This problem can reproduce in the latest mainline version (Linux 6.6).
>>>>
>>>> We use mlockall(MCL_CURRENT | MCL_FUTURE) in the user mode process
>>>> to avoid performance problems caused by major fault.
>>>>
>>>> There is a stage in numa fault which will set pte as 0 in do_numa_page() :
>>>> ptep_modify_prot_start() will clear the vmf->pte, until
>>>> ptep_modify_prot_commit() assign a value to the vmf->pte.
>>>>
>>>> For the data segment of the user-mode program, the global variable area
>>>> is a private mapping. After the pagecache is loaded, the private
>>>> anonymous page is generated after the COW is triggered. Mlockall can
>>>> lock COW pages (anonymous pages), but the original file pages cannot
>>>> be locked and may be reclaimed. If the global variable (private anon page)
>>>> is accessed when vmf->pte is zero which is concurrently set by numa fault,
>>>> a file page fault will be triggered.
>>>>
>>>> At this time, the original private file page may have been reclaimed.
>>>> If the page cache is not available at this time, a major fault will be
>>>> triggered and the file will be read, causing additional overhead.
>>>>
>>>> Our problem scenario is as follows:
>>>>
>>>> task 1                      task 2
>>>> ------                      ------
>>>> /* scan global variables */
>>>> do_numa_page()
>>>>    spin_lock(vmf->ptl)
>>>>    ptep_modify_prot_start()
>>>>    /* set vmf->pte as null */
>>>>                              /* Access global variables */
>>>>                              handle_pte_fault()
>>>>                                /* no pte lock */
>>>>                                do_pte_missing()
>>>>                                  do_fault()
>>>>                                    do_read_fault()
>>>>    ptep_modify_prot_commit()
>>>>    /* ptep update done */
>>>>    pte_unmap_unlock(vmf->pte, vmf->ptl)
>>>>                                      do_fault_around()
>>>>                                      __do_fault()
>>>>                                        filemap_fault()
>>>>                                          /* page cache is not available
>>>>                                          and a major fault is triggered */
>>>>                                          do_sync_mmap_readahead()
>>>>                                          /* page_not_uptodate and goto
>>>>                                          out_retry. */
>>>>
>>>> Is there any way to avoid such a major fault?
>>>
>>> IMHO I don't think it is a bug. The man page quoted by Willy says "All
>>> mapped pages are guaranteed to be resident in RAM when the call
>>> returns successfully", but the later COW already made the file page
>>> unmapped, right? The PTE pointed to the COW'ed anon page.
>>> Hypothetically if we kept the file page mlocked and unmapped,
>>> munlock() would have not munlocked the file page at all, it would be
>>> mlocked in memory forever.
>> But in this case, even the COW page is mlocked. There is small window
>> that PTE is set to null in do_numa_page(). data segment access (it's to
>> COW page which has nothing to do with original page cache) happens in
>> this small window will trigger filemap_fault() to fault in original
>> page cache.
> 
> Yes, my point is this may not break the mlockall, but the potential
> optimization by avoiding the major fault may still stand.
Totally agree.

Regards
Yin, Fengwei

> 
>>
>> I had thought to do double check whether vmf->pte is NULL in do_read_fault().
>> But it's not reliable enough.
>>
>> Matthew's idea to use protnone to block both hardware accessing and
>> do_pte_missing() looks more promising to me.
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Peng
>>>>
