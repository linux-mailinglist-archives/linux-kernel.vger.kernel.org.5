Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6980E8122CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjLMX2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjLMX16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:27:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8D1DB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702510085; x=1734046085;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jigZvLSGtKS4500/oIM2de6NN1K7/Q6zF0nll4gBWOk=;
  b=iLKxUqedssnEf1EPRMndy4ytolMU8zwaSrc4NYbRmDxDOeJdYu2hCImo
   K87q3Tj7GujNxshv9HkGXbtZUhCQNyN8Rv9lZI94zUclz3qY3FN9Mkyy8
   gcQDNTQrEYhj5syMAGr+DET4HUYzWqWEvZdVIE+DXnZtGyx0bumdv0mF4
   Ix84yLbSy0TNKLreNx6V5IDTrzuRs/bEStPgZLPlN99sQSglzofTxgeF8
   A3N4QfGfSpp67z3Q99838fi1SRw6wqWLfGYCYnhaOL+Bzpnu/Z2eFHbso
   vg0snEEEIX7xFtxDphki+SMfrlpdeUTeHf2RipkwcmJQg0N60ZSVgrV6p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2125756"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="2125756"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="22163535"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 15:28:05 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 15:28:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 15:28:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 15:28:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i92Mg1g1cy4FvyMWcOokioKSfJuC2Y8L402ymuKMAte+VYIFwEORpD+s9odsmw/e83N7P+G/VARaLhVRWZ1sVGpUC/OrDRZMQkbc0ny3UvIs5+rPfJA4EzmdymqwPFKaREEsDyH5VIX9avrK/G4zMUgfz+6DNt0rFy08Ijgl9G0dAASvbj03ppw05/qLi6uYeGJz0M6tNpMoOU5SUpo+3tf009cPIpKVxYCNWlNjbLc8BLpUfVJArSEhUtb4RdlE9V0QXYmNV21m9x3SJYyerBnKtkgkmZtTQ+XSWgbZr7jTnw+9kQQ37v1m6cVSN7su7TthAoDvPzbefiG6cp4EtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv6Iy+3IlTQ2NWuTf1RRq6TZVLrk36ZDAJmCvc5sl+E=;
 b=frxxtOVyBOBpn5VeXVNVoRzLfOdqQbiSxVKkR4XPh3U7PSroS0vv4kF3NuNxnUODmwfCXyU1hJeLnrRYj3qrBpgtUhLPZ5JVKXVfvpUpRtzmgqEKLyze6ay9T/7Hh1Z3p/qofOJwuw5Fc/4LcKEpKvkaf+DOvDHY4yfTFIQvr7qDQy2c9ofV78m57W4E37KRntFK5hyS9HxyxXAjBHbffoG9r6h1BSOcapu+uuJ6jzqvaoxAnN94uDjQy1hNwhLGN+5Iq5qe7RwzQzSDXyVI2mt8O+l9zNjwFfujZyA8rEzhkHviyQUcvjixcKZKbWffrxtz0w0/QKihrhQqMKNlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 23:27:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 23:27:57 +0000
Message-ID: <cddbbbae-599b-42c0-abe1-4ca74d5ce36c@intel.com>
Date:   Wed, 13 Dec 2023 15:27:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/24] x86/resctrl: kfree() rmid_ptrs from
 rdtgroup_exit()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-3-james.morse@arm.com>
 <208c3ade-a8c3-41cc-b136-4ab9b7e938e5@intel.com>
 <bd3afbfd-3372-cac9-600e-ace19ddd3199@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <bd3afbfd-3372-cac9-600e-ace19ddd3199@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:302:1::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: c38d0aeb-6360-439b-9fae-08dbfc332352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kSyS2QHg+qCAH4t/fxjLb6PnBv2LUbewrvORmsxMm8mvQMRkxaTVJkhoMfCa9HRElzcIVsaW/Apvd+2SRPevV43qBIWh4X+I3BUHGnavbdBzJTZEQp6o7t4sj2x3w7KyQAymXV0IqalKda2ovswk0mpebkKbPnESJj9C50eo1I8ZYQLqaksWxi60sXsh3rXkCnvOQ31ixC7VW8dPedhGM12bGTs2YVOCzmmKuo3uiEVrBCAUIx1I1ePY4PZhbb9FBq+Xaa2kpYloM2zo31mUK/XwF7i47AOTi6g0o1z651Md2u/Dk/A+MqP7VJBN9Ekd8cpWUC6rZUNreSzAacHiqVf6N3A4bhudfpZJGDTTlD3bnjYYacmj9jfMYH6XvpeazDo1r8hs1L0XgsYxpO+bZYd9060stLhlRJ3FM2j/kCaYh+AbsDMimHXM9vnr6YJJ51ICCtNyy4KnLU7QayyANbbYQp3PrllsffyIOxHL6aK09TQuBcgBNNsydObw3DZjLJPUco7bxCywyJh2uV/VYkdEDVUNwLmczUImd6Cpd6rmFGJ+sXz4V3UaMP+HCkTpDdym2+ZQazLFucQvUAGVZqaqKZ9KG1FVBaJ82/gZLM8HudnSROlmjCJ7f0rspMc8o5fSEFIFDPi9Fpdye6yZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4326008)(8936002)(8676002)(31686004)(2906002)(7416002)(44832011)(316002)(5660300002)(66556008)(66946007)(66476007)(54906003)(478600001)(6486002)(26005)(6506007)(6512007)(6666004)(41300700001)(2616005)(82960400001)(83380400001)(31696002)(86362001)(53546011)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NuT1ZLckhqbXoxeFNQdnNkRGtIL0FESU5mS0FnVDdqOEFnNnFJdHd3TmpF?=
 =?utf-8?B?eThIN3hzRm8zSkhoZFp2aXJPM0lYQXlUSFFYRGdnb3IyVU94NjRQU05DbmUx?=
 =?utf-8?B?YUgxNTZORmxta2J3T1g5NDJKWHB1UkNTdy8vaDRzRnRjMFJPYzV0ckgyK3Ax?=
 =?utf-8?B?Zlh1eTVuYnV2YTBxaWJDaTA3c0x6eTdqNTlsWFZWbHh3RUFrTVludDNzTGxs?=
 =?utf-8?B?dnp6ZlROM1ZrWG5jSHRpdVhuVEVvcXB6YU4rdkw2Z2J4bFBhVHRLblB1UnhF?=
 =?utf-8?B?SjRvTWNOUktnZFg0bFVMWjVtK2RHcHNhTVl0V0VFcmt2TmwycW0yN1l0bmNP?=
 =?utf-8?B?eXd6SHVNU29adDhQQ2NRcXI4dTJZUUUraW5RRXNCalN3Vm1OL3B2YXhNRGV3?=
 =?utf-8?B?STUwWllMVnhDaVF2Mlc0d0x0MTRWRTlGZ1RocHp4WU4rSTlZRU1UQitRTnlu?=
 =?utf-8?B?bFZzU3hKNlFMOWpNclg5dythVXptQm8vMmFBb0dUbzZ3Qis5ZUF1UVdrWHQw?=
 =?utf-8?B?Z25XZjBxRS9uVXVVVzYwKzIvRnRuRVpYa3h6Zk5ES1ZxMk9yWmFMV2pxOWNO?=
 =?utf-8?B?SW51R0RKeEJwb1MxUXRnajRnOXl1NDZPdG1qTFZSQWlFL3Q1UHN0dzFXYzUz?=
 =?utf-8?B?S1RiSlVXNmZ3bENqcUptMkxhYWdIZnJLb1dlQmdzN2VFaUxwYkR1M1lOem93?=
 =?utf-8?B?QlVmenQ3Nmw4dUdUOUVuOHdkK3FvSUREMkRQOThFVW5JSm1hY014NkhRLzdw?=
 =?utf-8?B?QUZXd1RrOFJXZVJBdkVnVlE5RXdLQWZyY2o4bWdCMzJEMmxoUjlrbVA0TmpB?=
 =?utf-8?B?ZEFUUHgzRmc5ZW54SktERDc3OWJ6OEYrOTVnbHloSjJwa3liemU3UWkxVG5P?=
 =?utf-8?B?K3RzRHQ1MzdPaXY2NTZQQTRoQjRxelNqcFlDYUpaYjU5WURZYkhqMTZ2RnFr?=
 =?utf-8?B?ZWFjdXBRSTgwTEVnbFNCdEl3QUpwZTRKbllXY3hpZHExYUtlK2xrcmljNUY5?=
 =?utf-8?B?TnllWFUwTDI4ZG9kanVaRUt2VUlDdWM1ckdqeFRPQkFEMEZvakdRS1pCWDV6?=
 =?utf-8?B?TDczYnRFeTdIZjNCTDNReStVMzVDTWx5M0gzWWxhbkNiSlRyWm96V3V4d1g0?=
 =?utf-8?B?ZlYzdmNWVDNtZnA0T0Z0VDlJbXl0dXVOQ2VhdEI3YnowSzV6eUJHc3o5dzA4?=
 =?utf-8?B?Sjh5cld6M21NbW1kbmR5b2FWQmVzTlN5ZW1nRHNZMFpqNG52bFArSnRIOU5Z?=
 =?utf-8?B?N0JZRkkwbGZDaDluZGhobGJhRzAvRnV5N21LYzJhNGVmczZiMktlb0xxMnpm?=
 =?utf-8?B?bEw1N3EzWXVhMGhuQ1Q5MEtWZ1N3ZEZkd3A2SGRsZ1RQaTNBWjhTMVptUW9G?=
 =?utf-8?B?cU15NnpreGY4N3l4R0NuL0NHU2hHZFBtUXEwenBNOUxpVUErS09jNVNnK1Zx?=
 =?utf-8?B?Znk0bnEwUWVQZ016RVBEMkE4VU9yRElZQzZVd3l4Z0V4OGVrSXoxYkt0U3VG?=
 =?utf-8?B?MGhkclNOZDV5My9tL1NGR1BPNzlIRkRJcW5qODJiT3JHQlhhRmZ2aG5JaUJO?=
 =?utf-8?B?U29SSC9vVithcDZIQlY0aXdzVGxnNDhrQWVlYXNUa2R6aUlCTk01UlhqQ2oy?=
 =?utf-8?B?NHdjV1Q1dThZaTd5dUV2bkJ0dXJYWDdPaW9YRWtRRFFIU05ENGtyR3M0RWFT?=
 =?utf-8?B?RDBLVG1rYkR1ZzVMWmVoV01SSlRoOGV4SXltbHdnVTF5WWJGSytOWDdLbmVH?=
 =?utf-8?B?ZVhWTDN3aHMvQ21xZFZIeU8yT3F3dUxLcnZmYXE4cjBpK1B2dE5XaGg0Wk50?=
 =?utf-8?B?M1Q0NjIwRzM5dndsaUhMQnlXVTFTemFaQ2FkQkF0R3BEVEVlZnNVbVprNnZQ?=
 =?utf-8?B?eWM3a1ZxZmg4NlNzT0NKVjRiTUd2THdxb1lLeTg5WllidEx4eDlydThqSnhW?=
 =?utf-8?B?eDZaakVxcjR2dHdXa2tsczRTSDBEVEJIOC9nT20wcHN0a3lJbjNHRGZIQ0pi?=
 =?utf-8?B?MVBIb2hnQ1JORWMzV2hxZjB1aGRTaDZJdC9uWDByOVZWc2dBZ2JISWxJQUxj?=
 =?utf-8?B?QmhlTEtvaUY2anVjVjNzRHlZY2swYm1qQWx1S0lUWXIwZGlvRGdVb0VZSzRq?=
 =?utf-8?B?ZjkxbjRocTI4dlI5djNvL2VRcXUxV3VGWWIrYmIxRFZOZG5Bb2hyanAySkNG?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c38d0aeb-6360-439b-9fae-08dbfc332352
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 23:27:57.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjHkdq9JVXB86BPM8xzAgR1oMREqSr50UIOuA3XC5xnbcxCVmo3UrEmNZrNZ6zepcuxni4Yn2Mx0pIoLnB732ymG6RCK+9W4JZloEK9umvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 12/13/2023 10:03 AM, James Morse wrote:
> On 09/11/2023 17:39, Reinette Chatre wrote:
>> On 10/25/2023 11:03 AM, James Morse wrote:

...

>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>> index 19e0681f0435..0056c9962a44 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -992,7 +992,13 @@ late_initcall(resctrl_late_init);
>>>  
>>>  static void __exit resctrl_exit(void)
>>>  {
>>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +
>>>  	cpuhp_remove_state(rdt_online);
>>> +
>>> +	if (r->mon_capable)
>>> +		rdt_put_mon_l3_config(r);
>>> +
>>>  	rdtgroup_exit();
>>>  }
>>
>> I expect cleanup to do the inverse of init. I do not know what was the
>> motivation for the rdtgroup_exit() to follow cpuhp_remove_state()
> 
> This will invoke the hotplug callbacks, making it look to resctrl like all CPUs are
> offline. This means it is then impossible for rdtgroup_exit() to race with the hotplug
> notifiers. (if you could run this code...)
> 

hmmm ... if there is a risk of such a race would the init code not also be
vulnerable to that with the notifiers up before rdtgroup_init()? The races you mention
are not obvious to me. I see the filesystem and hotplug code protected against races via
the mutex and static keys. Could you please elaborate on the flows of concern?

I am not advocating for cpuhp_remove_state() to be called later. I understand that
it simplifies the flows to consider.

>> but I
>> was expecting this new cleanup to be done after rdtgroup_exit() to be inverse
>> of init. This cleanup is inserted in middle of two existing cleanup - could
>> you please elaborate how this location was chosen?
> 
> rdtgroup_exit() does nothing with the resctrl structures, it removes sysfs and debugfs
> entries, and unregisters the filesystem.
> 
> Hypothetically, you can't observe any effect of the rmid_ptrs array being freed as
> all the CPUs are offline and the overflow/limbo threads should have been cancelled.
> Once cpuhp_remove_state() has been called, this really doesn't matter.

Sounds like nothing prevents this code from following the custom of cleanup to be
inverse of init (yet keep cpuhp_remove_state() first).

Reinette

