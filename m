Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E747B0225
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjI0Kp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjI0KpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:45:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC11AC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695811520; x=1727347520;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0f8oNlT8V0OFzjr1ejHkD63sPZUe3kh3qkh2X/1x3ds=;
  b=k1f+/2SMRdbbWS6LY8EN/BhHYVFsZIrPbiRIjzwGf4+LPtY997yRMyv0
   6sHXNKYbaBTKGncDYhur5Q6mdqPJ0/ehwrFvZDqluqRf65Ff/Nf4EdXSd
   Em/b/tRDDNkA34U4IgpDYRkkCYdT0mpLd5lirKOEBOW3TqRFCM7AXmQbb
   irOVv+NTEQXQqS7sdeiyO2ckMzZuC9enBg3Krhzm8XFfSC4NJKUUPpsyI
   obonDRp8Kj2ZRqeMTGkz0Vp4gCdFPFrIsYXF29xLpipXLag23xYIu1s4m
   FIRnKWZ+ehwlTrJWgd66EGJSRlSYpPQQxiyPQO+dQWqTPLmn4MzUVf9yu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445927973"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="445927973"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 03:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="749159749"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="749159749"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 03:44:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:44:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:44:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 03:44:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 03:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN+iHLToetuUO0IFaTPwgFp7ED00kGGEweRkTpxjm8NgdemwHkGHlOVO2D4adKyrNTr9Wxp/yx2gK3EdEafYOiirt73r62NfewdZCdjGa0UaaXSxx07EGGO5F76hzEDq/i+LGh+qqrpQk9yd1rm3DA519GSNDFdLVlDt+Wzo9Wu8zVjn+KZNcJ516wG/tU0wBJq0H2v9+zmJ52kFWPC0m5b5I4RzRvGa06x5R/6puSuV6kAWdJ/VB5Y9//cmxHxKRaMUNsVtBYbquTNChOd1DBHAI3jJnYZdJy8ycFqWA1MhA6c3lzKsF4xuZgb/4+FQaZ35506MevaVeX40MSflUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK4JtNNWp2XOEYFsoIEjIgfZrSx19OBhtKskOaJmPBw=;
 b=VrvdUXg4BSAmzYv/pZqkbqQqMwdPxMnnRyJiMqNClXUhPBdXS6jZa/C+G0DcYdEbfVaAr80yvQuqbnm7zqEc0w2mDoM10JiGnxIimWKmUtQZJ1Z5MHC5F50WIHpNSpcrp3z5dn6ksfEKA2L+e+Gin5IMcmQhdlkRdtRFrSNBeLVl7k/Vj2xCA0f4KQWPienfQONSvL/2j6Uh2fjJiwtp3kNTgZsWYWB68z3MH5PdzCluXl/fVZGFeNDGfjK9UcWK1i5iOcAsBZzm4nyn7aqS1THnhdI49LhzGv1/SlMnlNhj9gkX1YhkX/j3okQuZrIER+oBtq67KyXoxu6WuF6lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 10:44:48 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342%4]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 10:44:48 +0000
Date:   Wed, 27 Sep 2023 12:44:39 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Peter Newman <peternewman@google.com>
CC:     <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <fenghua.yu@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <eranian@google.com>, <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel
 CAT
Message-ID: <xn63zx7zfjszkp2nvpiemrxnva54dse3wed7apvadgibr23fqq@jodz2loxarsu>
References: <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
 <20230922141441.3353077-1-peternewman@google.com>
 <xnjmmsj5pjskbqeynor2ztha5dmkhxa44j764ohtjhtywy7idb@soobjiql4liy>
 <CALPaoCgm8ed0p3Nw53d=Hgs0WnunkRUwAriyuKqu6+5Ty-QVTw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCgm8ed0p3Nw53d=Hgs0WnunkRUwAriyuKqu6+5Ty-QVTw@mail.gmail.com>
X-ClientProxiedBy: BE1P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::7) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f4f6bd-53fe-419a-b5c6-08dbbf46c4f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Unyh3vm8SKt4EQMe71MqSPkSzNcQsCjCzbJfnqI8fBdusK7FPJriXZbQwgrTP/G0+zvNnTcC1lrpZtmEz5nWauZu210JFCAyf3G25YpvFS/aEQ7JaTtjKPROyGoe+7J1UaXpQzvZ9BWbExOLzsayseXG1Y8+ePLu8946+PU1iS1AO+ptUOa/f2glbaNSIJuBU9n1tWu3JKTEh2jEyDIXpETr4I+n5SPqYqJrv5IHa5AFc+e+zKM4SvZ8T9y+GXJyuqAGDv2UUBjyRI0EcLb1U1BAWYqEWtVw7GbPxUg2Nb9XGZ38ERQYnEV586+pWDyv4IPf179I2xQ+vPojGQ1LnhXiQd0E0hcaaYtDFREL6FGZ8zXVmit/17cN6WKPpI1VGOYPPzHuL4IZx5DTAoNWHx86cmQzSFOCU12jFMkjBIkAmrOK/tX6UpYsyU8YHPnDPlRF8b00n4ZPZo2izp8vQRcqILvD7jykoXRCG+XmYRS2CrwGT+QEaKKPMDdBph6apR+IWHz751Yoie/TpV+QxhKCyaAWvM4U03l9zAVx+y1AFuhpE71/gzryvuQMGL5I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(82960400001)(6666004)(83380400001)(6506007)(38100700002)(9686003)(66476007)(6512007)(66946007)(53546011)(26005)(5660300002)(66574015)(41300700001)(66556008)(8936002)(8676002)(316002)(478600001)(4326008)(6486002)(2906002)(6916009)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFNKV3A1R0VEaTUzZWJ6ZEdzYUVhbmZkbXlFeVppZlQrM28zMWVmR2tIeFJP?=
 =?utf-8?B?QTM1UHRwUEQydmlzbVhzME82TDJDR2hMMXlhbXhiaWs2VW5QOTVEcDdqRjZO?=
 =?utf-8?B?S1BIU3VFRjgyMWdiZE5aUEl6N29oQ0pPVlR6WHo1UzBJUDFtTTV0Y3YzM2hw?=
 =?utf-8?B?K3hGWkp2V0RrcVB2WDBXakRONU5YZ2h6ZDJrc1V3bGlsc1ZZNmtjTktEOWdi?=
 =?utf-8?B?cFg0WU1keUJvaCtZSzc0K3Y1WEFQYzl3R0VLcXlHTkcxQTRYa3lndG8raVhH?=
 =?utf-8?B?QXl1Zy95NU5xcHJ1N2thUGR0ajhQMlJ3dUZLdDAvTHZaLzQ3Z3d2SGh3alZv?=
 =?utf-8?B?MERYY254bEJudWk3UE40NkpOTUo5TmdZYTN6MEVlMGxTZzV0cTcwYWJIcnY1?=
 =?utf-8?B?dEc3dmwxc0JHNnVBditmRlJldjhTNmFLdWRFZVBZcDNwRWdLYkNhSTI2N0Z1?=
 =?utf-8?B?VmV6cFZ2NGE5OFlWaGtvNklRb05TNmNXR21Obkd1eEpXZDVBMFVaUDMyQjQ1?=
 =?utf-8?B?Rm9WOGhXMnluTFBPR245cmRvSzNBY29zM2JmbVY0ZzFvRWRDejFVQ0RnbkpI?=
 =?utf-8?B?NTNncDNyS0JVVDlWRnB5em03aXNpam5EYkdoSStVY2dqa3QyOFRMZjdlcHov?=
 =?utf-8?B?QUFwWFpSa1lrd0hLb0ZnQTk5a2hwVFYzWmNjeEYraEFUbGRiTzB2ekhmVGxq?=
 =?utf-8?B?bEZObmhtNUpYVDJsaG9oQkZUODUzTVNSWlJTM3RVYzFOR2VZd3F1a0dnbzJ5?=
 =?utf-8?B?Zm5uSmZYRHVOdzFzUytuTVBlZWNjNlBxajk2L00xa1hVRnptd3lOcEJHWExQ?=
 =?utf-8?B?NlFycFhCZXN1MjZwOEYzT2swMTdBOE1GdFFieVhQaERXWkZIcFl0MmV5eHJl?=
 =?utf-8?B?Y3JYME9XOHl4VTk4Q0QxYlpNdjZ5ZGNVVjBKMTFab0NqR1NaVFRDUTNnT0xJ?=
 =?utf-8?B?YW9KN3k4dlF2TFllY3BCMjgya3B5U3Vuc0ppbklMRnBLRTlvLzBoeVAvZ05x?=
 =?utf-8?B?OGw5VGxObzJSUHlRajFQV2szblhQd2RlWWxVUURXanRrd1gvZ2JsSGdhUExO?=
 =?utf-8?B?NFh4amhvNDBuV0V1YVZDMk1YbGxZQXl3TUxwVW9kenJ6K1c0RlAxMk9uM1dM?=
 =?utf-8?B?SFhKTlJJYVlTQi9mOUQ4WkpMb1RoMDBMM3Vwd2FVRm1NUU9xMHBjMmhFQmUr?=
 =?utf-8?B?cmp1cW41cFI1Q2Jvd0hjZHVEZGpXV1FmS25VR3l6a1Q0eG1raGQxcjBScFVZ?=
 =?utf-8?B?K25teTZxcFY5YjBwcGFPTitmRXRvdElJVjdLWFJPYlBjN3hsYmUxNDlCaXRw?=
 =?utf-8?B?SithcG8yOTJJTHZEOWFCN3hpd29aSWdHN3FESVVpMU1yRDdRZk1HTEdnQWFU?=
 =?utf-8?B?MmJKRWwzbFJGUjdlb0lFQ3VlbVR5aCttYXRCOGtVYTNlM3k2TTlhakd1WWFn?=
 =?utf-8?B?RmlWY2IzTVlUZCt1UUFtdnZyU01IRkd4UHNTSDF3dXYweDdGOUtCOE5ZT2E1?=
 =?utf-8?B?QzVQOENZdStFTG5MbFZuRjlRenY5d2RyQU5xNTVScTg5WFNQczlmQ2pnZHV0?=
 =?utf-8?B?R1krbnNwdTNjVzNNQmVUNHJ3QmMzYk5hcjlzTk16ZFdMWGhmZmZZQytJempR?=
 =?utf-8?B?YTVNYS9ONGY5VzdsaWtJU3ErVEQ2UE1zbTRzUzFIT29zS2hrTlFVZXJHV0N4?=
 =?utf-8?B?T2grdjBsSHYxRzBwaFkxT2QrSGtNMWZCNS9LaVZrRWhGd1FLaTlMc0tHak00?=
 =?utf-8?B?TTR2M2Q5QkpHelg4YjZXa2V6dEpCajdYcWJOeCtKMzFwQlV6ZDRUWEdJdlZ6?=
 =?utf-8?B?NjR2NjZGaGptdWlDL1NXbHVpeHhWcE8rVWRPSDFQSllRcFhlSUNyYUhUWHFF?=
 =?utf-8?B?ZFI3dWZ5NFpYdStkRGZSTFFKRzUyVGRWSnp5OXZLZmpqNG02YytzV3RiRFdK?=
 =?utf-8?B?VnlPWHZ5RXpxQXkxTEFtVExLc1MxdEVNVzhXT0dpVmJCeDdvVFh5QVhLMENO?=
 =?utf-8?B?Rm9nUHdNQ2J0QzRNZkgxRHhtWVBMVVRXTng2VVQycmlZRmg5ZHVKTlNSemll?=
 =?utf-8?B?aXk4NXZwekt2NDJiNDltakcwbzR0VUdEZkhvaWVsOEc4MWw2bjltN0F3Z0sv?=
 =?utf-8?B?QVg1QWtQWE9EYlV6ZElobHFkWFdVWmdmd2ZGOFc1eS93QWVXTHpsOEhvNU45?=
 =?utf-8?Q?jgGABPw2sr++QJ6B67yafTw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f4f6bd-53fe-419a-b5c6-08dbbf46c4f3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 10:44:47.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTJQRpf8lCM+WstarHwK/B3Pw2pMe2RtmDqM/NxPZqnk6L+KDx04gfWK5G+77xBKbM0rJmH5on+cDTv4tcbqO8goT4THIRghxNm3MWPS4QU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-27 at 12:08:33 +0200, Peter Newman wrote:
>On Wed, Sep 27, 2023 at 11:20 AM Maciej Wieczór-Retman
><maciej.wieczor-retman@intel.com> wrote:
>> On 2023-09-22 at 16:14:41 +0200, Peter Newman wrote:
>> >On Fri, Sep 22, 2023 at 10:48:23AM +0200, Maciej Wieczor-Retman wrote:
>> >> -    cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
>> >> +    cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
>> >>      hw_res->num_closid = edx.split.cos_max + 1;
>> >>      r->cache.cbm_len = eax.split.cbm_len + 1;
>> >>      r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>> >>      r->cache.shareable_bits = ebx & r->default_ctrl;
>> >>      r->data_width = (r->cache.cbm_len + 3) / 4;
>> >> +    if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>> >> +            r->cache.arch_has_sparse_bitmaps = ecx.split.noncont;
>> >
>> >This seems to be called after the clearing of arch_has_sparse_bitmaps in
>> >cache_alloc_hsw_probe(). If we can't make use of the CPUID bit on Haswell,
>> >is it safe to use its value here?
>>
>> I believe the calls go like this for a haswell system:
>> resctrl_late_init() -> check_quirks() -> __check_quirks_intel() ->
>> -> cache_alloc_hsw_probe()
>>
>> There this line is executed:
>>         rdt_alloc_capable = true;
>> where rdt_alloc_capable is global in the file scope.
>>
>> Then later in:
>> resctrl_late_init() -> get_rdt_resources() -> get_rdt_alloc_resources()
>>
>> this is executed at the function beginning:
>>         if (rdt_alloc_capable)
>>                 return true;
>>
>> So the rest of the get_rdt_alloc_resources() is skipped and calls to
>> rdt_get_cache_alloc_cfg() never get executed.
>
>Yuck. But it works I guess.
>
>The series looks fine to me.
>
>Reviewed-by: Peter Newman <peternewman@google.com>
>
>I applied the series and was able to confirm the behavior was still
>correct for contiguous-bitmap Intel hardware and that sprase_bitmaps
>is true on AMD and continues to work as expected.
>
>Tested-by: Peter Newman <peternewman@google.com>
>
>I'm not sure if I have access to any Intel hardware with
>non-contiguous bitmaps right now. Are you able to say where that would
>be implemented?

Thanks for testing!

Writing non-contiguous bitmasks is supported starting from the upcoming
GNR microarchitecture forward.

That's also why the new CPUID bit meaning is in the ISA pdf and not in
the SDM one currently.

-- 
Kind regards
Maciej Wieczór-Retman
