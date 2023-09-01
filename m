Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4D79039F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350801AbjIAWZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350822AbjIAWZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:25:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F17121;
        Fri,  1 Sep 2023 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693606423; x=1725142423;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rgC0+w8QdC74vAaRauYrKlWx6W/mAw8dVOfTm2J/uxM=;
  b=juwyD5rkdnNru0hNdP4V+YSCwYFHSLLYTNOKeWhW2D9bZm+q7hnHcMtd
   jFRy/BHMf6JrnF6++Sb0Kw8zFXZUTeZmjjZa9WBdAN8wS+9Ke63niMTSU
   Sxl/o42YNbGl5rSysVQ2fNk1L0HmFWuIvKNYLAM1u2qWRnUYgMm/Rblmk
   warPUHV55yLk6Mf5J4vJoZ/p17w1RymR27pjsEwY842zaGIBUBpg518ki
   brMylT5mSNHenOH0VsROilZnofxZDxjMgEa3D/nx7N9IdByKgzuwGWpSk
   jFa29GRpydrbHgs77ERa1vd8lHXkqT2ac6FTouB5sxWR3/Fwe399Y0zh0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373713708"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="373713708"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805597254"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="805597254"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 15:13:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:13:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:13:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 15:13:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 15:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6SFxLcA7n8ENIMENb0kPHarNWvH5wdVc2+cM3QlBnGzbRrkUr6KHWQuVS1DsXYHlgsQBun3mjhXchVRcRtJrI4GrY5+y+jjhGaFj+7qCJSaSjUGAjV1BF6pOzb73wvfLC7nW7YgbpzCHbKQ+CYkcsH2ckPTvXhz89fJ22IzhZYZxzCyoVbXedgfsKHa1ilXfTlWIi7RKYMH0NIUo1Y7kmOsIse5mmTB0uj34rvP/DzyCNn9BvSiaQH6VCMpfgsDpmE0rj3jRLKpF1q6WXqiAamzChMdXB7bgqL55/dX5Yce/EqyYD2RVdDUtbBNqz/3lQ/mVkjqNJHT2AeSEsT4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT2pp8Yo5RxJ8mMH9eO4QdfyyDGEMx9IXfVVSBx95JY=;
 b=cW13QfmO7CQlwyucGsopdx4GGDANfOVfstfKbG2msgTREvvDwfZX9PgbsqtAkHY0lAXd/hUz9isBz6angz/wYNGXYHovU6toDcsUCBnLB8H5vnrTiQPBF0ExEabKkZUfiN2cflDBoc9mWnRH6wKywduGK28vDHLSDfI04Cr6vTs+W825XRRM+/FQBRhrH6kR1+RHB6u6ZpCesqQTdPWOJTyx2gk+SphZi2jV3+0L8YYgQ4DHXRKD7WuLfWJkBiIwmyVboOzYA7fYS7JxdXAGz6fJozfgirYj8wGkaFFV/QsFr8BNECycf3zlalIMzkmuStJoN8oWwdCXBVITDkQe1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Fri, 1 Sep
 2023 22:13:37 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 22:13:36 +0000
Message-ID: <a59be218-350b-b88b-2b02-be9c1d2bf797@intel.com>
Date:   Fri, 1 Sep 2023 15:13:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/8] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
 <20230821233048.434531-2-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230821233048.434531-2-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MW4PR11MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e1e7bc-ca91-46cf-b873-08dbab38afd2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHWUJi4dai7GLihweXkDJ6//r3g5VZngyiC3KI21rpqqLznSNK8dJlCLBYKFFgsgfGQXHubWH0TUYfCf3q1rYyGBraqzZ+VO1nuMCVBdz92O4WbCkHaEuXW7R18q1OAEV7/3X6FTm4xoeV7bbcYpBbwjT7JHKZGOQVtei2SDzoF5AYyOhEq70EUpPW19fwKzq51foQjWN/TrRi1gc4soQNpuPwSVZb+7OgMkAT3VDTU+6bbZJSI680JjY32CqwutRXB5qXUmgEt+Nuz5FI6aYrFGr7R2CZzqB/Nce3ncpHaVG8hh9TWnsSOgqELRZL955HKwmltM8ekZl9/+xgOolZWkJsHRp5+2dddaNSQR8mo8YlGyQZo1xQfJmM2evt7gbNF6Hxx7igph2lza3oMoM6HXrv/bjSBN9u9RhhZXxN8wUgf3caR+V/728HbrTeaapB6Qm7fDmeKerPPAKYRsi+ADn9mJR03NgXzna52Gvij3GXPR5WD0KBY6DZVrjzFzE0qEhSxURu+4dZch7stb8qrmNHEGRu82CZR+FaWYzD7rPxEv2XSonERJkq2rEsK4eu0mFHMyl2CXW5ihtL2kA1DTbzJUwAIYC5rX8R18aAy1V8AQde96iBExEn9BTwjp4aV07w5JSaS6zOK+vI02pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199024)(1800799009)(186009)(66476007)(66946007)(66556008)(2906002)(41300700001)(7406005)(7416002)(2616005)(31686004)(5660300002)(478600001)(4326008)(8936002)(8676002)(316002)(44832011)(6666004)(66899024)(53546011)(6506007)(6486002)(6512007)(36756003)(26005)(38100700002)(83380400001)(82960400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGJySmord2RRaFhuLzIvRnRVNndmaXhsUk9nM0RTWk1LQ0pybm5CRUtRR0p3?=
 =?utf-8?B?VExtRlJMWXBSRzhDL0c4RTFyYjBpTUUxZHJyc1RqeTAvNXpTYjMyeXY5WXJP?=
 =?utf-8?B?TEdVWHdNYjlkWngxbnlra3BlS1IyWVQxdFM4N2tHY2lpNFAvTzNGYlp0UXRM?=
 =?utf-8?B?YW1JRmxZZ0laaHJUUDJZcFRzcjZwMUZtcktmWnVoOFErUU1rd3RoOTdDWDUy?=
 =?utf-8?B?cXU4VG5WTk1BYlA3ZjNLTERNbjZLNzgwSmVvQWhiZUhyOG5Idm5LVkFRYjFG?=
 =?utf-8?B?RWE1bEIvN0hJaEdnVzFaenRKajNIUnNaeVBnSlI1R2RDY2tIc242QlZicEdi?=
 =?utf-8?B?bXRtcU5HZ3lwN1BQK0NrY2RxWkF2ejBKeHJlT09UeVpscHNBMTYrbjJRdnBk?=
 =?utf-8?B?cm1LbzUxcmZWaC9YbGRQUGRHRmZOZXFiWjhhbXcyVndlOE9tNEozQnFPcm9k?=
 =?utf-8?B?LzBPcml5SDBNa2NMcmpDanlJVGh6aDByKys0bWdieFRTVWVpUmhMU2JDSFpW?=
 =?utf-8?B?WUhjWCtON21EUzhIQ1BldzNwS0d3N24vS2Y0MXg0QWlraFU0ci91bk1vZGdu?=
 =?utf-8?B?R3FTWjFrQUpIbk5xR0RpQkFCeTllYTdrenVNdUhxc0dZaWFQOFIvV1Buazdm?=
 =?utf-8?B?M0RlRWxqNStZcUppRUN2MzVqOUcyUHMyUk4vMnhSRW90TURBbytMZWpkbzBp?=
 =?utf-8?B?TFdPMm5vbk5aL3BRdWdnQWI0VzFNRmZOazBZMUM5OHJWblV5OEJtRHNWZVpa?=
 =?utf-8?B?TU9KZXpyYjErZ1JRRXpSV01xVHhHZ0VJaHVORHZqK3Fia3JVbmZQUW9XRHND?=
 =?utf-8?B?OTJiMUZTMHprRDQ4dkpZcFcwczNGZ2pCN0FIckN5TzZnQkhPdVRqYjE2V3Nm?=
 =?utf-8?B?dER4SnJCODFkWFY1S1B3NlRTalNWMVVwU3owSmZHdDdiQ0h0azNHSlAxNi9m?=
 =?utf-8?B?bVNQY1Z4WVN3bVpiNHAwdzBnOVNjcUVaeDhuR3gvUVBvOTA3Vjl4S09YUmhS?=
 =?utf-8?B?eE5GNzIwR3I4UTFJdWQyU05va0M0OGd6TTNxR3RBREpHNHJyMGhKMEk5SnVv?=
 =?utf-8?B?cERNYjJBWGdabmpabzV6YWtBUVFNQzJVK2hwblc2b1hSS01WVVNoN0FoWWFy?=
 =?utf-8?B?bHUzTjhpRnpGSDJOVURrRUI2aXlBZWZuT2xwYWMyR2lkVWpDT2taYVpjMlhT?=
 =?utf-8?B?RlNXL1hweHRxSEZHM3ptYUZxQStPOXo1TEdqUExSVzRnd1R0Mkk5SFVuaWQy?=
 =?utf-8?B?UzBnLytPYVY2MDRpYTcrTmt1Znh4c2lWQ3JjbTRJQjl0QVFUbzRSbHdYbU1G?=
 =?utf-8?B?UjMvSjQ5cWw4WVhRNWpiS1hHNFlRTlI2ZFFENEJOWUk0SWZlSElIRkhMNjFM?=
 =?utf-8?B?ZXNLajFZWTFOQzJPWmNNTVBpa3lGbWtCZm8zUGt2RXE3RUlGUVFRQ3RRRThv?=
 =?utf-8?B?V2hkTlBQcEhlL2V5bjJBckg2Yk9FeHJMNG8xY1MzRTY0b2dqNVowWEQ3Wkxu?=
 =?utf-8?B?L1ZRbXlOSEZGN3lCekJsb3dLSEx3WURPekVXMUlCaDFsbUU0UjhqcC9sanhH?=
 =?utf-8?B?ZE5PUnBCODJTazZ6NUEyenhFR25SZXVoRDdmUm9DcDFVTjFzTFhpYjc1WXY3?=
 =?utf-8?B?eUJ2ZXRQQ3pYd05QK1JWbmd3TUx6NjZ3ekVyTHpPb25QZ0JCallKMnJZN0lk?=
 =?utf-8?B?dGU5dUVPTXJFRHVxWlJuUGZkZG9jZi95aXI2WEZ5ZFdUSFRCeEZhM0wxL3pl?=
 =?utf-8?B?anMvM3B0MUpwMnYraXVEbDlhNzcwUTVucThIVlAwclN1QStsOXhwdnQxRWpJ?=
 =?utf-8?B?WE1ZZkZ0RnArTHo1bzlBWHQzTmkrbFJJVzlrQm56KzR0SHVYZ2ZUeTNBa0tN?=
 =?utf-8?B?QllPOWRsTkQ1dmdtRUdUd3pqNW1teG5JSGRzRC8vUFFOK0diUzBybjNVZ1FH?=
 =?utf-8?B?dlZIck43TWVVSFBJb1V2NC9hUEptNDhnWUdON25hRS9UVDI0WjFsNHJNclgx?=
 =?utf-8?B?elk0UWxOTjB4RkI3OGpzK0FnVXRsUUVOUFNSTUJ0a0tEYiszYkx6UUtLZ2tO?=
 =?utf-8?B?bnVjR2NwNmF5ek45Y0ZIR25yWEs3Vkl2dVM3M0tnUk9oZytaWng2ZmphN1Vh?=
 =?utf-8?Q?0nzVKWV12s+egFeapssWanmQJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e1e7bc-ca91-46cf-b873-08dbab38afd2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 22:13:36.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZO/XCyaZD2ky3Oy+2DaY20yPiCY5gihDktSq7IwgfLyHJ9goQUM4jsfljCCBGm+QGw47HDATG94CS6G1XjIHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Babu,

On 8/21/23 16:30, Babu Moger wrote:
> The resctrl task assignment for monitor or control group needs to be
> done one at a time. For example:
> 
>    $mount -t resctrl resctrl /sys/fs/resctrl/
>    $mkdir /sys/fs/resctrl/ctrl_grp1
>    $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
>    $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
>    $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> This is not user-friendly when dealing with hundreds of tasks.
> 
> Support multiple task assignment in one command with tasks ids separated
> by commas. For example:
>    $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>   Documentation/arch/x86/resctrl.rst     |  8 +++++++-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 25 ++++++++++++++++++++++---
>   2 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index cb05d90111b4..af234681756e 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -299,7 +299,13 @@ All groups contain the following files:
>   "tasks":
>   	Reading this file shows the list of all tasks that belong to
>   	this group. Writing a task id to the file will add a task to the
> -	group. If the group is a CTRL_MON group the task is removed from
> +	group. Multiple tasks can be added by separating the task ids
> +	with commas. Tasks will be assigned sequentially. Multiple
> +	failures are not supported. A single failure encountered while
> +	attempting to assign a task will cause the operation to abort.

What happens to the already moved tasks when "abort"?

Could you please add add more details on "abort"?

"A single failure encountered while attempting to assign a task will 
cause the operation to abort and already added tasks before the failure 
will remain in the group."

> +	Failures will be logged to /sys/fs/resctrl/info/last_cmd_status.
> +
> +	If the group is a CTRL_MON group the task is removed from
>   	whichever previous CTRL_MON group owned the task and also from
>   	any MON group that owned the task. If the group is a MON group,
>   	then the task must already belong to the CTRL_MON parent of this
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..8c91c333f9b3 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -696,11 +696,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>   				    char *buf, size_t nbytes, loff_t off)
>   {
>   	struct rdtgroup *rdtgrp;
> +	char *pid_str;
>   	int ret = 0;
>   	pid_t pid;
>   
> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
> -		return -EINVAL;
>   	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>   	if (!rdtgrp) {
>   		rdtgroup_kn_unlock(of->kn);
> @@ -715,7 +714,27 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>   		goto unlock;
>   	}
>   
> -	ret = rdtgroup_move_task(pid, rdtgrp, of);
> +	while (buf && buf[0] != '\0' && buf[0] != '\n') {
> +		pid_str = strim(strsep(&buf, ","));
> +
> +		if (kstrtoint(pid_str, 0, &pid)) {
> +			rdt_last_cmd_puts("Task list parsing error\n");

It would be better to show the failed pid string in the failure report:
+			rdt_last_cmd_puts("Task list parsing error pid %s\n", pid_str);

So user will know which pid string causes the failure?

> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (pid < 0) {
> +			rdt_last_cmd_printf("Invalid pid %d\n", pid);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		ret = rdtgroup_move_task(pid, rdtgrp, of);
> +		if (ret) {
> +			rdt_last_cmd_printf("Error while processing task %d\n", pid);
> +			break;
> +		}
> +	}
>   
>   unlock:
>   	rdtgroup_kn_unlock(of->kn);

Thanks.

-Fenghua
