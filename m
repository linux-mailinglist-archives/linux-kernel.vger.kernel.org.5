Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA9776C34
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjHIWeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjHIWeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:34:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D2CFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620460; x=1723156460;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MAF06U94Cv68zxLqsHMoXT/lWMaUQAae+NTudlQD54Q=;
  b=aPnw5sivvCcffAbGlMQOwxaxdKn0cSi3hPmYjeSl5z12OAy8M42onaSI
   NNirX1FNmN4xMsIZjwG0asaVTDnJkvCpXawtRG97NqBIKxI0LSEYHXFMX
   UvJ2drmaIe+zwRYrXxm3U/sKFCBxgHgqRhwXArlaE5VMky2xwYyx5+wz8
   lozcXtyrhEzL5s8OYG3sXsv0IRzeDylSIvPIMROL4lLFr9CsKlW0NDAgK
   KebL+s3dxo8aYT0lWYTGdfCcVU8BMNF2ozIuj/3/4MIaOzOjiHsaH5XA9
   ID9+PMFEvD0Y0b9Plmh/RcjYZj4dTS/TvDMMxHtLbS+i/2nkcRNjJ9rUQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="350823852"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="350823852"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:34:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="731979351"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="731979351"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2023 15:34:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:34:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:34:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvXzqDxbAaVkV/JlKTSXgA84xs2n290VShd6u5sT70k9Aw3JNl4UGCytZIKKOB5SfnO3KFYEdrA23+uAVXk0WC8/B70ver899HEOTqwChIEBJ5Z0rssWMuLkJLTaiaNlsJFZtCNUvxbZviLvQ5G6rRy+eeLObZm0QGxuePluXTRByXrtz+MpoTqqhW015CuS5SpeRdjGDV/ikjYh6tta9ki0/y//2+eUktD/XJdidmruZehxqUByIXAJDjkEcuJORVHKgrwTiIUPwOE7uQVmy4JfNvDc+BBK+Fl2K1yiAa6/MPfFMsGMweJGquiAbeohXwi9DJdz2eC0mdSdDAwLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWNsG3jZB9lZ8r5U4bYRDNcZW1Aa3nvkgtyUE0B3GCI=;
 b=oT2V06QQOaCI7HEMhkxjekyZsYcYh4P+Z4wnkOGaVVpjirWj3n1llwj05VNLdUeoLwOjM4AcgSjSgi/ygKbIqOp4giZHfq/7wLuPNp+560mvXT0E1WIIyNvbXXz+8S0Xewtfz+ucfQp+njad2oj4xuZdxtWMNBrKPsfDHp297xTifLD83kjDajw1Vv+nYxjPojB6z5pr/TWjR8vYKIsRC/UfqEN51BJAKD6YE7B3eei2dNcE4+8djSs1EJJtEfRYiee/gNr9H0j3rhyW27QtNz0T/MRjnzNIDXP56n0K6vRmyA+qwHD+okZ5zZTU/r0DKGb4iwil+iD1XV+4VSfNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 22:34:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:34:12 +0000
Message-ID: <989616c3-ea4c-1c9b-b857-6d8bcb4843bd@intel.com>
Date:   Wed, 9 Aug 2023 15:34:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 10/24] tick/nohz: Move tick_nohz_full_mask declaration
 outside the #ifdef
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
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-11-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-11-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0348.namprd04.prod.outlook.com
 (2603:10b6:303:8a::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: b2eb8fd4-e9ed-4db3-cf7f-08db9928c16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7BrrnFcEw+OaHVVpy6+hVCeUGQ5iWcXijy97/c6CmWZOm3/UJm84sQH3q1it2Cq7ol0C0Z2SmuzYfUaf0mMr6UjQcW9mHf+jPQbJssWuY/7P4V7+0KPjQZDWp0nWv8dqmdqb5OvfYbx0cmyiFmXbSq0SwXrIvSRgNinEtrB5+HC6QuXFzXt1J09Xlb+mz0KBIVXnUDWy1OLn95Zb7jGLyF0Bdh+04vq9zeBr+n+R6ggFBvkLfXT+6aH/EKH4Z8UQb2Gwd7cDkIURiYwZdkDXpKlTCVrWjJlgpy+et2eKO6k/BnMSE7PUGAoRPuh26yzO7OYDiAHKuwzHpiLeP2a7HI7nNjkd2p9WCOKkNiV9ihior0RrF6CtUdubFykaiitCPeCYOs8bbMe2lc60JJtlnrXYzBIPdBj3ZzCpvoUsHyYhuV6iuqmQx+yRTpfh6B6W4jmENE3v6h/VKk9uXTQnxzBScNf4obT31LZMQvSdSuNPk1BwQUPXmTNHQoWNyd69/beEYdxPsiawvdPyWR1mGCAMXIohIa+emgfdG9o32KBKDaLG6OHd5ne4qnpLhvZ1ME7gngLRUYpGH2vI71jv1sa4EkfbwZBaV4aCbB+wuBL0BOhl4slULgYdmpESC3dlUPNvrDZLOWGbeesFU25PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(26005)(8936002)(41300700001)(2906002)(44832011)(5660300002)(31686004)(7416002)(83380400001)(8676002)(2616005)(38100700002)(316002)(53546011)(478600001)(31696002)(86362001)(66556008)(6506007)(6486002)(54906003)(82960400001)(66946007)(6666004)(66476007)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGdyK1oreHBQWGxBMWtCL0lyZVJNV0JrRWlCeldVQVliNVZGZk41NndvcUEr?=
 =?utf-8?B?cHV2N1YyNnh2Ym1CVXFxMVhJNHA4MnZMZU9OQXE5UXkvTm9UWjViQ2F0YU40?=
 =?utf-8?B?anltWkM5VmZWTi9IaVNoTUxPL21wVjRiNnpJOEdUaTVSbmNQWElrcFZyMSs5?=
 =?utf-8?B?NTM5dWJtUWY2Q0dDZjVJQnI5elQ2YlM5OUtKdVVLbWRxck1NNlNuWXY1ZE5o?=
 =?utf-8?B?YitmdlJ3c0VWbjZpN0x2SkpQYTdBTHpxMXdZNjVSR0hqdXViMStzamtDMnlz?=
 =?utf-8?B?SnM3Z04xRHVvZXJFcGpNdVpVbi9hNVJWelBvU2hySW1vS2ovSXNnQTg5Wm4x?=
 =?utf-8?B?TEsyWjBWSXhwWlRQVGwxTjA2TTVKNXBReWlBcVlIUWdLYXVHcERHOHc2NDJB?=
 =?utf-8?B?K2dndGNhelpPOEFoN01DaVVHeDZWK2JGa2JVbnNxM2RDZE1qclNVNEUyTG9Q?=
 =?utf-8?B?YTEzeW9JZFdjTHNwYVFXeVNzQ3l4dkpTa1RoYm90bFY0d1FrMDhEUUVZc2p5?=
 =?utf-8?B?UkVRN3JsSGVMNStSZklzMlpmSCtUUEROZkNJNUgrUFI0KzBKeEhuUmc0TFNW?=
 =?utf-8?B?QVUrZjFaWS9jNlNjMGMrM3JhbUZ4a3d3aGU0Q2VGWlF1Vk15dlFyeEp0YmYv?=
 =?utf-8?B?Tkk5T2VLWWQ1UUU5MXFXZS9IZ3hwa2lDL1k3NkRnR2tFR1lhSGZjZmk1bUZX?=
 =?utf-8?B?dDNaY2d6ZzdyTHRmTEJXTnZqcDZpSjZnTW52ZldpTHMxM0dFRTNDNWpCaXJu?=
 =?utf-8?B?VVlyTFBGUUg2R3hIa05qTW9tR0pkRDlKd0xrT0N5YlVLdFlMQmY4RnZJNlUx?=
 =?utf-8?B?VHhiMUp6V3JuWmVRdURyWEcyUWxNMTJoZkw2RmpHdU52TU9mYU42QkcwZHRi?=
 =?utf-8?B?VGhBUTVZWmxrOEpNa0p6NXRVKzZnOXdsWGRMSWd6d3hicm0xdDR0eGh5Qkty?=
 =?utf-8?B?bGx5MWJLVzlmaFo2TmxsNkM2My9uWlhTUGZsZ2pnY0V0VGRTWlcyeWU3eTZV?=
 =?utf-8?B?alVtNlljdm44ZlpzSWwxbEJRSWtpdUdFWENONG4rTFhVdVhiY0VLLzFFcU42?=
 =?utf-8?B?dFl0QXEwVldKcVFIWnV6Sm90T0hsUWFPdWNYd083alU4b3BOTkVhSFUvdDlI?=
 =?utf-8?B?aFVVYmpBWmdRN1REbzUwZ2RJTU1qNHorY09rNmlmS2tvc1pHTHpQSEF1eElS?=
 =?utf-8?B?bjduUUV4VlBzMnA2V3ZOU3FNVDVHNTVBTnc4WjkrODhNbk95YnErVGNrVEFv?=
 =?utf-8?B?U2czeGpCdEtodUFpb1kwVFlBZzRMdGk4MmdzWGVqWm1kbVo4MGg1WTZCb21l?=
 =?utf-8?B?a2k2dUl3eWRpNVZnUW9kNWI3UDVaR1JicUtpQW1sNURVaGVwSUpKd09oekh2?=
 =?utf-8?B?ZytIbnFpOE4zeDdONWtIOVRzL1V3UkU0dGVNTThJMDl0R1dBVlZ5MXdJZEU3?=
 =?utf-8?B?SExsY0VZeTVoS1JhOWEyRWU4ODNXWVRpdHNWV01rZ2ZPZ3BUa3RodHVLaWk5?=
 =?utf-8?B?ZXp0NDlXRjFYdDdrcjVnSkdpUVhWMmY5cDJrRjBOWUtSWlpzOWlqUGhrZFlj?=
 =?utf-8?B?VHpkeWJyM2k5UStwb2ZXZGg5dGY2SVJyZFFvdjY4ZzBlTjV2QlVsREc5UlZV?=
 =?utf-8?B?VGtXd1Z5S2JYVDJrOUZNc1RMenNyZlQ0bWhsbUNmc1NOTEJnckZkTWFIRHhZ?=
 =?utf-8?B?ZU5mSTVTeTBQSnpGUGJFKzZPY0JsUStXamQ2QXRvZlRnMzFGWEJKUUllekxG?=
 =?utf-8?B?TEVhTy9QSzhiNzZlaGordklsUDR1T0wrbFZtaHQ1TktIaDlKR2ZWZC9oTkRB?=
 =?utf-8?B?U3JDZDc2MG1NSHI0Tng1Ky9hekdzUGxVODdPZ0dlemx0UW5uVG1wQ2pOamNP?=
 =?utf-8?B?dDhKand0aUErV2k0QlJLclFUVDJLRW9sSThRUkRNNjFiWndxRGZZdUR4alh5?=
 =?utf-8?B?ekw5MlFhMlRtQVJLWGlPVUxEZzVQOHBFOHN2REQyd1pMbXN1bXVjL29qMlhF?=
 =?utf-8?B?ZE1UQnIwYnROL0UrdjlFcVREK3pNb2oyWHVodnFWWUo5ODJNUkJ4ZDVMdHNI?=
 =?utf-8?B?UlNMVi9sOXk0VThaOXR6aHdIQWMyMmp3aFd4VnNFZ042dlhNSHZjMmR6blhl?=
 =?utf-8?B?OCtJZGxLcUg2UmJBdmNCVXdnaEZPNEdTZHl2MU1PRjhGbFJZaHJKVHVUZEI3?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eb8fd4-e9ed-4db3-cf7f-08db9928c16c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:34:12.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ulyt21nsHLIexN74h6cMy5HMgq6eRvK+TJDs6kl6vwYSimh11zyIpnzCoW41fwkMK79Cs15IUsfBzmP4TeqTOq/pAtlPWvArXdmxRyhGC3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:
> tick_nohz_full_mask lists the CPUs that are nohz_full. This is only
> needed when CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows
> a specific CPU to be tested against the mask, and evaluates to false
> when CONFIG_NO_HZ_FULL is not defined.
> 
> The resctrl code needs to pick a CPU to run some work on, a new helper
> prefers housekeeping CPUs by examining the tick_nohz_full_mask. Hiding
> the declaration behind #ifdef CONFIG_NO_HZ_FULL forces all the users to
> be behind an ifdef too.
> 
> Move the tick_nohz_full_mask declaration, this lets callers drop the
> ifdef, and guard access to tick_nohz_full_mask with IS_ENABLED() or
> something like tick_nohz_full_cpu().
> 
> The definition does not need to be moved as any callers should be
> removed at compile time unless CONFIG_NO_HZ_FULL is defined.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  include/linux/tick.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

This is outside of the resctrl area. What is the upstreaming
plan for this patch?

Reinette
