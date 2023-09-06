Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCBA7937E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjIFJTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjIFJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:19:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8654DE60
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693991934; x=1725527934;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B9TBB+yMC5qjCYRPtxVs+jclodz9QxfAEJSGC82KsVA=;
  b=i9e+MhLox5IGgRzV+xJCIXqKTDJ4Oi6UnDY1BhMCOwgN2ugaNtGJqBsT
   G/oC3onP4pcY5XPUHCPOGCoWYN18vZPPux4NnbzWTg+12fnWsSFYiPUI8
   PcFV+J2WyYoik04u4Wnd65U0VtGGOtXAEW2JMWY2hU9DNv1+3JspYXmqE
   ivT1HtmbDLW4chOapM3PKa3lZuQMsiAKS39dwofVs9gZe7DiW7cYoLdEg
   yTWpJ1iNTF5PCVmRiKHgtUkpC01a3tjzRf4IcctJDCX0AB1lswFqy50n0
   x31D0xRF370UbemlqOkAhW8d/HYdah1hC/kstWxdPZCEOOddfWRCb147y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="408017231"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="408017231"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 02:18:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741467326"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="741467326"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 02:18:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 02:18:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 02:18:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 02:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS5/AudB9YTgL6hNikwBracc/vPs3jHKK7nkRSZRboSY+aihY7uONvJawnJFwEFjSwx+MVuHf7vZoQ5KfxBAtBKs2qLbQsf5Nqcfz9qs2sohcyuv4ofiAKeJFNd0TigbE4kVe649qQlERW2Ptr4zTNAEt68z1T7fA6Urd9Ydv7mHlaN101NbVfIfNImggdZDMBWLXdM80b7ofdrNC4mc1uCbKWyHgWA44HhiqjQ91HOwQkjPbQV9duwi2XsNVl6ggkqMeQ59amz6jMYxmg91SJc4q79AYkPWHuSnMeFpe6hCzzI5UkH2Syb5f+g+Ge9ku62Na6WoMv7S9ASku5dmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w/0HNF25h7Ir5DZY9jHI5mRIXMZ8nQl7qvS7FE876o=;
 b=ic5ml12GpFQu8tc7H52/qGXfv1H24rSPE+bq6n5Xcm5YUPSkclOxqsoUW3+M4fqv/B0U5Ctt87Wy+vB5BAkB5YM9yF7U1Dczma1eEBM/fn/BTYdcl5zTlEoDyrOqMYMa0DUA4QrpBnSzlE0Z9rAtQxcNEE9ldLWdh8UaTB5maJrYNkt2duFqwHnJ3RbK8gHcLewqYK5XlzzwHEn8vAI7entnq8EewdZmSv57oBKwC9M2+zPCFbO+TFhhNdf5gT1jGnEYam7ZoMXCBBB5d0tgDxF2lSQeaPzsVPepG4hpw2gixhTifeKVSV2YzUJ8uRZ1sLLTDyzPQqUIwWHLs46nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 09:18:50 +0000
Received: from BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::5e3:67e1:e213:c87]) by BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::5e3:67e1:e213:c87%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 09:18:49 +0000
Date:   Wed, 6 Sep 2023 17:18:36 +0800
From:   Yi Sun <yi.sun@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
CC:     Ingo Molnar <mingo@kernel.org>, <dave.hansen@intel.com>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <sohil.mehta@intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <heng.su@intel.com>,
        <tony.luck@intel.com>, <dave.hansen@linux.intel.com>,
        <yi.sun@intel.intel.com>
Subject: Re: [PATCH v6 1/3] x86/fpu: Measure the Latency of XSAVES and XRSTORS
Message-ID: <ZPhD7B+pXyeP2BPS@ysun46-mobl.ccr.corp.intel.com>
References: <20230901143414.1664368-1-yi.sun@intel.com>
 <20230901143414.1664368-2-yi.sun@intel.com>
 <ZPMTVNM2oBCdSYjJ@gmail.com>
 <ZPOIVmC6aY9GBtdJ@tassilo>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZPOIVmC6aY9GBtdJ@tassilo>
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3094:EE_|IA0PR11MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 4267b7b5-5cbd-4e01-4c2c-08dbaeba477a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7y+ZKUIRpb1KsxO/SFoRdhq1x4BmhrTkMOJHv7/Q32JJEPcrGeTkAyCKIcsuuDZSju2FBmly6AC/+3wcP+IYrqwPt1mVpOy6ru/T7+TDJTJ9w98HAUJ5xYYXA3bHWOBgNgwurqeQXvHQGYH9u+1B6GEilbMktewOmublzEqFitDPtHQmG0lj85cgPck9oEej7g5lyS7A7UyuMkykY3WVw0Slywbtc1F+f5ABh+ikMYZKDA0R3W0CwO8mfuywFmZBN+MZgveOK1Zjx9Mf/zPcyB9xEBvI722NkRRF1WSKvo1wF7o+aHY5KiiwlIPGrOMeGtljwStetV+ReY1Z7FG+K/Wwj8LLvDZIVEQ4fWDExZ8iuklcqM1PqRQdOrtaxZvVnKkwAi10BS9UNstN8HJn3LqWKo19JsseCLxSsewZli4NTJrt25rrOfz+f3hUNlmXUOK/JsRP18RVVCbFpM+k987zuvtmYVZzjwLpZPVaPuR3So42k0KT7bqEVZE0+gO7rCjlIB+hhif1NZLhp9KbMY7FyTJAjChiRuZRgePi9guM9du8248WA8ZBh8hDcWzaW8gjMoy8NTszmaLtyvLAgT3tXpt146d6+6x0I0FZzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3094.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(53546011)(6486002)(6506007)(41300700001)(6512007)(66476007)(66946007)(66556008)(6666004)(6916009)(478600001)(316002)(26005)(44832011)(5660300002)(86362001)(8936002)(8676002)(4326008)(83380400001)(38100700002)(82960400001)(2906002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGEzTDBhVGdSbEZrWGtLQXM0Y3kxZ0RERGhwTndZRUxaNEpZUkxOMkkyNFB6?=
 =?utf-8?B?aFh2WGE0OXRROStmckpDOS9xcDVTeG5oakF1YWlCRVBKT3lpcTdzdlZiWStD?=
 =?utf-8?B?V2NhcklOUXRETmNTd2FxZ0RqMEJaUnkyWEp0eEZ0TktmWTFsbWRRMFRlVnhp?=
 =?utf-8?B?RU0rTk1lUlBMbXhpaTJxL3piWkx4Yk5tUlVyOWNTM1haU0JlSHFVaHZTSXNs?=
 =?utf-8?B?T081dGpiOXNsSU9rN0JXaDNEem93WDRKTnRsM3BDK2V6dFhlWktMbVZDcW82?=
 =?utf-8?B?TEtUd29pTTdrNjhuUHlqanlIdXY4TUNmYTBqai9LOFdVZ3RhTHh2YmhBdm5k?=
 =?utf-8?B?ZlF6dUxzaUpaZy9LcHFOditBRmVFUm9RK2kranB3MjN2RDdwdjRZcXhHVlA0?=
 =?utf-8?B?UldIdEhqbExpcWtPYXd2KzJ6OHlQNm5QUlFQQTJoN2JvUXJCNVBDVHpWNTVC?=
 =?utf-8?B?N0JjK1djUm02bkZadGNOSmozenplVGI4dHVSYUNMOWpteVVOL1BFNFhlT01j?=
 =?utf-8?B?alFKNERLYUJZOTc4dWk3MTBzOUJEODRWWU1BSzFxRWZSU3F1RUZIa1BYVlFB?=
 =?utf-8?B?ZFhDbFo2ZHY1NFNzSjZyaVR6cVFhbVJUSnorV3g4eUQxaDB5WWtsMWFzS0ox?=
 =?utf-8?B?ZE9NV2FwUC9OSFpIVTk5anAzbDhVc0lWVzliSUp2TFNsejUrY2RhdzQrekVn?=
 =?utf-8?B?RkgxWmFHeVJ3SHJaM3g2dWhINW5SVVhBczhmdFUxUUxTaFdrUzJ4VGo3eVQ4?=
 =?utf-8?B?SEkvRGRIaHZJd1pSai9NQzJSRlY5TzRLNE5jUWRRa244dmpIY0xzYXFLb0xO?=
 =?utf-8?B?bCtaRzFoLzUyYmJLTXozN0lxRGNhR0lJTVVoSmM3dzNDcEtOVG9kM09ybGdi?=
 =?utf-8?B?L3MwWko1QVhDQ3FPRG56NTJZTTY2TzNDWFlGL3BBNWFsTXVsTFNlencyNnR5?=
 =?utf-8?B?akQzLzdhclZ2MXZtQnE4bFpNakdMYVROSmp2RWtMaDlJbkQ5NFhFVTFQUmxD?=
 =?utf-8?B?eXJidzJoczY5Wm9Yb01oRmduckE2TXBvQWxRVTBwN2JpeUJZQ3Q2bElORkto?=
 =?utf-8?B?Qyt3T2E1R3ZERVhEV3RaTVZUSTVxZGQrSmRWd3VPZlNvaW55VEpaVGhyOUFE?=
 =?utf-8?B?TTZ6TzhCUitVUmdrUjgzcmxxSm5BYytNVk83c21wdyt5Zk1uTVNRamJFWFN4?=
 =?utf-8?B?ZGI5amJwQmlQSGw2dU5mUHFyeHQ1bVFUVmxoNmp0V3l2MVVxRGF5UHIvNnNL?=
 =?utf-8?B?aGpiT3FabzFtdUFISU9tWTB3ZnBJMHFuNnc2OXJSekkyT2R2MGZIazZxVmND?=
 =?utf-8?B?amorSkFQOGw0NG0xWldKODNnQXJmcHNQa2NtdnBqV3plQ1h6TDNLTzVpdEta?=
 =?utf-8?B?QXgvVmcxZm1lTjYvL2gwRlJGc09zRUh2aXA0L1RNNDNodkthQ3JBN2YvbCsy?=
 =?utf-8?B?WWJFa3dzZUw5NFRheHc2TlVQcHYrZ1hUSHhuRnpaTFR6MnNtVWluY2VOTlNx?=
 =?utf-8?B?eE9wNFpaaHRyR1BTNExvWndvdmpQcVZjZ1hpMndvL0Z6T2VnRnZGRVRzWUVZ?=
 =?utf-8?B?cDJXRHFRd3ZkS0NjUFp5UitpN2F0SFRIUmlsTmx2RlVkTFRjczViaEoyRVNw?=
 =?utf-8?B?OElRbFJiei9OOEN5VkZrVnlRODdFUnV5RURRSkNMMzNDcXZIUVo4RG0ra2Z0?=
 =?utf-8?B?SXZEcVhaaGdINjFKTG42SWNUNjk2bzJSMFRTczcyZ2xEOXpuZFpCVzZNQ3l4?=
 =?utf-8?B?R080dUxYM2Npd2NvRWlKTW1TUmxFaTI2N2lmT1IyLzRlYTU5U29xdU5vTzRQ?=
 =?utf-8?B?emVjaE1SbjlIMldGMGVEdXBtb0ZBQjY2TW56N252VVNyZHA1OUEvYXRjejhv?=
 =?utf-8?B?cXBGelV2cnZ4NE9kS0UxaDJ2ek5BN1pPL2lVMFo0VmMzSm91OEhYMTFPMUVG?=
 =?utf-8?B?c1JkUDRYS2VEWkVEbjdKQmZrMmpFM2VVbWJJdFNBSUxqdXhqMUt3VjB4eW13?=
 =?utf-8?B?SnVZVGsvenRxQzF2eE0ycWg4Tko0ZmFrWG9DSU43TlFVS3JTZEY1MWRRY21l?=
 =?utf-8?B?QWJadmMyQXVHME1tbk8wRU9IWHk3KzJKZGNEZVF5TDY0cUN0aThRN0prNEFR?=
 =?utf-8?Q?F761JHwEV/2/2Etgln1bXRbi6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4267b7b5-5cbd-4e01-4c2c-08dbaeba477a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3094.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:18:49.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8nhuiDpQBL936B6yNwgZVrgSHT6Drb36i+zs6t0J/K9a7xht0/uiwlPLNcKgj9/nVYWI1f3/EgG8dYxy7/VTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.2023 12:09, Andi Kleen wrote:
>> Instead of adding overhead to the regular FPU context saving/restoring code
>> paths, could you add a helper function that has tracing code included, but
>> which isn't otherwise used - and leave the regular code with no tracing
>> overhead?
>>

>> This puts a bit of a long-term maintenance focus on making sure that the
>> traced functionality won't bitrot, but I'd say that's preferable to adding
>> tracing overhead.
>
>Or just use PT
>
>% sudo perf record --kcore -e intel_pt/cyc=1,cyc_thresh=1/k --filter 'filter save_fpregs_to_fpstate' -a sleep 5
>% sudo perf script --insn-trace --xed -F -comm,-tid,-dso,-sym,-symoff,+ipc
>[000] 677203.751913565:  ffffffffa7046230               nopw  %ax, (%rax)
>[000] 677203.751913565:  ffffffffa7046234               nopl  %eax, (%rax,%rax,1)
>[000] 677203.751913565:  ffffffffa7046239               mov %rdi, %rcx
>[000] 677203.751913565:  ffffffffa704623c               nopl  %eax, (%rax,%rax,1)
>[000] 677203.751913565:  ffffffffa7046241               movq
>0x10(%rdi), %rsi
>[000] 677203.751913565:  ffffffffa7046245               movq  0x8(%rsi), %rax
>[000] 677203.751913565:  ffffffffa7046249               leaq 0x40(%rsi), %rdi
>[000] 677203.751913565:  ffffffffa704624d               mov %rax, %rdx
>[000] 677203.751913565:  ffffffffa7046250               shr $0x20, %rdx
>[000] 677203.751913565:  ffffffffa7046254               xsaves64 (%rdi)
>[000] 677203.751913565:  ffffffffa7046258               xor %edi, %edi
>[000] 677203.751913565:  ffffffffa704625a               movq 0x10(%rcx), %rax
>[000] 677203.751913565:  ffffffffa704625e               testb  $0xc0, 0x240(%rax)
>[000] 677203.751913636:  ffffffffa7046265               jz 0xffffffffa7046285    IPC: 0.16 (14/85)
>...
>
>
>So it took 85 cycles here.
>
>(it includes a few extra instructions, but I bet they're less than what
>ftrace adds. This example is for XSAVE, but can be similarly extended
>for XRSTOR)
>
Hi Andi,
Thank you for your guidance on Intel PT.

I recall that we have discussed this topic via email before.
I have compared the two methods that calculate the latency:
  1. Calculate using perf-intel-pt with functions filter.
  2. Calculate the tsc delta explicitly in kernel, and dump the delta by a
  single trace point as what this patch does.

My findings are:
  1. Intel-pt is the most accurate method, but it's likely just a one-time
  exercise because 'filter with function' requires rebuilding the kernel
  and changing the definition of functions 'os_xsave' and 'os_xrstor' into
  'noinline' instead of 'inline'.
  2. I collected the latency data with the two methods, and the method in
  this patch can achieve results that are close to those with intel-pt.
  And it only introduces a negligible impact on the performance when the
  trace is disabled, as I explained to Ingo earlier.
  
Hope this clarifies my approach. We're using this patch set to do tests
on Intel's new brand chipsets.

Thanks
    --Sun, Yi
