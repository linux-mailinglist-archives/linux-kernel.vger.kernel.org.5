Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B57E70BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344857AbjKIRtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344859AbjKIRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:49:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A956330FA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699552139; x=1731088139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AxE5Rv09SjWjd7HMWTFgQPE6zFOQdob3yNoFm8ZBvFY=;
  b=dY6GDLBrzPTZ/qClJPT5oxJQF1M3kQhiRb6JHjfJbATe+NwOqfTTGHFe
   BPC34s7+eCF+Z7gi5AaYbeQ9f7UfOCITmQLAilWoQgNPlJhKAovXwDx9A
   /vtN/osru+TZ8RCB9qdjkaxmJzWrctc9SQmeUoQQzM0UkBv437j5v9bVF
   U0DNxiFYd0scUBg8miZ/GaEh06ZgcgoeAn5j6uUuRhPyzYsT2c4+BOUDL
   T3OuGZPZGM2YC+JiqmPjL8FSv7NO7yZbXRyijPT2WwBY8uXL9QRsXpATq
   d6kXepb4WaONFmKJHH1O1fqtN9oHWlQ/FIU8QkI2XZc0IJvwRUANjfLCa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="8691789"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="8691789"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="792624488"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="792624488"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:48:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:48:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:48:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:48:57 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:48:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlqtTUNOD5nKfiXgTBH/QwCHzM/D2ZZNKrO/oHkxO/6y2aHo9ODTKp0sgNY3FeEKvHwQrrK1lk1IzwA9GXmICWz4RuG+6MFJLedbMdZIL9e/i/Or3h+KmFDKz+Y27h0q8edirWr+IOnpaYaSU0pSXsIJVQiFUVZFX0uUSp9rTc/jpEEGSTAm9hGUpbSx7jz3k+O5Gv9ydda/K3VVUpTkf00+7+2NZS+Ev0fFH/AzOEj4gspM6yYrjcPSa9KhCORTydpYyG+dOREpwnJT4/KC0UQAKrPRD6bFvNsmzNYEDd0RYpsNr7Dd6Cov9WlVdVKXg1o2sZWA49Ev5pLP5gdTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9akkl7QcIGaTip+4HwwvcBYGaZkd4WAj7QvFDvOLh54=;
 b=kkYlIcABJ9hGga/Ic12LAxAFy+XIl9V/sBPMonEJBeG9cUmGNLssjmHSrrcC56gpnCVfEKK9psG/mK+56bUNnU7PH4j3mHyIghooYMiv/TBtJ3FZBwkblihKeUmo6+FMZDZpozsN8HyyERdKuPjxZVNDycZ9Inz77/N9cJ+9cmsgdH7cSPFutj0x7ywDgDDzWkwxT6x1wqXr0n2iE7c3KmnYHC2W/buTJaJmUugOIt2CN80W0ew2RthD8eaKwRgnbzPfb4sQYFt9nzlMRbmgByE3dfwNve9Ajclx+UUavL9AsJMeYvxd8WenMa7BMBRRROTKfOngMVPjC/8ecnWi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 17:48:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:48:55 +0000
Message-ID: <b4d33d06-9320-4a32-b2f3-4cbe2ae52a77@intel.com>
Date:   Thu, 9 Nov 2023 09:48:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/24] x86/resctrl: Separate arch and fs resctrl locks
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
 <20231025180345.28061-25-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-25-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: b04639d0-5924-48d2-0357-08dbe14c24d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFkSFRxMhfFgSJTBMfgIZm6DHe/2UNSEXaA3pmd0Yjlmpdo1/gBA8alNMBdbXRvTbbOQSRl84Gvc/zSfvhjdjCTmziWoG5VJ9odysi53CAPcBY53euVS+Td4YuQNeSWkL3vG/61R9moIC8IdT5gDRju+Rr8s2G0OEJj/1AUxMdROgStw7oEK/OqGMTcC3Y8m8BjedfNWpb7V8WcwxqHK7v1PAOyMz2AXmnKu0M7q+8lqddzK/Iyv3QgqY9yPWDULehU246pTAL++0DYptXoE0M1IYadVnIl/obq8fxtbmjCPmnh53D8Sbe51wcnjwat7AUzb7znivbKxTcAiG0C9MgosDAZrpCHleiuwWJuxSbC09DbXR/F2Ix9RsxpWLqbbKwZszn19aRl+79wqzm6YWDzGnWHZeRU+wTDppAY878UfrRQ91iLQAQUy0OXBgbBQW+N46Mcd3pH7Iqjq8r46YYIvmFFh3tu/q9dHuSOgBR26pY1mPj3uMyWvZD/Tc8UzDvUS+QIZCyT1K+424JnrDOxw5qqNuEiLAwHyvnEy9bxcRLNP1xd4IqeeRAQqsTiF2nNj276H/9MEtpLqEHhtwlb5eOY9U1Mo/on4NTWJ3CseCd8YAF2MwFVf/DNrI3c4EcQjN6mJQDwVg2vNnwVhYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(82960400001)(83380400001)(6512007)(53546011)(36756003)(26005)(2616005)(38100700002)(6486002)(478600001)(31686004)(66946007)(8936002)(8676002)(4326008)(31696002)(66556008)(66476007)(54906003)(316002)(86362001)(5660300002)(7416002)(2906002)(66899024)(44832011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElmTXVFcWkyczVaSjBnbVJtYzlRTVdYTGxFR3kxRVB2UzB1cVV4UmZJMi9S?=
 =?utf-8?B?YldhcE1Gc1g5YW54WjFpbTE4T2FrdkZvMmtpSm5hSCtoc0ErbkoyUDFwT2x3?=
 =?utf-8?B?Yzg5azdScXd4a1A2dC9sVUlUbng0TG0vcEZxWldRWTJsK3pMUGpGaHN3SVVs?=
 =?utf-8?B?VUp4UEp6ODRzZkNWbW15cjErdWNIdVhFYlljVlN0SmZkVUx4QUN3ekJUdENY?=
 =?utf-8?B?MkVyMHFpYUNqYWJQa2RMSUFzdGRXbUQ3ZTdzZnRic29XdUR5dGFuQmFsQ0tZ?=
 =?utf-8?B?T0VCblp0ZVZ4R2FJMXo1UXpTL1RwVWlpMXE3Y0tnVktHcXJxTC9pTzRCZit1?=
 =?utf-8?B?MWt6TU9QT3d4Rkg4VU0wQU1BTUVvb0k3WGJ6a29tVndDRUJCYzluSUViUDgx?=
 =?utf-8?B?SWd0bjJFMkdtKzhyWUVFWDg1eVJKOFVvOVZINk5JbEo2OUZJeFNOdmJ2UFNj?=
 =?utf-8?B?VndWcmNZYkM4NHo1eHYvN3hxRDVUanlCdVRtN3U5NXFVNUtWN0ozTTJhaktw?=
 =?utf-8?B?RjRLd3IyVUtQaFZBek9ROVNuWUZZRDUvSXlRWlhJR2dYRFM2TWpSTFFTQ09K?=
 =?utf-8?B?TVhncGYyZFgzMGVoQkJ3WGpVL0FNdGk3YTdwTWhFdzNKUFRlY05aaVZhZUFY?=
 =?utf-8?B?UFNaTmg2dXphcys2em1uMWR3Ym1laitGeTZqNVBNSzdaZUdhcDF4bWI4bmV1?=
 =?utf-8?B?ZHFiMGhOb3hEZ2JLRm10YU1qd2JXQm1FdnhnZEtrS2dRZldzZFJSNUhlbFoy?=
 =?utf-8?B?M2tvTGZ3djhuRm5ia3R5MzBOcmRxVm5HWWtkbGUraktTZ3hZZlZMU1NycHNG?=
 =?utf-8?B?UHFvNEhKejBpc2lCVC9mcWcyWnhRdU5RVU9MdFVSMitWR0JOaGF1dTYvdVF2?=
 =?utf-8?B?c1R1a3V6NVAzSmRTSE9INjdnczdmV1JjZ0xBQ3hqNUJsMnJTVVlvYjlmY2NL?=
 =?utf-8?B?K1NwdGJtU1U5RW16L3RmcHZ5K2ZvOCtVdURsS3czRnNoKzJrRzhqYys5dS92?=
 =?utf-8?B?dUdLcDQ5eG0zRVdraVhHSys2VGRUN3RsV3NRRTh6MEE2QjJnNFpFZ2Q1VWow?=
 =?utf-8?B?Q2ZTd3hORVJYaWNuaHJsRE9XWlQ3K01ZNXA5WWNVUXEwUFJNNTkxTWV3YTJM?=
 =?utf-8?B?NExBQTZlVnlZNERUeWxPR1psMVA2d29QTnhhWGZCaE1ad2xmSWs4MzJpQ3Rv?=
 =?utf-8?B?KzV0b3QvY3R2L0NKWDBrV2pQY0RNemlsYTJrL2YzbkNxb2x5NDZIbjA4cExi?=
 =?utf-8?B?RS9ZSDhIdjlMMGZiNTJXaGpGYURZeitRSStTTDIyNWprUnZEQVlsTVlrWUl2?=
 =?utf-8?B?WjFEdjFna0xzWk13L1V3bVFwZnVsaDI2L2Rtbi94bWdJWTNxZUNJL3pxZUZr?=
 =?utf-8?B?bm1uN2VyWE5OSVRmSWFvRlhSeStUcENiK2FCc1RJb3JWdGM3YVBUQzhIUFJk?=
 =?utf-8?B?b2F6MTRIZlltK2Y3aGFKQlQrMm9zcnhvWXA0UFhuaGxzRXNJUnJFVHlmMXQy?=
 =?utf-8?B?cG05Uk9iZ1RrOTArSERlZmhTYWozaFYrbXJ3cE9VNHdvbmVsSzdtRWFXMmlJ?=
 =?utf-8?B?WTd5K1dmdm1nNC9TWjlHRnVyeGpFaDRISDVmYjZ4b29EOUQyUVNXS28vTHcv?=
 =?utf-8?B?bzVMaFlxY2grWlZ5K08xaG9DYWF3Y21CYkxEYndEcnk4VEhGMWNST1JpZkV2?=
 =?utf-8?B?R2x2YkJRYnpqUDVvdk5ySnVqSVl0NkFwNWRZa1RZazhtWnZwZkpvcGVkSCsw?=
 =?utf-8?B?WERRcW1GYktxRkZoNXRxbWdRbFV5LzNLOTJSWlNnSWlqK1RBRmVRK1dxR0Nk?=
 =?utf-8?B?bVNaNE9UR3lKV1NyY2ZUKzdrVHFGaDRhbjZ0ejBtODRaTXJzV2hzSmxBcGxS?=
 =?utf-8?B?eFEvNG9ndFpTY05xMzNpeks4emNJZHpYSENIZUVuN3ZJcVI4WTZNVVBXRWxI?=
 =?utf-8?B?MDFQOHd0aFFjUXZBQktSS21jQ05rQ2tQVXFXdmdFWmZudDlIZk4rbVZUUlhN?=
 =?utf-8?B?VjBkNXNvSmUvY0Q3NUxSb1Nkdm1EcjF0emVwOVl3MmdPVVp6WDZ0L0ZucWEr?=
 =?utf-8?B?U005R2E5YW1nUXFqVWNPZjNvbG1wZFhWZ0ZsdnhCa3YxRUVjRUFZbmdkZ3RI?=
 =?utf-8?B?djNHbmx0cnJZeGEzTWZJV2V4eTJRR2N4ZlZTQkRhdlNMTCs0a2xqSngxZGRv?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b04639d0-5924-48d2-0357-08dbe14c24d3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:48:55.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bP/cWIO76AefUMDeNr2NSGdeluJbhwRHga+WRfi+gZrPv9QFg/zgRSYhy0drqbN4/Sx2fbaoQDhy6uMPbNJ7m9xhrY/FuZqLExgqNhEFmjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> resctrl has one mutex that is taken by the architecture specific code,
> and the filesystem parts. The two interact via cpuhp, where the
> architecture code updates the domain list. Filesystem handlers that
> walk the domains list should not run concurrently with the cpuhp
> callback modifying the list.
> 
> Exposing a lock from the filesystem code means the interface is not
> cleanly defined, and creates the possibility of cross-architecture
> lock ordering headaches. The interaction only exists so that certain
> filesystem paths are serialised against CPU hotplug. The CPU hotplug
> code already has a mechanism to do this using cpus_read_lock().
> 
> MPAM's monitors have an overflow interrupt, so it needs to be possible
> to walk the domains list in irq context. RCU is ideal for this,
> but some paths need to be able to sleep to allocate memory.
> 
> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
> of a cpuhp callback, cpus_read_lock() must always be taken first.
> rdtgroup_schemata_write() already does this.
> 
> Most of the filesystem code's domain list walkers are currently
> protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
> The exceptions are rdt_bit_usage_show() and the mon_config helpers
> which take the lock directly.
> 
> Make the domain list protected by RCU. An architecture-specific
> lock prevents concurrent writers. rdt_bit_usage_show() could
> walk the domain list using RCU, but to keep all the filesystem
> operations the same, this is changed to call cpus_read_lock().
> The mon_config helpers send multiple IPIs, take the cpus_read_lock()
> in these cases.
> 
> The other filesystem list walkers need to be able to sleep.
> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
> cpuhp callbacks can't be invoked when file system operations are
> occurring.
> 
> Add lockdep_assert_cpus_held() in the cases where the
> rdtgroup_kn_lock_live() call isn't obvious.
> 
> Resctrl's domain online/offline calls now need to take the
> rdtgroup_mutex themselves.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

