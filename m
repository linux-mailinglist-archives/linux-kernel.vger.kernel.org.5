Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E017A4FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjIRQxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjIRQxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:53:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38138E;
        Mon, 18 Sep 2023 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695056021; x=1726592021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Arh0xFyhMpIPMKEfLW0IaNhdt6vgk3R5DjClYb1NCC0=;
  b=b52U5tLNJNsX2+TpXcOzwRGeYV1l6IrBLE47I4DtcTqdQJ6m9qA6vBYV
   LfhvsHwyQAGM5mJvLDPgRxz9j2YmS/GiIfI9QkyLA2uy8EeEcL/Lm+zw/
   6mg8hJxl/p8GXWiBxqgm1XymyLGAe+xZ8tAiLIdmYkaAGCPUpyDcCMdDN
   uh4dqlFZzIGpJ5rupTCT/8c/iHqmsVb69c/0MGxgjFSj24D8QOGVP1wPK
   ty0N/7YvDdVV+MYnIDQbA3SaWAhaY0czi8Z8COiF6mRScybd9WqndQHWO
   BLrx1k6Bx1/NdxmDrIaOil/dRIb6h0PKJlkZEybgvzd+taTqwy6gsKbeC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="466063279"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="466063279"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="869624348"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="869624348"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 09:53:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:53:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:53:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 09:53:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 09:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USWUpn728BCu+IlOTVhmZ3CubkhxQZtWtCpu+CX9kijygnvgm5vmfZc3MNMKMUCNS9wJ/AHcPwapdXPBgT8jLbwUj8T+w5SoSBrNh3TtiLWG70x8ggCf1HLFmvJR5+GLKhSPJj/kzrcrWJ+q1hj30yZgIhPvgSs7edHdiLZahLxKYH1NfBqCXw4PYc8icAz+3wGtiBbk8DxXOH2xI8kyesyJJ2bNsmiE7jQZ3V84GksoAqGNFRtJip2YCy1oxgQbxoB3b9yrOGWj0yxtF7xBZDViiispFdNLSvJ3WrK4VemfJVOSsCHHmrRYO2zEbLC/f83kkjaJzRMX/S3n+l/mdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzscBDsCxSkHuCq//mLVkLYjW7CGYVFotS/QFBhh53U=;
 b=A64TjlupI5ZQuxGpulHXhqoo3nqBuburOfOyRUSo9W3y7ivS2l/D3AOdhPK0t0glT6w+p8VncEC9Tyw7nxXwjLV66lzSel+X6IVwbLWMv0EyqaZaefMlPY77SJdq+te5m3eqQZZ9IqQMv88dflNE/1OwqgCKxF2JMgRugv3VBNZttsvVSqBaQxEsmhuQn/xW9KJiB4xDhyl7GpHsZJztTkHMCbf0YpBWPe9hFlyPezBcBLgfcm8pGgWBCx28tEU0Uhdrc3dJ6hWxzX1lWgzlIxw/31OqAdfzh1R1KOZCxYItRYElMF++b5UkJ+GoWNMNpa0LrQvSCprEew65a69Bew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by IA0PR11MB7306.namprd11.prod.outlook.com (2603:10b6:208:438::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 18 Sep
 2023 16:53:37 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 16:53:37 +0000
Message-ID: <fa4730c3-6993-906a-1ebe-1b4faeda830e@intel.com>
Date:   Mon, 18 Sep 2023 09:53:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/10] IFS support for GNR and SRF
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <ec68c553-1a12-6e33-b732-fd51d89cd439@redhat.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <ec68c553-1a12-6e33-b732-fd51d89cd439@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|IA0PR11MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c254fb-e73b-4166-3253-08dbb867cda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjLd2kneR9eS2EPNTaGWBOo3mx5dJDxWg2r7beOSbIP+3Z1+kkWsH6HOAgF6YMxtaqpOMgW6qLkJZGpEAFOqDT7mbLSFK03xR6Af3YdTtUp2BIuAYHDSrxsDVuP71ALzduMNJ61K9Be4MJMmnRX5eUlAn3y9QbU479Xm18PGB5SEghUQ8pRErhr4JMZe5PHpCh0maFtA+W4oFDxQM7ksQVVJPEtyHd5E5z0NfEcR1EL2bc9r0InrwuQ5p9WdPhO7RbSjRRz+PdoSZw3ykkQLt+CZYVLeZNR7FS2L4FptiOuYSrW6V3dJlz7Avk2D8x5/DrV8EXw9zASAwAnp5qbjcr5HHiz/WWuPZrSrbEvdZ0bRoclMY2pAGkFy2l2WeT4u8FvZIzyCAj1pQK3VAwhbz0AgBPA7PaRqppv5Tld8hqGhqzMf0RH6m/k/nIpf9CQsmLFY/8WBD3/e0MH6tI4+rfAljdudXwaJ3MFpOSor8f2QY++/9u6Me1mjI8mdrxG4KaWIsuSq/a1p5HbrmboSn+NIjJtVbCORWsjd+0Xak8riD1ygjDWY8dlHUHhzVFnGI7B8Iq9gVVXBQCVMPjXxqrU/UZgpwJ091OVSJCTpt0wmv+35uyFQqL0a15xJ5Nh3qZR2wDiEQPLSIoAtrYByaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199024)(1800799009)(186009)(6486002)(5660300002)(6506007)(53546011)(86362001)(316002)(6512007)(66946007)(38100700002)(41300700001)(66556008)(66476007)(31686004)(6666004)(478600001)(82960400001)(8936002)(2616005)(8676002)(26005)(2906002)(31696002)(36756003)(4326008)(83380400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnZUOWkveHdzL09najNST0tNSlMvcXZ4eUpxY2l1OHNKKzhRR2hiYzVCWjU5?=
 =?utf-8?B?Q0dQdlB2TE90Zm5KdjBIZHNSYS96NGpxOXB2QTdUU01TQlJpOUVkaWJxbTBv?=
 =?utf-8?B?WEJFanc1U3pRdXRZRzdveTNEMnV2LzFmV0lwVE1nSTFnVjNIb2FNZmJmenJ3?=
 =?utf-8?B?YnZ4blFBbW5OdHJOWFJIUWJSVWJFV2tuR3ZycG43R2tpeDNwdnRaVUM4Qi82?=
 =?utf-8?B?NkxGMGdlTDZvNjNSQ2NjbHJIZHU5OVlYWUVMNDFXUDBYSklJSFhLd3FZb3Ra?=
 =?utf-8?B?SS95RjM2SHRVRFQ0VkQ2ME9OV1NJZW1rcnYyMU0vYXlJS3N6NHMxUW9kck93?=
 =?utf-8?B?d254cFJ0M3J6cldCYkN1bHRBeGE5SjhTK2s0WTNhcUNKQ3B1VkN6Z3RXWVNl?=
 =?utf-8?B?eS9DVE9LU3lCQW5KS2I2WXY0OWM2aUZOZUltTExIenVlWTBIdUJmMTJiMC9G?=
 =?utf-8?B?TWU3NEowM2tmYzgrK3QvNmJqOHpnMFN2ZGhpVkRhQnZNRTU2RS9tSmhLWi9z?=
 =?utf-8?B?Y2o4Sk10ZllpUUhib1IyTFFWN09CSE5vSUFCQjhISmpqUEJPc1dYeHBKdkVy?=
 =?utf-8?B?QTBjbC9aT2hwa3kyK2hZU3I4TDdUemJiaCtVaWxpbG11cDFqU3lseDdYVmdq?=
 =?utf-8?B?Q3VvVlZYSUlOc2lBMlo3VnRGeFU4UTNNQjY0THJoRTN5RlN1QnhjYkZvekl5?=
 =?utf-8?B?K2ZnU0F1eTBZV0JJL1BZeDVmWitjZTNBdk84UjlCQTVveUxSQzkxbmZCemdZ?=
 =?utf-8?B?Y1QveGhXTGtiWGJydkE2UjE2TUk5K2tBd1NVUFY3eDJsQ3J0TVI2TlhjbTFT?=
 =?utf-8?B?TVhSRGFaOG04cldTb2ZjWEIwMU1WTUpkS0haKzFkbjQzblRlM3VINE1VcEZU?=
 =?utf-8?B?YkpydEFFNW5OOWROcEhoNWVZUmI4QlE0a0V2anBHdUhubUZ4dUpma1pqUjVD?=
 =?utf-8?B?MU5ObTc1dGU0TmVvVm0rNFF3YTZsNit5RVFqaGRCMHJYNGRVQkxFRSt5VytJ?=
 =?utf-8?B?UG5TWVV3cFNsS2RxemsweTBPbVVxWndCQTRPRUhLd3hEeGRpT0Q1WkhOZjMw?=
 =?utf-8?B?R2xqQys4NStBMHU0OEFIOFpEZHd1bFJlajJiOVNtYUdrUExua3dHUlJZNUR5?=
 =?utf-8?B?b2dDQzlUdzRLMU81enRBWVl3Nklvc1dtWXNMdG42R2FJY04yb1JOZlhETlph?=
 =?utf-8?B?ZmlJVUxpREpiRTZTWWwzWlc5N1hKWVE2RzRUaFRHblVBemdVQ2RjMUgyQkFV?=
 =?utf-8?B?cmJvVUNyYUc5SDBJMG1ac3NpQ3VSRm1meERkdWcvTGtkN3BrWStGNENYSklB?=
 =?utf-8?B?azhRQmdNN2hwcUxKUHd5cGFSYWNreDZGa3d0YWljNUtiVkdFeUNtSjZ3bXho?=
 =?utf-8?B?S05DT0FJOVRCeFZoQ2dMOThDUVc1cWZIWlJIaE9TUmNKYWFHclRMTTJjQ3Iy?=
 =?utf-8?B?QXpIUXRLL25EZE1PUDNTL3lSSVo4T3E1U290L3N5c3dnVmFvTURGdHV1YkdG?=
 =?utf-8?B?cGxXT3dIbXFBWldKTnhoQ2F6c3hJd2FiWFU2c2RSMVBoUkdQNUJBRE9YanBk?=
 =?utf-8?B?dDRoSGZON0V3MnpzZmQwRG8xaWxIbUJabzRKOUoyTTBhOUh2VDMrYWltVFpU?=
 =?utf-8?B?clpGZEw0ZC8vYjJKdC9MZ25oeWF5TmMzMXN3SWdCMW5ZQkFMRnBYWWlaMVp6?=
 =?utf-8?B?aGxjc2N4Rml3VzBhUWZSRFBWQmYwTVAxMVpsOHhXbnRtMkY4c0tHb1NxNEJW?=
 =?utf-8?B?ZnliV2pFNXdpVm5CdlFWRDJ0WHA3TjVVVzVDblhHR3QvZzVHSFNVanN4UDRT?=
 =?utf-8?B?TUxvU3pyRkg1QVZHek8rZTB1eTVvY1dra0o0K0VTUHNUVXRhK0ZNL0orTUd0?=
 =?utf-8?B?M2RUNUpNa3ZQdm5UUkg2ZnF0ZHlpSjJaaHdiY2RGUHR1L3FRWllJazdubm8r?=
 =?utf-8?B?VXl1QlFFUUZZa2ZKQUVPT3pNNVpDOWNoMWtsQm40RHVTTmp6ZGoya2RvRXM0?=
 =?utf-8?B?Y0Q2dGgzSGVUaG5GWnUzRzkxeFJWOGt4UlRTM2UxRE1PdWJLaWxwK0Z2REdT?=
 =?utf-8?B?Qk45bzJRWnRyaUZwUFVUZSthNFpoT3h1eiswMytKTFFsNTBhQld6V041OHV2?=
 =?utf-8?B?enBIcURPU1dadGNQRm9JWFU0aFhRV0NqbGdtbjBzRjROcjBnMlZmcE1mamhP?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c254fb-e73b-4166-3253-08dbb867cda6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:53:37.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVNUkFMxGjjmnF0Q5WDcQMtp9ebjdFOgXhQ6y4IFZHlh393aXxrH4vy4fhsmYcraTUOGfXS750uT27jku7Scww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7306
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



On 9/18/2023 5:32 AM, Hans de Goede wrote:
> Hi Jithu,
> 
> On 9/13/23 20:33, Jithu Joseph wrote:
>> This series adds IFS support for newer CPUs like Granite Rapids(GNR)
>> and Sierra Forest(SRF).
>>
>> There are changes in the IFS image loading and test flow to support
>> these new CPUs.
>>
>> Note to reviewers:
>>  - patch 01/10 adds a bit definition to arch/x86/.../msr-index.h,
>>   hence x86 maintainers are cc-d.
>>  - patch 05/10 modifies an existing tracepoint, cc Steven Rostedt
>>  - Rest are localized to IFS driver
>>
>> Jithu Joseph (10):
>>   platform/x86/intel/ifs: Store IFS generation number
>>   platform/x86/intel/ifs: Refactor image loading code
>>   platform/x86/intel/ifs: Image loading for new generations
>>   platform/x86/intel/ifs: Scan test for new generations
>>   trace: platform/x86/intel/ifs: Modify scan trace
>>   platform/x86/intel/ifs: Validate image size
>>   platform/x86/intel/ifs: Metadata validation for start_chunk
>>   platform/x86/intel/ifs: Add new CPU support
>>   platform/x86/intel/ifs: Add new error code
>>   platform/x86/intel/ifs: ARRAY BIST for Sierra Forest
>>
>>  arch/x86/include/asm/msr-index.h         |   2 +
>>  drivers/platform/x86/intel/ifs/ifs.h     |  47 +++++++
>>  include/trace/events/intel_ifs.h         |  16 +--
>>  drivers/platform/x86/intel/ifs/core.c    |  14 +-
>>  drivers/platform/x86/intel/ifs/load.c    | 159 +++++++++++++++++++++--
>>  drivers/platform/x86/intel/ifs/runtest.c |  68 +++++++++-
>>  6 files changed, 273 insertions(+), 33 deletions(-)
>>
>>
>> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> 
> Thank you for the patch series, please submit a new version addressing
> the various review-remarks.
> 

Will do ... Thanks

Jithu
