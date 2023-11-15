Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2AE7ECA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjKOSVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjKOSVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:21:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5DB189;
        Wed, 15 Nov 2023 10:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072471; x=1731608471;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i4ds6xR5qF+F9kJfmY80tsfbBWCWvbONjXBDw9FgIRQ=;
  b=HVQShyoSkyDJ5ipNHNLkv3uK421JcExBei+70HkcH8zAaBbc/mZMEyUv
   bVjjmayI/fW89AiQie6WMUcBwc+aLb7YXaeL+jaOdqKmNQM/cJokAh8th
   Se7L5JrSyTPHwOKV8Arm3niN47Q2hH3Xg8l7cAIbPK6HJ/4j6dLW7kU1u
   4udQ7KHGTa4WI0uG3zTbTkDEJSNEIbCWAUjJh6urY18LSiFCnSIM1gMRV
   fWN8U0UJvYLkseevZOAah51ia7HjYsrPxerBcJWzxhq30EDUPqq5wMMXU
   hFbVBCKxv+xzh4PBl1yQGd/s9RjSpV/JuoTymDgDJx5MJtttx/Tk9NidY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393782591"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="393782591"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:21:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="6474487"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 10:21:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 10:21:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 10:21:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 10:21:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXkmEbXaEgvlV8tO73XWm02uuN6tp4xNWNZF7GxQ0kqQeqhvEC/3xrbiLrwdP7L1q16Pp0uG4gz6tEpf7cp/8ffTsIyCUHCtM5uWrZlvdtZRdjgrih16vGsSL96DAnKkJuw1GbwFz8DomQhSHS1p2vbwwMZJrd5SsNWXnrzokdz1v6jZ2U4CgIIHecJgR1gSFQBsUtq24UO3EqfHr4vA5YCjRi6feNb0vpCQAOqSbYh+JOoSPTbq8I9UMYDzMhjWEWS4eVaOS5ysQkAFTbs9MmZpg7ynIn8A3ZKRxZ7036din3U8hAeVuFdcZsYhlih7j38yI1+dQ1RnwMMWP+dlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mGyTrUwEunAEkWkyneCQSyK0qXJc3W4aMM5aOnZEp0=;
 b=d9vm06xL6rgEBy1FlyfKGlJGnJXuI8MjlIzg05h6bQhKqBf3Hdwj8rsZGpEoGZxo8KE5eyHz0W9DaFeX/kdN+/16NP88MrARTMVYJMCRlJ3kSRUck76bL6JGL0NAcftXRZjXGiJzShNHF2bJrEbNpVgHub3oSxujcftC14s5PaDyfabYqQzL2BOpFVs66z48HTaiNHf9ViL95+gLwJaVUOR7Xy+Pmv/yZRW3Cfbb6hUfcxcrxGLOybXNUli8wprMAw1FPpFiDvbNxa9ichJ1/Eh5oU4XnRoisddyzFA7MSplGMAFGzoxge//duPhbUtys3br6ujUbbVQrtQ6Q5m7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB4925.namprd11.prod.outlook.com (2603:10b6:a03:2df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 18:21:06 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e%7]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 18:21:05 +0000
Message-ID: <1ad8c9d4-0436-48be-ac55-67a09c747dae@intel.com>
Date:   Wed, 15 Nov 2023 11:20:59 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [RFC PATCH 1/6] cxl/mbox: Add GET_SUPPORTED_FEATURES, GET_FEATURE
 and SET_FEATURE mailbox commands
To:     <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <Vilas.Sridharan@amd.com>,
        <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
        <rientjes@google.com>, <jiaqiyan@google.com>,
        <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <"pgonda@pgonda"@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
        <linuxarm@huawei.com>
References: <20231114125648.1146-1-shiju.jose@huawei.com>
 <20231114125648.1146-2-shiju.jose@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231114125648.1146-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c036ad9-e44a-4178-43e0-08dbe607a161
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNeynxzTc2lL+bsBAJIADbfFAgAqggXzHVT1wSY/qKw7YPwbMUf1su9TsYQUk215KJZGrt0oF5m9/XWxUAYIhxXla3HSZi/9gQyYuvyqsbgOCEF/qepsWROWlP6CwaTOHzqCiPXD8OIZ85yj1EPYvaeIGj4dCDQ+v/xmGpKCeD2i9cHEzWw0n+ly4Uf0/rovZw46DGJj0p9Vrsd3lSywuDu30NLcOmPl+UXPwyQFRaZzlXsos0zCR5l/3TWYpQHs6C3BwG1p5uN4WBTHnEwL2HyxMBNiy9sY8C99TpH0DlIBMIEeDG1/jUfOgzHAeNHR2JbAvqbm6ZSX0uShu2OBqj0Bnxpvsqx3cAItnTBn5IfkAYfxwiS1P6BJ29lOtst5SbQIvsanLPz+m6g4ZZ4wfCiFDE3963aBsZm3Xi7OraqjMNfzU2EDFhryjO2HEYZej4Gq1gnJwFsCuwm2RdF2VwPZMUv6O6Sgt3FpcsTlvjqL/tcvYlODkZGQ2AsoepuTSV8W2BdhqfXHt2C34wIhAuTevoJ6I4+jIj221GJ4/4r2D0/PZ5Tbah1GWte96N0+rNnzKNY5VzFb25hCHjuKEUEcIpdWBNNSvVqOGMhzfFBNmekqW4P+go5LmYZeBsGV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(6506007)(6512007)(83380400001)(2616005)(86362001)(82960400001)(38100700002)(31696002)(36756003)(5660300002)(41300700001)(66946007)(66476007)(66556008)(44832011)(15650500001)(7416002)(7406005)(8936002)(8676002)(6486002)(4326008)(31686004)(53546011)(6666004)(316002)(2906002)(478600001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODNNSDRpY2U3bEh5ZUpEVnFSOGxUaXlwTlpVVGJSdkdrRFVHZGkxeHlsdklN?=
 =?utf-8?B?aWhZTnhTV3h3TkovQ0YzYUJlcnhzeUkwaFpvVDZabEJwbHNhYkZ5N0hKcTNl?=
 =?utf-8?B?ZnFCSmVkWFlDaUpKRWRCRFFxcmFvcHZSejVQeTNpSjJ1Z1o4Wk1oUFZJUWVH?=
 =?utf-8?B?dEZlM0YzSXMzdmprYlQ2MjNaNUdnM2tVNzBDQVZuNTBoUGVwOXBzc0d6VHg0?=
 =?utf-8?B?bkJQRmIwUVRYbDQzNldnWTBEaU5tZGdocWowblk0U0VOUGZMT05PWk5sRllv?=
 =?utf-8?B?a3dzK3l0amduYVAvOGM5aFFQNHdwZTNCMDVEUDBZYVlVTWRqSW9UWm01K1Jm?=
 =?utf-8?B?clp6YjJuOGZPcWowV3hHeHpOL3BqK0k4MnRRdkZMUEVLZTdjSUcrSW1BeGFI?=
 =?utf-8?B?bTNxWG1iZVZMNFFLU3VnZ0FySE1rOGVNcFhldW12YUU2Sk1ENklha1JINzho?=
 =?utf-8?B?REpUd0J1YTcyNkF5dUN6TnhQakRCNjNISjlWd3NhZThHNms2QSt3WGc0cm42?=
 =?utf-8?B?YTVZajgxMlduUU0vRXdoSjdHbU1jODlMQUZ1c0xUSW8zSHdySUNpcHhHMFRV?=
 =?utf-8?B?aVoyYmZQK1ZGZWpFa3pKbEszem5WUWlQUUNxUG9sZ29CSG1XRVdNd2FKZnR6?=
 =?utf-8?B?bkIweUUvQjhlZEhLMWpUcFd6d2ZPQ1hvalE5aHFTMFAvckh4NjNxL2VHUlp1?=
 =?utf-8?B?SHA2bUxCMmp6Z3orRFNpRWRMdXQ0U0tEaFplcG9NVkppMmR3QmtBNzg3b2JG?=
 =?utf-8?B?QTV6Y1JtQUlWWFRvNVdZNG5raW11S0pJRVRPUm5sTjBxaXJWTWs0bXdPKzY2?=
 =?utf-8?B?RmVESHFjRjVGT1J1TXJNV1B5RVp1VWRyYmNDT0VyejlMQ1dzOTZ5TEtIRHZN?=
 =?utf-8?B?b2wxM2hiUUxZT2h0OVo1ZEZlSDczOWd0QUxoVTJlTzI4Vm8xZ01MSG5YUGk3?=
 =?utf-8?B?VUsyRXVheGR6Z0cxTGJmdGc3WC8ySm9YUHdxU3JYV05YWlRsaFpyM3FVRVBW?=
 =?utf-8?B?Vm5mYVA4NjJGWE95ZGUyL0NyQWEyTlV3L3BiaWtuemk4VHh4RzkycXBiTDJL?=
 =?utf-8?B?ZkJLVlFjM1RMRmZIYkw4M3BsaXE4MDZVbGw3bU12RkNDZUFrcWZDclEyZ0Vp?=
 =?utf-8?B?c3dlOGVuYVVRU3BVWHBrdG5rZWF3RkY4c1lqRTVZdmtjV1RFeU5LWjdvZjhu?=
 =?utf-8?B?UnpVL3Z3bjdXSkVibXd6YkRLelcyNkVBMjlZbkJId2ZTek1DQUd6b2hXRU9y?=
 =?utf-8?B?U21uWU9jMzc3TzdyeXMyUW5xYk52WmorSkdxdndJeWtMWTdzL21zT29IOGFl?=
 =?utf-8?B?cnEwclhZWVd2MXd2VDRDbkI0U2JWR0F2ZnpsdTZTUnJobzRqY3NQT2RIcnJw?=
 =?utf-8?B?TDJyUDdSWE1JcFl0UnlKZEdWZ3hrQU5WSGNCalBlMkg3MExtRjh6aWcrR0U4?=
 =?utf-8?B?LzEwQXYxWStBeHNUalJRd0xIQ1ltKzl5UG1aVXB1dzdXZ3hCeEFJRnZQMFJZ?=
 =?utf-8?B?NnJhWXhaOEFsaysyVEVrZkpkR3ArM1ZJajcwMENJREp5dTF0TEE2M3FGNmNK?=
 =?utf-8?B?NG4rSmZtbzJjUSsxRHpTemlqQTFkdUVZU2FnVU1wTTFwc0ZKUFo3TmFka0xl?=
 =?utf-8?B?Z0hjS1grMXV1dm1kZ0EyZEpocHN0d2xVWDZYd1ZBa0pLd2xvVWhVejJhKzhU?=
 =?utf-8?B?MUNncTg5VTVpQWwzeURSV01vSitzSWxNQTB6cjhiNTNDdTkyNHVRK0w5eEtD?=
 =?utf-8?B?Q3RHVGc2RnVEdCszSTFYNVFFTEllVEZMQU1aUmFvNERIOWZVUEVkcjBaYW9M?=
 =?utf-8?B?ZVpQMkFIeHFWNjRONGtRVnovVG00MDVRbTJ1M0ZZSWMxRlVQZEQwOGxCbWMv?=
 =?utf-8?B?Wm9lWHRNbHVia0lRWEFFNG51QnZoOEV1N2p0Wk80ZUlJZlhuWUZtN09HRTdi?=
 =?utf-8?B?YkhOTnUvZ0k1WFVzR0N0ZDZpNzRHNzdQazVscGFkdTFDbzhkTTl4MnV6U094?=
 =?utf-8?B?ek03K2ptNkkwcmpQNnY5cnNWSlRxRzVPaWs2c0tUaEZuTnMxZHMzcEVnR2ZR?=
 =?utf-8?B?SFBacVVsUHdRNitPc2doUVZYUkFxWEx0Ty9ZRnl2M2pHQkljTUdHSzJNc2sw?=
 =?utf-8?Q?s7fcC2mMO2FgepqkMsFDwxNZI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c036ad9-e44a-4178-43e0-08dbe607a161
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 18:21:05.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMveYlZTW5OmQ5aGRWb0XscVdpaf4SS4dScFjFiOVeDRdq2Io9d6z1fT94E6HdzEfkUtx1+akAxO+xr3W9NE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4925
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/23 05:56, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_SUPPORTED_FEATURES, GET_FEATURE and SET_FEATURE mailbox
> commands.
> 
> CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get
> Feature and optionally modified using Set Feature.

Maybe split this patch out into 3 for each of the individual commands you are enabling. That'll make git bisect easier for debugging.

A few nits but the rest LGTM.

> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c      | 74 ++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h         | 95 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h |  3 ++
>  3 files changed, 172 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 36270dcfb42e..2a6d8ab927bd 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -63,6 +63,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> +	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
>  };
>  
>  /*
> @@ -1303,6 +1306,77 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
>  
> +struct cxl_mbox_get_supp_feats_out *cxl_get_supported_features(struct cxl_memdev_state *mds,
> +						struct cxl_mbox_get_supp_feats_in *pi)
> +{
> +	int rc;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mbox_get_supp_feats_out *feats_out;

reverse xmas tree declarations

> +
> +	feats_out = kvmalloc(pi->count, GFP_KERNEL);
> +	if (!feats_out)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +		.size_in = sizeof(*pi),
> +		.payload_in = pi,
> +		.size_out = pi->count,
> +		.payload_out = feats_out,
> +		.min_out = sizeof(struct cxl_mbox_get_supp_feats_out),
> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0) {
> +		kvfree(feats_out);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return feats_out;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
> +
> +void *cxl_get_feature(struct cxl_memdev_state *mds, struct cxl_mbox_get_feat_in *pi)
> +{
> +	int rc;
> +	void *feat_out;
> +	struct cxl_mbox_cmd mbox_cmd;

reverse xmas tree declarations


> +
> +	feat_out = kvmalloc(pi->count, GFP_KERNEL);
> +	if (!feat_out)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_FEATURE,
> +		.size_in = sizeof(*pi),
> +		.payload_in = pi,
> +		.size_out = pi->count,
> +		.payload_out = feat_out,
> +		.min_out = pi->count,
> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0) {
> +		kvfree(feat_out);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return feat_out;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
> +
> +int cxl_set_feature(struct cxl_memdev_state *mds, void *feat_in, size_t size)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_SET_FEATURE,
> +		.size_in = size,
> +		.payload_in = feat_in,
> +	};
> +
> +	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a2fcbca253f3..fdac686560d4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -506,6 +506,9 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> +	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
> +	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -740,6 +743,94 @@ struct cxl_mbox_set_timestamp_in {
>  
>  } __packed;
>  
> +/* Get Supported Features CXL 3.0 Spec 8.2.9.6.1 */
> +/*
> + * Get Supported Features input payload
> + * CXL rev 3.0 section 8.2.9.6.1; Table 8-75
> + */
> +struct cxl_mbox_get_supp_feats_in {
> +	__le32 count;
> +	__le16 start_index;
> +	u16 reserved;
> +} __packed;
> +
> +/*
> + * Get Supported Features Supported Feature Entry
> + * CXL rev 3.0 section 8.2.9.6.1; Table 8-77
> + */
> +/* Supported Feature Entry : Payload out attribute flags */
> +#define CXL_FEAT_ENTRY_FLAG_CHANGABLE	BIT(0)
> +#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_MASK	GENMASK(3, 1)
> +#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_NONE	0x0
> +#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_CXL_RESET	0x1
> +#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_HOT_RESET	0x2
> +#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_WARM_RESET	0x3
> +#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_COLD_RESET	0x4

I think you can declare the flags as enums?

> +#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_ACROSS_FW_UPDATE_MASK	BIT(4)
> +#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_DEFAULT_SEL_SUPPORT_MASK	BIT(5)
> +#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_SAVED_SEL_SUPPORT_MASK	BIT(6)
> +
> +struct cxl_mbox_supp_feat_entry {
> +	uuid_t uuid;
> +	__le16 feat_index;
> +	__le16 get_feat_size;
> +	__le16 set_feat_size;
> +	__le32 attrb_flags;
> +	u8 get_feat_version;
> +	u8 set_feat_version;
> +	__le16 set_feat_effects;
> +	u8 rsvd[18];
> +}  __packed;
> +
> +/*
> + * Get Supported Features output payload
> + * CXL rev 3.0 section 8.2.9.6.1; Table 8-76
> + */
> +struct cxl_mbox_get_supp_feats_out {
> +	__le16 entries;
> +	__le16 nsuppfeats_dev;
> +	u32 reserved;
> +	struct cxl_mbox_supp_feat_entry feat_entries[];
> +} __packed;
> +
> +/* Get Feature CXL 3.0 Spec 8.2.9.6.2 */
> +/*
> + * Get Feature input payload
> + * CXL rev 3.0 section 8.2.9.6.2; Table 8-79
> + */
> +/* Get Feature : Payload in selection */
> +#define CXL_GET_FEAT_CURRENT_VALUE	0x00
> +#define CXL_GET_FEAT_DEFAULT_VALUE	0x01
> +#define CXL_GET_FEAT_SAVED_VALUE	0x02
> +
> +struct cxl_mbox_get_feat_in {
> +	uuid_t uuid;
> +	__le16 offset;
> +	__le16 count;
> +	u8 selection;
> +}  __packed;
> +
> +/* Set Feature CXL 3.0 Spec 8.2.9.6.3 */
> +/*
> + * Set Feature input payload
> + * CXL rev 3.0 section 8.2.9.6.3; Table 8-81
> + */
> +/* Set Feature : Payload in flags */
> +#define CXL_SET_FEAT_FLAG_ACTION_MASK	GENMASK(2, 0)
> +#define CXL_SET_FEAT_FLAG_ACTION_FULL_DATA_TRANSFER	0x0
> +#define CXL_SET_FEAT_FLAG_ACTION_INITIATE_DATA_TRANSFER	0x1
> +#define CXL_SET_FEAT_FLAG_ACTION_CONTINUE_DATA_TRANSFER	0x2
> +#define CXL_SET_FEAT_FLAG_ACTION_FINISH_DATA_TRANSFER	0x3
> +#define CXL_SET_FEAT_FLAG_ACTION_ABORT_DATA_TRANSFER	0x4
> +#define CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET	BIT(3)
> +struct cxl_mbox_set_feat_in {
> +	uuid_t uuid;
> +	__le32 flags;
> +	__le16 offset;
> +	u8 version;
> +	u8 rsvd[9];
> +}  __packed;
> +
>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
>  struct cxl_mbox_poison_in {
>  	__le64 offset;
> @@ -867,6 +958,10 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
> +struct cxl_mbox_get_supp_feats_out *cxl_get_supported_features(struct cxl_memdev_state *mds,
> +						struct cxl_mbox_get_supp_feats_in *pi);
> +void *cxl_get_feature(struct cxl_memdev_state *mds, struct cxl_mbox_get_feat_in *pi);
> +int cxl_set_feature(struct cxl_memdev_state *mds, void *feat_in, size_t size);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 14bc6e742148..8c89d323cc41 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -46,6 +46,9 @@
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
>  	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
> +	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),           \
> +	___C(GET_FEATURE, "Get Feature"),                                 \
> +	___C(SET_FEATURE, "Set Feature"),                                 \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
