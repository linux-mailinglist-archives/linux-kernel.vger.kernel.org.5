Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3ED77C62C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjHOC75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjHOC7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:59:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6C2173D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692068369; x=1723604369;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1tet0F6MTVOHznLUt6ElRMnhWt6LRQ/dj7YgJ2a2Yak=;
  b=eXwxtidlCM7EUf4E0S/3yrRWSCnKsVBn5zFiTg8iD511ffJ7KOk+UGaq
   31tETBz2axPKCv1ghONXgXrd0FWmwxiyMJO4oDkNB8FIPitK7c+EXThDD
   3dAevtrYOgZ/0VULqGO5dzJiyYX+wE+Oz5JB6H557ogQlijR2SpYSwoWu
   o/U/mq9fzyaQme+rq3E/0oYvGm26KqTNy0M3V7P8AER6SlIB4J58AzCnK
   +Lti2bGNg0yDFzuYrEaPsfriSrfbtEerNo3O0FplcIcewWkFbQP+8LLhi
   7XXtEypWo2GICmfIvBZf8xBmlldGH3svx/sYp9XupT0OnvRwlp/M+BZW0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="351776404"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="351776404"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 19:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="710571422"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="710571422"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2023 19:59:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 19:59:27 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 19:59:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 19:59:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 19:59:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd85T9UC/2IjO/bbNSeX8enZrF2wzdRXlN/Fykd7lAKcJCgkZG5EEex5b3YG7yeRL9b6q50q/ezoVSR68CJX3HR3K5Wyr6Lgpr15OKRZItlFtUoQ4HBcyr9CNz9Kc2BtMbHH5+2eNFUqurqAKIN/WxGg55QGuw//8HdON9v0dlJzIIEoa8MPl8xeWJa4T/o/oiDZsczICHd8EtByZbtUmGwacUY32VHP6WpIJRQYwudJRZbH5KxgWh/7eqjmi2AZMbYQT24HJkl/uILeLE3/NGTIIPwIa9eG+oibSPSN5JPb4Lx0lPd8t3FWIrQJNK+2KWtUCVSJ4MFiIgJOtWHlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ximnsuUPoA4YsvO7WP30hOtm6A46cq5LWxbj845gvzo=;
 b=HzRGmaGq2N4j41iZC2MlxaK6bMGAyYthtOcsPbNA3252DkRcGlmvpEGiWg4sishpqGJFA0frigvIl9dYysbcNu/qVqyahVdmHSiSDOvq0AL/AMBBP0UwzLjySgVEpwGNrTcZQ+3mbg3WRinrKBjs7fPZKJ7Gow13nAidU7Sx4rc7E/gLHM0/wBYj7dOOz7J3Q6i5Nv4cpIxzeJagSY6dmfze7Vvee2Oy0kJplwOkQZs1pG17v1ibVkYtuh2i1Jz8umOq+OiS3MQIYM7pjtpaHR7NxxBWt7Kke2MCYXmEFaJAeW+lckyORf/KtjODqSrGcc+6x59FnrHHeRafRJClmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ0PR11MB5103.namprd11.prod.outlook.com (2603:10b6:a03:2d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 02:59:24 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 02:59:24 +0000
Message-ID: <74e8de12-f35d-d7e7-7b0f-56546ab8e0d2@intel.com>
Date:   Mon, 14 Aug 2023 19:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 08/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-9-james.morse@arm.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230728164254.27562-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::48) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SJ0PR11MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 5caa3b5f-6823-47d6-bb07-08db9d3ba16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3X1FuleIjadBPgeDfmBStAYnXSkd4ipU47vCtnDD96G+1Ex9SgeI6z3rMOdlwQttcZYRmZmaT7UNxVC7yu3oHlfOZyYM94JR8PYgDGAaoxKLIFq5sOQFzOvIcDV3pXTcZ5NYFe5G/9hrEEXY0WN/cmfqi6Skr5mAhYqSEIW86Cf5y1QcMi+aPftjXQQrd65GjSDbbX75sGEShJRbZDcVQd3W3FmVJakndqoCla9A+9itdVQPEoVoke3XW7kWw5a8VvtJtR//2emOQhIipnMoJ6LVNKmFKMRbqItqfqx703ibbJKVQnGlGbJ8LKTv4o5DslkKuf82A63ndHf62Hxw5QkxLfgdC9WTlVhtvWbX72knPoRjKHA6pzXqh11tvt9axY2e2pe9+9UHD8STSsg1VrbE7JKQvFxw3wYCeMcz/Zwrr1aljd+eh7oDsVOyXMblS6cx7tR3LTZbJ7zexhrEMjN0WUHDUcksuPsXEIy1uu0Aq3DyVlAYb56MKZO7dkoSwscpuHxfkoRpPALPzXtp9NLoGiK46KS/Qb2fmsCUsER6e/orDev2nczpJawIKvnCK9fJ3hbq5m3P0k576qYRKT2BRmGHNIT1BYj6s36iYhLI4dj9/MNcAgx1HJ1ZB0zpg5InCAWTYmG/5n6XUIUUQgOo5EXHmn5wow9oECsq/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(1800799006)(186006)(41300700001)(82960400001)(38100700002)(5660300002)(36756003)(66476007)(66556008)(66946007)(316002)(4326008)(2906002)(31696002)(86362001)(8936002)(7416002)(8676002)(44832011)(6666004)(6512007)(6486002)(83380400001)(2616005)(31686004)(6506007)(26005)(53546011)(54906003)(478600001)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1WSmZBWnBHbHBYQzUwRjRta0owdXFtZmVNbXlLMWxlNnVKZlQ0RDVKMXlq?=
 =?utf-8?B?cjFibUdncm9qS2hVUGpqZnQwdU9neFB5L2VCNHdpcGcrZnN2SXZXV0R2ckFV?=
 =?utf-8?B?dGhGcjdHV1pheU9ydnREOWRUazF0eEcwRlFmQnhmMjFFRGJjaFB0WE5LRVJE?=
 =?utf-8?B?b2hBQW9VMW1EUVE2bjhMQ1Vqd3Y3MWZyYkRMcXlYRWZYNlpMc05pMExmanJC?=
 =?utf-8?B?TmhoWEd4dCtYMVUxQ3ViSk1Vc1VPM2F1YU43UkFucVVUQWNqTithYmY1Smk1?=
 =?utf-8?B?UXd1ang4c3NRakdiS3pzem1HRU5Sd3JxUWt6elhoMHh2d09HS1oyVE5LaGhR?=
 =?utf-8?B?ZGdSOTNoQzVKeFlEb1RDU3hGVHFSWHdCYnpJdkVNYnc2NlhkQ01pNmR0NHVu?=
 =?utf-8?B?czJRMm1qN04wWXZKTHRXVzN1dG1vSDJ5TmtBZDkxUnIvdUh2akwrVkl5WnRE?=
 =?utf-8?B?VjN1OEE3RFVLdEUrVFdpRlpORzJrM0lnMnRGZVJ1VTNPZHE5WksrYU5kdEJU?=
 =?utf-8?B?ZVdxRHdtSk9DcG9WcTk0YStSRnNrSU5USmo0THhGbmdLa3JkQUdvYmlJT3NE?=
 =?utf-8?B?REgyRFUrT0VsSG5qWkx4OUNmcUlIZ2dGYWNwbzBJNmpGb1k2eXQ3RXhma0JE?=
 =?utf-8?B?Y3NmSm1OOEFoVEQxVWZ1aDVpcjJZaVFRVm90TmdSTjd0ekRvazRjRHBOM1J4?=
 =?utf-8?B?cmpjejVNSkRLMUlvTG5mWDhmaGU4aVRoSDg0ZC9ueHBBd3JPbWFpUGtuOXJN?=
 =?utf-8?B?ZmNTMHZ0ck9jRllZcFVVVktxQVE0SjMzTkZYZnExOXo3YXRIRVJMbDd2MTNl?=
 =?utf-8?B?QXBXUEV4d05lOWdvV3loWVp5UGNlNUNnZTdrVXB6SmpkS1dyc3AvT1B2alho?=
 =?utf-8?B?RnlLV1VjcHkvS0hhcGNpbGIvV0dHZmQwWjBDZGJOdCs2czBKbUt4WkttM3Fx?=
 =?utf-8?B?c1lWa3k4M2V2UUhJbXhQUko3Tlo4QzJWZkVOT2dFUTB3NkxOQnUzNkw4WDNQ?=
 =?utf-8?B?TWtlSTlVVEloN212K1MzMjVaMzVNY1pOVjNjQzdXWUtWSmpvZ2hYR2ZxejBV?=
 =?utf-8?B?dnJOUGhBTGJJVGtKL3F3RGJjTzM2K3JUWjA1ZGwvZzNJTGZPdHV2Tk5LMHpk?=
 =?utf-8?B?SXBWNmVzdElMTEpKTE9wdHlYRmgrajA0ZEdyQkVvSTlraFF3NURQS3I0Q0k5?=
 =?utf-8?B?eFdwVjF3WGZaWWVvb0hyNHFCdm5heXBBVTNITUhNYjY1WlhlOXB2V0kyWXgr?=
 =?utf-8?B?ZHVaMEtOSGl3UzZURWttMHFjdkFuejUrRXNFU1ZwcUYwNTkyQ0cvNVkrS3pO?=
 =?utf-8?B?eTZOU2VDb29GYUl4U3VyLzNteTdmT2VwbnRzaURmaTRRZlo2dXR0S0VXU3VJ?=
 =?utf-8?B?TmVaaHNSOWJxRm9hLzdCd0JnZ0RDdlAxYjRsNTY2YjVMNys3NEM0K3p4ckdp?=
 =?utf-8?B?UEdiTUVUK0Y1MlhsU2ZkVzViNTZQMzdvdDZ3TVcwYmNYWi9EZG8rdm9pS1BY?=
 =?utf-8?B?MEd2bVBIYUpxR3I1U1NuRGVBTC9Qb09Kc3RGc241NzhRWWx3dkExc1NmKzkw?=
 =?utf-8?B?RkgvUGtVdXdCTFpnSUFQVlRuSEVzYkZaS290OGJ1WDBhY3ZUQVZkaVdYcVRY?=
 =?utf-8?B?V0hrV2s3VnRFbGQzY1ZWTjZ6M1lvbXZsUDdJVkhxZmtvMGpPcU9zRCtTZHlj?=
 =?utf-8?B?aElvTnBsOXh0a3lraFZia1YvUFNtbWtscnlOVWJ0c0pPUDhMazc1UWtpVEMy?=
 =?utf-8?B?a21wVFFpQW96RTRHcVJLVmtzUitCRFN1aWRsVWxKRVdJdzlOYU9xN3VYc1hK?=
 =?utf-8?B?N2JsTmh4NWcydEJJNjlGckhyQWZEbFh4OGcrQ2tFUlFFcWNPY290M2h6Q3NX?=
 =?utf-8?B?QUdWdXR6ZFk1S1RlUFBUODNKazBuTGZndTVGYXFyVy81UXVJR0ZhY3pZbHov?=
 =?utf-8?B?dUNYbEJaV0F2UUQwVVY3MDc0K3VLMHIrNWUxZFpaY3Z5eTFCK1hKK1ljbFlH?=
 =?utf-8?B?WFhlR2orYUh6M1BHcHdhZ0dKNWc1WWl0ZmZUVlhmaWpTcnVHSmppcGYwSzcx?=
 =?utf-8?B?N0ZrenQ2OHYxYkIzaTJMb1U1VVZCM2pHQVMwT3RrdmFHby9GRGFQRXpkUzdT?=
 =?utf-8?Q?JunJ5PsBWoh+XrZy7AKRTfC4B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caa3b5f-6823-47d6-bb07-08db9d3ba16b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 02:59:24.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRG/OOFgRdtJ5ye6WmD00fUo6Y0okIP6KfN3aIWoYn1iinUSPiBUr9r/w9zrM1vAXV7ya1YIpCWvZCucqdpBcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5103
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On 7/28/23 09:42, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
> 
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
> 
> Instead of allocating the first free CLOSID, on architectures where
> CONFIG_RESCTRL_RMID_DEPENDS_ON_COSID is enabled, search
> closid_num_dirty_rmid[] to find the cleanest CLOSID.
> 
> The CLOSID found is returned to closid_alloc() for the free list
> to be updated.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v4:
>   * Dropped stale section from comment
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 42 ++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++---
>   3 files changed, 58 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 94749ee950dd..7c2a1c235480 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -557,5 +557,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>   void __init thread_throttle_mode_init(void);
>   void __init mbm_config_rftype_init(const char *config);
>   void rdt_staged_configs_clear(void);
> +bool closid_allocated(unsigned int closid);
> +int resctrl_find_cleanest_closid(void);
>   
>   #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 44addc0126fc..c268aa5925c7 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -379,6 +379,48 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>   	return ERR_PTR(-ENOSPC);
>   }
>   
> +/**
> + * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
> + *                                  RMID are clean, or the CLOSID that has
> + *                                  the most clean RMID.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator will
> + * choose the CLOSID with the most clean RMID.
> + *
> + * When the CLOSID and RMID are independent numbers, the first free CLOSID will
> + * be returned.
> + */
> +int resctrl_find_cleanest_closid(void)
> +{
> +	u32 cleanest_closid = ~0, iter_num_dirty;
> +	int i = 0;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		return -EIO;
> +
> +	for (i = 0; i < closids_supported(); i++) {
> +		if (closid_allocated(i))
> +			continue;
> +
> +		iter_num_dirty = closid_num_dirty_rmid[i];
> +		if (iter_num_dirty == 0)
> +			return i;
> +
> +		if (cleanest_closid == ~0)
> +			cleanest_closid = i;
> +
> +		if (iter_num_dirty < closid_num_dirty_rmid[cleanest_closid])
> +			cleanest_closid = i;
> +	}
> +
> +	if (cleanest_closid == ~0)
> +		return -ENOSPC;
> +	return cleanest_closid;
> +}
> +

resctrl_find_cleanest_closid() is not empty on x86 after compiled 
although it's very short. After all, the function is irrelevant to x86 
and could be completely empty on x86.

If put the function in
#ifdef CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID
resctrl_find_cleanest_closid()
...
#else
resctrl_find_cleanest_closid() {}
#endif

It's fully empty on x86.

>   /*
>    * For MPAM the RMID value is not unique, and has to be considered with
>    * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 4ab9bb018c17..df28b81d2c9c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -132,11 +132,20 @@ static void closid_init(void)
>   
>   static int closid_alloc(void)
>   {
> -	u32 closid = ffs(closid_free_map);
> +	u32 closid;
> +	int err;
>   
> -	if (closid == 0)
> -		return -ENOSPC;
> -	closid--;
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		err = resctrl_find_cleanest_closid();
> +		if (err < 0)
> +			return err;
> +		closid = err;
> +	} else {
> +		closid = ffs(closid_free_map);
> +		if (closid == 0)
> +			return -ENOSPC;
> +		closid--;
> +	}
>   	clear_bit(closid, &closid_free_map);
>   
>   	return closid;
> @@ -154,7 +163,7 @@ void closid_free(int closid)
>    * Return: true if @closid is currently associated with a resource group,
>    * false if @closid is free
>    */
> -static bool closid_allocated(unsigned int closid)
> +bool closid_allocated(unsigned int closid)
>   {
>   	return !test_bit(closid, &closid_free_map);
>   }

Thanks.

-Fenghua
