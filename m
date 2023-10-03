Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD89A7B7346
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbjJCVXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbjJCVXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:23:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A1FB4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696368224; x=1727904224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=64sYlZkd5+Aj69xK/UkuLRVtDFqWxZQOQ3/2EtSHlFg=;
  b=ibicRVEE+w2CtkVFERfkYe/nU/klLajHXM/OangkfANGfx14b0P8q2eJ
   ZsUWr9LDu0RpGj1/g0o5N1W46fR5+tQH/2DRdunxr/4qE0gPtELeaIbWZ
   Bo/tIB5sv+omnIlOZjEGahBV6hJTBXOOcpHU4qSw4NHTUl4ceCuB4miH3
   M1ticgX/wtk+U64Dh/fmNx9D3ypg6haAaHTZE+DISl4ZiyEVIx6PR8OA6
   I/kKgZW9/kE1YJEJtjKKdeYqXSjJIxME6/V1fkV/UmzHJ+lAJvGuVwMMj
   oQEBoN6VmFz9qttxW4aOI/3Is4wfgS7CmMwma7SQWe6gvi//0grV0bEie
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1579058"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1579058"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841507262"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="841507262"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:23:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:23:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:23:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJgGm7NyWDBbHa6ffYvPZb/ySBP6sTmlTmo3AxZmxxXr59gqOLx6hjN3JfXRO+aHAtQTUphBhKa0H+D/bOdkqP3nrToWHVgZXIXYP4v84IGSQqZnsJwQeDk50AmPg5FihNvKGLoZyMKvQ9brkbWwK0MZXyDCPKaD03x6/R0x/1qaqen49JU6O39Gfh1Sy1vR33izVwaNYxKcYWoboY/aZwQSUSykb9HlCH9j/LaIhmQRF/QWb0w4Jw3PWzKEMzsrXiOnl4LCyjEVuAYnFJL/EAaIK3DiBXz3s1rc4uxkVFtoo8cSoI79eEIIQTlkKr2OmtxOMMJTlGwG6FTci2mhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMftVFIyyJafGLQeVPYPcgwKhrN/k6ejNL7Hv/x6Sas=;
 b=au3mYSNeAY9zMUnKDJCntFhkSgnjvQ5IoOkJRchfq7ikaxF36AEe58eaB7ts19rxaPJ3j1denDanPi5uhPB5LvqvdcZuTIo+KvLvkf1KFip/6SjrfW7GxugaP4bvXlODNSIkeDKAjh/HrHSpQi5JPf4n6xPvJpu1DZ3NZUnksfqLe+rCc0FwdvBbL948t3Zyo07DJbwrWJRIJMTsqVo+ZNz6izQCHRwyTHl4/HusF+5OEEETHuwwjIF0He55RzlICw1eUOlv9N6E5koV2Tqi4nV4+d10nkRRNkxKxME1PwaQyvfsmU8TeQfjy6fIC8/1JurRRBwmtLXJ8GjdFPckQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5175.namprd11.prod.outlook.com (2603:10b6:510:3d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 21:23:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:23:38 +0000
Message-ID: <f6d476e1-ce8a-e680-b9ec-d5c2d78bc387@intel.com>
Date:   Tue, 3 Oct 2023 14:23:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 23/24] x86/resctrl: Move domain helper migration into
 resctrl_offline_cpu()
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
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-24-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-24-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0323.namprd03.prod.outlook.com
 (2603:10b6:303:dd::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 107347aa-32e7-420f-12d6-08dbc457022b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8lNZQWN1EXLJ66DdRPeBLHkb1BSg60PcjwZziWjMwe42bBgSF3SxoG8H+gPj6pZObrKQZMhwYbV+Yezl/vitOkMqGgLzNs/zpnd7ZF3nuk4yj35W7gPoki9NeQz8nqhvUrI06fzuHXvtGvF+SyDXo1hS1CPzMdG2SqP3uXt8pLaK4WeAJpVyXbI2xoD0Ka8RIuTcF+tgBsDB2Y1KToUoqD95tJRlALutvIuepcu/v18HtQ+zzyot5BDV71z1NsG8z6087b8Xq7SpIDZq9ERLSwegug7fPGli6z2oB/T+qZLaVozhWRjzuOvLehFi4XEg+XWijxW2nkf+IsvzD755EmQVD5zNG/n6yRtjMiLpJ3AR9pGGSrbg9sz7qSQYgeKwnFHkdYulh7V15n9QaFdWUBQjbaWUE0qVGSWDPwZjKEz4uvRlO4xp4KYWN/ezisHth8Am0lbKOmI4v06bskVMMqkrBMnCGo2E3t6fPN2AHk6B5YKjo1TuHWY9Ll4OvnQoHoiEsHEkH0LbvP1f3G7nIaFGDrfEIgREOwgftjINtWucpE+ojh/zj0jP6LOFlIzf19a28RKK8yyK0kFzheucC8O8JaMHlU/7qNaVxBuUALEQX3+K/Cazq2Qrd8Ar8bEB6bDcn1uKgSK6mM0O4qHMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(2906002)(7416002)(4326008)(44832011)(5660300002)(316002)(8676002)(41300700001)(8936002)(6506007)(54906003)(66556008)(66476007)(26005)(66946007)(478600001)(6486002)(2616005)(53546011)(6512007)(6666004)(36756003)(38100700002)(82960400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE4rSThrdmsvYjQ2aStRdU1DdTR3bWtXdWJoVU1WUjR1djl4U2I3QW9EYWJO?=
 =?utf-8?B?R2tQa2FmdDFJdlp6QVlZcEVVMU5XN0hremRKNWQ5cmRQSzYxbXpKR1JCTXZm?=
 =?utf-8?B?RllsZUJkVm9FTUYxZlBLZm1NRXU1dXl1MlpISDhEa2NjL29VZnlHaklNYyts?=
 =?utf-8?B?QmJPTDZ3VWFqd3RMd0NodEQyMVFBSWRqTWVmWDdycWdxci9GUTRiTmJjQzcx?=
 =?utf-8?B?bFRmcmwvcEF6Mks2U0Y1NlBlMnMzYXVTVm9OV3RYWE0velJrSi8xTHczd2dT?=
 =?utf-8?B?dGJFdWxBL0kwaVZkUDdnOElRaGZTNW8wMDBMTzdMTkFuUmhFYkVkZXNnV2dN?=
 =?utf-8?B?ZXo2KzR3R1R6b2dTSFhvR0VIQ0U0QjRpd25OcGdPTVhCenN5YVphK09yUXpD?=
 =?utf-8?B?Qm8vSXRoZnJINGIrTk9uTDJBRXVadWMvWEFubGtqNUQvZnJ0MVZhZ3JlMUZt?=
 =?utf-8?B?SEU1ZWl2TzQ3bFk5VlNEZjBLMWd1d2lzRVh0ZlVUSEUrSFRSR3U0M3pFQTlN?=
 =?utf-8?B?aER4RWxZUUpyelBHZG9xV29wNXYyRlhNRnRaM0pDcGNYTnJYUnFULzZqdGFX?=
 =?utf-8?B?Y1dnUE9DZ0sveU0wa0NKa0ZDM053bmlqazdDSTh5eUc1R09tbk9Rb3QwN1pF?=
 =?utf-8?B?VzAyK3BjYll4ZDBFQm1ZTk5FOUlUenBhOGVRdGh3b3ZDeU1QOUhNY2lDU3Fi?=
 =?utf-8?B?Nk9STFZjR0xMVFhzOUVjaTU4MERKTTVhckwvbXE1ejU4NFZyODNOUDVQM3Nk?=
 =?utf-8?B?VzFKdms0VVJDV1BxeGtnZW8wdWRvaDMxR3JScVIvZUJiMXhlN3lKUWFKOTV6?=
 =?utf-8?B?WXVSOW0vWjQzaGxDWkozS25mZVRUdnZuYThMRzZsZEZaSVZ4OU9iWGZOeldB?=
 =?utf-8?B?STNoRGJ3Uk4wV29COUJMdzlGUkUyTzBHR2Q5d1E5ek1ZVldRSU5JTmRFWHFa?=
 =?utf-8?B?bEpBcGlMSXJQYTBDMWpUamgzc3VxUTVqc3Q2SXphdkFlQ3RNWUdTV2lzVDRD?=
 =?utf-8?B?TzhJOWV2dG1zQTEydFZSK0VNSk5RaUI4byttUzkwenM0Y3Nub0VBRjJNbXNo?=
 =?utf-8?B?NVpVSXFrY3d0czZPN2NGT0l3TUw3bTQ1M0JTa0tZSnAwS2VNbkx1U2VVQnhl?=
 =?utf-8?B?d0o3bnN4OVBjdmd6YStqeDErSHNNTS94bHFzZFBtZ2IvK2dHVVYzZTZCYmxP?=
 =?utf-8?B?REIvSjJKcHp3TURwNVdlSkJiazlUdlBEc2U2U2VHazJDODZ3RnNldnFDbmh1?=
 =?utf-8?B?NFNYYTlNem1WQTEyZXpQc3EydlIwdzJBZGFQRjk2aXhjSXBVTXhhdzFWbmxB?=
 =?utf-8?B?R3ExaHJZNHJFOHB3OCtuUDBad3pGQ2pzWXVMMUpJMU1OV1dKejM0NWZVZktN?=
 =?utf-8?B?bXAvRGlXWXVaaFJPRU5NRk0reW1YL1UxQkFMUlE2dUQ4bHNaNUp1V1ViNWZL?=
 =?utf-8?B?Z091aHIwb0NmbUdJSEFGR1ptSUVJTmk5MDJDZExkUEdLMVpzclRreVBOQ0ND?=
 =?utf-8?B?dWJTYjN3WnFxd3Rkc2JRa2hYTllBQzl4U0s0cUpRMys2aHAxLzhSQ2JhK3dn?=
 =?utf-8?B?dVVpSEltSlpvTjZUdFdsd0ZXaDlOZW93ak44cU5PUkcyUjFGcVpzRVc2ckVD?=
 =?utf-8?B?M0wvZWpMWlV2NURtUWsxYlBJUnpPR3Rtejljamp2SDJyRWVNRWdCUDdub0Vy?=
 =?utf-8?B?bklYSEowT0xDazljK0JGRlBiUklucmFURldiN215SDl4L01RaEI4cXVLZXdq?=
 =?utf-8?B?eEorcXNUbTRXaXdkVEZNV0F6enU1dEpJV0pVZ0FEay8xa3ZUL1RUdWRidUhL?=
 =?utf-8?B?cGVVNFNHZ1paNzB3M3RXbEUxb1Q2bm1OaWM3SWJMTEd5bGdIWlhrNEYxR3Q3?=
 =?utf-8?B?Q2swc2tNbldWRGtuVE12RCs0TjlLczRUQ0xCb2V5WVZIT0RadzhPMi9TRHQx?=
 =?utf-8?B?QmhobUlDNXJzcWtwL0NsZkxkSnF5YmdDN213ZG51ek52SVBwZDY2VFNKbWFI?=
 =?utf-8?B?T1hRYVlNSFpxRUdHVmJ4TldxeHliZmlyNFlWVEpiVzhsSHFERWxxWGpyMGUv?=
 =?utf-8?B?NWFiSUJXVEt1Y1o2aGVEcnR5NlZRMERIZ2pGWjVzYkJONjZ0S2IweXEzbGtV?=
 =?utf-8?B?RTNmSFRZYzVJeGFtM3VRNXFXUXVKNElodWt3WUFIajByUDU0b0xBTE5WRkJr?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 107347aa-32e7-420f-12d6-08dbc457022b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:23:38.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIDwfIqcAP0PQdC8GgrSTxmXdllIC6tMvEyLQJ9VRkAshP/OB7Yk5lsiqcn1hPkE6tXAS+vl47wr1Y1p4tZ/5uwBqEB/OD7Kr0t0bMyH79A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5175
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> When a CPU is taken offline the resctrl filesystem code needs to check
> if it was the CPU nominated to perform the periodic overflow and limbo
> work. If so, another CPU needs to be chosen to do this work.
> 
> This is currently done in core.c, mixed in with the code that removes
> the CPU from the domain's mask, and potentially free()s the domain.
> 
> Move the migration of the overflow and limbo helpers into the filesystem
> code, into resctrl_offline_cpu(). As resctrl_offline_cpu() runs before
> the architecture code has removed the CPU from the domain mask, the
> callers need to be told which CPU is being removed, to avoid picking
> it as the new CPU. This uses the exclude_cpu feature previously
> added.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
