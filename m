Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF4B7D183F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbjJTVfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJTVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:35:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A752D76;
        Fri, 20 Oct 2023 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697837731; x=1729373731;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4uBaV5gWt5hQ1EvlNqhy9jBWznYItgwFoDKFI3Rf8gc=;
  b=JEY78/eRfCEG5ip34YRN7X1akaEqyat6VghCLgQ+vdPznYiQ7yhJwaWZ
   izavM9SDkdrsSo1JzYdJamewqSsIGLZFSDp/NjZDdrJv/8F0KSlUGj/0x
   DY5DaKH5Q6aM5qurElaG35jB0bP0BDLXofQmDZKJkOZy98Ft7qOsf7Dhb
   vZIQY3Jmc5IwbHdORRSdJhThNlFaWMxe9u8ZWghMp2DOfsJoRL7QZwHp3
   CKeiYdP3VUmK6piPxF9K0dTQ1pq4uv+Q1EgwsEdvY6MUqGhHw1JXyCaix
   sJpihTIsXa+MInXISl5o+2UrAqXO9xOgmlDFyadaGIomDtPMqd+pviulf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="366807779"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="366807779"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="827856057"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="827856057"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 14:35:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 14:35:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 14:35:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 14:35:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 14:35:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbFGAaYygsUXZyrTjwEEFK5nRcWa8m4pO+P1ug8YZnVGoJUsq0xxo4rO37pfShurAY+lSZIvp4WowweIwIXnXFZFs9XNTnJ8Q/MP9/oYnxLRXY8U/jQYUfzKc7xd8HuHWaIZPGko8mSaPre4nwB0GJNGmJNSq5120ilgHdA8GYonvkY5vsKzzs7JXQmNihNCMs06RiwMp2vBgqG7s30QcxDW0KfuXZ2vBhLhidzWaruG9WoFK0iMQUKvpok5iiAFCszFQOiqgOtytsSEVeZF8VUqlmoFk8gtlVysSlMeS5jGHLU+aAgKDw/ZAHvQIwo6/JetX5Kl8u65OaLu2kVaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Tamb4h2TNOBNYYnWWw+iZOdQs7+6Z6llxpodW2HoJs=;
 b=S1Y6bNUAX72UPDqyjvj+iDWzKPqibZkAm9TtoZ6kWOhLcuO/gJoebSvEJvyzAOkerDIpQ1dyW11rFhXTCwzxbaYSjWpMb8H1uwTeZAuxAuWKcLTmOACdKZkJTueKltfF9l0j03UtZ/h/YzonWCiN/A8x1zh3zVdeiw7ihu2oEVMuRf+qdF4QKXrfbBKWuK1xqHyTwDzkJH5XSGPTyf/MaQSjhxY/FZjJ4zJQH1KGiP3c0hF23LtqYmzxxEEIOAQIBjwYM0lfUaZQ9Q0yO06uSBew7wm7Sw3gWIH9FeIJrwT77ghvQFfAnWZcl7lxPW+1V9y6Nu7JPIop3XiW6Vo1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4543.namprd11.prod.outlook.com (2603:10b6:806:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 21:35:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:35:25 +0000
Message-ID: <876a9c0a-527d-4719-a933-6c0b1aa9c4d4@intel.com>
Date:   Fri, 20 Oct 2023 14:35:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 6/6] i40e: Initialize hardware capabilities at
 single place
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     <mschmidt@redhat.com>, <dacampbe@redhat.com>, <poros@redhat.com>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231020193746.2274379-1-ivecera@redhat.com>
 <20231020193746.2274379-6-ivecera@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231020193746.2274379-6-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:303:b9::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 209b6100-1bcb-456a-bc9e-08dbd1b4790c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Nw446A/jDYYXPyXewwHr9XLLBxMhJwDzNfHwckxq/PUkNyATIs6ajeO0A6UyQ9NKJa6rbJAS1KLFnTnwligkSGBoO8f8JQBgig2kEXUyvZqfgaJeozrRhekKIi6DIW64iqHER4j7FFJooeIHSgC81dr1godkuSjg967yN0oSTnVlLJlRPVH4Q+vLi9cmVm5TktrXXqo1oRNWpFJbcqNQqtE9ZuZt9wzyLQ/4rYETq8mf01hVNXOLUIjXH/3fgY6MG0WurIcWYB+rtq7Gt80RwE9OAfaJi+QdgnxXoLDqrOg6G8BeARUdlz+xD/IbPqS4ZDhGIYqYhZk08lt/iWp2dth6WvFKtslGvGeJuUPGN/vG9A1NrmeXvOzjAFjx4hMHdgNxoO38k19t/o/KcCStJK9hT7x9Jj0KANj2uTTXs4ZLOQuaEKKaSesB2xmMPAtQ0cv0EOfAvK+4lxuvFtHnuInjvBxKnHK3PQ7B8YbZsP/LG7r8IBN4jcgpzSyPK5s4A3jmE5Hrl0gYyiYeAVDDQbv620VZIf4REcPVVrO27fl97L2vrfRQmaQ3RD2ue2SCot/HIyslL8jl7p+VSW4eEuqnEdOsgfuKh7UztFrOy8E2Wn335X5PpSrB84gO5xEvNtewEV+tyjeHtlh0QquZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66476007)(66556008)(31696002)(4744005)(2906002)(316002)(53546011)(26005)(6506007)(2616005)(82960400001)(86362001)(478600001)(38100700002)(54906003)(6486002)(66946007)(83380400001)(7416002)(8936002)(41300700001)(5660300002)(6512007)(4326008)(8676002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akRqVm0wNDBOUnFka2pVUXc3a2JVY1U0QXIxVzlKRDBaYUZRVW5RS0ZFa3hM?=
 =?utf-8?B?TVVSRDg4OEhoVU1FS1FJb2QyRWp2VkoyMVRnOVllS2RhUDBybGZPRVR6a3Qw?=
 =?utf-8?B?YURia2tpclN1UXliVFNtMEEwa0FEVkpFRmplT1IzaFQ3VE1WYjNRN0JSYy9H?=
 =?utf-8?B?TkROclVVa3JkZUhhTVZsbUxQdzFhOHU4RHg5OStRYWhTWmp6WDdxWU8vUm9V?=
 =?utf-8?B?OXQzd1BDMTFjbkZYaWRuVkMrbFR2V2RvNHYrMGVabmduYjdlWmNZREg1WDA0?=
 =?utf-8?B?UlBJZWhLTlJwRVd2SERRQ29wMlBOenFlU3ZxL0M5MGticFJEcW1PbTdiTE9l?=
 =?utf-8?B?Ni9EdFF6VjN0RDFBWjdUQjdkOWxkZVFyVjB3QkxFQkxVVUFPUGI5VHVYNkkz?=
 =?utf-8?B?dW5HY2dvNVJYWER3QWlQZWhidllrc2NHbDkwV3N5ZWZlS1FPRmZZTFhGMm1u?=
 =?utf-8?B?Q0xRdCt6ZWlMZlhoQldXRUY4RFUweFF5dStyVGVUbzEvSlpqc05VSTVDTUtY?=
 =?utf-8?B?Wjl0cTJjSFVtZG1RSm1pTjZ0S2tHWDNmcVo2R01sdE9rdC81Y01BZ1Bwc3M1?=
 =?utf-8?B?RHdSTDduZVN4d0ozUHg0T2lmVWVGNCtIbHgyQktDNWtDbEsxaDJneGNYQzA1?=
 =?utf-8?B?RUd0VUltdXFSQUswLzh0UzJsNzFhTG4yRGhSY1hrakhVQVA3cGN1RnBqM1lH?=
 =?utf-8?B?K01iZ0JuZVcxNVlzdHgxdHdMSUdnY3hmVFowbXVJZUIwR0YwcG14MTRsVTlN?=
 =?utf-8?B?YkliNW1vR1R3cmJSd1l1cHFWQWd1ci9MZlIwUUVCUmYzQ3JONkFuWkJwQXc5?=
 =?utf-8?B?ajIvSjBLcFhPTzRWVnF4N013V3hsM1U5dURQMjlOUVJWUElHdldLZkhEZzh6?=
 =?utf-8?B?SGh1STd5NTJwbTd6cnVESTkwK2wrUHVIVWwzS2EyR1lSWFFCa29zTVdPZ3R4?=
 =?utf-8?B?emJ4RnFNaisvOHZXeWZDU1M1bUIzVER3a2dzSnVGU3AxNW95TUxRWENyc1Zy?=
 =?utf-8?B?VlRkK2NLbnhHTmVHRFhIZnM1NzVHRmpwTXFhSHdsL2ZwYk5uUkVkS1hlcmZ5?=
 =?utf-8?B?UUs3aHFlRytTeXlHZ2lBbnhRZUNxTFF0dVNRcGZ4SWJ3WVJzSEd6a1Vxd1Y1?=
 =?utf-8?B?eXFCQlRkSnJyWHM4dG5UOG5ubnZTeG1wcWJoNDhTdGRpdTVUcytvWi9XTkpt?=
 =?utf-8?B?eWZHVDNTQ3JVb2xBWWJXTnUweHRoT1dJMEJGcEgyYlRvNTJxSkRmMmdGT0Np?=
 =?utf-8?B?bmJraityaGI2bmlFbitIdi9ZOGtGSG91amM2S0dVR2t5T21sSXVEK1JXRDBk?=
 =?utf-8?B?dmVZbXZrbEJCT09kWlpOODVnd3AxZStmb2xtN0x4RWl1TWpuRUpYeXpRRGUr?=
 =?utf-8?B?SVBIWnpqRUJsZFZLWjR0NUxzclZxbjRxOWxScHZ1RG42QjljRHFhODdPU2Zl?=
 =?utf-8?B?UHpxampFN1pRdzNOSmFaUlpsSWs0ZTk2d2tHWXE5Qjh0QjY3dDVtbElKSWQz?=
 =?utf-8?B?cE1taGhrSHFwY3BhWm9VVkdDZnpwdko2UWlJR1licWJ4Z3Z5dXdCUExNVUFJ?=
 =?utf-8?B?K3d0VVJ6bGVhMmVrRzBxdEFJN1I1SUx5Y2FiSUF1NXcyZmJ6ZjMrdlJXL2FE?=
 =?utf-8?B?VDhlanJSM0NQQmdMdm9pYUZ4NzFoMkFuYml4ZktCRTBCRlpBYUdSZTJUN2pa?=
 =?utf-8?B?U1V1TjdBcWR6bWk4MEVzOU10ZE4vd0ZQbmp0SDJ0SWNnZzN4cVlndHNZc3pT?=
 =?utf-8?B?L3labUkzQVpuTnJveWxTNDU5aHkwRmJwbU8zY0dndmtCSWZRMVlWRmhydENs?=
 =?utf-8?B?aHRIaXJxNnBPMThQSUxPQWxzT1Z0SUhJeW1Ib09MWXQ5ZmRoZmNadm05UVNu?=
 =?utf-8?B?NTVkNjhPT3RTNVFDaG1kS0pzK0liaENZQ040ZW55ZUlpVTBXK0JQbFJmejYy?=
 =?utf-8?B?bEU2RG1SVWw0YjQwR29RWWFZT0EvQThqd3RXVDJrSjBHV0paWFBGZWRnRzJT?=
 =?utf-8?B?cmJqR2NlVTRyeW11b28yWnRGTG1yampKMWpWVDRpbVdPOGwvNnZqa0xMRmli?=
 =?utf-8?B?MmkzcWRFRWU4RlNNbEVaQU9iOUFSdFNlVG9pSnhid0tmamFSd09ZY0xwcUJ6?=
 =?utf-8?B?a0RQcnVjVEVmZUtEOEp5ZCtXWGJkMzd0NTgzYTlFV1pKZUdyM2JPZk92TGpo?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 209b6100-1bcb-456a-bc9e-08dbd1b4790c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:35:25.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3rJfuLXAjaUIUYptkh1T/2gZ1WsRh7F/AQiq1dUmzRGXjDzUPJm6VDM7koAlkebRv8A71TbyLh7pUNlcqai1YyWbB2yb+wccYkpxaRh+Zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4543
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 12:37 PM, Ivan Vecera wrote:
> Some i40e_hw.caps bits are set in i40e_set_hw_caps(), some of them
> in i40e_init_adminq() and the rest of them in i40e_sw_init().
> Consolidate the initialization to single proper place i40e_set_hw_caps().
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
