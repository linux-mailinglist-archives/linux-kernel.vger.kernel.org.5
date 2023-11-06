Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691887E29D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjKFQd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjKFQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:33:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE967191
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699288429; x=1730824429;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=paamqpNwWFMOzBKj32LUI8YL5QX/gsYrnnBWsD0SrIY=;
  b=B6NG8mWFAPlPG0jmG8YjaRYHmEXuAG+n+NWcni5188szYgR3Hqo3u55y
   R2vVMMvCZvny3X0CXzRSe/Rk08fwkRmOn3JBRM1zU/SyNG4+k4vvsICjY
   eMIAMy8iU1XorTLi1QtJV2ZkKN87iy2RkPbyXwnY15IRjL8dO00xCUkAq
   +QIsHpkKBJakqwV7sbmvjnpqHwz8vLFoinTI5TGtpUaj8pv8UMvlLztsH
   Qh/CTXjgw6FpAB/yGhwG9ME5FRHMx4JsHOEDPRl3fN0L2WajXU77uXA1d
   3OncLrV83UCIycV1sWAG7NHWr3GSN4aej5buVI8OrDSJyuOKFVsUQPkdo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="420423581"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="420423581"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 08:33:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="853055718"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="853055718"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 08:33:26 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 08:33:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 08:33:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 08:33:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 08:33:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQtSqlNekpS8AmrR3O6QZRgDoqn0L/CLwNdxOoCY9pKCtt955z3FM07sMhn+xG6rMNuLuQQOyiSTox4XdcX3OslCQt6ecBCeLw/hS4KMPBtEMqzw3Gs+YtRfa21y1kMu7Vd/kyMUYM1wE45T3R2WhDLzBPtyCN9HWnpLBPBojbKUVl5hWb+XA7okNyGX/O6icgaMVG7Ngjf792oBfDQkNuC6e5lLOz7f2FE09HboI5nOK/4RMU2hNkIe/lr57D1ep08mWwZb4XqyPFOhgAV2Nf3hE28tj1n3B9VKwSdRJLZvCssYLXS8d+JgvYQM53pgPQ2NA56pcjP5PNhFpexPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iugwxKCrxnPexcKAqigrOLjKz0XMI50bDanEaLrU2mI=;
 b=HnxmahVqvE86G7vKmts0zIN/QE9WvTe+0vku3GhRv85kbcN6Gx6scgWoMOmqadMiQ6KhEjHe6CZkX79BLPprC9RFJfM+X5HcwHK+lvPsJYxbAgfocOyp238cWCET+syTpLM22pAWNEgc4kDtljFkJxk7ErAGxhddxblxCkUzvUAlxDy7LYhITwOxMl6iM5fn5lh+nwwQPhbH/VS6JgdsUlQ4XCVp+N4s82VTnbaL6v0Ilm+xBw5HK/0BV6+Sifye73xA0y38z0JvrrJtL5KmB7YsKe8sG41RFAQmrAQiFpGojjG4NeKwgsWGgCAESrWbol6etvSfh2nPg4eJgzhflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 16:33:22 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 16:33:22 +0000
Message-ID: <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
Date:   Mon, 6 Nov 2023 17:31:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
To:     Alexander Potapenko <glider@google.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        "kernel test robot" <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202310170708.fJzLlgDM-lkp@intel.com>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202310170708.fJzLlgDM-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: abdc3d36-a207-4d04-63ad-08dbdee617a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFQlijLEl8Ssod1PZ77JcPefvmCL1Opv4+8ph36sF/amYlPTF1qrMT7TPaVUJSIf9Q6VkGWQMnxC0xRS402KkYUqpGUy2P4A90oV0SM3HVJw5uJTzskUAxnMFTYJl3fnTiaDZkEb9zl6kpFW1J30Vqi0mudzAtLBmW9RRkHoOP8OFywf07OQnJPB+xcTxfwPolum6J4KSl9jsoXItv3s3JgyXdkubkNCCNUr0jWmVihkYcpDb5uTiTZB5rUv1z1KjNcctRJXahnBw139lEh9jvgLvvjwMpSwqvhpAbpwqFnX/GlFJjbryurz7p8xPqQwJaeWvUv1OEglsJSPhoRBr4QALOlKEBilWmt7RKpOwJ+3OcOYMYjXRRNCboIGjllWBvp+JY/a28vzI01Twm1XKDiFYEo9wAMje2L+0PwU/9Mgh+srXS29fYvai0895UvSBrF1aUX+45XjEMq4DOo4s/5b0OZASWrWMCTwYA2DddjUlVv7/Tqw6XGGwP3EWY3gYsqsdA/M0q7PM9wEQEkoBtuAG5igF2ueSp1Og45zhtKnOimkcENtVlSI4nmclkRG5FuKTuG1gBGBx59Gy82S5rcgWemnhar/dpqEehw4sdPrKEEs8xwdlEeYr9tRMo/sfenA9nGF0zjGeRPamjhcWW49smn3l7MdbOmJz9cWWYo03iKaWcUV0Agm/mzy19ihDzvc2MEpni5QeqQp38PoEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(30864003)(2616005)(6486002)(6666004)(6512007)(6506007)(966005)(478600001)(83380400001)(26005)(66556008)(66946007)(4001150100001)(5660300002)(2906002)(54906003)(41300700001)(66476007)(316002)(6916009)(8936002)(4326008)(8676002)(36756003)(38100700002)(86362001)(82960400001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1oRCtnczJiVFduSWpDUkcrVTZqM3VRNzl3ZldIQUhJdFJwRkFLNnJDc0ZP?=
 =?utf-8?B?WkhBbVhZTEpGcHNEREkvQ0tWTGYzNjk5aUxjeHpTTHBZamhyZEhMdi8wV0wx?=
 =?utf-8?B?WG1KYTJvVit3SlVyQ3dUU1FpaEYzUjBEUU9QcExJNTJxMXloa2VrSFpPQzB6?=
 =?utf-8?B?eVBvVVZaWEhVNW5LWm8rV1pGcmNEQlN3RzI5QjZ0bW5HSnFYbnBKOFRjTnlt?=
 =?utf-8?B?TUwyUFE2UVo4bWdzcUdyclVoZWJGeEowbWlKL2d0YVJWNzBoUnhBSHFnd2Rz?=
 =?utf-8?B?YkVFZ2N1T1ZuMHBVaHc4Q2hWTGZ6c3NTNnFaRlBaeG13QkRtMzFPdXZMUDVw?=
 =?utf-8?B?TTB6WGw2a09xekh6Q09hcnVaVTZ1K0ZXYzJxdkY2eG9rcjFVdmk1eDFHL2lK?=
 =?utf-8?B?S2x4ZktVT2lJSzdhaWFlcGRwbG83Tm1wTjEwSTZMZk5LNjVDSFNobUprOWpn?=
 =?utf-8?B?ZnJKNWZuUXBSemw5SHovUmRLa0JvdENOU3ZoNEtjN1BJb0cvUUlObVFRVDVE?=
 =?utf-8?B?aml6SWxXQlJob0Fvd1dWOWNwUkhGSGFoSDEyNDJsMHZQRm1oekNHZW9HN2Rj?=
 =?utf-8?B?OUxhVG5WQS9qeXRGVU5RRWhyVnB4bXlBcURPRzBoN0d6VEhWRUszWTlob29D?=
 =?utf-8?B?LzNYR3FlTndvSUlVQ25KQXJsY09kUEJqM2RXdVArWE1yaDF0ZkdEWTFjNnZB?=
 =?utf-8?B?Q0o1RlVHRnExMkpWWDgvWjMvK2dDTzRJTGZXNWlpRXZqTmloQ0R0UlFKdTln?=
 =?utf-8?B?THBOWk8zK3ZqRnZmb0JTeHRzbjZSTzRkVFcyaVpLLzJPUEZobnVrQzFLZjRV?=
 =?utf-8?B?QVYwY0hLam9nQmoraHJkVnVlakJJbTdLd1FIUDloZTltUFhsSDRJbG1EMTg2?=
 =?utf-8?B?N3VmODZ0NDlISldqOXRINS9IaFlPNGFVWW9kTDIvOEx5VTJpNFgrOGEzcHhv?=
 =?utf-8?B?T2pQMDM5QU4yTzJZbW5VZUc0NmRuMysxNjh3bUFUS2RNVlFJc0twdmNDRGNa?=
 =?utf-8?B?N0ZrVkdDMzd1WVdsRXRRa09RVVhqTnpUL285dmhQUlpSWXNRbC9LbmVRb2lo?=
 =?utf-8?B?SEdoaVZUTExUMnJuVFFJVEM5SDJxSk1MM2REcWFSNis5ZElBWDVIY3Nkc3hQ?=
 =?utf-8?B?UFR5dWUwUlgwVUh6bjZFaUtUWU54SmtYNWVNVUFsTnhuK0YyeUVWOEZqMmhi?=
 =?utf-8?B?d25FUkloSHdaWGJnZER4WGtqNHlRcHRJeU5ocVVFOW5PK0NZVjZ0Z3lEMDNk?=
 =?utf-8?B?NENUcFo3UGZ6d051R3EwMUsyM2o2OVArc0thN0s3SjF4SlVkelFsQU53T0Z1?=
 =?utf-8?B?Q1BFdmo0VzdySzFDV3RxdFc3VUxpbFBTR2tad0tTMzY2ZS81SjJ1UDViTUhL?=
 =?utf-8?B?MFV2Mk5PRi9MYmd4eVlrd216NFBHZTJ2K2hTZDRIU3JKUDdLNUw2NExFQkNp?=
 =?utf-8?B?R2FRN21FaGhQUnpHQ2NVenVOQ0FWTHM2YUdjWFBzeEhzTDBVUzJXSWJDVDM4?=
 =?utf-8?B?NFIxSmVXcDlhL05mVWlacmJMb09VMDRwZWRxY3NwVWxaTjRZaWFWdFRsa0JO?=
 =?utf-8?B?dk13Vis2MTBHR0J3aWdQQmhnS29iS3NMQmdmWXB3VFA0MmFYRXFDRlpPYm9s?=
 =?utf-8?B?WXVSSjBzRGpJWWh4TEJ4TVVZUkphSGNkbDRXaEpWRk5VaFluZzNYd2grSnF6?=
 =?utf-8?B?cFZPK3M4eVFqVm5yTHlYS3hudWRqZVI5dy9aTG1GN1E2Y0o1RTNRVElEWWRl?=
 =?utf-8?B?Q0ZYK3pzT29FTmE2eEdFc1duMHRDN2FLcHpndXVwb1E4Z0pvOHM2T05RdjlV?=
 =?utf-8?B?Q3hVc0VrTnhSWDU3anQ0QU9lem8xL1FweWZVZlZhR3plTDlKVjVOcU90VWRE?=
 =?utf-8?B?N1lOVXNCL2d5VkpBWGFXWnJEcjRFcDYxZHBEcVNRSkRoZExOQVRRNjVlQUwy?=
 =?utf-8?B?RVV1UXRDZXA3dVpEUURlSmNqNktxOFhJK2czK3Z6NDhscERHR0cra0xYNGZu?=
 =?utf-8?B?czg3T0tiNDFBNG5XUGtTbEZmMS84c2d4WHZmSmQxTklOWTNQS3MyandUMmhB?=
 =?utf-8?B?QU9GQXFwSnRkQ1BvR3kxUm1oK1pxYmZnbGZreVJMdTJUZ3pRZUlTcFk5MWkw?=
 =?utf-8?B?bGpHUDl6akdMdlZ1bmZaVVRESFR3b1Uza29XRjJtNmZxWndLM2dtbUFHeE1Y?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abdc3d36-a207-4d04-63ad-08dbdee617a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 16:33:22.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7lKZ5BorfmuMSeMs5Nd361Mgzkp2mE4lRvgf8bVZkMbjawfnYz1s/veUJU4JpBDOKePl1yUXNLErRvn0LXvakmlAcOhhsusir1YT+ePdIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, I have this in my inbox:

From: Kernel Test Robot <lkp@intel.com>
Date: Tue, 17 Oct 2023 08:14:51 +0800

> tree:   https://github.com/alobakin/linux pfcp
> head:   9183a3eb639912169a3d3e2be4f25556b465919b
> commit: c8a652cdcc0964510f108726b3da0784d1bc0cd2 [11/19] bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()

So it happened after I converted bitmap_{get,set}_value8() so that they
use bitmap_{read,write}().

> config: x86_64-randconfig-004-20231017 (https://download.01.org/0day-ci/archive/20231017/202310170708.fJzLlgDM-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310170708.fJzLlgDM-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310170708.fJzLlgDM-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/cpumask.h:12,
>                     from arch/x86/include/asm/cpumask.h:5,
>                     from arch/x86/include/asm/msr.h:11,
>                     from arch/x86/include/asm/processor.h:23,
>                     from arch/x86/include/asm/cpufeature.h:5,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:60,
>                     from arch/x86/include/asm/preempt.h:9,
>                     from include/linux/preempt.h:79,
>                     from include/linux/spinlock.h:56,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:7,
>                     from include/linux/slab.h:16,
>                     from include/linux/resource_ext.h:11,
>                     from include/linux/acpi.h:13,
>                     from drivers/gpio/gpio-pca953x.c:11:
>    drivers/gpio/gpio-pca953x.c: In function 'pca953x_probe':
>>> include/linux/bitmap.h:642:17: warning: array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]' [-Warray-bounds]
>      642 |  map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
>          |                 ^~
>    In file included from include/linux/kasan-checks.h:5,
>                     from include/asm-generic/rwonce.h:26,
>                     from ./arch/x86/include/generated/asm/rwonce.h:1,
>                     from include/linux/compiler.h:246,
>                     from include/linux/build_bug.h:5,
>                     from include/linux/bits.h:21,
>                     from include/linux/ioport.h:13,
>                     from include/linux/acpi.h:12,
>                     from drivers/gpio/gpio-pca953x.c:11:
>    drivers/gpio/gpio-pca953x.c:1032:17: note: while referencing 'val'
>     1032 |  DECLARE_BITMAP(val, MAX_LINE);
>          |                 ^~~
>    include/linux/types.h:11:16: note: in definition of macro 'DECLARE_BITMAP'
>       11 |  unsigned long name[BITS_TO_LONGS(bits)]
>          |                ^~~~
>    In file included from include/linux/cpumask.h:12,
>                     from arch/x86/include/asm/cpumask.h:5,
>                     from arch/x86/include/asm/msr.h:11,
>                     from arch/x86/include/asm/processor.h:23,
>                     from arch/x86/include/asm/cpufeature.h:5,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:60,
>                     from arch/x86/include/asm/preempt.h:9,
>                     from include/linux/preempt.h:79,
>                     from include/linux/spinlock.h:56,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:7,
>                     from include/linux/slab.h:16,
>                     from include/linux/resource_ext.h:11,
>                     from include/linux/acpi.h:13,
>                     from drivers/gpio/gpio-pca953x.c:11:
>>> include/linux/bitmap.h:642:17: warning: array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]' [-Warray-bounds]
>      642 |  map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
>          |                 ^~
>    In file included from include/linux/kasan-checks.h:5,
>                     from include/asm-generic/rwonce.h:26,
>                     from ./arch/x86/include/generated/asm/rwonce.h:1,
>                     from include/linux/compiler.h:246,
>                     from include/linux/build_bug.h:5,
>                     from include/linux/bits.h:21,
>                     from include/linux/ioport.h:13,
>                     from include/linux/acpi.h:12,
>                     from drivers/gpio/gpio-pca953x.c:11:
>    drivers/gpio/gpio-pca953x.c:1032:17: note: while referencing 'val'
>     1032 |  DECLARE_BITMAP(val, MAX_LINE);
>          |                 ^~~
>    include/linux/types.h:11:16: note: in definition of macro 'DECLARE_BITMAP'
>       11 |  unsigned long name[BITS_TO_LONGS(bits)]
>          |                ^~~~
>    In file included from include/linux/cpumask.h:12,
>                     from arch/x86/include/asm/cpumask.h:5,
>                     from arch/x86/include/asm/msr.h:11,
>                     from arch/x86/include/asm/processor.h:23,
>                     from arch/x86/include/asm/cpufeature.h:5,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:60,
>                     from arch/x86/include/asm/preempt.h:9,
>                     from include/linux/preempt.h:79,
>                     from include/linux/spinlock.h:56,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:7,
>                     from include/linux/slab.h:16,
>                     from include/linux/resource_ext.h:11,
>                     from include/linux/acpi.h:13,
>                     from drivers/gpio/gpio-pca953x.c:11:
>    include/linux/bitmap.h:643:17: warning: array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]' [-Warray-bounds]
>      643 |  map[index + 1] |= (value >> space);
>          |                 ^~
>    In file included from include/linux/kasan-checks.h:5,
>                     from include/asm-generic/rwonce.h:26,
>                     from ./arch/x86/include/generated/asm/rwonce.h:1,
>                     from include/linux/compiler.h:246,
>                     from include/linux/build_bug.h:5,
>                     from include/linux/bits.h:21,
>                     from include/linux/ioport.h:13,
>                     from include/linux/acpi.h:12,
>                     from drivers/gpio/gpio-pca953x.c:11:
>    drivers/gpio/gpio-pca953x.c:1032:17: note: while referencing 'val'
>     1032 |  DECLARE_BITMAP(val, MAX_LINE);
>          |                 ^~~
>    include/linux/types.h:11:16: note: in definition of macro 'DECLARE_BITMAP'
>       11 |  unsigned long name[BITS_TO_LONGS(bits)]
>          |                ^~~~
>    In file included from include/linux/cpumask.h:12,
>                     from arch/x86/include/asm/cpumask.h:5,
>                     from arch/x86/include/asm/msr.h:11,
>                     from arch/x86/include/asm/processor.h:23,
>                     from arch/x86/include/asm/cpufeature.h:5,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:60,
>                     from arch/x86/include/asm/preempt.h:9,
>                     from include/linux/preempt.h:79,
>                     from include/linux/spinlock.h:56,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:7,
>                     from include/linux/slab.h:16,
>                     from include/linux/resource_ext.h:11,
>                     from include/linux/acpi.h:13,
>                     from drivers/gpio/gpio-pca953x.c:11:
>    include/linux/bitmap.h:643:17: warning: array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]' [-Warray-bounds]
>      643 |  map[index + 1] |= (value >> space);
>          |                 ^~
>    In file included from include/linux/kasan-checks.h:5,
>                     from include/asm-generic/rwonce.h:26,
>                     from ./arch/x86/include/generated/asm/rwonce.h:1,
>                     from include/linux/compiler.h:246,
>                     from include/linux/build_bug.h:5,
>                     from include/linux/bits.h:21,
>                     from include/linux/ioport.h:13,
>                     from include/linux/acpi.h:12,
>                     from drivers/gpio/gpio-pca953x.c:11:
>    drivers/gpio/gpio-pca953x.c:1032:17: note: while referencing 'val'
>     1032 |  DECLARE_BITMAP(val, MAX_LINE);
>          |                 ^~~
>    include/linux/types.h:11:16: note: in definition of macro 'DECLARE_BITMAP'
>       11 |  unsigned long name[BITS_TO_LONGS(bits)]
>          |                ^~~~
> 
> 
> vim +642 include/linux/bitmap.h
> 
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  603  
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  604  /**
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  605   * bitmap_write - write n-bit value within a memory region
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  606   * @map: address to the bitmap memory region
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  607   * @value: value to write, clamped to nbits
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  608   * @start: bit offset of the n-bit value
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  609   * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  610   *
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  611   * bitmap_write() behaves as-if implemented as @nbits calls of __assign_bit(),
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  612   * i.e. bits beyond @nbits are ignored:
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  613   *
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  614   *   for (bit = 0; bit < nbits; bit++)
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  615   *           __assign_bit(start + bit, bitmap, val & BIT(bit));
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  616   */
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  617  static inline void bitmap_write(unsigned long *map,
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  618  				unsigned long value,
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  619  				unsigned long start, unsigned long nbits)
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  620  {
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  621  	size_t index;
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  622  	unsigned long offset;
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  623  	unsigned long space;
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  624  	unsigned long mask;
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  625  	bool fit;
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  626  
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  627  	if (unlikely(!nbits))
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  628  		return;
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  629  
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  630  	mask = BITMAP_LAST_WORD_MASK(nbits);
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  631  	value &= mask;
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  632  	offset = start % BITS_PER_LONG;
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  633  	space = BITS_PER_LONG - offset;
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  634  	fit = space >= nbits;

For that particular case, @offset is not a compile-time constant, thus
the compiler can't assume anything. @space and @fit are as well due to that.

> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  635  	index = BIT_WORD(start);
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  636  
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  637  	map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  638  	map[index] |= value << offset;
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  639  	if (fit)
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  640  		return;

...which means the compiler doesn't know whether this condition will
return from the function or not.

> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  641  
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11 @642  	map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  643  	map[index + 1] |= (value >> space);

However, it knows that the bitmap has only 1 long and indexes above 0
are not valid.

Not sure how to approach this :z It was also captured on the version you
sent 2 weeks ago, so this could've been resolved already.

> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  644  }
> c8ac468adba7fe Syed Nayyar Waris 2023-10-11  645  
> 
> :::::: The code at line 642 was first introduced by commit
> :::::: c8ac468adba7fe930ec22f392d5f127b768deccc lib/bitmap: add bitmap_{read,write}()
> 
> :::::: TO: Syed Nayyar Waris <syednwaris@gmail.com>
> :::::: CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> 

Thanks,
Olek
