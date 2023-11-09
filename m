Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5BB7E7075
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbjKIRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKIRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:40:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FE3269E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699551614; x=1731087614;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8T0h9gp/JNOJZJa8iu7XkIsTVli+v8DC642O/OdoPAs=;
  b=lbwl0pz8gI6Etq5Z9hDz1migBS8+M7C7obXtja6mSLdcpXaRQkZ9fmSS
   XkW8GsZgJHvy5tZ6cN7AOxT2J3kb8hbpXltWMFxlQgWg8GiGw9xIB6fUp
   XL8DHwNk3xiuzdUReDgQ4fY/2Kq3yebPAt0f8aW50tMtElkDeNwLLHu8p
   /cQ3/PhecXL+RPIcn6vWnlA404J+gU/teF/Au4S86X30OWeYgm65mfdqB
   q9nM4qYX9P8/jZTEMpee8qqzOwLg/m5+ZsjkVroWjDhasxAtFo4aWYrsE
   OXTP41MFjMrYy9q2izX6vd6lx45qkzhWPWwZOx/6P0q6c5wjmQ2cDZt4L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="454340076"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="454340076"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:39:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="4790800"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:39:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:39:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:39:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:39:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRjV0QvaokxDKZlo6/YX6/FFpoTqLZNc3DCLGfQ6APvPnpNY5p8lVuSXPtgAhWeXJ3EX9vfe9jfm8se2UEwojmyibHmUhJ6ysO8hlSHDikQ7yHofEpOwOymWmAuwaknkDhDQBSrIBortsKIWks+J93FPewL/EBXbrbzjEmXXzFsvENiqETC/2pN1N3EA7oKO5lNhpYk88xuZN/XGVI85hmKfJ5V3kxUCo8Bp3r7LLOGF3peh4KUhds4KKrW9xSXOUDvLuBrUYKrnRrgQLI5tzEZTyg9Q/wmDMFDEGwuCwKmvDgXxaSKRxlXBAqilGGdCABHMNpHizaUyp4iJeqYymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyD4fi5QW3wKrdWZIw+sWa9xjnvX7DbzeWLgj1MJp9k=;
 b=bbh/W7SwoYPW2VhfCaF/uclpl64I4+4ny5DqUQ+CbwNyNh8XOH4r+cp4GNHDUv3xaaVZIh/hWREfAVhTHJZwIj+5hn8DkeH/0s2oJM57JfcSfB5MStbMfVus/LndDz5D0+huaS3Ts8jjzcMHkzqLax6I9+ntpFXtZOV6vwjP9dsV43/u5G10APbkX1xqwfZ39GR3qFDdsmvOY64rYvWpG2wlm3KEzaXundz1IWZtnvG0LFZL5IiQEYaFBuOOdkcDzS9DJ1fIX2DJ+Kislr6ugfOTDy7DgsyNfzHEWhEBBF5oVJcuvPjL1tQQyCXS36xQn7+gqYEUiw3SgAdrZktNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4565.namprd11.prod.outlook.com (2603:10b6:208:26a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 17:39:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:39:47 +0000
Message-ID: <208c3ade-a8c3-41cc-b136-4ab9b7e938e5@intel.com>
Date:   Thu, 9 Nov 2023 09:39:44 -0800
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: e99e7a6e-2840-4a18-41a0-08dbe14adde1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KeFIuO+bt+5oW4BaIePd5qgMcht5JerGONbq5skafOIGEyUr7oxrn0aHZ9KL+XYdVmzssfzXwwAggBrZTGcU7mXAlzhJbz2NvZw55J0e4fPqhKGG+5VoXfmQnr1iwkNskCjPUrm7RT26a5nB2yNGZO2ae/3PtBHOHsUzvH0OUpL2pqKsTV5dxW1rtgf89Hg8vjc83Xaa+JZlvW1mIDXaZaI2TV1hpal23uyx0cmipGsKWDns2VtZ3pu9xY3Lycj+tsVY5xmWwUPi5A98eE9HS9gYo7iUjTShAUru4DHJdKUPv5RoL1Z2N5ylJ9q94P+QmzbR9A1oX63TrdLi3EJysqb7vm6fkS/RZnCFnrI/xok2guLxB1ib1MLljxO7P/VpyvPFbSrC/hkSrFYxQVcvL3EjM1SXpqm8uXig13ScwqTYaD/WjF1XQ8d8kDtGMp2J4V1Ph3ktpHKt/EtXlGUz714kBTA0LtexE0EcGfCBbB9dEl4BkY1OCQlk4nmGGqD3vEgbyyJ1a+uU/6m41HUhKq0V3KvP5ULJRCEkcB75TJq5GLweob/XaU38LC7Q9ElwzeXk/Uv03SsdOlJSkY6yUz0wSM2voMzj+g1ocAzfo0tS4KYch1KLuCiflsUq58mRM1WNs7ZXYjTXh+21FAPWhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(82960400001)(38100700002)(83380400001)(5660300002)(31696002)(2616005)(6486002)(6666004)(478600001)(53546011)(6512007)(6506007)(31686004)(36756003)(316002)(8936002)(66476007)(66946007)(66556008)(54906003)(8676002)(4326008)(86362001)(7416002)(44832011)(2906002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0hZZllCLzJXcHB4Wm1WSVZwNmtOQmNMcG1NYlV0TWZaWkNIR3FmekxLZ3N0?=
 =?utf-8?B?OEFVYnJacVVlSXRuS3lSdTRZZFJWKzZsQnluVDBFeGRONTIzWHhORUNjMFNL?=
 =?utf-8?B?b0JDRlhSWWE1Zzh4RVkrSWMrTWVTYnhlM0dJdzNsVDR2cmdGemlJWHQwemlu?=
 =?utf-8?B?b2pzUDhkYW1VVk8vS2xHWnluVW5vN3NmUU9OMm05NDN4eXFmbG05MjV1ZW5m?=
 =?utf-8?B?RklxZUluZFVLbTdHdmpiUmNPR1F1RS85d3h6R3htZ20wMHBlMEx4cEFSQkhy?=
 =?utf-8?B?WXp1TkN5eURxUGtTM2FkM1dWK3FDeUd5bGlBWHhrWGpUQ0FTYmU2MWNtOFFZ?=
 =?utf-8?B?SjhmTG4wRzB2TkZOa3ZIdlQ0R1YrMUMwTGZraURkR2U0MjhXT2svWFgyaXNu?=
 =?utf-8?B?SUljTDFGQm4zUnV2STJQUHMrMjZOYUZ6Q1FjNDVmNzVES3lSdlZmSlVzZHZB?=
 =?utf-8?B?MFdEengyVVZaRlpzYnpGbmRmR2ttckhTMEc2eS84LzBLZ245bTBlMlBQOFF3?=
 =?utf-8?B?RWJhRk52dGZDYW9BdHZCZVh4ZmZNdVVLRWMwQ1FqbllOc2FkTGlyeWRQQktY?=
 =?utf-8?B?dWxzSjVMUXdvaDFlQkVWNXUxMHl2eG05LzllMkVXL0o0cmw3aXZMbDVmQlIz?=
 =?utf-8?B?MDJIN0pkU0puSmtPdW1RR056c0t5dytuaUVVdmN0NERESjJPeGprcHBoSDVI?=
 =?utf-8?B?NC9aUnlzT3VMQnhvcGZibU5iYlYzTXpZUUs2OXFUaHYvV2lEVFVGdTkxc3lO?=
 =?utf-8?B?Ynd4aWlSc24vU1A5cVhmT3dMSUg1UWphdFEyUnhwRTZTa3lESEtaZDdBRFcw?=
 =?utf-8?B?TGZyOWxYU3ZtMEpIaHJKVzlVT0I0NFl0VUlYOHM5ZmtGbkxIc2dlUktZekt1?=
 =?utf-8?B?VHZ3Q1V6SjlGdjVJNFpCbE1rODJDVkFzZnBCaVRGcGx6bDBMclprbm5kVTJx?=
 =?utf-8?B?YmFIamozK1lrTlNLek12RnRuQXJwQzlrNzhpaTNxVEJXblUyc2F1Wkc0Q1Ro?=
 =?utf-8?B?Y3pzNThpUkI0SG1kTU40aU5pdm44eE16SzFpWkFIUVlLSmZMTGMxcXJIOU5M?=
 =?utf-8?B?V0lTQ2RJeEh3VTRiaDlMUGQyZ3U3UTBnejBncVM3UzQveUplN0Y0anVTREpa?=
 =?utf-8?B?RllsQ2xDejlva1BoMjJNQ0ZRS1Z2QUZHUEM0dEkyVzJRSVB6WUlBVmhnMjhH?=
 =?utf-8?B?VGxTWlZLRVFIVWFDNGlhSjE0QkxldDFERzc1K1ZJU3dCRWQ5bWR0K05JeCtt?=
 =?utf-8?B?bWNvRFJnMjNiK0NJa2dKWmhUWjVTMjEwZDV1WUZ6MVI4TlR1YXZwdDVFME13?=
 =?utf-8?B?eVNkalhrSWVFUnVtVFQ2NjFLRDlUanZua2wwSHNvcDd0VGJvelBnTm02bWN4?=
 =?utf-8?B?Y25qTHE3cmcrbkxudHRoaWttUmk2WWpYSnovTm82NGZsNFF2bnZqL2Q4Nk1r?=
 =?utf-8?B?M25LbzZtSDEvaTBnOG5TNVdHQk9qWHc3UlJFSTdMd1FNc0tmdG1hS3VVek4r?=
 =?utf-8?B?TTdqRmFGOXdla3cxKzY2dnpzZUFSNWorcUhYSFBSZmUyWWdKVVMwMWgwQUJS?=
 =?utf-8?B?ZkZJaXhjNlpMN1BVZzlNS3BUYnlWZ0E5VEZaRnBScytEUSt6TndxMmpVajFZ?=
 =?utf-8?B?NkY0MTczQU1pem00SWVYQllNaE5QZFVnVkxSaEhFc0dXSXIwMjI2UkY0NEhV?=
 =?utf-8?B?SHhDTDl4NW1LUUhIQXdva0dxYzRybktwQ2IwSVJLYldoWmpxTW9QZmFraFIy?=
 =?utf-8?B?Z1RmbmdFcWx3bTJuYmlHOGh6MWZTWUhUQVV2VVpPQ3N4TzJFbkJnT1JTU29t?=
 =?utf-8?B?cXNhMnBHMVM4SGMyTWdJVTV2eFZhMENJRFo0K3dMcnpqa21pTmRxc0tWWXpM?=
 =?utf-8?B?K3ZqcEg3djEzK3lWRStST01SVHZvQ2dXcGE4b0FjbzR0akc4eG5HR1JsdWRo?=
 =?utf-8?B?YUdXOVE3cE9UMFpIVE9QeXdWUkdDZU9ycVFMclNLNG5DRUxkVGV4QXRwWnNu?=
 =?utf-8?B?QjVkZ3JxbHhSRndRUG9HdVhTdGI4bW5VK1d4MUs4RmVyWGRNdW50Sks5NnE2?=
 =?utf-8?B?U0VrRklqRUpIcFFpNHlqaEcwUmU0elZUclR3amtqTW93WEltaDVrMEZSTy9p?=
 =?utf-8?B?Tzl6MTBVZ2hRUUlKUDlWSFE5WXd4RytnT2U2RjYxTzBxQWpsZTJzZURzMnpD?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e99e7a6e-2840-4a18-41a0-08dbe14adde1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:39:47.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bk5NlpuoAzno5Egqv1FNPo17Ya+53CIoXMgc9OoEQwSEBROTIIDvAAAPeMoPM2DpE9h4rnZGXhPRNffqxlYJwLEBASkSTPdm+urMoBi/U3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4565
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Subject refers to rdtgroup_exit() but the patch is actually changing
resctrl_exit().

On 10/25/2023 11:03 AM, James Morse wrote:
> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
> 
> While the exit text ends up in the linker script's DISCARD section,
> the direction of travel is for resctrl to be/have loadable modules.
> 
> Add resctrl_exit_mon_l3_config() to cleanup any memory allocated
> by rdt_get_mon_l3_config().

To match what patch actually does it looks like this should rather be:
"Add resctrl_exit_mon_l3_config()" -> "Add resctrl_put_mon_l3_config()" 

> 
> There is no reason to backport this to a stable kernel.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v5:
>  * This patch is new
> 
> Changes since v6:
>  * Removed struct rdt_resource argument, added __exit markers to match the
>    only caller.
>  * Adedd a whole stack of functions to maintain symmetry.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 15 +++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 19e0681f0435..0056c9962a44 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -992,7 +992,13 @@ late_initcall(resctrl_late_init);
>  
>  static void __exit resctrl_exit(void)
>  {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
>  	cpuhp_remove_state(rdt_online);
> +
> +	if (r->mon_capable)
> +		rdt_put_mon_l3_config(r);
> +
>  	rdtgroup_exit();
>  }

I expect cleanup to do the inverse of init. I do not know what was the
motivation for the rdtgroup_exit() to follow cpuhp_remove_state() but I
was expecting this new cleanup to be done after rdtgroup_exit() to be inverse
of init. This cleanup is inserted in middle of two existing cleanup - could
you please elaborate how this location was chosen?

Reinette
