Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC91790451
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347988AbjIAXru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344975AbjIAXrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:47:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4831410D4;
        Fri,  1 Sep 2023 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693612035; x=1725148035;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oywh1Dr0O38MwgT8HVxwXyEV/Jpz4zs3QlsNF0kJND0=;
  b=OaH31jQj0Ugf9mNIP1ENk0kJb2kZigtZWd++6ToCDk/9P7cr+BZ078tu
   cJe7AOEchMQzqg659a5DxPUPFGz2+2M6LkO49e3bBpgSSpP0giIg5nc7Y
   7svWXTRR3x/j2db4oRa2ZdCKUUbE0E9YDSOllO8J0nl5jI7v1PpHudgeZ
   YQmGAlcC2G1thHr4LlCmTv2t1GdY0g9hW5VZE++DNodcy7tHFXfT4XRjM
   XXv4Qz70Si7dpZhr1SnWu7muTac/GeZCEPPXJgP7vW0ly1vsV5pkTwfCJ
   +CdC/5c4JMYOy07L2/jvnB/76r7ZaOnyBYDoJ4LQhG+cuwPSTFEtJOsR7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375229797"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="375229797"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 16:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="863716966"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="863716966"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 16:46:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 16:46:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 16:46:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 16:46:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuL6+Y9ruh1TTGwwuBeTbIiFFK142oEiSJuIbnBzYb0/M8U4EUbjbjemJYr48dcmmxptkTuwUAPtJJtpq/+ekMGhe0Em82qJUEkG8ZQoTh4/tTlrSrqNl0JwGpFK5AerC7ZDMG88P3o+HOFGKJ1Ko8MbQQpGnvjHMkRLTZZs/ownIcZWY23OQFFIirIhlBV1KauzWQ+s01zHLiTcwyL1pdFbgR+1/nNRChrVT48V3g/tqfD9DrpEziL9KQrz7mw4JFDyeAGiOuEuqYF30AC0ryS6fsoXNzziBqd2KGXzKm0kwrHXfuq25mbILdHNFD+hg5AzTHx+xbrXjs+cYyliww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5P6JuU7kIcDX1hzmeO2T0TDOWG41QTRU9lASoqOuKo=;
 b=PvSyeTPhknrvK04hoSR8rGXQgpPRVQZW2EAfcp8FkvSA2LUlL/oeURsEz+PSFwFGnKP10kAxKyaIawEAtjyK5SBtAQe549odEH141PAs5d98QVRRTYj5ypl7tIAj9iKCLLSbyn2RXnxCijxsG1af/sObn71IG8VgtT8yzpR04DZO5JQ+g1Hl4qolcDDbFxNwtxwEu3PP2XVTwAtw2BQsnnVgn8HiYJjm2XPq+Yb3XaYM+o/KR0daYWxr6fyp8OP+nC5nHQacNjUe+Tcnj8VkJShU+W1FE8QmGgZiQq+qGLUyO9KC0g5LdK7s8u9a85CvAIyjypBZ5mIKSAmy4yl72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Fri, 1 Sep
 2023 23:46:00 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 23:45:59 +0000
Message-ID: <87cd3ac9-7ade-1d57-bd78-da78ce0d2cdd@intel.com>
Date:   Fri, 1 Sep 2023 16:46:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-7-babu.moger@amd.com>
 <d6af932b-4e1b-103f-77f0-d91c2f3fd75a@intel.com>
 <f33d96b1-ef46-f1fd-94e3-52baab2fd29f@intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <f33d96b1-ef46-f1fd-94e3-52baab2fd29f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::38) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 844da112-42d2-440b-eef5-08dbab459808
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nvmfg8jiTdPLobFKX5lEwe3zyVC+foevkq/oS0jsNZhGGTcE4EWiswCBc1gqSr5xB1CaspxMgSChmF8GycX2hLy7tJN8VGUFjHjs9bf+vSy9sbx/wraujUVQFcnF9n/f1O/o5bgzbC+AmB2Nm5gk9Oa0wbpzNkjmEomSDxp5zLvXnWChwTmTdukjcZOR8VW74dEB3PO5fhPaHWg3ij0+6b/KWo22+xQHC9fFIjgF5HUJC08bm/tf3qyhpppZZQ9ypHrtlDX7taX4jSa7w3wG5x0iJcMUVTXtwbUNxr5wjGjq+5x45haAubdgFH/EIVm9XShedpvspb+HH/9xJGnoJaFX779jTvvz/VE4eKDzXBiW3Wsj/8HJUyEVHRffF4o3/ykfC1S5deyvagCIACcffJr0b4VK3ygUlW80CvsYElvGw4jS/Gww/bmTX1eYF19DICf+jozV6z6lQNZ6Dm8/QI5M+IPgU59ZOqPPGheHB4uxuSS8oimNGz7elvIr2ZUOpfHJKBD7+YzLC4kbwqyXJNjVG8RMNHqn1GAs2Rgif/5AZvTpW71Z+M0y9KwQiz2QGjIkdQtSe37KYE3h5SDde+rAdSCXMl1dJCUlMQeq/BDwlb58BS7fo4YvzlDjOt+4lFG+e2Fnu+jb3mc9lyFwTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199024)(1800799009)(186009)(31686004)(6506007)(6666004)(6512007)(6486002)(36756003)(31696002)(82960400001)(86362001)(38100700002)(2616005)(2906002)(26005)(966005)(53546011)(83380400001)(478600001)(110136005)(66946007)(8936002)(8676002)(5660300002)(4326008)(7406005)(7416002)(44832011)(316002)(66556008)(66476007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHIvSFJtd0xnNVlEeVlIcnRXeFMvMFVKamtrbkRhT1E4QWw0RWdVSzlOUFdL?=
 =?utf-8?B?Sm1hbC81TXg5ekNqdkZwU1VBRXlhenAwczk3MERYT0FaYUtUdmcvUUcrbEVB?=
 =?utf-8?B?MVUyWllTS3V0VzVhRllzTjl5eCtmWXo4OEpwaTEvRVoyTkVDZlVMYTRBaXNx?=
 =?utf-8?B?KzJuVkpSZHJsZ3lCWUt1UUVocGNyLzlRT3JjWjZtZmxSKy9HZWlxb04wckh1?=
 =?utf-8?B?Y3dmWEJ5emRBSHB4R0NnU0kzYXNYWVlFTG5pM09ZZ0ZjUXBkSERtdERFT1FN?=
 =?utf-8?B?eEdTSDRyM0RweG1PRWxWM1YyS3h0SWtlWTZCU2t6eHA2NDl5dDBqbmF3Qm4v?=
 =?utf-8?B?bTBJR2NkSGw4MVlUekhCVUJ5ejcyY1JZeWNRRUl4RklibHcwUi9wVGptdEhh?=
 =?utf-8?B?aGFFdkVTNCtiZTBGM2ludTRBZkNnVkxxcGg2QWZhRGN3U3E2T1d4ZG42RUtK?=
 =?utf-8?B?WVJ1bTY0Y1JEWVdOQWdHTzd3QXUxbUg5a0Mzd0ZsMHQxMWN6c0VYZktNZHVu?=
 =?utf-8?B?S2pGV2FlbHVNd1dPMVlDeDdnSXRyL0JFNUNFQzR1NTZzbWIwUStOc0VpTUdC?=
 =?utf-8?B?SVdRSnBvNmlwQ3dCbzR4R0tpQnNEV1hpNnhjemlWMzI4WG5pVFBJR3lxOWc0?=
 =?utf-8?B?VEU3SzZzV3BCT281NTcyd0ZMbGIwUERYWTdJcFlXRDVsSkxRakJNdnhFR0hP?=
 =?utf-8?B?S2NvQmtQSElpejRqNlhqbSsyVEQ3T0p3UG9NTDdIbis1dWxqUVJNV3FFZEFr?=
 =?utf-8?B?THZ3ZklEM1MyVE9jeXZzZXVGa3ZZaU1HakVZdFVQcUkvTVhjVlQvTmpUL1kx?=
 =?utf-8?B?cEx6Y2YxWC9KbGhyNWVkbW9Gb29DRmdYU1h3cnRQbGxYTHkyQ2lpcEVNMDhT?=
 =?utf-8?B?RmpDZ01iV2NNaGU3SWVINmdPdXlCZE03NXRKNzNqeXU0L2F2d0xJZzBLdkcw?=
 =?utf-8?B?U0hrUlB2SW8xNmNnbTE3VWJHNEFpQTFEMHh4Uk9sMDloVDgwZHM4K0xtTXht?=
 =?utf-8?B?VU1ESlBBdklOTGZSYWpJcW1nL0FVMElNUG93WkEycGJnK2g4cmNDQXVsL0Jm?=
 =?utf-8?B?UGI3V1d0MWl6K3RQVWs4Z1AyY3loY3ZBSUx5dFdtQTZYSWxsMmhZaTlYdXI2?=
 =?utf-8?B?NGdtd0RGM2t0SGl3STJhT2cyai9hb2R4U1VTaUs3QWl4NkM4ekFZajZ1dXVT?=
 =?utf-8?B?dDAyOWhGaXJqWVFYb04wMGk4VkNoQ0NNSDU5SCtaWUtyQ1dISHZyMjNjQml5?=
 =?utf-8?B?N0JPWWRtRlBzNFVZMmZyYXVmV29welBiUE9xdk81NnJIL25ETW1wSmNIQkdp?=
 =?utf-8?B?aHZlUlpIT3FMbXlqZVJzMDU0Z2txUnl6NDVET1R5RnpDU3djVFU2Um5XeVZU?=
 =?utf-8?B?OWtXWldHUTZUb3BjSDBuNkMwS2x6UG1kR0NSYlZGRHdTdkMySHJGRmFqVFhh?=
 =?utf-8?B?TjVTZVB0dDFMWjljYkl1VVVuUWhlUXZ4K3pMMTRlL05hU2xTbnZTL1djUEtM?=
 =?utf-8?B?YTl5WHIrMlZwci9LWlVNcnh0VDFONFc0R2VFZEh2WDVWQ0ZUZGxQODd5dDA5?=
 =?utf-8?B?TmpZeVQ4c1drakJiaEFUVXN3bTRZVERkcHB5QXpiRTBZTHFWZWwrb2lkYUdF?=
 =?utf-8?B?NXY0NEk4Y252b21lMStDK0lCOTM4SWwxVGMxWDFOQUM0aXg3NjVEMVA3T09q?=
 =?utf-8?B?OGFvU2dBZ0RoRXNXQVNlc2c1aFdmMFhMWllrRFIvSHlIVXJXd1NVTkhYa1BQ?=
 =?utf-8?B?UnJ6TjVTeTdFN0R5WVZlYUpDVXBrdUJDMkpYWmdaSHRLaXV0aG9rcWF0Tmo3?=
 =?utf-8?B?dWlmODc1YXVhamZQMFB1L3M1K0JMM01NVkg3ZW1kR3V6YW8rQndRZDB0Ym1k?=
 =?utf-8?B?Sm5NM3VxUTVIMkN3QUN6N2xScDdNVUE5UkdpOVNKNk4vRnhsY29xaElKM2NW?=
 =?utf-8?B?TDQvSGpMYjFUa0k1U0s1Szd2ZHhNakZndFhrSGwwZmlWQWVGUFlQSjFObFM4?=
 =?utf-8?B?bVY2U0RMQ05EQWdtb2FSSkdVRVBBTmVmb2lZeURjc29pNWhUUk9zTWR1VFRr?=
 =?utf-8?B?VUJUTTNGc1RSSmpsejVHd1lnNW42Z0h1Rk5uZ1FwbFAvNU9aS3Y5eVUySHl0?=
 =?utf-8?Q?FLJYdoHgnBd27AghHNi2NAxSf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 844da112-42d2-440b-eef5-08dbab459808
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 23:45:59.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPlYPd8s7CQG04kswqdT7Po2uC4R6h4j5b/lTtpstpyFfV/JMu87DW9HUAsnAqwSxrgofE3q2RlFdza4rcnTGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Reinette,

On 9/1/23 16:36, Reinette Chatre wrote:
> Hi Fenghua,
> 
> On 9/1/2023 4:21 PM, Fenghua Yu wrote:
>> On 8/21/23 16:30, Babu Moger wrote:
>>> The default resource group and its files are created during kernel
>>> init time. Upcoming changes will make some resctrl files optional
>>> based on a mount parameter. If optional files are to be added to the
>>> default group based on the mount option, then each new file needs to
>>> be created separately and call kernfs_activate() again.
>>>
>>> Create all files of the default resource group during resctrl
>>> mount, destroyed during unmount, to avoid scattering resctrl
>>> file addition across two separate code flows.
>>>
>>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>>    arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>>    arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
>>>    2 files changed, 33 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index b09e7abd1299..44ad98f8c7af 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>>    void __init thread_throttle_mode_init(void);
>>>    void __init mbm_config_rftype_init(const char *config);
>>>    void rdt_staged_configs_clear(void);
>>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>>> +void rdtgroup_destroy_root(void);
>>
>> These two functions are called only in rdtgroup.c. Why are they exposed here?
>>
> 
> Could you please take a look at the email thread [1] that
> discusses this? We reached a compromise but would appreciate
> if you have any guidance on the right solution.

Yes, putting the static declarations earlier in rdtgroup.c is right AFAICT.

> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/972db626-1d74-679d-72f2-3e122f95c314@intel.com/
> 

Thanks.

-Fenghua
