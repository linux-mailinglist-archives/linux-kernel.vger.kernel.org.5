Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FE87DC1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjJ3VTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJ3VTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:19:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED030E4;
        Mon, 30 Oct 2023 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698700756; x=1730236756;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p03/fy3vsQHIKVWaOGDCtoriLiDArYAJmIkdCgrirc0=;
  b=MbZwuoUL/CYRyH1S+Ceg1DGmYUFDG/FMmyrsGg6JozgDdYYn2nwAPcMg
   yvPjMplFTui5XAxEee3NTD3CMDqqJkmajOKaEGhyUQbZ6WfOmHJCOb/Ms
   pN1YIe0oYt5UhbKWxGCE7DTK4q0hmFIZJD7noHqC+P5gCyOgBHcBCbkZJ
   /d1gYEPj7sgLVj/dYKcvMpsIj9qvOKM/LW4t5Uy9eutRSG3cPs+D4LL6n
   kCCfM4os53jhFb8dO5OSaC9Bcsoxxeh8ker3X+rM3wtXnCDwobPlgDVuB
   JiAlxlgmjoz1LqprrlmZavXe015V1thhlG7lO4QDg9ZztNg1Q8Pikkzc0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="368373299"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="368373299"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="884005743"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="884005743"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:19:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:19:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:19:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:19:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJs6bEVADE3RjkgGZVRqjWbsv3f5ky6Hf1XovvIBH4kB/nxtp/b3c/X739muFUtrfhu6bykehEQ45givtKqQosXvOG9n+tOl0n7ZG4EUNvSx2V+8SOIB4w5EGgYey1BgsqtLtWaLxXweX2+AJk3K39cqSbg41sCjyRAHL4vEfZnfzEWAW8eD8AOpJiJpAh2H+bWIObagj+V7f6MNLg0n7RXwHjeiX5gWk0fbOgILE1aVErWL0/Yotmf2gYNbcu0oxyBt2D5Ctt0PJ9f+oXRVDEv5jmu2DNxsD8//aOeR71ETMIwVU5sFFy4VhnZqjeHSz8SJ9FGnRnkgRxcWRGyC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQVHjiU8yvfnekQDEdlZkq4OnrtpHg3ZQnM1aCDWt/Q=;
 b=DV5FN7E/uX7r8hyoCMl31VcI7+2n21+i+k3sEObaJ07XxCV01Ij+/QCkLZEvsN8Ryjfc+qwXhoMbD0LJ0Oh71dEsFXObBlAkAT46FNr+EMt0LJ/S/rjzn3joWyaTdmN8SDB6uz4mUg04C9OiAM72irgs3v7mGYyDc/EtfBi8k7mz9EckOmmu5A3iQ6qep5SRvhRD3jc3E5gXtyEw7SDIVgK1YEdm6dqYgKbOvJSUcSiT9f3Tw984z4/XH14miZ8EU1Unaz0/1EmtdM5K/PGhNNWkN12RByTyoFzSbwhx8CGjjqJmct0CFoE2A4taKJBu2poK7/i/zVUjOzOHr5m5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 21:19:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:19:12 +0000
Message-ID: <b4053448-8ea7-47e5-be6a-d206f7d7a268@intel.com>
Date:   Mon, 30 Oct 2023 14:19:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/8] x86/resctrl: Prepare to split rdt_domain structure
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231003213043.13565-1-tony.luck@intel.com>
 <20231020213100.123598-1-tony.luck@intel.com>
 <20231020213100.123598-3-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231020213100.123598-3-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0367.namprd04.prod.outlook.com
 (2603:10b6:303:81::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 067da550-91c5-411e-c853-08dbd98ddcb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfVuDQS/x1SMutnN26qSHZ7sAwe+cIQ+oOLYCfKl79ZMSeqUVyLugqOQtoF44qHD5Fl8qRMvD0j4PxFN+/4zgomdYjDsrXhXBpRDGtgDuXj8wuRo6eDqceYH32JBPem3+ReTI1hPTgaZr+3zUc3T2bytHk2KSKWXUjSFmDsiWxA3lpi5S92RUNhush1/Z6ZhQYY5kSlE4RvF00Vxodyqgr/a37VUaDiTdofDK5ZNrP4bRhv6C/clWUZAtOdDD4mGe7LYZyvETwLH9fsEqmiX7NjML29wBCIWzO7NDbVMFx6ToB3jnp4TabX1pc99h+p1Nl9bYH9P425+zIWemCULo0AlXqY3uUE2/xTszb+e20XGe2zjzXdBDrhj/j+qg5KISmdNc6WyKCLu48J1DIFpnpptFMPuK/6bAAARTRUYBngbyVwltOHJTODss7ChiQCHCoiArZNZOHp55D7awVih3g+apVOEQavAMppv80UcJJsO4UwhsYV/pWntsp0dkMVv8uL86BfIF1fal6eMxUgITISf1PFFVcVo4p+22XEG8gcuryamC6AqtcUVNE5ZEiPtD+MGV8jBu8MKYX+KRXV9AXxFho85wG+Bb3Uhltzsj6/rhxpsYKEgkC84JkQbhh5NyqPgF1GvHalsYbWCikp3qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(2616005)(26005)(6512007)(53546011)(82960400001)(31696002)(36756003)(86362001)(38100700002)(7416002)(2906002)(5660300002)(478600001)(6506007)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(54906003)(44832011)(6486002)(41300700001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZlNFVVU0dOKzBBMnNpc3dSenhWWi9EdGZHdHFyUkxRVzB1MGwrZFFIdXd0?=
 =?utf-8?B?RnYyUGlPZ2Myenc1SDRQV21SLzIwZkxpSGxzS2QxbFh5V0J0TUtEVmtGQmx5?=
 =?utf-8?B?VWtvOTh1aVg2N3RYR2VJSGd6RXVnUFhocy9IUTduS3dQVGV3QWpnMXl2cVNk?=
 =?utf-8?B?YTFtOGVBeUhMSG9xWC9JcDFwSHpxd3V6SVpxc2hHVVR5QmpPNVpNRUdqQTdj?=
 =?utf-8?B?ell5Mnd4OVREQ0k2VHh2UlNPQm4xSVdIUkp5MlFTYjFQcHVPc09VMmJqSXBm?=
 =?utf-8?B?c3lmU2JlZmpjY2hSMzdGN05vaHB0c29nVjhsM3dGc0VRTUNZZVExd0Zac0RB?=
 =?utf-8?B?SjQyTkc3Mi9GNUJDSDRLY0RPTlhudlFKZUtNUk9DRy9VbDl2dCtLYnlBTk4v?=
 =?utf-8?B?VmxVWVRod2llU2cyN3l4dkE0U3JWM1hVV0kyalE3RmRwYTJsQzJxTHAyUS91?=
 =?utf-8?B?OUM0V2lraW9HNHQwSXVpTjFwdXNlQkpremw2M0RMN3VqTTlIL0UyclZuZ0Vi?=
 =?utf-8?B?NHBPWnRiWHlIUFZBVDJqYjF5K2F1MzVnQUlmUm94YjVZZGJYU05hMmJYd2RH?=
 =?utf-8?B?ZVQxcDl3eWlTQzFlcm80enF0SE5vZ0ZuTW5aMFIydlIwRFVGZlNzTDFNVjFv?=
 =?utf-8?B?c3ZNSzJRRDF2aXMva25ERXFqRC9teUFEM20rM2k1eHh0ZnRmWG1TZHVTbUhD?=
 =?utf-8?B?cml4QjR5dDE4RUtneTJiQitEUHRPNEN1SW16UUJnN05LMWovbDViM1FiWCti?=
 =?utf-8?B?MWE0Ulo4YWd1VzV5NENLbGtaZGt4U3dzUlpISHJCOSt3bU80M1JjaG1QTTA5?=
 =?utf-8?B?eEU5ajdxN2ZGSW9EK2FaWFVEejdqREw1aVN1Q2ZtVEhTZG83Q2VSQUd0Vm5V?=
 =?utf-8?B?Y2FlMXA1UFVSVUpabGk3eEdtVENLOFd1RXV6cmFYeTFmVTlhK2JtbFpDZGR1?=
 =?utf-8?B?TE5aU0hVWThWaWhyYW9vY1IvUDNzZHN5Yy9NamVmOVovVnhhd2dQTWRHcFJZ?=
 =?utf-8?B?bi94Q2dIKzlCdkV5L2orYktxNm01RnJIYU5qUTlMSkxOblIvSkc4KytUNHBQ?=
 =?utf-8?B?Sng2Ykd4ZFJFQUxyNC8vY2FYenRHYzQ0VFhvQm8vMC9yUEFnd2pyOEs0RCtB?=
 =?utf-8?B?VmZEZnl5azFocHRtTWFtSDgvSVBTWjRPVm1Ndk5Wdy8wYUlnc01EK3M0c094?=
 =?utf-8?B?SktOOFNkT0lka29PMDJGUEEyQ3crbmhCNU80eTVESnVsYU03NlI4YTJKT1Zn?=
 =?utf-8?B?MnZIdXdLa0tmY3NOS21OV0laa2NIV3V0M05oQUJQaTZjQ3RxSmVhcWxxaWxh?=
 =?utf-8?B?ajVMbkc4ZkdOczlyWmlWZUN4cjh0M0NtRHhXQjFDaDFLZGxXcEptQjJJMjVz?=
 =?utf-8?B?blYrY2lZUFlndU43Rmh1V1BSajRZUGpJOVk4M1NkSFFBempwSHlxOW00UVly?=
 =?utf-8?B?cVRxWlVMMkZYbWNOVEp4azdiSjFCZ2xsT012K3BCdVQ5QVFwSHB5cnhtaUdO?=
 =?utf-8?B?SjJhZHlHUFNuL3l0L2c3M1pzU3dnRlRXRnUwNVVJQldQUG5oT05nWUNyTzdI?=
 =?utf-8?B?eVJBMHgwUmI3czkwT1JydzhJdjZjT21mdUNIVlU4NVphS2tsaFVZZmc2L3Jp?=
 =?utf-8?B?cDNVQnlIcFNzMkVJM3NvcGIwNUVSTHpXVERFSVNQYngzdXZMUktzOWw5b2hN?=
 =?utf-8?B?amJ5OC8vaVY2dU52N09yUUpscFFTREpmVXZsTVVuTWkxU2VxRUJFVjVGNFht?=
 =?utf-8?B?VXdJMGVhVSt5WGZxN0tqUlp2TnRMdVQzRU9HVUhFL003WXF6eHV3WnN2VDZG?=
 =?utf-8?B?M3ZiRXVUblNjWXJVWG5hUDJLWFZ3cE5nY3lJMDAxdStuNVdtSjRpbjhiRmNT?=
 =?utf-8?B?RnZFdFovSDBnNzl1N0g2S2NrcTllTzgwUWVWUEYrUGJ5Q3cyUXJpMXFJM2wy?=
 =?utf-8?B?SGIwTFFPNTJFMVFXdkppWStCTzBidkJ3SGJqOXhLaUpYa2E5Wms1Z3FkUmxy?=
 =?utf-8?B?TUUrS1hkS1NacSs0a2xTQVVuVFU1cXI1amtKVHJGK01hYU5WZDdHK1NWd2x1?=
 =?utf-8?B?QmFLS3c0Y01TR1BMTjhNcTg2WEJBVmNZSDZncjdoZkNWVDZZQm10ZGYxdXVV?=
 =?utf-8?B?RWpEQTZMTk9mOWR2L2hLWC9LSDJZRnYrV2VPOWZzNGZhOHFMb2ZRNFRjSVpo?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 067da550-91c5-411e-c853-08dbd98ddcb3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:19:12.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PW80HOhnMFnEKjdn2Vqa2SmHBdvzeOMCPEWKldJq1wlXVCYs2gsS6rVeSu/H1ntbPIgvtOjE4folFo+h9AAfHCPb8wRJtAg77CuIo/vJPl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/20/2023 2:30 PM, Tony Luck wrote:
> The rdt_domain structure is used for both control and monitor features.
> It is about to be split into separate structures for these two usages
> because the scope for control and monitoring features for a resource
> will be different for future resources.
> 
> To allow for common code that scans a list of domains looking for a
> specific domain id, move the "list" and "id" fields into their own
> structure within the rdt_domain structure.

The motivation for this split is not clear to me. Here the motivation
is to support the code that needs to traverse both lists. Later (patch #4)
the motivation is that what remains should be "just the fields required for
control and monitoring respectively". The comment "common header for different
domain types" also makes me think this new structure should contain all
common members?
The reason why the motivation needs to be clear in this regard is because
there is a common field, cpu_mask, that did not make it into the header.
Should it?

> Add a "type" field to the header to be used later so that callers looking
> up a domain can be assured that they found one of the expected type.

Please move this addition to when it is used.

Reinette
