Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3828062D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbjLEXSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjLEXSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:18:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE31B2;
        Tue,  5 Dec 2023 15:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701818308; x=1733354308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WjZYSP8yeJcv9poZuazw/VWqvnoBJ26ECOItdhrfaI8=;
  b=L5b7vycl755eQBK5YeKXOj01mwSEQVpka1qdsMY0e3GZnw4RYIvJqBxg
   lzM0A9Jr+P8qzvPgHUTkuwCdhzobexXEYSZv/0SDP3h5DctKiwSEIgJnY
   68/hMyDdiayUAmblh3PwwxKBBcGVm/ZjTZgbbmZwuWg7T0gu7OVd9Todb
   8au2COY7UElVF/LKzb8R1rmjPL+/z7gLHPle+kbgJvPz3y5+DgATjC4xK
   A60qyWGnrMNmUiyrgUo1IAF0zIM4WDrE/o+5sw7tQksCtGV3FV2BRk7r+
   DY1ckDMDAxPYhmb2YV9OjD26ipkpMl29yvuhsNEqfIowGrmnNDALhpjsp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="460464152"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="460464152"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="12492958"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 15:18:27 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:18:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 15:18:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 15:18:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNSgz2olk0aanRglUzZ+Z4D9Pnx9KZcVAyKPjyZz1xXdWhVFx/cXGFexf3CfkyDg7ouWk7opvoAr5asVgfyLg6yAUKyKPuzlZDmTc5BqUFJawGzV0BML77nRyWfXuNt7zHewR15GSGbcRBQZXVQr/f2Hn1+LoDFbSosTMKiOYpnjSz2XQzJ92wL2eA/ulXTLCv/f0zdVNTMFWW3/UNtlC4UQRFY2LPSNBslZ3SXeKae+xFRZFqfeQQGbaCOw5iO0wWPsfK6/e5Aoa/QuRhtBBwFe50SoV4nDgKzSHRAqve1Eg+Q5nA218jGKBgvaG5DfIQTgiPoGdx0a20WdrF00Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntcQTnZhmbfX5gsDkvya6C7ec/JGPmtyK/g/7vAzVlA=;
 b=UaaAsYB8jgDEfWxSuhmSgtU4Z9IRA+pwyHCku3Cp7S5IIUAQaB8jYqSzO6jR+YLqOoS7Tp6sG1ByTucRQXm+L2hOUbLtV3TR4hoYOqxY2G4GvkbHPn7EjATQP4HVlVl72VcWE3E1bxWnNf0uV8tcfUWO4VBa4WRgnh64zcA90FWxysIYRF+q1vEqlVcVWhtUS4Jv2SKDMebsz3/5yyEyqEyy9M1EKIO2E1FgWuE+om3/oTfowz/x1rQcY1UKqBG/0XA2qHgsCQrI4JpK/hdJEX44rHc+zWFKmn69k9Ie6iNnuNsd7Fg7oj+I0J5LTOrhOU1OIFwTsG5sQEHI2kWJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7319.namprd11.prod.outlook.com (2603:10b6:208:425::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 23:18:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 23:18:17 +0000
Message-ID: <4bca7ca1-d452-4cb7-b721-b2273f9a71b5@intel.com>
Date:   Tue, 5 Dec 2023 15:18:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] x86/resctrl: Remove hard-coded memory bandwidth
 limit
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <jmattson@google.com>,
        <ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
        <kan.liang@linux.intel.com>, <nikunj@amd.com>,
        <daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
        <rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
        <maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>, <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <20231201005720.235639-2-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231201005720.235639-2-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: d2418f5c-f5d0-47b6-5abc-08dbf5e876b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAgob6JhEqr4UtkV8GOlvQuDPm4znzB/I7lfEWVz1PLvtidkaFfbxSrfY48xcsem96/8DY6dzRhek2uRlkFVoUa0flPo0iypzqwRRa1EZPFSFM8R9kPe2kbo2YSF1Au0WGP8JAuvsJ5dcKyl9nuZCuhKi9WL1gBhKL9p3LiEvnk8DgQ50v2GbYKBDGqwDKlemioKDc5QJvhRCbL387BJaHben+lyPvRxHFNx+r1xGf7PciRnYxAFvVZGxOW9P+DIIFbGI/Z1f+iSBhMfPtZ8ll5IUzzmL0w+5luRWXORqneivXsugja/SZLiOl0vxnJE9GbMxcZddRyEurL+rJ1CaCUM4q66c90YoDUGlqeDJG+T9R21by2oeUoM7u696OhvjKimChKDOydEftHZaTz+RDuSdsjX7tZdudhKQ2ij+MVz9z8kG2+OuZZEM3HCSiqUeTQJQqssMCVFiJiuZcnr0Gm7sl4EYK+Pu/54i36vo9cCQeDuqOGD6xI/wp0V9iwtuB1Ud0wf5/N8OzIugsoP22zzMQfTp2XnXngcCZfn4T7T6H55SJygH9Xnxkk8IVkus7FEg6wUzE/HHm7r0CA0Sy5Evs5KBffyhLmpJ2eYYNW2nJwM8WFed4tiq/auzqfHKasyGlsUO5GAycoIqfn/lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(8936002)(8676002)(4326008)(44832011)(36756003)(53546011)(966005)(2616005)(26005)(6512007)(6506007)(66476007)(66556008)(66946007)(6486002)(316002)(41300700001)(478600001)(31686004)(5660300002)(7416002)(2906002)(86362001)(31696002)(38100700002)(82960400001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmM5RVZHdUNJU3k4L2xsbDRmTld5UGplOC8ya3plWXZvaTllcnZNdGRyaDFL?=
 =?utf-8?B?bmFxcG1GVVpadk5iMms4U0RYNXFFYU9RVDI4Q1Q5ZU5MY1BNMEdPMWNyRUs3?=
 =?utf-8?B?eVdyQ1dvaFdtL2VhbnAzazJ2TmFyWEgzOTFEVU8walNXR3M0TU0yQzdyN2lG?=
 =?utf-8?B?WVYwOVJKNHNsbmUxWTRoMkliU3NjOHVHNDZYdGx2WWRadFVqSDFZS3FrOFla?=
 =?utf-8?B?dzkwQysxWEZ5OFBYRlJob3l3UUJVTlNCV3FPR1lHZzRBN21rTDdZTFNUWXVn?=
 =?utf-8?B?clAxcEVUcExMcjF2YUVvdm1NSy9EdGM2VjZHSnFWT3lJclV6Ymt3eDl3ZlNa?=
 =?utf-8?B?a2hITWcvdU5OWUU0Ui95UlZhMHd6Z3hlWkQ5Z0U0bUMvZWVFWW4xUGZPdmZO?=
 =?utf-8?B?NlFuYVgwL1Z5clhQOVVablErTVkwNFZIWWNWN3Raa25JaXFvN0M1cDRQR2pm?=
 =?utf-8?B?K1p3SThXUGh5c3ozUlUrc2JLcHlOVERMR1FZb0JnMk9kVzRESWZUSUtyaDdT?=
 =?utf-8?B?cFhaZy9TMTI0aEtTU213Rk02QUhUcUVJUmlkUnBtK2QwNm0vam1DMUN6OHNS?=
 =?utf-8?B?UUlEcGlTeWJXNHZoY0M4dHFaUURxMUFhZkFvRmpHUXR0TUx2T25zREZSUEtE?=
 =?utf-8?B?QjNsSkVXaUJCc1pXa2lITlFTZWs5T1A0bFNya2poQk51d20xdktVVzVBdFhF?=
 =?utf-8?B?MWY0RGwwVUZ0QUVlSGp3L2tlZnFFZk4xN0tSVUwxVnMrcEYvODdaRXNyc2Ri?=
 =?utf-8?B?L0dxMDYzRTdyUzl1NGVuODFpc044TnpjbmRLNlU4TjdnS2l0eFNiVHVieW9w?=
 =?utf-8?B?TUFNZXJyaTl4ektjNytKSDJyUE00V3U2Y1d6UzRXNmZLMTZTOWE4K3NDbUJX?=
 =?utf-8?B?dzMzRGZ6V0dod3N4OUtud1RQOVM5YUZjeEVJTlppMTNmd3VYK1l1VUZaQWlp?=
 =?utf-8?B?ckp0d3RGR2wzS0xhWkpyTmowVW8yUDZIemVZOWRKdHo1bnZkd0duWnhqcHZm?=
 =?utf-8?B?dmp3WUhDbGJQcXhkRDU2My9RaGZha0NqM3RWaTZWTUVLYnpUdktPWWRUTkZM?=
 =?utf-8?B?dFJiS1doWUVZTkd2THFUYlJvMXkyQmxMSndIT2NIN3J6U1VnQUU2Y2k1bUNU?=
 =?utf-8?B?Yzg2a3pRT0FtdUh1VnY0dlRidWJtSjVQdDlDWWZXSVZ2cEw1ZitEMnJqY2lN?=
 =?utf-8?B?QnFVTVNaakQvUWdrVXlSQmh4VTVRSzNZRFdBd3JiOWdSMk5tbC96K2p5VEVV?=
 =?utf-8?B?c0JQSjFPRzl6T1I1ZDlTVk82YWxDNm1idlppckF2d2RMQWJLZWJIM3loRTVE?=
 =?utf-8?B?aDBnU29ncjhCVVRTVzU0TEpWcHE1RkY3N3RtMnJjQURWMHVWNmJzK1RTQ1RB?=
 =?utf-8?B?K2FrTXRLOGxxRGdYdUdnbkJaY0VRRDQ5WE1Lb2Riemo3d24xS0o3SEVBcDNS?=
 =?utf-8?B?WWF5R3JVWGgzVCtCbEVkZ1V5TmFxeklKWUZKOWhtMTNDZ2l4ZTBwaS9sVW8v?=
 =?utf-8?B?eUZaTFAzQUl4UFhuTHZnckJ6MXFYbHNxTjF5ZTRoZUI4dHQrSld3RDFMUjNq?=
 =?utf-8?B?YnJBNXFpK1M2TmViL0FyMENxaVU0eEFoT0hXYkg2RGd1MDRZcE5hd05JdG55?=
 =?utf-8?B?eHRqVnl5OE5nWGVEcU5tUWdSNlVaMGhWRFZxOEhvYUFnVEdNdWw4VzF0OU9D?=
 =?utf-8?B?eGNGV1FmZkRIWlROR1NVTk9yZzFpZmdaMnZqYTV1b0p6YlhMdkl1ZTEwRUth?=
 =?utf-8?B?SUU4Q3V3YkNQaEtCOEthL3gzREVzYUo3TkpCdzNiOVJhZVBGSDRHTllndmVj?=
 =?utf-8?B?clhXWkk4UEZWN1BjbmxjN3czRld2ekdaTStmeWlia0E5WmtIVGg1T3VIRk9Y?=
 =?utf-8?B?bitwdmhGdkxhZVNlWHo2YWZiVTJTcHgxbUlGRldqZTI1VnNyajZ5VkFxd0w2?=
 =?utf-8?B?bWhnQWJWWHlNZWJPR21YOTgzTlJmQmthamIrVlFrVVlvVEFaZTZDRzZZenl3?=
 =?utf-8?B?ZGg1Vy9Wa0VOTk5lZDBsRG1QeCtuVk5KOVQ4dkR6TVV4UG9mZDU0bk9CemZH?=
 =?utf-8?B?L1RuNUsvY0xwUlF0cGNOZ0ZOS0sydkF2bkVzOXRxUjBQbUtKOXNncFRxaisz?=
 =?utf-8?B?Z3BqRG5pM0ZVM0o2cEJKdll6bEg1b0s5QjVtR1FtMzJ5aTNUa0gwMkdhR1dJ?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2418f5c-f5d0-47b6-5abc-08dbf5e876b6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 23:18:17.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3Q0KChKMdwrB9RAV/5AwlBYicdpB3+o4gn6lA6r8tZnCqzHg//85OzVOk6uVyGtygk9V36rga8MLVcyPBMvwHd/r1jACUUqF1YPTSz4dU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7319
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

Hi Babu,

On 11/30/2023 4:57 PM, Babu Moger wrote:
> The QOS Memory Bandwidth Enforcement Limit is reported by
> CPUID_Fn80000020_EAX_x01.
> Bits Description
> 31:0 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.
> 
> Remove the hardcoded bandwidth limit value and detect using CPUID command.
> 
> The CPUID details are documentation in the PPR listed below [1].
> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
> 11h B1 - 55901 Rev 0.25.
> 
> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")

What makes this change worthy of the "Fixes:" tag. What is the impact
of this? Does this mean that there is AMD hardware out there that is
not being used correctly? In this case it should be highlighted and
the stable folks included?

This also does not seem like it belongs in this series and should
be sent separately as a fix.

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 19e0681f0435..3fbae10b662d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -243,7 +243,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>  
>  	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
>  	hw_res->num_closid = edx.split.cos_max + 1;
> -	r->default_ctrl = MAX_MBA_BW_AMD;
> +	r->default_ctrl = 1 << eax.full;

This does not seem appropriate. You are using eax because it
it convenient but if you take a look at its definition it does not
match the AMD CPUID instruction output at all.

>  
>  	/* AMD does not use delay */
>  	r->membw.delay_linear = false;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a4f1aa15f0a2..d2979748fae4 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -18,7 +18,6 @@
>  #define MBM_OVERFLOW_INTERVAL		1000
>  #define MAX_MBA_BW			100u
>  #define MBA_IS_LINEAR			0x4
> -#define MAX_MBA_BW_AMD			0x800
>  #define MBM_CNTR_WIDTH_OFFSET_AMD	20
>  
>  #define RMID_VAL_ERROR			BIT_ULL(63)

Reinette
