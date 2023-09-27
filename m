Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7787B0F35
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjI0W6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjI0W6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:58:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B446121;
        Wed, 27 Sep 2023 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695855525; x=1727391525;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dAPKDx7EXOuurcEJEDiIB+aSrvUlNyPdwGXAVedCuFU=;
  b=l/xHZ4KS7balS8W+ML6V2ouGFh49V59YuOyECJYPXO1gV4yvUmVufuy1
   3i29e2vcM9dYgo0dAjklkBkIaJfW/39VA5vYtmJWB78gx6CTRtjjiVcdW
   e+9Vwh/Vobt7shPhvO6fLvR9GOdEu+qjRPC3MmTdsPMSlPTWmqmF4aEtv
   L+Bei0aHWjozQJETLsz8AEHfgSeIf63cZT+Nko2LKOzZhAOaoNms4nh7L
   pg8lEHUx0AKOzobUw3UKTLrI7z9ufwLii+6CQTpC2aXtpcmxK3ydn/jVh
   XfxjxUgo6Blvp4PjF/Mn2udyFOY8DNub0AeuLpOkZ/Iy7HjFTmAFKT4WH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="384740720"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="384740720"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 15:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="778704137"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="778704137"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 15:58:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 15:58:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 15:58:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 15:58:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 15:58:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDS+TAselO0l6ZzGwv/pFaX5yW/bczLOzz+0sJg2OH6dAWSxZvUzAZ2NIWzpoE3D9aF+HmDz/2U2mvGOTqMXj5fJmfehV45mZKKVz3v2hG6b1MQRlRj4f+hmWGilQkUDmqxSykCq7v06sI7A/LeJ1/uO2aImQSfP44pi39QOy9gh+WRiTi4waJRR5Hx7Rb0Im2FN7UB60OxqNEJGSaA/xLZa6irTjhcl0ZmAOo0UpQE71feXMmc+RB9ryoLOHHBTaDSKsRr5cbFjwp01N514RbVfBYGYj2MrRdiWP4Hx9+jurjKSO/hkMuIUTut46sbJdphe7IG0JQYAIy1ZRqv0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14kP7/XhVWmWmbk1iHgfg1+L0NtKXHxEXJabn92pYkw=;
 b=JsDMLn7sxoGV01mvTWc92QVur6pN49PO8vS9dtANDR9XCl4uNApiMZakFG1PARvzU8zou6dtB5y1wukOq8euHum8BERi1LHNgywXII1iX/uEzhLm4TvyjS7MRHFprlsSBqhQsJJpfcn+0p0VPwVlba/qqCLHJIPyikw2ThL6g9vXHxOXeKT83H6x51bmEGkOGuF4iC5wT8ojVvGe/iL+9vrIpAu15TUZuLPiRtn/LpX+9kaJ+U+wNHqyKDZ6L6mMqyLACqUgY/PlfAzkrM8EcDIMsvHQfVZMxiJvnzDfiJxWXbjY8AyIb/jasSZEvvMHUyruafN7SOlSFE38SZyC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 22:58:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 22:58:41 +0000
Message-ID: <bced7bc7-c489-7a57-374f-62818cbfded6@intel.com>
Date:   Wed, 27 Sep 2023 15:58:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/4] Documentation/x86: Document resctrl's new
 sparse_masks
Content-Language: en-US
To:     <babu.moger@amd.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <308c92438288a45a12330af83aa0088a31f60343.1695371055.git.maciej.wieczor-retman@intel.com>
 <17079b9e-4efd-4258-2b5f-afc6d3ae2c0f@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <17079b9e-4efd-4258-2b5f-afc6d3ae2c0f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:303:83::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb2f696-5925-4621-ca62-08dbbfad4ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aymJ3WgkJ1FUj3IxBZheHF28cgDcvkdv4jycG6OH50xU36FA/RPrQuu3EorC3IOSxuCR6xKuiDs5LGKmOAgatKW6RdsBWXy2Zdqzp9okDwrFbnEG6H1u6N6b5q9sKJWVfZy6+DO9mFzvt3Hlgf3CIVC1w7y/JpESFIsh+Ts6BPNXgJkX54ig2jukJEBLWcotanMYzygT0avrF2cJN0pYQyVc7jZB1pP4p4a+Ay8luK6cSHgObBNJ3jSyBp021lfwVSRYrSV0Zh2L4BzJznAtqqavLm6LCVQjQ04M4xZLquiIuUHCa/wDiz4WkIbpBqyIIqWeVR4UVAViunxDHHR4eNHoAqyNJfnRDlV8mIXsMnEYklzk5DPxBOP1/cGqDhrQGZ9v01tCMyFrQ8MKelc9eJaQMsPxUDV3QeHceqm7KDfxNri4qHO4GpjRf0gz8iEjuKZJKGs03fh0H3PbIIaNK5HIs96W7eKcgiKIGm1o58ARxX85QGuAlu2uzEN5Vrw2FGu0F6nezUr2qAbLIHVQEcAIcmOU6MoId56xeYbNcjLfZF9oJtMu8vYyAdcnLzFheDe4pac8gCLq5BULgfqPlaUk48MMWnJSgL9txBN3AyTJtGid+5l7Id8+ABHtO0VXBZBxulztWIFT+oNY/K4yTIP6FeGwrl+GHwQkqIgH68=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(36756003)(44832011)(53546011)(41300700001)(83380400001)(6666004)(921005)(8936002)(6506007)(4326008)(8676002)(6512007)(5660300002)(26005)(82960400001)(2616005)(31696002)(38100700002)(110136005)(66946007)(86362001)(478600001)(66476007)(6486002)(7416002)(2906002)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5JTDJidEtkTCtzVXdpWHRwN3lmRnFaNFBSTThaNnJiRXhkak5ya1RlTVl0?=
 =?utf-8?B?ZHNxN0h3Z1RzNWdCOTlLSzBHSmNoSGFVcTRYRVVWcHpOekNDNVZKWWs0R3Mr?=
 =?utf-8?B?SDdrdFRjV2RmMnR1dFpOQ1F4eXZodHZiUC9UaHhmV0lubTlGLzloMlVRSGFt?=
 =?utf-8?B?TUpxVUV4T1RkdEN1c3RkZUdtODNZZ0xXREdYc0UvZWxSMmtmQzVmM0IwNWJC?=
 =?utf-8?B?cXYxME03Z1dYcGVjOHFQeDJ3dEVGbm45L2J1dVUzd3R1amdCVHk3Q3ZCUDdE?=
 =?utf-8?B?TzlvTnQ0ZWwrcDErZ2hTV1NqaHMveTNKdkZDZExLdkRWNzltSEtoTlRCUU43?=
 =?utf-8?B?V3RkNXNkRXJLZ042ZVZTeTd1L25FNjIvMnI0Vy81YXlEL3JZbWRGeksyY0Ew?=
 =?utf-8?B?L3dESDJybUwwWnIwNy9OUEZFWUdBRlFBalJjYkhjbVhyejJYSjBpNmt6NHNM?=
 =?utf-8?B?emFQajBzNGhxMGNlSkVPaDh5R1NpNlRMUXY3YnJzVVdPTWFvUkMzQTlYSzNG?=
 =?utf-8?B?a2xVUk5WaHNlT1VpWnQvNzFHUzhHTlBGRmZ2dklkendzWFpyUmNYbnBUL3k2?=
 =?utf-8?B?WkZqS2hnanVYdy9LRUNyRFh1OCttY0JpRjNXYkd1b1lDcXBGSjVtWWJzNk9W?=
 =?utf-8?B?Zkdjem04bzUva3R1TnhUS3EzRTlaSTZ5cUJhajY3OUxFRi9DVnBHY1pNejQv?=
 =?utf-8?B?TG9yU0tHRG5GMGtiZ3h3eElMZFljOTZ1WHFQd0dRdFk3NWl5L2Vrd3dSMWFi?=
 =?utf-8?B?NjdvZG1pR0s0SFBNUWo3enA5VG5HQXdMMUVZZ242TWVrQ2tldTFVOE8zNURa?=
 =?utf-8?B?VkxUaUFtVW9BMXNSWDJsUGxVRFVreXJnenZEVlhTaURRWlIwaVlVMmlXV1dr?=
 =?utf-8?B?Nm1adzk1ZXhIRVRhUFU4THpjb1B4bWE0cm14QkdpR0xlVitwSnpZYTM2akNM?=
 =?utf-8?B?eTdCMzNNSXlwTmZXaWwzVHdTend0VDVXQjh6cSt1MUNINWptWGRKL3pHYk1v?=
 =?utf-8?B?QjFydS81a09HUEM2ZjBFVjRXVnlKNnlrazdVbVorZlRwMUdZTEl3WldDdHJ4?=
 =?utf-8?B?amVNNEVraTZQYjFiM1hPMWZZd09ybGpOcldLTmJYSFBuSjVUYzlRMmNGMllx?=
 =?utf-8?B?dW1oYXpmT3FyTkdFampuckwzT01xUVQwVmN2S2ZwaEZOaEpGWUFlbUR1MERl?=
 =?utf-8?B?d1VaWUNGUlJLY3JrN0xuYmxrS2dvUytJT0JVWnhod0s0MUJ1eUhWeGJvZE5T?=
 =?utf-8?B?VmZLY1JCSk5SenpQQy95MTJua2IyL1QveWtkRE1FUnQvY1hXbC9FZ0RFTUM3?=
 =?utf-8?B?bWI5SENjSnE4UzRCK0E3aHRITzQybURmRDdKRUovNEpwREFsN3NNeEIvYnhn?=
 =?utf-8?B?RWxEellsT0RvZUtlOVI2bnFzdmZ0cWxhSThQQlNaOG9EenZsTi9UNzUvSFI3?=
 =?utf-8?B?bENBcHFkbFFFSWNFQU9wb1JJYUpXUHk5WEFyMzFEcG1YdmsybjMvWWJCL0w0?=
 =?utf-8?B?TElTWVg3N1duWHNSM2l0c2doRW85YTA3YWcyNG5ITVJmTHlJVUNHTUtHYUJn?=
 =?utf-8?B?TjNQaVcyaGxFN2NFS2RjT0tlQmlJRkNvUGhoeDR2MDNvRHZIQkJGK3JqeVhD?=
 =?utf-8?B?MExjUmpBNEVQMVNXTUhRZHRoY3J6OGh5UnN1bW05Q2xSWkgzYzNiTGQ3ZVFT?=
 =?utf-8?B?NzZ2bXg5eGxDTmMvTEFIZ0JLMzRCOWZRNjBtWEpCK2NvdHd4ZFpVd1BMSjl2?=
 =?utf-8?B?VGpSWXJuY2hzOFFHZHZra0hmZVJWSmJjbnM2Z25GeGRtK3cwU1dzZVkvajFP?=
 =?utf-8?B?ZiswWGRsalk5Q2hma0VJT2pHeEJ6Wk1jVW9LT2hqdm9QWXFUdExJTll4OU56?=
 =?utf-8?B?Q25uZWxpZHhqSlhqcjdpeCtRY2Z5aUZ4OWFzRUlVRHVVNWRxcnl3cUpkQUVk?=
 =?utf-8?B?TEIrZWRkemtJSVFGVDVhZUdFQndkS1BGcGNOeFVGOU9MKzJTZlkyRXY2Z2Np?=
 =?utf-8?B?Yk5PdkpJV2F1TytYVWk4N2s2RTVuaTdqVGUzeGRVNG8wWU43RmVzS1U2OG9E?=
 =?utf-8?B?cXhkVUZYcWhYRkhaamQwa2hEMEV1SjJFRSs5OHNsYmlMVDM5V0RWTXAydEVP?=
 =?utf-8?B?d2tRVTh2blBDNHo2V3dKUW5hWWhwTVlpVFpGZ1AvM1I5dkUzSzBUVmVtTUtZ?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb2f696-5925-4621-ca62-08dbbfad4ad1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 22:58:41.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0b1VWshgOWLJtY0q3vbVOnM2v81GaNB7EDYXzCheGBG874VBBxkZFHE+aLCy2l29q08vAbMbcYuOGEzbqRDszVCdhjG+6s+jl3sHUUGvTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/27/2023 3:47 PM, Moger, Babu wrote:
> On 9/22/2023 3:48 AM, Maciej Wieczor-Retman wrote:
>> From: Fenghua Yu <fenghua.yu@intel.com>
>>
>> The documentation mentions that non-contiguous bit masks are not
>> supported in Intel Cache Allocation Technology (CAT).
>>
>> Update the documentation on how to determine if sparse bit masks are
>> allowed in L2 and L3 CAT.
>>
>> Mention the file with feature support information is located in
>> the /sys/fs/resctrl/info/{resource}/ directories and enumerate what
>> are the possible outputs on file read operation.
>>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v2:
>> - Change bitmap naming convention to bit mask. (Reinette)
>>
>>   Documentation/arch/x86/resctrl.rst | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index cb05d90111b4..4c6421e2aa31 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -124,6 +124,13 @@ related to allocation:
>>               "P":
>>                     Corresponding region is pseudo-locked. No
>>                     sharing allowed.
>> +"sparse_masks":
>> +        Indicates if non-contiguous 1s value in CBM is supported.
>> +
>> +            "0":
>> +                  Only contiguous 1s value in CBM is supported.
> 
> This is little confusing. How about?
> 
> Non-contiguous 1s value in CBM is not supported
> 

It is not clear to me how changing it to a double
negative reduces confusion.

Reinette

