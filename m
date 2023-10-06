Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1417BC04A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjJFU1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjJFU1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:27:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A0DBD;
        Fri,  6 Oct 2023 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696624042; x=1728160042;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=762SEI842j6xbeCH//ya5BUk4IDS267eVf0ZCamnIvY=;
  b=LK064biolRE9mPHyQSq+uk05arCamGu3qLdu+foIQT3ptbVJiTDhZkUx
   1LuhMR3xoETPrfXQ/u0JCMZK7gpDF4poWOLR7TAqfL2XWnBLRWO/cbaju
   fN6p2RUw1DmM97eJsxomupp+08cMsZpGjJvOs5BNPw5VPM9UAtSmcp8F4
   gdsgm/KT4dShY0DB+9CyHyIX5EuPnCH3lhnINhCr5dwxEYXk5RmWK3fde
   JihFFssAevokDahAl/2AaJGYu5H6cElWKxdakE8LYZKab4f0qheL1H5nS
   9cABmX9OzokVpjoYbXWUscddR+G9f2G8wEk7PNeS8qNXy4XEIQgn9GF+A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="2434507"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="2434507"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 13:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="926072468"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="926072468"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 13:27:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 13:27:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 13:27:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 13:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asm49euV4sxiZ6Xca+OplvhI2t/XWG2t1xIISKE/wPb1lAkqqMTyNw3WXKnrkq96XV6MoGYCrw9NOb6NNYQ/OUhbRkbnRKIwkYwlasBQwdT9M2LyJocEwZ4wpfDzeXiv6BrWHARy6Rf227jzVsADBYA/cHy222m56lBYUrvCUi/5Lr5IqSJN8bQ0LqJXMmB90uE+1F3gF4bExVFJi00+VOwunLNnwz3Ln0eLrLVmvTliaKoqr3itQGSa8CziLGjX6Oh8fRWWiXUjX8YwAla6gAriYvZUJHhiQjIa2E3O3tYcXXEkLDgcFexEvM3fr3Ff3HmgL/1U/Jh5vm/PmPiVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKjxy4PEeywYOFtHgBBl6jsabNPI6ZvtZhbOORXijD0=;
 b=jq6gZBHgOCCZ7XWsQhgtvQzIJ+f/b/YWKU+FDKLUFFYGO1NulzFfd77akfMgk0QJhnnAObjfmqMJBr2Kg4qaEAaQQ+/qaEn+PpY3vIo1JlPyFNR/hBjYmaywGRpbmOhStwKS7UAHFXzjgGJBn987Ep0hOqqZx+DBZRHEsmES09jIi/423EA91HQybKfmsEAScMqWls1tvMQpO2T7j6G0D878C2MQyeMkiiUh84Ht+Xq9YxTUR5srCGYPuzDqoNZ6x6thVMjDaQFh+ZcAR58UL/oFkTBPw6VOQViTPOpTuqOXc0UxBIIvoZxqhcRhAT/kmWe8k7rzClPoT4fZRauZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB7144.namprd11.prod.outlook.com (2603:10b6:510:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 20:27:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 20:27:18 +0000
Message-ID: <de071fb6-116e-4650-8d8a-8474ed361c55@intel.com>
Date:   Fri, 6 Oct 2023 13:27:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] Add support for Sub-NUMA cluster (SNC) systems
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230928191350.205703-1-tony.luck@intel.com>
 <20231003213043.13565-1-tony.luck@intel.com>
 <TYAPR01MB6330625DB7B68BC63B4F67E38BCAA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <SJ1PR11MB6083188C577FD1067B6F7362FCCAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083188C577FD1067B6F7362FCCAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d692f1b-3c03-41ef-4519-08dbc6aaa31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nymXShHhOVqRmk84mpvWMX4NKE6sETZH8o4ywRFzbzaCyUGF/wcH6Gjn42X1Qs/SXFbuZ1mgcFrhuei4X4REY13YmsV890kxztZiWoIaEY89LS3QoE7uPrULGAwiW0AI704BrNQGeE3Nf8uL0y0x3550DsE6SVR1uy/0gfzZyO6lO1IxDqGZtlaQlTu5xIScTG7FGj6zmtpLCqGdOkrQvliPM/um3jx5u1fs/8mOGwCdOoBe9PJ/YLUS8LDYjdMWK/TbaFutIzPecVI7i5tmMXBIY5bm17kvxPud1T5ye6+s/YQQpXGgIYlOmC57TrGB7qX7y7QJ+pp7tNc4WatHZR7QfApJw3a2bDw78i+RTvoV0Ilsiul13tOL5zTpYKALWEfytyFIJxbC/TPhr8WlYC4eABV/poZ0XjlUt2DQBtHtL5oZA3N9EFgsKgVaPoi9zXYfZKd4teX9nzWkgly3Skl0fwulreHBO3FydaBXUqcSmgm9y5THGsLA8e6mu2oe4Ft52AzgXfq80VomvJahdqArx49RWpQ7GIlGEBCptN8RA8oVZlcpGwV1lV3A4jA7y2rRXWMaAptq7YtH6OpkPZqptFBPRfzToAzjP8zQ6H5nHfgvTMd4fa/xrK7p81UyTcLkfJivQfceJ9RzTotX/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82960400001)(6666004)(5660300002)(26005)(8676002)(8936002)(4326008)(31686004)(478600001)(86362001)(2616005)(31696002)(6486002)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(110136005)(2906002)(7416002)(6512007)(4744005)(6506007)(83380400001)(36756003)(41300700001)(53546011)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZSQjlOcEF1cmpwK1NGUVJvTHdFankrN1RLWVNkeWhSandMcHZGeWVXSFJP?=
 =?utf-8?B?SkluMG5kNkFnRzBnUGk3SkFnb0RDWC9RZ0xUSzFhaWxlRkNQWGdPQ2pzYnpt?=
 =?utf-8?B?L0N3OXNzNHZhbzM0R1JKQytGZzdseXhhNDluRmVQMVR3SkVzeXZ2cmVtc0Zm?=
 =?utf-8?B?NXd1REw3R01vSFJsU3BZaXNKZjRBVmwvUzl0SkpBSXk5bVNpZDlieDM3SDB5?=
 =?utf-8?B?cS9abGEwZVhnQW1tY0lRWTBpSHMzSFluWVd6OVk0ZjJ0dUNML1NIWTBQSldk?=
 =?utf-8?B?a0MyeTdVVDJ1ZVFqUzBOTGRieTBiYTJuV1lWalZ1QlZlNXVQeE11bVFJM3A5?=
 =?utf-8?B?K1kzN2pqL0NkcHpnSTZLVXhqMFE3Y2pFTnVWeWY4bmpQQUYvRVBSMTZMVVI1?=
 =?utf-8?B?ck4wM3hTZ2lzZEdKVTN2VE5ZN3FoN0h2a2FqRHUxazRzSGFTY1lrM2lqYnRi?=
 =?utf-8?B?T0pCdkNCRFNWWkswZElxcXR2TnZ2UEhkb2xlQWNqRlZGSUdacWNxRU5FUEoy?=
 =?utf-8?B?ajY1N1gwc01waGwyZURsNmFRMHB3Wk1RTmRjY241Q1E0bHZ0ZVQ1NTlDWFlI?=
 =?utf-8?B?cFFWYmQ2UzhZZGl5dmtPUFpOczJCMkc2TEliR21UNk1OdGkzQUVFWFN4STZS?=
 =?utf-8?B?aUZueVZBS1l1dVhOYlRRditwdTV6ZW45cjdBcmVnRG5GbnArcGVONzVSR1BE?=
 =?utf-8?B?aWJjYWV5OG1UZVkvOVg2UGs5TmYzWHNrUlRtbmJneUhucXNQOEJ4Z3hrWFdx?=
 =?utf-8?B?dU1PRmJQZzlmb2xKZ1NrNTgxcHY1QTZrOTNaVkU5WlZpUmlhL0lDaVI3VS9Z?=
 =?utf-8?B?a3kxTnR0MXMwMmYzL0JTbTZsZ3lyOHQ4T3RRTU1JeldIYjFSV1Z5dlNrYjU4?=
 =?utf-8?B?SHhLL3I5Um1YNU1lamFNL2Q2L1ZrVUMzUVBjNVptQzFUVjVvOEhYc3c2dDNj?=
 =?utf-8?B?VlZYNlRqRFh2WCtES1FhZE1FVUNsSURuWWpHejVudHc0K3k0YUd6NndWekUr?=
 =?utf-8?B?TlNQTC92UTZhWkEzaWl5YlgxNWh0ZXl2QkFZWEJzWVVOQVZxL2xhY2ZmOE9F?=
 =?utf-8?B?M3A3MUpTQnRiM3pZWWxCWW42Z0dEYmpmOXcrNDRuUDQwWkhzTlYwZ3RzZFp0?=
 =?utf-8?B?M3hScm1NNkJEQysvUU43YTN1M05LNXphNGtvWit1Uk11eWJHdkkzMDJ5QTF6?=
 =?utf-8?B?WGtsdTNSdEhjUGI2TXJNK2dSNTlORU1CV2J1djFrUzlnOVNpMlUwWGpGNTFB?=
 =?utf-8?B?SnN5TzZSb1o4cjh1dUZDcXV4Sk9pT3ZJSE92MFFzcEMwalc3NXlZQjRwVDN1?=
 =?utf-8?B?T2VlOTBCYUFyMXBsWXB0MURiOTFScTlTcUxJamRvN3ZYQlhzbG9CR1F1a3ZK?=
 =?utf-8?B?OW9aN1RMSndpRmJyV1hHQkc1cTU4eDB6VmZQSXZqT1NzRktJaTg0cnh0N05G?=
 =?utf-8?B?Z2R4WWd1SERVR1lkYTQvRG9BWU9Ra1Joa0ZybEV6aU5xREYvTGVzdWI5S0po?=
 =?utf-8?B?WFp5aitRN292OGpzZXN0VDFXK3UxNmNjT2hwQVFHOER0UzJyYWpQWi9kQkUr?=
 =?utf-8?B?WEJ6L25pTVF1NEorc1VIWmozdE5SZmlaM2dQRUdSb3VobXdJaXU2YlpaQUxx?=
 =?utf-8?B?VGhlTDd0aWFvVkZrUVgvN1B2Vm9JS0ZFbmEvWkZobUJyYklDazcra3lrYnN4?=
 =?utf-8?B?b2pJVnQvMUQ4K1A0ZkJ1c2MwK2dQNzVvLzUzQUhvL0RyWlZXQ2FGTm9mS2tX?=
 =?utf-8?B?RFhJYzlwRWtNNk5rOHRuTEo1cTV5aTM5Z1RFbml0ZXI1c2hVdWpDZnkxYlR3?=
 =?utf-8?B?dUp0RXFibkxKWkVUcWcyblJESWJTQjFMMlZ4azJSOVpTS3FBb0FoQ2ZqNm5s?=
 =?utf-8?B?VVJpTUdpcS84KzVlR2xJNkNVWUlWVlcxZHhJYUtxWVVDb2FhWmljNHBoUGUy?=
 =?utf-8?B?ZzlMcFBaL1dldkJraWxVVHowTTJXMW1ZbitIbW5QYUdTbjA2bUExU0tUcW9M?=
 =?utf-8?B?U0VIM09EZ0dVS05QWktaV1ZqNzI0Y2tXc0hYRXR4bm5sVDJjaEtYbWhoQjVF?=
 =?utf-8?B?dVZndDlsRHoyZkxIVkFhMExEU0VKc2lHWXlCaVZ0TlM5RmV2NHBIdVZpWG9z?=
 =?utf-8?B?VWRFRlFqdzJmczBoeTQ4UEZEUjFrZjFxUDF3M0hHS0tBOHdHZFlZeG5Cc1Uw?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d692f1b-3c03-41ef-4519-08dbc6aaa31e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 20:27:18.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yI7h29pD2KUxG7gneUhMZRwzPQ9wosyWERHcmo0OEN7bX1ehn5IRguInmaPdxB9SCYbsMGTZz3e/scxV1zth5z87epEj+dGWHRAVJpmqk+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7144
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/5/2023 8:08 AM, Luck, Tony wrote:
>> I applied this patch series to kernel v6.5 and v6.6-rc4, but the kernel cannot be booted.
>> Could you tell me what kernel version this patch series is based on?
> 
> Hi Shaopeng,
> 
> Patches are based on v6.6-rc3 (see the "base-commit" line at the end of the cover letter).
> 
> Which CPU family/model/stepping & microcode are you testing on?
> 
> Are there error or panic messages when it does not boot?

There is no need to ask Shaopeng for more information. If you test
this series you will immediately learn that it is broken. 
Reading the series I only made it to patch #3 where I realized that this
has not been tested before posting. 

Reinette

