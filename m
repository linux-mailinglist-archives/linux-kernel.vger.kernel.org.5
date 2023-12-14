Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABE1813A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573169AbjLNSye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNSyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:54:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58AA0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702580078; x=1734116078;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WqFWWaUsNfEOQv2g3oxWyd6gVawHGChYqZ+aNOBR9K4=;
  b=EKz49h/ilf5I9kBrqjzwAy8MaWgOwu1vuS6Vd6L85oh2vC1+bp2rLgmA
   qTJ2vCGOxGpM7EBVB7eUJwJaEuTQvo23A5l6iX+EJKu90DDPFknL5xCcd
   dQ0jjGJ/Lz8f5BnemYhfSGu8eCQCHjQ4VMAKzy0etaPSK0RrFqnbW2r+5
   FjXUoubL0O39EONxtppX1smpSrQ9uNJVnudhJgxPtcWbKQ00qiLRaEjR1
   dtZsYqYFv8nmUU5z+ZFzJCZ9gZKUanWj5Pcd/YMomutDmnCbhEJbiSgRW
   KlvGGzbqri1eRt39vogJSrm1l1wnM7kw7b8lM49upN7OF6Noa2Vsyz4Gr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394912259"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="394912259"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 10:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="767701008"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="767701008"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 10:52:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 10:52:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 10:52:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 10:52:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 10:52:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHWlbsGWSdbaLyccHMc+rlmfw0MS+hOyJcMlNpxoDlfzgNh2UHAvb0zVTXPg1uiMTcWDR2ywBbTYf0nzuD1gGkO3x0y6ah7KH2xcPkcbt1NV4h8/Rq6SxESqo5u2otgunX/W5eO5v6HEZFJo73iahS+wHlJ4t5RzxstSTGQxqKPOOxOYuKNalw7556W1LceRNqIfKvOn5kI6xhg0HHagzizYecTOvqJrYl/LLgjOd11PpFhlO3YZjKUgj4Uoa8j4+O18UYQbCrfxvUIrky77QeiffiJFj5+8igG1OQGJlN5+AQzLP+ygA4PWqS1UwnkXB5L+HSc7JGLaVDcrg8i9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+3L+IdiDsMLrBZ4whh4EDSBfocuiUNs5dNgrZImIHk=;
 b=cpOsnitrHSa7J/J1SZoHyt+fA3P3OarHniAeq++wns36iha0cVAA2V4FO9iQDckExUHzFgUYHBZmpHxXF0WAiSFmasJ/rNSi9F4+Uk+qQy+u9TRPmA9KrWD9QfybIhh0WqX0w/uPNbqqZGQf18yyWVnlke9nFkVPkZeUmANpGEYJPb7kmXRx6sgwkJ4hKg5SZGIcxeCU6Dv5p5/zRolAM8zmawX6e+8VPUPpFfr0YGLZZ6qOvTZ0GytjiGDs8n5tneMvwGgMxIRmQ/5v7TnTprLfyFML1E0U7NdSEaR3shMo2Y5k/VHbX8+H+HR+oht1FzN2sJvjdb7wcuzoF18YLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 18:52:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 18:52:32 +0000
Message-ID: <da48d207-da8e-4085-940d-54a0dfec1c9f@intel.com>
Date:   Thu, 14 Dec 2023 10:52:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
 <20231025180345.28061-15-james.morse@arm.com>
 <73bcd9f2-7c2d-4e9e-bcd8-ce3de2f9a5a4@intel.com>
 <b49f55df-e566-9a6c-b7d0-b0b675e787fc@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b49f55df-e566-9a6c-b7d0-b0b675e787fc@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: f228bf47-50b8-4029-4215-08dbfcd5d420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMoMVbV5874Gbu1xfSS7FNwZ5LoWG52tNchQdJ/dW3NRud+Y7dliVje4b5qYpYFJLA05jihMhLkF8lnCSLLsBQfPEqgcL4DSs3RG+QfvC1ZbuzoyrkGNsyrxqhQSj41TUJZShvvJobIQQyZSqB8yJOVrbe1dcJ91O6UcaH2KuBbL0HW3QI1J+F7KojzIsIgAP8uLiPTOaBXb4f3Gi8Mczh7x3e7uhcdqlnDwTFCXdDEC/DuObvEtbe0ql1O+VXoRXltoU1Lfu8SyUQzwMLkuNtyrZQv7xlJ/v7CD3UtImft7QUSCcYnfy4MUC4SU++cmHrMNAWZr89QdNkEcC06LCjUHJFnSubTc89T8zqk4rssevQc6Q0KuHRCwM7iQxuKFaORzvjOOlgvjNySgYZHQZsvSjEHVsLeeFA4MlpyBonbVj1BWduxXra++9jDIUkB+lfJ3I+3Uff9hLQpKUSdZzYbQdZNlDu7XCJA/uXj0mndn1UWyZ87WQAIVfe9T71rDt6hmFJ1isowdkHDIzzVxO4zY0rPG4CWO1kA4Vkkcxx+IwYJPS+FHaDtBV7qGsUW3GVn5vaCcfTSEmr2p6swdo1s+CUBZRINyWKP49PPdxBD+pi47vhljQ3vHCSr6CobFbnq1os5K3HaC0yj/kk2gtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(31686004)(41300700001)(66556008)(66476007)(66946007)(54906003)(2616005)(26005)(86362001)(6666004)(6512007)(6506007)(53546011)(478600001)(4744005)(6486002)(2906002)(7416002)(316002)(44832011)(36756003)(31696002)(82960400001)(8676002)(8936002)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0luYjFEN04zaENnQnpNQmFYbTFmNGtEclUybU5pb3ppa1MzdFk4U2lEczRJ?=
 =?utf-8?B?WXYvbDNudXZXeTRUQzcxb2plSTNjZERIRjNJc2E2YjB5TVJQRTMyNkJuSGp4?=
 =?utf-8?B?NitkajRkWkl4SEJVbTlYVWozR2NnMGJNNC9WZW1QVEN4azVOOW5ocVNUQVRo?=
 =?utf-8?B?Y3ZlNmh3Z3BqeTE3K0hKOENGanY0bFVNNUk1YjdoNFIxVmJFUnkvem02M3ZP?=
 =?utf-8?B?c2VMdGxUbjZCZ2RaVTlxNXFTWkFRYnFhRTM0MGdXSXVpT25COTRZWnpyZjRY?=
 =?utf-8?B?aGRraCt2S21tWnJYYmE2bm5OcFdxZmw2MEt1NzlWQnh4aHA0MWFDYmxPdCtZ?=
 =?utf-8?B?ZVJCUzFCMWY4QjhmQ3R3c3BSZ3A2RnNPYmUyNGUrbWFocTRnekhBbndDVzBK?=
 =?utf-8?B?T2ZGYjNFY25nRVIrSFIzem5oRnZ4WU56UndOeHpCQzBLL2Nxb3RacFZodDkx?=
 =?utf-8?B?ci9PRWM1cU92aU94UHJaK1ZpcXFrdzhpOEJGY0xKdGZPT1N5SFN3UzhaM2xH?=
 =?utf-8?B?aGpEanBROTE4RUxvOTh2dVd2SzJJYWlUbHZtQ3FtQlhvdEc2M29HMGh4Nzl6?=
 =?utf-8?B?bHRuU1U3b2V0UHR2TzhVbDhEU0NMd290Skx3ZDZmd2EzVTNhcHA2eDFKb3JV?=
 =?utf-8?B?R2Y5aWxCZjVsdzZxbmVMd29CZlluYitWbjVpNndyd2U4ekxsM3BMczB4aXJM?=
 =?utf-8?B?a3dSUXdNNnJCR084U1daWTVVb3labnF1SkV4dkh4Z1BtaTRFalhyTHdLSkRy?=
 =?utf-8?B?UU42QTFDMmdLczljckd0UTF1MzZKTXJvaFpnR1JMdStWQmFWTEpDdE8rVXcy?=
 =?utf-8?B?VGZ2eGJMYjBRRk1BSStqUHRPczBCR2NrMncyRWNxRFdBTlJWYWE4RWM1UTUx?=
 =?utf-8?B?K3NaVTVQT3RrU2RUcjBxVEJqYThzY3VHK1BSN3FVNHNMb1Fpd0tBRnZHbmhv?=
 =?utf-8?B?dzBnOWZvNXRaYVlSdDlGcGtWZkExUWZxL3BkUnl6bnhuY2ZqMm5BaXhaV1A2?=
 =?utf-8?B?cUJBQU1waXd2N0J4RjFMQ3dNT1ZsNjVqUisvVFJUMXRidVVjZWRzUDVRK1Y5?=
 =?utf-8?B?bW5raFVTUVFqa1cvaWFEdkk1TFlQaWQvdDA3RnpWUVJPakpQNlN5SEZpVEdL?=
 =?utf-8?B?clRaV3lNQ0lMTXFoMzNFSWNtZnlSYUQ3aFBPbytoZnNOWlJ3ekdvYlY0MFVF?=
 =?utf-8?B?VTQwYTFGdHpPRE1naWw3S3NDZDZIcjNXZlhJTkRIMjdPeHBpSmRTK0hjK05O?=
 =?utf-8?B?eGRYdnZlTVNadU1wbXd5U2xHdXl2aCswUXU0dWw3SUFJdHpsMENuNVRSbjZw?=
 =?utf-8?B?L3Q0M3Fvd0czYXVGWllFZEdLZ29kU2dTRGswRXRTR25jZmkzaFdjZEQvTEQ1?=
 =?utf-8?B?OGJicURsb3lnRmdtZFJ0Q3BBRUt6aGo4clBzWXFFYlpIRDZySklmM3oyY2Q2?=
 =?utf-8?B?Ynlid24weGRROU9KQWJRUDZEZ0VnekwwYTNvS2o3Q1N2dWtUS1haZExxVlVK?=
 =?utf-8?B?SWsrTzJKbGsrRlR4eng3OFppa3FOMDJwZ0o2REx5L1lxT1JtV05EeVFZY1ZH?=
 =?utf-8?B?U0lpSmlHenVqM2w4azNJOUJ4anFCTTVzMkhPMkpndlcrWnZiTDRBRy9hOHVT?=
 =?utf-8?B?QWpNbkEvK1B1VFhqbDFad1ArWkdNT3EvU3VpNnM2RnY1SkpvTUFDQ3h3d3cx?=
 =?utf-8?B?VkJoSk91cGtjejE0SDRzdFNPRGtMckl1aVlPZmRPMzBhUVYxdDQxOE5IaHI5?=
 =?utf-8?B?alFvTnlWdHJpNzRjMXhkbkp4SUZxdnh4aU1GTWNsWWMwd200TElOS1hsWTBk?=
 =?utf-8?B?bjh5ZVVDV0F1LzlIcktsZG82a0hpeDI5M0U3ejJ6MEFCMUlPOUFUTHdlb2lZ?=
 =?utf-8?B?aENhdWpOa0xleUxuNUFCSERzRFRMMzZXQlFrWUdHaVlScGdEOERaN2pGMjk4?=
 =?utf-8?B?bFhqL0J4VTErMVkycGd2c09zMzZPaDk5b0tBVDF5dW13QnFySDVQUHRwVVpC?=
 =?utf-8?B?aC9CajVVNEptbHYvUlRJa25zWTVaZWlZMHZDRHpOZ1IwdGNoYjlSSVhpZUZZ?=
 =?utf-8?B?QytRQStHSG1qckF3bFNZS25hV1l4MVNxN3ZVTjNhUy9tRlROSlM3cDZUU3Ux?=
 =?utf-8?B?MS9Wa1dnajE5Nmh0OVJJUldXbW1rS3NLWGRmOUZBanJPVlRUeWEva3dJTDNX?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f228bf47-50b8-4029-4215-08dbfcd5d420
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 18:52:32.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXHRqU4CwqURa4uFJM+YhH38JjeQy74mjedapyC/TuNbSZHcTwXce/Sp/VPN1tXhFsmtLqGxbrqulzC3YqFjrByrVGAIPUbJu70/AaH8s50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
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

Hi James,

On 12/14/2023 3:37 AM, James Morse wrote:
> On 09/11/2023 17:47, Reinette Chatre wrote:
>> On 10/25/2023 11:03 AM, James Morse wrote:

>>>
>>> No changes since v6
>>
>> If I trusted this I would not have taken the time to review this patch.
> 
> I'm not sure what you want me to do from this comment ... but this 'no changes' annotation
> doesn't work for either of us, so I'll remove them.
> 

The "no changes" annotation is valuable when it is accurate. When the patch
explicitly claims to have no changes since previous version when in fact there
are changes then it complicates the review process.

Reinette
