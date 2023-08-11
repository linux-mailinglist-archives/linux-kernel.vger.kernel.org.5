Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D75779620
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjHKRbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjHKRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:31:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAD2CE;
        Fri, 11 Aug 2023 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691775066; x=1723311066;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KCaG34l95EzImD0RGUpgnS6Mija0Ob5w7+ym+T9+hGI=;
  b=g0GEDq1oUYKN8BjR9zUWzXHgnNgKH+Ga2X2lFGFYNKS9JLsPFU92/b8Q
   KOfWgAOs0t0s9f1vOW15IIWQzy6xZWa82xayIr9C5Clvd4f5B2jYsfkV9
   Dg1Jd+avmakVuxBSD041524mImImYblU5IY1/8mc8Pph7yDlnLpBLOntC
   xy/ocoKj714vNWfRbTSMeyd1TqfqJfbt9Qwb9b2KgICEmG7RJ0wNSQFZF
   GDKhNlyHTeHZanNbh/OaJGbqlf2Hwxq8IUsaUZ5oG6mZFP+5woOcMV0aG
   mN/ZrcsktrrRWqZwuxw2qJKBd5BaF2KwvITA3qJDbbOAc3cXrgYrbcgG0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="374492648"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="374492648"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:31:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="682603283"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="682603283"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2023 10:31:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 10:31:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 10:31:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 10:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZByw0PminXeb0gGmhOHwo1dFc/zsQ05m6avxylNsINmTUgtXb+r13QfQIqPxgul6WbFXdGsa3J07MVzTSrnZjAnri4IVJnUt+5CBr2TgL7XVgVqLUQzOGgu0KolcT1cn93rG2/Y+2PB4Dx/WzDrFtby9/aizuvtXxug+VHJtuYh3SfEn/FxPJ/PUIuSkv3Y36YY6FeMhjODe9hJiIGINtDRSENceQQNZfsIzcm5XkZo70hh9AEgYja6a3AEhLnkBVfOPYvvKLPhZH7wvVwNURvFZTvTWYIrBwBsbTHDpHSvooljWnjNjYjyIic/tinwWKK2GV4GrdutNeyv1x2UXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCaG34l95EzImD0RGUpgnS6Mija0Ob5w7+ym+T9+hGI=;
 b=hWRdkZ1Xo2kz+FMOME1I3f9YiT8ZCx6xQ4GYRX/u5FCGfrIcoFna+Ol8imsNhEUE7Vc1FCq3jXxvJ6Ns1MY+tihq2wuzVXhA/hUlfLMq65IwB3aQXEWRMv+Rs6hDJe5L7tbtBLiuB9NSU8CBIFClR6GaynvVtTKr3rE/P0K5A8KQ0i4FEaVtq30yrPEPRcn7V+PAN5FnafkjMZ1bu8lvkuPg4z/jzMgQouxzPcuft43bYNuviil91e6pc8AhmY+D6bIo+539nrYHElJYQ7fiEtTIxudWO8vQfT4CKHgVakSfo4Z+fxUlGjOh0HUWMHj9O7dvyQ4k0F+9sNgsRW5J0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5609.namprd11.prod.outlook.com (2603:10b6:510:e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 17:30:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 17:30:49 +0000
Message-ID: <8a5722f0-35aa-a0f4-84a6-467c263e4a88@intel.com>
Date:   Fri, 11 Aug 2023 10:30:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 4/7] x86/resctrl: Delete unused fields from struct
 rdt_domain
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-5-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230722190740.326190-5-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 774a0ddf-b62a-4f79-c058-08db9a90b466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WgC5MArjCbKF2YOnkHFaMdkIS/yt1+dKFszlXr2LZKYLI7u/EBTnXY1NkNIkhFv6MS4f/Jzyxq+KzcjHmXFDCHJUJWjrKOCjXnaTuVY2PZx3syJCJJxwRC9PQEhpq9QYEjepXPJJs88cmTfMfA3u5BGLBfmEJxgyK8uqFcs+2HQVtyrWYrOB+mzqbEN3Hyjrhp0TYAHcMPuh7FBh/cJ2TydJGLYG7NcKHeYbEBhoX19Kz6SCle0nmzm1DF0H0Y1J5fDofzRebd/DyiqR2CqGElT40D0UVXHSluV3Js0MJc4PgGuJ9yes7/Xy2xybOXNG+KfenfyuL2LPPzcahsp8nwoZuM5DAGe/4Xuo4bTgicskVO/0l3Nk8XffquqxUP5ke8uQDVvIfFrdWntpZ97UKY64GH34iK9vgHh2IU4YlxIlcdypFPfYfVhisuMlm0az02dos8C9gRenxnTVm4ziFtkwV0KiVOORWpZkgd0A34pJs3rqBH7Ks9/VIWMNXC0/ERue/3I/+QdT+H5zEm4DQvRVPzZ6K2q0HjxOyztHmoCxxAv5aCkrbE33pew7w9cQuMadBSj7VQ1onzebRH5xtwxlpEcse+3arheD5sRLymjpvRMNSh1foKCALEAG0k54tKWb4TZqlNz7jepQgkKNpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(1800799006)(451199021)(186006)(36756003)(31696002)(86362001)(82960400001)(38100700002)(31686004)(110136005)(4326008)(8676002)(8936002)(44832011)(6506007)(6486002)(478600001)(6512007)(2616005)(26005)(41300700001)(53546011)(4744005)(2906002)(7416002)(54906003)(66476007)(316002)(66946007)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTUxNWZrcVR2dDRUT1VDaTBFMEwxVVNLVmpiYTZTdWxOSm41V3AwdnBZZ1cz?=
 =?utf-8?B?N0Q0anlTTVdwMVBXTUtZNUVHTUdhN004blIzdnoyR24zaU5SK1VqdUR0KzUw?=
 =?utf-8?B?WW1DcnYwNzRjUU9ZMHRjRzJCRWk0L1U5Z1RxbXBscWVqcCt4MzM3WSs4V3No?=
 =?utf-8?B?Ri9JbTRPNmRJbU9YL1NNZ0p4Y1BwYWdoVmtySXBZVm96SzBvamNzbElkcWZG?=
 =?utf-8?B?V1NFb3Jac1d1clhBbWFmYndxaHlSUDNGT1BoYUdjZnV2Q3VDeDF4TzU0K1Bt?=
 =?utf-8?B?THJPZEQ5L24ycWQwVGpaU1JrM3ZSSzlsM2Z5VUNQM0pQNndWYlMzN2NpRnNY?=
 =?utf-8?B?cmFiRzdvSTNXUjJsa3VOYnNJZ05FSXRKSHRwemcybXk5M3FMYlF1cHFnMlNR?=
 =?utf-8?B?eU5IeU1KNUt6YTRNY1liNGhEUlRkRlgxQ2txcW5MSnhqOThOSTZQL3NFWmVC?=
 =?utf-8?B?bEJnVWkyYlZZcHk3aG1wUXZNWWRvMDJyNWI5NFEvSjkrOHhvK29YeFQvQ3B1?=
 =?utf-8?B?OEFuZW1kdmNtRC9hSC9XcnBxckZ5KzBRUXNpQWVPUVhVMk9zVkM2SUk2SWRC?=
 =?utf-8?B?Q3dOZWZuQ0NIdDJPVlVZOFRhMmxYRFc5Qk1XT054SHVwTVp6dmdlLy9RQUNw?=
 =?utf-8?B?M0p4ZDMvWFVnWmFqS3N1QlB6TGV4dXBjY0NsTUh0VjhCN2prMFMyYTRETmlF?=
 =?utf-8?B?cDk1d3ZDaEVQb1JRRGVrejVwMzBaTzBRdHNtcVZwVHRRK2xkdElOaDVQVlBY?=
 =?utf-8?B?M3hNMG5RZzE0WnNVSWhvUm4rQWFpTU9XNUlLYTBzc0lxK0lqVit3RmRKRm95?=
 =?utf-8?B?WkJIWEYzczhTZ0o0SHlqYTRVRjJzempIbjRBblZwSld5TnB1SGJQQmg5STkr?=
 =?utf-8?B?aTQ3ZjdVTTdJTUpDSElvRlVNVEora2ZOSjlWbkprQ01DbUpYdndzV0grYVUz?=
 =?utf-8?B?WG5DWHNBVWh2dzZBNUlZVlZ5UmNwbXFpbk1MVEc4ZytVUStjNUpLWWRmMFZL?=
 =?utf-8?B?VHZDYzhUK1BHZGFYUEFLZm9rK0JRS3M2UkJadXp6TUNHeXhXdlhQcjM3VDNx?=
 =?utf-8?B?ek81T0RCRkVtZDBkVFdMSmtSNm9NZ3BzK0dlV0ZqUjRhQ2djNXFrNHJWVGZ1?=
 =?utf-8?B?eWY0YkMxRC9IV1cxVysvZ2ZNM1ZwUVZRZzh1cnJFdDh6d25xOWRYbnYvVXly?=
 =?utf-8?B?UjRNcDIyT3d6NjkwNVd0VkxpQVFJZ0s2YTQyN1hhSS8yVk9XUEMraFFpMjI5?=
 =?utf-8?B?M3o5K3BaNUh3aGs0MWxIcU1lTDQ0OUF3N1l0VDduTmtmcjlFUDFIV0dZNkN4?=
 =?utf-8?B?T09vdkFjbVU3WjBuRDRTOEt6TkhZUzRsZDVNTTQ3OVRLbVNDNGRjYnVhMGxU?=
 =?utf-8?B?a05xdzNzVU1FSVZ4TzJhTmVNb3JyOUF1K2VnTTR0elNIcGwzY0F5cEdiMDlY?=
 =?utf-8?B?SStOeittTW4vUHBUckJLY05GRW5CemkvL2RtV2FDK0ljV01PTDFnTWlYY1Vu?=
 =?utf-8?B?VUV3RzdzdEdFWFcyM20xVzJsNGlBYkhNc1Q0SkNVcnVwVERvS3FHUGd3ZzVI?=
 =?utf-8?B?MmRaeXQ2Mmk5WWJtQkVTOXpCNUZPUmJmcHV0dkQ5UnF0d3FFN2RNalo2OEEy?=
 =?utf-8?B?ZjZkZkZtWDZDb1NMODRJc3ZmeStaYTZXVWY0UUxNV3dFbmVjSVRrV2FIUE1R?=
 =?utf-8?B?UzZJMDVRYkhPbW1Ra1lHeDZwTEIzcHpkdFlwUk5YUlZ4cWV2QjlsWFVZMm1Z?=
 =?utf-8?B?UVhFZ0JmaHZoTzFNTkUycjJJc1FkNVl2WENjNmRYYk9Wa2RNNVhmUWhpUkZD?=
 =?utf-8?B?QlVORmMycXRad2xJTkVlU25BT2NOclZrbVBBdXZ3dEJGbHhMK0V6SENIelpj?=
 =?utf-8?B?c2FWTnVVY0ZjVzdWQ2FvaktrVTRWOG9Lcm9QdjQ0cFdXVmhLb0ZsZTlGU05J?=
 =?utf-8?B?WXUxam9ua3VqSE5ZY1Z0Z09OcE1BT2NCc3pERHRmQWZnNmR1bENxQ2JEL1pZ?=
 =?utf-8?B?SGFuN3Q5TGJVWUk2R1hXR0NKU2twRlBDcHQ2RElHRHZDMlFRKzJnMjNDK3NN?=
 =?utf-8?B?U2dTT1ViSmVNUEp3QWpmakdaUzh0WW9sTnNtOThZWDUrTWJId0tORFE3VmZw?=
 =?utf-8?B?cFdkUHRwbmV5VjV6a1NzakdIdW1jMGJ3TmtlZHppMURDM1NsdTNWd3NrVWlz?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 774a0ddf-b62a-4f79-c058-08db9a90b466
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:30:49.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azS6k7UNy9RnksHNt22I6WFUnH6Tchbwsy8BhBMfwhZ8eyIYg9nbZYj7P5KGjIjLsmVa+StUhjQ7m5ezjdXRyHXAkZk9Lh1bkTIoNBvFwJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5609
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/22/2023 12:07 PM, Tony Luck wrote:
> Now that all the monitoring functions use struct rdt_mondomain the
> monitor fields can be dropped from the structure used for control
> operations.

Please provide some context for this patch so that it
can stand by itself when merged.

Note that two structures are changed in the patch.

Reinette
